Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D441667754B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjAWGza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjAWGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:55:20 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161B51A972;
        Sun, 22 Jan 2023 22:55:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t5so9830461wrq.1;
        Sun, 22 Jan 2023 22:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OYHf6uBdRg2Pv0Tc1k0a2GUSIrlYLxSnMEevum5bpY=;
        b=KGpeEul2xiba3v1KsjCN8fEMjddcL2wnjP4/BtjA3jfdyeBt10wnp3ntC1kLE8Pxo1
         pI+R/Gl49zXS/ULo6Ell/He88LvhBbXjs1uViXCx8ul+XcyZqRVEYjz592at9ufWB2W6
         VUpKR7pDTkwr5wdj7kimOft3mfu9WugNfdvjM0QNZ6IGZE4TAuG92RCCh0QMrUuLVv3t
         Ztj9A1OkzS3sTNXa6yXUe8lsyIBWbvPqsbMnTY0ucPFg44jA11AMax6Z679wMP4j4v8s
         8rrTN6/RsAQX3YVMRPl6aKBUz6cjdHV00x4gD2b80+ZtMdToHwjXxD/xv9pGgSD5xbhJ
         wGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OYHf6uBdRg2Pv0Tc1k0a2GUSIrlYLxSnMEevum5bpY=;
        b=w7Xwf/P5Qn3IPVp0wFDWj5JViy0usrKL1hn73Q6NupIUrUnHZoJjyZZbqA48b+sezR
         eXn2WyAzjb5MSJA5lS9LuVk7MIk1IlVJfigrdaljLSfMqUTRRUINAoHAfEdnCFKm3rx0
         J2v6MfgtWo9HAKCNSUFQ7jo3gtOaS5oHNtoKtrWKIxgTnIt+DuNfMS/TLSXc68Casr74
         DknYMzeuQavA8AhPHVgPHr9x65SNXzPSLHyVevpoEuCzW24XwOM54Hmxvt8QUJa6ecrc
         3lBsu0xq9llSDhNzXONmqHZZDQDRhgXcB8fqGrD4MaKQQsLgwZN3xCSYpwkCqIBQ68Yt
         aLvw==
X-Gm-Message-State: AFqh2ko992/lzYSMB6YuxkXwPxmUI+K5MPz7AmFQRm2+blnxKu9t5J30
        4G7/JLnc5Ln7Oj5xYcwHhKc=
X-Google-Smtp-Source: AMrXdXsvxNmWMyKXfXak1lyV5JX7ANjEeRxt2fZqd75eEp91UqyI/xjA5bU7YPFAtl3LpapusGTfCw==
X-Received: by 2002:a5d:6e8b:0:b0:2bd:d9b5:8191 with SMTP id k11-20020a5d6e8b000000b002bdd9b58191mr20903324wrz.61.1674456916457;
        Sun, 22 Jan 2023 22:55:16 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id az22-20020adfe196000000b002bddaea7a0bsm25948365wrb.57.2023.01.22.22.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 22:55:16 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/3] arm64: dts: meson: remove WiFi/BT nodes from Khadas VIM1
Date:   Mon, 23 Jan 2023 06:55:04 +0000
Message-Id: <20230123065504.2669769-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123065504.2669769-1-christianshewitt@gmail.com>
References: <20230123065504.2669769-1-christianshewitt@gmail.com>
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

The Broadcom WiFi/BT SDIO nodes are now inherited from the P212 common dtsi
so we can remove them from the VIM1 board dts.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts    | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index bee51e29015b..2f88f78de5b7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -220,21 +220,6 @@ &pwm_ef {
 
 &sd_emmc_a {
 	max-frequency = <100000000>;
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-	};
-};
-
-&uart_A {
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
-		max-speed = <2000000>;
-		clocks = <&wifi32k>;
-		clock-names = "lpo";
-	};
 };
 
 /* This is brought out on the Linux_RX (18) and Linux_TX (19) pins: */
-- 
2.34.1

