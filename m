Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22F6F31FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjEAOc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEAOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68448134
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 07:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F413860E33
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 14:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52335C433EF;
        Mon,  1 May 2023 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682951543;
        bh=rszZaRt349rSKpXDtTUZKWMXkHmt5IGp9/2/HR6rRyo=;
        h=From:To:Cc:Subject:Date:From;
        b=p+8PyNo7PFE8jPejPTz6PdMaOMifB56eMcoqYWkzRafBVBPIq6ueWOSOcti27tEan
         0+X4BCVjwv6ajyGGhXqgMJqi+LfhrrGDt372wsBk9Gq/0OiRhkUuTnLxgIcnPiwT+m
         +9REaBkA3YYdFd3pdOITw7qyNiqjYvVZkADZ/hANf+5NMFceiZWekLkDhpw/RL7z+E
         tM3FYFzyZBtDjKnrOdPeNqgXn5kIKdG2gKdWQvlYra1Ckm5C3fF08HWo09UVh356i7
         LbUEgvFT+/1/eY9sU/bI+tc0i51tpj05fwGdRlosrNK1koDNcV8rERdJJ8bIhAsjzh
         9bW0neZkTfifA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Wenchieh Chien <wenchieh.chien@amd.com>,
        Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: mark amdgpu_dm_connector_funcs_force static
Date:   Mon,  1 May 2023 16:31:53 +0200
Message-Id: <20230501143213.1571373-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A global function without a header prototype has made it into
linux-next during the merge window:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6339:6: error: no previous prototype for 'amdgpu_dm_connector_funcs_force' [-Werror=missing-prototypes]

Mark the function static instead, as there are no other
callers outside this file.

Fixes: 0ba4a784a145 ("drm/amd/display: implement force function in amdgpu_dm_connector_funcs")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304251640.JClqTim9-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This was previously reported by a bot for the drm-next tree but remains
broken in linux-next-20230428. Sending it out as I needed this fix
for my local builds.
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3647d21d688f..2bbb2988942d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6336,7 +6336,7 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 	return 0;
 }
 
-void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
+static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct dc_link *dc_link = aconnector->dc_link;
-- 
2.39.2

