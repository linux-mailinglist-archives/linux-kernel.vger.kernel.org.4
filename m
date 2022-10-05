Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7A25F4D48
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJEBKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJEBKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:10:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB0E6DF8D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 18:10:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso228870wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 18:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vTtrZ5c58j0WZSj98SnKiN3CQ0KpqQiGa+HkG23eQ24=;
        b=Bg9O0HbmZ3imZTMmU16zgGU++dJLyfLlKUwtU1VSK+lHxLt8i0S/oghO8TQZuLZvb0
         UvAebMScWcN1GmILBzE2lPewB43O78oxQhjxZseelYzXslgsR/eHsHu6AIr4vsvF+w5j
         Zx0WLg5qqOf4orI6DdgtgEi/YmGmmY1igH2/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vTtrZ5c58j0WZSj98SnKiN3CQ0KpqQiGa+HkG23eQ24=;
        b=FJMXD0A2o9yUTzlgmOvqctvkH7BYTwk2KHIIl+QcaeqQry4dGXAgN3RPQRsQkY5rbQ
         0pb8N442bAySucci8ohdWXj94qiVXX353zT4D4Z7opDB8F3ieZGv4ofjztLJc5LQZSo1
         cOd1TgNInesy3ipKrGWdbH5yz1hJnxODRxQHEhTmtkK/MzcolMHsAaHHJN498WvJuICE
         lIBbiDn/q0kXxiDXZmwaruVTP0EnpVRrQuG5N/M0vrN4o5ScIrzw+BBvn+nGRA2S6omt
         YlqQsiRhJp08yiNfmpa/kaxNB1YTheCPkqh6Ne89wMnRJ9dUWAQzbmmwl7Ihib4U+q17
         DAZg==
X-Gm-Message-State: ACrzQf0+VXA+vdn/qTVGPq1MsWJU7YTKwu04oimCdZpH0p2ynGOu9npj
        kvJkw4soAQRBdAl3DhWrqaDv2bAzsaJl3jwBPoNsrQ==
X-Google-Smtp-Source: AMsMyM6jTum8U8UoTF+9TnQxxOV4RbGrGDfRAfKFR/zFXELeEqrkWJ9v6yu8fiJYCSBLVQcL3ZL18jHKrtyC9WtX4qs=
X-Received: by 2002:a05:600c:5490:b0:3b4:8db0:54d7 with SMTP id
 iv16-20020a05600c549000b003b48db054d7mr1579961wmb.62.1664932212925; Tue, 04
 Oct 2022 18:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221004003811.4075765-1-jrosenth@chromium.org>
 <Yzvz9hn1G8rU4VaO@kroah.com> <Yzxl2oczTtwEvIqt@chromium.org>
 <Yzxsu2Ms43eTfOYR@kroah.com> <Yzy6KNUHFqxWZb9U@chromium.org>
In-Reply-To: <Yzy6KNUHFqxWZb9U@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 4 Oct 2022 18:10:01 -0700
Message-ID: <CAODwPW-7Y_CbCch+Y5unH3yJD1T=3epYvqja6w_CB-23C9x9sw@mail.gmail.com>
Subject: Re: [PATCH v12] firmware: google: Implement cbmem in sysfs driver
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Then how does the kernel know what to print out?  Why not add such a
> > reference somewhere?
>
> The kernel really doesn't need to know the list of possible ids: it
> simply reads what coreboot gives it from the coreboot tables and proxies
> that on up to sysfs nodes.
>
> In an earlier version of this patch
> (https://lore.kernel.org/chrome-platform/CAODwPW-JzXXsEANaS+6n695YqriAQ0j0LXm31R2u1OP3MhX9Uw@mail.gmail.com/T/#u),
> I actually had this list so that the directory names were human-readable
> instead of using the 32-bit CBMEM id, but Julius didn't like it citing
> that we'd have to keep the kernel tree and the coreboot tree in sync.
>
> I'm fine with either solution ... just want to make all parties happy
> here =)

There is quite a long list of possible IDs (79 at the current count),
many of them are just coreboot-internal implementation details for
specific platforms that are really not interesting to the running OS
after we're done booting, and new ones get added all the time. I don't
think there's any practical value in trying to maintain a
corresponding list in the kernel, it would just be unnecessary bloat
and a maintenance nightmare to keep in sync.

This whole driver is supposed to be a thin bridge between coreboot and
coreboot-specific userspace tools. Those tools will know about the
specific meaning of individual IDs and the data format of their
contents, and they are much easier to keep updated and in sync with
new coreboot releases than the kernel itself. So the whole goal of the
design is to leave all those details to the userspace tools and have
the kernel involved as little as possible, just passing the raw
information through without being involved in its interpretation.
