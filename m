Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B106765FA1C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjAFDXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAFDXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:23:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD2365AC3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 19:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672975419; x=1704511419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vzaIpO9g2dJNqPE3cgeT+cA367kkjTyM4UVrmN1eSlQ=;
  b=cnLVBC1vi9Dy2LGhPDD53yO6qCTmGgoFd7Pze9ZxqiCmcQAleymW/iPT
   w4xmLJsVCWzIuY6h5QYfEr6jCbhyr0/pVP6gk3LroyHk8ndBoQyocUA4w
   9NX8v3y/7faXfgP/bBj8qr4yotyv1cM7HcEkjbrlJaHMR+bUN8geTU176
   4FITSdV0EpZLn/dprLY2CqPcA/I3wNXyOI88pN+1akJCajL4hC773flyL
   7F6uiXCqN/xlOAXUtxk0FQzUFqeArH9Bqr0qn+GtvMt93//oB68yCo/WY
   v9vXGMHOOryGzosiDvTvDy+wSGqlpn1oyCbWnhbDAl4i/Zo9wXodON34B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="408645499"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="408645499"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 19:23:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="779849694"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="779849694"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 05 Jan 2023 19:23:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 19:23:36 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 19:23:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 19:23:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 19:23:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjD5HZW8M0Aq8+P7lb6ZuOoDpKcwMhCFUsbJ6Jb4Dv8/d7knqWFpwWO95Nr6GvyBDCWJmrKzanymI4LXLHFF24dJ2o5DfRE218TQATe4FxNpyyrwuKuAQ+Bpyj5ikYtuvXnPhHin/oWtZIt/A1LEFL4x2MBSW5uOkrhdEfk1w3aaytERUoHOEEvUHsaVaQ5DIizKqDCstBPW0tui27e97eQvS+UqCDLb44EGk7Ejxy0dxF+/a4jQ11q/7wUGXmlwwNyB1PcLs4+Y4kfYO/pAg7SavTfP/3tXB/7Ma2IE8O3J11WsZZURRWhJHXRwweLSowLwUXz5s1j5qc3JBUnkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLragJX8s/J/N8yxZvhf/vewAN3DJuUrWwkqL4L+eoM=;
 b=HrN6dDZcyjbIEYq73H+Lpk4NKFI7W/PZxeeTGKLfRQ13lk4iChHVTDco40Lc1fHnS90D1zKuYEZ/yFRci2RbehF+Zi+qrOP91U+lbRRlq4nUHZ7JdoK/mo9rIXReReP16xfoLgYk1C/whAt0bMPO47LA/D07BgpwOBSxiTPN7l9UTaPx8INlemBy9UAm8ZG/e2rDJq1ePx3RMYNTVAmz7ORCZPBwCiH1Gz20ICijI0recQLhxrQ4OQK4V/W75LSq5NnLt++fYzBA3yfi76IiuwbEgvNiTWgwmhEulwLwHWj8pzgX9P9ZvVRwFTRZEp7N+VEOMhXu4gYWGk4wzDGtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:23:27 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:23:27 +0000
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
Subject: RE: [PATCH 03/18] x86/resctrl: Create helper for RMID allocation and
 mondata dir creation
Thread-Topic: [PATCH 03/18] x86/resctrl: Create helper for RMID allocation and
 mondata dir creation
Thread-Index: AQHY5U7RPCQTz11wxkuKthYppHLOmq6RL/jA
Date:   Fri, 6 Jan 2023 03:23:27 +0000
Message-ID: <IA1PR11MB6097DBE28137579B89FD23739BFB9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-4-james.morse@arm.com>
In-Reply-To: <20221021131204.5581-4-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|PH7PR11MB5984:EE_
x-ms-office365-filtering-correlation-id: c034acd5-fa6b-42da-1761-08daef95609f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/iXV77PA4wGXo/1Jy/d7uV5yQbkHposZXSlxgIRqCj2bzT8CgPnbN8j/gZhnTo4+mCuCxAROke7ycwLmHMrFmVXKReyGbdIwQmvAZ6PgVmhgi4XVAWLoo1zk+HTrfGdOU0wsQ5N6XG9fWXDGE0BnKS8hqB5sm04TANIA9D9EomnELV1uuFcg78fNbO717frpwn96HTWLHBJi923cUoO6XO/uOtdOt79Ma7x7/M6o2oVviR9QN9qG0jkfN2hgr5fmNOZuv92TJz7W9dxryeENHb5fnnOnOmc0LGZdFtXPyu5sSnmDDsbpbmQA0L1izKB6VKXRVtSReue0WMtRaZmf+RA8wLY3btfgVg113B/lkCDwpvjJU8A7OABmkBoEz0cl5PxeCiZ6P5EIcO0N+XDGOt0Ycuy9fnyJrYMC5HbVfJQsfccDiQzpJNk3pH80sORWWX9b7quVQiEVNxh2ceKpfuuSH2WsgLbyJdSqexZz8n8f+LdFh6/vxAkde18s6XxM3BpKXA9ItX8TJt4Mng04Smw6Nb1fGCxHDVTo56k5Zvj7AZUI8IvljygXJoJVwEUw/ib1MmZpyNcmM5Iq7ZIE/8VUjIV2Rr1DjqiIv5CSvi+uUoIf9TNFaAAx204DtPhw3ANEzcDNy774G/Hs2V3MaMrWE4uo8d2pCb6853shm+CghEtuzOMWGxHX4pvZhq/QTYOLW57p9jcoZHwJedAWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199015)(8936002)(86362001)(66946007)(38070700005)(41300700001)(66476007)(7416002)(66556008)(64756008)(2906002)(76116006)(8676002)(33656002)(5660300002)(4326008)(66446008)(122000001)(83380400001)(38100700002)(71200400001)(316002)(54906003)(478600001)(110136005)(82960400001)(55016003)(52536014)(7696005)(26005)(186003)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kekz1VJRtfo8lXreUcO3Im5TkSmajRM07EO8n83lWd7LEPoGbjvdcA1aM0aC?=
 =?us-ascii?Q?jSGkqeeyBj1FAl/HGMMbldaOnIJCN1C4ONGc5XlL//jBC1HwWOoKwjSlNqjN?=
 =?us-ascii?Q?9/e0FAQ1QLk/zQV3bNScLItBmtQSzw0mpRecQPEbPIZwJWgQ4X0Ee6qJYlyb?=
 =?us-ascii?Q?QO6qxUxMYIZfM69QdRNf44fBnEevrLBEqn+KIVS/wompRmuxtTd7SZKywlYp?=
 =?us-ascii?Q?g3B+qCbJvgRlFFqu+7Lm0JTc7PmrUN2uk/aL+r+XN95djgeZwhPY3ESY58SZ?=
 =?us-ascii?Q?2U+anclUzqjfMZvS2KkmhV4+jlJTrAuSxKw4UiWqj2hoTOK9TmxnnyY6F45L?=
 =?us-ascii?Q?CO1mdcH5k+8Y0CuBh/BbPVqC6BT5v4TWn/9k+9qpPeYvzXCjC5EdoOt/K7S6?=
 =?us-ascii?Q?myDXF/JMOih3k9jReOasZWIEJOUzLPDSTG7VkV79G91tRrIrM53hZsB/aCed?=
 =?us-ascii?Q?UZjcwYR4cavnluXpQIiryaN6V+YyNmbHnCtWTckbVhP4Erc5Imu4chnj4EgQ?=
 =?us-ascii?Q?vmKQ6Q3DPzBx+vDwx0aNMCzA7zANHPElG89LjQV23RH7XybqEnoCwYt4mxP6?=
 =?us-ascii?Q?nq1IzVQvkaeG919GyPApb8Xvbj5OJihF2Me3DZ+HH/9hp+Ln1otBbOisBRPt?=
 =?us-ascii?Q?h5dRhyCn1k6hh/v9wRB5HzaCyH1TCU5LYkpxgdJlqCwAGQjehoQzYQVUqMf0?=
 =?us-ascii?Q?tg63f2v/2P+T/rTl2AJX1D2UXM6Te8zZZVHCZyB0gC705TgmazBS9MwTyb/C?=
 =?us-ascii?Q?RNLlW2p+Z8+cB1SEb1T2RBiysMnRDZ+sB2wNCg/CI7Zjz7rzL1MZcrmc/hdU?=
 =?us-ascii?Q?e31Xfp1nbeO2M0RsPr0amElR6KFF9FndT1+JGvD4xQvma4L0UzSwJLQQ1pc1?=
 =?us-ascii?Q?BaeKnQUnZojKjoeuuPIGX5RIyolLhk0HiIzhDcs1EjHGsO6Wr+w2nZtGYVDw?=
 =?us-ascii?Q?QKNOktM71u8aOrSDODukySc2RGzCojIjkQzy75jqcQima5Mj+dhLW2lY9YRw?=
 =?us-ascii?Q?wa3+NoFKla3/0cK2gVdKmYDolI8eVRim0kpCP6u2CqKFPnPqHn6Qz1mKkWMT?=
 =?us-ascii?Q?WLdyRMen6SLCKHY0zFfoglQ4KmrAFpwTAYglqiApj+/Uq55xy13R08/wkTwQ?=
 =?us-ascii?Q?g4rcjns7wpkSw/891KqkGzS4WrZe0x5XSySK8MJMLM9/lBAjDs2sXXM2+GiG?=
 =?us-ascii?Q?rFM56+LOYXLT/qnUHhvA3EfVzPPAv1vY09st34m+SwWw/qX9Xzl/SIfYbVvY?=
 =?us-ascii?Q?BwYm0odLjCZ71CEVPHeZnKPm29OVtgzxETThA6NngvjNbskiphgiZDgFgmWY?=
 =?us-ascii?Q?L7MHJPs3AhgLiqWC83oosNpQUN2Mih8NkURj8Zpx0TS2iLCYMgDFrTV5BG1Y?=
 =?us-ascii?Q?jahx0/YfnLAwFJMDPfI8Mcczy24yuMBdRvHQzB9wYejnwdKrRhIViyAkxgbP?=
 =?us-ascii?Q?MAhDEQpeS96gBFgxGKzjeE7rSX+4KT37AdttwyP7RjNOQcOBP5OcqcwF45Xf?=
 =?us-ascii?Q?byNj704K0jHz8C/OMGJ9fH9f0N64IS4g5NlNPP0tJfJRF34KdQcFxL/pYC06?=
 =?us-ascii?Q?IIMOo1o0t8q4rCEuZY6ExhuhoPwLlEU62xnKY0DB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c034acd5-fa6b-42da-1761-08daef95609f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 03:23:27.6082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TS4U+jgis+2GsEDGA6Sg5plWCepNy+zHr5lfJZvwiLlkqduCdHUXx85oHiglVl4gX3lAXuS4Z5vqb9//4Jr8yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5984
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

> James Morse <james.morse@arm.com> writes:
>=20
> RMID are allocated for each monitor or control group directory, because e=
ach
> of these needs its own RMID. For control groups,
> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
>=20
> MPAM's equivalent of RMID are not an independent number, so can't be
> allocated until the CLOSID is known. An RMID allocation for one CLOSID ma=
y fail,
> whereas another may succeed depending on how many monitor groups a
> control group has.
>=20
> The RMID allocation needs to move to be after the CLOSID has been allocat=
ed.
>=20
> To make a subsequent change that does this easier to read, move the RMID
> allocation and mondata dir creation to a helper.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 42 +++++++++++++++++---------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 9ce4746778f4..841294ad6263 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2868,6 +2868,30 @@ static int rdtgroup_init_alloc(struct rdtgroup *rd=
tgrp)
>  	return 0;
>  }
>=20
> +static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp) {
> +	int ret;
> +
> +	if (!rdt_mon_capable)
> +		return 0;
> +
> +	ret =3D alloc_rmid();
> +	if (ret < 0) {
> +		rdt_last_cmd_puts("Out of RMIDs\n");
> +		return ret;
> +	}
> +	rdtgrp->mon.rmid =3D ret;
> +
> +	ret =3D mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp-
> >mon.mon_data_kn);
> +	if (ret) {
> +		rdt_last_cmd_puts("kernfs subdir error\n");
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  			     const char *name, umode_t mode,
>  			     enum rdt_group_type rtype, struct rdtgroup **r)
> @@ -2933,20 +2957,10 @@ static int mkdir_rdt_prepare(struct kernfs_node
> *parent_kn,
>  		goto out_destroy;
>  	}
>=20
> -	if (rdt_mon_capable) {
> -		ret =3D alloc_rmid();
> -		if (ret < 0) {
> -			rdt_last_cmd_puts("Out of RMIDs\n");
> -			goto out_destroy;
> -		}
> -		rdtgrp->mon.rmid =3D ret;
> +	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret)
> +		goto out_destroy;
>=20
> -		ret =3D mkdir_mondata_all(kn, rdtgrp, &rdtgrp-
> >mon.mon_data_kn);
> -		if (ret) {
> -			rdt_last_cmd_puts("kernfs subdir error\n");
> -			goto out_idfree;
> -		}
> -	}
>  	kernfs_activate(kn);
>=20
>  	/*
> @@ -2954,8 +2968,6 @@ static int mkdir_rdt_prepare(struct kernfs_node
> *parent_kn,
>  	 */
>  	return 0;
>=20
> -out_idfree:
> -	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  out_destroy:
>  	kernfs_put(rdtgrp->kn);
>  	kernfs_remove(rdtgrp->kn);

Why not free allocated rmid? Rmid leak without freed.

Thanks.

-Fenghua
