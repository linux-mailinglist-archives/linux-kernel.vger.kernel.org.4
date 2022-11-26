Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F56393A8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiKZDVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZDVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:21:45 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B207D59FD3;
        Fri, 25 Nov 2022 19:21:44 -0800 (PST)
Date:   Sat, 26 Nov 2022 04:21:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669432902;
        bh=3gQNFPEkrfk8FvgThUUGBp+W3qYIQb/nNsoP6AUOaTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRgBqf6WTtWmYUYXJtCA6bvY96IGwztRM3DzYkHCgF4S2luXcpBwHU2IzbEX3C6qL
         NK2DEKnF8pj/CeJEztiC2hs74UpC91vDgTENNfVIDu7D4zYcIkmEiJUA7oobqDxEtb
         GmUfDvFDkOj8vxKyc7TE/XtoPgvLaOIq0UwZm888=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: Report firmware_version in sysfs
Message-ID: <12d52741-4cf9-4c95-a8c7-f563e149da9a@t-8ch.de>
References: <20221125222315.4925-1-linux@weissschuh.net>
 <da94449e-d250-1b44-0e72-f951b73b1946@roeck-us.net>
 <ddd1ea7b-0be7-4c16-a5ac-56516f955ef9@t-8ch.de>
 <7c38ad68-49cb-0f8a-18a4-fa78f0429bdd@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c38ad68-49cb-0f8a-18a4-fa78f0429bdd@roeck-us.net>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-25 17:46-0800, Guenter Roeck wrote:
> On 11/25/22 17:00, Thomas Weißschuh wrote:
>> On 2022-11-25 16:37-0800, Guenter Roeck wrote:
>>> On 11/25/22 14:23, Thomas Weißschuh wrote:
>>>> This synchronizes the information reported by ioctl and sysfs.
>>>> The mismatch is confusing because "wdctl" from util-linux uses the ioctl
>>>> when used with root privileges and sysfs without.
>>>> 
>>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>>> 
>>>> ---
>>>> 
>>>> Userspace implementation:
>>>> 
>>>> https://github.com/util-linux/util-linux/pull/1927
>>>> ---
>>>>    drivers/watchdog/watchdog_dev.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>> 
>>>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>>>> index 55574ed42504..88c76e27873c 100644
>>>> --- a/drivers/watchdog/watchdog_dev.c
>>>> +++ b/drivers/watchdog/watchdog_dev.c
>>>> @@ -555,6 +555,15 @@ static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
>>>>    }
>>>>    static DEVICE_ATTR_RO(identity);
>>>> +static ssize_t firmware_version_show(struct device *dev, struct device_attribute *attr,
>>>> +				     char *buf)
>>>> +{
>>>> +	struct watchdog_device *wdd = dev_get_drvdata(dev);
>>>> +
>>>> +	return sysfs_emit(buf, "%d\n", wdd->info->firmware_version);
>>>> +}
>>>> +static DEVICE_ATTR_RO(firmware_version);
>>>> +
>>>>    static ssize_t state_show(struct device *dev, struct device_attribute *attr,
>>>>    				char *buf)
>>>>    {
>>>> @@ -618,6 +627,7 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
>>>>    static struct attribute *wdt_attrs[] = {
>>>>    	&dev_attr_state.attr,
>>>>    	&dev_attr_identity.attr,
>>>> +	&dev_attr_firmware_version.attr,
>>>>    	&dev_attr_timeout.attr,
>>>>    	&dev_attr_min_timeout.attr,
>>>>    	&dev_attr_max_timeout.attr,
>>>> 
>>>> base-commit: 0b1dcc2cf55ae6523c6fbd0d741b3ac28c9f4536
>>> 
>>> I think this conflicts with drivers/watchdog/ziirave_wdt.c which generates its own
>>> firmnware_version attribute.
>> 
>> Indeed, thanks for the catch.
>> 
>> We probably can't change the attribute from ziirave_wdt, which is a bit
>> unfortunate as "firmware_version" would nicely match the name from
>> "struct watchdog_info".
>> 
>> How about "fw_version"?
>> 
> 
> I don't have a better idea. Go for it.

Will do.

>> That would match the naming of sysfs attributes from a bunch of other
>> subsystems.
>> 
>> And obviously an addition to Documentation/ABI/testing/sysfs-class-watchdog is
>> also missing from the patch.
>> I'll add it in v2.

Can I put you or Wim as contact into the docs?

It feels weird to have a random drive-by contributor listed there.

Thomas
