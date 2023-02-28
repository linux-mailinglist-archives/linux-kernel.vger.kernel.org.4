Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083156A5BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjB1PZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjB1PY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:24:59 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828922CC6E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:52 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i28so972115lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJKby1etsQJsllCrJh6jNuq7BGyySsQgLQcWxf9td0M=;
        b=FNAAp+L1mjP7wXirSyAnaA+f+qxBmWL+t6LCR1PQ77rO+N0YBedv9B9b834hLtkfOc
         zJxBpLFILWTMK0q3fviIYARGqxedttKeH2+Zd9Juw/Mgf9EwHmGMT2ryqEYdikBVUJF9
         xf35aPKyROPrUdrbURlyimSj35XPGCGP86iZenLYVoGqdVAwpTeKN7lOR9PRzG1D/joJ
         jcjhfta8IUwLoG9kxX6U3vczWgfBsHNPSRHK8ZvV0mD+3a7XU3MFBs8mh+St6EbsmV3c
         srS5ipHLSL5QHJNWurzy+nblDFQ7cwKniM4Z/DP9R9h0U8/V8kbU38nj+HO8+d0aFoh3
         1AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJKby1etsQJsllCrJh6jNuq7BGyySsQgLQcWxf9td0M=;
        b=caA87PNSUK/y3NrmEU8vak4tz0mZp1owzVUeidLNXEsmlh82jKL5fFstRKU7P5swbe
         hdhak2aTWrnEg2GM9GOkxPjkVRun8Z78c3KU01KUeDMWNbfkmA4SLVlQYl8KWHR4JWNn
         x+98tU/EeFpPP4Vh8fRwziY+/vU7QB0foA9lP4Vg+tHia1M+NJkShMkDODmVHO7qUoPZ
         Mi05A7m0iAaH6D3oBfZu33WM+x/xjyjqtC4qJsqUFx57VZMjRYkaudz7N2rGKKLTEdhI
         cGak2JLBh7TrzqpawXSFYjED1RPCDa7l3BGPjhLOdjRFGM9LihzhHJGsVRifzIZ7NRd8
         8qXA==
X-Gm-Message-State: AO0yUKXyYNtW0+aDCHvQWpWl2u/QQxpWWalOU9Gk8kTAouI8DXUye6/q
        oj53paA0JXowhLw+f0uYt0zbWQ==
X-Google-Smtp-Source: AK7set/AQ6YZAiURXkQvm9aWq/Uoeu0gY7URJDbOH5dKAUBFUMn8XKel8bpY4nppr3hNtxX+gTlJbQ==
X-Received: by 2002:ac2:4347:0:b0:4cc:a107:82f4 with SMTP id o7-20020ac24347000000b004cca10782f4mr722161lfl.64.1677597891979;
        Tue, 28 Feb 2023 07:24:51 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:51 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:35 +0100
Subject: [PATCH 11/18] media: venus: hfi_venus: Fix version check in
 venus_cpu_idle_and_pc_ready()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-11-58c2c88384e9@linaro.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=1021;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NAz9W7wy6ZAwlY7CWxe3uTkj0TQJe8T3RoBED0bE9S8=;
 b=qtjNKvtA0yoqyrxQM0xDnZpRdingZm2zdMqL9NlB53Shbi1eO7NMqR/X3sZ9Mk+VEEGmYonr/kM1
 nbVgOYKuB+sFfAJsOZ9f7Jc2AR72I4wjhXfuhh4Tllov3iBHKjs+
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

IS_V6() should have instead checked for specific VPU versions. Fix it.

Fixes: e396e75fc254 ("media: venus: hfi: Read WRAPPER_TZ_CPU_STATUS_V6 on 6xx")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 584c84125887..c2d134e04c30 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1563,7 +1563,7 @@ static bool venus_cpu_idle_and_pc_ready(struct venus_hfi_device *hdev)
 	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status, cpu_status;
 
-	if (IS_V6(hdev->core))
+	if (IS_AR50_LITE(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
 		cpu_status = readl(wrapper_tz_base + WRAPPER_TZ_CPU_STATUS_V6);
 	else
 		cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);

-- 
2.39.2

