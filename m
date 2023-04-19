Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994086E833D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjDSVPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjDSVPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:15:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ADF4C1A;
        Wed, 19 Apr 2023 14:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViqZ2TANUWzFRWaQBJu4SWArgDVA+p6zzhtAoXLd7SJ0e7JLNBrQWe7sP4TfZGXVibhxoDcsOJJoOsJqYZ1hnOaMnNkWqA4J5Xg0bG0j3BS2SciYSmvZptcSlbBuRepKBBnULSioChOlqmAr1YGzP7FiQbI0bC7RjEil8BOU+aXWKTb6hpTWit1AQRXCgyJZXw/pRbExJ1U3j2QL/Kp8epX1wSEgEa7fg9NSDxTGEvUy1rH8jKr5WWTrYv0iUflrjfEQcTYlLx+KuiwYOTdnjD+VsCUR15tZYqwWaLF7DZCyHx+DioKIcqD2LMSjqoRcM4kG7Do31t5QUDaYPdwDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB78j/Qo5Aw2fdSkPHC3EnjtStjMYMHvyqvD0cDsChE=;
 b=lb9QBhQf3ZVZ5cIrdFoT79xNBa+g+yKDF30oxM7OJANc15H4uVegATnaTKodl8Ws33LEl4MWO+bJZBYPC9XEJIAhWfKlOgl0XeoN1JTpvq8A0eB8W8Cw6ahilmuvNG9b6alWvw7O3tzzNGWEk/qARkdcKDM8YUY7FS0HY4EefFtfXtLgflMKLNIV+WrBJVHcx7BOBonHHKXXxf8IW5XhfH6nvxKptl/NO+4O62jy8Pzs8d3WKhmrph9cIDMyE7cJFYrLD9+XJu/wOOECs8S3qXWLzbGky0l5zW2nqJmj21143TlGili2dNRg+A2tmYlPTVe6/w954NUYD8gN0xMz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB78j/Qo5Aw2fdSkPHC3EnjtStjMYMHvyqvD0cDsChE=;
 b=oxcYMrNtth9rWeOrmDQ1RGUW6GcUYJE93HnVbLjqQYwfUOcD1tfNX5rqpGwOsvB0F2gLqF8wVpFXXhJkbZ82Z59/segu4ysRxCK+cv83cfZ2sT9e3GTXZEZWG2uIR+8oGQBWSxpZCqZ2Kb5MTJ6HD7j8mYSRGtV6EdMFZJHK/1jcs4VWEts3AX6jjxUvUy5HabiJfsNRL4HkFTuOX9MxUMDqv4CfAb9BJ5beFcYregzD0+69lmdrQlaZN0ZojvhU8pU6GROMEjP75mfhHWB4i3OtprJ/oW5StAbyEHp7LqSSicB4nXBQeR/7TmwPS/QdX5+WllJpetM4zZAnOP8Gyg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 21:15:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%5]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 21:15:07 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Thread-Topic: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Thread-Index: AQHZcpuo2+Eqx2a4MU+xtBGjjFI9R68yYeoAgADA5QA=
Date:   Wed, 19 Apr 2023 21:15:07 +0000
Message-ID: <ae4faa38-9d84-c708-8228-223ed7fc68db@nvidia.com>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
In-Reply-To: <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ2PR12MB8135:EE_
x-ms-office365-filtering-correlation-id: fbb66159-fc02-4d5e-1610-08db411b26b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +xsDYu+b/XnZ0prMzJ/WiZmoVXZPh55l3KCHgpxORGJudWTzZ5/gwiIAuWr820ruMxUrfOwzqIPeq9IpCwc2+j2ph02tTSVGVhhsYdPaKS87Zd3yJsdwSAXqAOLAPaNB8/mcofCLqtTbgSiJ6O82egMLA61vWL5G6ojsh+ZnY4qFCS7CUKcOsfmAtbC8MDykUrMV35oe6WQtcPTq4Wfxal2Iei+rZg4nmN8DMxEqstm3Dv+X8fL+2oJYC42ORxfM15frO7Dzkve0wB7H5DgK9UFCwIWmb5Wiw6Hkap/9PMmQxShONerbkSxXBfPQITp0RIlJ/QuyMl5+C2KiCCDhcVXo+CmGJSCv+w44f6pX+rkoseL3BerBMcNbvAky3D3NsfcF3gXz1b4dzd0rrTZQT+eqhUUNx/ft1UjGdoJQiEJv1ApB6+dVwF+3R/RtwqhzO3I75VkyCbtZ08Xi2D4StKlGJ+qUzNIgkBP1tSP/NzMHmUybeE7ASPjpK3CRftZrK0aryP2TpEuT46mcP4IIEr/nSMKj8rxWzAwiK0ieFI/lclKZ03wBTIy9897XA9LP5wFUSvhTpp8m0mDi8YLRQZpjoWcmBHI7Z/ZJKINIAnh6poTWln1u9jJYKPYgZuTyoTwLn2CVjwrxs6TiOeilET7kPWPmfGv9iRshmak5zFe50e9LTuMqUh/TKLhOn3H9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(36756003)(53546011)(76116006)(4326008)(54906003)(316002)(110136005)(66946007)(66556008)(66476007)(91956017)(66446008)(64756008)(6486002)(41300700001)(478600001)(71200400001)(5660300002)(8676002)(8936002)(4744005)(2906002)(38070700005)(86362001)(31696002)(122000001)(38100700002)(2616005)(6506007)(83380400001)(186003)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFc4RGdORERTUjRwUlF1OHpmb2NLRFdFZzVwQjVibXpRSG4wZ1hPSFhiajhM?=
 =?utf-8?B?S3ZGdGhmdnVVcXkvWlgvME1nNnE0Q3NMRnRsNE54OHZFZndadW1CaTExSlBC?=
 =?utf-8?B?S3BPWmFCeC84QW1ySW9xb25FbStRalRZUEFRZWtTRTA4cDBTalBGUHVqUU1P?=
 =?utf-8?B?NmVvMGVnZ0FsQ2JCcXMyQTNzMmlHQTg4T0lIQmlmcUxDa2hUVkZXcmFNVitG?=
 =?utf-8?B?cE9Sa1dxeW44S1JsaFhRek1DeFFPdTJRWWlDZ09Ddy9zTVFvQXFoa2lZeWkr?=
 =?utf-8?B?NGpzK2UzR2drNUlMa2lmZm5GNlJUUHhQdFpCWmlydEZtS0hPTnVCMlMwU3FP?=
 =?utf-8?B?MHprUlhXNEZTcG1LMHRTbkN4a3dWRUJZM0R1OWE0V2oyMlVPUW1qQWthZU1M?=
 =?utf-8?B?d2YyRno1U1NNUWU3OWx1d00zQzlrNWRhQUVvbElYTmtXUHFRUkZIN2c3UGVW?=
 =?utf-8?B?TlQ0TVM4ajdhRlJIYStGVTZNUStuc0MvNXpZQzVwN0hmUmRsUUxWTDJURzQ1?=
 =?utf-8?B?M3d1UHZlZDZyL2dYRTRWOFlvQzVVNEVIbHloSzJzVDNiYVVYRDcwV21LRGI0?=
 =?utf-8?B?ODUwSDlzY0hGTEp3akR6QnVKTVNrMGdxV2dtWkhMbFl5V0I0bnVkWjF3Q1R2?=
 =?utf-8?B?UEFseTBsRHcyVE9VVnVrcE5iNDkvK0xBQ28xdm9Rb2VTSXRaNWQwMWE1L1lX?=
 =?utf-8?B?dk5udlkvbXhQc25scEJKZVhsQUhZUFArL1dHcW1XRWtrcXZ2eVBVSXFiOWVq?=
 =?utf-8?B?OG5aeUZJUHJobThVNzZLczNaRml2NEZvNWNHNndCblhDVEgzRGNIYTcrSzJK?=
 =?utf-8?B?TGZ2cGFGRkorN01JNGtzRU9PSUZ5cUZ2UkIrbEVDdU54ZUlhdVRTU244RC9B?=
 =?utf-8?B?SEtScnFSbzBRUGRsTUJ1Um5qc0U2MVNxdlF3UGdSQU8yNlpSZHpEQW9YNVJ0?=
 =?utf-8?B?SGdPQy9tTDBGV3ZiWWZMY056ZXVQZnRUcW16M21pelkyMVRSSlRRRERjWGZZ?=
 =?utf-8?B?MTNGREQwQWplYVRrWGRWUnBWWEE5a3RheWp5UHRJQmVCUVhVc0liS0pJclp5?=
 =?utf-8?B?ZGJ2U2FSMW03bDNqbHUyNWd4VlV3L1d1Wk8rZGVIY2hEZ1NFRU44MGJueHVl?=
 =?utf-8?B?cXQzRGZUaGJOWm9oWHl4S1FlS3M4ZHptck01RG9nemNsT1RUMEFkZnJta2Qz?=
 =?utf-8?B?WnhZMFBVNU85M3dBdm5FRUZCWkI2TEdyRTdjUUtmQVdJb0ZxbE12OUtLM3l0?=
 =?utf-8?B?ejNjMWwyMHRuY1BWWmhBZVZoUTI2S3RYU2p0RHFDaXJzb0ZWVXZQb3QzNktB?=
 =?utf-8?B?UGVHTGo3bnF0T1BIQWkwVDlsTzRoOVYzSVR2TmlOa0U5K1d5Y3RMWVEycjY4?=
 =?utf-8?B?QWRxTXU3eURvYm1rME0rQWovaU5CelZhSUR2d2drbmZaZWoyVktrc3huQkdl?=
 =?utf-8?B?WVVrdVViU3U2MFFsOGVZWG5NbHhtZXJob2JwbEFrV0J0dUZFUGk0cHpHZTdm?=
 =?utf-8?B?enFaVklsS2laUUd5RytkUTErdWxwWmNtSHRWTk84dXlUTG15Y3hyNDd2Yzd2?=
 =?utf-8?B?dGgyMm9XUDBQRm11dGMwMkJ2bXUyaGhiT3BmMEdSSHFJbW5TYVR4K1RUcTkz?=
 =?utf-8?B?MEVDU3ZsdzZya3VYZEdIZGM3d2NTZVI1SFpSbkRRUWpVQXJaUE12WnVNQncy?=
 =?utf-8?B?aStVb0JzZU54eDRuZXR4Q200T0VEU1c5SzFOWGNSbktrbm8ra05Ta0xwNTNQ?=
 =?utf-8?B?a1RVS3lOak5nU004amdlWjBJMVVZbEExNytXNS9BUWl3Y3BMWWZyNFl5RnhR?=
 =?utf-8?B?U1B1UStwKzg4WEtnWjgvT01XZmNTdVJCV2pvcXZhWjdvVlpRbGhjV3UzMVZk?=
 =?utf-8?B?cTlxcGE5L3R4b1VTYWJPNHFIZGhlbzJIOGFwVDBpV1ZSTlFjZEphekRqb0tY?=
 =?utf-8?B?bFByajUybmgyWmQ4SGh3SEdCWithTmpTMjhJQnUvR1lBL2dxdXFrZXpqUi9F?=
 =?utf-8?B?RmlUbkxZbGd1V2JsQktPOGtnMStDMGdQck9KT0REd3o4VVRwQXU4K0ZTYkJP?=
 =?utf-8?B?c21TQ0dNMUJlUFV6NHVIKzhid21lRjhMUlB4YkpDNSsvS0hFU01pRWpFVEJm?=
 =?utf-8?B?VTBzOGZTREQ4TmFIM3krbkw0SDg4YXcvV2szeVpCUjhXNGloaTVmaFRxU21w?=
 =?utf-8?Q?iEyEU2N7gvKvOcPp3SFcFXGaMgI+t4u0yp8vB7fp0JUv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10141E57730E1E438A35D8E2E31E43AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb66159-fc02-4d5e-1610-08db411b26b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 21:15:07.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTC6em8/N+Wuk31GsjmxMgCU/pT8wFN7iRrpfybnhxltm2tJ/KmOCIecEKvkq4sBHRqOWFwnaLmoVWFTVP2iVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
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

T24gNC8xOS8yMyAwMjo0NCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4NCj4+IEJlZm9yZSB3ZSB1
bmxvYWQgdGhlIG1vZHVsZSB3ZSBzaG91bGQgY2xlYW51cCB0aGUgZmMgcmVzb3VyY2VzIGZpcnN0
LA0KPj4gYmFzaWNhbGx5IHJlb3JkZXIgdGhlIHNodXRkb3duIHNlcXVlbmNlIHRvIGJlIGluIHJl
dmVyc2Ugb3JkZXIgb2YgdGhlDQo+PiBzZXR1cCBwYXRoLg0KPg0KPiBJZiB0aGlzIHRyaWdnZXJz
IGEgYnVnLCB0aGVuIEkgdGhpbmsgaXQgaXMgYSBnb29kIGlkZWEgdG8gaGF2ZSBhDQo+IGRlZGlj
YXRlZCB0ZXN0IHRoYXQgcmVwcm9kdWNlcyBpdCBpZiB3ZSBhcmUgY2hhbmdpbmcgdGhlIGRlZmF1
bHQNCj4gYmVoYXZpb3IuDQo+DQoNCisxDQoNCi1jaw0KDQoNCg==
