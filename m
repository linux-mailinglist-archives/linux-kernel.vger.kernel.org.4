Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AD868A25A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjBCS5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjBCS5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:57:14 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C31AE846;
        Fri,  3 Feb 2023 10:57:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+wn9+nNT0kbfj2yYDimnjqEjeB+k0RCBqkL8+eeMEpzsSf/X7cEK4vBujE74kykmdqd2KZf/Kk7l9KxZ09fg3vRER7mmOqYW6bmcoWqZD6tjwYPp8P9DaqPvqjCvmE/E4iMTYYFfBXiY40IGZ6W5nDQX1YCrD0FvjZ2+QMQ+xngC+NryD/8DVook54YVylUDlA5/L/NjyIJpTu+v+N9ACfSlKq1Yx8XetglYB6F1tFNBdJPkQN4KRiGoqSrOALp27fth1AEddl8jJT+bKp9eW1gaM8pUkqDZydU7p9sznKm4hWrq1rwRV3yXRznCUCNo2DCGZsTUko/B6bacSjdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIP9/RsZ3O/noXqCt+u0l93LL+xalhKJ9kXz+RyJT10=;
 b=kBCorrUXR76hFjVqY4eDk0UUDTw0645rNSOiDoDnRhR1IsYDnZ81RRMm+tK0HMG6dy7xf0KZOjsPwrqOK9tNjM4RlG/3VHuEkFAFzGWz84PCyTWNEi1w2DdjG6no7HNIjh1ZYZWY1ZbE0yQ1q77TafbR01OFbjNDvESZYZANtR7zcw3LFE9mZn4/EjshjVsypEOSwoaVWGLE3xEUbmS0+DyEY3omHHXK9S6+9avhGKS3qY/3PdOSzy8SvSF/fLh1894t/FfSguTrH4kUUHH+zCv/8JOXGfFfAy7oOMqKKXSuHnQnwwcw6QFBdHgbNvxBxPgBxM6TRzrK2l/4MUFRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIP9/RsZ3O/noXqCt+u0l93LL+xalhKJ9kXz+RyJT10=;
 b=TdB+pmmMokNmsD0ZOzh10bItnU67HdHlpAYq+QPc5tZBQ5OxnP1X8Z18ariaG06pjDuPdG1h0ob1wd5MO1C+SWBYim5W/UTvO8QdqVtMqUBODGHykvkyBntrysVT9W2hrjW2Lr5dwt2Z4is8h0pxQ/KD5VsbW5iNFSHlR+D2xbo=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by DM5PR07MB7894.namprd07.prod.outlook.com (2603:10b6:4:aa::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Fri, 3 Feb
 2023 18:57:10 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace%9]) with mapi id 15.20.6064.024; Fri, 3 Feb 2023
 18:57:10 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "efremov@linux.com" <efremov@linux.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: WARNING in invalidate_drive
Thread-Topic: WARNING in invalidate_drive
Thread-Index: AQHZOABOlP3JSf175U2Nu3+u6tvE/g==
Date:   Fri, 3 Feb 2023 18:57:10 +0000
Message-ID: <IA1PR07MB9830B1C6FE306D1A4FBA58EDABD79@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|DM5PR07MB7894:EE_
x-ms-office365-filtering-correlation-id: 3127dca2-48de-48bc-2dbb-08db06187486
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7lXnaKtFw23O1t3yBOUbPlYenT1sCLHSyYj7UyGkE4KQqsT2keLpKJ/T4OT4PstfK3NQ7xLdRNCRKYNKUiOZ8acEW96tsQhpV7D/hX6ptgu6l1YyRPKnE8QrpcxGmDiA+cx+mIZ6OPyMfN9lBHWXpC39Yo/jtdD1ovDJqOWfGgn2ocpq7CBeM9nYuX8WsLvYhHpcA8FJb//mX3JCzhO+C11P7hzrxxBdrovy/kDPqO64BMQbM9ZGhnK2ALTGbJ1kzAy6Paob6U+C/g7i6sFjzkQrDhrC3844Q0MQF+/qY9hkRjiCnkB2n/V/bQhWpBQYzVeeTquooO4pAKwkXjp6Wj+aKWQkMyEtp3lSRcXMTbqwoe8qN9+sHbX87XMkoq0tNMPoX+Hja1QwuvN3LTHGN2k3HPCO1+5wNo7sFaYjyb1J641ynUMP70ukb5FhI4+wuNwOVxdg9OSM0w5QR5pkz8X9shfSiOkZWtoz55dxt8X1QAnrBcoU8VuHVlphebClNXtR7wjr7mRpJykJj6ybmIbb7b1VKvMNnndm/W5TprExSUQtBcK1vAh7Z8C6Sa83prtIJEnpCO6RgQJCvXXt8ySrwAgq+rb2/rgrW6itzyy++P3sKBsRFTde3B7yUFn6IG8983WqX1casZfsjYTWZOossPTnVXeRDxpanm8igFunHuIqkESidDqLZ45wfToCi6SutlNTPtzCuyUx3nO/oM9sPOA3xDeJvWc4apHaEeAsKbOIVpVBggMnrkPgFGRHe3wfzz4PoAbzownFFNDtHFjdYUqOqixR76Uk/RRWOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199018)(7116003)(5930299012)(478600001)(66446008)(2906002)(64756008)(4326008)(8676002)(41300700001)(52536014)(44832011)(8936002)(5660300002)(66476007)(316002)(76116006)(71200400001)(66556008)(91956017)(45080400002)(110136005)(54906003)(66946007)(7696005)(786003)(966005)(6506007)(83380400001)(26005)(38070700005)(9686003)(75432002)(186003)(122000001)(55016003)(33656002)(41320700001)(38100700002)(86362001)(58493002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?thhvXNjxAP4+4lNC1xm7R7CgcG4dZgLbZR72HJMeWIZro+/wiLDXQGANXO?=
 =?iso-8859-1?Q?xwLEaE8NyJhMLi8jvWonMXtNKNSjs8UwCi+uSvwlAmzhVHFN0RQSJfPsFV?=
 =?iso-8859-1?Q?8MMIdMr5w6viOsJ/dUa3sJrFes+Qdp4tD9iWGof/0CQK1I7+pXbNE/3knv?=
 =?iso-8859-1?Q?G+rHpEbTyN5R2yuMn3K2b8TH/3rgvuod/C3i4sVaTmdLUkD/B9woC283wt?=
 =?iso-8859-1?Q?jQCTWfUVGgsf8l1OQzTnQ1C6UmBAKdaZ0GTeSDwMO75d/bVVBSgPLDMwZO?=
 =?iso-8859-1?Q?bKdxk+QN+rIMqpCH6OSOLmQCP7nLwwmSe04Y54LnOTGabKk35nB2qzNpTH?=
 =?iso-8859-1?Q?ElKXw7jV6IlOLBqz7/xAsFfbxMnUqUPn6J/nuq6k6WvglVcuDe2PlYQ/fE?=
 =?iso-8859-1?Q?ZUiu/mFkJbUJi0gmuiSghs+sLRLV7x4H1JagJxcUEN1rbmWhsjqIVBdm4c?=
 =?iso-8859-1?Q?Rq6PizGYRroM1qbP8thMAZYRucOmjlJSZcnI3wyBZDYHd2jjiU7hJVWfDc?=
 =?iso-8859-1?Q?6vrzPp3uvGeleZSDbATnsMxiOLmzmedrtWtR6g96qHJ0T6lJdBk2EamVpU?=
 =?iso-8859-1?Q?x4D2UaAtVvSknHDoIUrdnnpiKOAHyxvLL+zP8ghhd959O8r5CZVaawW6x0?=
 =?iso-8859-1?Q?rSvCWRfm89buswxvK6YToV0NUkXO2vEGDCD66Yt2G05oxWntaWIeDPo0jS?=
 =?iso-8859-1?Q?CDDuegaCQ1BnjMZC3PvB6lWQG6UNSqjrDWzOQXlMQuJnmMoQLr/KpJ9W8Q?=
 =?iso-8859-1?Q?gTOsCguJovBUXfF2CHXL3FkOfVxkTp0DL4A3fJlDTBCOfYn2qSpnqrMHqx?=
 =?iso-8859-1?Q?wRtWJiJnBHVzBRFcLFM5Bp3LmNaVavwu8gTKjTzZ8efKd6xrxgJM6zYI7G?=
 =?iso-8859-1?Q?Qke0bPDBf2McvOJFo1OEXMyEb1qi9lfGelPgGuHbb+pWT4PadqhXMxPLaH?=
 =?iso-8859-1?Q?7RWEi4QbBMXenOonFIcIV9OaG6m+9VMlBit85HfEHfKEzTedoURiiYmOfT?=
 =?iso-8859-1?Q?K8xNeAIGc7gqaCP1JWZD751ec7oyhYzakAqpylqq1Qa/Z+KzGLToHLznvb?=
 =?iso-8859-1?Q?vbrvuYiyCBUDeTvVLfBt74j7JDbqepJAgM51MY/qxaQmBQKo1q1zZeJc5k?=
 =?iso-8859-1?Q?FBw2KOnuSzKQ28yaCwF6aX5Vb4u5MaD9Zna8Axcfgk4NVrlwu9DWQJB2qJ?=
 =?iso-8859-1?Q?TWiXeAwELYOhkllQY1eS/VLoGCQJ/5v/ECC30aj5hWX4YDJyJlKQJgxykU?=
 =?iso-8859-1?Q?3avqp/s2zgz18O/2hXMahFHT9yFtss3pWwk12sDVcdsbHRuLB+J+F8Dt9B?=
 =?iso-8859-1?Q?LOJQ69m1RmArBWDdIqTasJBOVao5qg8v9DP5kPtzY6JOQXmK+nldo/H64p?=
 =?iso-8859-1?Q?WpFQCI/6vGm5s1kQg4UjC7gEpo8hjEleHvg26eM+cZvNqBIxtR0AtMLj9C?=
 =?iso-8859-1?Q?Tu/JNRyQoLjakcm6gBPuCf9A4MU3XWrskXCK8ptA5vWSVTl5LivqaK5AWy?=
 =?iso-8859-1?Q?SAx9Jff41sADhjSAJ+bFeUoSqCLD+Wr1k/hqJ2TPZIf6B/N6bAAtUKloyu?=
 =?iso-8859-1?Q?QEYd/IODf3MwxwDPgo7GpPDG0YaZcEVjB/7AoB5LIRWhvUkNw6IkQbeuCf?=
 =?iso-8859-1?Q?5YTkCJDJGeTsZ9nPSQRFSwtIaKrbdPBCXnvqYWr3ywP3TbJQv8GWswPw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3127dca2-48de-48bc-2dbb-08db06187486
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 18:57:10.6989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZDLk6S4rw7TV9RYszrS/tboWVH8iUIACDifASCRx8mikLKIFMPHeKr6JueAj1Zu6AlFGa3gwSuiWHrwQIpRN9wgK3m50zMni93wsnhl/ZQ=
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
Kernel config:=A0https://drive.google.com/file/d/1t4nrvTX95c7ynGX-LCTaoi0uR=
WGYelyt/view?usp=3Dsharing=0A=
Unfortunately, we do not have a reproducer yet.=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 7 PID: 15355 at drivers/block/floppy.c:999 schedule_bh driver=
s/block/floppy.c:999 [inline]=0A=
WARNING: CPU: 7 PID: 15355 at drivers/block/floppy.c:999 process_fd_request=
 drivers/block/floppy.c:2847 [inline]=0A=
WARNING: CPU: 7 PID: 15355 at drivers/block/floppy.c:999 invalidate_drive+0=
x145/0x170 drivers/block/floppy.c:3217=0A=
Modules linked in:=0A=
CPU: 7 PID: 15355 Comm: syz-executor.4 Not tainted 6.2.0-rc5-next-20230127+=
 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]=0A=
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]=0A=
RIP: 0010:invalidate_drive+0x145/0x170 drivers/block/floppy.c:3217=0A=
Code: fc ff df 48 c1 ea 03 80 3c 02 00 75 3b 48 8b bb 10 05 00 00 e8 2c e4 =
ff ff e8 d7 6b c8 fc 31 c0 5b 5d 41 5c c3 e8 cb 6b c8 fc <0f> 0b e9 74 ff f=
f ff 4c 89 e7 e8 9c e6 16 fd e9 d5 fe ff ff e8 92=0A=
RSP: 0018:ffffc90008b47ca8 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: ffff8881004d8000 RCX: 0000000000000000=0A=
RDX: ffff888100bc8000 RSI: ffffffff84b98465 RDI: 0000000000000001=0A=
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8881004d8510=0A=
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000=0A=
FS:  00007f3593d5f700(0000) GS:ffff888119d80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f3593d3dd78 CR3: 000000001427e000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 fd_locked_ioctl+0xba4/0x19b0 drivers/block/floppy.c:3467=0A=
 fd_ioctl+0x39/0x60 drivers/block/floppy.c:3574=0A=
 blkdev_ioctl+0x375/0x7f0 block/ioctl.c:616=0A=
 vfs_ioctl fs/ioctl.c:51 [inline]=0A=
 __do_sys_ioctl fs/ioctl.c:870 [inline]=0A=
 __se_sys_ioctl fs/ioctl.c:856 [inline]=0A=
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f3592c8edcd=0A=
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f3593d5ebf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=0A=
RAX: ffffffffffffffda RBX: 00007f3592dbbf80 RCX: 00007f3592c8edcd=0A=
RDX: 0000000000000000 RSI: 0000000000000241 RDI: 0000000000000003=0A=
RBP: 00007f3592cfc59c R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 00007ffc2ffdaf2f R14: 00007ffc2ffdb0d0 R15: 00007f3593d5ed80=0A=
 </TASK>=0A=
irq event stamp: 915=0A=
hardirqs last  enabled at (921): [<ffffffff816664d2>] console_emit_next_rec=
ord kernel/printk/printk.c:2893 [inline]=0A=
hardirqs last  enabled at (921): [<ffffffff816664d2>] console_flush_all+0x9=
02/0xd10 kernel/printk/printk.c:2942=0A=
hardirqs last disabled at (938): [<ffffffff81663533>] __up_console_sem+0x93=
/0xc0 kernel/printk/printk.c:343=0A=
softirqs last  enabled at (902): [<ffffffff814be10d>] invoke_softirq kernel=
/softirq.c:445 [inline]=0A=
softirqs last  enabled at (902): [<ffffffff814be10d>] __irq_exit_rcu+0x11d/=
0x190 kernel/softirq.c:650=0A=
softirqs last disabled at (757): [<ffffffff814be10d>] invoke_softirq kernel=
/softirq.c:445 [inline]=0A=
softirqs last disabled at (757): [<ffffffff814be10d>] __irq_exit_rcu+0x11d/=
0x190 kernel/softirq.c:650=0A=
---[ end trace 0000000000000000 ]---=0A=
