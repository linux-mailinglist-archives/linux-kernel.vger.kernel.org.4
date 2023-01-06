Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A465FBC7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjAFHQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjAFHQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:16:13 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AAA6318E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 23:16:11 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id j130so484074oif.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 23:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3rrp6V7KWYZFDRr1re6vLXoec41Prjw9aIuZx3KbAjE=;
        b=hkSiAvZQ5q7niMrgTomLfzJbqJJ/y3VphW3KaB3hIgfneZUn6KtYbtnN9CVk1dZ80M
         S9WFDJb+OLC9+FZdZKPICuEorPEB7oLsq9c26ygU+XxZws0TqeJgbTzr6/EIVLtp4yA7
         /ySS0U1uhVo2lw5Q/teBBNvrz06FTo7U8cezt7jSYNzfa3U4PVTo2FN9Cfl1cIA16AIB
         ha/0NKomsCYw3MRO17h/tXbtnusSebPxaq/FeWsgH2cSY2zWJGs5T+47ZwSuASUgDj0O
         eWgs2aJ3HlBrWZ1Sr13PxTgZ71azW1FxRq175F3z8R7yS/X9Z+v3Ezh8EeBhgyzCL3cC
         XHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rrp6V7KWYZFDRr1re6vLXoec41Prjw9aIuZx3KbAjE=;
        b=4rDSPQPnHKBIAn3NNwvvc9Np/1iAQ6Yos+C2PprvYdni7CvdYKhuUhaClLrZq4rsky
         KaTS2+tkOKQh7b5wHtQLOrEhIWO0CHtKbhDFmf35Ij4c6DLuRnldH9eIOgtdJ5RxhK+R
         CcYdK3KhhIXTVz36RTx+wOgmsn4FkLrOLeeeFLcCHo9jiF0MGOU+70RXzPgTXVeaJXR/
         P690mP8vPAIC8n9lNxi38SB1HKydqlIEFvhKbmTAB92LbUHy+bLMOiZCE9mJAWM7w5cX
         xUgbDRrVzfQGbziAebGzad+ViEsv32qmvBbUziMPMWl/A5W4C7X/JQCDzS+WJ0cFEfLu
         VYFA==
X-Gm-Message-State: AFqh2kpvqALVDDOmunBjjbm8eG9HnutdpiZaIzjEnsUVugYWUhrbrKJC
        Ed8brdcMP327k0EQakIWNf1nkg==
X-Google-Smtp-Source: AMrXdXud5KDhZQApL7a3qEoR2W/iDOw8JuWICERDCbrP2ehGJAMny4mSwd3IA4pPORyRy6Mbqj9iYA==
X-Received: by 2002:aca:4207:0:b0:360:bc5d:2ed2 with SMTP id p7-20020aca4207000000b00360bc5d2ed2mr20527042oia.53.1672989371307;
        Thu, 05 Jan 2023 23:16:11 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id p3-20020aca5b03000000b0035c073aa0d8sm126616oib.18.2023.01.05.23.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:16:10 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     steev@kali.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: Set preferred depth.
Date:   Fri,  6 Jan 2023 01:16:09 -0600
Message-Id: <20230106071609.3948-1-steev@kali.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 37c90d589dc0 ("drm/fb-helper: Fix single-probe color-format
selection"), if no supported color formats are found, it tries to use the
driver provided default, which msm didn't have set and leads to the
following output:

msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
msm_dpu ae01000.display-controller: [drm] No compatible format found
------------[ cut here ]------------
WARNING: CPU: 0 PID: 73 at drivers/gpu/drm/drm_atomic.c:1604 __drm_atomic_helper_set_config+0x240/0x33c
Modules linked in: ext4 mbcache jbd2 msm mdt_loader ocmem gpu_sched llcc_qcom gpio_keys qrtr
CPU: 0 PID: 73 Comm: kworker/u16:2 Not tainted 6.2.0-rc2-next-20230106 #53
Hardware name: LENOVO 21BX0015US/21BX0015US, BIOS N3HET74W (1.46 ) 10/12/2022
Workqueue: events_unbound deferred_probe_work_func
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __drm_atomic_helper_set_config+0x240/0x33c
lr : __drm_atomic_helper_set_config+0x68/0x33c
sp : ffff800008a7b790
x29: ffff800008a7b790 x28: ffff73ee3e130a00 x27: 0000000000000000
x26: ffff73ee3d256e00 x25: 0000000000000038 x24: ffff73e6c0d65e00
x23: ffff73e6c17a7800 x22: ffff73e6c0d64e00 x21: ffff73e79c025e00
x20: 00000000c0d64e00 x19: ffff73ee3e130a00 x18: ffffffffffffffff
x17: 662074616d726f66 x16: 20656c6269746170 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa829144ff8bc
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff73e6c0d65f50 x4 : ffff73ee3d254950 x3 : ffff73e6c0d65ec0
x2 : ffff73ee3c953a00 x1 : ffff73e79c025580 x0 : 0000000000000000
Call trace:
__drm_atomic_helper_set_config+0x240/0x33c
drm_client_modeset_commit_atomic+0x160/0x280
drm_client_modeset_commit_locked+0x64/0x194
drm_client_modeset_commit+0x38/0x60
__drm_fb_helper_initial_config_and_unlock+0x528/0x63c
drm_fb_helper_initial_config+0x54/0x64
msm_fbdev_init+0x94/0xfc [msm]
msm_drm_bind+0x548/0x614 [msm]
try_to_bring_up_aggregate_device+0x1e4/0x2d0
__component_add+0xc4/0x1c0
component_add+0x1c/0x2c
dp_display_probe+0x2a4/0x460 [msm]
platform_probe+0x70/0xcc
really_probe+0xc8/0x3e0
__driver_probe_device+0x84/0x190
driver_probe_device+0x44/0x120
__device_attach_driver+0xc4/0x160
bus_for_each_drv+0x84/0xe0
__device_attach+0xa4/0x1cc
device_initial_probe+0x1c/0x2c
bus_probe_device+0xa4/0xb0
deferred_probe_work_func+0xc0/0x114
process_one_work+0x1ec/0x470
worker_thread+0x74/0x410
kthread+0xfc/0x110
ret_from_fork+0x10/0x20
---[ end trace 0000000000000000 ]---

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 8b0b0ac74a6f..65c4c93c311e 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -479,6 +479,7 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 	drm_helper_move_panel_connectors_to_head(ddev);
 
+	ddev->mode_config.preferred_depth = 24;
 	ddev->mode_config.funcs = &mode_config_funcs;
 	ddev->mode_config.helper_private = &mode_config_helper_funcs;
 
-- 
2.39.0

