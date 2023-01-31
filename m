Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA3868389A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjAaV1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjAaV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:27:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2903A2A161
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:27:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mf7so26906571ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UPHb9Bsg7XnLtZlGu8iBeFHnSWk2xaqAByJ9kz45QiU=;
        b=eXDPyJzC6mP1/DejSYtt3dZCAfrvyZu6vzFT9kus3VmOHTARwED9L3vl5X2u97KeFP
         GsrvTuObim8SGQUUTV4gYTl+l54bkIZgBVVRSwkqSH5PY0SRscE4vsPwMdawpoJBZxTp
         NuwfFiElj6/WvWoJtxvuiZcuEDDqwAc8ZWJN4KLocv3fKIL6nmgU94F+3gN19d109fMs
         SF9HWDQqoFUba6skk2NmU9KwGdXSoUDDkEaimoZNSulQhDWQrVd879IEQC1j8Kp8+IHl
         6CWQ+NVciFNXpZC4A7XGJeNSUK6wgTTLOLi1/OqrZc0tk3I3s8Qum8XMkWpP10PyG3di
         04bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPHb9Bsg7XnLtZlGu8iBeFHnSWk2xaqAByJ9kz45QiU=;
        b=kGXo8hJJt+UUc70QzaJ++DDfHs8QDE7FP4VJGSDJt1zfNB2ND4bn4rjbgFvwqBunwo
         MihDYMKFnWXlEKjl80d43szN+R3EDge3/G+KUMkiRCM2sDJFr7C9/sCdBp1PPTzQVxEt
         xUD4vlLBPFWqIYlhH9YZlB1WpT042YymYhr8q3zRzjExPc3j5AZjw2qIzeWPBMVzRIp5
         xN0HUmJKEGw6cbleTYhwNoINofW70XoLivmItRXdkca6m1xiLugGEZM1+9G21IdrK238
         ZcncU6LCulpLHJX0rBFntIc3lZvjXM2/ISs46VOPP6tNMAbC2mnz1cbwjYiXYHnpqAIf
         vxtg==
X-Gm-Message-State: AO0yUKUyte2HEPEG5jamW+nKcrJVprwHe4+y5oCnNT0+61QBzLhtoEAZ
        n1sxnfAX27lv1/6RINdMBkArEtIR6X1wqw==
X-Google-Smtp-Source: AK7set99EkwKPqyoQdaLexL+L052uaSjN0Ir+9Y6oioYQDmKBHuZg0vTXzuboJ70CwAPoarVPXJUYw==
X-Received: by 2002:a17:906:e218:b0:887:8076:ee54 with SMTP id gf24-20020a170906e21800b008878076ee54mr10389753ejb.37.1675200460596;
        Tue, 31 Jan 2023 13:27:40 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id x25-20020a170906711900b00878b89075adsm8210390ejj.51.2023.01.31.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 13:27:40 -0800 (PST)
Date:   Tue, 31 Jan 2023 22:27:23 +0100 (CET)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
To:     linux-kernel@vger.kernel.org
cc:     trivial@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] Remove a number of duplicate includes
Message-ID: <52d6ec2f-417c-8bc5-ed35-72229fc8d7a0@gmail.com>
User-Agent: Alpine 2.26 (LNX 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 09d653f07a8bbb2aea52b735a731ca781f5f401c Mon Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Thu, 26 Jan 2023 02:16:59 +0100
Subject: [PATCH] Remove a number of duplicate includes

Including the same header multiple times when there's no functional reason
to do so is just pointless clutter and potentially slows down builds.

Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
---
  drivers/base/node.c                     | 1 -
  drivers/bus/bt1-apb.c                   | 1 -
  drivers/char/hw_random/core.c           | 1 -
  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 -
  drivers/gpu/drm/drm_gem_shmem_helper.c  | 1 -
  fs/fscache/io.c                         | 1 -
  fs/overlayfs/inode.c                    | 1 -
  kernel/sched/build_utility.c            | 1 -
  kernel/sched/core.c                     | 3 ---
  kernel/sched/fair.c                     | 2 --
  10 files changed, 13 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index faf3597a96da..4306611ac092 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,7 +20,6 @@
  #include <linux/pm_runtime.h>
  #include <linux/swap.h>
  #include <linux/slab.h>
-#include <linux/hugetlb.h>

  static struct bus_type node_subsys = {
  	.name = "node",
diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index 63b1b4a76671..fd198577cdb3 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -22,7 +22,6 @@
  #include <linux/clk.h>
  #include <linux/reset.h>
  #include <linux/time64.h>
-#include <linux/clk.h>
  #include <linux/sysfs.h>

  #define APB_EHB_ISR			0x00
diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index f34d356fe2c0..ead998ca0c40 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -21,7 +21,6 @@
  #include <linux/sched/signal.h>
  #include <linux/miscdevice.h>
  #include <linux/module.h>
-#include <linux/random.h>
  #include <linux/sched.h>
  #include <linux/slab.h>
  #include <linux/uaccess.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 55e0284b2bdd..f99251861c08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -43,7 +43,6 @@
  #include <linux/sizes.h>
  #include <linux/module.h>

-#include <drm/drm_drv.h>
  #include <drm/ttm/ttm_bo_api.h>
  #include <drm/ttm/ttm_bo_driver.h>
  #include <drm/ttm/ttm_placement.h>
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index b602cd72a120..6f794db17059 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -10,7 +10,6 @@
  #include <linux/shmem_fs.h>
  #include <linux/slab.h>
  #include <linux/vmalloc.h>
-#include <linux/module.h>

  #ifdef CONFIG_X86
  #include <asm/set_memory.h>
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 0d2b8dec8f82..ac9f19388bfb 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -9,7 +9,6 @@
  #include <linux/uio.h>
  #include <linux/bvec.h>
  #include <linux/slab.h>
-#include <linux/uio.h>
  #include "internal.h"

  /**
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ee6dfa577c93..e6aba8c21efc 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -8,7 +8,6 @@
  #include <linux/slab.h>
  #include <linux/cred.h>
  #include <linux/xattr.h>
-#include <linux/posix_acl.h>
  #include <linux/ratelimit.h>
  #include <linux/fiemap.h>
  #include <linux/fileattr.h>
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 99bdd96f454f..80a3df49ab47 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -34,7 +34,6 @@
  #include <linux/nospec.h>
  #include <linux/proc_fs.h>
  #include <linux/psi.h>
-#include <linux/psi.h>
  #include <linux/ptrace_api.h>
  #include <linux/sched_clock.h>
  #include <linux/security.h>
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e838feb6adc5..f3bba4b8c430 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -84,12 +84,9 @@

  #include "sched.h"
  #include "stats.h"
-#include "autogroup.h"
-
  #include "autogroup.h"
  #include "pelt.h"
  #include "smp.h"
-#include "stats.h"

  #include "../workqueue_internal.h"
  #include "../../io_uring/io-wq.h"
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f8736991427..e6a11380b47b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -50,8 +50,6 @@

  #include <asm/switch_to.h>

-#include <linux/sched/cond_resched.h>
-
  #include "sched.h"
  #include "stats.h"
  #include "autogroup.h"
-- 
2.39.1

