Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CA66D7424
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjDEGIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbjDEGIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:08:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A1B2D6D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:07:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eh3so138328608edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680674875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BHxYcSmsdjoKvPYhhFPBgDYaSzif9TBy2RIlw+xR3w=;
        b=ThEh6HAPISb2wLc9Sx4yFvAueYbPTH0h77e0SlM0Z/x3obM29K4FVfmghpQ/SMyyvL
         r9pobgWAxb+4z26PnPCW+YFcnhKkf4LB+TJP8BnbWfzCuDg7CQE+gM5Q9xuRtabb6esz
         AdWu1CKHw4BdiBdDvF9uBYoYA8lZqMjNIfoHJphDzTIpZxQWquJZWiLJJqM++4PkvvFg
         r6huZENycnBrrLBvhPU4fkbF+pAvBKfYNNr2vMaUWp3qMxziZ82zCy2EoDkSiBLevXcn
         NOr3EYp8xBf+JyM59aWHpKYyQbcnGMLJtpbgN1ejyKFxRSvT/Lzs2GDR1De508S2Ywso
         Nthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680674875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BHxYcSmsdjoKvPYhhFPBgDYaSzif9TBy2RIlw+xR3w=;
        b=QSSI9ulV3TCWKG0kEZT7rn34ndt9M24Sfd+RtCiEI+Au73+1eC/1B5Eh2rIzIb8nqs
         6rn1/KtOx42TiYaPdbiDtKguNn8gQeQfuNZmW4KYXGAcP0xZJy88rlZS0Z60tKQZys97
         o9HPpPxXzEodYfdzwwHRLR6BxFcRlampj7HtZNlRAtdWEvOL2UnlnlYDdK+M+vcvMOqQ
         N++jnMH350+AyKV/vTZfhsXnWEYZJkKqR7S/Z84mxv6GI0RBPkp1hhsR++ufdFjH3/pR
         SVrTEWK3/MHs10cGnrtxcXa766/43e7GG60/E6lmrmZRKIQTHk1lA6zCTMpJ6d2n+rEW
         gqIA==
X-Gm-Message-State: AAQBX9eKhMJz9iFGEvktKSJCRuLxVWgzW9iE/8ma+UirPLUs2GLxf633
        A3Yf+8svV6pOWGSuI+iab+At2g==
X-Google-Smtp-Source: AKy350aXu3R3xsZi/r0NAlh78FPuXCC/tpxJGrVt1VjeZ/eTbD+yktSuM4gqIcQlNgYSAmoxYMUjsQ==
X-Received: by 2002:a17:906:9be0:b0:945:5510:2b9f with SMTP id de32-20020a1709069be000b0094555102b9fmr2106467ejc.54.1680674875179;
        Tue, 04 Apr 2023 23:07:55 -0700 (PDT)
Received: from 1.. ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id k26-20020a1709062a5a00b009331450d04esm7019747eje.178.2023.04.04.23.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:07:54 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, Takahiro.Kuwano@infineon.com,
        pratyush@kernel.org, michael@walle.cc
Cc:     bacem.daassi@infineon.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mtd: spi-nor: Allow post_sfdp hook to return errors
Date:   Wed,  5 Apr 2023 09:07:51 +0300
Message-Id: <20230405060751.49056-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4909; i=tudor.ambarus@linaro.org; h=from:subject; bh=C7xAwS3xNT+nbz1gYj7adnaTZ3v1W+GxPhefMM7+lHM=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkLRA36CpucueVT640rYvuimhI/+AWkhRH1jOqh Ajx6QYUJyeJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZC0QNwAKCRBLVU9HpY0U 6TlWB/wNMDlRKpoLkoAQnGe+b4UDyXMumrV6zV/yKycxjjviTal6z5Bw6pZksVK07xjhdGLIXv9 Fh0EK4rz95UWZE92r122A4thhoaBk2Y2A4z3k6QNNODs88rmvgkmJ0vovdl7SMkwb51jA8hm+KA tG3wMivExk0wIJ8KwncG99YLNmbbev0qxBh5XnCcm0o8CIkxNkF1adza0LXSa724EPrE2KpbZX3 PrYRIUmLx7yG/dxjHiFjjYOnTEg0YdJxOALxl/OEHz4U/1dWl6YUx8/0hcn/P4pkwt7Wf3DKiNo wmfzjh2Mgd6vOLMOPiVQco3aBQOjf+X4LRW4iC0VCDcRgzft
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi die flashes like s25hl02gt need to determine the page_size at
run-time by querying a configuration register for each die. Since the
number of dice is determined in an optional SFDP table, SCCR MC, the
page size configuration must be done in the post_sfdp hook. Allow
post_sfdp to return errors, as reading the configuration register might
return errors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.h      |  2 +-
 drivers/mtd/spi-nor/micron-st.c |  4 +++-
 drivers/mtd/spi-nor/sfdp.c      | 10 ++++++----
 drivers/mtd/spi-nor/spansion.c  | 12 +++++++++---
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 8cfa82ed06c7..a9e5e091547d 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -426,7 +426,7 @@ struct spi_nor_fixups {
 	int (*post_bfpt)(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt);
-	void (*post_sfdp)(struct spi_nor *nor);
+	int (*post_sfdp)(struct spi_nor *nor);
 	void (*late_init)(struct spi_nor *nor);
 };
 
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index a6f080112a51..4b919756a205 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -131,7 +131,7 @@ static void mt35xu512aba_default_init(struct spi_nor *nor)
 	nor->params->octal_dtr_enable = micron_st_nor_octal_dtr_enable;
 }
 
-static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
+static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
 {
 	/* Set the Fast Read settings. */
 	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
@@ -149,6 +149,8 @@ static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
 	 * disable it.
 	 */
 	nor->params->quad_enable = NULL;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups mt35xu512aba_fixups = {
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 69e47c9778a2..e501686a6dc3 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1260,14 +1260,16 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
  * Used to tweak various flash parameters when information provided by the SFDP
  * tables are wrong.
  */
-static void spi_nor_post_sfdp_fixups(struct spi_nor *nor)
+static int spi_nor_post_sfdp_fixups(struct spi_nor *nor)
 {
 	if (nor->manufacturer && nor->manufacturer->fixups &&
 	    nor->manufacturer->fixups->post_sfdp)
-		nor->manufacturer->fixups->post_sfdp(nor);
+		return nor->manufacturer->fixups->post_sfdp(nor);
 
 	if (nor->info->fixups && nor->info->fixups->post_sfdp)
-		nor->info->fixups->post_sfdp(nor);
+		return nor->info->fixups->post_sfdp(nor);
+
+	return 0;
 }
 
 /**
@@ -1477,7 +1479,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
 		}
 	}
 
-	spi_nor_post_sfdp_fixups(nor);
+	err = spi_nor_post_sfdp_fixups(nor);
 exit:
 	kfree(param_headers);
 	return err;
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index c937f0ac61de..519fdad79a19 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -370,7 +370,7 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 	return cypress_nor_get_page_size(nor);
 }
 
-static void s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
+static int s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
@@ -379,6 +379,8 @@ static void s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
 	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
 				SPINOR_OP_PP_1_1_4_4B,
 				SNOR_PROTO_1_1_4);
+
+	return 0;
 }
 
 static void s25fs256t_late_init(struct spi_nor *nor)
@@ -409,7 +411,7 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 	return cypress_nor_get_page_size(nor);
 }
 
-static void s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
+static int s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 {
 	struct spi_nor_erase_type *erase_type =
 					nor->params->erase_map.erase_type;
@@ -431,6 +433,8 @@ static void s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 			break;
 		}
 	}
+
+	return 0;
 }
 
 static void s25hx_t_late_init(struct spi_nor *nor)
@@ -463,7 +467,7 @@ static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 			cypress_nor_octal_dtr_dis(nor);
 }
 
-static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
+static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
 {
 	/*
 	 * On older versions of the flash the xSPI Profile 1.0 table has the
@@ -489,6 +493,8 @@ static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
 	 * actual value for that is 4.
 	 */
 	nor->params->rdsr_addr_nbytes = 4;
+
+	return 0;
 }
 
 static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
-- 
2.34.1

