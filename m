Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16935F743E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJGGdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGGdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:33:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2058.outbound.protection.outlook.com [40.107.113.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF180C4594
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDnMlgPmE3U9kD5IQHhsy9tpT7iVSXWDoOariPX9QubmGreIUF8D+PG2JTpxX6fr7XC0BEjrTYRWHLeSezo6N+NpQNHPmp9N/HPlc4NCssB2VQ1W2GXGVWnQ1SUysfozpchnfy7Sz+nWRJBmcNLN5+iMZBfH5dN9DTnic43QIJgK4t/klE6oHaMNqzCej9hOrlDrXEFXxYNNvlYzef0XREsgCqOarYHmztTuJ7/ARMUEsCpDrqbeKaMPrPkQ73zSzCsGGVb4y+unrA+XkjI27nxGvzbp2osYoV1LTCLLsgcJYUKM5RztdgdCwFTvs2A8d+13RjS/Rfi7PkOq267H5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8ejqPIydOt/omU9lxMjFYmVvUG4d7ePN3xLqSjQ9Qs=;
 b=ca+xfNWRV5VzEzHHmwQMDmAVneIsf5zsWCGQ3lHZ2WwOR75YnugKRmubDHbvcAmbQ9jVij92ovb8OroX6ISWOwbcz+HRPbEJu4LLx7AcR9wDwX8a7HHC+bABTYnw7FcHQDkarCcHaBhw6KGiTAyYUlsp4YKx8c8YZaVvCcQAe7jg42s5dyozlgX5D6cQ+71u4HMg63YtH5MYJE8kpW6LVczp4Qvzf7IBU1bWRV1kyg1Mj9uzogU4aytlOBnA/Jy5g9hyV/xQw2UtLPcdwZkl0g6SbMq+sbcbWWYyRADdJUzegzHFvzk9r9M1SEtFAGju7dm1jbI3vpSincDChue7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8ejqPIydOt/omU9lxMjFYmVvUG4d7ePN3xLqSjQ9Qs=;
 b=NL9TOezlBhtq6Zl2AZrnW0qkemmDIUNz3n3Bo1trBAMrNeq7s03cfvQZJzZ9sMaFySyTr7/YKpKRl6rTvEMZxhH0Jt8RvaaCBQy0zdXJr9j63EqzNz5a/YJJv+gsp2kd2+0H6Jn5enw4O+yD+wYHUeRwiwFm0sqJS+pTooQlpIQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS0PR01MB5522.jpnprd01.prod.outlook.com (2603:1096:604:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 06:33:43 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::982:49a5:97ae:7673]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::982:49a5:97ae:7673%8]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 06:33:43 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Thomas Tai <thomas.tai@oracle.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "reinette.chatre@intel.co" <reinette.chatre@intel.co>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Thread-Topic: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Thread-Index: AQHY01Cowhk66J+WxEi+gvpepeTKP64ChtuA
Date:   Fri, 7 Oct 2022 06:33:43 +0000
Message-ID: <20221007063343.GA3240211@hori.linux.bs1.fc.nec.co.jp>
References: <20220928153832.1032566-1-thomas.tai@oracle.com>
 <20220928153832.1032566-2-thomas.tai@oracle.com>
In-Reply-To: <20220928153832.1032566-2-thomas.tai@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OS0PR01MB5522:EE_
x-ms-office365-filtering-correlation-id: c8081483-56d0-43a4-c12c-08daa82de188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5sYJDHrVd1VnXpz03lYCi1cJSGdLD3RnYSayPgi95sbXEFxdo4D7tc7gGTCrh/FutnLXhf8OuOW06YRWoFI7/Dl/QtuZ2U+DKGtAm1RjMaBHhgjvOIHrNqV695Vzoi9JPQ+fobeplQEX9acmE4mVkxkAdty2ei8DqYafp8LEIAiTNeGTh0pTfRDh5yoU+oKAfkq5ieu9P/s9HweAK/aN0wQ0D99HEWsu6iPkTsC935AANMQHKv+TIB9G4zJE+ks/LKINLsYbXfmVQCsIPx3xofxCaTslrkghWh+/Dt1GtuLGkGfOWSvIKJDkzrqOYiEl9oKjBeG/RW2xkWbmlOMgUXxy5ufw1xUp7Cquf9Ux/G+A3kI6ang6Za3duuiZCZCpQd3rO9w3t9wQl6LQin97ZHKmTJfHtpYnYrxOgbkmf/T3qRDN8OYPeOWhddWTyKORDnwyJzw6r4FpTNg9dXb6uwLeXb7VY3Mms9oZnO9a9Mtn84u8U6+oS4uh6inkLjOOF8lorI6IQmwWlXKDpcLgePd6r2Xk3miMB+VMFJWHdGC1fHo/cGumEo8dPdJGhgoxdQYaWA9hsfIvtAmbQ6VTZiJok/PDfc2/EWdCO5a+6v6C3tkhXKA20zWZuFM82kIafcdZetwofYvgpHiakJcaWArQauntwbZOps40tCol/4YMjKXJjLIN6Spl6gTgpQzV2RtmmzNs9imtwM9GFzxmDECb97oHuqQ1891otwefSYoRPMj6GUjwhRyR7OBdeu7fN3+9IkYbgAVkVJpVXoRgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(316002)(4326008)(64756008)(6916009)(8676002)(66476007)(66446008)(54906003)(66946007)(76116006)(71200400001)(6486002)(478600001)(85182001)(26005)(122000001)(38100700002)(82960400001)(66556008)(41300700001)(55236004)(9686003)(6506007)(33656002)(6512007)(2906002)(83380400001)(86362001)(5660300002)(38070700005)(1076003)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUp4NlpYcVk4ZDg3aXRuUzZKZmkvNVM3NW9oNG0wY08wRzdGb1V1OFFhZlF0?=
 =?utf-8?B?b25zT01JckhzTUFxcXB4YjdjcG5ZekV0K1NYWkNlSFFwQXUxSjYzNXNCSzNo?=
 =?utf-8?B?cUpHTy9yVzJtS0hCazVhNG9EUEt6T2l5a2RrUEwwQ3gwTHcyRWs3WDNSSllo?=
 =?utf-8?B?aHZDTGtBeDNlTGIrS1QxcTZlc3MyaDMxRFAxT1MvV1IvVEJtWGhOYnluYVR6?=
 =?utf-8?B?Qi9VWDd5b0gvdVBHSXRPY3ZmK1N3MmgvcC9hZGZ6aEJrZGI1aVNpcC92eVhw?=
 =?utf-8?B?QmNxTHRkdndYS2cwZmRkVW9WRUNDYUgvM1JiQjh0aDU3M2t0cTlxaERPNTFQ?=
 =?utf-8?B?S21vTUw0RUNQT2pZY0pMblRUaERQRWVHd3pkclJsOFNzc0wzalJPMG9ZcXkz?=
 =?utf-8?B?T3ZLbFVtOUcvNkE2dTBQK2F1cURBYUdXbGttcGVCRnBrNi9NNnBtc1BWdWVH?=
 =?utf-8?B?M2pDTjl4cDN0TTVmeW9YVjlEdUh3Wks5U0NyZWY2aDdpbm5TS3Mwc0V0cnBT?=
 =?utf-8?B?UHR3aTBuNStKeThvajVQelhwRSt5Q3RPRUR5S3dydVMxU2gxWGFOa1pQTGJy?=
 =?utf-8?B?N2N2c3FpYzg1b1JmNk5vWmV0Y0paK0gyRHFsbUJzbE40c1dIOFZIRXhnczhD?=
 =?utf-8?B?M3FIcjdONEg3dEVwWTJ0VGRxc1p2L202VWFjVEdoYzl2ZER3czlDaXM2RENo?=
 =?utf-8?B?TUVnRngwUEkyNmtkaFdoSi9Za3hCNm4vd1orUHp4QytuVWJRVzhzNEJLTUF0?=
 =?utf-8?B?dTJhTWFlYmM3VzR6MTFYbk0xbVZWemZ4MVlzMFo4NFIzU0pxNW9IU284Q2Ru?=
 =?utf-8?B?RCtJVkpSUHByV1hsK003VnJDVFRWU2tFaVV4NS80MHpGT0J3VG1lbGpjSGN6?=
 =?utf-8?B?OFR0eitRU0tvUHFpdGYvUzNLMHJmZzBBOTJkZ2ltcUhKUWcvT2pVL2Q1aXNL?=
 =?utf-8?B?clVCRGIwZGE1K1pla0xkTHZKTFlnMXJSZjVaUjM0bGpSdUk2ZHNNVFlmMUFq?=
 =?utf-8?B?TlNSQkp1eERnRGVTcHE5VTREVmxvdjNraU1JcW00Z0NWU1E4VEZWZ2VLbThu?=
 =?utf-8?B?ZWxORG5sNlhidStidTJsbCtUYzhtVC9Od3kxWTJEK0ZjQUdNclVoc1JZd05z?=
 =?utf-8?B?K3E0U3RxMUtzVjM0eGxyYzZpUlNZd3FKc0dqTWpHZnBkNFFhdGhjSjNUbDha?=
 =?utf-8?B?MGtOeTlpYWNEQmQxVVVhdmM4dEhjUUE3ZFVhNVRkaWpLeUlWeHJiSXl1ZTFP?=
 =?utf-8?B?eVpJRnVrZkQyMUpnaGx3UENIcVVmTTRkQksyQjVzOVRQN2puY2h4ajRUdWpa?=
 =?utf-8?B?UUNwM3lXRlYzdlMrY2FJcEFTTHZCdFZvSG42elczczJ2WTBPaVQyUm9qbjRv?=
 =?utf-8?B?Q1JkV2ZOT2tscys5eGpQclhHZUh5ZnpXMmRVUkhnS3FKcmNldWNQMG5YV0Fj?=
 =?utf-8?B?Q2ZMUVVVTGdwd2g2LzViNnY5VUY5R1RpOGpXZGFJMHR3STBGc29LamkvZTAw?=
 =?utf-8?B?Rml1Wm9XWS85K0RWbnVxV1JkcFVGM29OM0pJenpxRkY5OHpSVWxCWjVuVnk5?=
 =?utf-8?B?R3lqbUh3NGc1M0lpN1FtTGVHQ3dOUlVKc2pBc3ozY0dNS1hMSDJrY2xyY00y?=
 =?utf-8?B?N0Y2ZVBvb0lRVlM1N3psNUxpd2Z2b2lLaWI0eWUvUFM2Rm5SdXpPN3gxcDg3?=
 =?utf-8?B?bWhjUlpHL29DZ2ltYWVORGhmN1lpVUJMVDN1RmcrNFh3YTh5Ri94Tm1JNTQv?=
 =?utf-8?B?QkY5dFY0dmRRdS9uTk1kK3E3Smd3eks3RHVyWGJOTW14d0JmWVBsYzVRcFI3?=
 =?utf-8?B?M056L3dCTDRQY08xZEh2Z2FmWThiNFQ1VFBwR0hxdWx2SVhzQ1R2MURZNlB1?=
 =?utf-8?B?MGJRc1ZrZWp5bXVGZTVTSXR6Y0xLMVozYjBMNW5qRzNnSmFsdTgwQ1g0WHhN?=
 =?utf-8?B?WkZHZXRqMVRYQTJBdXRaRElrSVVkR21nRHhhbWpTeHNpSk1wckpFdlNHWU5w?=
 =?utf-8?B?RTBHRkxnblFXUCtNbksyb0lmRHZmWENhbU1GZU83cXdUVlhMb2lMb3UvbG5J?=
 =?utf-8?B?eXpONDZPeGFKNmttZFdYNzBnNGp2NEY5WkVHaDJET2lqdGRoV1czT2NONElY?=
 =?utf-8?B?RWpLc2hBb1AvcUF6OGswTXZZTEpwelNhMTVjN0xIYkIrSmpxcUtIdnpyRzFV?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDA8386DED5E82479C57515DC242CCBF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8081483-56d0-43a4-c12c-08daa82de188
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 06:33:43.7020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxTgezo74J/3HSCF2Jst5feVXwBi8qoG+hdIpeIJiASCX9gQD+rXuRVPozrKk85N6LF+idGBekfop0XcEt4PYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBTZXAgMjgsIDIwMjIgYXQgMTE6Mzg6MzJBTSAtMDQwMCwgVGhvbWFzIFRhaSB3cm90
ZToNCj4gSW5zcGlyZWQgYnkgY29tbWl0IGM2YWNiMWU3YmY0NiAoeDg2L3NneDogQWRkIGhvb2sg
dG8gZXJyb3IgaW5qZWN0aW9uDQo+IGFkZHJlc3MgdmFsaWRhdGlvbiksIGFkZCBhIHNpbWlsYXIg
Y29kZSBpbiBod3BvaXNvbl9pbmplY3QgZnVuY3Rpb24gdG8NCj4gY2hlY2sgaWYgdGhlIGFkZHJl
c3MgaXMgbG9jYXRlZCBpbiBTR1ggTWVtb3J5LiBUaGUgZXJyb3Igd2lsbCB0aGVuIGJlDQo+IGhh
bmRsZWQgYnkgdGhlIGFyY2hfbWVtb3J5X2ZhaWx1cmUgZnVuY3Rpb24gaW4gdGhlIFNHWCBkcml2
ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgVGFpIDx0aG9tYXMudGFpQG9yYWNsZS5j
b20+DQoNClRoYW5rIHlvdSBmb3Igc2VuZGluZyBwYXRjaC4NCg0KPiAtLS0NCj4gIERvY3VtZW50
YXRpb24vbW0vaHdwb2lzb24ucnN0IHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gIG1tL2h3cG9pc29uLWluamVjdC5jICAgICAgICAgIHwgIDQgKysrKw0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9tbS9od3BvaXNvbi5yc3QgYi9Eb2N1bWVudGF0aW9uL21tL2h3cG9pc29uLnJzdA0K
PiBpbmRleCBiOWQ1MjUzYzEzMDUuLjhhNTQyYWNhNDc0NCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9tbS9od3BvaXNvbi5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9tbS9od3BvaXNv
bi5yc3QNCj4gQEAgLTE2Miw2ICsxNjIsNTAgQEAgVGVzdGluZw0KPiAgDQo+ICAgIFNvbWUgcG9y
dGFibGUgaHdwb2lzb24gdGVzdCBwcm9ncmFtcyBpbiBtY2UtdGVzdCwgc2VlIGJlbG93Lg0KPiAg
DQo+ICsqIFNwZWNpYWwgbm90ZXMgZm9yIGluamVjdGlvbiBpbnRvIFNHWCBlbmNsYXZlcw0KPiAr
DQo+ICsgIDEpIERldGVybWluZSBwaHlzaWNhbCBhZGRyZXNzIG9mIGVuY2xhdmUgcGFnZQ0KPiAr
DQo+ICsJZG1lc2cgfCBncmVwICJzZ3g6IEVQQyINCj4gKw0KPiArCXNneDogRVBDIHNlY3Rpb24g
MHg4MDAwYzAwMDAwLTB4ODA3ZjdmZmZmZg0KPiArCXNneDogRVBDIHNlY3Rpb24gMHgxMDAwMGMw
MDAwMC0weDEwMDdmZmZmZmZmDQo+ICsNCj4gKyAgMikgQ29udmVydCB0aGUgRVBDIGFkZHJlc3Mg
dG8gcGFnZSBmcmFtZSBudW1iZXIuDQo+ICsNCj4gKwlGb3IgNEsgcGFnZSBzaXplLCB0aGUgcGFn
ZSBmcmFtZSBudW1iZXIgZm9yIDB4ODAwMGMwMDAwMCBpcw0KPiArCTB4ODAwMGMwMDAwMCAvIDB4
MTAwMCA9IDB4ODAwMGMwMC4NCj4gKw0KPiArICAzKSBUcmFjZSBtZW1vcnlfZmFpbHVyZQ0KPiAr
DQo+ICsJZWNobyBub3AgPiAvc3lzL2tlcm5lbC90cmFjaW5nL2N1cnJlbnRfdHJhY2VyDQo+ICsJ
ZWNobyAqbWVtb3J5X2ZhaWx1cmUgPiAvc3lzL2tlcm5lbC90cmFjaW5nL3NldF9mdHJhY2VfZmls
dGVyDQo+ICsJZWNobyBmdW5jdGlvbiA+IC9zeXMva2VybmVsL3RyYWNpbmcvY3VycmVudF90cmFj
ZXINCj4gKw0KPiArICA0KSBJbmplY3QgYSBtZW1vcnkgZXJyb3INCj4gKw0KPiArCW1vZHByb2Jl
IGh3cG9pc29uLWluamVjdA0KPiArCWVjaG8gIjB4ODAwMGMwMCIgPiAvc3lzL2tlcm5lbC9kZWJ1
Zy9od3BvaXNvbi9jb3JydXB0LXBmbg0KPiArDQo+ICsgIDUpIENoZWNrIHRoZSB0cmFjZSBvdXRw
dXQNCj4gKw0KPiArCWNhdCAvc3lzL2tlcm5lbC90cmFjaW5nL3RyYWNlDQo+ICsNCj4gKwkjIHRy
YWNlcjogZnVuY3Rpb24NCj4gKwkjDQo+ICsJIyBlbnRyaWVzLWluLWJ1ZmZlci9lbnRyaWVzLXdy
aXR0ZW46IDIvMiAgICNQOjEyOA0KPiArCSMNCj4gKwkjICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF8tLS0tLT0+IGlycXMtb2ZmDQo+ICsJIyAgICAgICAgICAgICAgICAgICAgICAgICAgIC8g
Xy0tLS09PiBuZWVkLXJlc2NoZWQNCj4gKwkjICAgICAgICAgICAgICAgICAgICAgICAgICB8IC8g
Xy0tLT0+IGhhcmRpcnEvc29mdGlycQ0KPiArCSMgICAgICAgICAgICAgICAgICAgICAgICAgIHx8
IC8gXy0tPT4gcHJlZW1wdC1kZXB0aA0KPiArCSMgICAgICAgICAgICAgICAgICAgICAgICAgIHx8
fCAvIF8tPT4gbWlncmF0ZS1kaXNhYmxlDQo+ICsJIyAgICAgICAgICAgICAgICAgICAgICAgICAg
fHx8fCAvICAgICBkZWxheQ0KPiArCSMgICAgICAgVEFTSy1QSUQgICAgIENQVSMgIHx8fHx8ICBU
SU1FU1RBTVAgIEZVTkNUSU9ODQo+ICsJIyAgICAgICAgICB8IHwgICAgICAgICB8ICAgfHx8fHwg
ICAgIHwgICAgICAgICB8DQo+ICsJICAgICAgICBiYXNoLTEyMTY3ICAgWzAwMl0gLi4uLi4gICAx
MTMuMTM2ODA4OiBtZW1vcnlfZmFpbHVyZTwtc2ltcGxlX2F0dHJfd3JpdGUNCj4gKwkgICAgICAg
IGJhc2gtMTIxNjcgICBbMDAyXSAuLi4uLiAgIDExMy4xMzY4MTA6IGFyY2hfbWVtb3J5X2ZhaWx1
cmU8LW1lbW9yeV9mYWlsdXJlDQoNCkluIG90aGVyIGNhc2VzIG9mIHBhZ2UgdHlwZXMsIG1lbW9y
eV9mYWlsdXJlKCkgbGVhdmVzIHNvbWUga2VybmVsIG1lc3NhZ2UNCmxpa2UgIk1lbW9yeSBmYWls
dXJlOiAweDEwY2YwOTogcmVjb3ZlcnkgYWN0aW9uIGZvciBmcmVlIGJ1ZGR5IHBhZ2U6IFJlY292
ZXJlZCIsDQp3aGljaCBpcyBwcmludGVkIG91dCBieSBhY3Rpb25fcmVzdWx0KCkuICBTbyBJIHRo
aW5rIGl0J3MgYmV0dGVyIHRvIGFkanVzdCB0bw0KdGhpcyBjb252ZW50aW9uIGFsc28gaW4gU0dY
IHBhZ2UncyBjYXNlLiAgVGhlbiwgeW91IGRvbid0IGhhdmUgdG8gdXNlIGZ0cmFjZQ0KdG8gY29u
ZmlybSB0aGUgcmVzdWx0IG9mIGVycm9yIGluamVjdGlvbi4NCg0KVGhhbmtzLA0KTmFveWEgSG9y
aWd1Y2hpDQoNCj4gKw0KPiAgUmVmZXJlbmNlcw0KPiAgPT09PT09PT09PQ0KPiAgDQo+IGRpZmYg
LS1naXQgYS9tbS9od3BvaXNvbi1pbmplY3QuYyBiL21tL2h3cG9pc29uLWluamVjdC5jDQo+IGlu
ZGV4IDY1ZTI0MmI1YTQzMi4uYmY4MzExMWMxZDliIDEwMDY0NA0KPiAtLS0gYS9tbS9od3BvaXNv
bi1pbmplY3QuYw0KPiArKysgYi9tbS9od3BvaXNvbi1pbmplY3QuYw0KPiBAQCAtMjEsNiArMjEs
MTAgQEAgc3RhdGljIGludCBod3BvaXNvbl9pbmplY3Qodm9pZCAqZGF0YSwgdTY0IHZhbCkNCj4g
IAlpZiAoIWNhcGFibGUoQ0FQX1NZU19BRE1JTikpDQo+ICAJCXJldHVybiAtRVBFUk07DQo+ICAN
Cj4gKwkvKiBJbmplY3QgdGhlIGVycm9yIGlmIHRoZSBwYWdlIGlzIHBhcnQgb2YgdGhlIHByb2Nl
c3NvciByZXNlcnZlZCBtZW1vcnkgKi8NCj4gKwlpZiAoYXJjaF9pc19wbGF0Zm9ybV9wYWdlKHBm
biA8PCBQQUdFX1NISUZUKSkNCj4gKwkJZ290byBpbmplY3Q7DQo+ICsNCj4gIAlpZiAoIXBmbl92
YWxpZChwZm4pKQ0KPiAgCQlyZXR1cm4gLUVOWElPOw0KPiAgDQo+IC0tIA0KPiAyLjMxLjE=
