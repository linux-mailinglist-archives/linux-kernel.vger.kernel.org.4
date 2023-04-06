Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7646DA578
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbjDFWAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbjDFV7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:59:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CA1B47B;
        Thu,  6 Apr 2023 14:59:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so44176280pjt.2;
        Thu, 06 Apr 2023 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680818372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh/cSP01X7baGcBhRNO/UI6rxYCvlWhn8fT2Xxx8V1w=;
        b=azChA4iepORRwqBwYlga8jmqES47PmBJA5H4jRgGIU3000G70/o9VhARuDB1XtGsBc
         mH8UaxWpwVLdiaLlBaJaU55y4KuwD9IKO9Ua3KkuHO+LNup8POI2vC3l9CingB0a0eu9
         nWVoSeBc8hrKvw1nfAAPnDs20BeohnBGxnO7eFF6yGE8jfDH03BImspXFCQ/xyc+jP/U
         IPhGxj1EVBH2GxK69LIGwDmemiYftXGPY146TYIXu9BfECVe1ElHW7Oh03WIXB5iGqU/
         asZ41EYXFuQJDgQRDOZW07YbL24980B2UX2NHmrVRLIHlkFcf62y5ROmZkLW8H098J2Q
         sD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680818372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sh/cSP01X7baGcBhRNO/UI6rxYCvlWhn8fT2Xxx8V1w=;
        b=OAzBhhpWrpNIKLzl7gjijqyrcwIvlIfPTUi2a1LwUZPDFS9m3dw8lnBbbNHw7p0n2a
         pk6WvCCuu79JoALkfPS1hFHbUspAG/zCu5TjSGHNYALbXPqJLrHuSMIdji2FTrMqh0/q
         f0sfoSsKkGZ3eW8c7g8CYuLbTXj/NhJ3viJjifqg5PpJaXRUILqSWSfqfHVjeZ/VdM10
         wq+6Y7R6fvqOziFgh51Ok27pVMjkrhMmAwIrd4j0PAnyAMqCVpjHm3cCOwRivueZXNPw
         NORrkRypMBKqP21itXKTBYb51fShEL8uNho6Fprqgo7zPMnuRBxwElNIINe5QnEsURwA
         h7gA==
X-Gm-Message-State: AAQBX9dFSVwMLoie7VBy0g8BpkWT1zzG3TX35M5X4Jp/7aDbeHaWoPgF
        DiAy1gD4k8EsBzzsK2IiSeQ=
X-Google-Smtp-Source: AKy350bo4KJeNsRKbrWCg7w+eKRCQynE4zWn4ZdEYUZrNEVMBtjR+F8D6ulk5dyu7iGJS3DU+v2I3A==
X-Received: by 2002:a05:6a20:8bb0:b0:d9:4c19:fe6a with SMTP id m48-20020a056a208bb000b000d94c19fe6amr746759pzh.9.1680818372270;
        Thu, 06 Apr 2023 14:59:32 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b005a87d636c70sm1790621pfu.130.2023.04.06.14.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:59:31 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        Sean Paul <sean@poorly.run>
Subject: [RFC 0/2] drm: fdinfo memory stats
Date:   Thu,  6 Apr 2023 14:59:15 -0700
Message-Id: <20230406215917.1475704-1-robdclark@gmail.com>
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

TODO gputop support?

[1] https://patchwork.freedesktop.org/series/112397/

Rob Clark (2):
  drm: Add fdinfo memory stats
  drm/msm: Add memory stats to fdinfo

 Documentation/gpu/drm-usage-stats.rst | 21 +++++++
 drivers/gpu/drm/drm_file.c            | 79 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.c         | 26 ++++++++-
 drivers/gpu/drm/msm/msm_gpu.c         |  2 -
 include/drm/drm_file.h                | 10 ++++
 5 files changed, 135 insertions(+), 3 deletions(-)

-- 
2.39.2

