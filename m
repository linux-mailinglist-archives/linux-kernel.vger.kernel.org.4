Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2870E659EBB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 00:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiL3Xu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 18:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiL3XuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:50:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5381DF30
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672444223; x=1703980223;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hgM2UEd3gMAQDUIrIkG30AoMQt4xG7B0VYWuOd4ceDk=;
  b=mHP6e/Z7RL5CRF7yCozz1kekIgyq+1ux/k3zot0dQlM087Bgv8jNVMKP
   i+2OIGYhYgs2+SXIoy+HWry4oeQR2oEvJHrealn3lHhC+dBa2OXPicDnb
   v8fcX5iMiORtFTrlRpQ3qjtaazsvp0UsR5j/lhIZqB96+8srBjHfYbGCW
   tMq2EIrbyZJKjUSFEVM+HKlr0xD7DEQjqjztb219SGI370jdItUro84/3
   kN6nusG5hLTzMFngwurFD0N+jJoSsy+LVUOY9Q95hWFI8mWsfgeAtKMbP
   5o7uSaCpbg9uPZ9p1ft6VaUquEX9cyGBV4XrTZckDMP8E76UNahvrMRKV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="323256194"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="323256194"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 15:50:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="982763588"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="982763588"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 30 Dec 2022 15:50:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 30 Dec 2022 15:50:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 30 Dec 2022 15:50:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 30 Dec 2022 15:50:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 30 Dec 2022 15:50:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R84UmuPQnJzSWFj2ubhUZGIw5YTzaGpQYHF+Fkyt1o0k4ZqSJI8EleeLCjwNcvawx2tQsyVeKW5+wY2vkkxd2rCF6fgDfVBuOkwfwqgMAe/fHwyr8WbHbXpH/1OB0agt2EWPOOAK9rcBuvk2CWYtt8a4ihIDJbQM21xVhy82A31v+6UQkzwFc2ryCLOeMbUguOOlS3wlOjZPQzVHhLHVgmP45xv59OEDYsCSupDyzCStioDjoKbczWgvVwVyA6ElcCO4FpF2KtXf2pQiwsoWZClar9Aud1JCQf2S0S3Apbq8VFPfK7KMo6YQKGMVBzuDQUaZ+yLd4xdQN7n09D5cJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBwzB22qvV8nA9yCHEmXtf6uMMy243RmrLZsuJbbKnw=;
 b=P04sX/DQ4LwER2vAqeAlyaC2Nh7aSCB0VqIbi6heH6tnYdjliyv2GelOsJDcSHY1SaHsdDgo33LR6nU4AtlLKbN++shGWyj+rq9lawbbPX1qEJ8/OUAAee9nOON2zrmERdpsup0ayciC++knm3q3d5NWtesaIFC8jeOmlLPqGJjwD/079WQU2AfvOkvJtuqEOTUnbY1mZ3flfmfmWW4D0S48ComeV8kpK5NV3QTmBDIrDAl8ks1sBvrc00m9WmEwE++8m3bRc0wzByt7l40VkclvPIrMwviU/0EwT/g5P3Dx+aC62dHKOcoc1v5/GAU1PY0C+HB0+RP2gVlqbIzxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by CY5PR11MB6235.namprd11.prod.outlook.com (2603:10b6:930:24::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 23:50:20 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::dcc2:a123:be56:c530]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::dcc2:a123:be56:c530%9]) with mapi id 15.20.5944.018; Fri, 30 Dec 2022
 23:50:20 +0000
Date:   Fri, 30 Dec 2022 15:50:16 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Subject: Re: [PATCH] fs/hostfs: Replace kmap() with kmap_local_page()
Message-ID: <Y695OHrq+UmvVeez@iweiny-desk3>
References: <20221013161700.11631-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013161700.11631-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|CY5PR11MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 02586cfe-5418-48ea-68b3-08daeac09c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F44ehOLY2m6rlTbB+W8oQjtdjmgvbslMsyf8aHy5qAgWvvoOxLXHN9vZbgE+a/IcCmt9exmm0agTj4+rjt+T42PJPzBu78yHPyB08GK89KTv1pNOLPY7e3jDIx2s6OkCpKJUQcUnadF5YGhnE34FZLxPZPtpd7bfQFcEIWV9E4n59BxaLkh8/zaEtWZcK8OcHU0bo9CkLPVZvxox18oxYmlH+Og54ZoZ48WKKlYhNBvzK3jUnRiIGZaO48oYYbXFmknYTHfMXaf2XGFBl/RAn4qkDHdrhtXGvS4gbNSNt9GdLDKFXCPmKyBGRWH4KCBnV1BD6dVU8m3jVDjeY13DLNnYljoCQkLpMn5quryCvB5hx8JeQ+NgLjgWsCKMnYELrbbO8B2GVrildE5yKlDYjPG2dU4xh8HUkAg1GOoZpqGfJAkpvs1QJ0qlcEFuat1nbELSDr0aFEpxS8HSNSIk7nTDJK+prdFqHoYPE/7/BxWz+MPTQHIMZxYHvdFr9YnVUpypUsDm+/wL8gxQZ7GL2ykdM/b7gTzqhYvxZXECnxq172DmJyA/rK5xkkEguquq+0LVZPKh0R+zHla0M0CznexymNCtgG0wYi56P5NePDKOiLcO02DZgKzh/UmcRtblr+9CX9EWSTdLwml8ceHgMRB52QRxtk3VO9dGlV9A5SJmcmgOQjebxqIrUcH6hQad
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(66556008)(66476007)(4326008)(8676002)(5660300002)(66946007)(9686003)(44832011)(8936002)(6512007)(41300700001)(26005)(83380400001)(2906002)(6916009)(54906003)(186003)(478600001)(6486002)(316002)(86362001)(6506007)(107886003)(6666004)(33716001)(82960400001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdKYnY2ays3Z2ZVVi80Q290eXJGL2pobTU1LzAxTm52dE9lQldTUWppbzhY?=
 =?utf-8?B?Wm05WjAxdmI5RWh0eDQvdlo1MmRBd09YelVsUFNWV21ycnBsaEY2ajJqaTJG?=
 =?utf-8?B?NUExWVJTSXJFQldOb0xONGlaT1hSRVNjUE1zZ0U3NTY2Vll0NStSVy9zRWZM?=
 =?utf-8?B?Qi9rbGEzY2FxMmVqQ1Z6WVkyV3ZLdW5GVlp1SUF0UElqTzJ2SUgxYVdwYjBt?=
 =?utf-8?B?MHA3OWRESEhWbjFFTEJMRndaWE5DZGVWb1RBcEQ4ZDlDWk5aMTdJNmViR3pZ?=
 =?utf-8?B?LzdXVC96WjRJcGQzRVM1N0FidnlYT2RwaFVGUENpMG9FVG5rTHFpRXl3ZVRm?=
 =?utf-8?B?SGlpU1dDUzdMWU90MjFJVnZ0V3diMFZ0bzZ2TVd0bWY5ODdHdWdMNTltWFB5?=
 =?utf-8?B?aUEvVG9vZGQxYVNvZ0tGbFJFRzlIR2FXRlNKZENJUVhBUzJyVlIzK0ZkN0Ji?=
 =?utf-8?B?ZThvK1NsM0ZPZTQ1UUFZZUpFTmMvV2VQTlE0eitvWmJBV1g4UkRBZGkrNGNR?=
 =?utf-8?B?eEJkOVZlNTFGYTFoRGY0NVlJRVZPTUZERGFNc2tHaTJ5RTFmY3VVOWNtTEtS?=
 =?utf-8?B?NkxSQXB1NFFieTBneDVOZUhzNzM1NkRvdXphT0FYMkF6ZzBIQlRFaFY2NzV4?=
 =?utf-8?B?Wk13aGxBT2hDeU9iOHZEdjZoMVRyeVgybUFUYlJIM1JzWWhDTVFnVHphLzJu?=
 =?utf-8?B?eFhUa1d0VEYzeks4cldYa2FIdTduODQ4QUtRSHliVUJ5cEJVSHIzaTBRSlhY?=
 =?utf-8?B?MndVR0hSc3N2YmwxbnQ5STJyKzlZQ2RSb1Z0TDNlUDVaZEluVTBDbXJwaklE?=
 =?utf-8?B?d0lnTnVjd01LM213bURYaHJBNWw4Nlp3OThxQlBlVkZabXpBMmpqdWtveTNx?=
 =?utf-8?B?SWQ0Y1pRSmNvYUx6TDlQR0ZORXdVZXFucXhudTlNbGhxMmIyelZsYVgzNXBV?=
 =?utf-8?B?RXJWaG12UEk1eThKMkthVTJGcHdPRTNVOENxZVFYaSt3RVpNQ3FIVTIvNmhh?=
 =?utf-8?B?NGpSbmlrWmdYR2tUTHg2ZUNKa1crUTVZd2JUZmtuUitNdkJFaGFoc2FXQ1Nm?=
 =?utf-8?B?Y2FlWFZNQ3EwRnZvSDBoT05QQzkyd1VCVkYrNThiQVFWUG10Q1JNTjQ2RUVB?=
 =?utf-8?B?NjByUVVhZm9BK0FUdXRDWHU4U0szTDlJZWhjdlY3T3ZLRlgzZVU0WjA3WXJD?=
 =?utf-8?B?RG1KNHlmQUY5d0tRdithYyt0ZEJtQ1VtajAwd0tyNG51dG05MkZEZFVtREZ5?=
 =?utf-8?B?MXVBbEVoSmhGM1paUWpZcDNJK0tvaUVCVGUvaGY0c1d5S3d5RVZiNmx3Nnk1?=
 =?utf-8?B?NWJkYlpQUUhTRHJROCtDWTQwMEVLLzhwdU5PbUFYMkw2cmF5ZzNPZW5HNjhZ?=
 =?utf-8?B?dEN4TEhlWC8yaEhjMktKSEVQL1dnN21UcDFFQmpGNVprekFkclBsZ3hXWWFk?=
 =?utf-8?B?QktzYjM4djlNMFFrQkNTcUhvekZqUmRqOFkrSy9Yckd4QjJjcFNmL3BSSmo1?=
 =?utf-8?B?T0w5cTJxQUpZMURTSmtWaWVzdzg1K2luS0h5QkRFc0RyMDR0bnFEbTM3c0ZX?=
 =?utf-8?B?YjBoN2pzaHVxT25VOWk4QVJvQ0h6VU05TjkyZ0dmVkFTcWhuVzJ3UU53UnFG?=
 =?utf-8?B?L3ZOZUdrbVoxUEovZyt1bnQrY0xWSVRlM2U1Q3ppWmJaU2hPNDQ5ZmJHdVlC?=
 =?utf-8?B?U3NxT2MwNm02NlJZSWRlS2ZvMWFDb3EzZlZtUGRCLzVpb2FsVW1sQkpGQ2Jo?=
 =?utf-8?B?WmFBaEc2emhWdTJDZWl2aW5vZytocU5rczVOUXY4NnczbzQyNWtPVWVCY1U3?=
 =?utf-8?B?bnh5THVnbnZPT3plenk3NTNYQkxwNTNBdzh2cVZEYTZ2amc0ME1wd2duSkc5?=
 =?utf-8?B?clEwMVd0SEJIZnk2MXIxQTlDd3NMYVBnRVFuNlkrSGpxcHpnUlFhMzJkYXg3?=
 =?utf-8?B?RGVLSDdHZlNXWmFxNW5qNnpoZER4RytLK1RvcnZOdXFaKzBmSWMwc3VCbis3?=
 =?utf-8?B?VGhySFhtcWduOW1YVjRmSW5Cbno3Q1Vrbm91WldZZWR4dDkxMTBVWm9DL1N1?=
 =?utf-8?B?L3krZmcyRUdQV3pNbWZUZERBZ1RLU296dldTNGNDNDdJSUE5K00raS9obnMx?=
 =?utf-8?Q?pxT2hasgqcTKF4t8ShpiOxG5D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02586cfe-5418-48ea-68b3-08daeac09c63
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 23:50:20.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: En/VErmHfL8TqLvGQ1Y0EUxd2nUnlOLu588QLHMJNdQnUuXvf/JkgQ8ciY6e/MgiFOIUP4LepsLaIJx5ctVVfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6235
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 06:17:00PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Therefore, replace kmap() with kmap_local_page() in hostfs_kern.c, it
> being the only file with kmap() call sites currently left in fs/hostfs.
> 
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

What can we do to move this patch along?

I'm not an expert but it looks ok to me.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> These changes are not tested in a 32 bits VM as I use to do with other more
> problematic conversions. Mere code inspection makes me reasonably think
> that the rules of local mappings are not violated by this conversion.
> 
> Furthermore, I have no idea how to test this code. If maintainers think
> that tests are absolutely necessary, any hints about how to perform them
> would be greatly appreciated.
> 
>  fs/hostfs/hostfs_kern.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 07881b76d42f..0c9f89352601 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -412,7 +412,7 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
>  	if (page->index >= end_index)
>  		count = inode->i_size & (PAGE_SIZE-1);
>  
> -	buffer = kmap(page);
> +	buffer = kmap_local_page(page);
>  
>  	err = write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
>  	if (err != count) {
> @@ -428,9 +428,9 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
>  	err = 0;
>  
>   out:
> -	kunmap(page);
> -
> +	kunmap_local(buffer);
>  	unlock_page(page);
> +
>  	return err;
>  }
>  
> @@ -441,7 +441,7 @@ static int hostfs_read_folio(struct file *file, struct folio *folio)
>  	loff_t start = page_offset(page);
>  	int bytes_read, ret = 0;
>  
> -	buffer = kmap(page);
> +	buffer = kmap_local_page(page);
>  	bytes_read = read_file(FILE_HOSTFS_I(file)->fd, &start, buffer,
>  			PAGE_SIZE);
>  	if (bytes_read < 0) {
> @@ -458,8 +458,9 @@ static int hostfs_read_folio(struct file *file, struct folio *folio)
>  
>   out:
>  	flush_dcache_page(page);
> -	kunmap(page);
> +	kunmap_local(buffer);
>  	unlock_page(page);
> +
>  	return ret;
>  }
>  
> @@ -484,9 +485,9 @@ static int hostfs_write_end(struct file *file, struct address_space *mapping,
>  	unsigned from = pos & (PAGE_SIZE - 1);
>  	int err;
>  
> -	buffer = kmap(page);
> +	buffer = kmap_local_page(page);
>  	err = write_file(FILE_HOSTFS_I(file)->fd, &pos, buffer + from, copied);
> -	kunmap(page);
> +	kunmap_local(buffer);
>  
>  	if (!PageUptodate(page) && err == PAGE_SIZE)
>  		SetPageUptodate(page);
> -- 
> 2.37.3
> 
