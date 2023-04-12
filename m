Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCDB6DFC23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjDLRBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjDLRB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:01:26 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF38698
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngrhajGRlXSi7asm8qUcXw1g3ZlRPSNykMoCJBbtt18IPEx40N9NGXUFt67Na22gR/9pdrhhIySJEJnvoXfFDfIV8/yszBwNYyTeOgo8boouWQkpawLroaLyXXKbaPlgV2wd9yuCNaJoszal0MCu+LiZ4pgY8k9kyQzUKhT2YGQ8Ldc2n9E81rUOSG7aATlG3vkMyLIaN6J3wnWRehg48nHnKBCwIouHsRDbOX9Fdati4Pe2zSJ+e23yZXH0xFz1glvkhm3Sr5qPlbLCjyW8ySTaAcNauiItY6/HAfl8TIHKaYgnuLgx4ZSmADi5ng+BRdRrRyEgsOx6naxaEc5sMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLER7wPvH9ED6SmWkNyjUv1DUvnSHd7aK4mIwvXto/A=;
 b=dvlAqVaPPLVq/OzyvAd+KZKy+EiZP5iES0GsWWOFPnfw2twUB0FEeaTG/gKksnhb2dyOy26ABJogoQqDaV9R2Hv/K8sJH/RdqmcFcFoYtp5j/0Pob5FmCFjh9HZo74PtH17ET7wTUczJxg9UXI9RBjngzFpJG7vdR9r2G/rhyH4a9+VSQ98S0+A+4vVOhNFdzSv2PLbuZLz4sSq2kGTgt7hfafkstHTjdqd8Hjhss6TmglCeSe1Blk0TgB92IhI9ieEInLdXdd9/B9KgVlUlTWt45QF6jlYf5L/25mMEmqikIgFxsX2iYxaxyaKGO7MmeyGy8hcnbDlOpP2J6NTiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLER7wPvH9ED6SmWkNyjUv1DUvnSHd7aK4mIwvXto/A=;
 b=fmGnN9SnLudAtnUcBalt1jQUXptXna7gN+npqRUTBg5dnoQyiy0pIimoNDvHy44WSr4Kotx2fRgouCLPM/iXJD4MphpCC2aWe6VLuGXIMseSVHwdy19oAmcGRe3uyzA2PC+qpaui7Vv1kn9TOGBjnWEJiOpuggcrkUM4GOpY8YM=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by IA1PR05MB10080.namprd05.prod.outlook.com (2603:10b6:208:3db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 17:00:49 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0%7]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 17:00:49 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm,unmap: avoid flushing TLB in batch if PTE is
 inaccessible
Thread-Topic: [PATCH] mm,unmap: avoid flushing TLB in batch if PTE is
 inaccessible
Thread-Index: AQHZa4FwosvoCxZx+kWFav90J+Ui/a8k84GAgABgfg+AARGUgIAAhiWJgAD94QA=
Date:   Wed, 12 Apr 2023 17:00:49 +0000
Message-ID: <03BCE979-33B1-486F-A969-0475A35DEBB5@vmware.com>
References: <20230410075224.827740-1-ying.huang@intel.com>
 <402A3E9D-5136-4747-91FF-C3AA2D557784@vmware.com>
 <87zg7f19xu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <D432368D-7E3F-47C8-8BE3-A0D11BC6EA2D@vmware.com>
 <87sfd5zx5b.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sfd5zx5b.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|IA1PR05MB10080:EE_
x-ms-office365-filtering-correlation-id: 3f75f49c-fb45-4229-1e32-08db3b777782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qkhyr61ejIggDG9SRcnNshUx6CtHfa3Fp7yPO8PQ+zLnh15LKQyUO+G/NTYoOKo82DqnX5FYdiCGcWpHMSPUb6WYLbFGD0O8puEbU465chlP+MSe//P3VVK3UW6GX7QlQ+ch6St2z8lKFcBhemayvAM3PofvUyJm3MZUKA0md7raJeEBjc9WvY1T2o34IJ0sotwul2PWfeC+NgDNvvi1ow7GuKZwlDbBTOXNpHZV/tvmO0TjbwipZ0mcT5Lf7+qHELDm9LLdz9t/tkVziVo7pOQM1IvrsJEWTE0k+IFqTs7Ru+U4hoGsDrUDY2tsCMru8kRF7bnByspThSty6mVoCCfrLqAWZXP1ymTugqQGUrL/sRqyqXS6JgUdH859eykuvOtYV3/WxRjos9e/EwITApslqXORGJA7ICdhuxGS9bLVFQaEkXQphQFE99r5GQKssV2sfC23w+HlsHAwf+r7yj3zVtRRr1veBxaMH4twOimLHYP9Q8sPPFg8bcIblHEyTSqzZp3YgOYhXi6OA9XYoNFcMhd1vzZPOq02NCOyuZOA3hmIeddO33EYCGWkG+oXPVKKu3Ow6J4X26SUUYsGsSn/xm91c5B2EaR7kCl4J2kChrr78unSnAWtlV93gxCOXpX9hxtCiSFhdPlhVsOlwceab70bq0ZTzEww6OOywGQdyqT2rgGA7pxrYFYt6ia+K1KZG4dxHLJblrVc8Snnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(83380400001)(2616005)(76116006)(4326008)(71200400001)(26005)(54906003)(6486002)(478600001)(6512007)(6506007)(53546011)(186003)(38100700002)(2906002)(36756003)(33656002)(5660300002)(122000001)(316002)(66476007)(66446008)(6916009)(66556008)(41300700001)(66946007)(8936002)(86362001)(64756008)(38070700005)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXZ4UGFoYmRNcWdNckFldnFkVEg2VXRqZkU2ek82RUF3YmFhSkVqU3BSY3lW?=
 =?utf-8?B?RW5GSjJnMEIyWFdXNW1TQVpvUWxKVkJyQWRISHd3cHo3VXJjV09wa2NxR2Zn?=
 =?utf-8?B?TTFnek5ZWlk0OE1YOGR4cUhLYmE0TjdyVkFuWHZCM0ZDWTlycHVseDV0WFRE?=
 =?utf-8?B?YlNkOXJuc2czbFBPZ0J6dGEyamE1SDZKYzZiUXNWWk5NWVY4eUVJMWZLL2hV?=
 =?utf-8?B?WWdjQXV3UzRPMWJhVTk5dVVpY3RPTE8yaElqZy9kTjRkKzNUbEFLWUNjWGNZ?=
 =?utf-8?B?bDFSd3hpZmZPTGIrY2E4cHNXTDdsYzFRd2cxRmFBQ055elZaRHcrQllxYTRr?=
 =?utf-8?B?blAvNjZYTzc2ZEhuMEFVNVVwcDdtNUkrUkJiQkdXdHRXNTVGUGZYMHozKzlM?=
 =?utf-8?B?RjBGWERKZ0hCWTVHdW1lY3haZEZZczJ3aHhQNHhGcUxIdGlKdWlpNkY1ZkJD?=
 =?utf-8?B?YWZmQTZmTEwyY3FiRDRDWEozMFhSNXdScSszZnppTUJGclpNWnRWWGE0YVQ0?=
 =?utf-8?B?Qmg2WTVQY3hPdmtnTWZ6YjBxRmZzL1p4ejhPRjcrUURETzdoOUpHOVZWVWJE?=
 =?utf-8?B?K1R2R3JJS1c1YjdJWHFpYjFFUVlLWnV3eHN1dytKUDdNYUNzcnpwc1ZObkp0?=
 =?utf-8?B?dTIzeTY4dVBvOTBrL2pvdmdNOWthRnR0OERpaVQ1THpmbFJhQkZpa3MwYVMz?=
 =?utf-8?B?UC9FUjlLY2xDSVAzRlR1NjVjbXFhY1czSDJsdjMvWDZ6TGJLMDNIa2NRSVBk?=
 =?utf-8?B?cmdrQ1k2K0xqWkFBT0htalNNMzluajBpb2NVL0Y5MzNNMDB6Umc0aXdKQUNh?=
 =?utf-8?B?U1pObzNRREJuMnNRZmhYaG90OHk5M2NIU2VJMyttWlUrak91MlFjVEJkQzJM?=
 =?utf-8?B?UmNvUFBmMGsxOU9vNGNFMEdJWlUyM0R1dkYrU1VwNXdPNjV5RVU5a0NYakdE?=
 =?utf-8?B?bXdrdGJRVURFdzREUjlhK3dpOWR0UWd4SjZKOUhVbis5eWdwYVdwU0tnZHo0?=
 =?utf-8?B?aEV6Y1NpYkFkZHpGb0k4M25xbDdDckc5TTlsbVRFaExQQkZETkxzYklLeSts?=
 =?utf-8?B?UlJkTzBLK3lOM0p6ek1pczhDUW9JMEs4WUs1WDZCbWUzVmhUdTIxZ1RyN0tT?=
 =?utf-8?B?THlGOWNwMG1xeDdtRjlOVk5IcGd2dFpzSnF5UEZ2SWdyYWZ1S01qZjlLYVBk?=
 =?utf-8?B?aFRGSXJ5TGRkaFZpQ2E5bmp6TWFhcm8yOVdVa2hHMGwrSU50cy9xcFlPdytz?=
 =?utf-8?B?K09aUkZSOElka0ZKWGlkVUkwV3lkNDQrU0lVOVJ0eGZYbk9NZXdqa2dCZFhQ?=
 =?utf-8?B?QXJvTmN3K2pORXZWOVYwWng4T3AzY1k2OUY1SmViMnF6VWp5SDBHaXZ4dmJC?=
 =?utf-8?B?Y1VZSm42MUlvQkc5NE5PcjhrZmtQYXBOWUdxWXdiWGs2OFd3aHZtaGlsTUFC?=
 =?utf-8?B?S3RGSUtNRHNUTXlPTk1CNjBHclIwTkxpQ2J5b1F2M1R6b25NdkkvQWRURnhu?=
 =?utf-8?B?UFh6eE9USzQ4NkNJMDk3aVhZT21rdVhoT1E5RlN3RTlJZVZJa3FIU1BqNVo0?=
 =?utf-8?B?NVV5YmZXQTFXUnpWNWNwd3pYV0ptU2xpN0tYVFJ1NG1lMlNGVExkRG0zTzBF?=
 =?utf-8?B?V1kxNGRaRUE2U2R5NG5iWGtsUmI4dm1iM0RNaFp5RGFmdnBzQkNGV2ZiQWxw?=
 =?utf-8?B?SHBiOXJuWHg5Slk3RFFXditqclRwNmVnSUd5eWhLMFFjWTdRTjBPWEMvUm81?=
 =?utf-8?B?TzF2R1h6ejNtbXVaeTlwa1p2QWc2NEJBZThyTTBNbVpQTHZiOUJEWmQ2bG1V?=
 =?utf-8?B?UmJ2Qm5hQlhWNjViNW9MbWwzcWpqSDQ4YlJtOEM0YVU1VzErR2lHZVVmRW9j?=
 =?utf-8?B?NE4rUWh3SnRXbjhCWnBaZnNwcjFRK3FmTG5KUndWbGZzNytBVUhzbkxTYU1r?=
 =?utf-8?B?eE4vdFcwKzZtYkpwVlhyOWpqZ3dHakhDOHRJc1AxZzJOK3Rvd3c5K3AxeHdj?=
 =?utf-8?B?YjZRb0FDQ2h6Yy96NmI0dHNIdGlDRU9MQVM2TzdVUit0OXppdENJUEdoWVdT?=
 =?utf-8?B?bHhCMGtWZ1BJVlEvZklyV3RrUzh6bkNUdWdKMC9Udi9CRzVITzdkRTU1YzJW?=
 =?utf-8?Q?U56XJWXdNj/Y9/IdLdQdweAqp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5560C2C38C23E74EA05AA913EC4CABB1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f75f49c-fb45-4229-1e32-08db3b777782
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 17:00:49.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FccdlKsNnsF7wvlmHxAKWxQsfggusB9uf/bhZTpEfDLCPbB5LGxrlbzOsFf+cOy7I1SeC2XhHdAZ/UEhTEyzTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB10080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXByIDExLCAyMDIzLCBhdCA2OjUwIFBNLCBIdWFuZywgWWluZyA8eWluZy5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gISEgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE5hZGF2
IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyaXRlczoNCj4gDQo+Pj4gT24gQXByIDEwLCAyMDIz
LCBhdCA2OjMxIFBNLCBIdWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+IHdyb3RlOg0K
Pj4+IA0KPj4+ICEhIEV4dGVybmFsIEVtYWlsDQo+Pj4gDQo+Pj4gSGksIEFtaXQsDQo+Pj4gDQo+
Pj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgcmV2aWV3IQ0KPj4+IA0KPj4+IE5hZGF2IEFtaXQg
PG5hbWl0QHZtd2FyZS5jb20+IHdyaXRlczoNCj4+PiANCj4+Pj4+IE9uIEFwciAxMCwgMjAyMywg
YXQgMTI6NTIgQU0sIEh1YW5nIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4+
Pj4+IA0KPj4+Pj4gMERheS9MS1AgcmVwb3J0ZWQgYSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGZv
ciBjb21taXQNCj4+Pj4+IDdlMTJiZWI4Y2EyYSAoIm1pZ3JhdGVfcGFnZXM6IGJhdGNoIGZsdXNo
aW5nIFRMQiIpLiBJbiB0aGUgY29tbWl0LCB0aGUNCj4+Pj4+IFRMQiBmbHVzaGluZyBkdXJpbmcg
cGFnZSBtaWdyYXRpb24gaXMgYmF0Y2hlZC4gIFNvLCBpbg0KPj4+Pj4gdHJ5X3RvX21pZ3JhdGVf
b25lKCksIHB0ZXBfY2xlYXJfZmx1c2goKSBpcyByZXBsYWNlZCB3aXRoDQo+Pj4+PiBzZXRfdGxi
X3ViY19mbHVzaF9wZW5kaW5nKCkuICBJbiBmdXJ0aGVyIGludmVzdGlnYXRpb24sIGl0IGlzIGZv
dW5kDQo+Pj4+PiB0aGF0IHRoZSBUTEIgZmx1c2hpbmcgY2FuIGJlIGF2b2lkZWQgaW4gcHRlcF9j
bGVhcl9mbHVzaCgpIGlmIHRoZSBQVEUNCj4+Pj4+IGlzIGluYWNjZXNzaWJsZS4gIEluIGZhY3Qs
IHdlIGNhbiBvcHRpbWl6ZSBpbiBzaW1pbGFyIHdheSBmb3IgdGhlDQo+Pj4+PiBiYXRjaGVkIFRM
QiBmbHVzaGluZyB0b28gdG8gaW1wcm92ZSB0aGUgcGVyZm9ybWFuY2UuDQo+Pj4+PiANCj4+Pj4+
IFNvIGluIHRoaXMgcGF0Y2gsIHdlIGNoZWNrIHB0ZV9hY2Nlc3NpYmxlKCkgYmVmb3JlDQo+Pj4+
PiBzZXRfdGxiX3ViY19mbHVzaF9wZW5kaW5nKCkgaW4gdHJ5X3RvX3VubWFwL21pZ3JhdGVfb25l
KCkuICBUZXN0cyBzaG93DQo+Pj4+PiB0aGF0IHRoZSBiZW5jaG1hcmsgc2NvcmUgb2YgdGhlIGFu
b24tY293LXJhbmQtbXQgdGVzdCBjYXNlIG9mDQo+Pj4+PiB2bS1zY2FsYWJpbGl0eSB0ZXN0IHN1
aXRlIGNhbiBpbXByb3ZlIHVwIHRvIDIuMSUgd2l0aCB0aGUgcGF0Y2ggb24gYQ0KPj4+Pj4gSW50
ZWwgc2VydmVyIG1hY2hpbmUuICBUaGUgVExCIGZsdXNoaW5nIElQSSBjYW4gcmVkdWNlIHVwIHRv
IDQ0LjMlLg0KPj4+PiANCj4+Pj4gTEdUTS4NCj4+PiANCj4+PiBUaGFua3MhDQo+Pj4gDQo+Pj4+
IEkga25vdyBpdOKAmXMgbWVhbmluZ2xlc3MgZm9yIHg4NiAoYnV0IHBlcmhhcHMgQVJNIHdvdWxk
IHVzZSB0aGlzIGluZnJhDQo+Pj4+IHRvbyk6IGRvIHdlIG5lZWQgc21wX21iX19hZnRlcl9hdG9t
aWMoKSBhZnRlciBwdGVwX2dldF9hbmRfY2xlYXIoKSBhbmQNCj4+Pj4gYmVmb3JlIHB0ZV9hY2Nl
c3NpYmxlKCk/DQo+Pj4gDQo+Pj4gV2h5IGRvIHdlIG5lZWQgdGhlIG1lbW9yeSBiYXJyaWVyPyAg
SUlVQywgdGhlIFBUTCBpcyBsb2NrZWQsIHNvIFBURQ0KPj4+IHZhbHVlIHdpbGwgbm90IGJlIGNo
YW5nZWQgdW5kZXIgdXMuICBBbnl0aGluZyBlbHNlPw0KPj4gDQo+PiBJIHdhcyB0aGlua2luZyBh
Ym91dCB0aGUgb3JkZXJpbmcgd2l0aCByZXNwZWN0IHRvDQo+PiBhdG9taWNfcmVhZCgmbW0tPnRs
Yl9mbHVzaF9wZW5kaW5nKSwgd2hpY2ggaXMgbm90IHByb3RlY3RlZCBieSB0aGUgUFRMLg0KPj4g
SSBndWVzcyB5b3UgY2FuIGNvcnJlY3RseSBhcmd1ZSB0aGF0IGJlY2F1c2Ugb2Ygb3RoZXIgY29u
dHJvbC1mbG93DQo+PiBkZXBlbmRlbmNpZXMsIHRoZSBiYXJyaWVyIGlzIG5vdCBuZWNlc3Nhcnku
DQo+IA0KPiBGb3Igb3JkZXJpbmcgYmV0d2VlbiBwdGVwX2dldF9hbmRfY2xlYXIoKSBhbmQNCj4g
YXRvbWljX3JlYWQoJm1tLT50bGJfZmx1c2hfcGVuZGluZyksIEkgdGhpbmsgUFRMIGhhcyBwcm92
aWRlZCB0aGUNCj4gbmVjZXNzYXJ5IHByb3RlY3Rpb24gYWxyZWFkeS4gIFRoZSBjb2RlIHBhdGgg
dG8gd3JpdGUNCj4gbW0tPnRsYl9mbHVzaF9wZW5kaW5nIGlzLA0KPiANCj4gIHRsYl9nYXRoZXJf
bW11DQo+ICAgIGluY190bGJfZmx1c2hfcGVuZGluZyAgICAgICBhKQ0KPiAgbG9jayBQVEwNCj4g
IGNoYW5nZSBQVEUgICAgICAgICAgICAgICAgICAgIGIpDQo+ICB1bmxvY2sgUFRMDQo+ICB0bGJf
ZmluaXNoX21tdQ0KPiAgICBkZWNfdGxiX2ZsdXNoX3BlbmRpbmcgICAgICAgYykNCj4gDQo+IFdo
aWxlIGNvZGUgcGF0aCBvZiB0cnlfdG9fdW5tYXAvbWlncmF0ZV9vbmUgaXMsDQo+IA0KPiAgbG9j
ayBQVEwNCj4gIHJlYWQgYW5kIGNoYW5nZSBQVEUgICAgICAgICAgIGQpDQo+ICByZWFkIG1tLT50
bGJfZmx1c2hfcGVuZGluZyAgICBlKQ0KPiAgdW5sb2NrIFBUTA0KPiANCj4gRXZlbiBpZiBlKSBv
Y2N1cnMgYmVmb3JlIGQpLCB0aGV5IGNhbm5vdCBvY2N1ciBhdCB0aGUgc2FtZSB0aW1lIG9mIGIp
Lg0KPiBEbyBJIG1pc3MgYW55dGhpbmc/DQoNCllvdSBkaWRu4oCZdCBtaXNzIGFueXRoaW5nLiBJ
IHdlbnQgb3ZlciB0aGUgY29tbWVudCBvbg0KaW5jX3RsYl9mbHVzaF9wZW5kaW5nKCkgYW5kIHlv
dSBmb2xsb3cgdGhlIHNjaGVtZS4NCg0KDQoNCg==
