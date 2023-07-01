Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304A0744A6F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 18:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGAQJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 12:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGAQJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:09:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8845270E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 09:09:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso48312e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688227738; x=1690819738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ng1EwQD5y0cvCYQ4WXImHX40YGNrjiR/qucwDkIAqw0=;
        b=VO8EhLHDwQ5jp0Tvre/Uo4THVMrjETEFn74e6K5XQw5SQbRTvfBGOZQQr0q+wH8pFx
         Z6b3qk9TZfRut3fA9aV2SS9+5h3R6VKtG00mMDOSvJg/6ApeW7KmVqP2LLDNSEXzK++4
         9xabhD8x97u/RlDc+uM9QjSEzYHZ0Q26K54zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688227738; x=1690819738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ng1EwQD5y0cvCYQ4WXImHX40YGNrjiR/qucwDkIAqw0=;
        b=OUnz7Q4/m+6LEHXNZ0MzgjC6gCglbelSiYeGajd8V49BZLJgon8Gvd3IvrVczvHYAX
         6TJPSyyrU5wU39ZnB2bgRRysyMaMqUBjdKKq3RQdfk3E8ISdm3gYq5PUQyzR7kHbXWN7
         aD8WNhucgb2CLzrJs+D0+pFGKnFXCAj0XzyrdfxsaO9xYOu3VknEzuQaWNuPMDJE+QMb
         9AXs6vTXBafZ3s5ydBHXoxw8jwu01DsLlPCY9F3wDeZpimVrUbYeITmzFX9fRUBc8PfE
         qFcaqHMc4/jMyQxNkc7PZHxuAobWEii1cqTVj+h/s81bCqs2VgmCcyIPp7k9+JTuQjtD
         dSBA==
X-Gm-Message-State: ABy/qLZ5DsRCmVAp/G98TFGwcXefXqdngv/z32dixGiwDD7KHxviW67j
        AQBEFFUS0WpnbaEqnt79IOL/vJ6nLYyFoxXqZoWM2F0+
X-Google-Smtp-Source: APBJJlHafQUTx/6TgoeUW498d2zfto0c92Tp+wf1lL3yCwY7x0lpfhUTQ1gc/sVwdasKQJ/WZMR5rA==
X-Received: by 2002:a05:6512:208d:b0:4fb:7447:e724 with SMTP id t13-20020a056512208d00b004fb7447e724mr3913743lfr.8.1688227737738;
        Sat, 01 Jul 2023 09:08:57 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 22-20020ac24856000000b004fb79feb289sm2560611lfy.227.2023.07.01.09.08.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 09:08:56 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fb0336ed4fso1420e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 09:08:56 -0700 (PDT)
X-Received: by 2002:a19:ee17:0:b0:4f2:7840:e534 with SMTP id
 g23-20020a19ee17000000b004f27840e534mr36733lfb.0.1688227736365; Sat, 01 Jul
 2023 09:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230616150618.6073-1-pmladek@suse.com> <20230616150618.6073-7-pmladek@suse.com>
 <7cfc15f1-d8d0-4418-b7a1-5aa9e90e3fb3@roeck-us.net>
In-Reply-To: <7cfc15f1-d8d0-4418-b7a1-5aa9e90e3fb3@roeck-us.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 1 Jul 2023 09:08:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UsgweS0pTpr=6xE-+Dx0fqXgjN=3Gf-4MQcNAzjL+64w@mail.gmail.com>
Message-ID: <CAD=FV=UsgweS0pTpr=6xE-+Dx0fqXgjN=3Gf-4MQcNAzjL+64w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 1, 2023 at 7:40=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On Fri, Jun 16, 2023 at 05:06:18PM +0200, Petr Mladek wrote:
> > The HAVE_ prefix means that the code could be enabled. Add another
> > variable for HAVE_HARDLOCKUP_DETECTOR_ARCH without this prefix.
> > It will be set when it should be built. It will make it compatible
> > with the other hardlockup detectors.
> >
> > The change allows to clean up dependencies of PPC_WATCHDOG
> > and HAVE_HARDLOCKUP_DETECTOR_PERF definitions for powerpc.
> >
> > As a result HAVE_HARDLOCKUP_DETECTOR_PERF has the same dependencies
> > on arm, x86, powerpc architectures.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> ...
> > --- a/include/linux/nmi.h
> > +++ b/include/linux/nmi.h
> > @@ -9,7 +9,7 @@
> >  #include <asm/irq.h>
> >
> >  /* Arch specific watchdogs might need to share extra watchdog-related =
APIs. */
> > -#if defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HA=
RDLOCKUP_DETECTOR_SPARC64)
> > +#if defined(CONFIG_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOC=
KUP_DETECTOR_SPARC64)
>
> This results in:
>
> arch/powerpc/platforms/pseries/mobility.c: In function 'pseries_migrate_p=
artition':
> arch/powerpc/platforms/pseries/mobility.c:753:17: error: implicit declara=
tion of function 'watchdog_hardlockup_set_timeout_pct'; did you mean 'watch=
dog_hardlockup_stop'? [-Werror=3Dimplicit-function-declaration]
>   753 |                 watchdog_hardlockup_set_timeout_pct(factor);
>
> with ppc64_defconfig -CONFIG_HARDLOCKUP_DETECTOR, because the dummy
> for watchdog_hardlockup_set_timeout_pct() is still defined in
> arch/powerpc/include/asm/nmi.h which is no longer included.

Can you test with:

https://lore.kernel.org/r/20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a=
9e1a9d4c4@changeid

Thanks!
