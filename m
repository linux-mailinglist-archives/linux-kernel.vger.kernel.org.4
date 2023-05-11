Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5E76FF8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbjEKR5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbjEKR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:56:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0559F901F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso16176730a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827791; x=1686419791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24nE1/kCUIt4VxUYaOy3n42p9I+OEZpARvSoMuz1JcY=;
        b=romEM7onwBvttCZ6Iyh6XGlNl6BiuxxstU5nRxUtYf7UMwLRAB9f4qvhYA8Hk2/b0E
         eTFG/hxUU2Y8XxM7FIoZzrxACMoLc2S+4DmXpR7cSpCMJ52jyWfqJ8E1+h/hJTgrAoss
         zfLX/TcL2GXp82O73J4Q9kpATOy1zv31OkVg3pZse57SQJHZDCLhBSQINeiw2+xNalw6
         sK5lnFN2l22vsfVDcTG5I7EX5iEwCvlEhPPMbPZgDUdMUQcUqMPcoGXjE0AksElbgo4q
         AUG3A41/nx7TSKXyQpyjjStAlTU6ypVr9THjLBW9c0EUFYbWHqHCkSQhX0Wu8Uc8kOUd
         3Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827791; x=1686419791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24nE1/kCUIt4VxUYaOy3n42p9I+OEZpARvSoMuz1JcY=;
        b=c3y7jaMXCM1aMS/5wK3kuNTEYz+3ATV8TBBC91JWUGAdOcJ9qISywa/by+NCpE8m4F
         /TanxI0kSfNYR3fvnXfFOqw6hFuJTkl6wb5zuElD/hbQCccuwHz25exnPyP8RqQBVCN/
         XY2hFnsZKBru4alyPsnqwpsYb2RbXjou24hFfe1fcgMynPUaWTWx/sCLVJtQfFpowhIM
         Ik4v0j1fefXSvGE7MYkzLbAkAcz9OcfQyiExzqVCgkUdC4Rl8LzU2b0ibkN28VF9zDXA
         BK8yXpf38fwlETPETJ+W9/o+/+oCMeCUcavliGN8X6eLtvHWVoT4PyQsQHVkO6PBnUAk
         I1KA==
X-Gm-Message-State: AC+VfDwBcSupB/E1dO2YVssqj4dLDx/6L4JSPb95n4CjKgl/9KSuguTz
        lbPlTNdOyFmf10X/+p5oSdJ5Ig==
X-Google-Smtp-Source: ACHHUZ4dVYd1ckDx8XuEHai8ueEHM1w9oSLwr1AQap+eSxw5kA9JOvV6VACtscHKKLA9r+o5MewQ/w==
X-Received: by 2002:a50:ed99:0:b0:50b:d30c:c595 with SMTP id h25-20020a50ed99000000b0050bd30cc595mr16582930edr.7.1683827791134;
        Thu, 11 May 2023 10:56:31 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id l14-20020a056402028e00b00506addaaab0sm3099202edv.32.2023.05.11.10.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:56:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 1/4] platform/x86: gigabyte: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:56:24 +0200
Message-Id: <20230511175627.282246-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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
 drivers/platform/x86/gigabyte-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
index 8aa665e866b8..f6ba88baee4d 100644
--- a/drivers/platform/x86/gigabyte-wmi.c
+++ b/drivers/platform/x86/gigabyte-wmi.c
@@ -94,7 +94,7 @@ static umode_t gigabyte_wmi_hwmon_is_visible(const void *data, enum hwmon_sensor
 	return usable_sensors_mask & BIT(channel) ? 0444  : 0;
 }
 
-static const struct hwmon_channel_info *gigabyte_wmi_hwmon_info[] = {
+static const struct hwmon_channel_info * const gigabyte_wmi_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT,
 			   HWMON_T_INPUT,
-- 
2.34.1

