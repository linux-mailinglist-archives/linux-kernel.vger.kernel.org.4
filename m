Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36568A252
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjBCS4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjBCS4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:56:46 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456F5196AC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:56:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViTiV3mBVO1bCGsZfLM4SAj7svfMxUKs7n5/8H6om9y+majqxaqML0xlaRSJDlcSSURjt5ORS4VRyklqAbJinPV7ZtVouuqevkqe0+vJRnloIEpE4fnbIPwSPDzNXxS5INeVR53uMWKvfxcGOHPLbiX5H8ndkhT6UP7KYS38+ZGgGIs73o6FhehmVU4IGA9bcJaY+RiJp1DOBS9HKnPm9J3Oa3vYmJeRlpiJk97Sc3ZmpxB7ID3PZnNZFBruFMWvVcTiWPx1J9dAo4MWq0EvhLuu/NEfDLCVimdM2D/s5dPG1d1tJKZu63yG7/OqN8le0IiORpE5dB6CIjUzWEwf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQM9rlXMUu9gfe8YFTJWy72aP92xNgwICYYfE8EX5nI=;
 b=oNhy3jY8ywE1dWfhzGYETUQak4sQjVbMkhej/bbbib2qqy3t9B+WWahYpyI9y3ETbP5y7mpReB3qPUitIr0GDArR7wzW7BLYmCb2VDmHMuvGJYUpht1wyscI2jwdzFXmiz+TWy03TmnNkOGqZSwg0cnPk5R3ULC2rNk5lmixhe/t3i5TlN38E0SfLk0WGXQ1IKdRcJpWNtvQcLYfS7TFr4o9cu0t2yjXtNdcU1/+pDSFK/s9mb28GsxqOKu+OEIXGEtaUX6mkjrGvRYPCAUAV6mdTS6dBxjMJJMTTITefoCEfAsZ93DqM6dFCRio6C1sOKQBl6N4cVU/TJ1lZ7oRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQM9rlXMUu9gfe8YFTJWy72aP92xNgwICYYfE8EX5nI=;
 b=fGPyjjksi0ULKSuFZuKwg3WK+58H1qp2m9bSgvzjToPH2yNmcCnuzfWiZ2uqpcsxlVxcBrJkHVXtV6sp7rXr6mrxg7hi/stLw1lab+xUQ5E3lXv7ZjyOfV6asa7CDf82rQuFHlUkVl0Q6j6JIeO2iaNgFTI2Y+g0d4T/Oj1pqcE=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by DM5PR07MB7894.namprd07.prod.outlook.com (2603:10b6:4:aa::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Fri, 3 Feb
 2023 18:56:42 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace%9]) with mapi id 15.20.6064.024; Fri, 3 Feb 2023
 18:56:41 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: KASAN: slab-out-of-bounds Read in f2fs_iget
Thread-Topic: KASAN: slab-out-of-bounds Read in f2fs_iget
Thread-Index: AQHZN/1XNusp4zIyiEC4U6RFRi8pVw==
Date:   Fri, 3 Feb 2023 18:56:41 +0000
Message-ID: <IA1PR07MB9830A51FD5E2F4BA573EE517ABD79@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|DM5PR07MB7894:EE_
x-ms-office365-filtering-correlation-id: b988f760-8455-489d-6124-08db06186333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ucB4xX3aV/vWzxJMlWV4CDPSezMRj0/V7bp3xWVosq7BTqjJrXU3ZrLH5c0IacW5Ue72Hb+Oydjeq6cVjLmWAGqPTacwjAlgijfMWEtWyYvRLB+wZutUDwflRg0apaDB97KwbsglAtQlMW7CCVh3xIAJlUPKfyStN6UFCpfOY5swAkGCla/eyOnulRPYqF/Zh3GKsj5/MYXJ1jKYHzideylqpls848vQDNyi7sdRB6jM6eNQ6Z9Ogqy3MlLf+PO0vl1inFoj7BcjlheedVnYeIL7f1OnhujElPXUpHuy9TlYN7cTIUcalYX7/j96iNxd/zAWOwt1vhysbsJmcjvhIsUL9tb15tt38zu+0tcyXz9bxHdCTwD8mmIDHdg/ej2Fjcrn6IbqHnCayj7lS1rrsCnEj5cw/RKjvbsnfuMIJ3vTwGVycpZo06z3Q7yea5QCAfkqDDjqHxIr8PXylbJZhKHVk5+EoR7D1PaBnEOFtPIe4tjFsVq7RYonTUm9s6v6o7uijapA3pxnxagDyXboB3FKOCMYyZh2c9H4EL16oyGmAhpGjt3e+fO0jU8Bra+vvqVyxlDeFDml6nLFV4ALQugwt4j9QnlQhRsY9jYtkkhGXEzgTY0hhSLZK15WutmTTkWvEnNuowq8yQImmzqpabnKiArsEwwYgHHqhcihEUwb8/OHWikEbJcDXcuPh7AHv0v0sgL4iCCOHcj6mtFOE9Lz7QjzcTs4cHvzby0fp9y6x7jXs4e99Q0xNugOZalumZDdUOByH+0jCY1eDHrREpsE0+VBmZxDC+C8vhkqpwnaov3iFJrcDkzmtNgwwPJoBvZHg/oJ7dAD3srJjjdmmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199018)(5930299012)(478600001)(66446008)(2906002)(64756008)(4326008)(8676002)(41300700001)(52536014)(44832011)(8936002)(5660300002)(66476007)(316002)(76116006)(71200400001)(66556008)(91956017)(110136005)(54906003)(66946007)(7696005)(786003)(966005)(6506007)(83380400001)(26005)(38070700005)(9686003)(75432002)(186003)(122000001)(55016003)(33656002)(41320700001)(38100700002)(86362001)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0o6EVf4b4rxXXYg+9hsS45PlOg/cPU5K4ce0DDkvAMF/W4M4EyoNaPuXkp?=
 =?iso-8859-1?Q?Hat+61RmT2dn+ilyw0SO6D5i+H8DZEwipKMp4j2DmEeOkA6VoJBQHXQpeB?=
 =?iso-8859-1?Q?Vbz0B5/6XhmqzXI55pEUNpPB8ErjwoFkjPdm5uM75A2d7FJhqg/auANgq1?=
 =?iso-8859-1?Q?2MtFxP5B2aquHWSM8tc7RcETBnueX/RG7biUNnTJnufFsAkdpikEap9huV?=
 =?iso-8859-1?Q?2HkTS6b9ytmiQLpx+99eRJM4dQxhOZW77K9+CyeL/yEJEZRQbzxThI8fOU?=
 =?iso-8859-1?Q?vO6s+UmQJVExEya1tkZ9DrmFEgc3aZvOWWOp++4F1kWsGZQ89Cax5pFF+T?=
 =?iso-8859-1?Q?biRxBMHC2LN+BBdJZkIqVyhZdeY+JOWBWR9YLXHEImlmo3ZH5Yqy0df+qF?=
 =?iso-8859-1?Q?3LuhDVPrN6OGQr/incj0S0CkJbqmPZkc5Lxx3WuB3DaznlLuhUgqgZRvcJ?=
 =?iso-8859-1?Q?savYUj9EfoluhBHJ2wWU84wb78m5CJeeG6gKpY0nu7eDdraOEMXyZtFW+R?=
 =?iso-8859-1?Q?MoapGFaQcj0Bt2ygmSuaEvxfcR78cHJ61HJrteRMAeosq9rPJYaUPpUcPu?=
 =?iso-8859-1?Q?sLvqyLKbhnU8llBcgx5w1oMOwkU3stiFL60PFCueqHP+MN5JVVjpawlhcJ?=
 =?iso-8859-1?Q?7xV0p4DCYYIvanaE3tcI4F608C4fpVhkLrvl/falY8JStF8M2CN0mD3xxC?=
 =?iso-8859-1?Q?CY7FCIAU0i5KTyWkL9NQAfqxWTmVFJO4xSpDJvt5tkrj1S80MVJco4/kgb?=
 =?iso-8859-1?Q?Or+sLcMG5thj9pHaWfaELV6s4mabikhe8LTNgGiup621CUXfbWAtJ5KD11?=
 =?iso-8859-1?Q?+A3wku6Roaux7dZaRYP+KXiZJ/sODRZg1axkj0hy8kO7c1f7lHS+E7UuxZ?=
 =?iso-8859-1?Q?PNxd9iMD6urHzsOvk+TK8sWODL/dRqWQz4B2SPMnVr3uUfL7+JYc62y5yQ?=
 =?iso-8859-1?Q?UU7VnznrvzrQTad5R1L/Q60dHodyxt3NaZOryLQvqTRy3uxa7ZSu6+DbYQ?=
 =?iso-8859-1?Q?IF3JAtv6hxcSJLqshSKIucxjsaz+TNbZlgHanzJozoHZ8er9fMUgmVnE7P?=
 =?iso-8859-1?Q?EevtV+bwM2XnWIfkZFEQRsdnCVSra5TBQc6mZ6sQ3LtDn/CFmRxG+kOTQS?=
 =?iso-8859-1?Q?FXs2F2wtOz8NnmJnYs8wKN8Uhjc4ckW0VrON1pnbgXxP1yRLooacpvTnJB?=
 =?iso-8859-1?Q?sPHHRrxi1cy1cbksWqCEfh5HinIc88zxerfpwBWG3h0/KWV2+UhIseNsJA?=
 =?iso-8859-1?Q?oT/Cn2VpuWGlmyOq9iAjmHfV0nOQ56HLtzwzuJP3Gyi++C1om5zqnK/qLq?=
 =?iso-8859-1?Q?ep5WMibcZmXaWCWKqa7plQDa4A9o0isDMW8xjm9TTiZSzKkkz0V2UmUvUd?=
 =?iso-8859-1?Q?srHASdw6rICkraY50Bq2EtCNQXTyF98jcOctNxmy3LB6G1QyH/eFcs8Lih?=
 =?iso-8859-1?Q?aI+ofbinP59TsRGJSB73/8XjSVrtOmRfwYYSQineY2Ju0mAhRkLxGkqnvp?=
 =?iso-8859-1?Q?V33BllXUkTQaz7S+90xUF634n10aYdMUy2h+ItC3xmZfNFs6ecc0j48J7o?=
 =?iso-8859-1?Q?0P6yb3ikbzonIebxpiEDchIryKAQ4JMVFEQX6H105p26qYMaAgQyF+KxUX?=
 =?iso-8859-1?Q?QNWHLsJNqBVWhMASajIERPWVrcLSbOl8N9x6Fut7VVzwCagr0NVgHXHg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b988f760-8455-489d-6124-08db06186333
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 18:56:41.5881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: As1Tm56Og4HqXD0q6TXuTNnxu/CkdmlyXRdyWRC5EEyJEgRCuxDj+M2CTIkBIzZpjIL37yw9VaP3P5sDOv9UgkS+m+oVdgeR7FNqP2sYb78=
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
Kernel Branch: 6.2.0-rc6-next-20230201=0A=
Kernel config:=A0https://drive.google.com/file/d/17UnUG1E5HyCPGz_HN8--CTXXx=
SHV2e6z/view?usp=3Dsharing=0A=
C Reproducer:=A0https://drive.google.com/file/d/1SUoN_Bud8DW-FHrE4bV-azXaAd=
ITStS9/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)=0A=
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock=0A=
F2FS-fs (loop0): Found nat_bits in checkpoint=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
BUG: KASAN: slab-out-of-bounds in f2fs_iget+0x4acd/0x5550=0A=
Read of size 4 at addr ffff888111be9bf8 by task syz-executor941/5911=0A=
=0A=
CPU: 3 PID: 5911 Comm: syz-executor941 Not tainted 6.2.0-rc6-next-20230201 =
#1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Call Trace:=0A=
=A0<TASK>=0A=
=A0dump_stack_lvl+0x178/0x260=0A=
=A0print_report+0xc1/0x5e0=0A=
=A0kasan_report+0xc0/0xf0=0A=
=A0f2fs_iget+0x4acd/0x5550=0A=
=A0f2fs_fill_super+0x4131/0x8490=0A=
=A0mount_bdev+0x332/0x400=0A=
=A0legacy_get_tree+0x109/0x220=0A=
=A0vfs_get_tree+0x8d/0x350=0A=
=A0path_mount+0x675/0x1e30=0A=
=A0__x64_sys_mount+0x283/0x300=0A=
=A0do_syscall_64+0x39/0x80=0A=
=A0entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f5b5d4a67ee=0A=
Code: 48 c7 c0 ff ff ff ff eb aa e8 ce 05 00 00 66 2e 0f 1f 84 00 00 00 00 =
00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007ffecd308d08 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5=0A=
RAX: ffffffffffffffda RBX: 00007ffecd308d60 RCX: 00007f5b5d4a67ee=0A=
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffecd308d20=0A=
RBP: 0000000000000003 R08: 00007ffecd308d60 R09: 00005555ffffffff=0A=
R10: 0000000000000000 R11: 0000000000000286 R12: 00007ffecd308d20=0A=
R13: 0000000000000004 R14: 0000000000000026 R15: 0000000000000000=0A=
=A0</TASK>=0A=
=0A=
Allocated by task 1:=0A=
=A0kasan_save_stack+0x22/0x40=0A=
=A0kasan_set_track+0x25/0x30=0A=
=A0__kasan_kmalloc+0x7c/0x90=0A=
=A0snd_info_create_entry+0x51/0x420=0A=
=A0snd_pcm_new_stream+0x4d2/0x1530=0A=
=A0_snd_pcm_new+0x246/0x3f0=0A=
=A0snd_pcm_new+0x3e/0x50=0A=
=A0loopback_pcm_new+0x95/0x200=0A=
=A0loopback_probe+0x294/0xe90=0A=
=A0platform_probe+0xba/0x1b0=0A=
=A0really_probe+0x236/0x8f0=0A=
=A0__driver_probe_device+0x252/0x2d0=0A=
=A0driver_probe_device+0x4c/0x1a0=0A=
=A0__device_attach_driver+0x1ce/0x290=0A=
=A0bus_for_each_drv+0x163/0x1e0=0A=
=A0__device_attach+0x1f2/0x490=0A=
=A0bus_probe_device+0x1e8/0x2a0=0A=
=A0device_add+0x10d4/0x1c90=0A=
=A0platform_device_add+0x35a/0x6f0=0A=
=A0platform_device_register_full+0x396/0x4e0=0A=
=A0alsa_card_loopback_init+0x167/0x2c0=0A=
=A0do_one_initcall+0x141/0x860=0A=
=A0kernel_init_freeable+0x5e4/0x8f0=0A=
=A0kernel_init+0x1e/0x2c0=0A=
=A0ret_from_fork+0x1f/0x30=0A=
=0A=
The buggy address belongs to the object at ffff888111be9800=0A=
=A0which belongs to the cache kmalloc-512 of size 512=0A=
The buggy address is located 752 bytes to the right of=0A=
=A0allocated 264-byte region [ffff888111be9800, ffff888111be9908)=0A=
=0A=
The buggy address belongs to the physical page:=0A=
page:00000000acf7864d refcount:1 mapcount:0 mapping:0000000000000000 index:=
0x0 pfn:0x111be9=0A=
flags: 0x17ffe0000000200(slab|node=3D0|zone=3D2|lastcpupid=3D0x3fff)=0A=
raw: 017ffe0000000200 ffff888100040600 ffffea000446fa90 ffffea0004470e10=0A=
raw: 0000000000000000 ffff888111be9000 0000000100000004 0000000000000000=0A=
page dumped because: kasan: bad access detected=0A=
=0A=
Memory state around the buggy address:=0A=
=A0ffff888111be9a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
=A0ffff888111be9b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
>ffff888111be9b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^=0A=
=A0ffff888111be9c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
=A0ffff888111be9c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
F2FS-fs (loop0): sanity_check_inode: inode (ino=3D3) is with extra_attr, bu=
t extra_attr feature is off=0A=
F2FS-fs (loop0): Failed to read root inode=0A=
