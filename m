Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB30B7133C8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjE0JkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjE0JkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:40:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B90DE;
        Sat, 27 May 2023 02:39:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f7377c86aso281476266b.1;
        Sat, 27 May 2023 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685180398; x=1687772398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Np2TY4wzluYjw6tvBst2SYU6co+dQh0uK/Q/WT/NspM=;
        b=fQM6Hilq3wWlqNn7ZUh7pa2JPh3q2D1ecibqbwZpL2dseryd4IVDDqU7WPm7Yqayl7
         JS8c6KW0KTxrAjKif0wMTDHuqQuGRpEXA4PnqYbkwJSuYRN7sBt4r7NJNSq7k8VUHg/P
         ZYTNCWgy3BPS0iEY3oS7GkiJaUkujMlZB4EzF+x4O4hr6K7VzfFPm2Nt7mO6Oqrh95m+
         3V4PLk9StJWPbL8yCz5rzQ9jDq0GtCk/frzJexGqAhzu6E4SgvXTesAT/JspksDv0M0y
         JKESjO9U3jAeApv1zX75mKwraMofG7Fl1Lhnrdf8OkucHpd8GK41/O1La/DcodmaXdKH
         kvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685180398; x=1687772398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Np2TY4wzluYjw6tvBst2SYU6co+dQh0uK/Q/WT/NspM=;
        b=kf9uHqodSVwbU9CRfIxgRVGjlXWGOAYlC9s+smuVQONVg2sva7yyUTvZ7plN77jejK
         41eUYpIBPGDuPsa74QgublYU064Di+BEVYuiMLzrdyZ5TKDWmTXkUhOo6CnDOABnzIld
         yUT7041NsC0mpR4e5dQJUzWw4mWx8q8eMn/sC+mkP6z88Cq34p03VLjqGi1Xjo+uaeNT
         D/xS8OrphHdXrVEDXPmh8YyPR8ZcOV9D/2FnRKbjrhTTfez0xqn/QN+Sw59OBz2jLLAG
         gZotTUKjKbaZSSzlT7Dwo0rrnrBdb/ZrHzoYd9yqAsf9GlYTkAh/KapsCremnO0jtysk
         g/Kw==
X-Gm-Message-State: AC+VfDydmE3JFedwf8s+5rV3Lwe8yiCTQBgWpkzdVItlfoAxSL7qHGqc
        495bjtJVMjjlT3395ZhBbHo=
X-Google-Smtp-Source: ACHHUZ6ma5N5Q1VKocHdFAPIRxqCBhpTqxAdCHN8no9X2aXP7GN9ZhXjf2eGNgpvRHb1DN4+mjjaIQ==
X-Received: by 2002:a17:906:ee88:b0:96a:928c:d382 with SMTP id wt8-20020a170906ee8800b0096a928cd382mr4311846ejb.48.1685180397384;
        Sat, 27 May 2023 02:39:57 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id kq12-20020a170906abcc00b009596e7e0dbasm3163623ejb.162.2023.05.27.02.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 02:39:56 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] MSM8996 Pro CBF scaling support
Date:   Sat, 27 May 2023 12:39:31 +0300
Message-Id: <20230527093934.101335-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.1
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

MSM8996 Pro has a /4 post divisor on its CBF PLL instead of /2, allowing
it to reach 192000000Hz on the lowest CPU OPPs (compared to 307200000Hz
on MSM8996). Add a compatible string to differentiate between the two and
handle the different divisor in the driver. Finally, add peak bandwidths
to CPU OPPs in msm8996pro.dtsi.

This series depends on the following patch series:
  clk: qcom: msm8996: add support for the CBF clock
  https://lore.kernel.org/linux-arm-msm/20230410200014.432418-1-dmitry.baryshkov@linaro.org/

Changes since v1:
  - Patch structs during probe instead of defining new ones.

Yassine Oudjana (3):
  dt-bindings: clock: qcom,msm8996-cbf: Add compatible for MSM8996 Pro
  arm64: dts: qcom: msm8996pro: Add CBF scaling support
  clk: qcom: cbf-msm8996: Add support for MSM8996 Pro

 .../bindings/clock/qcom,msm8996-cbf.yaml      |  4 +-
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi      | 51 +++++++++++++++++++
 drivers/clk/qcom/clk-cbf-8996.c               | 10 +++-
 3 files changed, 62 insertions(+), 3 deletions(-)

-- 
2.40.1

