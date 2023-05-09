Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67436FD0E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjEIVVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjEIVUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664205FF7;
        Tue,  9 May 2023 14:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A05506372C;
        Tue,  9 May 2023 21:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA4DC433D2;
        Tue,  9 May 2023 21:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667199;
        bh=aeVE82GOAm+8/pi+l38V8m9CkT3EyRdDIYsSw5VqQw8=;
        h=From:To:Cc:Subject:Date:From;
        b=f0PgD+WRAg67UJgSqpMa/C+hOpQM/OanHPvF1xYPUYU/DwvR3TZS+SMH4luIBZGP2
         JSIHCitVhm+1bjYewJb9PDfGyGgkGWwbyQx9gXkzN6p6CuflfNyYXCW5GXUtzjD63j
         QgprtgXFoCu55/kyvt1YdcqUU2o1gJWCBWGOYcAV+KiNOCcO7Ar72W+tZmF7AM9t4B
         9Ug5dzfmUy6R22Duxjpttj/4sZdff0qgriqGhn0rbbkOkSateVnFueZl81rFmUC0jO
         nd7nfGyKFqCsEL1uLyBEDa7/zFqi1aNf15boTDQxDCMGTcv3oKSjsdxmmUzVtz4ajd
         KJq1cBQApnQ4Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>, nathan@kernel.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        mcgrof@kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.2 01/18] RDMA/core: Fix multiple -Warray-bounds warnings
Date:   Tue,  9 May 2023 17:19:39 -0400
Message-Id: <20230509211958.21596-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit aa4d540b4150052ae3b36d286b9c833a961ce291 ]

GCC-13 (and Clang)[1] does not like to access a partially allocated
object, since it cannot reason about it for bounds checking.

In this case 140 bytes are allocated for an object of type struct
ib_umad_packet:

        packet = kzalloc(sizeof(*packet) + IB_MGMT_RMPP_HDR, GFP_KERNEL);

However, notice that sizeof(*packet) is only 104 bytes:

struct ib_umad_packet {
        struct ib_mad_send_buf *   msg;                  /*     0     8 */
        struct ib_mad_recv_wc *    recv_wc;              /*     8     8 */
        struct list_head           list;                 /*    16    16 */
        int                        length;               /*    32     4 */

        /* XXX 4 bytes hole, try to pack */

        struct ib_user_mad         mad __attribute__((__aligned__(8))); /*    40    64 */

        /* size: 104, cachelines: 2, members: 5 */
        /* sum members: 100, holes: 1, sum holes: 4 */
        /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

and 36 bytes extra bytes are allocated for a flexible-array member in
struct ib_user_mad:

include/rdma/ib_mad.h:
120 enum {
...
123         IB_MGMT_RMPP_HDR = 36,
... }

struct ib_user_mad {
        struct ib_user_mad_hdr     hdr;                  /*     0    64 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        __u64                      data[] __attribute__((__aligned__(8))); /*    64     0 */

        /* size: 64, cachelines: 1, members: 2 */
        /* forced alignments: 1 */
} __attribute__((__aligned__(8)));

So we have sizeof(*packet) + IB_MGMT_RMPP_HDR == 140 bytes

Then the address of the flex-array member (for which only 36 bytes were
allocated) is casted and copied into a pointer to struct ib_rmpp_mad,
which, in turn, is of size 256 bytes:

        rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;

struct ib_rmpp_mad {
        struct ib_mad_hdr          mad_hdr;              /*     0    24 */
        struct ib_rmpp_hdr         rmpp_hdr;             /*    24    12 */
        u8                         data[220];            /*    36   220 */

        /* size: 256, cachelines: 4, members: 3 */
};

The thing is that those 36 bytes allocated for flex-array member data
in struct ib_user_mad onlly account for the size of both struct ib_mad_hdr
and struct ib_rmpp_hdr, but nothing is left for array u8 data[220].
So, the compiler is legitimately complaining about accessing an object
for which not enough memory was allocated.

Apparently, the only members of struct ib_rmpp_mad that are relevant
(that are actually being used) in function ib_umad_write() are mad_hdr
and rmpp_hdr. So, instead of casting packet->mad.data to
(struct ib_rmpp_mad *) create a new structure

struct ib_rmpp_mad_hdr {
        struct ib_mad_hdr       mad_hdr;
        struct ib_rmpp_hdr      rmpp_hdr;
} __packed;

and cast packet->mad.data to (struct ib_rmpp_mad_hdr *).

Notice that

        IB_MGMT_RMPP_HDR == sizeof(struct ib_rmpp_mad_hdr) == 36 bytes

Refactor the rest of the code, accordingly.

Fix the following warnings seen under GCC-13 and -Warray-bounds:
drivers/infiniband/core/user_mad.c:564:50: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]
drivers/infiniband/core/user_mad.c:566:42: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]
drivers/infiniband/core/user_mad.c:618:25: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]
drivers/infiniband/core/user_mad.c:622:44: warning: array subscript ‘struct ib_rmpp_mad[0]’ is partly outside array bounds of ‘unsigned char[140]’ [-Warray-bounds=]

Link: https://github.com/KSPP/linux/issues/273
Link: https://godbolt.org/z/oYWaGM4Yb [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/ZBpB91qQcB10m3Fw@work
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/user_mad.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index f83954180a338..d21c0a042f0a5 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -131,6 +131,11 @@ struct ib_umad_packet {
 	struct ib_user_mad mad;
 };
 
+struct ib_rmpp_mad_hdr {
+	struct ib_mad_hdr	mad_hdr;
+	struct ib_rmpp_hdr      rmpp_hdr;
+} __packed;
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/ib_umad.h>
 
@@ -494,11 +499,11 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 			     size_t count, loff_t *pos)
 {
 	struct ib_umad_file *file = filp->private_data;
+	struct ib_rmpp_mad_hdr *rmpp_mad_hdr;
 	struct ib_umad_packet *packet;
 	struct ib_mad_agent *agent;
 	struct rdma_ah_attr ah_attr;
 	struct ib_ah *ah;
-	struct ib_rmpp_mad *rmpp_mad;
 	__be64 *tid;
 	int ret, data_len, hdr_len, copy_offset, rmpp_active;
 	u8 base_version;
@@ -506,7 +511,7 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 	if (count < hdr_size(file) + IB_MGMT_RMPP_HDR)
 		return -EINVAL;
 
-	packet = kzalloc(sizeof *packet + IB_MGMT_RMPP_HDR, GFP_KERNEL);
+	packet = kzalloc(sizeof(*packet) + IB_MGMT_RMPP_HDR, GFP_KERNEL);
 	if (!packet)
 		return -ENOMEM;
 
@@ -560,13 +565,13 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 		goto err_up;
 	}
 
-	rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;
-	hdr_len = ib_get_mad_data_offset(rmpp_mad->mad_hdr.mgmt_class);
+	rmpp_mad_hdr = (struct ib_rmpp_mad_hdr *)packet->mad.data;
+	hdr_len = ib_get_mad_data_offset(rmpp_mad_hdr->mad_hdr.mgmt_class);
 
-	if (ib_is_mad_class_rmpp(rmpp_mad->mad_hdr.mgmt_class)
+	if (ib_is_mad_class_rmpp(rmpp_mad_hdr->mad_hdr.mgmt_class)
 	    && ib_mad_kernel_rmpp_agent(agent)) {
 		copy_offset = IB_MGMT_RMPP_HDR;
-		rmpp_active = ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
+		rmpp_active = ib_get_rmpp_flags(&rmpp_mad_hdr->rmpp_hdr) &
 						IB_MGMT_RMPP_FLAG_ACTIVE;
 	} else {
 		copy_offset = IB_MGMT_MAD_HDR;
@@ -615,12 +620,12 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 		tid = &((struct ib_mad_hdr *) packet->msg->mad)->tid;
 		*tid = cpu_to_be64(((u64) agent->hi_tid) << 32 |
 				   (be64_to_cpup(tid) & 0xffffffff));
-		rmpp_mad->mad_hdr.tid = *tid;
+		rmpp_mad_hdr->mad_hdr.tid = *tid;
 	}
 
 	if (!ib_mad_kernel_rmpp_agent(agent)
-	   && ib_is_mad_class_rmpp(rmpp_mad->mad_hdr.mgmt_class)
-	   && (ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE)) {
+	    && ib_is_mad_class_rmpp(rmpp_mad_hdr->mad_hdr.mgmt_class)
+	    && (ib_get_rmpp_flags(&rmpp_mad_hdr->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE)) {
 		spin_lock_irq(&file->send_lock);
 		list_add_tail(&packet->list, &file->send_list);
 		spin_unlock_irq(&file->send_lock);
-- 
2.39.2

