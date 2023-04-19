Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A144F6E7D38
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjDSOmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjDSOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:42:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B910B4200
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:42:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a8-20020a05600c348800b003f17ddb04e3so1489566wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681915320; x=1684507320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skGYkFK59/ukAv0WKnmVB0D2Vf4WzLOkmRLP20Jah6Y=;
        b=S/SHCet7T6o1bzniNlVL7gE5UJCdDdK+tx35QCxV16Avx1ks+QhmoPpYR2iSn97x+8
         fLji34fU/fXE0o9jI7a/N8JijPFVvqqy33aYjQH6LNCt+o9Vh5M+YN3Y8fwYvncGyt/k
         CvzAoGf3BF8d8zcZ9hSQalXdd+vEIQdtb5NX4XhU0KoH7+kq4jEmFjjT7DxbQeMPiyoD
         BhdopBmJJVZx9a8sn6P+g4em3ROBjSNsIpQ8MPCDoxkla+SchV8YnH6VR00JiVfzBL0v
         qCnngF6JauL//7bl8cIVDhEeqgtCeG2Sa0DG9focJRhG2jVIUOgYXOWQgCMuaC9lTYf4
         hHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915320; x=1684507320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skGYkFK59/ukAv0WKnmVB0D2Vf4WzLOkmRLP20Jah6Y=;
        b=JBIFD1uLzIR9Fqpsv0XPZjgfwXyzY1Zhi0TuoDubkX79tgnLw5rVXWUIHXzHgcTj3L
         SD/SBvlvBaRk9FS3TxD04uoYj/vSMgWCeRBp+5sM2UVNFQBjlaMcTyWAQtXUPi4tGwcK
         ReSRHosVYLv+IY1aATlc8p1qo9tzOUVO+NSiRMvwx/vEwyrzzSnVCsNTezvbGCZaSnOD
         LzrscHyzpb+NmHbrkIgqOSA01ke3CvASuebSV/CPtn8ZQN9/yEcSRq1RUkwiBWAn+Gin
         llyEGBMUIaSG72Z6UmtKbDmSmYgp73+39tnMYULz7wKFC2epP3tu7pdXb8AhAtEAiEvt
         NNjg==
X-Gm-Message-State: AAQBX9erdN2FR80rRPwE2ged1nRWHHrUt9oIbCVlO7R5jk9jEf1HQIqT
        uFsMe7lHawfJ1uYoIQ44mg3Kmd4oOAya2aarHw==
X-Google-Smtp-Source: AKy350YmaKK3EqTA0/QScooY92hdt3OuAEvnHBAhCJTAnTZTSLhDQXZTU2KFdA8T7mH+W4Fg2s5lLw==
X-Received: by 2002:a7b:c8cd:0:b0:3f0:3a57:f01e with SMTP id f13-20020a7bc8cd000000b003f03a57f01emr16543670wml.4.1681915320333;
        Wed, 19 Apr 2023 07:42:00 -0700 (PDT)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003f17131952fsm2388519wmi.29.2023.04.19.07.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:42:00 -0700 (PDT)
From:   Arnaud Vrac <avrac@freebox.fr>
Date:   Wed, 19 Apr 2023 16:41:16 +0200
Subject: [PATCH 09/11] drm/msm/dpu: set max cursor width to 512x512
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dpu-tweaks-v1-9-d1bac46db075@freebox.fr>
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
In-Reply-To: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnaud Vrac <avrac@freebox.fr>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=avrac@freebox.fr;
 h=from:subject:message-id; bh=U2sKqdlLf08vu1Eh26+MgGM86CFL68O4zQFfb4I2ZHM=;
 b=owEBbQKS/ZANAwAIAXED/9m7NDSrAcsmYgBkP/2qdLhQ8jKSue86pVPaOBEUFNXXjoToVNKG6
 6b62FiMnMWJAjMEAAEIAB0WIQSUwb/ndwkXHdZ/QQZxA//ZuzQ0qwUCZD/9qgAKCRBxA//ZuzQ0
 q300EACs6Y5bbGsrBx9QQIpO3qcIvxHHO1/cU4aapUC4FXaAFZVZH1fnBncMrhExDQFjg/pzDEf
 9Kfbd7OJCwa3PRdB37UedeKukA4Vl2Bb3TrTSDrHEwX/OOWvM6ZI55NBCf7mStf2JpJNmbaKZ4b
 wCPtIN449OPMeLeKzEh1idAWQCqb68+irLQAXWku1EHOSOYKr6vRvd30fSKzsRCRW96zeuhz4OR
 YU0KZ7M8h/zHbY33ZfizVVwrM/UtF+akktNYosbuzVCoQyz8Tad8czriIVuZn9OTXojW1gJBRE7
 5EBP6GtskcsCrgjkG92vETqb+RXhrBD76QW40hxCpPi0Y8CDlkf28NG/C3m3Z4dZ1Qfw9o0dCwS
 4DZSkWvrCSgGx1zNxRbYmgfgBadzncfRdqdxSs3sJjdTcpHl1GU66Ukd4i5lY3sBETLCQLCtrEK
 KV4YjGVROZWU/tiTTZ8hsoPTc47Tk6DOVe/RCO5RhxH16g6Fsyxj9yu9L3Df5q1Cluxzrkvy02Y
 Dxmd9IDwtOVqZCR9dTpJMR01jD+Ls42Ql/Jg9DU9Dcilgs9u79tmQOWji5YsuLGKYjpsntX/ZtY
 4YA2J/5XL5LCURB9R/Ys0VjFRcBq33Jhyw0aEoiKmicnqzS9xfhzHQK0L9C8mLwg3KZHMh2ePVk
 XVKyDtMoSZPQ/fg==
X-Developer-Key: i=avrac@freebox.fr; a=openpgp;
 fpr=6225092072BB58E3CEEC091E75392A176D952DB4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Override the default max cursor size reported to userspace of 64x64.
MSM8998 hw cursor planes support 512x512 size, and other chips use DMA
SSPPs.

Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 6cce0f6cfcb01..2dd19b7aca0f8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1014,6 +1014,9 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
 	dpu_kms = to_dpu_kms(kms);
 	dev = dpu_kms->dev;
 
+	dev->mode_config.cursor_width = 512;
+	dev->mode_config.cursor_height = 512;
+
 	rc = dpu_kms_global_obj_init(dpu_kms);
 	if (rc)
 		return rc;

-- 
2.40.0

