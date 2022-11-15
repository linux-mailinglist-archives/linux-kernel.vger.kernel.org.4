Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F303F629671
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiKOKzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbiKOKwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:52:44 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9628326AEF;
        Tue, 15 Nov 2022 02:51:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so12819734wmb.2;
        Tue, 15 Nov 2022 02:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6dU/Bx1osZzG21UnwcwV2rTzixGC6UyL/zax73qVqY=;
        b=coeAHHTiZnzhSuWRrVEWJ5btrTlpR33RRLweMGg/vQN0g7FFzx5w4Ts2g+zVBNDC3l
         YOXoy8WVAvgwZ7tq84pptBuGlqbVerWmHCBmkyHDJyRhAFw+16W/Ll6kLL/4ieikpxuO
         uaJSzkG7owP/UzEXpK2BVzvrzdS1chGBtp84iA9oT0BRUPg9D6fqw7Lm6HMxSvuGITqp
         lBQMCmiex4NpwOoQ9HvyOUIQnMw26qWFxvslmkJckg51KBkmGj+hGCXcBH0A/vA/lk4p
         Xoux833W8LBTaIRevp9rgp67JQHkzl4XDnFhethMRdweJIOUDXCoze4iLyKtDmjxN504
         9P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6dU/Bx1osZzG21UnwcwV2rTzixGC6UyL/zax73qVqY=;
        b=ui5vzh09fkeyrEh5xpCFHmbF8eTdlpBICUJqTy9dN+9bj1mvdml6WITRykACxEZYKZ
         WDHTrjNQ4RBZf72gamiuxQPpHuRDzOCiapAijxT23UCRHv9BOCHWE+/0YyWuqan46piE
         dq2A9PVRLzTnv5WZ+yWTzAyqbQPF2s8a+xD/QmS1D1NL7Dq0me9HlTfaiYBaICb3zp8a
         vX6sQ65sboJof2op0K291iMSc4EKfsKuoWB/LiiRkW9BDeVqu/LZVuzvtKIo+JzOlCNK
         wifzVaUPsmb9gZXZnERcC4TB2g1u7m4/XnL/NoH384Po/r52E2/zVdwQJVkK6BmmBQR+
         5OHQ==
X-Gm-Message-State: ANoB5plkIOd+8l8NYwAoWCRVpLMddDF4xw5FczN4YvYRNhd79zHFgDGs
        4yF8CZnOac6DIOuw3EX6YhE=
X-Google-Smtp-Source: AA0mqf5DbSzMeqirjdTo+p/jMZ6gN9pMRHlG+eDHmsb2GaCzMNehiZJUo7UX9/gkkl8dVBvo8+e32A==
X-Received: by 2002:a05:600c:510b:b0:3cf:cfea:904c with SMTP id o11-20020a05600c510b00b003cfcfea904cmr267230wms.33.1668509511094;
        Tue, 15 Nov 2022 02:51:51 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d94a:6345:c378:e255])
        by smtp.gmail.com with ESMTPSA id az9-20020adfe189000000b002367ad808a9sm12210528wrb.30.2022.11.15.02.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:51:50 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/3] riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
Date:   Tue, 15 Nov 2022 10:51:35 +0000
Message-Id: <20221115105135.1180490-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable CANFD and I2C on RZ/Five SMARC EVK.

Note, these blocks are enabled in RZ/G2UL SMARC EVK DTSI [0] hence
deleting these disabled nodes from RZ/Five SMARC EVK DTSI enables them
here too as we include [0] in RZ/Five SMARC EVK DTSI.

[0] arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 27 -------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
index e64f0e5f8e30..c07a487c4e5a 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
@@ -7,25 +7,6 @@
 
 #include <arm64/renesas/rzg2ul-smarc.dtsi>
 
-/ {
-	aliases {
-		/delete-property/ i2c0;
-		/delete-property/ i2c1;
-	};
-};
-
-&canfd {
-	status = "disabled";
-
-	channel0 {
-		status = "disabled";
-	};
-
-	channel1 {
-		status = "disabled";
-	};
-};
-
 &ehci0 {
 	status = "disabled";
 };
@@ -38,14 +19,6 @@ &hsusb {
 	status = "disabled";
 };
 
-&i2c0 {
-	status = "disabled";
-};
-
-&i2c1 {
-	status = "disabled";
-};
-
 &ohci0 {
 	status = "disabled";
 };
-- 
2.25.1

