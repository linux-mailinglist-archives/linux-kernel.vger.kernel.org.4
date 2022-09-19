Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2F5BD25E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiISQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiISQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:42:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EF424BD8;
        Mon, 19 Sep 2022 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663605737; x=1695141737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pll/EXF1RpvvFNGtzCFQ7zUuao+TUl9HkSMUnluwTb4=;
  b=VmgJcCZFVGhAuySEXndfzusSTVjEznczoG/MkxXl8snatX0t++GfxGjx
   DZ3Td4+3k6m1v2qnrgsYovKN+3D2b1ChnrLfFQm5FEbSlx27O4gQHM+jW
   7uLBNVcsWz6YfncuyHMJEXQNU7t7M4eKrPJ1qTt3ByOQ6TgXBfA42aovH
   Q5PPHvALhlRSSkgYN6F9kMZgo05FmcK/IVLj/eF3aioT5LUpQe29lKDo/
   aYiBhTpVVMvn1+fCJCupR2VW2y4ng+s7CdpgwyQRjb/lT9ODjZQJ43tHw
   dhz1dYWfU9BW2hth/bTHOmdnEMWCeXI9SEK6GPzcPHZzfWjbP7Tk4ftUh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="299442539"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="299442539"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="793922433"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 19 Sep 2022 09:42:16 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 09:42:16 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 09:42:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 09:42:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 09:42:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm1dcdQfVV6zk/l3g2O/vM6Xcc0cvnJh6k9bKIv7o4Hjo5WmXo6+CUtgXJLJOarUrdxVla6jN5LJ5Kg8bp9UXdACNDjQyqw5evkrm+l4lTv8EzK8lqLT67TjvMH6BIjba6gcPw7a5oQq1Bwnx/TbITKGv+KwUxTPYe/lgMhFSt7o3OEHj0lUa5lHVRErS2RlMlxNUSTw2QzLPrU3kpbvbv7NnhtQI+o6o7tcLBG8kh3x6HuCXo1Zce5ZKi9rBD3Z2WjmPA0R7/WrJZalQ8LemruaC1S5Tb+J+FhHQnALTbyOfZxH2cyKmWW2YrXCbvADg9NBNSFGvI5N77edk5JBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2uNNZ2tiqrSGIh3YwfGGfxBeZapMIYQqqtSXKraU2c=;
 b=fxVPPFFln1CmFYw0GAazzd32NEp+uw/cOx4+TJk8DZ/z3JkBBbWZ3aGr4L31omS7O03jbBgwkhuDp0EC2TgwMmeRsYGsM7eRbfvdGTY7Ue8vP422HiS8jnNaRzXBcqw9OJMOkOy9Y2H9fKnMRY3iEtBzy6xWZg6n40kV0l7d1dMDgn974FsHDNNA5DASN0/irMZoZgMEwPww4LXztnX/B0RzxA4Cj7ci7KzIzy2ZJsKRjsWy5saoYzYRSTxMZIq+nr7ym6IjhM9LNDcTrFTdPXvJGSGZgaR3XTx4BTrpQ+wxUqEQ1/aJQrAzEWQXwpJmfCFbPR0rLcH8JBc16/LqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4626.namprd11.prod.outlook.com (2603:10b6:5:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 16:42:09 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%11]) with mapi id 15.20.5632.021; Mon, 19 Sep
 2022 16:42:09 +0000
Message-ID: <bd424e21-c24d-fcf1-96e8-38c9f7546d19@intel.com>
Date:   Mon, 19 Sep 2022 09:42:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 09/13] x86/resctrl: Add sysfs interface files to
 read/write event configuration
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
        <eranian@google.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257366204.1043018.4834615270384002210.stgit@bmoger-ubuntu>
 <13294a8f-e76f-a6a9-284c-67adbc80ec7c@intel.com>
 <04132d34-c69e-62a0-35ba-bafa44210c0a@amd.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <04132d34-c69e-62a0-35ba-bafa44210c0a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM6PR11MB4626:EE_
X-MS-Office365-Filtering-Correlation-Id: caf35dd1-228b-41c7-2e87-08da9a5de4eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vT+b/5YTm5h9WHHXJHQYguDV5H8Kax43xIddaa6mnrDx2JZA6MbpShch7ZdPSQZdUyo0XiihM+ZQ7myM/MPMnbuqT0/c3V2ktEZfwvyC9A8WcQ8DPj0EuSRRqv3FAvvkfdy8lEvynPKdn9RfQQcqHXbjlAmNMl8tK7qq2UYLTG8DGZQe5L3xRmfeJ2ttKRcSrlcMrP3nzDflXmFimNv5vS61TMEisLntQmyS6TWCOQbkax4ozUhs+9JqyQsES61zreXnqHalHqcm3ZOFZ02kiFI0mCu8AhCqk3ECu9Ozp1CKg6O3XjS24Z7zzU4/wmFp2kN6g+tNZ1zZW8u2NtGNh0IUPU6CUqLihX4p5/ixEgAmWjHCrM0xF1XMJ5H3tKI3XGg4LpvQ//MI9Ph8/Li6VKBNCids0FIO4CXEYZGz9SarKfs4k2lrfzhBWl0N0M/AKeUUjDs3z/6K9au7RvNgIjXmrqQC+3TJNQ19u0SUwQNZ8gLxdXwEY1sXTfmEW/FYCCGVSZ3vJBnrzebFkPsSEcCbseQRI4EHOFV3YGyCPTXBycIfJHOKN5wG0mnXBP9eV30loSut+k8Y9kJVAXjO0sLEYpG9nc+/9yWSGfod1V5L32yyHj2DrOeGnT04zoiW+rFGircZJZRvA03CHyQJKDAwnGaYLezelT2UDJTzkQ91g7leSjuX8dRNfLzhcLr8lbFMUZ/4FpU2VKAxCglmZf2V2ToCzlwTpTkHKdLlMxPfpDg+ZaF1dHYFQzGHRHB8aByLhhYdJk6WPB9AmI/d+XdmNed4/cqhN1w390qoc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(44832011)(31686004)(36756003)(2906002)(316002)(82960400001)(38100700002)(66556008)(8676002)(5660300002)(4326008)(66476007)(7416002)(66946007)(31696002)(8936002)(86362001)(186003)(478600001)(2616005)(6512007)(26005)(83380400001)(6506007)(6486002)(6666004)(53546011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJaaHN4dmtQL3g4U2ZwWXBKL21ZYnZlUEJBd1NmcDljT0ptSUdnREc1UXJ0?=
 =?utf-8?B?Y1ozY0dkdUhxMDRTRlU4YjhPWHlIb1lUbjNSNWNkR0ViNGZFN1g5UHdjYVdE?=
 =?utf-8?B?K1laa0tObHVFRDI3dXRHQW1CYWhxNzBYYWtMVjRGOXZwNE9jY1N5TnIyaGph?=
 =?utf-8?B?TmRQUStOa3lqYlJEcjVDQjVzRm5GdVpUYXJMdWdLR2FJY3F0Y3FleUxZODFk?=
 =?utf-8?B?bHlMc2h6TzN3YWEyMkptL1hMSm80RlFHdVN3V0hDdzAxdWlDSzhRTGpmY3pr?=
 =?utf-8?B?RWFENkhTS2dZQWE1Tmh5c0s4VHZGclgwTDlmbWhqdDZ6M0JjcVZCOFlyOGJk?=
 =?utf-8?B?ZW8zVE45RkxHenEySXg3ek1CV0pUQWNnYXhRUllGWVhJUzBsNktZWGxHRENy?=
 =?utf-8?B?ZEhoTysxT2d5Z2Z3a0pGZzhmY0Z6ZUxSOGVJZGc4Mm0rajFScUVoNjVrRXAy?=
 =?utf-8?B?K1d1dXB6eUNvak9XMnRjUStVeXhwNzA3VmpYU3loWEEwMG5MUXBqZWVEQkF3?=
 =?utf-8?B?ajFqcGhlSnVVcEI3aGY2NnFNa1llMThIMFRJLzJkYUZIQU5XTG5BK2IxMGJs?=
 =?utf-8?B?Q2d5RGVrY2dBNUE3cDVnQ3ZHNlpXT3hXRktMYXB4VG54Y3lYbUxwSi93SllG?=
 =?utf-8?B?WTF4SU5UdUc4YU5BcGM5ZEVkeHlMcXdxK2VheWFyWXFJdFhWeUZZVjZjby9y?=
 =?utf-8?B?dURLbHJlb1dHaStnWjREa0M1Z3RMUk1PSTJSOTJVaDBwWkt0WnFuRmUydVdh?=
 =?utf-8?B?bE5VampvYzJpT2JNZkZ3dUVqdElETCtvRWRJd3VpNTd6U09EZWhZMlVNdjFw?=
 =?utf-8?B?Ri9lVGk1NHdMWUFNUThSMlJmdFkyVGF3WHcyVlNxaDMwTEw2cU12dDBMRjYv?=
 =?utf-8?B?b1J1NUpUM2Y2YzBIb2lwdDlIaUhLaEpzSHFpUUE5OG5iTHNLSk5OZTJld1pk?=
 =?utf-8?B?cjB2bFcwM1poVTR1NFZoV2QyckNsSnMrdk9UTlY2Yko5WWJxMS9PTk4weDNY?=
 =?utf-8?B?aEQxRUFiYUNucmUyQjQ5ZU95U3F6eVdmOWhrYW96aG82eGpRdGxZWHpKSDdD?=
 =?utf-8?B?N3J4ei9NOGFDSjh0b2dGZCtwYkN0M2VoclNNNnBGRkpPVHp4T2hoN3AyblhE?=
 =?utf-8?B?dEJMUmppbnBESEx6Vjl3R3JIZnJsOFJPZnhmN0EwZGhkSkgvVk91QVJwcXlp?=
 =?utf-8?B?ejg5bjgvaWthem52VTQ3dElVS25lYTdweFlHbXRVekEyM2FCaTA4VzlZc00v?=
 =?utf-8?B?MHhUR3lkT0lqNW5ETjZhT0t1REsyRkFxR3lSeW1pTHRZVFJ3MXNDckJ5Nk1P?=
 =?utf-8?B?VGRuMFd3R3FmZUkrR2MzYTJyYVlIUTI1bzRWelNPR2owZndSNjI3TzFGTU4y?=
 =?utf-8?B?dkdhbWFkZTFYc1ZrRUVBYTNtbVhJV0RObHJwL0dPMzNMNUtMZmp4SmJSbFF1?=
 =?utf-8?B?bklSOStnTXIyanNqN1RzNXpsVnQ3QjE3UFoyTzdZOEtObVpaQXNpbVMwNEp4?=
 =?utf-8?B?LzNBeGV0TTJ2bXRLZFlxR29XVVJ0Q1lMMCs2YUx1dFdpZURoZ1pURGJicm85?=
 =?utf-8?B?Y0F5dXAvNHc2cm41dzk4azQvUTM5M0dvYURrRndIaWtFa3VEd1BnWmZpb05q?=
 =?utf-8?B?dnVUTTVLNmpiVG15elMwajR4MWJIQWFkLzNxRDlCRHJydG1NbVExbVZPZmhj?=
 =?utf-8?B?dVNuaTQ1RWtqM1ZhbjVuVzc2MVk3bThPbmd6WWpQNzY1Z3VCejBFbjhQcTNj?=
 =?utf-8?B?Qlc1ZkFreVMza3hiN0dpU0szYUJQYjlYM241QWNJMVZEUzB5RnVFVFEvYzVI?=
 =?utf-8?B?UmJUbDZqcThwazZ3Vjh0Si9scUFqKy94RmN2anJ2TnZ4Z3U1YW95SG5qQnNK?=
 =?utf-8?B?Vjl5THZ3UXk3UmNMR01Qa29GeFJGN1J6NXk2VHFEeEV3czIzdk1CdGJDUU1O?=
 =?utf-8?B?eC92QmFLVVFPb2FHWjlYc0RoVU95U0tya3Zxb2ZNZEFNcmNWSFVVWVNveERE?=
 =?utf-8?B?a0wrTkJsVmtjYnhVRHBaUUhXd1MxT2NuZ0VkcjBuaVhmUWlxRTd2bE5YY2xC?=
 =?utf-8?B?NDlRSytJSjR5N2tyN0RrbFFBTW94dEVSb0N3Y0FwY1Q5TFpjVzBxbmtTbklW?=
 =?utf-8?B?UWY2d3ovVVdZdGhVdGVTWmZLOWJ3L2dxTFpvdytZRUtCak9QOE1xL2xvcW0x?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caf35dd1-228b-41c7-2e87-08da9a5de4eb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 16:42:09.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnIHUmksc3DGXZjiDFoQKIPP4sl24kPWpgceffy0XChNshoq2b8yKWQcsypIHf0SS1QJ3rUFp/igHHnyfDdwuTlxSW9DrIKUy6Ry18eJOSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4626
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/19/2022 8:46 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 9/16/22 10:58, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/7/2022 11:01 AM, Babu Moger wrote:
>>> Add two new sysfs files to read/write the event configuration if
>>> the feature Bandwidth Monitoring Event Configuration (BMEC) is
>>> supported. The file mbm_local_config is for the configuration
>>> of the event mbm_local_bytes and the file mbm_total_config is
>>> for the configuration of mbm_total_bytes.
>>>
>>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local*
>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
>>>
>>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total*
>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
>>>
>> This patch makes the mbm*config files per monitor group. Looking
>> ahead at later patches how the configuration is set it is not clear
>> to me that this is the right place for these configuration files.
>>
>> Looking ahead to patch 10 there is neither rmid nor closid within
>> the (MSR_IA32_EVT_CFG_BASE + index) register - it only takes
>> the bits indicating what access types needs to be counted. Also
>> in patch 10 I understand that the scope of this register is per L3 cache
>> domain.
> Yes. Scope of  MSR_IA32_EVT_CFG_BASE per L3 domain.
>>
>> Considering this, why is the sysfs file associated with each
>> monitor group?
> Please see the response below.
>>
>> For example, consider the following scenario:
>> # cd /sys/fs/resctrl
>> # mkdir g2
>> # mkdir mon_groups/m1
>> # mkdir mon_groups/m2
>> # find . | grep mbm_local_config
>> ./mon_data/mon_L3_00/mbm_local_config
>> ./mon_data/mon_L3_01/mbm_local_config
>> ./g2/mon_data/mon_L3_00/mbm_local_config
>> ./g2/mon_data/mon_L3_01/mbm_local_config
>> ./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
>> ./mon_groups/m2/mon_data/mon_L3_01/mbm_local_config
>> ./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
>> ./mon_groups/m1/mon_data/mon_L3_01/mbm_local_config
>>
>>
>> From what I understand, the following sysfs files are
>> associated with cache domain #0 and thus writing to any of these
>> files would change the same configuration:
>> ./mon_data/mon_L3_00/mbm_local_config
>> ./g2/mon_data/mon_L3_00/mbm_local_config
>> ./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
>> ./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
>>
>> Could you please correct me where I am wrong?
> 
> For example, we have CPUs 0-7 in domain 0. We have two counters which are
> configurable.
> 
> Lets consider same example as your mentioned about.
> 
> g2 is a control group.
> 
> m1 and m2 are monitor group.
> 
> We can have control group g2 with CPUs 0-7 to limit the L3 bandwidth (or
> memory bandwidth with required schemata setting).
> 
> We can have mon group m1 with cpus 0-3 to monitor mbm_local_bytes.
> 
> We can have mon group m2 with cpus  4-7 to monitor mbm_total_bytes.
> 
> Each group is independently, monitoring two separate thing. Without having

Right, because monitoring, the actual counting of the events, is per monitor
group. When a monitor group is created a new RMID is created and when the
counter is read it is per-RMID. 

The event configuration is independent from the RMID using the counter.

> sysfs file (mbm_local_config and mbm_total_config) in each monitor group,
> we wont be able to configure the above configuration.

I do not understand this reasoning. From what I understand the
event configuration is independent from the monitoring group. Thus, changing
an event configuration for one monitoring group would impact all
monitoring groups using that event counter. This implementation associates
an event configuration with each monitoring group and by doing so it
implies that it is unique to the monitoring group, but that is not
how it works.

Reinette








