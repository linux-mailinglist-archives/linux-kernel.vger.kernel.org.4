Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3990D67F798
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjA1Lg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjA1Lg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:36:56 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974EA233D5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:36:54 -0800 (PST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-45-RPge0YyBO_S7MTqLnGEODA-2; Sat, 28 Jan 2023 12:36:52 +0100
X-MC-Unique: RPge0YyBO_S7MTqLnGEODA-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:23::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.30; Sat, 28 Jan 2023 11:36:49 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.6043.030; Sat, 28 Jan 2023
 11:36:49 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1] media: i2c: ov5640: Implement get_mbus_config
Thread-Topic: [PATCH v1] media: i2c: ov5640: Implement get_mbus_config
Thread-Index: AQHZMmHdndevyaNkN0qwnSx3com1K66yis2AgAAMUICAAR26gA==
Date:   Sat, 28 Jan 2023 11:36:49 +0000
Message-ID: <b851143625401cac631b099e1b496bc726e19e4d.camel@toradex.com>
References: <20230127151245.46732-1-marcel@ziswiler.com>
         <20230127175003.6ofmfaqovbqu54hg@uno.localdomain>
         <Y9QZH2/jDbFbew2D@pendragon.ideasonboard.com>
In-Reply-To: <Y9QZH2/jDbFbew2D@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0117:EE_
x-ms-office365-filtering-correlation-id: 7044cd9a-46f6-47c7-c8ff-08db0123f1b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: +nsC9fV9n4824BXNc0/uKcjl/Nqs9NB0Goupohc2UQYpUEvQaiAfcl+nwBQ0WycHXM/Hd82m90POkZjTmWSDuf3A3iVWVSZ7gq3XMU8e4Eu7itgYCb8Wpz5oEGtMWv9ZNouIIGgb8zeqyXEs3v3gqmAj+HEu7Qk15RlZu05GanQDdN2qRYmxeGfAlUzL2JdlE21qwwGKsI0eIEdN4B1vO6P4WlDVzLfFvioe3G14YXyaxmUxWTTl28vUkJ7+eJxt+llDux/kt3plRdwCz3VJrnByNJP7f8bpHnljO7FSMEmWKjpaaMCsA5T5H/ZcJfW4pYUmQyXiHJpEjIYiWjTdBE2rhkKj6/M//5zs0FwP13pQRRY66ns3jARNrhF4WhbLc/wWmQIzs3ca38a59cCIL/ClYKMtGJagXDkYHwNfLBZjdMGYVKDOW19baUhFB2oIhBfDpY8srWVgfanieH36g8OxAUzBCJCmlmPX3Bihcd5aOxwQkXBzcHV7S6m/d8j2fGQJdzQNT8XrBpeP8P10uEzm8FTDqTxzmOqU1TYZGRU9Au+sCdiMFnrinE1z7DQmvf+036OJ9N5N2KwS1wGojxJ+qAsxyP2D2aK54NeABPY7Xpd5pUC1UPfpeql35IkIn+jM3TKKUGfOvGC+NtZhFc7icRT8Ygf6GW+JZS4oE0pgwOqVJ8GDYy8TFb1QG+SoGVLBAchpT+1Qnj6T4VV5/NLBuIZODb3r5k3NJQz7m0A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(39840400004)(396003)(136003)(451199018)(966005)(478600001)(6486002)(71200400001)(86362001)(38070700005)(122000001)(38100700002)(26005)(186003)(6512007)(2616005)(36756003)(6506007)(110136005)(54906003)(5660300002)(44832011)(64756008)(8676002)(4326008)(316002)(66446008)(76116006)(66476007)(66556008)(66946007)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU9qUnJLRnl3OU1NejIrMzcvMlVzazdaNWxkRXpYN01YemRrK2dPVGNBbTJO?=
 =?utf-8?B?S1dOcVQ3Q0ppRmxyTFdtUHNZSFFiYWl2ck9uRnNYM0MvSmNxN29udlIzb0sw?=
 =?utf-8?B?MUpuYXFnT3FmTEhUOExBOER0Wks1TXVGUktkaGhHK3daNFNqZU1tdlI4dGtV?=
 =?utf-8?B?Vzl3TXdDODNYcU5MUVNXbzR3ckwrdGRoWkYyQlNNTGtpa29YYjdpd3dGaW0x?=
 =?utf-8?B?Y2hQVG95S2RRZ0JId2Q3Mmg4UXRuVjRzdVV1U1Fna3hrRVpvc2xLbGQwbXVR?=
 =?utf-8?B?b0tBMk93QXdpZHBzZEdLT0dDcUMvVHpHbWhLQXl3UjFRTGR2cUVhMzd6M1Rp?=
 =?utf-8?B?NUI3VTNiVWNETEVpcmp5TEIxWWRsL2VVS0ttYU90NkhJL2tZRzVCRDMxUnJs?=
 =?utf-8?B?b3dleDZmUkRwbVF2d3lJemgwYzBHR1UvcDJxSDdUYVFDTnhnS2FHdGtqWWda?=
 =?utf-8?B?UXU1bWYyTVpJb0xpY2daaU1YeVF1RVhkZXlaTlVaa3NZRm1VZ0dQb3lOYlFo?=
 =?utf-8?B?S2VKTm9nRDFLR0xmVkc2ODQrQ003ODM1WE5JcGp1a3QzZFUxYm0yTmtua0VW?=
 =?utf-8?B?YTl6Y0NXSFdaMjdNbkp2R05ydncxMVpQcUVNRGZzaW1FMlVZRFJ4dC9TcXNL?=
 =?utf-8?B?cWgwSmJRZm0vNnZUbzk1MlZiUFk5WGVrUmJVMXJxZU9abjI3Q3dhNE4wVTM2?=
 =?utf-8?B?OTVwS2RiR1QzaUpncU1ZeVdXMWhVVTFSL0pUVTNqUjZURnFvSndnSHBoOWtF?=
 =?utf-8?B?NjJYYllqeXROa3p3Um41T1o4ZTUxN0c4cnVwR1BneTFVdHBZRVNwLzgvbVR6?=
 =?utf-8?B?Wm5iYTlaSkExM1ozRjFJYTlHK21ZRnNkNGRybXJPSk4vR0s2MU1ZbklZekxE?=
 =?utf-8?B?RjV6QThZMkRUN0t1QUNCNHBFNUFHcVBMZWRkeWFESVZKV085aXFMMVl0a2I4?=
 =?utf-8?B?N0UvMTJEUkJ1S21jQzlDbzd1eHVCcGVJaWlPbmJQS3NDNG0zTlp2TjI0R1d5?=
 =?utf-8?B?bFpNSGhPOWZlWXhxd0c3RWlZMTBHcnl3MVlXRkpnZWc5WC8vbW9wam9LOUt6?=
 =?utf-8?B?WWdLanJkYmJrVUFCTk9yUEpTZ2ZJck56SFh1SGYvcjcxbnQ5ZFB1Qnh5N01z?=
 =?utf-8?B?M1dJN3p0V2hZRkcvVG1qekdOR2xxT2lrWm96cENiblo0cldTdkxQM3p0Q2RZ?=
 =?utf-8?B?ZjBTTk8rdzdINGE2RGNsd1FiSGFoVTMrRDNjdURubjNqWXpGSXlxY2NVaUQy?=
 =?utf-8?B?RzhGcTVmY2JPTTNVYzJHMVNML1ZqbGx2RzQrSktQMTcxcmpHUWhLNGxoNElZ?=
 =?utf-8?B?UDhhV3dQRzRLMDNjejlSL1VMbzBzdng0YXhISlNBUTBSS0NRakRXK0lraTVs?=
 =?utf-8?B?UVJFQzQrbXpxbDBycmhVVEFSd1dlUGtZVjRMOGZnSlRIc2UwbFlnejJxU3JF?=
 =?utf-8?B?RVN3MVlVR2NteHkzdGZYWHBaN2pieWdWWURiRjdvVHQxUnRURHdreG54TERD?=
 =?utf-8?B?ZXVkczBTMU9nKzFSZ1k2TWxPUmxXaXh5T0hjK2h4dk5URDdRWlZVSnNsYlhZ?=
 =?utf-8?B?Z3QxS3A1RXEyLy9WV0xWaDdUcmpyT2tYN2ZsZzNWcU1uQzR0WmpzZFFYQ3Jp?=
 =?utf-8?B?TlpvVEV0Y1lMcC84N3hYK3B6Z1NDNzI0M280REd0L2xacTRSOCtFWGNjVE4y?=
 =?utf-8?B?eFlncXZybXRxYWc3aUYxMFphVU1LOTJ1MGpoU0RuRG0wRkxObHpQbWlJcEdQ?=
 =?utf-8?B?T3NoYXVDOWJLYldBTTF2MUxZVFdEV3NxMkY4aFJXRXhXeTNiSHlFTFNYVUZY?=
 =?utf-8?B?eHM0OWNOWEMydjlxR1orVnRHZDR3YVAzVTg4U0Z3TXlZMGgzbXg4UjVicTNu?=
 =?utf-8?B?TVRIMFZLcXM2MTB4dkZEWGk4eUNISmx5bDRJQWt2cXRlVGFtTXhoejJ2UlE3?=
 =?utf-8?B?dDhrMktMYy8rczRsdm1DamVlOU1GVThld2dJdFMzUTBLUE5xL3NRNkVnTmkw?=
 =?utf-8?B?S0RnSEY1L0pkZldONElsb3pWWWVjVGsvL1JuVFJKbHRuWk9XSXRFQXYvRThm?=
 =?utf-8?B?dDVEaUJnbi9FSmxQc0svQjZpYmYrbTRyTHRLTUNYTERSbHMzMFJmRDJjUnp3?=
 =?utf-8?B?aDluSUpxV0hmbjN4MEJaajlTQXFJbFZOV3NScDJZTkN5emlsM2kwSTBtTWVW?=
 =?utf-8?Q?MYFu4pFxcszkRGDrVa9ACF0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7044cd9a-46f6-47c7-c8ff-08db0123f1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2023 11:36:49.3475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSeDN+ErvozOcVPcO21RkTW1hHoPVG4UONS0mTu8b+i6xswvW4v23PXICZMCmXDwbHktvEHkAVsUk6Vsj6u1JZGn9NkTu+N+mPgNV4dWVhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0117
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <678EBE12FCD66945B2C7E1AC47D062E7@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudA0KDQpPbiBGcmksIDIwMjMtMDEtMjcgYXQgMjA6MzQgKzAyMDAsIExhdXJlbnQg
UGluY2hhcnQgd3JvdGU6DQo+IE9uIEZyaSwgSmFuIDI3LCAyMDIzIGF0IDA2OjUwOjAzUE0gKzAx
MDAsIEphY29wbyBNb25kaSB3cm90ZToNCj4gPiBPbiBGcmksIEphbiAyNywgMjAyMyBhdCAwNDox
Mjo0NFBNICswMTAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4gPiBGcm9tOiBBaXNod2Fy
eWEgS290aGFyaSA8YWlzaHdhcnlhLmtvdGhhcmlAdG9yYWRleC5jb20+DQo+ID4gPiANCj4gPiA+
IEltcGxlbWVudCB0aGUgaW50cm9kdWNlZCBnZXRfbWJ1c19jb25maWcgb3BlcmF0aW9uIHRvIHJl
cG9ydCB0aGUNCj4gPiA+IG51bWJlciBvZiB1c2VkIGRhdGEgbGFuZXMgb24gdGhlIE1JUEkgQ1NJ
LTIgaW50ZXJmYWNlLg0KPiA+ID4gDQo+ID4gDQo+ID4gT1Y1NjQwIGNhbiBvcGVyYXRlIGluIHBh
cmFsbGVsIG1vZGUgdG9vLg0KPiA+IA0KPiA+IFlvdSBjYW4gY2hlY2sgaG93IGl0IGN1cnJlbnRs
eSBjb25maWd1cmVkIHdpdGggb3Y1NjQwX2lzX2NzaTIoKSBhbmQNCj4gPiBwb3B1bGF0ZSBzdHJ1
Y3QgdjRsMl9tYnVzX2NvbmZpZyBhY2NvcmRpbmdseS4NCj4gDQo+IEknbSBhbHNvIHdvbmRlcmlu
ZyB3aGljaCBDU0ktMiByZWNlaXZlciBuZWVkcyAuZ2V0X21idXNfY29uZmlnKCkgZm9yIHRoZQ0K
PiBvdjU2NDAuIFRoZSBudW1iZXIgb2YgbGFuZXMgaXMgdXN1YWxseSBzcGVjaWZpZWQgaW4gRFQs
IG9uIGJvdGggc2lkZXMgb2YNCj4gdGhlIGxpbmsuIEl0J3Mgb25seSB3aGVuIHNlbGVjdGluZyBh
IG51bWJlciBvZiBsYW5lcyBkeW5hbWljYWxseSBhdA0KPiBydW50aW1lIHRoYXQgLmdldF9tYnVz
X2NvbmZpZygpIGlzIG5lZWRlZC4NCg0KUmVtZW1iZXIsIHRoaXMgaXMgb24gQXBhbGlzIGlNWDYg
d2hlcmUgd2UgZG8gYW5kIGFsd2F5cyBkaWQgc3BlY2lmeSB0aGUgbGFuZXMgb24gYm90aCBzaWRl
cyBvZiB0aGUgbGluayAoWzFdLA0KWzJdKSBvciBhcmUgd2UgbWlzc2luZyBhbnl0aGluZyBlbHNl
IGluIHRoYXQgcmVzcGVjdD8NCg0KRmFjdCBpcywgdGhhdCB3aXRoIHRoaXMgcGF0Y2ggKGFuZCB0
aGUgdHdvIGZyb20gSGFucyBbM10sIFs0XSkgYWxsIHN0YXJ0cyB3b3JraW5nIGFnYWluLiBTbyBp
dCByZWFsbHkgc2VlbXMNCnJlcXVpcmVkLg0KDQpbMV0NCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZxZGwtYXBhbGlzLmR0c2kjbjcxMA0KWzJdDQpodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9h
cmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWFwYWxpcy5kdHNpI243NTUNClszXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvNjk2MjRjNTQtN2NiZC03MzYyLWM0NjgtZjhmZmVhOTYxNGJlQHhz
NGFsbC5ubC8NCls0XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYzEyY2ZjYzUtMWQ0Ni03
YjVmLTRhMjctZjRjZDUyYTFiODg1QHhzNGFsbC5ubC8NCg0KQ2hlZXJzDQoNCk1hcmNlbA0KDQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBBaXNod2FyeWEgS290aGFyaSA8YWlzaHdhcnlhLmtvdGhhcmlA
dG9yYWRleC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNl
bC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiANCj4gPiA+
IMKgZHJpdmVycy9tZWRpYS9pMmMvb3Y1NjQwLmMgfCAxNCArKysrKysrKysrKysrKw0KPiA+ID4g
wqAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tZWRpYS9pMmMvb3Y1NjQwLmMgYi9kcml2ZXJzL21lZGlhL2kyYy9vdjU2
NDAuYw0KPiA+ID4gaW5kZXggZTBmOTA4YWY1ODFiLi40MmQ0M2YwZDFlMWMgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9kcml2ZXJzL21lZGlhL2kyYy9vdjU2NDAuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9t
ZWRpYS9pMmMvb3Y1NjQwLmMNCj4gPiA+IEBAIC0zNzMzLDYgKzM3MzMsMTkgQEAgc3RhdGljIGlu
dCBvdjU2NDBfaW5pdF9jZmcoc3RydWN0IHY0bDJfc3ViZGV2ICpzZCwNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gMDsNCj4gPiA+IMKgfQ0KPiA+ID4gDQo+ID4gPiArc3RhdGljIGludCBv
djU2NDBfZ2V0X21idXNfY29uZmlnKHN0cnVjdCB2NGwyX3N1YmRldiAqc2QsDQo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHVuc2lnbmVkIGludCBwYWQsDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2NGwyX21i
dXNfY29uZmlnICpjZmcpDQo+ID4gPiArew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG92
NTY0MF9kZXYgKnNlbnNvciA9IHRvX292NTY0MF9kZXYoc2QpOw0KPiA+ID4gKw0KPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgY2ZnLT50eXBlID0gVjRMMl9NQlVTX0NTSTJfRFBIWTsNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoGNmZy0+YnVzLm1pcGlfY3NpMi5udW1fZGF0YV9sYW5lcyA9IHNlbnNvci0+ZXAu
YnVzLm1pcGlfY3NpMi5udW1fZGF0YV9sYW5lczsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGNmZy0+
YnVzLm1pcGlfY3NpMi5mbGFncyA9IDA7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gMDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
djRsMl9zdWJkZXZfY29yZV9vcHMgb3Y1NjQwX2NvcmVfb3BzID0gew0KPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoC5sb2dfc3RhdHVzID0gdjRsMl9jdHJsX3N1YmRldl9sb2dfc3RhdHVzLA0KPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoC5zdWJzY3JpYmVfZXZlbnQgPSB2NGwyX2N0cmxfc3ViZGV2X3N1YnNj
cmliZV9ldmVudCwNCj4gPiA+IEBAIC0zNzUzLDYgKzM3NjYsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHY0bDJfc3ViZGV2X3BhZF9vcHMgb3Y1NjQwX3BhZF9vcHMgPSB7DQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgLmdldF9zZWxlY3Rpb24gPSBvdjU2NDBfZ2V0X3NlbGVjdGlvbiwNCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqAuZW51bV9mcmFtZV9zaXplID0gb3Y1NjQwX2VudW1fZnJhbWVfc2l6ZSwN
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAuZW51bV9mcmFtZV9pbnRlcnZhbCA9IG92NTY0MF9lbnVt
X2ZyYW1lX2ludGVydmFsLA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgLmdldF9tYnVzX2NvbmZpZyA9
IG92NTY0MF9nZXRfbWJ1c19jb25maWcsDQo+ID4gPiDCoH07DQo+ID4gPiANCj4gPiA+IMKgc3Rh
dGljIGNvbnN0IHN0cnVjdCB2NGwyX3N1YmRldl9vcHMgb3Y1NjQwX3N1YmRldl9vcHMgPSB7DQo=

