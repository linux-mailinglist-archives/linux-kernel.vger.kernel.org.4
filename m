Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF28679E82
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjAXQW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjAXQWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:22:51 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3F083E1;
        Tue, 24 Jan 2023 08:22:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPiGsAtbeZ/2J1ALyu2DGpHsRkAeuVpaeVIeJZmMe5Q9gmpKnNN0mucZK6+A8By2UxPLm16z1n1mf/wWz7g/T+nIcob3Nd/EnwxdWTktLhgaDlyukvP0Paf8sHzboVOIeF9KJ8gJUVbHJ+9NVSVQrPQ3H1j1jNajuQzQYAOmNB2ekt6blOqi70lyW5WY+IlnHEhi4ICzwuOyMBgXO39emLlZ/c+C/veY7AUVSNa9Ee1RAyedHbprWZtzEv82DC0rVMZPveDvGNMoHNq3//62TvUbWK7gioEqqpGwqivnAghnS00NJvMqeez6Y5LpCnfd3hQoeyot6nw5ryxlC2h2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8eOGikcxmlKyJonxTCMzscG5ZB4NqDBgFQ/mewIuSg=;
 b=Axyk1SrA+1yhiaQmXOVs37tQDGXrYyWjtDTY558n87hPMrPM/WgbkmhKTmjcmACKHKzW2C+B8FybbpESZ6ZWdHiMaOzAQQFGE6HiSMTGOwxXJE1s8pH832Tkd/wov2WCOoLaWaB8X7l35MMTx1jt8hFGf0PKNl9UHzWiVEcgq2PTkJY5PwxFiEkeeI5aQd50FZP6Qcnw9vcJJr/dtskAR5cZoIdoV52rOIajbkCmZx6MsIXviDNFoRjkuv1NnK4qLaTyoSYjwvZo++A3Wqn8F3OqO3us9b64Wz6bLBTB9z+kXuRtVnWu/uMetJbXon+qc9onWrbW5DEm/uKqphO8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8eOGikcxmlKyJonxTCMzscG5ZB4NqDBgFQ/mewIuSg=;
 b=n0Mc69X3XeF0a5zpp620+fI29/OalHd8e7lBO7dPOZEENfCRiaKyQNhJgpJLVZHLsUGiT9pPRn2jNA/IReC4Q9AikRtabuSFluJC4F592/ORF9mDBTKGBQHpxI++Qf2e8MloHyrNmx+PyoNQhnsAT6tERKlhz5QO7rMRuNzMZlk=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by DM6PR07MB8110.namprd07.prod.outlook.com (2603:10b6:5:1b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:22:44 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:22:44 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "efremov@linux.com" <efremov@linux.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: WARNING in get_floppy_geometry
Thread-Topic: WARNING in get_floppy_geometry
Thread-Index: AQHZMA5UiTTnoUQKS0CDg8SXc9sRig==
Date:   Tue, 24 Jan 2023 16:22:44 +0000
Message-ID: <IA1PR07MB98300093BFFA9208D1677222ABC99@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|DM6PR07MB8110:EE_
x-ms-office365-filtering-correlation-id: d179bc5b-fd91-481b-a0bd-08dafe273951
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JUJck/AeUwCoyTEhRGA2UHemGUtq4NzGKzpmNE7wmCxY17mIuBXurvvB1eFiz3a+gwfnqoOD9isBHZhgMkUPIG2mtgb0YnGb3MJRIh41v0R1EpAAhaOn3UsI0FBcc+c3IuNPfP8/20AE+JvSN0MHX/H2KTch3bpXQanUvUq5dKDw7iTpm28rmmwCFZoWaRUZfFd/D05+pvg/UYxMWbZFWHgJ1H1MsZ1yZUv6Uz91tqYHMzIhs9KZg524c168NGMNhshx7+3EY7pi9FILOHARMGehv3wdzv8WQ01xBxJRCFLG+/nhG1zYeexIIyQ8ibWEUtukOIYmzVAKzguPSXNTGH3hRXPNu/UFXCLOKuD+E7ZAh+Xw0CJhwLwnnrwgoN1OAlV7K0dY76GBINCUXFumaL3iljJS0+EUy2zwYgHShKu/S53nquomo+56HYlb1peXTK6M+T3AcAfEDn7peVKPqgvywfvC9f2dFv9y/4sILTkQwsgzrLE6BC0Xc3t5uhKKlqFtwVsAvl8OVHjXo7uSdWM5KSSNTtg3fakQURqlr6mmsWJaNyFK+ih4pRgTvFmMh/p1/cmws4nygpHTUGzF7yneZBjdVZy1vELhCrPRU8fz0V1UoeultgcWlDV0W19w9XciL696R/RHJHScY/Mg3IRjoFk24dIENxt4vgze2xIhSrY4Oy0EZLFWOmNu9hkRsunMqqUfGnY4uzh/HLtGKm1Ir2MJGkqSZVXi3uB3cOvVg39RjdyJfCktklZXqyT6b9PDelIwkKicG/uN5JhW7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199015)(54906003)(71200400001)(7696005)(66446008)(66476007)(4326008)(64756008)(66556008)(966005)(7116003)(8676002)(76116006)(45080400002)(91956017)(41300700001)(52536014)(8936002)(186003)(9686003)(44832011)(5660300002)(83380400001)(6506007)(2906002)(786003)(66946007)(5930299009)(33656002)(41320700001)(122000001)(38100700002)(75432002)(316002)(38070700005)(478600001)(110136005)(86362001)(55016003)(58493002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WJoZx3BUPH6cmPdxriWAkC068jK1RK/2iNKAhh32q+eRUSefUWl443o6p/?=
 =?iso-8859-1?Q?yuuMP48LX3/GTcGEIzGaDYKOBulvpS/doXFuURZipg2g5O29fCTH/F7pdQ?=
 =?iso-8859-1?Q?jajw3r7YvwhkfQQE+maj2KJUPjh7rIiz0O4lzYihE6Htue9F09MmUN6zq9?=
 =?iso-8859-1?Q?bv3AlV/QN1903nz2YNChpHIv8eLQNbQ0chk5/U2WN+rBkjoPpIkqWaYNMs?=
 =?iso-8859-1?Q?XZsV8SmWiJ12AlG1IMvzc8owPTXFaQyGJ7YCVzTgi65bcNiRDAhSub3vB6?=
 =?iso-8859-1?Q?zsHSjyVs5YErCZU1AqtOFLeC2bAC+8m1cg53BYwJ/+zUhGi15AqkR7+H0k?=
 =?iso-8859-1?Q?hpCQIeIr9m2GBUVDXTIMfz5EyOmM8LTEzn+NUiPURxz17IkTflsXad34aP?=
 =?iso-8859-1?Q?AyVcXW7n9LkzpqbbJRxsdxHUY1M+jiHlgocOtep0ssp9fIOwrDh8Mjfzwl?=
 =?iso-8859-1?Q?CCkTi9lr3K1A9GERicVuV5kif7YPn4nIKTGD0Y9CIamDU/AeTXJrke7Brv?=
 =?iso-8859-1?Q?tZNBRTecSf6c5QlIZHtVLDDfN23EDHJKfkgEoZZIYuPQlWB5o/HOvsJuQo?=
 =?iso-8859-1?Q?a/ocWEMvPbOp6RNG1ttq7rGQPzVysBLkjN6bSw6Aj2nLk9MzH2LCB5L4dr?=
 =?iso-8859-1?Q?YGxp4QoKAQMPaCyxQdHmWdLPjMnSlJpeuzgorW9WxUufZl2H4X/8zd//t2?=
 =?iso-8859-1?Q?jx3K5YRcMTF4rJLtDJqZzQi5jouFGnUpaY+nWYpzKnug1DhxpQOauO6s7i?=
 =?iso-8859-1?Q?jE1fbYowwLqB1F/eRrRIPFqz5znC0p4WNtij72/+ZIRPB2khF1icBTyqUB?=
 =?iso-8859-1?Q?b+kh2eyc7InUlUGvY6tT4qIVprA3SQWRZVf+avnPsLpx7fSZ3dLXF3y4UT?=
 =?iso-8859-1?Q?5U0dHJ0rWApfnh8nJybH3yPS1uEydfJ9iQXDOB12Z3FxGm0qiaaTu6OY3a?=
 =?iso-8859-1?Q?PWeAHL2pHoij5WSaYxowgT3wznYz5GZ2iU0ostYjbjYkF9GwNzlJpAkfJm?=
 =?iso-8859-1?Q?HzOpHahh6kgn4I5IJedsqvyOqDVW9MEAHPYF9dW0+ubzXIVL32pHXu0eUu?=
 =?iso-8859-1?Q?9WrvzF2TDFRVAIL8aPlShlWUQ0xADaFfef7vKC8WauJVhNaE7MmgF550pw?=
 =?iso-8859-1?Q?WV00i418Hb/yW6EW2UnvexdwDkryosJhmEs+YhKaoHnEnm667hQNs90v26?=
 =?iso-8859-1?Q?bqU177PxgXzlv3+bqqVJB03X6MDo/HvPUWEYab1fgm0IdZPw3OEIfbABQ6?=
 =?iso-8859-1?Q?BbTlGhM7F/GSua3yHQV2AJmJ0BFEBxbAXFJcyR5oRP7D/IBCNc/mDHzwcD?=
 =?iso-8859-1?Q?bIX8E9bDHDInIa88X3RH8REc9FDmKw+08pETrLYo+DMNcT22Mw1j2tfbva?=
 =?iso-8859-1?Q?lXQTGjQg/m1/+bC7pOibQgDLBU8NNFbqHEPKhdoLINUbpHfrxENfBATsCJ?=
 =?iso-8859-1?Q?PKLPX6lADjTOxk5TC03hL3TzVV2X3HmJzoEj1mxBMPOHSOMr7/m/rcaptJ?=
 =?iso-8859-1?Q?rC9vXGJaRCEOvzb8GXbnjUSFObYce1bfziakv5YZ1NpxQxP6bltZYykgne?=
 =?iso-8859-1?Q?NfIaTgYZpGCmhGBNTcHar9JM4/Rn6d7ADm/NrCordlxE8+a1tvja19CA4N?=
 =?iso-8859-1?Q?l8RREcqUvv/NNwo5KMpG3SKQE0W35e1wh9O8Ojog5BWB5jUkEt/JYWV98a?=
 =?iso-8859-1?Q?GaOkX8+5KDn5oOJdHEUpnBe2OoOhJ4B0dkSgduOkeVUIUn6Ote+lwbkMqw?=
 =?iso-8859-1?Q?ZDBw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d179bc5b-fd91-481b-a0bd-08dafe273951
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 16:22:44.4864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bmhNeRniCIxz2ldX9FmHnnuempDF+yBP9St50v29XoDmGXE5eixeT3PIiOswaGFWlQChS8dbtdTSBW4mtvqgDkY4DoO4WTbnj6t3IAZEFU=
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
er. =0A=
=0A=
Kernel Branch:=A06.2.0-rc4-next-20230117=0A=
Kernel config:=A0https://drive.google.com/file/d/1aDw7_IXEzr5avqtp-fb6mG199=
n7gkvy-/view?usp=3Dsharing=0A=
=0A=
Unfortunately, we do not have a reproducer yet.=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 1 PID: 27793 at drivers/block/floppy.c:999 schedule_bh driver=
s/block/floppy.c:999 [inline]=0A=
WARNING: CPU: 1 PID: 27793 at drivers/block/floppy.c:999 process_fd_request=
 drivers/block/floppy.c:2847 [inline]=0A=
WARNING: CPU: 1 PID: 27793 at drivers/block/floppy.c:999 get_floppy_geometr=
y+0x187/0x1f0 drivers/block/floppy.c:3353=0A=
Modules linked in:=0A=
CPU: 1 PID: 27793 Comm: syz-executor.0 Not tainted 6.2.0-rc4-next-20230117 =
#1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]=0A=
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]=0A=
RIP: 0010:get_floppy_geometry+0x187/0x1f0 drivers/block/floppy.c:3353=0A=
Code: 80 3c 02 00 75 57 48 85 db b8 ed ff ff ff 48 89 5d 00 44 0f 44 e0 e8 =
58 76 7e fc 5b 44 89 e0 5d 41 5c 41 5d c3 e8 49 76 7e fc <0f> 0b e9 61 ff f=
f ff 41 bc fc ff ff ff e9 c4 fe ff ff 48 89 de 48=0A=
RSP: 0018:ffffc9000bdbfca0 EFLAGS: 00010212=0A=
RAX: 00000000000036da RBX: 0000000000000001 RCX: ffffc9000f141000=0A=
RDX: 0000000000040000 RSI: ffffffff84ff2cc7 RDI: 0000000000000001=0A=
RBP: ffffc9000bdbfd28 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000=0A=
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000003=0A=
FS:  00007fce27251700(0000) GS:ffff888119a80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fce26061c40 CR3: 000000007e1f9000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 fd_locked_ioctl+0x1455/0x1950 drivers/block/floppy.c:3472=0A=
 fd_ioctl+0x39/0x60 drivers/block/floppy.c:3574=0A=
 blkdev_ioctl+0x375/0x7f0 block/ioctl.c:616=0A=
 vfs_ioctl fs/ioctl.c:51 [inline]=0A=
 __do_sys_ioctl fs/ioctl.c:870 [inline]=0A=
 __se_sys_ioctl fs/ioctl.c:856 [inline]=0A=
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7fce2608edcd=0A=
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007fce27250bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=0A=
RAX: ffffffffffffffda RBX: 00007fce261bbf80 RCX: 00007fce2608edcd=0A=
RDX: 0000000020000540 RSI: 0000000080200204 RDI: 0000000000000003=0A=
RBP: 00007fce260fc59c R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 00007ffcd72178df R14: 00007ffcd7217a80 R15: 00007fce27250d80=0A=
 </TASK>=0A=
irq event stamp: 799=0A=
hardirqs last  enabled at (809): [<ffffffff81625d6e>] __up_console_sem+0xae=
/0xc0 kernel/printk/printk.c:345=0A=
hardirqs last disabled at (818): [<ffffffff81625d53>] __up_console_sem+0x93=
/0xc0 kernel/printk/printk.c:343=0A=
softirqs last  enabled at (850): [<ffffffff8149f58d>] invoke_softirq kernel=
/softirq.c:445 [inline]=0A=
softirqs last  enabled at (850): [<ffffffff8149f58d>] __irq_exit_rcu+0x11d/=
0x190 kernel/softirq.c:650=0A=
softirqs last disabled at (829): [<ffffffff8149f58d>] invoke_softirq kernel=
/softirq.c:445 [inline]=0A=
softirqs last disabled at (829): [<ffffffff8149f58d>] __irq_exit_rcu+0x11d/=
0x190 kernel/softirq.c:650=0A=
---[ end trace 0000000000000000 ]---=0A=
