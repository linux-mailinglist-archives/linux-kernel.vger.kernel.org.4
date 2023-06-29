Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E361C741D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjF2BEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:04:23 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:31454
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231356AbjF2BEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:04:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rzb/7mDH6f5R7cKfjn8FQU80trke+eSEzNTbjXHZuJPHninz6325v2S8nB+hQH8sm6WohbG33xjywdMaNuVnPxyawYBqAagI4D1vgloKNYAl4cBne9FmydBq4gdm3CinRtpMZejKJxPPQkpWqGNwdPeqvYclNlS68bzh+6kmTZANmMA58ZHFckjK9IzeEhzH55bz1Wa57YhN2WgS2kad61/orQVAYYMK1NmNo8MiCGZ1PQNSJn3nkTy/K2BZiohtmH19kJv33EAjxpNEpKUr6DSWuZXxPivTRCn6nONc39zEPALog2bYsDdFhyvCccaPlnMPi/Oz5mMokCgGAxTzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EV9P6xHIzzjvtXuO7Bcw6lLRMVqbw1OpwcQNFYoPlsk=;
 b=khH9DmbZSowwIXaW3lH3g0cwbfJkNdTAt3fqGSa8F7uFs9A/0cWYclJbZbcsttlh4oY+FBP+zQ1zYe8UwXpsiMmCIqkciCHbSg5j0DWmKLM49IxkYMsnUMGSTx0GPf3gFp6F5KcCeJZ/HmgcWhh6pfLC/XKP04krRqZ5dB+IHxzPPQtlFO7JJvldRHv6dcfEQ/BPRkvJAhu37feb+LCSpysqdh1/QnlTCnX6oFiky9Mh/6I12haMmmdiDOUKSBv8b+8c3xTq8bteec1lpH7JQnxpMpJA7iEN4qyiXlz5vbkZf5Ubn7mySx3p5i++pDPtysmrWr6b6s2tbk+s3BkiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EV9P6xHIzzjvtXuO7Bcw6lLRMVqbw1OpwcQNFYoPlsk=;
 b=oU4g9D3GlJYotRzw2xvXfcr/2e3v9Z9tHpeMWL7dKM66RFQyExtxnSacAdNflZG8gUhRKc9ikCn9Q0Ns8P4nQzp1MTElVXg6rO+KIaBFsYPASpuPhk0CF1L4EN755gcQN4f9Txasvy0GjnO3wIEIhUGui35xXKOv6HkqpqFCV2kmoaZ4/5wPsgQqrJk81mYVVIRh84SFKY6rlEyoAlRIPISBvCC4sK0pDEH2PEk78n5hoVdpBDTXzs+ENQ/BFpl1RPxKk6E52foLHXFIqZIv/zZ6Ck95uEWCpHvgLatgRgWBlzItbW86mNUC/hTwTDgKSc0SrfxEyvJh5dPUFqkQAg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 01:04:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 01:04:18 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Min Li <min15.li@samsung.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v3] block: add check that partition length needs to be
 aligned with block size
Thread-Topic: [PATCH v3] block: add check that partition length needs to be
 aligned with block size
Thread-Index: AQHZqZgYX6xUhmDwQk2oD/otineHmq+f5hxMgACMwwCAAIUygA==
Date:   Thu, 29 Jun 2023 01:04:18 +0000
Message-ID: <93db2fcb-7afa-776e-01a1-de928b93e799@nvidia.com>
References: <20230628083839.GA26606@lst.de>
 <CGME20230628090918epcas5p3a5463f0fc421e435a363192e40d3f649@epcas5p3.samsung.com>
 <20230628170734.2960-1-min15.li@samsung.com>
In-Reply-To: <20230628170734.2960-1-min15.li@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4302:EE_
x-ms-office365-filtering-correlation-id: ef817789-0783-40c8-0b99-08db783cc3df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5DEbvMYRSLKb9A7sCkJjgTOx5uCPQjBSXervvWklAP3NuvNgcMMVKYwPCHlbqE29yeZDx/Q6GMY6mTqbPDpuS+t5OgbRrD6w3Ru+2G8PbXT1l/HK22HvU+R8cKZ26PabdFN3T0kO+E5xJZHgCS6pss3F73AqmzGNsJcq6ugSPdB+65+hs0rUcjBo1k0ikF3zYU8H59LSYA5pxd1DegeR26q/rbqfwBCqnShDPenu9Lu8R78y2GbSi1QBMe0IVU7Ua285sHjvWCFZ5hH4ln3UBkrS7r2ffNPaYxmktYedYpnZmH3S2ZPJ6QlFs7OXCk+HKx9/ZxaoJpVnpUu5u2JhGm2sfeLfsNNg23Oz76UMxY/4McZGqr6P2HHK0sJRVY+c3CXghz+/5QpVjp9kebkj1e+cx7KfNkcyvZJJhBmYqIno3GHAKOkBw29fha7YSBz6ASy3wIeEWDFk0HBSAIvHxRTrJ8AsoSYBswFBEJOvxAhLvukLbDlg+RYjKBn7JJBX8Hasjn6vFSag08gNUw4H/XTVEwuf5nVsHjC17+yJTJFfkDtVEetxPKAk+isG7T6KuhTE11bVwTQf7KdVJFfYy/wp31CziR26F1wA+wfSgUdsK/1I5YdIVF2DaeQClJ6eDFa0pWHrLISi2FJRCYPxCjPdeOoyJf9Bl5qnI/Iz0KWWET78AEWG8UT5jFVG6274
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(54906003)(4744005)(2906002)(6486002)(186003)(2616005)(38100700002)(53546011)(6506007)(122000001)(71200400001)(86362001)(41300700001)(31696002)(64756008)(38070700005)(478600001)(66556008)(66446008)(91956017)(66476007)(316002)(76116006)(6916009)(4326008)(36756003)(8936002)(66946007)(6512007)(31686004)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm5rNC9XMVBhUTJ2RU41NTVVM2lwaUtiQWlpUEowUWk5TFl6VVNjWnlKdUFa?=
 =?utf-8?B?eGxNWGtFdVlEdnBEWklxN0hXd1U3RzQyb2I1aHFsUDJqSFpKS3RqbGFjV2tq?=
 =?utf-8?B?cndTTFB2UjdyV3FCOXBBRkg0ZkhVbWRVUzh0aGdGSGNTK2wyWkgyK2svUzFu?=
 =?utf-8?B?Z1FxRFRhRGZpQmNsOThmdzFKelg3ZWFHUzNtK2Z6eDkyUUZCRTNleU0zL1BT?=
 =?utf-8?B?MWQwbXNwZnQyWlJFNGtBYVIzSERlVHV3alA0bDNtTGxyOXVoV1h3cS9BWWJj?=
 =?utf-8?B?L25JKytOYkVBNVc0ODI5ai9rNGI5QUE5ZkFTd2FkNndDWkxjd0NobFhua3d0?=
 =?utf-8?B?UFRqb1BEMURON3VxeUE3MS9wZStlMkJLWTl4azhNbmZiSDRpdEtlbnJwb3hx?=
 =?utf-8?B?VmIxeUh2WmdtYkdWRlVldW5WdlFTczlickZ6QWdxNlA2S1lQQzZQcERTWmZV?=
 =?utf-8?B?VEk3dmUydzNKSGVLYkhZeGNybG1hcTFYb05ZTXhRNHA5NkgvZE5FMjYvQmps?=
 =?utf-8?B?ckxpS25zM1FQNS9EVWhXVTh3Sy9LZ0pERERSNy85U25Id0NkaEEzNStsVXNQ?=
 =?utf-8?B?V0l5ZythY0xJQUd3ei9QbmR4TTR3bUZGZS9PbC9GS3h2dlZONTNhRHo0ZzZi?=
 =?utf-8?B?UkZDaWYrM09UUDVvL3BDcnkxaS9sQmxvK0VOTiszblJUdkgyTUxpdW16YmRz?=
 =?utf-8?B?Vk9jMjZDS0VyRnM5WXVaQjdXNkVBNWthQmlXSGZ0MmtVM3VUWFk5UEZTSnJT?=
 =?utf-8?B?VXc3WFZkbGFvMnVISXh4WFdJdmh2M2VQV1hEYTZuMHNRR0F4LzNIMCs4NmNj?=
 =?utf-8?B?aDNvdkZmdFo3VUpMeDJvYldlb1NhZzg0Y0dndDVkZDh0eDlIRkZpckE4bUQz?=
 =?utf-8?B?TjJheGUyMEdKdGVqM3U4SHFadlRPVU4wQkw0VGRQMFZKUVFYRnRCYVNaZG9r?=
 =?utf-8?B?bWdvNm5RdTh0aU5YalYyUzRsSUlRRmVqSDFEV1hEQktFKzl4eGtPQzZkQ2xt?=
 =?utf-8?B?NEhMRTRvdXhyVmJkRTh2MlFQZXVSbjNDeXpNK0dsbk4xZDE0L3FTU2dYMmx5?=
 =?utf-8?B?RDN1NEtFRU1pR3FleTdjc0xtT3UrQTFnV2Jwc25UVjZ3emNwOW8xb2lrQmhI?=
 =?utf-8?B?OVhyNm1XRU40eWgzQjFoTE9vYi9EUGtnQ2FqbHR0Ti9NcFJ1SDZqL0VGaVA4?=
 =?utf-8?B?VTUzdFdPZkp6Q1BYZDh6b0E2UldoS1Z1c3B1a3BzVTlXMFl3OUxvMnlxRXdv?=
 =?utf-8?B?U29rait1Mlo0L0dCOXZoNXlmZzlYbmhRSEd4RFpqRWVCcGttSGxmTE12aVFH?=
 =?utf-8?B?a1lJbE90VUM0ZUttQllTZGhTODVaMzZvNExsMXpUQVFxVmNhWlllUkIrNTZz?=
 =?utf-8?B?QlE1cHU5dHBtbURoQUNmeUZrNTlBeHp4bmx0ZDA4dFFPcmp6YmJjemVRemxl?=
 =?utf-8?B?azBERHR2Mzh6b2Vzd212UkZnenNmTEM5ZTMyYi9UWnVDZ2N2WWNxRFRRRTdC?=
 =?utf-8?B?WkNtKzZRbGRRWTBaanRYRkVGVncxblkreklleXE2VnptdkIvWlRUMVMyVkV2?=
 =?utf-8?B?K1FuTUpFUG40aHp0ZG5SOGE3OTZWY3EyeUpBbTlaOEFYc0o5QTJDTkx3ZStL?=
 =?utf-8?B?QUtMK1R3VUIyYUt3aVBoSU9uRjM2ZDZTdE5ReTJ3SlNKc2ZXeTBNWTUxcm1K?=
 =?utf-8?B?cEJObmhzN1BHeitydlpVR0E3UUo2ZkhJYUgybnBUMXF4OUJQZFBweVYrZENJ?=
 =?utf-8?B?OFRaWU9DS0g5eUNqcTF5Q1o4ZHVTNG9Eb3gwUGViVDc4a2dSbC9kUjlPRTNu?=
 =?utf-8?B?dWxNc3dDa2d5VmdWdlZrTDRsZVR0ZnpYc1A3bUpBckVRTy9IMXlHWitnUDFa?=
 =?utf-8?B?SkVXVktjUHJvVit5R1BFWFZXRWVoU0ZyMjlLaExWZjM4NTY1ajRwU3pUNmdp?=
 =?utf-8?B?bFkrWFJXbnRrbmEwckUwRTRrV2dlQlRFTzhsbkN2NFg4UU5ZTzUwL2RFRlEv?=
 =?utf-8?B?dm5aTkRGTCtFZmZWNlY2RlpkUGRIYjZuQzhUZSs3SVhBYzlUQjc5Ym1UbXE4?=
 =?utf-8?B?ZW9qTU5UUjdMVTBGSSsyTE40bzY0MFRXYldCVDlMam0xUVV2aXVPTU9FRGYv?=
 =?utf-8?B?L2JmY2hCaUlWdW9MQ3ZpMWYrQmdjMjhvK0xEbUtXb0ZHWGRHeFFLc0hRQVgy?=
 =?utf-8?Q?FfECTN3UtB8MiZ1rdPocWjw42AsywSXOjh4Lc4sZ6swH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35CA35290ED67949AD93A5D000A26995@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef817789-0783-40c8-0b99-08db783cc3df
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 01:04:18.2131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faJAXjru+20Cf0eiPZ7ltqf6UWkws1o0ZmCAKIPcxiV4qZeOfjymLM/ZP1o09dsSGwnfHvS9fJu3kQSYNj3HQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yOC8yMyAxMDowNywgTWluIExpIHdyb3RlOg0KPiBPbiBNb24sIEp1biAyOCwgMjAyMyBh
dCAwNDo0ODozNlBNICswMDAwLCBDaHJpc3RvcGggSGVsbHdpZyAgd3JvdGU6DQo+PiBUaGV5IGFy
ZSBsb25nIGxvbmcgaW4gdGhlIFVBUEksIHdoaWNoIGlzIHdlaXJkIGJ1dCBoYXMgYmVlbiB0aGF0
IHdheQ0KPj4gZm9yIGEgbG9uZyB0aW1lLiAgU28gSSB0aGluayB3ZSBuZWVkIGNoZWNrcyBmb3Ig
bmVnYXRpdmUgdmFsdWVzDQo+PiBiZWZvcmUgdGhleSBhcmUgc2hpZnRlZCBhbmQgY29udmVydGVk
IHRvIGEgc2VjdG9yX3QuDQo+IERvIHlvdSBtZWFuIHRoYXQgd2UgbmVlZCB0byBjaGVjayBpZiBw
LnN0YXJ0IGFuZCBwLmxlbmd0aCBhcmUgbmVnYXRpdmU/DQo+DQo+IFRoYW5rcyBmb3IgeW91ciBy
ZXBseQ0KPg0KPiBNaW4gbGkNCg0KSSB0aGluayBzbywgZnJvbSBpbmNsdWRlL3VhcGkvbGludXgv
YmxrcGcuaDotDQoNCi8qIFRoZSBkYXRhIHN0cnVjdHVyZSBmb3IgQUREX1BBUlRJVElPTiBhbmQg
REVMX1BBUlRJVElPTiAqLw0Kc3RydWN0IGJsa3BnX3BhcnRpdGlvbiB7DQogwqDCoMKgwqDCoMKg
wqAgbG9uZyBsb25nIHN0YXJ0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBzdGFy
dGluZyBvZmZzZXQgaW4gYnl0ZXMgKi8NCiDCoMKgwqDCoMKgwqDCoCBsb25nIGxvbmcgbGVuZ3Ro
O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogbGVuZ3RoIGluIGJ5dGVzICovDQogwqDC
oMKgwqDCoMKgwqAgaW50IHBubzvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC8qIHBhcnRpdGlvbiBudW1iZXIgKi8NCiDCoMKgwqDCoMKgwqDCoCBjaGFyIGRl
dm5hbWVbQkxLUEdfREVWTkFNRUxUSF07IC8qIHVudXNlZCAvIGlnbm9yZWQgKi8NCiDCoMKgwqDC
oMKgwqDCoCBjaGFyIHZvbG5hbWVbQkxLUEdfVk9MTkFNRUxUSF07IC8qIHVudXNlZCAvIGlnbm9y
ZSAqLw0KfTsNCg0Kc28gc3RhcnQgYW5kIGxlbmd0aCBjYW4gdGFrZSAtdmUsIGhlbmNlIGluIHlv
dXIgcGF0Y2ggd2UgbmVlZCB0byBlcnJvcg0Kb3V0IGluc3RlYWQgaW52aXRpbmcgb3ZlcmZsb3cg
YnVncyByaWdodCBhZnRlciBvciBiZWZvcmUgSVNfQUxJR05FRA0KY2hlY2suDQoNCi1jaw0KDQoN
Cg==
