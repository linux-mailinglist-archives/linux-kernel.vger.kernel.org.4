Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA21636915
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiKWSiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238103AbiKWSiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:38:05 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4382ED48
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:38:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlK16VniaSW63RqHAh3+yE+0ZcByz/l9Vi6Tjou6bozdAHM6Hj4GIHVnDlrfTLqPeti8aeFHtMsKfiTtKmsF6KgaxNvjcjeKT0ohs2XkyHfkDfLXDuQUM3J59ZBDymuB4ippKScctaf1uXjBxC3FsLATzLYIkgqmLJKNlyFw80biKjt5Oqkx7x8Ehlmj1VdTWuOZBNta+8ekq+23DNQ9db0hS/sn+jPDQ19Knr72ThzFouPmb1B9y/jWtuLDUnPRS6GoMRB2gZzURycNCXIvB1klbk6BkTC3wXqPoPQ3DM6AwEtjpxE84o2N5h5yVjt+eHDoDDvPrXT2Or96ua+Whw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlWJYTJEYJn/I99ANRoYm6U9M2ZwwFZHdlHhOhZB4dU=;
 b=UQoaUGqKZcYD9g46NUuNXqip1pF7c34ZwIHD2dh/7dhtQYB38e6LoAnj8hGLL1s5uvTpoWbFnaJhOAoBPQRmXccm5Pfyee6PqEnYgxL689yYOyPuzttnsURfwFxFZb646dH77OZy0gMfmgIqDThdmavKoeyLIObXW8dWDG3zDzrC/jley/JeW8ZigLINdcWMilqyG48eKbHzkUMEe588+nbIbPycWK5rkZNoI7G+zybS3iXkE0hjdLCyEqrTvs1KmM31vW46usJCwo8P+hLLIKs3u7FUaKk9ALlaFpHhCy+gOm6H84A8dgQ4+ZnevsY74oxwA5MxdtAf2ji7hfIr7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlWJYTJEYJn/I99ANRoYm6U9M2ZwwFZHdlHhOhZB4dU=;
 b=hZFiL51rAgCCGH/jLOn+wz5v0a9eO+dW3SR5PL94c3X9diKlauz+K+MnljD1VFbuF1eLxrd4+ovJqhiL8kE6YJZAowtfvU1yl/QSWOVAzcr0RE+KhxYrw4pmrt4S7AUVYxutpvhM0XxMWZFcgoTJl3uWaHULGNXHJbLuKIcBROo=
Received: from BN6PR07MB3185.namprd07.prod.outlook.com (2603:10b6:404:a6::15)
 by CH2PR07MB6455.namprd07.prod.outlook.com (2603:10b6:610:27::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Wed, 23 Nov
 2022 18:38:01 +0000
Received: from BN6PR07MB3185.namprd07.prod.outlook.com
 ([fe80::9446:f08f:16f7:ec49]) by BN6PR07MB3185.namprd07.prod.outlook.com
 ([fe80::9446:f08f:16f7:ec49%2]) with mapi id 15.20.5834.009; Wed, 23 Nov 2022
 18:38:01 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Paul Gazzillo <Paul.Gazzillo@ucf.edu>
Subject: Syzkaller found a bug: KASAN: use-after-free Read in do_update_region
Thread-Topic: Syzkaller found a bug: KASAN: use-after-free Read in
 do_update_region
Thread-Index: AQHY/2ofkEfVHoisHkyMYt2lVPsOIw==
Date:   Wed, 23 Nov 2022 18:38:01 +0000
Message-ID: <BN6PR07MB3185D3400510E9D395288D71AB0C9@BN6PR07MB3185.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR07MB3185:EE_|CH2PR07MB6455:EE_
x-ms-office365-filtering-correlation-id: 02a408f4-cace-4aa2-16d4-08dacd81d9c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rKZ1RmuU+TbH+iWsGPnbVVM9TyRJ4EQE33Sm5Y64mBE57i8meqeui9i44ax1uet+PXjjRujrZEKvgkZZtwYcpF3ylPgrYZ9WUakBwTOMd37mo/N67MK4vEQwKW32TK+QL21WLJCXK2ZUPO2Pxcs+c388dJwOy2jGxfkIkNAWPqBRHG4iumaPfIUwLW34NNFmRneq5o2rsWYMl4SvSMcEx3pxI7sDRQ9h7FE/EqeCHcBq4eKdizgKL6r3jGaffGr/stynZ+97+LmUOs23GUmaoqOjxktcNa53tY0bmv5YvYtmd/3LQ7j2jC9mUBYRVA9ipAbhVoXYjgTl6rhMvc3xoLTQ+2VDu68Y8GIoyWXGCqSCTDGjxoaCVAnELWaYLAooA7zjz/iKvQM5pgR0GCEO5yjEecktzecba+wp0DtwNB1CeQVw3ZjXiVVyJmv+xzQuPxpterhMQ/wrrgpXNS7kTZqqk9S1oJrHypP3YLM/tMcvyUSV5veXMwj0WA5H2HywKNs/JL+tzt2S0czONIzuef0B+c+/mc7uRI38NDPNoHUGg69cdawvRCDhwcBlX22g6ZxOepg3juDaZ6NUlyEUGfKnyezDmCJFmweodnDajIa8Fe9uPGTEYRkdiEjYDLCezI5IKeU05wHTiVgDVmzrEusbrEOCZsbjZvyzgHTQtbC0SLLgdoKH6OZ9p3Rv4rOFocxNyUKqeAEVdNL1w+prD6D9gvBurBlW+bHOvdwN/WmYayjSORWc96JmGSrVjoptqKaRBc1Al6aOIh5/s+XXMalgidSLbqjR81ucdrcVQtw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR07MB3185.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199015)(33656002)(86362001)(55016003)(41320700001)(75432002)(44832011)(5660300002)(2906002)(9686003)(83380400001)(38070700005)(38100700002)(122000001)(186003)(5930299009)(478600001)(8936002)(966005)(71200400001)(76116006)(41300700001)(54906003)(316002)(786003)(52536014)(7696005)(64756008)(4326008)(6506007)(66446008)(66946007)(66476007)(66556008)(110136005)(8676002)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CCek76vGbWwf8MFmw5onefcjvIibaOvG8y6vmmARyZNY1zZa9qEZ1cH9ph?=
 =?iso-8859-1?Q?YjxNMXy6mwcow/Nqn5FhN7LUTP5F1GQoQuVTBR8bcunwplNkQEaPgoWAtT?=
 =?iso-8859-1?Q?aRFoLlxHeMJJEYYf/IvAAOBG8ZmKmYT62MWpBIb3qqVW+7nT8yMw4dDosy?=
 =?iso-8859-1?Q?fWVa+RseoUMkap2orkTjViepZNEOjgfo6/r1PE4s/0aQJ17w2NDuJmx50+?=
 =?iso-8859-1?Q?Uk0biUDwK7XotbDvdRPQERlmEdqauOo2UpSY5A4DPEw6NzwthmuAEPuCW1?=
 =?iso-8859-1?Q?JNaVckrMbx92sqkY3IAj2EWhj+BSG2jD3AiqiYUKgfsBg0CC8jGDF+E3yj?=
 =?iso-8859-1?Q?8ZMWbkLU5xZw4BnOpVK+EEeuJ0GFkZHBn9iZgs0FBfX/xIGOt6c/HzluyK?=
 =?iso-8859-1?Q?T5QcJSPtZy7URNvPbiue1/UgtzIUXK8pB54e0EI2bk8YRJtcleIdyKAah9?=
 =?iso-8859-1?Q?e0afYS8to7+l++GoMgJwt/FeEL15ICnxs69uLYvNa/YaQ0dFAIKT924OGX?=
 =?iso-8859-1?Q?A7l5BoLBG0WPGpKByJGVeGskecTr2y7uHm07DsxwjFpmhVbQ5PGuCw+PTV?=
 =?iso-8859-1?Q?qhkFKHokZOnOCtCV5Q761EABMrJZEZvxIYiC9Kp+amHLARNBV8iHLi7BmX?=
 =?iso-8859-1?Q?o1qkRjImBsImZOn6StueSMv2uBkLFZyDPFm385XsxVL+lwUGoqfM2InHdJ?=
 =?iso-8859-1?Q?FAGfE3KXoRo64gkBjI7g51LPX2kJj/9nuPCmJ2rtU+LdyopENnEwoZsqCy?=
 =?iso-8859-1?Q?xK1B5rbrTBn0cmeA1m1ATDIANoWY/YqdwsrCxI35LcWx9ogqwekGCGnXx7?=
 =?iso-8859-1?Q?h9KMVFEoljdXjXD6KIpPMuyYYyf/W4tgvng1wZV3bRECyAZe+1tkTl+dto?=
 =?iso-8859-1?Q?gk4fYBqU+26pNFzJAwSMa/0D5tKTfzPwFWPkpQnQTYmdEJcD0rlKlktJYy?=
 =?iso-8859-1?Q?M3M9LjYlDZxjKmHK8fkqtD03SFM1XhA6Aw1d6SlduEfM2OQa/EylfpNwnL?=
 =?iso-8859-1?Q?Wwfn7JBt402chB6D4h/z3tPPNmuhpZgX3wJDxy0wbD7ZPrtqaKlFfX0laJ?=
 =?iso-8859-1?Q?9wXGnnWCbcccm7UXNcj7WVnpVnXeFhoHLVyuiI8inoyJ2TepiH3g1jOqtR?=
 =?iso-8859-1?Q?+wvPHQbe6FMfQg+wvxnEtGnfNcMMFCDPYxrgnyxiqPmX2ilUpss5yt2APy?=
 =?iso-8859-1?Q?4L+mODdZfo+YKMfoP2p5TkTeuU0NC2/3nyGhihaEWr/Hc6hOmEBn5aRhLz?=
 =?iso-8859-1?Q?u49QqP7XzxlnAiZ6PWx7As7vWkjrCKPzS4Dcug5F6WFHt+cB5J+/jhUj0/?=
 =?iso-8859-1?Q?YWnhmiQJCFlIkui4aWJRF9HaJOSAa2fDSqA1m5ZrAoJ8+MeNDpTa/ApoUM?=
 =?iso-8859-1?Q?0JiGw4Pim0HsoCKp7CQt+ZJ+sqRu9CONOYXUWpFANELt4+oLMVMyA5kVB4?=
 =?iso-8859-1?Q?uv96I61LG/Fw2317Y6SEFI2q3I9ZAC2ohfohfHISatX3s2M4yWUs+wqDPw?=
 =?iso-8859-1?Q?IYWjDTcDp9LcapmJU2eUj/T8pwvhyzOPwCFd3faHsTJ37ljFmnhE2aNVbV?=
 =?iso-8859-1?Q?Huqdi8gBXu3YssdO2VZj0gQnJxoAkknqpx12YmolYOZV+ZW7XwLtNt28lS?=
 =?iso-8859-1?Q?l6ecBOh4bG4qr/4EhagsYTYNP5ron8TixVDt/+vUT2HiAwQBukDcMDA2oD?=
 =?iso-8859-1?Q?JCiw+E0lC2MyRFuf43JXN8S+1kGzBQXNUGSX7VF3rpLkDXVWmJY/2y4Zcx?=
 =?iso-8859-1?Q?yMLg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR07MB3185.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a408f4-cace-4aa2-16d4-08dacd81d9c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 18:38:01.4212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vn+nObsTxaP7v5J/aLBptmWgNl8oyDP7jXtfNcGKc2I4zgLRxMqkPUU9VgtLRQ4+QCXQIZKuE2HGG1CdD5nZwI8S6W2zYRlYtAfOvGTVBIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6455
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
Kernel branch: linux-next 5.11.0-rc1+ (HEAD detached at 6a4b1f2dff55)=0A=
=0A=
configuration file: https://drive.google.com/file/d/18W-8umgZVSm-KwvIzcBQpx=
Rn74Q1S_Fa/view?usp=3Dsharing=0A=
=0A=
Unfortunately, we have no reproducer for this bug yet.=0A=
=0A=
Thank you!=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
BUG: KASAN: use-after-free in do_update_region+0x571/0x5f0 drivers/tty/vt/v=
t.c:664=0A=
Read of size 2 at addr ffff888000100000 by task (agetty)/17350=0A=
=0A=
CPU: 6 PID: 17350 Comm: (agetty) Not tainted 5.11.0-rc1+ #3=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1=
.1 04/01/2014=0A=
Call Trace:=0A=
=A0__dump_stack lib/dump_stack.c:79 [inline]=0A=
=A0dump_stack+0x9c/0xcf lib/dump_stack.c:120=0A=
=A0print_address_description.constprop.0+0x1a/0x140 mm/kasan/report.c:230=
=0A=
=A0__kasan_report mm/kasan/report.c:396 [inline]=0A=
=A0kasan_report.cold+0x7f/0x10e mm/kasan/report.c:413=0A=
=A0do_update_region+0x571/0x5f0 drivers/tty/vt/vt.c:664=0A=
=A0csi_J+0x294/0xa10 drivers/tty/vt/vt.c:1568=0A=
=A0do_con_trol+0x1c23/0x53e0 drivers/tty/vt/vt.c:2420=0A=
=A0do_con_write+0xd92/0x1a40 drivers/tty/vt/vt.c:2911=0A=
=A0con_write+0x21/0x40 drivers/tty/vt/vt.c:3255=0A=
=A0process_output_block drivers/tty/n_tty.c:596 [inline]=0A=
=A0n_tty_write+0x3d6/0xe20 drivers/tty/n_tty.c:2335=0A=
=A0do_tty_write drivers/tty/tty_io.c:961 [inline]=0A=
=A0tty_write+0x438/0x790 drivers/tty/tty_io.c:1045=0A=
=A0vfs_write+0x1bf/0x760 fs/read_write.c:603=0A=
=A0ksys_write+0x100/0x210 fs/read_write.c:658=0A=
=A0do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46=0A=
=A0entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
RIP: 0033:0x7fe7d10101b0=0A=
Code: 2e 0f 1f 84 00 00 00 00 00 90 48 8b 05 19 7e 20 00 c3 0f 1f 84 00 00 =
00 00 00 83 3d 19 c2 20 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 31 c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24=0A=
RSP: 002b:00007ffd1dee4fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00007fe7d10101b0=0A=
RDX: 000000000000000a RSI: 00007fe7d247bcbe RDI: 0000000000000003=0A=
RBP: 00007fe7d247bcbe R08: 00007ffd1dee4fa0 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003=0A=
R13: 0000000000000000 R14: ffffffffffffffff R15: 00007ffd1dee52a0=0A=
=0A=
The buggy address belongs to the page:=0A=
page:000000005dd3986c refcount:0 mapcount:-128 mapping:0000000000000000 ind=
ex:0x0 pfn:0x100=0A=
flags: 0x0()=0A=
raw: 0000000000000000 ffff8881401fa300 ffff8881401fa300 0000000000000000=0A=
raw: 0000000000000000 0000000000000008 00000000ffffff7f 0000000000000000=0A=
page dumped because: kasan: bad access detected=0A=
=0A=
Memory state around the buggy address:=0A=
=A0ffff8880000fff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
=A0ffff8880000fff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
>ffff888000100000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^=0A=
=A0ffff888000100080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=0A=
=A0ffff888000100100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
=0A=
Best regards,=0A=
Sanan Hasanov.=
