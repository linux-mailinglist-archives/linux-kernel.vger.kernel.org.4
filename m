Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0716C664192
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjAJNWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238093AbjAJNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:22:16 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22B41B9C9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m6so18357464lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gIMoLkP77aNH+efgKowydUwLYRslPo+L1GU+pJJwb4=;
        b=AP9igvSTRyb2W8VjVO+Er7QSZYzIpbV1tBKoAVcbTDRWQaMIsvEEnTsDn0NG0saZhJ
         6LsUm534zOHUKYx6U0FduY1C2sB23XmrLrc16kMDzn764Ej/+keELyJSFLeXPYt15mkD
         WzI2R+x2+/PoXT8djTQ6IQ2+UAkSYSY5+jad5PxFfiLCs1QkoABcCpRUUxRSXNupvkDw
         dqtNjHGZ1Q+Bu/YQ8FEfiDNTjaNodxfqyTlDzlLogf37EhbhNlppgujRBR6o01EvsZ41
         HvvGynAI8YZB85swYgNrr4PkLmE1W5ph2N/H8nAK87C3K+sQpV8hfVXqDZBaWrlWIofm
         9Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gIMoLkP77aNH+efgKowydUwLYRslPo+L1GU+pJJwb4=;
        b=KMRdMf5WfZmVjDbuiQl7rloI9sOWQhbf743tfhSqo/Hf/6P09A36DYKYnOn0boodzM
         KmWlIqXEM95et7LvohxOazGmfU//jpVNyKs1+m0vEXnoouM2uvNnZ+6rhAZL28aOZMk1
         vg2mKMGpRI+iXVB7oxZkbEkMF9ega8PMbiQMdkr1I0SbbQcfIoqGH1Y5CZ3H1lva5joc
         HoAK09/58mmVnOLdeSJ/3lUFOebZ6BVzluTXwWGEIYEm3e5E0JOg+tlUbNAdQveVBPMS
         hH0DblSfYHuuFNPAEZH1NJ629IBvTsVV6QVkyMebgxrPbNZVbwZz3PKwcDRjouQFOHOM
         TCuQ==
X-Gm-Message-State: AFqh2kr++mBDsapVfkJyZSbgII26JNEEvMs1XihypiZnV25NyKkPMdgv
        IES3M2fFI5hW3mOEpdh8C/XNlA==
X-Google-Smtp-Source: AMrXdXvF+/lnLJj/yIhJptSVaALtj/tZt53EmTrLR103q3QsxIQvwQfmHjLsJhITreow8Ah13B0Tdw==
X-Received: by 2002:ac2:42c4:0:b0:4a4:68b7:d645 with SMTP id n4-20020ac242c4000000b004a468b7d645mr15855883lfl.44.1673356934563;
        Tue, 10 Jan 2023 05:22:14 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm2183000lfe.201.2023.01.10.05.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:22:14 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] interconnect: qcom: Sort kerneldoc entries
Date:   Tue, 10 Jan 2023 14:21:57 +0100
Message-Id: <20230110132202.956619-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132202.956619-1-konrad.dybcio@linaro.org>
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the kerneldoc entries the same way the struct members are
sorted.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index eb51680f890d..b75e99fa08b8 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -23,12 +23,12 @@ enum qcom_icc_type {
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
- * @bus_clks: the clk_bulk_data table of bus clocks
  * @num_clks: the total number of clk_bulk_data entries
  * @type: the ICC provider type
- * @qos_offset: offset to QoS registers
  * @regmap: regmap for QoS registers read/write access
+ * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
+ * @bus_clks: the clk_bulk_data table of bus clocks
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
-- 
2.39.0

