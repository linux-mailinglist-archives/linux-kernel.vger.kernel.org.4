Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07A767C140
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjAYX7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbjAYX7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:59:30 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A7F611C5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:59:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SczT/y6cWPbC8qC9h+0MvthE5kAFOcSK9GLK0/Esnah+JyXUsh+d3xYOj5W2Cqm5U4dxcb2HOQWNp9WGtOGxQjEUm6QJN+Bxey/y4P8/IK3245OW7RE8Q+El0bZpockcsQsS+iTmZnyKHppVOXxrt6Fiy6bzbu0QcBE1JSuuoSdVu3bK7OpMqJzx247C6/kG3I72G8DUC4MmvcpI24Ak8IuKiNOts9h2O2XKpxVVT7EH+bXYBHtySbvU+wm+kBDwvh9dh4F4sRBUo+VwZQ2H0tlA5aK3lHwThWFjbva3IX8N5xbwbvWuo1KvXSZQBPq/SVlQFO54ZqZd8NoBxYWt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zu6rcMIdYZJwaJlsTqV1Jsuivl9iN3HigkRGLhGdTI=;
 b=doWrQMGB35nufTdbnglUU5jGbUYgeZiZqKQyx2VT1kQwPttzQ8p/UxujkLlzSb2nkoe4gdxwoCiFdH+ARZeAXb+fUG9+PTmrsM7pyjr+egM4I40bJZddbEOKcaOHUoaJYLHBDUMZxWf945BgvakR4g//km1G+kNLjGt7HM/3mXiXeG4iOMG/cIw93lJLvsTCZCqYvT/67QTmvvGGd4NbE86DNfu8dM6jvBhDb+33zsNfGK+R/HJDDbfEYdr8oxgKc9fRGGcXdwZj1ah0uRm8odsXOuy/aRJKz7BSvg8sKwKFnukScosDDecOzxKwJPqoi5Bk4RwpbngJTNqfHs9lWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zu6rcMIdYZJwaJlsTqV1Jsuivl9iN3HigkRGLhGdTI=;
 b=ZLt26tOdtU82sSTUZ1NNv9l4zjsh2s8Q0fcEzASEwhc6p/7g1CGg0iKrdE7K323cUveUYObB3fzAdNsByZ52tQgKn7LrGmI90fOu133lNgqXy8bvGFL4+e5qF3g7BaVNeKCAk05K3YMUMGDAZ6Yxk37Fu1ektUex/3tSdxnEeO4=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by BYAPR07MB7845.namprd07.prod.outlook.com (2603:10b6:a03:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 23:59:23 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583%3]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 23:59:23 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: WARNING in __split_vma
Thread-Topic: WARNING in __split_vma
Thread-Index: AQHZMRh312qOLPHZnES/e6gyHZrW0g==
Date:   Wed, 25 Jan 2023 23:59:23 +0000
Message-ID: <IA1PR07MB98306BC0F55667A760EABE91ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|BYAPR07MB7845:EE_
x-ms-office365-filtering-correlation-id: 3efe706b-0ac1-447e-6845-08daff302eca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuUONE69r/OBVIIxsPsZ34SCXmFqzkr+Et/qGP3V2f3IxKhTCiXpwTIycc//IagwxS2J7ZwDTVGf0lPHg5vul22YoCLdEp3MYPSoE6dRsVx6ofGpGLSScGqQvG9NcSLG+3GaT4VMy/USb+ihsZUtWTyINdSqfb8kukGGHfi4GAsUiVzPSod1IrYWbSFIHOkBpWvChZmAHboLTslEyBmJB3+CRWT+2QdVvyu5LfhUZss7qtJeHWQ5ByFbDlb/+NGbrcfdbL4oubDIQULXdlLXDJPrLXkk6eNolrRY9jQhbzZTH4dRUVDBTIQ+s3wAzJ+Kt3b/QYLTBgCL484f9XIzRJcAwhjmaY26mQ/iPOYcA4I4nmDvn/gwTEHhbMKnzKPsOZdchgtz+q+kGxi51rByZpsx1DkHvKkRt2NmK+IPiq5yV1GrkXgbAwk3zjZvlJYz1kVmshVmJAL0+4Go2rMnZ/5GM6UIkzaafNF6XspPjOfoxCEj0BD7wMbnOE2JJxOF6E5AJ/jpu+c+oi8iAqQkIeXkHCRx/wCdXcN46L5ZcQNPhKASy63zthR2gaxMZkvw2wqN6Ce+y7DpUWwLZZk3HDE2+IvURxqIKZUM6GoTKUfL3Vc9/1sgKB7zOytkhuUEWuAO7QBXJ8B4V/JiIOQpC6xa+1hx3pFF70J0YDmxkPSmPoziyrN3xC8e4HiuISxqvY0lgSwGO4Ar0A2Tw96zcO6mGbsNorsWLPJZM4d9KoBoYsJEWBJ0cdOth0245iwlJyzRETAbzCwVY6TnfjnBrX4L0iVATBbOejII2PzEtFoHxygvldG7TdjKUmtKsYfX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(2906002)(5930299012)(38100700002)(41320700001)(38070700005)(4326008)(9686003)(786003)(66946007)(66556008)(66446008)(44832011)(8676002)(76116006)(64756008)(122000001)(52536014)(83380400001)(41300700001)(8936002)(966005)(6506007)(66476007)(478600001)(55016003)(33656002)(75432002)(316002)(7696005)(5660300002)(186003)(86362001)(45080400002)(26005)(71200400001)(110136005)(54906003)(58493002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xQbjz6O1Wsv3xfi3wKB18d6RsI7SB7YaColIdlHn0Qc1EiCEThPAQuMjlS?=
 =?iso-8859-1?Q?Xrka5iEmy5PodpuHD5wQD2yCSRGZbf/nzBusrZx3vxvsw2AEqAM1NSdYkX?=
 =?iso-8859-1?Q?V4D/r/W8dAxrEO0x4FFmLRSrOyZfra/J55uhVb5XYjdIAK4nGWygZxQb5B?=
 =?iso-8859-1?Q?Xo/xcxvxxgBRfs+sUEGWuzJZBk81tFPYEGHgzRT/c0HTd6vv0gbqX6Nidr?=
 =?iso-8859-1?Q?092NFm++bFW74cmGDNa+3pXqziXCirmzlxbOuLuaWWbsCq7AlgT2DSDTOF?=
 =?iso-8859-1?Q?r2+X/5S5qwJu/IMmB6fkRYQicJwYmfW0HSYVm4sm2Zb8bVsKALvln7qZBr?=
 =?iso-8859-1?Q?iaeZ45xK/k6PuZ6wTPkT05SH/x/WfRr7bXCoNyZOiVL9O+y/hwEqv1GXYq?=
 =?iso-8859-1?Q?MWOkRf+I0KvAznBFVYlcymSYgKsCZGZKZbqrL2oKbOs0o99wpsZJcHTIdS?=
 =?iso-8859-1?Q?DIXAgnU7/aWufBE5uwO5X/eTP6Hb4nibm8lfZOnVSlXSeWBo9zNg5x1Ei5?=
 =?iso-8859-1?Q?+N8li1B1o/UGPuw5uyFf/P88kyV0ILW2UBTP/9v/1mrUeNqbCK6/exsbmA?=
 =?iso-8859-1?Q?rPyCwVzIlcSn9tb15EkiUbL/K4niK3gGEFmyFDj/QRf/mu3cbQSVyziR/2?=
 =?iso-8859-1?Q?JnyYeEasXQZxch2jqpFHQaLCIx8JRgEwaPk5WNNRhX5U+bEghCXU5w41dK?=
 =?iso-8859-1?Q?AND80L29Jc5VBeQ4E8/PyNdJpztmSg/M/fiAohfjm5p8ejj/vGVWcrZ/Jy?=
 =?iso-8859-1?Q?fZ/8dYqHeSjsinbQQAg3OZvQRTUuwa8RoRbVq7sOxPvQq4RqkPVMqNVBHL?=
 =?iso-8859-1?Q?yYNZyAujF4Bk3DgScdOWrtixExkQQ/wMj9Q1WkGVH1RC17r2lJW6495u4b?=
 =?iso-8859-1?Q?rtsVDf/Wv+T2NypqcEiL/k9koT7qliWWavAE900kQGL+lMqsnZSmvc67Q3?=
 =?iso-8859-1?Q?8BvJMMPuDydbrNJMgVvpN9HReAdl0O6bchBWf5sbnaXVXVL4XbaMxMia/R?=
 =?iso-8859-1?Q?Al3Hpc+NIyTR1TR7AkLmFFA56GpBO7BEVMHv+0dtNJ/YLBBAbD8WrTJLp9?=
 =?iso-8859-1?Q?3rtRDwFSzWVJQ1ZcXvFz9q7U6DgpMv146Bentycn6dJz+nqOf/sni4CaWy?=
 =?iso-8859-1?Q?PDJlwVYxeG4D71L7pD75s2bmtWzeRWXevrih8PR5+8kSRtFDOaxrGYmepH?=
 =?iso-8859-1?Q?dcGQcg6f+e2VSg2NrJBCTQXtBom/hugNTVzWiSWlHoJj2VmThs/E/ZvPrJ?=
 =?iso-8859-1?Q?XV37pkKwWP0SJUss5DxDGyaFQsBmC/Z4cTMvr9YenSBY8NcRthURyhBKxm?=
 =?iso-8859-1?Q?pvtEiuBNtPVCuaBJNi8E76HQRQFd4micZsBxqNyN0r9m/hk7SI7gfmmRew?=
 =?iso-8859-1?Q?dIJV/pbQ4Ff7QeJIRylbvccyJkSlNe3PqDUeUc6c/MwrjzVfIVmJIEuG+n?=
 =?iso-8859-1?Q?NS0+gUn/0xC0k3kq3AnGqJLROOejUEN2NhMRX1SUSpB7SXr9zNsnqFKNsg?=
 =?iso-8859-1?Q?iwq4p6AbkjHMZAC166uDnhCzME1uPmoItLtrFVmzMS/YIGT1mBwYFvXcm8?=
 =?iso-8859-1?Q?1sa0e5uPi+2rkE71ZDC8QTQYCCSnHUON8/NCxHss+FVolfjoeuSmH1ogBx?=
 =?iso-8859-1?Q?6KV4cmNqUgMRz3D+8ppb2w54NDiUw0LNIZyHV6K2ncPyFotQGyGmPvoQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efe706b-0ac1-447e-6845-08daff302eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 23:59:23.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWHqho6J6BcS1zwgBnwuI1Vu5x9hxTl7muQBW++E4kyyGWVXVmMb2OIwzUwo5evt5x8p3EwhhhAVVqve7Zxb6yNZw3ElNLVu9pByQa22ZZs=
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
Reproducer:=A0https://drive.google.com/file/d/1L03M-21V_CDlUX3Q281GkLyC5Oxe=
h3Pg/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 3 PID: 29148 at mm/mmap.c:2167 __split_vma+0x5fc/0x780 mm/mma=
p.c:2167=0A=
Modules linked in:=0A=
CPU: 3 PID: 29148 Comm: syz-executor.6 Not tainted 6.2.0-rc5-next-20230124 =
#1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:__split_vma+0x5fc/0x780 mm/mmap.c:2167=0A=
Code: aa 22 c3 ff 4c 89 f7 e8 a2 11 8c ff e9 26 ff ff ff 41 bc f4 ff ff ff =
eb e6 e8 90 22 c3 ff 0f 0b e9 ac fa ff ff e8 84 22 c3 ff <0f> 0b e9 e1 fa f=
f ff e8 78 22 c3 ff 48 8b 54 24 08 48 b8 00 00 00=0A=
RSP: 0018:ffffc9000b1d78f0 EFLAGS: 00010246=0A=
=0A=
RAX: 0000000000040000 RBX: ffff88810f524bd0 RCX: ffffc90003d89000=0A=
RDX: 0000000000040000 RSI: ffffffff81bbc3fc RDI: 0000000000000006=0A=
RBP: 0000000020ffd000 R08: 0000000000000006 R09: 0000000020ffd000=0A=
R10: 0000000020ffd000 R11: 0000000000000001 R12: 0000000020ffd000=0A=
R13: 1ffff9200163af22 R14: 0000000020ffd000 R15: ffffc9000b1d7cc0=0A=
FS:  00007f70ff656700(0000) GS:ffff888119d80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f6622840260 CR3: 000000007d1bc000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 do_vmi_align_munmap+0x223/0xbb0 mm/mmap.c:2305=0A=
 do_vmi_munmap+0x26c/0x2c0 mm/mmap.c:2451=0A=
 move_vma+0x7c2/0xf30 mm/mremap.c:704=0A=
 __do_sys_mremap+0x48c/0x17f0 mm/mremap.c:1095=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f70fe48edcd=0A=
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f70ff655bf8 EFLAGS: 00000246=0A=
 ORIG_RAX: 0000000000000019=0A=
RAX: ffffffffffffffda RBX: 00007f70fe5bbf80 RCX: 00007f70fe48edcd=0A=
RDX: 0000000000001000 RSI: 0000000000001000 RDI: 0000000020003000=0A=
RBP: 00007f70ff655c50 R08: 0000000020ffd000 R09: 0000000000000000=0A=
R10: 0000000000000007 R11: 0000000000000246 R12: 000000000000000e=0A=
R13: 00007ffe16c8ac1f R14: 00007ffe16c8adc0 R15: 00007f70ff655d80=0A=
 </TASK>=0A=
irq event stamp: 1113=0A=
hardirqs last  enabled at (1121): [<ffffffff8163e2e2>] console_emit_next_re=
cord kernel/printk/printk.c:2893 [inline]=0A=
hardirqs last  enabled at (1121): [<ffffffff8163e2e2>] console_flush_all+0x=
902/0xd10 kernel/printk/printk.c:2942=0A=
hardirqs last disabled at (1132): [<ffffffff8997e59c>] __schedule+0x2f1c/0x=
5a70 kernel/sched/core.c:6518=0A=
softirqs last  enabled at (922): [<ffffffff814a50bd>] invoke_softirq kernel=
/softirq.c:445 [inline]=0A=
softirqs last  enabled at (922): [<ffffffff814a50bd>] __irq_exit_rcu+0x11d/=
0x190 kernel/softirq.c:650=0A=
softirqs last disabled at (771): [<ffffffff814a50bd>] invoke_softirq kernel=
/softirq.c:445 [inline]=0A=
softirqs last disabled at (771): [<ffffffff814a50bd>] __irq_exit_rcu+0x11d/=
0x190 kernel/softirq.c:650=0A=
---[ end trace 0000000000000000 ]---=0A=
=0A=
=0A=
