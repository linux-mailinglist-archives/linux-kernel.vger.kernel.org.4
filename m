Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B62715CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjE3LVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjE3LVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:21:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA3EA0;
        Tue, 30 May 2023 04:21:04 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7770b7c2fa5so261087539f.0;
        Tue, 30 May 2023 04:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685445663; x=1688037663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzNEbgTraqKA7CFpkPxkOPN8rp70PxDOo72leKajhjw=;
        b=Ba5mRddbGfVE2a84DB1WnQtDqvRKgx1icAnzmN0SKau/ndbCJKv6PdfkX5/ZfV+lcV
         dBhtRy4j4BrX7vc55Di1Q8ldXqYemuUUDfR+J8AefUR+x3K+lyGGIDaEH6A65HAODh2Q
         rQ0psu/1SV+MsHopjK0M9d0KkYqSlqcxMll9ENyMgtJHbJXeuY12doRxFo4RIntHJLLi
         qwZdPYVAcfBiQfA37bxyoJNltECC+YGKiMGdcKhLA2O9Z7eIDL1KgK6ICcAkHCQos/cR
         B4YjYXSSUKp7efI4SYI4O+P5MsKWU37hzqyM3XqQ6pUFq7L7FcXdSTJs1YeFGF3/dASw
         z5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445663; x=1688037663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzNEbgTraqKA7CFpkPxkOPN8rp70PxDOo72leKajhjw=;
        b=MamJTfCJ0ZDr8WxrKHkOeWdRP7n4FSMqzszqVuEXRqaUpvN78XrihhXi+sx/2pUVHo
         qpwGAUhcxkY85386X0wPtCqPIQ5aKuZXFP3HjMRIElzXkBIrI3WEuI/DqYXHTBsv5Khn
         Se8CZWWNIeIO/VxPlthCW+Iqf3JSiv1M6c23/XPRNz+1MCtTnmGhRFQz5wPaCkccQyAP
         c7eSopm80bAhOv+GlmYlcUzDcdNiwwbjI1fcGZLWJdf7Jw5Zpinuk9jFDjpXVtLNqd2I
         IOwxttX8+WsnMoBqcyk3AjsHIdEOAzBVddS1dn4jrasqyUXyZzJD3N39apaqBerSGS9D
         4JaA==
X-Gm-Message-State: AC+VfDyQ2iX7IZHqWUuIxa6SFI3Qg+CHLV52zuJyCB5V9nS8afwc8yTI
        bP5fxfs+/uhYu1YvRja4S2OC+Pl3Xic=
X-Google-Smtp-Source: ACHHUZ47NCmq0gmYRMh0JisBCfwXygYS2+J1oSi/qMi2LJA7nSRi8lG7PZBV2zh0DBk+lkHEGZ6mGw==
X-Received: by 2002:a5e:de46:0:b0:774:8aee:7e5c with SMTP id e6-20020a5ede46000000b007748aee7e5cmr1343664ioq.16.1685445663210;
        Tue, 30 May 2023 04:21:03 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:a5e7:c9e9:bb20:39c1])
        by smtp.gmail.com with ESMTPSA id co17-20020a0566383e1100b003c4e02148e5sm634363jab.53.2023.05.30.04.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 04:21:02 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     biju.das.jz@bp.renesas.com, marek.vasut+renesas@gmail.com,
        cstevens@beaconembedded.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [RFC 2/3] clk: renesas: r8a7741a: Add 3dge and ZG support
Date:   Tue, 30 May 2023 06:20:48 -0500
Message-Id: <20230530112050.5635-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530112050.5635-1-aford173@gmail.com>
References: <20230530112050.5635-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3dge and ZG clocks are necessary to support the 3D graphics.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index ad03c09ebc1f..7e70c9a9affa 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -76,6 +76,7 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",		R8A774A1_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
 	DEF_GEN3_Z("z2",	R8A774A1_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
+	DEF_GEN3_Z("zg",	R8A774A1_CLK_ZG,    CLK_TYPE_GEN3_ZG, CLK_PLL4, 4, 24),
 	DEF_FIXED("ztr",        R8A774A1_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A774A1_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A774A1_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -123,6 +124,7 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
+	DEF_MOD("3dge",			 112,	R8A774A1_CLK_ZG),
 	DEF_MOD("tmu4",			 121,	R8A774A1_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A774A1_CLK_S3D2),
 	DEF_MOD("tmu2",			 123,	R8A774A1_CLK_S3D2),
-- 
2.39.2

