Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C350C64B850
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiLMPWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiLMPWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:22:40 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE7B96;
        Tue, 13 Dec 2022 07:22:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0sPbREXwcED5RJWN4CDxOy9V9pilTAA/qa65Im534XySRkfN5cjCzlxEYuVwYOATJKM5/OpWMiPq7tUpGW+W6BhLgdwreOYikzbl9mOHmbQN+RZ+HraGLGe5oK2SgS6MK2fyU7vVqJb5yBwBfZRnsUNdewQfKNgKVChoUxkvPAxhmqwJJdk5afGpGc6RhulIe+YdEu/6hGVWAJ9xD+HrDVb/pTqPpz74KxipKPvbZqHwD96sQKus9QadGWH64PFZ/pu0ShK3/VAMYSmMxBj0OEnacLuLBSTbTYAZ25OdlTDUcWrwXjGtmsAxuCaS3BfKbKp753imyVx+Yde/lQ41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzTjlbyFXL79PKrnRt2h0na2ajJsWQOBKKV3sPoPSUI=;
 b=VfYufgF/TmmUMacfbfCZAM48IK92MtJpmhEpYv1xkIK64w1M2cBW5c/VzAiy6ZQUSy3v7bHQQgX6hnFbI5MZHVbNEe5tN/IaCa8NI2ABfUhehYAXPXxAL/k2dvmt1Gj9Yly1DKGSqEa9A2/49f1nbbyDRKdRrVVTIt1N4i0at2V/8FuNLT2Vq8J7q82cI1wlq+MUS9MoxBVyGXMI1mr4nIry3sDP5MqRQeyxoBqydrxr+/lkmdhDcFrG4FYCYn7wea5HCkBA9Auqjoagh5TDxbi6pI+USSf3mdFrAai9XqCjDW7zW2C7X+CIN7GLmqCnt0JI66s7pxA+zUoVnzDfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzTjlbyFXL79PKrnRt2h0na2ajJsWQOBKKV3sPoPSUI=;
 b=gXE71HCqsyZilOSl3MthDJnc9np9ox0d8buMEWOd7nJqcoGGwQJFbcuyBaRBy9hEsqkxcpIFnxU3eBs6zlzeuXjewd6BLhaF1ByZ7D2j8MmydjNHw8sPYEkcJcG6zM286kHpErfGXhvcttatPjdLVoxlIqjViJArRepwn/pPXwU8Npv4vK/VY+zTUSPSh6wIOEfgQqSA7BfzHWbBy1eDZP3HMxy6zIJ453PAtAKmNW5+sDQsXBYdjA6l5pS912BwRgveHSivc8zXxkLftN3hhDeXfX1IHYIkR5093d+omSeJiqQyQTRLYUmeLc9G0Nnh8NiXsmx/FwzcCYHV770cgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB9711.eurprd03.prod.outlook.com (2603:10a6:10:453::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 13 Dec
 2022 15:22:34 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 15:22:34 +0000
Message-ID: <810fbc48-449f-dfc1-432d-f2a183b1e155@seco.com>
Date:   Tue, 13 Dec 2022 10:22:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] rtc: abx80x: Add nvmem support
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221205151918.1264917-1-sean.anderson@seco.com>
 <Y5iXu9pZjWiumfcx@mail.local>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <Y5iXu9pZjWiumfcx@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB9PR03MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d87e3a-578c-4676-6ce7-08dadd1ddb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dubyV4t0NaichRrK6PV3e3ENF5fjLSYLE8tsxOxnHeMKUGI+CT9zPkVldWKGi4rt1/k0ZkN+fUzLM4PtxK/ho46zm2A1cpdkP/TuJ23kiRIuxbbxk28WkGDGcojDvpoRwzCRkng22HsLeKWR2bTk5DxhnlHA46kx3qvOENOG62Cten1FB7sBmz33dtHy9oFSoIJ0uLPFAAT30u/wmYBrclOXe6cY/k+gDizaQ+xqRpRLku4Cg/xJs3WdcRL9Dx46pN1wUJGR1aJGQb1YYeXfkyrT34e/4IpVF4KHFwHS483gyHdbaqOAgc328njjDaqF0fBhVv//B0ncAW6EkDrRpSrbCFvITSA9hwY7do5VcgTwCOj4r+zxCRL3yvlzKQ8NFZtEPUqSgAM8bnyENa+k86bb4IMpusQQf3IUZ+kx6qCROwQ64n0r33StSRzMXEDo1MJ/xjuzvKG1hPDSfB6trGUdVOHYtjageIcD/Cw5lKR4PeXLM/JUn5vmRKGD+gJdUYUukEEe3sXzoJB8A0tNT7oliqyHmaFT4pcMoXvyahTVwnSbNLUtT13E3JpKD1b72PeZnDDuHbyArYf6D2pxeCJntGh+0+M/lKNX5Qrxailc21D+Yqn2CbBkJZNVNM4ZLA3xS81KRZphy1mB80QHsaIWCrEtbl7nWtfnff9+XPCQj+PfH5wj9nhJfhNlnIaPzg3HEYkS3/VM1lZ7JchnC2t5BqoW95/AV9ncsW2vhEESvRYRkp0AY0cyHcDASzrE8ltc7zvRENu5AVb0qqMdwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39850400004)(346002)(136003)(376002)(451199015)(38100700002)(86362001)(38350700002)(316002)(31696002)(8676002)(4326008)(6916009)(66946007)(478600001)(5660300002)(8936002)(41300700001)(2906002)(44832011)(66476007)(2616005)(52116002)(6512007)(6486002)(6506007)(26005)(53546011)(186003)(66556008)(83380400001)(6666004)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TklsakYrR0lsSlN1c1RNZmp2M3VVQUhkRktRNXprUDdFV1dXS3krOFd4bHd3?=
 =?utf-8?B?aWZiL0FHam8wWk1icFJnVURabVRXTTc2NmQrNWFhRXR4aXhpTnBLT0pwdUJl?=
 =?utf-8?B?QmVSZHZuVzBpaVY1OTErR2tKelVWblV5Q2ZGZUg1SmxieUZ6NmJIVWtYQ0hL?=
 =?utf-8?B?emtIeUFiN0xkS3hTMUtrQUNVQ0RDVXIwcnQwaWJsTDJCMk1sejU3SmFBdi93?=
 =?utf-8?B?UUpZM05INFpPL0dCQTA3ZWx1U1ViU2NHa0JTbnozbmR6R3N2YkJ5QUtXK2xh?=
 =?utf-8?B?aFhvSUtFWGxzcFNXRUxtdGNwVm9VOU4wUENqVnU1dTBQV3NYdlduOHBEN2Zr?=
 =?utf-8?B?Z3ZGY0VxUzlqRVRJcCtIWWl2elJscjBGY05Zc0NxTC9PNGNSS09FT1RnWXI2?=
 =?utf-8?B?WGRFc1hSd3I0Vnh0emg3MkdWaWIzZlE5M254VW00dlVzaENDYXNscFdaaW44?=
 =?utf-8?B?azhqdkN5QUtTZjArTllDd09zVlp2alYvUURUamE2RCtPeTVVaElNajErOWh1?=
 =?utf-8?B?TEtEWSt5aGk5eUs1T2lFcklsTGxTRml1R0dyVnNsNTByeFJnQUZJUlRhTEVa?=
 =?utf-8?B?UEc5WE1BTGxKaENzMDhidXVhcG83emc3MjBycm1EMXpDb0x5eWlkLzlVd2lr?=
 =?utf-8?B?QVQ3TGRzbllKZ0pRUzY2eSthSFMxWjl6WGhNeW5vN2c2VHpIU2ErdU1xMngx?=
 =?utf-8?B?TmRLVHM5MHRJS3g4dlZwOXJMWUJwcEk3MWFiM1l1UXhoeC85RjJSMGM4dE84?=
 =?utf-8?B?UjRjYmFuQmkwSVgwNUpLdWFaZHcvZHZuZDBxTlR5RENadEhweHZuYnZmRGZp?=
 =?utf-8?B?ZzNXUU5ZOTdJL0FEQVBibEJtNzE1VGV1RllIOHJCcVhvRENHK1lUNGNxcXkx?=
 =?utf-8?B?Ukg3ZTQvUHkxSzlDTm4rSk8vbldONzFBVnV1cVhPN2ZaK29DLzg0ODVMbW5r?=
 =?utf-8?B?eWhGMjZXYkkvQ3hkOWpmTHh4SXk0Y0tZRXZvSDJRU3R1NHd0bWdtMjd4aGw2?=
 =?utf-8?B?aFVtMnpVS0Q1MUs3WlIvVE1XWE94a2pKSlgvbld0Y0FPZ3ZvRWFsRXhVTC9M?=
 =?utf-8?B?Y1dqN3FGMzRtMjVoeTd6WWdkcHowcnBNZDViVmtLclFxai9FWmVKNXBDak9x?=
 =?utf-8?B?eUY5YmtzN1R2ZUg3dEJielh3OGZXVGIweXlFOVRzN0o2SmJwb0ZtSmx1UzlX?=
 =?utf-8?B?emlFaE5FQkxHb0czSEh6a3BGUGE1aVpoOVhUbWN4YVNSdFV6R2JOcUlpYVlY?=
 =?utf-8?B?UEJCKzh2WVhudTlXMFFwdGJoRHBzN2NpY0JBaXVzSUh5WjlINjVaaHMreWRQ?=
 =?utf-8?B?Zy9iMUxBV3J0SG5Wc1BiUE14UWVXd1RmcGFzUFhRZThXaWY0eXlacHpkaHVX?=
 =?utf-8?B?RW1zUDI2WmxqTWYvelJsWnc5bWY2MW40bEo1TWpjaGVXOEhmN1ZHZ1VNdDZ5?=
 =?utf-8?B?bS9QZFFEZmhRQTB0ZUVlUUVqdzd0dExERWJEbmRPOStWKzVIamlENUs2aXY5?=
 =?utf-8?B?Znl6VVZIa2ltZ080MHRNNjBtZzFUNVNYdnpldEVSMVZkcUVxcVg3ZnB2K2xM?=
 =?utf-8?B?dHpWRDcxK0YxaE43a1czTXdCNGEzWVlZOEc1NStQY0JtOTBuSDlIcU5Vc2Zs?=
 =?utf-8?B?ZXZqYTRPUUVQR2dTa004aTkrUmNxU2F2VlRrM013bHNZeEgveStka2dOckRj?=
 =?utf-8?B?WHY3UlhwZFJidGs5cGlDYXNENS9XVmhzTlQyS3YvN2NSVWdlV2NQZWVSSzUx?=
 =?utf-8?B?TVhBazdnNmpVK0pvcGFUbUR0VVdSQUVRSktneDFHWWZsMk5ncHc2TDBabGdi?=
 =?utf-8?B?VlI4ZFBzdVRTTnBwTjlOeE9xWEdSaU9ibWIyL0FZeTN2SG43eE1Ibm1pVkU0?=
 =?utf-8?B?NXI4Ukg5bVVSYUF2YStTUUQ2cHRzdmlLcGtoU1M4Z3oxKzY4SHN0a0pRcHlY?=
 =?utf-8?B?N0c1dGkxdk9zM25GQnVEZ2wzckZxditSZ2srUHUrVWhWaUwwelpkR3J5QWJU?=
 =?utf-8?B?djZWakdEcFhIVVAvamMyOFZIZlg0M1BSeVN3Z1lELzdLT3NZRGh6OGtvNm40?=
 =?utf-8?B?SVlWQytYd1R6ZHBHeXpPL1FaVG4xSjNJcDVXQnRvZDhwbWZUTWlHUHROdk52?=
 =?utf-8?B?NGs5bFJOcDNDT0I5eVpmYU5RNG0weVM1OW9QR3EyRytLMWU1dTc1MHNqU3E3?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d87e3a-578c-4676-6ce7-08dadd1ddb48
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 15:22:34.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SE9qDbXPgoBt8TWF4d+/32zu98vAe0AoZ+weHM6gb0AN/iR+51icd0wQUbKmH4bhA2L0XaA7xRR1qdpzdtE9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9711
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 10:18, Alexandre Belloni wrote:
> On 05/12/2022 10:19:18-0500, Sean Anderson wrote:
>> This adds support for the 256-byte internal RAM. There are two windows
>> which can be used to access this RAM: 64 bytes at 0x40 (the "standard"
>> address space) and 128 bytes at 0x80 (the "alternate" address space). We
>> use the standard address space because it is also accessible over SPI
>> (if such a port is ever done). We are limited to 32-byte reads for SMBus
>> compatibility, so there's no advantage to using the alternate address
>> space.
>> 
>> There are some reserved bits in the EXTRAM register, and the datasheet
>> doesn't say what to do with them. I've opted to skip a read/modify/write
>> and just write the whole thing. If this driver is ever converted to
>> regmap, this would be a good place to use regmap_update_bits.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>> Changes in v2:
>> - Fix building on non-arm platforms
>> 
>>  drivers/rtc/rtc-abx80x.c | 87 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 87 insertions(+)
>> 
>> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
>> index 9b0138d07232..e606bf126dc3 100644
>> --- a/drivers/rtc/rtc-abx80x.c
>> +++ b/drivers/rtc/rtc-abx80x.c
>> @@ -11,6 +11,7 @@
>>   */
>>  
>>  #include <linux/bcd.h>
>> +#include <linux/bitfield.h>
>>  #include <linux/i2c.h>
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>> @@ -87,6 +88,16 @@
>>  #define ABX8XX_TRICKLE_STANDARD_DIODE	0x8
>>  #define ABX8XX_TRICKLE_SCHOTTKY_DIODE	0x4
>>  
>> +#define ABX8XX_REG_EXTRAM	0x3f
>> +#define ABX8XX_EXTRAM_XADS	GENMASK(1, 0)
>> +
>> +#define ABX8XX_SRAM_BASE	0x40
>> +#define ABX8XX_SRAM_WIN_SIZE	0x40
>> +#define ABX8XX_RAM_SIZE		256
>> +
>> +#define NVMEM_ADDR_LOWER	GENMASK(5, 0)
>> +#define NVMEM_ADDR_UPPER	GENMASK(7, 6)
>> +
>>  static u8 trickle_resistors[] = {0, 3, 6, 11};
>>  
>>  enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
>> @@ -673,6 +684,78 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_NVMEM
>> +static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
>> +			     void *val, size_t bytes, bool write)
>> +{
>> +	int ret;
>> +
>> +	while (bytes) {
>> +		u8 extram, reg, len, lower, upper;
>> +
>> +		lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
>> +		upper = FIELD_GET(NVMEM_ADDR_UPPER, offset);
>> +		extram = FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
>> +		reg = ABX8XX_SRAM_BASE + lower;
>> +		len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
>> +		len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
>> +
>> +		ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
>> +						extram);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (write)
>> +			ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
>> +							     len, val);
>> +		else
>> +			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
>> +							    len, val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		offset += len;
>> +		val += len;
>> +		bytes -= len;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int abx80x_nvmem_read(void *priv, unsigned int offset, void *val,
>> +			     size_t bytes)
>> +{
>> +	return abx80x_nvmem_xfer(priv, offset, val, bytes, false);
>> +}
>> +
>> +static int abx80x_nvmem_write(void *priv, unsigned int offset, void *val,
>> +			      size_t bytes)
>> +{
>> +	return abx80x_nvmem_xfer(priv, offset, val, bytes, true);
>> +}
>> +
>> +static int abx80x_setup_nvmem(struct abx80x_priv *priv)
>> +{
>> +	struct device *dev = &priv->client->dev;
>> +	struct nvmem_config config = {
>> +		.dev = dev,
>> +		.type = NVMEM_TYPE_BATTERY_BACKED,
>> +		.reg_read = abx80x_nvmem_read,
>> +		.reg_write = abx80x_nvmem_write,
>> +		.size = ABX8XX_RAM_SIZE,
>> +		.priv = priv,
>> +	};
>> +
>> +	return PTR_ERR_OR_ZERO(devm_nvmem_register(&priv->client->dev,
>> +						   &config));
> 
> Is there any reason why you are not using devm_rtc_nvmem_register ?
> 
> 

I didn't know it existed. To be honest, it doesn't seem to be doing much.
With that changed, is the rest of the patch OK?

--Sean
