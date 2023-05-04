Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F76F72ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjEDTHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjEDTGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:06:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FED31B19;
        Thu,  4 May 2023 12:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683227123; x=1714763123;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5AhrFPdmDM2BkunSNupoat7DZXzUVtHFm/skqsMclBU=;
  b=TV+YjkWxvq+yUG6NKlDc9aqrOwcCKrzhamlpW7kyCyvGwHK0qMk7jV4x
   K+OLW7O42BG00d5lJ61ylC3X0GptQHvsVE6qbKUmD7V1ymUiRwhsZA3VC
   CgguTu6ucsfNY9lFtaY/oM1vz7u6Ymeg4kkFGyM4mYiFvHBztKgyZTcN5
   +RuE8+sZYsnSJsEDgLaiF8W+vfws6Tqobe/KBxgBtrMPAlrM0jy6gvccy
   22sTpyaQb0JKm74XOAZhp/c00Q6FSLp9gcQFYUaCrNdyg2x4cfUx3Avbl
   Ie6HFFK5HkEafQEB2x3QvCKKM64kp8AjxGfxO0Y7IEWsnyv3K7FtmyQHm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="351153610"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="351153610"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 11:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="871449400"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="871449400"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 04 May 2023 11:57:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 11:57:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 11:57:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 11:57:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 11:57:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxIHCRE2EMUjHnnr5um9UY2wf5nqdOzyEPVPxy7uqzJDz6c5MzWQuAbSOAuE8kUjEQVRL2FtHlaMkCqCcDoRfPI4EEE/NLVdgYbWiE/dyI+/e4FFWdhuQrEJ1L0yolggcymIAdGyx2d0KrljvBkbKAPZ5Nms2cTu6YPVhbk/2rCU5eveGEICiPcwwr2yTwjr5sjhwGHPKNUXQuwV5lVDihK9/Glf3NC/qai4mooVmVLLgciFfGyBVVC7eNeO/MY+YJ18cWQjlZGeL/GL5GKaBD0q1/TlMZqyhGlSKj4E9Rzid3ib6TH+zJFXT3OPnXdwZyvH+0e444f+SFyoO3bW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pGbHEHA+Dfl8PiBRbf0uRIWCxvDdGeqeM1Cw3KbSpI=;
 b=deWiN+wfyEFHMbCTA9XC7yrnhPMjjrxmrLHjva96qi49/YEnkuWhLfNbFxQ5DeM91UUyoWpZRWZ+YjSYlK9o1gt7JQqi6sxSFSZJZ6c1ZmdBl8dSB2UNk4+s73D2hqdi24M8T95aobzwzJtjULMtEnsV7+cmRJvJzP/8Nqy6IZ++FZpHL4jSXsmXYyEqSd6fGXJdYqrKs7ZSt3Wn1Cpsh2n+8oL4P+p+9bXTvaQyXkFfGY4tKPsUBOQ02U5Osym+0/azO0LiSFWm33zJFkdnGgra7pNH8NcYJTWqckMyqSBo18SEHB9uMkvNKWhca2B1l66eVcacE/L89r+M6V9s1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4870.namprd11.prod.outlook.com (2603:10b6:510:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 18:57:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 18:57:49 +0000
Message-ID: <51a1b46e-9162-83bc-29df-8a154059f847@intel.com>
Date:   Thu, 4 May 2023 11:57:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177444676.1758847.11474266921067437724.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168177444676.1758847.11474266921067437724.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: 084b7eb9-580f-4c7a-5b7f-08db4cd17486
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBamODaLlO4EG2LLxEHsU8TQfvZy9zLt4Si3NmKDxEsTtHkuI5JHdooC8/d7edhRsooXAqkI0V+XyGxbmSP/EPwWrRKKDGkxnkbul2qbgRyn8YxdcdkgkX6NyzB1/k8msdvdS0rTtoriNqWL14+XhBOTkjMmIpgZi6ONWK5E9yz/+YQdJrLTB6gE1CFTacmO9+6UrpJ42OhlSEVlM+2FtMZEchRZg2ReDnW8QYvhP3My6GasH5rB8q0DwW/Z7gifuBdRrykmaubIGRGTMWoTM7cGgcJLC70ewqhdsp47p+0zrH6HJgNwy7VERAkbZFCwILYkbFrH4JAplAzRZ+VSj+jb5Qx8YJ/QY6eO7u0enhi1M6g7MdPWnOgLaDOPHefu1B4KQo6fpBjWKMpDbSqrRuyeT6SVvoQJ87tmLSIJUqd+NQixLdAvV4fu49xMnuEGU7fP/eGX6cpu6rYardYchM3Bh4sVvbCGjJb85JeaNeeLIer+HM6m7k706DeBQs7UsGiD2mogo2UIRlmTxr0qCXZYMXkDBLpLN9Jm0UrbcVkj5VOM9BPem5APqvVjHik/fquYoTLciZuw8UTum+NIhGllLX/yFh5RbScrtIXeCa1gzQiALGPdgh1ncEJpQAyGLFC4i83NEz3w8COym/mPWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(83380400001)(478600001)(6486002)(2616005)(6666004)(26005)(53546011)(186003)(6506007)(6512007)(44832011)(7406005)(7416002)(2906002)(36756003)(5660300002)(38100700002)(4326008)(66476007)(66946007)(41300700001)(66556008)(8676002)(8936002)(31696002)(316002)(86362001)(82960400001)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzdoK3ZZZjhNNTI5M3NtVnE1VFRDVTJKZ0syNmhqem82ZFhmd1Q5dDB6c3Fo?=
 =?utf-8?B?ZUlVbWFaK1MyRlo2NHNMOU5HajQ5RlY3dllZK1NVV2VTMXlRbVBOZzVKWGZh?=
 =?utf-8?B?ODYwVXhCSUVvU0g5QThEUVVZSElLV1MzOUhya0RISFFiTk1tWnhjUXU0LzM3?=
 =?utf-8?B?ak05RDdmc00zWEFieW1HRjJtbkZKV21CcTVLZkw4OXk3anhmUjFLSytxY0FN?=
 =?utf-8?B?QUM3K3pvYWMweEVWMU50eFVWVU1vZDhWTmlFN2g1VFJSLytPakV3SVQzOVJH?=
 =?utf-8?B?TEt4Zm5acUFuTldHVGszWFMxZ1drVEZaVnpTMWdNeXYzNFlhNzgwbExmSG5q?=
 =?utf-8?B?cVFHcTFNbXNqMmVRMWF1b0lIc2F2cDBWN21pZ3BsckJxc2Z6eTE3L2NvbFRN?=
 =?utf-8?B?RU85bHI5WnBCNStmOVExNUIvMHM2L3VFOCtyNE9MYS9tbksrenZpQWdneG9C?=
 =?utf-8?B?eUVTZ2R6c0Z4YTk3WldCVkFtb0w4a0hjeWQ1L2NYVmdHc0ZaSkw2ekhTSDZr?=
 =?utf-8?B?YWFNc0VvYlBPYkhsVDV5OGd4WGVzNVFaWGxJZEJCQ3Z6dXBpOWphcUhqMmFQ?=
 =?utf-8?B?QXJaVlZEUlVxTzk5Z21CclErbXNJU0FKSHZKUjFuVkV6REYvSWozK2luc0Qz?=
 =?utf-8?B?ek4rVWFiWUMrYkpTYjVnZ2kzY1pNMGJ6S2Q1UGhyZTJkVGFBR2JtNTdERzQ1?=
 =?utf-8?B?anFMSGlHQWJ2aU85RngyU0QxdE5ST0ZKUUZDTkEwOGJTREFSR05yTHpnMVNS?=
 =?utf-8?B?bmxWcGROU0hoQlFsUkZhbkM4dEVwaWQyaGVNay9WTXk5aE9vdG9pUEFKQktm?=
 =?utf-8?B?aG5IVmlYWjlRZ1YwR0x6WDhSWHI2QVhhd0FxbDd6azBsYmhqRDJFZ2R4YzZz?=
 =?utf-8?B?YWRwNmEvZ2tCS21MLzlyUmN1VjhyRmR2bWt3UXNCR2tXSkQ0SDExN2hmeDBk?=
 =?utf-8?B?TUp2SHFKc2EwaWw2Si9zNWovV3Z0TUY0cFFNVkJwREh6Uk9MdGNMVnZpbnlq?=
 =?utf-8?B?MnZSTDk4M0hTSENrSGlsU2NTKzRRUHNWQWhCNGQ1aWdHRkxraVp4ZzBMVjJO?=
 =?utf-8?B?QlFCbjJlYVRMNTNZZ0VRdFk4NjFnV2RoYVpCNlVWS29FY29LemtwVE4wTmE3?=
 =?utf-8?B?NW04RlN4RHpoWUlLS3F5U3pzOS9yblJpWnJFRXlCeUtsL3VUSzAxQmx1c0tM?=
 =?utf-8?B?VUI4Z0ZydW9Nb2R6ZzZIWmF4M2tFNzhWRXBVZDZrQnZmNHVqRmFIUnJVOGNv?=
 =?utf-8?B?ODRIWERjZmdZRGtKVHhpdmd3bDM3OTRvNmVDczhxNTdDV1FRNm1ESnJpQlJs?=
 =?utf-8?B?RUVMelJ4anpZNEJ5WkxpcEVaaVlMVUJpWnhkQ3M5Unp5K0d3ZTh0VjFlcnNj?=
 =?utf-8?B?VWhxcGpYU0dVMXRYN3REZVhqQzBBL0VnY2t5ZkJyQVBVZXh3cnUxNW1ULzQv?=
 =?utf-8?B?YndjZnFHTFM3WW02cXdOYzFVRThuaVdPMlNmdnhUdi91YTVSZDQrMVo3Sits?=
 =?utf-8?B?UmR6VHFNSkJ6V3lteGpSSEJFTWN4ZGRLM01OYXVGVHppZkVHTllZdkpGaDdV?=
 =?utf-8?B?T2JTWGQvR0pnaFVFVmI3TnlyZ202d29pZFBhNFFNaU1SV2Zic3ErMWpSaGF0?=
 =?utf-8?B?NkhaRUNwbkhDL0RKdW9TSlZ4Y1Z0TitDaHUyQlFQZUFleUxoNXd4Mlo5U2tv?=
 =?utf-8?B?N2VKbkpWTHlocUNMUHR1dm9kU1liNWw3aFc1dWNzdEdLMmNmT1lVQ0NYc0pO?=
 =?utf-8?B?b1poSEI0M0J3aE8zTCtSVHdVMWFvbE5sM2p0YVcvallrdkNnUThSQVBTQVZr?=
 =?utf-8?B?WHVldVVUL3VCMlpQUW5XQmxVU0xVamptaXZzUi9ydUMxSk1LWFdrVGwzTVFp?=
 =?utf-8?B?Um8vc2IvaVBVVXhtRE5vWFRqL0ZGUG5ZdzVpWXZQWSszWGxmTlM4amxGOVZi?=
 =?utf-8?B?MzNKUzV1VC8zc25ZaWl2TjZlNWdVbi9HZDJEdEQzcUo2QjZmeVoreWh0RWRM?=
 =?utf-8?B?Qm9VQVU1V2F0OGdOZ0RvWXhGbG9iTXZUbmpacXhJZWJQRjBlNlNqanU0QjVW?=
 =?utf-8?B?azY4N3k5bkpiU3haTnRkaXUrellxczRSUWN5bWtUdUIrRjV0YXYrczM1NlhI?=
 =?utf-8?B?ZXNCbzZDM2h2WnB2WXJlNTZvTWtmOUlSMmJYcmdXU0tPMGF0TFpZeEVlN0pY?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 084b7eb9-580f-4c7a-5b7f-08db4cd17486
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 18:57:49.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agbu2AApI81QlVlgAPtlZzvzMG1JvrpgP9NGOMd9dhontHorzO2hvSxo+3vOSoBU0Py90vjPXP7IVPpNXwN0yldFY+Gab0hv7wRSvTCNLfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4870
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 4/17/2023 4:34 PM, Babu Moger wrote:
> The resctrl task assignment for MONITOR or CONTROL group needs to be
> done one at a time. For example:

Why all caps for monitor and control? If the intention is to use
the terms for these groups then it may be easier to use the same
terms as in the documentation, or you could just not use all caps
like you do in later patches.

> 
>   $mount -t resctrl resctrl /sys/fs/resctrl/
>   $mkdir /sys/fs/resctrl/clos1
>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>   $echo 789 > /sys/fs/resctrl/clos1/tasks
> 
> This is not user-friendly when dealing with hundreds of tasks.
> 
> It can be improved by supporting the multiple task id assignment in
> one command with the tasks separated by commas. For example:

Please use imperative mood (see Documentation/process/maintainer-tip.rst).

Something like:
"Improve multiple task id assignment ...."

> 
>   $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst          |    9 ++++++++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   31 ++++++++++++++++++++++++++++++-
>  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 387ccbcb558f..f28ed1443a6a 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -292,7 +292,14 @@ All groups contain the following files:
>  "tasks":
>  	Reading this file shows the list of all tasks that belong to
>  	this group. Writing a task id to the file will add a task to the
> -	group. If the group is a CTRL_MON group the task is removed from
> +	group. Multiple tasks can be added by separating the task ids
> +	with commas. Tasks will be assigned sequentially in the order it

I think the "in the order it is entered." can be dropped so that it just
reads (note tense change): "Tasks are assigned sequentially."

> +	is entered. Failures while assigning the tasks will be aborted
> +	immediately and tasks next in the sequence will not be assigned.

Multiple failures are not supported. A single failure encountered while
attempting to assign a single task will cause the operation to abort.

> +	Users may need to retry them again. Failure details possibly with

I am not sure about this guidance. From what I can tell a failure could be
either that the pid does not exist or that the move is illegal. A retry
would not achieve a different outcome. I think you may thus mean that
the tasks that followed a task that could not be moved, but in that
case the "retry" is not clear to me.

> +	pid will be logged in /sys/fs/resctrl/info/last_cmd_status file.

Would it not always print the failing pid (if error was encountered while
attempting to move a task) ? Maybe just drop that so that it reads
"Failure details will be logged to ..." (adding file seems unnecessary).


> +
> +	If the group is a CTRL_MON group the task is removed from
>  	whichever previous CTRL_MON group owned the task and also from
>  	any MON group that owned the task. If the group is a MON group,
>  	then the task must already belong to the CTRL_MON parent of this
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6ad33f355861..df5bd13440b0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -696,18 +696,41 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  				    char *buf, size_t nbytes, loff_t off)
>  {
>  	struct rdtgroup *rdtgrp;
> +	char *pid_str;
>  	int ret = 0;
>  	pid_t pid;
>  
> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
> +	if (nbytes == 0)
>  		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +

This seems like another remnant of the schemata write code that
expects that the buffer ends with a '\n'. Since this code does not 
have this requirement the above may have unintended consequences if
a tool provides a buffer that does not end with '\n'.
I think you just want to ensure that the buffer is properly terminated
and from what I understand when looking at kernfs_fop_write_iter() this
is already taken care of.

>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
>  		rdtgroup_kn_unlock(of->kn);
>  		return -ENOENT;
>  	}
> +
> +next:
> +	if (!buf || buf[0] == '\0')
> +		goto unlock;
> +
>  	rdt_last_cmd_clear();

Why is this buffer cleared on processing of each pid?

>  
> +	pid_str = strim(strsep(&buf, ","));
> +
> +	if (kstrtoint(pid_str, 0, &pid)) {
> +		rdt_last_cmd_printf("Task list parsing error\n");

rdt_last_cmd_puts()?

> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	if (pid < 0) {
> +		rdt_last_cmd_printf("Invalid pid %d value\n", pid);
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
>  	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>  		ret = -EINVAL;

The above code has nothing to do with the pid so repeating its
execution does not seem necessary.

> @@ -716,6 +739,12 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  	}
>  
>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
> +	if (ret) {
> +		rdt_last_cmd_printf("Error while processing task %d\n", pid);
> +		goto unlock;
> +	} else {
> +		goto next;
> +	}
>  
>  unlock:
>  	rdtgroup_kn_unlock(of->kn);
> 
> 

Reinette

