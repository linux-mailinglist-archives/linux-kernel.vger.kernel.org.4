Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935045EC86C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiI0PrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiI0Pqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:46:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3862438B5;
        Tue, 27 Sep 2022 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664293461;
        bh=xapIOah0tx06ZorbO2OBOQdT6JMIjrDJogdiPnNn/+g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jVzcNPrCjUtznpRRl8i1wIdrxVOTWjy7GI27X+VbWjmuQS8iU2WXQ5QrfQ+d8tLty
         +tRKsj3T/5mVcQ86y/vwI8uwOQiSym9nIXOPg8ruFZGWstWxB1vYlDqR0KbnFSVBFW
         Kw5gUjmxOJuakdZH0gskmZ0MlOLHQyMLnVBHQwKE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1oURKX1oDw-008p78; Tue, 27
 Sep 2022 17:44:21 +0200
Subject: Re: [PATCH 1/5] ACPI: battery: Do not unload battery hooks on single
 error
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>, Len Brown <lenb@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Matan Ziv-Av <matan@svgalib.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Jeremy Soller <jeremy@system76.com>, productdev@system76.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-2-W_Armin@gmx.de>
 <f8fa6d10-6eb1-7fa7-80eb-ea190d29ba4a@redhat.com>
 <CAJZ5v0jWVMMTjc+KtBRS86f8kYpbPcDCH9JV2ZgeN4f-MSO8rQ@mail.gmail.com>
 <f2af5d01-a2cd-ae96-24c7-d61f5f0d0bc3@gmx.de>
 <f0b17ba6-3d3c-cbc1-ec0d-ec59c73f06f6@gmx.de>
 <471449b3-cced-d75d-e349-6bec950b0bc1@redhat.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <f6ac14a8-6403-029e-6179-f8ef0a7d5457@gmx.de>
Date:   Tue, 27 Sep 2022 17:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <471449b3-cced-d75d-e349-6bec950b0bc1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:5MyBv8IKsYLuUsVsJMopstbGuvu343mvzrzSNTs3XpZouvuB+sw
 41Id43MAQxI3DUcH2Ni9/Ogq+LyWZatySfktIDCOJJBL6UwWRG1/cH2NgEkWSvaNvGgId9f
 d9DC3xV/45bIaUxdfrfLJdE06TKCrXzPJfStc0A4jXrba5KM+5lsGsFu1am2x2YVOGUmamy
 GJjPotM7zMCpkaM2iPGfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dj8zzLGJBJ8=:yEiB015XrdNoRKwZ8QnYti
 2J5lDllNRvJ6Z5Q0FjkuLLlaN2OlVTKzpVpR/ymF/sDHXckj7FhmZPM0HUwOZo0Sk+8PgkXi2
 xg7YYVOOZVW/fV2j/+57tKRO42/P9TPgSd+h4Fp1lKj1JnXNfDLOtc0g43aRIDiQjaiyJwDmk
 teiy5sFa2kc0PFDIW3RPg1hWo31NBeuJe8zj1mUyVIwAUrlG+lv6hIYuo3GBOYW6q5JLY1TVb
 qhQD20nM3oZWe5OAE3mHoaOa/RmAvhu4/dWYx5ug26tzFfgngw2eUMDgjNMuvIdwU8jkx95vS
 axCgPbiEEaomUJrCipIkyGwoJ0tJUQsdv6oRYnX5acxKUtL2kM/WXs4nfgOIOjtyRP/WL8LuB
 0NJhbvzNgbu/PxS0MbsJk5o8UrZMavA3mSmhz8xNityx6z8YXJaaNVtHPl+U8m+GmFrg3Is9D
 RSsmqDz042udb7TZ2fwcjGZvtnvRkcXy/A8yzo2dYfcZ5sVOYbtlV13ZzCuQ7kL26ZV3sSvvP
 NZbYuHUJgefgN596lcxhIz49vCHdjkapQ1DYWHCYU5QxSAGLWNjesxggIuuMSnQnoHJQDPrhw
 1ATfwfY2XLDDpGVfAb1Jug8p8hxtOIqGXqa6DEICurOewGl8+H4saIfsnMNv/P9oVWfOs1/ZT
 IdAxECIDEye/0qUFsZrAnkriJATabEWWYsLOh6cslAW2ZYCqQzL5zI0WEphCTS/8xiOe5ahO4
 o/mFx0pTnS5JJtV9oyvZXjwaF8x8hPq143NF26zCbVC6teC51XQfqLTw/d/NUvMSnnHC0yoHr
 2SeqJbz9EMezMJval78U7lpcRSJ8rIxpssg0gVPuOa+yDytN8Yve+LjAqH+skyq5fKOFs+rHh
 E2+uvk9x1yohwfNvcRhigwk6/1GYeDDTwWEVp2nomSYiHMOOoMbCu91/N24JMpZwUxtgrFj0M
 DyAbFH1zNACxVREPTdBCRSnroDtNFrTr07mvhZJJOZBPdEoHNybwGMO0A0IfWwf3KnkL0/kCO
 OpK1/4pIsGPpqDBfGAESR3M7BVT2s8sVGWEmZ7WN0XbDw0iADaBG7ONZ/KmcnSi3dQmF5M7x2
 Hn3ACkZHZgKsbuyHxe2VFT63QdTAr5ELnS45Dnld57tlofDtC+9Xrb1jCX23o55AAgwqGITww
 RmYbKkjSXhru5vmmaYZUGA00C1
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_H2,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.09.22 um 16:29 schrieb Hans de Goede:

> Hi,
>
> On 9/19/22 22:35, Armin Wolf wrote:
>> Am 19.09.22 um 21:12 schrieb Armin Wolf:
>>
>>> Am 19.09.22 um 18:27 schrieb Rafael J. Wysocki:
>>>
>>>> On Mon, Sep 19, 2022 at 12:42 PM Hans de Goede <hdegoede@redhat.com> =
wrote:
>>>>> Hi,
>>>>>
>>>>> On 9/12/22 13:53, Armin Wolf wrote:
>>>>>> Currently, battery hooks are being unloaded if they return
>>>>>> an error when adding a single battery.
>>>>>> This however also causes the removal of successfully added
>>>>>> hooks if they return -ENODEV for a single unsupported
>>>>>> battery.
>>>>>>
>>>>>> Do not unload battery hooks in such cases since the hook
>>>>>> handles any cleanup actions.
>>>>>>
>>>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>>> Maybe instead of removing all error checking, allow -ENODEV
>>>>> and behave as before when the error is not -ENODEV ?
>>>>>
>>>>> Otherwise we should probably make the add / remove callbacks
>>>>> void to indicate that any errors are ignored.
>>>>>
>>>>> Rafael, do you have any opinion on this?
>>>> IMV this is not a completely safe change, because things may simply
>>>> not work in the cases in which an error is returned.
>>>>
>>>> It would be somewhat better to use a special error code to indicate
>>>> "no support" (eg. -ENOTSUPP) and ignore that one only.
>>> I would favor -ENODEV then, since it is already used by quiet a few dr=
ivers
>>> to indicate a unsupported battery.
>>>
>>> Armin Wolf
>>>
>> While checking all instances where the battery hook mechanism is curren=
tly used,
>> i found out that all but a single battery hook return -ENODEV for all e=
rrors they
>> encounter, the exception being the huawei-wmi driver.
> Right, so this means that using -ENODEV to not automatically unload the
> extension on error will result in a behavior change for those drivers,
> with possibly unwanted side-effects.
>
> As such I believe that using -ENOTSUP for the case where the extension
> does not work for 1 battery but should still be used for the other
> batter{y|ies} would be better as this preserves the existing behavior
> for existing drivers.
>
>> I do not know the reason for this, but i fear unloading the extension o=
n for
>> example -ENOTSUP will result in similar behavior by hooks wanting to av=
oid being
>> unloaded on harmless errors.
> I am not sure what you are trying to say here. The whole idea is
> to add new behavior for -ENOTSUP to allow drivers to opt out of
> getting their extension unregistered when they return this.
>
> Although I wonder why not just have extensions return 0 when
> they don't want to register any sysfs attr and that not considered
> an error. If it is not considered an error the hook can just
> return 0, which would not require any ACPI battery code changes
> at all. So maybe just returning 0 is the easiest (which is
> also often the best) answer here?

I agree, i will send v2 soon.

Armin Wolf

>> However, i agree that when ignoring all errors, battery extensions whic=
h provide
>> similar attributes may currently delete each others attributes.
> AFAIK there are no cases where more then 1 extension driver gets loaded,
> since all the extension drivers are tied to a specific vendor's interfac=
es
> so we won't e.g. see the thinkpad_acpi driver load on the same laptop as
> where toshiba_acpi also loads.
>
> IOW I think you are trying to solve a problem which does not exist here.
>
> Regards,
>
> Hans
>
>
>
>
>> Any idea on how to solve this?
>>
>> Armin Wolf
>>
>>>>>> ---
>>>>>>  =C2=A0 drivers/acpi/battery.c | 24 +++---------------------
>>>>>>  =C2=A0 1 file changed, 3 insertions(+), 21 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>>>>>> index 306513fec1e1..e59c261c7c59 100644
>>>>>> --- a/drivers/acpi/battery.c
>>>>>> +++ b/drivers/acpi/battery.c
>>>>>> @@ -724,20 +724,10 @@ void battery_hook_register(struct acpi_batter=
y_hook *hook)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * its attributes.
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(battery, =
&acpi_battery_list, list) {
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (hook->add_battery(battery->bat)) {
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If a add-ba=
ttery returns non-zero,
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the registr=
ation of the extension has failed,
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and we will=
 not add it to the list of loaded
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * hooks.
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("extension f=
ailed to load: %s", hook->name);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __battery_hook_unre=
gister(hook, 0);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto end;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hook->add_battery(battery->bat);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("new extension: %s\n"=
, hook->name);
>>>>>> -end:
>>>>>> +
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&hook_mutex);
>>>>>>  =C2=A0 }
>>>>>>  =C2=A0 EXPORT_SYMBOL_GPL(battery_hook_register);
>>>>>> @@ -762,15 +752,7 @@ static void battery_hook_add_battery(struct ac=
pi_battery *battery)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * during the battery mo=
dule initialization.
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry_safe(hook=
_node, tmp, &battery_hook_list, list) {
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (hook_node->add_battery(battery->bat)) {
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The notific=
ation of the extensions has failed, to
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * prevent fur=
ther errors we will unload the extension.
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("error in ex=
tension, unloading: %s",
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hook_node->name);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __battery_hook_unre=
gister(hook_node, 0);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hook_node->add_battery(battery->bat);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&hook_mutex);
>>>>>>  =C2=A0 }
>>>>>> --
>>>>>> 2.30.2
>>>>>>
