Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E34742CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjF2TCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjF2TB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA883582;
        Thu, 29 Jun 2023 12:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F311161601;
        Thu, 29 Jun 2023 19:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1264FC433CB;
        Thu, 29 Jun 2023 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065285;
        bh=f4U2mnHC17deILTlIjHR/zjNCQG4W2AmYyWztzIAOXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvvldP2m+kSKoCfWqCdPKYTjgwCnfOQFvTUVnCBIbAqm0YIU3/28ab9Krmqq3Woxp
         k16k9b4/jheF91crzx+EHnLoyqyhXJXDyxWyCqzVLPbfI8nXRCXfwWQy8yoNqlrFbs
         pGvsGa+RriaZHmBGyQoZZXxIl9Bhk5CZhFUZRFSuvF+JpP6oefmK/RBsqr/9OPnvRy
         jakR9AVzsBRn+nBQBNbwbflI0mVQNIukSaVpBBL8s5tN03LZQBMEFWPFOv55A9vIol
         OLuCrNJlLMNXnNsr3IN6aefSIk5/YtAfmzDObHmZPNBBqoxUVJH4TeDy4oqTDWeVJE
         8l0euCJb66u6w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Lyude Paul <lyude@redhat.com>, Sasha Levin <sashal@kernel.org>,
        airlied@gmail.com, daniel@ffwll.ch, Wayne.Lin@amd.com,
        imre.deak@intel.com, alexander.deucher@amd.com,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.3 12/17] drm: use mgr->dev in drm_dbg_kms in drm_dp_add_payload_part2
Date:   Thu, 29 Jun 2023 15:00:41 -0400
Message-Id: <20230629190049.907558-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190049.907558-1-sashal@kernel.org>
References: <20230629190049.907558-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 54d217406afe250d7a768783baaa79a035f21d38 ]

I've been experiencing some intermittent crashes down in the display
driver code. The symptoms are ususally a line like this in dmesg:

    amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port 000000006d3a3885: -5

...followed by an Oops due to a NULL pointer dereference.

Switch to using mgr->dev instead of state->dev since "state" can be
NULL in some cases.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2184855
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230419112447.18471-1-jlayton@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 38dab76ae69ea..e2e21ce79510e 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3404,7 +3404,7 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
 
 	/* Skip failed payloads */
 	if (payload->vc_start_slot == -1) {
-		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
+		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
 			    payload->port->connector->name);
 		return -EIO;
 	}
-- 
2.39.2

