Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D066E6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjAQTXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjAQTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:14:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D778C45BCB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673980162; x=1705516162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uv9SI4nUVi9GnAZlQJAVruTR0kAH6Tiav9cr74CCGwg=;
  b=KosLKTos2h3osPU9B9cqP7UrSJaeWH+0ELdoS4jsBp0JTAEe48pvZwtz
   PGeedlqEQ9Ig2fcDborigUv2kqqWvjiVZLTKAMN9NBqJA+sQttaBBZb95
   zwQ0saQ8gZwFxjUZ5TmwE4ApAcNmtbz/dKXIJ9E5F83/7t9C/7HYVQxZG
   JAjPmxQTDje2L/XWQIvu3/nu4QGp/3qVn+kyXFAC+MEl641lIrVq3dJSa
   cicUGg7oQgJLg/PEr+5pbvInzasm6aSJcHxBnFJC4q7dlDYmrpx0jRtDY
   TXTJyGkVELSKilIQSyNfs8fyNhKNPvGYmRmM00KjzGBJnmVjy9xrmNPxK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304460716"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304460716"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="783341844"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="783341844"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2023 10:29:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:29:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:29:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 10:29:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 10:29:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YosfcQM0u+53wpAHXGH8ds14lHVwIwfx10JCyvhkdf9cq9POyV0Gbu4Y/Pu8cPJSj9nMUWddGnoPeJ7v5wJVhvZvfLSb2TLG3u7E9ED+el3thUdmVxwBojwGuhK6hmPjJ9aoL/stkV0DQ6n6JP7cWUi3IibC6V0MtljEZXkyDwD3kLgvmLQdPCwCBkJN9V4vc4uZW5tMok0TTeC4y+h9Hsx83H0OHLREplwtnpjMCCyg5PSuvEPZ2EshROeKlRbcEQlUax+hhbJGR5rW2upcdHBq5nA3ocSpFl0t7OUFS2tqa5S7jCNbdtTLhL8Q7AhJwYWqcH6jd/63Pyn2n0SPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLB+08cmR87sRTDQjYXqkruSldvbcUnwxBU8jdCZp58=;
 b=YDm4/WlOWNE3xG6FE6XOWkU6ZL/sIkN46d2VsN3szHa7fRLMsAcbdCbgWCI9GQqDXr5qvnMlb50L7o7rpHn28wHM61Fe8cjcEka0EZ+i0NTDSeUz6/JIhlVgjJJMnzi6o7ZjTk6ksa9fuGrsQQOjTZ6bMGP6LX99+lbWjfK9Y9+dTiJZI20H0gwAf/ePRipYvXwUZIFGTODsY4HhJ4TxNKEHhyU99E3pTCEoVht4YOuB0LTJJy7dauRn9vNdcYvS0maTTz5mxem4cGw69+eXYrbCCndxImYltoohcLVakv/uffvEfu8ZRJQ32n3TNuDU81gOAZfQMGt3JF/jb5q9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 18:29:18 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%6]) with mapi id 15.20.5986.018; Tue, 17 Jan 2023
 18:29:18 +0000
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
Subject: RE: [PATCH v2 08/18] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Thread-Topic: [PATCH v2 08/18] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Thread-Index: AQHZJ3hXXNy7ItZKE0GbLj+Jq0J8EK6hSgIg
Date:   Tue, 17 Jan 2023 18:29:18 +0000
Message-ID: <IA1PR11MB6097ED9919B408116EFE161E9BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-9-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-9-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|PH0PR11MB7541:EE_
x-ms-office365-filtering-correlation-id: e5d2e54f-44d6-4766-476d-08daf8b8beab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdBiX6tA+YWsIXDPhCs5d0emR++pt0upZsUvViulSvw02ijst3hF28Yu3TPyEmhencOLYQb3V3Nnt1fVTPiD7sd1BQS0FUIi0wmSwB9VjWSBtWHcYA5Lr+HlYr97BE5/Zi0Qt/YTI7+qYLIg10EbSEWBzTCV7WeQxwymOeNBUYNGII9pSrzNW8VNgsTS4MTUf/Gi3m1yc0sdvxGNpwdRqAq5ney4w6tlPQYJhQ85jqTCJXFH64bLgZKVDNthiFZBbzA6d2kRoVLIdXu+5d+aNeTkngqudIUyH8we6vGm5FtrOnFkRacs9mBbJ+ONIU/XhlfkIywRoq6gD787xXGaGPm/lB6wwvFIN8o/bBbtK1qsH+kGLTcpQxV9tlq5Qvxd4i+/y11MLDFiAGMQQxigYDInaTLMt4KVv0aXr7zXoRvLxN9Tz+RU2K3rljC5ojyj5i0VtHARdIKQd18Kxky4u1OB4QP5E8qIxwCI5F1jjyGD7WH0n4v59JerhAnjZc9N87z+4Rqkcdv63d4n/xaYCVopggkH8IRm2raALZ/f3KYZW9Vl8ORzIyL9NXVpzFojDjQEOg/zIzkg5osqlpD50gEW/ttpBTNsCc4Ak4nwhSk5w+/PPGTgAn9KlZM0yRzsZPoYJwYKh6k27TeQ6Y7979GFy6EDf8DNncJ4R3jhKLHmvQxDZDz+H94sBKnHQ7iwUfQPAuIyrZlpHQknRKgwYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(83380400001)(55016003)(86362001)(7416002)(38070700005)(52536014)(122000001)(82960400001)(2906002)(5660300002)(8936002)(38100700002)(316002)(8676002)(478600001)(6506007)(66476007)(9686003)(71200400001)(26005)(186003)(64756008)(66556008)(7696005)(76116006)(66446008)(4326008)(66946007)(110136005)(54906003)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FmSknXDMsy92MmBkVyAifNmrQ+uVyw1JhFchfctzToLX+Jogvj8sGgRo+Q4I?=
 =?us-ascii?Q?fAzhEnCzOgTJBUe6uKTuaj0ZYrQWyfnmGgrV+RoCsqXqaSFxVD15ml548J12?=
 =?us-ascii?Q?5SVFhBupreDlX+YdU5bbXeTJjmHMzuCyphuJzyvnVZWScJ3aphQzMNUpFWsV?=
 =?us-ascii?Q?oAZLU4ZkEIWOuPZJ9DCAd0717UeRlbHWKol/iAXoEYgxjSIc+arWOCOSWEzY?=
 =?us-ascii?Q?8bQdaY/pSkh19SXrcvfJFKLcyWtNjS3Vdp40KzK8M+8XoyEBUGCmEgEvbkvQ?=
 =?us-ascii?Q?9uY8hEjwiXngrZTAFu47RsKlbIhVjeTnoQRpDqXh8ML8fJr+acMjYbBX9wHq?=
 =?us-ascii?Q?8XyWK0OdmfurxWBiEPQ04NAemC4Oy3HSoF5I+DDc3B9ibwWCYTFgRKNOmNet?=
 =?us-ascii?Q?z+Nodpd4NGdoyOrR+IIKWD2KGxBkrbu3/hRm2bn6067w7DzNUOAWisHU4v0h?=
 =?us-ascii?Q?AFPeiFxRbH410IUKQPRNuDP7YuiHKd/nZZJGzE9wUphAHDcMVZJpE6MgKEoq?=
 =?us-ascii?Q?gYp0nx2xwY/p9nwDDc2YlStd39ElYBGtPaM/QDcOvuSV6hZXbg0GhJ04z8zo?=
 =?us-ascii?Q?n+mI4pqT9Gi9h16EwKW5AWykganFhGcUCKV2dF7c/uw7d9pp1So92EH4mMED?=
 =?us-ascii?Q?vZ2Ftx9YKTZ8vhHzPMcgxmB2bug/HiUsMWfH1SJ7Ow+QMiHMQA2lJmlbSONV?=
 =?us-ascii?Q?mBk27nK6d9RiNYq5q0qT1vBUqbujjzWPYXQ6aeTkPoWkPzGoxljzZdUPJ3xO?=
 =?us-ascii?Q?pqz6W9cqKcLEoTTr9/s5nZ5lvv1Ll2m2WlImdrCVXOTt6iLbOMnQL66buh98?=
 =?us-ascii?Q?wj8jmmKnUDUfAXEVktd0TMN9/gx0Q9XYa5/EXRBWynaY/O1tekoFgOndr/zB?=
 =?us-ascii?Q?HZzM7ZKV4+/EgyLNSDwjDr3pvLnYBA13a21g1edAnWx1SBuORLftm0rHmnEY?=
 =?us-ascii?Q?y51fSaEBp4SemMzEDC5msQFUUxOGvMazV6HmXRpVUlvR6m1Cx90E8B2+asl4?=
 =?us-ascii?Q?f0/ERNNlh6avkMiqH9QJAJgchQyqBQBc4GNDdHyXqnd+t10z/P/rmQeCv7zF?=
 =?us-ascii?Q?D4gKl1surQeh+72T3DwhXhX4BZzXlj5ng9i8Lfb94MnhJiEYKs7mJ/4fDAOg?=
 =?us-ascii?Q?72lf52jgAUWgCet0YSDKQ3HXpA88LNxhCvbVk/B6R30TAVf2g5mb4c8Ta/DX?=
 =?us-ascii?Q?Ce2zIRnqKQg55Z2ODh3pUFKE1hVk1Bif+pPoWBQu4CQK4JOrQ8I5M7Lck5Ea?=
 =?us-ascii?Q?4vSBgzZ8Yai1pdzxcz8COqd17FXgMU1JNhl1yxqC502v4sJwFesPNUT0OU1k?=
 =?us-ascii?Q?TJabQIMidzchGKqf5enKM9Vu9dOnrHMFdRr8zALOuFqqnkVWn/WMhARGsWaF?=
 =?us-ascii?Q?xwa+H4eE9vWfSDh7eJYreqB8Jx5ibT81uOwdb4OL9Zte7Zz8+JOzR9CVqNu7?=
 =?us-ascii?Q?ab4pAAnI5kXU4sPRnRW5QuwAqIbkgE+q0wGPhupGPjrih3u0jpcoyCsI9tIE?=
 =?us-ascii?Q?gd8K19k1NLFqg1CV5rEep+Ynwr96ZTs5nSWlK18AiXQ1yi7gb0t7+QHBH29J?=
 =?us-ascii?Q?ZTLh+d7q0RZ+lyBlU1A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d2e54f-44d6-4766-476d-08daf8b8beab
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 18:29:18.2444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPB+eaHr4X0AAtoYLw+NPMwmyXBKhbwGk1RxhpMhKRbN55wfbelSPBaeiusJNv71lZLLpQbMG3OUWzKd4+Q0jA==
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

> x86 is blessed with an abundance of monitors, one per RMID, that can be r=
ead
> from any CPU in the domain. MPAMs monitors reside in the MMIO MSC, the
> number implemented is up to the manufacturer. This means when there are
> fewer monitors than needed, they need to be allocated and freed.
>=20
> Worse, the domain may be broken up into slices, and the MMIO accesses for
> each slice may need performing from different CPUs.
>=20
> These two details mean MPAMs monitor code needs to be able to sleep, and =
IPI
> another CPU in the domain to read from a resource that has been sliced.
>=20
> mon_event_read() already invokes mon_event_count() via IPI, which means t=
his
> isn't possible.
>=20
> Change mon_event_read() to schedule mon_event_count() on a remote CPU
> and wait, instead of sending an IPI. This function is only used in respon=
se to a
> user-space filesystem request (not the timing sensitive overflow code).

But mkdir mon group needs mon_event_count() to reset RMID state.
If mon_event_count() is called much later, the RMID state may be used
before it's reset. E.g. prev_msr might be non-0 value. That will cause
overflow code failure.

Seems this may happen on both x86 and arm64. At least need to make sure
RMID state reset happens before it's used.

>=20
> This allows MPAM to hide the slice behaviour from resctrl, and to keep th=
e
> monitor-allocation in monitor.c.
>=20
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 7 +++++--
>  arch/x86/kernel/cpu/resctrl/internal.h    | 2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 6 ++++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 1df0e3262bca..4ee3da6dced7 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -532,8 +532,11 @@ void mon_event_read(struct rmid_read *rr, struct
> rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first)
>  {
> +	/* When picking a cpu from cpu_mask, ensure it can't race with cpuhp
> */
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	/*
> -	 * setup the parameters to send to the IPI to read the data.
> +	 * setup the parameters to pass to mon_event_count() to read the data.
>  	 */
>  	rr->rgrp =3D rdtgrp;
>  	rr->evtid =3D evtid;
> @@ -542,7 +545,7 @@ void mon_event_read(struct rmid_read *rr, struct
> rdt_resource *r,
>  	rr->val =3D 0;
>  	rr->first =3D first;
>=20
> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	smp_call_on_cpu(cpumask_any(&d->cpu_mask), mon_event_count, rr,
> +false);
>  }
>=20
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg) diff --git
> a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index adae6231324f..1f90a10b75a1 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -514,7 +514,7 @@ void closid_free(int closid);  int alloc_rmid(u32 clo=
sid);
> void free_rmid(u32 closid, u32 rmid);  int rdt_get_mon_l3_config(struct
> rdt_resource *r); -void mon_event_count(void *info);
> +int mon_event_count(void *info);
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);  void
> mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp, diff --git
> a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 190ac183139e..d309b830aeb2 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -509,10 +509,10 @@ static void mbm_bw_count(u32 closid, u32 rmid,
> struct rmid_read *rr)  }
>=20
>  /*
> - * This is called via IPI to read the CQM/MBM counters
> + * This is scheduled by mon_event_read() to read the CQM/MBM counters
>   * on a domain.
>   */
> -void mon_event_count(void *info)
> +int mon_event_count(void *info)
>  {
>  	struct rdtgroup *rdtgrp, *entry;
>  	struct rmid_read *rr =3D info;
> @@ -545,6 +545,8 @@ void mon_event_count(void *info)
>  	 */
>  	if (ret =3D=3D 0)
>  		rr->err =3D 0;
> +
> +	return 0;
>  }
>=20
>  /*
> --
> 2.30.2

Thanks.

-Fenghua
