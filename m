Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4CA7056A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjEPTEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEPTEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:04:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95309015
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684263829; x=1715799829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1vnHw6aze0H/6j4r+BcHYLYIMC2HkKcACVXczEh2Mgk=;
  b=RbigMRlXDralFd9QYTdX2YZcMCOIP3mhvmi8sAhhh07fGIYlBws4UyJU
   WmWg5kM5ol4bRHGyQH4zp3TMzAEtQg+Za8RbpYfCKDvKBYeJJsUjvfaq9
   f6o6Eo5jLmzsQEYJcwbPdTKxoNHHBqz2pIaqMdPEIhzOl2kTO7LqLB3dP
   a4jnrA2nWrYk/nu2rbWCn8Wr4h1m2y0AXhVsAQobBJxFGoP+G5zIIcQ8O
   kYWow/LmtrVFP23fvUUwOyu6NceGnLGrhaBcmHwOpZHCLoFUJP368qsU+
   hsSWHeMOasEqoUUOpTDGOd673id5k4TAhYHn+013XQ6/L/9KyWdjavLjR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="354729362"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="354729362"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 12:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="695581474"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="695581474"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 16 May 2023 12:03:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 12:03:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 12:03:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 12:03:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 12:03:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS4EUh74MAcoXvf1IfwT4cc864+P/3rKx7V/ajTi1dn0Kpg0cp9ZrT6EcXxkTYmewZwKKtXLJWjAxRYfDdPu0TiM4OSDBG5L9jK7hC8x9sV/KS7U/3IwMPpwxctVrqe7LVW68kzEq/laT9gE+c3zMa+XhEy4uyHTjcq9MuTjuvymN6ALiFJbpImfm4NUUnEdV3kbd0M+hNK3A2jW5EtxiwgrxaGoK5usRh0v3E5xpqvzfgEdNRVco3TRnCFujLBBOuRF7RQHqqU9Yc07IQ93qpVP06JmEHa/ZdWo7+MI7k4lnp2nwTGhCVF0Kd/p6M44hv3BbimqL6h4R8ledWsf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kaPANXFyTEQlZkP4QZJVO/puJxrpbgn3OvbzoxbRHk=;
 b=NQUcYml1lJmGyuA/GtdZ6xVxS5KlPwUhEh2sKgDIuE8qinAxmP5j/MPocFJCd12pyJWAotkf212CBeLW4G1/gbGOPTa9tqfPpSvAb0JN+JXBBSLBR4d6egbSkqhwoBmS8AMGqf9fntQjT+67Hg0tm3fkLRug1Z6NWXM7q1rF52dAQHRXvvwNRPm4UuV+wNWPRKoaLLdENbZV2zqiCbGyyLorid6awpkMttut7LassPxcEoMQtuWjc6GleIe4Fgc+Alfbjm/CPy3RR3I05JjTcEg+s2TH1R78PuxeH0zl8Xa7DOWWmNPd7yvOTy/cF7CgSFbPuSdbi1fBFpkiYUODjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW3PR11MB4569.namprd11.prod.outlook.com (2603:10b6:303:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 19:03:45 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 19:03:44 +0000
Message-ID: <ace6ad64-75a9-716a-8845-9a2c92820dda@intel.com>
Date:   Tue, 16 May 2023 12:04:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] x86/resctrl: Only show tasks' pid in current pid
 namespace
Content-Language: en-US
To:     Shawn Wang <shawnwang@linux.alibaba.com>,
        <reinette.chatre@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <20230515060448.50446-1-shawnwang@linux.alibaba.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230515060448.50446-1-shawnwang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MW3PR11MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: 029c2021-5dde-491d-e5d6-08db56404501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/L0qqs+gIHc0QflisnvxH0r0+nMy+2yiQJcN3m8bHLczk/zPelYRoJYHfNZNQxdgtOEKoaJRNSfdG/mT4eSiUOlnZ2ieJnkg4XI++TnYDL4PcsQMNWvGpmDH7hz2OjyJXw7gz6NpBH4TgTK3dC6AgpS9sy5ha1lk4NxAs6kUwYPgQMvoCXGUri42WV04zoaaS0B42hqvDPM5lZ1714xBZoUE2bkqh4MaG694mPhESlR4tr8rLsN8zTOXVvxyBxQpDVUlGX1TyMFxvhPAsVgg7v1oULWRixnG8N2+OcuSIFBa3Fq0fVPQKb/yPFjjurbWzAer55xiWSpwgGarW2LLhpigA1OVy9hJcygD2UEvLPjHJUqIsZr4II07mKjjp9P7SQLmWTnW+aXp87x10S1jOujMcU1U/KlGLY7QI45mopxk66nrHL7iaiUoX7xePLg1n/uSfY6C2chhxdsYDwYiJjohsYaUY6I7G4wgmyoG9vWmRtkYA0c3HnYkKMs3KtsjozMSyrv8mhlNtFYdZj+GsvTlXny3N2/1Vh7M04c7udBD3gNfrNA1lvFBElyKx5/6YWBdv8wuK/sQcCgHIce/UgDQjMATlATNt/IqyS7skhEjlBaLJVwShhuV1fIbOCYpZdKP6DVlUKq9gnU8fFZww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(5660300002)(8676002)(8936002)(86362001)(44832011)(2616005)(966005)(186003)(6506007)(53546011)(6512007)(26005)(82960400001)(38100700002)(41300700001)(478600001)(6486002)(6666004)(66556008)(66946007)(66476007)(31696002)(4326008)(36756003)(6636002)(316002)(31686004)(4744005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVlYSzVub0hGMTBsdElFUTdreTV5QzJjcmtXWlJrVnFsOUMvaXVrU3VMVkM5?=
 =?utf-8?B?SVVmcEpxQ0xnT3dQUDVpamVxSVVRSi9nVDM2eVQ2emNpSkw2TXgxNnQvWUtx?=
 =?utf-8?B?Qy9WTlR5T0s1VU5sQXIxRllySHhXamV2NG9KcDZtUGszS3ZDb0t4cUtUckFr?=
 =?utf-8?B?SmlxVmFEeFZ3QnhLYndmYzJ6L3FIMWFPcGJzc0hBYmhTdVNOOGxJQlR6bUxI?=
 =?utf-8?B?V0JWTjhiOUhzZnVORWFXOVptSFNGLzRiblFMTG1XSno3azNYRER2dHJrRE91?=
 =?utf-8?B?UXdvSXNMVmhFYkdDL0llWnM4K0p0aTFyZUZ0aDQ3U0F4TjBSSEJHdXlqejVJ?=
 =?utf-8?B?bkR0WW1YUlUwWkdZR21hbVV5SG9QVFg3STNYWVJnT1QyR3YyMHJMK1hLSFla?=
 =?utf-8?B?dEZmSVZ1THJmLzZ2d0hkOGFaVUZlRmRkU3JBOWMvRU1xOVpYVnN3R2NKbUdW?=
 =?utf-8?B?T3pYRmpqbkdETW4vWHBBaUhFdmRmZzdvNEtody9SYkhaa25nRzFCSE1ybEdr?=
 =?utf-8?B?ZCtOa1d4SS81K1RyRk80Z3p3ek9Vb3FrNU9wQzBvRThGNklqZW5JbnBpL1Ni?=
 =?utf-8?B?anAyMVN0SEZvck1DUWd1eitucXVTSHJ5bnZDdklqdzJaQU84dW5LczRqRDhp?=
 =?utf-8?B?NVlrVi9INTdtUHIrLzVxOUlUUW5FK1FvS1BiV2FGNFRqY09vSDVHa01PMjEr?=
 =?utf-8?B?eW9NZVJlWnNjbXZnOU1DVmFZdEsybkF1Z1R1eTYxQUVmRm1YR0VSbmp3Y0pq?=
 =?utf-8?B?ME05Z0JmT3lrcTd3SEZWZDhsaE1kMVFCRmpOTTFEUXl0S0lydW5YSnpKVGor?=
 =?utf-8?B?VThMZnRVQ0JqNkpNcy9MRWFSM3hhZ1pWTXpuaUhKQ01EQmdGb01aZml0cEtZ?=
 =?utf-8?B?N0ozM21UNlM1VTZUZVdpLzdzNFg5U3RBV2JEamZFMWd2UlpMcWJqZnNkSkxB?=
 =?utf-8?B?QTRzTG9ncHBQWUNMczJHbm9qRy80MVJzWnZqaVNmcTRUN0xFc2ZvT1d6V2d6?=
 =?utf-8?B?ZjZoOEw5bG9iKzdwYlZ5WG1xNndjZzRleVpoNDdhSzhxREM5N2Q1eTBsaEsv?=
 =?utf-8?B?OEJmL3lIRzZIZHA2a1hyV0ZZeGo5Z2JIeW5BZVJqcFpkdW45VDdvNXR6bm12?=
 =?utf-8?B?Y1hoUy95ejk3U1JGMXRmRGMwWkJadEIwYVVlWUJiL3hkOWtCQm1CT2l5MEFr?=
 =?utf-8?B?MWFLbWJlaElldFdkcCt5RlJtNWgzbHR5ZGpYQjJzMHQ4QnZQNjJtdjFSeVFD?=
 =?utf-8?B?ZGZWem9DVGd6bVBoQklZRkxuQU9GekdoSVY2dmRtc1c0aDJETmcrckl0WmM0?=
 =?utf-8?B?ZXZSRWw1ak1SYTZ3RloramJuWHYwWTRReVhURnNRMjJseStoVGQ2WUYzNXl5?=
 =?utf-8?B?dHM0OGhJQ0lKdWpGVVBFQ1JKZ0NzQ3FQNmMyQy9rR0s3ay9DMXdld3FlTjhM?=
 =?utf-8?B?ODdmL1c3SmZvWlMrZ0ZURVZXeXoyLzZ6VllUcEpwREIzbFh4NkEyTmp5SDln?=
 =?utf-8?B?Ynp2TUtSUTVJaGozNkI4NWhXUHAyVzV2M0MrM1BrYkwwNTBWbm5Rb0ROQTVY?=
 =?utf-8?B?WnNZVWp3TVVFbFl6bXppanRPRnFORStoNDR4WG1TcTRtamhKQkt5bnd0Rmc3?=
 =?utf-8?B?c3lob3JDam1tLzJENEZ3VnVzQS9BUkZiS1Z6UnBjU2hqcXhaSUFUZUQ4NGgz?=
 =?utf-8?B?a3ZCaTUxTmd2dExKRHgveTZabTA1SWN3VHMwUDI4RUpZNUNGK2l3RmVjL3gz?=
 =?utf-8?B?ZzVDMmdNdUtlRHlvbkppUTBWdkhub2I4YjEwMCtHVG9Wc1FxeWVSMXAyNURG?=
 =?utf-8?B?SjF2Tm55RVo1dHdhMlNQUmVNdjh4eHlWNjZJd3lPV1d2ZWpmVmdEL0QwSnl3?=
 =?utf-8?B?ZloxZ24xWXBGWHdGcWVMUW9jb1lmSVZNSlRkTjJOQ0p5SzZTZmZvR1IrYlpN?=
 =?utf-8?B?cXc2ZVNxQ21OVEVjTEZ6WEhOWWVjUnJsdnc2RWRESXJuc0FXcVU2YzJqcGtz?=
 =?utf-8?B?NVVJSUdNN0UyNk5BV3BQYVBPZStNMkJsNE1oc1Z0S3ZVVkJzVGFYVFNiTDdV?=
 =?utf-8?B?Ynh2VG1UdVJVTlRDQ3R4RkF3c29VQ293TER1QmtpOGpERVFTMFBCT3FBajJF?=
 =?utf-8?Q?vHvvHZK1QhDEI06T63K8Vv4gs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 029c2021-5dde-491d-e5d6-08db56404501
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 19:03:44.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2w+3ncdwdQAfFnzTcRZ3T1q/NC83etgUpu0a/JBJufznnnn/YyZ9ZsG/apEPPiybtL4IXzNuFo+je8LNj7tS9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4569
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/14/23 23:04, Shawn Wang wrote:
> When writing a task id to the "tasks" file in an rdtgroup,
> rdtgroup_tasks_write() treats the pid as a number in the current pid
> namespace. But when reading the "tasks" file, rdtgroup_tasks_show() shows
> the list of global pids from the init namespace, which is confusing and
> incorrect.
> 
> To be more robust, let the "tasks" file only show pids in the current pid
> namespace.
> 
> Link: https://lore.kernel.org/all/20230116071246.97717-1-shawnwang@linux.alibaba.com/
> Fixes: e02737d5b826 ("x86/intel_rdt: Add tasks files")
> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
