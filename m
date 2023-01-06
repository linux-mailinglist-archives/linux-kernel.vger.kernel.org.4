Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55165F9F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjAFDMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjAFDMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:12:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF0861327
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 19:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672974764; x=1704510764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SfkqfEpMDj/E99/62MsTEKCPtei+tIsg4tMVmb8RF/o=;
  b=GWciiaxrl2umxLzsV5qlCfYt3mk+htawPaCV5D91mfNDIbiuPEuu5xlT
   l1UuReixoH2Vi0L3OmLYM2XUuOUk3AyVPoLKqNWLft/eFcDNl0Gc53eAJ
   P3ospH+plBmcfXT+rXYpqdfrZvhS4XjQF34OBF4rSy+7QLM6UuGvahQ5+
   jwyL05qUwmTEGsMZuyVKhAlTbhvi3SLUlZJI+KRuhs5im4utcFottYKLD
   XPfe7pEiISmEUoQJgRCEbkIpUGtJHnleGo7Dxq1ZypGCppQ/JOpYXgHZ5
   baukOeZjLCkFowei5BiRDy46gMjYfG1F07eRo7iAaU/3pOYQNupieA/4m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="305909720"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="305909720"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 19:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="605775390"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="605775390"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2023 19:12:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 19:12:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 19:12:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 19:12:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 19:12:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUH9r7Dm/PyWYNtCFQv6os9fEy4UJfWoIWsnWnDFIcKcSpFtSMY8ihJgdSFQCc9vnzxK1o6Gq9eH2Ql+61VLIxamtFdceHf7zrfp3P1fU6KBQ5PSHzJjzYPvJz4GF2y9sB6eN+plxfkteC5CFx24qRIgehJeAd5GQ8Do3Jwxn0Ql2RlmnhqxhMyX2yjy7WQ9hhS/3yip9TjnTwQRg0/kfSKj1wcoFm4eAJAXfGwA0uieKaC80zFb4iVQ9ZakdA72q4vsuIbTkw9V1ZV52qIIwg+Oan29VeStNMy7IZP0r47bu53LBqmY652XfFT6eRgwggd7fepN+X+oLHNeKOu0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL5f9Qtn0Uxwjsk9A1jDi065A0t2tuQGjsLFB4j1wCY=;
 b=aC4ih+XjWUkrGW7fdxT5dzUgh1gec6OMuexlV4kh5TDALhOa8eq5MTWLe9UR4qQpmMbTPWPzizZGbFy4kqyPqNia8BD1s5PUtPY2lFOGrNOREtP8OZCF255mtZt07l370tT6T2okdH82ZDFx/N/MmCfaIgfIJNLtm3PEcul9LbUoX4xvnvrKHcnKBvlhXhmD/eYW7JmSXsSNvEI7JFrQ8eOESULRgq8ge7YAMjsVmiG6tlu0SzQzqNVhbh/oSS4tiSTx8n7tJw5aGqh4mpUrQL2S0E/cWI6A5x9/h9Mhj6a5Gj9+2Gb1aKnUAG9DtytosuLKBygK/6xISkvBFykBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:12:40 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:12:40 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH 02/18] x86/resctrl: Access per-rmid structures by index
Thread-Topic: [PATCH 02/18] x86/resctrl: Access per-rmid structures by index
Thread-Index: AQHY5U7Mu7zwFI3jJk6I+hPvaZIdK66RKpGw
Date:   Fri, 6 Jan 2023 03:12:40 +0000
Message-ID: <IA1PR11MB609782777889811A1BB773549BFB9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-3-james.morse@arm.com>
In-Reply-To: <20221021131204.5581-3-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|CY8PR11MB7267:EE_
x-ms-office365-filtering-correlation-id: fa2644a4-9406-4526-8fe5-08daef93ded9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tqntOMBerjNYQpMhP4knQEHoQsvEsjXVzYQ06l+nVpKwWQB1ZTbseRhTgeZuWqA6nOZQfLr4xxvKzRoVZI6unFAAln96xo7cheeCpgL0wCLAQORZTHn17Gefv+b/R/gQxf8iHkMcnacBKCOOWA6pqiGoXUmU+DFqF8T1xwcm/pasF/+Dq0zQBHPnlf3YXu0Igl+eOVsIyZeseM+rStLygZTJgjkmy9M50ESO1uUBkpXhVLVhH7YvJOroZ7ja6MA0Pgs4laNeZ02bOCX0ctDSAULaWnvMDlUd3rmmfocURWEr9zzssYhhRVSlKrchLDeXnVTgk9ldE7WVPmZ6zvFaTqiOm1/1DH10t0zySc8r8rPur6iXQ5Oug5GTs+yBYrYERJ+6nEeA+QoTSOr5TJoa1qK4EWVi6C3CayKhu/pbPdezZFuumfSzKQKutZW3Xvt+9cXPSnclV0rO10rAOucRDo1i/S1XXJrFo+nSKysIZAWMwmR8y9mMrmh37JeL8CiA7tASXqtC5+7bGCw/feTYKI3EuwtgBBSxc3XHXWLrkkvSiXfTVhCTVtA3OsYqPlhCvoI3B/EzHA+OAR1QeGXq9v4CPKgO2LxYKeUveJEy5/R4l1HSFq04TdupIOxVGRGP8DGT0OaY/tKWizLgRP0yMxusfWemQgr0LQPLihrxFX8ooJ4MUK3kZT+T8cVweuBQDViK7w3TEl4Lwcf+UYnO1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(38100700002)(38070700005)(122000001)(82960400001)(55016003)(33656002)(86362001)(7696005)(66476007)(4326008)(66446008)(64756008)(6506007)(478600001)(9686003)(76116006)(186003)(26005)(316002)(110136005)(54906003)(7416002)(71200400001)(8676002)(2906002)(66946007)(66556008)(41300700001)(52536014)(8936002)(83380400001)(5660300002)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9FK+30hh0kr7rSrDg9apLYcZirSetSuBcEePLHxrLJb7Zb1I9YHwAv977t9n?=
 =?us-ascii?Q?NO/5X09vb7Xn8KQeTLOI8JEJUAMDQ1G3iIi0kv2mYOQpW1EU5qIE8kf+kHq0?=
 =?us-ascii?Q?PdcQtPQug4+6qYkHpd8N7x6LtD6eZf3RdhbIn14QTqHkqRZzC64Dbd/rA50O?=
 =?us-ascii?Q?EPw7ufuAHCmVusBkGf/wDkbuh4bklMiNW2Da4/pGjhiELgJrzNO3gqowbIyD?=
 =?us-ascii?Q?n8/iL0lCkagzJJFlyi1fTYU5/D9tb8lsLBK6buL5EDCE50aQU2YoBIzpmm6H?=
 =?us-ascii?Q?6ZqfE/YK07k+gRuopHY7YN/n3V+UCs7u0cqqhK/48aUY5sLgyvs6GiU7cJ3e?=
 =?us-ascii?Q?Sr/leYQaOikWO2bnEvuy6KYSaosfD2rL3J3e4lX3tIZnsk3QBRkgD21hmPN8?=
 =?us-ascii?Q?gpXAaus526yuCcPK1loSXxkUdfaOXH4qvTXPEKgXELYS+i4QO9QLUaLJEqKD?=
 =?us-ascii?Q?WcWqH0BgEoClC/0sCnpATjVz0Zwak3a4OBXgzd/pQpnn0lIbP7d6vvDxib6G?=
 =?us-ascii?Q?3E+sZw4J7/TLCkd4djYVwZbg11Vktv52l9kbba/VpXR6//PnAbh/tM6jViSi?=
 =?us-ascii?Q?/o6jKf+uVDaU+7GKq1WL8x54Is/Fcr5vbJ/hXgy40VmvF7X++n6iFrMsh+FM?=
 =?us-ascii?Q?sHFNjpdtnsru6ySa5hc5EWdXzDSMtLs9TJmT65kUD5peaMXVfkLWJaIKhcoZ?=
 =?us-ascii?Q?tBvgOnyu5pX8boIvULaMx1uB2YTDXPtwJoHcJf1ssiXxZ4ShMxMndURibrKA?=
 =?us-ascii?Q?7JzepY0QFCYGyiPrUS2TkltHkMlIxij2TqQOeaR0NPxyjZ3UnSoPzq34XF2U?=
 =?us-ascii?Q?2CQ/TgoU0+FhbeLYJWyIq+PQRz0boJ3C+beV/zoz3c7MEr7lBcj4SoaEUsVt?=
 =?us-ascii?Q?+W9CeW6RJmURHDJ7dl1uXYEdUdyXoAJwp4EdN9J3v73wHwTP8eKM1bZI01Ls?=
 =?us-ascii?Q?zncQLzrdNxGdVtjBD1bXmM+B0PKm2fXivAqF6erH4BaCpoJ9+CXR+ybPgnjZ?=
 =?us-ascii?Q?Z0D8w6IJ2R/PIr/TrI7DXn9/306OCxVgYAADfDGff8Mfm2oU/rUm12jm9ZXF?=
 =?us-ascii?Q?368wVczhQxg6ciR7baZuEtgM7S2oMnPBn8rgPbropA6Heo6pT7OopCY0FlG0?=
 =?us-ascii?Q?DxQ8rjbVEtqgiBaXazO6I7VfenYgaV8xnp1IIho8tLMNCtUdq1sX66WvVQM1?=
 =?us-ascii?Q?ophNzkEEuXS+FVQ3gFG9tzCHbGxh7hhLwWVmuOX7Nq+h5SN+fWq2SjIj6RMG?=
 =?us-ascii?Q?r2bfpnBSi2HySgroLgNIbXhPke94aI7FZkG8jQFoF7sKmQ1fR1JF45u8Y5po?=
 =?us-ascii?Q?hreAegZU2U24CpyyxyNt+Sw0wjAnb9APhY2hMGjNW6N4R/fqQiVtQqDNQ33u?=
 =?us-ascii?Q?bkYK0qfTzbG2F7WhYNxz+x6IWmRXElEQCUG1CT9rLDHwow7cBMdnH2Kg52/f?=
 =?us-ascii?Q?5X4yl296OqpFeSlATkaMeX5KdgomKIVi5izBLx1kdT9dItSvcvOBUo2Tv78W?=
 =?us-ascii?Q?1pYzHAt0395ptjF2rpVLa8NkK4u6iN4fHSJTEE+g7gs5XIZWSv+UJ8mCYll6?=
 =?us-ascii?Q?vVKxdxOnz5R6YUVwmpgtxQ9ogCJxqvH1jOSeiSop?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2644a4-9406-4526-8fe5-08daef93ded9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 03:12:40.4065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UUeNnSw8qeQ4zZ0JBFaEnx6EHYbU5EZ8D/CpTOqigmq44BY/uDI5zI9eaKOVDFUmu9fzfVg8z15uHSiHFKxiBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

> James Morse <james.morse@arm.com> writes:
> Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
> monitors, RMID values on arm64 are not unique unless the CLOSID is also
> included. Bitmaps like rmid_busy_llc need to be sized by the number of un=
ique
> entries for this resource.
>=20
> Add helpers to encode/decode the CLOSID and RMID to an index. The domain'=
s
> busy_rmid_llc and the rmid_ptrs[] array are then sized by index. On x86, =
this is
> always just the RMID. This gives resctrl a unique value it can use to sto=
re
> monitor values, and allows MPAM to decode the closid when reading the
> hardware counters.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/include/asm/resctrl.h         | 17 ++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
> arch/x86/kernel/cpu/resctrl/monitor.c  | 75 +++++++++++++++++---------
> arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 +--
>  4 files changed, 72 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index d24b04ebf950..523eabfa3193 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -96,6 +96,23 @@ static inline void resctrl_sched_in(void)
>  		__resctrl_sched_in();
>  }
>=20
> +static inline u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +	/* RMID are independent numbers for x86. num_rmid_idx=3D=3Dnum_rmid
> */
> +	return boot_cpu_data.x86_cache_max_rmid + 1; }
> +
> +static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid,
> +u32 *rmid) {
> +	*rmid =3D idx;
> +	*closid =3D ~0;

Should closid be 0 or ~0 on X86? Any special reason for closid to be ~0?
Seems 0 is a natural value so that it's ignored on X86. And the value shoul=
d
be consistent on x86 and documented.

> +}
> +
> +static inline u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid) {
> +	return rmid;
> +}
> +
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>=20
>  #else
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 4b243ba88882..cb94c3e3fe36 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -8,6 +8,8 @@
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
>=20
> +#include <asm/resctrl.h>
> +
>  #define MSR_IA32_L3_QOS_CFG		0xc81
>  #define MSR_IA32_L2_QOS_CFG		0xc82
>  #define MSR_IA32_L3_CBM_BASE		0xc90
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f1f66c9942a5..c95d259476d4 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -137,11 +137,24 @@ static inline u64 get_corrected_mbm_count(u32 rmid,
> unsigned long val)
>  	return val;
>  }
>=20
> -static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
> +/*
> + * x86 and arm64 differ in their handling of monitoring.
> + * x86's RMID are an independent number, there is one RMID '1'.
> + * arm64's PMG extend the PARTID/CLOSID space, there is one RMID '1'
> +for each
> + * CLOSID. The RMID is no longer unique.
> + * To account for this, resctrl uses an index. On x86 this is just the
> +RMID,
> + * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
> + *
> + * The domain's rmid_busy_llc and rmid_ptrs are sized by index. The
> +arch code
> + * must accept an attempt to read every index.
> + */
> +static inline struct rmid_entry *__rmid_entry(u32 idx)
>  {
>  	struct rmid_entry *entry;
> +	u32 closid, rmid;
>=20
> -	entry =3D &rmid_ptrs[rmid];
> +	entry =3D &rmid_ptrs[idx];
> +	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
>  	WARN_ON(entry->rmid !=3D rmid);

Will __rmid_entry() be moved to fs/?
Should add WARN_ON(entry->closid!=3Drmid) here?

>=20
>  	return entry;
> @@ -238,8 +251,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, st=
ruct
> rdt_domain *d,  void __check_limbo(struct rdt_domain *d, bool force_free)=
  {
>  	struct rdt_resource *r =3D
> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
> -	u32 crmid =3D 1, nrmid;
> +	u32 idx, cur_idx =3D 1;
>  	bool rmid_dirty;
>  	u64 val =3D 0;
>=20
> @@ -250,12 +264,11 @@ void __check_limbo(struct rdt_domain *d, bool
> force_free)
>  	 * RMID and move it to the free list when the counter reaches 0.
>  	 */
>  	for (;;) {
> -		nrmid =3D find_next_bit(d->rmid_busy_llc, r->num_rmid, crmid);
> -		if (nrmid >=3D r->num_rmid)
> +		idx =3D find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
> +		if (idx >=3D idx_limit)
>  			break;
>=20
> -		entry =3D __rmid_entry(~0, nrmid);	// temporary
> -
> +		entry =3D __rmid_entry(idx);
>  		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
>  					   QOS_L3_OCCUP_EVENT_ID, &val)) {
>  			rmid_dirty =3D true;
> @@ -264,19 +277,21 @@ void __check_limbo(struct rdt_domain *d, bool
> force_free)
>  		}
>=20
>  		if (force_free || !rmid_dirty) {
> -			clear_bit(entry->rmid, d->rmid_busy_llc);
> +			clear_bit(idx, d->rmid_busy_llc);
>  			if (!--entry->busy) {
>  				rmid_limbo_count--;
>  				list_add_tail(&entry->list, &rmid_free_lru);
>  			}
>  		}
> -		crmid =3D nrmid + 1;
> +		cur_idx =3D idx + 1;
>  	}
>  }
>=20
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)  {
> -	return find_first_bit(d->rmid_busy_llc, r->num_rmid) !=3D r->num_rmid;
> +	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
> +
> +	return find_first_bit(d->rmid_busy_llc, idx_limit) !=3D idx_limit;
>  }
>=20
>  /*
> @@ -306,6 +321,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entr=
y)
>  	struct rdt_domain *d;
>  	int cpu, err;
>  	u64 val =3D 0;
> +	u32 idx;
> +
> +	idx =3D resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>=20
>  	entry->busy =3D 0;
>  	cpu =3D get_cpu();
> @@ -325,7 +343,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entr=
y)
>  		 */
>  		if (!has_busy_rmid(r, d))
>  			cqm_setup_limbo_handler(d,
> CQM_LIMBOCHECK_INTERVAL);
> -		set_bit(entry->rmid, d->rmid_busy_llc);
> +		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
>  	put_cpu();
> @@ -338,14 +356,16 @@ static void add_rmid_to_limbo(struct rmid_entry
> *entry)
>=20
>  void free_rmid(u32 closid, u32 rmid)
>  {
> +	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
>  	struct rmid_entry *entry;
>=20
> -	if (!rmid)
> -		return;
> -
>  	lockdep_assert_held(&rdtgroup_mutex);
>=20
> -	entry =3D __rmid_entry(closid, rmid);
> +	/* do not allow the default rmid to be free'd */
> +	if (!idx)
> +		return;
> +
> +	entry =3D __rmid_entry(idx);
>=20
>  	if (is_llc_occupancy_enabled())
>  		add_rmid_to_limbo(entry);
> @@ -355,6 +375,7 @@ void free_rmid(u32 closid, u32 rmid)
>=20
>  static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)=
  {
> +	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
>  	struct mbm_state *m;
>  	u64 tval =3D 0;
>=20
> @@ -371,10 +392,10 @@ static int __mon_event_count(u32 closid, u32 rmid,
> struct rmid_read *rr)
>  		rr->val +=3D tval;
>  		return 0;
>  	case QOS_L3_MBM_TOTAL_EVENT_ID:
> -		m =3D &rr->d->mbm_total[rmid];
> +		m =3D &rr->d->mbm_total[idx];
>  		break;
>  	case QOS_L3_MBM_LOCAL_EVENT_ID:
> -		m =3D &rr->d->mbm_local[rmid];
> +		m =3D &rr->d->mbm_local[idx];
>  		break;
>  	default:
>  		/*
> @@ -407,7 +428,8 @@ static int __mon_event_count(u32 closid, u32 rmid,
> struct rmid_read *rr)
>   */
>  static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)  {
> -	struct mbm_state *m =3D &rr->d->mbm_local[rmid];
> +	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
> +	struct mbm_state *m =3D &rr->d->mbm_local[idx];
>  	u64 cur_bw, bytes, cur_bytes;
>=20
>  	cur_bytes =3D rr->val;
> @@ -497,7 +519,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, stru=
ct
> rdt_domain *dom_mbm)  {
>  	u32 closid, rmid, cur_msr_val, new_msr_val;
>  	struct mbm_state *pmbm_data, *cmbm_data;
> -	u32 cur_bw, delta_bw, user_bw;
> +	u32 cur_bw, delta_bw, user_bw, idx;
>  	struct rdt_resource *r_mba;
>  	struct rdt_domain *dom_mba;
>  	struct list_head *head;
> @@ -510,7 +532,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, stru=
ct
> rdt_domain *dom_mbm)
>=20
>  	closid =3D rgrp->closid;
>  	rmid =3D rgrp->mon.rmid;
> -	pmbm_data =3D &dom_mbm->mbm_local[rmid];
> +	idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
> +	pmbm_data =3D &dom_mbm->mbm_local[idx];
>=20
>  	dom_mba =3D get_domain_from_cpu(smp_processor_id(), r_mba);
>  	if (!dom_mba) {
> @@ -693,19 +716,19 @@ void mbm_setup_overflow_handler(struct
> rdt_domain *dom, unsigned long delay_ms)
>=20
>  static int dom_data_init(struct rdt_resource *r)  {
> +	u32 nr_idx =3D resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry =3D NULL;
> -	int i, nr_rmids;
> +	int i;
>=20
> -	nr_rmids =3D r->num_rmid;
> -	rmid_ptrs =3D kcalloc(nr_rmids, sizeof(struct rmid_entry), GFP_KERNEL);
> +	rmid_ptrs =3D kcalloc(nr_idx, sizeof(struct rmid_entry), GFP_KERNEL);
>  	if (!rmid_ptrs)
>  		return -ENOMEM;
>=20
> -	for (i =3D 0; i < nr_rmids; i++) {
> +	for (i =3D 0; i < nr_idx; i++) {
>  		entry =3D &rmid_ptrs[i];
>  		INIT_LIST_HEAD(&entry->list);
>=20
> -		entry->rmid =3D i;
> +		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
>  		list_add_tail(&entry->list, &rmid_free_lru);
>  	}
>=20
> @@ -714,7 +737,7 @@ static int dom_data_init(struct rdt_resource *r)
>  	 * default_rdtgroup control group, which will be setup later. See
>  	 * rdtgroup_setup_root().
>  	 */
> -	entry =3D __rmid_entry(0, 0);
> +	entry =3D __rmid_entry(resctrl_arch_rmid_idx_encode(0, 0));

Closid is 0 here on x86. We need to have a consistent closid value on x86.
Maybe even define a macro for x86 closid value e.g. #define RMID_FIELD_CLOS=
ID_IGNORED 0.
So the macro value is used on X86 always.

>  	list_del(&entry->list);
>=20
>  	return 0;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f3b739c52e42..9ce4746778f4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3320,16 +3320,17 @@ void resctrl_offline_domain(struct rdt_resource *=
r,
> struct rdt_domain *d)
>=20
>  static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_dom=
ain
> *d)  {
> +	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
>  	size_t tsize;
>=20
>  	if (is_llc_occupancy_enabled()) {
> -		d->rmid_busy_llc =3D bitmap_zalloc(r->num_rmid, GFP_KERNEL);
> +		d->rmid_busy_llc =3D bitmap_zalloc(idx_limit, GFP_KERNEL);
>  		if (!d->rmid_busy_llc)
>  			return -ENOMEM;
>  	}
>  	if (is_mbm_total_enabled()) {
>  		tsize =3D sizeof(*d->mbm_total);
> -		d->mbm_total =3D kcalloc(r->num_rmid, tsize, GFP_KERNEL);
> +		d->mbm_total =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
>  		if (!d->mbm_total) {
>  			bitmap_free(d->rmid_busy_llc);
>  			return -ENOMEM;
> @@ -3337,7 +3338,7 @@ static int domain_setup_mon_state(struct
> rdt_resource *r, struct rdt_domain *d)
>  	}
>  	if (is_mbm_local_enabled()) {
>  		tsize =3D sizeof(*d->mbm_local);
> -		d->mbm_local =3D kcalloc(r->num_rmid, tsize, GFP_KERNEL);
> +		d->mbm_local =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
>  		if (!d->mbm_local) {
>  			bitmap_free(d->rmid_busy_llc);
>  			kfree(d->mbm_total);
> --
> 2.30.2

Thanks.

-Fenghua
