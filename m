Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4E715FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjE3Mbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjE3Mb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:31:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8971B3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af1ae3a21fso46758061fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449846; x=1688041846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gG/GQ4bkNLXJnem7GziPpF9ACnuRetCT8nUsDWFQHk=;
        b=FPcrWx+S0QqRRp9vjxeUGVcIokY4/Nke+Ff+Q0JzM8PKBO4+rvXhn1bgO7zpzFOTNP
         6BMA/Vey0ohHZ8ULcjp+Qc0nvj/j4EgCpMhld9J2LXcxMeccAmPQzHJSdpTFxWuhcFMb
         VAsjQA+LYAOsKhdpXM9W3TCxM+ZGRe/+424JuDbGMQpx3yjx4zcaVITqg8gXFN/14UY2
         BHHIIHUDMbKMnqNdMRzeUY6rbZbmMTbqpg2v0zIauOVF4kUL8oBiOFuIn/EP6kwDR3af
         HP9P2GnOSLsIcLYJA/LojzJ4hQDut4jD93IsVYebz0b+1Rs7Z+2DBjEqg13q7bu0uRiQ
         Tr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449846; x=1688041846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gG/GQ4bkNLXJnem7GziPpF9ACnuRetCT8nUsDWFQHk=;
        b=VlRqXN5tXE/aQoqjvpYTF3juilCSkyEED1omc/QBkaYJQaBoRCyvZcedN0qNCXqqC0
         seJhWbiO8id703HhU3CcwcIfcZR5q5WOAa+/WGr/mqCueNa8rmTrQNkXQGtFzJGc4nzs
         eTVqD7U4GX4V1VIR+jaz6jjQTSYhL0Azdvae4fhsEdQ7irq2iUjrqh1RDWjvDi5PkAbu
         WVpKEVws+fahFcXnKv/amN6wpdj8NZucXFoxkSfCsp77/j5+wWsPfUZosKV4C3JWihTw
         jVsIx8GEg7sUERC1RjntfNGIfKaFogXc/6VlrJBSWriRwdmm8CvHpWjqVCbiqkQd0koF
         AZrQ==
X-Gm-Message-State: AC+VfDzojDSR7LZ6/X8RcJox5C3WwqsdNYxKtXlgk0xgqOBr6b3xiopk
        DoEZ37BJ+Q9Xn/IUk7Irzl1i/g==
X-Google-Smtp-Source: ACHHUZ6425G16ZBREi/VznF6+jFFaaARjmy2zcNhdH6MNDBtZkLRadv/FvnFM8Rpluskkffqo1AaMg==
X-Received: by 2002:a2e:97ca:0:b0:2ae:da46:7f62 with SMTP id m10-20020a2e97ca000000b002aeda467f62mr782022ljj.29.1685449846149;
        Tue, 30 May 2023 05:30:46 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:30:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 14:30:39 +0200
Subject: [PATCH v4 05/17] media: venus: firmware: Leave a clue about
 obtaining CP VARs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v4-5-feebb2f6e9b8@linaro.org>
References: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
In-Reply-To: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=1589;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=v9h9rG/TP42x17XwYSGnOJ0sfKKqjUawup8lEKzjmAc=;
 b=J7JzvBaATX4OCVY/zIqqe/aOUY/Ubry8yNokzE+j+EO1Y/vbLIyY1ZtEZo9hQK9FF0fPaY9FB
 uVJ+94MKZQZAw9fX+nNMzg4Ke59YMQPbMOfbWN/jOFeIbOUw5BDoF6w
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

The qcom_scm_mem_protect_video_var accepts two sets of <addr size>
pairs as arguments. They describe the virtual address ranges of the
CP (Content Protection) and CP_NONPIXEL regions. It is however not
immediately obvious how to obtain these values.

Leave a comment explaining how one can translate the vendor device
tree properties for use with the mainline driver.

Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/firmware.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index cfb11c551167..572b649c56f3 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -241,6 +241,16 @@ int venus_boot(struct venus_core *core)
 		return ret;
 
 	if (core->use_tz && res->cp_size) {
+		/*
+		 * Clues for porting using downstream data:
+		 * cp_start = 0
+		 * cp_size = venus_ns/virtual-addr-pool[0] - yes, address and not size!
+		 *   This works, as the non-secure context bank is placed
+		 *   contiguously right after the Content Protection region.
+		 *
+		 * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
+		 * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
+		 */
 		ret = qcom_scm_mem_protect_video_var(res->cp_start,
 						     res->cp_size,
 						     res->cp_nonpixel_start,

-- 
2.40.1

