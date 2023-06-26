Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7860B73DB68
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjFZJ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjFZJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:27:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5918F10D2;
        Mon, 26 Jun 2023 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687771624; x=1719307624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3mrrnJPN3WRzZuBY5/ppMAonnkB4EuW+qZ/uzbwNfrI=;
  b=fv37mNFvpp7shfOgfpjPPvv7Wo+AFgI0SHoxGP7AlxmieaYdht0+K5h1
   31ULoi76jKVnEkW4NYMcBtKU+iOGvZo5Fu6loahuRxwJM+LqTbTxFkaqK
   WtpBkbW2j+583rmu7weP0ocwb1z9uONRhS27+aqxqvMCJonfB9a9CF707
   yt3HcsMSyVbnBsEJWs1I4lWHD7GQQt5MMW8dkMTR1gq9Lj4ofAPfcOrZ9
   I0CoGTv5304hJo43KK7UwJdJdi6qBraSu6sGpfg38DfA3Dyd8LCghiyOF
   WyTpVp/gUTPvk20TqdoHfOP9q7bRnFCDRE3fXCEriTSNPUuO+6GmyZJ+d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="424892817"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="424892817"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:27:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="962712374"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="962712374"
Received: from csteeb-mobl2.ger.corp.intel.com (HELO intel.com) ([10.251.217.4])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:26:59 -0700
Date:   Mon, 26 Jun 2023 11:26:55 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>, keescook@chromium.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH 16/26] drm/i915/gvt: use array_size
Message-ID: <ZJlZ3421Whev/LkX@ashyti-mobl2.lan>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-17-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623211457.102544-17-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On Fri, Jun 23, 2023 at 11:14:47PM +0200, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>     expression E1, E2;
>     constant C1, C2;
>     identifier alloc = {vmalloc,vzalloc};
> @@
>     
> (
>       alloc(C1 * C2,...)
> |
>       alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>       ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index 4ec85308379a..df52385ad436 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -1969,14 +1969,16 @@ static struct intel_vgpu_mm *intel_vgpu_create_ggtt_mm(struct intel_vgpu *vgpu)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	mm->ggtt_mm.host_ggtt_aperture = vzalloc((vgpu_aperture_sz(vgpu) >> PAGE_SHIFT) * sizeof(u64));
> +	mm->ggtt_mm.host_ggtt_aperture =
> +		vzalloc(array_size(vgpu_aperture_sz(vgpu) >> PAGE_SHIFT, sizeof(u64)));
>  	if (!mm->ggtt_mm.host_ggtt_aperture) {
>  		vfree(mm->ggtt_mm.virtual_ggtt);
>  		vgpu_free_mm(mm);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	mm->ggtt_mm.host_ggtt_hidden = vzalloc((vgpu_hidden_sz(vgpu) >> PAGE_SHIFT) * sizeof(u64));
> +	mm->ggtt_mm.host_ggtt_hidden =
> +		vzalloc(array_size(vgpu_hidden_sz(vgpu) >> PAGE_SHIFT, sizeof(u64)));

thanks for this patch, but I see an issue here. array_size()
truncates the allocation to SIZE_MAX, and I'm OK with it.

The problem is that no error is notified and the user doesn't
know that a truncation has happened. So that if we save from an
overflow here, we might encur to an unwanted access later when we
would start using the array for the size we think is allocated.

kmalloc_array(), for example, returns NULL of there is a
multiplication overflow and I think that's a better behaviour,
although more drastic.

Andi

>  	if (!mm->ggtt_mm.host_ggtt_hidden) {
>  		vfree(mm->ggtt_mm.host_ggtt_aperture);
>  		vfree(mm->ggtt_mm.virtual_ggtt);
