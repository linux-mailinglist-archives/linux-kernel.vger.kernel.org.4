Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFCF745EDD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGCOoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjGCOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BF0E76
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688395399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tzP/Plg9Kd3biRQs2SODGsYGbG5ASH0tovc9ug5MNhw=;
        b=VpCFKeaPGQ2OV+vOvR7CNOC919n+FEPv7NnLlzpHglmZp991raeUhDImbUQV7xp4sLnhd+
        sDvVk1H2IyQRBnWtOLPB3hF+3mSrCT9e/1cIBfgMuY9ujjQ7dU4d59wf+4No1u1j1h10NC
        qua2hCqW67eoFFmXjD07hbOD0rS1F+o=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-DPQ09DuIOQmEXx4QnyS1eQ-1; Mon, 03 Jul 2023 10:43:18 -0400
X-MC-Unique: DPQ09DuIOQmEXx4QnyS1eQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-c4cda9d3823so1212866276.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 07:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688395397; x=1690987397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzP/Plg9Kd3biRQs2SODGsYGbG5ASH0tovc9ug5MNhw=;
        b=Sklx1gWq6pHfRjg81gXu0b+2QkSjxgHagzLdlTOpIRlhqIyydNc8m+RY/U5Gkb0rqZ
         2QtS5bLHs/v9GtEXZYxWO+Z4se+3Q9vvn0qy7AA1CiNO/LI0RLcRzECAa5Zqt90pg+PB
         Qf4ocQX4TngGXH9kez0Q5Z/3XbNL2kFoaiXBXS+6W0J0udf6qERns/JqLy5pfiUXt+1O
         bAxIba9It5TtrnpCV+kDTntwNh4LySX+WtxJpQ54F3kO4+U7ts0iAShHDWpZ9cMz5tiL
         C/2tAnRAmu2C8yoJsM6/qPFVpIzUbLudpVNFPPHMxbA+3ttl26z+NHclqaDRJgNLG0z/
         kEAg==
X-Gm-Message-State: ABy/qLbD1IuxZueOAXK5Zg0OBRTWk6QHjstSYn4SqPCAY0yzC2NRIZhh
        9HLgWN69g5cqAIbO0Hb0SZbZwOzB2zuzxGPlxOVZVRyIcrtGIc5z6lKr1VJz90UQiShm3Fe7Q7R
        Kyh/+cUdLW1fNVyZrPz0/RjaqIwr0Q48UjXVdFEmv
X-Received: by 2002:a25:ad9f:0:b0:c1c:9285:64c2 with SMTP id z31-20020a25ad9f000000b00c1c928564c2mr9966294ybi.50.1688395397127;
        Mon, 03 Jul 2023 07:43:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGCQQpzfRWKboYAWmxpXD+LbZ09ETqoiyarcSt7iwOa5Mw6E+/3mX9L+rVpFYwf57ZUBogxHuQCd+q4fTcISvE=
X-Received: by 2002:a25:ad9f:0:b0:c1c:9285:64c2 with SMTP id
 z31-20020a25ad9f000000b00c1c928564c2mr9966248ybi.50.1688395396315; Mon, 03
 Jul 2023 07:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com> <20230703142308.5772-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230703142308.5772-3-andriy.shevchenko@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 3 Jul 2023 16:43:05 +0200
Message-ID: <CAO-hwJ+HPLe3XQuGtbZT2wky4wMRpR2kVWj3-euCrrQRkpoVBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpiolib: acpi: Don't use GPIO chip fwnode in acpi_gpiochip_find()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 4:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> GPIO library should rely only on the GPIO device's fwnode.
> Hence, replace GPIO chip fwnode usage by respective handle
> of the GPIO device.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  drivers/gpio/gpiolib-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 97496c0f9133..fbda452fb4d6 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -128,7 +128,7 @@ static bool acpi_gpio_deferred_req_irqs_done;
>
>  static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
>  {
> -       return ACPI_HANDLE_FWNODE(gc->fwnode) =3D=3D data;
> +       return device_match_acpi_handle(&gc->gpiodev->dev, data);

Quick confirmation that using "device_match_acpi_handle" also works in
v2 (was easy enough to test given that everything was already set up
locally).

Cheers,
Benjamin

>  }
>
>  /**
> --
> 2.40.0.1.gaa8946217a0b
>

