Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640485F4F84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJEFiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJEFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:38:02 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F2E6A489;
        Tue,  4 Oct 2022 22:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ1RoflQ+3lwYSCux9GfHjh5RxJRxhgjyOeaNceF6nbtzWuOKwNhgo9WGpMsNPvHJCwQ2rOhvxv85udr6uSHlB34OeEABosewmbSnXH5pP7KeiscpBU+rhibt2mMaWHj1qy8eXVedia1ufJx8jf8ut7iUkn8kDbSvyP/mkyf0QmnYLI8i8fUrkhyYWfewKZv7llIM4eQDBP9PSeeekkpF/fbJugSRJ1pyFhGp5r3W/AcN+mWmszCDNFIc8kibWFIwYGByw/r9LMJ8LIDRzcP9qgnduz/15iUCwucyU1BnBjq9caOOaVcsektg5+21OPOsG8Uhkhkfr9XGAc3FS45lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KKWl19ddfSTsKSbd7zIdl0e0fLOxU1QNX7P3zki6Jo=;
 b=BUyvxag3y9Z9eUb7rIB62bSPnj3Ezoos84rsKGBBaLIpVsV2ZYfhfqHlHuawmnbggF/ynyJNaAUq812Pcd9zq90r/bcM/ZW+YKmYaOg7pZPIFWU8WBlBWMhx9N42TIBRmGerAos38rKHVoAUpP7dlx7hPekTIv1qyvno9Lz+3yYx7gWCutVpYFGvH3jRPBvaxKfrFywGYOQdOIKekq7RtxQkAXurrykHs9602rbI99/uiU5Q9j+M1gI3McsbTuyzV5yCPBLVFpeYi6BncPXFAyZFoYkLTfz6gWx9pvM34cBaoCB74lTDNRyu/3drRE0e2G+qhUapP/o1hx3gqQsUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KKWl19ddfSTsKSbd7zIdl0e0fLOxU1QNX7P3zki6Jo=;
 b=UHJIpH1+By1jUALbl0wzROkYbtzdBaUjxGXrXMEXpHM1a/btdtpwR09LvDxwHcfVANFabw5H8WgMV88JflKYG1z+kHWXLORpRISoodNipa7paQcosW/C0SdgP9m52YzGApX8/jE+edRMWzZKrmpN8xi61seKV5KHF87Tkpqvy3a6y9nXcrBRRXwqH0LqOMAdRo9ImOMs6w6JEawdCGfruyNLHqU38FxVb8YOjiIHRF1I5VqfhU3OMxiOXY3ASTvE2qg0IWXi2vsNri0r5NGZJXYlinR+AOh9ho6PUTs/tVQJ9BYwMPUH9kF5u3YqRiGmFTl0ijTG8kHbW34chZQamg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Wed, 5 Oct
 2022 05:37:59 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::a1bb:b25d:8309:27e6]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::a1bb:b25d:8309:27e6%7]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 05:37:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
Thread-Topic: [RFC PATCH 01/21] block: add and use init tagset helper
Thread-Index: AQHY2GnUla2DUnT45EePa3oKE5VM3K3/QPCAgAAHfAA=
Date:   Wed, 5 Oct 2022 05:37:58 +0000
Message-ID: <b2c5d8cd-aee1-d02f-33b4-d424a6db9c55@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
 <20221005032257.80681-2-kch@nvidia.com>
 <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
In-Reply-To: <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|IA0PR12MB7603:EE_
x-ms-office365-filtering-correlation-id: edc9018c-f3d0-4470-b979-08daa693c314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XFPBLQRNF9h0ZUB6CYMJxb/xyS8xtgJ6wIUI45DTr119ABJwPf1Zy5pqCZxzQrHCtbaJWmY+71aPvSp1co50QqZsLP+hv2SDy143IztA3pda9mrfb7BYJy4OPtIn8CQKsOYs73PTlW0q1YaY0hWjZSasgEmvxfu7YZyqcH19kmXpGRDIeMu6riaITankfR3/OuYLzl/EDhx8DlUY2FsxSuKvKp5VMqXfFChnnOQfXADJm1VVVrjZJGOIl6/5FY6GCzHBqJc47NNA1zbwQnK5tDpOs7Zl3+OIt+DSqLq8811XJbgfY4zmqKwsVZbZ58yLGJuWuUXaZGt5RPzCt1e+a0V2mEq2MFvO64DX+zTWUvMsHY+Y/sVQkyMb44pE+Yva9H0saD5YvufPmsjweW3tNRoIN+kZXEZQQ9m5vRd15BPelC5Ow5GmYHNUWMykzLrprcGqAcecH2TQBHNNghPTQfKVLY1eNW9OWpK+9NCt+SmAa4A0C6QE8KteYCMaibqrmWv4PB1IHVHl90QwekbMJqxvpX3jVZFqgi39DprgHpynz4SRRS+ZUsTW1gAgbpsHeSz6FUWUoEMopgwIUD4GE/qV4EOKuKQxd24VJVg4BHNF4pW4dNHYbwfREfgoce4NEW7t9IY6xhnMcGEItOE6FWdL/lMXcYi8ggxXFLXqbOCAMeFOs4clRC1EncJlq2VZo6thrviru62BBsC4LtMaJW1E6meDWfxdkBtRRTAFYB3VgHNbNwFDkj6YCZvuxELHqjzIfjs5n85MBADN2ckAA+YydVEsoKrwfJ60wkZYi1T5F5HINslrEx4dktm0oDrJrQo2ekdNrNzAYA0haV7tOBfNh7ThOYjw72ERNI3bUaQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(6506007)(107886003)(36756003)(38070700005)(478600001)(186003)(2906002)(6512007)(76116006)(2616005)(86362001)(31696002)(38100700002)(5660300002)(53546011)(122000001)(83380400001)(6486002)(91956017)(31686004)(6916009)(64756008)(71200400001)(8676002)(41300700001)(4326008)(66446008)(66476007)(66946007)(8936002)(66556008)(316002)(54906003)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnUxbTM0VHc0VnI0clZtMVUveWh5R1JEN0xVV3RhUjQ4alY1WWg1VXhFOVBy?=
 =?utf-8?B?MW9SN1lsRXhpcXA1RUZ4SUJkK3c5anRqNXV5aTdRdjhrNU8xcVhMNjRxdndp?=
 =?utf-8?B?bFd0aVREeHVUV1NRL2VTRitlUXp4b3lHWkxCNURRSHJmQ0pwM3M3dGQzVlh0?=
 =?utf-8?B?ajN3L0pKTnhyWUpmck5GSEhvVVd2YlNnaDc3OHRabXFMaGdyTm9CNXdVNUxV?=
 =?utf-8?B?cUptRFBtTHA5Z3ZkdFNHcWZoMDh4bFNJclhmdklxOEliS0hSMCtHTG10cGYx?=
 =?utf-8?B?Z1hRb01TdmN4UWo2Z1pHeUorVEtUbWs3cEVQSVhVN1MyOFVMU2lFalhITERF?=
 =?utf-8?B?bStQNTFWcUsxOTZ5T0hmZ2JsRDM2Mmx5dFpsRTc4ems5cFUvelpKcEZTeUxK?=
 =?utf-8?B?QVBrcXRuT2c5MUFnYlpydjYxNGRaYW5uK3B3czVXYnpPRks0K2t4WnF4R1I1?=
 =?utf-8?B?MUwxTFhnanI4eTE4MzZEaTJmMXRSaUxxV0Z3V3hqZXY0RlBoaUUzblh0VGRh?=
 =?utf-8?B?MWVGYk12OTBTYmdraE1FV3JmcWY3UThKMjBPUnZsSm9zTjRQYUVGN2ZSaUJZ?=
 =?utf-8?B?TGZJSWYrUUpwTGtaQWR1TW0rTWdORVdhNkNRMmVoWUhSdnI2OU11SU1iemJV?=
 =?utf-8?B?ekc3cnp0WVk4ckx6dEV0Q0s5ZDFGM2VzNldwVldnTkh6MFIwaEJxT1NNY252?=
 =?utf-8?B?cVRBdlBTSHhsTjJ3dkhPcDBHbFVzbktXeHU4Z1IwUVFGS1pqSEZBQmkvbWEw?=
 =?utf-8?B?RzhZY1JpMWRjb09NM2IwZkMybEtMQVIrK1FvTit2aU5ocnlDRU5aaTNJeGpt?=
 =?utf-8?B?MWtiZENZYmEyYkZkZDh2bkx5enVJV3pOV3pHc3U3NWp3YmJKOC94Mjlxc0Nj?=
 =?utf-8?B?Q1ExZFZjTHUrTFNHZVdJNVlsZGZBcTE0aXlKSGFkaEo4aUl2dnZyM0lQUExa?=
 =?utf-8?B?NDI0VnFoRUMvakZ2YXdBcW0vYk9md1NzT3dHNkNTdFBTcEc3dFY4ajlUWmd5?=
 =?utf-8?B?VllORmpvS3o1YkhQZVd2dVc2N2tuVGo1d0ZySE1jSUQ5K044K1JFdEdWQlJJ?=
 =?utf-8?B?c2hoL2F2eXhjcjBJQzBaVkZNbDJkeHhETnE5V0RmWmJzRXBqOGtpbmJMSkU3?=
 =?utf-8?B?Zzd6L2NwVkdZQytKSzNQNjFKWXJYUHF0amhDV0h1MW9zR2lnSXp0S0lGemF0?=
 =?utf-8?B?YzNaNVZxc0YzTkVERTE5ZkdtbWxDb2FEQzN1OEVwRUc4Yk9WWHR1ZWgzVU9R?=
 =?utf-8?B?dXN6MHlTaVVoeVdjME9zNUFxZkpSK2pCYVZxZzJKRmU5NE1TWHZtbTdPZlhy?=
 =?utf-8?B?aktrS05RVDNiaTBOZHhwTy8vWElEYUZXUHJLM1lvZXYzM0UyRjUrMlhTNVdT?=
 =?utf-8?B?YU9IUy9tUXRVY0pKN2VIcDlYN0p3dE5Dc2ROWUtZa0NkbjAzYmo1NkFTK1E3?=
 =?utf-8?B?Ukc5QUxaUFh5cjEwSlJxazF5dldJWmYrR1VpWFcxK0Z6bVNna1F1YzhUdElW?=
 =?utf-8?B?d0FRMnBvWmoxVGlncnJtZjlSTW9jWVYvOTUzWUZEcmx2SmU3NUtSdEhueWVE?=
 =?utf-8?B?YWhnVkk5b1VJdmFVMFJZVVpKWi95aGttQUhkazZRdFdVVHhwRXZzbVV6U2Vt?=
 =?utf-8?B?UVdubUg5VTNJWFhOMGJPMEJHY0VpM1d5cjgxZjRGU25QR25oMk9Md3RMUXR6?=
 =?utf-8?B?aU9hWVQ3OVU4T0xTZ3NJa1FsNXk5c2pUWlFMNE5EMGlLUGNOREphMzZSZGpr?=
 =?utf-8?B?bk53R1dqd3gzOHlMUVZWQ0I1aHhSUHRWNmtPYUZQQ29JK3o3Y3FOdnRJYTA1?=
 =?utf-8?B?QjRsQmExUkxwamQ4SUgxT1FzS0hHdndCeXlUYU5HT054bXZXMVR2MnJQUTVr?=
 =?utf-8?B?MC9pTWlydk15ZzJLemY3MzVRNytKM2tHaEpmVXZCNGo2UGtZb2wxTVhNaFlk?=
 =?utf-8?B?VTQrK3RkU0VCNVZHbjZnMFZUWkNTVkp1Z2thcWtFa1JjeFlGWkh0YUpjcjJB?=
 =?utf-8?B?TVNIdElLZzJSNzZYU2paYVNKZGlVL2xyU1VtSGx0VmdyV3RwaDdMQmFnR3hK?=
 =?utf-8?B?cEJ0YlI4RzRLYncySXJPeW13dTRSaVhEY3VHVTF2eUlRN3ZUbms4RTV2ZmNU?=
 =?utf-8?B?SFBOZ01xME44aVE3Ty9HNXRhS1hLTVY5OWttVXM1TTBET3hYTkREam5UN2p1?=
 =?utf-8?Q?sGhu8UVAEbKhgS/AZYsDr2z/wYY4ERh39yJJPLJDxHLz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F2F1FC00E51A64093C462975DDAC46D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc9018c-f3d0-4470-b979-08daa693c314
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 05:37:58.9352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEhOjF5K8Sacc6405OU/WU55Gva5oA/ZsqQhxALPZA08qLEFmL25BDj+sCL2sEW5FQtpZFX+egEzdQpx1fYURw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNC8yMiAyMjoxMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDEwLzUvMjIgMTI6
MjIsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEFkZCBhbmQgdXNlIHRoZSBoZWxwZXIg
dG8gaW5pdGlhbGl6ZSB0aGUgY29tbW9uIGZpZWxkcyBvZiB0aGUgdGFnX3NldA0KPj4gc3VjaCBh
cyBibGtfbXFfb3BzLCBudW1iZXIgb2YgaC93IHF1ZXVlcywgcXVldWUgZGVwdGgsIGNvbW1hbmQg
c2l6ZSwNCj4+IG51bWFfbm9kZSwgdGltZW91dCwgQkxLX01RX0ZfWFhYIGZsYWdzLCBkcml2ZXIg
ZGF0YS4gVGhpcyBpbml0aWFsaXphdGlvbg0KPj4gaXMgc3ByZWFkIGFsbCBvdmVyIHRoZSBibG9j
ayBkcml2ZXJzLiBUaGlzIGF2b2lkcyB0aGUgY29kZSByZXBldGF0aW9uIG9mDQo+PiB0aGUgaW5p
YWxpemF0aW9uIGNvZGUgb2YgdGhlIHRhZyBzZXQgaW4gY3VycmVudCBibG9jayBkcml2ZXJzIGFu
ZCBhbnkNCj4gDQo+IHMvaW5pYWxpemF0aW9uL2luaXRpYWxpemF0aW9uDQo+IHMvcmVwZXRhdGlv
bi9yZXBldGl0aW9uDQo+IA0KPj4gZnV0dXJlIG9uZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4+IC0tLQ0KPj4gICBibG9jay9i
bGstbXEuYyAgICAgICAgICAgICAgICB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+PiAgIGRy
aXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jIHwgMTAgKysrLS0tLS0tLQ0KPj4gICBpbmNsdWRl
L2xpbnV4L2Jsay1tcS5oICAgICAgICB8ICA1ICsrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwg
MjggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxv
Y2svYmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYw0KPj4gaW5kZXggODA3MGI2YzEwZThkLi5lM2E4
ZGQ4MWJiZTIgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9ibGstbXEuYw0KPj4gKysrIGIvYmxvY2sv
YmxrLW1xLmMNCj4+IEBAIC00MzQxLDYgKzQzNDEsMjYgQEAgc3RhdGljIGludCBibGtfbXFfYWxs
b2NfdGFnX3NldF90YWdzKHN0cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0LA0KPj4gICAJcmV0dXJu
IGJsa19tcV9yZWFsbG9jX3RhZ19zZXRfdGFncyhzZXQsIDAsIG5ld19ucl9od19xdWV1ZXMpOw0K
Pj4gICB9DQo+PiAgIA0KPj4gK3ZvaWQgYmxrX21xX2luaXRfdGFnX3NldChzdHJ1Y3QgYmxrX21x
X3RhZ19zZXQgKnNldCwNCj4+ICsJCWNvbnN0IHN0cnVjdCBibGtfbXFfb3BzICpvcHMsIHVuc2ln
bmVkIGludCBucl9od19xdWV1ZXMsDQo+PiArCQl1bnNpZ25lZCBpbnQgcXVldWVfZGVwdGgsIHVu
c2lnbmVkIGludCBjbWRfc2l6ZSwgaW50IG51bWFfbm9kZSwNCj4+ICsJCXVuc2lnbmVkIGludCB0
aW1lb3V0LCB1bnNpZ25lZCBpbnQgZmxhZ3MsIHZvaWQgKmRyaXZlcl9kYXRhKQ0KPiANCj4gVGhh
dCBpcyBhbiBhd2Z1bCBsb3Qgb2YgYXJndW1lbnRzLi4uIEkgd291bGQgYmUgdGVtcHRlZCB0byBz
YXkgcGFjayBhbGwNCj4gdGhlc2UgaW50byBhIHN0cnVjdCBidXQgdGhlbiB0aGF0IHdvdWxkIGtp
bmQgb2YgbmVnYXRlIHRoaXMgcGF0Y2hzZXQgZ29hbC4NCnllcy4uDQoNCj4gVXNpbmcgYSBmdW5j
dGlvbiB3aXRoIHRoYXQgbWFueSBhcmd1bWVudHMgd2lsbCBiZSBlcnJvciBwcm9uZSwgYW5kIGhh
cmQgdG8NCj4gcmV2aWV3Li4uIE5vdCBhIGZhbi4NCj4gDQoNClJlY2VudCBhZGRpdGlvbiB0byB0
aGUgYmxvY2sgbGF5ZXIgY29kZSBibGtfcnFfbWFwX3VzZXJfaW8oKSBoYXMgOSANCmFyZ3VtZW50
czotDQppbnQgYmxrX3JxX21hcF91c2VyX2lvKHN0cnVjdCByZXF1ZXN0ICpyZXEsIHN0cnVjdCBy
cV9tYXBfZGF0YQ0KKm1hcF9kYXRhLCB2b2lkIF9fdXNlciAqdWJ1ZiwgdW5zaWduZWQgbG9uZyBi
dWZfbGVuLA0KZ2ZwX3QgZ2ZwX21hc2ssIGJvb2wgdmVjLCBpbnQgaW92X2NvdW50LCBib29sIGNo
ZWNrX2l0ZXJfY291bnQsDQppbnQgcncpDQoNCmFib3ZlIGZ1bmN0aW9uIGFsc28gaGFzIDkgYXJn
dW1lbnRzIG5vdCBtb3JlIHRoYW4gd2hhdCBpcyBwcmVzZW50DQppbiB0aGUgYmxvY2sgdHJlZS4g
SSBjYW4gdHJpbSBkb3duIHRoZSBhcmd1bWVudCBsaXN0IHByb2JhYmx5IGJ5DQpyZW1vdmluZyB0
aGUgbnVtYV9ub2RlIGFzIGl0IGlzIHNldCB0byBOVU1BX05PX05PREUgZm9yIG1vc3Qgb2YgdGhl
DQpkcml2ZXJzLg0KDQotY2sNCg0K
