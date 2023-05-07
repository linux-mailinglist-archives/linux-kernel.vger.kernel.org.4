Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E46F979C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 10:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjEGIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 04:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjEGIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 04:20:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2134.outbound.protection.outlook.com [40.107.237.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34840100D9;
        Sun,  7 May 2023 01:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+6ixeMHyxF1i1y1x9f6OFneuxIwSG+kXenDLQe1DWBwCgcScrSbjzFhdmo2J8tiHLknZwdP9wkGTCchQLLM2hT+BTBHzQa9nayxUXxHijr4cPVVZlxavYleIwwAT1GBH65SYUwglMDb2S14QqKwzxSwDEjkONkeTlKmlKtntEK6XvgnXNNL/c4jvnevEwiKA/kC39Q8BQlJTO1N5FSdjEFTsSQ2z2ZEcVQwaUEcKnUCmnhUFs4Fwnx0uYxRa9qr0qf7Isu8UYL9qmaSx5NJILVKOPcP4EEIh8AW+P12l8Wkl+klj0q/5ENlXmbFaRUav9RMGyu2SjIsOfk+ATjeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKwJ1T5NBb9/I9vYhBOWMxJxyWy5ruSRsa7xIgVpBhc=;
 b=Z8XS+PP4+aWY9q81jYb9C8dcUYWTwwiWxOcBrAgFIYqO2CDfPacdHINh9lE3bsflG7kgOuCbymUO+yzY4gmqx0dINAG7cccuII3SGvcNs4iPyIRlwTU2/pmB+wI3kxEpdBu/IbIYGEJeZHPxiBT+TYV+tEp2+2rDU7irgsbJtc9bKQEzfUb+VJZvvgrH9BwJF7KWob2j+GoO3FDHe/HfC3HlzjgMTqOp6FjsrxQHUhjWUkCjzenDJjuc0hAte1rLSY8E5sl45PYxTWdqYCXSwGccty1sp2EUuqZjxMyn8v41r/DlY19CaQFmXEI+/B8tYpxhp0O2pwRIe6U9DTvPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKwJ1T5NBb9/I9vYhBOWMxJxyWy5ruSRsa7xIgVpBhc=;
 b=0bbaBuByc3dPv47C1eVPaco3mJLA4XoOPXS0/IyVXW4Mgu/uLMPNxOLxk4lSkhnxMbBpw+tPoujStIkPkleKHFAVNWWTfEvk1cfQMZJRZGgGYwCmzMxY48Pl/Ul2vyHr727rsjancQMUpEY4okuOz9F/Vaoly503dP+i54hjfBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SN6PR01MB4973.prod.exchangelabs.com (2603:10b6:805:c4::13) by
 DM6PR01MB4121.prod.exchangelabs.com (2603:10b6:5:28::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.29; Sun, 7 May 2023 08:20:30 +0000
Received: from SN6PR01MB4973.prod.exchangelabs.com
 ([fe80::9caa:9d8e:688e:9e1d]) by SN6PR01MB4973.prod.exchangelabs.com
 ([fe80::9caa:9d8e:688e:9e1d%6]) with mapi id 15.20.6363.031; Sun, 7 May 2023
 08:20:30 +0000
Message-ID: <5d1cc7d5-2d73-c1a2-f95d-5810757640d2@amperemail.onmicrosoft.com>
Date:   Sun, 7 May 2023 15:20:20 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 2/4] ARM: dts: aspeed: mtmitchell: Add I2C Fan
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230425065715.21871-1-chanh@os.amperecomputing.com>
 <20230425065715.21871-3-chanh@os.amperecomputing.com>
 <7ee3eec8-b5b4-2591-adcd-1831bf7de02b@linaro.org>
Content-Language: en-US
From:   Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
In-Reply-To: <7ee3eec8-b5b4-2591-adcd-1831bf7de02b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::33)
 To SN6PR01MB4973.prod.exchangelabs.com (2603:10b6:805:c4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4973:EE_|DM6PR01MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d8a78a-f4e8-4552-288b-08db4ed3eb54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fT6lrCUeEYfm0pSlQd+eVXLjTKktZARJmLfiMUVSpZ76bu8ysdftm09WeUHqt8KfkpxiFCQbzmWkGTUktCwd/9L1Tka7UnjqogTHMRzIw5AUazVmJzni1zQ6frdisy9diFzN8hAGG5dSjbvruLLGwfzxNQy/BdW1bFC6xKDmWVcL8cR9vO1+fXP9qnhz3sqnHgzQA4ZUDavRRm+34dlkbsbmks8RI7bm+5/Zcd3GiIaeh1CUSuLfzIRSu6vjJcwisRWzrWXCw9YcNArpbPGdq6d5uhVZ0Swi3sVbcukf2y45Fu4mH7OS7Cm3fU01K53uob0LTDhypWb6MkfF3B+4TY3QXKbTafrv6Vx56hMiyjbgIXzr9w9laJn0zXQvT6AXJimScReUKX9A7+1QMCFGw/PkXpnNrZPnxKXO/vOUVIN9o3W90hgX3pf2BBUibXyhbajtOULKw5hzGH8c+/0KCTXDMmLTCsStAYl6k0QOyBYGIfgUCFPp/ciHcwJQzdBF2kjCKHPFNC+Yder8996JgNm6UIenbGZCth1LjbRkXkR1QM+LtGNQtgZN0jgA19U/W7Iam1NXzKbfJViymzRTkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4973.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39850400004)(346002)(396003)(451199021)(966005)(6666004)(6486002)(42882007)(2616005)(921005)(38100700002)(31696002)(83170400001)(186003)(26005)(53546011)(6512007)(83380400001)(6506007)(66476007)(66946007)(66556008)(2906002)(110136005)(31686004)(41300700001)(5660300002)(7416002)(8676002)(8936002)(478600001)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUdyUXRaUHZTdDRYRFFadkx4OEY1eUpyS0ErNk5tUEQwWUpzdDR2b2UzdjYx?=
 =?utf-8?B?TzRLMmFoM3F0RHREdHhpaUpTVmZYOUZ4ZTgvWFRycDNnbWljOTBhVHl4eUU3?=
 =?utf-8?B?SWg1bHhxRnYzblVNZkpSK04yTCtFS2g0NFNDTDdlSWtqMWQrZW5wb3FBQmgz?=
 =?utf-8?B?WmM5L3QyWUNyOWI5RU1LQitYUzQzZ1lCU3N4bzBGSDJOZTdVVnRmT1d6aU1Y?=
 =?utf-8?B?Z2MwSUtFYnhndnV6amhuWjd6VWR2YWVNN0pNRHpQQ2FXQ2h6Mmg3K0Z6anpF?=
 =?utf-8?B?bVJzMGo2UGI2cy8yUGlJQmUrek9CRnZ0ZDJZZC9iVzllM1YvVHg3d0licERn?=
 =?utf-8?B?akNTQTVRM1YwbWloUEd4a3VlUDA3N2VPcWJnUUFVbUhRK2hJeUp1VzFOVUxS?=
 =?utf-8?B?bmF5YVZ4c1pPcDhOUkEzNHVtb0drbUU5MmRoTlpwMmFWZmVwY2M5YUU3R2hn?=
 =?utf-8?B?NlhpMmRTeTJscDdyaVZKOVczdWdGbmpIV3MrVXYrR2FlSExSRGtWVXBoOVho?=
 =?utf-8?B?bS9KRktvL3dwZXlqS3FpK2FCaWN2Z3E1RmxUb09kYUFoQ0tNdEVEZEpra21D?=
 =?utf-8?B?TllxbUZDYnp3bmpvRTRmT2swY3h3eGs3K2VFMlN1OUZNZmwrL0xqb1NRVXhP?=
 =?utf-8?B?TGw5YVRFZ2FuYjF1S0xpazBtZUFRL1o4MVBub1ROaXo1cHNaeXRpUm05Z0hi?=
 =?utf-8?B?MFZZcGFDbG42bkpqWXBwSW03RFJPSm9aaEI3ZmxicGhMQi9BVnRhVXBEQkw4?=
 =?utf-8?B?WjhaR0sxR0hMb0wveWRPeDJwSzlaS2pzREYzcEFTVmdqQ3h4OUkvSTQwQ0ow?=
 =?utf-8?B?cVdMRHZqVCtWeXlzbkw2ZHdCYSt1UHdNb3dsY3B6NHJ2WitjRjIrTzhXeTNa?=
 =?utf-8?B?OWhaY0p2eGJqTDNFS2xUY0RjeTMySXIxMnplZHREWWszeEpRVkxyZnp1SW9L?=
 =?utf-8?B?UXdBMGZacVJZWGpHNFBXVTl2SU1WRC9tVVE2dUcvZUJrRFBMNWNVd0grbmZJ?=
 =?utf-8?B?bXJRZE53blhLYllUOUpwU1BHMlJGaFRXR2s4K1FHMjZyWTJCZlE5N1ZjMFh1?=
 =?utf-8?B?Z0dNbGZzWDNzMldvcVcwNXI4S3FhNFBUZUI5RlVpZ1ptbjlUSnJueTdiaHdP?=
 =?utf-8?B?ZUgzRG80NkR3TzIrTWJMRkhRWmJFcVZoNmpPTjZrclNIYVljMTUxZVExbG05?=
 =?utf-8?B?a0I5MFF4OGR5NEFnUXgrOGVMM21CbGNGOHJ2c3Ava3B4K2x5Mi9iYjV4VHR6?=
 =?utf-8?B?RFFlR1NRemRKOGhtWWpDMEQvcFp5V3RGenJncHhmSTNnakJDMXcwODV6akxJ?=
 =?utf-8?B?Z0s3bFkxazdOR1l4cFROWlcwVHJoMTdiRFBvY0NpY0Nhd2xEQjNVa2xRVGxn?=
 =?utf-8?B?aXQya0UxczlzVmRrcmh1RTJoMEFFK3h5NDFZZ1djVVh0ZHNEQmtCWElZVS8r?=
 =?utf-8?B?L3JkbUlHd0xNekhRWFVBUEF4SC9SS3kxMHFjaDNOQ1g3ZXkraWh2RDFyUGtO?=
 =?utf-8?B?OHpsdGNqaXlOOHJZdisrOVpxa0hUcExoZUorQ3U5dWdLYnM3ZDIyaW1ocmwx?=
 =?utf-8?B?dHlEVk1rdVgzNHgwWm9veElGdVY1a1FHUER2b2JSMWE4NEh5cExVTUo4aUxw?=
 =?utf-8?B?dTVtc01QaitGS0paMzEwYjk3OS9QK254ZXU5SVRCZVJCQ2dxUVpsRktWTEl4?=
 =?utf-8?B?bW01ZmhDcVNoVHJ3cmt0aTlnUXV0aDZxazhXUmx2WUdRbHFvTGs1L01FNUZt?=
 =?utf-8?B?N1YwNm84WWs0WTZ6a1B0MVJIU1Y3dk1SVjh0N3VxRCsvTVI1THJuQTZaTXRD?=
 =?utf-8?B?OGNZM2wrV0pwZm9LVmZDYU9LTXpOYko5MTRFbmVhYUZ5dVRralBYSjVrNkhJ?=
 =?utf-8?B?c3RpeUEvWlBPOGpubkl1TmNQM3JmckNMQ01VZmdqcFdsdHc1Smx5WU85UDc5?=
 =?utf-8?B?NmxGOW9tUjRtcGhlcGhsOG5IVkNTUzM2dmhXSnhidW9aQ21nQnNwRWg1NEFN?=
 =?utf-8?B?MG9DdW0ybWJic2RrZVNoVEZPaWZ1WEhSc1VMTUZab2RwOWFHclRVSkkraTRl?=
 =?utf-8?B?WUlkUDF6ZWVBd2FBT21yanA3OWNJZzBPUS9EWWpXY0pXRkhZQkc3WGxyTWVF?=
 =?utf-8?B?ZmpOcDAzSEFJWXRjcWxTQnZYckJWNmk5Z2JBRVdRQzdGUWF4bW1aSW8yZktl?=
 =?utf-8?Q?/m1VSzmC9aJ1mFI2evx3bvU=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d8a78a-f4e8-4552-288b-08db4ed3eb54
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4973.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2023 08:20:29.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JH5gS6dzE+rigWwzF5EvKiq+2J51thyw50kLNFCi6rw2hmh8GCn0kDT91k5coeM4mKSL6wQIz/NLTfyo0TW10MEwpOdD8OBUtbPd/+Rx4m4k1xVdqi+YBkjv/gP5GIX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4121
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/04/2023 20:15, Krzysztof Kozlowski wrote:
> On 25/04/2023 08:57, Chanh Nguyen wrote:
>> Add the MAX31790 node as a Fan I2C controller. It controls the
>> TACH and PWM for Fan Mt.Mitchell system.
>>
>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>> ---
>>   arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>> index e79f56208b89..6455cf80da0e 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>> @@ -477,6 +477,18 @@
>>   			line-name = "bmc-ocp0-en-n";
>>   		};
>>   	};
>> +
>> +	max31790@20 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Thank Krzysztof,

I think these node names should be "fan-i2c-0" and "fan-i2c-1". Do you 
have any other idea ?

> 
>> +		compatible = "maxim,max31790";
> 
> Unfortunately the compatible is undocumented.
> 
> Please run scripts/checkpatch.pl and fix reported warnings.
> 
> Best regards,
> Krzysztof
> 

Yes Krzysztof,

This compatible has not yes documented.

Should I push a document for max31790 to 
./Documentation/devicetree/bindings/ or ask to maintainer (Guenter Roeck 
<linux@roeck-us.net> or Jean Delvare <jdelvare@suse.com>) ?

Best regards,
Chanh Ng
