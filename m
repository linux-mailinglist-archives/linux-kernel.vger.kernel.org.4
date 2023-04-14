Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975B46E2711
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDNPcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:32:45 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011005.outbound.protection.outlook.com [52.101.47.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960496A6F;
        Fri, 14 Apr 2023 08:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moEn7TMWhJGWtRXnhACg+vSC3t7nvwbT0HCuOt3XdLzg+Fe91OJvOdFzidmq74/f5YXkWqqNUC0pRwyPUGJOSrjpJe5H9DHf7N/Wto6abI8ks15m6q7dgodgCxSSROTRISdEWFkY4/ejm9EFnWlTEhlKi1VbqCXUtyVidE9fgp5voI7EKgRZHoIRi1S2FiHlDpMVYtxncne7B8y7UVxpQtJ0T/iLReyEJW/nsvIcLm7u2WI+xIrijmlDetH8mEHheYQRz8J7aZClBLba1V6TRWeNf04++gajmA53yXRx3N4GaVxoZZqOuFWXGhDuzTy69YKjexPIx73a38FydNi1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFlWDkHjha9E4y3+IUEsbO25kfl1E1YYP+DiilzpTXc=;
 b=Aknk21WhBMPkTxuCMW7xyyQXF1b9xsGY4qd7X5AYdRfSu7NaMSwaExxZwWb5Siho5yHMmnkbzesUnbYFY+7vQkJbmsFVnr/kVN+j6STk1bjY3IMq5GG0mewPy2tI6b1YRGHNqVqQjYi8YrKhTQOilyyx2wG31UG4BPk9IuGwUBeVOdSj+sWL5DuIH4f129XHu5PpJShnZQDifYRJu7mYz2Y2bNUqr+5B0yFu1H6w6fnU/ZM1scJ64c1XO1G6q9b0mVSejcJ/RaKni0oE19kd797pf4uBLmt6DVrCpunJDOwxrVRRBrTyoJywEodr/hsD778ndNC6i0K+k+m+Bf7uNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFlWDkHjha9E4y3+IUEsbO25kfl1E1YYP+DiilzpTXc=;
 b=PtVUeZFsjk/uCDPN8kpvPpy3TeUnJZ/6Nwqyf7a2qEkuIqdPv9jf6iKf2+2PpOUrsoEve31Nf7On5seGn4g+COiuoUEfU36UA+B0e3+LdLXHOGo5poWv8agzU2ljd+ICLwJxkhYzCL6bJY9iU1oO9sXSAO84/6zsa3oBzI0MQZ4=
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 (2603:10b6:610:155::10) by PH0PR05MB8640.namprd05.prod.outlook.com
 (2603:10b6:510:ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:32:40 +0000
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::b4c3:9441:f0:efb8]) by CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::b4c3:9441:f0:efb8%6]) with mapi id 15.20.6298.028; Fri, 14 Apr 2023
 15:32:39 +0000
From:   Zack Rusin <zackr@vmware.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "zhouzongmin@kylinos.cn" <zhouzongmin@kylinos.cn>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: vmmouse - add macros to enable vmmouse relative
 mode
Thread-Topic: [PATCH] Input: vmmouse - add macros to enable vmmouse relative
 mode
Thread-Index: AQHZbeXmXmgoR9i+s0CzOvg0t2sCPa8qA1YAgAB/ZICAAG4pAA==
Date:   Fri, 14 Apr 2023 15:32:39 +0000
Message-ID: <59df37cf089230dc6d2d62f2ee539ee90f72388b.camel@vmware.com>
References: <20230413085635.2515647-1-zhouzongmin@kylinos.cn>
         <36d0b466c96b42f5fd364c2a80379d6d7be9cb48.camel@vmware.com>
         <a576df84ad459d13b18377bb64309fa80f1ea7f2.camel@kylinos.cn>
In-Reply-To: <a576df84ad459d13b18377bb64309fa80f1ea7f2.camel@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR05MB10206:EE_|PH0PR05MB8640:EE_
x-ms-office365-filtering-correlation-id: c9e1b9a1-f994-43df-4d49-08db3cfd7b46
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fz0CKtqZ1g4rvRs7g0At+AELm6v2VKsDUTsc4QWC+j5B82XI5LDej9vqnKvPG4OlhJhKhuQ4dJrH4wfS/EYc5SFI28h3Qn00hXCZqPEag8/Xn8bJpVn8paoLknz3EaKfhjWfNEX/Zd+seRMpb2fe4Awr1dZ1U4B+RFMGslg5R12TgRxpeX4KcZt1yGl0orYvX5eEBj1idWM2yFAo+hy0inMztZW6//B9FzVgEdD1kEX7Teb8zC19KQmdi64pW4AOo0cVPdmNqC4uODfDcJzjZ4ZDoOFc6nQp0etnZ5LSMVx9TOB8sZaIY3yOv5fyYObNbRqZM73R3H5A9gtWvptDFjPauPdPVtlbjBOgNyJi9cKOteb1tAZC/hhF+RGlR2LtAcXNOMKE5PRad416EdZySmr3lwso3nfBPqUh4s7x7RGqpUf1eDbTeqPa0i62VpeNLacuY0+bVgIaIAF5XXglZ542AUDgVmVag+/vU/LYEi0I4b0niZwEA1VAisIHWHur5qci+mepmdAJ0Teq8LzDPtHQ2ptRQWFY//QXKo9W3taPa93/v+oWTEO+AizcQc8ZJEcebVmeYvRbaMUXdb+O9DBXzYkv4rfZzdWjF0wKrkn9rWTr4QP+hZLNYggGnjkUiZ23C0yJmfOeIA3pHft4TrBlJuu8MqtNrMJU491XruozsP07TKuaal2slF96C6jS9Vduh6QsHf+Sxn/yHb75nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR05MB10206.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(71200400001)(122000001)(5660300002)(36756003)(2906002)(38100700002)(316002)(8676002)(38070700005)(86362001)(8936002)(64756008)(41300700001)(66446008)(66556008)(66946007)(66476007)(4326008)(76116006)(91956017)(6506007)(966005)(83380400001)(2616005)(54906003)(186003)(110136005)(6512007)(26005)(478600001)(6636002)(45080400002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2toaWcwcnlZcmpIQitieStOZEMvZUpxdEpoUERhd29ZbjQwTy80d05Qdlda?=
 =?utf-8?B?enRadXhYMnRib2ROK2NvQVZaT2gva3VXZCtveTZGNkNlMHRMTUk3cWNHNE5V?=
 =?utf-8?B?UzFKK2hBNldRMkZDMzB1amdmU1RNWG9uYlhZQit0SE4wa1RBb2JpcHIrcTZs?=
 =?utf-8?B?bU5pMWtvSVpsNFRLTTE1ODcrU3BBM05jaEhETllzODlrYzErbllLcGN0K3BP?=
 =?utf-8?B?QlpGbk1reExXM1pJZnBoakZPWWNjZ2MwK3hJTzFLT0toMWVyUEV4YmlJblF4?=
 =?utf-8?B?WHZZWko0aVBldTBOZ3djZDNnUGg5WnB1YXJIS05hMlRYWThrMGd5c2w1ZDYv?=
 =?utf-8?B?ZGF0ZTFBMkZPT3J1ZlJpVnBWYUlLdGVUM1U2QmhiVGJXOHVYL0JlcVFHcVIx?=
 =?utf-8?B?L1I2ZzJLaTgwSUt6clJTWXJ4TlNCQld1WmtXN2YvaHR0NUxKM3EzZWQxQ1hC?=
 =?utf-8?B?SENtWmlGcnpZOUFHQjgwR0Z4alZwWklGQ25scGJ3M1UzUWo5UGxTbW9DQ1lw?=
 =?utf-8?B?RS83WWdZMFQ4YVIyNDJEZDZ2aWFBSnBkbHBOMER0YXFHWlpiaHNITVI2TmU1?=
 =?utf-8?B?RUtzeC9NVzVjY3hHd1ZFbnQ3RGp0VmoyQWkrMFRWNkRqeGRicndVVEVwQ1A5?=
 =?utf-8?B?dk9KcCtpYm9NTjluSXJQNzFxQWFKUit4VU55N2tadFNsZWlabjM2T0RyYXpN?=
 =?utf-8?B?QmJ1Uy9LSFNSOWl1dmY0cFp6UC8rdW8rRCtLZ1NuVWxYQXl1KzRrOWd5SkJK?=
 =?utf-8?B?RVFEbm0wZDRJNmtBZExocWFXRExHeXdBcXZCM1JRTUtUSzBEZTV2WldVQWNH?=
 =?utf-8?B?bnpPQ3o2KzNzbGpxL0FDU3FMUGphaWNJbjhyakZZcjJkVUhPdldaQ29wb3g2?=
 =?utf-8?B?UjhSbVBDWGFTdXhRUTR0STNJcVJyOGpyUTBNMm1NUEtOODRNZVpteGcwYUw5?=
 =?utf-8?B?RHljM0JRN0JYbk5VUVNCU0JOTnkxc2VqUnR6cThic3Rzb251WlE3eHIzSk5p?=
 =?utf-8?B?a2h2UUV5QjQyU0lTMEdxZFVSdU0zUnNEMGpqWmkvNHVHR08xV2w1YThraDNC?=
 =?utf-8?B?YWJhMS8vSEl3aVNEOFZ3K2tjSnJiOTh1cmdXL1VwNkRVQk5SN1hGUjNOajdE?=
 =?utf-8?B?U09IeTlzMFNNQWdjVVNQRkVycExRV2ZnQ05JVVJVcXU3QS8zUkRaTUd0RDlY?=
 =?utf-8?B?RSs1dTlxdzZQWVZ6OXhtU0xGUzJEaDNYcTRSNERNSURtbVBDM0RySU9XTEwy?=
 =?utf-8?B?NFk1bkNOcFVuQk1qU2lxb3phekpBekUxemFFcFpQSnlPMmdLSnEvRS9SR1Zp?=
 =?utf-8?B?eGk4bVVIVElyWjMxZkNINXNzcGJFZVBNc3NyQTMwT0Zwb0MvbDZwNGVGRkhK?=
 =?utf-8?B?SDVUTWFkb3V1Q1ZOUHA4dFQ0V3ltOVpzcGJuNkV2ZHV1SUhoUEppYzRzYUlq?=
 =?utf-8?B?SnZFTHlkK2l6bjM1ckFveTl2ZGduejRVekRucXpjMFdrRFAyTVZGeitjTVhn?=
 =?utf-8?B?bEFRUHRDSnB6NDFIWE1EdXp1WUpDaitrYmtmTk9KNTNSWmZDSHl6dmI3cmk3?=
 =?utf-8?B?WCtUU3JlUzV1Z3RDUEtVV2JTUVQrR0sxdlFvSGNhU0VyWTVmU2tLWDk1dFZo?=
 =?utf-8?B?TUZObFVmK1ZFOEJTNThvaTV1Y3pHeUROOWxFV0s1WnBPamd6VlRWVVpkeVZJ?=
 =?utf-8?B?VzJMVkxVNnM2Nk5Xak96cG9IT0RzaXVRT1Njc3JidnU3M1JnNnM2dlhIdVRw?=
 =?utf-8?B?M0IxSmVUdXJqZmFhZmJBQ0FONitUbWk3REFldlkvdlp3dmt6SktrVys1RVNZ?=
 =?utf-8?B?RGYzcTAyWUd3QjR1K0NlYlV1MGFTYWhqSHUycnY1VUNKMGptRDFuUkdzUjRo?=
 =?utf-8?B?a1V4bU9kckx3S1dMeXJpYlhPdmxjUlRkZkdQY2I3U01SZFJoSEY0NHdvbHcr?=
 =?utf-8?B?bkNLMWs0TFZBQVhSVG02Q2NkaDNRUzNubVo1RTJ2NXI2bXJmLzA3VUhxdy8y?=
 =?utf-8?B?S0xnNmNxUmdFOXBnOTJOS3h2eE53WVhGNnB5MDFPOU9EZExyRFpZbEtHTzZV?=
 =?utf-8?B?MjVEcTlPclJnY2loRmhTSGdLY3lGQTFYaThNQmNZMXo4K0NKOTJsQXVha0E5?=
 =?utf-8?Q?TUrUNZhqC3iwQOAtMkbnKRzFB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <336182F7934D1B479013C0A4330AFF38@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR05MB10206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e1b9a1-f994-43df-4d49-08db3cfd7b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 15:32:39.5176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWh8nYj579dE+iKLlNEGn7g5o9LZqqd+Zn3XGDhKghpY0WZmYCebyMwgPwis+skodD7AEIc1gDbXlRVPhs/Bnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8640
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDE2OjU4ICswODAwLCB6b25nbWluIHpob3Ugd3JvdGU6DQo+
IE9uIEZyaSwgMjAyMy0wNC0xNCBhdCAwMToyMiArMDAwMCwgWmFjayBSdXNpbiB3cm90ZToNCj4g
PiBPbiBUaHUsIDIwMjMtMDQtMTMgYXQgMTY6NTYgKzA4MDAsIFpvbmdtaW4gWmhvdSB3cm90ZToN
Cj4gPiA+IEFkZCBtYWNyb3MgdG8gZW5hYmxlIHJlcXVlc3QgcmVsYXRpdmUgbW9kZS4NCj4gPiA+
DQo+ID4gPiBDaGFuZ2UgdGhlIFJFTF9ZIHZhbHVlIHBhc3NlZCBieSBpbnB1dF9yZXBvcnRfcmVs
IGZ1bmN0aW9uLA0KPiA+ID4gdG8gbWF0Y2ggdGhlIGRpcmVjdGlvbiBvZiBtb3VzZSBtb3ZlbWVu
dC4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLCBidXQgaW4gaXRzIGN1cnJlbnQgZm9y
bSBpdCdzIGEgbmFjay4gRmlyc3Qgb2YNCj4gPiBhbGwgd2UgZG9uJ3QNCj4gPiB3YW50IGFueSBk
ZWZpbmVzIGluIHRoZSBkcml2ZXIgY29kZSB0aGF0IGFmZmVjdCBjb21waWxhdGlvbiwgaXQncw0K
PiA+IG5ldmVyIGdvaW5nIHRvIGJlDQo+ID4gdGVzdGVkIG9yIGNvbXBpbGVkIGluLiBFaXRoZXIg
YSBrY29uZmlnIG9yIGEgbW9kdWxlIHBhcmFtZXRlciB3b3VsZA0KPiA+IGJlIGFjY2VwdGFibGUN
Cj4gPiBidXQgdGhhdCdzIG9ubHkgaWYgeW91IGNhbiBhY3R1YWxseSBleHBsYWluIHdoYXQgaXQg
aXMgdGhhdCB5b3UncmUNCj4gPiBmaXhpbmcuIFRoZQ0KPiA+IGN1cnJlbnQgc2luZ2xlIGxpbmUg
ZGVzY3JpcHRpb24ganVzdCBtZW50aW9ucyB3aGF0IHRoZSBlZmZlY3QgaXQgaGFzDQo+ID4gKG5v
dCBjb21wbGV0ZWx5DQo+ID4gY29ycmVjdGx5IGVpdGhlciBiZWNhdXNlIGZvciBtZXJnZWQgcGFj
a2V0cyBhYnNvbHV0ZSB3aWxsIHN0aWxsIGJlDQo+ID4geD14LCB5PXksIGJ1dA0KPiA+IHJlbGF0
aXZlIHdpbGwgYmUgeCArPSBkeCwgeSAtPSBkeSkgYnV0IG5vdCB3aHkgaXQncyBkb25lLCB3aGF0
IGl0J3MNCj4gPiBmaXhpbmcgYW5kIGhvdw0KPiA+IHRvIHJlcHJvZHVjZS4NCj4gPg0KPiA+IHoN
Cj4gPg0KPiBEZWFyIHphY2s6DQo+DQo+IEZpcnN0bHksdGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0K
Pg0KPiBUaGUgcmVhc29uIEkgd2FudCB0byBhZGQgbWFjcm9zIHRvIHJlcXVlc3QgZGlmZmVyZW50
IHZtbW91c2UNCj4gbW9kZXMocmVsYXRpdmUgb3IgYWJzb2x1dGUpIGlzIHRoYXQgdGhlIHZtbW91
c2UgZHJpdmVycyBjdXJyZW50bHkgb25seQ0KPiBzdXBwb3J0cyByZXF1ZXN0IGFic29sdXRlIG1v
ZGUuQnV0IGluIHNvbWUgY2FzZSB3ZSB3YW50IHJlcXVlc3QNCj4gcmVsYXRpdmUgbW9kZSBzbyB0
aGF0IFBvaW50ZXIgYWNjZWxlcmF0aW9uIGZlYXR1cmUgY2FuIGJlIHVzZWQuKGFzIEkNCj4ga25v
dyxsaWJpbnB1dCBtb2R1bGUgb25seSBzdXBwb3J0IFBvaW50ZXIgYWNjZWxlcmF0aW9uIGZlYXR1
cmUgaW4NCj4gcmVsYXRpdmUgbW9kZS4pDQo+IFNvIEkgdGhpbmsgd2UgY2FuIHByb3ZpZGUgdHdv
IHZtbW91c2UgbW9kZXMgdG8gZmFjaWxpdGF0ZSB0aGUgdXNlIG9mDQo+IGRpZmZlcmVudCBuZWVk
cy4NCj4gSWYgbmVlZCxJIGNhbiBjaGFuZ2UgaXQgdG8gYSBrY29uZmlnIG9yIGEgbW9kdWxlIHBh
cmFtZXRlci4NCj4NCj4gVGhlIHJlYXNvbnMgb2YgZml4IGZvciBSRUxfWSB2YWx1Ze+8jGFyZSBh
cyBmb2xsb3dzOg0KPiBXaGVuIEkgcmVxdWVzdCByZWxhdGl2ZSB2bW1vdXNlIG1vZGUsYW5kIGxl
dCBtb3VzZSBtb3ZlIHVwLHRoZSBtb3VzZQ0KPiBwb2ludGVyIG1vdmVkIGRvd24gaW5zdGVhZC4N
Cj4gU2ltaWxhcmx5LCB3aGVuIEkgbW92ZSB0aGUgbW91c2UgZG93biwgdGhlIG1vdXNlIHBvaW50
ZXIgbW92ZWQgdXAuDQo+IGl0IG9idmlvdXNseSB3aXRoIGEgd3JvbmcgbW90aW9uIGRpcmVjdGlv
biBpbiB5Lg0KPg0KPiBBY3R1YWxsee+8jEkgdW5kZXJzdGFuZCB0aGF0IHRoZSB2YWx1ZSBvZiB5
IGhlcmUgaXMgdGhlIGVuZCBjYWxjdWxhdGlvbg0KPiByZXN1bHQgb2YgcmVsYXRpdmUgY29vcmRp
bmF0ZSBtb3ZlbWVudO+8jHRoZSByZWFsIGNhbGN1bGF0aW9uIGlzIGluDQo+IG1vdGlvbl9ldmVu
dCgpIG9mIHNwaWNlLWd0ayBhbmQgIGxlZ2FjeV9tb3VzZV9ldmVudCgpIG9mIHFlbXUuDQo+DQo+
IFRlc3Qgc2NlbmFyaW86DQo+IDEpIHN0YXJ0IHZpcnR1YWwgbWFjaGluZSB3aXRoIHFlbXUgY29t
bWFuZCAidm1wb3J0PW9uIu+8jGFsc28gd2l0aCBzcGljZQ0KPiBwcm90b2NhbC4NCj4gMikgbW9k
aWZ5IGd1ZXN0IHZtbW91c2UgZHJpdmVycyB0byByZXF1ZXN0IHJlbGF0aXZlIG1vZGUuDQo+IDMp
IG1vdmUgdGhlIG1vdXNlLHdpbGwgb2JzZXJ2ZSB0aGUgcG9pbnRlciBmcmVlemVkLGl0J3MgYmVj
YXVzZSBkcml2ZXINCj4gbm90IG1hdGNoIHRoZSBjb25kaXRpb24gJ3N0YXR1cyAmIFZNTU9VU0Vf
UkVMQVRJVkVfUEFDS0VUJyxjYW4ndCBmaW5kDQo+IGNvcnJlY3QgaW5wdXQgZGV2aWNlLm5lZWQg
bWVyZ2UgdGhpcyBwYXRjaCBpbiBxZW11Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyMzA0MTMwODE1MjYuMjIyOTkxNi0xLXpob3V6b25nbWluQGt5bGlub3MuY24vDQo+IDQpIGFm
dGVyIG1lcmdlIHRoZSBwYXRjaCBpbiBxZW11LHdlIGNhbiBvYnNlcnZlIHRoZSBpc3N1ZSBvZiB3
cm9uZw0KPiBtb3Rpb24gZGlyZWN0aW9uIGluIHkuDQoNClNvdW5kcyBsaWtlIHlvdSBoYXZlIGEg
YnVnIGluIHRoZSBtb25pdG9yIGNvZGUgdG8gbWUuIFRoZSBtb3VzZSBtaWdodCByZXF1ZXN0DQpy
ZWxhdGl2ZSBtb2RlLCBidXQgdGhhdCBkb2Vzbid0IG1lYW4gdGhhdCBpdCdzIGdvaW5nIHRvIGJl
IHN3aXRjaGVkLCBpdCdzIGEgaGludC4gT24NCmVuYWJsZSB3ZSBkZWZpbml0ZWx5IHdhbnQgdG8g
cmVxdWVzdCB0aGUgZGVmYXVsdCBhYnNvbHV0ZSBtb2RlLg0KDQpVbHRpbWF0ZWx5IGl0J3MgdGhl
IGRlbGl2ZXJ5IG1lY2hhbmlzbSAoaS5lLiB3aGV0aGVyIHRoZSBkZWxpdmVyZWQgZXZlbnQgaXMN
ClZNTU9VU0VfUkVMQVRJVkVfUEFDS0VUIG9yIG5vdCkgdGhhdCBkZWZpbmVzIHdoYXQgYW4gZXZl
bnQgaXMuIFRoaXMgc291bmRzIHRvIG1lDQpsaWtlIHRoZSBtb25pdG9yIGRlbGl2ZXJzIFZNTU9V
U0VfUkVMQVRJVkVfUEFDS0VUIGV2ZW50cyBidXQgZG9lc24ndCBtYXJrIHRoZW0gYXMNCnN1Y2gu
IFlvdSBjYW4gY29uZmlybSBieSBwdXR0aW5nIHNvbWUgZGVidWdnaW5nIG91dHB1dCBpbiB0aGUg
dm1tb3VzZV9yZXBvcnRfZXZlbnRzLg0KDQp6DQoNCg==
