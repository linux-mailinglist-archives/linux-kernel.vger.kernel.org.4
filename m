Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD767AF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjAYKWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjAYKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:22:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8770C3A581
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674642126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=89IL5nu5A2pzN0EnC6g6HKyleu+Olf0iNi7gGVlHd5c=;
        b=GB6x9Xn1tAwJzRGbskebY8/4gIAN29cXcVRkTc5z2vTwqCPrMc0Gpr8h99X/tDn5y0eqts
        SmEx9jHQmUhN2t1lq946npadmPpS1m1mSjEZMfNq41QgYRF71GUbtUVrxyWsSC4wVlDLNY
        Ma8vYBmnis9K5XIjvXAPddSvHRjBaMw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-VT1gLR4nMqCFHx1TQNRGJA-1; Wed, 25 Jan 2023 05:22:05 -0500
X-MC-Unique: VT1gLR4nMqCFHx1TQNRGJA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-4fee82718afso151907347b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89IL5nu5A2pzN0EnC6g6HKyleu+Olf0iNi7gGVlHd5c=;
        b=P6tXksgwvQcnC9sAp80FRvyAY230Xb5GAKwH4n/MkUj9yyPpVLxwLd7kJ3dOMUcx4O
         Zv7ecVbdF33j9MOGldXjKWshDrTJXInNt6+lfTjtWNgAmu1sXpWlmMA1RawsJj9x8bkY
         Jrb7b3/ylzpXqccoczoxFFvdhpukXnH42IbQ1TDB4XP7DgsnFzu4QCbPcKiFB+qjfSof
         mWKyhs7uMpg2CmiKTKrblS11nxNpsqYTGSUepGobH59k1PDCMDVPBIw0SqQvco5z7gnY
         Aa9d8PE8imzwvtJuk4dN7H2P57JveLrkjn0qmptfT6JXKaGy1UR4dBat4BcsCu9wxxqm
         RAzw==
X-Gm-Message-State: AFqh2kocTPONnC0CiSLlSdh3YtwHxKOZIToDx762GMMG+ZqfQFBs3nwA
        Vs4NfmdFLKLa2xupCKyj6ZGUTcL8urlfmfzN6vfWg5dSUG5NWz3SG/h9s02f8eOx88K0jjlv89W
        dyiHnQJ2OCbpWRh2LSpYm5OVa1dY+a8DcXvIVtGeO
X-Received: by 2002:a25:1856:0:b0:732:edd2:4138 with SMTP id 83-20020a251856000000b00732edd24138mr2324885yby.448.1674642124660;
        Wed, 25 Jan 2023 02:22:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvddEmRAkvvDknAyoKqnRzba9kixGoTQM2pl9vXy3pB4NOuX4HZrLEyws7vvL9+LlW1co9yqu2FEChxNddAuXI=
X-Received: by 2002:a25:1856:0:b0:732:edd2:4138 with SMTP id
 83-20020a251856000000b00732edd24138mr2324882yby.448.1674642124466; Wed, 25
 Jan 2023 02:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20230116130937.391441-1-hadess@hadess.net>
In-Reply-To: <20230116130937.391441-1-hadess@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 25 Jan 2023 11:21:53 +0100
Message-ID: <CAO-hwJLFt185LS5ePO3Wr=L1VULdAHKQC3oXvLAS9GC0-UraFQ@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Hard-code HID++ 1.0 fast scroll support
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
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

On Mon, Jan 16, 2023 at 2:09 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> HID++ 1.0 devices only export whether Fast Scrolling is enabled, not
> whether they are capable of it. Reinstate the original quirks for the 3
> supported mice so fast scrolling works again on those devices.
>
> Fixes: 908d325 ("HID: logitech-hidpp: Detect hi-res scrolling support")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216903
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---

Applied to for-6.3/logitech

Thanks!

Cheers,
Benjamin

>  drivers/hid/hid-logitech-hidpp.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index abf2c95e4d0b..fa026e9107c5 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -77,6 +77,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_QUIRK_HIDPP_WHEELS               BIT(26)
>  #define HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS     BIT(27)
>  #define HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS BIT(28)
> +#define HIDPP_QUIRK_HI_RES_SCROLL_1P0          BIT(29)
>
>  /* These are just aliases for now */
>  #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
> @@ -3472,14 +3473,8 @@ static int hidpp_initialize_hires_scroll(struct hidpp_device *hidpp)
>                         hid_dbg(hidpp->hid_dev, "Detected HID++ 2.0 hi-res scrolling\n");
>                 }
>         } else {
> -               struct hidpp_report response;
> -
> -               ret = hidpp_send_rap_command_sync(hidpp,
> -                                                 REPORT_ID_HIDPP_SHORT,
> -                                                 HIDPP_GET_REGISTER,
> -                                                 HIDPP_ENABLE_FAST_SCROLL,
> -                                                 NULL, 0, &response);
> -               if (!ret) {
> +               /* We cannot detect fast scrolling support on HID++ 1.0 devices */
> +               if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) {
>                         hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL;
>                         hid_dbg(hidpp->hid_dev, "Detected HID++ 1.0 fast scroll\n");
>                 }
> @@ -4296,9 +4291,15 @@ static const struct hid_device_id hidpp_devices[] = {
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
>                 USB_DEVICE_ID_LOGITECH_T651),
>           .driver_data = HIDPP_QUIRK_CLASS_WTP },
> +       { /* Mouse Logitech Anywhere MX */
> +         LDJ_DEVICE(0x1017), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
>         { /* Mouse logitech M560 */
>           LDJ_DEVICE(0x402d),
>           .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
> +       { /* Mouse Logitech M705 (firmware RQM17) */
> +         LDJ_DEVICE(0x101b), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
> +       { /* Mouse Logitech Performance MX */
> +         LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
>         { /* Keyboard logitech K400 */
>           LDJ_DEVICE(0x4024),
>           .driver_data = HIDPP_QUIRK_CLASS_K400 },
> --
> 2.39.0
>

