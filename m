Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6887B5F7D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJGTGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGTGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:06:08 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6595D2F022;
        Fri,  7 Oct 2022 12:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y42J+mc0/dthltF3CsDrmvR5jhoZS7OBBok1csLxYOQ3jzUY9L8qCCic6k9YIz3FUTHLM1peMXIzucoh4ALDdYcE8/+1+C9kZ4iMQGwGhQViVS0hhzrSUgS7w/atGJRYowyQhkP8B+wdAroD2BBLRhG8vVLxCb/FApMAUkqgckUneyYFTDDnJjcHNI0jDzT/A7BAUHIsE49VQZ8gXT04zzVg2Pf3i+NXxmuzGE/tCttjJvmUV+FqV/laMw3f5jW1FhiGMq+dzk8Pl9rinLV4r5QHapxquZuuna+bjc8QAebHwKAu0tSinlMGypmh9bLlI7G++B8MGlqer7gwfQTHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afhnLC3ueoWlgjWqXtaFAX40xslZhdBXedU2tsfwXNk=;
 b=CceAoLXOi8bZgjNMsRvMb/V+CWQy2OZcc/Td6uMQc8+rZh3mHe7vCoULIihoVchdzmYK2QE2TZo1xj0b4prTbmIJvXuy4SB1Hkdc/ffe9RPvN8GTo610pC7cZQH2ubpnWf7n50mxOQmeJL2UJgl2zpgVgmhGKV+dvZEdZzOgma11e9C6PUkEBUfjx3JQj+8HeF8fb6U9fxGSceBLfV3ej69St5R6MOCWcvdUCEeS9gdJcnZAP+wxwTcJIIhLKZd9vjoYYyshJhk1yGHDBS6mYK0cy+F4H172CC9yTdcdYgv6WunVHUcfhsMt6iSCRTpHkJlc/t8YfXu/so9kV/fGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afhnLC3ueoWlgjWqXtaFAX40xslZhdBXedU2tsfwXNk=;
 b=MzR9678+fOyfXEFmiBpNWChMZlHRh6YQP+TanNphmco7bRY04uBYPqkAJFdZeo1rvg5DofOa1K1z0AOhoszaEMDOXZV93XjT8aWOYltvn1GNOvG10n2Ck7HcTmBSleU5DyjGw7HLQ1SehQMSgShuhjQkeAFUaA70qG7rIv3RSvoiZsNln7icrR7HkiZwJPpVPef6QnWjlw2MXmzRpiUd5Q0NGXVcDs2lU9EzOENZGb4ZxUh2WSPdHTdOA3TedSz34vCPakoP6I80FsagAs3bXqHhwWcuLJFSR5WSeUMzb6hu55QPXhz3jRmoAJT4vEaw05aBEIwYpAfP0eJ7vBnkYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by GV1PR03MB8541.eurprd03.prod.outlook.com (2603:10a6:150:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 19:06:00 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d%6]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 19:05:59 +0000
Subject: Re: [PATCH] rtc: abx80x: Don't warn about oscillator failure after
 PoR
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221007163712.2193966-1-sean.anderson@seco.com>
 <Y0B2pNv8otKkLs1D@mail.local>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <a7c4fdc6-a704-31dd-d596-daa484328024@seco.com>
Date:   Fri, 7 Oct 2022 15:05:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <Y0B2pNv8otKkLs1D@mail.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0132.namprd02.prod.outlook.com
 (2603:10b6:208:35::37) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4972:EE_|GV1PR03MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: c81358e6-a366-4392-4885-08daa896f828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIudr79yVt/3B57RvJ6W9El4km59aIf3HIJt+pLtoO18+kpsLDFhmugg92VWvn0jzgZE3nXDtYz3ho4P3XHkX/PF2qGKnxCif+19AdIgOSAKrh0ycpMHBwzZtPSjEjklQMSvy/GXu8eGWSKhfh6O7skmKkf70HdhCi9FqM5qrAhJy8DA3ygnvyD6PL3U4Hqoet41c16+7fph4TCgTx0o+p0ose+jqWoSOJd3uUu7RqaFhSpBuTDjB+CQJO1P+ZON5YpTMVLnj/7k+twfNnDF0vzM+MYPUJP0PMBuv2t/mt4+o/s4qdQhelmGiuaUk/SYbYVkmykfQyuZc73tJM1n/iFqQp5TEjfx2mDJQY2Os0+8YUxiaYfZIwiDo9itQ0Dzq1h1pmclpYZfM4i7DqJUbwX51Ob7E2hoBXRf0t9KfhBmuIqSR5P8tlDa+H460boBZWmcPQvu2aRRNBMIK6UfqM6vPPxurMtOg45phVjWjM0BnU6B+albAuLyxacO2pMehQ0+3R4oxQjTpCqZXoSKmXmkGHGZ0X7iZQo8zTzqe4QH+QlL+13E02yUo0nCw6KHdQS7cCEAc4B2iH4lQaSrqNCMCDJu1tPkwMWJ7TMr7jOKVDRglfIV6Iz3u8H6IhOrKtYrqZ8vPVvvzqHPURP53WINNVDhVJfZ94XJNbZg2rxWQZzYgKYfzHrZ+t3vB1hhIjbuIJ4Uf/iZGC02+V5+5UZM5dd+I7NEOYo19+7xlgH6c3NJDrgyLXOeR1IIYP1dKEt7y8DMiwXf+tSr2p/w+fDgpep+HjOaxdZGsbE7xpriP2Hlft9YdNP8FxIlF01IhyD6y7LOWhpg2olS+M0dzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(366004)(396003)(136003)(346002)(376002)(451199015)(2616005)(66476007)(53546011)(86362001)(6666004)(8676002)(52116002)(4326008)(66946007)(6512007)(6916009)(6506007)(316002)(38100700002)(66556008)(26005)(31696002)(38350700002)(478600001)(83380400001)(6486002)(36756003)(186003)(31686004)(41300700001)(44832011)(5660300002)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2NLd2Zobzd5NGNzSnllTTVJN0ZOTkdHSngzenZQV3kxdExkMERrbUZ2b2RQ?=
 =?utf-8?B?bDRxVHVZeldHTjRvQUgyWC9US1hJZXlEQ0N5R0xXU0Q2UWFtTW85VW82c3Y3?=
 =?utf-8?B?VFVSTUtsZElvVEp0TXAzQkl3Zkp1OENkbkkydWNjQWNtUmh3aE5YWjNua3lj?=
 =?utf-8?B?VGdRU3Y3U0tWcmNxa01EN2xwNC8wQ3VwWEtOY1dRd1NaMjhkWE9DRk0vdkwr?=
 =?utf-8?B?bUVPN1dya0VReVplMEVPcldrNGQ0VmM4SzZwTm8xSStIS2FKMlV0cUtOaTEz?=
 =?utf-8?B?SEpSV1JiYmg5NzNtdGZCQkJYUjJTaUpsVlVRaVpEdkE3b2FFRWNETTV6S3VN?=
 =?utf-8?B?UWZiTGRURUt5Z3hVNUxQZlAyYW8rRFErakR2cmg3MVcrSWc0MmNRUlorSmtn?=
 =?utf-8?B?M2RpSi81aG40b1MwQVZxM3ZOTnFaMWVyZXZMWml2N01kOEkxWndlakUyM1JQ?=
 =?utf-8?B?RzUvTTBGSWR4VlgzZWY5R1dMUmwwSm1Ea3M0Qk1JR0JNZ3BhYlZpZzBpTlhw?=
 =?utf-8?B?cVpXaTY0SGhZQnk2U1NaRkRrNHlUUkY2R254NXJOa04wclFDUmp5ckdub3Zw?=
 =?utf-8?B?U3RLbWxLN2tVRHRDUTJjQk9oaldwVEMwRStnSDNZYjlEYVhqT2ZXSjcvbGtI?=
 =?utf-8?B?S1JSK0RNZ0t2ZE1MdzFVMi9ONVdqWkFnOVJ0RlZTNWE0QzQyS1E1eHc1UlFr?=
 =?utf-8?B?V1QrT1VtckpreldDTEFPZXo2dmhTU0ZCdzZuM1Q2NGV5Um9Na0xBV2l2ZS9M?=
 =?utf-8?B?dXZPaTBOejM3ZWJXcmFHNlEwd0tuQU1tWWZZbG1pV25EZ2lscC9DQ3daMlBw?=
 =?utf-8?B?ZDhMK3ZvOHpLQmVQWXd2ZnplQ3AyMGUraCs3QlRReGFhWHlJVi9rNWhSVEli?=
 =?utf-8?B?ck5nQ3pFSjRQbjVUVVU2VDBMOHJybWVJSGNaRnYxSE4weitRTWhaeXMwOUJH?=
 =?utf-8?B?NWFCM2RsdGl3bHZhZHpqK3ZxMkdoNFQ3WExxVTZDejF5MnN2M2xhSUhoK0pO?=
 =?utf-8?B?cHdKdlNvMDFZQ3ZxMTRIdXRockJzcVI3cUxiR1lkVzRUR1hHZi9vQ3drNTlu?=
 =?utf-8?B?bXpSZ2t6ZXgrZ0tDZE9kbHRqZGhkS0ZwcGlXMFBNcFBFalp3S1g5MWxlRTY0?=
 =?utf-8?B?T3NOKzRQaUxBVTloMTdLZEJxcGJoeW9CNHdidXp1NHMvSlhROVBGN0VMcU5Z?=
 =?utf-8?B?c1BzOTFGbUFxUFVjMFBBK1ZObC9sbnk5M1Q2YkJnNUxSYW5FV3ZWSFJkSmFB?=
 =?utf-8?B?WXhSWDFVaXB0NkRzbFZ5VW5HTGtxMm1CTlBGUjNlUjJMOFNhVVFqR0NERjJm?=
 =?utf-8?B?WFhveHRVU2FVV0ZucGxrelEza1Mzd1p0TlpsbFFhZ1ZISDNjQ2VyYldnVkxT?=
 =?utf-8?B?NVRmalQwSWRxcjJNY2NEUXo4ckQrT3F2RVJwYXVBTGhnenRyamxhZWJZN2VG?=
 =?utf-8?B?YzhqV3kzQSt3VzlqU0UranVzWTlla2xRbFQ1QUlyZWNjZVNxNklNT2RwWERp?=
 =?utf-8?B?NXV1NEluZi92N1lRU1ZzNkVOTURhdm5zNVF3MVZRSzlPM0JyK0syUUY3QVVl?=
 =?utf-8?B?Zm1LbU42eTVzVXE0b3BkdmlSVUVZL2t1QnRDRWZZZ2QwZlpaTGZ3VGxaS0FO?=
 =?utf-8?B?SmFKN1VCOEt1Sk5Va08xN002ZTQ3UCtTV1FjVXlOV05TbElhWjN0SmJXQllC?=
 =?utf-8?B?N28yMHJXUUcyMkxkYkF2d29sMUtPZ3J4Rk9nMk9CeFdVRzQwRDNOT0QzdVpx?=
 =?utf-8?B?cE5FVmlMaE9Ub2wrUVk3eVN3b2tyVkJleDhzWlZ3c0Q2SldYNEFYdUdURE50?=
 =?utf-8?B?S092cWVRZjF4bXhlTWFVdFJlbVBZVTlXT3VLaFVCVHdDMzlIZ2VoOGYyUXh5?=
 =?utf-8?B?SW5WREN3L212dU00K1JqMzcxS1duVUdlNTF6V21INDFYbU4za1B2RUFIWVRS?=
 =?utf-8?B?VEVVSHdTSjVqZGNiM1puY2VTdURES3F1RVRoWHF1WlpjUDJsRjNTbkl1VVVR?=
 =?utf-8?B?MUh0SVdhRTlSR0tYbllONFhMdW13M1hYbFVXN1JieGlXNk8yTUtTVkJERGdU?=
 =?utf-8?B?ZWxBUzVDbXUvUlJSdEtSUFhRVFNvTXM4Q0sxWmFqN0VWUDRSVDlzZUlkMnJE?=
 =?utf-8?B?dEVtVWhoOEQ2SnZqbE9oQlpWZFkwWGMwSjNMd1NmbHArU0NZNkxTeTNlUlVX?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81358e6-a366-4392-4885-08daa896f828
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:05:59.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRkoASAokFEcw0/bs4oEh883UbN3x8fgknz5b0EXao7W6DkgiK4EiPRq49WlhswV3lHm4+rvYJWTBKy5o9WZYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8541
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/22 2:57 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 07/10/2022 12:37:12-0400, Sean Anderson wrote:
>> According to the datasheet, the "oscillator failure" bit is set
>> 
>> > ...on a power on reset, when both the system and battery voltages have
>> > dropped below acceptable levels. It is also set if an Oscillator Failure
>> > occurs....
>> 
>> From testing, this bit is also set if a software reset is initiated.
>> 
>> This bit has a confusing name; it really tells us whether the time data
>> is valid. We clear it when writing the time. If it is still set, that
>> means there is a persistent issue (such as an oscillator failure),
>> instead of a transient one (such as power loss).
>> 
>> Because there are several other reasons which might cause this bit
>> to be set (including booting for the first time or a battery failure),
>> do not warn about oscillator failures willy-nilly. This may cause system
>> integrators to waste time looking into the wrong line of investigation.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>>  drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
>> index 9b0138d07232..1eb752e4e39d 100644
>> --- a/drivers/rtc/rtc-abx80x.c
>> +++ b/drivers/rtc/rtc-abx80x.c
>> @@ -115,6 +115,7 @@ struct abx80x_priv {
>>  	struct rtc_device *rtc;
>>  	struct i2c_client *client;
>>  	struct watchdog_device wdog;
>> +	bool wrote_time;
>>  };
>>  
>>  static int abx80x_write_config_key(struct i2c_client *client, u8 key)
>> @@ -167,6 +168,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
>>  static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>  {
>>  	struct i2c_client *client = to_i2c_client(dev);
>> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>>  	unsigned char buf[8];
>>  	int err, flags, rc_mode = 0;
>>  
>> @@ -181,7 +183,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>  			return flags;
>>  
>>  		if (flags & ABX8XX_OSS_OF) {
>> -			dev_err(dev, "Oscillator failure, data is invalid.\n");
> 
> Simply remove the line.

I think it's important to warn the user if the oscillator actually fails
so they can e.g. replace the crystal. Additionally, this can help debug
failed batteries, since you will see "Time data invalid" in the boot log.

--Sean

>> +			/*
>> +			 * The OF bit can be set either because of a reset
>> +			 * (PoR/Software reset) or because of an oscillator
>> +			 * failure. Effectively, it indicates that the stored
>> +			 * time is invalid. When we write the time, we clear
>> +			 * this bit. If it stays set, then this indicates an
>> +			 * oscillator failure.
>> +			 */
>> +			if (priv->wrote_time)
>> +				dev_err(dev, "Oscillator failure\n");
>> +			else
>> +				dev_info(dev, "Time data invalid\n");
>>  			return -EINVAL;
>>  		}
>>  	}
>> @@ -207,6 +220,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>  static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>  {
>>  	struct i2c_client *client = to_i2c_client(dev);
>> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>>  	unsigned char buf[8];
>>  	int err, flags;
>>  
>> @@ -240,6 +254,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>  		dev_err(&client->dev, "Unable to write oscillator status register\n");
>>  		return err;
>>  	}
>> +	priv->wrote_time = true;
>>  
>>  	return 0;
>>  }
>> -- 
>> 2.35.1.1320.gc452695387.dirty
>> 
> 
