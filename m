Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFAD7030C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjEOPAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbjEOPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:00:29 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55545E79;
        Mon, 15 May 2023 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684162828;
  x=1715698828;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iEvZNkW/QxxXj0rDa/edZB/h0t+LFzhL3NG8DSs/rDQ=;
  b=bho8cFgUDVAi/1Ag/R1KqcfDBtoHustnGh8gK0rlFToVxYT8md/GsiZ1
   3cntSgsvdTSUzT944CwiQUSxa90+wyJvYUPdZZ2pDmyzFyr+EFeOivsdK
   4HOq5igp9oDGJbaKBhFfgK4Qft4SmngJRxzYf6k/Oz/wHzm/SqASKULBp
   m5MnEbtChXpbWAXdEPLT5DV67OhpHCuWFpsLYb+x0AMXkDHl/okfWzpt9
   dyLMR+t4bCXz5rZn+UrPR7F9IhiE9GJwjrY7PSGNUTHP0CO6u9YXoy2nS
   Kn66ah/5rnuWvf/JXrzWRqpTKocDawE+7TsmWWluZlsWNQk3R21SGknh5
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2yrJAvsdqu4uIeUqpLQEPfHkxvA75GTw7IjKjby9g9xGPlk40M5WrVWDRp1BEhL+OzSNNLtIwN9mVMijBzj6kgktQCPZocxPmD7C8tOL7tdBL8XOIwLPI9aQqnmKSQ4p75FEomwsd6CbMqdH2OceeZm+I1+UI15W1ocOwfaG7uqfwAsemC2LFOBSeupCoaQSzo1uVUJ7Pw0aVPPQR2er6IMx3yMlqVJ7ko7KfUUvfYDIGqBfGRa3DG60Uhak1L1ic7EExJKy/JipLKUaxT/sD/yrNW0LRmLFT5szC8M0TW59eIwYFJARYlGqWZqfwrIXIJN3+U9DzNhcaTsnRxoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEvZNkW/QxxXj0rDa/edZB/h0t+LFzhL3NG8DSs/rDQ=;
 b=WgGnSgUoBHjYKVdIXGDTV+JfsGemz3UWVEGHErIqmaJxBDIyGo3gi6JZdjSD2cnhCZXxROoz5so9f1JnpVRH1tFExgZ7P2vxo9ZudC83GAVqcyHCEkTmd4CkUzK/aGS73OMF1ohZkQOgjUcsj5qmYib9gn6Ya25T7gMYxeLVjGZFWWLXBbLxqDhSwozlJyImhjmycw+MT6pfn6XzwOO/kTvK5pe7c4IPSgxitEqNgtdU0CPwmOK9oBbsU/fHdF9HAHLycEhX3xLTl8ksDw7qTlCEZTSUtYsgTs5/v4Q9Zn7o0IjPaupfOz8tlD7enpIZ5i2KzwLtnPshJVK/xbPvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEvZNkW/QxxXj0rDa/edZB/h0t+LFzhL3NG8DSs/rDQ=;
 b=U/KoDHl0gk6pr8nDQxV6iNs4eVpUDcxo08p2lFgq3hSA0y61i3A+vKG/uZFy7FQmf7mJd8a/wBxW7/zD6rTi1wRiZKoea+CDkNgTd0CwceM3I/2qi4XQuFUl0RmngAhYaBB923XqoI4earARiTMWCc+t4VjwTEbUrRV0RS7BLqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <d2fbfe0f-b2bf-58e4-1ec9-02dff2d08420@axis.com>
Date:   Mon, 15 May 2023 17:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/7] iio: light: vcnl4000: Add debounce count for
 vcnl4040/4200
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Astrid Rost <astrid.rost@axis.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
 <20230509140153.3279288-6-astrid.rost@axis.com>
 <20230514183748.256a210c@jic23-huawei>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <20230514183748.256a210c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0116.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::33) To DU0PR02MB9467.eurprd02.prod.outlook.com
 (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|DU0PR02MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: da7fe36b-c81b-4dcc-3746-08db55551bfd
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5RX+gFCT6h9beJYY0Cfxk1VG48Rn9/bOLsf9QUyhXjckg8p2SL2UAOx0AJmcJaF10Tpbic5uUGXUJ3RmOJ1UMS1Q0zr5688t7a1qRe9qEk9tQXp4azT3wk/4JX1VR/JE4dVow6pNJX2YAML/u+nm2u320ET/Vc+S4teDu0y6+SX57vJxoVs2ace+LclfiV9avRjG2/RTFGqYsFjld/X3AQWoaDXiJ93+2gAi+HGLROgMFYDsL1NLI0ynYdXF8T4WMKtI2JcCkiwSCCg930O9LsaeVnG3KsB9bJACtMQRt/aIDaszwrgsjg8bayeInt6ZYrKZ2g/0nOGKq4PIiA6gBV9gMUvZJndGNsLvCmSfCZhwqT9ORI5AYBQz6HOy9vFOn7pG1B5oBAjdJuO1MWhi58hFV32HNibcSRGDJ18HLLp9yBAlBV9F5imiZa9/cLHW6WvWe0rANT7ZakwFBqvmEnCNuA3GOs69k4Ze4xQj7M9YHN74Lnglimu3p26JSLgTKJ/4efF6q81VmXqTYMCQEMzArTEILuWftfSjD+WOPOwWAN0XfzKTgugd0NLl214N4s/kTvyYCmzy4eDNiFYqDVH5p7hdKF2/5DTyf8IMF+hpS1tPg4eZlgrD1oiLTUKAt+F9KOeXa7TT0vNrzlTnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(6486002)(83380400001)(478600001)(110136005)(2616005)(6506007)(26005)(6512007)(186003)(107886003)(53546011)(2906002)(36756003)(6636002)(4326008)(38100700002)(66476007)(66556008)(41300700001)(66946007)(8936002)(8676002)(5660300002)(31696002)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFgrRStGQWNDOFBqN3pXaERybW1KSkRqMFVHY0swSDJLSFRER1hmZmgxcmZh?=
 =?utf-8?B?ZXNURHBuUlZGVnZlc01QRlJ4Qk1KaisyWWRsL3J6OFpFRmpXbjY5ZTNWQkpJ?=
 =?utf-8?B?dENRNXpPSTZOaERybW9hM0JSeWNmYmlSYnJONXpnWmhCZnFrSkVRdjlzV082?=
 =?utf-8?B?ZXdjcXE1WjRDQ1hNY1BOQ1MveE5nR2RJRUpGQXNyYmZxQm5yVDd5TXZIYkh0?=
 =?utf-8?B?emUzajFVOThkM2YvQ2V3ZXZFVHJoTkRWVlVPL0REUHRhTmxtQ2g4eVEzNFF3?=
 =?utf-8?B?eVliSE9wSUxVdnhWdG5sbjRpQmdaYzNhanFpMnZBWWVFczNDUlgyMWU2OXVR?=
 =?utf-8?B?eEw3S1NGdnYvcGI2Y2FxZXQ3M25QQ1F5akNKOVNnV3VRSkNqUHAzVXAzbWM0?=
 =?utf-8?B?bDEvbE1DZ0hqZDEyMjMzekZlUGo3WlBVMWprdkd2aGtQei9KUnIrU00xd3JG?=
 =?utf-8?B?dGk3MmM0UW9KdmhLS0ZnLzRmK1owWi9EUVVmbElUbHZEeVY2YllhQUNPcUVX?=
 =?utf-8?B?VEovR2dLQ2w3Q05oWjlzQ2ZKTTNWNGJCVk5oeHphdnNrNjBKejZaaUhvRjQr?=
 =?utf-8?B?TVBlQjhHQzEzcHdaUnpiZEduMDNzcUlMQ2FGTnpmYjBQQ2FjNUdpMUpEdk5E?=
 =?utf-8?B?c09qUVNTcm42cEhqMVpoSjBHSko5N29rNktYL0h6NW9zTmtMaE92NGpBVlJx?=
 =?utf-8?B?dHFYWXFKbXZHNVkwUXZveVl2R05KbU9lSENLSDc3OVFrMTJsdlprSjhVQjRy?=
 =?utf-8?B?UVhEeGhTVXlNMlJJUXk1cnhPUHo2Q3ZGZUF1empidjJ2U044S2ZRNUE3NlBi?=
 =?utf-8?B?cU55aVhvYjBDNzBDcGlNTzlHRWJSMEt3YlFyQzQ1K1hibm1TKzIwbG5vY0JM?=
 =?utf-8?B?WURlQ3pwbkVPMmdWeGlZaG1lWEh4V2ZNVkZDSjlQNG5UMWk2d3ZQNXZpTGpn?=
 =?utf-8?B?UzBRck1pM3VHenBQVFlidWpPSWpUWWYyZ1oxREhpRFhWcVZKemxSdG14TW9X?=
 =?utf-8?B?bEFsL2Z5RlBKNzE5cURSWXFLeGdMTFZWNXhYWW4zSFpKd1JFcE14OHgwd1JB?=
 =?utf-8?B?RW1yNE1ubWt4VFZOQVZhaUJ1VnlVRzQ3Y1NvT2RtRTlOM3hucGRWL2RsSDZT?=
 =?utf-8?B?Ylo2b2piM2dKcmJGSlVLcFFyeWFUMkJ6enhuOVdUVlNlZzh1VDBldTBUOW1L?=
 =?utf-8?B?RzkyQlFCSTk4RGVMUzBFZDYwYlUwSGdnN1BuTmFiVVJVVjhzQndHL3JjUlpS?=
 =?utf-8?B?TnkxV1RuUmJNV2lBMHhUZEIrUDlxWnhxRXNKM0xVaUlFK090QWRWU1lNM3dF?=
 =?utf-8?B?cndYNXVuWlVENml5RlJXUVdRZTRFMXV2MWxWN2ZhWnFPdlllUG5VMGtNVmlt?=
 =?utf-8?B?dmFvMGtpOUk1OThMMUZ3ZVZydllEaVRybmRCVXV1M2tKT3lwUUpwL3lickFl?=
 =?utf-8?B?Y1R5dHB6OUROblNhR0dPMFZVd3o1REdXblU5bDZ4WUhMM1Z1bGxnZ0szODM4?=
 =?utf-8?B?SDNLWXlLZjBmY0sxUDMvM3lKOUNzUWpPaUFUU1lIU3JEb042V09MOVliR0J4?=
 =?utf-8?B?ekJYQXdRR2NaY09Ycm52djFRWk92ZjRYZGEzeDYwaUorS25XNk9tNDA1VkQz?=
 =?utf-8?B?bWszQy9IUEc4OFNKUis0UENRMHFYYXlLaHNSVTBVVXhobGtIZW9oODQ2MWVN?=
 =?utf-8?B?elFieUVVTmlwOHR4bUx4aWs0MTM3UUlnV2JtbVY0Q1YyWkliVzRDdm4xanNK?=
 =?utf-8?B?ei9lOURpS00yT3BIUUdTVlpiaVZGSlJLcno2L1lNdWZ6STVsSzJsemoxMjAy?=
 =?utf-8?B?Z083STNVY2x5QTFTenpnbzdiUHZCd1JYVHF6a1dGMEtVZUFLdzg1NFJrL2ZQ?=
 =?utf-8?B?eEN3czlEMFNQcWltWDJFR3NDazJmcjBvUDZyZTl6RjBmdGx5ejc0UEFtN0hF?=
 =?utf-8?B?czg5L2J1S1RML1pxK1VLTkViVkJleWpzVkRyL1dQQVhjc0pZbDZmVFdmSTIr?=
 =?utf-8?B?VmFrQWwvd1lSWDVNL0dQbkZ5OUV4cmZRZTZ4UFRUaEhWS0RHWFkvVWZEUlRa?=
 =?utf-8?B?TFFpYUgrWUg5MEZBNU1uUjFVSVovS1BGa3Nwamx6WFEvRjEzMjZlZnVGWWhu?=
 =?utf-8?Q?swqk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da7fe36b-c81b-4dcc-3746-08db55551bfd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:00:23.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4/z4lXRMdskW2ejag2TvMib/2aY8x+hmagLDl9HJAK6XdWmlUqvV4XtA29qGgd9PwyWr3p/cSdyukMgFUEzqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8190
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

Thank you!
I will use period instead, but this means it is dependent on integration 
time as well.

Maybe I should try to deliver the first four matching patches and make 
another delivery of the last three.

Astrid



On 5/14/23 19:37, Jonathan Cameron wrote:
> On Tue, 9 May 2023 16:01:51 +0200
> Astrid Rost <astrid.rost@axis.com> wrote:
> 
>> Add read/write attribute for proximity and illumination debounce-count
>> and read attribute for available debounce-counts.
>> The debounce-count is set in the interrupt persistence flags
>> (PS_PERS and ALS_PERS). An interrupt will not be asserted if the raw
>> value is not over (or lower) than the threshold for the set
>> continued refresh times.
>> This is supported for vcnl4040 vcnl4200.
> 
> Why debounce count? That has previously just been used for step detection
> on accelerometers and has a pretty specific definition in
> See Documentation/ABI/testing/sysfs-bus-iio
> 
> "
> What:		/sys/.../iio:deviceX/in_steps_debounce_count
> ...
> 		Specifies the number of steps that must occur within
> 		in_steps_filter_debounce_time for the pedometer to decide the
> 		consumer is making steps.
> "
> 
> What you probably want is period, though that is defined in seconds so
> you may need some unit conversions.  That is defined for events, not for
> a channel so IIO_EV_INFO_PERIOD.
> "
> 		Period of time (in seconds) for which the condition must be
> 		met before an event is generated. If direction is not
> 		specified then this period applies to both directions.
> "
> 
>>
>> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
>> ---
>>   drivers/iio/light/vcnl4000.c | 156 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 152 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index 68eea686b2dc..b8ce4ed6b0bb 100644
>> --- a/drivers/iio/light/vcnl4000.c
>> +++ b/drivers/iio/light/vcnl4000.c
>> @@ -84,8 +84,10 @@
>>   #define VCNL4040_ALS_CONF_ALS_SHUTDOWN	BIT(0)
>>   #define VCNL4040_ALS_CONF_IT		GENMASK(7, 6) /* Ambient integration time */
>>   #define VCNL4040_ALS_CONF_INT_EN	BIT(1) /* Ambient light Interrupt enable */
>> +#define VCNL4040_ALS_CONF_PERS	GENMASK(3, 2) /* Ambient interrupt persistence setting */
>>   #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
>>   #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
>> +#define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
>>   #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
>>   #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
>>   #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
>> @@ -153,6 +155,9 @@ static const int vcnl4200_als_it_times[][2] = {
>>   	{0, 400000},
>>   };
>>   
>> +static const int vcnl4040_als_debounce_count[] = {1, 2, 4, 8};
>> +static const int vcnl4040_ps_debounce_count[] = {1, 2, 3, 4};
>> +
>>   #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>>   
>>   enum vcnl4000_device_ids {
>> @@ -680,6 +685,106 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
>>   	return ret;
>>   }
>>   
>> +static ssize_t vcnl4040_read_als_debounce_count(struct vcnl4000_data *data, int *val)
>> +{
>> +	int ret;
>> +
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = FIELD_GET(VCNL4040_ALS_CONF_PERS, ret);
>> +
>> +	if (ret >= ARRAY_SIZE(vcnl4200_als_it_times))
>> +		return -EINVAL;
>> +
>> +	*val = vcnl4040_als_debounce_count[ret];
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t vcnl4040_write_als_debounce_count(struct vcnl4000_data *data, int val)
>> +{
>> +	unsigned int i;
>> +	int ret, index = -1;
>> +	u16 regval;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(vcnl4040_als_debounce_count); i++) {
>> +		if (val == vcnl4040_als_debounce_count[i]) {
>> +			index = i;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (index < 0)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&data->vcnl4000_lock);
>> +
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	regval = (ret & ~VCNL4040_ALS_CONF_PERS) |
>> +	    FIELD_PREP(VCNL4040_ALS_CONF_PERS, index);
>> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
>> +					regval);
>> +
>> +out:
>> +	mutex_unlock(&data->vcnl4000_lock);
>> +	return ret;
>> +}
>> +
>> +static ssize_t vcnl4040_read_ps_debounce_count(struct vcnl4000_data *data, int *val)
>> +{
>> +	int ret;
>> +
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = FIELD_GET(VCNL4040_CONF1_PS_PERS, ret);
>> +
>> +	if (ret >= ARRAY_SIZE(vcnl4200_ps_it_times))
>> +		return -EINVAL;
>> +
>> +	*val = vcnl4040_ps_debounce_count[ret];
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t vcnl4040_write_ps_debounce_count(struct vcnl4000_data *data, int val)
>> +{
>> +	unsigned int i;
>> +	int ret, index = -1;
>> +	u16 regval;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_debounce_count); i++) {
>> +		if (val == vcnl4040_ps_debounce_count[i]) {
>> +			index = i;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (index < 0)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&data->vcnl4000_lock);
>> +
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	regval = (ret & ~VCNL4040_CONF1_PS_PERS) |
>> +	    FIELD_PREP(VCNL4040_CONF1_PS_PERS, index);
>> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
>> +					regval);
>> +
>> +out:
>> +	mutex_unlock(&data->vcnl4000_lock);
>> +	return ret;
>> +}
>> +
>>   static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>>   				struct iio_chan_spec const *chan,
>>   				int *val, int *val2, long mask)
>> @@ -730,6 +835,21 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>>   		if (ret < 0)
>>   			return ret;
>>   		return IIO_VAL_INT_PLUS_MICRO;
>> +	case IIO_CHAN_INFO_DEBOUNCE_COUNT:
>> +		switch (chan->type) {
>> +		case IIO_LIGHT:
>> +			ret = vcnl4040_read_als_debounce_count(data, val);
>> +			break;
>> +		case IIO_PROXIMITY:
>> +			ret = vcnl4040_read_ps_debounce_count(data, val);
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		if (ret < 0)
>> +			return ret;
>> +		return IIO_VAL_INT;
>> +
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -753,6 +873,15 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
>>   		default:
>>   			return -EINVAL;
>>   		}
>> +	case IIO_CHAN_INFO_DEBOUNCE_COUNT:
>> +		switch (chan->type) {
>> +		case IIO_LIGHT:
>> +			return vcnl4040_write_als_debounce_count(data, val);
>> +		case IIO_PROXIMITY:
>> +			return vcnl4040_write_ps_debounce_count(data, val);
>> +		default:
>> +			return -EINVAL;
>> +		}
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -791,6 +920,21 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
>>   		}
>>   		*type = IIO_VAL_INT_PLUS_MICRO;
>>   		return IIO_AVAIL_LIST;
>> +	case IIO_CHAN_INFO_DEBOUNCE_COUNT:
>> +		switch (chan->type) {
>> +		case IIO_LIGHT:
>> +			*vals = (int *)vcnl4040_als_debounce_count;
>> +			*length = ARRAY_SIZE(vcnl4040_als_debounce_count);
>> +			break;
>> +		case IIO_PROXIMITY:
>> +			*vals = (int *)vcnl4040_ps_debounce_count;
>> +			*length = ARRAY_SIZE(vcnl4040_ps_debounce_count);
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		*type = IIO_VAL_INT;
>> +		return IIO_AVAIL_LIST;
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -1504,15 +1648,19 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
>>   		.type = IIO_LIGHT,
>>   		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>   			BIT(IIO_CHAN_INFO_SCALE) |
>> -			BIT(IIO_CHAN_INFO_INT_TIME),
>> -		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
>> +			BIT(IIO_CHAN_INFO_INT_TIME) |
>> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
>> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
>>   		.event_spec = vcnl4000_event_spec,
>>   		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
>>   	}, {
>>   		.type = IIO_PROXIMITY,
>>   		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> -			BIT(IIO_CHAN_INFO_INT_TIME),
>> -		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
>> +			BIT(IIO_CHAN_INFO_INT_TIME) |
>> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
>> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
>>   		.ext_info = vcnl4000_ext_info,
>>   		.event_spec = vcnl4040_event_spec,
>>   		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),
> 
