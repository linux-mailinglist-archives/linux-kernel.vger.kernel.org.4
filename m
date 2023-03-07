Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1366AFA41
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 00:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCGXYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 18:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCGXYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 18:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA937C3DD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 15:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678231430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L1VSODuSHT6h/z9IAuPAvJcAN7vDMCMVV0tl0uco2PU=;
        b=VtsQ3MY4wrad9qA8bppUqeceRDC3Xfo1+llADGnbD/WUWXLl8J51krUX9v91LQ2R4pgfuf
        C4hBcNMml7BT2EKT8gNnWUPojUzevu38e10gIal3RvUJzJpRLlpHbSUhaJVRHQmtISpZ24
        PQ/RZLZELPO+xfszskjPArrqLYzxmgE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-B4zzyCR6OtyVoAqLY6_1hA-1; Tue, 07 Mar 2023 18:23:48 -0500
X-MC-Unique: B4zzyCR6OtyVoAqLY6_1hA-1
Received: by mail-qk1-f199.google.com with SMTP id pc36-20020a05620a842400b00742c715894bso8308551qkn.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 15:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678231428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1VSODuSHT6h/z9IAuPAvJcAN7vDMCMVV0tl0uco2PU=;
        b=6eKQpyIWnef8xVxg3fhXNqlPp2NMUFQGq39p2M2AYAiz67pDxEQU8p73uXLVeD3UjJ
         0qVC6fOfpxFflQ28YFSkVVlKJWdiEQqTrSkYfnDLUWYLwtZ8UWKdTmjTPJjQd36J2T+/
         TL+Oq3yShIRKbKkvfgZBtgQEY2OcEHFql0OLhsSBsu+UJoEm8Kk1zxRyGy2P5Yw3jXM6
         Kk42D3NhvEvN2jTcnpx3/RQXSH5XXr4pbfNZw+mDS07kAh2uZSB+FQdJR8x64JU42j5t
         rfX6k1QP+/K+AfgInW932GRUJLdWCZsh6MzJqtpEQnOXKU0Z+02WfvdIrOa6Ye39iz/p
         JxiQ==
X-Gm-Message-State: AO0yUKX53tezlpYkcGzf44xFA9MJX4qWBnD9AmYw/Z0HsBTN9d71Z/Yu
        RVZGgYXwJGtT6NLvL5v/oLO4xmrmnKkpGcuYeYWPXoa0MKMytcJgl/vGVnzlZJWozC4vUZhgKo/
        XsFc7ivPG/2SmOPdLtWvgmExV
X-Received: by 2002:a05:6214:1250:b0:538:a431:862e with SMTP id r16-20020a056214125000b00538a431862emr28167920qvv.19.1678231428404;
        Tue, 07 Mar 2023 15:23:48 -0800 (PST)
X-Google-Smtp-Source: AK7set9vDzIHs5mt0XlKyBy4hLxi39WDRWptCE7iC2Ek8YGBhCCTIL5pFVQdE5rV3MHj/lZGxFaXPA==
X-Received: by 2002:a05:6214:1250:b0:538:a431:862e with SMTP id r16-20020a056214125000b00538a431862emr28167899qvv.19.1678231428131;
        Tue, 07 Mar 2023 15:23:48 -0800 (PST)
Received: from x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id do32-20020a05620a2b2000b0073b7568d998sm10280819qkb.2.2023.03.07.15.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 15:23:47 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org
Cc:     quic_shazhuss@quicinc.com, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sa8540p-ride: correct name of remoteproc_nsp0 firmware
Date:   Tue,  7 Mar 2023 18:23:40 -0500
Message-Id: <20230307232340.2370476-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cdsp.mbn firmware that's referenced in sa8540p-ride.dts is actually
named cdsp0.mbn in the deliverables from Qualcomm. Let's go ahead and
correct the name to match what's in Qualcomm's deliverable.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 6c547f1b13dc..0f560a4661eb 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -177,7 +177,7 @@ &qup2_uart17 {
 };
 
 &remoteproc_nsp0 {
-	firmware-name = "qcom/sa8540p/cdsp.mbn";
+	firmware-name = "qcom/sa8540p/cdsp0.mbn";
 	status = "okay";
 };
 
-- 
2.39.2

