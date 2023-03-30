Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41AE6D0965
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjC3PWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjC3PWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:22:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475DD10E;
        Thu, 30 Mar 2023 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680189723; x=1711725723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R9ZL0gHuFad+ZwUefOn4on+Tp6hD72SKLWl1hEdZ5Os=;
  b=BCm2ETgGIjY4Yo6787zxySRLlUz4ovCB+iuTEcCSj+xzC8FR9bMhlP2D
   rw3ezlsZ+ToibkJxkQ2fgfPI0r4STeSjapZthe0zstfdV94O+BmnZ2vTV
   aeDZIhV7NB1xZ6DtF5dS9i6dHkFUazvp2AXwDypTpTI6NwAZnZkROtBsp
   e0JwOMMed/xvEpQnN2cxdaYUd9wvq8Yu7pLPuNu9VHg33m4Nt5rk+lh5J
   4MHdnfhnQjtOw0cTESk2iB8IcqoZyljuDTwYCtB7q2PziTCmy/V5pwXOW
   A4fp9XFbyXn8msZFeoZyDqu3O4P+dce38uKBNeGovKSA0pqddmzQmGd0f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342837765"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="342837765"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 08:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="754062515"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="754062515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2023 08:20:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 08:20:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 08:20:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 08:20:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 08:20:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar6aixSCMw5h4S3Q2R2mSwtC7+o3weHXeDuNCPGoTcV+QaAuUmzb+Vh94eEkpAvGIsl2Y/X4pYySPnmLgdl6NyKLd0qwcQL2N8GjmE3rDBdDi+Hfo1rnVmA4A8UBDoZJ8CRH0yrFVLaNDfe3t0xIwVajQ/UQ4l31T2eZsGXlwPUjWnrdpU/yYWUrG1fw3/eyOvfL+LwnYLL6yOUC/W+LYyi6hBuoZ7eEsWN/BSxR71M5eMVxRCldj5RqEEArkKbs0SgNCHDcW/ElwDwtJAQsGctwyj5YDz12886fW2Pr5OsqyN9F4kltKkVVpJRYB6pnD+hnRscYnw5+NW7ypUY1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlzE74OTbFLlkep/4jx826BiPRjlNMBjNW8wlbSDahQ=;
 b=T4daHP1UdbYnmaTCEKN/dvirzSyHiUz+xBAcOxLS2YsmNSbnEmrLqabpIqItY8U2FTW0nbx25jlIa7WHo5Fx02ZQIi2tSuYpTm6skOBZjn/DExLKZHNFwGMilOmRRgOV3axBiigeqFGmL2cMa9ntU+Kro7sn3Zo1flrkt61PcJefEPfB/1ojIE516rj9XlZY6v2PMqUIcEM8mDEuJzBoz7T58wH96Pvd0LFqKK9jCRmMEeDzlQVrtDUr0YgyNUKruLSc4TXEpSfX3T4/Jzg8JbBD6pJlVaISOupjsNGUdgk+aVJ/CuVKMxBgHaWUQ58wm9EY9Dhcgz2wsLRYOud6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA1PR11MB6806.namprd11.prod.outlook.com (2603:10b6:806:24d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 15:20:15 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 15:20:15 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hch@lst.de" <hch@lst.de>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: RE: [PATCH RFC rcu 02/19] srcu: Use static init for statically
 allocated in-module srcu_struct
Thread-Topic: [PATCH RFC rcu 02/19] srcu: Use static init for statically
 allocated in-module srcu_struct
Thread-Index: AQHZXeZkMjCksJUJIEigTtRmvPjKta8SunIggAC5AYCAAAGhAIAABLIw
Date:   Thu, 30 Mar 2023 15:20:15 +0000
Message-ID: <PH0PR11MB588088F6212E9291D3E69244DA8E9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
 <20230324001938.3443499-2-paulmck@kernel.org>
 <PH0PR11MB5880CA682074874FF64B3412DA8E9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <b66d52cb-ed73-4c7f-bab0-201dc13d164a@paulmck-laptop>
 <PH0PR11MB58807EB1C375AE03F8586C92DA8E9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58807EB1C375AE03F8586C92DA8E9@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA1PR11MB6806:EE_
x-ms-office365-filtering-correlation-id: bd5e67c6-2bf6-4a0d-b79c-08db31324398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +K8UZxB4sUfSLNBKWW43/qPknWmEL0t/v1niqY+g+AiXldQhl3iF6IDLWdcgsF1MUtYrZvC50UMlKcMNEboDM6fcAIYRLY3sQqhQf+3wG2+sxC0evQTYiURrkiq5uUnlt6xcwAlUzRF2mmGF203G5J1Jrmsan5c5n2U7BeGkBkevIyIVXh47RV589WPqUsIEtJ/8Dp3i89E3CFkW92KNFT0DMJdTaFgXLrrBomg8GVPNfAnAZNerCdiQ4d4RnpXU0GmakWCllaEDMnuRDwWNYV22Krhg05M1ygDcrXfTRnL3DjHCkVLIfBt+Z2vqArh4h/V8Bq7pr7efB+k15wowpv8BSOXImJYAwNXFmNG65n0hRnGRxMDHrZo45JOaJKXBYJVsTU+JLvEGWT/f2a6gFfm0YhqWpX5if7caKYjXxqTW1iPSxflnzrxaJ17s+DAok/MKg4qtJmM82fbovUVsxpIUGFYVGLFcA1htTqneqS8wkgonkt7cH2PGqNt2s4L8+SDAI5Xd5NgIaDSBTNFM0HB2xXpeZDIUdjGfAD2W5f+poVMvsVyqJud0EPLg4xxN8xez0qi2iJpWkW0TvjEIR+Zfp8QsDfhsslLEWmO8BejdWEBrEgk1HxbkVOWuZ/Yk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(86362001)(38070700005)(122000001)(33656002)(83380400001)(9686003)(6506007)(26005)(5660300002)(52536014)(8936002)(82960400001)(186003)(41300700001)(71200400001)(55016003)(76116006)(4326008)(7696005)(66556008)(8676002)(110136005)(2906002)(38100700002)(2940100002)(66446008)(66946007)(316002)(54906003)(66476007)(64756008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wzPtM2M8HPVgds5REEvyxyEJlThNqbyDwrv58tm+ot0Ci2qVx8OnBu5a75RE?=
 =?us-ascii?Q?UN87Aa+BdT3kt6JnVjxbWCe/QG9fz+2hxOPlRBbpOB87l0kXUVnHmphfT1Ey?=
 =?us-ascii?Q?CllYU19xd8ghBEEOs+Hn2ASxsRg2ipRRxuQDTV0Ye8pHFD4agBwh81K/uQ1c?=
 =?us-ascii?Q?u6CqiSt/qRXB9g5kwF+XHVwuAP9qAqYSTBWmdJW9NGZjMGx2l41rd9oTtDcX?=
 =?us-ascii?Q?9GeLc4X6LofuD/7R/aWRW7wiOE8hoGnTUKSflaY3OgxMRU2uNTavPPLr56Lb?=
 =?us-ascii?Q?E/U/tvuU8o9R7nQ2/FLBXWytgxpc8SNsspovdkWdg8HH4z3mg50Yy9SycAih?=
 =?us-ascii?Q?oi5ayKKxkewRnUvakBeB0cKKhs8c++mqI0QOJdltkGxQcl0yFe8CVN33jcCa?=
 =?us-ascii?Q?txO0/m1+HtFCXxmBv6v5kDyLEUhS/93FLD366QEMyawWGg5wGoCzxRrNic8a?=
 =?us-ascii?Q?R/KMnxRezylUbGygd1Ee413Y+mAMKARSBqnTU0lhjPA+fp+MfNiim0t9Dl1E?=
 =?us-ascii?Q?rWC6GgnAyHHY1J3KgFAABSXGEU6dyTeDeHbeSaGNriPI/aAjfuH7DCBXHflK?=
 =?us-ascii?Q?67E41o9O9jUwhEMM58wtZJvGk9nEfEgwN1/iYeIbPRHSpumBSeNpa0um5l5s?=
 =?us-ascii?Q?NkXAldnxvU6U7BLP9RThpe0Voq4ZoEW2UoYZR642FfUtuqHImY6FrPr7CMRT?=
 =?us-ascii?Q?/OF7qMUnBn+KFp0AF0aztW5Te6Zt/UQGmiRM16+ijSbXGRIwLmbQRCqhjDLw?=
 =?us-ascii?Q?so3lFX4dKSrh13VScL0nbUldIpyN2IRRBTUI8e3nT4XQ6GCMwad2J2HxtZ7f?=
 =?us-ascii?Q?XVbJEyqviOv2Nn2C9L9NQqBxWo+gjV6j8YhvVbGTM7LcSsoJ/3EamV9epFwl?=
 =?us-ascii?Q?AZKawWAqxzDD3ilYNDmBrsQwPP14ygc+Am4KuA8/MP6Xhp/oHq2OpJrB7Xq/?=
 =?us-ascii?Q?cyfuMUdA5qsv9PfgPJuNyRtsLTzvTPsReOT2cUKyIvc6QUHPWXLdrlOOf2k1?=
 =?us-ascii?Q?qWL4Cy5YYuUGcz80YW4v7TFcpBLmzdploYdvNe1YNqWV0vbzJdutMy1cTPtU?=
 =?us-ascii?Q?qfGXTOBwwrQDRLHnbVNS6qfxR6FsZsNxw7xsmgBVXEQDmglleZyB/LQ6OSYF?=
 =?us-ascii?Q?TNeCTaGI6l54nfhxQ8KGZugyF1pGwoTNmi1ZWhM84vf9hmJ3VRLgtz/lhJbu?=
 =?us-ascii?Q?kD13ewjPyojd4J1IVszf21ub6wtyfLRfskl8w3CV0iUg2VkLIHJjOk22ugQn?=
 =?us-ascii?Q?dWW0GXld9Q9QKu3gC7x760TsNG2G31AGVUtRJGtqWvkkudqASNfZcDLM0Cq4?=
 =?us-ascii?Q?pcSkjESoxuKCJ3DXQDjTo8AtDJVDnG/XSxOqupVXSrN0JD1eQOyOwhwPiSQv?=
 =?us-ascii?Q?zmAg6Ic2AdunEFDz6qhZSKvdLJDd/AZLyRVamU0js+sUDYg1OEqfOrxT7jSL?=
 =?us-ascii?Q?AESSd58C+MrSK+kKaeaEnQKIqy/2eRCVaUA1lsTAoMpieuW6Wic3NTuOkZpE?=
 =?us-ascii?Q?psZnu6uwuiTtmoGeOfmLo4ccGWLwOxTeEZrURUBpvhyK0r9r/352VFZaSKg1?=
 =?us-ascii?Q?oWYkvfkSiBycEmPvT9UN0+wH6GJWwQVKfT++gOhR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5e67c6-2bf6-4a0d-b79c-08db31324398
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 15:20:15.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cwIkZY+zYF7hyq7sexEI1obr8rAXMorRNrc2QXZwWFQMLy1+i/XHqY8qLgu709/6VcCMM7aanC2EHbbIavb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6806
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >Further shrinking the srcu_struct structure is eased by requiring=20
> >that in-module srcu_struct structures rely more heavily on static=20
> >initialization.  In particular, this preserves the property that a=20
> >module-load-time srcu_struct initialization can fail only due to=20
> >memory-allocation failure of the per-CPU srcu_data structures.
> >It might also slightly improve robustness by keeping the number of=20
> >memory allocations that must succeed down percpu_alloc() call.
> >
> >This is in preparation for splitting an srcu_usage structure out of=20
> >the srcu_struct structure.
> >
> >[ paulmck: Fold in qiang1.zhang@intel.com feedback. ]
> >
> >Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >Cc: Christoph Hellwig <hch@lst.de>
> >---
> > include/linux/srcutree.h | 19 ++++++++++++++-----
> > kernel/rcu/srcutree.c    | 19 +++++++++++++------
> > 2 files changed, 27 insertions(+), 11 deletions(-)
> >
> >diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h=20
> >index ac8af12f93b3..428480152375 100644
> >--- a/include/linux/srcutree.h
> >+++ b/include/linux/srcutree.h
> >@@ -121,15 +121,24 @@ struct srcu_struct {
> > #define SRCU_STATE_SCAN1	1
> > #define SRCU_STATE_SCAN2	2
> >=20
> >-#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
> >-{												\
> >-	.sda =3D &pcpu_name,									\
> >+#define __SRCU_STRUCT_INIT_COMMON(name)								\
> > 	.lock =3D __SPIN_LOCK_UNLOCKED(name.lock),						\
> > 	.srcu_gp_seq_needed =3D -1UL,								\
> > 	.work =3D __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
> >-	__SRCU_DEP_MAP_INIT(name)								\
> >+	__SRCU_DEP_MAP_INIT(name)
> >+
> >+#define __SRCU_STRUCT_INIT_MODULE(name)								\
> >+{												\
> >+	__SRCU_STRUCT_INIT_COMMON(name)								\
> > }
> >=20
> >+#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
> >+{												\
> >+	.sda =3D &pcpu_name,									\
> >+	__SRCU_STRUCT_INIT_COMMON(name)								\
> >+}
> >+
> >+
> > /*
> >  * Define and initialize a srcu struct at build time.
> >  * Do -not- call init_srcu_struct() nor cleanup_srcu_struct() on it.
> >@@ -151,7 +160,7 @@ struct srcu_struct {
> >  */
> > #ifdef MODULE
> > # define __DEFINE_SRCU(name, is_static)								\
> >-	is_static struct srcu_struct name;							\
> >+	is_static struct srcu_struct name =3D __SRCU_STRUCT_INIT_MODULE(name);=
			\
> > 	extern struct srcu_struct * const __srcu_struct_##name;					\
> > 	struct srcu_struct * const __srcu_struct_##name						\
> > 		__section("___srcu_struct_ptrs") =3D &name diff --git=20
> >a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index=20
> >cd46fe063e50..7a6d9452a5d0 100644
> >--- a/kernel/rcu/srcutree.c
> >+++ b/kernel/rcu/srcutree.c
> >@@ -1895,13 +1895,14 @@ void __init srcu_init(void)  static int=20
> >srcu_module_coming(struct module *mod)  {
> > 	int i;
> >+	struct srcu_struct *ssp;
> > 	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> >-	int ret;
> >=20
> > 	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> >-		ret =3D init_srcu_struct(*(sspp++));
> >-		if (WARN_ON_ONCE(ret))
> >-			return ret;
> >+		ssp =3D *(sspp++);
> >+		ssp->sda =3D alloc_percpu(struct srcu_data);
> >+		if (WARN_ON_ONCE(!ssp->sda))
> >+			return -ENOMEM;
> > 	}
> > 	return 0;
> > }
> >@@ -1910,10 +1911,16 @@ static int srcu_module_coming(struct module=20
> >*mod)  static void srcu_module_going(struct module *mod)  {
> > 	int i;
> >+	struct srcu_struct *ssp;
> > 	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> >=20
> >-	for (i =3D 0; i < mod->num_srcu_structs; i++)
> >-		cleanup_srcu_struct(*(sspp++));
> >+	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> >+		ssp =3D *(sspp++);
> >+		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_neede=
d)) &&
> >+		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
> >+				cleanup_srcu_struct(ssp);
> >+		free_percpu(ssp->sda);
>=20
>=20
> Hi Paul
>=20
> About 037b80b8865fb ("srcu: Check for readers at module-exit time ")
>=20
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1911,7 +1911,8 @@ static void srcu_module_going(struct module *mod)
>                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_=
gp_seq_needed)) &&
>                     !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
>                         cleanup_srcu_struct(ssp);


The srcu_sup->sda_is_static is true, in cleanup_srcu_struct(), the ssp->sda=
 can not be freed.


> -               free_percpu(ssp->sda);
> +               else if (!WARN_ON(srcu_readers_active(ssp)))
> +                       free_percpu(ssp->sda);
>=20
> Should the else statement be removed?  like this:
>=20
> if (!WARN_ON(srcu_readers_active(ssp)))
> 	free_percpu(ssp->sda);
>
>Mightn't that cause us to double-free ssp->sda?  Once in free_percpu(),=20
>and before that in cleanup_srcu_struct()?


how about this? any thought?

--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1937,7 +1937,7 @@ static void srcu_module_going(struct module *mod)
                if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp=
_seq_needed)) &&
                    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
                        cleanup_srcu_struct(ssp);
-               else if (!WARN_ON(srcu_readers_active(ssp)))
+               if (!WARN_ON(srcu_readers_active(ssp)))
                        free_percpu(ssp->sda);
        }
 }

Thanks
Zqiang

>
>							Thanx, Paul
>
> Thanks
> Zqiang
>=20
>=20
> >+	}
> > }
> >=20
> > /* Handle one module, either coming or going. */
> >--
> >2.40.0.rc2
> >
