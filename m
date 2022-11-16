Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3762C087
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiKPOIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiKPOIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:08:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D7B38;
        Wed, 16 Nov 2022 06:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668607653; x=1700143653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=816t2C6IzfBs+l7lKdULaXDgnpWEXX2bsqsuFDDb+7w=;
  b=NxRh7NXfYIHhAy7c2F+db1DkRRJ4sqXnaKjsHEJWgWvSHc8EuUzLtHHj
   XskfLy7lMqrovG5fW1Ptvn9qLFCsc0G8cUWrQoFw2WNhwpR0KDrc/3rY/
   k8H7OKYvevwFwLRCpt0mr05grvGwIYcOG23XLAOswpyo2v4j/AHWGSkEb
   cbWNNsCJz+3NOew2Ij4BY9xMctX8N0D+pWnc/gWwshWJhG92zONSTpZdw
   Bt+yGcL6rF2TiPo1rXucfqupaiM1u9kgyFxy0BA18oYK7XISiFrFmYQPJ
   TM3fKpqUBEIGFGn9Tpyqr1EKeSrSai7SW0wKuVX5LNeL+TxdMfXZgn9E0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339365539"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="339365539"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 06:07:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968436374"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968436374"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 16 Nov 2022 06:07:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 06:07:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 06:07:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 06:07:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 06:07:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEv2rXR4tuChFYuyP0W4lm918KWLZbuGsDIxdxUSAx7xrs4hEilHh2v9LXuSI+W3al21ruZTIpPE3PzMV9G4pfA4RgdE0ZPOLFUcnarVg0hL8PvhT1BhRWnQert6vM0a5t8CpekP3xJR7ohOp9o7BWvV9EoyH09+Kdb6E1R1Ligr9asLSMK+hverzy7ttWiYT4KOva4NOaE3bPZgmpfT/DLlvp1sGtAjgM22u36Kniy54qAKLErbF6BWnhb0Ikdo6cjoDiD9C8ZQFFbxepxi1bLtdkxLNaHi5Ql3YMndM0EZI1A0NPSo0n3H8Eakr5DHFLQ/9Cp2BF5poqp3fTYjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM/xj01x7t2Aot9TQKkMq3nQxMvfNftYYIdoQAjFTDo=;
 b=l6yVMXkxSVAVplJVGsLz6Y3oCQUwuwc5et5UMMmhZAi3DjVjpi5Aq6yjdQF/KoYxc4piRfs/2mu195CxBS6nHFbPmQSA+MS2nn/VR5r8ZygCmNCR4oMjn2Ngx/GbvRogHnjss02S5xzE/2YMnczwkl00W210NZytROKfW5h9i4izdN9o5v92rSTGCUNweS57qwIMQVLkRDqQAHT/RUOq/obOI8IQR3G6zGVWWkk/8jOBeyqMB8PcqYx2mjrb8TGLnehsnmbRDaWUCaPmFEYu5V5oOhy1gsmCeKmH0kYO+IZTAkxz7oUt74/Or2K22DCzpicm4Dug00N0y5gnvj4rjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL3PR11MB6316.namprd11.prod.outlook.com (2603:10b6:208:3b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 14:07:29 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 14:07:29 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Avoid invalid wakeup for rcuc kthreads in
 RCU_KTHREAD_OFFCPU status
Thread-Topic: [PATCH] rcu: Avoid invalid wakeup for rcuc kthreads in
 RCU_KTHREAD_OFFCPU status
Thread-Index: AQHY+PQlxGZ/hW5SmUe9kA4qPJUqOq5BgTQAgAARpnA=
Date:   Wed, 16 Nov 2022 14:07:28 +0000
Message-ID: <PH0PR11MB5880FD7499114743BCE3E5A3DA079@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221115131926.3409974-1-qiang1.zhang@intel.com>
 <20221116124716.GA813995@lothringen>
In-Reply-To: <20221116124716.GA813995@lothringen>
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
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL3PR11MB6316:EE_
x-ms-office365-filtering-correlation-id: a10cecde-9214-4412-b1d3-08dac7dbe5a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LnLrmUhpuqn82ex2QzxyRrbt8qXWQfka0GBpuVkWE107GVaLsiCOr16F4aZkjuFRuBF3iD8BDrXHKD2hU6ggvI2u0fQfZpz09Wz0zxfFEzJ90Ob7T1mhivovN5FetI/5dIP5eXhZHJpiIuDOlGtkXbBXr9nXoWXw6lXk9YX3rN7CDLCtKKxZrUqFk0enLrN4FeF0iPIo1v41POKbfoa8ak3NMR32z2BcsM+BCrZe4QuV5b/rwdImvjuBXpn7ejbKvx4AONXZ9cozID0X96wVhdf1t7U7Unf8VAuXF5Ne/9bcirq+/r0MEkbhJ4hslKNPtDWi1YA2cCVpuTdB/bygqu60iJ3VTRYIXgpRgcza9xYMCWw7AgeDBeym+VLf+YBlE7yuLmM9Oe9axCf0h1zh3vf18HIM4XeN6R8Zd1f4S070Q97Z/iD7QhIttS+80wrol7iNfrwsr/tqQEM5AbYVtK63IeWDZK7xwLODqMXE9leCKsmhQDXShUS9mzVju+6wmOieW4wEvdVn1YkArxy/VxjLliYeAgFnGfv+dAZP74hKSIyLceKdSRa4Z/B29Zg4LE5Oii2rCtqqfsACKMJZ9kRKG2U2nO9oMfO9bKdZgsX3cdXxzVgkQpnTU+LWaCXTwY66GwWWPH21epvBCL3Tvyz0KkwdxTqMXianVHvqYyOwkBEdguuQMJLGU1zd4SnyctBNP9TmPk47X9jrHLDpX0Y+rkHqVC1iN69d952yrpJNnPmxWIzPKaGrm8TCLUP7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(38070700005)(55016003)(33656002)(86362001)(38100700002)(122000001)(82960400001)(71200400001)(316002)(9686003)(26005)(6506007)(7696005)(54906003)(6916009)(83380400001)(2906002)(8676002)(64756008)(4326008)(66556008)(66476007)(66446008)(66946007)(76116006)(8936002)(478600001)(41300700001)(186003)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hF213PHs/2p7gtPSfGmWaW1qUCVwUC0UcOb6idLEaSG48tOnW7ZuNidfBUne?=
 =?us-ascii?Q?6X+9dZ4oG+uec0wrrVehPuERR+UA2tn8HwAqOYmSAH+9WokY7urhaLmQagFi?=
 =?us-ascii?Q?XLFNx/3USKLS16Yw55AE1AiRo56cWHFNdgLTPCsEZe36QyTqBKNnVJ7d0Jfs?=
 =?us-ascii?Q?ZaX5FKCsjbYO0eNnScm8fkCafu1GZzgjQl+yNTOuXoTN8Cs5FckIM2AlwoGQ?=
 =?us-ascii?Q?KjP+b/JEmmcrbwhJjI0Ra0tGu15EMg1DuV4nVNAiEipH9tz6DBOy8tJ8yrjC?=
 =?us-ascii?Q?nMpuDjLpi35nyXnGLGto5qNeFs+CLF1AtDQMxkjhmmGwMZT099pSUInb0WSb?=
 =?us-ascii?Q?aGgeI1qT+uVGNWU+VceGV5U90xjqU2C+YWOl7OlCKbqixyIzNclZtP+3ylUa?=
 =?us-ascii?Q?kGkgzue+BhrnFxu6AtNR//iQXqnO9geyMvg2HAAwzHGrIsA53v6vibJ5Deu+?=
 =?us-ascii?Q?SqsgritVrOZbIezFBkyyUj2M+J7JYXbvtT2TqZUPuEL59Y8ffc+Q+LdBhlbi?=
 =?us-ascii?Q?EH6C3H2zhlWtAhyPI/t3x9Mz4BKi2FjPAm4u7jco8mByKbJCCiHV3g5EiaEt?=
 =?us-ascii?Q?RiEtfPXgNYbJaiGLRPkrVJYZUo7XmdIw6zQq3TRFy16RwGVrFr6C1M9v5ZAC?=
 =?us-ascii?Q?3+pguz1gpHDfyxZo0cBb1KALRj/zOR96rLvkBlX2yuP9b0pItS3U6kYWQ4ox?=
 =?us-ascii?Q?IsBt8BZJoXKI4nq05z3us1cKjNr11INGMs6YmVJaXmWU7gyq+Hafz4f1nOGR?=
 =?us-ascii?Q?p4ur88S1eyTpjoG/YOy7TMtq/NfIM2UE7NLgb0EuaMx1fpvsAkIfqBqOjjzg?=
 =?us-ascii?Q?Tw6OOkpiW76DBItjE9z0PN1A78i04Y3UyOslU6CD/HUVuz9KEgSZgrYLVz6Z?=
 =?us-ascii?Q?JW2YYBBKemeLtK6LgrNvxCzZnKC/FRsSXS+rl+SB9mRVu82NX1djKCEqfq2e?=
 =?us-ascii?Q?kNIYFoqE9qysQnO+zqOEr+p0r/F5wwQ+1GQwrJFJJ3mtZa5zRkMshCiVXDCV?=
 =?us-ascii?Q?2iqnxdSnjQ+Ux39XzHOLgcBBXmo0KX+FnRtpyBjCyu6QoojcV+sk8DuKVnmQ?=
 =?us-ascii?Q?c9RJiSMep1GKE9b8Ube9rzUAuT3XpuhqPee1X0ti2VTdCMtYX+OwthdtSAto?=
 =?us-ascii?Q?jRgTGwvfH+X896og5Kwlls8/muHQVWrGUxitPdyZnshQJHNf9rFG1Se9rfGt?=
 =?us-ascii?Q?XxDJnFoLJYEksYZRog1/9fu6h9oQs+CACNGUOwQkMvB6Y4Vs1HW35MEv4PYM?=
 =?us-ascii?Q?PfR5gOjIqjS5SFyMCstjzjnFLWXRK03eeyIwceEb48A3E+eOhWaX5cy6+3xL?=
 =?us-ascii?Q?eOs3KQ/2yvKIV/AJl1P8fSixRKW0G2j1ZHm4GxT7WESrGPiDcFN4PMM1jOQY?=
 =?us-ascii?Q?9ty7c/OpaDUmEg5ZLwOCsYxUz+Sf+cm/Am3HsGJV/BBcy1p6LRX3r5+xBxPB?=
 =?us-ascii?Q?d9ybsknpCFbfq8yFjh9io0Dzv1etlbBqNf3Tg8rdcpdy/m66FGHboT27pYBd?=
 =?us-ascii?Q?H3Axef9AYLrqsl+P62osgXXz0G1dR5t0Tu95YKmYZoX+Oh/SK4k1CNNNxIxP?=
 =?us-ascii?Q?mBHvJm2/fgQqxh10Fumcrbet3LOX/GqhuABH9q5k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10cecde-9214-4412-b1d3-08dac7dbe5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 14:07:29.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UipL9qny9GM+OiFxY0vIexPBSixyYQVcWbmwgFtFkpegRxa7nGm4qrwb7WYEhSRSIPN5CsSspk0Nif5vjKVvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6316
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 09:19:26PM +0800, Zqiang wrote:
> For CONFIG_PREEMPT_RT=3Dy kernel, the "use_softirq=3D0" will be set, the
> RCU_SOFTIRQ processing is moved to per-CPU rcuc kthreads which created
> by smpboot_register_percpu_thread(). when CPU is going offline, the
> corresponding rcu_data.rcu_cpu_kthread_status is set RCU_KTHREAD_OFFCPU,
> and the rcuc kthreads enter TASK_PARKED state, kthreads in TASK_PARKED
> state only accept kthread_unpark() to wakeup.
>=20
> Therefore, This commit avoid invoke wake_up_process() to rcuc kthreads
> in TASK_PARKED state.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ccad468887e..49dd87356851 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2375,7 +2375,8 @@ static void rcu_wake_cond(struct task_struct *t, in=
t status)
>  	 * If the thread is yielding, only wake it when this
>  	 * is invoked from idle
>  	 */
> -	if (t && (status !=3D RCU_KTHREAD_YIELDING || is_idle_task(current)))
> +	if (t && (status !=3D RCU_KTHREAD_YIELDING || is_idle_task(current)) &&
> +				status !=3D RCU_KTHREAD_OFFCPU)
>  		wake_up_process(t);

>There is a tiny window where this can happen (between CPUHP_TEARDOWN_CPU
>and CPUHP_AP_SMPBOOT_THREADS) and it can't cause a spurious unpark because
>wake_up_process() only wakes up from TASK_[UN]INTERRUPTIBLE states. And ev=
en
>if it did, the KTHREAD_SHOULD_PARK bit would still be on.

Yes even if it did, because KTHREAD_SHOULD_PARK bit would still be on, this=
 kthreads
will schedule out again.

>
>And more important! On unpark time RCU_KTHREAD_OFFCPU isn't cleared. Only =
the
>rcuc kthread does it, and after your patch it couldn't be awaken to perfor=
m
>that, unless rcuc is lucky enough to have rcu_data.rcu_cpu_has_work =3D 1
>by the time it unparks and that isn't guaranteed. So rcuc may sleep foreve=
r.

Thanks for review, yes I should register an unpark function to clear RCU_KT=
HREAD_OFFCPU.
Is the following modification more appropriate?

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3ccad468887e..a2248af0ccda 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2375,7 +2375,8 @@ static void rcu_wake_cond(struct task_struct *t, int =
status)
         * If the thread is yielding, only wake it when this
         * is invoked from idle
         */
-       if (t && (status !=3D RCU_KTHREAD_YIELDING || is_idle_task(current)=
))
+       if (t && (status !=3D RCU_KTHREAD_YIELDING || is_idle_task(current)=
) &&
+                               status !=3D RCU_KTHREAD_OFFCPU)
                wake_up_process(t);
 }

@@ -2407,7 +2408,14 @@ static void invoke_rcu_core(void)

 static void rcu_cpu_kthread_park(unsigned int cpu)
 {
-       per_cpu(rcu_data.rcu_cpu_kthread_status, cpu) =3D RCU_KTHREAD_OFFCP=
U;
+       WARN_ON_ONCE(cpu !=3D smp_processor_id());
+       __this_cpu_write(rcu_data.rcu_cpu_kthread_status, RCU_KTHREAD_OFFCP=
U);
+}
+
+static void rcu_cpu_kthread_unpark(unsigned int cpu)
+{
+       WARN_ON_ONCE(cpu !=3D smp_processor_id());
+       __this_cpu_write(rcu_data.rcu_cpu_kthread_status, RCU_KTHREAD_ONCPU=
);
 }

 static int rcu_cpu_kthread_should_run(unsigned int cpu)
@@ -2460,6 +2468,7 @@ static struct smp_hotplug_thread rcu_cpu_thread_spec =
=3D {
        .thread_comm            =3D "rcuc/%u",
        .setup                  =3D rcu_cpu_kthread_setup,
        .park                   =3D rcu_cpu_kthread_park,
+       .unpark                 =3D rcu_cpu_kthread_unpark,=20
};

 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index fcb5d696eb17..c4b9606968db 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -36,8 +36,9 @@ struct rcu_exp_work {
 #define RCU_KTHREAD_RUNNING  1
 #define RCU_KTHREAD_WAITING  2
 #define RCU_KTHREAD_OFFCPU   3
-#define RCU_KTHREAD_YIELDING 4
-#define RCU_KTHREAD_MAX      4
+#define RCU_KTHREAD_ONCPU    4
+#define RCU_KTHREAD_YIELDING 5
+#define RCU_KTHREAD_MAX      5


Thanks
Zqiang

>
>OTOH one cleanup that could be done is to make rcu_cpu_kthread_park() to u=
se
>__this_cpu_write as it's guaranteed that cpu =3D=3D smp_processor_id().
>
>Thanks.

