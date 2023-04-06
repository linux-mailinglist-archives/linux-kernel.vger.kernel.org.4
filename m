Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601EA6D94F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbjDFLSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjDFLS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:18:26 -0400
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E47900C;
        Thu,  6 Apr 2023 04:18:21 -0700 (PDT)
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
        by mx08-0063e101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3369uhLB020839;
        Thu, 6 Apr 2023 11:22:35 +0100
Received: from ind01-max-obe.outbound.protection.outlook.com (mail-maxind01lp2169.outbound.protection.outlook.com [104.47.74.169])
        by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3pp9xuk2dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 11:22:35 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5kostL7mdWUwTMFFXrehH9KYk6Ahcl6eyuEbGT8NHznU5XH+aQpOlpmw2wxN3/4KjIql7bwSP4ePmHC1SrKkIiSZ31BLmL2ietPy7azbII9AsqVXU93xmjg6wW6Np2a+wh4Q2KSceFgOhCkNwZ9ewtpXtXECFVa4mO3SHRE4N1/AdW/DhAcgxzO12hKx4L3jJXVYlv7b6j0TvZHjUxkqgcIDzkievnFqYB0UJ369iC0IGf5PoOPPk5quGtiCGVd7PxzimSwR1430NsKdp4HRbdgHWzyvvBqq7oZGvwcQ8U3jYy3WJzlLMtxFf5yhN3LiO3vp4D9Uttg09LiQD7g7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf4pWKqPTNIBn6eGVGY5QXDqKZwDcwn+WxfORi1Wplg=;
 b=Yne4We66dQ52zk0od20TMDbskveBe+b5OTfVtacZYQIdH7W1bvvHaWoHIf4IHpaVeJmLGnPDWKiYRRMklt+JdJhMZWTxR0kopvadGFinYrxEmDhMRFVfNvvBPZEIt/I7req/FKA/m1us6xKJO82y55oiBGj9D6DPRehQBUKZbrTszbKF2dT0LiDlWszFDd8qOLTM08s09EM8aeTL/672f95BZnUpwVJEu2ja7RL76wSSF0jPKJq44nvg+mbXKPe3dU+TA3YGd5FHwR2EkHUQ475DDtAURcSXEl8g8mvJz1YjiA2N6k0gZjkek1t6DhyLvwvvydaazEjaccyTAeX8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf4pWKqPTNIBn6eGVGY5QXDqKZwDcwn+WxfORi1Wplg=;
 b=Hu8Yz0EXpB1ub9Uztc+EhxVxLQhEmrwjepnUukoUuWMX0m/B04sCJMaIZZzk8uBpX5BfvBIh2qMLDmnb7lcN1YDM7+Z99wrsm3LPjdOMp9oKc7C3ptgF1cLHgtFHU2s1NmBSPED7Ljmr9Ky1E3VypDCwdOu2TdOoZ99R86JEH/c=
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:37::10)
 by PN3PR01MB7647.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 10:22:31 +0000
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23]) by MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23%8]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 10:22:31 +0000
From:   Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "soc@kernel.org" <soc@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>
Subject: [PATCH 2/5] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Thread-Topic: [PATCH 2/5] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Thread-Index: AQHZaHGym/Anc1a8IUKEm26yM97Rzw==
Date:   Thu, 6 Apr 2023 10:22:31 +0000
Message-ID: <20230406102149.729726-3-nikolaos.pasaloukos@blaize.com>
References: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB6906:EE_|PN3PR01MB7647:EE_
x-ms-office365-filtering-correlation-id: 8b4a58bf-3612-4fbe-64b3-08db3688d492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F3KkXnCSgP1DIaFg0NkgG7lDoDp2AYbzhh8TGOzq+RZG4WtqkywbyhKUFENGEmcFgV7PPhbyXzB5G04X6MNNXOKnhXeCuIwQe9fRWHvkowHl4//mVzEzMCf3L0tKozfpQMa2oPFt2AWHIZA6GSRwI4JYsxOsRFv0X1o/T8C7qn6EoFaYzuIMvfoVtjaGSi1B3rG3nKDRwfUgOJYd2g6GqoZoRNVcooJ+DVm6EDq3hl2CZkdwxvI1ZvEZ0kGfPTM48vOu+/JgdFkL6/QhF2PBb1Wcnv+UKDlUt/CLDeEvAxKuayW7cGA448gixx0d1+guzSp6QVo40KWFvKWpU4Xulk7ikPLKC049q1nAASIf6urOkmC+Q/x4G7Dg6NuFa4oxhCey9xSzZh3NJTmXmMQoUXqjWCXbwEE/F9HHvTEMeGZj9AjwEArege42Zml07aOhxNeikruPRbgCWuv4iBKdd88xp4TQkwt1kh4IewPPYB6UI91dDbXIPV6/CSv7r8WRO6c7QTZKcOCER4sT85FebwF1BgVwvigoQgwmFzrBbPY10bADr8ksSN8f+tYRvXbAmbgDmax+o9GAplMdr777vogQju2GbPhc7TrFT5tOEg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39840400004)(366004)(451199021)(6486002)(4326008)(91956017)(110136005)(54906003)(66446008)(966005)(64756008)(76116006)(66946007)(66556008)(316002)(8676002)(36756003)(66476007)(122000001)(6506007)(6512007)(107886003)(2616005)(186003)(26005)(1076003)(38100700002)(5660300002)(41300700001)(71200400001)(478600001)(8936002)(38070700005)(86362001)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k0Ay5XYhuCyAnzYXYV79jlfHRXV0EfB7m/SErX5qtR70wHB6DF6dRciuvO?=
 =?iso-8859-1?Q?lTlGGnfeUCcqQI53eRGUETY9G+T9NiYZ0R+9TmeV8OzDV/FNXiqKr25zLh?=
 =?iso-8859-1?Q?91FfYifz/gm9/4Q4EusxC9NVYX79f0TZi8/cCr5AmciJic/dvmapDpK5I3?=
 =?iso-8859-1?Q?/F/yF9SNJyrOKj9RQfjJPCGMQqQMEZtmAVk13TWr1c6G4Bftdg0BhRfPgj?=
 =?iso-8859-1?Q?qLrVQSc6XE2uFchTM7M1KgC4MoGobEMBQhmoVnSRkhvkM+loG15/Cpx5gG?=
 =?iso-8859-1?Q?S7JrEdtowUcJ1diTxuc8pNFVsJYQPaSCmHmcVULuIDC57nFGy5UGaWFf2R?=
 =?iso-8859-1?Q?sxzYvFXU/Cnga7JP+PNJmzukKx2hG7UmBwLzKTAlHvPyxmLqx5zumF5p1C?=
 =?iso-8859-1?Q?Rpcqh6W+RUKAM/++rvBbFQ4tmlUMHTGPo15xYL/mzYKEXXlPH+rhT5FQhx?=
 =?iso-8859-1?Q?6ok9RKm0nvfsMQ6lmrOzt/jkSm676Wg6rBp8Fyo5PWlqJmgHlVfGW1uPt7?=
 =?iso-8859-1?Q?nDChKrWrpG8WCmPEKHaiDMuVViC8VqkMOkPJoU6WOuteZX7DzJeTN96oz7?=
 =?iso-8859-1?Q?I0/ct6kTZ06azmNVOwJaqGluG3XHutErcDowQhSfWXy4mI/E1S4F3poeod?=
 =?iso-8859-1?Q?85IYk+poEuC6Cm95zDltc1qaeMywfPizIxpDdcfAGjQ7aJt/Dlr/UKFyGq?=
 =?iso-8859-1?Q?9ndlsWv4EWm3evN+t9L8/bw5GbPzfybN2F5OQ1fQzIHmZrpU7pgnYmNkpB?=
 =?iso-8859-1?Q?PrYVH7x+1+4XhKIN63EEloV0TF1UmwO8Ch3ye39i4yeZdREZCyHwyLNBJm?=
 =?iso-8859-1?Q?fhlfX6L+kaP3DpjcE0ED1SnkPVG207k2A63aJhD+sK6WuSZ7f5usDlPKMZ?=
 =?iso-8859-1?Q?UjyULHuOkmA8GrOmxYdUfMz6lrrPCl/W1ggYw0+JxUAWRDtRUFpkbNwHsp?=
 =?iso-8859-1?Q?CdyVt/3WkOldGMBxeqM/vgbEoKR/1mbmdLvF4sF+xUyu9GA+QkOcwno3ob?=
 =?iso-8859-1?Q?nVtDB+2FscRJLKkM2PLRHshoSfx+9FN7Tqa3pkb6LYU03lWhKZbMTcehpg?=
 =?iso-8859-1?Q?HwlugkS4f5muOfVa0+coi58N3oiT+SU3Sdmy882OOy8dP/CkwQI2xpxpib?=
 =?iso-8859-1?Q?oSQJ/FKHUkqWuybwF9j84zbGDiJZlnGI4ybgvyHGOoDbobrGXdmSQCjAYP?=
 =?iso-8859-1?Q?aJpMQIVm5pYsT5hs/aBP2s/WthwRYLVGF9o/slc3gnSccNL7q7gxVAxY1s?=
 =?iso-8859-1?Q?RcF7HgWOLepVRJiQqfaIht034AddbkAzxWlC2lVScY2yKlVQtXjgIcBBxo?=
 =?iso-8859-1?Q?teB9U89VY1UoDAXH+hXdT2RzBF2xKwKXDxlXajhLIRl/sfdoIN63oGtes6?=
 =?iso-8859-1?Q?R87XMebp0vXY/3PFbUO30181k6d0+VOhJxFOjZ7sY7+EANenRZryVJUGKu?=
 =?iso-8859-1?Q?GtO5pLblXdu6BfSRlzC8xGGem5dyHTmiyA2TsfHB0BuyZ41tR0rSajwDEb?=
 =?iso-8859-1?Q?u0lGdL3dY0wTWRbGvakdcpEYX1AO1+CbukyqfLKpXQTeC03vleV/b1aDwB?=
 =?iso-8859-1?Q?49S7SLUZMo+LAE7Nul3oQZTj+ZTmtC83pTVWzqbiJXpNaQicM/XM+VpA9M?=
 =?iso-8859-1?Q?DgMzxVVX6AEdVU+Fd00uIAl0IrQN6SLOhhZ/TAiGsoh4lnYzeezh3vTw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4a58bf-3612-4fbe-64b3-08db3688d492
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 10:22:31.2478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZ9Zenpu71N6WSRUeBReQa/eC0eozZZovoZZKMOUFf+il4EGnIe66gVhQ/Slr7TZejW9/I9YO8MI/qZmE5JKiXjFxnJsdz56kR5RcX49W4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7647
X-Proofpoint-GUID: QDszsrAUGXLSrrK5ecucttccYxrG6jYf
X-Proofpoint-ORIG-GUID: QDszsrAUGXLSrrK5ecucttccYxrG6jYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_04,2023-04-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=640
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060090
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the Blaize BLZP1600 CB2
development board.

Co-developed-by: James Cowgill <james.cowgill@blaize.com>
Signed-off-by: James Cowgill <james.cowgill@blaize.com>
Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
Co-developed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 .../devicetree/bindings/arm/blaize.yaml       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml

diff --git a/Documentation/devicetree/bindings/arm/blaize.yaml b/Documentat=
ion/devicetree/bindings/arm/blaize.yaml
new file mode 100644
index 000000000000..739115ba1fec
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/blaize.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/blaize.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Blaize Platforms Device Tree Bindings
+
+maintainers:
+  - James Cowgill <james.cowgill@blaize.com>
+  - Matt Redfearn <matt.redfearn@blaize.com>
+  - Neil Jones <neil.jones@blaize.com>
+  - Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Blaize BLZP1600 based Boards
+        items:
+          - enum:
+              - blaize,blzp1600-som-cb2
+          - const: blaize,blzp1600
+
+additionalProperties: true
+
+...
--=20
2.25.1

