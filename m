Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571435FF135
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJNPXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJNPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:23:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16FE1974FC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D641EB80B8F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BCBC433C1;
        Fri, 14 Oct 2022 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665760931;
        bh=zumSMnjEB7p5SnrVEFCNhx+z/ucnZjd98NRHyDu6F5E=;
        h=From:To:Cc:Subject:Date:From;
        b=A4Sbe/jdgIdp2JTTlJQ/vJ7PRFBn7V3MpBu4EWtv7v+Gm1iqO+VzSPofI82rqOmqi
         NeP2i6fk1PlH+XjX077mlJBwjTTF4bkTanAKfd8F0pVcX4kU/sNx2Lwc6l2QuyA420
         DgFjb1QoFdbFISLgFFmAMM5lxyi4YYOtTdofh3JL7kNKJZeHbeiIQIb82+Oa8flbvV
         T2fpOOxjDGiIM9oJKPkQW1kJ/4LXzkVWTQYWwNxB5QgiUIBIbGZH/5VIK8/aAaG0N2
         YzrIQBGerQKC9mXcG8X5cF2luJzu7Bgtg7g7PapPdZQDwO6qp5Hrr38rhQ+oHcgSug
         +ekifejesRymw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drm/amd/display: Fix build breakage with CONFIG_DEBUG_FS=n
Date:   Fri, 14 Oct 2022 08:21:03 -0700
Message-Id: <20221014152102.1755050-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 8799c0be89eb ("drm/amd/display: Fix vblank refcount in vrr
transition"), a build with CONFIG_DEBUG_FS=n is broken due to a
misplaced brace, along the lines of:

  In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_trace.h:39,
                   from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:41:
  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: At top level:
  ./include/drm/drm_atomic.h:864:9: error: expected identifier or ‘(’ before ‘for’
    864 |         for ((__i) = 0;                                                 \
        |         ^~~
  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8317:9: note: in expansion of macro ‘for_each_new_crtc_in_state’
   8317 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~

Move the brace within the #ifdef so that the file can be built with or
without CONFIG_DEBUG_FS.

Fixes: 8799c0be89eb ("drm/amd/display: Fix vblank refcount in vrr transition")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

I have sent this to Linus in case he wants to take this directly since
this is a pretty obvious fix, as opposed to going through the regular
channels.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f6a9e8fdd87d..c053cb79cd06 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8310,8 +8310,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 					crtc, dm_new_crtc_state, cur_crc_src))
 					DRM_DEBUG_DRIVER("Failed to configure crc source");
 			}
-#endif
 		}
+#endif
 	}
 
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)

base-commit: 9c9155a3509a2ebdb06d77c7a621e9685c802eac
-- 
2.38.0

