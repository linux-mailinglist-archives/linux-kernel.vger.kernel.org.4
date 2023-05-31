Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB2717BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjEaJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjEaJWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:22:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDD10B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685524944; x=1717060944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/r3gcWQoto+MLlyTLPUbCGxj9ry+CDxBwsAjSjiaVNU=;
  b=ShaI1L/5rPFhQcl2VxCgwsHlazW/+QNjca9XHv7KIYzhZZGVFhQCQX9m
   4JffLUBuwKPOEMxEHJveDw61On99V+mqUbqZEQHaQxewGM2VYgUArzYAi
   FxOX6lFfSCWCdWhJVXK8+snysyILnfxpollSoCrUalinxD5/CE8xoE3id
   TBcxBcVkLSQg0qUBYa0vfemXtzNc2FOTqBrslRuOhRTL7rdvA9OIyHo1L
   S5MCtmZB44VJrWREUVPki7lhgjwemTOUc597t2ftxz6TOGINTXByDzXBW
   aebEzDZwTuWU/A0IPcvWBi46cyueTfBnXZ5az9SGs065ozvsrDLDpzSGW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357575104"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="357575104"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:22:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="881103740"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="881103740"
Received: from itaraban-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.47.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:22:20 -0700
Date:   Wed, 31 May 2023 11:22:16 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     airlied@gmail.com, intel-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, rodrigo.vivi@intel.com,
        Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH -next] drm/i915: remove unreachable code
Message-ID: <ZHcRyNg1aGHJOBSB@ashyti-mobl2.lan>
References: <20230531021714.125078-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531021714.125078-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Wed, May 31, 2023 at 10:17:14AM +0800, Yang Li wrote:
> The code after the return will not be executed, so remove them.
> 
> Eliminate the following warning:
> drivers/gpu/drm/i915/display/intel_color.c:1808 intel_color_prepare_commit() warn: ignoring unreachable code.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5342
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/i915/display/intel_color.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
> index 8966e6560516..0bfebac1e3e2 100644
> --- a/drivers/gpu/drm/i915/display/intel_color.c
> +++ b/drivers/gpu/drm/i915/display/intel_color.c
> @@ -1804,11 +1804,6 @@ void intel_color_prepare_commit(struct intel_crtc_state *crtc_state)
>  
>  	/* FIXME DSB has issues loading LUTs, disable it for now */
>  	return;
> -
> -	if (!crtc_state->pre_csc_lut && !crtc_state->post_csc_lut)
> -		return;
> -
> -	crtc_state->dsb = intel_dsb_prepare(crtc, 1024);

yeah... it's an ugly bit, from my side:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

but would be nice to hear from Ville who has added the return in
a first place.

Andi

>  }
>  
>  void intel_color_cleanup_commit(struct intel_crtc_state *crtc_state)
> -- 
> 2.20.1.7.g153144c
