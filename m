Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDB631126
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 22:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiKSVz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 16:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSVzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 16:55:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F3A13DCF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 13:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668894948; x=1700430948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5l4d7G0s80UYqYXXEkT8Vm+b//66azLbBQ6vw8jHyro=;
  b=h7Sn3MT25ivpZpji/d4qcgCy+65nwLRG5Fzm8+sCLvm3WSFPK+yQy6Bx
   Agmtggvgbb9VQsMm8qKjYpFs2soLhsgwsgg7epS7/zKg+NaHKCdNOfddq
   Lipu1GosAlbecdeorM0ekbXktNjvqXI9AE9p0qEMoSKi157o93o2WSs44
   LLn8iBXa9VL0JF8mAghB65/QwytqrQVHjUP6AAtjncrJjU9HgSqs3r1Wy
   DTGfJdMVqBFUbFFTG3KOf6mWHukWf97z2g6J7RmdiWMHeqlGkjdkcs4HR
   w0XTsDpDS4SVtaExOzWg+NF2iJvmXTPVoK1ATnmiyWVqZT1h0SAlx2t5O
   A==;
X-IronPort-AV: E=Sophos;i="5.96,178,1665471600"; 
   d="scan'208";a="187795000"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2022 14:55:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 19 Nov 2022 14:55:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sat, 19 Nov 2022 14:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPy6hrYAgoGvxcX3MDkOqfYTMWxiwO6oqjY9iE8eqC8MBKHyInZ9CZjTGSjLs643zdv5FWP1/KqD8HP00snaZ8tOleNpnrUWkvjo7iaLOTolW/iF2xyia1SDjrbWtqQAxyZd8OpeJ38LrqBGQRNXxTaC3zRf8+EwEYz3oS+JvaLGAJSeGGO8igVMIkOisw+0CIDuCiysjXV6P+4e3ppAx0elTcGy3NdDELylvTRd1JZ6nIxGZfgN1br7PLccxLrxMa1MFXbqKDj11y3KFwcyqEHjYTUk8qPFxa0gMEhtkYcYGaougf9dj9h3Mu2/t0EzAEEsQZzxD9fufr9zkbmf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l4d7G0s80UYqYXXEkT8Vm+b//66azLbBQ6vw8jHyro=;
 b=gKAjsIGRQnuqOzDqD1xOmYIRDIHyLdnKbQiQpEnEvCx6TIrMwWU0qoFBTpK2z9wI7pP45v1RWLAqnrXfG+dzTADVuBC5K+HND5YC4M9CKSMD/d2aE6EIjxkpRe44aJDY4q6UPnDwUcLnb25TlF1IJPR0MjIzCCOJEkxsuQJhVPqqkxziHwmYQPltpGbhJh6CFIX2kvqmwYTL5mBy97RxW3xyex5lNGid4z2/dGm8A3U79DvHS9E+a0gSZoHWU/YNjDtHb5oI6v6cLIWR+jmqtLH2TjpnPRfIlifVwO18vP23XVpIVLsm9iNp4dMUBrcF4FQc5k+r65eNZQqi+pBxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l4d7G0s80UYqYXXEkT8Vm+b//66azLbBQ6vw8jHyro=;
 b=qcM4h+Ux+XU+q7wlyyHhyl+ZUbbdb1HWSUehVd1m5I894XB7tqe4NBnaiOXMO0FM82U9kVS/en+utSPVTc+5azix6WLAyW9O7BvHVoh8D3RNYOtsA+kGNtV/GJ3wBimh1BtFzOgAH/3I50z5G88MaT9ZR6Q3hV3N6ZKMu3d2jiI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB5794.namprd11.prod.outlook.com (2603:10b6:510:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sat, 19 Nov
 2022 21:55:45 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6%6]) with mapi id 15.20.5834.011; Sat, 19 Nov 2022
 21:55:45 +0000
From:   <Conor.Dooley@microchip.com>
To:     <conor@kernel.org>, <jassisinghbrar@gmail.com>
CC:     <Daire.McNamara@microchip.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mailbox: mpfs: read the system controller's status
Thread-Topic: [PATCH v2 2/2] mailbox: mpfs: read the system controller's
 status
Thread-Index: AQHY+5wf/oPkfDp34UyWlqf7ipQTua5GzCAA
Date:   Sat, 19 Nov 2022 21:55:44 +0000
Message-ID: <8e9cfab2-4ab2-698f-36f7-b191c5ea8a0a@microchip.com>
References: <20221118222043.1214776-1-conor@kernel.org>
 <20221118222043.1214776-3-conor@kernel.org>
In-Reply-To: <20221118222043.1214776-3-conor@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH7PR11MB5794:EE_
x-ms-office365-filtering-correlation-id: 9eec2892-0820-4d95-6ca1-08daca78cf58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TMYlcviRfc5Tg5AYPaGpCi5NaKB/E3OLnJbvrvDD9V8EOOnmFnzCyQgQWqmX+d0ZODyqu3b7h78x+XidCXqHlqMt0lJaaGnoojf7wZGlAO4ASCT8xVwVy1V6GUlIaPfLiAmwZEr/VXd9OaZNCP5Acl38D9iXGhK4+JBpoDLXpRATGntfCo6Spey+fo43U27+8w4kJf/LeXruan8AS3NxXtilp0xIjms0qqCeFTpnYSxSJO+i3J+puDHWxN3CLBXYYUJbzPi827bQWwKcvV/NSCdai/FXRode3i6xbpO8g/r9jcOwALc4wOoysow7TS+O5L5MJcIaOv/ZByhhP8odcGrVzIpQagC3+Fx4GUBSNlf9Wx6MG86lZoRKV/4to6/FfCLj0PZWLinXRuOmrraNrP8jsGDsdGUxs2ipdCZeO9SMYI3iSnTo5HXDnyQUyolH1nv6L1p4jdtheooespMpf7egXcjT/vcWA4akAhkDwgLiTFkvfexexJ0IWfNCK8XFTAH/Da7Ao/Lqp7OWUV/2GZROBYyBKVHsT6jrcQZY13v72ga1tPy5W0ojtA4q1yllCUBVRJ/FO/GsTwjCBwDCpevMgriITU8gQ9Gggip82VEP7wOreKlKquO0uHOqx1YTbACW5Epyl9QQK5gBxnXJHnSeXdWTTcPJvmQDdjNgE6oGCml/PCRm1wXFS3UN+nI27f9pElwLdpvaqpVzxWARPdQYyB7wn/hCq9vALBgwIrZQHh1IMRpU6hBp2QwhhmPruQuwRGv6deAv+xy7WO8XgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(39850400004)(366004)(346002)(451199015)(71200400001)(6486002)(6506007)(53546011)(66556008)(478600001)(66946007)(54906003)(316002)(76116006)(110136005)(91956017)(36756003)(31686004)(86362001)(31696002)(2616005)(186003)(38100700002)(122000001)(83380400001)(6512007)(26005)(5660300002)(8936002)(66476007)(66446008)(38070700005)(4326008)(41300700001)(8676002)(64756008)(2906002)(15650500001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFlPUVJncUttVEFWVHFhTTJ2c0luaDN0K1RqcVZGUjB2ZWFrd1lYOFJya1Ew?=
 =?utf-8?B?RjdZbkMxcUhBMmFhcjVMeG9zUCtkR1labzZILzhmVjVyZTY3MWtlcnhyOUEx?=
 =?utf-8?B?QVd6WWNSWHJmVDBkQkU0Q3MydWZJSXoydDNOem8xeXVTTVhPNG53eGx2L2Za?=
 =?utf-8?B?WC9hZGdxd0xaR0FGc0JHSjFVQVVRNkRzeldOWGRoZmduNWVVT3V2RFhKNVk2?=
 =?utf-8?B?Uk1Cd3U1d1kzYlBsTmJxZStWR3VDQkhvbmE1cnRUUVBVSUVTeS9KbEo0d1lk?=
 =?utf-8?B?N3FmY3ZldExQd1A5VHNJcEtGTXIrVHF4NUhZUnlUNkNqR0NSaUNYanJETEZL?=
 =?utf-8?B?enBLSm84V1VZc29OZ3RUUXVyWlFDQlh1VHJjWXppUmZyY0d6VnYrZ2hvdWdr?=
 =?utf-8?B?cE5KZEFpYzlSUmpLYmZ4UmNNR3F0RkJqY2NTaGNvR2hsSzRmQWZRbTRVdXNk?=
 =?utf-8?B?M0s3VktVbDNDc1B6YXpGVmswa0FNZWc5bU90cUwrR0xUQlVKUnQ1SjhIVloz?=
 =?utf-8?B?RWl3TFhHSG41Z2F5TUZCYVBsbU0zcVQwSXY5cWsvblM4cXVSdGp2YytPVnZZ?=
 =?utf-8?B?ekF1NmwzSDRnMzgzOTdqSHpYYmt4VTJoenRhb1FlOTZpWFBGM1J3ZTlYL2M1?=
 =?utf-8?B?dTQzU3JqbC9zZTNNQ3A0RG51VzdodmgybnlhYnh3KzNLcWZsZ2N4N0NCV2p3?=
 =?utf-8?B?SzN1cUpQZytyY3JsNXdwZTMzbmRXVUlweEFPS2tFakIxK3RsVi9XUkpjbUhh?=
 =?utf-8?B?ZWdTeVl6YVNIVEk0TE9SdE51SDBIenRGaGJNZlpPem1YSytjaGc0eWlwdS9C?=
 =?utf-8?B?d0xaN2t1ZW5FN09sYUp6UVVoa0k3U3cxazRyR2d3czljcTVDZnNZUGh2YURX?=
 =?utf-8?B?YlZ2dDNrTS8rY2dyeFZWTDBrZ1BmeDhNUU0xZ2EyWVFuNGNPUGdTL1pOb3Rw?=
 =?utf-8?B?dGJ6TGxPMEdicy84Q3ZDV1A0all2WncxSEttL0dNMWorUjBJYmYxanhGeS94?=
 =?utf-8?B?QWdrRWgyaTNLNVRrTzhnYjZTVUZnMUZWYWlEVnkyRlprM1JUalk3eTBRaU5v?=
 =?utf-8?B?SXhTbm10MVVXbGtRZHh5WTliRURFQmNmUHRVRkZTNzJpYThmSVgxeUlxbEpw?=
 =?utf-8?B?RFZrL0lwWXo5U2RodXNxVGc1a0JwM2N2eXpHRnJweGdkc2JYbkRnMXZXTXlu?=
 =?utf-8?B?d0F0WUJnTjhJallnZUNyZU1WL3NyOThWVldZMWVJeTNtNmRaZ2hyNzZQT0hz?=
 =?utf-8?B?NzZ2UXRUMlhwU0JVTzc3YURFd3ZkZ3JnYnhVYVBMbFhiUHBYWVE0N2V4Wmdk?=
 =?utf-8?B?ZUVDOVlGTXB5ZTY1UWhlZEx4VlhNRTlPM1ZhV2ZzdTg1RExTZ3R2akVhakds?=
 =?utf-8?B?dE9Yc0FtQnB1TEcxcG94QytYMzdidTh3YUZBYkVVVXB2UFN3Tk9Yb0VoME1U?=
 =?utf-8?B?VTBVcURTYXhlNjk5YjllOHdWWDhvMHFQZklkTERqSGF3Q1NMckZ0WHhDVkFa?=
 =?utf-8?B?QXk2dFhHVmJ5aEp1WWt1NWFKLysxcFc2Mk9IWGtXVmNNU1U1UUNZZHVBQkdS?=
 =?utf-8?B?eVdaSE9mZk16eTdGYjg2SkdlNXNFOU91WnVpekc5eVpjRG1kTCtTZ1FjY0V4?=
 =?utf-8?B?ZnhIcG5FUm5YYzI2QVFrYnpRRS9oZFpLSjZiam5KT0xIT1ZlNitEQ2hjWTkw?=
 =?utf-8?B?K1UwOExrT2k3N2wrRE91ZjVWWWkvMW1BYVBGV0tYeUVjVlRnMUVxU3FYSUNB?=
 =?utf-8?B?K1lnbTJ4UmY4QUp6VldLVkhoUjF5TC92VlZrOEtWL0JlbmxCdzVGeGdkQ0E3?=
 =?utf-8?B?bi9OUUFoRWd6QlBjVGZiY1diMllhTUs4YlFnbDJxdG5hWlV4eVlDMFVKWG0x?=
 =?utf-8?B?N3prWUxwVkpWQ254M1hlRHByTzRUQXZQSmhZMnBHS1JpYTNzbk8zNXhSVjhL?=
 =?utf-8?B?RzJSN3IxMXlrMCtNYjNsSVpTU2ltVncxNlh3SmhxNisvRFdyaVVqMW4zdkdk?=
 =?utf-8?B?UGVrK0EwRTVrbTNIWWdGK0cvY1hMKzY0dG9McWE2NnNmNms0Ty8rQklUTFJG?=
 =?utf-8?B?c2NlblduTHdJbmdqSWR4dGNvc2lNZmZ2dXE5UjNGZm5QdFUyWVErTE16djVv?=
 =?utf-8?Q?cTGfU5jI0OVyUQ3ZaPA6o4Hu2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C06EC78E858CB448DE29438CF202A26@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eec2892-0820-4d95-6ca1-08daca78cf58
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 21:55:44.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctPaF8TdfHJcktHXu37sNz+d/MsitbivZF60YTViMH5pvj3nIIskDxjU4RzrFGpCqV7HSPWEMTw0Dzt2+wUzE+tRYnt1ABpGh0BPyiaiE9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5794
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMTEvMjAyMiAyMjoyMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9v
bGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBTb21lIHNlcnZpY2VzIGV4cGxpY2l0bHkgcmV0dXJu
IGFuIGVycm9yIGNvZGUgaW4gdGhlaXIgcmVzcG9uc2UsIGJ1dA0KPiBvdGhlcnMgcmVseSBvbiB0
aGUgc3lzdGVtIGNvbnRyb2xsZXIgdG8gc2V0IGEgc3RhdHVzIGluIGl0cyBzdGF0dXMNCj4gcmVn
aXN0ZXIuIFRoZSBtZWFuaW5nIG9mIHRoZSBiaXRzIHZhcmllcyBiYXNlZCBvbiB3aGF0IHNlcnZp
Y2UgaXMNCj4gcmVxdWVzdGVkLCBzbyBwYXNzIGl0IGJhY2sgdXAgdG8gdGhlIGRyaXZlciB0aGF0
IHJlcXVlc3RlZCB0aGUgc2VydmljZQ0KPiBpbiB0aGUgZmlyc3QgcGxhY2UuIFRoZSBmaWVsZCBp
biB0aGUgbWVzc2FnZSBzdHJ1Y3QgYWxyZWFkeSBleGlzdGVkLCBidXQNCj4gd2FzIHVudXNlZCB1
bnRpbCBub3cuDQo+IA0KPiBJZiB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgYnVzeSwgaW4gd2hp
Y2ggY2FzZSB3ZSBzaG91bGQgbmV2ZXIgYWN0dWFsbHkNCj4gYmUgaW4gdGhlIGludGVycnVwdCBo
YW5kbGVyLCBvciBpZiB0aGUgc2VydmljZSBmYWlscyB0aGUgbWFpbGJveCBpdHNlbGYNCj4gc2hv
dWxkIG5vdCBiZSByZWFkLiBDYWxsZXJzIHNob3VsZCBjaGVjayB0aGUgc3RhdHVzIGJlZm9yZSBv
cGVyYXRpbmcgb24NCj4gdGhlIHJlc3BvbnNlLg0KPiANCj4gRml4ZXM6IDgzZDdiMTU2MDgxMCAo
Im1ib3g6IGFkZCBwb2xhcmZpcmUgc29jIHN5c3RlbSBjb250cm9sbGVyIG1haWxib3giKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9tYWlsYm94LW1wZnMuYyB8IDMxICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tYWls
Ym94LW1wZnMuYyBiL2RyaXZlcnMvbWFpbGJveC9tYWlsYm94LW1wZnMuYw0KPiBpbmRleCBjZmFj
YjNmMzIwYTYuLjZiOTlhYmFjMGIxMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tYWlsYm94L21h
aWxib3gtbXBmcy5jDQo+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tYWlsYm94LW1wZnMuYw0KPiBA
QCAtMiw3ICsyLDcgQEANCj4gIC8qDQo+ICAgKiBNaWNyb2NoaXAgUG9sYXJGaXJlIFNvQyAoTVBG
Uykgc3lzdGVtIGNvbnRyb2xsZXIvbWFpbGJveCBjb250cm9sbGVyIGRyaXZlcg0KPiAgICoNCj4g
LSAqIENvcHlyaWdodCAoYykgMjAyMCBNaWNyb2NoaXAgQ29ycG9yYXRpb24uIEFsbCByaWdodHMg
cmVzZXJ2ZWQuDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjAtMjAyMiBNaWNyb2NoaXAgQ29ycG9y
YXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+ICAgKg0KPiAgICogQXV0aG9yOiBDb25vciBE
b29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiAgICoNCj4gQEAgLTIzLDYgKzIz
LDggQEANCj4gICNkZWZpbmUgTUFJTEJPWF9SRUdfT0ZGU0VUICAgICAgICAgICAgIDB4ODAwdQ0K
PiAgI2RlZmluZSBNU1NfU1lTX01BSUxCT1hfREFUQV9PRkZTRVQgICAgMHUNCj4gICNkZWZpbmUg
U0NCX01BU0tfV0lEVEggICAgICAgICAgICAgICAgIDE2dQ0KPiArI2RlZmluZSBTQ0JfU1RBVFVT
X1NISUZUICAgICAgICAgICAgICAgMTZ1DQo+ICsjZGVmaW5lIFNDQl9TVEFUVVNfTUFTSyAgICAg
ICAgICAgICAgICAgICAgICAgIEdFTk1BU0soMzEsIFNDQl9TVEFUVVNfU0hJRlQpDQoNCipzaWdo
KiB0aGVzZSBtYWNyb3MgYXJlbid0IG5lZWRlZCAmIGdlbmVyYXRlIHNvbWUgLVdtYWNyby1yZWRl
ZmluZWQgaXNzdWVzLg0KSSdsbCBkbyBhIHYzIGluIGEgZmV3IGRheXMuDQoNCg==
