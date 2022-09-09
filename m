Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786355B3E24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiIIRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIIRs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:48:27 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BDFA69F;
        Fri,  9 Sep 2022 10:48:26 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289Fx5Ib031368;
        Fri, 9 Sep 2022 13:48:09 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jf8yc56qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 13:48:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jI115YXG5tNNHjMJTm5htc1BNqnEkFYLmEs6yOMnxMOQQGNYfr/AeTajbzfEY4xSvWEQZ+D5sPn63TrXq64vrZKT1zn5htTAwWH361risku3Rf8yOOIWV/rydHXRPYO/MGSbKzajWSt/LLoSyNaxjkza2iwS2OdOka4vRs8JIaQUR9ZkzyGxALmCpRzOUgsgla/pkTY2mF939a14n9uHqastZenFsNmPZ9PNZSljCAgC9UHEV5HkkB5ywNIFpMbtzyxDLjBeXUf8fo500IEsfAA1FEeYzzkbC9FH7A6ibdRe3wJalGgmds5cfJ2sOisIaOWQzS2lMKR9A/F6R6bfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiA0fXyyQS3zuiDBMmZ7Vc+R1fdGuAkUmV4V2Txf4Tc=;
 b=Mx7RHyRQlxXy6Kh6+6NaYSFerSdb5fs6xIaoYnxMQpu7ZfEYu8HUH7/EOwefnQ1VfuM+RuDN5cdJNKF7Q+uAlKlB/qd3DPCWhAR2VM7LBsnJmyYuM86YZOnKZ6Tcmg0L0u9Ztw+EGAzPuYfH4PUIlvrH7IJw6PZ2kMsVedUUHTGQO+J0yDtZ/kHw8NJS7cK7RXiWI4tjKhzrtqj6EDdFChhVMVO8Zo0ApUo5MDOlrzZIf33jX3nSeG+FHE/M9VRqOgZnIpQZkP6x9AOZiSENQFd4LIvd5VEoaliDCghgWed93IYO4Ka0ie5dlgLLE/+PkUZsJrO3EYUuo0SlXUo38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiA0fXyyQS3zuiDBMmZ7Vc+R1fdGuAkUmV4V2Txf4Tc=;
 b=j3gt9FuoTYCE55+u9QeyaaBgqXxvm8X1HfmBGGeXvtS31Qem2VQG74B2cEOZO+jtM77J45AhuVVSmIFgBK3///w7CqGfB8i+OKoZJCO7qrkPK43Go76gdetr34uQTDPiixSOrEFFboaeRFjyz2XFaBCtBSvPhlqV6z/3ENUup3M=
Received: from DM8PR03MB6247.namprd03.prod.outlook.com (2603:10b6:8:3b::6) by
 BY5PR03MB5144.namprd03.prod.outlook.com (2603:10b6:a03:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 17:48:06 +0000
Received: from DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::781c:6cba:d36:2971]) by DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::781c:6cba:d36:2971%5]) with mapi id 15.20.5612.022; Fri, 9 Sep 2022
 17:48:05 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v8 3/4] dt-bindings: hwmon: Add bindings for max31760
Thread-Topic: [PATCH v8 3/4] dt-bindings: hwmon: Add bindings for max31760
Thread-Index: AQHYxFFeyfAJY5xBI0Cum0e0PCDEpa3XSTGAgAAFxwCAABDn0A==
Date:   Fri, 9 Sep 2022 17:48:05 +0000
Message-ID: <DM8PR03MB624727E043782EC34DBBE6B196439@DM8PR03MB6247.namprd03.prod.outlook.com>
References: <20220909133718.388213-1-Ibrahim.Tilki@analog.com>
 <20220909133718.388213-4-Ibrahim.Tilki@analog.com>
 <1662740789.477872.1507147.nullmailer@robh.at.kernel.org>
 <20220909164710.GA1537271-robh@kernel.org>
In-Reply-To: <20220909164710.GA1537271-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaWJyYWhpbS50?=
 =?us-ascii?Q?aWxraVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLThjY2NhNTczLTMwNjctMTFlZC04ZTU4?=
 =?us-ascii?Q?LTdjYjI3ZDcyMzFhYlxhbWUtdGVzdFw4Y2NjYTU3NS0zMDY3LTExZWQtOGU1?=
 =?us-ascii?Q?OC03Y2IyN2Q3MjMxYWJib2R5LnR4dCIgc3o9IjIwOTEiIHQ9IjEzMzA3MjE5?=
 =?us-ascii?Q?MjgzMDg3NzM4MyIgaD0id0QwcGwwTnNPaUJDaW80NmtodFBjcGxzd2pnPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?RW9DQUFESHJpcFBkTVRZQWUyeWVlL0ZQRStpN2JKNTc4VThUNklEQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQVFBQkFBQUFYNWwyS3dBQUFBQUFBQUFBQUFBQUFKNEFBQUJo?=
 =?us-ascii?Q?QUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFk?=
 =?us-ascii?Q?QUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxB?=
 =?us-ascii?Q?R01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpR?=
 =?us-ascii?Q?QnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFI?=
 =?us-ascii?Q?QUFjZ0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIv?=
 =?us-ascii?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR03MB6247:EE_|BY5PR03MB5144:EE_
x-ms-office365-filtering-correlation-id: 58331dfc-e65b-41ea-95ff-08da928b7319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TgbNqhHaurKq7Of9BbnkwQm2ZiLwPfk/xrRsmTxuTaHa7484WPnqqurVrDmRwlrE3pKjkD/pfRFkg6QIHVwgNseyQWKjNM64eHmlPGZmCP17Qko+6faQQw/Vgv+fk/aOvFWBVzis3VRv/0FVCBQTtkE0MZX740acn+lrWyRK2tVB2wZx/aLqbHx6HzrnlyDEmv+Xl94LZXQoRZyP6Nk6/klPos5ZGqKaemfdPDHwqOg9llzhyaKiV4QBmjXdK8+VmpAgSEh2dVI5KpX6vXe8t3BLRM39pUp9CDrQaRCYr61qGRG4/SQYZ9XeLLA2PJ9VCMl4UWXPX48cUX8BI2ELIj16xK8w1Mv33l3ZxG3VsM6fM2XHS6O+i1ies51xl5Jza824HL8C1yMGkdRkO63Up++YGHPV1nzbGxhOmbz9lYKq69E2beHrmf44AnRDhbUHyj2XY6+8vkot3bY5tJPlaw5k3TMGJZ2PK3i1AuWVe7kOg4y4y5EnulsuZ5HdqU/O/K5eKdqNFxxxe+O9Hf2JlwWSDdMUD8HREt4jqdME70Ox3k8THD/XKRvuSCvu9Sa9Gnymb29D6CJN6YhEGJzk0ItwVTm4J29GVWI1aqWa3YO+2S1WXyvd/VUWR6xPXlKUJyFyenb0Pho+9goTlcDfHgAd9pZHX08h7vVTzBsOKR83LPOw3wdep6HssD1uU89yH2PMUQfT3XWXgjS1NT6oifNwkELZFTyeKYtfQUF/15p1SJ2eALOZ72xLRSAYG5V4D88dmAZTfbGWA7z7PoijCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6247.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(5660300002)(83380400001)(186003)(38100700002)(33656002)(316002)(54906003)(2906002)(52536014)(6916009)(8936002)(8676002)(66946007)(76116006)(66556008)(66446008)(4326008)(64756008)(55016003)(66476007)(478600001)(38070700005)(71200400001)(41300700001)(26005)(86362001)(9686003)(7696005)(6506007)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lLoKJv8PsW52Dl3rVS9ARVy4AairvN9FfYqTFZEbs60LZpghxi0A8ksERPQi?=
 =?us-ascii?Q?SL6YB0uSjsVxTXjf+gyzsdLrH0vWMBwHR4VkWF4O0Ro42RQDeWcf4MS5adG+?=
 =?us-ascii?Q?tvBmjMvEx9mBr/LQ22lNz6B7kxvbGYqiJt0Mc4Pc6Ln3G/uae32XuRffZ53U?=
 =?us-ascii?Q?sK7SGCqo6QTXkSA6FThYfIqfnOzKUXY0fjE2XUMlI9tio9e1Zg5XZkvO/a3K?=
 =?us-ascii?Q?p82C6j19NMbsvMXinAVIZpnin50HEU4bRp4w7ddCdcKkzNnFaLLqoUol+hc0?=
 =?us-ascii?Q?rxYNneFq9wTKTR/mTlZDO9R5PyGm8Bv8S7vBgjSJTmJxN/fsH5RRlNABsAfZ?=
 =?us-ascii?Q?ZMLAnaTOtE8GOvgwdFC8Q5Bpua+StwaIkwB3/5IInNkBalXcnulMcOg8eRJS?=
 =?us-ascii?Q?sGAgERYiBTJxCyheS1T9zwS6fKNdpztCI52OWfdEuKgLE9PdVI5IatHR3Je4?=
 =?us-ascii?Q?mm3gLROIczIrHpVJl/dQ9amTEXCirEBsAUpy84YYSXZBnKhm4jqL8+JPGROA?=
 =?us-ascii?Q?y4I7qZnTuwPainwRGTYcCdLg4oheSeULS3FUD7oJKAGvOR6BmZPWGt5T2/+T?=
 =?us-ascii?Q?VhQWzc3FuxPKMgKFkF7cGYMBi46I0eK2CTLz+MyMdiHlsWOuuOjEPad8vMzQ?=
 =?us-ascii?Q?vwYN7SVTtJm4eQFdMVhHwUVKemj9j9LbVVeDSYhAKzEthMe9xdA9+nC853Ru?=
 =?us-ascii?Q?6vC9x7j/8gEIoeGQzER9gQxh/2sHdPYDxjjx89KPU8yeKoDEbOp3dgmVLoiS?=
 =?us-ascii?Q?VRLJugZULoTd9AFOVUxxcqqMBVljVJF/H9lAYLBknvXfT+dhK0Bb3jBzQ56O?=
 =?us-ascii?Q?PmySTpqbDfhYAHiB45Ez1tAZWgijhZSTY1MsFbfF0HgES+rZaKTpz3aI9wkj?=
 =?us-ascii?Q?Fhs/oF43IBuMWIeyDGHWdGlYqxlbsH4lsz948i8JwmjkpiV7Ruyd4HU8OhYM?=
 =?us-ascii?Q?U/6B8tBut5V8jMxMqvPOUvWQv1r+d6zwCw2g9Mn2uyNFeLPrc2Sq+Y1SZfpU?=
 =?us-ascii?Q?ceY9kcGVEPv94Kk43gqgmGBoLO2Q0GGrWWKxWffb0bX3Zz1MMkFTz3t/6ezt?=
 =?us-ascii?Q?FdlHWzADLpVNloFAZnt7sizLeYPUZMhCWZWQJQOsRVp6xWxsNF9nlMdcmNq1?=
 =?us-ascii?Q?8/HAFjXgF8ocqbh8pwDbV31HQI2ip1zaig/ANovA07QkcT6XQCjVZJNqNPKb?=
 =?us-ascii?Q?BD9I+7DlLBvQaGAEAYx55C9/nsJx1AEP+kwR0UtaEdOMcaAfG8yro8UPwdxC?=
 =?us-ascii?Q?YkwniUH0P+tIdga24awOBsg3V+4LHPe0UBuALQ9iD+JEtLxRtuBrm0Zc9w2+?=
 =?us-ascii?Q?GG4pKUJFwfVbwADy2Vgl86ShAUuJq4BDR/0Z4ZDzTZrEu5jedGQcJs03wgNi?=
 =?us-ascii?Q?5g1DM6tlDPDxk0rB4I0rv6mTVuMnba9M6b0p//1N92XLqVww1qgR3X3/G2lR?=
 =?us-ascii?Q?h/bGSKYhcf+8R0xOIpGe4Sx+YBjTMGu5OTC5gOP4ohQrX2RpBkbIiTZ5v4HZ?=
 =?us-ascii?Q?Gcg8gytxFC91SPu/fOk2/uDGbDUbbvtw8tYtOsShHWjGCnqIZ5GaJUXg9YLk?=
 =?us-ascii?Q?maPh7LIcVLuPEz9mQA4hdSO+PXsKBpVX62Rw48VS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6247.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58331dfc-e65b-41ea-95ff-08da928b7319
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 17:48:05.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RGDELryuiAHhoZlGfJErGLWO2N5hySmIhGNi+7DhaobFFPmgXoLKCH9KvLcGlC72Wx0hsbGqHkbXKo+dhcv1ADOyFRYl4kF5taGpW9tTks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5144
X-Proofpoint-GUID: NSYOannz-7evMOWVKDSrZTSWtt3H-EbN
X-Proofpoint-ORIG-GUID: NSYOannz-7evMOWVKDSrZTSWtt3H-EbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=567
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090062
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Sep 09, 2022 at 11:26:29AM -0500, Rob Herring wrote:
> > On Fri, 09 Sep 2022 16:37:17 +0300, Ibrahim Tilki wrote:
> > > Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
> > >=20
> > > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > > ---
> > >  .../bindings/hwmon/adi,max31760.yaml          | 44 +++++++++++++++++=
++
> > >  1 file changed, 44 insertions(+)
> > >  create mode 100644=20
> > > Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
> > >=20
> >=20
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> > ./Documentation/devicetree/bindings/hwmon/adi,max31760.yaml: error=20
> > checking schema file
>=20
> Not sure why the error is useless ATM. I'm checking that.
>=20
> The problem is that 'reg' is a matrix and you need to either fully define=
 it or use the simplified form for a single cell:
>=20
> reg:
>   minimum: 0x50
>   maximum: 0x57
>=20
> The full, expanded form is:
>=20
> reg:
>   items:
>     - items:
>         - minimum: 0x50
>           maximum: 0x57
>=20

Actually it passes the check when I remove maxItems property:

  reg:
    description: I2C address of slave device.
    items:
      minimum: 0x50
      maximum: 0x57

I cannot find a way to specify both maxItems and min-max limits.
Which one should I drop? Line below is from the output of dt_bindigs_check:

hint: "maxItems" is not needed with an "items" list

Regards,
Ibrahim

> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding
> > s/hwmon/adi,max31760.yaml: ignoring, error in schema: properties: reg
>=20
> > Documentation/devicetree/bindings/hwmon/adi,max31760.example.dtb:0:0:=20
> > /example-0/i2c/fan-controller@50: failed to match any schema with=20
> > compatible: ['adi,max31760']
>=20
> This will go away when the schema passes checks.
>=20
> Rob
