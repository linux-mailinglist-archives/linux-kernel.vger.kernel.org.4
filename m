Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC89665429
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAKGED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjAKGEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:04:00 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C2B6403;
        Tue, 10 Jan 2023 22:03:59 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 269227E4CF;
        Wed, 11 Jan 2023 06:03:56 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673417038;
        bh=f/3A1vIt8FrC/KEXKsPDv+Qz2qkQtjVjdgOmhSlxA7U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZgoGicZ2orlsdD5fUa++p24WOsUtiwRQQC5ko9IxURfFgS075I8MYzxrq3gO/YVWe
         8Xi50R96v9JI1rA2vILOd2U2mloAM50szmg2O/7ukrHDc7PWpLLB/+UihHeq0/BZ/l
         r4+pp9PxTwqjFJRzjsaEQ8eL/kAOlJ3myOXvVjmd6ymRX8s7BQzAS+2K/ndlhrxmwV
         /hDiW5DQRZ6LpW6DYK8i+4N+eHIkufeAK/JSYv89IwvyJwNqOjSnmw4xYkSxGUnSOR
         cSR2tuunWVDco09GvnHg3fFKD3WRlnUzdFi4aMClhrmDj5h8AwZjCFc6WvIOIjN6aQ
         Xp24oKKKsafNQ==
Message-ID: <423fcac8-97cc-88b7-19d8-f93baddea3cd@gnuweeb.org>
Date:   Wed, 11 Jan 2023 13:03:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] hwmon: remove unnecessary (void*) conversions
Content-Language: en-US
To:     XU pengfei <xupengfei@nfschina.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20230111020723.3194-1-xupengfei@nfschina.com>
 <db4276db-bbec-142a-d306-928421eb49fc@roeck-us.net>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <db4276db-bbec-142a-d306-928421eb49fc@roeck-us.net>
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

On 1/11/23 10:29 AM, Guenter Roeck wrote:
> On 1/10/23 18:07, XU pengfei wrote:
>> diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
>> index f77dc6db31ac..501337ee5aa3 100644
>> --- a/drivers/hwmon/powr1220.c
>> +++ b/drivers/hwmon/powr1220.c
>> @@ -174,7 +174,7 @@ static umode_t
>>   powr1220_is_visible(const void *data, enum hwmon_sensor_types type, u32
>>               attr, int channel)
>>   {
>> -    struct powr1220_data *chip_data = (struct powr1220_data *)data;
>> +    struct powr1220_data *chip_data = data;

This is wrong. That cast is needed to discard the "const".

   CC [M]  drivers/hwmon/powr1220.o
drivers/hwmon/powr1220.c: In function ‘powr1220_is_visible’:
drivers/hwmon/powr1220.c:177:43: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   177 |         struct powr1220_data *chip_data = data;
       |                                           ^~~~
cc1: all warnings being treated as errors

-- 
Ammar Faizi

