Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262A86D0912
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjC3PGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjC3PGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:06:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D089AC177;
        Thu, 30 Mar 2023 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680188791; x=1711724791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rfKeQjvyn8N2YTCFOkndJE6Sd7mjB//UW9R1B4NqpO0=;
  b=X3ouvyC97dsiMYIid3y7oZoLisYuM80Fr3x1potMXTCPGtNetSLx8rcc
   i/NkTNs79YWlC5b6OkcQIsFYqblFpKjP29xCqtskYlqcOLJmSSb8cTerq
   GpJlyHqfuUb9yNJERBlLk1iXCdGCs2S9QOn8XNoE7mWGKAgIyfcSGQN2B
   iXPq5NNMf4b/77fNOL+70kONtzPlijsnDsb+xre8Hu4Wyz6KTabZnyMTZ
   B0H7Blr8OerH2xnskn/frexHght4meyut55BijApNXLGYsa/9Olun2fYA
   FKAtBhTYj4DlKk4w5CWJa/XCoJZdtIfdNFWhcz9SNoo3gRDW945BYPz9z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="341207647"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="341207647"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 08:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="774027109"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="774027109"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2023 08:03:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 08:03:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 08:03:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 08:03:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 08:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFNQmHwNBnurNvtajiFCWK8Ar96lfrZ2vET+SKMnl3h4j8V0YUFPOlSuof6gQGwGHWZd/zNxtm4RN+ecAGvMnKWhju7h7yPVpLcp0iuOAFyYzuPvM62OgybxvirnaQfW5HJ5//RuJv5OJw+DFqKXIhdy7rktoE1yt0CXQwkNNWDD90LTgnGof5TxgTaS+MHQ/LEpQs9fc68rf3vlQrQsgjqrNAMa2n7nzr3ONok3HnP0Hq330bNitVj7xMcui8apUjkFVT9p7dFtZ6+14aeVzDzSReAEk8ORAaepAOrQjj/tsMUBuatEteXZVgkSpQBKvhTulO2oH0SkEgou5gyCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b2qN9zYaGGq2G3EtlEheFti5U6XR9FjaSiy/sdVMUg=;
 b=LSwdNP67XOpL1k6aAZKpTBSJO8m2dQMR+PL3z4NcCHCD3T+45aYTWZhqugz6YXVEvCE7WdfBOogKDyWRzabIn3SWFdujTVJhY8dH9g5I0sbeM9bXtxeJM0PXhiI3aUkclls711DSpYHg0H8xFpHJGTuhdhdrDK7elsBD18COyayNKe8Ufn3TckKVYk6MS1D7IFgd8+AtxslfjFfq4gtechIYFys9nUfmcfjrBEcwMMArM6EBBk5rXzLUA15DvB/PcTVbNoT95KWF/rMxpOWoYcWZZFTNEPaWlqsIZbAPwI13if9AfbF4qt9Q3BfCJlaM/QsZvrrLxhM+qkiSe40H1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 15:03:51 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 15:03:50 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
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
Thread-Index: AQHZXeZkMjCksJUJIEigTtRmvPjKta8SunIggAC5AYCAAAGhAA==
Date:   Thu, 30 Mar 2023 15:03:50 +0000
Message-ID: <PH0PR11MB58807EB1C375AE03F8586C92DA8E9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
 <20230324001938.3443499-2-paulmck@kernel.org>
 <PH0PR11MB5880CA682074874FF64B3412DA8E9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <b66d52cb-ed73-4c7f-bab0-201dc13d164a@paulmck-laptop>
In-Reply-To: <b66d52cb-ed73-4c7f-bab0-201dc13d164a@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SN7PR11MB7511:EE_
x-ms-office365-filtering-correlation-id: b73d077e-cc19-4fea-5c12-08db312ff8b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUkOLUWauUlCZ5jrm6DFugmkZgWSJqjszQn5RHN1KCtnw3xUYbzVYDRG2JUB8F55BG6alo6SATwaNkb7suOnIlVSB/9oGAKSXmzB2+s+uRpjPYtT/FBA+L6akwKq0aj4gjMZ1GO2eDYllkUDuZ7y6WQ5ZZEo7lvlf6a9fzxalqfn+6d2kA7oXjixSSzVwbXSElUPOTobg3Xh5Yn/FIIJwpUZtKKyiD5RrqNceym6ej+820pLaUbFiisLH5JiKLriNLDl2MTQQGBz5ZD6GZ6NsIPT+pTY+uJYsZZ1CmVGPr+RFU8m/VhTAyaATnKd11Hy+MTWpHdbrvsW4+pGwYZKUkB5oWQ98hAzOob82xWFs73s8N2qLtZiLwOt6g7K863zVWrqBwnQCxlkcUSmiBYUiZqi8yrCGJnBbauSCZPg0aYnXqYwC4CNc42kfIqRmwTnBkvG6chCBfA8Mw1jfKL410JFz28VKqnHnjsgNBbg3iDLNg4eHLbL4+SgJmgbJTaOeaeAtWxx4+/cqudaoYV11CikKf8ReV8I+f/2jZgG/tnbCzSHuoUHT8zBmq6K39blUc5Itzr/oSTILSk7LoXS8rJBJn0qBOUgo8UUCu968JcPu28U42I9Xsu16LN5k/G3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(52536014)(83380400001)(26005)(122000001)(186003)(86362001)(6506007)(9686003)(82960400001)(5660300002)(38100700002)(38070700005)(41300700001)(8936002)(8676002)(66476007)(7696005)(33656002)(71200400001)(478600001)(55016003)(76116006)(64756008)(66556008)(66446008)(6916009)(316002)(4326008)(54906003)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZLr/aEwhmIorCb3TVqZQQk+Rate/dtxoTXfcyvrq2/XpqyltA9PWr/OTIdAb?=
 =?us-ascii?Q?du43O4WUf2sTJQUaD/6aEbup3iT8w8GkP5xnld3ha3rdROFiePXpotajZ/Q1?=
 =?us-ascii?Q?S6CLPnrXyFPqWRx+ClCJian0CV7p29VRq+Uh8h4H13fMbCrExZsizjMIe+oa?=
 =?us-ascii?Q?vPu3XOxZS2sNgvMCBta7i8P+YXSzbs4FdcfO8kjSUfphSn6KjI9XBiLKKB3x?=
 =?us-ascii?Q?Awu5/A4R0sHLW6OEJwka6jdzRaipSJNFKIGt3f5Vx/a5xIXc0wD8RsKBhLe/?=
 =?us-ascii?Q?YDbCclyMps5h9knBNZUqnmGoX7dqgK6mbRp2EPK0xHB51Uj7+bBFbwGZikfv?=
 =?us-ascii?Q?Knd8ZRqZcC2tjje+3p1RjtKySo/6hTsuokz1UdyDeZV9l5lPjddZQwtQuieT?=
 =?us-ascii?Q?1Q2NREoj1iC8dsJeKenqG0EmRychECJBjwtvTcUPwbQOG4If7pymj8Yi/pap?=
 =?us-ascii?Q?TNq9xHzMnx7u0zijYVuFIKE96UeN0CvREhQVFGh4ToJIKwYuuu80ex86yZyP?=
 =?us-ascii?Q?bvqF8f6IW0fWw5o4c3JZEVOBG91YEiSCBZsfyBs1AYhdektM+sZmeBZTwhH6?=
 =?us-ascii?Q?bmxWP+ddREvCoISJNb76qJghHZuFFXmO5iZYoAoF1OwIlaHeVfVFKvFVepfu?=
 =?us-ascii?Q?LGw+fJmZtzLslyGzAm1G+NnN0mTA7AQxE88u21H2CJUIM53kTVPREpDaT3gl?=
 =?us-ascii?Q?STZdCXEZ8xNEqyQcf7Xkpr9+mxYh0OzYRA50kmUmM/r53qxfIGBVgLM5Re0W?=
 =?us-ascii?Q?R4Q8z1F6k1xRdwfaI/df9L2wd7t6jNr2FJMr5pG6ss8iwmcDnDJodU/nJ0R+?=
 =?us-ascii?Q?XdwGIlmCKunM23bGtibD/+vH1MhH/BL/TcXayoH/SlVyeKO9s1tMEuJXfXD+?=
 =?us-ascii?Q?dnVOTDe7p1lStRsYWw5SML4+mdlTQ4mXN1w8HI51AgZva9Q4Cj4NXjoJLQaB?=
 =?us-ascii?Q?h5FDpuqJ6/xI+pyulN9YEeMVl2OkWK67+9UkAjEL0jmhqPdcEdZGsBMyJsfN?=
 =?us-ascii?Q?KL7gF9tPrBnJMtC6BDQkXmtFayyUW84199qeR6zjAan/9SlUEIrfmMyrhjMg?=
 =?us-ascii?Q?Qp7zbluyfq5OkYofNC3swFarL6cdzHvUoPmfs4FxFi6I0+wdAVJ83Et0RUZf?=
 =?us-ascii?Q?IpKzAINrGkxpq5ILYSidxoxtxUXiz3OKztP1+X4V2z0zVX/vF0+stilqQCZb?=
 =?us-ascii?Q?DuzLWsEgG2Uwf6fXJvNaQXfbaDH/Bk4I5m4T9P0xNG7D1eMq17h4tc02KSze?=
 =?us-ascii?Q?mT3etvfybo7RVKfZmenc6TvTzZ+vSY6L1TfSMtJ/VSVsKPRePjF/BIAzKNFt?=
 =?us-ascii?Q?d9ENxZiImt6Jng/xh/6Rc4Znd+Vh+pOntZZrH+GR48EoXdm84X5L0/Ddtwqg?=
 =?us-ascii?Q?7adgJWIddj0t623gQ5W3pEN26+ZqLc0px+fYT+Dz8d/EDHyVttPyovVUyiPY?=
 =?us-ascii?Q?R5L3F5HEa0gLjsMB64EpMYnR2JYKeMprsGN/1t6czcOcVcE1PEVSXNi/l8ia?=
 =?us-ascii?Q?GpNctdfdqFKPUHvlg4+rrGSPxqFRe/mFnEDHCQupQ1O7xM8HKU9LTCAcagGZ?=
 =?us-ascii?Q?hkzkFXrxBrjLA8Wuolgih66OxHn1bwto7Kl8GZtV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73d077e-cc19-4fea-5c12-08db312ff8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 15:03:50.8269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlza55QJg9y72RifoUtqi4q2hpN8WiNis6s3ry80NaQDng8nJEK2xbtAd2Ro1WEVZmWQWYlUS5/HvFPnG0aZzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >Further shrinking the srcu_struct structure is eased by requiring
> >that in-module srcu_struct structures rely more heavily on static
> >initialization.  In particular, this preserves the property that
> >a module-load-time srcu_struct initialization can fail only due
> >to memory-allocation failure of the per-CPU srcu_data structures.
> >It might also slightly improve robustness by keeping the number of memor=
y
> >allocations that must succeed down percpu_alloc() call.
> >
> >This is in preparation for splitting an srcu_usage structure out
> >of the srcu_struct structure.
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
> >diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
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
> > 		__section("___srcu_struct_ptrs") =3D &name
> >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >index cd46fe063e50..7a6d9452a5d0 100644
> >--- a/kernel/rcu/srcutree.c
> >+++ b/kernel/rcu/srcutree.c
> >@@ -1895,13 +1895,14 @@ void __init srcu_init(void)
> > static int srcu_module_coming(struct module *mod)
> > {
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
> >@@ -1910,10 +1911,16 @@ static int srcu_module_coming(struct module *mod=
)
> > static void srcu_module_going(struct module *mod)
> > {
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
>Mightn't that cause us to double-free ssp->sda?  Once in free_percpu(),
>and before that in cleanup_srcu_struct()?

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
> >--=20
> >2.40.0.rc2
> >
