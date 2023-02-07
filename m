Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1720B68E35E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBGWUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBGWUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:20:01 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E23EC53
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:19:52 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id b18so3047503uan.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 14:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Vyn8HY8vsd2rsre0kd5fD4aVzHSpoMRl6C5sK8M6sM=;
        b=KT6Qz39kMvinn10wtsCHxTbUGJe6JE7+Fp7Zr3D0ljX0h5ROBa1xTuVZ8vcDmUM6fy
         jAJ80JEq+6uDOnYOCpBqLcjymImd88g9AWiwD3h0LzUWR9AlUzUuS1kGTSSR3uR0sJ/v
         xiyVUh+TGxuQgHqD366+IlfBQKEzYWzfbokcAn0SJBmunKStffE4rxH2C0JINpxSJpga
         T4jIG7DtYKgasoyv2Z50BGbhdxq7V9k0vp/MX17BlsXnBebFSRUp9tlOSp5x0xGKt9H8
         sd/G2+pCnBxPTSI0bd9J9cvoJbpTyus8jieFL3DUymwk59Q6pkLhFmOepC41qJ2TVKTC
         RxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Vyn8HY8vsd2rsre0kd5fD4aVzHSpoMRl6C5sK8M6sM=;
        b=EMnAPntpQ8zCdk407fTPYNxLISidGVHoBrxk77e0bhvBYz0sGmjjm8arnFh/+RUwT9
         /gUR4uktgVc3sYNEIMbWYSa5zZk+nJ3VG6TvJmWhY2+Q5qYYESsxoLad2zsNd6VchFOv
         W8kxZ1a+fNvhfgM0XWWwfSdhp05EwQyaFX9ihcEfsBKDTtM2xOzi6kIB4SqE9pSQP43M
         oJWbTbLYZYueuDRBZzOSnYe3wLqTaGiBI2Dr+tKKTuTOFLZsu1u7unMH5pSf5OMYVM2g
         bGyqudOxcYSGbMBLgOoHsaaO0ZTu4GiqoGGpifo89SUVkjVARt+5TKbYgtwf54xhh5Cb
         X26w==
X-Gm-Message-State: AO0yUKWHXg8g4UClMYu63T8QUy7mUn/+spj7T5m6gMBgytJWyNDZX+eL
        DI7a4n/gYEwrkUDwU1T/nk2Fbyxg/qYOZCwqtsVXVg==
X-Google-Smtp-Source: AK7set98YqYgcIQoUZZdGqqr4Xrb2JetbWfTgEKX3PcMLzz4mtJqZH11DpIIZjA7RwI6BtoSiDvRBqx62OExTj7cGNc=
X-Received: by 2002:ab0:3b90:0:b0:683:c74a:af60 with SMTP id
 p16-20020ab03b90000000b00683c74aaf60mr933712uaw.74.1675808391950; Tue, 07 Feb
 2023 14:19:51 -0800 (PST)
MIME-Version: 1.0
References: <Y+K/i4kj0WER1Hl0@google.com>
In-Reply-To: <Y+K/i4kj0WER1Hl0@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Feb 2023 14:19:40 -0800
Message-ID: <CABXOdTc-qqx4GArwUnRK15yLtvrcaCrDvEzqSSA3-WwDbpUFiA@mail.gmail.com>
Subject: Re: [PATCH] HID: retain initial quirks set up when creating HID devices
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Allen Ballway <ballway@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Guenter Roeck <groeck@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 1:16 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> In certain circumstances, such as when creating I2C-connected HID
> devices, we want to pass and retain some querks (axis inversion, etc).

quirks

> The source of such quirks may be device tree, or DMI data, or something
> else not readily available to the HID core itself and therefore cannot
> be reconstructed easily. To allow this introduce "initial_quirks" field

this, introduce (says gmail)

> in hid_device structure and use it when determining the final set of
> quirks.
>
> This fixes problem with i2c-hid setting up device-tree sourced quirks

fixes the problem (again, says gmail)

> too late and losing them on device rebind, and also allows to sever the
> tie between hid-code and i2c-hid when applying DMI-based quirks.
>
> Fixes: b60d3c803d76 ("HID: i2c-hid-of: Expose the touchscreen-inverted properties")
> Fixes: a2f416bf062a ("HID: multitouch: Add quirks for flipped axes")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Compiled only, not tested on hardware.
>
>  drivers/hid/hid-quirks.c                 | 8 +-------
>  drivers/hid/i2c-hid/i2c-hid-core.c       | 6 ++++--
>  drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 1 -
>  include/linux/hid.h                      | 1 +
>  4 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 30e35f79def4..66e64350f138 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -19,7 +19,6 @@
>  #include <linux/input/elan-i2c-ids.h>
>
>  #include "hid-ids.h"
> -#include "i2c-hid/i2c-hid.h"
>
>  /*
>   * Alphabetically sorted by vendor then product.
> @@ -1238,7 +1237,7 @@ EXPORT_SYMBOL_GPL(hid_quirks_exit);
>  static unsigned long hid_gets_squirk(const struct hid_device *hdev)
>  {
>         const struct hid_device_id *bl_entry;
> -       unsigned long quirks = 0;
> +       unsigned long quirks = hdev->initial_quirks;
>
>         if (hid_match_id(hdev, hid_ignore_list))
>                 quirks |= HID_QUIRK_IGNORE;
> @@ -1299,11 +1298,6 @@ unsigned long hid_lookup_quirk(const struct hid_device *hdev)
>                 quirks = hid_gets_squirk(hdev);
>         mutex_unlock(&dquirks_lock);
>
> -       /* Get quirks specific to I2C devices */
> -       if (IS_ENABLED(CONFIG_I2C_DMI_CORE) && IS_ENABLED(CONFIG_DMI) &&
> -           hdev->bus == BUS_I2C)
> -               quirks |= i2c_hid_get_dmi_quirks(hdev->vendor, hdev->product);
> -
>         return quirks;
>  }
>  EXPORT_SYMBOL_GPL(hid_lookup_quirk);
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 0ab8f47a84e9..efbba0465eef 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -1025,6 +1025,10 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
>         hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
>         hid->product = le16_to_cpu(ihid->hdesc.wProductID);
>
> +       hid->initial_quirks = quirks;
> +       hid->initial_quirks |= i2c_hid_get_dmi_quirks(hid->vendor,
> +                                                     hid->product);
> +
>         snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X",
>                  client->name, (u16)hid->vendor, (u16)hid->product);
>         strscpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
> @@ -1038,8 +1042,6 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
>                 goto err_mem_free;
>         }
>
> -       hid->quirks |= quirks;
> -
>         return 0;
>
>  err_mem_free:
> diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> index 554a7dc28536..210f17c3a0be 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> @@ -492,4 +492,3 @@ u32 i2c_hid_get_dmi_quirks(const u16 vendor, const u16 product)
>
>         return quirks;
>  }
> -EXPORT_SYMBOL_GPL(i2c_hid_get_dmi_quirks);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index daaac4d7f370..56dac09c99d9 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -622,6 +622,7 @@ struct hid_device {                                                 /* device report descriptor */
>         unsigned long status;                                           /* see STAT flags above */
>         unsigned claimed;                                               /* Claimed by hidinput, hiddev? */
>         unsigned quirks;                                                /* Various quirks the device can pull on us */
> +       unsigned initial_quirks;                                        /* Initial set of quirks supplied when creating device */
>         bool io_started;                                                /* If IO has started */
>
>         struct list_head inputs;                                        /* The list of inputs */
> --
> 2.39.1.519.gcb327c4b5f-goog
>
>
> --
> Dmitry
