Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFFD5EA6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiIZNFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiIZNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184391BB6CB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664192133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=El6s5Me40WjqNMPIsI01upfNOG9tCRVFThB/uqNE3Fc=;
        b=UrK9/XS2jlcN09GVveJZTR5qNDu+7Fn4F0fXIuHRDH55xdT6rAuTEd5ujyD5OUBZw9bUeT
        WcgnCOWHR5qLc+roju8GHu75u/0boz6esVO85TUqCHyJjIpm25rKUJAzHqt5ZhDyvyO6t/
        ej9OokJIoDdN+DpZCzGsI/XOhjtWecs=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-ez9VVGlVOiOWWBgYFo8z7g-1; Mon, 26 Sep 2022 07:35:32 -0400
X-MC-Unique: ez9VVGlVOiOWWBgYFo8z7g-1
Received: by mail-vk1-f200.google.com with SMTP id e17-20020a056122023100b003a1e6de5bf9so2240202vko.17
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=El6s5Me40WjqNMPIsI01upfNOG9tCRVFThB/uqNE3Fc=;
        b=xd8IgNXdz4nWi62+2a958AHK2aV3Ja4qGla3uUGGILEtWnGQQKwfBEGdqX5aQqzjzF
         tjfX05r6g6WAGg3EiMy8tK9A1UmGLzimBT6IoYUjlE8wDq+xQ6HRADXWuxfxza+6XXiU
         uYCyJMPTkR1NWJE/E8CuDmgDBX6JzpdK2++CkOMdcP1SDNsZtmz761CGkC1m9ObS0ko0
         Wmuk7n4Y+IQk2i9c2bhzsfo49yfSNxUYj6EGzQTVZ38/a2NlFcSly2X5y3Nw8FfBa+UE
         DRx5HTXhQ4fS4guYCimMKgNtWpCSSv89egg7PjjGcHRNzUFroWHU9+UuF75y724acPOH
         WjnQ==
X-Gm-Message-State: ACrzQf0uxyeC110buzxP6MFpN5VaUmoDzsbIrKiYVMjpvGlnTv6XJeq6
        8QCkxA/jXxsY5ZD9eoJH2ANFwoYpWDXWH0ZtbEbtKknu1tVQYHL9wjzKJPurh3n3eqKQx55x2ac
        NDWJ0i0I6LTxLsJCtc3VEIlayrsUVRJ3NDsHf9WRX
X-Received: by 2002:a67:dc98:0:b0:398:c70f:9357 with SMTP id g24-20020a67dc98000000b00398c70f9357mr7700218vsk.76.1664192131940;
        Mon, 26 Sep 2022 04:35:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7QffRF1yNXJ07+v6HXx6c3EHwuogm4Tj8Rvx8Y1YOfwF0OM48DctOrSJEUHph+UD/b5tVJ6lKINT5kRwE2x6k=
X-Received: by 2002:a67:dc98:0:b0:398:c70f:9357 with SMTP id
 g24-20020a67dc98000000b00398c70f9357mr7700205vsk.76.1664192131763; Mon, 26
 Sep 2022 04:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAH7mPvj64Scp6_Nbaj8KOfkoV5f7_N5L=Tv5Z9zGyn5SS+gsUw@mail.gmail.com>
 <ba821ade-1573-4c35-8fbb-285283817147@app.fastmail.com> <478D9484-E404-4A96-908C-4DE0F7C23997@cutebit.org>
In-Reply-To: <478D9484-E404-4A96-908C-4DE0F7C23997@cutebit.org>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 26 Sep 2022 12:35:15 +0100
Message-ID: <CAOgh=Fx-sjUKBCPSYX+6JEn39Vv6LLkTMBVRCOGOa9AfJ4Trag@mail.gmail.com>
Subject: Re: Any interest in building the Linux kernel from a MacOS host?
To:     =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        asahi@lists.linux.dev,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sept 2022 at 10:21, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>
> FWIW my current workflow includes building the kernel under macOS, so
> there=E2=80=99s some interest from me, but that will pass once the portin=
g
> project progresses enough. So far I get by with some local duct tape.
>
> > On 26. 9. 2022, at 10:09, Sven Peter <sven@svenpeter.dev> wrote:
> >
> > On Mon, Sep 26, 2022, at 09:51, Nick Desaulniers wrote:
>
> (...)
>
> >> If this might seem helpful
> >> to anyone's workflow, I wouldn't mind pursuing this (with some
> >> cleanup, sending a more formal patch set).  Maybe this helps us
> >> bootstrap or get Linux up and running sooner on these machines?
> >
> > I've been either using a Linux VM or just a bare metal system running
> > on these machine for quite a while now to build kernels. This would've
> > been useful when I originally started though and VMs weren't working ve=
ry
> > well yet so maybe it's still worth pursuing.
>
> I really wanted to do it in a VM as a saner path, but I didn't find
> a satisfactory way to share the working source tree between the macOS
> host and Linux guest (which wouldn't slow down the build).

My way of doing this efficiently is to create throwaway commits, in
git, just to push code around to various physical or virtual machines
in my house. Because git is really fast at pushing incremental changes
around:

https://github.com/ericcurtin/staging/blob/master/git-push.sh

But if you eventually find a way to share a filesystem (which wouldn't
slow down the build) between MacOS and a Linux host via qemu or
something like that I'd be interested, that's most ideal of course.

>
> Martin
>
> >>
> >> Take a look at the commit message linked below for the trials &
> >> tribulations:
> >> https://github.com/ClangBuiltLinux/linux/commit/f06333e29addbc3d714adb=
340355f471c1dfe95a
> >>
> >> Thanks,
> >> ~Nick Desaulniers
> >
> >
> > Best,
> >
> >
> > Sven
> >
>
>

