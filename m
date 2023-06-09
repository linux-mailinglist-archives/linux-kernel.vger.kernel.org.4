Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1F472A146
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjFIRdM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Jun 2023 13:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFIRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:33:11 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17072B5;
        Fri,  9 Jun 2023 10:33:10 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f7f67e8f1dso4225875e9.1;
        Fri, 09 Jun 2023 10:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686331988; x=1688923988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W66sGaj6hyj7I9hI8s37hEC4TuOq6Dcl5tyT2vlNHUc=;
        b=fCiiXZFJ2mdQ3e6aYt4wKolFoGlUw/UnaTVLuvBUcNMW41W5TSKX+AwndqyFTbATNe
         JjdQQ9UiEVeAbqI35mcO8wEmBmvGJ2DmvDd2M1mG33qKClSpie1jUdBoEz123InI5Pli
         xkufQyiZvOppLHyllcTR6q89kCf0DlwMSKIYy0QHgSuxzQF7yisp68U1nMlnT55SOyza
         3mlVpiHaqwV7UmbvsYm9Ul2V0lAeGGjDfuI8uNq7HIHaEuMI/nEw6d9UQHrfyfoXPqZl
         BZJTa/+y1zA5FhHGsqtR8CakIVQ4w7PUW7J/aiG2kB+EpoDWOP1GxnFJSziQyRbrfwLD
         hA3Q==
X-Gm-Message-State: AC+VfDxC6mOmAp6a8NrD4QE8Ev5xCJUWF7VDEVI2BtZGdagCaI2WGB/S
        Z429iuSwi3bR6MnkM6xlVjnArtW/o7yo47Riw7s=
X-Google-Smtp-Source: ACHHUZ7OdnbeztyKDTbazhTmoUtoVPPmRqTOaKxkjvnet2gY7x0glFPMXFR1G8doS/gLrTfuic0TFiOEODN56hwi+Ws=
X-Received: by 2002:a05:600c:3843:b0:3f7:1483:b229 with SMTP id
 s3-20020a05600c384300b003f71483b229mr1932651wmr.3.1686331988283; Fri, 09 Jun
 2023 10:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com> <20230609154900.43024-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230609154900.43024-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Jun 2023 19:32:53 +0200
Message-ID: <CAJZ5v0i29u7RUnhatOANBgjdrH4uoWK_8VCHWK2UO7RS8L3H1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: Move ACPI_DEVICE_CLASS() to mod_devicetable.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 5:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The data type of struct acpi_device_id is defined in the
> mod_devicetable.h. It's suboptimal to require user with
> the almost agnostic code to include acpi.h solely for the
> macro that affects the data type defined elsewhere.
>
> Taking into account the above and for the sake of consistency
> move ACPI_DEVICE_CLASS() to mod_devicetable.h.
>
> Note, that with CONFIG_ACPI=n the ID table will be filed with data
> but it does not really matter because either it won't be used, or
> won't be compiled in some cases (when guarded by respective ifdeffery).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or please let me know if you want me to apply this.

> ---
>  include/linux/acpi.h            | 14 --------------
>  include/linux/mod_devicetable.h | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d41a05d68166..640f1c07c894 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -70,19 +70,6 @@ static inline void acpi_free_fwnode_static(struct fwnode_handle *fwnode)
>         kfree(fwnode);
>  }
>
> -/**
> - * ACPI_DEVICE_CLASS - macro used to describe an ACPI device with
> - * the PCI-defined class-code information
> - *
> - * @_cls : the class, subclass, prog-if triple for this device
> - * @_msk : the class mask for this device
> - *
> - * This macro is used to create a struct acpi_device_id that matches a
> - * specific PCI class. The .id and .driver_data fields will be left
> - * initialized with the default value.
> - */
> -#define ACPI_DEVICE_CLASS(_cls, _msk)  .cls = (_cls), .cls_msk = (_msk),
> -
>  static inline bool has_acpi_companion(struct device *dev)
>  {
>         return is_acpi_device_node(dev->fwnode);
> @@ -782,7 +769,6 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
>  #define ACPI_COMPANION_SET(dev, adev)  do { } while (0)
>  #define ACPI_HANDLE(dev)               (NULL)
>  #define ACPI_HANDLE_FWNODE(fwnode)     (NULL)
> -#define ACPI_DEVICE_CLASS(_cls, _msk)  .cls = (0), .cls_msk = (0),
>
>  #include <acpi/acpi_numa.h>
>
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index ccaaeda792c0..486747518aae 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -221,6 +221,19 @@ struct acpi_device_id {
>         __u32 cls_msk;
>  };
>
> +/**
> + * ACPI_DEVICE_CLASS - macro used to describe an ACPI device with
> + * the PCI-defined class-code information
> + *
> + * @_cls : the class, subclass, prog-if triple for this device
> + * @_msk : the class mask for this device
> + *
> + * This macro is used to create a struct acpi_device_id that matches a
> + * specific PCI class. The .id and .driver_data fields will be left
> + * initialized with the default value.
> + */
> +#define ACPI_DEVICE_CLASS(_cls, _msk)  .cls = (_cls), .cls_msk = (_msk),
> +
>  #define PNP_ID_LEN     8
>  #define PNP_MAX_DEVICES        8
>
> --
> 2.40.0.1.gaa8946217a0b
>
