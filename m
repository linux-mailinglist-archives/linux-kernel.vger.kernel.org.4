Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C767719735
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjFAJjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjFAJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:39:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6615E71
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:39:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f4f757d575so907674e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685612351; x=1688204351;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRvNGrsibEvu6jhRJBq1cBQ4kF2HTrS/VOtbw4oxVa0=;
        b=oJPY1B0tSvI82MXYYsTcHjaCd69oP8/C2oPLYL9IUuIiHqI97BuOG6qIrAR9hYgIXD
         LHSp/oMeX5OSTSqjvwgU8UWvU91sUqzidwpeKEC/1A3cw+cCK0T/34coH7nQDgiGt7mW
         Z2lnNzMFh+nNRBtjNDJvDRhrH2rRn59XpPzqzwzz+N1/TpmU8o6AGhS78klDJ8L+GIto
         tiFPKi6K5gVwAYoNCV/6oEkTI7aEt77KujZLxh9nZCOJzl8XlDBTxUH5yiATR/M03T/9
         Uz+Lgote1m/ev2mBXpLE++WvRRrvdbzEJjYHsX0c52q0TOmDD2vlcFZP85HuUlTKlIny
         lX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685612351; x=1688204351;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRvNGrsibEvu6jhRJBq1cBQ4kF2HTrS/VOtbw4oxVa0=;
        b=fZAn/wQQuMQVUTChbQI/+MttBGNu+F0vhabjlqgVZ6E4Zu5R98juLjPeyjVieP+LTN
         xMCgSf0Mcmha4RawErK4R8MZAucGAVOKZUfeog12++PrjVyAiWM5cV2YgHSfARXZMCh1
         w8GeAJzbMulRUREAkylpNkUmg7WKv8vcY91XAZ3iD9QmXM1jirqbGnpg33S299f+vhwe
         qyWv0D/OeZ2vVDbGBl8E0UkvS6NiMaX0eq7TSjwUvxqe/la7pMW8NLJ32NOmDCSMy8Oy
         VxPxbT9Ixzd9exOWW61Eg4OROyBDEWIFybtkCAkq8tixJ+/c0WYhD+qrwiHxAf1yTMig
         13qg==
X-Gm-Message-State: AC+VfDwIdFtzCAyneeTqvPyRtH+/LZZMKIy3/QakavSki5i6icStr4bj
        ELRKRRAESp6roEKLTD44gr2nnbECURVNJJu1Tts=
X-Google-Smtp-Source: ACHHUZ4wl5eRmVoSl9UH26pnAgkcofTJ38V9G+G3IT8dqT7qVyiM/5Nvy+pDD+XL//satwDo0Gcydw==
X-Received: by 2002:a05:6512:4018:b0:4f3:a763:ccb7 with SMTP id br24-20020a056512401800b004f3a763ccb7mr356822lfb.2.1685612351343;
        Thu, 01 Jun 2023 02:39:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id v3-20020a056512048300b004f3b258feefsm1031119lfq.179.2023.06.01.02.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:39:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Update parts of PLL_TEST_CTL(_U) if required
Date:   Thu, 01 Jun 2023 11:39:06 +0200
Message-Id: <20230601-topic-alpha_ctl-v1-0-b6a932dfcf68@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADpneGQC/x2N0QrCMAwAf2Xk2UC26R78FRFJ02gDpSvtFGHs3
 w0+3sFxO3Rtph2uww5NP9ZtLQ7jaQBJXF6KFp1hommmhUbc1mqCnGvih2wZOVAU4jgvlzN4Fbg
 rhsZFknflnbPL2vRp3//mdj+OHyl+21d2AAAA
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Iskren Chernev <me@iskren.info>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685612350; l=944;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IIHix1miPp0qtL4poKUvHfug4CBiAQj5S40QUBQ09Oc=;
 b=5RhikQiQfI+zL877J08QzRcusiyGzh3STK6XsgsBunSmpZG/FRrazcjiVqijI8nlRuz9Zkql3
 OzKofyptzZZCCYboY2jT4W2Tlc/vEDd2w48En2F4F3MvUXB/BdFZoI8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some recent-ish clock drivers touching on the "standard" Alpha PLLs
have been specifying the values that should be written into the CTL
registers as mask-value combos, but that wasn't always reflected
properly (or at all). This series tries to fix that without affecitng
the drivers that actually provide the full register values.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      clk: qcom: clk-alpha-pll: Add a way to update some bits of test_ctl(_hi)
      clk: qcom: gcc-sm6115: Add missing PLL config properties

 drivers/clk/qcom/clk-alpha-pll.c | 19 +++++++++++++++----
 drivers/clk/qcom/clk-alpha-pll.h |  2 ++
 drivers/clk/qcom/gcc-sm6115.c    |  8 ++++++++
 3 files changed, 25 insertions(+), 4 deletions(-)
---
base-commit: 571d71e886a5edc89b4ea6d0fe6f445282938320
change-id: 20230601-topic-alpha_ctl-ab0dc0ad3654

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

