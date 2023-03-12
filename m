Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470B16B66A5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCLN05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCLN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:26:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B2E1D93C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn21so8389299edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678627587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZPa32XDAtEd//9G2V1ruB1ZRmNf36m//VgqDPSR18c=;
        b=fGHFWIYuNn9gbGCjNvlOque7tlzFchZcflzL1JUIQmGtLimdtfL58AQzYeKyqV5euo
         KnPAW3nyWKR3gO+CH93I9XtRl9ByC4/e9PdD5X0cbeCMqDFfkDiNW1wYQpc0h7GEoqZr
         w+3Gsxx1wMqxAs68njvZ4QXH7aH9FiVyIdWDDYXBIDw/cg0iZm3Zy2EaFsF1K+lw8bvU
         6UxYRduRxQWbvU+BDKjtXFnOXNBcE2YmIcdY+NEasqU8xQpfxNbxpeSUX4OGq0lEMQvu
         nxpEyW226qW/Z9UUr81bPahOIpCR3+xvWKLPUXzPTZRrT6/7vf/2pOHuPLAF5+NrW83W
         fVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678627587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZPa32XDAtEd//9G2V1ruB1ZRmNf36m//VgqDPSR18c=;
        b=yR/H0aJBETI8NdkQ/azw22aohVrPkBcO7Z5UUzl0kq8Bjf+6WIgpT4ASAqIaq2Gc+o
         k/cJpUhwL/vpXicakLfHr4ikBAxjBxJVtS0YVkKZPn8QVc4MR22V9wVk+b//cyzMwLSh
         rDntvtENgUM9+emb4fpoZZ5f3BONzdK6RX7p9cMBaNVlTg1YylWVaF7qzb94sJFiHewx
         +fsRU+v04Ldddysx+6fSU+7nIocrVQXQrCFPK+HibFDetl+RJetkhAE7StjfXS7qKPbX
         c9cxWf66fAxSE41nDHw4bQeFpvt8vXd9T4NyehoE/8qSXjcqD45BJeoUv5/YHHP5LQgo
         GdCQ==
X-Gm-Message-State: AO0yUKVCn6wumBl+AGkV83DYQCh8IAgW09qmkzqS2PUIxX2wMdeUJ4QK
        9B7G9EK1lk0Ei1dorQ7fJwRIR0K60I2ed5GIjSM=
X-Google-Smtp-Source: AK7set/p7DxoA7h4HAcjHCU92RSGdcCsiGfR59LiRYT5XXBweuJJBnuOJSLgJAX3Sx7SNILqSwqQzA==
X-Received: by 2002:a17:907:9719:b0:8ed:a0ea:29ee with SMTP id jg25-20020a170907971900b008eda0ea29eemr7736801ejc.22.1678627587072;
        Sun, 12 Mar 2023 06:26:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id xc14-20020a170907074e00b008b904cb2bcdsm2262530ejb.11.2023.03.12.06.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:26:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
        Daniel Oliveira Nascimento <don@syst.com.br>,
        Mattia Dongili <malattia@linux.it>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] platform: classmate: mark SPI related data as maybe unused
Date:   Sun, 12 Mar 2023 14:26:23 +0100
Message-Id: <20230312132624.352703-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312132624.352703-1-krzysztof.kozlowski@linaro.org>
References: <20230312132624.352703-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested as built-in making certain data unused:

  drivers/platform/x86/classmate-laptop.c:1137:36: error: ‘cmpc_device_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/classmate-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 8b6a14611859..2edaea2492df 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -1134,7 +1134,7 @@ static void cmpc_exit(void)
 module_init(cmpc_init);
 module_exit(cmpc_exit);
 
-static const struct acpi_device_id cmpc_device_ids[] = {
+static const struct acpi_device_id cmpc_device_ids[] __maybe_unused = {
 	{CMPC_ACCEL_HID, 0},
 	{CMPC_ACCEL_HID_V4, 0},
 	{CMPC_TABLET_HID, 0},
-- 
2.34.1

