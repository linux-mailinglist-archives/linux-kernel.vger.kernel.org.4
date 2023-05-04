Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B686F668B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjEDIBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjEDIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D53C19
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:32 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ac78bb48eeso2064061fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187290; x=1685779290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1wrHdE9iKrmB/WxNypIy4J2UJNGNaaQcU0qAUemPII=;
        b=WDHW2yNAhW01kMfJX7yGsyy6Gm+EE6cCAyf/9TIZh/Xbpz6NeleG58b44v9i/qahSH
         EAs8+5YKk3uDuzqKIaNKUciaZ7kbWStZMrVSsK3t1IMJ86+PZGfrqNfJ8Ha/uP2O6CoE
         3kVdb/6t4Mhaq0ippPDLk+I7PXd5NfJ6AzHy5jvkgSk5gC0+3zsOY44DlPi0W0BjGf7B
         gsCAoWrwF+kqT5H2mroGxqsnJ4Y+HI1WYWBCJD6c34ATI3Drqx4KscXdGSqn+iO0MK3b
         TEnwILA4FXpR5Dr5pyNomkfuYmBShqEbSjsmqUbjiFATvdZE/VGg51cWp1R/HAKIKyrw
         8z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187290; x=1685779290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1wrHdE9iKrmB/WxNypIy4J2UJNGNaaQcU0qAUemPII=;
        b=kfA9LZigX+ljTHOOvRQP/LYONxuwRgIWdPMkeJHNrMoXxTMb2uswF01W2mxbBqeLLw
         tkNMElEZI/qGe3R2ClXENzin2k62J/vQX4or9gYsfFfCvHR0oZMyCc6ANUT2+e+G3I5Z
         4dr9vyrKOp5usj8HjYQ5nRi+2mCsKv/z2jKlwig9rRiVKec9U26MjPLpboQ9O/UBTTyo
         a/L3xJI5RI9Lsec1DWh1GXzgl3h73D7eyaoS0VqlXMl1S5EZrSOAkH2knHoVFu5B9aV9
         k7db8XwlDCccTxn0PEUDUXEYT/vfOpZuVyDk6CYA/8dEx9+N2fO4mzg8jzjYCMtq9vzp
         qwog==
X-Gm-Message-State: AC+VfDzUVWt0S9dmhuNx5bTAWDcGLf6eprOhdve25fTh7KISq7Hbbiv/
        XHVuuppa2jeDkkL0x96k6cM3ow==
X-Google-Smtp-Source: ACHHUZ7AGjDXW8IJKxCiGE93VGJ9cDvW8UI3O+wuSm+ZqEPQzLp2QbdQzxnJsJrVCD2pYXeYbbBnFw==
X-Received: by 2002:a05:651c:201:b0:2a8:e4d3:11e2 with SMTP id y1-20020a05651c020100b002a8e4d311e2mr711499ljn.39.1683187290499;
        Thu, 04 May 2023 01:01:30 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:00:59 +0200
Subject: [PATCH v2 03/18] media: venus: Remap bufreq fields on HFI6XX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-3-d95d14949c79@linaro.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
In-Reply-To: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=1455;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Y7O3kXJUMALOc0Q0JhoHuikwOvvLDtLGeWfKw337F/E=;
 b=jCZB3nnLtzrwBc/9nUK3HW69Wl7+UodaZZct6VGWvDO/jIlFm2QK2OjGO7+uIAfMRHFqyHcBt
 DsDW6iF+tIQDZ5vspOGLVJfq/1AzMQT9Pm7VLtQPpb7Nd3CdmnqIeSo
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to HFI4XX, the fields are remapped on 6XX as well. Fix it.

Cc: stable@vger.kernel.org # v5.12+
Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index 105792a68060..e0c8f15644df 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1170,11 +1170,14 @@ struct hfi_buffer_display_hold_count_actual {
 
 /* HFI 4XX reorder the fields, use these macros */
 #define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? 0 : (bufreq)->hold_count)
+	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
+	? 0 : (bufreq)->hold_count)
 #define HFI_BUFREQ_COUNT_MIN(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? (bufreq)->hold_count : (bufreq)->count_min)
+	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
+	? (bufreq)->hold_count : (bufreq)->count_min)
 #define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? (bufreq)->count_min : 0)
+	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
+	? (bufreq)->count_min : 0)
 
 struct hfi_buffer_requirements {
 	u32 type;

-- 
2.40.1

