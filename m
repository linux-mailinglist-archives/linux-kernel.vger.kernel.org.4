Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5EC692F5F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBKI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKI2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:28:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E6470BE;
        Sat, 11 Feb 2023 00:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676104132; x=1707640132;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Fq7kTDKOKAkU6VyZqhng2WJaL8wXQ5UgaRwFQq82BZM=;
  b=bzjwz0/DWNHfUs9FW5ektnEeeZ+Fl9vDAakqKnBWmo2V3FkT23rLE9mK
   gsL/hLXFFnZ5QCs/mqf8GvFpIiBonMCIu6oFqPqXfeCVDrPqO27kvQdMs
   orxImb2Sb7mCvl4XiI6jbFzwpUTQreaB4lVwUsOzy9hG0NGK73P4Iam+N
   /A//zr04x3UvnB6bZVU6P1yT50T2qa3Csn1N1m2Fmhu6K3iFclEMuP8Mf
   vNjnyqbLTQvmR7lmzquamsT4pe4zTHh98F8Sqg1Ki0wifU9Cs6bNDQXx6
   9cuScnGoNqJcbUD7qIUXWHlQfp+Z979/Z5r5vYcXNTXfXNr43zHbvp8tN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="314236532"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="314236532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 00:28:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="698653849"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="698653849"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 11 Feb 2023 00:28:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 11 Feb 2023 00:28:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 11 Feb 2023 00:28:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 11 Feb 2023 00:28:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 11 Feb 2023 00:28:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0LaT7akrvlZTzgCQtYzuadDXEsSG3Z6dY3mJL5SPrUJIwdGWnp7iLRQD3K6HPqXWU4EWccqPyRlxONzV04NcVos06SmE8y4gKva7RXZ0QvNU7cQ40KQiV8bhumcOSJFj0oihQd0A14haYOB5sIG41eoNlNBFhP86Q5lpuOkKLZo4r7Z3bVJrMLDC30h9zxq94y6yiXzX2nQSUrHBjJl56rGVxboJS9Ni6uuc5ycKvHGEvqa57tuEej3ZK0HYaUU+OcLbU36pEwfaySJ32nqtqJzYOnw6EE/pgHLy2BNJ0N+fV0T9Zob25BwBp19fq51kUKB1r4BypbN8S2bGFhMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IwsGE5do7SshsvbIJ8qCix7Fx4ionwU+6478fe0Esk=;
 b=a/+k0b7pQ2kFg7gX62o9vV8fj+FuYqwsp/tH9hhYfVcuTyeH2ftWKn0qq+Hy9z/w/QSv+5GAVt8BSh2Ha40du7onYfpnl7qmAfqX71n1HHPScEvKUZl4M8uuye8GvAPCLLMeAAW5Kjjv5tdnWcmGtmJkM10Gs3VNbAKN1193wGFLuciWmK+1+05Kd4LtzwyCgJUrkqMoXWNfaCN28IaZ12EanEzWXm+IW/ckbJr4IwzWxUgzqGCZXRRAK6rAKuLE3IzQtYgkYnOBzaaudX6YwreagIAYGtGGzbzoGWcl2FktZPAN1ssMI/p36aZX9G8rz6z0Er4sOtfuLI7Q2Qm+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SJ0PR11MB5792.namprd11.prod.outlook.com (2603:10b6:a03:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Sat, 11 Feb
 2023 08:28:42 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::52f:ae62:7fbd:600e]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::52f:ae62:7fbd:600e%9]) with mapi id 15.20.6086.021; Sat, 11 Feb 2023
 08:28:42 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
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
Thread-Index: AQHZPOfpehT8bN9fMkGXN/L3M8ggRK7JaM0A
Date:   Sat, 11 Feb 2023 08:28:41 +0000
Message-ID: <IA1PR11MB6171FFF325BABC76DCF2A8B989DF9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230210003937.1030753-1-qiang1.zhang@intel.com>
In-Reply-To: <20230210003937.1030753-1-qiang1.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SJ0PR11MB5792:EE_
x-ms-office365-filtering-correlation-id: bc9fb998-9e18-42a3-4c1c-08db0c09fb70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9iCpERMgPOh5lDUqqthpEenWjcDrDeUTGAC60FOhVSOfCqaWo77YXFNPBH/ztsAu9/SoArROqg7S2Fus105K5d6Zy50jJHD8u9N489YRHMjlaDLDvnsHZ0940HSWBg550WQNGYddKb9LnOz7dw1dqCiOHcL4Uzg7u+SaKfvDl5kG+mzFFr8PUGbwcRpLrGaBszrvseIN/XI5rsq9TPY4tQ2OR2b7UjM5Mj4w3hIBYZ2J/v0CjAg37diFqwJJuBFAlFR13wO4cpnfLmXBs7GVLKWTK10Ah6If5rK2zivSpWKonptw55SZ5nxYAMYdgQzaHKW/1BBDiOA+w1DwlnfRS8m/drqWp04H9d9ZYsKBrdJEsHNiNgcZsRi7NGbUaJgwF7ycgs7Hz+76gDAZ028m6QDiWrvaOj0q65zRtVnx21Ib6JgZMX3nVdP9FP88/F62QLn61RLUISi3jxjCPjsOFTfihyYLc+f8OiMdJpZhrPJUhfk/IaJLaJCG92xPHvSKeFuUPjEWw4+X5+lOKQ1Aq/azKXEruo+jV/LH7mj1SHqxmWIc05LUMbdAhNJvPwMfy42NvPHNqhSpVtYS02r9d+X1+z/WpjMW49aYt8SgwRF123kb19QXw0cdc2nQMesfDkBmQk4YxIjHsqjlXx30hwMaBeA9dWk6yqHpS7dFS7O+c5im2xkeckV9mtHKU6blt4SmaJp1/JKVkwBgUYViWqfhlKYkkXUhbaNtKBFElI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199018)(8936002)(2906002)(316002)(110136005)(66476007)(41300700001)(52536014)(66946007)(66556008)(5660300002)(66446008)(64756008)(8676002)(76116006)(38100700002)(82960400001)(122000001)(921005)(38070700005)(86362001)(6506007)(9686003)(53546011)(186003)(45080400002)(33656002)(55016003)(478600001)(71200400001)(83380400001)(26005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vjr5cURjvqgEB+aazttOWJOBwhySHi9ZSX72f8CzX9G+YofYSlUgmsV0G7WR?=
 =?us-ascii?Q?tLzZ2uJwJhp06UsOxK8RVFkRCugwWrrWWQrKNEGRHoj40e0r0B6rX9ZO1csR?=
 =?us-ascii?Q?Bn7/1VHNzsrasGMfMr+sSdy2jD65jze0aHBWKmaZVG/hg5Cf3fLMSnf0OtEc?=
 =?us-ascii?Q?Xh+EOQj2vNi6srgylS2U93ADZsdaboQSa4ViM3/bOr1CM54FAh23w+3sEatB?=
 =?us-ascii?Q?PNvWAEaUbrxJw2GPMp0Dwk1cKYp2yc1tqC3hNvElDDH0isWf4gl9uXg3pcNq?=
 =?us-ascii?Q?jlJ7LePtKwjTklJOb6ZACAFFPBo5jwkscn4a4bdic/G+uVCXMy8WM5j1pulj?=
 =?us-ascii?Q?J9va495oHsVEUHtm9z6+nAJiW2Wp3gl3BtDOmzTCD0ZQr+9LJIPO73kwQBFA?=
 =?us-ascii?Q?+L1iWpOpAc4PpMPTl5ON2ZUKURqYlXKmLO6nwXk0r7j3VlEhOAyFGuB3FIrZ?=
 =?us-ascii?Q?jFv9mWO463bYWb8pjp8rmzHUivP4w4UBRkTbfWMNRoUXZ+vHcVPQ6/WkgFQN?=
 =?us-ascii?Q?wkBRRhDqQtoub/ZerHQNnI3gcrK92QvRmJXyk1LqG7D3DhHOD02dQphVDnWc?=
 =?us-ascii?Q?454Yad3BgTXFBmLa700Hp3gndmu5qKJ1fSBNAgTSGsVGiKrrc1lXqcug/UpS?=
 =?us-ascii?Q?HiAlI7evvSEINx+PUiMqVeiUGUohSWcZ0VTZQEOjmQP14DMth2SCIsQqCRqq?=
 =?us-ascii?Q?909odSeaUr3oHP9dVzXwmxEp1jB+kITdrMqWYZjcOKhAGjV1/rq/7aSi2D3R?=
 =?us-ascii?Q?rgcue5EKWO65SZJ17qvLBbedL5KycGFb2eLpkhRLOjtLL3t111d1Lh3N8x+B?=
 =?us-ascii?Q?d4mCj66N2/JKkeW9RUOR7MqQ3o2fNu3aIXf6Gaa0XMNDN63DbxyoOPXUE3P/?=
 =?us-ascii?Q?wv+OP4Qj0AMlDztUIewtFnsN2lJRAnyJpZCu6FqepYtqe0/iyBQ61WG3EGol?=
 =?us-ascii?Q?BcAOKlNwOm8RXASmjhLmK7iaOmJ2GRfOoAPZAAo6A2UUt+hT3VKV9GszGcCe?=
 =?us-ascii?Q?ZNQfYNmQR/NjJwAs+FBH/7wxe2QqtJXdrKf3RGkQDBcmMD17SQNJFGVjxLPe?=
 =?us-ascii?Q?TQ0NosIIbuwMIz846RSmBOuQh7gNtVUmApQFASlQMmGefb5zXFnVTnM2owJL?=
 =?us-ascii?Q?Bs4/Uilf+DtEen3mBLM/B0KM1mkwcBH4IMbKbJV2KrMrR7arlh1HWmPCl+hX?=
 =?us-ascii?Q?HYcF4/LTD0gFz3WXCk5+sNq+al4DJ2fdgykVxKSiZWwOCIbP/x/3vkRtrXE+?=
 =?us-ascii?Q?OVDIFre8GCjl14NZcb0YxJr8vJdrTtYB8sFIlMeWML+5MaLVyN+NfkQyCwe5?=
 =?us-ascii?Q?w9Gh5yhJwfj2zlEyz3XGulEj+t+wl7b+VxsT79QBfAq+ENBDzr48xrQUViXG?=
 =?us-ascii?Q?viUXFOHAWIC8sHC2cg5sLDv4klKYJKqOfprATG4asrwTF/VTz79BhxbOFjQt?=
 =?us-ascii?Q?Ok1r04bEpEWef+1YOyvP9ji1iqsxqL7py4irWaBdZoMbz10pzGgna7ApOUT1?=
 =?us-ascii?Q?4yPaLvs773yLRuW5NyIlxdzjW1DeuANy15COFJLOEnyh9RRbtOkM5f5hlt5W?=
 =?us-ascii?Q?GqI8lyUTs07skbiiUhQRqeVWH5QtgkXjq/HcfLuT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9fb998-9e18-42a3-4c1c-08db0c09fb70
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 08:28:41.5424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87zH5pCWI5uBXNrHDKkpR3sPHvf7X3PowV6M5VCzCg2AXdjQmp+DyyBpcBrWvb/sa+hzaCFZtXgev8M9B4K/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5792
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Hi Qiang,

Did some quick testing using the same kernel parameters and the reproducing=
 steps as yours:

1) If not apply this v3, the kernel was panic like you found.

2) If apply this v3, the kernel did NOT panic and worked well.=20
     But a WARNING call trace [1] was thrown.=20
     Not sure whether [1] was another issue.

[1]
[ 2445.396928] smpboot: CPU 2 is now offline
[ 2445.399084] CPU2 attaching NULL sched-domain.
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
