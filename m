Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1686FE23F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjEJQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjEJQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:18:54 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABBB7AB2;
        Wed, 10 May 2023 09:18:53 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33494fe24b5so41303545ab.0;
        Wed, 10 May 2023 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683735533; x=1686327533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=voV7s248E7gIvbug1lZfTIuQben9sdww3QQZzGmRsFk=;
        b=XYEPZf0tfHEEexs2ZzM5vTzkNgJ6QvjxLjn0g3k8Mja50uGvOiDT5PWAQyPXYTgL4Q
         4Ow7rATx11mY42MgJ7z/zPj1bsKL/usl8PDFd7oAiXQA0HptpwAUHVsDkO1/iSMDrfxi
         Y4XNPzuuhKECiLHyZALmihESnIPaOWbSoaMmM1HOef+v7gZt45R8iy2I8zTdoF2Sx1Zm
         4sCxgtMonTNmP0mYa7KYZ5MpP2b1izXtOOdPI8sz4qvci0F1H1UG1nxWecaC1IU8s9xr
         jSXwf4AohepvXRg9ispxW0MhHvlFeJxzqDnwXWUAmByqQpXOwbWldQicQSulLV27fczt
         Hmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735533; x=1686327533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voV7s248E7gIvbug1lZfTIuQben9sdww3QQZzGmRsFk=;
        b=USVWHcPUkXKIKa+DHt6GR/xb6XztPmrg3dngnV58T2mnlKvnVAIn41R/R3Xitu9ggS
         IyEVDBBfAfjUrRjtSSV9YearALRvSQ+azN7z9wQSGF0aJ4dv2iasY+m79Een1aCBwBYQ
         EuCBI2JqkXHzJRHyv5sPcewBn/gd1LrPh7EaobZeMSMrNHm7woX4ceShlDFohFoZ4tx9
         GBX53ydkrSI8pQIURcD9X3LT/YIWtVHxCTMIJOCPq9jrwLW1tA6KjDd/24PCnMRqT2Uo
         23MSPPcF5MNL8NYOoVW1Ts+JM1UGVL3JU8hro0Sz9MnqhAaOcSqZLXllPV6+ECjYF8ld
         1K3g==
X-Gm-Message-State: AC+VfDxQofALxYHjNu8RXaC2dftb+xM54Qxh6j9sbqxFnyfRzGO7gxu4
        T1mOePQoIRQMIGV/IpuKp7zR9lcstEv9wQWE
X-Google-Smtp-Source: ACHHUZ67bHjT+fSIecYQ6lhHmzt9xA6tcO8lP35mP2lEwHtEgEFR968NAIK3gcbaaPTDf0JlDcPvYw==
X-Received: by 2002:a05:6e02:78a:b0:335:b047:3f62 with SMTP id q10-20020a056e02078a00b00335b0473f62mr3288918ils.10.1683735532649;
        Wed, 10 May 2023 09:18:52 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id b24-20020a05663801b800b00411b6a4ab7esm3539427jaq.93.2023.05.10.09.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:18:52 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix button reset pin for nanopi r5c
Date:   Thu, 11 May 2023 00:18:50 +0800
Message-Id: <20230510161850.4866-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset pin was wrongly assigned due to a copy/paste error,
fix it to match actual gpio pin.

While at it, remove a blank line from nanopi r5s dts.

Fixes: 05620031408a ("arm64: dts: rockchip: Add FriendlyARM NanoPi R5C")
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts
index f70ca9f0470a..c718b8dbb9c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts
@@ -106,7 +106,7 @@ pcie20_reset_pin: pcie20-reset-pin {
 
 	rockchip-key {
 		reset_button_pin: reset-button-pin {
-			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
index 2a1118f15c29..b6ad8328c7eb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
@@ -134,4 +134,3 @@ wan_led_pin: wan-led-pin {
 		};
 	};
 };
-
-- 
2.40.1

