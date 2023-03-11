Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5326B5F5C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCKRsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCKRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:48:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C46F1EFC8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:48:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i34so33066572eda.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6QRvqIPqhwfkaL7qJCNUGtwyaLEhOy0ZykrT/r18uU=;
        b=QeP5/OREzJ0okWd4ne26O5OThHlQ61jbPXKceQebMd+FzFwy88vrkLlInfEgcqOmuf
         V4mGZUmCZ0mItv7FHMjNGnRhfq3n0nOUsj+ESMM+oUUJipCHohdwW6J8wN12mY6W62g8
         SVM7NJun8s6hqPMcOvPqQLAL2ayR54Bey4zqbQ1H+ahk57U7zJ/ZKa5P0YcR3VEfYz8C
         N8R8qDcyXapXAlYya6ZW99h/UmCECCJtPQRK28YwHmO34+ilO9pGp5Bj6P6Pyfa1tDUr
         2ZDD8VpUmhQfhwatuwQ3COAn86wh5So0BV/f2yTA93Q9G6ed9yUQP4ryxlp6NXVrHJpw
         M6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6QRvqIPqhwfkaL7qJCNUGtwyaLEhOy0ZykrT/r18uU=;
        b=2bdtJRQMacwwRISgfHFOngPhKAFrlwWBRXJH4GcisDiCCFc5/LVrNgrR3i7chIVVZS
         il1quFqdq1ADfWFjNR7Z1JQcDbZaySTXWD3OhjAsT1pq+gtNCkEbpRgjRjcvp/28w9PQ
         mAXBcP1D8h1ZkwWdKUoV/vj9wK5MRNYII0tw6xYrURYIoHcFt+YXa8Pm71ywTqYDe1sK
         OOKDkdBUQcI4E34qv8w+R0aoiwA/CwtNBjTaCRU9Zy3d+hx7mH3/pwQU20+qlbO8ctkL
         7r2A2AfJSYrZYg4JW3sNG84Gdk4JRRlM0ATFa5nZ+SEzaNHtlYM3e+6Pjan7HF0qdgqe
         SgSg==
X-Gm-Message-State: AO0yUKUyshve7LY+urs7wksKENwhv9V0bM3XyX/KLoUDwmgFAgYkChIy
        MhpIexzGyNxKXZ0iSWVrETDsOSL2xehm5p5l0gk=
X-Google-Smtp-Source: AK7set8G/4BR94DteJ8al719zG2ZLW4GhFbY4KlxWdeiielUMmGVUrP1PmeO8ZDcbEXIIrdlTQcCAA==
X-Received: by 2002:a17:907:c22:b0:919:7f81:22a8 with SMTP id ga34-20020a1709070c2200b009197f8122a8mr6980742ejc.24.1678556144183;
        Sat, 11 Mar 2023 09:35:44 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906b00c00b008c76facbbf7sm1311364ejy.171.2023.03.11.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:35:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] tpm: tpm_tis_spi: Mark ACPI and OF related data as maybe unused
Date:   Sat, 11 Mar 2023 18:35:41 +0100
Message-Id: <20230311173541.262949-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173541.262949-1-krzysztof.kozlowski@linaro.org>
References: <20230311173541.262949-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
unused:

  drivers/char/tpm/tpm_tis_spi_main.c:234:34: error: ‘of_tis_spi_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..1f5207974a17 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -231,7 +231,7 @@ static const struct spi_device_id tpm_tis_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
 
-static const struct of_device_id of_tis_spi_match[] = {
+static const struct of_device_id of_tis_spi_match[] __maybe_unused = {
 	{ .compatible = "st,st33htpm-spi", .data = tpm_tis_spi_probe },
 	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
 	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
@@ -240,7 +240,7 @@ static const struct of_device_id of_tis_spi_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_tis_spi_match);
 
-static const struct acpi_device_id acpi_tis_spi_match[] = {
+static const struct acpi_device_id acpi_tis_spi_match[] __maybe_unused = {
 	{"SMO0768", 0},
 	{}
 };
-- 
2.34.1

