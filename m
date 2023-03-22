Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539666C4366
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCVGlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCVGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0719D5BC8D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h25so10392721lfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjibXlExvge37of3uq5kGMqBiMIjX3D2b9DBjXXdAOg=;
        b=UWFPA1O80E8Yvytt01jq2QIZlVrmn7Jcyha10uK9nvBUeZ9OymTt6B8Z9AX3M1FOVk
         FAgiDSO/jaNYlZwykZtkM6h8Br2W+Xz3Upj+p1cJ3G9NUWRYMew1DqmVVcxg5s3xhR6W
         P91VXlrP4QY4cVIZIPaw74N3GzXJs/CWhQEK6vuRWwkKRvwhFYhgMhM2OX/jvg3VuVOM
         73Z/Q0t2qS9GkaccmEy2b5NdVtlgmhAPox9KqyABqgEIl07lkYOdVCdKoQoS9014wOwR
         4MuZ77zV2HQU60wNZPhj+9F35cimJ5cg6Prcql48PgTM4ngXq9dDpTVf1swH+/8w6rq1
         YMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjibXlExvge37of3uq5kGMqBiMIjX3D2b9DBjXXdAOg=;
        b=fnQ6b6TczLlDXUSMpy+OyNu/5PhHeeeIBhl0NWaLGe4BxUjADIY2AL3iCn2hniZD7I
         348fJyqSNXtXQYPjYsi5RmLqf00oAGpkSKXEezSYaOjPoq1pyxKrpiv5auK+uyMZ5g8j
         VLiunWkoaQErpvXb0x1ZRQoEoq9wywiJ/uPSeRPzh/W1BsYID0Sfc+J7i3qfkyG6TeJc
         lLVut2O+i0o4DhqzJiZU7t9fWki58qXS0fGALGKPFoXmsX23eJhaN/KLOmCSbxkSoZ4x
         FipUKIUt50R+gbFgd9plaKmft9Vl2F9Wx6lehOJTWsSa8Z+jV1WMavqWbYdMb7Sr18nY
         RrAQ==
X-Gm-Message-State: AO0yUKUb1+oeYn/o0xpu2Tn0xMirjsBnxEuzPXwVVCSJdBqUFt3aJTlc
        NmdzFoyW/gtfJWc62g4HOheJKQ==
X-Google-Smtp-Source: AK7set8Qi0viAviwjYHM3w8QtxMrW5ArDewIDKji6YiN0pl8h2sw0lxNoFC7eh4swxgCw7JwHCrZQw==
X-Received: by 2002:ac2:43a4:0:b0:4e8:47cd:b4ba with SMTP id t4-20020ac243a4000000b004e847cdb4bamr1676972lfl.13.1679467244027;
        Tue, 21 Mar 2023 23:40:44 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020ac242d4000000b004dafde0e7b7sm2462255lfl.279.2023.03.21.23.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:40:43 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v4 09/11] mtd: spi-nor: core: Update flash's current address mode when changing address mode
Date:   Wed, 22 Mar 2023 06:40:31 +0000
Message-Id: <20230322064033.2370483-10-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
References: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bug was obswerved while reading code. There are not many users of
addr_mode_nbytes. Anyway, we should update the flash's current address
mode when changing the address mode, fix it. We don't care for now about
the set_4byte_addr_mode(nor, false) from spi_nor_restore(), as it is
used at driver remove and shutdown.

Cc: stable@vger.kernel.org
Fixes: d7931a215063 ("mtd: spi-nor: core: Track flash's internal address mode")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1cf566fed9c6..868414017399 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2769,6 +2769,7 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 
 static int spi_nor_init(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
 	int err;
 
 	err = spi_nor_octal_dtr_enable(nor, true);
@@ -2810,9 +2811,10 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		err = nor->params->set_4byte_addr_mode(nor, true);
+		err = params->set_4byte_addr_mode(nor, true);
 		if (err && err != -ENOTSUPP)
 			return err;
+		params->addr_mode_nbytes = 4;
 	}
 
 	return 0;
-- 
2.40.0.rc1.284.g88254d51c5-goog

