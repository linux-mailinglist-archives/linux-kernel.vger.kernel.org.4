Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D038F64BB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiLMRgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiLMRgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:36:24 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0874EF6C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:36:23 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-40b40ff39f1so164842637b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zWH9Rf1WxLgRA3W6HfI2ljCk9Kvc5uNgxrRpSNJD+IU=;
        b=N3/KFSQ/8EQ8h6XdAcZH2isNr5jtfZ69Tdc3wAnqnbW8r9rJvAodAfhZjl9MqOxdny
         LaL2emk1ufrBfRul/K1UV0T9twhe3cFekx134/nmWDSXQ+wWNBZhKxs4x7s4pyTl4mLv
         oG3hPxjO+JnKvmb6B7EL1Oken/nOVYI/LDBeC4tEGo+K7UrUx3McsV5H/1e8G2ezzNkd
         a3++2w03W8DHykzga1/TxNQQ1q1/Bhz0NP5Ag5WgI1LMhbNrICpIWr6Z6Oxj0/yRanOS
         UsNIiYL/aWIR316szXGjZTXh91fXt2qV+o45OsYT4KxoazOeIMwL+YhCEJ+9INrYLDvT
         XJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWH9Rf1WxLgRA3W6HfI2ljCk9Kvc5uNgxrRpSNJD+IU=;
        b=za+Q0JX2KZcndggm5jVhpfclL2/mDpipgYTR8zJrqyz4qw/f3VazZh1EatMWYH/wJV
         evkKIVOA+5YXxSyjcK8vIg8qPp5pcBP9esB6FfgKqpviDeu6A9nifufsrop2wWTvqJgR
         w0BS62Qp8AJ1jrEpXxFkWtlJc7Rp9AQhehXbwJQt+iKqd4l8HrP8IvpmEd2fmsnp52XK
         hrtXM+x8ocWLYUUFlM8zDrhzpNyBKa6+lEh9CPnQJi085CG8R5cqCC6lENlFZr1qs54x
         2PgYjqCzBz0NYSnQQUSBzZ+FYvx9VEOEEsUFpImJVmh7V8cYDikcxELw5+PQrQ62dDz2
         mKYw==
X-Gm-Message-State: ANoB5plhV+bIOMgKqJXSXPM8KasHzo9m1YWiauGAIpYd0tqskOTfIyaJ
        Q0CGx1AzLjWFEo6hzV8IRbI5nNl99p+7Etw9yMo=
X-Google-Smtp-Source: AA0mqf7hORT4nIlqfc9hBX50JtzxO7BHDUvAifEiYJ/zw+mGsh1IaM5J0+eAOD+1Tn1pOjHKO+MTttbQ8jdgaMPVykY=
X-Received: by 2002:a81:1110:0:b0:3e9:7e84:29d0 with SMTP id
 16-20020a811110000000b003e97e8429d0mr21989883ywr.256.1670952982293; Tue, 13
 Dec 2022 09:36:22 -0800 (PST)
MIME-Version: 1.0
References: <20221129081542.5890-1-niejianglei2021@163.com> <Y5b7m/aijyJEuyoI@smile.fi.intel.com>
In-Reply-To: <Y5b7m/aijyJEuyoI@smile.fi.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 13 Dec 2022 18:36:11 +0100
Message-ID: <CANiq72=2_RK5qT4jnn8-Q4WA0OFADJrG0pmA+9PnVnP0bnoO3Q@mail.gmail.com>
Subject: Re: [PATCH v3] auxdisplay: hd44780: Fix potential memory leak in hd44780_remove()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jianglei Nie <niejianglei2021@163.com>, ojeda@kernel.org,
        geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 11:00 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Miguel, can this be somehow moved forward?

Thanks for the ping -- queued!

Cheers,
Miguel
