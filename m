Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5149E5ED0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiI0XTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiI0XTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:19:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1461129F0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALkaOCDnQnZPqDqx7X4SGlDyT/LCYr9AMgXM9YH0j5TMVX9/ilqzs1iz6/Xl05P3cweZh4cK1ZIQ2vSe5Lmo8O7L75wnon1kybeT9+8SM8yfzj78+L/7TIoXv+acEi54KYtBLpvORRSZrV3Y3ECj7mDhrV8O9ubXOD4xsAxNY7vp11J/TY4GHw+KVOlFkbWhW5LjSWZRUWnyayHZhVFwwHPuLNpPTTqXKfNVv25Fj7QXuT5ZgQJZXNhbs8I1udJ7QhM9xk4JGzLHnMj1/brSk8k8LSs3CHi2ufNmShLLTGSwdlmJ+MVZA4EnudG0F349MhD9whSI7HhZ5/wuovDauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoC0urk5WC0W3I64kQgESX76jLvac7UpKl0yN3aBeuc=;
 b=XTjGcPNKICEDhQTbfOQwk6dhKZgQ4yvTI/tHPG09btHIzRcoTm5DvSqTC+6SXOKBP6GFXREwD679JzGLXS8LuoV0IBqNiv4zcpmm8iVNRhqXM3iTV2S92CWJpvK+xlHRqQpUbOm5SdMYMrl30FO+Hic7+IggHVXBzyFJL0N0CEtfc3x8tYkh1k0AEwdYM6ROWrbm99CpcTuGgJD1M4uuAqC0Vdj0JT+9ojIElGpgvBue3Si8x0+TyrtP+HshAzevgEkBhK4hdaWEDKCHCGdEscd56N/pOa6LlynAjd3gwZiDHyzUi3PeC0pYF8XxaNAjF0RlqDhj3XJXNhzx6rFIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoC0urk5WC0W3I64kQgESX76jLvac7UpKl0yN3aBeuc=;
 b=TY+TojnCKXV5SzIA1OPsnnRmqSKGNyUHX6c+xw3AIBvPdzpnJ8THzq+F6O8fRlM4IRwNd8kojVGAcvtQ/lpmtvIuFBd/Jj/jfA/WSqRl+9+GadF9/kkMnalRKMoUn8nsd/I3uGkOyzN7QxzGfQLw/Dz35QpJzjazS6cBFkBXIdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 23:18:59 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243%3]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 23:18:59 +0000
Message-ID: <179b3e55-695a-d145-0b3b-2b67fbb54097@amd.com>
Date:   Tue, 27 Sep 2022 19:18:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [REGRESSION] Graphical issues on Lenovo Yoga 7 14ARB7 laptop
 since v6.0-rc1 (bisected)
Content-Language: en-US
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
 <3ba218a3-8b6b-c0da-873b-53e1a8a082ae@amd.com>
 <f84e4956-293f-801d-6b9f-df4226df87d2@augustwikerfors.se>
From:   Leo Li <sunpeng.li@amd.com>
In-Reply-To: <f84e4956-293f-801d-6b9f-df4226df87d2@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0054.namprd14.prod.outlook.com
 (2603:10b6:610:56::34) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cd68d4-c671-4259-3305-08daa0dea80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1A08/O0HBq0EEdgOF9xReualOcCijzzvOdNivr7ntKfLy9felo1XSfYNcuviAbG0ytt8AY5gowGFsB7nqJM0OMA6RJGXRpif5s461TSjoguM6dNEk1kfM0mg5s4sNjlxsBJVcE4/gwb2/3rIAeaCiABibxNQbYHaJleqqJ2GoUEZNFZyDDTjtLPgwUHZFm/SuLoHwNX56NSFH0mt2ANcgnLq7keRqT5JlacyYJ/aAHu4NdGvGR7LaqafRNnEniDrP4cMNi82JiFfJMxN2k4z8Xds99GeL/2Ewy67iJxoBo7/x/Y4gxO7dP8DI2peKdjiF0ExFvJ9CFO5L1YX2jwf76gBDsr+6PNVewEOpY87H9LLkWZwmpRrF8Apd4JvhMagMh+B0BCZ4d3+6eGxMKxdKwSHefvyH0GWmulgCOiUVHR8CkDNOPQoS7aFc3pg5e1YZCXw4xpYiFl+E4bv3ECEtef8CGeaf7XrohZBQhv70uREtZo8KtQ5MuGe8cMErn0kNYZGJZRSAVqxmteDVdJpAnrgdg6tVI4VxRJthgDtpeU+0udPARTRBvxLW4ENIQAOZrltGbbllhkR0jqoXtBH2wRZHPt6sgVHS529B7zzMc6CO5ZosSPz+ggdChOTjpKPdelITi2DsAe3I/jU3LinRATKBrz8xv36DCn+nNUNtEJ2W+bUCVlCdE1Tkte+XJZYw1rUAyfWtHFcGutpoZhSJ5BXPLSkdC7Fe7Zw4b+9uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199015)(316002)(110136005)(6512007)(26005)(31696002)(186003)(8936002)(4326008)(54906003)(66946007)(86362001)(66476007)(66556008)(2906002)(8676002)(2616005)(6666004)(5660300002)(6506007)(41300700001)(53546011)(36756003)(6486002)(966005)(66899015)(31686004)(45080400002)(38100700002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REsrUEdibFA3UzRTODEyekwwdEh3cmt6citkVDgzSWNSYjlFYXdFNXVaUEVq?=
 =?utf-8?B?Z0dtdmtDMWduU2lTS1RGd05BL21YUXlzT05UMzliQ3F6Qy9vc1FSc21IWWU4?=
 =?utf-8?B?RFdVd1R0d2N3Rk9UdXkxOVp4SXp0aFBrSEhXaFAvSm1Gd0lSMkJJUEFsV0J4?=
 =?utf-8?B?dHNieml0ZmlxY0QreGR3S3RIZmhNa3NhMHdwVURFKzdqaS9PRXVWR3ovcmNC?=
 =?utf-8?B?cS81QjhaSHhidlFybFU5bmdnTzVtaXl1bnduSDJEaytoZUJsckhlbzZlSWtY?=
 =?utf-8?B?UkFmY2FSTzZmYi9seHNONmJOSU1naDgxOXZGeTlOSHpZQWdLanlnTTdJcmFj?=
 =?utf-8?B?SkZIUkt4WFJROU81Y1JXaHM1aExtWVB1cDBYcHdwdWM3bVJwOHZJTEFQdG8v?=
 =?utf-8?B?QXYxK2JxMmV6bFcvbmxmZ1V5WHZkN2tBN0xOTXVlRnRRSU5ZTXYxMVdBU3pr?=
 =?utf-8?B?SVAvYlBKSzNYckhtejdqbkZ0dmd0cVZwRmVqbWtUUzZ0UG50WmNsakZPNVFq?=
 =?utf-8?B?ZjBqTmQ2UEJyaStWa2tCT21PUjJkMm02TXhZK2ZXNUxMeHp4Vm5haXpqQ2h6?=
 =?utf-8?B?K3BnbThYNmd6K2gxYUpNdFhONERveVNsNGhITkhIL29wbWpRY3NzZWVLRnJ2?=
 =?utf-8?B?NEU2TUUzVDJSRzJqemhGMUltV20wUTJYVDdqOG1mWkIzTWNDYkFsYVMzLy9m?=
 =?utf-8?B?QVJyR3hDSTBKY1pMS2V3L003VkF0K3JRRUxDYjdxMlpUUjZ4MUxMbFZrdytO?=
 =?utf-8?B?cGJjejJxL3RLdUJSNU50bzJwaCs3aDdENjF1dmRpME1sRVFUNEYza1VJdXhB?=
 =?utf-8?B?NS94VmZrOXRSYXcwUDc4SVhxNGtMSytQMjFTeXJGTEJWMzlpb0YwL0JEeVcw?=
 =?utf-8?B?clpabTNqaHJGTFE0WUZIdXJUdTd2L1FpdkJYWlgrTUxRZWhRaEs0K3FyU0dq?=
 =?utf-8?B?Q21tZy95WnJ6M3lsNGVtWDNFT1lFMSs2bFNpWFE0ZmVvM2VPelpHSE1kYTVk?=
 =?utf-8?B?dTRDUXBMOUZOeTNDcmROUVZoeXRFM0NlUEVya2hpa0NoK1k4aEZMN0docGdn?=
 =?utf-8?B?V1c3T2VUNGRoeE5XZUlvRkxVRHhYdDFJdlNYV3BqYXN6dlh6Z1lBNVZMb3RL?=
 =?utf-8?B?TklzdlpnNmc0eTdRMHRuZWRqb3d1TmhvV21xUS8yRTN1cHIzZGVtK1kwaTMy?=
 =?utf-8?B?MUtnRDZJU2c3YWJlUnV3V1U4VTNPNHV6K1ZTUUZvdUVrMDFtTXZXUy9YeURT?=
 =?utf-8?B?WWU4cWFrYldmUXM2R1hFdkJjczZnbHIxcW0vd1hYOGxlNE9xa213Vk1UdW1T?=
 =?utf-8?B?S3RKVGJDWDFGVE4wUFg0RDRBRWZXa0JETTVhWFl2NTBBejFTQnpBYUZzT0Vo?=
 =?utf-8?B?NjIyZ0pxd0VKSVFDbUluTlRVOFRkdTNtNlFRRnNsMng5WE0wZVhwQmhWMWN1?=
 =?utf-8?B?em8yQWRxd21MQUw4U2Zxd3NRbDVBNXU1bU5EUkYzUEIyOUpqVW44SXRNRjhl?=
 =?utf-8?B?Ri9hUktlaUhPOE44QkFNV3hCL01ZcUhOaUNrblA5ZjYzWmhEeDRZTUFTc1k5?=
 =?utf-8?B?NFMwcTRxS2dVeGhaYTNvTGVkVk50RkNKaDJxbkJFMTA0WHhUTlA3SlJubVJp?=
 =?utf-8?B?Y3g2SUM2OUtSOXQ3aWZ5bHZndU5ZMFF2WGdmbjlqak9NRkZJQ21ZVmlwUWlX?=
 =?utf-8?B?OVUxejJjVHg4SmdiSUdoWmg0WHA5Q1lPbFNITHk4c082TGJEMVZZK2tWd0tY?=
 =?utf-8?B?Y095bkY2aWlWMmhDekZBYTNRMGR0MWVrWmdweTJYS09xMHJtdytDb0g3Vmlw?=
 =?utf-8?B?VnVSWVJYZUVTVUpJa05NMzIvbUlrTnR6bWxMVDgvRmpxZXNtSmt5alRPNUIz?=
 =?utf-8?B?enU1MTQ1VjVybFU5RWo5SXJaRExNc2FBK3UvcFhsQmhBV0MzdmJBSlR4K3NW?=
 =?utf-8?B?NlVwQkN5TmpUYkg0NjN5WFNGRTNvbHNvMnNxMGFFUEo4bUFzTEpYeW9WSk55?=
 =?utf-8?B?V3NSaHJxNUorZHgyTmo4WHhRWEVCdzZzT1VoY0xFWG8vZTNsbXlPNUJaYi94?=
 =?utf-8?B?OXhmTUJST3JqVnJDWG9ScmpnaEJ3OGdySmdGQzlnaks3UDhtUGlxU09WTjJF?=
 =?utf-8?Q?Vt10=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cd68d4-c671-4259-3305-08daa0dea80a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 23:18:59.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VDeogs+UIyxM7NsCEy38e/G8wuigl/piV0xGUxLpTUXHHO9ZIg1SP2R0FRcKCty
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi August,

I've sent a fix here: https://patchwork.freedesktop.org/patch/504993/

It's not the most ideal fix, but it should address the regression. Let 
me know it works for you.

Thanks!
Leo

On 2022-09-27 10:22, August Wikerfors wrote:
> Hi Leo,
> 
> On 2022-09-27 00:29, Leo Li wrote:
>>
>> Hi August, thanks for the log.
>>
>> It seems the eDP panel does not fully satisfy the amdgpu requirements
>> for enabling PSR SU, but we're enabling it anyways.
>>
>> I suspect it may be due to the "DP_FORCE_PSRSU_CAPABILITY" bit being set
>> in it's DPCD registers, I'm checking with some devs to see if that is
>> expected.
>>
>> In the meantime, can you give these two hacks a spin? Let me know if
>> this helps with the glitches and system hangs:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2F-%2Fsnippets%2F7076&amp;data=05%7C01%7Csunpeng.li%40amd.com%7Ca5864225840b4bbbd04c08daa093bb26%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637998853607058272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=cNAK%2FMhWCGwXySpITTTvKtzXQ7WCEQL4DYSrPKzWSkY%3D&amp;reserved=0
> Yes, the issues do not happen with those patches applied.
> 
>> Also the dmesg, in particular this line:
>>> [drm] PSR support 1, DC PSR ver 1, sink PSR ver 3 DPCD caps 
>>> 0x70su_y_granularity 4 force_psrsu_cap **X**
> Here is that line:
>> [   12.085196] [drm] PSR support 1, DC PSR ver 1, sink PSR ver 3 DPCD 
>> caps 0x7b su_y_granularity 4 force_psrsu_cap 1
> 
> Regards,
> August Wikerfors
