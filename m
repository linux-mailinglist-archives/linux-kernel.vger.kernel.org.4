Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8FA67C13E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjAYX7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbjAYX73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:59:29 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DC13A861
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8fsB70M4BDQqrX4ydKikvMGcLScXWwdNURgYOn7GLGvFoYsEhUgMF1VFtbWcQCF2tEEDN/3iW/Oe7kkLip4FkRp3CXeDwpapod6/jdFF73D3L2xFM48t5GZ9LFTzZ3HGS6S3hSzcVk782TMGlfjkcMDVaTgmWsRDuIbruFL4LDWtTXql0oj40uDwxQXPAyNG/frF/p869W54izweb8dsqGhsSTddbIFGHgFTz6PFJLPrGt+JLsnk3Xl/9sUNIVKpNRQXAwIEazy4FJ8MyHazXgefQu3ExW/HMO7tWIEWZvK52aqQX/Wsyx2cxO1mXOjNZrW8zbbBIpSVeeWfzwhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YNbCF66ImZ2QLed3Bi+u+3gWYdwN0d2ZPd+laa/d+o=;
 b=iuDlLP6NiSheNXpeW4z08xRtnM/g2oiUtex0TURa0C5qlugt4pBDBaEUTNc3WJ4H7WawHsWDki4pR2p3bArdAiqDPw0TDHEat6ZdHu16I25cXjLMLOHYYDi7oYv8vmsbZqY0pULWlR//YS0vDoIugfd1xMKX+/CgGBrPcalFerb8mrmbnn9p+SEVA/nrI+CPQU+Nf+U2WESxCjuno+WALp1HB5U8trHxe5JeIIAJxxEIBmriLoTLUg3+vGszznIvrubCiEaUIPz0/xsMZdvV47wk643J6AnxIxPB1iE9pbMkAtml/ea2ToR2XyePa3HG2zgl2a1IN4LMvYcSPkMR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YNbCF66ImZ2QLed3Bi+u+3gWYdwN0d2ZPd+laa/d+o=;
 b=JHJTi2j6xojEBwNs4zIi8sEaSX3sLIAIv9sfwQoLx+/DdZDfaElD1o2qjqfd89z3Af9FyWXA9oIFjE4nU+8W2rlIiIb5AnDmAHqY/wXkt1bP1gkMSwU8YjdNunQ1v4h/2slHL6JrureSIlNJhCpA61w7KHivpOBxodcNreXOa8k=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by BYAPR07MB7845.namprd07.prod.outlook.com (2603:10b6:a03:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 23:59:17 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583%3]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 23:59:16 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: kernel BUG in page_add_anon_rmap
Thread-Topic: kernel BUG in page_add_anon_rmap
Thread-Index: AQHZMRe6C5MT4qQat0SXa+dBKYuLJg==
Date:   Wed, 25 Jan 2023 23:59:16 +0000
Message-ID: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|BYAPR07MB7845:EE_
x-ms-office365-filtering-correlation-id: a2190fe1-bc1e-4531-eb3a-08daff302ae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ARmex89Oin6ji88J6vvBgUvpUpR+e+XZRAy3h/22s9J9AuH/LHMAL2y8dP7PP33TqzSZpCEIl1VlWXyKjr6yTALMT1TqE34Po5cAAhZFFJHS9jsav2iYogToJEpIItmwPTnrpscEC70NmHAhDeOK+ZI1H10f9mv8foB8jb5euPSPVneHdm5RrsZ2FhJ4epY0pqH/ULrz1yL2Fk8Jva++FrZja5NCGJkYVQrUiYkq57ydq/f/PjEpPbJigU44CBo9g8gfYsJNjwVpXuVo8GKXQ5J6XQw4hiV4X07vKnQYYvrSeSac0SNDU7ZjMIzMpKYD/VtxaXKV2ZSIr84/uvhaCLd+wuvp1zGuT6+LHkpLp7SbX8DiDnn6iEaC/5moDDI4Zot/RgZFtBJ2cO/8qVCTSK+7J3kZrITdHDeN97tthPMqk32577XLhiShwfh7g1WqM+57Z17VjU4ihV8ULj6b/+yhTXkoqv0nkS/vU1Pe2IAU49wif4sAqxIIopm7RoZTAY3Nswjb0SC5tOYAOKs7nN8BXFinVeFd1WuE+rtDDxP3znGEl5UgNZx96Q8IALb0I37JeUXVKrqovcP0yhQ7x0ZdaBx0xCJrbj4TGm273HlWs77AUtHi5oY5k188FnMXLYAKldnyQurIo/2F1ay8zzQAIN/fvNd8kpTysPVnj3mXI14e08uVJ2FGeH710Hw+PRwmripZx91ikKm5UToTKDnlvMEnxyrb3Nc1zwHTx0o/RAZsXLhpl6FN/Z+nwlvfvs4tJymuyv1Xbg9ohoBZ9KtW1D8tmAT1/v49D3wCIc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(2906002)(5930299012)(38100700002)(41320700001)(38070700005)(4326008)(9686003)(786003)(66946007)(66556008)(66446008)(44832011)(8676002)(76116006)(64756008)(122000001)(52536014)(83380400001)(41300700001)(8936002)(966005)(6506007)(66476007)(478600001)(55016003)(33656002)(75432002)(316002)(7696005)(5660300002)(186003)(86362001)(45080400002)(26005)(71200400001)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pvDMsyDWNhc1hE/0kktnQJZ5QgRSj9rWTzEJ5eHz8gHKQcVhwllKARCBgt?=
 =?iso-8859-1?Q?ekUToR0WVlHOLnxssQHM2Larc7NhNvA6nSOoU8qQpnjW7InUve66TD505H?=
 =?iso-8859-1?Q?DBnY7yVj1n1rqJIQfPvJGDmuRT+8nMy5trShsLBLV13DAvsIkeW5cPfLj3?=
 =?iso-8859-1?Q?QB9xQrGmL3FEW1CJXRRCwn8esoaH2+9GSWGqlU50L3/MYxDwJ2Fb5hYiwe?=
 =?iso-8859-1?Q?fUAW7OQH1SVS8N9mJRCqBvkrKS+WF54R08rH2HHuiewQkHCx+Z3RqP40hU?=
 =?iso-8859-1?Q?h34HL5rjWoJAUqO+cGLyeg7uKLPpNM2CF1xzbTqW9KdueHQ+QpUSD1FDZv?=
 =?iso-8859-1?Q?tWhnOus1irFgQ+Kg5cFxfd7JZAxuumDRY2Y+8DkN92zkrdvb8+PwauC815?=
 =?iso-8859-1?Q?OvtpAUQHC1NsIh0fZDw+gcVEOWMO3Mz5iybLZUknB2691ue9+/HUtWOigz?=
 =?iso-8859-1?Q?+1o7tvFp1QDDJ6l8nfhYm5/zOGYtB6K93TlObtq3aCWwRloCexXODYBRcO?=
 =?iso-8859-1?Q?0Fk2Ibt22wYxgJ4BOMfrYg0yWJPefXovkN7gZbEbNbGgWT45Kbm57oCkxA?=
 =?iso-8859-1?Q?KPeYSBDjdUz/njbMsUj2ejWONpKCxdiElCl67I9+NUS3GsIJ67ij9REmA8?=
 =?iso-8859-1?Q?C4hpGT9SRJq9N8MSiETGnF6zGVKZvBXO2f+urYGGVZQAPFSEdeT/eOAMA2?=
 =?iso-8859-1?Q?SfD1wotr7LLbnqRrksuDDjK2Qic77rRVj2uvcbhWCeZksIc1NjusmgiI+6?=
 =?iso-8859-1?Q?ZsyrZz2ciWAKKaq4qEYGlMg2kGULTtBKXYj0vTUTnPJBRwmsv8DMNnugQH?=
 =?iso-8859-1?Q?Gyn68ySJMB1dN+sgY/739/Vgq+WoJvAcBf8QPiU7i9Yq2+pxs2WBkdCZ52?=
 =?iso-8859-1?Q?3PWqbKJCX3oZZyBYP8XbtPbZazONXMha9ms+s8CTRReM0jYFdZlq64/DXg?=
 =?iso-8859-1?Q?hkZyx/MjanC0iXs3dV39n4HVaakI91qQMyweVHFTO354WXbNCny1Jdb22p?=
 =?iso-8859-1?Q?zqsld1OYaieZ2cx2W6PZIHDnZTXdnaTlvasgj1I1JB/JEVqvL/AQonddAV?=
 =?iso-8859-1?Q?WulQt2n8E+1lkcqHJqbYvi5citWqbYpM+p2GyPXwd4CQyERtudYw0g5ujv?=
 =?iso-8859-1?Q?1CR+ScwxobzUIOwGt9ItPjMW0G9HtY09y+W1sNhG6MvoX2vLx1994ytLG3?=
 =?iso-8859-1?Q?sek4Dc84dyue1HabSHY8FrxBy2kgjgKthNLChHdk89vLPQXHjOm2JcLhzq?=
 =?iso-8859-1?Q?iMVqSEALuQBOf/aUU1nN5uSLKFOBFn32djxt2ZavkaQGpzVW5z3W8lxHth?=
 =?iso-8859-1?Q?uZ4VK7C6v92L/qNZdHKuLMSaWS7qw2xGfipEWhjB6SnwCHqQyvVJXXayZf?=
 =?iso-8859-1?Q?pUVginfnZAjTet04xOKIHPQk0XvHQ2SECwZApf6rU9kCGXmez7+plCWpbM?=
 =?iso-8859-1?Q?fuFM5suZf/3czpxH2Ok4VIh3n/ZdB3DHycXmoFXx4FOPfq6ryulMKdoI6m?=
 =?iso-8859-1?Q?mJB4D/7ih2P8ju0xWADo8vIZmtqFNae9s22IHQYkSG3eDVUIxoNnbv8pws?=
 =?iso-8859-1?Q?TUkk3L3sZhx0Kxz1yI+Z3WOzlNyxL4RcJ/ubV9holg9Pix0H/JXySA+Hze?=
 =?iso-8859-1?Q?pf2Joo9kfkEumuzdUxv3YvmCUHpilS53c6WpT/JbgII69ESQnWji9zkw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2190fe1-bc1e-4531-eb3a-08daff302ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 23:59:16.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SVqc5YHzo7fyu/PJPXSk/2X+FGu3pT+GIkrWNr0pTVcGh6ezYpRr7OuwnIkCm/6LmOAqc9JfCOXdEO6MdzIKuOk6R+SU/RNn8YLrrFqV+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB7845
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
Kernel Branch:=A06.2.0-rc5-next-20230124=0A=
Kernel config:=A0https://drive.google.com/file/d/1MZSgIF4R9QfikEuF5siUIZVPc=
e-GiJQK/view?usp=3Dsharing=0A=
Reproducer:=A0https://drive.google.com/file/d/1H5KWkT9VVMWTUVVgIaZi6J-fmukR=
x-BM/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
head: 0000000000020000 0000000000000000 00000004ffffffff ffff8881002b8000=
=0A=
page dumped because: VM_BUG_ON_PAGE(!first && (flags & (( rmap_t)((((1UL)))=
 << (0)))))=0A=
------------[ cut here ]------------=0A=
kernel BUG at mm/rmap.c:1248!=0A=
invalid opcode: 0000 [#1] PREEMPT SMP KASAN=0A=
CPU: 7 PID: 14932 Comm: syz-executor.1 Not tainted 6.2.0-rc5-next-20230124 =
#1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:page_add_anon_rmap+0xddd/0x11c0 mm/rmap.c:1248=0A=
Code: c0 ff 48 8b 34 24 48 89 df e8 1f ff 07 00 49 89 c6 e9 85 f6 ff ff e8 =
52 73 c0 ff 48 c7 c6 c0 3c d8 89 48 89 ef e8 b3 23 f8 ff <0f> 0b e8 3c 73 c=
0 ff 48 c7 c6 00 3b d8 89 48 89 ef e8 9d 23 f8 ff=0A=
RSP: 0018:ffffc9000c56f7b0 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: ffff88807efc6f30 RCX: 0000000000000000=0A=
RDX: ffff8880464fd7c0 RSI: ffffffff81be733d RDI: fffff520018adedb=0A=
RBP: ffffea0000c68080 R08: 0000000000000056 R09: 0000000000000000=0A=
R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000c68000=0A=
R13: 0000000000000001 R14: ffffea0000c68088 R15: 0000000000000000=0A=
FS:  00007f717898a700(0000) GS:ffff888119f80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f7178947d78 CR3: 000000004a9e6000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 remove_migration_pte+0xaa6/0x1390 mm/migrate.c:261=0A=
 rmap_walk_anon+0x23a/0x5b0 mm/rmap.c:2433=0A=
 rmap_walk+0x96/0xd0 mm/rmap.c:2509=0A=
 remove_migration_ptes mm/migrate.c:294 [inline]=0A=
 migrate_folio_move mm/migrate.c:1307 [inline]=0A=
 migrate_pages_batch+0x15f8/0x3910 mm/migrate.c:1809=0A=
 migrate_pages+0x1b56/0x22e0 mm/migrate.c:1961=0A=
 do_mbind mm/mempolicy.c:1329 [inline]=0A=
 kernel_mbind+0x4c0/0x790 mm/mempolicy.c:1476=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f717788edcd=0A=
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f7178989bf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed=0A=
RAX: ffffffffffffffda RBX: 00007f71779bc050 RCX: 00007f717788edcd=0A=
RDX: 0000000000000004 RSI: 0000000000001000 RDI: 0000000020002000=0A=
RBP: 00007f71778fc59c R08: 00000000000007ff R09: 0000000000000002=0A=
R10: 00000000200000c0 R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 00007ffd2c012f6f R14: 00007ffd2c013110 R15: 00007f7178989d80=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:page_add_anon_rmap+0xddd/0x11c0 mm/rmap.c:1248=0A=
Code: c0 ff 48 8b 34 24 48 89 df e8 1f ff 07 00 49 89 c6 e9 85 f6 ff ff e8 =
52 73 c0 ff 48 c7 c6 c0 3c d8 89 48 89 ef e8 b3 23 f8 ff <0f> 0b e8 3c 73 c=
0 ff 48 c7 c6 00 3b d8 89 48 89 ef e8 9d 23 f8 ff=0A=
RSP: 0018:ffffc9000c56f7b0 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: ffff88807efc6f30 RCX: 0000000000000000=0A=
RDX: ffff8880464fd7c0 RSI: ffffffff81be733d RDI: fffff520018adedb=0A=
RBP: ffffea0000c68080 R08: 0000000000000056 R09: 0000000000000000=0A=
R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000c68000=0A=
R13: 0000000000000001 R14: ffffea0000c68088 R15: 0000000000000000=0A=
FS:  00007f717898a700(0000) GS:ffff888119f80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f7178947d78 CR3: 000000004a9e6000 CR4: 0000000000350ee0=0A=
