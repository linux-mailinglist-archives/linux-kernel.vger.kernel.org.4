Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3965D414
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbjADNXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbjADNWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:22:36 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2541B2B;
        Wed,  4 Jan 2023 05:22:34 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304CbIH4020004;
        Wed, 4 Jan 2023 14:22:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=eyyr065k7L+urExihJ9eI1g63kt6J3N+k4VPbd6BKdk=;
 b=aQ/atlSN6Z5eRw4YqnRlpz224PmG3PM1m5cDvJa7N0LDrOn2xSonDbLiaTelAo3zHLMQ
 YyFJFsOhuLDJSv0O/zkueInXqc23Lk432gOFIyE2RdmpoD8sDfU9AtccvpKv93XFyVg7
 3vwvapztXLOc+n+2WOSXXzun2SFNw9/EthzeCguR+v4HpEYQUmYyuD5YFT2KyDM+lF36
 XXOzWTB9QZa7JsfRDeGb+3NeG8dkA48zAHAVQkFEqE9c+wU6Dv5BfO74XQe6oUsvrKDR
 6vR/1Q3/kxlr0lh7HJfhl9naWs6le+yZigBURCZL9hrM8PO62TLuV507Z9X3ggKr3PP1 JQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtb3eb8uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 14:22:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49257100034;
        Wed,  4 Jan 2023 14:22:25 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3FD0B21ED56;
        Wed,  4 Jan 2023 14:22:25 +0100 (CET)
Received: from [10.129.166.172] (10.129.166.172) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 4 Jan
 2023 14:22:25 +0100
Message-ID: <4c3560c0-e949-ed67-648b-8da9015eae4e@foss.st.com>
Date:   Wed, 4 Jan 2023 14:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/1] media: i2c: st-vgxy61: Use asm intead of
 asm-generic
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20230103145219.40226-1-andriy.shevchenko@linux.intel.com>
 <b2ad42cb-fe09-73f5-8d7d-ac4f22817bac@foss.st.com>
 <Y7VS2LuKGVQkcyrU@smile.fi.intel.com>
From:   Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <Y7VS2LuKGVQkcyrU@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.129.166.172]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/23 11:20, Andy Shevchenko wrote:
> On Wed, Jan 04, 2023 at 10:27:14AM +0100, Benjamin Mugnier wrote:
>> On 1/3/23 15:52, Andy Shevchenko wrote:
> 
> ...
> 
>>> -#include <asm-generic/unaligned.h>
>>>  #include <linux/clk.h>
>>>  #include <linux/delay.h>
>>>  #include <linux/gpio/consumer.h>
>>> @@ -15,6 +14,9 @@
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/regulator/consumer.h>
>>>  #include <linux/units.h>
>>> +
>>> +#include <asm/unaligned.h>
> 
>> Any particular reason not to keep the alphabetical sort ?
> 
> It's kept in an order in each of the groups of headers.
> 
> The main rule here is to go from most generic headers to the particular ones.
> asm/* are definitely more particular than linux/* ones.
> 

Thank you for your explanation.

Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

>>>  #include <media/mipi-csi2.h>
>>>  #include <media/v4l2-async.h>
>>>  #include <media/v4l2-ctrls.h>
> 

-- 
Regards,

Benjamin
