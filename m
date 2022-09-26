Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096265EB490
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiIZW33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIZW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:29:27 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418A511448
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gii8mmQyJOrsd0jAWbOZpuBbg2i6mnI889uXmOLlx1vbB0AtIf53WDeojJMhB49Vq0d3yfb6/DjzjzV0ZE25oaOlbSwYCrqiVyCPQrU/Lb3Zzw+p3kiDnhsTn7aBLOqqKOEPq7ujTIsK8pFemA27IBWw1r+/yM9WlOeAVhso4HoDJPSf1ex0uH8nzas+Dv8oTuYuvoaUAlRLszRtfYWxAJpp4MXbFrM+RblKUOfxBIiFp37hrEFNH5n/yw8BWM8KqMGRFi0ROc3hUGDCHl1astJnNZ62juNSFR5t1N/8GIbh0y10E8ztfH1jMW8WpCLWOhpjxz0e1/s4wNqWIi2FKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbYKjBKoyzNVAxBWO/Y8QN4vswp1Im4MQni+YNo3zdA=;
 b=fX9wp435diY2RWHRU+FaNKriwDctE3ysiB2Y7uqaaywt3OyDwk+LhKV4ghdfRT7pLH4rl4Db/U9OAAVS9wvafq5zWsduB7dPCsCowxB5JMWPhT2t9yaFJegXRZP3i3h8hwg7g0PUZCCRveJVs8N+vpnn4C7FlMxNYbv2AqJ56ZpoQryeu3qDlo5CstTVCv+9SLcloGeuKJ2OJXCSz+Nx3nOiq6HuzmmP9ppEtZekPr8Jfq1vKST10fGnKvMmgueDVH6a1iQz89a3UcuPDt2H7QOApDbSRE30gIMoUaqUcqEBkC7ODYd9eKVe2IdTQoUnr7oPDNDEwd9HUani1NseeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbYKjBKoyzNVAxBWO/Y8QN4vswp1Im4MQni+YNo3zdA=;
 b=N0HsUyBn4uiXHDmhfY5FBlzPFQT6Acqp6aztou9CcsACZW9Xp8QVJSXorW8CU2uAuubKldfoEj6pDEDAH17RokOZ/wM/XKzdAHb1CT7ivMz3pDarwyOM7S7qCEUitExEj1s8U0R7gslPvrCxaIgc81hKiPzUzdMDIdrgXZ5sNrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 22:29:22 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243%3]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 22:29:22 +0000
Message-ID: <3ba218a3-8b6b-c0da-873b-53e1a8a082ae@amd.com>
Date:   Mon, 26 Sep 2022 18:29:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Leo Li <sunpeng.li@amd.com>
Subject: Re: [REGRESSION] Graphical issues on Lenovo Yoga 7 14ARB7 laptop
 since v6.0-rc1 (bisected)
To:     August Wikerfors <git@augustwikerfors.se>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        regressions@lists.linux.dev
References: <c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se>
 <eee82fb8-0fc5-98cb-e630-f86891574f21@leemhuis.info>
 <CADnq5_PRP3ekHPLhdXALxt9GL3aHHZQUw5TNAwm4t+ggimUq7g@mail.gmail.com>
 <33cf5071-3157-a3c2-3252-3a8ab926c60d@augustwikerfors.se>
 <f4818fc3-7015-29ed-95c5-ab6a18da33d7@amd.com>
 <ea1f1d81-650b-768a-30ab-c9d7d9f9fa54@augustwikerfors.se>
Content-Language: en-US
In-Reply-To: <ea1f1d81-650b-768a-30ab-c9d7d9f9fa54@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:610:33::17) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b1eb25-9412-4a0d-77d0-08daa00e8fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xtf66Z4eTFHEoKRAsNS+37EZoHsUxCOIfrQcDK+UGmKEu3fFVlRyqC2KjY4uClowLoYX96Im+3fPklWP4cAvjAjEwJb7bXlh9+TP0A+d90E6QNfgEDJSLKpO1WktD1SO7x4XPiXlackAQ4z+jW5eGCe7D4d5t1cBL8QYoaR1kebr3FGSLGwPRIDrE3ErMo1Wsfxy9Yb0oLGxWOOpnhvKClMsU2E7dtvjt6xuDhf1ROErkEAdvJyxu+l7Vtekg6S6dnrlX5evDV28mHUB7vohItqNUGXn/KoHXKTiRVjUqlH0fx/4VBhVdN4pYyHip04rzbAKROqta1naGt8+jnrx7BUQCIcv7LBV4FYLCsI4vUUEWEpNVicF4aFWCvUA/k2Y1HqxQW2pJbEjgp2oHPLzWAXBcd4tV9OyN6Ybm/fUErvtmicaWDGjV8uPSy/UIIsXLTmIwlG3JULrHhXPjZDLDsuhV3WHpFgmeOQ1DQWbnV0nkXH/q0mmgVU15wYri1r5XksVJMhrzUTI2S5IRf1uuJrxKtD0/nhyozvzZo1nPz9QuWGvWMn+COdb0ZpTGawoIp3agVRdY0ehvZJfWzqBlj8lFkcvyusqXrLxwrOEFrrrqNDibTDUb7BTq1LXsFRW036IFPjrE/4TMafCbSgy+uhgqQhBcc8KEzP50czc9yyyYD8aIhB1JTQHtyfcWYJlCWtBlgSq1YGhEeNoOrHG+fSljSg+O1wrLkovpu5yTYVwhu17vQXxjO2h9lxtnt3C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(110136005)(41300700001)(8936002)(31686004)(5660300002)(186003)(2616005)(54906003)(316002)(2906002)(36756003)(26005)(45080400002)(6486002)(966005)(478600001)(6506007)(6512007)(53546011)(6666004)(31696002)(83380400001)(66556008)(8676002)(66476007)(66946007)(4326008)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU56dVFZeWkvc213T0VwQTB3Yng5OEhENnhxY0Rrdm40UVRvM2hvM2JRZm9P?=
 =?utf-8?B?bGRGRW44UkRlMlFtV0NTQjI2SkdoajV4eGhQYmRJaWMyN1ZNY2RmSnBBN1VQ?=
 =?utf-8?B?d0lEUnYvNHdYS1drOGdSM0NhYXJNSmFBVlF4azg4US9XVG1nZDk2REJkYVZG?=
 =?utf-8?B?N2RRV2xjZlBseFp1VHNhRUtBMGJBeUpNZEpxRDZaVDlPVDVWVGpyUzdnMExU?=
 =?utf-8?B?OTNzKzBhaWRFZXpMQVFxT3g5MXlHQzVteXA2TlpseDF3VzBlcmExQytnN0k0?=
 =?utf-8?B?SWRKNUhVNC9qL05DNjNrY0RWcFYwTkdnYTRGQVFuWk9YMU53dGlVOWZhaExa?=
 =?utf-8?B?bzNVbFlOWXhFemRRMGZJVTE4L21NZGdRMmhyb2k2NUM0MmxBUG1seElTbHdV?=
 =?utf-8?B?cjZUK1dzK2MzTWRpU3A2T2NhejNNazNkajBpbFlCVDJYMytFQXc2UWJNMkRp?=
 =?utf-8?B?ek8yUEx6UkN4ZzNmbnVTTWdwamVDZmlUUHZ0R3pOQzZtYnNBcys4OE5LT2Qv?=
 =?utf-8?B?YzAra1BicnpFdThyRWRwMjNzK2RERllGMjROd3pwOFFQaVRvdm9QbitCZllG?=
 =?utf-8?B?c0w5QlFwRktrZXZ4THRucjc1SXR2VVVRQURjWUdUNWZlektlTHNEbHdlRC9k?=
 =?utf-8?B?SnBVQ24zOHoySnJTdmh2Y2JjOEVnaFNpVkl2MEVVSHorOUZ0ZzAxYnVvL21j?=
 =?utf-8?B?S3NZVzM4aXNIM0s1TlhLbGplRXNSR2xNVzQ2aE43dXFnemlxZ2Y3ZkNQaUhZ?=
 =?utf-8?B?SGxQbVVqdHYzaVpDUkhSU2R6Qi9vNmVNc0h1RWFJa2liYVdvM2ltMXB5YUdE?=
 =?utf-8?B?MDMwMnhtV1kzUnQ4YTQ1RGRvZ1Fpdk80ZUF5Q1JVRi9tZmlBdVY1NXBVNjI5?=
 =?utf-8?B?dzgvSXpCUkpsMU4rbkF2dUt2djRRd0pKNXZPNFQzTm9hWFkrUFZWTUxsMWFM?=
 =?utf-8?B?S0pPK1RpU2d1bXBqYkdYVnI4TjZ2UHB6b3NQVVcwdS9RY2FOQkVHdXZIUC9I?=
 =?utf-8?B?azdpYkorUUcxQzZmWDNlOUFmUWdmK1NzL1NQVzR6YnZ4bVArb3hQTWxWV1BO?=
 =?utf-8?B?ZVAzMDYrUW1LcG9Tc0dDaHR6Y2o0TE83T3ZKMGtKUnloOVJoZjNzaG1UTDF4?=
 =?utf-8?B?U05tQ05RMmpxTWdGZkYyN0pMWUJSSS91dmVWL0M4TVJzeWxENWNoNngrNmFY?=
 =?utf-8?B?YWduOTRFbDhNZGx1Y1E1cTcvLzhnSVloVUtOMjlJRFRzYUYxWENEbHJHTU11?=
 =?utf-8?B?UE15VlZEVEE2dmNnM2w4bTVpSHROSTFab2cvNUtWQ0ZEYmhMUUNYcU01ek51?=
 =?utf-8?B?L0hOWG1CZ0QzTlJaUFdrd0x2K0dVRnBkNXNDZERzaStLaXUxd01kU05KT1NP?=
 =?utf-8?B?TDhtL3I2UWVWWUwzVnA4algycFRJS2V3VkRIK21QcGZ1QjhtdmUveWF2UzZN?=
 =?utf-8?B?NUpkMDl1YUR5K1hOVEllcmYwYjF5L1BLem00MHE4ZUp3S1prRE9GNVVKUHBk?=
 =?utf-8?B?MHdWUElsZUZoNGZkWWREQnBOeW10b2wvMVpKMlZyWWRKODF5TVFZb1Rsdmhq?=
 =?utf-8?B?bmZ5aWhiOW9Td1dNOEFzaWJFNi82UVN3NU5taFRWdmRKMWxQOE91TWFtZkxT?=
 =?utf-8?B?Sk9kcXVrdWxhR0ZlTXhHN1dDVmh1OVd6MGJQb1JhR0U4TFR2Ky94WkNYMDFn?=
 =?utf-8?B?eWFoc24zc0lSRlBkUnlyajRHY3J4OHY0ZlBzZ3hzUE5NUlBhZzUwMU81empo?=
 =?utf-8?B?M0hGc01qVFp0L3QwQmQwR3Z4enNVR1lMY3o5SGx3VkIvdEJuejVZNHNTWkRY?=
 =?utf-8?B?blNRcFBhMHVySk9UOWJRZW1tM1BDNDd0RllMS1d6TTdhSjhUUmVHcVJ2amNB?=
 =?utf-8?B?aEIyTzRxbjJXNFRpdW5NMDlLYzlkSlFaMFJkNTZvRXZHRjdxdW5ISWZEbnU1?=
 =?utf-8?B?WUlwYjh2V243Z2ozeFFjU2hwNk9hNnhJc2hNenFPZkQxTmo0bUlWUE5QdlYw?=
 =?utf-8?B?MUk0bzYveFZPVUhObmVWNjhjU0UyZlFhUUIyZmJkZHBlNGNqb283Ujg3bEp2?=
 =?utf-8?B?cmpnbHNYbktEeG1SNzV4aWFtSUZ1VkJnTWR2SkVtZGpiMG1zZHRRTUl1dW5U?=
 =?utf-8?Q?h2TQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b1eb25-9412-4a0d-77d0-08daa00e8fa0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 22:29:22.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrtM3w5zAWLnlO5JMTki3gABtfmFH/RhVwKTxhZvYRJ52hdKhzim+jTWXt14qEru
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi August, thanks for the log.

It seems the eDP panel does not fully satisfy the amdgpu requirements
for enabling PSR SU, but we're enabling it anyways.

I suspect it may be due to the "DP_FORCE_PSRSU_CAPABILITY" bit being set
in it's DPCD registers, I'm checking with some devs to see if that is
expected.

In the meantime, can you give these two hacks a spin? Let me know if
this helps with the glitches and system hangs:
https://gitlab.freedesktop.org/-/snippets/7076

Also the dmesg, in particular this line:
> [drm] PSR support 1, DC PSR ver 1, sink PSR ver 3 DPCD caps 0x70su_y_granularity 4 force_psrsu_cap **X**

Thanks,
Leo

On 2022-09-23 16:26, August Wikerfors wrote:
> Hi Leo,
> 
> On 2022-09-23 20:41, Leo Li wrote:
>> Hi August,
>>
>> Can you provide a dmesg log with drm.debug=0x16 enabled in kernel 
>> cmdline?
> Log is available here: 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Ffiles.augustwikerfors.se%2Fdmesg.2022-09-23.txt&amp;data=05%7C01%7Csunpeng.li%40amd.com%7C261d31a0ac6844e40b2208da9da1ee82%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637995616061782958%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=6LAMah8N%2FdEG6gl6u9HGcajwozrS7fwp%2FJDLZMKpcGU%3D&amp;reserved=0
> 
> This is what I did during that log:
> 1. Boot the system
> 2. Type into the password field in SDDM (this is when the problem occurs)
> 3. Switch to a TTY to save the log (the problem doesn't happen there)
> 
> Regards,
> August Wikerfors
