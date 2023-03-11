Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0C6B5F34
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCKRiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCKRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:38:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A032A2D17C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:38 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r15so5860243edq.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cBXwdVVf91SB8bAJyIJXNgZJKfax5M+P+jqXsh7j/k=;
        b=i+uNehPbqsApAXzIkJ9FA4tcJqNI3ycHEhXKRsF61f9YF+Tr5lk9/MldBCiGnUsAiT
         xRIa9WnXeDiFvMSS43XvEaFAVQps7Uqt9YTuZtKOR+05nPNB96ruq9IDiUHkJKj0hVjQ
         9/PygBnLUFJkzsf2yErCA8Zvx/KDGHtD62ByE0DdMF0rGo0ZZ4A9WA4muudaLRpSVtL5
         ldWhtpQNOfDyBina390f1OuSOijEA4uDzNcQUPb69QcUga0IGpBbqhR/HW1bvu2aD2BP
         sPT0jEjX33l0/oFaZHSuB64xBweXyttA5WQlFd/kDDfRrRzXug9hNxG43BG8pOaNZjnf
         TUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cBXwdVVf91SB8bAJyIJXNgZJKfax5M+P+jqXsh7j/k=;
        b=w60FmYL1EqnVPrTqXi2rL3MAMvamxEpOBQZDNcFa3XbFZjnD0r7HCMEuxOkFopCmsB
         5c3owABrjDQBAR+X2r4kf+Ky7v9T6Sh8fn2FO+bT3OIu9/aUTzicC3LoDS4P4o1AwD3r
         8JC00CKc6gmdrqaub+dOj2d4gL/RU17e1y/d95T0Z8/pjfyvMW8CR54HZAMl0Zbpyr3x
         7Dc3ZBxxt1aiX6Irz6qjziW3CwmaluVjcuaxh4xth4R+Nlw2+GBCLy0BD7G9cMilHTWf
         zJ0+cv+oMhP6vU5odb9PB5IY0jjpjpBkDVuHhQhZmIgMZfaV6CCEyNTek2DYZKB557Wk
         aNRw==
X-Gm-Message-State: AO0yUKXq6a6c/OH5gxnkSVbQ8Orx0xtwO3oJRBS246eTkIDcXvzXizPG
        tQIxQwrPj8Fgs7wUj/GP7vbRk51dkneIZKbRidQ=
X-Google-Smtp-Source: AK7set9sbE6kJKu4Fl/uJAED4UQyZQWXZEQlCNQzNbupCO/drQarzCuEYybYIW1lcoUnlQBycekXRw==
X-Received: by 2002:a17:906:3e52:b0:91e:fcea:f25f with SMTP id t18-20020a1709063e5200b0091efceaf25fmr3617220eji.32.1678556192876;
        Sat, 11 Mar 2023 09:36:32 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id jy2-20020a170907762200b008de729c8a03sm1315253ejc.38.2023.03.11.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/7] usb: renesas_usbhs: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:36:20 +0100
Message-Id: <20230311173624.263189-3-krzysztof.kozlowski@linaro.org>
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

  drivers/usb/renesas_usbhs/common.c:535:34: error: ‘usbhs_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/renesas_usbhs/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 96f3939a65e2..fa34efabcccf 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -823,7 +823,7 @@ static struct platform_driver renesas_usbhs_driver = {
 	.driver		= {
 		.name	= "renesas_usbhs",
 		.pm	= &usbhsc_pm_ops,
-		.of_match_table = of_match_ptr(usbhs_of_match),
+		.of_match_table = usbhs_of_match,
 	},
 	.probe		= usbhs_probe,
 	.remove		= usbhs_remove,
-- 
2.34.1

