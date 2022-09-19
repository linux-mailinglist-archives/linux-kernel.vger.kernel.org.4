Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9885BC460
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiISIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiISIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:34:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8DCDF04;
        Mon, 19 Sep 2022 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663576489; x=1695112489;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gvitbWxJbKVPz6HHjo9mSVxRRPK2yahVp85eTBd7yNA=;
  b=ONkNMPHXM03WklHFA5NWiXlH+rZ97yryHU0aQtGB5BcHEcy9yQLTY524
   zZdpu+utqUWBPsioMQPIy+Qy1d0sHQrhmBVT+dNx/ftLo4kf0sF3jt20h
   ReGY+84dPVMf/D9LoCJgJvj8rbLug8KXd5HJWd13Wa5HrsWi3m6mk6LTA
   W3wsPBT5DroFQzBlu9yXN05l12jWjz+2VLtk+9KeiGGuqhx9vLP0WEcAO
   3Bm7tS+fifNnSe6zvITIiP5bAf+Ov2tvG0NjWFVskmk3nwkMt78QFo/iJ
   ZmRPu23yyBHg2IbCNkg8k8t6FhuFkDNmKxqBAdlUm3O/V3WSLX8kyOOs2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="361078973"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="361078973"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 01:34:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="595995204"
Received: from jjohns2-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.57.205])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 01:34:44 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Li Zhong <floridsleeves@gmail.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     airlied@redhat.com, ville.syrjala@linux.intel.com,
        christian.koenig@amd.com, sumit.semwal@linaro.org, daniel@ffwll.ch,
        airlied@linux.ie, tvrtko.ursulin@linux.intel.com,
        rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
        Li Zhong <floridsleeves@gmail.com>
Subject: Re: [PATCH v1] drivers/gpu/drm/i915/gt: Check the return value of
 i915_active_acquire()
In-Reply-To: <20220918220731.1026200-1-floridsleeves@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220918220731.1026200-1-floridsleeves@gmail.com>
Date:   Mon, 19 Sep 2022 11:34:29 +0300
Message-ID: <877d1zrcdm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2022, Li Zhong <floridsleeves@gmail.com> wrote:
> i915_active_acquire() could return error when the acquire fails. Check
> and return the error code.

The commit message should explain why you don't need to do further error
handling. Or do you?

Side note, the distribution list is excessive.

BR,
Jani.


> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_timeline.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_timeline.c b/drivers/gpu/drm/i915/gt/intel_timeline.c
> index b9640212d659..d8333ab64574 100644
> --- a/drivers/gpu/drm/i915/gt/intel_timeline.c
> +++ b/drivers/gpu/drm/i915/gt/intel_timeline.c
> @@ -211,7 +211,10 @@ int intel_timeline_pin(struct intel_timeline *tl, struct i915_gem_ww_ctx *ww)
>  	GT_TRACE(tl->gt, "timeline:%llx using HWSP offset:%x\n",
>  		 tl->fence_context, tl->hwsp_offset);
>  
> -	i915_active_acquire(&tl->active);
> +	err = i915_active_acquire(&tl->active);
> +	if (err)
> +		return err;
> +
>  	if (atomic_fetch_inc(&tl->pin_count)) {
>  		i915_active_release(&tl->active);
>  		__i915_vma_unpin(tl->hwsp_ggtt);

-- 
Jani Nikula, Intel Open Source Graphics Center
