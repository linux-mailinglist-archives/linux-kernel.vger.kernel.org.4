Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D371566BFDC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjAPNee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjAPNeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:34:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926391D926;
        Mon, 16 Jan 2023 05:34:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cih3NVnezjLJ8PgxVhIX1xaAq75xwqYrIkM50MGjVaMwrbjnD1Ufn9Me+/lDZ5x7l/KQmjwEarnUBXfCWbRccyAiBginOJPSJJyXEIK+Y9LChlsM7DRha0rWwMtqsTRt0qSrwSsU78D7CEJZDA5hluf1LAMyESLVlu2FtciUXSrAVUAgeIMefCcidIlcMWGSfy85yEDl5tfLkTMJZZ3ZgI02JRCnwlhBjJTJCm/FcJDxPqMJKzyC/d/kx9wbJTcfWfJuwWKxquwgr3ksHdFYS6UmGL43ZUfIbqyFgdHeNz7YjOuQrR3gTUitLPxWvK58vkYiYa2LIAncFXmfgozY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAsrt/TK34CuWcgeLMhGj4m60gxaJxA+PBC4cjQ0MFM=;
 b=ftUIhGLl2bAIWOzQgegAZ90qc5M58cimP6pj9sUOKV7Tr0RhHSH08pXriL34GcCGsy9lSdOjzDl5/e9LKqYp6n1EmgGe/uUjicul0ZoH5xbgcWLxuYELmb4Ur2pBVohwo/2FruyajxDPIJD0XuXi3qEsr3uJAXDmatkRslDJMjtPOPHLjYZ88xvrahjJm2Uk8yG+UFetoJUk3G0lpWEL7VdrmaC8STRR4nyIZSzpI7FjQ9gW16148+/ar3uxoEB7YJqKEKg+aXhaoEh7P2l9q6yPdOYpgC4o31KoX9+zD51pmWIQVyyG9IuRCffz+BVNWxoxiXXAkDhKrLKRK5mWWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAsrt/TK34CuWcgeLMhGj4m60gxaJxA+PBC4cjQ0MFM=;
 b=MqHomjYYx/edLDf1BfH+LryPrbLVxvbA2PdUc56ubTnTp7HxCQWgYl8lRjBqyXr37HwQPhxwyqOcGfn0LbrbvEw7uMmQjPHlGSch01OkcLbW5fQftaiR0G45mgzXdPVsaq/goxvNmp2m96reEGaSyretp98bvJb6zNS58Zie/AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 13:34:26 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 13:34:26 +0000
Message-ID: <437ccc68-e07f-de9a-4a0d-602b0d8189dd@amd.com>
Date:   Mon, 16 Jan 2023 19:04:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC 3/4] perf tool: Introduce PERF_RECORD_KMOD_SEC_MAP
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, kan.liang@linux.intel.com,
        peterz@infradead.org, mark.rutland@arm.com, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, james.clark@arm.com,
        german.gomez@arm.com, leo.yan@linaro.org,
        alexey.v.bayduraev@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230110055859.685-1-ravi.bangoria@amd.com>
 <20230110055859.685-4-ravi.bangoria@amd.com>
 <cbcb6109-0c23-9270-a534-c4fabdddfbbc@intel.com>
Content-Language: en-US
In-Reply-To: <cbcb6109-0c23-9270-a534-c4fabdddfbbc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: faf7524b-1c7e-4e2c-8b3d-08daf7c662c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7wgcmI3Mp9ULnEEIWoH3euahqyZ93IZaLRnS7A7gk3Vf75QxV+SS3ckltUS+yh9G6QToUH74IahVf0lPXVH1RJ30YTX4GCKwK2LfU2y2P21RlPb9YCJ0BocK2NHT+7vWr6R/Ysb0cpZ/nH/R4T6TrHujdm/8XUtAtRy/wEhyrmfqZ1jaPbsPc1JjZdE7fH69tq0fGSpVfLpasIaXJGkm9hBB6PTd1FRpFzacK5+YYrq1WsR05YKSQrybOojOZ0Na6E2NUyN3EIhhzS17NZVyivOOFD4x0yOsk/PHga5itaKhQmgwzyzBzV25M3gdWayO3GbHLaIpYV+gQ+fr0+KGBk+qX8syeYXeHweMBGrAJuz5MVZdr9OaYUA2gIQ78QCa1D2uEsiFLD4v6TZsCBawVHw8dGrvFNyfzsJgQgtaeO/UUxdzv9WSeGQng/YCBQOdrbGWee7g9jPWnOhYaPts5lo/sAmLvGnYdncaWEquOlRbtQjumWIHiVgzMM4uAd0ivYX5W7SNhQJfivrcZ0a7KTKz14Dtg2JafGQFKV6UzxOgZYm/elbNMOoWaJxQRxwyjKWFHWTun7UvktuwhrlYha0Zb273sh8Ar3YPeUjW2stL33UXDU/VEFvSJ0Duvjhwz9fVH2jWh3oCsf2qE3vqggzoSBE769w7r57AvRpv1czX+IuoAdqwqSNCaKypORjMmOUxnEzZiNGWvjQxEy3tS3RdSvBqG8J1jUxgIMREKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199015)(31686004)(36756003)(86362001)(8676002)(4326008)(6916009)(44832011)(8936002)(66476007)(66946007)(66556008)(31696002)(5660300002)(2906002)(7416002)(38100700002)(83380400001)(478600001)(6486002)(6666004)(316002)(41300700001)(53546011)(2616005)(6512007)(186003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGhrRG12UURPRXhYUVg4aTVWcEN6bUJwZU9NVTVWWnk5SkoxSE0xWERUWFJo?=
 =?utf-8?B?RjlsK3pJcGpFYTNxTWRaY2xuR0NUQ2ZsOThadytLaEhrU0cxdG5tMFR5RGM5?=
 =?utf-8?B?NnBsaDMzVkt2VXNONzlHamszMVp2VXMyN2hrRWg0eEJyczNqSmpFL2xuOVJB?=
 =?utf-8?B?RldnTjd3K1hKVk1WbHR0di90RnVXWTFYMGU0WjZsM2FPei9ZTTVRS25odTFq?=
 =?utf-8?B?Qm5IdmlvV0NHWlhpUFB6alZjUWp1c1c2TnhwN3JabWY2UmU0YURlcS9kSjNa?=
 =?utf-8?B?RU1GTnBvSHkwUmpiMWxkcmp6dDFveXU0a2cvbGZ5RFZYRDMwVlF0WjREenZp?=
 =?utf-8?B?U3dTbGVtdktXRFAwLzYwY3BHdXZ4dnZ5Mk5CUngwZ2ttejJNR3NGTUZwdi83?=
 =?utf-8?B?d1RvV3pDM2VyQ25kNmMvdDhEMUNyNnJEcXkxRWNiY2gwVEMvd0ZvSDYwbkZj?=
 =?utf-8?B?MTA0ODlWeVdmVW1uNmdybzlYZ1dIUUk3NllsbkJBSWNDOXRsdlh4NFgzL2pu?=
 =?utf-8?B?QkVBTmZLbkpoSkF2L1YrbkVVbkVXWnZoTDg1bTNMOGlKUzVvUGFMcnNxSldE?=
 =?utf-8?B?UFpYdFpXVzFqZkl1SS9wOHp6NGJhbHZ3UjYwKy9BN0pFUHVsYW5kNm1rcEJJ?=
 =?utf-8?B?R0k3SmxWVmpzR21mdzBHS0NlUkZMQUdyNlBqbmo5TlFZVVJDemFmVlRuaXNk?=
 =?utf-8?B?VVZLVlhNLzQ3alBKNW5TWUx3dStnUXBteTZubjFIeTNQMnFIWjE1Q1liRHpq?=
 =?utf-8?B?VXBEWFZwcCtjUkxIeUl4ZUxTS2dDUitNaitiQ2JtM1JjTWY4M0hsSTJkK1RN?=
 =?utf-8?B?dmdROG1EczB3SlFhSUEyWkdPRnhUSG5ObDB3VEQ5NGlCKzRDQnl3Zmc0dzQv?=
 =?utf-8?B?VG91STErUEk2clJ1K1hQMDNDbHFuOWtEVUM2dHZjMDUreHpQVUJGWEVZTGgv?=
 =?utf-8?B?K3dDNndEMXBkYmdCeEhBbGJma1o4bm5jSXEvb3dOSFd0V1VORURuYkNsYXFi?=
 =?utf-8?B?R1RKaXM2K3UvMTI2c3ZRd3RHSjZiYXUxMnRmbXpsVG04YllpZ3Vxcm4yMzc4?=
 =?utf-8?B?ZHMzL2dFOEdrd3Vrc1hHTzhsazVFRmY0Y1dNYlhJcHMrTWJ6bHlMOHpxTkFT?=
 =?utf-8?B?Q2tsWDVveVRZT3pQbDVoeW9zb21PSGpHQVI2UzRjOWFNK1ZBbFJWSmwxRVAv?=
 =?utf-8?B?SURSRFJwZHdYalFMemRqSlQzTXNrTXJOaHQ2cWJ3MHRsNFpJYXVBemVXamxl?=
 =?utf-8?B?UmxxS0N0cnhlaWpLeWpsbHRpUmFvYTUxTU8yYU1DNjdhOERBeDA0UVJ1MzBk?=
 =?utf-8?B?Y0pBSHlMWmxORW5odk13WndCQTZpY21DN0NCenhyaG00Sm1aQUxzWks4OVhu?=
 =?utf-8?B?MjBZMmpuSzUrR0dESXMwL2pDbm9FWEFMSHFjRzVnTUFxTEthempOYWM5ZFZE?=
 =?utf-8?B?U3c3L1ltcEtZME5DL2J3bzluMExqTk9xZ0Zlc004cmZjR2hqdlJpWDZRem1q?=
 =?utf-8?B?OFE1bU1DaDUxeGkva2llOExOZHZtOGlSNWJaT1l1NVBuRnQ4Ykl6YktsQjRS?=
 =?utf-8?B?L0I1RWgvLzhUQWk3akZiWk5nUDdvbFJYWGpNUGxybDRDWUJ6eFpJTlFuV0Fk?=
 =?utf-8?B?aTYybXNzMG8zZ2U5UFZveEp5UkR4blNia0d3L2wrQ1FZMlVDSTg5SVZHWXlG?=
 =?utf-8?B?MDA5cDhDT3VJSGlobjJGZmxaSGFPYVgyL202RFBMMWR0YmplZCtGSWJZd3dl?=
 =?utf-8?B?aFJjUEE3T0tvSHlKdGZlSS9tODE1c0o4M3UxdWY3QnRoRjdKODdTc2dlQ3F1?=
 =?utf-8?B?OUhmT1NBWmE5OUJnOXNiRjRyZU1kemVzQk1NZ3MvanAwakFmd3pMK1hXZnl0?=
 =?utf-8?B?VmhNZWpUSUdYTUFCQ0tBN3hlRzJSa0lOZmt0WXRRVE9JUGRXb3p1VlpiZ0NC?=
 =?utf-8?B?UTlRM1BOWGR0WWZidFMrNmVkYjdDVHBsazBUdHA2WnhRL1VrWmlPNFFlNUti?=
 =?utf-8?B?ZzUxaEE4enB1K3J4TWFmQjgycmVaZmMzTmpJNDlOSmR1dlByRzRjR2VYNVc5?=
 =?utf-8?B?OHBmNm1XVXI0YjFlRUxXRUV2ZXpTZUoxdE1zSzF4MlNTcmtITG42cFArUXFW?=
 =?utf-8?B?U0F1Y1dtaGREZGkvQVJSb2o5b3BjekpwcVJ3MnQzekRERmVjZ3gxbXVOZzJM?=
 =?utf-8?Q?mrBooOI52HF5htBKpM1FPM8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf7524b-1c7e-4e2c-8b3d-08daf7c662c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 13:34:26.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYTDIbqX/7HUbiPEwa3a23D0McsNRvzkvk0/s6fWSs0orlvS+y+pz1wC/FKySE7t0oy+tjLZzht/w4txT0lXDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 16-Jan-23 11:44 AM, Adrian Hunter wrote:
> On 10/01/23 07:58, Ravi Bangoria wrote:
>> Introduce, perf tool only, synthetic event type PERF_RECORD_KMOD_SEC_MAP.
>> Also add stub code for it. This event will be used to save/restore kernel
>> module section maps to/from perf.data file. This is needed because kernel
>> module elfs does not contain program header table and thus there is no
>> easy way to find out how kernel would have loaded module sections in the
>> memory.
> 
> Currently machine__addnew_module_map() adds a map for a
> module, and then perf_event__synthesize_modules() creates
> an MMAP/MMAP2 event for it.  Why can't we do that for the
> sections?

Do you mean why not use MMAP/MMAP2 for module sections as well?
I thought about that but:
- PERF_RECORD_MMAP has no field which can help segregate normal vs section
  specific maps.
- I can probably introduce special MAP_ flag and use PERF_RECORD_MMAP2. But
  that flag will be non-standard (perf tool only), which is ugly.
- I also need additional hacks while synthesizing section specific MMAP/
  MMAP2 (e.g.: store section name and file path in filename[]) and similar
  hacks while parsing them at perf report time.

So I felt introducing PERF_RECORD_KMOD_SEC_MAP is relatively cleaner approach.

Thanks,
Ravi
