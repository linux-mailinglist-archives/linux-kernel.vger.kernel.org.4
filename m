Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87427699F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBPVpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPVpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:45:14 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E665A3B846
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:44:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2Kwuh5mylqt+PKc362x0Yg3Kp5uJIIwl2bi+PXYIQDAGb9RQW9JoGRuccxLjDAjkyKOLJXF605ISoSskVHij1yLhtsMzs/3kWmYnHv/HfolDpQ/Mpx/WXa6SDsALXG3OyBeOj7OkRlatPogNiqz4HrD7W92cSncKk2V/RWOMPDqUttr2oWkvLEqTIKbodCL9UODR4iEswGM50pbU+FSbNJ0SO1jYuz7XocYbLPXVNgPCdL1ti+ePWBK3HR4gcr88DmQQAR6yComb7/f/NGjt/hQjae++pRKQJ6cPUf/iv4FiVrlnGLaOVxBXfB/7oFzRtXU9NacuY7XB8GLEy9zUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jKcv6ezLeDRWsWO6cUgxBVdwXYsdiHABxeYg8WWpzY=;
 b=Ox3mt7L0rofeon6QWgzaPnPDd1r3DexnSlQV85Qwg63EB5+bIyJR1LuvHicT7AzlHwLYoT/TM2nFhkCtnGvQS3ibEsaEESWNPjgoDx5yeWTJJ1cKYUqcIFd4oVGVNY5Ec3zdw+M2B9eHglAWKgTHtxuKlDY/l9Fs9DUZYe119J44OQlkeseZ9wW+jJcy9ZRGJQweWHhUnFYc3VjD+tKGjv4qwkU68iLGE2+Jk42Ec6bTSjV4+e38fdlKfmH85qz1r5zFtf9hITqgi8T3hVBZg4J8fGF9TS16/UblNFncsT2LEtoP1GRn95BX3zKB1s+vtWy3EwHsS+P0tXQDvnPKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jKcv6ezLeDRWsWO6cUgxBVdwXYsdiHABxeYg8WWpzY=;
 b=bcvOAJz+yftWBuP1qQUxS+JGqtQANNsBbW3BLS6qToGZSJwX1PNDJltch7BFy+nvKFr1eb7gxzlHMgUIRi4z5fKPIb1ZpWU8AHFv9TQlIjGKH16TsNf2CqUqfhUE8VvfQMX8syv+URM7rOo9S0dk8dz7Xxkp1G/o40tHT0Xf5r4=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by PH0PR07MB8717.namprd07.prod.outlook.com (2603:10b6:510:86::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 21:44:45 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::d883:f078:37f:dace%6]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 21:44:45 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "jack@suse.com" <jack@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: WARNING in udf_truncate_extents
Thread-Topic: WARNING in udf_truncate_extents
Thread-Index: AQHZQk6RXDAWR+GuY0SI6VNkaTq7/Q==
Date:   Thu, 16 Feb 2023 21:44:45 +0000
Message-ID: <IA1PR07MB9830389CD6BFD22047E8BA41ABA09@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|PH0PR07MB8717:EE_
x-ms-office365-filtering-correlation-id: 3cae1af1-fff3-4293-28eb-08db106704e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xfwKd7buHQCpZZ6PXKAF7oEBA51AL/yLgWP85HqdisLFGu74pLYyuGk9amCcigVDShjQRfPxAsJJu/j5V1slI4TTHgyZiliD3QJJYF4+SS3cTrobkbLesBAWeoUNhDiDwQSIMbaMAZsJrh9ZWIG7Nzx3KTsHBF9mKIqG3GibEKvx7psfq2q56XCjgU+4PNre2YpU80gpSDvp0u0oziKPXP+UhEcJstO1pfJ9kRrVV1H75TW8UkHiY4jkITumZvoO8VjBmGlHn3HuAunYFskE0YqPk+ziVhKdk5J1ff+NtiLN63KDF6pSaHhMdOHyQiGWWsLk6n50STJb+MWJjY4h3jaGjqFi060X5M0k5Wz28cHqQL7CfucsN3b3wD+yyhiHU9ZUYI+ed4vweX2gIxFGiN9b0OR3/qfcGXgT4/bfY3s0wd1fk/r4iRg0m7qcjgoAfb3AZvehHKwrx3RmvyuALk1nwd4CQprM5jpUC8tf4Dt840XnC4GzkeTwXaKEs8dVUsgIQCxNyv4qTeJtQELVDywdkJpkO3+qAl7xw9SMVe5gjezLSEI0gUerrEPqVd7N1JkIjivMP1uZPKSUniwcRvSPYGfCauEa/nXlJelcDN4FAicveZXf/88fSJyFiZZkUA583jPcuWXxhGa+2yN78+UmFaugpbaZLMqgxhzqBgcbHv6uZ9tyHRmHm2L1N6cF+QwU+62ewHYFmyZF/2w23wojV8K9zS7aPpiM8bDPMYFbvxaXre+zgxgoDnGjuVPr2O2h66DBZ2Lb19CasUBJHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199018)(5930299012)(966005)(55016003)(83380400001)(86362001)(2906002)(44832011)(45080400002)(478600001)(33656002)(7696005)(71200400001)(6506007)(186003)(26005)(9686003)(122000001)(38070700005)(75432002)(38100700002)(66446008)(7116003)(8936002)(41300700001)(4326008)(5660300002)(52536014)(41320700001)(8676002)(786003)(66476007)(66556008)(64756008)(66946007)(76116006)(316002)(54906003)(110136005)(58493002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jI1W7tVPSe7a7IMH8mBL2joFijVfsiMhzzFI1HymXXrD/EjImR7DRbtyWa?=
 =?iso-8859-1?Q?FhORk0tMj9wWt+y7MtQaLxrqjYB7uDbDzCdNucT26gkV1FVOthISbhKhBd?=
 =?iso-8859-1?Q?M/EX4mNXkkc9zLwyUxdYd8ch3LOOVvnLDlk7xE2esP88LGvqeg6Hvzur4X?=
 =?iso-8859-1?Q?ozJ6QBW6GNiBm8V+I9v+oY3owSSxDbIsFwpj5rIwhYnj64AxujubbrYjWf?=
 =?iso-8859-1?Q?uGePx/DxOQtUQCvC5VCARQsRZzY19szvnt8bFMEsIyx94X8rZVtBwLX3UP?=
 =?iso-8859-1?Q?MCqow8Rjj6PWVnVdw11cTQnweFIKQqa2NwqnMRG30wXSkcaHwLGZlx4+rP?=
 =?iso-8859-1?Q?BGW3xNEOl5G4HOGrzaNHl7wpiVKvBKb72fK1nF3GEPiNsA+VcQ6U6AVH3O?=
 =?iso-8859-1?Q?HjB6Yhk5ryrKsJPLt52zfOOdgq9iULta4f0LbaT+orugNZ+t1wUC/6umxl?=
 =?iso-8859-1?Q?/qLBu0keW9PEaLJO36CHZRYkrvom3sMwtqG//DVx1raU1D8hsJkdHWnkpV?=
 =?iso-8859-1?Q?i9qT34q/PXf+3xZm/to5KstuT4eR3USN6FwE/YQ60gQxnyf5W9ndg5NmJN?=
 =?iso-8859-1?Q?9duZzQGJoMtxk+HqDvJaffkGkdb2DSox23YL0Ro0AKpZ2sz+F6kK/5MblC?=
 =?iso-8859-1?Q?NsljZJoERbjsZTEc/7yVNr4t2s8CW63V97Bx102nLN3DLfKT72kHt69EWQ?=
 =?iso-8859-1?Q?hqLKJTLAYhW9NYc5Z73czG6ogpdhhljECQ/znlk3Pa/kFBRSuQloFZQzwV?=
 =?iso-8859-1?Q?bWvIbWRTnxDHi/V8N82rRHosr2bPmpvrWqNAakhH+w8exvVK8gLHtf1rv7?=
 =?iso-8859-1?Q?0eCS3UQ8RnbSdf0BG3zX/bfeu73HUFbQJR+RY3fk5riC6KM686Hqg1qtOA?=
 =?iso-8859-1?Q?wsRiVBpzB+CmvzA70RHV67wyUILj6vjdH/PrhSrlO4mE9Av1jfopivLNx0?=
 =?iso-8859-1?Q?TWBHZDBY/GIVQGZEwRaxKVmHcMQ6OLzDkMCsVolT5JJrXuT8q69btyXGjZ?=
 =?iso-8859-1?Q?FrdipqnjSaipiAppwc2WVm8sn/tgpznt+Dyoit/gY+jXnDjsS/GHoWeDOU?=
 =?iso-8859-1?Q?jsN5YzcjXTgR7OFukUHmHXX4DKE7nv1hBcAhdjKsV/zuVFmdP1iaVrfJ3j?=
 =?iso-8859-1?Q?Ouu9Gr0Ci7yBG9GM3PLOEYNC+gTF87jDAn0OYd4CmYqarfHnvoYmQTxU+d?=
 =?iso-8859-1?Q?vVpfQRkc5ZQCCCuS9bFa+IhnRnubdflXehkUIpzi6nWC1rQo3ifdp23fMQ?=
 =?iso-8859-1?Q?h7jC4u1uOJEh7OESFsyBboslLhTL0CijBK9Y0Z0vU0QN9RqceKTm7Rhhzz?=
 =?iso-8859-1?Q?dwDxuGIXSBIyI1KTVZlrLoxLSYMB31irPNm/JykWMS7jK9vtCXKr3PBfxX?=
 =?iso-8859-1?Q?oTCJrTy7leGi78/6hFS7tOwvPfk1lgZWvoFjlf4k4kBJd/NttgEATcu+I/?=
 =?iso-8859-1?Q?qRxzhUWCJZ9o0Ck8dHFEqomEmSAciVfKAEWo0U76A6YcCPQth+Re3U56xO?=
 =?iso-8859-1?Q?Fuz8cWzQBX3QnulPGZD40mFeZ6O9Mqb8qE15w8dXyKX5cCOdbAJvgTGV9l?=
 =?iso-8859-1?Q?M8R05+ZO95WW3iSKZCGmfJ2dABk0M9VFNZYYR+mOJeBKnGy3K0ykzYBV+8?=
 =?iso-8859-1?Q?3ntlgNyCj1bgHfTg/NPtPA3yskscX6VHfMXL4zcMN6XNSeL6oFowyBWg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cae1af1-fff3-4293-28eb-08db106704e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 21:44:45.2678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjI/ITdvefxjq31kY4Edy1om35K4ZvGbMvG3amJeb959ZsTIZ0mTEIdjLtK9Vp/+Td8RDK53p55DVN+WJC5klO6QnvSZCN/THcm6yaLu+Eg=
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
Kernel Branch: 6.2.0-rc6-next-20230203=0A=
Kernel config:=A0https://drive.google.com/file/d/1jWHyzy2KABqlRawd3FO2V2ZVN=
oMWpkZu/view?usp=3Dshare_link=0A=
C Reproducer:=A0https://drive.google.com/file/d/1zH4AtT1D3O-vqihwMy-kxrFW6R=
ni6bZ_/view?usp=3Dshare_link=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 6 PID: 10426 at fs/udf/truncate.c:208 udf_truncate_extents+0x=
8a9/0x9d0=0A=
Modules linked in:=0A=
CPU: 6 PID: 10426 Comm: syz-executor.3 Not tainted 6.2.0-rc6-next-20230203 =
#1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:udf_truncate_extents+0x8a9/0x9d0=0A=
Code: 84 d2 74 05 e8 e8 1e f9 fe 8b 44 24 20 be 07 00 00 00 48 89 df 89 83 =
cc fe ff ff e8 61 0b 13 ff e9 a5 fd ff ff e8 b7 23 aa fe <0f> 0b e9 1f fe f=
f ff e8 ab 23 aa fe 0f 0b 48 8b 7c 24 08 48 89 74=0A=
RSP: 0000:ffffc9000c6f7050 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: ffff888045252160 RCX: 0000000000000000=0A=
RDX: ffff888114e53900 RSI: ffffffff82d5b399 RDI: 0000000000000007=0A=
RBP: ffffc9000c6f7140 R08: 0000000000000007 R09: 0000000000000000=0A=
R10: 0000000000000350 R11: 0000000000000001 R12: ffff8880530de000=0A=
R13: 0000000000000350 R14: 00000000000000ff R15: ffffc9000c6f7100=0A=
FS:  00007f601837e700(0000) GS:ffff888119f00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 000000001ffffe40 CR3: 000000004c1b1000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 udf_write_failed.isra.0+0x173/0x1c0=0A=
 udf_write_begin+0x2c5/0x370=0A=
 generic_perform_write+0x259/0x580=0A=
 __generic_file_write_iter+0x2ae/0x500=0A=
 udf_file_write_iter+0x233/0x740=0A=
 __kernel_write_iter+0x262/0x7a0=0A=
 __kernel_write+0xc9/0x110=0A=
 dump_emit+0x21d/0x340=0A=
 elf_core_dump+0x215c/0x3720=0A=
 do_coredump+0x2d30/0x3ce0=0A=
 get_signal+0x1c11/0x25c0=0A=
 arch_do_signal_or_restart+0x79/0x5a0=0A=
 exit_to_user_mode_prepare+0x11f/0x240=0A=
 irqentry_exit_to_user_mode+0x9/0x30=0A=
 asm_exc_general_protection+0x26/0x30=0A=
RIP: 0033:0x7f601728edd5=0A=
Code: 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 =
c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 b8 f=
f ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 84=0A=
RSP: 002b:0000000020000040 EFLAGS: 00010217=0A=
RAX: 0000000000000000 RBX: 00007f60173bc120 RCX: 00007f601728edcd=0A=
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000000=0A=
RBP: 00007f60172fc59c R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 00007ffc959cbaaf R14: 00007ffc959cbc50 R15: 00007f601837dd80=0A=
 </TASK>=0A=
irq event stamp: 1369=0A=
hardirqs last  enabled at (1379): [<ffffffff81643788>] __up_console_sem+0x7=
8/0x80=0A=
hardirqs last disabled at (1388): [<ffffffff8164376d>] __up_console_sem+0x5=
d/0x80=0A=
softirqs last  enabled at (490): [<ffffffff814b2d7d>] __irq_exit_rcu+0x11d/=
0x190=0A=
softirqs last disabled at (351): [<ffffffff814b2d7d>] __irq_exit_rcu+0x11d/=
0x190=0A=
---[ end trace 0000000000000000 ]---=0A=
