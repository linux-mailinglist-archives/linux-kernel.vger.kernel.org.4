Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47E9665461
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjAKGJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjAKGJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:09:41 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81838DF37;
        Tue, 10 Jan 2023 22:09:39 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 840C87E4CF;
        Wed, 11 Jan 2023 06:09:37 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673417379;
        bh=NkdpfklbguF0iKykjTEZLjjzqPuc3x168kbqCcp4VOI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=QHROOwny6tEFS1M7PYvD89/YUY95YHQ5d4OKOzFwAnOrmH/m9BYzL7yGuV0P9SlMi
         FZ9lzNN1WA7uSzvZBGSdvdf0YfmCdAxKy6K8Ea0p0SVJX04qF2Sts8w8te2Zoh7R80
         +vG390AdzZRoPSY1zqODPlRe9RltD0Wsib+7AkcYHik6SevO5ViArmWAFwnKggszFG
         oVAbN4Mw9sBD2LGjm7TA908BzA7wdz8poidxuIyJhb8XXmoYjoCrJoCc1Po0VSuNzA
         jcXgavPdUgT8zKu12XlWx3O4MXMIJfDCMOgQj+dmo0b4TmKNHCvdn02lCjzaoJHLur
         iMVlzPkv8fVGQ==
Message-ID: <dada9a9c-32fd-9d8c-b692-5efb8a94c20f@gnuweeb.org>
Date:   Wed, 11 Jan 2023 13:09:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] hwmon: remove unnecessary (void*) conversions
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     XU pengfei <xupengfei@nfschina.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20230111020723.3194-1-xupengfei@nfschina.com>
 <db4276db-bbec-142a-d306-928421eb49fc@roeck-us.net>
 <423fcac8-97cc-88b7-19d8-f93baddea3cd@gnuweeb.org>
In-Reply-To: <423fcac8-97cc-88b7-19d8-f93baddea3cd@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 1:03 PM, Ammar Faizi wrote:
> On 1/11/23 10:29 AM, Guenter Roeck wrote:
>> On 1/10/23 18:07, XU pengfei wrote:
>>> diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
>>> index f77dc6db31ac..501337ee5aa3 100644
>>> --- a/drivers/hwmon/powr1220.c
>>> +++ b/drivers/hwmon/powr1220.c
>>> @@ -174,7 +174,7 @@ static umode_t
>>>   powr1220_is_visible(const void *data, enum hwmon_sensor_types type, u32
>>>               attr, int channel)
>>>   {
>>> -    struct powr1220_data *chip_data = (struct powr1220_data *)data;
>>> +    struct powr1220_data *chip_data = data;
> 
> This is wrong. That cast is needed to discard the "const".
> 
>    CC [M]  drivers/hwmon/powr1220.o
> drivers/hwmon/powr1220.c: In function ‘powr1220_is_visible’:
> drivers/hwmon/powr1220.c:177:43: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    177 |         struct powr1220_data *chip_data = data;
>        |                                           ^~~~
> cc1: all warnings being treated as errors

Anyway, powr1220_is_visible() doesn't write via that pointer, but
the local variable needs to be a const as well.

diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
index f77dc6db31ac..7cbbed5a6f5e 100644
--- a/drivers/hwmon/powr1220.c
+++ b/drivers/hwmon/powr1220.c
@@ -174,7 +174,7 @@ static umode_t
  powr1220_is_visible(const void *data, enum hwmon_sensor_types type, u32
                     attr, int channel)
  {
-       struct powr1220_data *chip_data = (struct powr1220_data *)data;
+       const struct powr1220_data *chip_data = data;
  
         if (channel >= chip_data->max_channels)
                 return 0;


-- 
Ammar Faizi

