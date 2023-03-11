Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DFB6B5F36
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCKRiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCKRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:38:03 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9724C53725
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:40 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o12so33035111edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC9i5n8asjM8jylrUmHvyHqC1xMOAwXkhiHJbgBRUXg=;
        b=IepgW+QXG7KAxULdrdbYkLGImQ9fH+VcF5R6PvkN52JfhtumdgGjRMwLJDyjTbYocq
         i2oYs2r1qeFgfGt3JZBLmHodNtCpLiOf6m967/4/bXaXnFAUNCaOb6o231btD0E7ksxw
         x37SoPNHTOlUm03sdH8jj43+J1X8kt/H+YcormpqI3F4rEoUbcsncwiX/j7awDH8Fbp0
         3pkTRmFdZ4cQbQHexf0VeR5k/oOZa4fgtPcSHBT5bxNx65juWSTeshbuG/I/ZDW1WiE3
         1NNG1qVCFj+Hm31uRWFDFWPkrlcCj4KMFKH1Oja3oNSyCr5DsH+0omLMmPT299YL/53m
         N9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC9i5n8asjM8jylrUmHvyHqC1xMOAwXkhiHJbgBRUXg=;
        b=Ii1AQQ56Rz1ZqnrdAtED7gRl4nqHkzDZs+z/87EPB+SGHYG9gVNz1xdgWxEtwXXCew
         9RGPMaJvqd6pLCdXZLmlUPm+T7R3mksL5zckI7zhTE/tt8xuFlAhe+YWNKzlslokaGKO
         iKksfAVJb3rsOQtnHUaXmPJbJcgFmD2Gw4ahnIw6EoV4YpcTHWxHCjsJGrQqelmtqJb+
         rYDF0/JDnjDypMWtadYRpGSZvtgyqCvEC8o1N2MdYYI2FXGEYKCVCUrwocWlnPAusiF/
         txPZKte1xBrD/tfGeBsVemmv5u5MilxSvP1CNoHjDemI4TKnxOcpbRYezjMLGfn9dsZm
         ObmA==
X-Gm-Message-State: AO0yUKWvuNn+TK9dZFnrsikqGyhUZPzq5i6cEf/PN3W1albIwmgIQSFV
        kG6ga07Jo4NgFG4pt8TscXH5pw==
X-Google-Smtp-Source: AK7set992N5KyTV+Kc/Ns7ppLpIqv+kUzxVVHlXH4uBYYsAdLkNYwDXfffhY/9vBzI4SRnwAhGTh1A==
X-Received: by 2002:a17:906:58cb:b0:8b1:2998:6474 with SMTP id e11-20020a17090658cb00b008b129986474mr36336448ejs.16.1678556193912;
        Sat, 11 Mar 2023 09:36:33 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id jy2-20020a170907762200b008de729c8a03sm1315253ejc.38.2023.03.11.09.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/7] usb: gadget: rzv2m_usb3drd: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:36:21 +0100
Message-Id: <20230311173624.263189-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173624.263189-1-krzysztof.kozlowski@linaro.org>
References: <20230311173624.263189-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/usb/gadget/udc/rzv2m_usb3drd.c:120:34: error: ‘rzv2m_usb3drd_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/gadget/udc/rzv2m_usb3drd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/rzv2m_usb3drd.c b/drivers/usb/gadget/udc/rzv2m_usb3drd.c
index 3c8bbf843038..8855d8e8d793 100644
--- a/drivers/usb/gadget/udc/rzv2m_usb3drd.c
+++ b/drivers/usb/gadget/udc/rzv2m_usb3drd.c
@@ -126,7 +126,7 @@ MODULE_DEVICE_TABLE(of, rzv2m_usb3drd_of_match);
 static struct platform_driver rzv2m_usb3drd_driver = {
 	.driver = {
 		.name = "rzv2m-usb3drd",
-		.of_match_table = of_match_ptr(rzv2m_usb3drd_of_match),
+		.of_match_table = rzv2m_usb3drd_of_match,
 	},
 	.probe = rzv2m_usb3drd_probe,
 	.remove = rzv2m_usb3drd_remove,
-- 
2.34.1

