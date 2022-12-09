Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A46482E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLINqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLINqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:46:11 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2083.outbound.protection.outlook.com [40.107.9.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D13663F2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:46:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgdGadaSw/3POcJ45MPq7Z75of/x2rha5+hxtK+0De0v0PyNU2AQw4vAaXn7lXpEujAII4C5aIqSsz2SeY6Wv/XNAJlMOErkvlCX9F/TmptmbPCCX2pdAVBYx9RbiZOhE92a6bu3GAtVqNn5qnAXf6eZojAE95CyMeh3GVq/Hg3HggT+CDbnCJQlgYnRHsUtZKPQEWoNBZ7YPx1jfcYK1oTBr96/UOu6WaMz3sqtYYsYCSP3h/hv0Szt6iaoOV03Z8Te/5/s0gEVcVHGqrnoneW1II431DbeV2mpwXf6WkpIXTzWfkCRXV0P2NPR8JjJVM1BV8nAaNkyNQXSAbQtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh588ykq8gynoLaCMFVWEnyNKPFPcs9IIcEPNmjK+Oo=;
 b=nz2e3kAdV55vtPq7g33SS7JxnFfu2ErWCFYbYyyjxYMBwIB7EGGvsvMgSSIGCfvr0f6hdpmd4npyhTejgvs6pdM18WbLIwHTm0z3qVkR7VM3MQjrG88cLJcqXsRHA32Q7FXYm+CSxJpc2Xz1IJ+PmC2w10ljhXksv9vu/LEjs9xo1V/E2oKiHzmuAsQIfIn8Fi+yfDJ4xD0AbyDJQPS7ns2e1RFvWHfHdfAHnwz063qVe3U+jV3gxFeq78vGwN4l4VHZKABhQiJi5RIXjyzrGzfglTZMGd5rHntvGX+W7WMH75q0c7wc32Yut3HO97XvsO/Mkisgs/eS5MGoPSw6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh588ykq8gynoLaCMFVWEnyNKPFPcs9IIcEPNmjK+Oo=;
 b=fn69swWQ6uIyxrY7+3UAEmxDJB4Od9oVIN84DtaBErIhsBc8JRoy0MriGQp52r4CaXBqnuee7AsdUSjtJ03fXBQaUpPE1o/E8N+pn/Tq1GLzAZGKFu2m3ONCpKlzPeAe2dkYOmsDeJaC+o3DDtnBpwOD73XqpumOEgbPK0/eUMEEktlErkmOW+O7eJoE6tANYkngRYDe2kh2iiZIy62HbO+DaFgqmWHf0Z3s6Vj7NnlaPo/iyiR1MPRONnRYlZ2ynEA/M0UIKaU6mwkxxI1kPp6BCcuvMdd8A/c8N5r+pVxCsXmk1+pY8B9hm11gLiTV0wMtuY2L1yzxqycGOoLtKA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2922.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:18::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 13:46:06 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 13:46:06 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Xander <xandermoerkerken@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xander Moerkerken <xander.moerkerken@omron.com>
Subject: Re: [PATCH] Added ability to vmalloc executable memory
Thread-Topic: [PATCH] Added ability to vmalloc executable memory
Thread-Index: AQHZC8+0uCF1pFWN9k6PUaa8E0LZAK5liXIAgAAF6gCAAAIvgA==
Date:   Fri, 9 Dec 2022 13:46:05 +0000
Message-ID: <ed1c32c0-e882-e7f8-3acf-0c0204fb96ae@csgroup.eu>
References: <20221209131052.64235-1-xander.moerkerken@omron.com>
 <Y5M1UowMyucPOqAl@FVFF77S0Q05N>
 <CAGkG8RF0QNrC=UQ3uwurYQRS-kajYr3=g1qa6d7x=RC55z7ymg@mail.gmail.com>
In-Reply-To: <CAGkG8RF0QNrC=UQ3uwurYQRS-kajYr3=g1qa6d7x=RC55z7ymg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2922:EE_
x-ms-office365-filtering-correlation-id: 7972a276-2628-4af9-f5a5-08dad9ebb863
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b2bQvcuE5o6K6hXJLwU3WOFC8zCIXuynbqbVzEfMrkmpeReFyIHZn5vvO3Q7TVfrgB5m4ociVCmqRqLcnEIY1c9iX8u68DDUSnBtg0N3H3b2hh08dAv449VqXQ8CF2OV7X6CkSJY9I82NVtWw+bYOfN7zlwMvNJNQLXDBfiKxHumIsExXH9RV8lQ1Zj+wkIxxDFswwjPxkAtTkwz7DXmoOp/cAA3r3tz/zl+R6xOyHMZszjWks3P/t54Vg7c9R5mF+AB8S6lbjiacYXcoCtsCRfKnSoutYJZ2LRFjPG4OyWUhHJp+3L+/+73bAz9ZfHS1I4xth06JCA/KPQaQJb7mZ5bNijubI56HVg7JeAPRrjTQZD77UZqPQGhv+GWGXftr1s5QKeRR6RfGbUqXDMSEoxk5rOlXeEiypL2yLFfs36lgQ1ta/7WfT8m8sWm5rD0ZXlOo6zYa+5oQzawgBcqrKhivhdMkh117ww4Ax0HumWyRf8VpOhJhIfWeYqHjNhAODEN7aIbd2pV9qvQy8bLRVqk6coagxpqUcB57vgc0tZYuM3t+llevcs3xIWtyi/Sb7C4ixSKotIMc4usSHIPqpXaPPlNdbBbk6Um4Dq6L1FLlYQ/u5YK0izpyelqG6U4TScq2Nm8tpWJJaeKv3yLKfjwxOaIQCj8iiGmMIO0/4o/LBxQ1PgQaWlZ+z5bme8Epankuu6hfc2alw2JrWymdqjt+H3wU9OoiT1g1eJdIiEDe6EuB5pTS1oUOPLP1v4nOLNryY773QNsks4NEaGTJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(451199015)(316002)(31686004)(66574015)(54906003)(110136005)(71200400001)(36756003)(76116006)(91956017)(6506007)(8936002)(5660300002)(122000001)(38070700005)(8676002)(4326008)(66476007)(64756008)(66446008)(66556008)(66946007)(478600001)(6486002)(2616005)(41300700001)(6512007)(38100700002)(2906002)(26005)(186003)(44832011)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXRKcmZLNVozeXM5UURmNFlVdG5rMThhYUxyNENjSWY0bnJPblMxSEdEeWxv?=
 =?utf-8?B?cGlGblBEejJjYTQ0K1FNOEdtdVFJZm1lRlhoS3VJOC9FVUpoMWo3Q0V3bllu?=
 =?utf-8?B?QnlwOGNzVHZ3Ymg3eXV1ak5neklYREI2b3BaZnVRb3NmNkhlalZPNU1rYVNC?=
 =?utf-8?B?Z0dxVDZ0SGJVTy9FOWhhN0hjMC9JRnFCQVNZLzVEWVBNOTFRK2tVZVExa3FE?=
 =?utf-8?B?bHlKbEVxZHRtMmQ1eitzWWdhdHFDRms0T2xYRUlzbTJZQ1FvYnpsTzgwYWZs?=
 =?utf-8?B?L3k3aWlVV3N2SThQYmprdW1YcHoxbkQrWHBaZHEvbTBkQ0V1a0E3dTEwd2Jv?=
 =?utf-8?B?VDEwbWk0NGtxV1BrdVY4bVR3ak5QSFRPMS9TRHpRNm9ub21uUVQxWkVxS3ds?=
 =?utf-8?B?WVpuNk9vYVU0UWoxT2o3Y0sybWIrMXd0RW80ZkNPWWVmYlQ1YU9iQVZtcE5S?=
 =?utf-8?B?TU5kSEUxelBKNkFEUTZrRFdaU3BOaGZ5MHdLSjc1TWg0dldwUkdxb0JzQWFa?=
 =?utf-8?B?bTZESTB6bWFsMVhuVlpwakk4UVM1WW9laFNHUk15QXFIczUwdDlFRVMwbm03?=
 =?utf-8?B?Nkg3N3F4V2t5WWZnWXpqOWxvdEtWTVNPNTVUY3MwUXZmNXNGZ2tUZ3lFemhL?=
 =?utf-8?B?TGE5YjlBWUFLb3dvZVNCZnJMZFYyWDZweklnamtJem1FbytSRW5qbFcvcUdM?=
 =?utf-8?B?eGpuaHVNQTZsTWtjR3l1Qks5eThnejNUNloybFF3cWZjZU82VXdyOXQ3VFEr?=
 =?utf-8?B?NWh4TlZjSmtxUWR6bnRRbDYwRTA4amFDanp6VFo2SjFtM01iOGFyUkN1OC81?=
 =?utf-8?B?L3VjbEJCZ3d3QzlZL2NBaVFBR0FwSllLc21zc3BleUpHdVVsR3g2ZWJPT2RR?=
 =?utf-8?B?azc1QXFybEtsVm9EUHFXYmozbzIzZmZXSVpLZlE4U0FuYUU0OVUrYmJ6SUFF?=
 =?utf-8?B?K3gwVnU5Q2E0UWtWTzdSVXhwYzl6YXpIQ1FCb0JaNVBhWi8zZUhuaEZvV2U0?=
 =?utf-8?B?STRXUVdmZzZIRkgxKytPeFJPSnRTaHJOdzJCOURWeU5MRzFKRmtXS3orVnlk?=
 =?utf-8?B?NnZrNlBOS1dWamxyYmRyUVU2K2drMVZaK3I0RzZhWFRLdUw3VDRoUkFsaXpv?=
 =?utf-8?B?V0F1Tkw1cm01QXhKdVlZVUxML2I1TDN2MVVabUIrZTdEbmlUUjhTb2l2aW5s?=
 =?utf-8?B?ci9jeE1SbTNCZjN1Z0hxc1FVUTh3VFFQby9pdTF1ejBGRjMzTGxuK3B6aUk1?=
 =?utf-8?B?ZnhUUENTU0JuSXlwU1E1cGhvUnIvQ0x1OFI4Z2NSUWlHODF1K0tsazlxQnhl?=
 =?utf-8?B?eEs5bHRuSXdSZUxFNmFSR3VVelUvcEpMWVp0Y3VrWm5hNXpNdlFtRERKM1VU?=
 =?utf-8?B?LzBUc0FpUlBKUnBNR04xeEdVWGhDTXdmdWNXRFFzOWlNZVgyaGYzWG5za0pu?=
 =?utf-8?B?WEI5dmFSQlQrZHAwWVNic2hERElMYmdBeG81L0l3djNVd3pZcnI0b0FjMitt?=
 =?utf-8?B?eWVvNXp5TmNIU0M4OEZ5TnBqU1YrcXVSWGJJZXNZWjEzTW1uVkw4WFU1M1pn?=
 =?utf-8?B?OVZoUUhBK2U4Z0V0anA0cWtJcTlVb1QrblRKWFU1WnZUM1YreXM2Snlxc3RM?=
 =?utf-8?B?V2p1ZkpqVnc0eCs5SVVTelZTTXl3TEV2WGxnWDFmRTZ3WlFqU0dVNUI5R1U3?=
 =?utf-8?B?YU1QTTdBMURxSTlVN2gxcURVTjN3MFRzQksyMUY5U0FUakJteHVJb1BYb051?=
 =?utf-8?B?aW1qTnRwT2JUalJIQlN3V055aGtJNTFmOGs2QVZsazVwMmJ4R0hOc1IyT2lL?=
 =?utf-8?B?ajhramhsaXdKUHhBMzZQanM1VFFxNXU4K0ZINVJkbFkvL0dCUkJHWjhHWUxp?=
 =?utf-8?B?RTVMOHpjL0VjT3o3RW9qS01hOWdHNGxMV1FmSTVucEVWcHlvVDN5Yk5OYlJK?=
 =?utf-8?B?UXRCMmZORmpkSGR3VEx1Wk50K3pMenlkK2s2QWFBTWtWN0kxeFVRWTg4ajBR?=
 =?utf-8?B?WU1NT2xjTDcrRDExbGRzRGYwZnY5NGkrejZURDNwR0ZyeU53UE1lWWI1M3FZ?=
 =?utf-8?B?Z29LdkpLTjJpYVZ3Wkp1cENnWW5meGpheHRIYVFoN3U4bUFyM1ZWVDR3T09Y?=
 =?utf-8?B?ZkZVcVVzVUljdVlKT1V1L2tyWUczc1Z3aml2MThLN0dMTENBTktvdm9nVHRt?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A3E691068424145AA00A8A1286FA4A3@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7972a276-2628-4af9-f5a5-08dad9ebb863
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 13:46:05.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +k2mw8Uii7Rmoi2zQdF6hGT9RwSZ6tm0WvvQV6NujMLJgpB5ma8fsSeXtu4D0ttphydRiX37sgSJV2D2k7t2mCkmVZVMRbKyySyD/REeReY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2922
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA5LzEyLzIwMjIgw6AgMTQ6MzgsIFhhbmRlciBhIMOpY3JpdMKgOg0KPiAJDQo+IFRo
ZSBwZ3Byb3QgcGFyYW1ldGVyIGdvdCByZW1vdmVkIGJlY2F1c2UsIGFjY29yZGluZyB0byB0aGUg
Y29tbWl0IGxvZywgDQo+IGZvciBubyBvdGhlciBhcHBhcmVudCByZWFzb24gdGhhbiBpdCBiZWlu
ZyBjYWxsZWQgd2l0aCAnUEFHRV9LRVJORUwnIGFzIA0KPiBhbiBhcmd1bWVudCBpbiB0aGUgd2hv
bGUga2VybmVsLiBUaGVyZWZvcmUgaXQgZ290IHJlbW92ZWQuDQo+IFRoaXMgcmVtb3ZlZCB0aGUg
YWJpbGl0eSB0byBhbGxvY2F0ZSB2aXJ0dWFsIG1lbW9yeSB3aXRoIGV4ZWN1dGluZyByaWdodHMu
DQo+IE15IHVzZSBjYXNlIGNvbWVzIGZyb20gaW9yZW1hcCgpLg0KPiBJIHRoaW5rIHRoaXMgaXMg
dXNlZnVsIGZvciBvdGhlcnMgdG9vLg0KPiANCj4gSSBkb24ndCBzZWUgd2h5IHRoaXMgcGdwcm90
IHBhcmFtZXRlciBnb3QgcmVtb3ZlZCBidXQgdGhpcyBpcyB0aGUgDQo+IGFsdGVybmF0aXZlIHRv
IHJldmVydGluZyBpdCB0byB0aGUgb2xkZXIgNS43IGZ1bmN0aW9uLg0KDQpQbGVhc2UgYXZvaWQg
dG9wLXBvc3RpbmcsIGFuZCB1c2Ugb25seSBwbGFpbiB0ZXh0Lg0KDQpJIHRoaW5rIHlvdSBkb24n
dCBhbnN3ZXIgdG8gTWFyaydzIHF1ZXN0aW9uLg0KDQpZb3UgYXJlIGFkZGluZyBhIG5ldyBmdW5j
dGlvbiB0aGF0IG5vIGRyaXZlciB1c2VzIGFwcGFyZW50bHkuIElmIHlvdSBhcmUgDQp3b3JraW5n
IG9uIHNvbWUgcGllY2Ugb2YgY29kZSB0aGF0IG5lZWRzIHRoaXMgbmV3IGZvbmN0aW9uLCB5b3Ug
Y2FuIHNlbmQgDQp0aGlzIHBhdGNoIGFzIHBhcnQgb2YgYSBwYXRjaCBzZXJpZXMgaW5jbHVkaW5n
IHRoYXQgY29kZS4NCg0KQnkgdGhlIHdheSwgd2hlbiB5b3UgbmVlZCBleGVjdXRhYmxlIG1lbW9y
eSwgdGhlIGZvbmN0aW9uIHRvIHVzZSBpcyANCm1vZHVsZV9hbGxvYygpLCB0aGF0J3MgdGhlIG9u
bHkgZnVuY3Rpb24gdGhhdCBnYXJhbnRpZXMgcmVhbCBleGVjdXRhYmxlIA0KbWVtb3J5IG9uIGFs
bCBwbGF0Zm9ybXMuIEZvciBpbnN0YW5jZSwgb24gc29tZSBwb3dlcnBjLCBzZXR0aW5nIHRoZSBY
IA0KYml0IGlzIG5vdCBlbm91Z2ggdG8gZ2V0IGV4ZWN1dGFibGUgbWVtb3J5IGluIHZtYWxsb2Mg
c3BhY2UuDQoNCkNocmlzdG9waGUNCg0KPiANCj4gT24gRnJpLCA5IERlYyAyMDIyIGF0IDE0OjE3
LCBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tIA0KPiA8bWFpbHRvOm1hcmsucnV0
bGFuZEBhcm0uY29tPj4gd3JvdGU6DQo+IA0KPiAgICAgT24gRnJpLCBEZWMgMDksIDIwMjIgYXQg
MDI6MTA6NTJQTSArMDEwMCwgWGFuZGVyIE1vZXJrZXJrZW4gd3JvdGU6DQo+ICAgICAgPiBGcm9t
OiBYYW5kZXIgTW9lcmtlcmtlbiA8eGFuZGVyLm1vZXJrZXJrZW5AZ21haWwuY29tDQo+ICAgICA8
bWFpbHRvOnhhbmRlci5tb2Vya2Vya2VuQGdtYWlsLmNvbT4+DQo+ICAgICAgPg0KPiAgICAgID4g
U2luY2UgcmVsZWFzZSA1LjgtcmMxIHRoZSBwZ3Byb3QgZ290IHJlbW92ZWQgZnJvbSBfX3ZtYWxs
b2MNCj4gICAgICA+IGJlY2F1c2UgdGhlIG9ubHkgdXNhZ2Ugd2FzIFBBR0VfS0VSTkVMIGFzIGFy
Z3VtZW50Lg0KPiAgICAgID4gSG93ZXZlciwgdGhpcyByZW1vdmVzIHRoZSBhYmlsaXR5IHRvIGlu
cHV0IG90aGVyIGFyZ3VtZW50cw0KPiAgICAgID4gc3VjaCBhcyAnUEFHRV9LRVJORUxfRVhFQycs
IHdoaWNoIGNhbiBiZSB1c2VkIHRvIGFsbG9jYXRlDQo+ICAgICAgPiBtZW1vcnkgaW4gd2hpY2gg
eW91IGNhbiBleGVjdXRlLiBGb3IgdGhpcyByZWFzb24gYSBuZXcNCj4gICAgICA+IGZ1bmN0aW9u
IGlzIGludHJvZHVjZWQgY2FsbGVkICdfX3ZtYWxsb2NfZXhlYycuDQo+ICAgICAgPg0KPiAgICAg
ID4gU2lnbmVkLW9mZi1ieTogWGFuZGVyIE1vZXJrZXJrZW4gPHhhbmRlci5tb2Vya2Vya2VuQG9t
cm9uLmNvbQ0KPiAgICAgPG1haWx0bzp4YW5kZXIubW9lcmtlcmtlbkBvbXJvbi5jb20+Pg0KPiAN
Cj4gICAgIFdoYXQgaXMgdGhpcyBnb2luZyB0byBiZSB1c2VkIGZvcj8gVGhlcmUncyBubyB1c2Vy
IGZyb20gdGhpcyBwYXRjaA0KPiAgICAgYWxvbmUsIGFzIGENCj4gICAgIG1vZHVsZSBvciBvdGhl
cndpc2UuDQo+IA0KPiAgICAgTWFyay4NCj4gDQo+ICAgICAgPiAtLS0NCj4gICAgICA+wqAgaW5j
bHVkZS9saW51eC92bWFsbG9jLmggfCAxICsNCj4gICAgICA+wqAgbW0vdm1hbGxvYy5jwqAgwqAg
wqAgwqAgwqAgwqAgfCA4ICsrKysrKysrDQo+ICAgICAgPsKgIDIgZmlsZXMgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspDQo+ICAgICAgPg0KPiAgICAgID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvdm1hbGxvYy5oIGIvaW5jbHVkZS9saW51eC92bWFsbG9jLmgNCj4gICAgICA+IGluZGV4IDA5
NmQ0OGFhMzQzNy4uMTBjNDY1MTNiNmIyIDEwMDY0NA0KPiAgICAgID4gLS0tIGEvaW5jbHVkZS9s
aW51eC92bWFsbG9jLmgNCj4gICAgICA+ICsrKyBiL2luY2x1ZGUvbGludXgvdm1hbGxvYy5oDQo+
ICAgICAgPiBAQCAtMTQ3LDYgKzE0Nyw3IEBAIGV4dGVybiB2b2lkICp2emFsbG9jX25vZGUodW5z
aWduZWQgbG9uZyBzaXplLA0KPiAgICAgaW50IG5vZGUpIF9fYWxsb2Nfc2l6ZSgxKTsNCj4gICAg
ICA+wqAgZXh0ZXJuIHZvaWQgKnZtYWxsb2NfMzIodW5zaWduZWQgbG9uZyBzaXplKSBfX2FsbG9j
X3NpemUoMSk7DQo+ICAgICAgPsKgIGV4dGVybiB2b2lkICp2bWFsbG9jXzMyX3VzZXIodW5zaWdu
ZWQgbG9uZyBzaXplKSBfX2FsbG9jX3NpemUoMSk7DQo+ICAgICAgPsKgIGV4dGVybiB2b2lkICpf
X3ZtYWxsb2ModW5zaWduZWQgbG9uZyBzaXplLCBnZnBfdCBnZnBfbWFzaykNCj4gICAgIF9fYWxs
b2Nfc2l6ZSgxKTsNCj4gICAgICA+ICtleHRlcm4gdm9pZCAqX192bWFsbG9jX2V4ZWModW5zaWdu
ZWQgbG9uZyBzaXplLCBnZnBfdCBnZnBfbWFzaykNCj4gICAgIF9fYWxsb2Nfc2l6ZSgxKTsNCj4g
ICAgICA+wqAgZXh0ZXJuIHZvaWQgKl9fdm1hbGxvY19ub2RlX3JhbmdlKHVuc2lnbmVkIGxvbmcg
c2l6ZSwgdW5zaWduZWQNCj4gICAgIGxvbmcgYWxpZ24sDQo+ICAgICAgPsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgdW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBl
bmQsDQo+ICAgICBnZnBfdCBnZnBfbWFzaywNCj4gICAgICA+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBwZ3Byb3RfdCBwcm90LCB1bnNpZ25lZCBsb25nIHZtX2ZsYWdzLCBpbnQN
Cj4gICAgIG5vZGUsDQo+ICAgICAgPiBkaWZmIC0tZ2l0IGEvbW0vdm1hbGxvYy5jIGIvbW0vdm1h
bGxvYy5jDQo+ICAgICAgPiBpbmRleCBjY2FhNDYxOTk4ZjMuLjhmZDAxZWQ3MDgyYiAxMDA2NDQN
Cj4gICAgICA+IC0tLSBhL21tL3ZtYWxsb2MuYw0KPiAgICAgID4gKysrIGIvbW0vdm1hbGxvYy5j
DQo+ICAgICAgPiBAQCAtMzI5NCw2ICszMjk0LDE0IEBAIHZvaWQgKl9fdm1hbGxvYyh1bnNpZ25l
ZCBsb25nIHNpemUsIGdmcF90DQo+ICAgICBnZnBfbWFzaykNCj4gICAgICA+wqAgfQ0KPiAgICAg
ID7CoCBFWFBPUlRfU1lNQk9MKF9fdm1hbGxvYyk7DQo+ICAgICAgPg0KPiAgICAgID4gKw0KPiAg
ICAgID4gK3ZvaWQgKl9fdm1hbGxvY19leGVjKHVuc2lnbmVkIGxvbmcgc2l6ZSwgZ2ZwX3QgZ2Zw
X21hc2spDQo+ICAgICAgPiArew0KPiAgICAgID4gK8KgIMKgIMKgcmV0dXJuIF9fdm1hbGxvY19u
b2RlX3Byb3Qoc2l6ZSwgMSwgZ2ZwX21hc2ssIFBBR0VfS0VSTkVMX0VYRUMsDQo+ICAgICAgPiAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVU1BX05PX05P
REUsDQo+ICAgICBfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MoMCkpOw0KPiAgICAgID4gK30NCj4g
ICAgICA+ICtFWFBPUlRfU1lNQk9MKF9fdm1hbGxvY19leGVjKTsNCj4gICAgICA+ICsNCj4gICAg
ICA+wqAgLyoqDQo+ICAgICAgPsKgIMKgKiB2bWFsbG9jIC0gYWxsb2NhdGUgdmlydHVhbGx5IGNv
bnRpZ3VvdXMgbWVtb3J5DQo+ICAgICAgPsKgIMKgKiBAc2l6ZTrCoCDCoCBhbGxvY2F0aW9uIHNp
emUNCj4gICAgICA+IC0tDQo+ICAgICAgPiAyLjM3LjINCj4gICAgICA+DQo+IA0K
