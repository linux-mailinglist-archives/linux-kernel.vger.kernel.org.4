Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87FC66AE26
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 22:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjANVVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 16:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjANVVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 16:21:19 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C52555A2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673731271; bh=wolWjCpEf1H3OIKgIMygLfimJEpe1hYUkjsFG3xvaSQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=c1tg4ZH5I0+IfBjxxi2KZAd7mkqw7NSo5wE9tI0G1AS0AvfH64X7qB/kbxE9TJ1zN
         wBYBPlleHVCre9oKfvtshgaiSFJAn9+y/y1t1h1Kc+aeVdTqJeFIyXlRj48sGz3Uvu
         8KKExwiaRXcrnqNZvNQ87rVryO8Sj7fZo66RC2cM=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 14 Jan 2023 22:21:11 +0100 (CET)
X-EA-Auth: QPUqpE0hegBYiohcI3WBO46zBlZZafd7KjhOMaLKR2qPNKImrg+0H8TDInokhH06BXgI+ThOMBoLtvl3iKaVoyK+5PYKXj8y
Date:   Sun, 15 Jan 2023 02:51:06 +0530
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
Subject: [PATCH 3/4] drm/amd/display: dcn21: Use min()/max() helper macros
Message-ID: <3ef364025902b76f9aa388069026b6eace353827.1673730293.git.drv@mailo.com>
References: <cover.1673730293.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673730293.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard min() / max() helper macros instead of direct variable
comparison using if/else blocks or ternary operator. Change identified
using minmax.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c   | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 1d84ae50311d..41fb5fddd85d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -838,10 +838,7 @@ static bool CalculatePrefetchSchedule(
 
 	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
 
-	if (dst_y_prefetch_oto < dst_y_prefetch_equ)
-		*DestinationLinesForPrefetch = dst_y_prefetch_oto;
-	else
-		*DestinationLinesForPrefetch = dst_y_prefetch_equ;
+	*DestinationLinesForPrefetch = min(dst_y_prefetch_oto, dst_y_prefetch_equ);
 
 	// Limit to prevent overflow in DST_Y_PREFETCH register
 	*DestinationLinesForPrefetch = dml_min(*DestinationLinesForPrefetch, 63.75);
-- 
2.34.1



