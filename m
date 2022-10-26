Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29B260E6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiJZRwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiJZRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:52:01 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADAE915E9;
        Wed, 26 Oct 2022 10:51:59 -0700 (PDT)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QEjikG018352;
        Wed, 26 Oct 2022 17:51:30 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3kf6xmgqmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 17:51:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEUR9H0pnX9PsWPayOuw24yKy+9MJwv8Ax443t9/3BPIg/uKKYzUBwTTAIlDvT+z8yTYhFG56h216252f21Wofx8aPv29xr1RKjF8wfj7VtHsbSXhq5ssjNUhfeQoHvQbsU9Dz+dsknUycQbX53/a9Eq1KAX3h2TwihCqpgJnFLLNnkZ0e5qBoliw8zyrNewnZVRRNRkEdMB3WkgrqMw8sdSnLq0DUY2Ac7NsA7UB7U3RO8fcGQqwmsqJ9W1maPVVr62FslJYE2A04n425KVfJw72h2jLR+Vc3VmYkcYSynPBfzfTOvkFLuKDxhSPov/or2s+m/Y9a2KNXtK1KfLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0LphD6/i9eGF8ENerwMRiQakV60OUA/XK5uA7LdGO8=;
 b=IVqfTxuKmWItJjppOI3iQgBuAMDneIEJ8qB/32UjKumSJMgxmXa0nmdFSoDqYrFUzxnTTMi07WpV6tQG1cyRXmyzDzxF9sjAh1JMYTu02MitqluTP+0MaSetmr3baeMy2oFv8dfbcMqtQrohQbGt61Lfz2mEiAXmZB5uAYf7V8omT9jeZZKV2q5sleOVJDkYGUbTrMQb9D8fn4bCtP3IM5wOOHZUH2r09DJGAXK2Y+xXsip1V/n9SUGd8h4Y7HPRFpWmncLVJAerazCcrXVhFspD/kh62eoK4x+e1QEUY4RCI2RVZQ+Cbk3/9QCNfWsv3qOkAYvQrbWSvyZNB3SYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0LphD6/i9eGF8ENerwMRiQakV60OUA/XK5uA7LdGO8=;
 b=UhQFai70eJVepSfViY+LLOjUouDuQt164EKcqASpk5VC7wgP0j71EBcFyl3thGwgo8TQihsaM+BjYFhO8U9F0w8GUzNrBhjuPH0/wqPEy7uhvp1O7oGQZ1fVTKbiCj5R+qDwi4NRcKaAghweQHVvHOuOmfQBSAWTvMcvWQi+8wsCFDYhu6RQNi+5SuHb40cDceMMjWWRgxADOB7GlSd5E0b0kBqNsJKJH973GpRPPs8Ndt4+2ryge5cRA67T1Iz98mjNgMEYMsYOQ9lXyozDB1NIMSMA3QjUeqqeZjoMwS9PaTQgA4veg8b2ZD5enBhqCabije4b/Ev6z1z+eKmqyw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS8PR03MB9069.eurprd03.prod.outlook.com (2603:10a6:20b:5b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 17:51:27 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::551e:e1bc:b684:b7bb]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::551e:e1bc:b684:b7bb%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 17:51:26 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/2] dt-bindings: Introduce feature-domain-controller
Thread-Topic: [PATCH v5 0/2] dt-bindings: Introduce feature-domain-controller
Thread-Index: AQHY6WOR9rgqInIf80e8qho4/jJecA==
Date:   Wed, 26 Oct 2022 17:51:26 +0000
Message-ID: <cover.1666806317.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS8PR03MB9069:EE_
x-ms-office365-filtering-correlation-id: 89b834b2-2eed-4383-4e94-08dab77ab482
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ELNAewwmsyNdHoUd0VupmnbgpmmkFQEUiqrPB3f04K34PkmpCDq2s5RxMBOvPAfi2W+gkEBtGa3AlTh2azgTRXccwNrbA2ZkiQvf8Jjc1ATg8m3FK4KgzzWYtrc3+AOyAsNklhRt/Nx3bTx+TJRgs0Kt3nN7KpbJytiDAv/X56lmhAm5z1wLLmQyE4NMRm6IbzkVDItdokv3Ee1TVGCFYC/jDO9ZRqCtlAttktBm7cp6OnTt1kIxWKjAst5BITPT6PmvzPT9UJHIWzsEWun6hAIrcyo38j26WIfo5+h419C2HPTibIm1ups7QZH49MNedOGfybLGcE6o1y2y6EwG30FM28JUD5TojRxCTxgb1e9J2BHBMlsG9RgKs8uKtKogrpdWPO5okbwtVTbL1GrHvggzSJbwtlgraloKX7PaqIdaUldkD9fzOA1H2Qily2be02WW9uut3/o/iuM2/y3sZ2e/ZY6WY+4Iaq6x9HPPzQT4UKWd0998sfpj0kSzqOGleBwwI1GinI3NnLzJhwcAzfeAGbUuo4OobxkA4dnqPqlmqd4eE711E81PWYU00G9Mtfp7tCh2TNqkhb4h3Jsd48CfCNd93lOZb7iFecb9mTYMpgSQNs1h904uCW9+eGLiG7MCSu6hk3eVKfPiA0iEyyGb4KccX3srD4hEebjhGo0z3qWQCW95gLBVE0GYFm1XeWrWMvX8JsIfEmq4pRLWEXJuwKHPkdDvM8gEG/Eq5Dy0Qosj68je9DsmzaQwzMaNmwqf6/r4wBtMH7L50TmSLM4hDmkAoru8s+xd8h3MOzpXaAle4J1fqJdwtq1bw15vmjTUkgC3m3cCZD4Dxta1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(8676002)(83380400001)(71200400001)(76116006)(91956017)(36756003)(478600001)(4326008)(6486002)(966005)(6512007)(38070700005)(26005)(54906003)(316002)(86362001)(8936002)(122000001)(38100700002)(2906002)(41300700001)(2616005)(7416002)(186003)(5660300002)(6506007)(66476007)(64756008)(66446008)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?shBO/HSomw2jmcBJz7Ze84Z1ArCwMvdH35U63BibtuOuhcmAI6YI0qwcfz?=
 =?iso-8859-1?Q?zIa+mHGaE4nLLwrHL11uDih/pchffFpzY7Y1D4IiqWNBgoYJo3yDxD6IMu?=
 =?iso-8859-1?Q?bF0vsKMt3xzWl8Yf8BuqP91X82S0kz3e97zvwTADUIA8SE64iG7tWegCd9?=
 =?iso-8859-1?Q?pVqk4JaZdZUNL+H3arij8BFLgDaRiuR4nNdw3j+GoN3Y0gEvu7NT0V60y9?=
 =?iso-8859-1?Q?jJOhGLSgJybsQHMQI0Gb5OSi8D2GDMqbbsnx4Jjk+YLzyj+3wlXTxh8F59?=
 =?iso-8859-1?Q?GoOOmjkUcwc0eFeE4G2sjGUZDe2dGwYT8w6qwEqYT4NR2iGAAVaDDbp8Cc?=
 =?iso-8859-1?Q?I4ahkiXgbNJC5aBZnc/97OGfVvfJAsy/kx1cl07iePRrjEQVAu9gnhx5pd?=
 =?iso-8859-1?Q?/phExbWx7le+piCUyZAEkRmYuaO31et5gg5JEk/iGH0UM6p+Cx2d3Ecy68?=
 =?iso-8859-1?Q?DvnmXhmA/As8FTvmfQ7Rest3HvwMLS59Xv/VtCXf8GR429GV1qiTYNJyyC?=
 =?iso-8859-1?Q?o//hy6I4BmSsWbAFuvN6zd9o3m/3O5aH/axHVQ47thnsT5CmFdagr8YWvY?=
 =?iso-8859-1?Q?3VCGePfBg8wmZvqKnYwVPW2ONEAslC8nwej4aA0On9HOESn6jVjPdIcLhI?=
 =?iso-8859-1?Q?j6qG0HOJrkp7yiKq/bX/iW5YoosaxzM5aZS9/susfeIUHSDs2C/l/lCfBf?=
 =?iso-8859-1?Q?M+uyeUU79M6LNkQkymejytfsoHgtllgsJQcnQ3cFZ7Nkpl4sFEEK2FUKZ+?=
 =?iso-8859-1?Q?QzbcLANTjJNNpBXg4nXfnQI1l3a4fv18ILFb0h4S0zMHrygC1eg5r9asO2?=
 =?iso-8859-1?Q?rroOxK/NqgRzbOvtlc7KXU6iq0HPzezCJ7bjqlTbeif1ygPOAgPfc/UKqy?=
 =?iso-8859-1?Q?7gdRKlbOtYcIgsQwj4WuvurWhzNEz8yDjITqgMs1Z0n7kU9Vd56QwdtTMc?=
 =?iso-8859-1?Q?U3wUW4aNU0GJDIdUTeGHpo72aJ7F4+jiDP3ei8Xc3Cg2WTyLxYUp8iTwQK?=
 =?iso-8859-1?Q?TaPvr1ru5Cga3o14ITKsb3O8ShjGefPXyo+AhhY7DxzmeFTUG1+efhS1P4?=
 =?iso-8859-1?Q?GaZQAgmKkr7I9c6cvg9HignlS7zTI3bkVSKvWrkdSJqMA88kl023g/Qz9J?=
 =?iso-8859-1?Q?H4Kj5eW19oa9mNt5IXoFjjMXtDj8Q06zJXrVy8y3ccL+JAHBSQ9+euwo8q?=
 =?iso-8859-1?Q?2jtALVKi9h22pqLedOSsNf+Vn9ghubWStYyoierSR7nIrF9f9bTdcWlhDC?=
 =?iso-8859-1?Q?s8eZBIhiuhZhPiEIKHe4qFXxyGfUXkOtz0XOW6scWiW2MQWvKCCQ1Mgd0j?=
 =?iso-8859-1?Q?MjNqyfRPqHIRQuR7Lb4Kk/ya4f8GZ/AAuf1zPyQtfXF9XuV7xC2v6+sxPH?=
 =?iso-8859-1?Q?3h9NqUrJ0h68/nbUSF/Fyh3gtCZUZ5c3Y4Hoh4VQOJs7uRlaKo1dCfuL77?=
 =?iso-8859-1?Q?K1Mi9P9zdhS97ejcvR1EHrreH+zjJJAzDuTbQZztkGXaWSBqW2duhMS7yh?=
 =?iso-8859-1?Q?Pv8wCVv7Vhl49l0upbBJ980CtGeIS87kOlsbFkH4m4gHE6EF79oPGLGpVu?=
 =?iso-8859-1?Q?hMYmeVCNeWEN68kRudJnXujfCZ3TSNkCT6CeFd2WURDlyBDni6Rzmd3WiK?=
 =?iso-8859-1?Q?vrnCiLMjNy6ayghXB9W8EFdIHEh89VeuGrj01VPQ5iY4rmm+Y7r9SCqw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b834b2-2eed-4383-4e94-08dab77ab482
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 17:51:26.8053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LkF7mNFd6sNLpCL8RG/JHpPXW1nJwn56EAvnCofHbBy4KWARf1fGkwAuedlknOIg/y7iavWZ/ioz3+XCgRvx7h41qP5r6tPIWwr0TWgSUFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9069
X-Proofpoint-ORIG-GUID: NK7P8RcS9b-XtnZgntZ4IxKo97dJ8N9s
X-Proofpoint-GUID: NK7P8RcS9b-XtnZgntZ4IxKo97dJ8N9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=940
 adultscore=0 clxscore=1011 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing the feature domain controller provider/consumenr bindngs which
allow to divided system on chip into multiple feature domains that can be u=
sed
to select by who hardware blocks could be accessed.
A feature-domain could be a cluster of CPUs, a group of hardware blocks or =
the
set of devices, passed-through to the Guest in the virtualized systems.

Feature domains controllers are typically used to set the permissions of th=
e
hardware block. The contents of the feature domain configuration properties
are defined by the binding for the individual feature domain controller dev=
ice.

The feature device controller conception in the virtualized systems is to s=
et
the device configuration for SCMI (System Control and Management
Interface) which controls clocks/power-domains/resets etc from the
Firmware. This configuratio sets the device_id to set the device permission=
s
for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of =
[0]).
There is no BASE_GET_DEVICE_PERMISSIONS call in SCMI and the way to
determine device_id is not covered by the specification.
Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
Given parameter should set the device_id, needed to set device
permissions in the Firmware.
This property is used by trusted Agent (which is hypervisor in our case)
to set permissions for the devices, passed-through to the non-trusted
Agents. Trusted Agent will use device-perms to set the Device
permissions for the Firmware (See Section 4.2.2.10 [0] for details).
Agents concept is described in Section 4.2.1 [0].

Feature-Domains in Device-tree node example:
usb@e6590000
{
    feature-domains =3D <&scmi 19>; //Set domain id 19 to usb node
    feature-domain-names =3D "scmi";
    clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
    resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
    power-domains =3D <&scmi_power 0>;
};

&scmi {
    feature-domain-controller;
    #feature-domain-cells =3D <1>;
}

All mentioned bindings are going to be processed by XEN SCMI mediator
feature, which is responsible to redirect SCMI calls from guests to the
firmware, and not going be passed to the guests.

Feature-domain-controller provider/consumenr concept was taken from the bus
controller framework patch series, provided in the following thread:
[1].

I think we can cooperate with the bus controller framework developers
and produce the common binding, which will fit the requirements of both
features

Also, I think that binding can also be used for STM32 ETZPC bus
controller feature, proposed in the following thread: [2].

Looking forward for your thoughts and ideas.

[0] https://developer.arm.com/documentation/den0056/latest
[1] https://lore.kernel.org/all/20190318100605.29120-1-benjamin.gaignard@st=
.com/
[2] https://lore.kernel.org/all/20200701132523.32533-1-benjamin.gaignard@st=
.com/

---
Changes v1 -> V2:
   - update parameter name, made it xen-specific
   - add xen vendor bindings

Changes V2 -> V3:
   - update parameter name, make it generic
   - update parameter format, add link to controller
   - do not include xen vendor bindings as already upstreamed

Changes V3 -> V4:
   - introduce domain controller provider/consumer device tree bindings
   - making scmi node to act as domain controller provider when the
     device permissions should be configured

Changes V4 -> V5:
   - rename domain-controller to feature-domain-controller
   - feature-domains format fixes

Oleksii Moisieiev (2):
  dt-bindings: Update scmi node description
  dt-bindings: Document common device controller bindings

 .../feature-domain-controller.yaml            | 80 +++++++++++++++++++
 .../bindings/firmware/arm,scmi.yaml           | 28 +++++++
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/feature-domains/featu=
re-domain-controller.yaml

--=20
2.34.1
