Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD31F656E19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiL0SyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL0SyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:54:16 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0BE103E;
        Tue, 27 Dec 2022 10:54:15 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id bp44so8469972qtb.0;
        Tue, 27 Dec 2022 10:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UyCHYgcKdnh1AuUb7mkxH/rhz7ro92GMl/vFMjJCDM=;
        b=8OILOveoMwPLWQOSPEDT/vJt3vl3/X1MVZr3FEwqOsg5OS/rfWJy8sCYnvWOUP1OhT
         v6eH7Bgz9kBK/2Boq/EZb+EpHkaCpmefxtXXtjiAzuV/PsXVH9ZLJtTFyDGgTpjSgFhj
         ZlI+nrJqNEuZszkeWt/KruTlKHCQUzQKNpjG1aiV3SSONw63YZgfpV3OFwOhJluxG5TQ
         8sliY5cxC0ShyuTMMcHUDTs53RxQxeckO/QE9x2xg9RbFH8RuCAexvsvCR7rkvEr+Tvv
         xHpI+zE2j2Ur8bhQQwP2im7TAIweetLg/T5bgNpWWrFc4INF5IzDdml4hd4d2D4Fdxtu
         x05Q==
X-Gm-Message-State: AFqh2kqdxG+rEXkigFiNqJWb+eytw/PXTKLaTQ5r988saYZXRJgFaJde
        XRSP69lTCeb06ot2cou11ymMgMKuUx/FmktZA84=
X-Google-Smtp-Source: AMrXdXsQ0LtWHl7rCgXKWEQZfmplELHbQGG6jatFL+5aCussqN2TmVnt1xZiFW5zRi3QG/X0qZGvXvWYd3m925q/reE=
X-Received: by 2002:ac8:528a:0:b0:3a8:1410:2dbe with SMTP id
 s10-20020ac8528a000000b003a814102dbemr954677qtn.48.1672167254806; Tue, 27 Dec
 2022 10:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20221221155203.11347-1-ptyadav@amazon.de> <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
 <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
 <2ed9702b67832e3e33ef352808124980206c1e95.camel@linux.intel.com>
 <8e2cc66f7dadcfb04099aac7c4eef0b02075c91b.camel@linux.intel.com>
 <mafs07cycdfh4.fsf_-_@amazon.de> <33dd969d9bdb1eb93f8f2a2167efeb535455cf74.camel@linux.intel.com>
 <CAJZ5v0hFOA97FAq=CwGXgXTkC8aS_vyHjXuaFUppXktrG62H6w@mail.gmail.com>
 <61b3d3720ac4bfd1fc8b7dcd09f58dd5a2de3cca.camel@linux.intel.com>
 <CAJZ5v0hbiuvvP_HKnP5m0TBwGsN2-=32bMXTRUUanc4cFRJKwQ@mail.gmail.com> <aad6d76a4a1bc986cb4187e041b9750d98196d80.camel@linux.intel.com>
In-Reply-To: <aad6d76a4a1bc986cb4187e041b9750d98196d80.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Dec 2022 19:54:03 +0100
Message-ID: <CAJZ5v0i6YAyr96z4dDkP4igD67FJsnxrDAGS2Fqr+w=4DNmTvQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] intel_pstate: fix turbo not being used after a
 processor is rebooted
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pratyush Yadav <ptyadav@amazon.de>, linux-pm@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 7:49 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2022-12-27 at 19:47 +0100, Rafael J. Wysocki wrote:
> > On Tue, Dec 27, 2022 at 7:07 PM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Tue, 2022-12-27 at 18:02 +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Dec 27, 2022 at 5:40 PM srinivas pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > >
> > > > > On Tue, 2022-12-27 at 16:38 +0100, Pratyush Yadav wrote:
> > > > > > Hi Srinivas,
> > > > > >
> > > > > > On Sat, Dec 24 2022, srinivas pandruvada wrote:
> > > > > >
> > > > > > > On Fri, 2022-12-23 at 10:10 -0800, srinivas pandruvada
> > > > > > > wrote:
> > > > > > > > Hi Pratyush,
> > > > > > > >
> > > > > > > > On Thu, 2022-12-22 at 11:39 +0100, Pratyush Yadav wrote:
> > > > > > > > >
> > > > > > > > > Hi Srinivas,
> > > > > > > > >
> > > > > > > > > On Wed, Dec 21 2022, srinivas pandruvada wrote:
> > > > > > > > > > On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav
> > > > > > > > > > wrote:
> > > > > > > > > > > When a processor is brought offline and online
> > > > > > > > > > > again,
> > > > > > > > > > > it is
> > > > > > > > > > > unable to
> > > > > > > > > > > use Turbo mode because the _PSS table does not
> > > > > > > > > > > contain
> > > > > > > > > > > the
> > > > > > > > > > > whole
> > > > > > > > > > > turbo
> > > > > > > > > > > frequency range, but only +1 MHz above the max non-
> > > > > > > > > > > turbo
> > > > > > > > > > > frequency.
> > > > > > > > > > > This
> > > > > > > > > > > causes problems when ACPI processor driver tries to
> > > > > > > > > > > set
> > > > > > > > > > > frequency
> > > > > > > > > > > constraints. See patch 2 for more details.
> > > > > > > > > > >
> > > > > > > > I can reproduce on a Broadwell server platform. But not
> > > > > > > > on a
> > > > > > > > client
> > > > > > > > system with acpi_ppc usage.
> > > > > > > >
> > > > > > > > Need to check what change broke this.
> > > > > > >
> > > > > > > When PPC limits enforcement changed to PM QOS, this broke.
> > > > > > > Previously
> > > > > > > acpi_processor_get_platform_limit() was not enforcing any
> > > > > > > limits.
> > > > > > > It
> > > > > > > was just setting variable. So any update done after
> > > > > > > acpi_register_performance_state() call to pr->performance-
> > > > > > > > states[ppc].core_frequency, was effective.
> > > > > > >
> > > > > > > We don't really need to call
> > > > > > >         ret = freq_qos_update_request(&pr->perflib_req,
> > > > > > >                         pr->performance-
> > > > > > > > states[ppc].core_frequency
> > > > > > > *
> > > > > > > 1000);
> > > > > > >
> > > > > > > if the PPC is not changed. When PPC is changed, this gets
> > > > > > > called
> > > > > > > again,
> > > > > > > so then we can call the above function to update cpufreq
> > > > > > > limit.
> > > > > > >
> > > > > > > The below change fixed for me.
> > > > > >
> > > > > > Right.
> > > > > I think, this is the only change you require to fix this. In
> > > > > addition
> > > > > set pr->performance_platform_limit = 0 in
> > > > > acpi_processor_unregister_performance().
> > > >
> > > > Not really, because if the limit is set to a lower frequency and
> > > > then
> > > > reset to _PSS[0], it needs to be set back to "no limit".
> > > >
> > >
> > > If PPC becomes 0 again after ppc > 0 during dynamic PPC change, pr-
> > > > performance_platform_limit will not match current PPC, so will
> > > > set to
> > > PPC 0 performance ( which is already patched by driver after return
> > > from acpi_register_performance_state()).
> >
> > I see.
> >
> > > But fine, you can always set freq qos to FREQ_QOS_MAX_DEFAULT_VALUE
> > > for
> > > PPC 0 as you are doing in your patch.
> >
> > I think that using the "no limit" value to represent the "no limit"
> > condition makes sense.
> Agree.
>
> >
> > Also, I'm wondering if the patching of states[0].core_frequency will
> > still be necessary after this change.
>
> I don't think so. We can remove the patching.

OK, let me cut the patches.
