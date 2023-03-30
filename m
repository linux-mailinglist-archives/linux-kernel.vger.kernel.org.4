Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7136CF9FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjC3ELa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC3EL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:11:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0535245;
        Wed, 29 Mar 2023 21:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680149486; x=1711685486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G6IUuioYsV1JPXdcASMZ0gkaXuP346Rj2tvhf4UJB+M=;
  b=Hpmx3S+8o/VVthBJZ5LKgahY4PFR7VUmxRFU6lgGM04dzUtwyrbtHHpy
   rLvUF37VUB2QpbH27S3CgYzzqV5h1plBal9FPXLPMLdT4vZKSJv/WAAFz
   NDgXhBrCXkIpANYOM0x+SPIYay/5PgjHknWGGBAojM0UO2K88+VStAIKE
   gaUxhO9P8u+zSh8XeuSWQtArsw836OvZ/nWcEQpLx//mOxTOd2aRdcjmx
   facOo+PwivNOTVO+N9hHaXH095SMohZ1JCGNtfsofpmh2XfVyILZ61tDm
   QlHUPVD5QFDYqSfXyFDUlcYdutlxsflJC8Mhng0YUpw3ErHSnhGTRdy4/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427340873"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="427340873"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 21:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="930580692"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="930580692"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 29 Mar 2023 21:11:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 21:11:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 21:11:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 21:11:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 21:11:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMyNm3MYST9CGQNmNtp7E3HfB+HsoKksgkWG7bmvLT7sJLbw261GyQseV7BVWCAQJJImedUb2nB4XNguu1GwCd8rie5KcWEIx/Z60A1n1mXdKfM6grYfS9WLu3WYIXo19UC8dHZDeeB84b6K7uw5gVdmwdWtLEz1/wXSidpx/mdFWR+MqOjzQHyLQVzxTpOBiExx+7c3LaDw+IiPST5K4TsP9xLKU+jNXAY6cELQZ+Uf4mswhCiF3+HrO9T5DaDLmL23MrPoypS+bFB3RQw7+cwXftTozvnkVcuH0IXy5Mm9WTsiXQr3kb3igg2svD57RNSGlahB06WTlfaDcH5ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYbk6ZqMllAvjiSNmWu4uWU1gPFdNeGbF8360S/3WHY=;
 b=QI4tTuDEjG0iD5ROlJCylPwmd7baYRjsISul9gDZRA8J7590czorvwkFRHBTW4cnMQPVsd7k4dEvMFyyV88ZN3qZw8kWPrx5BsmeruleNtQCsJPIbZLdyXfFtMhA1G2q2D7SGdg4rsJ8mJOmfIhWaSkStv5BUBn0Re2E3h+T8fFD3MrIQ/1qDxj2CyE2f8n1uXl3eMn/y+NZN7qm8oGOQaFn6IIvjUhUV50282WC1kON0Cz+yvF7MRioYx6tg/ZZlNfCtB4lPmOhrlykvmR7AccFyGxgvnljrHouFWiKVxMXqVRdUYKBX98VyUhZP7Fl5eH0rIG/lCLw5zwt4zWiLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 04:11:06 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 04:11:05 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hch@lst.de" <hch@lst.de>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: RE: [PATCH RFC rcu 02/19] srcu: Use static init for statically
 allocated in-module srcu_struct
Thread-Topic: [PATCH RFC rcu 02/19] srcu: Use static init for statically
 allocated in-module srcu_struct
Thread-Index: AQHZXeZkMjCksJUJIEigTtRmvPjKta8SunIg
Date:   Thu, 30 Mar 2023 04:11:05 +0000
Message-ID: <PH0PR11MB5880CA682074874FF64B3412DA8E9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
 <20230324001938.3443499-2-paulmck@kernel.org>
In-Reply-To: <20230324001938.3443499-2-paulmck@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH7PR11MB6858:EE_
x-ms-office365-filtering-correlation-id: 66bfffa7-47ee-4ce3-016c-08db30d4c86b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vf9Sk1mY4iuND7VJ4FUB1MiEnKZBhwq/Ws3nGzLzxwQQzccWvBEN8wDlDio426V4Hfc457ZDnSKdBFq601pCgnIR6R3+RjfXxs8a5evCgC2ACYLngJPEBjA62jdvOloclCEDTMXj8Fif3BDnVvMVOC8+tmWZGGZvVgTT9IB+SE9jcjXxOBK4s0yV8BYMaHDJZGAfsWSKm/R7M79zFY1nqKMYGOiWkjIAmf4R4JlCAW/+yWJfIzg7d/zZAf0LCz7m+Uotky0F8DVS1KtWnVpC6+dapIfqL3FUhLSNpmfitoodkjjOpVk/VhnT5PNkMRWkyARhV/8tgJI1HHt28Z7dd+Z3fTinRB/eIjTi2L/J+HtM92d4Tzhjuou4EbdAmqFjLg6DVvEzmEWnYCzbrcIthgXyzw7FvAI2DbiPlz2JmCJ+fJZlHhjW6ZULoZI244RnauB1r7PFweyxL7wd6Llx+6Jsy4g3JKoJV9jIwQKP67pJrgF3CnxG9A7jcE9c4ngnUJ7o69IcjQl4fd4uNShR9lu1qDcywatQiSr+OZEfiO1QhKU+NF9tFQHjIMgCoVnZXosMG2hp/WT/hIPc3Q/i7aBc1wM/LdwixUue07Zk/OfBmT0YvUc50pMN0+PVS0K9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(71200400001)(7696005)(478600001)(26005)(6506007)(316002)(110136005)(54906003)(76116006)(186003)(66446008)(66946007)(83380400001)(66476007)(64756008)(8676002)(66556008)(9686003)(122000001)(4326008)(38100700002)(52536014)(41300700001)(5660300002)(2906002)(8936002)(82960400001)(38070700005)(55016003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ryG2qxpvsZJw296xWorNDkTKQNAeJVYG60iMiKfivIulm7k2vtAZLHAa68ho?=
 =?us-ascii?Q?BujVl/8cLC1Cwyu6QSbstQgC0nKWn6RP1fZMvWFBSpYeB7g2wVaVIq3bSLdq?=
 =?us-ascii?Q?7sFX+4OukBqf3TM795+vH51eiMMUQxsHvIhpAt5dLbPZ8P0K1t163jt9UK8g?=
 =?us-ascii?Q?XfoPLk812Rb0IiXZPht5eQfhFVgLC09FBUFQFWG7cmygLRZz54f+oprEuGbc?=
 =?us-ascii?Q?Ccy8LdAOpOaUzKYunEqtMldUIAy/lzyiVKx+sz+Q5LQt/aurLwNNqNmtiEge?=
 =?us-ascii?Q?XMVW0vuw8/BiZe7gP/TskHFhGlhH2AG4nBAzf1cy8hYg3x7vLi1Ux+bE3ple?=
 =?us-ascii?Q?N85zS0ncZ866GnMRpwKVEYcrGoUp72rJYX0oOGDaKbympdlvri6MUl1ibBqH?=
 =?us-ascii?Q?WCK/ElqiKWH4h21hfT+uY5FkX4E3RM7IEHF077tC34IssI3TYJ4Febd3YPnW?=
 =?us-ascii?Q?GAAK2+dRuAhQI9F38Pl6DsQ2wLDqzkSi1GT+nS/R1F+wyPhhUfzDCuwkWsrv?=
 =?us-ascii?Q?skn0pWZVJF7Vxnt9Orac/pL6iDl1RBur2dtXaFuETRQiwSvKdWNxsEfBEsKq?=
 =?us-ascii?Q?n/Ar7M5OWkHSdo/MyC70bw1JmaVmDCi6eTEcMHjDvSxuAWj8TqJVGzWPvMZ+?=
 =?us-ascii?Q?wWC6YfpQzm7HL42dxSoivUjvJjpM0OAp1I+VLAau2+UTNf8AGYC/ZaZ8JpUw?=
 =?us-ascii?Q?v7PnXZA4Q6dh1xIUKZDQDDdteSSNpowW17LOayLnwPgu1upT+qGe3TYEivXs?=
 =?us-ascii?Q?a/cUxYgXZyqx/4DeClyurW11AXR9Sj7e2X5wJdqhOGZDMo0fCu9IVdTBdzWD?=
 =?us-ascii?Q?30Q9RUBbmV4zicFrgFcJlsHoZjAQzrquPBGXqcDLwU93NPbJyzpDX7YBWc71?=
 =?us-ascii?Q?+Mkd76cWdC9Zn037ZiaoYUZYIT8hsawosihCNJlm21jUtMerFVgMJphxxEQB?=
 =?us-ascii?Q?AxIoBQinztkVcdbdIoDIhShESSl8fZXlJOGlVZIQ5SzypkF9dZBjEXKIFLf5?=
 =?us-ascii?Q?eZYLTYdwS4R0FBgTlrpdv5eqrA0PTSM7CaRpRuFqhF4YlQ9AksreflV2ozyb?=
 =?us-ascii?Q?VFYdPN51Cf3sXcYCGXZkJuTRlTXS3pcT7jAH3h3G7QOed/1IuzKN8NwERbuw?=
 =?us-ascii?Q?JtnXwVPdjBOcoJj5lqPVPsTZ0of4CBMBP7uMfeSL7MvdznzRu1ElxA814ck3?=
 =?us-ascii?Q?R8FiBx2e+Nfv6thoWK8gIFWxLuO1H1DqjBsTcd8B0YufwQGin15Fjp9Xi4rL?=
 =?us-ascii?Q?T4sOwis5ZHHXIIeRH0uS4V8M+Cq7KNf2Y+nqVu3C/TFC16xMHERpuN/PxY/o?=
 =?us-ascii?Q?ZslJzfxa+Vl3bB+lKqkoJwm0ufYH4XPDwa3+nGe0RsqNiixCqGv7hK8/dzKe?=
 =?us-ascii?Q?toN1P2H1wDAJmIT0LCu52swXhWOG8D3fWVV99vClNbQl0yPn8+nWanNMvvd5?=
 =?us-ascii?Q?PUNltGRbKf8obxy+aUS0yiJU1LkSYic7y6WBjkceNb67R4gRPPN00IY59UF4?=
 =?us-ascii?Q?j/8xvsO1K//C0Z5M8QVtyqkUSY379EWcYP5KSv47kPUVoC34+yXCREiuAVSj?=
 =?us-ascii?Q?oaP1hNTItG64yNBEWf8yuIg4i0nxC5BRowXXOa52?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bfffa7-47ee-4ce3-016c-08db30d4c86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 04:11:05.6225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWJqw22MvBqrhZEt5Wwo0R8EB7ofiFxdBsd01hk7Rc65EbE5060bJUQ25VBFoTFNhAcAQ+xxL2urwoZnsZ8foQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Further shrinking the srcu_struct structure is eased by requiring
>that in-module srcu_struct structures rely more heavily on static
>initialization.  In particular, this preserves the property that
>a module-load-time srcu_struct initialization can fail only due
>to memory-allocation failure of the per-CPU srcu_data structures.
>It might also slightly improve robustness by keeping the number of memory
>allocations that must succeed down percpu_alloc() call.
>
>This is in preparation for splitting an srcu_usage structure out
>of the srcu_struct structure.
>
>[ paulmck: Fold in qiang1.zhang@intel.com feedback. ]
>
>Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>Cc: Christoph Hellwig <hch@lst.de>
>---
> include/linux/srcutree.h | 19 ++++++++++++++-----
> kernel/rcu/srcutree.c    | 19 +++++++++++++------
> 2 files changed, 27 insertions(+), 11 deletions(-)
>
>diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
>index ac8af12f93b3..428480152375 100644
>--- a/include/linux/srcutree.h
>+++ b/include/linux/srcutree.h
>@@ -121,15 +121,24 @@ struct srcu_struct {
> #define SRCU_STATE_SCAN1	1
> #define SRCU_STATE_SCAN2	2
>=20
>-#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
>-{												\
>-	.sda =3D &pcpu_name,									\
>+#define __SRCU_STRUCT_INIT_COMMON(name)								\
> 	.lock =3D __SPIN_LOCK_UNLOCKED(name.lock),						\
> 	.srcu_gp_seq_needed =3D -1UL,								\
> 	.work =3D __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
>-	__SRCU_DEP_MAP_INIT(name)								\
>+	__SRCU_DEP_MAP_INIT(name)
>+
>+#define __SRCU_STRUCT_INIT_MODULE(name)								\
>+{												\
>+	__SRCU_STRUCT_INIT_COMMON(name)								\
> }
>=20
>+#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
>+{												\
>+	.sda =3D &pcpu_name,									\
>+	__SRCU_STRUCT_INIT_COMMON(name)								\
>+}
>+
>+
> /*
>  * Define and initialize a srcu struct at build time.
>  * Do -not- call init_srcu_struct() nor cleanup_srcu_struct() on it.
>@@ -151,7 +160,7 @@ struct srcu_struct {
>  */
> #ifdef MODULE
> # define __DEFINE_SRCU(name, is_static)								\
>-	is_static struct srcu_struct name;							\
>+	is_static struct srcu_struct name =3D __SRCU_STRUCT_INIT_MODULE(name);		=
	\
> 	extern struct srcu_struct * const __srcu_struct_##name;					\
> 	struct srcu_struct * const __srcu_struct_##name						\
> 		__section("___srcu_struct_ptrs") =3D &name
>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>index cd46fe063e50..7a6d9452a5d0 100644
>--- a/kernel/rcu/srcutree.c
>+++ b/kernel/rcu/srcutree.c
>@@ -1895,13 +1895,14 @@ void __init srcu_init(void)
> static int srcu_module_coming(struct module *mod)
> {
> 	int i;
>+	struct srcu_struct *ssp;
> 	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
>-	int ret;
>=20
> 	for (i =3D 0; i < mod->num_srcu_structs; i++) {
>-		ret =3D init_srcu_struct(*(sspp++));
>-		if (WARN_ON_ONCE(ret))
>-			return ret;
>+		ssp =3D *(sspp++);
>+		ssp->sda =3D alloc_percpu(struct srcu_data);
>+		if (WARN_ON_ONCE(!ssp->sda))
>+			return -ENOMEM;
> 	}
> 	return 0;
> }
>@@ -1910,10 +1911,16 @@ static int srcu_module_coming(struct module *mod)
> static void srcu_module_going(struct module *mod)
> {
> 	int i;
>+	struct srcu_struct *ssp;
> 	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
>=20
>-	for (i =3D 0; i < mod->num_srcu_structs; i++)
>-		cleanup_srcu_struct(*(sspp++));
>+	for (i =3D 0; i < mod->num_srcu_structs; i++) {
>+		ssp =3D *(sspp++);
>+		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)=
) &&
>+		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
>+				cleanup_srcu_struct(ssp);
>+		free_percpu(ssp->sda);


Hi Paul

About 037b80b8865fb ("srcu: Check for readers at module-exit time ")

--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1911,7 +1911,8 @@ static void srcu_module_going(struct module *mod)
                if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp=
_seq_needed)) &&
                    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
                        cleanup_srcu_struct(ssp);
-               free_percpu(ssp->sda);
+               else if (!WARN_ON(srcu_readers_active(ssp)))
+                       free_percpu(ssp->sda);

Should the else statement be removed?  like this:

if (!WARN_ON(srcu_readers_active(ssp)))
	free_percpu(ssp->sda);

Thanks
Zqiang


>+	}
> }
>=20
> /* Handle one module, either coming or going. */
>--=20
>2.40.0.rc2
>
