Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8C6BC0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjCOXNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjCOXNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:13:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4BC132D1;
        Wed, 15 Mar 2023 16:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678922002; x=1710458002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KW3BfeWWoRnzAUmFy6n+9VNcMr0eup1IFfzKrmOhoa4=;
  b=XisGWnvFje7QJ1SvfiSCIwIeWSLm8zlQd7vXd5gfy32/XzeMIoPp4BBE
   hOFI4CaLMlDwOucZ0o3eR1BNEw512HiW58N1EXAc8wm3yTQUqUbpoSuBP
   /dm9kil1WwImliEdLT+ak6+REHsAsAdGQV/zkQYeYesocW/WXios5slyh
   lbr8lkG8R4C99OUEzGR0XYMb4Urh627cHXLAQSk4z05uQTz+RwXOSZYf9
   pU08jyw3T4t3deI/ToO94I/mn4EvP+aPfXgutXUJ+q+wIzFi98wXyuO5d
   ff9GiOPVsfCNa74LZyY6el1AsKoxOKmwPiy/QrkoHucVKW/CLYPGN9mDf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424111823"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="424111823"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:13:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="712108467"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="712108467"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 15 Mar 2023 16:13:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 16:13:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 16:13:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 16:13:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 16:13:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3RkTpJC242p1cC3jP2PEVtqtmBm1NxiuX8hj83d8yNO2VDLqaAxScU5wbAPg8XoLmyygeczbkfHKDHi4oPpbkRId5EFryMU3qpoNjLIr3ZlGk2ikXamqs9Movzx62C8eV47VOmXm3kvyxbn0ztwz00o162CP2MXjshll5v8n2aqP8Fco/KstXClknnr9ZqfH9Jjp/uEhCC4avNtKcYC9PEpWgQ5+Jtdon7Qoi1UPMJu8+EkGz34lQNXI3PmJCx1yghWeWfjd+GvuhAjBnc5ywxBCzxyUxyrE7YXb5Vd2hcf+4oFdphPVohTG86JAmhMAWSwVGIBfHrDNfUH9CfB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh5efMwi1E8QE6pZ3TC15eOdhsbyovRAsWqg0jx5V6k=;
 b=FrCpHI5tOuMG8THa73pYT+SBjJHEaAhR1A2c4+rA9jVjfhV+82IdsfT/5ycRqPgBxelUt8MVXXrDAaqVA7ShbbsHXLNDZXn0oaMiI/rvDg4JaWWKrlmWsHatS7W5DojQiIlrxALH5xti8wpIq4zuJjkQwE9wGTGMSMMUoaYNW3esJfAOD1skSDU5RlNk7o8/VqvztaQIF5kJclQWnAPWLXmKkwFCOevAt4lokxADUTCh59sCaqI3V3J40CuJf0Lf0BfIZUh30OPUoOlBmknvbOaSx3z/IOdMrqzV1oTQoDOZx4ICuXyfLZ/uN6cIKfnBsfAT/UKrKwk0EAgixdxcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS0PR11MB7407.namprd11.prod.outlook.com (2603:10b6:8:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 23:13:03 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%9]) with mapi id 15.20.6178.024; Wed, 15 Mar 2023
 23:13:03 +0000
Message-ID: <c34372d8-8166-6be6-b3a3-5214a2bae37a@intel.com>
Date:   Wed, 15 Mar 2023 16:13:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] Documentation/x86: Update split lock documentation
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Jonathan Corbet <corbet@lwn.net>
CC:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230315225722.104607-1-tony.luck@intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230315225722.104607-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::30) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS0PR11MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: e22fe527-b8c7-4a3e-82fb-08db25aad3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60I0LzZJ4wBp48lAbxwJUecTrVfd8+cYA1GqIQwKb4c0zQMDqYtZJydv+PQjJkAfmpE5Q5NHDnMf3e5+anLqgTFjiaftSiCkbgIjgLdafNSTkeLELZbyOgaIOZld3MLIMlPq95YlpYAvD9bQiQs8qR0HyJ5raiJvuRWyESS11r8i9a8r4x6aQviq6hiVh3LWeGO7LSLJ0BQD/d3AUj3Ev/TRgAW5CpMtbxjP+VgEYGgS6vAwnvtaUs9QN9gkIlGguYoEmFH/kMnRX5VhxI/aRIie2D/7DtVCSD1n6cRZh9gEiJrsBh2nOGmMZr6bXqAbxPXSbMs3H91uvOcDmdfIotw2a5+Q3k082yXSmDLJQ513EqEmhTcjZjS27ooHPO5XJfdYOzltrzUjDhAoeePJQuAQKqb9U4/UXn3Gv0qyNrNWdKkSQAh2wNcSazIzIEWQXP5HWXCT8a55F60dsqWr3xE3yNxIDPW/Ys07+hHbidaR0fpNae+ZpWL7fKIcg10t5AETbQeZ3hh3dY7yEhhMazXLYX4yEQ3cD2BtxeYD3mZrYWl1JDzMa9dQC98Ii8r6v82A8UFUgE1y254dHo3j2TiH26qCuOTGwpDOgsj5yeJG5FKIg5+rTgnsiQic39lNolyn3RlnzIHyL1Pi36VN9MJ8YJFzUUylFPV4jjT8rrJPBkBRjwohxgT3Ajee7aCQk15WwqyM1p3WotDcBTd+3xgkmdFc54+Nb8n7Bij1vYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199018)(36756003)(31696002)(86362001)(38100700002)(82960400001)(2906002)(15650500001)(8936002)(41300700001)(44832011)(5660300002)(4326008)(66476007)(186003)(26005)(2616005)(83380400001)(6512007)(6506007)(53546011)(316002)(110136005)(8676002)(66946007)(6666004)(66556008)(6486002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTJqTmdXZ1ZodTU1QzJHZmN5ZzVwN1B0aVg1UFp4K2Z4cnBzNnJhYWJUZ0s2?=
 =?utf-8?B?dm9IWmt0RVpMM3h2SVZhblJsM3NzOStBZWpzRFZYR0xIeUdJQVkzOEZoK2tM?=
 =?utf-8?B?WWlnNmY5UkcyZTZLZ3RNL1pwdVo2UmV0L0dFdDFxQWVUMkFwTnpzVld4NjNv?=
 =?utf-8?B?VnlRZVdTZVJYK1VkeWJMdjdSVmlFcjdnRStoM2JoV1dQTmJCMlQyNDRyQXVy?=
 =?utf-8?B?cWgvTGRncXk2eXJiMzRvc0RpYmhNWHA5Y2pZK0tHSEpFbGQzano5VytFcEw0?=
 =?utf-8?B?dXAwazV3WDMrbVNIWUhUTjZwdmdJVkpqckh6YVZVMDRSMGVjWEJFNnlhOEhs?=
 =?utf-8?B?Q1hmN2xSaFpjWEQ3eVBuQzNtcjNGRVg0WWtBWThWRWQvYnU0QmRmdFlwSERs?=
 =?utf-8?B?WWZBZEhYaGRSRExDUFFRMndWMFpxNDBhSVNUNEg1ZVUxWUdydUlWd2Q2M2s5?=
 =?utf-8?B?UzBoUHl1MFdvc1loaUpLZUZuckF0em16YXlOcjZPZ0l5Z2J6UHVqSXFSQ1JW?=
 =?utf-8?B?dkp2KzB5aEw1dXE5WXlndkVJdjRmSTBLbWhQN1RZL0hnYnhjeG9GbGx5OGVJ?=
 =?utf-8?B?YkFwSFB1bEZMWlNKRUc2YndjeWY0T2N6Z0tGWXp0ZFZIK2YxWkh4M2hZTHh5?=
 =?utf-8?B?ZXNDdVdQUStwY2cwU3NCd3RGdTVuT0JZMWxzN2xYelpSck1Lb1gvd05KL0py?=
 =?utf-8?B?UTRFN2MzTnU3SDFJbXR4Z1NLaDBFeEdpMnRQTGRyQ1ZlcGVYeG1uSGdTVnY0?=
 =?utf-8?B?am8vMkk3a3B3Z3dKc05IaTdnOUpSdWtsL1l0TkYrbThzMG1oZEJlMGloaVUx?=
 =?utf-8?B?ZDVNL29DU3g0ZDZaZWZRSDB2VXJENHdaUnNXQWdlODQ1a1UxTGFZbDFjNFJl?=
 =?utf-8?B?WGloZXJtQWh5R0NFOTJJcElNZ1lEMGQyU2RGOWgzU1NjUCtuanNNUzF5NW9C?=
 =?utf-8?B?SE96QWlDMHgvTWZFdDB1UlpKVStPd2NxYjEwZEdoLzBXcW1QWENsU3Qxem02?=
 =?utf-8?B?Z0w3cVpYWXhPbUtjc3JOQ1d1VVM1Y1MxR3lGamttNUFRWExka0R4dUdYUXFI?=
 =?utf-8?B?c0xDMHdTcGRKN0JGVDZXS1F1Q2Z1SGU2enJMTjZlQnR0MnVmSVk5cjJZdkwz?=
 =?utf-8?B?U0ZZK2VGM00wc2R1WDNZVHpyVXFpV1Fpd1EyTTFMeE5tc1JITEtIYTduTUNJ?=
 =?utf-8?B?OWczZGxhNmhHT3hsWEQ4eW5JVm90ZW5vWFdXUU9pb0I4MU5keGtpdTcrZnhB?=
 =?utf-8?B?Z251Z1lTK3djaVVaWkxpQ1RYWnQ0R1dVa0txU3JSQ2o3dFJnS3VuYnZIMno1?=
 =?utf-8?B?SVMzOUU0SVN3Q1lkcDRNazdjTXA5RjlCNytDMFZVQ2pUbHNrM0ZXM1lNMzc4?=
 =?utf-8?B?VmR0aWhQcDkzM2JEQjhpQ1dpbkw3MXoxNXcrb1Z0KzlMSGVvdVFHT2J2aCs3?=
 =?utf-8?B?ODE1aC9JL3FXK2o4Q2gwQk1tMmduVUpTdzM3SHdubm10RG1oS09KUEJyb0FN?=
 =?utf-8?B?S1k0UE9CYzlucTlQVUJCRVQ2VWFxK2txa0txbytSYUxURC8zdGtnQU1RMVVt?=
 =?utf-8?B?L09zWVp6MjdiaEhpNHd5b2MwYkpZUUoxV0MxSnY2MGIxNGlYOFlJZVhQNEdU?=
 =?utf-8?B?MUIxaWVoOTNlR2VBejV5SUlzK0t5SURheloyRStwZ21RdTVCZW85bnppMUtn?=
 =?utf-8?B?WThHQndBdzZIbWx5TndaQVVMaXhON1lhV0ZudUVjS1Z1anMrVlZOMlgrbWty?=
 =?utf-8?B?QUFVK2pyeHFjNkIvNERsL2hhSUZRWEErWEpPa3MycGQvMG9HcG0zZFI4STZQ?=
 =?utf-8?B?TTNOZlBVV20wZGRqUlNYeHFrRzRlbWFseGhjb2pWQS9qQWdCRFBKRGludm85?=
 =?utf-8?B?b1h2ZHpieFpUU1V6WFVocHdZVVlnOU9MczloMWFGNVVwMU01bTNMNjJKVE1Z?=
 =?utf-8?B?YS9DQlZRd1FUVUQ0NEd0ckdNTjM0NUkwMSs2R3NjMVJtOWFFSzJCT0g5dVo5?=
 =?utf-8?B?WU9RUmlzK1NmTEJHM2R4UlpPM1Zqcy95c1oyR1d4U2oxTVFrY0RLdWZ6Vmxk?=
 =?utf-8?B?akZ2SHhEcmlWamN2eXBTTnBaOU9KOVEwZkN3amdZdk9CbFcyRzRDZVhxWUo0?=
 =?utf-8?Q?w0guy6BIAsnGK6DbV3k4K1KqW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e22fe527-b8c7-4a3e-82fb-08db25aad3c2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 23:13:03.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKP5Gr1B7PuF2wXmxroacBFRKg+ROECm5apK3iAJvCKeqxGukonikK+s/i8mKf2SRq2Y/PTkZNxtb0Tze08hYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7407
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tony,

On 3/15/23 15:57, Tony Luck wrote:
> commit b041b525dab9 ("x86/split_lock: Make life miserable for split
> lockers") added a delay and serialization of cplit locks. Commit
                                              s/cplit/split/

> 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
> provided a sysctl to turn off the misery.
> 
> Update the split lock documentation to describe the current state of
> the code.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>   Documentation/x86/buslock.rst | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
> index 7c051e714943..31ec0ef78086 100644
> --- a/Documentation/x86/buslock.rst
> +++ b/Documentation/x86/buslock.rst
> @@ -53,8 +53,14 @@ parameter "split_lock_detect". Here is a summary of different options:
>   |off	  	   |Do nothing			|Do nothing		|
>   +------------------+----------------------------+-----------------------+
>   |warn		   |Kernel OOPs			|Warn once per task and |
> -|(default)	   |Warn once per task and	|and continues to run.  |
> -|		   |disable future checking	|			|
> +|(default)	   |Warn once per task, add a	|and continues to run.  |
> +|		   |delay, add synchronization	|			|
> +|		   |to prevent more than one	|			|
> +|		   |core from executing a	|			|
> +|		   |split lock in parallel.	|			|
> +|		   |sysctl split_lock_mitigate	|			|
> +|		   |can be used to avoid the	|			|
> +|		   |delay and synchronization	|			|
>   |		   |When both features are	|			|
>   |		   |supported, warn in #AC	|			|
>   +------------------+----------------------------+-----------------------+

Other than the typo, looks good to me.

Thanks.

-Fenghua
