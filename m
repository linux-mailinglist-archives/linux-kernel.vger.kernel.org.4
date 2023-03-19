Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8216C024C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCSOOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjCSOOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:14:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98753196BE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:13:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eh3so37379499edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679235238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5P8vV5SdTC8v0eY1KGmdi5SpQmO/V0KvzXuxG5KBGwI=;
        b=eLvpMkifkBIdXQ7UetfEpMemmF379+5kf09TjY2d6rTkkpv4pDW1mMCQDGrxV2UeqB
         L9Zkmufygw4svPq9s6pFUWnRJFdd0NCbX+51vy5mJ0HHWmDIdZmS6ipebhtaY6mOBUMR
         hmGNamy0stqDW6xt9o0t+pctMP3GvmKgYWajnzQFj94SYMy8ayD+lhv7D0by3bSN0dwN
         9HxXuqqg53hJB20+esXKlhckwnC4AZAept26uMo1QXE/kP6eXVjHxOJSa83pn983O0Xd
         K9Y39t2cNChcd67fPjQUPnCnX/HDXzOB3PceXqxM5fNmKGGiIcpSB/ahkwGBtloVPTpM
         oQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679235238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P8vV5SdTC8v0eY1KGmdi5SpQmO/V0KvzXuxG5KBGwI=;
        b=sTAFwobfhk5RUfeHoBFWluAwgSXDvw5ZcB4nbjOCFWhz06kj8oYwoquurnmA7x9bmn
         X/gATLbD538a0T9DRsgbiGg43fhkIM3t/OxUoxxmSt1ZN19e492YeRD5ZAkLAKhdS8qd
         wyndpf8wt6L1EIJmpzdBG1KlTeWicmjunAHg7LHgez46p3ugeRU7Om3sxduzCZlgOVun
         w2pfiLTcHnJ9TMZ77E+zBFFyRT+VsSaiC3H03KiyHcDXlQ2Eo6uddA5TwE3U+FXEcHv/
         dDoGdJHnCDBqgNqDsPFvKVuNLeWaTJzklzrmFWY98OxmGbetQ7zrKBYcP4Fo/UdVVfTa
         n87Q==
X-Gm-Message-State: AO0yUKXDgBi8Uhu3Ms4ly8VatRqcTowhv+3CeBLRXJYsqG6KCTG+hUe4
        Coti4LjPsnzpSPGz9++nvqt79AJ4gXmKezgmp/I=
X-Google-Smtp-Source: AK7set+7F5xYj57Uc7OdJB7x1zl+UTYlUcK21nOpfQqu9S3MJ+xiyrr4s/wKj3rZ3zx7povZD0tcJQ==
X-Received: by 2002:aa7:c043:0:b0:500:2a15:f86b with SMTP id k3-20020aa7c043000000b005002a15f86bmr8791029edo.42.1679235238119;
        Sun, 19 Mar 2023 07:13:58 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id t21-20020a50d715000000b004af7191fe35sm3540689edi.22.2023.03.19.07.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 07:13:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] tpm: tpm_tis_spi: Mark ACPI and OF related data as maybe unused
Date:   Sun, 19 Mar 2023 15:13:54 +0100
Message-Id: <20230319141354.22907-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230319141354.22907-1-krzysztof.kozlowski@linaro.org>
References: <20230319141354.22907-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
unused.  This fixes compile tests with W=1 by annotating device ID table
as possibly unused:

  drivers/char/tpm/tpm_tis_spi_main.c:234:34: error: ‘of_tis_spi_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Enhance commit msg.
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

