Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CCD6DAF22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjDGPC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbjDGPCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:02:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EAEBBBA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:01:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-4fa3c857b08so1796790a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680879676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39vQ5gfFEdag3ZfqeTZIAWiuaWeqb2c0HNkG3ClYWpw=;
        b=ksERjhycDKQAuwDwtPkgWSU1R8hcqdRLBNMuhaNyJK3lh46gjTFEzTdI9saV1G2hXA
         5+qi4lVcXCGhpFSQ6hcoJYxD2BBY2EvTZiqC2pl7BCzs2NgmAoqX/fJmmdKA8Nsv4gYq
         t9CLoUy0npQNXrMpH0eetfOT9il3aqxnUaGdn/IxKalOlQCt1FOXXCv4CAJKe3xFbbfM
         wz5u6qbqVH6uLPOBsbKztHpE7Os8WhXpLLaAzoPxKIKw8QfXpSJMZ9aaslLr1kOaKX3C
         TwY0ZS5zAdVDT/JUbMhMLQdPjQvYnC/19m/SrLrwAaqsK9iBHsx6tGeIlgpfRx9D2Wah
         RuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680879676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39vQ5gfFEdag3ZfqeTZIAWiuaWeqb2c0HNkG3ClYWpw=;
        b=fZC52cMMEIIGIqtgYMBJH8GR8DGvCjY6HilkDC06+k7PBPWjDX+UDXkfvDXKvZjO18
         s4zPOtTg2thQfNMXrBsXCcA0AQGnprZzh6OdqxFpIYRoW7klbz9L3pqr2SmJWdZZcqkX
         8lEDRoPK9IqgoUS8XT5R48L2fO81EiU7k5NvkrvjbaxRj8pYvZU0CznpVnWFY5XTe1cr
         l/pAzju+8b737cSE7iWZIaPjxdkqyYHOlS3yU9yp+og5bOnnMl4bYdEqMUJQ1hDwmcRL
         T98bSJB5cQ74kO+F+8zEl/jXtngcKGnjmVYnU+efR/3Kbhrs4H19eLFFfURlU6euFXUT
         uieQ==
X-Gm-Message-State: AAQBX9c9zJB2iBzuiCSl0DSg4+WU3PGJz52qySMxeplZk2Oe5ZPcA7er
        j12ndIa4Ss9sZ71ED+bq9ja/PV/irVOOrijTDPs=
X-Google-Smtp-Source: AKy350YHYCzgcXu8cuDPFMJXa/kNUhvsl8ezu/D0XT6Lt2JFP2aho/r6qFHfjSrwzgfBYlsv2FGDhA==
X-Received: by 2002:aa7:c74e:0:b0:4bf:c590:3c57 with SMTP id c14-20020aa7c74e000000b004bfc5903c57mr2884380eds.2.1680879676457;
        Fri, 07 Apr 2023 08:01:16 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b20f:8824:c926:8299])
        by smtp.gmail.com with ESMTPSA id f6-20020a50d546000000b00501d39f1d2dsm2000231edj.41.2023.04.07.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:01:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] fpga: dfl-fme: constify pointers to hwmon_channel_info
Date:   Fri,  7 Apr 2023 17:01:12 +0200
Message-Id: <20230407150112.79854-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointed to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This depends on hwmon core patch:
https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/

Therefore I propose this should also go via hwmon tree.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 drivers/fpga/dfl-fme-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 77ea04d4edbe..bcb5d34b3b82 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -265,7 +265,7 @@ static const struct hwmon_ops thermal_hwmon_ops = {
 	.read = thermal_hwmon_read,
 };
 
-static const struct hwmon_channel_info *thermal_hwmon_info[] = {
+static const struct hwmon_channel_info * const thermal_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_EMERGENCY |
 				 HWMON_T_MAX   | HWMON_T_MAX_ALARM |
 				 HWMON_T_CRIT  | HWMON_T_CRIT_ALARM),
@@ -465,7 +465,7 @@ static const struct hwmon_ops power_hwmon_ops = {
 	.write = power_hwmon_write,
 };
 
-static const struct hwmon_channel_info *power_hwmon_info[] = {
+static const struct hwmon_channel_info * const power_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT |
 				  HWMON_P_MAX   | HWMON_P_MAX_ALARM |
 				  HWMON_P_CRIT  | HWMON_P_CRIT_ALARM),
-- 
2.34.1

