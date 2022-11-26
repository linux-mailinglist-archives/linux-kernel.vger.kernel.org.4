Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0767D639379
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKZCoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZCoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:44:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAD829CA9;
        Fri, 25 Nov 2022 18:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669430669; x=1700966669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eaco7sWedfpyKq3RgvOen8821z2bXtUYjykD9RCs/ZA=;
  b=NQ8jBQ6QnMAb/TAGgyS9AZsYcpxa8JgHfRPX9fCxVhPkb3sqChFPaYYF
   UDt5oMJAS3hT5XlP2ITmFekW4ASBjJoOXJyvjsnxgHYU2Vr24UmwlsW2U
   wvAmUiZCji6zlnvLdTEWFFsGmHiO7MyWBljzqELMKm4Xf52Z2EEdTfJ18
   EyoJLVjHCz5O6l413gvViZJS8V6L5KuCEMoEtCEbPTKJSfxmwPArH/sKa
   M5WW5aViirlhzcH50DGRVIlgjjZmdqv3J3EhXdl0N9JJHzDWNPNnQ3Na1
   zBGCpZcxcq0RBAaQw0qjsiewpHX57zjTfPyvGX3xj13GjkvmIxl4tgLnP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="315718964"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="315718964"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 18:44:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="817277143"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="817277143"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2022 18:44:05 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 25 Nov 2022 18:44:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 25 Nov 2022 18:44:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 25 Nov 2022 18:44:02 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 25 Nov 2022 18:44:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+Z9Xn2KwWf3wHq+dntqXVKkS7lDGYgXO4CyZhY8G3FopxZ8Ezqxm80J7mpaomUum0cgt77kUxLKRvLbCmWpXkp59uaKpizA+KzZ0R8fxFP1idvaBhtH7lNsdb+3vVR1boS/aiUoCT6hCdCt/Ys57USVj0NGrfaY5ZeIJdb8bYF+5zO7B7p/gCcF78yZje9BNGfkg+unaZRgFUi1hDYqF8VJtcn/loxvNruyJUB7oU+Ru8Hno/DQCJNFGouHPoTdr6f8LTuvXyV6ilmuXxj5GOiiB/fZSwvdosbWpbWX1uWDwAeVRc+8PqHiF4GpRoryTETwz9jaEh3L0MWSxYhDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh5DaLaWNIdXbWTaEmnFlSIpOWYAjuyT47yWQl8njOo=;
 b=cuCLbEuYgvGpCrwq7arYiqZ32zxSNVFD8AoMs+L4bq0m2YHxPrs3jpg9ZWBWOmzNAqC4yxCQuHOuKz8IJJaz5D7QwCKwNj9foFHrl7yttBCw8jEqZ22oqvA2qnX3gW729tgWnK8hCxPrXk/EC90MsTotjqSmBLPKPkgc9XnrZw0yQMXUsH401nzhnzMct+vBX1wBACZg0uVAUT73/IcFgEuU//DnUYJZSr9Yz5evzkjuPKztyXVIBw3jw8tk7FCPl6m/VynljwCg916jrIKL6pgjuMuZ3kCaV1uTdh+uVZuKizno+RPvEwpbR+DjDLXFG+4umAM2BUmwyjemJPmFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Sat, 26 Nov
 2022 02:44:00 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%5]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 02:43:59 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Thread-Topic: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZAOVqO+x1XL1ptUSqdc8Q343Nzq5Qe5uAgAABlKA=
Date:   Sat, 26 Nov 2022 02:43:59 +0000
Message-ID: <PH0PR11MB588009DA52C17BAE7388F99EDA119@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221125155427.1381933-1-qiang1.zhang@intel.com>
 <Y4F5r9nLDtCrl6df@google.com>
In-Reply-To: <Y4F5r9nLDtCrl6df@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ0PR11MB5214:EE_
x-ms-office365-filtering-correlation-id: 0e4eec21-7610-4309-f7b7-08dacf58126a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9MfZowVqJX7bodX5f31rdpbPCGz/lfPN+Vniclq4zAK8pPYBB8YleGBN1ChcHvja41ItiHpvlofkxRz3fsVGOpPdBYeXJp7t6ywkFq9O2z/cAgonGTHMvHMDSBvMax8PZfQvTgtv8ChvqEGidaGfBsSNS0n7UzoBSu7+uqjN8PduypvLRO+Cv7Bigpvx3tyTYlAC1t4X4EcivNfDUgtfvVasxP7frMQWBoOmNCGwlRHSt2udM2pjR/CVKXp1GSbsYV0FpP0hl3uUdGWnUXSvGcpwt5IifL65DCX47aWuRIaH+w7lzVPeNsfilNi9l1m9FfbFKEdokaCsua6+sqckIpN5W1WbZ8pXIIOXqFQ3fOvd1VmxF+kyR+PzQUMcQgvXkkfG7KZ4B32z3umx9YVld0WH+MXZomuZ2xDYU1Xe4MWDAmdJISBGV4zDBIR44aHz1sP1Mf3n2SKutC9SOVfJDlE6aTzEwbng8snK59DNtfNiVv8ubt0YWp6uEHQM9f3sumJv/Bpu3Jcpt8ktERDfxtm1NsdxtcdEqzc4rrQVT1TeO5UtXWpw34PHFbLYSRpcWFcjzjJa3QZ8E7qr4CfdtRARuvW6y52GnPP8HUiybq1i+V3mF9w60fk4aAxE3G/ovUzVdhYqQsTV6GGCrdREUGZrfmZ270pM9RwUvDxPGJl1Zal6ses9LekTjmgRlYtZ+mUyYRmUxcnjsnZX/qrEMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(2906002)(76116006)(41300700001)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(5660300002)(33656002)(6916009)(54906003)(71200400001)(8676002)(4326008)(52536014)(8936002)(9686003)(86362001)(478600001)(6506007)(7696005)(26005)(186003)(38100700002)(82960400001)(83380400001)(55016003)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?07+g1mLh+/AX344xeaXxpkR9ncosF8OTVW6INtFaEjd8//AKOBTiodBvLFHQ?=
 =?us-ascii?Q?KBzMDwNk3bb/WPjPMtoG8D3qs4e+358t8oAw5Gb/8MCm/g3ZeOEiU5iDDoN9?=
 =?us-ascii?Q?HqdEOJ5bxKyhMk6Et6HjYgopZCR5xWOfj861Z0SdQvSji5ZYaCL2xEHlBIBq?=
 =?us-ascii?Q?6fehHwQbVzNqd2wuJ9jMdS850UtQhaBgetYvQPGMk2pwKXpa5Tl1bHEy9kKF?=
 =?us-ascii?Q?nqxV40bK3NmuH8pi3+k1Nh3fd16OwolOjfO4af+WFgrFU0SaEHymYfNsH30u?=
 =?us-ascii?Q?5lrF82ZTUc94HsrQrC5UR23yy45LxztxP6Tyw/FY5iiuNdQuzZKSBngpf2uw?=
 =?us-ascii?Q?FyT4eT8GBMZxkbcAcI1jJtb5c2+f4eWabnxBYoHafHjy22ziK57tCxBmUkpb?=
 =?us-ascii?Q?gKgn8deg9oZutKqq9zP6yiGvHm/NqDmIUYyMDjwphT25BozHPOuLAdEGd69b?=
 =?us-ascii?Q?rRmJ+3QuWP/jj4sCCwH0pEz7+7jsgKzz621hT2qy6UEDe4PChx80o0moB2gN?=
 =?us-ascii?Q?WwsbumJF1kgUFWHcZE2zGUK+fICIhzifiPQGA+GlM65biz3G228RYf2QnsYR?=
 =?us-ascii?Q?C0N3PENxu3on1xQv95/+QEgaE+7mtEDcA+Y2uOOXwXev80AnrId51V8jPrRJ?=
 =?us-ascii?Q?3yzkVU2L+KkT+XrBgt46T7iFNxr1DyNzjl3XGlrXv3xIKzt+6Os4nkciyECK?=
 =?us-ascii?Q?YL0bjfDQuEqGtmyghIVDgxEeOgNXUazoUOFVHwDhuARWmZhdQft2xTid+JJv?=
 =?us-ascii?Q?RuW/KabWhkyhDY1JhYIi/9B+y4diWAmh/grvRDYPL6DDc+xQjADcHaSVhrh4?=
 =?us-ascii?Q?BmT1uRychf2Aaaxv50pclcHrht1btc4J0f1LpGvE6V/XvXA9vkBp3hCznSgy?=
 =?us-ascii?Q?OS9lXl85rgVSzCVTMgBt9PcLk9Nh3lefTRNjuHbaQoPJALXq6RoY4kGDe0zw?=
 =?us-ascii?Q?T9NM+VAZczLr/wT+EPtR6gxUIpIz+xZXLTBr+AsNwtHxKya3TwuiYmz30ccb?=
 =?us-ascii?Q?vVIa/r9MI80025VKsfdK1LCglG9sWDXeowf4VFSOI6Q5zuFUMWW0x7Y9Eku1?=
 =?us-ascii?Q?5TiI8DTpdQJM7gmchAIpJ4u/rM0zF7IQpi/QTzTBsJhz2wE0WqT1KrVZyQ0h?=
 =?us-ascii?Q?lAyDiUpry4hZv9m8gRdKtlKj0yzSR03LVfu+XQrjBfYdIpWuQol+n37YMinW?=
 =?us-ascii?Q?YZ7NMzCTy0i3g5mrISh4fULVZzb0nnxufc8IQUH0OCSFPXoeCpULaxSbZVuf?=
 =?us-ascii?Q?9F2jBpZMN9bMZQHFIfFkcpviDHw/AIfm7vtrLbG2OaQB3ltnr4LIICfLYFLu?=
 =?us-ascii?Q?Boji37LPwhBOAB4RZaXqcy1iAoUbGcA2vARS+AuzhZkGFViGNjTzc3cHUA0S?=
 =?us-ascii?Q?IJQg+GAUnyQz76xbpV/mIlhVKPbviIpl4VLxsd6aflR4EKXHAibuDJa+1RSB?=
 =?us-ascii?Q?PhBi0HJXgCdJ+O0pyvdBkijEKxyr2lF6dFguwHBiHPT206kq4XTxqnfjNW4+?=
 =?us-ascii?Q?ZPQgXc+/uPRP3L8fxsnn+EIqED+eFoNJFQPTdnPa+xvWDq37f3eSN0u1ikaU?=
 =?us-ascii?Q?wh51OnbYxZ8ooq/rV1pIMjszMsgx2dRtEhuY1tsF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4eec21-7610-4309-f7b7-08dacf58126a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2022 02:43:59.9105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGzZamBlbmlMurP4YpmjWCuGX4b7yWokSkdb/HUaNwHDr2YDiOY10cgvADvk01Og+7ehEDOqfYb+bB2ckJoQMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214
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

On Fri, Nov 25, 2022 at 11:54:27PM +0800, Zqiang wrote:
> Currently, for the case of num_online_cpus() <=3D 1, return directly,
> indicates the end of current grace period and then release old data.
> it's not accurate, for SMP system, when num_online_cpus() is equal
> one, maybe another cpu that in offline process(after invoke
> __cpu_disable()) is still in the rude RCU-Tasks critical section
> holding the old data, this lead to memory corruption.
>=20
> Therefore, this commit add cpus_read_lock/unlock() before executing
> num_online_cpus().


>I am not sure if this is needed. The only way what you suggest can happen =
is
>if the tasks-RCU protected data is accessed after the num_online_cpus() va=
lue is
>decremented on the CPU going offline.
>
>However, the number of online CPUs value is changed on a CPU other than th=
e
>CPU going offline.
>
>So there's no way the CPU going offline can run any code (it is already
>dead courtesy of CPUHP_AP_IDLE_DEAD). So a corruption is impossible.
>
>Or, did I miss something?

Hi joel

Suppose the system has two cpus

	CPU0                                                                     C=
PU1
					     cpu_stopper_thread
                                                                           =
       take_cpu_down
						    __cpu_disable
							dec __num_online_cpus=20
 rcu_tasks_rude_wait_gp                                      cpuhp_invoke_c=
allback
	num_online_cpus() =3D=3D 1
		return;
       =20
when __num_online_cpus =3D=3D 1, the CPU1 not completely offline.

Thanks
Zqiang

>
>thanks,
>
> - Joel



>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 4a991311be9b..08e72c6462d8 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct =
*work)
>  {
>  }
> =20
> +static DEFINE_PER_CPU(struct work_struct, rude_work);
> +
>  // Wait for one rude RCU-tasks grace period.
>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>  {
> +	int cpu;
> +	struct work_struct *work;
> +
> +	cpus_read_lock();
>  	if (num_online_cpus() <=3D 1)
> -		return;	// Fastpath for only one CPU.
> +		goto end;// Fastpath for only one CPU.
> =20
>  	rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
> -	schedule_on_each_cpu(rcu_tasks_be_rude);
> +	for_each_online_cpu(cpu) {
> +		work =3D per_cpu_ptr(&rude_work, cpu);
> +		INIT_WORK(work, rcu_tasks_be_rude);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(per_cpu_ptr(&rude_work, cpu));
> +
> +end:
> +	cpus_read_unlock();
>  }
> =20
>  void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
> --=20
> 2.25.1
>=20
