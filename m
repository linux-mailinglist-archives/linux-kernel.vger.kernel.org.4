Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769D1635888
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiKWJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiKWJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:58:29 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB35D236E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669197129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUzj+o+EAyS0ZvgFy1p9B19pA4EEQ455CLwNRBEOs+g=;
        b=hkhRYt6QPJm6u0zkgMwIJAzpMrgI7yGQ0k+Birvz8KgQ8UMUaSMaGgh+GO+Ccsc7k9w8Kt
        vtdL7tgwZdWbnuB73296m6PK1yd8idkPr916+y2NN+8owxuqGi2uHgvztQjQdQZXmWmEyK
        Fcl5bFJkRTSwMhJxg0JdaIUnCdAbhOK9cYJ7dHJ6nE5u28tmuLNZm0TSgJ+GXLGDcil8Ip
        HNG9WAcWpfVEdw7OCTYiMpRQSDyafvbupYH84JQxJzEwST4D3gU/Z6N/T3mBwVurrvcqlH
        kbEyh5P3WheneWKHbMbOI50S3HTEsxFp9rRQssKl7FyLS5TWIKJTHOGhdb7n+A==
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180--IsmwuDrPkSYZzWp4fMpeA-1; Wed, 23 Nov 2022 04:52:07 -0500
X-MC-Unique: -IsmwuDrPkSYZzWp4fMpeA-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by SN4PR19MB5391.namprd19.prod.outlook.com (2603:10b6:806:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Wed, 23 Nov
 2022 09:52:03 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 09:52:03 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v3 0/4] x86/of: Fix a bug in x86 arch OF support
Thread-Topic: [PATCH v3 0/4] x86/of: Fix a bug in x86 arch OF support
Thread-Index: AQHY/kRd6x7F/veGJUyUIWlGtgApL65KqhWAgAAIsICAAAcvgIAACH8AgAAgqICAAWLSAA==
Date:   Wed, 23 Nov 2022 09:52:03 +0000
Message-ID: <bd1aab73-654a-59fd-7b2b-eb3773e3c97e@maxlinear.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <Y3yTxRAVSOJTMuUu@smile.fi.intel.com>
 <a7a1b539-bd69-0227-ea93-b90f2e3ef2cd@maxlinear.com>
 <Y3yhFWQ7NHMArO74@smile.fi.intel.com>
 <fee4cf31-11be-9459-7d7b-ba8729dfb356@maxlinear.com>
 <Y3zDm1zaqpn8uMiV@smile.fi.intel.com>
In-Reply-To: <Y3zDm1zaqpn8uMiV@smile.fi.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|SN4PR19MB5391:EE_
x-ms-office365-filtering-correlation-id: 6c158370-5371-49e4-0cda-08dacd385fa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 6zjSXgdhAQjrQ1v1XisHQOW2v6zjSpPYoQJ11hb+dwtPuAX1owfAmvpHf1aXBtS5uyzp3JASWdIrcyuYdc6AQFO5pkN8FcxrKLvbjVQvyOfj2ooaUapy5/EXxSu3rXop506E9QUZ7hy8d6zIiRSsrCNi9Bg3HvO4v6qD/W2oOsgE2vQgaDNc8v8T/Vh5p7GwocljtGiNokkRqQcQIwvZsMuFEqmZfJ0ibIN4pMd3lQSC2GjBzQQOLSDQUazxGBV4VQBJ4o+yDh7Qt7gOD/wtMIVPXmfZyVTcOgnK3SfCDSqbLTzYnyZtaQQdpLuzyoqZLWv+bFUsoWRNh/DQtaFuH5l9FWkATQvA7QVcN5GG5L5eTbXAYbjaIrL+Vpzc6ZAEpCAjOtjQmaz+yxhsbcvO366wLx1oA9LJDA2Mtd+6XsSAzITkccn2/bKZ0o+ff8mHgHysSC75YsbypbJQidnLPeXdC0Vp5G1FDiQHnthz7t4LnkJYOM3q0SUDM09/1bg2b+JL5iqWb02KftMQOlTq/xBIXK/UKjrU4dQ//xmTkdOKGai+1A8Xi0prhasoxP+lrQSy0xDpGq0YVu+2cxlwQhT3tvP55aL4j8Y1xccFmKosxrh3pPkjQ+QZAb0GkAdXiP5+lIrzLBOffOLHVPj7UgygK/24L1aSn+C+EfDw43g9QxKR2DdlzYnMFu0xrhp7PMT1mRaZhOt8VIOp8F/QPWjxzccwOqgMi+nZONI9SX9YGdNfN/lNdgJ7tFXjHn2XW/fVvXljFuUMFvTULDC3vathoEjVlJV104g+y47RkbGL/1EAfKGBgbkFRf/1oFZLAIXXdEEC4hssgO0I7hQ58g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39850400004)(346002)(451199015)(31686004)(122000001)(7416002)(86362001)(31696002)(38070700005)(4326008)(2906002)(83380400001)(38100700002)(316002)(8936002)(966005)(91956017)(6916009)(66476007)(2616005)(36756003)(64756008)(478600001)(6486002)(186003)(76116006)(8676002)(26005)(66446008)(66946007)(66556008)(5660300002)(54906003)(6506007)(107886003)(6512007)(41300700001)(53546011)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGJpeFJ4V2FMT2trODF4dXZmYjhEOHMrb3hHVHZxNCtJeWlJMWpER2pET0ZD?=
 =?utf-8?B?YVkvWDVlS0hkU2VEYnlWelM0RzZaSnVQRjR4ckdsNFY3VlV0MHlCZlBlcjBT?=
 =?utf-8?B?MUhUcU1iSWdqLzlnRDdGM25tZWZFNjczWUxBWTZwQTZFUEw1VTZZa2ZndmNw?=
 =?utf-8?B?SFkxVWliMkl6azFZTjdzOFhIa3RZL3B5ZUhzei9kNEE3czdQNW5wckIwTkdk?=
 =?utf-8?B?YW85VzRyWkRwdjQ0UGxwTmhvTG45c3VkN240Rkd5Q1Y4Kzh6aXBjNWRNbVNP?=
 =?utf-8?B?QjJuaEtjU0dXMEwxYmdQcC9tYmNZN1REYjZCMG9ERGZpUWlqUzgwTjhtWVFR?=
 =?utf-8?B?c0tyeVkwbDBWZG43SU9ZUUkvNC95b3kvdURmcHlkTm5nSlZXdHhZdm1SbzNF?=
 =?utf-8?B?WnViWWN1eE5HWXE2Tk5KZFE1eGhZNlNEbUtNUElkcnA2bnh3NXFDSXRIMkNi?=
 =?utf-8?B?S0VoRkxTNVJGbTJJWUw3T3FoZ0s4OUpseElVbHFNTUhnTlArVGE4eFRIT0Rs?=
 =?utf-8?B?clZNK3Q3VjVPZUhkY2NBbjVoTUF2alVzY1hYdmN4dk1yM0trcWNGUXR5dEVN?=
 =?utf-8?B?OTNWYmloZGdUWkhKNUhqc1NKSGxja0h6czVtVExWTnI4VHY5aUs1cEo2ZFlo?=
 =?utf-8?B?bGFKTTh3aTJtQnhYai9hcVFaMEpCS2UvN1VvZzFYcG5YMmpmSE1TUFNEbkMy?=
 =?utf-8?B?YllGTXdtOGVkUnBlalBEL01xT043ZVZ2bnRxeFk5dU54QThlbUc2RFNPcHZ6?=
 =?utf-8?B?NlpTNFVsckhDUUdWMVpXSlRXQnBiTklsM3RnQnpqR0NqRmZTY1FkTjR3bXpG?=
 =?utf-8?B?aGZLRW1xcnVNVDZjN1YraVVoYTJXdjlTamhSOXZmTWZIRHdMSXoycyt1djBG?=
 =?utf-8?B?K2VxM3ZBaHVPdlJFcTNYVVkyTlN0R1pZeWN4cm0ydkVkTTBwYUxDTEMzV1RJ?=
 =?utf-8?B?RGlTeUVISmlUQlpSSWpmazZOQkFiWnVlU2Q3R3VxVXhWQTVqNUIraFRkV0pK?=
 =?utf-8?B?YmorOVIvYnVjZ3RGYWxRVFBEbDZIeWcrQXNCUkJucStrRk95NnRWZEF4K0RL?=
 =?utf-8?B?YXRkWkljN3lhYnhMTXFyNDhMK1ZabGVKUEhKOTd3K0hLR2d4NGJaMGRHQVcy?=
 =?utf-8?B?aXc1djYxT1NoaXlLUTFSOHIzQ2g0K01panozcDFxWnIya0MvRGxxOFpiellm?=
 =?utf-8?B?MWF6d2NoSzN5czdyeERLWWx0OEE1N0FrNjVIMFJUVEZZQUFJUVJZRkQ2RTRW?=
 =?utf-8?B?bzZ5ZDBiRm1ENzBZOEtZenJWeFcrbU1HcU9acXVaYk9wSGpSVzZuOG5wY2t2?=
 =?utf-8?B?c0dxMDhwb21JYVNyZGhmSHhOL1g0aGdCcjBpSmRHYTVTVnhGK3QyRVBtZEZN?=
 =?utf-8?B?eHVKQzY4cVpZcnFrYnZURnAwSjZoaUUvcGcxd0FHZGx6S3VmQisxVC9mVkNw?=
 =?utf-8?B?dlBvTG14Q1l2VTVabVNxQkRRS05PWjJwaE83TTM4Y3Q0WVl3UW5yV1VPTnFV?=
 =?utf-8?B?S1dFT1MwQkNIek50ZnJ4Y3BpR0tqZHIxK1NSbHRWQ3hiK0VIY1JyV0NlUEpp?=
 =?utf-8?B?SGsvNUM2bklUWHlUek1XaTB1RUYweXlNOERtUEpOMUdESDBXNnY1U0FhYUpu?=
 =?utf-8?B?ak1QMHhrQndHQkN0S1lvRTk2dFIrOWMwamIxVEFzMW0xR0VmMnhYcVlCb0tu?=
 =?utf-8?B?ZkZ3bVFSZ1V4U0hSdHVsQzlWbmlPenFadDQxdzdCL3Y2VldrcHZNKzE5YWky?=
 =?utf-8?B?NUF1YVhLZlp2UVZJWDMwdW5ZdlQrRkozVm9sM0l3TUxFaXQxVFd2UWxBemt0?=
 =?utf-8?B?U2ZzT3BZK3pFTG4zNkZOV2Z5dU93V0VjdCtzWlBzT1kvbmw3NG1VQjU2czVP?=
 =?utf-8?B?NXNYblBqVGFkMUs0OGtKZ0ZlMGtueW80amtDRWtObkVTR0pkQmVuMlFYWG15?=
 =?utf-8?B?T0l1a0xLQmhKZUxCUVVnQXZnRlEyN1g2Q2kyaHlKRXM0eUtvTmZYdjdIV0xU?=
 =?utf-8?B?VDR5SzZFTVF6dmxpZ0xwdWZveVVGRzNkaDJISDNHVnNJS0tpTjVYZHlkSTZX?=
 =?utf-8?B?dVp3UkxDWm1Hd2ZnaHZhSEllWDhJQ2trdk9mcWFkdTc3K1BoNC9Fa3pxY1Jq?=
 =?utf-8?B?M3dzYnhFc3IyWVd2T0V4dVdWaXZlTi9DckxhamR0eWpTVmFNNm8xVno4RVky?=
 =?utf-8?B?b2c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c158370-5371-49e4-0cda-08dacd385fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 09:52:03.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SV3nfN5lPTM7UsirfxevOdzJywEJDNl3d1YjRGCw0UKiimYfQM5bziqu+E3nsHKwMIYV0R2QmJqCotUguDNbpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR19MB5391
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <C95AD82B5258E244833F8C019C93FE0D@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMTEvMjAyMiA4OjQyIHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IFRoaXMgZW1h
aWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIE1heExpbmVhci4NCj4gDQo+IE9uIFR1ZSwgTm92
IDIyLCAyMDIyIGF0IDEwOjQ1OjEyQU0gKzAwMDAsIFJhaHVsIFRhbndhciB3cm90ZToNCj4gID4g
T24gMjIvMTEvMjAyMiA2OjE1IHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ICA+ID4gT24g
VHVlLCBOb3YgMjIsIDIwMjIgYXQgMDk6NDk6MDRBTSArMDAwMCwgUmFodWwgVGFud2FyIHdyb3Rl
Og0KPiANCj4gLi4uDQo+IA0KPiAgPiA+IEkgcmVjb21tZW5kIHRvIHV0aWxpemUgbXkgInNtYXJ0
IiBzY3JpcHQgWzFdIGZvciBzZW5kaW5nIHNlcmllcy4NCj4gID4gPiAoWW91IG1heSB0YWtlIGFu
IGlkZWEgZnJvbSBpdCBob3cgdG8gcHJlcGFyZSB0aGUgQ2MgbGlzdCBjbG9zZSB0byANCj4gcHJv
cGVyDQo+ICA+ID4gb25lKQ0KPiAgPiA+DQo+ICA+ID4gWzFdOg0KPiAgPiA+IA0KPiBodHRwczov
L2dpdGh1Yi5jb20vYW5keS1zaGV2L2hvbWUtYmluLXRvb2xzL2Jsb2IvbWFzdGVyL2dlMm1haW50
YWluZXIuc2ggDQo+IDxodHRwczovL2dpdGh1Yi5jb20vYW5keS1zaGV2L2hvbWUtYmluLXRvb2xz
L2Jsb2IvbWFzdGVyL2dlMm1haW50YWluZXIuc2g+DQo+ICA+DQo+ICA+IEFncmVlIG9uIHRoZSBD
YyBsaXN0IGJlaW5nIHdyb25nLiBUaGFua3MgZm9yIHRoZSBzY3JpcHQuDQo+ICA+DQo+ICA+IFF1
aXRlIHVzZWZ1bC4gQ291bGQgbm90IHVuZGVyc3RhbmQgaG93IHRoZSBzY3JpcHQgd29ya3MgZm9y
IG11bHRpcGxlDQo+ICA+IGNvbW1pdHMgd2hlbiB5b3UgdGFrZSBjb3VudCAmIHZlcnNpb24gYXMg
aW5wdXRzLg0KPiANCj4gSXQgc3RhcnRzIGZyb20gdGhlIGNvbW1pdCA8Q09NTUlUX0hBU0g+fiRj
b3VudCBhbmQgZ29lcyB1cC4gU28gaXQncyANCj4gYmFzaWNhbGx5DQo+IGRlcHRoIGZyb20gdGhl
IGdpdmVuIGNvbW1pdCAoPENPTU1JVF9IQVNIPikuDQo+IA0KPiAgPiBBbHNvLCB3aGVyZSBkb2Vz
IGl0DQo+ICA+IGNyZWF0ZSBwYXRjaGVzIChmb3JtYXQtcGF0Y2gpPyBJdCBzZWVtcyB0byBnZXQg
c3VpdGFibGUgdG8gJiBjYyBsaXN0ICYNCj4gID4gc2VuZCBlbWFpbHMgdG8gdGhlbS4gQW5kIHRo
ZSBpbnB1dCBpcyBDT01NSVRfSEFTSC4gSG93IGRvIGkgdXNlIGl0IGZvciBhDQo+ICA+IHNlcmll
cyB3aXRoIG11bHRpcGxlIGNvbW1pdHMgJiBkbyBpIGhhdmUgdG8gY3JlYXRlIHBhdGNoZXMgb24g
bXkgb3duPw0KPiANCj4gSXQgY3JlYXRlcyBwYXRjaGVzIGF1dG9tYXRpY2FsbHkgaW4gdGhlIHNh
bWUgd2FzIGFzIGl0J3MgZG9uZSBieQ0KPiBgZ2l0IGZvcm1hdC1wYXRjaGAuIFRoYXQncyB3aHkg
aXQgYWNjZXB0cyBhIGxvdCBvZiB0aGUgcGFyYW1ldGVycw0KPiB3aGljaCB5b3UgdXN1YWxseSBh
ZGQgdGhlcmUuDQo+IA0KPiBUeXBpY2FsIHVzZSBmb3IgdGhlIHNlcmllcyBpcw0KPiANCj4gZ2Uy
bWFpbnRhaW5lci5zaCAtdiAxIC1jIDQgSEVBRH4wIC0tYW5ub3RhdGUgLS1jb3Zlci1sZXR0ZXIN
Cj4gDQo+IE5vdGUsIHRoYXQgeW91ciBlZGl0b3Igc2hvdWxkIGJlIGFibGUgdG8gaGFuZGxlIHNl
dmVyYWwgZmlsZXMgdG8gZWRpdA0KPiAoZS5nLiB2aW0gc3VwcG9ydHMgdGhhdCBtb2RlKS4NCj4g
DQoNCg0KVGhlIHNjcmlwdCB3b3JrZWQgbGlrZSBhIGNoYXJtLiBWZXJ5IHVzZWZ1bC4gVGhhbmtz
LiBCdXQgaSBtaXNzZWQgdG8gQ0MgDQp5b3Ugd2hpbGUgdXNpbmcgdGhlIHNjcmlwdC4gSSBoYXZl
IGFkZHJlc3NlZCBhbGwgeW91ciBjb25jZXJucyBhbmQgDQphbHJlYWR5IHNlbnQgdjQuIFJlcXVl
c3QgdG8gcGxlYXNlIHJldmlldyB0aGUgc2VyaWVzIHN0YXJ0aW5nIGZyb20gYmVsb3cgDQpsaW5r
Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIxMTIzMDkzODIwLjIxMTYxLTEtcnRh
bndhckBtYXhsaW5lYXIuY29tLw0KDQpSZWdhcmRzLA0KUmFodWwNCg0KPiAtLSANCj4gV2l0aCBC
ZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCg0K

