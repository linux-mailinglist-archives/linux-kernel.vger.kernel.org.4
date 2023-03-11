Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD87B6B5F30
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCKRiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCKRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:37:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A82B3733
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y4so3588057edo.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51J7ma9iyDiEzHar+KOLvIqKc+iCxvx6uDovr0nOXMg=;
        b=jgQY6/80LqgXtTIC1vgAyzfbe8AwY+LHUoUfe1K+cYgQgzaVPF6WvuR9nrzH7IoUs+
         DaIBr9OuL2SMQfIiY096xCQbW3dAHoPoBuap7PVTUquW7qHWtzZNSaYzwlMecLRPaZl1
         zARLQgo+5+PHYGAJb/J1XnWUgjNNJQujb8cPN0fdR1jpwaFM7wjYMkgPkOClKcZaYiuG
         9Ixkx7jrnCIniVQe4gQRL2SWIX15beqFb9sQ2zPT1GS9LwKgCwDdkwI2tDJC+4LV99xi
         4qoUA99NPSmA2B79tLl5MjnnIkFswjf7SYcNeZe57vQRaTNYp5kJD0A9UPWyMlVX31HH
         9Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51J7ma9iyDiEzHar+KOLvIqKc+iCxvx6uDovr0nOXMg=;
        b=F19Y0sXPDIYyq9zKs9S0hXwtVnHQZocRWlIYIdrS7lLSt3CSk3B5nBlVQGn49bQeRo
         D3xJvWaTub1tFn/vMf2FtndCMmwwdAObis2WK3TxCN/qlGjifkOAS8dG8h6kXc9WdRSP
         TBrgNIBF169HQ6QDmIPaRtGSPfC3CSjI0dPqkPSbH5eXJuE7eVgis5K0iPc3PaLxw4aU
         ho6FmjKUNxSZmpjDg2RxLNAojFUAXfb6zx/U/eIUBS4EfRL2xOkuk9aYLRmhPKgJDTcc
         li75cuthFgcTPGQFD2rC6Q7GMOJVVBQ2BIk2so9flKTWfq4yf2HRSxrfqW2if2YHZbUD
         Im4w==
X-Gm-Message-State: AO0yUKXqRpQERsVw+lnGsGqL9GsjyLswVU12oqzcXeSfB3TIXXTo8Ny+
        iQf/WlqIChS0e+WKY/GuA/TYM4mml2LIdilDjp4=
X-Google-Smtp-Source: AK7set9r7turVfzVMRHL6C0LQnIOCXg9/qqvDM83ESDE0B20wvaErRVpq4LpT0V1m8cTOfa6X4NUzQ==
X-Received: by 2002:a17:907:7da6:b0:888:b764:54e5 with SMTP id oz38-20020a1709077da600b00888b76454e5mr34727430ejc.71.1678556195869;
        Sat, 11 Mar 2023 09:36:35 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id jy2-20020a170907762200b008de729c8a03sm1315253ejc.38.2023.03.11.09.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/7] usb: gadget: max3420_udc: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:36:23 +0100
Message-Id: <20230311173624.263189-6-krzysztof.kozlowski@linaro.org>
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

  drivers/usb/gadget/udc/max3420_udc.c:1312:34: error: ‘max3420_udc_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/gadget/udc/max3420_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index ddf0ed3eb4f2..12c519f32bf7 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -1319,7 +1319,7 @@ MODULE_DEVICE_TABLE(of, max3420_udc_of_match);
 static struct spi_driver max3420_driver = {
 	.driver = {
 		.name = "max3420-udc",
-		.of_match_table = of_match_ptr(max3420_udc_of_match),
+		.of_match_table = max3420_udc_of_match,
 	},
 	.probe = max3420_probe,
 	.remove = max3420_remove,
-- 
2.34.1

