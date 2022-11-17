Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3B62DE80
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbiKQOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbiKQOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:43:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A8D2EE;
        Thu, 17 Nov 2022 06:43:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9327561F30;
        Thu, 17 Nov 2022 14:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00237C43145;
        Thu, 17 Nov 2022 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668696208;
        bh=PtQQuZh4x6gkV/7zv1jhLBJM1shrxLNzaR2wdAV4Bd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kB2sPWpNiRz3Ae5/wQ0URqxkNLVMl/RxfCfciicYJPXxVc5Y2XSJ/yPnX2YBvz0cD
         OTa9l2PKqLK95LJ7u8UH8tINKpDUs2hElD9P4RJm1SAeWti+PD9Q3rUiejlkp9BE/p
         pEbgHD6MSE+4y1YjRNh9F0tLmC3lm9lQEYHj1MqDbLg4JkFxyhKwqLJFMRlT3Xza/1
         XYUpqClvX3tNAGecFCaCLZ/Oam405WgZIJiYAtNJUhfqbc48PMmACkcw3iI2loi24S
         dkiHMLnpG0EOssXf+F24ZRWgvAStUW3PMJdF2XcNZnI3DcY5+zV56DDjy7wH3CfUO0
         /7jyoYL6te+/g==
Received: by mail-lj1-f176.google.com with SMTP id b9so2987017ljr.5;
        Thu, 17 Nov 2022 06:43:27 -0800 (PST)
X-Gm-Message-State: ANoB5pmJnfkM50EWKbOtF7XWvUPLdtERekjFDZYifx61PRFV8wX5gmKp
        WXvkZ9QK22dOUFwoPABRiUS7Jy0uDVHBtBsJ0Q==
X-Google-Smtp-Source: AA0mqf7jB2iKLFyRkgEPhmDznVrq+mWMaPm8RVbm9kLapVF5jFapO3LQ2aTW4BZ64Qc2gAP6XYENyA06X1A0z4BBREg=
X-Received: by 2002:a05:651c:1690:b0:277:2b10:bf69 with SMTP id
 bd16-20020a05651c169000b002772b10bf69mr1213015ljb.392.1668696205975; Thu, 17
 Nov 2022 06:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Nov 2022 08:43:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+WOjoPW0FDSa=B9-aCMwXC3tc5HUqokoVkKUucKgqanQ@mail.gmail.com>
Message-ID: <CAL_Jsq+WOjoPW0FDSa=B9-aCMwXC3tc5HUqokoVkKUucKgqanQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] perf: Arm SPEv1.2 support
To:     Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 10:55 AM Rob Herring <robh@kernel.org> wrote:
>
> This series adds support for Arm SPEv1.2 which is part of the
> Armv8.7/Armv9.2 architecture. There's 2 new features that affect the
> kernel: a new event filter bit, branch 'not taken', and an inverted
> event filter register.
>
> Since this support adds new registers and fields, first the SPE register
> defines are converted to automatic generation.
>
> Note that the 'config3' addition in sysfs format files causes SPE to
> break. A stable fix e552b7be12ed ("perf: Skip and warn on unknown format
> 'configN' attrs") landed in v6.1-rc1.
>
> The perf tool side changes are available here[1].
>
> Tested on FVP.
>
> [1] https://lore.kernel.org/all/20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org/
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v3:
> - Add some more missing SPE register fields and use Enums for some
>   fields
> - Use the new PMSIDR_EL1 register Enum defines in the SPE driver
> - Link to v2: https://lore.kernel.org/r/20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org
>
> Changes in v2:
> - Convert the SPE register defines to automatic generation
> - Fixed access to SYS_PMSNEVFR_EL1 when not present
> - Rebase on v6.1-rc1
> - Link to v1: https://lore.kernel.org/r/20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org
>
> ---
> Rob Herring (8):
>       perf: arm_spe: Use feature numbering for PMSEVFR_EL1 defines
>       arm64: Drop SYS_ from SPE register defines
>       arm64/sysreg: Convert SPE registers to automatic generation
>       perf: arm_spe: Drop BIT() and use FIELD_GET/PREP accessors
>       perf: arm_spe: Use new PMSIDR_EL1 register enums
>       perf: arm_spe: Support new SPEv1.2/v8.7 'not taken' event
>       perf: Add perf_event_attr::config3
>       perf: arm_spe: Add support for SPEv1.2 inverted event filtering
>
>  arch/arm64/include/asm/el2_setup.h |   6 +-
>  arch/arm64/include/asm/sysreg.h    |  99 +++--------------------
>  arch/arm64/kvm/debug.c             |   2 +-
>  arch/arm64/kvm/hyp/nvhe/debug-sr.c |   2 +-
>  arch/arm64/tools/sysreg            | 139 +++++++++++++++++++++++++++++++++
>  drivers/perf/arm_spe_pmu.c         | 156 ++++++++++++++++++++++++-------------
>  include/uapi/linux/perf_event.h    |   3 +
>  7 files changed, 257 insertions(+), 150 deletions(-)

Will, any comments on this series?
