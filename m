Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FDE65B32F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbjABOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjABOIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:08:16 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBABB3A;
        Mon,  2 Jan 2023 06:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWPtkRReOAfFVfjzo5IpTOAqcYpVb/le3dNOYp7jm/uje8E+rgW8DP1zzKQzx0ggKyvGvVyIP2iCp9U/IsErDZZj0IorCIOGpJJ8dFfo/Czy90S85swKoUcUAtvM1jL+3/DAFLriXq+pcmOEiu2k27ch06WkP/1HkxwXig1ZHWEPqDUQo6/kZD+dmz3ZjJmWAGC/tAuuQXCzn+cI6GL27q1/mRAq0x5abO3rYreeKs8Sikde/ITH3XQAWZC2GCFXfJa8gbErqPFs3rMZsf7VzIGuVP7TfLVedJH2kYYjt5CheTNJu2f5CgHl7OBBr/ZhydBoWl7R58xDiXFcmcR28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbpTQlV8hG4UjZ12j2uQcRhErZ18D+nTQ3MlIZJxMN8=;
 b=k7c+RUrG0tiytEzDHHxNCdF6GT7x6QQ3ffjTQBWpru6veTQcoNAoTSBILzInB+iXxHCOWUO0G65Ao3Ig5VQ5VeE8YVb5BU3zVo1IGBRX2P4zx+np/0dBiUgxnpc7w4L5K+wx6Sdp62qU30GBdX0efJZkXSVon7nMaVujfls5nOjo9hNrKDNNOlSoWBki3ua3Xbedq39Ss0Mdn81BkDGbisOB5ZcZ7a7CacVUOXhxyPA1Tu/qq4erFL8najAnCl3fT5LhTUbEvgsyuYnHegD3765JRGfpTeKR+Gu/94AX6cYgBb+E/YSPo/SFzVqqrEuCLc3QgobAki9Am26zudNhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbpTQlV8hG4UjZ12j2uQcRhErZ18D+nTQ3MlIZJxMN8=;
 b=cfpbMlriEN2yJ3CI/v9DU6LH7QXnD2uJgp8FJ9DU0qUtXnWULkNfHESNenpc6c7LJk9xEwPM8vQkWoDWLh71MuHxczHuZIb0muz8wHccvMQyODVZENviwMqYVUnFUh89HYcFIi9AO7hB7i2P4wasG54n0Cz0QZndUfv7A/LXCFU=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by VE1PR04MB7406.eurprd04.prod.outlook.com (2603:10a6:800:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 14:08:11 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::a24f:f435:b192:ee6a]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::a24f:f435:b192:ee6a%9]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 14:08:11 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Rohit Fule <rohit.fule@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v5] Bluetooth: Add hci_nxp to hci_uart module to support
 NXP BT chipsets
Thread-Topic: [PATCH v5] Bluetooth: Add hci_nxp to hci_uart module to support
 NXP BT chipsets
Thread-Index: AQHZHrOlMlqVvEZB40uzCuwx6oKDVQ==
Date:   Mon, 2 Jan 2023 14:08:11 +0000
Message-ID: <AM9PR04MB86031859F17AE8D5B563D103E7F79@AM9PR04MB8603.eurprd04.prod.outlook.com>
References: <20221216094350.1121354-1-neeraj.sanjaykale@nxp.com>
 <85D2AE3F-97A5-4C88-8FC4-1684F3FD4438@holtmann.org>
 <CABBYNZLWFNWp=StPQ0=8hQe8bUoJzwSvCBk7Ybd=2oe=NROCgQ@mail.gmail.com>
 <5742801D-881A-45BC-A8A7-28D694179D8E@holtmann.org>
In-Reply-To: <5742801D-881A-45BC-A8A7-28D694179D8E@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|VE1PR04MB7406:EE_
x-ms-office365-filtering-correlation-id: f07a1afb-5499-440d-f374-08daeccac882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GulLbd08BOdMEeik4y03SlBDE8P3rKE6+Cy9ZhDWIdp9IPbHBzM1M2hMWV39gyN39ibr4txGFY6Aien5DNTDmuEDvoktGeXxfAnt8y+Hcs/IqPlEO1ERMRA+a09bDXz7pW1Gbt6DU/6vvqrpUIYmmFbnO5foxLLmV0ZAhfeAyEV8ufJWt4cNg3ulbXTp40ycoPS7jFc2mPYMLpFSKrkpWRmoYZuB2q7ZI8CeHuxQ0pTW+KZbrpQMipQHG6FFSzpkna4Y3+wjIULBle+74+GxOQWMllhCGXlfcQYJ4lKiMAZRfxsejBc7UrT0tk5vZnaHPnks/Dl38cCifVNwz9HdXWuUD+Yn+kfJccSHv3cwfUp7+q6wrYSvUTmIADtCKQHIPk8SqIssQDK4rfxPJmyai55PMM/dR2SeF/wJv18cQD6El4HK4/o40Nx5GK3yAcC9G2honWz0eEVfio2RW5tMOslhUbTnl8csjsPYZqMHKX2vsiwscV9Abi+1PrnJtvyiIcmVnplVmV5FpmO+20INxs8Q/kaq4IoCsgbkmacF/cWxjzFtCcFNgzox8c/lUPWjJLDhYVQn9P6lxYRC+oyoRPkPpbnA7IlTfoyOPO81TBhLo8++629NTlrlxhNCmDqCR9k+nexyTtXpoR3DWu+JcenktFhH2U7E/ordDOAJBeVzwydMC0dPmCviWPcWBSC3m2epsTc8Ld8JQ4JAvqWMhW4b5dmKwjk0CvnWpfX62GA7+YU855p/LhqiaeY80nxKgY2bZbGkbWOIvARndqbJc9mHFYqubde/hbi83R4rGhI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(41300700001)(316002)(54906003)(110136005)(4326008)(8676002)(76116006)(66446008)(66556008)(66946007)(66476007)(64756008)(86362001)(38070700005)(122000001)(38100700002)(83380400001)(55016003)(5660300002)(33656002)(52536014)(8936002)(2906002)(6506007)(7696005)(478600001)(9686003)(71200400001)(186003)(26005)(966005)(22166006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IfaBwc7h2ifhlE/nuCcT9XwEWLDJ1X2YyuW7J1Viy2uRPCGnQtvv3j+e7w5o?=
 =?us-ascii?Q?jwGpHpDF6dF16cu4r0ts+O9UrIWGIC4/jvj6FTBb2fchS1dcYIIuXHEaCN1e?=
 =?us-ascii?Q?YozeAqCMozBHuNC1FQdfYzmpJmDCHSl/0CvXzJ0BDEDji35gr90oqje5+PcJ?=
 =?us-ascii?Q?bSWZ9NcjENNLX6vxhUMZ84zTmvvM1syOe5B+XUslJ8F0nMOasJFtkY3BB4k9?=
 =?us-ascii?Q?Ym0eDv3D16dFDQOrqJkiQkJO/5H0S1TVLgRZo/bZK6wgqqneK1Egf1JPiyzh?=
 =?us-ascii?Q?SNqk3wBk2JIZJubbtpttUVrGLKDmzpS3wHXQ5henUKPgh4sRBHlGhnbqrerL?=
 =?us-ascii?Q?zFGUGYeE9HO6x5VEAhbSjVG1MJp/FQmoVViS5qJ077EM1KJMD7n1c1UhcDsB?=
 =?us-ascii?Q?6tewZMbVbhr3Os49H1Q927QvoVfeU6vT2N6l+A6vU7/yNsPWCN12z6cevMks?=
 =?us-ascii?Q?6cMoKHhHhFndOVu4gBibrcjU1L9RdabMOJ9USxllbXcqj0b3fjOxakbc8EOW?=
 =?us-ascii?Q?rkq+CVBKUB5SJ8ynafm3E89i4n8p+9+uASBJVDybRPUJwiA2zmdBKbCiD8ag?=
 =?us-ascii?Q?Gnn3gHNOssLLlROsWxKmHimdEpBFiHrzlmXOIYJWBUhiie2Z5jHGI1yweeM6?=
 =?us-ascii?Q?cgpIoL234zjWjYKGbgCyR2tC4JzpCkH9tGqXOMwSwOG4NC8qrDwElSQXpy8t?=
 =?us-ascii?Q?u70JbR444LEgXowf2OfsLBpJCOhzL+aSTQjurhskCw+i8U99bTwEmXZY59r1?=
 =?us-ascii?Q?QlLA1qubyL1FsQgxrv92ysNqQ7hvkBbZRCm4RHlMCB0Cx6YMKlXjl2BwozR5?=
 =?us-ascii?Q?r/YT/WaPP9bzhJVeiFoWCL+cl476QcluhTdl9w6BxEnF78zgW33MiMOgXbko?=
 =?us-ascii?Q?iKWCxtOnTPX8gwkVUeJMrcwyQxBcZzvSbpd+cz4PBXntZPlmcD4ZlUzKhjli?=
 =?us-ascii?Q?FBXO1LzjI9iU7iwIo/sJFrhP36qCHF548e6WqG9YRI/Q4pLeKLb/vT5td1Lv?=
 =?us-ascii?Q?eV6nAEwyhfoUdN2KSIfQDIgiUHbc9QFgDowQGrVr2h1zFSTywFjUw9bYcudQ?=
 =?us-ascii?Q?iC5hO0nnl0zaT5hD0tHE1ZjrpTacI9NHA5eC6AqjQKtW5VyD80ITe4hR840n?=
 =?us-ascii?Q?F1uCsYuGInNIrPz7D42sQyy9yW+ogjhL8TAlGYfRRKeU/f1TDSmc6pANzb6X?=
 =?us-ascii?Q?3YiZYF1S7rQ3DLKWu8WGMEtQpcfIYw6FmQrBENLtoTGlmhHc4BkxycKftHwF?=
 =?us-ascii?Q?UVmOfAJ1tjTesxeSAFFfok8ZK5Y4VBw8zoag3iR1nepusOxbCm2WwQ7Fhjl9?=
 =?us-ascii?Q?cNwbfibSi0hEcW5hrZaivsSuCl/DWKbwix40wCpTsOSg0O3DipKBpzM6MfIQ?=
 =?us-ascii?Q?5JKvuWMghlv2a06wnd/wf/gGA98wIYM+UaRv17ewccHEr1bjA8oqAUm5GxVr?=
 =?us-ascii?Q?U2+HjqskePIjFYUSl4XHgCZtqLAlEMxjpUNH6pHasDciEYrVFn8SmugwRGNc?=
 =?us-ascii?Q?MNaLD12vWv/ZCNG/OmjWwoQ4jIXN/xXrNXj0SLEkOcLASMaLKCiKc5RX9Ggf?=
 =?us-ascii?Q?KM4bwAf43vG5D7h86PTauXAjpZv132lq1riM8RleiOQb9651YSo8h+LNE3o+?=
 =?us-ascii?Q?fA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07a1afb-5499-440d-f374-08daeccac882
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 14:08:11.7295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpeO6Asc4PPLJVHsS6sXO0az738pekOs9yqc5Rs/2M1k01ufCd9UiWsgpShs8Z2t0rDyyIvWjV7iBIC0g44ydUKGDeKhrTVUstewRshzAKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

> From: Marcel Holtmann <marcel@holtmann.org>
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>; Johan Hedberg
> <johan.hedberg@gmail.com>; Paul Menzel <pmenzel@molgen.mpg.de>;
> Amitkumar Karwar <amitkumar.karwar@nxp.com>; Rohit Fule
> <rohit.fule@nxp.com>; Sherry Sun <sherry.sun@nxp.com>; LKML <linux-
> kernel@vger.kernel.org>; linux-bluetooth@vger.kernel.org
>=20
> Hi Luiz,
>=20
> >>> Add hci_nxp to the hci_uart module which adds support for the NXP BT
> >>> chips. This driver has Power Save feature that will put the NXP
> >>> bluetooth chip into sleep state, whenever there is no activity for
> >>> certain duration of time (2000ms), and will be woken up when any
> >>> activity is to be initiated.
> >>>
> >>> The Power Save feature can be configured with the following set of
> >>> commands (optional):
> >>> hcitool -i hci0 cmd 3F 23 02 00 00    (enable Power Save)
> >>> hcitool -i hci0 cmd 3F 23 03 00 00    (disable Power Save)
> >>> where,
> >>> OGF =3D 0x3F (vendor specific command) OCF =3D 0x23 (command to set
> >>> Power Save state) arg[0] =3D 0x02 (disable Power Save) arg[0] =3D 0x0=
3
> >>> (enable Power Save) arg[1,2,...] =3D XX (don't care)
> >>>
> >>> The sleep/wake-up source can be configured with the following set of
> >>> commands (optional):
> >>> hcitool -i hci0 cmd 3F 53 03 14 01 FF    (set UART break method)
> >>> hcitool -i hci0 cmd 3F 53 03 14 00 FF    (set UART DSR method)
> >>> where,
> >>> OGF =3D 0x3F (vendor specific command) OCF =3D 0x53 (command to set
> >>> sleep and wake-up source) arg[0] =3D 0x00 (Chip to host method NONE)
> >>> arg[0] =3D 0x01 (Chip to host method UART DTR) arg[0] =3D 0x02 (Chip =
to
> >>> host method UART BREAK) arg[0] =3D 0x03 (Chip to host method GPIO)
> >>> arg[1] =3D 0x14 (Chip to host GPIO[20] if arg[0] is 0x03, else 0xFF)
> >>> arg[2] =3D 0x00 (Host to chip method UART DSR) arg[2] =3D 0x01 (Host =
to
> >>> chip method UART BREAK) arg[3] =3D 0xXX (Reserved for future use)
> >>>
> >>> By default, the hci_nxp sets power save enable, chip to host wake-up
> >>> source as GPIO and host to chip sleep and wake-up source as UART
> >>> break during driver initialization, by sending the respective
> >>> commands to the chip.
> >>>
> >>> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> >>> ---
> >>> v2: Changed the subject/summary lines and added more details in the
> >>> description. (Paul Menzel)
> >>> v3: Made internal functions static, optimized the code, added few
> >>> comments. (Sherry Sun)
> >>> v4: Reworked entire code to send vendor commands cmd23 and cmd53
> by
> >>> using __hci_cmd_sync. (Luiz Augusto von Dentz)
> >>> v5: Used hci_command_hdr and combined OGF+OCF into a single
> opcode.
> >>> (Luiz Augusto von Dentz)
> >>> ---
> >>> MAINTAINERS                   |   6 +
> >>> drivers/bluetooth/Kconfig     |  10 +
> >>> drivers/bluetooth/Makefile    |   1 +
> >>> drivers/bluetooth/hci_ldisc.c |   6 +
> >>> drivers/bluetooth/hci_nxp.c   | 592
> ++++++++++++++++++++++++++++++++++
> >>> drivers/bluetooth/hci_nxp.h   |  94 ++++++
> >>> drivers/bluetooth/hci_uart.h  |   8 +-
> >>> 7 files changed, 716 insertions(+), 1 deletion(-) create mode 100644
> >>> drivers/bluetooth/hci_nxp.c create mode 100644
> >>> drivers/bluetooth/hci_nxp.h
> >>
> >> so this is a clear NAK. Add this as serdev driver and not hook
> >> further into the mess that is the HCI line discipline.
> >
> > I wonder if we should make it more clear somehow, perhaps include a
> > text on the likes of BT_HCIUART that is deprecated and new drivers
> > shall use BT_HCIUART_SERDEV instead.
>=20
> not even that. They need to be separate drivers. A long time ago I posted=
 the
> skeleton for btuart.ko and bt3wire.ko and that is where this has to go.
>=20
> Regards
>=20
> Marcel

Thanks for your comment.=20
Based on your comment, I re-worked the entire driver with reference to foll=
owing patches:
https://www.spinics.net/lists/linux-bluetooth/msg74918.html
https://elixir.bootlin.com/linux/v6.1-rc4/source/drivers/bluetooth/btmtkuar=
t.c

I am able to create a standalone btnxp.ko which is able to run basic BT ope=
rations along with FW download with NXP chipsets.

However I have now hit a blocker. The NXP chipsets require support for brea=
k signal, by which the host can put the chip into sleep, and wake it up.

However, it seems that the serdev API's in https://elixir.bootlin.com/linux=
/v6.1-rc8/source/include/linux/serdev.h do not support break assertion over=
 serial TX line.

Is there any plan for serdev to support break signaling?

Any help on this blocker would be highly appreciated.

Thanks,
Neeraj
