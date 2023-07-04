Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E21747594
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGDPs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjGDPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:48:25 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2133.outbound.protection.outlook.com [40.107.113.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB6DE75;
        Tue,  4 Jul 2023 08:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSo+QYzdkmpf3OtSBdXG1NxYKWwt5s0IM17qxreo/9YcXc2IU9PojF+3+rULMj+QgUJDWzZLNdiOJEz08oubYcPxN3ShAgBjBhubYYHmsVK/eVU8/tk9qlBdvbV7ESUhGiLZ1an5N5EzZHkE+H22e/ndzWFpAOpIyG21zd0jTdQ+aOxsD7ZdGg7qIv+MjOstsKxjACb/92RaEMsYlb+bXIeqmFAJ8LGyolmDf1ymAV1luk2zt7EwmCpkLi+4MqzbYWdWNbfD3CX/C4ov5pfxut0A9DUooyum2VLuxRZGEh/iCZVfCXlgpwXrQA1Roe2sc5GEqYvIOoMZ9dVsz1WYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cemzXT3Z98xHwyC3QaHasDaZyjiniWrg6jJx3bRuDs=;
 b=gzNmbOFEnrX3Zvi1t3Mr3B3ZCoCQZKA9VlpCnZdgsbQQxES4vwsNJ6+lvPZgPsmSmg0vfRkr3QJTgWPi/WHtmUbPM37+vM6CU9xKukoV64Tarsc2g/Tb8ai/OEx2mkeyarZYPSL+RskWDTfAOeKG5QVJFmSeUwyKIfgZJw6lWsBn7aWL7ErLDFMtDFkkf/SXX/OPJnFgLKj2LNaELFAzURUP5mPjo0DRk04MEDzpCZ7hP5XkJzndKDsMaQlQ3Dw6M/rQSLOp6y0HUJDlvCl7SOYOvlJTVTezwi6/Pp/bCQxRpNxsus31l0mhLUXzkXUMrkxuxVMuihIFr9xTE6L0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cemzXT3Z98xHwyC3QaHasDaZyjiniWrg6jJx3bRuDs=;
 b=Sj6YlwhllBHtXwOn88Kw1n6G4REcrLHaAfM9dtbUBjNnS3lDF17HaQS9Aiw9nLL0btLDq8DBUoILu/IKAn162NltwE/v+pdRo9/5sEaldCtERPfbEQ80KkVrnHpHBAo/ljUGnzDls8j7iUU1n+tRSec+xG9immOaYXJ3XuZeTb4=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSRPR01MB11632.jpnprd01.prod.outlook.com (2603:1096:604:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 15:48:20 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 15:48:19 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode
 names
Thread-Topic: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode
 names
Thread-Index: AQHZrcAPb0TcFA8ANkaumuYwU4cr56+pwgQQ
Date:   Tue, 4 Jul 2023 15:48:19 +0000
Message-ID: <TYWPR01MB87755B1EEDEA676237009CF3C22EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <607bd6ab4905b0b1b119a06ef953fa1184505777.1688396717.git.geert+renesas@glider.be>
In-Reply-To: <607bd6ab4905b0b1b119a06ef953fa1184505777.1688396717.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSRPR01MB11632:EE_
x-ms-office365-filtering-correlation-id: 0ad1f6bb-a3e0-4ee4-7e15-08db7ca6173f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFnVMVcM6HMIDtKvdlDOTZgFWY+BdNa3re0u7lDe+Hi++x4hSH3j8vr0Z4jvA6SH+qoTZDN+gJCrjFbNYbdk5krK3X2BBLf+NsOl3BloItMaNQCEfVHZNaBtq8nIn2DtEMHF4YylGhIyZpX8rwao/h1y5A310sGqU0lq3ajIz2cgOqj4xcbEpyh4X4vQ5nmG9lwXQsS3e8N1XgafmxXT5kZ7Q2iMzeV1xWhSZ+q+NaQFUj+ZisJYIQbMyO6ZK6WzPZTg9ofcMtNSxV/ymXp5vUo8zK1bo22ADWr6WmfdHmAB24b8BsG0jJofvqqU6wsJgj5tPbJgymlyu9lNgMqIbG0iJ09AP/ZlX8B3CVIF/I1QNBDydAJt9UZPq7dHHZM81ijwz2WOlEZKCZ6u/P9Jr4F4IasbdMMIIRMYitYNMpMqEGWdZwNX0lAXggbBV/huL3CBz7HFlY43C0hMENuamBa5OlfijMqDeOsX3hcgruzBAtl/9uWWMpfeFnDOP9w66wv3faJBAekHyhkJFv3io68T3FSsaeFhMHZQaTrOEKu2MfCSlCXNLwvcpwGNVd4VNymWJkcGcQD7JEgnEgo3F1Bu+bfIpbcI2R9jQCFeWxjrDBH8Z3kVXw5ddBwY3lac
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(110136005)(54906003)(2906002)(4744005)(9686003)(478600001)(26005)(33656002)(86362001)(7696005)(41300700001)(52536014)(8936002)(8676002)(5660300002)(71200400001)(64756008)(316002)(66476007)(66946007)(66556008)(66446008)(38100700002)(122000001)(55016003)(4326008)(38070700005)(6506007)(76116006)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pCzxOpns/W0ZPBJ6dkdwOusYppybJf5BFBFO4UZa8IZVZjj9HcyaKA2rWfBv?=
 =?us-ascii?Q?ks+9lzXLBIuXCIyxLGRyqGZs8ZcDTsyYPXEFKMLOLgEmAamzP4ik8spMZXXq?=
 =?us-ascii?Q?qCzfEGYnGEe5olQV88lT4SgClbHB1A8lDEr0OeOdiUhdn63wYbto8lYIAoB2?=
 =?us-ascii?Q?UYEuAKCh2ceBMBg3Fhq4NkBri6e2kvBB7KKeDfmxslUtW4DR37dae4he0ub/?=
 =?us-ascii?Q?TwCrz3Iw5P1M8sb3l7bcW+lChM0UnHlZg6uoNIdv5fF9aTpvmuL9CqR90CNe?=
 =?us-ascii?Q?KBpD9MBXLt/pQ7T1XUSw+4AUO+3f9JxisnlxqHE9T4v2c42SN3Hg0mwgtX/m?=
 =?us-ascii?Q?/cvk3PzURSx8fU1xj7VFm4F4VVATfz2jJYd/lYafj4yhiuR545I4bv7AwsE+?=
 =?us-ascii?Q?3VNtI/uolBuU1vzfl1gak2HzTxUROFHlbL+JIiuZfo1pb3/sMuxjELICcPak?=
 =?us-ascii?Q?ybekf6D9ssR1s6cr2W7I0DCazmapTrDp4x+x9BlqfcOx6OmdqHi9pNTa78lE?=
 =?us-ascii?Q?GwoToDyupg17RkKZPqbL512ACoFHwpGaRSshOS/7HBj4Bj3E4X8FRKWKpYSu?=
 =?us-ascii?Q?4EdCLSpotAJ0vruawThy/7mnC1tTJn0Wk4XTRsUy5cxwhVDGcqTQT/SNKWuN?=
 =?us-ascii?Q?r3fp6r5fD5XxXANKTq8EzJ4KvjkkO/rUAj/8c/UvfJ1hxc8kV6Q+2Xr9RoYH?=
 =?us-ascii?Q?7uuwii9cgALhAomtXcm4cGrwLnW4mK/NobTjV5fXOmDrSWdRqGdVt80WAFgg?=
 =?us-ascii?Q?d9hiGjNGXOp0L0SZheu0GAcONr2Xf/Eah/noSWupYqlcNO/hkavZVr8bUFK/?=
 =?us-ascii?Q?xooh5JBHVFqHFarnQwdMNdebWskRcQtBMShA9tcYUSo9bwzEgQrB+EoANEsZ?=
 =?us-ascii?Q?P4Lm7VGurBGEee2PT7n/gOOxhqXZaPWtNOoHvstkfg0DrZlkASrPiS7ExNsT?=
 =?us-ascii?Q?EbEG5vtcCxqjup2gYH1rPuO+ZZEc/mXECv55vwHYJNdb57FtPGks9f3a4scf?=
 =?us-ascii?Q?d8ojFGXNo/Zo6PkoR3NnZiCkqECq6nzCfTDdSjUx98vKMk9aECyD6xZiE+oy?=
 =?us-ascii?Q?P+FVV53yFsvBDnTESY03yAaP/Qz2LbkHa0t2A0Tu0XUxZVx4P3lfR/PYyAJ4?=
 =?us-ascii?Q?1u7PRzcngBroUgMDmDuwyyeh+UgYYpBC5SDp66ZJV0FdZBNdNE6DmLqKG0AB?=
 =?us-ascii?Q?AN5f5hdurpkKu/95LoVWcOc+UH8ID9Sq3yFZTY7ryfi6ycAoAya7CJ/mjnCJ?=
 =?us-ascii?Q?1kGwcsviP0C0ncwZ97Xcza29c2n1kk5sh+vLDumt5DJ0oGOJwe74cV7YkgKd?=
 =?us-ascii?Q?frFPLkPb2DqCJKeFHwci4U5fYdNGT/H/OVQVbbX7d+j+hMWcjtCr9LDfuX4Y?=
 =?us-ascii?Q?QgiTT+/kYWWZlXZG7HmLvD8W8AOIDGoZ9u7twaeGu962chzxKpgJhN6gVzQ8?=
 =?us-ascii?Q?znJR5NLel75KsB3iFIFyLdjILev2cxKNO8Nbx2QCjDO/e1smA2wlR27tHG/N?=
 =?us-ascii?Q?exWWTeJmu87JuaHErSfaCpk8pO0MFI/MXQ9yPcDlfZi9546Xc+2aZBBiUstu?=
 =?us-ascii?Q?qNbDvAYwgU2vAi8HPJQTcqfs5ioEqQ2kG181A9gMFnKvXVnyc2FLWuMyRnoq?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad1f6bb-a3e0-4ee4-7e15-08db7ca6173f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 15:48:19.9152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/Co9AjbE7DwctAhFMpnS+XeNweRcnyganm53t0oEvzR7G+MgCkRgixyTyNJ75EjcWe0n8T6xiNeJCHolHyKRqb5fuXCaBFfkL0Tf+OlLqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for your patch!

> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Subject: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode
> names
>=20
> The eMMC and SDHI pin control configuration nodes in DT have subnodes
> with the same names ("data" and "ctrl").  As the RZ/V2M pin control
> driver considers only the names of the subnodes, this leads to
> conflicts:
>=20
>     pinctrl-rzv2m b6250000.pinctrl: pin P8_2 already requested by
> 85000000.mmc; cannot claim for 85020000.mmc
>     pinctrl-rzv2m b6250000.pinctrl: pin-130 (85020000.mmc) status -22
>     renesas_sdhi_internal_dmac 85020000.mmc: Error applying setting, reve=
rse
> things back
>=20
> Fix this by constructing unique names from the node names of both the
> pin control configuration node and its child node, where appropriate.
>=20
> Reported by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Fixes: 92a9b825257614af ("pinctrl: renesas: Add RZ/V2M pin and gpio
> controller driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
