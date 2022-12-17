Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C2664F8FF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLQNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 08:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLQNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 08:02:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F8A15F37;
        Sat, 17 Dec 2022 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671282130; x=1702818130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qNEfzLjMUCJCvCdBBFw+k8Msn3P6ILwKaB77bR2D55c=;
  b=ZE8z8dyr/G7/bBQA9F2fFdS22k6Ar8f1DVtIXzxnJ1GX5ZKF4U8UVH9+
   zHU9qlIZxOYUE6RzNnk9TxrzrN1M3rU9O6jgzt8r6H5wcQw2Kecz7D99l
   wfuOt1MbNcq+kNQF8VEVYdRy+Hm2Y3Xza89m2L0mFXKEImvfH1BdEmp0g
   7HbDQGB/1Ux5VqQYe98zZHSi8RExSggpWD4uiGhR+Xr/3cEx9fr+N+gRV
   /0tesLAeTKmwmb1COHqz1+f9VzOTNZB18l8PuhmLXo5ynb6o6Wpm/W6NX
   H9UkludNLZ48bkB0Zeq+L6rsch80ziwM/6ksi1A6MbRxSkUa+cq4f+QGR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="299459502"
X-IronPort-AV: E=Sophos;i="5.96,252,1665471600"; 
   d="scan'208";a="299459502"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 05:02:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="824393916"
X-IronPort-AV: E=Sophos;i="5.96,252,1665471600"; 
   d="scan'208";a="824393916"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 17 Dec 2022 05:02:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 05:02:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 05:02:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 17 Dec 2022 05:02:06 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 17 Dec 2022 05:02:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7FnS9muHTc3gxjJZlgvSBKV1I2nrn9VvtmdHI8qPbCgNYskoElJoxJeeo5DU0fZn3TyDW+eLT7SQZ+o7AREIPEXCodRS9BRsD01mwJDreCDx7fYBjqqFFjdzFOS7l64QiTUXAO3AVPbA2e1KQaFkGlTySXXxBcdGnp7YamI9hB+1E8YTq+XxlohAMsX1B5EhFPrBdILSezsGny0KlLlIJXphBbFPdovXq/4ySJegBspfwHyNIEtSomLtCQr08/hLzeWhz4kxMmyE8ziLuqYvy+OPuAPUEKE1oKezLYrGXeXACDYUDrU3gsLcUOu3g/7OKq9VyvbgUMcre1xqBP4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKdrp3sC+91aB0/C+sd/9/yiOo2oDir07281rql5I7U=;
 b=V463FojbKmbPa9+A75QnfLKjWNVgtAgJGtpdENgSwkEvoLA7kzFuQbozLWAtX1BtCpc2QyY5KMPg0gCYqrLeSs/wXkR/yDOhLWJxk+iC8/rARq/Bmv2msl5XZU98sg73CcxiZt+ZfUvJ36/wLWdtayuk7wbpg82otMo3n+sy0lnOy44CZpXi0pfUmQ+6a0v7MUCBTGEBlbH6Dgn1JFg6B6un216Nmdvj3vXPYViRmLVu7bwfUXUGClSXexvOeFie+v6kxE0ysR5ks5BeZJT5VqteDWriG+3VqnHkDiEydpl09mwwUgQoZHd6dzhD/HVNe3uHUerbkLiZVD6b7FyoVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Sat, 17 Dec
 2022 13:02:04 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 13:02:04 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Remove duplicate settings for rcu boost kthreads
 affinity
Thread-Topic: [PATCH] rcu: Remove duplicate settings for rcu boost kthreads
 affinity
Thread-Index: AQHZEGMOnvxGUFjU2Uq5+RiLJLzbVq5xR5qAgAABybCAAMOa8A==
Date:   Sat, 17 Dec 2022 13:02:03 +0000
Message-ID: <PH0PR11MB58806ABF242993103390A6F5DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221215090029.2972236-1-qiang1.zhang@intel.com>
 <20221217010919.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880B9403488CAB5DF9810FFDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880B9403488CAB5DF9810FFDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL3PR11MB6507:EE_
x-ms-office365-filtering-correlation-id: 82d22b41-450c-4a04-234c-08dae02ee4fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RSs8w8IYhcdsV3CVeik02ykJQGqpMGmVOvX6be/wtimKky+TTpDLjxqkWXHIkeknch37aQzZlThRXqaDP1t3QynEgE3zpyX53p8Cd/kMHk1aPehMyPAjzlO9vx1rpCGwbxQGG1t7eEwHK/Lc1dF1eJ9XHwOoRvBC1IDgbOBtpNHVGTKc06Y/QU1NNFsd6pslvpCQYV/4xfR+k9HXIENX3xy93rJWdAilxrK0JAMjcCUtb6U5pLkljLGoode1WV3Eo0h3Nf4ujfAdp/sfvLIUFZyLqrUA21UjxjCOGK63ymGM7OGMCiE/HaH6nsPfnvANLGwqdxMkR64/mHLPv2Vimc/z5jKTkMVYogiLdIV8aYfVAlbsgHxwJlU25zMCBPHSbGIIrOaEzVfb1MCkJoDF1/vfFfAkpKJXZkALCjHoliE9MqlOx4KEWlh8z+tZzfz1UUu6KzIhiKE01YxL2R/8eDQyWUscl3XqUta554t6foRxZ2T86bGV5u36Kh8/5touDJU7B1V3oMbET5SG40b3fN2F8SZ/G7efARy5zr7kKh02Ro2CkahxV4p1J2tYZO7Owq2oHChRSi/TRUf7wr/+643oTYc2U40F6VCk+wZQS1VGE8GY0+asnNXDrqwoKWCL6U0jF+tOd4iT6RBOor8AijCiwfV1OjJ1ZYeF+uPDlgjSoqhp0wnCDqX9nIzgagoQOJtWtU3MM2xdhkN1XY1jcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199015)(5660300002)(86362001)(38100700002)(83380400001)(66556008)(82960400001)(8676002)(2906002)(8936002)(122000001)(38070700005)(76116006)(41300700001)(66476007)(4326008)(66446008)(64756008)(52536014)(66946007)(2940100002)(55016003)(71200400001)(6506007)(26005)(7696005)(110136005)(186003)(54906003)(66574015)(316002)(9686003)(478600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kBmL0rPVInEFmYfmbWPie6Oam7ZHW56E7MwXTLlcS2te5Xv1ky/kjt4/vy6r?=
 =?us-ascii?Q?OwuYs08jnf0gw8r8eZ0hhRdHALnSj48L0cj5jbaNVy4+L8ANTRIYuFCfUJo6?=
 =?us-ascii?Q?q7TdFKEPmzWSsfAhQAxQypHVxZpebX6VxrHeVACqWuZhddxrbxkpDUmZNJ7g?=
 =?us-ascii?Q?glFnui+PlAZRVz3/JqygTdrvxmfjlKrFiRxCMj0R4ceSF2Ym2vAOJiWlZgZj?=
 =?us-ascii?Q?9IiOl07fLSpN5nsGunQHndKvfUzLqCNYnK0tX7TXDxpf+D6PYJPj76QFOKlP?=
 =?us-ascii?Q?AKlK4QuO2a2pm60McGH7FWYifz+MduMh1XBO9xHC4fcW+08y8WETm8urOu5D?=
 =?us-ascii?Q?sfIBbxpnyGAozodNLuFTqm2B55flBUZuznk4BLRYDehixJMRyUZv+6HiFzl6?=
 =?us-ascii?Q?CRyNvUIPmQlxGUEnrunIbeHXJ4BUODKRoGh9iPmdIHTKMDFqAtF1vP8jaB15?=
 =?us-ascii?Q?zLEUBBtxkXG3s5C6cesypMWUoecd4ZW9QIaotSsKNVtxE34YGnZ904ZrMUre?=
 =?us-ascii?Q?216aKw5Uji9dlhViH7zdbDxHRBh3pW72RS8DW7zubCEWe/0HiZEj7r5Xy3dX?=
 =?us-ascii?Q?D/ZVPtrsvlj2OjdbgvklkYJ6xvzXG6qsdeEICPtAsIdnQrK+f0gmTf1aLTJU?=
 =?us-ascii?Q?Vr3wB2UYz0ypcmYTl5RYrs64FSZVXIr+iBiG1S9rFtpZqRtNZtpwc2udA5Au?=
 =?us-ascii?Q?2ijckoPW7JwYSnGEdIOkFNHIhfqngKBmOoOSfZPDCuWEAzDy8MSjmkjgB0TK?=
 =?us-ascii?Q?Ugkm1OSTXSLLHyzqzAcTFGeVGs6ZqGfqrqPotTOw/5S6wm+TjgfVg4rYbQxc?=
 =?us-ascii?Q?KF9Xg2c8U8vOJ2J3cIidd1HgUeygHXlH16pB3GpEzwGdskgU8E04IYNIkQTH?=
 =?us-ascii?Q?NLq3Rz9+lvcsKXyHztS411ZAq+F+Sa7mWvQCoTrRlBH72DMWW7L0+mVuulXH?=
 =?us-ascii?Q?2ROnyH8diu6ZQg0mfilHbyQLBblStuzhi1QRdoh+LKfnodMUG97XyQU4nIqO?=
 =?us-ascii?Q?ztrFOvKVoMnLja/gTKOLPYtwXTiRquUWmpnRvhYxL5ndB2GAG3qP9ya9angw?=
 =?us-ascii?Q?1/kwT685GxGXEo8Xks02aKCtfqSDdX1/DlCYpwkzf8rlqYcuALEY0GeNo6jH?=
 =?us-ascii?Q?Zxq8oZzedallknBjsKeaRJl4mSweRToIgVtih76/6Gc08wlV7hN9ThARFPU/?=
 =?us-ascii?Q?TjdsGQWQqzSKapk4gL9CSHMuSERKp0c19SuTkYOOhmDfjj+VQaFo50lIYxcr?=
 =?us-ascii?Q?5HQx1I2U0Iyqh6Pf5BM8dsp2/qLiSu29iZ10P2StAXlcq/KxW5R1mMs6mYht?=
 =?us-ascii?Q?oGLKJ6Gs14/bnjL3iJYWOx25sbah23CmHYIzi57A2FJLUnAw26Igqh0FDRKJ?=
 =?us-ascii?Q?1q4IZCVtgGCnwjNgP6+pZlRQoSBcOUIsGaSRN5FYhJiWwAwvoQ4Elkbfd9IT?=
 =?us-ascii?Q?aXJN6iw3eNQU7JRQk8EEctQX5TnbOm+lFqqmzOG6rqsg0owcEEpExBIkhCAp?=
 =?us-ascii?Q?m/CaxHMLkZd8eLkOaiNlGoCizYqKe7x7yVyfTRp3fNUzR9uyHCwMnYIzaaP8?=
 =?us-ascii?Q?RzD2aAz6GZn4I/TyvrGSPBwNN8Bo4BLHhUFUDtn0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d22b41-450c-4a04-234c-08dae02ee4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 13:02:04.0593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTHKEsN/im4Y2yacwYyNvjOx5X4ULZMlObg2GV29QrVz5j86gqF3G751seCsSGs58yhFtWYNuqDEtmkY1UU/XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:00:29PM +0800, Zqiang wrote:
> Currently, when CPUs going offline, the rcu boost kthreads CPU
> affinity has been reset in rcutree_offline_cpu(), therefore this
> commit remove duplicate settings in rcutree_dead_cpu().
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>One question...
>
>Given that rcutree_offline_cpu() causes rcu_boost_kthread_setaffinity()
>to be invoked with the number of the outgoing CPU, but rcutree_dead_cpu()
>instead passes in -1, are these two invocations really redundant?
>
>Although -1 is passed in, but at this time, the outgoing CPU has been remo=
ved from=20
>rcu_rnp_online_cpus(rnp),  in other words, we will eliminate the same CPU,=
 which is
>also  we passed in cpu in the rcutree_offline_cpu() before.
>

I also used " qemu -smp 4 "for a simple test.

1) rcutree_offline_cpu()

(gdb) bt
#0  set_cpus_allowed_ptr (p=3Dp@entry=3D0xffff888100bd9cc0, new_mask=3Dnew_=
mask@entry=3D0xffff888100ce7cd0)
    at kernel/sched/core.c:2939
#1  0xffffffff811be169 in rcu_boost_kthread_setaffinity (rnp=3D0xffffffff83=
7a4c00 <rcu_state>,
    outgoingcpu=3Doutgoingcpu@entry=3D3) at kernel/rcu/tree_plugin.h:1250
#2  0xffffffff811cfa9f in rcutree_affinity_setting (outgoing=3D3, cpu=3D3) =
at kernel/rcu/tree.c:4297
#3  rcutree_offline_cpu (cpu=3D3) at kernel/rcu/tree.c:4341
#4  0xffffffff810c4e6f in cpuhp_invoke_callback (cpu=3Dcpu@entry=3D3, state=
=3Dstate@entry=3DCPUHP_AP_RCUTREE_ONLINE,
    bringup=3Dbringup@entry=3Dfalse, node=3D<optimized out>, lastp=3Dlastp@=
entry=3D0xffff88815b027568) at kernel/cpu.c:192
#5  0xffffffff810c6e24 in cpuhp_thread_fun (cpu=3D<optimized out>) at kerne=
l/cpu.c:785
#6  0xffffffff8111784e in smpboot_thread_fn (data=3D0xffff88810014c3c0) at =
kernel/smpboot.c:164
#7  0xffffffff8110c88e in kthread (_create=3D0xffff8881009b8b00) at kernel/=
kthread.c:376
#8  0xffffffff81002902 in ret_from_fork () at arch/x86/entry/entry_64.S:306
#9  0x0000000000000000 in ?? ()

(gdb) p/x *0xffff888100ce7cd0
$1 =3D 0x7

2) rcutree_dead_cpu()

#0  set_cpus_allowed_ptr (p=3Dp@entry=3D0xffff888100bd9cc0, new_mask=3Dnew_=
mask@entry=3D0xffff888109fc7948)
    at kernel/sched/core.c:2939
#1  0xffffffff811be169 in rcu_boost_kthread_setaffinity (rnp=3D0xffffffff83=
7a4c00 <rcu_state>,
    outgoingcpu=3Doutgoingcpu@entry=3D-1) at kernel/rcu/tree_plugin.h:1250
#2  0xffffffff811cf4a1 in rcutree_dead_cpu (cpu=3D3) at kernel/rcu/tree.c:4=
176
#3  0xffffffff810c4e6f in cpuhp_invoke_callback (cpu=3Dcpu@entry=3D3, state=
=3DCPUHP_RCUTREE_PREP, bringup=3Dbringup@entry=3Dfalse,
    node=3Dnode@entry=3D0x0 <fixed_percpu_data>, lastp=3Dlastp@entry=3D0x0 =
<fixed_percpu_data>) at kernel/cpu.c:192
#4  0xffffffff810c58f5 in cpuhp_invoke_callback_range (bringup=3Dbringup@en=
try=3Dfalse, cpu=3Dcpu@entry=3D3,
    st=3Dst@entry=3D0xffff88815b027540, target=3Dtarget@entry=3DCPUHP_OFFLI=
NE) at kernel/cpu.c:675
#5  0xffffffff827a5f6a in cpuhp_down_callbacks (target=3DCPUHP_OFFLINE, st=
=3D0xffff88815b027540, cpu=3D3) at kernel/cpu.c:1170
#6  _cpu_down (cpu=3Dcpu@entry=3D3, tasks_frozen=3Dtasks_frozen@entry=3D0, =
target=3Dtarget@entry=3DCPUHP_OFFLINE) at kernel/cpu.c:1170
#7  0xffffffff810c6ff8 in cpu_down_maps_locked (target=3DCPUHP_OFFLINE, cpu=
=3D3) at kernel/cpu.c:1202
#8  cpu_down (cpu=3D3, target=3Dtarget@entry=3DCPUHP_OFFLINE) at kernel/cpu=
.c:1210
#9  0xffffffff810c7906 in cpu_device_down (dev=3Ddev@entry=3D0xffff88815b02=
6988) at kernel/cpu.c:1227

(gdb) p/x *0xffff888109fc7948
$2 =3D 0x7

As can be seen from the above, we have set the same cpumask twice for the s=
ame boost kthreads.

Thanks
Zqiang


>Thanks
>Zqiang

>
>							Thanx, paul

> ---
>  kernel/rcu/tree.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 65f3dd2fd3ae..20de83ed0c7e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4122,15 +4122,10 @@ static void rcu_cleanup_dead_rnp(struct rcu_node =
*rnp_leaf)
>   */
>  int rcutree_dead_cpu(unsigned int cpu)
>  {
> -	struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
> -	struct rcu_node *rnp =3D rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> -
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>  		return 0;
> =20
>  	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> -	/* Adjust any no-longer-needed kthreads. */
> -	rcu_boost_kthread_setaffinity(rnp, -1);
>  	// Stop-machine done, so allow nohz_full to disable tick.
>  	tick_dep_clear(TICK_DEP_BIT_RCU);
>  	return 0;
> --=20
> 2.25.1
>=20
