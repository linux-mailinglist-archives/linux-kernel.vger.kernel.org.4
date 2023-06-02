Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B517207F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjFBQz3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 12:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjFBQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:55:27 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9E4196;
        Fri,  2 Jun 2023 09:55:25 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-974604c1394so23398066b.0;
        Fri, 02 Jun 2023 09:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685724924; x=1688316924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt9VNTeJlFVEV3sIod8cHGTAKd0dmJxzfE9EV8gLQWE=;
        b=HodPOyJNhYxQ60vwtp4RyfBXr7UskTIgCAEk2wJ/1jYVuesor3MJal4KF6yB1W1FKZ
         1XSWy5JpREK+undDIkqOfukU154VpavJIkbBV829y5FraqDksaIG/N0h2VaBvRPJkA/l
         wd4Z0vPSEtP14aV3zkJK3IHFRHT/DGM09zo1v1JgH0aA9uuygUBJ34e+Oeap8yNX6DG8
         X5/DemQxNHz2zm6bxH9tfTUTv0CR7Xm1Mxebeh89qQ0YJypkmkMroWBHIQ73hTSXtcCG
         b8dy/eiAMn1TB3hQAFlGTCWHDAeivrJSJ/TOsgiHdSLjAfCHHAMQgXgbS9qww8Y4SGmL
         Hf6w==
X-Gm-Message-State: AC+VfDzuSNA53YZ6xGqDvdGgYHjY6wzWRCkyGiMGw9CGUD0FXAI/xnHx
        UKY30P7Imf8ufjgIU6co7yHXbSD/CfxqDijaFInIxyqfTLE=
X-Google-Smtp-Source: ACHHUZ6Py3U/a0yFJ9hJFd0xhfSWBcfOZ1zZOLFsSPZRu42PNsWRoF6JOHnKOtYWEcuxqvrGUZPUIF6mO/lz3yYt3mg=
X-Received: by 2002:a17:906:145:b0:94a:5f0d:d9d6 with SMTP id
 5-20020a170906014500b0094a5f0dd9d6mr10572995ejh.4.1685724924056; Fri, 02 Jun
 2023 09:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213246.3271412-1-arnd@kernel.org> <ee67348af01d729a959563f5cb2ecab7534f2e53.camel@intel.com>
 <0d627109-483d-42c2-86c7-337c2d38fadb@app.fastmail.com>
In-Reply-To: <0d627109-483d-42c2-86c7-337c2d38fadb@app.fastmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Jun 2023 18:55:12 +0200
Message-ID: <CAJZ5v0iP+cmcoigiGwv58Hf8_3iM-+_5KZbAqiZyjqZxfBQR6A@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: fix CONFIG_IOSF_MBI dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zhang Rui <rui.zhang@intel.com>, Arnd Bergmann <arnd@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 11:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jun 2, 2023, at 10:04, Zhang, Rui wrote:
> > On Thu, 2023-06-01 at 23:32 +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> When the intel_rapl driver is built-in, but iosf_mbi is a loadable
> >> module,
> >> the kernel fails to link:
> >>
> >> x86_64-linux-ld: vmlinux.o: in function `set_floor_freq_atom':
> >> intel_rapl_common.c:(.text+0x2dac9b8): undefined reference to
> >> `iosf_mbi_write'
> >> x86_64-linux-ld: intel_rapl_common.c:(.text+0x2daca66): undefined
> >> reference to `iosf_mbi_read'
> >>
> >
> > IMO, it is the intel_rapl_common.c that calls IOSF APIs without
> > specifying the dependency. Thus it should be fixed by something like
> > below,
> >
> > --- a/drivers/powercap/Kconfig
> > +++ b/drivers/powercap/Kconfig
> > @@ -18,10 +18,11 @@ if POWERCAP
> >  # Client driver configurations go here.
> >  config INTEL_RAPL_CORE
> >       tristate
> > +     select IOSF_MBI
> >
> >  config INTEL_RAPL
> >       tristate "Intel RAPL Support via MSR Interface"
> > -     depends on X86 && IOSF_MBI
> > +     depends on X86
> >       select INTEL_RAPL_CORE
> >       help
> >         This enables support for the Intel Running Average Power Limit
>
> I think that has the logic slightly backwards from a usability point
> of view: The way I read the arch/x86/Kconfig description, IOSF_MBI
> is a feature of specific Intel hardware implementations, which
> gets enabled when any of these SoC platforms are enabled in
> the build, and the INTEL_RAPL driver specifically only works
> on those, while the new INTEL_RAPL_TPMI driver works on other
> hardware.
>
> More generally speaking, I think it is a mistake for a device
> driver in one subsystem to use 'select' to enforce a build
> dependency on a driver in another subsystem when the other
> symbol is user-visible.

IOSF_MBI is already selected from multiple places and while you can
argue that they are all mistakes, this particular new one would not be
worse than any of them.

IMO it would be better if IOSF_MBI were not user-visible (and
interestingly enough, whoever selects it should also select PCI or
depend on it - I'm not really sure if that dependency is taken care of
in all cases).
