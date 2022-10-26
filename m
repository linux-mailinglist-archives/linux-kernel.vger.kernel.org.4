Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BB660EABD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiJZVRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJZVRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:17:34 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1EA1213F1;
        Wed, 26 Oct 2022 14:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/tIdr8r5pgRqlf+2IrrJMA/g9HXH1EjFgpdORTXHKmMcgKa352m02yZrn7c5LbT2S2hVXVISJutCvaRPl+Ds90IVnHdXSwxrpDxM4nY0qdJ3JZWEUJnGBsgIiIrB7MMDcXjNTeEtASns38ctgv/YwyUmUJ6SCmQM6EiOfL/4yxQ06ipmVnKtMGjQahLrUb8g5566f63okNOa8FdBxc2uTPS59uM/v61WHc5VNfHAHAWayMuiFA5beX1Vp7KDSdarwjA+6aKNJT5K0fPxtErE0Iq1wgEXWMyhhdrwz5LMiMqs2xuMC3PAedw0H0kaVw0XTKqEH/s0aDilM1q0mMsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA94CNmBNyt/SwZncdpnb+psbFj0Um7gimfLo5i1oV0=;
 b=SbeQy+uijgm7Mh3GiXnWjd11s3wrq3rmGb3gW7rlDrF8yHAS+nrvjsVDvxXEboAjUUHCCR27hi9FXnRanB8E+1i/FKsB630LqeewELFm4+BybLm7O8OsDlQC9poXMZcGzokPU+4nDoxiN+XZlvWNJeiCv6nEp8vW6R6grPiCDjaZVHMYqI0/rm6duV5kPDttUDRS3iK58iH4o+A4JmHjxMcNtwVCSP015rmrESsEhEAX+1kkCyhbN3nMUCl53lrp+T20XJTlqIXnOgEuhYxqPcDPXdT+lROU09w22Ctnk0sn7Q8w+Y3l2LT/Cis5MvJW1bnV+dwebZhFrJUpOAmWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA94CNmBNyt/SwZncdpnb+psbFj0Um7gimfLo5i1oV0=;
 b=nuXSkRf09hYofrM6zmlayMTs4QdkTmmUuGMn2L/oTnpvUXHo3mKxZ5kiSWGqXbozuhsA0/hGth5gRPS5ggOtBfERkX2189iO3Euf8f4gq5EjzjeM6dbp72T9y3IIGRbHChBf9qHHp2iguHYgzGp86YQdW5hS16xPDE9twHHYujFDjWmz2+XPx/YiZbivQwddsbnD7oYRyNW51DNpOj/oGKA5rM+tO28PZOJxzYfnhgVNnkUsAYQ6U2QjxYRYF5InuhRfbTRHJCFAUTod9u8Wo1SH0Esn0Dd3YHHIkm8QllOL06MtwVt+CMcVx9yA6s4ldghcRkMo5GIwsYQMceIMZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by PA4PR03MB8245.eurprd03.prod.outlook.com (2603:10a6:102:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 21:17:29 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::447d:3157:60b0:ded8]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::447d:3157:60b0:ded8%7]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 21:17:29 +0000
Message-ID: <8c82d111-7799-3ec9-4354-8c2344c15a6c@seco.com>
Date:   Wed, 26 Oct 2022 17:17:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] rtc: abx80x: Don't warn about oscillator failure after
 PoR
Content-Language: en-US
From:   Sean Anderson <sean.anderson@seco.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221007163712.2193966-1-sean.anderson@seco.com>
 <Y0B2pNv8otKkLs1D@mail.local> <a7c4fdc6-a704-31dd-d596-daa484328024@seco.com>
In-Reply-To: <a7c4fdc6-a704-31dd-d596-daa484328024@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:208:23c::30) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4972:EE_|PA4PR03MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdecda5-dbd9-40c2-2465-08dab7977d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXenD3fhJVeLAnBPXuFDdzTR+jbyE5VkAuERBO1YePq7EXaHj5GPLNXGo09XLMxdXY0+O7r9jl4z9HqL3AXQcsh8bAykg1udCGxj1zGLwWNeRD/b4MQUi13dIUNXG3z6teqN7SWR3P5UFa2bbMxjmJ8fBcsTV8CpOGovotPCf7NqngXiI5AIuJVyCunxOQytsFhxg9n4xY64/goSGzFvEKE+lOXSBJaD61KFOxXIX3yiob+lXRHtu9uC3xcziydqPCvSdvJEuOXDf1vhxQC8q39Mdhv2UZBadzeM2jeEgCWxCEJUc2R76xnLc/C+JVPCXCsYMR5OtmpnP+Gz/eKKEnf5x0oM8UwwMNVZm5kKfg4Tzufxl1E1jTV0VW3IwbCxYNZriNaJTLtg/rq6ATDo2W4wke3OQjsYNh01Yp77l237TmNJ/ORmB8LXpvjKjA7TcmDeV7AMsK2XrtGTkrzAqOoKWyOEqatAYo/XYoBJHpAturFWc+919j5c8uar9XXTlVsqhEYVI7yfWe39itjDpWeeo4USRRvGbZXI/yzIuLxPxOr0yOvYhK7loWs7hTxAIs6djXrzdkcAfOzhQhATSTiHUhD0g74dqoQ3SppXcbL942tYtsGpjlugYCqM4KPs2oQFPrDIbhYl9yAKJp3c6HTbO/Fs9YzeysgE4yepiavASaG5gT54JzyRQ9T7hHg2t/rEF34tQpLWYIpxhvoM89uDgZCyCgcEvQ33HhtiocNMBktpZltZ5gb7Ab5Y0lrGx5SKLqTMOY2oHrxIoHSPv6KMMHhgRgBR2q1D4gbL4aa4dCNXqVAOevzNzqakNyn6YHnYka8X9U09hbNuY3C8ocRWqHagMbe9J9pmXlZQoe/rAgMsv9YZrOzJeYAn1gdU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39850400004)(451199015)(31696002)(53546011)(52116002)(36756003)(316002)(41300700001)(83380400001)(186003)(26005)(6512007)(8936002)(5660300002)(6916009)(2906002)(8676002)(6486002)(4326008)(31686004)(86362001)(38350700002)(6506007)(38100700002)(2616005)(66476007)(44832011)(478600001)(66946007)(66556008)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUhieEdSZmN1TnpOQTlXQkZ5d2hCVCtjUHpwUE5kSnVzMzh4VkZjSitJWXVE?=
 =?utf-8?B?aGlyQy9veTBoMUJIZW5ic1FqS3pKMC9BajFsYVVOWlljcVNJaWszMDZiQnht?=
 =?utf-8?B?cVdhczlGN0tTVk1IK0F1ZjNSN2VGUmowQ0NTUHJac0xXVkZIblhYYmVtWFNC?=
 =?utf-8?B?WXFteThTRzZUM242T01YQVRkZ3F2TkpPN3FsaVhFY2tCWWd4WVJqUWsycXY3?=
 =?utf-8?B?TENMZFlXU1BvTzJJUUpBTmZTTE1xZThvWmVYbmtEcFNEN04rbVUyUGxaaXUy?=
 =?utf-8?B?dU5YbnhrdXpqMUx5cS9vWVErYXFuMFpqamM5UEJ6SDNidmwzVnM4WmovZFhu?=
 =?utf-8?B?SnNSdGpzd2NTRXFERlZ5cUtuYzFQQTcyNFJrdjFYcTREMXpURFZCaVNRY0VP?=
 =?utf-8?B?c0t1R0lCTjI0M0N6cS9wMTdFWWRYUThpUk5KUVFEQzZqZWVUcEx2UzdjcFAx?=
 =?utf-8?B?WGNzSnV5bmhkZkFsKzA1QkI3dGhoUC9kRE5zdko3ZjNyWlJrRTE1bndMQWhy?=
 =?utf-8?B?OUhvd016dnVpT0p1VGtMUGxXcTRmRzYwanBWSmN2M0t0TndkbldjaHo5c1lM?=
 =?utf-8?B?VVVJQlhQN2FDTE1QalIxU3d2UTZvZTFIUzY1VG13RndwRkdMVU5INDhNMmpn?=
 =?utf-8?B?MFRtb0lDZ0xLZllQUTdJY0h5WExJS1dKWjAvQ3NLVHlFOHU4SHlMa3BJVElh?=
 =?utf-8?B?Y1IwU0FTeExSRDBDNExuTEszR3dicVVDeFVvd0FLUFNWTStJZ2lpNWJZQmYx?=
 =?utf-8?B?VWV4Z3RxMktUaDZTUUkxbTY3RWNxYkQ0ZzNsNXU0S3VnKy9ERTl5aGRhQzZQ?=
 =?utf-8?B?cEgrWkFjUDBsNldqOTFPRzVORlFObW9DOHF0djN1d1pYUTFtSHhkOE5uMXQr?=
 =?utf-8?B?RHQzQ3VDMU92N2lYa3RFWFRad0QwaFRybUNaREwvTWZlNDNsampIbldDdmpt?=
 =?utf-8?B?b3N6dkhXbUt5dU9QZUpIdUJaWEE4cnd1OVA3VGh4RHZZa0tQdEUzRUtuSlJh?=
 =?utf-8?B?WTBFRlhBWExVYU0xZ3djb0ZqQmh1amRCdG40cldiUVFnTFViRU5TVnhpUnhH?=
 =?utf-8?B?T3JSdHVQN29teHRmS1ZRVkpLZHF6dkFkUmVsYVpINTZjMVFlQkRpaDBUdmR3?=
 =?utf-8?B?Uk5NOFYxQzNsVUJickZpYnhwUXZDTm94YXI0UCtSeEJvc3M4VHFzV1NlbFhO?=
 =?utf-8?B?ZUxxQXJ1d3Y0dDE1c2x4ZnpiWmtjV2l1NW55TjdwSjQ3MU9ROEtsNGtTN1k0?=
 =?utf-8?B?akROSU9VL3E0WThaRzk3WWM2TmsrR2lIT3VERGh3T3ZsejZFOE5FVythOU82?=
 =?utf-8?B?Qmc4V3BMSHAyajJJUXlCdnJZRDJQdGkrYmlNMGxaKzJ4V3RWOE5VUkNyNjQy?=
 =?utf-8?B?N29tamk4bms3bmZZbjMwdHBacTBCa04yZWNkcVM1bTg3WWs5Y2NOVkw1Rklu?=
 =?utf-8?B?Mk9NbjBQN1lpZkxQMnZRdXlvdTJMWjFRV1hEUGNVdGRXQ2VqUWVoMnJ5UE9q?=
 =?utf-8?B?OUF1OFBxYnhPeXlncDNpOWl2MXJPbWxVTkYwbGErREZjT0VQdGh0TndqQnA3?=
 =?utf-8?B?cmxwV0JOMFBFQ1ZMWkxWZWdYQUFXMGV0VmtjR0FjamxoU3VwSElXRVQ4eWhG?=
 =?utf-8?B?L09tNnZXc3ZaZzdiWXIxZk1EYW9sVmpuUGkrbVVLQnk3Rmh3ak5pcUFuUi9X?=
 =?utf-8?B?d1hJVTlrNHZCM25tMFB6bGcvc1BqZTh4NCtJMVhLenJ2UXRWSzlxVWZMQ1Ju?=
 =?utf-8?B?bDN5RVJyZXhud0JwK2tBQUpYakNNdGVCZ0Nuend5QTMzL1lOZmVuVzZMN2xK?=
 =?utf-8?B?djh5bEp6MUtROUZBaFc2V2c0c3IwZmg4L212Z2FRNC80TlF5YnpXMTFPMkkr?=
 =?utf-8?B?S1U2YVhuR01oRFdTVDlNK01rOWJ4d0FGQjR5ajZLTHNoYUt6a1lPRHVuRE1P?=
 =?utf-8?B?Z0hmcGFZRTVlOXR4bUQ2NFpMN2UzNmhreUdpbXpDWndlTm9WdTgzcEU2MitT?=
 =?utf-8?B?UUdkQUZad2paS1RNdkdES0hBR2xxK0VGbDMyc1FOYk4ycDNGZ3FmNDBFQmhs?=
 =?utf-8?B?UWlsR0t5VnNHT0JqbGhpNWJNRk5ZaFI2NDJYcWlDTllRa0o3V0lFRnpPYVlV?=
 =?utf-8?B?dm9LTis3QUtVYzBKSmNEUU1ielFNRHpRRGFKSmptaHNIRzJ5TDZLcDFuOEpu?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdecda5-dbd9-40c2-2465-08dab7977d42
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 21:17:29.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/w/dQL08hj7plZTHcRN7ncavQD0fRADB1Od2Oahw0eb77H3q8Xh9nUcD43ImkllgWvQCr7lRgQXP+loxOwypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB8245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 10/7/22 15:05, Sean Anderson wrote:
> 
> 
> On 10/7/22 2:57 PM, Alexandre Belloni wrote:
>> Hi,
>> 
>> On 07/10/2022 12:37:12-0400, Sean Anderson wrote:
>>> According to the datasheet, the "oscillator failure" bit is set
>>> 
>>> > ...on a power on reset, when both the system and battery voltages have
>>> > dropped below acceptable levels. It is also set if an Oscillator Failure
>>> > occurs....
>>> 
>>> From testing, this bit is also set if a software reset is initiated.
>>> 
>>> This bit has a confusing name; it really tells us whether the time data
>>> is valid. We clear it when writing the time. If it is still set, that
>>> means there is a persistent issue (such as an oscillator failure),
>>> instead of a transient one (such as power loss).
>>> 
>>> Because there are several other reasons which might cause this bit
>>> to be set (including booting for the first time or a battery failure),
>>> do not warn about oscillator failures willy-nilly. This may cause system
>>> integrators to waste time looking into the wrong line of investigation.
>>> 
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>> 
>>>  drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
>>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
>>> index 9b0138d07232..1eb752e4e39d 100644
>>> --- a/drivers/rtc/rtc-abx80x.c
>>> +++ b/drivers/rtc/rtc-abx80x.c
>>> @@ -115,6 +115,7 @@ struct abx80x_priv {
>>>  	struct rtc_device *rtc;
>>>  	struct i2c_client *client;
>>>  	struct watchdog_device wdog;
>>> +	bool wrote_time;
>>>  };
>>>  
>>>  static int abx80x_write_config_key(struct i2c_client *client, u8 key)
>>> @@ -167,6 +168,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
>>>  static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>>  {
>>>  	struct i2c_client *client = to_i2c_client(dev);
>>> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>>>  	unsigned char buf[8];
>>>  	int err, flags, rc_mode = 0;
>>>  
>>> @@ -181,7 +183,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>>  			return flags;
>>>  
>>>  		if (flags & ABX8XX_OSS_OF) {
>>> -			dev_err(dev, "Oscillator failure, data is invalid.\n");
>> 
>> Simply remove the line.
> 
> I think it's important to warn the user if the oscillator actually fails
> so they can e.g. replace the crystal. Additionally, this can help debug
> failed batteries, since you will see "Time data invalid" in the boot log.

Have you considered my reply?

I'd also like to note that 

drivers/rtc/rtc-ds1672.c
drivers/rtc/rtc-pcf*.c
drivers/rtc/rtc-rs5c*.c
drivers/rtc/rtc-sc27xx.c

all produce some kind of message if they detect a power loss or oscillator failure.

--Sean


>>> +			/*
>>> +			 * The OF bit can be set either because of a reset
>>> +			 * (PoR/Software reset) or because of an oscillator
>>> +			 * failure. Effectively, it indicates that the stored
>>> +			 * time is invalid. When we write the time, we clear
>>> +			 * this bit. If it stays set, then this indicates an
>>> +			 * oscillator failure.
>>> +			 */
>>> +			if (priv->wrote_time)
>>> +				dev_err(dev, "Oscillator failure\n");
>>> +			else
>>> +				dev_info(dev, "Time data invalid\n");
>>>  			return -EINVAL;
>>>  		}
>>>  	}
>>> @@ -207,6 +220,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>>  static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>>  {
>>>  	struct i2c_client *client = to_i2c_client(dev);
>>> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>>>  	unsigned char buf[8];
>>>  	int err, flags;
>>>  
>>> @@ -240,6 +254,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>>  		dev_err(&client->dev, "Unable to write oscillator status register\n");
>>>  		return err;
>>>  	}
>>> +	priv->wrote_time = true;
>>>  
>>>  	return 0;
>>>  }
>>> -- 
>>> 2.35.1.1320.gc452695387.dirty
>>> 
>> 

