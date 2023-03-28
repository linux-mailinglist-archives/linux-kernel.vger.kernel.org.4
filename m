Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EBE6CC037
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjC1NKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjC1NKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:10:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2488BB98
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680008960; x=1711544960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hEsefQeZT5HOexkYp5BwuMTDiULU+5IKf5YZR+PdMrw=;
  b=WM6I0bTsizoIEvLeqeSbpMmoZA1c3MkYpzB4lOzpKGNP+sHW+4dPtHW+
   Ug4ELSyqOYlZIgkPBvcMDSxbEUiC/JQwewbWYEdcXHWp+YI2Tx8dJr21v
   VQEu/E+b9gh3ETD7QoesReforHeF66kzUzLtiomEaKr9Jh3TIokNvbqnL
   g4S7mlyEBP4Pv2/vpwVg/uB9NyQ0je3z12A0xjsWCnOYukWHhpsWB+38G
   xB6UUvgHjR6EIWecLGe1A4LZJualy8tHUnWD9kyvpq9g28v/PvpenScF1
   ELrGy9bTdNotKmdsKykenndDMFOLY6cTpTr304yWAeR0OYam+IWM+YBk4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="340581919"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="340581919"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 06:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="748396269"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="748396269"
Received: from wheelerj-mobl.ger.corp.intel.com (HELO [10.213.213.242]) ([10.213.213.242])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 06:08:49 -0700
Message-ID: <e7541f73-f100-3b1f-de80-376fa55f2479@linux.intel.com>
Date:   Tue, 28 Mar 2023 14:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] drm/i915: fix race condition UAF in
 i915_perf_add_config_ioctl
Content-Language: en-US
To:     Min Li <lm0963hack@gmail.com>, jani.nikula@linux.intel.com,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@gmail.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230328093627.5067-1-lm0963hack@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230328093627.5067-1-lm0963hack@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/03/2023 10:36, Min Li wrote:
> Userspace can guess the id value and try to race oa_config object creation
> with config remove, resulting in a use-after-free if we dereference the
> object after unlocking the metrics_lock.  For that reason, unlocking the
> metrics_lock must be done after we are done dereferencing the object.
> 
> Signed-off-by: Min Li <lm0963hack@gmail.com>

Fixes: f89823c21224 ("drm/i915/perf: Implement I915_PERF_ADD/REMOVE_CONFIG interface")
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: <stable@vger.kernel.org> # v4.14+

> ---
>   drivers/gpu/drm/i915/i915_perf.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 824a34ec0b83..93748ca2c5da 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -4634,13 +4634,13 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
>   		err = oa_config->id;
>   		goto sysfs_err;
>   	}
> -
> -	mutex_unlock(&perf->metrics_lock);
> +	id = oa_config->id;
>   
>   	drm_dbg(&perf->i915->drm,
>   		"Added config %s id=%i\n", oa_config->uuid, oa_config->id);
> +	mutex_unlock(&perf->metrics_lock);
>   
> -	return oa_config->id;
> +	return id;
>   
>   sysfs_err:
>   	mutex_unlock(&perf->metrics_lock);

LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Umesh or Lionel could you please double check? I can merge if confirmed okay.

Regards,

Tvrtko
