Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7487030A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbjEOOzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbjEOOzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:55:48 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE9610C9;
        Mon, 15 May 2023 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684162547;
  x=1715698547;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QC+1sB4vhNnWutHQ/8eRzoJV+R7Pt68V9ffSd75UL/g=;
  b=YmTPseWCSrEDOmN2ybNPL0T0KYYVaMEAdnwGiyT+ngRRcMeM5qbwZYVn
   fRHrMvvT1n//8dPxbrDZ2CaAVgFV1RsOsE6FLBnrYOmCr6REnTDqCdNtw
   vjSQYfTHjJ2lzWayMgEc3vJgbenpmWTlaehE0Pk42xBPygZn4jxK7IACn
   9gw3V1PjsFynjHV58kDxS1WNprQ1gmTlFBs7KP/PI3kDTlSlrMaRfAMdw
   7t2AJ/iM/EZntOWiGNWYhGAVtURjBIVygCrujk5BBI0ikvVUzzgH3muAk
   ZhzsPLIl2oQjyh6CmRf0GOL7ffykeqELUIImjkG8ooVj/bZVtFgsRWsai
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEA8DEHQ49WdxDdGcYdOFhbBcaGbStTdnRSuf6qfmP9oOmHAadSygNV6wsdD/sNzEj4CWzDhpl6ry7Jzuqp64YAheKCJoMwRM4L6H5uGD3CHFMYcA/rSB9rgo9hXhX66DJtW/cwN3A3hc5rPNpVFYLsfYbTb5HanO56IAJNdqLKkesDF2euyxOXEk1/+o/O5dTSJ+nrrTw3jpzYb52n/NvEhiWxRkZy18msVT5uFyHo7zvZ3hK/LlpQFw1wTueO5x0t9w/+tbaDtEs9WWUvFUITG8lynJSWw+Oh9XP8Tc3MsC3sgfBYtXLbodI1MxLaxUD1TETG/JmuVbbQYTRMsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC+1sB4vhNnWutHQ/8eRzoJV+R7Pt68V9ffSd75UL/g=;
 b=XNhw3fbLBbbaJfGOAr3xG8DmOY00QyM3XDEXeUpDK5cPFOXXICqD749FweNFDngvrhbOGmmzgieIjSSjv/TT8xtazzLrQ08WEkdZ6PCi2DLBvQ7bEyUWsrQ2uZGDv6wJgMfeqHiiHG2tOM9Ngyl9n7tcIjCgSGDl1euyrTHLiOtICeK+wi9DFqhv1+zJj0d5LsYlo1IqE1Tmj02JFaiULFBCPeWwyEtjlWQNij3fOCyuoL/Tw1h5mk00cGjd/F6giEfrQjiYelShmkZAwNG837pqWd1j1Wu3iYCt2Ak9p+yBuJlq9j9RUY0zTJVCS97kcW5/ORw3nlUqwLbPJ+HdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC+1sB4vhNnWutHQ/8eRzoJV+R7Pt68V9ffSd75UL/g=;
 b=deQk5HaiWwb3uOFAPZT3hrEHl2nIwPubSScM8Bgu+Eh9unScrI+AqEdc7tSLpKi5q2HwqYnmKd4EgmzBdIZI2Y2xUhTracd31lP2o6HXbNZDlqLXJZObbI10JbzKknq5jG5JCNACn6RxwceS3oCiLDLnlGvnbupj1wV6un4Dz5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <30b4951c-4045-fe1b-3b1d-403eccbdb971@axis.com>
Date:   Mon, 15 May 2023 16:55:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 6/7] iio: light: vcnl4000: Add oversampling_ratio for
 4040/4200
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Astrid Rost <astrid.rost@axis.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
 <20230509140153.3279288-7-astrid.rost@axis.com>
 <20230514184142.59796c2f@jic23-huawei>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <20230514184142.59796c2f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0111.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::24) To DU0PR02MB9467.eurprd02.prod.outlook.com
 (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|GV1PR02MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 2518d578-ec2d-4643-5fd1-08db5554730f
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qO1nB0zRb0p+O2BTCilNFoiz6Bgqc4wZEutE3RV5iPfH2RSU7ehHJ0P4kX/b3mFeK3zeMmDpLpFpt+i1dAsZrs72sz2BWpwlzISpBVxp9JlvAG0OiFo/897xMltwdIZwSpYuW3roIx7GjRtW1UY9FupF1M1flyaGXKBoGR8VDQ4kCZX9wADnSPs5SFEg07wIUG7J5YZ2wpyIwZXv1W2OnsNZ+puJXP5RRLXlGooAPPFC8nrxUEwE40vMEI5QOVMbwQ4Ia6HEVoEXv2/RKdfydE6Rmm6yRWI2vvNcTSn4pj3DGAweDGnIa4TG58+BScfdcKM+wwiiz6CQAMOaMGecPsWGO/PDSl/DsTJk04qIfINRSWZv6hx2sTlpnzr10gPJAjTl0HqxBMp0TZhuAxsg8k4JTArjKshF8aNev3zQgTUOsIZG3TBkQlE0qa/4hONbA1diSBXoorAZI0DLD11eA7JcK1BoHO+xOlZxzBZf5kbSUw8f25tu5n2PD0Wje9wFb/TdNPzU1nBLEUzAJyZBaaCi9+NWh+GqJXO9hahP1eEDVZvmqs5h7w24PRj3wcepUgKK9erI3xzATrD1K8J0lOSMr23+Y7WjeuhqlVrBBYMak/wMX2lLQ6cxE5CmyWBTde4IrOmC+Wl/DBBgQ7685g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(31696002)(110136005)(478600001)(36756003)(107886003)(186003)(53546011)(6512007)(6486002)(6506007)(26005)(8676002)(6636002)(4326008)(66476007)(66946007)(66556008)(31686004)(8936002)(83380400001)(6666004)(41300700001)(316002)(38100700002)(2616005)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHlybnZCU1ZRU04wMHhzYnZMVzBydmdOdVFGYi9YV0N1UHVHNVU3QldMS0Q2?=
 =?utf-8?B?aTM4UEdQdGhnUGdFRDlFbStLSHFIYm9paHRRNXZLWVhiMkM1UHI2ZmI5M0VG?=
 =?utf-8?B?NjQvZXFoNGVXRXRYMFYwb01mNGpFSExZR0dFL291czIwTFhwWGNFMTZ3N1hk?=
 =?utf-8?B?c1ZkaFErT0JRR3QzRkw4YzJMbzAzMjBITDZhYlFodVZDd1VFMEFhbjNJMHY0?=
 =?utf-8?B?S04vdkdnZGZXUkhudXNBZDVpV0M4bHJWT09CVHFyTzRQVmw0Zk11TE0vMTlB?=
 =?utf-8?B?dDZFVFY0eGxTMW9Va3d6K2hYS0FnZE1XdTd1bzg1aVdhYkw3alVPdURmVkRm?=
 =?utf-8?B?TU9IeTJ6K1ZFcEpQeVlrNGJrZWYrRmpZMkFXb1BYRllnTklLZWNxU3FxMHFh?=
 =?utf-8?B?aG1lNWZVTjFwdkZCN2hUWE9zSjF2S05kNVFjcHFXYm5BVjhDM1daRWF6Y21P?=
 =?utf-8?B?UitrRnpKd2ZYd2NIekZJWk9Mdk1vbi82a0lpN3l6cTJ0bnN2bzVxTit0em43?=
 =?utf-8?B?OEtxQ2szTVZYK3VSZWhXT0lsYkRSY0lwa3JuTkFyaGRIeFV1dEc3dStQWXhr?=
 =?utf-8?B?K2c0TFl6OXhpQTRwSGlYZldiNlVyN25LUm1reUc5L1IvcTZ0dThHMnNpRGxM?=
 =?utf-8?B?Y2dtQlFReTc4NGM2VkZGeHJzN0NkRzQzTmNGZzFITHpxZnBxZmpTeUxZQzFL?=
 =?utf-8?B?MVNlMFUxYVZ3YVJLRTh5NkM2b0Q1TWZqWXN1Tnk2Z3NWZ2xBTGNFU0pRUEoy?=
 =?utf-8?B?MkxiekZXUjJkQnBUdzlXY3RLLzFFaXltUzVWdUNnRzZtT2ZMS0JRNkEyamNC?=
 =?utf-8?B?WkprclRnQUtwSDE5cXJKVFdhdTZsTjg2NEJKNUNoa0lIWDAvRmNDYjdaSUlK?=
 =?utf-8?B?NXFQOTltWVhpS05UcjFwSUZwbmRFZ2xMMXd2UGE1dUJYQmpLR0FYUm9WTGhI?=
 =?utf-8?B?dVp0UVF3azZveDVlUHE1MFYvQ3BxcjU5Z3MxemVTT3g5cVRxT0JyZGdJeVBi?=
 =?utf-8?B?a1QrVXU1VWkwSVJMNDlEZUxjYVhFalhwbWg3U08zejZzY0lYaG42QnFwQmIw?=
 =?utf-8?B?VWN3c0syaHlVRzZtTXVxR29UZVh2TG9ZSTNDVzRwTkp1eFBLbWJQMDBSMWVq?=
 =?utf-8?B?MnNrdlhjN29YbmlML2I2TDlUTWIvN1RXU2h3SlFRMDhUOVAzc0tWMG9Eb2Vy?=
 =?utf-8?B?djMyMXpjMFl2NjVZcERacXFWWXlEMWdQTXBndVdOcUpFOTZocC9JSXZrTUNJ?=
 =?utf-8?B?UG1JbHp6Und2RSsvbk4vZkYxaG1GdU9JTFRoR25mTjJDZkxIQWZ5U0xnWVZ3?=
 =?utf-8?B?NEtqSXJBeGtteUJidll5S0lQOUhVUEFvTFZ0UGdVcUpPSTJFSERHejVPUnVi?=
 =?utf-8?B?VDFad2NXYnNDM1N1Um9uYzZEVmRTL3VPLzFxbmg0dHFjNXhnaDM1RUVwT0VU?=
 =?utf-8?B?Tk8zMUM1NXAxaHVxcElsbjhKSGZFU1A5dWZSMkhXOTRnbTFzMzUvMnQ4Nlpo?=
 =?utf-8?B?YkRKZDU0d2JRaDMzYitSZmVDTWxqNjlzQ1lISGxQc0t1V3Bab3diNTZxejRl?=
 =?utf-8?B?ZHB2aUd5NkIvRTlNdHBHT05XeFJnOFZkQmhqVVR0VUhKL3ZwT3hFUVR4YnZR?=
 =?utf-8?B?bkp5aUdFc2tHa3ZTTThwUnFKcWRxME9yanprekMxWkxuaWpUUS9VTXU4djVx?=
 =?utf-8?B?aHpzVHFHbDAweml5ZXBudEpqTXR2RGxvbDY2aEUwdC9wMGxGRjRDbWU5enF0?=
 =?utf-8?B?ZUVQelRBQnNVYTFScGdHWW9senlqTVlPZ3hsRW90ZE51eGZhMk9mS2J6dkYv?=
 =?utf-8?B?K3VGdUVQakkxSnl6bE1vQk4vNDhSbFAwUThjN0hGNk4rN21IT25yR3RzdXZ1?=
 =?utf-8?B?Ty95MThlN0ZyOEs0OTAweGJHWW9OSm1jcGNSeC9uMHlYc3UwSFRqUE9oSzQw?=
 =?utf-8?B?ekE4NDY2UnZjTTd6YlZEMXFja1o3T3hoUGJnSXFtWmJPWnJ4WDBDR0JOMXJm?=
 =?utf-8?B?YzZ1V1ZtaFM4dmtlZ1lKVnlaLytxWWt3UG5DVE5teDdTMlljblgyOUg0ME5S?=
 =?utf-8?B?MWMxYUp3ZTdja205YkswRG1weG5lRVRMMGRMalJrUVRnRWdTa1dnWS9vTDVJ?=
 =?utf-8?Q?NUKM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2518d578-ec2d-4643-5fd1-08db5554730f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:55:40.0318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJPzXBXNOvE+8Ioz4gn0fAsreA9IW7oNJxy2yhlEHYD7KVBkz0bjKHXV6Q7jS38V1ibLLm/x9C3z1r3DHXQ6Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8402
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

Thank you for all your comments, also on the other commits.
I started to fix them all.

Yes true,  there is not much information in the data-sheet.
According to how it behaves it calculates the average of the multiple 
pulses and the SNR is definitely much better after setting the value.
That is why we need this.

Best Regards

Astrid





On 5/14/23 19:41, Jonathan Cameron wrote:
> On Tue, 9 May 2023 16:01:52 +0200
> Astrid Rost <astrid.rost@axis.com> wrote:
> 
>> Add the proximity multi pulse (PS_MPS) as oversampling_ratio.
>> One raw value is calculated out of the set amount of pulses.
>> Add read/write attribute for proximity oversampling-ratio and read
>> attribute for available oversampling-ratio.
>> This is supported for vcnl4040 and vcnl4200.
>>
>> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> Hi Astrid,
> 
> I'm finding very little definition in for this Multi pulse setting.
> Do we know if it does averaging, or some other form of outlier detection?
> 
> For oversampling we'd expect it to be averaging in ordering to improve the SNR.
> I have no idea if that is what this feature is doing!
> 
> Otherwise code looks fine to me.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/iio/light/vcnl4000.c | 86 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 84 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index b8ce4ed6b0bb..1fd1eaaa4620 100644
>> --- a/drivers/iio/light/vcnl4000.c
>> +++ b/drivers/iio/light/vcnl4000.c
>> @@ -60,6 +60,7 @@
>>   
>>   #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
>>   #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
>> +#define VCNL4200_PS_CONF3	0x04 /* Proximity configuration */
>>   #define VCNL4040_PS_THDL_LM	0x06 /* Proximity threshold low */
>>   #define VCNL4040_PS_THDH_LM	0x07 /* Proximity threshold high */
>>   #define VCNL4040_ALS_THDL_LM	0x02 /* Ambient light threshold low */
>> @@ -89,6 +90,7 @@
>>   #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
>>   #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
>>   #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
>> +#define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi pulse number */
>>   #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
>>   #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
>>   #define VCNL4040_ALS_RISING		BIT(12) /* Ambient Light cross high threshold */
>> @@ -157,6 +159,7 @@ static const int vcnl4200_als_it_times[][2] = {
>>   
>>   static const int vcnl4040_als_debounce_count[] = {1, 2, 4, 8};
>>   static const int vcnl4040_ps_debounce_count[] = {1, 2, 3, 4};
>> +static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
>>   
>>   #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>>   
>> @@ -785,6 +788,56 @@ static ssize_t vcnl4040_write_ps_debounce_count(struct vcnl4000_data *data, int
>>   	return ret;
>>   }
>>   
>> +static ssize_t vcnl4040_read_ps_oversampling_ratio(struct vcnl4000_data *data, int *val)
>> +{
>> +	int ret;
>> +
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = FIELD_GET(VCNL4040_PS_CONF3_MPS, ret);
>> +
>> +	if (ret >= ARRAY_SIZE(vcnl4040_ps_oversampling_ratio))
>> +		return -EINVAL;
>> +
>> +	*val = vcnl4040_ps_oversampling_ratio[ret];
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t vcnl4040_write_ps_oversampling_ratio(struct vcnl4000_data *data, int val)
>> +{
>> +	unsigned int i;
>> +	int ret, index = -1;
>> +	u16 regval;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_oversampling_ratio); i++) {
>> +		if (val == vcnl4040_ps_oversampling_ratio[i]) {
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
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	regval = (ret & ~VCNL4040_PS_CONF3_MPS) |
>> +	    FIELD_PREP(VCNL4040_PS_CONF3_MPS, index);
>> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
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
>> @@ -849,6 +902,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>>   		if (ret < 0)
>>   			return ret;
>>   		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> +		switch (chan->type) {
>> +		case IIO_PROXIMITY:
>> +			ret = vcnl4040_read_ps_oversampling_ratio(data, val);
>> +			if (ret < 0)
>> +				return ret;
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>>   
>>   	default:
>>   		return -EINVAL;
>> @@ -882,6 +945,13 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
>>   		default:
>>   			return -EINVAL;
>>   		}
>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> +		switch (chan->type) {
>> +		case IIO_PROXIMITY:
>> +			return vcnl4040_write_ps_oversampling_ratio(data, val);
>> +		default:
>> +			return -EINVAL;
>> +		}
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -935,6 +1005,16 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
>>   		}
>>   		*type = IIO_VAL_INT;
>>   		return IIO_AVAIL_LIST;
>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> +		switch (chan->type) {
>> +		case IIO_PROXIMITY:
>> +			*vals = (int *)vcnl4040_ps_oversampling_ratio;
>> +			*length = ARRAY_SIZE(vcnl4040_ps_oversampling_ratio);
>> +			*type = IIO_VAL_INT;
>> +			return IIO_AVAIL_LIST;
>> +		default:
>> +			return -EINVAL;
>> +		}
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -1658,9 +1738,11 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
>>   		.type = IIO_PROXIMITY,
>>   		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>   			BIT(IIO_CHAN_INFO_INT_TIME) |
>> -			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
>> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |
>> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>>   		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>> -			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
>> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |
>> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>>   		.ext_info = vcnl4000_ext_info,
>>   		.event_spec = vcnl4040_event_spec,
>>   		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),
> 
