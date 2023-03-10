Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781B96B4F65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCJRs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjCJRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:48:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CF011ACBA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678470506; x=1710006506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bee2h7Uihe+QYwTZwZ+fnOq+GIrmw0Sej7yiPuEmRfI=;
  b=Goo01+efOzv+lyElcZDDrYd0LAEbF0grht/s9oBsVB9uZI1+wdHt5xqT
   2O0V388RPxtwC+UmjZLm5nPwwmSB0+PABABdy0avUzWmaukb9xqLgiSFx
   VeLp9vzNur3iGOfnOEwb2u5F8JCfB7qZpC/TYfpCSuJPB7wgnVlueCHgy
   PE90Lg7OBL6X9DCk6WTJEpsyrklUsigrIpy+5Al2dNMiZbLAZsrrd7lOc
   9T4FiZa71oo/O3oXg78r6LfP9G5a5Z2+8FYziToyxZtChEoRigE7r57Vf
   C7r+k8IIlXy3GA1nv0lrkv3VCmT0cR1IWKYTodatSub0t923D5DFtuqQc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="401648388"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="401648388"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="766910021"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="766910021"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by FMSMGA003.fm.intel.com with SMTP; 10 Mar 2023 09:48:05 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 10 Mar 2023 19:48:04 +0200
Date:   Fri, 10 Mar 2023 19:48:04 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Ian Chen <ian.chen@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Wayne Lin <Wayne.Lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Sung Joon Kim <sungjoon.kim@amd.com>
Subject: Re: [PATCH] drm/amd/display: use a more accurate check in
 dm_helpers_dp_read_dpcd()
Message-ID: <ZAttVGN/VdrfkH3y@intel.com>
References: <20230309213027.256243-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309213027.256243-1-hamza.mahfooz@amd.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:30:27PM -0500, Hamza Mahfooz wrote:
> We should be checking if drm_dp_dpcd_read() returns the size that we are
> asking it to read instead of just checking if it is greater than zero.
> Also, we should WARN_ON() here since this condition is only ever met, if
> there is an issue worth investigating. So, compare the return value of
> drm_dp_dpcd_read() to size and WARN_ON() if they aren't equal.
> 
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 8d598b322e5b..ed2ed7b1d869 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -511,8 +511,8 @@ bool dm_helpers_dp_read_dpcd(
>  		return false;
>  	}
>  
> -	return drm_dp_dpcd_read(&aconnector->dm_dp_aux.aux, address,
> -			data, size) > 0;
> +	return !WARN_ON(drm_dp_dpcd_read(&aconnector->dm_dp_aux.aux, address,
> +					 data, size) != size);

Just FYI there are devices out there that violate the DP spec and reads
from specific DPCD registers simply fail instead of returning the
expected 0.

>  }
>  
>  bool dm_helpers_dp_write_dpcd(
> -- 
> 2.39.2

-- 
Ville Syrjälä
Intel
