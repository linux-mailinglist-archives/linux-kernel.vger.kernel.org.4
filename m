Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E016461E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiLGT5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:57:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FDE5E3CD;
        Wed,  7 Dec 2022 11:57:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C7D861BAF;
        Wed,  7 Dec 2022 19:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CFCC433D7;
        Wed,  7 Dec 2022 19:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670443024;
        bh=AvmeQtrnl7xMXtEnD6viJTvtLqEQcfiUyyyKZl/KgUI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ObplL2g8TxTO5JJOjfNmVoA6K7NHMQs2vaoeQ8u0mEZIQu8gLeqCx6d8mgaTga/BN
         bc376wJENHG5Zx2mALAkvG9AD8eEcU2D2t+zU/g2gWfdHcB+YvjaUhf1eAM4ah9E6g
         HxlHuQI1pnrpq56qd7fAIykbUO5dDDDDSSM2TpXQ+cHruqik5wqddbEmqONurSgYoO
         iIs1QIs5quM6sNqIBbuV5a9PcQuIdKGKk2qlEiYFZqBY7GCJgFBA+/Q67aNSN+fjOe
         TkuSnoXCog3/5QBkPYZiRnsqQ73zm7umoQBu2qcR0AedfrMHeLNUMMMLfwy05q6xsL
         0hLaOMGk22yRw==
Received: by mail-vk1-f173.google.com with SMTP id z23so4818562vkb.12;
        Wed, 07 Dec 2022 11:57:04 -0800 (PST)
X-Gm-Message-State: ANoB5pmXKTUU3z7RyEUdmyfNBWmcM12whZa7hI2gKV/vMGb8SyYDmGGX
        2RbvxMiweIn/78pHXF2wYsHQRIsvgnNpOfCNEw==
X-Google-Smtp-Source: AA0mqf79ttTFnrHyDKt4VUK0QUXtDvssZUfj1nXbNUgEZmKUPkzsNanut9A30xKpK3IOHRfaB9JBKoN+r9dpoMCKPpw=
X-Received: by 2002:a1f:41ca:0:b0:3bd:ce89:f4e6 with SMTP id
 o193-20020a1f41ca000000b003bdce89f4e6mr4493288vka.26.1670443023467; Wed, 07
 Dec 2022 11:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
 <20220825-arm-spe-v8-7-v3-7-87682f78caac@kernel.org> <20221118164943.GA4872@willie-the-truck>
 <CAL_JsqJMxEWhqZV=yqG15zvEHrBTwRVfHA6zptu2TswxRMSR0A@mail.gmail.com>
 <877czfujdj.fsf@ubik.fi.intel.com> <CAL_JsqKJYrEUzkzNMKMOGvzJN_EqacHZvBR6eVt35bRhhtRo=g@mail.gmail.com>
 <Y49ttrv6W5k3ZNYw@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <Y49ttrv6W5k3ZNYw@FVFF77S0Q05N.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 7 Dec 2022 13:56:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfZVrwFgYDwA9mz3FPp3jf0r5OOajTJ=7QvwE8P8UKyw@mail.gmail.com>
Message-ID: <CAL_JsqLfZVrwFgYDwA9mz3FPp3jf0r5OOajTJ=7QvwE8P8UKyw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] perf: Add perf_event_attr::config3
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
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

On Tue, Dec 6, 2022 at 10:28 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Peter, it looks like this series is blocked on the below now; what would you
> prefer out of:
>
> (a) Take this as is, and look add adding additional validation on top.
>
> (b) Add some flag to indicate a PMU driver supports config3, and have the core
>     code check that, but leave the existing fields as-is for now (and hopefully
>     follow up with further validation later for the existing fields).

That looks something like this:

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 853f64b6c8c2..845162b152ea 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -286,6 +286,7 @@ struct perf_event;
 #define PERF_PMU_CAP_NO_EXCLUDE                        0x0080
 #define PERF_PMU_CAP_AUX_OUTPUT                        0x0100
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE          0x0200
+#define PERF_PMU_CAP_CONFIG3                   0x0400

 struct perf_output_handle;

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aefc1e08e015..4414ae64432a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11314,6 +11314,9 @@ static int perf_try_init_event(struct pmu
*pmu, struct perf_event *event)
                    event_has_any_exclude_flag(event))
                        ret = -EINVAL;

+               if (!(pmu->capabilities & PERF_PMU_CAP_CONFIG3) &&
event->attr.config3)
+                       ret = -EINVAL;
+
                if (ret && event->destroy)
                        event->destroy(event);
        }
