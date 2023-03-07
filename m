Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42166AD3CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCGBW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCGBWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:22:54 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081FC29E2F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 17:22:52 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id i28so15283786lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 17:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678152170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2x8CT0qC69q7YoY7JhCMWzXWvhAS15Aiyex8pxnv7E=;
        b=RQdubjvBLAVFreilW44I42iQiHFUhj1JbyenLwezjpLlLVlGhy2HWQWxrGj74EeQ7H
         QcR4HXjUoRM2gjf8O5gXoG93Uar0xzDxgKOuFCz0iyqBToqHIGJSQdI78e2vj9QZLEay
         QdVnOdJH387WGiXeRRZulzPsl4Dr7xIRsQ11gXmAUoOvvW4G96DN/4lM7UVTuyh6MJz9
         FIzFUz7cbKkqByIZwefZCb0EyHI62Mw9nTrwjoCDhKUQ/mxEAlkgFRpM3BZ++KEUO4jp
         6JZEvduDK1Je8SojN76prW4Ln4U2pad5U1w8ND2n9Ez/Co/wvUilJKuarXR1CV+yxDZH
         Ubpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678152170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2x8CT0qC69q7YoY7JhCMWzXWvhAS15Aiyex8pxnv7E=;
        b=k69erqrnhzUv7GZVNYKXggbgOnmme4LEX4ecf7kNxfZuS/dM7Jz0NlCAUf4fqPpl5d
         eKmv6g74r386vPeb79/okCfpbvUaKaZq7T3TnV5dy0ghsAyqvAwJIJ7yiaJ4ohy+yD7w
         nsQrLnSMSGVwwWhF8iz9KMYKmzc0dVbEXyvHnF8rkZJWLRBZTepjIRk4lR69EGRVHINi
         z/mDbLkF1qLQwgbvrQq4T3KaGbpp+rQ/U4X/3X6vCpHwYAU+wiQ8+ThyZBAw/7teOTPj
         ZCVyY2F5UAVSvE++SZfItkE/SHCFw1PgGa/MaS3BDSxaii+cChUNKQXrH8T4MJVKxbph
         t/0A==
X-Gm-Message-State: AO0yUKWLtyvfjpGjgIcvumLo/+j4t71ICu9JrBB+pS4apXjT71CPunOp
        FO/bRgSYQqfqnDvuMOLHdPky4j91twou7OfFfRs=
X-Google-Smtp-Source: AK7set/Wo1Bhvg6d91uy/i9lev8howJuGnZgjPUqpM2a4K9IBOjlWDJyG/BbkIgCqi1LhJ/QsW5k/A==
X-Received: by 2002:a19:7506:0:b0:4dc:790c:910b with SMTP id y6-20020a197506000000b004dc790c910bmr3198637lfe.20.1678152170215;
        Mon, 06 Mar 2023 17:22:50 -0800 (PST)
Received: from localhost.localdomain (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id u28-20020ac2519c000000b004dd7fefd2c8sm1819076lfi.242.2023.03.06.17.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:22:49 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: qcom_scm: Add SM6375 compatible
Date:   Tue,  7 Mar 2023 02:22:47 +0100
Message-Id: <20230307012247.3655547-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it was introduced in bindings, requiring a core clock, and added
into the DT, this compatible was apparently forgotten about on the driver
side of things. Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/firmware/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 916a0c2fc903..2e8961c84b68 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1494,6 +1494,7 @@ static const struct of_device_id qcom_scm_dt_match[] = {
 	},
 	{ .compatible = "qcom,scm-msm8994" },
 	{ .compatible = "qcom,scm-msm8996" },
+	{ .compatible = "qcom,scm-sm6375", .data = (void *)SCM_HAS_CORE_CLK },
 	{ .compatible = "qcom,scm" },
 	{}
 };
-- 
2.39.2

