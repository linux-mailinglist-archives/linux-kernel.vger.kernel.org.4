Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF2A679BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjAXOdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjAXOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:33:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A051D7A9A;
        Tue, 24 Jan 2023 06:33:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso11062691wmq.5;
        Tue, 24 Jan 2023 06:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aOtYwkJuuHEPdSEaKtuY4IVMeDQdkAEZJbms1VnoL4=;
        b=GexpuhAbVSXoU0EPzvjZgr4tSeN0n51vxGdsguhXKYvtz4V5HBssb9UIK4oHWOM3nf
         txLzl1zwlKiFc9WbFASq59y5hGJrs/etdpknLbHgLGicI0iGLQVMU2Yt3En/XDIWx2ye
         4/MeLqz2N6JHI98fiyyGuDWiazqoZf7iz78T2MJ4K0gxbqQe7S2TI6Nyi9SQJdjJBD1d
         9jjtYR+xTga5ighZQd/PWgU3kxqBwiaLjtJxhg6EfXTdo3cWxq46OiesZ3CtYEDWi49D
         3W0FNfWfo+tktO2tyX5vxfRLZpu3VP6/M6Grru2sNaHSSySaDKLgqbwAFJGA/A0pJ/+z
         266g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aOtYwkJuuHEPdSEaKtuY4IVMeDQdkAEZJbms1VnoL4=;
        b=fNQkQKciaGKRymA1FliD1gOPbjl9VHaeIywy1j/n0uquLaEjtfrQvj2PUh47oyPpzG
         JF4qc92kGSvyOllAODjBImhcxqNL6k6MPnOKdq14c0Cs5tUHsDgXJfdB2SQue0CesTEI
         IDOOqv0MqZLRQPSCSU7Zh7JIxR/IEtuuV/0lMgSdXY4EPKck8OSq21BTse9D9ao+T8kG
         HQn8jTlN7akMplF0hh8vA5DPwqRzlq57uvSZIT6BbdVoMDAvo+oyPIz+RUq4AZcmxSuU
         bgXo+CsPD+XjBzqxjrrGZFGu8Bd4HPyntZ9z7bLPC794NDTSdSHcD0cIEkp4YZWuiloA
         qh0g==
X-Gm-Message-State: AFqh2koyJKU72LOGzZE1fNdFG+tbKbAj+jyy4XexZMTKg0Tn7G6eBxhe
        Mp4mDU+pZRJiKXmm/Lmfo6A=
X-Google-Smtp-Source: AMrXdXtpjWD0+cZIvANzhQag0IH6f60p2wMHykGleUd706IE+w4sB96Pw83DkgscJQB0pxreZNI50Q==
X-Received: by 2002:a05:600c:3b83:b0:3d9:f758:e280 with SMTP id n3-20020a05600c3b8300b003d9f758e280mr29410938wms.24.1674570793989;
        Tue, 24 Jan 2023 06:33:13 -0800 (PST)
Received: from localhost.localdomain (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.googlemail.com with ESMTPSA id j14-20020a05600c130e00b003db0bb81b6asm2083039wmf.1.2023.01.24.06.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:33:13 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 2/2] soc: qcom: socinfo: Add Soc IDs for IPQ8064 and variants
Date:   Tue, 24 Jan 2023 15:32:36 +0100
Message-Id: <20230124143236.1038-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230124143236.1038-1-ansuelsmth@gmail.com>
References: <20230124143236.1038-1-ansuelsmth@gmail.com>
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

Add Soc IDs table entries for Qualcomm IPQ8064 and variants.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/soc/qcom/socinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 10efdbcfdf05..a4347fec7d37 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -255,10 +255,16 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(MSM8126) },
 	{ qcom_board_id(APQ8026) },
 	{ qcom_board_id(MSM8926) },
+	{ qcom_board_id(IPQ8062) },
+	{ qcom_board_id(IPQ8064) },
+	{ qcom_board_id(IPQ8066) },
+	{ qcom_board_id(IPQ8068) },
 	{ qcom_board_id(MSM8326) },
 	{ qcom_board_id(MSM8916) },
 	{ qcom_board_id(MSM8956) },
 	{ qcom_board_id(MSM8976) },
+	{ qcom_board_id(IPQ8065) },
+	{ qcom_board_id(IPQ8069) },
 	{ qcom_board_id(MSM8994) },
 	{ qcom_board_id_named(APQ8074PRO_AA, "APQ8074PRO-AA") },
 	{ qcom_board_id_named(APQ8074PRO_AB, "APQ8074PRO-AB") },
-- 
2.38.1

