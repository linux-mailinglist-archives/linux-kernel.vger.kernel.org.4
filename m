Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0F6AA9F8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCDN2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCDN2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:28:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EDC1287E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:27:56 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s22so6999217lfi.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzHrJoW6Kg0rf2Ogvqpc/42443dPzaVDNHAni2oxJ/4=;
        b=IcRE8qR3ODKrmu58TDiMl5f2ZQZ3QTRHNxHytCrqkLg13+9Dl+V0yG1qT00qrHtR56
         gVSVOCKmYpc3mkkoHp9Qf+hEuVKgzLb8gxDnjraE43u6xpK44sL4tEntFKoAPVDchthy
         SNvn3ft3e569ACmECUq6YWgvXlWiO0PTcSq5frE7q1jsi5ct8mDHLDU8dtbX5Y86m39b
         FdZDBE4KV3sX9L0nMk7gbsZ1tx2AEXP81AAYfXjOygBsiFftzONsxgdqUsQO7dIBNxTF
         /nDKuHyjHv9LtZTBjo8Noq14AVcE7cfZk/neQfmfGUlZ8IOwPfyjpSMwAWCv3ApP3+5g
         4C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzHrJoW6Kg0rf2Ogvqpc/42443dPzaVDNHAni2oxJ/4=;
        b=zNf+znwYzVj5bKMJCNbcBPsx60ZpnoUgE1Jt9AICKLlgdqysPOxomYUrCpsdyZdXPg
         HrvO/8q/v13JYYG3ePACc6yQB13hijlhBBJJoEP6VyMf/GFuZYEWMsxur1e6nDivJnbN
         CpvbPgt6KuX2mF4yGJyGPdAUSKepz0tdN8mlrP7HgD7G0d3Umfe/CpciQ+CdRIJ97wvv
         3uKWu/El+0+4rxb9htPgtJIHQKWBqM7YLkk9iE8iMbU5pGBl/CH9JVXH2pIpq4FPgcTp
         Vt543HHVN+I3FUnejFtBZQPWsCsPLpmcVNtEkLqRi7d6ftauC8t5UcQqtaStdNDGwbjb
         +QHw==
X-Gm-Message-State: AO0yUKUKmPT5NejH+FzbattDF9U6qzMowWwdNzHBXB3sVmMTIih0Ty0v
        gkWGHL2j1FuxokRzPmUjhmHDbrjkv35CMq1Ym0k=
X-Google-Smtp-Source: AK7set9N3b4JslDyZpAp61DLEsFU9+2W8DcqF5lk6WMNt2q6Tk1Zm5LhtInJbRX7m4A8/sVvx5iz7A==
X-Received: by 2002:a05:6512:20d:b0:4db:456a:9a1 with SMTP id a13-20020a056512020d00b004db456a09a1mr1507400lfo.66.1677936475744;
        Sat, 04 Mar 2023 05:27:55 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:27:55 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:46 +0100
Subject: [PATCH RFT 11/20] clk: qcom: smd-rpm: Add keepalive_clks for
 MSM8992
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-11-d9cfaf9b27a7@linaro.org>
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
 bh=1lqcxtVFODqNrQVkr7L9/FHGP6fajr4jJzkMd+/yxbo=;
 b=jmGhchc9fBqdxNfNYbBU8b5cLPhdvuQlWApk+nHKNltI3DaXUL12Nh9rmJE6xebmaAngTitVE7uv
 WUFLPd9kCLgnFDVJtj5obJtMt13JsuGc2FRYFgvTGoBtX9rcvnxv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8992 requires that the PCNoC clock always gets an active vote.
Guarantee that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index f82576180fd4..c7c623b258ce 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -782,6 +782,8 @@ static struct clk_smd_rpm *msm8992_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8992 = {
 	.clks = msm8992_clks,
 	.num_clks = ARRAY_SIZE(msm8992_clks),
+	.keepalive_clks = pnoc_keepalive_clks,
+	.num_keepalive_clks = ARRAY_SIZE(pnoc_keepalive_clks),
 };
 
 static struct clk_smd_rpm *msm8994_clks[] = {

-- 
2.39.2

