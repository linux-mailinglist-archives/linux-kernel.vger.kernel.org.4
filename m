Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4EB6E30C6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjDOKoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDOKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6FD9EE5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50489d1af35so5682724a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555405; x=1684147405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCXVhY21NYv8g0uVv2aMkrRaQ5OFE2M1RqCENUZEQwY=;
        b=MaeoAEhme5S3w6Vvm2hlX3H8xIfe4cKomyHpefHejjA5ljeacJhQM/kb4o7+eiw0Lb
         hoZ/DxNAqYGxd2DYpb355e27sMyk8XGTNuJPFDVlQqT6M/xYcY7JMUblwZxhTDMSs2Ff
         JVHN5V5XgZEUn/lfe4teNo+OHcpeLfrSZu9LbLtvlxexDFltXHvJk3oQ3XQ+6cOEC4WZ
         oaeSaThl1C8vFWrP6nXOOK2ESynnOFKsSaF6xikIMLFYpBlCatoEFokHwK9zRFUDZuMI
         yCBGNUIVfqqmBp0+QOXDsrQdTzy62ff2qusUwOjiOhRNoBq4lIsS9z49QuIaoPN5jRzT
         U7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555405; x=1684147405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCXVhY21NYv8g0uVv2aMkrRaQ5OFE2M1RqCENUZEQwY=;
        b=dC1IEVi6jGnyZYLeU0jCav6WL1v/i6lwi0tEVtF/T6/DjnN7DlGH/URNo97cQOxw4v
         0PWNQdeA3D3qgNlRJu6m+S8VpDOyOtlCPBQfDwra9UTiAOe3HlWOtMBDm+wfig6gpgvc
         N9EgZ42aILBfvhpaVGkSHl0SjY1HONG+J8ux91N/kK2ZshPhFUYhBo9fbtmxN5aWNfxk
         lJILorqJKnEiLsYg7vCRDGQhG7/5xVVP1X9zqWl1aAB0bxpNqyLsdxCB7P0UNAWXqjPN
         X1/WTykUokXlbKaoMwTrPDmURlAl5QxUXoAlidynl3UfqNRVFaVATIDdYlP6vkfWWI4H
         2aAA==
X-Gm-Message-State: AAQBX9f4MLle81U3cgD7/SQbr0AQObWvQQtkL5FjeaUBUeZRWSgAhKZv
        RkAGQOKjpSC6AUEkyBrxZakeug==
X-Google-Smtp-Source: AKy350axUyld+HptWNFgmq7JEqEvSwSiRuyM/yYdGSOt3UHn5lx/H7ibPIBuKDzGrCTLDESGCPzlMQ==
X-Received: by 2002:aa7:dd59:0:b0:506:77e6:c9e5 with SMTP id o25-20020aa7dd59000000b0050677e6c9e5mr6271718edw.8.1681555405433;
        Sat, 15 Apr 2023 03:43:25 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/15] w1: ds2482: do not use assignment in if condition
Date:   Sat, 15 Apr 2023 12:42:57 +0200
Message-Id: <20230415104304.104134-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

Assignments in if condition are less readable and error-prone.  Fixes
also checkpatch warning:

  ERROR: do not use assignment in if condition

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/ds2482.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 7e915b71045d..f4ad644a7abf 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -451,7 +451,8 @@ static int ds2482_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE))
 		return -ENODEV;
 
-	if (!(data = kzalloc(sizeof(struct ds2482_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct ds2482_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto exit;
 	}
-- 
2.34.1

