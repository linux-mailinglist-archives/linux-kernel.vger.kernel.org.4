Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11466EFB2F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjDZTf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjDZTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:35:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB72114;
        Wed, 26 Apr 2023 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682537734; i=w_armin@gmx.de;
        bh=XUyH3MfpE05wPAy94z/OMdVQELABtgu+fF1W2bG9JFE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TejFsH/6s5qsgGmRxhUaCTudQowayTMcrbFkJX8pL0zm0cpTuVu5O6Kn5I9FZdX8W
         4MgewEr3Wf46200+6QAAZ7+1CvSRcVBu9Z5PPnHpmGga8glEgvirsR3yoCMVtnt/Rq
         6VBZkN2IKWJfy1Irfh1vSQON9dxvKOsZUWwVF0cZT/lkSqruQyL+t5f4D1SEkBZq1+
         VKrlKFSF7DoRulTcVCmNyK39atzxkWTxkcBVMLQ4mGTuHpUpQJ1qPGqjWjuw6ReNKa
         m1v5J4h+gO4IvsVja0qDhPCYmPA9FrsE5I9pxh5qzkj9PQrbaZgL2P0iajDBceWdwc
         WVnr/FXfqbGNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsj7-1pYhRL1mRB-00LEfw; Wed, 26
 Apr 2023 21:35:34 +0200
Subject: Re: [PATCH v3] hwmon: add HP WMI Sensors driver
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424100459.41672-1-james@equiv.tech>
 <cd81a7d6-4b81-f074-1f28-6d1b5300b937@gmx.de> <ZEkkLggFLCGlvq8f@equiv.tech>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <30339393-0ba2-9788-6ad8-98c89afc6994@gmx.de>
Date:   Wed, 26 Apr 2023 21:35:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ZEkkLggFLCGlvq8f@equiv.tech>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:JICnlOZNxItB8HUgNhCGxiBjBIfr4pYanULL+MdXEvBHoz27QIr
 ASWWzKRP+r1wLi8W6l5YmQDwM6nczVZac4VvqajxEt7ywl/+7aX3CZ71v3u6SDSqSfNwQzm
 jDZvzrqErUg3VJHpaa9/KE/r5SyRO3fDaU9FP7vuUhhP8AOkW8uzwFgzYZ1Wp1TRObbP5Dj
 9MRSKtTGWlBvFVNbQAM5g==
UI-OutboundReport: notjunk:1;M01:P0:pR37t2XA8UM=;Cr1AtwwTuiNUxuE9z126nonbvxT
 lJYSojLUODYDt/x7H09x34tjf1+yuWlmNrqMJYKuqiECHRj/g6IkCpNzYhmIhil5p5nULX6RI
 bi1t9BLuPAThPC5KEbRcxqo6Ez/Y7xKFSRmc5V00mObjzYIH7Uy9bl3/3+bcBVzrmXbVGRMIb
 YSc/XezvG+K529+0tXhvrvvUzaixidYBOGrReIuidBtv8aWX/1PiyNYaHJMNFbyIzUcCHqXMk
 62LQIbLoTiRtsiatsJ5s5mwSWl4Vb5Hi3O87931ANXHBCIckG0j9HmJZssB5nrsHbLApZ7U8t
 BtYANDpPsFns+pGQwNYcqoEXf6Tjks4NunE82kTfOfvU/BiEJkXsQuxCM+n38uO8GNnzcwZOZ
 tE9uvASScl2UX7T0UXsDuVNXOFpcvUkHLkCzQaNwmRKd0kFh2T7UTx8+znH4qm9go3npIvy7r
 0wC/Oron4FL6tRNz3QhBSRZONUeXpQhVrsY2MHjxpOFsXE+zfnwywQOFa0z662W5hOlSEoubQ
 QkkpsFtFRcaDPxXD61i09kfKyrwhv3MPCAjdxL1+CA/TIJ4IIvaIRhiEMP0hUjNRcAljWdowX
 H6X4gv+cKqABED9NR5DMo1LoPaPcAT4hqXxtlZo4B1XlTbUH/N2thnVoTEntd5JtJw7L1s2FX
 SM3u9GaCvTxOaTX/DMNIS3ALg/FUPY5PlwDqH4EU9LHI96Gk3lrSveL2KjhVt/XDvSqdEiv4F
 lxfADIquxlXa1QKaguMJlM6Lx8YQJ0yoqw7xh8eIWBMoqexJ3sz0xyOpPYvspBmPLulg8HFnQ
 2OMC40K3GkXOgrjdRJ7takVowXOi02ebWBhib7XFLxWKG4/O7FuGFW2HfwYMEt3GWfCh0Ysai
 BgG/zIhv/79xZjs1QJF9ipfozhgzcs9rN0a/IEuRs9geK11Au+lrzrw4GKzE6/+2t2IXD1vD4
 TAz54nwGT62SkQJ+PUIzRXaxoHI=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.04.23 um 15:16 schrieb James Seo:

> On Mon, Apr 24, 2023 at 11:13:36PM +0200, Armin Wolf wrote:
>> Am 24.04.23 um 12:05 schrieb James Seo:
>>
>>> +	for (i = 0; i < HP_WMI_MAX_INSTANCES; i++, pevents++) {
>> Hi,
>>
>> the WMI driver core already knows how many instances of a given WMI object are available.
>> Unfortunately, this information is currently unavailable to drivers. Would it be convenient
>> for you to access this information? I could try to implement such a function if needed.
>>
>>> +	for (i = 0; i < HP_WMI_MAX_INSTANCES; i++, info++) {
>> Same as above.
>>
> Hello,
>
> Having the WMI object instance count wouldn't make much difference to
> me for now. The driver has to iterate through all instances during
> init anyway. If I were forced to accommodate 50+ sensors, I'd rewrite
> some things and I think I'd want such a function then, but I picked
> the current arbitrary limit of 32 because even that seems unlikely.
>
> So, maybe don't worry about it unless you want to. Or am I missing
> something?
>
Hi,

i already have a experimental patch available which adds such a function.
If you could test this patch to see if it works, then i could submit it upstream
where other drivers could profit from being able to know the number of
WMI object instances.

Your driver could also profit from such a function, as it could optimize the amount
of memory allocated to store WMI object data. The current instance discovery algorithm
(using a for-loop and break on error) also has a potential issue: when a single WMI call
fails for some reason (ACPI error, ...), all following WMI instances are being ignored.

I will post a RFC patch implementing such a function and CC you and a couple of people
who might be interested. If you want to test this function, then you can use this patch.
If you find out that the function does not work for you, then you can just continue with
your current approach.

Armin Wolf

>>> +	err = wmi_install_notify_handler(HP_WMI_EVENT_GUID,
>>> +					 hp_wmi_notify, state);
>> As a side note: the GUID-based interface for accessing WMI devices is deprecated.
>> It has known problems handling WMI devices sharing GUIDs and/or notification IDs. However,
>> the modern bus-based WMI interface (currently) does not support such aggregate devices well,
>> so i think using wmi_install_notify_handler() is still the best thing you can currently do.
>>
> Interesting. Of course I had no idea. Though, for some strange
> reason, it does look like some documentation to that effect has
> emerged on the topic since the last time I checked ;)
>
>>> +	if (err) {
>>> +		dev_info(dev, "Failed to subscribe to WMI event\n");
>>> +		return false;
>>> +	}
>>> +
>>> +	err = devm_add_action(dev, hp_wmi_devm_notify_remove, NULL);
>>> +	if (err) {
>>> +		wmi_remove_notify_handler(HP_WMI_EVENT_GUID);
>>> +		return false;
>>> +	}
>> Maybe use devm_add_action_or_reset() here?
> Will do.
>
> Thanks for reviewing/writing.
>
> James
