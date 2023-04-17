Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9222E6E539C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDQVGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjDQVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D2810F4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 697C762203
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCABC433D2;
        Mon, 17 Apr 2023 21:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681765569;
        bh=An4/qvBICNxrZq3RM6ajIvQGCH7WWPRxMuUGkIjf4xE=;
        h=From:To:Cc:Subject:Date:From;
        b=Lmi7RyLY/b4hnJV6EwWzVz51lWwZ/+MRxXeXhB63HP882GQTBywrF8b0NFVjr6yG2
         0pUXOTbNvsU1e8AP+VcRhoKdRYO/qLc9BsxidmVqMWfok+yNzK9qH15uJCgTLKvsJe
         uGgIYz/wLd/a4PlEPGmeZ5yrHRHfwSW5mfl+z5YMAC1tjuXwcVFebz1wa0Y8Z9mLi8
         2+VH22T2QOU629Drfn5WvW6nW4b0TlCxMs+Sm1CAdjn5dGhJWCHWGTPm59QexCljS2
         wXQpmbjXLy9wBm/qRR9eAzKAC6iWy/MQQ+6PRZKTlvEdl2KRgg2Y/UwpGbhyoY/91G
         3WmsHLn94Qe2Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Taimur Hassan <Syed.Hassan@amd.com>,
        Jasdeep Dhillon <jdhillon@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: mark dccg314_init() static
Date:   Mon, 17 Apr 2023 23:05:42 +0200
Message-Id: <20230417210602.2614198-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

The newly introduced global function is not declared in a header or
called from another file, causing a harmless warning with sparse
or W=1 builds:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dccg.c:277:6: error: no previous prototype for 'dccg314_init' [-Werror=missing-prototypes]

Mark it static instead.

Fixes: 6f6869dcf415 ("drm/amd/display: prep work for root clock optimization enablement for DCN314")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 6f879265ad9c..de7bfba2c179 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -274,7 +274,7 @@ static void dccg314_set_dpstreamclk(
 	}
 }
 
-void dccg314_init(struct dccg *dccg)
+static void dccg314_init(struct dccg *dccg)
 {
 	int otg_inst;
 
-- 
2.39.2

