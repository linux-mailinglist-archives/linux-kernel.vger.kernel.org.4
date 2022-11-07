Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF3D61FF64
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiKGURB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiKGUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:16:59 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18A3192A1;
        Mon,  7 Nov 2022 12:16:58 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7KFDCN019948;
        Mon, 7 Nov 2022 20:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=PYPqWrATREPowq2Vdqx9TSCssQ6y525tIlTeiX3JwU0=;
 b=ZYARryLVCcjZfokpbq6LVKeflVas/WNOuY8gRXcd3xsWT4vkgAmOo3fKzQrd18NyB3Ws
 fLrJphhKzQ6JG+FgvNcQBk39F327vmosqQqC+fK195eJgQEhFYbclo3rMNhpY2AeHyyB
 DoXO1zz8LNUuoOqVxTU9gdINGVT29wjlbOUD/RBkxkeSIG1KNRuLZME7layG8z3E4250
 4Ph1vXfhMOGeusif/wXPHbKzKJlrbE25/ww2IQFidTHAPMUrkO/qyNLXwlFxL8WTVqJV
 H5r0UNPgzybrZnwn6KkMgleXGiXWyX+plWQIEZrpSDvWEY4DULk//LIAssWY3j4hulNG jw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kq8vsr0ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 20:16:37 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 22EC4809F47;
        Mon,  7 Nov 2022 20:16:37 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 08:16:36 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 08:16:36 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 7 Nov 2022 08:16:36 -1200
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 08:16:36 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfXE1saBuJnclQ1oz+rIx6eZesrg60NwTeGJ58IpgcP/Kf8q3vsUEZFtJyerMz4BVTwsvYNl1+avE2wdUFTz6rIa3smzWFMgJJcTlRgqfSxksZymNL6W6EIVVl1cmAjnJg3CSryH7v2U+mc/wpjqleoaQw7bJxmgjaGMAKseyElSUHHvs1XS02zUb0uIoCwoO1AF/N3QRXLP0F5twYSo65Qt1xxP0ZcI7yMFRO8O/mijF3nZmqraS6Io93E5YWuya0/6HC3//4h0dyUJ6gpWD7dFm3kyoDbW93H0XffWlIC3TqsSESicG9UCln4ZTqUw0jQ+yTNrILG1NOltcmdM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYPqWrATREPowq2Vdqx9TSCssQ6y525tIlTeiX3JwU0=;
 b=HcGrSLsKXaKu/sBvjXrMl8ANJAqTQR7SHH6SBlE0L4hLmvD5bidMZo30WQDnlFof693XASONWkpTEYL1LZlTbw62JyUOMsN8SMRxhwao4e18Qyx/niq0k0AMSUPraHktj7GtEiMgCqfF6LKtjFfbw/3y7x9Ssw41HIhS3QmfukNILer1goydmr0jyDPZVVOF4AhiAXkod/nG1XFWHq4igLEQB5ESu4vxeHFCePEMCXU4n85IOleEVpB008hllsJRPYPD1RmYkjL9+gW8I96VrqHWHZMsgPO0weCPRIh/SAIDuop3PRn8HwVGReCUrJPgFUyoYcoz2gKR3tXN/zU/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::14)
 by PH0PR84MB1432.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 20:16:29 +0000
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5ffb:817b:2f19:b2b7]) by SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5ffb:817b:2f19:b2b7%4]) with mapi id 15.20.5791.024; Mon, 7 Nov 2022
 20:16:29 +0000
From:   "Yu, Richard" <richard.yu@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for gxp
 gadget
Thread-Topic: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for
 gxp gadget
Thread-Index: AQHY755tsrsf1u+J3EmTaEhUe3W7664tY7+AgAaG7KA=
Date:   Mon, 7 Nov 2022 20:16:29 +0000
Message-ID: <SJ0PR84MB2085E6B922DAF1070DC802EF8D3C9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103160625.15574-1-richard.yu@hpe.com>
 <20221103160625.15574-3-richard.yu@hpe.com>
 <b85230d4-8fce-ba49-0d6b-8c4d20132cda@linaro.org>
In-Reply-To: <b85230d4-8fce-ba49-0d6b-8c4d20132cda@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2085:EE_|PH0PR84MB1432:EE_
x-ms-office365-filtering-correlation-id: c684446c-f1b6-42f8-a722-08dac0fcf486
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i3n7Jn4AsTbFsU0bAB/HogCVeIO+9Fr0gjwv2BE4IVArQmLGkaiv61CyE/6c7BhuOm1oPhdvitL8P+DGMOosGT4pvI1/neULeo4ak8RvSnw7OAFnpoqfhMzlGaLi5F8inTvq6tWEHDm20scF98HtBbwBsHGnrl5Y2DaVrl/+tvVyaCtBTMNEkZw+P50IIT0ut0aswsLPuaHef3Aylbh8Ek83hW0w1kw15TtflO2oy8cPxbsyyVSTLH6nMkjtE7q7agQecdhxlgHW9e8UZQqbmCt3K+24jpFvg9UySot9BpAoiggzCqOfDcKtgd9/9WhEHIChMnnLBiAaJIq59EzJjB9BYoWyo6MzZ2ro74OxGkxWaE+LR5j0lpfjiCBGnea3Nn/0obTg4Mxdz07dXxHUj/yPWozU+Fmnq++lbP2NGfZCW0Ye3L29VjskQHxX1vdvHRu5W74pDeUVOUPQPMmZSUA4XXGl2Fedae9QwYuB2A7kCl+BS87j8iGvmpSEs6gDH/MPgzNczFtpkV4EMeFLlIAS8UrrhTh1WGoxBCjnrYyYIFCHAAvp2doYkcCBCFmqcx09HjNUVxVH25LtpB5haf/5U0LBj8fOIDpyMmcjJe3WjieBsyqvixZU99JpORysvkD4SbOSJTiZIRM2SyxtyxplKc+WT3bDI2lYexTHvgIow9bCbEYs1CaT545Kzu2zVqI18aLqsEcH5SJ5cq729zbkekoR1S/OSIRXx202eMDxCV/ybx68OtNsPAjmY4Mr2MdjwKbqlEEoJKXCKQmjI2uG1CYJNazvV497u1Af2QY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(6506007)(478600001)(71200400001)(55016003)(2906002)(66476007)(38100700002)(33656002)(38070700005)(82960400001)(921005)(9686003)(122000001)(83380400001)(26005)(64756008)(7696005)(186003)(76116006)(86362001)(66446008)(66556008)(66946007)(316002)(7416002)(8676002)(110136005)(52536014)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU9LcGNYTkkrbWlkcHZyY1o2dU9HSjJJb1dMWWVwek9CVzlUNUwwTXhhRTRh?=
 =?utf-8?B?NVA2bVhCNkRvYjI2WTBCSFE3OUk1RWdiaUN6WXlyUEpWMTZJbHdOa2JpbWUr?=
 =?utf-8?B?WGdNTk9icTJ4UEUzRUdBazVDT3l3TkRKVUpIcVRWMlVQNktmMzdmYmhkekJV?=
 =?utf-8?B?Z1NkZjM3SWh2NzlmaEV6M0R3S3lxSXlySzNsTjR2dlcwSDl4YVBIa1ozbDlG?=
 =?utf-8?B?WDZqbnhLZzkxYk1zZWZ3U3g0U1YwOUdmV1FDdVcxSTh0UWNqUmFuTklxYTBx?=
 =?utf-8?B?M2h2NEQ4MXF6ZWNlQ01kcmZOREdZb0ZQUFFXWGIvbnlab21aM3B3ZldBWFZ2?=
 =?utf-8?B?U0pRVXA2Wi9UMUYyUzAvSFZLYXJRdEpnSytaNitHOXlvVklUeDIwSG9SdTVv?=
 =?utf-8?B?R3FRK24rZjVESzk1Vm9iZWhTS1dzb2lpNEVRdFYvcis5M1RaSlJ1THJTOWxh?=
 =?utf-8?B?cDEzOEp2bDEzcjh2d3QxVXJUeTJZZTg4WkhRMk5USGNQc2V4ZFhKQ3RQazA2?=
 =?utf-8?B?QkdXSDk3RHZtK0pmcENza09XMVNXZk9Jc2JsV1lQdEY1STJTeFNTdTZ6K2h5?=
 =?utf-8?B?NEU3SFY3aE0weG5Cdi9hREtxeENRVTJ3bGtSeVFVRTNEYzJDWGxyZGpMcWpu?=
 =?utf-8?B?bjE1NThjRkJiZll2b2VSS1hRWnVGVDVqb1JIRktqVG82dmtSVTNjV2pONzVY?=
 =?utf-8?B?TStVSTM3Vlg2czU2d2E3N3FyMGhMb0lFVFdCTGp5ZUVqYXlLRExCV0ptaGJQ?=
 =?utf-8?B?blMzNDEvNlNSOEdMSUQ4M09kOUZaSVBhREltTVJwNHhpM09rbFF1d0hIQ0hP?=
 =?utf-8?B?UG9YY241TzdIM3dxdFlpUGhCUEJxTlNhQnhEcEFGU3VZVDlDTGo1cFJBRmh6?=
 =?utf-8?B?SU5GMkZDSE5JTkNkajJEdkt4MkJqZ2IyUHRmb1ArLzZldE5kQlcyV0kzNWd5?=
 =?utf-8?B?RXRHVUNoN3dOQXRJejhtRUNZWTM4ajNvVG00TjhHVStUREJITVJIU1JQNC9R?=
 =?utf-8?B?ZVAzeE0rUnpRakE4U2o0dU1CMU1zeUV0cGU1S0k5djloMWYrK1hnUnZqaENz?=
 =?utf-8?B?MHVYK2pvTHFWVkxXODlrNURCYXFmVzQ0cFdzNE5rSnUvaUlaN3ZSSkhlZWpL?=
 =?utf-8?B?TVdRSi9hVDhtbEc2dmNydmpkNFlkbEJTdi9aUUdZNWtFb3Y4Zm82YXZPZng1?=
 =?utf-8?B?TjUyQjFHQjQ5d3lEMTQwa2FnVXViekRJNGhDZXRDd3F1M0VwSEIwcDBZbjgr?=
 =?utf-8?B?NDZ5WkE1MHFoMExBWXVhWHFxQWJWa2tTRTVPLzRPUHFCd0RPTDVXZmRrMldG?=
 =?utf-8?B?czFVcE16UkV4aytyVi9zUnBrU2xLN3dIR0pYMms4Wjh5WHp3dmFoVGtNS1Jw?=
 =?utf-8?B?QUx2UFAyalpwa0FneHZjVGNTSnV5c3Y4MHJ2M2h6WWtsMkJNWkxNNHZhdThD?=
 =?utf-8?B?eXY0SXVaMVV6MmhDOWx0cjJIMzhaRlR2eFZXOU15WXRtN0trN0xBa2FMQXJW?=
 =?utf-8?B?SHh6T3VEaklVUmszeG5wTldoN0E3VkFQZ2E0T2dzVFlKdmhwczZzaTdobUZY?=
 =?utf-8?B?VFZ1RThveTRwZGZ3dnh3YmtzRnlabjJXbzg5aU83Qy9md0Q1aC9FZVdEMU5o?=
 =?utf-8?B?ekZNNk5uMTRMclkzRDRNOGFPWjZRQlFzRWN1S2hubFV2aDVxUFl0V1lxY1A4?=
 =?utf-8?B?bHhrL1gra2VMT25FNHJnbzF0SzdybnJxeFJnUGdxS1JmMmtKMmFTZlMxQUg4?=
 =?utf-8?B?RTRyeDkvdGVtNHJ2enNhRTVXWTJPa1AyUExNSnhTWFdXaHhwc29lRlpCb0Ri?=
 =?utf-8?B?R3c1a0E0MmkyaEVrVW4xVThJbTZqUlEyV2liejNJcnVoMVY2OHJQNTRpOUN6?=
 =?utf-8?B?bHU4djVmRjNHNEw1WmRpcjhtM0NHd2hrbVVKL25XYmhDM3cvVHh0UjhiY1Vu?=
 =?utf-8?B?WFpKVm0wOXhGWEtBVDRLby8zWDNZdXExemxieGpSSVdseFI1ODNkUHo0dHho?=
 =?utf-8?B?SzFIR21PenQ5SlNXYytPQTlLUU41LytpTXBXL25ReUdxbVFIK0NIeDZUN1Nr?=
 =?utf-8?B?bzUralNXVTA4a2laOG5YSEFlb0xNR05sWXVoZ1VId1dPODZadUhreGxkdDNB?=
 =?utf-8?Q?kqgBujCBEHH8T1eWtnJXoaymF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c684446c-f1b6-42f8-a722-08dac0fcf486
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 20:16:29.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6iYxfHtmCoP1MxEwZxuLXqu8/qOe+vWhocvtB+yCJAcSZUa2omsBneNZhzTiNR0EGETMQOfezbMQHz0T/4bGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1432
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: zx2EdnUBZnE6z8ZsyK3-wLUundmNY4VA
X-Proofpoint-GUID: zx2EdnUBZnE6z8ZsyK3-wLUundmNY4VA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=345 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070159
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTXIuIEtvemxvd3NraSwNCg0KPiA+ICsNCj4gPiArICB2ZGV2bnVtOg0KPiA+ICsgICAgZGVz
Y3JpcHRpb246DQo+ID4gKyAgICAgIHZpcnR1YWwgZGV2aWNlIG51bWJlci4NCg0KPiBUaGF0J3Mg
dW51c3VhbCBwcm9wZXJ0eS4uLiBXaHkgbnVtYmVyaW5nIGRldmljZXMgaXMgcGFydCBvZiBEVCAo
aGFyZHdhcmUgZGVzY3JpcHRpb24pPw0KDQpJbiBIUEUgR1hQIHZpcnR1YWwgRUhDSSBjb250cm9s
bGVyIGNoaXBzZXQsIGl0IGNhbiBzdXBwb3J0IHVwIHRvIDggdmlydHVhbCBkZXZpY2VzKGdhZGdl
dHMpLiBFYWNoIGRldmljZS9nYWRnZXQgd2lsbCBiZSByZXByZXNlbnRlZCBieSBhIGJpdCBpbiA4
IGJpdHMgcmVnaXN0ZXIuIEZvciBleGFtcGxlLCB0aGUgaW50ZXJydXB0IHJlZ2lzdGVyIGJpdCAw
IGluZGljYXRlcyB0aGUgaW50ZXJydXB0IGZyb20gZGV2aWNlIDAsIGJpdCAxIGZvciBkZXZpY2Ug
MSAuLi4gc28gb24uICBXaGVuIGEgdXNlciBkZWZpbmVzIGEgZGV2aWNlL2dhZGdldCwgaGUvc2hl
IGNhbiBkZWZpbmUgdGhlIGRldmljZSBudW1iZXIgYXMgYmV0d2VlbiAwIGFuZCA3LiBUaHVzLCB0
aGUgZHJpdmVyIGNhbiBsb29rIHVwIHRvIHRoZSBiaXQgcG9zaXRpb24uIFRoYXQgaXMgd2h5IHdl
IGhhdmUgbnVtYmVyaW5nIGRldmljZXMgYXMgcGFydCBvZiBEVC4NCg0KPiA+ICsNCj4gPiArICBm
ZXBudW06DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgbnVtYmVyIG9mIHRoZSBm
bGV4aWJsZSBlbmQtcG9pbnRzIHRoaXMgZGV2aWNlIGlzIG5lZWRlZC4NCg0KPiBTaW1pbGFyIHF1
ZXN0aW9uLg0KDQpJbiBIUEUgR1hQIHZpcnR1YWwgRUhDSSBDb250cm9sbGVyIGNoaXBzZXQsIHRo
ZXJlIGlzIGEgZmxleGlibGUgRW5kLVBvaW50KEVQKSBwb29sLiBFYWNoIGZsZXhpYmxlIEVQIGhh
cyBpdHMgb3duIG1hcHBpbmcgcmVnaXN0ZXIuIFRoZSBtYXBwaW5nIHJlZ2lzdGVyIGJpdCAwIHRv
IDMgaXMgZm9yIGRldmljZSBudW1iZXIgKHZkZXZudW0pIGFuZCBiaXQgNCB0byA3IGlzIGZvciBF
UCBudW1iZXIgaW5zaWRlIHRoZSBkZXZpY2UuIFRoZSBkZXZpY2UgZHJpdmVyIGNvbmZpZ3VyZXMg
dGhlIG1hcHBpbmcgcmVnaXN0ZXIgdG8gYXNzaWduIGEgZmxleGlibGUgRVAgdG8gYSBzcGVjaWZp
YyBkZXZpY2UuICBIZXJlLCAiZmVwbnVtIiBpcyB0aGUgaW5wdXQgbGV0dGluZyB0aGUgZHJpdmVy
IGtub3cgaG93IG1hbnkgRVBzIGFyZSBuZWVkZWQgZm9yIHRoaXMgZGV2aWNlL2dhZGdldC4NCg0K
VGhhbmtzDQoNClJpY2hhcmQuDQo=
