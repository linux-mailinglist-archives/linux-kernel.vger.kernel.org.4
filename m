Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB5A6800A1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjA2SHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2SHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:07:39 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11012010.outbound.protection.outlook.com [40.93.200.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129A18B00;
        Sun, 29 Jan 2023 10:07:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvHV/4zmwTA5ZdXlJU0fVyUOGecPleiMKIEbyHABoR0l7G2lxqjBBKBidJnVIHmAfigqYJm1fiGxoXm8MTdYId3vjNpHmDbXZ3mzV8zNNqZP/tyPu88A61UF5RKaF3yNAbcZ6YM71w+REDIm678EploqVugqXEwELXbM/zZly6gLDsxcw6TqvBp+DDIMOLTth+1yQ3HT5xd2KNBs09dXELCztR/NaGI7SE1WILiwUHKrAHcaF8PfchpC30hzRDy2NFOxU7H3zf7dKUZ6xdFaL8Ot2jlVKjOTYSFC7rs47oVOxgCBWPMksz1qd9u0XlGZms5+vx93tkX7yAaYr53ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1ba/Ryhk0hXuBjoF+45560Fb+Uod/xo3SlPzUfWB0k=;
 b=PkbVySsHl7CG3ydpBs45UEXbWT5Yvi/s6ecVnMk0gzkmZefEFTm4yoBfDeYYdYE3fTBIXw1dPgawNeLu8M3s25yjpxV/YDA/edCLmIEkhCoTbql/0fUIySlfIoyh4o/gcD1aeRqBokajCBjX4wa7f9kxZpiT5ZcEEXXCceyA3YHADceECaMGTu4j4V3vZT8bXUvKePYHVQxnadIoMamLDkQ6CJkg7PXl3ZKxZjKeDbsmHT42bAaFb+RLk/TlqIMFh4iC5Kv2Rn5qfzBUiZdQNZHEAB5Cu0zVcLU8EXMSTJOP2JTMi3aDb3xFbSlnf7UgPyx/8fA6g04K+rPQYB+JhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1ba/Ryhk0hXuBjoF+45560Fb+Uod/xo3SlPzUfWB0k=;
 b=SUvuYIogio+HqL1zu9wQZ08lKwGd0f8W+3w0WY42mjSXOMfrc6b9/9f/3uKZrPevBVkAoT/AEy8G84rUaemGKe7wEDB23AVqhUsRhhaHv7frJGNTXj3RZDY2kwnZaKxSFVBU4hI4rDp8qZVGo4OBa0y2Y0sXV7aolKFRray0KD4=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by CY4PR0501MB3699.namprd05.prod.outlook.com (2603:10b6:910:90::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Sun, 29 Jan
 2023 18:07:31 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0%3]) with mapi id 15.20.6043.022; Sun, 29 Jan 2023
 18:07:29 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "chinglinyu@google.com" <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH 0/8] tracing: introducing eventfs
Thread-Topic: [PATCH 0/8] tracing: introducing eventfs
Thread-Index: AQHZLoQH5dE+ZQnOVUm4TxmRzoe30q6sOL8AgAmDUQA=
Date:   Sun, 29 Jan 2023 18:07:29 +0000
Message-ID: <223F3594-6BFF-48AF-B0BB-6BF050C8207E@vmware.com>
References: <1674407228-49109-1-git-send-email-akaher@vmware.com>
 <1674407228-49109-9-git-send-email-akaher@vmware.com>
 <20230123115108.7dab91f3@gandalf.local.home>
In-Reply-To: <20230123115108.7dab91f3@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|CY4PR0501MB3699:EE_
x-ms-office365-filtering-correlation-id: 07c911e3-292e-4abb-9fc9-08db0223af6b
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8gV1gRBAGQcJ8iriV+xQrj3P4mGkh/SzOxelhVYAVSNOd3CZDDIBBJnunO7FY8M8BOF5/RMQV1Yt7HQgKbUvVNKqdf1j6uB9XFQhYMkOf8yutb0wvIgOQGvRX1loQ7GqgAVOcaJu58HXTJWHJu4pLMOg9mSpGBmkYOkjp1EBuzySyJ4k/484bHPNVaTx2xHsiCSR+Qc5j7zmXTjFvtWiZQZAOov8L96Mq8/ChoG1+VBjfWVBcptdkvwwAWfdIjBKGM2ESDRIdz9rqpwSjMb+PncXZ0O+CLYEW3R4lugpIf3s8EMb40Oer3V39z7RF2TfbVrZ0ociKofoYS9CPItS3bknriCj4Q7AUkbAVwrEMlsz/eVWPJLE9lr534hD/pcHsTbz50pAUHM6lTkTMj47ik653kzGBzJ4gbFzOwvzhN8RGEtX9VAAQ4Rglu4o8Lh4d123oc0bgSuP6StR37wNRFVcG9Fe/tU2cTzj3gp7Eykq7YbWOE3lXuWDcKvWVcon4eR205Y7Z6rq718sfV5gbofFeWEQHSChQ4UfkdMALss8ECAXPRbZAEl+4GAwdRZXRbuNFk30WJNSjBXGx+FFA0GnXtfPnxWUdrciIc23P8F+J9lkwHg9Ac57fhEogF1JZshxH3UrxYKuijIbExwYMDxKkNs/+Ai4bsExDsEYBSTy9eWu3rMd3XGN8IE0EURYU/+WlRdVdtaG2eXd7RZYBy6YWI0OGSGyGKtqeTy165QYJ4TwdDyTR8364PqGi3w2p4DdCWlPUwoqX6VNFP6y1wXz6b5c97LfOnfQjS55ss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(6506007)(53546011)(478600001)(26005)(6512007)(186003)(6486002)(66446008)(76116006)(4326008)(6916009)(64756008)(66476007)(2616005)(66556008)(91956017)(66946007)(83380400001)(41300700001)(8936002)(8676002)(71200400001)(45080400002)(86362001)(122000001)(38100700002)(36756003)(2906002)(33656002)(5660300002)(316002)(54906003)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O1vvtvXh7Du2Ei9nUGeujacQ7QXEJqmHZyq/5wxdNXRonr47q+reEQaumh9J?=
 =?us-ascii?Q?da8FH5JcoAjh00jUevbwwmWu6V11+jE18sXBBqOb1xPWOlaH4Jh7Cj8JxhX9?=
 =?us-ascii?Q?dwZfmQwmu85JM03CXkwHBuO/sgv//AILbuYJkigwjmyfDkGzYopx5oYqhUGI?=
 =?us-ascii?Q?ej6pOvyoa+S2Wh8sIIpv8cP4m/ff9e779Oo6J8RQdiSIz87R70sQqSkxUKGu?=
 =?us-ascii?Q?qmtt6mtbvpUuumvntBXBy2jQDzmtH3F5LXRNQeIk57xErVPK2jzOYOQF5nlH?=
 =?us-ascii?Q?YBjouAwWOpPqzT/z4O0DB3LXSI99QWKhK7IIKtEfh9nktLrIiBVJ/LbP/jgA?=
 =?us-ascii?Q?eLTTScRQmeGh2zbqjZexzJI3J9VIdTL3KTSuCYYxtF+Hc1GV/V8PgbzDdiLY?=
 =?us-ascii?Q?m9btWystzqlWK2DWqGiP7wi23BqdvNwybtopGUPWOO6Rp9FyGv8NJabFu5DC?=
 =?us-ascii?Q?iXJtYol1FY0yBP1l8RFQppIwJGl1qUY6SwfP0zAcyyae99Erl3IVY+gIQFBa?=
 =?us-ascii?Q?nx06VnCsTZh1jTdBpQ0Yi/pm0YEnCONJ9PzVV1AbcDExS+7OYn+yfkuRPdeV?=
 =?us-ascii?Q?AD4CTOK5TehAScguNFuAw7oBoLYCM7kYAZps81foalUjWqZ17AYi2a6RB2mJ?=
 =?us-ascii?Q?005PksuYpoVXYCcJ0AmLJ1SS2tQmdODgKVKQ3gVsDLTZl3wdD96cmlf8WUYk?=
 =?us-ascii?Q?eUyXGsOOD9LHt27+i7mjiWKkgya2NOPpKleJlpsolP55NqB657pOncJdrwhW?=
 =?us-ascii?Q?xfBdrYCSXrQQRE/9ZYMsruD0q6X2SmViSaCF26TN+rDcU1PZkSJ4Vkz4YVuW?=
 =?us-ascii?Q?yHSImIvADOgIKdbPyc/tgXTta9/Y4GSQBt3PTNYMaqpoOQf5/nd9sfoTXd7L?=
 =?us-ascii?Q?hEqygrkUtNssnVsAZXKx6sMKWGviOoiDYfuAV7jznK5q23As6gg2sTNh/1+6?=
 =?us-ascii?Q?c0LUR27p8ic1RS5AnZu/+TVpXuhRS68I3kIvYnW+d7TMoVbzGBpi7xo9oKo5?=
 =?us-ascii?Q?TKJ1N6Nsw0LzpSckY9FUWX70LDlwSO3C0gUN73rEsOFPPmy/q66w9d0JqFCX?=
 =?us-ascii?Q?QuuuQA2bqTCLdYe+i3L3oiqbEYrYGbirxdQC+15Lkf+2pnSi/GZbAdnONM2Y?=
 =?us-ascii?Q?NYQWtzI7cJ/JeY2uNg/saQAmIwfutNdVxb4Bb6ZGwtoYIlsBOVYJcMm6pjLN?=
 =?us-ascii?Q?Y+XO//+dinB/3/jt2+e1DwyMgs21zh0cRmvYBVXiVKTk0yeFVLAhN4+K0/Wg?=
 =?us-ascii?Q?en67yBzrhw/CQH3JVqDqUCa5Nd+/c1wWCcHgVYalglzDUxCJV8+AhAatKQy0?=
 =?us-ascii?Q?ldzp7H8Al2xOsoe79EuWIpgNfAFTemn4Sd3MmbHJ21JctPsX67lOHaEsAz1i?=
 =?us-ascii?Q?q2MWku1i7/rr3/+ffC3DATr92igNZr2mjWPpp7T3bVsH+u+366YzqVNfsLsy?=
 =?us-ascii?Q?GXgGtRsMIIroGm1Gw3g4JJ7bn0+zIzyV4IMgslfYBnpW0QjUEuL4o/9ZL48D?=
 =?us-ascii?Q?2VVnwcwFE19VIs/BcCEckw33x+Gq4YbwqjgSZGu2i8Py1FWw2pPgEY1yAIzI?=
 =?us-ascii?Q?LXKcXXk7F7Fy87hE7MHrhqKBllWrVZIzOl/7aRUU?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34CE22D4DEAAF645A2A4F7CA908F7A67@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c911e3-292e-4abb-9fc9-08db0223af6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 18:07:29.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5c8Rdgb8+al/Kg2/cF8w5zuXZSzxutnBa6VjdVj7Dfmr5TYl4ZcOibG5HujOK3HPPQZCcWFYVpFN7nEyIFTtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0501MB3699
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 23-Jan-2023, at 10:21 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> !! External Email
>=20
> On Sun, 22 Jan 2023 22:37:08 +0530
> Ajay Kaher <akaher@vmware.com> wrote:
>=20
>> Events Tracing infrastructure contains lot of files, directories
>> (internally in terms of inodes, dentries). And ends up by consuming
>> memory in MBs. We can have multiple events of Events Tracing, which
>> further requires more memory.
>>=20
>> Instead of creating inodes/dentries, eventfs could keep meta-data and
>> skip the creation of inodes/dentries. As and when require, eventfs will
>> create the inodes/dentries only for required files/directories.
>> Also eventfs would delete the inodes/dentries once no more requires
>> but preserve the meta data.
>>=20
>> Tracing events took ~9MB, with this approach it took ~4.5MB
>> for ~10K files/dir.
>>=20
>> [PATCH 1/8]: Introducing struct tracefs_inode
>> [PATCH 2/8]: Adding eventfs-dir-add functions
>> [PATCH 3/8]: Adding eventfs-file-add function
>> [PATCH 4/8]: Adding eventfs-file-directory-remove function
>> [PATCH 5/8]: Adding functions to create-eventfs-files
>> [PATCH 6/8]: Adding eventfs lookup, read, open functions
>> [PATCH 7/8]: Creating tracefs_inode_cache
>> [PATCH 8/8]: Moving tracing events to eventfs
>=20
> Hi Ajay,
>=20
> Thanks a lot for sending these out.
>=20
> Note, something went wrong with your threading, as all the patches should
> be a reply to this one, but instead, they all (including this email) are =
a
> reply to patch 1 ??

Not sure why this is happenning, but I will try to fix in v2.

> Also, for v2, can you address all the kernel test robot issues as well as
> what Dan Carpenter wrote. There's also a couple of whitespace issues.
>=20

Sure, in v2.

> Finally, when I run the ftrace selftests that are in the kernel repositor=
y:
>=20
> # cd linux.git
> # cd tools/testing/selftests/ftrace
> # ./ftracetests

Thanks. I was looking some utility to test eventfs.

> It crashes with a NULL kernel dereference:
>=20
> [ 1021.844973] general protection fault, probably for non-canonical addre=
ss 0x626f7270747365a6: 0000 [#1] PREEMPT SMP PTI
> [ 1021.848900] CPU: 2 PID: 1160 Comm: ftracetest Not tainted 6.2.0-rc3-te=
st-00014-g1a351602422d #152
> [ 1021.852384] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.0-debian-1.16.0-5 04/01/2014
> [ 1021.855716] RIP: 0010:dcache_dir_open_wrapper+0x6b/0x1b0
> [ 1021.857700] Code: 75 28 e9 f7 00 00 00 48 8b 7b 10 48 85 ff 74 09 48 8=
3 c7 58 e8 36 ad 0c 00 48 8b 43 18 48 8d 58 e8 49 39 c4 0f 84 d4 00 00 00 <=
80> 7b 4a 00 75 d7 c6 43 4a 01 48 8b 45 30 48 8d b8 a0 00 00 00 e8
> [ 1021.864170] RSP: 0018:ffffa68b40f0fcb0 EFLAGS: 00010296
> [ 1021.866133] RAX: 626f727074736574 RBX: 626f72707473655c RCX: ffff9c6bc=
08cb000
> [ 1021.868797] RDX: ffffffff89058dc0 RSI: ffff9c6bc09f6f00 RDI: ffff9c6bc=
eef2810
> [ 1021.871389] RBP: ffff9c6bcee223c0 R08: ffffffff8a3b2da0 R09: ffff9c6bc=
eef2810
> [ 1021.873953] R10: 0000000000000007 R11: 0000000000000002 R12: ffff9c6bc=
3664980
> [ 1021.876669] R13: ffff9c6bc09f6f00 R14: ffff9c6bceef2810 R15: ffff9c6bc=
09f6f00
> [ 1021.880350] FS:  00007f58e39ba740(0000) GS:ffff9c6d37c80000(0000) knlG=
S:0000000000000000
> [ 1021.883289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1021.885401] CR2: 000055a0c1465000 CR3: 000000010f5a8003 CR4: 000000000=
0170ee0
> [ 1021.888117] Call Trace:
> [ 1021.889227]  <TASK>
> [ 1021.890216]  ? __pfx_dcache_dir_open_wrapper+0x10/0x10
> [ 1021.892088]  do_dentry_open+0x1e5/0x410
> [ 1021.893501]  path_openat+0xd7f/0x1220
> [ 1021.894863]  ? asm_exc_page_fault+0x22/0x30
> [ 1021.896325]  ? trace_hardirqs_on+0x2a/0xe0
> [ 1021.897715]  do_filp_open+0xaf/0x160
> [ 1021.898972]  do_sys_openat2+0xaf/0x170
> [ 1021.900211]  __x64_sys_openat+0x6a/0xa0
> [ 1021.901451]  do_syscall_64+0x3a/0x90
> [ 1021.902636]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 1021.904145] RIP: 0033:0x7f58e3ab9e41
> [ 1021.905255] Code: 44 24 18 31 c0 41 83 e2 40 75 3e 89 f0 25 00 00 41 0=
0 3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <=
48> 3d 00 f0 ff ff 77 3f 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
> [ 1021.910033] RSP: 002b:00007ffdfae49b40 EFLAGS: 00000287 ORIG_RAX: 0000=
000000000101
> [ 1021.913838] RAX: ffffffffffffffda RBX: 000055a0c145bfb1 RCX: 00007f58e=
3ab9e41
> [ 1021.915613] RDX: 0000000000090800 RSI: 000055a0c1463380 RDI: 00000000f=
fffff9c
> [ 1021.917358] RBP: 000055a0c146338f R08: 0000000000000001 R09: 000000000=
000000f
> [ 1021.919110] R10: 0000000000000000 R11: 0000000000000287 R12: 000055a0c=
1463380
> [ 1021.920864] R13: 000055a0c145bfb1 R14: 0000000000000000 R15: 000055a0c=
145bfb2
> [ 1021.922613]  </TASK>
> [ 1021.923331] Modules linked in: vmw_vsock_virtio_transport vmw_vsock_vi=
rtio_transport_common vsock ip_tables
> [ 1021.925741] Dumping ftrace buffer:
> [ 1021.926709]    (ftrace buffer empty)
> [ 1021.927754] ---[ end trace 0000000000000000 ]---
> [ 1021.928993] RIP: 0010:dcache_dir_open_wrapper+0x6b/0x1b0
>=20
> Could you see what happened there?

For some cases, eventfs keeps file/folder (in form of node/dentry) with-in =
VFS
even last dput has been called. This will be deleted while executing drop_c=
ache()
and eventfs_set_ef_status_free() will be called.

Above GPF happens when something deleted from eventfs link-list (removal of
dynamic events) but present with-in VFS (because of earlier access) and whe=
n
VFS will try to access and call dcache_dir_open_wrapper().

Solution: while deleting from eventfs link-list, needs to detect and delete=
 from VFS.

I will fix in v2. Thanks for reporting this bug.

-Ajay


