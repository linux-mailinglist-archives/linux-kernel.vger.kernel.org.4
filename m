Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C2168A258
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjBCS5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjBCS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:57:09 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E58A640E;
        Fri,  3 Feb 2023 10:57:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw6i1ce/1ijwqdWMxNjCqf5eJDo21If0v6BpoHzqcLyTJwVoANoc4YAfFYk0/1RJ0hf8t38I9iu91ZXT5jkOPBNS/8wjhKq6UZpOKs7XIsiVSg0bBhykJHs2S/b8kp1MCIrzq54+zlHabPzRfOFg8QV6glC4WUccwncE3J7NxDYbGGGTHhCyd7OLwv7qUMCKv3jg7Y4qsoo3jIFkx7hkZRfy0zu1B91PePu2DdnceJXb3IUmAa5XqlUwsnqZos0ycNFjbcJQRCyhB74+rIcANKunAvbcjaZ6y8OtrrV+cyRWCzbusLODYwgE3tVcKK83UvZtOZaEF/1yFxIHkJz2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i446FZHSNqpKbZXOm7yVbvnNzh7jw05OyWI+2xm9H0c=;
 b=nb5Y33mja5wyUs3HK8e+yfNX3MpirjeRwQDYJi0SWjNpNfWc6pP4MzRNetShp1jbR8PDhRXlU1Bplzc9AynDFQMLgoAGWKVDR7gRZhxkAR6uKZncQacMLi5LFOItQJQfjxRHnX3TtwI/9na4CBV4r9PTk0JUOyt1NF+GzhjfPen9ih1ZIBPwQH3rJ1WO1PdZsfn1dHYscrHIV27foydr20QhhxVeUN+124xQOdlUG4pBacewHifwFof8bdQG4k2p47v4hDnVYym0sWDAz7jgDGxPhfYqMF0SlsABJCKDsYucT6rOohhZukRxaBhtHJlM+/vvZCjvf/dGMt/s6yvvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i446FZHSNqpKbZXOm7yVbvnNzh7jw05OyWI+2xm9H0c=;
 b=Lfr6nIDjLL74sz7F5TquCO15kFCGwQWrckf8U0m9KHq6hHTBqETgOayeGAvJthrUq2v0n1r/n9Gj7UFzIReC8mFd4BZHyyqA3d6FprURttM02ivsw0WdNX7DcOv1zjY9PnlAPt9vN0oalKk+DmFGPPHFctyX+bjBhu+1UG/lI4g=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by DM5PR07MB7894.namprd07.prod.outlook.com (2603:10b6:4:aa::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Fri, 3 Feb
 2023 18:57:04 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace%9]) with mapi id 15.20.6064.024; Fri, 3 Feb 2023
 18:57:04 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "efremov@linux.com" <efremov@linux.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: WARNING in fd_locked_ioctl
Thread-Topic: WARNING in fd_locked_ioctl
Thread-Index: AQHZN/66kuOhd6vt+k+oHMbvjov38Q==
Date:   Fri, 3 Feb 2023 18:57:04 +0000
Message-ID: <IA1PR07MB9830470F72201FA675F671C1ABD79@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|DM5PR07MB7894:EE_
x-ms-office365-filtering-correlation-id: f2d2d3c3-9ba8-4eec-3afc-08db061870f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCSIAYvzC4sixFthgQQcBaglAlnXM3o7ok9ETwfuctFwmTLNyY/aQzSprlSoOqRLIXhz6rYD1ZqKnkPWkdbVsQfDsB0mzZek/MFs+88fEdBMRk8ShINOcpDMa708dKNt1MbLW2VVmzvVucoF96iy9IOOgkByO8ixlCB0Ks5+GfTUH37LgtEGNng7iWjF9L0+nbS0vEzMmRTcoFP9OSgH13CZqIH5mWr4Kbi+uplQX03Til6FOu23yPvFobMWLLvXPgzt4v1INrQbBN5XYfFESKhI75xVkdxgByTLfVDFsG+ZBei+a6gviUTVCSXoKtdXtrr9kzysMzVF6PkBHI2QmqHExBscyV5pv6TWWxA5T5QaS++5Egi+XqTPkOGyALu8i/ivtDsrBGiclcUO2k2kXUjdeCWstY/AylXIjgWTU6P1ivDqmSxE7Qw2NRgdOw1/Q8+HuF/CKe/fGtWZCJAUJqxeii0jMfHTBxB29bA+r3iaiQdjvIRIFg+iQEDB7U5qJJ10RqPpmyAliC0GTTDa+eZSGTA7P3B1Ohdep/6EqlNiHjmBGwXH1gu0isKq3FTRUYScdYbsPolBJ/rEWLssrFufqqOtJl5ycfOWsAja4eGG1NW/08nxHlKa83tmSSOtSfEqE0qRoOxLYt7cuN7f0o+WNBgXUs9LBINekGZzPNw61cES9lumLnT+XfbUUFhUQDwDulQa8jt49r2QbGktnhdhn4chivl47bYWkJJKzJwNeCiHQw3OTSSQq8ljQG7FXTR+VDwMzZUtp6+r1fD7XHqcQcGpzTQGvpFSatEXRDNq5caZJocko3HWPam9fRDZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199018)(7116003)(5930299012)(478600001)(66446008)(2906002)(64756008)(4326008)(8676002)(41300700001)(52536014)(44832011)(8936002)(5660300002)(66476007)(316002)(76116006)(71200400001)(66556008)(91956017)(45080400002)(110136005)(54906003)(66946007)(7696005)(786003)(966005)(6506007)(83380400001)(26005)(38070700005)(9686003)(75432002)(186003)(122000001)(55016003)(33656002)(41320700001)(38100700002)(86362001)(58493002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0JQkItkgemoFeFy5q3RUlvFraCCZYE9NCbdeO2POWxMzihDeOnTzheCQr1?=
 =?iso-8859-1?Q?9ewBHLS1qS5HPNDBTkD9BadYTk89/2qm0h/z+jvBDWCKcSqOgQaNuM30dM?=
 =?iso-8859-1?Q?hKDQgh2RkMfWc5W66uzKMjnvXbXsEcWImWSfWhUedxpX/HX4TnkxK679fw?=
 =?iso-8859-1?Q?3tlMQxvCdep2rqBvnpfhmI/UTLG5aw0Rchr6Iu1BPPCGxIXjqMo93jeAOI?=
 =?iso-8859-1?Q?UVEB+tNIxXgoilX2h3TfQ1WXN+EFpFEHd/eLj1Qx0OwidBviCWw0E1kL8y?=
 =?iso-8859-1?Q?gU2cq1+OQI9bcCNVcEcqn5qHwlIExO6eKIQeDNpAUSdFwHPjdHPrgC8tyj?=
 =?iso-8859-1?Q?sDFsPnQcG8oYPEzZq8F8ENs5rw1LEKzdKgJJXxHNctASgZLFZkVAQPNwVr?=
 =?iso-8859-1?Q?Sorh2Mt41+INQjXwQV01/Q6KDlNyGAgdGB+X/mcIQEb4D5vMV5UDY95mIl?=
 =?iso-8859-1?Q?Gvfr2M942LagPKe5ZEb8/mYQW8NWWdBnBtpOjoV8rzmuOXFx2/2PqSaxoN?=
 =?iso-8859-1?Q?8JVztSDxH17Vr/ZkcABjTce2w3vVfIPVlBCC3S3Hw4hWFqe4ZNZudG47pl?=
 =?iso-8859-1?Q?762PLJ+0JE6G/bS3fgpNTzDe2hmvHsRuUQQ3F7EtwsIBX9qgIRc4Qx+Wmx?=
 =?iso-8859-1?Q?Q9lxgZTuCtAd9C+66tz75Od5FZJJQtgtRJrKHdjLgjoDfyJE4zaSr2vmKZ?=
 =?iso-8859-1?Q?uzrlv2KmJpByLMoy4kTHqZIlYBgg0+EQQDsYAVbvbX8si3b2QjiwCPnD1I?=
 =?iso-8859-1?Q?mJB01EUZ/kTKfF4BrN5zF51jaSoCq9zhRvTSqXsHlTx1NNi/Q3FmXguG1M?=
 =?iso-8859-1?Q?/2M48PD+vqcpoJ1v/NxJAyisCpKNx/sUNHaJ28hUJfyKiCdH4YlJ2AYwkx?=
 =?iso-8859-1?Q?rET6sFzBWy3J/27A5luWyY+C4pXvV8IEZ4KSLsqrrQJumo6M+ZSmQ+8BBQ?=
 =?iso-8859-1?Q?ks2W92c1alm0FYpnnGfOt7OPyS7rEH9wBkn/aXubOm14mkXzHY0fA3qhBc?=
 =?iso-8859-1?Q?5a4lMcNJmW37M+lz1LJie9qupMwPhzw8g9S6FZZVQsiBTTQeRadblqi8dW?=
 =?iso-8859-1?Q?74JdIf1by90l7Zxed3zfyZH9dawmnLslsyT9XaBYVi32+w6BUTKrZ3aVJs?=
 =?iso-8859-1?Q?DVPq/EM2SobNDdPmw1D6gWWceA7imW1X/rR+ZwMgNeBpYyQYxdAK432+C7?=
 =?iso-8859-1?Q?ID78beeKo/fijcWwL6jfnsF3zAuQtWsT5MHtUHZY/GDNvgU6DUIM5DfGSj?=
 =?iso-8859-1?Q?bpfouJ4xiJ6CkJf+sXfX8D282H6JZ5vc9QajlW5+Ypu2s6NHxVox4f/83m?=
 =?iso-8859-1?Q?i94RNqEU/f4iEGip8GI7tGh4DnnIcuzX8NwAOX2alaVrw6m/agivq8+RhL?=
 =?iso-8859-1?Q?43k6DZbAAN9dXutDSxy+/zjphJwt5RZXPR6NwyWNi5FdIRmjL4VrN4j3jf?=
 =?iso-8859-1?Q?0JET9TeuLVgNS3zs9gtqXRhRT1qG3lp/8+QvD8L9g8FoLIyJxxey7qrbPw?=
 =?iso-8859-1?Q?6i2kn6Q0Hiv08ubMEuqJcmNjR5LWYWF5pN/wagxxCbDnC7LIgXDXSlYhHU?=
 =?iso-8859-1?Q?noiPvuCsRhqe2k89TSQW9g3clR/L8f9sh5Z+fldg+2o8gaWCSvTWXkbivR?=
 =?iso-8859-1?Q?it2JHJ1JOL1+D2LsqRdZXx2ub7/PhPb3P639etTxBMZ743v9YANg3drg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d2d3c3-9ba8-4eec-3afc-08db061870f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 18:57:04.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ar783OkTf9/qDvUnBZ5s6xZ+ZFfRWFIsVGVBHNzuBG4EmCOg8Puvhvfu+QKdG400Ogz63QbGUGtHRD9XKVBunPU9xefTdoWDYAxfJQKMvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB7894
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
Kernel Branch: 6.2.0-rc5-next-20230127=0A=
Kernel config:=A0https://drive.google.com/file/d/1SO_BtkrJt5gJwJAyWYIDu4cc7=
SuYqjVr/view?usp=3Dsharing=0A=
Reproducer:=A0https://drive.google.com/file/d/1v8j64gBGvdpkOEsxBXZHvFVXm6Ag=
P6dn/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 4 PID: 24921 at drivers/block/floppy.c:999 fd_locked_ioctl+0x=
14c4/0x15e0=0A=
Modules linked in:=0A=
CPU: 4 PID: 24921 Comm: syz-executor304 Not tainted 6.2.0-rc5-next-20230127=
+ #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:fd_locked_ioctl+0x14c4/0x15e0=0A=
Code: ed ff ff bb f0 ff ff ff e9 e1 ef ff ff e8 d4 02 95 fc 0f 0b e9 56 f3 =
ff ff e8 c8 02 95 fc 0f 0b e9 83 f8 ff ff e8 bc 02 95 fc <0f> 0b e9 90 ef f=
f ff e8 b0 02 95 fc e9 4f ef ff ff e8 f6 cb e2 fc=0A=
RSP: 0018:ffffc9000d39fcc8 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000=0A=
RDX: ffff888111ee0440 RSI: ffffffff84ee1da4 RDI: 0000000000000001=0A=
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000001 R11: 0000000000000001 R12: 00000000400c0248=0A=
R13: 000000000000000c R14: 0000000000000000 R15: 0000000000000000=0A=
FS:  0000555556282480(0000) GS:ffff88811a200000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 0000000020000008 CR3: 000000007e165000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 fd_ioctl+0x39/0x60=0A=
 blkdev_ioctl+0x35a/0x7e0=0A=
 __x64_sys_ioctl+0x197/0x210=0A=
 do_syscall_64+0x39/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f214104212d=0A=
Code: c3 e8 f7 25 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007ffeaa10e7f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=0A=
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f214104212d=0A=
RDX: 0000000020000040 RSI: 00000000400c0248 RDI: 0000000000000003=0A=
RBP: 0000000000000000 R08: 002364662f766564 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeaa10e83c=0A=
R13: 00007ffeaa10e860 R14: 000000000000091f R15: 00007ffeaa10e8a0=0A=
 </TASK>=0A=
irq event stamp: 1413=0A=
hardirqs last  enabled at (1423): [<ffffffff8167d8e8>] __up_console_sem+0xe=
8/0x170=0A=
hardirqs last disabled at (1432): [<ffffffff8167d8cd>] __up_console_sem+0xc=
d/0x170=0A=
softirqs last  enabled at (1240): [<ffffffff814f4918>] __irq_exit_rcu+0x188=
/0x220=0A=
softirqs last disabled at (1233): [<ffffffff814f4918>] __irq_exit_rcu+0x188=
/0x220=0A=
---[ end trace 0000000000000000 ]---=0A=
=0A=
