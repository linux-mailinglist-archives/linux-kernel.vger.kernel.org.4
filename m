Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E1C6F24FC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 16:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjD2OIW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 29 Apr 2023 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjD2OIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 10:08:11 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2086.outbound.protection.outlook.com [40.107.222.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A28198A;
        Sat, 29 Apr 2023 07:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/GoNFfixzEYWpG9QVF5b3+RSC3czFsLcjyO2IZXS3RfhG7nAAobS+pXh47j+2cUUkxoxuauXmXF/vFDyk6cz9jyycfVhh6p+ZfXb8sAGyEQLZ66DJKOtghV53ofYKGA7QTTzLPnfFBDVNNua0v7dupHBoeVFv16UYQNZsj2iNqRfLTaUMR7TJIUpuZzsce66g9L1A8az+VEu7Q0UwJEQcc66MGZyAQ3nWqXWJnvcgRydsfaSPoN2G/scQmxwMudtlGgBEJ0jraR/j2vKwL1MJMOYe9LHOIVLD+RWTKA389hgYOsLKVoVOJZDZgt9LX/FqX2ql+6SRpvf6ehFEUYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGbQsrCj0OjyQ1tNd3XM6J+lzAV7+sJ7qKHnQtAOIHI=;
 b=oKqrGCX0Z7p3CQ8Bip/99iP+S/GReq2w50/T3SSsq2U9iIWOFBnwtl3fdrVIyO2jHWrrOX99QkRwLTx/op+cPMUyk9KAG3XEHxMBkMJp1+bRenqKKUPzWcU9SJXZI2MxJJlur4Uxpe05Z0lyajQZNVVZ25dmEYyu8cRqx/vUlPB2Ar1kzwhqd0UVUacfxG/5dBmmxJv1z/vcmyoxkpXMiwZjCMEhtFIA5fDGte0naJUTV1oyozoZt9J7V7vLJO/8D3bsNDoTWAkCuXHpF4Y7m9Hpa/mysIpHHgpV/I4hwU5nMMh58z2sA7+z9me0RE7EKA1QwPq/6foQ7dRYBgn+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.25; Sat, 29 Apr
 2023 14:07:51 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6340.024; Sat, 29 Apr 2023
 14:07:51 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "festevam@denx.de" <festevam@denx.de>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "max.krummenacher@toradex.com" <max.krummenacher@toradex.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "matthias.schiffer@tq-group.com" <matthias.schiffer@tq-group.com>,
        "denys.drozdov@toradex.com" <denys.drozdov@toradex.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] yaml: Add an entry in imx8mm boards for Emtop SOM-IMX8MM
Thread-Topic: [PATCH] yaml: Add an entry in imx8mm boards for Emtop SOM-IMX8MM
Thread-Index: AQHZeqOVB2oges4Z6U6KO9QiZIFfmg==
Date:   Sat, 29 Apr 2023 14:07:51 +0000
Message-ID: <BM1PR01MB4899FB61CCDE89E83F0F4D979A689@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB4899:EE_|PN2PR01MB9108:EE_
x-ms-office365-filtering-correlation-id: 18ef2db3-1d47-4150-a704-08db48bb1ee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rq3rvp9QPtil35GrNFSfdLNtZ2VvArqfx9K4X9OLoyGy4Oe6LpmJIX5yGWPghhtQH1ACuDVcd0IAxOZQOP+1u2+0DVlkQCjavaVainR8WBtBWtOt8kt1FrBCDyYGTccR5gGVAptWlVn9dHuj69NZdCk74x78GVEQsfNY0HBx0jNu16tpIvq9jkLIAUdoaFR6nkRhVjNHUfPyjVJCCfYhZiq5sx7ZO4nyJzwFmjj25Z3ji5xzHFFjXoiQ2j1k5uS3zgwD0Ryum42fu47KHs2J31/Jx/bUcjbR3nWrotixvQUq96+XEf8DHflkmFSGeB8ac6K+8luNPE1quDJXWQVlavnxiApS5hk4xd26WANOdbGKwue/H6t8R2AWUWt2h9yNKO+FzAlrrs3F8RgMV25zkUT5uUQAEsk+DzNVWfcAvck84bOsdPgDYTJHT7cjZQp2Q6GdXzznW9tcoih0kJp1ehW8u2/wyAwNvdEJ14a5bkMrTlbzn6o82SzxC4FJWKLarFvATs+7uqjJuRLf+Yk4ljZ2HiGOPcSQF2SiOPEyNYj1b3jr3MVBVZOEddYAYj9KJiInNU5pmb8okvsSo9MPqj7jM0CqO8I9sa49ZZYSmAL9Ku/LeZCb85jwKdYeoWxsbLZJAsXLOARVk8BL/cXXKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39830400003)(136003)(396003)(376002)(366004)(451199021)(55016003)(316002)(4326008)(53546011)(9686003)(6506007)(186003)(41300700001)(76116006)(478600001)(66946007)(26005)(54906003)(66446008)(66556008)(7696005)(66476007)(71200400001)(64756008)(38100700002)(2906002)(4744005)(122000001)(38070700005)(33656002)(86362001)(8936002)(7416002)(44832011)(8676002)(52536014)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ua4knsBSbku5jleT36ct8TNRmaYtsJ3eFu7trxKSrrTrFiuyPna4Y6DOMS?=
 =?iso-8859-1?Q?XoGi/c5mwCT/RAo6OWFBmqdgtln3UkYez1rkqG3ntl+GdFpYChir7GhH3e?=
 =?iso-8859-1?Q?dxhPSHdiCmYgny+UZTwTESn+bpjbdNaRzMm01fTh7qag8XZLH2bKYhp7vV?=
 =?iso-8859-1?Q?pEvBkae2O2YZh+GHDEaMzA3SmH1OR3hC0w9ZoD66s70ikYgB3dB0/vl7Pu?=
 =?iso-8859-1?Q?JT2+5g49L3W+7UMImCJggq32eUc5rHTt5L55esEi2VAp+yXyOyuSxTvBDW?=
 =?iso-8859-1?Q?VGgFAfAGdb1grb9vARCPhn6JlNe5QJ08V6A7bKwUfxKHn4q9Qd+Gwi+Mhy?=
 =?iso-8859-1?Q?QXyHGknxxRHyxT4/MRRBeJ/1AHziWI9Yjikcb7Zcw0cPRmzn9pfo9xSWXE?=
 =?iso-8859-1?Q?BjOcRqjIkVXmfYVZ7fb+m0plPwAs00Aw9OY3Iunub+2vFCdfiCqzfKbGrx?=
 =?iso-8859-1?Q?i4Fwb8tm4C2SqdVe27WNXrQjDk1cGMjTdblbmhQxF4cVF2pXhK45B4JU+j?=
 =?iso-8859-1?Q?CeuLG2txU7b2svzjlvtY1xysqzhhfMIN6SAvuJQatUY2aQARnwDRySyjbJ?=
 =?iso-8859-1?Q?TF5a4BWRh1XKM+dtMatjKCb4HKo0nWDhK72U29+eEyOBMyBasu3Tn0EVFX?=
 =?iso-8859-1?Q?mjOKuGpzMJ4aHYejKSdJZ1HoS8+VNamEJtKn2gnyK3/5qunVqe4wC3lORG?=
 =?iso-8859-1?Q?X9PQrSFK+SVKDgHqFuzjhdptDc7bh9xkZFpVZ5gAH/85qbJj58E/xczE88?=
 =?iso-8859-1?Q?C+bjpFoAFebpqAOQO5URe1ErHE+crRihR1aasABkeftImJxy/FMv6fIaWA?=
 =?iso-8859-1?Q?wpcP2sXk4tipUtQkQdVdF1mnHjYAvscbfBOnqc7d8dNK4y2Bc/grUSrhPQ?=
 =?iso-8859-1?Q?xiRL1fZNZPivsaz0X0HORprMlRtWPlEWy1w10YxNZKSRYS/djl5nPNdYYO?=
 =?iso-8859-1?Q?/uNT7r0SkHGKlqF/i0ai6IAHO0M0WjAprhSZEEVQrZjvM/5AoakFNqjS66?=
 =?iso-8859-1?Q?X16W9VUKV7ag0wGVkXtomUAz3WBnnD/bocnKvlJKuPG5ULAYGeF6Xv1ltN?=
 =?iso-8859-1?Q?6TmagSw4W73nmNu5mXaTNRaSyEb8wbg7IZVmsl0Ffasu2a/fIvUnYtuAlo?=
 =?iso-8859-1?Q?RXRRBr5PpKKu0YFdm6ssZLMwlag4NSc65wtDLSH6wPwvru+JDCF1e2Wgu+?=
 =?iso-8859-1?Q?hN0E3bGc5KT/qB/aire0zW36QpRTTJpIUMnQmIpanqva9wdPn0+zq/ClRo?=
 =?iso-8859-1?Q?ScFL5eve5CLipttLNA51g+HCRq4kiIFZiGbmMPoLA4aZvr6EYC0rjtopHD?=
 =?iso-8859-1?Q?m+NnLpuYwdcOArsa3B17rjd2lyv1oIc3SDt9JiKTTmsJwNyJyatU2KxaWp?=
 =?iso-8859-1?Q?zTyVenXAtQxDzil09bP/nVF3uE/to7yPtusiHUYaw+oJ38ej2TIsA4JIA+?=
 =?iso-8859-1?Q?mGFTIi73TDQWYkXfzOc0p16ZCy0+3Odyj2Lmi4YZr1Ogep6LAoB09YrtOS?=
 =?iso-8859-1?Q?2IjmzCAySBQ80VHhLWa+ZXN4ARi8nrZqzKJL+19SUfYyR8KpSsWjoz7gPT?=
 =?iso-8859-1?Q?fUWhdhALeE6vYszQvzajmasfaXTR2lT9Em7sLp9mqVL+nklqDmdC3evhZv?=
 =?iso-8859-1?Q?cO1BEt0le2mTNFU0Oz+p67Q41xmCM4Ats2wdFRSlvUesjtFJPyMhujS3uj?=
 =?iso-8859-1?Q?0ejrjxdoiZPlm0tgyo0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ef2db3-1d47-4150-a704-08db48bb1ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2023 14:07:51.6965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64Jk7pAjEwzcFRi8fN5aWIzYVL9Iw+fxOnAXk/3iia5QKT75F2hxlUawpqCWKaqp3f1cja/iOiWV1lgBJA3vrLVzEv0vngpLt9s9cJKKv44ulVntjEq3ukIZoGJA8Hx7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 8756e66b7fba0a5063c6011983eb876456504ede Mon Sep 17 00:00:00 2001
From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Date: Sat, 29 Apr 2023 19:32:27 +0530
Subject: [PATCH] Add an entry in imx8mm boards for Emtop SOM-IMX8MM

Added an entry to the list of imx8mm boards denoting the Emtop SOM-IMX8MM

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 442ce8f4d675..61f3beabb1d0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -902,6 +902,7 @@ properties:
               - toradex,verdin-imx8mm-wifi  # Verdin iMX8M Mini Wi-Fi / BT Modules
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
               - prt,prt8mm                # i.MX8MM Protonic PRT8MM Board
+              - fsl,imx8mm-emtop          # i.MX8MM Emtop SOM
           - const: fsl,imx8mm
 
       - description: Engicam i.Core MX8M Mini SoM based boards
-- 
2.25.1
