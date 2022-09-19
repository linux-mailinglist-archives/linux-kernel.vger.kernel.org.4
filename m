Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F72C5BC562
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiISJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiISJbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:31:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5FB1D0D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663579863; x=1695115863;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Wm82v0gvwNP1lKdhTEKnO4gPdEPdmnpw+d87R28dzDA=;
  b=JoXFufG8dY6DsJXZ0QRoN2GK03GkGG3Xq4AqYUApWlGiaqqzTMR/+eFd
   urTIup+rdyURdkJVn9ybOrRh18xFB9qCP5b+wlR9jXwcjJvR7YsQvIwos
   Twu9Q90QUIip/ZMVQ9TX4jhPvtm/2o2obqVI+gpbBZ4Y8tHW6oyHdemnH
   SNV0EJRIuPUCywFa2k3es/3dklvvrDxu4SoUreUL8KUODCuHTQS1u/0Jo
   xpo2RTi1e7HZgOghJS9cuhmhOS32QiKxJyMaEJOeHaJ+HK+8jy580ttLS
   zMVWR+Cm3HKVoNM/buruDYdpCdwHzCxpTHMRYN3JhOR2qn4N2cygD0yC5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="325641720"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="325641720"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 02:30:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="793787602"
Received: from jjohns2-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.57.205])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 02:30:48 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Zheng Wang <1002992920@qq.com>, gregkh@linuxfoundation.org
Cc:     alex000young@gmail.com, security@kernel.org,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, hackerzheng666@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry
In-Reply-To: <tencent_ED24158E83CB9885E8BDD173EB5896B51906@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <tencent_ED24158E83CB9885E8BDD173EB5896B51906@qq.com>
Date:   Mon, 19 Sep 2022 12:30:33 +0300
Message-ID: <87pmfrpv7q.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022, Zheng Wang <1002992920@qq.com> wrote:
>  From afe79848cb74cc8e45ab426d13fa2394c87e0422 Mon Sep 17 00:00:00 2001
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
> Signed-off-by: xmzyshypnc <1002992920@qq.com>

Please use git send-email. The patch is whitespace broken and line
wrapped, making it unusable.

BR,
Jani.


> ---
>  =C2=A0drivers/gpu/drm/i915/gvt/gtt.c | 16 +++++++++-------
>  =C2=A01 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gt=
t.c
> index ce0eb03709c3..550519f0acca 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -959,7 +959,7 @@ static inline int ppgtt_put_spt(struct=20
> intel_vgpu_ppgtt_spt *spt)
>  =C2=A0=C2=A0=C2=A0=C2=A0 return atomic_dec_return(&spt->refcount);
>  =C2=A0}
>
> -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
> +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt, int=20
> is_error);
>
>  =C2=A0static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu =
*vgpu,
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 struct intel_gvt_gtt_entry *=
e)
> @@ -995,7 +995,7 @@ static int=20
> ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 ops->get_pfn(e));
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENXIO;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 return ppgtt_invalidate_spt(s);
> +=C2=A0=C2=A0=C2=A0 return ppgtt_invalidate_spt(s, 0);
>  =C2=A0}
>
>  =C2=A0static inline void ppgtt_invalidate_pte(struct intel_vgpu_ppgtt_sp=
t *spt,
> @@ -1016,7 +1016,7 @@ static inline void ppgtt_invalidate_pte(struct=20
> intel_vgpu_ppgtt_spt *spt,
>  =C2=A0=C2=A0=C2=A0=C2=A0 intel_gvt_dma_unmap_guest_page(vgpu, pfn << PAG=
E_SHIFT);
>  =C2=A0}
>
> -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
> +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt, int=20
> is_error)
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0 struct intel_vgpu *vgpu =3D spt->vgpu;
>  =C2=A0=C2=A0=C2=A0=C2=A0 struct intel_gvt_gtt_entry e;
> @@ -1059,9 +1059,11 @@ static int ppgtt_invalidate_spt(struct=20
> intel_vgpu_ppgtt_spt *spt)
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>
> -=C2=A0=C2=A0=C2=A0 trace_spt_change(spt->vgpu->id, "release", spt,
> +=C2=A0=C2=A0=C2=A0 if (!is_error) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 trace_spt_change(spt->vgpu->id, "r=
elease", spt,
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0spt=
->guest_page.gfn, spt->shadow_page.type);
> -=C2=A0=C2=A0=C2=A0 ppgtt_free_spt(spt);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ppgtt_free_spt(spt);
> +=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>  =C2=A0fail:
>  =C2=A0=C2=A0=C2=A0=C2=A0 gvt_vgpu_err("fail: shadow page %p shadow entry=
 0x%llx type %d\n",
> @@ -1215,7 +1217,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu=20
> *vgpu,
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D intel_gvt_dma_map_gu=
est_page(vgpu, start_gfn + sub_index,
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 PAGE_SIZE, &dm=
a_addr);
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret) {
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ppgtt_invalidat=
e_spt(spt);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ppgtt_invalidat=
e_spt(spt, 1);
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return re=
t;
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 sub_se.val64 =3D se->val64;
> @@ -1393,7 +1395,7 @@ static int ppgtt_handle_guest_entry_removal(struct=
=20
> intel_vgpu_ppgtt_spt *spt,
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D -=
ENXIO;
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto fail;
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D ppgtt_invalidate_spt(s);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D ppgtt_invalidate_spt(s, 0);
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret)
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto fail;
>  =C2=A0=C2=A0=C2=A0=C2=A0 } else {

--=20
Jani Nikula, Intel Open Source Graphics Center
