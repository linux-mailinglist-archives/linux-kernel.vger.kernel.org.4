Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9BC63F08D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiLAMcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLAMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:32:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D3CBA085
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:32:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EFA961FD4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B773CC433D7;
        Thu,  1 Dec 2022 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669897931;
        bh=MXm6wVDy/1Dk2GqWOrBo8woDf8D58qZtiQYEYC8VNEo=;
        h=From:To:Cc:Subject:Date:From;
        b=IxFqPM5Sf3/GilRQHZpk9Ea0GbwtgNyX7mkwuJdpOoAAF3goS0uqTXhrPMwGtJM3E
         0GfYUV69dNLm7EWsUJpKZQ/KC6Bh3ItN4/6VB6oiBxXX7Skofrv6vsOfJiV3+cP2hn
         o7tEqNP9Y43+ZmDixl/gpwqpX2Omc6PsAY+JrxVMsXIEGH2TJRbAxo6DdU9ep1kkkE
         eZNfR4UUDJp1EEfvWgdfmr+Z+ztZ4YCS1BqzpkFssPi8shckFIYSTF6Ok/37ckoRTb
         LfQ+xu+ETq5F1JIbRw/5I080MlGzfvjrlfTGRcBapBlBeuZ7jTERyPMZ5r+NCfGlc1
         +XX0lB3wXsTjQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1p0ijY-00FYFG-2p;
        Thu, 01 Dec 2022 12:32:08 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add KUnit support for i915 mock selftests
Date:   Thu,  1 Dec 2022 12:32:04 +0000
Message-Id: <cover.1669897668.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's an updated version of my previous KUnit RFC series:
	https://patchwork.freedesktop.org/series/110481/

While the RFC series added support for live and perf, let's start with
mock, as running tests in bare metal is not the current focus of KUnit.
So, basically patch 1 was changed to export just mock functions,
and the bare metal patches got removed from this version.

As before, running KUnit on i915 driver requires the --arch parameter:

./tools/testing/kunit/kunit.py run --arch=x86_64 --kunitconfig=drivers/gpu/drm/i915/selftests/  --jobs=`nproc --all`
[13:18:40] Configuring KUnit Kernel ...
[13:18:40] Building KUnit Kernel ...
Populating config with:
$ make ARCH=x86_64 O=.kunit olddefconfig
Building with:
$ make ARCH=x86_64 O=.kunit --jobs=8
[13:23:20] Starting KUnit Kernel (1/1)...
[13:23:20] ============================================================
Running tests with:
$ qemu-system-x86_64 -nodefaults -m 1024 -kernel .kunit/arch/x86/boot/bzImage -append 'kunit.enable=1 console=ttyS0 kunit_shutdown=reboot' -no-reboot -nographic -serial stdio
[13:23:21] ============ i915 mock selftests (18 subtests) =============
[13:23:21] [PASSED] mock_sanitycheck
[13:23:21] [PASSED] mock_shmem
[13:23:24] [PASSED] mock_fence
[13:23:25] [PASSED] mock_scatterlist
[13:23:27] [PASSED] mock_syncmap
[13:23:27] [PASSED] mock_uncore
[13:23:27] [PASSED] mock_ring
[13:23:27] [PASSED] mock_engine
[13:23:31] [PASSED] mock_timelines
[13:23:32] [PASSED] mock_requests
[13:23:32] [PASSED] mock_objects
[13:23:32] [PASSED] mock_phys
[13:23:32] [PASSED] mock_dmabuf
[13:23:38] [PASSED] mock_vma
[13:23:38] [PASSED] mock_evict
[13:23:41] [PASSED] mock_gtt
[13:23:42] [PASSED] mock_hugepages
[13:23:42] [PASSED] mock_memory_region
[13:23:42] =============== [PASSED] i915 mock selftests ===============
[13:23:42] ============================================================
[13:23:42] Testing complete. Ran 18 tests: passed: 18
[13:23:42] Elapsed time: 302.766s total, 0.003s configuring, 280.393s building, 22.341s running

Mauro Carvalho Chehab (3):
  drm/i915: place selftest preparation on a separate function
  drm/i915: export all mock selftest functions
  drm/i915: allow running mock selftests via Kunit

 drivers/gpu/drm/i915/Kconfig                  | 15 +++
 drivers/gpu/drm/i915/Makefile                 |  5 +
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  1 +
 .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  1 +
 .../drm/i915/gem/selftests/i915_gem_object.c  |  1 +
 .../drm/i915/gem/selftests/i915_gem_phys.c    |  1 +
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |  1 +
 drivers/gpu/drm/i915/gt/selftest_ring.c       |  1 +
 drivers/gpu/drm/i915/gt/selftest_timeline.c   |  1 +
 drivers/gpu/drm/i915/gt/st_shmem_utils.c      |  1 +
 drivers/gpu/drm/i915/i915_selftest.h          |  2 +
 drivers/gpu/drm/i915/selftests/.kunitconfig   | 12 +++
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  1 +
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  1 +
 drivers/gpu/drm/i915/selftests/i915_kunit.c   | 95 +++++++++++++++++++
 drivers/gpu/drm/i915/selftests/i915_request.c |  1 +
 .../gpu/drm/i915/selftests/i915_selftest.c    | 23 +++--
 .../gpu/drm/i915/selftests/i915_sw_fence.c    |  1 +
 drivers/gpu/drm/i915/selftests/i915_syncmap.c |  1 +
 drivers/gpu/drm/i915/selftests/i915_vma.c     |  1 +
 .../drm/i915/selftests/intel_memory_region.c  |  1 +
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  1 +
 drivers/gpu/drm/i915/selftests/scatterlist.c  |  1 +
 23 files changed, 161 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/selftests/.kunitconfig
 create mode 100644 drivers/gpu/drm/i915/selftests/i915_kunit.c

-- 
2.38.1


