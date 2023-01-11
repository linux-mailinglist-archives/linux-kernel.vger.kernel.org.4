Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF88066546B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjAKGPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAKGPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:15:22 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48E260EE;
        Tue, 10 Jan 2023 22:15:21 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 84F0D7E4CF;
        Wed, 11 Jan 2023 06:15:19 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673417721;
        bh=sH4y0Bg/YC4VQSKQlDsB5/u57z7QvT23qSAkZaISeGE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n6ZgauoIZWlxFy43ZpmZMcsDnTUXMWxvVkjrxn2UDZHJ+dy19prcZ2naXRpVtATye
         /70gk/3i+YJL6e8OdqQ0ZTeGErpy3VWe0G/k+N1v1aPqOmftfP6JXYGtUTgvxWC75b
         PeE+V0OkBnbJk+VkFdLoT/lfLnrOCMaUgGSa0h3aeMqwkkfTQThXvM93lKtorJ3DE8
         kv2cIvyiNEQ1rHoTiCNJHbkHr1NADizzePl4y1h0SoxI5hcA2CGONy3NIsuxKGKH18
         1lZpVA5Lg4/ofas7KuzgbUkVJwO78LCjUIMoBhDdAsDyhNfuQ9vZoQWy67OHk2KNi8
         r6ABt9NYmruxw==
Message-ID: <efbc4e6f-b583-239b-439b-6ebc01ffe44d@gnuweeb.org>
Date:   Wed, 11 Jan 2023 13:15:17 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] hwmon: powr1220: remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     XU pengfei <xupengfei@nfschina.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
References: <20230111043729.3792-1-xupengfei@nfschina.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230111043729.3792-1-xupengfei@nfschina.com>
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

On 1/11/23 11:37 AM, XU pengfei wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: XU pengfei <xupengfei@nfschina.com>
> ---
>   drivers/hwmon/powr1220.c | 2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
> index f77dc6db31ac..501337ee5aa3 100644
> --- a/drivers/hwmon/powr1220.c
> +++ b/drivers/hwmon/powr1220.c
> @@ -174,7 +174,7 @@ static umode_t
>   powr1220_is_visible(const void *data, enum hwmon_sensor_types type, u32
>   		    attr, int channel)
>   {
> -	struct powr1220_data *chip_data = (struct powr1220_data *)data;
> +	struct powr1220_data *chip_data = data;

Broken:

   CC [M]  drivers/hwmon/powr1220.o
drivers/hwmon/powr1220.c: In function ‘powr1220_is_visible’:
drivers/hwmon/powr1220.c:177:43: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   177 |         struct powr1220_data *chip_data = data;
       |                                           ^~~~
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:249: drivers/hwmon/powr1220.o] Error 1
make[1]: *** [scripts/Makefile.build:465: drivers/hwmon] Error 2
make: *** [Makefile:1853: drivers] Error 2

-- 
Ammar Faizi
