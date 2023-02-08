Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0502069B15F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjBQQts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBQQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:49:42 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9B647432
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:49:41 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id u22so1206954qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxSHhRIK7JTZXIncFXbe4DygtHjDqgxwQ1O7fQr99v0=;
        b=bBK72SGShYHBhmybaEy8D9ycdnj8d7RbBzWnHqRYNa4M/J05pj2MkeQs4cb5SNlWj3
         HhS3EDcgw8lfHB6RseBMCMU/5BoM6yic6xDlcMOCdZBgE5SNqmNXGoHi/cjovVZVRwXM
         n7KobkwZNwnLIyqlLasDtXjoKaCInWmsSC0wR4P+iXrynxEb67CvXEMytWkhKp5y6vk9
         vxdzqn8/xD1+KlGBVgYIB/OBOMWyAjnpIiDNVz8uGSvuEmN9C2hE1gjOpUs5s/goqlnK
         VqrEH1h4A9YX+C+r7TksxAjUMK6/6n6epokDVoqTxj3xUU+ahD360N3wvmUoltlnkgl4
         nLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxSHhRIK7JTZXIncFXbe4DygtHjDqgxwQ1O7fQr99v0=;
        b=IB5bshVDyyJYfvMqEcpUQqk+vS4zT/T18gwxwbveHyoSksQUeni2LQnJx9WRFAKNUJ
         BUVHCiDBf0lwSHC7uCKlOu8t1e62+5xYzQubShlsj0DJqlmjkfhDgisBtsMMyyPdmyo/
         6T84zhso9dLz6FmQ5f8WUlmoZNXWCYbDGXhBLrvwBR4hqgYvrhWNQrohU88jelciS1wi
         AnDaEboLHMck+czPdmGQRnd3ZYvquNIxSFoCFcQsl0PrumSlbMZgpsv9emjFDahIyVdI
         BoZ+sFju3DGQ9sDNT7Ypl3tA7TWm0qbDsnvmv1HhBhhmSfqxcHNpscrDV4kITNKvcf3j
         zVqg==
X-Gm-Message-State: AO0yUKXSxWS1C53hN0tDrjFpuZPcrFVnDLZkLZRaUBy/uViUszIwj5LW
        0x8kXrRGSgC19DT3b1gGCdmaQEwaOOWxa47U
X-Google-Smtp-Source: AK7set8T0nLgI/dXlquKcJR73ymSYdmJVlsR5ZpdeUQCG52DFge9IebeJgeUGpwqCppsiMxFcJW3NA==
X-Received: by 2002:ac8:5784:0:b0:3b9:bc8c:c204 with SMTP id v4-20020ac85784000000b003b9bc8cc204mr11198556qta.15.1676652580626;
        Fri, 17 Feb 2023 08:49:40 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b68-20020a37b247000000b0073980414888sm3569161qkf.42.2023.02.17.08.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 08:49:40 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 2/6] gpio: 104-dio-48e: Utilize no_status regmap-irq flag
Date:   Wed,  8 Feb 2023 12:18:17 -0500
Message-Id: <0feb25265128808d4487c49238fdd9f3ca3bb725.1675876659.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675876659.git.william.gray@linaro.org>
References: <cover.1675876659.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 104-DIO-48E lacks an IRQ status register. Rather than use the Clear
Interrupt register as the status register, set the no_status flag to
true and thus avoid such a hack.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-dio-48e.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index a3846faf3780..fe3c93bfe4bd 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -195,13 +195,9 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return -ENOMEM;
 
 	chip->name = name;
-	/* No IRQ status register so use CLEAR_INTERRUPT register instead */
-	chip->status_base = DIO48E_CLEAR_INTERRUPT;
 	chip->mask_base = DIO48E_ENABLE_INTERRUPT;
 	chip->ack_base = DIO48E_CLEAR_INTERRUPT;
-	/* CLEAR_INTERRUPT doubles as status register so we need it cleared */
-	chip->clear_ack = true;
-	chip->status_invert = true;
+	chip->no_status = true;
 	chip->num_regs = 1;
 	chip->irqs = dio48e_regmap_irqs;
 	chip->num_irqs = ARRAY_SIZE(dio48e_regmap_irqs);
-- 
2.39.1

