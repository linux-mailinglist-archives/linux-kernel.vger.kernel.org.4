Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6C5F4A42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJDUYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJDUYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3276258
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664915080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=68Cjk2krWuLCLqwuVkKp32QKy4UuNZQ+DBLOl7qONe0=;
        b=SL4/zXp2FeQHoJhWFcfhQTN5jjxxEXuKgqEz5B+cI7xKc0GyGGtFHufoDu6wO6X+X5uojr
        Azl6//2tiv7Zs25e+OaAdjv6XrB8QOcfysEFDDD5f4RNtmur44BLch1ElEmh5mVUNiv1uR
        lbPJsJKEvzif9Uy74TRFXd7lH632Yeg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-6nYTxoTBMSiDvqWHTmPTnA-1; Tue, 04 Oct 2022 16:24:37 -0400
X-MC-Unique: 6nYTxoTBMSiDvqWHTmPTnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 385D01C0758C;
        Tue,  4 Oct 2022 20:24:36 +0000 (UTC)
Received: from emerald.stthomas.edu (unknown [10.22.18.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 855191121314;
        Tue,  4 Oct 2022 20:24:34 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Ian Chen <ian.chen@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Claudio Suarez <cssk@net-c.es>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/amdgpu/dm/mst: Fix incorrect usage of drm_dp_add_payload_part2()
Date:   Tue,  4 Oct 2022 15:24:28 -0500
Message-Id: <20221004202429.124422-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yikes, it appears somehow I totally made a mistake here. We're currently
checking to see if drm_dp_add_payload_part2() returns a non-zero value to
indicate success. That's totally wrong though, as this function only
returns a zero value on success - not the other way around.

So, fix that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Issue: https://gitlab.freedesktop.org/drm/amd/-/issues/2171
Fixes: 4d07b0bc4034 ("drm/display/dp_mst: Move all payload info into the atomic state")
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index b8077fcd4651..00598def5b39 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -297,7 +297,7 @@ bool dm_helpers_dp_mst_send_payload_allocation(
 		clr_flag = MST_ALLOCATE_NEW_PAYLOAD;
 	}
 
-	if (enable && drm_dp_add_payload_part2(mst_mgr, mst_state->base.state, payload)) {
+	if (enable && drm_dp_add_payload_part2(mst_mgr, mst_state->base.state, payload) == 0) {
 		amdgpu_dm_set_mst_status(&aconnector->mst_status,
 			set_flag, false);
 	} else {
-- 
2.37.3

