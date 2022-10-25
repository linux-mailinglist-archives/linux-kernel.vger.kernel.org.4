Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA4560CCEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiJYNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiJYNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:04:48 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1594AEC1F5;
        Tue, 25 Oct 2022 06:04:01 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id z30so7908709qkz.13;
        Tue, 25 Oct 2022 06:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hTvjb0tcZh53KAmGJm9tIusRTTvIDlg3I7uw0cpzIY=;
        b=c1cvhCUvwomPymwDcMD7gZFqe0UXxocTDwjmZhsJ8HTSFu25IR28+KgGLX1y+GMF1Y
         oEvIj9/BpAR5s6/ECbgfn3lWPrxvey+cYgWFG+CgEwvphb+CGy6Pf5gnNrUzXqq5GQJx
         1amfgG4SJpaLWrLFgctPcE/JqZvI88UzEjAJGoDjCYAYKeOvdsHbweR9TKCP+NzoRPOW
         2rgQ7F0nCmyG9OhhUrnjtS8eRoq+M40Jfu5F9I2/LDUiwoGlD/iV9DOPTlgzGluSYyFY
         ZJDapUoOaY2mzzlZGOpggv5u9q+EC0ifQI6mcc20cT98CTrHAqmQS4O76B0yb0MYwycD
         11mw==
X-Gm-Message-State: ACrzQf3kSYieTKs9wSiftT2yy2KfBKRvGrw4CVieuCW6mv3Mzkb6mB2i
        0IbLvW2HkkGXrGA4uIJ5ZijvuqyF/Bkp9/VsPOC2ihIo
X-Google-Smtp-Source: AMsMyM73afkLbc80YdAd3R70hpqRQwlAa+WHnXnKxEr49aecEbUtC44cg79MM3bNaOl/Z3KrZfPKkbcwekYEk7rHXuM=
X-Received: by 2002:a05:620a:4547:b0:6ee:dc16:d67a with SMTP id
 u7-20020a05620a454700b006eedc16d67amr26999081qkp.23.1666703040184; Tue, 25
 Oct 2022 06:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <2258064.ElGaqSPkdT@kreacher> <8bbd9bc65622aafd36433dbf0cf81338fde3007a.camel@linux.intel.com>
In-Reply-To: <8bbd9bc65622aafd36433dbf0cf81338fde3007a.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Oct 2022 15:03:49 +0200
Message-ID: <CAJZ5v0gMhzWiBm5H8V6eHfsCyJ0tyEaCfYJo0TvCeug6_Ek+DA@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq: intel_pstate: Make HWP calibration work on
 all hybrid platforms
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 1:58 AM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2022-10-24 at 21:18 +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > The HWP calibration in intel_pstate is needed to map HWP performance
> > levels to
> > frequencies, which are used in the cpufreq sysfs interface, in a
> > reliable way.
> > On all non-hybrid "core" platforms it is sufficient to multiply the
> > HWP
> > performance levels by 100000 to obtain the corresponding frequencies,
> > but on
> > hybrid ones there is a difference between P-cores and E-cores.
> >
> > Previous attempts to make this work were based on using CPPC (and in
> > particular
> > the nominal performance values provided by _CPC), but it turns out
> > that the
> > CPPC information is not sufficiently reliable for this purpose and
> > the only
> > way to do it is to use a hard-coded scaling factors for P-cores and
> > for E-cores
> > (which fortunately is the same as in the non-hybrid case).
> > Fortunately, the
> > same scaling factor for P-cores works on all of the hybrid platforms
> > to date.
> >
> > The first patch in the series ensures that all of the CPUs will use
> > correct
> > information from MSRs by avoiding the situations in which an MSR
> > values read
> > on one CPU will be used for performance scaling of another CPU.
> >
> > The second one implements the approach outlined above.
> >
> > Please see the changelogs for details.
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thank you!

As discussed offline, I'm going to fast-track this series as urgent
fixes to cover systems in the field that are likely to have problems
related to it.
