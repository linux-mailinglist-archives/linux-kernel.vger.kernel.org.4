Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B71659309
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiL2XDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiL2XDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:03:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A25C13F83;
        Thu, 29 Dec 2022 15:03:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y8so18470066wrl.13;
        Thu, 29 Dec 2022 15:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1AZ5G8QdvwsjRXOP4YGY0iwqvUTHtMnrEchm0crWkw=;
        b=OrNOIe5F6kwD3gvBb13uLI1jiPKI7ZhRmfv2ONO+sPyfEHiG3dBVd8BchL0itwUYUk
         6wnI+GOa5NeqF9eAT7M5IIW5J4fztW06SmyP+5oDard61Ns62R0MP2mSJoz2c57MrE/S
         Tq7vrEduhs3Kk6rPtHtQ+4+lFk+7vnnljUHjsu5+AWrtYvj+L5hJSwqO8tcvpRsHK6GV
         Ur08RUkqMM7TflssQZWU9ScAKOTUzmqUlJbsMwj2oHV3d1RFCCbtY8AZ8Wjx8zaQqbXt
         1idm+2bIA4IwVz+hxEnvNdiBHvUWh96VxI8Jt/pC754z6YUEe3VbwaFhBBdjqwNVp0+W
         F7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1AZ5G8QdvwsjRXOP4YGY0iwqvUTHtMnrEchm0crWkw=;
        b=hAraNuekXT4pfSTkCUygiFIqNCHwJTCrlTtCT0NVkeqicJnwTZLWm2tVIq1kOmgDdh
         gTeXEGHexNF0WPo88dTgt7K6e7WxsNjWwPzwBt25q7Ycel5ag1v6uOBbe5IiW8Am6F+k
         9vwNGmT1NhJNqOphAKMnMITmXnPxNkGyAPPndAYW0x651V5qNYR/pkQmFp5UkkgC0XZY
         F+PKHyrbU+gOyZpogcvqw0stDSaAC3Qcqf3MB8xc+d4Qt3aGoQ1/bGrV/l05ZgfLtZsh
         lXXj8U+QrPKzPfYdWF7i2z9fo8CI9HSMnYzRoevDeoq725/E07m92oN7LAej2d5noRzm
         wAKQ==
X-Gm-Message-State: AFqh2ko7WDZfPLhDFx9PVq0iIq8wMSd7yp03/M8zimtmp2cmXoa1vpRQ
        uoXKAMTnSvjgd8l+bah2n5Y=
X-Google-Smtp-Source: AMrXdXtFEYvWXlgWHpUtQQSJ9uFe1qiaXPSmpUChY+HKun8x4LG88d8sQabX63FNkBzy4tffYEvyjQ==
X-Received: by 2002:a5d:484d:0:b0:27b:45ba:3b53 with SMTP id n13-20020a5d484d000000b0027b45ba3b53mr9467197wrs.12.1672355019974;
        Thu, 29 Dec 2022 15:03:39 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:88e9:3a08:4328:85c4])
        by smtp.gmail.com with ESMTPSA id b9-20020adff909000000b00267bcb1bbe5sm18995683wrr.56.2022.12.29.15.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 15:03:39 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] riscv: dts: renesas: rzfive-smarc-som: Enable OSTM nodes
Date:   Thu, 29 Dec 2022 23:03:00 +0000
Message-Id: <20221229230300.104524-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

Enable OSTM{1,2} nodes on RZ/Five SMARC SoM.

Note, OSTM{1,2} nodes are enabled in the RZ/G2UL SMARC SoM DTSI [0] hence
deleting the disabled nodes from RZ/Five SMARC SoM DTSI enables it here
too as we include [0] in RZ/Five SMARC SoM DTSI.

[0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, without patch [0] clocksource-switch tests fail on RZ/Five SoC.

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index 318a584be341..43a74c8a4321 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -28,11 +28,3 @@ phy1: ethernet-phy@7 {
 		/delete-property/ interrupts;
 	};
 };
-
-&ostm1 {
-	status = "disabled";
-};
-
-&ostm2 {
-	status = "disabled";
-};
-- 
2.25.1

