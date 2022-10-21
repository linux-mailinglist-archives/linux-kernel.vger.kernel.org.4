Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C345060766D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJULow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJULos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:44:48 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CBD36DD4;
        Fri, 21 Oct 2022 04:44:45 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L8TfCc028989;
        Fri, 21 Oct 2022 07:44:15 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kb9vme46v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 07:44:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6drZNNv8CuIr57KMb3jpF8bMF2RIaLxx9AClqGuXdReNPXngNW6dXI+33x6U62/H+gDxvZXms3Rk85nzybdXBxJuHv8CUy+Kkh7dXExKhdeP0+zpT1b4noPWyxLKxad6YJqvOfFmwiVwGrGWNgbObwcS03SQx1X5oOM+kZ/BXy1evBBbD5/mckcJu1vYj1Hkcu8TN2dt+qdSXWtiUTOe1ES/EqxN6qtG7H5UNS7Uksdh8xe3SyZ1Mpbdc8YMR9NZ01CKI1YUWfWpbHS6E8xWjH2QxqMVtmR1W4D2yBq7ei/ZfDLYIptgnu2XQ1V16mxKdYu/tSKAou38n3rCWvQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw6xxlcQRlmZKZkq0756KOppNlxalhCH0x2t2sx/yMw=;
 b=jgo6aqyEyhrNennDS6eE6CQpqz2TK5LQY36y0zt6M0PiIkJRX65vOLcieRYRrMayuDRDFnYk8QPzHuWj+tMFs8J8RL61ReLxvsFqwA0V4eYunbB3rClSdt/pGw810CKGZDuUPWLdmnZD6+V27P8Vntkk2/D8ANNvBSaku4DnL5hTWHLpWJPg8oScTtgvhoVtUCO1VynuaMWNzfGXAdMMXqFr0U1J7h2COiiymLS0kzB1QpUFpkyBn72i8pqGAEhilIUkce3cJ3Ik1MG2K7HkVUCJp12V8XlvUYQAiE7D5ZiLrjzfEKf8LdjdXD7uJSj4lLAlVIWYf135JBjfJA68Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw6xxlcQRlmZKZkq0756KOppNlxalhCH0x2t2sx/yMw=;
 b=7gL7klLpVzawHJhKP7i9AHxhdcrQLAj9alg550dwdMFR+G9OUZWlwr2xMaQJ31xqpW36Fig2TBt49cYdUg0nmdoKaSfAXvTnSEsGsy8lwrbSXOMHD58XN/BfYfictNY+Gmos9lAmcLC6K/jlYqt4Kn7VmDbANmPv3miWQCPOF/8=
Received: from DM8PR03MB6247.namprd03.prod.outlook.com (2603:10b6:8:3b::6) by
 PH0PR03MB6397.namprd03.prod.outlook.com (2603:10b6:510:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Fri, 21 Oct 2022 11:44:12 +0000
Received: from DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::17cf:8070:5f0f:8b37]) by DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::17cf:8070:5f0f:8b37%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 11:44:12 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Thread-Topic: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Thread-Index: AQHY48BZbMpT/SjNa0SzYqltq8qQ864XyjkAgADySLA=
Date:   Fri, 21 Oct 2022 11:44:12 +0000
Message-ID: <DM8PR03MB62477670C186E6CC5308B600962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
 <20221019133910.282-2-Ibrahim.Tilki@analog.com> <Y1G6FIvS6WD57GXW@mail.local>
In-Reply-To: <Y1G6FIvS6WD57GXW@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaWJyYWhpbS50?=
 =?us-ascii?Q?aWxraVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLWFiNmI4Y2ZiLTUxMzUtMTFlZC04ZTYz?=
 =?us-ascii?Q?LTdjYjI3ZDcyMzFhYlxhbWUtdGVzdFxhYjZiOGNmZC01MTM1LTExZWQtOGU2?=
 =?us-ascii?Q?My03Y2IyN2Q3MjMxYWJib2R5LnR4dCIgc3o9IjYwMzIiIHQ9IjEzMzEwODI2?=
 =?us-ascii?Q?MjQ3OTc3MTUxMyIgaD0iUGVHd2RTTXJJK0dtTGdDeDhra2ZYYlZBRFhjPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?RW9DQUFCNXQ4WnRRdVhZQVhVOCtKblVYMGh3ZFR6NG1kUmZTSEFEQUFBQUFB?=
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
x-ms-traffictypediagnostic: DM8PR03MB6247:EE_|PH0PR03MB6397:EE_
x-ms-office365-filtering-correlation-id: 2cfe8639-9fbf-4e43-f196-08dab35992e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w9Bfm8jOVXyKiT5MGG8yHORejOYf1xUhb53meardoKrLPui7T0/VDyi5Kz6o87P76is3RayCEze9z8BBiy4NX8s83vaypA1T8itU/bkq06zW4mmIzNvBQHbDG3wWMBTdkEPUqI6k0ZvyhRd4sFXmdzsFP9KhnFurXAZkX0Yal3FRIWArU65l7ZHzvf55JnYrI2dCfgRsiPWCiOESuOPP6Nyr5MKjzIq1pIAAkv03wS3EtY8XGNXWX8eXuEnqtw1ko9QWH1d9q9RNviJKWT0gC8C7LJzQfpR7MOo7wH//zJ6Zl96nGyxuMoZqb8AXnIpZ4SjR1lA/RfQcQeJTCmQX+oBTByD0Q7d+IX8VL8/OinJVfjgCNzSKAERrGVXd5ynz9SEZlVLlNwUeQcuG/Q+xoW9kzoh1xFV+G95KVPjSZP0HWvgoRudo2UocCXeazFM5sSQrQ1P1CiMlgxo+e0Tuh7NxxyBor9buvQomXZdWzaCpG/4qIomRzkTvjzBJcWnels4WbnDAqddpPqbQlQOvWr3E8Ythf8zZCdXQ5ntmhC7U6QzUS2lFA3QldRDgheQcKi8DnN5wpXxIvhZ/bUkkGn7JZ0hYJLbzo/gM1pteixjzkUFqnAWlD58v3sKb+IrD9ENGh9Zkz+zHlUSjLYGdqCyU6jfdQgXsLOjuaB+GLu0hxOggrhKjEzopROkn6tBgYP6oG9ZVCt4bEa3j9+3SMkJPqXXjqqUWrV1km76bm43lygi8SxpN09lOvOB9NlWExJweYJ1oF9lpdAaxhmdW0IUaEexPKv4hZ89Wv/Qr/Dw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6247.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(7696005)(6506007)(9686003)(186003)(26005)(107886003)(7416002)(83380400001)(5660300002)(55016003)(316002)(8936002)(478600001)(66446008)(54906003)(6916009)(966005)(64756008)(52536014)(71200400001)(8676002)(76116006)(66476007)(41300700001)(66556008)(66946007)(4326008)(2906002)(33656002)(86362001)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qapG0e2cMqhHcm48U83az3cQjFcRnAMvhIXQk/QcBA9DS9ceH38Oqpa+8/nL?=
 =?us-ascii?Q?Lf6Ultc1PrrP7GxxDQ4f4CBWKbSUG2Dz4yg2btgn0iKCZlzq1oHe+tghIW5W?=
 =?us-ascii?Q?LsAoNUt4S0fT3MGTTpcYoZprKLA5fvacPZfEhPnKlzbndxm186qbQ8teK1QI?=
 =?us-ascii?Q?E2SvMSAPdOaGmeU9dKQXAe5XA+u+5T9uaiCCE6gquxbP2lMsAPA8F2xy0bDS?=
 =?us-ascii?Q?Fn/vErnMEqaVgnR3h29B2Bdl9asoqyEvEO80qmsMIQZSWAjZrHzYgKcA1qKy?=
 =?us-ascii?Q?v6wCWWX+LEzvnAnOsmOcfvyBfzhHc6wevS3DHn9Grt8Od9OSB8dapk2pdcRZ?=
 =?us-ascii?Q?sqhci6PXehZNJWeryWyLS6qnOR7pX7ynFxzZ8cTZYOmZ/Z+1eg8T1Co7a4/F?=
 =?us-ascii?Q?YwuswAuE5omc37FF2AKs5n7nzGw3GJYoja3ZbDUnOnhkMwxPxB9Du8TstdGY?=
 =?us-ascii?Q?OcHNBEI8XOI/u+m8iFeu6WyPbTIDRmXl/IwNLesLeyz9QegH94qzfImdkURP?=
 =?us-ascii?Q?jMCgmfgTgUqYFJbGZIyAlWCG/C4lcIQCRzF3Te35EVko1MyTipne8PlBkuVW?=
 =?us-ascii?Q?+kD3C/xq8Gex99TrI9hcyGvO+RlPBIoQ9R+9u2/qgkCtxt7wrCBUGw5/9Be+?=
 =?us-ascii?Q?SeJ2bvQta6Hxby3rs6Alyk89EvGOjr2jYzFVN/w4lBCdyqXPLZiiroYmlucL?=
 =?us-ascii?Q?Pvqp49UgHCr0IA9s56fR90vH3SnzTiSKL5at8pthUBaoP1TZXYiLDTaZmMDc?=
 =?us-ascii?Q?mfmhnC/5QzImBt1e0r6pu1IYlwFE5rVmo8GXtQcw28ejoslstCeCF1CK4X4a?=
 =?us-ascii?Q?k9wcWhhh4CC4UVzcmMkmHlOd1+rbu1uztSRzkNIhOwTCqaRD7C5g1Exaav87?=
 =?us-ascii?Q?9FFdrc/irZyK902WGPfJLFM0aThYELKbCNwL11XbyykDnQ7fGyodxpPAIG1r?=
 =?us-ascii?Q?gpED7wFK9k7UHTE7h+90Z7Mbl0SAPjt3ZLlj6zIuSOLCROpWYGR2dHqtXpT+?=
 =?us-ascii?Q?zxjpelLpXGx6B4ezr7y4YUxF109ungeaMSoszNCRgdWfLgg845ykDMvnbPIK?=
 =?us-ascii?Q?fVe2ECwNm/BrvzEmAi0kP0Rfr6Gv0/8cVf+qz9NwtFmcFavB6nfF8T6N9mj+?=
 =?us-ascii?Q?f9t8H2Okzj+2BQ4j+LxN7kubAA8CLMe/UnfghLj9PGqvShaniF6PphbzxrwL?=
 =?us-ascii?Q?Hm9IAPriwLFUKBxlSG1dZDr3SvhRBcuN+DuDXWJGqSs0C5znL/mEd62x6eyx?=
 =?us-ascii?Q?fssftACgM1jbgFQnCKlMFkBRUYd1c7+xlZFozVhAAkTjSF1d20HBcLt671p2?=
 =?us-ascii?Q?6kNgO6Q8tHyfqNnsVOLwlnp5wlUsUj3LsV4k36eL5DwWfrwX89oHgm7uUpg5?=
 =?us-ascii?Q?rYFZ88gw3Kajr591b5PFa6qxU3wpYITyXiOI7iIgufazl7Q/Cjvj7u5b/DUa?=
 =?us-ascii?Q?fzxSH24dQE5hrxOLEJzHahBnU25CgFMlfr1SyifetsN6+XRA2W6i5sPqPwf5?=
 =?us-ascii?Q?bEm1fwmdBgtQ1R9yrYjsXycfy/4yqSzY8fgDXAQrVMJ41r7sZ7sBBIe3wvAf?=
 =?us-ascii?Q?Oc852nbJc5iXhYHcy05zWA8IxZ0LpXb3wYJf/JPL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6247.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfe8639-9fbf-4e43-f196-08dab35992e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 11:44:12.3686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oeQlx3/Boc5GEONIGIiqmoV+WzCSwjJ62WOcJFht5VsLTy042X/3JhCjkS7Vfw8Cs4WYwPVc3QIajPTea6sJ8BGbglvWcKm+eq6VU0l6A+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6397
X-Proofpoint-GUID: yjxajaNjyxHoSu3blnLz_3C-sNj3saVR
X-Proofpoint-ORIG-GUID: yjxajaNjyxHoSu3blnLz_3C-sNj3saVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210069
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 19/10/2022 16:39:10+0300, Ibrahim Tilki wrote:
> > Devicetree binding documentation for Analog Devices MAX313XX RTCs
> >=20
> > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > ---
> > .../devicetree/bindings/rtc/adi,max313xx.yaml | 163 ++++++++++++++++++
> > 1 file changed, 163 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.y=
aml
> >=20
> > diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml \
> > b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml new file mode=
 100644
> > index 000000000..1aa491799
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > @@ -0,0 +1,163 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2022 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices MAX313XX series I2C RTC driver
> > +
> > +maintainers:
> > +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > +
> > +description: Bindings for the Analog Devices MAX313XX series RTCs.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max31328
> > +      - adi,max31329
> > +      - adi,max31331
> > +      - adi,max31334
> > +      - adi,max31341
> > +      - adi,max31342
> > +      - adi,max31343
> > +
> > +  reg:
> > +    description: I2C address of the RTC
> > +    items:
> > +      - enum: [0x68, 0x69]
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    description: |
> > +      Name of the interrupt pin of the RTC used for IRQ. Not required =
for
> > +      RTCs that only have single interrupt pin available. Some of the =
RTCs
> > +      share interrupt pins with clock input/output pins.
> > +    minItems: 1
> > +    items:
> > +      - enum: [INTA, INTB]
> > +      - enum: [INTA, INTB]
> > +
>=20
> I don't think this is right, what this is doing is essentially pinmuxing
> interrupts versus clocks. What happens if you want INTB but this goes
> directly to a PMIC instead of the SoC?
> It is not something you can express with your current bindings.
>=20

Why would a user want INTB when it is not connected to SoC?
User can specify none, either one or both of the interrupt pins.
I don't see what the problem here is.

Ibrahim

>=20
> > +  "#clock-cells":
> > +    description: |
> > +      RTC can be used as a clock source through its clock output pin w=
hen
> > +      supplied.
> > +    const: 0
> > +
> > +  clocks:
> > +    description: |
> > +      RTC uses this clock for clock input when supplied. Clock has to =
provide
> > +      one of these four frequencies: 1Hz, 50Hz, 60Hz or 32.768kHz.
> > +    maxItems: 1
> > +
> > +  trickle-diode-disable: true
> > +
> > +  trickle-resistor-ohms:
> > +    description: Enables trickle charger with specified resistor value=
.
> > +    enum: [3000, 6000, 11000]
> > +
> > +  wakeup-source: true
> > +
> > +additionalProperties: false
> > +
> > +allOf:
> > +  - $ref: rtc.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,max31328
> > +              - adi,max31342
> > +
> > +    then:
> > +      properties:
> > +        trickle-diode-disable: false
> > +        trickle-resistor-ohms: false
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,max31328
> > +              - adi,max31331
> > +              - adi,max31334
> > +              - adi,max31343
> > +
> > +    then:
> > +      properties:
> > +        clocks: false
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,max31341
> > +              - adi,max31342
> > +
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - const: 0x69
> > +
> > +    else:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - const: 0x68
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        rtc@68 {
> > +            reg =3D <0x68>;
> > +            compatible =3D "adi,max31329";
> > +            clocks =3D <&clkin>;
> > +            interrupt-parent =3D <&gpio>;
> > +            interrupts =3D <26 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-names =3D "INTB";
> > +        };
> > +    };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        rtc@68 {
> > +            reg =3D <0x68>;
> > +            compatible =3D "adi,max31331";
> > +            #clock-cells =3D <0>;
> > +            interrupt-parent =3D <&gpio>;
> > +            interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>, <26 IRQ_TYPE_ED=
GE_FALLING>;
> > +            interrupt-names =3D "INTA", "INTB";
> > +        };
> > +    };
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        rtc@69 {
> > +            reg =3D <0x69>;
> > +            compatible =3D "adi,max31341";
> > +            #clock-cells =3D <0>;
> > +            clocks =3D <&clkin>;
> > +        };
> > +    };
> > --=20
> > 2.25.1
> >=20
>=20
> --=20
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
