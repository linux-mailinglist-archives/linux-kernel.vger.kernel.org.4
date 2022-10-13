Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2AA5FE5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJMWzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJMWzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:55:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ABE27FD7;
        Thu, 13 Oct 2022 15:55:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y191so3283928pfb.2;
        Thu, 13 Oct 2022 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3mIhMnGoIlAKBRI/Lq6fsfZ+LtCgVnYV3UGZC28tNso=;
        b=paHg6qwWqBLQ5noiDCzwYHUpJLZ7es1HEAUGwJugYi/CxbiOs7YkC0rGO1cU/y+3Bl
         foWUZYr4kJjhbkD1tHtpB4EcAKb/ott4/yu5bxqoYnIuEOpaMJJIjF0OqnQpA00cCwEk
         Jyu0qHTLeVvVDJqrGj8l3mfwGTDpnXAoOCoe16xzs8c+VmOdcrRv/v0dVSlGBG3NUjU1
         H+gUjvBuDB/HIYPZZQ+p8bS7jVx48J6e8CY2BU5BRYSm5hbj5+XQTty5dzqT/N6+Ytwa
         2VltE5F4M2cf6hvFf394fcNJKL4GmXQCBxTZboqkuc3Qfr5dKQkn35IJBfcgZohi5/we
         fwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mIhMnGoIlAKBRI/Lq6fsfZ+LtCgVnYV3UGZC28tNso=;
        b=OWH8h7whw+15qTQJoQuY3eKbnoOxDOgTksL/Bcz2kIQquzn5/8CHUDucJbazrc4WHh
         vcj1owr2yJO1ZjTSDAZMsmKYffZR3XG8AIvyCYZPW/S0rITsouJ3zYDIyaL1Oi2HonJ7
         IsMRXAIM41p88qzhzwhCjpMm23w3nT3ONl4XghY51qJijiCZeEE8Eg3hiLBfbk1I685d
         ftuK3mRPd4OWGwVa398yxWiFoB00N4zjd3pWaX+uUQiQn1egdvn+5UwXirfmvlVAFsL2
         SXkt7HVIOAA9Ev+xDc44yw42fIjv42JZrSl1f4uhZNHdzBUULbhLVkgVuHvxC422TrO+
         FtMA==
X-Gm-Message-State: ACrzQf3p3wYviG6PPUfCc3d+wKhdWnjll8f9Uinlme8yl9ScTRpEkhwh
        WPz8WSdox/EkbMNHuCj+ce4=
X-Google-Smtp-Source: AMsMyM7SuFGVIsozC9eBZ2vZFWzV3HmleEVAV4yaykXpE0yjaBLytU8NySHH2qRaB+L31oLUIFoOQw==
X-Received: by 2002:a05:6a00:8d0:b0:53b:2cbd:fab6 with SMTP id s16-20020a056a0008d000b0053b2cbdfab6mr1890998pfu.3.1665701711666;
        Thu, 13 Oct 2022 15:55:11 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id i15-20020a62870f000000b00562adeac326sm213368pfe.102.2022.10.13.15.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:55:11 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Emma Anholt <emma@anholt.net>,
        linux-kernel@vger.kernel.org (open list),
        Sean Paul <sean@poorly.run>
Subject: [PATCH 0/3] drm/msm/a6xx: devcore dump fixes
Date:   Thu, 13 Oct 2022 15:55:12 -0700
Message-Id: <20221013225520.371226-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

First patch fixes a recently introduced memory corruption, the remaining
two are cleanups.

Rob Clark (3):
  drm/msm/a6xx: Fix kvzalloc vs state_kcalloc usage
  drm/msm/a6xx: Skip snapshotting unused GMU buffers
  drm/msm/a6xx: Remove state objects from list before freeing

 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 18 ++++++++++++++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     |  7 ++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.37.3

