Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7495662C975
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiKPUCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiKPUCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:02:39 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B26657EC;
        Wed, 16 Nov 2022 12:02:39 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 6so17716845pgm.6;
        Wed, 16 Nov 2022 12:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u48IeVxeYRpqZXDq8TEy2jgfthr+zPe9V44R0XXV6s=;
        b=OJlre6S9pakulZA+yEGpONatIYHUbfqM2duW/AMNUeogjFygAv4bC1gl8iiKIN6L6l
         9V9rlywuoLnK5SwYcyVQS2YSTt3Kqvii4TqEmU2ENGMclvuydNlmNCAUteaOS75MjF/Y
         MhGThK8Twowj8WQeQ9lAWEYmiILMeQtIu+PiP3qqkDG6rsjtDicG+9RKXHykP+xknhc6
         X6gs7BePV5RcqSFi1V8QY3DelJ/Ut7FesSt/BazrNm21n79ND4L3ithnApPPwZpaJJfM
         TAh28RRnZv87qP/NiskyIMIboOAh8QHacJG3uShCw95I0tDHwrsw/zQMQFyCOGnu5Bag
         R17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u48IeVxeYRpqZXDq8TEy2jgfthr+zPe9V44R0XXV6s=;
        b=Q0vMvJtCXwaL/Zkk7+V/mukgy/kXp2FOP1Z49bwMBolK0I0ZSAWEO9cn6ZF3GFZSpZ
         l4RIQp7DHPJv3qR09+XZWB9E0sQoWIWDHHAQRdmuyRNYGkPZfXC+xEqxJM2yyxhj+5kq
         stpUr3SZ9EYNhnqVMjPkRZw5AI3SIJMYP1KaQEjn9gOWwPM2/JEE5t+R3gvQ6AQyrlE5
         +oJ8XmeTTr5mbEpZF5GIb5ibV2aZC4yS0NazqpAhyGwwhcjpDycnNh1ELdVb6tq2Hnq1
         PLEpVJbqRJou61EylmvSow2mwBAqZtaeXDyKzSM3QRgZBEON8IsEmR1s4Lb06/TZrBrL
         5EKQ==
X-Gm-Message-State: ANoB5plGjdpzqCSYeErksrC39uibhz82YkbEOHxRpmrwUc+CRVhGwpK5
        e8mqsAD031KKiEIw9d2fPSA=
X-Google-Smtp-Source: AA0mqf790rR++Tn3av8PLwCoZX/3FlqthhDW8C6waWJTH8vWZ4I6VdRk+YNTEVcH7PvR8/e6wp9Pyg==
X-Received: by 2002:a63:5f4c:0:b0:45f:fc05:270b with SMTP id t73-20020a635f4c000000b0045ffc05270bmr21765809pgb.14.1668628958408;
        Wed, 16 Nov 2022 12:02:38 -0800 (PST)
Received: from localhost.localdomain ([103.51.72.182])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b00186a6b6350esm12423950ple.268.2022.11.16.12.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:02:37 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [linux-next-v2 3/5] arm64: dts: rockchip: Add support of regulator for ethernet node on Rock 3A SBC
Date:   Wed, 16 Nov 2022 20:01:45 +0000
Message-Id: <20221116200150.4657-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116200150.4657-1-linux.amoon@gmail.com>
References: <20221116200150.4657-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator support for ethernet node

Fix following warning.
[    7.365199] rk_gmac-dwmac fe010000.ethernet: no regulator found

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: new patch added
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index b848282ea005..5378254c57ca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -260,6 +260,7 @@ &gmac1 {
 	clock_in_out = "input";
 	phy-handle = <&rgmii_phy1>;
 	phy-mode = "rgmii";
+	phy-supply = <&vcc_3v3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac1m1_miim
 		     &gmac1m1_tx_bus2
-- 
2.38.1

