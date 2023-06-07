Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4B72731C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjFGXh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjFGXh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:37:27 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5BC26A0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:37:09 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77a1cad6532so132315839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181027; x=1688773027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+jSOn4aArekcx3+zLzXPOVm14+fmJKsE3biZ6If6cY=;
        b=jay0sx5I2eQJ1h0tFcbnDacV26IJmwGBLopaqg9DOWbtRQ7ybBPfwdd2BNkqB3lHtE
         J4RGXyEk6iqgy1HXPB/g1DjSrcSlwg97W39i6VftoHs9B0IJBO2e++EzrVAOrW3mJQDy
         f7/ja59F/QvYEbDmEt06LuyrANktoXcrkyWIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181027; x=1688773027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+jSOn4aArekcx3+zLzXPOVm14+fmJKsE3biZ6If6cY=;
        b=EsD20UaFOgYaB6t/Bo/ECPAzc5ejQpqXfkUvYrNsW5T2s144TJ49mcvZF+UHZJ9Eeq
         HOvmXflFPhGdco9rzdk1h3LYBcBk/mjaj+9dsgFDtES65f/fCr9v+r22GQxl2NPgTUuU
         2voctZIyPhsRFC8SfHV6c8ZFlVCuml+C25CfmOgR2fMKOMtWINfQ2ec3BQ5KYousWI0c
         O2oYQ0uxLm9vNwEyYnT5Nk0aLRdKe58JTBVxb4ruXtOvTbqJ8tVEtmjM1dtLSqOFrRGQ
         8uwNEahqldtRFyqY83bZ8EKupRO9izccIppixfhKNEUuLUp9h9mHACXTKKadozplQFfM
         60Wg==
X-Gm-Message-State: AC+VfDyMdadTt/u16Y3Zqp4l6QrYBd1c1mnIrcr3CW2NWO+1e5LQOYPj
        EfCeoGgVHLtMoBT7auNdJeBPTLuLv69wdLkQe50=
X-Google-Smtp-Source: ACHHUZ6LAZw7NGSC56botCjOljVA0rh5GCKD7JojSw9R30n6ycAIx6g62XBxFGVsFr1fwxpyKZVlPQ==
X-Received: by 2002:a5e:8808:0:b0:779:c221:eb62 with SMTP id l8-20020a5e8808000000b00779c221eb62mr8998025ioj.15.1686181026886;
        Wed, 07 Jun 2023 16:37:06 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id dx1-20020a0566381d0100b0041cea93e589sm3695150jab.152.2023.06.07.16.37.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:37:05 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-33dea7d5424so26225ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:37:02 -0700 (PDT)
X-Received: by 2002:a05:6e02:170c:b0:33c:a46c:23b3 with SMTP id
 u12-20020a056e02170c00b0033ca46c23b3mr99141ill.1.1686181022226; Wed, 07 Jun
 2023 16:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-7-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-7-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:36:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-H9z20zT8Oop5+Hnf-S3QgiotzQ=f3LGvN6AiLUxi=Q@mail.gmail.com>
Message-ID: <CAD=FV=V-H9z20zT8Oop5+Hnf-S3QgiotzQ=f3LGvN6AiLUxi=Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] watchdog/sparc64: Define HARDLOCKUP_DETECTOR_SPARC64
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
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

On Wed, Jun 7, 2023 at 8:26=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> The HAVE_ prefix means that the code could be enabled. Add another
> variable for HAVE_HARDLOCKUP_DETECTOR_SPARC64 without this prefix.
> It will be set when it should be built. It will make it compatible
> with the other hardlockup detectors.
>
> Before, it is far from obvious that the SPARC64 variant is actually used:
>
> $> make ARCH=3Dsparc64 defconfig
> $> grep HARDLOCKUP_DETECTOR .config
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64=3Dy
>
> After, it is more clear:
>
> $> make ARCH=3Dsparc64 defconfig
> $> grep HARDLOCKUP_DETECTOR .config
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64=3Dy
> CONFIG_HARDLOCKUP_DETECTOR_SPARC64=3Dy
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/sparc/Kconfig.debug | 10 +++++++++-
>  include/linux/nmi.h      |  4 ++--
>  kernel/watchdog.c        |  2 +-
>  lib/Kconfig.debug        |  2 +-
>  4 files changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
