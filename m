Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EF16523E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiLTPof convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Dec 2022 10:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiLTPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:44:16 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2288917E35;
        Tue, 20 Dec 2022 07:44:12 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 1AE2040003;
        Tue, 20 Dec 2022 15:44:09 +0000 (UTC)
Message-ID: <db717b228dabc53b5d726c6e57076917dfecba37.camel@hadess.net>
Subject: Re: [PATCH 1/3] Revert "HID: logitech-hidpp: add a module parameter
 to keep firmware gestures"
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Tue, 20 Dec 2022 16:44:09 +0100
In-Reply-To: <20221220092207.428640-1-hadess@hadess.net>
References: <20221220092207.428640-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-20 at 10:22 +0100, Bastien Nocera wrote:
> Now that we're in 2022, and the majority of desktop environments can
> and
> should support touchpad gestures through libinput, remove the legacy
> module parameter that made it possible to use gestures implemented in
> firmware.
> 
> This will eventually allow simplifying the driver's initialisation
> code.
> 
> This reverts commit 9188dbaed68a4b23dc96eba165265c08caa7dc2a.

Forgot the signed-off-by, resent as v2.

> ---
>  drivers/hid/hid-logitech-hidpp.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 08ad19097e9e..7f9187201913 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -32,11 +32,6 @@ MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
>  MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
>  
> -static bool disable_raw_mode;
> -module_param(disable_raw_mode, bool, 0644);
> -MODULE_PARM_DESC(disable_raw_mode,
> -       "Disable Raw mode reporting for touchpads and keep firmware
> gestures.");
> -
>  static bool disable_tap_to_click;
>  module_param(disable_tap_to_click, bool, 0644);
>  MODULE_PARM_DESC(disable_tap_to_click,
> @@ -4355,11 +4350,6 @@ static int hidpp_probe(struct hid_device
> *hdev, const struct hid_device_id *id)
>             hidpp_application_equals(hdev, HID_GD_KEYBOARD))
>                 hidpp->quirks |=
> HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS;
>  
> -       if (disable_raw_mode) {
> -               hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
> -               hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
> -       }
> -
>         if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
>                 ret = wtp_allocate(hdev, id);
>                 if (ret)

