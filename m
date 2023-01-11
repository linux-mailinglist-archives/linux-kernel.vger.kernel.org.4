Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C276658E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbjAKKWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbjAKKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:22:27 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D0FE6C;
        Wed, 11 Jan 2023 02:22:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVNYBp3rQBE3VIWvdxkzU8dPNp8tLs4ytQ6+ulsobkwXHWAyAsFNKJm2GpHUTPVRjSAccV/H7M8edh+ZrNVdcRoBzs8ovjpU4H1MKCRS7p5TLDYMXNj4VgP+CLQFRlZPH77BIeoaGnHWvq2130DcFSgdXuiGVw0MVqk//yM3di3VnIeegPHIRJ9q3NTK46lb7M4aeeo7IQ0EOZYb0jxaiPn1fzPCsZChdRsOrDWfd1dwixSo7hIoQtoEwClMMysMKXMv3cwqIMPwqtOKs66pJ7VHzz/dDJHaVJtGg7SpyjsTPJEl2wXOc2fA/KPgLqMddGulSnSx3YMCxv4qVJ3rHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4CXW0i+3GKc7/WxN5LBcZx5F2ym/EG1r3WsYregp8E=;
 b=A0MzrbTT3eF4WYN41BIEXEmhTGLZZdofgKZcWJwGfIvYCJXD42JhNTi4GqSV5kyuXLpQu7O4D/a0KJGyRGhZARv/tz9WDNU4ENC7VJXiJsX3xj1maLNNqsOKSKZqOGHkjqXnn04K62UKfSERTi6jXCjZCwVddrdhgtnT2yzzixq9fIOGydvgBwgoPJfff5toUmWv7bS6d92qj+oRVZljAEe0NXrAe6YGThIBiXxxCCAnHDRImuky9VmD4gYmsEgmET1+5ZY8qLSegaZDTAEME2ihoe8HoEGWGj1I52J5BCokCZelrCPErYkJIqfZ4/nTwBToMpYgRSMB566KJ0KzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4CXW0i+3GKc7/WxN5LBcZx5F2ym/EG1r3WsYregp8E=;
 b=tJtZN0XI+791Tk60V6zLlRQr6iHQhBzzFTauvfOS4rP1OuZR9h8piBkuFHWy+NVbTMmpJye856pPheloTyvjHmkUEmZM8PYSKs/zOe+Oj4NlP1u/qgjXHc7LqXKvYg1xm4G6MwFdn/n4x7DVNHvouiiPbS6x5jqnXymkOUGsuciBnEfpRcHefppzuu5P/LeaNYyg+cf1hHYKO/EBaW03sytaXCtJJxQHJq3n2KTldQBwuW21OesM6mjwaawLCT6CvuSVl9yldnR2JZsY2dhT4I4C00QnLSUEyTMuPQsASOtWjV0CQX4TRJXu/6Ch2WxCwSRF/swjt3Mm8w8v1UgdzA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 10:22:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 10:22:24 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH V1] lib/scatterlist: Fix to calculate the last_pg properly
Thread-Topic: [PATCH V1] lib/scatterlist: Fix to calculate the last_pg
 properly
Thread-Index: AQHZJaUYv92UPzC17Uq9B/zeeHwc1K6ZAeWA
Date:   Wed, 11 Jan 2023 10:22:24 +0000
Message-ID: <0e0c8aaf-9ec6-d3e0-b530-1a4ec405d0f2@nvidia.com>
References: <20230111101054.188136-1-yishaih@nvidia.com>
In-Reply-To: <20230111101054.188136-1-yishaih@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA0PR12MB4445:EE_
x-ms-office365-filtering-correlation-id: 948012de-27db-4a4e-7e2c-08daf3bdbb41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJV06jDLXvE9hSo7pQDyOWUd8VFmOj99FOpmeGnbMg215u1liP+pwi/rDoMGrZoLVwr52An65PN7qjLSrbcptrFH5HhgCuK52V4Sve2a48SXwdCM3fRyTkQJTqiZ46O4l/sdjpm6Zvyajh1g2o/nTYG/Caz3hNq3gnXzwGjGdx58R5IxvzxXFyOY9IEy4EfCSq1mQOUhr0aicPXobKC5D98lsbNRbhjlIe4CxUNYkw37yZbwNG87zWp5xSjuauPsXWFyyJkb0BjoAaXM/4p2rI7FWQEtSOTKirq2snxfbatnv5HtC1PZMepTBj0xuBCk7hBBk+XUH8QAyJZTgTGTA0TjkamJlNBr1YNgEeQX9sLlC68ctUXuxeRxFyHJO6m3XdvLoLtm91I/Y58ds0LzsR9UzWNqrMqEMEFC58JMkqNUq9eWRgDzwX6MSd9z+Qi+tumu3sapfHmUdN6If+2MhyxW7m8Vw5QYq8A11N71XgDIUYzUMW+4Ue6qg1c2DIunNmdyX8Ii4yZsiBL08SGYU/ju0H509/vcsTm37nz/qXliezGvB2xOhK/ociX4NRzA4rmwpdwoFKK7DCHpUe6U0cK96SB8rWzG3w+WHfrNzHR44B89twGGbnmy5LN8YSgAfyCqZe/p1BUzEvc/p0MWfHmSf4krmon5IEPB2pAx8Iqnal/XNMCpdkoWoZDg6ZmKNVNZaIXe5F9ok8M76ycLamau2U3fTnfxfHtLu1VWQL7FOTi7jZfWQI8OJw4iejYna+nkbuZmX+S1yyDeUYvnKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(478600001)(38070700005)(6486002)(41300700001)(38100700002)(6512007)(71200400001)(86362001)(54906003)(6636002)(316002)(37006003)(31696002)(2616005)(186003)(66556008)(66476007)(66946007)(76116006)(8676002)(4326008)(91956017)(64756008)(66446008)(36756003)(5660300002)(53546011)(107886003)(6506007)(2906002)(31686004)(4744005)(8936002)(6862004)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWxwTUcwZHh2dExvQW5oM0xQSS84Yi9Bd2t6RUtIUlprc3Q3WkxmeGF2Mnd2?=
 =?utf-8?B?L0ZpZWdMaWxBaDR4eXhLZ2VUeDhoK29MbWlBclNzVnZVeXNwMmRNR05UQ0Va?=
 =?utf-8?B?NXNzemwyUFJnRVdPRG95ZFA5RmVDemNVaktZaVRmcnlnL1U1ZTUxaFZBSSsr?=
 =?utf-8?B?N1pZR2FKbkRoNlJKNmU1Vjc4TDNuVkJzUUR1ay9rVDZXeWJ0OEo1cFcwK3Rk?=
 =?utf-8?B?VFA4bzcrTnVySlkwVVBhWVBzaFFVTEtXL0xqakhoMGF4WVExV3N2V3ZoczVJ?=
 =?utf-8?B?VGNEZTV2SjZvL0FzL0JZZ01HVEhRS2RZaStSWHUzQkM0WXFsSGd0NUlZSnBr?=
 =?utf-8?B?WmNBZ3ZtSDBjanl4MmxBdTNtMGJ6RDJpUzVJYTgzSExLUU1KWHlPOTlwZkIy?=
 =?utf-8?B?c2JvUzR1OXEya3hmcVNwc2M2dG5GZElobVQ1V3VhNmNlMENZWXZBREZYZHBE?=
 =?utf-8?B?aXd5MTkvQ1lQYmlFM1lNNVlxdk5NRjZEWW9rL0pKc2FzdkxvRUkvMitwcU94?=
 =?utf-8?B?K2lod3AzeWFQcmFuNFRJeUxYV1lZUmo3MnVIeG5uTWIvSWxEY3lZN0FPSm9G?=
 =?utf-8?B?dXkwY3g2b0o2UWN2Qk5HeWRva3paWnJvcXo4M1k2WURTenF5UjNEblVqUzJY?=
 =?utf-8?B?R2g4dCtRUm9mKzEvaStMUm1NNTZQRDIrR2VmdnFCYjJoaU94VTZyZHJ2VnpU?=
 =?utf-8?B?bVcyUFpVMEIvZ2VoQUNnaFFiaTdxcHB6U0xyWEliMyt6ZXpSR0psd2pDRU5D?=
 =?utf-8?B?NVdHTWtoelFuV21Wa0ZjbVd5dWYwQ24zSUxnVCtKaTNYVGg1bWt0ekxwREVV?=
 =?utf-8?B?TnhKVnZxM0JIRmIrRXY1UCtGMmgvNStCNWF1WWk3ejN5K3cxNU0xcnlpL3FN?=
 =?utf-8?B?QUhpcU1vYnlkSmhMMXhxVEV0R0JoQy9JWjZLTGx6STFXbWdaYVE3NDVrdUt4?=
 =?utf-8?B?bkdxSUR3b3o0eGEvbGtaRkszVndrVU1WcThXL3JhcFhaRktvNTg2dU5sWjlV?=
 =?utf-8?B?elUwUGlKZGM4RzRHb2RrT2FSWVU2Q3ZRY1UxaUwvNHFlVlJJOW1PREV3Z1VV?=
 =?utf-8?B?R01jRTdwUGhDd1dQTFVlT1RSTklZVG5VV1h1TTNwMlhNelIzZDFRanpyNWN3?=
 =?utf-8?B?dU9hVFpNZ3paM0c0aGE4TUhrbTkwVEd5eWh5eVhoUmRubzdmNE1DMnNIQ1Ns?=
 =?utf-8?B?R29Vem9HVmt5Sk9RNUlLYklwQjJjUEgzR2RJNU5qdWhIUTkvMW5WMjBzaVE3?=
 =?utf-8?B?UnRvUnZjSkRrMm9ZQ2piNDk0SUdGQ3FTVVZSVFBMcFVGeS82cjhOeFUzancx?=
 =?utf-8?B?NFp4OThXS0JpMk0zRXl1WWRSYzRVamc2TlRSbVVBUDhLWFlINzBGeWZSaUJH?=
 =?utf-8?B?WjV5ckdKK09HR1pSOWZyMTFYcWxGbUZxU21jS1lQQlg1YmR1SkU2LzZXSEZ1?=
 =?utf-8?B?cTlIdUIvK0g3TGNSaHhxUXpDcTNrdEVhMmM1QlM3Ly8zbVl4bGJ1SE8weFdr?=
 =?utf-8?B?aUdITExzYytaSm0xR3pka1BRY1BuSVJoRW5rMUNzNDVnNnE3Q1h3eWtWRERy?=
 =?utf-8?B?Z09mdlVKaTFkcTVMTzlWUWtrRk9tMzZiVWNTbUM3YmJlMitrQWVWY3JyR2FB?=
 =?utf-8?B?VnRHZUNnMTlzbnlBdTU5Vm9uTDhDS2pMZFVrWFFNTUFWb2xsS2VCME1VMkN1?=
 =?utf-8?B?K0t2cHZzNVBaTlZxSlRtYTdxSjJzaHFLTFVJTmhxZXhybW1WR3Z2bWdGTzR2?=
 =?utf-8?B?V3g4WGdRWVkwQ01sUjgvZ0hTUDZzdkFYR1ltYzBLcDhjSFVtNVJNQkp5aisx?=
 =?utf-8?B?RWx2NnhNVjM1M3pKd0JySlBaSEtJMVpVamJrL2hZZDUxdXJrOEZ3Z201MTFB?=
 =?utf-8?B?QytzZjhiem8xaXUzRFR6c3d0b0ZjdDRQdlphTnFHbGtvTFF5R0RxODVtb2ZT?=
 =?utf-8?B?L3pQY0xwZjQ3THdUY3ByRmtQQWdtUXd4WlFHam43SENxVGt4Um54VjNCWmJz?=
 =?utf-8?B?c2NkazhBNFhidTQrcXB1aGRvMlhJQmVhMTBIY2VIY3pxdjlsUVUyQ09xbjRW?=
 =?utf-8?B?YjRoREk1QlZxUFNGVElnNHN4d2FwaVhtWUMyT0F4bjJSdW5GVmE4dUQyaWRW?=
 =?utf-8?B?SWtycWJPeUdvOHNwaXhFSE9ZdEFEMkNJZVBaN01uUWVhY2Jpbm9jK1NsY0JZ?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE1C2BE0B1EEDF4C8B933ECB627C4DA6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948012de-27db-4a4e-7e2c-08daf3bdbb41
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 10:22:24.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huAEk3VlSRQ7LrggrWZewDnq224sHX6vbzG7ti7ZcPV7UeTBmBMTj4572xis6bjiaoyBSxv34gRIERUdygEqAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xMS8yMyAwMjoxMCwgWWlzaGFpIEhhZGFzIHdyb3RlOg0KPiBUaGUgbGFzdF9wZyBpcyB3
cm9uZywgaXQgaXMgYWN0dWFsbHkgdGhlIGZpcnN0IHBhZ2Ugb2YgdGhlIGxhc3QNCj4gc2NhdHRl
cmxpc3QgZWxlbWVudC4gVG8gZ2V0IHRoZSBsYXN0IHBhZ2Ugb2YgdGhlIGxhc3Qgc2NhdHRlcmxp
c3QNCj4gZWxlbWVudCB3ZSBoYXZlIHRvIGFkZCBwcnYtPmxlbmd0aC4gU28gaXQgaXMgY2hlY2tp
bmcgbWVyZ2FiaWxpdHkNCj4gYWdhaW5zdCB0aGUgd3JvbmcgcGFnZSwgRnVydGhlciwgYSBTRyBl
bGVtZW50IGlzIG5vdCBndWFyYW50ZWVkIHRvIGVuZA0KPiBvbiBhIHBhZ2UgYm91bmRhcnksIHNv
IHdlIGhhdmUgdG8gY2hlY2sgdGhlIHN1YiBwYWdlIGxvY2F0aW9uIGFsc28gZm9yDQo+IG1lcmdl
IGVsaWdpYmlsaXR5Lg0KPiANCj4gRml4IHRoZSBhYm92ZSBieSBjaGVja2luZyBwaHlzaWNhbCBj
b250aWd1aXR5IGJhc2VkIG9uIFBGTnMsIGNvbXB1dGUgdGhlDQo+IGFjdHVhbCBsYXN0IHBhZ2Ug
YW5kIHRoZW4gY2FsbCBwYWdlc19hcmVfbWVyZ2FibGUoKS4NCj4gDQo+IEZpeGVzOiAxNTY3YjQ5
ZDFhNDAgKCJsaWIvc2NhdHRlcmxpc3Q6IGFkZCBjaGVjayB3aGVuIG1lcmdpbmcgem9uZSBkZXZp
Y2UgcGFnZXMiKQ0KPiBSZXBvcnRlZC1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogWWlzaGFpIEhhZGFzIDx5aXNoYWloQG52aWRpYS5jb20+DQo+
IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0KDQo=
