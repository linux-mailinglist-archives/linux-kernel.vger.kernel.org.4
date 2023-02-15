Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A64697F04
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBOPBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjBOPA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:00:57 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901926A60
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:00:48 -0800 (PST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2110.outbound.protection.outlook.com [104.47.11.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-56-0fPK5IkYN6273scR3pytpA-2; Wed, 15 Feb 2023 16:00:46 +0100
X-MC-Unique: 0fPK5IkYN6273scR3pytpA-2
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::14)
 by ZRAP278MB0961.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 15:00:43 +0000
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f9e:5ebd:d37b:b0cb]) by ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f9e:5ebd:d37b:b0cb%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 15:00:43 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "zhipeng.wang_1@nxp.com" <zhipeng.wang_1@nxp.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH] rtc: allow rtc_read_alarm without read_alarm callback
Thread-Topic: [PATCH] rtc: allow rtc_read_alarm without read_alarm callback
Thread-Index: AQHZQMOh4RZHTboy/km0YhrPmGl6wq7QGwQA
Date:   Wed, 15 Feb 2023 15:00:43 +0000
Message-ID: <1c631d431d134f78d72bb3c23bb692f62d67803a.camel@toradex.com>
References: <20230214222754.582582-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20230214222754.582582-1-alexandre.belloni@bootlin.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0377:EE_|ZRAP278MB0961:EE_
x-ms-office365-filtering-correlation-id: 59901c19-5432-46c1-d714-08db0f656929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: QTvBu58P6NoqWK1CS6ZxX5DhLySgCOPuqM9mm+6Iq+Nhy1BCfA1z5Va3/dzY7FvJaJ54Zh7C4qYVdyvOOwATrjuopob5VIo/V2gGB0zg9g6RsILAHdH9vnxGUfT36y23orQ6ieBCcwUpD+vgoshoRAkqUwfM/1iGmNpr4V1k76vo8jIbZhrsclKPpqxgJS/sMqgdmyTbMw4iSE2gA/1ftu2vz398HmHM0NFdz+6jk22QOUggYg/Tz5grap78XRTWX8DcC65Lyy9oF8PPkZB2Lkr1D50sIo/UkXFRPDKXQ8Uy16VSZh4hUJmUyogpvMjPbhVdVrbzSwhF4i5K6IM+wti4Ert6x0Yb19D4r6+XbWx7ro7juCeW6jRAG61zzH07b6Hb/ZGjoijhg5j0ts4YCx3zVDtLO02ZYqluytGPc86PwS0AXbMCbO4QVoSuHVApGoO0klxADmPKcK8h+fMySKV4T3feqiW3YW7xEj9S1RCprWaudmZnN+DNAb5e2UqIbtwRDKZg4wicqFFRqtD29JRDKN6ndP6/LH3NTclFFFe2i57hHsX6l3Vaf/IEsltnK9Boyx/kMcosAwXLUBmKXBpPmXJUBfo8GlBf0s3IsgDi1V53wW+6KrldiabmVmqcEg5r0DipUA73TGAS4bYgC/lghNC8tSJm10QFU/YBsAkBNpjaLDKCk+RKbvx2Oh8o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39850400004)(136003)(346002)(396003)(376002)(451199018)(316002)(6506007)(8936002)(107886003)(38100700002)(41300700001)(110136005)(76116006)(5660300002)(83380400001)(2906002)(86362001)(54906003)(478600001)(122000001)(966005)(44832011)(38070700005)(6486002)(36756003)(66946007)(6512007)(26005)(64756008)(186003)(66446008)(66556008)(66476007)(4326008)(8676002)(71200400001)(2616005);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFRKbWFFV3gzR01UbWNKWVptOStKZUs0bWxDbExhTFNhekRaMHZDcS9Ybk95?=
 =?utf-8?B?d0liaS8rVHBLcitURWxHaEhtM1VVcHJtSVFLbTl1S2dsbzVob2FvSFAwN0Nu?=
 =?utf-8?B?YjlMN1QyQ3pZNERxbTJjM0VKS2ExaEhIMnc3L2cxWlFYRGdPVm1oN2w5eXJj?=
 =?utf-8?B?aHpuY2xTNnhTMlNGbkpuelRRZGl6Qmx2T0NSMFJaYnVCL0JuTlljd2Z5N1B6?=
 =?utf-8?B?TnErRm5Na3lzZFE3eW9aNDROVlpkUkdieDJIL2oyVzZIWFl0OEVXMVRwbEY1?=
 =?utf-8?B?TkZUNitySFJoYVBVcTZpVWdZaHNZbWxvamRjblpzRnZLNjNhZHdvZGs4YUxs?=
 =?utf-8?B?SnQxOFVnaTVyZHBJNFhoRElsV211UE8yZHdZOHdPY0dZTytQaEJjakpaOE1J?=
 =?utf-8?B?N0M2aGgrK21xaHl2d08xdU14dG93NStTelR5cXVFK2FMK3JmSWdKVlBOdjlq?=
 =?utf-8?B?VTc1aXgraWE0ZWVpOW9QYzZXZWNTZ2N1UjhnaFNqd3piMVZqQ2FwbFpWTVhr?=
 =?utf-8?B?blJPUVZvUVN2SlUzUXh1YWc1azZOM1BrM2FQa2diZVFjbCswZ3VJcXpjQTZu?=
 =?utf-8?B?ZWxZcVVRek9lOEpqM3hiOUpMQXc1dWFZcEZKZHBlOGZNVFFhQXhCbHoxMDFq?=
 =?utf-8?B?T21TTWt5SVhZblZZbW4zZXNrTWpYZy9INnFiT0hUWUZoNmJObmp1L1JGNjBK?=
 =?utf-8?B?M09qcXFNVDJjYVFTVFE0aUFPbzI1bXpLQ1NWb3hTcnp5czIvVWlkc1hiN0h4?=
 =?utf-8?B?S2pUQytCR2NtUEVWN1RPT2Y5L1JUYXZtSmxBbGswdHZSczllbzdrVURIdVRX?=
 =?utf-8?B?OStJSklEaUkzcnM3VmFJZ1B3Rnoxa2Zhc0swNG1QUzhUQ2JYd04xS3Rhc01T?=
 =?utf-8?B?eTRWNHN2UFVMWEhVSEJyQmswYUJtOGtsOVlmQ2s3QTJqaFEvTEVNdnhndnpv?=
 =?utf-8?B?S215STJ6OXRYODcwR1hocjZFbzhnL2VKc2NYZE1aa0N6SWFrT1c0UTZuekNY?=
 =?utf-8?B?RXlYRmoxSlloeGJQNVRpOVJUL1BhMHo5bEUrUGhjc1pOMFdVYzc5MXYzYnQ5?=
 =?utf-8?B?OENqVUlaQ0xPUWZRUlo2UkhJMzUxTm5DY1V0TUlCK3NJUlNlb3I1eWJvd3pQ?=
 =?utf-8?B?SStKU0dXNmlJSnFHSnQ2eDRtZGp4UW9uUlNSMElJWmVKcFE5dG95L3dnbFRZ?=
 =?utf-8?B?dVJ6R1p2NnFaNEV0ZloxSHRwVjRjanJhUXg2WWJLZmR4SUEvZndBNHRnM3JX?=
 =?utf-8?B?enpnUFVRQkpHYSszVWx4QVR6L29qWm9aSHQ0aWVqOFozSGg5MmVKbzdnS2NR?=
 =?utf-8?B?WmxUdVNURmx2Wm4wN3JqUk9LSys4QUllZEZuRC8rakZPWitkdVFnclI0b3RX?=
 =?utf-8?B?cGh1aTBib3ZqSWlrTWoxTVNFd3l6SnBvRDlMU2JnWkZseHhSbitubGd1eTFj?=
 =?utf-8?B?QWdqQmZWNHJoOHU0Vm1yM2RIaEFncWwvbzFVT0UrMWpKaGE5azFRQVFoV3FO?=
 =?utf-8?B?cHQ2bWVDV2hIdmZUMmRrMlB1VHlyMmxVSnZpY0Q3RERBVGtxTjhQV3JaQjVx?=
 =?utf-8?B?SkdFdVlGL0ZSVXE1czRVWEsybmZZUHB2SmxiY0pNU3lYbXFpVE45WGFyVjEx?=
 =?utf-8?B?cncrdmFkZGZxdlhMK1NhWkttRkFGcGxIWXhLVzdpa0xSRnFmY0ZLM0d6ZnV0?=
 =?utf-8?B?dEhFcXIrTDFKdmJmSzBmQ08zNFBNaGd4Y0lqbnhkUDl2RWFHcDV1YnQxRFNV?=
 =?utf-8?B?WDZjN0pobUNsd0VGRnlCY2FyOHVMemNQVFhkK3VsSTNiUGp0bVZkTmFYWXZu?=
 =?utf-8?B?Nmd0cVp2WG51NUR0bE5XMWMrdnFHdFp1ZHc1L0ZRTElWN3FCaHRWZXJOTkZW?=
 =?utf-8?B?OWVMNWF4S2lsZFJGNWFrWVYyaFFNUkpzcERpNjdHcG1CWVdIa2kxKzFqSXBK?=
 =?utf-8?B?ZXdnRVlSR2hVc0FnNzUxSHk0R2RtNmY4cUg3SDc5alAzMVpnc0JsNDRGV1Vj?=
 =?utf-8?B?UlJYakNKNkI4MzJ6ZlJoOHlqTHBwYlZDZFJUajJZd3Y1MHFOeVdHNVhTTmZu?=
 =?utf-8?B?RFpEL1ArdTFuSEI5eHhlOG5KUjdHMzBnTVBqanhUUXMzR3VpT0JSMHE4aXRG?=
 =?utf-8?B?Q1YzU0ZxN0FDSVBQVDZxWDQxYlBIQUJyY2h1ajl1ak9peHEwdzRIRHB1QWdK?=
 =?utf-8?Q?vZvegFPvW4XohKeglkYA34I=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 59901c19-5432-46c1-d714-08db0f656929
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 15:00:43.3051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNXDlt6vj9P2iI5LtEdjrMOTp8NARiafP8ToFo+xQ/ScF1sJQXwEw76LaRKCxD7Irw73DC2Ncwpe3xsmJZTolZcJ3MOp3n3ijnnwEotlxFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0961
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <2B3D64EB5F80074387DEE257AB94AD86@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTE0IGF0IDIzOjI3ICswMTAwLCBhbGV4YW5kcmUuYmVsbG9uaUBib290
bGluLmNvbSB3cm90ZToNCj4gRnJvbTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxs
b25pQGJvb3RsaW4uY29tPg0KPiANCj4gLnJlYWRfYWxhcm0gaXMgbm90IG5lY2Vzc2FyeSB0byBy
ZWFkIHRoZSBjdXJyZW50IGFsYXJtIGJlY2F1c2UgaXQgaXMNCj4gcmVjb3JkZWQgaW4gdGhlIGFp
ZV90aW1lciBhbmQgc28gcnRjX3JlYWRfYWxhcm0oKSB3aWxsIG5ldmVyIGNhbGwNCj4gcnRjX3Jl
YWRfYWxhcm1faW50ZXJuYWwoKSB3aGljaCBpcyB0aGUgb25seSBmdW5jdGlvbiBjYWxsaW5nIHRo
ZQ0KPiBjYWxsYmFjay4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBaaGlwZW5nIFdhbmcgPHpoaXBlbmcu
d2FuZ18xQG54cC5jb20+DQo+IFJlcG9ydGVkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56
aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gRml4ZXM6IDdhZTQxMjIwZWY1OCAoInJ0YzogaW50cm9k
dWNlIGZlYXR1cmVzIGJpdGZpZWxkIikNCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIEJlbGxv
bmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0KDQpUZXN0ZWQtYnk6IFBoaWxpcHBl
IFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCg0KSSB0ZXN0ZWQgb24g
b3VyIFNvTXMgQ29saWJyaSBpTVg4WCBhbmQgQXBhbGlzIGlNWDgNCg0KSSB1c2VkIHRoZSB2YXJp
YW50cyB0aGF0IGhhZCBpLk1YIDhRWFAgYW5kIGkuTVggOFFNIHBsYWNlZC4gVGhpcyBwYXRjaA0K
ZGlkIHNvbHZlIHRoZSBwcm9ibGVtIHdlIGN1cnJlbnRseSBoYXZlLiBJIGFsc28gd2FudGVkIHRv
IG1lbnRpb24gdGhhdCBJDQpjb3VsZCBub3QgZ2V0IHRoZW0gdG8gcnVuIG9uIGEgbWFpbmxpbmUg
a2VybmVsIGluIGEgYWNjZXB0YWJsZSB0aW1lLQ0KZnJhbWUgc28gSSB0ZXN0ZWQgb24gVG9yYWRl
eCdzIGtlcm5lbCB0aGF0IGlzIGJhc2VkIG9uIE5YUCdzIEtlcm5lbC4gWzFdDQoNClsxXQ0KaHR0
cHM6Ly9naXQudG9yYWRleC5jb20vY2dpdC9saW51eC10b3JhZGV4LmdpdC9sb2cvP2g9dG9yYWRl
eF81LjE1LTIuMS54LWlteA0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvcnRjL2ludGVyZmFjZS5jIHwg
MiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRjL2ludGVyZmFjZS5jIGIvZHJpdmVycy9ydGMv
aW50ZXJmYWNlLmMNCj4gaW5kZXggN2MzMGNiM2M3NjRkLi40OTlkODkxNTBhZmMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvcnRjL2ludGVyZmFjZS5jDQo+ICsrKyBiL2RyaXZlcnMvcnRjL2ludGVy
ZmFjZS5jDQo+IEBAIC0zOTIsNyArMzkyLDcgQEAgaW50IHJ0Y19yZWFkX2FsYXJtKHN0cnVjdCBy
dGNfZGV2aWNlICpydGMsIHN0cnVjdA0KPiBydGNfd2thbHJtICphbGFybSkNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZXJyOw0KPiDCoMKgwqDCoMKgwqDCoMKgaWYg
KCFydGMtPm9wcykgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IC1F
Tk9ERVY7DQo+IC3CoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAoIXRlc3RfYml0KFJUQ19GRUFUVVJF
X0FMQVJNLCBydGMtPmZlYXR1cmVzKSB8fA0KPiAhcnRjLT5vcHMtPnJlYWRfYWxhcm0pIHsNCj4g
K8KgwqDCoMKgwqDCoMKgfSBlbHNlIGlmICghdGVzdF9iaXQoUlRDX0ZFQVRVUkVfQUxBUk0sIHJ0
Yy0+ZmVhdHVyZXMpKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0g
LUVJTlZBTDsNCj4gwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbWVtc2V0KGFsYXJtLCAwLCBzaXplb2Yoc3RydWN0IHJ0Y193a2Fscm0p
KTsNCg0K

