Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A3D61651B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiKBO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiKBO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:28:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6BF286D9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:28:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v7so5006149wmn.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9Q0JUaa9L0FDTRBbRHtk7pORF5FI4qgSR7kELJhqR0=;
        b=YeDR6B6k0057Cx5aXSoaJU/L1oqbxiIWfIcytTEuQKn8ua9kXxpp/FBg8c7GMpufTd
         7GALet6uXxPZ7paxcBnR+iC6vKKCugT4P2jfcLM19gmosJHckL/BSvjORqaJlS1swxJw
         At0smbGcTxf0q6b64htT/WPu0/IcglEsTqXEaM9nHkaskjy6WqbBd5G6wAHVM6cVmxUt
         hPgjRCyhzqcQm6jC9EyVofwjWgK7ZrG9je7krios4rICKAYjT5+7XEYOxbanY+Ae8d2T
         TikB5IvjXbNL/1KsddzudxD5sOHytl2Ub7SfQEiIJ8AX1bicM2pZhC0MlnhxQc9bP+8w
         pzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9Q0JUaa9L0FDTRBbRHtk7pORF5FI4qgSR7kELJhqR0=;
        b=VkzCL2+mfiBMBNm7VnprtCzpIkXbV4RRetM/HjEpLSg2duzOusFkGgsavtVm9NWr9p
         2z4P7/ItWM3yu1i5woDvGYQao2URO10//sr5jK6aY49DyCF5HjjxtSDf6DCw30gM68oG
         HEZdDyBt9XHBp4eiqgXevGsCyDVXACYryfIE2Mlu8jE+u/VZ3mn8vq1jCoraI0uY8BDG
         wMj+B6zlcmvgKN40XR7tatU0NT6l6DiZjCHQkNipHwn8uD6ojYut8nAc0b68pFSFVEBp
         mY/OJZsQIqsy0qAUY31sBXP+/LZLHANHMC34c97bWpU6KAyJUsMlMSdtIlz9kz/76heM
         rpUA==
X-Gm-Message-State: ACrzQf0h9MVwALqgqN5r55oeSboGSWinBAJWDfP1GfjuNsVz56p4qP1M
        LZGhukDj8e7UQCzzYGh3jHYK5Hs3z9eUZCR7GHL0AQ==
X-Google-Smtp-Source: AMsMyM7zcxHhdaic2LXhNvhEh6OciGXa23nTNLJfIg+yjYW2Qm+0NWtRXRM86sNfUrfXj+EcENc2mD58LJ9imUYppLE=
X-Received: by 2002:a05:600c:1609:b0:3cf:4dc4:5a99 with SMTP id
 m9-20020a05600c160900b003cf4dc45a99mr16005402wmn.67.1667399307208; Wed, 02
 Nov 2022 07:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221019170835.155381-1-tony.luck@intel.com> <20221021200120.175753-1-tony.luck@intel.com>
 <20221021200120.175753-2-tony.luck@intel.com> <a60484bf-2107-8bc4-acdc-5f582f9637af@huawei.com>
 <SJ1PR11MB6083F63D86CDF7810F5ACDA3FC329@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083F63D86CDF7810F5ACDA3FC329@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 2 Nov 2022 15:27:50 +0100
Message-ID: <CAG_fn=WG2-k74zKv2_-jAqU+WDraJDnFZ_hM58FPgswnXs=BrA@mail.gmail.com>
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

On Fri, Oct 28, 2022 at 6:14 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> >> +    vfrom =3D kmap_local_page(from);
> >> +    vto =3D kmap_local_page(to);
> >> +    ret =3D copy_mc_to_kernel(vto, vfrom, PAGE_SIZE);
> >
> > In copy_user_highpage(), kmsan_unpoison_memory(page_address(to), PAGE_S=
IZE) is done after the copy when
> > __HAVE_ARCH_COPY_USER_HIGHPAGE isn't defined. Do we need to do somethin=
g similar here? But I'm not familiar
> > with kmsan, so I can easy be wrong.
>
> It looks like that kmsan_unpoison_memory() call was added recently, after=
 I copied
> copy_user_highpage() to create copy_mc_user_highpage(). I'm not familiar =
with
> kmsan either. Adding Alexander to this thread since they added that code.
>

Given that copy_mc_user_highpage() replaces one of the calls to
copy_user_highpage(), it sure makes sense to call
kmsan_unpoison_memory() here.

KMSAN tracks the status (initialized/uninitialized) of the kernel
memory. Newly allocated memory is marked uninitialized, copying memory
preserves its status, and writing constants to that memory makes it
initialized.
Userspace memory does not have its status tracked by KMSAN, so when
values are copied from the userspace, KMSAN does nothing with their
status.
That's why every (successful) copy_from_user event should be followed
by kmsan_unpoison_memory(), which marks the corresponding kernel
buffer initialized - otherwise the status of that buffer may get
stale.

> > Anyway, this patch looks good to me. Thanks.
> >
> > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
>
> Thanks for the review.
>
> -Tony



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
