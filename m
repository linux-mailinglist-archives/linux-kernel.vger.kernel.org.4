Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3803A6D3BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjDCCnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDCCns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:43:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC1AAF32;
        Sun,  2 Apr 2023 19:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpO485TY/rzyQgMlod91Stx6mZ2FnHYwIgFedoDolgpVTe15dC0mFwaczggQD9uhbI4bpeUYaZblXZruM6ZKe6Z3lfThepZ5So14isYFWM67Ksd4pVVhC6fB3STaF2JqeTgh8CKHgaVH3Rc+boysrzndc1zgBRNfCQ8mxfTQjXzmPC9+y245bDcqGgrX4sNJecCgBSsPpvuOiU8uLb3RZtGR58vaj/UbNQFs8VIo6DE8kF8vffTPPrmrRdl2RvU47V0vhqNXrqK7HIgIoMXnGZCS3k2vuP+UvVmCiFiaGkQ9drUH8HvLvFxxF4Nl5ohJkPFlmUpZKucBtvwSFMVsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuvtyXjllqPSMIwD54SP3BYNvDs4ze78uQ8DuukkwaU=;
 b=Wq5u1+4RNI6uRJtZCmbxn0hbuoQg5ws7Y/HVCB3NFib8DJr7aX3elIO78T3l7L+qb4NkULaun6mmczJCYZD+jA4FtFh9yQcBrTr488X1WLjTfy63pdfvHEclebiidixeFCydXvd6r2+SULH8dD+RCd9xQgomQrQM/KMhK4nD5pNzJO7nJLAgWROJP4vCDRHDX7qvD13bDhAy6vXc52Zo8YWA4IC3EjBmnhoS002xeQIVbCT4X4+xJ0d2uDx+yKCvBVPFVLv9PXUaxCtP6jCHeZ7prUtrWnV/PGXnhA8VC6yJLOSOK9JyPDsbcm3lHPu/eVrTnHYfNtvv+SU/8wshNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuvtyXjllqPSMIwD54SP3BYNvDs4ze78uQ8DuukkwaU=;
 b=zDQPQ1UFabg4SQqTd7TheSGMlcvgNzOxVw+/oBbHt/4AzbrX8OawGOCU7ZHy9nb3nwDBQg8pwp4XaSQda55S8CGMEYmOTxacis/lTMpPwVCYGwxXdDH0aCyuPNFZbk+kaIXy/r50kF6OY4c8esf+A8NECj6pizclNjyQMfw8tqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 02:43:44 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd%3]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 02:43:44 +0000
Message-ID: <ea3ddf8e-1809-1211-7ac4-d7175dbb4e08@amd.com>
Date:   Mon, 3 Apr 2023 08:13:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 1/4] perf: Read cache instance ID when building cache
 topology
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, ravi.bangoria@amd.com, sandipan.das@amd.com,
        ananth.narayan@amd.com, gautham.shenoy@amd.com, eranian@google.com
References: <20230331045117.1266-1-kprateek.nayak@amd.com>
 <20230331045117.1266-2-kprateek.nayak@amd.com> <ZCbKCwJDf3PrjSLH@kernel.org>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZCbKCwJDf3PrjSLH@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::30) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4e8b6d-cd6e-4a2e-0097-08db33ed3dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJ/Nxrp1YZ/zCjqULJVreoNqF/2hSRMzo30lOfr9uJUb09k0Qd70YvY6I4M+rKKmQscpAKwg0tlecNcyFvO1ufErHBVKXQB83nPe1til3lUAQ6kgCQaeoxcg8ovvy47ANzJcuJUgS1zyJL/cjalHMMQGWIxYfYQB7DrilAkR6toDSpnyF/bMYJ5ruj8Y4FMGrH/tIfAR7xRZzfSOaxyzEIjfLP06oA+8Z/zht2obvYZM8ex86IxS/rfPKhMIQkIyvBi1aCI7NGNaRRafYBGxHR3eebHlmGgSFDfEhnu1cmTxVd32RaCNkdqbVzmYQB+PMYC+1B2n6tMLG4iX+GLhD8zLKxbylxfuyAbUVw96Cv4fqBJerVgf3jbikRuGEDQNm0w2n0JStsL2mJaOexdQwWzZHNF4dloLNHKPoSMs57vI71TSi4tKi9u5Vu6ZlKfhDU1OUvKge3o/vYuFAJ23IjU5GATSV2MYBkhZSmwNB/FoHkX67P/HB+5Rc750HxTIJnF/4fjeSc7UqEhrisw8rz+mGQBExXKu2w4l2muSeirT0m1I198v7UmS20Pwrw+gHZjUmjGxqnhFTm8OTiAAtiTf7UKR5TQUUCHV1JNT4spKXfGHPpffnHl+8ueRIITUWMpHE9SqAkoLDvrUVO+XsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(6666004)(36756003)(2906002)(4744005)(6486002)(31686004)(41300700001)(6916009)(4326008)(6512007)(6506007)(26005)(186003)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(5660300002)(316002)(478600001)(2616005)(53546011)(86362001)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEY5akgrWEp5bExTVTBCZmh3Ync1MDhoWU9jeVArYmU3UDNhU3RmUm1tbWxL?=
 =?utf-8?B?TVBzMlNha2lHd2lySTUyS3lVUS8vdmRVYjV3UGxPSGVYODNNUjlMNHI0dk5R?=
 =?utf-8?B?ZzBWWExaR0hNN0ZKUXlTdjV2aElMWFJrS0FreDV2bmlCbnY3V0ZmMFNveGh0?=
 =?utf-8?B?Q1AzOWJsVDByVlVhYXYwU3NUS2tlaW1MZVNETFZUenhFeHlLY254OVZ2THVx?=
 =?utf-8?B?SEVlbHZUZ3JYL0V0bEFRbGpuQ21JUGFzaXpjMnlRakFiUGhlTG1GWnkvV01K?=
 =?utf-8?B?RDFCRnhXRVo3c3E2aEM5SkowY0NnblBINFQydVpRUGc2aW1zcXd4SHlBYjhx?=
 =?utf-8?B?Y0J0TExJN0daQnN0S3puMXFWRHhhK3lhNmQvZjJwR21aZ21GL2IyVEpRcVRD?=
 =?utf-8?B?eDd0U2oxVUZGdnlkdi9UV3FaS2VCZFkyaDNmcEN5MTExSlRjZGRZaXJkNEVG?=
 =?utf-8?B?Z2hlZmhNeFRQcE92N0M2Y0hzQy9lQ3ZFak1FU1JCa0kwMEswa2hVeDRJNkNk?=
 =?utf-8?B?SlV0bFpKTkpSRUpPaVBUb2c4alJBdHplR3lxL3V0VXlMWWNLanRCdFNLMHZG?=
 =?utf-8?B?aGpXQnovQ1RIR2FjSUpFclc4dGg4Z3grYml3MGs4NFE1QXc2eTltWFkzTWdj?=
 =?utf-8?B?TUszR0NYREV3QmVWUVlOZmVvY0xicjVsakVpWGhhVUNaazFaYkRHU2hCSXA4?=
 =?utf-8?B?RmxMSmxzVnpiWWdyODM4QnBSMjkxWE1YLzlheHhOWWZNMmVXanNhcmE1UVgw?=
 =?utf-8?B?dkZiSWx6bFA0TXRPMVZxK1JNK2FORVdkS0trdDNSTUF0T3BwQ2ZpTHBJd0d4?=
 =?utf-8?B?SHN2ek9pYjRrblRqSC9JQy9CazB3T3RKTzdnb1RJR3FMdzdZYWRvK2VEeXJa?=
 =?utf-8?B?d0hJZEZ2ekN5RlZvbXpPbjJTY2pEZDRESC9NTDJ6NGF4QmJER2J1MVNSQ2Zo?=
 =?utf-8?B?T3phVm9YMTBLTnA4SEZwRlJlNXpGRkMrZkwwN2xZRjR4ZjRUYUhoMHBtT0lr?=
 =?utf-8?B?R3l4WWQ2V05BT1ZLNXo2NjhCek9zekFTWXk5RUtubnFIZDJWcXdOOFNubksy?=
 =?utf-8?B?cDVSRlBEQ25VeUpTQmRETE9WT1pnb3JmcGNUOXlDSjBQNkFvcE5Ga2RIb3lv?=
 =?utf-8?B?UXR3TmlSUjFPZEJ2YjVvZXJ4b053R1psckRnc2hQTys0SzhvM0RjTEFhZDNs?=
 =?utf-8?B?VmprL2luK1hXcmx5WE5lcUt3T0dPMkJ0V0cvRjJwMmZ2cGhBQ3JNa3I4QWdQ?=
 =?utf-8?B?L1A2TFRWSUhlTlBHTytnOUdIR2FvSkRZRXdHUUFTSUxRY0pscUlEQWIvY3Zr?=
 =?utf-8?B?Z3RLYWlzNGxKNTVKbFB6Njd2ZU14SW95M0xWQWJ2clFxV2Y5bnNQYTM2TWE5?=
 =?utf-8?B?MTh3Wlh6UVdSWEdhbjRtMGhkYk4rTUhNTlBYZm81ZWp3Ti8rN1VBNjVMUUwx?=
 =?utf-8?B?N3JXWTVLdzNObm41M2FJN0lYNE8wemQvUjhpcVVWQXAxajRhSExiZ2ZWTnZr?=
 =?utf-8?B?djVLU09LL01JdUN4cVJOSFB0TFFQOE9rZk5BNFVvQk5SbXAvcWlROWR1bmM1?=
 =?utf-8?B?WW5IR1UwcUpwcC9OUm10RHZjSUEvd1E5cTQwT2lRdUxXTzVNcURDbDJrUzUw?=
 =?utf-8?B?WDZqOVAya1pGUUd0U3duOFJVQkJMY0wwMVB6c1I1aWIvbmNVT0tLelc2aXRN?=
 =?utf-8?B?U0hYYWNuZ2RxZWRDUGdpY1JDYXRPWDE3QTIxSHIzQ3JVd2dKR1UwZnhGNGx1?=
 =?utf-8?B?QVIxY29jdkNYZkZ5WFlrVVYreG9GNEZTZFpYdEhiRC9CL0VianMwYWtiVjlr?=
 =?utf-8?B?T3o4eVZadTBONnhyWXdCKytuUHg4OG1zL3RObEZicjJiNlF4VGI4eElNUzlo?=
 =?utf-8?B?SHl3cVRobXNZQWgyR2FJZGxqQ3A5UWRkazdqTUV1RWJKa3djaTJQWkhIZjQ2?=
 =?utf-8?B?cDQzc1grbTlPZjVpWWJMV3Rwd0cxVHRJZlFIRktPTlphaWdidjhvM2Qva3FR?=
 =?utf-8?B?UlcyeFNVZEp2ZUZ1NUdmTEt3b0xGVkNzUWh1eG1tYUFIdVFqLzlFaGxjbjVu?=
 =?utf-8?B?Z2dsOG9adXBBajF1eHlFVDJEYjNPMnZTaCtSQ2FwajFNZ2o3ZTM3M1o3N0k2?=
 =?utf-8?Q?AaTZJtCdXH2wkaT4+bOP75nAg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4e8b6d-cd6e-4a2e-0097-08db33ed3dd8
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 02:43:44.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1i6P9DVBq6kpx5NM749hQgJO8R7geuLOsNQGwb0KHSIqIrx6Wk9MWLAa0fDwVa1pqr+4UYH2Qpx01nZA6p45+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaldo,

Thank you for taking a look at the series.

On 3/31/2023 5:24 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 31, 2023 at 10:21:14AM +0530, K Prateek Nayak escreveu:
>> CPU cache level data currently stores cache level, type, line size,
>> associativity, sets, total cache size, and the CPUs sharing the cache.
>> Also read and store the cache instance ID from
>> "/sys/devices/system/cpu/cpuX/cache/indexY/id" in the cache level data.
>> Use instance ID as well when comparing cache levels.
> 
> And if a new perf tool is used in an older kernel without this new 'id'
> file?
> 
> Please check if the file exists, if it doesn't don't fail, just
> initialize with a zero, this way the latest perf will be usable in older
> kernels.

That makes sense. I'll handle this case as you suggested in the next
version.

> 
> - Arnaldo
>  
>> [..snip..]
> 

 
--
Thanks and Regards,
Prateek
