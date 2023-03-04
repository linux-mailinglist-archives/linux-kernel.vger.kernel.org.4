Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F796AA9FE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCDN2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjCDN2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:28:24 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3275C55B7
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:27:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id k14so7022740lfj.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2z9cnyQNCQrmi4E0sqYfd+FcDUKVN5myB1pDKOwRqq0=;
        b=Seyq5ymCozhGmol9HAv0dbvFf3QjsGfoJ4+0bWx7U8WSia9IJY85F7aWbb1MrLTC0o
         siS2WYlF5GWOZFXl03nbcuCzsvUsybB++DBXBJGI1h8VbYtsLmFjeu2yd0Ogr40dF+ba
         TkzAYNYbldxmx/KriTXOlQP2EJBlOFnqCtZkp7dc5zpTbfU0D6ADak+9jSsIUrw0VBkF
         krmCzm4JUCQDjzblwwGg0mvf1zMJMHG/c1A1FZ5NbtoBz5QQCWJaP7EtbGaRxtzjkyKA
         9PqQAP0ywJBth4wk9WXOZdzCZVews6eA4e2pBwM+WbcJqBQLOexwBWz4bxS6+C6XRmqE
         JccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2z9cnyQNCQrmi4E0sqYfd+FcDUKVN5myB1pDKOwRqq0=;
        b=qUMsitk1O72hlahr2lRtkiPt7n2TzAHpyIl4PNgSTkFYI6QJcTA7OeGVQeaIVXNoop
         4PhXbbOGyjsicrl6hS9cKPLCXvDay6IESioU96QLwU9XvxOkB3h3hDgzEU435XA+8MrV
         DhP66sKONOTx8gP8vK63Zy2hnlW1Kdovq/fMESfx5RU5q4DsYDeIRMwhz7PLYvcRaybn
         7+Wks0YfHpvQgwsTe3j8rN70GO1Ykc0RgYcjAlCOHIk7Qht/jZA/cS7Ocb3fuh/Gd8tD
         SR+Ual6f2z9EW3K5KznPRKi9+rbqEstQqWUNsRM7/RBog9g2X3W15/aJq2vWAh9G1W5G
         YrvA==
X-Gm-Message-State: AO0yUKUMTyDOZSUHsBneNUZkH8HCJpNxEGU9ZJXlI9HNc1S1un4UqpOd
        A+Rv+oT+Ick0eldCcS3k6nEvWw==
X-Google-Smtp-Source: AK7set//QMUXLq7je7zm/ERtuM7uMA+XVfgTIlDnUrmkF2DSbBcDGir2BunllLBvjEhnbuWQKDwHyQ==
X-Received: by 2002:ac2:4472:0:b0:4cc:6f42:a097 with SMTP id y18-20020ac24472000000b004cc6f42a097mr1352769lfl.26.1677936477750;
        Sat, 04 Mar 2023 05:27:57 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:27:57 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:48 +0100
Subject: [PATCH RFT 13/20] clk: qcom: smd-rpm: Add keepalive_clks for
 MSM8998
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-13-d9cfaf9b27a7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=1200;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3gGCgHs8c+Krw+pfw3dUgzyqYnpnidbAElcU8AN3oB4=;
 b=X8YnLM1sy7ck0dlP/tPZD2CKK0+NpjftBIVbzUc2g/bbI4g44joY5jRyJ+pNvtXgpKW8Z4TYo0HQ
 BpMCpEevCmi2anmF2/iqXhqlyNEbx6iuN8KKRroGt5xcb9X+5ITt
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

MSM8998 requires that the PCNoC clock always gets an active vote.
Guarantee that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 4b6037e804ae..6649f13c741f 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -521,6 +521,10 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk1, 11, 19200000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk2, 12, 19200000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk3, 13, 19200000);
 
+static struct clk_hw *cnoc_keepalive_clks[] = {
+	&clk_smd_rpm_bus_2_cnoc_a_clk.hw,
+};
+
 static struct clk_hw *cnoc_snoc_keepalive_clks[] = {
 	&clk_smd_rpm_bus_1_cnoc_a_clk.hw,
 	&clk_smd_rpm_bus_2_snoc_a_clk.hw,
@@ -990,6 +994,8 @@ static struct clk_smd_rpm *msm8998_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8998 = {
 	.clks = msm8998_clks,
 	.num_clks = ARRAY_SIZE(msm8998_clks),
+	.keepalive_clks = cnoc_keepalive_clks,
+	.num_keepalive_clks = ARRAY_SIZE(cnoc_keepalive_clks),
 };
 
 static struct clk_smd_rpm *sdm660_clks[] = {

-- 
2.39.2

