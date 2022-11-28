Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9E639EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 02:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiK1BgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 20:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK1BgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 20:36:14 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E52AE65;
        Sun, 27 Nov 2022 17:36:13 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:36:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669599371;
        bh=sHHrSIsccnZzCKQNwO/lZGryhsA4szb1WczJqiHZqkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsKQSq71IfzOSi5PvZIhwEcax6W/22PqlvoSDt74GltlAEbM/VfLty1cJKELXlxL5
         k+u7iPZiOyO/ocqv/4zEy3L6yaCNtdDaLAKngwvp/9bUBfPv3gDQOfU68XdcttQagS
         cSKHVbJli7bGUhc/sii9ZQIVRHaVpGEoXPH0Xb9M=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] watchdog: core: don't reset KEEPALIVEPING through
 sysfs
Message-ID: <63e88f05-0431-429b-8285-7dcd7e5782fe@t-8ch.de>
References: <20221127154559.80899-1-linux@weissschuh.net>
 <6ee65abe-8620-956d-a4a2-4ec5ec6257a5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ee65abe-8620-956d-a4a2-4ec5ec6257a5@roeck-us.net>
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

On 2022-11-27 08:47-0800, Guenter Roeck wrote:
> On 11/27/22 07:45, Thomas Weißschuh wrote:
>> Reading the watchdog status via ioctl(WDIOC_GETSTATUS) or sysfs will
>> reset the status bit KEEPALIVEPING.
>> 
>> This is done so an application can validate that the watchdog was pinged
>> since the last read of the status.
>> 
>> For the ioctl-based interface this is fine as only one application can
>> manage a watchdog interface at a time, so it can properly handle this
>> implicit state modification.
>> 
>> The sysfs "status" file however is world-readable. This means that the
>> watchdog state can be modified by any other unprivileged process on the
>> system.
>> 
>> As the sysfs interface can also not be used to set this bit, let's
>> remove the capability to clear it.
>> 
>> Fixes: 90b826f17a4e ("watchdog: Implement status function in watchdog core")
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> 
>> ---
>> 
>> I was not able to find an application (besides wdctl) that uses this
>> bit. But if applications are to use it, it should probably be reliable.
>> 
>> Other possible solutions I can think of:
>> * Only reset the bit when the file opened privileged
>> * Only reset the bit when the file opened writable
>> 
> 
> All suggested solutions would be changing the ABI, which would be problematic.
> 
> As you have proposed elsewhere, it is possible for applications to chose where
> to get the status from: sysfs or ioctl. It may well be that there is some
> application out there which uses the sysfs attribute to read the status
> and the ioctl otherwise. That would be odd, but possible.
> 
> Also, I can not imagine a real world use except for maybe reading the status
> bit using sysfs from one application and checking if the watchdog demon actually
> pinged it as it should ... but that is exactly what you are trying to disable
> here.

Good point.

> Overall, this is probably the least valuable status bit. Any application should
> know if it pinged the watchdog or not.
> 
> So: What real world problem have you observed that you are trying to solve ?
> If there is no real observed problem, we should not entertain changing the ABI.
> Actually, we can not change the ABI We would have to add another non-invasive
> attribute that doesn't change the status when read. That should really be
> worth the trouble.

I have not observed a real problem, only weird behavior while working on wdctl.
From this I figured that this could be a problem in case another, malicious or broken
process accesses the state file and resets the status bit.

To make you aware of this observation I sent the RFC patch.

If you think it's not a problem worth fixing this patch can be dropped.

> Guenter
> 
>> Instead of using a status bit to check if the watchdog was pinged it
>> would probably be more robust to use a sequence counter or timestamp.
>> Especially as it seems more operations are being exposed over sysfs over
>> time.
>> 
>> I'm not sure it's worth it though.
>> ---
>>   Documentation/ABI/testing/sysfs-class-watchdog |  3 ++-
>>   drivers/watchdog/watchdog_dev.c                | 13 +++++++++----
>>   2 files changed, 11 insertions(+), 5 deletions(-)
>> 
>> [..]
