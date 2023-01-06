Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314D165F9BF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjAFC5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjAFC5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:57:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CE63C0DF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672973838; x=1704509838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I4qWAbDzEgouRpbHZ18UFcFBlskZRphUZManat6apks=;
  b=f3z7tfMtebEsIzUrrYkQ78h9WIRZlzNKuts/JYvYbYNKV6AveXrFhcB7
   rSueiav3H5SWzoihtGpfyvhh+KhiV5m89X1eiPKtFUFcSgehEJp08VrgA
   EiXrlpE9rpXkxJaYNyAtkpiDhqeAFUYKWbESBpbfz9Gj6BODBhCjQlQfS
   +Zh2R3TQeNKqrjCf2mvz9ZYPkR7AaCxifZYJUFnTubz67ol7kMpM2/LZ9
   8/8iExk+p13wvwKle6w1e6RfW7UIErAUvd2uff5LWqsgIH0AyleV7uLTz
   kODdet4YQzrTdxdwWP82e6QJnWi0nnnY8Ei1lv0UJsaX/Q4Aeg5S+/mkp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="349600056"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="349600056"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 18:57:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="719052157"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="719052157"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jan 2023 18:57:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 18:57:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 18:57:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 18:57:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 18:57:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Leyz6aG/oM4Z8G58XUs0tM4LGsh5fUGYR1erN8tHx+F9Fr53waZCJ3vrdakzRU5w2jsLxZ1umAmdpx1bMzavipFhP0Zf8jdyd7khW4C2RvYGytf8m57kTtJPsOncAT6RC+F+Z/1CryrZx5EJiwHzifz2TM3VnJCN60DGvpiZ1qS9G9PFsNjtHQcCa+mFBAKgCCRZIBgZlqMB+TodAT6O4NvVR8hklfXIKkhzZd4CD1q/zCWW1zXppzM7X+Wm4yNwA8efaPZxUwb/l1qGm0J96WpYFQw4NTYhT8aFHrRJwt5bLIY5lrVGy8jmXR34WHfAkG7N9WFOMI66wEKKa3MGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OygtxP9N5dHRL5a6tbxowKKgcylv78mRzclY/ljmdww=;
 b=oQULwoNItAzKUE5nLlKM7kjKeQoOxSAINFWfPPGbt7AZZVI5Brrdb55KALJ/ZWJ72H33R95QAnMF4kShPOZ6rCMbhZFD07ff3W7TpEXILd+hWQ83MJj8AOYYEhT3ECREAHwU1yHUzbwkFVov+4UDWhNrbz6SRAxZLPnwK1ohzyltKRN79W24XPHBkExS98ncK4/HUIqqbhs0yubbNRfOXAKtAP3xX39kr6pzzcACIaITlsZm29VvTyV9nm7CQSdyetQWN0ONDXJ5z4rMdkGfuaQmj0ouZjfq+ZTZnAziHEXHdfcxr+qXG/lMM+M5rHOxwyo3p9sI8wCqSSmUvLum8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SN7PR11MB7509.namprd11.prod.outlook.com (2603:10b6:806:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 02:57:12 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 02:57:12 +0000
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
Subject: RE: [PATCH 01/18] x86/resctrl: Track the closid with the rmid
Thread-Topic: [PATCH 01/18] x86/resctrl: Track the closid with the rmid
Thread-Index: AQHY5U7NN1fP90vsN0CwPOACtvugOK6RJhiQ
Date:   Fri, 6 Jan 2023 02:57:11 +0000
Message-ID: <IA1PR11MB609724963D5C6086A98AC0479BFB9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-2-james.morse@arm.com>
In-Reply-To: <20221021131204.5581-2-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SN7PR11MB7509:EE_
x-ms-office365-filtering-correlation-id: c132a78b-4951-45ab-2009-08daef91b56c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h5VnPKsjO8opki2zDUBrn5lgJ9rdDbnSwKw5j0Z9twox6DhbL8VzcMnF+b/dJYQ6QbL7Axup2X0hw3WkcCsHsdlYe2taRbWMAMDWSuo+ouxR9F9V91h2YndaMUmAxwGRcJtR+8FomfRMOEURVM7DjgftulfIfY+RCEwGvX32HEcROvUmljfp28J4zDLtKbh9fs828NdjHeuUfoddAToisO6OOiHTkdcUDRkOGF+A0e/wvH7PkqWhx1HiiU/JKvoymE7XusP7oQoHJhort5t8ssr3nphLQZJm/htZDuKM/yDx1EzkD+ghWWrumaiRB/FY+fsNLpfvFYSmQOpFLzKaQi/7bn6N+wFIe2SO3V0y6Z0r7OLzu1gbyF2h+ArHyPLSwGQxvT16JfuVeAQbuz3GmF2UqBzGTu99IHXXonR9PiZ34YtuY1LKIVjMLGS7mWqWnIKug3h6j3UYW9c1j6DieGmwtKWWOi5K5aKOPqcTt5U5IfYzGV4qwULebCOG51bsmi5Oul9zxmDLV//j2S5nWHJlQ1YfG5spiHNVv/pGPKfnlZI0Tuc2JmWgnlzVLpicy+4rpI7/6FP1ycn6ywsOFn1lvDnFEGXNOPsusqpv80dZur1VB2+4rvTu9gExzUlNLzpddQhu5t4ZF3HFwVCpmyhUXtq0RER5v2xf5C3Jr8xF1eU6yxuHXAEGR33U55VUHByLmvcJLK57xBsEez5voQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199015)(7416002)(5660300002)(2906002)(8936002)(41300700001)(76116006)(4326008)(8676002)(66446008)(110136005)(66946007)(64756008)(66476007)(54906003)(316002)(66556008)(71200400001)(30864003)(52536014)(478600001)(26005)(9686003)(55016003)(7696005)(83380400001)(33656002)(6506007)(186003)(122000001)(38100700002)(82960400001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?12TmTybX4RX8beCHEQjBD44nv68tcuLAxEfiYEdP9gPOepfXOL+fEhpSDHSL?=
 =?us-ascii?Q?xsu9V3IaHwUgxWUOTCaRFEy9vcAX01mu9JFlTgqJpDsmxosZ5KgoMEcYzoK/?=
 =?us-ascii?Q?n2wtzvnBp6c/8IZ/LedwN2uUccxpGh+Ky6IFeRIPWUsoqqjv/LvD+5IZsWD+?=
 =?us-ascii?Q?pS2VfG7fmBnmd6FnHFeIJcbd9NXb+WR6LEIZVxsZQIU2dqEYjyOc7NmYuWAw?=
 =?us-ascii?Q?HzToTsLWE5icCun/3B/CGR09B+uaN4JI9dBCgMtxL/gJyLoBQQLsL9RsyYjf?=
 =?us-ascii?Q?FshA989oDvluC7drqRFAh9wl+X9G4pVyvvFyj93lzVz64J9E1bn+qDZvy2Cu?=
 =?us-ascii?Q?5b/fyGgxxvM8bDWdbdUkDiYShctIDgt3HGeU5z9eDy+ZkHYugNdgEI3dJJF7?=
 =?us-ascii?Q?dnYA4CkNIToyUiQXryUPRt/IgOauI+Mtirt0Vhnq9UTssJidG6sHPMXjb09H?=
 =?us-ascii?Q?eIxMsoy46zb67AiOO7SWHtHq8DGY4kDDveWcilpN3kA2Ns/93Vh+h/xhPBPa?=
 =?us-ascii?Q?BtKtEF5z0WywR0oq12GP4dZWJ0njvcPRvaGA9yl/pUe4ZlGZS1cb4rWUhtpo?=
 =?us-ascii?Q?frLv8O0qlcEtS7zDfFNWv80MTDl/AIhzUCw1J7kI3T+i7eJrXCVOnBZhz9nj?=
 =?us-ascii?Q?fJ3Hapm4tVd4PrB3TxJi7v7oab5SENk7GdTHRMpH4I7xWHNRBOhUUW5AIM8u?=
 =?us-ascii?Q?AutDVVr3wQD0Op5UzG0pxHSzWYxvAFZmZc4x4+l0RoFhue+jrVfh6lKqOs/G?=
 =?us-ascii?Q?pKuqfvqTUBGXFksvw7SJTvloc/aRbYL4n/CRZ/jmYstFdbtg3U85q4xamL8h?=
 =?us-ascii?Q?vvk24Uo0b/vA/5JTj9zJ9MgapZuGL5XHpmTlER/ae8Poq6+KF1eQ1KsPAQXB?=
 =?us-ascii?Q?oCmQj3ahJcnDnCanhHIEC3EDH4k+pujcaD0hJoJZ57TgSPPT5ICLCswF5bf6?=
 =?us-ascii?Q?COXSJ/8drdZNe9AmPQHspgCf37JOagpHjVNtHFmp9Oyy3jcJJjXwcbAMO291?=
 =?us-ascii?Q?E0z4UxTMHJDzDXUtyC5+506CmUePPnqDc2wsExyyFs0x0O9CaWuRxji3jqtc?=
 =?us-ascii?Q?lM+XOXhHzTZJdrUGfrw6dQf1aOT4izWFCRd++2KGaKCyEYzOkkoBeWDRnDwS?=
 =?us-ascii?Q?mzjY/59b1u2nMRxxHBkVpuEcxkLurIf05OqsB8dnNU1ngG11F8hOol4NrE78?=
 =?us-ascii?Q?Dlzuh8/yV/KBpGN4QNjXYQhmwjnjM/Dkfcmk/Xkp/utC018vJkTRRYsGRUn/?=
 =?us-ascii?Q?R+3ZmeSNxiENQgZcNUPmVNVf+gpEj7VOAIrBGes+jiFNwOEu5W45vrM3eAmy?=
 =?us-ascii?Q?I6hiP/kHLMT2G95gE1ZhdV/jra/Mn9KkC9OWleSVVwcgAmU9QQYNzOUJRFFq?=
 =?us-ascii?Q?oFbrqPOxj2iBp/SK6HxTjjFFFr4fHQH1UwXlHWYUPhO79xCqbL8dDpJElQN7?=
 =?us-ascii?Q?+eshFFnYUQsdrbJG7js8a2wmtnFbkyG7S+vLB0mY2auiCFsHsRKSfue1IJnF?=
 =?us-ascii?Q?MiVtDhBECW/ELI7XIefREHwMNA7SbTuFmB32G0V+Q+7O453xtMx2hGUbMtoR?=
 =?us-ascii?Q?f4posdjpmGJY0fGxVadC/HgK7Z/OnHeXtUu854gR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c132a78b-4951-45ab-2009-08daef91b56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 02:57:11.8780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRXg/a2sCM7klV39dzpSOKjBp7fhCr9o95K9mz4SWGN+1OPETgVl6HFF1er7d0+xQ5XtlCGCz1R8FhFKWFyjtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

> James Morse <james.morse@arm.com> writes:
>=20
> x86's RMID are independent of the CLOSID. An RMID can be allocated, used =
and
> freed without considering the CLOSID.
>=20
> MPAM's equivalent feature is PMG, which is not an independent number, it
> extends the CLOSID/PARTID space. For MPAM, only PMG-bits worth of 'RMID'
> can be allocated for a single CLOSID.
> i.e. if there is 1 bit of PMG space, then each CLOSID can have two monito=
r
> groups.
>=20
> To allow rescrl to disambiguate RMID values for different CLOSID, everyth=
ing in

s/rescrl/resctrl/

> resctrl that keeps an RMID value needs to know the CLOSID too. This will =
always
> be ignored on x86.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
>=20
> ---
> Is there a better term for 'the unique identifier for a monitor group'.
> Using RMID for that here may be confusing...
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 54 +++++++++++++----------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 ++---
>  include/linux/resctrl.h                   | 11 ++++-
>  5 files changed, 49 insertions(+), 34 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5f7128686cfd..4b243ba88882 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -519,7 +519,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu,
> struct rdt_resource *r);  int closids_supported(void);  void closid_free(=
int closid);
> int alloc_rmid(void); -void free_rmid(u32 rmid);
> +void free_rmid(u32 closid, u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);  void mon_event_count=
(void
> *info);  int rdtgroup_mondata_show(struct seq_file *m, void *arg); diff -=
-git
> a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index efe0c30d3a12..f1f66c9942a5 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -25,6 +25,7 @@
>  #include "internal.h"
>=20
>  struct rmid_entry {
> +	u32				closid;

Could you please add a comment for this closid field? It's expected to be f=
orm x86 RMID entry.
So it's deserved a comment to explain a bit more on this field.

>  	u32				rmid;
>  	int				busy;
>  	struct list_head		list;
> @@ -136,7 +137,7 @@ static inline u64 get_corrected_mbm_count(u32 rmid,
> unsigned long val)
>  	return val;
>  }
>=20
> -static inline struct rmid_entry *__rmid_entry(u32 rmid)
> +static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
>  {
>  	struct rmid_entry *entry;
>=20
> @@ -166,7 +167,8 @@ static struct arch_mbm_state
> *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,  }
>=20
>  void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *=
d,
> -			     u32 rmid, enum resctrl_event_id eventid)
> +			     u32 closid, u32 rmid,
> +			     enum resctrl_event_id eventid)
>  {
>  	struct rdt_hw_domain *hw_dom =3D resctrl_to_arch_dom(d);
>  	struct arch_mbm_state *am;
> @@ -185,7 +187,8 @@ static u64 mbm_overflow_count(u64 prev_msr, u64
> cur_msr, unsigned int width)  }
>=20
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> -			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
> +			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> +			   u64 *val)
>  {
>  	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom =3D resctrl_to_arch_dom(d); @@ -251,9
> +254,9 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  		if (nrmid >=3D r->num_rmid)
>  			break;
>=20
> -		entry =3D __rmid_entry(nrmid);
> +		entry =3D __rmid_entry(~0, nrmid);	// temporary
> -		if (resctrl_arch_rmid_read(r, d, entry->rmid,
> +		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
>  					   QOS_L3_OCCUP_EVENT_ID, &val)) {
>  			rmid_dirty =3D true;
>  		} else {
> @@ -308,7 +311,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entr=
y)
>  	cpu =3D get_cpu();
>  	list_for_each_entry(d, &r->domains, list) {
>  		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			err =3D resctrl_arch_rmid_read(r, d, entry->rmid,
> +			err =3D resctrl_arch_rmid_read(r, d, entry->closid,
> +						     entry->rmid,
>  						     QOS_L3_OCCUP_EVENT_ID,
>  						     &val);
>  			if (err || val <=3D resctrl_rmid_realloc_threshold) @@ -
> 332,7 +336,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		list_add_tail(&entry->list, &rmid_free_lru);  }
>=20
> -void free_rmid(u32 rmid)
> +void free_rmid(u32 closid, u32 rmid)
>  {
>  	struct rmid_entry *entry;
>=20
> @@ -341,7 +345,7 @@ void free_rmid(u32 rmid)
>=20
>  	lockdep_assert_held(&rdtgroup_mutex);
>=20
> -	entry =3D __rmid_entry(rmid);
> +	entry =3D __rmid_entry(closid, rmid);
>=20
>  	if (is_llc_occupancy_enabled())
>  		add_rmid_to_limbo(entry);
> @@ -349,15 +353,16 @@ void free_rmid(u32 rmid)
>  		list_add_tail(&entry->list, &rmid_free_lru);  }
>=20
> -static int __mon_event_count(u32 rmid, struct rmid_read *rr)
> +static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read
> +*rr)
>  {
>  	struct mbm_state *m;
>  	u64 tval =3D 0;
>=20
>  	if (rr->first)
> -		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> +		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
>=20
> -	rr->err =3D resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval=
);
> +	rr->err =3D resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evti=
d,
> +					 &tval);
>  	if (rr->err)
>  		return rr->err;
>=20
> @@ -400,7 +405,7 @@ static int __mon_event_count(u32 rmid, struct
> rmid_read *rr)
>   * __mon_event_count() is compared with the chunks value from the previo=
us
>   * invocation. This must be called once per second to maintain values in=
 MBps.
>   */
> -static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
> +static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
>  {
>  	struct mbm_state *m =3D &rr->d->mbm_local[rmid];
>  	u64 cur_bw, bytes, cur_bytes;
> @@ -430,7 +435,7 @@ void mon_event_count(void *info)
>=20
>  	rdtgrp =3D rr->rgrp;
>=20
> -	ret =3D __mon_event_count(rdtgrp->mon.rmid, rr);
> +	ret =3D __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
>=20
>  	/*
>  	 * For Ctrl groups read data from child monitor groups and @@ -441,7
> +446,8 @@ void mon_event_count(void *info)
>=20
>  	if (rdtgrp->type =3D=3D RDTCTRL_GROUP) {
>  		list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -			if (__mon_event_count(entry->mon.rmid, rr) =3D=3D 0)
> +			if (__mon_event_count(rdtgrp->closid, entry-
> >mon.rmid,
> +					      rr) =3D=3D 0)
>  				ret =3D 0;
>  		}
>  	}
> @@ -571,7 +577,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, stru=
ct
> rdt_domain *dom_mbm)
>  	}
>  }
>=20
> -static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int=
 rmid)
> +static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
> +		       u32 closid, u32 rmid)
>  {
>  	struct rmid_read rr;
>=20
> @@ -586,12 +593,12 @@ static void mbm_update(struct rdt_resource *r, stru=
ct
> rdt_domain *d, int rmid)
>  	if (is_mbm_total_enabled()) {
>  		rr.evtid =3D QOS_L3_MBM_TOTAL_EVENT_ID;
>  		rr.val =3D 0;
> -		__mon_event_count(rmid, &rr);
> +		__mon_event_count(closid, rmid, &rr);
>  	}
>  	if (is_mbm_local_enabled()) {
>  		rr.evtid =3D QOS_L3_MBM_LOCAL_EVENT_ID;
>  		rr.val =3D 0;
> -		__mon_event_count(rmid, &rr);
> +		__mon_event_count(closid, rmid, &rr);
>=20
>  		/*
>  		 * Call the MBA software controller only for the @@ -599,7
> +606,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domai=
n
> *d, int rmid)
>  		 * the software controller explicitly.
>  		 */
>  		if (is_mba_sc(NULL))
> -			mbm_bw_count(rmid, &rr);
> +			mbm_bw_count(closid, rmid, &rr);
>  	}
>  }
>=20
> @@ -656,11 +663,11 @@ void mbm_handle_overflow(struct work_struct
> *work)
>  	d =3D container_of(work, struct rdt_domain, mbm_over.work);
>=20
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mbm_update(r, d, prgrp->mon.rmid);
> +		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
>=20
>  		head =3D &prgrp->mon.crdtgrp_list;
>  		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> -			mbm_update(r, d, crgrp->mon.rmid);
> +			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
>=20
>  		if (is_mba_sc(NULL))
>  			update_mba_bw(prgrp, d);
> @@ -703,10 +710,11 @@ static int dom_data_init(struct rdt_resource *r)
>  	}
>=20
>  	/*
> -	 * RMID 0 is special and is always allocated. It's used for all
> -	 * tasks that are not monitored.
> +	 * RMID 0 is special and is always allocated. It's used for the
> +	 * default_rdtgroup control group, which will be setup later. See
> +	 * rdtgroup_setup_root().
>  	 */
> -	entry =3D __rmid_entry(0);
> +	entry =3D __rmid_entry(0, 0);
>  	list_del(&entry->list);
>=20
>  	return 0;
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index d961ae3ed96e..4d3706f71ee3 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -738,7 +738,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
>  	 * anymore when this group would be used for pseudo-locking. This
>  	 * is safe to call on platforms not capable of monitoring.
>  	 */
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>=20
>  	ret =3D 0;
>  	goto out;
> @@ -773,7 +773,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
>=20
>  	ret =3D rdtgroup_locksetup_user_restore(rdtgrp);
>  	if (ret) {
> -		free_rmid(rdtgrp->mon.rmid);
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  		return ret;
>  	}
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e5a48f05e787..f3b739c52e42 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2422,7 +2422,7 @@ static void free_all_child_rdtgrp(struct rdtgroup
> *rdtgrp)
>=20
>  	head =3D &rdtgrp->mon.crdtgrp_list;
>  	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
> -		free_rmid(sentry->mon.rmid);
> +		free_rmid(sentry->closid, sentry->mon.rmid);
>  		list_del(&sentry->mon.crdtgrp_list);
>=20
>  		if (atomic_read(&sentry->waitcount) !=3D 0) @@ -2462,7 +2462,7
> @@ static void rmdir_all_sub(void)
>  		cpumask_or(&rdtgroup_default.cpu_mask,
>  			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>=20
> -		free_rmid(rdtgrp->mon.rmid);
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>=20
>  		kernfs_remove(rdtgrp->kn);
>  		list_del(&rdtgrp->rdtgroup_list);
> @@ -2955,7 +2955,7 @@ static int mkdir_rdt_prepare(struct kernfs_node
> *parent_kn,
>  	return 0;
>=20
>  out_idfree:
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  out_destroy:
>  	kernfs_put(rdtgrp->kn);
>  	kernfs_remove(rdtgrp->kn);
> @@ -2969,7 +2969,7 @@ static int mkdir_rdt_prepare(struct kernfs_node
> *parent_kn,  static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)  =
{
>  	kernfs_remove(rgrp->kn);
> -	free_rmid(rgrp->mon.rmid);
> +	free_rmid(rgrp->closid, rgrp->mon.rmid);
>  	rdtgroup_remove(rgrp);
>  }
>=20
> @@ -3118,7 +3118,7 @@ static int rdtgroup_rmdir_mon(struct rdtgroup
> *rdtgrp, cpumask_var_t tmpmask)
>  	update_closid_rmid(tmpmask, NULL);
>=20
>  	rdtgrp->flags =3D RDT_DELETED;
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>=20
>  	/*
>  	 * Remove the rdtgrp from the parent ctrl_mon group's list @@ -3164,8
> +3164,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp,
> cpumask_var_t tmpmask)
>  	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>  	update_closid_rmid(tmpmask, NULL);
>=20
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  	closid_free(rdtgrp->closid);
> -	free_rmid(rdtgrp->mon.rmid);
>=20
>  	rdtgroup_ctrl_remove(rdtgrp);
>=20
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h index
> 0cf5b20c6ddf..641aea580a1f 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -225,6 +225,8 @@ void resctrl_offline_domain(struct rdt_resource *r,
> struct rdt_domain *d);
>   *			      for this resource and domain.
>   * @r:			resource that the counter should be read from.
>   * @d:			domain that the counter should be read from.
> + * @closid:		closid that matches the rmid. The counter may
> + *			match traffic of both closid and rmid, or rmid only.
>   * @rmid:		rmid of the counter to read.
>   * @eventid:		eventid to read, e.g. L3 occupancy.
>   * @val:		result of the counter read in bytes.
> @@ -235,20 +237,25 @@ void resctrl_offline_domain(struct rdt_resource *r,
> struct rdt_domain *d);
>   * 0 on success, or -EIO, -EINVAL etc on error.
>   */
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> -			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
> +			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> +			   u64 *val);
> +
>=20
>  /**
>   * resctrl_arch_reset_rmid() - Reset any private state associated with r=
mid
>   *			       and eventid.
>   * @r:		The domain's resource.
>   * @d:		The rmid's domain.
> + * @closid:	The closid that matches the rmid. Counters may match both
> + *		closid and rmid, or rmid only.
>   * @rmid:	The rmid whose counter values should be reset.
>   * @eventid:	The eventid whose counter values should be reset.
>   *
>   * This can be called from any CPU.
>   */
>  void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *=
d,
> -			     u32 rmid, enum resctrl_event_id eventid);
> +			     u32 closid, u32 rmid,
> +			     enum resctrl_event_id eventid);
>=20
>  extern unsigned int resctrl_rmid_realloc_threshold;  extern unsigned int
> resctrl_rmid_realloc_limit;
> --
> 2.30.2

Thanks.

-Fenghua
