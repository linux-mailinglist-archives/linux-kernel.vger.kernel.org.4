Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9A699F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBPVo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPVo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:44:56 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D64F4A1C3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:44:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1Sl5NPjaTt2F5fbZTc3SrP+NGHP0RsLBSHc5GMZ0owDEBz21QVvEoU0bXHx1HmcVZLMatLxWhqFoGhzBdQ4IcX/OxHac7JzeAcGmQ0gneGcD3ylZWoqBaaHo8pVokggEzh05wzUFQnV4whAAkwnpuZMXTtDCHV1KkuIb/Kej4Cr+NWktxe3JRI+pPgvcPxif8v7D1SBsl9VSa72ZIsof/+A0Q/xWI3HPiedU6ZJnUqXMRUnAHnzEcA3BXtKxFYLsbGBSlR5TEv+iA0LJkZvebuKZNRpiNXih3GSqUdX8uMD+iMyj6aPnQNYGiR/k+Hqjpd0WKcaQc6oacQ7pWn1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsP+jQ4NyBJ8x0i04dDPGLQPV+ISuHjmggsHX2GrqZs=;
 b=CgDJYurEX9K9v2394W/vLIm6hNRbOBLw4IMOrAKBfZfFWoIVEQdMQuD1AZT+WFCUA1LGlXiNjJjMhp+7QywVi8fQXeDuYohspO1bSG0tvRYPNnRspR8EGIY1YCP/qmWIZw26ph6oilSUh0ldL2yp9T2+bxo26Brb7+GrJjTgamouTAS0CYvhsnkkqIfFSBrvd4AcvVXtN5OA6rrlxfldHGdLvBaACsD8ecICzTRlFpXEe6LH3+7qxoQrSOTk49B2wQ49Uj8ll2KS8fuvxb2HH+kJ1iF2MoVxco3S9NOxNtEtotX2PQQRwMANv5Ho9d5H/OuQ44gDIcB4ho8SxkC/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsP+jQ4NyBJ8x0i04dDPGLQPV+ISuHjmggsHX2GrqZs=;
 b=PNr2JZEpBwZmh/ZMW3FAeJiGLqLqOMIUZ12JE6bF1AkeUAWDKGwd0vbjL52YU0TjJrLO4hbfNuEf9QnY2+0UECne/PGkNJyDD9NMSZMl6LpiMcY956EOAxjj1aCNnXLpxLipuWFar76E0GH9l6Y5WA04qXna8TIfL9pMqr9tdQU=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by PH0PR07MB8717.namprd07.prod.outlook.com (2603:10b6:510:86::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 21:44:40 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace%6]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 21:44:40 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "terrelln@fb.com" <terrelln@fb.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: UBSAN: array-index-out-of-bounds in f2fs_iget
Thread-Topic: UBSAN: array-index-out-of-bounds in f2fs_iget
Thread-Index: AQHZQk2cvSQVA7NGqkOodaiWStBCSQ==
Date:   Thu, 16 Feb 2023 21:44:39 +0000
Message-ID: <IA1PR07MB9830528DCB1AAE0C50DBDE0CABA09@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|PH0PR07MB8717:EE_
x-ms-office365-filtering-correlation-id: 4fbb00db-e8f6-433a-d465-08db106701b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1lZElXTRMHZPqxVNlDiXT/yW2OV/KQzu1VoMh8mjB4nglqnotOGQNkG9/3t4Xu8IvJbQKmJkBywnIKuc1lxMUaTlX0LKQgs7jeYAz1k53Wju3gt0Qf/nFX2oCr4XS4tQHq5QabwnIjh6mdillBVO/57RPKosVnD8HcZRAujL616T9KBDLyeaJ26LBPyxrZQZ8W9Z7Z6bLTsvNwfoIFF8uAvHYu5ZJdrhpEUt6Fb1d3uxNoAOYwjEdZ6ZIgNiI4is/1uzJCpIMWSbXyDRwJuL+pLgQUBXkENboORT4y4NQbgqntANAaUZyqMk+5/BTnHfIxSlMGWDdfsXGvqppDVBoukhSmyNvbaQfyBhOmWCu9YBQR+6NYJe3zKH7yYxuwywIhazUd3vX0RJYCCZB+CSm3uzlwZXK5O8IzGUveM1V7GWWJMK9flyoBVsvyIcG53Nxxcw+PP+47Nj5vHqMHJrTHkWw6q9/G68s1YuJh5nfB0UQUVrN6mMmoJckWSE1t7aAdQRMOA4HJnl0Cd956AK5IMEFAAkQJr0TWyufbQ21R6PfGF3j2Y6W9RKo+lexFY7w2uCiq9SDfPmVLHc+hl8V3abWHc8W86OctpR2ItMo6irJhOOzy7U9S2hgOWuuNCngZX9wXAferid3uEOTeblzbN5h0kQ3+OKnSRV1kIzVa+mDWmES/lnY9qTao4QMHZP7roK5E81DQETEF7skr1GoZUYySxV2ANppQi22h+HGG2Eb8l+/26zhERiJcVMxeGD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199018)(5930299012)(966005)(55016003)(83380400001)(86362001)(2906002)(44832011)(478600001)(33656002)(7696005)(71200400001)(6506007)(186003)(26005)(9686003)(122000001)(38070700005)(75432002)(38100700002)(66446008)(8936002)(41300700001)(4326008)(5660300002)(52536014)(41320700001)(8676002)(786003)(66476007)(66556008)(64756008)(66946007)(76116006)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rZW8drMbH41V29ObfNHM9qSF2VMreHCaLmJUikL0M/S16pbdMXgSFUIHkM?=
 =?iso-8859-1?Q?9h+/9MFTvEmAUdFuZD6MhkXgQHscdHmMihscDoIkcNB81TvdGjAIFN0oe5?=
 =?iso-8859-1?Q?U2QM6NzPbZfeK5EWGLGfRwwI0nuPduz4mMldUobPdTVVfu3jCGmR76yAO3?=
 =?iso-8859-1?Q?9w0D53iShd1Zf1ZllU06qK2icDAcLZIKSjukl+Vw2J6h3gz0W0rKhLrzmQ?=
 =?iso-8859-1?Q?g9BvrU89VVnV+8x3x3zV7/v2Jvg4CYlmXpLClwy/93vgQGOUuYjXRf5O8E?=
 =?iso-8859-1?Q?5IrdcK8A2LW30US7lG57+MGYBiFUG3N49PqWHJeGPcRxRBojPC85bA09Qf?=
 =?iso-8859-1?Q?mDaQ+k5QAe/cox/6HPmbaNdorEtkITMQmZ1lT+smzuBjzxi1ujTi9ITztQ?=
 =?iso-8859-1?Q?gW5K0IsXBxaNQYcS8daiLR87nS0wDmpu+ZOEcpV5rDNDAm9T9lY/citbl1?=
 =?iso-8859-1?Q?p14qT+pS2Uu4Cg0gVwWdMpjXxTNNuYeFZLSwb+Lo3zS7htZYs8sRNXKC1w?=
 =?iso-8859-1?Q?Jg5CdaLPjhnUwfw6ZPQGuDucg5hKUBIIqH5zJAHseeohNJr++9s5F6Sv/J?=
 =?iso-8859-1?Q?jYivefe8+Kk6T9OWfmWFQnhv+K4KI5Y+HOHJnxsK70JwM2doE6py4e19DR?=
 =?iso-8859-1?Q?wDTSxKFBA6kELg97k3KbJ5D0lH/QUzFWCQ8JV9Tt5fvedviSy0HkVhAS2j?=
 =?iso-8859-1?Q?DFXcWoMA4WV+/WZhPdT8gkWVORxVPllLdppvyRWtE4Z6/zRfvZePvU2zJc?=
 =?iso-8859-1?Q?cpHR1nFNC3D7/XW/8sxhqKr8O+qknkP8tp2S3vhn7NOqOdcMrGY9rOBus7?=
 =?iso-8859-1?Q?UDvcwOKmzYnjD6VJ1RFaJ9XwHmCA4i/eZviycUico7Cf3qXsh5pBDRf+ED?=
 =?iso-8859-1?Q?S2gT79DXPQ+SU5BRaIbKyBn7NA93txhdRw/+FIWhYWOuvEwYkk58TmLTx3?=
 =?iso-8859-1?Q?tNRE6m4q+T5+t/kF2ObFwoYYwpruqSMuqFNp3MMCSAZdP7SErNuuR0tOM6?=
 =?iso-8859-1?Q?0ZxI/eXgu9fFwEBKfACtJG/HT/LpvJv6XH4XIOXbJYfXdgfaZmrOSHyXhg?=
 =?iso-8859-1?Q?v28BP2dD7I4FMSPTOA60Tas/pxrpBFG7LiIqQRWTrgl+tWQEmh5rllttme?=
 =?iso-8859-1?Q?oldl98p8/C5UnbbPrZF61xeHJyyjwNi4ZcPvef3s0uSR3Bwc6tO/jGVj9E?=
 =?iso-8859-1?Q?KWA4lskDu20yI2zuTBbG/B7JEpTrQOnRdW8xoYmq+a6rjlxoTVUJsrh3rS?=
 =?iso-8859-1?Q?IsnCIOkJNlH4DFWUcrON5+uZYU1YmHC4hNxYZXGznY7MdfG09FSOvWAT4B?=
 =?iso-8859-1?Q?fMzpjiplzVqzZvLlWhPDfZzVLpW599VPs6NH8cZXyxdvgx35TKXHrlvTa8?=
 =?iso-8859-1?Q?UmNolqs0Nl7mW8S3PX3Hwn/EhcAl6uSTX4rvnaNXCvS2vigNeDP+fx/7eW?=
 =?iso-8859-1?Q?3Yzq9uIm+bPkk3NqucnOjUMFhDfP7m1DzVBvNtZqwOyUIxxrowr6vi4n1I?=
 =?iso-8859-1?Q?812pN322omnJ9xMqwRC0zp/33+0ryPpKDFnOxk0/46CHI7TD3GREhxar/s?=
 =?iso-8859-1?Q?Kgd5umogcuZFCi31PVoTogNjEu9woYTXvVEfOIz3d4jAwEKHwxorSCU/zd?=
 =?iso-8859-1?Q?1hye5eL3vwAMHpxeoKCOwjUZvsClqE+8HC6jvZi0ilwCY6Mw8tmeyB/Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbb00db-e8f6-433a-d465-08db106701b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 21:44:39.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGZYOa91zuaFG7xr7s7tMTQMk8POCAODZCLmV0FntdscxRMGIp7EMFKuJeYvEUFJf8N9CS3eS0ke+PcV9ClakyFii7TPmEf4jq2liv0R6r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB8717
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
Kernel Branch: 6.2.0-rc7-next-20230206=0A=
Kernel config:=A0https://drive.google.com/file/d/16AAzfA1DqiaTS8ohH7X80kud8=
QTCKBB6/view?usp=3Dshare_link=0A=
C Reproducer:=A0https://drive.google.com/file/d/1mWS9BHAKuQcf9R1BiMX17-h9GQ=
9OI_v9/view?usp=3Dshare_link=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
UBSAN: array-index-out-of-bounds in fs/f2fs/f2fs.h:3272:29=0A=
index 1409 is out of range for type '__le32 [923]'=0A=
CPU: 6 PID: 27613 Comm: syz-executor.5 Not tainted 6.2.0-rc7-next-20230206+=
 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Call Trace:=0A=
 <TASK>=0A=
 __dump_stack lib/dump_stack.c:88 [inline]=0A=
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106=0A=
 ubsan_epilogue lib/ubsan.c:217 [inline]=0A=
 __ubsan_handle_out_of_bounds+0xd5/0x130 lib/ubsan.c:348=0A=
 inline_data_addr fs/f2fs/f2fs.h:3272 [inline]=0A=
 __recover_inline_status fs/f2fs/inode.c:111 [inline]=0A=
 do_read_inode fs/f2fs/inode.c:418 [inline]=0A=
 f2fs_iget+0x5300/0x5620 fs/f2fs/inode.c:536=0A=
 f2fs_fill_super+0x3c09/0x8a10 fs/f2fs/super.c:4363=0A=
 mount_bdev+0x351/0x410 fs/super.c:1372=0A=
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610=0A=
 vfs_get_tree+0x8d/0x350 fs/super.c:1502=0A=
 do_new_mount fs/namespace.c:3042 [inline]=0A=
 path_mount+0x675/0x1e30 fs/namespace.c:3372=0A=
 do_mount fs/namespace.c:3385 [inline]=0A=
 __do_sys_mount fs/namespace.c:3594 [inline]=0A=
 __se_sys_mount fs/namespace.c:3571 [inline]=0A=
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3571=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f7c3449176e=0A=
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f7c35569a08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5=0A=
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f7c3449176e=0A=
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f7c35569a60=0A=
RBP: 00007f7c35569aa0 R08: 00007f7c35569aa0 R09: 0000000020000000=0A=
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000=0A=
R13: 0000000020000100 R14: 00007f7c35569a60 R15: 0000000020011c40=0A=
 </TASK>=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
F2FS-fs (loop5): sanity_check_inode: inode (ino=3D3) is with extra_attr, bu=
t extra_attr feature is off=0A=
F2FS-fs (loop5): Failed to read root inode=0A=
