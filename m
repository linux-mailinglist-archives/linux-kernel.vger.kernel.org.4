Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2502B746F2E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGDKyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGDKx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:53:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B759BE76;
        Tue,  4 Jul 2023 03:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688468033; x=1720004033;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OqfXxZL1XkpReOu85FTX2wdg9KV6jUowJFeBWEcwZk0=;
  b=MKy/aMsqiT09MNmspzMkCDqKWAsBNl6shp7x+w1mxZqnlOEf88M0TMs2
   JR92aeplM997VG/LTePl2zu9vPt5Tznp8XeYQx5EaBAkdxqffaXQiRMsb
   9nZzV7uNZ8OH9hS3CE6A7WpscgMfM+71Xz32kXq558IcD8yiHPpJFmV+8
   RbFQH/odRCzc7ASDRfSNLPWKsohBJ+dVUgeuwTLIMhJ/AdHTH5xIo9HAS
   Z2HheBkNBVR+ZvsoYlh66Lg7aJlxDT7NLfl01xjJ1LgobAO7zvfc7BXGZ
   qEr+giyLgkND+Zes8n8g1z2Uz+R3Piw9crX8UFkYrfEAc/CMRlL8HATZ6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="363129831"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="363129831"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 03:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="808888113"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="808888113"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2023 03:53:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 03:53:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 03:53:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 03:53:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 03:53:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbMmOMQdCtD5+iqiwoA6r/O9pv+t921Dv4LQefFBUpMcQla5wiOabvgbDeDoG3by9a9oHunA90yekq8PiLrMLTtA2+LptO/uyTaQg8FHcse5fbEjSRXzBSatzbbBbi7V7UXRLXcL7X+E1j9Q0gbzCSUI6238snyUSxGByfBhTWFymFNI/PbAjs31Ks0v+G0TMC5VSMhE+YuLege4qVL7fwxp+NHMH7NSEmp1ydllRMGlkxVh4DJhk/mYazH/sXnxkAEsUarWWUTxm5Ls2MovN2dbq0v9BqNNJgyn+FcKTM4oTFJQxfc5tPs4pArXHJMOwgCE0wHcJFd3e7bQFHij+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Keqj5USjOaaYstJzBxqxPpmOAGSWMRqt7sVGqHIHxPc=;
 b=FHQEfDB8zpdstZQDYwcvxhkSYcefsnmJ3T2e7ICD9RpDLtYwMV5IN4Wg1mCMXsKcVTCtYmeDDpHfC6Kd2Y+f2BXRXymfEwSd2KYbKswxiVluMLTHL0kw20NEXKwOH/EOiq4oVHasRiRPMe+DvTxQtBQtAhPo5ma6/PyJwnzQHRrQSUyyWfhVrAp8Gzp0Sak9bWkrwhQ93eQK1vjmxZSgS+KPnKZ/0saauj64tvcBZyImpEhtFMr9dUoc1PRHHviW5nwT4pkQotClYVlls0Hk0Y5xnNRP3FeWdmKSH9HBE84bZsuZc+3btQgVzGlHvPI10ijJ22yWEDHzzYIMrXsw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:53:49 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329%3]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:53:48 +0000
Date:   Tue, 4 Jul 2023 11:53:36 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     You Kangren <youkangren@vivo.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        "Bruce W. Allan" <bruce.w.allan@intel.com>,
        Pingchaox Yang <pingchaox.yang@intel.com>,
        Bo Cui <bo.cui@intel.com>, Karen Xiang <karen.xiang@intel.com>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <opensource.kernel@vivo.com>, <luhongfei@vivo.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5] crypto: qat - Replace the if statement with min()
Message-ID: <ZKP6MKGIUnX76Myb@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230704094208.642-1-youkangren@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230704094208.642-1-youkangren@vivo.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|PH7PR11MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e2244c-ee73-4058-b58b-08db7c7cf23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JMB0CKHCwqP3Y9LMtKlt8j/aJk6Z7xZ64/UkQIXFXlRW2MLpx55Y8mGoxUsuYH0KWB2nVw/V0vQlY5JiFOVkGUgDS9VIcGK9g3X2f29SKkFRbFOLYDFN+K3N1xAwk4WrANaOkB1gCwNBgBhDMHYdOJ0vloXRjbI+vHZKoIQnTPMhisClu9t11OqqhfEqRqksqv3opzJ/5EdoRdT4+Ctao3mI3PDXGSZcZKCXnAN50qmKJ4/df1PbVbMUYe7Lc8g5KpB7ulRL72sZ5pSc9lGYP4amcfQa8oUjGq2XaOrnOVhVwjcGwKNak6HIlG3q3kYaUqGRAzEYJRQAOhSUkGCIxIzfPzXEMQ0DXUzJlcMBSB8KN4u0W85ufZxyWY0ZILXjTrk0kNbVXDCOTalQvfGM7pSA7Dl3RePV+XaO9QaBG89PjemY/tgVWOpue671hpL0/ft8C1mT4Zl3XUmpeyoM9SuzU8I3LiCOL2zQ2qt6jI6QKVl/POQrZU4HFDnoRqMjyX9Le8jjLHxXrzsM9zqZMN6/ItlIul8FZ9kgWX4DbDrnh1EWvHCXSTguERuczwA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(44832011)(4326008)(66476007)(66946007)(6916009)(2906002)(478600001)(316002)(66556008)(8936002)(8676002)(5660300002)(41300700001)(6512007)(86362001)(54906003)(36916002)(6666004)(6486002)(38100700002)(6506007)(186003)(83380400001)(26005)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JWzHxPmYcukT820INeshoAE1sH8l89ZhiJbkTVyDQFLqtW9SvaJlwFQiKQGe?=
 =?us-ascii?Q?WRpuqNWPFRVXWlgw8vh9PiJSAHGfPkyExONAZIAwRTdSMbMTgw6eR4u/1Ui0?=
 =?us-ascii?Q?kFDxAsUVVjOZsBquXrXCPH/56M8K4lZrZliuLfkxshrrr+YbC6hq3kcsPBoO?=
 =?us-ascii?Q?haF7L7YzL/U3/8lbQumiE58gegGhB5+Wwtmf5ysg6eSp39K7IlIh1yZem4qd?=
 =?us-ascii?Q?x9xVf5WPMUbtkkhnXTBRAyInzM7QKhLRTJrdLloFPq9X/asYYTHgPKwqsqf3?=
 =?us-ascii?Q?cRq3H6qDeuxthrTh+oSfaeBG1KgAs9nA0yy6FCSUZlQaNKwU0/x0Ud086gyb?=
 =?us-ascii?Q?aIao1Tk/lEisHbeo/AHCS0IwVP6GUY/5uP1NapvFha0Bbq27WRBqT3SOjBaR?=
 =?us-ascii?Q?J5QgE0MZhl1B4Yp7va96f5Fvp6rWkv+T98CiePw4XcoThJeiFAjbZ5Md6yDW?=
 =?us-ascii?Q?TMkSee/qX1n/JMdfTLJODx99JeSgHuBDrCjXh4pFWwfWath6qOJBQu3/ujrc?=
 =?us-ascii?Q?poZFJ0R3Tz/5sGF+/aqR4L9ldDNeIJ1xkuj1pUfKFHvpJ9yTMM1Yup0scklP?=
 =?us-ascii?Q?OY6ga/niBZ0P5zgiCBbUI3AnGgV15QVQqn82BHEpSv3r0mdw0YNhi9epWI6J?=
 =?us-ascii?Q?NglF0Et9AF7UgeK6Y5IobbpTM5LOXEXwpYgj08NdKpyF9ntk5zsnJiAQLBT8?=
 =?us-ascii?Q?s/2IKMbbebyMPlIjjAvJS5KbtrZFyFx6G7YKjS1kuO+8Pv4xb5KMu2CQ0X8E?=
 =?us-ascii?Q?4gTIP5inFL/+ps+WkIkfR8fiBcR+HjjPQwHbsoQiLEVhPL79kDn7rWazIwYk?=
 =?us-ascii?Q?tYUph2Dpzs1oHGqtgVEeGUgkMZren/qinLcllNQoXmwvcgJND24xIML83zFe?=
 =?us-ascii?Q?NJ8YoXtZ7s6QhxxD000ILjuy9SoajJX4lIUVyiBnIAyu0Q7d/ePdu0WJ74P+?=
 =?us-ascii?Q?Al1f2g/n+vY4pHiTp+RDYFyshvO3+cTDUphUmpixNQ6luhAqYBMxDvCF8vMK?=
 =?us-ascii?Q?xWWCpDnejZ+4djJvbQ9OxG9AkE3T0MOhc01MJj90B33ILEPQCfbtzsiEpHWG?=
 =?us-ascii?Q?sNAKKz/hDTp9Y1Xv2uShCM9m/pXAwMXTbvvM9XjLV5Zad+sbzmAAuJJwmRgX?=
 =?us-ascii?Q?emIWWetP6jatLIniQKCb5Z9KrhELYHWZpZDppEDjA8a/qrXT0VDhu+cjjJAx?=
 =?us-ascii?Q?QCHFrXWA2zGSTRSj92YVmGEfK2B67EHwLMmsRkrfH7Hg93fetNgqT6cV+MNU?=
 =?us-ascii?Q?Xr1gnIh1qBSZRVZhx1FSC2yJ6fsTZEwwRzsYqfUwX+ZhKCMaz0IuasDqiiXc?=
 =?us-ascii?Q?kJhrBVp1AkaNxKtR8PVa6jV6qDsd6ETSMIkyJG6iF0QM98O/ageO70WWszOz?=
 =?us-ascii?Q?TvTldAqryEOctOho7XTmXN/wkKhSrsb9Ufq9XTRgCZKF+71rrTaNQD5HIG6W?=
 =?us-ascii?Q?G8iOHTv/VoyjSsqdYxGfygOPA/93YfDshX8dzOBOwya5psurJYj6Axfc0vlV?=
 =?us-ascii?Q?7e1ruEWG2ZcMRxu1nChat035F4SkyB3PfG44KcE8aT8B14BcA6sMjcsGtwgu?=
 =?us-ascii?Q?5H98RLMk0Gojr+y+fOP1AoCgPlVUozXut33VCK/zt58JpVZ4diUZdDLH0ULT?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e2244c-ee73-4058-b58b-08db7c7cf23f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:53:48.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DnNOvl/OWCEeNTVovXszN6P7tjBG8nioqGNQsAMfN3QbwVH8qDP0EUs+MofVuC4eQBoAqCbpyCAc8ytkw7ngvlFvfUbsMlwf5dY84E9Y8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:42:07PM +0800, You Kangren wrote:
> Mark UWORD_CPYBUF_SIZE with U suffix to make its type the same with
> words_num and replace the if statement with min() in
I would separate this in two sentences.

> qat_uclo_wr_uimage_raw_page() to make code shorter.
> 
> Fixes: b4b7e67c917f ("crypto: qat - Intel(R) QAT ucode part of fw loader")
Why is this a fix?

NIT. On the headline of the commit message. Lower case after `-`.
See
    git log --pretty=oneline drivers/crypto/intel/qat/

BTW, you could reuse the commit message I proposed when I reworked the
same.

Regards,

-- 
Giovanni

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: You Kangren <youkangren@vivo.com>
> ---
> Changelog:
> v4->v5: 
> - Add the Fixes and Reviewed-by tags of the patch
> - Add the version update information of the patch
> 
> v3->v4:
> - Remove the header file <linux/minmax.h> in v3
> 
> v2->v3:
> - Add a header file <linux/minmax.h>
> - Mark UWORD_CPYBUF_SIZE with U suffix
> - Change min_t() to min() in qat_uclo_wr_uimage_raw_page()
> 
> v1->v2:
> - Change min() to min_t() in qat_uclo_wr_uimage_raw_page()
>  
>  drivers/crypto/intel/qat/qat_common/qat_uclo.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
> index ce837bcc1cab..4bd150d1441a 100644
> --- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
> +++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
> @@ -11,7 +11,7 @@
>  #include "icp_qat_hal.h"
>  #include "icp_qat_fw_loader_handle.h"
>  
> -#define UWORD_CPYBUF_SIZE 1024
> +#define UWORD_CPYBUF_SIZE 1024U
>  #define INVLD_UWORD 0xffffffffffull
>  #define PID_MINOR_REV 0xf
>  #define PID_MAJOR_REV (0xf << 4)
> @@ -1986,10 +1986,7 @@ static void qat_uclo_wr_uimage_raw_page(struct icp_qat_fw_loader_handle *handle,
>  	uw_relative_addr = 0;
>  	words_num = encap_page->micro_words_num;
>  	while (words_num) {
> -		if (words_num < UWORD_CPYBUF_SIZE)
> -			cpylen = words_num;
> -		else
> -			cpylen = UWORD_CPYBUF_SIZE;
> +		cpylen = min(words_num, UWORD_CPYBUF_SIZE);
>  
>  		/* load the buffer */
>  		for (i = 0; i < cpylen; i++)
> -- 
> 2.39.0
> 
