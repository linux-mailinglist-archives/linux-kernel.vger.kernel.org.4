Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C1B63860F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKYJZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYJZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:25:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8502B18F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:25:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7708D6231E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED728C433C1;
        Fri, 25 Nov 2022 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669368331;
        bh=B62OES+YOnQQ6Yv0WIo/pUftJIfqLaBkNFM1pIRlO/0=;
        h=From:To:Cc:Subject:Date:From;
        b=XWjsOO2B24TFK3PAfHzTJAs2eADRomRdpdE/iy3C4mmB1/IPSisPHbwGOqWsFTIP3
         JQ10+8Ol7NVzD28vqtJ5z3R+3+Ui3pdtZGLLO6reKQSNrlu5XrncUcY/JGMc+woWyR
         bchexoyydsUGV3BzbUJekFeQWZjEz4Bs34tX8VPtlYV/ydLQphj1rvm6ECg7blsRUQ
         DoZvph2NgB5viQoshO3DaJ+73Xw2uS/k4WFMj9/68G/qM/3EH/PnCgxHwxcFtYzEKC
         Hq2QctAxMnQWsyUP1BAa6m9jN3PUuuYQB3JpAL23wPEN46m2R3RS3zzGojYtsZLQxu
         HkpA3ZRN+IC8A==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, arnd@arndb.de, akpm@linux-foundation.org,
        nathan@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, ndesaulniers@google.com, trix@redhat.com,
        harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/3] Fix a bunch of allmodconfig errors
Date:   Fri, 25 Nov 2022 09:25:14 +0000
Message-Id: <20221125092517.3074989-1-lee@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since b339ec9c229aa ("kbuild: Only default to -Werror if COMPILE_TEST") WERROR
now defaults to COMPILE_TEST meaning that it's enabled for allmodconfig
builds.  This leads to some interesting failures, each resolved in this set.

With this set applied, I am able to obtain a successful allmodconfig Arm build.

Lee Jones (3):
  drm/amd/display/dc/calcs/dce_calcs: Break-out a stack-heavy chunk of
    code
  drm/amdgpu: Temporarily disable broken Clang builds due to blown
    stack-frame
  Kconfig.debug: Provide a little extra FRAME_WARN leeway when KASAN is
    enabled

 drivers/gpu/drm/Kconfig                       |   7 +
 .../drm/amd/display/dc/dml/calcs/dce_calcs.c  | 483 +++++++++---------
 lib/Kconfig.debug                             |   1 +
 3 files changed, 253 insertions(+), 238 deletions(-)


-- 
2.38.1.584.g0f3c55d4c2-goog

