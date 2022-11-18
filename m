Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC962F6AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbiKRN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiKRN5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:57:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5288CFD8;
        Fri, 18 Nov 2022 05:57:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id cl5so9355136wrb.9;
        Fri, 18 Nov 2022 05:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWeG46+stoyqg0DxeWDTE3Ia6sRtYUvD/f2AC43whrI=;
        b=UBy2pMwmY0F9TprKdzF9+oHmuDyYef1NLk4176juESl05IbLKp/9GV1uvwNyE05eZK
         Z+p4UqW4trGX9r7dbmMuBuftaRQ4LvECgbAC/ityZUzukli41iB650dYXFJgH1YVEbw3
         anilvPdoIUHL+/519Z4dn9g5IfQiiRtLNH4AmNo9+rZS/xdn2l6s5OlKa7Et9KiQ6ulO
         wg/8YoszXR0Tuer9L5IYFieHON2rjcYFY533+oLLD4OJnogLo1dw8T+LrUog6HLoC0VC
         LwD7qSPBu5dMc26l8lV2VfWN+AqetNatAGJVeor5LCkDBvhY2c3wSb8PyU0NMXaTUTdf
         SmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWeG46+stoyqg0DxeWDTE3Ia6sRtYUvD/f2AC43whrI=;
        b=SoZQO8rtK0JodtzgGNUrBBDhRDE33UnfjvnNJosXOOYCzkC5HKMFQSBeC2OwrPo6oK
         AOU14YWjdVz064zsHP7E9Ts3vYNxU4ebUJvUgn9CF39HHmnGpIFnRDGL0YtN6Ftx5laF
         0Qyt/GcVpOrR30qGtF/Npaw0RbR2wvRXzwyaP91DWQMOZCO2G3FzeGlTArbiJ97td8Xb
         za9+1V5jz55phCBe87Lyn6Nqb7ooPeTDojlh6v/5YQp2aSYhG4E2FWa0ZAN3R6GRN3z1
         s2qdPF14xJiraOtE4Q4iq2gdrLejoLKd03gen2TpFAtBwkG/NiQvIPkVfOCmcSP93qy0
         EqdQ==
X-Gm-Message-State: ANoB5pmrJe//2TVLLvx02xre+p7hDD78Dk7Cmi66uCQ57Bl/fRnHtlEM
        dxFn0xLSYhpn8sm6H20+oe+pvLVPz4ogFKnq
X-Google-Smtp-Source: AA0mqf5ExHBrb9jNKEdMu558qiVQsc11nUOiP0QaPE81UIhiHekyMevzM8kLNpjwRinrrCouduOJ/Q==
X-Received: by 2002:a5d:6282:0:b0:22e:31a4:2323 with SMTP id k2-20020a5d6282000000b0022e31a42323mr4368273wru.691.1668779866301;
        Fri, 18 Nov 2022 05:57:46 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:29e1:fee9:75e6:d6ea])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d604d000000b00236695ff94fsm3638491wrt.34.2022.11.18.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 05:57:45 -0800 (PST)
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
Subject: [PATCH] riscv: dts: renesas: rzfive-smarc-som: Enable WDT
Date:   Fri, 18 Nov 2022 13:57:15 +0000
Message-Id: <20221118135715.14410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable WDT node on RZ/Five SMARC SoM.

Note, WDT block is enabled in RZ/G2UL SMARC SoM DTSI [0] hence deleting
the disabled node from RZ/Five SMARC SoM DTSI enables it here too as we
include [0] in RZ/Five SMARC SoM DTSI.

[0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note,
- For the WDT to correctly on RZ/Five we need a fixup patch [0].
- Patch applies on top of [1]

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221117114907.138583-2-fabrizio.castro.jz@renesas.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/log/?h=renesas-riscv-dt-for-v6.2
---
 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index 2b7672bc4b52..fdfd7cd2792b 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -41,7 +41,3 @@ &ostm2 {
 &sdhi0 {
 	status = "disabled";
 };
-
-&wdt0 {
-	status = "disabled";
-};
-- 
2.25.1

