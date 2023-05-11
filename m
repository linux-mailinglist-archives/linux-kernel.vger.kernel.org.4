Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FE16FF8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbjEKR47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbjEKR4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:56:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D979013
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso15883803a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827775; x=1686419775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq3xdaWbI38VbfHI2H2l4imhWRTMT3X9WaNVdUPW3NQ=;
        b=hE2R2qAE+wJQ4exZRg2a7m7xY99SkSY6KF/r1j4oNUbZEMCqiDRKPbV0hbR5WXOYcw
         mz27le+L37SqkFA4ytw7VHnUlE402c1xJ1JxCarYIZ4t7rU+B2YNfyLivGu8nqCQPH8R
         n56myZts5jZTdiy25B9/j0mEd9f7zqcfep4BcoalLEQCpbZsJAVrSs79KwX27LWLYsYl
         lKU+bBd8q/xZJatUPahBnRdGNSTm7VoD88Iyo5GbqGrI2jKFofuxUu/e47Pcs0I01+GU
         ZKhI39Qrl6B4psVgUsRyH+ZRmMDrjwJ+Kw6BhngPTXgVOTmsb0TGYs/UswAEFWNuEu1k
         dSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827775; x=1686419775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq3xdaWbI38VbfHI2H2l4imhWRTMT3X9WaNVdUPW3NQ=;
        b=bLD5+tmIJ8ps2tiYzczlq4UG/EJwXweSgziggIRweKAgNuERYsRb3XgdYTuGI0hVr8
         4kcv1WNeF74t/5G6aAFcNX3rHC0OVM0nVLqjZp/ZUvU9Zm4rU5kCI15an8AUcnaS05kN
         fI8UohSU6duYFt0yiZYDSBLZJXYtVcvIBu1QrrfJwpcIGICW7sosk8wr3hqCsfI+zc0/
         DmTG5xTCdxmMcgollEGtZm7RoQ75hx4rV6TZy7ca+s+zXPWDoJRcAokVyKUfEOBrDFC8
         JeA/N7ped1e6pQ3SbGMlTKd1dqc+ENyj5ljmk4mcVsnAjqMIpWlYbOGI+sMGgu3Bhl9y
         ttJg==
X-Gm-Message-State: AC+VfDzK7sppOC2WZ9Wf4yH0H8LKsVzVgvE0VZVoMoKe+DH9k0vSfSXv
        R0T+d0462kMT6dI31OJfY1vcUI49pN90iNu82Bnyeg==
X-Google-Smtp-Source: ACHHUZ5TbI5yiZxzcAVL3WTsRXuiksWbaxiLOHY/lXw+vzlHCKWlwKQT6uqTl3XSx4urMCkxZbmTzA==
X-Received: by 2002:a17:906:d542:b0:953:7e25:2156 with SMTP id cr2-20020a170906d54200b009537e252156mr19528034ejc.51.1683827774746;
        Thu, 11 May 2023 10:56:14 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id lf23-20020a170906ae5700b0094ee700d8e4sm4247029ejb.44.2023.05.11.10.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:56:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 3/4] rtc: isl12022: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:56:08 +0200
Message-Id: <20230511175609.282191-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511175609.282191-1-krzysztof.kozlowski@linaro.org>
References: <20230511175609.282191-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointers to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-isl12022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index e68a79b5e00e..eef66453841f 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -89,7 +89,7 @@ static int isl12022_hwmon_read(struct device *dev,
 	return -EOPNOTSUPP;
 }
 
-static const struct hwmon_channel_info *isl12022_hwmon_info[] = {
+static const struct hwmon_channel_info * const isl12022_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
 	NULL
 };
-- 
2.34.1

