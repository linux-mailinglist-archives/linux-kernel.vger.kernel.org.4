Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBAB652C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiLUFBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUFBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:01:39 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55F1FCD1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:01:38 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id q18-20020a056830441200b006704633f258so8474653otv.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDUOHVCc9K3hdDQtTl6zCt6I0//F7xbzgiL5zzmDHKU=;
        b=meh0/v7prpFdpKiPJ2jFndEeeaLwe28XcA3Wg4xD2/6znobuR8gOtGAT62vSkwC/y3
         bUaZKxv6XpNj0JW3vKL5hqC9tW5LPcucYX09ux9reWhiU9gIdavVc1E6DVwW2m1geAbz
         J+B+aL17Me09HsYZR3ecaY/VTK0codX/zMleIguScWjX/nZ5mnbnJTAzYqsCAf0hH8NS
         oapnDOL3/5601W6BxO5x1miXR1WtbM5i1M+eyppj8QT6SV32q+olRoVOm6TjiSecc9sF
         ltkd9asgtFUyObo5WUS6NtA2Ocw7oc258SBFzcjx3XrwaFYczF3+Np64hDi1usb8MRw1
         r5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDUOHVCc9K3hdDQtTl6zCt6I0//F7xbzgiL5zzmDHKU=;
        b=GEXW49H54KnjJYr1nBjXFP4HInvE32ZwnsxV0GhXFGqAhuAUvko2ukv4rbhbYGg2OJ
         nm/gZkBO2TowB9aE8alwTvbJzeDK35qy69XKBpTf5gTN+n7zM+M0AjehJI0Bcs+jMTMD
         /QzRIZK3DqUx7JSgEg7kGfKKJJFdJ/Wj8Dcd4TMjnUa+9FH7+QPY4cfb4VuvIXu+F41b
         aYrJjoUcO8iZOM33XqFhRhvI5m8SIxgqc67YEex9lfqzc3WYF60oOlZc1a3cv+/l5fJz
         xTdtM+LWsI2z1V7zXjzoiSg3cJl5XuoVOz5cSHNaoelMeXBVKUlbK7iPLLvKsM1GuzY0
         c4vA==
X-Gm-Message-State: AFqh2krN1jkttCPFJONLjrVaM/Rm+vzfd483Z8pt1Jdi50k95q7KoVMF
        Wxl+LIa8GbSUYmatDE2nma+GATsGFa+exvuv6PM=
X-Google-Smtp-Source: AMrXdXtS1JI4CuCqdbp9KkbNyVpLqhCpVOQBSeOh2PyUNfq8iexFzbkqPy13qZFcsTa54khLLs/pav+EzFCl8ZS6zV8=
X-Received: by 2002:a05:6830:3095:b0:670:7942:b562 with SMTP id
 g21-20020a056830309500b006707942b562mr41452ots.84.1671598897767; Tue, 20 Dec
 2022 21:01:37 -0800 (PST)
MIME-Version: 1.0
References: <11728bc1-7b59-1623-b517-d1a0d57eb275@intel.com>
 <20221220094014.1128207-1-zyytlz.wz@163.com> <20221221025857.GG30028@zhen-hp.sh.intel.com>
In-Reply-To: <20221221025857.GG30028@zhen-hp.sh.intel.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 21 Dec 2022 13:01:26 +0800
Message-ID: <CAJedcCyvSW_RAOrzUkWM8Li8x6Jkd0FL6uCXCz2Jzk33dng4jQ@mail.gmail.com>
Subject: Re: [PATCH v5] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
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

Zhenyu Wang <zhenyuw@linux.intel.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=89 11:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2022.12.20 17:40:14 +0800, Zheng Wang wrote:
> > If intel_gvt_dma_map_guest_page failed, it will call
> >  ppgtt_invalidate_spt, which will finally free the spt. But the
> >  caller function ppgtt_populate_spt_by_guest_entry does not notice
> >  that, it will free spt again in its error path.
>
> indent

Yeap :)

> > +             if (ret)
> > +                     goto err;
> >               sub_se.val64 =3D se->val64;
> >
> >               /* Copy the PAT field from PDE. */
> > @@ -1231,6 +1229,18 @@ static int split_2MB_gtt_entry(struct intel_vgpu=
 *vgpu,
> >       ops->set_pfn(se, sub_spt->shadow_page.mfn);
> >       ppgtt_set_shadow_entry(spt, se, index);
> >       return 0;
> > +err:
> > +     /* Undone the existing mappings of DMA addr. */
>
> We need a verb here for Undo.

Get it.

>
> > +     for_each_present_shadow_entry(sub_spt, &sub_se, sub_index) {
> > +             gvt_vdbg_mm("invalidate 4K entry\n");
> > +             ppgtt_invalidate_pte(sub_spt, &sub_se);
> > +     }
> > +     /* Release the new allocated spt. */
> > +     trace_spt_change(sub_spt->vgpu->id, "release", sub_spt,
> > +             sub_spt->guest_page.gfn, sub_spt->shadow_page.type);
> > +     ppgtt_free_spt(sub_spt);
> > +     sub_spt =3D NULL;
>
> Not need to reset local variable that has no use then.
>
> I'll handle these trivial fixes during the merge.
>

Very thanks for that.

Best regards,
Zheng Wang
