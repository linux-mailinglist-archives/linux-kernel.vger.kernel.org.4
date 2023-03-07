Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DC26AF957
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCGWrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCGWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:07 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6842A7288;
        Tue,  7 Mar 2023 14:47:01 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 09CF57A06FE;
        Tue,  7 Mar 2023 23:46:49 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/32] parport_pc: add 16-bit and 8-bit fast EPP transfer flags
Date:   Tue,  7 Mar 2023 23:46:06 +0100
Message-Id: <20230307224627.28011-12-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
References: <20230307224627.28011-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PARPORT_EPP_FAST flag currently uses 32-bit I/O port access for data
read/write (insl/outsl).
Add PARPORT_EPP_FAST_16 and PARPORT_EPP_FAST_8 that use insw/outsw
and insb/outsb (and PARPORT_EPP_FAST_32 as alias for PARPORT_EPP_FAST).

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/parport/parport_pc.c | 20 ++++++++++++++++----
 include/uapi/linux/parport.h |  3 +++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 5784dc20fb38..eda4e4e6d4e8 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -298,9 +298,15 @@ static size_t parport_pc_epp_read_data(struct parport *port, void *buf,
 		}
 		return got;
 	}
-	if ((flags & PARPORT_EPP_FAST) && (length > 1)) {
-		if (!(((long)buf | length) & 0x03))
+	if ((length > 1) && ((flags & PARPORT_EPP_FAST_32)
+			   || flags & PARPORT_EPP_FAST_16
+			   || flags & PARPORT_EPP_FAST_8)) {
+		if ((flags & PARPORT_EPP_FAST_32)
+		    && !(((long)buf | length) & 0x03))
 			insl(EPPDATA(port), buf, (length >> 2));
+		else if ((flags & PARPORT_EPP_FAST_16)
+			 && !(((long)buf | length) & 0x01))
+			insw(EPPDATA(port), buf, length >> 1);
 		else
 			insb(EPPDATA(port), buf, length);
 		if (inb(STATUS(port)) & 0x01) {
@@ -327,9 +333,15 @@ static size_t parport_pc_epp_write_data(struct parport *port, const void *buf,
 {
 	size_t written = 0;
 
-	if ((flags & PARPORT_EPP_FAST) && (length > 1)) {
-		if (!(((long)buf | length) & 0x03))
+	if ((length > 1) && ((flags & PARPORT_EPP_FAST_32)
+			   || flags & PARPORT_EPP_FAST_16
+			   || flags & PARPORT_EPP_FAST_8)) {
+		if ((flags & PARPORT_EPP_FAST_32)
+		    && !(((long)buf | length) & 0x03))
 			outsl(EPPDATA(port), buf, (length >> 2));
+		else if ((flags & PARPORT_EPP_FAST_16)
+			 && !(((long)buf | length) & 0x01))
+			outsw(EPPDATA(port), buf, length >> 1);
 		else
 			outsb(EPPDATA(port), buf, length);
 		if (inb(STATUS(port)) & 0x01) {
diff --git a/include/uapi/linux/parport.h b/include/uapi/linux/parport.h
index f41388f88dc3..fe93e41fc205 100644
--- a/include/uapi/linux/parport.h
+++ b/include/uapi/linux/parport.h
@@ -90,6 +90,9 @@ typedef enum {
 /* Flags for block transfer operations. */
 #define PARPORT_EPP_FAST		(1<<0) /* Unreliable counts. */
 #define PARPORT_W91284PIC		(1<<1) /* have a Warp9 w91284pic in the device */
+#define PARPORT_EPP_FAST_32		PARPORT_EPP_FAST /* 32-bit EPP transfers */
+#define PARPORT_EPP_FAST_16		(1<<2) /* 16-bit EPP transfers */
+#define PARPORT_EPP_FAST_8		(1<<3) /* 8-bit EPP transfers */
 
 /* The rest is for the kernel only */
 #endif /* _UAPI_PARPORT_H_ */
-- 
Ondrej Zary

