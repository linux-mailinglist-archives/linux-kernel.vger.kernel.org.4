Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAABA67E13F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjA0KPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjA0KPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:15:43 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B757682
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:15:42 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id r10so959024ual.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k0BjRlSRclKXf1VmtMpzRR1oA/s6fAFcFwAGkwCpFmg=;
        b=QYx2SSysfD4y0jORu8Zi0zppjhqvRrqv0W2u4tcSfYRmb2EgAFSfUt2ulEifUkSb12
         NvUz5NdyFKVXuRIN5jlQMTIDxntoQcLh8GvPp+kEFzdI6G2Z+fGh1nmMAs52DTEW/saH
         4xCQT39t1duVAw0uyaI6m3/a4+bBAoZEfdkuxfE2loJkerMQ2MAJYsj7LdKOgOlr5wbj
         VgVv8PcvBr4gZX0pC6nJt1yhz6wZixSOwx3DnkJyy313CWijA6AFN1UV6VcO1TjirB/o
         Tz/N+XKBROyCXrVdl054ajLcJgqrlLef2xqS8liwTXOrGzF5RMh3y6Xf2pHY+DTaDr08
         olUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0BjRlSRclKXf1VmtMpzRR1oA/s6fAFcFwAGkwCpFmg=;
        b=DOQd8PJyjXOC3/rGZakiHFqeEl7Gl0so1c7ZuB5p8r+JTs3+nWC7KOqF9U7JI9GJr0
         qWjiZCQLtI+4rVU03EkHt5OZPW7Cvr2QawoUApoAk4TPQ4CC1PD1lOng2MvSYhl3CKsv
         25v17tPvNBi8d/HbOEnm2okjZNEfFfHBwg1KUPMPe/vOtVnvPBi5xyG1PHybK+ZT5ln6
         pz+Z4uaGgLwHtf9p+tLQ/E14xjAAjmxvcnqIQj8Y1IY/sOiiGv2ynUeRqsBT9U7rrpvc
         7U17154q0VFyJvW59wfwR9RauP8S8l+MCm8whfL/v3UebB3UImA4aN+yYsVYkKSfAaCF
         jfwQ==
X-Gm-Message-State: AO0yUKUi+Tly82kzXKHCk7T1eKUz+xs4D49MeZL9qQNFYCzBhlkqKG4l
        smab69kIPqjZyLOv6kfgwfjpY5YlAFgeZGzZWlcUhg==
X-Google-Smtp-Source: AK7set/A4sNlQUZ6cVD076qa1X0VRa1B4Iil9rYhFm7a19E+zdPj4yv1KpPkYc90veF3a2tesUdcMFJWkxQScw8g3qg=
X-Received: by 2002:ab0:15b0:0:b0:657:6ebc:a2be with SMTP id
 i45-20020ab015b0000000b006576ebca2bemr1205213uae.64.1674814541387; Fri, 27
 Jan 2023 02:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20230126131033.23011-1-ivoshopov@gmail.com>
In-Reply-To: <20230126131033.23011-1-ivoshopov@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 27 Jan 2023 11:15:30 +0100
Message-ID: <CAMRc=MdnfNC1cACq1nZM23fyeFgswj8hgNYk434eueKYSfzrfw@mail.gmail.com>
Subject: Re: [PATCH] tools: gpio: fix -c option of gpio-event-mon
To:     Ivo Borisov Shopov <ivoshopov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 2:11 PM Ivo Borisov Shopov <ivoshopov@gmail.com> wrote:
>
> Following line should listen for a rising edge and exit after the first
> one since '-c 1' is provided.
>
>     # gpio-event-mon -n gpiochip1 -o 0 -r -c 1
>
> It works with kernel 4.19 but it doesn't work with 5.10. In 5.10 the
> above command doesn't exit after the first rising edge it keep listening
> for an event forever. The '-c 1' is not taken into an account.
> The problem is in commit 62757c32d5db ("tools: gpio: add multi-line
> monitoring to gpio-event-mon").
> Before this commit the iterator 'i' in monitor_device() is used for
> counting of the events (loops). In the case of the above command (-c 1)
> we should start from 0 and increment 'i' only ones and hit the 'break'
> statement and exit the process. But after the above commit counting
> doesn't start from 0, it start from 1 when we listen on one line.
> It is because 'i' is used from one more purpose, counting of lines
> (num_lines) and it isn't restore to 0 after following code
>
>     for (i = 0; i < num_lines; i++)
>         gpiotools_set_bit(&values.mask, i);
>
> This patch just restore the initial value of the iterator to 0 in
> order to allow counting of loops to work for any cases.
>
> Fixes: 62757c32d5db ("tools: gpio: add multi-line monitoring to gpio-event-mon")
> Signed-off-by: Ivo Borisov Shopov <ivoshopov@gmail.com>
> ---
>  tools/gpio/gpio-event-mon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/gpio/gpio-event-mon.c b/tools/gpio/gpio-event-mon.c
> index 6c122952c589..5dee2b98ab60 100644
> --- a/tools/gpio/gpio-event-mon.c
> +++ b/tools/gpio/gpio-event-mon.c
> @@ -86,6 +86,7 @@ int monitor_device(const char *device_name,
>                         gpiotools_test_bit(values.bits, i));
>         }
>
> +       i = 0;
>         while (1) {
>                 struct gpio_v2_line_event event;
>
> --
> 2.20.1
>

Queued for fixes with the commit message tweaked.

Bart
