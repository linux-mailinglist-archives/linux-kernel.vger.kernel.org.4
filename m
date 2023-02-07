Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF668DDD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBGQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjBGQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:20:36 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2059.outbound.protection.outlook.com [40.107.13.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5943D911;
        Tue,  7 Feb 2023 08:20:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVGgj6RYQS2lAhC7KCQHNpYBQtmOnxGC9XsPhW5yaMRpUJYz8cqY2D8zoS+HKJitbgoFRMuheE+sWdrq6TXLccJZ3vbq3P1QPTkirOuZg3EAy4lVbZIzyqWX1Rvbbhk9OILzzNzClCcRqmuv9M6scHFpjVnaLoo1F5j5n2BdESYXbsP0xcDi6XJPZaSeoSJtn5Ph7FRKtxjYzuN+GAYxT4xYGlJFEcFjv9/Hiy6rnRRevO6Rs/AkFGOS0+06sqrNCsjlemQTrEX8aqwHTjz376E1iAXDQUBUKBLfkAMR8u9PYG/NKUgJpETUS1zr+YJspTw2xMJQGRION3dYDcQKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orupMnO4e3dQNzw+ROPL/AGdNXjGfyRbC+Cz/ahpqys=;
 b=j+pPEU2tAOuVfZ7wYOewhUcfBW8PdhWQ0EEBzeBqcx/hVmEQNAesniilMZdX9oQ3pqbLAeZcIUAS6U1ZejUaOuU2vBC8+eKZ3gwY92EXrYj7x9xYtMlvtcL+wz/lALoJQJzWjpPsp7XqAyDsfcnD9zdvmO8LzgrHjm4atTQLUtHgS2HEUMNl7clh4fH+HHILCs1rHsGMeB5RJO8MgfC/HysV5N6SDTbcxz//rekS4/5qhIJUqpPSBIlqQSY6WjGJmJaJabiFZVpJNo9HSlrMTAtoSTSu+H1BlFI9o3HDfJjLXfgtBQSZn9AEAIoCx8mjOqBptCIpCjblvwvmj2X1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orupMnO4e3dQNzw+ROPL/AGdNXjGfyRbC+Cz/ahpqys=;
 b=msusOyQdXKadvDrciBfqHyam0Y+1sSnUgSttIN9JeBWnl7Z8/eVR7oyLNm+OuZVldutdYPr91DtgpiWDLjIT5neUyb/QoGpiA2HkxMDvLr3jTqZ0TPNehOeqzDjHgyLqUq5RDKkO2wEu5zx8ZT612UbhNSGuCZvtDgMNz7F02k4=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by VI1PR04MB6783.eurprd04.prod.outlook.com (2603:10a6:803:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 16:20:21 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 16:20:21 +0000
From:   Frank Li <frank.li@nxp.com>
To:     ALOK TIWARI <alok.a.tiwari@oracle.com>,
        "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [External] : RE: [EXT] [PATCH v2 1/1] PCI: layerscape: Add EP
 mode support for ls1028a
Thread-Topic: [External] : RE: [EXT] [PATCH v2 1/1] PCI: layerscape: Add EP
 mode support for ls1028a
Thread-Index: AQHZJrz7UNBwg0aD+0SFGvc7zfwgFa68DdDQgADCWgCABwHIYA==
Date:   Tue, 7 Feb 2023 16:20:21 +0000
Message-ID: <HE1PR0401MB2331634B29ED9EDAB032B73888DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20230112193442.1513372-1-Frank.Li@nxp.com>
 <HE1PR0401MB2331C19D7474E6EAA4DC29C888D69@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <199a5aff-fee8-71d3-bfcb-c0492667de1b@oracle.com>
In-Reply-To: <199a5aff-fee8-71d3-bfcb-c0492667de1b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|VI1PR04MB6783:EE_
x-ms-office365-filtering-correlation-id: 339ffb26-b8b8-4505-ca5c-08db092735f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFvtCkxIvDPnIGwlTETa/cBHoSWk5UteZBEa/Am2aDfT0OK5AaGEQH4p6XonIycbqTSxzOhBBb9PkGjaJWt1sfetC8p5cjAXlmQhdvZMCHbiYj30q2kSa/KsE++EyGk3Aw+c0nHTzF0XNm3DqkmY/JfKo5lOVBqXbLLDmPz2tFDQqOaP6OsWFIe5mtJBnGa1Nz6XTU5WLFzKyHtwwMucsoh3304uFyPl/Ojd/NWmOf88Nd0L+tpiQQuorkNsiSotNiHV4UGApqqdGs2EgQjv9DyhKAxE84h3EQiQgvRZYL6U1Qb1XB+Pffz67KxdiBcOzXzKoUe6BNJXJnTaUSN3yQpgkkfSORoqmEDSIk3ClSjrV0l936Z7TWXBXxFPUkic+HGUFYClS4H6448h32qZFdmOBYS9AEWju0VkEjU4AdZgLjFgvPTuyUU6YZ6bGjTXE27n34DJpwG8QbQkiObZN7FyAFOQXowDzG2cf80x+aZSg8WBZcYJ4hQIx8OBiOeJjUN9MJdezaUWl8HNaN9STwjFQqwOdU1mcNshw795q4Swzj8Xi8VMtsw0ifnBfk1XZkyisRxi468dkr8+GthZ4N1w0y/G5HoEIkj8JeqHdEbes8HQ285/w2BxQKt+XCVhMK+wK0N6pwuYHnS1ZGgNw8VmT6/gzjxJagbEUZY4xQ/tDI+UstpMKW/IWDE+SIOfyZLdfiMUkHKV2zkS3J5ZBTG7RGlIKMd7N7uJl1nNcA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199018)(33656002)(921005)(7696005)(38070700005)(71200400001)(110136005)(55236004)(7416002)(4326008)(6506007)(8676002)(478600001)(66946007)(44832011)(2906002)(66556008)(66476007)(52536014)(8936002)(316002)(64756008)(66446008)(76116006)(5660300002)(26005)(122000001)(38100700002)(86362001)(41300700001)(186003)(55016003)(9686003)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?adaHA11svl3Lpee9TkGUFPa4cLXx2WEMpNoZf2XU9OWokOvlKPAws1AGnb?=
 =?iso-8859-2?Q?eBevwOyAOVUuiNjnubPz+lGrDkeP/qwBv8KQ/1hUGRAz9RFSkUH8ArZlW+?=
 =?iso-8859-2?Q?jbww+IjKowJBpXOXf03RJT9AnQ9qW1SIfzYNdYv/ixZXJ13pQeGI/q2KJc?=
 =?iso-8859-2?Q?fcJy3oxe5+wrpIs93BSLZkRyooxnl3MGjKuGNWwCMkNNy9JeDRM5bB/0K4?=
 =?iso-8859-2?Q?AKsdiSjopuGtYrKy42yPg9dFYrK8CpToigCo+dCeIjeRBU70P8YETwkx7b?=
 =?iso-8859-2?Q?wK/xBDxWji+P8ZR1PHOoOr/mP3oBOj11MU/+WQuHWkqLZfX4/2vRokmxoF?=
 =?iso-8859-2?Q?7SZHzHybnGFy9WP7ui4P2Limzh0/uJ/OcFPrnXXSnaYG9KOYw1W/OC85hD?=
 =?iso-8859-2?Q?tT3C084Yn1/UsH4LHClh2jV8dzk5eNMRupjBJlm2hBgBaR46uk9hKfWODN?=
 =?iso-8859-2?Q?4MLnTSn35MTKJ29hf2H5xS8QwYJiLBObz2lMqwMqTo8RI+wkQYsBZGTKZW?=
 =?iso-8859-2?Q?z3iYoHtJi1Zq1L6VIc3PX4mTK+yoQufeQJM6aL1WAkg8fEkK/nUHoVIBCA?=
 =?iso-8859-2?Q?LGqH01VUOOcc3n+KYTeL+Ex979v3wDCKCrgXHsuSrKt8Mo21jwLjMHMicI?=
 =?iso-8859-2?Q?oqC6IHLL429OY6U07xs8hmEEyr+mBRhMEB5KkYN21jxmk/4pcyVsYsgGqY?=
 =?iso-8859-2?Q?sllUtlkidFb2is5yxTRODypYVHc1EK9ou2iMilX2Alb6J0C6h6U9v6QeY1?=
 =?iso-8859-2?Q?SeUdBIvPfzdCTMfIMXhswwB2Ui7w1JwLwgMcKtTYvUYJcsTXqokOkAv1/5?=
 =?iso-8859-2?Q?1BsA4xTya/qv37wTW78zZk4xsI8Gw8LH+KBtg4HqQHE0Bb/adX3WGgRx9T?=
 =?iso-8859-2?Q?b4GsaU5MPBYPpDQS0UtzA40DQIXZWG2kuweUBiw7h/P0T55YbO4Y/kyv99?=
 =?iso-8859-2?Q?YEvybaon44slY+bVupbfdAknXisl07RFxE/rhqRgCIPBhLtM1JklyfCnOJ?=
 =?iso-8859-2?Q?Bw8GtP8l9WyjHUzBVRhWrWln3e5JUbcuxSO6b9ZzMAemIIR4LQkl70PQ4z?=
 =?iso-8859-2?Q?oStdXm8e2+OGyROAJidPAdSjC1/+tg4p0L0ld7a+nZ1aDZ6iXf06VKim8v?=
 =?iso-8859-2?Q?NWvbGCydR6sCzdcuv16ThAAFW5ayFGO35Sm+QyrzRuaS4oC5FNlUZdOjAH?=
 =?iso-8859-2?Q?8mjyzh6UYgWL9nc9DHk9px+PRZnRb7DPJJ7Yf4Wfu2oLJL80yAxzG94Wbd?=
 =?iso-8859-2?Q?0pjbz+BIV5MVTMvtSLN/g4SGnh33auaFxAQMZ5xsfPU2kk16MgsfePTDOL?=
 =?iso-8859-2?Q?2+A0EaKXLoTepECHifvgVjZqfXFA0T2h92ef7lRjx0Kp4KuMVmglERYHmY?=
 =?iso-8859-2?Q?5ECrt1TNQl9Bo2MZVhfX11fSSIgHII7iiTeTe7udp4UZDBt5hEw6DlBz97?=
 =?iso-8859-2?Q?Dubo8tIPfJDc+HUp0xC4AKdChc534Y/M3dI0M20nLISETTePW5CsN99r7r?=
 =?iso-8859-2?Q?dnHuDIQ9nFOg3ICt+Mm7IzjgHq8JnlZWnn5YaGx/eGrB9fDhgO71vtaIhY?=
 =?iso-8859-2?Q?A73RDBZ/jJYtmLdv51n9xWEilSn0X8WuY5zUWSlzh2DIjxl99HjkcBoezi?=
 =?iso-8859-2?Q?K8PkXNe+kosAk=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339ffb26-b8b8-4505-ca5c-08db092735f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 16:20:21.6198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dirSyz5sKUtTRPdc/gKFgGbpXapI8NppXiGGbgeYJHbLxy9HLFABgBuggoEbAK5iO4oagblBMrMNpF63GJwlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6783
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [External] : RE: [EXT] [PATCH v2 1/1] PCI: layerscape: Add E=
P
> mode support for ls1028a
>=20
> Caution: EXT Email
>=20
>          { .compatible =3D "fsl,ls1046a-pcie-ep", .data =3D &ls1_ep_drvda=
ta },
> +       { .compatible =3D "fsl,ls1028a-pcie-ep", .data =3D &ls1_ep_drvdat=
a },
>         { .compatible =3D "fsl,ls1088a-pcie-ep", .data =3D &ls2_ep_drvdat=
a },
>=20
> can it be like this for better readability. ?

It is just chip name and follow name conversion, which already upstreamed a=
nd documented.=20
Why do you think it not is good readability?=20

Frank Li=20

>=20
> Thanks,
> Alok
>=20

