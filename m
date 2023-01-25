Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0ED67B48E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjAYOen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjAYOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:34:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3D59279;
        Wed, 25 Jan 2023 06:34:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso2180783pjf.1;
        Wed, 25 Jan 2023 06:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33aN1+zq+dtGXTv8s+/MpRCqjJHz2bZNw6EwNpZ5/gs=;
        b=iLozZ3cVYSp4JjjD9M6HZ07Vkkb/GR0WSC4kr5msX83zFWR3GhxNJbFTof2XV64Cs7
         CMv80Mg5SeISZ5NfGCnVc7qmBAdSNRzpkocz/CfHUYboPAjodRwQ3XT+ZidpCMM01NwY
         HUgSE+DkOWy9DpFJuCsRKfyss7rEOzwbM2vk7bGL17bUXWAdzyb8mCRhGbmmefPkqFet
         qZpcDR94XPGje0AbOLa4TGl2dtQZsZjzOqYpl7V7nfSKK4AndZbXLPVkchi8kUlBdvWk
         LKdPaiGLe5yQjMjOz7R2Zrb1Fen25FtqEMVbtMP5tWrD5F/QFOI/MSli1P7psWw6HBwY
         xtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33aN1+zq+dtGXTv8s+/MpRCqjJHz2bZNw6EwNpZ5/gs=;
        b=fagZWamPQ0XApNc1a7p8a52beEqF71jKzhvuYDwpr9AgLFL2qIvxoXc8UXPP7zaBRS
         f7L0JqoKWuWzmv8jUwzCaH3Mm3myQdEpudgVokcDkhikFGmQ2oQjE3bRVQSVzZCrLCWk
         0aQWuhHyyibX2SsycDVQXhYOXXtJHrODy+kkr9StbN7UDncRSstatLkkmhhkSho3zrXh
         PBbHULP29PTCDcGvVHgCPmFRGgZf92j732DtUKL84Kkyq3HsTv+O8LIcLHfO00wYHRoa
         D6aBi5lSwOStbr/zR1MJ9/ke8IGhdNrxci2MSV8hRxQoAgAx0ShW0Kg2i8slMnzqpP+4
         w2Pw==
X-Gm-Message-State: AFqh2krHbFIJ1YmEOl/aiHVAEOj3XAvXKvx8Z7jZCLK0kKiD8v0rrToZ
        9yf4Nr2AR1gVz8iIWbXiLec=
X-Google-Smtp-Source: AMrXdXsY/wVDY6WEukb45cQqDY/MfOUK+zWQCinkzelc/bRkU9wbTDUAVi9BrOqGQ2CrMjFHC3eIpg==
X-Received: by 2002:a17:90b:1c0e:b0:22b:b5c7:4fc with SMTP id oc14-20020a17090b1c0e00b0022bb5c704fcmr19566154pjb.46.1674657272085;
        Wed, 25 Jan 2023 06:34:32 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a1d0200b0022c033f501asm1671465pjd.41.2023.01.25.06.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:34:31 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND linux-next v4.1 2/4] arm64: dts: amlogic: Drop superfluous dr_mode in usb node on odroid c2
Date:   Wed, 25 Jan 2023 14:34:01 +0000
Message-Id: <20230125143404.1424-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230125143404.1424-1-linux.amoon@gmail.com>
References: <20230125143404.1424-1-linux.amoon@gmail.com>
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

Drop superfluous dr_mode="host" as it is the default in meson-gxbb.dtsi

Fixes: f24859bbec8a ("arm64: dts: amlogic: Used onboard usb hub reset on odroid c2")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 01356437a077..70b10934a811 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -399,7 +399,6 @@ &usb0 {
 };
 
 &usb1 {
-	dr_mode = "host";
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-- 
2.38.1

