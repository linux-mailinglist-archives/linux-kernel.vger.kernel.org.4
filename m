Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574AC6AAA13
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCDN3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCDN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:28:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D31ADE5
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:28:05 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d36so3868353lfv.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwpdNKDF+NZllqTRGwjUJbvwc53G+1D/9QetVZeUhx8=;
        b=kfBEf9VJHTFaNDMvnQRTXIO1B0LeU/XrM2oD2JTWWo4rG3N9NTkDxVTzXmfpw2guwu
         Bzs6hgAT2aN1l5vuv0viUpchEdWQjGkOFxvZRWJ8e81BtShZNIt2v/b5eny7PD1IaPe1
         BBlBov58NGvVbxK/pM1uaBrPrrY+Een2xG7KIP5kGdrq+isL/MCJJEYvdWRaViCbNqKY
         7WIcth1ZbZxX+vUdmXCn/LHEL8wJ9qqr8fsBN2eHsHzybgnkOvRGaoHU7TdlW8gUy+/0
         /IdAnFEPjgiHW6U2P/wfp9p5h3CdN6GWO77BAUinBQ/Q6sPmo0TQ5TUj1zDKBC+BJqLu
         BVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwpdNKDF+NZllqTRGwjUJbvwc53G+1D/9QetVZeUhx8=;
        b=7XtDjAyx5287a6BU4Zg9kPD94ysj3nddzmvMmHez3xdwI3yzN+2VfS8Gw5HgEfJWaI
         nU12YzJ5C1ANsIMIMl1dMlxs+tOHw3pjquiMDaVC9l3TTZYLhUpzqChh5wR6dKHlOGK7
         j+SyPmoskPolqf8r0g79+74Nq7oEVb+lcSyBebzvHVCgUZLYQicuyHKJm/XFtaxqVZnZ
         LpMuq6Hjq8DQk0a4Sf6Dy42HaIVjMUAHuSMBJDNZbu4f1zyjDhSDdK/HX8IpVrXGZiS8
         pW+5lpZcR4NpOJ8Ov9EHWyeJYcz0qZvqdow1OHgNvEr9X8DfFQmvQg8Gji2z6ccTP3o4
         T29g==
X-Gm-Message-State: AO0yUKVUfG4ta1636Fe1HUCgnjOA2kEzT1EGWoQEAqRpYtaGjMpwcVgf
        qi3gWmn7jgVVH1W6+pDWKoW5uQ==
X-Google-Smtp-Source: AK7set/IArmaG8UGmH1bSO4gYOnkCuJ0LxcNf26GWp6veMhYOODsCFTrDanapwMT/6yHoc0CA0nVzw==
X-Received: by 2002:ac2:518e:0:b0:4b7:2a7:1241 with SMTP id u14-20020ac2518e000000b004b702a71241mr1427849lfi.64.1677936482814;
        Sat, 04 Mar 2023 05:28:02 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:28:02 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:53 +0100
Subject: [PATCH RFT 18/20] clk: qcom: smd-rpm: Add keepalive_clks for
 SM6115
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-18-d9cfaf9b27a7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=792;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9IYygSv7WyUS2mTDxWuyuom5yDq7gjXSU2vpknvMF+E=;
 b=bq+/ReILwYadLeCOWmzOuXbedMdRZAszg/pNUCgkUTbBA4cndH+eBM81EfJPwvN7t43o1nkmOfVK
 3tJQizn2AAyHgW0e6WR5fFELV3OJh01zfTIKK7ellMNWzcH0uuJu
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

SM6115 requires that the CNoC&SNoC clocks always get an active vote.
Guarantee that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index a5171b818d15..c3ab882de7ff 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -1191,6 +1191,8 @@ static struct clk_smd_rpm *sm6115_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_sm6115 = {
 	.clks = sm6115_clks,
 	.num_clks = ARRAY_SIZE(sm6115_clks),
+	.keepalive_clks = cnoc_snoc_keepalive_clks,
+	.num_keepalive_clks = ARRAY_SIZE(cnoc_snoc_keepalive_clks),
 };
 
 static struct clk_smd_rpm *sm6375_clks[] = {

-- 
2.39.2

