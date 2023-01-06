Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775D566015A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjAFNfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjAFNf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:35:26 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EA34167D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 05:35:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdFsQnXSUq6Xhz4zFIxijwGwt1oPNxYuX/ZiugTwZKkjC2vlAI8KErT1rGCKAJE3nSjC4B2MIaJw5GRiLPDHMohNA+++7vf9Z3YxYX4AvqjkLI67cXJlWXZewqIhSgRObE68uZ3zubVdiqFcF3/lf3CY6eJUKZrpwztRHFTat3Tt0Nsva7oV/zoqQkZ9F2DnbED75p8OtzreFKyNZNSUiaX3hFqpI1va/6UBVj8oS5NLiAlXtbpcwUTg3VbtFdc1YaJhFS/T/5DsPg3d6DvFAkYIaE4t2UnbshlKbnHGKWZabl6jQN3TnXZctpF/1qdn9lfMAwlBhjX6hgA1tiX3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ06n6S3S1OSzx9nVhDorBLGydN2h/lCSxkBje1btk4=;
 b=gU1UpZa9two7msHI6vqeSlxsn0bpLxc15T8udKqj3eUI4e+1vsiE3R030++hJ1Hnw4IsV7NXzzJ3mJNDtPg8XP/YlTuiJGtvNrLzZDMc1948MNS+dE5KQyeDAPJ6MfvrhrEel6A6kTuU7v7KDPECpy2pm8HIQl0caU9ao0S5RbTaQWvek1S9xCz621g9S2+P/RxW50wLz1SnjWPDrmM+W2d/isGtZ49gYX7gMQ3bCUTTVe/2H+fEYQDO2Fgf2HRF5KFdEpMIYZH9CKZ4YBgmFWMk7eEsIlXfjfNQ6WzpNPb2HiyIfEu6ARkpPqtdB9PX+m7Ux2EonjQHbn+yeNKRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ06n6S3S1OSzx9nVhDorBLGydN2h/lCSxkBje1btk4=;
 b=JEcmdzqTl4RKlYLVe8S1euQ+64F429K/fDOcNxW88lluusSzG4/zd0njpgq/KqEvKLBUUGz1S7y32mblAuFcevL9KCnC6WxyFS57+Jq2He97AyBoT1t2lYnsrDAnV1v98b59kbIquy96mHJHPEfFu6/AmdK2toMymp2vXDyIgwE=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by AM9PR04MB8796.eurprd04.prod.outlook.com (2603:10a6:20b:40b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 13:35:23 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::2b62:f63c:797a:b7b9]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::2b62:f63c:797a:b7b9%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 13:35:23 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RE: commit 3497b9a5 (usb: dwc3: add power down scale setting) breaks
 imx8mp
Thread-Topic: commit 3497b9a5 (usb: dwc3: add power down scale setting) breaks
 imx8mp
Thread-Index: AQHZIcWuDozc4KZTnECWNUU6okT12q6RYU8w
Date:   Fri, 6 Jan 2023 13:35:23 +0000
Message-ID: <PA4PR04MB9640E88C1F4EF722682608D689FB9@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <5ae757aa-5b0e-be81-e87c-134e2ba5205d@prevas.dk>
In-Reply-To: <5ae757aa-5b0e-be81-e87c-134e2ba5205d@prevas.dk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|AM9PR04MB8796:EE_
x-ms-office365-filtering-correlation-id: b0c640d5-8877-4758-d465-08daefeadce3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCQopCMAiQUPEtw4Pw6k71hSbt/15dig6tqU2cqelfWAVI7u8hk/kUEzQwI/68xyIaEzfHF88vz4Hm1iNZU06f4BFkJgrfAa07nkEU5t+S4QR1tDqbOTrLEgJiNl2R2+Y8tzf4lltA011Jo87mdGERlIpKq3foIkqI8lNpv92GZo4h2Mk5ZOZV6fQbOmoA0gkSBXH1Cu4ITgsgaPoOb1jaoWH8BnVIZv8h23OSBA4W5ubr8U7tZiVmwOaaz8hXpj7QQUeCWp5alyaMaD1dhtVD7q6/ZD8usF93UTz2WR/msS1oX9HAT34HIA0obgriteo8rUd6SrzHzQGPz4to7MT4gShBZOuwJM7e6phrlJOF71UNmzirH/HjfUz+AukvjYLR8REee04jmh7YX1nlPVwBaP6dm7qrCq0iBdSrkZw0Rb+50unhxsVqdlTdCdeahjcAZrZiEo4I0sz8sdaEw9VYL1lCMkcj+ziA7r1T2uXBUX/W6RTgealJnGLO3KzIPy/aGw2rq/iyOYIEy3E4abUJledcn/OLF+SATP8K0Yv9qZsouuudOTXCHa5mRaYvRymR2Jw9khPqwRkGC4mSW3or4cb83i1IXIlEiGURwYsuXki7v8RWI3o90QJkYXJUJ+LTTRDuwsqMIQ9pKtJ2+xwfs+Vq+xIcfWHL9t2UEyVPr5wuzIj1AesVIeUnqa5teAeYZc/WWHXeTQKik5StAkXFAFr+qPfJh5e+/4+4b20hNUamK6+8xBblrZqZX+HXbyrcGl5/qwr47ilp+FLjY87p3W8HDDjFF214DyIKrNq4w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(53546011)(55016003)(186003)(9686003)(26005)(6506007)(33656002)(7696005)(38070700005)(86362001)(38100700002)(122000001)(83380400001)(52536014)(4326008)(66446008)(41300700001)(8676002)(2906002)(5660300002)(8936002)(44832011)(71200400001)(110136005)(66476007)(64756008)(66556008)(966005)(76116006)(66946007)(316002)(478600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3RKMU1CZ1o3M0Z2ak1BN3grQXltU05NNERPUlpNcnAreGI0Z2ROT0Y0TVFL?=
 =?utf-8?B?Umt1NGJTMFZJaHh0MW1jQmNoWkJBeVlRV3ZjU0JNTVFKSlJwWTVkVUxzS055?=
 =?utf-8?B?ajdnUUljbE1HTEdFS2F5Y0lubkllMnFuMUVUWEhoazlycU9SYjVJWVZOVnR0?=
 =?utf-8?B?Q2pmTnQzTHBEeUNoeW9JK1BvenFDZ054aTNla3RGV2QrTGhqakFESHZlOVhq?=
 =?utf-8?B?V2JxWm5pYm02UGh3c0Q1RnZXWFc4M3ZIZ1FsTU5qdWZzWUlHQ0NWY1dDUjBj?=
 =?utf-8?B?bmZMaTc0dE9CeUF0aFRsZGRkdU8zdVgvL2dqd0ViZTBNa3dqcnEwTTFmcEFw?=
 =?utf-8?B?QUl3VjVPS1BKb0lMUitCWjJlSFZPUFU4UU1qQ0l1T1Nhc3B1dUpDK0tWSXZi?=
 =?utf-8?B?OGoxd0tWNVNvVEEyWmh6OXFZNTZGQ29CU3NhLzQ3c0tCbGdMNTRYQVltdTB3?=
 =?utf-8?B?SnpRWXc4a0xvZTNlUCtjaEJIWFJsTFQ5RDg3d1dlbFlXdkhmRW5HV2lzaEdG?=
 =?utf-8?B?MUQyTXE3amZoWitxcTh0NEFXU3N1T09KL2tJd29IdmJKRmVpSElwd3EwUjd2?=
 =?utf-8?B?ZTFjMU90L1R2TlJ1dmxHV0hzOVVDMXVZSC9Iam1nMkoxL3FkTlg0TmtGZEp1?=
 =?utf-8?B?SW5pU0pON2I3cm9CZnVzak1jRDR0ZDBGdXc0Sktvam42aHVNcG96ZjdDOTY1?=
 =?utf-8?B?U0RaZldhZjB2V3pEUWFGbjhvTEkvS2lWWWQzUGRJNEh5VlJuNnBPQ0toeWNK?=
 =?utf-8?B?MktRSDA3UzJRZGxxbTdFc3BxcVZRaGRYYVRTSE9qNVBSMXBMWTQvM3MwcVNG?=
 =?utf-8?B?NExZSUlRQ2tVM3RWRDh4MHdoRi81NWowUVArREw5YnljZnMxWUJPVDNMNXVO?=
 =?utf-8?B?ZHRUSE5zVXlNeXBRZHEyZ0RydEpzWDZTTzdaMEZleEtPR1BvRXQ0OTJ0UHh2?=
 =?utf-8?B?WXhodk1xbUFQUW5rQUNBNEdNRHRpZDN2T0ZMOFdFbXhTdWdISjRDU0psZUlO?=
 =?utf-8?B?eG9nSEk5Unl1Q3crdVl1UFZVRFNpWHRmVkZsMjR5UDJka205N1BjVHJtYkNx?=
 =?utf-8?B?dU5HY0JreUtnUFBMK1c1Wlp2akMvN0IrZk5ZMjBzNkRYQjVJWk1XeFRGTE9J?=
 =?utf-8?B?VFV5NFA3U29uMEFtU0NYeG9MWldSYWRWZlBFeUt4WHQwckN6VmpTaUJyKzcx?=
 =?utf-8?B?ajIxVTB3WFRWdSswU2NDUzFZTExFVWU5bWFGYWJkRzFMcGdjcmdBQjJCa2dj?=
 =?utf-8?B?b1E5S3ZmRk1DYTZoSDBWc0xGdnhMeFU5KzNrZVlDbHR3VFVTS3pKV1Nzb054?=
 =?utf-8?B?YkZIdnRRTXYxSUhoODIrbmVVWEsrK2E1bWtaV1hLL0hLVktUMzRhSnV2bEUy?=
 =?utf-8?B?OWhYR1plOEl6SnNuYzdsa0w3dXpQQWtrbmcyWmVOcUNJS1BWY3R1RVgwODZk?=
 =?utf-8?B?MVhRV1AvNU5YU040Qk9TT2x1b3JXUW4xWXBvTXMvQi9zTVBia1FWWWxQSG40?=
 =?utf-8?B?V1BpQW9EQmlWOEN3MG13Y1VtZHZ2cWZRS1J6REo1bzc3d09RbnN0akU5RVZu?=
 =?utf-8?B?UFkxZTVvK3lyMFRzWm4vclJLdkY5YjVEYVlja2JENjdtWXpZazBoVWVzNG5I?=
 =?utf-8?B?Nk5HTzJCc2daZ1pHOFNNMk5Ea2tvZTYyTTk3alZtN0JDMlZJYk5BaXBRdWUv?=
 =?utf-8?B?bm9RUll2RktoeXoraGRtNHNnVFNmRGJOSkQzNFNLZmtnb2taSEE0SzJ3MGpE?=
 =?utf-8?B?dTVQZ1FHemVNaVF2b2ZTUlh5YWx1alhuYmgxaGZNVlQxZWRHS2MwQVdQZE5Y?=
 =?utf-8?B?bXVZTDZjRkdqZEpZQzB0NmQyK3NBTXdFQ05SUmNIT0htbG4rb1UwTXExd085?=
 =?utf-8?B?dU9tOWlZLzRvYmg2T1lhVkI1Nzl6NXFtQUtLNGIvU3o1VlB4WjZYM2IzTVgw?=
 =?utf-8?B?TUFxMThnRlMvaldndDE4TUM4YUEvTERxZnNnM05vams5aXdvNmJSVlBZZDdt?=
 =?utf-8?B?V1gxMCtiMDB6TEdQaFVzbFBhRFJ6b28wMHRJVjlhVldHQlJUSmtJM05lNUdk?=
 =?utf-8?B?eEM2RnA1QUdVVzdmM1IrTm5Ka0dPRElsNFVHTngyTDRESzVWWmZIWERFZE90?=
 =?utf-8?Q?GIwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c640d5-8877-4758-d465-08daefeadce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 13:35:23.3025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4K6WHzY4TWbPbGwJn1JdSm0Deq9Jo/DnZNRr1Aow+eU8iOrODTzgq00yVNPo0VbQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFzbXVzIFZpbGxlbW9l
cyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2YXMuZGs+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSA2
LCAyMDIzIDc6NTUgUE0NCj4gVG86IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc+OyBKdW4gTGkNCj4gPGp1bi5saUBueHAuY29tPg0KPiBDYzogTEtNTCA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogY29tbWl0IDM0OTdiOWE1ICh1
c2I6IGR3YzM6IGFkZCBwb3dlciBkb3duIHNjYWxlIHNldHRpbmcpIGJyZWFrcw0KPiBpbXg4bXAN
Cj4gDQo+IFdlIGhhdmUgYW4gaW14OG1wIGJvYXJkIHdpdGggYSBsYW43ODAxIHVzYiBldGhlcm5l
dCBjaGlwIGhhcmR3aXJlZCBvbiB0aGUNCj4gUENCLCB3aGljaCBpcyB1c2VkIGFzIHRoZSBob3N0
IHBvcnQgZm9yIGEgTWljcm9jaGlwIEtTWjk1Njcgc3dpdGNoLg0KPiANCj4gV2hpbGUgdHJ5aW5n
IHRvIHVwZGF0ZSB0aGUga2VybmVsIHRvIDYuMS55LCBJIGZvdW5kIHNvbWV0aGluZyBxdWl0ZQ0K
PiB3ZWlyZDogV2hlbiB0aGUgc3dpdGNoIHdhcyBiZWluZyBwcm9iZWQgZm9yIHRoZSBzZWNvbmQg
dGltZSAodGhlIGZpcnN0IGVuZHMNCj4gd2l0aCBhIHN0YW5kYXJkIC1FUFJPQkVfREVGRVIpLCB0
aGUgYm9hcmQgd291bGQgc3BvbnRhbmVvdXNseSByZXNldC4NCj4gDQo+IE5vdyB3aGVuIEkgZGlz
YWJsZSB0aGUgc3dpdGNoIGRyaXZlciBpbiAuY29uZmlnIGp1c3QgdG8gc2VlIGhvdyBmYXIgSSBj
b3VsZA0KPiBvdGhlcndpc2UgZ2V0LCB0aGUgbGFuNzgwMSBkZXZpY2UgZGlkbid0IGFwcGVhciB1
bnRpbCBhYm91dCA0NyBzZWNvbmRzIGFmdGVyDQo+IGJvb3QuIEJpc2VjdGluZyB1bmFtYmlndW91
c2x5IHBvaW50cyBhdCAzNDk3YjlhNSwgYW5kIGRpZ2dpbmcgaW4sIGl0J3MgcHJldHR5DQo+IG9i
dmlvdXMgd2h5IHRoYXQgaXMgYm9ndXMgYXQgbGVhc3QgZm9yIGlteDhtcC4NCj4gDQo+IFRoZSAu
ZHRzaSBmaWxlIGxpc3RzIElNWDhNUF9DTEtfVVNCX1JPT1QgYXMgdGhlICJzdXNwZW5kIiBjbGss
IGFuZA0KPiBjbGtfZ2V0X3JhdGUoKSBvZiB0aGF0IHJldHVybnMgNTAwMDAwMDAwIDsgZGl2aWRl
ZCBieSAxNjAwMCB0aGF0J3MgMzEyNTAsDQo+IHdoaWNoIGNlcnRhaW5seSBkb2Vzbid0IGZpdCBp
biB0aGUgMTMtYml0IGZpZWxkIEdDVExfUFdSRE5TQ0FMRS4NCj4gQnV0IEkgYXNzdW1lIHRoZSAu
ZHRzaSBmaWxlIGlzIHdyb25nLCBiZWNhdXNlIGlteDhtcS5kdHNpIGhhcw0KPiA3NGJkNTk1MWRk
MyAoYXJtNjQ6IGR0czogaW14OG1xOiBjb3JyZWN0IHVzYiBjb250cm9sbGVyIGNsb2NrcyksIGFu
ZCBpdCBzZWVtcw0KPiBsaWtlbHkgZnJvbSB0aGUgY29tbWl0IGxvZyBvZiAzNDk3YjlhNSB0aGF0
IGl0IHdhcyBhdCBsZWFzdCB0ZXN0ZWQgb24gaW14OG1xLg0KPiANCj4gTm93IEkgaGF2ZSBubyBp
ZGVhIGlmIHRoZSByaWdodCBjbG9jayBmb3IgaW14OG1wIGlzIGFsc28gc29tZSAzMmtIeiBjbGss
DQo+IGJ1dCBpdCB3b3VsZCBjZXJ0YWlubHkgbWFrZSBzZW5zZTsgdW5saWtlIHdoYXQgdGhlIHJl
ZmVyZW5jZSBtYW51YWwgY2xhaW1zLA0KPiBpdCBzZWVtcyB0aGF0IHRoZSByZXNldCB2YWx1ZSBv
ZiB0aGUgR0NUTCByZWdpc3RlciBpcyAweDAwMTEyMDA0LCBhbW91bnRpbmcNCj4gdG8gYSBwd3Jk
d25zY2FsZSB2YWx1ZSBvZiAweDAwMTAwMDAwPj4xOSA9PSAyID09IDMya0h6LzE2a0h6LCBhbmQg
dGhhdCBjb3VsZA0KPiBleHBsYWluIHdoeSB0aGluZ3Mgd29ya2VkIGp1c3QgZmluZSB3aXRob3V0
IDM0OTdiOWE1Lg0KPiANCj4gTGkgSnVuLCBwbGVhc2UgZWl0aGVyIHJldmVydCAzNDk3YjlhNSBv
ciBmaWd1cmUgb3V0IGlmIGlteDhtcC5kdHNpIGlzIGJyb2tlbg0KPiBhbmQgbmVlZHMgYSBmaXgg
c2ltaWxhciB0byA3NGJkNTk1MWRkMy4NCg0KaU1YOE1QIHN1c3BlbmQgY2xvY2sod2l0aCBuYW1l
IElNWDhNUF9DTEtfVVNCX1JPT1QpIHdhcyAzMksgd2hlbiAzNDk3YjlhNQ0Kd2FzIG1lcmdlZCwg
YSBsYXRlciBpTVg4TVAgY2xvY2sgZHJpdmVyIHBhdGNoIGNoYW5nZSB0aGUgY2xvY2sgdG8gYmUg
cm9vdA0KY2xvY2sgZ2F0ZShhY3R1YWxseSB0aGlzIGlzIGEgc2hhcmVkIGNsb2NrIGdhdGUgZm9y
IGJvdGggc3VzcGVuZCBhbmQgcm9vdA0KY2xvY2spLCBzbyBicmVhayB0aGUgaU1YOE1QIFVTQiBh
cyB5b3UgYXJlIHNlZWluZywgYSBmaXggcGF0Y2ggc2V0IGFscmVhZHkNCmFkZHJlc3NlZCB0aGlz
IGlzc3VlLCBwbGVhc2UgY2hlY2sgYW5kIGFwcGx5IGJlbG93IDMgcGF0Y2hlczoNCg0KaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0
LmdpdC9jb21taXQvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg4bXAtY2xvY2suaD9pZD01
YzFmN2YxMDkwOTQ3ZDQ5NGMzMDA0MjEyM2UwZWM4NDZmNjk2MzM2DQpodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L2NvbW1p
dC9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC5jP2lkPWVkMWY0Y2NmZTk0N2EzZTEwMThhM2Jk
NzMyNTEzNDU3NGM3ZmY5YjMNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0L2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcC5kdHNpP2lkPThhMWVkOThmZTBmMmU3NjY5ZjA0MDlkZTBmNDZmMzE3
YjI3NWY4YmUNCg0KTGkgSnVuIA0KPiANCj4gUmFzbXVzDQo=
