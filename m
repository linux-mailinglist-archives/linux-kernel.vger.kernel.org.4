Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D600E6E4567
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDQKkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDQKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:40:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE79959D4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:40:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso15244347wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681727940; x=1684319940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmymNmbm0SFHzsUmDof5GjJMAJrAxQvLWm3ATdzKtGw=;
        b=PyvaEv2OMxFIha0wI5BblRADti0qMpbF1gYKEZVSU+3OQvz6SQLcjJhiL9ivyhdUJX
         Jb51hQ3SCun1pojTJp2CchSEKcFXvBfUJJu3MAmTMlpif8JME8EoPYWO8T/A1WKH63dn
         iCDX652nzriAxGav7OZ1aUKb9uc75SBq6ftsy7wQIDFQ77EmUqpdILH41UoDxSDq42fT
         Ik6pucLjrK09/Sp8YwnwEyv5Jq8q7Wmtra2+UPFgR6rkOqbnl857HapViUrvQozrv9an
         0Q4DU2D8AOcPqO45ccxzJzqe+0zpbiShI+j/zYpxofd5e/2sGWDs2H7WFvs3Yvt6R3RA
         NBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681727940; x=1684319940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmymNmbm0SFHzsUmDof5GjJMAJrAxQvLWm3ATdzKtGw=;
        b=LyPaP7g27DuC6yoyDgDZkU8JTfIOZ9jkllN6+ON/90qasSRxijdyWdEIToinLnOwJk
         J1DQfmEgl0wtujOptpmJeofOFJv9dATCf0jpL3HP1uCAz8VJPxdo5lEnKfluJ9jsMa3I
         1WnKCuNNwUfGitvYa4sXSHg35SNxxYnxbVctd5zQBWinj777lnf0U9tlVa0/xuyg0xd9
         1QZXMvSMtkvggmtoAF5ocnKX4Dq1DS8YT3iSj2waT9mHo/NbFsVXcU4mTAqmRnQrmWvX
         tS7UGXG/NIc/ACbzguJGYzfyBGKnL/4j8MHKKcxYqe1k56+vGRFyfVk0rgWumID3B5Df
         qWyQ==
X-Gm-Message-State: AAQBX9dy5CCa5p4tFGKBd+TEGsAvhOahJdzwzrisP1E8EQIPJEJ0FjWI
        tvcUujxw3j+8gFrG6nkZ0nc=
X-Google-Smtp-Source: AKy350YdU7qP4tBFqWVAJiivAblmNCnXdRCQFu60ob4m4TJL8g5SZDT0ZYc4RdPK2cbPhPtXmnnk3w==
X-Received: by 2002:a05:600c:292:b0:3f1:73ca:7807 with SMTP id 18-20020a05600c029200b003f173ca7807mr1703037wmk.37.1681727939919;
        Mon, 17 Apr 2023 03:38:59 -0700 (PDT)
Received: from localhost.localdomain (host-87-19-108-254.retail.telecomitalia.it. [87.19.108.254])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d470c000000b002c70ce264bfsm10238018wrq.76.2023.04.17.03.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:38:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matt Roper <matthew.d.roper@intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 0/3] drm/i915: Replace kmap() with kmap_local_page()
Date:   Mon, 17 Apr 2023 12:38:51 +0200
Message-Id: <20230417103854.23333-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

kmap() has been deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).

The tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and so they are still valid.

Furthermore, kmap_local_page() is faster than kmap() in kernels with
HIGHMEM enabled.

Thread locality implies that the kernel virtual addresses returned by
kmap_local_page() are only valid in the context of the callers. This
constraint is never violated with the conversions in this series,
because the pointers are never handed to other threads, so the local
mappings are allowed and preferred.

Therefore, replace kmap() with kmap_local_page() in drm/i915/,
drm/i915/gem/, drm/i915/gt/.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

v1->v2: Do some changes in the text of the cover letter and in the
commit messages. There are no changes in the code of any of the three
patches.

Fabio M. De Francesco (3):
  drm/i915: Replace kmap() with kmap_local_page()
  drm/i915/gt: Replace kmap() with kmap_local_page()
  drm/i915/gem: Replace kmap() with kmap_local_page()

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |  6 ++----
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |  8 ++++----
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |  4 ++--
 drivers/gpu/drm/i915/gt/shmem_utils.c              | 11 ++++-------
 drivers/gpu/drm/i915/i915_gem.c                    |  8 ++++----
 5 files changed, 16 insertions(+), 21 deletions(-)

--
2.40.0

