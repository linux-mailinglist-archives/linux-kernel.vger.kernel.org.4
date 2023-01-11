Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE09666362
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjAKTPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjAKTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:14:59 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFFB3DBF4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:14:58 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id bn6so17026647ljb.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPcZBzHD7ae6hkELFAHD+D8x2hKPutj+3M3d+IlT3KQ=;
        b=UMv7/eMyntz4XC/n0FQobQsKOnZQOAAYdZD9dw3Q3LzNgH71k0ft+Iqir/z2+HF71I
         zOnDFjw0DTI+biMwLY/eQLXThEOF2Xzv2OoufOF1WV0kPt/+imGpxihOFw4THOplbGPT
         0Ts7mtKSZReDkPU2MUcOEmwPAvX99rtX754/l89mElokerv1nguqcGty0yzfos9RHjiu
         cwQhGRlSZVNusrCB/tJJYE1WsQ4xAAxD0vmHEpPb+RRN0Hruw7xSNqKaRv+/AMIpX+lG
         Usiw2D4N4Vx+2n7BcT1tReSttWk0BGwrqFBz9URDKSZbMfzzfhh7XufNQJFrLRKiRzi1
         nNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPcZBzHD7ae6hkELFAHD+D8x2hKPutj+3M3d+IlT3KQ=;
        b=lcsZCbFVnvkw22Gl36STFs4voLrTz+Vk0jY5rt214X/CqVTjvDETjsLg0gfSC3plhg
         bgeFQhWeEj5H7FsNUx3fZ3TCyAvOsAff4cmprW9VHc9zMLg2JC6oDX+zz+rT+Q03/44k
         cxQ/TdMG69vFuwrMWUvVfRwfU3BVgBJTqSFy9g1oZsPSQB+du6FqdzEzhuO+B8WlLOD4
         XoXJGea0dkJbvLoT52I4TFUejDZtwFEOPwbCvw1vobBImuhLiCI3MDWJKs38ErpqD8VV
         0racba/tVnJ/fJr0fDsAt4uRDZnxaa6FCpZrJZNHye15g9AFkuq1IJyyQuHetKUEWL0r
         Wlpg==
X-Gm-Message-State: AFqh2krQSSoMgpnKurINumH60Ghvbc1Gft1oOIif/PBZaeCuT/zBZsYa
        AcFOiOh6uhB63ziZ1O4WSdCggg==
X-Google-Smtp-Source: AMrXdXuapSySspddRmgkrBvUeYqYXvuI/qlqdHQcrDRWca5y/BcX5TCLFKVsmrpgEhlHLopnJUHIwQ==
X-Received: by 2002:a2e:b52a:0:b0:27f:fff4:a6c8 with SMTP id z10-20020a2eb52a000000b0027ffff4a6c8mr7328861ljm.48.1673464496896;
        Wed, 11 Jan 2023 11:14:56 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r7-20020a2e8e27000000b00289873cce0bsm76343ljk.14.2023.01.11.11.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 11:14:56 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mailbox: qcom-apcs-ipc: enable APCS clock device for MSM8996
Date:   Wed, 11 Jan 2023 22:14:52 +0300
Message-Id: <20230111191453.2509468-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111191453.2509468-1-dmitry.baryshkov@linaro.org>
References: <20230111191453.2509468-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8996 also has the clock-related part of the APCS mailbox device.
Follow the usual pattern and create a child device to handle these
clocks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 0e9f9cba8668..bd61dacb44ba 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -42,7 +42,7 @@ static const struct qcom_apcs_ipc_data msm8994_apcs_data = {
 };
 
 static const struct qcom_apcs_ipc_data msm8996_apcs_data = {
-	.offset = 16, .clk_name = NULL
+	.offset = 16, .clk_name = "qcom-apcs-msm8996-clk"
 };
 
 static const struct qcom_apcs_ipc_data apps_shared_apcs_data = {
-- 
2.30.2

