Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46C64E96D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLPK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLPK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:26:14 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709732980F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:26:13 -0800 (PST)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NYQGG5BtZz16Lj2;
        Fri, 16 Dec 2022 18:25:10 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 18:26:10 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <yiyang13@huawei.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/amd/display: Remove redundant assignment to variable dc
Date:   Fri, 16 Dec 2022 18:23:18 +0800
Message-ID: <20221216102318.197994-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch report warning as follows:

Line 53679: drivers/gpu/drm/amd/display/dc/core/dc_stream.c:402
dc_stream_set_cursor_position() warn: variable dereferenced before
check 'stream'

The value of 'dc' has been assigned after check whether 'stream' is
NULL. Fix it by remove redundant assignment.

Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 20e534f73513..78d31bb875d1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -408,7 +408,7 @@ bool dc_stream_set_cursor_position(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_position *position)
 {
-	struct dc  *dc = stream->ctx->dc;
+	struct dc *dc;
 	bool reset_idle_optimizations = false;
 
 	if (NULL == stream) {
-- 
2.17.1

