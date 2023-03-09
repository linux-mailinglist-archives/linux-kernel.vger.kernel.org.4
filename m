Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2247D6B18D3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCIBjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCIBjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:39:21 -0500
X-Greylist: delayed 1740 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 17:39:13 PST
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E8C6A2D8;
        Wed,  8 Mar 2023 17:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
        s=s1; h=MIME-Version:Message-Id:Date:Subject:Cc:To:From:In-Reply-To:
        References:From:To:Subject:Date:Message-ID:Reply-To;
        bh=GUMA4f7kLIsYl8rdj/++cokk31HflPlHrRAXXG0kkR4=; b=Tr0YLj9l5ONrokcfH4AT/7wO7X
        UGcRBU33RK4MtyzF8Amu5M8d9FjX0WG4pahAHMdV2/wtFl6bjhUa+F8ADoDFK90Gh3xX3BLE4DUOG
        dTzVAcQy8SkqxBUsYJFSI3Lr020ze3YXty7UG3HH3/m+kHUlbeZLv4fIa5yAvJtN/cZPRMPT6ZkjU
        jDl7qeoMYQeEPCKtDPHQPBMjaCKBIADRycsE2XMzfr15t7kPIaZAVdSscA/SLxCwRqK9HbNH3ztst
        aY1m9dUlIeIe44USrrRDs5fdW1+YNk6egYM0CyDJMoEJ1WUNS3CZ7FrqvR5tLoa8ElovvG2wWNp/L
        Du+Q8BYQ==;
Received: from [212.51.153.89] (helo=blacklava.cluster.local)
        by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <lorenz@dolansoft.org>)
        id 1pa4nK-001JUh-1M;
        Thu, 09 Mar 2023 01:10:10 +0000
From:   Lorenz Brun <lorenz@brun.one>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: pwm-fan: set usage_power on PWM state
Date:   Thu,  9 Mar 2023 02:10:08 +0100
Message-Id: <20230309011009.2109696-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lorenz@dolansoft.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PWM fans are controlled solely by the duty cycle of the PWM signal, they
do not care about the exact timing. Thus set usage_power to true to
allow less flexible hardware to work as a PWM source for fan control.

Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
 drivers/hwmon/pwm-fan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 83a347ca35da..aa746c2bde39 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -507,6 +507,14 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	pwm_init_state(ctx->pwm, &ctx->pwm_state);
 
+	/*
+	 * PWM fans are controlled solely by the duty cycle of the PWM signal,
+	 * they do not care about the exact timing. Thus set usage_power to true
+	 * to allow less flexible hardware to work as a PWM source for fan
+	 * control.
+	 */
+	ctx->pwm_state.usage_power = true;
+
 	/*
 	 * set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
 	 * long. Check this here to prevent the fan running at a too low
-- 
2.39.2

