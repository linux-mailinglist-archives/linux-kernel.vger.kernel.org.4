Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992146C540F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCVSss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjCVSsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:48:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA8B32E6B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679510923; x=1711046923;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=xi7rV083NkhYAaHwOo1yUOeKq7Z2ENlcmOwKV7QEPL0=;
  b=lmzgy8F4VxQoKW41HVrpEDMXAEcyFYhGKmkCXD3wrIZhh1+iRrLuZnGT
   pVG/Q9PkjpNvZu0EbyWxqE7tgOv81du7tJsURwFFV1cQt1DpK9+a5DFF0
   AtE8VjmITQJ5LcUyfZgrg2R+p0JqX0+g8UfurxjLybFXvsZqhI51kwb4j
   +9U27bgaQdNNpeN38r7BxvrTzwkv1SzAKGaHf01nWIBdZs0KxA5ayxE6x
   Y8RyW4sMNr/m5rZme7qYpNObnnSFria31E0WgkOKXOCrsBw9G5qS7axc9
   fzqVU5En/Iqeqp0cfRglbcACakEsoZxqc+Fqzpf1vZda8yL+oOyknG24Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="318958846"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="318958846"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 11:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="684421402"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="684421402"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 22 Mar 2023 11:48:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 11:48:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 11:48:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 11:48:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 11:48:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEFytAdF0YYYp5lT6FGyXM+CKNUzELZO/UbceE/71EhW66HZdGhznRuXt/zqytGgTcyCRn20aivNgvSX5cu/Tko+hr9tv7aI9EaZewt4+HyG3VQ5dTFCgJ2i0i75Kq84X9Y394EtI6xhBxkUEFFNLtW2zP+NtP5dQLpwpv1a0G0UmTGoJxOfpAjdWimqTxWgojK33FprnGiaGqwRt3x4MZhsv82tJ/EVH/DE9uQjv3V4aTFl9PypVvSuhnjwQOUbDwzoH2lBHpBOa6EwPVrY3agPFBELYxuWcRzl2e0XmOyZZ3Y2jEfX1OjJoHINhL4p/IS/CQIXJDrxGfZmeqOJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Av6EQ/U9h00qgiydBlOBo3w2KZPiAC9r4AsJLif/SPE=;
 b=bFGhPFC8aKnk3zoFaXQwp5na1Nlb/gTK8JI2GTtVIMXog8aCaJ07kcpkzvrg8DM0NbSSAwnj7jWd8soyqAc7rryNgmP6XHSPq4y5MYNmKU5C2yieP8NpArVqbs7VIPeNyYeqXxrnzjAB3eO9V5rPqVj9U6GZ59hFKHHxKk1AKISQWzJLfLPKwSjgfciaXM9J6+C5fTtG20Dbl4JzHQgCDLf0C+JddDrAstNJFJ5XFlqZ6T/e5Z9KQW2V4bGqP9n6uWntgapDYSYLRHh39A0SWq5ERJ5JDMDvhaAKqzpNJvXKZrAxK7+hVL1emzb1vj03Y6hmeHpdGdZwc4avRNZXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 18:48:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 18:48:39 +0000
Date:   Wed, 22 Mar 2023 11:48:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Kloudifold <cloudifold.3125@gmail.com>,
        <outreachy@lists.linux.dev>, <teddy.wang@siliconmotion.com>,
        <sudipm.mukherjee@gmail.com>, <gregkh@linuxfoundation.org>,
        <linuxstaging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v4] staging: sm750: Rename sm750_hw_cursor_* functions to
 snake_case
Message-ID: <641b4d82494ef_2ef21c29480@iweiny-mobl.notmuch>
References: <ZBcrEp+VssZDxAnC@CloudiRingWorld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBcrEp+VssZDxAnC@CloudiRingWorld>
X-ClientProxiedBy: BYAPR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:a03:60::36) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: be14e2cf-556a-41d9-d7ac-08db2b060ce3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TNs5kyt8nZiLPO1/dCH1DyAbocUDLXPBDPUa3XLaTAcId9ET+EZd/OT25HFYtagrpARSbgN6b99ykRr9zCOPAqH1aak+N1QvvQhdwyTnMiemPJCavEhFAxBQrmliGJl30D4L+cuIIMqY09meX4GDdBG0Uukyr+5hu5PFtvSmE6zQo/W6GMO3K7Sbp184A6ePm4tFsoOTjDHn56DXicmYdiW1nWPv2YszkhKv1QAYMtIcrfxo7J/a7nO5OOvsFxrz8W0E639VmncANuyt4R4cy2WBBwoUA85HIEs+60ct3IJ+tQF09zbl6X+pjZSs75T36LSKrL8IOOImUZfzGGoH3+/HkhXRhGosLcgWRAMFiyMMS4fzc9+x7RICoCXNzk2iYJ6u08P3AB6GK2QtHG7y9fX40O04Mmem39K2FDLP1urqQvKdGvhHKnsgUQDutOtHn3t9SttGnJzITGwE6yhyvt4m4wdQfJx8LXlXh1UIusLaY4BOC71Xv7bIqzjKWc3sjD3+5m5hC9+XZr4xk6jemmXRDELJ6eFr6ij5683RWL+kt7G2CfdofgWn8Xyc2nmn5t45s7VO7cgKwGpmM2447xWH32YWAcuxFS8IadfKh5LvyRGFzR5Z3AGqZEDiRcU2P52KbSUEiNjnFkHf9BnvJnSNh3FFR7z68xiGFjBGEvCoFky1quu+53LynOd+NZ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199018)(5660300002)(44832011)(41300700001)(38100700002)(86362001)(8936002)(82960400001)(2906002)(6666004)(6486002)(83380400001)(478600001)(186003)(966005)(6512007)(9686003)(26005)(6506007)(8676002)(6636002)(316002)(66946007)(66476007)(66556008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EylFWkxYUkDAmF+pxXyn4DZveh2ZXBJi/OT8wSkU0vAl2lYp9E7SVNVEa1wK?=
 =?us-ascii?Q?Lh8/7+kr8hZNozEB5xX/Zv4OKi87OUxnVoodVgJwopFkToRMvSbmTm74aJNL?=
 =?us-ascii?Q?xrG2n6gJCDRy3pEiK9qhAwdCMdNIEONo/owSO+A+oUhjMcoGU5REWLFF1LjU?=
 =?us-ascii?Q?o9Hc9h2vUJlKYDKDVh2PXdN+9v9dR9brzjfb5QvDNMK9cm1h2kdTYvxkBzfr?=
 =?us-ascii?Q?tWtNo2YYiHUE/WkSBo8fwegpVSKmb3ohCvqxCUEsDwghbzO0Ocn460LLuKix?=
 =?us-ascii?Q?1F6s1witBqrG8JjmoPqpEtTJicYFm/B3C6Crw+RiKP73p5xM4IRyKX+LxrkO?=
 =?us-ascii?Q?fv76uy9dPkn5DXKSWkbTxhAtH3XrcjjTAu+VwbgEvFeod/jOuxgLMULNMfti?=
 =?us-ascii?Q?5zUkT2QSaUyiRVA/31Dhuh5eKL6ULpoFXKi2DtJ4zh0jJGKJdmMXLjg/dlu4?=
 =?us-ascii?Q?+v73LB+jNwcmSxwxrs1g8lbkn1rjtEl1cMNBHB5Sf1xYkUkKYDPFjfNlTy98?=
 =?us-ascii?Q?QmI/pqUev4Tjh4bDG3ldm7JvXi2BhdLnyxPjKo1Ac46RT7ZA5uOmT6Uc2Vf3?=
 =?us-ascii?Q?rSBbw8RnUC4hTdh1OEY9Ku6tXp9LcA+vabVxY0A6ODf2gb+9aetZzkgXq8PY?=
 =?us-ascii?Q?inBQXNZQecmjNn4owthBZ/vwtKFEjLZiikNw2mhEZARgQDFwrYm69pDbCIOW?=
 =?us-ascii?Q?OOIpxO3UEStuQZJopkE+/6yjL503nVLVa7vEuednpa0GN2xJvwo74yNP+qcI?=
 =?us-ascii?Q?qvk3j9WIrTKDd4N76MdI41MOTEIgOq/A5sotGlk7WXRmQ7OFpxoO+aJsFCfD?=
 =?us-ascii?Q?0pcmFj/kqCO9UD0pMslUIxZCuYajF9VLiknRi7R6mxsvqt7DkKFy52RcxSlJ?=
 =?us-ascii?Q?pqvimLwbQAgzeskiw4+oxyJ6Yzai0jSjZO/DfUEFx8A1MsFhtBM2LpxvM/mP?=
 =?us-ascii?Q?253TJKqyzmCttCnKbnwllkJnFQVJmDybqTWfmE3os+Voq6U0f96ZGk/DDCkE?=
 =?us-ascii?Q?8hQ4GwS45JEMQ/6mVasaYXaE6Qs3vSg93vSsl2smntFXF7lV6GZ0kLnBrtjl?=
 =?us-ascii?Q?O3eZhBqRGZXi5uSc4e2VvyolY9iwvG5/69q4/Tx9/iuzRoftMqbsGy/q4/h0?=
 =?us-ascii?Q?qrdbvQQSqw5MQN2G21EgTqWCF4GOYs0ckHVOVbHOxQarRhlAn2klRiz4MxtU?=
 =?us-ascii?Q?70PeL+Nl7KxQU5NOb0Gsr6AKeHsgrXEKw5d0K4fHCRNfy8uxRvfcdVofF+s3?=
 =?us-ascii?Q?Wt5szp84eTDbc1hwcuwBg9eMe2iuAOv9H0b7OlJv+DJvh/oILnms7FCVGBWd?=
 =?us-ascii?Q?wZw2ua1jcRG2zE4JpywSX3OPjK/Zu+pM0NKiFHH/QYcSNIVPQkPbu1vVr/X1?=
 =?us-ascii?Q?igRtcKTpcHCkgTwzBcYlBwKC63azoJktsTcHBfNolYdYBDL+X030F2k+R2Zh?=
 =?us-ascii?Q?OwI9O7V38YTSb9iaXB/jhhRiSlo2rdHeTRwVZC/sKNGMsbdzQF+L//xyXQw3?=
 =?us-ascii?Q?eSsgC+2K9BRLsiKoaSlq46tcgjrxNiuRfOrreioFp9XvNaHFnxHk3pUEGQtV?=
 =?us-ascii?Q?OYN9qAY/0OIDp+nrptaZYjO63v3wJHNg9OQOVAQn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be14e2cf-556a-41d9-d7ac-08db2b060ce3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 18:48:39.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGKZ4D2tUsfENJUGkyNiL7Fhp7uoQBkF+RfDoXLe59wwRqWGBU/TSPXvPgQj51Hu0Q0GcVy4ufvSLWTfLpc4Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kloudifold wrote:
> sm750 driver has sm750_hw_cursor_* functions, which are named in
> camelcase. Rename them to snake case to follow the function naming
> convention.
> 
> - sm750_hw_cursor_setSize  => sm750_hw_cursor_set_size
> - sm750_hw_cursor_setPos   => sm750_hw_cursor_set_pos
> - sm750_hw_cursor_setColor => sm750_hw_cursor_set_color
> - sm750_hw_cursor_setData  => sm750_hw_cursor_set_data
> - sm750_hw_cursor_setData2 => sm750_hw_cursor_set_data2

I think this is fine.

But I would like to see a follow up patch to just remove
sm750_hw_cursor_set_data2().  It is not called anywhere.

11:43:22 > git grep sm750_hw_cursor_setData2
drivers/staging/sm750fb/sm750_cursor.c:void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
drivers/staging/sm750fb/sm750_cursor.h:void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,

That said:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> 
> ---
> Changes in v4:
> - Update the commit msg (Deepak)
> - Use tabs replace 8 spaces
> 
> This v4 patch was prompted by 2 errors, 2 warnings and 1 checks reported
> by the scripts/checkpatch.pl, which detected the style problem.
> 
> Changes in v3:
> - Add this changelog (Philipp)
> - Move lkp tags and link to the correct location in commit log (Alison)
> - Update the commit msg (Philip)
> - Update the commit log (Bagas, Julia)
> 
> Changes in v2:
> - Use new function names in call sites (LKP)
> 
>  drivers/staging/sm750fb/sm750.c        | 22 +++++++++++-----------
>  drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
>  drivers/staging/sm750fb/sm750_cursor.h | 12 ++++++------
>  3 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index effc7fcc3..5d7249e82 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -121,14 +121,14 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  
>  	sm750_hw_cursor_disable(cursor);
>  	if (fbcursor->set & FB_CUR_SETSIZE)
> -		sm750_hw_cursor_setSize(cursor,
> -					fbcursor->image.width,
> -					fbcursor->image.height);
> +		sm750_hw_cursor_set_size(cursor,
> +					 fbcursor->image.width,
> +					 fbcursor->image.height);
>  
>  	if (fbcursor->set & FB_CUR_SETPOS)
> -		sm750_hw_cursor_setPos(cursor,
> -				       fbcursor->image.dx - info->var.xoffset,
> -				       fbcursor->image.dy - info->var.yoffset);
> +		sm750_hw_cursor_set_pos(cursor,
> +					fbcursor->image.dx - info->var.xoffset,
> +					fbcursor->image.dy - info->var.yoffset);
>  
>  	if (fbcursor->set & FB_CUR_SETCMAP) {
>  		/* get the 16bit color of kernel means */
> @@ -142,14 +142,14 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
>  		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
>  
> -		sm750_hw_cursor_setColor(cursor, fg, bg);
> +		sm750_hw_cursor_set_color(cursor, fg, bg);
>  	}
>  
>  	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
> -		sm750_hw_cursor_setData(cursor,
> -					fbcursor->rop,
> -					fbcursor->image.data,
> -					fbcursor->mask);
> +		sm750_hw_cursor_set_data(cursor,
> +					 fbcursor->rop,
> +					 fbcursor->image.data,
> +					 fbcursor->mask);
>  	}
>  
>  	if (fbcursor->enable)
> diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
> index 43e6f52c2..ff643e33f 100644
> --- a/drivers/staging/sm750fb/sm750_cursor.c
> +++ b/drivers/staging/sm750fb/sm750_cursor.c
> @@ -58,13 +58,13 @@ void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
>  	poke32(HWC_ADDRESS, 0);
>  }
>  
> -void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h)
> +void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h)
>  {
>  	cursor->w = w;
>  	cursor->h = h;
>  }
>  
> -void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
> +void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y)
>  {
>  	u32 reg;
>  
> @@ -73,7 +73,7 @@ void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
>  	poke32(HWC_LOCATION, reg);
>  }
>  
> -void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
> +void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg)
>  {
>  	u32 reg = (fg << HWC_COLOR_12_2_RGB565_SHIFT) &
>  		HWC_COLOR_12_2_RGB565_MASK;
> @@ -82,8 +82,8 @@ void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
>  	poke32(HWC_COLOR_3, 0xffe0);
>  }
>  
> -void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
> -			     const u8 *pcol, const u8 *pmsk)
> +void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
> +			      const u8 *pcol, const u8 *pmsk)
>  {
>  	int i, j, count, pitch, offset;
>  	u8 color, mask, opr;
> @@ -132,8 +132,8 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
>  	}
>  }
>  
> -void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
> -			      const u8 *pcol, const u8 *pmsk)
> +void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
> +			       const u8 *pcol, const u8 *pmsk)
>  {
>  	int i, j, count, pitch, offset;
>  	u8 color, mask;
> diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
> index b59643dd6..88fa02f63 100644
> --- a/drivers/staging/sm750fb/sm750_cursor.h
> +++ b/drivers/staging/sm750fb/sm750_cursor.h
> @@ -5,11 +5,11 @@
>  /* hw_cursor_xxx works for voyager,718 and 750 */
>  void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
>  void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
> -void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h);
> -void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
> -void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
> -void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
> -			     const u8 *data, const u8 *mask);
> -void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
> +void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
> +void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
> +void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
> +void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
>  			      const u8 *data, const u8 *mask);
> +void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
> +			       const u8 *data, const u8 *mask);
>  #endif
> -- 
> 2.40.0
> 
> 


