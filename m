Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EC36FA149
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjEHHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjEHHoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:44:07 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2070.outbound.protection.outlook.com [40.107.113.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20198687;
        Mon,  8 May 2023 00:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE8wsVg22hp5a/YrrulPnGVmwgZDP3mkuP7mgDDTLkLbDb3+L5ayMGtva2WsUKWV2lmpbfs7aLwRrrBXo5xJ5r3wvTjWrtcP2eUmGszTg2ly8KbzxD8NxvkN0+kXnI0ioWSb8/yDoa4l90TsecG45XM6B0hugJgVplKbG46OOc1yqS1RCGE+GCvOlUku/b/ltp2ExeUlSuZQD2MnI1kAQ8oLjTeS0ekMRqewT6bgTms6lPcxw9qrDoQV+Z2YGQZ7uTGjzCgCIGSzyxSPMQ5UIPKM+FxXUos0pB9yFnCsgt06vSaWVF1c4Z5uVcDeGyo+hIfwBareDddZvmUn3+33qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpHXR7pqNO0w3RUYiYK6pnW4ZAgecQxrzhXyT0bn5DE=;
 b=RS4lT91E1tIP1SneHva+fOFkMgRpdSDN4NG/Y0UGirh4h5WX66Ibt2/U6rHtKwmuhY3prgC6RomF/b0z258T7gcrzab9csPWj40vXcG5QBLSYn9P7N+6Tnlj/booQP/EQM9RyFop8bdu0oJqlw3C+vmiUFq1gx9udyOht96RSMAeQl1xuOE5j5RCYXcPJA0msv7DsTImalIvMnTcD30051fU6BN3k9525BlxnANQP6fW0RZSHOx6rmxvyQXoip/yA/n20fKQ/EpeGwSjP/3xBM3rlWr27cPPHOmfEv6tDqpNuJe9VInik8KT7KZntLrpJXExZr0qe+X+OGSmvBhxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpHXR7pqNO0w3RUYiYK6pnW4ZAgecQxrzhXyT0bn5DE=;
 b=Cjpuuo7GLjPGlyk4tJzFXQjL2aSgdcMlTmfjyIrbIcGOqMStYiKj5ykCEs2VlI8PE+RjTO8VUkfDXo0vimI9t5LfdmMx1UDXbwIPkBOZzClbDOldh+SdLpxfVRXT51GhHucp895J+xTd/VI0ztR+Y78isYa9p8hZ0KxD8g7jxnA=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by TY3PR01MB11370.jpnprd01.prod.outlook.com (2603:1096:400:36e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:44:01 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::148a:7cac:32d9:1c03]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::148a:7cac:32d9:1c03%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:44:01 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Dhruva Gole <d-gole@ti.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
        Pratyush Yadav <ptyadav@amazon.de>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Thread-Topic: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Thread-Index: AQHZMJVBHgHXafuso0ywMCCxmHrW5689ZDXggABfGwCAARZ4MIAA3JcAgBBuwJCAAFXLgIAAGoLg
Date:   Mon, 8 May 2023 07:44:01 +0000
Message-ID: <OSZPR01MB7004DE3578325B0F51C5CE598B719@OSZPR01MB7004.jpnprd01.prod.outlook.com>
References: <20230125081023.1573712-1-d-gole@ti.com>
 <20230125081023.1573712-5-d-gole@ti.com>
 <OSZPR01MB70048CE259A3D63C4179199A8B659@OSZPR01MB7004.jpnprd01.prod.outlook.com>
 <044a723e-b81e-f6f2-8bf7-3680a10abc86@ti.com>
 <OSZPR01MB7004D229048A950C93B40CC88B6A9@OSZPR01MB7004.jpnprd01.prod.outlook.com>
 <b1d30948-ba3d-a4cc-e1ed-851a9dedba7c@ti.com>
 <OSZPR01MB7004907B2FB95F45E9B83FEC8B719@OSZPR01MB7004.jpnprd01.prod.outlook.com>
 <11c63702-cd25-67c9-d0bc-21ec47e14c98@ti.com>
In-Reply-To: <11c63702-cd25-67c9-d0bc-21ec47e14c98@ti.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7004:EE_|TY3PR01MB11370:EE_
x-ms-office365-filtering-correlation-id: 57fedfc7-5a8a-4515-e0f2-08db4f97fd7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QcdoI9falS5qAsUTqam/lZLV6tuxA/J/eZ3N1rHZ5J8hAo5plF9pEyYNIAoUpY1LmZupDLnO1szH0nJhxtJEo1rjG9t7k9D9EONEZuLN6bW2KWeATmcqwdv35dxRHSjxAc2XwriT4TxT/Ui8laebKlmtlv0uk+bE8MFlb9GATFCYvgrkJKU65uPNGpS15HKvXY2cl4/eA4OxqkucHugOnfo61LoMMo+GBEClgILl1x2zDZ+hqRsTIMOmMAnwzWtABtoRp5+L3z2NjLBbLSt7Q/s+6r0V16/Ja0HKIuNEzpNZNHlpiRrZAm1FAa9lxNOctLc4mNR4Tl0c4uzmtNA1dc0SU8QqRTJEPFPvfBWko2OB+B2Sw9AJLdorGGS62pX3N5MYjStH6hvA1i5/2U6/uiykP33dFulKFM3P5g0QOflfKaYCnJ8GjA4rJItWkqUzPjNLCt6TDaLzrY5V83ysXokokzhcHXpqr12Tj0V8EyMhfvPOR1Ax41MAakyhx8AW92yiuxEJcvIrmrIwtE/snnAf5uEXCrGUwJXIeO/CRxuAuawi69TZj8FlzS+onnTM1Uslm02KOpZIxd8tDcxQMN5WBjQikQb4G43Mb8bUZAc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39840400004)(136003)(396003)(376002)(366004)(451199021)(83380400001)(186003)(2906002)(38100700002)(33656002)(86362001)(38070700005)(122000001)(55016003)(7696005)(8936002)(8676002)(966005)(316002)(71200400001)(41300700001)(7416002)(5660300002)(52536014)(54906003)(66946007)(6916009)(4326008)(76116006)(66476007)(66556008)(64756008)(478600001)(66446008)(6506007)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2Y2NGoyT29ZMVZWOGtrNisycmdJTTNYRGQ4dVJZdzY5TDFhc0xSTEJXOGVo?=
 =?utf-8?B?eVQvcVlKR08ybDc2VUdpb1RBZ1Q3bjlQc3JJYSt1ZjIwcjRKVVBNQ25yWmZk?=
 =?utf-8?B?MXBZN0xnc3hwV2t2TGhVWkVBaUgzYm9ZdjVaYjF2VVRiMzltK055R3ZidkpZ?=
 =?utf-8?B?SGNiLy9tYU1ZcGpCWkJMc3NsMFhqNnBsbXRGOUpEOFRJMmhKM2pZWi9PcVlC?=
 =?utf-8?B?c2h0R1NZeklBZ2lONUNEbS9RQTVSQmZLRFRQUkFvQjVoTWlnNGsraHZ0SWRu?=
 =?utf-8?B?dEpzWVhMc29LMU01dFBQSGE3ak1NcksrSk50dmx1RTlTVkRsMDFGTVJ3Q3FC?=
 =?utf-8?B?ODhoS3JSaHZRR1F3eWlOZlFibC9Qc0V6YVVoK1dBT1Y0c3VVMkxUQk1Vengw?=
 =?utf-8?B?cURMTExzaUowUGdhQ2hXd3JmZk9mY3pnQmtaVUlXSW5CbVhCSkdHd2UyUFpM?=
 =?utf-8?B?NUVJeWgrUExjelR0QXpxb1hDVVNxMXRIb25rZVI1RlBMaWJZM3pLZnFDVEVO?=
 =?utf-8?B?T3hhZmRYREhrYko0VzNNZlowQ2tDK0NxT0tMRlY3ZUV4NXpnOSt0SFdOSkt1?=
 =?utf-8?B?d1dtSHRBWXQxTDVIQnNjdDM2UTRrVkdNbVVjOUJSeFJWT0N3WjY3WktoSEpY?=
 =?utf-8?B?TUxmdVhObVNiUm1DL2g3KzZmYUgrY21kUDBpbFlKbUdFR3BHMzJ3bXdnQWd6?=
 =?utf-8?B?aHVWSXIxUjd3Q2s5em5OUnZQUitUQWNjZmRQdkJ1WldEbVRJN09yc1B0dTR2?=
 =?utf-8?B?WUdqZUJrMXlpTGJmUDlQQTl4ZHZVRlI3OGtLSTFaMkFtWDNwUkp3cEtUU1p1?=
 =?utf-8?B?YzBadHFOOStlMFZXZzZ1Y2JEZlVKNGNSU2haYk15YnBWenZ3MTNNelRvSktW?=
 =?utf-8?B?RzBpejFPN2hQeFh0NWlSWGNTRjNjeVZybmtyWFNRM3VRSWdzQyt3dWs2Vk04?=
 =?utf-8?B?c0tnd1JLK1Z1T3NTRDRIanZlNGxCUVpNQWVNME5zRHJ4eEJIZUF5QUxwOTdl?=
 =?utf-8?B?aUQzSDRlS2d5OURhSU9Zb0RVd1ZFNHo0N1VqTm9PZHpCbmloL05Hc0FxT2JQ?=
 =?utf-8?B?Ujk1RWpIUnRaZUZHMHhRY0ZOWk9pNTJ3SkxFK2xIaU1UYkpxTGY2M2ZMMmln?=
 =?utf-8?B?OHZPTFB1RW43T0UzMmdmNyt5RUpQOUNkSGFwUHRvOVM1dTZTeEp1RE9LeEZv?=
 =?utf-8?B?cURlV1lYSCtzVDdJSzZsdE9UYjQ2WHdjRXpVcHIwTlE0WnNVMUVMVFlrYnpt?=
 =?utf-8?B?RHd4Vm5xRUtoV2o5SEVhbU16bmZhYWNtL25SbERHZXI0anZxQ3owYlBxV3dO?=
 =?utf-8?B?NGhiek91TEdVRUxuOVJ6K1drR1hJVHVKYk9aSHg4TXJkNXVoUityYXdVdjZ5?=
 =?utf-8?B?aEt6N1F2UFI3aEtSVWU1R1NpbFNjdEVwMzh6dk01anZzWWtmN0F1dFM3Z2ty?=
 =?utf-8?B?OWpObVZLVDBCWG9iWlN5SHVLWE5uYUd1bGN6dWZkek4zazZvQkVBQ0t0bVpk?=
 =?utf-8?B?ZGdzc0RsbXhWSjYyamw5dm9mdmt1WFkxQWlFdTdVUld5UXkrcW1QRGU5SG9E?=
 =?utf-8?B?TFhhdUQwR1poaFcvMkJ5YnVUd0RsNno1VXBHQjlzd2ZYejNMU0FLWG95WTBm?=
 =?utf-8?B?d29mU0hUQkFLSWcyOWJ5VkdHYWxCMVlic1hvSklxREs0ZkJzcTNlMm1kNzZq?=
 =?utf-8?B?SGhDeEtaZE5kZlZiT2tZbXcySVRvSXA0Z2ZTWkhJQkJlNi90RnQ0MEZSWFIz?=
 =?utf-8?B?S2F6VXNyQmMzR2JpWmRvaEFJZndNR1JKNk9zdy85b2ppeldlOVd6UjdzREsy?=
 =?utf-8?B?aGdQUjdZL2lJcnNTY0l0SFlZSjRkdkY0Q3YxMUdaM1hiSnpKcjBHWWZYQllv?=
 =?utf-8?B?ZkdyRU5WdHVOQmpCTnNWTnpNQXRIT0pCMW0vbzBJbTd6Nmk2Qlp6YkZpOVJs?=
 =?utf-8?B?TzExZUI1bXZ3Z1JSNlhsV1I2dVl2S2R3RDNrL2tKc090c2xYenlNZmNZdmor?=
 =?utf-8?B?eHhscmVaQlErVUtjTlRxS0J4aXNIR2piREJGTHB5cnh6V3FZc1lkMTNTUTEz?=
 =?utf-8?B?RWZUNkUxa1p3d2F0UlRQc1V3QTdMRE9CaHZjakhxRnFTNFRYNGs0Y1VZL1o2?=
 =?utf-8?Q?xWwiYSZ9Fi6GKqbUqY7J/nff6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fedfc7-5a8a-4515-e0f2-08db4f97fd7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 07:44:01.4107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2fws7BK4abYGKXk9Aqrz/ms4VDx7fYhxsjAr3rZGEicVJyqLVnWsJpCOv2+w6fNlPb3EnVoWfA6XlKS87+1gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11370
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGhydXZhLA0KDQo+ID4gLSBFcnJvciBhdCBzdGFydHVwDQo+ID4gICAgLSBLZXJuZWwgbG9n
DQo+ID4gWyAgICAwLjk4MDU5OF0gKioqKioqKioqKnNwaV9tZW1fb3AgZHVtcCoqKioqKioqKioq
KioqDQo+ID4gWyAgICAwLjk4MDYxM10gYWRkcjogbmJ5dGVzOjB4MCAsIGJ1c3dpZHRoIDB4MCwg
ZHRyIDB4MCwgdmFsIDB4MA0KPiA+IFsgICAgMC45ODQyMjNdIGNtZDogbmJ5dGVzOjB4MSAsIGJ1
c3dpZHRoIDB4MSwgZHRyIDB4MCwgb3Bjb2RlIDB4OUYNCj4gPiBbICAgIDAuOTg4NjU2XSBkYXRh
OiBuYnl0ZXM6MHg2ICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBkYXRhIGRpciAweDENCj4gPiBb
ICAgIDAuOTkzMzYyXSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCj4g
PiBbICAgIDAuOTk4MzI5XSBzcGktbm9yIHNwaTAuMDogZm91bmQgbXQyNXFsNTEyYSwgZXhwZWN0
ZWQgbjI1cTUxMmENCj4gPiBbICAgIDEuMDA2NTc0XSAqKioqKioqKioqc3BpX21lbV9vcCBkdW1w
KioqKioqKioqKioqKioNCj4gPiBbICAgIDEuMDA2NTgzXSBhZGRyOiBuYnl0ZXM6MHgzICwgYnVz
d2lkdGggMHgxLCBkdHIgMHgwLCB2YWwgMHgwDQo+ID4gWyAgICAxLjAxMDE1MF0gY21kOiBuYnl0
ZXM6MHgxICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBvcGNvZGUgMHg1QQ0KPiA+IFsgICAgMS4w
MTQ1OTZdIGRhdGE6IG5ieXRlczoweDEwICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBkYXRhIGRp
ciAweDENCj4gPiBbICAgIDEuMDE5Mjg1XSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioNCj4gPiBbICAgIDEuNTI0MjcxXSBjYWRlbmNlLXFzcGkgZmY3MDUwMDAuZmxhc2g6
IEZsYXNoIGNvbW1hbmQgZXhlY3V0aW9uDQo+IHRpbWVkIG91dC4NCj4gDQo+IFRoaXMgcHJpbnQg
bWVzc2FnZSBpcyBmcm9tIGNxc3BpX2V4ZWNfZmxhc2hfY21kLiBUaGlzIGZ1bmN0aW9uIHNob3Vs
ZCBvbmx5DQo+IGJlIGNhbGxlZCBmcm9tIGNxc3BpX2NvbW1hbmRfcmVhZC93cml0ZSAuDQo+IA0K
PiBIb3dldmVyLCBmcm9tIHNwaV9tZW1fb3AgZHVtcCB0aGF0IHlvdSBoYXZlIHByb3ZpZGVkIGFi
b3ZlLCB3aGVyZQ0KPiBhZGRyLm5ieXRlcyBpcyAzIGFuZCBkYXRhLm5ieXRlcyBpcyAweDEwICh3
aGljaCBpcyA+IDgpIGl0IHNob3VsZCBuZXZlciBoYXZlDQo+IGVudGVyZWQgdGhlIGNxc3BpX2Nv
bW1hbmRfcmVhZCBmdW5jdGlvbi4NCg0KVGhlIGxvY2F0aW9uIG9mIHRoZSBsb2cgb3V0cHV0IGlz
IGFmdGVyIHRoZSBjYWxsIHRvIGNxc3BpX21lbV9wcm9jZXNzKCksIHNvIEkgYXNzdW1lIGl0IGlz
IGNhbGxlZCB3aXRoIHRoZSBmb2xsb3dpbmcgZGF0YS4NCg0KWyAxLjUzMzQ4M10gKioqKioqKioq
KnNwaV9tZW1fb3AgZHVtcCoqKioqKioqKioqKioqDQpbIDEuNTMzNDg5XSBhZGRyOiBuYnl0ZXM6
MHgzICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCB2YWwgMHgxMA0KWyAxLjUzNzA1NV0gY21kOiBu
Ynl0ZXM6MHgxICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBvcGNvZGUgMHg1QQ0KWyAxLjU0MTU3
OV0gZGF0YTogbmJ5dGVzOjB4OCAsIGJ1c3dpZHRoIDB4MSwgZHRyIDB4MCwgZGF0YSBkaXIgMHgx
DQpbIDEuNTQ2MjY2XSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCg0K
VGh1cywgdGhlIGNvbmRpdGlvbiBpcyBtZXQgYW5kIGNxc3BpX2NvbW1hbmRfcmVhZCgpIGlzIGNh
bGxlZC4NCldlIGhhdmUgYWxzbyBhcHBsaWVkIHRoZSBmb2xsb3dpbmcgcGF0Y2ggYW5kIGNvbmZp
cm1lZCB0aGF0IGl0IGlzIGNhbGxlZC4NCg0KLSBwYXRjaA0KYGBgDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zcGkvc3BpLWNhZGVuY2UtcXVhZHNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLWNhZGVuY2Ut
cXVhZHNwaS5jDQppbmRleCA2NGI2YTQ2MGQ3MzkuLjhkMzY4MWUxZjM1YyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvc3BpL3NwaS1jYWRlbmNlLXF1YWRzcGkuYw0KKysrIGIvZHJpdmVycy9zcGkvc3Bp
LWNhZGVuY2UtcXVhZHNwaS5jDQpAQCAtMTM2NSwxNSArMTM2NSwyMSBAQCBzdGF0aWMgaW50IGNx
c3BpX21lbV9wcm9jZXNzKHN0cnVjdCBzcGlfbWVtICptZW0sIGNvbnN0IHN0cnVjdCBzcGlfbWVt
X29wICpvcCkNCiAJICogcmVhZHMsIHByZWZlciBTVElHIG1vZGUgZm9yIHN1Y2ggc21hbGwgcmVh
ZHMuDQogCSAqLw0KIAkJaWYgKCFvcC0+YWRkci5uYnl0ZXMgfHwNCi0JCSAgICBvcC0+ZGF0YS5u
Ynl0ZXMgPD0gQ1FTUElfU1RJR19EQVRBX0xFTl9NQVgpDQorCQkgICAgb3AtPmRhdGEubmJ5dGVz
IDw9IENRU1BJX1NUSUdfREFUQV9MRU5fTUFYKSB7DQorCQkJcHJpbnRrKCItLS0tLSAlZDolcygp
ICgxKSAtLS0tLVxuIiwgX19MSU5FX18sIF9fZnVuY19fKTsNCiAJCQlyZXR1cm4gY3FzcGlfY29t
bWFuZF9yZWFkKGZfcGRhdGEsIG9wKTsNCisJCX0NCiANCisJCXByaW50aygiLS0tLS0gJWQ6JXMo
KSAoMikgLS0tLS1cbiIsIF9fTElORV9fLCBfX2Z1bmNfXyk7DQogCQlyZXR1cm4gY3FzcGlfcmVh
ZChmX3BkYXRhLCBvcCk7DQogCX0NCiANCi0JaWYgKCFvcC0+YWRkci5uYnl0ZXMgfHwgIW9wLT5k
YXRhLmJ1Zi5vdXQpDQorCWlmICghb3AtPmFkZHIubmJ5dGVzIHx8ICFvcC0+ZGF0YS5idWYub3V0
KSB7DQorCQlwcmludGsoIi0tLS0tICVkOiVzKCkgKDMpIC0tLS0tXG4iLCBfX0xJTkVfXywgX19m
dW5jX18pOw0KIAkJcmV0dXJuIGNxc3BpX2NvbW1hbmRfd3JpdGUoZl9wZGF0YSwgb3ApOw0KKwl9
DQogDQorCXByaW50aygiLS0tLS0gJWQ6JXMoKSAoNCkgLS0tLS1cbiIsIF9fTElORV9fLCBfX2Z1
bmNfXyk7DQogCXJldHVybiBjcXNwaV93cml0ZShmX3BkYXRhLCBvcCk7DQogfQ0KDQpgYGANCg0K
LSBsb2cNCmBgYA0KWyAgICAwLjc4NjYwMF0gLS0tLS0gMTM2OTpjcXNwaV9tZW1fcHJvY2Vzcygp
ICgxKSAtLS0tLQ0KWyAgICAwLjc5MDMxMl0gKioqKioqKioqKnNwaV9tZW1fb3AgZHVtcCoqKioq
KioqKioqKioqDQpbICAgIDAuNzkwMzE5XSBhZGRyOiBuYnl0ZXM6MHgwICwgYnVzd2lkdGggMHgw
LCBkdHIgMHgwLCB2YWwgMHgwDQpbICAgIDAuNzkzODg1XSBjbWQ6IG5ieXRlczoweDEgLCBidXN3
aWR0aCAweDEsIGR0ciAweDAsIG9wY29kZSAweDlGDQpbICAgIDAuNzk4MzI1XSBkYXRhOiBuYnl0
ZXM6MHg2ICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBkYXRhIGRpciAweDENClsgICAgMC44MDMw
MTNdICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KWyAgICAwLjgwNzg5
Ml0gc3BpLW5vciBzcGkwLjA6IGZvdW5kIG10MjVxbDUxMmEsIGV4cGVjdGVkIG4yNXE1MTJhDQpb
ICAgIDAuODE2MDYyXSAtLS0tLSAxMzczOmNxc3BpX21lbV9wcm9jZXNzKCkgKDIpIC0tLS0tDQpb
ICAgIDAuODE5Nzc1XSAqKioqKioqKioqc3BpX21lbV9vcCBkdW1wKioqKioqKioqKioqKioNClsg
ICAgMC44MTk3ODJdIGFkZHI6IG5ieXRlczoweDMgLCBidXN3aWR0aCAweDEsIGR0ciAweDAsIHZh
bCAweDANClsgICAgMC44MjMzNDhdIGNtZDogbmJ5dGVzOjB4MSAsIGJ1c3dpZHRoIDB4MSwgZHRy
IDB4MCwgb3Bjb2RlIDB4NUENClsgICAgMC44Mjc3OTJdIGRhdGE6IG5ieXRlczoweDEwICwgYnVz
d2lkdGggMHgxLCBkdHIgMHgwLCBkYXRhIGRpciAweDENClsgICAgMC44MzI0ODBdICoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KWyAgICAwLjgzNzQ0Ml0gLS0tLS0gMTM2
OTpjcXNwaV9tZW1fcHJvY2VzcygpICgxKSAtLS0tLQ0KWyAgICAxLjM0NDY3MV0gY2FkZW5jZS1x
c3BpIGZmNzA1MDAwLmZsYXNoOiBGbGFzaCBjb21tYW5kIGV4ZWN1dGlvbiB0aW1lZCBvdXQuDQpb
ICAgIDEuMzUwMzI4XSAqKioqKioqKioqc3BpX21lbV9vcCBkdW1wKioqKioqKioqKioqKioNClsg
ICAgMS4zNTAzMzRdIGFkZHI6IG5ieXRlczoweDMgLCBidXN3aWR0aCAweDEsIGR0ciAweDAsIHZh
bCAweDEwDQpbICAgIDEuMzUzOTAxXSBjbWQ6IG5ieXRlczoweDEgLCBidXN3aWR0aCAweDEsIGR0
ciAweDAsIG9wY29kZSAweDVBDQpbICAgIDEuMzU4NDI3XSBkYXRhOiBuYnl0ZXM6MHg4ICwgYnVz
d2lkdGggMHgxLCBkdHIgMHgwLCBkYXRhIGRpciAweDENClsgICAgMS4zNjMxMTRdICoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KWyAgICAxLjM2Nzk4MV0gc3BpLW5vciBz
cGkwLjA6IG9wZXJhdGlvbiBmYWlsZWQgd2l0aCAtMTEwDQpbICAgIDEuMzc1Mzc2XSBzcGktbm9y
IHNwaTAuMDogbXQyNXFsNTEyYSAoNjU1MzYgS2J5dGVzKQ0KYGBgDQoNCj4gUGxlYXNlIGNhbiB5
b3Ugc2hhcmUgdGhlIGV4YWN0IG91dHB1dCBvZiB1bmFtZSAtYSB3aGVyZSB5b3Ugb2JzZXJ2ZSB0
aGlzDQo+IGVycm9yPw0KDQpNeSBlbnZpcm9ubWVudCBoYXMgc2hvcnRlbmVkIHRoZSBvdXRwdXQg
b2YgdW5hbWUgLWEsIHNvIGl0IG1heSBub3QgYmUgdXNlZnVsLg0KSW5zdGVhZCwgSSB3aWxsIGdp
dmUgeW91IGluZm9ybWF0aW9uIGFib3V0IHRoZSBrZXJuZWwgSSBhbSB1c2luZy4NCkl0IGlzIHRo
ZSBmb2xsb3dpbmcgKHY2LjMpOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2lkPTQ1NzM5MWIwMzgwMzM1ZDVl
OWE1YmFiZGVjOTBhYzUzOTI4YjIzYjQNCg0KPiBBcmUgeW91IGNhcnJ5aW5nIGFueSBzb3J0IG9m
IGxvY2FsIHBhdGNoZXM/IENhbiB5b3UgbWFrZSBzdXJlIHRoYXQgdGhlDQo+IENRU1BJX1NUSUdf
REFUQV9MRU5fTUFYIGlzIDggaW4geW91ciBjYXNlIHRvbz8NCg0KVGhlcmUgaXMgbm8gbG9jYWwg
cGF0Y2ggYW5kIENRU1BJX1NUSUdfREFUQV9MRU5fTUFYIHJlbWFpbnMgOC4NCg0KLS0gDQpUaGFu
a3MgYW5kIFJlZ2FyZHMsDQpZb3NoaXRha2EgSWtlZGENCg==
