Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76B62D190
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 04:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiKQDXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 22:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiKQDXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 22:23:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2102.outbound.protection.outlook.com [40.107.92.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27463A2;
        Wed, 16 Nov 2022 19:23:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/XLn2j1fWYOKHFlYNp9SL4y6z5HKUH8N1MxfGRGvsMLG0scSXRhlboHJdP3HOQpA+NHtK3idARpoYJ1auFAl1eC/FbTU5fCD7P4Vt6iGYZrEhuZ/Rd1mcu+94uR+8l8pMNHgTinxxVXqLcDEXvm4bEVvvLehnOaSiTjcu+oAF6i+noONAmIP8itfq6Ybw8JX3XJCVpgJgCCrVZ4Sma+48z/fVOzI6tvcvoBJqvprfeYyH67pBY2MpMOuJ7KNVpppIdlSsI3RPRKuDhwcTqKzI3BI93ffboZiRpIyalPKXqObx/xSvWy3MtbNKZQ/6ZxtktStj2P4tJ/mfXa0RT4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0H3mSvcnxlObHJYpZD1w1bfKTfsQ095RKzPqChWCrI=;
 b=jMtMPENkf7ejPGWId14xe5xOSPrq7UtPJxVkSdbO1kfvpy8oRmXmdTYT0TrpRHwtlIMD/Znn+3L326NllmkjnTK/IMFqWOyshcuKS3CTVoiqqOWlen4BDwskHUaImFRuW2m/e07G5qUfxaQkU8HoKNqWpHFsE8CInjzOpxw6RNUjtSsWKOXGSJRKearyxw4FTGQbv5mQkVoTa6Qbs4KHoDZjWL6DP40fFf2X9JaQzZylGNpOOU0JMndTff4O1BldGm7M9TKpsZJne+6ZQyPwOlCQhh7SoRO3l1CLxQtwoGYB3/G5Vc/9FcJ5TjcspSCa1jWovZMTKquOx7VuM7sCSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0H3mSvcnxlObHJYpZD1w1bfKTfsQ095RKzPqChWCrI=;
 b=oAphoW4ucWBBCcQ1eSqXm7gY1E/rAYwrFBRsCuCKLdI15ft8TqNNdAEpKcz1U+7G6gUrBBXGpJI3rzW65kV+1R0fKh0WKuXXXRPjJ8EODME81G97UUR5ZlbnYh1E4LWs2w9me/hjCeXgI+svvWoMOkv8N08+/zPEvS/cCdGl8qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN4PR01MB7455.prod.exchangelabs.com (2603:10b6:806:202::11) by
 DM6PR01MB5050.prod.exchangelabs.com (2603:10b6:5:68::22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.16; Thu, 17 Nov 2022 03:23:49 +0000
Received: from SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::df7e:7f53:a83f:a86a]) by SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::df7e:7f53:a83f:a86a%4]) with mapi id 15.20.5813.016; Thu, 17 Nov 2022
 03:23:49 +0000
Message-ID: <8562147f-b68a-e49d-c914-c8d9d00901d6@os.amperecomputing.com>
Date:   Thu, 17 Nov 2022 10:23:38 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: dts: aspeed: mtjade,mtmitchell: Add BMC SSIF nodes
Content-Language: en-CA
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Open Source Submission <patches@amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
References: <20221024081115.3320584-1-quan@os.amperecomputing.com>
 <781ea7c7-b33e-f054-71eb-d760f7a01301@os.amperecomputing.com>
 <CACPK8XcCKK_o0hBA82k0CEcpbHXbHcUii3bgoGvHaGvtw2Q_Ww@mail.gmail.com>
From:   Quan Nguyen <quan@os.amperecomputing.com>
In-Reply-To: <CACPK8XcCKK_o0hBA82k0CEcpbHXbHcUii3bgoGvHaGvtw2Q_Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To SN4PR01MB7455.prod.exchangelabs.com
 (2603:10b6:806:202::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR01MB7455:EE_|DM6PR01MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a3b9ce-2c56-43ff-13f8-08dac84b247f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gtorwebTpL5/WLFcyOzJK2c/xhG54vm42SCzFYLfWYK4amgORR34VCz2CeDd8O/qXBKZFrvCWb4JTug4NX5aMYvk3rkhiUp/7GxlwHrGK1+vtkvf67nXjJzJrNeGu/SqmlPdh3YTMKG5BH4aqWNN8fs+WJ/GmnW+USjPC6Sear5G+DOzG0BEhKCQNdKh/b84duArogEOPZe7HEMwIiml9dfbgXR77cNPFnJ2FyRP15pf4oGVsB+Y1GVdx5aW7xCLFrC9n7VZmkHGO+W3/PxARXzLk/sbrnlbvZP+sRDqQNAhfR1ZfdTlV+U2AFNacQQIwnFTtpcKPTQNa+fakhQAb77uYqiUd+2ZSaxvK9SjS5/uaCTWj9160gWvpR3P8fdfA3QtNO7Sdj6scaegs4+XVlaN2vBuXhKfxQiAOEmrs9LbnzYFdmy4OD2kyQx5mO+hawDJ6eANLsTwi88NKHD3c+GMA9kiI2Q/j2TNxlAsX1qNs6aKE9MbMGvZR6wuXoNhWsSAhsmjozADYcjRKGOae1v9oDnRcOqx7B4mEitwdVUI2FWLf59yN6mGz66ZnbQAem1+P4nnMROhr1u6/reEX8UGNuqfMTE2ZI/LJhA1UhHjttksDY5SQ8PRNGQBzcLrbDptPFXl09VYKdeOj8PCOMLA/PHrgpZiyM1tQXl6lP5Qy3TAJbgKJ6aa8LFgVprssCC4C2bIytCOwxHF2c3BoObNdZdgSltwq+LMLDGsqg+6/QF2KsEZr/tZNal2VciVg7J79q8aRvpyEynBvh+hytghD/TAc7ljtMG14Wn1cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR01MB7455.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(396003)(39850400004)(451199015)(478600001)(107886003)(6916009)(316002)(6666004)(6486002)(41300700001)(66946007)(4326008)(8676002)(66476007)(66556008)(2616005)(186003)(8936002)(5660300002)(2906002)(26005)(6512007)(6506007)(38350700002)(52116002)(54906003)(31686004)(38100700002)(53546011)(31696002)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm9rK3dyZ3J0a0wwS2daRldwaW9jUzVYbGQvM2hUNmR6cWtqTkxpVXVwcFNV?=
 =?utf-8?B?SFR1Q2NJTjhBQnNvR0NDb2phRVA3RndIY01NZzRXcFZWd1FEaGdmMXI4aytB?=
 =?utf-8?B?ZDFDQjhkV1VURzhtRkNHYkRvK3Jlc0E5QnVBdDJUbStKLzZPTUpXQXd3SjZ0?=
 =?utf-8?B?MzRJbDg4RXhGSFVwaERBRVNzZlh0WElRYzM5TjdiS0Z3MzVKNU1NZTFBbUpq?=
 =?utf-8?B?SmozMUhPZEhQbFVSMFY2YmRVYW81RVdYNkNoSkMrd0Z6SVMyWEhRQnQ0VDZQ?=
 =?utf-8?B?MnhlZ3RsSVVXeVF1ODhZdng2ZWlOSGZLUjNiNEdRak8vbmtiaTJ2TWJCR1NU?=
 =?utf-8?B?SVZhZUI2TFAwYnNGZm9NRXZoWkM0anArZENQcnlBWGtneWNtYVBBRy80Znky?=
 =?utf-8?B?RURyanFwUE85UDRlbXBDVnZHTXlDd0lmamdwTmF6cGE1VUUxMWtBeWNlODRJ?=
 =?utf-8?B?MFA3R20wYVQzOC94ZGdDRnRWMVBycTFLYWdZejg4aHhPK0srU2VzVG9RQlMr?=
 =?utf-8?B?b1hLc2F1bHg3MENqSUtyejNSeXBaaEtQYjhFODJIQ1NqU0oxM2hyN3EraGRX?=
 =?utf-8?B?elljeGUzZnlKZ0ZQSnpmZFdIQ2ZmZlVHSGtQU01nTE45QkhpM2IvRytBbklw?=
 =?utf-8?B?SnhxWlVYQUo2bzRla2YzMG81SzNYOGNxRjZ6emNDazA1Wkp6S3ZiMHRNcmNr?=
 =?utf-8?B?Myt5dk90bWlEemRsMFdoa3l0N05RL0RQZkQxeUVlVGRKazVYUFRhdEZzTVVC?=
 =?utf-8?B?VFFmcjFKUUdUTDUzMDZ0MGMyaEs4R3RrZERpYWxndFFuNFQ0Zk9nWVhiL0N0?=
 =?utf-8?B?Q2ErUjRzdTJIdGM2TFh3SXNQSm1NZ1BmR1dKVGVkRzlpWFBCZkJDemJxMHFi?=
 =?utf-8?B?YkRFbWpSaC9naURwQnJURnVsbkZlL2xnUndHUGpIWTFMckc4blN6ZmM2WEhV?=
 =?utf-8?B?Yk9sOURySE43WE5GWkJHK3pGckp3UjZTblBmajlhWW1ESnRhd2Nrdk96Lzky?=
 =?utf-8?B?RmhHM2E1N1plbXpLYW9aWGxCS0JiMGFmeTYyUE9CSUJzOXcxblkva1ErY25G?=
 =?utf-8?B?YzZTRGhPdm1vVjdXY0VZcTFiajcvbnBNR2xWcnBvd1MxU0g3ajFxdEVIdDY1?=
 =?utf-8?B?ZzBZREd6bFd6OWpZV2FETS90ZVJ4UHU2bjlucytMeTRPVFprbksyZlh2SWk2?=
 =?utf-8?B?VERmRG5XcG1IZCsxVkdESmo3Z0djM25GQkxiS21sUGYwQ1U5eFFCTkFiTEJO?=
 =?utf-8?B?YXNwdzBMYXhpa0tmdnQ1NXI2V0VJQU9GT05mTkh4b21EWVJ0d25LTTZMRUo2?=
 =?utf-8?B?alQyNlIrMXZ6bTVSS2JkZXVFckZCcXpmNzQrblhnTC8yOTZNQ2QyRmhxNnRu?=
 =?utf-8?B?TjR0M281eVNxZVRmYTh4TE1JNlRnL1BJbzB0S0dHQWgrbXNMbGpHNUJGdFVo?=
 =?utf-8?B?QXRPcW1ZNlR3bWR5cFdtTm1CbEd2dkMvZXFvR2N4VG1pZk8reFVESzVsUWw1?=
 =?utf-8?B?NmxDM2dFU3pVeFNTTVY1VnZxTGoyWHJueWt3MVp5b1oyU0Q1UFYyOFEzSHNG?=
 =?utf-8?B?SHg4U0RXcUZINDRyY0JWaWVyaUxTMk56VHBJbnhrdHFLc3NtYWlVQWRjRGdN?=
 =?utf-8?B?M2dlOGZMNmVGbmZ6MDhWenZhd1Q5OVNaVjVCMjBiUGZEYXpHYW4yVHh0czJz?=
 =?utf-8?B?VVN1VHc0V1E0OGpuR1FUV0d1b2g3ekkrOFhIamJRaWZ1Y3Y1WkZqMVNiKzJX?=
 =?utf-8?B?UTM5NUxra29ndy8yc3NEN1dBWHV5dEVZUFIwUXQ4aXZ6SjdqR0VXQ1dPRTJM?=
 =?utf-8?B?cE9zSnd6R05KZXpBcFNUbkJmS3RCeXN3REZYM051cHY1OGgwcGk2TnFjelRp?=
 =?utf-8?B?WXhYRHpVd2l3cU04ZTFOd21uVXhJTUgwSDJNM2xQeEF1RmhrYW1XeXI4cTJQ?=
 =?utf-8?B?Sm9wdklZRVBKNzg4OXM5Zk9XVmFRVlpBK0Zoc05rWTlwSlNNSXNzK0hkc2ZO?=
 =?utf-8?B?U1J5VzJEMWpEN2xBZFBPZnh2dHpLTFRLOFAwallaOHY4NWZ5dXNWRW85OTZz?=
 =?utf-8?B?THBaSExNQTlnbklWcktEcEZPMG1PTWhPY0lESFJNSTU5WEY4N2pYNVdsbnVW?=
 =?utf-8?B?Nm02WXB2aUtncW1IMjcySGlJdGxpK0pUQXR1ZTBKbHlReVNsaTNSbmkrZWpB?=
 =?utf-8?Q?Iw6yej4QR9el0HnMAUTGCIA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a3b9ce-2c56-43ff-13f8-08dac84b247f
X-MS-Exchange-CrossTenant-AuthSource: SN4PR01MB7455.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 03:23:49.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4szbR3crtL/vMui4MheLEGj3JxWzBR/WxXiA6TOpe36FgfUDI6ASgBAR8vMhe4aLoYsMGwOH+tZf6HdprjouRK9VVwz1qRJrqtDEYMdwROo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2022 10:01, Joel Stanley wrote:
> On Wed, 16 Nov 2022 at 07:06, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>>
>>
>> Just a gentle ping about this patch.
>>
>> Thanks and best regards,
>> - Quan
>>
>> On 24/10/2022 15:11, Quan Nguyen wrote:
>>> Add BMC SSIF node to support IPMI in-band communication.
>>>
>>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> 
> Applied, thanks.
> 

Thanks Joel.
- Quan

> 
>>> ---
>>>    arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts     | 4 ++++
>>>    arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 4 ++++
>>>    2 files changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>>> index d127cbcc7998..353359822d7b 100644
>>> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>>> @@ -342,6 +342,10 @@ &mac1 {
>>>
>>>    &i2c0 {
>>>        status = "okay";
>>> +     ssif-bmc@10 {
>>> +             compatible = "ssif-bmc";
>>> +             reg = <0x10>;
>>> +     };
>>>    };
>>>
>>>    &i2c1 {
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> index 606cd4be245a..4b91600eaf62 100644
>>> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> @@ -445,6 +445,10 @@ &i2c9 {
>>>
>>>    &i2c11 {
>>>        status = "okay";
>>> +     ssif-bmc@10 {
>>> +             compatible = "ssif-bmc";
>>> +             reg = <0x10>;
>>> +     };
>>>    };
>>>
>>>    &i2c14 {
