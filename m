Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD16B6C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 00:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCLXbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 19:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCLXbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:31:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF129E30
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:31:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o12so41929120edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678663901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2rvudHbVOnChl+qv6wpA7Rv7tbiy4zwUQFXOr8Etec=;
        b=M4/CsfGzgYjfR7vq5RWFJ5NA/pMXRo9vyLWdReUw7STD/2XdCxaVrFJRa4ZwO2bLmO
         cAbypT6lboJKehK2335G5sBAX4mdmJB3Tao+wqKFNhRtAKiEQhndA+VpWe+V4voxJRHR
         N4nl9TpP/BiydCJS7P9dKDpHwZCL8CHV0yC1B7nPuH0rX09IbJpvi2CWmpS5URHn5QHc
         V26+32xE+wpVbpsImlYyGimR90E4HcPUsvB6eJ/8asG/nB1exwojkmnJkc+JdeamOA7y
         suxmpk+S5r8KvRNhQ7fCRvWg7OK9c2SwRKv1WxDhRyxeEpaCfCKSXfc6HhHfeyIYjJwz
         d8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678663901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2rvudHbVOnChl+qv6wpA7Rv7tbiy4zwUQFXOr8Etec=;
        b=gquy/uZs5t8ZiPWLxPFM14x691bVCe/9Ither7zYD+bGjFcgl1d17JS1dUcIcT7+ja
         55FNIzSqiFzK6cp4zuO67bq1LJMlb7REf6yTlHPZBXZJh58Rh0bI6JE6istcObLZDQPe
         z30FsZtTyRmyja2r6pcNaXixA8OTrV+7d4b6TjFUXhiQHd2g+vBxiEXmNpj3EF0DmAub
         VkuTcq89Ky/HGuDYhEaDlLwDA6BtHZ64hFhyI6qhJ+RDAoxTkDTe7Iym9x+6CuJBwtXy
         w+Ft/ctm3b9+VdZugh0OhKaoKo4u07KnfbWDbssCXQAeYmp3CGAxAjMxjAUGcPe6EifF
         R4Jw==
X-Gm-Message-State: AO0yUKUmnhckTIR+T7MPLsfbhwOQHvl0Y3XMgnFwLRXD7EwW9S90rHKe
        F0GOJkBix2/8woP7AkLLX6g=
X-Google-Smtp-Source: AK7set8cQScks8ot0O62oZWVmp8qWom24It6qknbChj5ZCrWu4454GxJehIokI7MUfPZAkYOO++kbQ==
X-Received: by 2002:a17:906:1c59:b0:924:a66:df8e with SMTP id l25-20020a1709061c5900b009240a66df8emr4940857ejg.26.1678663901294;
        Sun, 12 Mar 2023 16:31:41 -0700 (PDT)
Received: from centennial.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id vv11-20020a170907a68b00b009226f644a07sm2009958ejc.139.2023.03.12.16.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 16:31:40 -0700 (PDT)
From:   Erico Nunes <nunes.erico@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH 0/3] drm/lima: expose usage statistics via fdinfo
Date:   Mon, 13 Mar 2023 00:30:49 +0100
Message-Id: <20230312233052.21095-1-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Expose lima gp and pp usage stats through fdinfo, following
Documentation/gpu/drm-usage-stats.rst.
Borrowed from these previous implementations:

"df622729ddbf drm/scheduler: track GPU active time per entity" added
usage time accounting to drm scheduler, which is where the data used
here comes from.

Then the main implementation is based on these etnaviv commits:
"d306788b6e1b drm/etnaviv: allocate unique ID per drm_file" and
"97804a133c68 drm/etnaviv: export client GPU usage statistics via
fdinfo"

Also "874442541133 drm/amdgpu: Add show_fdinfo() interface" since lima
has a context manager very similar to amdgpu and all contexts created
(and released) at the ctx_mgr level need to be accounted for.

Tested with the generic "gputop" tool currently available as patches to
igt, a sample run with this patchset looks like this:

DRM minor 128
    PID               NAME             gp                        pp
    4322   glmark2-es2-way |█████▊                  ||██████████████████      |
    3561            weston |▎                       ||███▌                    |
    4159          Xwayland |▏                       ||▉                       |
    4154          glxgears |▏                       ||▎                       |
    3661           firefox |▏                       ||▏                       |


Erico Nunes (3):
  drm/lima: add usage counting method to ctx_mgr
  drm/lima: allocate unique id per drm_file
  drm/lima: add show_fdinfo for drm usage stats

 drivers/gpu/drm/lima/lima_ctx.c    | 30 ++++++++++++++++++++-
 drivers/gpu/drm/lima/lima_ctx.h    |  3 +++
 drivers/gpu/drm/lima/lima_device.h |  3 +++
 drivers/gpu/drm/lima/lima_drv.c    | 43 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/lima/lima_drv.h    |  1 +
 5 files changed, 78 insertions(+), 2 deletions(-)

-- 
2.39.2

