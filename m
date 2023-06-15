Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D457322AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbjFOWXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjFOWXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:23:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E52967
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686867818; x=1718403818;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WqH+HikMwfVwZfwpECfHXxmqHFFgXXcS+/NqM/9zjGI=;
  b=hk9VuBIWe87QsvsErrgHwOIiYyiAX34rtYcgayawdwNKZGbjZkFn2KF9
   KiYBK+yl+L+iYSFXvJ6LaD3PrPn9akU2B5g3j5yUy04Lo0UmN1zWlI/yZ
   o2HwieyTM9jOu9BAzPvdZUb9uXmM405y07L9QO0y5cW1w+nmGEhF0Sntw
   wRPaZrCPlekVFyquJGnKczrn5fUftE6Vt0tqY4AUlejMDU2EF2gL6hc/t
   hwGg9Isy/JHxyRBy8Aamxu1JagpGRf3L8BJ96XHyiTF8EVpFQraN7oeSe
   vR9PmEpNpROhL/r7bvN6AqTOn3d6SgExu8i9p5k+SV6BG0Oty2DpBk3T5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356545670"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356545670"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:23:37 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745851807"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745851807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 15:23:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:23:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:23:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:23:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+9XBQmgMSCkCvk8E+CCLlbKkFCi7DHiQOHFmfY9ZyeKxYR6beHjD3SSwymZqciVr6/lFAK8Q8ELLtJR8FgpIs4ayOf7ieNtT3hZgccwgal7gJ4UdsgVbE3xZ1NSTPb+15NIMZ+1yGyicBF0ICfPJawrpbGi+iGyQdS2WqDyUdidENYCCgzPjVkIx6S32sF3ECoQBZKLmWunryCr1wKJlLBxu91zZBfjRGUi8EsYBzvr133/zRZKuA9KSnWsK4NrdkXzc+7+6OZ7FGtIxQXNdUMDbZdsfG03iKFkCe1cSKWsc0T20JfJ7smjUcle1hQayGZ+gHwykWn+nzUP7f9DKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcV8chhF+8krxaF1lbSqtOFP5ofE8OT5t2azDMMQBJI=;
 b=cbj/+Nq+uvUAWwohVwMjWgPXhUt16ryybmmjKEMfEynLoiUZYZ6SvrFIFWax/pV5ee6oRST8LjsXXpUxCs+0jIxTt/0tDLW+9DOPNtW9+hbHs9a4xw0Hbl6YYJP1WBgVmzIzIYOBn1afFa41rNjNBJGoxp25wQb8zuvHQLlMSwkJa11f3uIBrjL6UfYpp/ezrNCJwjJMXQlL8cDBjixM42eUNH1EaEYAXQ+beKg7Zfg3W+VdS5viU3D6uLyleJ1RVuYUs5LSKhXTYmgbfIQ479M7SokgaErwa9FwZ9lNV4XbGXgNL8yI0MPNU+u4QkPxX+8WABUIr8YxFq7lFbZsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW5PR11MB5932.namprd11.prod.outlook.com (2603:10b6:303:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 22:23:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:23:34 +0000
Message-ID: <9e340c96-507c-d6b9-b4b6-0c1d9aadf6f8@intel.com>
Date:   Thu, 15 Jun 2023 15:23:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 20/24] x86/resctrl: Add cpu online callback for resctrl
 work
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-21-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-21-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW5PR11MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4479810f-669a-43d3-568c-08db6def27fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdhUpqdhG+U+LXZbt5MR5WF9iixNkKn/ouj2SXmvDK+j86L90bzQ+G01zmg42kQvoL/AQAuGXmhb7sVj5IZJnIXirBqDO/C+IH8yTTeY50FQzRfn8Fl8wNOafapmfHRehXZPZqcSOAtE/HKeLWLY7rykQVNo0AJ3lixzs751DW5qECdPEzKAK+yvVofnhTMIG48eD4gux9d6WAX2lswKWUgVpXsRbb0EQhYOJc2V8K+6zB4kplL0Qxe4nbaBYOb30mIhZoX3McN160wyCyvb3bIJTt7t1ExIbbFWNyHQSzX5vbpsd2DB9H1Kv31MdHTwhDbY6r5468g/lltPZU0p4vg/uLQUNIguKq9qx9i/rhHz7El6wRBD/LTg8ikXJFNwrxZMb5z6847poSAyh1jLeWVk0iAfJ0hYI359lxnZFA1hHKMM9VtB9bqbV8SWz7gieu/AR9zOFLdAMF3s2SWA1Jp8sMUC6m4yj3hZ/X0nK29bD+ATkf1uzG+lm8mUFsrd4h2koCfh6UARdE5sqB+nf2/2GnWjiWUQlCWOSbITwkBzx1EOTydup/Zu6ZunuiWFlc05Usc9BsQuvsfvdF6seDn+eVjjk0ox3F5GDETY8rRG3/gijjQCZngCIneXNdRwmBBNhjlK7YYI4pODqyBnIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(44832011)(6486002)(2616005)(6666004)(478600001)(186003)(26005)(8676002)(8936002)(86362001)(66476007)(41300700001)(6506007)(5660300002)(6512007)(4326008)(316002)(7416002)(53546011)(36756003)(54906003)(82960400001)(66556008)(66946007)(2906002)(31696002)(38100700002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1RjM1EvSHVwak5aZnI5ZjRlMXRCcklNeUNqNGl2WURkSWlwdGdJMDJUZmJx?=
 =?utf-8?B?OUhrYzIzb0dBRG9ReXdwbHZZR1UwMmZkc2hjT0QybTJxcE9Jd2huMzlvbXlh?=
 =?utf-8?B?K2ZYV0luUnZxOE80V3p6YnZzaFZNUU1zcVphb3Q5VG1rVlhkTDVMVktmZnFh?=
 =?utf-8?B?Y1UzWGI1K0FmSlVsYnZaaXhpS1RMaTl0aWM3dlpiQ0JieE5GRkJybVBNUS83?=
 =?utf-8?B?d0xjd3p3NmZRbVhqaTNteko4UUZHTTlzVDFIKytBY1dwS1JucDY5Zkp2ZTdN?=
 =?utf-8?B?Mk1naldKQ25OVWZhaVUyZUMxb1ZIRzY3R1VwVUNpV3B4aFlXbUtxRXUvZGFM?=
 =?utf-8?B?NXRsazZlVDlnQnA2Rm5tNysrdVU0WnpzZTUzUWR2dzdMMUNKbk1HOVBBMFp1?=
 =?utf-8?B?bElEbW9pK0dKNmJRQ0dWa05PQ3QxU1NjSmxQZEsvcXN3cVNuT3V4MWN1d1Vm?=
 =?utf-8?B?Y01uWEdvSkNSRDVUUXhqSW5LMy8rTFVJZVQ4b2EwK3AwaUp3K0laVFovcU1F?=
 =?utf-8?B?OWNuSU5pU1NVZ2ZZZ3lkVEo2TmZEUnRyeksrWDB0elZGMlh1Tng2bCtQTGNo?=
 =?utf-8?B?MDlTeEp4SjM3R01pWG01OXlVN2QwdlRyMTFid1pmUmhEWGxoMWgwRzRQZUhp?=
 =?utf-8?B?VUpZalVzTkdCOVJCdi9tQnordGxnb3kzMGZaUnlBWGlVNnphbjVFb2Z6bDU5?=
 =?utf-8?B?QWg2NktSWXk4SmlkdXdMK3lUYktDUXplN0Q3aTBCSWdGVTA0LzV1S211d1lX?=
 =?utf-8?B?NVhySldXdGY5VlZIZ3Q2Smd0L0JBVHhWcVhsaHJmQURJNkE3a3JFL29XY1Za?=
 =?utf-8?B?bnQyY3JEaUZJMEZQcGRrZjdtSm9mZjlCTVhrVjlnWlllTDNYclhTUDdlMW4v?=
 =?utf-8?B?NG5Xeit5VWFqWFJnNzErUk9kT2RIV3h5RHorVEdSNkpVOVhZY0R1WldlM1hR?=
 =?utf-8?B?UnpEUDFzaDdtYnNBRjhYdmFqUlVlYTR6THdwb3Bxai9ESHU0ZG9aSVVNbzRq?=
 =?utf-8?B?WmxLdTEzQWZLWFB5bEFnZXo2RHA3cWhPYkxGWTZReHhOOWRIZDdKblFUTVVF?=
 =?utf-8?B?THZCSUdvZDA1UHNaSFE2TWkrc3BnU2ZaMFdrbkhwNFdla0NXUmNCbUVxcnhS?=
 =?utf-8?B?djZnT2lLNU5qVThGN2xGRmR5VWdsTWRlL2FMRG1xczVMWmU1aGNDeFJxTGI0?=
 =?utf-8?B?OFBFdHlZVi9SSzcyWlVuOWNIb0xHNm5RSzU5eEVPdTJaZCswTmpLaWN1ZCtt?=
 =?utf-8?B?aklpV0V5RnJYUEpjQjYzenZjOUlwaFp2MXBZbElicU9rZkhvWTEyUkI2dzFG?=
 =?utf-8?B?YnpncjBuSExxOXBEblhVc0o0QTI3V0oybWlwWE1oM2IxcXR2eFA2a3RxUHUr?=
 =?utf-8?B?aEpJQ1ovSmlzSVBpWCtBQ08wTURrSVo0WjluNHJOdE14QmMwRWUxc0hENVFh?=
 =?utf-8?B?NzJUcXRlVEVjZndWNjE0c0lCR1ZWZ1hhMVpWVHRyVVRYeVdWdmlqWmlKOUV4?=
 =?utf-8?B?SEVLMXRQMnJsZjdJNnh1ZlZUTHdNMDd3QUc3Y3hDby9ES3UzWFlmOGtJRVM0?=
 =?utf-8?B?cG9aSFZidjNnZi9rZjZIRVRwbVFjTVpybHRzVE8rdHhzMnYxejRMTkRkU3dp?=
 =?utf-8?B?SEgrM1hTK21sZTViamRUSDZYNXNZZzErY1pPdVVhYTNFejRjVzhpNm0vWlhj?=
 =?utf-8?B?bjB5M2t2VnNoMFpBMG9SSEg2U2RHVVY2WTdSVko3RThUeU8vOHJwZ20xSThl?=
 =?utf-8?B?VWZZYTkrdjh2MkdKbm9qT2dlY2tCY281RnVjVVp0aVNJK3BrTGRKVW51Uzd3?=
 =?utf-8?B?SzdNLzFIUkhzYmovQzlqcHFud1RqZ3BVRTRKeHpVVDZZVkt0YmVoSHpWUklS?=
 =?utf-8?B?eEp6Y0ZxYWRGVWRMUW5MWW5TU2xjRE8za3Y2WExiNGF3UUZ5OHIzV1RCRG1n?=
 =?utf-8?B?M2Jla2FNOHBJa3JuTGIreW9qU2lpZXFPeW1SYnp4R2RidDJzeDBmbFM0QTNM?=
 =?utf-8?B?aWdTOC9TYzFkWitDR3FJYzdYUmdYUDl0SjNDZlY4ZUZOZElBSXh5T1FjbTFJ?=
 =?utf-8?B?b1pnTUJ2ekE2US80cmlxMEM1RWdwMFhRcy8zaDdJZUVmQkNhUTQ2S3NWRmwr?=
 =?utf-8?B?S1hJSlY3SXRMY2hIdzRjRXlDOCtVZlY3L2g2ZGpaZEdQQUZwRE0rWnRLTnJ0?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4479810f-669a-43d3-568c-08db6def27fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:23:34.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILycAQ/gzLp/JFEJ1U3VYXiYe6avMZWHGUSSFHcEiAOtInIuxTJjUEj0c4ck6YbmIDA5Q/4smZPtfEp6yEBDJHy6b2Y0QAl3baqgHApZRoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5932
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/25/2023 11:02 AM, James Morse wrote:
> The resctrl architecture specific code may need to create a domain when
> a CPU comes online, it also needs to reset the CPUs PQR_ASSOC register.
> The resctrl filesystem code needs to update the rdtgroup_default cpu
> mask when cpus are brought online.

CPU mask when CPUs

> 
> Currently this is all done in one function, resctrl_online_cpu().
> This will need to be split into architecture and filesystem parts
> before resctrl can be moved to /fs/.
> 
> Pull the rdtgroup_default update work out as a filesystem specific
> cpu_online helper. resctrl_online_cpu() is the obvious name for this,
> which means the version in core.c needs renaming.
> 
> resctrl_online_cpu() is called by the arch code once it has done the
> work to add the new cpu to any domains.

CPU

> 
> In future patches, resctrl_online_cpu() will take the rdtgroup_mutex
> itself.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v3:
>  * Renamed err to ret
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 11 ++++++-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
>  include/linux/resctrl.h                |  1 +
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 4bea032d072e..e00f3542e60e 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -603,19 +603,20 @@ static void clear_closid_rmid(int cpu)
>  	wrmsr(MSR_IA32_PQR_ASSOC, 0, RESCTRL_RESERVED_CLOSID);
>  }
>  
> -static int resctrl_online_cpu(unsigned int cpu)
> +static int resctrl_arch_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
> +	int ret;
>  
>  	mutex_lock(&rdtgroup_mutex);
>  	for_each_capable_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
> -	/* The cpu is set in default rdtgroup after online. */
> -	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>  	clear_closid_rmid(cpu);
> +
> +	ret = resctrl_online_cpu(cpu);
>  	mutex_unlock(&rdtgroup_mutex);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
> @@ -965,7 +966,7 @@ static int __init resctrl_late_init(void)
>  
>  	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  				  "x86/resctrl/cat:online:",
> -				  resctrl_online_cpu, resctrl_offline_cpu);
> +				  resctrl_arch_online_cpu, resctrl_offline_cpu);
>  	if (state < 0)
>  		return state;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5330c0bdeffc..7c3de5ea0482 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3725,6 +3725,16 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> +int resctrl_online_cpu(unsigned int cpu)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	/* The cpu is set in default rdtgroup after online. */

I know that you just copied this but please use CPU instead of cpu.

Reinette
