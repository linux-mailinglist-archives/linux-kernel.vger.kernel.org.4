Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1110273AD30
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjFVX3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjFVX3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:29:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F34D2101;
        Thu, 22 Jun 2023 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687476538; x=1719012538;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2/F9ItZt6SkUsa3AIOYHJuVYZBdXMi54/h3clwX0dJ4=;
  b=HN0qbkjKCcaqvIzu90gfU8rtuyGW2ozcu9XJEsJTWVB3y+zbeXJV3yvc
   lUcNqbBdwGnwvrjwiSACVfgl0T+fkQd5kaWV69FhtInkEokZSHFEonxrw
   f1HR3u1Vlmd7ykdEJO45Xuf3pCNUSu2RNSSm2ua2V29opUarSAKJq7RZm
   svVEuu1LjWpLkJ2r4dtvtTfXkKg157DMLiKHgz6YnVLCVI/9rjI3v0Ysh
   MUsOD3aO0u64nWDhL0Y1grXl01yEqOJPimp+CZMcCHZuGOL1/+pSEdGHA
   fWQ9QIBTlxFQsNX6D845M/U+tBMDvwipIrMsqwkIUWHJUIlfRU0KIw7MD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447015012"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="447015012"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715119144"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="715119144"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2023 16:28:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:28:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:28:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 16:28:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 16:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq7IKsGOwDUTroyZ2if0urEeQxPQAZEuA3TN6+mHJAlXVtO/lHZKI5QVpvI63sNSZTQmEGbA8XLtPKqcxjCIqq0hOcFPe9ZPZKbKRxG9HW0BCAe8EXjRYy+idKgSlXDG+EUN4slm50lQfs7eQg7jHOLOfZgKjU+18q7AtnZCIBgyCAAB1m1Gy2vdyoHpjUmXD9IdOpTFqo1qujnwmeHcXQ6dSp+RvkDdLK2D60OuGzxqsdnOjnLwPdSu1WC7RfdEjxBOUngn7St7YrbIm7mKyeGpPx2tKVyguThapSalSimgpJc2iAJgUDuB3R+R3QsjwJnfnfAsgyOrywtEZKepXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN11DXEho+qiGjgRF1JcTC5GgTzOplatfRGQr8NQr0A=;
 b=Pzv1KEcLUCs1+a5VxgdcS2/V8U4Uy0sizer2APAaugY2JaHNwQAbDNNcCnsHxW3gvxdmdyRStblJxrRof0T8j+9hcpu8hkI4BxKs0gT8zGEHkEKfcEHJ6Vf8T7SxKMO3tHg+N2jNMrF+mExjlUTO2Tyfw1hBNAeeqaX8Hub0UVPcpavy4RasEahFjnThSgHFkBwWguKZ4ytqfRQQookMOZm+Dn+jgRZM7lK1NUbuxDLmSyDKh+RMLsD8ZKjzBTPODqI8H48FaB+IZALRd46y+DMvIkUWt2Hmx6gn8JtBLObqlNoYTlJf+0Y+kLGUpg+8FLy511I2/M48p9oqzpSvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB7878.namprd11.prod.outlook.com (2603:10b6:8:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 23:28:54 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:28:54 +0000
Message-ID: <0a5ee5c3-5850-92b0-dbe1-dded3ec5d0f8@intel.com>
Date:   Thu, 22 Jun 2023 16:28:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 10/27] cxl/acpi: Directly bind the CEDT detected CHBCR
 to the Host Bridge's port
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-11-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-11-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22)
 To PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: ae94ef31-d839-4de0-f52e-08db73787128
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APTQsQaz814WqI1jRv200MpSF0I5RQaT1wv+Q1ZMiTWWYUIxhKrrVesBWP52I468qM0ONTVY4LfdWpoIfEUpV768oYzAm8hUwap5Ma7GEC0yDMOU1nFeuoi9Meu0DTV6qn/G591PZ6VEpcf6Vli9H5yROf1jRUSPjILtDxJq90EhB54+7I0KMqxw6pmCFdwn/CgJmktjUNGSlLjoQDLSreD1jNUCOCpnidUR78q4VGPHCappOijffaO/UqAcr5LD5tHWDTuUhYTbQwd1U6biNKnVHPiuCCUWR3ANUmh9lEVdUuvTOKIzpcHspoN7K7raxp+8lut6yu9Y9qKPMduMjEgySinE6uGvE4QcjOdcn2q5+w+ipztRhw13k2eP0Assrv/+mijHkKQJOUwUwYuIzzbMVCThZXGJfnbHYJh8uONyCU7If2iDOsCZvRJ9zKt/AP2o/Vny3Vulq7f84/QhvHYdjQfl8CHs19lNOJaU9y2DiTcmw6FXtdt/BIpcQeVSnDIX4P7H6p6CkAQvC2epHzx8E1tyEaG6MBIdSd+UOHkB/EGagfEGCZdiiKxUG2BKUNVhmhXqn8u+SRbPVmhFA3KxoINTjFfG+74rW/P33xvZoCW6f4vBu8E5qUCSgSsZy/Rob9QDS5G8adYF4ZRlew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(8676002)(31686004)(4326008)(6486002)(66556008)(66946007)(478600001)(66476007)(6666004)(36756003)(316002)(31696002)(86362001)(83380400001)(6512007)(26005)(6506007)(2616005)(186003)(82960400001)(38100700002)(53546011)(5660300002)(2906002)(8936002)(41300700001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW9zbDBDMzFmVEhkOHVQMktJZFBzUCtLc3o2SldkZWdsM1NibXBtNnRoQjFF?=
 =?utf-8?B?eEV5THl1Nkc2T1h5a1RsTDRvOWhKVjJzNENBNEQxSW1IcWVnNWNEbFlsSFhs?=
 =?utf-8?B?Q3Zka2h3RlhsemVrbEJVWG96a3hpWmFJZVVCYkhIaWd4U3NMekJFTkRLb21r?=
 =?utf-8?B?bHM4MklCODN4dE5BMzBlWEp2dVBDdmtZSUh0WkpoSHJEWWF1NlBnNy9TUThE?=
 =?utf-8?B?Y2tmc2R5VUw0OFBZaFZLSWhtYWUxWEtScEgrVHpDSFNxeFQvSDVmSXZxUjdz?=
 =?utf-8?B?SWIwNDJMMVVtdHNzVXk5elZYLzBrVE1vSC9TUmUzakMrbDFEb1NpUFhXYjhT?=
 =?utf-8?B?MGRTMDZCYjlYK29na0F3Y2wzV1R3MkE0R0o5VHQ3bkJzLzJBV3RnZ3lqa0w2?=
 =?utf-8?B?Mjg2QmQ4UE5qeDlrbi81cmc4M0l0YzA5dVlQbWdlcVB4bGV5ZzBCUUNSU2xG?=
 =?utf-8?B?VmY3VzNSblpsZi9oLzdKUkh3Sm1aOFg2dVNGM0Y3ZTF1ZnZsWnlFdWsrWTR2?=
 =?utf-8?B?NXlyZnQybzVTdG9nejQ5enpUeldYNWpHNmtLK255ZllITVVhRm80Q2dqM0NB?=
 =?utf-8?B?bUlMQ0U3citwVGZJbjV4MW5FQ0ZwR2RQOFNLMG5uYy9ZZjhqc0ZCL1M5cnlB?=
 =?utf-8?B?Y1g1blNSakpIQUh3REFCbE9vRHRxWEJmTStXemI0dlJESjA1am1yUDhuRmZu?=
 =?utf-8?B?MkpoMzNmdVdOSnRmbmdMQ2JwRFI4cjZnazJGY0MxeDZLb1ROcUJ1ZmdZSVRX?=
 =?utf-8?B?dFpaRFRqNVV1Q0xEUm8rdHZXL1lyUnZnR0tpTXExTWZDRGE2bTJidjFQWlRC?=
 =?utf-8?B?T2x2c0c5SHJ6R0s3cFM4T3NUamw4TmQwT3ZWdU1ZcTJCeEticFRGM0JxWmlj?=
 =?utf-8?B?V0JuQm5Lb2h5ZnI0T2VkTmVDL3hxSlpGM2dvblpvdThMQkx1VTJ6ZkNIYy9E?=
 =?utf-8?B?b1lQZVEwQlYzUzlWS0twWk8rQzQxV0ZrdmdFaS9EZ0NOS0FzQWoyMlpRM1Vj?=
 =?utf-8?B?VmlEZGtQQy96MGhuU0JQcTJidU52UmU1UXRYT1RyY0ZaUm9ia3VTVnVkemFy?=
 =?utf-8?B?am1EY1Fqa2p0bHZRdWRQeFc5NHJjd3JDT2xJMTM4eEQzdGNURDlhUXBadVlP?=
 =?utf-8?B?alVYZ0VNbDAvR3ltSXBBY0Y0cUdMemRwZUl5bENnM1B0MUhDMGhIVzZJUGtm?=
 =?utf-8?B?RUZ5S3ljOGlmZ2UvcUdEY05RdDVFT09JL3pIeFJZUDNuZCtjamQ2MW9taVRS?=
 =?utf-8?B?S0hqS2JNc0haTTRFV3V6dlJQa3c4QlhiTFJ6dTVsU0VDRlVNOGNlV2VsRnhJ?=
 =?utf-8?B?cE5NbDBpU2wxTS82Z0FKM2Q0R25mWE5Tbi9oQzhqVXRjajR3UlVFRGJ4SVIw?=
 =?utf-8?B?RWNmQTBCSWM4eE1NMkcwUDFKbEFYRVVnb0RJdFJmc1NQNEM3bHZZTlFrQ25h?=
 =?utf-8?B?T0V1S2R0UkhvMTJYWm1wUjRoZjYrTXYyUzQ5UVlsVDlWU3oySk9oOUpJS1o1?=
 =?utf-8?B?MkVJYTc1TTVUNlptV2RMRkJjRUlTcnluUitPVUVRUGdwMXFMTmNna2lIZ1RS?=
 =?utf-8?B?clpWcWtjQnZ5Tk9wZXVxcWo1b05lRjF6WVhyak9yZGdtWjFFU0IxR3g0eWZm?=
 =?utf-8?B?TGU0eDZWSjZ0d3lVTGpQZ2M5WmhOSkY5akl2V2k0cTlteFNRNGFwZE1aSm12?=
 =?utf-8?B?c05ZaTRheExhL3VrNzdSd21LSXptbmIvSnE0TnZ6NEF1enUzYy9FcVJ5V2ww?=
 =?utf-8?B?dWRFbVpScjFZcXE4aDBJODFyVkxCWS9acFBWQlJ6akFQb1hIODV0VUFBZy9p?=
 =?utf-8?B?cTZ1Z0Q0QmdDSmh2NDhSN3RsSnBiNnREdHlsZmUrTFVSbWVrVUE3aDA2ZWtF?=
 =?utf-8?B?bVNnZmM2UlBuMVdRYTF3VDBGYWxJRG5jRHNMUTVsRUY3NDdTRUc2MlFzRUtD?=
 =?utf-8?B?NUJUNG5hQ3ZVaXQ1aUszNTdLVjZuNWlIZ1JrMytwV3NOTzdIdnErQ1dka09i?=
 =?utf-8?B?aW5xWEtScG9mMGZacnJoQ28rTmFvNUhrSThOUEtoMmRScWNnR0puZkxLUHFC?=
 =?utf-8?B?UElnQTRkNnNVT1E1QmdNSHF6NzFXT2RTSElSSXV3aDRRK2NPMGV0dVhPaG1T?=
 =?utf-8?B?NHNFV1ZCZXR0UFBEWlpUUy9lNWp3aFBMWXlvaU1xSDUvSjI4MmZmNEdRTkJV?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae94ef31-d839-4de0-f52e-08db73787128
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 23:28:53.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVjFLM9vD/TpaOLuvaELmfd1RS/ZxqjNRRmlwq6fDXwxO2yIWu2QANspZQ7c/oNd9FTJxSraAgrh386jPSdShQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7878
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



On 6/21/23 20:51, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> During a Host Bridge's downstream port enumeration the CHBS entries in
> the CEDT table are parsed, its Component Register base address
> extracted and then stored in struct cxl_dport. The CHBS may contain
> either the RCRB (RCH mode) or the Host Bridge's Component Registers
> (CHBCR, VH mode). The RCRB further contains the CXL downstream port
> register base address, while in VH mode the CXL Downstream Switch
> Ports are visible in the PCI hierarchy and the DP's component regs are
> disovered using the CXL DVSEC register locator capability. The

s/disovered/discovered/

> Component Registers derived from the CHBS for both modes are different
> and thus also must be treated differently. That is, in RCH mode, the
> component regs base should be bound to the dport, but in VH mode to
> the CXL host bridge's port object.
> 
> The current implementation stores the CHBCR in addition in struct
> cxl_dport and copies it later from there to struct cxl_port. As a
> result, the dport contains the wrong Component Registers base address
> and, e.g. the RAS capability of a CXL Root Port cannot be detected.
> 
> To fix the CHBCR binding, attach it directly to the Host Bridge's
> @cxl_port structure. Do this during port creation of the Host Bridge
> in add_host_bridge_uport(). Factor out CHBS parsing code in
> add_host_bridge_dport() and use it in both functions.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/acpi.c | 91 ++++++++++++++++++++++++++++++++--------------
>   1 file changed, 63 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 0c975ee684b0..89ee01323d43 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -335,13 +335,13 @@ struct cxl_chbs_context {
>   	u32 cxl_version;
>   };
>   
> -static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> -			 const unsigned long end)
> +static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
> +			     const unsigned long end)
>   {
>   	struct cxl_chbs_context *ctx = arg;
>   	struct acpi_cedt_chbs *chbs;
>   
> -	if (ctx->base)
> +	if (ctx->base != CXL_RESOURCE_NONE)
>   		return 0;
>   
>   	chbs = (struct acpi_cedt_chbs *) header;
> @@ -350,8 +350,6 @@ static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
>   		return 0;
>   
>   	ctx->cxl_version = chbs->cxl_version;
> -	ctx->base = CXL_RESOURCE_NONE;
> -
>   	if (!chbs->base)
>   		return 0;
>   
> @@ -364,11 +362,35 @@ static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
>   	return 0;
>   }
>   
> +static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
> +			struct cxl_chbs_context *ctx)
> +{
> +	unsigned long long uid;
> +	int rc;
> +
> +	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
> +	if (rc != AE_OK) {
> +		dev_err(dev, "unable to retrieve _UID\n");
> +		return -ENOENT;
> +	}
> +
> +	dev_dbg(dev, "UID found: %lld\n", uid);
> +	*ctx = (struct cxl_chbs_context) {
> +		.dev = dev,
> +		.uid = uid,
> +		.base = CXL_RESOURCE_NONE,
> +		.cxl_version = UINT_MAX,
> +	};
> +
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
> +
> +	return 0;
> +}
> +
>   static int add_host_bridge_dport(struct device *match, void *arg)
>   {
>   	acpi_status rc;
>   	struct device *bridge;
> -	unsigned long long uid;
>   	struct cxl_dport *dport;
>   	struct cxl_chbs_context ctx;
>   	struct acpi_pci_root *pci_root;
> @@ -379,41 +401,38 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>   	if (!hb)
>   		return 0;
>   
> -	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
> -	if (rc != AE_OK) {
> -		dev_err(match, "unable to retrieve _UID\n");
> -		return -ENODEV;
> -	}
> -
> -	dev_dbg(match, "UID found: %lld\n", uid);
> -
> -	ctx = (struct cxl_chbs_context) {
> -		.dev = match,
> -		.uid = uid,
> -	};
> -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
> +	rc = cxl_get_chbs(match, hb, &ctx);
> +	if (rc)
> +		return rc;
>   
> -	if (!ctx.base) {
> +	if (ctx.cxl_version == UINT_MAX) {
>   		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
> -			 uid);
> +			 ctx.uid);
>   		return 0;
>   	}
>   
>   	if (ctx.base == CXL_RESOURCE_NONE) {
>   		dev_warn(match, "CHBS invalid for Host Bridge (UID %lld)\n",
> -			 uid);
> +			 ctx.uid);
>   		return 0;
>   	}
>   
>   	pci_root = acpi_pci_find_root(hb->handle);
>   	bridge = pci_root->bus->bridge;
>   
> +	/*
> +	 * In RCH mode, bind the component regs base to the dport. In
> +	 * VH mode it will be bound to the CXL host bridge's port
> +	 * object later in add_host_bridge_uport().
> +	 */
>   	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
> -		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.base);
> -		dport = devm_cxl_add_rch_dport(root_port, bridge, uid, ctx.base);
> +		dev_dbg(match, "RCRB found for UID %lld: %pa\n", ctx.uid,
> +			&ctx.base);
> +		dport = devm_cxl_add_rch_dport(root_port, bridge, ctx.uid,
> +					       ctx.base);
>   	} else {
> -		dev_dbg(match, "CHBCR found for UID %lld: %pa\n", uid, &ctx.base);
> -		dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.base);
> +		dport = devm_cxl_add_dport(root_port, bridge, ctx.uid,
> +					   CXL_RESOURCE_NONE);
>   	}
>   
>   	if (IS_ERR(dport))
> @@ -435,6 +454,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>   	struct cxl_dport *dport;
>   	struct cxl_port *port;
>   	struct device *bridge;
> +	struct cxl_chbs_context ctx;
> +	resource_size_t component_reg_phys;
>   	int rc;
>   
>   	if (!hb)
> @@ -453,12 +474,26 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>   		return 0;
>   	}
>   
> +	rc = cxl_get_chbs(match, hb, &ctx);
> +	if (rc)
> +		return rc;
> +
> +	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
> +		dev_warn(bridge,
> +			 "CXL CHBS version mismatch, skip port registration\n");
> +		return 0;
> +	}
> +
> +	component_reg_phys = ctx.base;
> +	if (component_reg_phys != CXL_RESOURCE_NONE)
> +		dev_dbg(match, "CHBCR found for UID %lld: %pa\n",
> +			ctx.uid, &component_reg_phys);
> +
>   	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
>   	if (rc)
>   		return rc;
>   
> -	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
> -				 dport);
> +	port = devm_cxl_add_port(host, bridge, component_reg_phys, dport);
>   	if (IS_ERR(port))
>   		return PTR_ERR(port);
>   
