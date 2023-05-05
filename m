Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE66F7F1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjEEIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjEEIbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:31:23 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350DA19434;
        Fri,  5 May 2023 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683275453;
  x=1714811453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A8146vmVnqGqqt9aJNtJSfgZO4dl4rg59ynDA3go8v4=;
  b=H21iXvB7zkO9UDcb2sj68HPwnMWv8P5U8JMRG7w4guiHaSvz1qL7ET73
   gS6RlBs7O2pcVnAu8TMmfQBviMYk0awEBCFHpht1cpGa5fW2fP3bOc3ed
   QKjNeV0F7vepb5uqpQtgbVLwmL9oIQs9UCFCte1JQ690F/JLHGrs2HaaL
   MslJKlPWjMm0dstHk80fqIGKHwShu8C8hCoiRtUT6UMTVsMqeS/9O0Uda
   NIQmzoGN4FvsBKOXIY4tettmOWTURnatupxEsqsG1sIsNxEgAUdQWzn8H
   EZXcK17ebLLMPmaJvrtOL1z5T24rLN00t8y2mey53ApJgGM6KQ/ceQea6
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX5AoqksBBzEuDXK+ZI7l7FpjB7F+Lnl0YA8pJllHmpi90tduOVVXfwvheYxpnihdNPq9ffDHj0J/qo2qeSk9xXsooxOXL16V1iIh9HgDVhCsQw+jTS4YLjGB+aN+PXEFb7ypqJaNDqhAeHKHq3I2OW+ByRUEFQRpUlC/HpOKewfvFuCvqS4HFw76vAY0whouq7elomLwIls1OP1oPMkMX4a2CW69UMKKws0iL5SpaG+xjpkY1eHzpqDEOFT4CGwO9HytlqXSoV69bqhBIbdHujcSalnaTEq1FcQqiyCH1QYWSRFaCjTwKCMLEgqgl5tiUEH4OInpyuGmo8QOK5dQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8146vmVnqGqqt9aJNtJSfgZO4dl4rg59ynDA3go8v4=;
 b=EC6cIKg+BN9MTZmAhGRRtyBYVOOfEKqTfLrcLVmHV8MisubhLLKrn1EuPV/5O84bxIrDE83VvQOi9+15mQRsWN/sBWX7vJT0npUMWB8EjfjeOgXYYX037XRi3xb3WsZhsIBAAXVvtJMv5yq8BNZE6qOEPup3+P6F9/ash3nRCeDL5b64D8/o6+/jJ5aMBH8KBWOe+jUVR63ZUMcRk+z11YlvAusObtiKYcXeS4Q76Q827WripVFE8v/pAnXStr6btGyhLMj398EnZcHhLjkVP3C34qC5CS/HEY1M8d0r3zd5tfk0VKZZcry9drP7ml/H4TFe4UbE2RIyIi8JxZEcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8146vmVnqGqqt9aJNtJSfgZO4dl4rg59ynDA3go8v4=;
 b=M2eGK2S2VkoNiEWu+AQst5Pdcy87BcnZlUL1rsktQNMhOcnSFZgyvK2+WRc8UQ6pxfZkqbJt2+FaCNjxRNpZK5CrscNMcedanYFapbwRDNce1dCJgZ1ngt82QRgqnUUJ+OEEsp4Y/9ogVC+zoEfZ+b6VQq1qFL++Om95BOpifCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <cb621245-7133-67ac-2b1f-b829b96b7c07@axis.com>
Date:   Fri, 5 May 2023 10:29:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] regulator: Add support for TI TPS6287x regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@axis.com>
References: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
 <20230502-tps6287x-driver-v2-2-fb5419d46c49@axis.com>
 <ZFOfX+PTsmA35TsC@finisterre.sirena.org.uk>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <ZFOfX+PTsmA35TsC@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|AM7PR02MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: c05e4f98-83be-4bf3-01da-08db4d42ea5c
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5laQ1WJw9eqGNwGpF5+Bj/M0X3LtcWf65lmsxG1dQhqPYR0/2DDUhPnyG6MtGlmqKIX2RtbeFkappw6wE+ZT8z0wECkJF732hNl1xS7KtjFS5T63+rUOhfMt4QAvms/p6Qn+jXEmh3ro6vkASm3twNJmWxL/8uhzwKifuZnc5I2cV6uSsZKkZNvgvnahM/SntBch/qHnlC+s178qVWWlB6f/sorEIYB0JTNj+R8+GcdwTXU2JRis5vnZzFWX6DOs6U9xQwioh9fFT46KNLZLX9BkyM5LSIeVklXurwPTfG6e/x4F4vdc8stw++aC3T+cYTpHIEasC1UYpDQjQvE5MOhwq7YfVPupJwBRQ07H2A0oulpJ+HtYyT5ENCTIEFVxProEr7MloQBulyW/2fDtLG4q9yv48ynOLnZ1/nX6DLRZlqGYUzJjkc+jw7ebUSWlltVyo8WV+7jPEjx1ExYFsedn/EoxGo5uZ5MykruISRtK1fC5x+kW63UWHJexG3gukX0ssYkL/7cS6NHklTFH3O2c6zaLWQ6xeSF1MaRWkimBkbTTkIAWjy5X5TzG5J/83FOnVdK1ekO1+F9jyM44M57e057W4u1CoEj9GPFDS0ipcmmtrtWkRpdDwj1J3Olj0aVeDluJzwNIO+YdQ5tOwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39850400004)(346002)(136003)(376002)(451199021)(31686004)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(6486002)(316002)(54906003)(36756003)(31696002)(66574015)(53546011)(107886003)(2616005)(6512007)(6506007)(26005)(8936002)(8676002)(5660300002)(2906002)(41300700001)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjVNMG1oZDdrTThoa3g5eUd3VnRxMmoydlN3TmhUV2tpTE5iUE5tcEhxM21x?=
 =?utf-8?B?V202eGpteUhjUzZOYllzVGprQlZwUTFSQUp0NFVWWDVBVTFFTHZLdGJPTk56?=
 =?utf-8?B?MzRUUkpucnBLVVI3cGVScnFFNy92VmROaWxqT2xlRENMQS9PZVRRbW9OZ2Fn?=
 =?utf-8?B?ZG1yZm9wT2U2OHdTUDVuRWFNc2ZGNEhOUDYrNkdoY3U4V3pYREVkeVA0K3Bh?=
 =?utf-8?B?ZjVXRlFFV0ozbk90Q1FZQ2pVdFdPVS96bldJMm9BZ1d5aWIxSDAxOEEvSWp4?=
 =?utf-8?B?aFVUSkZ5dE00Rm9iYWVGM21zSzZEWDk3OEVoaFVlUE40WEs0VDBVR3U5TDNU?=
 =?utf-8?B?ekJHZVlSc0FpU3RxREF6Q3krcUszaHZNald4Q1ZGZGtjVDN3TXh6SkVFcDR0?=
 =?utf-8?B?UHhMckV1YURnakFLVGJndkVjNTRPS3FidE05UktiNm1IdDVUdkduSHh2bzhD?=
 =?utf-8?B?SS9HQlc1R1pjNENuZnI2VnhOSGR6bGpaMjNmQStMOTgyenh5MFVPNUloSjJv?=
 =?utf-8?B?U2VNeWZkU2puL1N5alJNeWdLLzZTaXIrNWg4Szg0UEI3aWlubU1DTHErRjFs?=
 =?utf-8?B?K05YOVFVU3dmRGNZdlJLZUluVjN1Skh6eG90SUJKTFVobG5kdkErYWduWHNY?=
 =?utf-8?B?VXpkZGJDUG5sMUQxTlJCcFY4Z3ZUYWF5RHplK0tPOE54dlhOS0d5d0xSRklO?=
 =?utf-8?B?MUR2dnNseHlDMDZzdmVmMWU3VmMxWFF4bHdNK29FVEJ5WmVuM1NRNlVaekpV?=
 =?utf-8?B?U0VDT1JIWnhlZko1RGhkNVhERWlrMjZuekRCR0xKMWxkYkxxbzNieko2VVUx?=
 =?utf-8?B?RWZ0UUs4REViWm5IeEVjUXlnOU5ZMkgyV0VCdlFMci8zSG02VjZ6MDM3Tldx?=
 =?utf-8?B?cEJjMTRicHhEenVpUC9uMlRpSUd3cHc3U21sT1UwY25YVU1BTUdKNVVlTlpH?=
 =?utf-8?B?b2t3RWcwd1F4dHVENWtjKzZ6ek5NbXAvMGViUHVJZmhPQnAvNjIrV203UXNr?=
 =?utf-8?B?bjUraU81WFQ1NFFiYTlsZmlUSlZlNm52UXZMczlvUEF6ZXB3Kzdsci94S1Qr?=
 =?utf-8?B?QWxNVUhGODR5N1RPb21naGY0ZGZFZEZCOTVHbkFMbEN1N2srY1BtazBDOExD?=
 =?utf-8?B?WVZhZmFva0s3djBjVWh5YnhMckkxQW9oSjEvYlNzRW9MdjdHWGNtSzNTTzN0?=
 =?utf-8?B?anpvM2RTMFRwKzhsNWMyMjllNFpwVXkvVlNwdTJyNzdNTlhkT0dMRjErUVBs?=
 =?utf-8?B?TmVQSnVCcGJLOGZkanJZaS94TkkzTEVVQ3BOZUZ3Z256UjNtTWp1dmZjZEZ4?=
 =?utf-8?B?aEFsMXdpa1I3SUJjc09sbE0vemozM0wrYXl3UDV0NzlPYXEzdHVoQlNKWTRQ?=
 =?utf-8?B?SHYwU1prdmtxNkJhSjVITHlTZUtPMU9pbmV5L3RxZHRzNlplWFNLWSsrT0xQ?=
 =?utf-8?B?NU5IMmdtaEExMEVueVdHdTJsU050anFwby9Hd3ovNy8xcHJLTFFDWldCYUdp?=
 =?utf-8?B?L2p1NTJQamRUaHBydUtBNHYzckg4aE14bnMzc01kZU9BaG9Rd2lad0VPNE93?=
 =?utf-8?B?WVRFTlRGS1FpZDlpUTZCZW9qektKV1F3R1AwdjR0cmFmWW9xY0Y5U0NPTWVa?=
 =?utf-8?B?YktidVg5ZFc3K3lqNDhBTi80MkwrWmQwWlR6NWFWQ1JMd09IaDkxRWw5b0xl?=
 =?utf-8?B?SllMa0ErbW5MNjJUdE04TEVQZUpzNDlMaW9kRTZ0SkhnVUFKaGxjNWVEMUJ2?=
 =?utf-8?B?VGd4cGpjelpCMWZqUFNET2IwQ2xhU2tQUzNHNCs5em1tWll2TmVtZ3l6elAy?=
 =?utf-8?B?SC93bFRNMnRsd09CTE42UVcxdTdpS1FkRkhVc05QUzAyajdOaW00dm5CSDVQ?=
 =?utf-8?B?MzJxK1VJcjVRZW9ra2p6RHZEWUM4OEFyOXptWU1pQ2pCanUrL3lFOWRLditV?=
 =?utf-8?B?V2FiM2hmOEg5bklZSUgyS3kzYWJmU1FXWjVGSWl1dndka3loN0IvQmF4ZnhZ?=
 =?utf-8?B?UzhrTjZ2NllKWkNoS2dMSVdrSTVoT0FNRzBKWERBeDQ2T3BvZEw3cGtSbHIr?=
 =?utf-8?B?QjNsTVlGS25WUXpETXdBYVc5YWdzck1sTm9aKzVLR0tMMDhFb0FrZHlRSEZo?=
 =?utf-8?Q?yA2aYDvbDIDXchZ5taKwsU7LX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c05e4f98-83be-4bf3-01da-08db4d42ea5c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:29:59.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pYvqXq4sPK+5j3tK0Ue2c01sFKedIN2M4xKrIjKWxKMP4mMTD3e7x6rC/ZZzseg1nv1teBS9qPrKs5Vec+4iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6163
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark!

On 5/4/23 14:04, Mark Brown wrote:
> On Thu, May 04, 2023 at 10:30:27AM +0200, Mårten Lindahl wrote:
>
>> +static int tps6287x_get_voltage(struct regulator_dev *rdev)
>> +{
>> +	struct device *dev = rdev_get_dev(rdev);
>> +	struct tps6287x_chip *chip =
>> +	    i2c_get_clientdata(to_i2c_client(dev->parent));
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = regmap_read(rdev->regmap, TPS6287X_VSET, &val);
>> +	if (ret != 0)
>> +		return -ENOTRECOVERABLE;
>> +
>> +	return (val * chip->uv_step) + rdev->constraints->min_uV;
>> +}
> Don't open code the voltage conversion, just use selectors - in which
> case you can simply describe the bitfield that the device has and use
> the generic regmap helpers.
>
> The driver should also never be referring to constraints to figure out
> what the register values mean, this is just not going to work - boards
> will typically be able to use far fewer voltages than the regulator
> supports.
>
> Also try to avoid squashing error codes, just pass the result back.
>
>> +static int tps6287x_set_voltage(struct regulator_dev *rdev, int min_uv,
>> +				int max_uv, unsigned int *selector)
> Similarly here, describe the bitfield and use the generic helpers.
I understand. I'll change it. Explanation below why I did it like this.
>
>> +static int tps6287x_setup_vrange(struct tps6287x_chip *chip)
>> +{
>> +	struct regulator_dev *rdev = chip->rdev;
>> +	unsigned int val, r;
>> +	bool found = false;
>> +	int ret;
>> +
>> +	/*
>> +	 * Match DT voltage range to one of the predefined ranges,
>> +	 * and configure the regulator with the selected range.
>> +	 */
>> +	for (r = 0; r < ARRAY_SIZE(tps6287x_voltage_table); r++) {
>> +		if (tps6287x_voltage_table[r][0] == rdev->constraints->min_uV &&
>> +		    tps6287x_voltage_table[r][1] == rdev->constraints->max_uV) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
> No, as I said above the driver should just know what the device
> supports based on the device ID.  In general if a regulator driver is
> looking at the constraints that indicates that it's doing something
> wrong, the purpose of constraints is to grant permission for the
> features of the regulator to be used on the board.

The reason for doing like this is that all 4 device IDs support all 4 
voltage ranges:

   0.4-V to 0.71875-V in 1.25-mV steps
   0.4-V to 1.0375-V in 2.5-mV steps
   0.4-V to 1.675-V in 5-mV steps
   0.8-V to 3.35-V in 10-mV steps

Of which the third is default for all devices. The range is solely 
selected by a register
field (no hardware pin connection), so I can't associate a specific 
device ID with a
specific voltage range, which is why I let the DT properties min/max 
decide the range.

But I see now it should be done in another way. I can think of 2 ways to 
implement it:

1. Introduce a DT property for this driver, like "ti,vrange-selector" 
and select one of
     the 4 voltage ranges by desc->of_parse_cb. This way allows a new 
voltage only to be set
     if it is within the selected range.

2. Dynamically set the range when a new voltage is set. This way any 
voltage from
     0.4V to 3.35V could be set if the DT node has:
         regulator-min-microvolt = <400000>;
         regulator-max-microvolt = <3350000>;

I hope I was clear enough with my reasoning. Maybe there are better ways 
to do it?

Kind regards

Mårten

>
>> +static const struct of_device_id tps6287x_dt_ids[] = {
>> +	{ .compatible = "ti,tps62870", },
>> +	{ .compatible = "ti,tps62871", },
>> +	{ .compatible = "ti,tps62872", },
>> +	{ .compatible = "ti,tps62873", },
>> +	{ }
>> +};
> Use the .data field here...
>
>> +static const struct i2c_device_id tps6287x_i2c_id[] = {
>> +	{ "tps62870", 0 },
>> +	{ "tps62871", 0 },
>> +	{ "tps62872", 0 },
>> +	{ "tps62873", 0 },
>> +	{},
>> +};
> ...and here to enumerate which of the variants is being used and hence
> which voltage range is required.
