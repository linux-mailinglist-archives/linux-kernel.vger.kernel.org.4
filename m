Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1FE6ECBD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjDXMOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDXMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:13:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F8410FC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:13:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a7ac8a2c8bso40926381fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1682338436; x=1684930436;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQtohBky33MWUdeKOY9B0Jdzwvi92+shTR5B/pXImXU=;
        b=hTVanmBkAGPFQtISg9J3XJ+Tlq36EE9E8yJoC4vcotb1vZS68CHyPzfh7MQQ3KWvoY
         iK5E+RDuVKGBgDraT25L+lP6aRY9vY5TBAPhsDMMC5T/sC1GHjJkFsiQKZ13439Hj1c/
         xYsZUD4g6tqsXZc8K7+UatulGP6AAL6GuPw+/HQb5rXNLRGw/XflGuZhZoIrrV2cGmYl
         t2vD/lCz/2DJDSxV0mIGHUpLhappR9I0zILDu+GTu1RHnryQCdbJgr5+nYEqHYU1iJm2
         wfD1i+mIaW7SXYr5NwaXh0u/cMNmHi59PymlPUg3al20pUR48scVRwUajHgsO9E1V2M5
         Vjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682338436; x=1684930436;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQtohBky33MWUdeKOY9B0Jdzwvi92+shTR5B/pXImXU=;
        b=P3TnlahySk/ziYBpL2Obq6KPR51JxL7E6URH3ykP7dc1gGNNaehY+lvuPqRYYL8fKm
         IPnRELv2ebkA9G9+219aLm1048YfI6lI03Fr5Fwhx1ldjrPvy+/SDZxCM+bzovm8PO45
         1p/48NdLK/KsrCuTrXs0tsmUXHRQMMEopNovniD5iDfiSn0+27BB/fiabnBzfVMMu2b1
         ZgTSuqx0ub4L/fUtEJDLAOmjoFm4wzSRgFzmYHfELZdEOm1SByiThi9fw1W0KfWlX9B0
         zWdMttQ0kR36f6uZlTz0S9yqzGTWJ3cD83T3hLmRlYjmo1FcVN/W3+Z0Tji6UTRu9ETg
         d+3w==
X-Gm-Message-State: AAQBX9dH0Q9UA9k0Xzk9o9m3ZI/toTubfHbfPArYEC+i2fOrmI3FlPF3
        vGQO7IfI7/i2+CeQkEl2v4w3cg==
X-Google-Smtp-Source: AKy350akQ8EciT+C0V8pKYtfqBhPEaEv5XPr4eaKZrvmhqi0oiXoFstBdBYa998MK2ui6b6T+gGuMQ==
X-Received: by 2002:a2e:2e0e:0:b0:2a8:d13d:88fb with SMTP id u14-20020a2e2e0e000000b002a8d13d88fbmr2642480lju.11.1682338436147;
        Mon, 24 Apr 2023 05:13:56 -0700 (PDT)
Received: from mantas-MS-7994.8devices.com ([84.15.37.222])
        by smtp.gmail.com with ESMTPSA id x23-20020a2e7c17000000b002a5f554d263sm1732382ljc.46.2023.04.24.05.13.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2023 05:13:55 -0700 (PDT)
From:   Mantas Pucka <mantas@8devices.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
        Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Mantas Pucka <mantas@8devices.com>
Subject: [PATCH 1/3] clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks
Date:   Mon, 24 Apr 2023 15:13:30 +0300
Message-Id: <1682338412-15420-1-git-send-email-mantas@8devices.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDCC clocks must be rounded down to avoid overclocking the controller.

Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller support")

Signed-off-by: Mantas Pucka <mantas@8devices.com>
---
 drivers/clk/qcom/gcc-ipq6018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 3f9c2f61a5d9..5c5d1b04ea7a 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -1654,7 +1654,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
 		.name = "sdcc1_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll2_gpll0_out_main_div2,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
2.7.4

