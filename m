Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9460EE90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 05:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiJ0DaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 23:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiJ0D3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 23:29:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2095.outbound.protection.outlook.com [40.107.93.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514B14EC7A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLCofz8jgLn1dd7RNmelvlB9v90oo1GW0Wmely5PJKEyTtoQO9xOP7TJ7h3+qoZBnrcXqIuIXSc8yXa60Ucc547IJ6/YUkgpq6YNPEObGQ6xmjbQaEphwyvDRqVCCLqF4Ks2RRMDFIqlDuA9btjDTMDfcrOjeSjpU8sOJeRy6REc0+/Ios88cRjY1CfgPiPRwSK0rl64Tb7aLjbmJA5/KxBASbXFy8csBresTJ8iOp2TdTC+SXEeYvCnL3W6Qs1gzgys4w8h0yROHnDZ0q/xgDj3K0Y1NtzeV+uL+dk/Fh8FAIWIFNVTjOQKE9xn6tHj3mnSzxOuOyvXzIftWyeVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCvoKPN3Qy0uwa+xs+GXlshfNULLkWWD1Nkd60AypYI=;
 b=n8HQ8DRxmHsoAFBJzCtnC0smahSNYdoIP4LWsg2gwvwLM1raaXcI+JvDSYT55rPj3FI/7BPyaSAr9W12JfV89xmfaHOz2sdSAZ7Vl4qwjCEL+ziszhkd9CwUx79kEaliMMZlOQInenLQO88Mszn2rlbJmybB0U0IWxbYUjt+fMbx67RkJJ7FD1OwYmSZMyJ+bFBC8ah6cmnXNyZ7m3KCJMPNvJ0BsU+XRvvPwIO/2M0vqDBLVcoZvnPecQmABis1CrK5sh1NbKKq2AyBYq8izfgNI6NOySaqni81+40RUjsESv7L6QsxO/3B7PgGkDNxsOFUWgeFv9mqUNOeeU0UiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nathanm.com; dmarc=pass action=none header.from=nathanm.com;
 dkim=pass header.d=nathanm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nathanm.onmicrosoft.com; s=selector2-nathanm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCvoKPN3Qy0uwa+xs+GXlshfNULLkWWD1Nkd60AypYI=;
 b=J8cA+tNYo9Tw6F9kpsZRxB/1bkyWE1CuuyQwbpUwnHEFhzdDSdVT7mbvGtIYXxPzctPF5i/5rAQyLkdtjZdK0Vt6WePUWPNGXmczxvj6APFP+KZQlZYZZ5jTFA7ZXjgrxTBHTHrntTGDAlnkX97G0G5kVibwrISrDs49jk57huo=
Received: from BYAPR06MB5573.namprd06.prod.outlook.com (2603:10b6:a03:a8::18)
 by PH0PR06MB7509.namprd06.prod.outlook.com (2603:10b6:510:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 03:29:07 +0000
Received: from BYAPR06MB5573.namprd06.prod.outlook.com
 ([fe80::8680:24cb:c1f9:6497]) by BYAPR06MB5573.namprd06.prod.outlook.com
 ([fe80::8680:24cb:c1f9:6497%5]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 03:29:07 +0000
From:   Nathan Moinvaziri <nathan@nathanm.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
 chars match
Thread-Topic: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering
 if chars match
Thread-Index: AdjoEtBynXV7SUtxSVy5+tznV2O0qAANQzQAAAIz3AAAElDFQAADMAUAAENk3QA=
Date:   Thu, 27 Oct 2022 03:29:07 +0000
Message-ID: <d9c73675-1060-fd8b-958f-50793dca4db4@nathanm.com>
References: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
 <Y1embP5sEp/NPxK0@smile.fi.intel.com>
 <BYAPR06MB557390C5F741300BDE2BAA8BD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75VeNwvAppVdn+wqAYkzDS115ZuJqm9=gu0hyVoz14qWQkA@mail.gmail.com>
In-Reply-To: <CAHp75VeNwvAppVdn+wqAYkzDS115ZuJqm9=gu0hyVoz14qWQkA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nathanm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR06MB5573:EE_|PH0PR06MB7509:EE_
x-ms-office365-filtering-correlation-id: d09cf616-f7b8-4dee-633f-08dab7cb67cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30w2jOt1nVF59Bmve4wpn1YGo7Bpv7ybyg/s0n4GltBeSs0mic6ctTMy2WCtwTJAhg+A74G/yoJhp4Otox3v+ue5OxCtDPNtfURaAD8fQ9FGKAwem3KO+v+nDneiD62keKLLVjGR0mKlrju8+vOcqk70rdjEYqzHMZXypa1skmYRpy6IDxCkJLdgSrjdueE53Q0ZHuxlRrQeTevTnq6wL/OwQfppCQbahzQ8T56XTBIihVJrxApJs/Cfs7BK+WDQeXEywq39kLM/6O8T3VW2grppQdghnSrNYs9QsygQu94TtQTD5Qaz6dBfJd30DOVtExGFSVBRXSWYWWvw5N08ZkOFvX/huiIT81F2JnU2Qv5hrENclctN/oulFqDZYlS7z8eOJkUSro6MbSVzyKZrPM7hjHrrz1wGjov1rd49FyLDa8A/1lHsXWramRNG5aa5XHxMrqMAHpTFiyd6YH4g1QfHpUCCQdnTQMj5uW4lCGOyIKV6GgvCFQ8gAuLtPuNk8FEmqZj5yCCxj1H55zPCUpw62RmSPmcSI6F+/5JuGvBLhWR7sZ66K7xUGGHe8iCEoQPjz0WZC0EogaRKkqDiHlly/KTWJuYSZ+BqaDlHyo3MBMo629zpir3klhQAiBb5Tog2FIp99yy1ZM2W6R887qFORX/sS2QaaRiWJqRNRnmSo3dh+CESEL/66T7BWI7g1BD6fTAmYILte5GYw9I+W+6QCPgwCd1j3ia3YTpVAW3MhDheqVf8qfBWCOlmQKQnbWwt+VDl7eyyaNcpQ4TnEUEjH06F/QonH+uGm7YNohMuCKiE+KuWKDI3o2h4ul5vYWU+wO/4vRbPL1K/z6DxMJqUQK486XzN84QM8kKRWs8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB5573.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(39830400003)(136003)(376002)(451199015)(41300700001)(6512007)(2906002)(26005)(186003)(122000001)(31686004)(2616005)(38070700005)(36756003)(38100700002)(8936002)(5660300002)(76116006)(966005)(478600001)(6486002)(71200400001)(6506007)(53546011)(86362001)(31696002)(66556008)(8676002)(4326008)(64756008)(66946007)(66476007)(316002)(6916009)(66446008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0FLL2piNUJCYmpuL3ZLWDBHQ2pCSytIZzQ4aE9aeWM0cU1EcDhtKyt5aGs5?=
 =?utf-8?B?U1pvcU9UUjNrbXc5OVR1SGg5K2g5NVRzNUJKNUlDRWUyWXlzSXU4WUc0QWNl?=
 =?utf-8?B?QjF1UWFJc0x2Y1Y3ZmhUV1V0b212RTRTVjUzME9IS1pzR1FMMmZVbEtzTTdr?=
 =?utf-8?B?R3p6ZkM1ZDJHOWs5eFkxaDV1aTVTWFNoSElFL3dxeVM3Q2hoSWw0ejJsN0ww?=
 =?utf-8?B?eHdGdXdndTU0L3NYUGRxSXVQMHNPOWwvRnlvdTdpZHlWeFZMd3cvZmVVT2Q3?=
 =?utf-8?B?eHl4d3NnY1RGVFd5REpRUG1rbGwzVDMyeWpBNVpvVHQ4VEt0Z0JYZklkWWN3?=
 =?utf-8?B?azV6d1FGemk2RWFrOVZCaW54ZWlJa3pjYlBCZmJjcWRYYm4xakZ3MkY5OXY4?=
 =?utf-8?B?azdJZ29yVSs4YlpDSzhnUkZLTitWRXlVZVBwU3NaTko0S0JzckJLcXBob2Jv?=
 =?utf-8?B?VmE2dE5RQVNHa2NhT241b05nUVcxeUtkRUM5TlJUMWhtZmNWVmxMcnVWeUFj?=
 =?utf-8?B?NW1MZkxQRlFEbml0OGRleExFNkN0MlhtQjhRdUYzdTRXZlFqZDBuMUtXdWQ2?=
 =?utf-8?B?aExqWnhBMzErQWhicTdRV01Od3VEQnBSZ2pvMVpNSHlIT2FxbjZIc1hGK3Q2?=
 =?utf-8?B?RlphZERKVmg3dzd2dWJyK05PUWNOb0lWQTI5TG0rZFdnR2hjbUR3Zmw1NVVM?=
 =?utf-8?B?SGxBdXoxSWdrQ2Z4aG1sUHhBbjdzMmc3VzErdHg0cW5QWER4YTd5ZkUwWXpN?=
 =?utf-8?B?eEx0cUNIOVZzUTllSWVDTTFoMWpZNjZ6OXFuaGxqbENER2t3bnpkckRkNjEw?=
 =?utf-8?B?a2xTTVlOMlFEd0tPNGZ1Q0lrdXVENlRyL0JwUUNxdXpSWWlQL1MwZzFMRzdZ?=
 =?utf-8?B?SXpGUmdIZFVuazNBQi8vZjN4STcwdjR2ZFlJRTh4aTdQMFZnemRKZFBLOUlD?=
 =?utf-8?B?TW8rNTZtK05BRmZQQnkwdGRJNW90Yk52ZjcvVjhsYW54WG1vSHNpb3hxKzdG?=
 =?utf-8?B?MG4rUUxZWEMrOWdoaldobllXN3RUb3hxbzZuMEN6KzBWL0g2cFZOaUpwQTJW?=
 =?utf-8?B?VXVwRHZ3UFN1VE95Kzl4SUJYc0dUOHVxSC9UTVBZckNvT1MxS2ZXNTZaaFNK?=
 =?utf-8?B?NWt3Y1ZtL0JVZ0lTZ0gweHJkWUpPbXlRSndrSVRVdG8yOExrV3dlaU5yTEd1?=
 =?utf-8?B?NEJ2R2RlbzhkazI3Sk9DZGhRMEg5UjVnWHdMNEFxNHhFQjI3cm5zYktCSFk0?=
 =?utf-8?B?c1Bqa1lPMDFLZGt4VVM3U3lnS25reUlUZVd3NUhPUGFMSlNUc0c2L2wvd1lD?=
 =?utf-8?B?REdTdFhzT2VROVRyenRjNUhDK2VMTmJneEtVTnVBajdzRE9DVDRiL0ZxWDJX?=
 =?utf-8?B?OEUyTmdEVlNzRVRYc25MRzltTnZGNHpkSG1JZEJJMlgvcDJLR3dBUHI0ajRL?=
 =?utf-8?B?MWRmSXpPdFdoOW9KL0o4VnZDcG13ZzNoRE9aTnBkZU1Jbk5ybElVN0hCbFNI?=
 =?utf-8?B?WkY1aHhBUDJZaUk3NnhRN2x3anZjcEdUZkorc3F4SitJbDJVcFBCcVNLbmJl?=
 =?utf-8?B?NC9XYktRT2pLV2ZEazQ2TU5nMkJjZUIwcS92eWZLbktYT1pmWnVRRURsVXl4?=
 =?utf-8?B?ZGRwcFZCV2FzL0hSL1hDdUtkQ3FFeTVMRnBCOGVZdnkza1RUdE9EdzB2YUV0?=
 =?utf-8?B?K0k0MThQSktwL1VoNmttWDYwV3FKQ0I3L1dzYklMWHJxNXdEQytIaFdJdmcx?=
 =?utf-8?B?dUpLY0M2UHoveXBuMGNTdlg4YlJHWHNQT29WTTdXdmE2dVlOZTA1QTRieUpK?=
 =?utf-8?B?ZGRHVVMxMVc2MmdSTEpkWWtrV1Z5UFE2a3pod09ZM21FbGxLbjhGQ091em9D?=
 =?utf-8?B?ZUo0Szcyczc0NXY5UEVIZEk5bTE3YjVXcXZmUnlPeE9jdlJCbHM0MVJZaENH?=
 =?utf-8?B?YkoxQTA3NzVKUUc2YWdGNVNZSTlEc2ZsL0VqRUZsMlF5dndXbTI0Y0Z5WXJz?=
 =?utf-8?B?OWJFWFp5eUhqVGluRklOaEI3eE9hOVVMR2ZMY1lWU25OWndIeVZrNktNejE1?=
 =?utf-8?B?Q3dsMmNLY3ZGZUo0VXdDUkJSTlBJdkk0QmZnRzBQdXQwN3VnZ0EyMUpQdHZY?=
 =?utf-8?Q?d9yw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CCCD1591F4C014EB9DD3188565A1A9D@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nathanm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB5573.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09cf616-f7b8-4dee-633f-08dab7cb67cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 03:29:07.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e74266a-92ff-414a-9879-2149aecc5932
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6t7ndqfZmwVxHgXCUw2BvNcYQoJbjBI0/hLtEqS23xVgMsKz6ObTKI2DPDnim2YQt/PicEuBJ1zKYP6RWpFLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7509
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjUvMjAyMiAxMjoxOSBQTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBMb29rcyBw
cm9taXNpbmcsIGJ1dCBtYXkgSSBzdWdnZXN0IGEgZmV3IHRoaW5nczoNCj4gMSkgaGF2ZSB5b3Ug
Y29uc2lkZXJlZCB0aGUgd29yZC1hdC1hLXRpbWUgdXNlIChsaWtlIHN0cnNjcHkoKSBkb2VzKT8N
Cg0KT25seSBicmllZmx5IGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGZ1bmN0aW9uIHRvIGNoZWNr
IGZvciBhbiBpZGVudGljYWwgDQpjb21wYXJpc29uIGFuZCB0aGUgYWRkZWQgY2hlY2sgaHVydCBw
ZXJmb3JtYW5jZSBmb3Igc3RyaW5ncyB0aGF0IHdlcmUgDQpub3QgaWRlbnRpY2FsLg0KDQpPbiAx
MC8yNS8yMDIyIDEyOjE5IFBNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQoNCj4gMikgaW5zdGVh
ZCBvZiB1c2luZyB0b2xvd2VyKCkgb24gYm90aCBzaWRlcywgIGhhdmUgeW91IGNvbnNpZGVyZWQN
Cj4gKHdpdGggdGhlIGFib3ZlIGluIG1pbmQpIHRvIHVzZSBYT1Igb3ZlciB3b3JkcyBhbmQgaWYg
dGhleSBhcmUgbm90IDAsDQo+IGNoZWNrIGlmIHRoZSByZXN1bHQgaXMgb25lIG9mIHBvc3NpYmxl
IGNvbWJpbmF0aW9ucyBvZiAweDIwIGFuZCB0aGVuDQo+IGJ5IGV4Y2x1ZGluZyB0aGUgbm9uLWxl
dHRlcnMgZnJvbSB0aGUgcmFuZ2UgeW91IG1heSBmaW5kIHRoZQ0KPiBkaWZmZXJlbmNlPw0KDQpJ
J20gbm90IHN1cmUgd2hhdCB5b3UgbWVhbiBhYm91dCB0aGUgcG9zc2libGUgY29tYmluYXRpb25z
IG9mIHRoZSBzcGFjZSANCmNoYXJhY3Rlci4gSSBoYXZlIG5vdCBpbnZlc3RpZ2F0ZWQgdGhpcyBt
ZXRob2QuDQoNCi4uLg0KDQpBY2NvcmRpbmcgdG8gbXkgcHJldmlvdXMgZmluZGluZ3MgdGhlIGNo
ZWNrIGZvciBjMSAhPSBjMiBkb2VzIHBlcmZvcm0gDQpiZXR0ZXIgZm9yIHN0cmluZ3MgdGhhdCBh
cmUgYXQgbGVhc3QgMjUlIG9yIG1vcmUgdGhlIHNhbWUuIEkgd2FzIGFibGUgdG8gDQpnZXQgZXZl
biBtb3JlIHBlcmZvcm1hbmNlIG91dCBvZiBpdCBieSBjaGFuZ2luZyB0b2xvd2VyKCkgdG8gdXNl
IGEgDQpkaWZmZXJlbnQgaGFzaCB0YWJsZSB0aGFuIHRoZSBvbmUgdXNlZCBmb3IgdGhlIGlzKigp
IGZ1bmN0aW9ucy4gQnkgdXNpbmcgDQphIHByZS1nZW5lcmF0ZWQgaGFzaCB0YWJsZSBmb3IgYm90
aCBpc2xvd2VyKCkgYW5kIGlzdXBwZXIoKSBpdCBpcyANCnBvc3NpYmxlIHRvIHJlbW92ZSB0aGUg
YnJhbmNoIHdoZXJlIGV2ZXIgdGhvc2UgZnVuY3Rpb25zIGFyZSB1c2VkLCANCmluY2x1ZGluZyBp
biBzdHJjYXNlY21wLiBUaGlzIG1ldGhvZCBJJ3ZlIHNlZW4gZW1wbG95ZWQgaW4gdGhlIEFuZHJv
aWQgDQpjb2RlIGJhc2UgYW5kIGFsc28gaW4gY1VSTC4gVXNpbmcgaXQgd291bGQgYWRkIGFkZGl0
aW9uYWwgMngyNTYgYnl0ZXMgdG8gDQp0aGUgY29kZSBzaXplIGZvciB0aGUgdGFibGVzLg0KDQpJ
J3ZlIHB1dCB0b2dldGhlciBhIFF1aWNrIEJlbmNobWFyayB0aGF0IHNob3dzIHRoZSBjb21wYXJp
c29uIGJldHdlZW4gDQp0aGUgZGlmZmVyZW50IG1ldGhvZHM6DQoNCmh0dHBzOi8vcXVpY2stYmVu
Y2guY29tL3EvbDVEa1lRTy1DY014UVV1NU1qWmlxWjhNLVkwDQoNCk5hdGhhbg0KDQoNCg0K
