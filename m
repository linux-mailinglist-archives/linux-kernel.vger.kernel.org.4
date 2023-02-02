Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AF687615
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBBGyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjBBGyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:54:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4692228D3A;
        Wed,  1 Feb 2023 22:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675320889; x=1706856889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QFr0H+xT4tfjiANgNnKz1LfycqUkc9MmTkjs3RpsT/0=;
  b=cWcs5w9KAFZlDfVulf0zadDFV/vJWA5hZFB9g3XTAXiWGasRnTC7hr5d
   7r1Dqk3bpF76TPneB10Dll65s+KV/DYoAEbGO6zLUlFiTuTVjEkyzGe/h
   KH09sdlikmMiyTTasOkmk0CT5FELfYyJ2s0gDDCoEnPjHe7kJaozhgSSA
   aFP4MCN8RjqSVomov0aBehyszftIyQIl2x28ZCYAkAWXXp51l6/whSLEg
   PYghOAof5t0WMmB+Tw7bLFqGCXtUUP38kiaQppmpOTljSRMFWx1YN2/RM
   XI6UaeoAub93IsM3wKHMtgbhIL4sLa8zk9q/xq4JXqnZ/3lilOTkz3+lb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="316369836"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="316369836"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 22:54:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="695670181"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="695670181"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 01 Feb 2023 22:54:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 22:54:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 22:54:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 22:54:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 22:54:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBswnORNp9Yr3KDmC4WTSBZHIgf/ZdDuIoyBqqOL5bLDRMPhcvG4nMgGYTa+FsA+6rJAp/x9KoHGFPRU2kwf3WtT67yeKJXXSeZls+uKXE9hE+sg+Qr2wj9GRhFvXBA+zyUPfkR+sPEAJtv9pflZz7o5ySL8WSmozHzOsr0JlpiGS8NiueaqkIkXldj4V25RXBHtqWpqZOrtfw6EuM4heUNT/KRqBUjYzU6qKjPeDrsQoC8YMEEntHQ+Yac8lO1mhT3+yHmxPzCJSyFng2DMMb8vYypr+w5O64vOpUqjR5AQW7WdmhxLXHhSaPW4Th/KNhS9boQLweitVNI/Re1z5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEljYaUHZlRn8m9wpCqo7rLlx5Qd4kqCPffIp67GLLE=;
 b=eCnW58QzfS/dvuGfu25mipg8V7FBeCfzSlFEBml5MLiemi/s/6PgpXdA9djiJGvklwDDxWMCdYsBbjW7bAOEdryW7C4oCROsmVqkSZyhVvsRWQZZ8X1V9Aphjjy9gLsjIzmDHTlHuyFtubU3xcN9FhUKqORH//Re2yHCSzFOc9Wo48JQCj27M4KsysrdZAzU+bvBUfUMKUghyGN9i3GdD6WMa6ME8r47C31P7nV4sym/PWt8dSQZg1PaczDbFZAe5LHfxSl0UDHi70kherlzNtD20+xFUoDPV4tFwM9WKSxwPl40XH6ksK4SLuKYTNUGa12T4FR5TM1XKJQe1RGkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CO6PR11MB5569.namprd11.prod.outlook.com (2603:10b6:303:139::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 06:54:46 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 06:54:45 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcutorture: Create nocb tasks only for
 CONFIG_RCU_NOCB_CPU=y kernels
Thread-Topic: [PATCH] rcutorture: Create nocb tasks only for
 CONFIG_RCU_NOCB_CPU=y kernels
Thread-Index: AQHZNtG2s1141EqcGEi4PIz7Qi9/SK67NubQ
Date:   Thu, 2 Feb 2023 06:54:45 +0000
Message-ID: <PH0PR11MB5880F444889A1FB409883E57DAD69@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230202064846.3306975-1-qiang1.zhang@intel.com>
In-Reply-To: <20230202064846.3306975-1-qiang1.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CO6PR11MB5569:EE_
x-ms-office365-filtering-correlation-id: 80dcdcde-ba92-4334-0816-08db04ea5e96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RqAMcy6Hy5n7frqVfLaHIJM8o+WObkm7WxVkxtWDS8cDsC+TN0ivB+1BlPn0fTXQ5NyvPZCkPJ7d9iBJeqmBIbDOLRGJPB8Lvcb32YmTPlDFV/i/6vFl2SXJBLALz2AV8nw3rBdIyjtzIXj6LyIiEzhd+c1tsFk2fegPLmgz4Ki5dRX0jPIuCdcQTxQbbdulqdEr/Cbcj6Dv8Vj1UNdLEZFvGvvGrdrLndcgWo3a2tFiLFkH/q6VApmUTbE90EJKvLvbR08gOqOjSODGurX0ZK0nrJ6hbew50cL03oSv4n2p+3KAmEUXwK6lMufUt4lENsX+i1R9cCOFDGL3gaAFNdmlwvrZc5Zr1AwzextJy7gaOwgtXYjBcf5QZHFTl2p+XVIyQK7pjNvURzcFMyEobB9DybLe5OcqnREYUVQHomwtsrrHQ/GnAyzSAzpjgK1rtpBURhtMLg8PO1kI4zI1e8q8UDJMcMPZvnSv7BXQFB2xPrsBBzpKer96C2dQOikbOUIYy3Pl3VKP7/N3enqV768dPlEgqj1HljyMqNFqbGd0wM3hcJtrunvmcewuKASJ6lGOReLuq3Z3+e/HvtwcCATY4UvSfcTcPQMRbZMeb6zt2oHp52yIww9kuPaRMCXN2lmwJGP05CtVL5c0Q14tKZC8mMFAsaq87M96jS1qdWq0QVMemjbKtGkwQunDnURN6nlJzgWzFjWyDMpaBz4bOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199018)(122000001)(5660300002)(6506007)(110136005)(38100700002)(9686003)(55016003)(83380400001)(41300700001)(33656002)(86362001)(186003)(26005)(38070700005)(316002)(2906002)(52536014)(71200400001)(8936002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(7696005)(4326008)(478600001)(54906003)(82960400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4TcF1yH/g26H7tVBJKx3GRSPtFg7rCz48TPH/1hottPL64ibtDog9Ec1nftm?=
 =?us-ascii?Q?4uuDcDSvqjE9fVsoJ4tZuKQlsBtbjKA7wNYZdvB4n7GT/60Tu4cnOTzCwLzE?=
 =?us-ascii?Q?r1hOOj0x95oDLiDlUeYyLR1rACBLwoXOUmKvOHy+QnvhW0vQ4BHf1gHT9Oez?=
 =?us-ascii?Q?pm5EkuFL5gZK6PvaBDdeuNphPIcdTPvNatxTH52VT6tmHun5BSqX+hrFz0JV?=
 =?us-ascii?Q?RtQO5ngdySyR6yBhwMNal5doX3Xd12Xu3yUWwfF6yD9eE9MayPwsAm8OIHEb?=
 =?us-ascii?Q?lWuTPoMCmA72Ti5/QZcz6uHrKogGXxhyraKv656twSY6oLrpP6f1yrHC/6Ds?=
 =?us-ascii?Q?lWWkOd6VOOjjRBRMTlkBl+ZpzrFl/V/8sQyJ3gKhyz3t5lbC/+HGP7hle5Aw?=
 =?us-ascii?Q?98Tm/WcX0dS60c5x+PmK+rBly77HJbY4nARbRhUKM+b5g/vLbKf9+FeTxOiD?=
 =?us-ascii?Q?+6k8ER+/TT7FqxVkEOahX14/PcPNt0zqOBLP60/1o/KwPZnOhBcodoyvZCrE?=
 =?us-ascii?Q?l8sxYzeg43gz7D3Xlh88eJ2dE1ZbBgf2veyWH/HEbLCMnFhlky5lEfNc/D6w?=
 =?us-ascii?Q?1gtVCslp2cnewnJYDX6aoPPUwWYaAiOSpDvFDFuD2PvvPCSlDTQMfp0bQLe8?=
 =?us-ascii?Q?7MNopqWtl/EUkYbGxqLVb0jB1N6rQai8oguPJXP8ngeWNLHXV1gsb+1n1/36?=
 =?us-ascii?Q?BAuYTPMCdi2yOMO+6/tkfOsd2INXkL27uOdUTRkIn9iWXnEtWcFwrx8CECm6?=
 =?us-ascii?Q?e5I6jXeUG/j/xHwFTFdexDlTU1Wo6sGg5H3Pp2q5LH+KfgLLWQgJFnbLEcXD?=
 =?us-ascii?Q?iv04wVsGib0VD7xKwnOZj2dMF+qL8q4ZXS1LL4pSfptGouKv5o9Z5V4gaKge?=
 =?us-ascii?Q?PZ//A7SUNNC6YPitHBlOgeaZJcQwpXAGDzr6aa9fMrRHELw714Fggx7a779X?=
 =?us-ascii?Q?66PsJOCZ3PEpWcdxzCbZ+r9r3H9bK/Lzgc0QlRTndTCsrq82QuSlH2Q7+0YT?=
 =?us-ascii?Q?abKrLFasMxpllaGL05bBjRAm3UZLrrrW8KMOqtVEFftkutI/xppr38F6727F?=
 =?us-ascii?Q?s87u1ebwJ2ALbFozWnuKRgjYCmBofc2WCse9vW6+DnZA0KJeHA3HkwE2hQlC?=
 =?us-ascii?Q?I+qBWVCKl+LuiuosCcBIZmGDJDtS8Vu+w5U6T7RJjDlbl2IF9IhDA4al1UZF?=
 =?us-ascii?Q?EvGxlTlRZDgv7sxLOKOam9ytLoPEUxzLsZSrTUFIWesfKPJsoTpIUAlkjB6i?=
 =?us-ascii?Q?stEcdwkEv/GBISvrnZxKbRrhBE7bfxP/bIQS7Spb0P/lw/Tl1pegKdyCWFz6?=
 =?us-ascii?Q?DDykuzyPSPCTmZiJFjmcZ3p8M19+AHos3Jg8yDH96+AP3AGMo1m777e4iakJ?=
 =?us-ascii?Q?MK2pxL/6EAm5aJU197lMlqUpQRfhjAZm74s32dI0T6p026/pHvWYLr5fRByO?=
 =?us-ascii?Q?bAWZFvCsVBz/JXLoggOvTjNycho/W0ixpZRgmuAkuVFcyaJeiMGm9jScukWS?=
 =?us-ascii?Q?Bfqzx23l2jm18ajfecYr+fUcdQqNcxkjpJr2vxyy4nWxa/JY02pdk+IVyrL8?=
 =?us-ascii?Q?aayYZTNHNWCcVmF9pfKtvbmRlyM6w6XotYL8VKnl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80dcdcde-ba92-4334-0816-08db04ea5e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 06:54:45.8338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbQmkK8wg3M4N/tDjEOIWhKpRSVP5rQ1126COI1cdrsvhM7iW989T6jFT6VrarWyZFixNHru/85ilbesVsY2Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5569
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

>When setting nocbs_nthreads to start rcutorture test with a non-zero value=
,
>the nocb tasks will be created and invoke rcu_nocb_cpu_offload/deoffload()
>to toggle CPU's callback-offload state, but for CONFIG_RCU_NOCB_CPU=3Dn
>kernel, the rcu_nocb_cpu_offload/deoffload() is a no-op and this is also
>meaningless for torture_type is non-rcu.
>
>This commit therefore add member can_nocbs_toggle to rcu_torture_ops
>structure to avoid unnecessary nocb tasks creation.
>
>Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>---
> kernel/rcu/rcutorture.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>index 297da28ce92d..27becacbe3b2 100644
>--- a/kernel/rcu/rcutorture.c
>+++ b/kernel/rcu/rcutorture.c
>@@ -383,6 +383,7 @@ struct rcu_torture_ops {
> 	long cbflood_max;
> 	int irq_capable;
> 	int can_boost;
>+	int can_nocbs_toggle;
> 	int extendables;
> 	int slow_gps;
> 	int no_pi_lock;
>@@ -569,6 +570,7 @@ static struct rcu_torture_ops rcu_ops =3D {
> 	.stall_dur		=3D rcu_jiffies_till_stall_check,
> 	.irq_capable		=3D 1,
> 	.can_boost		=3D IS_ENABLED(CONFIG_RCU_BOOST),
>+	.can_nocbs_toggle	=3D IS_ENABLED(CONFIG_RCU_NOCB_CPU),
> 	.extendables		=3D RCUTORTURE_MAX_EXTEND,
> 	.name			=3D "rcu"
> };
>@@ -2356,7 +2358,7 @@ rcu_torture_print_module_parms(struct rcu_torture_op=
s *cur_ops, const char *tag)
> 		 "n_barrier_cbs=3D%d "
> 		 "onoff_interval=3D%d onoff_holdoff=3D%d "
> 		 "read_exit_delay=3D%d read_exit_burst=3D%d "
>-		 "nocbs_nthreads=3D%d nocbs_toggle=3D%d "
>+		 "nocbs_nthreads=3D%d/%d nocbs_toggle=3D%d "
> 		 "test_nmis=3D%d\n",
> 		 torture_type, tag, nrealreaders, nfakewriters,
> 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
>@@ -2368,7 +2370,7 @@ rcu_torture_print_module_parms(struct rcu_torture_op=
s *cur_ops, const char *tag)
> 		 n_barrier_cbs,
> 		 onoff_interval, onoff_holdoff,
> 		 read_exit_delay, read_exit_burst,
>-		 nocbs_nthreads, nocbs_toggle,
>+		 nocbs_nthreads, cur_ops->can_nocbs_toggle, nocbs_toggle,
> 		 test_nmis);
> }
>=20
>@@ -3708,6 +3710,10 @@ rcu_torture_init(void)
> 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabl=
ed.\n");
> 		fqs_duration =3D 0;
> 	}
>+	if (!cur_ops->can_nocbs_toggle && nocbs_nthreads > 0) {
>+		pr_alert("rcu-torture: ->can_nocbs_toggle false and non-zero nocbs_nthr=
eads, nocbs_toggle disabled.\n");
>+		nocbs_nthreads =3D 0;
>+	}

Sorry, I ignored the case where the nocbs_nthreads is set to a negative val=
ue, will resend.

> 	if (cur_ops->init)
> 		cur_ops->init();
>=20
>--=20
2.25.1

