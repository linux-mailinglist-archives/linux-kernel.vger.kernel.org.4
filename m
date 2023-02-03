Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3217F689934
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjBCMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjBCMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:51:08 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0967E9A816;
        Fri,  3 Feb 2023 04:51:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJURguB3kNT+FpJDHi+9d3L0qdN5hu0NCk+9OsMPmkcxB+QzUd/cqZfZpTQfkQkp57Fx2Qj3YVat+nlKLGQemHnkRLDTrcrTGLv0wUz2DNPyCj8GOXguavJP8S3Kr3DjxOFv5nYsaTeg1WkGa7am7+v1IZfqpbkRC1NTd7x5appnaGx9OPGWGNlxL1ATV9nqs8K2SUm7uceVzW9XFjuWeUDcAqS7jmDAeikx02tjJmKze8q5E2riXANwM8QldjtHjnsgjnJ6BV0LULKYwJE5G1L8kFT/PLd8jBjWKNmYq1mAtYaADGEaSUaINUK+MOzU9ppCZciW01oXW02AO8ZnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/PQJBAmYB94M6fZAlClJQSOJIj+zeUEXCQLPg5lK8s=;
 b=X+S3Z6GRmMxrNZJCibL/HJDw+IuAaCQ7ZcV4eDs5jdeori7eUMebL1zjhHghHOo+a0K4+XNvL1Y962/T1Ps0z0VTYfopGYM/09pJROwGwlcB2ApWK0wdPw5fEWAd2jcRYbVLAud6tUjGTZIVs6ObJSvz5yh/BNlZV6GBNaNKj5LrSW3Dxlmno/YqFrJfEAg9+qhpX6s7T0mpKS3zo0sHsni7Fu19IJvG6i7JbR0BIrvUlT6bksV3uGddx/5inhYl+UB40BB9pnT5XJn7NiRjc4oblREh2Rca/xGY46A6B1bJKSvcYQlwVvMGbd8ENl0HmOo2skdrpJAudveO8qN8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/PQJBAmYB94M6fZAlClJQSOJIj+zeUEXCQLPg5lK8s=;
 b=c+GTqdGs4lpu0KkRShD0Iv2+pI5l0Pocrq3OsJ9mJ4dVF9QEXTK958CvloeYLuOhEbTntoEIku2lk1ukXDDNmWjejTRIqEMXmXnPv/Jw7+k/imt7uNZuCCNGddCRXk3cpTv+m6XdNnQfXBpN4Ezqq1A3WzSobm7S7TqeZIivpjY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9301.eurprd04.prod.outlook.com (2603:10a6:102:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Fri, 3 Feb
 2023 12:50:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Fri, 3 Feb 2023
 12:50:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH V2 5/6] remoteproc: imx_rproc: set Cortex-M stack/pc to
 TCML
Thread-Topic: [PATCH V2 5/6] remoteproc: imx_rproc: set Cortex-M stack/pc to
 TCML
Thread-Index: AQHZMjDJzgt7cVgC9UWv0kJgugWwrq69NtuAgAAAxlA=
Date:   Fri, 3 Feb 2023 12:50:58 +0000
Message-ID: <DU0PR04MB9417DE3B40EBEAD50E2117D188D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
 <20230127092246.1470865-6-peng.fan@oss.nxp.com>
 <CAEnQRZD8MFkn8JB7CJviMF1=5gp6KWrM7-n935xk=Hv1j_VPuQ@mail.gmail.com>
In-Reply-To: <CAEnQRZD8MFkn8JB7CJviMF1=5gp6KWrM7-n935xk=Hv1j_VPuQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB9301:EE_
x-ms-office365-filtering-correlation-id: 61b9def4-3257-4092-f8e9-08db05e54c81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+wqHG/ytDib7pXl30wBSCKCyyE3G80U80foxdpAhga2V4Vx9IWh9bk3gygvl2rgxv3KIaolPph5iqfzaJRUlXwmk4x0BuZ18d58G2wEgZuDFZO6ZOmT5v14RAubjf87znMkiRUAWSEXPhr8GnM9/ABOUtt8Bxp7YuESvWGpanvoOV8Q8J8YIbVmaP76ZJHf8JVIr+4bdg+mExuJDnUI9ShswRQiG+YQg5dxon3NqQyjfhiUYsrF+713C09/dcdyYYVRR/HlyB6QaC9ez24111XYW2y98RvcnVjCzPXKnxkmgc2ybZ3rhllJiEAdwYaTZZ8IrogC6v8rvw4YkX/j1tpRlKGtGcM5LPKMkKNlhe88T0+Zh92td7b6SaHwv2xVbqhoU9q7JFvGQdJ2j1yd0+/vEADJ7/AXgNhPjCRq0dt6ghVQW5rVCe6I7JAiKwM3ZvqYH7qaNlS6OBIObnMDuuS3GZQCezOU3AYM/jfACHnx/8OL+SlAF0fUd/EdDv2jvtWeqxQ33CNHNRH9od2K1G1sczl2GYi3NfujbY2k0/IHQDohy76u/WKd8c6Bl07jZv+i7qQJwVKKXZ5kTlMGQ6a8awMH+beogLlOyFT/kx5RbLugeOsNJ8wioMO6T8Tm8FpUarxeRAxtSsB/BbhzyXQZfZvPETLtZmev02tKUNHBK+lG2FZfzCQHIIoAmtnqI6POSAGI5ICd0LZ1FWqQYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199018)(7416002)(5660300002)(44832011)(83380400001)(38070700005)(86362001)(122000001)(38100700002)(2906002)(7696005)(71200400001)(6506007)(33656002)(53546011)(186003)(26005)(9686003)(478600001)(66946007)(76116006)(66556008)(64756008)(66476007)(66446008)(8676002)(316002)(41300700001)(54906003)(55016003)(110136005)(52536014)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1NTR2RNcmp5VklGME5DQVNCTmpFVVNQRk1uR0crMzJpM0pNMlNFUDBCbmRH?=
 =?utf-8?B?N0RMUGMzSTBBaTk0eTZtQWJ6WHBiV09ubkxqU1hIcmlNYVdiMndKN3FkZ1Y3?=
 =?utf-8?B?cjMzQkFsWURnQU02Q1FUNDlST05SaXpDSE1PNWYyN2RlZjdwejFLT09HMWFM?=
 =?utf-8?B?K2o5bzZJTy9UNHcwWE45RTB4eHZQU3BER0sxc1NpaE56TTNGVzMrOGNyTTAy?=
 =?utf-8?B?dVBPeWJvUG1aaUJ6Ym5JZEdHVnMvOE9taURYeGMrbU1BczBkRno3ZHR4aGRR?=
 =?utf-8?B?OWRHQTA2am5CZ0ZTVXFlcElNVmxaUndINC9UT2tpQXQwMlhyOVRLdEpyZzRJ?=
 =?utf-8?B?d0tLL1BaSXZ3YlNUWDk4Q1M2QXU5MUdoSmhicEUyZDcrd2oyamE1ZU5aUUhX?=
 =?utf-8?B?VjQyUFlFRHdnS0FpWWxNcTRiYVRjL3RGTTJKRmw0UTIyeWV4UDVvVzhMV09D?=
 =?utf-8?B?ZCtZR2I0RStGUVE3dmlsOUozSnVMQnltNlhvK3pCNzhSRG1yTEJQS0NsK1BM?=
 =?utf-8?B?cTlnbW9aa2VBMGNlaVVTUGdhWnZodnl0NmpCckhDd1FMY2owalJkbkRjUUJ5?=
 =?utf-8?B?ZlFGYzNaTlNyMjdrWU54OU51RHhJMTlEcWZ3aWlrbWk4alo3RWVPQWZpRUZn?=
 =?utf-8?B?anB3MVBGUTcwTmRXK3hxVmJHSW8rMkZtZEc0Y0JTZXBVUERaR1pvQ1ZwSWlk?=
 =?utf-8?B?aHNMRTB3RzE3NkRiNklpMzdQaFNoVmdsejJVdnZsZzlnWWhCb1YyZjZHLzdY?=
 =?utf-8?B?SVdLUHdTV3lIR2kwelY4eko0SEtNNHpMUFJPUldMRDR5Qkx4TzVrN0NqN0ln?=
 =?utf-8?B?VS84T0p3V0ZuMmJKb3FNQzNmUCt5SFBCbkU2amI2c2JtUUZUaVd3WGtPKzVh?=
 =?utf-8?B?QTh0cnJVRWZiQ0JCNkxvUHJsSWlUbnJnbHc0dlNsQmhtK2RxTVMrNlJ2WFls?=
 =?utf-8?B?b0dReUZLZXRsVmY2OFhOTGV3Mjdla1hTODA0dHp1NzVwNnlkOVk0T1N3bElx?=
 =?utf-8?B?eWUzWS9TWUkvSlBnYmZPS2RUc3BkQWNEWUFwZXZPcFdPLzkyN05FNnlxVnVq?=
 =?utf-8?B?WUYxUkhSSzdZVHFwZmFnWHh4NVJEYU5pSkwzeGw2STRJRWtvamkwcDFOcFQ0?=
 =?utf-8?B?MzFidnM1ZlhXelJnUzZBcC9Nc2VVaEJsN0JVSTZOR085cmRKWTh0SzNScnJC?=
 =?utf-8?B?U2NTQ3ZuUTg4NDl2VURCUnFGTzdhOENCSkJncE8ybXdUVUNDdXhPV2xnUm5w?=
 =?utf-8?B?UUg2WS92NThsVDB2dUEwc2lwcUpWRStZY1dKNFpJRnZPVmx4UjB4VTIwQXhB?=
 =?utf-8?B?RFVoZ3ZvdmxBRE02a2gvaWJhQlUzdUw3M09NNEhUb1o4dTlmdnlxenhtWmtl?=
 =?utf-8?B?bFVnV0dnVnNUSWkrR3VZa2RleGluSHZMKzBZN29YVnJtMzUvWTJnaDdJRWVm?=
 =?utf-8?B?RzBvTmh3ZHhqT1VJMHErdFNwSGtIcCtBTmJBVXlhekFKZzFEQzFjay9sQ1ho?=
 =?utf-8?B?bEhYcXE4L3ZTRndob3l4YnFmeWJ4cDE2WWdwY1p1N1YvWUViVis3TzdjTllO?=
 =?utf-8?B?RkQ3SDJSMkJqUkh4V1FJNGNzMFJab1hPVEg3VU4rMWZkUzNsMkhaTG1CRVlh?=
 =?utf-8?B?LzcyOFRiWnB6QkIxTUoyRjdjWWlkNjVPWEhEam9ia0dtMHFWODRMc25CR3pX?=
 =?utf-8?B?TlREeHNXaUd4cWhveVZQeXBPRnMva0lTTTVwTUtmaStTRUIxS3hLVzFGRDZH?=
 =?utf-8?B?cGV2NWZhM0RBNWU2L1MzQjNMOU1aWnE0QUZyNTd3NFBwcEZmOS9MemRYaFNz?=
 =?utf-8?B?YnIxelZXd2Q0c05TSmxrS0RYdi9iZTFxU2N0QnFMMkFBajhyeFFqZ1ZycCtG?=
 =?utf-8?B?SUZwdXllVGpMMHNhREkzQm1qK21HWDd5UnVRYXltQzQya09xTlRocXNldldM?=
 =?utf-8?B?ZStVVEJodTVNdVIyMDNMalMyZlY5akl1RjJRTkpqdGVUc3VNYlcyeTlWenpP?=
 =?utf-8?B?Tkh4TVZ6Y0pETlpWVjlzNXhtRlVSQWFWYUwrM2ZHNmZEZmdDL1FwQmNJclFh?=
 =?utf-8?B?T3dqcEw2b2xlaHBhRnczc2ppckd2ZjEvQzlJdGlyRmxvMC9vcy9PM1dBVUlu?=
 =?utf-8?Q?B1Sc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b9def4-3257-4092-f8e9-08db05e54c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 12:50:59.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29OfsCctcUYvzFnu9B88JWCjL9CRe5wJpr8V/+CVYyuumQI94sRrpYiYDRnu6OCBD+46GiIAMCFk5BJLes/63g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgNS82XSByZW1vdGVwcm9jOiBp
bXhfcnByb2M6IHNldCBDb3J0ZXgtTSBzdGFjay9wYw0KPiB0byBUQ01MDQo+IA0KPiBPbiBGcmks
IEphbiAyNywgMjAyMyBhdCAxMTozMyBBTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54
cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+ID4NCj4gPiBUaGUgaS5NWDhNIENvcnRleC1NIGNvcmUgbm90IGhhcyBST00uIEl0IGhh
cyBhIHJlcXVpcmVtZW50IGlzIHRoZQ0KPiA+IHN0YWNrLCBwYyB2YWx1ZSBzaG91bGQgYmUgc2V0
IGluIGFkZHJlc3MgMCBhbmQgNCBmcm9tIHRoZSB2aWV3IG9mDQo+ID4gaXRzZWxmLiBGcm9tIENv
cnRleC1BIGNvcmUgdmlldywgdGhlIHJlZ2lvbiBpcyBhdCBUQ01MIHN0YXJ0IGFkZHJlc3MuDQo+
ID4NCj4gPiBUaGUgc3RhY2sgYW5kIHBjIHZhbHVlIGFyZSB0aGUgZmlyc3QgdHdvIHdvcmRzIHN0
b3JlZCBpbiBzZWN0aW9uDQo+ID4gIi5pbnRlcnJ1cHRzIiBvZiB0aGUgZmlybXdhcmUsIGFuZCB0
aGUgc2VjdGlvbiBpcyB0aGUgZmlyc3Qgc2VjdGlvbiBpbg0KPiA+IHRoZSBmaXJtd2FyZS4NCj4g
Pg0KPiA+IFdoZW4gdGhlIGZpcm13YXJlIGlzIGJ1aWx0IHRvIHJ1biBpbiBUQ01MLCB0aGVyZSBp
cyBubyBpc3N1ZSwgYmVjYXVzZQ0KPiA+IHdoZW4gY29weWluZyBlbGYgc2VnbWVudHMsIHRoZSBm
aXJzdCB0d28gd29yZHMgYXJlIGNvcGllZCB0byBUQ01MIGFsc28uDQo+ID4NCj4gPiBIb3dldmVy
IHdoZW4gdGhlIGZpcm13YXJlIGlzIGJ1aWx0IHJvIHJ1biBpbiBERFIsIHRoZSBmaXJzdCB0d28g
d29yZHMNCj4gPiBhcmUgbm90IGNvcGllZCB0byBUQ01MIHN0YXJ0IGFkZHJlc3MuDQo+ID4NCj4g
PiBUaGlzIHBhdGNoIGlzIHRvIGZpbmQgdGhlICIuaW50ZXJydXB0cyIgc2VjdGlvbiwgcmVhZCBv
dXQgdGhlIGZpcnN0DQo+ID4gdHdvIHdvcmRzIGFuZCB3cml0ZSB0byBUQ01MIHN0YXJ0IGFkZHJl
c3MgYXQgb2Zmc2V0IDAgYW5kIDQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL2lteF9y
cHJvYy5jIHwgMzcNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVwcm9jL2lteF9ycHJvYy5jDQo+ID4gYi9kcml2
ZXJzL3JlbW90ZXByb2MvaW14X3Jwcm9jLmMgaW5kZXggMjk1ZTBlMGU4NjlhLi5mNWVlMGM5YmIw
OWQNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2MvaW14X3Jwcm9jLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3JlbW90ZXByb2MvaW14X3Jwcm9jLmMNCj4gPiBAQCAtNyw2ICs3
LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2FybS1zbWNjYy5oPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvY2xrLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gPiArI2luY2x1ZGUg
PGxpbnV4L2Zpcm13YXJlLmg+DQo+IA0KPiBJIHdvbmRlciB3aHkgZG8geW91IG5lZWQgdG8gaW5j
bHVkZSB0aGlzPyBOb3RoaW5nIGluIHRoaXMgcGF0Y2ggbG9va3MgbGlrZSBpdA0KPiBpcyB1c2lu
ZyBpdC4NCg0KSXQgaXMgdGhlIDJuZCBwYXJhbWV0ZXIgb2YgZnVuY3Rpb24gaW14X3Jwcm9jX2dl
dF9ib290X2FkZHIgdXNlIA0KJ2NvbnN0IHN0cnVjdCBmaXJtd2FyZSAqJw0KDQpUaGFua3MsDQpQ
ZW5nLg0K
