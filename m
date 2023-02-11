Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20962693041
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjBKLVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBKLVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:21:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893F52DE5D;
        Sat, 11 Feb 2023 03:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676114494; x=1707650494;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=YQe+XOx1FaTS0aZ0En82z89ZebFjG5CmzQUwqvmrOH4=;
  b=mBPbn/gmpob2jhXQwkUBtWjp6UnnvH6dPxy3/2ctdqUYTUR2joX/JefV
   fw/tZgjppeelVtd05stLsTquh8BPv5cosgpK3sBQ+n8wvWRGlgNC3bTow
   LIFnuh/FnoVOSrFzTcDR6BtXWGS5hWO3u0BVSAn9dUTDfzd2pqPYXUWzL
   X/WY10E6eTdbum8TmR7UdhBDH9yC5Igf4C7LDAVKtzbvBl15wF0jaX9VH
   rf0/Ca3XofON/LxmlykRSwcnkqXmG/AaD/OrGWZ9hGcDXZ/JuduaNzTWt
   qwx1UUh+sN7EuOh/e+Q2jD4nrydZStjH7tKbB9vdYfymJ67E8YgYi5HeD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="332742948"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="332742948"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 03:21:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="698677873"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="698677873"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 11 Feb 2023 03:21:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 11 Feb 2023 03:21:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 11 Feb 2023 03:21:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 11 Feb 2023 03:21:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 11 Feb 2023 03:21:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQqmDEYGjx4e0g59DLUchp5buTMPi0GsxKQWKYSC/kaKccL6kMqw8yCsBx1RGLPpCcv+i8S/wtxURfAEPiee0z0gA5GXY52Ikp2xmVBjMx1AJjhF/J0m7mlvAcMD/VTrZWCfvkY8/0Twm1poan4AQ+mS8rWqVJtRNKmYWAc2fAyLdXXJq/Kb6/mP2ctgkEl+1HcuSrjQd3muxwn5iQwbyUKgUh4dOKqL2kxO32x/y/0iZyGcfhU8e0hyWuI/XyBgf/wwpcPh45+PERKTPhCqck2V2sAtYafVeGf24RCpfbLJ2Rr2JHCdUXszdPuDL4gbmVI0N4bD+ixV3J6it9RLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkNzt5TaZo6ypwqAMyjmFcN3tRqzW0AkO/ffnIomJiI=;
 b=aq9sYhkzKnNPODx6bUvQRImyT3makT7Obv6hyHkglSX5kAMX3ED89jHCCVJKPyKHsJCfRzTFL3i6f8YSXhHT/XiZc7P2HZdvg5/iZmf+lUTyr7QJz9R75k1JxjAR3kOZpBQVFEebhH+S6vEn7DIJZWAahq6Jj2lphsTD7VEstkhItMFO5E+eP7DaOzYLtho6QFQw48vzJszIEzjPNHKyWHzYbJf5FirW05lTkCH+4vqNeI20Lgh/I5qrqjF16ywEq1sdX3/tcVcwZCYpi9BMXYh9Mqdz2AWM8Qujsm+RlfM90gnC7GY97FDU81v76x4sV60e3KaPcOr0U+lJhxyE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH7PR11MB6881.namprd11.prod.outlook.com (2603:10b6:510:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sat, 11 Feb
 2023 11:21:30 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6064.031; Sat, 11 Feb 2023
 11:21:30 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] sched/isolation: Fix illegal CPU value by
 housekeeping_any_cpu() return
Thread-Topic: [PATCH v3] sched/isolation: Fix illegal CPU value by
 housekeeping_any_cpu() return
Thread-Index: AQHZPOfp1xcFgwN/9Ea8NQEmXkSFCa7Ja+GAgAAvg8A=
Date:   Sat, 11 Feb 2023 11:21:29 +0000
Message-ID: <PH0PR11MB5880EDD3D155F0596FB0C464DADF9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230210003937.1030753-1-qiang1.zhang@intel.com>
 <IA1PR11MB6171FFF325BABC76DCF2A8B989DF9@IA1PR11MB6171.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6171FFF325BABC76DCF2A8B989DF9@IA1PR11MB6171.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH7PR11MB6881:EE_
x-ms-office365-filtering-correlation-id: 3d88416e-12a0-4037-3ddf-08db0c221f80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f4SxwPIdl8ywzULF3Y/Q8CxZEUfwG6i36uqK9tY3AfaHXDykt3ERB+DFecVcuiTIfJ213GY0COtZV/8VJgdfaDTS5tRWymXbMPsMerQ+yZCzI/V7qZhy36XHsEwRDLkCsH+kv2kWYJA0AJyD/s+sXGWG9HgdpGHsSvx1farJjLWrCCC0C6QvX2lfgUuUNVs5H7dOrGLi3sM9HWXBIYi7TvzfDPPWN19g9oB0sLR2coVX7KKRL3bgUxmMukWdMN03P6CQH2g2bDYjyNb25qsVzrCFC8yx2etdnc6v7gTDjTyvAogKyWo3M864spWN+kllKn0qlipsscrzRm0KJGMZf1Tq6do+++qd/e82OzhTwSeJEoquUIosVgnjdDMNixqZElf5GMwFVDRzctdtizq6EX1QODxyw55PA7cDvnLGykc7UX54ix4PIIace6HnlxNzEMO1d/+TEd2dIR0DoX0WQzBztfRC7lxkBCjiO/weIADzuNOBhTLwmyhLsCdoa71XS/0h/iMI2GCG6ktrDDAu6Y2OmgrthH2MptX0IGE9eQWARH2C8Wxs7A32IDbuJ/SvrI3SjfVuCNPtORck5HyJxRouvITe3YkvyeYTamKGyF4oehp/OKqXridhcUOoRlE5oHAyXqOPlSj6o+MXlC6O+zK7l7LxP2sD9i1B0pgrgySQifN4WQu+eXYgO6PYbWsuYM1hxE/guTUIowfSPiaD8TU4Dhn6Y/qrCIzHAIU0/YY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199018)(83380400001)(38100700002)(122000001)(38070700005)(921005)(86362001)(33656002)(55016003)(82960400001)(2906002)(110136005)(45080400002)(316002)(41300700001)(8936002)(52536014)(66476007)(5660300002)(66946007)(66556008)(76116006)(64756008)(66446008)(8676002)(53546011)(6506007)(9686003)(26005)(186003)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A/hSEwzYQf5z3AzZDdFBAeUITiw/0ghWvwyaUvz3NG8qVPSVDD9/C8a2stFg?=
 =?us-ascii?Q?GebM1xOTbLl5+bAZ3d1CucHX5phtVfp3hfyh43z8cWZCYtkR2th7zkoRRS3a?=
 =?us-ascii?Q?uilFZWwH4G0tNHcde3gCxX6g8BqPPheL4Sv1nIdw0MDrbT2mUJuHiSeOcb9i?=
 =?us-ascii?Q?B3BhSzvFv/ydrfEMAW8Jl93PMoLcopp70TfNWpDkgIt4c0PdH0RtD93AEcMw?=
 =?us-ascii?Q?UGpc00B1tMczLvK/YcwvzN6EXzqQiNQVW3dk4E4v2ueKPkT6ioaUb6N+gBYY?=
 =?us-ascii?Q?voD6TNIDusGqJcBm5BuZWwWYCb36gKUVNOUksqyF8SgF8rRP1Lp02FxJCdgf?=
 =?us-ascii?Q?HaAP7OFzX07jIT9CdjeiN3pYtawJ+p/mhA/HCHF2UJYS/zJ8ZYgHTkqjr2fa?=
 =?us-ascii?Q?6q52ZsuzRrL2GKFXDKzut2pZHmPrtWOSMhtmpxggnCAJlYXOi3wRXgBEgTHN?=
 =?us-ascii?Q?lHDNhF7jnUFc0W2h6+bbW1YjmAq9G7WcCQItuKIWJ4NhxIUTwkEdeEdgUPEl?=
 =?us-ascii?Q?1CBwOtG/uHJg6qJhBQMP/d7gmU0bDRkDW2fRAsTQQJYZmKT6Ri1u7EOHSHVu?=
 =?us-ascii?Q?cXT3Uv6RBvWBZhWzKniplavx7YRP0B3YKHcJdvN1pFhz4JV+m1WcdJLdaqJw?=
 =?us-ascii?Q?4LhLfYRZvNt8kuQSyhq7THy8lgeyQuHXFifqFwpHd6MtPSyw7RY4G6bTpkuX?=
 =?us-ascii?Q?iNkoL9G+2muoMWJ24v7Zk24blKzUhwxVVH6rzUP2jgsoqWYCsKXgIHM9sTaj?=
 =?us-ascii?Q?535Qwj6iH7N+IbZI+7pFpwYPCqO9trYDHZQMp0cYNGz32FlQD1QWILEXVilk?=
 =?us-ascii?Q?3w3ot5+HqCuqmTmopAp9BTmWSD9jMmmxIgynqZeq3i7fCgm1kekCBG+LITsP?=
 =?us-ascii?Q?FslBmmcYul6M9PpXZHjsjpi5EDXaQk4zsgPPWTfpFhGZ5sgohBTvDKuVZMFF?=
 =?us-ascii?Q?/J6jD7ou5GBjPj3RBtSfPOoaKlLLpzLwPY+7ZoWnTJLT99uPjYQ1+n+2I1iH?=
 =?us-ascii?Q?KCNd4o0xq1iwK8dleubXqJrCHsdp/T0f/QaP7IupiQhXBDD5IM9DeOeyZxeG?=
 =?us-ascii?Q?1St118XG97hXAejqBH6AKVobCMQRchrLfHW0oYSxWJ6I0G/QG0mC61v+cuSq?=
 =?us-ascii?Q?dka4lLWG7hsneDHijlFf+8wCqfFX460784vSHRBQPrWhMG22fnX0PQ+Pl+la?=
 =?us-ascii?Q?BXgxViNUZoZnJp0zC8C0WgQsvvcYEFfxZmmSfgOJ5U28BEp94ONXyVGr8IWH?=
 =?us-ascii?Q?EI5etMNHSS4LA0ApyuIlJ9veDWhVfItI6aGgrGpE/4eriyyZ+zHmQ/ynHk7k?=
 =?us-ascii?Q?tJGFxPqtR0ldsOJMLzA1z1tCKS8BE2MM5mPpnUjB5Pzo/njkAR1w4xccm/cV?=
 =?us-ascii?Q?AQFoZd62EFwoBHO5V9HrhsVREqRJ+/FwLpRYFzvb3L5gFV/Hy05cBd472AbN?=
 =?us-ascii?Q?YH9qziSeYSTpShJOR06FbERyVxrmxNFbiq9Sn2phnYEAo1ei48vZPIi3w6X2?=
 =?us-ascii?Q?e+evOOVegnzE2fGnVH5fd9XC1A1d8yHkSVQtE8HwgFwcMEPwFPSnPiTG+3eg?=
 =?us-ascii?Q?3IC45QqIwvMpqtBZa31F0Nm1EsHY1vBmJ5oWwjM0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d88416e-12a0-4037-3ddf-08db0c221f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 11:21:29.9663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKdZB0sVc3r/DKU/DKA4936uBGS5xZEy+cITfqXAqe1dPB1gcS3FnbHKBpD/SstDYsArPKwvFZUxp9tdvdas3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6881
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Zqiang <qiang1.zhang@intel.com>
> Sent: Friday, February 10, 2023 8:40 AM
> To: mingo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com;
> paulmck@kernel.org; frederic@kernel.org; joel@joelfernandes.org;
> rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v3] sched/isolation: Fix illegal CPU value by
> housekeeping_any_cpu() return
>=20
> For kernels built with CONFIG_NO_HZ_FULL=3Dy, running the following tests=
:
>=20
> runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4" bootparams=3D
> "console=3DttyS0 nohz_full=3D0,1 rcu_nocbs=3D0,1 sched_verbose" -d
>=20
> root@qemux86-64:~# echo 0 > /sys/devices/system/cpu/cpu2/online
> root@qemux86-64:~# echo 0 > /sys/devices/system/cpu/cpu3/online
>
>Hi Qiang,
>
>Did some quick testing using the same kernel parameters and the reproducin=
g steps as yours:
>
>1) If not apply this v3, the kernel was panic like you found.
>
>2) If apply this v3, the kernel did NOT panic and worked well.=20
>     But a WARNING call trace [1] was thrown.=20
>     Not sure whether [1] was another issue.

Thanks for testing, yes this is another issue, if enable CONFIG_CPUSETS opt=
ions
will trigger follow calltrace.

Thanks=09
Zqiang


>
>[1]
>[ 2445.396928] smpboot: CPU 2 is now offline
>[ 2445.399084] CPU2 attaching NULL sched-domain.
[ 2445.399091] CPU3 attaching NULL sched-domain.
[ 2445.399202] CPU3 attaching NULL sched-domain.
[ 2445.399208] root domain span: 3 (max cpu_capacity =3D 1024)
[ 2449.731424] process 672 (tuned) no longer affine to cpu3
[ 2449.733332] process 509 (systemd-journal) no longer affine to cpu3
[ 2449.742278] process 541 (systemd-udevd) no longer affine to cpu3
[ 2449.745409] process 760 (bash) no longer affine to cpu3
[ 2449.748550] smpboot: CPU 3 is now offline
[ 2449.755129] CPU3 attaching NULL sched-domain.
[ 2449.755194] ------------[ cut here ]------------
[ 2449.756296] WARNING: CPU: 0 PID: 483 at kernel/sched/topology.c:2257 bui=
ld_sched_domains+0x104c/0x1430
[ 2449.758227] Modules linked in: rfkill sunrpc psmouse i2c_piix4 atkbd lib=
ps2 vivaldi_fmap serio_raw virtio_net net_failover failover sr_mod cdrom i8=
042 qemu_fw_cfg pata_acpi ipmi_devintf ipmi_msghandler
[ 2449.760804] CPU: 0 PID: 483 Comm: kworker/3:6 Not tainted 6.2.0-rc7-rcu+=
 #21
[ 2449.761820] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
0.0.0 02/06/2015
[ 2449.762931] Workqueue: events cpuset_hotplug_workfn
[ 2449.763676] RIP: 0010:build_sched_domains+0x104c/0x1430
[ 2449.764465] Code: 45 98 f4 ff ff ff 0f 84 1a f8 ff ff 48 8b 7d 90 31 f6 =
e8 17 48 ff ff e9 0a f8 ff ff 0f 0b e9 01 fe ff ff 0f 0b e9 b6 fb ff ff <0f=
> 0b c7 45 98 f4 ff ff ff e9 3f f7 ff ff 48 c7 45 90 00 00 00 00
[ 2449.766934] RSP: 0000:ffffab51c08f7c00 EFLAGS: 00010246
[ 2449.767568] process 737 (tuned) no longer affine to cpu3
[ 2449.768378] RAX: 0000000000000004 RBX: 0000000000000004 RCX: 00000000000=
00000
[ 2449.769079] RDX: 0000000000000040 RSI: 0000000000000004 RDI: ffff9486442=
d7f08
[ 2449.769785] RBP: ffffab51c08f7ca0 R08: 0000000000000000 R09: 00000000000=
00000
[ 2449.770501] R10: 0000000000000190 R11: ffffab51c08f7ab8 R12: 00000000000=
00001
[ 2449.771227] R13: 0000000000000000 R14: ffff9486424379c0 R15: 00000000000=
00001
[ 2449.771920] FS:  0000000000000000(0000) GS:ffff948777c00000(0000) knlGS:=
0000000000000000
[ 2449.772714] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2449.773303] CR2: 000055ed0e0ed158 CR3: 000000010091a002 CR4: 00000000003=
70ef0
[ 2449.774011] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2449.774725] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 2449.775437] Call Trace:
[ 2449.775752]  <TASK>
[ 2449.776053]  ? cpu_attach_domain+0x3d7/0x810
[ 2449.776532]  ? wait_for_completion+0xff/0x110
[ 2449.777015]  partition_sched_domains_locked+0x1e7/0x3a0
[ 2449.777554]  rebuild_sched_domains_locked+0x545/0x800
[ 2449.778032]  ? rcu_sync_enter+0x6b/0xc0
[ 2449.778377]  rebuild_sched_domains+0x1a/0x40
[ 2449.778728]  cpuset_hotplug_workfn+0x18a/0xe10
[ 2449.779105]  ? balance_push+0x51/0x110
[ 2449.779444]  ? finish_task_switch+0x85/0x2c0
[ 2449.779810]  ? __schedule+0x2f7/0x9f0
[ 2449.780134]  process_one_work+0x1cd/0x3e0
[ 2449.780495]  worker_thread+0x32/0x380
[ 2449.781436]  ? process_one_work+0x3e0/0x3e0
[ 2449.782006]  kthread+0xe8/0x110
[ 2449.782478]  ? kthread_complete_and_exit+0x20/0x20
[ 2449.783067]  ret_from_fork+0x1f/0x30
[ 2449.783566]  </TASK>
[ 2449.783953] ---[ end trace 0000000000000000 ]---
[ 2449.789269] process 741 (tuned) no longer affine to cpu3
[ 2449.794191] process 759 (sshd) no longer affine to cpu3
[ 2450.188215] process 732 (in:imjournal) no longer affine to cpu3
[ 2450.188457] process 733 (rs:main Q:Reg) no longer affine to cpu3
[ 2453.011183] process 659 (gmain) no longer affine to cpu3
[ 2465.517178] select_fallback_rq: 1 callbacks suppressed
[ 2465.517185] process 605 (rpcbind) no longer affine to cpu3
[ 2479.794154] process 652 (chronyd) no longer affine to cpu2
...
