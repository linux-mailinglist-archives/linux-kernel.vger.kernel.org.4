Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AD16DF45E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjDLLzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDLLzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:55:38 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2138.outbound.protection.outlook.com [40.107.135.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537A730FF;
        Wed, 12 Apr 2023 04:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWow9GcSclmF2qMr0w24hHwkFt107koly3lI5AwE0KQwfDOQet9z+PxYFK9xAV7xZ7MPmDNiOInQA07sIL7nJYg3kFX5kkEvrch1CGR4SSgyudo35PpWJ/zwz2YqvO8O9IgfLKm8cuy4UMBJn6KyYCrakiSrWbo6OJcQ6Rxs9CZV5twGocW3fUSOhWDA117JkFjdBLeobh/ERBWLRkLADcOzMm/OoHzMVVV0dLwmPHokdU6AM+7WPS+poI9gvfl0b3Q23l5PEn0h8cBtlthz069ODfVg+uoqU1MWiPLrAnazTt+NQFJTKG8lSFCOw9aeR75AvJkFWt3OSQk1GAH7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KtsOnYhlMDoTEZVkMy3Y4xxZR6MvxklcnAzHm6UQSo=;
 b=itZHV+7cLIzd0zxMUs8yFgW7ys9U+7HxK0aiWjs3IQvP6zu0qU8yd3DR5gguCkh5HU6e5GQBQ7w7vOkajiD51nS4lW/XRNTNkqVGPosKHvVT+Kwr6d+XQXRcbHZ9OAC3Qr75REDl+UBAJf3dt6ybV0t9HY7GV/B0YLFJI7bJOIZLk6/ktb91DD3JII+LvvNtR7YPfrqm5py0gNrXdKWUISu5cz51/Swb4Ffprw0UVC00rjc4KFlACMD81mNSW51O/GlcCxjzQi1GS0YeYE5ddb/ZZGlNXZaCa71ZC6asVQMC05j94lHEws2zqzi78h9aKqwtUzPFF6tBnecdvmxxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KtsOnYhlMDoTEZVkMy3Y4xxZR6MvxklcnAzHm6UQSo=;
 b=wHBNdkJHe1ksUHBG5yCmuXomFuqYWUUQkzGDm9iy43ePIdxN2eKCxAMzed+Kkq93OhSedpknctFmTlhemg0G+4l2V23tlNwf7dQPK2N2MEB4LP872veGmI6r8k06fPC6TaK6iOpANpyYBSPunBwLdQ9bCZK7adRNw56B2bAXlVs=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BE1P281MB1601.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:18::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 11:55:27 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f%4]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 11:55:26 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 4/5] iio: light: ROHM BU27034 Ambient Light Sensor
Thread-Topic: [PATCH v7 4/5] iio: light: ROHM BU27034 Ambient Light Sensor
Thread-Index: AQHZY85bPT2a8xlB7E+uwSrykMRZ968hUPcAgAMYiQCAAzo6AA==
Date:   Wed, 12 Apr 2023 11:55:26 +0000
Message-ID: <c14e3897-0186-681e-45b6-d079111c893e@fi.rohmeurope.com>
References: <cover.1680263956.git.mazziesaccount@gmail.com>
 <2a7efb6f335da5526fbe34b95137c5e45db5c5d3.1680263956.git.mazziesaccount@gmail.com>
 <20230408122140.25332d15@jic23-huawei>
 <eeb96226-2ad6-954c-7054-b4762942ac0d@gmail.com>
In-Reply-To: <eeb96226-2ad6-954c-7054-b4762942ac0d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BE1P281MB1601:EE_
x-ms-office365-filtering-correlation-id: 4e74dc26-0f7e-49fa-5324-08db3b4cce40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywuEb3Vu3+akViXQTSiBAs2WTKtlXI82YwcuTABSL9kcDS40ZyzGuuEZIrjs/sa7apkPmM7eOKkCjPSjM9uVKquXh6qeXULonA8Dp53N3DIxGu0M3Uw1s0Re1+R9DUDd03ryHCO1URTkXhE0UPEgUJ0l9TVLcUon/MMGtfBgI+vDd1GAAELJoSY/Z6mR5dwor3lqHwx44vH4wme9B78kb1HIyYFywbtK/zzT4QKq+wOGuncFupXf9q16bdnhEf5brfKWdMNnJ+DqGePRtNNpKaMcVVyxi2MSCHj/E+01tA4vF/wr6+AsPHimIfW5xwx8USrYukxrwq4oISSLaQmH2cWoel1CmDe0KtvvS4RhdGCInYyExisTrGiDFXiqXnkJL9c1nEP+mygS76xPSjFl0HidmoC1BjcpRkkNe8nZeiZpGOJVT7yFeY2uYD+3YNZwuPISYGLT4JfbRa8spM1co3csxessi/FjaLnHVJ66rgEXmDQVC5RFL2pKhWYtju6eA/BhOLRuCxahwDYRv+krvlnXlsYji7E5n29Hzh+kl3u0EkLY+Dd4Bboqbbw7WGIz851s+qTe3EFUlehK8rB2IrG+1Le9kytYvhf4jTmIvoEr/WZQs1Vbc0ey/vi6LOe6w79zgVKiZT09AlfPf1/VPW5vxMmDkxy4X+o86th/7MHEqlk0Z9QtnNLb+98Ffcj8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39850400004)(136003)(376002)(451199021)(4326008)(31686004)(66556008)(76116006)(66946007)(316002)(91956017)(64756008)(66476007)(8676002)(2906002)(8936002)(41300700001)(5660300002)(83380400001)(66446008)(54906003)(478600001)(110136005)(6486002)(71200400001)(6512007)(6506007)(53546011)(26005)(2616005)(186003)(38100700002)(38070700005)(86362001)(31696002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmYrRm11eXRhbTQ5UlhEUWp2ZE1YMUs1UDYwK3Q0UDg1VUM3TTNyWE83YS8z?=
 =?utf-8?B?TDdsV2x3TDVsblRySmdISys2ZmY4aUhsbEE4a0hTUXRsTER4R0QxV2RjTzZN?=
 =?utf-8?B?ZGNYb0RncWRrZnhQdzRNM1BIVTdjMnUyOVI0L0JuYzVJT3E2OGZYNnZ2akcr?=
 =?utf-8?B?RjJaQVpjRXY0cDJKdjA4ZEJ4TEg2RzhWUzNrZ3dINUlzWjVhM1VhYU8xT1Np?=
 =?utf-8?B?TFo0c09yVVlvRzc1eGlzaStYT2xKeWMrZFFxUlB3OXBwQThxbDVoTjVaZnZl?=
 =?utf-8?B?K1AyNmttUWdHbndFOEx3K1hlS2tsd1RmbXlPaDdGeVQzUXJaUWJvbU5NcWpW?=
 =?utf-8?B?aWNPVlFScmpwTnQweXg5VFFvbE9kbXRGWlBBWEs2a05MZENSc3ZLRW05R0hp?=
 =?utf-8?B?empPS1ZJWWdTNzZKcHNGOC8zVDZOWjZsbjFEU01yU1B4L0x2bVN6S2RzQjRx?=
 =?utf-8?B?TFN0WUJEbGpPVUc0d3R3ZUxScHBpcTFBRTh3RFlTNjQzdWFHMjNUN0U0WWZS?=
 =?utf-8?B?VUlhWGlRRkNqL0FNZm1aZlozbnB5Wk9zUm5qSXRjT0VWbER6UFdYYkZ6c1Jh?=
 =?utf-8?B?NUlWTnQxRlVJSHg4M3NESUxDeEFIUjhZU24wV0ZIRUdlaC91dEpjUm9jbExJ?=
 =?utf-8?B?cmV5U1JHNUJkT3BOMDMxd2pOemdBQVVscU1KL0pxNXEraWdGTzAyVUNHNGlk?=
 =?utf-8?B?bWp3TTkra3FFVU4zYjI4T0c1SFZEV0d0eXBiTzBpalNuK0FkTTYzbmxTNTUr?=
 =?utf-8?B?eFlPZzhIWElLdHpSeFpNSGVqUWhkNkZlcm9rSGdoQkxReS9nVmo0azJGdHlN?=
 =?utf-8?B?UzZicGFMa0kycUtrZUhqZE9udStnVWFRbUZUZzdkWlVyWElpVy82UHpMR1Ex?=
 =?utf-8?B?ejU3eC9EZzNVUFVGY3o4YmQrNXlLNWVReFlHNG10M3VRVlplTDNGa25tOWpS?=
 =?utf-8?B?V3p6eUtJMWNHUHhqWG90a0hWS1BlWU9teEJvVFlILzZJUDErRkxBdFIrcWg0?=
 =?utf-8?B?MG9XWERucE9Ybzc1T1dsRTZ3SHExQnBnNmwzR3A3WXZHVFA4RzFNR09zYmxk?=
 =?utf-8?B?Y2t3a0dOaSs4U0UxWGdkUHg1aEMyZXkwSzlOcjUvanF3eEhJQ2pkcnVHbVVE?=
 =?utf-8?B?N0d5bCttTHQxUThnN0FjZzdVNEVGSUY2NXdTVStXM2RidHVjc0l4ZGpRbUtt?=
 =?utf-8?B?RTZBaTBlMWsyUWRDbkVNQU03ampsakU1dHJyait6di94QVJQaGdETnR2TTB0?=
 =?utf-8?B?a0srSjlOTVg0bGc5a1dmS2FkZVJFU1U3a05YQm0xcm9oalpYa0VhM29mbkFu?=
 =?utf-8?B?dExpYXdtY0V3TnZJUUg2Wk5xRFRhYU1aMllsd1pCbzUzTFRCNi9vWXJXRktK?=
 =?utf-8?B?TCt2NkhTUkk3Y1U0MUJqRnNhYUxrL1BqdTBxTlIxVHpEcitENEpvaVEzUlpR?=
 =?utf-8?B?RFcvdEpteWt1K2Q1VHAycWtpelpQQ0xHVkVUcU1mTE1LTktkb2haall3ZHRS?=
 =?utf-8?B?STR4WnU0bURCanhVdzg1d2NwNWxUbWZCV2hJTDBFWlFaSllhUjlOVWdiUCs5?=
 =?utf-8?B?SmRBUy9aeUFPSVFGdkJNZVFtNUQwRkx4a2pOQWM2QkVsWHZMRGwzUk1mcG9Z?=
 =?utf-8?B?aWJmd3AvUzRidWs0NnlNblZDQ0twUEtCTm5TanA3OW1MaXpMVlV6UmorYUxG?=
 =?utf-8?B?YkgvYjRyem12dnZMRUFTdHlRVXcwbTQyQitpN0Q5ZWZmTmg2UUFIM1dyNTZl?=
 =?utf-8?B?bGpsWkNOOUZ1K2w0UzM5a29pKzAyZFBtTDBPeUhPMTRLaStOQ0h4Z1A2cy9R?=
 =?utf-8?B?U1Q2VnI4Q0syUlBNV1ZiczRzcmtjTnA2UEMxV1Z4a2xTaDBIdHJSek9ucCtV?=
 =?utf-8?B?Z09TNXlpN1QwZXhVV1MxUzBaRGRuY2x6ZHNXSUlNQ0Y5ZjNXbVdnSUVJZ1hO?=
 =?utf-8?B?OWdFcjRXYVZ0R0NudkNDQkVaQnFoejZjWDYvRFRkZWUvSWRJbG5wTitzYVBO?=
 =?utf-8?B?ajQvMG9JZ3ZSSmRBWlU2dGhDb3RmMzhtUUNJQ3dOWFpxQ0l1UmIzbSt0dDUw?=
 =?utf-8?B?Tk4wQmFPbkRxcEtxNGdJenI3d0VrK0FpY0o4REFjQWJNck8zam1ta1lnSmJP?=
 =?utf-8?B?SE5yc3NvTkE1MTJ6ZkhQQjMva0o1Vkc0N2FiWnVaMHdNNWt6T0xVdlN4NUx4?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8ED68E30C903A4B9253EFA7BA5D22C8@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e74dc26-0f7e-49fa-5324-08db3b4cce40
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 11:55:26.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ru2YAhfVUWWrtFYqhYThDf/0GSzc1hnS6wi+iHLKqpWcPYn6D/La5WXlrU/Bv2078v78Vh/97oB1qWPA6spHwfcc/R9ELLWf7PgGFdQrOoCNivtz9fDvT59piutGr3/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1601
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xMC8yMyAxMzozOCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiBPbiA0LzgvMjMgMTQ6
MjEsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+PiBPbiBGcmksIDMxIE1hciAyMDIzIDE1OjQx
OjU4ICswMzAwDQo+PiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50QGdtYWlsLmNvbT4g
d3JvdGU6DQo+Pg0KPj4+IFJPSE0gQlUyNzAzNCBpcyBhbiBhbWJpZW50IGxpZ2h0IHNlbnNvciB3
aXRoIDMgY2hhbm5lbHMgYW5kIDMgcGhvdG8gDQo+Pj4gZGlvZGVzDQo+Pj4gY2FwYWJsZSBvZiBk
ZXRlY3RpbmcgYSB2ZXJ5IHdpZGUgcmFuZ2Ugb2YgaWxsdW1pbmFuY2UuIFR5cGljYWwgDQo+Pj4g
YXBwbGljYXRpb24NCj4+PiBpcyBhZGp1c3RpbmcgTENEIGFuZCBiYWNrbGlnaHQgcG93ZXIgb2Yg
VFZzIGFuZCBtb2JpbGUgcGhvbmVzLg0KPj4+DQo+Pj4gQWRkIGluaXRpYWzCoCBzdXBwb3J0IGZv
ciB0aGUgUk9ITSBCVTI3MDM0IGFtYmllbnQgbGlnaHQgc2Vuc29yLg0KPj4+DQo+Pj4gTk9URToN
Cj4+PiDCoMKgwqDCoC0gRHJpdmVyIGV4cG9zZXMgNCBjaGFubmVscy4gT25lIElJT19MSUdIVCBj
aGFubmVsIHByb3ZpZGluZyB0aGUNCj4+PiDCoMKgwqDCoMKgIGNhbGN1bGF0ZWQgbHV4IHZhbHVl
cyBiYXNlZCBvbiBtZWFzdXJlZCBkYXRhIGZyb20gZGlvZGVzICMwIGFuZA0KPj4+IMKgwqDCoMKg
wqAgIzEuIEluIGFkZGl0aW9uLCAzIElJT19JTlRFTlNJVFkgY2hhbm5lbHMgYXJlIGVtaXR0aW5n
IHRoZSByYXcNCj4+PiDCoMKgwqDCoMKgIHJlZ2lzdGVyIGRhdGEgZnJvbSBhbGwgZGlvZGVzIGZv
ciBtb3JlIGludGVuc2UgdXNlci1zcGFjZQ0KPj4+IMKgwqDCoMKgwqAgY29tcHV0YXRpb25zLg0K
Pj4+IMKgwqDCoMKgLSBTZW5zb3IgaGFzIEdBSU4gdmFsdWVzIHRoYXQgY2FuIGJlIGFkanVzdGVk
IGZyb20gMXggdG8gNDA5NnguDQo+Pj4gwqDCoMKgwqAtIFNlbnNvciBoYXMgYWRqdXN0aWJsZSBt
ZWFzdXJlbWVudCB0aW1lcyBvZiA1LCA1NSwgMTAwLCAyMDAgYW5kDQo+Pj4gwqDCoMKgwqDCoCA0
MDAgbVMuIERyaXZlciBkb2VzIG5vdCBzdXBwb3J0IDUgbVMgd2hpY2ggaGFzIHNwZWNpYWwNCj4+
PiDCoMKgwqDCoMKgIGxpbWl0YXRpb25zLg0KPj4+IMKgwqDCoMKgLSBEcml2ZXIgZXhwb3NlcyBz
dGFuZGFyZCAnc2NhbGUnIGFkanVzdG1lbnQgd2hpY2ggaXMNCj4+PiDCoMKgwqDCoMKgIGltcGxl
bWVudGVkIGJ5Og0KPj4+IMKgwqDCoMKgwqDCoMKgIDEpIFRyeWluZyB0byBhZGp1c3Qgb25seSB0
aGUgR0FJTg0KPj4+IMKgwqDCoMKgwqDCoMKgIDIpIElmIEdBSU4gYWRqdXN0bWVudCBhbG9uZSBj
YW4ndCBwcm92aWRlIHJlcXVlc3RlZA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNjYWxlLCBh
ZGp1c3RpbmcgYm90aCB0aGUgdGltZSBhbmQgdGhlIGdhaW4gaXMNCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBhdHRlbXB0ZWQuDQo+Pj4gwqDCoMKgwqAtIERyaXZlciBleHBvc2VzIHdyaXRhYmxl
IElOVF9USU1FIHByb3BlcnR5IHRoYXQgY2FuIGJlIHVzZWQNCj4+PiDCoMKgwqDCoMKgIGZvciBh
ZGp1c3RpbmcgdGhlIG1lYXN1cmVtZW50IHRpbWUuIFRpbWUgYWRqdXN0bWVudCB3aWxsIGFsc28N
Cj4+PiDCoMKgwqDCoMKgIGNhdXNlIHRoZSBkcml2ZXIgdG8gdHJ5IHRvIGFkanVzdCB0aGUgR0FJ
TiBzbyB0aGF0IHRoZQ0KPj4+IMKgwqDCoMKgwqAgb3ZlcmFsbCBzY2FsZSBpcyBrZXB0IGFzIGNs
b3NlIHRvIHRoZSBvcmlnaW5hbCBhcyBwb3NzaWJsZS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6
IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2FjY291bnRAZ21haWwuY29tPg0KDQpBcyBJIHdyb3Rl
IGluIHRoZSBvdGhlciAoc3lzZnMpIG1haWwgLSB0aGlzIGRyaXZlciB2ZXJzaW9uIGlzIGJ1Z2d5
IGFzIA0KaXQgaGFuZGxlcyBJTlRfVElNRXMgaW4gbWljcm8gc2Vjb25kcy4gVGhlIGNvcnJlY3Qg
dW5pdCB3b3VsZCBiZSBzZWNvbmRzLg0KDQpJJ2xsIHNlbmQgYW4gaW5jcmVtZW50YWwgZml4IHRv
IHRoaXMgYW5kIHRoZSBndHMtaGVscGVycyBvbiB0b3Agb2YgdGhlIA0KaWlvL3RvZ3JlZyAoaG9w
ZWZ1bGx5IHNvb24pLg0KDQpZb3VycywNCgktLSBNYXR0aQ0KDQotLSANCk1hdHRpIFZhaXR0aW5l
bg0KTGludXgga2VybmVsIGRldmVsb3BlciBhdCBST0hNIFNlbWljb25kdWN0b3JzDQpPdWx1IEZp
bmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28gdXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMgY2FuIGFs
d2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
