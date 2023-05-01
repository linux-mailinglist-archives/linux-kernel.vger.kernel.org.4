Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA86F3151
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjEAM52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjEAM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:57:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B4A10F9
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:57:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f0025f4686so3114900e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682945838; x=1685537838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVxPqZEZqxT/xble5HJfq8Vj9DqelOFd4DLS6YwEQRk=;
        b=qAwu+pVrhIlLgf33SSBK3DoiYgjhCcfLThZcPo0eXws58slERBFYB7TmvXZLNqBbum
         GDigKGjE/m87a2yBWbzTcliEntbid58PWp03W7mC674y6S9p9Z3L/hu3evKT/Ig/m5xn
         E5D2jxk5IoBkNyuycWgmf4JRZsbM2xdRMsHoZQX3rLvWiodt1C2GyzWlFk0R/atiXXXX
         F/sFUOz50S+8FtYsCzpSekCdpzvHPHpE477hJvXJcSq2vtQcpGMs+2uY+ZVYfJzfnPTD
         fDsjqXf+lQ7/+v/5hs70g5iUxRyfh5a5I1BdZtlXIrvNSa1OFK/lViVvL91diGUGjfLJ
         0Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945838; x=1685537838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVxPqZEZqxT/xble5HJfq8Vj9DqelOFd4DLS6YwEQRk=;
        b=LeRyT0i8meVIb4MNT0o7etyP35bgZntwndz0ytjclOwN5Ev/wNttAiUEPDHM0TeuGY
         aysPA1mgpXTCi1lZMzcjZSjOYHbsT+Wa25u1lzXP5akM06jtBdqS62ptHl9A0sH+VsUj
         L6zlXz+6dWbVl1rLxHsuogk0t22C6v2UKctcn41Bs/tmtzbmuWlAL3RF2CtdP1H3KNOd
         k0jLnt93HXTJum8DMKLn3B8vblbR84mvZ8HozYlaXkbHbcef+i0H8zbILRYABSXf0KAB
         3jtOgp6roXf7T8rVrPIFRJBM0ikpeZrsJsKjkvHOrChVygskGS8Q5JJV6timtbpzqLwj
         kMiA==
X-Gm-Message-State: AC+VfDzQhzTeSbt1+Y+NRkbY2Di+QZO8wVBWpHvvQwz2dtnc+cVHh6L+
        gxDH4ATc7Xl/vQuhz+7pMaj7dA==
X-Google-Smtp-Source: ACHHUZ7FWE59lx7yU+Wa2gadJl0mGy4rdJrhFE4r17mW/89mIM8KAeaBV6pHzRuhk32djHcDpc2AbA==
X-Received: by 2002:ac2:4c8c:0:b0:4ef:e6a1:6cc2 with SMTP id d12-20020ac24c8c000000b004efe6a16cc2mr4290688lfl.47.1682945838345;
        Mon, 01 May 2023 05:57:18 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id y6-20020a2e95c6000000b002a77ab1d73dsm58332ljh.96.2023.05.01.05.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 05:57:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 01 May 2023 14:57:13 +0200
Subject: [PATCH 3/3] clk: qcom: smd-rpm: Make BI_TCXO_AO critical
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230501-topic-rpmcc_xo_a-v1-3-93f18e47b607@linaro.org>
References: <20230501-topic-rpmcc_xo_a-v1-0-93f18e47b607@linaro.org>
In-Reply-To: <20230501-topic-rpmcc_xo_a-v1-0-93f18e47b607@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682945834; l=1210;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=l8l7+8uAcDF71yxaJqogJmWLjOCgIdZPw3YgQE8kOBk=;
 b=A0ur+z7Q0fpXelwJBH7Z48fWErgxHPy74GDXgwcZ1IjmPo+Fao6wDfDdxyTt0aiYs8jNGG0gQzEF
 dR2R0BvDBkQ+uhidoh10ufW1jQPXcK8hqKJBTAsxyhWNMRKlQsUS
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

We should never let go of the active-only XO vote, as otherwise the
RPM may decide that there are no online users and it can be shut down,
resulting in a total, uncontrolled system collapse.

Guarantee this through adding the CLK_IS_CRITICAL flag.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index e00889fddc7b..9649f4644d71 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -439,7 +439,8 @@ static const struct clk_ops clk_smd_rpm_branch_ops = {
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
 };
 
-DEFINE_CLK_SMD_RPM_BRANCH_A(bi_tcxo, QCOM_SMD_RPM_MISC_CLK, 0, 19200000, 0);
+/* Disabling BI_TCXO_AO could gate the root clock source of the entire system. */
+DEFINE_CLK_SMD_RPM_BRANCH_A(bi_tcxo, QCOM_SMD_RPM_MISC_CLK, 0, 19200000, CLK_IS_CRITICAL);
 DEFINE_CLK_SMD_RPM_BRANCH(qdss, QCOM_SMD_RPM_MISC_CLK, 1, 19200000);
 DEFINE_CLK_SMD_RPM_QDSS(qdss, QCOM_SMD_RPM_MISC_CLK, 1);
 DEFINE_CLK_SMD_RPM_BRANCH_A(bimc_freq_log, QCOM_SMD_RPM_MISC_CLK, 4, 1, 0);

-- 
2.40.1

