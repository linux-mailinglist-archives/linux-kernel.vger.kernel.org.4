Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00AA6F669C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEDICW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEDIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAE840E4
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f00d41df22so8585511e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187299; x=1685779299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGZfzDtDtbp7luOgtk5iRa02ZQGrQVsSDa0gZJuVtLo=;
        b=w3BJtmBXcJXJRwjtG4nutFaMmClGQ4CYwe0KrY7MKGyHrO0K94hQvAEEMr6d1UtzOM
         /pvVqwMW+xZKloMnDFFFp8USqSH1UTzKwS0LRXKeQDJvAklxiHDFjsgKGngrCc+TfpUa
         cXCayqpjXo7RwJ4Bh+h3XqzklV7gvVoEHUv5IDyLfYzTXUa4ZST3t1QjjUN3ZzlVmdKq
         H+Ow9hEBZFbsdJtFiqui1t9QFksbbufSlnYd1Slqy5h2f0vkViO5/4FcOt7rom/toOMq
         tSbklD81Wb39+TBVQs6hF/7qy7fGyjC+pGbB3X0fI6IthV57ejmjkG0zf97dFO5frJUd
         C9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187299; x=1685779299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGZfzDtDtbp7luOgtk5iRa02ZQGrQVsSDa0gZJuVtLo=;
        b=deqAYcQEXOFD/lHBtYfXL6qB8oLzc30MVDbKbrhAO5gBmC2DCI7rrduLrigDPtfRpv
         pdz0F89wO73f/nJB5MyO7DmTqQXba2x8vA9RKFta3SWXC5ACE44D5iV2ArEZe1Okgt86
         3N535Xihlt32IIbvT9pifNf3r68klBxeK5gzVqpYayi6KZVRn2oxt9tI44Oed9w6K//c
         I9gP88mEmc0n88UjnpnPzjUAB/t3riKF2wBU3m+NVx8e6T57oDxMtCH9kLssuydmdp9b
         5Mq2NG2tRqpb9KV2bkz3IRgVQyJlzE1XmtHipGonz4gnb9nF2oZNNJWeU5dyi8OpNAKf
         27JA==
X-Gm-Message-State: AC+VfDwvbaNq05WCjVrJHMLQ38VlObd4kS60zKH7ZfrhYE66CTMxLSU8
        3L5hnxtcWeJk6lcQb9QCBK6bIA==
X-Google-Smtp-Source: ACHHUZ4SgSbZzRe+Cbjm53ZX1wv37cfpnxLas5HwxtmwYK+qMBrQ//pZ87lVL6eLlSNm18gnE/VEKg==
X-Received: by 2002:ac2:5690:0:b0:4f1:4074:b4fd with SMTP id 16-20020ac25690000000b004f14074b4fdmr491615lfr.29.1683187298830;
        Thu, 04 May 2023 01:01:38 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:04 +0200
Subject: [PATCH v2 08/18] media: venus: core: Assign registers based on VPU
 version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-8-d95d14949c79@linaro.org>
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
        Vikash Garodia <quic_vgarodia@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=1460;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=m2Osp2Xf2pUATOq+7urWFmKXQd2Ed5bGWf9T651mWII=;
 b=1Tkmqz2YbLpV0808lxCYKvHKCyO6BlreCh4HSpHw5yOUcSKTUVoZOggBR2sMnjj3Pjnsrc9zG
 2L32SF9lguJD1MZ7utfeL6JvH66cU0YdtMYj8QTo09aWzIA0og6EwmZ
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

IRIS2(_1) has a different register map compared to other HFI6XX-
using VPUs. AR50L uses the same offsets, but doesn't feature vbif_base
and aon_base. Take care of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 01671dd23888..51cead91571d 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -246,14 +246,14 @@ static int venus_enumerate_codecs(struct venus_core *core, u32 type)
 
 static void venus_assign_register_offsets(struct venus_core *core)
 {
-	if (IS_V6(core)) {
-		core->vbif_base = core->base + VBIF_BASE;
+	if (IS_AR50_LITE(core) || IS_IRIS2(core) || IS_IRIS2_1(core)) {
+		core->vbif_base = IS_AR50_LITE(core) ? NULL : core->base + VBIF_BASE;
 		core->cpu_base = core->base + CPU_BASE_V6;
 		core->cpu_cs_base = core->base + CPU_CS_BASE_V6;
 		core->cpu_ic_base = core->base + CPU_IC_BASE_V6;
 		core->wrapper_base = core->base + WRAPPER_BASE_V6;
 		core->wrapper_tz_base = core->base + WRAPPER_TZ_BASE_V6;
-		core->aon_base = core->base + AON_BASE_V6;
+		core->aon_base = IS_AR50_LITE(core) ? NULL : core->base + AON_BASE_V6;
 	} else {
 		core->vbif_base = core->base + VBIF_BASE;
 		core->cpu_base = core->base + CPU_BASE;

-- 
2.40.1

