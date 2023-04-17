Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57D96E516C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDQUMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDQUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:12:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635EC46AC;
        Mon, 17 Apr 2023 13:12:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q2so32018798pll.7;
        Mon, 17 Apr 2023 13:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681762339; x=1684354339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c9ZcH/UsIU/GcQvCDP1QRyb831wl6lpWFQtu8V+MLrA=;
        b=JLFDGszkk3bWSS4oOn0Z5jXx5pu5tQyCXMtYa7M5wXTMF4vf86At8265QTzScrAoj8
         +O8gZyxn1daqdjD1dpgIeMzX2XDqD94nLo6iKJN2Knuglbukt5stAF1HMUg79eAdk9qr
         t1tg3XFRM5FxUHB2R2vbZn+EM1piSSFQWJ3WjLHiDvX4klcR8VdUFmbCHiaO2C8vYQgc
         jEylp4v/NvZjQCtmeY58poEjl7g2SUbTBjDZSVPmMP7uFif42uNOY8MDBXaqjaWwT2w0
         uqbKqOH2TXothSMwU5CD0xtVKHrATYvPRWZAP8+in3UhMba9lNuTXbq74R34YlfHbvHL
         27BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681762339; x=1684354339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9ZcH/UsIU/GcQvCDP1QRyb831wl6lpWFQtu8V+MLrA=;
        b=FJ/cKom59BuSlAm2POQvzno9fieKd2z/7DvI+snGoCApR5Yk9xUW3+73ihVnGlu3J9
         vaCnTL99HmmVxyJi8kYIzajoF+no+0xD7i2k356Ql4sIvtZBwL3tXBt7v1lJOXyFlzQY
         3R1OjnrN3pSUcNFzewsW/QkTlPiMbAgqh4Pnr6hVWk1L3Bxwvu8kTGIH3zKLPzgC4L2G
         NIGzpQhGvikVVttoTY6GCoh88+06qP7JbTTRNTMgdD1Dd5tqKWyJvXRFLMK/UCMsxwId
         evL/LGy/QRp5KWXk9T+z7PqaJU48aJDVCdYTamTO1G34MP8Qh8qcjBE1pwIGfPUNFqaC
         kWDQ==
X-Gm-Message-State: AAQBX9ewgbJ+MuT3zPVcejGrxPjhxP4LdRyjJlB25aG6NWxic5BWUEM2
        7GcNoSVCg4+kCat0l3g9vw4=
X-Google-Smtp-Source: AKy350YD7UMGXIJ56E5NzWJ0ernvcLLeIW8Ry6wjCWgcRxvgxJ0fIYk2uFG9KJbQD74pEtwQSbpohQ==
X-Received: by 2002:a17:902:854b:b0:1a2:9dd8:d646 with SMTP id d11-20020a170902854b00b001a29dd8d646mr75485plo.54.1681762338766;
        Mon, 17 Apr 2023 13:12:18 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b001a69dfd918dsm6166625plj.187.2023.04.17.13.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:12:18 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        Sean Paul <sean@poorly.run>
Subject: [RFC 0/3] drm: Add comm/cmdline fdinfo fields
Date:   Mon, 17 Apr 2023 13:12:09 -0700
Message-Id: <20230417201215.448099-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

When many of the things using the GPU are processes in a VM guest, the
actual client process is just a proxy.  The msm driver has a way to let
the proxy tell the kernel the actual VM client process's executable name
and command-line, which has until now been used simply for GPU crash
devcore dumps.  Lets also expose this via fdinfo so that tools can
expose who the actual user of the GPU is.

Rob Clark (3):
  drm/doc: Relax fdinfo string constraints
  drm/msm: Rework get_comm_cmdline() helper
  drm/msm: Add comm/cmdline fields

 Documentation/gpu/drm-usage-stats.rst   | 37 +++++++++++++++----------
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 +--
 drivers/gpu/drm/msm/msm_drv.c           |  2 ++
 drivers/gpu/drm/msm/msm_gpu.c           | 27 +++++++++++++-----
 drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++--
 drivers/gpu/drm/msm/msm_submitqueue.c   |  1 +
 6 files changed, 58 insertions(+), 25 deletions(-)

-- 
2.39.2

