Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0819F62120A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiKHNNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbiKHNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:13:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8DF1D0E5;
        Tue,  8 Nov 2022 05:13:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864846156F;
        Tue,  8 Nov 2022 13:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE471C43144;
        Tue,  8 Nov 2022 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667913184;
        bh=RjKzHDdvNdhhqfLtS6tIrlSlQE1p+3t6lJ0X9tYX6TA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G5qTTVfPjy9TPUXnDtlwJU0YWJuvTONeWw/y/aSJoSVpg8j0T1mMvPWFDASH/1TWh
         cvX1skWSgomoSxE9UJWPCqKqYqBP07Qxj2+B/PMut1qcZMcxYIsPL6WP5h7jdXk+dX
         lY56IRfDDJ09vyz3COv4/iohkQpgM5bNuy3KJ2M7n5u0otxamah19V1ssGjLTSO/61
         lBehPahySwDRBsQ5oySBPm2KjwCpE6DCghYGWqHarE4WmtgnCbnVyfVpa1DQfTEXxc
         Rx7K3WgncFgW6L32rJefMkjmggU+J9ICGjwQBeKjlv+Rj04haNiRQi1thAPPEet3YT
         ZJdsPRESvvkRw==
Received: by mail-lj1-f174.google.com with SMTP id a15so21022344ljb.7;
        Tue, 08 Nov 2022 05:13:03 -0800 (PST)
X-Gm-Message-State: ACrzQf0PJK5nyvs6/IEXhDPwBCC76OFcdNDonPN9zF+ycbvaCx4meB7i
        M1RhiQ2B5I2bkjLcS2wklt+YIHBz6ESXp4mvpA==
X-Google-Smtp-Source: AMsMyM5O7pLGp8uyEtGPHwwVGHXeMrvhpQYBhNZudRznlwrlOHTsrSivsSasDCN6BrYubsxGr8Wt2bonOSkVnaLNpOY=
X-Received: by 2002:a05:651c:114a:b0:25d:5ae6:42a4 with SMTP id
 h10-20020a05651c114a00b0025d5ae642a4mr19131225ljo.255.1667913181963; Tue, 08
 Nov 2022 05:13:01 -0800 (PST)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
 <20220825-arm-spe-v8-7-v3-8-87682f78caac@kernel.org> <CAM9d7ciYabTpo0q5Z8h229dZ+RXG7JP1zgOoR1fgdZZCH87vow@mail.gmail.com>
In-Reply-To: <CAM9d7ciYabTpo0q5Z8h229dZ+RXG7JP1zgOoR1fgdZZCH87vow@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Nov 2022 07:12:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKS+xos95R0KUhm-xJ5ZhTaa7XYc-Ly45BCEWTXOh4j7w@mail.gmail.com>
Message-ID: <CAL_JsqKS+xos95R0KUhm-xJ5ZhTaa7XYc-Ly45BCEWTXOh4j7w@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] perf: arm_spe: Add support for SPEv1.2 inverted
 event filtering
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
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
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
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

On Mon, Nov 7, 2022 at 1:48 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Fri, Nov 4, 2022 at 8:55 AM Rob Herring <robh@kernel.org> wrote:
> >
> > Arm SPEv1.2 (Arm v8.7/v9.2) adds a new feature called Inverted Event
> > Filter which excludes samples matching the event filter. The feature
> > mirrors the existing event filter in PMSEVFR_EL1 adding a new register,
> > PMSNEVFR_EL1, which has the same event bit assignments.
>
> Just out of curiosity, is it possible to have the event filter and
> inverted filter at the same time?

Yes, that's why config3 is needed. Samples with all the events set in
PMSEVFR_EL1 and none of the events set in PMSNEVFR_EL1 are recorded.
For example if an event bit is 0 in PMSEVFR_EL1, then recorded samples
may or may not have that event. If the same event bit is then set in
PMSNEVFR_EL1, then record samples will not have that event.

> What if they have the same?

You'd get no samples.

Rob
