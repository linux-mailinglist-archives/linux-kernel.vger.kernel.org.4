Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941FC749C2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjGFMog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjGFMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:44:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E71BF6;
        Thu,  6 Jul 2023 05:43:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so83382266b.2;
        Thu, 06 Jul 2023 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688647431; x=1691239431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6EAhfoDoZ7HkHH1SwMxSyZ3vEbeVt8JnBzyWyltbvA=;
        b=SHIlpUmdIA1NPXZQytetO4r5UBIkepMRPvLol3I5uQMdv2k0o0Gs4ux3QWny4mAzJB
         mXiqEAuuKCsmvwNuj6b3Pr8SR4hjdMLJi1eM8RtceGZqTTXsIO8U82Yy8gs8CkVGCwcf
         zzcLVmREnciYtEyGBhcetIuMInUSpMbePHUNqI9ezscnm5GndzeluRZX8Vqhne26uAEs
         WewKsdCHEbJRnaMepFxmYb7J7s5Mdi9tA0M9QCCK9xmB1frf83PD6BNTEMaiN3+Wx93K
         VzkDCkPwfAUGnxit3RctHRmA1eMJa6qbWuJbGlTetk21AE/wmMwIRk5MDDdh8kJvl5Wc
         vY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688647431; x=1691239431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6EAhfoDoZ7HkHH1SwMxSyZ3vEbeVt8JnBzyWyltbvA=;
        b=ZfpBW7WQzjhKNeqtGstZZaRaARMH75Q3PIXaZsus/fGSlztizY4r6Ts8oSxvOhP4ze
         zoLYxdAGMXli7NtihL23b4AmdF2lpI/GsuRZdcFCj4Wu+9JJ17Ikzl5meycJ/Y7poxGT
         7csP4umPfIFu99VhxJL57B8rMZwbTQuBmUEFDElUZSv99YRDlZIF5tpqw4PUSLx8FWPv
         cJdJlZAZyAD/Hwa1XGhnjVMeB1iDNIt+1tjVNafMi1c1FLhJ+s3ImddkZDdLdRJDBMux
         gyifkQ7tav2T1TXB2pNZvftOlFZhw4IKJkXyqpSvYHozb85SKk2LN28HKnBMMGe1zIvR
         B4Qg==
X-Gm-Message-State: ABy/qLZu0Up5eJfp8kL0rHLYMJWnUzAm2Q0VsxMvXU5g3L8AvLqjit/z
        iplhbkH0FQOekz85xmDitJc=
X-Google-Smtp-Source: APBJJlHLASABTYt85CbYVDtNv0qEPcoks80q3a2BO9Q+bkYGR0gPDmi58Sh5pCOPjPGMKuY3OGXRYw==
X-Received: by 2002:a17:906:101:b0:987:16f5:692f with SMTP id 1-20020a170906010100b0098716f5692fmr1252897eje.44.1688647431500;
        Thu, 06 Jul 2023 05:43:51 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ipbcc3a9b0.dynamic.kabel-deutschland.de. [188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id w14-20020a170906b18e00b00992ca779f42sm775915ejy.97.2023.07.06.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:43:51 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v2 1/7] clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
Date:   Thu,  6 Jul 2023 14:40:20 +0200
Message-ID: <20230706124339.134272-2-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706124339.134272-1-davidwronek@gmail.com>
References: <20230706124339.134272-1-davidwronek@gmail.com>
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

Set .flags = CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
didn't update its configuration" error.

Fixes: 17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 drivers/clk/qcom/gcc-sc7180.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index cef3c77564cf..49f36e1df4fa 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -651,6 +651,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_5,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
-- 
2.41.0

