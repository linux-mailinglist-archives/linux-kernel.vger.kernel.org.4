Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DFC62CF58
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKQAJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiKQAJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:09:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B36F3E0B6;
        Wed, 16 Nov 2022 16:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668643793; x=1700179793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6vxojuxbjWba1cpmAvMNmYCe5cc+sz8PwsPZqHgIlhM=;
  b=aeWeZKz3ExX8h/JS6qOeE0grhJL0zwcEYApz2lScHQgz75fFjGwX1uoF
   CcOFR/L2YBQDTubBaTZMZhrnkiCI4QIjgFct5E6rM71PqznumTCePwc2d
   jAIQKnm5+N+RQ5IZEifgcpNnfFp6eL8Dab5BzbGcRn4vFuTdDPTjphoTD
   0Hh+grrATI7mYLFn8wb14isxNfiFNT5GVbc1MsNC5KdKLOQqhXxHIYvyK
   5i2ZM0wWynNYBaQr4n9CD9PJT6oa5I1shZZdRCbQu9NyLDmrjn+5ACHc8
   +3nL6R22644RwvBUZQ0jlsOKltFYvX88wAuPNvL6UQIjy0bLzkHjdJsCT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="293100596"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="293100596"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 16:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="728585513"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="728585513"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2022 16:09:52 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 16:09:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 16:09:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 16:09:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 16:09:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCUs/Y+WIRoFzP8HKmmOkfYuRcia6C0JDCmAZCANb/e5BwKY451do3kEwosmw/zUKqbGGi/2HxpqD/8OG+vfu6cBEF1JRfiGF7S1MVD6fdmNPTXfeHCkJsTBIUME3Vx2rq448Mp3R8x3OD+2hcp4yM2NDCVlNAwKZ6JN/9DF9cRoMK/IUeyF8vM8i5e8Y7jou1JkFgY+DMMAWwmF/wPvq3rOeyF8Ioxh6pEy9ZDYR33or6hv4gpysj9bkcpEcpeqX2KvPWTUrRTno08lS3EbK5BqI1sZs7jpYTRa1e/5RDlJJRfsFPXs63QCLYeZp3MfJiplqM40xrqC+HG3vAO77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuwIMo2HfPen1xeJQTlTZlE2SmdYfbUXEizZOIdXJnE=;
 b=KvL3CW23wS5qjq138uQeXVu4GMpfcOXk0/f3IyaIfpfOd9nUTRkSrYKilBqIcfthCqSG2XKbXddzEFVszZoLp8VfWRRGEFcP2TS9dec6Zmw6QWBX29fxuw+HR8796SdrHSINHNUsAsJ9zwyn23kdJzZ08AN+XVuFS5DqYNIK/cK61ee1GQvLCqaGklT21WQq7eMwecQhv15qkBRQfInraOKC8aAuk5doLiAFM+TUmc+6OLpfdZSWXadD9ipjuyog6BxGqPfp8lnOb51EilF67MAVQAD+npVnPS7fjIOdp3ibLWHOVmjHJCtn60YqDqplHZ78L1QsdrH+ATNm9801RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 00:09:49 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 00:09:49 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
Thread-Topic: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
Thread-Index: AQHY9bjOyeVrXHxgy0el1PqNXBMQja45mfHQgAAOY4CAAAch0IAAX9cAgACDSgCAADxFgIADODMAgACTnICAAw2agIAAV46AgABFViA=
Date:   Thu, 17 Nov 2022 00:09:48 +0000
Message-ID: <PH0PR11MB588091693F801F00FD853220DA069@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221111102822.224-1-thunder.leizhen@huawei.com>
 <PH0PR11MB5880E3A11437CD0402941F4DDA009@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ed264f0e-bc13-5662-1a71-1458952ffd71@huawei.com>
 <PH0PR11MB5880FEAD72BAE59185256195DA009@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221111184238.GX725751@paulmck-ThinkPad-P17-Gen-1>
 <abff0a08-d5a0-6cea-ef69-c74a9aff8731@huawei.com>
 <20221112060815.GC725751@paulmck-ThinkPad-P17-Gen-1>
 <f056db41-daa4-0697-1baa-99121f2a43e2@huawei.com>
 <20221114160629.GC4001@paulmck-ThinkPad-P17-Gen-1>
 <d0b46074-2e89-faa6-11b3-bce6cdbd3916@huawei.com>
 <20221116195719.GV4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221116195719.GV4001@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH0PR11MB4775:EE_
x-ms-office365-filtering-correlation-id: b6a39905-8504-439c-0aeb-08dac8300ab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKq1pWUWG6g4g4hH5Nqeti3dQ7Q5eqlQgLRfrNGE2q6PuTolLutK9ndKQ1k6QIOkTYmiaXlHUAXUXRjOO7r4yczwoBFhUwgcdbSXolgN6Uu0qXLzww8//9/nMaCQ+iJYiXTPSyb8gu644x5J/fVelEDfJHt0tLAuEaKcJilSybF0/a2JN/n+LkhKLCJeyAX1rAw5sPMWrF3VgDBtt3dBD1004pTTdibB8Q7/1Qhp6gWdn6NS/FPw7IO9r8iLaT/FVV9DfnGOxyegrh/MpoxIG613IvKnu1W+psOBcVkPRFUf+VISrudggBzkENk6iwN4lRY3edn8sKTkMoloE+FA1g/uQhAj+NVNIsqZJZ9M/8/MeKnzsLyMAGfGFPRQ168t9+SHd/sa9NjGoLdQCgShQ46PtL3fc+hEriVdraiDZoaR/jZBs36R9w2XOitDl1MHIAE9IXK8Ha7kq1mpYyITiJeI5ff/cmc8su/mdgCb7l6cdn59PIyVj9AZ2XiEghLEsYddvdmhmmTvJ50zOJgnBerxU8kcX9dTx+cSo8+3ziJVxzk7sxpb1JyIX4KgUYSLdXNyocDj6VkrAHTHcP/K7Ah/rTjtDjWfjCE12NUmGr1ffEZhJdfhwB0eiKMlFmeblBsJni1xUm9TSoDzLSLKFCfzrxWEMNlFyga0hGo7khWHe11R7gXBTKYd7CdU6Dc7CV3BfN3tFP2rCCVKgT9AD4KblneStc9CLFnwLSwutk3y2047ZEv17lnU2FXWAUHcVar85GdLKMsdK9887F6CYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199015)(41300700001)(52536014)(9686003)(8676002)(66476007)(66446008)(4326008)(66556008)(64756008)(110136005)(76116006)(8936002)(66946007)(7416002)(71200400001)(2906002)(55016003)(86362001)(5660300002)(30864003)(33656002)(54906003)(316002)(26005)(186003)(53546011)(66574015)(83380400001)(6506007)(7696005)(38070700005)(478600001)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EXcE/lfepnmnl/rRFHfNvy3efYnAyEWi7gc+TN1NIwmtSqvaUfw4hjdyU40Y?=
 =?us-ascii?Q?Ha2VNOsa3yklO4Ozd+r4Ak4bsAyw4mldzkA6z7JZ9QPnRnMNxGpFszxvWeZI?=
 =?us-ascii?Q?V1ltipqZCkH6HM3A6XJgN/zCI3kHBoQS8rZqOpOIhQx5hlpS9D60urCM2klI?=
 =?us-ascii?Q?9K77Zo03twctVVB2FAEkNpDz0GNzC2UWaMOgfkIrjpTclKnt+MsDPP6g/1fV?=
 =?us-ascii?Q?4FQDieHAObhAEnJBmwMOFY/EKLjFB3Kr5GMX7JqVQWC3merhTfvHfY9KEB1l?=
 =?us-ascii?Q?mgr2djdsZV5lMp2g2g1YK/hDg3zdt7JKKKDtrTNfE8h6yq19ueinsvsQYjj4?=
 =?us-ascii?Q?iwJh+GuYyXvolq9LcxW8d+9Iqxmy1RjtW5uQmKofAUs6JzaFdUCjTjWn5Axa?=
 =?us-ascii?Q?q2lav+Vd84oVW91ki4awOPOxHVOD/RGdY3aLZqzTPIZnVrLKzU3G2k0KL5xL?=
 =?us-ascii?Q?uz8ewpa4gZdBQcpuNBzXURJWapgNLVtH7IM1PG8qkjZI1VOSmIGaYAInVhDv?=
 =?us-ascii?Q?LUu3VmbGtMYZJkG0UvgrjSsvBAJW8ylC5yZyWD4peQcRw291O4E51SLXQ3sg?=
 =?us-ascii?Q?3e407zdPdbes+Qo6svoVjMh9p/yLRhjY7DHjVZhE2FgT3iWkC1SMeEIIHJZP?=
 =?us-ascii?Q?jeO5pXXonmmEdfUTem/sNH6B9r0vXGvBxHty2GOP7xQ49j+KcXLUVXYKF2+v?=
 =?us-ascii?Q?o0rMf1rWTo4yQOh2dhh28wa+zS3SY60JeghlRoDPcvTzGJorsmbE3jIwEfkE?=
 =?us-ascii?Q?aYh/rkVB9XuytBpKwiuWqkCweXElA/EGF8XGNGZWXg3f97hl/HCumFGvViYj?=
 =?us-ascii?Q?4poVWIbrMEeq0vnN9ILQpHj/PmRWHn0RAmu69nqTJVKmDD6jNBKbSodd1Pr7?=
 =?us-ascii?Q?qKiiyMrdLS4/ZZFabwaI214JOkJWylyPY8bwbjY7D6MvYpyk+GSq3LhBa/Tg?=
 =?us-ascii?Q?Kl9VmmoKpa9hkaISBNCKrPoLgXB6GIS3n/cJapR3qB71SixoF5yD/uxG/2z1?=
 =?us-ascii?Q?QBVkH1xcqI/YtRI5LFO4yVKRix3Qedc6iAQO8BKTcbRUYB4srvcmteKYXKWn?=
 =?us-ascii?Q?U3wehu3W9qFov5Jrs62S3KizUYGvVddwL9TUx6cImq0NRh84RPljs93eEZzU?=
 =?us-ascii?Q?Rj0Vb1gT/9U5mFoUs/HpAJ2vPlEoN78kyaZdaaxi4mxbdktPrXgiO9/vdpv/?=
 =?us-ascii?Q?KOHtjCfxaN6CdWwrgbnzbGdbo9GXySpctQKyA1CoUBIKNwTXs0dKMb52qVma?=
 =?us-ascii?Q?coc48F00jRBxnE7mPB/goGW38nDjDIrhg9SIcSyiYIGuuTilWLwX7+3AdkWF?=
 =?us-ascii?Q?MjIGaS/pVGXH0bZnvZWBoXbeCC5rRomV9JsldV3psTCoE7UtWTNvx83qJNEg?=
 =?us-ascii?Q?ReJ7+GdG8nH0RqbuJSy9rOHc7VusK+XHqRM9bDwqmU6Gg/A+3uFle52+6yOa?=
 =?us-ascii?Q?L9hl5bmxNy1mcH9E7QaWIfvH6Z3SRjRlyB2PsIVRKcwGjYBKRqaeVLFLMdTt?=
 =?us-ascii?Q?/WscfDC6pLwYRQNhVa0rRjw3fCbZKC3V4uj+lUBPIOcC4yovqV/iPAGBcFKT?=
 =?us-ascii?Q?WMD7GJIzFmiGNA5La+E5MtCnROm9dza9Itz8iYgD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a39905-8504-439c-0aeb-08dac8300ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 00:09:48.9918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGNp/09a6ycqcSbhLzxz0Z1W8BFAjDtJ+5xQnlOEiLf+ICVzpntG6PX6+9WO87kcXdhuFyTJMBsEGTqmeU0ilw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:43:57PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/11/15 0:06, Paul E. McKenney wrote:
> > On Mon, Nov 14, 2022 at 03:18:10PM +0800, Leizhen (ThunderTown) wrote:
> >> On 2022/11/12 14:08, Paul E. McKenney wrote:
> >>> On Sat, Nov 12, 2022 at 10:32:32AM +0800, Leizhen (ThunderTown) wrote=
:
> >>>> On 2022/11/12 2:42, Paul E. McKenney wrote:
> >>>>> On Fri, Nov 11, 2022 at 01:05:56PM +0000, Zhang, Qiang1 wrote:
> >>>>>> On 2022/11/11 19:54, Zhang, Qiang1 wrote:
> >>>>>>>> When a structure containing an RCU callback rhp is (incorrectly)=
=20
> >>>>>>>> freed and reallocated after rhp is passed to call_rcu(), it is n=
ot=20
> >>>>>>>> unusual for
> >>>>>>>> rhp->func to be set to NULL. This defeats the debugging prints u=
sed=20
> >>>>>>>> rhp->by
> >>>>>>>> __call_rcu_common() in kernels built with=20
> >>>>>>>> CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy, which expect to identify the=
=20
> >>>>>>>> offending code using the identity of this function.
> >>>>>>>>
> >>>>>>>> And in kernels build without CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy, =
things=20
> >>>>>>>> are even worse, as can be seen from this splat:
> >>>>>>>>
> >>>>>>>> Unable to handle kernel NULL pointer dereference at virtual addr=
ess 0=20
> >>>>>>>> ... ...
> >>>>>>>> PC is at 0x0
> >>>>>>>> LR is at rcu_do_batch+0x1c0/0x3b8
> >>>>>>>> ... ...
> >>>>>>>> (rcu_do_batch) from (rcu_core+0x1d4/0x284)
> >>>>>>>> (rcu_core) from (__do_softirq+0x24c/0x344)
> >>>>>>>> (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
> >>>>>>>> (__irq_exit_rcu) from (irq_exit+0x8/0x10)
> >>>>>>>> (irq_exit) from (__handle_domain_irq+0x74/0x9c)
> >>>>>>>> (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
> >>>>>>>> (gic_handle_irq) from (__irq_svc+0x5c/0x94)
> >>>>>>>> (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
> >>>>>>>> (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
> >>>>>>>> (default_idle_call) from (do_idle+0xf8/0x150)
> >>>>>>>> (do_idle) from (cpu_startup_entry+0x18/0x20)
> >>>>>>>> (cpu_startup_entry) from (0xc01530)
> >>>>>>>>
> >>>>>>>> This commit therefore adds calls to mem_dump_obj(rhp) to output =
some=20
> >>>>>>>> information, for example:
> >>>>>>>>
> >>>>>>>>  slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 2=
56
> >>>>>>>>
> >>>>>>>> This provides the rough size of the memory block and the offset =
of=20
> >>>>>>>> the rcu_head structure, which as least provides at least a few c=
lues=20
> >>>>>>>> to help locate the problem. If the problem is reproducible,=20
> >>>>>>>> additional slab debugging can be enabled, for example,=20
> >>>>>>>> CONFIG_DEBUG_SLAB=3Dy, which can provide significantly more info=
rmation.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>>>>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>>>>>>> ---
> >>>>>>>> kernel/rcu/rcu.h      | 7 +++++++
> >>>>>>>> kernel/rcu/srcutiny.c | 1 +
> >>>>>>>> kernel/rcu/srcutree.c | 1 +
> >>>>>>>> kernel/rcu/tasks.h    | 1 +
> >>>>>>>> kernel/rcu/tiny.c     | 1 +
> >>>>>>>> kernel/rcu/tree.c     | 1 +
> >>>>>>>> 6 files changed, 12 insertions(+)
> >>>>>>>>
> >>>>>>>> v1 --> v2:
> >>>>>>>> 1. Remove condition "(unsigned long)rhp->func & 0x3", it have pr=
oblems on x86.
> >>>>>>>> 2. Paul E. McKenney helped me update the commit message, thanks.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Hi, Zhen Lei
> >>>>>>>
> >>>>>>> Maybe the following scenarios should be considered:
> >>>>>>>
> >>>>>>>                 CPU 0
> >>>>>>> tasks context
> >>>>>>>    spin_lock(&vmap_area_lock)
> >>>>>>>           Interrupt=20
> >>>>>>> 	 RCU softirq
> >>>>>>> 	      rcu_do_batch
> >>>>>>> 		mem_dump_obj
> >>>>>>>                                   vmalloc_dump_obj
> >>>>>>>                                        spin_lock(&vmap_area_lock)=
   <--  deadlock    =20
> >>>>>>
> >>>>>>> Right, thanks. I just saw the robot's report. So this patch shoul=
d be dropped.
> >>>>>>> I'll try to add an helper in mm, where I can check whether the lo=
ck has been held, and dump the content of memory object.
> >>>>>>
> >>>>>> This is a workaround, or maybe try a modification like the followi=
ng,=20
> >>>>>> of course, need to ask Paul's opinion.
> >>>>>
> >>>>> Another approach is to schedule a workqueue handler to do the
> >>>>> mem_dump_obj().  This would allow mem_dump_obj() to run in a clean
> >>>>> environment.
> >>>>
> >>>> It's about to panic, so no chance to schedule.
> >>>
> >>> It won't panic if you drop the callback on the floor.
> >>>
> >>> Though to your point, the ->next pointer is likely also trashed.  So =
you
> >>> could just drop the remainder of the callback list on the floor.  Tha=
t
> >>> might provide a good (though not perfect) chance of getting decent ou=
tput.
> >>
> >> OK, I think I understand what you mean.
> >> if (!f)
> >> 	schedule_work(&work);
> >> else
> >> 	f(rhp)
> >=20
> > Yes, except that the "schedule_work()" also needs to be accompanied
> > by something that refuses to execute the rest of those callbacks.
> > This needs to break out of the loop (or return) and to adjust counts,
> > among other things.  This might be as easy as setting count to the
> > negative of the length of the "rcl" list, but does need some attention
> > to the code following the callback-invocation loop.
>=20
> Yes, doing so would cause other problems. As you mentioned, the ->next
> pointer is likely also trashed. Some nodes may need to be executed in
> sequence. For such a weak debug function, it's not worth the risk, or
> overly complicated thinking.

>Do we have similar deadlock issues with the calls to mem_dump_obj() in
>the call_rcu() code path?=20

I think it exists, and also consider PREEMPT_RT kernel ,  because the vmap_=
area_lock spinlock
convert to sleepable lock. I have sent a version of the patch.

Thanks
Zqiang

> These are somewhat less concerning because
>they are invoked under a Kconfig option that is (as far as I know)
>rarely set, but still...
>
>							Thanx, Paul

> >>>>> This would allow vmalloc_dump_obj() to be called unconditionally.
> >>>>>
> >>>>> Other thoughts?
> >>>>
> >>>> locked =3D spin_is_locked(&vmap_area_lock);
> >>>> if (!locked)
> >>>>     spin_lock(&vmap_area_lock)
> >>>>
> >>>> Careful analysis is required, which may cause other problems.
> >>>>
> >>>> Or in new function:
> >>>> if (locked)
> >>>>     return;
> >>>> spin_lock(&vmap_area_lock);
> >>>>
> >>>> If there is a chance to dump the data, dump the data. If there is no
> >>>> chance to dump the data, do not dump the data. This is the fate of
> >>>> debugging information.
> >>>
> >>> My concern is that there will be increasing numbers of special cases
> >>> over time.
>=20
> The memory modules are mature and stable, so your concerns may not be tru=
e.
>=20
> >>
> >> OK, I got it.
> >>
> >>>
> >>> 							Thanx, Paul
> >>>
> >>>>>> diff --git a/mm/util.c b/mm/util.c
> >>>>>> index 12984e76767e..86da0739fe5d 100644
> >>>>>> --- a/mm/util.c
> >>>>>> +++ b/mm/util.c
> >>>>>> @@ -1119,14 +1119,18 @@ void mem_dump_obj(void *object)
> >>>>>>  {
> >>>>>>         const char *type;
> >>>>>>
> >>>>>> +       if (is_vmalloc_addr(object)) {
> >>>>>> +               if (in_task() && vmalloc_dump_obj(object))
> >>>>>> +                       return;
> >>>>>> +               type =3D "vmalloc memory";
> >>>>>> +               goto end;
> >>>>>> +       }
> >>>>>> +
> >>>>>>         if (kmem_valid_obj(object)) {
> >>>>>>                 kmem_dump_obj(object);
> >>>>>>                 return;
> >>>>>>         }
> >>>>>>
> >>>>>> -       if (vmalloc_dump_obj(object))
> >>>>>> -               return;
> >>>>>> -
> >>>>>>         if (virt_addr_valid(object))
> >>>>>>                 type =3D "non-slab/vmalloc memory";
> >>>>>>         else if (object =3D=3D NULL)
> >>>>>> @@ -1135,7 +1139,7 @@ void mem_dump_obj(void *object)
> >>>>>>                 type =3D "zero-size pointer";
> >>>>>>         else
> >>>>>>                 type =3D "non-paged memory";
> >>>>>> -
> >>>>>> +end:
> >>>>>>         pr_cont(" %s\n", type);
> >>>>>>  }
> >>>>>>  EXPORT_SYMBOL_GPL(mem_dump_obj);
> >>>>>>
> >>>>>> Thanks
> >>>>>> Zqiang
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>> Zqiang
> >>>>>>>
> >>>>>>>
> >>>>>>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h index=20
> >>>>>>>> 65704cbc9df7b3d..32ab45fabf8eebf 100644
> >>>>>>>> --- a/kernel/rcu/rcu.h
> >>>>>>>> +++ b/kernel/rcu/rcu.h
> >>>>>>>> @@ -10,6 +10,7 @@
> >>>>>>>> #ifndef __LINUX_RCU_H
> >>>>>>>> #define __LINUX_RCU_H
> >>>>>>>>
> >>>>>>>> +#include <linux/mm.h>
> >>>>>>>> #include <trace/events/rcu.h>
> >>>>>>>>
> >>>>>>>> /*
> >>>>>>>> @@ -211,6 +212,12 @@ static inline void debug_rcu_head_unqueue(s=
truct=20
> >>>>>>>> rcu_head *head) }
> >>>>>>>> #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> >>>>>>>>
> >>>>>>>> +static inline void debug_rcu_head_callback(struct rcu_head *rhp=
) {
> >>>>>>>> +	if (unlikely(!rhp->func))
> >>>>>>>> +		mem_dump_obj(rhp);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> extern int rcu_cpu_stall_suppress_at_boot;
> >>>>>>>>
> >>>>>>>> static inline bool rcu_stall_is_suppressed_at_boot(void)
> >>>>>>>> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c index=
=20
> >>>>>>>> 33adafdad261389..5e7f336baa06ae0 100644
> >>>>>>>> --- a/kernel/rcu/srcutiny.c
> >>>>>>>> +++ b/kernel/rcu/srcutiny.c
> >>>>>>>> @@ -138,6 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
> >>>>>>>> 	while (lh) {
> >>>>>>>> 		rhp =3D lh;
> >>>>>>>> 		lh =3D lh->next;
> >>>>>>>> +		debug_rcu_head_callback(rhp);
> >>>>>>>> 		local_bh_disable();
> >>>>>>>> 		rhp->func(rhp);
> >>>>>>>> 		local_bh_enable();
> >>>>>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index=
=20
> >>>>>>>> ca4b5dcec675bac..294972e66b31863 100644
> >>>>>>>> --- a/kernel/rcu/srcutree.c
> >>>>>>>> +++ b/kernel/rcu/srcutree.c
> >>>>>>>> @@ -1631,6 +1631,7 @@ static void srcu_invoke_callbacks(struct w=
ork_struct *work)
> >>>>>>>> 	rhp =3D rcu_cblist_dequeue(&ready_cbs);
> >>>>>>>> 	for (; rhp !=3D NULL; rhp =3D rcu_cblist_dequeue(&ready_cbs)) {
> >>>>>>>> 		debug_rcu_head_unqueue(rhp);
> >>>>>>>> +		debug_rcu_head_callback(rhp);
> >>>>>>>> 		local_bh_disable();
> >>>>>>>> 		rhp->func(rhp);
> >>>>>>>> 		local_bh_enable();
> >>>>>>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index=20
> >>>>>>>> b0b885e071fa8dc..b7f8c67c586cdc4 100644
> >>>>>>>> --- a/kernel/rcu/tasks.h
> >>>>>>>> +++ b/kernel/rcu/tasks.h
> >>>>>>>> @@ -478,6 +478,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_=
tasks *rtp, struct rcu_tasks_percpu
> >>>>>>>> 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> >>>>>>>> 	len =3D rcl.len;
> >>>>>>>> 	for (rhp =3D rcu_cblist_dequeue(&rcl); rhp; rhp =3D=20
> >>>>>>>> rcu_cblist_dequeue(&rcl)) {
> >>>>>>>> +		debug_rcu_head_callback(rhp);
> >>>>>>>> 		local_bh_disable();
> >>>>>>>> 		rhp->func(rhp);
> >>>>>>>> 		local_bh_enable();
> >>>>>>>> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c index=20
> >>>>>>>> bb8f7d270f01747..56e9a5d91d97ec5 100644
> >>>>>>>> --- a/kernel/rcu/tiny.c
> >>>>>>>> +++ b/kernel/rcu/tiny.c
> >>>>>>>> @@ -97,6 +97,7 @@ static inline bool rcu_reclaim_tiny(struct rcu=
_head=20
> >>>>>>>> *head)
> >>>>>>>>
> >>>>>>>> 	trace_rcu_invoke_callback("", head);
> >>>>>>>> 	f =3D head->func;
> >>>>>>>> +	debug_rcu_head_callback(head);
> >>>>>>>> 	WRITE_ONCE(head->func, (rcu_callback_t)0L);
> >>>>>>>> 	f(head);
> >>>>>>>> 	rcu_lock_release(&rcu_callback_map);
> >>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index=20
> >>>>>>>> 15aaff3203bf2d0..ed93ddb8203d42c 100644
> >>>>>>>> --- a/kernel/rcu/tree.c
> >>>>>>>> +++ b/kernel/rcu/tree.c
> >>>>>>>> @@ -2088,6 +2088,7 @@ static void rcu_do_batch(struct rcu_data *=
rdp)
> >>>>>>>> 		trace_rcu_invoke_callback(rcu_state.name, rhp);
> >>>>>>>>
> >>>>>>>> 		f =3D rhp->func;
> >>>>>>>> +		debug_rcu_head_callback(rhp);
> >>>>>>>> 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> >>>>>>>> 		f(rhp);
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> 2.25.1
> >>>>>>>
> >>>>>>> .
> >>>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Regards,
> >>>>>>   Zhen Lei
> >>>>> .
> >>>>>
> >>>>
> >>>> --=20
> >>>> Regards,
> >>>>   Zhen Lei
> >>> .
> >>>
> >>
> >> --=20
> >> Regards,
> >>   Zhen Lei
> > .
> >=20
>=20
> --=20
> Regards,
>   Zhen Lei
