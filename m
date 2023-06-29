Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A204742E17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjF2UEL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 16:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjF2UDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:03:40 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE723ABD;
        Thu, 29 Jun 2023 13:03:08 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76FB7FF805;
        Thu, 29 Jun 2023 20:03:06 +0000 (UTC)
Message-ID: <8b8d8d78bb8856b933ee92ba2b9c8a256f90d29b.camel@hadess.net>
Subject: Re: [PATCH] HID: steelseries: Add support for Arctis 1 XBox
From:   Bastien Nocera <hadess@hadess.net>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 29 Jun 2023 22:03:05 +0200
In-Reply-To: <87wmzm9k7l.fsf@nvidia.com>
References: <20230629172041.3771-1-hadess@hadess.net>
         <87wmzm9k7l.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-29 at 11:50 -0700, Rahul Rameshbabu wrote:
> On Thu, 29 Jun, 2023 19:20:27 +0200 Bastien Nocera
> <hadess@hadess.net> wrote:
> > +static const struct hid_device_id steelseries_devices[] = {
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> > USB_DEVICE_ID_STEELSERIES_SRWS1),
> > +         .driver_data = STEELSERIES_SRWS1 },
> > +
> > +       { /* SteelSeries Arctis 1 Wireless for XBox */
> > +         HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, 0x12b6),
> 
> Shouldn't the USB device id be added to drivers/hid/hid-ids.h?

No, the hid-ids.h is only used if 2 files in the hid directory need to
reference the same device.

Since changes to the way hid drivers are loaded, there's no need to
blocklist the devices in the core to handle them in a driver, so
there's no need to reference the device in another place than the
driver itself, so no need to add it to hid-ids.h

> 
> > +       .driver_data = STEELSERIES_ARCTIS_1 },
> > +
> >         { }
> >  };
> > -MODULE_DEVICE_TABLE(hid, steelseries_srws1_devices);
> > -
> > -static struct hid_driver steelseries_srws1_driver = {
> > -       .name = "steelseries_srws1",
> > -       .id_table = steelseries_srws1_devices,
> > -#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
> > -    (IS_MODULE(CONFIG_LEDS_CLASS) &&
> > IS_MODULE(CONFIG_HID_STEELSERIES))
> > -       .probe = steelseries_srws1_probe,
> > -       .remove = steelseries_srws1_remove,
> > -#endif
> > -       .report_fixup = steelseries_srws1_report_fixup
> > +MODULE_DEVICE_TABLE(hid, steelseries_devices);
> 
> Thanks,
> 
> Rahul Rameshbabu

