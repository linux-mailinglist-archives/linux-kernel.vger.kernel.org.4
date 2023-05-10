Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166406FD3CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 04:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjEJCVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 22:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjEJCVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 22:21:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EED118;
        Tue,  9 May 2023 19:21:50 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QGJZn11flzpVD4;
        Wed, 10 May 2023 10:17:37 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 10:21:47 +0800
From:   Dong Chenchen <dongchenchen2@huawei.com>
To:     <edumazet@google.com>
CC:     <davem@davemloft.net>, <dongchenchen2@huawei.com>,
        <jbenc@redhat.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <simon.horman@corigine.com>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
Subject: Re: [PATCH net, v3] net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()
Date:   Wed, 10 May 2023 10:21:46 +0800
Message-ID: <20230510022146.610613-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iJRe1-EXa8soRORCKSkQG+mK1MNYfR8B=VPbCrSJ5NpOA@mail.gmail.com>
References: <CANn89iJRe1-EXa8soRORCKSkQG+mK1MNYfR8B=VPbCrSJ5NpOA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > As the call trace shows, skb_panic was caused by wrong skb->mac_header
> > in nsh_gso_segment():
> >
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> > CPU: 3 PID: 2737 Comm: syz Not tainted 6.3.0-next-20230505 #1
> > RIP: 0010:skb_panic+0xda/0xe0
> > call Trace:
> >  skb_push+0x91/0xa0
> >  nsh_gso_segment+0x4f3/0x570
> >  skb_mac_gso_segment+0x19e/0x270
> >  __skb_gso_segment+0x1e8/0x3c0
> >  validate_xmit_skb+0x452/0x890
> >  validate_xmit_skb_list+0x99/0xd0
> >  sch_direct_xmit+0x294/0x7c0
> >  __dev_queue_xmit+0x16f0/0x1d70
> >  packet_xmit+0x185/0x210
> >  packet_snd+0xc15/0x1170
> >  packet_sendmsg+0x7b/0xa0
> >  sock_sendmsg+0x14f/0x160
> >
> > The root cause is:
> > nsh_gso_segment() use skb->network_header - nhoff to reset mac_header
> > in skb_gso_error_unwind() if inner-layer protocol gso fails.
> > However, skb->network_header may be reset by inner-layer protocol
> > gso function e.g. mpls_gso_segment. skb->mac_header reset by the
> > inaccurate network_header will be larger than skb headroom.
> >
> > nsh_gso_segment
> >     nhoff = skb->network_header - skb->mac_header;
> >     __skb_pull(skb,nsh_len)
> >     skb_mac_gso_segment
> >         mpls_gso_segment
> >             skb_reset_network_header(skb);//skb->network_header+=nsh_len
> >             return -EINVAL;
> >     skb_gso_error_unwind
> >         skb_push(skb, nsh_len);
> >         skb->mac_header = skb->network_header - nhoff;
> >         // skb->mac_header > skb->headroom, cause skb_push panic
> >
> > Use correct mac_offset to restore mac_header to fix it.
> >
> > Fixes: c411ed854584 ("nsh: add GSO support")
> > Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> >
> > ---
> > v2:
> >   - Use skb->mac_header not skb->network_header-nhoff for mac_offset.
> >
> > v3:
> >   - 'net' is noted in the subject.
> >   - arrange local variable following reverse xmas tree order
> > ---
> >  net/nsh/nsh.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
> > index e9ca007718b7..793e0bd94558 100644
> > --- a/net/nsh/nsh.c
> > +++ b/net/nsh/nsh.c
> > @@ -77,6 +77,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
> >                                        netdev_features_t features)
> >  {
> >         struct sk_buff *segs = ERR_PTR(-EINVAL);
> > +       u16 mac_offset = skb->mac_header;
> >         unsigned int nsh_len, mac_len;
> >         __be16 proto;
> >         int nhoff;
> > @@ -108,8 +109,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
> >         segs = skb_mac_gso_segment(skb, features);
> >         if (IS_ERR_OR_NULL(segs)) {
> >                 skb_gso_error_unwind(skb, htons(ETH_P_NSH), nsh_len,
> > -                                    skb->network_header - nhoff,
> > -                                    mac_len);
> > +                                    mac_offset, mac_len);
> >                 goto out;
> >         }
> >
> 
> I do not think this patch is enough ?
> 
> This is still not nice, because mac_header == 0xFFFF
> 
> nhoff = skb->network_header - skb->mac_header;
> ...
> skb_set_mac_header(skb, -nhoff);
> 
> I would simply restore mac_header with "skb->mac_header =  mac_offset"
> and get rid of nhoff.
> 
> (Accept the fact that GSO layer should not rely on skb mac_header being set)
> 
> In the future, we might be able to rewrite GSO without any assumptions
> on skb->mac_header.

Thank you very much for your suggestions!
I will revise it in v4.

Dong Chenchen

