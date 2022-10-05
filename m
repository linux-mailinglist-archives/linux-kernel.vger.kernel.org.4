Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25FA5F4F58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJEFL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJEFLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:11:04 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E41D262A;
        Tue,  4 Oct 2022 22:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBNYBBy2dh5LYR18cuA4zKzhM71NHfxC9o2wvqTMY+DzvAAhdekc81R1WhQXtN1WfsYVtraZDnwL0lebhtYmZk02bYVczv5YY/ViwML9fmUAFGcVKAlM2CJi299A5Bp6Y9JlnXicNeWkCkaslRMestXpPN2myoi3TpiAKKGH3jiQISRTGQmsPVhxQiSvSrgwwhYs7JTe1v5rPe0sadMXLDr4COqGagKnVJjlOK+/gmNWrSWG6DyhyuS0rqYsY2myEwIzh59oIZM9jhwOv/uR0plol+oQKOyvlEOEEyUh2OcYhp+RyW+/N2AGQeA8pSjrm0vuPp5D1nswyTaN1G81og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrcfHiHnLjR2v/Jos4A0i9MSyePBWdlnfLg6dm2HIXg=;
 b=kdDQpg7MI1iYAY0TdEy9FuFRZwlKNPThESoooHpfK1gJzQTW0aNVb/dWgcqGY5qSBrhcbU5wi7txtshVke82qw9X4b4UffjPq9h+HymSS2gGNN1Es9H4mGF2+xGI//1qA3PMY8F3Ka0EC4dfXbcSBZunsMYhfBCrvwal/qTNlcuLDBM+b9H+7G2jadCBGsCYS90igmzCSszKHCwqUyFiCCrGFVDEJEZnf3HtxdwBPoJIdUZmVDOdTedTaCVAbWaZL1WhuIbsoDATByQFRhCOEe2zvZ2YET4BIkJIQsx3OZGAerJUQwVC1PznX9zJu+bqEUZIYUlb2G8pBGY5S4tGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrcfHiHnLjR2v/Jos4A0i9MSyePBWdlnfLg6dm2HIXg=;
 b=ql7NuLmpT/dFlA4uZG+/T3C2N/1z/2AmESXKP+Zm5wSu/kzq+xaYMrJP71oPHmlrBzn9r2C1A5ujDZ10klQSud3250djK0GJ77qSA5qJIgmsA0m+Bt9b22NqxoIOB9G5CTo7kygOCGNpywGkt+rNl0Nv+2LAk4tq0bqRzlCp/R/2RZCGv7NOnxNMx0ziEYo0thNK8ECAUcMiUDDEXOXip93qymkL+bu5eIGk06x/QBfU19ZG7o7nI5HJ7X0vUCch0xpEYAgtur+ODZzzi0BI7uqaSoLy8k3zBkaHt4q1FhNyuORIYr1CRRp7ye5ZeYvbEmT9dE9qZLXaCFPw2MVaRg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30; Wed, 5 Oct
 2022 05:10:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 05:10:31 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/6] null_blk: allow write zeores on membacked
Thread-Topic: [PATCH 2/6] null_blk: allow write zeores on membacked
Thread-Index: AQHY2GkFovuCv41QBkqHDwUISksJwK3/PSqAgAADmIA=
Date:   Wed, 5 Oct 2022 05:10:31 +0000
Message-ID: <a3fc1d06-7624-3283-ea6e-40a7a0b0fb39@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-3-kch@nvidia.com>
 <89b93617-2fb1-3757-9f80-ddc06f02683f@opensource.wdc.com>
In-Reply-To: <89b93617-2fb1-3757-9f80-ddc06f02683f@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6614:EE_
x-ms-office365-filtering-correlation-id: f4f2ea1c-ddbc-40d9-6c73-08daa68fed21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 69uU3f2MmtTZsgC5JF1uWGdjt9z3OFbSz7vFOpNRLbfca4QnWpWVef/X/lCs/ucjJJUAj6WuaMImX2iUXH+GyWIYisjmlx9v+2bZsr0vSdfAP+HR/pbTB9oT2YAiREXHDurqAHkVVAOG6kndvpZMd1aBI3llbkOgW1a49oSQr+5GNZLvdPGbl4DPpO1wmV1rWMAe7ysnIONTABzjSyKG4JsLw7ftO5s7ESWWBfIisRD8yioJaN1R7UD410hAbS7farpYIQVE+B5z7mLEJZjMsmN56jvL4XMkc6E1EbQ9jW7qYN/hDxGr5loj7FyaFv/HJTcmLni5cX4yH/Mcznj54k7GPn0FM+jrjfEjjfkbertNvWd/KT3PcOijnEAQ4MLyHXWpaMUZUIr1QTeOfzsaiFtCSAd52t19MvNOCnRvtHyNxHV1SoA2UUdPlMvnEODCvdRMo1Y6LKpxs6dC09uz2hn2ppNGglEdxKgUdQveSsDnR+9Uwnguj+fF0vZzBnotCgvdUgBJDIz1rDXTAsQMG1XqVrWO8kkNerxSfxQTrgltJ4BHmnWi0TE0rItzPgoPo1GvMHmTR8ttUIgYW5BATz434RK8jpKOGz0aivMl/R4Aa5kwWlWHctj1nDI0mCryG0Uk2G+4U1tz/XZ6kCnicEg6COfDVa98qrSk8rQgT5NnZalZyAvDKE/45bmvtviHKD3nmoq1XNrvvOJZi5bZ8ZDj02OC71K9C6UvFSiGZRrvm6v2CjUdulpkq6KncrQsNbtcZvwqTyenlr7Ch3QSRV8xjfHFzlSmmN/yVC9eKo0g7Rjz/TUO9oDy/yHqYERwXK6G8beuEhXfFNJfKao6Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(83380400001)(86362001)(7416002)(31686004)(5660300002)(6512007)(2616005)(41300700001)(36756003)(71200400001)(6486002)(53546011)(54906003)(6506007)(316002)(8936002)(4326008)(186003)(8676002)(76116006)(66946007)(4744005)(31696002)(66556008)(64756008)(66476007)(38070700005)(66446008)(38100700002)(122000001)(2906002)(110136005)(91956017)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW1OUm14QXpVQ25JdmN0MTQ2WWcwUm9MRDNodlRpazZjeUhyRGp3WU5lUjVo?=
 =?utf-8?B?OXZQK24zN0xMUCtuSjI0Nm02bEVlKzd1eDgxN01TQnFXMGhMaEVUVUNXL2xI?=
 =?utf-8?B?cnJ6T1hMRmpmKzAxSE5aMTlMMDE5dmEyR01senpZMUN1MWpVTWp6ZUIvWFJ6?=
 =?utf-8?B?SS9aZkI0c0FLcVJxZVBWRHFvbGxlcXN0blIxZ1Jqbi93ZFBwb1hOakxGcEZq?=
 =?utf-8?B?dXJtRHA2Nm9UL1ZmdVRPOSsyRXNBVXplRGd3NHU0d1kxUTYrY3A3L0hwekh2?=
 =?utf-8?B?R2tDVnBWVldCdHd3KzRHQUpOTk4rYUNUSlpzRWNTeFdnenhubXRsNC9TZkFt?=
 =?utf-8?B?VFpvK2VEdDFtR3ZyWDVTVEpaREdBcUVjbnBwb3pndGZiY2xweCtTYVp4RFR0?=
 =?utf-8?B?UEM5SUtRbzEvOHBnOG5XK3U2S0hqLzRsWXBwQXRqamticDk5R3huQ3pjakpo?=
 =?utf-8?B?YVhURFI5TnNMSHBYZSszaTdKQWZuZVB2UlMvWlhJQ2FTQ0l3SlJjUTMvNERN?=
 =?utf-8?B?eDhHQ3dJa2M0d09zTlQ4RFRoQklLMENkWDhCckRvak1vQUZ2a0VnSmlsNW9S?=
 =?utf-8?B?QnFGU1NpaXJQYkpIZkhLaTA2S2VsMTBZY1JzVXoyRi9oY3JBVW1kY3BPL0ZX?=
 =?utf-8?B?MUZUSW1GbjhPa21wMDQ5Z0F1S21TV0JhUjZ1RFp2N2VxSW1BQWdVRFV5elRL?=
 =?utf-8?B?eTQ5anRKOW42MTJDZFJBNnRVOERJUStMYUtKc0hvbGUyQnBoMHlZdFFjVytk?=
 =?utf-8?B?Uld1Sm9kVnc5OXlXendCc0lsZStNYWJaRHIvZXArS3VCSmNOV3JWU1RuOWFh?=
 =?utf-8?B?ZWVuenFkUHN2cjBSek1CYVlqSkRjeUN2S2N2VXBSL0pLNmwzT25MczFEUGV1?=
 =?utf-8?B?QVUvamlZUkZZQ3ZVWTI2WFJyakRhZW9nSXlEb0lwNmJaL1JpdXYwRkgxYU5H?=
 =?utf-8?B?Z05ZRWUyQ1NQSlJQV3I1WFZvNEk4SEk4UTBOcHlPUmFpcnFEZlpxTjJOYVhD?=
 =?utf-8?B?WE1CQ1hMbUdqVU1JTVRvL2Rwazd5T3JFTnFZcW9HU1psNk0xbXdRSXJLZ0lO?=
 =?utf-8?B?QnpIc091Yk5UOHo0NFpINnd2cXo2S0ttaVRWSzM1MCs5aG9McFdvMEdSL1ps?=
 =?utf-8?B?N2VOeVpneGw3VGJaZlNoRHp1TEtibDVzRWJhZ3Y0MHlkWFUvaEtReFgzQ2gz?=
 =?utf-8?B?VGRMeHM5MnFZU2tLNEQ2R2JLdkQyeU10ZFUxY2hOV1VkT1BZY3VHd1d6ODI4?=
 =?utf-8?B?a0g3WjZ3VVVJdUFXZzl4aTk3L0xrYm5wUnhWem5iNi9tckk1NzBMeG1aM3I2?=
 =?utf-8?B?U202WG9CeUJKWHc0RTYzSkYvWnA0TlZyOUxIaU5KYW1ySllMQnVoS0pDZGo2?=
 =?utf-8?B?SGF5ejFlVEpvckNZL25mWnA5ZmNmVDBTNGsvcUpVLzJoM2o3Qm1mWjNURlBK?=
 =?utf-8?B?RS9pQklIa3FiQ2ltbU1oVzdLSlBwQUNpamFpYlY2NHBDRkFSMGRuKzVWM0pJ?=
 =?utf-8?B?bklZWGRML3V6cXNjK1YxWUlZWXBlYktUNEkxVzZ6ZkJBTEcrRkxTSzlQbU11?=
 =?utf-8?B?eUxmME8yNXJWME1ETkhGb3pVU1A3VmtlVkpFclI3N01NVWdraUpaMmxNVDBY?=
 =?utf-8?B?TlEwZEVMUEZOY3FBSmZzVzJudHkyb0Y5NlI3Z0xpRTMrQ3lJWXJuUUV0SUhk?=
 =?utf-8?B?VDVKWmcvYkptaVNnZHBrUzRRM2t5cTRTODVzY25hVGtOUUw0dkptWFY3Y1Jo?=
 =?utf-8?B?TlllV2J6NzNXdjhsc3JKMVpjY1dwZ3ZRcVhCekE3K1hZUnZNNnYvWklQTU1Q?=
 =?utf-8?B?RUdOREZyOGZRNVFrVWM0RThzWlkrNGJYd1lveUovdnpxNUVGbnVRTlNwaWF1?=
 =?utf-8?B?MUgweU5LemRsTXdSdExCbnZ6RmR2NFJjYUg1eFpwMXR3dHl0bFpndnc5ajNR?=
 =?utf-8?B?Ym5ycDk0Rk4vd2ZvaGRKSGZVcTk0YWZrdkk2WkVzN09waCsweFM3eFpMbTlW?=
 =?utf-8?B?cW9kanY5OWs4VW1ybWlSLzFCYmJhMDI4aVNNc3JQeHFEZXdUMllrNkRtYXlH?=
 =?utf-8?B?K2hIZVpqQy9WdklSdG5sSldEOWp3OFFhc3BYK2dGSXZYT1pIRVJZU09XZWlk?=
 =?utf-8?B?R1FVTHVkZFpNSy91THlCU1RVMWUrNk9uSWpqTlFidHJOZ2RSQVFubGpnKytH?=
 =?utf-8?Q?8KUL1g+mYKXphhcTgVpuw4eBAzTDJ0itlWNMWyHGvAtP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46434C304727E147BD547322FFA6837A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f2ea1c-ddbc-40d9-6c73-08daa68fed21
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 05:10:31.4646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byOVbpY0+OUUfxbFnkKfgp1Zxea96aHfbaFnhKTbzga/CscKwuShNdE6vdjxYfVzNg1Rcgz3W5v3K32LRYmQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNC8yMiAyMTo1NywgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDEwLzUvMjIgMTI6
MTYsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEFkZCBhIGhlbHBlciBmdW5jdGlvbnMg
dG8gZW5hYmxlIHRoZSBSRVFfT1BfV1JJVEVfWkVST0VTIG9wZXJhdGlvbnMNCj4+IHdoZW4gbnVs
bF9ibGsgaXMgY29uZmlndXJlZCB3aXRoIHRoZSBtZW1iYWNrZWQgbW9kZS4NCj4+DQo+PiBTaW5j
ZSB3cml0ZS16ZXJvZXMgaXMgYSBub24tdHJpdmlhbCBJL08gb3BlcmF0aW9uIHdlIG5lZWQgdGhp
cyB0bw0KPj4gYWRkIGEgYmxrdGVzdCBzbyB3ZSBjYW4gdGVzdCB0aGUgbm9uLXRyaXZpYWwgSS9P
IHBhdGggZnJvbSB0aGUNCj4+IGFwcGxpY2F0aW9uIHRvIHRoZSBibG9jayBsYXllci4NCj4gDQo+
IFdoeSBhIHNlcGFyYXRlIHBhdGNoIGZvciB0aGlzID8gSW50cm9kdWNpbmcgdGhlIG1vZHVsZSBh
cmd1bWVudCBhbmQNCj4gY29uZmlnZnMgZXF1aXZhbGVudCBzZXBhcmF0ZWx5IGluIDIgZGlmZmVy
ZW50IHBhdGNoZXMgaXMgc3RyYW5nZSBhbmQgZG9lcw0KPiBub3QgZmFjaWxpdGF0ZSByZXZpZXcu
DQo+IA0KPiBUaGlzIHBhdGNoIHNob3VsZCBiZSBtZXJnZWQgd2l0aCBwYXRjaCAxLg0KPiANCg0K
U291bmRzIGdvb2Qgd2lsbCBtZXJnZSBpdC4NCg0KLWNrDQoNCg0K
