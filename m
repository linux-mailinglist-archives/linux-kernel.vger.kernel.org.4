Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1635B6DCC98
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDJVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDJVGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:06:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7974D1737;
        Mon, 10 Apr 2023 14:06:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ik20so5645953plb.3;
        Mon, 10 Apr 2023 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681160780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mw7PIDF324rj5JmiBp3Gcc4Fg2iuz1Tt4YTUd4kugdk=;
        b=a68QFzn1xixO15odT51vAd9u8PE/r3KgLLy3lgULiikNLxbWZc1f7JczaJVfAKkZQI
         pyUH/X3rpI0J+idTdkgL0jPeK847Y/6kFnjXjCA0hm/Uq7AL1NZYR4tfmge2JNjCq7oX
         rGVGYVunI3aFL+9V1gkWlzCAYY9qSrUoG543VJZfTf7GXytYKAGiCUHVb6CAo5J3Fgeq
         0GNZS4cgqC/53a+Q6ZjdEG7JHGkntMEBZruSqBH7tOCcycBWoWoMLzrwtSBTaJN0EIuL
         IW1cmGWfMw5Yhhl8uU/8rify1v7DkpSS1526TkroQrtSK1L4s0g6/CPS3nqbOA/5aT4B
         fOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mw7PIDF324rj5JmiBp3Gcc4Fg2iuz1Tt4YTUd4kugdk=;
        b=oKjcadyVnhO62Yd1LoeBSIvx5CcVF98rF0pZozdL3pDQutUGhqA2rw6wz7xAHA4LAy
         upKRLOhj7pAaArUkt8aMCorYFZ5tHgddRxvQRZz0oeAMl5BIrhuqSLl101eHAcNRQUkk
         ctfhxi04RZoNDANHbb3oyAsEx8GCcGf8a1CFSjumgvP+NxsS+E28bB/89rWGDDK9jclk
         02I9iKv9s+Uat38OuQL1x/1vcNpt2m8pdk1VIhfvtb2sS/HMaH4DqSMis7ma3UYpd4f8
         ekrj6LjeyC4HUdD8H0TgceNzFomPVTl7zbMOA0xfVGD3hfFveTq2NTnvq5QX2P6IC/GK
         DvIA==
X-Gm-Message-State: AAQBX9fTIIMmbuajkq+WtFaGlU1weCcxwBQOmmbAyLPLhwtwC0k5Pi9G
        XcN1ild/WVCOKImAuc3C+r9A5Vly9fo=
X-Google-Smtp-Source: AKy350ZeqUgG7R7usICFzaYvDiaV5ajgBpKig+9DQsFboh4/q+hNdEvXbo7HjMPoHIBYsXHdB4ZACg==
X-Received: by 2002:a17:903:124f:b0:1a5:5e7:a1c9 with SMTP id u15-20020a170903124f00b001a505e7a1c9mr347008plh.61.1681160779826;
        Mon, 10 Apr 2023 14:06:19 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c20300b001a647709864sm1812180pll.155.2023.04.10.14.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 14:06:19 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        Sean Paul <sean@poorly.run>
Subject: [PATCH v2 0/2] drm: fdinfo memory stats
Date:   Mon, 10 Apr 2023 14:06:05 -0700
Message-Id: <20230410210608.1873968-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Similar motivation to other similar recent attempt[1].  But with an
attempt to have some shared code for this.  As well as documentation.

It is probably a bit UMA-centric, I guess devices with VRAM might want
some placement stats as well.  But this seems like a reasonable start.

Basic gputop support: https://patchwork.freedesktop.org/series/116236/
And already nvtop support: https://github.com/Syllo/nvtop/pull/204

[1] https://patchwork.freedesktop.org/series/112397/

Rob Clark (2):
  drm: Add fdinfo memory stats
  drm/msm: Add memory stats to fdinfo

 Documentation/gpu/drm-usage-stats.rst | 21 +++++++
 drivers/gpu/drm/drm_file.c            | 79 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.c         | 25 ++++++++-
 drivers/gpu/drm/msm/msm_gpu.c         |  2 -
 include/drm/drm_file.h                | 10 ++++
 5 files changed, 134 insertions(+), 3 deletions(-)

-- 
2.39.2

