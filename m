Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD3A682D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjAaNNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjAaNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:13:05 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64A10A92;
        Tue, 31 Jan 2023 05:12:51 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VD1Ql5020469;
        Tue, 31 Jan 2023 08:12:29 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3negvtqece-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 08:12:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7ckshUhCUbi/jDIJq9pUIkzn0s/oo3C3rq5Sc8eYrgajP6IwXX2H07TT10xRdsZak3lgaaK+M5+ea4MsvfYhhBaXS/+rIDMRMNrOaOc1aw11dbZ0SwrclWqLE0rMRyjB60oTBh2G57YDJdjCfuolRc/OqnSejuSTNPJ854I9dMteJF9hGIqeEoW51vb9iP5TAOE/fpJqV/1d7AHb1x0NtXx4T+J4JJv3vqSo1axZerKg3z6u5oN9BTP60t+IhPs4/GRht8q+MxPl2V0FtMnrDlJMAoHrUC6VxKLu3zOwS+l0qsE48vbUTxTRw9EmGAo903y0utzLtBo94O01ZNK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQZL9q8uBipy83ELo0wBFma0RT50ewUvWZwZSfK5UmI=;
 b=fgY79pY6tW+LpCBQa3Zk+ue+d3HvgZzOKbH8Po3UZCccYcmnHzZGj7x+lECzNYlOuzHdeyYahEUSh1U5WbaKHQLSaGAyOd30pYHxVQFQ8c253//nx6jE7fIAghly12QrDnqYv04PxoaXq+hfdS7mBJ6jJkPTJ3HcnkTxOCuQM8JxLb+c68uB/Jj0waC9hp+DwHtVDpWJhJnXIlGlCWGT534uWzaYbhzrySpiOoz9g4/uDYz6zNAhiwuWKh1yew9EYPOZziAW3kFwHD2r3wBUmPg6z8pSWUsnnPxj3v4P/J5lkyWYB72th80OzG39HXIELKN3pYEaRVN9aa8J5AojcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQZL9q8uBipy83ELo0wBFma0RT50ewUvWZwZSfK5UmI=;
 b=OxF3YMCDspbw0RZ9viVO4hAxizKhBhpJ1EKXXFkW6ndnJ0Kr0AP86xdFUCENdiCQOavG5oEvR5bBuwMw/feBkFjRoB6SlfH4uXdUmpGND1Gdfp4tiqiv65q9aEOFnWsmkpSlS2AisLxOVVP5fpAgkcB7RcxqimpQakiu7Z4RPcc=
Received: from BY5PR03MB5153.namprd03.prod.outlook.com (2603:10b6:a03:22c::21)
 by MW4PR03MB6523.namprd03.prod.outlook.com (2603:10b6:303:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 13:12:26 +0000
Received: from BY5PR03MB5153.namprd03.prod.outlook.com
 ([fe80::f306:167:891a:c68]) by BY5PR03MB5153.namprd03.prod.outlook.com
 ([fe80::f306:167:891a:c68%3]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 13:12:26 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Topic: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Index: AQHZKwfLM9q3yL8ciUSLt6aTy9zYOq6j1SEAgBRcQ/CAAFZ5AIAADHeA
Date:   Tue, 31 Jan 2023 13:12:26 +0000
Message-ID: <BY5PR03MB5153112086B2B9F899E8524AE7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
 <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <Y9kIfEj70XdO3Q/7@smile.fi.intel.com>
In-Reply-To: <Y9kIfEj70XdO3Q/7@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLWU1ODM4M2Y5LWExNjgtMTFlZC1iZTk2LTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFxlNTgzODNmYi1hMTY4LTExZWQtYmU5Ni01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjExNDYiIHQ9IjEzMzE5NjQ0MzQy?=
 =?us-ascii?Q?ODA1NDkwMiIgaD0icFBJOTdqNlYwT09DbzhHcm9mbElIaUlqWllzPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFCMjU5K25kVFhaQWUxRHBRU3FkcHVzN1VPbEJLcDJtNndEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUFSczFnRlFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6?=
 =?us-ascii?Q?QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01B?=
 =?us-ascii?Q?ZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlB?=
 =?us-ascii?Q?REVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR03MB5153:EE_|MW4PR03MB6523:EE_
x-ms-office365-filtering-correlation-id: c2c07b95-d56b-4773-b307-08db038ccc74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7YX1YJEaKb/xp0CE26AILh1CfVM1CF9zw8eepNm84i9GtHQ+gWbSwVKDGrcoB5e2V5X/HD2JytGc9o6nHlTir/lEWcv40XfY5/pBmnlJQZh6iWl/ZcFB4ZVaV/ylEHVRJvaeEUF1EErkPCSYoVbFEqJrghRl0RxLe06mFx4/tb/auvBK6QvhpMl5VckOxTOuXQEHhWhThzY5/OKML581FxC/82r4uG04iMwy6LdfZ1CgOA27IiSzxdS3ElouIZOqp6BeCSCOGXdGMkFENqbQZIZ5j7OFnonoOdVMT1jeFfDnjngAPbk7aqhUvp7C/7MOoBEOatq8f7xXKHcdzPKVjNT9++hKzPHI/kAtyjE90djpotNw8VTzJvH715kOtsGBZOa50m1FHvntKk+4+D9eGMTooPVtvngLghPR+27M7TvJzvsd41PtY4MsFJw9NsTQnrMDKFtuJHY/f4gpynnTZStM99Sk+QaWHZc8iw083N21rZN5pOMdjOExEJ/pN3jPRd3JZUAcJMScN+NdS+wfz/8DqrShMIsik+rVdVGYL4yAzQq8AKFD+eknAWwnIUL1+VCvNZ+UOeEYpi26bE3DVselLDSGxWVJU7R+8TaedjaJN9B+FbX2qPTWfEGR80CcARawnuqVDE1zR0d/GD+rG6WR8/iG46aETBlaCrPTfhMKDLPHdJEzaJ6GMs08/ZS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5153.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(4326008)(41300700001)(86362001)(55016003)(38100700002)(38070700005)(122000001)(316002)(54906003)(8676002)(6916009)(66446008)(66946007)(66476007)(64756008)(66556008)(6506007)(76116006)(33656002)(478600001)(26005)(186003)(9686003)(7696005)(71200400001)(4744005)(2906002)(8936002)(52536014)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xxmt0tUTcKPJtsmpB6rd1iOdwk1aM9i6RPeMFosFYd1/Xnsgp9qxB4Q6TQhT?=
 =?us-ascii?Q?wzYWuWlppOT8s46dKrL8+RyMydfi+7IoM74wsTsAssSTwrQ2AvrFM+OvcxI6?=
 =?us-ascii?Q?xqpqxnY+2Un8M1g+VS8G4y8xEm2gtxuSTS+BVUk33SWK1lk23LJCt/6aZF8n?=
 =?us-ascii?Q?pI+IDPLtBl2j/T4GhdfQQo2LCU7aDkYW2hTSSVVWvZVOrrHR/y0VzTuO1+O/?=
 =?us-ascii?Q?PGf3LWcuXWj/EonaIN48qU6leZncs02NK23aGwrA/vrXmWccuUlm0m4VngV+?=
 =?us-ascii?Q?iv1keu4bxIJFjAjDzbYORaJfi7pPqK+OM9PGvlIJaK23o1NuxGhLhvBA2iEX?=
 =?us-ascii?Q?kH1udzHhwBG73tmp30N6nF7YoxqLqAPe9DvOnkzXXQgXnAJwovvwXyIYJKIl?=
 =?us-ascii?Q?DDE1xMt9t9V8xkZevZyWhz3LZcRY1rIzbSZb7uhDSwZ3D5D7HrC1C3UFeQe/?=
 =?us-ascii?Q?r3TQSNLHMr31/daW4GUBWMYEN1gZZUcHaEO1fp2TRvzMSHKedTVFIuQiLHHb?=
 =?us-ascii?Q?0zFckhek/tHfo2QMfurXIf9V7bkSRI8is3QUNCMnVtt3SjtWJtOIhxIgjMN2?=
 =?us-ascii?Q?pyp6L1NLNGYL5Yqw4GklyZ51iv7DMoLxgEMDE6KpvWs0RMhEE3duHDLnqki9?=
 =?us-ascii?Q?3V/zM/m/kp5a02V3YhnmiZZBUiPh0RK22QfELTDl8a+Fq8jGDvlF19u2LwHL?=
 =?us-ascii?Q?y0gCCIQDGSe0NVNEvPmvWn9KH9vRm4mDUWFaqR2mh5ht6LaJKaNJ46tHonPj?=
 =?us-ascii?Q?4CdEg56SiXOOYVSg1vuA3AJMzrzRGddUo6FYy8YIGJaUO+otaC8N8IB2UAdW?=
 =?us-ascii?Q?wewo255fT/VRIVMW+Dmxf99HTTWfOWiL2AbInQcCZExeD2qIFh9Vr+IWA6gS?=
 =?us-ascii?Q?L2IhQGtFLXe6ozaRoWdljL5H11anAYDgHBc8CnxH5D62qQDO6zgI/D5I64Dq?=
 =?us-ascii?Q?5hX5Rx1Z+wAkIwlvVHmcz3is9qlKp4Q3pVctjs7HDWu7qb+EvzqGaSnlparX?=
 =?us-ascii?Q?2AxUIvjtmIb1SKxXXC5sDmV/Joia2pqRyI/Bzpx7qHP+a4fpM3/scNFsTU5+?=
 =?us-ascii?Q?bci9Wu1Fgfy/k4j1tcTxlAbNsdsxe5ek7xLWV28yfnA1+CTHxRCMW4xKY8X/?=
 =?us-ascii?Q?/+Vs6OV/WnX84Q6kE0fZJVICwkTaoiJSTrzppnw/qsdHKVjaK1jfIUBWdWCG?=
 =?us-ascii?Q?QQXn+zvYFn6w6jGksiJgtyGc54PDfgnEqhM6wy/MRhvUDJURx4ShzDPZMTRX?=
 =?us-ascii?Q?t4IswOhWpOSa+bnOcDjVwOnu/b+Nu1Ofp126c9Yxz/L0kjaTTVErp28YR8Nv?=
 =?us-ascii?Q?rEn/woNnlHaSvy8UwqLjABjuYuZE3xUfsBgGaCj7e4hqOF1im2vuO+c8BtLE?=
 =?us-ascii?Q?iJpbMproWw6JnFeRIRa/4oLVo1g3Cwy9acM9iUofFBJ2Ut7n3PxmU9Wk5xRZ?=
 =?us-ascii?Q?cUFpA7+ImFbbRP+ZfPSZSVX/Fah+BHbeaqt9Hi4YuREZaJN7DV1NNOw28wn3?=
 =?us-ascii?Q?L7yk7PLmu8qjkQu8R1wAY+zYlqYsT4GDO7rsNm6N1DEPEHICY/ONCwbSLckY?=
 =?us-ascii?Q?Kf06sgZ2hSQYfvEyev98jnhauBbSOcYy590gKojq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5153.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c07b95-d56b-4773-b307-08db038ccc74
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 13:12:26.3405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQQ63Nq+iXDucLwohYdHrybBNINOXSnkCGfYDs6WoSXT06PbvT9ppRG5UcIXyrnR/WK7EebgL5hViPJTA0lIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6523
X-Proofpoint-ORIG-GUID: gcz_-5UnyoFhLctsi_JS08Q2v5-VT1p5
X-Proofpoint-GUID: gcz_-5UnyoFhLctsi_JS08Q2v5-VT1p5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=890 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310116
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2022 3:24 PM
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

>On Tue, Jan 31, 2023 at 07:20:52AM +0000, Sahin, Okan wrote:
>> On Wed, 18 Jan 2022 11:20 AM
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> >On Wed, Jan 18, 2023 at 09:38:10AM +0300, Okan Sahin wrote:
>
>...
>
>> >> +		rdev =3D devm_regulator_register(dev,
>> >> +					       &desc[i], &config);
>> >
>> >This is perfectly one line.
>> Thank you, I will arrange it.
>> >
>> >> +		if (IS_ERR(rdev))
>> >> +			return dev_err_probe(dev, PTR_ERR(rdev),
>> >> +					     "Failed to register regulator\n");
>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +}
>
>> However, this one is not fit when I set max-line-length argument as 80
>> in checkpatch script. What do you suggest? This line has 99 characters.
>
>Which line do you refer to?
I am referring "return dev_err_probe(dev, PTR_ERR(rdev), "Failed to registe=
r regulator\n");"
>
>--
>With Best Regards,
>Andy Shevchenko
>

Best Regards,
Okan Sahin
