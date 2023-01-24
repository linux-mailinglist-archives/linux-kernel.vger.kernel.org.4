Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746E5679E80
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjAXQWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjAXQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:22:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05384ABE0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:22:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcTOZMOWpI0y8HJD370OlQ1o1kiUfnmISzlOEZ0oXcbYRC0gGRp4/YVysrtVp39WwMzD3FKAZpfCCcTFZUIYVzI6fh0OpfkgvP/xpeOmDseg1xYCEQ+n6jO3iDscVaOtzlOKgMjd2vyXF1JX70UQCVgjlb5gdVcfQBwr74Rd0+ETNsYbFeaPg55uoAbUYCw5Qgg4Q21J6n67GZqFuysWMcP5rbCykf8OdeeiwO5Di/Gob/UQZrQyDwpyXleAf+6M3OObMC8+D+eeLKDoNrJrR8lp9FskhJYQ3Uu13mAxwRaJySkkojyLUVdhBABInsYlpTU8jTrntlFgMFkvZVoZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaIBLcKE2RCXzKSO/rp7re8J+Oc++rHWnhQX17UEBSY=;
 b=CTqoUOrPsrAdbGwF05Pv+AnbBSMzbY3+BUT0hthQ0ltV2DNBavC/XIqTBARcG7TZAI5w/DaL/oEeT/i8waEFSy+t6MDdSjosbHo+DuvQoi0djRQ4ZOpM3UPE7MHtL25VzdcdCekwXjk+7Ki4VA7D5/OIzd6o3DLB4lS4Y38dKgw7SSZoOq91k6/sNGaYjY9n26kHLccJ400VQtV7ql9Cw/uHHwtLU1/2sI46mLH9NqRAoJIPr6uGivuBx9gmE3mWLvhNV8SlIZNMG4/iYKKoowh8FN3UjSqvGcnMK0HorslQ4b2v4UNYSVS0FN+bwwNcQGcYAICaTFWUAQCEZQ5XSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaIBLcKE2RCXzKSO/rp7re8J+Oc++rHWnhQX17UEBSY=;
 b=jHOp08jE0VHH/r4bmKV0s6QXgXjB6dQB88gu2jZI+iCv18aKj40s49p3BxyA/49lUfUxUeb8S5okLSl/iR9Ehc7XOBQsx7sXBFUItgtN8NT6uXkm7LEc0aqLdvK45ClXOzC5YN5z7ITqrEcfrB1J0H6vMcPgLZWQQ/lAPqfLY84=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by DM6PR07MB8110.namprd07.prod.outlook.com (2603:10b6:5:1b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:22:35 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:22:35 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: WARNING: locking bug in pgd_free
Thread-Topic: WARNING: locking bug in pgd_free
Thread-Index: AQHZMAset3nz2AD2Fk+SjP8/qDrTVQ==
Date:   Tue, 24 Jan 2023 16:22:34 +0000
Message-ID: <IA1PR07MB98304A14BD26596C87A8C581ABC99@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|DM6PR07MB8110:EE_
x-ms-office365-filtering-correlation-id: 7df80187-1e20-40c0-4006-08dafe27339f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJurvuyC22NIRgWhMGQJoApjFbP44CrSIiEJh/kMkBLNW7dIAL1FojBR4OHUnx7eaG2L6HHQccw6Ag5r0ZpvLhJROMzgKmofyTofb6EpInEGJfrc8NQkv4SUvF5IszBLOHCZ20SUOZkDztBFAGjBgdYkLo97A00VtuXq8tZ5Ug/5t/WrMdUflGs389NaomKpNTl4KK5/Iu5r9hsBN+MM4rckphhh09LbFoxR83k+3Gsx2eyRl7gmmr8l0ucRySA2XbzyPl3rMUvL7dpc1KljHLwKmjARDSSSq8ADztDs24ccnFtWWXXk9/rpOzjy75lpHMxh5mivFSos3qL7XNF6mSDUI1JSVAKNkeB07gowFL0cJM/sCxSuG5/IoL/tK6VKG1D12Zp6S0lOARCPPO3QuwC3XIvyeQFOQKW4eIjlAu85jrliJ8G+OVmKmCFUJGE5qkgRIZmf3J9a6Zvgq1bLGyAB70vrBma+i6zaYxtQ7NDcmmUGepRHBzwXmpPR00DWA3nQsOvlnRLxDwYrczuVN0UEGdGmM0OkerBoLh1hCSaBhC0Us7WrnmBVtp4JKFVlmPuAmZNpWx9AQvZr3U+SzISuoCWmUlwB6k/7RynYmxm1uacxY2bUH9et1vs1CHP9C0VRPXTAWAKF3MCL7B8lBMAOyT7UdXoZGMs+yQWzHzTAAM/eV6aH1QIx69EnsTgrRLGUdYSm6QqMcSOlfrjvKr2wDBwOb6lVuqvGqh+AQi6TqqMQlobvyzmnlvcW6MeQaTgy3TQCLdkOkZ2CQGlZT+IByf4wD9MMsIp7CoHa9MM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199015)(54906003)(71200400001)(7696005)(66446008)(66476007)(4326008)(64756008)(66556008)(966005)(8676002)(76116006)(45080400002)(91956017)(41300700001)(52536014)(8936002)(186003)(9686003)(44832011)(5660300002)(83380400001)(30864003)(6506007)(2906002)(786003)(66946007)(5930299009)(33656002)(41320700001)(122000001)(38100700002)(75432002)(316002)(38070700005)(478600001)(110136005)(86362001)(55016003)(58493002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YssH4SFk4tEc8GvH6ZOImeciqHv+TnQGxQvJKVwW5hCXeZDDpSI4H52ezm?=
 =?iso-8859-1?Q?XLLbqRFzGuW7hVNDg9roFUOntGZdjojERrn7v/dlKSp5imZJfWVCOvWBP9?=
 =?iso-8859-1?Q?KeUHcwaFpclOO9tst0J8A/ogXMp7bvFIYP7n3g1x/FCIpB1bAqI7Hy98pN?=
 =?iso-8859-1?Q?EZLHeJhAr04HIwQniBJejzQ8csS/HzKYA+2DnWu1sbc/5z1d519qD+DsLF?=
 =?iso-8859-1?Q?aZ+VAPEsSbz6faD5w2MZBL5bZpDfVNoA9jGJuxq+rhImIfqA8rvTIYFY9f?=
 =?iso-8859-1?Q?hqcv8y5WKGTxFMp+Mu34EQp7HqFakAe+lzT117sUZykfVBDUNIObD8+xAt?=
 =?iso-8859-1?Q?uyxNzhsOF8n2leK+ZpY7kdjWZIzv/4u6By9OxpT4LBZE7TgaALk2C9tsA+?=
 =?iso-8859-1?Q?lImV6QqK9f+5PFzz6XLt1E+fC13HdtAR7TV7OVNAAKR8jivQHMV9zlRzbA?=
 =?iso-8859-1?Q?JbdGoixpQQ0VTrwzORovSk0M10nMrHMaIOh8y45Txi64/qjNdtSurLGWFU?=
 =?iso-8859-1?Q?hAgBMl5JnYfXNPuFy/Hex+cJlb/zo9eVL183sZbgWtforvoIh3gax0xwXJ?=
 =?iso-8859-1?Q?cggfmSvomy/rT0QfQS9oqoJ0MtYDCzGlsbM+Fk90bozCEySvWUwIt/GOk4?=
 =?iso-8859-1?Q?gqB2a8FEoozauemoCspEZKOIbbwi9eCdI9vuUUukWHpwxRz5ZVRB7TFUst?=
 =?iso-8859-1?Q?t0IEqSMG6jA1jJi5A9h8r7HTmg7wy2MoWfaOCCHDgur2Y95Z/9KDXW/hmd?=
 =?iso-8859-1?Q?vbfIGqyDdmI6FdH+0jeg7GzBvUhqJEhPxcAAyxoflog8ViY4rdftv5ybzR?=
 =?iso-8859-1?Q?uPJG+wmR5/Y9BUnseaf0uoeOD/1IrUqSRrt0CTQ4GvxIbSCo0Hk3Fx9uko?=
 =?iso-8859-1?Q?5H9rVV8Lvh9O/4tm2PZpmeYpSatOol5BUboo6IjgEdhbU/Kcdf7hpeK+4Z?=
 =?iso-8859-1?Q?7K1q6NWFhLQT/1IJ36WCKUs7VCg5polMr2pUr+5qDEqk05NhiQg5oIRrMT?=
 =?iso-8859-1?Q?8yticSouk077dscmQWii0tDGQOorvlEGuaGhePYwU21MJGaiJO+QtTyN1s?=
 =?iso-8859-1?Q?UWE0lqjfgMjXYTW6gdi4Onod7C4dZ5Jm4WeT7cZslCCWs/jZjyHPS8S17i?=
 =?iso-8859-1?Q?QuoA0D+lqhkjWQjNQQoPsib7Em+okkM4K1f2AWbBjxbhwlE6qurtJ6CDL4?=
 =?iso-8859-1?Q?BokmWPEQCJNVbmsFjYcyGh9rqADJ9Su1XYpMNZZhbWuiCiBBl5AOSst4zK?=
 =?iso-8859-1?Q?aNeejppe/KNKfOR7AUGA1FfBG0OEkKv/ARufEsDZVzPXL6BtJ+BYjVL/kQ?=
 =?iso-8859-1?Q?Sek73a+VjNT7dgq5J32GEfEGSEku754uZE8b6WmAg8HLbUcJ4wwSD2BKKD?=
 =?iso-8859-1?Q?S8sWrI9FVo/8/WlNer3QWhmPWCguYgy7EXtne9fFZHnBr/dV7Z6Bcma5nO?=
 =?iso-8859-1?Q?V4XsPv2WIDvjtAQzs9oNzlJ+g0iyMNBOZqoa+GCVKpYXF1g4XU/xxKw5R0?=
 =?iso-8859-1?Q?++w8vQWpNDIWJBhCbIIKKLAvWkLwMw9BL2exJFso/OrmxjTKZZl86Zn4T3?=
 =?iso-8859-1?Q?9aI9ZZaxwyng4zWPhy/fA/7LHZIOiFwblduqB9dnSITHqELx8eUdZ1Khxq?=
 =?iso-8859-1?Q?cj+lLfKMCg1KQSRnPNSgW4Cn/JX/UfuBVcVm5ZXhefy+AxzAtGZ83UPguD?=
 =?iso-8859-1?Q?zRJFBFmWdyHwMALG3udVeq7UvfGP7dN0xtm4IUnVnCxMgiPA4ymVpTSIAQ?=
 =?iso-8859-1?Q?bzdw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df80187-1e20-40c0-4006-08dafe27339f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 16:22:34.9444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2CTcFk9vzWsUULuXhwUz+zRcHN8Pc+dStybpFn7BMsCpzuApiqkTI/COc4o1oAxs5UrgvT2QOPpd/XdW89x/JGDtSCL4bOODc4D1vfzYRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB8110
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, dear maintainers,=0A=
=0A=
We found a bug using a modified kernel configuration file used by syzbot.=
=0A=
=0A=
We enhanced the coverage of the configuration file using our tool, klocaliz=
er.=0A=
=0A=
Kernel Branch:=A06.2.0-rc3-next-20230112=0A=
Kernel config:=A0https://drive.google.com/file/d/1Zg-NZ5s04wPVdO8cfpvQjatI-=
0VAVjZV/view?usp=3Dsharing=0A=
=0A=
Unfortunately, we do not have a reproducer yet.=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
------------[ cut here ]------------=0A=
DEBUG_LOCKS_WARN_ON(1)=0A=
WARNING: CPU: 5 PID: 7278 at kernel/locking/lockdep.c:232 hlock_class kerne=
l/locking/lockdep.c:232 [inline]=0A=
WARNING: CPU: 5 PID: 7278 at kernel/locking/lockdep.c:232 hlock_class kerne=
l/locking/lockdep.c:221 [inline]=0A=
WARNING: CPU: 5 PID: 7278 at kernel/locking/lockdep.c:232 check_deadlock ke=
rnel/locking/lockdep.c:3017 [inline]=0A=
WARNING: CPU: 5 PID: 7278 at kernel/locking/lockdep.c:232 validate_chain ke=
rnel/locking/lockdep.c:3819 [inline]=0A=
WARNING: CPU: 5 PID: 7278 at kernel/locking/lockdep.c:232 __lock_acquire+0x=
24b8/0x5170 kernel/locking/lockdep.c:5056=0A=
Modules linked in:=0A=
CPU: 5 PID: 7278 Comm: systemd-udevd Not tainted 6.2.0-rc3-next-20230112 #1=
=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]=0A=
RIP: 0010:hlock_class kernel/locking/lockdep.c:221 [inline]=0A=
RIP: 0010:check_deadlock kernel/locking/lockdep.c:3017 [inline]=0A=
RIP: 0010:validate_chain kernel/locking/lockdep.c:3819 [inline]=0A=
RIP: 0010:__lock_acquire+0x24b8/0x5170 kernel/locking/lockdep.c:5056=0A=
Code: c0 03 38 d0 7c 08 84 d2 0f 85 61 20 00 00 83 3d 85 10 86 0a 00 75 ca =
48 c7 c6 c0 d8 0c 89 48 c7 c7 20 d2 0c 89 e8 4d cd 39 07 <0f> 0b 31 db e9 e=
7 fd ff ff e8 fa e4 73 02 89 c3 e8 73 67 ff ff 85=0A=
RSP: 0018:ffffc90018207240 EFLAGS: 00010082=0A=
RAX: 0000000000000000 RBX: 0000000000000705 RCX: 0000000000000000=0A=
RDX: ffff88810c5ec340 RSI: ffffffff81671fdc RDI: fffff52003040e3a=0A=
RBP: ffff88810c5ec340 R08: 0000000000000005 R09: 0000000000000000=0A=
R10: 0000000080000002 R11: 0000000000000001 R12: ffff88810c5ecce0=0A=
R13: ffff88810c5ecd08 R14: ffffffff8bea82e8 R15: 0000000000000000=0A=
FS:  00007efddedb98c0(0000) GS:ffff88811a280000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fdb250c0de0 CR3: 0000000110ba2000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 lock_acquire.part.0+0x186/0x440 kernel/locking/lockdep.c:5669=0A=
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]=0A=
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154=0A=
 spin_lock include/linux/spinlock.h:350 [inline]=0A=
 pgd_dtor arch/x86/mm/pgtable.c:148 [inline]=0A=
 pgd_free+0x29/0x220 arch/x86/mm/pgtable.c:478=0A=
 mm_free_pgd kernel/fork.c:737 [inline]=0A=
 __mmdrop+0xd7/0x3b0 kernel/fork.c:795=0A=
 mmdrop include/linux/sched/mm.h:50 [inline]=0A=
 mmdrop_sched include/linux/sched/mm.h:78 [inline]=0A=
 finish_task_switch.isra.0+0x711/0xa60 kernel/sched/core.c:5205=0A=
 context_switch kernel/sched/core.c:5304 [inline]=0A=
 __schedule+0x11df/0x2e10 kernel/sched/core.c:6619=0A=
 schedule+0xe7/0x1c0 kernel/sched/core.c:6695=0A=
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6754=0A=
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]=0A=
 __mutex_lock+0xaca/0x1460 kernel/locking/mutex.c:747=0A=
 devlink_compat_running_version+0xd5/0x6c0 net/devlink/leftover.c:12234=0A=
 dev_ethtool+0x597/0x5340 net/ethtool/ioctl.c:3091=0A=
 dev_ioctl+0x2d0/0x1010 net/core/dev_ioctl.c:524=0A=
 sock_do_ioctl+0x1c0/0x250 net/socket.c:1183=0A=
 sock_ioctl+0x211/0x6c0 net/socket.c:1286=0A=
 vfs_ioctl fs/ioctl.c:51 [inline]=0A=
 __do_sys_ioctl fs/ioctl.c:870 [inline]=0A=
 __se_sys_ioctl fs/ioctl.c:856 [inline]=0A=
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7efddcee1017=0A=
Code: 00 00 00 48 8b 05 81 7e 2b 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d 51 7e 2b 00 f7 d8 64 89 01 48=0A=
RSP: 002b:00007fff73f33b88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=0A=
RAX: ffffffffffffffda RBX: 00007fff73f33bd0 RCX: 00007efddcee1017=0A=
RDX: 00007fff73f33ba0 RSI: 0000000000008946 RDI: 0000000000000007=0A=
RBP: 00007fff73f33d40 R08: 0000000000000000 R09: 00007efddcf2e160=0A=
R10: 0000000000000001 R11: 0000000000000246 R12: 0000557b0816f5b0=0A=
R13: 00007fff73f33ba0 R14: 0000000000000001 R15: 0000000000000000=0A=
 </TASK>=0A=
irq event stamp: 3491=0A=
hardirqs last  enabled at (3491): [<ffffffff81592f3b>] raw_spin_rq_unlock_i=
rq kernel/sched/sched.h:1379 [inline]=0A=
hardirqs last  enabled at (3491): [<ffffffff81592f3b>] finish_lock_switch k=
ernel/sched/core.c:5059 [inline]=0A=
hardirqs last  enabled at (3491): [<ffffffff81592f3b>] finish_task_switch.i=
sra.0+0x23b/0xa60 kernel/sched/core.c:5178=0A=
hardirqs last disabled at (3490): [<ffffffff88cc9af6>] __schedule+0x1656/0x=
2e10 kernel/sched/core.c:6518=0A=
softirqs last  enabled at (2824): [<ffffffff814efe1b>] invoke_softirq kerne=
l/softirq.c:445 [inline]=0A=
softirqs last  enabled at (2824): [<ffffffff814efe1b>] __irq_exit_rcu+0x19b=
/0x220 kernel/softirq.c:650=0A=
softirqs last disabled at (2809): [<ffffffff814efe1b>] invoke_softirq kerne=
l/softirq.c:445 [inline]=0A=
softirqs last disabled at (2809): [<ffffffff814efe1b>] __irq_exit_rcu+0x19b=
/0x220 kernel/softirq.c:650=0A=
---[ end trace 0000000000000000 ]---=0A=
general protection fault, probably for non-canonical address 0xdffffc000000=
0008: 0000 [#1] PREEMPT SMP KASAN=0A=
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]=0A=
CPU: 5 PID: 7278 Comm: systemd-udevd Tainted: G        W          6.2.0-rc3=
-next-20230112 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:check_prev_add kernel/locking/lockdep.c:3070 [inline]=0A=
RIP: 0010:check_prevs_add kernel/locking/lockdep.c:3217 [inline]=0A=
RIP: 0010:validate_chain kernel/locking/lockdep.c:3832 [inline]=0A=
RIP: 0010:__lock_acquire+0x27d9/0x5170 kernel/locking/lockdep.c:5056=0A=
Code: 0f 83 06 0f 00 00 4f 8d 3c 7f 49 c1 e7 06 49 81 c7 20 c9 bf 8d 49 8d =
7f 40 48 be 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <80> 3c 30 00 0f 8=
5 ac 1c 00 00 49 83 7f 40 00 0f 84 af 07 00 00 48=0A=
RSP: 0018:ffffc90018207240 EFLAGS: 00010012=0A=
RAX: 0000000000000008 RBX: ffff88810c5ecce0 RCX: 0000000000000000=0A=
RDX: ffff88810c5ec340 RSI: dffffc0000000000 RDI: 0000000000000040=0A=
RBP: ffff88810c5ecd00 R08: 0000000000000005 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001=0A=
R13: ffff88810c5ecd08 R14: ffffffff8bea82e8 R15: 0000000000000000=0A=
FS:  00007efddedb98c0(0000) GS:ffff88811a280000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fdb250c0de0 CR3: 0000000110ba2000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 lock_acquire.part.0+0x186/0x440 kernel/locking/lockdep.c:5669=0A=
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]=0A=
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154=0A=
 spin_lock include/linux/spinlock.h:350 [inline]=0A=
 pgd_dtor arch/x86/mm/pgtable.c:148 [inline]=0A=
 pgd_free+0x29/0x220 arch/x86/mm/pgtable.c:478=0A=
 mm_free_pgd kernel/fork.c:737 [inline]=0A=
 __mmdrop+0xd7/0x3b0 kernel/fork.c:795=0A=
 mmdrop include/linux/sched/mm.h:50 [inline]=0A=
 mmdrop_sched include/linux/sched/mm.h:78 [inline]=0A=
 finish_task_switch.isra.0+0x711/0xa60 kernel/sched/core.c:5205=0A=
 context_switch kernel/sched/core.c:5304 [inline]=0A=
 __schedule+0x11df/0x2e10 kernel/sched/core.c:6619=0A=
 schedule+0xe7/0x1c0 kernel/sched/core.c:6695=0A=
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6754=0A=
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]=0A=
 __mutex_lock+0xaca/0x1460 kernel/locking/mutex.c:747=0A=
 devlink_compat_running_version+0xd5/0x6c0 net/devlink/leftover.c:12234=0A=
 dev_ethtool+0x597/0x5340 net/ethtool/ioctl.c:3091=0A=
 dev_ioctl+0x2d0/0x1010 net/core/dev_ioctl.c:524=0A=
 sock_do_ioctl+0x1c0/0x250 net/socket.c:1183=0A=
 sock_ioctl+0x211/0x6c0 net/socket.c:1286=0A=
 vfs_ioctl fs/ioctl.c:51 [inline]=0A=
 __do_sys_ioctl fs/ioctl.c:870 [inline]=0A=
 __se_sys_ioctl fs/ioctl.c:856 [inline]=0A=
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7efddcee1017=0A=
Code: 00 00 00 48 8b 05 81 7e 2b 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d 51 7e 2b 00 f7 d8 64 89 01 48=0A=
RSP: 002b:00007fff73f33b88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=0A=
RAX: ffffffffffffffda RBX: 00007fff73f33bd0 RCX: 00007efddcee1017=0A=
RDX: 00007fff73f33ba0 RSI: 0000000000008946 RDI: 0000000000000007=0A=
RBP: 00007fff73f33d40 R08: 0000000000000000 R09: 00007efddcf2e160=0A=
R10: 0000000000000001 R11: 0000000000000246 R12: 0000557b0816f5b0=0A=
R13: 00007fff73f33ba0 R14: 0000000000000001 R15: 0000000000000000=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:check_prev_add kernel/locking/lockdep.c:3070 [inline]=0A=
RIP: 0010:check_prevs_add kernel/locking/lockdep.c:3217 [inline]=0A=
RIP: 0010:validate_chain kernel/locking/lockdep.c:3832 [inline]=0A=
RIP: 0010:__lock_acquire+0x27d9/0x5170 kernel/locking/lockdep.c:5056=0A=
Code: 0f 83 06 0f 00 00 4f 8d 3c 7f 49 c1 e7 06 49 81 c7 20 c9 bf 8d 49 8d =
7f 40 48 be 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <80> 3c 30 00 0f 8=
5 ac 1c 00 00 49 83 7f 40 00 0f 84 af 07 00 00 48=0A=
RSP: 0018:ffffc90018207240 EFLAGS: 00010012=0A=
RAX: 0000000000000008 RBX: ffff88810c5ecce0 RCX: 0000000000000000=0A=
RDX: ffff88810c5ec340 RSI: dffffc0000000000 RDI: 0000000000000040=0A=
RBP: ffff88810c5ecd00 R08: 0000000000000005 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001=0A=
R13: ffff88810c5ecd08 R14: ffffffff8bea82e8 R15: 0000000000000000=0A=
FS:  00007efddedb98c0(0000) GS:ffff88811a280000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fdb250c0de0 CR3: 0000000110ba2000 CR4: 0000000000350ee0=0A=
----------------=0A=
Code disassembly (best guess):=0A=
   0:	0f 83 06 0f 00 00    	jae    0xf0c=0A=
   6:	4f 8d 3c 7f          	lea    (%r15,%r15,2),%r15=0A=
   a:	49 c1 e7 06          	shl    $0x6,%r15=0A=
   e:	49 81 c7 20 c9 bf 8d 	add    $0xffffffff8dbfc920,%r15=0A=
  15:	49 8d 7f 40          	lea    0x40(%r15),%rdi=0A=
  19:	48 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%rsi=0A=
  20:	fc ff df=0A=
  23:	48 89 f8             	mov    %rdi,%rax=0A=
  26:	48 c1 e8 03          	shr    $0x3,%rax=0A=
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruct=
ion=0A=
  2e:	0f 85 ac 1c 00 00    	jne    0x1ce0=0A=
  34:	49 83 7f 40 00       	cmpq   $0x0,0x40(%r15)=0A=
  39:	0f 84 af 07 00 00    	je     0x7ee=0A=
  3f:	48                   	rex.W=0A=
=0A=
