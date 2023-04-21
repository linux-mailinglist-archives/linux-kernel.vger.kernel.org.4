Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617496EB16E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjDUSOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDUSOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:14:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF502127
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 11:14:31 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33L8oSBl028048;
        Fri, 21 Apr 2023 11:14:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=C65X31CuErNrdNR0W1Cvn4ROEgEcZHZPZcnLCQ/iwgA=;
 b=ZPbahb084PWxGqcdpKKOc47yEklx1qKrXJGyZh1U3RCzPsb9pVfHhus5fJcK4bRyVM35
 kRZkFX+FlJ+qodg7mT4P0wdXGsCu0GBVu14CdUdgd00w4SLj0XXB45+AAgLz7enmxWNW
 zAdSo+UAhZQPFun7W+XR1JWVfSOU3tdYweWKWFpfr76pS73ULahdQ7uscsd4nKI3STrZ
 Ocve2BwwFGKeNfGanfi7tM8nc59cOkZNjaqFgd8rhHeuSMy+7nEkONr6rhVZop8M2vvU
 d4fLFN5lCu4DxPRUi4HXrPwyxjB9+vuBZW1nkrHxwMvBRZ1AOHrTD3GWxKv1WjCDtD8d 1g== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by m0001303.ppops.net (PPS) with ESMTPS id 3q3qak38wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 11:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz08OIEcALIIwb6bt4DSZwjC+QnR9ZDMitgLEJMCAHtBqQAx+S9vkXVeRPbRFJUOmCEGxRA7kCJaaDw0k0WU+h0iUAgASDVogeDrWRbh2U+clgSBwW37pEW4wyT7GNw2k49bw+/lzomPcXyAjSRALERbMOtQLZ2K8bwO3E7BE8cZECIJyvlxavqva2tOa3VMR0Fe/d3sq9JdeqQ6bDORTBFgN1yNftvOtHFi2gUX7I7KajOTjlmqq1sN49t/3G0U2vNrJN/2F0WRAFFL8G+egZ9tFPAU0fp00IlkwW5E0ZkjZV+scvaV8m82SFHm9jLcao+9ZLuFSDmCFFfb+Zl5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C65X31CuErNrdNR0W1Cvn4ROEgEcZHZPZcnLCQ/iwgA=;
 b=LqmSD+9XC5B/h7P02jf6H0ny4mtubTDL4nScyPmuSgs4EGmaKPYCsbVugboaJRbfdnFmY6CQlcwL3pfyEGMWh/FFHl8K9qZ5nY8Jn1WLnkwkUks9GaBntbrZVrmU/7iSneEJuRLBWYNY9NO4L2iId1EpVqXXptTe81aU5WLPtPw8oJf0iy6+9yoZ/e1b9eEvKrDB5kV0zg6MZrnh4EKUOwEVtOYCE27evnqlBSrCqjTgvVf4t3O4tgC0ZlmbilRk62YYPktHpotwafQpkzzzgDtZkz+yMt2kwG/LiANFiIq35+aqCp/DLQvNgBOGACW2X4DwqgyPbHhjZYsZkjFMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by DS0PR15MB5597.namprd15.prod.outlook.com (2603:10b6:8:13d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Fri, 21 Apr
 2023 18:14:14 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::1fd:a451:959e:4315]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::1fd:a451:959e:4315%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 18:14:14 +0000
Message-ID: <1bd3bb9c-581e-2e18-aa41-ecf000e3686e@meta.com>
Date:   Fri, 21 Apr 2023 14:14:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: schbench v1.0
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        gautham.shenoy@amd.com
References: <bc85a40c-1ea0-9b57-6ba3-b920c436a02c@meta.com>
 <20230420150537.GC4253@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230420150537.GC4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::41) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|DS0PR15MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: d338820c-397c-4075-6998-08db429436ce
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgkQ+s/2VMytPbb8YCl26Jk8hsu8vuJ6stxfuN9XoENpuJr87AqAaTQALglUo+znHxESJyMRHuShKEDG0y4QK1/FmlEXsYtx/zIIeJiC5w5tYxTJE35cUx2jyLcuRIeuE3F6aECtEYD4yPqSvFWuA7VcI28m5YbwOb7242c+9cDmdznS4umW/8JqDatucUD4/BtwIDosdPQPijC1v4LnksQUlfOw4i2sn1fdxpspO4rf8Mcx/XYvbVsWaKEw7qWxSfKdz6aA5bL9sbavovkiDhb5RLUEsEq5rpKXU8y7RAA2x6v8nTYsO7Pn4fUPAlsZNr0k/BOn4qJIJatlB1kiWQZ34qVneuzQqxYL68WzJSfKWOdMCVe34qMxF+18r91+AL4F2ZsnDUNC2AOCsUnU9bwy/D1STyQN+68focFx/ts3kSBMChR3hpKM8xMnWFjkueWGxdeVOGKH8XXoa55H/JtVm0Y6/Upp+XcpIa4kZJkDJT8eyQ464wPYD5BFBMlyNnHC5S9sst1oU+NyFwI5hMutgb+jTi84QUeI1wcQG0we8ikCFOCktz8bdmbNpjxJdJJ2tTTEj35AefHatO0R4ZZxLJnnZGQD+TxtyJHsNqkYmPZGdyEznXyncR+8w6t/0NRnMAMRzYxAWZHuVncufg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(8676002)(2906002)(8936002)(41300700001)(5660300002)(38100700002)(36756003)(31696002)(86362001)(31686004)(478600001)(54906003)(2616005)(6666004)(6506007)(6512007)(6486002)(53546011)(186003)(6916009)(66946007)(316002)(4326008)(66556008)(66476007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnRIak9EUzhOTUF1NG5BVGVDM2xyNFZURUh6cWpFS2hrMmFNVnBIR0hHdFY2?=
 =?utf-8?B?YjJyQ2VSUUZhZ0l6U1pCR0U5OTRhdkU4aW1sZ01zVVFSeTVyWEp3eVlKZjRP?=
 =?utf-8?B?VHlneW1BVUJVeHZmQ2V0eDRrUFRZVWYxKzJFL253SmM3SzlWRW5WR2hLelZs?=
 =?utf-8?B?ODhVc0NNekRDa09CdzVIeUNhYlNRSmJ2YkdqcC80cTdxYmhyTS94Tno4d05n?=
 =?utf-8?B?L1VaRzRydWpFSlQza2pldTc5b2lYQXFFSjZ3dnlXek1wWkJMdXZXTDZQTDFl?=
 =?utf-8?B?c0pkSTcvZCtGQnVicmRpK0VVaTF1S3VLcGVTaWE5UFBlZU5jajNIVldMelNI?=
 =?utf-8?B?L0ltQ3ZaSFFCcDM0YUNBVS9IMDVYNUdLZ1ZURGc5d29mNHpPeHRkazBwaUVV?=
 =?utf-8?B?VFZIRHRWc0tQWC9XY2x5dUVGb0VUdnRrcW93YnJFeFFhaW80YjA5Tkcwb1VD?=
 =?utf-8?B?a1hBc1Yzdzh1QzVoMnQ5dDFUN0pUeWE2bWo4bmJxa0xTcGZIN1MxSVQwTHRl?=
 =?utf-8?B?eTFvelhoRmpCT2JCemY3SzU5MENOaE5hNjYzL3RQOVJzOCswSkpDZ2VBd2Vp?=
 =?utf-8?B?MVRyVGxKajJSR1grb3kwMk1xeXpFeFJYNC9mMU13SWFBc2pwS0lPM2dxaVdP?=
 =?utf-8?B?ZCtYY3RwMG0vYlhES3R6Z085bDdKcE9iOWtxWUc4N1JJaXowanR1VG5nV3N5?=
 =?utf-8?B?K1JWU1dlZm5KOS93b2ovWU9SMUt3NlVMZHJzRVZZclFTRHZRMm0rQ2dQU0Ft?=
 =?utf-8?B?eFZIcEJvdDl3cmhlL2hWT3BSU2xqOW84WlYvMDNTNjFGRkZ2Zm5yY205TmdP?=
 =?utf-8?B?Rnd1V1BZbmQ0K1RqWFhwZDh2ai9QWmw4a05RdUZ6VFVQMHhLT25aRlZUR00w?=
 =?utf-8?B?Z204NjhnY2g4Z214SWJYQVZJdndKbGtNeGlUZWlqS1FZaDVlYWQrT0l4UVZ4?=
 =?utf-8?B?NWc4TkV2c1h2bDVwa0kzNHVEcm15NmxHVFVOZVEzSHUzSld0elZ1bi9ENitu?=
 =?utf-8?B?RG02SDVXOU5hREpLa05TVW1tNzJqdjhqUVhMUVJFK0VxUzFRdFFDbHc5a3Ez?=
 =?utf-8?B?K1BiNW95Z1VaeFV1NHN2VjRva2Q2Y2hxQUZqb0NxU1FuVmJieFRGMlZreVVX?=
 =?utf-8?B?WUFIRXB0bjZUa3ZDUDFTMnBKOFFlekN5VTRkanNnb3hhY3RuYU02YUJ6S2E5?=
 =?utf-8?B?QUplNjkwSWh2MEttVFN2MEhsNTJIV3dkWVI2bEc2WlVJSERWaGZTeDlFbUtK?=
 =?utf-8?B?eVN6ODBocXEvMWJwSlR0NkgwcVpKSFM4aVpPUWsyK3RvOG1OSEZ0eGpLZWFC?=
 =?utf-8?B?RzlEdkVpZkJMZk40ZXVzVFRIbHFsZzJ0SXg2c2VYZW9QekhVQUZWc1daZTFN?=
 =?utf-8?B?bEpNelI0ZlpCVmlNWW4xeStJU2tJaVFiQWpSVVFkVzBvdjk1d29zQU1uaFFY?=
 =?utf-8?B?Q3ZhZTRSdFdlZHlvM0NDTy9ISmdGTSsvdC9JWEk3S1FoNDkvbUoxUkdnMkhK?=
 =?utf-8?B?cGYyUUxydWlwUkJmN2tMOVZ1YnphbC9NSnlvc2pjZWc0YjVIbGdYQ1ZGSnBN?=
 =?utf-8?B?dnhBSGo2amtUazFLVUQxWHVPaEI5SDl4VjFPVERzMFlQeW5HSXJPeHpFaUFq?=
 =?utf-8?B?RGxCeldnYlNtQ01PRHY2em1ZZjRwWFZmZzhtaVN4UEdkUUhZZVVEYmZrQmk5?=
 =?utf-8?B?a0VGaFNITnBKMTRkSG5iV0MvVjl2dVVkTTRIaW5mNVJFcXFUdzdhMUg3NDBp?=
 =?utf-8?B?bHROWURaWXV1SWNMWGNYUzFkWlkreVVRcHFHc1VhTDNmZ05URE11WW5WRURD?=
 =?utf-8?B?dTdWS0JyczVTMCs3OUp3Uy91VDJTZVZIN2Z4enlqZk05VGhmTi84VFBTc25V?=
 =?utf-8?B?NEpuemZzWlJzQndZV1FhWjlGNHJ1amFqSUxHbFc1QmpkckJWNnlZS1JEUk55?=
 =?utf-8?B?TC9IZk9OMW5TU1BCVENuOWRmZ1Z0NHFJN3NvSXpsUWZkVlc1bnc2Q2dDVTho?=
 =?utf-8?B?Y0VwTFovd1djc3c1dUthZ0RaQ2V1YVE4UEdsZ3czNWtwOEVnTlMycXFObmdv?=
 =?utf-8?B?bUJuUVltZ1FvYTlhMlhaYkNqKzYvRFVCMjJjRGZmK2puWEpLVGxlOFI5OVJk?=
 =?utf-8?B?WUtoS0ZVRnRSWmMzOUhTbEdDbTBBMDlwN2NJK0w4dmx1VVBRWWpOUlhkcXVP?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d338820c-397c-4075-6998-08db429436ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 18:14:14.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/2p/WCMEtc37AeCzZtHEZJAi1NuNHSfHfWVlEHYqrVVGAwwIl71zkY+bzvdmzbO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5597
X-Proofpoint-GUID: q7ExnEbQr10nb0EmFcpc4vPX-GjJU11r
X-Proofpoint-ORIG-GUID: q7ExnEbQr10nb0EmFcpc4vPX-GjJU11r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 11:05 AM, Peter Zijlstra wrote:
> On Mon, Apr 17, 2023 at 10:10:25AM +0200, Chris Mason wrote:
> 
>> F128 N10                EEVDF    Linus
>> Wakeup  (usec): 99.0th: 755      1,266
>> Request (usec): 99.0th: 25,632   22,304
>> RPS    (count): 50.0th: 4,280    4,376
>>
>> F128 N10 no-locking     EEVDF    Linus
>> Wakeup  (usec): 99.0th: 823      1,118
>> Request (usec): 99.0th: 17,184   14,192
>> RPS    (count): 50.0th: 4,440    4,456
> 
> With the below fixlet (against queue/sched/eevdf) on my measly IVB-EP
> (2*10*2):
> 
> ./schbench -F128 -n10 -C
> 
> Request Latencies percentiles (usec) runtime 30 (s) (153800 total samples)
> 	  90.0th: 6376       (35699 samples)
> 	* 99.0th: 6440       (9055 samples)
> 	  99.9th: 7048       (1345 samples)
> 
> CFS
> 
> schbench -m2 -F128 -n10	-r90	OTHER	BATCH
> Wakeup  (usec): 99.0th:		6600	6328
> Request (usec): 99.0th:		35904	14640
> RPS    (count): 50.0th:		5368	6104
> 

Peter and I went back and forth a bit and now schbench git has a few fixes:

- README.md updated

- warmup time defaults to zero (disabling warmup).  This was causing the
stats inconsistency Peter noticed below.

- RPS calculated more often.  Every second instead of every reporting
interval.

- thread count scaled to CPU count when -m is used.  The thread count is
per messenge thread, so when you use -m2 like Peter did in these runs,
he was ending up with 2xNUM_CPUs workers.  That's why his wakeup
latencies are so high, he had double the work that I did.

I'll experiment with some of the suggestions he made too.

-chris

