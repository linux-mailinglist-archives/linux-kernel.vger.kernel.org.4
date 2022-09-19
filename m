Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6925BC5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiISJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiISJzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:55:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F8B25E9B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:55:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b35so40510415edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=vnJl0L26F6/cF4LoX36tFsaUdJl5yJVNsgmOYHfsRBo=;
        b=Vb58P5FPswub/ju264ON0G6rNOIDPCQ3GPgtbDnL9G5e9OBp6YY93sVXlx6LwidIDc
         Fo0wgvT7f3ra1kG8Qxo0C/PW+CW/jHl8oUXedW/ZeTrOMcu59U4vz6luprsm8n4rKs0o
         LL8/pP7VsWejZczbgFWn7bDQVLHvRSUsimYgLZaiusojf3ZnzqrJPYOddQNashyMTT3D
         6nbCCvedQcphnp7D/OpFqSZUvY9MMrkYFVDiovOKRP/e8NgwVnfH+d5GpLRl3vRmyevv
         YgjtVqSmTVsn4Pz7me5Mk+4fIBQRDlkSzXyxcoti6H2JR9XCFcnRo3xQKyVT50kpQm5+
         kpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vnJl0L26F6/cF4LoX36tFsaUdJl5yJVNsgmOYHfsRBo=;
        b=8CTfexWnisOf6AqtuTNmrv2PveE/EOE68BnzULMZQbQ7kKcKbH8qNsZl7ktkfb7RfG
         mBnPM1lUBfRyK/+nHVCD+Ihhh8xz9JMNPsGtzHhj9R3ZvJVZarubB9k42lp9v6P4lBC3
         U+Kphj/15nqIkDuAmRZt2BQm2RdzY7C0c14T0/xAx1/dyjfEYgV/M1wibVP+cXf5u5A9
         uAif8job4nR3M/oTZyduldDXpTXiiUkOiNC1XUVbhsCqdwTT2i5xbRQ/ty3ftYUPv40d
         YKgiwlNnkRNPyoXzUu8PtF1/WKfp3eZGT4gwiCYP/g1cceICIez+1taDArgNa3udV4NV
         NF2Q==
X-Gm-Message-State: ACrzQf1v8KPpZxSnhs7IlM9qt6TWsbhMPefZUjiFx2R2JhP5T/fEOh/o
        6TlcT7o9/XpPtXnmXMcTXLCy79QqwQq8irORAMI=
X-Google-Smtp-Source: AMsMyM42HTbF/UFDvgdJ38PdEt0hijqa/khgCG00F9Fw/uY27h2or8B5g7sF95ObpJXZFD0OXeAG8T7xvZxPYQltuX0=
X-Received: by 2002:a05:6402:2b8f:b0:453:2e59:364d with SMTP id
 fj15-20020a0564022b8f00b004532e59364dmr14954390edb.254.1663581346809; Mon, 19
 Sep 2022 02:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_ED24158E83CB9885E8BDD173EB5896B51906@qq.com> <87pmfrpv7q.fsf@intel.com>
In-Reply-To: <87pmfrpv7q.fsf@intel.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 19 Sep 2022 17:55:35 +0800
Message-ID: <CAJedcCxWAjsB-zcGn_epE=1d=LTeX-ndNunLqQJ842+ptjy=Bw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Zheng Wang <1002992920@qq.com>, gregkh@linuxfoundation.org,
        alex000young@gmail.com, security@kernel.org,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

Got it. I'll try again later.

Best Regards,
Zheng Wang

Jani Nikula <jani.nikula@linux.intel.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=881=
9=E6=97=A5=E5=91=A8=E4=B8=80 17:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 19 Sep 2022, Zheng Wang <1002992920@qq.com> wrote:
> >  From afe79848cb74cc8e45ab426d13fa2394c87e0422 Mon Sep 17 00:00:00 2001
> > From: xmzyshypnc <1002992920@qq.com>
> > Date: Fri, 16 Sep 2022 23:48:23 +0800
> > Subject: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_ent=
ry
> >
> > There is a double-free security bug in split_2MB_gtt_entry.
> >
> > Here is a calling chain :
> > ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entry.
> >
> > If intel_gvt_dma_map_guest_page failed, it will call
> > ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
> > kfree(spt). But the caller does not notice that, and it will call
> > ppgtt_free_spt again in error path.
> >
> > Fix this by only freeing spt in ppgtt_invalidate_spt in good case.
> >
> > Signed-off-by: xmzyshypnc <1002992920@qq.com>
>
> Please use git send-email. The patch is whitespace broken and line
> wrapped, making it unusable.
>
> BR,
> Jani.
>
>
> > ---
> >   drivers/gpu/drm/i915/gvt/gtt.c | 16 +++++++++-------
> >   1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/=
gtt.c
> > index ce0eb03709c3..550519f0acca 100644
> > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > @@ -959,7 +959,7 @@ static inline int ppgtt_put_spt(struct
> > intel_vgpu_ppgtt_spt *spt)
> >       return atomic_dec_return(&spt->refcount);
> >   }
> >
> > -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
> > +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt, int
> > is_error);
> >
> >   static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vg=
pu,
> >           struct intel_gvt_gtt_entry *e)
> > @@ -995,7 +995,7 @@ static int
> > ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
> >                   ops->get_pfn(e));
> >           return -ENXIO;
> >       }
> > -    return ppgtt_invalidate_spt(s);
> > +    return ppgtt_invalidate_spt(s, 0);
> >   }
> >
> >   static inline void ppgtt_invalidate_pte(struct intel_vgpu_ppgtt_spt *=
spt,
> > @@ -1016,7 +1016,7 @@ static inline void ppgtt_invalidate_pte(struct
> > intel_vgpu_ppgtt_spt *spt,
> >       intel_gvt_dma_unmap_guest_page(vgpu, pfn << PAGE_SHIFT);
> >   }
> >
> > -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
> > +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt, int
> > is_error)
> >   {
> >       struct intel_vgpu *vgpu =3D spt->vgpu;
> >       struct intel_gvt_gtt_entry e;
> > @@ -1059,9 +1059,11 @@ static int ppgtt_invalidate_spt(struct
> > intel_vgpu_ppgtt_spt *spt)
> >           }
> >       }
> >
> > -    trace_spt_change(spt->vgpu->id, "release", spt,
> > +    if (!is_error) {
> > +        trace_spt_change(spt->vgpu->id, "release", spt,
> >                spt->guest_page.gfn, spt->shadow_page.type);
> > -    ppgtt_free_spt(spt);
> > +        ppgtt_free_spt(spt);
> > +    }
> >       return 0;
> >   fail:
> >       gvt_vgpu_err("fail: shadow page %p shadow entry 0x%llx type %d\n"=
,
> > @@ -1215,7 +1217,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu
> > *vgpu,
> >           ret =3D intel_gvt_dma_map_guest_page(vgpu, start_gfn + sub_in=
dex,
> >                              PAGE_SIZE, &dma_addr);
> >           if (ret) {
> > -            ppgtt_invalidate_spt(spt);
> > +            ppgtt_invalidate_spt(spt, 1);
> >               return ret;
> >           }
> >           sub_se.val64 =3D se->val64;
> > @@ -1393,7 +1395,7 @@ static int ppgtt_handle_guest_entry_removal(struc=
t
> > intel_vgpu_ppgtt_spt *spt,
> >               ret =3D -ENXIO;
> >               goto fail;
> >           }
> > -        ret =3D ppgtt_invalidate_spt(s);
> > +        ret =3D ppgtt_invalidate_spt(s, 0);
> >           if (ret)
> >               goto fail;
> >       } else {
>
> --
> Jani Nikula, Intel Open Source Graphics Center
