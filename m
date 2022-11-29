Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12ED63B90C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiK2ERt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 23:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbiK2ERK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:17:10 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E434F1AF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 20:17:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgNJ6IQd8YaQhdtS7VqlhZCGXoYdWy3Pm6QrmhaNNwNcjcqFKdr2FZNYj3KFSNRcoHRWXgw0lT9bmkMjIfpDmljP26C6b7kbQ4ilhCfkqXjqpj/LlGn39J2p5OSqy/gDpn8bjplGUrMkH1H0wrDj2inOSII/XriA6LXH4w+zkZSS5HXPkY5aMX0ibOSvGbDBkC2MxCS+xpfr/JVYQ1AQm2LGZJaw7GZ+yJwafbGtbJJCLkEkjTxcECF8SXYtKS7XaEJ7GVlZtLhCy9QjKUe0rWelWyxo6D+cdaJnDOEknXQ820mkNYr99Cxg4heOx1GjYvFUTSyAjFhT8B43Fco9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v++0PCdZqcy5b4l9rfV28RufvuDYD+5gznjrdas/lSQ=;
 b=Tk9vUhpMAmedOrGU1xW/jELksSWgqt6TmyQBsuDdfIKBYLpNyLXscpKuV8bJ0NOb9bO7TnGYflozZpb3pxJlYViJkF/xW3n2GF1l1xjcnAqW+y1KQf49VncOsiRmWKxrpHKZU954r6BbnKmozxAbsM6/601pSecfg3uDDKAey2JC9PzaEx3ClDh03rrCuCRSHkaCC1ZRVhzoEOw+XK8a69ihtxWOZ6owNEYbD+Gzb8g2CbCKrkflgpfC9u0zPhQVMvaYT+1sal++5h6w/GsOGZJ/ECsw7ZlWKcUqrgqZxs3uLB7uWZz1WlxXZ8EIobNVxVQH0P7cEnEWglG9MRkycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v++0PCdZqcy5b4l9rfV28RufvuDYD+5gznjrdas/lSQ=;
 b=S4zgwFp17Fp6/jsMovUO8tcX/YnDO6Do2bERRw2BmgfGWcC1SWAP6E+2Cgge3+51hhMLfxVHpEQ6FbHU7vagZ7/5mC/+j8JyLPZSc0bvznbTo279R7RJdd01sLQGo4NXKHJLVAZyL3PuxpM9tdu5mrmBb8x7LdlOjBpUG2GGnCf7tFEyNCaN6gOE/oiHSuq4InK0CyRU1gL6Qe/XYdS+eO0E+j/nAoqgV7kjWWQEVYXvlVS1DyxTPRaKOP5c/w+H0GGnNMC2oAF9fdDHD7lhS41v95OO+9c+mD4h0BRQqLX1LQ/KYLe3RcAdLz9IrQAJnNKxndAI68hP0rSiU5Zh/w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 04:16:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5834.015; Tue, 29 Nov 2022
 04:16:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Lei Rao <lei.rao@intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: clear the prp2 field of the nvme command.
Thread-Topic: [PATCH] nvme: clear the prp2 field of the nvme command.
Thread-Index: AQHZA5S0WA/ZUhtnIUyK4EL6QPTkBa5VS6+A
Date:   Tue, 29 Nov 2022 04:16:59 +0000
Message-ID: <15de4902-03e7-0d2c-4b4c-45d713d0f1fd@nvidia.com>
References: <20221129014711.91305-1-lei.rao@intel.com>
In-Reply-To: <20221129014711.91305-1-lei.rao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA0PR12MB7507:EE_
x-ms-office365-filtering-correlation-id: 790c9d35-654e-493a-5c0d-08dad1c08f70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZlYEE8Q/PjEYJ09scW4l0+Cs0hueE4t0/WbgSGPHlPkJVEWTgTWumQLVX3TDF44eQfN3qX15xb+eWMk2NwhCwfdn+FaLtNF1ilVIhk3UIf/ju1EIDwngaKHJlrZpu+Ud9WWKz9UpAZfKBNmTO/R76rvvh6EF1/T64QaALwZLyAIlju4qb4bsMC1i/HWmcxj3ee4q6cZpCje1yBWulUT7bUbsffHeO+1pXywZAX0SelaTjEWoA8SZoGmG0aZNgKuxu2KhGC7yjV2biOJBkWaubEiH+OBx991GWtm4pvfiGlQ1IASS9Wa8ssFiCzdKoNK2hsARGNeHzToVfu4mxALXbltA91fQP7AKrPH72Y3/bWbdVZYvCWTM5iM7P7x+iJVI9t5aaCA7iFbXS2DpnmuwzCAVdmmlK9RHi3MaBpfOwtLC1NqPheIzQrriVFwHzjiXYCyFRV82slC6KIv96zAleW4jONBlyotDIZU3J57ck6fItH84jjkw4MHstIfs7adxb8La/hu0DV0Qf9d3OTVn2bXXt1evsfSRqWYVGHvUk8radOLvtubq8gO+RMC4XB/P0Tku+dfShlw0/FI+nbxdg3KJ9sCCnRsS9TReFM7zer0/SGxmcLDTccgIaumgq6O3F+tDPeFsvtWTCvHxIFlf9OFiasyCaNENnRnVNvN3gnbx5piTUDOuIqXwOTWDYeaPl/N/FkrbRTkTHsFHuM3RxIQbCwqMf978vZotQqRqzj5zhnZ7JH9SjobSpjjp5GW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(31686004)(86362001)(31696002)(478600001)(6486002)(71200400001)(38070700005)(2906002)(36756003)(122000001)(186003)(6512007)(38100700002)(2616005)(66946007)(66446008)(91956017)(6506007)(53546011)(41300700001)(316002)(76116006)(4744005)(66556008)(64756008)(110136005)(8676002)(8936002)(5660300002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UStnMGZrV0p5UTZ3eEd0bUNLL281ZUEvSHMvV1RFOFJDUDFIa1NnZW1YZkpi?=
 =?utf-8?B?TWt0cElxMW9haHUxK3E5NVlId1laYUxQc29wY0VUTHh2NFkzVHFzVWZwUHFm?=
 =?utf-8?B?U1lJYVVIbEprdW9haEJLZ2t0aENaeWVNSUkrMDIyUElnbUI4eEJiSk1WL01u?=
 =?utf-8?B?ZWEyOEM4eWxJOFk3clpiVDY4cFp4Vk01Y1Jrc04vRkM4TzJGOFZ0ZkZ4dTAw?=
 =?utf-8?B?endvbS9LcEtqcnBJSTlDOXAxUEdobUxiTjlmek1xSWZ3TGZPaFdvMTRQVTdT?=
 =?utf-8?B?eGNvZlVEVHRDeGZnZ1BuZXFnQVAvajNaN1dKN29yWWd5RjJ5Vk1sK2liOUlp?=
 =?utf-8?B?aGFyVk5WZU9XQ2dkNzJZeXZNQ0JBbXpNTnFvYUZKa1grUXRKMTNDNVhVVXU5?=
 =?utf-8?B?aERLVTQ1OUhsRHhqMmpMay9DSzlmdjdvSkNNdVpieHVuaTA0TUFFUFY2Vjk0?=
 =?utf-8?B?aXYwVVBoQ3dJczArTzRHb0dHWlJRc0FXbU55cGpuU0ZTV3lDcGNlbGx5VSta?=
 =?utf-8?B?RkhKMkpmM1UwU085a3hseUFLVkFQeHZzWVdOM2djSEcwZW5ZRU1VTlVPTG5h?=
 =?utf-8?B?S1ZUT2M1eVcrejZMMDRDRHFGdGdsd0lkdmg1cU9JaWZrdDZzbTBocXFXMEFh?=
 =?utf-8?B?OEJpMnFmNmp1RmJCNkhYd0hOZU9Cb0xiQWVRRmVrdXI3Q1djdlkrL2pFNzFW?=
 =?utf-8?B?SVlRcURWT285b0FraUdhamlDYm0xVGk5ZGlGVkprcFlIQTdzeEh0TGhVbUs5?=
 =?utf-8?B?MFcxTmxjckFvU0l2L3lCZ3kwVFA4dGl2eDBYeTQ2eEV3RDFndHlRakRYRTN3?=
 =?utf-8?B?Ky82Tlh2VnhEUWRzUjNlT2RoL3ZJTWZQdjNKZzk2S0hEWnBLQ2lkZjlQREVD?=
 =?utf-8?B?ZzM1WCtmMWxoa2N6RTZRNk91WnpiTm5EUjg1TTJnanQxVmVDcTNrdkwwODU1?=
 =?utf-8?B?UW42aGhWT0VYTnRXYzlzNFhJSy80Q2hRS3ZuMUlvaXZnQklsbVk3eDVRME5G?=
 =?utf-8?B?U1Q4UjZmMUlXeVgzdnJqRFBWYXM2K3lXWFpnaTZQTmFNeHBIc3FlWUdHZzk3?=
 =?utf-8?B?M2tuRktVUUZTNEFXY1FYcko5ZXN5ZlpYWW5zUU1Qd1pVQ2hMNStBSDlORWxi?=
 =?utf-8?B?bW8zN2x4WWRkeFNJQTdLY1IwZTc0ekZFU2VXUXN1QWE0dFZyTHFzQU80L1RM?=
 =?utf-8?B?UVcwbWhlSTR2SUhLWEhOTG10cDF1bUZwY1VseWZmeHlXWkNEU042ZWtMNE1h?=
 =?utf-8?B?TnBPRExzclpVaVJwUW9wUU44ZTBnNXkzVHJiTnREd0d1eG1HdjdvNStVNFhU?=
 =?utf-8?B?cjNibUxOdldIRW40QWpvN1RVeXEzNjgyMkw5SmE5MEF2Y2tTOXJWczJuTmw4?=
 =?utf-8?B?RS9TazJXbHdCNDNXMHZrSVQvc0NwNlI0ME1XZDd6b0VzT1FmSFV0Nm45N3Fy?=
 =?utf-8?B?dlFKMUlLRVNGZm4xYjVaU1ptN0ZiR2ZVazM0RlZsMGxPRC9VcSs0L2Zpb1BM?=
 =?utf-8?B?Unh3WmZvN2tYTWFyYk5kdDUyNUNqM1FwUzhxQ1F4ajZEUmRKd05TYTFkMmll?=
 =?utf-8?B?RGR3cXpzR2VTT05DQmpDNXQ3elJTMUFBdC9wbXVmOWNhVEhteTRvWWJWRHVj?=
 =?utf-8?B?aEY4eTdxMGdZTnBGNm5KcmNkN3lIdTNocmM1QlpES2wyUG5VR1hocmlVdnB6?=
 =?utf-8?B?czlvWVYxTG1TbFZMVi9DQW4wcTl3bkZWWTJPTERIcm5yV3RXaTF5UnhFZzFH?=
 =?utf-8?B?dU43eE1GeUZwTlRxT1psY0diMWxRdjM4VXFiUmEzQmlaeTdvTThpOFdkTHRq?=
 =?utf-8?B?YVJ3Mzgzb3ZKWlR3OUZmaVdxdXBXREFTdGh3YURMemdTOC9tamphRVR1Q2tZ?=
 =?utf-8?B?UkNrMXFQY09CRC9ZYVVqVWVEemlkVlJlNE9zQUJLYnB2cklhUjYxb0ZWajEr?=
 =?utf-8?B?eTZOeDVmZ1JJNFVFVXhYMjByRjBIYkNPMWZnMWtOS21UdWVoM0pMY2g0U3Zl?=
 =?utf-8?B?eGxGNFhsT3hkb0pwWlg1U0p1SWREbCtka2N4YmNMbHJiT3U5L2pBYThoaEhE?=
 =?utf-8?B?eEU1WW1qNVRQcWtZeElod1JFZUhac0EzbHlXVWtZdkdnZW56VU1GcHNKOWVp?=
 =?utf-8?B?NTAvQXhJWElwanBqUGVPQlpwSk9aM2xOU1RCZTFVVXMwaENleitWNXRxQWtT?=
 =?utf-8?Q?1TxWYArjLBeuu37tHJFerX+H2wofTf3wZX/Ab6Bze24B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <481393678554314FB1D33628FE95DEC4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790c9d35-654e-493a-5c0d-08dad1c08f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 04:16:59.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFkFLbjU0YdpeRMJMTkEo56ITWnZzWBB1TN0z2DnWr9pzHuc+gTeVKynikkLjDjC1HVytA75IMZ4Gzbhbz3epQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjgvMjIgMTc6NDcsIExlaSBSYW8gd3JvdGU6DQo+IElmIHRoZSBwcnAyIGZpZWxkIGlz
IG5vdCBmaWxsZWQgaW4gbnZtZV9zZXR1cF9wcnBfc2ltcGxlKCksIHRoZSBwcnAyDQo+IGZpZWxk
IGlzIGdhcmJhZ2UgZGF0YS4gQWNjb3JkaW5nIHRvIG52bWUgc3BlYywgdGhlIHBycDIgaXMgcmVz
ZXJ2ZWQgaWYNCj4gdGhlIGRhdGEgdHJhbnNmZXIgZG9lcyBub3QgY3Jvc3MgYSBtZW1vcnkgcGFn
ZSBib3VuZGFyeS4gV3JpdGluZyBhDQo+IHJlc2VydmVkIGNvZGVkIHZhbHVlIGludG8gYSBjb250
cm9sbGVyIHByb3BlcnR5IGZpZWxkIHByb2R1Y2VzIHVuZGVmaW5lZA0KPiByZXN1bHRzLCBzbyBp
dCBuZWVkcyB0byBiZSBjbGVhcmVkIGluIG52bWVfc2V0dXBfcncoKS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IExlaSBSYW8gPGxlaS5yYW9AaW50ZWwuY29tPg0KDQppZiBpdCBpcyByZXNlcnZlZCB0
aGVuIGNvbnRyb2xsZXIgc2hvdWxlIGlnbm9yZSB0aGlzIGZpZWxkLCBubyA/DQoNCm5vdCBzdXJl
IGlmIG9yaWdpbmFsIGF1dGhvciB3YW50ZWQgdG8gYXZvaWQgYW4gZXh0cmEgYXNzaWdubWVudA0K
aW4gdGhlIGZhc3QgcGF0aCB3aXRoIGFzc3VtcHRpb24gdGhhdCByZXNlcnZlZCBmaWVsZHMgc2hv
dWxkIGJlDQppZ25vcmVkIGlmIGl0IGlzIHRoZW4gd2Ugc2hvdWxkIGF2b2lkIHRoaXMsIGlmIG5v
dCB0aGVuIGxvb2tzIGdvb2QNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
