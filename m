Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB3C6E46B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDQLox convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjDQLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:44:50 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670C468D;
        Mon, 17 Apr 2023 04:43:53 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94971337b10so94178066b.1;
        Mon, 17 Apr 2023 04:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681731763; x=1684323763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0xbRy2dWY+Ae8oaE0laExl3v3+/apitb+s9bwbmh0o=;
        b=lzipMSXAzZkynpErCFHdhM0x99DhtPxgFJbagdfPXHy0sAfKWqnHHrHEAPMbP6WwWP
         D2ijEzom+/NtlYulBRsQ7srw2xZ48iJFjC6aAKn5Dspw1M4CYc8ndAgaeWWiP3qgxRQ0
         hwwUIrvWmk1Rs9YpeF4RAP7hML8dn8QEGCzGnl9uCrnl53HpvqHUuecBIe7p+e21kuqU
         Qz/o4N0TnCOx2YFlLd36R58UyrdRB7Gc0wTNsclDqc3HYG9wQPlTMTIcpZweSVCEEqCV
         AbRQObPxgsX9w+53nZdXmgOZcnEK6Rhwe4rldNJtjWAXU0ZN+UYwjgQ2PA9zwzaZ+Rtz
         HA1w==
X-Gm-Message-State: AAQBX9cYJBNsmwvPRZAemTSEI8MZkIuxCmTTUxVoE2zVjH55yXe8E4+Y
        u5PIaXhpZ9tIfcpW8KIYcLbyfa0erFp4HCvyvlQ=
X-Google-Smtp-Source: AKy350bt3Bh1m6ing+3dnlcH8T1XzXu8NJhp6jMQip6y5cDD5gRGzvLKvuEJd3Dl7f3lJEEMR8ZNBSvfvZ8vITslh5A=
X-Received: by 2002:a17:906:7a4e:b0:94e:d5d7:67eb with SMTP id
 i14-20020a1709067a4e00b0094ed5d767ebmr8548849ejo.5.1681731762609; Mon, 17 Apr
 2023 04:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230414012346.1946-1-mario.limonciello@amd.com> <8a4f2454-809c-d773-42b2-e62fb057feb2@redhat.com>
In-Reply-To: <8a4f2454-809c-d773-42b2-e62fb057feb2@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Apr 2023 13:42:31 +0200
Message-ID: <CAJZ5v0h9YnitXBZK0SweMtAeaeDcb=mg_PinJfsG5Oc4dCxyMw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Add vendor agnostic mechanism to report hardware sleep
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Box David E <david.e.box@intel.com>, jstultz@google.com,
        pavel@ucw.cz, svenva@chromium.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, Shyam-sundar.S-k@amd.com,
        rrangel@chromium.org, Jain Rajat <rajatja@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:25 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Mario, et al.,
>
> On 4/14/23 03:23, Mario Limonciello wrote:
> > An important part of validating that s0ix worked properly is to check how
> > much of a cycle was spent in a hardware sleep state.
> >
> > The reporting of hardware sleep is a mix of kernel messages and sysfs
> > files that vary from vendor to vendor. Collecting this information
> > requires extra information on the kernel command line or fetching from
> > debugfs.
> >
> > To make this information more readily accessible introduce a new file in
> > suspend_stats that drivers can report into during their resume routine.
> >
> > Userspace can fetch this information and compare it against the duration
> > of the cycle to allow determining residency percentages and flagging
> > problems.
> >
> > Mario Limonciello (4):
> >   PM: Add sysfs files to represent time spent in hardware sleep state
> >   platform/x86/amd: pmc: Report duration of time in hw sleep state
> >   platform/x86/intel/pmc: core: Always capture counters on suspend
> >   platform/x86/intel/pmc: core: Report duration of time in HW sleep
> >     state
> >
> >  Documentation/ABI/testing/sysfs-power | 29 +++++++++++++
> >  drivers/platform/x86/amd/pmc.c        |  6 +--
> >  drivers/platform/x86/intel/pmc/core.c | 17 ++++----
> >  drivers/platform/x86/intel/pmc/core.h |  4 +-
> >  include/linux/suspend.h               |  8 ++++
> >  kernel/power/main.c                   | 59 +++++++++++++++++++++------
> >  6 files changed, 98 insertions(+), 25 deletions(-)
> >
> >
> > base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
>
> Thank you for working on this, this looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> For the series. Since this also touches kernel/power/main.c
> I think it would be best if the entire series is merged
> through the linux-pm tree and I'm fine with the pdx86 bits
> also getting merged through linux-pm.
>
> Rafael ?

That would be fine with me, but I've only got the [1/4].

Mario, can you please resend the series with CCs to linux-pm and with
R-by from Hans?
