Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5D6A53A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjB1HZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjB1HZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:25:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00ED1E1F0;
        Mon, 27 Feb 2023 23:25:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNe+5v9YcasFiZqKr/nVjv3sO8exMl2hM9YzI4shAZH2lmp7D0Hndh8rTBaCskTWIm5uyIRONKGLUIEwXee2G8H11akiz71EDUkqld1f9C2pCsgnxnSV+rf/oVC6iUtU8v0l8JTVQ817XFLvmxh90FKplTzff1jiXyFu74nOkY3NfMy11mcPSKZRvUv+kjeNzd3YPTUn0ZvOCjsPvFjjV/6qSEWQhiMAlGj7KpAI/v0aS5lzD0ADioi3j9r52QInGlKghtppkjeMmnNKhgrYDbs/Va8LZQYfjHp/WLTQwtJ6WHiwVouFIuYr57KSYxKcJDtnww4idlvU6GIwypUBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubv3p+OluilpKzlpnjEqMQ3TtliP4082KcqUj/HPxF0=;
 b=VybyhgA7oJv+ZbUuiHW9sI6am/SVlzq6mmtfJsURIM1YJhpDNuhtPQ9X+pHel+nHekLLahmYHFV8Tcw8d7pGqXmZ9EiOZjiOCyXlAnU+ehtHvSjM5sjkHhqise6e39OP5WOoWQodLeVEaVQRMVZaJ8/mR0k9eAUvkdKRKbRY8UzBUFnaenys29/l6Q+j5c3MA6R6m4aw66rD+yf98o4kNVW3ZsJ0uQMes1EUYMW6dIP0Pjs5hNHqLEuufBCoWDgWBhGyPpkp1K3Yy/Sm3AuxhktL/8/KHk7lBPugkJ7xGUSKhv2Kfvjkos4EFg8hLUY9CGsryrJSmOD2tw/Lc7yksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubv3p+OluilpKzlpnjEqMQ3TtliP4082KcqUj/HPxF0=;
 b=OUBE4qaVvGQcHHdMEEvZHPCoB44MKZa3iG3HFHTgQRSR1ajRm4TogCk5itYM85pw3aRvHsXr4o0Cu/n1mXMcc+dDt4P1qpPyA/JaBWWvGjV+EQsa9SDebNqv3aC/5kPrfjI7ZmKBq6dHdq71uAjYQyqKqOosoY8UdnprYuTvjfM=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB7856.eurprd04.prod.outlook.com (2603:10a6:102:cc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Tue, 28 Feb 2023 07:25:09 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::df09:aca5:4487:9fcb]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::df09:aca5:4487:9fcb%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 07:25:08 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: NXP imx6ull nonalignment buffer question
Thread-Topic: NXP imx6ull nonalignment buffer question
Thread-Index: AQHZJCqfilmTz1JUB0Cl7AgFtNcXnq6btY6wgABA6ICARvyjgIABTdcQ
Date:   Tue, 28 Feb 2023 07:25:08 +0000
Message-ID: <DB7PR04MB401000F6F54497A17D96475190AC9@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <CAOf5uwns3YZMY5xhM+o0rNvtTqEDwCbua5HuSy-LBwgZq_eWYg@mail.gmail.com>
 <DB7PR04MB4010D6ABA0D10AB826F468CC90C29@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <CAOf5uwmaP0x3s7W6OZaCfLmJguSMtKtJtLCgKZ2nuDZ9VgpLVg@mail.gmail.com>
 <CAOf5uwnuFBXF52Tbe7EFXcjzjbr-oOhn-fDVw=p8uZ8Y_Z7v+Q@mail.gmail.com>
In-Reply-To: <CAOf5uwnuFBXF52Tbe7EFXcjzjbr-oOhn-fDVw=p8uZ8Y_Z7v+Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PA4PR04MB7856:EE_
x-ms-office365-filtering-correlation-id: ed1056fb-de62-42b3-2863-08db195cebdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwLLA+kuIerafMG+IlOKhui25fWR5QuCcHcifVbYyJKmYUbLm6nQpzHMJMVA8ATnZjElYyAXgiecuqlovy7dBp8g1dCYlSXl0wjDomRLCXnadeoqUb765McTOlv8JQSyaCw+1+Iencge4+ebi31SP06HcnnKosqh3HbeAs5+josVf3C/ou+fIZBDWRM2gz4c7oUUyuoQeiAHg9LuEVWLJpAf33gxGeeJK7me31Cl0OX6bgZ0ZiERhDR8A/TOArmbs1yU7bF3udMO6A80nyZ50jHosXrRrvnJLpgo2nS4vtiwcBUrkjCzwJDFftyf8v5iViFMpQ3Dh9Nci05oaRNUtlQgpzLlfDiL3xhFdl8Su05TpnGImrJDs1BcqhncHQh247jf4+yH42qHppEGEajJygsHF/ev45ZFwjF0K1+cBVN4BPGNv3gPsj42QcZGVapiqQuxDrr/qWpklJeR56318sTyYH0uYQ8KFmsku5EoyHOupAtpfOrD4KuQvxBpFKgBeYl59hudhO4B4sVRgETBR19+dj2R3OX5Eufc25iQd6D5/fbgBGHg0yQuceckFj7eUrft7EsfDYIvfwttW/dedM7T8m7poU+2PCWRI0V9viNzQANwcsrwQRYFguO8KDf1I3wpN6FwgdXb1FyVMUcDrmVoY7Bg0mWhZl0QsQEXoVklXLCwMFJTFrmpj30wLlonus3O353l1fTNKvDaKlEdKbG6gFWTxR8SphDRK8/sRH8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(83380400001)(54906003)(316002)(33656002)(4326008)(6916009)(122000001)(76116006)(8676002)(55016003)(64756008)(38100700002)(53546011)(6506007)(9686003)(186003)(26005)(71200400001)(7696005)(478600001)(5660300002)(66556008)(66446008)(66946007)(66476007)(8936002)(52536014)(2906002)(41300700001)(86362001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXNFb2xUVFNLM0pGOVUxYVBwL200dUdXZE54d1FmNWF5U21pKzF4T2R0ODhx?=
 =?utf-8?B?ODR1SGpNejZLU1MvZU9JQ2Jab0EzdHBIUU9kZk5rT3RkTU93SklTM3JYdlVL?=
 =?utf-8?B?eU93bUJ3bHpyblhpZHRON0tQaVRkN1llODF4RVpwUmtZL0pPNXhyMVBueHR5?=
 =?utf-8?B?VithYnFzZ3licGUzY29wQUpwWXVxZENXUG9xcjUzZ2VhODFmaWRnelIvVHhB?=
 =?utf-8?B?Qzd3WnpyVzd3ZGVLK0hMQUlzMGNzeDRXcTVNZ0QzdzlsMThoOGNwMmpkKzVJ?=
 =?utf-8?B?aDUwK0VZWHRub2lkeXdJMk5Hb3VrN2g3Mi9BK0hMbERQN1gzdXhvYlloR2Fh?=
 =?utf-8?B?UzU3NVU0UzRPR3lUY003T1Y5dXNUd1lUMmFuWC9kd3NIT0dRUnVEcmhvaXU2?=
 =?utf-8?B?RXh0UUkzc0N2d1dXaFJFVWJlbUt5dTNkN010dUdhUWZQdm40cUJwV0hIRWEx?=
 =?utf-8?B?b1VJbVAwbzlCclVQbDdtVlhZQXdTYzZ6N1dmUTJ1cDNHSmRQMFpHNVJMV2p1?=
 =?utf-8?B?Mk8yakZBNm5tOW1wclovY2hMLzczL2t2cVhVZVNIYndVUko5N0J0cWcxTUFM?=
 =?utf-8?B?RHNMaTFUcjBBL1NXNkpQZmlLVjc0SXNOaE1PY3FsMEUzUllyVnhPWk1BY0hx?=
 =?utf-8?B?VUZMcndZS1NNVWl5bDdsLzhlTkh1SXU3anJWWTgrdlp6R0Z4czYxWXg0VHVL?=
 =?utf-8?B?MERMNTE4eEdzMXhPNzAzaUd3WWZYMnkvSEdqNENXY0piamlxZHMrZE1GQVpp?=
 =?utf-8?B?N3lFL1NPa0dMSU53a2RGbVdaTTZVYiswWUtQQlM2WEYyZEhiby9EZHhWWEF1?=
 =?utf-8?B?dHVMdWhOVWh6eVlJYVZjRkxpWGFtdXBqdHlSUS96VWt1OXBsRGFYbzZkV2c5?=
 =?utf-8?B?Y0E3YTdPanpkSG1UeWV3TzNLcUIxVUFIYTcrMENlNGI4NjVVMnVYNGxOeml4?=
 =?utf-8?B?VzZUdTFMb01hUGt1dHpwVVRNYnpyY084SE95WFZieFRxUWVsUDJGUHNNQlhB?=
 =?utf-8?B?NUZsZkd3WFM1dFdJWThoWUsyVDhiZDZkRkZhay9YOFhSL1U5QUdVRCtNNVZk?=
 =?utf-8?B?bDRCL2RwaFdPRGROaDh0MjdIVSswbzY0Umg5MzVPZjJGdXhRZlhPTG5iZmp0?=
 =?utf-8?B?WTVBU0loOWxtaUE5VWlGVmhZVmJHNEZmWDBuQWlrRDhQN1RGSjg1Q3ZNV2t0?=
 =?utf-8?B?WGowNzdhOEZBU3lHU1F1Z1pBcG40TGtaSzVqeWFLNG5JY1Z5RXFrRmJzS0pJ?=
 =?utf-8?B?akMzdEVrcGhQTldBQTdWQ0lrczlyVzA3cUl6dlJDRFFNbEdRK2FtMWxVQWpj?=
 =?utf-8?B?Yjl2bmpVUFhIT0lWd01VaDF5L2pGS1JycDNoNGpGUmUxbXdWQi83RzBWMDJv?=
 =?utf-8?B?UEIzdW51Z2F3TldEeXFBWEUrSjBKNWJMVWY1MG8wQW8xbkozcjREcXRlL2xi?=
 =?utf-8?B?cS9zcVBBQzJERTZyNnprTHlSMzI2RkwzNFdjL0Q5ek9YQlNWVFpzVWpBQUVE?=
 =?utf-8?B?MlQwVUFTUzBnSFdHSFFoL21DUmJHOFZCYlJYSUF3WDgwbzg5bFFwT3BqZjdR?=
 =?utf-8?B?R1RaekYrcENJZFVSZ0ljbC9BT0xiQ1pnV2MreHFRbkNQYlNpRlUySnNEZmVa?=
 =?utf-8?B?WWprNnpXd0Y1QWYwR1I4YTdHK2kyWlZGWWNYM1FkRU05MWQ5L05MVE80TFhV?=
 =?utf-8?B?dzhNUWVoR3h6WERGVWhuZ1VXMjVOWmRDNm0zMlQvc2N4V3JZeTZRRVo0Y2Qr?=
 =?utf-8?B?S0ZTM3JXWTNYckJFSVd0S3JvTlU0SDZmNWFHSStkSUs3eE5aZU9pMmVxWEYr?=
 =?utf-8?B?TVFjVERBVno3QWdONEJyTU1VUHc1MVFyaXJXQlMxalNLZTJaMCtvbENGVGlZ?=
 =?utf-8?B?cmhoZ2w3RW83T1NDSWE0cXNsK2dNcTZBS251QjVsenVZRnNWZ3pPVHB4MUlj?=
 =?utf-8?B?elhMaGtxcTlHYnNxOW42RlNkb3AzbUU2clFibWVIeGFtOWtHSWlWd2F6RkJx?=
 =?utf-8?B?d3I4K0VIN2tKMVhhT3dxRFVkQUhPYVBhTGlFVkZDV0gzQmpBdU13TVhhQlh3?=
 =?utf-8?B?REVxcjA1TVdHM09ZNThYaTJOdmxsUms0bnRPQkRsR2VHZnlLUjlTRlJrSGhU?=
 =?utf-8?Q?14ZRoCGvO7mWQeKbZsqBrrCk6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1056fb-de62-42b3-2863-08db195cebdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 07:25:08.7595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 926Fm85TCy3Q2a0ldGyTtGEjeqGm+2UJlIoXz3F9BxQcn+z8sh+1hphQnSipI3dcg5XYxjHOkDUmHupuIwU8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7856
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIE5henphcmVubyBU
cmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+IFNlbnQ6IDIwMjPlubQy
5pyIMjfml6UgMTk6MjINCj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4g
Q2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IEZhYmlvIEVzdGV2YW0NCj4gPGZl
c3RldmFtQGdtYWlsLmNvbT47IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0K
PiBsaW51eC1hcm0ta2VybmVsIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+
Ow0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25A
bGluYXJvLm9yZz4NCj4gU3ViamVjdDogUmU6IE5YUCBpbXg2dWxsIG5vbmFsaWdubWVudCBidWZm
ZXIgcXVlc3Rpb24NCj4gDQo+IEhpIEJvdWdoDQo+IA0KPiBPbiBGcmksIEphbiAxMywgMjAyMyBh
dCA4OjE54oCvQU0gTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpDQo+IDxtaWNoYWVsQGFtYXJ1
bGFzb2x1dGlvbnMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpDQo+ID4NCj4gPiBPbiBGcmksIEph
biAxMywgMjAyMyBhdCA0OjMwIEFNIEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4gd3Jv
dGU6DQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBG
cm9tOiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9u
cy5jb20+DQo+ID4gPiA+IFNlbnQ6IDIwMjPlubQx5pyIOeaXpSAyMTowMg0KPiA+ID4gPiBUbzog
Qm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgU2hhd24gR3VvDQo+ID4gPiA+IDxzaGF3
bmd1b0BrZXJuZWwub3JnPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgTEtN
TA0KPiA+ID4gPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gPiA+ID4gQ2M6IGxp
bnV4LWFybS1rZXJuZWwgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47DQo+
ID4gPiA+IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IFVsZiBIYW5zc29uIDx1bGYuaGFuc3Nv
bkBsaW5hcm8ub3JnPg0KPiA+ID4gPiBTdWJqZWN0OiBOWFAgaW14NnVsbCBub25hbGlnbm1lbnQg
YnVmZmVyIHF1ZXN0aW9uDQo+ID4gPiA+DQo+ID4gPiA+IEhpIEhhaWJvDQo+ID4gPiA+DQo+ID4g
PiA+IFdvcmtpbmcgb24gaW14NnVseiBkZXNpZ24gYW5kIGZvdW5kIHRoYXQgaWYgSSBzZW5kIGEg
c2RpbyBwYWNrZXQNCj4gPiA+ID4gdXNpbmcgdGhlIHNkaW9fd3JpdGVzYiB0aGUgYWRtYSBkcml2
ZXIgdHJpZXMgdG8gaGFuZGxlIGl0IHdpdGggdHdvDQo+ID4gPiA+IGRtYSBkZXNjcmlwdG9ycy4g
VGhlIGZpcnN0IG9uZSBmaWxsZWQgd2l0aCB0aGUgYnl0ZXMgdXAgdG8gMyB0bw0KPiA+ID4gPiBj
b3ZlciB0aGUgbWlzYWxpZ24gYW5kIHRoZW4gYW5vdGhlciBidWZmZXIgZGVzY3JpcHRvcg0KPiA+
ID4gPg0KPiA+ID4gPiAgIG9mZnNldCA9IChTREhDSV9BRE1BMl9BTElHTiAtIChhZGRyICYgU0RI
Q0lfQURNQTJfTUFTSykpICYNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIFNESENJ
X0FETUEyX01BU0s7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBpZiAob2Zmc2V0KSB7DQo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChkYXRhLT5mbGFncyAmIE1NQ19EQVRBX1dS
SVRFKSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVmZmVyID0g
c2RoY2lfa21hcF9hdG9taWMoc2cpOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG1lbWNweShhbGlnbiwgYnVmZmVyLCBvZmZzZXQpOw0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNkaGNpX2t1bm1hcF9hdG9taWMoYnVmZmVyKTsNCj4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAvKiB0cmFuLCB2YWxpZCAqLw0KPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBfX3NkaGNpX2FkbWFfd3JpdGVfZGVzYyhob3N0LCAmZGVzYywNCj4gPiA+ID4gYWxp
Z25fYWRkciwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgb2Zmc2V0LA0KPiA+ID4gPiBBRE1BMl9UUkFOX1ZBTElEKTsNCj4gPiA+ID4NCj4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgQlVHX09OKG9mZnNldCA+IDY1NTM2KTsNCj4g
PiA+ID4NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYWxpZ24gKz0gU0RIQ0lfQURN
QTJfQUxJR047DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGFsaWduX2FkZHIgKz0g
U0RIQ0lfQURNQTJfQUxJR047DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGFkZHIgKz0gb2Zmc2V0Ow0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBsZW4g
LT0gb2Zmc2V0Ow0KPiA+ID4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiBJ
biA0OC43LjQgRGF0YSBMZW5ndGggU2V0dGluZw0KPiA+ID4gPiBGb3IgZWl0aGVyIEFETUEgKEFE
TUExIG9yIEFETUEyKSB0cmFuc2ZlciwgdGhlIGRhdGEgaW4gdGhlIGRhdGENCj4gPiA+ID4gYnVm
ZmVyIG11c3QgYmUgd29yZCBhbGlnbmVkLCBzbyB0aGUgZGF0YSBsZW5ndGggc2V0IGluIHRoZSBk
ZXNjcmlwdG9yIG11c3QNCj4gYmUgYSBtdWx0aXBsZSBvZiA0Lg0KPiA+ID4gPiBJIGhhdmUgbm90
aWNlZCB0aGF0IHRoaXMgY29kZSBkb2VzIG5vdCB3b3JrIGFzIGV4cGVjdGVkLg0KPiA+ID4NCj4g
PiA+IEhpIE1pY2hhZWwsDQo+ID4gPg0KPiA+ID4gTXkgdW5kZXJzdGFuZGluZyBpczogZm9yIHRo
ZSBzZW50ZW5jZSAiIHRoZSBkYXRhIGluIHRoZSBkYXRhIGJ1ZmZlciBtdXN0IGJlDQo+IHdvcmQg
YWxpZ25lZCIsIHRoaXMgbWVhbnMgdGhlIHN0YXJ0IGFkZHJlc3Mgb2YgdGhlIGRhdGEgbXVzdCBi
ZSB3b3JkIGFsaWduZWQsDQo+IGJ1dCBub3QgbGltaXQgdGhlIGRhdGEgbGVuZ3RoLg0KPiA+ID4N
Cj4gPg0KPiA+IE9rLiBNeSBzcGVjaWZpYyBwcm9ibGVtIGlzIHRoYXQgdGhpcyBzZWVtcyBub3Qg
d29ya2luZyBvbiBpbXg2dWx6LCBJDQo+ID4gZm91bmQgdGhlIHByb2JsZW0gd29ya2luZyBvbiBh
IHdpZmkgY2hpcHNldCwgaWYgdGhlIHJlcXVlc3QgZ2V0cyBzcGxpdA0KPiA+IGZvciBuby1hbGln
bm1lbnQgb2YgdGhlIGRhdGEgaW4gdHdvIGRtYSBkZXNjcmlwdG9ycywgdGhlIGNoaXBzZXQgZG9l
cw0KPiA+IG5vdCByZXBseSB0byBtZS4NCj4gPiBBbnl3YXksIEkgd2lsbCByZXRlc3QgaXQgd2l0
aCB0aGUgdXBzdHJlYW0ga2VybmVsIGFnYWluLiBJIHdpbGwgY2hlY2sNCj4gPiBiZXR0ZXIgYW5k
IEkgd2lsbCBmb2xsb3cgdXAgaWYgYW55IG1vcmUgcXVlc3Rpb24NCj4gPg0KPiANCj4gSSBoYXZl
IGRvbmUgc29tZSB0ZXN0cyBhbmQgSSBuZWVkIHRoaXMgcXVpcmsgU0RIQ0lfUVVJUktfMzJCSVRf
QURNQV9TSVpFDQo+IG9uIGlteDZ1bHogY3B1IGFuZCBJIHRoaW5rIHRoYXQgaXQgYXBwbGllcyBl
dmVuIG9uIGlteDZ1bGwuDQo+IFdpZmkgY2FuIHdvcmsgb25seSBpZiB0aGUgZGF0YSBvbiB0aGUg
c2RpbyBhcmUgYWxpZ25lZCBvciB3ZSB1c2UgaW50ZXJydXB0IG1vZGUNCj4gZm9yIG5vLWFsaWdu
bWVudCBkYXRhLiBJIGRpZCBub3QgZmluZCBhbiBlcnJhdGEgYW5kIEkgY2FuIG5vdCBhZGQgYXMg
YSBxdWlyaw0KPiB3aXRob3V0IGEgY29uZmlybWF0aW9uDQo+IA0KDQpIaSBNaWNoYWVsLA0KDQpJ
ZiB1c2UgdGhlIHF1aXJrIFNESENJX1FVSVJLXzMyQklUX0FETUFfU0laRSwgZm9yIHRoZSBsZW5n
dGggbm8tYWxpZ25tZW50IGRhdGEsIGl0IHdpbGwNCmNoYW5nZSB0byB1c2UgUElPIG1vZGUuDQoN
CkhlcmUsIGNhbiB5b3UgZ2l2ZSBzb21lIG1vcmUgZGV0YWlscyBhYm91dCB0aGlzIGlzc3VlPyBX
aGVuIHRoZSBkbWEgZGVzY3JpcHRvciBjb250YWluIHRoZQ0Kbm8tYWxpZ25tZW50IGxlbmd0aCBv
ZiBkYXRhLCBpcyB0aGVyZSBhbnkgcmVnaXN0ZXIgZHVtcCBvbiB0aGUgY29uc29sZT8gT3IgbWVl
dCBhbnkgdGltZW91dD8gT3IgdGhlcmUgYW55DQpBRE1BIGxlbmd0aCBtaXNtYXRjaCBoYXBwZW4/
IA0KDQpCZXNpZGVzLCBkaWQgeW91IHRyeSBETUEgbW9kZSBpbnN0ZWFkIG9mIHRoZSBBRE1BIG1v
ZGU/IENhbiBETUEgbW9kZSB3b3JrIGZvciB5b3VyIGNhc2U/DQoNCkJlc3QgUmVnYXJkcw0KSGFp
Ym8gQ2hlbg0KDQo+IE1pY2hhZWwNCg==
