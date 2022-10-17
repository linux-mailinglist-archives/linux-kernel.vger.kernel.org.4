Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3987E600AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJQJc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJQJcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:32:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9BB41D03;
        Mon, 17 Oct 2022 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665999143; x=1697535143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZCA/a0w/nHj25c0aQ0x+mpOBkfDBxgkZIDxNgNFB3v0=;
  b=I8ecqm4J2HstZpORKJdVYc6MuogZYKn+MRk4KED/eAAJaIW8e3GG7Kvi
   avdEVyU580Z3kl7jimeLIQarin+rfxbjhDnQoh2LUaZVSNw7zcypnogvU
   SUp0mV3+X5uQLN/3SH2AFOFGY1XKmP4iBpu3kLM1R8M8egRhZp8LNlC6s
   IN73K39l4wk3EuEfj6pz5EoAzm9/2iOGTHEjbpTVo8MTGG2lLrx3SGEvi
   +atswpfUgYYFfUpQVLq9QCkQ/OlkM3hKOpk/V+qFErhw2P5Kh9Qb200QW
   xq4wBlgb3ZMt0eZWnrTwgw+xoBtTtV2ruexxbmpmyMgz6ZD23dGY0hk9R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305741534"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="305741534"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="717431196"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="717431196"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2022 02:32:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 02:32:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 02:32:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 02:32:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 02:32:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1+A6Q1Kh1Y4xf0j+ihMZJoI86aCce5qCbUHNNkKnT85caL+ZeE+vs0zpkGTBt0r/F5OEveteoDKxKOQYbR3Sb/6/FSbLb0y+IBnHl4O/vEMGDhwbXukJaJK5BV0UvP85pYMh+Jtu30eHrr1NHRjOXOoe8M4GK7f4z8HtvxITL1p9C7ud8/qlEbcj3trkYo8vTiSRJxk26vQS8BAaj8nr817vUaTvPlPJz+BTMZFAs9cnNJQsWT6MAjGnKU3F2/H6UJ0UzstApNMrhDy6Uh/13bRrP3x0bWjCqgp6ZLM7a2PkTbQODsVCQKTsHgAuk5xIKdXJcEY/PBYnI6fJoY3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8M4v6SoPz1Jf455WKLqWI2la+SOV1xMJUsNCzWVvaM=;
 b=i6LhEKe0BvtQJ+Pdk0CNPmwflJKfnnoD5OhZ4xPJ7P9ppT1pqf+brDsBEyTeqmYij9gYHYm+yehs4uMh1GtkfjeLotzipOtDvUfh+MQUSbSjX0JJEzK2Rikt2WfJiHz0najI3hC5q/nDPdR7zTf6pFhr5u0euRPNxHb1ZgdjaCCymnhk5QjM1w5Zn6HfWyF3AEDiRGmef2sZ/7tfJtbOZ12XDi3CAJnpmk/91nOsHF8NeypfY42sfY5WMpvQLB4Z8WcsBvbouHpLIZXXtWPcyOB3x1Gg8MljppIT/yQrrwvVzwmE5jBjpEehCMGLm3OWwDNpHs7mVLbamBfB3ucu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 09:32:19 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0%8]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 09:32:19 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Yu Liao <liaoyu15@huawei.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "liwei (GF)" <liwei391@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: RE: [BUG] possible deadlock in __rcu_irq_enter_check_tick
Thread-Topic: [BUG] possible deadlock in __rcu_irq_enter_check_tick
Thread-Index: AQHY3XRA23Ul8kJaeku0Y9YHsqxYoa4KUo+AgAgEEnA=
Date:   Mon, 17 Oct 2022 09:32:19 +0000
Message-ID: <PH0PR11MB5880A8E6EFE6D57EF44C4A9EDA299@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <e015e32d-d068-2d17-1ca5-c584c30ffebb@huawei.com>
 <20221012064911.GN4221@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221012064911.GN4221@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ0PR11MB5118:EE_
x-ms-office365-filtering-correlation-id: db07241b-5605-4ef4-e1cd-08dab0227cbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yTWA7T3dmtAMhM8Dw4CAgBmOAYwt6oEioVvran13dvEwU11K7O5SBZg1+XCPCeByJaGV+f9+Vuz037IEca+I62F3xSgNNWgpuAqdqVWDBPWw1Dnubs62hghA4Gyo3XODsxI9o7rpxGMcle0uq+luq9ZZPGembrQZJCgipL/i7yIdvV+HBvZuXvdZyzGbQb0ronvg363wi+IyNbka5LLcqqzFPs5GB8vthjPSALdplk7EkmQ+MLMO5F756ff/N4H+QiLRrZgMZSY5Dc1SkTP7pdTtXY+Spj29G9Q+o6tmwvch4hG4yaqd0Up2gXJPDIxks66ZbvJrBhKrLTclJSPUpcvRsQDRlyNxY51NppSddnU3/mNvN8ubzZcwERProV1JoEaEGXfh3haJe19EGFbT63uATKrB876BVInFqcDOGHjvhbikFG+hGGV9KCmmnDKJBIX9F4oNOxQzyjKdEAWDp7W8d9LVrauB4+UoILnbHt4op2C3GSBddyICuHbEtK72r50bSZ57MBtdOP6A9x9jG7aFKUg2Bse1jijWvjfpBIw2o4mtSZQeYNx9OZMVZSJssOnx3DGpUvRTuaEUvC7XaJOMDO0weYWKKps1M4VQXJK87bNC7s1kINGWUuDQbG1D7dugCS6diyqbJwBNukNrTt5h5W/NR5zPs9gktSVPyeN+BkzfYFNgrFRm+hw/EdsB8iE14s4o4DTndKTP5XL0EZ3HM6cxjduvCWxF6VH71npWTDq+cJx5EDcUEeAmlw7hH3p3rrFIMC8NU0vt4cFpdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(316002)(54906003)(110136005)(478600001)(71200400001)(66946007)(66556008)(76116006)(66476007)(66446008)(64756008)(8676002)(4326008)(26005)(41300700001)(7696005)(52536014)(5660300002)(186003)(30864003)(2906002)(8936002)(9686003)(66574015)(6506007)(83380400001)(38100700002)(33656002)(82960400001)(122000001)(55016003)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YgcIPTAba/l5CLF/3NmF1F576cVUvbTiVJrTMxWuoYGF266Ua1zAbtypEP5O?=
 =?us-ascii?Q?djEePBUIyE07pOuhr81Vt/+3sDqz9lLMOUtb8LNxDtx9cynEF8A5SI43JLWo?=
 =?us-ascii?Q?qfaEL8u9TIfVBzXwf6zjkEQJxbNqZkJb4qdXnpJkPwOuiU01RNyiEvDWwhUj?=
 =?us-ascii?Q?M3Eege1abU0Cv4QtpMtNjP91ej041qAy4TmZO4XIUAib3HLlJCGSdT9chWs3?=
 =?us-ascii?Q?vKsZuvPz4lNtAAuzXJzToewenlkiAyIMkh0Z2DEn063tcrsFhVlTposwjMoo?=
 =?us-ascii?Q?3yP7Ps68jq2CNL67+G5cwBdww9dyGB531gClryHEIPnghXtpWTbikCqxelgm?=
 =?us-ascii?Q?wy5dNhSzZONLJbn0JJ02QlF9oYib5/q0FWnZyxJlFz1tZuMrZCE7vvlJ4o/4?=
 =?us-ascii?Q?nDIXTkYl+yrOrucQ3+gAt7kRwwtJxaY2437YpaXtfD9P/ituwrI0CHIno5XH?=
 =?us-ascii?Q?LbqVKD0uGj4TJ4kNe05lStvSXE1TygN7/kLNadCsmFK4Dz1zLfsyFZQEmjpV?=
 =?us-ascii?Q?mr6eg963KCpYcgBIL6J15DdBYJx17OwudmFnC5HdeWDRSFiaKO2+C3RdLhH0?=
 =?us-ascii?Q?AR4w2SA+7BQ157D5pbMueNnBCKpVcR7N3KraDgujwgRKHbgIw64taWTJPEzS?=
 =?us-ascii?Q?rfyHS9vZGJPn+Y7U6CsPC7jamp0PyPLlxhg+/JEq3+PUocNUrlZ3t08kG5F4?=
 =?us-ascii?Q?tmSoEixbGKrVR3A7KTxzuAaQlTqjRugG27tU2rEN6IgXhIwSaQCYH57pmWJk?=
 =?us-ascii?Q?IMT73M/Ruhe76mzaOiEJVmiufsJI4qPrAf8AjPPQmp5gpLR9XI/BK/AasJbA?=
 =?us-ascii?Q?dfJNa8saSQ8BQzvvTM9x68xu7kupvfj+5BVmH5yvD1gX9q2PYl2dnFz/e0dr?=
 =?us-ascii?Q?MuGNVlJhT4QH/Bj2ZKAVQzyXamW/GD4VGc7UwRW4XFdiLjSwRL86Ol+10pdH?=
 =?us-ascii?Q?DvM3ySa/En7BvYe1MPRLGWX4ihNTb9kmOq/GrFKJYu2No6WmRTiSjQdER477?=
 =?us-ascii?Q?9yQ2hUd0UQ6BwXNNr9BO8CBIDc7UutMp2XQ1gzDi202fLB97y61Agtmg1Uhn?=
 =?us-ascii?Q?9rm7fxR8qUy5YViJAFnkTuezXrsy5e6jR1tz9Y6WwHBlHEkLHpg9QElYQQAl?=
 =?us-ascii?Q?WfpjIfg1MvFohP6iEGs3KqS2ZMaMAafEmsIQwcZr4UQXhAQeOKcO4v08/3/y?=
 =?us-ascii?Q?vOcOgCxBqNILd+ZrVNF+Jw1OeMimhTBYCKhHiQAG7KDE1k48/BoziTilLyLM?=
 =?us-ascii?Q?fR/bvEtsaiwEbxL7KGm9ErRnSnAIE/Z5u9cM5lwrZWLRjmdZD9UNpvpUDxqR?=
 =?us-ascii?Q?gXwTdnOXq3hYBnulhWtTzH41NYlpdNM2r74mJdJrDZR8y7pAG5Vdy5FisDB6?=
 =?us-ascii?Q?NNBs7wiAO5SiLlaZm80HNCfUsa/zwD/6JbhEdcLqi6/+0o3vpikfnDW3rZcB?=
 =?us-ascii?Q?mvyzFOtD6YfwHk+jkFcBGkcpMJgy/iuwtsO+il74GFfXYWGWDxOdWDaDtVqH?=
 =?us-ascii?Q?rlh8mHdacr4KQ08XmQeRrjjTCdGvE+qM46lU/4YZMlenj76RP2NNV6ERzxEC?=
 =?us-ascii?Q?mr4qmqkaTDesETiB/wvnFUcJMu2ONnXS+wZoEVRv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db07241b-5605-4ef4-e1cd-08dab0227cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 09:32:19.3916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PVffvGeqWvZl9YnEEd4MigUahbOPXcgLPqviVd2MuAjCSg0gq6iBNB8S8wrtvBn8wYmMcZiimZrnmLkWjH7yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 09:18:11PM +0800, Yu Liao wrote:
> Hello,
>=20
> When I run syzkaller, a deadlock problem occurs. The call stack is as fol=
lows:
> [ 1088.244366][    C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 1088.244838][    C1] WARNING: possible circular locking dependency dete=
cted
> [ 1088.245313][    C1] 5.10.0-04424-ga472e3c833d3 #1 Not tainted
> [ 1088.245745][    C1] --------------------------------------------------=
----
>
>It is quite possible that an unfortunate set of commits were backported
>to v5.10.  Could you please bisect?
>

Hi Yu liao

This looks like the result of the following commit:

commit 2a9b3e6ac69a8bf177d8496a11e749e2dc72fa22
Author: Mark Rutland <mark.rutland@arm.com>
Date:   Mon Nov 30 11:59:50 2020 +0000

    arm64: entry: fix EL1 debug transitions


Is it possible to try the following modification?  maybe Mark have better s=
olution.

--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -259,7 +259,7 @@ static void noinstr el1_inv(struct pt_regs *regs, unsig=
ned long esr)
 static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs)
 {
        regs->lockdep_hardirqs =3D lockdep_hardirqs_enabled();
-
+       __nmi_enter();
        lockdep_hardirqs_off(CALLER_ADDR0);
        rcu_nmi_enter();

@@ -278,6 +278,7 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *=
regs)
        rcu_nmi_exit();
        if (restore)
                lockdep_hardirqs_on(CALLER_ADDR0);
+       __nmi_exit();
 }

Thanks
Zqiang


> [ 1088.246214][    C1] syz-executor.2/932 is trying to acquire lock:
> [ 1088.246628][    C1] ffffa0001440c418 (rcu_node_0){..-.}-{2:2}, at:
> __rcu_irq_enter_check_tick+0x128/0x2f4
> [ 1088.247330][    C1]
> [ 1088.247330][    C1] but task is already holding lock:
> [ 1088.247830][    C1] ffff000224d0c298 (&rq->lock){-.-.}-{2:2}, at:
> try_to_wake_up+0x6e0/0xd40
> [ 1088.248424][    C1]
> [ 1088.248424][    C1] which lock already depends on the new lock.
> [ 1088.248424][    C1]
> [ 1088.249127][    C1]
> [ 1088.249127][    C1] the existing dependency chain (in reverse order) i=
s:
> [ 1088.249726][    C1]
> [ 1088.249726][    C1] -> #1 (&rq->lock){-.-.}-{2:2}:
> [ 1088.250239][    C1]        validate_chain+0x6dc/0xb0c
> [ 1088.250591][    C1]        __lock_acquire+0x498/0x940
> [ 1088.250942][    C1]        lock_acquire+0x228/0x580
> [ 1088.251346][    C1]        _raw_spin_lock_irqsave+0xc0/0x15c
> [ 1088.251758][    C1]        resched_cpu+0x5c/0x110
> [ 1088.252091][    C1]        rcu_implicit_dynticks_qs+0x2b0/0x5d0
> [ 1088.252501][    C1]        force_qs_rnp+0x244/0x39c
> [ 1088.252847][    C1]        rcu_gp_fqs_loop+0x2e4/0x440
> [ 1088.253219][    C1]        rcu_gp_kthread+0x1a4/0x240
> [ 1088.253597][    C1]        kthread+0x20c/0x260
> [ 1088.253963][    C1]        ret_from_fork+0x10/0x18
> [ 1088.254389][    C1]
> [ 1088.254389][    C1] -> #0 (rcu_node_0){..-.}-{2:2}:
> [ 1088.255296][    C1]        check_prev_add+0xe0/0x105c
> [ 1088.256000][    C1]        check_prevs_add+0x1c8/0x3d4
> [ 1088.256693][    C1]        validate_chain+0x6dc/0xb0c
> [ 1088.257372][    C1]        __lock_acquire+0x498/0x940
> [ 1088.257731][    C1]        lock_acquire+0x228/0x580
> [ 1088.258079][    C1]        _raw_spin_lock+0xa0/0x120
> [ 1088.258425][    C1]        __rcu_irq_enter_check_tick+0x128/0x2f4
> [ 1088.258844][    C1]        rcu_nmi_enter+0xc4/0xd0
>
>This is looking like we took an interrupt while holding an rq lock.
>Am I reading this correctly?  If so, that is bad in and of itself.
>
>							Thanx, Paul
>
> [ 1088.259183][    C1]        arm64_enter_el1_dbg+0xb0/0x160
> [ 1088.259623][    C1]        el1_dbg+0x28/0x50
> [ 1088.260011][    C1]        el1_sync_handler+0xf4/0x150
> [ 1088.260481][    C1]        el1_sync+0x74/0x100
> [ 1088.260800][    C1]        update_irq_load_avg+0x5d8/0xaa0
> [ 1088.261194][    C1]        update_rq_clock_task+0xb8/0x2d0
> [ 1088.261595][    C1]        update_rq_clock+0x8c/0x120
> [ 1088.261952][    C1]        try_to_wake_up+0x70c/0xd40
> [ 1088.262305][    C1]        wake_up_process+0x1c/0x24
> [ 1088.262652][    C1]        wakeup_softirqd+0x58/0x64
> [ 1088.263000][    C1]        __do_softirq+0x6b8/0x95c
> [ 1088.263345][    C1]        irq_exit+0x27c/0x2d0
> [ 1088.263674][    C1]        __handle_domain_irq+0x100/0x184
> [ 1088.264049][    C1]        gic_handle_irq+0xc0/0x760
> [ 1088.264394][    C1]        el1_irq+0xb8/0x140
> [ 1088.264709][    C1]        _raw_spin_unlock_irqrestore+0x7c/0x130
> [ 1088.265134][    C1]        __aarch64_insn_write+0xc4/0x100
> [ 1088.265516][    C1]        aarch64_insn_patch_text_nosync+0x40/0xa0
> [ 1088.265942][    C1]        ftrace_make_nop+0x120/0x1a4
> [ 1088.266300][    C1]        __ftrace_replace_code+0xdc/0x160
> [ 1088.266684][    C1]        ftrace_replace_code+0x100/0x1a4
> [ 1088.267063][    C1]        ftrace_modify_all_code+0x1a8/0x260
> [ 1088.267456][    C1]        arch_ftrace_update_code+0x1c/0x2c
> [ 1088.267847][    C1]        ftrace_run_update_code+0x38/0xa4
> [ 1088.268259][    C1]        ftrace_shutdown.part.0+0x2dc/0x550
> [ 1088.268682][    C1]        unregister_ftrace_function+0x74/0xc0
> [ 1088.269117][    C1]        perf_ftrace_event_register+0x130/0x1a0
> [ 1088.269559][    C1]        perf_trace_destroy+0x68/0x9c
> [ 1088.269938][    C1]        tp_perf_event_destroy+0x1c/0x2c
> [ 1088.270340][    C1]        _free_event+0x2f4/0x670
> [ 1088.270696][    C1]        put_event+0x7c/0x90
> [ 1088.271031][    C1]        perf_event_release_kernel+0x3c0/0x450
> [ 1088.271467][    C1]        perf_release+0x24/0x34
> [ 1088.271824][    C1]        __fput+0x1dc/0x500
> [ 1088.272155][    C1]        ____fput+0x24/0x30
> [ 1088.272471][    C1]        task_work_run+0xf4/0x1ec
> [ 1088.272811][    C1]        do_notify_resume+0x378/0x410
> [ 1088.273180][    C1]        work_pending+0xc/0x198
> [ 1088.273504][    C1]
> [ 1088.273504][    C1] other info that might help us debug this:
> [ 1088.273504][    C1]
> [ 1088.274168][    C1]  Possible unsafe locking scenario:
> [ 1088.274168][    C1]
> [ 1088.274658][    C1]        CPU0                    CPU1
> [ 1088.275012][    C1]        ----                    ----
> [ 1088.275367][    C1]   lock(&rq->lock);
> [ 1088.275646][    C1]                                lock(rcu_node_0);
> [ 1088.276082][    C1]                                lock(&rq->lock);
> [ 1088.276517][    C1]   lock(rcu_node_0);
> [ 1088.276797][    C1]
> [ 1088.276797][    C1]  *** DEADLOCK ***
> [ 1088.276797][    C1]
> [ 1088.277339][    C1] 4 locks held by syz-executor.2/932:
> [ 1088.277696][    C1]  #0: ffffa000145251e8 (event_mutex){+.+.}-{3:3}, a=
t:
> perf_trace_destroy+0x34/0x9c
> [ 1088.278345][    C1]  #1: ffffa000144fb5a8 (ftrace_lock){+.+.}-{3:3}, a=
t:
> unregister_ftrace_function+0x2c/0xc0
> [ 1088.279034][    C1]  #2: ffff0000c0e0c968 (&p->pi_lock){-.-.}-{2:2}, a=
t:
> try_to_wake_up+0xbc/0xd40
> [ 1088.279672][    C1]  #3: ffff000224d0c298 (&rq->lock){-.-.}-{2:2}, at:
> try_to_wake_up+0x6e0/0xd40
> [ 1088.280300][    C1]
> [ 1088.280300][    C1] stack backtrace:
> [ 1088.280706][    C1] CPU: 1 PID: 932 Comm: syz-executor.2 Not tainted
> 5.10.0-04424-ga472e3c833d3 #1
> [ 1088.281315][    C1] Hardware name: linux,dummy-virt (DT)
> [ 1088.281679][    C1] Call trace:
> [ 1088.281910][    C1]  dump_backtrace+0x0/0x41c
> [ 1088.282218][    C1]  show_stack+0x30/0x40
> [ 1088.282505][    C1]  dump_stack+0x1fc/0x2c0
> [ 1088.282807][    C1]  print_circular_bug+0x1ec/0x284
> [ 1088.283149][    C1]  check_noncircular+0x1cc/0x1ec
> [ 1088.283486][    C1]  check_prev_add+0xe0/0x105c
> [ 1088.283804][    C1]  check_prevs_add+0x1c8/0x3d4
> [ 1088.284126][    C1]  validate_chain+0x6dc/0xb0c
> [ 1088.284442][    C1]  __lock_acquire+0x498/0x940
> [ 1088.284764][    C1]  lock_acquire+0x228/0x580
> [ 1088.285072][    C1]  _raw_spin_lock+0xa0/0x120
> [ 1088.285392][    C1]  __rcu_irq_enter_check_tick+0x128/0x2f4
> [ 1088.285779][    C1]  rcu_nmi_enter+0xc4/0xd0
> [ 1088.286082][    C1]  arm64_enter_el1_dbg+0xb0/0x160
> [ 1088.286420][    C1]  el1_dbg+0x28/0x50
> [ 1088.286689][    C1]  el1_sync_handler+0xf4/0x150
> [ 1088.287010][    C1]  el1_sync+0x74/0x100
> [ 1088.287295][    C1]  update_irq_load_avg+0x5d8/0xaa0
> [ 1088.287640][    C1]  update_rq_clock_task+0xb8/0x2d0
> [ 1088.287988][    C1]  update_rq_clock+0x8c/0x120
> [ 1088.288309][    C1]  try_to_wake_up+0x70c/0xd40
> [ 1088.288629][    C1]  wake_up_process+0x1c/0x24
> [ 1088.288945][    C1]  wakeup_softirqd+0x58/0x64
> [ 1088.289271][    C1]  __do_softirq+0x6b8/0x95c
> [ 1088.289580][    C1]  irq_exit+0x27c/0x2d0
> [ 1088.289868][    C1]  __handle_domain_irq+0x100/0x184
> [ 1088.290211][    C1]  gic_handle_irq+0xc0/0x760
> [ 1088.290522][    C1]  el1_irq+0xb8/0x140
> [ 1088.290801][    C1]  _raw_spin_unlock_irqrestore+0x7c/0x130
> [ 1088.291188][    C1]  __aarch64_insn_write+0xc4/0x100
> [ 1088.291533][    C1]  aarch64_insn_patch_text_nosync+0x40/0xa0
> [ 1088.291928][    C1]  ftrace_make_nop+0x120/0x1a4
> [ 1088.292256][    C1]  __ftrace_replace_code+0xdc/0x160
> [ 1088.292613][    C1]  ftrace_replace_code+0x100/0x1a4
> [ 1088.292963][    C1]  ftrace_modify_all_code+0x1a8/0x260
> [ 1088.293335][    C1]  arch_ftrace_update_code+0x1c/0x2c
> [ 1088.293694][    C1]  ftrace_run_update_code+0x38/0xa4
> [ 1088.294048][    C1]  ftrace_shutdown.part.0+0x2dc/0x550
> [ 1088.294415][    C1]  unregister_ftrace_function+0x74/0xc0
> [ 1088.294787][    C1]  perf_ftrace_event_register+0x130/0x1a0
> [ 1088.295172][    C1]  perf_trace_destroy+0x68/0x9c
> [ 1088.295500][    C1]  tp_perf_event_destroy+0x1c/0x2c
> [ 1088.295850][    C1]  _free_event+0x2f4/0x670
> [ 1088.296154][    C1]  put_event+0x7c/0x90
> [ 1088.296439][    C1]  perf_event_release_kernel+0x3c0/0x450
> [ 1088.296820][    C1]  perf_release+0x24/0x34
> [ 1088.297125][    C1]  __fput+0x1dc/0x500
> [ 1088.297404][    C1]  ____fput+0x24/0x30
> [ 1088.297682][    C1]  task_work_run+0xf4/0x1ec
> [ 1088.297989][    C1]  do_notify_resume+0x378/0x410
> [ 1088.298316][    C1]  work_pending+0xc/0x198
>=20
> I checked the code. The following scenarios may cause deadlock.
>=20
> static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
> {
>     struct rq *rq =3D cpu_rq(cpu);
>     struct rq_flags rf;
>=20
>     if (ttwu_queue_wakelist(p, cpu, wake_flags))
>         return;
>=20
>     rq_lock(rq, &rf);
>     update_rq_clock(rq);=09
> 		=3D=3D=3D> el1_dbg
> 			  ->rcu_nmi_enter
> 			    ->__rcu_irq_enter_check_tick
> 				  ->raw_spin_lock_rcu_node(rdp->mynode);
>     ttwu_do_activate(rq, p, wake_flags, &rf);
>     rq_unlock(rq, &rf);
> }
>=20
> static void rcu_gp_fqs(bool first_time)
> {
>     struct rcu_node *rnp =3D rcu_get_root();
>=20
>     WRITE_ONCE(rcu_state.gp_activity, jiffies);
>     WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
>     if (first_time) {
>         /* Collect dyntick-idle snapshots. */
>         force_qs_rnp(dyntick_save_progress_counter);
>     } else {
>         /* Handle dyntick-idle and offline CPUs. */
>         force_qs_rnp(rcu_implicit_dynticks_qs);=09
> 			=3D=3D=3D>raw_spin_lock_irqsave_rcu_node(rnp, flags);
> 			=3D=3D=3D>rcu_implicit_dynticks_qs
> 				  ->resched_cpu
> 				    ->raw_spin_lock_irqsave(&rq->lock, flags);
>     }
>     /* Clear flag to prevent immediate re-entry. */
>     if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
>         raw_spin_lock_irq_rcu_node(rnp);
>         WRITE_ONCE(rcu_state.gp_flags,
>                READ_ONCE(rcu_state.gp_flags) & ~RCU_GP_FLAG_FQS);
>         raw_spin_unlock_irq_rcu_node(rnp);
>     }
> }
>=20
