Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6413573E276
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFZOvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjFZOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:50:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A6912E;
        Mon, 26 Jun 2023 07:50:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6686ef86110so1466951b3a.2;
        Mon, 26 Jun 2023 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687791057; x=1690383057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3/i5nGpo6bAYzHRYmjepgeMVK+fjAMmYYEQI4A8dzWk=;
        b=WcV4DcEBS5YMzS9iaPDRah1GA8GP4m8yCyx/thCr1kzXp/1T2D2H1Ap+Zx8/NxVenk
         fUWee4Ndk2misDoh1G5NO6U6bOPbnUgSllMa4nTGKMd8ym6YzNTzuiXnYM/4WJUHhGyL
         2yaFVJNBKnAPHE/DoYIlleYsrb/JWYyczHVojNOA51eOznE5hRz/GJfHkALKInY0RlTc
         QV4bBN7spqzeaPNe741uGfXZsZszC1dkbG8KaY/daK6OaKqbjUda693A+36oGeMBO/PH
         OGkE+Ld+QkjbCGet6WRjXY7YZ7gGq0qP4AeIhhM69FG9991bEoEDtmOKZysxC5K7pN/c
         nyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687791057; x=1690383057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/i5nGpo6bAYzHRYmjepgeMVK+fjAMmYYEQI4A8dzWk=;
        b=K2PI67H2gpfSrsSgik9X+/J3AS/Q/AjJukbAlqtKb7vqndDAucR2/TTdzIplJFFjvf
         /CvkaYlykSmPnMSC7pUKSV4wHWGD/rUeWToC+bHGjUcgyPnWOj9RBYeVL6jG0GppugeQ
         zA/gfDtRjLWejdoml7qmhT8Pw4YeCUmpj7+MbvGiWGGnSUstmVEELQbbqXxax4yMSfKl
         tdygaAMlpdqJmuLJBYc2ajX9OoqgBZd/7g80N5BUGEssOmVk83TOocI6O2Lc3rgoKQU7
         bBl3ZBBtc0ZB9kWnJyP45jOmDRF7zpo3b70baOqE/zI8MwY1U/sHIOMyzb0L7xyBBxDA
         3V6Q==
X-Gm-Message-State: AC+VfDwUoqpFpfFRQsLINo3dqkr8gp/KZ2nbyOYxpXN/5W1DR/Q04Juc
        HQ3yDOp77CgQs93NtyfgVtA=
X-Google-Smtp-Source: ACHHUZ7gyf8JRcVX0msxlw87KM1NXLxkxhxSkyxpkjUkB5RP08dHtYuS1O5W3TiyOlTbkG5rO5m/Jw==
X-Received: by 2002:a05:6a00:244f:b0:63b:5c82:e209 with SMTP id d15-20020a056a00244f00b0063b5c82e209mr18091552pfj.10.1687791057379;
        Mon, 26 Jun 2023 07:50:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7838f000000b0066a6059d399sm3889133pfm.116.2023.06.26.07.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 07:50:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7e708dfa-4019-fe28-afbd-91ad847fada0@roeck-us.net>
Date:   Mon, 26 Jun 2023 07:50:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/24] init: pass root_device_name explicitly
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230531125535.676098-1-hch@lst.de>
 <20230531125535.676098-9-hch@lst.de>
 <c1391658-d785-4b2f-ba7e-01e4668685d7@roeck-us.net>
 <20230626075325.GA26851@lst.de>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230626075325.GA26851@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 00:53, Christoph Hellwig wrote:
> On Fri, Jun 23, 2023 at 05:08:59PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Wed, May 31, 2023 at 02:55:19PM +0200, Christoph Hellwig wrote:
>>> Instead of declaring root_device_name as a global variable pass it as an
>>> argument to the functions using it.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> This patch results in the following build error when trying to build
>> xtensa:tinyconfig.
>>
>> WARNING: modpost: vmlinux: section mismatch in reference: strcpy.isra.0+0x14 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>> ERROR: modpost: Section mismatches detected.
> 
> I can reproduce these with gcc 13.1 on xtensa, but the report makes
> no sense to me.  If I disable CONFIG_CC_OPTIMIZE_FOR_SIZE it now reports
> a similar warning for put_page intead of strcpy which seems just as
> arcance.
> 

I don't see that (I tried 11.3, 11.4, 12.3, and 13.1), but then I am not sure
if this is worth tracking down. I just force CONFIG_SECTION_MISMATCH_WARN_ONLY=y
for xtensa builds instead.

Guenter

