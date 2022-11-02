Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810A4616534
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiKBOb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiKBObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:31:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4787C2B19C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:31:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id cl5so13187954wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvcd8aKkXATuRfEipojhsSmbkitfupBiLaEwnV78heo=;
        b=jrxAY3MgHeVIzcyiNPKtsXJk9dLguqghP/Fjfj+2bzpqzI8Prp73eTJhQjhB0ZFgnj
         ENkFqMekQANYww6qdtbL9fPFhaXN8sqUohuYgloCXlrnxY94ynjMY7v/GtVWYSyGfDDn
         qS2raTJYrrg6bpoLfy+Mm9I3Pe7Z+XR4H1igv3t80BCiwD8ZbSNUjfSDpImNN6LQYZW5
         LA65QwR/6sBqIRaw62mH++XBTgi2BkxGzlprT7asQsa4ZCGo77VPfN1/LUROW6AFRuu7
         koDCbwNY6WxkZbgrjHZwxSYViQQf0rwbw2gTK4aFN2KmlXQkad5K9XYDq5DY6UeMFUvb
         VBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvcd8aKkXATuRfEipojhsSmbkitfupBiLaEwnV78heo=;
        b=I9lXvbChMtAXNB8ICzbInaKpQA/kQyTAqLmEwwBFIrmcIBNbLykwEz09csgo91/D7O
         ZD3y9tWtOsQCjOieFxUd0Iue0lHdgmdEffdmQVmRL5UsRkPpssTvhF11m1MGiKlA4dik
         DMqNml1n+Opg74j7yOaD5ybqPfh5Qb8DQ6aDkMJQdr0iGJyfjoiN59ET2x/0HiGAEy3R
         AA6OGtQ5I6chc4GgwRLPhrCpPBqHVktfpEqGK85DKip++M+oYGg/Dxpu47j0kdI+qd40
         ws/wX5AkPZ4H7oMplchHDQPlnIfyC6AzSLC2xraB9MzlxGVNkiqjCZ0koPmeleGkYMek
         TZUw==
X-Gm-Message-State: ACrzQf3i7vM3X6vH4RkcfSKUuaML+Kdx58tckiIz/8mnaZPOHM9VcEmW
        ubj+63D2iRvV/vqyzfBxzODaH76jDD7BFZeppdrjNQ==
X-Google-Smtp-Source: AMsMyM6v9a6vVf5kY2HXjmezSGtsXJpE3LiX+IsFEVWUIFUbTph4Gtnxq3ntkjCtOuZTkp2cjAllhreubO89xhIpzUw=
X-Received: by 2002:a5d:4ac8:0:b0:236:781a:8d2d with SMTP id
 y8-20020a5d4ac8000000b00236781a8d2dmr15833263wrs.715.1667399478686; Wed, 02
 Nov 2022 07:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221019170835.155381-1-tony.luck@intel.com> <20221021200120.175753-1-tony.luck@intel.com>
 <20221021200120.175753-2-tony.luck@intel.com> <a60484bf-2107-8bc4-acdc-5f582f9637af@huawei.com>
 <SJ1PR11MB6083F63D86CDF7810F5ACDA3FC329@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAG_fn=WG2-k74zKv2_-jAqU+WDraJDnFZ_hM58FPgswnXs=BrA@mail.gmail.com>
In-Reply-To: <CAG_fn=WG2-k74zKv2_-jAqU+WDraJDnFZ_hM58FPgswnXs=BrA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 2 Nov 2022 15:30:42 +0100
Message-ID: <CAG_fn=UQUAQGNEGisADkgpe=MHg-8QcNZdgtJPmaLxyLdLc_NA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm, hwpoison: Try to recover from copy-on write faults
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 3:27 PM Alexander Potapenko <glider@google.com> wrot=
e:
>
> On Fri, Oct 28, 2022 at 6:14 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > >> +    vfrom =3D kmap_local_page(from);
> > >> +    vto =3D kmap_local_page(to);
> > >> +    ret =3D copy_mc_to_kernel(vto, vfrom, PAGE_SIZE);
> > >
> > > In copy_user_highpage(), kmsan_unpoison_memory(page_address(to), PAGE=
_SIZE) is done after the copy when
> > > __HAVE_ARCH_COPY_USER_HIGHPAGE isn't defined. Do we need to do someth=
ing similar here? But I'm not familiar
> > > with kmsan, so I can easy be wrong.
> >
> > It looks like that kmsan_unpoison_memory() call was added recently, aft=
er I copied
> > copy_user_highpage() to create copy_mc_user_highpage(). I'm not familia=
r with
> > kmsan either. Adding Alexander to this thread since they added that cod=
e.
> >
>
> Given that copy_mc_user_highpage() replaces one of the calls to
> copy_user_highpage(), it sure makes sense to call
> kmsan_unpoison_memory() here.
>
> KMSAN tracks the status (initialized/uninitialized) of the kernel
> memory. Newly allocated memory is marked uninitialized, copying memory
> preserves its status, and writing constants to that memory makes it
> initialized.
> Userspace memory does not have its status tracked by KMSAN, so when
> values are copied from the userspace, KMSAN does nothing with their
> status.
> That's why every (successful) copy_from_user event should be followed
> by kmsan_unpoison_memory(), which marks the corresponding kernel
> buffer initialized - otherwise the status of that buffer may get
> stale.
>
> > > Anyway, this patch looks good to me. Thanks.
> > >
> > > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> >
> > Thanks for the review.
> >
> > -Tony
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
