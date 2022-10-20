Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73126606920
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJTTvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJTTvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:51:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0489A1FAE6A;
        Thu, 20 Oct 2022 12:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 939CE61CFD;
        Thu, 20 Oct 2022 19:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04FFC43144;
        Thu, 20 Oct 2022 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666295473;
        bh=A9VoRgR6bzi4c4yYMEbN8DyaGqa9LNIhOqN8jYUfKqA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UR1Ek2h1WAD92kTiNaDUijKxQtHMHSGViP8SV6zeeFRgcbHgtrPJId/RWk1hFMrwx
         X2n2479KewtlMdR18WhLfOsS4mpOcansX+viFWhImWZBMQL2DtDSey0LUJBy+lK5EJ
         07jXp6qiZr1cLpds9TgS/Y0csl841mLKPjoDdWn1q9MKKbjMDBleZBGUJhjLVsHikb
         GWZ8VygEZ8bkUHZPSh+9E/SGYYcLJdxzPC9kKwvaX/5/rCXeK6JoT5ykKm1Wruym/o
         W4oPH9u78EEpzFDrSTLaRVGbPczO0TIAuN1rv2jFsliLJkKy5xdwYZJD1QLCq63kU3
         zRYOigY4k8w1w==
Received: by mail-vk1-f174.google.com with SMTP id u204so339289vkb.13;
        Thu, 20 Oct 2022 12:51:12 -0700 (PDT)
X-Gm-Message-State: ACrzQf3FvhnrDo6ZvV4KU2IHQbx+yke/NRJlje+vEsU/6mHAc5OpfBT0
        c7vEMBXdT1byGZS7b+QQ94G9jPlVntnyIY0iyA==
X-Google-Smtp-Source: AMsMyM7u7wV871a7sMf6cDm8Cp2SxQcmq+IVFFx8ESqkntMYR2zBJYwu6TxtcDkd2XcyxAgHl8fZrJU2s7ju9Elrgj0=
X-Received: by 2002:a1f:3d4c:0:b0:3aa:feb8:3ec6 with SMTP id
 k73-20020a1f3d4c000000b003aafeb83ec6mr8414254vka.26.1666295471867; Thu, 20
 Oct 2022 12:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org>
 <20220825-arm-spe-v8-7-v2-3-e37322d68ac0@kernel.org> <Y1FcRNhFpZxZ7AMx@sirena.org.uk>
In-Reply-To: <Y1FcRNhFpZxZ7AMx@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Oct 2022 14:51:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLVjWH-x3jxGQpJ3ax_ddvBqHd-P2DE=DEnrknoHuq+Qg@mail.gmail.com>
Message-ID: <CAL_JsqLVjWH-x3jxGQpJ3ax_ddvBqHd-P2DE=DEnrknoHuq+Qg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] arm64/sysreg: Convert SPE registers to automatic generation
To:     Mark Brown <broonie@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Jiri Olsa <jolsa@kernel.org>, kvmarm@lists.cs.columbia.edu,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 9:33 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Oct 19, 2022 at 02:11:26PM -0500, Rob Herring wrote:
> > Convert all the SPE register defines to automatic generation. No
> > functional changes.
> >
> > New registers and fields for SPEv1.2 are added with the conversion.
> >
> > Some of the PMBSR MSS field defines are kept as the automatic generation
> > has no way to create multiple names for the same register bits. The
> > meaning of the MSS field depends on other bits.
>
> A few small things below from checking against DDI0487I.a, nothing
> major:

[...]

> > +Sysreg       PMSIDR_EL1      3       0       9       9       7
>
> > +Field        23:20   FORMAT
> > +Field        19:16   COUNTSIZE
> > +Field        15:12   MAXSIZE
> > +Field        11:8    INTERVAL
>
> These should really be enums.

Okay for COUNTSIZE and INTERVAL.

The only defined value for FORMAT is 'Format 0'. I assume next will be
'Format 1'. I don't think defines with the value in the name are too
useful. When this is used, we'll just be passing the value to
userspace via either sysfs or perf aux buffer.

MAXSIZE is the power of 2 encoded size and we just convert to bytes
(1<<MAXSIZE). So I can add them, but they will never be used.

> > +Sysreg       PMBLIMITR_EL1   3       0       9       10      0
> > +Enum 2:1     FM
> > +     0b0000  STOP_IRQ
> > +EndEnum
>
> DDI0487I.a also defines
>
>         0b01    DISCARD

STOP_IRQ doesn't seem like the best name either. It's not used, so I
changed it to 'FILL'.

> > +Sysreg       PMBIDR_EL1      3       0       9       10      7
> > +Res0 63:12
> > +Field        11:8    EA
>
> This looks like it should be described as an enum.

    0b0000    Not_Described
    0b0001    Ignored
    0b0010    SError

What's the preferred case here?

>
> > +Field        3:0     ALIGN
>
> This could potentially also be an enum.

Another power of 2 encoding.

> > +Sysreg       PMSCR_EL2       3       4       9       9       0
> > +Res0 63:8
> > +Field        7:6     PCT
>
> This lookslike it should be an enum.

Humm, PCT is a bit tricky. Here's what I came up with:

Enum    7:6    PCT
    0b00    VIRT
    0b01    PHYS
    0b11    GUEST
EndEnum

Again, CAPS or CarrotCase for new things?

Rob
