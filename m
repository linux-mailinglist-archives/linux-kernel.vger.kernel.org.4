Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F09574DE14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGJTWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGJTWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:22:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76D8BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:22:03 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qIwSH-0006F7-SJ; Mon, 10 Jul 2023 21:21:53 +0200
Message-ID: <fa3d706a-57e9-9ca6-9d7d-a7a2b62960e1@pengutronix.de>
Date:   Mon, 10 Jul 2023 21:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] thermal: core: constify params in
 thermal_zone_device_register
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230708112720.2897484-1-a.fatoum@pengutronix.de>
 <CAJZ5v0h6_jzOBxhmd2b8WL5nVOvZ03AD5fzdtc9ACXGiCKEmOw@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CAJZ5v0h6_jzOBxhmd2b8WL5nVOvZ03AD5fzdtc9ACXGiCKEmOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10.07.23 19:33, Rafael J. Wysocki wrote:
> On Sat, Jul 8, 2023 at 1:27 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>> Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
>> parameters structure"), thermal_zone_device_register() allocates a copy
>> of the tzp argument and callers need not explicitly manage its lifetime.
>>
>> This means the function no longer cares about the parameter being
>> mutable, so constify it.
>>
>> No functional change.
>>
>> Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
> 
> Why is this particular patch regarded as a fix?

That the prototype wasn't adjust in aforementioned commit is IMO an oversight,
so this commit fixes that. As the commit is already referenced in the commit
message body, I don't mind dropping the Fixes: line. Please let me know if
I should resend.

Cheers,
Ahmad

>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>>  drivers/thermal/thermal_core.c | 4 ++--
>>  include/linux/thermal.h        | 6 +++---
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 842f678c1c3e..cc2b5e81c620 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1203,7 +1203,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>>  struct thermal_zone_device *
>>  thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
>>                                         void *devdata, struct thermal_zone_device_ops *ops,
>> -                                       struct thermal_zone_params *tzp, int passive_delay,
>> +                                       const struct thermal_zone_params *tzp, int passive_delay,
>>                                         int polling_delay)
>>  {
>>         struct thermal_zone_device *tz;
>> @@ -1371,7 +1371,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
>>
>>  struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
>>                                                          void *devdata, struct thermal_zone_device_ops *ops,
>> -                                                        struct thermal_zone_params *tzp, int passive_delay,
>> +                                                        const struct thermal_zone_params *tzp, int passive_delay,
>>                                                          int polling_delay)
>>  {
>>         return thermal_zone_device_register_with_trips(type, NULL, ntrips, mask,
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 87837094d549..dee66ade89a0 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -301,14 +301,14 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
>>  #ifdef CONFIG_THERMAL
>>  struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
>>                 void *, struct thermal_zone_device_ops *,
>> -               struct thermal_zone_params *, int, int);
>> +               const struct thermal_zone_params *, int, int);
>>
>>  void thermal_zone_device_unregister(struct thermal_zone_device *);
>>
>>  struct thermal_zone_device *
>>  thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int, int,
>>                                         void *, struct thermal_zone_device_ops *,
>> -                                       struct thermal_zone_params *, int, int);
>> +                                       const struct thermal_zone_params *, int, int);
>>
>>  void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
>>  const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
>> @@ -348,7 +348,7 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz);
>>  static inline struct thermal_zone_device *thermal_zone_device_register(
>>         const char *type, int trips, int mask, void *devdata,
>>         struct thermal_zone_device_ops *ops,
>> -       struct thermal_zone_params *tzp,
>> +       const struct thermal_zone_params *tzp,
>>         int passive_delay, int polling_delay)
>>  { return ERR_PTR(-ENODEV); }
>>  static inline void thermal_zone_device_unregister(
>> --
>> 2.39.2
>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

