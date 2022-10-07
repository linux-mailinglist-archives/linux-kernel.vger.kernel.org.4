Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526A05F7254
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJGAkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiJGAj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:39:57 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B8222A4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:39:53 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id oo23so2082148qkn.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 17:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mj2EKWpfo6LoRYDkuVsvJBcVKzsfzIJ++jT12GdLtjw=;
        b=NNuJ21y4cpn/LHDvmMlpXXSqwGlnw4Enf3ugrTMqCr9Enfv1BKIsoBIvPZeN4gB2wD
         T879SHPsMRPk6FVeTnWkejya9x9QHUfcnj6Q83rPN3ymPCEep7T/nIkC5AMEaJKaD8KP
         mIr5CcRrbc1gEvyKtD4tEopP+xlPYqj6JaAnHQOVXK+8kgPcnPV0l4/KRsXT12/6S3S2
         J7iOU2tiAuaEP/UlKH+M2Jcpluupd/AhHIkkVuaaEs+8O/pyCO4lc/LViZEwRCeI125M
         aIftgKO7UQJCU7wjfkkpD3NQzVkMgs/jNrD7cbtaCKT2TVO1W29qLh1bLAYEfDpDTTYr
         /0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mj2EKWpfo6LoRYDkuVsvJBcVKzsfzIJ++jT12GdLtjw=;
        b=3T1YxGsRBl0rw5hx/PIJfYhppWuf9icboRDT0UfXv93vcRXctyFf7oBVBMylW9QV0f
         Q9Nv7jTeWnXnSgShM09nahpQnfmMmrY0TQ2WixJwmB7VKlc9TGZGbtcx05ERFsHYdpe8
         Qcut8d2gaiWhIVx2TCleRkquDdKeuoyQDOe0RnXR12yB2OsI8RYo4YuazVBn8cFC+sl7
         L7rf4RszjYoFy3ZkFN4a0VAfrcSDpVlVGrMUNsvgmqa7UKzJl7Ynnxlae1TCBsVbZ+Q3
         N+l3Qjpdjs+2sj1whGIIsuWGbSPdVVQ1+YoY2eBHbnJxC6pCzQSlFQygZ3FPA5C5N/vU
         6dhA==
X-Gm-Message-State: ACrzQf1DxzSAgJkREXa+XbMURZvZ+qqFV/b2LHVCpgun702cQVQ2HWIi
        aHRQX+O6b9aW3/hLFZGx9YMOCEKqRwWDdTn+8e4=
X-Google-Smtp-Source: AMsMyM5E1MzJ9JQuEPVSkfHBhXtesLAjNLwtvKUUNIgWqw4vmmVqwk5Lo475kuPJV7EdDHi5CwLpb51+OhgddVqUX1g=
X-Received: by 2002:ae9:e011:0:b0:6e4:41aa:eb0f with SMTP id
 m17-20020ae9e011000000b006e441aaeb0fmr2272174qkk.8.1665103192715; Thu, 06 Oct
 2022 17:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220928033340.1063949-1-zyytlz.wz@163.com> <20221006165845.1735393-1-zyytlz.wz@163.com>
 <Yz8rIxV7bVCcfZb0@kroah.com>
In-Reply-To: <Yz8rIxV7bVCcfZb0@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 7 Oct 2022 08:39:41 +0800
Message-ID: <CAJedcCwwNFWU0_RQ1aG4WQc9JGUYWKKhKtZx_drV3T3n9UD3sQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, 1002992920@qq.com,
        airlied@linux.ie, alex000young@gmail.com,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org,
        security@kernel.org, tvrtko.ursulin@linux.intel.com
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

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B410=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=94 03:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Oct 07, 2022 at 12:58:45AM +0800, Zheng Wang wrote:
> > If intel_gvt_dma_map_guest_page failed, it will call
> > ppgtt_invalidate_spt, which will finally free the spt.
> > But the caller does not notice that, it will free spt again in error pa=
th.
> >
> > Fix this by spliting invalidate and free in ppgtt_invalidate_spt.
> > Only free spt when in good case.
> >
> > Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> > v2:
> > - split initial function into two api function suggested by Greg
> >
> > v1: https://lore.kernel.org/all/20220928033340.1063949-1-zyytlz.wz@163.=
com/
> > ---
> >  drivers/gpu/drm/i915/gvt/gtt.c | 31 +++++++++++++++++++++----------
> >  1 file changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/=
gtt.c
> > index ce0eb03709c3..55d8e1419302 100644
> > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > @@ -959,6 +959,7 @@ static inline int ppgtt_put_spt(struct intel_vgpu_p=
pgtt_spt *spt)
> >       return atomic_dec_return(&spt->refcount);
> >  }
> >
> > +static int  ppgtt_invalidate_and_free_spt(struct intel_vgpu_ppgtt_spt =
*spt);
>
> Odd extra space after the 'int', why?
>

Hi Greg,

Sorry it's a spelling mistake. I'll correct it right away :)

Thanks,
Zheng Wang
