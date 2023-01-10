Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35750664128
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbjAJNEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbjAJNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:04:02 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B3352767;
        Tue, 10 Jan 2023 05:04:01 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id jo4so28425786ejb.7;
        Tue, 10 Jan 2023 05:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U62Sr3DmpbCpRGWuqrj+WavjeQmNeJPc3umPZoIz79Y=;
        b=gGnyh1l6HY+Oda8WTtdaCNybRJzIn6JEVZ2H0zAtaV7khRsAz3FyZYZj2jmGLcdLmm
         hOH/kViVULndT0gSg7ikLcEzXnlRdZosfQoSD55fMK+kqClwePOmXgSKHEWDofzcb3WT
         KhluzslSz+Fd1uOd7wQ9HCKPbT8GXUq6ShA1tbuDV6OBMbLzJ39Zl/dDF3wyclBLG8mr
         YA97ec6WvnuWJQqxIfW1WITG66IG/SRzL3UXq7vd/uGUFC7GxOetXeUnlGQk6/JoHHaY
         d2TnjSbKgIOfqmflW4Lc495/Bs7iHysZYznvPxgRYjdFo6fUAbUoh04Y+I1rIPkBvW5l
         ZHxA==
X-Gm-Message-State: AFqh2kqCjNqDbUhQQT+kz0zGY44x7WOlk7MdQ7KSQojg6OyXlKB1jQAa
        YIL0/P10Qzy1CR4abXYH2pLimJLXLKAkk1EpS7k=
X-Google-Smtp-Source: AMrXdXuF4rXBNY4fahxauXG8YvbaAnO3qDtRIPNikdKA5RHQbXb4FCbep2+4Nkb1ts1OV9ptSFa0znU1aG2+R35fo1M=
X-Received: by 2002:a17:907:29c3:b0:84d:4b8e:efc with SMTP id
 ev3-20020a17090729c300b0084d4b8e0efcmr450215ejc.390.1673355839925; Tue, 10
 Jan 2023 05:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20230105041059.39366-1-kvijayab@amd.com> <CAJZ5v0g1Mu8ip68one_gsAR3xmyua+6m1uJqb3n92xxYWeR+FA@mail.gmail.com>
 <Y7dNjHXJJwzCtYOY@zn.tnic>
In-Reply-To: <Y7dNjHXJJwzCtYOY@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 14:03:48 +0100
Message-ID: <CAJZ5v0iq1_kSOXuBcteXrCJR0NyyBVXcio_L=47oKrACT1oaZQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/acpi/boot: Do not register processors that cannot
 be onlined for x2apic
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Borislav Petkov <bpetkov@amd.com>,
        Leo Duran <leo.duran@amd.com>
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

On Thu, Jan 5, 2023 at 11:22 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 05, 2023 at 06:09:59PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 5, 2023 at 5:11 AM Kishon Vijay Abraham I <kvijayab@amd.com> wrote:
> > >
> > > Section 5.2.12.12 Processor Local x2APIC Structure in the ACPI v6.5
> > > spec mandates that both "enabled" and "online capable" Local APIC Flags
> > > should be used to determine if the processor is usable or not.
> > >
> > > However, Linux doesn't use the "online capable" flag for x2APIC to
> > > determine if the processor is usable. As a result, cpu_possible_mask has
> > > incorrect value and results in more memory getting allocated for per_cpu
> > > variables than it is going to be used.
> > >
> > > Make sure Linux parses both "enabled" and "online capable" flags for
> > > x2APIC to correctly determine if the processor is usable.
> > >
> > > Fixes: aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
> > > Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> > > Reported-by: Leo Duran <leo.duran@amd.com>
> > > Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Are you saying, I should take it through tip?

Works for me either way.

Just please let me know if I need to take care of it. :-)
