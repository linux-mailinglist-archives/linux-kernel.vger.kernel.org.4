Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709136C175D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjCTPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjCTPMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:12:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0CC1421E;
        Mon, 20 Mar 2023 08:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PholrWntMlLlNgTnLGfeWGvxdDJU7RWibHMf0y8+h6yQruxrM1kbkl5QK8ovibjbjthrhen850P2R9hmcFIXXJVAfU8xhx7FWnmysrZfAbZ9W6wEleACGFKYnF8PmvGAihEeLgqS8OIvVgkEJbHJCBYdPDmz/uTHxaXjeEw/Tl1wG2dBMyTg4BCf9K0obcvq4Ih8k4sOVX3ccB3oO8xOa28bizQaVWySCaAaY9dT1Hx/Kk76ctU7iVlZvT+v9EPrrnD/IaU+/kHkNbp4nE2Ff381/Piu5FGqE8F7SY1BnF7eQ64SvPGXVHkRfdn1s/O+jUwYFuMLmID8iq90S6Z+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZRdIPghXuMZmwgDjXIa+LBkz5lVOUsbuaj7wBgK0MA=;
 b=Kq/SAvZNYY0CqWjxoHEwmJYWEj9K3wjKkQ0TX1musonsF1LlSVk41yHku1wtYvZPf5sp0LKOnWizRbomnOV6WomInYHjWk3VB3C5O7em7xj/7tfl7yepQHQ8DZxgign5f/3rMTAIfZhWLQI4cExbczxf8c5sBjeM8daAyS72nKaT74j37KDyXZo7tQM32jzbj69M+mNbMGsEJniUfB6Kelgdnyur4FTXIRsqrbZdj7V0EWxgn+DLTb5qk1fvKRU0yTa8xSGSluMFB/Oh9h/CR6hV1PzHog7T14ynVjclElA2AJqXJkJQD1zHvpb+f4US93AN9uyKSJn81ldJ5w1vFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZRdIPghXuMZmwgDjXIa+LBkz5lVOUsbuaj7wBgK0MA=;
 b=x1JEUFsQSMxNLdiEGGbttpzkNLBb9WaMQF/LSBADLapgdV+P2hEZsM58fqRyos64oNTramaO1NwejY6+uOFYU2q9q43fh414bu7NoeJTiBGWKdcEF7K1NA6JM/gMOQT5S/zQNY3yjDqA/vyyY5CwbkDshPKXxYQ/B9dOy70LbFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 15:07:32 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 15:07:28 +0000
Message-ID: <044fd84b-257b-d450-2b4c-f6ca5ef47f7c@amd.com>
Date:   Mon, 20 Mar 2023 10:07:26 -0500
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
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <7a71ac36-d9dc-c2d8-31fc-127225d21ee4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:208:237::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 916e9eb8-423e-4e13-6c4c-08db2954d1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CH18lQ2CPXmp2Zb5dUi1afTL+abOipvShZRocN15Wlz8N6u9cvE2bCTiAu3aU770XVb+vnSJuKmaSyq0x0vZ0mKOvOJZs49ufGj5yCWkAJK3tL1TVWetnp5e/5D+7FTMuVWeIW2jbuFDLpi6lzMSMDsriRL0UDXgwbXpo/VQB6abKP2Mj59LIi6s8JWuQNjbYUyPxGqVn9ZeWE3kOaJroi++PHAQm//QqjevvWgLxHLNjysQ3wIMC4wjyfXqN1LRz6Zl+zmcdncXM8T9zq1ZTFYnb6Zornf5Ii+vz6gPt+9ZBGJIOKd5bCSejXVBc8dxMh0ZyYWTiTwHxpHZ4O8EGbgGRjbZpNskbd3t79Sc2gvjArHGHwUaF/uiw8eYVXRk7o24yFIYzJqONKMzqw4iOXEInISlshPzCCI1KLXTwr2lIK+Bnruq6NExIoRYjB9GgiPM1VL4O8qKWlb2E0m3vGYD5MsUBUcZqgdyd+x4nXhANBypX9VsP8rcbHQdI2YgWjjaNc2ACECNyd8NB+7TAanS8Jvyw73qUHmCAIM6RVzLVVdr6jFZrpCVVXH9ENx+QDdT0HfZkH4L43+Sz9vX8eJzYqeaJh+uSINc5V000M50YK8zID5OwsGP0D1uw81Nm4CaJvsQQe3bhng0MvbNeLM8sGrauFWawzQ1aGrzXpllzk4jy2khNavp0jQmhuOkscLrOX7epT8/4ILfphFrkil4Mfp0vtsohfrjO1w3geY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199018)(41300700001)(4326008)(8676002)(66556008)(66476007)(66946007)(2906002)(3450700001)(36756003)(38100700002)(7406005)(5660300002)(7416002)(8936002)(53546011)(26005)(6506007)(6512007)(6486002)(2616005)(31686004)(186003)(110136005)(86362001)(66899018)(83380400001)(54906003)(316002)(31696002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJ2bnFlOHQ4Si83bGVFQzF1YnJ5TEdURS9kbVZtRXhMS2x2L3EwNDE4eTBR?=
 =?utf-8?B?Qzliem0rckdqMjhXSmJnVzd3bVQ0eXA1Z2tVR2FQbFkzejdsRGMyWTBGWnNE?=
 =?utf-8?B?NTQ3Ym1qbTFucDFaUGtFUkl2a0c1alpBLy9FSE5UVlUyeG5ZVmpzaXVPNXky?=
 =?utf-8?B?Y1lMUnRncEdaMlNrNU9aSUt4cTBCUmExc2V2b09WaFJKTk40UWpmQXpSZ3R1?=
 =?utf-8?B?TDdKc2hLTEsvK2RVU0xtaUFMMExUSjZ3SnlYN1BPSWVUTTBYSnZ0dnZEeWRa?=
 =?utf-8?B?ZEhqUTlMRHlxVXpSeFhLWDk1dmcrUWVSWWgyYWhtcVRuWkZ0QWxpajc2SXEx?=
 =?utf-8?B?SktUVkFjN1MweXJ5RWpUbGJOZHRnVDhlbFk4d1pPVUV6OEV0RVJpd2J1ZGlz?=
 =?utf-8?B?clpyNXBWMUNVZ3RWczNtVlFjS2w0aGxRWFJZRXV3SkE1Vnk4SFhSRXl0ODN3?=
 =?utf-8?B?ZHRiNmEzbU1KUHpUYWhZTjRyLzROV1RGNGk4ZkxWNmhhMThhTnA4d0oyZjVh?=
 =?utf-8?B?dm11d3hNUmRZc3lGNEg2cmFXVmtkMmNkNUhaSjNObk40Y1VCOFh4UjhSb3gv?=
 =?utf-8?B?NXZ2L0RSNk1xVUdFSEVqcmVPNThDb09neklDbVFRZWlSYkJ3WWhuMkZNQzBH?=
 =?utf-8?B?K2NLV3hoVmovcEVFVFREYnlUSFM0YU9XREVFRzFaSUFhV2xDSnpTTGhOaWZ6?=
 =?utf-8?B?c0d1eXNVYnhLOE5NVTlFSmFXc2tSMHpOY0l2a3loYmE2OGlzcXlzZllyakpN?=
 =?utf-8?B?Z2c2ZHNieGxYak1lZU9BSmhPUVdzMDl0U3hXWFVHQldNS0ZRRlJCWFFRQ3Jw?=
 =?utf-8?B?cTExRXhGVkt2UG8wZHdkK3hjaFoyV3RWbllQQ3VsVmMxZmNtU1ZMVS94Mjlz?=
 =?utf-8?B?enZaelVndTVjSHF1Tkc1VngvWFVkZ1FtTnl0SC9DakNONEdheG5CK2YxWEpN?=
 =?utf-8?B?MUdRM0wva2NzVzBwWk11QllYNjNCL25XYXREYmp2a1pVVDgvSTVqVnNLUmxK?=
 =?utf-8?B?VnlxYldlSGdYeVNEL214Y011eVFtTlVuelZRbDJlMzFMR2w2elNIM21jT2l2?=
 =?utf-8?B?NTk0ZmhyR3ZFRWZtaWNsSTN5R2VFYXJkQkFiN1NKQUkrWGlZMTJ0L2IvSlQ4?=
 =?utf-8?B?UVl4enVPSmppTVk2NEoyelQxWlJYbXpSYXFYdFllaHd1ZC9uZGgyK1ZrbjVV?=
 =?utf-8?B?VURQS1BPQnJVcmNKMGd0Ri9EVnA1VzMzZWRlMitGTFdlMGdJQkFTWEdKQ3dL?=
 =?utf-8?B?aXdoeEhiOHVHNGxkOWFpNzVKWVFKK0pLVFBDQmZlYUE4MGovMWtnMUE2YzJo?=
 =?utf-8?B?N3R3cDMvY1p4Tjl6empKMHcwQ1NFUnZ1Y1BtTEdUTEk0bW5uTFlJK2Q5ekNv?=
 =?utf-8?B?amlnTkpNU1NkVUErODFacllyY29PVWdpc1hHWHNhTmFLTllJTWtoWGJhOUph?=
 =?utf-8?B?blJYYS8wY2Y4RXp5aW9IS0t2S1l0NEFjL3FNL3F1YzN0ZGRHR1A5S1I1bGlP?=
 =?utf-8?B?dE1KN3hXdVFRLzc1QWg2TTJ3eVhFUGdMSUlpUnY1eXpPTFFSdURFKy8rekFU?=
 =?utf-8?B?ZzVFdXNwUFVjdXZDVGtVc1Q3c3Jxb3VJTEFqa2J0UkFmVC9zVktsVDhicGlp?=
 =?utf-8?B?dldreGx4SE4yTmNsdHRtZzE3enE2UUs3NFJVY0p1NUhjdnBhL3lUL0loR3Zp?=
 =?utf-8?B?WHRXYUZrN1RydmVDOTFkVFJNMmR1MVlNT0VPTFhvcVlXTDRGRTZsNjNTYUtO?=
 =?utf-8?B?VmxMYWd0bjgxMmFSaURNQk10c0E4WnBYS3RTbnVFZnl2WjBGUGpXWGZPM0hD?=
 =?utf-8?B?R2NPa1YwZmI2bGNKQURLZ0xUTnRNa050dU9qUDFkamc5L1VlVjNveUh5bHVM?=
 =?utf-8?B?M05jWFJmVDFnazM5M0JXMkttTkJiNFdaY1lSSkl6c2FQYzVXTWJuV2k3amhQ?=
 =?utf-8?B?WjhlVFgrOHVOanBlb0lIcTBFRFR1ekZSVWlUY0pURlJqVWdlbE5vRjRmUkFn?=
 =?utf-8?B?Zi9wSjIxL0Jiejc2NmFZQ2hZYS91VWJTRTFxS1I1VVNBWkIrOXNxQjhHUmNU?=
 =?utf-8?B?V0EvY09VVEdFRmh5YytoakVkTUF6MHVWQlBBOWFwekhRSDhJc2dqbGdoSzZl?=
 =?utf-8?Q?WKTweQMugSzNCIc0SS3Fnw/Zf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916e9eb8-423e-4e13-6c4c-08db2954d1eb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 15:07:28.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tEc+CsRUcTg2l5fnYpBp1/VoKGM2/fxntA46RR1x6uxoM3lg3rJ+/lukuHPCM0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
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

On 3/16/23 15:33, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/16/2023 12:51 PM, Moger, Babu wrote:
>> On 3/16/23 12:12, Reinette Chatre wrote:
>>> On 3/16/2023 9:27 AM, Moger, Babu wrote:
>>>>> -----Original Message-----
>>>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>>>> Sent: Wednesday, March 15, 2023 1:33 PM
>>>>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>>>>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>>>>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>>>>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>>>>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>>>>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>>>>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>>>>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>>>>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>>>>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>>>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>>>>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>>>>> peternewman@google.com
>>>>> Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl group
>>>>> at once
>>>>>
>>>>> Hi Babu,
>>>>>
>>>>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>>>>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>>>>>> done one at a time. For example:
>>>>>>
>>>>>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>   $mkdir /sys/fs/resctrl/clos1
>>>>>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>>>>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>>>>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>>>>>
>>>>>> This is not user-friendly when dealing with hundreds of tasks. Also,
>>>>>> there is a syscall overhead for each command executed from user space.
>>>>>
>>>>> To support this change it may also be helpful to add that moving tasks take the
>>>>> mutex so attempting to move tasks in parallel will not achieve a significant
>>>>> performance gain.
>>>>
>>>> Agree. It may not be significant performance gain.  Will remove this line. 
>>>
>>> It does not sound as though you are actually responding to my comment.
>>
>> I am confused. I am already saying there is syscall overhead for each
>> command if we move the tasks one by one. Now do you want me to add "moving
>> tasks take the mutex so attempting to move tasks in parallel will not
>> achieve a significant performance gain".
>>
>> It is contradictory, So, I wanted to remove the line about performance.
>> Did I still miss something?
> 
> Where is the contradiction?
> 
> Consider your example:
>    $echo 123 > /sys/fs/resctrl/clos1/tasks
>    $echo 456 > /sys/fs/resctrl/clos1/tasks
>    $echo 789 > /sys/fs/resctrl/clos1/tasks
> 
> Yes, there is syscall overhead for each of the above lines. My statement was in
> support of this work by stating that a user aiming to improve performance by
> attempting the above in parallel would not be able to see achieve significant
> performance gain since the calls would end up being serialized.

ok. Sure. Will add the text. I may modify little bit.
> 
> You are providing two motivations (a) "user-friendly when dealing with
> hundreds of tasks", and (b) syscall overhead. Have you measured the
> improvement this solution provides?

No. I have not measured the performance improvement.

> 
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> @@ -683,16 +683,34 @@ static ssize_t rdtgroup_tasks_write(struct
>>>>> kernfs_open_file *of,
>>>>>>  				    char *buf, size_t nbytes, loff_t off)  {
>>>>>>  	struct rdtgroup *rdtgrp;
>>>>>> +	char *pid_str;
>>>>>>  	int ret = 0;
>>>>>>  	pid_t pid;
>>>>>>
>>>>>> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>>>>>> +	/* Valid input requires a trailing newline */
>>>>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>>>>  		return -EINVAL;
>>>>>
>>>>> The resctrl files should be seen as user space API. With the above change you
>>>>> take an interface that did not require a newline and dictate that it should have
>>>>> a trailing newline. How convinced are you that this does not break any current
>>>>> user space scripts or applications? Why does this feature require a trailing
>>>>> newline?
>>>>
>>>> I have tested these changes with intel_cmt_cat tool. It didn’t have any problems. 
>>>> We are already doing newline check for few other inputs.
>>>
>>> You tested this with the _one_ user space tool that you use. This is not sufficient
>>> to be convincing that this change has no impact. I do not believe that it is a valid
>>> argument that other inputs do a newline check. This input never required a newline
>>> check and it is not clear why this change now requires it. It seems that this is an
>>> unnecessary new requirement that runs the risk of breaking an existing application.
>>>
>>> I would like to ask again: How convinced are you that this does not break _any_ current
>>> user space scripts or applications? Why does this feature require a trailing
>>> newline?

I dont think this feature required trailing newline. I may have carried
away from similar code in the area. I will remove that requirement.

>>
>> I do not know of any other tool using resctrl fs.
>> So, you want me to drop the newline requirement for this. I can try that.
>> Will let you know how it goes.
> 
> You continue to avoid my question about why this requires a newline. Until
> I learn why this is required, yes, from what I can tell based on this patch 
> this requirement can and should be dropped.
> 
>>>>>> +
>>>>>> +	buf[nbytes - 1] = '\0';
>>>>>> +
>>>>>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>>>>  	if (!rdtgrp) {
>>>>>>  		rdtgroup_kn_unlock(of->kn);
>>>>>>  		return -ENOENT;
>>>>>>  	}
>>>>>> +
>>>>>> +next:
>>>>>> +	if (!buf || buf[0] == '\0')
>>>>>> +		goto unlock;
>>>>>> +
>>>>>> +	pid_str = strim(strsep(&buf, ","));
>>>>>> +
>>>>>
>>>>> Could lib/cmdline.c:get_option() be useful?
>>>>
>>>> Yes. We could that also. May not be required for the simple case like this.
>>>
>>> Please keep an eye out for how much of it you end up duplicating ....
>>
>> Using the get_options will require at least two calls(one to get the
>> length and then read the integers). Also need to allocate the integers
>> array dynamically. That is lot code if we are going that route.
>>
> 
> I did not ask about get_options(), I asked about get_option().

If you insist, will use get_option. But we still have to loop thru all the
string till get_option returns 0. I can try that.

> 
>>>
>>>>>> +		ret = -EINVAL;
>>>>>> +		goto unlock;
>>>>>> +	}
>>>>>> +
>>>>>>  	rdt_last_cmd_clear();
>>>>>>
>>>>>>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED || @@ -703,6
>>>>> +721,10 @@
>>>>>> static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>>>>>  	}
>>>>>>
>>>>>>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
>>>>>> +	if (ret)
>>>>>> +		goto unlock;
>>>>>> +	else
>>>>>> +		goto next;
>>>>>>
>>>>>
>>>>> The documentation states "The failure details will be logged in
>>>>> resctrl/info/last_cmd_status file." but I do not see how this is happening here.
>>>>> From what I can tell this implementation does not do anything beyond what
>>>>> last_cmd_status already does so any special mention in the docs is not clear to
>>>>> me. The cover letter stated "Added pid in last_cmd_status when applicable." - it
>>>>> sounded as though last_cmd_status would contain the error with the pid that
>>>>> encountered the error but I do not see this happening here.
>>>>
>>>> You are right we are not doing anything special here. pid failures error was already there.
>>>> I will have to change the text here.
>>>
>>> What do you mean with "pid failures error was already there"? From what
>>> I understand your goal is to communicate to the user which pid
>>> encountered the error and I do not see that done. How will user know
>>> which pid encountered a failure?
>>
>> We only have couple of failures to take here. Those failures are already
>> handled by rdtgroup_move_task. It logs the pid for failure(using
>> rdt_last_cmd_printf).
> 
> The pid is only logged if there is no task with that pid. How about the
> error in __rdtgroup_move_task() - how will the user know which pid triggered
> that error?

Yes. These cases we may be able to report the pid.

> 
>>
>> I can say "The failure pid will be logged in
>> /sys/fs/resctrl/info/last_cmd_status file."
> 
> That will not be accurate. Not all errors include the pid.

Can you please suggest?
Thanks
Babu Moger
