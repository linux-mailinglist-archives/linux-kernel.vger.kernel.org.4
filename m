Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178026B5F37
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCKRiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCKRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:38:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE1B83
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ek18so1918773edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVsRHvp4v2BZsDFyVhp2lzWzUanEACS05jvKHMEi9Oc=;
        b=tcexlUBsPwBVa0P2zR4E94lM2KxLiHbo5zOn6DBz7gZup6TVuvKaQ15pB5QxlYCMzq
         ercJh40HVV3I8+BKPJU8THwCnmxiWWPNpVLer6OQtcxk24qS2yeAqCVeK91eQRq6xB0d
         Ge25egWdeMznxKjF62VVua/KyHwWxKLn3sApSQSewMnUe1QKfltxt+7GKIlQQvu1ZPEx
         B2+/J5BBrI37z/xPOqoJ9R/m13PlunBJlZ5L9mx3fl7HyxpRA7HFEoO+2EY1CRMk6hBq
         UJ0lDg5llQr9ic0G/R7YgDI+AUg95Zse6lmhXUGrizUaiKyf0QyykKncGC3JkjeYf8sW
         ioSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVsRHvp4v2BZsDFyVhp2lzWzUanEACS05jvKHMEi9Oc=;
        b=WEsIsKtAIglsB370JWZDvRwCXoFwJfM7hhPgMbbtb+XTvGiN1llVJ2JmyS6QCwAFNO
         TjlqV0vdYfeF8u3P0nohvJpn7bZrFLCIDeUNbNSaqmlsp4Pr1oa/jcFS2kIIultu/1PO
         kkjPKtNRhKtojEevtcwXRccJpJZgUNNHNBBZQEph3FgHMSLoAMegDY5263cRBzh+kSnT
         BGnqEUJIH4M4cefgc32AuZJXwmJmnQWUQzAXIHbjJu30upl56JPI97PNj8bf/BCRgld/
         zG0KFNhkLW4BVc6rlLe+yncVOi8WC3DhsvwvOZVZMf8OBU2M2BCDPyowsuo3rlRkE6Zr
         HM+g==
X-Gm-Message-State: AO0yUKWX6Kq5S3OT8RCvqLNhOXc4QuTX7AosOXfqxDxYtbJ0dWH3htTd
        cQ2hZF2wQDv4uB7i9mP7anviPw==
X-Google-Smtp-Source: AK7set8PKIRd72z9/UuyBVH8cin+ES99J/ZpkTTo9AKpqnbFqTCWzYzgZiDEH2cYJ9q5Jc0kJo82kQ==
X-Received: by 2002:a17:906:fe4c:b0:906:4739:d73e with SMTP id wz12-20020a170906fe4c00b009064739d73emr5828323ejb.2.1678556197023;
        Sat, 11 Mar 2023 09:36:37 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id jy2-20020a170907762200b008de729c8a03sm1315253ejc.38.2023.03.11.09.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/7] usb: misc: usb251xb: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:36:24 +0100
Message-Id: <20230311173624.263189-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173624.263189-1-krzysztof.kozlowski@linaro.org>
References: <20230311173624.263189-1-krzysztof.kozlowski@linaro.org>
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

The driver will match mostly by DT table (even thought there is regular
ID table) so there is little benefit in of_match_ptr (this also allows
ACPI matching via PRP0001, even though it might not be relevant here).

  drivers/usb/misc/usb251xb.c:223:35: error: ‘usb2517i_data’ defined but not used [-Werror=unused-const-variable=]
  drivers/usb/misc/usb251xb.c:215:35: error: ‘usb2517_data’ defined but not used [-Werror=unused-const-variable=]
  drivers/usb/misc/usb251xb.c:207:35: error: ‘usb2514bi_data’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/misc/usb251xb.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index e3abe67a155d..c36e04aa5a82 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -377,7 +377,6 @@ static int usb251xb_connect(struct usb251xb *hub)
 	return err;
 }
 
-#ifdef CONFIG_OF
 static void usb251xb_get_ports_field(struct usb251xb *hub,
 				    const char *prop_name, u8 port_cnt,
 				    bool ds_only, u8 *fld)
@@ -626,13 +625,6 @@ static const struct of_device_id usb251xb_of_match[] = {
 	}
 };
 MODULE_DEVICE_TABLE(of, usb251xb_of_match);
-#else /* CONFIG_OF */
-static int usb251xb_get_ofdata(struct usb251xb *hub,
-			       const struct usb251xb_data *data)
-{
-	return 0;
-}
-#endif /* CONFIG_OF */
 
 static void usb251xb_regulator_disable_action(void *data)
 {
@@ -754,7 +746,7 @@ MODULE_DEVICE_TABLE(i2c, usb251xb_id);
 static struct i2c_driver usb251xb_i2c_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
-		.of_match_table = of_match_ptr(usb251xb_of_match),
+		.of_match_table = usb251xb_of_match,
 		.pm = &usb251xb_pm_ops,
 	},
 	.probe_new = usb251xb_i2c_probe,
-- 
2.34.1

