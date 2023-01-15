Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F83766B03B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjAOKA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 05:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjAOKAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:00:53 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB4C16C
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 02:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673776843; bh=/iD5FdGsACL4AeAQezA9XNB8C/O5bx6Q/X5pHtL9znk=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=j/AHSimET66MvDWv+l8/PtEAWvnrhLtKagZQwJmMQZcGGc2STk00RUpyw8LALrtNM
         ZnsIOPFDKQvAX/0CNhJx6g+LV5WxkZpCK/+5ao00eYs/low/H+qAJjJcLjhzpGnWfw
         tEoHNhFdf3SdsMewyN0YhTKDmukAc7EcXt/C0cQo=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 15 Jan 2023 11:00:43 +0100 (CET)
X-EA-Auth: QUVQkKdtaa3ThPmH0jN9hkKBEF3clhbPL9AScoOFF2o6Ipb8m9b2YiEd1CacQfHgw+lTtqJAFAhum5ZmXRrFw35fBU6TjDC8
Date:   Sun, 15 Jan 2023 15:30:38 +0530
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
Subject: [PATCH] drm/amd/display: Simplify same effect if/else blocks
Message-ID: <Y8POxreeC3EvOXhC@ubun2204.myguest.virtualbox.org>
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

The if / else block code has same effect irrespective of the logical
evaluation.  Hence, simply the implementation by removing the unnecessary
conditional evaluation. While at it, also fix the long line checkpatch
complaint. Issue identified using cond_no_effect.cocci Coccinelle
semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: The proposed change is compile tested only. If there are any
inbuilt test cases that I should run for further verification, I will appreciate
guidance about it. Thank you.

 drivers/gpu/drm/amd/display/dc/core/dc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0cb8d1f934d1..776209e5d21f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3470,14 +3470,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
 		 * move the SubVP lock to after the phantom pipes have been setup
 		 */
-		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
-			if (dc->hwss.subvp_pipe_control_lock)
-				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
-		} else {
-			if (dc->hwss.subvp_pipe_control_lock)
-				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
-		}
-
+		if (dc->hwss.subvp_pipe_control_lock)
+			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes,
+							 NULL, subvp_prev_use);
 		return;
 	}
 
-- 
2.34.1



