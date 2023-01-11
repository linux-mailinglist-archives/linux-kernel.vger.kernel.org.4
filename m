Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00572665469
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjAKGOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjAKGOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:14:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F94EE62
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:14:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z5so12938533wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIQ7qpauSbHhO2Y1Qi2mlq/E9mQryCMm0vG6QwCfULY=;
        b=S+Nt7OJ0/sQ41EZTkR67683caO9Eqqjv0j6r9kECCPH3A0X0bgBJNoV7qWvCkvra6R
         KlmIfzuzpDC271S34r/R9232WpvheDpVZpVotv9HnypR5xCK1xaQGiIWqlzw01s0pD1I
         QHrdIEkOslw9XJvAD4/DNK+jdTVrmOYOV/f456NWBYlV+6cwFYKsm6M3DvZ8+/PzIQg7
         CpoxebS3Ynxp4+/wWmafEz7P42NVD4VwTU1WIuOW8Eb3IBOdVCIkOkZaTuo7AvnTvJ6L
         8nEu7YzROpz0NRPn4/J4i4MiMvKOzXrqgKK7kqvCx0LSJdUZgtGpPiJebIyKiWDI8m3H
         eqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIQ7qpauSbHhO2Y1Qi2mlq/E9mQryCMm0vG6QwCfULY=;
        b=MrkZjMgw25LgFpN96/tMQ45StI/KGImX5uRjlDab9A4mqGPpctvKT80WOl6bwy67Rf
         yni9md9QvLtcz9LU3sjT/FZmHp5qjcWCZK36NaCyDKswOibsgcYd1GlA+vjfn5iEHuU2
         Cyv38jWTsPAVH1m5exBmO+Bi+Z6RsTAb58eUPxh+O38LuZO3LZMUDMIE7FkL9/kfbVxh
         IwLBIuKAwPrZ+oTawtWQhGBCY8+hgHy3yNpLZkzI4pfZCOGDiH9/JaxNkTKI84C4KVRg
         n8/hSN0TELxE8oosUp/wMo8cvO7EYbRzPytkdr8nYrNauCvdbvfI3aRH7NRUzTwMYJNa
         Jzsg==
X-Gm-Message-State: AFqh2kp21p8wqAxkS667M19Og97qYrCZTzZFESwTksFo5dJ2H64YrOYP
        gWusfklT2xvhTMCAIGw9ccHzPGQCb+aNCTnWv00r+w==
X-Google-Smtp-Source: AMrXdXvBnDPpKKrgiIU+2rNV0v16BQ2tr/0sCaT9KlYahquXg4H//4DQ2ERRzsP/ahVoZwArpvyhfN8aOfw1p2qG3ys=
X-Received: by 2002:a5d:6e0a:0:b0:242:5caa:5fbf with SMTP id
 h10-20020a5d6e0a000000b002425caa5fbfmr1372780wrz.300.1673417686436; Tue, 10
 Jan 2023 22:14:46 -0800 (PST)
MIME-Version: 1.0
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1672745976-2800146-2-git-send-email-renyu.zj@linux.alibaba.com>
 <5c5716e5-b2ff-67cd-b608-4eeffa7e04bc@oracle.com> <1f3d53cb-4160-e29d-3934-d6a488d9fd49@linux.alibaba.com>
 <7aa225df-af25-a6be-9bef-c965488ba43a@oracle.com> <d4d132d9-1513-6a4e-981f-aa4bc4ebbcbb@linux.alibaba.com>
 <00bf227a-75ce-c63c-c740-89b8d2b27e1c@oracle.com> <CAP-5=fVGmjFOZqOk0E1bcqeTHcJhEmoA-vrKcHLOs4B_ythT1g@mail.gmail.com>
 <6971b848-2754-6909-d36b-ea80fe157e95@oracle.com> <ec5684cd-a527-4e13-2b05-31832d80535c@arm.com>
In-Reply-To: <ec5684cd-a527-4e13-2b05-31832d80535c@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 Jan 2023 22:14:34 -0800
Message-ID: <CAP-5=fVLCV5bskAMDTvxZYxgbBYg9-yccF1-EhZPwAgVYU9Htg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] perf vendor events arm64: Add topdown L1 metrics
 for neoverse-n2
To:     James Clark <james.clark@arm.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 7:35 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 06/01/2023 10:14, John Garry wrote:
> > On 05/01/2023 21:13, Ian Rogers wrote:
> >>>> This may be a feasible idea. The value of slots comes from the
> >>>> register PMMIR_EL1, which I can read in
> >>>> /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots. But how do I
> >>>> replace the slots in MetricExpr with the
> >>>> read slots values? Currently I understand that parameters in
> >>>> metricExpr only support events and constants.
> >>>>
> >>> Maybe during runtime we could create a pseudo metric/event for SLOT.
> >> For Intel we do this by just having a different constant for each
> >> architecture. It is fairly easy to add a new "literal", so you could
> >> add a #slots in expr__get_literal:
> >> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kerne=
l/git/acme/linux.git/tree/tools/perf/util/expr.c?h=3Dperf*core*n407__;LyM!!=
ACWV5N9M2RV99hQ!IHcZFuFaLdQDQvVOnHVlbbME2S4aW8GohWUkydlejpi7ifFz61r7RutGXRe=
Rt0d88X_vDfkTySCiuD2PqOA$  Populating it would be the challenge =F0=9F=98=
=84
> >
> > Thanks for the pointer. I think that the challenge in populating it
> > really comes down to whether we would really want to make this generic.
> >
> > I suppose that for arm64 we could have a method which accesses this
> > PMMIR_EL1 register, while for other archs we could have a weak function
> > which just returns NAN. If other archs want to use this key expr, they
> > can add their own method.
> >
>
> I wonder if it would be worthwhile and even more generic to add some
> sort of int containing file accessor construct. It could also have
> support for a default value when the file doesn't exist. For example:
>
>   "MetricExpr": "ITLB / {file://<pmu>/caps/slots(5)}"
>
> It gets a bit fiddly because you might want to support absolute paths
> and paths relative to whatever PMU is being used. But it could prevent
> having to add some custom identifier and glue code for every possible
> file that just has an integer in it.
>
> It also wouldn't be possible to support the case where the file has
> bitfields in it that need to be extracted, so maybe we shouldn't do it.
>
> James

Thanks James,

I think there are many opportunities to improve the metrics. One step
in this direction is:
https://lore.kernel.org/lkml/20221221223420.2157113-1-irogers@google.com/
(which is looking for reviews :-D ). Some areas we could improve include:
 - the expression code has support for longs but I don't believe any
metrics use it.
 - the modulus is weird and again unused.
 - I think divide (/) should behave like d_ratio as aborting parsing
is next to useless.
 - events like Intel's msr/tsc/ don't have to be programmed on every
CPU/hyperthread and doing so is quite wasteful.
 - we may have a read but no write counter, so being able to read a
sibling CPUs/socket's read counter may inform about writes. This isn't
currently expressible as metrics compute based on whatever the
aggregation mode is, you can't get a particular count.
 - perf stat record/report don't work/compute metrics, but just
provide counters.
 - the json format should resemble sysfs rather than being a flat
list, metrics and events in the list should be separated.
 - metrics use / as divide and so @ is used in /'s place for event
modifiers. BPF events use / as a directory separator.

For the filesystems reading I think it is a good idea. I'd like to
make it so that things like #num_dies become tool events and remove
the notion of literals. Perhaps we can make reading a file something
that is an event. The current event parsing logic is overly complex,
for example the handling of '-' which has some legacy PMU separation
properties. A proposal mentioned at LPC was to have a new event
parsing library that doesn't carry legacy baggage. We can make metric
code use this as the metrics encode the events. If the new library
fails parsing the code can fall back on the existing parser. I'd like
it if the event parsing logic more closely resembled the sysfs style.
I'd like it if we could have events in sysfs, built into the tool (but
with a layout resembling sysfs) and also allow events, etc. to be
added by having say a zip of a sysfs directory/file structure. I'm
hoping libraries like metric.py:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/pmu-events/metric.py
can be used by vendors, so that it is easy to update vendor generated
json if/when the format changes.

Thanks,
Ian
