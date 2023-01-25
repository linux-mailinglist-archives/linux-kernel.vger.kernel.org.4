Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4270967AAD3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjAYH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjAYH0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:26:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622D742BC3;
        Tue, 24 Jan 2023 23:26:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so1148334pjb.2;
        Tue, 24 Jan 2023 23:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33aN1+zq+dtGXTv8s+/MpRCqjJHz2bZNw6EwNpZ5/gs=;
        b=K2lG+yw0+Rn6HcVYC5tcy2hi01zXkQR8wEQ8EtBH+ci5XWX1kwN/xDtFkP0gic6hnz
         DiuqBgJFXze6HxjSwJmstn/oVyZS81IG9OJM12dsBCVs4omtw0f2e4lCFUD4HJ2R+0TP
         1yyIHxfjLvBu3Nrk5ME7ov2C+xKSMvjixQkr5OOyVcoRNpYnWYyuacuxFDLBTgvEocf5
         4KXXgtqQp5SYI8JQVyldut7JI3pyh+Q5bRzgeTKd0oJnUMPT9/qR/jdo3Kl7n6ik3Bq2
         RiRQw5N81/oZqnU7c3kYHHuuBjwnNxiBPORaV/AG8bxjhTUY493BK7Khj9S0NigZDlhw
         9lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33aN1+zq+dtGXTv8s+/MpRCqjJHz2bZNw6EwNpZ5/gs=;
        b=rGMtG3j+7XmpZlt4cIR6kuAuX4QIypy8cETXw8GoXUlRRav3ICobSV4K68APnb6z6E
         nzGDzds1Sth4Di33XBuUCQFbrkdaoyPtdE8XwH3dsoC9FCWm9jsfAE1Jz380wPLX2/lk
         2towbuMW7lM/C2AgtIXiTpzUxUP4YlqZyfac0g3CnKnNqCKJGrQ9WGQRr9l+bfcjYlvX
         RX7vOOUyD85zDnuyo9w+jS1iJniXqPySsaXd/lbuzNNOSWcFlJwMLe1Uk+LENPoDV1PG
         EFJ2CbRhdQEiQ1SJL/lJ5djcq1P71n77Ql/Kr1fTr8whqqcpQnQda/FPB1OI23+A8ELk
         Ddow==
X-Gm-Message-State: AFqh2kobIHhYMXDjZLi2D3/r+K99goKS6ym0lQr7pbkeiRKPWiCeo7tq
        jzvCzY1eUL0U5wK+G/w/L+s=
X-Google-Smtp-Source: AMrXdXuEqM7PC1bfJVNeUa2SMWHmqUNQrAShciI8bsA0cRfhoxLrHrqtQCFj7/OdJfUKwiui+C605Q==
X-Received: by 2002:a17:902:9b8b:b0:192:50cd:97e2 with SMTP id y11-20020a1709029b8b00b0019250cd97e2mr29898777plp.26.1674631591901;
        Tue, 24 Jan 2023 23:26:31 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001769e6d4fafsm2902500plf.57.2023.01.24.23.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:26:31 -0800 (PST)
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
Subject: [PATCH RESEND linux-next v4 2/4] arm64: dts: amlogic: Drop superfluous dr_mode in usb node on odroid c2
Date:   Wed, 25 Jan 2023 07:26:02 +0000
Message-Id: <20230125072605.1121-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230125072605.1121-1-linux.amoon@gmail.com>
References: <20230125072605.1121-1-linux.amoon@gmail.com>
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

