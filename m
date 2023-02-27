Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1E6A3B37
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 07:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjB0GXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 01:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0GXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 01:23:15 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0ECA5DD;
        Sun, 26 Feb 2023 22:23:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOU+jiIovKKoQeU7BCGwjVg8bWiKrhnaSLqTN6jlHKHxfwGtkia0GkoWpr2ktalHALux1kmqnkViZmameX1G9O9gywsWozpaxOg1Xu8gjU68NWP3KO1aUVbcklBlgewAjNg9ks248suAB//Md+KmuHzF6SJ6Ipttu/20J00luuqpulo+8ECiv5sMutUHdDCuWJJ5KGlyFvzkpXPfUHod7xH/I3Oz9oCfv4GgFFFbvB4ffhhb5URdQf1RldN4QAc/MMa8aLPhJ/RUk6YSUnSmsT2oTgEsSIic2qWzrgbkKt1YYUmTNTPBJ5Ot/fc+kvGozLp+0xPVPLt1CDhpZ7onbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gp+W6ByQO6+zQfglWMbSAzGjJ2OWYV+e+QxFNqyI/Ys=;
 b=LNT0eXoKr677cNY8Sh3iC9Q+8bjM9zpMfeSpe9AxGg1KmeDAW2tV8SSXGpLFhUGgYe/GiMPB02pCbZlls9ITYYNR5OEt32K1kuo0kxEysO/Yu9iOhYqOgtSTvCxUuRKeTmBy9lLnb/3TfxmnOXeFGfL17emuR56+12VB3WcYRWoiiOaSLGVnxs6NsUbHuywxt+Ljtuizsf7nZ9eMzVMC+Fcgy6rV4ubuJDttsId6edvYgj8P1ksc8dy0uvcbZzJ6Ooxb57VeUYYuHPUfrj4APqc3P0WR7S0R9+7yn0PF+uFOgy3lRdaX2+Bo4S1D86OHY4NDSZg3p+J+MCQc0rMnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp+W6ByQO6+zQfglWMbSAzGjJ2OWYV+e+QxFNqyI/Ys=;
 b=YgytPs6VuOZPaYVVx1vhQ29ARcMn9KN0udo4AKud/MWjgSC6u+tOp/gWrgUgBCnRtX2XUl+qEjpg1tggLhw7O8hdOR4av+Oisrpx1PHKJ7DO41NTIVJyvdqf+KppN76KmfUnJ6hWTw5Iuz/K3DHo3BMPBJI+DcAa1wi7bUxQeMQ=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by SJ0PR07MB9123.namprd07.prod.outlook.com (2603:10b6:a03:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Mon, 27 Feb
 2023 06:23:11 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 06:23:11 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "efremov@linux.com" <efremov@linux.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: WARNING in process_fd_request
Thread-Topic: WARNING in process_fd_request
Thread-Index: AQHZSm9xdwAt+ZDqT0OADtKdUXYJ7A==
Date:   Mon, 27 Feb 2023 06:23:11 +0000
Message-ID: <IA1PR07MB9830A0BF37B0A979C2018EC2ABAF9@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|SJ0PR07MB9123:EE_
x-ms-office365-filtering-correlation-id: d2d63219-aba7-4c34-14b8-08db188b19af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Z6H8VCqmwXUC4+FUHNLgHePtf1TqaZtNuy3UfP8XL/xa+ZGKM/D4EDQfk6xyIqwaGjXUN9FIlPcHlHwb+o4Wgzgyu747zfum7jMfEflOeCIyFFBTpR6r4XtToilbc6RBuKu59kmbJ9DstldHzh5fgKaSfj0trEwYXNKnfQcISxwgQPWzKhFzqSF6JO7IOvy2XtWlPPQvp7Hh4SxPUI80QAGznSjkqFUR/bqZp1R9EKgo9jcJ8gH79MyWQtBDwYstFSFqhmrohLpuIv2Ja/8iC+7buRX2MdqljCpixyV9CB7eAlyxxcFLPyWeX1spa8bukIkhznEWOT/vU/rC87lS67HfRctuLSVzyn0jZgxywaf3inN96Fium35tWzB8D1LQCAxGgXscX38CIjUwdIQwstpom/69m9umgTsGa1DSi1QK3D+jQ9YvSaEifbCs5xh9FlVJyJuNEPlJjc79OV/NQ971h1KbbXmSTlUZwWUzIv2yUjuk6kviiPOHv3CNCtciUkE4xpFN54K4pkNMesk9XRSk93GImfqsVR07AJtfDPgH8l0sZFk/jqqTvaqni6Pb2sgQUAUnR/DhxDsAGIeatq+4LTSzqvcePy4qYdDCfOZMDytVaLKMh09iOuvoNb+Z7kOuNQyZvTfVWGQiH7IaYNU6RPgbKrUyCg0peGCKTNiaGWQJg5WTbrFCOS+GsPra5CNi2GMPwCcO5UxSvxni0Bp91oArtQ0HKs5XLZcz8g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(83380400001)(52536014)(44832011)(8936002)(7116003)(2906002)(5660300002)(122000001)(55016003)(38070700005)(41300700001)(76116006)(64756008)(66446008)(66476007)(66556008)(91956017)(66946007)(5930299012)(8676002)(38100700002)(4326008)(7696005)(45080400002)(966005)(86362001)(41320700001)(9686003)(186003)(26005)(6506007)(71200400001)(478600001)(75432002)(33656002)(316002)(786003)(110136005)(54906003)(58493002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KhAAVu0IKtAQoUUHcot08UA48TVlTKe/plM0+/6cLDAAeP3Rbiu0OSmu0C?=
 =?iso-8859-1?Q?BiMaHIXlmHl+KNuqLkZoL6Ei5ljQPp/8Gfdiwzo4Gfv1RoFzfqog97KH0g?=
 =?iso-8859-1?Q?BvQuMZkQytNoaIkwP3uf7nqAASelOn1t2lKyqjjO84XFtUmsAYimxDcQpY?=
 =?iso-8859-1?Q?EABHBlkKR0Jfwmi2WbSnu2PME9Ih/uFgt7ia9B72yiipb0ksYDnbnKNTIk?=
 =?iso-8859-1?Q?YHKKoE9zDg7M5YpHW4xBl6+AXTWOi9tpZFLfMGLX4vUJfynfkcqP3QX4cP?=
 =?iso-8859-1?Q?DYRSlMPs/eq01YoUMnbn18RmzWsVOZQy9rk12fE+hkiFmrls4W64Oi32A3?=
 =?iso-8859-1?Q?4lR8iS3C6B1zZj7xvjNhD46bfc4xjtyAIdOMe2vu/fu4mV6TtVXy+wB3tL?=
 =?iso-8859-1?Q?zv8A+adWAITbV2T54wLdeylw7VimS53i8zbTrC4vzIbCw8dIShSXc38I8z?=
 =?iso-8859-1?Q?7nCdDOEi3UKprO8ey+wEvIWl+V34WrwCB2cVsRL8bcZsochPbvbmBgqe6I?=
 =?iso-8859-1?Q?ydSXaUZWlYZ7+hpg5lCz2GjFT6yfbGJJ+RzjONOlVwBLWqgRDqVHx8Pji9?=
 =?iso-8859-1?Q?sJV/0Ld/T/gcOHLv+czWBS9VHTur1v4Pn80p+174WgKKfEDXSZ+qrbgu2U?=
 =?iso-8859-1?Q?BTBmEffBcA+Rn/Q4dAbZUzZmKZXPOdPBcfECp49VN6wMWvschwtrg0ojqB?=
 =?iso-8859-1?Q?fpGRgdC813vbItmEPQoNP8765y728Rfahp+mVpfn9+UUqIpgOZHEHtdoFd?=
 =?iso-8859-1?Q?KmvJak4S3vQ32EADQCJkDxl4/HcX5KTMV9vAPFKj3N+xIe6JJaBffR14QN?=
 =?iso-8859-1?Q?gU1qm4AtJ89NnRx3tJhwHVvIBozE1Y6yevDef8C9YqK54rimbVTkwKlFYz?=
 =?iso-8859-1?Q?Lycon5H9pPjLNPnH+BgkHlRWW6uSck5JaKgjgxBY6nP8TZdPf9qECo9UBR?=
 =?iso-8859-1?Q?u13liSvhECYY9zfp6GAfA2/zALDoaud5BwnpMIyqig2aIXQ8LG2XPxKMHO?=
 =?iso-8859-1?Q?bZQJxQZhTth//obovHNyAoGMhLuCv1RGeMeRRLcWgBwcKdtLtRE+GGgbCy?=
 =?iso-8859-1?Q?kWuF1rZ1DJFsAIG3VbaKRD4i2xVLrL36AuHvKt6QfEv6E1AaMNE7buqOob?=
 =?iso-8859-1?Q?N7KzPKSs/e3B8HryYy2bcoFTsO+ovfepw72BrXwNV+3VDRUoVAZNYYlavx?=
 =?iso-8859-1?Q?FFzLj5PhC7xDTvZUBzBX8odKTtGHJQ1F1Iqa5j9IgSOUTdzQIukZ3+CH4W?=
 =?iso-8859-1?Q?GsFMJN86rFOltygkTrLB+/Gvw5CmW0UJg95C4lOzCeaGT6B2S4LeGDnVhU?=
 =?iso-8859-1?Q?oX3TVjmlj++nXiIkF4cHTSBjhQAHFnt50cjWRdZX6OwUXxNYkC00DuhRB2?=
 =?iso-8859-1?Q?kBpnB/lg42nXn4L/hVsdhivBha+DAk2RQks1N3FLZleIyo9sXePGkWDL66?=
 =?iso-8859-1?Q?LfxE5x48hr825nKuZIdOsqJdD90QvNtd47mfbXYJCUgxX7wS4HbpHwIyuE?=
 =?iso-8859-1?Q?JTehv4w09rayGJKcFJ1ry7x2SuqBeWdPc78v+5niKl97d+eAk4UZnFiqFx?=
 =?iso-8859-1?Q?aOQIy401KJhqv58IUSmgquxUNqZd9Q1qasZEEtJN+ii1cBG6Hp/FHt6vKt?=
 =?iso-8859-1?Q?G948XBLu7In1ZG7m6JWMuQSW+UpM8qVEsfKcsEjpmcedDnyn7GYb9z8Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d63219-aba7-4c34-14b8-08db188b19af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 06:23:11.3013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNBLdCEPdqwcaIOi7Z6DnNtax61cwxbZoVPpf67WNIjyyTGiz+4DQKWjPMIrd5KMjVYTu04dHByytVxf+0T0NHuZGHpADFJtSqBkv/bGCF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB9123
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
Kernel Branch: 6.2.0-next-20230224=0A=
Kernel config:=A0https://drive.google.com/file/d/1nlVJD4vp7iMOPapFzdASZQ7JS=
iDf6SwY/view?usp=3Dshare_link=0A=
C Reproducer:=A0Unfortunately, there is no reproducer yet=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
2=0A=
floppy: error 10 while reading block 0=0A=
floppy0: seek failed=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 0 PID: 6994 at drivers/block/floppy.c:999 process_fd_request+=
0x6b/0x70=0A=
Modules linked in:=0A=
CPU: 0 PID: 6994 Comm: kworker/u16:100 Not tainted 6.2.0-next-20230224 #1=
=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Workqueue: floppy floppy_work_workfn=0A=
RIP: 0010:process_fd_request+0x6b/0x70=0A=
Code: fc 5b bf 40 00 00 00 48 c7 c2 60 ec 6e 8b 48 8b 35 1a ab 69 09 48 c7 =
05 2f a6 69 09 80 5c ec 84 e9 8a d7 68 fc e8 45 1e 97 fc <0f> 0b eb ce 90 4=
8 b8 00 00 00 00 00 fc ff df 41 56 41 55 41 89 f5=0A=
RSP: 0018:ffffc90008ad7cd8 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000=0A=
RDX: ffff8881091f63c0 RSI: ffffffff84ec2d3b RDI: 0000000000000001=0A=
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000008=0A=
R13: ffffffff8b6eec60 R14: ffff888109d41c00 R15: ffff888100079000=0A=
FS:  0000000000000000(0000) GS:ffff88811a000000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 0000000000000000 CR3: 000000010873f000 CR4: 0000000000350ef0=0A=
Call Trace:=0A=
 <TASK>=0A=
 seek_interrupt+0x160/0x510=0A=
 process_one_work+0x9ba/0x1820=0A=
 worker_thread+0x669/0x1090=0A=
 kthread+0x2e8/0x3a0=0A=
 ret_from_fork+0x1f/0x30=0A=
 </TASK>=0A=
irq event stamp: 647601=0A=
hardirqs last  enabled at (647611): [<ffffffff816802f8>] __up_console_sem+0=
xe8/0x170=0A=
hardirqs last disabled at (647620): [<ffffffff816802dd>] __up_console_sem+0=
xcd/0x170=0A=
softirqs last  enabled at (647436): [<ffffffff814f69a8>] __irq_exit_rcu+0x1=
88/0x220=0A=
softirqs last disabled at (647429): [<ffffffff814f69a8>] __irq_exit_rcu+0x1=
88/0x220=0A=
---[ end trace 0000000000000000 ]---=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
2=0A=
floppy: error 10 while reading block 0=0A=
I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
2=0A=
floppy: error 10 while reading block 0=0A=
I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
2=0A=
floppy: error 10 while reading block 0=0A=
I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class =
2=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
floppy: error 10 while reading block 0=0A=
