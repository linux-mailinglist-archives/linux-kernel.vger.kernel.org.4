Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5277C6FBD0C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjEICTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEICTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:19:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4818C1BFF;
        Mon,  8 May 2023 19:19:30 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QFhZ416LSzTkRy;
        Tue,  9 May 2023 10:14:52 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 10:19:27 +0800
From:   Dong Chenchen <dongchenchen2@huawei.com>
To:     <edumazet@google.com>, <kuba@kernel.org>, <davem@davemloft.net>,
        <pabeni@redhat.com>
CC:     <jbenc@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
        <weiyongjun1@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH next, v2] net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()
Date:   Tue, 9 May 2023 10:19:24 +0800
Message-ID: <20230509021924.554576-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

As the call trace shows, skb_panic was caused by wrong skb->mac_header
in nsh_gso_segment():

invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 3 PID: 2737 Comm: syz Not tainted 6.3.0-next-20230505 #1
RIP: 0010:skb_panic+0xda/0xe0
call Trace:
 skb_push+0x91/0xa0
 nsh_gso_segment+0x4f3/0x570
 skb_mac_gso_segment+0x19e/0x270
 __skb_gso_segment+0x1e8/0x3c0
 validate_xmit_skb+0x452/0x890
 validate_xmit_skb_list+0x99/0xd0
 sch_direct_xmit+0x294/0x7c0
 __dev_queue_xmit+0x16f0/0x1d70
 packet_xmit+0x185/0x210
 packet_snd+0xc15/0x1170
 packet_sendmsg+0x7b/0xa0
 sock_sendmsg+0x14f/0x160

The root cause is:
nsh_gso_segment() use skb->network_header - nhoff to reset mac_header
in skb_gso_error_unwind() if inner-layer protocol gso fails.
However, skb->network_header may be reset by inner-layer protocol
gso function e.g. mpls_gso_segment. skb->mac_header reset by the
inaccurate network_header will be larger than skb headroom.

nsh_gso_segment
    nhoff = skb->network_header - skb->mac_header;
    __skb_pull(skb,nsh_len)
    skb_mac_gso_segment
        mpls_gso_segment
            skb_reset_network_header(skb);//skb->network_header+=nsh_len
            return -EINVAL;
    skb_gso_error_unwind
        skb_push(skb, nsh_len);
        skb->mac_header = skb->network_header - nhoff;
        // skb->mac_header > skb->headroom, cause skb_push panic

Use correct mac_offset to restore mac_header to fix it.

Fixes: c411ed854584 ("nsh: add GSO support")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
v2:
  - Use skb->mac_header not skb->network_header-nhoff for mac_offset.
---
 net/nsh/nsh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index e9ca007718b7..7eb536a9677f 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -78,6 +78,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 {
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	unsigned int nsh_len, mac_len;
+	u16 mac_offset = skb->mac_header;
 	__be16 proto;
 	int nhoff;
 
@@ -108,8 +109,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 	segs = skb_mac_gso_segment(skb, features);
 	if (IS_ERR_OR_NULL(segs)) {
 		skb_gso_error_unwind(skb, htons(ETH_P_NSH), nsh_len,
-				     skb->network_header - nhoff,
-				     mac_len);
+				     mac_offset, mac_len);
 		goto out;
 	}
 
-- 
2.25.1

