Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6475F03E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiI3EwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiI3EwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:52:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B9032D9D;
        Thu, 29 Sep 2022 21:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL1M9yeW5Qks43OSnkvl7qZZB44fnIrppwy/AHENdGcQ9s7266Ga/3BospSwTOjOd9zmiGIdyi2Z/BSr5iwwuED5r7an4QlQ+VRKsNwyBCJjAjEyvu+RD8OASlL+AZMwyeHd/5iGQy9Q6uPEQHHtf3zvyTWPVokjD9e9YU97tV/LY6paCYHBhiCaANu/vZQhm2tgvu1S/OdIQB3RYkrlpSAJtwbbNPWuSe9+zVkCbjL92gLanhamJRNxUAodSI+fKqTi4WFwtf40v5/uQqSQlXdzApacpzr0yJDJBTMBiGeUZnK9XCbY0OXOqL3rn41xQSIHRE4CL2QV+ccRiiaK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+fdwse1UGN6VJqPMwSv328Bfn1lIyCxGwKVebg+Z/Y=;
 b=SuiPQ/CNFqqBfHBzG0gUJhPk2roFSPBPnw8M6/PRbeI80r/f0Uo30kotL2C7JV56smVymmjULvfeITTQTM+bExHHtG1T1slKOhvRANpOLpSsrKsM73WLq94cotpP66v0lyBfQ0gUktkrXNqbYbmubiHj/GtUL6gdkTJsz4TrQOZ5C4+7bB6eXU5J/ukowJ0g94pPiAEN25G4T2LICvqt1q7QnHhPyh/lMvht2tRDFjvp0cPlKW9NGeFfU9Rzt6oRD7fxSkMPfyLLuAKxUQQmm4q7Mw2DoVQn6komC978FE/Kj10ivby07ke7TioO3GuAp9SETzCY99NWZEYwjYwKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+fdwse1UGN6VJqPMwSv328Bfn1lIyCxGwKVebg+Z/Y=;
 b=lavr/gf2tkFnpOPfu5D2rcN+UjVL4moHYo6Pd+sL7N4Iulo7TG6kX3wZvSSIy51ZrTK8qbN7vMf6A9QOkXqR7+Kr6srqSKNNK3aj1+U0kNF/xxWjtn0PwScb/iSPDeBXp+Ate87hKUwK3uQJF7D+/p+8I8RkYN0sZflzPdeEhvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 04:48:53 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b%8]) with mapi id 15.20.5654.025; Fri, 30 Sep 2022
 04:48:53 +0000
Message-ID: <aa91fc2d-319c-bbb2-d011-e60f7c04d776@amd.com>
Date:   Fri, 30 Sep 2022 10:18:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 02/15] perf/x86/amd: Add IBS OP_DATA2 DataSrc bit
 definitions
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, alisaidi@amazon.com,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-3-ravi.bangoria@amd.com>
 <CAM9d7cjVcGLn+dmajox6ASxx=YQYv9Viv+wzSXdaqCEJrow56w@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cjVcGLn+dmajox6ASxx=YQYv9Viv+wzSXdaqCEJrow56w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 480da829-c682-408d-cefa-08daa29f12cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TODWaF0xjAf6sxl0YjgZ/QP6aZqzBUZLrDyuhFAOsIKjTtLr/gTpYMfyxjySiQ+FxVzuAPqfciih42OYFdCrHhnYeEntQoDFburDOegrWNvr8btVDRLEGm3H00k3KuUtxWQ9/ANtEXOSF7ei91DxI5Pxo7tl/r/bYZ8tQKKUnDqzAUyiBscmLqx0/Oup4lk8PRhlRSN99dff2s08Pb0pVDTuh3HrzVDWeUSlNbKQaEUqHz+fsw2e9Esas47kUTAL6bQWyrVrboxN5KlQds1CsiVnwyll1q8xSPRRkvRWbwAqgFKclhSFtE5nYcfsoDDnlMHSW5qEPQXHEkspkSCledef+iQoFhTiAiap+jqX6ffCBuynboeHYT6fZsLnCYLFm9b/cQQuiQcE26EEDIAfdtzca2YpTJykWHqVx659lOwhaFWgTEp8TCfg3MegTZtResQllZphPJyG7g8MKoEblyAs+Fb9LI9brcQctIHnq2HY9sKcko+BTUlMfFc9UtXqjheADxsIfTCz2ijzmWnnf1S5OsOM11q21onOva0gZ6TRC1JmlFZvjHM1nsai21bd3wMHnYcdsx2NCzyVMiNOZ7rnfLzOh7YGMheY2fQogxQvyEn56PhycbsAmVOghW3KvhyLFmWbzgCcL15gHbLWIFoI/fr6SQoFYIoIQKCbzxRy4q2lfK05t4Jo9DImaqg8qkKWnIuIpZwm3pGQA0cIpM6EwWt8NZpymAD/eVRNtV2qo6DIW4KshRtM8Mkiiv9vMxIHANfnFJeuOElq8Ybw39YRCgZrW1MHbcUApTrt+nY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(86362001)(6916009)(31696002)(8676002)(38100700002)(66946007)(66476007)(316002)(4326008)(54906003)(66556008)(44832011)(2906002)(8936002)(7416002)(41300700001)(5660300002)(83380400001)(186003)(36756003)(478600001)(2616005)(6486002)(6666004)(26005)(53546011)(6506007)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJkOWphOWVqQ0dhYnFtcm8rT2dOaXBuditySEVoNXdxazF5M2xzNzZodElE?=
 =?utf-8?B?SjJqVXVzcE9jTklCN1RybFV0b3U5bUoyN3JubkZnM0JzdHhrVHc0RURzSFRh?=
 =?utf-8?B?SFNDYUZKTzBBMkpyeVdZTlBBZm5vUU1yaTdGVDJIbmZGK3VmSTA0NHJBTzhT?=
 =?utf-8?B?ck5GWGYzdFRUc0gzNFhueXlYS0doaFpsVkJ5RjY0QlRvdkh6TEdpOUNKTlhj?=
 =?utf-8?B?VEtnUzM2aHAwckZWRG5mMzdPT1drZmxTS3JRVEdTZGYyWmhGa2E1VzhDSmx6?=
 =?utf-8?B?VUFXVzNzZGZhSm9JekdkcTU1ZS9XcTFweU82YW8wZkdYZGRiNlViWHc3UG9a?=
 =?utf-8?B?Z04xVjNLc2RZR3VEK3JSV3NRNUM2NTBFd2ZIaWFoRHpFWTBiT0VSa2RkTUQz?=
 =?utf-8?B?bWhXMUN3TUFOZ2JxS0RPNXVwRGdZTDVPaktlb3RCLzIvOXVSRFdnRVhJVXNO?=
 =?utf-8?B?MW1VdFd1cE9mZlhOSWpIQ1o3K1owVkVrTCtEVnBtcFVlelJZenRYYzNXcjJu?=
 =?utf-8?B?enJVbDFoOGpGWTR6djlUS1F5Q2p4Rzh2endqT3RQVFpFVnpKOHVWNkJTMWY2?=
 =?utf-8?B?a2tWdWo1aDllaWJ2K3ZXcnJ4MU84ZVJhbDdCUHpPMFlFaENWWkVPNmlkbm1U?=
 =?utf-8?B?ZXQybDljaW01TUF3QWJwbnA3ZFVlektBWHg1ei9sS1hWTjgzRmhBUnlYQjRI?=
 =?utf-8?B?aFN0RmVxZDBMNktTeVJkcno2RkJoTDh1OXdHVy9FelYxOEZUQWtnbHhBS2hP?=
 =?utf-8?B?VzFzUWJzc1R6ODRKSnpneWl2NlRocVBwdmVLUm1NRDdLS0VNTGJmNTl0Z29Z?=
 =?utf-8?B?bGM3U2xXUEVFdXVTaTBpSlpxamgxRnBUK1RzOEl1REtKenhFRlNzZTQrQlVD?=
 =?utf-8?B?VHhwb1JTcXJjWWdiR3lnbS9kcEFFNTYxbVc3em5jRzJsVlpvdzFqeTZMWUlp?=
 =?utf-8?B?UGFFd2RpS1NDbytIYWtJMGkwNm1rY1h4aFdJS01OYU8rVi96SW51ekplSEQw?=
 =?utf-8?B?bkFlYU93L2tJVkhYU012YWY5RzRMYTBDSE1zSk8xN3ZjdlpveS9WbE9RMkox?=
 =?utf-8?B?NGVHZHE1d2taeUhpQmt3aFl0TlRYUkpMRXJmcXFIak1YR0RrSHRJR2M2Z3pt?=
 =?utf-8?B?ZUxyVzh4NGhLdkJNQnRUVVJVRWpuVk9GSFJmWjhCdmx0NFBKSnRaZkg0eFdT?=
 =?utf-8?B?VXNNRlhUODYxWFRGMm9oaU0wMkRiTVd4QlB5TWJHMG1QTFJ0ZG13d3pTVVRU?=
 =?utf-8?B?NUY3QlU5YTdZeEdyV2hJckpITlFlUHlpNnJ3dXJ4TXNOWGdqU0kySFluVUor?=
 =?utf-8?B?YVBTZXgyelAvWnJOTmJrZHpJaGlSbmFWMGRyYnJUOTZwRU9jeHZQSkNaUUc4?=
 =?utf-8?B?QXErL2Q0OTVNdjR3djNDOHR2RkJjTXRSZ2NrdUdhbDRvMXdVQTArQXNTNnN3?=
 =?utf-8?B?R25UakpueHpjUi9EWmxNQ3NVaVBIcGpvQW0vcTFwSXIzOHhqK1J6cDZOa200?=
 =?utf-8?B?WVFOb3YwaVk0ZnhKM0lGOFVYTXQ5dGY2cFNsVmRUUU9sRlpZSGZMbVErd24y?=
 =?utf-8?B?UjRETXZ1Rm1qbnMzM3k0WDdnNEdDRHh0ejBZUDRWcklDMWJjZ0lXU1o2Nndu?=
 =?utf-8?B?REJ5cDRKakdnUnRwUnlEc2xsUlNNNGxYamhCelRTblB0OWhFK3NNVUJhbTVm?=
 =?utf-8?B?dmo4V1hnYkhibEhqZlRlaTdBR1pUcW9mQ2Qrek5oVGVzTmdYbGhkcW9BT2I5?=
 =?utf-8?B?emhIb0NRdFM4U1Z2SStTcG5mcDNjTVQ1bjB3T0o3ZThUcFJQTGJlMndGY3hD?=
 =?utf-8?B?WGk3Z0hNL1BmN0pFUUZ0QVRZaGg3SSsrRllWT3YwNGRSOWlnamk3UzFRcUxB?=
 =?utf-8?B?cElCWVZ0RGhWSXZKQmRUYVRKVWZxYlhLVUFVVVl4MHN0SHgyZTRSYmhXWVdG?=
 =?utf-8?B?VnZNQ2I1RUNHSEN3ZjlIaG4xMm4wcEpJQWF6QUxiYis4Wmh4aUZoZDNCMlF3?=
 =?utf-8?B?ZVErL2xqM2RWVjJOYXNIYWNSREkzUDJVN2RWZVl2Zk5JcGpaKytlOXNvWVRv?=
 =?utf-8?B?Q1F2SUhPRHprc0RzaCt0akl2cXE4R1AzSTRvc0FyaXZWWnI5QTFBY0hKZHNU?=
 =?utf-8?Q?Fu1WF6b6Gyd+87yK3zQP5SJnL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480da829-c682-408d-cefa-08daa29f12cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 04:48:52.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yq3flpWK2+3iZnhP5MOrny2IXo5SV7tx9Hve9fK32yCPLvfl5T/s7qblOYvEabPKOZLMs7VgZjusabjldOkalg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Sep-22 10:11 AM, Namhyung Kim wrote:
> Hi Ravi,
> 
> On Wed, Sep 28, 2022 at 2:59 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> IBS_OP_DATA2 DataSrc provides detail about location of the data
>> being accessed from by load ops. Define macros for legacy and
>> extended DataSrc values.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  arch/x86/include/asm/amd-ibs.h | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
>> index f3eb098d63d4..cb2a5e113daa 100644
>> --- a/arch/x86/include/asm/amd-ibs.h
>> +++ b/arch/x86/include/asm/amd-ibs.h
>> @@ -6,6 +6,22 @@
>>
>>  #include <asm/msr-index.h>
>>
>> +/* IBS_OP_DATA2 DataSrc */
>> +#define IBS_DATA_SRC_LOC_CACHE                  2
>> +#define IBS_DATA_SRC_DRAM                       3
>> +#define IBS_DATA_SRC_REM_CACHE                  4
>> +#define IBS_DATA_SRC_IO                                 7
>> +
>> +/* IBS_OP_DATA2 DataSrc Extension */
>> +#define IBS_DATA_SRC_EXT_LOC_CACHE              1
>> +#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE                 2
>> +#define IBS_DATA_SRC_EXT_DRAM                   3
>> +#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE          5
> 
> Is 4 undefined intentionally?

Yes, Here is the snippet from PPR (Processor Programming Reference) doc:

  Values | Description
  ---------------------------------------------------------------------
  0h     | No valid status.
  1h     | Local L3 or other L1/L2 in CCX.
  2h     | Another CCX cache in the same NUMA node.
  3h     | DRAM.
  4h     | Reserved.
  5h     | Another CCX cache in a different NUMA node.
  6h     | DRAM address map with "long latency" bit set.
  7h     | MMIO/Config/PCI/APIC.
  8h     | Extension Memory (S-Link, GenZ, etc - identified by the CS
         | target and/or address map at DF's choice).
  9h-Bh  | Reserved.
  Ch     | Peer Agent Memory.
  Dh-1Fh | Reserved.

Thanks,
Ravi
