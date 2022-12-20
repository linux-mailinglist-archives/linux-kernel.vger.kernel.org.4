Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDE651CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiLTJD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLTJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:03:55 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292AD113B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:03:54 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-14455716674so14700291fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzvNL+TsR6wJp/VVk0N1EHg2FFHt1BbH9bwtEX37Mi8=;
        b=l3PXEmY/Kh0b3BeAbHpZa0feNze1JUpM8+hStS2W1fAAhwIMr19+c7vde4hb3ClotP
         Je6KhjVpQ3nXGc+tmOdyLDy1po5FWDBYKeh3I0dcKWIb49j6tkB8f3AIgrICYeIEDYo6
         vwbcqk2Oz9ctUixuyecsbsY7PtYPFr5RuMYa2CAix4hdO/zOtysHwkRTIuW4Za+b8R0T
         fD0n7MzKKc8jibi1q4YkG7zWGsHs7/zmm35OhNU+w5QLrsyN1gZBG1PVQPHgTF3MMs9H
         4LkJytrnPymeTkXq5oXhKRy0tzt2k3W2V1XWQz0kOpmvPcCjQ23PtZWRsfyXpOxXk5yP
         jicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzvNL+TsR6wJp/VVk0N1EHg2FFHt1BbH9bwtEX37Mi8=;
        b=B6x5n1WVZOF4sRmf8Ocob9m2MFkMn9yfsoytVNkUCCpzcXV2Qa4lCvLZscTGrI753e
         ejQL6V/m6tZikIv5R805B1voM5SDjfbJWjDu+MT07FMsd6TgTiUfvjIBoMoVWRHf5RKi
         up4t6/8yVKKv+VHRx2LAcG1acq1rasz5S7JuCmuxNqvH4KYQ37iqhDbcouSz7lS29VwV
         0vsgLpgPLTXTHL9ao4a4nKexoM3wkyloHcHSsr+UNchKgifbQTEqPthLDn8WHr4/Av3B
         GawMzxyh/iI80t7bf61q/JKCee/a/TVqibZBEr5nGwfkcv95ICkv+wDXPVeDdP+cTMVi
         fPDg==
X-Gm-Message-State: AFqh2koxbuvMIpdmkc5yQ7T10+Fe+t/41VN/gsBqV/GuWa25Nbcl4bGl
        xhH11Zq+6KneGs7Jo1pzbHZbsQuoIcuFhPrToNk=
X-Google-Smtp-Source: AMrXdXveFr80wwpqNX3EU58rZEURdkoOkmVxIfys7NPcpdUmvbzGH0j/NN1RcyEMJ4xghKpphstg1uEAj1cGVX+gMlU=
X-Received: by 2002:a05:6870:6083:b0:14b:7e0a:eefa with SMTP id
 t3-20020a056870608300b0014b7e0aeefamr1637834oae.49.1671527033285; Tue, 20 Dec
 2022 01:03:53 -0800 (PST)
MIME-Version: 1.0
References: <11728bc1-7b59-1623-b517-d1a0d57eb275@intel.com>
 <20221219125204.1001149-1-zyytlz.wz@163.com> <20221220082255.GE30028@zhen-hp.sh.intel.com>
In-Reply-To: <20221220082255.GE30028@zhen-hp.sh.intel.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 20 Dec 2022 17:03:41 +0800
Message-ID: <CAJedcCzD6Zc=ncxH5821OA=zL49bUFqD2hYT=TruU2AVt+_2hg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, zhi.a.wang@intel.com,
        alex000young@gmail.com, security@kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        gregkh@linuxfoundation.org, intel-gfx@lists.freedesktop.org,
        joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, 1002992920@qq.com, airlied@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenyu Wang <zhenyuw@linux.intel.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=BA=8C 16:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2022.12.19 20:52:04 +0800, Zheng Wang wrote:
> > If intel_gvt_dma_map_guest_page failed, it will call
> >  ppgtt_invalidate_spt, which will finally free the spt. But the caller =
does
> >  not notice that, it will free spt again in error path.
> >
>
> It's not clear from this description which caller is actually wrong,
> better to clarify the problem in ppgtt_populate_spt_by_guest_entry() func=
tion.
>

Get it, will do in the next fix.


> >                                                  PAGE_SIZE, &dma_addr);
> > -             if (ret) {
> > -                     ppgtt_invalidate_spt(spt);
> > -                     return ret;
> > -             }
> > +             if (ret)
> > +                     goto err;
>
> I think it's fine to remove this and leave to upper caller, but again ple=
ase
> describe the behavior change in commit message as well, e.g to fix the sa=
nity
> of spt destroy that leaving previous invalidate and free of spt to caller=
 function
> instead of within callee function.

Sorry for my bad habit. Will do in the next version.

> >               sub_se.val64 =3D se->val64;
> >
> >               /* Copy the PAT field from PDE. */
> > @@ -1231,6 +1229,47 @@ static int split_2MB_gtt_entry(struct intel_vgpu=
 *vgpu,
> >       ops->set_pfn(se, sub_spt->shadow_page.mfn);
> >       ppgtt_set_shadow_entry(spt, se, index);
> >       return 0;
> > +err:
> > +     /* Undone the existing mappings of DMA addr. */
> > +     for_each_present_shadow_entry(spt, &e, parent_index) {
>
> sub_spt? We're undoing what's mapped for sub_spt right?

Yes, will change it to sub_spt in the next version.

>
> > +             switch (e.type) {
> > +             case GTT_TYPE_PPGTT_PTE_4K_ENTRY:
> > +                     gvt_vdbg_mm("invalidate 4K entry\n");
> > +                     ppgtt_invalidate_pte(spt, &e);
> > +                     break;
> > +             case GTT_TYPE_PPGTT_PTE_64K_ENTRY:
> > +                     /* We don't setup 64K shadow entry so far. */
> > +                     WARN(1, "suspicious 64K gtt entry\n");
> > +                     continue;
> > +             case GTT_TYPE_PPGTT_PTE_2M_ENTRY:
> > +                     gvt_vdbg_mm("invalidate 2M entry\n");
> > +                     continue;
> > +             case GTT_TYPE_PPGTT_PTE_1G_ENTRY:
> > +                     WARN(1, "GVT doesn't support 1GB page\n");
> > +                     continue;
> > +             case GTT_TYPE_PPGTT_PML4_ENTRY:
> > +             case GTT_TYPE_PPGTT_PDP_ENTRY:
> > +             case GTT_TYPE_PPGTT_PDE_ENTRY:
>
> I don't think this all entry type makes sense, as here we just split
> 2M entry for multiple 4K PTE entry.

I got it. I will leave the code for handling 4K PTE entry only.

>
> > +                     gvt_vdbg_mm("invalidate PMUL4/PDP/PDE entry\n");
> > +                     ret1 =3D ppgtt_invalidate_spt_by_shadow_entry(
> > +                                     spt->vgpu, &e);
> > +                     if (ret1) {
> > +                             gvt_vgpu_err("fail: shadow page %p shadow=
 entry 0x%llx type %d\n",
> > +                             spt, e.val64, e.type);
> > +                             goto free_spt;
> > +                     }
>
> for above reason, I don't think this is valid.

Got it.


Thanks for your carefully reviewing. I'll try to fix that in the coming pat=
ch.

Best regards,
Zheng Wang
