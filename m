Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B0B6E789E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjDSL2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjDSL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:28:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6861BEB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:28:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kt6so42584721ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1681903685; x=1684495685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N99yfKqkNg/PzVluqPrnuo7/UXaVkUZ4pARZeRWAW0=;
        b=h+3Tomy+fZrVXH6RN/babMfjC3kI4c/tjjs+upF4u2X/jkiM2Y88CL0+Ndyv402wRA
         ZN8jK2RJQPiW1OrNQGOz0lJxhdDo0VxjNTL6Wi/rxTAXStbwCZ3oB5IF1CRRLFVGQxbQ
         T9gYcbmXuvxaBPI1B259kNHR7vtJA9q3ZKhrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681903685; x=1684495685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8N99yfKqkNg/PzVluqPrnuo7/UXaVkUZ4pARZeRWAW0=;
        b=JW5cE/M3VDWtkzND9u3H/qlNhAv1LbJQtlJj8tyLjyZ6zyBzocDgwSCh4gXJWjYPpV
         B4n9W0zxoIMd+SbpfmGkxu/8f2Faj1SrDYXX05MaEyHy13faDdqdiJPu/udA3klchlOt
         KVzHwASeS2Ir+xW8WbIqvoo9SBfwshDmsvRCGNfj3Vrxp+AYZAFHdWZ0Rd/E3K9qkatT
         2gCiT2M53k4vlJbv8waHjMRBqoK12dpYciTdWt1TEmGYDjO8jSShRe3IIfUJRj2wQM1n
         JhQpWWa8CKRLiw/SMkctR2lPV00FtR4rNh5cg0Wmo36F+1BSla4PropfQNoiP5b/kCFp
         zvtw==
X-Gm-Message-State: AAQBX9cA0sYCnssg446RaHmBZOJTayUttutJnTXfEGSW46UIi3V0i6jA
        48xA/kJ+qKOKuO7OSPiscNK9vVUsVeWpvJgPJJYDg1NS
X-Google-Smtp-Source: AKy350aQ5StuyEixP2l7GGBxb3AboE+J4Ftijrlq9zv9aNRAG8FnhKrlr3FKjOncD904Nbz/unbK2Q==
X-Received: by 2002:a17:907:8c05:b0:953:1a7a:fbd4 with SMTP id ta5-20020a1709078c0500b009531a7afbd4mr5482066ejc.24.1681903684872;
        Wed, 19 Apr 2023 04:28:04 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id sa39-20020a1709076d2700b0094f410225c7sm5304789ejc.169.2023.04.19.04.28.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:28:04 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94a35b0d130so735169466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:28:04 -0700 (PDT)
X-Received: by 2002:a2e:7012:0:b0:2a5:fe8f:b314 with SMTP id
 l18-20020a2e7012000000b002a5fe8fb314mr1874851ljc.5.1681903663880; Wed, 19 Apr
 2023 04:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230325060828.2662773-1-rppt@kernel.org> <20230325060828.2662773-3-rppt@kernel.org>
 <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
 <ZCvQGJzdED+An8an@kernel.org> <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
 <ZDbp7LAHES3YFo30@arm.com> <20230418150557.ea8c87c96ec64c899c88ab08@linux-foundation.org>
 <ZD/K+Mof/Dx5yzjQ@arm.com>
In-Reply-To: <ZD/K+Mof/Dx5yzjQ@arm.com>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Wed, 19 Apr 2023 06:27:31 -0500
X-Gmail-Original-Message-ID: <CAFbkSA3yn_4Monrnk2u3CzfJ934Hy15rjAJ85AdFU40nV7KTkQ@mail.gmail.com>
Message-ID: <CAFbkSA3yn_4Monrnk2u3CzfJ934Hy15rjAJ85AdFU40nV7KTkQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
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

On Wed, Apr 19, 2023 at 6:12=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Tue, Apr 18, 2023 at 03:05:57PM -0700, Andrew Morton wrote:
> > On Wed, 12 Apr 2023 18:27:08 +0100 Catalin Marinas <catalin.marinas@arm=
.com> wrote:
> > > > It sounds nice in theory. In practice. EXPERT hides too much. When =
you
> > > > flip expert, you expose over a 175ish new config options which are
> > > > hidden behind EXPERT.  You don't have to know what you are doing ju=
st
> > > > with the MAX_ORDER, but a whole bunch more as well.  If everyone we=
re
> > > > already running 10, this might be less of a problem. At least Fedor=
a
> > > > and RHEL are running 13 for 4K pages on aarch64. This was not some
> > > > accidental choice, we had to carry a patch to even allow it for a
> > > > while.  If this does go in as is, we will likely just carry a patch=
 to
> > > > remove the "if EXPERT", but that is a bit of a disservice to users =
who
> > > > might be trying to debug something else upstream, bisecting upstrea=
m
> > > > kernels or testing a patch.  In those cases, people tend to use
> > > > pristine upstream sources without distro patches to verify, and the=
y
> > > > tend to use their existing configs. With this change, their MAX_ORD=
ER
> > > > will drop to 10 from 13 silently.   That can look like a different
> > > > issue enough to ruin a bisect or have them give bad feedback on a
> > > > patch because it introduces a "regression" which is not a regressio=
n
> > > > at all, but a config change they couldn't see.
> > >
> > > If we remove EXPERT (as prior to this patch), I'd rather keep the ran=
ges
> > > and avoid having to explain to people why some random MAX_ORDER doesn=
't
> > > build (keeping the range would also make sense for randconfig, not su=
re
> > > we got to any conclusion there).
> >
> > Well this doesn't seem to have got anywhere.  I think I'll send the
> > patchset into Linus for the next merge window as-is.  Please let's take
> > a look at this Kconfig presentation issue during the following -rc
> > cycle.
>
> That's fine by me. I have a slight preference to drop EXPERT and keep
> the ranges in, especially if it affects current distro kernels. Debian
> seems to enable EXPERT already in their arm64 kernel config but I'm not
> sure about the Fedora or other distro kernels. If they don't, we can
> fix/revert this Kconfig entry once the merging window is closed.

Fedora and RHEL do not enable EXPERT already.

Justin
