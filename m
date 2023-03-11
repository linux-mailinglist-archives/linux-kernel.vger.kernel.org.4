Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD56B5AFA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCKLR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCKLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:16:37 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E1B421E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:28 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x3so30662047edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWDnMi7QDZcdU4X1J04rb9K92AwZUFTrHqFetObZuyA=;
        b=FPB6LP9qGChtUK7gsfHHUoQz9aOtglbfyIbyXKjx+q88Uc7gEE//joK7NgZoHsVQId
         Q3SW4vnMZ7Mi7REyHsmktqkrH4LfkEJOSOih3tcOOiRlQWr7oi3m3aPv+dSNJa+6OKg5
         PS1sfqnBPBvFHObJy+cLm2EkysAX+jQQozk7oM1uahf4fg0le3hH4AshRYN16o3RTX2Z
         ops6O9KHRmxXB9sLZZXBeZye9/NVgqoQEhJdYWc3gbO/U7xpju7CSlCG5u5fvzPXCgFI
         MPgSb/RwDWBY8OHc2kNbtoEEA9/Fj+SWIIojRJVBKNqRGtO5isIsFnV7KCTV8c6uHvDj
         9JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWDnMi7QDZcdU4X1J04rb9K92AwZUFTrHqFetObZuyA=;
        b=FTvGIjHGBLYWUK5XCCpXpAauYshcuonXspOeVfjIWq6H3b1gC9Xt52NPgeLiU8UIy5
         i0+A2gCxbDn/JnqQqOZTDEE7i1G0f9w5imEMCQLiGsAV0Qg8KAAr7DjILp5+SJ6g35Cf
         zFi0hlDHJB4WR8SbQGhoXPwjcHXYLO84BL6oriF8lbN+FzVMv/w++moZzeD91LYZaykP
         jD67v3wdipdYM02aJIrUPAehhuK+GfZ2RqhrpK9r7q7mE+lzz+tTHse8/N8LNQe4Wlmu
         k8666sCsmW2hH3ocHTOBXCJVqedl3ws9m+KzbG21xDYrLLXlDSAFpWnaWDsnTxG9fzMV
         EGNA==
X-Gm-Message-State: AO0yUKVsO78Po8EEuruPWMkwAZUsxbdwlrNChPlqLMlSRsDNRRo/rLwI
        LbIJAtOS8G4QmzTbsOfZnRIHHg==
X-Google-Smtp-Source: AK7set/CMxwbblIW2mcgQdrWF+nrSueg14JbkoTX1/WzgpY9XADsiMemFhpivXEjozp2h9uVjs1CIQ==
X-Received: by 2002:a17:907:86a5:b0:8b1:7fe9:ac69 with SMTP id qa37-20020a17090786a500b008b17fe9ac69mr37804712ejc.75.1678533302588;
        Sat, 11 Mar 2023 03:15:02 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id lc22-20020a170906dff600b00922b009fc79sm223427ejc.164.2023.03.11.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] iio: dac: ad5755: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:14:55 +0100
Message-Id: <20230311111457.251475-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
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

The driver can be compile tested with !CONFIG_OF making certain data
unused (of_device_id is not used for device matching):

  drivers/iio/dac/ad5755.c:865:34: error: ‘ad5755_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/dac/ad5755.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index beadfa938d2d..a6dc8a0bfc29 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -862,7 +862,7 @@ static const struct spi_device_id ad5755_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5755_id);
 
-static const struct of_device_id ad5755_of_match[] = {
+static const struct of_device_id ad5755_of_match[] __maybe_unused = {
 	{ .compatible = "adi,ad5755" },
 	{ .compatible = "adi,ad5755-1" },
 	{ .compatible = "adi,ad5757" },
-- 
2.34.1

