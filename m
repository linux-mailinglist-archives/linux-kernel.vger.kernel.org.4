Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA296F2707
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjD2Wmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 18:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2Wma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:42:30 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B1BE7D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:42:27 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8aea2a654so10846301fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1682808145; x=1685400145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KXs6cntaUyBV90kwxt8lOyhcQo34Lm9tKDQionJD1g=;
        b=amUpt+1IzkB5DM8ksAHaf2LkvCbBmGFI03doUgMvU84YtmXEwuTp+7rmsc0hW5sFG3
         aMzpDX0OQQvOwGQIcofHzeHagxJay8RDMPvGFg8mr1euCsyB4+nJeDpIl5iWlvAM52Ov
         m4Z+S3emclyijhwxuJys51GUXIPIm2UuOjS54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682808145; x=1685400145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3KXs6cntaUyBV90kwxt8lOyhcQo34Lm9tKDQionJD1g=;
        b=IEOPaegqVQPhq3h04oKzeWG6jvblkNwCzKvVe6akQG2A7qUgSOvfmuY0mIOu9N4BPC
         hcSe/2HNi5iz1C/LDpO4MTWw9xT8DLEqF/X6YsQbgwbwWUvMIWrZhNgOsOyyE+U4doJz
         kCaFbAzBzBnWB3UXAgPMs7kBBMIWovA8F97beMYvPWjTytXrdWlo8omMlRyYpGF5wTIo
         t+Mu1lAWR5N/cfarj2UxUc8Xi/0EWyAXQd22A7+zBAzfB8tBfrk9Bgppd1hl8/uBOb2p
         M7BxwHMYiJkjwCDg6HU8cFdRj2iYJHCcuwYLOOCZ1U6BshLyHCcxxnIv/ZItNehTChs9
         7/tw==
X-Gm-Message-State: AC+VfDyfaTIYoOfGktIY6FM4v7wWvzuNOQ+30iZHbz1oUucfquJmqsLz
        cgc7g0lRsUjk3I3EyjVO/TwHOkxhsnKmAtEcIKxiag==
X-Google-Smtp-Source: ACHHUZ7web5uPJnAduuCKjLyWEfErQgtZEmOHK+uaUP6rspgzCxQel7HtuhZ2t5ymKHg5F37iht1LA==
X-Received: by 2002:a2e:9dcb:0:b0:295:9be0:212b with SMTP id x11-20020a2e9dcb000000b002959be0212bmr2968698ljj.8.1682808144794;
        Sat, 29 Apr 2023 15:42:24 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x23-20020a2e7c17000000b002a5f554d263sm3899036ljc.46.2023.04.29.15.42.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 15:42:23 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4efef769000so1519842e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:42:23 -0700 (PDT)
X-Received: by 2002:ac2:489c:0:b0:4e8:3d24:de6f with SMTP id
 x28-20020ac2489c000000b004e83d24de6fmr2613234lfc.14.1682808143304; Sat, 29
 Apr 2023 15:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230428153646.823736-1-jforbes@fedoraproject.org>
 <ZEv76qfIiJcUvdql@arm.com> <ZE1pcwi95nPdlKzN@kernel.org>
In-Reply-To: <ZE1pcwi95nPdlKzN@kernel.org>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Sat, 29 Apr 2023 17:42:11 -0500
X-Gmail-Original-Message-ID: <CAFbkSA3SzjWZ_Q8XC6-_Kzc+jmUN6sG7vzbSD5X1bRvPUaJg3Q@mail.gmail.com>
Message-ID: <CAFbkSA3SzjWZ_Q8XC6-_Kzc+jmUN6sG7vzbSD5X1bRvPUaJg3Q@mail.gmail.com>
Subject: Re: [PATCH] Revert arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 2:01=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Apr 28, 2023 at 06:01:30PM +0100, Catalin Marinas wrote:
> > + Mike and Andrew
> >
> > On Fri, Apr 28, 2023 at 10:36:45AM -0500, Justin M. Forbes wrote:
> > > While the ARCH_FORCE_MAX_ORDER changes clarified the descriptions qui=
te
> > > a bit, the aarch64 specific change moved this config to sit behind
> > > CONFIG_EXPERT. This becomes problematic when distros are setting this=
 to
> > > a non default value already. Pushing it behind EXPERT where it was no=
t
> > > before will silently change the configuration for users building with
> > > oldconfig.  If distros patch out if EXPERT downstream, it still creat=
es
> > > problems for users testing out upstream patches, or trying to bisect =
to
> > > find the root of problem, as the configuration will change unexpected=
ly,
> > > possibly leading to different behavior and false results.
> > >
> > > Whem I asked about reverting the EXPERT, dependency, I was asked to a=
dd
>
> Nit: When
>
> > > the ranges back.
> > >
> > > This essentially reverts commit 34affcd7577a232803f729d1870ba475f294e=
4ea
> > >
> > > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > ---
> > >  arch/arm64/Kconfig | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index b1201d25a8a4..dae18ac01e94 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -1516,9 +1516,11 @@ config XEN
> > >  # 16K |       27          |      14      |       13        |        =
 11         |
> > >  # 64K |       29          |      16      |       13        |        =
 13         |
> > >  config ARCH_FORCE_MAX_ORDER
> > > -   int "Order of maximal physically contiguous allocations" if EXPER=
T && (ARM64_4K_PAGES || ARM64_16K_PAGES)
> > > +   int "Order of maximal physically contiguous allocations" if ARM64=
_4K_PAGES || ARM64_16K_PAGES
> > >     default "13" if ARM64_64K_PAGES
> > > +   range 11 13 if ARM64_16K_PAGES
> > >     default "11" if ARM64_16K_PAGES
> > > +   range 10 15 if ARM64_4K_PAGES
> > >     default "10"
> > >     help
> > >       The kernel page allocator limits the size of maximal physically
> >
> > The revert looks fine to me:
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > For the record, the original discussion:
> >
> > Link: https://lore.kernel.org/r/CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnh=
nCn-WrAurvgA@mail.gmail.com
>
> I'm not really happy about this revert because MAX_ORDER is not something
> that should be changed easily.
> But since hiding it behind EXPERT would silently change lots of existing
> builds, I won't object.
>
> Still, I never got the answer _why_ Fedora/RHEL configs use non-default
> value. Quite possible something else needs to be fixed rather than having
> overgrown MAX_ORDER.

I get that, but I also looked at the rest of the patch set. Nowhere
else was "if EXPERT" added.  Why wasn't it added to other
architectures? Not that I am complaining, but aarch64 in particular is
the one arch where, as a distro, we are trying to accommodate both
Raspberry Pi, and server class machines.
It is the practicality of building a single kernel image that works
along a large number of machines. The defaults are fine for smaller
boards, and honestly the majority of aarch64 hardware in circulation.
They are not acceptable for server class machines running those types
of workloads. For a long time, it was just Fedora running with 4K
pages, and carrying a patch to allow  MAX_ORDER to hit 13.  With RHEL
9, the 4K page size became the default there as well, and they did the
same. Eventually using a MAX_ORDER of 13 no longer required a patch of
any kind. In an ideal world, we would be building a 4k kernel, a 64k
kernel, and even a 16k kernel for users running Apple hardware, but
logistically that is a whole lot more than just a kernel rebuild. It
has QA cycles and support requirements that go along with it, etc.

Justin

> --
> Sincerely yours,
> Mike.
>
