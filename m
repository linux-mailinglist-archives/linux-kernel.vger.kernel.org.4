Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4139E67A09A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjAXR4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjAXR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:56:21 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF7EFAD;
        Tue, 24 Jan 2023 09:56:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYRM1h18mf4Uz4vn79TBnwUnMGs8PTUtOKT+9ozGgajLWeABnYWIO7rryizPfCPfGZbLbX0LgrMswqiYyCydcQb7rykjjAgpU3PsZCV4C40jsv8agrWzuVtquTUgT7GdxBvID5nPbZgjOplEua7k++L+Oq7ES7KoIztQWZcw3HgjzpRbRwzAi4k1BW+Uq9b3LklzBYHjsRVXtpP45KJO3HxagUESk8iZiayzCWL0LaXyOAUHiQMQzztEeh4P2HL/T2+iGDjOaHhyjNUkTj4on2yEnScPIDaQJvTLv3AOeEwPJw/kKy01wqi+dqLn9kXFCkH6c6QjCjp96sJ3jHruEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnESgfuMuJnMIbZE/EXL6DEwGEABfDXUpUXiXFp71mA=;
 b=KQ6/ytgYgrCoURIBKXPD8WPC2w/23cmVtWaWmlpxiqZEnVrlxmzr0ufdYQNsbJJiDiTEBkCwpZDUhxcr1gaRN8mo/iXPQ1RpkNDaDnw2GcJe3EzwYMzU3zMGXQP4jqIs5LxumrcS73t0TXaT7vplrsIKdrcP0rhR6/VKzegt4kU9YNGduMH6KvEVmB48HgyChB+DM3xj/WgFuQYI9WWP6R3hzg68VvqWFXOxOL4CHs2aSOZycDdZyxwqyK/N+7RodqglzQVj4/EdS01Zw/d2/OwJS84cEtWakS2cneI5XjCc8yRZRx56yodBucaj1uKoXAXJvFoy045W4XrCMqYltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnESgfuMuJnMIbZE/EXL6DEwGEABfDXUpUXiXFp71mA=;
 b=XsYDKDmBqUqK+A3li2tQnj/wQALsPZ1g4kvJo9YywKcUfYJLUeaGkXETvs5Zlpes0O83SFctLCjzLG+N6y6fEhlNUFX4gUXD2Md0M2cdO9jQeH23b7r0YzyiL0m3jb2L/BID+V5IWZcQItYFuECKVMoQTeDhZM5YCoy4+wI3eVE=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AS8PR04MB7719.eurprd04.prod.outlook.com (2603:10a6:20b:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 17:56:17 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::f8fe:ab7c:ef5d:9189]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::f8fe:ab7c:ef5d:9189%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 17:56:17 +0000
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
Thread-Index: AQHZMB0o1bffURCKV0GDmBHEhWeqqA==
Date:   Tue, 24 Jan 2023 17:56:17 +0000
Message-ID: <AM9PR04MB8603BBC26BD17BAE735EC36AE7C99@AM9PR04MB8603.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|AS8PR04MB7719:EE_
x-ms-office365-filtering-correlation-id: de80e041-422b-410f-10bd-08dafe344b02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYU1Iuw+KicJVSJloXDV/YOLKQGNkKPn7CIug1HDnPNtjXvt6m5xs6DrZJ7oWxqWeojCBzqeTuWXL61JDVcATh8Pu5MK7Fkni9gJtVW3UQvyRhYhMMpg+ftwLi/lVf4Kjq3yZCQaqgj2kLK2OxOYdsnRdcOUFZcbrZgbP4sBjPhYJpdeEqEGWvPLJrBPWoRM6rMIAR7dDGOIpd2L52neiXIgJnb4D0GinxSOcjP/PHz3SrX5KnYVBzLJHg5Od/8mfLLxo2275TEGyTCpDYlvvp2/m2vYNTOZRjsyLWvcyPoy6BK8aqgG0WBiGnPAb9/WWobfCvag3KdgG9YxlQkUCBnbaquvDBmRXO+TB+cgcQoXKsOXrs09ZCc4A0rfiIPAZOEKqky2Lcgcux0PkzUssHn7uFaknFx8CNvKN46Y/44Hz6CEC55FW0R/yOcJ4GpldcHOvXDbRH6oe1xpK3H9Jl0WVsGXs4K8d5zCx4Dk1nfYivE8UMpI3tnzuyHbCxeqM4Zn2qxC5/s+CRP0o4yeWVXXCGKhwxraYKSXIxtak8HyNducVzFwHNlD8QnhLlaNgv6EKrP7GWCbjYVtPQYLotRBnyFHz9G8C2rPWnr7qXsX+6DTZz9aQYTsr1KP0rkZVFoiP9igo+fFQKsQr0iRjcJMJgZv4fAYDf3uf143UKYNrD3Swqdu2ZWRftqI9EHPIZW77mHSgK7t0amBc/HTaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(122000001)(38100700002)(33656002)(55016003)(86362001)(38070700005)(316002)(478600001)(110136005)(66556008)(64756008)(8676002)(66446008)(4326008)(66476007)(76116006)(71200400001)(7696005)(54906003)(55236004)(2906002)(6506007)(53546011)(8936002)(186003)(52536014)(9686003)(26005)(41300700001)(66946007)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T9WdUmcfh2SaRUffeX5j0MLn332PhIeRfyVLEC2favXupOewdqOzyGQr388m?=
 =?us-ascii?Q?/PGi3U4VU5vrtLMqtxzN0xVHbxdS9oJrNWpufq/UD6jrP5H4d3MStm+zCHbk?=
 =?us-ascii?Q?jGeTYJoIao6WDszYXGBEpb643aPGbxcq1yFImn3li0IlLUT+lk0KjByTbero?=
 =?us-ascii?Q?w+ZAMqd1uMl2DME9fTtRxu5vgOS6UUvtH6nP4fO7/zYvyLggVy/gtTxlpFbt?=
 =?us-ascii?Q?E1d+IuGy5evDD+aYxTuNLF7HpRTMswNmYKlYY1nmFfUhJjY52qjH9vcvMyZc?=
 =?us-ascii?Q?gqFPr1X0WJI+72nN2Sjx52oRosvQ8a5LY0AGIIA0FsRCT3aLWd7u28ztYEk8?=
 =?us-ascii?Q?1ja22OlYPKQ5NMEzXAb9t8npdMMzaF2zhAvVOkaxTtFL7Mm8jmSZ6YSOVAcM?=
 =?us-ascii?Q?X8pkaWN4rtBQoqN3gZYGu67iud3M5+QOVGLf2/5oeQSukCOg4zLrVFJ6SPRk?=
 =?us-ascii?Q?LctL4NQ0eu5EFnLlNPa0u55fEfoBLSJNvHp93A+ipHVcdVKf5FhRMvLnl4K2?=
 =?us-ascii?Q?VRRpDv5vQyCM731JCA5rVDFr8pdGCicUDTwemsgdliXH6tcCYMgxfCxckPWD?=
 =?us-ascii?Q?9S56r37zZXodlG1Ov2/9QycHv476Dt/BJZWTbh+GfPXyho1neqUKYRTh8uuO?=
 =?us-ascii?Q?yNeUks2PHQNBjWm648PLs1AuyVoSvWPhZo1s8OKKj/zX6+mTwJyQrSQG50S/?=
 =?us-ascii?Q?pgBdMrB88A9p2TtG2lGTtcY7y6F+JTdsej0F8pbIjBYyx550dn051lfggN6e?=
 =?us-ascii?Q?XOxtR20YNG5/cVH5o9BS4mpOgn55qqnDP8J6VpmlZYaVkUwVqDfrdGyluFQy?=
 =?us-ascii?Q?cEJQXfpWPlOnN/c0iBst74HcrLsiRFUaQI1K0XC4n51pdYrSj0xCY3KqkNZ+?=
 =?us-ascii?Q?QyaAKpN7mx6p09VVdygR9bPmfjLlWla84yPyvagLAcN4dUZUyAyrKCqjCzOP?=
 =?us-ascii?Q?CpgA2+vMBv3TT1tR1S2UHl+GlLqMt8LMbo5TJ/Vp8GC4qNITt8D1p60nX/Kp?=
 =?us-ascii?Q?5kpDmK+AyS7zuIfrceO8ZtPT51/kud9ZvES9hWvoZ+YqyP1dB/hz4LAsnOad?=
 =?us-ascii?Q?hif4SzIhsoe3q0vVN2qZxm4Io+XkE027akOTzFfKVR5HzIe7/OIf3ToG6Wsw?=
 =?us-ascii?Q?QjW4iCrN24MRMAdCa4mPXqUXYxgAPlC4840zVRveUh5UpNqvz7FnsXfdSiYK?=
 =?us-ascii?Q?QSWOBJ1K/ndibY6+kjXg9AJo+NhHqXeYFrkOe0SY7mS5XqYVxdwg5oSXqfNd?=
 =?us-ascii?Q?Ey0g4KNGCE7lMWnAF16rI2bcWDuPsRQitSn/K1lDzLE9iLW68W6P7bJNsksZ?=
 =?us-ascii?Q?C070iV5zf4wd90OY+fcor2wNCu623rjN8EwbLy3lD+DUTjnk1H9720lNHL2A?=
 =?us-ascii?Q?yx7zCbYL6PAyO3lptSPljc9GHtbATI6ZuS8tPSTwb2nt0q7AOzXN2L2wMl3V?=
 =?us-ascii?Q?Db9hBSYtpjmP0oSJF8pplGWqduUcXS8+YZkGX+seU4Ha1etiPOqirfL7Q9wh?=
 =?us-ascii?Q?N3KLfKsep5unVIbN5ESe3azPJNC0Vc2ifhJw5U1bvB7gbW5jCf318OSk/eCN?=
 =?us-ascii?Q?RWHhesWryzGIYi6SBwZ2lFWk8xpY7+FFctCX6a35fYJNspLBIH9R2PKY/tc1?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de80e041-422b-410f-10bd-08dafe344b02
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 17:56:17.5902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFK8vpX6K3VWQSXOXHFwS5czy7+MVWBvwuoR33bYdCyUDtqATfKy115J4pcx6M1gcp+71ITgR/AeEPa/Ui7QjuvXXqjXfsm5rjqMFWPJeqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7719
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
> Sent: Monday, December 19, 2022 5:12 PM
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>; Johan Hedberg
> <johan.hedberg@gmail.com>; Paul Menzel <pmenzel@molgen.mpg.de>;
> Amitkumar Karwar <amitkumar.karwar@nxp.com>; Rohit Fule
> <rohit.fule@nxp.com>; Sherry Sun <sherry.sun@nxp.com>; LKML <linux-
> kernel@vger.kernel.org>; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v5] Bluetooth: Add hci_nxp to hci_uart module to
> support NXP BT chipsets
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

I have just sent out a new patch for btnxp.ko which is based on serdev with=
 subject "Add support for NXP bluetooth chipsets".
Please have a look at it and let me know if this is how you want the driver=
 to be implemented.
Let me know if you have any comments or suggestions and please discard this=
 patch series.

Thanks,
Neeraj

