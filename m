Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4F64B959
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbiLMQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiLMQNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:13:36 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202A1A22A;
        Tue, 13 Dec 2022 08:13:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9FHFjFxnMH3jEOsHNsQHXid1jIljqDjKeJaeTgGIxHJkwYpxu6DQJz5PTozzkyp3gRLvRM1pD7hUYP8jy9YOqBmJU3jxBC3bTzvn5r4fRVewt/OVnsV2RWbzLscOGNyJznzfdjF1bMQj4EIhwmYKdHxm2NyFt2sgkoL+58Sh2cOEw9y8434e8W9Jy2/W7hOXiNFe23O+80r5XQMlgj4QF3rAngp+aFjZYPE/5b6ltoidfnn1PZ1nNdOHsu72sO/n90ZX9sQctrXubxOSpW8Lw+NnpqZko3CaQPUZoeKdBxeNjmmLNSp/+O0fGnCV1nCktCuPn2dmKLVr4ZO+QwLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/WrvlPaKDQSoCRdtTfxB7QsHgIgINWsF+vdYQX9OwE=;
 b=cN6pOEhIPvx1AzJf9ekNmXYCC+FymZqn1OuRfmYS3T6q8Tv2NQx+pPYmRqw/kEnWaUF/a/nrut/uIPWuWJ0uNTJs4dDVH7+ZZ/8Pi3KF2HyvUp3q2cfebRNfQS0iy8uwov+kwl0QMruxz6mThOjjFESnqF44hXkTiDMI8tBLZoVZGOGiKuw2dC0Ynp9L/7D9RXzM4oLaiZf3VD1ZPi5z+97BpjFm9v5CKr13C+1bPu/OvTIQOkC1I7wJ11qa7eicxLVsFFCZy4Wv2B+x7XZwtBvsvbvjaAIhqtJ+E0DLp5y21keJGcf7diVklKG4tOUKjaYWCjx/EG9szELZ3X3OUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/WrvlPaKDQSoCRdtTfxB7QsHgIgINWsF+vdYQX9OwE=;
 b=sDTYVuO38po2Ebnr6DyMdWJLbYmHLt6h3tNSKbjRSCzqjGx++pWKCgDZ5j5Scdm2TLEbT/j5dTmUsOhd0q3CZmhkX7DyXfNfMs3aXjf4iXHysi0MuZXaxRs0kNPXSR9nxHOH/ZBkoARddR4rBdeISQ6QEIpQdl9b3/xsXLEfTr8Y+dM/9Qd6X5XG6F4s8YvXLUcegIVCmiBDvZOPt+zdKnIF4ROxwowosNR5ZX+3t2vF0sx2k1FduFh9wRwcs7inX+bix7zH4rudy1bSNELbZkIw6/8O4OI4XiMHQnMnAFhnyaDj3QDq7gLsYotfK6WQZKoNXM3prQ3TuK7oJIz7tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB9421.eurprd03.prod.outlook.com (2603:10a6:10:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Tue, 13 Dec
 2022 16:13:31 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 16:13:31 +0000
Message-ID: <6942cc51-b35d-8a2f-f20a-7e903ea36ea1@seco.com>
Date:   Tue, 13 Dec 2022 11:13:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] rtc: abx80x: Add nvmem support
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221205151918.1264917-1-sean.anderson@seco.com>
 <Y5iXu9pZjWiumfcx@mail.local> <810fbc48-449f-dfc1-432d-f2a183b1e155@seco.com>
 <Y5idbL4ZkASFp4kk@mail.local>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <Y5idbL4ZkASFp4kk@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:208:134::27) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DU0PR03MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: b733b77e-2c42-4949-2801-08dadd24f945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNBVM9qrW5aJvLGYHnwu7XzSngoYQ8rJ6xXs+48EiilNmM6TN3XQDBamYc41B03o0/ufkMYbywJ1yQL5mRjmUd4zUkBOwy6CliHHU4RxIwTYi494MYHNWT7iVA+jOWCuX6tPWDa1YmH6c0rj+UuSKm5bXjBc1D4DE7Q/YFCeyWKSU4lnq71a1zXLBbXsRirbHnvg+Y83rn7VF+lk8bRh6qIjYHiwQzq1Jwy5QFnhrtV+tjR4i/lz3y5I0MrCL00/xPpOD8ZfqDArSTZGa8ER+hnzwkAQWq8G+qxkB0hP7B7hfgbPbh4wsGv5lSvT2HqXuUlJ9KWb8BPVkVfy/RyYCdrbz9+BPJvzrc1kYNU3my1MPGysjuyJpHY3t3rU8Csso8PCzHnlzBTuFOmyUKCd288bipPjCwlEjTCOK+UclJ0/rh9XaRJ21GkjJMBCW4yZp2P/lAvtsPsfwO+gRZ+koeYXIsNiK3KXCQozI0f8T85M6xBARTW7DhhllggUMOMSebh3Ut+UHp6cEMRxYuUV2U4+R3i35qVet6F1uyxZtKoRtETVd6ePdHAfBE21xwyVq6augh6965q/6Li6UGi1IQ93dsRmZuA/mkrd+scxVMj9CXhlAE3/9iBl9c3/fdUtJqIAgo4yCn+DiVthpNEoR7cexY62o/QjoHDG0MfBrRUKoC5y7Q4XSngT/yYlngNtofDQPB2GhfXHoepxd3bAEf5SbRYJkZgcaAwYQ+lgLTD+BDF3sqiIhUXOEeIHhbdXeO+k6dJvZSV5LzoDxuaEVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39850400004)(376002)(396003)(366004)(136003)(451199015)(83380400001)(44832011)(2906002)(5660300002)(41300700001)(8936002)(86362001)(31696002)(38350700002)(36756003)(38100700002)(6486002)(53546011)(52116002)(316002)(6916009)(26005)(6512007)(31686004)(6506007)(478600001)(6666004)(4326008)(66476007)(66556008)(186003)(66946007)(2616005)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3VFVGpkNWw2OGxWZGZvSCt5clJUemJKTDEvd2lFY0hKTUROWnZhMk9hNGRy?=
 =?utf-8?B?NGZ6TGlIbEJHU3k1TmNnbU9ub01yMFFreVNPWndiTnIyckpSUXhRSzhSYkFw?=
 =?utf-8?B?UDZ3YnRhMGorR1VaOVM5ZE1RTDNsRy9GM3pBYkhjY2RqQ1IvRHdmMnRqMmZF?=
 =?utf-8?B?NkovZ0VtaUFvUUs1M2dzRmR4c1M0VXpJRlVHQUNjck8zeDA5T3BoTUlCZE0z?=
 =?utf-8?B?RGpUTWxKNktnSUxibkFxN0RFVHByQ0NBM0xKbGUvSEgrZElVVzNLWWRmdXE5?=
 =?utf-8?B?YURuQ0NWMXJ4WTJkZFdRQzA5QjlJdE5tR1NEWCtzOU11VDNEay9lMkNYdDdJ?=
 =?utf-8?B?cXllaHg5SUdrNmpRQ1JnTUIzZUEwVFBiZHM5czN1bG4vdU1wSEk1SWo0aU9n?=
 =?utf-8?B?ckdOWE1vaXQ0UlNabXQ3ZXkzQ3A3M1JDS3hoZkZFNWdOeExIK0d6bm5GaWpx?=
 =?utf-8?B?bGdCeThKK2cwY3RjeVJNVHVLTmdkamI5YjlhWk1BUzVpWjBFUElqeVkzQnRy?=
 =?utf-8?B?OWRHQUV0WXRDTWJONnRXdk9JeHc1eFBTSEpza0dIc1pvSXJYVXA0Y1BwTDFt?=
 =?utf-8?B?dVpFc2pIYzZSdXRKN2pKR3VjaEZVQ0daZ0MzNmFwMXhERGZSQm5zMk5DaDEw?=
 =?utf-8?B?VEVYaFk3ejN2NDNFOTdrYlBNYS9pVmd0Wko4aWpLSFphdW1lTTRsLzc3ajRy?=
 =?utf-8?B?WWQyZlEyNWRZckdEWlNra3MvRVk4bTNienRVWnp5Zit5MGVVTFFFcHF2QkZY?=
 =?utf-8?B?TGNwSnNBN1lDZ296V2hkNGdBblgzUUt4Tyt6NWd1eFlaa09OVGt5MkN0MWMr?=
 =?utf-8?B?VXRkMEZuQk4rNXk2N3dYdURkYmUyN0lPemdXMDFzWHFMbGdwZTIvRVhBSnNq?=
 =?utf-8?B?aTlEeXpUNFlRbGtxMXg2cGhsRURKL1NncXVHOXFqeTFVSUtrK1hpZVJaRlZ2?=
 =?utf-8?B?NUdEVXM5eDlydEJYZ3ArajNiK1AwaDkwZW9GazN4Tjc4SzJSVS9EV3NlaUNx?=
 =?utf-8?B?YXJSd0dXTUs2UnpWRjNBbEVqOW5KU2orZWR5VDVDazhldk01cU0zMkhIV0xt?=
 =?utf-8?B?YzBvMUkxNGVXWUtCWU1jMDNzdnd2WEl5OFlDNGhBOTNBM25jelpCNjVFZjBW?=
 =?utf-8?B?VTUyaC9yVmROZ2xNR0VZcmVXVDRVMDU5UFhFbVdndWhJak5Kb3B0ZXVtb1Z3?=
 =?utf-8?B?QWxLbVpjK2RrdG1NK2JSWERpMFZ0SDRVMG1yWEhvMHpjWUlKOW9VMmc5d3N3?=
 =?utf-8?B?MUcxUndSTERHb290S0FubmpHeEhMV1pIZXpWQXBLbS9XRGhHQXgzWVZGS2la?=
 =?utf-8?B?OTFsbWtDdzk3c1grMTFpTFZMa1lGaE4ycVhVMTJDL3ZhUmg1MUF2TEdIUUdv?=
 =?utf-8?B?TlJBeiswZzJPUmdaVyt4b2tJQkZKSW90cDFpU2kvRnFUcGJUOUxqdlpkTm1p?=
 =?utf-8?B?aUdUaDhiV0VxYXhWclNyZUc0ME5OMUpuTjdlNFNSd2lSdGVDYWU2Y28vWUFw?=
 =?utf-8?B?WEEvbHFicUkrSW1Seis1Y1laR3Q2K0U4L1NFQkFHNmlDRHE5ZlZvamtMSTQv?=
 =?utf-8?B?UDRZNkFoSDJKNjJIdkZDbWdma0ZNTGFhL1VKRE5mb0xmK0h4Q2lXdGQrK1Fy?=
 =?utf-8?B?YTJFYTh4djBzTkJ2d2Zsck1DVmZnb0NYVU5BWTl4WjlCc0RNTnZhRUptb2lC?=
 =?utf-8?B?ci9tRnFiOVZXalZqeDR2Uk9vekI5ZnZva3BhMVhOME9pQnR5WHMwSjFtUUFO?=
 =?utf-8?B?WnZ1dks1SDFoNnczWnR1bEsrZUZpSk91ZDhadGRrbE51S0l0MU13bnN3dmwz?=
 =?utf-8?B?YmJyeVA5OGRUUmZzZmpwNEF5R1lqVmtSNTNmcnk1cGtlcnFFNmtGL0ZUalNj?=
 =?utf-8?B?WElFNm1idFk0d3FqQUw0R1JpTEtzTUxqdzFrY3M1VVVQck5NWDJFd3FUL3NI?=
 =?utf-8?B?akxuZXBGVnVMSXpzRjVUazdabXY2SFM3aENiT0NsMTdndENDdm1XeFhiaGxR?=
 =?utf-8?B?MnorZjBkR1U5VDArWUhxcmpmbXNKWmtxejJhZ3hZbFQwYUhHMWUrYjZ5NGVa?=
 =?utf-8?B?TEFpUWp5NjVxYk5ZcXV4TjU5OFNhcDFYS2gzUnhreE1lSFhxVVNNVk4vcllx?=
 =?utf-8?B?UDZ4WlBQTjN2TE8xZXhwWFRsamdzMlVVRDdxZVR3YjRZYzFudkEzbkY2MnFn?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b733b77e-2c42-4949-2801-08dadd24f945
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 16:13:31.3671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tasvElHMZXDxaQHX/MGc5Vir8sz77N/qKFLzssAGu6JMbN+KYdus6Y2bRSB+xEnZbLaOAo/vHe+7SGWsDLeV1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 10:42, Alexandre Belloni wrote:
> On 13/12/2022 10:22:25-0500, Sean Anderson wrote:
>> On 12/13/22 10:18, Alexandre Belloni wrote:
>> > On 05/12/2022 10:19:18-0500, Sean Anderson wrote:
>> >> This adds support for the 256-byte internal RAM. There are two windows
>> >> which can be used to access this RAM: 64 bytes at 0x40 (the "standard"
>> >> address space) and 128 bytes at 0x80 (the "alternate" address space). We
>> >> use the standard address space because it is also accessible over SPI
>> >> (if such a port is ever done). We are limited to 32-byte reads for SMBus
>> >> compatibility, so there's no advantage to using the alternate address
>> >> space.
>> >> 
>> >> There are some reserved bits in the EXTRAM register, and the datasheet
>> >> doesn't say what to do with them. I've opted to skip a read/modify/write
>> >> and just write the whole thing. If this driver is ever converted to
>> >> regmap, this would be a good place to use regmap_update_bits.
>> >> 
>> >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> >> ---
>> >> 
>> >> Changes in v2:
>> >> - Fix building on non-arm platforms
>> >> 
>> >>  drivers/rtc/rtc-abx80x.c | 87 ++++++++++++++++++++++++++++++++++++++++
>> >>  1 file changed, 87 insertions(+)
>> >> 
>> >> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
>> >> index 9b0138d07232..e606bf126dc3 100644
>> >> --- a/drivers/rtc/rtc-abx80x.c
>> >> +++ b/drivers/rtc/rtc-abx80x.c
>> >> @@ -11,6 +11,7 @@
>> >>   */
>> >>  
>> >>  #include <linux/bcd.h>
>> >> +#include <linux/bitfield.h>
>> >>  #include <linux/i2c.h>
>> >>  #include <linux/module.h>
>> >>  #include <linux/of_device.h>
>> >> @@ -87,6 +88,16 @@
>> >>  #define ABX8XX_TRICKLE_STANDARD_DIODE	0x8
>> >>  #define ABX8XX_TRICKLE_SCHOTTKY_DIODE	0x4
>> >>  
>> >> +#define ABX8XX_REG_EXTRAM	0x3f
>> >> +#define ABX8XX_EXTRAM_XADS	GENMASK(1, 0)
>> >> +
>> >> +#define ABX8XX_SRAM_BASE	0x40
>> >> +#define ABX8XX_SRAM_WIN_SIZE	0x40
>> >> +#define ABX8XX_RAM_SIZE		256
>> >> +
>> >> +#define NVMEM_ADDR_LOWER	GENMASK(5, 0)
>> >> +#define NVMEM_ADDR_UPPER	GENMASK(7, 6)
>> >> +
>> >>  static u8 trickle_resistors[] = {0, 3, 6, 11};
>> >>  
>> >>  enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
>> >> @@ -673,6 +684,78 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
>> >>  }
>> >>  #endif
>> >>  
>> >> +#ifdef CONFIG_NVMEM
>> >> +static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
>> >> +			     void *val, size_t bytes, bool write)
>> >> +{
>> >> +	int ret;
>> >> +
>> >> +	while (bytes) {
>> >> +		u8 extram, reg, len, lower, upper;
>> >> +
>> >> +		lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
>> >> +		upper = FIELD_GET(NVMEM_ADDR_UPPER, offset);
>> >> +		extram = FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
>> >> +		reg = ABX8XX_SRAM_BASE + lower;
>> >> +		len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
>> >> +		len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
>> >> +
>> >> +		ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
>> >> +						extram);
>> >> +		if (ret)
>> >> +			return ret;
>> >> +
>> >> +		if (write)
>> >> +			ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
>> >> +							     len, val);
>> >> +		else
>> >> +			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
>> >> +							    len, val);
>> >> +		if (ret)
>> >> +			return ret;
>> >> +
>> >> +		offset += len;
>> >> +		val += len;
>> >> +		bytes -= len;
>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int abx80x_nvmem_read(void *priv, unsigned int offset, void *val,
>> >> +			     size_t bytes)
>> >> +{
>> >> +	return abx80x_nvmem_xfer(priv, offset, val, bytes, false);
>> >> +}
>> >> +
>> >> +static int abx80x_nvmem_write(void *priv, unsigned int offset, void *val,
>> >> +			      size_t bytes)
>> >> +{
>> >> +	return abx80x_nvmem_xfer(priv, offset, val, bytes, true);
>> >> +}
>> >> +
>> >> +static int abx80x_setup_nvmem(struct abx80x_priv *priv)
>> >> +{
>> >> +	struct device *dev = &priv->client->dev;
>> >> +	struct nvmem_config config = {
>> >> +		.dev = dev,
>> >> +		.type = NVMEM_TYPE_BATTERY_BACKED,
>> >> +		.reg_read = abx80x_nvmem_read,
>> >> +		.reg_write = abx80x_nvmem_write,
>> >> +		.size = ABX8XX_RAM_SIZE,
>> >> +		.priv = priv,
>> >> +	};
>> >> +
>> >> +	return PTR_ERR_OR_ZERO(devm_nvmem_register(&priv->client->dev,
>> >> +						   &config));
>> > 
>> > Is there any reason why you are not using devm_rtc_nvmem_register ?
>> > 
>> > 
>> 
>> I didn't know it existed. To be honest, it doesn't seem to be doing much.
> 
> It properly sets the owner which is going to save you from race
> conditions and headaches.

nvmem_register has

	nvmem->owner = config->owner;
	if (!nvmem->owner && config->dev->driver)
		nvmem->owner = config->dev->driver->owner;

which is going to get set to THIS_MODULE because we set dev. This is the
same thing that rtc->owner gets set to, so there's no difference.

> It also removes the need for the ifdefery.

This is just following the style of the watchdog code, which is
similarly ifdef'd out.

--Sean

>> With that changed, is the rest of the patch OK?
>> 
> 
>  find the use of FIELD_* a bit too much but this is fine, yes.
> 
