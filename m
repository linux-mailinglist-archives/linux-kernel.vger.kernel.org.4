Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E8F6B0C0C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCHPCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCHPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:01:59 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D848537C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:01:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Szwv+KB47U0X/LBUhnhqEmvO2S8y31qF1jDH6aQfML93pepu/ejLKTaU2ZJlyIXdERP4zBxgm3EsjJEvMmKi/XLMJJ7QRYrdmhW5yTq0Pl678L0EnTvrxXNKUX+JTdmzLv6HX0XsUZWAPHVUZR8SVKREP1CZEA4lXthQLJ6Xbn7QYLzLeVuiy6QWIvAi05dznJCrXKrUrX8N1423hL/EEO+B0zAdC9fTZIr007wIgin/J2dvjR523K5ElTVP0+c8B0uaiHDkg0oRiYk0kDtNPElAsBVjdAcjIeE0Pu7PnLoRyW3OWAc7uHKM4vR3At5R2fRo+UaJ1V38sIBiXHB2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6efry8jy7z0RFtcdDPl7ZDKl6Mx+WfxfoqTjWB7sraM=;
 b=kiFzpiM7/5ZsdFLNsIMcHqWdcV8OBc+6Hh4wspJ5VJJgErYI5/EK9z7ViU1K0mHEhwBcv7V1Khnb8ShtfiUVMB6ryvXA8/fUehh1DseTWGP+sXTulmxZWvJls5YmK4pFY3EaVkxz0hNz0mU8guMz2PTWqAloGo2aKySaOpT9q06F2J4bIW7ohskoJSB+hpcYTTytkxz3fE0dHh6AqEqxUYvj932m13nrdT8ky8i3yo2FItpDCxLm+l4KEEjNgtN01/kYtv+D36Lma2UwRve6hlG1JT3Xy2P/6r+HrPH7O0apfgduLeqjVkrUA1fSc5cbP1ADaOUR/6J1633yfxUN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6efry8jy7z0RFtcdDPl7ZDKl6Mx+WfxfoqTjWB7sraM=;
 b=valEi4E75vC7TCDlWV3EpswssJCLlIRc0lA+ZoNwJcyQB3EJ4/19ESl2O3175xmpsUEoGMea7qqE7R0Vb/nRxf/mKc6/Y32WToy19woeoBs3lrEzYnHBW1NKu24LnG57NtNlvc6UsMGARM58mDrBmbAZk6cZvDEXnjs2aVIQ17s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 15:01:52 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%3]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 15:01:52 +0000
Message-ID: <e430ca1f-c678-01cb-0924-1e1139dd3315@amd.com>
Date:   Wed, 8 Mar 2023 20:35:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V6 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-9-Vijendar.Mukunda@amd.com>
 <4330af6a-ce97-53ed-f675-6d3d0ac8f32f@linux.intel.com>
 <d5a75826-d762-27fc-5820-6826debdecd9@amd.com>
 <9399110b-bbba-f96e-85ef-a317e8f4d518@linux.intel.com>
 <4cbbff8a-c596-e9cc-a6cf-6f8b66607505@amd.com>
 <85aba51e-1feb-5eb0-2e21-b714e217f9e4@linux.intel.com>
 <2e629a29-093e-46e9-2329-0d5afc916ee4@amd.com>
 <dfb09d78-0620-e535-08b6-894554201ead@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <dfb09d78-0620-e535-08b6-894554201ead@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM4PR12MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a733da-b326-403a-775a-08db1fe60c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAx23ddw+LMRacYGMrhePKKaR/WeGLtdJqMq8ZiAsTlvIHK4DHeBOqLSHy11OyF4OMFbFlOYhZuib0UTFmieT8pNloJxbVD962k0h1JZsnO9yIfnIncdLahfqZTSNRHUM6uz5mB+AMcQAkgA6M3eDRa9rJusI3sBxhaAzAbki5XcjVYbDqfFO9J2fNtt6aySEjPjT6xZ0va36dizGMuIJRaziNjrHWMMVtNQIU6HSne4B8vz350fugEShW6QD34m4jBJMM1qtr0ul5jfbW5nv6p8qcL1tvN25KK10P4sz8RNZoQNdHbrJVPo5CJ0Mu8mtJoZbTvQKtXZsqxmRIxlbl2iPh54gBsc1uNbeCR/nm7vOdBK3aW4+48V4Hf5ZNwfvy2qgRtXAtbw99WDWnXNb8+le92w94lpSCIYM/R9GpBlouYkSSS1toBaJKu5gVCo3OlCL+dfNV0RLhnSfnzvT5X0IOHMWaihyE8rKzSIk3XP+bsidf5NNz7vEzoqPgL471IkrGhn4cxdL8YkQf5gUuql2Ly2bTKWdWk1cm9l6zJRfAwdvPAh+SuptPxQreGbsD8JOr3hfOFgSN/obXlba7gwFDY/BIImxlOmZu6rB9RWlfrnwiMBQ1L8RxO5rR+OaCOxaC4ARQexbhPPkig8DvwH7E/gLVqB1ZlnVrV8DAauOTIqzBQDpvUL4tXcSFYvNjsgukrwTFXFYzc1cFlBBppfIiteKvJGhpKfGXOxEF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199018)(26005)(53546011)(6506007)(6512007)(54906003)(5660300002)(478600001)(31696002)(38100700002)(36756003)(6666004)(86362001)(8936002)(2906002)(6486002)(66556008)(66946007)(31686004)(8676002)(4326008)(66476007)(2616005)(186003)(316002)(41300700001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nyt4VFJST3d0Umx1dmZVWFVLM28wOWtOeVdVWXdnR0c0MWdIcjNVait3SUwv?=
 =?utf-8?B?YVRHek9DVEZMSkpZY0tZOHdWQW8zM3VtSnh5Wm15VUlGRlhPcEFSN0pEVFJZ?=
 =?utf-8?B?NHk2KzFPLzcwdzBmTHpEYW41OFdlWVZkMnJNSkI2RlJFV213TndWLzZtdnBq?=
 =?utf-8?B?VnI4RXJYUC9YKzc4aTZsL054Q1FUNnk3RXhYT2JVVXQ4SVNKZi9PYyt5QjVP?=
 =?utf-8?B?WmJRUkVZd1ZOQnNoYVpya1FjaHFrR3NuMFJ0M20yR0ZHdkkwSHJPWElxM2Va?=
 =?utf-8?B?SS9JTXkyQlRXbHFxY2I2NWR2RC9Rc0VHeU1kSDRvejAyNmprZWs2cDU3TXFt?=
 =?utf-8?B?WkpFRWJ4bS8xektONWNYT1hVRkdWRjRVdExGNmVvRlVBRFhDMjdiZ0R3cVVz?=
 =?utf-8?B?OVgycnhMTDY0MTV5S2d5bXQrZDlpMUFTbmVMV3RMSzZ6KzNudWZjdWR4bHNX?=
 =?utf-8?B?UE9IQ0dWNHFlMHNoS0lWd243ZURJV2ZUak5NcDdPZFp4V1EzU1FFZVgzamY4?=
 =?utf-8?B?ajdMK3N4N0VxRWJDZHlYZFN0SU5QdUlYOXF6cVZvU05PM203UVVzZUt1UFZz?=
 =?utf-8?B?ZXdKbm9tMGxPNURMNGlBSUU5b3Q3VkJ4dkhhSnQ4ZEJoWjRGNjZicyt0Nk1S?=
 =?utf-8?B?ellUSStrcWs0dU5RL0RzVmhBa3Q4ZmUyUmticktOd0x3ajYwSmo0cG5JdWlv?=
 =?utf-8?B?TlNnQVprSTJFSTM1Tjg5SXhmYUJtS1ZkdzhnM2xRd1lxT3RpRWQ4eU84V3Fi?=
 =?utf-8?B?R3VYWFUwV043NEZJcnIzaGFWTUI0cXF5SkozcnM4WDVCZ1NINVhuV0I5VVZm?=
 =?utf-8?B?cGFuc3lzME0xYWh2eGJHc095aVFDbnhKWmdPU3lHS2diMWJwT205WkFBTWgy?=
 =?utf-8?B?SEo5WEduZ0Q5NE9pdnhFR2ViNjl3VmpJVWdaWk1OMlBpTTdJbkNNTEdUd1o3?=
 =?utf-8?B?U2VoLzV4cHJyUThFVjBldDUyRy95eUx4a1pONFB6NVM1Y0g3Tms4d2x6T1B4?=
 =?utf-8?B?bW1qNkh4L3V2NVZjdGRKVTZkWXRIV3VrSnNrZlBUZWcwVkRHK0orTE9QdXhv?=
 =?utf-8?B?ZU11QkU1SGxhQ09wZGFuRmdHdTM3bDNjS05YbFJXczlJaGwvOGR6NzVoMlEw?=
 =?utf-8?B?YXVFYjI2VXVmdlF6N2k3R3FSRnBFQS9yWFlhVjNOTEpUQ2ZZbDhNczE4TmJD?=
 =?utf-8?B?b3VBMkN3SVJSWndYbStoaGpwdFM4VFN1VzU3eGVtc0hYZzU4QS9JR3dvelI2?=
 =?utf-8?B?MmtUZUMvRG1ZR0xZTmUxSjZEVVc2VGxTU1VCdHR4N00rbFp1bnIvOVRpai9U?=
 =?utf-8?B?RkRHMGJQLzdCallBUWQ3dStLd3MvQ0tqMkdRbEtobDJjb2lIY0YraHZmdDQv?=
 =?utf-8?B?Z2dPQkV4NDU4K29GdkVLbmxXbjN4QnNsR01VdUpjK3hIckZYQ2VqSXlndzd1?=
 =?utf-8?B?NUIzSFlYK2NlanFjU2MvMjkyUS9yYXFMa1BLazZXNkhkTTdBRHk4enNXT24y?=
 =?utf-8?B?eldGV3JENHozR1BXNWhGZkFEeU9hL0hsTFVxU21nYWVZUkQ2WUh5VW9nMVM2?=
 =?utf-8?B?Q2YxZEVyKzZyU3gyemZDU3NkZEtpaEUxTDZtcnpmanN4UXJZRlJoVVBCeWZJ?=
 =?utf-8?B?eDVFWVA1ZEF0MlNGQ0ZVRjBIVWszMTBqTXRNNXFVSXBZY1RxT1BlckNJdW5U?=
 =?utf-8?B?RDRiZ1NQVzkzUXg2SkhWYVVPc1BucWNDR29ycGN6YThTcU5XWnFiV25TNm54?=
 =?utf-8?B?SW9Zc2dlaStLMlZKRWJzWWpCQ255dkxnRnVJQlh3d1BpM01BSlpoNzJFRTJx?=
 =?utf-8?B?Q3Yzb2pIZkk5cm5PUitVMXczRjgrS0wxZnVoYTJIbGNaOE1ES21aVDZveXpN?=
 =?utf-8?B?M2gwN2FRTDdudHE1WC9TUVlLUWI2YVRIZHFWVktTSUt1YnNGcEpMWFF2QTRC?=
 =?utf-8?B?SVVMK0g1RzZqQU56UjhsRUl5aXVYRXdQQXhtM0h4TjV0VnY3Wm1aOG1xMTd2?=
 =?utf-8?B?N2VFRS9IYjYxL3A4eUFCUmhwaU5hbDJoa0ViR2hNWHVRT1FHSVByMHo2WFNp?=
 =?utf-8?B?S2hTeFJpUkFvbzlxVDBxQ1ZhaE10RjVndXJPaHlpaWQ3Smg3R1F0UnJJMnhX?=
 =?utf-8?Q?GsUKASldBx6D6iLNS59thH0gb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a733da-b326-403a-775a-08db1fe60c71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 15:01:51.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlCeDsGQb65A20l3UwVVPubKdVUDELLyznMCfnHRfhDvZ6t8rKmeh2F8Zhfnqn3PqGRjzF1kU695WhUBjW0jvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/23 19:53, Pierre-Louis Bossart wrote:
>>>> device_for_each_child() will invoke amd_resume_child_device() function callback
>>>> for each device which will try to resume the child device in this case.
>>>> By definition, device_for_each_child() Iterate over @parent's child devices,
>>>> and invokes the callback for each. We check the return of amd_resume_child_device()
>>>> each time.
>>>> If it returns anything other than 0, we break out and return that value.
>>>>
>>>> In current scenario, As AMP codec is not in runtime suspend state,
>>>> pm_request_resume() will return a value as 1. This will break the
>>>> sequence for resuming rest of the child devices(JACK codec in our case).
>>> Well, yes, now that makes sense, thanks for the details.
>>>
>>> I think the reason why we didn't see the problem with the Intel code is
>>> that both amplifiers are on the same dailink, so they are by
>>> construction either both suspended or both active. We never had
>>> different types of devices on the same link.
>>>
>>> I would however suggest this simpler alternative, where only negative
>>> return values are returned:
>>>
>>> ret = pm_request_resume(dev);
>>> if (ret < 0) {
>>> 	dev_err(dev, "pm_request_resume failed: %d\n", ret);
>>>         return ret;
>>> }
>>> return 0;
>>>
>>> this would work just fine, no?
Sorry its my bad. This would work fine.
We will fix it and respin the patch series.
>>> No, As explained, pm_request_resume() return value is 1 for active device.
>>>> As mentioned in an earlier thread, there are two possible solutions.
>>>> 1. check pm runtime suspend state and return 0 if it is not suspended
>>>> 2. simply always return 0 for amd_resume_child_device() function callback.
>>>>
>>>> We opted first one as solution.
>>> My suggestion looks like your option 2. It's cleaner IMHO.
>> To use option 2, we need to respin the patch series.
>> Is it okay if we fix it as supplement patch?
> I would vote for re-spinning a new version and ask others to review.

