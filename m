Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F716E8329
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDSVLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjDSVLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:11:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5D559E8;
        Wed, 19 Apr 2023 14:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGcThMrxEUG3F7WrswPOQPTVwWDbSb3j/xdOrEvj6wgvK1JwHI0Aw+kak8sBWXdX5lLTiYlJL7dTg7mBh58U4G3GaWNdXTMosVUZJYKT3OHlOhqd2MLK/Uuo0v/IqSz43yW1maOexhlpr8h8A4bHJgqiW3fOJ8TMgdxDDwfJcGRPOqj1CfdbMr/ushK9+LMIt56HyLfW0GZhDDYf767Cn7gF5q4cGz+wKmcBJ+6xqmIvNu+dHBg2SdUvUAsQYR5mEr/0rqMkgeTsSs7c5Jhnuc3eUna19Hj1staXR/V4jc0tURP5EOdH94Dp4ckBd7sB3FZCFNWTdgO2xLlinaY8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laJYkpKKElnvGGl1eicuuGXghHs46Jim2WHYDhjgeBw=;
 b=ACuXi5rTEpiSCblp7KMmOEtMbJK/Cwkr9Ar9zmA2zw3cusYye4xi6da47ZBYh61mMHfjcbyojRPYL9MoFX11IvBYPJrHG9FQm+xD+YeiG8Z+9KO850Sfy8aJa0kcNOf42qt5bQB1joLQvZwAR7JFNDrCNYI99FCSG6G6YqSRKIDN+mtSzmopJK3YixQ2twT8UM5bfTmOLGwiuzrU/3qa+xHZvDuZHz6a0rY2EWKQpdXg2c61Xw8J8KhRtBMmMm5fyQleEuVdHOkouzd4Mc7wl2exWfM8dhiuhF8M9SJfjLhqoomicGCm4J6cHEMUEd//bwJytm/bfA3e+AkfL61OWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laJYkpKKElnvGGl1eicuuGXghHs46Jim2WHYDhjgeBw=;
 b=JoV9nJRgb17PNvhkSoaLNGPhsmXEt8l6XCvZmotXFpnivC9yE1MjdWwid8qb/oMdoMaMi7+nqC9D8bbDC4IptfOXzcMZzVv7/m3bJpZltaWv+rdywKpTmTMvJaxDkWMKOZOabs72gr0Q3suLkSkjafLyRSwkt7ky6ulPVCjFzuor9JG8CuPIb6FuBWS+H5zNAgfDQZ8JZrFT7KIvnPK3XsOul/XzZLTWr54TWTNxZxE12EZDWG1MGmD242fJULFDJpzyfOaTcQry5o9Br/782KbHVUxKMNTzJ7ZltkUNj5VkvZ2dSUOE/8tyohIZ8X9hE8o1OB6q8reuNvUitiLKpg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 21:11:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%5]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 21:11:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Thread-Topic: [RFC v1 0/1] nvme testsuite runtime optimization
Thread-Index: AQHZcpzgQRAsytyJiEWmAIUqEW+1V68yXyyAgAAEQwCAAL5fAA==
Date:   Wed, 19 Apr 2023 21:11:33 +0000
Message-ID: <27235520-2e63-2891-fd0a-ff758f18032e@nvidia.com>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
 <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
In-Reply-To: <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB7685:EE_
x-ms-office365-filtering-correlation-id: 09f29a1b-b3ab-4c90-9d8c-08db411aa72c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2t0ECtOOtXNIwLRRmXjxYZGnFmykrIu5r0uGhuLnUVjKBujqakfM5HER84Z6aofSO6lFCWr5SKi8J85PMstZMEZ/U3D//u28qpiqCGzcfOBOMKrVywq9UyEhEPVXX0JYgkw3GpoEvOXcOdd0PlhCYH4wgat1j9e8YfAcLqVyzVQYsaOblm7U3wKcKwFc/S/nOiLj9JxpkXxzHsC9LaHhwZJ9LUbwdJcxup5EHfHV0FtVN9vRo35YeVV49u7k6unEEhGwlaTTktTaewYkTn1On1kpwLCkgkBoeroz7NgIhWIueLBalGls1IgTAYbqIB4rE+tQjQade9FKOY05IkgE1DBEBS27P9QvaLfCQ5keUTOVDrV4wAZpvdwTx3/hgKh32AHNUF/EFXiZ8v+VlU82h/e1by26NN2COhMOv3ABL42TDVFHI+zn0T2SquEfQTxZx5kds8qmBFt2syxsARwBnxZESGEtSx2RFHs2JWVA1c6nf+YmJhnuf+BmzOZDLQbQZ2i8CqyiPCe1sNXsVaDYEYz1E4LVwtFflOhUi21SacTboGBxZtRlTDM5p+6FwVQwYfnjUIzJu7jR7wzu9Yq++SsWmSSGE2T4qq/AW9s7+pkGXauWai894p4Z9Dm1K3BJqdg3f0KMHpGCmufoY2kXQ0PEPf+yC5R7MuQhErrl65trpKTqmbxZ51idaUuOD6WWjMRkHj2ff8QsoDGC6g9uow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(8676002)(41300700001)(8936002)(2906002)(38070700005)(5660300002)(83380400001)(54906003)(86362001)(122000001)(36756003)(110136005)(478600001)(6512007)(6506007)(2616005)(53546011)(6486002)(38100700002)(186003)(71200400001)(31686004)(31696002)(316002)(4326008)(66556008)(66476007)(64756008)(66446008)(91956017)(66946007)(76116006)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnp3dzhBeC81bXRDMDVPd09zZmZNclZLVU81MmlxS2ZvcmMzYTNkWUdHWTUx?=
 =?utf-8?B?NUpwcWk1dXdUU2xLWi90UzUyaENSM2dwYmgvY2xkaEZGUzVIaWRFZ2krbHMv?=
 =?utf-8?B?Um5xcTNqL1B2U1kzdk51NUpSc01WWDNDd0VVR2g5WnREUVNQMUxVcTZSRnZ5?=
 =?utf-8?B?Nkhkb3FBeEk2VUpmMThEV1Y5blpsRFk3VWE0VmlITnA4b2dEaVVsRlpoVmJV?=
 =?utf-8?B?RW5DZWRqQVZXWE8vM3RrZVg5eGV4Ulp0OXRMZG1ocHVLejRsdVc1V0tmZDJV?=
 =?utf-8?B?L1p2THNZbUtXUGYwa0RPVlBGSzYwQ3VFQkZib3JuWG1hOUJEaEI2UzNIL2o5?=
 =?utf-8?B?WVorWkhkYjJNaXp0cDJFUGhJcG1SbVNDT0lmamcrWkF3QkJ4YjJsVmQ1clAz?=
 =?utf-8?B?RGlDUEV0VWo4VVZidDJOSXNORWxOYi8wVnFtVlNjb0M5a2dFTGkwUGF4OWV3?=
 =?utf-8?B?Z0taM3hzMXNMd1dRRVRNK1ZEMHNLV01udS9YK2dySkxhY0JJMmd4S0NzcVFR?=
 =?utf-8?B?STAvNThPSkcwdXlNTzdrdkQ4TkU0emJ6S0RUSVgzUUFVc000OWpEazZyUFZl?=
 =?utf-8?B?b21KN3RnOGhETGcwVWJCbnF4ZEMxRytOdmQ0MGE4ZldwV1RYZWRaUXIzaExB?=
 =?utf-8?B?UXhzaWNNanR1bU9ILzQ0THBkbGJLclhONUcxYWFzanNZVWFFOWZZU2FNZVlk?=
 =?utf-8?B?VS9mOXNrM3VFOGFjeGdzNXJuZ0ZhWThkdGdyTmxzY2R2UmM2Zzhib0gyV1ph?=
 =?utf-8?B?enhHRlBEUVQ3RDVXaVpLMStweERrcDdBM2JxUEZIYldHcTl3d2NXUi8xUVJt?=
 =?utf-8?B?NkFncHovSlFueGdPWnNpd05SWk41aWhmdmNEeHkzV05walQ5b0NjSk5oeTF3?=
 =?utf-8?B?TzJqbGtFRWpQRGlTSldldTBSQUpOQVNvaSszMlFnd0hkUXl6U0p4dnUxWlBs?=
 =?utf-8?B?dWJzQ1FRd0dCb2l1b2RZU3I2dlQ5RE5leUJXK2FXK3dUSkFoa055UWxGazdR?=
 =?utf-8?B?bUYrOVB4bE1zL0xLRGpENUFaMzVuMnFuZ1dCTERNdkcvRUZ0T3F0czVVZ1ll?=
 =?utf-8?B?SjB3dExna2NSZm9XTkgyMTVSWklQczY0dE9nd2diS3h0QW9BMElhWmd4WFhP?=
 =?utf-8?B?TmVEZ3ZVUGdmQWNPcWpYZUEzRENNcFNOZDJXdXlsVXlRYXFmMHNnb0xjcHZH?=
 =?utf-8?B?TmJTVTFIOXl3SGRIemh2S2tIcXNtYjZpVGx6dWVSTUN6UVZTUmh0NWdIVWds?=
 =?utf-8?B?aWp5bDlqKy9BYTVhM2tWdW51aGhpMWJlcm1DNUlPbVl1YkprSm0yYjAzKzBK?=
 =?utf-8?B?YmRiOWJBVFNBb00zS21uUjYwYWxTZFlvMk1kZ1JNRkxGUllhc1NTSVlNSE15?=
 =?utf-8?B?eUZkRXdnakFMWnZXVVhDZFgxYyticHBTUlNxU0lFM1ljR2toYUJNQUhabTV3?=
 =?utf-8?B?S0Ntcld3Smp2WEljUUxHeEkxbFA5cUtiOVNqblVjWkhXNGg1SC9QNUNUTUNa?=
 =?utf-8?B?M2RIUEJ5R2pTdjFjN3g2elNxYVE2Q3oyZWF0dnBqK2JlWmxEOEJ5djU3dndo?=
 =?utf-8?B?ejBoRFJDT0VlNXAyS0ZMTXc5c0RiQXUwa2ZMSC96bnRjRVlWRFRnRXJOUlcv?=
 =?utf-8?B?cFQvMzE2MU5NczBkdTBoR1Z5T3ZDQkN6OGlDbnNodm96akU4bFRLZXRvYyt6?=
 =?utf-8?B?NytTbnUySXZqZ25SY2NqbFA5L2M3MVVNYTVSSzJNUVJ5aWFqSGtvSWVKSjBM?=
 =?utf-8?B?eCs1L1M0UG5UNzIybCtYOUs4YXFtWHF6K0lhQzJGbmxMVzFidWlyZWx6ei91?=
 =?utf-8?B?dzIvcVJzYUpGUEQrcEp1YnppQkIydUtQVWM3TGZ5T1kySG1wQjRPUWZlckQr?=
 =?utf-8?B?Z3pDZERGb3kwUWtoSUlDY2cyYm9FRHIvRitDc0htQVppeWZ2WUNUTDE0NGNM?=
 =?utf-8?B?NW4xY0M1eVlQeFFQL0tESFN1NiticE5ET3cwUWZpS2ordm0wc3EyRm8zTFNX?=
 =?utf-8?B?dElHaHpoK29VVlRzWmlFa055Lzh1T203dUljUWFRTzREN2xGWlFnMnNKTldW?=
 =?utf-8?B?dXczbGQvcUVySGVnRmdqUnVpSWcrNVNVWjZ2QkpVVE1ZV0NoMkZndkU4YUQy?=
 =?utf-8?B?TGl5S3JlbEFieVNVc3h3ZWEyemlEcE11ejlndktzKzkvYVdqK3BReW5peVFF?=
 =?utf-8?Q?MAASztYfV16PPPeVGwkk8SDWl55Mq7kiov0PsIf9OZvK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <282963F04D9D9D4D8BB1F3B3316B93B8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f29a1b-b3ab-4c90-9d8c-08db411aa72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 21:11:33.2259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/tpPNxiid7r/ruIxOBZoCoE4LQf8y5mF0wpsdb7TACf6kusPHbcdGsU3RffINvBWmncOOqz102WeBEa4zHKbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOS8yMyAwMjo1MCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4NCj4+PiBXaGlsZSB0ZXN0
aW5nIHRoZSBmYyB0cmFuc3BvcnQgSSBnb3QgYSBiaXQgdGlyZWQgb2Ygd2FpdCBmb3IgdGhlIEkv
TyANCj4+PiBqb2JzIHRvDQo+Pj4gZmluaXNoLiBUaHVzIGhlcmUgc29tZSBydW50aW1lIG9wdGlt
aXphdGlvbi4NCj4+Pg0KPj4+IFdpdGggYSBzbWFsbC9zbG93IFZNIEkgZ290IGZvbGxvd2luZyB2
YWx1ZXM6DQo+Pj4NCj4+PiB3aXRoICdvcHRpbWl6YXRpb25zJw0KPj4+IMKgwqDCoCBsb29wOg0K
Pj4+IMKgwqDCoMKgwqAgcmVhbMKgwqDCoCA0bTQzLjk4MXMNCj4+PiDCoMKgwqDCoMKgIHVzZXLC
oMKgwqAgMG0xNy43NTRzDQo+Pj4gwqDCoMKgwqDCoCBzeXPCoMKgwqDCoCAybTYuMjQ5cw0KPg0K
PiBIb3cgY29tZSBsb29wIGlzIGRvdWJsaW5nIHRoZSB0aW1lIHdpdGggdGhpcyBwYXRjaD8NCj4g
cmF0aW8gaXMgbm90IHRoZSBzYW1lIGJlZm9yZSBhbmQgYWZ0ZXIuDQo+DQo+Pj4NCj4+PiDCoMKg
wqAgcmRtYToNCj4+PiDCoMKgwqDCoMKgIHJlYWzCoMKgwqAgMm0zNS4xNjBzDQo+Pj4gwqDCoMKg
wqDCoCB1c2VywqDCoMKgIDBtNi4yNjRzDQo+Pj4gwqDCoMKgwqDCoCBzeXPCoMKgwqDCoCAwbTU2
LjIzMHMNCj4+Pg0KPj4+IMKgwqDCoCB0Y3A6DQo+Pj4gwqDCoMKgwqDCoCByZWFswqDCoMKgIDJt
MzAuMzkxcw0KPj4+IMKgwqDCoMKgwqAgdXNlcsKgwqDCoCAwbTUuNzcwcw0KPj4+IMKgwqDCoMKg
wqAgc3lzwqDCoMKgwqAgMG00Ni4wMDdzDQo+Pj4NCj4+PiDCoMKgwqAgZmM6DQo+Pj4gwqDCoMKg
wqDCoCByZWFswqDCoMKgIDJtMTkuNzM4cw0KPj4+IMKgwqDCoMKgwqAgdXNlcsKgwqDCoCAwbTYu
MDEycw0KPj4+IMKgwqDCoMKgwqAgc3lzwqDCoMKgwqAgMG00Mi4yMDFzDQo+Pj4NCj4+PiBiYXNl
Og0KPj4+IMKgwqDCoCBsb29wOg0KPj4+IMKgwqDCoMKgwqAgcmVhbMKgwqDCoCA3bTM1LjA2MXMN
Cj4+PiDCoMKgwqDCoMKgIHVzZXLCoMKgwqAgMG0yMy40OTNzDQo+Pj4gwqDCoMKgwqDCoCBzeXPC
oMKgwqDCoCAybTU0Ljg2NnMNCj4+Pg0KPj4+IMKgwqDCoCByZG1hOg0KPj4+IMKgwqDCoMKgwqAg
cmVhbMKgwqDCoCA4bTI5LjM0N3MNCj4+PiDCoMKgwqDCoMKgIHVzZXLCoMKgwqAgMG0xMy4wNzhz
DQo+Pj4gwqDCoMKgwqDCoCBzeXPCoMKgwqDCoCAxbTUzLjE1OHMNCj4+Pg0KPj4+IMKgwqDCoCB0
Y3A6DQo+Pj4gwqDCoMKgwqDCoCByZWFswqDCoMKgIDhtMTEuMzU3cw0KPj4+IMKgwqDCoMKgwqAg
dXNlcsKgwqDCoCAwbTEzLjAzM3MNCj4+PiDCoMKgwqDCoMKgIHN5c8KgwqDCoMKgIDJtNDMuMTU2
cw0KPj4+DQo+Pj4gwqDCoMKgIGZjOg0KPj4+IMKgwqDCoMKgwqAgcmVhbMKgwqDCoCA1bTQ2LjYx
NXMNCj4+PiDCoMKgwqDCoMKgIHVzZXLCoMKgwqAgMG0xMi44MTlzDQo+Pj4gwqDCoMKgwqDCoCBz
eXPCoMKgwqDCoCAxbTQ2LjMzOHMNCj4+Pg0KPj4+DQo+Pg0KPj4gVGhvc2Ugam9icyBhcmUgbWVh
bnQgdG8gYmUgcnVuIGZvciBhdCBsZWFzdCAxRyB0byBlc3RhYmxpc2gNCj4+IGNvbmZpZGVuY2Ug
b24gdGhlIGRhdGEgc2V0IGFuZCB0aGUgc3lzdGVtIHVuZGVyIHRlc3Qgc2luY2UgU1NEcw0KPj4g
YXJlIGluIFRCcyBub3dhZGF5cyBhbmQgd2UgZG9uJ3QgZXZlbiBnZXQgYW55d2hlcmUgY2xvc2Ug
dG8gdGhhdCwNCj4+IHdpdGggeW91ciBzdWdnZXN0aW9uIHdlIGFyZSBnb2luZyBldmVuIGxvd2Vy
IC4uLg0KPg0KPiBXaGVyZSBkb2VzIHRoZSAxRyBib3VuZGFyeSBjb21pbmcgZnJvbT8NCj4NCg0K
DQpJIHdyb3RlIHRoZXNlIHRlc3RjYXNlcyAzIHRpbWVzLCBpbml0aWFsbHkgdGhleSB3ZXJlIHRo
ZSBwYXJ0IG9mDQpudm1lLWNsaSB0ZXN0czctOCB5ZWFycyBhZ28sIHRoZW4gbnZtZnRlc3RzIDct
NiB5ZWFycyBhZ28sIHRoZW4gdGhleQ0KbW92ZWQgdG8gYmxrdGVzdHMuDQoNCkluIHRoYXQgdGlt
ZSBzb21lIG9mIHRoZSB0ZXN0Y2FzZXMgd291bGQgbm90IGZhaWwgb24gd2l0aCBzbWFsbCBzaXpl
DQpzdWNoIGFzIGxlc3MgdGhhbiA1MTJNQiBlc3BlY2lhbGx5IHdpdGggdmVyaWZpY2F0aW9uIGJ1
dCB0aGV5IHdlcmUNCmluIHRoZSBlcnJvcnMgd2l0aCAxRyBIZW5jZSBJIGtlcHQgdG8gYmUgMUcu
DQoNCk5vdyBJIGRvbid0IHJlbWVtYmVyIHdoeSBJIGRpZG4ndCB1c2UgYmlnZ2VyIHNpemUgdGhh
biAxRw0Kc2hvdWxkIGhhdmUgZG9jdW1lbnRlZCB0aGF0IHNvbWV3aGVyZSAuLi4NCg0KPj4gd2Ug
Y2Fubm90IGNoYW5nZSB0aGUgZGF0YXNldCBzaXplIGZvciBzbG93IFZNcywgaW5zdGVhZCBhZGQN
Cj4+IGEgY29tbWFuZCBsaW5lIGFyZ3VtZW50IGFuZCBwYXNzIGl0IHRvIHRlc3RzIGUuZy4NCj4+
IG52bWVfdmVyaWZpY2F0aW9uX3NpemU9WFhYIHNpbWlsYXIgdG8gbnZtZV90cnR5cGUgYnV0IGRv
bid0IGNoYW5nZQ0KPj4gdGhlIGRlZmF1bHQgdmFsdWVzIHdoaWNoIHdlIGhhdmUgYmVlbiB0ZXN0
aW5nIGZvciB5ZWFycyBub3cNCj4+DQo+PiBUZXN0aW5nIGlzIHN1cHBvc2VkIHRvIGJlIHRpbWUg
Y29uc3VtaW5nIGVzcGVjaWFsbHkgdmVyaWZpY2F0aW9uIGpvYnMuLg0KPg0KPiBJIGxpa2UgdGhl
IGlkZWEsIGJ1dCBJIHRoaW5rIGl0IG1heSBuZWVkIHRvIGJlIHRoZSBvdGhlciB3YXkgYXJvdW5k
Lg0KPiBIYXZlIHNob3J0ZXN0IHBvc3NpYmxlIHJ1bnMgYnkgZGVmYXVsdC4NCg0Kc2VlIGFib3Zl
Li4NCg0KLWNrDQoNCg0K
