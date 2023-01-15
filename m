Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6366B3F3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjAOUwU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 15 Jan 2023 15:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjAOUwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:52:18 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499E1CC09
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:52:17 -0800 (PST)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 55F981A0A53;
        Sun, 15 Jan 2023 20:52:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id A6A8832;
        Sun, 15 Jan 2023 20:52:11 +0000 (UTC)
Message-ID: <33ecbe8971bb9c90d72c67d43ca740abac160908.camel@perches.com>
Subject: Re: [PATCH] drm/amd/display: Simplify same effect if/else blocks
From:   Joe Perches <joe@perches.com>
To:     Deepak R Varma <drv@mailo.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Date:   Sun, 15 Jan 2023 12:52:10 -0800
In-Reply-To: <Y8POxreeC3EvOXhC@ubun2204.myguest.virtualbox.org>
References: <Y8POxreeC3EvOXhC@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: A6A8832
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: nmp5jzgs6mbr4ybrsoi3t7kdy77pzftq
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+vcIh7h853zIRDiyU/iVp2UCz25hch+jM=
X-HE-Tag: 1673815931-499090
X-HE-Meta: U2FsdGVkX1/EeyVIfaSREYkP20+/ZisoRlOpWZ33AFH9Y7nb5ddC0nDiZ8wdYjIk0gbCITI5svD3Yr3xHWrKTg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-01-15 at 15:30 +0530, Deepak R Varma wrote:
> The if / else block code has same effect irrespective of the logical
> evaluation.  Hence, simply the implementation by removing the unnecessary
> conditional evaluation. While at it, also fix the long line checkpatch
> complaint. Issue identified using cond_no_effect.cocci Coccinelle
> semantic patch script.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Please note: The proposed change is compile tested only. If there are any
> inbuilt test cases that I should run for further verification, I will appreciate
> guidance about it. Thank you.

Preface: I do not know the code.

Perhaps Rodrigo Siqueira made a copy/paste error submitting the code for
commit 9114b55fabae ("drm/amd/display: Fix SubVP control flow in the MPO context")
as the code prior to this change is identical.

Perhaps one of the false uses should be true or dependent on the
interdependent_update_lock state.

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
[]
> @@ -3470,14 +3470,9 @@ static void commit_planes_for_stream(struct dc *dc,
>  		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
>  		 * move the SubVP lock to after the phantom pipes have been setup
>  		 */
> -		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
> -			if (dc->hwss.subvp_pipe_control_lock)
> -				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
> -		} else {
> -			if (dc->hwss.subvp_pipe_control_lock)
> -				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
> -		}
> -

Perhaps something like:

		if (dc->hwss.subvp_pipe_control_lock)
			dc->hwss.subvp_pipe_control_lock(dc, context,
							 should_lock_all_pipes &&
							 dc->hwss.interdependent_update_lock,
							 should_lock_all_pipes, NULL, subvp_prev_use);

> +		if (dc->hwss.subvp_pipe_control_lock)
> +			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes,
> +							 NULL, subvp_prev_use);
>  		return;
>  	}
>  

