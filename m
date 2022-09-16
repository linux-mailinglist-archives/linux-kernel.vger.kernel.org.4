Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962255BB095
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIPPyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiIPPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:54:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C7F17591;
        Fri, 16 Sep 2022 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343685; x=1694879685;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FYeUCEkonaJecGfJgbee5AfxKrr6duH8NiRxgLtOkP0=;
  b=HQnSjLjWq00VdU/YfPPWPGQmk7Fur4L31hSYeEzXuouKn/EMeFUhSzRn
   fTV2OYPWNyZzDfAFhFQ+NRjR7W6ko92vGNhRM9o4rQDXwDfLmRv88aDLx
   bO2T+dVWQScRlEz57WrW7Azvm5EOJOT90QcSGaQY8/D1YRI80uzVYz083
   2c47IrZKPts/etHO4a7wnIFgVKd8iA9d1WK089eOStg6mcXFeMDi+ouiD
   LNtIOZfocDDbAyfYjOJMx3wim7WewU0vmt3ph2oLXEjXiARjxSNWH47gH
   SSYzWNVWLnlDOkwDDsIl9XmSoAvKypKQjv8pCeEifxIrYYc0krUdyIwF7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="362981391"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="362981391"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="721465955"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 16 Sep 2022 08:54:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:54:32 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:54:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 08:54:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 08:54:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUIygCWHrBmIr6A0aOP6UmVajFv4bxEIn3kYh+wtpqyARXBwVA4Ro4u/zznGp0DaHCA8mbCbME2fvuJLNrLwGJ0GYXfhbJm4i38o2Fnjzfl3Fda0etFpskUtcTiIJumzhpwXKW3BcUU96VeQSA+NCzx/fAcl++LsFn+tOQGcQ3/56RNv9vbkPCfScSV4AwMAteap2neLwvLhoDwMxcHCVMWmBI4WA2lbMR6Onjq77L4z+CDRW5VDDoXTymxtcL07creMPUqb95FTro9PrJF/pxXmrRW71Qa3kYpoRyd+9HzIHXP6l2s5jSpjDq8kBNyR0Le3mkTjEc09LP/b7/Y4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msnkTyLPT8efgjpUShwMb3lD4v8Nm28BiwkdGG6SMhg=;
 b=MbK7iMEqHFbzOVX8Ejop3RWqsUXHA0x+Ui5hEJ2otkMGTtj7F2O4UnAsNg+igkBP/fZFAdjua4TLnGgp/EzB+ZNf4sUTX6JOJ6UyiRWrWzLXw6psYPVsZ5elt7rqk/kxdKR4fY0YU2wEh0K2U7E0cxVrfSHtkn/xtUnbA48lR9plZlylMAvxjetx6YP7Uch5DIIwv+8/ToAV+xMkgGIai/Qe1I468ARPE1gfY4kLLTpAWI85ldQDqqkdOb8CcAjxU7VmfjLH/EkLHrOHsGqA59o6IWttQ9GYn644SnR4I8WF+hY57PgRf4m5gc0UFKmiDrvtZMrROTv+CS5po4379Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 15:54:27 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 15:54:27 +0000
Message-ID: <ba36c68c-0b13-e8a2-fb45-8b84ea9f7259@intel.com>
Date:   Fri, 16 Sep 2022 08:54:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 03/13] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
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
        <eranian@google.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257361558.1043018.12046795385220064687.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257361558.1043018.12046795385220064687.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbe60df-e319-4be8-752f-08da97fbbbb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vh4a62cuOmCXwcugc6Zjf0oMj5rTdqeMtNOo5YZw51PCOHIRjGq3aMHVOVGCwfeMZo3Wj8DcaEJN2XamPPyBdAj9gZsgY/7B917VnrLu7lEcJHdlV7puqLF6w36R6bf9NcbJJjHXO55daH4Xr8QGwmN963CFzgy6jbiSFtUwWt11A9Z7C1Lxw2CZ6K9mOKjOF3CjvICZC7IrFKT4KvWMn/bK9XJEuFyuBr5KhORXLWTE0uIw1JigOkNqUskL3b8RvMI2xWiWfDGdl1SPCuujM0OTriFxVvenhYSQM+Ax7nop2Z6btZW//zelJHpN0agokU+0YsDyNIFEVh/iqR1w7onRJ/1YvPx9I4/alvwhRcmpTB1qOnzM3h6Pd86fzoohnMTyatcprW/DnxEaQz78ZMdkvx/K79zJ/1v/KCinuxgogxdg0463TftKhK5/a/VfseT0w5MwcRcPRgGvFbCC3f8H82lZbIbOARboNK52Wohfmzx5gCOC299IiIJf6S/tEFmxwhYpiBwEawickf6qPIs2eoYK++kxbJaUGGNjMhaW+NBAzHnXCEp0EKb5NHODkXHOR7Pdo8hIWEMlapd9kIjYbRT41ulvl1cUoWNFqXPRNxlmmzm38DyopuRodkVuBD9KoI7ZM5+2kdnLl6i/KzG6FnGpfKFadNpIVIUVjFGHvGQ+ZAlUOEZCnYsot+/8sJKOn/vy3Cb8raZ6eIRjEyvq+mxU8XJXKCxTnKA//0pgqXMcFbpvguTG8E15gxt1mw25wC6ch5SW7R6Hwmtwg61SLxtqNQdST6eJvpbjgIfTK9Kf5zXF/xTfyTbpmeP43MufWA3WvQyew9JTIXgBS2NwoGZgpUeIGh4LR+/XrMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31686004)(2906002)(44832011)(36756003)(82960400001)(38100700002)(7416002)(8676002)(5660300002)(8936002)(316002)(66476007)(4326008)(66946007)(31696002)(86362001)(186003)(26005)(478600001)(2616005)(66556008)(6512007)(83380400001)(6666004)(966005)(6486002)(6506007)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OURMM2IyRkZyQ01iMTZFamV1OTlhbXEzVUsrR2NiZW9FUGhyOGZLd2VlVDFJ?=
 =?utf-8?B?dkJjTGZGTGlZWFdtQzZhbitWRklMMjhSS1BXZ3VqblhRM2JiOTMzQTB2THlX?=
 =?utf-8?B?eEFlQkJGcnpReFZWRUVGSTlLNFg3dzZmbnV6SUVaVU9haml2dXp1UC9aTGNT?=
 =?utf-8?B?eUdCOWJvd0ZvVTlKallXT2ZZdGovWmpENHM2Y25hUWFOYkdDYVdZVWp4K3Av?=
 =?utf-8?B?d1N4TjF3a0FrUkZtTGJXbXRwN3VIcldLRzRXYU1xVkJQQm15T1pXZXI0YVhX?=
 =?utf-8?B?NFdvaFVIOFVkWlNwQnZiZC9xTXJaK1Z5QXpEZWl6bnVjWkRiM3I1cWZkOHVR?=
 =?utf-8?B?UE91R3BxSStUTE15ZzNtUGs2LzJzRDFQdzlZTHkxZlNkcWlQM0orVlIveWQx?=
 =?utf-8?B?M2VXM2RLU1lMdU1aaldrWTk4cTJMWFFPL0dDandPVjFVWXBKSkZhUkhWU0Vj?=
 =?utf-8?B?YmpPYXp2WTBQTFNyOEMzbTlZZFB2VWZBTHBqQ1hzTTE4eVZwNzJkSVRnT08z?=
 =?utf-8?B?dG5Cdk1QM2o2OXY3cmdyaUx4a1RMeDdSdDYzWjZDVFB0N0E0a2F5dExJUnVI?=
 =?utf-8?B?WmlWY3NKRWQxYWNUT2lwamdUSGNoREJZVnpuN29yMGVQeGtGRmNzZnV1NFNr?=
 =?utf-8?B?T2tGU3REaTc1cWNEajc1YTZrcnhsSW5FOHRLaXRzZE50cmhZTkU0ZE5wUzFF?=
 =?utf-8?B?VUU0STdzUCtkdEVsa1pScTFmeUlBdHMvN0RDNXVDdUkzbGpkYzhsaFR1S0tY?=
 =?utf-8?B?d3FxU2ZENzJQNitxdllLSXNPSVZGWTNuRjRqS2duZjdUcWJXOVpMdzkwVFFR?=
 =?utf-8?B?VVRyVWtibDFuVWl2L2hGN3Uzbi9MRmVxbFIrSVpVWFpwQ0Y4dmFPM0JXYTR2?=
 =?utf-8?B?NkMxU0JVVHBScnhsVnlZd1cxbFhObGdqaFBQTkRyMkxQU1VrYTNHMWwwS25K?=
 =?utf-8?B?cHRwYkJDM0FUYlBSN25DVUR4b1FJY3V5VDFZSEk2RDF6Vk5PczY2KzVTbE5z?=
 =?utf-8?B?WjJ5TWdDdzY1c2JjUWN2WFR2TWxXSUpqdU80YjdFdlBEcjZvRWoxdG5vbzNP?=
 =?utf-8?B?NGV2NytFZUg0MmEwWnpLbjd2R1BUODk1YXk0YW1QdDlWdnFCM1NsaXdhTDdp?=
 =?utf-8?B?OE9HVUhMT0NZMzM1NFBlVC8xMXBpYnN0ZUVNaGt1UXgrQXdNRnNvUXl2OEJa?=
 =?utf-8?B?aG5nRVB5cU5VbXo1SWVvQ2UxY0RCQ2RGcmtVZyt2cEhtSFZsUFRoSjJuUnhV?=
 =?utf-8?B?dHF3MEFkZXM2eGhSQXVVNU4vd2VEd2lQK3p3VlFxYW8vdERwSHBaVzhhTjlu?=
 =?utf-8?B?aCtrUVdlRG9hWFV1UEFaUUZ2SHNwTDBxbGhDNWVjQVE0YnNjNkFBYnJES2pM?=
 =?utf-8?B?TU1LRzRJQVB2WGFXRmh1U2JTNUZOcHh4MDdoRVJtcEZ1WU85VittVGxyQUhr?=
 =?utf-8?B?NHhEZ0l6ZkVnUmdxcnYvOERQMXYvN01HNzZ5VUZtbFBCdzlmSzY3U2s1WG83?=
 =?utf-8?B?eWVoUG1Vd1lJQ0x0SXgxeXlHT3RXZ3FWWkZVcHRCb0swUHRjemRDcXN1YUZK?=
 =?utf-8?B?Y1V5c0FnVU1jeW9paFVKUEc3cVU0YVE4K0JHR1NuOGtvQkx2Vys0ZWZlbTR0?=
 =?utf-8?B?UVFRSExkbk1USDFhV0d4R3lRQmhOWWxESk1XZlplbmRqOVVHU2FTMnlXSXps?=
 =?utf-8?B?MjQxT3QvK2JlYXVDYWhWRGFGS1hKenFua2grcU43T3dpMVFkd0tndXlJY3JX?=
 =?utf-8?B?elpFSnE1bTQwSEhiZ09pM2xVbmVaWFBTbUdmUVhiMXlkYVZPdkFPcjVrclFQ?=
 =?utf-8?B?dzdvZ0MvYVFTMGFqYTB0T0lIY0d3TkZ4VEpsUWV1OGQrcmZkd2RPREhyeVZ5?=
 =?utf-8?B?NFArNHU3MDRCd2lXeTJTTXFBNXlndHJKQkwwVzI2Yi9uNk9aZ1ZGUUNQT2lB?=
 =?utf-8?B?OWR5M20rb1hNR2NXQ1hYbDBoWlRyeHpuQU5STDZzWWZUUFVBNlVEMC9HUWhF?=
 =?utf-8?B?d1NUdkhWR01vVUl5OUFuTkVucXMwNG1UY0tZN0p2QytRN0FXTy9EWnRUVnBy?=
 =?utf-8?B?ODBZeDdOZm9sUGpxaXNzUzF2N0RYUW1XSlROZmhpTHdrWEVNdzNZaHM4OExv?=
 =?utf-8?B?Z2hrVXBaU0lXQUI3aTJiV1U3ZUY3blVQVHJTdG9FZmYyVGpqWWxTQ1lKc3Ny?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbe60df-e319-4be8-752f-08da97fbbbb0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:54:27.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxGl3MkyhrZkTDs7WtBkWJ4cPcttKi2cAIcgoqyuXpnwW617bxFWhvaoCM1IsCJdz94of9cvvsdaaupdLDZUSkxp8OwACBt3qw+zGf29IVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2022 11:00 AM, Babu Moger wrote:
> Adds the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS

Adds -> Add

> enforcement policies can be applied to external slow memory connected
> to the host. QOS enforcement is accomplished by assigning a Class Of
> Service (COS) to a processor and specifying allocations or limits for
> that COS for each resource to be allocated.
> 
> This feature is identified by the CPUID Function 8000_0020_EBX_x0.
> 
> CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers (ECX=0)
> Bits    Field Name      Description
> 2       L3SBE           L3 external slow memory bandwidth enforcement
> 
> Currently, CXL.memory is the only supported "slow" memory device. With the
> support of SMBA feature the hardware enables bandwidth allocation on the
> slow memory devices. If there are multiple slow memory devices in the system,
> then the throttling logic groups all the slow sources together and applies
> the limit on them as a whole.

The above is a useful addition (made in patch 13/13) to the documentation ...

> 
> The presence of the SMBA feature(with CXL.memory) is independent of whether
> slow memory device is actually present in the system. If there is no slow
> memory in the system, then setting a SMBA limit will have no impact on the
> performance of the system.

... could the above snippet also please be added to the documentation?

> 
> Presence of CXL memory can be identified by numactl command.
> 
> $numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
> node 0 size: 63678 MB node 0 free: 59542 MB
> node 1 cpus:
> node 1 size: 16122 MB
> node 1 free: 15627 MB
> node distances:
> node   0   1
>    0:  10  50
>    1:  50  10
> 
> CPU list for CXL memory will be emply. The cpu-cxl node distance is greater

emply -> empty?

> than cpu-to-cpu distances. Node 1 has the CXL memory in this case. CXL
> memory can also be identified using ACPI SRAT table and memory maps.
> 
> Feature description is available in the specification, "AMD64 Technology Platform Quality
> of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Issue Date: February 2022".

Please shorten these lines to the recommended 75 chars per line.

> 
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |    1 +
>  arch/x86/kernel/cpu/scattered.c    |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 235dc85c91c3..1815435c9c88 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -304,6 +304,7 @@
>  #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
>  #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
>  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
> +#define X86_FEATURE_SMBA		(11*32+18) /* SLOW Memory Bandwidth Allocation */

Why is "SLOW" in all caps? 

>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index fd44b54c90d5..885ecf46abb2 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
>  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
>  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
> +	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ 0, 0, 0, 0, 0 }
>  };
> 
> 

Could you please follow the coding style (wrt tabs vs. spaces) of the area you
are contributing to here? Please do so in all patches in this series.

Reinette
