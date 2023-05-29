Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF764714CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjE2PXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjE2PXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:23:10 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD155D2;
        Mon, 29 May 2023 08:23:06 -0700 (PDT)
Received: from pride-poweredge-r740.. ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 34TFLoKa032373-34TFLoKd032373
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 May 2023 23:21:55 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: move the sanity checks before variable dereferences
Date:   Mon, 29 May 2023 23:21:30 +0800
Message-Id: <20230529152136.11719-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:

sh_css_load_firmware() warn: variable dereferenced before check 'fw_data'

The variable fw_data can be NULL in sh_css_load_firmware, resulting in
NULL pointer dereference.

Fix this by moving the sanity checks before variable dereferences.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/staging/media/atomisp/pci/sh_css_firmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_firmware.c b/drivers/staging/media/atomisp/pci/sh_css_firmware.c
index e7ef578db8ab..38b757c3df0a 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_firmware.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_firmware.c
@@ -229,6 +229,10 @@ sh_css_load_firmware(struct device *dev, const char *fw_data,
 	struct sh_css_fw_bi_file_h *file_header;
 	int ret;
 
+	/* some sanity checks */
+	if (!fw_data || fw_size < sizeof(struct sh_css_fw_bi_file_h))
+		return -EINVAL;
+
 	firmware_header = (struct firmware_header *)fw_data;
 	file_header = &firmware_header->file_header;
 	binaries = &firmware_header->binary_header;
@@ -243,10 +247,6 @@ sh_css_load_firmware(struct device *dev, const char *fw_data,
 		IA_CSS_LOG("successfully load firmware version %s", release_version);
 	}
 
-	/* some sanity checks */
-	if (!fw_data || fw_size < sizeof(struct sh_css_fw_bi_file_h))
-		return -EINVAL;
-
 	if (file_header->h_size != sizeof(struct sh_css_fw_bi_file_h))
 		return -EINVAL;
 
-- 
2.34.1

