Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF76B141B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCHVgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCHVfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:35:55 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A458DD2932
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:35:49 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id g18so18052390ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQfh2WbVBXCGhONYJZDP8O9PA2kbZ/WsteDRJW+CEEo=;
        b=jlT64jGnX9EyFQbSCp7Bn017VtmEaLUeLCtmD5RVnxofRuyJmVNspcSNivRnK5XL5L
         +kBcOEEzSDuEgU7b5i/s+wlOoTNWHuiLKd4Lw5kKvZL0hG0JCt0zIbjQCb4odX3G2+tQ
         Z2D7WcIwQMkP+fkb81gxKNyp9oIhxobO/7OB9PYZYrKVBBoPNLcz+va9hOaC0aBhIMkJ
         Bkfx/OMZXVCo4A9m/mpkZka7E1WvILbGrlGC4xwN9JuOCdZ8XxWxKJ7GlNNB/Z/SWd1T
         7VZBsAfX9UEgiJcCeJ519HuSqoZCQVsLfiVqCJgOhlhdSfp37F80B5hSzlbW5T7J3JmL
         6yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQfh2WbVBXCGhONYJZDP8O9PA2kbZ/WsteDRJW+CEEo=;
        b=e/QZEZcQ4vz8P5JwhovWmN+Xucd8/9SXKthO0iNj+JYIOGApzBPngo7bhRDSeTtwYO
         dk77oCB1t9WfGkcxXtYdMNFXzhQLqirsHm7HowOYiy/AA520C+2rLScSriqLC6IC0/eJ
         SOd9vDf1NKLOb5w2SinU2DILUS/MahKeFaF2XJS6kf3DRXYYq2MzvN9nAicDkXLKOSAy
         rbvWGKHzqf18UJrQRJBr76ppymAVbwOh4hwDfd990gvopSLWXsQchHmdpqrWbOA/Sn+T
         ih87LD09CKGSo5tUjVlhlIIPzWGwwE1Qx8EZBomdEYso1TxZhxARJB9ECWWiPyRKEHb1
         qoUw==
X-Gm-Message-State: AO0yUKWOMrk64MXQKbWIl8OkHPXSW4JfJtm3Uufkcq5jZ0hDOxfp8NNz
        QY/teMA60q2tve0kz2aF8zJERA==
X-Google-Smtp-Source: AK7set+y+DjLgIW7cnOdetKMsRZ4JWT/c1FWUTq7ipcbLcRS7Ib4CpBEwYEsN1IXPTaza1CY4QrbrQ==
X-Received: by 2002:a2e:7810:0:b0:295:b005:1d56 with SMTP id t16-20020a2e7810000000b00295b0051d56mr5751684ljc.17.1678311347868;
        Wed, 08 Mar 2023 13:35:47 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u7-20020ac243c7000000b004dc4d26c324sm2467479lfl.143.2023.03.08.13.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:35:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:35:23 +0100
Subject: [PATCH RFT v2 07/14] clk: qcom: smd-rpm: Make
 __DEFINE_CLK_SMD_RPM_PREFIX accept flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v2-7-ae80a325fe94@linaro.org>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311334; l=1880;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=psKSvGQDNyeXFzjuSkxyveilkS0EXbnLPmqC1X+KBDY=;
 b=BNP9g6R4cFS3/Yrb9t5P/MOac0VdgbxoI+qmXh6hIoCVitEsxsgiU5LyXmHV31X+F2mf/Q0b+636
 4HBTf54rCPB/sF1gXBv7ClninZknYlvqL3ULKsdw8p1TJd1D0NJV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting keepalive clocks which can never be shut off
(as the platform would fall apart otherwise), make the
__DEFINE_CLK_SMD_RPM_PREFIX macro accept clock flags for the active-only
clock.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 9dc779360ada..ddb4268ba2a5 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -26,7 +26,7 @@
 #define QCOM_RPM_SCALING_ENABLE_ID			0x2
 
 #define __DEFINE_CLK_SMD_RPM_PREFIX(_prefix, _name, _active,		      \
-				    type, r_id, key)			      \
+				    type, r_id, key, ao_flags)		      \
 	static struct clk_smd_rpm clk_smd_rpm_##_prefix##_active;	      \
 	static struct clk_smd_rpm clk_smd_rpm_##_prefix##_name = {	      \
 		.rpm_res_type = (type),					      \
@@ -58,13 +58,14 @@
 					.fw_name = "xo",		      \
 					.name = "xo_board",		      \
 			},						      \
+			.flags = (ao_flags),				      \
 			.num_parents = 1,				      \
 		},							      \
 	}
 
 #define __DEFINE_CLK_SMD_RPM(_name, _active, type, r_id, key)		      \
 	__DEFINE_CLK_SMD_RPM_PREFIX(/* empty */, _name, _active,	      \
-				    type, r_id, key)
+				    type, r_id, key, 0)
 
 #define __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX(_prefix, _name, _active,\
 					   type, r_id, r, key, ao_flags)      \
@@ -117,7 +118,7 @@
 #define DEFINE_CLK_SMD_RPM_BUS(_name, r_id)				      \
 		__DEFINE_CLK_SMD_RPM_PREFIX(bus_##r_id##_,		      \
 		_name##_clk, _name##_a_clk, QCOM_SMD_RPM_BUS_CLK, r_id,	      \
-		QCOM_RPM_SMD_KEY_RATE)
+		QCOM_RPM_SMD_KEY_RATE, 0)
 
 #define DEFINE_CLK_SMD_RPM_CLK_SRC(_name, type, r_id)			      \
 		__DEFINE_CLK_SMD_RPM(					      \

-- 
2.39.2

