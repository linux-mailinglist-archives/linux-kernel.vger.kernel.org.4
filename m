Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6513B6FF8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbjEKRzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbjEKRz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:55:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5829B9013
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:54:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so13312000a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827691; x=1686419691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ExNn/0BV7uiZxGd6DDKnxUoPniq87xv3Jw8AZivkUaw=;
        b=mk9wtBeaOCUH4b3IUHHpKu+o3ouUf8kQoUcUvru/6r5M178yO48q7WbAKxSyQ5k4S4
         PEVX7n+yUB7tCYyU7+KgxAAO3v4GU4Qi2yYqbHMvSdAzoKSmw9w4tfcEwcvtzi579zz9
         Sr/eCAV1RzMb9PtzPWDkITk+SJw4UPqIfVsROXk+pTc4PS95LY7GP5fURtqpT5A0lqvT
         a+4y+FwmMZdIrhlb+NYm4bxNkUsd7KGe58gpwi6XXU62Oq+bA9enTbIku0hUgdOyW5Tv
         Hjyp9HpRlAy3KJDtam5N2Vi9vzsX8xLp9GjFMC3qKkkn6ZOjRlJG8PndTSw1PZ2jrg10
         AO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827691; x=1686419691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExNn/0BV7uiZxGd6DDKnxUoPniq87xv3Jw8AZivkUaw=;
        b=Xk69422hgHrArqGs+p48etCNpGFVNz7qnOWZBWoTlYDeXJS/+7FckSemUdQjyq/m2W
         41GagV8fPHq+ZkT1hyk6xLLIFAg1v46zvF0vVHjHP3hDuFWGjKBmwvp1dftQ92RAIYJJ
         tkVPIWSVojEsEASk2O+6+PgPElhcsGmHnbYnN3M2pfzDsSHCFdeq7W+MUyvJZWD7KeWH
         xbobHHHNlBtGxr0dYr007AGLawJAIVYh2TEBIDJQtdaPVcBjoLNHVbw9nGtCq5jJsvIk
         ba87p7rYhGETn/V1guujr4EJ3JmEWVS7e/nzOojrv5mwkmMEr/XJ3DDp4AIn4f6Fu6rx
         PjJg==
X-Gm-Message-State: AC+VfDxHXoSZJbjI295z6XYyjvFGHN50r5VXeHEL/ouJkvZtBstxJdRJ
        5Gay8LP292jcaf1q0tEZ73Pz5UMVYOVFVBb8D/9uBg==
X-Google-Smtp-Source: ACHHUZ51BuTBkQHJ8q5/yqrRGA8TRj8wepBe56uHax7NV2zxvOw0XGHBhV9nK71bsdC5w1SznP4F3w==
X-Received: by 2002:a17:907:7e90:b0:96a:2dd7:2efc with SMTP id qb16-20020a1709077e9000b0096a2dd72efcmr6340332ejc.41.1683827690836;
        Thu, 11 May 2023 10:54:50 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id fy7-20020a1709069f0700b00965af4c7f07sm4281951ejc.20.2023.05.11.10.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:54:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RESEND PATCH] fpga: dfl-fme: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:54:49 +0200
Message-Id: <20230511175449.282069-1-krzysztof.kozlowski@linaro.org>
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

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

