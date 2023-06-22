Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB6C7397ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjFVHMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjFVHMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:12:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DAB1BE5;
        Thu, 22 Jun 2023 00:12:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98934f000a5so333339466b.2;
        Thu, 22 Jun 2023 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687417959; x=1690009959;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LnnCUI2XGWv9OUUv5C9cUpD2Y2mbvDs2GL4yDfqqOwI=;
        b=WokkXeHBtRxrHlyy2/xFvxbYYvfkcNIftGnQm6oCYJZBx6/HLMh8yxNs0GlMuBCBmF
         uP4jaqrstX2mcV90x6vrIqiEo3JEpjMNJlRAGbhdpEt421cD+t2Odb1zGpEm5mwAdEU/
         ckcua6pF8gMoVUXOTax3G1JGtGpLld4CXKyCCMlxPyS0E/4O8QOmbvf2Y8/Q4kJoPc+7
         1UEYg5EtO+RgFmBHt30t+xG0TPDZPCCZyQI4FiIwzFB508y5qly6D5XKSD7VVea+QhPM
         AUnZ14kpRnAtXaBVuxJsN7qLf6C1/s+QiMdS1K+eLDSGdsxhjMihsNrPCfzaBtgqLLd4
         jCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687417959; x=1690009959;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnnCUI2XGWv9OUUv5C9cUpD2Y2mbvDs2GL4yDfqqOwI=;
        b=LccxUT/eHuW/VgHFp4WrN491FxRekbHzIzgmhYDu1Aimsf+3c4BjQo5RPD56h4JAWx
         S2ffh23idX/xYMzxasziGRbvFegj1FUqLYmPF4zRkpGWHHzoggfTuXg+zwpAGs8RoMmR
         TO+pVaSGE3vwEhSyUJTTgnVQHlEGsJVqlA2XbxYuym+EJSUOhAUOq4Iifg7fFI+LJdNs
         RayjvzwEmZHbN6fDEPdFppNnXohJnFAoo/yBSMpi19RmaNJFz0nhbo9lTLJIyfKinuZS
         0cf0/OvZ+FsT9X5buSPzYY/dFYtiYVF//Ph26AUw7ozC0HwUj0cLlHVcTRijBfktYl5c
         fgkQ==
X-Gm-Message-State: AC+VfDwm5YFcEMRL1m2wA24L+KLEiqzlxVLCzxfZwHjBg0X9pdd0e9/R
        ayVRUTqVDwuXemJMZjTrc8B7k8d4B3R8Cg==
X-Google-Smtp-Source: ACHHUZ7ULiZqJOSc9kKACeB4oEsVZYM0IZtsRc+uaKWKnBr+/Z/ld0jA++qn26Ua4hvN8s4BSwxmZw==
X-Received: by 2002:a17:906:5d10:b0:988:922b:7a86 with SMTP id g16-20020a1709065d1000b00988922b7a86mr9119121ejt.39.1687417958982;
        Thu, 22 Jun 2023 00:12:38 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id bq26-20020a170906d0da00b0096f5b48fe43sm4134923ejb.47.2023.06.22.00.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:12:38 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH WIP RFC v2 0/2] media: uapi: Add V4L2_CID_VTOTAL control
Date:   Thu, 22 Jun 2023 09:12:22 +0200
Message-Id: <20230609-v4l2-vtotal-v2-0-cf29925f4517@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFb0k2QC/21OPQvCMBT8K/JmI2laDToJguAmLg7S4SV5tcG2k
 SQEpfS/m3Z2Ou6LuxECeUsBDqsRPCUbrBsyEesV6BaHJzFrMgfBRcl3fM9S1QmWoovYMVLF1pR
 SY0MIuaEwEFMeB93OnR5DJD8bb0+N/SwzD7hfrrN2O5+gztjaEJ3/Lg9SsST+jqWCcVYpaYgkc
 VnSMbyswYgb7Xqop2n6Ad52XlXNAAAA
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series adds new controls for the vertical and horizontal total
size. Camera sensors usually have registers regarding the total size and
not the blanking size. Also user space prefers to calculate with total
frame sizes. Therefore, this would simplify implementations on both
sides and could be seen as a replacement or upgrade for V4L2_CID_VBLANK.
Additionally, its value is independent from format changes and therefore
simplifies calculations in user space.

For v2, I added a little bit more documentation and my personal
expectations to 1/2. As I am fairly new to the camera world, they might
be a little bit naive so please correct me if this is utopical. I added
the RFC tag for that reason. However, my intention is to define a
documented behaviour regarding the values and limits which could
basically depend on HTOTAL. Currently, HBLANK is always set to the
minimum in libcamera (I guess to simplify calculations). I think with
HTOTAL, we could always use WIDTH_MAX(all modes) + HBLANK_MIN(WIDTH_MAX)
as default to enable a constant frame size. If the current HTOTAL value
differs from the default, we could infer that the user wants to either
have a higher frame rate, or a higher exposure and could adapt to that.
E.g. use the minimums to get the highest frame rate possible if the
current values are outside of the possible range, or not limiting the
exposure control by the current vertical blanking as it is done now. I
guess this would help the driver to "understand" the needs of the user
space, and therefore allow it to react in a defined and expected manner.

2/2 is a WIP (same as in v1) and currently implements VTOTAL for the
imx290, basically extending the current V4L2_CID_VBLANK implementation.

Thanks Dave for the feedback, insights and the examples (ov5647,
ov9282). I might need some time to skim through the data sheets to learn
why they do stuff like it is done now.

---
Changes in v2:
- 1/2: add HTOTAL
- 1/2: add documentation about expectations
- Link to v1: https://lore.kernel.org/r/20230609-v4l2-vtotal-v1-0-4b7dee7e073e@skidata.com

---
Benjamin Bara (2):
      media: uapi: Add V4L2_CID_{V,H}TOTAL controls
      media: i2c: imx290: Add support for V4L2_CID_VTOTAL

 Documentation/driver-api/media/camera-sensor.rst   | 11 ++++-
 .../media/v4l/ext-ctrls-image-source.rst           | 16 ++++++++
 drivers/media/i2c/imx290.c                         | 47 ++++++++++++++++------
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  2 +
 include/uapi/linux/v4l2-controls.h                 |  2 +
 5 files changed, 64 insertions(+), 14 deletions(-)
---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230609-v4l2-vtotal-eb15d37cafea

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

