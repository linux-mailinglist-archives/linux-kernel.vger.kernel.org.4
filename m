Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8775BFA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiIUJPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiIUJNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:13:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD98E461
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:13:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a41so7703749edf.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=l1vyb533afax2OC0XKhODZY3BbHylHPbSqXDEOL933M=;
        b=lexMAsGpZ4uEBXdBTpjGyZOQZbhz7PxOKpVGZx8r1n6iEClWEb2QgJhRCqVNybC4Zb
         umXIRTZtp4aBvlzpZOZ2hzAxKU31SiyYYjtfU+gZPLt6b9qHhGA003E8M5qtNmH2fnFK
         nchHZWUfq5ISXapeTIsdxmnTtZBV/QEoave+BO/SB2lPbt07zYW7r4PJRZdFzPZyhG+X
         VgCsD3BKY5P8SsGT6h+idC632uotCVMDnO4bMEL8tfUssm3i662dpQJ2uawr5G4TWFBL
         UDBGMWnbgSJ2CzHoKasq1mzIfpXFz/m4ecRfLS/c5GepOMiYEU6cmSY1VVs1zXW/jrVX
         7caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=l1vyb533afax2OC0XKhODZY3BbHylHPbSqXDEOL933M=;
        b=XRIhNYtFEhECdF6r5FBNcb7Bn/vyKQzqBRJO0LUNzEwL76hRDY9AVTyxbxqliBf4xo
         Yjkn44UL7/l3uPXCg7nyoytjMqaYBHESEi2Kwcpxju0aPsogd4sH3FaToAPpO2tXtK8b
         PF7xh3fGla+zFLCDOLTRSUgs3LU1strjq15iUzAZzg419KFh6aQS+nNg72nIg91iV4ta
         VZyXYIbGK6AICH4Gy7TPlm7cLTQdCmR/vKUyLSEZIKO9dHoOVMO0LNPquzpz1/ah1ogw
         OlYTJp+bb8LH7vZ9RwjrQ4RON/97B2Zz3exK2jYlc+rnqscQ6vo5h7lyZpcOJM1864N+
         hsHw==
X-Gm-Message-State: ACrzQf1D/3ou8SBESA+np9bQZQzQZBi5Un3wpO+g246nsDmjFJdnYVFZ
        iOMF+zi8ExgAzQUn034ZjerRXANGzBBkAjGzWR8=
X-Google-Smtp-Source: AMsMyM6qZWoSutaGxavU1l+b7Gm2hjgycXdK2iBnT1E6FzoR1kMbyw7qnFJJdbmwW2B+f+vp5HuJ/trMQxljKzrjOS4=
X-Received: by 2002:aa7:df87:0:b0:44e:2851:7e8d with SMTP id
 b7-20020aa7df87000000b0044e28517e8dmr24459923edy.106.1663751592281; Wed, 21
 Sep 2022 02:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_ED24158E83CB9885E8BDD173EB5896B51906@qq.com> <87pmfrpv7q.fsf@intel.com>
In-Reply-To: <87pmfrpv7q.fsf@intel.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 21 Sep 2022 17:13:00 +0800
Message-ID: <CAJedcCzjWw6v5Nt42jsCStdpwHuz13D+q-CD=6ycVWBczY+4mg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Zheng Wang <1002992920@qq.com>, gregkh@linuxfoundation.org,
        alex000young@gmail.com, security@kernel.org,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've sent it using git send-email with another email account (zyytlz.wz@163=
.com)

Regards,
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
