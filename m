Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9C8692251
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjBJPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjBJPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:34:08 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF3626CEC;
        Fri, 10 Feb 2023 07:34:01 -0800 (PST)
Date:   Fri, 10 Feb 2023 15:33:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1676043239; bh=vuMIsMAhElQYqXDSBihn1YCzsK2RcCrxcE3TtfS6HUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0OzN7DmHRa/QP/zIY97pXQFl+fS/RO00fqYBoxuqlV1pxd5n30I7gA0Wc8Ryitjq
         CjEi15guP+lCi5mp0T5BfCBUM+JQViaTafhE91b3VLRyChYfKdwZNF18n9y6N/JRAh
         qWCPhy8p/vK3XJfV7CgMWYZ/v+Z1XpWDF7QMEpl4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Message-ID: <20230210153356.zdj7gw7ztbgz2qx7@t-8ch.de>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <20230210045624.cjxroikmmvm3liij@t-8ch.de>
 <B9E319F8-6047-40E5-BD9F-D90D6504AA9E@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B9E319F8-6047-40E5-BD9F-D90D6504AA9E@live.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Responses inline

On Fri, Feb 10, 2023 at 12:05:13PM +0000, Aditya Garg wrote:
> > On 10-Feb-2023, at 10:26 AM, Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > 
> > Hi,
> > 
> > some comments inline.
> > 
> > On Fri, Feb 10, 2023 at 03:43:24AM +0000, Aditya Garg wrote:
> > 
> >> +
> >> +static struct {
> >> + unsigned int usage;
> >> + struct hid_device_id *dev_id;
> >> +} appleib_usage_map[] = {
> >> + /* Default iBridge configuration, key inputs and mode settings */
> >> + { 0x00010006, &appleib_sub_hid_ids[0] },
> >> + /* OS X iBridge configuration, digitizer inputs */
> >> + { 0x000D0005, &appleib_sub_hid_ids[0] },
> >> + /* All iBridge configurations, display/DFR settings */
> >> + { 0xFF120001, &appleib_sub_hid_ids[0] },
> >> + /* All iBridge configurations, ALS */
> >> + { 0x00200041, &appleib_sub_hid_ids[1] },
> >> +};
> > 
> > const
> > 
> 
> Constantifying this results in compiler giving warnings
> 
> drivers/hid/apple-ibridge.c:78:23: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>    78 |         { 0x00200041, &appleib_sub_hid_ids[1] },

For this you also have to constify the hid_device_id *dev_id in
appleib_usage_map. And then propagate this change to some functions and
variables.

>       |                       ^
> drivers/hid/apple-ibridge.c: In function 'appleib_add_sub_dev':
> drivers/hid/apple-ibridge.c:363:29: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   363 |         sub_hdev->ll_driver = &appleib_ll_driver;

As Benjamin said this is because your changes are based on Linus' tree
but they will break as soon as they will be merged into the HID tree.
You should base your changes off of the HID tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=for-6.3/hid-core

This issue is essentially unlucky timing.

>       |                             ^
> drivers/hid/apple-ibridge.c: In function 'appleib_hid_probe':
> drivers/hid/apple-ibridge.c:436:12: error: expected '(' before 'hid_is_usb'
>   436 |         if hid_is_usb(hdev)
>       |            ^~~~~~~~~~
>       |            (

As the error message indicates, this is invalid syntax and missing a
'('.
What you want to do is to check for 

  if (!hid_is_usb(hdev))
    return -ENODEV;

*before* calling hid_to_usb_dev(hdev);

> In file included from drivers/hid/apple-ibridge.c:48:
> drivers/hid/apple-ibridge.c: In function 'appleib_probe':
> drivers/hid/apple-ibridge.c:544:35: warning: passing argument 1 of '__hid_register_driver' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   544 |         ret = hid_register_driver(&appleib_hid_driver);
>       |                                   ^~~~~~~~~~~~~~~~~~~
> ./include/linux/hid.h:898:31: note: in definition of macro 'hid_register_driver'
>   898 |         __hid_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
>       |                               ^~~~~~
> ./include/linux/hid.h:893:47: note: expected 'struct hid_driver *' but argument is of type 'const struct hid_driver *'
>   893 | extern int __must_check __hid_register_driver(struct hid_driver *,
>       |                                               ^~~~~~~~~~~~~~~~~~~
> drivers/hid/apple-ibridge.c: In function 'appleib_remove':
> drivers/hid/apple-ibridge.c:558:31: warning: passing argument 1 of 'hid_unregister_driver' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   558 |         hid_unregister_driver(&appleib_hid_driver);
>       |                               ^~~~~~~~~~~~~~~~~~~
> ./include/linux/hid.h:900:35: note: expected 'struct hid_driver *' but argument is of type 'const struct hid_driver *'
>   900 | extern void hid_unregister_driver(struct hid_driver *);
>       |                                   ^~~~~~~~~~~~~~~~~~~

These are all because applib_hid_driver can not be const.
Sorry for the wrong advice.

Benjamin:
HID drivers can not be const because they embed a 'struct driver' that
is needed by the driver core to be mutable.
Fixing this is probably a larger enterprise.

> make[6]: *** [scripts/Makefile.build:250: drivers/hid/apple-ibridge.o] Error 1
> make[5]: *** [scripts/Makefile.build:500: drivers/hid] Error 2
> make[5]: *** Waiting for unfinished jobs….
> 
> Some warnings are also due to a typo in if and constantifying `static struct hid_driver`, although they probably can
> be fixed.
> 
> In short, Thomas, do you really want me to constantify the structure I
> am talking about in this email, as well `static struct hid_driver`?

struct hid_driver: Don't constify
all others: Do constify

Thomas
