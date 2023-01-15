Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8FF66B11E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 14:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjAONDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 08:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjAONDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 08:03:52 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E39510AB5;
        Sun, 15 Jan 2023 05:03:50 -0800 (PST)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30FB9Fg0000444;
        Sun, 15 Jan 2023 08:03:30 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3n3swbujtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 08:03:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyI9wFZZjNqnYpx/ReMtnkxSC0wGCJHNXU3sqmNHAGANzLZuzbALl89pm92OGWOywVQr/SpKZujxL/mdVYseRlAeT3TBilQjcjCmN/DSDyl0s7G7MM12PeeuzfMk3KFP6RCpr6O/ype+Oud2tC6fquz+LS67/qIDUuYNCzunP4jO9Gx6X3jrdehwWZX4ghlYQNGMxI4g2gFCLKKpMUj5Q6j9Xib07VjdxZSrbieovrKmk0SB+TDozvNC3EFNNO7EIDph1AWKST7/KTMKJzN7dpw5UGwk3kE5VOVEvuiyF69AZ66sEbt42JC7EqG/b6XI/FNwadUOrwzWBYmhjXexBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbJOwuZZAn0Ewtt0joj/ANT5R6u0rdFdHtNJC6kOU/c=;
 b=GUhKKBSi8WcgmPl5RR0BfonIhXM5yr+9t5HsiTvbXeVzpr5XB4pSGj02THIGVc4RX43jv3FH7JK/s4sZWnKX/+FBYRvEmmuZxyqlHSzLhl1D0kx0lZBPzv0liNzYlY9RXh5qAAIImsC7CrysL69R9d8kDohHcUSEUW7NGCZXsAq8B5vf2f0sa5PYW1zx3s4SlMOxJJMeyPlNpNcFli2DxRsy3CfWLb8C/dFchMIGHZP+3ah/JSQYzZGAZk1mdPzKf4d6fPphS6yFWMFi6a3EnEf8wGLorjekgAIhgUAoxA53/XgL+0P4PH2CEWtLTwHoG8JtEjXvrrXwluVLWBD/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbJOwuZZAn0Ewtt0joj/ANT5R6u0rdFdHtNJC6kOU/c=;
 b=YTOG9sLNWlQNN0oKj3QxidNC+2Y1gNQ7hhp0hbAfgnGbhXcYnIDJWVa13vAM0e2AO/XFMCohA/ACotvvRnC1hCvg/rLsOuhrP4B7pXlXrwK6d4SZPBcySLLL6DL5ABP6XkX9lI7Wxzu1FZ5Y5PG3C9tGrO0tJslEYJpF54pJ3Wk=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by BY5PR03MB5170.namprd03.prod.outlook.com (2603:10b6:a03:22e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Sun, 15 Jan
 2023 13:03:27 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9%3]) with mapi id 15.20.6002.013; Sun, 15 Jan 2023
 13:03:27 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] drivers: iio: adc: Add MAX77541 ADC Support
Thread-Topic: [PATCH v2 5/5] drivers: iio: adc: Add MAX77541 ADC Support
Thread-Index: AQHZGXrvmA9lBPOCO0+sYdxvzM9hIq6Gu2eAgBjKkxA=
Date:   Sun, 15 Jan 2023 13:03:27 +0000
Message-ID: <MN2PR03MB5168D7CDDEAA0DC19929CA02E7C09@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20221226223839.103460-1-okan.sahin@analog.com>
        <20221226223839.103460-6-okan.sahin@analog.com>
 <20221230175019.7075f987@jic23-huawei>
In-Reply-To: <20221230175019.7075f987@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLWZkMGExMTAxLTk0ZDQtMTFlZC1iZTkyLTkw?=
 =?us-ascii?Q?MmUxNjI0NzhjNlxhbWUtdGVzdFxmZDBhMTEwMy05NGQ0LTExZWQtYmU5Mi05?=
 =?us-ascii?Q?MDJlMTYyNDc4YzZib2R5LnR4dCIgc3o9IjEwMzYzIiB0PSIxMzMxODI2MTQw?=
 =?us-ascii?Q?MjgwOTEzNTIiIGg9IncxQVdYdnZkSkorUkNpZnlwbjU0QlEyOFMydz0iIGlk?=
 =?us-ascii?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVv?=
 =?us-ascii?Q?Q0FBRFkvMmEvNFNqWkFmaC9HWUlqMGdXTCtIOFpnaVBTQllzREFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFRQUJBQUFBUnMxZ0ZRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFH?=
 =?us-ascii?Q?UUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFC?=
 =?us-ascii?Q?ekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdN?=
 =?us-ascii?Q?QWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5?=
 =?us-ascii?Q?QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFB?=
 =?us-ascii?Q?Y2dCdkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48?=
 =?us-ascii?Q?L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|BY5PR03MB5170:EE_
x-ms-office365-filtering-correlation-id: 44a552d8-eb47-4cac-7315-08daf6f8e47a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hxT/SRV7DTHSMx9/Cm3W4GctfNsh5EBaJwlZEO+eeHmN449EqwsRabdeIBblZU+JK80KJ382wdEFbSgMfa9ZhEA28ywfkaOk367EjH6Z7X+7YxU7U3R2gczzxuss/33ao7kezV7meGOBmrFUEBp8E3hzH58YzZLHxQ6P75mhcFlTT32LQ8AjH2A9RLetLATfFlovqPP+ijn2EbUk/W4z6IKg11P524l9Ggwg3+h894Fr1qEuCiPD0svVHYi0yiMZJ1CwfZI6acQit462W3KC4mUHJiyUHhzTD7OdFF41CAD5aVtUQ3zA3ithDbtsf4BbrBz/rUO+63gz2XxMCrMYHzK+Dr4dRQthtiZxfw6ops68RMhFWDGg++jqP1Ueves/Mh236Pc18r3BA3KjKxuC7Py6KEuATWPJVs8y0WSIcZBEVlKLRudfxEssH31eWYqh21mfH0Rw5Wf7htz/RyZeiImdiBLzLRLj6/zuu661Z0ca7/+9ZddxHivXimAuUWTQRI3wn9edz0qMkB5D1ADvqXBzMWHg8iSiyp4HV2lkEH1YsUoBGeXjCdzjmVnaOPhUw61yIetJuuypYrLVWhQM+GeL0waEfJDZChL6EFEbZSRRA2SpuU99pyjiGE5A7m79nbWajG0uW4qDip/gbIqSvXMEgFS/DDp54aFwArVnhnxPH9kL5touh6OxxTwFHz3VLA081Iuo7zLWOSY9QpZYuNy4jFpslXlp20CMVi3eODg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(376002)(136003)(346002)(366004)(396003)(451199015)(9686003)(6506007)(26005)(186003)(38100700002)(478600001)(966005)(7696005)(122000001)(86362001)(38070700005)(55016003)(83380400001)(33656002)(71200400001)(52536014)(8936002)(5660300002)(66476007)(66556008)(66946007)(19627235002)(76116006)(66446008)(2906002)(54906003)(6916009)(4326008)(8676002)(64756008)(41300700001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cHLPylds/TKlrxbDHGaa3xyBces1Or1ESbHF1Nmk/Dbj14NbkXEeFS9kddJl?=
 =?us-ascii?Q?m1DW4vXK95KSj8dSRO2XpHDwW4YCUlYdz06HdHrlsI1m1tQvNRhX7lLfEi96?=
 =?us-ascii?Q?FImpUBqXxyy6j9wOsEDunYbTToCMRFpMF5qt/yBBkf+23xWpKX2yi/pBOAdu?=
 =?us-ascii?Q?YnQaJaFppz8rwX1RHt+axhleXxn0vtdWpJZBe68VpGIREaLQNka5F3SLw7Id?=
 =?us-ascii?Q?AFheCMAvsxhpv/iOT0VOWEBSU58RBrM1Q4EagcuBeeTZITTLfEFl/NHGzLiV?=
 =?us-ascii?Q?Wmtj6s3Ezxu4Q/shGIADgX/jcw0t5NnC0vhzYHlv8vEzB7KNGHn1WodsHpWN?=
 =?us-ascii?Q?cT472OlyQ5ntJJmobFxdSEzcTPLX8I0V1kk8n8lE1V31qPXpzUQp4h5FaVEg?=
 =?us-ascii?Q?H3MrYlwj8V7oKSFa3A0qCeyNtbyfWV0zPLJqj717cuRBY3+pCiAbbVsQe5eU?=
 =?us-ascii?Q?nZ0Kra7ln424zy6hVAQQpgZp4zRQuRqyJ40TIKsGE0nd7Yt4U7DZl6vwR9Ea?=
 =?us-ascii?Q?4C2NW/X4o8e78EcoAmDFIQpORcCuXcHxsyQvL6QKqMakS/xzBWKFrlMG9xdq?=
 =?us-ascii?Q?D1lyH9DVQVO77DJKvSSgG7YLCjyhZccg54pbZLlXWGOxbEb3iSTNtwltVtBr?=
 =?us-ascii?Q?cHrBYqrgpUDpTLrYcngNSQ0cVuhz1cyp4ciKFDHut2R+GmqSzATXw9WeH2WF?=
 =?us-ascii?Q?tsb5UNLUlyUtEGEx5JicGWJ9VWQPK5+fpAYolt+2LDl0cWUpwTOqkPxHi4Ac?=
 =?us-ascii?Q?WpAwTIPe/8aC8lznXgVj6M0TV6t3Oqs0Dzo52X9wyS9bPRR9r/Y7UW56fgOa?=
 =?us-ascii?Q?u1YAB75jcKdffJpq76J4Qsl8uCB6TqwwJjbydL4cvJWnqfo3/mBFy1IJoKVA?=
 =?us-ascii?Q?uyEgfn15T6LjaQDeP9t14oQlhLhsbLS8LMQBwqCGNozl7G8V6xhpPm6iqYde?=
 =?us-ascii?Q?mlPWT0hsgk9LoMhvgSY6XupobDVCOnyV4Icw06j8kOwPeV8CgVmD9hmXckAi?=
 =?us-ascii?Q?vdsSShzxPrCOrAlX7vLTdFnkOwQrWzM0hVEFW1pQ9btLpTXBr/KELASGsSRh?=
 =?us-ascii?Q?5YZUB8zjCMtpwWsd6TMEpj4vTD8/NC5ddENt40rzw2pbndcGebRcifL8pYZp?=
 =?us-ascii?Q?1Wuq3IKAYY9dUQDrEYe1l/YOoUduk6bq4uLEghGrHBVFv+yqpMavr9rgGyPF?=
 =?us-ascii?Q?GertTczF71NTFCo4arTPl5zTx2JTqqLSN4cP+D/U+U9Ic6C1Dwhbvi+5YH3e?=
 =?us-ascii?Q?OJlJMVktmGkVdkLXFf/nL7cM0D/MScxEUBYa2HipvQUaGTn7SwMDJ43bHIWs?=
 =?us-ascii?Q?XjliGJ/cZ5ITakzc0LU9z7OMEoYoEwO05JlWUxovmurckQaWjC+JjkY+SLoN?=
 =?us-ascii?Q?B0yVFHpv6+67tdwkHMuH1bpgcjCXJieANBHEbbMtOxAXp1jzdTDRmV6nZk1T?=
 =?us-ascii?Q?ZoElTzfYp/0x5kkB/GpvGqLAKYVf2TPv0g0X0zAD15hYqV1i5RJTMxbPuxFd?=
 =?us-ascii?Q?X37ygjGsDbObEVMn+xJUGjrfPV39BOdaDl4wtzs5ZTxlOsjzRO0d4IIcvfMU?=
 =?us-ascii?Q?16yy9oDczdrxPbiUIMz+OuDH0xUo87AbZ2euvI8u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a552d8-eb47-4cac-7315-08daf6f8e47a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2023 13:03:27.1429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8xc2N04DMQOPV6rL9dMQzHAGDf6kInhfjGjZhRKSNy3/aQsLGd0EJEEV4AdC9y8Kkh9REuyloJxkEOVWIZjMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5170
X-Proofpoint-GUID: eJuhywg_S5pQQ5zQ8WBpFbBIxzqV6OXe
X-Proofpoint-ORIG-GUID: eJuhywg_S5pQQ5zQ8WBpFbBIxzqV6OXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_09,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301150100
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thank you for your feedback and efforts. I apologize for some missing point=
s of v2 patch. I will be more careful to fix all feedback before sending ne=
w patch so I want to ask something before sending v3 patch.=20

On Fri, 30 Dec 2022 8:50 PM
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 27 Dec 2022 01:38:39 +0300
> Okan Sahin <okan.sahin@analog.com> wrote:
>=20
> > The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> > with four multiplexers for supporting the telemetry feature
> >
> > Signed-off-by: Okan Sahin <okan.sahin@analog.com>
>=20
> If there is a v3 please send the whole series to everyone who is cc'd on =
any of
> the patches in this version.  For a driver like this, it's much better to=
 let people
> pick and choose which bits they are interested in than to only send part =
of it to
> each list / reviewer.
>=20
> I took a closer look at the offsets / scales this time.  They don't appea=
r to
> comply with the ABI.  Whilst 'most' IIO units are SI units, a few have un=
its
> borrowed from hwmon including temperature and voltage - this brings some
> multiplication factors that need to be taken into account.
>=20
> Jonathan
>=20
> > ---
> >  MAINTAINERS                    |   1 +
> >  drivers/iio/adc/Kconfig        |  11 ++
> >  drivers/iio/adc/Makefile       |   1 +
> >  drivers/iio/adc/max77541-adc.c | 199
> > +++++++++++++++++++++++++++++++++
> >  4 files changed, 212 insertions(+)
> >  create mode 100644 drivers/iio/adc/max77541-adc.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > 8e5572b28a8c..18ce4644cc75 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12503,6 +12503,7 @@ L:	linux-kernel@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> >  F:	Documentation/devicetree/bindings/regulator/adi,max77541.yaml
> > +F:	drivers/iio/adc/max77541-adc.c
> >  F:	drivers/mfd/max77541.c
> >  F:	drivers/regulator/max77541-regulator.c
> >  F:	include/linux/mfd/max77541.h
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig index
> > 791612ca6012..9716225b50da 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -696,6 +696,17 @@ config MAX1363
> >  	  To compile this driver as a module, choose M here: the module will =
be
> >  	  called max1363.
> >
> > +config MAX77541_ADC
> > +	tristate "Analog Devices MAX77541 ADC driver"
> > +	depends on MFD_MAX77541
> > +	help
> > +	  This driver controls a Analog Devices MAX77541 ADC
> > +	  via I2C bus. This device has one adc. Say yes here to build
> > +	  support for Analog Devices MAX77541 ADC interface.
> > +
> > +	  To compile this driver as a module, choose M here:
> > +	  the module will be called max77541-adc.
> > +
> >  config MAX9611
> >  	tristate "Maxim max9611/max9612 ADC driver"
> >  	depends on I2C
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile index
> > 46caba7a010c..03774cccbb4b 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -64,6 +64,7 @@ obj-$(CONFIG_MAX1118) +=3D max1118.o
> >  obj-$(CONFIG_MAX11205) +=3D max11205.o
> >  obj-$(CONFIG_MAX1241) +=3D max1241.o
> >  obj-$(CONFIG_MAX1363) +=3D max1363.o
> > +obj-$(CONFIG_MAX77541_ADC) +=3D max77541-adc.o
> >  obj-$(CONFIG_MAX9611) +=3D max9611.o
> >  obj-$(CONFIG_MCP320X) +=3D mcp320x.o
> >  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
> > diff --git a/drivers/iio/adc/max77541-adc.c
> > b/drivers/iio/adc/max77541-adc.c new file mode 100644 index
> > 000000000000..29adcdbd96ae
> > --- /dev/null
> > +++ b/drivers/iio/adc/max77541-adc.c
> > @@ -0,0 +1,199 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2022 Analog Devices, Inc.
> > + * ADI MAX77541 ADC Driver with IIO interface  */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/mfd/max77541.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/of_regulator.h> #include <linux/units.h>
> > +
> > +#define MAX77541_ADC_CHANNEL(_channel, _name, _type, _reg) \
> > +	{							\
> > +		.type =3D _type,					\
> > +		.indexed =3D 1,					\
> > +		.channel =3D _channel,				\
> > +		.address =3D _reg,				\
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
> > +				      BIT(IIO_CHAN_INFO_SCALE) |\
> > +				      BIT(IIO_CHAN_INFO_OFFSET),\
> > +		.datasheet_name =3D _name,			\
> > +	}
>=20
> Move this macro down to just above where it is used.  Given the purpose o=
f this
> is to reduce boilerplate repetition we want to review what it does based =
on the
> values provided.  That's much easier if we don't have to go look for the =
macro.
>=20
> > +
> > +enum max77541_adc_range {
> > +	LOW_RANGE,
> > +	MID_RANGE,
> > +	HIGH_RANGE,
> > +};
> > +
> > +struct max77541_adc_iio {
> > +	struct regmap	*regmap;
> > +};
> > +
> > +enum max77541_adc_channel {
> > +	MAX77541_ADC_VSYS_V =3D 0,
> > +	MAX77541_ADC_VOUT1_V,
> > +	MAX77541_ADC_VOUT2_V,
> > +	MAX77541_ADC_TEMP,
> > +};
> > +
> > +static int max77541_adc_offset(struct iio_dev *indio_dev,
> > +			       struct iio_chan_spec const *chan,
> > +			       int *val, int *val2)
> > +{
> > +	switch (chan->channel) {
> > +	case MAX77541_ADC_VSYS_V:
> > +	case MAX77541_ADC_VOUT1_V:
> > +	case MAX77541_ADC_VOUT2_V:
> > +		*val =3D 0;
> > +		*val2 =3D 0;
> > +		return IIO_VAL_INT_PLUS_MICRO;
>=20
> I thought I mentioned this before.  For cases where the offset is 0 don't=
 set the
> bit in info_mask_seperate and don't provide an implementation to read it.
>=20
> > +	case MAX77541_ADC_TEMP:
> > +		*val =3D DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS,
> > +					 MILLIDEGREE_PER_DEGREE);
> > +		*val2 =3D 0;
>=20
> If *val2 =3D=3D 0
> then the return type should be IIO_VAL_INT allowing any code using this t=
o
> handle it as an integer, not a fixed point number.
>=20
> I'd also like a comment here to explain the maths being done.
> Base units of temperature are mili degrees Celsius and the offset looks w=
rong
> anyway as it doesn't take into account that in datasheet it is applied af=
ter scale,
> whereas in IIO ABI it needs to be applied first (thus requiring it to be =
divided by
> scale) https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.2-
> rc1/source/Documentation/ABI/testing/sysfs-bus-
> iio*L244__;Iw!!A3Ni8CS0y2Y!7FLhRoK07ZzeEcEw_H5bPRrK-Dpnrs-mBOV-
> mWXiEWRQQZDa3F89L6WaGw0St2sFxPgtGhIznNbdig$
>=20
> So what you currently have is
> 1LSB =3D 1.725*(raw + -273/1000)
> I think it should be - based on equation (-273 + 1.725 * ADC_DATA6) deg C=
 1LSB
> =3D 1725*(raw - 273/1725) so offset should be -273/1725 and scale should =
be
> 1725.
>=20
> Also check scaling is right for voltage channels - noting that voltage ch=
annels are
> expressed in milivolts I suspect the sale should therefore be 25 but I ha=
ven't
> checked it closely.
>=20
>=20
>=20
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
>=20
>=20
>=20
> As noted above, put the macro definition here so it is easy to see what t=
his does.
>=20
> > +static const struct iio_chan_spec max77541_adc_channels[] =3D {
> > +	MAX77541_ADC_CHANNEL(MAX77541_ADC_VSYS_V, "vsys_v",
> IIO_VOLTAGE,
> > +			     MAX77541_REG_ADC_DATA_CH1),
> > +	MAX77541_ADC_CHANNEL(MAX77541_ADC_VOUT1_V, "vout1_v",
> IIO_VOLTAGE,
> > +			     MAX77541_REG_ADC_DATA_CH2),
> > +	MAX77541_ADC_CHANNEL(MAX77541_ADC_VOUT2_V, "vout2_v",
> IIO_VOLTAGE,
> > +			     MAX77541_REG_ADC_DATA_CH3),
> > +	MAX77541_ADC_CHANNEL(MAX77541_ADC_TEMP, "temp", IIO_TEMP,
> > +			     MAX77541_REG_ADC_DATA_CH6),
> > +};
> > +
>=20
> > +
> > +static int max77541_adc_probe(struct platform_device *pdev) {
> > +	struct max77541_dev *max77541 =3D dev_get_drvdata(pdev-
> >dev.parent);
>=20
> I can't easily see other parts of the mfd (as not cc'd on rest of series)=
, but from
> what is here it might be nice to set the drvdata to the regmap rather tha=
n the
> mfd driver specific structure.
>=20
This is my mistake, I will send whole patches to people who related them at=
 once. As you said I just need regmap from parent mfd device. I think below=
 is what you expect, right? I will also remove dev_get_drv_data.
struct device *dev =3D &pdev->dev;
struct regmap *map =3D dev_get_regmap(dev->parent, NULL);

> > +	struct device *dev =3D &pdev->dev;
> > +	struct max77541_adc_iio *info;
> > +	struct iio_dev *indio_dev;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*info));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	info =3D iio_priv(indio_dev);
> > +
> > +	info->regmap =3D max77541->regmap;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	indio_dev->name =3D platform_get_device_id(pdev)->name;
>=20
> I would prefer to see that hard coded.  Also, from an IIO point of view t=
his
> should just be the part number which is "max77541"
> without the -adc postfix.
>=20
> The advantage of hard coding it is I don't need to think about what indio=
_dev-
> >name =3D "max77541"; sets it to thus reducing the complexity of reviewin=
g a
> little.
> Note that similar cases have gone wrong in the past and we've ended up st=
uck
> with hideous ABI for a few device names so I'm paranoid about this now.
>=20
>=20
> > +	indio_dev->info =3D &max77541_adc_info;
> > +	indio_dev->channels =3D max77541_adc_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(max77541_adc_channels);
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static const struct platform_device_id max77541_adc_platform_id[] =3D =
{
> > +	{ "max77541-adc", },
> > +	{  /* sentinel */  }
> > +};
> > +MODULE_DEVICE_TABLE(platform, max77541_adc_platform_id);
> > +
> > +static struct platform_driver max77541_adc_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "max77541-adc",
> > +	},
> > +	.probe =3D max77541_adc_probe,
> > +	.id_table =3D max77541_adc_platform_id,
> > +};
> > +module_platform_driver(max77541_adc_driver);
> > +
> > +MODULE_AUTHOR("Okan Sahin <Okan.Sahin@analog.com>");
> > +MODULE_DESCRIPTION("MAX77541 ADC driver");
> > +MODULE_LICENSE("GPL");

