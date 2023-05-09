Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB56FC562
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbjEILvF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 07:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbjEILvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:51:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2138440E0;
        Tue,  9 May 2023 04:51:02 -0700 (PDT)
Received: from canpemm100009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QFxG204rgzpV7y;
        Tue,  9 May 2023 19:46:50 +0800 (CST)
Received: from kwepemi500026.china.huawei.com (7.221.188.247) by
 canpemm100009.china.huawei.com (7.192.105.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 19:51:00 +0800
Received: from kwepemi500026.china.huawei.com ([7.221.188.247]) by
 kwepemi500026.china.huawei.com ([7.221.188.247]) with mapi id 15.01.2507.023;
 Tue, 9 May 2023 19:50:59 +0800
From:   "dongchenchen (A)" <dongchenchen2@huawei.com>
To:     "simon.horman@corigine.com" <simon.horman@corigine.com>
CC:     David Miller <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "jbenc@redhat.com" <jbenc@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>,
        yuehaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH next, v2] net: nsh: Use correct mac_offset to unwind gso
 skb in nsh_gso_segment()
Thread-Topic: Re: [PATCH next, v2] net: nsh: Use correct mac_offset to unwind
 gso skb in nsh_gso_segment()
Thread-Index: AdmCa6/13xAu81DfR1qLOi3J8tOZMQ==
Date:   Tue, 9 May 2023 11:50:59 +0000
Message-ID: <772b50e4ecb24da98ae917b650891d8d@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.223]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > As the call trace shows, skb_panic was caused by wrong 
> > skb->mac_header in nsh_gso_segment():
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
> > nsh_gso_segment() use skb->network_header - nhoff to reset 
> > mac_header in skb_gso_error_unwind() if inner-layer protocol gso fails.
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
> 
> nit: As this is a fix it should probably be targeted at 'net'
>      (as opposed to 'net-next'). This should be noted in the subject.
> 
>      Subject: [PATCH net v2]...
> 
> > ---
> > v2:
> >   - Use skb->mac_header not skb->network_header-nhoff for mac_offset.
> > ---
> >  net/nsh/nsh.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c index 
> > e9ca007718b7..7eb536a9677f 100644
> > --- a/net/nsh/nsh.c
> > +++ b/net/nsh/nsh.c
> > @@ -78,6 +78,7 @@ static struct sk_buff *nsh_gso_segment(struct 
> > sk_buff *skb,  {
> >  	struct sk_buff *segs = ERR_PTR(-EINVAL);
> >  	unsigned int nsh_len, mac_len;
> > +	u16 mac_offset = skb->mac_header;
> 
> nit: It is generally preferred to arrange local variable in networking code
>      from shortest line to longest - reverse xmas tree order.
> 
>      This can be verified using.
>      https://github.com/ecree-solarflare/xmastree/blob/master/README
> 
Thank you very much for your suggestions!
v3 will be sent.

Dong Chenchen
> >  	__be16 proto;
> >  	int nhoff;
> >  
> > @@ -108,8 +109,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
> >  	segs = skb_mac_gso_segment(skb, features);
> >  	if (IS_ERR_OR_NULL(segs)) {
> >  		skb_gso_error_unwind(skb, htons(ETH_P_NSH), nsh_len,
> > -				     skb->network_header - nhoff,
> > -				     mac_len);
> > +				     mac_offset, mac_len);
> >  		goto out;
> >  	}
> >  
> > --
> > 2.25.1
> > 
> >
