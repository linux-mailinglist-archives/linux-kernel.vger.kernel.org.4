Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE0869819F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBORIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBORIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:08:18 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD21724C98;
        Wed, 15 Feb 2023 09:08:17 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id n132so16356886oih.7;
        Wed, 15 Feb 2023 09:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8zyelginURipRbxdGHjbh7QH9QsCpgBY23a1oeTuFM=;
        b=hBVLBXWmcy6Vhm7U7T1Mt9zTvtTLPeP3D+4dKa4+lo3MhwuUJPFLiShr4SFqP7jzEL
         Bg1YrZ2PlC1iE629VxyFtvpQhh0B10oLe3ahwbBJpFVu3Q07IE9SRQ2o94ObTZnGrG5o
         /ArYjVLp0zrB33CSlqlnVI1hGIsKPj7Q4/8JPNeKHFEZwNdsDmqyPI9x5K+CCu3pDc7g
         feUUD/qrE2r5pozl/v5CpI+CYf/C3JgvSpi22yKNoh0Kxr5pc9/5eYHRaYO93W1ThN7J
         FYacqaZLBeIiacF6wfxB8+qSb6WuRO/kfBBr1dugmOYZg8c+GlNlMHcLnJtJufi2fhjK
         iJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8zyelginURipRbxdGHjbh7QH9QsCpgBY23a1oeTuFM=;
        b=wtfXsFHUXmGVY6ttfYFwxaYbjEZ7VfsQjgfqdfGc/SdhMn4kKpi+GOVZ6DG41kA0i7
         GEeAbylQ7QsJC+ooWOFYcEkerNzW5f2gPYHUlaqL2tHSNtNMZygDT/0QeNC1WVhiZLAh
         5euI6Q4FRfezrgeh3CtRB8vHK0yqsnmsl5Dz1bO7j3gJ72M0FZdjwvAsmbTs5m0F5Onk
         PffT5TN9eJJe/4dBQxolfw0CI3+Fdc6VEv+zIBBRWryWT/ZGeqKqm15iB2P7QfUxrASi
         p6p6SZcVFW93WxR8zqCqcNPMYK0DS2hUN/4f2LT7wiureMva+dZWJRwySIwIQXxhE0mE
         0ErQ==
X-Gm-Message-State: AO0yUKWhpyevC1t2FFK0kuM+uoF7Hns4+W0SzHqKVjT3zlPyzZ1R+ZCQ
        tVC4dy4LN7BXsJ1NEZI1d6Y=
X-Google-Smtp-Source: AK7set+vbwjn0W6ad8Z4+abxeNLlYtZT6+RzqRgEN3aEv6nLpfNL+sB/FdxIPUv997x/YsU0A1c8ww==
X-Received: by 2002:a05:6808:8fa:b0:378:528:d83b with SMTP id d26-20020a05680808fa00b003780528d83bmr1122806oic.55.1676480897167;
        Wed, 15 Feb 2023 09:08:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q185-20020acac0c2000000b0035a9003b8edsm7406252oif.40.2023.02.15.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:08:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Feb 2023 09:08:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH] MAINTAINERS: Mark Itanium/IA64 as 'dead'
Message-ID: <20230215170815.GA3787950@roeck-us.net>
References: <20230128122904.1345120-1-ardb@kernel.org>
 <20230215151547.GA3766362@roeck-us.net>
 <CAMj1kXEnoghSNpQFucmSCEhG3s_nyBCm+btgLHzOTiU56=XPfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEnoghSNpQFucmSCEhG3s_nyBCm+btgLHzOTiU56=XPfQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 04:40:30PM +0100, Ard Biesheuvel wrote:
> On Wed, 15 Feb 2023 at 16:15, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Sat, Jan 28, 2023 at 01:29:04PM +0100, Ard Biesheuvel wrote:
> > > Create a new status 'dead' which conveys that a subsystem is
> > > unmaintained and scheduled for removal, and developers are free to
> > > behave as if it's already gone. Also, automated build tests should
> > > ignore such subsystems, or at least notify only those who are known to
> > > have an interest in the subsystem in particular.
> > >
> > > Given that Itanium/IA64 has no maintainer, is no longer supported in
> > > QEMU (for boot testing under emulation) and does not seem to have a user
> > > base beyond a couple of machines used by distros to churn out packages,
> > > let's mark it as dead. This shall mean that any treewide changes (such
> > > as changes to the EFI subsystem, which I maintain) can be made even if
> > > they might cause build or boot time regressions on IA64 machines. Also,
> > > mark the port as scheduled for removal after the next LTS release.
> > >
> >
> > Since this just came up, I very much prefer complete removal. I don't
> > see the point of keeping dead code in the tree. That is still hidden
> > maintenance effort.
> >
> 
> Can I take this as an ack on
> 
> https://lore.kernel.org/linux-kernel/20230215100008.2565237-1-ardb@kernel.org/
>

I would not have considered myself important enough to make such a call,
but from a testbed maintainer's perspective it is an enthusiastic yes.

At the same time, again from a testbed maintainer's perspective,
introducing a new "dead" state into the code base deserves a just as
enthusiastic NACK.

Thanks,
Guenter


> ?
> 
> > If this proliferates, we'll end up having to parse the MAINTAINERS file
> > for code marked "Dead" to ensure that we don't accidentally send e-mails
> > to the wrong people, or we risk getting complaints about sending reports
> > for such code. That puts extra burden on maintainers of automated test
> > beds, which I think is not really appropriate. If the code is dead,
> > remove it, period.
> >
> > For my part, I'll drop my test bed support immediately after this patch
> > made it in, following the guidance above.
> >
> 
> Thanks for the insight. I think we should take the immediate removal route.
