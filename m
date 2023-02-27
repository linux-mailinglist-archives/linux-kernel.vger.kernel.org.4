Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6046A3B38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 07:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjB0GX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 01:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0GX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 01:23:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A1AB45A;
        Sun, 26 Feb 2023 22:23:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL09wlAATM/fF7na61+F3pPiHavpKweF6hCOJlVM2o781DidK54L4aOXCLTMH+K2LreZiPE1jE1oSzftTSWFIKeY7CW+a0c3P9N5arnr5DIYEZteT0lDzQ3kR76vcicZyZtNsd5BOZ+XIVdbFKDkwsAC7Fgw8unmnpMLETU5pZC5Dx4WH5tjFsZ8e4VZYHk3uvSq+yy8r6C6Fetok7Gk92VlYLvQe2eBdTy9IdinT27qQqPQfoAW5JnKtK3mkURUXskdAR++RF+PPBmtCGMJEauEjBxfbwG/nN4VCbxzKr7Z2Lo1qbLai5GeB+uO5JjpSR+bZ751cSSJV/OLMJCJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIM+2c+lcbTY56Kyd228nq81iepZyz6Q25Gh08keacU=;
 b=SoRQMXD5uaFzagucrOG6sDxLgXxop2VFyqfo5jqKfh4J7ksYB53//Pa1YcPeMu8Agv+8TW74A0p3zhWw+g7XadytF0xxdvlvR5k355ZNU7ExBgnx1/bTl6ttyoAubH/LzqRy28qtL8TqIshnTuOgmIC8lCzQeJ5v7f+FuTPBvr39+aiITdhO8ooir66rHuW5tggVHrXwnj2x5mimNlLpJXfG8fAI+RcgyYW0tMN24CVXKVy8lut0hSJT1IDQXiKWDYDeCaNFg3GhraJKKsw8qOPaN0CrAJdcYtSTG4+MTldOmpKrSZz4KEaR8iJreRMcU1pOx8qv4V5wtdjbUKOyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIM+2c+lcbTY56Kyd228nq81iepZyz6Q25Gh08keacU=;
 b=HH3qsm5theoutiNzpLjpVrUMEH6JH6HWzKl9r+DbrUVOfu2sQkY/s4SU/D9A2cWIF4HJJIbGFcWESGC5rdbkA3mud/IG/+6b2FfUr61xQB/XENuEwojFGSgDQWt9hvaHG5wgb5aJVNtIJji8tv7WGME0eguuyPX5jiqZRKNIYzU=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by SJ0PR07MB9123.namprd07.prod.outlook.com (2603:10b6:a03:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Mon, 27 Feb
 2023 06:23:22 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 06:23:21 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in rcu_core
Thread-Topic: BUG: unable to handle kernel NULL pointer dereference in
 rcu_core
Thread-Index: AQHZSnHWBOuzu5f2AkiK0ceFnKP0iw==
Date:   Mon, 27 Feb 2023 06:23:21 +0000
Message-ID: <IA1PR07MB983057EE02C56A3FF3E0ED1BABAF9@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|SJ0PR07MB9123:EE_
x-ms-office365-filtering-correlation-id: 6457ee72-242c-4778-fe76-08db188b1ff3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: byT6w/WHptiYlz/3HocuqD5Zv+giIDy7rkw+CDSON5roePCmZM55Padd5gdd4Eu6ma5o1X86YNiYZz7JppIUGuvuBBgdFKPLtJrVDfcevPDwFnGcjNds2+hkZUjFUBZlVNk8QL45Upkr4an2U214jjbDo/yA5WgC7Rog8F+eXJLQmXP8Yi5ar3lmpxtSw+5c3nOT2NVgSnEoS6Q9npV37GZr2RgmXJKt97K/emBSrlGpsDKN1/OtkMDXASIunJwKjtUBiRdF6xkFlPbIqWxHpVCQBw0JWpyC0Seh6m+Wxm2jc2egdHIk1Dzc0u5lCCj6UoeL+lr7lHyk9SXv7uMjv3YkwL87YR7mPm5Tqpb+rMcQXqu1Rp+eH+vjJ8msOSEaadk7XslQ3QmmKk9UiSWvoZSvdcglv4T4dwIXs4X+X9beb8OriTtP4GGu/CpardfvkDHEaIsyOlBgXO1iMP1OizSzvJxn5pNcl3vIC16AiFx58KHW72bBmFgQWeGGtsbZGyVUCDHF7XTDq77n6uKA7sN5QYoS49DHQIe714WPGTHiLTTrkZURUVHH+j/W36nxzjJhOavSYRjV8T4ZMuR8PwfZL2Nj8cEWCd/Hqw85gtZbUI+yX0V5oCExJUkr51I9ResdTaVIysvlTZu07uP0PYjI6tUUvTRze4ta8d9GmRBunC8F0SnCoMpeRf+y+60NEOyMgla1HJN2XHi93n2qK6K/+VgMx2KSt42Rm3CQOF4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(83380400001)(52536014)(44832011)(7416002)(8936002)(2906002)(5660300002)(122000001)(55016003)(38070700005)(41300700001)(76116006)(64756008)(66446008)(66476007)(66556008)(91956017)(66946007)(5930299012)(8676002)(38100700002)(4326008)(7696005)(45080400002)(966005)(86362001)(41320700001)(921005)(9686003)(186003)(26005)(6506007)(71200400001)(478600001)(75432002)(33656002)(316002)(786003)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?59EM7E+zlLAV/NJEX9zHzlJr2P0WuwQ0h/gQLopOo2GSLk8Qejs/1eZeVo?=
 =?iso-8859-1?Q?WvZWKwL+86d05oKd8WsYws61xDxDImXd2A87oLcDRt7w5hxFqSF5mLNXZB?=
 =?iso-8859-1?Q?V3usmGD2KhJ3h4dPxR/j5jSNrLUprSl3JPV5wLFKABP5qtBfdj5pkF/LMF?=
 =?iso-8859-1?Q?27hC4L6gF7DwmguD8G+2JhAVi5Mr141jNl/+2ECMIK5gHrajPjsye3e6/z?=
 =?iso-8859-1?Q?dyVkZhMWwHVgMGQ8g0xeGKhUcEcsdkSpJnMnmsIuqInbwsnI4V/isZ60q1?=
 =?iso-8859-1?Q?FQJG21yog/IB92Emt4OAVi5mbzaGevQitk2b2v/mUS6b9a9s/tfY/Nnpi3?=
 =?iso-8859-1?Q?IpSU8RToNEhRU24L7PwRtkpu2ahf70jZQbYE7T+/J7BXCEFX8JLMxMgXpp?=
 =?iso-8859-1?Q?0k8cqFxELbwmYYqCpGnrnvla1j7BMWqXlbKNIFPgaVVwpfABjCDfya9Tx1?=
 =?iso-8859-1?Q?jnbC9tARRF4BjLF9xE6Kdtku8S4rv7Pt4OfHTeZZ7qXBXrmG7trtgTpJkz?=
 =?iso-8859-1?Q?4VHpdkudlU4+tnfPFm/9LxAtcfZfMJFwQGom2/t4JWXv5kAmE2qH9UZ/6G?=
 =?iso-8859-1?Q?1bwSQY5tdAZa34Ox26fgM180VEC1Mhh3koFkvd/dssFvITezU8f6Mr7HxL?=
 =?iso-8859-1?Q?4hXxAeIwiCmffjcGHCWmdAq1YGNY9wjrW7+G2tNyVAMeulwv5TCc9F71H1?=
 =?iso-8859-1?Q?HdJYr4IX9pWoRBG45augDoumwg21WdQ+fQWBNaL/Gnr4C8FjBLolH6ZJmG?=
 =?iso-8859-1?Q?35ChbKn+gfMX9AWoWY9ciumZJKcRPLjdjaMFA3ilkva4I6xRSPyQupfFQQ?=
 =?iso-8859-1?Q?XbgagqdUiOGVIs1L5FBFGFZ3jFZMBP9ExGXOs58i/3djChg1xv2vqUNWVp?=
 =?iso-8859-1?Q?jwhFD/krMHRYj3Lyh9FyFoluzPvjw2FUKUdsHCKvzKaO8mfSi7WIpfU3dG?=
 =?iso-8859-1?Q?cFboaDTHdX26OedDk3r8EUoNnaWIWHLfoGVqNY+lBXOl/ScMfM3Kpf4brc?=
 =?iso-8859-1?Q?TI76C7m2qGv8co42wrJzpFqEGpQ7mP0dhHZaVF0p+QvkI9t3BW9N9ClyLi?=
 =?iso-8859-1?Q?0H4jx2INwxQJR+Cvb2Tc+MvmfHlt+wATp6DRsC+Q5o7tiUcdEt45Ohkpq8?=
 =?iso-8859-1?Q?rgyjtYifcs7VaxXRySNMF3zAOSw2oJdeLEAMrOV1K60noBMmbuAZbJjvib?=
 =?iso-8859-1?Q?NKxpmOfIk0QqKME0GVO7juIB7glpq9XXl2DM2sAlSJBZ3bT4SM+X8ibxEm?=
 =?iso-8859-1?Q?08TIHisuEhrQWEVz7KIZporv7GKbz9YSS48QeVMX/NYRxu5rQervIl/Qa6?=
 =?iso-8859-1?Q?I69eNHFISTkSCsTQW3ZSjPvRXMGBfvlg/0fjVBRVoiirun2/l8OS7Z6jWJ?=
 =?iso-8859-1?Q?QTBmJNbnt7rhq3Y8PyX6nQfzCftQIet2qo5iH8C6Pjqp79To3Nc/QbzNUy?=
 =?iso-8859-1?Q?mhoQ8MpCDDTCw/D5BEYRnUh5jmI1EbaoLlNA6zx3SXRxXeayJWUssddQnH?=
 =?iso-8859-1?Q?vN0AOB8pbknf6Nj/O2lADGc8W86WZpfi3p37AN6T8RoDHRA5U8nQIGGYuS?=
 =?iso-8859-1?Q?kMVjPpA4Ho3FulZeSMO7Dij6qofnk9s4Yop3uun9FJoPeskmVH2uSkGIcG?=
 =?iso-8859-1?Q?iPMX9pMirhBcJEDRruq9UuHs59Psos6gqYIZ7QkVSfU0dyOiuMdJg6dA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6457ee72-242c-4778-fe76-08db188b1ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 06:23:21.8193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qt57OLWK0G+HDQiLs2OOhwkO8RHpag8RoEVX1OOyllJDFlXiWQAKyk30vkA7GWb7iE4VQ+xaGUg+3xdViXwrUVc+ewlAXx5GSvQRmZww+U=
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
Kernel Branch: 6.2.0-next-20230221=0A=
Kernel config:=A0https://drive.google.com/file/d/1QKAQV11zjOwISifUc-skRBoTo=
3EXhutY/view?usp=3Dshare_link=0A=
C Reproducer:=A0Unfortunately, there is no reproducer yet.=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
BUG: kernel NULL pointer dereference, address: 0000000000000000=0A=
#PF: supervisor instruction fetch in kernel mode=0A=
#PF: error_code(0x0010) - not-present page=0A=
PGD 53756067 P4D 53756067 PUD 0 =0A=
Oops: 0010 [#1] PREEMPT SMP KASAN=0A=
CPU: 7 PID: 0 Comm: swapper/7 Not tainted 6.2.0-next-20230221 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:0x0=0A=
Code: Unable to access opcode bytes at 0xffffffffffffffd6.=0A=
RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246=0A=
RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c=0A=
RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708=0A=
RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f=0A=
R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000=0A=
R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b=0A=
FS:  0000000000000000(0000) GS:ffff888119f80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <IRQ>=0A=
 rcu_core+0x85d/0x1960=0A=
 __do_softirq+0x2e5/0xae2=0A=
 __irq_exit_rcu+0x11d/0x190=0A=
 irq_exit_rcu+0x9/0x20=0A=
 sysvec_apic_timer_interrupt+0x97/0xc0=0A=
 </IRQ>=0A=
 <TASK>=0A=
 asm_sysvec_apic_timer_interrupt+0x1a/0x20=0A=
RIP: 0010:default_idle+0xf/0x20=0A=
Code: 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff ff ff =
cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d e3 8a 34 00 fb f4 <fa> c3 66 66 2e 0=
f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 65=0A=
RSP: 0018:ffffc9000017fe00 EFLAGS: 00000202=0A=
RAX: 0000000000dfbea1 RBX: dffffc0000000000 RCX: ffffffff89b1da9c=0A=
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000=0A=
RBP: 0000000000000007 R08: 0000000000000001 R09: ffff888119fb6c23=0A=
R10: ffffed10233f6d84 R11: dffffc0000000000 R12: 0000000000000003=0A=
R13: ffff888100833900 R14: ffffffff8e112850 R15: 0000000000000000=0A=
 default_idle_call+0x67/0xa0=0A=
 do_idle+0x361/0x440=0A=
 cpu_startup_entry+0x18/0x20=0A=
 start_secondary+0x256/0x300=0A=
 secondary_startup_64_no_verify+0xce/0xdb=0A=
 </TASK>=0A=
Modules linked in:=0A=
CR2: 0000000000000000=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:0x0=0A=
Code: Unable to access opcode bytes at 0xffffffffffffffd6.=0A=
RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246=0A=
=0A=
RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c=0A=
RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708=0A=
RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f=0A=
R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000=0A=
R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b=0A=
FS:  0000000000000000(0000) GS:ffff888119f80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0=0A=
----------------=0A=
Code disassembly (best guess):=0A=
   0:	89 07                	mov    %eax,(%rdi)=0A=
   2:	49 c7 c0 08 00 00 00 	mov    $0x8,%r8=0A=
   9:	4d 29 c8             	sub    %r9,%r8=0A=
   c:	4c 01 c7             	add    %r8,%rdi=0A=
   f:	4c 29 c2             	sub    %r8,%rdx=0A=
  12:	e9 76 ff ff ff       	jmp    0xffffff8d=0A=
  17:	cc                   	int3=0A=
  18:	cc                   	int3=0A=
  19:	cc                   	int3=0A=
  1a:	cc                   	int3=0A=
  1b:	f3 0f 1e fa          	endbr64=0A=
  1f:	eb 07                	jmp    0x28=0A=
  21:	0f 00 2d e3 8a 34 00 	verw   0x348ae3(%rip)        # 0x348b0b=0A=
  28:	fb                   	sti=0A=
  29:	f4                   	hlt=0A=
* 2a:	fa                   	cli <-- trapping instruction=0A=
  2b:	c3                   	ret=0A=
  2c:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)=0A=
  33:	00 00 00 00=0A=
  37:	0f 1f 40 00          	nopl   0x0(%rax)=0A=
  3b:	f3 0f 1e fa          	endbr64=0A=
  3f:	65                   	gs=0A=
=0A=
