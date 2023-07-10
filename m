Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093DD74CEED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGJHsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjGJHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:47:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70879138
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A65260EBC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9583AC433C8;
        Mon, 10 Jul 2023 07:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688975260;
        bh=ZnLegZTYWh/K3X7JD0kwUhEN9oYU73+PSH8syt7K1KQ=;
        h=From:Subject:Date:To:Cc:From;
        b=mXu/fCWjx4EQJSzByv2tfYtKaUeHkfU7FsYzu3TtjvXErSsm7G26ov3owDBIlpKWM
         tFJr3f18Ke39fl8gnpjqMB/BEeXLEKdB6Lb8LvfVxdJWSHpeGaCWgrGFfwxOByz0Dy
         O/K6rFMt5DJsggm4otvFIra2XQDjfnvoEfxY/JoFfa0kuGQaOEkUQzRFoiJ8pyHMql
         27h94eft41cxiXkuj8ij36US5efSIevgP69uWVz2BZ6CJ3jUVzBUDDU+aobsbyH2FL
         +1EWWPdVlAXvJXKoOiGzTYRNH8ZytP94D570g/RpUOekKbc4GsXpaelhqVVkc9vuVt
         teZYcoyyZqc9Q==
From:   Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 00/11] drm: kunit: Switch to kunit actions
Date:   Mon, 10 Jul 2023 09:47:31 +0200
Message-Id: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJO3q2QC/x2MywqDQAwAf0VyNrAPquiviAdd0xoWV0lsFcR/d
 +lxYGYuUBImhba4QOjHymvKYMsCwjykDyFPmcEZ501tDcZFMX4T7ziEPcuKQscqEV+TrXxdudD
 4EXK+Cb35/K+7/r4fwuGer2oAAAA=
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ZnLegZTYWh/K3X7JD0kwUhEN9oYU73+PSH8syt7K1KQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmrt0+XteKUMWCXL9ks+PSJ7vm9M1ras87eNVplZ6IeZeBQ
 GKjZUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgIl0xDEyvLmVVf2LwTttRrfNsZmTyy
 M3LPo13+b5+3bdmQcLGbQF1BgZvkiZ+TyYa/Hdfm6qdvfR8B+vjeMez83JenFUhEvvn/dKHgA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since v6.5-rc1, kunit gained a devm/drmm-like mechanism that makes tests
resources much easier to cleanup.

This series converts the existing tests to use those new actions were
relevant.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (11):
      drm/tests: helpers: Switch to kunit actions
      drm/tests: client-modeset: Remove call to drm_kunit_helper_free_device()
      drm/tests: modes: Remove call to drm_kunit_helper_free_device()
      drm/tests: probe-helper: Remove call to drm_kunit_helper_free_device()
      drm/tests: helpers: Create an helper to allocate a locking ctx
      drm/tests: helpers: Create an helper to allocate an atomic state
      drm/vc4: tests: pv-muxing: Remove call to drm_kunit_helper_free_device()
      drm/vc4: tests: mock: Use a kunit action to unregister DRM device
      drm/vc4: tests: pv-muxing: Switch to managed locking init
      drm/vc4: tests: Switch to atomic state allocation helper
      drm/vc4: tests: pv-muxing: Document test scenario

 drivers/gpu/drm/tests/drm_client_modeset_test.c |   8 --
 drivers/gpu/drm/tests/drm_kunit_helpers.c       | 112 ++++++++++++++++++++++-
 drivers/gpu/drm/tests/drm_modes_test.c          |   8 --
 drivers/gpu/drm/tests/drm_probe_helper_test.c   |   8 --
 drivers/gpu/drm/vc4/tests/vc4_mock.c            |   5 ++
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c  | 115 +++++++++---------------
 include/drm/drm_kunit_helpers.h                 |   7 ++
 7 files changed, 162 insertions(+), 101 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230710-kms-kunit-actions-rework-5d163762c93b

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

