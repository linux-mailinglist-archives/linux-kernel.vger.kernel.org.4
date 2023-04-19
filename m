Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7139C6E7A83
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjDSNVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjDSNVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:21:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC581544C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681910467; x=1713446467;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sQu+EGztomOf0wJcq47X3hsD6fAQUa1otr26HmJHEN4=;
  b=nqV5bYaB161Clgn7aMvT7Dv6lVH4/R1s2SuDead70LNPrUX1b5Qg8AM3
   lWJWZAjdQSCYBLRODm4Dgg8oMBt2AuM3Z7cgUDrsmV9cPSP5bEes9Orrb
   8o1eeSDVXCFCc3e/FvAfBTQ+KGTcDailzCIh/wnQQBWWf51+0zMfOH91W
   /D0W/haK3RkrHs3pVuO644uRpwKRAauCuyj/xT58Ei+3kGX3b1VDoja9X
   7dvleQOVWqFqt3yKLrCp9wRgXgNKk23+O+du8SEu3X65qxljOpTRMBYsM
   MCxk7MrSv2s2Mu8Iw0qSTOKJzzLRAq8oAPa8LSNP2wDRsvvtZ7TadIxpM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345445526"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="345445526"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 06:21:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="802916028"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="802916028"
Received: from yedidyal-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.47.37])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 06:21:04 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jeff Layton <jlayton@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Wayne.Lin@amd.com, lyude@redhat.com, alexdeucher@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: use mgr->dev in drm_dbg_kms in
 drm_dp_add_payload_part2
In-Reply-To: <20230419112447.18471-1-jlayton@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230419112447.18471-1-jlayton@kernel.org>
Date:   Wed, 19 Apr 2023 16:21:03 +0300
Message-ID: <87o7nkypmo.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
> I've been experiencing some intermittent crashes down in the display
> driver code. The symptoms are ususally a line like this in dmesg:
>
>     amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port 000000006d3a3885: -5
>
> ...followed by an Oops due to a NULL pointer dereference.
>
> Switch to using mgr->dev instead of state->dev since "state" can be
> NULL in some cases.
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2184855
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I've been running this patch for a couple of days, but the problem
> hasn't occurred again as of yet. It seems sane though as long as we can
> assume that mgr->dev will be valid even when "state" is a NULL pointer.
>
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 38dab76ae69e..e2e21ce79510 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3404,7 +3404,7 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
>  
>  	/* Skip failed payloads */
>  	if (payload->vc_start_slot == -1) {
> -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
> +		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
>  			    payload->port->connector->name);
>  		return -EIO;
>  	}

-- 
Jani Nikula, Intel Open Source Graphics Center
