Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F7C7247B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbjFFP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjFFP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:28:22 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2123.outbound.protection.outlook.com [40.107.20.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61D100
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVC2odeloQr9hPCZ8JjEJOrplpeTl0LszPRC+ds0dDKBafI/JKxVezRWKQxeKrmIKWywWcTuezx51awgvn3OcUTVHeisE+OG2QZftNQ8+giZ8fbFVaBJkytzlu2FLSzDWZcsDgZwb9+PnkDSZGi467sxtnFRBp0pxaPPCNu3Uwr+o6IpdTXwo8+oOOM7+NKW7ZmZ/M+L2II8fWqdg0XwWXIz7pVmfz/ZwuX7XMj7wBSDO9ghxkKsas3bsM5R6MkhDeyswOdpnGgySN6CY7n29vvJdwcroy7XyQzH0TL7MykBy868VkjxGcAKTCkHoLCt1zyhx62puhBVBZbhX15xjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElZGY7qTH514UI4N5N57l40eZ9eSzk9IMo7/BpYVU54=;
 b=moKN6gao/ecIpZyjwwa2A9Q8Iwzpt5kvmRoPrWqSZ25w9vD0g6pxUz3Hrq1oFNoGTi641/kPn6qcefgvKOdarGZOZt5aYP9q/61zZvmGNW+vD42noyFIBNW8YqPbP9sZSyZ1UuWb0MAbhbDVqzO/wzIHz2a0Hu12SrZ2aRhTCtiNnw9KwPLPdLQ2STuCVWATZ9Thuy2XBQj8pY5YGPC+qqh1xc2hTtthmWkclJfjk2V/XR9rYNUjdNKLUIT++CqtExsEcFy/nn+tpTdHxrZVVOEA0I9LV6tzVUASV+WJOPV53K5iJeH7XK/0Jcvl4RpWGWvNtucKCjTeZ3ewXhZ7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=habana.ai;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElZGY7qTH514UI4N5N57l40eZ9eSzk9IMo7/BpYVU54=;
 b=la692A/q/rR44fHhZAz6EDkPRT5zRERZgzLCyCfngy01wGLvnkN9M9hYwnlJmPBvpVXE3SgLqlstf30hQONrXGeGlh+9ZSc++dIX615RvnCNZeeIuHCJhJectGfYh4kL5cbbgojJ3yIMg4R55Df3gYLwninZATNVNahMkN8h7xM8rUBTer75XwApAqHvROQ4glFvVNTTdz8+dPdrGaF8qyUk37YOheutR5kdvQfRN3VEF2rg0U1HFQayYogNuA2b3eoC5CJfXf5SjwV8SFG2I+3m9rwKT16aVxAj9z0e7rU+oxyafKYxbNndCuwAyJmaCzuIivUD1QVtMy2L++sChQ==
Received: from AM9PR02MB7706.eurprd02.prod.outlook.com (2603:10a6:20b:43d::23)
 by GV1PR02MB8857.eurprd02.prod.outlook.com (2603:10a6:150:a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 15:28:18 +0000
Received: from AM9PR02MB7706.eurprd02.prod.outlook.com
 ([fe80::73e3:88a8:1bd4:7bde]) by AM9PR02MB7706.eurprd02.prod.outlook.com
 ([fe80::73e3:88a8:1bd4:7bde%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 15:28:17 +0000
From:   Moti Haimovski <mhaimovski@habana.ai>
To:     Conor Dooley <conor@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "david.m.ertman@intel.com" <david.m.ertman@intel.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] make AUXILIARY_BUS config selection clearer
Thread-Topic: [PATCH v1] make AUXILIARY_BUS config selection clearer
Thread-Index: AQHZmHvOlQ30/AODak+XP1A3z091Ua99ygkAgAAJxlCAAAusgIAAAJCQ
Date:   Tue, 6 Jun 2023 15:28:17 +0000
Message-ID: <AM9PR02MB7706F1E489D4B54E9502D4B4D152A@AM9PR02MB7706.eurprd02.prod.outlook.com>
References: <20230606133528.197335-1-mhaimovski@habana.ai>
 <20230606-aspirate-evident-00b27a98a718@wendy>
 <AM9PR02MB7706888212798FE0CC8213D6D152A@AM9PR02MB7706.eurprd02.prod.outlook.com>
 <20230606-sushi-clunky-8e816f5b206d@spud>
In-Reply-To: <20230606-sushi-clunky-8e816f5b206d@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=habana.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR02MB7706:EE_|GV1PR02MB8857:EE_
x-ms-office365-filtering-correlation-id: 9970d4c7-4f7e-48ad-b351-08db66a2a730
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1C4/Z3lXPBtFCXFSC/EBVLad8SutsoqOg/5YkzLGUtII4Xy2fuTIZTSLG5tERkEF82KfUqM60sk7GXr1zKLinqAsni6b7lvh1hcu0DLyQsGWM5yVjEAM7nqidE8G+vja+y9cuTTsQ4+773ls4GPQK435PqMiP1bXFDeMpSi8yl1R91QQk0iVnxpDjVw2Hnx42AhqP6Tlbm+ZD3sPh6nDCZgKtg0zfU3cECmp4Ikvtd4nfyZixnp123u6AMCNjGlwgQR/7QJYHaKjSYtMQ6eu//buPIicCRgKiTLL1rItt5Ha389wnsdiRnNVoE0GelWcvp74PjYSt4RZVP6yBqZfwVq3oYcHAdMrFb8oZuMC2qZjMB5273hvI2Hdc8xm+C8DQl532bAJTftxIaZLDXPjo8rLylCEYsmTCaJD6T/TNErKheTy0s/MfD+DRoGG+N0xf9y8IknZ53iqGIL0EbCfGd+bglodgZRQLotpba9ByN1gfGFb0PJzZwbMTl9FQ3R3I5WljkJJ4M21HPkkCmczxyILuFP9Xe7cVpbErPGs6j9/IY4/JwpVvkoBKKzDIzdJTgXAIqhpWintLD0rB3LTqQ2LxEAEe3mG8NZXw8lxitHzB3tblkeUv0Gddk9T+0w3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR02MB7706.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(451199021)(83380400001)(478600001)(82960400001)(33656002)(55016003)(8676002)(8936002)(64756008)(38070700005)(316002)(76116006)(4326008)(66946007)(52536014)(66556008)(66446008)(66476007)(122000001)(6916009)(5660300002)(38100700002)(41300700001)(86362001)(71200400001)(7696005)(2906002)(54906003)(53546011)(186003)(6506007)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFFTd3hJZzJ0U0tjZmM4VCsrdFFudDMrZTlUcng3d0NFS1BKQkxXSGhmWTRl?=
 =?utf-8?B?Qm5PNGtrek9wYTYyM2RFR3JmaXhxczk5enlUSmlUT0RKcTIvZjhlc241RVE2?=
 =?utf-8?B?L0xYWFd6WW9MakMvcURHZXhHN2dkbVZvN0ZzQUlBL3NMczgreGVFdDZQMm14?=
 =?utf-8?B?cVNmUXdTYjBwZmxDalRldDVTQ2M5QSsvbEZwd0VvWXlDeDE1VEVWVldOaHZG?=
 =?utf-8?B?OW5saFFPRTdmQ0Zyd2QvMDlZblYzcXlqS2N2SlFkT2lNOFowYzRnZGFVQ2NY?=
 =?utf-8?B?THBtRlVmSXBTNm9hMHRsWGloSEd4elpvOGE1SXphb0JsQzJ6V1RMR1pwWHFw?=
 =?utf-8?B?SHNIRDNkcVk2TklLSXYzRGl4SjdLczBzRlg5a0xldW5LNjI4ZE16dEQ2VVgw?=
 =?utf-8?B?RHQ2WDEwclI0QndNQjZPbW9JMUtPd1ppSlpzcytTdEloc1VWOXdvbGFZczlU?=
 =?utf-8?B?dVM1WDJ4ZFRMeGhGUGdVTXo4a2VwdGl6NXJTeFVZUDBma3dMRTFNcWlBN0Fm?=
 =?utf-8?B?MTV5aDhQTmNkWjhDNGtDQWpOTXpxZ3hNcEZIN1UxYU11M3dsYzZmN0t1YWpx?=
 =?utf-8?B?SkJFQVZKNEZaVFJjTDRGRUJsNjlWeXExbWhlY0RXQTNaMnFDeVhXSmJLZVBu?=
 =?utf-8?B?Kzh6OGNZc1JrcVA4dmJpSWhnS0cxQ2RvanBPTVArNExCVVRQTWI4Z0ZkTEUy?=
 =?utf-8?B?RVhPdHptQUptWGU5ZEh2elV0OHhQYThBY1hwcW1RdC9Bb2ZCV2RhTDgzTHQz?=
 =?utf-8?B?Ykd6Umg3d0lKM0J5aG5pRFI4M0NOMlh3NXhsblhFRUNKNlhaTFlMaUNKZnJk?=
 =?utf-8?B?T0V2OTRHTFZPdnh0UnhoaFZrbWVFV2MxSlZkYVlvTW1KZi9ISDNhcTlhcENl?=
 =?utf-8?B?TjAvR2tGVERod00xd1RzUDlWajJNQUJZelowRDE0aGxSU25xTTR1L05MK0Zu?=
 =?utf-8?B?STlVS0dZME91UGFySmFIZjZEQ0JzMVBneStFZWpVOVVrbTgvV056OElHV2pr?=
 =?utf-8?B?Y2laUTJYRXZiZWdKaWM2dFRZb2FwR0pkUHI5MStoeHZLaDVPajFqZDF4VmlJ?=
 =?utf-8?B?ZWdYQ2orK2lIejhOd2hoQm5CQWoydkFLTmJhTXV3ZkNIMDVkOE1HMFdhMjR0?=
 =?utf-8?B?amNVUTRTTFEvenVjNzFMQXJiSkZBYmZKNnJhT01EcmR5WTcxVFVFWG9NVzAr?=
 =?utf-8?B?R0Z1bkhlR0o0UTY4WDBocWNtSjdxZXFFMWk4TzlVL1diaHdONlZRRGMyYTEy?=
 =?utf-8?B?aEhaZFJXTHdSbXVvVzVRVnVsdkhHOFdXQ0Zza2F5MVFJYndIaGZpWmliMEU0?=
 =?utf-8?B?ZlJkbXM3VGd2b2FMekRCcnhMY29Qa2Zzb3Q3bEUvUjNidkc2eHQvTDJwQTZy?=
 =?utf-8?B?Vm10cjhQZzVHekNRc2tqUEE2bVNhbk9ZVktJVm5uak9mLzJ4SDRHaTE2dUk2?=
 =?utf-8?B?bzJReVQ1U2lUQ29EWUZzdVZJVCtMUmtPZS9EQ0I1L1gvRmZ5a3dvMTBvNDU0?=
 =?utf-8?B?LzNzYUxld3FSMUNqb2k0dG1ONkpkcWkyQ3dpTmVGUEROMUhsRCsrSzA4V0FU?=
 =?utf-8?B?ckVUL25uSEhiYU4zckVZempCOUxOeHRUZXBXY0NqTXNEdE9HOUNIZTMvSkg1?=
 =?utf-8?B?SmNNMkF4eWdBR21uMXBpQnlLbG13UHpNZFJGb0VQb0JYNTFwMEJxUUdWczRZ?=
 =?utf-8?B?S2h3N3pNcGxmdEZOejNxN2JNOVpSZzlsUllhdVBzRGpROUw1RG85QmJXS202?=
 =?utf-8?B?R0JSWGNmRkJaWENtSWVFcCtVdlVsRTUwNnpaQ3dvRlE3a0JCeDhDcnFGM0Iv?=
 =?utf-8?B?NytYYmJaditHbkNOcEVDT0tRSStKN1N5MXVzWHd5TkIxbjNkWThsZXJFM1dB?=
 =?utf-8?B?K0crUUVJY1Q1bWVGdmk2RVZPbVdKUVVLRytpYXV2OFFEYWdod0xRNW5aKzlS?=
 =?utf-8?B?UEFSczAzTjEvdmRMVFl5ZHU2TE90U2taYUl4RXlMblZTdDBxSnZxcWdTdmlK?=
 =?utf-8?B?TVdjSmR2cGJCZWN1a0Y2eWZVT0wyTDJDampRYnJ2cm5QSmZGekZabVQvOG52?=
 =?utf-8?B?N2tDNC9aTnlvTEFwV2dhU0g4Z0pDaUgvTFFVMmZTV1czWmZMaG5wRkpHV1R0?=
 =?utf-8?Q?JE86ETbj2O7wPdoK73pvjI/jK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR02MB7706.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9970d4c7-4f7e-48ad-b351-08db66a2a730
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 15:28:17.8630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZZiGTPV55IzJfl05wMwWDHmiqVqsbHwLrFkbeHVg86PnQZCZ+TPFjqkxKCboeoNlqZ/4rSW7eHWUTx9GfcSug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8857
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29ub3IgRG9vbGV5IDxj
b25vckBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCA2IEp1bmUgMjAyMyAxODowNQ0KPiBU
bzogTW90aSBIYWltb3Zza2kgPG1oYWltb3Zza2lAaGFiYW5hLmFpPg0KPiBDYzogQ29ub3IgRG9v
bGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT47DQo+IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOyBkYXZpZC5tLmVydG1hbkBpbnRlbC5jb207DQo+IG9nYWJiYXlAa2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBt
YWtlIEFVWElMSUFSWV9CVVMgY29uZmlnIHNlbGVjdGlvbiBjbGVhcmVyDQo+IA0KPiBPbiBUdWUs
IEp1biAwNiwgMjAyMyBhdCAwMjo1MDoyMVBNICswMDAwLCBNb3RpIEhhaW1vdnNraSB3cm90ZToN
Cj4gPiA+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+IE9u
IFR1ZSwgSnVuIDA2LA0KPiAyMDIzDQo+ID4gPiBhdCAwNDozNToyOFBNICswMzAwLCBNb3RpIEhh
aW1vdnNraSB3cm90ZToNCj4gPiA+ID4gQWRkIGEgZGlzcGxheSBzdHJpbmcgYW5kIGEgaGVscCBz
ZWN0aW9uIHRvIHRoZSBjb25maWcNCj4gPiA+ID4gQVVYSUxJQVJZX0JVUyBzZWN0aW9uIHVuZGVy
IHRoZSAiR2VuZXJpYyBEcml2ZXIgT3B0aW9ucyIgbWVudSBpbg0KPiA+ID4gPiBvcmRlciB0byBt
YWtlIGl0cyBzZWxlY3Rpb24gY2xlYXJlci4NCj4gPiA+DQo+ID4gPiBJIGFtIGEgd2VlIGJpdCBj
b25mdXNlZCwgc2luY2UgaXQgaXMgbm90IGV4cGxpY2l0bHkgbWVudGlvbmVkIGhlcmUsDQo+ID4g
PiB3aHkgaXMgdGhpcyBub3cgZ29pbmcgdG8gYmUgdXNlciB2aXNpYmxlL3NlbGVjdGFibGU/IFdo
YXQgd2FzIHdyb25nDQo+ID4gPiB3aXRoIHRoZSBkcml2ZXJzIHRoYXQgbmVlZGVkIGl0IHNlbGVj
dGluZyBpdD8NCj4gDQo+IChwbGVhc2UgZG9uJ3QgdG9wIHBvc3QpDQo+IA0KPiA+ICBOb3Rpbmcg
aXMgd3Jvbmcgd2l0aCB0aGUgZHJpdmVycyDwn5iKDQo+ID4NCj4gPiBJJ3ZlIHN0dW1ibGVkIHRo
YXQgaXNzdWUgd2hlbiB0cnlpbmcgdG8gZmlndXJlLW91dCBob3cgdG8gbWFuaXB1bGF0ZQ0KPiA+
IHRoZSBhdXhpbGlhcnktYnVzIHNlbGVjdGlvbiBWaWEgIm1ha2UgbWVudWNvbmZpZyINCj4gPiBU
aGUgaXNzdWUgaXMgdGhhdCB3aXRoIHRoZSBjdXJyZW50IEtjb25maWcgd2hlbiB5b3UgcnVuICIg
bWFrZQ0KPiBtZW51Y29uZmlnIiBhbmQgZW50ZXIgdGhlDQo+ID4gRGV2aWNlIERyaXZlcnMgLS0t
PiAgICAgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucyAtLS0+ICAgU3ViLW1lbnUgdGhlbiB0aGVyZSBp
cw0KPiBubyBtZW50aW9uaW5nIG9mDQo+ID4gIHRoZSBBdXhpbGlhcnkgYnVzIGFsdGhvdWdoIGl0
IGlzIHRoZSBmaXJzdCBlbnRyeSBpbiBkcml2ZXJzL2Jhc2UvS2NvbmZpZyB0aGF0DQo+IHRoaXMg
bWVudSBpcyBwcmVzZW50aW5nLg0KPiA+IFNvLCB0aGUgdXNlciBoYXMgbm8gaWRlYSB0aGF0IHRo
aXMgb3B0aW9uIGV4aXN0cyBhbmQgbm8gd2F5IHRvIG1hbmlwdWxhdGUgaXQNCj4gdmlhIG1lbmNv
bmZpZy4NCj4gDQo+IFRoYXQncyB0aGUgcG9pbnQgb2YgaG93IGl0IGN1cnJlbnRseSBpcyB0aG91
Z2gsIG5vPw0KPiBXZSBkb24ndCBhbGxvdyB1c2VycyB0byBzZXQgdGhlIG9wdGlvbiwgYnV0IHJh
dGhlciBhbnkgZGV2aWNlIGRyaXZlciB0aGF0DQo+IG5lZWRzIGl0LCBzZWxlY3RzIGl0Lg0KPiBU
aGF0IHdheSwgYSBwZXJzb24gY29uZmlndXJpbmcgdGhlaXIga2VybmVsIGZvciBzb21lIGhhcmR3
YXJlIGp1c3QgbmVlZHMgdG8NCj4gZW5hYmxlIHRoZSBkcml2ZXJzIGZvciB0aGVpciBoYXJkd2Fy
ZSBhbmQga25vd2xlZGdlIG9mIGtlcm5lbCBpbnRlcm5hbHMgaXMNCj4gbm90IG5lZWRlZC4NCj4g
DQo+IElzIHRoZXJlIGEgcGFydGljdWxhciBkcml2ZXIsIHBlcmhhcHMgaW4gZHJpdmVycy9hY2Nl
bCwgdGhhdCBkb2VzIG5vdCBzZWxlY3QgdGhlDQo+IG9wdGlvbiwgd2hpY2ggaXMgd2h5IHlvdSBh
cmUgdHJ5aW5nIHRvIHNldCBpdCB5b3Vyc2VsZj8NCg0KTm8sIG5vdGhpbmcgc3BlY2lmaWMuIEp1
c3Qgc2F3IGl0IGFuZCB0aG91Z2h0IGl0IGlzIGFuIGlzc3VlIHRvIGFkZHJlc3MsIA0Kc2VudCBh
IHByaXZhdGUgbWFpbCB0byB0aGUgYXV0aG9yIChEYXZlIEVydG1hbiA8ZGF2aWQubS5lcnRtYW5A
aW50ZWwuY29tPikNCldobyByZXBsaWVkIHRoYXQgaGUgd2FzIHVuYXdhcmUgdGhhdCBpdCB3YXMg
YSBuYWtlZCBib29sIGluIHRoZSBiYXNlL0tjb25maWcgZmlsZSENCkFuZCB0aGVyZSBpcyBubyBy
ZWFzb24gdGhhdCBoZSBpcyBhd2FyZSBvZiBmb3IgaXQgdG8gYmUgdGhhdCB3YXkuDQpTbywgSSd2
ZSBhZGRlZCBpdC4NCg0KPiANCj4gQ2hlZXJzLA0KPiBDb25vci4NCj4gDQo+ID4gTXkgY29tbWl0
IG1ha2VzIHRoaXMgb3B0aW9uICJ2aXNpYmxlIiBieSBhZGRpbmcgdGhlIHNob3J0IGRlc2NyaXB0
aW9uDQo+ID4gaW4gdGhlICJib29sIiBsaW5lIGFuZCAsIHdoaWxlIGF0IGl0LCBhZGRpbmcgYSBz
aG9ydCBkZXNjcmlwdGlvbiBmb3IgdGhlIHNha2Ugb2YNCj4gZnV0dXJlIGdlbmVyYXRpb25zLg0K
PiA+IE5vIGZ1bmN0aW9uYWxpdHkgbm9yIGRlZmF1bHQgdmFsdWVzIHdlcmUgYWx0ZXJlZC4NCj4g
DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1vdGkgSGFpbW92c2tpIDxtaGFpbW92
c2tpQGhhYmFuYS5haT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL2Jhc2UvS2NvbmZp
ZyB8IDExICsrKysrKysrKystDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9iYXNlL0tjb25maWcgYi9kcml2ZXJzL2Jhc2UvS2NvbmZpZyBpbmRleA0KPiA+ID4gPiA2ZjA0
YjgzMWE1YzAuLmUxY2FhYzFkOWE1OCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9iYXNl
L0tjb25maWcNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9iYXNlL0tjb25maWcNCj4gPiA+ID4gQEAg
LTIsNyArMiwxNiBAQA0KPiA+ID4gPiAgbWVudSAiR2VuZXJpYyBEcml2ZXIgT3B0aW9ucyINCj4g
PiA+ID4NCj4gPiA+ID4gIGNvbmZpZyBBVVhJTElBUllfQlVTDQo+ID4gPiA+IC0JYm9vbA0KPiA+
ID4gPiArCWJvb2wgIlN1cHBvcnQgZm9yIGF1eGlsaWFyeSBidXMiDQo+ID4gPiA+ICsJaGVscA0K
PiA+ID4gPiArCSAgVGhlIGF1eGlsaWFyeSBidXMgZHJpdmVyIHByb3ZpZGVzIGEgd2F5IHRvIGV4
cG9ydCBhbiBpbnRlcmZhY2UNCj4gPiA+ID4gKwkgIGZvciBhbm90aGVyIHN1YnN5c3RlbSB0byBk
cml2ZSwgaW1wbGVtZW50IGEgY29tbW9uIGludGVyc2VjdGlvbg0KPiA+ID4gPiArCSAgb2YgZnVu
Y3Rpb25hbGl0eSBvciBzcGxpdCBhIGZ1bmN0aW9uIGludG8gY2hpbGQtZGV2aWNlcw0KPiA+ID4g
PiArCSAgcmVwcmVzZW50aW5nIHN1Yi1kb21haW5zIG9mIGZ1bmN0aW9uYWxpdHkgd2hlcmUgZWFj
aCBhdXhpbGlhcnkNCj4gPiA+ID4gKwkgIGRldmljZSByZXByZXNlbnRzIGEgcGFydCBvZiBpdHMg
cGFyZW50IGZ1bmN0aW9uYWxpdHkgKHVzdWFsbHkpDQo+ID4gPiA+ICsJICBkcml2ZW4gYnkgYW5v
dGhlciBkcml2ZXIuDQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkgIElmIHVuc3VyZSwgc2F5IFkuDQo+
ID4gPiA+DQo+ID4gPiA+ICBjb25maWcgVUVWRU5UX0hFTFBFUg0KPiA+ID4gPiAgCWJvb2wgIlN1
cHBvcnQgZm9yIHVldmVudCBoZWxwZXIiDQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMjUuMQ0KPiA+
ID4gPg0K
