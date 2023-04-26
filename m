Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187996EF57C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbjDZN1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241170AbjDZN1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:27:05 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6EC26AC;
        Wed, 26 Apr 2023 06:27:00 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q9vWUD011543;
        Wed, 26 Apr 2023 13:26:48 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3q6uwpt2nb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 13:26:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2bcN5KfuA/msOmxpjv1geQx9zAY/IAIFvjnfL/XZolt1/G/hXW+uswg+4hc4eaD+uDWWic10kPMSH7xVvGTzHOd5nK67IZGsxJM03rtJ7GsFZa+CzCA+uwcaeRYrJUAHHFGj8E5+l7aXOAGcqDeVGNj8T4VyiLPtD4+rDj5yQzBWmy2GH7ghhnyi0rIXbTUT8yvgq9nsYua6yp8TzSmBRWUoH80vNNZ06SpHCrUsyqfwHEHp51wsBAFa2rqJGLkb6+bU2BHtmywfAD37QQkvJtHwS+zsj4r2uXjsrPH/dGp4OYIscAmq4MR67bj7znXCtYRcnshRwhKoH4aYUHkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hnEd7OmhgbGKOGW2Yvc9Ggk0ZUsMiZTdI8WLVe2kMU=;
 b=d1nbbsLP2N/m+8TcYmzPRn/Fsk/t6ulRK8GX4LNRP24TleBHh/BVWBNVEaBZTxR2owhiIVUKAn0AnUnytDrigGC96B4wjcq6bav6oLw/hdEhpZcMvIznHs6xH/jDsEEcpF+0qnPh543fCVY6OWZZESUnlRgCErQ7CzuZfBkH2AaUvLCW8bmJ7Fz4lr8vr9e6PlR1c72/ThbfijjBdDar+txlInQ5ipwp8Vp8rEvLD1490YnLhSQaUFO620SwCAwzR5Q6rBvaME33FRM/SKBvAqG0NhPgIuU2cDRq/Jz0Z2vkY1PuD6cuFaaUWuE3P3e/OAuwI1z3yRNBw1tyegJtCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hnEd7OmhgbGKOGW2Yvc9Ggk0ZUsMiZTdI8WLVe2kMU=;
 b=R3X85GE2LNOwadzF5dPJu9KzeCChC2WJPjbAeMYSVuHy6Jz93oav8OgQld7m7BV7WJ8t/bjQYRKugvev/rVgpacC3U8bpMyFS7RPphL87uoC/T46qzK40GrU4zLOoGpxGiz17yz4HAJM3JrLBRGqabsEunWGspSt6M8Nfj7LLxGITr1Dn0yHSqQkzIS1wvPgpFzRcgQbzbRtxnssD2kmOngV3ShS2C8I9waZOjcBsr5HPFWBCB++1N085aCwqI0//f89U7+y7LUAogV0fBs2SNJtTrVzlxthEuUWH95jhHBIe1YyljiMty8Y0Jnh+yTtK4SUwPKUlPOblnFSHOQwnw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB9380.eurprd03.prod.outlook.com (2603:10a6:150:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.54; Wed, 26 Apr
 2023 13:26:38 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%8]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 13:26:38 +0000
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
Subject: [RFC v2 1/3] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol
 basic support
Thread-Topic: [RFC v2 1/3] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZeEK6SX8vcPOUbkqIYZzlwR9d3Q==
Date:   Wed, 26 Apr 2023 13:26:37 +0000
Message-ID: <b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev@epam.com>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1682513390.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB9380:EE_
x-ms-office365-filtering-correlation-id: 8fcf30be-d2da-4dbe-67b6-08db4659dd54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: awfJ2VXE+E3zSZ0PsJEvCJSCVNCAcCD4e3sbqbOYV5EHOid7eIj30UFS/JGGL/42W5arnCx9KruqVJ43RVup0lVbFRjktWbVb/Zjjq7seYq5BbJOm5e4Np6BN/8WLnkqNFC6Fdx9fmQR2FX/1BelRi3WTsMdCsJICRsd4Iv4QMPBe1sgjHmlzX+1tHKpEkU5Iy3zwS4UrAat3jbrm1GwKmiucQqPDKaAD4LNElbjGOBtKh1ndgcg9ikpJua5fUHugiFgFNxPRuPOJRYqv7pkCUy1l1l2BWIbhW10CQcnbH484ygYouZvnH6cZzmnbE0yG4ebqhGcoWu9DcnMZNBJPmo4c4d2z32lpKw4eu9bJL1Af10LY+CNfUEn16YZA71TpATB+LovEgMYvEIrHC1mbAprJUyV2CTYW6sbMbIMyXVeDeQDmizVY8k+xYEBpInYhjuJ/R2Lqi3L/N33TsaT/h8HvxulVQCWCWkLrpEOtlM4kFlauVsnzME2trBoFK2jju5XBQL4mlmwEhB2G0q5K8zU5sYih2rvpbj9IqH7w4CbVXYqaXDaGPvkTiBNSjvr5u1VaL6Y3lMV1cCfkf3lYjTdPmdvkB4GyFX0Cv35JfwPwPBTqnVfASeHKW+08az6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(8936002)(2616005)(122000001)(8676002)(478600001)(36756003)(91956017)(316002)(76116006)(66946007)(71200400001)(66476007)(66446008)(41300700001)(6916009)(4326008)(66556008)(64756008)(6486002)(83380400001)(86362001)(54906003)(6506007)(26005)(6512007)(186003)(30864003)(2906002)(38070700005)(5660300002)(38100700002)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NDHyJv4DKFOLGL0hLIhH+gI/EmtxMgJG/clbXzYu7SPWwolcrNXsrw92FQ?=
 =?iso-8859-1?Q?TyE2vwEzZKOmo3N8BWmW+M/PsR8Tb/9v8ga6LUw0kJe5jZ3qneqvmC6LP5?=
 =?iso-8859-1?Q?7T0VV0KJAw8iM/kDjfEPz4Fr69Hez0m6k6OK8BlyMBskUrKxOoSF4miGxj?=
 =?iso-8859-1?Q?HZvPC3acXwyOkGa+UQvZLl5JMcDztvY6GXnwOaGVYW6N95lLtQN/ykV2tJ?=
 =?iso-8859-1?Q?EZO7jYGZxfPPFErAUZ1v7HKqd6gD4mSww4jwOOrfzfRWHUETGJTO4KvLOg?=
 =?iso-8859-1?Q?0tw3sDM0ygDtzXXjvH9xywfW4uEr2zOEPhd6Ie4rL6cIeXKgd2jvOcoufp?=
 =?iso-8859-1?Q?Xs2HXnWSJYcHYsE6AxiCnxufCAB9y4iAofpvMcljcMw9JRQPYhh1byQsQJ?=
 =?iso-8859-1?Q?HoCSL7MIM1wOg0iWeDjRRZlfth21PA3x2LEY5GfOXpozVALnUjiVjZqMO0?=
 =?iso-8859-1?Q?lg+lVBly3xP3gD7dNVMKzcb17QhZmXxtbnfbNvTdwQb3odRrW2sgkOTMX4?=
 =?iso-8859-1?Q?JVSQd16z4BhVRD4p4PFa2rUJGEPhrux3MaDv2yY8bgfyIvWCM7sDG8SHbN?=
 =?iso-8859-1?Q?Dkpe8IUloalqq7cNIcUn3erB7D+/FLy1KNwAXmmsbpiuiOGaKBSVr8i9Qv?=
 =?iso-8859-1?Q?yAEiM2AyXUqeVDi+FQbVwb5tXDa/4h0PU65kJTnq3PrJ6NDeucVq8AWb7v?=
 =?iso-8859-1?Q?K5opURB2Xve/pwM3Q2CDVSpS/pZUaeA9CO5u6lj8X10MkmGmreCwMYuRAc?=
 =?iso-8859-1?Q?eVh9mFfn/RMnYAmJJ4VZ4GesocLPUrT3nVOG6ciQ6Jrrx82+M0n4re05lr?=
 =?iso-8859-1?Q?WSK4oOj1BPKF+fT2WG3lkPMUJXPkFVXD1mHq29EK3efynYlawJZOdNHkD+?=
 =?iso-8859-1?Q?LrgexSi77Nmb7a+t7lLW/4TTwMvr+ezMDFjkVOzlk+ft/dAJ+QmFPHlDIO?=
 =?iso-8859-1?Q?xSj7G6n3SabWxB+Tzwch5prB2y+Dpq1I9dpAw8D1FTp7v1GNxgXGdVcu3l?=
 =?iso-8859-1?Q?I6hAEusQAw1pkVdnB6z/mxDoS5Cu9FQYgh7a5YX2Ch8xj0nENY9iDOpfiD?=
 =?iso-8859-1?Q?KawLv9cTm/4ivcLCA9l/hHL6VbwNKEHeX42BOvxY+L/98yEeRcizzMTIvt?=
 =?iso-8859-1?Q?G5dKCglIZatupEDBlh/yH4pZIz4K8rTkkYihNqi0Hc7E34/xh54WZJZdXs?=
 =?iso-8859-1?Q?K6sO3lDFHgNuy3S9xmN1MCzCSKf/QmwQokjGCc2QT2vedpMbjZE/acNPA4?=
 =?iso-8859-1?Q?u2CDJMOc3RpEoth4nJMvPmBroqrBqvgDa+XC00Wvjw5wVWKM/gHgNHK6Gm?=
 =?iso-8859-1?Q?E23LoIrIoau+Dqi76UiNPBffWtDdB2BQ9Xj7Md/bFkeqWaxG/OyAC9D6Ka?=
 =?iso-8859-1?Q?zuxSSW7porxaZPBkNR2wCfI69pVAmyhK/5I8kF/AThg2MqbouZ4VYtHFmT?=
 =?iso-8859-1?Q?PRyHiyRJ346HUy6+Dz07CLqM9zB6lpuwoLGSfaNTsXVh5YVdcTipX5GMMf?=
 =?iso-8859-1?Q?vZXSv5qWbTl+dQPFC+NhVCA7gKncMR0EiybUP0MJW0bPxxXw+tisVc5b0G?=
 =?iso-8859-1?Q?aEzgX//rIL2eAg1m17hp2dHQt19QERCVPCIao/n5/jrfOppIq7+jbgomrQ?=
 =?iso-8859-1?Q?B/XcZWqN7fuk+IAdmK5C4KDXZJmgSYnTQDLxD9ZMfsgs/aasD4E5TDoA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcf30be-d2da-4dbe-67b6-08db4659dd54
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 13:26:37.4781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+DPamQjz8AUSy2pXvP5T+DKk76Ui78vbt/MNIWgqlNLay2vClc9iM7SqZw2O4ee2SJEzZDOx3gh00yxEjOhxhvteI/V8Cnr5iIw3llNXOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9380
X-Proofpoint-ORIG-GUID: 22Em8f-hJzD3r4l_0DdplRxEbIAXkEQT
X-Proofpoint-GUID: 22Em8f-hJzD3r4l_0DdplRxEbIAXkEQT
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

scmi: Introduce pinctrl SCMI protocol driver

Add basic implementation of the SCMI v3.2 pincontrol protocol
excluding GPIO support. All pinctrl related callbacks and operations
are exposed in the include/linux/scmi_protocol.h

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 MAINTAINERS                           |   6 +
 drivers/firmware/arm_scmi/Makefile    |   3 +-
 drivers/firmware/arm_scmi/driver.c    |   2 +
 drivers/firmware/arm_scmi/pinctrl.c   | 932 ++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |   1 +
 include/linux/scmi_protocol.h         |  47 ++
 6 files changed, 990 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/pinctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e64787aace8..0d251ebac437 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20317,6 +20317,12 @@ F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
 F:	include/uapi/linux/virtio_scmi.h
=20
+PINCTRL DRIVER FOR SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI)
+M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	drivers/firmware/arm_scmi/pinctrl.c
+
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi=
/Makefile
index b31d78fa66cc..071ac65f22b9 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -3,6 +3,7 @@ scmi-bus-y =3D bus.o
 scmi-core-objs :=3D $(scmi-bus-y)
=20
 scmi-driver-y =3D driver.o notify.o
+
 scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) +=3D raw_mode.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) =3D shmem.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=3D mailbox.o
@@ -10,7 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=3D smc.=
o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
-scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o syste=
m.o voltage.o powercap.o
+scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o syste=
m.o voltage.o powercap.o pinctrl.o
 scmi-module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transpor=
t-y)
=20
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) +=3D scmi-core.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi=
/driver.c
index dbc474ff62b7..fc7ba587ae6e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3021,6 +3021,7 @@ static int __init scmi_driver_init(void)
 	scmi_voltage_register();
 	scmi_system_register();
 	scmi_powercap_register();
+	scmi_pinctrl_register();
=20
 	return platform_driver_register(&scmi_driver);
 }
@@ -3038,6 +3039,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_voltage_unregister();
 	scmi_system_unregister();
 	scmi_powercap_unregister();
+	scmi_pinctrl_unregister();
=20
 	scmi_transports_exit();
=20
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scm=
i/pinctrl.c
new file mode 100644
index 000000000000..1c643d21390f
--- /dev/null
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -0,0 +1,932 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Pinctrl Protocol
+ *
+ * Copyright (C) 2023 EPAM
+ */
+
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include "protocols.h"
+
+#define SET_TYPE(x) FIELD_PREP(GENMASK(1, 0), (x))
+
+#define REG_TYPE_BITS GENMASK(9, 8)
+#define REG_CONFIG GENMASK(7, 0)
+
+#define GET_GROUPS_NR(x) FIELD_GET(GENMASK(31, 16), (x))
+#define GET_PINS_NR(x) FIELD_GET(GENMASK(15, 0), (x))
+#define GET_FUNCTIONS_NR(x) FIELD_GET(GENMASK(15, 0), (x))
+
+#define EXT_NAME_FLAG(x) FIELD_GET(BIT(31), (x))
+#define NUM_ELEMS(x) FIELD_GET(GENMASK(15, 0), (x))
+
+#define REMAINING(x) FIELD_GET(GENMASK(31, 16), (x))
+#define RETURNED(x) FIELD_GET(GENMASK(11, 0), (x))
+
+enum scmi_pinctrl_protocol_cmd {
+	PINCTRL_ATTRIBUTES =3D 0x3,
+	PINCTRL_LIST_ASSOCIATIONS =3D 0x4,
+	PINCTRL_CONFIG_GET =3D 0x5,
+	PINCTRL_CONFIG_SET =3D 0x6,
+	PINCTRL_FUNCTION_SELECT =3D 0x7,
+	PINCTRL_REQUEST =3D 0x8,
+	PINCTRL_RELEASE =3D 0x9,
+	PINCTRL_NAME_GET =3D 0xa,
+	PINCTRL_SET_PERMISSIONS =3D 0xb
+};
+
+struct scmi_msg_conf_set {
+	__le32 identifier;
+	__le32 attributes;
+	__le32 config_value;
+};
+
+struct scmi_msg_conf_get {
+	__le32 identifier;
+	__le32 attributes;
+};
+
+struct scmi_msg_pinctrl_protocol_attributes {
+	__le32 attributes_low;
+	__le32 attributes_high;
+};
+
+struct scmi_msg_ext_name {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_resp_ext_name {
+	__le32 flags;
+	u8 name[SCMI_MAX_STR_SIZE];
+};
+
+struct scmi_msg_pinctrl_attributes {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_resp_pinctrl_attributes {
+	__le32 attributes;
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+};
+
+struct scmi_msg_pinctrl_list_assoc {
+	__le32 identifier;
+	__le32 flags;
+	__le32 index;
+};
+
+struct scmi_resp_pinctrl_list_assoc {
+	__le32 flags;
+	__le16 array[];
+};
+
+struct scmi_msg_func_set {
+	__le32 identifier;
+	__le32 function_id;
+	__le32 flags;
+};
+
+struct scmi_msg_request {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_group_info {
+	bool present;
+	char *name;
+	unsigned int *group_pins;
+	unsigned int nr_pins;
+};
+
+struct scmi_function_info {
+	bool present;
+	char *name;
+	unsigned int *groups;
+	unsigned int nr_groups;
+};
+
+struct scmi_pin_info {
+	bool present;
+	char *name;
+};
+
+struct scmi_pinctrl_info {
+	u32 version;
+	int nr_groups;
+	int nr_functions;
+	int nr_pins;
+	struct scmi_group_info *groups;
+	struct scmi_function_info *functions;
+	struct scmi_pin_info *pins;
+};
+
+static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *=
ph,
+				       struct scmi_pinctrl_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_protocol_attributes *attr;
+
+	if (!pi)
+		return -EINVAL;
+
+	ret =3D ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr =3D t->rx.buf;
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_functions =3D
+			le16_to_cpu(GET_FUNCTIONS_NR(attr->attributes_high));
+		pi->nr_groups =3D le16_to_cpu(GET_GROUPS_NR(attr->attributes_low));
+		pi->nr_pins =3D le16_to_cpu(GET_PINS_NR(attr->attributes_low));
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_get_count(const struct scmi_protocol_handle *ph,
+				  enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_pinctrl_info *pi;
+
+	if (!ph)
+		return -ENODEV;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -ENODEV;
+
+	switch (type) {
+	case PIN_TYPE:
+		return pi->nr_pins;
+	case GROUP_TYPE:
+		return pi->nr_groups;
+	case FUNCTION_TYPE:
+		return pi->nr_functions;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
+				    u32 identifier,
+				    enum scmi_pinctrl_selector_type type)
+{
+	int value;
+
+	if (!ph)
+		return -ENODEV;
+
+	value =3D scmi_pinctrl_get_count(ph, type);
+	if (value < 0)
+		return value;
+
+	if (identifier >=3D value)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_pinctrl_get_ext_name(const struct scmi_protocol_handle *ph=
,
+				     u32 identifier,
+				     enum scmi_pinctrl_selector_type type,
+				     char **name)
+{
+	struct scmi_xfer *t;
+	int ret =3D 0;
+	struct scmi_msg_ext_name *tx;
+	struct scmi_resp_ext_name *rx;
+
+	if (!ph || !name)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_NAME_GET, sizeof(*tx),
+				      sizeof(*rx), &t);
+
+	tx =3D t->tx.buf;
+	rx =3D t->rx.buf;
+	tx->identifier =3D identifier;
+	tx->flags =3D SET_TYPE(cpu_to_le32(type));
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	if (ret)
+		goto out;
+
+	if (rx->flags) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	*name =3D kasprintf(GFP_KERNEL, "%s", rx->name);
+	if (!*name)
+		ret =3D -ENOMEM;
+ out:
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
+				   enum scmi_pinctrl_selector_type type,
+				   u32 selector, char **name,
+				   unsigned int *n_elems)
+{
+	int ret =3D 0;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_attributes *tx;
+	struct scmi_resp_pinctrl_attributes *rx;
+
+	if (!ph || !name)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
+				      sizeof(*rx), &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	rx =3D t->rx.buf;
+	tx->identifier =3D selector;
+	tx->flags =3D SET_TYPE(cpu_to_le32(type));
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	if (ret)
+		goto out;
+
+	*n_elems =3D NUM_ELEMS(rx->attributes);
+
+	if (!EXT_NAME_FLAG(rx->attributes)) {
+		*name =3D kasprintf(GFP_KERNEL, "%s", rx->name);
+		if (!*name)
+			ret =3D -ENOMEM;
+	} else {
+		ret =3D scmi_pinctrl_get_ext_name(ph, selector, type, name);
+	}
+ out:
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+struct scmi_pinctrl_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	unsigned int *array;
+};
+
+static void iter_pinctrl_assoc_prepare_message(void *message,
+					       unsigned int desc_index,
+					       const void *priv)
+{
+	struct scmi_msg_pinctrl_list_assoc *msg =3D message;
+	const struct scmi_pinctrl_ipriv *p =3D priv;
+
+	msg->identifier =3D cpu_to_le32(p->selector);
+	msg->flags =3D SET_TYPE(cpu_to_le32(p->type));
+	/* Set the number of OPPs to be skipped/already read */
+	msg->index =3D cpu_to_le32(desc_index);
+}
+
+static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
+					   const void *response, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r =3D response;
+
+	st->num_returned =3D le32_to_cpu(RETURNED(r->flags));
+	st->num_remaining =3D le32_to_cpu(REMAINING(r->flags));
+
+	return 0;
+}
+
+static int
+iter_pinctrl_assoc_process_response(const struct scmi_protocol_handle *ph,
+				    const void *response,
+				    struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r =3D response;
+	struct scmi_pinctrl_ipriv *p =3D priv;
+
+	p->array[st->desc_index + st->loop_idx] =3D
+		le16_to_cpu(r->array[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_pinctrl_list_associations(const struct scmi_protocol_handl=
e *ph,
+					  u32 selector,
+					  enum scmi_pinctrl_selector_type type,
+					  u16 size, unsigned int *array)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops =3D {
+		.prepare_message =3D iter_pinctrl_assoc_prepare_message,
+		.update_state =3D iter_pinctrl_assoc_update_state,
+		.process_response =3D iter_pinctrl_assoc_process_response,
+	};
+	struct scmi_pinctrl_ipriv ipriv =3D {
+		.selector =3D selector,
+		.type =3D type,
+		.array =3D array,
+	};
+
+	if (!ph || !array || !size)
+		return -EINVAL;
+
+	if (type =3D=3D PIN_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter =3D ph->hops->iter_response_init(ph, &ops, size,
+					    PINCTRL_LIST_ASSOCIATIONS,
+					    sizeof(struct scmi_msg_pinctrl_list_assoc),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+static int scmi_pinctrl_get_config(const struct scmi_protocol_handle *ph,
+				   u32 selector,
+				   enum scmi_pinctrl_selector_type type,
+				   u8 config_type, u32 *config_value)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_conf_get *tx;
+	__le32 *le_config;
+	u32 attributes =3D 0;
+	int ret;
+
+	if (!ph || !config_value || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_GET, sizeof(*tx),
+				      sizeof(*le_config), &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	le_config =3D t->rx.buf;
+	tx->identifier =3D cpu_to_le32(selector);
+	attributes =3D FIELD_PREP(REG_TYPE_BITS, type) |
+		FIELD_PREP(REG_CONFIG, config_type);
+
+	tx->attributes =3D cpu_to_le32(attributes);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+
+	if (!ret)
+		*config_value =3D le32_to_cpu(*le_config);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_set_config(const struct scmi_protocol_handle *ph,
+				   u32 selector,
+				   enum scmi_pinctrl_selector_type type,
+				   u8 config_type, u32 config_value)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_conf_set *tx;
+	u32 attributes =3D 0;
+	int ret;
+
+	if (!ph || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_SET,
+				      sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(selector);
+	attributes =3D FIELD_PREP(REG_TYPE_BITS, type) |
+		FIELD_PREP(REG_CONFIG, config_type);
+	tx->attributes =3D cpu_to_le32(attributes);
+	tx->config_value =3D cpu_to_le32(config_value);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_function_select(const struct scmi_protocol_handle =
*ph,
+					u32 identifier,
+					enum scmi_pinctrl_selector_type type,
+					u32 function_id)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_func_set *tx;
+	int ret;
+
+	if (!ph || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_FUNCTION_SELECT,
+				      sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(identifier);
+	tx->function_id =3D cpu_to_le32(function_id);
+	tx->flags =3D SET_TYPE(cpu_to_le32(type));
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
+				u32 identifier,
+				enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_xfer *t;
+	int ret;
+	struct scmi_msg_request *tx;
+
+	if (!ph || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_REQUEST, sizeof(*tx),
+				      0, &t);
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D identifier;
+	tx->flags =3D SET_TYPE(cpu_to_le32(type));
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request_pin(const struct scmi_protocol_handle *ph,
+				    u32 pin)
+{
+	return scmi_pinctrl_request(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
+			     u32 identifier,
+			     enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_xfer *t;
+	int ret;
+	struct scmi_msg_request *tx;
+
+	if (!ph || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_RELEASE,
+				      sizeof(*tx), 0, &t);
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D identifier;
+	tx->flags =3D SET_TYPE(cpu_to_le32(type));
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_free_pin(const struct scmi_protocol_handle *ph, u3=
2 pin)
+{
+	return scmi_pinctrl_free(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *=
ph,
+				       u32 selector,
+				       struct scmi_group_info *group)
+{
+	int ret =3D 0;
+
+	if (!ph || !group)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
+				      &group->name,
+				      &group->nr_pins);
+	if (ret)
+		return ret;
+
+	if (!group->nr_pins) {
+		dev_err(ph->dev, "Group %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	group->group_pins =3D devm_kmalloc_array(ph->dev, group->nr_pins,
+					       sizeof(*group->group_pins),
+					       GFP_KERNEL);
+	if (!group->group_pins) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	ret =3D scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
+					     group->nr_pins, group->group_pins);
+	if (ret)
+		goto err_groups;
+
+	group->present =3D true;
+	return 0;
+
+ err_groups:
+	kfree(group->group_pins);
+ err:
+	kfree(group->name);
+	return ret;
+}
+
+static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *=
ph,
+				       u32 selector, const char **name)
+{
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!ph || !name)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	if (selector > pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		ret =3D scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name =3D pi->groups[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_get_group_pins(const struct scmi_protocol_handle *=
ph,
+				       u32 selector, const unsigned int **pins,
+				       unsigned int *nr_pins)
+{
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!ph || !pins || !nr_pins)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	if (selector > pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		ret =3D scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*pins =3D pi->groups[selector].group_pins;
+	*nr_pins =3D pi->groups[selector].nr_pins;
+
+	return ret;
+}
+
+static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handl=
e *ph,
+					  u32 selector,
+					  struct scmi_function_info *func)
+{
+	int ret =3D 0;
+
+	if (!ph || !func)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
+				      &func->name,
+				      &func->nr_groups);
+	if (ret)
+		return ret;
+
+	if (!func->nr_groups) {
+		dev_err(ph->dev, "Function %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	func->groups =3D devm_kmalloc_array(ph->dev, func->nr_groups,
+					  sizeof(*func->groups),
+					  GFP_KERNEL);
+	if (!func->groups) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	ret =3D scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
+					     func->nr_groups, func->groups);
+	if (ret)
+		goto err_funcs;
+
+	func->present =3D true;
+	return 0;
+
+ err_funcs:
+	kfree(func->groups);
+ err:
+	kfree(func->name);
+	return ret;
+}
+
+static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handl=
e *ph,
+					  u32 selector, const char **name)
+{
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!ph || !name)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	if (selector > pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		ret =3D scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name =3D pi->functions[selector].name;
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_groups(const struct scmi_protocol_han=
dle *ph,
+					    u32 selector,
+					    unsigned int *nr_groups,
+					    const unsigned int **groups)
+{
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!ph || !groups || !nr_groups)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	if (selector > pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		ret =3D scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*groups =3D pi->functions[selector].groups;
+	*nr_groups =3D pi->functions[selector].nr_groups;
+
+	return ret;
+}
+
+static int scmi_pinctrl_set_mux(const struct scmi_protocol_handle *ph,
+				u32 selector, u32 group)
+{
+	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE,
+					    selector);
+}
+
+static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph=
,
+				     u32 selector, struct scmi_pin_info *pin)
+{
+	int ret =3D 0;
+	struct scmi_pinctrl_info *pi;
+	unsigned int n_elems;
+
+	if (!ph || !pin)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
+				      &pin->name,
+				      &n_elems);
+	if (ret)
+		return ret;
+
+	if (n_elems !=3D pi->nr_pins) {
+		dev_err(ph->dev, "Wrong pin count expected %d has %d",
+			pi->nr_pins, n_elems);
+		return -ENODATA;
+	}
+
+	if (*pin->name =3D=3D 0) {
+		dev_err(ph->dev, "Pin name is empty");
+		goto err;
+	}
+
+	pin->present =3D true;
+	return 0;
+
+ err:
+	kfree(pin->name);
+	return ret;
+}
+
+static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph=
,
+				     u32 selector, const char **name)
+{
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!ph || !name)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	if (selector > pi->nr_pins)
+		return -EINVAL;
+
+	if (!pi->pins[selector].present) {
+		ret =3D scmi_pinctrl_get_pin_info(ph, selector,
+						&pi->pins[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name =3D pi->pins[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_get_name(const struct scmi_protocol_handle *ph,
+				 u32 selector,
+				 enum scmi_pinctrl_selector_type type,
+				 const char **name)
+{
+	switch (type) {
+	case PIN_TYPE:
+		return scmi_pinctrl_get_pin_name(ph, selector, name);
+	case GROUP_TYPE:
+		return scmi_pinctrl_get_group_name(ph, selector, name);
+	case FUNCTION_TYPE:
+		return scmi_pinctrl_get_function_name(ph, selector, name);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops =3D {
+	.get_count =3D scmi_pinctrl_get_count,
+	.get_name =3D scmi_pinctrl_get_name,
+	.get_group_pins =3D scmi_pinctrl_get_group_pins,
+	.get_function_groups =3D scmi_pinctrl_get_function_groups,
+	.set_mux =3D scmi_pinctrl_set_mux,
+	.get_config =3D scmi_pinctrl_get_config,
+	.set_config =3D scmi_pinctrl_set_config,
+	.request_pin =3D scmi_pinctrl_request_pin,
+	.free_pin =3D scmi_pinctrl_free_pin
+};
+
+static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *p=
h)
+{
+	u32 version;
+	struct scmi_pinctrl_info *pinfo;
+	int ret;
+
+	if (!ph)
+		return -EINVAL;
+
+	ret =3D ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo =3D devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	ret =3D scmi_pinctrl_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
+
+	pinfo->pins =3D devm_kcalloc(ph->dev, pinfo->nr_pins,
+				   sizeof(*pinfo->pins),
+				   GFP_KERNEL);
+	if (!pinfo->pins)
+		return -ENOMEM;
+
+	pinfo->groups =3D devm_kcalloc(ph->dev, pinfo->nr_groups,
+				     sizeof(*pinfo->groups),
+				     GFP_KERNEL);
+	if (!pinfo->groups)
+		return -ENOMEM;
+
+	pinfo->functions =3D devm_kcalloc(ph->dev, pinfo->nr_functions,
+					sizeof(*pinfo->functions),
+					GFP_KERNEL);
+	if (!pinfo->functions)
+		return -ENOMEM;
+
+	pinfo->version =3D version;
+
+	return ph->set_priv(ph, pinfo);
+}
+
+static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_handle =
*ph)
+{
+	int i;
+	struct scmi_pinctrl_info *pi;
+
+	if (!ph)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	for (i =3D 0; i < pi->nr_groups; i++)
+		if (pi->groups[i].present) {
+			devm_kfree(ph->dev, pi->groups[i].group_pins);
+			pi->groups[i].present =3D false;
+		}
+
+	for (i =3D 0; i < pi->nr_functions; i++)
+		if (pi->functions[i].present) {
+			devm_kfree(ph->dev, pi->functions[i].groups);
+			pi->functions[i].present =3D false;
+		}
+
+	return 0;
+}
+
+static const struct scmi_protocol scmi_pinctrl =3D {
+	.id =3D SCMI_PROTOCOL_PINCTRL,
+	.owner =3D THIS_MODULE,
+	.instance_init =3D &scmi_pinctrl_protocol_init,
+	.instance_deinit =3D &scmi_pinctrl_protocol_deinit,
+	.ops =3D &pinctrl_proto_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_s=
cmi/protocols.h
index 78e1a01eb656..533b94c9a9a7 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -345,5 +345,6 @@ DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
 DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
 DECLARE_SCMI_REGISTER_UNREGISTER(system);
 DECLARE_SCMI_REGISTER_UNREGISTER(powercap);
+DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
=20
 #endif /* _SCMI_PROTOCOLS_H */
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0ce5746a4470..8e15d2912045 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -735,6 +735,52 @@ struct scmi_notify_ops {
 					 struct notifier_block *nb);
 };
=20
+enum scmi_pinctrl_selector_type {
+	PIN_TYPE =3D 0,
+	GROUP_TYPE,
+	FUNCTION_TYPE
+};
+
+/**
+ * struct scmi_pinctrl_protocol_ops - represents the various operations pr=
ovided
+ * by SCMI Pinctrl Protocol
+ *
+ * @get_count: returns count of the registered elements in given type
+ * @get_name: returns name by index of given type
+ * @get_group_pins: returns the set of pins, assigned to the specified gro=
up
+ * @get_function_groups: returns the set of groups, assigned to the specif=
ied
+ *	function
+ * @set_mux: set muxing function for groups of pins
+ * @get_config: returns configuration parameter for pin or group
+ * @set_config: sets the configuration parameter for pin or group
+ * @request_pin: aquire pin before selecting mux setting
+ * @free_pin: frees pin, acquired by request_pin call
+ */
+struct scmi_pinctrl_proto_ops {
+	int (*get_count)(const struct scmi_protocol_handle *ph,
+			 enum scmi_pinctrl_selector_type type);
+	int (*get_name)(const struct scmi_protocol_handle *ph,
+			u32 selector,
+			enum scmi_pinctrl_selector_type type,
+			const char **name);
+	int (*get_group_pins)(const struct scmi_protocol_handle *ph,
+			      u32 selector,
+			      const unsigned int **pins, unsigned int *nr_pins);
+	int (*get_function_groups)(const struct scmi_protocol_handle *ph,
+				   u32 selector, unsigned int *nr_groups,
+				   const unsigned int **groups);
+	int (*set_mux)(const struct scmi_protocol_handle *ph, u32 selector,
+		       u32 group);
+	int (*get_config)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  u8 config_type, u32 *config_value);
+	int (*set_config)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  u8 config_type, u32 config_value);
+	int (*request_pin)(const struct scmi_protocol_handle *ph, u32 pin);
+	int (*free_pin)(const struct scmi_protocol_handle *ph, u32 pin);
+};
+
 /**
  * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
  *
@@ -783,6 +829,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_RESET =3D 0x16,
 	SCMI_PROTOCOL_VOLTAGE =3D 0x17,
 	SCMI_PROTOCOL_POWERCAP =3D 0x18,
+	SCMI_PROTOCOL_PINCTRL =3D 0x19,
 };
=20
 enum scmi_system_events {
--=20
2.25.1
