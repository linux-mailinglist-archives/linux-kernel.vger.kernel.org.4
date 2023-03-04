Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24106AA9F4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCDN2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCDN2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:28:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7980692
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:27:54 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id k14so7022609lfj.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=537z0uLmwOojkV7vbpXGz5uLHruDuKMlpd8Duz/xgq0=;
        b=Det41a3eucH7/YN0Rqps4kFQ2iOzYSRU4Fp6PLBEiSCdsPCAyvTjOCX5TALmBGs753
         vO3vXdOy6bio1EZ8LvKeaidBhyMOpIgMPCbos54I3GNnAyQh6UbjqH573LF1JZX0wen+
         9yEXTUYvjgOxUkorNc1UM6MA2tBeej6Ctw3tU/WL67MzBZKaeugeHjgG2Oj8i690Fpt/
         PmbPgbsJrCkZndPIX+b1ytiLNApKBXBN87QRWbxwvU0BrQEIZUwymYjDf9iu4Fzb9jnL
         otnvx0c9h4te+SjVOITdsgtb1vCS/0gvVWAPUy1IwT1YGuAPx12VR2FH/+sbSTV0TDHY
         yKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=537z0uLmwOojkV7vbpXGz5uLHruDuKMlpd8Duz/xgq0=;
        b=NiyMkBTGx23SymEL0j8xwB+DhXF1AjG195Kto67Tek0z0pBf9dX3GgMJ5KqLSSk72p
         E7xqHKSOjczfOFdOdtCOsTpqwd37Fueicff/MV6O5ssomEDolYI4YcFwaWnWS5dyn8Fb
         1uPuFGWWZzUnSl8qjNxnwh1l3Y6GQG0FCPupzBHtGXX0ZcAAa1Wb4uAFJo02BhPnhTqQ
         5z4K+H/D3gVP+gQakNOhQgADrLmyhOnalxqQ+VMePaGcRg+JB22bfV1jG1juZzdqrqAX
         eBNbnKJgD1SW8fw+GLSHSfZXBDuVksDJ3GxK+3NFK/D/JRdkS7ECQWZVCua1Z5Iq5qzQ
         Wd0w==
X-Gm-Message-State: AO0yUKVOZL8ST1OdiFlDAoGWqURZOQsNpvUc2PX+3tgRz1/jw2JsSgx9
        lQxSA8fISvOV+p52NbZVJ4fjfg==
X-Google-Smtp-Source: AK7set9uat/8nDpipRcAy7YpJz4aq6S7JTespVqSZxAxB03hsHA92PUA283cLLdYR0DLi5+FayGcpg==
X-Received: by 2002:ac2:55ac:0:b0:4cc:a107:82f4 with SMTP id y12-20020ac255ac000000b004cca10782f4mr1380783lfg.64.1677936474077;
        Sat, 04 Mar 2023 05:27:54 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:27:53 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:45 +0100
Subject: [PATCH RFT 10/20] clk: qcom: smd-rpm: Add keepalive_clks for
 MSM8976
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-10-d9cfaf9b27a7@linaro.org>
References: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=782;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VMhd2HIENFYlcCni6Mim3NyGguSK/hOsSIVrkOLy6+0=;
 b=XtLlcfXHyYFrNA3wN/IrUTEYSMrCP9kRDDISBi7ktP0PcShPDOCnYOrTXPiFp//XfVnvMPNHdeJk
 sGUGvpkVBGsx3h2BwwOCz5ITwq1i6rd1jGoQmZ+JEQ08DbEAPVmX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8976 requires that the PCNoC clock always gets an active vote.
Guarantee that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index a390ec3d6c01..f82576180fd4 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -722,6 +722,8 @@ static struct clk_smd_rpm *msm8976_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8976 = {
 	.clks = msm8976_clks,
 	.num_clks = ARRAY_SIZE(msm8976_clks),
+	.keepalive_clks = pnoc_keepalive_clks,
+	.num_keepalive_clks = ARRAY_SIZE(pnoc_keepalive_clks),
 };
 
 static struct clk_smd_rpm *msm8992_clks[] = {

-- 
2.39.2

