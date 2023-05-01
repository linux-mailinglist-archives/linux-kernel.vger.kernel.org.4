Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97C6F39B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjEAVZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEAVY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:24:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA0173C
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 14:24:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so4004489e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1682976293; x=1685568293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRNEo4fec1ydGjEoS5W2dSAkWJWfTSd2Rg/x8kCWeCw=;
        b=OUSQA6fIHtatxzhqErSD6fXBZlTtHhxhdlTeRsqoyKQ/fWA7GNPWhb4hF1Xvl8GDQ+
         OWWuax8mKfFIJpT3qLumqurqPkro8IZTcUxeJ2tVlQxrWgjoHyMmyIeCy89Ga30Sq0QP
         unNihkCb7ABu/13lUGYuTQJC860A906K5o7Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682976293; x=1685568293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRNEo4fec1ydGjEoS5W2dSAkWJWfTSd2Rg/x8kCWeCw=;
        b=Aj/0SeYrRf93t3HAvYRCeghnJV/GcvGFcVil0536V2wyBnxZUp2rgYUN6EMisd/gzy
         uv7oo1cqbSBZtSHrW5W61KJvTTeGjDIAm+LaNZ9xv6PLTKXfCJq8+9DfWJTFmsGsvMoW
         KGMn9NIQNX4tnxZYcz/BKf/88p3ERtqnEhCpPzpMJ5DENNm2zTv+n+wJvhZvfhtzkO7Z
         b706QgPAgRlTPa1jndLjow82mMhIDjWBtIzBjHZJBxnxHjYNxCEuFbhZKEI0Obpl7HVE
         il6UfTos/zHRD+Q8tVoBtEvHoi/QQNb4IFF9slw7tNxy39V/NVDmCGH1U2Br6Tj/lyzM
         N96g==
X-Gm-Message-State: AC+VfDxteFlQEtCd6N0AHstU/RrmeEvYOeoyUqjFfFWMEoG2Met4pQM/
        oNsOC9FSvKDQA1JT9cYRbcy47YLqM8iGt/018llzbmlv
X-Google-Smtp-Source: ACHHUZ5R/yyDkv6iPPpEDxfhfwq8w4UNgzrzC/VIxAo1OFd5kP29N9ir7+FUNewDYxMNsbznnxAZ1w==
X-Received: by 2002:ac2:4904:0:b0:4f0:da5:773f with SMTP id n4-20020ac24904000000b004f00da5773fmr4108367lfi.25.1682976293335;
        Mon, 01 May 2023 14:24:53 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id o26-20020ac2495a000000b004eff4ea8dd3sm3461256lfi.76.2023.05.01.14.24.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 14:24:51 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4efe8991bafso4035979e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 14:24:50 -0700 (PDT)
X-Received: by 2002:ac2:59ca:0:b0:4ec:89d3:a8a2 with SMTP id
 x10-20020ac259ca000000b004ec89d3a8a2mr4087163lfn.43.1682976290352; Mon, 01
 May 2023 14:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230428153646.823736-1-jforbes@fedoraproject.org>
 <ZEv76qfIiJcUvdql@arm.com> <ZE1pcwi95nPdlKzN@kernel.org> <CAFbkSA3SzjWZ_Q8XC6-_Kzc+jmUN6sG7vzbSD5X1bRvPUaJg3Q@mail.gmail.com>
 <ZE3mdYajdFnvl1by@kernel.org>
In-Reply-To: <ZE3mdYajdFnvl1by@kernel.org>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Mon, 1 May 2023 16:24:38 -0500
X-Gmail-Original-Message-ID: <CAFbkSA0O-4YgNt-7KPhvx+vhvRNc38PO8E--GVAWKVgHK-_9Mw@mail.gmail.com>
Message-ID: <CAFbkSA0O-4YgNt-7KPhvx+vhvRNc38PO8E--GVAWKVgHK-_9Mw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 11:02=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Sat, Apr 29, 2023 at 05:42:11PM -0500, Justin Forbes wrote:
> > On Sat, Apr 29, 2023 at 2:01=E2=80=AFPM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Fri, Apr 28, 2023 at 06:01:30PM +0100, Catalin Marinas wrote:
> > > > + Mike and Andrew
> > > >
> > > > On Fri, Apr 28, 2023 at 10:36:45AM -0500, Justin M. Forbes wrote:
> > > > > While the ARCH_FORCE_MAX_ORDER changes clarified the descriptions=
 quite
> > > > > a bit, the aarch64 specific change moved this config to sit behin=
d
> > > > > CONFIG_EXPERT. This becomes problematic when distros are setting =
this to
> > > > > a non default value already. Pushing it behind EXPERT where it wa=
s not
> > > > > before will silently change the configuration for users building =
with
> > > > > oldconfig.  If distros patch out if EXPERT downstream, it still c=
reates
> > > > > problems for users testing out upstream patches, or trying to bis=
ect to
> > > > > find the root of problem, as the configuration will change unexpe=
ctedly,
> > > > > possibly leading to different behavior and false results.
> > > > >
> > > > > Whem I asked about reverting the EXPERT, dependency, I was asked =
to add
> > >
> > > Nit: When
> > >
> > > > > the ranges back.
> > > > >
> > > > > This essentially reverts commit 34affcd7577a232803f729d1870ba475f=
294e4ea
> > > > >
> > > > > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > ---
> > > > >  arch/arm64/Kconfig | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > index b1201d25a8a4..dae18ac01e94 100644
> > > > > --- a/arch/arm64/Kconfig
> > > > > +++ b/arch/arm64/Kconfig
> > > > > @@ -1516,9 +1516,11 @@ config XEN
> > > > >  # 16K |       27          |      14      |       13        |    =
     11         |
> > > > >  # 64K |       29          |      16      |       13        |    =
     13         |
> > > > >  config ARCH_FORCE_MAX_ORDER
> > > > > -   int "Order of maximal physically contiguous allocations" if E=
XPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
> > > > > +   int "Order of maximal physically contiguous allocations" if A=
RM64_4K_PAGES || ARM64_16K_PAGES
> > > > >     default "13" if ARM64_64K_PAGES
> > > > > +   range 11 13 if ARM64_16K_PAGES
> > > > >     default "11" if ARM64_16K_PAGES
> > > > > +   range 10 15 if ARM64_4K_PAGES
> > > > >     default "10"
> > > > >     help
> > > > >       The kernel page allocator limits the size of maximal physic=
ally
> > > >
> > > > The revert looks fine to me:
> > > >
> > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > >
> > > > For the record, the original discussion:
> > > >
> > > > Link: https://lore.kernel.org/r/CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3q=
cUnhnCn-WrAurvgA@mail.gmail.com
> > >
> > > I'm not really happy about this revert because MAX_ORDER is not somet=
hing
> > > that should be changed easily.
> > > But since hiding it behind EXPERT would silently change lots of exist=
ing
> > > builds, I won't object.
> > >
> > > Still, I never got the answer _why_ Fedora/RHEL configs use non-defau=
lt
> > > value. Quite possible something else needs to be fixed rather than ha=
ving
> > > overgrown MAX_ORDER.
> >
> > I get that, but I also looked at the rest of the patch set. Nowhere
> > else was "if EXPERT" added.  Why wasn't it added to other
> > architectures? Not that I am complaining, but aarch64 in particular is
> > the one arch where, as a distro, we are trying to accommodate both
> > Raspberry Pi, and server class machines.
>
> The patch was about dropping the ranges, not about adding EXPERT. So on
> arm64 it was added because Catalin requested it, other arch maintainers
> didn't.
>
> > It is the practicality of building a single kernel image that works
> > along a large number of machines. The defaults are fine for smaller
> > boards, and honestly the majority of aarch64 hardware in circulation.
> > They are not acceptable for server class machines running those types
> > of workloads.
>
> Why the default MAX_ORDER was not acceptable on arm64 server machines but
> it is fine on, say, x86 and s390?
> I'm not asking how you made it possible in Fedora and RHEL, I'm asking wh=
y
> did you switch from the default order at all.

Because the MAX_ORDER on aarch64 with 4K pages is more tuned to the
needs of the average edge client, not so much those of a server class
machine.  And I get it, I would say well over 90% of the Fedora users
running aarch64 are indeed running on a rPi or similar with a small
memory footprint, and workloads which match that.  But we do support
and run a 4K page size aarch64 kernel on proper server class hardware,
running typical server workloads, and RHEL has a lot more users in the
server class than edge clients.   RHEL could probably default to 64K
pages, and most users would be happy with that. Fedora certainly could
not.  At some point, we may consider adding another build so that we
offer both 4K and 64K pages, but for now, this is where we are, and
where we have been for years.

Justin

> > Justin
> >
> > > --
> > > Sincerely yours,
> > > Mike.
> > >
>
> --
> Sincerely yours,
> Mike.
>
