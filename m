Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E142A60F9BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbiJ0Nyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiJ0Nye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:54:34 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F395BD;
        Thu, 27 Oct 2022 06:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/GQ5rQKR0GA1enAYyoP1hYjvzJ7QeT1hrhjb35WlrdAecRGuee2lzJUm7zxIKlgbRZUrRA89rahibvXaRGq1vvoQUKgwM2zR8DLU5ajfdriYDtFhRxgptcjxg5rQ4+kVZ69NoQTtYROSLxbd1CxT9NdgnMYx2N9m9XobXfKGVEwIv4qb67hBDP0nYrDrwOhPpHrpdx7g3UYAzJGFoPBepkO20it/IhmtNR/ULqe2JojR9XHJl9JHBD7TeP1q1lH8KDSogcFsw3vitSH47X6vP9N/NQ6DKt4ledKiKHfJreN8i8S1autLltL9mmPbnYXk3i3w3T6XXIacRJdzrpWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UZ7DsMWn3TRX3bLFtDCUt8jWKWrJdbXRMBA9wwNCZA=;
 b=i+BrcHxIdjUXTK5118wTh4EztB0P0mKJsv4s8M16w7+NB2RkO4vYfqCA1fMT39qbSPO3939l1twLNEeNJYGDPb6lqfuRBdCeyDm7QZtz606iFcYpYODispkjGtNVPlR2YC2DcPEzWIfzEOp70Zr/VtRmsvovLuMVLj+VT15SyXnvBeK6ZwJ7+AUJzBU4Y8pvrK2UMoUx5cP8gV5NgrfYBYUjZgqYSf7PXR2kKUfGziefkq8aMStTjwzNy++risFxdiij0vlMQdsY9U4dYNbF6nkmUHuMtCEiWVj1Mw8MCT5rgTdZtWFyC+LsbpAHQUbFnSAsM7q/ix+6o/m/lQvmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UZ7DsMWn3TRX3bLFtDCUt8jWKWrJdbXRMBA9wwNCZA=;
 b=lll8kE2BdE8bcU2W/bhOmCW9U2vuusCilj7Rm47ilk9ygv/lYv/y2UWyOciEJPmdzvM5KPxEhzDq+vqEUDR5vxW9i3whU0VxO7R0kejVYjhGSvZRYpLI02ltyievCYAirQ884inRm/F0oUklNUpN95pMSzN2ydo/h7G+1K8/mVg=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VE1PR04MB7326.eurprd04.prod.outlook.com (2603:10a6:800:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 13:54:28 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 13:54:28 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
Thread-Topic: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
Thread-Index: AQHY6ffdJD/5Oq16AkSmf/jVUKUJTq4iJNOAgAAGMICAAAOMgIAABaeAgAAPG4A=
Date:   Thu, 27 Oct 2022 13:54:28 +0000
Message-ID: <20221027135427.n3f3v5lhuqwisfik@skbuf>
References: <20221027113248.420216-1-michael@walle.cc>
 <20221027120519.7f3xun66l4lamcq6@skbuf>
 <20221027122727.fhs35eqtzmeen6x4@skbuf>
 <20221027124009.mxfcyuayfv2snqf5@skbuf>
 <be6395ef27d47b16c3ea9a38e31b4c88@walle.cc>
In-Reply-To: <be6395ef27d47b16c3ea9a38e31b4c88@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5136:EE_|VE1PR04MB7326:EE_
x-ms-office365-filtering-correlation-id: 4a62d106-dfbf-4ca9-7b7e-08dab822c427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bnXnzTtR7FPj1n/3j5yOiz4eI68/Cb/4OEwuBiTv5oWcQKHE54VQBBslgqOTKOzFQV62wC3GeG+kg9fuJpiDvDudcmAIv+81R2PSrFo4hFWisITFM3R2A50PfiY8PdI9ZaWmyf10dgJbIKtgJpjdUXltqeWQI3BHaQEGF5HBzrzlLH/QKbBP/9wMBGzGZq/JOz1lfXc6DFKZOI6BlnJPdHwYwAb/FI+BY/T3B64d1p9DAS0K9TjEsfbCEMTHwtAF/I9FJRd64h0tFYSGe2IwAmaZaBKnNfyZ4xtxQ+1zLnovnj4xIBBrOk+E5Hdn6YJuA4C4wCzgZy1nseMr+8LDXtH4UfoLmI65RJZB9G50NpkB89A1nTFfzNJwPSR69Lf8cmrA+2is99fdRRLymKig+llGFlIU94Rp5P0KOxAQQ+/P/mop9hx6cA3AKOXsXFku6PDg/ZJ5bAhSWCLJA8jN9wD0OCWJVzFgPmT/W6fOr0w7/IiRL37EXTp7wV8LqQ4X6yuGqQNZl2gt/XHKEPWxtbT8CxPX1pcF896tfcGLvT/bbySU5OTAqqCZheXUabMN8nT8XEMeerLRyDrSLD13a6PISKXamuTwgere7bo5kWcmyoyl6UmLzMzNZHY1fmpTqBBXyNRgGN/Hs+IbbEVKGayBGSJqxiJBnkFElxHv40KjQfGWMSbEBNdUUIlJdquZtCVj90IIDyZRhF3Dgrk4AanmZozoIqCQI93QRYXjzm7nYpQr+FhJO6/Ujd4cOlF8//xvd8CxOXE2AwlifhHPDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(478600001)(6486002)(86362001)(76116006)(83380400001)(71200400001)(66899015)(8676002)(66556008)(66946007)(66446008)(54906003)(6506007)(4326008)(9686003)(41300700001)(7416002)(26005)(8936002)(5660300002)(64756008)(6512007)(6916009)(122000001)(2906002)(44832011)(4001150100001)(38100700002)(4744005)(1076003)(186003)(33716001)(66476007)(316002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PnazZXm25mcb9JiouyxBZ3DAPWloOVhI5SH5nPNInnpnvjnJR0MhmsxlgDIx?=
 =?us-ascii?Q?72hUKslTnHoBhXCWVwXVd225M8bEvq5OYXOCuCMxOBpD1pp3Xo5KD2bG7OAr?=
 =?us-ascii?Q?u8LEhw+4ZUyN5r69lhbGAyexu8OEG3Ie2A7N2uXwjU5nzuZQGmo1tmAo5vi7?=
 =?us-ascii?Q?OyTNjHdYAYMKkKPEjCZJobRc91pNQhey3C3ecIyuatdKuVlzPhEV2Z9Rs4ns?=
 =?us-ascii?Q?RcenOlZlClyOLaVTl3Nqpf8iK0b3bnEFsbzYM9QfsSBm3Z63flErzbitL9Vj?=
 =?us-ascii?Q?n6uVEQ2fJRdHV7IONpiXE2uhQV+y+8qqIL9F9AC7QcfEc4s/nx+AGW75BiSt?=
 =?us-ascii?Q?SfHQU9LP9MMqO4zqIFpuLKONixuPQITa6y2JxrG1rkWlOfZIZ3XtayKupM35?=
 =?us-ascii?Q?ARwAzNzuM2Ge8XqToQerg7C2XGs5KRd7H0OVM6Se9OvIYlC/DBZxLrmmEELJ?=
 =?us-ascii?Q?m6otFC/nc6a7WCM4rjt3O0Hu4bDNdEnB3bfOtr/p/XBzbixS6FPW4kntb0G8?=
 =?us-ascii?Q?+fuX3wXiqvys2PKUo4MPdyUh2aTVixKFfvwPkuk122dBWC/he7gNGDdm8NR7?=
 =?us-ascii?Q?lBXzVoTG2Ztl0BwHdUda3opPu+Ok8sNILorL2veuiT10HrfW72rm7993K/4X?=
 =?us-ascii?Q?blrR6halcJOeC5E+N3UW8KPWLrLdOw5zTm8Z7Q6j7Xe0fWh4WwEDqzngbrPu?=
 =?us-ascii?Q?eDM8Q2BQ29uW2wCVb/XeCJCdMkFjTUS25jQWRbPQhE6M2Yaq4FY2mQ152/uS?=
 =?us-ascii?Q?4NkNA+RKo8itVh7yCVRP1dMwQfZ09sjzrR+Xgehc7iw2shuN+pziG0j0U4EG?=
 =?us-ascii?Q?edphkcPGb0Jd21g7s8xd1DTIPYqQA4MEQmZtIkoHfANIzOoIenHibAn/Xj0x?=
 =?us-ascii?Q?hcF4bpHlK1L546AseSH3TeUYGKh7nPp4tvAsdMKGP6IES2uwa9Y4wfsV5Dmk?=
 =?us-ascii?Q?ul/UVPbG3Vv28txOIUtCgeDIliKYzgwD+2HMiMdZtfE14JYb2vnOf88gnrCq?=
 =?us-ascii?Q?st0ycA+qPBai/iYn163wgTZdjzhWnI3g/GhK15d2drU2K2PhvDoLcmpF+vdm?=
 =?us-ascii?Q?BdcPQLVnxQSYpT55aZAg0wobnxHvjG8aG0600x/qXZONgYV+5QZ1Fr8uXaDg?=
 =?us-ascii?Q?BGKsQKGV6NJa59yqVa0lHQRroSdSTzAYJWoYy7MUhMZq/nGyXmldzGy+gkML?=
 =?us-ascii?Q?eTCfv9W/BfhQqMZ2hIZb6x352MIZBTpqj/Y0GLF1t8OyTckNyU8aE+LWZ12R?=
 =?us-ascii?Q?xeNKgiujw1qtmSNkQEA7YYdxArp8UTrWE559kY5nbrA0Hbt3eb+ibpKbuFJC?=
 =?us-ascii?Q?24WzJkZwaOyUe9+wtpnbzWXjMBwOspQ+L+Wyy5cRPJhjRPFXb8JYqZUniWjX?=
 =?us-ascii?Q?BVxktK4Eu+YvlrCtcp+XgxZCIMWVKlUQS8CNAZzqdYUJqkSFkA9wPi/HvJ6C?=
 =?us-ascii?Q?o7jnUNyg+widCwUbr9uBhycuBiKGRV9uGMprFTxDWSXbNZIhJkLqUYtIIEkH?=
 =?us-ascii?Q?ObZyJ1nRXlu0HMsu+gf8I2pGMobtX/TK/bSCikiDCNs2xK8PGaGwMUicCcAl?=
 =?us-ascii?Q?cyg24fPKEbG3pNOMhRwHWMz7lSYidxfNVlN8rIQoqxpnt1/vZS9j1+1Clc5o?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BB3DA7F749A7F47851B1173C4FA9AED@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a62d106-dfbf-4ca9-7b7e-08dab822c427
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 13:54:28.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: El4SjNz03U1oPASH28O6IpOgQtKc8HVrbsvrzsBR71WhUgU7M25IfxRhwoWg/QBAJdelQWOor0zOnX266zGMcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7326
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 03:00:23PM +0200, Michael Walle wrote:
> Am 2022-10-27 14:40, schrieb Vladimir Oltean:
>=20
> > Sorry for sending so many emails. I think the problem we should fix
> > first and foremost is that, if there's a user protocol specified in the
> > device tree but the kernel fails to load it, it should simply stick wit=
h
> > the default tagging protocol, instead of failing to probe. Everything
> > else can be dealt with as a future refinement.
>=20
> Sounds good to me. Should I come up with a patch or will you do it?

I'll try to prepare a patch and copy you and Heiko. I hope to do that
soon, but I've been running with hardirqs disabled for the past week or
so, and as you can imagine, things are a bit crazy right now and there's
a lot of pending work to do=
