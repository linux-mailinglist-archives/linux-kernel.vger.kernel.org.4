Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E566F8CB5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjEEXSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjEEXSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:18:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A64ECD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683328682; x=1714864682;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=glIPBa+7wgG1nQ3Jwx6zBR+N18LhZNJ0ZCrel1fcq1E=;
  b=FUDSlGy6ZiDZ2Bnjke7lWZHvhMc+tOgdj8NuOidSMAsWstBKyt/bnM+l
   jGadmUs8M7kuvkbvhK/pjRNV1cZ7ALU+xTvO17Bdcebr4vhajhxYTQV85
   kF+yxeBaXRktJkCNc4bvO7BtH3TYq03zCHYnVSYR8HKDXCePKPK5JLJxg
   glUY7ataS9jrGGjX8pUPB5TyIyT+Ct/bKyyFLvZdFTkOkT1XEDfInnUjf
   DqJlLNbovt+WEuJXMryU7/2bEdMVh9+UPJ3JGJOXAWfGuI3/t6JGfgTlP
   1wy4KqD1kvB7m7BeOva8xxbXp6w5l7Eggu0agyjsPsRHXcOMJ2LlDnUhg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="377397999"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="377397999"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 16:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="809450207"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="809450207"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2023 16:17:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:17:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:17:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 16:17:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 16:17:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/PAmu851R0K4vBKJqkDnicaf3S4DBRMyERSs673aYZGGR7CFM7Kv/Vdu80TyHDq+QykkWCzI/e28SS4GkQ/3sYSx98I6ExDtVxHGYtPl7go60Ph2V4K5C7fEOFqOf9fz4UwNLcnZaWHOiyZAkVRjU2RcV3RxA9kFW3A/QWb0q+TAYvr+NBldIqpFZHstkPGZZJGXmBTqYKddJWjaWz+NcYkoql+vKzr2PO8mBF/RYBcvjpjVqWsa+ve1YNhaX/EkMjEx7FmCzC3pSiV+9jkHBqTQHDByW2nXXE2Pdy2NJDSe15+42XRAi0eyKAGRdCxEWOcCkRS0U63OLbm66KVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTVkAS/zwNG5g1bVPpKyxpS7r2I4YogoLFFLm8lIk2c=;
 b=DKUSEkV+PM1FQPMEzQTgUnKUYeEkfidqZ7rZeCtvZWhDw9t0O+CLzGQN0793ouZ/mAAcdbGLT+IFHmYe3DI3nAtJ6H3kSOpXPD6y3SmOotlLqUdE16K0bbtH4lm9DuHVVrvnXsQmlZYc7OuxDgME1ZKLRPAFq+LQQrZcTwNn6g95sXgyI+LnVz/+1sCi1DviR+KQGs6Ixhme9hrkqNbQgBqSimJok8ontP0iPULpHW0KI9j5QtMZAr0GYM9lBDdxhObohv7eMpEULwtteJJFr0lyUZ8Gl10czTla8yn+bOm/XausW9CH+Vq4wOxo6/STE1PfY08Qsbb2omzK2EOe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 23:17:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 23:17:50 +0000
Message-ID: <14cea0fe-4e6d-daa1-7987-3d9ba7f793c7@intel.com>
Date:   Fri, 5 May 2023 16:17:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 1/7] x86/resctrl: Add register/unregister functions
 for driver to hook into resctrl
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        "Babu Moger" <babu.moger@amd.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <20230420220636.53527-2-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230420220636.53527-2-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0182.namprd05.prod.outlook.com
 (2603:10b6:a03:330::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 383fb0b4-6d90-474e-0d91-08db4dbef222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEVY1lavjkwtL/u1PlZ8RjTyjk0VAHCgroA1PWTZlDRXyZULiARgmKXSHQJtiW06IB041U04K/IT2ixMWbvDmuBsMlc6ywfgN52HRv2KJz3EEKwE3XJ0yS7vefHYkDgjvvXoawlfXFVi1yGGhSWQmYGJdUCpZexitXcgnEsSOsW30PEB4oFc0OSu1ehJAFfZ8gokeqR54QjaQaiqLLl1MaRPUoehLpeBvpN+rPlIy+fgNzbr611HKLDe1FlBLrclqJ7OtLdeix/vcLc6JoKbXYhuCnWLhexaEupXwan9vPYOVrD9Ryy96gOfeBM8J044KTf9qforN4E9/bPaFvEo/oe4dxPiasqs815sHSiK2mrSf6ARpKxr55wJz1ROHnt+JptpZa0ZYnM8JAI5eu9UG/y9T3qO/SRaSVYMBTvIM7EbdbwdPWsKCxitEXnAaQtgE7qsA7eb3reSQJ3W9Sn2xe9F9JTTViQqMAK4hrSzoeN/fmXOLDqOuKEMrDBIV6RZ9lM9hX54qKy0evewpp+QR31+GRCjB+byWBeAeo5kbvYslvVjPqWlQxDtuPJQZrl7hjAj19aVNNkgVi4E4jBE2u9Cp5xiSqDYIaz2EXKPGQ+9n2+AHLjlozF1rZcE3w0Udc53jJJ9VTZmfl2FzFHYTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(6512007)(53546011)(6506007)(26005)(31696002)(186003)(2616005)(31686004)(966005)(110136005)(83380400001)(36756003)(6486002)(2906002)(82960400001)(316002)(8936002)(5660300002)(478600001)(4326008)(38100700002)(7416002)(86362001)(8676002)(44832011)(66476007)(41300700001)(66556008)(921005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHNFZ2xSNWFUWk10TnN3RG5JZEp0NkJvTHVFaFNuY1BkRFdKc0gzQlpjd3FB?=
 =?utf-8?B?bUl4dTBqMzlGeHdRd1J5OVNkOG9tQjhvVDBZbHF4STR2VDRINTFFeU5oMmF1?=
 =?utf-8?B?Y0hLZmllSE1oNGN1RE9ZaE5UMUY0dmNlaTdRRnViMlJjbU45SzFqRW5xdWkw?=
 =?utf-8?B?bXB0M0krbmlJYWVyeWNWdmJLbXk5dzdwS3FESmx0V0JsK0lnTDVaS2hMS3RS?=
 =?utf-8?B?VXc2R3VoQWp3OWlUdHExTGR3eVVzdGppYlBsK0IrcXpmUmc2WGlySy9hM2lh?=
 =?utf-8?B?TkI4bkExT3B3bzRiRVZnV2plMUhEZGl5Zy9xQjVjMkU0cXljbU5XSWluMkdw?=
 =?utf-8?B?bEUrYUNtdGlPc0ZwOU5xM1RlM3hJcHlmbW9QWGRXajc3a2ZkWXhHY3FnV3Bl?=
 =?utf-8?B?RW5qMWxra0ZEMDJxUG1YS3JKOEVsOTAwNmhrakRhQmtZdWRESnRsY2doaDFM?=
 =?utf-8?B?VWZDZmpyVDNEM0ZadS9aTzF3UVIra0JFQ2I2MXJ2STJsV1Vrc3REd2NBK09R?=
 =?utf-8?B?cUV1cGQ4TzlzREtPQ3N4Q2JoQkhwQkNsekVqT3F6eG1qbGVUUnIxUHN6ckhM?=
 =?utf-8?B?SkFsWTJjQzgrUlV0OWZrK2w0ODFZUm1STVpGVFFBYWw0UElJQ0ZWRy93c250?=
 =?utf-8?B?dG1LU2R3RERKOW9NVUk2WFl5UXpLU25qTmMvSWdlWjc5KzFWWVlsakVhT3pP?=
 =?utf-8?B?d2xzbVdDQWFFRUtkUzNua1J2bGdmUExwa3B1RFp5K2lURVpFcmZLRlRNNHlw?=
 =?utf-8?B?KzVlR1ZrYWVhUjFMSjJiUytndFhJeHNDVUtOeUt5ekt3TEowZXhpaVR0K2Iw?=
 =?utf-8?B?UGNTbFFZejV3ZzQrMThYRTR0NDhsbmhXanBkWW1LK3JJeWdtVjNwSEsxNENk?=
 =?utf-8?B?V090UGtJUS9Va2d5M3hZTm5VWHdCamJxak5keXp5UXF4d1JKdUNJMUdQSnZP?=
 =?utf-8?B?MEhJUUZyS3dhc3V4WjdKQkg2TzNjZ3lmN2FGTjU5NDlTMkNWS1hwaVlhY01T?=
 =?utf-8?B?ZHF6ejVwUC9nYXVyRGFyVTdYTEVGL1hIQ2YramE2NVFjTy9kbFIwL0p4KzFO?=
 =?utf-8?B?dFVSaUhOZlQwVFZ6N1ZQWC9KMTVVQXRROTBxQ3JkenA2TkdTOC82ejVqZWpN?=
 =?utf-8?B?VFpiQ0k0UDRJaUprRkdKLzl4NkZHNnl4WnRXYkxIM1JWYnJwYWozb3ptdnov?=
 =?utf-8?B?VDNWSGtPWWRkYkhwRk9OSW00RDNJdmNUcHNiNHFnMVd5OTZhaWpsRmZZck9X?=
 =?utf-8?B?WjBqMENOTm1mWjZNRVhNb3lqZXJJWFZTMjZHcmZNRGpCc1N4REswY25CL25h?=
 =?utf-8?B?czdSWGwyaGtldUJDbFJGT0N5VzRBQ3ZNUEVZb0ErdFVEVEsxRGtKdG80YjNw?=
 =?utf-8?B?TTVlYW9YSGpYMjg4clRVR1dZUC9tUzRxVTlFa0NzQkxObjhkSjlFVW1GK0RI?=
 =?utf-8?B?Y1Q1V0h2alRXTFpwckx2clpnWElwenpKdlVNcERNZEtsSXdLQzJnS0JwS3U1?=
 =?utf-8?B?dENlVGFUbUR3WVI5WnF3VGlzS09Jd29lVEcveHVyMXFBMExiYURLdnFleUNp?=
 =?utf-8?B?RVFCejZhZkFuU0RoYjA1TzB5TWlnTGFZK01SaThuWHI0NSs5Q093cmRJbklP?=
 =?utf-8?B?UXZpVW52SEdkTmhjZU1aaEd6SVdrVmJUc2tjM3Yyc0tqQTBFaG5EUitwQTdt?=
 =?utf-8?B?M0VyRnU3b0pVQXB5cFRBTXVTNUdaS25EUlp0M1pyU3lJRXFtK0tMSkVaL1Ex?=
 =?utf-8?B?MDF6Y3FCcFdVU3NHRGwvVEtiMmlOODNZa0lkblU5M3RleEJvU29aMms3Q0Zm?=
 =?utf-8?B?cXV5cHVmZnV1c2EwdUZQRmVDWlVsRWZORHJRaHNpbFE2ejhTcDJBaUFQSXha?=
 =?utf-8?B?WWxESnpCU21taWtPUjFjWGFZZjVrZWE2L2c0aUNhMWI5SHplNlhGeEVIUCtB?=
 =?utf-8?B?eWdhcGxKVDMvVE9RMG8yV3RQZ2hlTWlqZ1ZCbDlQYW9oeHFNeGJJMmoxbnZr?=
 =?utf-8?B?UXl4dHB4cjNtSG03eWlqbjdCN2lVdkFEUThXUzhCT2Y0RXoyOHk1L1dJZEht?=
 =?utf-8?B?Y2NTc3pXOHdYZHN3TkxWTDFFL1hCb3hPS0x0R2tSOVVIaVRnSGpmY3B4cHA5?=
 =?utf-8?B?MmEydVZqTU9rZjJURVhRaUtBVzlJWHFhYjNGSjBPVXMrSlBGSWNnSWFUS1Nu?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 383fb0b4-6d90-474e-0d91-08db4dbef222
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 23:17:50.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItauvBheVCK2ur5gZoON9KLaoHOjkKV4KajCKxB1nswnz7I4IeJSMkZl24ly5elrLC1Zur5lklthe6tdH7G+tcU2FZ4lO4BwvHWp9oK0jFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 4/20/2023 3:06 PM, Tony Luck wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6ad33f355861..3e6778bde427 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -51,6 +51,9 @@ static struct kernfs_node *kn_mongrp;
>  /* Kernel fs node for "mon_data" directory under root */
>  static struct kernfs_node *kn_mondata;
>  
> +static LIST_HEAD(drivers);
> +static bool resctrl_is_mounted;
> +

fyi ...
https://lore.kernel.org/lkml/20230320172620.18254-13-james.morse@arm.com/

> +int resctrl_register_driver(struct resctrl_driver *d)
> +{
> +	mutex_lock(&rdtgroup_mutex);
> +	list_add(&d->list, &drivers);
> +
> +	if (resctrl_is_mounted)
> +		driver_up(d);
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return 0;
> +}

Do you expect that the drivers may at any time
need to call into resctrl as opposed to relying entirely
on callbacks from resctrl? I am wondering about any potential
lock ordering issues between rdtgroup_mutex and locks
used internally by the drivers.

Reinette
