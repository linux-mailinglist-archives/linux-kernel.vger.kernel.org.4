Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989F55F5D36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJEX1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJEX1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:27:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DBA844F6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:27:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u10so151016wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 16:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QK9Ffo7noBOOh68pwr2VdWG30paSM0HTeytlJI3ponQ=;
        b=X9cU4nMrm7TIMWhG4EGG2kJdfwvMNeHdgPmMiXncsa7X2+uTXPuygqXzWmK0IeSqM/
         BaybWEoyEEeZB4QjL7geXkScLmUx564HUYiv6dbK9cIiGW1Wgrfj2U8tzeBK9vKFIQGl
         y+/OkP8BJ9icwnMBiO7Yn9lAB2k/GT1eEgtJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QK9Ffo7noBOOh68pwr2VdWG30paSM0HTeytlJI3ponQ=;
        b=vT8UtbHOhKgZ3vrsBqK5x9cMXlBUgGQx9k7ntTJNvtptgxO1fIARcyfZ+xKPD96Ikm
         gnm984941IiRUTpkmaywGAaEWr3vKtor6FNLA+D2xfCsrvsnRIeTPlK0P9eaVhh+36X0
         ywPo5PYYDPCdV5LYrNFE2wiguVrQbPFhqrZ83P+jXK6ZVjWxwCEECHJ+IzXs8oqzgcjJ
         zD1JYrLpDMoz92jSKrufh9fqAmBxg6xxXrx6Y8/i7oX046HNPuYorYNGeft9FQUI2b9H
         Xmz3sGXXgcf5O/Zibm2yEhnb1ZUcj4IUBuWHTwtTcRgSrBE7DPP1q7Bvt8lwOtNTh6aY
         O+OA==
X-Gm-Message-State: ACrzQf3KhuCrdF7aPACY0FS4+Ww1Ah56/8dPxiIV7xwXquds8hffUYwm
        zdXM8xMD6XMcgGFQSrGAQQB5QxMR7hsJnQXcrqwIiQ==
X-Google-Smtp-Source: AMsMyM6mp6fKFkJ2vplYvf78dCTCXwCG8epih4Xm6z/FouJvLVmg01VxhT6Xry4RKpOb9g04BFLD4gGbHeF5/pC53uE=
X-Received: by 2002:a5d:4a06:0:b0:22e:3e36:d7e7 with SMTP id
 m6-20020a5d4a06000000b0022e3e36d7e7mr1206969wrq.410.1665012427627; Wed, 05
 Oct 2022 16:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221004003811.4075765-1-jrosenth@chromium.org>
 <Yzvz9hn1G8rU4VaO@kroah.com> <Yzxl2oczTtwEvIqt@chromium.org>
 <Yzxsu2Ms43eTfOYR@kroah.com> <Yzy6KNUHFqxWZb9U@chromium.org>
 <CAODwPW-7Y_CbCch+Y5unH3yJD1T=3epYvqja6w_CB-23C9x9sw@mail.gmail.com> <Yz0jVbfDOITZfE9M@kroah.com>
In-Reply-To: <Yz0jVbfDOITZfE9M@kroah.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 5 Oct 2022 16:26:55 -0700
Message-ID: <CAODwPW8R2uXFJ_5V737Dy8z-WJHUwKkLyG4MW_Q50fs-OFm7Sw@mail.gmail.com>
Subject: Re: [PATCH v12] firmware: google: Implement cbmem in sysfs driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>
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

> If the kernel is reporting a value, that value needs to be documented
> somewhere.  If the kernel is acting on that value, it needs to know what
> those values are.
>
> In this specific instance it seems that the kernel knows a subset of the
> values, and some random userspace tool knows all of them?  Think about
> what you would want to see here if you knew nothing about this at all.

The kernel doesn't know any of the values. The kernel is just telling
userspace that spaces with these IDs exist and providing an interface
to access them, it's not supposed to know what any of them mean.

In terms of what you'd want to see in the documentation, I think what
Jack's patch provides is already the best solution? We're referring to
the definitions in the coreboot source tree as the source of truth for
exact details about what each of these IDs mean. Do you want that
documentation to say more explicitly that these are coreboot-internal
data structures exposed for use by coreboot-aware userspace tools and
that their exact meaning and format is only described within coreboot
sources? Or do you want us to put a full link to coreboot's gitiles
page for the file instead of just the file name? Other than that I'm
not sure how we could make this more explicit -- we don't have a big
official documentation page separate from the source code for all
these IDs in coreboot, unfortunately (like I said, some of them a
large and standardized but most of them are small, platform-specific
things for communicating between different firmware stages that don't
need much explanation beyond the source code itself and don't always
have a fixed format).
