Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F064E849
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLPIrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLPIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:46:12 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475FD36D4A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:45:58 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id l17so834830vkk.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LXiz7+aJfYZS7u+pOOJ8JqBinUQiC6SAWSdlj1RRZuE=;
        b=JIugqa6XxkJKeqH32MnakZAhQ4dh/k52EGTYP2TjdXA3wd1SLmkkCnOUK+b1fDbe/H
         pPIn1XDPZtmv0pqcQKtmeMmFpaWg4rBZ7C5bWj3kjA1E9xb2bG2qSIMXlXyUXVV9WHIl
         lCdjuFbhVc3vEC9GF6SptQnyTlTNwKdviiaaJAJkHUR+cPy7kwuStz+UuWpJ7xx8EG3q
         K2iLIgfCktRjVN4HmTgEWgQFEAlM/1dPXt9OGuJU/HJXPiEmTztLwdDUXI60jDFuP+s/
         AH2UqVy3EkeH+u5GK0Ek5fFij2VgPNJWzU80cT7KNC47mUX6h4iaU+l8hsDTp8WieJ1s
         t8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXiz7+aJfYZS7u+pOOJ8JqBinUQiC6SAWSdlj1RRZuE=;
        b=DUP3sOgtRqq/TzacY+yfdHJMHsAndUTKFmmYKfIFm7bRdrdJNtOViigglxp2D9nyBj
         HQ33AO7q6xpPE/qRSC3J7/lD7Jm0wfo+hNZLt4X0Mwr191iybEaL3PzcvZLmyW2y5IXM
         D+jYZFzHPZMg5Aqlqc9bxf4FeML8vCIg1ZUgba9CXkKHhXjgirWKiGKTH4IkSywmihm7
         cZdcQPqieXgNT1TBaUb2ss7s5yrUga+4uE+t040X+jzM3IINl1jPmYEFBo4fW0rRaNEF
         TZK/aekc8iizcuZEGIJhOjQ9uLjKWSPgoLZ/g5chJoC8JYEFTY/o3DwjSbPmSwgFdW+L
         OTMw==
X-Gm-Message-State: AFqh2kqEiEzp3d+hYot0lBfFsLfc5GNqTQP8zXteJ2PPgp/U8sK+vOCX
        tV0Duj6+YdALGYYxrPIcKK6g7PitmCX0AdzJ5LZtSQ==
X-Google-Smtp-Source: AMrXdXvXRG0WtWKEqOkNIeAdQuMlqwOlWChhTsxJ2eQNXxur6M4+QnXNtgAclXizRuX0Lkwq0LTJPRNV+KVcjNgVKHU=
X-Received: by 2002:a1f:4841:0:b0:3c5:a3c6:786a with SMTP id
 v62-20020a1f4841000000b003c5a3c6786amr1022458vka.4.1671180357305; Fri, 16 Dec
 2022 00:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20221002002326.946620-1-ira.weiny@intel.com> <20221002002326.946620-3-ira.weiny@intel.com>
 <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
 <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com>
 <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>
 <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>
 <CAHUa44GkTLCzuSij5FbjBXFBM1CCQROtrCtHHtj70ZRi-3K7uA@mail.gmail.com>
 <Y5u+oOLkJs6jehik@iweiny-desk3> <CAFA6WYNMRymyqkqfASYAPVoL0iR2kw0h9YKZ1gBTdeSuHMOAtQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNMRymyqkqfASYAPVoL0iR2kw0h9YKZ1gBTdeSuHMOAtQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 16 Dec 2022 14:15:46 +0530
Message-ID: <CAFA6WYMqEVDVW-ifoh-V9ni1zntYdes8adQKf2XXAUpqdaW53w@mail.gmail.com>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?UGhpbCBDaGFuZyAo5by15LiW5YuzKQ==?= 
        <Phil.Chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 at 10:39, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 16 Dec 2022 at 06:11, Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Fri, Oct 07, 2022 at 10:12:57AM +0200, Jens Wiklander wrote:
> > > On Thu, Oct 6, 2022 at 8:20 PM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Wed, Oct 5, 2022 at 11:24 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > >
> > > > > Sorry but you need to get your driver mainline in order to support
> > > > > vmalloc interface.
> > > >
> > > > Actually, I think even then we shouldn't support vmalloc - and
> > > > register_shm_helper() just needs to be changed to pass in an array of
> > > > actual page pointers instead.
> > >
> > > register_shm_helper() is an internal function, I suppose it's what's
> > > passed to tee_shm_register_user_buf() and especially
> > > tee_shm_register_kernel_buf() in this case.
> > >
> > > So the gain is that in the kernel it becomes the caller's
> > > responsibility to provide the array of page pointers and the TEE
> > > subsystem doesn't need to care about what kind of kernel memory it is
> > > any longer. Yes, that should avoid eventual complexities with
> > > vmalloc() etc.
> >
> > I finally spent some time digging into this again.
> >
> > Overall I'm not opposed to trying to clean up the code more but I feel like the
> > removal of TEE_SHM_USER_MAPPED is too complex for the main goal; to remove a
> > caller of kmap_to_page().
> >
> > Not only is that flag used in release_registered_pages() but it is also used in
> > tee_shm_fop_mmap().  I'm not following exactly why.  I think this is to allow
> > mmap of the tee_shm's allocated by kernel users?
>
> No, its rather to allow mmap of tee_shm allocated via
> tee_shm_alloc_user_buf(). Have a look at its user-space usage here
> [1]. So overall I agree here that we can't get rid of
> TEE_SHM_USER_MAPPED completely as it has a valid mmap use-case.
>
> [1] https://github.com/OP-TEE/optee_client/blob/master/libteec/src/tee_client_api.c#L907
>
> >  Which I _think_ is
> > orthogonal to the callers of tee_shm_register_kernel_buf()?
> >
> > >
> > > >
> > > > At that point TEE_SHM_USER_MAPPED should also go away, because then
> > > > it's the caller that should just do either the user space page
> > > > pinning, or pass in the kernel page pointer.
> > > >
> > > > JensW, is there some reason that wouldn't work?
> > >
> > > We still need to know if it's kernel or user pages in
> > > release_registered_pages().
> >
> > Yes.
> >
> > As I dug into this it seemed ok to define a tee_shm_kernel_free().  Pull out
> > the allocation of the page array from register_shm_helper() such that it could
> > be handled by tee_shm_register_kernel_buf() and this new tee_shm_kernel_free().
> >
>
> +1
>
> > This seems reasonable because the only callers of tee_shm_register_kernel_buf()
> > are in trusted_tee.c and they all call tee_shm_free() on the registered memory
> > prior to returning.
> >
> > Other callers[*] of tee_shm_free() obtained tee_shm from
> > tee_shm_alloc_kernel_buf() which AFAICT avoids all this nonsense.
> >
> > [*] such as .../drivers/firmware/broadcom/tee_bnxt_fw.c.
> >
> > >
> > > The struct tee_shm:s acquired with syscalls from user space are
> > > reference counted. As are the kernel tee_shm:s, but I believe we could
> > > separate them to avoid reference counting tee_shm:s used by kernel
> > > clients if needed. I'll need to look closer at this if we're going to
> > > use that approach.
> > >
> > > Without reference counting the caller of tee_shm_free() can be certain
> > > that the secure world is done with the memory so we could delegate the
> > > kernel pages part of release_registered_pages() to the caller instead.
> > >
> >
> > I'm not sure I follow you here.  Would this be along the lines of creating a
> > tee_shm_free_kernel() to be used in trusted_tee.c for those specific kernel
> > data?
>
> I can't find a reason/use-case for the TEE subsystem to keep a
> refcount of memory registered by other kernel drivers like
> trusted_tee.c. So yes I think it should be safe to directly free that
> shm via tee_shm_free_kernel(). Also with that we can simplify shm
> registration by kernel clients via directly passing page pointers to
> tee_shm_register_kernel_buf() (I would rather rename this API as
> tee_shm_register_kernel_pages()).

Okay, so I will take up this work and get rid of kmap_to_page
invocation from the TEE subsystem.

Ira,

You can then rebase your patchset over my work.

-Sumit

>
> >
> > Overall I feel like submitting this series again with Christoph and Al's
> > comments addressed is the best way forward to get rid of kmap_to_page().  I
> > would really like to get moving on that to avoid any further issues with the
> > kmap conversions.
> >
> > But if folks feel strongly enough about removing that flag I can certainly try
> > to do so.
> >
> > Ira
> >
> > > Cheers,
> > > Jens
> > >
> > > >
> > > >                  Linus
