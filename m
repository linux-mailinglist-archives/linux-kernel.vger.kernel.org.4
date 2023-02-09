Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7147D690CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBIPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBIPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:21:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42DC7298;
        Thu,  9 Feb 2023 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675956062; x=1707492062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m9biQprSCnATXMe/e9zU99Ve4xcThIHlYpjnFTqKwD4=;
  b=USNb2XvSKZ+PiE1+nAGPGqxSOFSuk5Jy6H2+3hYrp4tCUU7kS0RuGLBU
   +orWEFKJ0cjBhZKOTHDHZvza9Q2+vOCN4iC9bog9OyP+b5fTit0R/zohP
   Rh3Xd40Ch7DaVvvxSicJRrLH8yJ/uR1zcpPo7oONVGEmddZL+W8TqdEmT
   y7+ttaSOjHCaSDPpD/2vDOlzeTz/9DN2UEC8Ji4leXLCEtDDLjhbP2z1V
   fQmD03nrfSbdKN4KXeLAM+dg2QLXthRt7qaTTYto8A8ydc1/LF0tcsX9D
   jminkis0uUWUVMU4h0I/BunW/ghJfSHHzHkpVN9im7u6Dvb0Ht/88mnXK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="416354002"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="416354002"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:20:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="731349666"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="731349666"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2023 07:20:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 07:20:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 07:20:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 07:20:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 07:20:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJdgiqX1ILfYvZT2urO9apOjSeqmq2d8MCiH1K2vv8ZTWOWQ3Aq7uNp3qu3zdL6cIqjiK2wcgbOJz0eKOYQ39S6Zv/ci+uE7C/oyMFsDyFnSFVU9nUduvA8j3DFJJTml07RwPR7P8UT4rFlppdo5KmQZ/NLs1ZqpggxbLF367lToK/jbPCAIfMomBIG1mpUllDMkbJdCQ2GzeZXiilDHl/4k3gQhsmgnggsaLS5dFKqddpkxD2ZZNAoBCh3B4Yuy7pbhuFgRaBk8O3wzYX+qRCR5hGl7gEZWKH2GCx4Z7g6MOXkBdZBtusSbzzOAh5oP5RwFii+KnUR6QqUIb9s65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpCJZKg1kLU4wS4rl6XyMGHLMGTffxc9b0RPpNmHxns=;
 b=RVnKXmEfXm4dxvnAk4sJyJTBfQlO+kAiUYwOa+YhjUPBTtnqVTpjfMe6NHMJ2EmYomwcvHcoClm3V2QVxP//KiPfGboX0vbrnpqE/qDqM2TYDPRYCSe5l/H4Pi1cLH1mc821yGDQ+5oL7ZZ+3+DInJmCIRcMhv3+4/WhVptZK6W21o7TRHd7XqkD3KD1WReWUzGuqzk0PJzsJCMPLzNBGUii4Ceiy/XpmVrYst3DA5lDpwYMh9THSsZENyMCeDRW7aTZE3KsyZoZLytXvc6o3GBQOucJFUYUwoHEmWLBRAaEW4bjo9r6Jz6h8dq2lla9v2TjNkO0Hbbgr/c/qH0ZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS0PR11MB7191.namprd11.prod.outlook.com (2603:10b6:8:139::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 15:20:40 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6064.031; Thu, 9 Feb 2023
 15:20:40 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG]  run rcutorture  BUG: unable to handle page fault for
 address: ffffffff84d05000
Thread-Topic: [BUG]  run rcutorture  BUG: unable to handle page fault for
 address: ffffffff84d05000
Thread-Index: Adk8MhYPZ5mQA/WsTS2t5TzUx/BkvAAB2uWAABfhSQA=
Date:   Thu, 9 Feb 2023 15:20:40 +0000
Message-ID: <PH0PR11MB5880CE7CCAE4ED9C2BA39BBCDAD99@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <PH0PR11MB5880C80360BE924B60905CC0DAD99@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230209034927.GL2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230209034927.GL2948950@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DS0PR11MB7191:EE_
x-ms-office365-filtering-correlation-id: 180ee4d1-798f-4a1c-eefb-08db0ab13470
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cKsCI7E6/swkiWNpR1QAbM0uKbmf3DHOiym4v1Ha5IWz+LEgYX7klr6cfIKU5VeleDNO0PgfVZk9ohGYbmVf2YnAESRnBqe26flXbtO8tcSZ/IaIf4SgtIG4SR4LTEMBzjCYzo0WOA2TIucpGq5yVE3JZDSoPLb0/D7nvenN50KjCw/RK2po0DirfuplKcUDKBGEfB9Huk2Y58/pm0OnCwRngt1LX8IiJzWhoGcX+c+qS0d4d6VONOdTy9ENOhwS0ywl+KQz5QyYeMnw/VvYBjT8v6Br/wWhmRWVVKsUBheOGIwKiP+rbTiGtkCD32N94Evfs+/er4dH1/oMcbNUQRJnuh5/4iiYo+y6Tg/Hz3sRbB9MY4hjPEw1MziYD0iTfhZqrQgC0+/UuGHigXxmh2pC/RzINJXuTFI5y46FdCvTGSmCxIm1jSJX3XdIvmA28nKI5DhhdgeCBfTc48YIGTuRBoTcavk14HjOIYs10TksKF9VTucEIezThgBAUZl6XE8rbLEcgoHUuzPyiAHe9/IuV9t/Euo/4fCyXe+J6CqWhcUXpsmbWpOZaJoIMxZGr5VW6xw9pXq0YkPQIQ/pEA5Mw7iB8waL3SYBZ7NrJ0dRaOFjA4XvtgD5K5OW1XSjdSSLTVVTzstrmbwORnMXwn0QQymsKCoM/G3Zyt+k4zJyZVTu/n0EzpdhjjcmYzAex3gJhtpi4A4M58iZMB0jaCwLSXrqC0FOemyruqmfpcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199018)(8936002)(83380400001)(2906002)(33656002)(186003)(316002)(478600001)(45080400002)(66446008)(66556008)(8676002)(66476007)(64756008)(76116006)(4326008)(966005)(7696005)(66946007)(6916009)(54906003)(6506007)(26005)(9686003)(52536014)(5660300002)(55016003)(71200400001)(41300700001)(38070700005)(38100700002)(82960400001)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m7OoUjR05bsG/44p4on+/gHeMZKSUgV9RY1tnAzX6SJAoO8tXyhncgwIMKTZ?=
 =?us-ascii?Q?LRI4Ksbou++2LJZHaMXspMKIMToliTpAEfcl3z4IXDxydtI8WwNAwIwTgYCj?=
 =?us-ascii?Q?BQel2VcuMyhmTlv7lfYt5WtQo9iy3HwT5m7amREVupsqQ0lg2F4aZ7oaEogj?=
 =?us-ascii?Q?ouwIBOUc0mlGzY94svA8FJ4f7fio5hZjM+/hz3W5ekw4WhQjBptZAWYFuaT6?=
 =?us-ascii?Q?XMmnrcD5TXUcpUrIn14gHLKifftEojrTp1IKZ5JnlZ7IYXj7eGB19Tc0E3D1?=
 =?us-ascii?Q?ynCxTONhKWzqJYhh0nsnlA3oVcXpyp272jPC4rAwiYt4m+ZyzvCDt1SrsbRm?=
 =?us-ascii?Q?kNR+86qmp9FRPRQJdqjvEKVCdsTYuIx2NENDMyohn9Za5A4Dd9eAxsJjrBg3?=
 =?us-ascii?Q?hcmfdanEmXymA9FNBUiwvHTvQW/R9NwcaZlJxj2Yez/ksp7c8vQfkIBgoMxe?=
 =?us-ascii?Q?GO/uE1E1zFai67FZOYs5TH58iYy459z3X7izVCX6vtTG1IiYcKqrRS2H3OOJ?=
 =?us-ascii?Q?I34hN3LpKkQYkZiEwTYi2AveYnbYg9gvKYAR2V14u2C+pacvljKUH+LYXPkJ?=
 =?us-ascii?Q?NMybLgj3oN8T7fCFK/E6MGBxpZECDW8Km2JBIOdRpfwju4tJN8oR9qWv6Lqy?=
 =?us-ascii?Q?xESnoswqiIZC7sNTo1grfSovOXNbK9HA2EVaZGQHXMxnGCQHRM62dO9wBGbR?=
 =?us-ascii?Q?enA7SWKMJTgrGHifw0KtI28QJ3GfvW3tuNmOpdjYDVw/vzOy6Z1vUSossIt9?=
 =?us-ascii?Q?D/QKvSm0ZFI4VM32vj6k4N6bZX6IK4OLmoYe71XC0Q96X3XZ7DwaoriBb3cO?=
 =?us-ascii?Q?yT610I3LFnfHEJuJ2OHCps1zpQ9ElaGd7HtgnFk68b/0koPsKomdncBjQaxa?=
 =?us-ascii?Q?V+qS2t2lxnHsmpd46UaWc8UK4GiDtj2gcKyclzyf4H0mD3ZWs/0Lo0yESr1z?=
 =?us-ascii?Q?Q0m6cqIg2jGAtZdoVqDPHKIz2QagvPPOQNSEcEtLV/IeFgpHuhhTo4dGHRKV?=
 =?us-ascii?Q?KqTuJJaqIT3AGzc3ouAp0yAq55j3/zVihdiUlcUVlW3c8nlz6Y5ubGFRxrxA?=
 =?us-ascii?Q?NmSNaDHQGTmnOFwcNyJzo3bj5VDO2AE2TlJDKmdu9OTM7vUbjoj4DcGdjt+L?=
 =?us-ascii?Q?5goCp5FCU+Lr5z4pvpVUMUWL/qEmypcM9bnCrU26JtuZiM3WYJ5K5ueq3wb9?=
 =?us-ascii?Q?ooVQua9itTK2xUsEhJtGX97eHALBAYoohAbNHjllI5zbD9EnXE1f932J5XFF?=
 =?us-ascii?Q?3c3Sbrxi4rDa0bNG6+zV5XQz2BKkLCGa6iKKt0XT4v9trdXiW55v6gQaraEP?=
 =?us-ascii?Q?PX8ZRBCwBH4KjDQLpB24F4WZM9bgikSAkcOXnwJj+/SR7qqA4kiuNFHeI9l0?=
 =?us-ascii?Q?U99HhRVEUSETx8qN74iWLe7ONVAaDbMihX9zntWLC+0pl7peWS6olprsDHOq?=
 =?us-ascii?Q?chYwxAoWEA5ae92Rdd34H01PDzcdFgy4LZKg4ApDjWkvEpYtaLr5PoMlfykL?=
 =?us-ascii?Q?WE8ocKnzy97sJlfD09z89/cTsQV5Zn2To2nUSKC2EG1xm9OMyoqxkd2uCfOU?=
 =?us-ascii?Q?fWXBjyQmeJT1KnlOisGxWIx0ksKlLUCd/i1mjc11?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180ee4d1-798f-4a1c-eefb-08db0ab13470
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 15:20:40.7894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mw3kYRCVqrA3sW137K1ehRAJ/B3kLeNwURu5NUmuaPNLO34wxZkuU/V4cUjErBsL5d8+SDK1nj1V4eNzCfXS4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Test based on the following branches:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  br=
anch dev, arch X86_64=20
>=20
>=20
> runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4" bootparams=3D"n=
okaslr console=3DttyS0 rcutorture.torture_type=3Drcu rcutorture.shuffle_int=
erval=3D0 isolcpus=3D0,1 rcu_nocbs=3D0,1 nohz_full=3D0,1 rcutree.dump_tree=
=3D1 rcutorture.onoff_holdoff=3D30 rcutorture.onoff_interval=3D10" -d
>=20
> [   39.392925] BUG: unable to handle page fault for address: ffffffff84d0=
5000
> [   39.393244] #PF: supervisor read access in kernel mode
> [   39.393480] #PF: error_code(0x0000) - not-present page
> [   39.393715] PGD 3e19067 P4D 3e19067 PUD 3e1a063 PMD 800ffffffb3ff062
> [   39.394014] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> [   39.394231] CPU: 0 PID: 16 Comm: rcu_preempt Not tainted 6.2.0-rc1-yoc=
to-standard+ #635
> [   39.394590] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
> [   39.395085] RIP: 0010:do_raw_spin_trylock+0x70/0x120
> [   39.395320] Code: 81 c7 00 f1 f1 f1 f1 c7 40 04 04 f3 f3 f3 65 48 8b 0=
4 25 28 00 00 00 48 89 45 e0 31 c0 e8 c8 0
> [   39.396143] RSP: 0018:ffff8880072d7b30 EFLAGS: 00010046
> [   39.396381] RAX: 0000000000000000 RBX: ffffffff84d05000 RCX: dffffc000=
0000000
> [   39.396703] RDX: 0000000000000003 RSI: 0000000000000004 RDI: ffffffff8=
4d05000
> [   39.397027] RBP: ffff8880072d7ba8 R08: ffffffff811d74a0 R09: fffffbfff=
09a0a01
> [   39.397346] R10: ffffffff84d05003 R11: fffffbfff09a0a00 R12: 1ffff1100=
0e5af66
> [   39.397669] R13: ffffffff84d05018 R14: ffffffff84d05000 R15: ffff88800=
72d7cd8
> [   39.397990] FS:  0000000000000000(0000) GS:ffff888035400000(0000) knlG=
S:0000000000000000
> [   39.398353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   39.398615] CR2: ffffffff84d05000 CR3: 000000000a22c000 CR4: 000000000=
01506f0
> [   39.398936] Call Trace:
> [   39.399053]  <TASK>
> [   39.399156]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   39.399379]  ? trace_preempt_off+0x2a/0x110
> [   39.399576]  _raw_spin_lock+0x41/0x80
> [   39.399751]  ? schedule_timeout+0x242/0x580
> [   39.399945]  schedule_timeout+0x242/0x580
> [   39.400133]  ? __pfx_schedule_timeout+0x10/0x10
> [   39.400346]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   39.400567]  ? __pfx_process_timeout+0x10/0x10
> [   39.400776]  ? _raw_spin_unlock_irqrestore+0x46/0x80
> [   39.401006]  ? prepare_to_swait_event+0xb8/0x210
> [   39.401221]  rcu_gp_fqs_loop+0x60b/0xd50
> [   39.401405]  ? rcu_gp_init+0x89c/0x1250
> [   39.401587]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
> [   39.401793]  ? _raw_spin_unlock_irqrestore+0x46/0x80
> [   39.402022]  rcu_gp_kthread+0x2b7/0x620
> [   39.402201]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [   39.402421]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   39.402625]  ? __kasan_check_read+0x11/0x20
> [   39.402818]  ? __kthread_parkme+0xe8/0x110
> [   39.403010]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   39.403213]  kthread+0x192/0x1d0
> [   39.403366]  ? __pfx_kthread+0x10/0x10
> [   39.403541]  ret_from_fork+0x2c/0x50
> [   39.403712]  </TASK>
> [   39.403818] Modules linked in:
> [   39.403972] CR2: ffffffff84d05000
> [   39.404128] ---[ end trace 0000000000000000 ]---
> [   39.404340] RIP: 0010:do_raw_spin_trylock+0x70/0x120
> [   39.404569] Code: 81 c7 00 f1 f1 f1 f1 c7 40 04 04 f3 f3 f3 65 48 8b 0=
4 25 28 00 00 00 48 89 45 e0 31 c0 e8 c8 0
> [   39.405400] RSP: 0018:ffff8880072d7b30 EFLAGS: 00010046
> [   39.405639] RAX: 0000000000000000 RBX: ffffffff84d05000 RCX: dffffc000=
0000000
> [   39.405959] RDX: 0000000000000003 RSI: 0000000000000004 RDI: ffffffff8=
4d05000
> [   39.406281] RBP: ffff8880072d7ba8 R08: ffffffff811d74a0 R09: fffffbfff=
09a0a01
> [   39.406602] R10: ffffffff84d05003 R11: fffffbfff09a0a00 R12: 1ffff1100=
0e5af66
> [   39.406922] R13: ffffffff84d05018 R14: ffffffff84d05000 R15: ffff88800=
72d7cd8
> [   39.407245] FS:  0000000000000000(0000) GS:ffff888035400000(0000) knlG=
S:0000000000000000
> [   39.407607] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   39.407871] CR2: ffffffff84d05000 CR3: 000000000a22c000 CR4: 000000000=
01506f0
> [   39.408195] Kernel panic - not syncing: Fatal exception
> [   39.408450] Kernel Offset: disabled
> [   39.408615] ---[ end Kernel panic - not syncing: Fatal exception ]---
>=20
> After remove isolcpus=3D0,1 and nohz_full=3D0,1, there is no Oops.
>

Only add nohz_full=3D0,1 bootparams, the Oops can be reproduced.

runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4" bootparams=3D
"console=3DttyS0 nohz_full=3D0,1 rcu_nocbs=3D0,1 sched_verbose" -d

root@qemux86-64:~# echo 0 > /sys/devices/system/cpu/cpu2/online
root@qemux86-64:~# echo 0 > /sys/devices/system/cpu/cpu3/online

schedule_timeout()
->__mod_timer()
 ->get_target_base(base, timer->flags)
   ->get_timer_cpu_base(tflags, get_nohz_timer_target());
     ->cpu =3D get_nohz_timer_target()
             ->housekeeping_any_cpu(HK_TYPE_TIMER)
                     /*housekeeping.cpumasks[type] is 2-3*/
                     /*cpu_online_mask is 0-1*/
               ->cpu =3D cpumask_any_and(housekeeping.cpumasks[type],
                        cpu_online_mask);
             /*cpu value is 4*/
     ->new_base =3D per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
   /*new_base is illegal address*/
 ->if (base !=3D new_base)
   ->raw_spin_lock(&new_base->lock); =3D=3D> trigger Oops

The follow change can fix Oops

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..e255eb83f14f 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -46,7 +46,9 @@ int housekeeping_any_cpu(enum hk_type type)
                        if (cpu < nr_cpu_ids)
                                return cpu;

-                       return cpumask_any_and(housekeeping.cpumasks[type],=
 cpu_online_mask);
+                       cpu =3D cpumask_any_and(housekeeping.cpumasks[type]=
, cpu_online_mask);
+                       if (cpu >=3D nr_cpu_ids)
+                               return smp_processor_id();
                }
        }
        return smp_processor_id();

Have send patch.

Thanks
Zqiang

>That certainly isn't what we want the kernel to be doing!  ;-)
>
>Could you please try bisecting?
>
>							Thanx, Paul
