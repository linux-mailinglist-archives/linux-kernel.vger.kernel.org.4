Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CD7692D57
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 03:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBKCXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 21:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 21:23:51 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7073582;
        Fri, 10 Feb 2023 18:23:50 -0800 (PST)
Date:   Sat, 11 Feb 2023 02:23:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1676082227; bh=cND6peTvw/I7idpgc1XRWngdJLvgKPcW8uvL69WIsKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUH67zjYEcM4rphEoXAflumxV/kGAOpMKtZcnce3H1MCUPVBOFiJz5G1yrvNPvtDP
         eKM13NRrvSZ91HY/1GGgCwMgU/gkpBPdblyUwLlFV38QccrCSRqRniny0T2kSi1OeU
         2dih48HAu8YK7ZCtohAmN3cChsS6OrGwzsbGmeu4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Aditya Garg <gargaditya08@live.com>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>
Subject: Re: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Message-ID: <20230211022342.7xyvd3qsa42lwrkq@t-8ch.de>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
 <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
 <20230210162518.pe7ipe44falu3j3k@t-8ch.de>
 <20230211102425.178e1c78@redecorated-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230211102425.178e1c78@redecorated-mbp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 10:24:25AM +1100, Orlando Chamberlain wrote:
> On Fri, 10 Feb 2023 16:25:18 +0000
> Thomas Weißschuh <thomas@t-8ch.de> wrote:
> 
> > On Fri, Feb 10, 2023 at 03:45:15AM +0000, Aditya Garg wrote:
> > > From: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > > +static void apple_magic_backlight_power_set(struct
> > > apple_magic_backlight *backlight,
> > > +					   char power, char rate)
> > > +{
> > > +	struct hid_report *rep = backlight->power;
> > > +
> > > +	rep->field[0]->value[0] = power ? 1 : 0;
> > > +	rep->field[1]->value[0] = 0x5e; /* Mimic Windows */
> > > +	rep->field[1]->value[0] |= rate << 8;
> > > +
> > > +	hid_hw_request(backlight->hdev, backlight->power,
> > > HID_REQ_SET_REPORT); +}
> > > +
> > > +static void apple_magic_backlight_brightness_set(struct
> > > apple_magic_backlight *backlight,
> > > +						int brightness,
> > > char rate) +{
> > > +	struct hid_report *rep = backlight->brightness;
> > > +
> > > +	rep->field[0]->value[0] = brightness;
> > > +	rep->field[1]->value[0] = 0x5e; /* Mimic Windows */
> > > +	rep->field[1]->value[0] |= rate << 8;
> > > +
> > > +	hid_hw_request(backlight->hdev, backlight->brightness,
> > > HID_REQ_SET_REPORT);
> > > +  
> > 
> > The two functions above are nearly identical.
> 
> They are indeed quite similar, and I can turn the backlight off with the
> brightness one, but when I logged the usb packets Windows used, it used
> both so I've done the same in the Linux driver to (hopefully) ensure it
> works with any other models or firmware updates that the Windows driver
> works on.

I didn't mean to suggest changing the logic, just the way the code is
organized:

static void apple_magic_backlight_report_set(struct apple_magic_backlight *backlight,
                                             struct hid_report *rep, char value, char rate)
{
	rep->field[0]->value[0] = value;
	rep->field[1]->value[0] = 0x5e; /* Mimic Windows */
	rep->field[1]->value[0] |= rate << 8;

	hid_hw_request(backlight->hdev, rep, HID_REQ_SET_REPORT);
}

static void apple_magic_backlight_set(struct apple_magic_backlight *backlight,
				     int brightness, char rate)
{
	apple_magic_backlight_report_set(backlight, backlight->power, !!brightness, rate);
	if (brightness)
		apple_magic_backlight_report_set(backlight, backlight->brightness, brightness, rate);
}

This way you can get rid of the duplicated code.

> > 
> > > +
> > > +static void apple_magic_backlight_set(struct apple_magic_backlight
> > > *backlight,
> > > +				     int brightness, char rate)
> > > +{
> > > +	apple_magic_backlight_power_set(backlight, brightness,
> > > rate);
> > > +	if (brightness)
> > > +		apple_magic_backlight_brightness_set(backlight,
> > > brightness, rate); +}
> > > +
