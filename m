Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410A66F204A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbjD1VzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjD1Vy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:54:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F59C10F3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyG5kAqBdMo2Wuq24P79cmI4yBJIUcPmZZCvSgzRXhDfMp5OOdPv5TGXOBgKUKqqWYF+vxRhYe/S0DENl/IKdtPZ92e5FdP/fvvOFtVBHx9UM6gIneK0E1RkXlUJUv91zvhAqsTfUsrP8Jt5mkczUOEK7Rcr6y9C1JYZOJXC4Ph+MkEo58bKGunO5W69qYYBvUEO2vDkRdTlpJDTcu70PwmwjNUyVkmqJYkED6YQJmtcQygyq2Cszuu03iSP8qlmVRVZ8y6hnK2ScsR07iE8GKId0db+ax3FSAHRAcALANs+Er6bSstH96922H0MohuOsdZxRIg5OG3pXO8oyHGBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNRhF+C+BRfH/Q/HxnXWYiUXmHzksxNzPxsUWlLj8Yg=;
 b=lLBfePsYJYF3IzTyg2+psKV0H+cQKC3oGnOgmAY9FmoERTqGp07oblFuS6cDNl3WG+Msq77UCAziBkvHsNWmQdOyjkvL5eSsgjVp7nydDMMVsnJ0Bg5R7v2U2eX6fwWyauf1taWl8L/6K2UCTS1H9bahfmMiMECuvstR2SatJqaAtYZ0WBswIuU+F10kuxmjKDFoYj5Mpuu04TCq5gorNuP4uC/AXU7AOAOKCLzhfe1PiOUQGNJryY/AeuEQVoIb5gwkfuUG5ogxlNcP/Ex8EFgvhDPQiSU6yc6BRl3qwmgtaTsSIQ33ZtOCWon4+ow+lkWRi2dw+sza7ST6oy4RuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNRhF+C+BRfH/Q/HxnXWYiUXmHzksxNzPxsUWlLj8Yg=;
 b=Am9NBPmZ6PVRP00/VoHNedW48tYuMysr+vv6fT7eee4aFEn/6NdWkD3yskFpqX/uyTifN/5Qfl/Y7d7ktrtENGvImm1gqsIY+q6vkp97pOK5tQT54IN4jjOnJfWab7LIjy/NGRbNP1jH+i6YsmJpHsv6chcAQZe9DevY04l15tA=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by CH3PR19MB7260.namprd19.prod.outlook.com (2603:10b6:610:14b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 21:54:52 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8242:2254:13b6:74fc]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8242:2254:13b6:74fc%6]) with mapi id 15.20.6363.009; Fri, 28 Apr 2023
 21:54:52 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Andrei Vagin <avagin@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fuse uring / wake_up on the same core
Thread-Topic: fuse uring / wake_up on the same core
Thread-Index: AQHZXonZnrNnGQvxikaxtbJ88GLEB68OcL2AgC/yZYCAAOYogIAAE+eAgADLvYCAAVIbgA==
Date:   Fri, 28 Apr 2023 21:54:51 +0000
Message-ID: <d954ca54-2a3f-b111-7ba5-41169de473ce@ddn.com>
References: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
 <20230327102845.GB7701@hirez.programming.kicks-ass.net>
 <20230427122417.2452-1-hdanton@sina.com>
 <20230428014443.2539-1-hdanton@sina.com>
In-Reply-To: <20230428014443.2539-1-hdanton@sina.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|CH3PR19MB7260:EE_
x-ms-office365-filtering-correlation-id: f804ab61-b329-4f18-c235-08db483331d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUgXJU8E7x8j2VJ1gd1ttSZ8MRjKJ/zkW+jbwFYY7zjqS4K0Ej9IYqBaY1Lv9Oex7NpvZCVkg8aZuJY5p83kZaZqLUBrttGTtEEFAKDkXGrbPgA0CoF4nnK/TybgxYPx188hA1LSseHTsqZ+yhfxbzUhuQxvoZPLNqZrl3C350J1LuBhJ6PFBMW43mE8a6P3UbW1Ao06whNctA14zzaQsCfeuWSwCCeynuHIx8jRTYBuRNsREqCtN1sSKQwpQURvIOjLpC/6d1t8S6uvGNB3WlOTBlIzz63FwOrzNRvzEB/CsUPN50pfcSK6v/RMYcC2wBBqkWkiaYjUBBEyuALLoDZejB2FHBgEENC3C5J0kKmiZi9Gb98MHj+ovO4VgqvXtv+YOJitZbUD4StfTEQUivb2Us37CSJztmxwgfFOkwxs8N2YN1fDC9j6I8IGbE7yrQRu9hbfreo/bPM4Aurmz344rS6YTSHR67UrYF4G5xVrFM2Qi5SlmK+vJQb8wuVIGEeWigmqO2zSVQgpfaQflOxTmhv1/DrbjjGE7RNuuChZkAkjkACktl5aBN/1j3hCpxhqwaS/BjjctNkvRfrTuDChVMs8PVIxpbdwuJ4PpuwdCiU3z9e7LubHAILJZ4GxurbuuarQsIC5SAuvJVn2asifXWxVwnZLiIc/3Ztl0rk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39850400004)(136003)(376002)(451199021)(31686004)(6512007)(186003)(83380400001)(66899021)(2616005)(31696002)(66946007)(6916009)(76116006)(4326008)(54906003)(86362001)(91956017)(38070700005)(5660300002)(316002)(64756008)(66476007)(122000001)(66446008)(38100700002)(66556008)(6486002)(478600001)(71200400001)(41300700001)(8936002)(8676002)(2906002)(36756003)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWJYbzJ5MFBJOGhJTFcrMjFKcDFmbFJvWlM5RVBqSUFzTUQ1aG5BbDkzem9t?=
 =?utf-8?B?a3JNRFNnN0xRaXRjRXJSdDI2S2RwMVBCUEV2K2IwVlE4T2l5QlBiUm5WSTV4?=
 =?utf-8?B?OHZueFdBUVBZd2tnYTQxbXpMWW1oS1JqUng0ZisvODFNa3FmckxqTlA5OGpG?=
 =?utf-8?B?bnZId3NnRDZzdFVXSHoxMXZucTQ5N25YWS84N1N3RXFiTmhEbERWRzc4d29t?=
 =?utf-8?B?RFBMd29FMllXbWZQdTNGRW80VjdXRGYxVVI3RENucGVaVWpuanpXNjk3YjZ3?=
 =?utf-8?B?dmVLT0FzWXNiZ3RKU2hMelJOSjFtZHYvMWxxaGJQME00KzlZVkJMbGdCUzlO?=
 =?utf-8?B?b3pwcysySmgyenYwNER6Y09MWm1jYjdzUzdmM3VEaWp6UUdRMzYzWEpBZmdP?=
 =?utf-8?B?NDNOSWFFTlhod25vcXVHcDJDMjZtQ1VkdEVTbGUwTzFqZ1RuUkJFbjZWWURy?=
 =?utf-8?B?ZW5iWDBrbEpHajFodFhDc1l4YndFdTg4d0kxV2Y1WGZGRVhhWmdMcytRTk8w?=
 =?utf-8?B?enRCSkF4VHJ0RGVPTkRTRjNFWEJWcTRiM200ejcxcTRrR2IwZXd5aXVrNzIx?=
 =?utf-8?B?K3h6T3FsbWtDcDJVcXNNcy9MYUQxNFdpUncvdVhWL003WisvM3N3blZuYzl3?=
 =?utf-8?B?ZTRCN3BHWkJuODdhQzUxbWtSc2lNbVRYUTMvb29INTN2SkliamsydFNYQ2Jr?=
 =?utf-8?B?RmZ1SWN0dVJFc1lnS0xNQWxtWGU4Q2ZXb1RBdG8rOS84S0ViRXk3Rit5OWVE?=
 =?utf-8?B?MzFpWnNheE9NQlZ1ckZxY0lkbTlFc0x3b09KSUxKczl0OUk0VXUzSWRTYVBh?=
 =?utf-8?B?UGVzdWNxUldJT2JaR0pEK2tDa3BSQXJ3MkFuL0FOaC9rRVE1cDVWOWcrbHhi?=
 =?utf-8?B?ZE42SXRkbkFiaFNhREQwamw2WE5DcllrbnBRNU5RbzJtL0g1azNvWFp5cU5o?=
 =?utf-8?B?L0RMRXBxZU40aFdpeTRJb2FQYTlhZ0pDQ25rMnlZMFBMM0xKY3lkbk5ydWpF?=
 =?utf-8?B?eDlHWUE1eFVxYUlrNkN6Rm9FVVdFTlBQOXdyQ0FmY1hEcjNadlYvQS9ja1ky?=
 =?utf-8?B?NTZSNFNIQ3M5bFlQL1U3ZldVYy9GMlhzRXlQMEF1Y2ZmTjdlVTI0ZTZId2Qr?=
 =?utf-8?B?UFF5QjBJK2pjYnhrZlhHYjlaY3dXYkZ1N0hvNzUxbURYaDIzcTR5dHFDMFpD?=
 =?utf-8?B?Y3U3ZHFBWHhuRWQwUVdlQURBNVF5UU9kVThCZDBnLzlHQ29aMFcxbHNJMFhv?=
 =?utf-8?B?OGx6aElBRjVGS0xITDFBNVlieVpSQXJ0SmNMTFYzWWFqbUkrS1g3Z3NVeWxF?=
 =?utf-8?B?TkVVWDBiY01NY3puY1F0UVNlRzh0S0tsSFRWMUo4aDlRVnAvRU1lRVVyRmlr?=
 =?utf-8?B?aUNWcU8wd3FyTzNScFJQYTVOM3ZzcGhjQ2o1a1NRVFlxZnRUTVhVRXZzT0M1?=
 =?utf-8?B?UUlWVnpXQVQzRWJLWHZ5Y0tIL3lnTTJ2T3ljWUVsbFMzUnoxa3FwQWxJYkY2?=
 =?utf-8?B?V1VJY2FaWDZrTUJhMnFycUg2VGk5SWRaazVUOHlpOU9jMjVkMGtJRWlnWmtv?=
 =?utf-8?B?clY0YlVVU0tCenNWYnQ0SDdJNGRPSlFOSElEUEN1SFdQTFFkd2prZ0pDbkQ1?=
 =?utf-8?B?dmR0QmNhYXlEWWhhbDBPNlBUd1laUGw2M1l4NVFTMzFkWTI4YVV6aXI1aVI0?=
 =?utf-8?B?MFBzTFE2dCtEQTlnMFNmNVpON1NNWVJMcDdORmIrbzVxektyWi9kb045QzRt?=
 =?utf-8?B?QnFWMFJQS1liUXpicDNtMHkzMlY1WkpwMWV5bzZycEwrOVZuK080d093OEJY?=
 =?utf-8?B?d253UHAzczR4VUVocHRtU28yMFB0WmpUazVMellMUDByanYwYlF1SnNvblhR?=
 =?utf-8?B?a0p1dHNIZ1lWSkczVENGaFZYQXpobmVvZnJrSDdnalFOaTdJempwTytIZi9V?=
 =?utf-8?B?SEJpdHNBNUFucWI5QVJYUHlibXBkTGpseWx6V2R2dGNqaXRQTURiNkNGLy9Y?=
 =?utf-8?B?akEyc2VndU1oa1NQckl1TlF3K0tNeGU5SW9QNFh6SmhDOE1kY29wMStsb3A0?=
 =?utf-8?B?aWlCUWQvK1pVcncxdUIrRmREK3ZCMDNuVWd6MVFjZDlIeHo1UVFRbGRHc21U?=
 =?utf-8?B?d1VPYjlJemxaLy9aNDlMRGxQZzhZWmpkZVRUTDFQc0dJcEhCQ3l0anZpbzlH?=
 =?utf-8?Q?5ZB4DEvYXtY44M7XzH8Js3I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86B3B5F0812ED549B4D9DDBFED59E235@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f804ab61-b329-4f18-c235-08db483331d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 21:54:51.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgQhl/PDnTz8rMXBLAOh/r21GyUZQik0BUl7L1/nU7KJcJECTzotFQuzyJBGtiDE4xyiQH2n9dq1gpwqtDXqUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7260
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOC8yMyAwMzo0NCwgSGlsbGYgRGFudG9uIHdyb3RlOg0KPiBPbiAyNyBBcHIgMjAyMyAx
MzozNTozMSArMDAwMCBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+DQo+PiBCdHcs
IGEgdmVyeSBoYWNraXNoIHdheSB0byAnc29sdmUnIHRoZSBpc3N1ZSBpcyB0aGlzDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGV2LmMgYi9mcy9mdXNlL2Rldi5jDQo+PiBpbmRleCBjZDdh
YTY3OWMzZWUuLmRkMzJlZmZiNTAxMCAxMDA2NDQNCj4+IC0tLSBhL2ZzL2Z1c2UvZGV2LmMNCj4+
ICsrKyBiL2ZzL2Z1c2UvZGV2LmMNCj4+IEBAIC0zNzMsNiArMzczLDI2IEBAIHN0YXRpYyB2b2lk
IHJlcXVlc3Rfd2FpdF9hbnN3ZXIoc3RydWN0IGZ1c2VfcmVxICpyZXEpDQo+PiAgICAgICAgICAg
aW50IGVycjsNCj4+ICAgICAgICAgICBpbnQgcHJldl9jcHUgPSB0YXNrX2NwdShjdXJyZW50KTsN
Cj4+ICAgIA0KPj4gKyAgICAgICAvKiBXaGVuIHJ1bm5pbmcgb3ZlciB1cmluZyBhbmQgY29yZSBh
ZmZpbmVkIHVzZXJzcGFjZSB0aHJlYWRzLCB3ZQ0KPj4gKyAgICAgICAgKiBkbyBub3Qgd2FudCB0
byBsZXQgbWlncmF0ZSBhd2F5IHRoZSByZXF1ZXN0IHN1Ym1pdHRpbmcgcHJvY2Vzcy4NCj4+ICsg
ICAgICAgICogSXNzdWUgaXMgdGhhdCBldmVuIGFmdGVyIHdha2luZyB1cCBvbiB0aGUgcmlnaHQg
Y29yZSwgcHJvY2Vzc2VzDQo+PiArICAgICAgICAqIHRoYXQgaGF2ZSBzdWJtaXR0ZWQgcmVxdWVz
dHMgbWlnaHQgZ2V0IG1pZ3JhdGVkIGF3YXksIGJlY2F1c2UNCj4+ICsgICAgICAgICogdGhlIHJp
bmcgdGhyZWFkIGlzIHN0aWxsIGRvaW5nIGEgYml0IG9mIHdvcmsgb3IgaXMgaW4gdGhlIHByb2Nl
c3MNCj4+ICsgICAgICAgICogdG8gZ28gdG8gc2xlZXAuIEFzc3VtcHRpb24gaGVyZSBpcyB0aGF0
IHByb2Nlc3NlcyBhcmUgc3RhcnRlZCBvbg0KPj4gKyAgICAgICAgKiB0aGUgcmlnaHQgY29yZSAo
aS5lLiBpZGxlIGNvcmVzKSBhbmQgY2FuIHRoZW4gc3RheSBvbiB0aGF0IGNvcmUNCj4+ICsgICAg
ICAgICogd2hlbiB0aGV5IGNvbWUgYW5kIGRvIGZpbGUgc3lzdGVtIHJlcXVlc3RzLg0KPj4gKyAg
ICAgICAgKiBBbm90aGVyIGFsdGVybmF0aXZlIHdheSBpcyB0byBzZXQgU0NIRURfSURMRSBmb3Ig
cmluZyB0aHJlYWRzLA0KPj4gKyAgICAgICAgKiBidXQgdGhhdCB3b3VsZCBoYXZlIGFuIGlzc3Vl
IGlmIHRoZXJlIGFyZSBvdGhlciBwcm9jZXNzZXMga2VlcGluZw0KPj4gKyAgICAgICAgKiB0aGUg
Y3B1IGJ1c3kuDQo+PiArICAgICAgICAqIFNDSEVEX0lETEUgb3IgdGhpcyBoYWNrIGhlcmUgcmVz
dWx0IGluIGFib3V0IGZhY3RvciAzLjUgZm9yDQo+PiArICAgICAgICAqIG1heCBtZXRhIHJlcXVl
c3QgcGVyZm9ybWFuY2UuDQo+PiArICAgICAgICAqDQo+PiArICAgICAgICAqIElkZWFsIHdvdWxk
IHRvIHRlbGwgdGhlIHNjaGVkdWxlciB0aGF0IHJpbmcgdGhyZWFkcyBhcmUgbm90IGRpc3R1cmJp
bmcNCj4+ICsgICAgICAgICogdGhhdCBtaWdyYXRpb24gYXdheSBmcm9tIGl0IHNob3VsZCB2ZXJ5
IHZlcnkgcmFyZWx5IGhhcHBlbi4NCj4+ICsgICAgICAgICovDQo+PiArICAgICAgIGlmIChmYy0+
cmluZy5yZWFkeSkNCj4+ICsgICAgICAgICAgICAgICBtaWdyYXRlX2Rpc2FibGUoKTsNCj4+ICsN
Cj4+ICAgICAgICAgICBpZiAoIWZjLT5ub19pbnRlcnJ1cHQpIHsNCj4+ICAgICAgICAgICAgICAg
ICAgIC8qIEFueSBzaWduYWwgbWF5IGludGVycnVwdCB0aGlzICovDQo+PiAgICAgICAgICAgICAg
ICAgICBlcnIgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUocmVxLT53YWl0cSwNCj4+DQo+IElm
IEkgdW5kZXJzdGFuZCBpdCBjb3JyZWN0bHksIHRoZSBzZWVzYXcgd29ya2xvYWQgaGludCB0byBz
Y2hlZHVsZXIgbG9va3MNCj4gbGlrZSB0aGUgZGlmZiBiZWxvdywgbGVhdmluZyBzY2hlZHVsZXIg
ZnJlZSB0byBwdWxsIHRoZSB0d28gcGxheWVycyBhcGFydA0KPiBhY3Jvc3MgQ1BVIGFuZCB0byBt
aWdyYXRlIGFueW9uZS4NCg0KVGhhbmsgYSBsb3QgSGlsbGYhIEkgaGFkIGEgZGF5IG9mZiAvIGZh
bWlseSBkYXkgdG9kYXksIGtlcm5lbCBpcyBub3cgDQpldmVudHVhbGx5IGNvbXBpbGluZy4NCg0K
PiANCj4gLS0tIGEvZnMvZnVzZS9kZXYuYw0KPiArKysgYi9mcy9mdXNlL2Rldi5jDQo+IEBAIC00
MjEsNiArNDIxLDcgQEAgc3RhdGljIHZvaWQgX19mdXNlX3JlcXVlc3Rfc2VuZChzdHJ1Y3QgZg0K
PiAgIAkJLyogYWNxdWlyZSBleHRyYSByZWZlcmVuY2UsIHNpbmNlIHJlcXVlc3QgaXMgc3RpbGwg
bmVlZGVkDQo+ICAgCQkgICBhZnRlciBmdXNlX3JlcXVlc3RfZW5kKCkgKi8NCj4gICAJCV9fZnVz
ZV9nZXRfcmVxdWVzdChyZXEpOw0KPiArCQljdXJyZW50LT5zZWVzYXcgPSAxOw0KPiAgIAkJcXVl
dWVfcmVxdWVzdF9hbmRfdW5sb2NrKGZpcSwgcmVxKTsNCj4gICANCj4gICAJCXJlcXVlc3Rfd2Fp
dF9hbnN3ZXIocmVxKTsNCj4gQEAgLTEyMjksNiArMTIzMCw3IEBAIHN0YXRpYyBzc2l6ZV90IGZ1
c2VfZGV2X2RvX3JlYWQoc3RydWN0IGYNCj4gICAJCQkgICBmYy0+bWF4X3dyaXRlKSkNCj4gICAJ
CXJldHVybiAtRUlOVkFMOw0KPiAgIA0KPiArCWN1cnJlbnQtPnNlZXNhdyA9IDE7DQoNCmZ1c2Vf
ZGV2X2RvX3JlYWQgaXMgcGxhaW4gL2Rldi9mdXNlICh3aXRoIHJlYWQvd3JpdGUpIGFuZCB3ZSBk
b24ndCBrbm93IA0Kb24gd2hpY2ggY29yZSB0aGVzZSBJTyB0aHJlYWRzIGFyZSBydW5uaW5nIGFu
ZCB3aGljaCBvZiB0aGVtIHRvIHdha2UgdXAgDQp3aGVuIGFuIGFwcGxpY2F0aW9uIGNvbWVzIHdp
dGggYSByZXF1ZXN0Lg0KDQpUaGVyZSBpcyBhIHBhdGNoIHRvIHVzZSBfX3dha2VfdXBfc3luYyB0
byB3YWtlIHRoZSBJTyB0aHJlYWQgYW5kIHJlcG9ydHMgDQp0aGF0IGl0IGhlbHBzIGluIHBlcmZv
cm1hbmNlLCBidXQgSSBkb24ndCBzZWUgaXQgYW5kIEkgdGhpbmsgTWlrbG9zIA0KbmVpdGhlci4g
Rm9yIGRpcmVjdC1pbyByZWFkIEkgaGFkIGFsc28gYWxyZWFkeSB0ZXN0ZWQgZGlzYWJsaW5nIA0K
bWlncmF0aW9uIC0gaXQgZGlkbid0IHNob3cgYW55IGVmZmVjdCAtIHdlIGJldHRlciBkb24ndCBz
ZXQgDQpjdXJyZW50LT5zZWVzYXcgPSAxIGluIGZ1c2VfZGV2X2RvX3JlYWQgZm9yIG5vdy4NCg0K
V2l0aCBteSBmdXNlLXVyaW5nIHBhdGNoZXMgdGhpbmdzIGFyZSBtb3JlIGNsZWFyDQooaHR0cHM6
Ly9sd24ubmV0L0FydGljbGVzLzkyNjc3My8pLCB0aGVyZSBpcyBvbmUgSU8gdGhyZWFkIHBlciBj
b3JlIGFuZCANCmxpYmZ1c2Ugc2lkZSBpcyBiaW5kaW5nIHRoZXNlIHRocmVhZHMgdG8gYSBzaW5n
bGUgY29yZSBvbmx5Lg0KDQpucHJvYyAgICAvZGV2L2Z1c2UgICAgIC9kZXYvZnVzZSAgICAgZnVz
ZSB1cmluZyAgICBmdXNlIHVyaW5nDQogICAgICAgICAgIG1pZ3JhdGUgb24gICBtaWdyYXRlIG9m
ZiAgbWlncmF0ZSBvbiAgICBtaWdyYXRlIG9mZg0KMSAgICAgICAgIDIwMjMgICAgICAgICAgMTY1
MiAgICAgICAgICAxMTUxICAgICAgICAgMzk5OA0KMiAgICAgICAgIDMzNzUgICAgICAgICAgMjgw
NSAgICAgICAgICAyMjIxICAgICAgICAgNzk1MA0KNCAgICAgICAgIDM4MjMgICAgICAgICAgNDE5
MyAgICAgICAgICA0NTQwICAgICAgICAgMTUwMjINCjggICAgICAgICA3Nzk2ICAgICAgICAgIDgx
NjEgICAgICAgICAgNzg0NiAgICAgICAgIDIyNTkxDQoxNiAgICAgICAgODUyMCAgICAgICAgICA4
NTE4ICAgICAgICAgIDEyMjM1ICAgICAgICAyNzg2NA0KMjQgICAgICAgIDgzNjEgICAgICAgICAg
ODA4NCAgICAgICAgICA5NDE1ICAgICAgICAgMjc4NjQNCjMyICAgICAgICA4MzYxICAgICAgICAg
IDgwODQgICAgICAgICAgOTEyNCAgICAgICAgIDEyOTcxDQoNCihpbiBNaUIvcykNCg0KU28gY29y
ZSBhZmZpbml0eSByZWFsbHkgbWF0dGVycyBhbmQgd2l0aCBjb3JlIGFmZmluaXR5IGl0IGlzIGFs
d2F5cyANCmZhc3RlciB3aXRoIGZ1c2UtdXJpbmcgb3ZlciB0aGUgZXhpc3RpbmcgY29kZS4NCg0K
Rm9yIHNpbmdsZSB0aHJlYWRlZCBtZXRhZGF0YSAoZmlsZSBjcmVhdGVzL3N0YXQvdW5saW5rKSBk
aWZmZXJlbmNlIA0KYmV0d2VlbiBtaWdyYXRlIG9uL29mZiBpcyByYXRoZXIgc2ltaWxhci4gIEdv
aW5nIHRvIHJ1biB3aXRoIG11bHRpcGxlIA0KcHJvY2Vzc2VzIGR1cmluZyB0aGUgbmV4dCBkYXlz
Lg0KDQpGb3IgcGFnZWQgKGFzeW5jKSBJTyBpdCBiZWhhdmVzIGEgYml0IGRpZmZlcmVudCBhcyBo
ZXJlIHVyaW5nIGNhbiBzaG93IA0KaXQgc3RyZW5ndGggYW5kIG11bHRpcGxlIHJlcXVlc3RzIGNh
biBiZSBjb21iaW5lZCBvbiBDUUUgcHJvY2Vzc2luZyAtIA0KYmV0dGVyIHRvIGNob3NlIGFuZCBp
ZGxlIHJpbmcgdGhyZWFkIG9uIGFub3RoZXIgY29yZS4gSSBhY3R1YWxseSBoYXZlIGEgDQpxdWVz
dGlvbiBmb3IgdGhhdCBhcyB3ZWxsIC0gbGF0ZXIuDQoNCg0KPiAgICByZXN0YXJ0Og0KPiAgIAlm
b3IgKDs7KSB7DQo+ICAgCQlzcGluX2xvY2soJmZpcS0+bG9jayk7DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvc2NoZWQuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3NjaGVkLmgNCj4gQEAgLTk1Myw2
ICs5NTMsNyBAQCBzdHJ1Y3QgdGFza19zdHJ1Y3Qgew0KPiAgIAkvKiBkZWxheSBkdWUgdG8gbWVt
b3J5IHRocmFzaGluZyAqLw0KPiAgIAl1bnNpZ25lZCAgICAgICAgICAgICAgICAgICAgICAgIGlu
X3RocmFzaGluZzoxOw0KPiAgICNlbmRpZg0KPiArCXVuc2lnbmVkIAkJCXNlZXNhdzoxOw0KPiAg
IA0KPiAgIAl1bnNpZ25lZCBsb25nCQkJYXRvbWljX2ZsYWdzOyAvKiBGbGFncyByZXF1aXJpbmcg
YXRvbWljIGFjY2Vzcy4gKi8NCj4gICANCj4gLS0tIGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiAr
KysgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+IEBAIC03NDI0LDYgKzc0MjQsOCBAQCBzZWxlY3Rf
dGFza19ycV9mYWlyKHN0cnVjdCB0YXNrX3N0cnVjdCAqDQo+ICAgCWlmICh3YWtlX2ZsYWdzICYg
V0ZfVFRXVSkgew0KPiAgIAkJcmVjb3JkX3dha2VlKHApOw0KPiAgIA0KPiArCQlpZiAocC0+c2Vl
c2F3ICYmIGN1cnJlbnQtPnNlZXNhdykNCj4gKwkJCXJldHVybiBjcHU7DQo+ICAgCQlpZiAoc2No
ZWRfZW5lcmd5X2VuYWJsZWQoKSkgew0KPiAgIAkJCW5ld19jcHUgPSBmaW5kX2VuZXJneV9lZmZp
Y2llbnRfY3B1KHAsIHByZXZfY3B1KTsNCj4gICAJCQlpZiAobmV3X2NwdSA+PSAwKQ0KDQoNCkht
bSwgV0ZfQ1VSUkVOVF9DUFUgd29ya3MgcmF0aGVyIHNpbWlsYXIsIGV4Y2VwdCB0aGF0IGl0IHRl
c3RzIGlmIGNwdSBpcyANCmluIGNwdXNfcHRyPyAgVGhlIGNvbWJpbmF0aW9uIG9mIGJvdGggcGF0
Y2hlcyByZXN1bHRzIGluDQoNCgkJaWYgKHAtPnNlZXNhdyAmJiBjdXJyZW50LT5zZWVzYXcpDQoJ
CQlyZXR1cm4gY3B1Ow0KDQoJCWlmICgod2FrZV9mbGFncyAmIFdGX0NVUlJFTlRfQ1BVKSAmJg0K
CQkgICAgY3B1bWFza190ZXN0X2NwdShjcHUsIHAtPmNwdXNfcHRyKSkNCgkJCXJldHVybiBjcHU7
DQoNCg0KDQpXaGlsZSB3cml0aW5nIHRoZSBtYWlsIGtlcm5lbCBjb21waWxhdGlvbiBpcyByZWFk
eSwgYnV0IGl0IGdvdCBsYXRlLCANCndpbGwgdGVzdCBpbiB0aGUgbW9ybmluZy4NCg0KDQpUaGFu
a3MgYWdhaW4sDQpCZXJuZA0K
