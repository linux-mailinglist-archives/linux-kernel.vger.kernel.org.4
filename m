Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02F86AAA11
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCDN3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCDN2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:28:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14DE1ACDE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:28:05 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bi9so7053150lfb.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOriah8CGt+wDocjqhLOrYXq452xc5Pi+fEeXp9fgS8=;
        b=tiYbTRQZGVqm467Aj4oeega4VpkInq7di1idcSuPONWc20j9glNSC+zFMeMmrlQ2XS
         BcLH0v4VpcVq6jh9r9v3ryWItNx/IxiR9ZsGhDi8XgWaY0eLR6Db9lDKFo3u2SMuiWXI
         /bk4bEdC93sFqLxU0rupitkiShUgNpT1gJA1N3IEAAphdmYS1qVYy+a7dOhQYcU8c/nH
         tjAqELfRYFr6lVuZD3wgVwJhto6GpHF+Di2AK4qvrYbtd7R4mqd/GtNKdaJxD0Zimv8z
         CWHBVfiH+BHa/Q5WHsqgdMWAfUnHNqiH7kEuXY16ovV7n2YpX9kzlej2w2VFMIZtyalu
         z2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOriah8CGt+wDocjqhLOrYXq452xc5Pi+fEeXp9fgS8=;
        b=0Y9/XzuolViwc4ZtqDu6RWJDh6sxxrFpknmarr/99To5lNmXMZd9ELgmohHjwqL8T4
         YWSxYfyTDO+Ij4lLP911XWJPRQgv5HeHaPeF0G5g1nPgRuNG4lISix7RjX6x8CFL5YOM
         bSSeE8Efp7IJPykQfmSa9ZPPY6XMFHIl/pcLZdBHo23u+uq6NbInu9kpR9d52bzle5rw
         0TILq+pg26fXSQlXOsTWqGm0KfZvtccKi/Wc9KRJ20Epoy3a0FmpSSlyGuW6NIgRgMLc
         8HE0KSt7S/EGQDOSSsk9GV/YeKGRY45eGe99eQcbKfioUCrwdllQjvfoUSRq9RxBB5SL
         35qw==
X-Gm-Message-State: AO0yUKXmojLuDKktl8XJ/y4TEZKGfhytC/3CwcsQFvrNtcgYylCBYa56
        ZS9ckluDyQJ4RvkRrrzBqWPDPuOuaQiFqVGUUAI=
X-Google-Smtp-Source: AK7set+uhvc/id/nBQp33+BPz/ixczFmnZrXi4qXutVxg2FabCyWbt1RqcFCziJutJ7FbDDXl3TEXg==
X-Received: by 2002:ac2:4947:0:b0:4d5:96f3:61a with SMTP id o7-20020ac24947000000b004d596f3061amr1229303lfi.6.1677936481680;
        Sat, 04 Mar 2023 05:28:01 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:28:01 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:52 +0100
Subject: [PATCH RFT 17/20] clk: qcom: smd-rpm: Add keepalive_clks for
 SM6125
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-17-d9cfaf9b27a7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=760;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VK4g3BsSe83Idt8jQ7iBMSR7RQiEu45t1paO0zX0Ibg=;
 b=fxaQkNzN1IN1hgxn/a6rWWWUjNjheLcEtdZnZdf5H2rj/V1dCTUzkXTVoCh5Lnxo+6s9B46zJoj2
 vOj7reSSDDHPVHY0MCwkOmvV02kn+QUnfIKWPul51NcggBpedXnf
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

SM6125 requires that the CNoC&SNoC clocks always get an active vote.
Guarantee that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index dfcb2020b7b1..a5171b818d15 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -1148,6 +1148,8 @@ static struct clk_smd_rpm *sm6125_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_sm6125 = {
 	.clks = sm6125_clks,
 	.num_clks = ARRAY_SIZE(sm6125_clks),
+	.keepalive_clks = cnoc_snoc_keepalive_clks,
+	.num_keepalive_clks = ARRAY_SIZE(cnoc_snoc_keepalive_clks),
 };
 
 /* SM6115 */

-- 
2.39.2

