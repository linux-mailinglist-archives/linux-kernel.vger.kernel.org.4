Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4431B649AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiLLJKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiLLJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:10:42 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26957658A;
        Mon, 12 Dec 2022 01:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670836240; x=1702372240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lGCmWdoKadznD0M1lZKRdMSLnRvAnjfGN8XSOYgZZsg=;
  b=Iu4aac+PA83tFPba2VcVzEO0yJOkiLI+RucRQAWDod0Rxd6eyZ/qa8+m
   YIOAYlBDeAJa+yMhEymBIBsZmYJ1HdbN4j/r4SQxbhyk/sxxhk1q+14uU
   Jpj2asNidGsRBJyBdfMCRwJZbRYjD/TjFF6Y4uzAbgFqHlH/uqQJarhC3
   oxNS9Lwjm0t6bk1bq84BB0ciXuG6iqRnqx02qXkU22AQMAvfcFsBOmB4o
   8aNR0j8f/MyoD5hOTEfFm2aY7lcVtcs3txpFGaworoJ0vRSXaGQlLpCar
   FAycXO9VXWmwdSYRo+JwBx6iuHGBE/OmzahweECGj5FoujlXPsodAR9Fn
   A==;
X-IronPort-AV: E=Sophos;i="5.96,237,1665417600"; 
   d="scan'208";a="330521842"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 17:10:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu/ptctedHtP0uFenqrKlORWX24J8YBHuNI6KQG/JYxMoICLKPD8mGpo6ymwemdtLb3mcPav4Ijpil9TcSJcOSye2xqkhEvcIGNHvTRHM9DpvAUznko4I7yfJP+QZ4HegImXK6DcOBima8I0FhHumtbvb1Y01+NejbrqpEpez6lDV3KXlLAtcS96jeHC3lYu0/AHL1Ane0BUntW9jds9C+YBVbiIlwRzMnb4FSo7DaVypcZIsU7Bjn8RmnmdAGi5jtszQY+zDCqgmOYvc4Lcn3d0/lONjQXEXV/A0B1kVCMD5qLge/rfYnw+XtbdPdzT82RvgYXRTANLcWoCz0xSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGCmWdoKadznD0M1lZKRdMSLnRvAnjfGN8XSOYgZZsg=;
 b=jkLfWkr1Q26QGUFGGLYfy057VkJNDlYhC/5WaQYDtyLdpMaCPuN8fXEWY2DURV0JsONiOyp73hiRlqIHWePXeV4o+RN+dd3mrVrVskKUZPJkYP2MdknrhY/1G/lfsanjh46BvchGby7uqzpu00f5FuhvWZnXFK2ak41hgGfIwkYL79ayv7+sFeXZk65hOW1gkHBKyZ5RFhhvnE/+mKf9h3iL3WHVI8/fCvqH9j6TrhsBcLrzvmaeFtgsKTAEchksMnFGZdxLxGEA0/cVjjGMPAqZrjGHo0U84f8y1cfcNMu+QVeN83sCZilMkK9vsxIaJveUkrR0VqOGFSvspfvWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGCmWdoKadznD0M1lZKRdMSLnRvAnjfGN8XSOYgZZsg=;
 b=WqNJ54H4VKe/EZdKOhCVWOdVlVjDdf57WvqWWk+uJBbGZZvQK5QXR47CsRmcqzyWD5gwp1no2+8Oc9F6UTIxHyuGqcE+LVYbektNdfJ7AzyXfD70mih7av3QLA/f0Gril903YfQb1q3SXXz/7x3hbjRFOT3wMBQFnHopGAmFkt8=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by SJ0PR04MB8390.namprd04.prod.outlook.com (2603:10b6:a03:3d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 09:10:37 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::a038:ff31:3aac:992e]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::a038:ff31:3aac:992e%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 09:10:37 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length
 function
Thread-Topic: [PATCH v5 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length
 function
Thread-Index: AQHZDWFDH8aZOAp8fEOfc+9iCDwGsq5pY+aAgACTYzA=
Date:   Mon, 12 Dec 2022 09:10:37 +0000
Message-ID: <BY5PR04MB6327C72DC776F2A244F8DCD1EDE29@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1670763911-8695-5-git-send-email-Arthur.Simchaev@wdc.com>
 <71a10a4c-a726-edac-c5d3-1bfded690503@acm.org>
In-Reply-To: <71a10a4c-a726-edac-c5d3-1bfded690503@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|SJ0PR04MB8390:EE_
x-ms-office365-filtering-correlation-id: 09da253c-7d51-4933-22f8-08dadc20bbd2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uiE70EjyMBLovrm/Qh9et4clTC/LNhq1Xy5/Jh2J7feF3lpymAlP9LlC+DxV6qlEXakg7DY7UqXDdV+TMyJqps0cedAYT+sIjB49+X2r9h5pKLD5HIv5tfd6l6SpPjxllcEEPP88MHlhYwPOthsEnoiCDcjUKhhRTf15uXnVXcAzXe0FKuMKf6XLkPrTZ+LvfWPpLkad/cmZ04WS/75gu5DSKD6wFaHw9/V/bM6yHNz9crKFuvxmnem9PaWjRc2gdoJvuZbd0Gqm3V4iwsLwiwIRkc1Y8m8LuCY/ub28Z3xzB9QUV56BJNyc16MEARqyWVVXSkwRzYI4pCyuqMEvX4Y47PDB7UilGSkS89cARrsPdkkVjzkDcUXgLm6JPFqWowp/q4VDE48fjkjz9NgSBrGyWJ7p+Vd8/lWYT+BK5YjiMUqc02Xc3KgUm+CFqtjumV3sHz/Cc2CC9VEhNr+6I0JBgVm49grGBG8S287K6oCVvIPK2DtWjW/iCBxMwyIiejHI1HtkPOuIdMcKV0cnFEYlvA28ka8OvO9S4LMCe8quXbfqWLFFmKPTnnRft71kZ+axfd+NCMU34BnLF47q9vZEhBDHzBoILJ6XS8a3wKb5RH6boozVW4+O3pIxK2dvyzgV8J74gP3od2z+rLaWeh9DvkrwkbWqZtUe/c2dC7USJ/DNoNm7ddHhMfpPjCCxi8zqxSXDBU0yIxDXo5iNaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199015)(33656002)(2906002)(38070700005)(55016003)(478600001)(41300700001)(71200400001)(38100700002)(122000001)(86362001)(5660300002)(82960400001)(53546011)(316002)(110136005)(6506007)(66556008)(64756008)(54906003)(66946007)(76116006)(66476007)(66446008)(4326008)(8676002)(26005)(83380400001)(8936002)(186003)(7696005)(9686003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TitocDZ5NnNEVkszSlQvS0JxTUkwbUVra3AyNGdlNldWNVZrZzdEUTRJYjRP?=
 =?utf-8?B?cTNyZEJZM29HeThCQUFQZ3M3TE9UTzBDVGJyRFRZMW1Za1VLa1pnRWVOMm00?=
 =?utf-8?B?MlZTaTdLQmVud0VZYlVhWHc5UUp2QWFteS9tMG5VS1hQU2NZZk8wbzNFY2o0?=
 =?utf-8?B?N1JjdWd4SDN0RmdXeGRhZGhzd3ZaVDNkcXhYdkRkQ2N2V3hOeGNNNGdGY1Vs?=
 =?utf-8?B?b1phZURCREFkWVNBRTlEbFZTT1VaMlJWT1BBQmR2UmMwWkZzRWF6RU54OTNX?=
 =?utf-8?B?NDEyekVFWGdUc0NVU0Exa2hLMGRnYU44Q1pQRzBxK1hJd3pOdXpGZE5tRkN5?=
 =?utf-8?B?UU5tcjBrL1pWTlRUT3lwMmJvdjRxYzdLd3pqSXNmc0tiSEdnMUFMTHVrdHBQ?=
 =?utf-8?B?aDcxTzBCNm8wcVoycUZscTc2dkMwWnVmSko2UnRwVGY0bWNlM2l0Q2daUEE0?=
 =?utf-8?B?SlJJaTBkYkVDNkh2cnkrcUFMejVWcFplbHNVN3plU1ZrQkxySmIwMktHaEtj?=
 =?utf-8?B?dWpqQnBMNDBTTXNFTEpCL1c1eUEvTTZVZjFkRGJET1JaUXBndW5uUExXajlJ?=
 =?utf-8?B?UU1wWHVwZHhtMUtPRHU5NHptaC9McjhyRjBTcndjMHhIMWdKS0hmbXZodWhV?=
 =?utf-8?B?TmdTN0J2aWkzSFZuWHVhMlZtWGdHUU04b2FzQXUxRnBSVXJmVmhDNGJ1Z3lr?=
 =?utf-8?B?ODY5alh1Qm9GOFI3TXRUMjBpMlRrMmdRWFJCY0Q3cFhsaVVpS2xLaDB1Lzlp?=
 =?utf-8?B?Ym1oZUJuQnR0SERpK0o3c080YWxlUmRkYXZVekVEcnN3R1dDa2V5eWlDSEJP?=
 =?utf-8?B?U2crK3BjSXRIZ3dGemd1dkFpSEJ5QVNmM0hRU28xd2gvdDZTcTA2bkwyb0gz?=
 =?utf-8?B?cXJCd3FYVU9KRkpQNDlOZGxxazVlazFFM0dxd0R3dUwxNGhsREEzVVBtWSt6?=
 =?utf-8?B?bkJlWE5MUTE0NHFsLzl1Tm9GYzBMS3lGZ3FoSWwvb05MRDdXWnhMOEV4b3o4?=
 =?utf-8?B?MEZqT0VhNjNwUXRtekZwNFVVeC9lc0oxOGhTU25EV0hzM20zOVl0aVBOK3FP?=
 =?utf-8?B?RmNObUhCZGU4TDg1WmdVbG1Ealp5aDRhQlAxcEI5a3dJT2IxeW1jRU5rY0pa?=
 =?utf-8?B?bTg2SUVHVXFZQnBmQ2FBQk9wZ1NmaTRlNWhrNEt3QTI0d1paeitZblZDV2pC?=
 =?utf-8?B?SkthOStCYTNhRHI1YTV2VUg4R3R2ZzhWc3FkTy9CSWIrMEd4aHdYalBOcU1m?=
 =?utf-8?B?b1V4VUhHbVplY0lzNjlVZitaTkhUNU8wSnA5bkpWWWZXaWIvOCtJcVNkZ1hO?=
 =?utf-8?B?MVdndis4VG1EVmFyelV2TkJkQXVnUnZtR1NWTGI1Qktwc3AweVNEWGRObHJP?=
 =?utf-8?B?YjBWNkFiK004TUdJbWhxb2tOdlZlVk1hUitPM3J1NkFxbkpTRUd4WW1YWjZ3?=
 =?utf-8?B?dVdDYnhUaStKZU9hQUpzQ3J4MVA4a3g0ZEZmdzJmK05tVGpzWTY5RU1KN0tU?=
 =?utf-8?B?YzlwZE9pNy9jblZMUlAyUXJWMjNheDh3Z2p2cC9JTW9xeWxQZVJEVlV3blpC?=
 =?utf-8?B?aVh3cFIzemk3a29wU1N4R3dMTEFjN3VzRGVQNFJkWW0rVjNwVWd1R3BGbnlj?=
 =?utf-8?B?akRkQzVKMEkvSTVSVDgvQlRKVEJsZlhkakF0akhNUE1rUDNIRFNBd2NvYjAw?=
 =?utf-8?B?V1pCVklaZXF0N1BCaVpET3F2cFAxQUc2UVZBQXhRR1lFT0llaHBQbnBlSDI5?=
 =?utf-8?B?dS9MNG5XSFdOaXhSd0wxamw3NUV6UGlYNGduTkpHVVhEZE8zVm44NVFpR21x?=
 =?utf-8?B?SzI0bDRkWE1TM1dqakptVThkYmdRUGFNUlJERklmWS91WlZNcURTV09GTnhr?=
 =?utf-8?B?bk82RzI5WG83UFhhSG1HTUJ3cWIxdE1QRExlWXRQRkJkT0U4KzRLQ3UyUEFI?=
 =?utf-8?B?TTQ0KzdpMm5LQlFNSm1UUzUzR05DVnQ2OC85TFhEaGZMaHV5aVVGMnRvU1di?=
 =?utf-8?B?UFlsSS9ic0pFNzQ2UXZwTC9sT3N1S1BSb21vdGwrZFI5VC9kSCtvYXY0SWdn?=
 =?utf-8?B?UWVTM0pWTUZmSzJFbUNFRzZid3ZJcWhhayt3S2kxb0NGN3VHMzBpcDE4cDJz?=
 =?utf-8?Q?OSbyXqE8xCxBUpDhVt2ax84TX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09da253c-7d51-4933-22f8-08dadc20bbd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 09:10:37.4209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqIjq/qMYObGQNidy+rQ7ecAjHNApEjg+tu3i5I4D4weJxSFVRpAsX0GQKerbwHVeoWQz8qYazzlSI+UrD452g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8390
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTaG91bGQgYSBjaGVjayBiZSBhZGRlZCBoZXJlIHRoYXQgZGVzY19idWZbUVVFUllfREVTQ19M
RU5HVEhfT0ZGU0VUXQ0KPiA8PSBRVUVSWV9ERVNDX01BWF9TSVpFIHRvIHByb3RlY3QgYWdhaW5z
dCBmaXJtd2FyZSBidWdzPyBTaW5jZQ0KPiBRVUVSWV9ERVNDX01BWF9TSVpFID09IDI1NSwgYWRk
aW5nIEJVSUxEX0JVR19PTihRVUVSWV9ERVNDX1NJWkUgIT0NCj4gMjU1KQ0KPiBhbmQgYSBjb21t
ZW50IG1heSBiZSBzdWZmaWNpZW50Lg0KDQpTb3JyeSAtIG15IGJhZC4NCkluIHRoZSBwcmV2aW91
cyByZXZpZXcgeW91IG1lbnRpb25lZCB0aGF0IHRoZSBwYXRjaCBsb29rcyBnb29kIHRvIHlvdSwg
aGVuY2UgdGhlICJSZXZpZXcgYnkiLg0KUmVnYXJkaW5nIHlvdXIgY29tbWVudCwgd2UgY2FuIGRv
IHRoYXQsIGFsdGhvdWdoIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGNvdmVyIGZvciB0aG9zZSBG
VyBiYXNpYyBidWdzLg0KUGxlYXNlIGxldCBtZSBrbm93IHRoYXQgeW91IHByZWZlci4NCg0KUmVn
YXJkcw0KQXJ0aHVyDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFy
dCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1i
ZXIgMTIsIDIwMjIgMjoxOSBBTQ0KPiBUbzogQXJ0aHVyIFNpbWNoYWV2IDxBcnRodXIuU2ltY2hh
ZXZAd2RjLmNvbT47DQo+IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tDQo+IENjOiBiZWFuaHVv
QG1pY3Jvbi5jb207IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDQvNF0gdWZzOiBjb3Jl
OiBSZW1vdmUgdWZzaGNkX21hcF9kZXNjX2lkX3RvX2xlbmd0aA0KPiBmdW5jdGlvbg0KPiANCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBXZXN0ZXJuIERp
Z2l0YWwuIERvIG5vdCBjbGljaw0KPiBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhhdA0KPiB0aGUgY29udGVudCBp
cyBzYWZlLg0KPiANCj4gDQo+IE9uIDEyLzExLzIyIDA1OjA1LCBBcnRodXIgU2ltY2hhZXYgd3Jv
dGU6DQo+ID4gVGhlcmUgc2hvdWxkbid0IGJlIGFueSByZXN0cmljdGlvbiBvZiB0aGUgZGVzY3Jp
cHRvciBzaXplDQo+ID4gKG5vdCB0aGUgZGVzY3JpcHRvciBpZCBmb3IgdGhhdCBtYXR0ZXIpIHVw
IHRvIFFVRVJZX0RFU0NfTUFYX1NJWkUuDQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBzcGVjLCB0aGUg
Y2FsbGVyIGNhbiB1c2UgYW55IGRlc2NyaXB0b3Igc2l6ZSwNCj4gPiBhbmQgaXQgaXMgdXAgdG8g
dGhlIGRldmljZSB0byByZXR1cm4gdGhlIGFjdHVhbCBzaXplLg0KPiA+IFRoZXJlZm9yZSB0aGVy
ZSBzaG91bGRuJ3QgYmUgYW55IHNpemVzIGhhcmRjb2RlZCBpbiB0aGUga2VybmVsLA0KPiA+IG5v
ciBhbnkgbmVlZCB0byBjYWNoZSBpdCwgaGVuY2UgdWZzaGNkX21hcF9kZXNjX2lkX3RvX2xlbmd0
aCBmdW5jdGlvbiBpcw0KPiA+IHJlZHVuZGFudC4gQWx3YXlzIHJlYWQgdGhlIGRlc2NyaXB0b3Jz
IHdpdGggUVVFUllfREVTQ19NQVhfU0laRSBzaXplLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEJh
cnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPg0KPiANCj4gSSBoYXZlIG5vdCB5ZXQg
cmVwbGllZCB3aXRoICJSZXZpZXdlZC1ieSIgdG8gdGhpcyBwYXRjaCBzbyB5b3UgYXJlIG5vdA0K
PiB5ZXQgYWxsb3dlZCB0byBhZGQgbXkgUmV2aWV3ZWQtYnkgdGFnIHRvIHRoaXMgcGF0Y2guDQo+
IA0KPiA+ICsgICAgIC8qIFVwZGF0ZSBkZXNjcmlwdG9yIGxlbmd0aCAqLw0KPiA+ICsgICAgIGJ1
ZmZfbGVuID0gZGVzY19idWZbUVVFUllfREVTQ19MRU5HVEhfT0ZGU0VUXTsNCj4gDQo+IFNob3Vs
ZCBhIGNoZWNrIGJlIGFkZGVkIGhlcmUgdGhhdCBkZXNjX2J1ZltRVUVSWV9ERVNDX0xFTkdUSF9P
RkZTRVRdDQo+IDw9IFFVRVJZX0RFU0NfTUFYX1NJWkUgdG8gcHJvdGVjdCBhZ2FpbnN0IGZpcm13
YXJlIGJ1Z3M/IFNpbmNlDQo+IFFVRVJZX0RFU0NfTUFYX1NJWkUgPT0gMjU1LCBhZGRpbmcgQlVJ
TERfQlVHX09OKFFVRVJZX0RFU0NfU0laRSAhPQ0KPiAyNTUpDQo+IGFuZCBhIGNvbW1lbnQgbWF5
IGJlIHN1ZmZpY2llbnQuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0K
