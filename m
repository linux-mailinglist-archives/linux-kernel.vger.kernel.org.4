Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919F25BB768
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIQJID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQJH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C35E24967
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 02:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0569761309
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47FCC433C1;
        Sat, 17 Sep 2022 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663405677;
        bh=mN6OrmlEWafTBrem5aKUHKgVApH1DNBbr9anI0Yk1Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PB0ZPMBZnAWZ1zw5KUQZnMcwSr7Qzh7VHP9dAIWTGoQHEXzPSYjwj4Z4NlRscuEtF
         kFK+UTSiXstlLknXuNsRshkFqgjPVimy68V821BjwNr58X6rnNx0r6Mez0DljrOV6i
         fv57VR41Ob3D3SpskrdHa5/Ivo4+y4N7/ZEG51M0=
Date:   Sat, 17 Sep 2022 11:08:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        "security@kernel.org" <security@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        xmzyshypnc <1002992920@qq.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
Message-ID: <YyWOh+jGvmSdrHqz@kroah.com>
References: <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
 <YxWtfjfpNsoPUrgh@kroah.com>
 <CAJedcCzMo51aiy=Dv7zn7VmL3gwkw7JgzwAPAB2Z27C9CnhoYA@mail.gmail.com>
 <20220907030754.GU1089@zhen-hp.sh.intel.com>
 <CAJedcCxO_Rq0qMeLiHtY5+FuN1A1pDGsZd3gMtvUpm1xbAK3aA@mail.gmail.com>
 <Yxmzj2nCoTKurCY8@kroah.com>
 <CAJedcCwVC6Rg+wF7h6GhFvL6BGkKV=DS9Mo9fOf-gfDAk9VqPg@mail.gmail.com>
 <CAJedcCxRQ4h-ChNsD4OWpDMUJd3JNaQrvD=uVKxMpYONGFUgzA@mail.gmail.com>
 <YyQzDlM5n7mOLh5Q@kroah.com>
 <CAJedcCzt_1ZRV5egMLdoFVZ4hBDE+nDu9fLkBuGY0A=uYicvQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJedcCzt_1ZRV5egMLdoFVZ4hBDE+nDu9fLkBuGY0A=uYicvQA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 11:54:42PM +0800, Zheng Hacker wrote:
> >From afe79848cb74cc8e45ab426d13fa2394c87e0422 Mon Sep 17 00:00:00 2001
> From: xmzyshypnc <1002992920@qq.com>
> Date: Fri, 16 Sep 2022 23:48:23 +0800
> Subject: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry
> 
> There is a double-free security bug in split_2MB_gtt_entry.
> 
> Here is a calling chain :
> ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entry.
> 
> If intel_gvt_dma_map_guest_page failed, it will call
> ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
> kfree(spt). But the caller does not notice that, and it will call
> ppgtt_free_spt again in error path.
> 
> Fix this by only freeing spt in ppgtt_invalidate_spt in good case.
> 
> Signed-off-by: Zheng Wang <hackerzheng666@gmail.com>
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index ce0eb03709c3..550519f0acca 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -959,7 +959,7 @@ static inline int ppgtt_put_spt(struct
> intel_vgpu_ppgtt_spt *spt)
>     return atomic_dec_return(&spt->refcount);
>  }
> 
> -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
> +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt, int
> is_error);
> 
>  static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
>         struct intel_gvt_gtt_entry *e)
> @@ -995,7 +995,7 @@ static int
> ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,

Still line-wrapped and whitespace broken :(

