Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F6C6771AC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjAVSxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjAVSxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:53:37 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F34DEC52
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674413605; bh=rhAsGMbfg+PGnakQKnQpMWQ6FxgRoSYxPcJe5xXrEP4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=hT8NPtqnyUtg+ElcMwV88lvqkCGTlGRVq4YQGAh3fAn5RkzBzKGAjttv8MwWKTfSw
         4YJauRG89NBJzra+gabj9BFbuW3SBxhmHoxvZqYMc2IQCvNOXrYDYwDKcuM+meIJ1Q
         Tdjvlg6yAtpzzC+s+HuYI/jTsSipE3mMDUuM1KBE=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 22 Jan 2023 19:53:25 +0100 (CET)
X-EA-Auth: sQZjZHsUkHUGta+zBnh7yPGpKpJVDiCrF1C498o1U618e/SJLNy3cV3sT4ijWDGAMV5xW3Qdj6ueHRi05+1t3RVsHHs9s1PC
Date:   Mon, 23 Jan 2023 00:23:19 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Joe Perches <joe@perches.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] drm/amd/display: Simplify same effect if/else blocks
Message-ID: <Y82GHzOUHgEqTUq7@ubun2204.myguest.virtualbox.org>
References: <Y8POxreeC3EvOXhC@ubun2204.myguest.virtualbox.org>
 <33ecbe8971bb9c90d72c67d43ca740abac160908.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ecbe8971bb9c90d72c67d43ca740abac160908.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 12:52:10PM -0800, Joe Perches wrote:
> On Sun, 2023-01-15 at 15:30 +0530, Deepak R Varma wrote:
> > The if / else block code has same effect irrespective of the logical
> > evaluation.  Hence, simply the implementation by removing the unnecessary
> > conditional evaluation. While at it, also fix the long line checkpatch
> > complaint. Issue identified using cond_no_effect.cocci Coccinelle
> > semantic patch script.
> > 
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> > Please note: The proposed change is compile tested only. If there are any
> > inbuilt test cases that I should run for further verification, I will appreciate
> > guidance about it. Thank you.
> 
> Preface: I do not know the code.
> 
> Perhaps Rodrigo Siqueira made a copy/paste error submitting the code for
> commit 9114b55fabae ("drm/amd/display: Fix SubVP control flow in the MPO context")
> as the code prior to this change is identical.
> 
> Perhaps one of the false uses should be true or dependent on the
> interdependent_update_lock state.

Thank you Joe for the recommendation.

Hi Rodrigo,
Can you review and comment on if and what is wrong with your commit?

Thank you,
./drv

> 
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> []
> > @@ -3470,14 +3470,9 @@ static void commit_planes_for_stream(struct dc *dc,
> >  		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
> >  		 * move the SubVP lock to after the phantom pipes have been setup
> >  		 */
> > -		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
> > -			if (dc->hwss.subvp_pipe_control_lock)
> > -				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
> > -		} else {
> > -			if (dc->hwss.subvp_pipe_control_lock)
> > -				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
> > -		}
> > -
> 
> Perhaps something like:
> 
> 		if (dc->hwss.subvp_pipe_control_lock)
> 			dc->hwss.subvp_pipe_control_lock(dc, context,
> 							 should_lock_all_pipes &&
> 							 dc->hwss.interdependent_update_lock,
> 							 should_lock_all_pipes, NULL, subvp_prev_use);
> 
> > +		if (dc->hwss.subvp_pipe_control_lock)
> > +			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes,
> > +							 NULL, subvp_prev_use);
> >  		return;
> >  	}
> >  
> 


