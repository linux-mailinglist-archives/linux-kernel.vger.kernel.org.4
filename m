Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEF168A7F4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 04:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjBDD1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 22:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBDD1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 22:27:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EBA1BADD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 19:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FoOBybbVEq4nKcbNBz7lHZJ8Czql2ZLx6S2TZbuykFI=; b=sfUGQXYslsBr5DEQeDeBBallb8
        XOimGQpxsOTxBuSGQjWFxwjQJBeQk4Ve3pydj/XMNjzq+0a5taWQufh7rfVR83wc6uLn/pCNJ2pfO
        dvrrcA2LaHwbAlzoyIP/BogJOuE9Sf8Wj+FTrmrSt79sdebhMStK93K0omNsjhsGrlQo4Q7kLDXjd
        X98wDA8IbTOU8eevqlEziJJyEEh2R2pw5/dmCfOeFMslThs+JNuF9mp5R02gPUJ3oYHMmyrWigzll
        emCoIztijo/x1+xM6t5UEknovi4x86TYGdCn+p7+HpkGRQKEOvLs7TeOfsGCphOqvdTzfNHT1q1rV
        mFTIvzpQ==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pO9DE-004M4F-Ea; Sat, 04 Feb 2023 03:27:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Signed-off-by : Sung Joon Kim" <sungkim@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: add complete header search path
Date:   Fri,  3 Feb 2023 19:27:35 -0800
Message-Id: <20230204032735.22509-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The path for the "mod_info_packet.h" header file is
incomplete, so add its location to the header search path
in the amdgpu Makefile.

See on ARCH=alpha (275 times in one build).

In file included from ../drivers/gpu/drm/amd/amdgpu/amdgpu.h:90,
                 from ../drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:43:
../drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.h:62:10: fatal error: mod_info_packet.h: No such file or directory
   62 | #include "mod_info_packet.h"
      |          ^~~~~~~~~~~~~~~~~~~
compilation terminated.

Fixes: 5b49da02ddbe ("drm/amd/display: Enable Freesync over PCon")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Signed-off-by: Sung Joon Kim <sungkim@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -34,6 +34,7 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/
 	-I$(FULL_AMD_PATH)/acp/include \
 	-I$(FULL_AMD_DISPLAY_PATH) \
 	-I$(FULL_AMD_DISPLAY_PATH)/include \
+	-I$(FULL_AMD_DISPLAY_PATH)/modules/inc \
 	-I$(FULL_AMD_DISPLAY_PATH)/dc \
 	-I$(FULL_AMD_DISPLAY_PATH)/amdgpu_dm \
 	-I$(FULL_AMD_PATH)/amdkfd
