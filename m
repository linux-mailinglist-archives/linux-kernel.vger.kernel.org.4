Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7487F63ACBE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiK1Phu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiK1Phm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:37:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBCC21A8;
        Mon, 28 Nov 2022 07:37:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86DA461241;
        Mon, 28 Nov 2022 15:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5346C433D6;
        Mon, 28 Nov 2022 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669649860;
        bh=axC0bOfcmCXcacu/P2Pz0VCjCGhZUlb2iE5k15oCKYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ucSbWoT0+0wduq4sl2bVdpv3u2Q9Pddm6ucmKKK7+ELAgmXlReOH/bMpzEmtxhbHs
         LdDMsxtzEDSxU9TFIdoeEfaBc9OrPslaYn4tLvdiR8yeKH+mGhw8d6ZPEGgFPYsgjj
         qzdrMezj/xH7d/hFfKqFBevU2I5BOw1SklGasLhO7DHeZFV8x72SMzkYSZaQaDjZeh
         bpyDvj80fLeqGTdjswxum0xOPZi5qas91sc/aAcQwTxgVMLfaPNgoDxhIKBdhTjKX3
         XvjA/GieW4tTrlq+WgHuBB200PFObXnJknm7oGYlBAm2eYxhpxFCuG1lK0RVenS5qg
         8rDNqw4GC2lkA==
Received: by mail-vk1-f169.google.com with SMTP id s17so4201981vka.13;
        Mon, 28 Nov 2022 07:37:40 -0800 (PST)
X-Gm-Message-State: ANoB5pm7dMWGacywE/TDUky1GqSWQE+secH8W8aby3sUm/KPQgytXq4M
        nf5AUcCMHTeYzrZEsi/Ix4I8ip16ggI3lNzJmg==
X-Google-Smtp-Source: AA0mqf47oOpOINKJ64oOFgIVKNUPHLJ4ZGkpiXyC+OMmMYBM1LnHgMTlIgOw0DD8Jyah1mivcWxiIo1aoqaQuKrmCjM=
X-Received: by 2002:a05:6122:b45:b0:3bc:811b:ddce with SMTP id
 5-20020a0561220b4500b003bc811bddcemr20313339vko.35.1669649859866; Mon, 28 Nov
 2022 07:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
 <20220825-arm-spe-v8-7-v3-7-87682f78caac@kernel.org> <20221118164943.GA4872@willie-the-truck>
In-Reply-To: <20221118164943.GA4872@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 28 Nov 2022 09:37:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMxEWhqZV=yqG15zvEHrBTwRVfHA6zptu2TswxRMSR0A@mail.gmail.com>
Message-ID: <CAL_JsqJMxEWhqZV=yqG15zvEHrBTwRVfHA6zptu2TswxRMSR0A@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] perf: Add perf_event_attr::config3
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
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

On Fri, Nov 18, 2022 at 10:49 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Nov 04, 2022 at 10:55:07AM -0500, Rob Herring wrote:
> > Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> > existing perf_event_attr::configN fields are all used up for SPE PMU, an
> > additional field is needed. Add a new 'config3' field.
> >
> > Tested-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v3:
> >  - No change
> > v2:
> >  - Drop tools/ side update
> > ---
> >  include/uapi/linux/perf_event.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index 85be78e0e7f6..b2b1d7b54097 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -374,6 +374,7 @@ enum perf_event_read_format {
> >  #define PERF_ATTR_SIZE_VER5  112     /* add: aux_watermark */
> >  #define PERF_ATTR_SIZE_VER6  120     /* add: aux_sample_size */
> >  #define PERF_ATTR_SIZE_VER7  128     /* add: sig_data */
> > +#define PERF_ATTR_SIZE_VER8  136     /* add: config3 */
> >
> >  /*
> >   * Hardware event_id to monitor via a performance monitoring event:
> > @@ -515,6 +516,8 @@ struct perf_event_attr {
> >        * truncated accordingly on 32 bit architectures.
> >        */
> >       __u64   sig_data;
> > +
> > +     __u64   config3; /* extension of config2 */
>
> I need an ack from the perf core maintainers before I can take this.

Peter, Arnaldo, Ingo,

Can I get an ack on this please.

Rob
