Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C870D5A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjEWHqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbjEWHqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37131FE;
        Tue, 23 May 2023 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Eu+sHAbT3uL1Wlvtp9WjhkkqaQjxNO1P/0ao1isrLAA=; b=NLtDskm42LkDp116geKStjw9Sr
        P54dR5zjSNzpgEBIVmAwKXGDbzdhvM+1zrDFcObmO98Q2hhWk7Y7KANk9srHE2BxXH6hCFiN3o7LG
        ofsgKrtUtW7H5s857nXF7vQ5LytkoBuDe24KvFpVmKrbltiYU/jxPD4ratQcWzi3rR0sdArIBkTRb
        VrGIXLx/ZXFOl52+gjy3CvCpWYTwXOsUn0EiHjlyPcK/dnlWoGMN6mcNlHe0ciJTXBaQ9nSM04Rqt
        1Ns7xL/l5Z9F9XENaroMlNrkgwK/A8Ynbfu91djSNnH3fIhMYc9e3BnrRMjvIKpcujZ12b8n98niq
        bfdHrO/Q==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1MiN-009GXt-1X;
        Tue, 23 May 2023 07:45:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 05/24] init: remove pointless Root_* values
Date:   Tue, 23 May 2023 09:45:16 +0200
Message-Id: <20230523074535.249802-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523074535.249802-1-hch@lst.de>
References: <20230523074535.249802-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all unused defines, and just use the expanded versions for
the scsi disk majors.

I've decided to keep Root_RAM0 even if it could be expanded as there
is a lot of special casing for it in the init code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/kernel/setup.c               | 2 +-
 arch/ia64/kernel/setup.c                | 2 +-
 arch/powerpc/platforms/powermac/setup.c | 3 ++-
 include/linux/root_dev.h                | 8 --------
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 33bf3a62700270..b650ff1cb022ee 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -658,7 +658,7 @@ setup_arch(char **cmdline_p)
 #endif
 
 	/* Default root filesystem to sda2.  */
-	ROOT_DEV = Root_SDA2;
+	ROOT_DEV = MKDEV(SCSI_DISK0_MAJOR, 2);
 
 #ifdef CONFIG_EISA
 	/* FIXME:  only set this when we actually have EISA in this box? */
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index c0572804427275..becdb4f33c2195 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -627,7 +627,7 @@ setup_arch (char **cmdline_p)
 	 * is physical disk 1 partition 1 and the Linux root disk is
 	 * physical disk 1 partition 2.
 	 */
-	ROOT_DEV = Root_SDA2;		/* default to second partition on first drive */
+	ROOT_DEV = MKDEV(SCSI_DISK0_MAJOR, 2);
 
 	if (is_uv_system())
 		uv_setup(cmdline_p);
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 193cc9c394221b..0c41f4b005bcf3 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -76,7 +76,8 @@ int pmac_newworld;
 
 static int current_root_goodness = -1;
 
-#define DEFAULT_ROOT_DEVICE Root_SDA1	/* sda1 - slightly silly choice */
+/* sda1 - slightly silly choice */
+#define DEFAULT_ROOT_DEVICE	MKDEV(SCSI_DISK0_MAJOR, 1)
 
 sys_ctrler_t sys_ctrler = SYS_CTRLER_UNKNOWN;
 EXPORT_SYMBOL(sys_ctrler);
diff --git a/include/linux/root_dev.h b/include/linux/root_dev.h
index 4e78651371ba92..ed3ea8da642972 100644
--- a/include/linux/root_dev.h
+++ b/include/linux/root_dev.h
@@ -10,14 +10,6 @@ enum {
 	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),
 	Root_CIFS = MKDEV(UNNAMED_MAJOR, 254),
 	Root_RAM0 = MKDEV(RAMDISK_MAJOR, 0),
-	Root_RAM1 = MKDEV(RAMDISK_MAJOR, 1),
-	Root_FD0 = MKDEV(FLOPPY_MAJOR, 0),
-	Root_HDA1 = MKDEV(IDE0_MAJOR, 1),
-	Root_HDA2 = MKDEV(IDE0_MAJOR, 2),
-	Root_SDA1 = MKDEV(SCSI_DISK0_MAJOR, 1),
-	Root_SDA2 = MKDEV(SCSI_DISK0_MAJOR, 2),
-	Root_HDC1 = MKDEV(IDE1_MAJOR, 1),
-	Root_SR0 = MKDEV(SCSI_CDROM_MAJOR, 0),
 };
 
 extern dev_t ROOT_DEV;
-- 
2.39.2

