Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEA95BD51A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiISTMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISTMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:12:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B37315724;
        Mon, 19 Sep 2022 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663614722;
        bh=vsxyNPqECA66yaOhsz2gXtpE/um3nthTtnFhYLNOFPU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DtWw9DuyAWeKHjLe1m+BKX1gt189BUrk/Ksxh0glH1tQ6X50p74Y30Qu2fI8a7Yq6
         W2bqn9RHidiav6l75RMLdt12F8skoGVyw4/E/aTrXu+0P89vEnXuBvVgN4F5/ny7tV
         LOuIZ4N9ZsKmbHhVp4avWE+J9rfw7kW9XPC4yGKM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1ouCOP3aiu-00OIt0; Mon, 19
 Sep 2022 21:12:01 +0200
Subject: Re: [PATCH 1/5] ACPI: battery: Do not unload battery hooks on single
 error
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
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
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <f2af5d01-a2cd-ae96-24c7-d61f5f0d0bc3@gmx.de>
Date:   Mon, 19 Sep 2022 21:12:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jWVMMTjc+KtBRS86f8kYpbPcDCH9JV2ZgeN4f-MSO8rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:Cj4c7h/B17rFacKbVdPkRfdMhKLXT9mkXLYu6pCzELjJ/MsLyFB
 6s/5JApCGlvFFImHpJCmz0CIkyeJYmHXgi/aawm/ptXCIz3LynCMJXiE8tBRMBpRqdrYnL+
 CyRAhAiObPKaT72AjWtrEal78E1BkCoxuY9xEkwrnoevvPNMJqmLMfRgZ9sdjZUDd3+lG2E
 Au7WMhqAZCG2UxXY1YFiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OCgC4Y2BwGM=:0xULy9rZtD3KstlO+f4e2p
 hmGTTrBdeZBJaDL4kBpkfuRjki9FjWhb6aT836osJUDNGeE0t2QrVIeBNcRWtaUhYEViiLlD2
 8P8fs3gJo8yDogfDOCTf+Qa8jeKWnqaWBSQfs7e2bLHD0s1gHUGEsxb0ZcjWAgIojk7W0GwC2
 7O0RIM5vmjh6Kjb9ZAViAoxnZIMXuLL46e5MhSXpB7qg4np8UT1m26juHCH9Do+jslTmSgOu/
 jP21qfAbKifuQ8FmWyxKK3DF7BkXA3xww/CW9Gzx/dMm78XvhZpD37DQRy5XMhPcdmPkugjMM
 fgmbeN3XkJHLo+RI178eFfGFNPLGmrFu2Uf/P6rIPu8hFIWGY3p9/KsPC+qqsp8kkcjV1fxSL
 sx1y29Nnm3xBynYNFB0obkUIzvrVv2ML28iAkYS6sk9L9pai1Wflea3DW0JcZ05uvubhPON/L
 yf4yJoVtU1NznE/XMZgxr6qvsd34d2G7px+hJSJilz9iD3AGKMiu0mvI9K6pv2vSedPlPKRsc
 ctnxqWnXLhwK9WGU81Ggw2FCMlVN3ObyzHWcFVmqr6NqXZB4EtffHOp+vPtFUqbxH6m7zhMxs
 D5Ki3cGclMEQ4Tg9V8q6cWv/em9PatqDiWTkVI99QwSdGQg4q6Vb1Mi504OgoybmO404Z7I/q
 a8jB3H3Tuwr3+E7nlAk099Tc9X8cRm8UraCNofvWV47BM0uEwWNL+xGp4fK4fSeKiorlUKXBo
 /QTUU6iM5SJG2/NECcGReskzy2CZfGB9g481DoRb0DDYD1FjOsmhbamGDCn3UJgn8Th2m/VFW
 Y4dNViKtYcCumBarCsx0bzkfyANdGFIqW7ALyca3stP1K/sWaQeVPNyqqICu3KAIKtDxtd582
 16VwDgFpCGvK8LkKwaykA3axWSmbc3WxNUqcJkQm/qV61gwnDtxSP5XB8PEuaUZa86TjNwj28
 8sIDlvIMacbbub2M6c00rSm7ftH5JEo2WbcrUkrrCszbhIM8yUA9EqnwteCnf1sZHKUSRovT6
 g1JVe8fvGS1Ru3a056eaImZeorNoBc38l2FHMmEaNKXl5Um6hkDSYHydNf072ILRp1wi7zHpS
 UQ/PbMDB/lo+RCr9BOyt5Xyv6A0n1v2/XOX/yDNxO2W8rysmvOxddUhWBkQ9gRx0g0GjLlzFM
 vciUJoXhvm18ynEUAcaIfXmxRH
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.09.22 um 18:27 schrieb Rafael J. Wysocki:

> On Mon, Sep 19, 2022 at 12:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 9/12/22 13:53, Armin Wolf wrote:
>>> Currently, battery hooks are being unloaded if they return
>>> an error when adding a single battery.
>>> This however also causes the removal of successfully added
>>> hooks if they return -ENODEV for a single unsupported
>>> battery.
>>>
>>> Do not unload battery hooks in such cases since the hook
>>> handles any cleanup actions.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> Maybe instead of removing all error checking, allow -ENODEV
>> and behave as before when the error is not -ENODEV ?
>>
>> Otherwise we should probably make the add / remove callbacks
>> void to indicate that any errors are ignored.
>>
>> Rafael, do you have any opinion on this?
> IMV this is not a completely safe change, because things may simply
> not work in the cases in which an error is returned.
>
> It would be somewhat better to use a special error code to indicate
> "no support" (eg. -ENOTSUPP) and ignore that one only.

I would favor -ENODEV then, since it is already used by quiet a few drivers
to indicate a unsupported battery.

Armin Wolf

>>> ---
>>>   drivers/acpi/battery.c | 24 +++---------------------
>>>   1 file changed, 3 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>>> index 306513fec1e1..e59c261c7c59 100644
>>> --- a/drivers/acpi/battery.c
>>> +++ b/drivers/acpi/battery.c
>>> @@ -724,20 +724,10 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>>>         * its attributes.
>>>         */
>>>        list_for_each_entry(battery, &acpi_battery_list, list) {
>>> -             if (hook->add_battery(battery->bat)) {
>>> -                     /*
>>> -                      * If a add-battery returns non-zero,
>>> -                      * the registration of the extension has failed,
>>> -                      * and we will not add it to the list of loaded
>>> -                      * hooks.
>>> -                      */
>>> -                     pr_err("extension failed to load: %s", hook->name);
>>> -                     __battery_hook_unregister(hook, 0);
>>> -                     goto end;
>>> -             }
>>> +             hook->add_battery(battery->bat);
>>>        }
>>>        pr_info("new extension: %s\n", hook->name);
>>> -end:
>>> +
>>>        mutex_unlock(&hook_mutex);
>>>   }
>>>   EXPORT_SYMBOL_GPL(battery_hook_register);
>>> @@ -762,15 +752,7 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
>>>         * during the battery module initialization.
>>>         */
>>>        list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
>>> -             if (hook_node->add_battery(battery->bat)) {
>>> -                     /*
>>> -                      * The notification of the extensions has failed, to
>>> -                      * prevent further errors we will unload the extension.
>>> -                      */
>>> -                     pr_err("error in extension, unloading: %s",
>>> -                                     hook_node->name);
>>> -                     __battery_hook_unregister(hook_node, 0);
>>> -             }
>>> +             hook_node->add_battery(battery->bat);
>>>        }
>>>        mutex_unlock(&hook_mutex);
>>>   }
>>> --
>>> 2.30.2
>>>
