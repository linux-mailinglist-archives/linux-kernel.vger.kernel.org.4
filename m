Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C67270C0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjEVOTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjEVOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:18:57 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDA7AA;
        Mon, 22 May 2023 07:18:51 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MC7EEB000643;
        Mon, 22 May 2023 10:18:14 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3qptu6jtxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:18:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIYpmB3hyjClkIql858TBvCCLq0sxo0qa/PTl7wc2iYem4ETogP+tA6l4imdxfybSadlK+RxFnO0LrpsmgGfv08Wk853GnTSwM5m8nt8fW0Fdk43MSliZw+knL0B4TFZFjf6RkAW06PTQ9XCJN2Hm+BEzqrT42JwDWeGmZYdpRooMB80UlSZhxJaMwbpKNAoMzcn7cb+P3Y3W0NOXXM7463Ts/5oRWXk3HQ/77K6Xq9SyUBEgiU74kwIr/y0qYov9P2WTBnie5u/zaS5nNM+DemoLY8NUlPjreNWFYkDpKdYJvI9m2FFlgvje+JOU0DA13hF07iu2VWu8mCFObguOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu/lewuzAPiiYPOnuBMqIZyH+CO1RzqYpGqP8s+hFT4=;
 b=gm4Z3AmR2nXqSaMuJ2qFRL2xuqXh/uc/Z1ByKcCnrXcNg7cWBjmXXN7kx1jwzJ9lp24ggajlQcHlqfnyebdYhjhVzjChyK6UArQbetwPK7X/GlN9sTvgeJDoskz5RNBByrCDMmdrGDJK3qHcpPGkhfQqlqrHTwi5NO26G9KqY0IZkhGLrMEf+ccJ3xJIJbZMY//B4gWQL/n0tzNJjJBuVoTT5Oj7EBCvi71RhewHRdEvpd07hkJHZbHYH+mIan1Ob24lHJtgSJ+1DmHFAdQoUbmgZT7YbiIWBvdCqRoYMW1d58Aqgi6rIy4FUx20MbzT+97OAFRL8vCupl25mVGmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lu/lewuzAPiiYPOnuBMqIZyH+CO1RzqYpGqP8s+hFT4=;
 b=MjFjXXuAuDXY1ny5pKnC1xw8SiIfudO759Xh9m+s/wfAhbrRrIrwuyNoZP+xfZP6ejKnDqVhfQH//vGqQ8dCMW41BuYj47Xb6IfQI4Vg7irKLPIlFkDVxdz99zW9hjIaH5zpxlqNt1Irn4yhuG0P3xuEDWXH14Slfmi8W1gPCi8=
Received: from PH0PR03MB6771.namprd03.prod.outlook.com (2603:10b6:510:122::17)
 by SJ0PR03MB5455.namprd03.prod.outlook.com (2603:10b6:a03:27b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 14:18:11 +0000
Received: from PH0PR03MB6771.namprd03.prod.outlook.com
 ([fe80::a7a:6dc:addb:aa4]) by PH0PR03MB6771.namprd03.prod.outlook.com
 ([fe80::a7a:6dc:addb:aa4%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 14:18:11 +0000
From:   "Matyas, Daniel" <Daniel.Matyas@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v9 2/2] hwmon: max31827: add MAX31827 driver
Thread-Topic: [PATCH v9 2/2] hwmon: max31827: add MAX31827 driver
Thread-Index: AQHZh+OySu2N90N0RU+tieZpCTNw1K9mUcYAgAANiKA=
Date:   Mon, 22 May 2023 14:18:11 +0000
Message-ID: <PH0PR03MB6771D471E1AF58B0B50FE4D489439@PH0PR03MB6771.namprd03.prod.outlook.com>
References: <20230516104609.7095-1-daniel.matyas@analog.com>
 <20230516104609.7095-2-daniel.matyas@analog.com>
 <0e49e860-6f2c-48cb-9ef7-af7891b95237@roeck-us.net>
In-Reply-To: <0e49e860-6f2c-48cb-9ef7-af7891b95237@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZG1hdHlhc1?=
 =?iso-8859-1?Q?xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?iso-8859-1?Q?NGJhMjllMzViXG1zZ3NcbXNnLTc5MTI5NGMzLWY4YWItMTFlZC1iNmZmLT?=
 =?iso-8859-1?Q?E4MWRlYWFmMTM0MVxhbWUtdGVzdFw3OTEyOTRjNS1mOGFiLTExZWQtYjZm?=
 =?iso-8859-1?Q?Zi0xODFkZWFhZjEzNDFib2R5LnR4dCIgc3o9IjQ1NzQiIHQ9IjEzMzI5Mj?=
 =?iso-8859-1?Q?M4Njg4MzY3ODUzNSIgaD0iMWQwSUo1SnM3OGU2bFRDUWN4cG9xWjhJVHlV?=
 =?iso-8859-1?Q?PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTk?=
 =?iso-8859-1?Q?NnVUFBRW9DQUFCSE1YYzd1SXpaQWR1MmRwQ250LzJJMjdaMmtLZTMvWWdE?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUVBQVFBQkFBQUFTakVYeHdBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFKNEFBQUJoQUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRz?=
 =?iso-8859-1?Q?hBYWdCbEFHTUFkQUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFR?=
 =?iso-8859-1?Q?QjBBR2tBZGdCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQU?=
 =?iso-8859-1?Q?FHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VB?=
 =?iso-8859-1?Q?WXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWVFCa0FH?=
 =?iso-8859-1?Q?a0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBY3?=
 =?iso-8859-1?Q?dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6771:EE_|SJ0PR03MB5455:EE_
x-ms-office365-filtering-correlation-id: bc72176b-bd60-4e2b-009f-08db5acf5fa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0xGhir/Qx6PkUMSAs/K1tknN+o0cvfxCuabE/51L7Bv0nFlVZVXOQd7t7hOE0TEwULToXMQq3OYLFfsfknMWgErX5MXEs71fusAcPakTymdj5yQIwF8LYA+11FcxLZjbWl2J4DZXy2TMri5UYCCAhLJpZedpFgFDawWOs1alCDMF7+pnB+jhYRNi4JQEUb5+VGtSoDzk9EZvWqJaUpUbWCHlTZ4bhkMOz2EMd/V20vY6oWlvwY0ba0t/1XoUoKSiJQHwPVvm8gCrIYummcGYAS+mud2rFJS+EINBlZ6wTDTxtVNurI37siNP4hMiRUFo9LxgvsYc5/Hen3VWFZc5zg8pWRZQzHiCDRsws/v1Gp5l0YGCljAWURNHxI3JgmhfvnNAaexfHHrouBJuYl/23u/D/1DOL2+fYYkZ8jPDOnVwQMEd1owtJKemqwGwZN972arRp7WEmZvcRg78ZjgTFUDXPJgZWHTLRNWm41O25tRRV9ukHzU7sytxSiFRNu7pm01w/LUO8cr1AdEV14pHCHKczRIvDMQRHcTW+nngkH2V4oQB09bEJ33MAsyK/s3u98Jg3P79cShDNcxgGik5AQFNG7bL97jwAXksIs258g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6771.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(2906002)(66899021)(7416002)(52536014)(5660300002)(83380400001)(8676002)(8936002)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(966005)(4326008)(6916009)(54906003)(316002)(478600001)(71200400001)(41300700001)(55016003)(7696005)(33656002)(86362001)(26005)(122000001)(186003)(6506007)(9686003)(53546011)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L7ZQEUn0Kx+okD7c7FwBPHxOyKCGgGvNiN9jxPpqPhWd0Ql+mQz/gIznry?=
 =?iso-8859-1?Q?EhKzSaUU48eCSaf/YJCAZI3wQLKwfT4bttYG9kTcVaJ4jLBvrn6O6+PZiG?=
 =?iso-8859-1?Q?NagZOoo0G6160rJq8phhWawktMAfYoN+RSPjNBGKq0PGpWuKvQlIopXOzq?=
 =?iso-8859-1?Q?23PAFPzkDHWwxV1+UqzdLgmw1TYcIlmQlQriBaDi5hCebEkl6gPlDfYzhW?=
 =?iso-8859-1?Q?QfX2q2ew28TCxWSxeYyQnpAfYTRRaQDv0y9IBwSDL8c/H8XoTiecQeShRP?=
 =?iso-8859-1?Q?jIUVIf/ecowIH3xCGrNdYNuCoCyc/o4e5WeuuxCD900JsG9OBmUSUHUAaX?=
 =?iso-8859-1?Q?923/GoFQMfFG5UD7MuaUQ1mPIE30MeqJ1QVijb/4dDBx1wocQbpxkfDG74?=
 =?iso-8859-1?Q?S4WxvfeatTZ33ytOQPu0wVTSj4A5t/inPYVyyRBhrxE1RFDqDPrgXu93Ep?=
 =?iso-8859-1?Q?35WVQ09+Qw7v3jBq1OkAAV/wh5dc9SIXKbiGwBCUJ04ZVjj5V48PcbvFQR?=
 =?iso-8859-1?Q?LCa+j55AkdeAm+S6RTPYJKBiWyd2yeiABpwf02GKw9dq92QzvrbjsdFB7z?=
 =?iso-8859-1?Q?LrZf3i3/cxIujUWRz89YnOR9owIPLdiRDtxnqDp5hMsWm4CZrK9GTeJ0Zl?=
 =?iso-8859-1?Q?u+GMveL1zNJuH9uFsfdER24ZBsws4Cp6xsa+OszXrcXT7ZB/bJkMLNup9o?=
 =?iso-8859-1?Q?fvg0FJdDNjYIE+51FAS/QS9u11XbvHpRGA77y6vft5B5G22lysqmftXlzz?=
 =?iso-8859-1?Q?tnqBagJsXgK4FHQdWAlszEWIH0MxM4xd4wxOa/lEKxix/YynNn5v+F240M?=
 =?iso-8859-1?Q?Q4ZL0iYjHPCMfRvq8LO0J0gW4U8IMWcVIewQpRy45DrXj/3Kz9FK6Cl9Hi?=
 =?iso-8859-1?Q?ehqE7UwsMsWcKwpSqcUbihYJW4cK6MKdDleIk4FB8Djo8t0gubWKb4OGUu?=
 =?iso-8859-1?Q?RAmzp5LtfRJIFsB8ezo4ZIUMFCkoCW+4YogGcyTNZT3e+9My9TFjJSObwO?=
 =?iso-8859-1?Q?1nnO3ql2iDTinF1R9ENkkAZ8sYC2RZavCX3U42/tL/7JH6Ac+zgodRyMcp?=
 =?iso-8859-1?Q?NCl/HXERpbk24Zseqrxer98clbQRnvNx9MNOg4rdItDC1nz538LNIv3tPV?=
 =?iso-8859-1?Q?OCMm13L65memTmHauX/j1AXyU2W/QVbXIrbBdl8UqGrzaiuHuKC24ctnv/?=
 =?iso-8859-1?Q?sKcZVYaD0x3nEHuEH2cwtRihad+4c91vSlk3xSrGjKsGVk6RdDw1K/tW8P?=
 =?iso-8859-1?Q?YZ33qXMUuSoOah7FMRQ7LXda1ccfJitJKUqF3Z1h+aphmop5utWhKdJZSy?=
 =?iso-8859-1?Q?Z0b3yEtJXQ1TDbaUltytqTWkEgkKd7CqrtFvyfKjqZ/+MHZi3KqhI8aLCP?=
 =?iso-8859-1?Q?KLseJGKokVwb/MsPwZxncIVtmY8PRJIXMzgftgsc4nCQT1mJSlUW11goBJ?=
 =?iso-8859-1?Q?c6+L3VHUusRh3xjbQxoKWXjvbYRMwsKhXug0YlGG86NlaoIraLWWC7h/1e?=
 =?iso-8859-1?Q?c90WM7psOyNyRoDv9AyWH2Sl/cnw+EvKKSmjNQhl02zEw+VIRaUFng02uJ?=
 =?iso-8859-1?Q?1AvylDg89HraT2BJja7qDmRy3LU5JfiA/C3r8jgCdnMejIem2Q4KKCPyLw?=
 =?iso-8859-1?Q?vNBERz+HPUDdrxD6oJSmwOvnZAGWx5mQK/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6771.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc72176b-bd60-4e2b-009f-08db5acf5fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 14:18:11.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: defB57dMPzAb77eGU4ovPUyfyjdKMU05RFClVXDzKm6/yNdAQr+VRimpVl/UGq2YPgcEGARGg4ACLUgHkuU4rjoPvXVq2qAJexieuyHMFaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5455
X-Proofpoint-ORIG-GUID: N458BYzrtt571VeECC5tXsZ-blBEC3Yj
X-Proofpoint-GUID: N458BYzrtt571VeECC5tXsZ-blBEC3Yj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_10,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 mlxlogscore=717 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220119
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Monday, May 22, 2023 4:25 PM
To: Matyas, Daniel <Daniel.Matyas@analog.com>
Cc: kernel test robot <lkp@intel.com>; Jean Delvare <jdelvare@suse.com>; Ro=
b Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt=
@linaro.org>; Conor Dooley <conor+dt@kernel.org>; Jonathan Corbet <corbet@l=
wn.net>; linux-hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-ker=
nel@vger.kernel.org; linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 2/2] hwmon: max31827: add MAX31827 driver

[External]

On Tue, May 16, 2023 at 01:46:07PM +0300, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.
>=20
> The device is a =B11=B0C accuracy from -40=B0C to +125=B0C
> (12 bits) local temperature switch and sensor with I2C/SM- Bus=20
> interface. The combination of small 6-bump wafer-lev- el package (WLP)=20
> and high accuracy makes this temper- ature sensor/switch ideal for a=20
> wide range of applications.
>=20
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link:=20
> https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/2023
> 05112351.DBkFfs76-lkp@intel.com/__;!!A3Ni8CS0y2Y!5SeqSdRyCHcgA6Se6U-EN
> I_MJfRPgB-FEVkuwWyb944DQypaZ5XQAS6N3aZiVDd1LZDGK45xp7KJHH8RSzw$
> ---

Change log goes here. Without it, I'll have to manually re-review and compa=
re against previous versions and look up comments to ensure that all feedba=
ck has been addressed. That will take time, which is always
scarce.   don't have right now. My apologies, but that means that
review and acceptance of your driver will be delayed.

Guenter


Dear Guenter,

I didn't write a changelog, because I changed literally nothing in the code=
. I sent a new patch, because in the previous Krzysztof Kozlowski asked me =
to remove the '--base' when using 'git format-patch'. I wrote this to commi=
t 1/2, but consider it necessary to write the same thing again in patch 2/2=
.

I have the Reported-by flag, because I forgot to add it in patch v8.

I am sorry for the confusion!

Best regards,
Daniel Matyas
