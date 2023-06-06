Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C96D7248EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbjFFQWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbjFFQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:22:49 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1399110C2;
        Tue,  6 Jun 2023 09:22:48 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356F1eiD030721;
        Tue, 6 Jun 2023 16:22:32 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3r229jsu66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:22:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDFOvp2TChNX8bmqlg40j8WiGQkg77WASrnvks0pOZylGX5t9lmpFiI+fYDxAcmdloyWBaAtroSngMJY1HJJx89JBRQyoFu4hPWdkJowpZU3ulPhcw0QVHzPpMyKmJXwa4oNRnVnVa7c4rIlkEu5vXUssQYCLLriBG9OA4DqzXRpuhl0o6ft7i7ONa3Rg4YvDBMM8chjCEWObyNoqIIf39MKStPJ8yaE0S8gyncEJzMf8Q375ssdCGUHR1AgU4v/AMt2GYz7Quy66iPCGqaJ5fKMWt3RAM+3wVLHLIblpLGVi4CKYuBql57uDQsNnv4956gOU7WBoJpeKv3EHOKNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhKwUeWaEixCcsDny+ro3G7Tt8KymGi3OEteRLsq8tw=;
 b=hAHxX28Ksq5VH531dU7lbTGeAzAj26B0v3VeRruSsSCjdQLteQxALZHk562di8cIKRZzf0A9WT5JpHa8NGmtC6phzyHPJvgk45MyIsqn4nb7HTXC1U9EIVBJejeZ2Tl8jAnvG3bJ72sGeGZk2HQ1A1o2Y2JkVOucudZQpikklfpcf9zgzLNNvR1LH6M2d6BZ3p9L0lM2i4Goiuq0gxXldYN7QPhmX1Bq/oKuWl4CeExQgMojKmj71K1vCX40dkeHAxo6XlErJNaoLOVWOUghAS3MSJOF3Na44l0raISiiN4xtp89qck9zqijydFAgr2wj3thou76jz4UpXlt2RT3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhKwUeWaEixCcsDny+ro3G7Tt8KymGi3OEteRLsq8tw=;
 b=nvSJIz+xCS7IMaZ+Uj9ihaovBTKIYc6txpabU9FZBa00NGh7MCOy10iYc9q3S0tDd94FSTyHI4oKaylk8uSFR67Gy7p6HDa1Xec1S7SBnSeYtO2JnPGWY3Y3UWdkMqwnVTw+x74hNj4mO1bz6bQh+pWwM3EiAqUjGdauj8DHc/Y9E2mdCCEWeA5aOMm7oIQMO6+4bsu6K7nNboZlZiKc9UFtbzzbnEJy9EOzqvOjD9j2Ivld3hwENBAmeHmHFtMhBD15wE5Eg/8TgnJN9BNTz3msL8DMCdS7OZQXnCRPy4sVOQyVKfzPphwYalTDGfCXx1oLyEldVkRJS/PVaxhscg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB4PR03MB8708.eurprd03.prod.outlook.com (2603:10a6:10:380::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 16:22:27 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:22:26 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol
 basic support
Thread-Topic: [PATCH v3 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZmJMVbH1082dFzEWEKtwTiutfEw==
Date:   Tue, 6 Jun 2023 16:22:26 +0000
Message-ID: <cover.1686063941.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DB4PR03MB8708:EE_
x-ms-office365-filtering-correlation-id: c5473357-8a86-4ffb-e1c4-08db66aa37ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+rFgkpSd5EjNYgOl+RIvFyofeq8p6/aGyTDM9WprdAa3Ki2CFgLxppOzh+3DS8+iCwKQZ39IWlozDxGJEr5eijAMMV2b8W4TbJHK2A3jvCtuTrUa/nx8b3E8ZWQJ4+C0rFqI//cz4vN0kdJIwC7MECFE3EMdZaNotnfjgFBjth1nnftsi5DbppAz1WWjiYlz0pQ/tMbsbnON0wXLpIlGoRdyG3BjNzx2VdXFhaC3AYr4DZsv2qs7OW4WCYB9sAVBPVXQe58LmxK9VAgjKCCa2DS08sxg2zFBvCO/YEC1umwVyxH/KlPaowV+qHSnAiVn1qpndsZ0nBvulBulPJVS8xi3+3jK8LTB1simoDjutYyaOerPMaYyw6GZBGMdUUytVfqpYBmX8zkWxYPjlHeNiGdIFx6ZFN19k8Keqfh8EfhqS8/S2qrZD1XJKhLnFFnAVgHHIXDsr6lqcaSXufiHdy2DKx6A4JCyEkXN/m4bLTtfETXjff/4lfbXagEJdlwoiXRGIBne5P1zRgxRCTno7NEaoYdB+fmBZs9RvNJWrlvUSrWehMFWPW61xoUK4ptveDYAgesuW71p3veGvf509BNS7ZEO8YOocv/JNciTT8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(6512007)(6506007)(26005)(2616005)(966005)(83380400001)(186003)(66476007)(66446008)(122000001)(66556008)(66946007)(64756008)(76116006)(2906002)(6486002)(71200400001)(8936002)(38100700002)(7416002)(38070700005)(86362001)(5660300002)(36756003)(54906003)(8676002)(91956017)(478600001)(6916009)(316002)(4326008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fg7jPNHw85QMLefyLQ/ThFRBsGfJZgzDA1FvA7feUAivDmsBUJU7u32YFw?=
 =?iso-8859-1?Q?kBbm4yIaNM4FBkGeOwR/74M3tDefyr0m/zdV15wtTPkfp3mNaoiOlKAYiz?=
 =?iso-8859-1?Q?Cs9ugMy8TmrrEJd4ZO51PwNcEgyo74hJK2+xQYFnOb2dSyGN6qAB2jrKqs?=
 =?iso-8859-1?Q?QQ0hkPICFnDh+Dmu1LVuCaTsAM/q+PkjFh9ArSi3PQBeAYkcMX2V7axmkw?=
 =?iso-8859-1?Q?e3Tc5gXXd6aTtmPz9WMyiDdAerD9uBSIeBnXmHHcFbSPlC91WnjPvoBRBL?=
 =?iso-8859-1?Q?YkTST8npUf7WIWEnX0LYxvIkJvl07wDsG+FzLU0pbuqCk2k4Pi90S2rSaa?=
 =?iso-8859-1?Q?RxR/ib/g/IklWOCTvMpZXDSdhtLqDwvCR0nsgTrmj8CKCSbUaYqq6TnXc4?=
 =?iso-8859-1?Q?jI4OOuWKToVOPm9nceKN6dZcwIm5mrG56YU0OrdnRg8KVjMq10jg30SfdC?=
 =?iso-8859-1?Q?Prqaq9F7UUivvWBFMJZMLbwVRtvZzfGDMG1ebCMzHXnAW2zxgpwJGukbuW?=
 =?iso-8859-1?Q?ifAAcPRp5OYiNhZWh+7AWRGMYxIn1Se0xErUgk20985xp8batUk+IP+T/7?=
 =?iso-8859-1?Q?IOj4V/kbK7a2f4UFLsYkkMyLYGZHlUCaA/CCa9ri/ImwmktjjXEG3Ty9p6?=
 =?iso-8859-1?Q?5irHhNar7Ksx+nNCp+BH5vCFFhT6ksX7U5EOV1TxbqXCkkf9OX9h1XW3M+?=
 =?iso-8859-1?Q?3cwMMCW0jrHyI0WK4feEOMj9A7T0M1kosNvI3wA9pksrUeq3DY66sX6bCs?=
 =?iso-8859-1?Q?ibwmjzAoD5kJIbJLiFFmFmixRLsP/4+aWv7CKyuLlc2BlG6hE6nQArTYCL?=
 =?iso-8859-1?Q?t6/DRT5fGsodNQRpSKTojXZSzyn7P6A8FAWwT/mRHIqomBVMEcGvSpnvPL?=
 =?iso-8859-1?Q?4pwV91VgVImNcrUZmFCxmcjF/d/GPl+A0hrYdiaE4dlp8zHNQeHDaubD0j?=
 =?iso-8859-1?Q?5AHD6fjxxPeTOXqpuZc6nKtTZLG7OxBTpus3ZaBupyLqeOznrs8EypBcNQ?=
 =?iso-8859-1?Q?l0PWemywaQd1d0uUiGySK9rrW5SxnL6lgSRFEK8l/eQ6xE3W7p7tFC4OL9?=
 =?iso-8859-1?Q?oxAhlrBAp3O1+KKTL7U9XKa01pcUXVMAyW2qLIyBM3+7/ejDIC40ItpByd?=
 =?iso-8859-1?Q?ikJqUS/QJI4V5bSRIhhLRSJZ9KMHpqRO37v/qlaetm/BP1rE8mzlPuzrAJ?=
 =?iso-8859-1?Q?lanlZD8bYfRGuI0wbeqtKF1FaT0CjfL9UXRULkiT4qyhgJsqNFKkkLkwAs?=
 =?iso-8859-1?Q?ElObAkd6DjbKRyBPI9K7kdnN+0NY3hN2qMl7WTylI3J/P4v+8hsZ4ssRlk?=
 =?iso-8859-1?Q?zOqrOqI7m3xu8wlnH298qpanrDjVAbD79vSSvhXclKzXoZ6qrpr9seErEt?=
 =?iso-8859-1?Q?sa3l+VAW9ylf6Xz73qpwXntWvnc5gL7flytKOGdVIEKqzSnOiEtH7bufXQ?=
 =?iso-8859-1?Q?p0EyXuogwXWdtZMQCRXZ2qgPwyx0eRIOdVHlr3aiAXZ/4hW2DgeXx2kF3L?=
 =?iso-8859-1?Q?Pto0yMAyAW2JrnSHyPcv4qUKhHpLfudz4wcdliARFI6Mkhb4oFAVaojeL7?=
 =?iso-8859-1?Q?INZoiVjHV/eBJ4nQgXeciEClxGa9F0ef7Gc8D8QMWjoV1PonSXvjjN+8mo?=
 =?iso-8859-1?Q?Gw34hSktNXqb7bjOVh7NKYjCEXOW6XA9XRzivBD/OcSN5CYRo5usL7pQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5473357-8a86-4ffb-e1c4-08db66aa37ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 16:22:26.7665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UaygiOUzVy05/8O2bc3Bpynx1UNX745EWSgdNz51fbuVLlndroc1I5+BxgWttzLuuQDnk48sGll409EtBhbT/KLWhPDVb44SLlSTAh3Gslc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8708
X-Proofpoint-GUID: RFMnEgtMefOGSjPO6Et3TNmK4SFe8XD3
X-Proofpoint-ORIG-GUID: RFMnEgtMefOGSjPO6Et3TNmK4SFe8XD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch series is intended to introduce the potential generic driver for
pin controls over SCMI protocol, provided in the latest beta version of DEN=
0056 [0].

On ARM-based systems, a separate Cortex-M based System Control Processor (S=
CP)
provides control on pins, as well as with power, clocks, reset controllers.=
 In this case,
kernel should use one of the possible transports, described in [0] to acces=
s SCP and
control clocks/power-domains etc. This driver is using SMC transport to com=
municate with SCP via
SCMI protocol and access to the Pin Control Subsystem.

The provided driver consists of 2 parts:
 - firmware/arm_scmi/pinctrl.c - the SCMI pinctrl protocol inmplementation
   responsible for the communication with SCP firmware.

 - drivers/pinctrl/pinctrl-scmi.c - pinctrl driver, which is using pinctrl
  protocol implementation to access all necessary data.

Configuration:
The scmi-pinctrl driver can be configured using DT bindings.
For example:
/ {
	cpu_scp_shm: scp-shmem@0x53FF0000 {
		compatible =3D "arm,scmi-shmem";
		reg =3D <0x0 0x53FF0000 0x0 0x1000>;
	};

	firmware {
		scmi {
			compatible =3D "arm,scmi-smc";
			arm,smc-id =3D <0x82000002>;
			shmem =3D <&cpu_scp_shm>;
			#address-cells =3D <1>;
			#size-cells =3D <0>;

			scmi_pinctrl: protocol@19 {
				reg =3D <0x18>;
				#pinctrl-cells =3D <0>;

				i2c2_pins: i2c2 {
					groups =3D "i2c2_a";
					function =3D "i2c2";
				};
			};
		};
	};
};

&pfc {
	/delete-node/i2c2;
};

So basically, it's enough to move pfc subnode, which configures pin group t=
hat should work through
SCMI protocol to scmi_pinctrl node. The current driver implementation is us=
ing generic pinctrl dt_node
format.

I've tested this driver on the Renesas H3ULCB Kingfisher board with pinctrl=
 driver ported to the
Arm-trusted-firmware. Unfortunately, not all hardware was possible to test =
because the Renesas
pinctrl driver has gaps in pins and groups numeration, when Spec [0] requir=
es pins, groups and
functions numerations to be 0..n without gaps.

Also, sharing link to the ATF pinctrl driver I used for testing:
https://github.com/oleksiimoisieiev/arm-trusted-firmware/tree/pinctrl_rcar_=
m3_up

[0] https://developer.arm.com/documentation/den0056/latest

---
Changes v2 -> v3:
   - update get_name calls as suggested by Cristian Marussi
   - fixing comments
   - refactoring of the dt_bindings according to the comments
Changes v1 -> v2:
   - rebase patches to the latest kernel version
   - use protocol helpers in the pinctrl scmi protocol driver implementatio=
n
   - reworked pinctrl_ops. Removed similar calls to simplify the interface
   - implementation of the .instance_deinit callback to properly clean reso=
urces
   - add description of the pinctrl protocol to the device-tree schema

---
Oleksii Moisieiev (4):
  firmware: arm_scmi: Add optional flags to extended names helper
  firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  pinctrl: Implementation of the generic scmi-pinctrl driver
  dt-bindings: firmware: arm,scmi: Add support for pinctrl protocol

 .../bindings/firmware/arm,scmi.yaml           |  53 ++
 MAINTAINERS                                   |   7 +
 drivers/firmware/arm_scmi/Makefile            |   2 +-
 drivers/firmware/arm_scmi/clock.c             |   2 +-
 drivers/firmware/arm_scmi/driver.c            |  10 +-
 drivers/firmware/arm_scmi/perf.c              |   3 +-
 drivers/firmware/arm_scmi/pinctrl.c           | 836 ++++++++++++++++++
 drivers/firmware/arm_scmi/power.c             |   2 +-
 drivers/firmware/arm_scmi/powercap.c          |   2 +-
 drivers/firmware/arm_scmi/protocols.h         |   4 +-
 drivers/firmware/arm_scmi/reset.c             |   3 +-
 drivers/firmware/arm_scmi/sensors.c           |   2 +-
 drivers/firmware/arm_scmi/voltage.c           |   2 +-
 drivers/pinctrl/Kconfig                       |  11 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-scmi.c                | 554 ++++++++++++
 include/linux/scmi_protocol.h                 |  47 +
 17 files changed, 1530 insertions(+), 11 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

--=20
2.25.1
