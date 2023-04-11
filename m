Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D586DD56C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjDKI2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjDKI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:27:51 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2134.outbound.protection.outlook.com [40.107.135.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35053A8B;
        Tue, 11 Apr 2023 01:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkeB4JWg+q9WWcy2Pzd7H110tYKx8xKY462g0KUYx+q32goElQelYaAXhvp0GNlM3DY4HCYnAxl92/WWOLGypcfcYAUVmVX9iYn5E8ZVxYRHtgmb5JXpGFGae4zM9aeezv9n34yYKVagfXRDtBcM/MNuTttMG2sgSQMKKTnWfvrO3xFWVoLwd0uZjVOqwvSvHohptFdEbseD+d15flMRwA3Y9qb7gFq+4ZZnc4Bk0Z2YYNWaE0BIKszfffSG3MvJy1Nm8qLI1/lr1q0bflDeND2410hsx39qaRsmUqLPL8EK+LtQMfYTJHLk1Er2WZheIqomeScbtBNuoEcO+jVLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsYt5WXRK464KkvdIERK8oWZZqjzhtASWKNZvd8XxC0=;
 b=BE3ZgZUqWHa0mbnKdYcpLdo27FOLFDaXsvVpfzrf6leQytqDflyrSWVz/orlaecX93s18KlUPAcaqmMq5iTTkMqYE70pTCcpa85q19A/jw+Nv8s96oGc7k8xAQQnCgJ0qIqJtbCERa3uVx4u69LO30VLahYwF7gMK33G/e1xBXcZ70BsPF4wBU3TFIuZCXT5gpcTIYsPlDlBN08apu7dkfYqDGxjAKz/Jh5yhwhi/49XVTfFBw2YHwJvhtzdI39/3YsS/+S4tMP3UGNPSQ/HgmTkECZDp0NjrXYWCdyS9aD6kHbuVDkPdX+IJrotWz8zW1jt+tB+13b4pv3gj1ACKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsYt5WXRK464KkvdIERK8oWZZqjzhtASWKNZvd8XxC0=;
 b=yx7kcE7VS3hL7xcR6sCDaECWokUIx4yUvPRv2am20yefnC+yxPP7S85kcV+lDP2sEwKCfq+FI85Bf8CHzg7+bHMwTUYBCMAqLa9hgwtT7HKZ+2h1mg7ne3W6iKlj0cI33vtQpBllQng6nZV6AEpI+Npd0z0BA0CQvOmgovTLABc=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FRYP281MB2937.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 08:27:08 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f%5]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 08:27:08 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: add documentation for iio_chan_info_enum
Thread-Topic: [PATCH v2 2/3] iio: add documentation for iio_chan_info_enum
Thread-Index: AQHZSSDa8osVzGs6P06SESy5KAyK4a8heAWAgASUh4A=
Date:   Tue, 11 Apr 2023 08:27:08 +0000
Message-ID: <64ab56d2-7d67-4432-6c81-1d63b41811d6@fi.rohmeurope.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
 <884c8f386541ac572939b8993df7aea6ad99613b.1677331779.git.mazziesaccount@gmail.com>
 <20230408113029.35429440@jic23-huawei>
In-Reply-To: <20230408113029.35429440@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FRYP281MB2937:EE_
x-ms-office365-filtering-correlation-id: 716010f7-81aa-4f17-cfd3-08db3a668a46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iv1fJgdYFMprPjPVePHV9PFtc/Q+//BmUAKkX+2PK8BloUKcuapWTQPb9s7BORJyDrchrcrK9CPKEThrYSMSGmblVWrLKy/Wk1jExnjPRO7FbnRACfexfuQtwDIvu3gEVqfLIg8NuJ+70UJuFw3kB3WiRe1pNHG2lyhpg+Gz5GiTnFfsB/uyzCeJ20n5lgYLML6V/ituluoz0Yg5Hxo1CrNoHDIKZJIgAadx8BrDKfRD5vdZuDSyzybWZALftmkLEO3q95pJBGmnT5Ze1NHYQSrSqVIIapOIsJc8KnU5hfgY1eQYimHqafjVV//LMT5Netoj6Y+thy6ldmr3RrwgC42l4JzcjgFw+DprMdXlIQcYCgr8zoeDutWF1BQcIQeZQZ/IJ81h3VcDoMzM2Hua9yYbP1eXsHowTSpNtbPplQyCRVp0MRo6pDpKczWKW68v2Ii/2O8vJagJTcMQ8+KXd5/RqGxoAkQlInfRH1HJlNfImqibC6QYC7QQU0h7nLc9o01+EYpfCAnmVf5g4iAGkBX6w2EtPYOAjfcNB5/dGZS5Uu7jH+0JZ7XDr2f3HjxKVNkVMHOBbo74+xwy4bMFZh9+m++gzUkgZkDd5IFcycOc82PSFChYkWTCxJXpmtyJHjxZEzlp7RQpvGT27orxzoFgYUxapG8IWJwE3Y/OoIuvWwYyRLr7D1YtTqVCmMzt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39850400004)(136003)(451199021)(71200400001)(478600001)(6512007)(316002)(110136005)(53546011)(6506007)(186003)(54906003)(6486002)(91956017)(2906002)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(66476007)(64756008)(8936002)(66556008)(38100700002)(122000001)(31696002)(66574015)(86362001)(83380400001)(2616005)(38070700005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alhTQThhZHBRc1FlamNEekIxWWVGMmFJN3kwYVNFRFRNVm12bUJDK3Njb0JM?=
 =?utf-8?B?Rzd5VjNFRXB5cWVyMWNEcHhCck9iOE9SNVdsS1JvSWJiMndtZzdXWWVNcnQ5?=
 =?utf-8?B?eXJ5TlFVbnJ1elhQYjBGdE5uaGtFaHA5YjBMK2Q1cGp0YWE0eTJzcEF6YzR5?=
 =?utf-8?B?aUI5cVdhTjlnbXpjU3Q2ekdNSEI3TGF6TnN5SlBidkdNMjY4R1h1cHlHQzVN?=
 =?utf-8?B?dm9MY2NJbTJBSVZZandYQ2tUajRjdkJMUVQzV3VkNndXUG5qRG1Mc2VLQ1J4?=
 =?utf-8?B?ckl3SG81cDkxQVJVUUNDNGk0clgwcVBMakIxaVdYUmE2WTQ1Sk12dXo4Q3NE?=
 =?utf-8?B?a0dLays4cnlTcE9wT21LVjFhVnk4VTBIMkQ1YVRzanFYZDNsYnJObEIrWHQy?=
 =?utf-8?B?c0ZQYmtDTjdNNjhhdXk1QVFnWE1ZbTR2TUw2enpjMGcwN09wSjR4MC9obzF6?=
 =?utf-8?B?L3NMbjZOUmIra09PVTREcUsvWXNMWWxicjNSUStQc3c5RC9tUkRCT1czYTlX?=
 =?utf-8?B?V2Y5ekR6cGI4VVZWWndIZTdlcUE3NzJrN1RRR3g5N0x0V3Q4VnBCZ2ZPTDZB?=
 =?utf-8?B?MjVnUVVIem5rS0RodVFkcmF6UmxOdW5QNFZXWHgvL0daRWFvbDhCdjdpNEp0?=
 =?utf-8?B?TkFlNmdMRFg4UDg0dXY3TDlrb3JQc3hPb1U1ejVUNzBGY21mWHFmRDNheVYw?=
 =?utf-8?B?UE00WDNaQ3Y0RkFRdExHWDlmZFlHQWpzY1dtbUI2cXN6WEpRRWVrbjdrZlRO?=
 =?utf-8?B?U2I2QkJraVk4V29QMnMrS3lxVnp2dnRBUlB4R1pFNStVeTdhVmpSZGN6UmFE?=
 =?utf-8?B?TmFaWmp1SnhSSW1kN0tRbGpKcDNaWVFhcHV1eGkwNS9Mdjc0bzhsQXBETTRn?=
 =?utf-8?B?UFNGbzBqNmg1VEEwdGRHYS9qd01PTVNhRWVFK0FQb0tpUU5sL29WNkRNUThE?=
 =?utf-8?B?cDVnRTBZakFla09Va2drQ2NndGozc1ZvWUl4SFlOOVlMQTVXR0Q5emZiZEJh?=
 =?utf-8?B?MUtrTGxtdHl5aHBrSFdyemhiV0hicEhiM2lMWEVNOHFxZWFORUtJSHVVODQ4?=
 =?utf-8?B?Rjl4cGdyTGV2ZFJocEVvemdUWFBac3pHTkxtM0pVeFdja09XSjZIL2szS2Rn?=
 =?utf-8?B?NzZ1d0ZFbjBHQlNQUDdmK0h1Nm5hdFRBT2tPdFltajBPNldBRkxyT3RvN3Bs?=
 =?utf-8?B?OXNIc3BqSWExSU5Rc2YrWXorUEtWZGNQYjRLKzlwWHhKQXRSRXcraHVENkdj?=
 =?utf-8?B?OUt5VXdUWDdNai9kcURkZFMvVVhNdUtxNzQ3ZFRyV0lHTXlSZTkzZ2tPMHBQ?=
 =?utf-8?B?WFlKSkI5SkxvcEN2ZGY1QVJnRDl6RTdTYmVxSkp2aGdXbVNmWXdqYUhxK05E?=
 =?utf-8?B?UG1QQjREaXIvY2hVSVhtS05OTW9oM25Sd0hZaVp2eUJxekJkZEkyYkdBbVZw?=
 =?utf-8?B?c1RsZVQwM1lMVHAxODhkVkJYZWFVSHliVWJlQ0MrRmdyUS9qYWg4bWg3d1BI?=
 =?utf-8?B?YStiTi92bkxTekdjc2VSaHRIbERPVXFJZWIyOGhFNU1LOG5Kd1ZkOG8zeFpX?=
 =?utf-8?B?R1d3V1RCSVUvbkN0Mit2RmEyUlpYVEtxdmR1aUpCQ2pUUEtIU1NLSHpjNFds?=
 =?utf-8?B?YVBHSXpMMFFGbTdDRlcxRjJtNUhCMUVWcG1QTHhuK3FJdEUzV3BoeVRuNlVj?=
 =?utf-8?B?ZFhwc2Z5MTAyK2czV2MvNnA0ZXo5OW83YkU0Y2N4U01JdGNVNWtjMkxwazNM?=
 =?utf-8?B?QVl4WTRxTTFraFJuZC9RK2xid3lGV3lQZWh1TG1ISjZZeHBXdDZDM055aDB0?=
 =?utf-8?B?YkpDVmRWbjd0Wkp5WDB0SjFJK0JEa0NnNDdnTjV2aFFkSDR0MWdmZ0FmQXRT?=
 =?utf-8?B?eThZMEdIczU3UVg3WE5LaVZwSVhubWppRitVcFI3Y0h5Q1Y1cXN1ZU1DcXJC?=
 =?utf-8?B?b3ltUnlvOVpLZG1GdzEyTFJWd2ZmQWhLNFdOU0pNcjVKczNiTHhRL1pLeU9G?=
 =?utf-8?B?dmprc0dBSTFqanVXS3pac1dTd3d3VFlQWFJGbHQvOHRnYVM5aVFsRFNDNHVP?=
 =?utf-8?B?VjlRaW9nYW9KcDRmc3FLczlNVFJIWEMzaTljTGlSMy9oYWMzVS93ZGRlZDNv?=
 =?utf-8?B?Y1lUNHZjbUhERXVONGZWV1FVS2lyT2FzS2s4WEtNTy9rYU1mcVBVTmQvTEZP?=
 =?utf-8?Q?eepq2BM0Rxi2UgWZ2WliId4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <091D2F4A2AA71C488F168BDD816CC207@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 716010f7-81aa-4f17-cfd3-08db3a668a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 08:27:08.3960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8RTYU2QobZF29g759fnplczWupWMTa5COM4axvPcpoS59I2AQ1iRbeJZHX3IjQNn8InrjuWFLl0DOkOqT+mGlW9IuTovvymThOarRdkOM2q/tqs6KwSnd1/dy440mOS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2937
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzIzIDEzOjMwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiBPbiBTYXQsIDI1IEZl
YiAyMDIzIDE1OjU1OjI1ICswMjAwDQo+IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2FjY291bnRA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+PiBWYWx1ZXMgaW4gdGhlIGlpb19jaGFuX2luZm9fZW51
bSBhcmUgY3J1Y2lhbCBmb3IgdW5kZXJzdGFuZGluZyB0aGUNCj4+IGNoYXJhY3RlcmlzdGljcyBv
ZiBhbiBJSU8gY2hhbm5lbCBhbmQgdGhlIGRhdGEgZGVsaXZlcmVkIHZpYSBJSU8gY2hhbm5lbC4N
Cj4+IEdpdmUgYSBoYW5kIHRvIGRldmVsb3BlcnMgd2hvIGRvIHRoZWlyIGZpcnN0IHNldCBvZiBJ
SU8gZHJpdmVycy4NCj4+DQo+PiBBZGQgc29tZSBkb2N1bWVudGF0aW9uIHRvIHRoZXNlIGNoYW5u
ZWwgc3BlY2lmaWVycy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1h
enppZXNhY2NvdW50QGdtYWlsLmNvbT4NCj4+IC0tLQ0KPj4gUGxlYXNlIG5vdGUgdGhhdCBJIGRp
ZCBvbmx5IGFkZCBkb2N1bWVudGF0aW9uIGZvciBlbnRyaWVzIEkgYW0gZmFtaWxpYXINCj4+IHdp
dGguIEkgZGlkIHN0aWxsIGFkZCBkb2MgcGxhY2Vob2xkZXJzIGZvciBhbGwgb2YgdGhlIGVudW0g
ZW50cmllcyB0bw0KPj4gZWFzZSBzZWVpbmcgd2hpY2ggZW50cmllcyBjb3VsZCBzdGlsbCBiZSBk
b2N1bWVudGVkLiBIb3BlZnVsbHkgdGhpcw0KPj4gZW5jb3VyYWdlcyBwZW9wbGUgdG8gYWRkIG1p
c3NpbmcgcGllY2VzIG9mIGRvY3VtZW50YXRpb24uDQo+IA0KPiBHb29kIHRvIGhlYXIgdGhlIG9w
dGltaXNtIDopDQo+IA0KPiBJJ2xsIGFkZCBpdCB0byBteSBhY3Rpdml0aWVzIGZvciBib3Jpbmcg
am91cm5leXMgKHdpdGggZ29vZCBpbnRlcm5ldA0KPiBhcyBwcm9iYWJseSBuZWVkIGRhdGFzaGVl
dHMpLiAgTm90ZSBJJ20gcmV2aWV3aW5nIHRoaXMgb24gYSB0cmFpbg0KPiAoaGF2aW5nIGlnbm9y
ZWQgaXQgZm9yIGEgZmV3IHdlZWtzIDspDQo+IA0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvbGludXgv
aWlvL3R5cGVzLmggfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9paW8vdHlwZXMuaCBiL2luY2x1ZGUvbGlu
dXgvaWlvL3R5cGVzLmgNCj4+IGluZGV4IDgyZmFhOThjNzE5YS4uYzhlMzI4OGNhMjRiIDEwMDY0
NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9paW8vdHlwZXMuaA0KPj4gKysrIGIvaW5jbHVkZS9s
aW51eC9paW8vdHlwZXMuaA0KPj4gQEAgLTM1LDcgKzM1LDUxIEBAIGVudW0gaWlvX2F2YWlsYWJs
ZV90eXBlIHsNCj4+ICAgCUlJT19BVkFJTF9MSVNULA0KPj4gICAJSUlPX0FWQUlMX1JBTkdFLA0K
Pj4gICB9Ow0KPj4gLQ0KPj4gKy8qKg0KPj4gKyAqIGVudW0gaWlvX2NoYW5faW5mb19lbnVtIC0g
SW5mb3JtYXRpb24gcmVsYXRlZCB0byBhIElJTyBjaGFubmVsDQo+PiArICoNCj4+ICsgKiBNYW55
IElJTyBjaGFubmVscyBoYXZlIGV4dHJhIHByb3BlcnRpZXMuIFR5cGljYWxseSB0aGVzZSBwcm9w
ZXJ0aWVzIGNhbiBiZQ0KPiAiZXh0cmEiIGdsb3NzZXMgb3ZlciB0aGUgZmFjdCB0aGF0IHNvbWUg
b2YgdGhlc2UgYWxtb3N0IGFsd2F5cyBleGlzdC4NCj4gRS5nLiByYXcuDQo+IA0KPiBJSU8gY2hh
bm5lbHMgaGF2ZSBhIHJhbmdlIG9mIHByb3BlcnRpZXMgdGhhdCBtYXkgYmUgcmVhZCBmcm9tIHVz
ZXJzcGFjZQ0KPiAodmlhIHN5c2ZzIGF0dHJpYnV0ZXMpIG9yIGZyb20gb3RoZXIgZHJpdmVycyB1
c2luZyB0aGUgaW4ga2VybmVsIElJTyBjb25zdW1lcg0KPiBpbnRlcmZhY2VzLiAgVGhlc2UgcHJv
cGVydGllcyBhcmUgcmVhZCAvIHdyaXR0ZW4gdXNpbmcgdGhlIHJlYWRfcmF3Li4uDQo+IA0KPiAN
Cj4+ICsgKiByZWFkIC8gd3JpdHRlbiBieSB1c2VyIHVzaW5nIHRoZSByZWFkX3JhdyBvciB3cml0
ZV9yYXcgY2FsbGJhY2tzIGluIHRoZQ0KPj4gKyAqIHN0cnVjdCBpaW9faW5mby4NCj4+ICsgKg0K
Pj4gKyAqIEBJSU9fQ0hBTl9JTkZPX1JBVzoJCVJhdyBjaGFubmVsIGRhdGEgYXMgcHJvdmlkZWQg
YnkgZGV2aWNlLiBTY2FsZQ0KPj4gKyAqCQkJCWFuZCBvZmZzZXQgYXJlIG9mdGVuIHJlcXVpcmVk
IHRvIGNvbnZlcnQgdGhlc2UNCj4+ICsgKgkJCQl2YWx1ZXMgdG8gbWVhbmluZ2Z1bCB1bml0cy4N
Cj4gDQo+IHRvIGJhc2UgdW5pdHMgYXMgZGVmaW5lZCBpbiB0aGUgSUlPIEFCSSAobGluaykNCg0K
VGhpcyBpcyBqdXN0IGdyZWF0LiBJIGxpa2UgYWRkaW5nIHRoZSBsaW5rIHRvIEFCSSBkb2MgaGVy
ZSEgVGhhbmtzIQ0KDQo+PiArICogQElJT19DSEFOX0lORk9fSEFSRFdBUkVHQUlOOglBbXBsaWZp
Y2F0aW9uIGFwcGxpZWQgYnkgdGhlIGhhcmR3YXJlLg0KPiBHaXZlbiBob3cgb2Z0ZW4gdGhpcyBp
cyBkb25lIHdyb25nIEknZCBsb3ZlIHRvIGNhbGwgb3V0IHNvbWV0aGluZyBsaWtlOg0KPiAiU0NB
TEUgc2hvdWxkIGJlIHVzZWQgZm9yIGNvbnRyb2wgaWYgdGhlIEhBUkRXQVJFR0FJTiBkaXJlY3Rs
eSBhZmZlY3RzIHRoZQ0KPiAgIGNoYW5uZWwgUkFXIG1lYXN1cmVtZW50Ii4gRXhhbXBsZXMgb2Yg
SEFSRFdBUkVHQUlOIGluY2x1ZGUgYW1wbGlmaWNhdGlvbiBvZg0KPiAgIHRoZSBsaWdodCBzaWdu
YWwgaW4gYSB0aW1lIG9mIGZsaWdodCBzZW5zb3IuIg0KDQpTbywgbGV0J3MgdHJ5IHRvIHRlbGwg
cGVvcGxlIHRoYXQgSEFSRFdBUkVHQUlOIGlzIHR5cGljYWxseSBub3QgdGhlIA0KdGhpbmcgdGhl
eSBhcmUgaW50ZXJlc3RlZCBpbiA6KSBJIHRoaW5rIHRoaXMgaXMgZXhhY3RseSB0aGUgd2F5IHRo
ZXNlIA0KZG9jcyBzaG91bGQgaGVscCBib3RoIHRoZSBkcml2ZXIgYXV0aG9ycyBhcyB3ZWxsIGFz
IHRoZSBwb29yIHNvZCANCnJldmlld2luZyBhbGwgdGhlIGRyaXZlciBwYXRjaGVzIDspDQoNCj4+
ICsgKiBASUlPX0NIQU5fSU5GT19IWVNURVJFU0lTOg0KPj4gKyAqIEBJSU9fQ0hBTl9JTkZPX0hZ
U1RFUkVTSVNfUkVMQVRJVkU6DQo+PiArICogQElJT19DSEFOX0lORk9fSU5UX1RJTUU6CUludGVn
cmF0aW9uIHRpbWUuIFRpbWUgZHVyaW5nIHdoaWNoIHRoZSBkYXRhIGlzDQo+PiArICoJCQkJYWNj
dW11bGF0ZWQgYnkgdGhlIGRldmljZS4NCj4gDQo+IFVuaXQ/IChzZWNvbmRzIEkgdGhpbmspLg0K
DQpSZWFsbHkuLi4/IENhbiB5b3UgcGxlYXNlIGRvdWJsZSBjaGVjayB0aGlzPw0KDQpJIGJlbGll
dmUgdGhlIEJVMjcwMzQgdXNlcyBtaWNybyBzZWNvbmRzLiBJIHRob3VnaHQgdGhhdCB3YXMgY29y
cmVjdCANCmFwcHJvYWNoIC0gYnV0IGlmIGl0IGlzIG5vdCB0aGVuIHdlIGNhbiBwcm9iYWJseSBz
dGlsbCBjaGFuZ2UgaXQgdy9vIA0KYnJlYWtpbmcgdXNlcmxhbmQuLi4NCg0KDQpZb3VycywNCgkt
LSBNYXR0aQ0KDQotLSANCk1hdHRpIFZhaXR0aW5lbg0KTGludXgga2VybmVsIGRldmVsb3BlciBh
dCBST0hNIFNlbWljb25kdWN0b3JzDQpPdWx1IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28g
dXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMgY2FuIGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
