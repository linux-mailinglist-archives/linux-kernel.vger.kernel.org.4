Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6E37189D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjEaTIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEaTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:08:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C718101
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:08:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4f3ac389eso5961381e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685560097; x=1688152097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPuFw0npUksRN+4mHiT4+56P5P3V/hniye1VhYDyU0w=;
        b=Sis4OrHydMo42fDcC44TNHJSZKzjTozD2PehkgwML9aetns/dUYYzGIf1Qa8o1JVPj
         RYoMxcF5ZeRmGtlGvdXuj7+p5UhvySuI5FJKpxyaw/GQVC2Zi9RqLV5bmSWUr6X4Otic
         AuQAzmpmPEhSyWrw6fj+D+tVIqH+se18LmgLC9iyGzRjWdrM9RnxjbUQMHijqMsFJF6I
         czVSLXcKnzR8Z5OK5M6gN91vprEid4mvTafmKxm68QRScuITBageropUGdMkgtQv0qdS
         xAOkzlVBZkuDsxahwY7EIogMOXrh3tYAeVM9s80BfXuDTsYmuS86iWJtcZjgqageq+mO
         efdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685560097; x=1688152097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPuFw0npUksRN+4mHiT4+56P5P3V/hniye1VhYDyU0w=;
        b=RxWX4RQ3cyjIBk3V42eC8wIaW0ibeYemZU3SzBumDdioCqRH+bMoxPJ6aHS5xyiRKE
         gjD7oiDvBOWmJIcj8qQWAYj150Z1bZg21wkb61HI62tSWDB6xzuc76oIyGhoXP9QnXLF
         2IRDjv62BegtXfy/4jHKAj+z9Qt9RWEdPV6jwlsW8qSVx2ESJ7UFOOhS1CBzHNmS5euC
         nJ9jFa/MkK3gqRem9dDHk8ebc/DzjUgVaqmvqv23oaHU3sdyIguIcSyCueMz6JxgP7nk
         atHkol/HzIK1rr2H3spo7oz7aC7W2PwIAc17fJeYfWe1nwgdRulIxoZRTVpHPN7gtYMI
         Wm3Q==
X-Gm-Message-State: AC+VfDw0pUhhxoV5UYBGEe5E3pVE17J6EgGkDmIJNFEs6ocbikipff+y
        VV3/s0hNlHrphJ948pEhJRbdyA==
X-Google-Smtp-Source: ACHHUZ6RcarRYJQYAJ+ZB8ZpJbC+zZY8v6u8a9s9Q5JOBscTZYIYJt1oSIbiESaLT3mFfYsPuK70RQ==
X-Received: by 2002:ac2:5ecf:0:b0:4f4:deee:efaf with SMTP id d15-20020ac25ecf000000b004f4deeeefafmr36163lfq.4.1685560097279;
        Wed, 31 May 2023 12:08:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id i7-20020ac25227000000b004f3b4d17114sm820935lfl.144.2023.05.31.12.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:08:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 31 May 2023 21:08:11 +0200
Subject: [PATCH 2/2] clk: qcom: gcc-sm6125: Set up flags on GPU mem_iface
 clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-sm61125_gpucc_flag-v1-2-f59dd1350781@linaro.org>
References: <20230531-topic-sm61125_gpucc_flag-v1-0-f59dd1350781@linaro.org>
In-Reply-To: <20230531-topic-sm61125_gpucc_flag-v1-0-f59dd1350781@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685560093; l=841;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IEG6edkTJ6CWQJbTd+SqBb7jA9qXN5DYOo46+SWTNaQ=;
 b=C19QIJ+cMrTd9aUbcEfcX7gO4fZN0tbV+8Qndittoq8YWiKVMg+cUu7mjFqSCAP07aPGlVuRq
 WrMx8gJV6FPBW5R6bEnOoHnXJRcllaqXvIZajXBNn+G4y97mY8y0ZK5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the BSP, disable the RETAIN_MEM and RETAIN_PERIPH bits on
gcc_gpu_memnoc_gfx_clk.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6125.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sm6125.c b/drivers/clk/qcom/gcc-sm6125.c
index 40ad062d1bf7..ea1d567c7994 100644
--- a/drivers/clk/qcom/gcc-sm6125.c
+++ b/drivers/clk/qcom/gcc-sm6125.c
@@ -4162,6 +4162,10 @@ static int gcc_sm6125_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Set up no PERIPH/MEM retain on the GPU mem_iface clock */
+	qcom_branch_set_force_mem_core(regmap, gcc_gpu_memnoc_gfx_clk, false);
+	qcom_branch_set_force_periph_on(regmap, gcc_gpu_memnoc_gfx_clk, false);
+
 	return qcom_cc_really_probe(pdev, &gcc_sm6125_desc, regmap);
 }
 

-- 
2.40.1

