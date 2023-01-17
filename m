Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD066E6DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjAQTW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjAQTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:14:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6145BC5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673980154; x=1705516154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q437CF0GZOdSOv3MJ28b2mGzQ4RUE3DEc9BFdN7MDB8=;
  b=QWhaW7qjw+A5JeurpWmkpvKf7vZZDnT9YGKJpt0hXdvoXySZJAfWyfnN
   HEdjDXDVnLpixB3afSnIDwL0CTjrsf+TNMXoLmDIxWwCveQnvD4Y6mBuh
   LBz0xYqu84P1TRusuSTuKIOoY6c3NNrrDwq5xALZCFGkqicgQlSiCke4H
   xzZ37mDS4+PFQWg+3MKVwwTi1rJcmiGd+XI4OAY4GnkyblFqmwHitVgD5
   hvGXyjkBe1fuPwCTeWGJ7XQ3XfyCH0eUvRWBbvx9h0HELXLDPY1XJiVXp
   HHqtVIE7kZ3eZwRXFoO1x8Wgtw2a/KCnO9tGivFJqZ6gi0Di56YaDqZfJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304460674"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304460674"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:29:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="783341792"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="783341792"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2023 10:29:12 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:29:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:29:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 10:29:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 10:29:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxQzjsteVNNudQqEX4gyXcsKLIzmb9YgZYtQaVugwuhBy2FOuuOkL26d1lAkMaUuF6DXbPh/BUEhh/JgQuHDWQpSG6s4uhrTRnrr0Id4NNCeTZs38YfXMCHIq9BTJlofALp/U+YvDcxGE0HPikqDt2ke+OBaqDfs8KVVu9QUkqU4VtluPJ3G8yiuW46wjXZSA354q5QHQJprjZWFQnP+ZESbgyvxfW6t8ZPyemhGFinhQAltXF4iRhLBf8ICmpUdUpuJQVpmqXN7dTfG9PUc+97YhN2Vsj6C/uR6JO6tcul9bYPh6HNDcDPR274nIlvaMowC4wXUAp01IKz4QNbNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOJL/IV4DuByDZW+5DJYsD91kTMjyLmbRPwWWMp/LpE=;
 b=VVd6Cgvw2Dxz9O5Abqu3BaRGX/1K+jd1beOw4v0POW4I172/PQmF+sijho3aL6Beda8Hacak0tyqpmWwmggAqe5vzC/hD77b0eW2qEicIUcMpm/8RN7ECfDabTQTjZ8TTZjjyg01eOWhkjCXegLWZwRP+N6blKy4oR1Orkg0tWemuQD8PzBq1P50aqmrcCAbXTpNwjbm8kcEFACFCGUespUkJFZs+ODa96Z15ygXvdb7EAuAW6stGVSl2+LzpBgvzYXDcqtoEQTzBXJBV61EPWMWn6h11N518xUahOzQ2n2bhM2dM0HadabAv5zKsVCoKVeALZw2C0DJjxKFJ8Sw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 18:29:08 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%6]) with mapi id 15.20.5986.018; Tue, 17 Jan 2023
 18:29:08 +0000
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
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v2 02/18] x86/resctrl: Access per-rmid structures by index
Thread-Topic: [PATCH v2 02/18] x86/resctrl: Access per-rmid structures by
 index
Thread-Index: AQHZJ3hM+VcWIzEppUSZYtjY9I+xpa6hP2/A
Date:   Tue, 17 Jan 2023 18:29:08 +0000
Message-ID: <IA1PR11MB6097E206D4A9404BC3D78CD89BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-3-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-3-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|PH0PR11MB7541:EE_
x-ms-office365-filtering-correlation-id: 9c03e392-d014-4d5f-aa51-08daf8b8b896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d76dAnEF65GbDrcUmwdj43uDvscF5dqfHnsiI5Das7ADcExil292egVXOP+S2yG8NxUPCgx/yetklEx7850FieoItqHnSXF1MR5RvN+Vn54t7gb4f/1MaLHYZwXcVXMx4Lk8JdMdUpTSVgvJIGcywckK6mv5WFSNIE1ccOGEspZD9XMfjaBkXIliGuIW8EFNQ4wlD2TKN1YiE5gziZit2XGnneYE+DkhhvafQeFphKZqMx2OPhCzjTM4aBk5RY3NZtTKw353ieUVMddjnoaGXzTYMJl1GqFZCMyWUuLy5Wb5FrudpsgUvYpZc815PmM7uNaFHm6PxZogMjcoklJUHdnaqrevqZ/q2yzVaYDDQlqYmLTo8Up+Ic/zJBTGdkOPdtkQ9WSToNegUIs73bdUzhLSVc5F9jAko077eDn8d6aPaxxrbzSIdcq2/4u+aSSjkhTv2ZA1zZbZVToqi7roO+J0KzWPIm/TD+2IGP6FX49D8j4kDyHbPXUg5yavMS/nWnjHPnFGTW0E5VZUdmvFIptcogHbFjFp+QKaq5zzL2jQkQ6J4mJumYhiNjRYlLt9dw8laNcUhAh7ELiLhWLd2HYUiBTA8rdcYeCn9vYIq3H8VMc4xd9inPv2QH313Tz2pIOThuqLSWmsEa5rcvpck8xWV+mAWevO2qKXaHW12mFbMOBwJjoxyDw4+RgsjJ44VWMsuFo106AU6ryYYBMtvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(83380400001)(55016003)(86362001)(7416002)(38070700005)(52536014)(122000001)(82960400001)(2906002)(5660300002)(8936002)(38100700002)(316002)(8676002)(478600001)(6506007)(66476007)(9686003)(71200400001)(26005)(186003)(64756008)(66556008)(7696005)(76116006)(66446008)(4326008)(66946007)(110136005)(54906003)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vCEzSFieatqh3eyn9z2bKjOJlYOED6oQMIUKQN31joKO5uTposnWdDnbi1ZD?=
 =?us-ascii?Q?TO7Wx7PF+hcTx7FvPqT5vGjt5qIN3HGT5hHalg388l5++lskddMBWSXPJ0OR?=
 =?us-ascii?Q?vfsEO8jpl1SfTF1JKgf/rrERu3YFvjjq5BiWfhLQdBqpAP0+kcYkL9vtx1pb?=
 =?us-ascii?Q?d+C8VNNhwY8V8YJEh2uhHfWtj3ZgMSOD2rHTBj3yO4IcNRMjS3kLwlGpqMgo?=
 =?us-ascii?Q?acqsemNfqASLHQNUWP3ioNCFa+FTmiSWtJPktQJpIzcwmclOt2T4YLCXZnDA?=
 =?us-ascii?Q?xnTGsT/OA6u1q78fmn51l7cbVL4gO+9o0euOZuaHmiOl53PXCLfCiYF5/oEt?=
 =?us-ascii?Q?/in7Y47KLnSwimVNs05Ot6AEGYWTpGb29rh0idVzkMTCkr/yWZsLmFbsypO4?=
 =?us-ascii?Q?deFpD1sA9MdsTX695Cksy5STc+fsPEG698U4sqT6uCZnEWF1E4Nr3tGRvZjL?=
 =?us-ascii?Q?B2Cw9A1DoDf9KASrzI4CKCGXiNyzUXthLBZboWdMB8y1ptV63DTJIjPaF/eq?=
 =?us-ascii?Q?S5s+fBEkUaqTv73xORIvQTaXDIcdu2X2lpcY8OJAn5f1QvhRPKovdIIBj2fI?=
 =?us-ascii?Q?/kugcYyMgo7cE4tVyX9GsCo2QzdcFSmF7DnGXza47+3E+UyIojpLe1Stw6/c?=
 =?us-ascii?Q?JqBtOL8rGMWnUghe4qLd+VIhnJfKMyWJKK0c8lW007lhkUgCZ+57mGjtpSOT?=
 =?us-ascii?Q?X7jh+NbcPZw/u+VbjMp4DEcmCIHRc03ssYM96UaEXNhplIEXaH+YYEeLwYdp?=
 =?us-ascii?Q?NTi6i4c/KdiS1hJo8v2uZW1SYiphhx8ThN4Db1Eba8cRwZD9aCsAW2CEGVnd?=
 =?us-ascii?Q?b7OLQIS3q27JDdwuI/a77Lr66dxwrcaXyk6UtleolxrYmUpkAxCp3C7ACblj?=
 =?us-ascii?Q?/tSFr/k99pw7ky6oP0ZJWE4nQdMG2Nc9oLJhmtyn794566fgJx7B6syOyiYY?=
 =?us-ascii?Q?UM5g/r95B6aPqbpvl3CDwuC4XFO/hhGGKG1njV5kdi71xqfapIDDqRwqXiEz?=
 =?us-ascii?Q?yC2I8AcSJiBMTvkKpZpQVVCmQcvqeTofi5c8Hthq4crrmU1z0XUA37umORtp?=
 =?us-ascii?Q?jXN51IuazZVsRlmnN+nHs7Y5dYa4HyHd1PLPLc1sjBiuQk0d634lOvUde7ko?=
 =?us-ascii?Q?2647lMti9/Viw+NDNuhETZoJ/hjkpM6Byh9kMD68EJxQb7NCa8i2E/INRztg?=
 =?us-ascii?Q?T2nj1y0iVjNrXRiCvQTCHY+YuZ1QKkReZeBrLNtGXJkU7duuAUbWOOZ5jwR8?=
 =?us-ascii?Q?TiG8WVXwtHY6z3AVgvPBD0dkMHVkRidQq22ghwJXGvJSC93h8lMGhgXdA3N6?=
 =?us-ascii?Q?v/kHVFbaWFC/iN3+aFGdU7BmmaZVITpyKbuQzlI64TbdDJZvAltCMlWF7INB?=
 =?us-ascii?Q?RNJ/S4Qx9ZaaM7slHInZjAAsQaj/Hlpxi0oYMbaxM80yfMcn94j3qq9mLTc5?=
 =?us-ascii?Q?/b/y8m3aPoVe2bSR7hIZQBjE8rRxrGjIBenXx/GRgzcGhHE1RUEZDaR7RtxX?=
 =?us-ascii?Q?a0+wtb5AeaCMXtY2hegcM2c8Cz80SRbm/RLzHSvDkhRTSbSfC4fNCHE6uSDt?=
 =?us-ascii?Q?MfRw55Zt0D7ovKSHim+wRStGCCjKi2mww+kelLN5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c03e392-d014-4d5f-aa51-08daf8b8b896
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 18:29:08.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpNuv6/05I9KwK00cxdZePlAcHlxq9xSHzML2ZgPOoHtGejm/iSx+Atp/kc6AtTh7dMS91rx18Frmx4fV0xZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

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
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Added X86_BAD_CLOSID macro to make it clear what this value means
>  * Added second WARN_ON() for closid checking, and made both _ONCE()
> ---
>  arch/x86/include/asm/resctrl.h         | 24 ++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
> arch/x86/kernel/cpu/resctrl/monitor.c  | 79 +++++++++++++++++---------
> arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 ++-
>  4 files changed, 82 insertions(+), 30 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index 52788f79786f..44d568f3577c 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -7,6 +7,13 @@
>  #include <linux/sched.h>
>  #include <linux/jump_label.h>
>=20
> +/*
> + * This value can never be a valid CLOSID, and is used when mapping a
> + * (closid, rmid) pair to an index and back. On x86 only the RMID is
> + * needed.
> + */
> +#define X86_RESCTRL_BAD_CLOSID		~0
> +
>  /**
>   * struct resctrl_pqr_state - State cache for the PQR MSR
>   * @cur_rmid:		The cached Resource Monitoring ID
> @@ -94,6 +101,23 @@ static inline void resctrl_sched_in(void)
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
> +	*closid =3D X86_RESCTRL_BAD_CLOSID;
> +}
> +
> +static inline u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid) {

s/u32 closid/u32 ignored/, please.

> +	return rmid;
> +}
> +

Thanks.

-Fenghua
