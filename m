Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3F765064C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 03:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLSCVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 21:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiLSCVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 21:21:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC695B8;
        Sun, 18 Dec 2022 18:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671416468; x=1702952468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aTpVgaDyZ0Ai9pV5+iNhtdAma1FWl2noFny0r6zLvzg=;
  b=EkEzHX5fHv5TwS+mzKmXPQr++Huqd9SjyAO9inwkTk0BS7CwSVnVUREO
   uJ5wPoxS3dk1+n7SDCnWvqB6HqSch8EiVGg0FZVZKNAumonxxGGfoSf0y
   zBgOSHgcGRHaF3hWkp+zbPSoybQnAsnw73Y67SYEJvFiPxNbeuHttftbW
   /RHzy/Q7ZRCqGeMw3mnomCH7qszCnozeBmEgXemQ3PPoMzkqBIbfs3tzy
   PlN2XZ2LbYHScVGLns13XMR/Xdb8a3GF/jd6m6u5LblS7WYj3AEsN2jYa
   leVZIvV4HHR4pLqzhNo/uSZTeut3yl13poX4fpoGM9Lt9zRg04gjLKFUx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="306933663"
X-IronPort-AV: E=Sophos;i="5.96,254,1665471600"; 
   d="scan'208";a="306933663"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 18:21:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="718953044"
X-IronPort-AV: E=Sophos;i="5.96,254,1665471600"; 
   d="scan'208";a="718953044"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 18 Dec 2022 18:21:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 18 Dec 2022 18:21:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 18 Dec 2022 18:21:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 18 Dec 2022 18:21:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 18 Dec 2022 18:21:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbuuMOquJ5HU3MAAAo5R3PuP+lhrgQpGtumTEuWNPS0nMs75L6iSJ5F9h/1NHNIGzJSwiXmeXZUfPLx8spYQytpAj9maJfiq/6cDoDYS4G5KyY1r+EJewaSTqat/fdUVuNuxAV9LE95gVb2e79sdNSHpluctzL8K79B88NxKlH/qDpGDQVtHmavjj/JQiFbgBb/xXRGRIt/ra82X8fnE5XPaeD8jVy2Lr8fiJQ30BnTGVFciwdgfSo7pJC81bpYX+P/tIywcmUoohQQ1fi22Jb6aSjw/tf2GzAYRRp5v8wGYff0JMZc6QtVWnhfhOIkwUao7FljtjIP23/mQoMLAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlObqqnfouIn8q+UFWXraYJAfcQQeZToIFNG+t2EDDA=;
 b=X1RrCupMD+RdO1+wIkgK788OoG2ysI+wG9r5Q+kkYkmer3wN3BD0U1n4th8KiW60EVhaQu29stturbuH/zpqU94pF+vVy2w9OuzlTpIGxCBygVUQdYr7+bTeYT2JgaQHYUPIYLQzyncpkOyRP6c/FaZPN2mUCheHEvrWK2XRl+by7/ChO9RJ3CwMG8oplu1QXT8b3AYDU9I8ufaodmwVHzxD4nQVqUZKMSOsEZZaJ+M76P1Nye0SFb+K3MDRtZCiYcbSE6+BesZGrb07uwAUBS7EsHVVfKJu3dw4Sc36Zpy/ZOA1LqgUGXkoGQ+MRD7T/WVGTUfOcuWJuzWw/K0Mcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MW4PR11MB7079.namprd11.prod.outlook.com (2603:10b6:303:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 02:21:01 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5924.011; Mon, 19 Dec 2022
 02:21:01 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Liu, Yujie" <yujie.liu@intel.com>
CC:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Topic: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZBRUNYM7gGe8KaECV+8uqpx3Q8a50ePYAgAAL4hA=
Date:   Mon, 19 Dec 2022 02:21:01 +0000
Message-ID: <PH0PR11MB5880EB31D9AFD82EFA3073A6DAE59@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221130234533.1983769-1-qiang1.zhang@intel.com>
 <202212181914.f5a305f3-yujie.liu@intel.com>
In-Reply-To: <202212181914.f5a305f3-yujie.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MW4PR11MB7079:EE_
x-ms-office365-filtering-correlation-id: c1862239-5d4f-482d-820b-08dae167ac6d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xgmuuSg5xU4C8uFKw7KLBsSH6XOZFYRCeyl8RRhfLb/opQvR3V77yu5gscCPx9ma/jOYYxSFrM6e4qQweOdjA+oKK9zZvsjfzfzmbO4RM2/nCnOZlzfdxdmGEVFECJJfr8OfG2PJ1ZV2K0LMBjL4G2cFX+WRB4egavjNa+tcL1daI0aeW44py9/N38KUil+4F0mfko2CRsOXsG37BY+zqLtBL8F32cQe/m6vH/0SynsFAuzwTSKPkPZa1DbxalRMomoTjs/pAMFFO43W2ckfivjVW44kzAFLBZ+ub3gCJQFo1LybPTL9K8jFQpL0c6ZVyvYEF3J3L1gmDMW1EbRz2Avz1UgBFZqRzbaCc+2iD4ilMyCELvj4bAReUfAJBZIxr3su3+JmfVWhSsb686jtZZpMErNyLCRYETw+t4p9M8u0Dkuq39pTX0sKR929VSNTvgxvSexloq5OIdWrh79nU8Ia4LMKkMDJZTPQkacxvaXmX2t9Sd5IlebtEZN5ZmGU9XgofAO1IkhpXTqmgK+5pzNhyRtjEsuDcqSPwdzlgrbg1ut05L0fwSvWzd4Al+aK0JvLsIS9WbW5DsYY+/pXiYTIgYdx2OH79orJ4zAbzfOUyoSiZPIT1mtEBPicjkoB/KIeqGRyMuQOhgqOO5DH/IG+z1JGDhhMz7GkywYizLHywebHwO8S2B6wMzSMRcXMLaV91jffpeKlbKdJkFwFqg636E5nJdJ+ffIEM5ITRCRHLb+7GYVu4V7FTyjdtvbInF0DAvkE5+2PeVtG5Zdlnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199015)(83380400001)(86362001)(55016003)(33656002)(122000001)(38100700002)(38070700005)(6862004)(82960400001)(316002)(8936002)(6636002)(52536014)(54906003)(2906002)(66446008)(66476007)(64756008)(66556008)(76116006)(66946007)(5660300002)(4326008)(8676002)(9686003)(186003)(7696005)(41300700001)(26005)(6506007)(71200400001)(45080400002)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8j4sF4TQLwAO+1YBS86OcSMZ7ynFrTRHar0rfOS2jg/8+Hm/ehf5hcUJ1XUL?=
 =?us-ascii?Q?TUeuCk43vN/vq3fjCEnxj2OaKl5cYDZylT2jTGgpmiQ26+gimS42u5zkp8NL?=
 =?us-ascii?Q?iRilHrgprkiTzUuuhfzUdZZvEHBCQF9aui4KAanHbozMKNZ2k/ck4hSZQ+mm?=
 =?us-ascii?Q?wHJYYgv/h8ri+XZ/ltrikUpdQIkZ13mRjA0P2p0GiDRtctiK5vfQfMGBmpvx?=
 =?us-ascii?Q?gaGai5fxZX9BRw3Of9y1t4JEyKMvq+Knfhoq1SqSsbc4emwXoFHr7ZI0y5h9?=
 =?us-ascii?Q?dV7wcYujz2BU3Y2Lh2MCtHLf8dlKEXpHO6VHu1DoVKQX++M0OVSHwxlQ/7rm?=
 =?us-ascii?Q?LBTVpnQREu/u329cK4CsPVU71n9xBTC3KKGexBXv2SeC3jqoWdFzTss9oWHm?=
 =?us-ascii?Q?nX+1kkaNT9jlw+fc4uqSwQoeHUCwxGbIODo9ATcQ5AZfTDknEwCFnO+zuicQ?=
 =?us-ascii?Q?mmHm1Lp9FsbFE6GZmPCbqNXoI02sf5y/NPYOgTFewt5da0CiBSF8Fbt/yxw7?=
 =?us-ascii?Q?HSWHRgFmYX0rGYDjbt8ikk8/3aZNeiGgzKvMx95lBNTGudfXjCJZEH/ISN0G?=
 =?us-ascii?Q?CFluRt57g4+uQfihB1e+pTTxjjboYgFNokbIsJMlMa+flQia8AAl6UTHb0rl?=
 =?us-ascii?Q?F/5ofu1SbZUsdq6etE55K3JDs2zyOK39TmhwIvXzjdM7gFik8Wy30zQ/MRj6?=
 =?us-ascii?Q?g1WrsMvz8qgzELuVt+6A9Lm0j+vD2erhLLrdBSg/wMXezhYZmW4VjVNDGRkt?=
 =?us-ascii?Q?oUCNznGsoejeRB3czRP6ktJTOxly3QMr1v58iuASk4cdBG8mbY6cRyATzI5/?=
 =?us-ascii?Q?2iKVmrpqDia5FDy2alFV8QPGY7awTIylEiGyyulnPySvo4J7J6rLVUqBFhtP?=
 =?us-ascii?Q?lIpNQ/h8A0wCisHJJ8cv0bRax65TJprbljq5xu1z5l9M8Tcu9W/r0WCLkfwP?=
 =?us-ascii?Q?SqIzEL5lioEg3ZaxgcxVzrkXWyg1m/tW3WZUS4sQLZTqp8Zfx0NNVLBTSHTV?=
 =?us-ascii?Q?gKOeDNnU5cowHFdUIp7kooCo7c9ok7Q3Y7irE0w9/h3onXn9G9XtRKjU+SCm?=
 =?us-ascii?Q?8KrYY3W8XeREuA0ENoUDl9NAuNarNGnCHwSRh+gvaASUBNTiEbpcm4GflD5S?=
 =?us-ascii?Q?5jUiYnfdJlMY2dDvduGpvICPNsNfgb/LWC0w1f/hNtRY3DWamf3sUddN9RD+?=
 =?us-ascii?Q?q+XVOkWW5rwhKnntLz/rRhaHnHu8j+tZUaAeJnLct/9cz5siTBnDA1NT1Y6l?=
 =?us-ascii?Q?5iEIiRyEEY8hvtRMyqHR4UuVhpJ6HWYxmbBxYp6p/BSAewclW8PFOpt3spXH?=
 =?us-ascii?Q?+9JvqSeSc4ciAUnrT1Wx9xMowuUYac7Qv1+BuQzBxBZBzAnEk3DKDrOIy5o7?=
 =?us-ascii?Q?JRNfpxBRotYl035tbVBEsOu6HZt5DaTIXbfaRRx90D0tx0EmZsKbXKM8FxHQ?=
 =?us-ascii?Q?QypmQY/fmkg6GXTMm37hdtNnzmv5o2GPmKC8SIL2gFtnDZJ2N+P/+wV4P83v?=
 =?us-ascii?Q?giPx/22b9dpsSmMOSILG/PWe4tGElX91j95gcwZKMecUua/4fYGBM6sTRueG?=
 =?us-ascii?Q?dJjuaV/X3tgeeYO7SUOnQRMvwsg/Bbh/WTp1Y8pG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1862239-5d4f-482d-820b-08dae167ac6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 02:21:01.6460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V45Zsm4YX6q931AgfXSNbe9etjUPL2C0mK6X58NN+pMSaqITZGNY+D4ebr0C+ugOoTqq+QxfswObKuRGchpyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7079
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


>Greeting,
>
>FYI, we noticed WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_c=
r[rcutorture] due to commit (built with gcc-11):
>
>commit: 572a17843591d3c03ad891492939a06833fdd17d ("[PATCH v4] rcu-tasks: M=
ake rude RCU-Tasks work well with CPU hotplug")
>url: https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tasks-Make-=
rude-RCU-Tasks-work-well-with-CPU-hotplug/20221201-074127
>base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git d=
ev
>patch link: https://lore.kernel.org/all/20221130234533.1983769-1-qiang1.zh=
ang@intel.com/
>patch subject: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CP=
U hotplug
>
>in testcase: rcutorture
>version:=20
>with following parameters:
>
>	runtime: 300s
>	test: cpuhotplug
>	torture_type: tasks-rude
>
>test-description: rcutorture is rcutorture kernel module load/unload test.
>test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
>
>on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8=
G
>
>caused below changes (please refer to attached dmesg/kmsg for entire log/b=
acktrace):
>
>
>[  106.051532][  T583] rcu_torture_fwd_prog: Starting forward-progress tes=
t 0
>[  106.052085][  T583] rcu_torture_fwd_prog_cr: Starting forward-progress =
test 0
>[  133.611262][  T583] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barri=
er_tasks_rude+0x0/0x10() 0
>[  146.800051][  T583] ------------[ cut here ]------------
>[  146.800411][  T583] WARNING: CPU: 1 PID: 583 at kernel/rcu/rcutorture.c=
:2806 rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutorture]
>[  146.801075][  T583] Modules linked in: rcutorture torture ipmi_msghandl=
er crc32c_intel serio_raw processor fuse
>[  146.801894][  T583] CPU: 1 PID: 583 Comm: rcu_torture_fwd Not tainted 6=
.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12c137296733dde4a9
>[  146.802916][  T583] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
>[  146.803693][  T583] EIP: rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutortur=
e]
>[  146.804177][  T583] Code: 89 d8 e8 fc c5 ff ff e8 67 49 03 00 83 c4 10 =
84 c0 75 79 a0 96 c6 10 ef 84 c0 75 70 e8 c8 ee ff ff 84 c0 75 67 83 fe 63 =
7f 02 <0f> 0b 8b 45 f0 8b 15 40 25 8a c2 ff 75 e8 ff 75 e0 01 f8 2b 45 dc
>[  146.805599][  T583] EAX: 00000000 EBX: ecee3800 ECX: 00000000 EDX: 0000=
0000
>[  146.805992][  T583] ESI: 00000000 EDI: 0000c350 EBP: ed9d5f64 ESP: ed9d=
5f40
>[  146.806491][  T583] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS=
: 00010293
>[  146.807010][  T583] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 CR4: 0004=
06d0
>[  146.807484][  T583] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 0000=
0000
>[  146.808031][  T583] DR6: fffe0ff0 DR7: 00000400
>[  146.808384][  T583] Call Trace:
>[  146.808634][  T583]  rcu_torture_fwd_prog.cold+0x3b/0xee [rcutorture 67=
54ed9afe4685f50ef7fade6309181c73794538]
>[  146.809348][  T583]  kthread+0xc8/0xf0
>[  146.809635][  T583]  ? rcu_torture_fwd_prog_cbfree+0x80/0x80 [rcutortur=
e 6754ed9afe4685f50ef7fade6309181c73794538]
>[  146.810347][  T583]  ? kthread_complete_and_exit+0x20/0x20
>[  146.810734][  T583]  ret_from_fork+0x1c/0x28
>[  146.811075][  T583] irq event stamp: 205883
>[  146.811400][  T583] hardirqs last  enabled at (205891): [<c114bb06>] __=
up_console_sem+0x66/0x80
>[  146.811960][  T583] hardirqs last disabled at (205898): [<c114baed>] __=
up_console_sem+0x4d/0x80
>[  146.812583][  T583] softirqs last  enabled at (205880): [<c1ecb40b>] __=
do_softirq+0x2bb/0x440
>[  146.813079][  T583] softirqs last disabled at (205871): [<c10845f0>] ca=
ll_on_stack+0x40/0x50
>[  146.813567][  T583] ---[ end trace 0000000000000000 ]---
>[  146.813926][  T583] rcu_torture_fwd_prog_cr Duration 2411 barrier: 3960=
 pending 50000 n_launders: 0 n_launders_sa: 0 n_max_gps: 0 n_max_cbs: 50000=
 cver 1 gps 0
>[  147.914266][  T583] rcu_torture_fwd_cb_hist: Callback-invocation histog=
ram 0 (duration 6702 jiffies): 1s/10: 0:0 2s/10:=20
>[  149.453780][  T557] ------------[ cut here ]------------
>[  149.454322][  T557] rcu_torture_writer: rtort_pipe_count: 4
>[  149.454817][  T557] WARNING: CPU: 1 PID: 557 at kernel/rcu/rcutorture.c=
:1583 rcu_torture_writer+0x71d/0xc80 [rcutorture]


This is not a bug.  this is caused by grace period taking too long time, th=
e previous callback
has not been completed.  from the dmesg, can be found that the cpuhotplug t=
est is being
performed periodically, this may cause the rude RCU-Tasks  grace period to =
take more time,
due to we need to acquire the cpus_read_lock, and the CPU0 always bootup fa=
iled, that is to
say, only one CPU of your system is online at this time.


Thanks
Zqiang

>[  149.455687][  T557] Modules linked in: rcutorture torture ipmi_msghandl=
er crc32c_intel serio_raw processor fuse
>[  149.456490][  T557] CPU: 1 PID: 557 Comm: rcu_torture_wri Tainted: G   =
     W          6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12c1=
37296733dde4a9
>[  149.457660][  T557] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
>[  149.458484][  T557] EIP: rcu_torture_writer+0x71d/0xc80 [rcutorture]
>[  149.458990][  T557] Code: 05 00 00 8d 43 f4 39 c6 74 c3 e8 0e a0 0b d2 =
83 ff 63 0f 87 3d 05 00 00 ff 73 fc 68 88 a0 10 ef 68 f4 9a 10 ef e8 10 01 =
d2 d2 <0f> 0b a1 30 c6 10 ef 83 c4 0c 85 c0 75 95 b8 01 00 00 00 87 05 30
>[  149.460472][  T557] EAX: 00000027 EBX: ef10d630 ECX: e49c0f28 EDX: e49c=
0f24
>[  149.461022][  T557] ESI: ef10d694 EDI: 0000004f EBP: ece35f8c ESP: ece3=
5f18
>[  149.461539][  T557] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS=
: 00010292
>[  149.462101][  T557] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 CR4: 0004=
06d0
>[  149.462642][  T557] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 0000=
0000
>[  149.463172][  T557] DR6: fffe0ff0 DR7: 00000400
>[  149.463526][  T557] Call Trace:
>[  149.463795][  T557]  ? lockdep_hardirqs_on_prepare+0xa4/0x160
>[  149.464333][  T557]  ? _raw_spin_unlock_irqrestore+0x45/0x60
>[  149.464795][  T557]  ? trace_hardirqs_on+0x35/0xe0
>[  149.465191][  T557]  kthread+0xc8/0xf0
>[  149.465506][  T557]  ? rcu_torture_pipe_update+0x130/0x130 [rcutorture =
6754ed9afe4685f50ef7fade6309181c73794538]
>[  149.466327][  T557]  ? kthread_complete_and_exit+0x20/0x20
>[  149.466771][  T557]  ret_from_fork+0x1c/0x28
>[  149.467136][  T557] irq event stamp: 45753
>[  149.467457][  T557] hardirqs last  enabled at (45761): [<c114bb06>] __u=
p_console_sem+0x66/0x80
>[  149.468145][  T557] hardirqs last disabled at (45770): [<c114baed>] __u=
p_console_sem+0x4d/0x80
>[  149.468803][  T557] softirqs last  enabled at (41056): [<ef1037a0>] rcu=
_torture_pipe_update+0xe0/0x130 [rcutorture]
>[  149.469602][  T557] softirqs last disabled at (41054): [<ef10377c>] rcu=
_torture_pipe_update+0xbc/0x130 [rcutorture]
>[  149.470401][  T557] ---[ end trace 0000000000000000 ]---

