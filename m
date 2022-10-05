Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5F15F4F75
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJEFVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJEFVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:21:31 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF36F73328;
        Tue,  4 Oct 2022 22:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/UBTcUHWFIiSZS2hDYpUXNHrdZUj3xsnR2ClIADB0j191WTXF7T7bW0L0vwjfrGKsFofffhqznXL1R3qeKg8JSuPUlSeyr/pxaDMszScwVlZdSHQ67l9xQxdJ51RQY5gCCEfnqCBvpXU9oZTtLLMZmAdFHifd/uHnep95OzJwABP/zUJYMQ41WttwwODn3zLC7msTEWrZNpZd9tyDKJA7is4K+GhFojult2i9PbSy6ClIrHEKQB6PQVLLJiBpA6zw0UbA0zGnLA1HjsLsdUye5JY3W+LwZV+oiRg5lh4f8O0M2+OD9TdnkgCQuOWw8+fReUnw/M3z8mKUCrXU+Opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wquwCxOdilTn+kakKOCiUd6wFFhulG7dw/ZhRvMPc4=;
 b=JN69dmMYTtMMOPbx+dq+vuIFz/ESkX4AQ8NRUUdwA68xUTx+ghrcJaymr8iAy/pr3IEQFmsJfoDmRNlNkrr0gkaF8gpL3kSDsSAFCRocTlIY39I0FYcmsGqiQyg8TbEodlUcx5p8t1GdQ2zVxiyvZPZyMpWdt4dxJIPp7HHtHeADgHHPQgOH8dBqTHbweD8gLuqYBnadbnTlP7ipCI/iBoAl3scXx2JAmdqeAcNMeaehxDwpKem3z0VTsbl5YAkpv1ybwcOVOKXMz1Cpqx5hU+2b+jDiD+e5MaB5TvL+nGnmx9M0qj5kgpITO3vRpI3Jgg57vj/1zYm1/4UwdEWGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wquwCxOdilTn+kakKOCiUd6wFFhulG7dw/ZhRvMPc4=;
 b=Imnkp/uqVr0s3v/ZaYFxl/c6faf97Mha7FjgjtVztGsPPjL2hNoThF0ENoAwWKBQ14sYcbhpK6FETLrnmqI01McNy2s0TesbstC7zvuHEqOwpZ9GUzwRAQNKmGL5+N6awe7Vhw2C+6Q7NueX1kXmhQZR/BDKO4hpUo5ToRf56/pqT6U9Lk7wS2iylQNT9eNqMcKQtwvZnmr3VH1XPb7sGQoobdcD570Ai5wSx8L6kc4M3IfDfCF9Vn87KTf6Nz1v+C0YvA80GhWzu1pfUz8I/7okveP0y9Uo7SxGxC7d4tjsgx9Vn/+UQm9VsioFTy/QOHY4DY/8n5wJ+CZAlGatsg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 5 Oct
 2022 05:21:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 05:21:21 +0000
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
Subject: Re: [PATCH 3/6] null_blk: code cleaup
Thread-Topic: [PATCH 3/6] null_blk: code cleaup
Thread-Index: AQHY2GkKxj/Sa8+o40Oz1G4zG0Qy+K3/Po4AgAAFOgA=
Date:   Wed, 5 Oct 2022 05:21:20 +0000
Message-ID: <6c0cafed-c600-d499-ac26-13e4fa00737b@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-4-kch@nvidia.com>
 <b96c6d74-3436-c4c4-4c25-23960a1b3cc8@opensource.wdc.com>
In-Reply-To: <b96c6d74-3436-c4c4-4c25-23960a1b3cc8@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB6883:EE_
x-ms-office365-filtering-correlation-id: 81822527-02fd-439e-3c76-08daa6917036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lBz/pVwyMw3/qRD2LkbrqyCo5RU3PJdLLc88XKaPBzkXNJ0QyOOe+MDpwzsf69xq9dpSVjBr+LUUcIE4GrP7HWGgJTWs3NEkQw6G5aJ/C7F3ZQXCFHQGhCBpW5eHwdOX6HVC29BnGoOJFLRd44V7Usp8wxXbeI+qB799zHkli8c45bVgXX4sRex7gLBrWOSoh1sMP2vum7LEsHQjX2JomfvZUf0eM4ElGi/atj32jg11JtGZFrdtzpbR9/oHBMB5bjIzFZn9e5wAA9uf09dHB171IIERyBW8ajQEyGhF+nXCoyTWy1kZa6iqHrxHANU7NYOlU156nNFeq9kF+hiIPTMI4eTPJTRY6tmMgMUnKQartLgJRwsNE5DW8hJwdFIsBdHLvROmA3RonrjwXalHWGjaUGDRQ+EHnhqOVMKc0qL0heOsm3vtQhCIsktScT31EWZ8P8ZmWaXk2qKduxtChBrBbLgQD3rHIlg7RR7UsuTzJ9zS+02NIS4gNgLE0x2t83ODwxOkF7+AqiJt64vLnRq+sh1h2PFe8YlC1KYAWOaY0s9JZKFE7a8bCgmrEiigxZoovCrk/nByH4utTrAp9oLUuo/ebPtrug1JCdJ7S/YkhUr1lwHUt93C9ZPtCNTBa0WRwOYbrN2oCrlIEk/9/x6CexRDF4WurAdErOs2zok9Nk82dHqG8bUs4jJyT/D/WnzhMqaWk7IhJwFMS3+RJNIETXBJxXRABrqLNmMTWmuziR0swYjKSPb29potK+vcfNAjXRULxpxtD42l2kmXF7GIp2BMFDsmmsnkmFOjWd7w4JBkO7NEqaBVz6TNYINI62+oGVxSXIcb0tiDJ2eTjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(31686004)(2906002)(66446008)(8936002)(41300700001)(38100700002)(64756008)(5660300002)(316002)(54906003)(76116006)(8676002)(122000001)(4326008)(66476007)(66946007)(36756003)(6486002)(478600001)(110136005)(66556008)(91956017)(38070700005)(71200400001)(86362001)(186003)(6506007)(6512007)(31696002)(53546011)(7416002)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTUvaE5sNUx6Z2lMTjRrVzBETG5oZ0I2c1ZMbXRBeHNVenJ6dkVOSE50cWhz?=
 =?utf-8?B?ZmJPOFFtN3QwVU1jZURnOHQxeFVzdnJBMlRacEZORXlPMG1kNU9PSHA0MUZC?=
 =?utf-8?B?NGdkV0k5S1NheHBWdkhmYWJEZzNRT25aTnZadWp2OUlCeERDTFJSbzJsYTRJ?=
 =?utf-8?B?QlJLZ3NTSE1VWkhVMUtubnM4N2d4bTE4Tk5NWUFsZ3NGWkUzb1U4UnFiOHVD?=
 =?utf-8?B?bEY4Y0pGNTVyQ1NLKzVyZXZaRHlmRG05aGU2RDhaNHhrZkpDbDQ0emwyU0VJ?=
 =?utf-8?B?ZUc5d1hhV1RoVERoakhFWE15dlFIaU5FK1JCWUhzaUJOTzhGdklYVWRZU1lL?=
 =?utf-8?B?d3JJVW5URG83enVhOWpDY0dOL3A2UGhlVEpnb2s3bWIzTXpDWVMrc1JuQXor?=
 =?utf-8?B?bUpaaDVWME9tbUhxeWg2Z0xTTEFPcEltNTFGYzBaVENvN202d3p4NzhsNk1O?=
 =?utf-8?B?ZzdTb01SeGlqL3RlVE81emtCc3ZyU1NUWUlXTW8zMGhKUFBpS0UwbjFRQS9E?=
 =?utf-8?B?MCtPK0JaakNidmVjMC9IRHJmYmlBa1l1NExTOVJZU1d0UmV0NEFKSVhHYUpw?=
 =?utf-8?B?djZNanF0U0p2M01QOURNTFIwNHk3RlZBa3FsMXVFbEpEQ2oweEtyQ3pFWDlN?=
 =?utf-8?B?a2NTd2NDdjhTQXRIeEFPc1JERFNzbjFyYzNLQXJpK3FyaFd3QWdjWFN6TzBz?=
 =?utf-8?B?M05FT0JtakZsN2h5VmpGY2hzcnBraXdEWS85QnNXUGJJYmUvK1hENVZOclps?=
 =?utf-8?B?Yys0R2pseDJkS3lKUXNEQ2h6NGJ6MndabzVEMUIrbGUwNjc0VmdjWm9QM1VF?=
 =?utf-8?B?bm1VejJaUzh1S1MySjJjMkpqYndFTHdzR2MvMFdIN25jZ1I3UmNvODZtUEFn?=
 =?utf-8?B?N1NmOEdKWDlXTEJ3ZGhBMDE2Q1llckl5R2I3S0pkSUtNSFl5aFBrbDRZNXFa?=
 =?utf-8?B?dlNLdmNtSHVpbDBHaTRVc0NRL0lQL1pjNWlScDdJSDF2L3BCZzF6dFEyUDZ1?=
 =?utf-8?B?NnlFb0xvM1I3WGNLUkxGNm5IWllKeTE1REdTT0FnckRqWW1HcmNDaVBnNjU0?=
 =?utf-8?B?cHNjUU9vYkhSbTBFTGVKTjFwMEJtNUxXVzJHRytnUnpMSXdtZHJOWEUvQ0FK?=
 =?utf-8?B?Wkg4b25TcUQ0aVB5eHU1VGZUM1d3Vjd6RlMzT1JhV2pCWW9zb1hsZFIybnNO?=
 =?utf-8?B?RHRJaDROZ3R6OEFMaFYvS1JiSnRQdHFnN2pldzZBbThhQ3NKN2hUc3hsclRV?=
 =?utf-8?B?MDlLTDAzMU1pKys0OHQ5NitwTi95UHcwTVl4RWo1Ymx1SnRVQitoL05NSVBv?=
 =?utf-8?B?WStqQUVmcnZnMllVTjIvUW4wZWt3dVdsbkU4T3V4clFManZ5QmJzK3dVNGFG?=
 =?utf-8?B?OGo2b2g1a1hkMEp1K0tnd29FUWZUMlV0QTFQc0xnM1Y3SjRjMVV5M0huQ2J5?=
 =?utf-8?B?dkxtNFc3VnFJTUJML1E5dGUvVGtSWTBxODRIU2FjNndKRlI2MHBxS1hER0sw?=
 =?utf-8?B?b3ZESWNiVEZRNWZ2ODBlM1F0TnBRMExsUzVkU2lHTEpZeWJWTUJrVGI2T25I?=
 =?utf-8?B?b3BFUURYTGh2UjlXMTZuRUtlcjNMUCtXRWZEczJSNXdLUVpkdXRvU0Z4MTFh?=
 =?utf-8?B?ZEh0eXZpMjFHc0lMa2Z2ZkFXMzRLSGlsVldvMmQxMGM3UjRrK2t5YmxPdzUz?=
 =?utf-8?B?V2J5d1hHM1pTWmxmQ0NuQkFzK2l1VHB2RHlzRXRWSGhtckZManBsaktIOHM5?=
 =?utf-8?B?YkFwR3NxNG5pRjNSUEh2bmRCekIrcXREbys3ZEJNNmhOQUFnOGJoTVZlVi9k?=
 =?utf-8?B?bVU2UCtqdFBSQ3U0bHExUXR0Nlp3MlhhTXBRenRBQUZjNDRBZGdicldpNFd1?=
 =?utf-8?B?QktmSzFyRWRJVWJNMUhVdDdrQXhBUExtQUk2VzNja0FkNktaT05YdVh2TjFI?=
 =?utf-8?B?ZzlZNlhBZnJvUC9SZTBhY3lGTWNaN0Z3N0NhMUVRVDhRSVJkQnlRSFZhY3NB?=
 =?utf-8?B?S1hvT1pzazR3SjYvT05sVFVPOXRYUzJ2ZXhUMzRrV3lrMEg1ZXQ4eW8vaHFH?=
 =?utf-8?B?Sjlkb2lhc2lhYXcrUWlHS3pQSGpuRkRZR0xkN0Q2KzZTd3NKcXBnR1BUcGwv?=
 =?utf-8?B?bkRxc204UkJsVUtJai9rc0VTeGh0cGd0bG5NZWhhUmlJWFA3Y1BydXdWZjE3?=
 =?utf-8?Q?urSYaOrfG+DpXJHJ7aLTBKnJOHOYH3lFB97a1n/ttrKp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCEA8A20D410DB43ADE478B7F7CA1B6E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81822527-02fd-439e-3c76-08daa6917036
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 05:21:20.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lzMbKUwqxxlda1Qww62+2SmTrk5tF+RJDPlIfs5dkHPhk5LBx5GFENg3nDdZgkCqAg/2tKy9WASim+FsjhbbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNC8yMiAyMjowMiwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDEwLzUvMjIgMTI6
MTYsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEludHJvZHVjZSBhbmQgdXNlIHR3byBu
ZXcgbWFjcm9zIGZvciBjYWxjdWxhdGluZyB0aGUgcGFnZSBpbmRleCBmcm9tDQo+PiBnaXZlbiBz
ZWN0b3IgYW5kIGluZGV4IChvZmZzZXQpIG9mIHRoZSBzZWN0b3IgaW4gdGhlIHBhZ2UuDQo+PiBU
aGUgbmV3bHkgYWRkZWQgbWFjcm9zIG1ha2VzIGNvZGUgZWFzeSB0byByZWFkIHdpdGggbWVhbmlu
Z2Z1bCBuYW1lIGFuZA0KPj4gZXhwbGFuYXRpb24gY29tbWVudHMgYXR0YWNoZWQgdG8gaXQuDQo+
Pg0KPj4gV2hpbGUgYXQgaXQgYWRqdXN0IHRoZSBjb2RlIGluIHRoZSBudWxsX2ZyZWVfc2VjdG9y
KCkgdG8gcmV0dXJuIGVhcmx5DQo+PiB0byBnZXQgcmlkIG9mIHRoZSBleHRyYSBpZGVudGF0aW9u
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMgfCAzNyArKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMjEg
aW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMN
Cj4+IGluZGV4IDJkNTkyYjRlYjgxNS4uYjgyYzJmZmViMDg2IDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmxvY2svbnVsbF9i
bGsvbWFpbi5jDQo+PiBAQCAtMTQsNiArMTQsMTEgQEANCj4+ICAgI3VuZGVmIHByX2ZtdA0KPj4g
ICAjZGVmaW5lIHByX2ZtdChmbXQpCSJudWxsX2JsazogIiBmbXQNCj4+ICAgDQo+PiArLyogR2l2
ZXMgcGFnZSBpbmRleCBmb3Igd2hpY2ggdGhpcyBzZWN0b3IgYmVsb25ncyB0by4gKi8NCj4gDQo+
IFRoYXQgaXMgY2xlYXIgZnJvbSB0aGUgbWFjcm8gbmFtZS4gTm90IGNvbnZpbmNlZCB0aGlzIGNv
bW1lbnQgaXMgdXNlZnVsLg0KPiANCj4+ICsjZGVmaW5lIFBBR0VfSURYX0ZST01fU0VDVChzZWN0
KQkoc2VjdCA+PiBQQUdFX1NFQ1RPUlNfU0hJRlQpDQo+PiArLyogR2l2ZXMgaW5kZXggKG9mZnNl
dCkgb2YgdGhlIHNlY3RvciB3aXRoaW4gcGFnZS4gKi8NCj4+ICsjZGVmaW5lIFNFQ1RfSURYX0lO
X1BBR0Uoc2VjdCkJCSgoc2VjdCAmIFNFQ1RPUl9NQVNLKSA8PCBTRUNUT1JfU0hJRlQpDQo+IA0K
PiBTRUNUX09GRlNFVF9JTl9QQUdFKCkgPyBBICJwYWdlIiBub3QgYmVpbmcgYW4gYXJyYXkgb2Yg
c2VjdG9ycywgdXNpbmcNCj4gaW5kZXggZm9yIGEgc2VjdG9yIGlzIGEgbGl0dGxlIHN0cmFuZ2Ug
SSB0aGluay4gQW5kIHlvdSB1c2UgdGhpcyBtYWNybyBmb3INCj4gdGhpbmdzIGxpa2U6DQo+IA0K
PiAJb2Zmc2V0ID0gU0VDVF9JRFhfSU5fUEFHRShzZWN0KTsNCj4gDQo+IFNvIG9mZnNldCBpbiB0
aGUgbmFtZSBtYWtlcyBtb3JlIHNlbnNlLg0KPiANCj4NCg0Kb2theSBJJ2xsIG1ha2UgaXQgdG8g
U0VDVF9PRkZTRVRfSU5fUEFHRSgpDQoNCi1jaw0KDQo=
