Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A858E6775E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjAWH6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAWH6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:58:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2E3113FC
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 23:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674460675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IV8ZFMMB4mH+ho+gOPdoLhJW3vI1K5Tfot07hE5PSj8=;
        b=RGvlwOizCe2DDEp0uhJZpO6c0lF2OPoeRJxDusHq3NgZmWF1D5373b1JQVnHQ0EgnoF6va
        cTjPK7Zrer6okMYaswAcX3vZWZVDy1W21yl4Eze9kl5iuaHT/7O9IOk0gCnT4IezkkD2r8
        sYH+9SjX9KgcL1V++CQ1z3wU0eaHUVc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-e37loOS5Nv-7D5z5NFdWBA-1; Mon, 23 Jan 2023 02:57:54 -0500
X-MC-Unique: e37loOS5Nv-7D5z5NFdWBA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-4faa8f4bfb9so110266187b3.17
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 23:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IV8ZFMMB4mH+ho+gOPdoLhJW3vI1K5Tfot07hE5PSj8=;
        b=aP5Hqy9xKUPi4asK2Zs1yNZiPlwu9abeFunKTMjU9J+vrf/zmwsdXM/x/i/Ktm00xb
         T+6hmvMtM6OB5w25a50xL8gbmFjzCFp5usQXsOm+NryjBZPFtOV9Ag8cR5Rhv+gQAhND
         X6F1nRJYTpLMODvCEBli/e8HrOfhyQfNvmRTf7FDadU0XJI5FOto80wOpSFuRSLW9gh6
         KidJAUtJmR5F4Y4s+fXCioQgf7zoCUDbM/ZNixpG0weG2fGOPlMahARu5AqKjfdcFVju
         KXbjlSbBTYx3wNF7tx5hXOTs+uYITeUa+1GPa5Bn30+QjtBQCctr9WR6EalnkjxiTyWp
         ybug==
X-Gm-Message-State: AFqh2kqF5UosdrtMB+Tq6mum6BJsdLKc47m07/nqEqb1TG+sn7YjH6pa
        M2hKB4kL8io178/8617EnVmuWBo0UA+3UpBXiKdbB3prYdQtEO4XqMtyZlQ2I/gZf/KmTMtr1wR
        5h5SOsyhbpnQi0+6c38Ugu6G26wKz7t/Y+GIW/f5v
X-Received: by 2002:a25:3c87:0:b0:735:ea17:94d9 with SMTP id j129-20020a253c87000000b00735ea1794d9mr2715282yba.378.1674460671513;
        Sun, 22 Jan 2023 23:57:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvztifYU4nljeyBMcDJnvFCZ/MH1s8aB2hNpQ8aHb2o7X/ABYNbvP+oq3Wf6XRcniHaWdGAq/0A1Qp49brCIas=
X-Received: by 2002:a25:3c87:0:b0:735:ea17:94d9 with SMTP id
 j129-20020a253c87000000b00735ea1794d9mr2715278yba.378.1674460671284; Sun, 22
 Jan 2023 23:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20221224121814.11709-1-lephilousophe@gmail.com>
In-Reply-To: <20221224121814.11709-1-lephilousophe@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 23 Jan 2023 08:57:39 +0100
Message-ID: <CAO-hwJJwUQJueutZ5z_4qwBb1Y4+-9h3ta0Xran=s6pJ_e3itQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: evision: Add preliminary support for EVision keyboards
To:     Philippe Valembois <lephilousophe@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 1:23 PM Philippe Valembois
<lephilousophe@gmail.com> wrote:
>
> From: Philippe Valembois <lephilousophe@users.noreply.github.com>

Jiri, I have a doubt. Do we accept emails from users.noreply.github.com?

>
> For now only supports one model and only filters out bogus reports sent
> when the keyboard has been configured through hidraw.
> Without this, as events are not released, soft repeat floods userspace
> with unknown key events.
>
> Signed-off-by: Philippe Valembois <lephilousophe@users.noreply.github.com>
> ---
>  drivers/hid/Kconfig       |  7 ++++
>  drivers/hid/Makefile      |  1 +
>  drivers/hid/hid-evision.c | 79 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 drivers/hid/hid-evision.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index e2a5d30c8..1320ea75c 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -329,6 +329,13 @@ config HID_ELO
>         Support for the ELO USB 4000/4500 touchscreens. Note that this is for
>         different devices than those handled by CONFIG_TOUCHSCREEN_USB_ELO.
>
> +config HID_EVISION
> +       tristate "EVision Keyboards Support"
> +       depends on USB_HID

AFAICT, the driver only uses pure HID API, so you should be able to
depend on HID, not just USB_HID.

> +       help
> +       Support for some EVision keyboards. Note that this is needed only when
> +       applying customization using userspace programs.
> +
>  config HID_EZKEY
>         tristate "Ezkey BTC 8193 keyboard"
>         default !EXPERT
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index e8014c1a2..bd01571dd 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_HID_EMS_FF)      += hid-emsff.o
>  obj-$(CONFIG_HID_ELAN)         += hid-elan.o
>  obj-$(CONFIG_HID_ELECOM)       += hid-elecom.o
>  obj-$(CONFIG_HID_ELO)          += hid-elo.o
> +obj-$(CONFIG_HID_EVISION)      += hid-evision.o
>  obj-$(CONFIG_HID_EZKEY)                += hid-ezkey.o
>  obj-$(CONFIG_HID_FT260)                += hid-ft260.o
>  obj-$(CONFIG_HID_GEMBIRD)      += hid-gembird.o
> diff --git a/drivers/hid/hid-evision.c b/drivers/hid/hid-evision.c
> new file mode 100644
> index 000000000..6ea331575
> --- /dev/null
> +++ b/drivers/hid/hid-evision.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  HID driver for EVision devices
> + *  For now, only ignore bogus consumer reports
> + *  sent after the keyboard has been configured
> + *
> + *  Copyright (c) 2022 Philippe Valembois
> + */
> +
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>

Outside of hid_is_usb(), you are not using anything USB related, so
this can be dropped

> +
> +
> +#define USB_VENDOR_ID_EVISION       0x320f
> +#define USB_DEVICE_ID_EVISION_ICL01 0x5041

We tend to add those variables in drivers/hid/hid-ids.h

> +
> +static int evision_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> +               struct hid_field *field, struct hid_usage *usage,
> +               unsigned long **bit, int *max)
> +{
> +       if ((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER)
> +               return 0;
> +
> +       // Ignore key down event

No C++ comments style please, use /* */ instead

> +       if ((usage->hid & HID_USAGE) >> 8 == 0x05)
> +               return -1;
> +       // Ignore key up event

Same (and for any other // below).

> +       if ((usage->hid & HID_USAGE) >> 8 == 0x06)
> +               return -1;
> +
> +       switch (usage->hid & HID_USAGE) {
> +       // Ignore configuration saved event
> +       case 0x0401: return -1;
> +       // Ignore reset event
> +       case 0x0402: return -1;
> +       }
> +       return 0;
> +}
> +
> +static int evision_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +       int ret;
> +
> +       if (!hid_is_usb(hdev))
> +               return -EINVAL;

This can be dropped...

> +
> +       ret = hid_parse(hdev);
> +       if (ret) {
> +               hid_err(hdev, "EVision hid parse failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       if (ret) {
> +               hid_err(hdev, "EVision hw start failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;

... which means the probe is the default one, meaning it can also be
dropped from the patch :)

> +}
> +
> +static const struct hid_device_id evision_devices[] = {
> +       { HID_USB_DEVICE(USB_VENDOR_ID_EVISION, USB_DEVICE_ID_EVISION_ICL01) },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(hid, evision_devices);
> +
> +static struct hid_driver evision_driver = {
> +       .name = "evision",
> +       .id_table = evision_devices,
> +       .input_mapping = evision_input_mapping,
> +       .probe = evision_probe,

Just for completeness, remove that .probe line and your driver will
behave the same and be smaller :)

> +};
> +module_hid_driver(evision_driver);
> +
> +MODULE_LICENSE("GPL");
> --
> 2.38.2
>

Cheers,
Benjamin

