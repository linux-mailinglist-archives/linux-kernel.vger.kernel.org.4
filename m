Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763526CF30F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjC2TVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2TVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:21:40 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A9AF0;
        Wed, 29 Mar 2023 12:21:39 -0700 (PDT)
Date:   Wed, 29 Mar 2023 14:21:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1680117697; bh=+TYBjphSjzkzu8ppkUfNWC7DdedG0FDM8DFO+QletD0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=gAtaFetnCbTDoBE+WpFsDBACzCOLCoVYbfPF2s5Ee3MoIpLnkn8H4AB8bDU2x/EEX
         Q/AmIFLhhQFj2uEGkb6xTSz63Bmt59AxGMVwSQa/jgUVTVCZdFO4T6i21j0F1kkCAI
         qfna6GQL+NMhNYm9wBv9i5vBPA1KEV3rDz/vCwec=
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Hans de Goede <hdegoede@redhat.com>,
        Armin Wolf <W_Armin@gmx.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org
Message-ID: <bccb52fa-e1c9-482c-a024-9a02179728b2@t-8ch.de>
In-Reply-To: <b06d1d1f-7cd5-4532-ac49-d449ef68bbcb@app.fastmail.com>
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr> <ZCLPaYGKHlFQGKYQ@kroah.com> <542c13f5-4cdd-7750-f10a-ef64bb7e8faa@alu.unizg.hr> <d011a1d7-34ab-5f54-fcc7-d727abc7ec9b@alu.unizg.hr> <ZCLa3_HnLQA0GQKS@kroah.com> <b50f9460-ac54-e997-f9b9-3c47a9b87aae@alu.unizg.hr> <df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de> <16862c45-2ffd-a2f2-6719-020c5d515800@alu.unizg.hr> <4f65a23f-4e04-f04f-e56b-230a38ac5ec4@gmx.de> <01e920bc-5882-ba0c-dd15-868bf0eca0b8@alu.unizg.hr> <8b478e6d-7482-2cbb-ee14-b2dc522daf35@alu.unizg.hr> <9f757a7b-6ac9-804a-063f-4cc2c6fc3f54@alu.unizg.hr> <de54f828-e2c6-4c10-92ce-ca86fb5c5fb4@t-8ch.de> <6a5dc4de-b315-1e6d-e5e2-5b95521a37c7@alu.unizg.hr> <2c1d0b9b-0e71-b616-6486-52e741d25afb@redhat.com> <9c142ac2-9340-4a9b-8541-99f613772340@app.fastmail.com> <4dc118c2-0dde-bd5e-ea41-427ed33e4545@alu.unizg.hr> <b06d1d1f-7cd5-4532-ac49-d449ef68bbcb@app.fastmail.com>
Subject: Re: [BUG] [RFC] systemd-devd triggers kernel memleak apparently in
 drivers/core/dd.c: driver_register()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <bccb52fa-e1c9-482c-a024-9a02179728b2@t-8ch.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mar 29, 2023 14:00:22 Mark Pearson <mpearson-lenovo@squebb.ca>:

> Thanks Mirsad
>
> On Wed, Mar 29, 2023, at 2:49 PM, Mirsad Goran Todorovac wrote:
> <snip>
>>
>> Here is the patch proposal according to what Mark advised (using
>> different name for optitem):
>>
>> diff --git a/drivers/platform/x86/think-lmi.c
>> b/drivers/platform/x86/think-lmi.c
>> index c816646eb661..ab17254781c4 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject
>> *kobj, struct kobj_attribute *a
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* validate and split f=
rom `item,value` -> `value` */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D strpbrk(item,=
 ",");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D item ||=
 !strlen(value + 1))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D item ||=
 !strlen(value + 1)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 kfree(item);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sysfs_emit(buf,=
 "%s\n", value + 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(item);
>> @@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting
>> *tlmi_create_auth(const char *pwd_type,
>>
>> =C2=A0 static int tlmi_analyze(void)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_status status;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, ret;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wmi_has_guid(LENOVO=
_SET_BIOS_SETTINGS_GUID) &&
>> @@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 char *p;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 tlmi_priv.setting[i] =3D NULL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 status =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID)=
;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret)
>
> Really minor, but tweak to be this and save a line of code?

This hunk is actually from another commit and should not be needed here.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
drivers/platform/x86/think-lmi.c?id=3Dda62908efe80f132f691efc2ace4ca67626de=
86b

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID))
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (!item)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> @@ -1457,10 +1458,10 @@ static int tlmi_analyze(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * name string.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Try and pull that out if it's available.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *item,=
 *optstart, *optend;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *optit=
em, *optstart, *optend;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tlmi_s=
etting(setting->index, &item,
>> LENOVO_BIOS_SETTING_GUID)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optstart =3D strstr(item, "[Optional:"=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tlmi_s=
etting(setting->index, &optitem,
>> LENOVO_BIOS_SETTING_GUID)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optstart =3D strstr(optitem,
>> "[Optional:");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (optstart) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 optstart +=3D
>> strlen("[Optional:");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 optend =3D strstr(optstart, "]");
>> @@ -1469,6 +1470,7 @@ static int tlmi_analyze(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> kstrndup(optstart, optend - optstart,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> GFP_KERNEL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(optitem);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>
>> I have tested it, but without a few blunders of my own.
>
> I'm running a build locally and will aim to put this thru a few different=
 platforms myself too and sanity check
>
>> I guess "nobody wins them all".
>
> I hear you :P
> > Mark

