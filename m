Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BF86375D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiKXKCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKXKCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:02:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BBA2B605
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:02:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e13so1854273edj.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpY3UV91PSJQHvgfwYlnFBFz1OoDDcdlR+QZ0N6B/hM=;
        b=Ecx7bTcOSXvqqMzZgKieAhLzr4QI6sOZ0G5WhPbqjpli2YJygDJoBB1T3p9uSK20ZA
         /srPeIHVf8B9M2Eppw/ZGUAp/7t4jj0FPpOeY54uTDstfB80eZd9mpt8+DarOrGJz2W/
         0kwgmSOb/mTNsWZEnWN+T9WSly8I00SpZyltg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpY3UV91PSJQHvgfwYlnFBFz1OoDDcdlR+QZ0N6B/hM=;
        b=RJxJwgxdOq4/8POOXMdzsQQWp1wcEBwrV2oydMmw4ENan8QKTdp0MZ4lcFtIBmJl3i
         NtHQT5USNvDnV/SEp+33EwewI4CyQ9vKClBoJnRxRmt5mxFXUUoGNrrwScbibNQn9sFB
         AAm3+4tRP3uxZaYDgBLan4zmDlZdtchrNfiGy/Ye45mKCJY79UuhnJN+FDDfJ/aDHcyN
         DrSjWkm4zGUSIND1pmQ3J44ygq0S+euzXT/JmppMkKv+tIltWUGqGcJ5OztBsWHQO2Ta
         X1YUgqKr26oDBCXt3umT/1OXfeCr2Bp+zBq5CoRwoTmDrM9v5wM017ytc4NtsTmlfVSr
         hYdw==
X-Gm-Message-State: ANoB5pm9awqiQU4w3ktFG2kJ5hxUVyYYCtSsqc+KfkeAL/iQH7dkJRN6
        qJvHf83PK4KMuCrpsiO4pNiAGTCOTKYajw==
X-Google-Smtp-Source: AA0mqf4IAGUGBZu0HpMFEXxh+h1BfhxLpU73Ngshp5eQfZx3RHIUr+rGxdiBs0P8HtvidJKtRZFvAg==
X-Received: by 2002:a05:6402:2421:b0:461:524f:a8f4 with SMTP id t33-20020a056402242100b00461524fa8f4mr28270833eda.260.1669284160934;
        Thu, 24 Nov 2022 02:02:40 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:2a85:84f4:13a1:b293])
        by smtp.gmail.com with ESMTPSA id i29-20020a50d75d000000b0046a44b2b5e6sm335548edj.32.2022.11.24.02.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:02:40 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 11:02:18 +0100
Subject: [PATCH v2 1/2] earlycon: Replace simple_strtoul with kstrtouint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221123-serial-clk-v2-1-9c03ce8940d8@chromium.org>
References: <20221123-serial-clk-v2-0-9c03ce8940d8@chromium.org>
In-Reply-To: <20221123-serial-clk-v2-0-9c03ce8940d8@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, linux-doc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=BxupyuW9bNdLBDym2TmyvusXWxEqDYH/mW0kqKjxYbU=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjf0E3cz6hfTxPtG8dan4pVp0sHPvMZBTj4KHwf/E4
 JrvN/HyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY39BNwAKCRDRN9E+zzrEiDX9D/
 0TLkdFaNvc8KoF6EAzsYlDq3afSMn+zDYidrCvj3RXOx8empIqK7qgqXQFKeJR341BKHycrGMAHPr4
 pl3cDfhOnKNZCm2M67PjNA/6heNjqNfnQVQf83fGx9FTgu4JX1QDaW7H7ESwOlAwrn5yZYCTIKyNY8
 rBvWrVlzWp96Ad5s9mliNERtS1KSra9ejrhGSUDL75ngsJJcP3HgTpc8pkHxZT9poCT+pAR+R7cerG
 UvS+XP4XhTRkJMaN0QBIsnXR70HBBXss9VaJi3FzSJDfiKfHLTaAFFnjJuDLD/toqGhEUaCxFumX7J
 na2EYcIxuWjw9eGatEVm4+NVj2yxMRlRxAgbZn878IGtoj00gmQFYuR51lNqWhxCEa/KaedIq+7r3M
 I3momJlTlfvRnpFKDu872JUYuOWj2So5r3SQY4dO4RVJb7U4EREUmEEjML94oriCcP4F/8g8qD2Vbf
 MUWC95f5nu3H6leo/uaTaG7qme2CzlE9MXh2vecsnQeQAvSr+iMriRSh6txVBz/67EdohpG9+6NjVZ
 qJF+kHesFphNbQciwvCf1x0zlQJ6AKXCvLiPKwrATGsAEDORg3n5/Ad2s5cVe8gWLxvYqpmM9leoWy
 94l/m+4+SjwWWzssZvf4ImOi2bzm+9YkOygrn4hkSzAi20clncDehiVaetkA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baud rate is declared as unsigned integer. Use the right function.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a5f380584cda..5b73da9487b1 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -120,7 +120,9 @@ static int __init parse_options(struct earlycon_device *device, char *options)
 	}
 
 	if (options) {
-		device->baud = simple_strtoul(options, NULL, 0);
+		if (kstrtouint(options, 0, &device->baud) < 0)
+			pr_warn("[%s] unsupported earlycon baud rate option\n",
+				options);
 		length = min(strcspn(options, " ") + 1,
 			     (size_t)(sizeof(device->options)));
 		strscpy(device->options, options, length);
@@ -303,7 +305,9 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 		port->uartclk = be32_to_cpu(*val);
 
 	if (options) {
-		early_console_dev.baud = simple_strtoul(options, NULL, 0);
+		if (kstrtouint(options, 0, &early_console_dev.baud) < 0)
+			pr_warn("[%s] unsupported earlycon baud rate options\n",
+				options);
 		strscpy(early_console_dev.options, options,
 			sizeof(early_console_dev.options));
 	}

-- 
b4 0.11.0-dev-d93f8
