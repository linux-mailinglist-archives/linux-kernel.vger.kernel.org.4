Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF06731458
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbjFOJpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbjFOJpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:45:38 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E199D106
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:45:34 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 105245FD08;
        Thu, 15 Jun 2023 12:45:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686822332;
        bh=KY8MsO4bvb628kL7iIp0YQE4xIOo6DSZxFqLJtgyE0I=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=AcKOxgiKjiRGDox0dPZtopcpG8f8bbEUyZ2TkO5SQMdEOOR5vn+HahTx/Er2EWxWO
         8JJmBfwgVYwwZhdA2SX1O5FIr4nQc3GAKqCNPNkr1h/hf0jvON2NWcywfN1Qv3os1+
         uSRHhhW+8TMhlPF7L4/+nl7vpqQ2DbFtqSzRW/L0UBBav6NoNZSZsfyEWLPkxcI4gN
         ZuQzo8SDm+wEWtQTrsidHapGGG3qQVw3TpQo6qtujWyrqmBPFeDziq30lh5KpwlQJ0
         oZ3HkWiKsY7ICtxzSN+4fEKQphTGLLCjvZWLJowKLzY83fLvWSFxPNXnKlWZxIQ6ot
         eN95uXtZ0+NOQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 15 Jun 2023 12:45:28 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh@kernel.org>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jaime Liao <jaimeliao.tw@gmail.com>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
Date:   Thu, 15 Jun 2023 12:40:06 +0300
Message-ID: <20230615094015.3780078-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/15 07:01:00 #21506969
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for OTP area access on MX30LFxG18AC chip series.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
  v1 -> v2:
  * Add slab.h include due to kernel test robot error.
  v2 -> v3:
  * Use 'uint64_t' as input argument for 'do_div()' instead
    of 'unsigned long' due to kernel test robot error.
  v3 -> v4:
  * Use 'dev_err()' instead of 'WARN()'.
  * Call 'match_string()' before checking 'supports_set_get_features'
    in 'macronix_nand_setup_otp().
  * Use 'u8' instead of 'uint8_t' as ./checkpatch.pl wants.
  v4 -> v5:
  * OTP lock logic is disabled. Change locking callback to return
    -EOPNOTSUPP. See comment 'macronix_30lfxg18ac_get_otp_info()'
    for details.
  * OTP factory callbacks are removed. Only user region is supported.
  * Temporary DMA buffer in RW function is removed. There is no need
    in it.

 drivers/mtd/nand/raw/nand_macronix.c | 167 +++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 385957eb6762..e229de32ff50 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -6,6 +6,7 @@
  * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
  */
 
+#include <linux/slab.h>
 #include "linux/delay.h"
 #include "internals.h"
 
@@ -31,6 +32,16 @@
 
 #define MXIC_CMD_POWER_DOWN 0xB9
 
+#define ONFI_FEATURE_ADDR_30LFXG18AC_OTP	0x90
+#define MACRONIX_30LFXG18AC_OTP_START_PAGE	2
+#define MACRONIX_30LFXG18AC_OTP_PAGES		30
+#define MACRONIX_30LFXG18AC_OTP_PAGE_SIZE	2112
+#define MACRONIX_30LFXG18AC_OTP_SIZE_BYTES	\
+	(MACRONIX_30LFXG18AC_OTP_PAGES *	\
+	 MACRONIX_30LFXG18AC_OTP_PAGE_SIZE)
+
+#define MACRONIX_30LFXG18AC_OTP_EN		BIT(0)
+
 struct nand_onfi_vendor_macronix {
 	u8 reserved;
 	u8 reliability_func;
@@ -315,6 +326,161 @@ static void macronix_nand_deep_power_down_support(struct nand_chip *chip)
 	chip->ops.resume = mxic_nand_resume;
 }
 
+static int macronix_30lfxg18ac_get_otp_info(struct mtd_info *mtd, size_t len,
+					    size_t *retlen,
+					    struct otp_info *buf)
+{
+	if (len < sizeof(*buf))
+		return -EINVAL;
+
+	/* Always report that OTP is unlocked. Reason is that this
+	 * type of flash chip doesn't provide way to check that OTP
+	 * is locked or not: subfeature parameter is implemented as
+	 * volatile register. Technically OTP region could be locked
+	 * and become readonly, but as there is no way to check it,
+	 * don't allow to lock it ('_lock_user_prot_reg' callback
+	 * always returns -EOPNOTSUPP) and thus we report that OTP
+	 * is unlocked.
+	 */
+	buf->locked = 0;
+	buf->start = 0;
+	buf->length = MACRONIX_30LFXG18AC_OTP_SIZE_BYTES;
+
+	*retlen = sizeof(*buf);
+
+	return 0;
+}
+
+static int macronix_30lfxg18ac_otp_enable(struct nand_chip *nand)
+{
+	u8 feature_buf[ONFI_SUBFEATURE_PARAM_LEN] = { 0 };
+
+	feature_buf[0] = MACRONIX_30LFXG18AC_OTP_EN;
+	return nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
+				 feature_buf);
+}
+
+static int macronix_30lfxg18ac_otp_disable(struct nand_chip *nand)
+{
+	u8 feature_buf[ONFI_SUBFEATURE_PARAM_LEN] = { 0 };
+
+	return nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
+				 feature_buf);
+}
+
+static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
+					loff_t offs_in_flash,
+					size_t len, size_t *retlen,
+					u_char *buf, bool write)
+{
+	struct nand_chip *nand;
+	size_t bytes_handled;
+	off_t offs_in_page;
+	u64 page;
+	int ret;
+
+	nand = mtd_to_nand(mtd);
+	nand_select_target(nand, 0);
+
+	ret = macronix_30lfxg18ac_otp_enable(nand);
+	if (ret)
+		goto out_otp;
+
+	page = offs_in_flash;
+	/* 'page' will be result of division. */
+	offs_in_page = do_div(page, MACRONIX_30LFXG18AC_OTP_PAGE_SIZE);
+	bytes_handled = 0;
+
+	while (bytes_handled < len &&
+	       page < MACRONIX_30LFXG18AC_OTP_PAGES) {
+		size_t bytes_to_handle;
+		u64 phys_page = page + MACRONIX_30LFXG18AC_OTP_START_PAGE;
+
+		bytes_to_handle = min_t(size_t, len - bytes_handled,
+					MACRONIX_30LFXG18AC_OTP_PAGE_SIZE -
+					offs_in_page);
+
+		if (write)
+			ret = nand_prog_page_op(nand, phys_page, offs_in_page,
+						&buf[bytes_handled], bytes_to_handle);
+		else
+			ret = nand_read_page_op(nand, phys_page, offs_in_page,
+						&buf[bytes_handled], bytes_to_handle);
+		if (ret)
+			goto out_otp;
+
+		bytes_handled += bytes_to_handle;
+		offs_in_page = 0;
+		page++;
+	}
+
+	*retlen = bytes_handled;
+
+out_otp:
+	if (ret)
+		dev_err(&mtd->dev, "failed to perform OTP IO: %i\n", ret);
+
+	ret = macronix_30lfxg18ac_otp_disable(nand);
+	if (ret)
+		dev_err(&mtd->dev, "failed to leave OTP mode after %s\n",
+			write ? "write" : "read");
+
+	nand_deselect_target(nand);
+
+	return ret;
+}
+
+static int macronix_30lfxg18ac_write_otp(struct mtd_info *mtd, loff_t to,
+					 size_t len, size_t *rlen,
+					 const u_char *buf)
+{
+	return __macronix_30lfxg18ac_rw_otp(mtd, to, len, rlen, (u_char *)buf,
+					    true);
+}
+
+static int macronix_30lfxg18ac_read_otp(struct mtd_info *mtd, loff_t from,
+					size_t len, size_t *rlen,
+					u_char *buf)
+{
+	return __macronix_30lfxg18ac_rw_otp(mtd, from, len, rlen, buf, false);
+}
+
+static int macronix_30lfxg18ac_lock_otp(struct mtd_info *mtd, loff_t from,
+					size_t len)
+{
+	/* See comment in 'macronix_30lfxg18ac_get_otp_info()'. */
+	return -EOPNOTSUPP;
+}
+
+static void macronix_nand_setup_otp(struct nand_chip *chip)
+{
+	static const char * const supported_otp_models[] = {
+		"MX30LF1G18AC",
+		"MX30LF2G18AC",
+		"MX30LF4G18AC",
+	};
+	struct mtd_info *mtd;
+
+	if (match_string(supported_otp_models,
+			 ARRAY_SIZE(supported_otp_models),
+			 chip->parameters.model) < 0)
+		return;
+
+	if (!chip->parameters.supports_set_get_features)
+		return;
+
+	bitmap_set(chip->parameters.get_feature_list,
+		   ONFI_FEATURE_ADDR_30LFXG18AC_OTP, 1);
+	bitmap_set(chip->parameters.set_feature_list,
+		   ONFI_FEATURE_ADDR_30LFXG18AC_OTP, 1);
+
+	mtd = nand_to_mtd(chip);
+	mtd->_get_user_prot_info = macronix_30lfxg18ac_get_otp_info;
+	mtd->_read_user_prot_reg = macronix_30lfxg18ac_read_otp;
+	mtd->_write_user_prot_reg = macronix_30lfxg18ac_write_otp;
+	mtd->_lock_user_prot_reg = macronix_30lfxg18ac_lock_otp;
+}
+
 static int macronix_nand_init(struct nand_chip *chip)
 {
 	if (nand_is_slc(chip))
@@ -324,6 +490,7 @@ static int macronix_nand_init(struct nand_chip *chip)
 	macronix_nand_onfi_init(chip);
 	macronix_nand_block_protection_support(chip);
 	macronix_nand_deep_power_down_support(chip);
+	macronix_nand_setup_otp(chip);
 
 	return 0;
 }
-- 
2.35.0

