Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB96B5F28
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCKRhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCKRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:37:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A28897FC3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j11so33050252edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SdFkCAcFYqQLXuQPZJF9uuUIlYRjbN5Fnk2tHbR0J8=;
        b=nca4nmWy7yHFMhDtV3c+p/Kye64HqiZQuzZIXlLLzjri/qA6FSvaLyfCYSlKh3GCuk
         BLGlxDwoiuDwDLgIXFYWi4QQOT6fsTUT9h9nJnarMgheiTCTlQDvKfNwDYC8eLfrWmDF
         BbXu7JEEuwW1m3w6tk2DCDKSnImHgssZDSECgzHDGyGmQjU/xlGj0nS2Ojer3sFAX35+
         B0YtRFHG7Zov4jJRXj8MU308l+XRztSSV3+zHCxQPqqk0t5FHG5bQJFpTO2gPGRM0PkU
         npOPbc0IAAKbsFEv+XxwK+Lj/azJqSz+uk77N/qyeHmyhQdnn1qndci4TL7dWrKirSYQ
         BiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SdFkCAcFYqQLXuQPZJF9uuUIlYRjbN5Fnk2tHbR0J8=;
        b=Wd6H5SZNGGoI+oRe43jgubnqalQuuObiFJKm4cmIRB35RLfmu7o4415xjvwO10xkm/
         C4Aq1RNJS4rjMJe1mEf0SIoFkoObaR5/vKEXEdtlc3YMqRziSfiYitZbR7/iSUE8Qo/6
         f2U9QLeZfdUMVCk4BYRdhec5kHL43gnFa/ofG2n65IH6zUf+m/7H1svZ/4Bpe0RrmZzn
         Tos2w2ucIKd3gEecMyVnmw64YqukIIdpIMr4S8A4uwtN4iGJHjuRUhLJzxmZFnDWzPeg
         CGvk1oXvkGyvIKemTrcOfZ+MBQcOtd1OhD0ak820OeIsRP8leW2lOCsNnL1TI3gOdtxl
         Q4mQ==
X-Gm-Message-State: AO0yUKVhas7PuGYq9iXKzUtDXcZay4Ov+RFqleDpaGesU2D0G1EPezp0
        A2Goe7pJzg2qwKE1OnGP+07BcA==
X-Google-Smtp-Source: AK7set86+WXFwkkusoMVVsyn8I7uNiBN0R7q/0pN4r39ds7FYdWwNeye1wjlNOjhatU/gopp2H8RKw==
X-Received: by 2002:a17:907:3e91:b0:8b2:b711:5e62 with SMTP id hs17-20020a1709073e9100b008b2b7115e62mr34928132ejc.52.1678556161242;
        Sat, 11 Mar 2023 09:36:01 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061b1a00b009240a577b38sm245423ejg.14.2023.03.11.09.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] backlight: arcxcnn_bl: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:35:56 +0100
Message-Id: <20230311173556.263086-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
References: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
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

The driver will match mostly by DT table (even thought there is regular
ID table) so there is little benefit in of_match_ptr (this also allows
ACPI matching via PRP0001, even though it might not be relevant here).

  drivers/video/backlight/arcxcnn_bl.c:378:34: error: ‘arcxcnn_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/arcxcnn_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/arcxcnn_bl.c b/drivers/video/backlight/arcxcnn_bl.c
index e610d7a1d13d..088bcca547dd 100644
--- a/drivers/video/backlight/arcxcnn_bl.c
+++ b/drivers/video/backlight/arcxcnn_bl.c
@@ -390,7 +390,7 @@ MODULE_DEVICE_TABLE(i2c, arcxcnn_ids);
 static struct i2c_driver arcxcnn_driver = {
 	.driver = {
 		.name = "arcxcnn_bl",
-		.of_match_table = of_match_ptr(arcxcnn_dt_ids),
+		.of_match_table = arcxcnn_dt_ids,
 	},
 	.probe_new = arcxcnn_probe,
 	.remove = arcxcnn_remove,
-- 
2.34.1

