Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D098B619A76
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiKDOrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiKDOri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:47:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BD130550;
        Fri,  4 Nov 2022 07:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF2D62239;
        Fri,  4 Nov 2022 14:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2194C4347C;
        Fri,  4 Nov 2022 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667573244;
        bh=wPPnLNZ+4T3Fuos8Ly78Qj2v7R8MfGXYzebSE4GJ56s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d/7GPpvjH1jr3aFEkcWCRke/i2dOsHwqocnWKSK5H2rrqObWkDPivRKZkiVinqC4w
         bvWGdrmA0VYgrnLo+/GwxKgpCGCsFhFVdt5ucL0svuahYo1cCgJaeRt72YcLbRUMsd
         DIpZtLpgik8mbY4FbRSuaQ1g7+h7ypYO2lARwHmOworsjMxsa/IEmKxdayPgqGx5fG
         jFj9fw/UCASzCMJu6J5BUxwzpJnE74f5nu9/iyNSSXgEydIeyy6J7SQNehKy9rBwzl
         JMiH8gPJD1hPCE5DFBlxiMyCte/KDagvwV3b4yVqbTj7Rqmrohl6ofddDWvI45URLt
         sVZuLstD5UZAw==
Received: by mail-lj1-f176.google.com with SMTP id u11so6673060ljk.6;
        Fri, 04 Nov 2022 07:47:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf3TCaZXEm7JNrkTwWoEgxA/LqXymG5Z56HHtCj4DkbiCi/g08HE
        S9JOwkFpcXqPqzrJ+KMZNzgXDOTiowLU8TTTDQ==
X-Google-Smtp-Source: AMsMyM62Xs6fCvQyp5qZFL0MJl4QpNNhlm01k6mmAVVcbjT5g/d41ex992OtIiF0ZA7d3S+KRipg5DVCEr5R0NJZekA=
X-Received: by 2002:a05:651c:114a:b0:25d:5ae6:42a4 with SMTP id
 h10-20020a05651c114a00b0025d5ae642a4mr13404029ljo.255.1667573242688; Fri, 04
 Nov 2022 07:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org> <5c410969-2176-49cf-640f-8023c421682e@arm.com>
In-Reply-To: <5c410969-2176-49cf-640f-8023c421682e@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Nov 2022 09:47:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ6hdCxTOFk=r6RE_3XGtBhF1HRCMKdjrW-D2FuYazZrQ@mail.gmail.com>
Message-ID: <CAL_JsqJ6hdCxTOFk=r6RE_3XGtBhF1HRCMKdjrW-D2FuYazZrQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] perf: Arm SPEv1.2 support
To:     James Clark <james.clark@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 6:30 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 19/10/2022 20:11, Rob Herring wrote:
> > This series adds support for Arm SPEv1.2 which is part of the
> > Armv8.7/Armv9.2 architecture. There's 2 new features that affect the
> > kernel: a new event filter bit, branch 'not taken', and an inverted
> > event filter register.
> >
> > Since this support adds new registers and fields, first the SPE register
> > defines are converted to automatic generation.
> >
> > Note that the 'config3' addition in sysfs format files causes SPE to
> > break. A stable fix e552b7be12ed ("perf: Skip and warn on unknown format
> > 'configN' attrs") landed in v6.1-rc1.
> >
> > The perf tool side changes are available here[1].
> >
> > Tested on FVP.
> >
> > [1] https://lore.kernel.org/all/20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org/
> >
>
> LGTM. Tested with [1] applied and on N1SDP (where it isn't supported),
> and on the FVP. Enabling all the inverted filters results in no trace
> and other combinations work as expected.

Thanks, I'll take that as a 'Tested-by' tag if that's okay.

In the future, please be explicit with tags. Tools such as b4 and
patchwork will recognize them and add them automatically.

Rob
