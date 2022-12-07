Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383A6645449
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLGG6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLGG6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:58:21 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A694B99C;
        Tue,  6 Dec 2022 22:58:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt/aXuc2VBjmC75CUe/nAxHDJBYmOJHpqsfz4yiAZ3hx/g59kJvTlHVUU6pzxwqiQwHE1BYrw4Qq2bu7UlrRDwZzQa1bflCWc3V30MiUaEDQ+g2w7R+jf0jXnzYmYeghkuVH8RqZ+I13ezsY0OtPbwILt/pzESai/CXigvRElejKs5Vnq2ThpEnau1+320O5w1wiNZiswmHqkqqSaStu76L5Q7F+L2dLVBkFkE+vxqyhNvFCbi7XAgmOMrpGxEl1l9jAcrCLP7/0I4gojoN6DKdjerhggH2o/9fygGSjM0F+egGQBKNofxVS/G7VGonUidfCgAus2pLK52SNE4tQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7J4kbdKBloK/TNJfSE4NfDolyISdwfJWcjviUZfsIA=;
 b=FXRjo76m9tw1rrWILyY0LCKg8w6H6zB9hS+EMFkVH14EBZpegvlFUsecDZld/YdbmsT7QJOeL8y6yZiteUCkx1dT8vxAAiasUmv8LgXZdwhiwAHVSofLscLq2ynOVyPPAf0DG3kpn5GiM3n947htWQ/0+qyU2Ayjl+EQWSQGMNZgT7v5kXRC82J+Uy9tifUtbNpy86OsWPcc90MyyAPIWywnJs52myboWcyN8/MmDpJWIU0PARznefqPnQ08k76s2/vevlscYm8RVMCWPfkbzN7TTpmfqhhq3Kt1X70dpyhTEnMNcfAdLkEMcomIGjH7cy4I+fJgukPEbESD33dltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7J4kbdKBloK/TNJfSE4NfDolyISdwfJWcjviUZfsIA=;
 b=Z9ZCNEurokZzVFN0jxFnKxoixPTd5OiCIVrIi0EEb0l43/ygTUR9RobNeqEZT+7BlhTqZNRy/EsE+k9z40b9H+TtbVld8Zh9RKxQo2wdQ88HpeiXGy0GB5ckTH2koer+yAj4ROQ8DmkNEVlUFbRwYcfrwwr8MRBrwJ5Nh1UQ1iM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 06:58:17 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 06:58:16 +0000
Message-ID: <6675c596-eeb4-3347-ec85-2bd67b970973@amd.com>
Date:   Wed, 7 Dec 2022 12:28:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] perf vendor events amd: Add Zen 4 metrics
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        jhladky@redhat.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
References: <20221207053007.336806-1-sandipan.das@amd.com>
 <20221207053007.336806-5-sandipan.das@amd.com>
 <CAP-5=fUS37Xqi1x2ZDj48saFu-g5dCvwqg8Vm0DF1V0vuq4tXw@mail.gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fUS37Xqi1x2ZDj48saFu-g5dCvwqg8Vm0DF1V0vuq4tXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::23) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b84b891-fada-44c1-975c-08dad8206abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCXFHkaOF+kfu+BmwA7s0pvnn//PMdlzc4WO0mol/ycSP1se49OVJK9OvpY2peMVI5qFh2ZB5sapUwr3HdoULj8gPyzFEANdVnQ4oLvSczFhzsZqVTT98ycB0SRTa/KIOvL/xeWazGcJ73rrtl1IVL9g6wdCGRYGXxrFAcyv1RO4U2JW3GG9ELSetkYuavicxODlX7p9jo2ia9QoubU6mG0F2nJzOFEqOdjNsQnSRZk3zMeS7RGXnz1gbL26QSlkub84IKBlA8y9Ovs5my4AHIl0xkJONBjvDfuqSQHvYd5Y4gOSNQ30PACvOUzSuaiLkzby6gsLdLY9CzrcGr/X7vCEMCOagzS/V/6f3Zz6rkqGhrSb+H76vqpDOiRkwNrq+YsB2ldqzF1NNkgEO6cY9VX7lkR6g6b0rh0sEe7kbeSN0R7M3UOQoZyKxd9Zn7G6Dh8BfysqmuvWIndn+QZGTsaE7T9wxcrfDMZT5ATUyz8BiP3ZlcT7z4qPq+mlkzl6xNbpZLTqlzQsrqNq5ISHjEvAteGe059/KtQ+RGREG6/7QNqDbJLwiX6pgzT3VuCxTpI4xRHscv+V3MzwJ46KErCYWRMDXrQRshQOcItxK3g3lT7MoNO3DEWUSdR1WbqOLPYBSe8o6877L3A7ifGNUTf68BHZ7Qe2Xzv7L8IyDkcPIh9uVvA3zG1lf0F0fC2pRCX0XoqtDZjKU+jsqCaw1lbbgAE9q8MxImVGwp1sI0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(6486002)(478600001)(31696002)(8936002)(44832011)(5660300002)(7416002)(6512007)(26005)(316002)(6916009)(30864003)(53546011)(2906002)(6506007)(36756003)(4326008)(31686004)(2616005)(8676002)(66556008)(86362001)(66476007)(66946007)(6666004)(186003)(38100700002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBNNHJ6ZTdUR0lmOGhSNWN3R09nMUlWVnZ6NDBnKzNhRlczT1h0Zmhlb0VJ?=
 =?utf-8?B?TEwzbStOQnR3b1Z2bXZjSkhNb1h6Rk5NMmZoL21oYVBTQlNHL1ZwQlptZTB5?=
 =?utf-8?B?S2hkUmZiOXlnY1ErVU1LdXJINnpycUdkcWJPZWE5WldLeW9WRUV1UW01cEhS?=
 =?utf-8?B?bWxLWmI3b25KT1liNVkrSHRzQVZkcitsbS8zc2F0bzVtbHB1KzhTTTZBd2Vw?=
 =?utf-8?B?S2dFclBzM0QzUEl3RkFSMmh6NVdFQVRIU2JEM2JCVEFiRnBLdmJia2VkMENn?=
 =?utf-8?B?YzRISHg4eFZBajdpV2tVKytaY0lOUDJNYnh0VndMNm53Z1J4OGVvQVlMaUlR?=
 =?utf-8?B?Nm5EWm1kUzVXbW1wWDdZclI1eHJYc0lIOEhRdVV6Y2g3cWxraFhubEorbXYz?=
 =?utf-8?B?UVBPZDNHUnZRZndBN0YxNnc2eGd3ZGpiWVZzWWNvZDlEMldCZ2g1c2ZaTXUr?=
 =?utf-8?B?NkJudzBPYTd2Rmw1aTI4K2htakcvQTBKeHByWk5jUnpXQ2dUK2crN0RlQ2lF?=
 =?utf-8?B?U3N0d3hYRElQc2ZWbmdyRWVld0ozUWRqdjk2MjZqbmZoNCtjOERRMmE0VXJM?=
 =?utf-8?B?Ym5VT2xMYmM4KzFNcmNyM081MmE3VUlQMHJSenNKZ3BKMnZOQlU3anRObm01?=
 =?utf-8?B?cmpOL1ZnSkRwcXA4cG9CMUg1VWZlWE80dlh6YVhoaXNSUVcvcVZUclU4eWRH?=
 =?utf-8?B?R1FCTXE0MEZleVJwWGtSRmFIUkpWMjAwTkRBRm1kTExiNEVmRGhIUkh1STQ2?=
 =?utf-8?B?aEFXYzJEVGNKdllERjZBb1p5b3BSQWhFVzBNVWpVQzk0ajBPWXROaDhEYkw3?=
 =?utf-8?B?ZVBNTDltWUpwNzF3S1M0d04vOTVPcDd5UkcyUUp4Q2Vsc2RtOWEyNTJHUURp?=
 =?utf-8?B?TnpYdjhMMzZudmNCeERodW9PVXpUeGJQNFdENEVUc0xVMGVSUVJ6QzFTRXZ6?=
 =?utf-8?B?RHhocDJHR0pNSllSekR4WUM2dExvU3pQL0JrL0l4SUIwTk9rYTJyc2NLUFdu?=
 =?utf-8?B?emNnaHRjVXdnOGhTeFZwRXVJNWl2ME9SbitvaHR4TzZRRmRVY0hPU3g5OFFW?=
 =?utf-8?B?WmJzNjQrWVR3cGtHZk5nOFh2ejJoVWJVUmozV1IrNjJtK3lPdDUyeXNBdFRB?=
 =?utf-8?B?ZFY2MDczekpQRER5WWNyM3Q0QlJONmNFS0NlNUlRb2w1MWRVTU1JaTJ5UW04?=
 =?utf-8?B?NjFsckFaTmFxNm9ETkcxNlBhV2RxMTk5OHJPZDlqWXRMcmRTeHo0TDM2M1pq?=
 =?utf-8?B?UGJRWmFVeUhFVDF1KythcDlwR1pFekZPK005TVNWeWJvdVhGWmsyNXk5RGdC?=
 =?utf-8?B?OFNRTFZKczU0ckg3ak16YVhXUUY2L1FOWUpqdkxtSEZQdExwNk45T0psSnFs?=
 =?utf-8?B?cW1lalRXMm41Nlo0THVVNnBJVDJSait0bnlmMENHTGhKdURsV1B3cS9oQyti?=
 =?utf-8?B?bFkxRHZDai9GZFNDNDI4RmxQeGlIajZ6YkVXVlVnbDByT09FU3N6WHpxQmdv?=
 =?utf-8?B?YXhqSmV2WCtCcFg4cStReCtCQ21OaDFyazlYd3ZoZWZjZDdEUWM3VDNjYUV6?=
 =?utf-8?B?S0t3b0xrd1NMelkvKzEvc1RaMWY5UlZsY2JsUmkxT0JSdDdHUkdPTnNTbS83?=
 =?utf-8?B?ZzV4OFFvdWtiSXdQVGNrUG9nblQvTU05T1NsQUlUTkxjbVJzT09ZTFB3YTgr?=
 =?utf-8?B?bkhjaERuVkdoSmc0ZnphM2hab1lBbSs1dHNXZ2s0Yy9FTXdMN1Z4OFdCV3l1?=
 =?utf-8?B?VmZTNm9oT2RCdE5sdkFBeGZRVHI3bU94c0sxelJhM1RsdEVYcXNjQ1QxalRK?=
 =?utf-8?B?TEc3N0ZNYzIyRE5EbnlzRDhZaEZJUnhqM3Z2RS9CRlU4VjJqMWxEblBSTkVt?=
 =?utf-8?B?YkRGY3ZPa2JWems0eDFUcGtaQ3pFQmJKbFN3QzlWcUt3czgrSk4vd0gxckpv?=
 =?utf-8?B?ZXF6dTZUaWR0UkN3UGV6bWtnSWZZVU9hSEFSaWN2MHlOTW55V2szRHZjZmxy?=
 =?utf-8?B?QjNraXU4WllaZjl4MC9yMS9jdlNyc1JIaFFRZWlYQ2NXaWVDbmtXOWJXZm9T?=
 =?utf-8?B?c0JJYWIwMElCTzk4OVVkUHhybEtZSnR3KzY1UForejF1SGY2NmxETVNCUGMy?=
 =?utf-8?Q?lg8ITmTtYeIGA0crkI6GIqnrk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b84b891-fada-44c1-975c-08dad8206abe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 06:58:16.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gfM3T54MD8crHV/yqmH8BCah8UYv8FDazaRBEDiJrA7muYnlwgZSETOL3JMYSDjX5fIgUI1RMCeH96SeN3Xpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2022 11:35 AM, Ian Rogers wrote:
> On Tue, Dec 6, 2022 at 9:32 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Add metrics taken from Section 2.1.15.2 "Performance Measurement" in
>> the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
>> Revision B1 processors.
>>
>> The recommended metrics are sourced from Table 27 "Guidance for Common
>> Performance Statistics with Complex Event Selects".
>>
>> The pipeline utilization metrics are sourced from Table 28 "Guidance
>> for Pipeline Utilization Analysis Statistics". These are new to Zen 4
>> processors and useful for finding performance bottlenecks by analyzing
>> activity at different stages of the pipeline. Metric groups have been
>> added for Level 1 and Level 2 analysis.
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  .../pmu-events/arch/x86/amdzen4/pipeline.json |  98 +++++
>>  .../arch/x86/amdzen4/recommended.json         | 334 ++++++++++++++++++
>>  2 files changed, 432 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
>>
<snip>
>> +  {
>> +    "MetricName": "dram_read_data_bytes_for_local_processor",
> 
> nit: Is "bytes" redundant in the name here? It may even be confusing
> given the units.
> 

Agreed. I can replace "bytes" with "mbytes" or "megabytes" for these bandwidth metrics.

- Sandipan

>> +    "BriefDescription": "DRAM read data bytes for local processor.",
>> +    "MetricExpr": "local_processor_read_data_beats_cs0 + local_processor_read_data_beats_cs1 + local_processor_read_data_beats_cs2 + local_processor_read_data_beats_cs3 + local_processor_read_data_beats_cs4 + local_processor_read_data_beats_cs5 + local_processor_read_data_beats_cs6 + local_processor_read_data_beats_cs7 + local_processor_read_data_beats_cs8 + local_processor_read_data_beats_cs9 + local_processor_read_data_beats_cs10 + local_processor_read_data_beats_cs11",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "dram_write_data_bytes_for_local_processor",
>> +    "BriefDescription": "DRAM write data bytes for local processor.",
>> +    "MetricExpr": "local_processor_write_data_beats_cs0 + local_processor_write_data_beats_cs1 + local_processor_write_data_beats_cs2 + local_processor_write_data_beats_cs3 + local_processor_write_data_beats_cs4 + local_processor_write_data_beats_cs5 + local_processor_write_data_beats_cs6 + local_processor_write_data_beats_cs7 + local_processor_write_data_beats_cs8 + local_processor_write_data_beats_cs9 + local_processor_write_data_beats_cs10 + local_processor_write_data_beats_cs11",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "dram_read_data_bytes_for_remote_processor",
>> +    "BriefDescription": "DRAM read data bytes for remote processor.",
>> +    "MetricExpr": "remote_processor_read_data_beats_cs0 + remote_processor_read_data_beats_cs1 + remote_processor_read_data_beats_cs2 + remote_processor_read_data_beats_cs3 + remote_processor_read_data_beats_cs4 + remote_processor_read_data_beats_cs5 + remote_processor_read_data_beats_cs6 + remote_processor_read_data_beats_cs7 + remote_processor_read_data_beats_cs8 + remote_processor_read_data_beats_cs9 + remote_processor_read_data_beats_cs10 + remote_processor_read_data_beats_cs11",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "dram_write_data_bytes_for_remote_processor",
>> +    "BriefDescription": "DRAM write data bytes for remote processor.",
>> +    "MetricExpr": "remote_processor_write_data_beats_cs0 + remote_processor_write_data_beats_cs1 + remote_processor_write_data_beats_cs2 + remote_processor_write_data_beats_cs3 + remote_processor_write_data_beats_cs4 + remote_processor_write_data_beats_cs5 + remote_processor_write_data_beats_cs6 + remote_processor_write_data_beats_cs7 + remote_processor_write_data_beats_cs8 + remote_processor_write_data_beats_cs9 + remote_processor_write_data_beats_cs10 + remote_processor_write_data_beats_cs11",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "local_socket_upstream_dma_read_data_bytes",
>> +    "BriefDescription": "Local socket upstream DMA read data bytes.",
>> +    "MetricExpr": "local_socket_upstream_read_beats_iom0 + local_socket_upstream_read_beats_iom1 + local_socket_upstream_read_beats_iom2 + local_socket_upstream_read_beats_iom3",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "local_socket_upstream_dma_write_data_bytes",
>> +    "BriefDescription": "Local socket upstream DMA write data bytes.",
>> +    "MetricExpr": "local_socket_upstream_write_beats_iom0 + local_socket_upstream_write_beats_iom1 + local_socket_upstream_write_beats_iom2 + local_socket_upstream_write_beats_iom3",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "remote_socket_upstream_dma_read_data_bytes",
>> +    "BriefDescription": "Remote socket upstream DMA read data bytes.",
>> +    "MetricExpr": "remote_socket_upstream_read_beats_iom0 + remote_socket_upstream_read_beats_iom1 + remote_socket_upstream_read_beats_iom2 + remote_socket_upstream_read_beats_iom3",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "remote_socket_upstream_dma_write_data_bytes",
>> +    "BriefDescription": "Remote socket upstream DMA write data bytes.",
>> +    "MetricExpr": "remote_socket_upstream_write_beats_iom0 + remote_socket_upstream_write_beats_iom1 + remote_socket_upstream_write_beats_iom2 + remote_socket_upstream_write_beats_iom3",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "local_socket_inbound_data_bytes_to_cpu",
>> +    "BriefDescription": "Local socket inbound data bytes to the CPU (e.g. read data).",
>> +    "MetricExpr": "local_socket_inf0_inbound_data_beats_ccm0 + local_socket_inf1_inbound_data_beats_ccm0 + local_socket_inf0_inbound_data_beats_ccm1 + local_socket_inf1_inbound_data_beats_ccm1 + local_socket_inf0_inbound_data_beats_ccm2 + local_socket_inf1_inbound_data_beats_ccm2 + local_socket_inf0_inbound_data_beats_ccm3 + local_socket_inf1_inbound_data_beats_ccm3 + local_socket_inf0_inbound_data_beats_ccm4 + local_socket_inf1_inbound_data_beats_ccm4 + local_socket_inf0_inbound_data_beats_ccm5 + local_socket_inf1_inbound_data_beats_ccm5 + local_socket_inf0_inbound_data_beats_ccm6 + local_socket_inf1_inbound_data_beats_ccm6 + local_socket_inf0_inbound_data_beats_ccm7 + local_socket_inf1_inbound_data_beats_ccm7",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "3.0517578125e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "local_socket_outbound_data_bytes_from_cpu",
>> +    "BriefDescription": "Local socket outbound data bytes from the CPU (e.g. write data).",
>> +    "MetricExpr": "local_socket_inf0_outbound_data_beats_ccm0 + local_socket_inf1_outbound_data_beats_ccm0 + local_socket_inf0_outbound_data_beats_ccm1 + local_socket_inf1_outbound_data_beats_ccm1 + local_socket_inf0_outbound_data_beats_ccm2 + local_socket_inf1_outbound_data_beats_ccm2 + local_socket_inf0_outbound_data_beats_ccm3 + local_socket_inf1_outbound_data_beats_ccm3 + local_socket_inf0_outbound_data_beats_ccm4 + local_socket_inf1_outbound_data_beats_ccm4 + local_socket_inf0_outbound_data_beats_ccm5 + local_socket_inf1_outbound_data_beats_ccm5 + local_socket_inf0_outbound_data_beats_ccm6 + local_socket_inf1_outbound_data_beats_ccm6 + local_socket_inf0_outbound_data_beats_ccm7 + local_socket_inf1_outbound_data_beats_ccm7",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "remote_socket_inbound_data_bytes_to_cpu",
>> +    "BriefDescription": "Remote socket inbound data bytes to the CPU (e.g. read data).",
>> +    "MetricExpr": "remote_socket_inf0_inbound_data_beats_ccm0 + remote_socket_inf1_inbound_data_beats_ccm0 + remote_socket_inf0_inbound_data_beats_ccm1 + remote_socket_inf1_inbound_data_beats_ccm1 + remote_socket_inf0_inbound_data_beats_ccm2 + remote_socket_inf1_inbound_data_beats_ccm2 + remote_socket_inf0_inbound_data_beats_ccm3 + remote_socket_inf1_inbound_data_beats_ccm3 + remote_socket_inf0_inbound_data_beats_ccm4 + remote_socket_inf1_inbound_data_beats_ccm4 + remote_socket_inf0_inbound_data_beats_ccm5 + remote_socket_inf1_inbound_data_beats_ccm5 + remote_socket_inf0_inbound_data_beats_ccm6 + remote_socket_inf1_inbound_data_beats_ccm6 + remote_socket_inf0_inbound_data_beats_ccm7 + remote_socket_inf1_inbound_data_beats_ccm7",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "3.0517578125e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "remote_socket_outbound_data_bytes_from_cpu",
>> +    "BriefDescription": "Remote socket outbound data bytes from the CPU (e.g. write data).",
>> +    "MetricExpr": "remote_socket_inf0_outbound_data_beats_ccm0 + remote_socket_inf1_outbound_data_beats_ccm0 + remote_socket_inf0_outbound_data_beats_ccm1 + remote_socket_inf1_outbound_data_beats_ccm1 + remote_socket_inf0_outbound_data_beats_ccm2 + remote_socket_inf1_outbound_data_beats_ccm2 + remote_socket_inf0_outbound_data_beats_ccm3 + remote_socket_inf1_outbound_data_beats_ccm3 + remote_socket_inf0_outbound_data_beats_ccm4 + remote_socket_inf1_outbound_data_beats_ccm4 + remote_socket_inf0_outbound_data_beats_ccm5 + remote_socket_inf1_outbound_data_beats_ccm5 + remote_socket_inf0_outbound_data_beats_ccm6 + remote_socket_inf1_outbound_data_beats_ccm6 + remote_socket_inf0_outbound_data_beats_ccm7 + remote_socket_inf1_outbound_data_beats_ccm7",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  },
>> +  {
>> +    "MetricName": "local_socket_outbound_data_bytes_from_all_links",
>> +    "BriefDescription": "Outbound data bytes from all links (local socket).",
>> +    "MetricExpr": "local_socket_outbound_data_beats_link0 + local_socket_outbound_data_beats_link1 + local_socket_outbound_data_beats_link2 + local_socket_outbound_data_beats_link3 + local_socket_outbound_data_beats_link4 + local_socket_outbound_data_beats_link5 + local_socket_outbound_data_beats_link6 + local_socket_outbound_data_beats_link7",
>> +    "MetricGroup": "data_fabric",
>> +    "PerPkg": "1",
>> +    "ScaleUnit": "6.103515625e-5MiB"
>> +  }
>> +]
>> --
>> 2.34.1
>>

