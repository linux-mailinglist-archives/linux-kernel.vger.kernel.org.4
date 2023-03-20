Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F016C0C80
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjCTIs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCTIsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:48:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6194204;
        Mon, 20 Mar 2023 01:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679302118; x=1710838118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fi9YknH6JJ81yzcUDDgm6F7vnZDk4XNGtl9H8qBG85E=;
  b=I/KAyUVo4CecpmryrBHSJe05CKLy53ine5iP4x7FLA2a3ZmKhtxvp2Mj
   GHB2YOK6z1OFDFi5YtrJ5c1/BY1GKFiqTfD+NWaaCv0xvILG3UcGCcRVB
   jLd06ya8iIpDaRvWedZMItWxez+Oub7ElqlTA5Be1lN3QIcHmZfV16xfo
   9ePaz8mxKcAwvcJw+n8B7cT2Uo7VSWgqessr1wtdcW71dL4RFGbfDy4TW
   1EmK0vc/zmZLxv9vyGYsRu6GjQ+aMqyihWL/laZVhSJoXWWwotNkJv0Rc
   ojcshqUwxh006zOyV93Xr/DQcaOGtjFy/anlD1Df79TPqINFvx0YH+Xpg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="336110830"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="336110830"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 01:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="1010390301"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="1010390301"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 20 Mar 2023 01:48:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 01:48:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 01:48:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 01:48:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 01:48:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXhl5is+QCVOhOAGNBnaojgrPdwgTg1YMb5+TiI+X6SWx7ESkRVlQjHZvUBjA/YJuhshZgH7pjZfQC58/Xjr/oUhGoLnxp3Qo75dICXpd5q6xne5Fek5u/AggOV+yZBBUea/rVOvXwTg32yqD6eiMmVNtPvsenD6pcfoK8wX1kLcUGSyQxtooFtMBSfYOU8uueDWLn6VHfCbjJImBpGWn0F8Jwe2FT6RGyp4G4NQQJ+5ChoQkKzOeHMadtJRemI3um7Upn1og46oWK/OdiTRIBph7xJDGzUn990N6Sbp3r+L8qM4uCDvGu1qG55zp5GnGAQuapXCQZZjaGfzsjDUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pPz4SAORbK7eRW5IVG2p4p7lMor7ajbdix3Nn6lJnM=;
 b=gKh6gf4cORaP1Wk1iv3R4QlR94fsxRLEbL/Z+J8tD5I8/mNWvnaQZQ7yxI03EnjZR3gcXTRPhpGO+2JvRy1xiobSA3LBJ2NWcp+sX4udPJGfFU+uc9cWEBs6guZvlDoDRbYjFW6aI2o7agfDH+ii+obu3cZYDPgas8ZX/RRetylfLM+xMbtY7WHQeDk/fz/vlT1rRWzPlW11bgIMMJoJXUbvpTPRQIskdv0amp4NURbwA1fEOZNHJhf4bnZno8LC549EInHxvyd+u4fv8Gj9vbJlxcQ1QHHBPK3qpF19IVyy3fZAquwxUgX25e43A48ESs6sLkR0HKl2+Ygc88CKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 08:48:35 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 08:48:35 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcutorture: Convert schedule_timeout_uninterruptible()
 to mdelay() in rcu_torture_stall()
Thread-Topic: [PATCH v2] rcutorture: Convert
 schedule_timeout_uninterruptible() to mdelay() in rcu_torture_stall()
Thread-Index: AQHZWtsElwxz/KN2NEOd8ANQA4i0X68DUz9g
Date:   Mon, 20 Mar 2023 08:48:35 +0000
Message-ID: <IA1PR11MB6171C51E1DB7E1575D70878089809@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230320032422.4010801-1-qiang1.zhang@intel.com>
In-Reply-To: <20230320032422.4010801-1-qiang1.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|IA1PR11MB6099:EE_
x-ms-office365-filtering-correlation-id: 042dafab-373b-474e-5a60-08db291fe44b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uH9+ygbks0imhvbRduTbCKiSyYxBmYWPq2Ux1YQ0Izmmpg1Dd/HPbAztMo8LVxfpbZBUo2T97QPG6GcV6apdMgOGWsopHOpfDopYowxCKiv+2Om4PL8RO7ngFiQ4GFur1T5Z6qnHG3yltH0r0urOxvvfC7HbFzMn7UfQJAlWAdAgjRn3uj5LibarWikBnsnupqHgOgybhaU4jyp4MeWpKnDBzDbdpIkH/ku2TuVFHoav44p7018eT5pdY7tNcplON15UiuHi8kEKTHVDTTZjilH7X6TTYQI3aOwiF2tnaYRT0QTe7lrL/nqPr7ldnWHUfPVuXPytuO+c7nk0fZt0E3yOizmVBeojbRa40yNcH+IVefjuzWdgdQba6xly8Rz2CPaJkd92YfVUIPB8UHzz/GrWzRmr+u+ROtZwqL4VjD7cFnsF9tXKwwLPM6ZEj0ot6b7zSswBu6vRL9KibS6ro90lG/3fO0hvgvRqjqOHDoUjabx0GYinJy0r/M48h/ldJt88jZo5xMUf7Tt1eBFcKoy48nyuYamVS4xhP1UBQQqRHkXru0x/37zLTZUNTlK/99A0zKuhz88OvhNwrLjf3CyutaiSLp9JWEWuY7uSEpHGxCQbJyb0cbgxYkfklyjUaiHQ4vkGaCIKTINy4rSV+tHXS90+wxJFku5M1CzP4/6MH19CMMcJ8idrmPDKt8gGfG2Dx8IPvnddXE5dFQA6CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(38070700005)(82960400001)(186003)(9686003)(6506007)(53546011)(26005)(71200400001)(7696005)(38100700002)(122000001)(478600001)(2906002)(86362001)(83380400001)(8676002)(316002)(55016003)(110136005)(33656002)(54906003)(64756008)(8936002)(66476007)(4326008)(52536014)(76116006)(5660300002)(66446008)(41300700001)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ilSsM7AN8Vf9kq/twpH7GCwFRJomxQlumznfNdOz3u4fxruqSnroNg5/OfNn?=
 =?us-ascii?Q?KsCdzhvd0bI5DsSjo8t8CNzMjHka5O8j4Vj0SzcttjchXldJBMWSuqqcGaZk?=
 =?us-ascii?Q?MUutmG6NjKoKl0Z0NjKBwJ2FlZ8Xr8aSFqUYtjWRMZM5RRsa27LJV6X3OKpS?=
 =?us-ascii?Q?IyAN9YHdP54sGQxfiCDBXLNlcFbCxzcKlhnTVOOx23JGfoja7dlRGaZUmUbX?=
 =?us-ascii?Q?5Fp9uGbY51WGFRvAK48QbfWl7+OWL3/TwQqIpC3kgfEFFdfuz35bbHLowsKA?=
 =?us-ascii?Q?lQ+6hqcEtmaWgWkF7iL0WBAP789ujVH6lo/fBTkG3GQCnOMO7GpFYkJDidSM?=
 =?us-ascii?Q?84yQk12qG02WE/NH3rTB9vHbD63cgOaFNxPS1swA9z5/sEEnJdzmamOnMg7K?=
 =?us-ascii?Q?hGNamvMO8lH/jsNH/nrDKCnhDYnp6NgPONh4YB/o1jxJjDQclNw49jwl7Bkk?=
 =?us-ascii?Q?846iHHrYZXzAzFw/Yc9xSQzvgC/dvGlQImo0gjSjos7J83ZJM7eOdf/ds1ml?=
 =?us-ascii?Q?O8N+PZcdgX+gHD3WN/01Qg2fQjZ/G9c1cf0o5aOu9BSZxBAP7tLLy0zcxCzd?=
 =?us-ascii?Q?58zVpo58DVctzNs4vtHWRFH3UPxv094gk5+nT6JJrLZSsRz2p8UX3ISAs/4j?=
 =?us-ascii?Q?FZX3leiBTvhED4cF9R+K6wcbvOh9CE1BE1w88WbuLtYHhUD4MDVlRlmubd4y?=
 =?us-ascii?Q?9nekRmqdLas9iWMlKeehJGYkWTCf/qrFNjEK3eWquBhGEornoCGAfIcnjIWb?=
 =?us-ascii?Q?ZZmx/u8ITHXhrKYk8cA8BSf0NY/GVcNlWwsQWIrTuL6qw3vKbn/dA+EUC987?=
 =?us-ascii?Q?2bhEIjK13IdJBuRrr/agcNX9YvNag5GZ50gbSBnF6bdxVUPkJ9tvZQB+e0Df?=
 =?us-ascii?Q?nRvWW+NOejMTprZbuWkTN74q2HjBAHA3EFsu0tBusjDYGniszikLH3dRA52z?=
 =?us-ascii?Q?vVUznyY0jfy2uRdkBnDWTSm3GcG+JWYpwzIkogcOWm4egHzB4/tAJQEHfoqL?=
 =?us-ascii?Q?G8bc0zGnkfAGSt/rsJ6sumgXCYshPOGl2vvz3ibhEBpnDVHF/dZIF0HZi/Bt?=
 =?us-ascii?Q?8vV1pZ0d1fchmqy/X7hcc3Yky5JumzH6lAIq2R1cEY3r6DDY9KLhhjia590l?=
 =?us-ascii?Q?vzAT1k2zluJsyo7mN5K+cMezhTBVRRqTeRhgLviFGNhlLGFLTnBWd2G7WXAr?=
 =?us-ascii?Q?1z3/Xj6RbF/nJXrQ1TmOAIDQVKiQVvK/rP8EobWp/EADWwe6ReHUkhFW82Gw?=
 =?us-ascii?Q?JV834sE1QDprWnpsaTh4kr0S/m3GGbHMBeS8AOjdCiw5UuOTNOQoyMOTCC8J?=
 =?us-ascii?Q?LRssuUYKPDCfIiDJOHxHnNs7/OsUYLv8qnz7iGJ2lpwxhYwck8V2BZFuNnAM?=
 =?us-ascii?Q?FSaYDBfUUH/49kDBKzP8WBMX5TREINKU29XvnVKqG7iOlZYZF4oEjCHzJTiB?=
 =?us-ascii?Q?4he6/gVDyC7EtV0V6gyiIE/gztKOKEGvh+fjm6Pppjr84doIyuQLzyoywqU9?=
 =?us-ascii?Q?pglga0IjDTlAwevAOsp+clkLTKkUwCmLUi/Up8q8rI6gf2KLyhfla2QbaboH?=
 =?us-ascii?Q?YAvHs+gnuzuAjq43nlT2WjUSrfAPk0BGM+i1YpX9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042dafab-373b-474e-5a60-08db291fe44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 08:48:35.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIUqB0DBF+2Att3u0DCei9dbgu66jwpjDGXcJKGgSZtr4y26RJnG0myOwqZgZb0mrrEPxg3mdbPd4mC17ve4Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiang,

> From: Zqiang <qiang1.zhang@intel.com>
> Sent: Monday, March 20, 2023 11:24 AM
> To: paulmck@kernel.org; frederic@kernel.org; joel@joelfernandes.org
> Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v2] rcutorture: Convert schedule_timeout_uninterruptible(=
)
> to mdelay() in rcu_torture_stall()
>=20
> For kernels built with enable PREEMPT_NONE and

s/enable/enabling/

> CONFIG_DEBUG_ATOMIC_SLEEP, running the RCU stall tests.

s/running/run

>=20
> runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4"
> bootparams=3D"nokaslr console=3DttyS0 rcutorture.stall_cpu=3D30
> rcutorture.stall_no_softlockup=3D1 rcutorture.stall_cpu_irqsoff=3D1
> rcutorture.stall_cpu_block=3D1" -d
>=20
> [   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
> [   10.841073] rcu_torture_stall start on CPU 3.
> [   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x0000000
> ....
> [   10.841108] Call Trace:
> [   10.841110]  <TASK>
> [   10.841112]  dump_stack_lvl+0x64/0xb0
> [   10.841118]  dump_stack+0x10/0x20
> [   10.841121]  __schedule_bug+0x8b/0xb0
> [   10.841126]  __schedule+0x2172/0x2940
> [   10.841157]  schedule+0x9b/0x150
> [   10.841160]  schedule_timeout+0x2e8/0x4f0
> [   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
> [   10.841195]  rcu_torture_stall+0x2e8/0x300
> [   10.841199]  kthread+0x175/0x1a0
> [   10.841206]  ret_from_fork+0x2c/0x50
>=20
> The above calltrace occurs in the local_irq_disable/enable() critical sec=
tion
> call schedule_timeout(), and invoke schedule_timeout() also implies a
> quiescent state, of course it also fails to trigger RCU stall, this commi=
t
> therefore use mdelay() instead of schedule_timeout() to trigger RCU stall=
.

Tweak the commit description above to fix some grammar errors:

    The above call trace occurred in the local_irq_disable/enable() critica=
l section
    when calling schedule_timeout() from rcu_torture_stall(). Invoking sche=
dule_timeout()=20
    also implies a quiescent state, of course, it also fails to trigger RCU=
 stall. This commit,=20
    therefore, uses mdelay() instead of schedule_timeout() to trigger the R=
CU stall.

> Suggested-by: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

I didn't reproduce the call trace after applying your patch.
So, with the above minor fixes, then

    Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Thanks
-Qiuxu

> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c index
> d06c2da04c34..a08a72bef5f1 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2472,7 +2472,7 @@ static int rcu_torture_stall(void *args)  #ifdef
> CONFIG_PREEMPTION
>  				preempt_schedule();
>  #else
> -				schedule_timeout_uninterruptible(HZ);
> +				mdelay(jiffies_to_msecs(HZ));
>  #endif
>  			} else if (stall_no_softlockup) {
>  				touch_softlockup_watchdog();
> --
> 2.25.1

