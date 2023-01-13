Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F239668E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbjAMGzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbjAMGyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:54:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96866F956
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IFdwGnSodtMT979TfMD1yoQI2c7b6/jQ8MRYDII/3hA=; b=Lt436Q2BAmQ8bVisc0xgnbQCp+
        eWD0B48NGLCHG8a1S56TqSvnTAZp4FCRze0zgDYiqeTENVDHDEyX18PHlneDgf4PvgijD9suTFYK8
        trx5c1eASb6neBPv4DSZUl/nOm0EHfKh4GupWjEkiNZaxxci5ouHwNVvGn/4F/QRhTxTB6FdkeArl
        xKx+2tV/AlTl6RLU3JB2JoXm+hekWQQcAHapf3wPWxxiMlHyztIZXaVp+9vSMCSUn5VIhwIB7M3qF
        d7oi+XLYMXYUWL5J8KjLkZLdOm5EJx6vwpM4WS798Xa0lWZ1hAStpY3DrkpVxTBHSiJ8qViFvloAT
        xFkoSowA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDiY-000qRn-ET; Fri, 13 Jan 2023 06:39:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] misc: genwqe: move intervening macros away from kernel-doc
Date:   Thu, 12 Jan 2023 22:39:09 -0800
Message-Id: <20230113063909.19694-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't separate a function's kernel-doc comment and its definition with
macros or data; move the macro and data ahead of the function and its
comments to prevent a warning:

drivers/misc/genwqe/card_utils.c:162: warning: expecting prototype for genwqe_init_crc32(). Prototype was for CRC32_POLYNOMIAL() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/genwqe/card_utils.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -151,6 +151,9 @@ int genwqe_read_app_id(struct genwqe_dev
 	return i;
 }
 
+#define CRC32_POLYNOMIAL	0x20044009
+static u32 crc32_tab[256];	/* crc32 lookup table */
+
 /**
  * genwqe_init_crc32() - Prepare a lookup table for fast crc32 calculations
  *
@@ -159,9 +162,6 @@ int genwqe_read_app_id(struct genwqe_dev
  *
  * Genwqe's Polynomial = 0x20044009
  */
-#define CRC32_POLYNOMIAL	0x20044009
-static u32 crc32_tab[256];	/* crc32 lookup table */
-
 void genwqe_init_crc32(void)
 {
 	int i, j;
