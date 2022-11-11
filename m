Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E536263CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiKKVtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiKKVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:49:48 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838641209B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 13:49:44 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id t85so2389323vkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 13:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQe9Rl0ntHWxnBIoBGUVK2ikzJQDNUS44KuK47v5LQ0=;
        b=ASo2fQdU1R5SGlqvh2778YJxBgGzjoRjtCg96anIwCoUTkeBSmZ+zsFCLPZ5sc3QRX
         GqxX+VqAp1UJTtYSboyCX2tGCGPTVf3q4ex6pmQPTsRRxFabKEs9wv0i2uw5pTgPqK83
         2xtLF+iMG/sTY+xdgnpABK8nB6ZxTj7JBa+Sq91buskoui2ADFlKjQhzYWK5ZRAzxkYB
         N/m6mbMbRtmw4GcEtSZcCKtbl9nghsnzA5k0NxjTGE84AhZJi3TbyQDnth4QRif9psbw
         Y7Op8lnk6Y9+/VL6/DLGGpXJFtJUb8gGTqz3knOSjPy966QRtOXad/13D6S/YJh8SGhK
         xtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQe9Rl0ntHWxnBIoBGUVK2ikzJQDNUS44KuK47v5LQ0=;
        b=mJaK98ZTf37/u2dwSQa9P5K+Rvv3FCEFVaHO9k6azBQ+cBwNoAq4St6GpP9935QQGz
         NczuqlY5pViBTYvL2ZDXDnl1IAtwdQiFRPZSpR3mJOobuoSBB6sPg8B7aDzj9dFsGRLR
         lu+GRXRu1gddCzfp6vFXy0ZAlNW8Uoqn+ETe5MwGaj1GnGaArCqOPmUSdmQoEZ0NDQ+X
         k/wm3BsGuPQ8pZyyGfoPXXzECxY6KMOU3SRaiARBYiY/Jb9ukfiDwEneu2jD+XUqx0LM
         AS5UOVWaRslGoXp0AWIZXJwzEKoe+g5xAW3So5NY0FLXhLevCEUlFGV7kANXWNYaOSNb
         j3YQ==
X-Gm-Message-State: ANoB5pnLd9EMCdHpmtCq6auMs46pdGTFYit7haZgRH9ZPbNKULCbcjjL
        gc/FFSOF9gDDm4+rOnMIgk62zBbkGyZ2orFOcTvCdg==
X-Google-Smtp-Source: AA0mqf7hijeZDy7D0tTNP/dNdqfMqZ4zGiXEysQYgXwv5ybXd2J5PoePUWEhFT9OJVOqnS1K5jMxny/mvP3iy1vSCnU=
X-Received: by 2002:a1f:27c6:0:b0:3ab:85c0:e1e8 with SMTP id
 n189-20020a1f27c6000000b003ab85c0e1e8mr2247698vkn.1.1668203383626; Fri, 11
 Nov 2022 13:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
In-Reply-To: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 11 Nov 2022 22:49:32 +0100
Message-ID: <CAMRc=Mc-obd_8HiZamirE2YP+VruALFQ5Rp1f4YNVsRqZUC-tw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for software nodes to gpiolib
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 8:30 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> This series attempts to add support for software nodes to gpiolib, using
> software node references. This allows us to convert more drivers to the
> generic device properties and drop support for custom platform data.
>
> To describe a GPIO via software nodes we can create the following data
> items:
>
> /* Node representing the GPIO controller/GPIO bank */
> static const struct software_node gpio_bank_b_node = {
>         .name = "B",
> };
>
> /*
>  * Properties that will be assigned to a software node assigned to
>  * the device that used platform data.
>  */
> static const struct property_entry simone_key_enter_props[] = {
>         PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
>         PROPERTY_ENTRY_STRING("label", "enter"),
>         PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
>         { }
> };
>
> The code in gpiolib handling software nodes uses the name in the
> software node representing GPIO controller to locate the actual instance
> of GPIO controller.
>
> To: Linus Walleij <linus.walleij@linaro.org>
> To: Bartosz Golaszewski <brgl@bgdev.pl>
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
>
> ---
> Changes in v3:
> - Addressed more Andy's comments
> - Link to v2: https://lore.kernel.org/r/20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com
>
> Changes in v2:
> - reworked the series to be independent of other in-flight patches.
>   That meant keeping devm_gpiod_get_from_of_node() for now.
> - removed handling of secondary nodes, it deserves a separate patch
>   series
> - fixed refcounting when handling swnodes (Andy)
> - added include/linux/gpio/property.h with PROPERTY_ENTRY_GPIO (Andy)
> - addressed most of the rest of Andy's comments
> - collected reviewed-by and acked-by
> - Link to v1: https://lore.kernel.org/r/20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com
>
> ---
> Dmitry Torokhov (6):
>       gpiolib: of: change of_find_gpio() to accept device node
>       gpiolib: acpi: change acpi_find_gpio() to accept firmware node
>       gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes
>       gpiolib: acpi: avoid leaking ACPI details into upper gpiolib layers
>       gpiolib: consolidate GPIO lookups
>       gpiolib: add support for software nodes
>
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpiolib-acpi.c   | 132 +++++++++++++++-----------
>  drivers/gpio/gpiolib-acpi.h   |  54 +----------
>  drivers/gpio/gpiolib-of.c     |   7 +-
>  drivers/gpio/gpiolib-of.h     |   4 +-
>  drivers/gpio/gpiolib-swnode.c | 123 +++++++++++++++++++++++++
>  drivers/gpio/gpiolib-swnode.h |  14 +++
>  drivers/gpio/gpiolib.c        | 209 ++++++++++++++++--------------------------
>  include/linux/gpio/property.h |  11 +++
>  9 files changed, 315 insertions(+), 240 deletions(-)
> ---
> base-commit: b6fc3fddade7a194bd141a49f2689e50f796ef46
> change-id: 20221031-gpiolib-swnode-948203f49b23
>
> --
> Dmitry
>

Hi Dmitry,

What are the prerequisites of this series as it doesn't apply to my
gpio/for-next branch?

Bart
