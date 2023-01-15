Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A766B022
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjAOJ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjAOJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:26:41 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054C859ED
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673774780; bh=EprenRK+fhh8LVQitW7gzersdR2rfcFOxO4xOWvTdwI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=B4n9PFAiYsPvtQTfY06WMQg1lKrwJzas9oAiFGLlj2qWWC5DkV4JtR8Paw39YQmlo
         2VjC6gvFWm90AwOlhI7bsy7t3+UKOQs2mVJ3/pMLrnpicpKxTNJCti6BXFqYachjSg
         7a/eWi5G1tLfKID7kipr9JHkSiQK3Vb7VOwywmyA=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 15 Jan 2023 10:26:20 +0100 (CET)
X-EA-Auth: u3SH4wvgyxfpkBx0jrY/UYMRZuoD5GiSOPyFx6yICV+SBVN9aEAYXtgpuLPHhsdublOVQMOBuwfWuhfXeLdMLGNNHuH6VNPg
Date:   Sun, 15 Jan 2023 14:56:14 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] drm/amd/display: use swap() helper macro in bios_parser
Message-ID: <Y8PGts5Nku8OSlRN@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use swap() helper macro instead of open coded swap instructions. The
change also facilitates code cleanup and realignment for improved
readability.  Issue identified using swap.cocci Coccinelle semantic
patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 074e70a5c458..7b5894adbf51 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2929,7 +2929,6 @@ static enum bp_result construct_integrated_info(
 	struct atom_common_table_header *header;
 	struct atom_data_revision revision;
 
-	struct clock_voltage_caps temp = {0, 0};
 	uint32_t i;
 	uint32_t j;
 
@@ -3032,14 +3031,8 @@ static enum bp_result construct_integrated_info(
 	for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
 		for (j = i; j > 0; --j) {
 			if (info->disp_clk_voltage[j].max_supported_clk <
-				info->disp_clk_voltage[j-1].max_supported_clk
-				) {
-				/* swap j and j - 1*/
-				temp = info->disp_clk_voltage[j-1];
-				info->disp_clk_voltage[j-1] =
-					info->disp_clk_voltage[j];
-				info->disp_clk_voltage[j] = temp;
-			}
+			    info->disp_clk_voltage[j-1].max_supported_clk)
+				swap(info->disp_clk_voltage[j-1], info->disp_clk_voltage[j]);
 		}
 	}
 
-- 
2.34.1



