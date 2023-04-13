Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA46E0D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDMMby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDMMbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:31:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183AA83DD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681389111; x=1712925111;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=T1qN+BEy+nB1sRu7UoFdHmbhBDz2OmE2p2qIBhyTCLE=;
  b=lnVXeNIFHuHtjaaA9/MM165m0mD7hAAx7MEG+Y0uAHo/NWdiQMJLeHTk
   ql/uv6b0hQFlOV7T9v60NOhGDz9bln/I0BAVp3/fw6FMIoLsG6ajdOkaY
   a/cCECZkak/vT2cpefrU3EjN+CLCQtveAjT6ZZs3Mlor0Ne4N28JipPAh
   f9DzGI8pzk9GoXx8VmUD2nk+ORfybEhR4hHBp74n7341XaldeIqFuOFWb
   IsjwB99MuNsYICj+I8N+tGuE1QPYDo57SeYSOCLM5Hl4LdMioKfr71i7G
   e6jBalkZ+QwBtXxLybSe06KLno7RptpF/lrl1utIWP8vXI09tRHoSy/Uw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="346855151"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="346855151"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 05:31:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="722039812"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="722039812"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 05:31:47 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jeff Layton <jlayton@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm: make drm_dp_add_payload_part2 gracefully handle
 NULL state pointer
In-Reply-To: <20230413111254.22458-1-jlayton@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230413111254.22458-1-jlayton@kernel.org>
Date:   Thu, 13 Apr 2023 15:31:45 +0300
Message-ID: <87edooarpq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
> I've been experiencing some intermittent crashes down in the display
> driver code. The symptoms are ususally a line like this in dmesg:
>
>     amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port 000000006d3a3885: -5
>
> ...followed by an Oops due to a NULL pointer dereference.
>
> The real bug is probably in the caller of this function, which is
> passing it a NULL state pointer, but this patch at least keeps my
> machine from oopsing when this occurs.

My fear is that papering over this makes the root cause harder to find.

Cc: Harry, Alex


BR,
Jani.


>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2184855
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 38dab76ae69e..87ad406c50f9 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3404,7 +3404,8 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
>  
>  	/* Skip failed payloads */
>  	if (payload->vc_start_slot == -1) {
> -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
> +		drm_dbg_kms(state ? state->dev : NULL,
> +			    "Part 1 of payload creation for %s failed, skipping part 2\n",
>  			    payload->port->connector->name);
>  		return -EIO;
>  	}

-- 
Jani Nikula, Intel Open Source Graphics Center
