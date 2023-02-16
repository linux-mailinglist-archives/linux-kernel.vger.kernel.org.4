Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4A6997D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBPOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjBPOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:49:54 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E994B517
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:49:51 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id v5so482878uat.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ai3CedyoQlPri6k1JjfVKIfsle4h0KNZCUuZJqKd8BA=;
        b=ABED20X7r8NTLeNjt5Z51+7Gc/N0xVn31/dsccxUvfTyUb0ug/tYwQSlqRjO/hRMxW
         DpfZnZa/sB1ij8d3RixcE/bthSpCuld/wGPJvcTdBGswQwDS1aECelXEGYu+lNgcApCZ
         KVajiZYVqU898fh7Q7t/Y4EDuvgMFBzWMTSLSsF23ctOXr9MFn3m/8/y2LEo1FHsyELw
         pqibr9Ng3T709Q37j0c7Z+M5rbkD4vbzVz7HkmX9JbkhELebu7EBl1xUoufA/21yycGl
         c37zljDuDDc6VZj8t1tkizn7x2QhmEWwT5I5Eio1ZUnko1v9pL/DuwPpnkFHQkfEjnXI
         7Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ai3CedyoQlPri6k1JjfVKIfsle4h0KNZCUuZJqKd8BA=;
        b=3N5xi+aflw4Mc3YTKMniQaA4unU2Lhs4s4DN0T+rIHxq/YUWZjwadIqKq6XVvUqbpJ
         SiNuw/hIPtGlR4jL/D8Tqt8n6ErlAiUs2zJmToRUvJN3Ng3gnjSvub46TeZQrCoGMJK6
         Ghv5I+/UaMtHpuSrFKc+uG9eu5lRDdt2/AwA/eJBN/CNRvjK0QRkhq59DdZKD8mWDHwM
         WA9xaUkVZtNmpNZP9EskkEZBsabWY6CoV7XBHPORT2fsGxeRjih5KClFEPKijD+v6Vbn
         JSlcdxHXQUBaPL+QkyOJokkhStABCdP+HOnSZA3JZZzL5zBtTRA4OkkS5hH9k3p4ZFOM
         1f3Q==
X-Gm-Message-State: AO0yUKWQe2N7y3TeSfZu8U6tUKBSk0SjoopMPSytJiH+DCSeSDRjgl2r
        Js2zg61q3l32nNeNM/yIOSTpT8byAGwruGnrEdCHaA==
X-Google-Smtp-Source: AK7set+BNhdSYJr2WYaQ9cpbqWW82KD8HjVkehRodf+B4b/q4fs5NJNHLKdzsG8KjCFtNbWh7brMfL+W+zCINaWgYgI=
X-Received: by 2002:a05:6130:6cb:b0:688:cc78:8662 with SMTP id
 bl11-20020a05613006cb00b00688cc788662mr655873uab.1.1676558990146; Thu, 16 Feb
 2023 06:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20230216141555.116219-1-brgl@bgdev.pl> <Y+5AzMxlTC7X2UsM@smile.fi.intel.com>
In-Reply-To: <Y+5AzMxlTC7X2UsM@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 16 Feb 2023 15:49:39 +0100
Message-ID: <CAMRc=MfmMRUpv8ThWU1hW0pZBFNCoS3ODd23Z6ZZ_yuCo=2GTA@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: fix a memory leak
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 3:42 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 16, 2023 at 03:15:55PM +0100, Bartosz Golaszewski wrote:
> > Fix an inverted logic bug in gpio_sim_remove_hogs() that leads to GPIO
> > hog structures never being freed.
>
> Ha-ha, I stared to this code, and in the head I was "okay, this loop is until
> chip_label is *not* NULL, so should be fine".
>
> At the same time, "! is hard to process", see for example
> 2754435d4c82 ("ACPI / battery: get rid of negations in conditions")
> which I had suggested.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> P.S. But my patch I mentioned looks also good to have, no?
>

I don't think it matters. In fact - I'm not sure if the order was
accidental or not anymore. :( If you want to discuss it further -
please resend it as a regular patch on the list.

Bart
