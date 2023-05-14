Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB712701CBB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbjENJqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjENJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:46:42 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 May 2023 02:46:22 PDT
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EE91FDF
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:46:22 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 30791 invoked from network); 14 May 2023 11:39:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1684057180; bh=9X4Aik96rC7qqmmYlE08FycZCCqFGLDNGNT88xeEStE=;
          h=From:To:Subject;
          b=eUjJuTeuXiTtdiQAQRm0+804WnQu0nvGYlwfsE3Yr12gCluTBDVQHs3ofLEFeDYqk
           hOINnJAmPIYXo2skqjhvvYdYeXnjwrTiw93hRjhuFKNWfnURv7BHiY9mwmXBANUI3d
           TVceNRWDaGk88xylTqIiAT/bPC9SbBkYurMp8fck=
Received: from 79.184.247.17.ipv4.supernova.orange.pl (HELO LAPTOP-OLEK.home) (olek2@wp.pl@[79.184.247.17])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <miquel.raynal@bootlin.com>; 14 May 2023 11:39:40 +0200
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        olek2@wp.pl, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: cfi_cmdset_0001: Disable write buffer functions if FORCE_WORD_WRITE is 1
Date:   Sun, 14 May 2023 11:39:35 +0200
Message-Id: <20230514093935.4679-1-olek2@wp.pl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 4044979a10be0e33303665ee941e3f2b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [QdPk]                               
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some write buffer functions are not used when FORCE_WORD_WRITE is set to 1.
So the compile warning messages are output if FORCE_WORD_WRITE is 1. To
resolve this disable the write buffer functions if FORCE_WORD_WRITE is 1.

This is similar fix to: 557c759036fc3976a5358cef23e65a263853b93f.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/mtd/chips/cfi_cmdset_0001.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 54f92d09d9cf..8f7223221db2 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -61,8 +61,10 @@
 
 static int cfi_intelext_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int cfi_intelext_write_words(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
+#if !FORCE_WORD_WRITE
 static int cfi_intelext_write_buffers(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
 static int cfi_intelext_writev(struct mtd_info *, const struct kvec *, unsigned long, loff_t, size_t *);
+#endif
 static int cfi_intelext_erase_varsize(struct mtd_info *, struct erase_info *);
 static void cfi_intelext_sync (struct mtd_info *);
 static int cfi_intelext_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
@@ -304,6 +306,7 @@ static void fixup_use_point(struct mtd_info *mtd)
 	}
 }
 
+#if !FORCE_WORD_WRITE
 static void fixup_use_write_buffers(struct mtd_info *mtd)
 {
 	struct map_info *map = mtd->priv;
@@ -314,6 +317,7 @@ static void fixup_use_write_buffers(struct mtd_info *mtd)
 		mtd->_writev = cfi_intelext_writev;
 	}
 }
+#endif /* !FORCE_WORD_WRITE */
 
 /*
  * Some chips power-up with all sectors locked by default.
@@ -1703,6 +1707,7 @@ static int cfi_intelext_write_words (struct mtd_info *mtd, loff_t to , size_t le
 }
 
 
+#if !FORCE_WORD_WRITE
 static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
 				    unsigned long adr, const struct kvec **pvec,
 				    unsigned long *pvec_seek, int len)
@@ -1931,6 +1936,7 @@ static int cfi_intelext_write_buffers (struct mtd_info *mtd, loff_t to,
 
 	return cfi_intelext_writev(mtd, &vec, 1, to, retlen);
 }
+#endif /* !FORCE_WORD_WRITE */
 
 static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
 				      unsigned long adr, int len, void *thunk)
-- 
2.30.2

