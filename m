Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210795BE744
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiITNiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiITNiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2145F580B0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663681087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXq60k4Ir3p5piUtObaU84pFedZT5LrWb+1N9tdzWIw=;
        b=JvmWh+z89KOhyujYjXLBClTGAXKUk87uiIKuKWwzo/6stjoN9uWZdbNyqWDbJOS3gmbapD
        AmK/FhgMSNvbpHiG2/ISlQAWcs445jxtQa+XlZdKTMFUIbvLDSsxBlV1n6QUcDFmR8ReRi
        GNCTLslvAPgyPUINqwS6t9aLtI0QyUE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-359-z0KRvjvcMQ-BlqEvOiNUIQ-1; Tue, 20 Sep 2022 09:38:06 -0400
X-MC-Unique: z0KRvjvcMQ-BlqEvOiNUIQ-1
Received: by mail-pg1-f198.google.com with SMTP id m188-20020a633fc5000000b00434dccacd4aso1662664pga.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lXq60k4Ir3p5piUtObaU84pFedZT5LrWb+1N9tdzWIw=;
        b=unTg6oZ0cIR9dTHkUKV5kRt+OMCOE445IgF6Tht+LkKHo/Xo8uuDp602DB4oyBxUdv
         EQ3TUKYFiIh7bFcb/BVuocVdlLhSW4tl5d+CtVKQeZwVA82TIkKE9Db7B2zNwICH+9oU
         mY8UEv6xod/V/sDVyB9rns7DEa2qKQb0wI6ct1/crsoT3HvcQtq+tOzKu3tuKDwFUhTa
         +YZjkgR9ANM1Beqh1wwg4plx6VeB8KbIFx0cNvj4S19EjnYC3vcsYd9Es5/i5kkVQciF
         DzQdoqg1Jpd2meVeRDw6dYiI0pRu+Vp2SGikT/0y/+Evskmjp/w/PMmxwF8a8RUNJN+F
         xdUA==
X-Gm-Message-State: ACrzQf0b/i/H/xOS0nnCkRfX7s6say9NyfLkpjiXuPm9hiRI7WDUBHO9
        3jDwwhZv/820HNnpvBZJ3W6Hl3HCKb7VebOC2oVyrcm+pKplVTxYmHaCG2F2rdjOm9L8wLv2jQ6
        ax2nfRp9m3xTkurzdjv30WV3ilPO5gA3YBjq//9EY
X-Received: by 2002:a17:903:120c:b0:172:728a:3b24 with SMTP id l12-20020a170903120c00b00172728a3b24mr4829622plh.61.1663681085014;
        Tue, 20 Sep 2022 06:38:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Tlmu2PWHOfxvk9a5I8EUZK0cU3NFSK+sKuHQ3NlD5rbAifGDu5hMyQzwnZt1PlabuZgn4SJAAFw6/OHUgYDo=
X-Received: by 2002:a17:903:120c:b0:172:728a:3b24 with SMTP id
 l12-20020a170903120c00b00172728a3b24mr4829597plh.61.1663681084696; Tue, 20
 Sep 2022 06:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220914132146.6435-1-hadess@hadess.net>
In-Reply-To: <20220914132146.6435-1-hadess@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 20 Sep 2022 15:37:53 +0200
Message-ID: <CAO-hwJL=CXZRkp1c9R6jcnM1HT4NpTsJPkuFH40bP8K9u0mDFg@mail.gmail.com>
Subject: Re: [PATCH v1] HID: logitech-hidpp: Detect hi-res scrolling support
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 3:21 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> Rather than relying on a never-ending stream of patches for quirks.
>
> This change will detect whether HID++ 1.0 hi-res scroll, HID++ 2.0
> hi-res scroll or HID++ 2.0 hi-res scroll wheel is supported, and enable
> the feature without the need for quirks.
>
> Tested on a Logitech M705 mouse that was unsupported before this change.
>
> [    9.365324] logitech-hidpp-device 0003:046D:406D.0006: input,hidraw3: USB HID v1.11 Mouse [Logitech M705] on usb-0000:00:14.0-4/input2:3
> [   57.472434] logitech-hidpp-device 0003:046D:406D.0006: HID++ 4.5 device connected.
> [   57.616429] logitech-hidpp-device 0003:046D:406D.0006: Detected HID++ 2.0 hi-res scroll wheel
> [   57.712424] logitech-hidpp-device 0003:046D:406D.0006: wheel multiplier = 8
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216480
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---

Added the tested-by line from Peter and applied to for-6.1/logitech in hid.git

Cheers,
Benjamin

>  drivers/hid/hid-logitech-hidpp.c | 118 ++++++++++++++++---------------
>  1 file changed, 61 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 74013d0e0a24..5f8261c7b74c 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -74,21 +74,18 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_QUIRK_NO_HIDINPUT                        BIT(23)
>  #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS       BIT(24)
>  #define HIDPP_QUIRK_UNIFYING                   BIT(25)
> -#define HIDPP_QUIRK_HI_RES_SCROLL_1P0          BIT(26)
> -#define HIDPP_QUIRK_HI_RES_SCROLL_X2120                BIT(27)
> -#define HIDPP_QUIRK_HI_RES_SCROLL_X2121                BIT(28)
> -#define HIDPP_QUIRK_HIDPP_WHEELS               BIT(29)
> -#define HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS     BIT(30)
> -#define HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS BIT(31)
> +#define HIDPP_QUIRK_HIDPP_WHEELS               BIT(26)
> +#define HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS     BIT(27)
> +#define HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS BIT(28)
>
>  /* These are just aliases for now */
>  #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
>  #define HIDPP_QUIRK_KBD_ZOOM_WHEEL   HIDPP_QUIRK_HIDPP_WHEELS
>
>  /* Convenience constant to check for any high-res support. */
> -#define HIDPP_QUIRK_HI_RES_SCROLL      (HIDPP_QUIRK_HI_RES_SCROLL_1P0 | \
> -                                        HIDPP_QUIRK_HI_RES_SCROLL_X2120 | \
> -                                        HIDPP_QUIRK_HI_RES_SCROLL_X2121)
> +#define HIDPP_CAPABILITY_HI_RES_SCROLL (HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL | \
> +                                        HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL | \
> +                                        HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL)
>
>  #define HIDPP_QUIRK_DELAYED_INIT               HIDPP_QUIRK_NO_HIDINPUT
>
> @@ -99,6 +96,9 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_CAPABILITY_BATTERY_VOLTAGE       BIT(4)
>  #define HIDPP_CAPABILITY_BATTERY_PERCENTAGE    BIT(5)
>  #define HIDPP_CAPABILITY_UNIFIED_BATTERY       BIT(6)
> +#define HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL  BIT(7)
> +#define HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL BIT(8)
> +#define HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL   BIT(9)
>
>  #define lg_map_key_clear(c)  hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
>
> @@ -3418,14 +3418,14 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>         int ret;
>         u8 multiplier = 1;
>
> -       if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
> +       if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
>                 ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
>                 if (ret == 0)
>                         ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
> -       } else if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2120) {
> +       } else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
>                 ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
>                                                            &multiplier);
> -       } else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */ {
> +       } else /* if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL) */ {
>                 ret = hidpp10_enable_scrolling_acceleration(hidpp);
>                 multiplier = 8;
>         }
> @@ -3440,6 +3440,49 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>         return 0;
>  }
>
> +static int hidpp_initialize_hires_scroll(struct hidpp_device *hidpp)
> +{
> +       int ret;
> +       unsigned long capabilities;
> +
> +       capabilities = hidpp->capabilities;
> +
> +       if (hidpp->protocol_major >= 2) {
> +               u8 feature_index;
> +               u8 feature_type;
> +
> +               ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
> +                                            &feature_index, &feature_type);
> +               if (!ret) {
> +                       hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL;
> +                       hid_dbg(hidpp->hid_dev, "Detected HID++ 2.0 hi-res scroll wheel\n");
> +                       return 0;
> +               }
> +               ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HI_RESOLUTION_SCROLLING,
> +                                            &feature_index, &feature_type);
> +               if (!ret) {
> +                       hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL;
> +                       hid_dbg(hidpp->hid_dev, "Detected HID++ 2.0 hi-res scrolling\n");
> +               }
> +       } else {
> +               struct hidpp_report response;
> +
> +               ret = hidpp_send_rap_command_sync(hidpp,
> +                                                 REPORT_ID_HIDPP_SHORT,
> +                                                 HIDPP_GET_REGISTER,
> +                                                 HIDPP_ENABLE_FAST_SCROLL,
> +                                                 NULL, 0, &response);
> +               if (!ret) {
> +                       hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL;
> +                       hid_dbg(hidpp->hid_dev, "Detected HID++ 1.0 fast scroll\n");
> +               }
> +       }
> +
> +       if (hidpp->capabilities == capabilities)
> +               hid_dbg(hidpp->hid_dev, "Did not detect HID++ hi-res scrolling hardware support\n");
> +       return 0;
> +}
> +
>  /* -------------------------------------------------------------------------- */
>  /* Generic HID++ devices                                                      */
>  /* -------------------------------------------------------------------------- */
> @@ -3694,8 +3737,9 @@ static int hidpp_event(struct hid_device *hdev, struct hid_field *field,
>          * cases we must return early (falling back to default behaviour) to
>          * avoid a crash in hidpp_scroll_counter_handle_scroll.
>          */
> -       if (!(hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL) || value == 0
> -           || hidpp->input == NULL || counter->wheel_multiplier == 0)
> +       if (!(hidpp->capabilities & HIDPP_CAPABILITY_HI_RES_SCROLL)
> +           || value == 0 || hidpp->input == NULL
> +           || counter->wheel_multiplier == 0)
>                 return 0;
>
>         hidpp_scroll_counter_handle_scroll(hidpp->input, counter, value);
> @@ -3927,6 +3971,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
>         }
>
>         hidpp_initialize_battery(hidpp);
> +       hidpp_initialize_hires_scroll(hidpp);
>
>         /* forward current battery state */
>         if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_BATTERY) {
> @@ -3946,7 +3991,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
>         if (hidpp->battery.ps)
>                 power_supply_changed(hidpp->battery.ps);
>
> -       if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL)
> +       if (hidpp->capabilities & HIDPP_CAPABILITY_HI_RES_SCROLL)
>                 hi_res_scroll_enable(hidpp);
>
>         if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
> @@ -4257,42 +4302,9 @@ static const struct hid_device_id hidpp_devices[] = {
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
>                 USB_DEVICE_ID_LOGITECH_T651),
>           .driver_data = HIDPP_QUIRK_CLASS_WTP },
> -       { /* Mouse Logitech Anywhere MX */
> -         LDJ_DEVICE(0x1017), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
> -       { /* Mouse Logitech Cube */
> -         LDJ_DEVICE(0x4010), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
> -       { /* Mouse Logitech M335 */
> -         LDJ_DEVICE(0x4050), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { /* Mouse Logitech M515 */
> -         LDJ_DEVICE(0x4007), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
>         { /* Mouse logitech M560 */
>           LDJ_DEVICE(0x402d),
> -         .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560
> -               | HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
> -       { /* Mouse Logitech M705 (firmware RQM17) */
> -         LDJ_DEVICE(0x101b), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
> -       { /* Mouse Logitech M705 (firmware RQM67) */
> -         LDJ_DEVICE(0x406d), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { /* Mouse Logitech M720 */
> -         LDJ_DEVICE(0x405e), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { /* Mouse Logitech MX Anywhere 2 */
> -         LDJ_DEVICE(0x404a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { LDJ_DEVICE(0x4072), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { LDJ_DEVICE(0xb013), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { LDJ_DEVICE(0xb018), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { LDJ_DEVICE(0xb01f), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { /* Mouse Logitech MX Anywhere 2S */
> -         LDJ_DEVICE(0x406a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { /* Mouse Logitech MX Master */
> -         LDJ_DEVICE(0x4041), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { LDJ_DEVICE(0x4060), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { LDJ_DEVICE(0x4071), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { /* Mouse Logitech MX Master 2S */
> -         LDJ_DEVICE(0x4069), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { /* Mouse Logitech MX Master 3 */
> -         LDJ_DEVICE(0x4082), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { /* Mouse Logitech Performance MX */
> -         LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
> +         .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
>         { /* Keyboard logitech K400 */
>           LDJ_DEVICE(0x4024),
>           .driver_data = HIDPP_QUIRK_CLASS_K400 },
> @@ -4353,14 +4365,6 @@ static const struct hid_device_id hidpp_devices[] = {
>         { /* MX5500 keyboard over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
>           .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> -       { /* MX Master mouse over Bluetooth */
> -         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
> -         .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
> -         .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> -       { /* MX Master 3 mouse over Bluetooth */
> -         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023),
> -         .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
>
>         { /* And try to enable HID++ for all the Logitech Bluetooth devices */
>           HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_ANY, USB_VENDOR_ID_LOGITECH, HID_ANY_ID) },
> --
> 2.37.3
>

