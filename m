Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076C4621782
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiKHOzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiKHOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:55:10 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F65CE1B;
        Tue,  8 Nov 2022 06:55:10 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id cg5so8734495qtb.12;
        Tue, 08 Nov 2022 06:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upVQhf6pWIcHB9R3hepXMqElSmvFn2xXyyNPv5bvdTY=;
        b=aDJty5h6++lsbfctKlaWxFFCExe2kOJH9aLGtlL4su7ELmY9PJ8LjeFDbRuJCaNREY
         uBRkq9CNaN+EgiOFvRXFvNwZ2Hv2J0uW7tFXaDoyCrwZHEtKNP0KmrflzJZvVGmmBrQN
         1xWbtKP3upqFMts3B1RKYpHJCE0mTtnf/ZRxcOa4Eb3pJ6mUZ/xrT2npRE2EreRndqSv
         /1wZ2iMkdaYNldegQQaiSI7rvfkWZ8MQqz05gUEWvWTIaMrCDhhjsrcbznVs1EwRGFE7
         5rYD09izHypvoZP6KW6nVOcjWaONeVTuu9x8Hlup7orzg7H5KsXIsYL5UG3u1nHTq3c6
         k7kw==
X-Gm-Message-State: ACrzQf1xtijge7dyQpzEqzMP/5gnM2Fe/siRHerQzsAmw2U9Z3rbA61a
        xtdzPQ61lQ2BQGNyeyPeqFXwUYxXcK8Xlh/vRd0=
X-Google-Smtp-Source: AMsMyM5ZQc2iucd5JPOSecyTGUine/Ks1jqk4Zr9kkZcrUK1da9BzKDou3F3mzGkANM0SZla+yC+/6m96K833cnE5NI=
X-Received: by 2002:ac8:7d15:0:b0:3a5:449:87c3 with SMTP id
 g21-20020ac87d15000000b003a5044987c3mr43723966qtb.357.1667919309329; Tue, 08
 Nov 2022 06:55:09 -0800 (PST)
MIME-Version: 1.0
References: <2276401.ElGaqSPkdT@kreacher> <2219830.iZASKD2KPV@kreacher> <Y2l4hmXQTiQZssDK@smile.fi.intel.com>
In-Reply-To: <Y2l4hmXQTiQZssDK@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Nov 2022 15:54:58 +0100
Message-ID: <CAJZ5v0j3xwDKJig5OMkW208vxE3a-9_A2v06NDU4HRYpy4gZ5w@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 10:28 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 07, 2022 at 09:03:06PM +0100, Rafael J. Wysocki wrote:
>
> ...
>
> > +static inline void acpi_rtc_event_cleanup(void)
> > +{
> > +     if (!acpi_disabled)
>
> Btw, other functions look like using
>
>         if (acpi_disabled)
>                 return;
>
> pattern. Maybe here the same for the sake of consistency?
>
> > +             acpi_remove_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler);
> > +}
>

Well, it is more lines of code, but whatever.
