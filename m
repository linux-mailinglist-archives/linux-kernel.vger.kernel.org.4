Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7E67B489
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjAYOea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjAYOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:34:27 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B03A474FD;
        Wed, 25 Jan 2023 06:34:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c6so18057967pls.4;
        Wed, 25 Jan 2023 06:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrcqHhD2+Ap5Bl+Zx7RGd/oyh/FJKuuqv3NrFr1ehPI=;
        b=T3Vcjhc65PvnwPdOvVMdP537WTnKC/4/Zs+KRAqYUpgxDnrvLOs8lvAhhPJearG22I
         Jp5oCQxq+caTVBiORxqcsP1xMq3odkKCA8EYX/yT1Uu4nrQqVoHOaws2XtSGMbfMZkf3
         Y18io59HCN1/z6/e9b/Xe7evfAb8CXZGVf0HNU/irgQE4CJiuoJpwNu8ZabPVw+T0kdq
         7trhJAQpB7QBQqT99nLZxQ8e8+Ue33ccaBDnXNUtbjMDhloH7nF3H0sro3fzAlsmMyMM
         Z1GN5Z1HvJkaghjuY8me96YaWhGHKe0o6OzMBfsdOFNK1Ex5eQbX+f07LSXP2O43oxNC
         IPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrcqHhD2+Ap5Bl+Zx7RGd/oyh/FJKuuqv3NrFr1ehPI=;
        b=UykiIuyWreH4akF5GPjDug9DQ0phocvvhiq0NQNB83B9DArwRcakzbWlKY11nDkiSx
         oTPJlr25a9ZBONink+Jzc/XVfInt14UloE0wkLAKMnUR9QG426k60NPiTNIWiB7JxKGM
         PxXIbc7PYGtaBBvDRZuvok6ELZ9D9pJKU+iNtplmJf2yEBm3uGv/MgQ52pbbDKbG9FsK
         5UUvOqh6hMQYcvvC5AF4hzCSwJ2N+EYDA8IYrjB7JeyToCyhIcM9bS6R03kdw6gKMI4I
         BrxD1FQXvSKISlCv7Vzd++i95MFiiIVpd3RYlJwewqd7g+J07PmhAYV67vB1Vmu9eQgW
         gLIg==
X-Gm-Message-State: AFqh2kphQiWwuBM3GDKDxH0nY6FtLZ85jGl3VDUGTNmJO+w/7Dm6elof
        4LCVwF7Wo92idsHgl656uEU=
X-Google-Smtp-Source: AMrXdXtmZGqoIl3PwSb1E7JjrUVeQ6HTRjR4Et4uIXnw29k7/PuDIMpEl6hK1SmZaC6aNADlfw4Rmw==
X-Received: by 2002:a17:90b:2347:b0:226:d727:4045 with SMTP id ms7-20020a17090b234700b00226d7274045mr34087769pjb.24.1674657265929;
        Wed, 25 Jan 2023 06:34:25 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a1d0200b0022c033f501asm1671465pjd.41.2023.01.25.06.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:34:25 -0800 (PST)
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
Subject: [PATCH RESEND linux-next v4.1 1/4] ARM: dts: amlogic: Drop superfluous dr_mode in usb node on odroid C1
Date:   Wed, 25 Jan 2023 14:34:00 +0000
Message-Id: <20230125143404.1424-2-linux.amoon@gmail.com>
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

Drop superfluous dr_mode="host" as it is the default in meson.dtsi

Fixes: 3325f3e4534c ("ARM: dts: amlogic: Used onboard usb hub reset to enable usb hub")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 941682844faf..1097b35b7a49 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -368,7 +368,6 @@ &usb1_phy {
 };
 
 &usb1 {
-	dr_mode = "host";
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-- 
2.38.1

