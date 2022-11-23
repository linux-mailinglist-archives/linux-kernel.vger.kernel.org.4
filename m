Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE62635F81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiKWN2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiKWN11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:27:27 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E9C562E;
        Wed, 23 Nov 2022 05:06:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYlr+pZGO09ZIZaddn2JHDUT954ayFB0QapSrBLNCMAao4Yo1IyHgtov+waFlj8sR8ww4UT+ZX5mDCrItpYFMwX4aicfTx+GG9f3+RLLHAzI01ZLenNTj76wV/wdNUJf8ftDNLvks8cymlLC0W8NNSBRtGy4zAJOmWX3GypjgGbAP6UrBQ+Qq+PCl1mrC0wk2AEBPKX/v+R7Xdi+RxJujNuyxAwl+RPBf22Mm5GQ2ZrE2IjeIxoimLUISehMYDdwiJzuzmIwOiGrWz+OAXnH3IpPWdv1Si5E/rwvczG5rP9iAsO7jC4U0xc2zXYZkr0evzlVzSAH+H1ijQJWcoZq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8pJzLog3fMgvqEtIkIx5jMFdT+VZr+ZYlO4XUr2/5o=;
 b=gjuQ9xROT4qkj4j7F5Jv+e4DbWSZy9wB7qKtdFfOjQGFfjlaio4ItzNEe2VO+57H9PEx0TZkUgd6M4/GuUj0IG7xdFgzge10k12ebJhmMBudP/A3aJ+vh/kvvgD0thkVvZDOItpPETjyb3q6V0TM22y6+GXgDECsjvhrcYkFQX7a6rc1am6e2sH6DSdeekIBnfdIsAltbX0M1tUxCj6qiFwTwwWGJr3oKPsJLpwH6VajgqlWKrDdzRm1snJE+5JiaTCCvf+ex7BWyS4Webn3NKb/87NNXdyWnbYDUbJfvA5Im8MaQ+gTO8z1OnkCYanCu/LYg6GoPD5OGcUXC3+41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8pJzLog3fMgvqEtIkIx5jMFdT+VZr+ZYlO4XUr2/5o=;
 b=WDpPFGaygFb81oigx+nn+/ID3O4VbtBksDQs7Ap2XpULdb7katwMDrxi+OScOHYrmkH8FTHsMzXJ3e8OkUnZAVDe7oMRt7zZycPSBCih5UHZRdfl6bPAggNmKv9wm0PGSvMo2oqQ9QHVcjWxB986GuKrYF7YgtRRnXBKUohrakc=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Wed, 23 Nov
 2022 13:06:17 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 13:06:17 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "jingchang.lu@freescale.com" <jingchang.lu@freescale.com>,
        "tomonori.sakita@sord.co.jp" <tomonori.sakita@sord.co.jp>,
        "atsushi.nemoto@sord.co.jp" <atsushi.nemoto@sord.co.jp>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/5] tty: serial: fsl_lpuart: clear UARTCTRL_LOOPS in
 lpuart32_shutdown()
Thread-Topic: [PATCH V2 2/5] tty: serial: fsl_lpuart: clear UARTCTRL_LOOPS in
 lpuart32_shutdown()
Thread-Index: AQHY9N0ndaYC9LLIxEmMDBrWfgwKya5MZJAAgAAD6ACAAAXfAIAAAWKAgAAH9oCAAA/YkA==
Date:   Wed, 23 Nov 2022 13:06:17 +0000
Message-ID: <AS8PR04MB840492259821902391BFF2FA920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
 <20221110081728.10172-3-sherry.sun@nxp.com>
 <1a7c9345e3c8b97adfbadffda7340871@walle.cc>
 <AS8PR04MB8404EBF13DF7A051650EE76C920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <7724b39dabc60f872e20ffb5ed21d1d6@walle.cc>
 <AS8PR04MB8404825F21A72C22C6D09B49920C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <45769b238521d4b41638406863e31ded@walle.cc>
In-Reply-To: <45769b238521d4b41638406863e31ded@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|PA4PR04MB9661:EE_
x-ms-office365-filtering-correlation-id: 5aa67f10-c8de-4c97-9cd3-08dacd538210
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U8tNRY/PxE6ZNBGsTBRPaGVCP39olEpnn0i7mx/BADEAabeiQZU7Adyx4QVzYSChEpD3TuMYkOmvahTwq5pOQioYkEw3Uen7q+nqdATOqyDRk/wO//al7nzFCpfPFpGhIeuvcPb9bg8Pyxwjdkg36PSUa1Du33himQQhJCUCg1krMVx58qc+ito4TBufDxiArDNcLmZacT1vaewszGk3iTyU5yIwfxhMyyl/7LNp2M5wyYt8meO9ckMlyN7JzH4SWmzC+oTEj1JhuW30Djrh4Iepf6BEeEqk9kYydNTZd7MsXHUXjvOXDrQ6mJRbDjhDnjpUXCKkDkGCIqlgt0rlfXO4gV3PgNjhNpb9UE3VyGH+1Sz9NGkRZv65N1HDybPDhnu/tbny542lSPED2NiCqiGnyxJBUGwhP46SqysUYJiILSepbe+b6oBQxEprp0YpcwEI0eAPqMd+MGHMb6DNdIBjbWce1ZYRaM0ffQhZhxRTVla83W/55RECqrPl8AABqAqyDz/kEyFsh9sY6EUIhjVCE0CSvysYcLJ+mJbtelYOPAfxJh5Ijx31ga9j4+2FlwMU90N2v9gWHTmyI6a4Y3/ns7h122qQeKnuyOBBaZQcwZcAVrNcDeMXbZ9dNsPr3I/BV+Z2FVGaDF2Nqjqw+QDd+qQA38w9QHiFjKV2O+2aF+ozSgwxmmpEhYUlYtf/UAZm8b0eqfGKLhYa34g8fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(38100700002)(86362001)(66556008)(66446008)(41300700001)(64756008)(66476007)(122000001)(66946007)(4326008)(76116006)(54906003)(6916009)(26005)(8676002)(9686003)(316002)(55016003)(2906002)(83380400001)(52536014)(4001150100001)(8936002)(186003)(44832011)(33656002)(5660300002)(38070700005)(71200400001)(6506007)(7696005)(478600001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2xldnh0TThTQzRmR2lZNHNoTGcrWFhKYWZ4SllOS1Y1NkxxWUt6TmhqVStP?=
 =?utf-8?B?anBnSlJoVlZKOGJlVmhFM2F6TkZ6OU1wOUh3cUhhNWxmYUNVZkZSZVJLNU9k?=
 =?utf-8?B?T0dpMEtnQzM5bktwM0V2Ny84aUZwMjNISjlvTFU3QXlhVS9yRk9ZaWhQWlgz?=
 =?utf-8?B?K3JhMnlQaWdwVjdiT2MvMExYRm5TOU9sSWhKTWZoV1hKNGpXeFdtY09nNCtD?=
 =?utf-8?B?QndaY1I4ZTQxdzlqemcxQTZ0MnZPT21tSGllOWtSOVJFYmQ4UHg0Ky9EdXV1?=
 =?utf-8?B?bFcvNnJjRHlUVjRiU3liR1N5cHNIOG1DeDM3cVFvcTh2UnRhWlBhYUF3Tlc3?=
 =?utf-8?B?NGxWbmd2cTJKanUxTWRncDVhY2t4czc3TlZQSjZ4QkpkZThiUVRiS0JUQ3Nv?=
 =?utf-8?B?Z1BxbXhWeXZMMUg5SHF4b25sNkdwem41MkxMdEFsRDZObUVXT3ViRXh4aitB?=
 =?utf-8?B?ZGpQM29Mc29RQ29PYkxyRUlZK3lUY3d4cGMvRkh0SEpEYVFXYlBkR3FyN3d2?=
 =?utf-8?B?ajBERlhzeXN2OXpSMytEOWJJdHZuWDB6eUE3MUZzV1hhd3RDZUJIV0xLbGc2?=
 =?utf-8?B?V1B3dVVudGxLV2FTKzlGTjZ6VW1OWHJWWS9za0t3RHBpOHpyRnVPMlEyZUxa?=
 =?utf-8?B?ZnhYaUsxR2prQ1ZoekJQN1VMOUhMQnN0aTNzNVpiclppM2lMYUlvMmpLckt3?=
 =?utf-8?B?ZitacFhPQWxFQTNwVnNJdWFPTGtFZUpheW42bkZpSkFPdFdJRFhjYkNBVG1r?=
 =?utf-8?B?a2ovdVl2L3pzSlR5SFJmVyt3SlNKUWp3bXpmZC80NktEMGRoRkNJaVBmOCtF?=
 =?utf-8?B?Qk9JQmNVZ0tsM0NzUll5R1Zqcmoxai81bHAzWEduT01Ybm9iRVp4RUxYWm9I?=
 =?utf-8?B?WlhQMXlFT0krdWRCaGxmVUovKzlIaG9SdXN4VTlSRkI2UE1LRVRnZG9oVkdY?=
 =?utf-8?B?MWFBcWI2cHBPZStGdlRudGdtTlgxbzh3R3V0aXoyRkJBRTUyRUs4bmIxZFBU?=
 =?utf-8?B?NEJXWWdBRUtNRzdaSm5najhnMExsbHV0TDkwdXFUWkxqclAwVkUxZU16NzV4?=
 =?utf-8?B?ZjF4L01rWlF1Z0taekp1VTFJWjNkOGQvbGxOdWxVR1AyYjRHWUh6N2hjb21N?=
 =?utf-8?B?VzdrZmFqV0RQYWxqMkU4UzhvR2VsWUl4N09wR2ZZYnFjSmQ5T1MrTW40Q2Mv?=
 =?utf-8?B?d2VXSXJVSUY3NlBSUEtlWWtIK2xudFF0eWJLM3NPUmx2RWw0UlUrN1ZUYnBo?=
 =?utf-8?B?TVFSR2pWN2xlSlNmUEtHSjJXeTFjN3BvemwyOWoyMi9mYkRvdm1UTUIyU2FD?=
 =?utf-8?B?TmQ2LzhZV0lGRGVMeXFWVlhCVmNBdHpYblNlL3JKcXFaNkdRak1ldFZaRFNh?=
 =?utf-8?B?RGxrY2xEMDVwNzh0b1lZTUsvQithLzF5bUt2Z0EzbUVKR1VXaHJ6R01JUWZR?=
 =?utf-8?B?Ny9PQnZHaWZPMEpxcFluRS9sTFhqc0R2cXJsVTVrdmU3cytqcUI5TUgvVWlD?=
 =?utf-8?B?cWtzZDVYUGZCaGYyS1M3SnRyeFdBZytRSUkxUnZKQkY0Z200STYvWlZBTEc2?=
 =?utf-8?B?clU5SHErK3VTOWVTWUhhTnFER3ArQ2ZBMFo1TlRzOCtOUjJ3NVdUM29xMEhY?=
 =?utf-8?B?UUZBbHRDZ05xSFJQVVRKOWU5QkZ3RzRpdkhlakxVcldsRFdVS2RMbUk1Wkxl?=
 =?utf-8?B?VWgySzYrWExmZFhlRUVCVy9aaFYxVnJBNGMzSU5TYjhlOTBtQmpVZ3JySXdS?=
 =?utf-8?B?cTNQUUlobDV0RHFVS216NWZhRitKeFZXUzJHejlNeTd6VFUyZkVjMWRnWndE?=
 =?utf-8?B?b0dtanEvTTUzMisxWmQrazdENUl4dzRCMjYrUTRQSisveHpqV2M4NFZsRUFB?=
 =?utf-8?B?RE1QRGxWRnU5NHpzVytVdFBKem1HMWE5aHhoSC9QaWhMSjFZSmxBKzF3N1Jr?=
 =?utf-8?B?Rzl6OUw4L2RtMmxmNnpmR29zYXZoZXIxS0hIQ2VJQUIzNktKVnJMTkpONDFO?=
 =?utf-8?B?OWVzb0RjeWw5cSs1SUNVK3pYMEFhQXV4UkVTTmFBQUozTmY4dDVNaWEwM2Jq?=
 =?utf-8?B?WlRDTSsxL09PMlNlUzJJZzlyVzFLUU9zK2lod0lYNzFtMGFJM1pkMEdFdFdW?=
 =?utf-8?Q?dteOjSCGcDEiwL65RT3JJj2Fk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa67f10-c8de-4c97-9cd3-08dacd538210
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 13:06:17.4140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6iOGMtH3kHvuip2Q8usGwLVngKimAWgCzpJzRejNTgaeTP018YkXIWfBBheFUd+65UDmbbTUzydkHmH+ejbhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBXYWxsZSA8
bWljaGFlbEB3YWxsZS5jYz4NCj4gU2VudDogMjAyMuW5tDEx5pyIMjPml6UgMTk6NDMNCj4gVG86
IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOyBqaXJpc2xhYnlAa2VybmVsLm9yZzsNCj4gamluZ2NoYW5nLmx1QGZyZWVzY2Fs
ZS5jb207IHRvbW9ub3JpLnNha2l0YUBzb3JkLmNvLmpwOw0KPiBhdHN1c2hpLm5lbW90b0Bzb3Jk
LmNvLmpwOyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBWMiAyLzVdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBjbGVhciBVQVJU
Q1RSTF9MT09QUyBpbg0KPiBscHVhcnQzMl9zaHV0ZG93bigpDQo+IA0KPiBIaSBTaGVycnksDQo+
IA0KPiBBbSAyMDIyLTExLTIzIDEyOjMwLCBzY2hyaWViIFNoZXJyeSBTdW46DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxA
d2FsbGUuY2M+DQo+ID4+IFNlbnQ6IDIwMjLlubQxMeaciDIz5pelIDE5OjA5DQo+ID4+IFRvOiBT
aGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4+IENjOiBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZzsgamlyaXNsYWJ5QGtlcm5lbC5vcmc7DQo+ID4+IGppbmdjaGFuZy5sdUBmcmVl
c2NhbGUuY29tOyB0b21vbm9yaS5zYWtpdGFAc29yZC5jby5qcDsNCj4gPj4gYXRzdXNoaS5uZW1v
dG9Ac29yZC5jby5qcDsgbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+
DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi81XSB0dHk6IHNlcmlhbDogZnNsX2xwdWFy
dDogY2xlYXINCj4gPj4gVUFSVENUUkxfTE9PUFMgaW4NCj4gPj4gbHB1YXJ0MzJfc2h1dGRvd24o
KQ0KPiA+Pg0KPiA+PiBBbSAyMDIyLTExLTIzIDExOjU4LCBzY2hyaWViIFNoZXJyeSBTdW46DQo+
ID4+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+ID4+IEZyb206IE1pY2hhZWwg
V2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+ID4+ID4+IFNlbnQ6IDIwMjLlubQxMeaciDIz5pel
IDE4OjM0DQo+ID4+ID4+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4+
ID4+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgamlyaXNsYWJ5QGtlcm5lbC5vcmc7
DQo+ID4+ID4+IGppbmdjaGFuZy5sdUBmcmVlc2NhbGUuY29tOyB0b21vbm9yaS5zYWtpdGFAc29y
ZC5jby5qcDsNCj4gPj4gPj4gYXRzdXNoaS5uZW1vdG9Ac29yZC5jby5qcDsgbGludXgtc2VyaWFs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4+ID4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggVjIgMi81XSB0dHk6IHNlcmlhbDogZnNsX2xwdWFydDogY2xlYXINCj4gPj4gPj4gVUFS
VENUUkxfTE9PUFMgaW4NCj4gPj4gPj4gbHB1YXJ0MzJfc2h1dGRvd24oKQ0KPiA+PiA+Pg0KPiA+
PiA+PiBBbSAyMDIyLTExLTEwIDA5OjE3LCBzY2hyaWViIFNoZXJyeSBTdW46DQo+ID4+ID4+ID4g
VUFSVENUUkxfTE9PUFMgYml0IGlzIHNldCBpbiBscHVhcnQzMl9zZXRfbWN0cmwoKSBmb3IgbG9v
cGJhY2sNCj4gPj4gPj4gPiBtb2RlLCBidXQgbm93aGVyZSBjbGVhciB0aGlzIGJpdCwgaXQgc2hv
dWxkIGJlIGNsZWFyZWQgd2hlbg0KPiA+PiA+PiA+IGNsb3NpbmcgdGhlIHVhcnQgcG9ydCB0byBh
dm9pZCB0aGUgbG9vcGJhY2sgbW9kZSBiZWVuIGVuYWJsZWQgYnkNCj4gPj4gPj4gPiBkZWZhdWx0
IHdoZW4gcmVvcGVuaW5nIHRoZSB1YXJ0Lg0KPiA+PiA+Pg0KPiA+PiA+PiBJdCdzIGNsZWFyZWQg
aW4gc2V0X21jdHJsKCkuIFdoYXQgaXMgdGhlIGV4cGVjdGF0aW9uIGZyb20gdGhlDQo+ID4+ID4+
IHNlcmlhbCBjb3JlIGhlcmU/DQo+ID4+ID4+DQo+ID4+ID4NCj4gPj4gPiBIaSBNaWNoYWVsLA0K
PiA+PiA+DQo+ID4+ID4gSWYgd2UgY2FsbCAuc2V0X21jdHJsKFRJT0NNX0xPT1ApLCB0aGUgVUFS
VENUUkxfTE9PUFMgd2lsbCBiZSBzZXQuDQo+ID4+ID4gVGhlbiB3aGVuIHdlIGNhbGwgLnNodXRk
b3duKCksIHNlcmlhbCBjb3JlIHdvbid0IGNhbGwgLnNldF9tY3RybCgpDQo+ID4+ID4gdG8gY2xl
YXIgaXQsIHNvIHRoZSBVQVJUQ1RSTF9MT09QUyBuZWVkIHRvIGJlIGNsZWFyZWQgaGVyZS4NCj4g
Pj4gPiBQZXIgbXkgdW5kZXJzdGFuZGluZywgLnNodXRkb3duKCkgc2hvdWxkIGNsZWFuIHVwIGFs
bCB0aGUgdWFydA0KPiA+PiA+IGZsYWdzLCBhcyB0aGUgdHJhbnNtaXR0ZXIgYW5kIHJlY2VpdmVy
IHdpbGwgYmVlbiBkaXNhYmxlZCwgd2Ugd2lsbA0KPiA+PiA+IHJlLWNvbmZpZ3VyZSBhbGwgdGhl
IHNldHRpbmdzIG5lZWRlZCB3aGVuIHJlLW9wZW4gdGhlIHBvcnQuDQo+ID4+DQo+ID4+IFR3byB0
aGluZ3MsDQo+ID4+ICgxKSBzaG91bGQgdGhlIGxvb3BiYWNrIGJlIGNsZWFyZWQgb24gYSBuZXds
eSBvcGVuZWQgc2VyaWFsIGRldmljZT8NCj4gPj4gKDIpIGFzIG1lbnRpb25lZCBpbiBteSBvdGhl
ciByZXBseSwgdGhpcyBjYW4gYWxzbyBiZSBoYW5kbGVkIGluDQo+ID4+ICAgICAgdGhlIHN0YXJ0
dXAuIEVnLiB0aGUgc3RhcnR1cCBjYW4gY2xlYXIgdGhlIGxvb3BiYWNrIGZsYWcuDQo+ID4+ICAg
ICAgKHRvZ2V0aGVyIHdpdGggcG9zc2libGUgaGFyZHdhcmUgZXZlbnRzKS4NCj4gPj4NCj4gPj4g
SSdtIG5vdCB0aGF0IGRlZXAgaW50byB0aGUgc2VyaWFsIGNvcmUsIHRodXMgbXkgcXVlc3Rpb24g
YWJvdXQgdGhlDQo+ID4+IGV4cGVjdGF0aW9ucyBmcm9tIHRoZSBzZXJpYWwgY29yZS4gSSBndWVz
cyB0aGUgYW5zd2VyIHRvDQo+ID4+ICgxKSBpcyB5ZXMsIGJ1dCBiZXR0ZXIgdG8gYXNrLg0KPiA+
Pg0KPiA+DQo+ID4gSGkgTWljaGFlbCwNCj4gPg0KPiA+IEZvciB0aGUgKDEpLCBJIGhhdmUgY2hl
Y2tlZCB0aGUgc2VyaWFsIGNvcmUsIHNlZW1zIHRoZSBhbnN3ZXIgaXMgbm8sIC4NCj4gPiBzdGFy
dHVwKCkgd29uJ3QgY2xlYW4gdGhlIHN0YXR1cywgb25seSB3aGVuIHRoZSB1YXJ0IGRldmljZSBp
cyBwcm9iZWQsDQo+ID4gbHB1YXJ0IHdpbGwgZG8gdGhlIGdsb2JhbCByZXNldCB0byBhbGwgdGhl
IHJlZ2lzdGVycyBpbnN0ZWFkIG9mDQo+ID4gLnN0YXJ0dXAoKS4gU28gSSB0aGluayB0aGUgdWFy
dCBydW5uaW5nIHN0YXR1cyBjbGVhcmVkIGluIC5zaHV0ZG93bigpDQo+ID4gaXMgcmVhc29uYWJs
ZS4NCj4gDQo+IFRoYXQncyBub3Qgd2hhdCBJJ3ZlIG1lYW50LiBFdmVuIHdpdGggdGhpcyBwYXRj
aCBhcyBpdCBpcyByaWdodCBub3csIHRoZQ0KPiBsb29wYmFjayBmbGFnIGlzIGNsZWFyZWQgb24g
YSAibmV3bHkgb3BlbmVkIHNlcmlhbCBkZXZpY2UiLiBKdXN0IHdpdGggb25lDQo+IGRpZmZlcmVu
Y2UsIHlvdSBhcmUgY2xlYXJpbmcgdGhlIGZsYWcgaW4gc2h1dGRvd24uDQo+IA0KPiBNeSBxdWVz
dGlvbiB3YXMgcmF0aGVyLCBzaG91bGQgdGhlIGxvb3BiYWNrIChvciBnZW5lcmFsbHkgYW55IG1j
dHJsDQo+IGZsYWdzKQ0KPiBiZSBwZXJzaXN0ZW50IGFjcm9zcyBjbG9zZS9vcGVuIGN5Y2xlcy4g
RS5nLiBsb29raW5nIGF0IG9tYXAtc2VyaWFsLmMsIHRoaXMNCj4gZHJpdmVyIGRvZXNuJ3Qgc2Vl
bSB0byBoYW5kbGUgdGhlIGxvb3BiYWNrIGZsYWcgYXQgLnN0YXJ0dXAoKSBvciAuc2h1dGRvd24o
KS4NCj4gU2FtZSBzZWVtcyB0byBiZSB0cnVlIGZvciBzaC1zY2kuYy4NCj4gDQo+IEdyZWc/DQo+
IA0KDQpIaSBNaWNoYWVsLA0KDQpOb3cgZ290IHlvdXIgcG9pbnQsIHRoYW5rcyBmb3IgdGhlIGNs
YXJpZmljYXRpb24uDQpJIGhhdmUgY2hlY2tlZCBzb21lIG90aGVyIGRyaXZlcnMsIG1heWJlIHlv
dSBhcmUgcmlnaHQsIG5vdyBJIGFtIGFsc28gY29uZnVzZWQgdGhhdCBpZiB0aGUgbG9vcGJhY2sg
ZmxhZ3Mgc2hvdWxkIGJlIHBlcnNpc3RlbnQgYWNyb3NzIGNsb3NlL29wZW4gY3ljbGVzLiDimLkN
Cg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
