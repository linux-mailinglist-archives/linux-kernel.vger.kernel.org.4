Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB8610E33
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ1KPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJ1KPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:15:09 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E057136427;
        Fri, 28 Oct 2022 03:15:08 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S7rSKX005104;
        Fri, 28 Oct 2022 06:14:50 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kfagchuae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 06:14:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMuaRWwMmSgskRNork4AC1MCKiS97V6H1DwSwlsy+BLS49YTT3XfKqJFageZtRe2U0uaqzK69icY/UdKpgWq3/ibcbgiCoJvJ+xTlOioeMIN2R9Om3L2rb41tJPBG6dGK9+l+cLSVSh11vye4U7+hdr5lyBVc5wXWpZGtr8ulCzSFHnmscj/hQ2OSbm6jRtKWbsH/1MocNUBtM+gY5zlWgWd5XG6IuAQA5L5PJglyIMOWaVHF/QJ2YRnU/vClhhW6P5c5U+RKreKZdLW03Vuil4rNRVCU76//4njTc3MDK3mjS7HuU1LgEaI2L46yZAKFvshGw5R7qBGvFGo6cXNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akahE/YBXfiWRXjT2s7crHv0utp5ZsiNEcfOKLFOKIE=;
 b=Z3nEg81fZKki6T8zqdsy42PeLAZatBisjDlMmM50ewVvTDB79M1Sd3ipzSNz093RzaxDjP8/H6ErsbEeMIXLV4w5SGsKBuSfzV4K2owSPG2qv7CEww5JVYG1w3Ygeq1yUQ8NEhe/0kMEid3zAWm8g/xlcIpI3nO/hNaS649qmqJp+EMXiybBiiTfcVzpxVzUbXsF0Diot//a8EVfuVNoUMt3LiE/Dmo6ySJt3d+Xh5EKJ2ljRFhgmvnO83kuu0pTQtNScRpR/bPL0TjkHIwde5ktK7GXQxN70kFtZL/E8kN+wlnAR4sJh056RwH+9zY3j2IX2gvd1I6EaN4UNc8HhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akahE/YBXfiWRXjT2s7crHv0utp5ZsiNEcfOKLFOKIE=;
 b=IEsTHk31k9NMpuA81N6GmRYq/NmgO8CddmQeLxDzKsi3fTzy/ba3g3031KqqCl25kvCnqDG37O0GGwQ7mudCfV6R6zo7PdoLDKNkwZKkrDcuCxKlNCSzuzmGkulAnJqexQpl1QCmevYjm1klGBKk6ViNqaqIqpe9hEipEJ9dGAk=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by CH2PR03MB5206.namprd03.prod.outlook.com (2603:10b6:610:a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 10:14:48 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 10:14:48 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Deepak R Varma <drv@mailo.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] staging: iio: frequency: ad9834: Use div64_ul instead
 of do_div
Thread-Topic: [PATCH v2] staging: iio: frequency: ad9834: Use div64_ul instead
 of do_div
Thread-Index: AQHY6k991BoEoSvPaUmXRY3U9NvoWa4jl13g
Date:   Fri, 28 Oct 2022 10:14:48 +0000
Message-ID: <SJ0PR03MB677828AF20AAF0FC1A167C3C99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <Y1r/RAk83Csk2L3E@ubunlion>
In-Reply-To: <Y1r/RAk83Csk2L3E@ubunlion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNTkwMzI3ZWUtNTZhOS0xMWVkLWI2YjgtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDU5MDMyN2YwLTU2YTktMTFlZC1iNmI4LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTA1MyIgdD0iMTMzMTE0MjU2OD?=
 =?iso-8859-1?Q?cxMjg1MzU3IiBoPSJta0Exb0w1WWkySjZOYmQwaFg3VGd5d2k5MXM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJ0WWxvYnR1cllBUzQxMG12dXZ2aGJMalhTYSs2KytGc0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVg1bDJLd0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|CH2PR03MB5206:EE_
x-ms-office365-filtering-correlation-id: 75bb91aa-f609-496e-bbdb-08dab8cd3ea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bVRLUWGbk71Lh+2mNSZXf4oxP/p2UOut8RjwXhZIoWkMVg96MhUhc8/3PQJb4XAe38+/X/Nq6gmhrKFWAl/4tlB6Xeo8kwXNMLKszfRYrnBAu1D45PE5I+TqulOFPBLjje4D7wb4EO2G2fN5cRVfaKc/2m3szZisFi7ZbER5bn4uR6IA+bsbmZ86XO7ssVjkst1wJj9xcQx1r1EMtIVRiNBMF2QIxR33VoAqciSmzLSkZBHNlBtH8k0sMbRNei1O3+MNCcsIEwOIPbgdCb+yUQcLd0guco1wj8x4NxjmEje/RcttDA1FX5FZNSCmPOBvHOu8vnctykMjcS+A0guO/+ULkIj9y6BUgD9aFvARBdJONc20/p2gYh5qteQHjGAozo49VClfffU9VLVRHhLlQaMMwglUNjvjMaTTzcxpIoWowyL5cEfjO2lOXZnRp7e5a7JGnHT+oItCYOVwNu/u1QV0EoehU1WDNL/CK8vNjvtgUznCYvEa1gF9O6eFD9BzSqPncv2ppBnQAErRmCkaV6+Jr49d/asVH8C9DIhcgEQZCQ9qaQbkVYQWZ9vjET+0MLAET+LX+ufSOXH75mBd2jmHIf39DDVrpYTaJCMK0Ec/N+xuY8GhfJMleepVrtvy08PE0n+GB+wDLKkmOkmQK98fx/5Beq8fFhz8jDPQzakNt+rYOpnRDkYCP0uSeyk9q/S5zUGQAu562O3SmqN22/2H0mLDsACXRdDJ9wLx1zqs7OoDeK+FgU/7bmaF04UYif0CFWoriZO1HYw5YLHHsHQ8v7E1/M0vsFlxz6Op1fQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(2906002)(53546011)(186003)(9686003)(83380400001)(26005)(6506007)(7696005)(66556008)(41300700001)(66946007)(76116006)(478600001)(122000001)(52536014)(4744005)(38100700002)(71200400001)(5660300002)(86362001)(110136005)(38070700005)(316002)(33656002)(921005)(8676002)(66476007)(66446008)(64756008)(55016003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PemhsgM5P5AD42966ei1q68oYRqDsJuHr0KRlFqBMXIetDE/CKLoa5vDWI?=
 =?iso-8859-1?Q?HDuZ1t3ULuX34zYPCe7qGRBXNRt1wOZPszqMHqNVY8GfpX3Tato97VZJJu?=
 =?iso-8859-1?Q?srN0c7AHWk5pTr22T31j0VabDOZJf/pyxYeEnmfyjG4vlMzVGIJp/obABi?=
 =?iso-8859-1?Q?W6ZxbYib5K0xZX4tWTldjDiUTSsYXbSLPxns3/3veNsGAn94EANm5t1rIh?=
 =?iso-8859-1?Q?uh+O3hF4EFOlSzliOQlXipjddEG1bnWx0ILumMsrks0dGi6mHNr0sewlo7?=
 =?iso-8859-1?Q?wTJ5jcB9C/FBhEVG152LbvJQM/V3iJCKSkXZ2V2nI6f1e+W42iMHc1lbQW?=
 =?iso-8859-1?Q?hofuqnvHFmS80LKKdXojlr6p2yHIWt2cNHjcYZdXTxxQtFISwyZ3j4pjlq?=
 =?iso-8859-1?Q?s6yXEzUejxGVdpPulIEPCmBS2eGPj02SCxQd83RHok0ffeQGa3HhPWGB/k?=
 =?iso-8859-1?Q?fp45pLs9krkTeetidKiwh6hbzyV3M54+mOQqvQSTJriOzoYKN4gMFs/D8a?=
 =?iso-8859-1?Q?UXevUCuqyUfYuxYP3Mh7xnBUMjD1COOCerk1s7C6r9A1E2l27RDfiuRmix?=
 =?iso-8859-1?Q?PBqiZuSny9+kkiUfwziW/fMWwEcImRxoIR3ZPorfdT8eA4CERSAoAKuyBR?=
 =?iso-8859-1?Q?/et45u4LNjSBGZ0UP361LcQJ4g7yGfnxQwrLjqQ/01habDs8zb225tQNS2?=
 =?iso-8859-1?Q?2aSsHt6HaeD2c2505pr5QblEWGYR0XUsqSSZSAFFtYuV6Y7PGzxFXC1ywG?=
 =?iso-8859-1?Q?BJpiytzT7kXPvc/Cdgcau4KopKpOk/mXhOYCfxx3MX/4r9gbDaMm/RA7mq?=
 =?iso-8859-1?Q?5msP81fV3+igBSgHWxvl0w3uCZF8XLDnxUQXMdBtVsgPVPiG1JcNzb0h3o?=
 =?iso-8859-1?Q?JteKW9ARE8R2rsgsvhel5Ke4SVVFBvoObEYMCgxeSY4lB5Sna5WRnDUaNk?=
 =?iso-8859-1?Q?REbwwyW1UfvsE6icmrnhhsP3DqZNNztCe9Lp4rQrQ+Dbk9ogj7WbUioaHL?=
 =?iso-8859-1?Q?JhEcVxmw2jXip/wP/s6b0VI7WNDY1XPWXBYITWgknzWDrXGUoGqkE4EbhA?=
 =?iso-8859-1?Q?Efm4QJ88yJGX218mRYzO1FS3qlCpjCPhBzyMQoYzV0G5BUz8MISau1zRrI?=
 =?iso-8859-1?Q?PjsDAGyKvo81QKxi95mWihX5V9vZLW/Mj3cdWTaKTOtZ7YXFYNKojB1LYD?=
 =?iso-8859-1?Q?1Np7Kqe4k4dSQjmCfF7EWpqVYKabB2k76iWSMn5gQqve0Oy0MqlSVy7Z42?=
 =?iso-8859-1?Q?95xiFnncHdseRHP2rhl8/x1n4fvk6JROHssPiJO7cfj7CmjKlv7OTP84CI?=
 =?iso-8859-1?Q?UGnVTqxcO6YhncqlOeVEc01txrwIiwjOs7KSARJ//E+g4NR1+Q04xBXBVg?=
 =?iso-8859-1?Q?w9HYWGrxdpcC86eyuI8UBvFPZdqZiKUvRCzQUG3rTvVODgwzTwZKDKPKB4?=
 =?iso-8859-1?Q?rwcaukcGIFNRA8GAiMIgk2UP0eiJwXaM7NypNLPXZUSyoIyTf9JQ5LcEAS?=
 =?iso-8859-1?Q?PmsQ+jaakx535Yv4PXHl9Q8cS1s4g2gCH/3Ftv/LVkqYOvPYk72dLUU8V3?=
 =?iso-8859-1?Q?S5SRpHPZVMjAe+j5obWDCsu1ixVbx0zFAN8wK2L8d0Q8rLe+B4viJlSfWa?=
 =?iso-8859-1?Q?OwEvllVqCtkdu5xVEfEoKmIEBkqSh5OKYg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bb91aa-f609-496e-bbdb-08dab8cd3ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 10:14:48.4823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5AvOwIJm8/5k8X3MSFiDTKYWJozgGMylMS5nGtTQyYKdbTreuO05Vf8x7lFIhHQK3kuqmqaW5kOin9hh8Go+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5206
X-Proofpoint-GUID: tcu12Qa5PcH03MuQ2sNIHGre8oiH0-H4
X-Proofpoint-ORIG-GUID: tcu12Qa5PcH03MuQ2sNIHGre8oiH0-H4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_04,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210280064
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Deepak R Varma <drv@mailo.com>
> Sent: Friday, October 28, 2022 12:00 AM
> To: outreachy@lists.linux.dev; Lars-Peter Clausen <lars@metafoo.de>;
> Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> linux-iio@vger.kernel.org; linux-staging@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2] staging: iio: frequency: ad9834: Use div64_ul instead=
 of
> do_div
>=20
> [External]
>=20
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation. Issue identified using the
> coccicheck tool.
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Clearly, I should have looked better and only reply to this one:

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
