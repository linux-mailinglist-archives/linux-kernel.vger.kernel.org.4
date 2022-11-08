Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6E062177A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiKHOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiKHOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:54:19 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010FA43849;
        Tue,  8 Nov 2022 06:54:17 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id x13so10366519qvn.6;
        Tue, 08 Nov 2022 06:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QF12oZt8AZ44/sdT+3QD1AGRv3vT5XnqG2NmIMvCMaw=;
        b=8Mob5Apdy2I0+S5WmtQGynQ2oQ2420U9zneAhvlJ+Q9He3aMpwgyu1nIwKU9QKAPXP
         ehr/BiWPi6FfaJupCo7vBSxa1ccpzTsHrJhNGUn5Ebd4hObOsu8TMRFyCmd+l1IteG6d
         owDax5cd9B+gWoaHkKz1WBEKs4zP3/S2H5ocTv8ROKomzZfAYX7a4T2fWVrt4cwEzKVl
         yUFlzHy0j6LwMUJpu23XpY6OuxZjI1YZ1dcKVvkvO8ZAbsDpj8coR9xS9+K050seldFC
         POSPyUB7MOzOgfYJZCe2VFcvT+8ym2oD4MwuTLzNtdc+XaSwGnCIVsr3nKwF00hWA/sN
         M49A==
X-Gm-Message-State: ACrzQf1h/cIwFYQ4kh2QKTiOtnLrfyMkIp+Vt8uLYjnWhEWEAA7t13Eu
        aa4FJjWKMD/uM6J0seIWlyUuKGVE2GgT57cdIIc=
X-Google-Smtp-Source: AMsMyM7GtWyaiX2oLjca/bNy3xuAt3+ZcvrX8C8jVXQBaDZP9TLtB6uEYX98TnhmfHqefXV6eqOyRQfkIkEImBP6fMU=
X-Received: by 2002:a05:6214:f63:b0:4b8:c0bc:c43e with SMTP id
 iy3-20020a0562140f6300b004b8c0bcc43emr49934995qvb.119.1667919257095; Tue, 08
 Nov 2022 06:54:17 -0800 (PST)
MIME-Version: 1.0
References: <2276401.ElGaqSPkdT@kreacher> <2219830.iZASKD2KPV@kreacher> <Y2l2hid1SSAzpKhS@smile.fi.intel.com>
In-Reply-To: <Y2l2hid1SSAzpKhS@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Nov 2022 15:54:06 +0100
Message-ID: <CAJZ5v0gnRNe+k2BEJGnJiWHmWTyb0cxgZ9pMLwMUtU2f=VJv2Q@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] rtc: rtc-cmos: Disable ACPI RTC event on removal
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 10:21 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 07, 2022 at 09:03:06PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make cmos_do_remove() drop the ACPI RTC fixed event handler so as to
> > prevent it from operating on stale data in case the event triggers
> > after driver removal.
> >
> > While at it, make cmos_do_remove() also clear the driver data pointer
> > of the device and make cmos_acpi_wake_setup() do that in the error path
> > too.
>
> ...
>
> > +     dev_set_drvdata(dev, NULL);
>
> > +     dev_set_drvdata(dev, NULL);
>
> Maybe I'm missing something, but the cmos_do_remove() is called by ->remove()
> callback of the real drivers (pnp and platform) and device core is already
> doing this. So, don't know why you need these calls to be explicit.

Good point, but then I guess I should move this patch to the front,
because the issue fixed by it may trigger a use-after-free in
rtc_handler() already.
