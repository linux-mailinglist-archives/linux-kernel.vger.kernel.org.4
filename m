Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF46D7456
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbjDEGVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDEGVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:21:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AF330CD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:21:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so138469030ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 23:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680675670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=37wf5RuLXYQ2GF/JRvIi9hQZK8An5GQBqnLDA1j+haw=;
        b=NumasAbWAKnmvMrSOJctJghuhJaRwvPkeizYxdCkdyRjm8/UkfMrY3yywTdQE85sy0
         TOfYdAUAOnnzQE1S/anBa/0mYZHBim803Mor0NGBPr+bSdFIxrhU1uN/sGFwAsWFXte/
         lxJ8g3QDZsi6escu8A6epb9CWNAFQOtuefMiqV69XTZ2reQIc+B0fDmSi8lhEZQ/GFAQ
         apwd+VdgerRvgFZ6oIHPfhOv8TX3QB/g8NQyixrxsV+mGqIQsW7vfZ6azhzNMVsdmYFP
         xFXzL7egGz+bdOvzcneanXhNdHSi/G1GsRGVUK7byUze6lWiMDvYOqJt1meDe4+SCC6y
         h6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680675670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37wf5RuLXYQ2GF/JRvIi9hQZK8An5GQBqnLDA1j+haw=;
        b=tIYDJX5gO5JPK+pzIuIbq0QyAA+L7EVxrNLBPsC7YmJixa36Xkuw8SUVY641ZApmiz
         a85fFQDFBquxUuDE/JCcm/bK4Kjk2pl+JAPRoa+o6El/9d0QjKVqI3JagDDW1g7k13FY
         CCcNr/HVJXEptocyezbXdo2uRv/7RXFwtmFy6MbJJZ/wcCBzRsiSavPvCEYW3EZO1900
         zVy72gScobD3Zyl7V4jhUJH6KMv9BGyJNfls0Lm2UKMphzwiTamr6BV5bu7StCUWvsnn
         oPe9QWohmjuQ6Jm9Ub1wSns11IitZZB0q1tglGvz3ZvEJ3Gn21ugAFNvhKtwvdECkL8L
         4kvA==
X-Gm-Message-State: AAQBX9efM4bxSpKLuSMNPXY/sNIqfrDvYyonr0KkkhjzK7lD+iNducHD
        JBfK45Pu7Kl7FMIvK9vdsH3zsA==
X-Google-Smtp-Source: AKy350blz5Rm2OmsxD9Rv+jPxdM4Rj5Ckdz2clZmFC7ODXVH6ArfnHQfModIJlXQ4wWbSg8kJuWgQQ==
X-Received: by 2002:a17:906:144d:b0:93f:fbe:ed17 with SMTP id q13-20020a170906144d00b0093f0fbeed17mr1771352ejc.62.1680675669740;
        Tue, 04 Apr 2023 23:21:09 -0700 (PDT)
Received: from 1.. ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id h13-20020a1709063c0d00b008b176df2899sm6928978ejg.160.2023.04.04.23.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:21:09 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, Takahiro.Kuwano@infineon.com,
        pratyush@kernel.org, michael@walle.cc
Cc:     bacem.daassi@infineon.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2] mtd: spi-nor: Allow post_sfdp hook to return errors
Date:   Wed,  5 Apr 2023 09:21:06 +0300
Message-Id: <20230405062106.49594-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5149; i=tudor.ambarus@linaro.org; h=from:subject; bh=uLRlHwXswDm0+Iz8gfhM2OM4oGR74A/r+jko5VVtKzg=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkLRNSnovp0DP6aXX4UdzLh/Q6ZXe0JaFXCkjXN Db/P89QTZuJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZC0TUgAKCRBLVU9HpY0U 6WorB/4gL/5EPF9KC2mPpvKO6UcSifXGxeWLsSCUym51JOIP9TRGFc+1COrd7YZ/kMemjye/G5e f/PVnK7+w2kBj2h521hDyVCLaW6Q87yCYe9xEjxzR3z/TuwiDtDPlnk0HMeBEZpa0jW4GFm1SOc iGJFk1dSg/zoGbe78hlHFOW+OqlO3lpI8yuuQPvvhO2LnZ2AGt0GNYDEPb27k3vztWipvuVJlIA rxUwXXt47pGyOR8VIJxhEME7MIpfsUrzryDh3hkomvKqq6qsbmgLFPsxryncdnzPaYlke+BeTCH coVy97aofnBwHlCObG4kHWSSvvil7sGjQD2g4W7xodCvZHeK
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
v2: Fix own mistake in spi_nor_post_sfdp_fixups, do not exclude the info
post_sfdp call when the manufacturer post_sfdp is defined.

 drivers/mtd/spi-nor/core.h      |  2 +-
 drivers/mtd/spi-nor/micron-st.c |  4 +++-
 drivers/mtd/spi-nor/sfdp.c      | 17 ++++++++++++-----
 drivers/mtd/spi-nor/spansion.c  | 12 +++++++++---
 4 files changed, 25 insertions(+), 10 deletions(-)

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
index 69e47c9778a2..e184b67f3c9f 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1260,14 +1260,21 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
  * Used to tweak various flash parameters when information provided by the SFDP
  * tables are wrong.
  */
-static void spi_nor_post_sfdp_fixups(struct spi_nor *nor)
+static int spi_nor_post_sfdp_fixups(struct spi_nor *nor)
 {
+	int ret;
+
 	if (nor->manufacturer && nor->manufacturer->fixups &&
-	    nor->manufacturer->fixups->post_sfdp)
-		nor->manufacturer->fixups->post_sfdp(nor);
+	    nor->manufacturer->fixups->post_sfdp) {
+		ret = nor->manufacturer->fixups->post_sfdp(nor);
+		if (ret)
+			return ret;
+	}
 
 	if (nor->info->fixups && nor->info->fixups->post_sfdp)
-		nor->info->fixups->post_sfdp(nor);
+		return nor->info->fixups->post_sfdp(nor);
+
+	return 0;
 }
 
 /**
@@ -1477,7 +1484,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
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

