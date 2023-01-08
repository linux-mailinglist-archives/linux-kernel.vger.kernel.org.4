Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B98661551
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 14:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjAHNEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 08:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHNEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 08:04:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB65DF82;
        Sun,  8 Jan 2023 05:04:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 18so8723468edw.7;
        Sun, 08 Jan 2023 05:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pbPYYWyqM3Km+MmO9M4MvtLvP8fuh3Tc+91cRMxFpfs=;
        b=f53LoH7fItXvtlkArddm8RAl+/EDorUMczf+yqZ6S9QjOmj6sniNIQQScBKu4uY2s5
         FHzdgC95593j8Qy8tKdA+TMwfwtig+ynLe+43yXtcZS0wUmlRsVpr+3EpGmLf6CZ8/Ds
         SeAlPPdGatgLjFvVC+/nyndYffgd8Fyk/7/crQDXWawhHPHhaKmXmKq6ev0n4zLMObsb
         pLq8GHSCNOtRPxJ34PEWjtQUBkHcJhE8DsMUBBNmmKXwcQQxPHxrEadS/tZxoQEr9KMW
         LfIM8gj9dGDPKnumGiSG9ZW+dpwVIIe9iHqJxti/ofRz7mjLT19LTu8GOmnWj3Cp4uR9
         /mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbPYYWyqM3Km+MmO9M4MvtLvP8fuh3Tc+91cRMxFpfs=;
        b=00H+QHUR3ljhXMC4Z8DhErOAD+x0j6mUfob/WekNj30qhzIm2YZJuQXLHw0FHMguUv
         gjwXW+4eYOQM67k2YtMKwioeC7t67tmQP6hP1QolAtgU5UIysp0XNqCii5Jevka3SRMl
         J0KoZDpBaJ9lRPF9pGEgDmyam+BvEdk4B9TGEpk7+Iw0ba1xMLvAI4l0CJsV5vBe48eh
         SgEOR3wcnu/563bh8FBHsgIJWkBK8Kdpa8Vg2hzzHwicIzup7FO5lbDf1ywCB3nINBpA
         r+16EHdzddqbaVhz5YI3IA7AmGPPqPKCghzzlZBWZWfUFIcv2k/zkKbneIUHW5ooXlT/
         hzRw==
X-Gm-Message-State: AFqh2krE9fsVcwaG3cC9qKOwAErSeEUo8l5iWjeGa3cUlQuf4e1vaP01
        WUdWBJmgHA5Znywp29la9Vc=
X-Google-Smtp-Source: AMrXdXuzq4+RB/jzO8hsBGSL8+tJxAHR09IDSwyHUvpD8zU0jmnaFUFz9kcQFLBYGLlk6W+2B+c3Yg==
X-Received: by 2002:a05:6402:541a:b0:46c:6ed1:83b0 with SMTP id ev26-20020a056402541a00b0046c6ed183b0mr53791418edb.9.1673183084497;
        Sun, 08 Jan 2023 05:04:44 -0800 (PST)
Received: from fedora.. (cpezg-94-253-128-11-cbl.xnet.hr. [94.253.128.11])
        by smtp.googlemail.com with ESMTPSA id l10-20020aa7d94a000000b0048ebf8a5736sm2499285eds.21.2023.01.08.05.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 05:04:43 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] clk: qcom: ipq8074: populate fw_name for usb3phy-s
Date:   Sun,  8 Jan 2023 14:04:39 +0100
Message-Id: <20230108130440.670181-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having only .name populated in parent_data for clocks which are only
globally searchable currently will not work as the clk core won't copy
that name if there is no .fw_name present as well.

So, populate .fw_name for usb3phy clocks in parent_data as they were
missed by me in ("clk: qcom: ipq8074: populate fw_name for all parents").

Fixes: ae55ad32e273 ("clk: qcom: ipq8074: convert to parent data")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 8374cc40915a..888e8df7bc92 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -934,7 +934,7 @@ static struct clk_rcg2 usb0_mock_utmi_clk_src = {
 };
 
 static const struct clk_parent_data gcc_usb3phy_0_cc_pipe_clk_xo[] = {
-	{ .name = "usb3phy_0_cc_pipe_clk" },
+	{ .fw_name = "usb3phy_0_cc_pipe_clk", .name = "usb3phy_0_cc_pipe_clk" },
 	{ .fw_name = "xo", .name = "xo" },
 };
 
@@ -1002,7 +1002,7 @@ static struct clk_rcg2 usb1_mock_utmi_clk_src = {
 };
 
 static const struct clk_parent_data gcc_usb3phy_1_cc_pipe_clk_xo[] = {
-	{ .name = "usb3phy_1_cc_pipe_clk" },
+	{ .fw_name = "usb3phy_1_cc_pipe_clk", .name = "usb3phy_1_cc_pipe_clk" },
 	{ .fw_name = "xo", .name = "xo" },
 };
 
-- 
2.39.0

