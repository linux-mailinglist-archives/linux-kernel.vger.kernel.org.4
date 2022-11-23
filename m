Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F2763693F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiKWSsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiKWSsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:48:50 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AC88C493
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:48:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i45fm6kwdPJXJS/SHbdBdGZe+SkuEoFYwXI+rk9YpoEzqaSBtojND2Q1nKxXGpBmW2E9ccIWBlXg28rwIR+ilNznofRlT4pg8NiGA5f16GWgWrojknRusXJKE42MCYcRQnvJBTz77obezXvtvDBnSiz0n6wJyohmDPjq0UUC+E1o6B+kzcehJqYZgoSdgCLMC5Y1fX0i+kB5ADCHovFsYI3V/YlrNsEYEEshlwuvs5yNdckE6L+igQk3EdMGtKSmi1PVbCXOSUt5ULiRtgw6sSdhhDZVnP79YKan4oUO4yX5FYasT1T86Fob+JNJutMZalVSyganDTUm6g9P2IoV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cve5c72P4Fbej+E70JL64+8RHgfu/myaIW2PoGyJFME=;
 b=JZPLXjvVarfe1+vJNocCOX0xHzQr4TCq1yM9SkH71QKbqTAfq6utvFrxOiqbnoiGanTOtFiJ/Ox9siYNC7wbCsVAa5wLjhQ2NhV4G4WdS6ld7OYE8EksHcgox7QX4Wd8FyKAbj6B/hBSVXgqpfqAVdGUKsrS6tx5/HLwp/fYIjzmGUN8Y99SfrYA7QeOYVP8kACZ95wPLxHfvH3+DYQolhuvFko5ipE01np5jxBL5bntU9wnDsJ8mzhMnmBNIbDqS8LSRMlZwrwnoznaaQFJers5/XiaBeo/I6T37J4IlTDdu9x/PzJWRKWhuF2Z0BYGjMfVcJWpgWx7Ux6L3MJTMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cve5c72P4Fbej+E70JL64+8RHgfu/myaIW2PoGyJFME=;
 b=SNULl08/EtI5vWIxfoyvbSb3oStJ9H0LoUZaDFqBauNql9gNJfZJQGjX6Urvafl8VoRjmMmZo6RwwCtvHiQQf/Mr/WL95K88TdtyCaoZ/2WJdSpIe+5YzO9QKf7Kzs4v3+VfB15qeYpchmY9X28PlQnt20a8ZFqMr3N2WCvS7zI=
Received: from BN6PR07MB3185.namprd07.prod.outlook.com (2603:10b6:404:a6::15)
 by BL0PR07MB5236.namprd07.prod.outlook.com (2603:10b6:208:27::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Wed, 23 Nov
 2022 18:48:45 +0000
Received: from BN6PR07MB3185.namprd07.prod.outlook.com
 ([fe80::9446:f08f:16f7:ec49]) by BN6PR07MB3185.namprd07.prod.outlook.com
 ([fe80::9446:f08f:16f7:ec49%2]) with mapi id 15.20.5834.009; Wed, 23 Nov 2022
 18:48:45 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Paul Gazzillo <Paul.Gazzillo@ucf.edu>
Subject: Syzkaller found a bug: KASAN: slab-out-of-bounds Write in
 enqueue_timer
Thread-Topic: Syzkaller found a bug: KASAN: slab-out-of-bounds Write in
 enqueue_timer
Thread-Index: AQHY/2t9n/wlXEZ1HUmDIi3i8SkkHg==
Date:   Wed, 23 Nov 2022 18:48:44 +0000
Message-ID: <BN6PR07MB3185B8E16A4AA1EE384B2375AB0C9@BN6PR07MB3185.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR07MB3185:EE_|BL0PR07MB5236:EE_
x-ms-office365-filtering-correlation-id: adcbb0f4-ebbb-450b-cb1a-08dacd835955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7APqpaAqXZVjp4ZABNHS/fSo6EkNnq2G/P0W3G/aUG0ZeLKtzrAmAFchzsZXUA9y/vCH6n2R+CPMTAzpRumMJ9UCVsp3PA/xJlGXQUh8XOjfDClYEZ3/sebsbCuD3faLzIApMPpLl3Y0k5TLXF/1wDHp4seqbT7TF5/NfuP8BpDbmPmxw8QMlS53cGuamdiLXc2uImx4lvsDaxYFmuDGQfBbV+iSM1FZbuqcPSs5yGhubw/75p4oPfJ6ogwUxyNwbzXwBaY7leGcUQOI8PUrHzcZfjHIoYIF8LkIzJaMCvVAA1oS8O+Tp64WILw0omH99F2igRKrBdberdIkDZoim+12acq0HyQQBj22mf7UeVAMeWruTbKlcG6pMpJ9EcarSKCWx7x0FZ6ioNrQ82/HThfKbpL1PtDZuHDCa6CfkROlV5MI9RPncHQ5FmOKQl9TigTb2CV7EtvFcXuWEB7CARgAk/EgnV4aYYryO91mJ5Yeco6G0aI6XtHaPBSmKgmq7sbPDUxV8KOCXhKsIZphTC0k2cw4m52AXuhxWK0c9xBawbj6Np+CKPLRzIcvXzN/ohgbbZmV81vMqor43PBu+fMe2MFZ/B4YujaI3bWwpYLlwzH84cN+XcM9STiOVejhgDdTrJj0jkr37c8AUkY7eGTjSN0jYViQU7yN5If2ezWUREPAr50jw2kaarCWTxBe8ukEPhg1NstE9U56ZUY6jT1tFI0IHaLQTH5cIUUuVbu/d9v2c2HgJ8xJR0IOguaDxfjqaq0Z/lpTgwKH6CB2thYV1pCmUJyCh//8rb7DEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR07MB3185.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(396003)(39850400004)(451199015)(5930299009)(41300700001)(5660300002)(44832011)(8936002)(52536014)(30864003)(110136005)(316002)(786003)(33656002)(86362001)(54906003)(75432002)(76116006)(2906002)(66556008)(66476007)(4326008)(64756008)(8676002)(66946007)(66446008)(71200400001)(478600001)(38070700005)(55016003)(41320700001)(38100700002)(122000001)(7696005)(26005)(9686003)(6506007)(83380400001)(966005)(186003)(559001)(579004)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wIVl6kyYJfEQ13dw6ht40JyNaPlfXJH/j4k2t5oOvyUEl/UFlX/a96yEHu?=
 =?iso-8859-1?Q?StyHzGL64Pc19WjkyE1v6qA1OfW5Ik9bcYY/K3uucl+XUj2WeZTqPqXBUK?=
 =?iso-8859-1?Q?9tJ0nIMpsNYfFcfsSrvEWMWy+vtOfkjS2B1IEwZzKuwHeZ5nAfGw7JIi9J?=
 =?iso-8859-1?Q?YRpDl89Dle6sjEYrhHWox7SXFi9TmN5UQK/bruFS0EVKPxR630aSS2vdRI?=
 =?iso-8859-1?Q?hHYt2rVbiTeIiW2btWxq1jaypNQWZNbQNzEAoZ6PSNgSm6clQIX5kDA0+4?=
 =?iso-8859-1?Q?VLHsEe0amoyn8jXU5+WyqoSJNHxNL/SVm8gcpqtRL5RqeH7WCXV2iRDZpr?=
 =?iso-8859-1?Q?uKExaxc+C6Wepf+WjyF+RqNyRk8ZvMaFNPOdTGCcUDcHRx2QfwmN3WoEvd?=
 =?iso-8859-1?Q?eDmuXSjzUgyq2QHkMvn2+M7vL83QrKodNHHlU1l///tA/XmRucPg6IO1JP?=
 =?iso-8859-1?Q?LO87yK81kOfRufedmJCfjo2K6I/y6GX+oGBssv7SghLPgeP7WxLIYFp9fl?=
 =?iso-8859-1?Q?djMXY3iW6/spBRQYMpTiG2Cn81v8gxJFVIKMuNVEaY1QlECRi+kVfXXW8h?=
 =?iso-8859-1?Q?qYP07d7/b/QoCbDPsnwyk5cLtwlnPgKLKU9kOndLG8ByvaNfSJP5ioItgR?=
 =?iso-8859-1?Q?8HHRaun0KkluFhwFLn5jxNutni4iYQnUdzBjLh/pnlZwhORHiVPj0vl9hJ?=
 =?iso-8859-1?Q?u+gtYHMctBwt3HAfIwKfZI4AhGT25+qxkY4nz2ogsFn8sQV47vL3/w4U09?=
 =?iso-8859-1?Q?WunH+byPpTPIJkjqXMwU4yEftzELaVowFSjJlEUD/1zVTqbHKaSpJUITBe?=
 =?iso-8859-1?Q?bmOwUjlWfNtHotX/h9Tmvy5D7cKC45qhwGuq9pY15CjDySluHU3Z4qxzYP?=
 =?iso-8859-1?Q?qhDdqY29CJiBT3huQussDRvIVMTcO+mTBwpPpwo6lC+hudPvYc6HvOAP+R?=
 =?iso-8859-1?Q?TMVOona5pB4hOAhL+0DFvby/kIWR2m+C00qyXUNC2LpXzXqYO0MtaB0pHz?=
 =?iso-8859-1?Q?fEOsav3KNvRXKycTzpXjH4L4hiI45RNga3I645xhq61l1qVW9G1ou78Zby?=
 =?iso-8859-1?Q?dPJGtln1ycTi15XDib+0JqFKU5ZiHrOLYAmhp4TnTzqfUvrpnWT3siM6CM?=
 =?iso-8859-1?Q?ftKP4SawSoKNWHKyvHNF4za7Ct4EomKhbX4AjMv4tTYooQrjqGOs3BcA18?=
 =?iso-8859-1?Q?PWXsqGNHl8lvCxZOpxjpCctA7Wu2hFS24+/WEOvMZcsZGcjHF+gE/2yVyV?=
 =?iso-8859-1?Q?C86qrzdoT831szUknfMpfaK+HJPZNc+Cgx56A5BgTBuukGnD9lu/44XgaI?=
 =?iso-8859-1?Q?5ikp7qyL8iTM6MiQXl7i2L5HTxMOYZnjPpl1thOUSuDf/xNn/Xoovh+8Er?=
 =?iso-8859-1?Q?Dfwll1+u56ZQMlNypnIXD59bdXFG9dyQjHIgnwKd8zjr0Trh3Ur5DX5GHi?=
 =?iso-8859-1?Q?Irfc0oHWki6ExLjpSOm3NHiw5LHxvEOQOtF0Lb6dsIvzRiWk4LNr2ATWU2?=
 =?iso-8859-1?Q?4eBjIVFziaHhoju31oaRiqr4BiXu9ld7JmYhYlqGanVwjaUZckxorR9WAc?=
 =?iso-8859-1?Q?95vSOx2VxZ9UpD1Y+KXrzUajLsgKSwVI0d2YB8cNk+BrU+qio1pzdHX8NF?=
 =?iso-8859-1?Q?rVg58LEmMvmV1iMebuDu2tu18pmVBLbFWWcGWEBwrMxALUZG987n/wzA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR07MB3185.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcbb0f4-ebbb-450b-cb1a-08dacd835955
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 18:48:44.9394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsQ2lbZgpMhxxeoOs6SJm427ua5PG7n+eID2I0dRrHoMO1b+U8gS1PSr6F4MpTzpVceOPV+ICqicdS0NlcukWqVx+I/ODZlCW0b73mKCXX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5236
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
Kernel branch: linux-next 5.11.0+ (HEAD detached at a68aa48d4ed8)=0A=
=0A=
config file: https://drive.google.com/file/d/1TjJi74Vw0t1C9A62BHu9EBRDRmfPd=
OJ1/view?usp=3Dsharing=0A=
=0A=
Unfortunately, we have no reproducer for this bug yet.=0A=
=0A=
Thank you!=0A=
=0A=
EXT4-fs error (device loop1): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.1: iget: bad extra_isize 9640 (inode size 1024)=0A=
EXT4-fs (loop1): get root inode failed=0A=
EXT4-fs (loop1): mount failed=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
BUG: KASAN: slab-out-of-bounds in hlist_add_head include/linux/list.h:884 [=
inline]=0A=
BUG: KASAN: slab-out-of-bounds in enqueue_timer+0x3a5/0x3e0 kernel/time/tim=
er.c:581=0A=
Write of size 8 at addr ffff8880189b3378 by task kworker/2:2/23650=0A=
=0A=
CPU: 2 PID: 23650 Comm: kworker/2:2 Not tainted 5.11.0+ #4=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1=
.1 04/01/2014=0A=
Workqueue: events flush_stashed_error_work=0A=
Call Trace:=0A=
 __dump_stack lib/dump_stack.c:79 [inline]=0A=
 dump_stack+0xb0/0xf3 lib/dump_stack.c:120=0A=
 print_address_description.constprop.0+0x1a/0x140 mm/kasan/report.c:230=0A=
 __kasan_report mm/kasan/report.c:396 [inline]=0A=
 kasan_report.cold+0x7f/0x10e mm/kasan/report.c:413=0A=
 hlist_add_head include/linux/list.h:884 [inline]=0A=
 enqueue_timer+0x3a5/0x3e0 kernel/time/timer.c:581=0A=
 internal_add_timer+0xb7/0x100 kernel/time/timer.c:609=0A=
 __mod_timer kernel/time/timer.c:1060 [inline]=0A=
 mod_timer+0x51e/0x940 kernel/time/timer.c:1106=0A=
 ext4_update_super+0xcce/0xfb0 fs/ext4/super.c:5537=0A=
 ext4_commit_super+0x18d/0x4b0 fs/ext4/super.c:5555=0A=
 flush_stashed_error_work+0x18c/0x260 fs/ext4/super.c:727=0A=
 process_one_work+0x869/0x1180 kernel/workqueue.c:2275=0A=
 worker_thread+0x97/0xf90 kernel/workqueue.c:2421=0A=
 kthread+0x2f1/0x400 kernel/kthread.c:292=0A=
 ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:294=0A=
=0A=
Allocated by task 26673:=0A=
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38=0A=
 kasan_set_track mm/kasan/common.c:46 [inline]=0A=
 set_alloc_info mm/kasan/common.c:401 [inline]=0A=
 ____kasan_kmalloc.constprop.0+0x84/0xa0 mm/kasan/common.c:429=0A=
 kmalloc_node include/linux/slab.h:577 [inline]=0A=
 kvmalloc_node+0x42/0xc0 mm/util.c:587=0A=
 kvmalloc include/linux/mm.h:784 [inline]=0A=
 seq_buf_alloc fs/seq_file.c:35 [inline]=0A=
 seq_read_iter+0x6e1/0xfc0 fs/seq_file.c:207=0A=
 kernfs_fop_read_iter+0x3ff/0x5a0 fs/kernfs/file.c:241=0A=
 call_read_iter include/linux/fs.h:1895 [inline]=0A=
 new_sync_read+0x3db/0x670 fs/read_write.c:415=0A=
 vfs_read+0x35d/0x480 fs/read_write.c:496=0A=
 ksys_read+0x100/0x210 fs/read_write.c:634=0A=
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46=0A=
 entry_SYSCALL_64_after_hwframe+0x44/0xae=0A=
=0A=
Freed by task 26673:=0A=
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38=0A=
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46=0A=
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356=0A=
 ____kasan_slab_free+0xec/0x120 mm/kasan/common.c:362=0A=
 kasan_slab_free include/linux/kasan.h:192 [inline]=0A=
 slab_free_hook mm/slub.c:1547 [inline]=0A=
 slab_free_freelist_hook mm/slub.c:1580 [inline]=0A=
 slab_free mm/slub.c:3143 [inline]=0A=
 kfree+0x8c/0x220 mm/slub.c:4179=0A=
 kvfree+0x35/0x40 mm/util.c:616=0A=
 seq_release+0x4f/0x80 fs/seq_file.c:352=0A=
 kernfs_fop_release+0xd3/0x240 fs/kernfs/file.c:761=0A=
 __fput+0x21e/0x870 fs/file_table.c:280=0A=
 task_work_run+0x104/0x1b0 kernel/task_work.c:140=0A=
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]=0A=
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]=0A=
 exit_to_user_mode_prepare+0x11f/0x130 kernel/entry/common.c:208=0A=
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]=0A=
 syscall_exit_to_user_mode+0x1d/0x40 kernel/entry/common.c:301=0A=
 entry_SYSCALL_64_after_hwframe+0x44/0xae=0A=
=0A=
The buggy address belongs to the object at ffff8880189b2000=0A=
 which belongs to the cache kmalloc-4k of size 4096=0A=
The buggy address is located 888 bytes to the right of=0A=
 4096-byte region [ffff8880189b2000, ffff8880189b3000)=0A=
The buggy address belongs to the page:=0A=
page:000000002d1437e5 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0xffff8880189b6000 pfn:0x189b0=0A=
head:000000002d1437e5 order:3 compound_mapcount:0 compound_pincount:0=0A=
flags: 0x100000000010200(slab|head)=0A=
raw: 0100000000010200 ffffea00004eea08 ffffea0000531008 ffff888100042f00=0A=
raw: ffff8880189b6000 0000000000040003 00000001ffffffff 0000000000000000=0A=
page dumped because: kasan: bad access detected=0A=
=0A=
Memory state around the buggy address:=0A=
 ffff8880189b3200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
 ffff8880189b3280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
>ffff8880189b3300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
                                                                ^=0A=
 ffff8880189b3380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
 ffff8880189b3400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
loop1: detected capacity change from 4096 to 0=0A=
EXT4-fs error (device loop1): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.1: iget: bad extra_isize 9640 (inode size 1024)=0A=
EXT4-fs (loop1): get root inode failed=0A=
EXT4-fs (loop1): mount failed=0A=
loop1: detected capacity change from 4096 to 0=0A=
EXT4-fs error (device loop1): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.1: iget: bad extra_isize 9640 (inode size 1024)=0A=
EXT4-fs (loop1): get root inode failed=0A=
EXT4-fs (loop1): mount failed=0A=
loop1: detected capacity change from 4096 to 0=0A=
EXT4-fs error (device loop1): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.1: iget: bad extra_isize 9640 (inode size 1024)=0A=
EXT4-fs (loop1): get root inode failed=0A=
EXT4-fs (loop1): mount failed=0A=
loop1: detected capacity change from 4096 to 0=0A=
EXT4-fs error (device loop1): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.1: iget: bad extra_isize 9640 (inode size 1024)=0A=
EXT4-fs (loop1): get root inode failed=0A=
EXT4-fs (loop1): mount failed=0A=
loop1: detected capacity change from 4096 to 0=0A=
EXT4-fs error (device loop1): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.1: iget: bad extra_isize 9640 (inode size 1024)=0A=
EXT4-fs (loop1): get root inode failed=0A=
EXT4-fs (loop1): mount failed=0A=
loop1: detected capacity change from 4096 to 0=0A=
EXT4-fs error (device loop1): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.1: iget: bad extra_isize 9640 (inode size 1024)=0A=
EXT4-fs (loop1): get root inode failed=0A=
EXT4-fs (loop1): mount failed=0A=
loop7: detected capacity change from 512 to 0=0A=
[EXT4 FS bs=3D1024, gc=3D1, bpg=3D8192, ipg=3D32, mo=3De800e01c, mo2=3D0002=
]=0A=
System zones: 1-20=0A=
EXT4-fs error (device loop7): ext4_orphan_get:1411: comm syz-executor.7: ba=
d orphan inode 2374918752=0A=
EXT4-fs (loop7): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 512 to 0=0A=
[EXT4 FS bs=3D1024, gc=3D1, bpg=3D8192, ipg=3D32, mo=3De800e01c, mo2=3D0002=
]=0A=
System zones: 1-20=0A=
EXT4-fs error (device loop7): ext4_orphan_get:1411: comm syz-executor.7: ba=
d orphan inode 2374918752=0A=
EXT4-fs (loop7): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 262188 to 0=0A=
FAT-fs (loop7): bogus number of FAT structure=0A=
FAT-fs (loop7): Can't find a valid FAT filesystem=0A=
loop7: detected capacity change from 262188 to 0=0A=
loop1: detected capacity change from 512 to 0=0A=
FAT-fs (loop7): bogus number of FAT structure=0A=
FAT-fs (loop7): Can't find a valid FAT filesystem=0A=
EXT4-fs (loop1): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: writeback.=0A=
ext4 filesystem being mounted at /syzkaller-testdir3419502593/syzkaller.5cm=
vS6/1810/file0 supports timestamps until 2038 (0x7fffffff)=0A=
loop7: detected capacity change from 262188 to 0=0A=
FAT-fs (loop7): bogus number of FAT structure=0A=
FAT-fs (loop7): Can't find a valid FAT filesystem=0A=
loop1: detected capacity change from 512 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
EXT4-fs (loop1): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: writeback.=0A=
ext4 filesystem being mounted at /syzkaller-testdir3419502593/syzkaller.5cm=
vS6/1811/file0 supports timestamps until 2038 (0x7fffffff)=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 512 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
EXT4-fs (loop1): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: writeback.=0A=
ext4 filesystem being mounted at /syzkaller-testdir3419502593/syzkaller.5cm=
vS6/1812/file0 supports timestamps until 2038 (0x7fffffff)=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
loop1: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs error (device loop7): ext4_fill_super:4943: inode #2: comm syz-exec=
utor.7: iget: root inode unallocated=0A=
EXT4-fs (loop7): get root inode failed=0A=
EXT4-fs (loop7): mount failed=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): ext4_check_descriptors: Block bitmap for group 0 overlaps =
superblock=0A=
EXT4-fs (loop7): group descriptors corrupted!=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): ext4_check_descriptors: Block bitmap for group 0 overlaps =
superblock=0A=
EXT4-fs (loop7): group descriptors corrupted!=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): ext4_check_descriptors: Block bitmap for group 0 overlaps =
superblock=0A=
EXT4-fs (loop7): group descriptors corrupted!=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2364 to 0=0A=
ISOFS: Unable to identify CD-ROM format.=0A=
loop7: detected capacity change from 2364 to 0=0A=
ISOFS: Unable to identify CD-ROM format.=0A=
loop7: detected capacity change from 2364 to 0=0A=
ISOFS: Unable to identify CD-ROM format.=0A=
loop7: detected capacity change from 2364 to 0=0A=
ISOFS: Unable to identify CD-ROM format.=0A=
loop1: detected capacity change from 512 to 0=0A=
FAT-fs (loop1): Unrecognized mount option "nfs	dos1xfloppy" or missing valu=
e=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): unsupported descriptor size 99=0A=
loop1: detected capacity change from 512 to 0=0A=
FAT-fs (loop1): Unrecognized mount option "nfs	dos1xfloppy" or missing valu=
e=0A=
loop7: detected capacity change from 2048 to 0=0A=
FAT-fs (loop7): invalid media value (0x16)=0A=
FAT-fs (loop7): Can't find a valid FAT filesystem=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 512 to 0=0A=
FAT-fs (loop1): Unrecognized mount option "nfs	dos1xfloppy" or missing valu=
e=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 512 to 0=0A=
FAT-fs (loop1): Unrecognized mount option "nfs	dos1xfloppy" or missing valu=
e=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): unsupported descriptor size 99=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
__nla_validate_parse: 61 callbacks suppressed=0A=
netlink: 176 bytes leftover after parsing attributes in process `syz-execut=
or.5'.=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
netlink: 176 bytes leftover after parsing attributes in process `syz-execut=
or.5'.=0A=
netlink: 176 bytes leftover after parsing attributes in process `syz-execut=
or.5'.=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
device lo entered promiscuous mode=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
device lo left promiscuous mode=0A=
loop7: detected capacity change from 2048 to 0=0A=
device lo entered promiscuous mode=0A=
device lo left promiscuous mode=0A=
device lo entered promiscuous mode=0A=
device lo left promiscuous mode=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
ext4 filesystem being mounted at /syzkaller-testdir2756072593/syzkaller.Ltz=
YSL/397/file0 supports timestamps until 2038 (0x7fffffff)=0A=
loop1: detected capacity change from 9472 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop1): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
ext4 filesystem being mounted at /syzkaller-testdir3419502593/syzkaller.5cm=
vS6/1831/file0 supports timestamps until 2038 (0x7fffffff)=0A=
EXT4-fs (loop7): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
ext4 filesystem being mounted at /syzkaller-testdir2756072593/syzkaller.Ltz=
YSL/398/file0 supports timestamps until 2038 (0x7fffffff)=0A=
netlink: 188 bytes leftover after parsing attributes in process `syz-execut=
or.5'.=0A=
loop1: detected capacity change from 9472 to 0=0A=
netlink: 188 bytes leftover after parsing attributes in process `syz-execut=
or.5'.=0A=
EXT4-fs (loop1): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
ext4 filesystem being mounted at /syzkaller-testdir3419502593/syzkaller.5cm=
vS6/1832/file0 supports timestamps until 2038 (0x7fffffff)=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
ext4 filesystem being mounted at /syzkaller-testdir2756072593/syzkaller.Ltz=
YSL/399/file0 supports timestamps until 2038 (0x7fffffff)=0A=
netlink: 188 bytes leftover after parsing attributes in process `syz-execut=
or.5'.=0A=
loop1: detected capacity change from 2048 to 0=0A=
SELinux: unrecognized netlink message: protocol=3D6 nlmsg_type=3D91 sclass=
=3Dnetlink_xfrm_socket pid=3D28182 comm=3Dsyz-executor.7=0A=
loop6: detected capacity change from 2048 to 0=0A=
SELinux: unrecognized netlink message: protocol=3D6 nlmsg_type=3D91 sclass=
=3Dnetlink_xfrm_socket pid=3D28200 comm=3Dsyz-executor.7=0A=
SELinux: unrecognized netlink message: protocol=3D6 nlmsg_type=3D91 sclass=
=3Dnetlink_xfrm_socket pid=3D28200 comm=3Dsyz-executor.7=0A=
SELinux: unrecognized netlink message: protocol=3D6 nlmsg_type=3D91 sclass=
=3Dnetlink_xfrm_socket pid=3D28200 comm=3Dsyz-executor.7=0A=
loop6: detected capacity change from 2048 to 0=0A=
SELinux: unrecognized netlink message: protocol=3D6 nlmsg_type=3D91 sclass=
=3Dnetlink_xfrm_socket pid=3D28200 comm=3Dsyz-executor.7=0A=
SELinux: unrecognized netlink message: protocol=3D6 nlmsg_type=3D91 sclass=
=3Dnetlink_xfrm_socket pid=3D28200 comm=3Dsyz-executor.7=0A=
SELinux: unrecognized netlink message: protocol=3D6 nlmsg_type=3D91 sclass=
=3Dnetlink_xfrm_socket pid=3D28200 comm=3Dsyz-executor.7=0A=
SELinux: unrecognized netlink message: protocol=3D6 nlmsg_type=3D91 sclass=
=3Dnetlink_xfrm_socket pid=3D28200 comm=3Dsyz-executor.7=0A=
SELinux: unrecognized netlink message: protocol=3D6 nlmsg_type=3D91 sclass=
=3Dnetlink_xfrm_socket pid=3D28200 comm=3Dsyz-executor.7=0A=
loop6: detected capacity change from 2048 to 0=0A=
SELinux: unrecognized netlink message: protocol=3D6 nlmsg_type=3D91 sclass=
=3Dnetlink_xfrm_socket pid=3D28200 comm=3Dsyz-executor.7=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
FAT-fs (loop1): Unrecognized mount option "@" or missing value=0A=
loop7: detected capacity change from 512 to 0=0A=
EXT4-fs (loop7): Ignoring removed nomblk_io_submit option=0A=
EXT4-fs (loop7): encrypted files will use data=3Dordered instead of data jo=
urnaling mode=0A=
EXT4-fs (loop7): Number of reserved GDT blocks insanely large: 63126=0A=
loop1: detected capacity change from 2048 to 0=0A=
FAT-fs (loop1): Unrecognized mount option "@" or missing value=0A=
loop7: detected capacity change from 512 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): Ignoring removed nomblk_io_submit option=0A=
EXT4-fs (loop7): encrypted files will use data=3Dordered instead of data jo=
urnaling mode=0A=
EXT4-fs (loop7): Number of reserved GDT blocks insanely large: 63126=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 512 to 0=0A=
EXT4-fs (loop7): Ignoring removed nomblk_io_submit option=0A=
EXT4-fs (loop7): encrypted files will use data=3Dordered instead of data jo=
urnaling mode=0A=
loop6: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): Number of reserved GDT blocks insanely large: 63126=0A=
9pnet: Insufficient options for proto=3Dfd=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
FAT-fs (loop1): Unrecognized mount option "@" or missing value=0A=
loop7: detected capacity change from 2048 to 0=0A=
9pnet: Insufficient options for proto=3Dfd=0A=
loop7: detected capacity change from 2048 to 0=0A=
9pnet: Insufficient options for proto=3Dfd=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
tmpfs: Bad value for 'mpol'=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 65536 to 0=0A=
tmpfs: Bad value for 'mpol'=0A=
tmpfs: Bad value for 'mpol'=0A=
EXT4-fs (loop7): Mount option "nouser_xattr" will be removed by 3.5=0A=
Contact linux-ext4@vger.kernel.org if you think we should keep it.=0A=
=0A=
loop6: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop7): mounted filesystem without journal. Opts: nouser_xattr,dio=
read_lock,lazytime,auto_da_alloc=3D0x00000000000000dd,resgid=3D000000000000=
00000000,nodiscard,block_validity,min_batch_time=3D0x0000000000000849,nojou=
rnal_checksum,,errors=3Dcontinue. Quota mode: none.=0A=
tmpfs: Bad value for 'mpol'=0A=
EXT4-fs error (device loop7): __ext4_new_inode:1067: comm syz-executor.7: r=
eserved inode found cleared - inode=3D10=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 65536 to 0=0A=
EXT4-fs (loop7): Mount option "nouser_xattr" will be removed by 3.5=0A=
Contact linux-ext4@vger.kernel.org if you think we should keep it.=0A=
=0A=
EXT4-fs (loop7): mounted filesystem without journal. Opts: nouser_xattr,dio=
read_lock,lazytime,auto_da_alloc=3D0x00000000000000dd,resgid=3D000000000000=
00000000,nodiscard,block_validity,min_batch_time=3D0x0000000000000849,nojou=
rnal_checksum,,errors=3Dcontinue. Quota mode: none.=0A=
EXT4-fs error (device loop7): __ext4_new_inode:1067: comm syz-executor.7: r=
eserved inode found cleared - inode=3D10=0A=
loop6: detected capacity change from 2048 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop6: detected capacity change from 2048 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop7: detected capacity change from 65536 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 1024 to 0=0A=
EXT4-fs (loop7): unsupported inode size: 3072=0A=
EXT4-fs (loop7): blocksize: 1024=0A=
loop1: detected capacity change from 2048 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop7: detected capacity change from 1024 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
EXT4-fs (loop7): unsupported inode size: 3072=0A=
EXT4-fs (loop7): blocksize: 1024=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 1024 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop1: detected capacity change from 512 to 0=0A=
EXT4-fs (loop7): unsupported inode size: 3072=0A=
EXT4-fs (loop7): blocksize: 1024=0A=
EXT4-fs (loop1): feature flags set on rev 0 fs, running e2fsck is recommend=
ed=0A=
EXT4-fs (loop1): couldn't mount as ext2 due to feature incompatibilities=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 512 to 0=0A=
EXT4-fs (loop1): feature flags set on rev 0 fs, running e2fsck is recommend=
ed=0A=
EXT4-fs (loop1): couldn't mount as ext2 due to feature incompatibilities=0A=
loop7: detected capacity change from 4096 to 0=0A=
EXT4-fs (loop7): Unrecognized mount option "??(??1?usrj" or missing value=
=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop1: detected capacity change from 512 to 0=0A=
EXT4-fs (loop1): feature flags set on rev 0 fs, running e2fsck is recommend=
ed=0A=
EXT4-fs (loop1): couldn't mount as ext2 due to feature incompatibilities=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 4096 to 0=0A=
EXT4-fs (loop7): Unrecognized mount option "??(??1?usrj" or missing value=
=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop7: detected capacity change from 4096 to 0=0A=
EXT4-fs (loop7): Unrecognized mount option "??(??1?usrj" or missing value=
=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop7: detected capacity change from 4096 to 0=0A=
EXT4-fs (loop7): Unrecognized mount option "??(??1?usrj" or missing value=
=0A=
EXT4-fs (sda): re-mounted. Opts: (null). Quota mode: none.=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
EXT4-fs (sda): re-mounted. Opts: (null). Quota mode: none.=0A=
EXT4-fs (sda): re-mounted. Opts: (null). Quota mode: none.=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop7: detected capacity change from 2048 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop1: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop1): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
loop7: detected capacity change from 128 to 0=0A=
EXT4-fs (loop7): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
ext4 filesystem being mounted at /syzkaller-testdir2756072593/syzkaller.Ltz=
YSL/433/mnt supports timestamps until 2038 (0x7fffffff)=0A=
loop1: detected capacity change from 2048 to 0=0A=
EXT4-fs (loop1): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
loop7: detected capacity change from 128 to 0=0A=
EXT4-fs (loop7): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
ext4 filesystem being mounted at /syzkaller-testdir2756072593/syzkaller.Ltz=
YSL/434/mnt supports timestamps until 2038 (0x7fffffff)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 128 to 0=0A=
EXT4-fs (loop1): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
EXT4-fs (loop7): mounted filesystem without journal. Opts: ,errors=3Dcontin=
ue. Quota mode: none.=0A=
ext4 filesystem being mounted at /syzkaller-testdir2756072593/syzkaller.Ltz=
YSL/435/mnt supports timestamps until 2038 (0x7fffffff)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
loop6: detected capacity change from 2048 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop1: detected capacity change from 2048 to 0=0A=
loop7: detected capacity change from 2048 to 0=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
ALSA: seq fatal error: cannot create timer (-22)=0A=
loop6: detected capacity change from 2048 to 0=0A=
=0A=
=0A=
Best regards,=0A=
Sanan Hasanov.=
