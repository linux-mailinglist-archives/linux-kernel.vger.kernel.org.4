Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212096A02F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjBWGth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:49:36 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48F0525F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:49:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMTEZKd0Kvc1pO0jlLVmaocO3O+M6aYu9u1kHnahBBBqcsAFWmh0sy3kQ4ScihM/d6hx25G0zbIG7lOm7CI5KR0OC0WQR9gEFdQZ0yN3dTzECHXtcJKAkBlP4quynW5MRjnwnpPTzBA66u2xryPkkY7yfO1aDmNw7QhYe0nzOBjPxG6insq09QeZcOMIgoYABF8cLYGu7F/7ArfGyeU5QE+GsOjqgYtsZBc7b+XiLFC9ztWevRxzuyku9UsHqV7fSpYclADXPfxd9zoyaRb61BrRYdccVSQTpTOcNeRzY3L07Z5NfByN3C70vfx6BfVuY7D/gdlHOs7jlYSXLiOe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8cZFdL3xUXJnZhyxDyDhcHjaMzaachLOVJQqL3Fa1Q=;
 b=oAS4BRF7fyFzKQD3NDbOksTY/2SHuOUSNepcobzI5bafdE1LGJMiD7zyJyP73ynckTggV6UecMhMR+M/Hcmi4S8CS62hGGhCvvkXN7BQRUABgzCZ65nWwm3oapwu7HWmEmPhZndoDDtswLTvXRl7XGcRqsNiulWdc7Rp6vmQ4G9RxuWh/TSgksyplYtOzbFnxP2Ds+F+m69TE3bT6JcL6cpPdfvh+EWY58eQGrkcQGiaEhSJf2UrIz56TMZ+CA33Cw8EJOVwkOzZGCmdgVcBB9YFNXbvKKXdnfYqsn8mvaNgDn9kMhI9z5AdFnY7jpWpm+g/UWOS3d7M6FmwCwOf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8cZFdL3xUXJnZhyxDyDhcHjaMzaachLOVJQqL3Fa1Q=;
 b=WBV3wgC0d5l9jeoaLZTxbzL6r1eccRABxxQEGWh5LyDs5M0EJcbP1mtJVLIo3H8QYjYDDS0pL7w1CgpWKXqB416MHBeR6ockBVLHPMvL97aVcVY5DUiZC3+rxFk+LCTYNoelWvnrTdnIQLeqeWxAQ1g869PDJdFsE8mWMd0Fc1o=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9569.eurprd04.prod.outlook.com (2603:10a6:102:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 06:49:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 06:49:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Fail to freeze process
Thread-Topic: Fail to freeze process
Thread-Index: AdlHUq0eJRhyCNK0Rb6CRNu6YQQwPQ==
Date:   Thu, 23 Feb 2023 06:49:31 +0000
Message-ID: <DU0PR04MB9417DDFE48AF703586561C0A88AB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB9569:EE_
x-ms-office365-filtering-correlation-id: e042ada3-7ea3-4b89-3b4e-08db156a1dcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Q0dmQ2Uc0BQmGzGHQf7vM+a+c/mQLApi9swFPFx3UZs3PdyNB6CnXkS5egO5vPA1bGhRa9FqZZP4C1aRV0xU8xtC2r69OZEWtir/ma1p21q2nmD9nNnLqKWqiOyigoBPOQHcKQHtIokJCBketH9P+rO5aySsaKr2qoUhuR5bpv87QymDE2x8PRHqIuL/16EZUIQaxy3ex2lI7t1AKTCCejb6HUaeUuXA4sPrVo2SupzUotXS4S8YG6cNXtTYisFfNoeLRx2HFNRdcamRTqnkiE3FnWMa0QE0eJbCxtRhiMgK0cTXvxBw+SCO0BOjrK9UMxKgptpM+FzMMAFD+qywOMOIz7amCUaZvQKmLwgLGVom3YrdcYWwxl4ZJ4mEsSk8RLDmuXj+jaNpc5j6/Jq2RWw5yXhIvVtfKgQb/7jeGaOYaPHFgHCVtEUhHfSAeJ3tpgRFwP0DhvRSCGIXszQlPhPyT37yS9eSUzgHkna5ea5stR3mAUQjpZ3DdNhYlmEMWwfxUglkZXlEFurFocyz6UwjK8fS4VrFY+5UU9SxHYPTHj20ZpSIl7gk9dPUbYUpSbwGHp6b6Ut7vWwbgKouY4VqbDFXV8EiuA0uFaTYiovyX1gMeLazaeHLATN3oG6J/pp1JFaY3kJyx3a9Rlr1/IF6NbXTCubYYkbBMD5b1KcuzHXEIrLytlWiZAFNPMpb6c1t1Q3mhKSfmJH4rvQXL/LG/Fj+R4LBUwuTVFwe8E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199018)(316002)(55016003)(38070700005)(9686003)(41300700001)(186003)(26005)(7416002)(44832011)(52536014)(8936002)(122000001)(5660300002)(76116006)(33656002)(54906003)(478600001)(110136005)(6506007)(66946007)(66556008)(66476007)(64756008)(7696005)(83380400001)(8676002)(66446008)(71200400001)(4326008)(38100700002)(86362001)(3480700007)(921005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R8Mn4/AEF/Qpr38XMnHTQL7NWL5CwEUlYTqhdyoz8RGhdWyVZSGMPaCrWF4/?=
 =?us-ascii?Q?Y8ofZowCLpQlTl1/sTl7vxmqgBqFRRpB1PV6rZwMpxDGAJysIahMOJjdgv1K?=
 =?us-ascii?Q?WT9cUV2UCQSGmxUZDb2e0RTkhTFRz08OZfn219ayMUtamr5Y4SP52zrYIbcx?=
 =?us-ascii?Q?RyqxGXmJpJaxM80Ik3OJkuClbQX9rRExnpijraqRQ3Orqb4FP30dQNeZfcK+?=
 =?us-ascii?Q?gE2d5xRE8ThtgvzL9HzMu8nKNMZiRm6MP3OU0WtZuQTWS9jpOJpdt034P3Nb?=
 =?us-ascii?Q?bmtg8k1BERACHoUnxxmIU4jSt/VCYjEfe8JBuHZ4XEFx1NiziPSZkyjJj1v3?=
 =?us-ascii?Q?ACW1436aJXr5lfsTdAF3jrCW8wrk/o9Ffx0TE19LbJxb7drY3ZqmINGFcgS3?=
 =?us-ascii?Q?A8SlwX7K+T9UGxZY87VMh1cnKGM7KuzRJsmb9Tlj7II4KEMtBhDxw3qKuhUl?=
 =?us-ascii?Q?2VtafP0mtO5HIMDzD4ul6xbgUU+ZleRjMnFmmobGke0Zc4Di0vS9EcGbFZnB?=
 =?us-ascii?Q?fS0KUSwja2Jh4w8OOK0SPt5WzpMbaAEDwNpsG2Ly1MNxSUOx2W4PI0Ou/ej2?=
 =?us-ascii?Q?onIrXLidIABrA+e4Y/PrZf3ALkxoRDzALrYTr1aM2T/h8k0yiyWJ8EBLrsJj?=
 =?us-ascii?Q?aAvzo+8UyenR/rrUcvR3dL/tQEp8z004VOoCLUvPWszEH7htOLg+TFpPsWQU?=
 =?us-ascii?Q?Rw0/jRLpc4dj+mI0HwTR6eXerx/3382jV4pHJPeae2o1rQvljWfi24QSPkWB?=
 =?us-ascii?Q?w0IiC3bSuwt4mQUd/H8TowDPWPkvZZNnyCrZhwgT90EPvBGAUOosXVL4DK3n?=
 =?us-ascii?Q?ao0TZ4yKtygVOi8Y1uBG5rTQ6y/cYlVAvrkJEhQTperOCRzlyA642s0o8tRZ?=
 =?us-ascii?Q?9B8jb08XKiUCm9u54BeK4DxWkZwlN6oSsc4dtN8gWdYzJhCluc4Ec4xsmrGN?=
 =?us-ascii?Q?kW7vzZkUeJjut38oQifIxLKxqh+S4ZwVgiBZq0O4b5+Gs3caSjyhPFYji+UI?=
 =?us-ascii?Q?N9hvrxMdjBOI7m0Jnvn6NXImNlXkYTk7tYNv/itduBImGFn7whaAKJE69EYU?=
 =?us-ascii?Q?JFzRGCVqw20r0n4gchovsWV++2rAOgF6+4X191Ujy+9tHHzsxIwo/+KHYLIz?=
 =?us-ascii?Q?2qLwGUdmnJITpxVFCItslyXj5iQ1KWvZht+kJltYDALaBkOP+be7vJfJzvCm?=
 =?us-ascii?Q?h/Qh39GO+dzIQ3TCRhmVX/9XQObNKMLR6XjC1qLRKvmMrPRTVIIVQJLFcZj8?=
 =?us-ascii?Q?6SgO8DVU+FVYimBtzAx7/r0Ba2sGX6fAcrNIWS9VD57QdZX8gTcP+TjNDyZd?=
 =?us-ascii?Q?zc3/mbRyaUJuNUIn3Y1PF9NqXCPLuvwF+bWkYJjEPi3h+JGOdSnaMYBfD7kf?=
 =?us-ascii?Q?SRKwdtK2c/IPxiKeQxQscJWUh/S+XOOO4t+TK4xCxSwEUYHP/F/8Q5/doaRl?=
 =?us-ascii?Q?bqxipkBWcAJmv2adtChwmfErgafigkLZh25k8k+0yZttRuWXe1wS1Ci8KRjS?=
 =?us-ascii?Q?zKfVU49P8zVHmwEatfhURqnjAPhpBc81/rfhdIHyrf+PA1nC6PpJiBGgr/qc?=
 =?us-ascii?Q?aC7rGxYqfUuWyrUP1wk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e042ada3-7ea3-4b89-3b4e-08db156a1dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 06:49:31.3319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1PFBhQ7pYjtE23TeDxD1BWfqIX7hU9cAAvUt4v+vcR0g5Gxlt4kVLqdeoYqeAMeb6OIaJe4VNjL0FYqmuaGJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9569
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel experts,

I am facing a suspend/resume issue with linux on top of jailhouse hyperviso=
r on
ARM64 platform with 6.1 kernel.=20
Actually without enabling jailhouse hypervisor, the kernel suspend/resume w=
ell.
So it should be the jailhouse hypervisor introduce some interrupt/timer or =
else
bug cause this issue. But I have no idea for now what bug may introduce suc=
h
issue. So I wanna narrow and debug from linux side see why freeze time, the=
n
move into jailhouse hypervisor to fix it.

I have try to enlarge freeze time to 90s, still has similar issue, process =
freeze
failure, the issue not happen every time, but after a few round suspend/res=
ume,=20
it triggers. And the cpu running the process has a very large timer expirat=
ion value.
Even I use jtag to trigger the timer interrupt, the cpu runs into idle agai=
n.

I see the process has flag 0xa05, it has SIG Pending, but not sure why it c=
ould
not freeze.

Seems I have no idea to wakeup the cpu from idle and let it schedule.

Hope you have any ideas.

---- Running < /unit_tests/SRTC/rtcwakeup.out > test ----

rtcwakeup.[ 1153.430758] PM: suspend entry (deep)
out: wakeup from "mem" using rtc0[ 1153.435689] Filesystems sync: 0.000 sec=
onds
 at Fri Jan  2 00:20:51 1970
[ 1153.487507] Freezing user space processes ...
[ 1173.495070] Freezing of tasks failed after 20.003 seconds (1 tasks refus=
ing to freeze, wq_busy=3D0):
[ 1173.504091] task:systemd-userwor state:R stack:0     pid:1563  ppid:588 =
   flags:0x00000a05
[ 1173.512457] Call trace:
[ 1173.514909]  __switch_to+0xf0/0x170
[ 1173.518416]  __schedule+0x28c/0x710
[ 1173.521916]  schedule+0x5c/0xd0
[ 1173.525064]  schedule_timeout+0x8c/0x100
[ 1173.528996]  __skb_wait_for_more_packets+0x128/0x190
[ 1173.533975]  __skb_recv_datagram+0x80/0xe0
[ 1173.538081]  skb_recv_datagram+0x34/0x90
[ 1173.542014]  unix_accept+0xa0/0x1c0
[ 1173.545511]  do_accept+0x114/0x190
[ 1173.548916]  __sys_accept4+0x70/0xe4
[ 1173.552503]  __arm64_sys_accept4+0x20/0x30
[ 1173.556609]  invoke_syscall+0x48/0x114
[ 1173.560368]  el0_svc_common.constprop.0+0xcc/0xec
[ 1173.565085]  do_el0_svc+0x2c/0xd0
[ 1173.568412]  el0_svc+0x2c/0x84
[ 1173.571472]  el0t_64_sync_handler+0xf4/0x120
[ 1173.575752]  el0t_64_sync+0x18c/0x190
[ 1173.579434]
[ 1173.580947] OOM killer enabled.
[ 1173.584095] Restarting tasks ... done.
[ 1173.589831] random: crng reseeded on system resumption
[ 1173.595422] PM: suspend exit
write /sys/power/state: Device or resource busy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
suspend 57 times
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Thanks,
Peng.
