Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD4605969
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiJTIMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiJTIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:12:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2135.outbound.protection.outlook.com [40.107.117.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C06109D47
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj0cazUMrdWP9/7wvAxRrdpaC94cZnJDcDmAnLJrxncll58cCsdvo3q3f000DoN7/5DndnuV6dY7pEWCtft/fXa4ccArbF7iWmAEiZeMvp6n6o65OrgnTdxC7OlKw+XupGU1uby7dilcYr+ZZLJP8VY1aisbw2K1h94Y5iM6yPsF9a9zOf1/BPIknNtpPRT/mEMJO0tlXtMrdfbvbAKKSMYZu3dhzFGXPKs2vOksIwT1/vyW+z65ZSQoGtAxJBTuqCPNsif3WuOTfD6g6ke1xdbhXpL9OOR3VgelDvuG05kpUrYwQHnXyUvQx6qtBUbJBmaxKApeY5EIkvaf7Cxf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uaAEfgxliMoESOn6Q1UOWoSSTqGvZ0bmlDoEo13/RA=;
 b=UIUVRiKemNRybYoOnZZohyXXvi1kE2Byf/+tvyn5EuiJadSZJ26DwuBZ6dnHDtu5djMb4FQ4bxLMpaglQ+sCSLaS5Mr1q5xA/dO5ZGD0IylxmEg0U/fnC9QYEhuKcpgMDWxUp4Jxq6lDCJU5licrFiwwRufEecjXPw234NvudHcq8pEFvrCEhmUM1m7RYEcMW3suSjH3RWSD1SJlTlzok/GXgR2AZsYnfbAfS7VE6XkurQP1wy65wUrMOhTipO33RI5ey8CfoeKLhQ85wOo8mGi+UddfErzlQI6ijT35ASpRHgOZapvRIM0N7VT140A4j5q0ALlvhPVFF6HbbciYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uaAEfgxliMoESOn6Q1UOWoSSTqGvZ0bmlDoEo13/RA=;
 b=DP23OB9h4U8BFjjPaeI9kMYm8fQ/8GZdrD/l62wfLZWkYbMBLwtNt6zKoZLPQBAPSfatR3OZ8kOhZd9X4jdvNg1fz5YH0fgSd3maWtKg1OSGN2VWe+D6b7se/SSD15/cRgLlYMidVzrGUZxjvEl0fdNaXd88FI07UOAtg8t3UGLX87OWyjm43QnyToIdo+X4P9khaA1GaiF6XhMfAG7huzDC0ZDQrgmfvitk/oRbHGJkMHszX1QABvbX3x2NApOCIRU3cawxnv0UXpwSd2/++1bsqoDt3ztgu2XXAM3wW0VXeJ2DaRwXnuvK/tQbZ5HU4Hh/yVpfrqE+F75px+E8Gg==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4026.apcprd06.prod.outlook.com (2603:1096:4:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 08:12:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 08:12:28 +0000
From:   =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To:     Chao Yu <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC:     "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGYyZnM6IGludHJvZHVjZSBnY191cmdlbnRfbWlk?=
 =?utf-8?Q?=5Fremaining_sysfs_node?=
Thread-Topic: [PATCH] f2fs: introduce gc_urgent_mid_remaining sysfs node
Thread-Index: AQHY4sW8mgJa5fMka0W82H1XdV2JB64W7OaAgAABnsA=
Date:   Thu, 20 Oct 2022 08:12:28 +0000
Message-ID: <SEZPR06MB52693451F34B9A5CB60E2851E82A9@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20221018074621.16019-1-frank.li@vivo.com>
 <3ed1c3a5-e299-4915-a339-e2b6360635e5@kernel.org>
In-Reply-To: <3ed1c3a5-e299-4915-a339-e2b6360635e5@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|SI2PR06MB4026:EE_
x-ms-office365-filtering-correlation-id: 96b5bab3-832a-4096-8884-08dab272d48f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7mO7/LUO7a2WtjiMOnGS76VH+qvxlws/RFO7Q5gi6/ZGWhz1O/u/QNn8AMaReZJpQ61whbOe74+qYuc36C9T3JKvCoPtQWOf42IWHbxhGRovncP4JQQoyXYSGuNkzRWEqg7Bfg4O+5aHsWQJh/3oBJKFP7wbZQL0xZ7+YbmYHEhEJW8U4xsq1guwa8k4XYQNKBamqa+b+k7aTsKmC4dbmSsgy236gQiUSsJTOu4i/CEO15IVuPRKWKFNj8so/JH7YTzjwv7jm4k+Q+qADHasoNNLc52/YKoEgMI6HHaak502OWzeQTeGkhwkCu8D7GiYpWChVQBXnRzjYejgnso+PeAA51pYsHjiG9omM7TqfUrbfAIRy/NP4YbNfql13Y2Nh2Y/eS46kogRSgo8crZBVTE+Du1yW+n1Ox5HbtPWohtvt1y2u7oQI4G/OTV4afE1c2Z3JXRhZ6Rf6vPHDM5j27FpG/DDIlhmeUUKSg0K4Hsok+SR4XT0JvTnX4aWAt+X2Tnl5R1uJtuYYo5siVsYyVRW/flI3ri7Sed1IBb7JZ7lyucqspvlhW7JA9w6CLWLD9r/bUmc0jCxD9FpO5aapa1S8YmZ970UWn4sHrttZGVKDBO2YTm7kn/XdZKe1KHs0eLRLFbVzoe+36DMgOEh2b3O0MuDrriyekRnblSZ/Q+r5rSTtUg3UhSGpIFneWzmGBKwQU5KVn3QcjG23ebHtdqWEtjnqsyLZsFlReP5GDynFTue3z2+zvonf9U0vt7m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(85182001)(224303003)(86362001)(33656002)(66476007)(52536014)(41300700001)(66556008)(38100700002)(66446008)(66946007)(38070700005)(83380400001)(64756008)(6506007)(7696005)(186003)(122000001)(478600001)(5660300002)(2906002)(316002)(76116006)(4326008)(8936002)(9686003)(26005)(110136005)(55016003)(71200400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTdiSlZ4ZHRYbnUyeXE2N3FCRjRHTXRzMDNPUlNjL1U5T21RWmhNWnVGOW5l?=
 =?utf-8?B?RCswYTAxTEF1SHgxbnI1N2RkUDc0UnNmVkVKTUVjZ3JFcXd2c0JBc1cyWmhM?=
 =?utf-8?B?cERwcXphNlVieHRhTWhsQmpSYWlNWEpzRk9MMlpjR0FweXd2STkySi84aUs1?=
 =?utf-8?B?YjcyRHdJMk1jN01lU2w5b2FOdlZ2MnBrWS82KzNMZ0h5K0lGaGFLa29ZYm9i?=
 =?utf-8?B?Z0tGeXZpdC8xWEZoaTl0dUhDT2VFOExVRmZhdU1oVi80V1hySEZPQTdsSG5M?=
 =?utf-8?B?WDRnZnV0RzNmVjc4SnNRczFtU0ZYOHBYb245ZlBLYnNXSUpZaEJ4RjQyN0Ix?=
 =?utf-8?B?c0hueTg1VDFHOS95dnF1R0lYUVQvYXNjdEFvaEFQYTg2a0ZOT3o3eEdnRmJz?=
 =?utf-8?B?dUg2US9YMWdzcG56eDR6ejNRVU45L2tCNnlRMzlzcDVBbmtnU3ZoenR0L2Vr?=
 =?utf-8?B?WHQvYWdPbzI0Z2dMeEV1M1RidjVUR2pTcXhjUzBNVUVxa2J5VFZ6b2JMTVY1?=
 =?utf-8?B?aGo2VWVaR1VHUlJweG1lS0xUNmxXVHRIU0dwRHZMQSsxU1UvWW1TQm40eTRn?=
 =?utf-8?B?WjlmQzhJMWZPZGtzUitlb3FKYkR2WmFvelZkUkRqd1Bma1lPcGU0aWZjTjRV?=
 =?utf-8?B?QUt5MVhVQTRaaEdicjlWNlRpTkZvUGlXT0ZNMlFuYUtCSFl4SUxqV2hRdDRI?=
 =?utf-8?B?aklBMU9UWUtYWTl5T1NpYUwvQTVtRzJUM2VtUjRMRngzaUg0WDhUZjQ2QzI0?=
 =?utf-8?B?aWZPTEoyQjMybXc5R3JIamFzcHdwaXhEemdxZTF1ZndPcEJ2a1l3cFJDVUd1?=
 =?utf-8?B?d1V4enNUSmUralYzdm1ZcUc4MEMrQlVvby9HQlQvN3dJR2hIblJhM3g1bUx6?=
 =?utf-8?B?b3phenRzbTFsTkFiMWdIcWdzTmxsNytsYUNhUDY5MGJVQTdGdzFhTjJWV283?=
 =?utf-8?B?NWVYNU1oWUZlWTc4VElMNUkrdWRDR296NHhGWFZQbk1XaTV4RXowZGkzTWxa?=
 =?utf-8?B?WXZlQlNBaUtaY09pOE9qQlExMTZZSFRrRlRUczBEODQ5Y2F6aFZCSFJnWEhM?=
 =?utf-8?B?dFlXZGplUURnRWhFZ3FRNGN2Z0p4eS91YW9mUnVpbzlTRTRvUlB0L1F5OUM1?=
 =?utf-8?B?Z3pIakNMQUZ1KzROdzg2WVJnbzNJRVgwK1dmVlM3VjJjaytQYnUxWlhld3Iv?=
 =?utf-8?B?WmM1enFYZVRHc0RNZmx2R3Yyd3pRTVhpcnp2NTRYNTdER255cHNhamt5ejl0?=
 =?utf-8?B?bFROYWtkV2VWRFBZYjUxTFdkV1YwcEdaajVJbG9OM3NYZVR4ZE5RU3JlN0Vm?=
 =?utf-8?B?RWtyTVo5ejVtRWtCTW9oKzh3aENKVzJlS09STUd4YlhaQTFCam5JY3JWMmdZ?=
 =?utf-8?B?MmlWWGFyRUlVb1FBL3VqdTd6VHVmMW0xQktrWjZqODFXUDFVN0JKbm81N1U4?=
 =?utf-8?B?ZUkrTEVjR2xhcFVibUxiaE9JNlh6Q0tEd2F5Q3JQbndLZTBKaC9vZTBjMXFZ?=
 =?utf-8?B?YUpNWW9LbEs0Z0xzT2FqbjU4Y2k2U0wzQ2t6QkRVcUowZmhPUWpHWDZnek5R?=
 =?utf-8?B?M3Z0SWhzeWRQcGZkVVUwT2lVc2hLZ3lkckk4cTRYSU14c2Q1S05vV2x3N1JE?=
 =?utf-8?B?TGY3NndtdEJOL0F2NmpCZnM4dUl2Z0diMFJrWVNOUnNMcGs4YmxVME9aV3RB?=
 =?utf-8?B?VUJuNGwrYWRMaTV4NmR6MnFZMDRyQmhIaUljdkp3Q2dnNWdQTU1IUDhRWVFV?=
 =?utf-8?B?NVRIeWVESkdtL01nRXNZNENZSjcxR1psOTZzbzh1d0pJRllsdlh4bDdITVd6?=
 =?utf-8?B?d1RFVXYrU2VBajhXbEJueWZMd0laLzlvUzhNZXhla0RlNlAzNFhmYjdHaUM4?=
 =?utf-8?B?eFNpb0MzeWNyazZ5ZDhiTmpKTmFvQTU4U2pPSmVlTDN4NUxoR0xjYVVpVXds?=
 =?utf-8?B?dURmSzg5NDIxN2dBT1Awcmx3M0pSTTlVRVNqVThhSHBmRXRqTU9zUFNreEtL?=
 =?utf-8?B?TnFGVkhmR0dLaCtNVHEyT3J3YlFEYWZiUGt0Y0hzbGR1R01UZXZwaTN5R3g1?=
 =?utf-8?B?WkN6b1hGbnBZRDZtVC9HajBIRTAzVnp2MzVjbHE4YlBvYjhiK09KWnc3NnhT?=
 =?utf-8?Q?tGxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b5bab3-832a-4096-8884-08dab272d48f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 08:12:28.8382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfaUurXdNQ7XHLaWhXKI7zscB9MXM5OGzUUCsu7nrWENOtmN1wssllIELnMaQ6SHQUUD6H403OIL9X9WXUlvFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbywNCg0KPiBOb3Qgc3VyZSwgd2Ugd2lsbCBhZGQgZ2NfdXJnZW50X2xvd19yZW1haW5pbmcg
bGF0ZXIuLi4NCg0KPiBDYW4gd2Ugc2hhcmUgdGhlIHNhbWUgaW50ZXJmYWNlIGZvciBhbGwgZ2Nf
bW9kZT8gc2luY2UgZWFjaCBtb2RlIGlzIGV4Y2x1c2l2ZS4NCg0KPiBUaG91Z2h0cz8NCg0KQm90
aCBHQyB1cmdlbnQgbWlkIG1vZGUgYW5kIEdDIHVyZ2VudCBoaWdoIG1vZGUgcnVuIHVzaW5nIHRo
ZSB1cmdlbnRfc2xlZXBfdGltZSBpbnRlcnZhbC4gSWYgdGhlIHVzZXIgcHJvZ3JhbSBkb2VzIG5v
dCBzd2l0Y2ggYmFjayB0byBub3JtYWwgbW9kZSBpbiBhbiBhYm5vcm1hbCBzdGF0ZSwgaXQgd2ls
bCBjYXVzZSB0aGUgZ2MgdG8gcnVuIHJhcGlkbHkuDQoNClRoZXJlZm9yZSwgdGhlcmUgbmVlZHMg
dG8gYmUgYSBtZWNoYW5pc20gdG8gZW5zdXJlIHRoYXQgdGhlIEdDIHVyZ2VudCBtaWQgbW9kZSBh
bmQgR0MgdXJnZW50IGhpZ2ggbW9kZSBjYW4gYmUgc3dpdGNoZWQgYmFjayB0byB0aGUgbm9ybWFs
IG1vZGUuIFNpbmNlIHRoZXJlIGlzIGN1cnJlbnRseSBhIGdjX3VyZ2VudF9oaWdoX3JlbWFpbmlu
ZyBub2RlLCBJIGFkZGVkIHRoZSBnY191cmdlbnRfbWlkX3JlbWFpbmluZyBub2RlLg0KDQpJZiBn
Y191cmdlbnRfaGlnaF9yZW1haW5pbmcgY2FuIGFjdCBvbiB0aHJlZSBtb2RlcywgaXQgaXMgbm90
IGluIGxpbmUgd2l0aCB0aGUgbWVhbmluZyBvZiB0aGUgbmFtZS4gTm90IHN1cmUgaWYgdGhlIGV4
aXN0aW5nIHN5cyBub2RlIGNhbiBzdGlsbCBjaGFuZ2UgdGhlIG5hbWUsIGlmIGl0IGNhbiBiZSBj
aGFuZ2VkLCBvYnZpb3VzbHkgdXNpbmcgZ2NfdXJnZW50X3JlbWFpbmluZyBpcyBhIGJldHRlciB3
YXkuIENhbiBhbiBleGlzdGluZyBub2RlIHN0aWxsIGJlIHJlbmFtZWQ/DQoNCklmIHRoZSBuYW1l
IGNhbm5vdCBiZSBjaGFuZ2VkLCBpdCBpcyBuZWNlc3NhcnkgdG8gaW5jcmVhc2UgZ2NfdXJnZW50
X21pZF9yZW1haW5pbmcuIFBlcmhhcHMgb25lIG1vcmUgZ2NfdXJnZW50X2xvd19yZW1haW5pbmcg
Y291bGQgYmUgYWRkZWQ/DQoNCg0KDQo=
