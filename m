Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF1E7095D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjESLEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjESLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:03:46 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0527D1BC1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:03:17 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-436161f2cf2so1009501137.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684494195; x=1687086195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jNtnl0ixWjSP8DQh9+bE2W7QXjs5PjGYkgY8RBy91o=;
        b=lU582uaFvhsPxMB8wieIzAYVgQG0KGIWH5cpY+cPNeH8AcChj+NQrDExmvzlD85f1V
         ho3n07Z0lPb/nZAhAj8HaO/7OuryGP6bmiZoBTVPtTr0Md3umRYMurtmeMt56QPXDhAU
         ZYK7YKR1jeL/P6YgBayTNbuskzqzqz/E6ELcQ60RAv3adDsA9IW2KwJczxSo/XxSC2D+
         zJMPvHCrG7oz1+RYdMeTvBMYWe7ZwljIqsHQDpPeIMGyh3/SIr5eH8fopc3zsGu+Ftwk
         Md7xrkI0AiGAaimELV0QiMeUNcxVLBtFiXts7gsrBXsbiLfRBc8RSTgBzQGn45eprW+B
         41tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684494195; x=1687086195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jNtnl0ixWjSP8DQh9+bE2W7QXjs5PjGYkgY8RBy91o=;
        b=jROqOLmtB+6VymsDKTe6RbSrBQEGXyIoecJwMs04bxIFNJqKqIktubdZov6BNj/RdT
         cLyJ9l56vETqYfjU+ALDNjaXstxFgFBWRiRDyRaKxC6OzDyjFagKv92PZL5+/JZkAA4p
         SZKFzEE25gzwFO22bRFpLqKCORekSzn+q4yKgcD8oJVDieTgwDUujpY9ZpZ40qJyvYbo
         q+R/x9DsBV5JB8wSbsboapEOlF5GSCDmuhF+nQNCM7dq0OutwkKKeWQTHpEaj53XkPmi
         T9vGYbZ3aw10cywrUzPjpIX/qrbqzvT+py0B0lbWYNW70nWKicGpmymzprifSxCXMuZj
         Sgqw==
X-Gm-Message-State: AC+VfDx7VP9QCnKrglYK5qKIFYXdCjOWmdAg734hpJZ7PnsJYyTAF4FW
        +38dkrd7ehFNJmGo0kXpZRCv7o44UMhvxs8ZiEZ4aA==
X-Google-Smtp-Source: ACHHUZ4IoNjXX/D7uJQbUhx4UKBwK7sl5gNbLX0mtILlCTVmUCh4lNnPA6iI5tSHHiw6QYjcc4RCsC5Pgf5JNANsywo=
X-Received: by 2002:a67:cd99:0:b0:438:d4bd:f1f2 with SMTP id
 r25-20020a67cd99000000b00438d4bdf1f2mr318974vsl.22.1684494195773; Fri, 19 May
 2023 04:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org> <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org> <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
 <ZGSgCZrg+RjAbGO1@infradead.org> <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
 <781d993204fbbdf30a6ca495b59b3b0aa7a2e496.camel@mediatek.com> <83a846a9-8f88-3f66-b840-e84d072bb0fb@redhat.com>
In-Reply-To: <83a846a9-8f88-3f66-b840-e84d072bb0fb@redhat.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 19 May 2023 16:33:04 +0530
Message-ID: <CAFA6WYOfku70PXso9LeO0G=443NVFKsmxgsZUnMwKwnSZ6bg5A@mail.gmail.com>
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
To:     David Hildenbrand <david@redhat.com>
Cc:     =?UTF-8?B?WGlhb21pbmcgRGluZyAo5LiB5pmT5piOKQ==?= 
        <Xiaoming.Ding@mediatek.com>,
        "hch@infradead.org" <hch@infradead.org>,
        =?UTF-8?B?RmVpIFh1ICjlvpDpo54p?= <Fei.Xu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 at 15:31, David Hildenbrand <david@redhat.com> wrote:
>
> On 18.05.23 08:40, Xiaoming Ding (=E4=B8=81=E6=99=93=E6=98=8E) wrote:
> >  From 35fd062d5cbc4d182eee0183843cd6350d126788 Mon Sep 17 00:00:00 2001
> > From: Xiaoming Ding <xiaoming.ding@mediatek.com>
> > Date: Wed, 10 May 2023 10:15:23 +0800
> > Subject: [PATCH v2] tee: add FOLL_LONGTERM for CMA case when alloc shm
> >
> > CMA is widely used on insufficient memory platform for
> > secure media playback case, and FOLL_LONGTERM will
> > avoid tee_shm alloc pages from CMA region.
> > without FOLL_LONGTERM, CMA region may alloc failed since
> > tee_shm has a chance to use it in advance.
> >
> > modify is verified on OPTEE XTEST and kinds of secure + clear playback
> >
> >
> > Fixes: 033ddf12bcf5 ("tee: add register user memory")
> > Signed-off-by: Xiaoming Ding <xiaoming.ding@mediatek.com>
> > ---
> > v1 -> v2: take off the ifdef and apply FOLL_LONGTERM by default
> >
> >   drivers/tee/tee_shm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 673cf0359494..38878e549ca4 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -257,7 +257,7 @@ register_shm_helper(struct tee_context *ctx,
> > unsigned long addr,
> >       }
> >
> >       if (flags & TEE_SHM_USER_MAPPED)
> > -             rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE,
> > +             rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE |
> > FOLL_LONGTERM,
> >                                        shm->pages);
> >       else
> >               rc =3D shm_get_kernel_pages(start, num_pages, shm-
> >> pages);
>
> I didn't dive deeply into that code, but I can spot that we can end up
> long-term pinning multiple pages -- possibly unbound or is there any
> sane limit on the number of pages?

I am not aware of any limit that we put on pinning user-space pages.

>
> Take a look at io_uring/rsrc.c and how we account long-term pinned pages
> against user->locked_vm/ctx->mm_account->pinned_vm in io_account_mem().
>
> If user space could only end up pinning one or two pages via that
> interface, ok. But it looks like this interface could be abused to
> create real real trouble by unprivileged users that should be able to
> long-term pin that many pages.
>
> Am I missing something important (i.e., interface is only accessible by
> privileged users) or should there be proper accounting and
> RLIMIT_MEMLOCK checks?

So your observation is correct. With long term pinning we have to
implement similar RLIMIT_MEMLOCK checks. Thanks for your insights
here.

-Sumit

>
> --
> Thanks,
>
> David / dhildenb
>
