Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B076EF57B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbjDZN1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240791AbjDZN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:27:04 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25552195;
        Wed, 26 Apr 2023 06:26:59 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q9vWUE011543;
        Wed, 26 Apr 2023 13:26:48 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3q6uwpt2nb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 13:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGOWEjJaOx/ByduY/gusG9/dqPH+LvN54SpvG0fdvF0hKwk180ER5QOxXecqxNextj5n0G2r/ZfYXjFRVoGueNben42ICs7EQ8bh9MgWMSTHPi3h0vCa4NU88IHniCBfc1VOiTDEWT0HI4brAnMXJwiChdO83qXE79FssKaJZiKEoFTlbTLimakB4XdUCAmitYGX6qI8nvFVEnpOQaNsbEf+kFEUMjBs5jznZrZSYXcEflAA2i0fVQipFPQJnOjeByUkVYWTyQaD85cPJfCFJHJ3HqzmXxD9i/dqN+yELeirBhYi4xopKXhjzOu5iyjsVpphn7RFeALSaEWUOrtl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEezjuWroQgRzMttKIAme0+0J/GqYCEPMpvnydczWR8=;
 b=a26OiqYRdfHDZdXkhDAtv5RTTBIDDYsyRSK0vR2qVJ/scPT7Hu6xLvghMa2xsNzeTyH7JqKK8OGm9Zc6FZuUR5jsSJrw0qQjYA6PpxY4t5drSrP67FEA69QNVQcg3ZBwBfOH7DqxCymGjyPqAyPMY/0Olq+6leHJsTMPcFaXzN7YhaQh9YtH+WJ1oCGvYa4bhZP/x1peUTH26yJT/ZutDMyj79LgFJZq9/JUBvkDW6hx5xUExClzk/GZIdZ3V6KZVj2ZGlDlhsNWe80TL0ZNV4/MpGKQ6LgIkiuQDcC52u6kDVzbc459uJl403qdTb6t3ayRZlGXHH5pQacpQhkn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEezjuWroQgRzMttKIAme0+0J/GqYCEPMpvnydczWR8=;
 b=htFVE6rkhxkFPybYBWa3GRReE8jiZkUtepT33rV/ipxez1jW/tY6qFaTHJG+1WKtQ1QQXP0C29roL5vPvwF/sMJOQ2ff9tjVp3GJ8PlvQMQZyxuxxNtCsu38AISXAYGhPM5a3qbJSjc4FfW7tp77XKTurnHyN/tKFdn4WdohoO1417ewSarU5+Npz159DUqtXFdtlVhCgoD6aWYU1VX+a6l2vspzUolsa99q+P2HwpkJQlxtV+GXCetgNsz8h9o3PFQW8WgcQk+8bkxE7Y9KIf9cUPJ33Othh4/3T1rThbxHsXQYSgNM7SXS5uNL/Q6ibvkq8ApipIIuep3Esb6oxA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB9380.eurprd03.prod.outlook.com (2603:10a6:150:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.54; Wed, 26 Apr
 2023 13:26:37 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%8]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 13:26:37 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [RFC v2 0/2] Introducing generic SCMI pinctrl driver implementation
Thread-Topic: [RFC v2 0/2] Introducing generic SCMI pinctrl driver
 implementation
Thread-Index: AQHZeEK6Mgluo0v6EE2yyMI0Mpfhqw==
Date:   Wed, 26 Apr 2023 13:26:36 +0000
Message-ID: <cover.1682513390.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB9380:EE_
x-ms-office365-filtering-correlation-id: d741b8b8-23b8-4d96-4671-08db4659dc9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZjH5sMQFn4QTKJvTnBB9eqKwFjuLuPHXB00xfnFv15STnvCM5scZeSXYzW4TQRrgVeHd6Cq/sT6F6j/xv8s1O2SZ+gveXAmX7nH60HC77aNAurVa3GmQGNHoEkEKHvwZ4FJTM9LKpenxjON5eSzaYuzinL8L9XyOTPN3eHtHSwbCJ3aDsdJY93GzNJltgIkRVNrS4tpjiXwVfTeghQUghURI7egdhHzMS8cL1MCORkp+tC/Tmn9LvGgcrU7v/iEAShJCHtRTqXUHk1Q9MLG0A3xq606Bgg4UT4w51X5kPIiFipO7wGilNlITb0iyD52+DMNI3F90PPxOxnuHzkR2/pHRMUUj58/k5WeOPKnSykOb0xUuP2172QRDAeX6/NRRItjHaoL5tuD2dVZn9gOCYUEjKrjgNV1JDUIS05nSQOaBAx0y/HKRsIt86/LvbZSaNf7hr0fKIDYUkJ5AJrD6UQm1osR1btrF0mRGZuN38c0s5+tYiy59SONwbr1bY+Y96w9//r/+PHLHmRDeA4LiPafYhdECf+6/CSxxV5z0S5JTt+9DnW402WNTbOO5QMB142YlzK+SF3O2vBzZRxNRHOWi6ICaP2xG//OBoYCY+NV+0jCNo4VmfSdRvNUraWS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(8936002)(2616005)(122000001)(8676002)(478600001)(36756003)(91956017)(966005)(316002)(76116006)(66946007)(71200400001)(66476007)(66446008)(41300700001)(6916009)(4326008)(66556008)(64756008)(6486002)(83380400001)(86362001)(54906003)(6506007)(26005)(6512007)(186003)(2906002)(38070700005)(5660300002)(38100700002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dXKIcihAWk8VihgL+2QW7AJjVVQpVzopYytZivGoQpckmjtAs+6zL8LwWA?=
 =?iso-8859-1?Q?44DpwUEp/DSd8wJvdWtUXB3GeGiPtX+f8erH5pXKtp8ItfULCmJoAURt6r?=
 =?iso-8859-1?Q?J7RXSmwdBB8mor3nN/vdrRJ4IHpXV7eEVohbQYxJ/rQTu3KwysZzaobBuS?=
 =?iso-8859-1?Q?PCjetB/UpbtylTXj0I3IcHS92jPayP0lL/G7Pqj4IZsTOfrrN2oiqlkFtS?=
 =?iso-8859-1?Q?qaMSh/SYnpFA26Bc/yyWSANVs9dgywQe7XIKSQ17QaAhxPYeFbFeNFbg+X?=
 =?iso-8859-1?Q?rKEr3BegVc9TrMxVi0oTZqmhyn/yWDuiCQvt/PRs3lqwJh2hdmYFno10DP?=
 =?iso-8859-1?Q?VWLczFXN6/dkuQQHwMSp/5TekdAZ8Kss8KgBLSeFdm/nbgWjvFnJHYGmaU?=
 =?iso-8859-1?Q?6al10vuQwZpeDIhc96P6ddNtJ5lxoV/XCDottSv4cD68Qf4l5jafvv0nPZ?=
 =?iso-8859-1?Q?ApFnt7pMhUVHcAeW+QL9orkgWAP+G+UIVVqaH6E6fBcxlgoThlDdiVkeWp?=
 =?iso-8859-1?Q?NSzQ8uU+1qQ0ykK9s4omGyxyC08kGv+nW+Knh3VwD3Bw49TUKrgPnbl+Gi?=
 =?iso-8859-1?Q?DLVbVWRLJl8KPv9fePp9O6TGlTTXaIVvCng3RLKAtm2c5ICjvQsYYEgnwv?=
 =?iso-8859-1?Q?IfZVEKuNMUMVzmFIciZbAxFb2RZ9wzMt/4LFFu8b1JlkJ/5JLEklmPXU9b?=
 =?iso-8859-1?Q?0pZ7OZJalzLTRi+D6PqzFdIoBG8nc5/Hvupp8Qh5+mk6O9mtgxVvpVbPO1?=
 =?iso-8859-1?Q?TgjlVjYEpfMLAXdBvgNgsHYSK9beVx8q5nVfVrbfwgxyCSX0YzIXdHXLwr?=
 =?iso-8859-1?Q?rNB04WGs5DyFsAczJ8rAlB3QZfUVZzxolb2oT76D9CU+HFyWGs1+0DmLP9?=
 =?iso-8859-1?Q?HLX4W8proFXb8hGTfm1mdpg1K0KSxyMYA9J89gQfL3hmH7BN8gLgRDoQZn?=
 =?iso-8859-1?Q?Zzt6ln+kioIGOKoaRsMkxDkBy1wJuFqSQGI8lXwq1H+6EaE68l8tlkTEj5?=
 =?iso-8859-1?Q?fsgU8OEyaGtcnVcBS1YgzYgmvXR0jLg3rms4pv7iGgbiEHfAY4O5HTt/Ty?=
 =?iso-8859-1?Q?74lcv+nMPoXwGtkDj+QB5W+LhDsE/yDOCLznPww1kO/oSkDQB3IncEIPKI?=
 =?iso-8859-1?Q?2YKKYJsHP6yzkIc39SKVB2KIdzvMTMGGVnLK4hNROl0Crg3f1VFs95+GJN?=
 =?iso-8859-1?Q?mKg0+Y+Wyhvf60Lfs2slS+fDjNH+JwIiON3+q9LaVk+SXH390+wJzOtWYN?=
 =?iso-8859-1?Q?2qEtoZ+3Ju8AAX6KnSbJ6mFLkbO6cdb0unfkDaN/3dVHG5eo1l7cYRJrlE?=
 =?iso-8859-1?Q?VHn5vMMclXPD4/Jje4zRONUlRRc5gH2w7ShVsJCPicP77Prgsv1HHocxnP?=
 =?iso-8859-1?Q?gYgWLCvXqNZGIhe2ryYaAKddbiQgHXdffPOOJKDBPWGG6+Ao9M8oKB32W+?=
 =?iso-8859-1?Q?orcb99o6m6pzuYDmZBIR8RUDDuIMaa6xXK9zpmYHXg4uXH04t+KOBUP2SZ?=
 =?iso-8859-1?Q?HEFTkCfETWiMdnXvSbzciRbQXSfBnRV8OCQVryh+hr+lfSjX6g/iJoeAvY?=
 =?iso-8859-1?Q?bTS5DD0ke5fkkh23g6z+it23MiCoHMVtSrfgRWhZJfJO7R5C4QxdTgA9O2?=
 =?iso-8859-1?Q?OxkXdQxRpShYEyAUaQ+X4qBAv+BYkiNtSfUvdYj7QtCpdRc2raukBHuA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d741b8b8-23b8-4d96-4671-08db4659dc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 13:26:37.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ofZFrmwZZn4drFhAx9U1X38cO4lR0bpnaoVR9DBRkNQs817/QYSKwOK6l0g6xl9SAZR7UWARx3shSfW/w/BT2veBUVOz/OPbd+IZpWqXU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9380
X-Proofpoint-ORIG-GUID: 4p8VgBreDDj7wPdinifTG7mMe2WKJuC_
X-Proofpoint-GUID: 4p8VgBreDDj7wPdinifTG7mMe2WKJuC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_06,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC patch series is intended to introduce the potential generic driver=
 for
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

This implementation still reqires some features, such as gpio support, but =
I've posted it as RFC to
start the discussion regarding the driver format.

[0] https://developer.arm.com/documentation/den0056/latest

---
Changes v1 -> v2:
   - rebase patches to the latest kernel version
   - use protocol helpers in the pinctrl scmi protocol driver implementatio=
n
   - reworked pinctrl_ops. Removed similar calls to simplify the interface
   - implementation of the .instance_deinit callback to properly clean reso=
urces
   - add description of the pinctrl protocol to the device-tree schema

---
Oleksii Moisieiev (3):
  firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  pinctrl: Implementation of the generic scmi-pinctrl driver
  dt-bindings: firmware: arm,scmi: Add support for pinctrl protocol

 .../bindings/firmware/arm,scmi.yaml           |  77 ++
 MAINTAINERS                                   |   7 +
 drivers/firmware/arm_scmi/Makefile            |   3 +-
 drivers/firmware/arm_scmi/driver.c            |   2 +
 drivers/firmware/arm_scmi/pinctrl.c           | 932 ++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h         |   1 +
 drivers/pinctrl/Kconfig                       |   9 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-scmi.c                | 578 +++++++++++
 include/linux/scmi_protocol.h                 |  47 +
 10 files changed, 1656 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

--=20
2.25.1
