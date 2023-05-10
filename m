Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02036FD400
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjEJDGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEJDGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:06:10 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2087.outbound.protection.outlook.com [40.107.114.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999883593
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exJCdoEBAc35d5tKrsgT4bjpPJJ6+uiO/OctJpUaJe0LJHEkVNsar7MG55BuBZKXgGR5IllKpOvdDKXqD6tcG6i/RsG8NzkIGu79s9W3M30yfo3eruQ1zeDESGR9z03zf7Jv3roZTGXiXs1+W21o54r4snftqaW4nX39iHvquO5rhmd0DhRU8Tu6Le93I2GSHj53bFciG5+VrL9+1MzjyqCNN7Nw6e7nuFUHNNNRN9KHEHp0lRKMb8WfjmGBaXzZElpHCv7wYCGbvS9XpiJ0n0jAYlbB17of+SgKrAhJk9KiKoddQCDyPVKOtUJI8KxETfd7OilnaMJW8bonygVjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg0Q9lHXMDYHu9j0AjTe/8QYxc43qmuBDQYoWl7L1EA=;
 b=Saq7NAN2q6pBWl9wTey3qUXxRgJiKM4FjbWwueXz6fFJ0tjAmlJPg2qBWQZN0/QO38WNB6Ia8EUMRGWeponIWZj53zUiAUvLwt/kGBLlhV2U2BujxxcFm/iD9EfaC1/kl44IVhB0g4LIyglngcQ81KOAcCOcv3sfkEVKkBAXGf26BNoa9uWtQlG8jq6TJa/zlaYBLZgalYff6iUgWijYcll+Zx8yszQ445xuJEKujfnLalAyNsE+OJD75CDvpAsF9+/K1FOeuiQAsJKGRSxzC6dfwIyyfyTt1pIYBrBs2mQOWHMKVvU4H2ZTJqTBQuEYhw52WmkuIiECcMspD17YRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg0Q9lHXMDYHu9j0AjTe/8QYxc43qmuBDQYoWl7L1EA=;
 b=as5IXeXVfyrHTbKCJHVAdU5v5+qGSFSkOjH7nxcYMmqudnkeqIl0hUP8dh1H1uKF/wIVDGJDmClNcaN2SVcFe8FBBowBIURJBo/IWKOsOLP6NSP/zgTB4R7LaGIF0iv6bOqNlYVIBFQ7+SV0/r0iunx0n3MMSnRbq/VIRICiuIY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB5688.jpnprd01.prod.outlook.com (2603:1096:604:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.34; Wed, 10 May
 2023 03:06:06 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 03:06:06 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: memory-failure: move sysctl register in
 memory_failure_init()
Thread-Topic: [PATCH 2/2] mm: memory-failure: move sysctl register in
 memory_failure_init()
Thread-Index: AQHZgZ+jkXqP7wVhyEaBV782U4xqCK9S1XkA
Date:   Wed, 10 May 2023 03:06:06 +0000
Message-ID: <20230510030606.GB30737@hori.linux.bs1.fc.nec.co.jp>
References: <20230508114128.37081-1-wangkefeng.wang@huawei.com>
 <20230508114128.37081-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20230508114128.37081-2-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OS3PR01MB5688:EE_
x-ms-office365-filtering-correlation-id: f7e1d5b0-daba-4545-f4be-08db51037f70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDDErX1LCyP4IgXUB9MnkZbM7YubLc/h3pd/3w4yu+SffhUiwdPmcYGMOdGFRkp8i8pU3wQipUE2XmuMMpWFE5sbTOERp3UaWVWjseruAr1kHGKpD9AqPgWOGEZcFlKdQ9/7zMePXEOZU5v5arBmjljZEaqJk4vLPnlG4F4TNiapP1wSzkRC/0zWt0lApGE2L8nvKj9Y8Q7fV0rVdp2+Byj+7pCrFlfeJreb+/lfvx38V0LV9I5mufbwN1+NmNo/zW97O14erri2kZU96oyGnTAxWpa1zp7YCfmlkMLSZMkPLDwAKOTqCayg6K6PeoeXyJsAQtoBvuIET4TPff4JbOTey6T7TAptybUFDXgk5PvPp2RZ0XSzswRX4ZI8GPmDqrh41TV2c+O5mAkgD6HsAkaj91Bhg4LJR55j7CPmpFhQrCACPbLchRgcc29tl2Su4RbeYEFX8O7xVyXFOPTkGOUQk1/euSo6RhLAiduwwBTsVnojDD148tH47NDIpeZYP82z5dR/ftvFHr47rA4k6zc55sjiIvx0C8lCqOxX04HdG52yCNMG9qOP7LRPSMFXfci7lWtLR01Jt0fLakGbtmMCuGErkwO+vtnyn+yrEHmbzwhkCmt1WDhl6G0eHoLL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(86362001)(6486002)(71200400001)(558084003)(33656002)(9686003)(6512007)(1076003)(6506007)(2906002)(186003)(38070700005)(66556008)(66446008)(66946007)(66476007)(76116006)(6916009)(4326008)(83380400001)(85182001)(54906003)(316002)(82960400001)(64756008)(26005)(122000001)(478600001)(41300700001)(38100700002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWRrQk56bEpMN01NbUVyQVQ0bGNVVGJ4SzZtS0FkM2lqenliN3IvMDRndWt6?=
 =?utf-8?B?KzNQdVhaYnBWVTg2dHhLNFREZUM1azYzYWVoaFFRbVlMRTlFck1tTHNUaVNp?=
 =?utf-8?B?b0V3YzhxNzRjL0JBcDExVnFwWkFaNDU3WFA1T01aUUVDRkFRVUtRclhaR2lq?=
 =?utf-8?B?aGNCaXdlOFA5QlpONzRCMW9Qd3BhOWp0SWVYWXAwbzQrNXB1TmhGVkpZZS9h?=
 =?utf-8?B?RUdnS3YraEZOWTkyMlNUWnlPYURIZ1BDYUlvYVl6d05JNkpObUlSUGZ5cURz?=
 =?utf-8?B?b2VDY044allFNFFvUktEcjRmZHpXeTRsaTBabThYdXJOSkFLcmU1Z1NzN0ZP?=
 =?utf-8?B?RFlJSGp6ZEJ2SXMvSFIyazJmOXcrUUgxU3E3bndabWdON0gvVkIyUzE4eEVN?=
 =?utf-8?B?TnNzbDBDWHJ3MElQNk5oc0FJM2FNQjA0aFZQSFJiUExyR1MvdkNKZHpaKzZF?=
 =?utf-8?B?VkYvaDY4ajNoeTczcTJTUmdEU0cvSVBkcm9mYXFHeS96WkpLdjlpdFplSlA0?=
 =?utf-8?B?SStrd1RhbHVZVTZDWVVleTVpaVpabEh4Rm84eUlKNDkxNTY0UGU5WGVWczU2?=
 =?utf-8?B?d0ttK2pKeWxtTE9OdEs0S0xqTFh6bWIzVWZ4akxoaHJyNEdOYTBRVFVlOVZX?=
 =?utf-8?B?TzFKM1hwLzRkWTlOUlhBTW9YQVpRYVRqYm1sM24zaEdzOGwvbkhvYXVQb3li?=
 =?utf-8?B?cURrNTh4L0JvSEp2bTlhcWhhWm15L0Q3WmlsWUVETlN4azdOMnYxenRLcUJZ?=
 =?utf-8?B?Nnk3Q2V0Q1QrbmkzSGQyN3RqWHh6aVFJRHZ6d0V4ckw3WnpHTU0zQVNpVVVK?=
 =?utf-8?B?ZmlITlBVYUtTNWpCNTJQWmVWRXo2dmNLQzFaQmhmVG9NRWdrUzNxYS9VaDcr?=
 =?utf-8?B?OXd5WCtwNFduZHR1cEo5NGFQdDJmTlAvN0xSV0NFc1R0cmFFalU5WmlCZFI0?=
 =?utf-8?B?blVaYWxqaFJZcHJOVnB5OTRhSEpMOHBmUGM4S0JWSTB3SDZzLzVOejg5dnpt?=
 =?utf-8?B?V3owRm5rM2hYZFlnOGh6Z3lZY2I4RElVQVhCdnI2TGRFcm1NdzE4OUZhT2lD?=
 =?utf-8?B?SFZJUFR0SXFCS2VSczd3ZnJKQ2pNWGRFdkJjdXNFZFZsOUdmYzBKd29yZVhB?=
 =?utf-8?B?aW5FSG1ITzBwOUhBVW5BbDBEMVdUQ0dvckdtaHdFNWw2Z2hZbzlUNFphTjRp?=
 =?utf-8?B?WGo1QjhaeXBiSXBLQkthTSthZEZNY3dqS0V1aUIrS01CcnRlUm1YaUxmSjZk?=
 =?utf-8?B?NjF6QUhzbmc3YVRsdzdraHdGcERWWTJxajk5QlVNcFpyaEpmQU53NjFLblM3?=
 =?utf-8?B?d0FZa0dZZTdSSVU4Z2lYUmYzOWFhamtzMmg2QUNlbU5kTFF6VWZGY3p2Y0Fq?=
 =?utf-8?B?aVIwbXhoeDZ3ZEYxdUI2bFNSQWpHZ3hDN2JwMFZ3VzBLaUFhWjQzZG1kcVpk?=
 =?utf-8?B?SW9OSnBGbVhXT1h6WGtESXdrZkVNQXMwTktHbElrUUxmNDRTQkJHZGUzK1pi?=
 =?utf-8?B?ZndISkNzbzhwRzlnM2hPTEFFdjRBS3RGZ3oxamNsQTVGWXNvK3ZKdlVXYkla?=
 =?utf-8?B?ZEZ1WVZJeHJUek9vS2Fob3hIZnM2cmtZZzBkcVFWNHdWajlQVTNhNE5Wak03?=
 =?utf-8?B?dnJ1c2ZmalB3ZFBlUHByT2JHbDE1dk40WWN6T2JFTkkzVkM3cjdLSy9JZUZt?=
 =?utf-8?B?emRUcXJrSEk0WER3WkV0WVhKL2FUM2VwaTZvQkoyeUZpZ3VMQnVVSE5iNldk?=
 =?utf-8?B?VlFqZlc3WnlaZmNmNEJDcVdxdndJdnVLcDUvbDNOenAzUGYrMGhUaFoxczhp?=
 =?utf-8?B?VWlZM2haQ3F2bEtkdDgyYjhzWEY0bW9WaTVUOXhnWlBEQjRvamt4ZkNOMmRx?=
 =?utf-8?B?QzBnME5KbzBGK1dNTGdHTGlWaUJCR3A1ZVYrS2s4cUc0cUw3c3N3eXhrTi85?=
 =?utf-8?B?eGZWK2Z4YW9CQkdNL1B3cGRXV2t3bDd3OURMWk5OWmU5S09Ody96UkJ2Ujdh?=
 =?utf-8?B?RzlSM2ZJd0h3SHgyY3pVd3BIOW1NU3FLRlRMTVhwSCtWYjhDTlVRSlg0ejFC?=
 =?utf-8?B?UUNNTHh0TzM0a2Y0bGcvZGFEWWE2QzF5b29WQVhSWkdsbWVQSEJYclVnWm0v?=
 =?utf-8?B?ck9acFJ3ZXRxSU5KMGdiaCtOQzJGSkxyR2VmSUJYQk12SVQ4R1JjNmlOL1pO?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A910110E475984F9F90AC0B600F0DDF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e1d5b0-daba-4545-f4be-08db51037f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 03:06:06.7536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhudtOZFZZ3QaGaoM4yF+4EFYq1dfsTJVeSXDLCyQZtdqvJg3i3Qs78DVAt8YzyptvGtbVtBbb4sJBY5vdI6yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5688
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMDgsIDIwMjMgYXQgMDc6NDE6MjhQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFRoZXJlIGlzIGFscmVhZHkgYSBtZW1vcnlfZmFpbHVyZV9pbml0KCksIGRvbid0IGFk
ZCBhIG5ldyBpbml0Y2FsbCwNCj4gbW92ZSByZWdpc3Rlcl9zeXNjdGxfaW5pdCgpIGludG8gaXQg
dG8gY2xlYW51cCBhIGJpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtlZmVuZyBXYW5nIDx3YW5n
a2VmZW5nLndhbmdAaHVhd2VpLmNvbT4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFv
eWEuaG9yaWd1Y2hpQG5lYy5jb20+DQoNClRoYW5rIHlvdS4=
