Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A9D67CA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjAZLrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbjAZLrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:47:02 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6966186B;
        Thu, 26 Jan 2023 03:47:01 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id tz11so4482895ejc.0;
        Thu, 26 Jan 2023 03:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9Sv/U04GTNhxvBRrEVrJ5dGzAGJNH/2ysR/99C8XrA=;
        b=zbxHnJ4c0QjoLfRM+tMM2CgND2Iu0A5DcRwpO7l9McKZtxcrsu9rFp0OE4V5J/lUWH
         uD8mBSc9WUUNqZ/zFpWCSHbONvZuVPH9SMH9k4A854jpXa25NHeQ+NC+uEEROY5aWzsY
         ixRuQuOp0ToJg62sEiQLvH1C3qsfAQcItJPC5G7F45H6ho4O9ynv0PfFIHWD5Bd2aqhq
         PsJafrRmoKKLkopouGk90gYJsntHcRRI0nG/1JngJ0NQHb9ZdNfe3t065we/x+fXUv1u
         dq1sNKnEhNLGIDj44hFVqrsVonlBJd9v20H9ImvsGH9gmVN92WmEIjhXEI0KefWdJmuL
         nV6w==
X-Gm-Message-State: AFqh2kqkNcTdyZlrOC4skw3ZzuKMKmKfVnbZApBUQO2ynuYncMX7e4QY
        S0gCfkXalgRl4hvEixir7NLNDETLW0F1f5m9AFI=
X-Google-Smtp-Source: AMrXdXsXgy6uQFLB2yLQXFf2/ydUxFWdJeiOiuQh69m6vZhaXuMkPDZlv84/gLX3hnKGoElwZfWdfmnvLpaI1oQl6Is=
X-Received: by 2002:a17:907:c928:b0:85e:4218:c011 with SMTP id
 ui40-20020a170907c92800b0085e4218c011mr4139261ejc.258.1674733620252; Thu, 26
 Jan 2023 03:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20230116162522.4072-1-ubizjak@gmail.com> <CAJZ5v0j7i0FG_ivX1xhTPutJOXb8nZEv7kq+TTOCjynts9049w@mail.gmail.com>
 <Y9Jagh6eOEkcudL4@gmail.com>
In-Reply-To: <Y9Jagh6eOEkcudL4@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jan 2023 12:46:46 +0100
Message-ID: <CAJZ5v0jyuGhWGY=2BuppOsGYNBS7Ct==mMqn6NKNibuuKvvLMA@mail.gmail.com>
Subject: Re: [PATCH] x86/ACPI/boot: use try_cmpxchg in __acpi_{acquire,release}_global_lock
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, linux-pm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:48 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> > On Mon, Jan 16, 2023 at 5:25 PM Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> > > __acpi_{acquire,release}_global_lock.  x86 CMPXCHG instruction returns
> > > success in ZF flag, so this change saves a compare after cmpxchg
> > > (and related move instruction in front of cmpxchg).
> > >
> > > Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> > > fails. There is no need to re-read the value in the loop.
> > >
> > > Note that the value from *ptr should be read using READ_ONCE to prevent
> > > the compiler from merging, refetching or reordering the read.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > but please CC linux-acpi on all ACPI-related changes in the future.
>
> Thanks Rafael - I'll take this patch through the locking tree, if that's
> fine with you.

It is, thanks!
