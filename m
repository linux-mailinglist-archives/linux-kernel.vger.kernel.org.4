Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F163E6D2769
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjCaSAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjCaR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:59:58 -0400
Received: from mx0b-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68D32293D;
        Fri, 31 Mar 2023 10:59:38 -0700 (PDT)
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VALJgm014873;
        Fri, 31 Mar 2023 12:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=25/iMZnl4QBnOtdO3Pc/3uR5ONQmT2aRZDAy6ZEg/Yk=;
 b=SlqHADhiZqbC5u+/I3h04EJNADZ0iZMdhOCIyjxoNKjhKXuMlhX5TiA/H+fVw9mW5kGa
 CBubcHtgqjcU29Q+fZiakkLBC9t3PAF5BiXH1IdbBO09gLtreAFkDYhMjmqXci81qHzr
 aXZggspd/+3p8KQSInsOTEGkFLPyYeJvEYKWWsDE88+V139M5EXOAkprn53hsq9bDZcH
 KQveWa+PlbmjNdk03uGlsusbvcitdKwDbPx0DUbuFhn8y8wKHAZRbpN6dsHybxjYXpRD
 LUv+4SIb1HRQJY3UeyzW1bp3F4Rc8WfW/OHkIWuicKiLvH/Q+97R8C9o9meAusTLn+y2 HA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-00010702.pphosted.com (PPS) with ESMTPS id 3phxfvw56d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 12:59:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZHopVAq+Xduty+i219Jq0AHQ00EIzXjoQUuR6NdWWioRacYOUhsYfQkov4PiEZnwzg3GCpmX9Fccn89ZeindfHigQg88E58gtyVxxZNzjKU64sJZa+pV7QTsC4LweaI196UJPRnTJAgmF8WfDxH2VbQy5rhn+wkhULYD4aAmFm8i39uCYSUIXSWKPJjG9P9c/jdqVeRAANvozadq/OyzbNXQNOYMiMLQPeqeP5zQUZMsKVFwYi0UrH90HrTVnX6FqMpMriE/5NTCtDSSDIZ2O0nMP87Fnix/hTBrWjPcbBaxZN8ejv1Gjxdry8fx5q01aJ6PDEEsSJgLy7TvZ8XwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25/iMZnl4QBnOtdO3Pc/3uR5ONQmT2aRZDAy6ZEg/Yk=;
 b=StwH6jZOF65z8BL0GkV3GgNBh9JL9YqUATLubC49EfnPXmeCe4fVkCdRuCM2HB54CS43OMumlClj9co8uXvM9PoXJ4dFWtIcgbcmgF3lbCGx+5jh6srcDX8Rh/335FUfJE47RNCDiK2XrRJyxltYEslwTFHwfVlZAAjZu7X77D9rfF2Y8NKkTJtA9UUH94zdL8/K73wFvke6TxpcqTyTjSfVxmQazQSVzlKMOUiDHZKzAaKCrNWybwuWPwfM0T1/GQGIh815Kmwwl5xFgwb4epGH2d+o6Vkf944+x2/NnMQSXlRyaBH6Vr6Vf0/jEo6I9PcMUX1RHO5vp4ZX/O3FzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25/iMZnl4QBnOtdO3Pc/3uR5ONQmT2aRZDAy6ZEg/Yk=;
 b=rEl4YeuPhnMZdBcltvEYKyKrSLbWwZScgFga0wUawOvl8BpJD6ZfC7NggqBLT0wzzqKMnZXQv89Y9B5DPh+8OsyPZBzgM/NnKrelyQI/5wdePRZ0fTBE6VWCABlifTD8HZlQSY9x4Gz4YACw0HkeTkSLyhlDVGxYG/yO8AoAhH0=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SJ0PR04MB7853.namprd04.prod.outlook.com (2603:10b6:a03:37e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 17:59:27 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00%7]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 17:59:27 +0000
Message-ID: <163ef94e-4a3e-784d-b327-8e05a31c9f93@ni.com>
Date:   Fri, 31 Mar 2023 12:59:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH tty-next 2/2] serial: 8250: add driver for NI UARTs
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230329154235.615349-3-brenda.streiff@ni.com> <ZCRnwDa8kpuz7GwJ@kroah.com>
From:   Brenda Streiff <brenda.streiff@ni.com>
In-Reply-To: <ZCRnwDa8kpuz7GwJ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0036.prod.exchangelabs.com (2603:10b6:805:b6::49)
 To SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|SJ0PR04MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ad92b0-912d-497f-8db0-08db3211ab37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+u667+4jqpwHZMVu0A7xXYNnv+vQib/99BRxPRZ31lmI8HfaBWp4Zp94frXsHZ2D469dO5PmRbIxEbgJsqRHtO7fkk+FSXsKzDwTs1am6Tv6AeFbC38wN3pF49AnGKUc9Iysg5b54MiZuotdZfT3XN+FOPAa4nhxwWzDJQQXwTUh6QOkVcFOyorEQ7ms4y81lcTUYZofCWwaSOpHIcqoY+cuoPeK3tG+9XrUK8MlkCEkGTojFOfRM3YV1R/nMvncdLWsUBmWOdqVzpbIK+XobmMgOL2yaXY/JRtnIs6l1FYdmn6tK0LQfOByjT7EJIJY8hWjuL91OuaY0hL8KOJMdyhBdtk780jUCqKH+Pqnc2qRQ35oOPu3WHqpe+YDRNzK2XlcyFkXoVmAGHOZRYlg/MLnoy7Xx8XpSj/w97OoFrtQhhB2TWRwET690l38oOGzY9Ds2oDPsw0Eg2qmcElz5+2Yqak/er0+hu/cq4BOb5NPRqRmq3/vYmOTZs9wCrpwZrMshE0BiMg7JPzjqrC4XJYTZoqQ7DTHedFZXsfCwzeGgGYtpmE/aGIYelWbeQulYEaG8hevHAYQ4yRDfhaQWdkIjbQQbzsv7KS9rhHTf3zn1/d+UsvSyL/miw3GXrs5m4x3ArwYOQWtySsS9oPUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(186003)(66476007)(4326008)(53546011)(54906003)(26005)(31686004)(66556008)(8676002)(6916009)(6512007)(478600001)(83380400001)(2616005)(5660300002)(6506007)(316002)(44832011)(41300700001)(2906002)(966005)(6486002)(66946007)(38100700002)(8936002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YldiemtEaGRSTlFiSGtZeTVDR21VYXBPOHdwNTVpQlZhUWxQcktXeE5xYjR0?=
 =?utf-8?B?NCtRSEZEUDlPMDlJUHJpZS9wWG4wOGhRZHg0QjA2UFVUUmdNT0h3cjArRFZl?=
 =?utf-8?B?NmFMajlpNGRDdUhIbEVUNS81UzRoeE1ZTDBiZkFLNWNIUW5sRFFVL3JVVmpv?=
 =?utf-8?B?aVJFT0xJUUFNUDlNK0pDZnZRTnE4RGZ0K1RiVFAxcDI4dkxUYnJUSFc2aE93?=
 =?utf-8?B?a01ZSXJwUXN2VGo1azVCcFc2MmhTbGJGaHdra0UxZ1ZJQVNIUG1TVFRZNUN1?=
 =?utf-8?B?dHNVVjFpMkNLcE5xZWE2a1RMa2V0YWRXbTNUWDE3L1duVlphZ1RrMVFNTDNk?=
 =?utf-8?B?cVZaR3NFem10YTJ1OU1LVEVHZlNUZG5TelpIOFo2bXZrK3lmdi9wM0owcFBr?=
 =?utf-8?B?bGIxTXg4TEpjaXpVOXVQM2s5RVJodVV6SVNkeXBwREtTbDAvaVB0MXJPemNs?=
 =?utf-8?B?Nk9QTVNMN2pJV0s5MUZwdjNBUE1tb2lYTXNzbDhiNXd5U21UcWV6WmhERVBJ?=
 =?utf-8?B?SUh1Z0NNYzVRR0krM0JpSGZTalZiYW1FWWRkOEc1UE9FZXpjK3BIQTVOdkZv?=
 =?utf-8?B?WkxEUGU4Vm5OZEJ1R2xPRm9ITmxrdkVlWS95V2h3R2FzYmR3dmtvcUtZcnpM?=
 =?utf-8?B?c3lnMExQOHlPL25RQkN6SStBZElISEY5V090RVByQlNSZzR5NzNidGVLRW96?=
 =?utf-8?B?RFJ2QmdGaEZyZi82MVFhay93eTFlTSs5SlRJc1RBK3pmTzlXdmxxekhKd0Fv?=
 =?utf-8?B?Z0xDTjBFdUJkT3FPN2pJRkdybG9ibkxpQ3FCWXJDWHZSYU9CTm90V28weUgv?=
 =?utf-8?B?UE54WFVBcmtpUEpBZkJKdkZ4aWduajc1ekNSVkZuZGlrZ04zUFQyNDUrUWY0?=
 =?utf-8?B?YjZBSlZ3WGlwQTh1SDFwYWZUeXo4dExDdUVnVHh2c1J1QVNWUW5FakgrSk9M?=
 =?utf-8?B?V2ZNYXplTVhRT0ZlU0cwRzBTWDZJYnM0UElMa01seUJRU1FaOXNaclRISW96?=
 =?utf-8?B?Y2Y0RWZaMXpZcFN4ck1BaEw5VDM0ZXJYN2NmTEg3VW9kWngxTVl1eEIwc0Zs?=
 =?utf-8?B?UzNlYXJyN0J2a0VMdEdLa0owbG1JUWtJWUZUQ0xIb1N6WmQyL3l0enc2d0Ju?=
 =?utf-8?B?YjB6RDZzUWMzc1NXTW5lYmU0NktCUzV0ZTdVYk8wcVdVcHozQnpMZGd3dzR2?=
 =?utf-8?B?RDQyMkZ6UWdkM3lUN2FuTVUyaWlnSlAyTGpSMXJNa3I0ZnE2dmZzd0orQkor?=
 =?utf-8?B?VmZhSG9lTGdVUzVlZU9JTUgvZXV4U0ZzUzRqQkFwYVRMcmkxZHhZQmUycmoy?=
 =?utf-8?B?M1hVUUVqenN1ekJ6MktjVnlKNkw1UHdrV3hKTURPdFp5S1BFbU8wSG84eS9X?=
 =?utf-8?B?WVlKVEhBckswcncxWUxkU0dGcWVucTNyK01IWTBxUC8yd3ovbFhhNTJMSFZZ?=
 =?utf-8?B?TXJycHlpRHpNRFRtUFdzZk9mcUUzeFp2R3JqQ1Jubk90eFVvNndsMHFocmhZ?=
 =?utf-8?B?UTJvb1dkUGxrV2RKQzN3eFRkRWRVTUwxaXAyZjE5eDNwYTU2YmVHQy9aVjdx?=
 =?utf-8?B?dS9YMytFU2tqUkM0S2hGSDd1ajM1cm9FK0duVFhEUGY0aklvemJMV3F6eXlU?=
 =?utf-8?B?K0srOE9KSURYK0thalF3MTJJY1ZtenhxakQxYjF6cHAya2FDaXpySlBPc2Rp?=
 =?utf-8?B?bkE0WnFhUmxkVnBmOG42S1pLK0J2a1gyTzhKYzQrejhoamdOcDhWS0tBSEhX?=
 =?utf-8?B?VlB3cHBDMCtzemJaZ25VYitXamgyNFJHR0JnUDUyNVI2TEV0QlpJRFlJMkZJ?=
 =?utf-8?B?eGtSd0xyd1JqTzhuMEVPTldtN21TVjNNekp2RmFVMm1WV1pLTUZsemtlb2dk?=
 =?utf-8?B?dnR6SHpVSVhoa0xvTXREVUlkOU1RL2lKVHBOWENZQldhdUdhTzQ3NmlsMnMv?=
 =?utf-8?B?OXJOYnMyalRtS3pmcTZ0TXRvYUVrWXU1eDV5WnpndFZmbjdvMEJZdVhndnpw?=
 =?utf-8?B?ZWJDUlE4aWtFQyt5Uldjci82OEM3UzRSUzc2dVdpYW9LOWw4Mjk0L0ZTallS?=
 =?utf-8?B?MFNKSFBLcDRhRTg4RjFtb1pZOXR2eE1qWUYyYVJDWlY1Znk2L2ZtZWlnZHZZ?=
 =?utf-8?Q?1C/I2/inhLHyM/Irp/K9f+AHf?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ad92b0-912d-497f-8db0-08db3211ab37
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 17:59:27.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo2dips8bOx92bM6fCiaCqAxwLVGzFpG3GALNbv83w3inGK1Wd98S8fg/eQLF9NivsVVmzNvb9+Z2kPheoeBRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7853
X-Proofpoint-ORIG-GUID: jThV5bTjiwOHy2DKLhK2Nq6muTUzIRFD
X-Proofpoint-GUID: jThV5bTjiwOHy2DKLhK2Nq6muTUzIRFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303310144
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 11:30, Greg Kroah-Hartman wrote:

Hi Greg, thanks for looking at this so quickly.

> On Wed, Mar 29, 2023 at 10:42:35AM -0500, Brenda Streiff wrote:
>> The National Instruments (NI) 16550 is a 16550-like UART with larger
>> FIFOs and embedded RS-232/RS-485 transceiver control circuitry. This
>> patch adds a driver that can operate this UART, which is used for
>> onboard serial ports in several NI embedded controller designs.
> 
> People are still making new 8250-like variants with different ways of
> controlling them these days?  That's the design pattern that will not
> die, or at least, it keeps getting a "value-add" :(
> 

This design has been on NI devices in some form since at least around
2009, so I hesitate to call it "new". But yes, it does seem like if you
let a hardware engineer be bored for too long you'll end up with a new
8250, a new SPI controller, or a new I2C controller. Sometimes all three!

>> +++ b/drivers/tty/serial/8250/8250_ni.c
>> @@ -0,0 +1,447 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> Do you really mean "+"?  Sorry, I have to ask.

It sits atop 8250_core.c which is marked as GPL-2.0+, and has been marked
as 'any later version' since it had been added to our tree [1] in the
pre-SPDX times.

[1] https://github.com/ni/linux/commit/6bf16de92cc9

>> +/*
>> + * NI 16550 UART Driver
>> + *
>> + * The National Instruments (NI) 16550 is a UART that is compatible with the
>> + * TL16C550C and OX16C950B register interfaces, but has additional functions
>> + * for RS-485 transceiver control. This driver implements support for the
>> + * additional functionality on top of the standard serial8250 core.
>> + *
>> + * Copyright 2012-2023 National Instruments Corporation
> 
> Um, 2012 and every year since then?  You all have had an out-of-tree
> driver for 11+ years that has been constantly updated every year?

It's been in _a_ tree-- NI's-- in some form for that long. But... yes,
this is correct.

I can't defend having it out of mainline for so long as having been a
good or wise choice, but that is the state of things.

>> +/* flags for ni16550_device_info */
>> +#define NI_HAS_PMR		BIT(0)
>> +
>> +struct ni16550_device_info {
>> +	unsigned int uartclk;
>> +	uint8_t prescaler;
> 
> Please use proper kernel types, u8.

Okay, did a scrub to remove C99 types.

> 
>> +	unsigned int flags;
> 
> And that's a horrible packing, do you mean to have those offsets?

I wasn't thinking about struct packing here, but yes these can be
reordered.

> 
> And why "unsigned int", don't you mean "u64" or "u32"?

For "uartclk" it was because struct uart_port::uartclk is an "unsigned
int" in include/linux/serial_8250.h.

For "flags" it was because there are loads of other places under
drivers/tty/serial/8250/* that use "flags" as an "unsigned int" or an
"unsigned long". Using a width-named types would be clearer (and I
don't mind making the change), but I tried to adhere to the convention
in nearby code.


>> +static int ni16550_rs485_config(struct uart_port *port,
>> +				struct ktermios *termios,
>> +				struct serial_rs485 *rs485)
>> +{
>> +	uint8_t pcr;
>> +	struct uart_8250_port *up = container_of(port, struct uart_8250_port,
>> +						 port);
>> +
>> +	/* "rs485" should be given to us non-NULL. */
>> +	if (WARN_ON(rs485 == NULL))
> 
> Can this ever happen?  If not, don't check for it, otherwise you just
> rebooted a machine that has panic-on-warn enabled :(
> 
>> +		return -EINVAL;
> 
> Or better yet, handle the case and return the error, why the WARN_ON()?

I'm not sure if this was ever possible, but it doesn't look like any of
the other drivers supporting rs485_config do this check today. Into the
dustbin it goes.

