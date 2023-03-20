Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7E6C2565
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCTXGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCTXF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:05:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064F934324;
        Mon, 20 Mar 2023 16:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679353528; x=1710889528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uGGRvreKdIhZkW+j7Wvl+XDwrFouHyw1dqC8NobrR2Q=;
  b=fs0ToZN2cBAv7YqpxxGbXM8cXpARJgqBFhCwDIwde3D/blzxxwo6orp7
   NLwTRxEOMtGghuW5eYTAJyWeC03Y5paoTMumyGtzg8R1Ov+1UEkEgYc5I
   D3rUA4W2HDkdOAq1eAoIpAxl09o2F8uZEED3UulBA/pwqwDnc1m/R90vg
   flhvOyckAA8r6bub/he1JCFLNwqkAY+dZb/klAy7XvKtouxWF/v7bv6Hy
   /ssd9OUpPz2skW3s+89FAzDz1B0kzWvfP7hVnaAtGJ5xwLwaPCLPwsG7t
   Ux5Rn+tNPRgWb7hgdu0DUB+3A65fiKZFJIp9i3nvHmDnBzHY1wllJLfOx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="403672408"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="403672408"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 16:05:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713749395"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="713749395"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2023 16:05:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 16:05:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 16:05:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 16:05:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 16:05:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLV/fVau+/KLRkEivNf3h2JyHhEiLts7FlP0BY2sGzRyM3BjhmVVhqceijIj/znsRAj09o2a92tMQ2M44l9xfSU2sqoWYuwTU+6Tk4ugE8W+GrsbIVvKURJwuyheN9CybJqUqbwEnvPv3P8a2kAy2SiBNaftVnV7njDr/IEgG3mlNDhT9fGqU5cGQxCUxo1Uw94+9z87PpXo0o5lTrfwDUx0wEbvGFHAAZxz+NwnVTzCk0bWThrAkMIFqi7YQsfdOQPdHNcrZLay6igmPKYAdYmre4WqYdn9FdbG2Y5PJjEa9lV38lZTkbjkS9Pm0xteDcLNyOfdbx8vON/55X+jTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpTY2W8CfcorEjRUjOiq7bOAHYSB/B4e8HFYBilBDLo=;
 b=CqBX8KM8dNVhAdmBP8FWw26hJl3gFXs2mDyp7bRjLohs3fjp+5vlEpxNs6hbJiQStsUaIE94A7Nq080mRhymZDqSuFV44maJZ81lhgW0uO0i8jnhdxb6Ymjyr7KGjgNqkPdtpxUO2L9VPfYK06dwCy6my2CPKaDm87k4tFE8GjRd5RDcU43tmsZT4epo22TH8Bka20lQCJczk08g6aKFxNlz6zhArD3kvsQbtpIobJLXSy3+5muv0SPcYl9tFWGNTI20Z6nUzAuSujhjqu0dX9gZeVxeRkVYDgfKll88iXtlyakQQu9YDsfHrXJ9zo1wpL96OKJun+LuZgQoeVLPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL1PR11MB5367.namprd11.prod.outlook.com (2603:10b6:208:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 23:05:17 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 23:05:17 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcutorture: Convert schedule_timeout_uninterruptible()
 to mdelay() in rcu_torture_stall()
Thread-Topic: [PATCH v2] rcutorture: Convert
 schedule_timeout_uninterruptible() to mdelay() in rcu_torture_stall()
Thread-Index: AQHZWtris8fTdEhd602c/GqMXMcxwK8EHJQAgAAryuA=
Date:   Mon, 20 Mar 2023 23:05:17 +0000
Message-ID: <PH0PR11MB58806032CE88C9E6BE61059CDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230320032422.4010801-1-qiang1.zhang@intel.com>
 <7a414721-25fa-485c-91a5-13d3149073fe@paulmck-laptop>
In-Reply-To: <7a414721-25fa-485c-91a5-13d3149073fe@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL1PR11MB5367:EE_
x-ms-office365-filtering-correlation-id: 52176c82-5829-4427-47c8-08db29979223
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHH4hSzvUE4mAevSSEtQ3XePziFnHPyqS6TY64p5ra9PsdZs8T059LeWnkIfqvHdZ3WqZT4Ib3dtVu/RSeAJdd38M2JfeUtq76C4pINe00iAcrxI1ZdRAb49fSWkK3H6O7n+zmvIueZwXIVljzx/2lqDsnjSTNW4R1Xr0XK621zDoTyImTA/TnYC2FtEuIl2b5jmBD347LgutsNmDtJbKSH4YEb3i0XeRN+wSllrbhKDXpDisUwOHWh39s3gEND6cX/rPpVfHroVP3bmekF8DLQfLlgZqjMc42MSTaBJc32WfxME60j/GInglciOmo4bu5GbwWzH1jQzzunFEPjNDLMwrluQnzAwGyLN+71xA+48oZSDMTnEWFLF9oo76urkhwxH3dGFQ6hvH22rWtB2WVNfLpG+tHpx7Sge7uJHxuQAaiCoX45OzsOJI1uUhCCOiWozJ89dPL7R2olcOmBG+o5RfwWFRuHGQUq2SUAEhqSkNOC1VnpRtNb47j6Ejb+fCws4zPMIcdi9sH/yhb+4fTjhCxMFsaQJ89HbmYlYkUtQSBkKfShq2T9B8R83WG6N2cIqzsW/TnAN8L1/htoJPG0zYYzAOhfADBRDJyCLIJ9YHCYCXHt/uxXxNfPl6Xt0a03yl3RiiNQK9vNrxw9uANQHiqU01bTPNO3d3a2x9rv597JVW3onIaDksOKm0yVepvvff7uJP3Vm2lyFQXC0CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199018)(38100700002)(55016003)(71200400001)(7696005)(83380400001)(33656002)(54906003)(316002)(8676002)(5660300002)(66476007)(66946007)(66556008)(8936002)(6916009)(76116006)(4326008)(64756008)(66446008)(41300700001)(52536014)(2906002)(478600001)(122000001)(82960400001)(86362001)(38070700005)(186003)(26005)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cwh66d4A2FJt+rN1l8ZNu+4I4i3dj98iaLBJKNsGSGyubNN4GDNGHsTO2oHQ?=
 =?us-ascii?Q?bFYHD/1PHhiQPDGfJl70X3QcTGpRd1DMgyDu6o4NpVxxsGcKAgw9TSWSYtAR?=
 =?us-ascii?Q?qYm9oTboP6ac4CRnMtmV8o2fREBcjZBFKGanfRbqdHCPrEtiUIMh3kK+wP6f?=
 =?us-ascii?Q?oK4SzO2tkb8AtEP1Eynd48qgLvxBRM/641kCq8hvztwvNkKfNwDaDyyn7ewH?=
 =?us-ascii?Q?G2p3qnE/vXloJ3xKHAcDK130ajhLtYF9YmpGJ7AeQF+Trer/vMhBkCtMZ/OE?=
 =?us-ascii?Q?CCBtYCH2DyhnR7UVK2Wmyq2jL2Pj2432xH9KRzmmYQGv03iXbI8FEOKWTQJV?=
 =?us-ascii?Q?ljerMRGw2Nwf5PS9+Subm8K8OEaL+Gbsyg4bHBupxVttELM2jNkRAWIpOxt/?=
 =?us-ascii?Q?i0/et9WKnDMZD11St9AfMWrpclwtZ9fX/BVNeS8tIj2CpbFj3r1h3bUJUCRh?=
 =?us-ascii?Q?tFVT0oXT66Z/KuvZIkDISwA40jT9e+evi14sw/fj3NtrbW1EmTLsMaPGVrH1?=
 =?us-ascii?Q?8jR7yRdCsyaopERqdiW4mKizboHUgaUtkSA9juSlfZxAccc7Eqc9uirpfbQ+?=
 =?us-ascii?Q?hGRQvhAaCRqbKJZytUicTPrsmQGFix1kHJY9rJG7+GN0aEaqbXVqQaK3h6Cd?=
 =?us-ascii?Q?JanSzdpJxVGZn97uz54o9YAYb12MEiBwCYvcqyp6mJ7ZvitpyZs4syg20wF5?=
 =?us-ascii?Q?biqMle05S9xARxdhVNxKkw//ggOy4rlPWfc9y4ueWy61trMK+Xm6x4ggL/Oa?=
 =?us-ascii?Q?qMiDAQtcr3/rYlE0IByyVSWa82TAbivftZ2fBC1CtdcSI6DavWnT79q2B3C4?=
 =?us-ascii?Q?DFk5hFuerD0SIHFYFCAeECzJ1NlAiAQB5vQxWdTzaF3KdcJ22f/mQOHKl100?=
 =?us-ascii?Q?jRw1bA08QlJuxwH6FyRXyAx4SJ0YWv8P13Lj3wnkcLst9POxpAow9p67Z/KK?=
 =?us-ascii?Q?WmSBePO3tWyWoxtqhu6wSOXkVhOdah5z3QqjslJSsTA7m0j0z7hRFC5RpAiG?=
 =?us-ascii?Q?2GzafTgtUXZlqTU/OJPb56ko3ZVbPS9m13JmXozx/Wa0KOu4ijAtbv+GneZ+?=
 =?us-ascii?Q?KmMgvH9GmKAtTrYvVPqfqcJoU9gIV16bXSNfTDtHqqWMVR9AQYW40RoV2YWu?=
 =?us-ascii?Q?vX0OLbvSiTh41ntuCAP8ziJDR4seb8k1DnaL2vZbqL1MBgZBKAJgc9yjW0Mg?=
 =?us-ascii?Q?xua+1ehAvvhNK2tQDgcSQcapny1WbLEhLracdyFgmLnnsjO4z1pq7aZmQl3z?=
 =?us-ascii?Q?gPA3aJE/zixLT9uho1F8aOMCRetKJESveHG13D8kGiPKekyIWyVWsGh41+jl?=
 =?us-ascii?Q?0UJkEtsU10V3D0JS6qo+l7TGYjiZwJrx7bWP9/BVh8676B90iq/7YVOD8Gvv?=
 =?us-ascii?Q?xFhStsV9lQfbtf0P0SNkvKpc2yJCi4Y5tECoZQ26Tbl48FvJOaZL8oNieNwo?=
 =?us-ascii?Q?M1YXBAxe4xHV64MHD9/ihlkpA4U9CzKSKLCI9GSAE9J6Rt/AGfWL4yuYp+ig?=
 =?us-ascii?Q?quz+F4wCtWoZ2oRr3Xz3wZ+bta0g+Uh15sOz8XP7OtpF31HuoApuQfTyYFHV?=
 =?us-ascii?Q?LNN99mW3GBDpXCohrGaGh4F5jvPoVggh2GhlyBKH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52176c82-5829-4427-47c8-08db29979223
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 23:05:17.1487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AoS89YUGy4eZhrY0bYFbeFqPGcTvrovrBUnszpuzkAud1ZQ5OCpq4uzPMoyJwCUcAixXoEjMEhNP36TrOu22Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5367
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For kernels built with enable PREEMPT_NONE and CONFIG_DEBUG_ATOMIC_SLEEP,
> running the RCU stall tests.
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
> The above calltrace occurs in the local_irq_disable/enable() critical
> section call schedule_timeout(), and invoke schedule_timeout() also
> implies a quiescent state, of course it also fails to trigger RCU stall,
> this commit therefore use mdelay() instead of schedule_timeout() to
> trigger RCU stall.
>=20
> Suggested-by: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index d06c2da04c34..a08a72bef5f1 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2472,7 +2472,7 @@ static int rcu_torture_stall(void *args)
>
>Right here there is:
>
>			if (stall_cpu_block) {
>
>In other words, the rcutorture.stall_cpu_block module parameter says to
>block, even if it is a bad thing to do.  The point of this is to verify
>the error messages that are supposed to be printed on the console when
>this happens.
>
>  #ifdef CONFIG_PREEMPTION
>  				preempt_schedule();
>  #else
> -				schedule_timeout_uninterruptible(HZ);
> +				mdelay(jiffies_to_msecs(HZ));
>
>So this really needs to stay schedule_timeout_uninterruptible(HZ).

But invoke schedule_timeout_uninterruptible(HZ) implies a quiescent state,=
=20
this will not cause an RCU stall to occur, and still in the RCU read critic=
al section(PREEMPT_COUNT=3Dy).

It didn't happen RCU stall when I tested with the following parameters for=
=20
rcutorture.stall_cpu=3D30
rcutorture.stall_no_softlockup=3D1
rcutorture.stall_cpu_irqsoff=3D1
rcutorture.stall_cpu_block=3D1


Thanks
Zqiang

>
>So should there be a change to kernel-parameters.txt to make it
>more clear that this is intended behavior?
>
>						Thanx, Paul
>
>  #endif
>  			} else if (stall_no_softlockup) {
>  				touch_softlockup_watchdog();
> --=20
> 2.25.1
>=20
