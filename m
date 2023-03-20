Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A576C2013
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCTSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjCTSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:38:30 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AB9241EB;
        Mon, 20 Mar 2023 11:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIuqvwF1+UjA+Xqx5xasDEMyIkBKXd8l4lUJipag5/FHGGJQFGOUuwhWgQ6cTM8nzvwspR1qXSDgH1VjrC7hyOGIoXriM7/8NQAZ0lScWvWYlrykJWc7ssS4JXv4O4JNAqRH+VMW+Jm55G3tCcJZHgBaSt9sDmL7iqYbziuyJHddM+YZS1s0raog//7vat+J8URje4PYp1olGt10K63YphFZk6WCmFCcu/2zDLYNFfMwQVjiOtdMGjxPwvm8Gp1kMHKASAgVCXfeGpBYqary/CJGmquhVJGCctApQ/cA5Dbt4utPqWQPl+5zT1yUOYOH0AtMvGizticGAm10K/chtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm3zEQWgVS6Vrn988tYeBcCcn/w6lGl+bFU/ycStTig=;
 b=OKNhQ6WDQS2tMiKPfutnVJXPr6mdry4LySN4aa2TAmXO0dHiKBcb+QNULdjZQxkUBI6kTAUx1XaCy8hRUmoLG21pFk8E2s7CpPEsszbiIBkkKe69OcNAmFrPajqPM5J/h+otvo8WE57+sZz4CPGWelx3iUlX8LM8FUdAvpwIZB43sSww7GqXLvHq4Gpa2C6mGuZEbyD9EnL4TGWVPRSfHS1M3IixX/vsXwbA3JohcDT/5jegiA24G3UKOTxPN3dP5LV/DdvxUAki1sHq0NeU8rzgb9FnRUuYNMBruj4WWK5/DXdk4LNHxTZ8oavqip4BiyAibVhvs8hk8SAYWTd51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm3zEQWgVS6Vrn988tYeBcCcn/w6lGl+bFU/ycStTig=;
 b=EFjFB7VO2lGBBEKq00Fw4T9x9J9UxhWolrorFqPeIl9PImJ+ALpiq0GwxFiyktTh4VbsFNGddHOnTNFbyCkBqSIdQQbNSZcrtnIe15SHher/A5lWKqlWzq4XW6HsPm9QMuKgr1/1puTI8DXKcRNqyhy0/c89+qVczgQ0PK5wKLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Mon, 20 Mar
 2023 18:30:02 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:29:58 +0000
Message-ID: <3d8585fe-ab2f-6a06-bfc0-47569d755c69@amd.com>
Date:   Mon, 20 Mar 2023 13:29:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu>
 <9af9eb7a-476c-d4b0-e114-3f5c2b45dd95@intel.com>
 <MW3PR12MB45537DC45130BB5F02F0F3F095BC9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <71b58853-e7c9-b522-3f90-c3d84cba1317@intel.com>
 <39c85927-9c34-0284-86c6-724f417423db@amd.com>
 <7a71ac36-d9dc-c2d8-31fc-127225d21ee4@intel.com>
 <044fd84b-257b-d450-2b4c-f6ca5ef47f7c@amd.com>
 <ec71ca8a-2550-8e01-7830-6e9f62ee4e95@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ec71ca8a-2550-8e01-7830-6e9f62ee4e95@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:610:5b::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: a195cae9-921d-42cb-2578-08db29711bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcixpla5WzHCa/fZo+puzkYyCXeXMSMPqBRsqkD4k+hicGpIOiRykSNYxMc3+uV25Zeix3++VoyGSjBa1smG2GWQUdEPflk3PP6XJQaQDz82cRR/alDQ61oLpXGTqnAzgqxcf82+ldPqur/YjJh8umm0/rfoRu3PT8QcMzRlsrnUE9VlUEf6/wzH0nCjpXQ8VwNQj8bq57fv/F0f7KD4r2ebjeM4t9+RQf/F8W0epvEnZZa4FoCIkUDG1VeHZpa7g6wcRiLklzVZ0Tz7FXjQb+wvXS26vOG1URG1oQ1jzpog3CKK6HraK/z5OFZrT6Qz75PNzOtr5w7NhheBG43OW8Nranq8IaxhV4R/nAAgRABx2HVcoFOGcnN5+WTbjxA9yze5luMlEI9KheYqrJ4xtKUKkXlDOvYolrxWB1C/Oloucmsu1nzR5CbDjByJRg1n08Wx+N/4mhDmokq4AS2KhQGCbT1PRHNQ3jM1PkK/9tJ9Xl5gCISRdcSp6rUDRqzHdDY4j18Ytnqf/QS3g5O8neosiYzXnpYG2ApGiV9qNYgpVe7pYqz5kwdne05wc4gUx58nNjwYmbmFKvSGgCTYXz+gNFLba/VmEyS9pD9gu7xmkKSfB9QZOAjZPZB1B6Oo6YOsHP7Ju6H1O3nhND1diaGSoEi9hCIAnBypmPbO1SievRKgdvAuKdJRg4CBmey1KSYvaQoCaa4KK05UJs6Zfb41ObQbWSrQypSHLOPxpWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(31696002)(86362001)(36756003)(316002)(66476007)(66556008)(83380400001)(54906003)(478600001)(8676002)(4326008)(110136005)(66946007)(53546011)(7416002)(26005)(6512007)(2616005)(6506007)(31686004)(6486002)(186003)(38100700002)(66899018)(7406005)(5660300002)(2906002)(8936002)(41300700001)(3450700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0ZoL0ZDK241T3FTbHFzMVNEZXJKb2wva3BmcHhCdFlSZkY0VkVOWCtUMFVB?=
 =?utf-8?B?VTFubE5PZlVoRzJGbEZ3Y1oxL3Y3cjNubmFpYjVDVDd5R1ZTU2c4VTBOMU9t?=
 =?utf-8?B?V1YydkJSSENaUXpiMGw0QVN4aTEvS0dVdjhBdFQzakVMdFl5ZkJQT0FMUGZL?=
 =?utf-8?B?bFd3NGxFc3N0dmtVejlPdnFhaFpIRDdWWVpsZ1gxWXhPY3RpNmU4eVhwUC9k?=
 =?utf-8?B?T2dsNGQzQXBsTW9aVEprNFRGc3RTcVhwMXVvZThVTHZsVFArMktaRG4xSVE1?=
 =?utf-8?B?MC9pYytGYTg2WThWUDNxOVhGcytqTzhyY2xTK2JGcFgraGpQVngyQXVWWlBD?=
 =?utf-8?B?SzIvQ1k0c25oTEE0QVk1ME8yc3JoVUxTZm02d3JiRG11OWlVMFV1dXpMakVX?=
 =?utf-8?B?QTNYeVJyMlNlTU5rMGwrdU55cVhqQTRTRXc0TXVNYlp2L2tzY2lmY01RR3Bv?=
 =?utf-8?B?NFdjd2kzOWRjUHNNQXlKaUNwalFram5GYVJOZjdLd2JZdDZ1NXFiV1ZkRFVi?=
 =?utf-8?B?MzN4Y25zUVJPUFdIRUV3a3V5cDdNaWNlNnFqdUNDYnZod0RlTER5cXhjREhD?=
 =?utf-8?B?YnFTNUQrS2NPdkRXOFlUTDh6R2IrbjVIMVVwZUVPODgzZVBEZFA5SlRLVnVq?=
 =?utf-8?B?ZFkweDEyOWQ0c0JnL1ZQVXlaMjlNWWpWbFNQcHdLU05vTUxBdi9XTE12T29U?=
 =?utf-8?B?clVzR29kUmtvR0NTQXVIRk44T3NOWTIzYjg1aTA0SlF5KzVoazZOSElIYjVV?=
 =?utf-8?B?NUtkeDBRc3RLczBxZVliUE9YZ0lvYnFQMHFJL2VBZHhxLzVDMGdPVGNyZ1Bm?=
 =?utf-8?B?TGxXclQ0bno0UVU2VVM0M1g0MjltV3I0RDE0UzJ3dWdJOTB2cDFDbktVeTFK?=
 =?utf-8?B?c3J4QmpqZlppeVZ2eTUwb2FGR1JQdmtWR1F5QUcxNVBrMjAwMG1NY3V4Z1Vq?=
 =?utf-8?B?cTFyaS8remEyZmdLV0pPN1hwUWVBb3Mrd2FsVk9yUzJHS0Q5UHZkRExtQ1o2?=
 =?utf-8?B?Ull4WFh0cnQ3c2Fvd1NsaHJzdko0SXZFV0NmSWtzb1RSK3EzL0NTRkU0NmVN?=
 =?utf-8?B?MGU3TnF0V0x2Y2MrNlpGREdDWFRJZEtxV1lFNm9xOE9tYXl4ODFIQjR3UWdB?=
 =?utf-8?B?K3dTVlJBVU0ydzdLclhtZXNSdEVkbzdydnlPeFRWak5WNmt1cXIxcUhOSXZT?=
 =?utf-8?B?L1JUWmo0YU43cDhXMUU5SStnU25HUUFIZUlPMmE2TWxaa1N5ampITHdLRXBw?=
 =?utf-8?B?TDZsVGNFYXYxbENnbWRSa2NoNXFyT0VQSXVhb3RGaGh3V1dzUlV3cWFDM3F4?=
 =?utf-8?B?VmN6VkVubFNpVGVUeThEclp5UTVBQ2RVSGhRZnZNbXBBODA2RTU0cllsU0Js?=
 =?utf-8?B?VGN3MVZ1bk90a3NFZHhkeDFJQ0lJYVQ4a0t4NElmcFBuWXJzUjF5M2Y2eU9G?=
 =?utf-8?B?RmJYKzRMeHlQdE5IcUFqQlZyWWZCQWV1aVd3ZzV2TWYwK1lVcXRoZGVZcGFB?=
 =?utf-8?B?aXJuVytLQ0pLM3BhZE4wMFBJcVM2YjZ5OTVxcXdUYnpiM2JzZE1DcDByemNz?=
 =?utf-8?B?eGdHT1A1anB6UzhNaFdwSS83V1JLRVdpemxxeDFXdkViaDl5TWNtUjN1Smk1?=
 =?utf-8?B?bTBLR3RPZ3cyVWZVNVg1VUF3MVBQUzVkd1MvY3poK2NNeTVya2szVXJhUUFF?=
 =?utf-8?B?NEFLWFp0MDd6YnQwelByenNsZ08wNXMrb0xoVXNqQWhOQ2pjLzdES1hCQWJq?=
 =?utf-8?B?L2NkL3FHcjlmeUlEV0RIM1VtUHZ0aXcrNWJWUWpQTExYL3pNSmsxNkhXRm5t?=
 =?utf-8?B?NHVMMWlsaVlWU0ZpT0kzd01NZEtrZk1tb2V3a01SMzBIM0lRQnBjeHNWMW5W?=
 =?utf-8?B?L3JWQ1pVeWdiWkpzOHFHM2RySHJibWlkeUVtSTNxUEFrdWhzdFFiUktacUJM?=
 =?utf-8?B?TVBjOXkzSHFJTmV3OHFkVVhZSnZsbnJTZ2xYT3ZFYkVTS3R6THpMTjJDVWs3?=
 =?utf-8?B?L1RQUWIrVk5TS2lDZjBMRy9pSEJNTFNRcEVERDExT0VSNlNRdVpGOElNQXBY?=
 =?utf-8?B?K29hcEdIUjl5UjJXdXZMREdwUTl1MUQ4Z0ltSFlTVzRKakdKaDlWSElGdmxD?=
 =?utf-8?Q?UDYsOCyD6DUcSHKUw26mSWTnu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a195cae9-921d-42cb-2578-08db29711bf7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:29:58.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6Ju/Xoq+K2R6zmEMKzZx7lkd9jW0BSZupjGN3GR0Fwh3R5rpixGA29syFsW/RHl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 3/20/23 11:52, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/20/2023 8:07 AM, Moger, Babu wrote:
>> On 3/16/23 15:33, Reinette Chatre wrote:
>>> On 3/16/2023 12:51 PM, Moger, Babu wrote:
>>>> On 3/16/23 12:12, Reinette Chatre wrote:
>>>>> On 3/16/2023 9:27 AM, Moger, Babu wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>>>>>> Sent: Wednesday, March 15, 2023 1:33 PM
>>>>>>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>>>>>>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>>>>>>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>>>>>>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>>>>>>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>>>>>>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>>>>>>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>>>>>>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>>>>>>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>>>>>>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>>>>>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>>>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>>>>>>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>>>>>>> peternewman@google.com
>>>>>>> Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl group
>>>>>>> at once
>>>>>>>
>>>>>>> Hi Babu,
>>>>>>>
>>>>>>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>>>>>>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>>>>>>>> done one at a time. For example:
>>>>>>>>
>>>>>>>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>>   $mkdir /sys/fs/resctrl/clos1
>>>>>>>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>>>>>>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>>>>>>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>>>>>>>
>>>>>>>> This is not user-friendly when dealing with hundreds of tasks. Also,
>>>>>>>> there is a syscall overhead for each command executed from user space.
>>>>>>>
>>>>>>> To support this change it may also be helpful to add that moving tasks take the
>>>>>>> mutex so attempting to move tasks in parallel will not achieve a significant
>>>>>>> performance gain.
>>>>>>
>>>>>> Agree. It may not be significant performance gain.  Will remove this line. 
>>>>>
>>>>> It does not sound as though you are actually responding to my comment.
>>>>
>>>> I am confused. I am already saying there is syscall overhead for each
>>>> command if we move the tasks one by one. Now do you want me to add "moving
>>>> tasks take the mutex so attempting to move tasks in parallel will not
>>>> achieve a significant performance gain".
>>>>
>>>> It is contradictory, So, I wanted to remove the line about performance.
>>>> Did I still miss something?
>>>
>>> Where is the contradiction?
>>>
>>> Consider your example:
>>>    $echo 123 > /sys/fs/resctrl/clos1/tasks
>>>    $echo 456 > /sys/fs/resctrl/clos1/tasks
>>>    $echo 789 > /sys/fs/resctrl/clos1/tasks
>>>
>>> Yes, there is syscall overhead for each of the above lines. My statement was in
>>> support of this work by stating that a user aiming to improve performance by
>>> attempting the above in parallel would not be able to see achieve significant
>>> performance gain since the calls would end up being serialized.
>>
>> ok. Sure. Will add the text. I may modify little bit.
>>>
>>> You are providing two motivations (a) "user-friendly when dealing with
>>> hundreds of tasks", and (b) syscall overhead. Have you measured the
>>> improvement this solution provides?
>>
>> No. I have not measured the performance improvement.
> 
> The changelog makes a claim that the current implementation has overhead
> that is removed with this change. There is no data to support this claim.

My main motivation for this change is to make it user-friendly. So that
users can search the pid's and assign multiple tasks at a time. Originally
I did not have the line for performance. Actually, I don't want to claim
performance benefits. I will remove the performance claims.

> 
> ...
> 
>>>>>>>> +
>>>>>>>> +	buf[nbytes - 1] = '\0';
>>>>>>>> +
>>>>>>>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>>>>>>  	if (!rdtgrp) {
>>>>>>>>  		rdtgroup_kn_unlock(of->kn);
>>>>>>>>  		return -ENOENT;
>>>>>>>>  	}
>>>>>>>> +
>>>>>>>> +next:
>>>>>>>> +	if (!buf || buf[0] == '\0')
>>>>>>>> +		goto unlock;
>>>>>>>> +
>>>>>>>> +	pid_str = strim(strsep(&buf, ","));
>>>>>>>> +
>>>>>>>
>>>>>>> Could lib/cmdline.c:get_option() be useful?
>>>>>>
>>>>>> Yes. We could that also. May not be required for the simple case like this.
>>>>>
>>>>> Please keep an eye out for how much of it you end up duplicating ....
>>>>
>>>> Using the get_options will require at least two calls(one to get the
>>>> length and then read the integers). Also need to allocate the integers
>>>> array dynamically. That is lot code if we are going that route.
>>>>
>>>
>>> I did not ask about get_options(), I asked about get_option().
>>
>> If you insist, will use get_option. But we still have to loop thru all the
>> string till get_option returns 0. I can try that.
> 
> 
> I just asked whether get_option() could be useful. Could you please point out what
> I said that made you think that I insist on this change being made? If it matches
> your usage, then know it is available, if it does not, then don't use it.

Ok. I dont see a major benefit using get_option here. So, not planning to
to use it.

> 
> ...
> 
>>>> I can say "The failure pid will be logged in
>>>> /sys/fs/resctrl/info/last_cmd_status file."
>>>
>>> That will not be accurate. Not all errors include the pid.
>>
>> Can you please suggest?
> 
> last_cmd_status provides a 512 char buffer to communicate details
> to the user. The buffer is cleared before the loop that moves all the
> tasks start. If an error is encountered, a detailed message is written
> to the buffer. One option may be to append a string to the buffer that
> includes the pid? Perhaps something like:
> 	rdt_last_cmd_printf("Error encountered while moving task %d\n", pid);

ok. Will try to add and test it.

> 
> Please feel free to improve.
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger
