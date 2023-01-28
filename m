Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5126467F657
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjA1Ibx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjA1Ibv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:31:51 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076DD6D5CD
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:31:49 -0800 (PST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-yY4-jmyaNZycjoZ11mdIrg-1; Sat, 28 Jan 2023 09:31:46 +0100
X-MC-Unique: yY4-jmyaNZycjoZ11mdIrg-1
Received: from GVAP278MB0679.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4b::13)
 by ZR0P278MB0057.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:17::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Sat, 28 Jan
 2023 08:31:43 +0000
Received: from GVAP278MB0679.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a99:135:a7aa:6e72]) by GVAP278MB0679.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a99:135:a7aa:6e72%3]) with mapi id 15.20.6043.028; Sat, 28 Jan 2023
 08:31:43 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: Re: [PATCH v1] media: i2c: ov5640: Implement get_mbus_config
Thread-Topic: [PATCH v1] media: i2c: ov5640: Implement get_mbus_config
Thread-Index: AQHZMmHdndevyaNkN0qwnSx3com1K66yis2AgAD2U4A=
Date:   Sat, 28 Jan 2023 08:31:42 +0000
Message-ID: <28fabdda1c9236c1733eef7224e65306d2d09ba8.camel@toradex.com>
References: <20230127151245.46732-1-marcel@ziswiler.com>
         <20230127175003.6ofmfaqovbqu54hg@uno.localdomain>
In-Reply-To: <20230127175003.6ofmfaqovbqu54hg@uno.localdomain>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0679:EE_|ZR0P278MB0057:EE_
x-ms-office365-filtering-correlation-id: 116efeaf-991d-4a8b-87b4-08db010a15cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: dzEMrEfX26KLAniWrQ0VWRS01TzLIpqmojIWtVN6Dz8lNlOVBxuPL4weVtbkY0WZTgJYnTDujqsxLCYlIR9PbcwWxPJudoBMgyKWFYcOngAd0L+5632X+4jOKS+KFmYMwE8C8JfcNS0SwtmXr8a7uKEmazQm46DO0rvtL+4N/nzk25tZI0f6fffNBBIDF5fC1gYeaLXwfGsWjfQ1Rdx8cYbiDCF9b+t+cjZB2M7v6/+vHIe0Nkk00XWJvUVkDqDxPYM/jzeMD7Ml4r/f7Ed5RXmA/x3U5qB0kEKmx4VORIHWZzOSj7/BCGQ5F9Ih7QE2w/fX5O7bEy8sCqXQKdeUnKmRfZDAz5agzKIY8unSpOUUaBWwHoUUgrt8vSoXGxIHYElIzvvm5FHx9J4EgQ+0rIdrECwdndpAc7T2Ybsze5tU50kTQGo0RV9+9YnQE8rzftWHaAf7sHCelrS0Frpl+3PZB7g80WxK0MYZetcFntmhCUEtgD5naBtmW7PWhfdd/w2BGiOjpeFW53sWWlmt/UO0J+YHSoglT36SlfGetLjePf8Zh9ZZ6HjVORdKBvv303V4qJKl8Bif9vPjZtDLzTq99TgGpj6xKZ3h4v09+9NskQU2N9J03klJYZfb06bfLuk3pFsOWd/QfiwYiZ8Me862y15+HpemeFveioIi1+EGT276TKTyJvsB3vV/ZEqQP4n74uagcPM/fmgdXhgEFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0679.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(396003)(39840400004)(451199018)(2616005)(36756003)(6506007)(186003)(38070700005)(26005)(6512007)(44832011)(6486002)(71200400001)(478600001)(86362001)(2906002)(38100700002)(316002)(54906003)(122000001)(5660300002)(66946007)(66446008)(64756008)(66556008)(66476007)(6916009)(41300700001)(76116006)(91956017)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEJhN1h1bWM3dzVIV3l6b2NZbDRFb1BUZjBwSDRyUmRkYStKT2NFMTZFSlcz?=
 =?utf-8?B?N3JJTmc0RGdacFo2aGF5VFVYM1d4VDAwaXRHWmgwSXM0akFSRGp6c0ZFNXBq?=
 =?utf-8?B?RjlSaXJISzFLYlhzTnRyK0dqcnQ0UXZ3bm9TR3JXZUdCT2x4NER0cmdxeC8w?=
 =?utf-8?B?M0Z0Uk9HV1RCWDZ4Zm1rdUcrM3o1M1RGNFFyYW5pdkJrQThWc3dxVU1HMGYz?=
 =?utf-8?B?TzAveGtoRmRjTkZpVVdPZDRSU3ZSR2pyb1NnNllxWHlXZUpSb3NJenRISnlx?=
 =?utf-8?B?cUt3OHh2RFUvNmJmNGExWGJQS09OY3Y3RThYamsxMnBSRk13b04xY3h2STUw?=
 =?utf-8?B?ZE9zQzJlaUVhakh2M0Y0cnljWkVZdjQ1SEZLbnRZSk4xUWZQQnVjaWVkbDQv?=
 =?utf-8?B?RmlhcGFCRS9INXZNT2JyUFdKWGVTSUdlaVZselZLWGZCSkxJZWtUMG9VL01y?=
 =?utf-8?B?TzNPSW9tZ0doY1g0dGxSaTFhRDJoNXVwTUhob2djbVdWZ3ZkcDNKTWJJcERa?=
 =?utf-8?B?cXdaUEw4SDBkYjBPckl5aTBnN1hGdGF3REVTcEFLM2IxN2NZZndBZlNJNTdH?=
 =?utf-8?B?VWFCYW9kUWc3VGVvbDErc1h6eFdiQll5L1RyaGFIYkgrZlZ6ZWVrRmlTZXNF?=
 =?utf-8?B?bUluVXJ0Sm11M0lnS3g3YzlsakFFTk1QYXlVMVM3cG9jb0ZndjdLNUxEZEFL?=
 =?utf-8?B?UG1iRE5GdndLV2IyMjVqaUpyWTFRbTNyVm94VEJicERJYmpvQ3hMeTc2a20y?=
 =?utf-8?B?c1IzaWdTT1REbEZYcTlVV0tpK2VxazNMSy9rVkU1OFhDQkRXNUhmM1MxUERY?=
 =?utf-8?B?dlFDdWRNQiswa1NvRXh0TS9HN3BsNGZHRjl1SkE1bEc3MzlQbVJoQVVnZDBv?=
 =?utf-8?B?ZVU3dmRIWitDYTdOSjFPKytRTkpRVU1ha3VGRE0rUWxlYlg4R3h2U0VaMjZI?=
 =?utf-8?B?SWFmckpGUGxPbDRYL0pVNVRTNm5SVFVpeTU2VWhIbmtEdW82aHRUdGRIb1dZ?=
 =?utf-8?B?L3BIcWFNbEU1bnMwMmFGNDJnbWQxRlZkYTJmU1NCS1RxajJhYWgzWlVTcUNn?=
 =?utf-8?B?NnhsMmhsaE5TdTZFM3lmLzlhVld1NitCek92aEFiLzlGTExyY2NPbGVZenBT?=
 =?utf-8?B?QzM0RWl1SUpNTkpoOTZqbXJQTTV1L2wrK091Y1cyUmJQVi82WEZ2OUpQV1JC?=
 =?utf-8?B?c1dSVDJVbTUxT3FIc1VJWWtuUnFrN3IxRkQvV0syRVk4aFVPYkpUUytTWGVZ?=
 =?utf-8?B?NFVreHd4Mjg0RHQ4NXI1dHZRUjhXNkNhN3hLKytoMjNzbktUR1lJbnFaNTUy?=
 =?utf-8?B?TG5hQ05ueG9YaURRbGVMakZ1OE9TZ0xJR2dHNFFRSHFBc25lRTA1Y3YvdUJF?=
 =?utf-8?B?SGJ4b2FRVkNIb0JpbU0zVG1BZDNmak1kRDVIbVpzMVkvRWwxVHJ1c216ZEo2?=
 =?utf-8?B?ZTFEQndjYkhUMXREYzJkNmdsbGJMdCtmTmwzb25jLzE0S0czSDFWdXBUNW9K?=
 =?utf-8?B?SlhYWU1xT3loTXhURFZETmpiWlFJN2xBd25SN0tTVTY2TWx2RzBXd0UwcW1J?=
 =?utf-8?B?MTZjeCtKcnhpTVgzZmJGZHlVQUxuM0dQT1ZFd0hUdVpqQU5LWklDdzdCbDFS?=
 =?utf-8?B?R0RtWUVOc21pM0JPeVdITlhUWU5JTHZoSzRUSDg1eXYwN3MrNld5b1dScVJx?=
 =?utf-8?B?dGVXTUtyZFI0WllYZTFqbTRoTm42T1RyNlRtNWMxNVk0UUJyek1IU2U5VG9u?=
 =?utf-8?B?TUpISjVsaXBSUldOS0lHL0l6VXVjTzRXVHQvTDJrQm45azgramRJdzYvVWlS?=
 =?utf-8?B?Y3VwUHpaK3E2T280RTREWEVmNko0bG1sL2E2ZE1Hb3lWanRRaUZjVjBVUkJt?=
 =?utf-8?B?RzI5eldyWDlJNjFqYzBxQ2J0OE5WM2dRb1k4dlJ5VWhOeTN0US9CR08rbnVZ?=
 =?utf-8?B?RUdoSUpzTkwrY2FTMExraUliTkxDbGJrQW9aWjFmT01kRTIxY0pDMGFDN0Zo?=
 =?utf-8?B?cmV6STBienl0eG84UkRqV29NdldCemN6K3NCZm84OTlBY3RHNXhZZ2tkTmlV?=
 =?utf-8?B?MjhQSGhWa2F3OVNhNEg0YzFweHR5TnJGZGozRXRXL01TU1JTN1hsK2ZZY21D?=
 =?utf-8?B?UUJWdlZCWDZBamQrRTRqQVdIamM1RFVrUXRXbTJ6SVZ1UkVuMldKSmRoeDBj?=
 =?utf-8?Q?RoSop/wba15dx5nBZZTapFA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0679.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 116efeaf-991d-4a8b-87b4-08db010a15cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2023 08:31:42.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MsfskIJXj7EDtPu6POVIC+7zcHWgm8/H5EXamsTyrRzBTFffuP6UydpmUXNduLARM8DqzS44cSnlytNmuJd4kJ58e9lWU8QYZHt8i0nudb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0057
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <8BA21B8BFE215D48AE7AB7489C9B3390@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFjb3BvDQoNCk9uIEZyaSwgMjAyMy0wMS0yNyBhdCAxODo1MCArMDEwMCwgSmFjb3BvIE1v
bmRpIHdyb3RlOg0KPiBIaSBNYXJjZWwNCj4gDQo+IE9uIEZyaSwgSmFuIDI3LCAyMDIzIGF0IDA0
OjEyOjQ0UE0gKzAxMDAsIE1hcmNlbCBaaXN3aWxlciB3cm90ZToNCj4gPiBGcm9tOiBBaXNod2Fy
eWEgS290aGFyaSA8YWlzaHdhcnlhLmtvdGhhcmlAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gSW1w
bGVtZW50IHRoZSBpbnRyb2R1Y2VkIGdldF9tYnVzX2NvbmZpZyBvcGVyYXRpb24gdG8gcmVwb3J0
IHRoZQ0KPiA+IG51bWJlciBvZiB1c2VkIGRhdGEgbGFuZXMgb24gdGhlIE1JUEkgQ1NJLTIgaW50
ZXJmYWNlLg0KPiA+IA0KPiANCj4gT1Y1NjQwIGNhbiBvcGVyYXRlIGluIHBhcmFsbGVsIG1vZGUg
dG9vLg0KDQpJIGFkbWl0LCB3ZSB0b3RhbGx5IG5lZ2xlY3RlZCB0aGlzLg0KDQo+IFlvdSBjYW4g
Y2hlY2sgaG93IGl0IGN1cnJlbnRseSBjb25maWd1cmVkIHdpdGggb3Y1NjQwX2lzX2NzaTIoKSBh
bmQNCj4gcG9wdWxhdGUgc3RydWN0IHY0bDJfbWJ1c19jb25maWcgYWNjb3JkaW5nbHkuDQoNCk1h
a2VzIHNlbnNlLiBMZXQgdXMgaW5jb3Jwb3JhdGUgdGhpcyBpbiBhIHYyLg0KDQo+IFRoYW5rcw0K
PiDCoMKgIGoNCg0KVGhhbmsgeW91IQ0KDQpDaGVlcnMNCg0KTWFyY2VsDQoNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBaXNod2FyeWEgS290aGFyaSA8YWlzaHdhcnlhLmtvdGhhcmlAdG9yYWRleC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9y
YWRleC5jb20+DQo+ID4gDQo+ID4gLS0tDQo+ID4gDQo+ID4gwqBkcml2ZXJzL21lZGlhL2kyYy9v
djU2NDAuYyB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL2kyYy9vdjU2
NDAuYyBiL2RyaXZlcnMvbWVkaWEvaTJjL292NTY0MC5jDQo+ID4gaW5kZXggZTBmOTA4YWY1ODFi
Li40MmQ0M2YwZDFlMWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9pMmMvb3Y1NjQw
LmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL2kyYy9vdjU2NDAuYw0KPiA+IEBAIC0zNzMzLDYg
KzM3MzMsMTkgQEAgc3RhdGljIGludCBvdjU2NDBfaW5pdF9jZmcoc3RydWN0IHY0bDJfc3ViZGV2
ICpzZCwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ID4gwqB9DQo+ID4gDQo+ID4g
K3N0YXRpYyBpbnQgb3Y1NjQwX2dldF9tYnVzX2NvbmZpZyhzdHJ1Y3QgdjRsMl9zdWJkZXYgKnNk
LA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IHBhZCwNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCB2NGwyX21idXNfY29uZmlnICpjZmcpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1
Y3Qgb3Y1NjQwX2RldiAqc2Vuc29yID0gdG9fb3Y1NjQwX2RldihzZCk7DQo+ID4gKw0KPiA+ICvC
oMKgwqDCoMKgwqDCoGNmZy0+dHlwZSA9IFY0TDJfTUJVU19DU0kyX0RQSFk7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgY2ZnLT5idXMubWlwaV9jc2kyLm51bV9kYXRhX2xhbmVzID0gc2Vuc29yLT5lcC5i
dXMubWlwaV9jc2kyLm51bV9kYXRhX2xhbmVzOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGNmZy0+YnVz
Lm1pcGlfY3NpMi5mbGFncyA9IDA7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiAw
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCB2NGwyX3N1YmRldl9j
b3JlX29wcyBvdjU2NDBfY29yZV9vcHMgPSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoC5sb2dfc3Rh
dHVzID0gdjRsMl9jdHJsX3N1YmRldl9sb2dfc3RhdHVzLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAu
c3Vic2NyaWJlX2V2ZW50ID0gdjRsMl9jdHJsX3N1YmRldl9zdWJzY3JpYmVfZXZlbnQsDQo+ID4g
QEAgLTM3NTMsNiArMzc2Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdjRsMl9zdWJkZXZfcGFk
X29wcyBvdjU2NDBfcGFkX29wcyA9IHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgLmdldF9zZWxlY3Rp
b24gPSBvdjU2NDBfZ2V0X3NlbGVjdGlvbiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgLmVudW1fZnJh
bWVfc2l6ZSA9IG92NTY0MF9lbnVtX2ZyYW1lX3NpemUsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoC5l
bnVtX2ZyYW1lX2ludGVydmFsID0gb3Y1NjQwX2VudW1fZnJhbWVfaW50ZXJ2YWwsDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgLmdldF9tYnVzX2NvbmZpZyA9IG92NTY0MF9nZXRfbWJ1c19jb25maWcsDQo+
ID4gwqB9Ow0KPiA+IA0KPiA+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCB2NGwyX3N1YmRldl9vcHMg
b3Y1NjQwX3N1YmRldl9vcHMgPSB7DQo+ID4gLS0NCj4gPiAyLjM2LjENCg==

