Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D23C6F97F4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjEGJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjEGJOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:14:02 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3058192;
        Sun,  7 May 2023 02:13:46 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B06E4CED45;
        Sun,  7 May 2023 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683450782; bh=MC8BJTkVNHFkpuzAQk1SVZ5OYONedDEetKHltlnaN1A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=A6lcWCmHw5qdziSAay4U8p/SCdz24UD25mIemDtpcjQlcdhj3wvJ4LwU6MQQNq94e
         E8w+V2kkRO/+BOKLSgx5X1Ch2l+e6oeg406yqcQWnbkI9TgtnxrUpdY+YK+zh9Y9yE
         r1Rthq26pnoumzEXQ4VUV4DBGEjigySmMgrmGE8E=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 07 May 2023 11:12:22 +0200
Subject: [PATCH 5/6] soc: qcom: ocmem: Add support for msm8226
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v1-5-3e24e2724f01@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=MC8BJTkVNHFkpuzAQk1SVZ5OYONedDEetKHltlnaN1A=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkV2ub1U8OPVlxEdg5XyRaCndznhLRJNWmqUMTm
 bOYxKro0/aJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFdrmwAKCRBy2EO4nU3X
 VsG3EACuCSoWyCHmUgzYkcnWvSHPhjroNs9okr5opad6kYowZdVQwqjGoDxmhuFsQwZE+w1TZ+K
 cOBQCV8oXSnntdaPKfyNM2ycedTQRL60J0gvQsfN1HyFFOJ/AwPbrtuOljRdm2+OH+trrgx9lrF
 ejlIOMSpKGLnsGzt5OQn3AcOYhBVKiOJSjkzdkP5D2sBpKHZ6+br6T/cVNuB0FcpPHuYGw34IfD
 SUGIVgiwU3ZPbCbrmtPHJjIX4cgwRWloYd/FEZ+YMF0lHLlsvTVptny58M+MAfPbbhAwa8yDwa3
 Z9ZT/t4yw+iKhQQb4YggTJrU3z6Fr4449igoSibr24vowRzqNpy1QVqLSzOzd2JWX3KgTOB1RY5
 jWIpedZdTiP8T6MzOnH9kCYsGfrp/MWuVtfG5G7/oIRgtiFmAjoWycJkYuxA9GxXTIzmqzQOJ6a
 a5l3PadOXkk5YTto+TpazxUxDcL7Jy+JXHZR5d9otME45Ghxiuh8PqX2AcU1jx3g+HBZwXl5jMn
 AwFVPPJpursVXmRDtr/++XqZPh75qt1h8F+dJXFJlITKfYrcy7RkUB2No4EPCLuAztV9V2fJbU6
 f/6FJuroNJHW5MK4TqXQAVzEt69JDWxkzDEev4rMH73ph2Rl918vrcO8DeXu/3nbyMoxUo/3A4Z
 8wxPinFE3v+x4Ew==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msm8226 SoC also contains OCMEM but with one region only.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/ocmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index 6235065d3bc9..d5892ce999c9 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -413,12 +413,18 @@ static int ocmem_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct ocmem_config ocmem_8226_config = {
+	.num_regions = 1,
+	.macro_size = SZ_128K,
+};
+
 static const struct ocmem_config ocmem_8974_config = {
 	.num_regions = 3,
 	.macro_size = SZ_128K,
 };
 
 static const struct of_device_id ocmem_of_match[] = {
+	{ .compatible = "qcom,msm8226-ocmem", .data = &ocmem_8226_config },
 	{ .compatible = "qcom,msm8974-ocmem", .data = &ocmem_8974_config },
 	{ }
 };

-- 
2.40.1

