Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7A46F532E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjECIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjECIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:34:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E94C09;
        Wed,  3 May 2023 01:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhXsBgrNSEi7+OqXdKFjvAIXqCJPzf1/AK+09kTqD/GSmwZ1RoLQ9i2/cVMJf+nkbeZc31xmGWY0gjktg9i4VMDE4zS6Mokne7eSLjsflKuMF+XsH6YVAEeVQ2xQu/iqBJ3SZ5hxSczT0K+oWIGBbBclQVZrZE/Ci82TacfSjvsG+L0rVfro4NWDqOAXb+hs5abYgHJsPi2Qfp/xs1TbDtWmcahFvlC4JRzunvvNQ6ryQ75m7iVf38cskiNIR2LFRi8BhWUZ0JN+sg0dAU1JxQvWQDAeDCUhpAv31ys3ErXiVLB8Pi52A8xIQdBTs3H7k6L8fpgG0QNyNBXsw67+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25K0RvwUoJHFSOTQXe8M+KWpcc5u+CP4/3YYkxoK9sg=;
 b=VOQ3B5w+Eldodjqkh7l84jMzD4fdydN7vSSA13Lh0iwuoi/H96DjnUvLVf4cqWew8kTIwXqAQLkGOPakZIsPwjMtqQ+ztavVp0yNR9OwhcxpJNCHvz1UqWzpuSKUBOe4F4GxZrW0j7fSxGuW0nTvPZaVL/TFe+ML5afAlEYpy/TgMDbGa/ehfXQhpHvHHdybWpxxlwVz6Vt6RSTyOHHiHM4IgOsYJS225ACn5MnfV+poBebD0LC31vT7sEGT1uiUuze7HU/91gS4/DYIj9qCOp3pe5at8c7QKgB4l/VreGmWA6wnhkaO7HBsNvQgKM11SwTHwOlWnMjI/ZZBkbP+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25K0RvwUoJHFSOTQXe8M+KWpcc5u+CP4/3YYkxoK9sg=;
 b=ctkQIXcMAeXXazLJjWdfbJtGkru7ZFCcD7oMP8QsAJMG2FWhqnEG0ypEXJuIW1oqW9loHJHsofYTlau5cti7jalx7E6AI4/LmwGYeizEpH4nHo+eGSOElQKxeM2CHVolzA+mW02WIkgErWSzZcID1QTJ7uwYUEhhc45pEcTj074=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 08:34:09 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6340.030; Wed, 3 May 2023
 08:34:08 +0000
Message-ID: <0e9baf9a-444c-99e7-d40e-d1d228e21157@amd.com>
Date:   Wed, 3 May 2023 14:03:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/3] perf/ibs: Fix interface via core pmu events
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     namhyung@kernel.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, kan.liang@linux.intel.com, adrian.hunter@intel.com,
        maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230425142205.762-1-ravi.bangoria@amd.com>
 <20230425142205.762-3-ravi.bangoria@amd.com>
 <20230502153701.GF1597538@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230502153701.GF1597538@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e5bd44-f85f-42c4-48c3-08db4bb129ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BQUJUdyvh/RhPFhGDGZzwTULWdn51RPsuTzM+KrLYvsNpKs737xi/POo4mTOFZ/fLj/u4URPoURB77z2IgJdEMPwRFpNvH85I0RXuTp+bsw19M4pARFOsNBt1RPvk1An+jmuNlwLKKRs/3ibfBSXLFU2mdxd8UG22ldvFcHRE4i2MAUDhmcvaeUCZYTT+LYKUuUsjN10AKnIXOOT9s8Mz8HMqPAeB1IBY1uP+w4ZzEXqMKaGUPjTyJgXxEBO7mMcf/DDdjD5SOOfAoMnvw0cwyu3LCjSdwAFRslU3ufwNggrhySmYe2VcEiEIfq3B3HOiIEFuCVF6msJpaj4f7ujOGXsJzKN6b/mLwpAV+YmPmiujXdEwApAqUCbtd0euMm26DNsGkRcqjCKvLxIf3RW+nM6dD3OrmTJi+zTsb+DHuRp61t1DX8TQ5g90+d7H9QAiewj2O+t0QKOD+nCdAIcgIocOEQgli+woLXGjmr+u76hxnG+StvjWSUNd2OrxNusWM+rXpwQLR8HJjV4S6//Ue45vVCLYcL3QkfZU9lFzYYIjSyDMMO5DOA87DPVrqcOrfESqae6G5H70YlOlaZfXo7G5KhbZGv02NA4BDCP/bcwrfg9vlpVv6QSCAtJYUp1HtB2GI5ok0Rdo69zSS3rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(2906002)(4744005)(38100700002)(83380400001)(2616005)(26005)(6506007)(6512007)(53546011)(186003)(36756003)(8676002)(8936002)(5660300002)(44832011)(7416002)(86362001)(31696002)(478600001)(6666004)(6486002)(316002)(4326008)(6916009)(41300700001)(66476007)(66556008)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak4yWGpQQURZNVVYS0lQRzdRUUJNY1FTa0xZSDIxdytjMzcyQ3c3cVVIdmZp?=
 =?utf-8?B?Wm9uMi9mZXlUd2RaV2d3Q2dVVDlXMlF6VlBHVFFhWHZ3MUhidk1EMHc4NXla?=
 =?utf-8?B?bEI4QUdNSzg4QUorZnFQblQ0aGJLSW9Va1RTUXNFUWc5UWFnZVp2STNCSlE1?=
 =?utf-8?B?QTg4OWphdUlxNmZ3Tm9EMzB0ekVpL0ZIamgwMzhTVnNZeW02SENRS0p4L1Mx?=
 =?utf-8?B?LzlCVjU0dVo0SWwzaXRGaHBReE1WS2VyNWVrTTliRjIrZEhyUzcrbnFNSkFY?=
 =?utf-8?B?dXJFYS9QM3lrYWlVU1JFSVBrRzVzRWVyYVBYYnBGQ2laYVliN3VEVnRVZG0v?=
 =?utf-8?B?aitTTkx3U1ZHaTVUTS9GV2RHQVlXM0Z2TUlyVHBIak5zOE03NjFGN3g3emFJ?=
 =?utf-8?B?c1hOUWt5elhnWTR6U2pySVYwbk5wc1E4T3IwL3FhREZULzZkL0I2U0labS9u?=
 =?utf-8?B?SmhadGZBNUpzK2F4Nm9KQVZPOTZsWndsNkVFSG5kOTRpKzFtMVhKVmhhaFRW?=
 =?utf-8?B?YkZnWHoxSEVuaDN1TFJaRW5mSTExY3Fub1o4V29SZDYwSnp2TzdXYnJtdVA3?=
 =?utf-8?B?Z2hUWGJkbFd5V1hpcXA3ampPMlM5OXBMRDRjeTdla1RKU21JYm5vYzNJMlhY?=
 =?utf-8?B?WUtrZWhwbTNmbk1KM21DZjJBanhKMzN5TzZsS0c0ZXFaaXd0MmhNcFV4MkhY?=
 =?utf-8?B?eHVyZlB5aTJSeGRCaFMzdThDOWNaaHFGNXV2SktXZ2pBUHVJdVcvd0QrbVZR?=
 =?utf-8?B?ZWszL3REejYwQ1VMUWVIeXR2Ni9SaFY4aFFUVUhRUktENHVSVTI2TmdmZnE3?=
 =?utf-8?B?UWVXbE1leG9Nc1kvSnJKNHJqMHNoUE8vKzRKanRFSVgvUDZ0aml1QVJndkQr?=
 =?utf-8?B?L2J6SSs5dGVwUXZ5SFpES3BjcFE1QjI2bUw4ZjdvOUY4OFhsbk1Rc1h0QStX?=
 =?utf-8?B?cGk4TEJsTkJFU2dSU1RMSGgvZnRad2J4UWdvYWRNcm5nZ1pNTC96U0NMaG1n?=
 =?utf-8?B?RDc3NkhqYzZEL1JsaFhiWHNJODRxRU1wVHFvbzFtb3ptSkEvdnNOUVMwN3dz?=
 =?utf-8?B?K1owNWJqOTIwYTB0NHVhNHVwdU9oaFRkSFcybStYU014SjAycnBrMm14cVB6?=
 =?utf-8?B?WTRBdUl4N2djNEhWazRBTkkzMnUwZ0c5TldmUGFHaklBaEo5UjNRSzIzS3lQ?=
 =?utf-8?B?enVUYVk2UExJR2JKS0wwZ0hXaTJ5S0FtZ1c5V3ZEMEVUMnpkU29EdGg5M095?=
 =?utf-8?B?WnNMVkMvWlF5ZndHYVFpbGZGZXBBWXMzTEM4bGU0TjBiNndwY3ZEWis5bkg2?=
 =?utf-8?B?MXNSTWptbHNibGNNMW5LSFc3Y1Y3QnpxQ0RkT0RCYlcvY3VGb0oyWW1tTWlD?=
 =?utf-8?B?Z0J6a1RpS2pYa1lQYUtOVXBMMUNETlpnVGIxdHhhTkdaSEJWVXBRcGhDMFIz?=
 =?utf-8?B?WWN0RTV5OVoxeHR5SUFFeWJGSUtuMWk5R3VONTBJalN1K3VicnZWWStVUnAy?=
 =?utf-8?B?TmthR1IyWFhnUVlMelVPa3NzcFZvRnF3emUzT2UzZWF5RGZuRlRkWkNwbjli?=
 =?utf-8?B?SHRaRmJCbC9qV0FHSzN1TEUzcWVGZmsrRmdDTW5DRHViSUloR2x3OFVtUzBJ?=
 =?utf-8?B?STlEV2FsYzVubitZUHlGTEdzZnkwZ1VUekMxMU55VkF6Z2pEWW9hK2M4a3p2?=
 =?utf-8?B?VDdUTFdEMDVJOExqYUg4bkRNU0daVkRJK21DblVmVUdPd01VRTBsbUQvdlIx?=
 =?utf-8?B?bEZabTJMek5DMm1CNHc4NTNoVzdKK1ZCeGZXWEtLT0JlSi8rS05lbEpjQzU4?=
 =?utf-8?B?Z1BZcFZ2OXVGdFQ1TTh1NkJnQllHZGp1RFRnemV5UTBOZWFKNmFPTjJRVTV2?=
 =?utf-8?B?UHk1Q0ZaOCt1RVdPMTJRQ2lSdHF0em13K0YvVmtpSnhxQUtXc2M4c3RGTml1?=
 =?utf-8?B?TEF4YjFjRkYxQmtCczZmWlA2YUYyMGl4V3RQSUdrZmNsYmNQelNHc3hkVEYv?=
 =?utf-8?B?NjFhb3RqNk9ZM3dvMVdhc0dnNDFCWHpGMzU3RlVKNGtMVURLZzM3eHF3d0hu?=
 =?utf-8?B?Yy92RTNOcTREVGhsRTF2dEpPNmpPaWdlNGU2NVVLaGZPNms5SkJXSnBxcllT?=
 =?utf-8?Q?51ky/0nN6l5Q9Sw9gyC7WBNPv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e5bd44-f85f-42c4-48c3-08db4bb129ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:34:08.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: to1PnOh5JML2Q2Js1eJ3Wl1EsFbiuw/KWmMi+qQYbZ4VG8rWOqcUEGkMQRwFV8OLlX76Eao9SHA5x9aXuGeUkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-May-23 9:07 PM, Peter Zijlstra wrote:
> On Tue, Apr 25, 2023 at 07:52:04PM +0530, Ravi Bangoria wrote:
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 151299940d9a..232121a6d1e2 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -11648,16 +11648,6 @@ static struct pmu *perf_init_event(struct perf_event *event)
>>  		goto unlock;
>>  	}
>>  
>> -	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>> -		ret = perf_try_init_event(pmu, event);
>> -		if (!ret)
>> -			goto unlock;
>> -
>> -		if (ret != -ENOENT) {
>> -			pmu = ERR_PTR(ret);
>> -			goto unlock;
>> -		}
>> -	}
>>  fail:
>>  	pmu = ERR_PTR(-ENOENT);
>>  unlock:
> 
> Would it make sense to put the above and the below cleanup in a separate
> patch after this?

Sure. I'll cleanup and respin.

Thanks,
Ravi
