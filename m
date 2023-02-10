Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10EE69256B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjBJSgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjBJSgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:36:12 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908F69536;
        Fri, 10 Feb 2023 10:36:11 -0800 (PST)
Date:   Fri, 10 Feb 2023 11:36:02 -0700 (GMT-07:00)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1676054168; bh=60guHEUGd/XmV+MPQukXhjwcgeGRDbEWPL4ThJ77WqQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=l4I/A25g4qNffJqCgIVPIivBY69t5u4DnQt5RoP0+hhg/25Lw4Lkm3T4NaBn+g4ke
         XdOEuR9mxkD6gNf4v3uHGwbZf3WCNnxug72wkEwnDHWFl5V76osLh0FfeSMcdZ9X9H
         Ev7Fv8nOzW2lWJToGRhCxX6YfibbEKzEzLr3XnVI=
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Jiri Kosina <jikos@kernel.org>, jkosina@suse.cz,
        benjamin.tissoires@redhat.com,
        Andy Shevchenko <andy@infradead.org>,
        andy.shevchenko@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, ronald@innovation.ch,
        kekrby@gmail.com, Orlando Chamberlain <orlandoch.dev@gmail.com>
Message-ID: <cb640534-ed9f-4b69-8070-6eb3efd72604@t-8ch.de>
In-Reply-To: <BM1PR01MB09315DC70770D236DD29D007B8DE9@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com> <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com> <20230210045624.cjxroikmmvm3liij@t-8ch.de> <B9E319F8-6047-40E5-BD9F-D90D6504AA9E@live.com> <20230210153356.zdj7gw7ztbgz2qx7@t-8ch.de> <BM1PR01MB09315DC70770D236DD29D007B8DE9@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
Subject: Re: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver
 for T1 chip.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <cb640534-ed9f-4b69-8070-6eb3efd72604@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Feb 10, 2023 08:50:12 Aditya Garg <gargaditya08@live.com>:

>
>
>> On 10-Feb-2023, at 9:04 PM, Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wrot=
e:
>>
>> =EF=BB=BFResponses inline
>>
>> On Fri, Feb 10, 2023 at 12:05:13PM +0000, Aditya Garg wrote:
>>>>> On 10-Feb-2023, at 10:26 AM, Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> =
wrote:
>>>>
>>>> Hi,
>>>>
>>>> some comments inline.
>>>>
>>>>> On Fri, Feb 10, 2023 at 03:43:24AM +0000, Aditya Garg wrote:
>>>>
>>>>> +
>>>>> +static struct {
>>>>> + unsigned int usage;
>>>>> + struct hid_device_id *dev_id;
>>>>> +} appleib_usage_map[] =3D {
>>>>> + /* Default iBridge configuration, key inputs and mode settings */
>>>>> + { 0x00010006, &appleib_sub_hid_ids[0] },
>>>>> + /* OS X iBridge configuration, digitizer inputs */
>>>>> + { 0x000D0005, &appleib_sub_hid_ids[0] },
>>>>> + /* All iBridge configurations, display/DFR settings */
>>>>> + { 0xFF120001, &appleib_sub_hid_ids[0] },
>>>>> + /* All iBridge configurations, ALS */
>>>>> + { 0x00200041, &appleib_sub_hid_ids[1] },
>>>>> +};
>>>>
>>>> const
>>>>
>>>
>>> Constantifying this results in compiler giving warnings
>>>
>>> drivers/hid/apple-ibridge.c:78:23: warning: initialization discards 'co=
nst' qualifier from pointer target type [-Wdiscarded-qualifiers]
>>> =C2=A0 78 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0x0020004=
1, &appleib_sub_hid_ids[1] },
>>
>> For this you also have to constify the hid_device_id *dev_id in
>> appleib_usage_map. And then propagate this change to some functions and
>> variables.
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^
>>> drivers/hid/apple-ibridge.c: In function 'appleib_add_sub_dev':
>>> drivers/hid/apple-ibridge.c:363:29: warning: assignment discards 'const=
' qualifier from pointer target type [-Wdiscarded-qualifiers]
>>> 363 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sub_hdev->ll_driv=
er =3D &appleib_ll_driver;
>>
>> As Benjamin said this is because your changes are based on Linus' tree
>> but they will break as soon as they will be merged into the HID tree.
>> You should base your changes off of the HID tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=3Dfor=
-6.3/hid-core
>>
>> This issue is essentially unlucky timing.
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>>> drivers/hid/apple-ibridge.c: In function 'appleib_hid_probe':
>>> drivers/hid/apple-ibridge.c:436:12: error: expected '(' before 'hid_is_=
usb'
>>> 436 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if hid_is_usb(hde=
v)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (
>>
>> As the error message indicates, this is invalid syntax and missing a
>> '('.
>> What you want to do is to check for
>>
>> if (!hid_is_usb(hdev))
>> =C2=A0=C2=A0 return -ENODEV;
>
> It was a typo on my part
>
> +=C2=A0=C2=A0 /* check and set usb config first */
> +=C2=A0=C2=A0 if (hid_is_usb(hdev))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 udev =3D hid_to_usb_dev(hdev);
> +=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;

I would prefer

if (!hid_is_usb(hdev))
=C2=A0=C2=A0=C2=A0 return -EINVAL;

udev =3D hid_to_usb_dev(hdev);

>
> This is what I have in my patch set now.
>
> If there is something wrong with this, then do tell me
>
> Thanks
>>
>> *before* calling hid_to_usb_dev(hdev);
>>
>>> In file included from drivers/hid/apple-ibridge.c:48:
>>> drivers/hid/apple-ibridge.c: In function 'appleib_probe':
>>> drivers/hid/apple-ibridge.c:544:35: warning: passing argument 1 of '__h=
id_register_driver' discards 'const' qualifier from pointer target type [-W=
discarded-qualifiers]
>>> 544 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hid_regis=
ter_driver(&appleib_hid_driver);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~
>>> ./include/linux/hid.h:898:31: note: in definition of macro 'hid_registe=
r_driver'
>>> 898 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __hid_register_dr=
iver(driver, THIS_MODULE, KBUILD_MODNAME)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~
>>> ./include/linux/hid.h:893:47: note: expected 'struct hid_driver *' but =
argument is of type 'const struct hid_driver *'
>>> 893 | extern int __must_check __hid_register_driver(struct hid_driver *=
,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^~~~~~~~~~~~~~~~~~~
>>> drivers/hid/apple-ibridge.c: In function 'appleib_remove':
>>> drivers/hid/apple-ibridge.c:558:31: warning: passing argument 1 of 'hid=
_unregister_driver' discards 'const' qualifier from pointer target type [-W=
discarded-qualifiers]
>>> 558 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hid_unregister_dr=
iver(&appleib_hid_driver);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~=
~~~~~
>>> ./include/linux/hid.h:900:35: note: expected 'struct hid_driver *' but =
argument is of type 'const struct hid_driver *'
>>> 900 | extern void hid_unregister_driver(struct hid_driver *);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~
>>
>> These are all because applib_hid_driver can not be const.
>> Sorry for the wrong advice.
>>
>> Benjamin:
>> HID drivers can not be const because they embed a 'struct driver' that
>> is needed by the driver core to be mutable.
>> Fixing this is probably a larger enterprise.
>>
>>> make[6]: *** [scripts/Makefile.build:250: drivers/hid/apple-ibridge.o] =
Error 1
>>> make[5]: *** [scripts/Makefile.build:500: drivers/hid] Error 2
>>> make[5]: *** Waiting for unfinished jobs=E2=80=A6.
>>>
>>> Some warnings are also due to a typo in if and constantifying `static s=
truct hid_driver`, although they probably can
>>> be fixed.
>>>
>>> In short, Thomas, do you really want me to constantify the structure I
>>> am talking about in this email, as well `static struct hid_driver`?
>>
>> struct hid_driver: Don't constify
>> all others: Do constify
>>
>> Thomas

