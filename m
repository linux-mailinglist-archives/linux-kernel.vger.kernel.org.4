Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30E699F14
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBPVo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPVoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:44:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED523BDAC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:44:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+dT7MkwHvL8F0pmwGjNVXDFx8G+QRPVd4/GW6HvNsHZqBsJZyCKII4WvJCPXqqIqz6BgRz2VVza2zj/fDvNmlZkN7UgM5/YrV2VjPLZPf3SLK2VwQeEoEytSMpm+mltrq0Ig80be9m1CrEj+vFroHxCW4qb66j0k9L/WQIjPZXj8h7qzUvANF99Opb78A3SYTgNOVCBfSP/ZMxV3ZzFocPVCUoX4fXtwilVh0a6aqN6d3ZJxi6HEAwRvNKx752kBidVOXc9bNx9jbSUvB5YE0BuKlac/BLh4x53NR+18c7prftiwtQGHNr1tFnYH5DjsgXJ5KWBpy4o6VznyI/Pjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7AwandNsDahcPrKvnDdFSYXV1/q9IDCskIfmvaznAY=;
 b=m7B9ewfNlbrNIwZ30Z7XYf74xDGKuwiDcnqF0gwFrw4od1z9IGJ8Bbu525MzzD1K/Sq75Uvld2OiTHiV3kyxDKFZgSKglRbHoa5eTo9qnuDKZ8BiPA6CYUzEW1j8tTT61JmNZ2C3LzBCJ5QmkTz/MIbQ5Y5R7Y76PZ6K0ONAQ65NGgjPPkRc5WWmcDV2gZGe0TwHJ1VzPhkWy3dUMCyNgJbWKWBzdZMEfHCoSTb3xLU6R9fhwSV9AqLMpz7RQxU9caaI9Ff0LY38ikdYV4g7pvXDbLahPAunxt7Sq7zN2OYtrw9qzgxNxbaCFxHTtObcgSJxI52sCV2Mr7UGcqt7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7AwandNsDahcPrKvnDdFSYXV1/q9IDCskIfmvaznAY=;
 b=ekSnqTCgaRLqh9Rbtb3WTEsTF9UZcq2KgZhx/ZN5UYrgOGOh+Z8yrUl4D+Ttf5ueEubnAml66StFefcl+NHPA3E0Iopo/BE7K7qxwrGhs3NF5qPv2xEHvQiJEg89so/xBSXE73guPgynixHzM2zEZmvlcdyUKqZaK0f3BdOwyic=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by PH0PR07MB8717.namprd07.prod.outlook.com (2603:10b6:510:86::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 21:44:20 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace%6]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 21:44:20 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "shaggy@kernel.org" <shaggy@kernel.org>,
        "okanatov@gmail.com" <okanatov@gmail.com>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: KASAN: use-after-free Read in diFree
Thread-Topic: KASAN: use-after-free Read in diFree
Thread-Index: AQHZQkt2BggXpjbzg0yrJLC+JV9WgQ==
Date:   Thu, 16 Feb 2023 21:44:20 +0000
Message-ID: <IA1PR07MB9830F102D9E73960D30C35AAABA09@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|PH0PR07MB8717:EE_
x-ms-office365-filtering-correlation-id: 25073ecb-0535-4e94-62ab-08db1066f5f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U2IQqruxsSWH5PdGTraHWt9vFUasWtPlg2NmWlmIF56/Z951hjfTMNiWk5/o7RyUWEQ3NZXpMUy3nDC1U0h2LtpI+djZv7Pnmls4oOt/jEjzrofM+TJomHVyD7IgoUnvzWgfcdNFaFceenBRNdjBI1qKBW8qYyRNhbCVR1fAMfaOqh6w34//sdXzqhn99VjJMlPfz+3nsi7XV1CLkwiFsddK09gi8w0eHZka80Sz3pbiaWJX/yTWCVof65Y+XGVK4PQwgM3jL6ff9j2wGbB+vBZoza///txvtQK4FLdcE+k2GD3uneJ9T4SaUEXRKogGOC8tjn/CzcNa3LW4qS9cG+YEMbS0OeCsb45q1yOjh67tNpBdlPNNdd7ZY8zzUVH9EIkAPSOYRJFEdfriBXz78kKh5A9tzQaZH0654P+fXuPVAM594eEt6zt2UgXpVJDO49Cln0eOJtGm4ZlNL9Wrn/+SN7Y2qUWVj379dZxZldTFFrwPk0TspJJw1CcbOfy2EeMeLkyOMB9IfkibbVeuKLtXf/2BdVzfbqNEvZmHwUE3DbFCthn0nHLxTfB9lQZnu/d2QkttfvxLulpmOw1j4+748bpvozpwobR3a2lMfiR1/nQGWooou38HpQkclkpFqvzpfqjc8jUaqKaqDy3wjeFBMpMLmvFSy6V+zOGlde/z8Kjz3UYBey+H8/1zKRGnsw3abYo8dI9BBfg4yk4b+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199018)(5930299012)(966005)(55016003)(83380400001)(86362001)(2906002)(44832011)(478600001)(33656002)(7696005)(71200400001)(6506007)(186003)(26005)(9686003)(122000001)(38070700005)(75432002)(38100700002)(66446008)(8936002)(41300700001)(4326008)(5660300002)(52536014)(41320700001)(8676002)(786003)(66476007)(66556008)(64756008)(66946007)(76116006)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p4HIWHqmJ51HTW5xrX64WCq5i0t+yRwCkb3f+5V7obc9naqZjdHCCyp9HP?=
 =?iso-8859-1?Q?vacbXbiQvNL66DKSFE18BiNKn1du1TEWXUcfDtavN6nx8RVnqt9W34CRYE?=
 =?iso-8859-1?Q?n7gvrtzf7kSQ+kP5fAkXnopFolj7Mb9w5N7bMeNBzsmVFZRLyKtBzAoCwM?=
 =?iso-8859-1?Q?laAEzz2pHDfz4EX/12+tzqFZMWTkp6rBaT/LWLLFjFs56f0kmRHNneZx9O?=
 =?iso-8859-1?Q?SDJlPB0JyT8zWJOZtr6Bru8QcMKdmm6emB+/ook/X1tZ/K0vvmZv891mra?=
 =?iso-8859-1?Q?H0fUq0xFs2XUKoyjf5poP2cl+BZVnvEXjjYgHrQx0bys8e5E59wHc4KB1/?=
 =?iso-8859-1?Q?Fol+0/xbWWAvrOW99M45hTBSvbPcw0Ra5FCp3V0xO3hkNJcdyu73hGL81F?=
 =?iso-8859-1?Q?7ay+EjssgdT9j2jGj0yJ7gtQAjL8aXXI/dBN5EzB+rp4g2pUmxuwsSmy5G?=
 =?iso-8859-1?Q?b4F7oivBsKqp5lw+TEAw8uKi1zzVpAPxeclprFoYawaZJxJszwg4KVanGT?=
 =?iso-8859-1?Q?scC1XXg9HpzgYLiiW5JEuUhkyjaDjjNGVlK486eQFrUSVOEaPRj8068H4A?=
 =?iso-8859-1?Q?uyYPyEkDH29CTltlWzwrTMO98db8ObSj2fuuOFo5yNhK14FR9EN9Sc99Yo?=
 =?iso-8859-1?Q?oHzc9dLGSJTC3NWf2rRnNpJFLyX5OCLHkvzO9qQ5FfVP0UM6W4/jSdJZFK?=
 =?iso-8859-1?Q?v579FsCuVJVjVj9mKD+OYNuQdy1CY4ZPzCF6ybw77t8T1iKY6edsvrGPIl?=
 =?iso-8859-1?Q?EBy512Bfl2phOs++RKJdf3b+tcpCnh1oviOCsRNAwwVnYDBuYToR+gpB5l?=
 =?iso-8859-1?Q?WYDazWDi4wYPaE2UszYQApg3WuyT/XP+vJ99UtTL7UDfQxZFr2u1PwJO//?=
 =?iso-8859-1?Q?TldAw3z/kY27/wFVWoCUjvko9tpcN7aI8reA0ByaH+OdIgiapt7m4JEitQ?=
 =?iso-8859-1?Q?Dsfmq3TDtN06stXRN1ePOlBbCLmGnEYRTTZ7sAjVs5v/mK2j7f7IHHWpi2?=
 =?iso-8859-1?Q?2x6VyJ5loWwsrh4+TQkzvQH5w2CMwMSXWZxzjFsJh9eorvphHAO72Cv1Fk?=
 =?iso-8859-1?Q?K/cTYrq4CT9U+ccBmY9VhWxatVd9hh8i3a9SBXin9L9TB7kjVZGFPS+XgM?=
 =?iso-8859-1?Q?VM4X1Hre2WAIku15KL+y2CW31v8mi4yPEb9CSzHs5mjp1i0hM5elIhnUa/?=
 =?iso-8859-1?Q?7V75TyT3ZeHIcTf/P4pzZecSZc9/z5l9wGnEixjZ9Vw7E4QcPJdXhgP67z?=
 =?iso-8859-1?Q?M7azW/kvbrQN3wEAE3lBRvwVzBYEl6helWO25J3u0OQI/N0RnEJSlsHJYH?=
 =?iso-8859-1?Q?/4k5RQWUefjJn+u/Mx436U7tUxgwLfcG1/EgW1xx34P7uJJUhvWzkfLGYo?=
 =?iso-8859-1?Q?zjZH1mz7YbiV1mug0pIkM3hikIjPvoMhHRcKN8DR8+++RG21+1o5pw4ssI?=
 =?iso-8859-1?Q?wu8kpG6jp5UFQ1pj9XEIcHvmVXmLi1S0Ep1lgyiQN13pZED900XLqxgmgS?=
 =?iso-8859-1?Q?Mj+wxX81KjUvpINB1SP0zVF2TeQscSQ4nQgXhuozWk4othOsVQ3v8ogLEI?=
 =?iso-8859-1?Q?9REfe4TZxpI1IuuNz5fgvMDmD/2h0n4lB57GUA2Q+pHL/XG7QOx9mVveqF?=
 =?iso-8859-1?Q?Fr8RusUAuAmJdAlv4UFGvXsEB7R0zT4hd1rNuPpT62ttXDPRtk09EUbg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25073ecb-0535-4e94-62ab-08db1066f5f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 21:44:20.2149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4EsF/96nxMWXhdl2N+sNueqLNjOQlzDE/WWaiG7mFHF0MNFvHGWmw57D/0eA7Emietariu2mMaO5wREuwcXKuzqZXU47ABzayzAuL3NqDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB8717
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
Kernel Branch: 6.2.0-rc7-next-20230213=0A=
Kernel config:=A0https://drive.google.com/file/d/1yVvlPL4-MMdjARqrwJ0QoKuPv=
_3lFQIR/view?usp=3Dsharing=0A=
Unfortunately, we do not have a reproducer yet.=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
BUG: KASAN: use-after-free in diFree+0x19b3/0x2b90=0A=
Read of size 4 at addr ffff888077b90004 by task syz-executor.2/24105=0A=
=0A=
CPU: 5 PID: 24105 Comm: syz-executor.2 Not tainted 6.2.0-rc7-next-20230213+=
 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Call Trace:=0A=
 <TASK>=0A=
 dump_stack_lvl+0x17f/0x260=0A=
 print_report+0xc5/0x5e0=0A=
 kasan_report+0xd7/0x110=0A=
 __asan_report_load4_noabort+0x18/0x20=0A=
 diFree+0x19b3/0x2b90=0A=
 jfs_evict_inode+0x36d/0x430=0A=
 evict+0x305/0x6f0=0A=
 iput+0x541/0x8c0=0A=
 diFreeSpecial+0x7b/0xa0=0A=
 jfs_umount+0x13e/0x340=0A=
 jfs_fill_super+0x9ab/0xc00=0A=
 mount_bdev+0x332/0x400=0A=
 jfs_do_mount+0x39/0x50=0A=
 legacy_get_tree+0x10c/0x220=0A=
 vfs_get_tree+0x92/0x360=0A=
 path_mount+0x6cf/0x1fa0=0A=
 __x64_sys_mount+0x2ae/0x340=0A=
 do_syscall_64+0x39/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f592ba9176e=0A=
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f592cc8ca08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5=0A=
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f592ba9176e=0A=
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f592cc8ca60=0A=
RBP: 00007f592cc8caa0 R08: 00007f592cc8caa0 R09: 0000000020000000=0A=
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000=0A=
R13: 0000000020000100 R14: 00007f592cc8ca60 R15: 00000000200000c0=0A=
 </TASK>=0A=
=0A=
The buggy address belongs to the physical page:=0A=
page:000000004cb7d93b refcount:0 mapcount:0 mapping:0000000000000000 index:=
0x0 pfn:0x77b90=0A=
flags: 0xfffe0000000000(node=3D0|zone=3D1|lastcpupid=3D0x3fff)=0A=
raw: 00fffe0000000000 ffffea0000594408 ffffe8ffffc82420 0000000000000000=0A=
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000=0A=
page dumped because: kasan: bad access detected=0A=
=0A=
Memory state around the buggy address:=0A=
 ffff888077b8ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
 ffff888077b8ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
>ffff888077b90000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=0A=
                   ^=0A=
 ffff888077b90080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=0A=
 ffff888077b90100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
imap: 00000000fcdc15ea: 00000ecc 00000000 00000000 00000000=0A=
imap: 00000000d740174b: 00000000 00000001 00000000 00000000=0A=
ERROR: (device loop2): diFree: inum =3D 16, iagno =3D 0, nextiag =3D 0=0A=
