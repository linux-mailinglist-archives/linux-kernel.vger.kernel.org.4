Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CACF6545A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLVRkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLVRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:40:13 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C24613D71
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 09:40:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOpFpDhYLG+vou3XISSyz12LJQ80w7bEUuaWIk4AA1XhOGP15i/SrUCm6VEZJ9y8i16w1pPguHXoD4xxHa5lkRC+haHoJIXLhL6RY2mrf/Je0Yg6fTLNITnZ1YM3b5D/CPZ53LmiXsUYGG9il1G4oaxMtKQ5hPFamV/VJyILYS1gJxjUz5Tx6fzT6IsuYts+dlJER6K8hvOXJDpwnl8fodMLosefwbRsEhf1UR9WJO62Itnx3I+zLZiFl5v1y1IIfaEUldCz9FtnOA1QyO6zn10wg59roeT6yz1jKOauahPr4FAYlyQrOTWsxsgCVADKzBeP7Bl+E0IBba04KUQsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFAOLcy+BJGnQTLqrGlaeDtzhcOYi5vOzi5PGVcbxxc=;
 b=ACmKMnUpAZCupn9d3hVoEID6xAItfRGm+/d1S4IIT1Mz6hPHqR9ikbWMyiRTN8pq5f73LzgE+achOH8wKp1JAS/VuH0RiQKd1w/QZWFYbDpDu92pDnxd3T19ZsR0JDwckDfWy9v3JDuLXuZJgi5JLjQ4J9AFTX/E2xgcEDQMF9FdBawoSCGVObw5c5XHOauywj1KuYE3Ipq8W+8rxHq0Lc9VPSEFZYVPVnwfS2WEK1Y0s/Ivxrlw/i6IaWRnypsbwYlXjJL6cP0YfL68Ltr6x9ChK+kG1FljTcQMq+JKLbPgGX+3zxpjb8seIxnzy0Y+KCw+h5ltcj8cg3XztdwQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFAOLcy+BJGnQTLqrGlaeDtzhcOYi5vOzi5PGVcbxxc=;
 b=FcNHEEd2ZBFXL5wF4V86D6qIE59FxkAbk0/WP/coQx2kDFWHmo8ApEOHrBp8EqnI4Ix9f33Z01LHibF3wql58B8VL0cTRykuivp79ixRiSTphqOD/+fofjmMmRxVi6dydOPNbrpIQfkxlWYxm0Z1B5gK5MPA6N+fezh4YZBHOxg=
Received: from BN6PR07MB3185.namprd07.prod.outlook.com (2603:10b6:404:a6::15)
 by MWHPR07MB3519.namprd07.prod.outlook.com (2603:10b6:301:68::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 17:40:09 +0000
Received: from BN6PR07MB3185.namprd07.prod.outlook.com
 ([fe80::6acb:4a76:60f7:7698]) by BN6PR07MB3185.namprd07.prod.outlook.com
 ([fe80::6acb:4a76:60f7:7698%8]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 17:40:08 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        Paul Gazzillo <Paul.Gazzillo@ucf.edu>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Syzkaller found a bug: KASAN: use-after-free Write in put_pmu_ctx
Thread-Topic: Syzkaller found a bug: KASAN: use-after-free Write in
 put_pmu_ctx
Thread-Index: AQHZFifjkkQumCC/w0aH8rOryqbv5A==
Date:   Thu, 22 Dec 2022 17:40:08 +0000
Message-ID: <BN6PR07MB3185E78473482885FE72BCF3ABE89@BN6PR07MB3185.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR07MB3185:EE_|MWHPR07MB3519:EE_
x-ms-office365-filtering-correlation-id: 625f0257-14b2-43a7-f74c-08dae44391d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mHGd0z4/HqUZFjgpnGyJ2hYkOPMvae/KAcstTbvvNuaxDrEpP4dDmPbzuJRxsU9QKQTGTc806SBZpYXJxiRCx2tUw6QMU9X97K/TDs2HHLcLBvzIZg9rhjSYpEzJ7BEm9Akk7VFJMVzf/wiCkcO1MLgrzSMXZlen6T4EVEeJ7n8IXKm2qtvyKOsrPkKq/sjOp9GDeEt+Urh+PpXxWhKcI8N95v9EyQx2a9LJ1jSq7+tSPW1ll68ei3dlXKELL2sM865NjP2X7IoRLy2FefyLj63Y0BgyrkMTkHQt7nbIfOw95glA+GOBSnY2jB7CZEQ+DnN5h8pvaRkvVnH/VoYe19caHiSxBs1rswmtUggP69MZSuYkAvNlCd3H3ngxzbN/ecaCpwD2DBGmoyMqEkywpq2NZCRNsS2pdFp8ce83l1cmFp6308qD+ah80mOst2Q5lxEjT3hxLi3KDwXg/2zmtivFfuoTexNiG6l7UBoaOklJSfc1P8lccbqY64x8X2uQQOMNTFIOZS6L6RPasmSTSHCCpqFsjJKNAf123pBceF4djtC3y6VioRYFaaToh7IqdJ+84ZVcXRDzznJghW/WwzViMH1S8GdgT+Sz2vfPwzWDnk40f7AYzzmJicjod7IBO9lWsIlhwHOMqAwhIeb3p3mLkjmPQijoaY1m1Ly+D/K72H0Dq/LgtjmYj5YnN8902rk0hdGWKyZI9I6y71t0RUVUl0CVJbMv6QmLsgqQ4lq629JUa+XRXgdNigL3k7RIvgcALHihXCR009bNddRcCjtfYFER/iXPirqMz2otMu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR07MB3185.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(346002)(39850400004)(451199015)(110136005)(316002)(54906003)(26005)(786003)(186003)(52536014)(9686003)(75432002)(2906002)(55016003)(41300700001)(83380400001)(8936002)(5660300002)(44832011)(91956017)(66446008)(41320700001)(76116006)(66556008)(66946007)(86362001)(33656002)(4326008)(64756008)(8676002)(66476007)(6506007)(5930299009)(7696005)(966005)(38070700005)(478600001)(71200400001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ErNo3WkqeZq8dvtvQpLSeh8/9tNxi8WnnaNFANC+ieQZCti8liOyQXiKoi?=
 =?iso-8859-1?Q?jSPGQ/4RqVq2wBKGYwrIFEsjGKtnqPsWE4IbB1ypSQ5EIRhrCryWNg2U4K?=
 =?iso-8859-1?Q?JmBdVyM0kcv6M+/WbPSoMtdn58dDfV9YVrQRhqn5D1X8X1ucTckZxnV4R9?=
 =?iso-8859-1?Q?QUQnzud4NNZIeG27Yxi0bfsZi4EJ7OVKbqTcUI7HD0pIMXyT4HhfdgygIM?=
 =?iso-8859-1?Q?8akWcOGbwP/HhxrBBs6kXsOaOkxDx/DLDBYLiodRq7Bx72h6d4hmJjPcua?=
 =?iso-8859-1?Q?gjZd1WE7nT+orJWpxUxzA3KOFuZpsEIOKuqRUlgpAQ7Q8in6iRlFyZ1rYP?=
 =?iso-8859-1?Q?37gJUC01/BjZGhezOYwpqgM5LIVd72DQHpXZsMFGGDu6pDAG9ILd3LQKOh?=
 =?iso-8859-1?Q?eKRGDgPzgRfo72va7cZiFi+0PaSAJzkG3BDB8pPppjHHymzN0A54fDLtT1?=
 =?iso-8859-1?Q?Ok8V19fER79T2gK1ZmetXo+pvwE8A85oBNrxImN4WADZAkePBBBAVfan8s?=
 =?iso-8859-1?Q?GISBbLHjTJRKhkAgY/573TFSGGT7Odb1s+D7gWnyk9hoARu0EwxI24SuT+?=
 =?iso-8859-1?Q?mrRsA6aJl56qCb0rqVVLemIYWefApUT7scMdpOrr/UbjfOZFj3X9PmXIfG?=
 =?iso-8859-1?Q?QqC5arwRzqSjT32ptAAb8RCouevbsa0Lm3S/el7ojKZzJWq9QAEl35ZxTb?=
 =?iso-8859-1?Q?YKP4nzb/UnTVWgEsgX+zTJqCnSRi//NrWPcSUflUMywVTQH3anEaXeCqdu?=
 =?iso-8859-1?Q?/eev3RumbB8M/L0ZICaZrgHxoSFwpb+RzdGYgiyAkbqW83IuovaLD0y+8y?=
 =?iso-8859-1?Q?FB+LB3d5zExT1J0yYF0S1qxiqKyMPtL3Ai1Ve5XfLvmPSLu4Q6gP6BMGOs?=
 =?iso-8859-1?Q?ZGZ2/VKhah68IWVNM2pySPJXpX3WebPROH8Is3TgYaBHXzDc+NoBym08LV?=
 =?iso-8859-1?Q?nSffFQ8dJ6kKrNjwUu2qrSuYtuFu3oHRfLZfZNOEcTT02LA1rZa8ewWRuZ?=
 =?iso-8859-1?Q?lzZVbj1bHf8PjA3a+/gwZ0PhGYWqNOVP08gtfH6tYg8nJcyeAccymb5yWu?=
 =?iso-8859-1?Q?2P2M49NzqwjWDR29fOBmLy4Uc5n29tGUs6PHYNWIb67KWiHvu83XVvDDOX?=
 =?iso-8859-1?Q?I6qgFmlOXZcvc5zDEMND236ZUF7S7Uc7ChzFVOXT+TfQEiAGw0HxHFq3l7?=
 =?iso-8859-1?Q?JlBngv/KInXpiZ2Vy+Z4Pfqt/AKRaU0N7ETdbs0B/ELKVZXkrmjkwTKQli?=
 =?iso-8859-1?Q?OatTCs0ssaIaA2EfCP62dB9JX8rBBXm9VEgygqK4RVuyM5+klJQNKV08qz?=
 =?iso-8859-1?Q?lS4gpGzlU3WIPZd7Rc/KWPqjl8mFk3mA5hzkQH6lwgE0iUsNFrEqKfEklv?=
 =?iso-8859-1?Q?D2bLlj3kb4ftlWzJNdRvHuZMkQ3cOyB/tSf6IY64y/STAtq1aLl4z4q6Lw?=
 =?iso-8859-1?Q?D7x0cGvcsT5+r5uKo3eT5O8aHcXIuTMCs7LU19ZVfD7X2FZdxBJlJjWN41?=
 =?iso-8859-1?Q?0BZstjcVk9EsjXmk7VfDorJ+OY/T6oIYcWSn2CSSl8+cM1cfLLDr2cFmBF?=
 =?iso-8859-1?Q?52Lzr8Opmx6a0tuB0DiqLY208YJVhMd6ylBv7eKkrmP14UvZ9RcsKqLdAJ?=
 =?iso-8859-1?Q?zJgQoDJjelenMaWj1Nj5IlzgGlKQYvrwRKjUq6eOoGEAwUDSofIpG3Bw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR07MB3185.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625f0257-14b2-43a7-f74c-08dae44391d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 17:40:08.6916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekbkvCvdptjAI3HypTQ8tFHTxysP6WIagVNlydGi7KDrsZ40X5KhfUX4d/LuJ9nLlN/gGrZoH4SegV+Y8m4/pN2S8SKaBXhtJdrSyilQU+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3519
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
Kernel branch: 6.1.0-rc7-next-20221201=0A=
=0A=
Config file: https://drive.google.com/file/d/1JutR21cgcf28flJVyLqDniNyrExMs=
Sn_/view?usp=3Dsharing=0A=
=0A=
Reproducer file: https://drive.google.com/file/d/1X31x8w4ULrtP_YnkD7_RCyW7F=
lwGewMR/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x7d/0xf0=0A=
Write of size 4 at addr ffff88810327d800 by task syz-executor.0/24706=0A=
=0A=
CPU: 2 PID: 24706 Comm: syz-executor.0 Not tainted 6.1.0-rc7-next-20221201 =
#10=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1=
.1 04/01/2014=0A=
Call Trace:=0A=
 <TASK>=0A=
 dump_stack_lvl+0x51/0x6a=0A=
 print_report+0x16f/0x4a6=0A=
 kasan_report+0xb7/0x130=0A=
 kasan_check_range+0x143/0x1d0=0A=
 _raw_spin_lock_irqsave+0x7d/0xf0=0A=
 put_pmu_ctx+0x9d/0x360=0A=
 _free_event+0x2b5/0xfb0=0A=
 free_event+0x42/0xa0=0A=
 __do_sys_perf_event_open+0x4c3/0x1c90=0A=
 do_syscall_64+0x3f/0x90=0A=
 entry_SYSCALL_64_after_hwframe+0x72/0xdc=0A=
RIP: 0033:0x7fd03b442dcd=0A=
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007fd03abb2bf8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a=0A=
RAX: ffffffffffffffda RBX: 00007fd03b56ff80 RCX: 00007fd03b442dcd=0A=
RDX: 0000000000000000 RSI: 000000000000082a RDI: 0000000020000140=0A=
RBP: 00007fd03b4b059c R08: 0000000000000000 R09: 0000000000000000=0A=
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 00007ffcf64779df R14: 00007ffcf6477b80 R15: 00007fd03abb2d80=0A=
 </TASK>=0A=
=0A=
Allocated by task 24706:=0A=
 kasan_save_stack+0x22/0x50=0A=
 kasan_set_track+0x25/0x30=0A=
 __kasan_kmalloc+0x82/0x90=0A=
 alloc_perf_context+0x43/0x350=0A=
 find_get_context+0xaf/0x5d0=0A=
 __do_sys_perf_event_open+0x6ce/0x1c90=0A=
 do_syscall_64+0x3f/0x90=0A=
 entry_SYSCALL_64_after_hwframe+0x72/0xdc=0A=
=0A=
Freed by task 4352:=0A=
 kasan_save_stack+0x22/0x50=0A=
 kasan_set_track+0x25/0x30=0A=
 kasan_save_free_info+0x2e/0x50=0A=
 __kasan_slab_free+0x10e/0x1a0=0A=
 __kmem_cache_free+0x7a/0x1a0=0A=
 rcu_core+0x59e/0x17f0=0A=
 __do_softirq+0x195/0x57b=0A=
=0A=
Last potentially related work creation:=0A=
 kasan_save_stack+0x22/0x50=0A=
 __kasan_record_aux_stack+0x95/0xb0=0A=
 __call_rcu_common.constprop.0+0x6a/0x820=0A=
 put_ctx+0xe9/0x190=0A=
 perf_event_exit_task+0x3ce/0x540=0A=
 do_exit+0x8a5/0x2680=0A=
 do_group_exit+0xb7/0x260=0A=
 get_signal+0x1a0a/0x1b00=0A=
 arch_do_signal_or_restart+0x79/0x6b0=0A=
 exit_to_user_mode_prepare+0xd8/0x120=0A=
 syscall_exit_to_user_mode+0x21/0x50=0A=
 do_syscall_64+0x4c/0x90=0A=
 entry_SYSCALL_64_after_hwframe+0x72/0xdc=0A=
=0A=
Second to last potentially related work creation:=0A=
 kasan_save_stack+0x22/0x50=0A=
 __kasan_record_aux_stack+0x95/0xb0=0A=
 kvfree_call_rcu+0x2f/0x780=0A=
 drop_sysctl_table+0x27e/0x340=0A=
 unregister_sysctl_table+0xa7/0x180=0A=
 neigh_sysctl_unregister+0x5f/0x80=0A=
 inetdev_event+0x47f/0x1280=0A=
 raw_notifier_call_chain+0xa6/0xf0=0A=
 call_netdevice_notifiers_info+0x97/0x100=0A=
 unregister_netdevice_many_notify+0x884/0x13b0=0A=
 default_device_exit_batch+0x3f4/0x530=0A=
 ops_exit_list.isra.0+0x102/0x150=0A=
 cleanup_net+0x443/0x840=0A=
 process_one_work+0x861/0x11c0=0A=
 worker_thread+0x54d/0x1140=0A=
 kthread+0x28e/0x340=0A=
 ret_from_fork+0x2c/0x50=0A=
=0A=
The buggy address belongs to the object at ffff88810327d800=0A=
 which belongs to the cache kmalloc-256 of size 256=0A=
The buggy address is located 0 bytes inside of=0A=
 256-byte region [ffff88810327d800, ffff88810327d900)=0A=
=0A=
The buggy address belongs to the physical page:=0A=
page:00000000427018d3 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0xffff88810327ca00 pfn:0x10327c=0A=
head:00000000427018d3 order:2 compound_mapcount:0 subpages_mapcount:0 compo=
und_pincount:0=0A=
anon flags: 0x200000000010200(slab|head|node=3D0|zone=3D2)=0A=
raw: 0200000000010200 ffff888100042b40 ffffea00042bda00 dead000000000003=0A=
raw: ffff88810327ca00 000000008020001a 00000001ffffffff 0000000000000000=0A=
page dumped because: kasan: bad access detected=0A=
=0A=
Memory state around the buggy address:=0A=
 ffff88810327d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
 ffff88810327d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
>ffff88810327d800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
                   ^=0A=
 ffff88810327d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
 ffff88810327d900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
=0A=
Best regards,=0A=
Sanan Hasanov.=
