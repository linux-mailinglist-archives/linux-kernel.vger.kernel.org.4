Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20422665B43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjAKMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbjAKL6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:58:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9DBF78;
        Wed, 11 Jan 2023 03:52:32 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y25so23119530lfa.9;
        Wed, 11 Jan 2023 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akX8Spsmb8eHc45qxyT07eMq4v6BQfaJuDvgRydNQ0U=;
        b=oZkMOTv8VzItNdeoOagEla1tgEF0wFLmF31sfOgof2//fXwwUxxnP0BYRXJ2pYwZNK
         YMvvL9Uez4P5ApEM2BkEvxg/3eZamx/ft+/VFJ0eVZ8atnAT5vdsV9tglCZJ5t8WcO5f
         mKK4/fQoduWWAPVE1EUHJV2b1WL/23dH+U/7DfLPqdehABg8h4TSC6IVsmf89BndNdmt
         0SCpOhjlrw8VvYSXTkGgGIBx+7y4VEaO/UxMk+UkjRTapOxfmVGDViDjY4kfo4a1BHW0
         HDnjsubkMOB95AszsJFszQmW0mw6TIqJ9ES4VPJHWA6805Vpz2Mo1jr4eOkL8aRbQ9HB
         DwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akX8Spsmb8eHc45qxyT07eMq4v6BQfaJuDvgRydNQ0U=;
        b=djQ+IIsGS6HggsVLrALO/KCI7o5lX9lO+ojssUv1yrowF414Xp4W3eXgNsUlTry7Ki
         6cM6142n4irQZZpDuREvTgh0GjKV3tK/O6gwtTobFJrZH4NKj9xpL9PjOzOzRkMIx8IG
         i3BmCor70+3D49D03JMdMJOOYPPbk2EOVqJ5VJGDPSdARUR1l5X/o8UyeDW7LFyWh49p
         qWNte0+QrNhoCp5DjPRy1VpHurAjwJ3yQ5cclD3d95fHNv6BdwmSjt8eFtWQn5K4I77i
         NzD7FWzzcEEv4G8wKMzooLAkuWLDTLC7LXZb2yjdts6/xK7SGwRyfKb0CmK8JNfspzY6
         Lsxw==
X-Gm-Message-State: AFqh2krJQSE5l1CHd+/zi5OP9hs3CmcxPUf98jT3MMf5/UheNY4jTTk+
        dJKCmXlZ1jct5DRMvGA3Ssc=
X-Google-Smtp-Source: AMrXdXsZ2CI7/xZBxfernCt7RhQ7XRGyHhWU/FBiLhf5qGEAexunzC4zJICg6uyMk70PL9RBXuITPg==
X-Received: by 2002:a05:6512:202f:b0:4cb:ca5:b5ba with SMTP id s15-20020a056512202f00b004cb0ca5b5bamr13375670lfs.29.1673437951291;
        Wed, 11 Jan 2023 03:52:31 -0800 (PST)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id x11-20020a056512078b00b004b5821219fbsm2711185lfr.60.2023.01.11.03.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:52:30 -0800 (PST)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Konstantin Aladyshev <aladyshev22@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: ethanolx: Enable CTS/RTS pins on UART1
Date:   Wed, 11 Jan 2023 14:52:27 +0300
Message-Id: <20230111115227.1357-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BMC UART1 is connected to the P0 CPU UART1. As the connection has
CTS and RTS signals, enable these functions on the BMC side.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 5f9093c58e8c..d8e8fca44c78 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -90,7 +90,9 @@ &uart1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_txd1_default
-		     &pinctrl_rxd1_default>;
+		     &pinctrl_rxd1_default
+		     &pinctrl_nrts1_default
+		     &pinctrl_ncts1_default>;
 };
 
 &uart5 {
-- 
2.25.1

