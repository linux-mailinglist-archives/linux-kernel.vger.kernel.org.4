Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6D15BB961
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIQQat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIQQaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:30:46 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A552DAA9;
        Sat, 17 Sep 2022 09:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO1T597+zR3gXHCjOgyQNW8zv/zrQ71UgunBFz+ICNEVgFNtY6lpHf89H/TLTF66e/0f6GlgOQEcpaSbgfV0qCxd2cQs78LPPhz394SoFJZ1QxkRXzczjc+7nrQIFJAt4M2e3F/SZBnO5F16UInHIwmnPhrz2GY5s1ghc/vvfxCZ6dtNGPqy9gPleqGJFl+NWzrlxbxHV9i6xb+kskwUtRyBS5nQQayv/YFXAOJxdBqOpsiOKQwkKv/JM6jDG+1IYhoc2GQmK/7yPYEiFAp0y3geV4FLOgfjrpPDDGNIzblEmFnk0McbzT22hysKGfJbvZbtzEBis3MElVMSOIIvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRO6XSCRYqaMhLE556KeG6SvBg6lpdytqT3Lhy6nY/U=;
 b=eYNeEhiIZ1eorWt4gRgTMmX5cf81Z3db1SfUutFWYciXaL0zOOB8SBt4QONqTRjOHa0q5sGc9Tmea4USbXtgRafeu/eUBgV3Y7IFpTMORBMNjcWkW3rfE0Vddn4l6/eJq33TmvAmp3S1zE+1e1plStRyVT4BR/XQmgDpm5R3lyGQUZckYGfx2v+SYgd0cmojtEuyOXdxcIPq21l79Q473NOewDqQZT3eZigZ6Ocwab7f+yer1I+Rq525DkwY7WO9flWIyGl1rODIk0IYsEM9hJcHFpSKSUWOW3z/Y8XeQrnYnOyPvUZWmLaR+BOUlJaR8rBmwLcnwS4kFAZWkE+u0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRO6XSCRYqaMhLE556KeG6SvBg6lpdytqT3Lhy6nY/U=;
 b=uLHjcS8wXXYE2fPPBkUHPmGGOVo3hM7VljiWGjJmcjLCBxPYYqoILuwira/y/ZUhKFFa5v6ypa0wx3/FWpG4UFLO8cr0IyVRMAMjaEGIp8LAP9tbcUmKmgPBkYndijBY07Xxu41LjtwTdGFeSVV1dlkDHIaqmgUOIyxWSrvhgkFHLbtAvY0p2D5omTqFBUMdyGTWKtD482pmlnpmDuvhxHD5oO6NTvEYD5i32hT4OQkX6G6kbzXi5H6r7cdzNW8k+XlRrnP0Vs02CRIBZCOa51GixzwNzM/HjI3bUqVxRH6GVQIQ4JCq26S5XmHMt9OdARu9bTj9/vyp/gD4fBPJ+w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Sat, 17 Sep
 2022 16:30:42 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.018; Sat, 17 Sep 2022
 16:30:42 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Li Jinlin <lijinlin3@huawei.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] block/blk-rq-qos: delete useless enmu RQ_QOS_IOPRIO
Thread-Topic: [PATCH] block/blk-rq-qos: delete useless enmu RQ_QOS_IOPRIO
Thread-Index: AQHYyXTjYF2IKWNfP0m619oo0fSira3j0r+A
Date:   Sat, 17 Sep 2022 16:30:42 +0000
Message-ID: <fe9863c8-af50-32f2-9b3a-ee631a50a874@nvidia.com>
References: <20220916023241.32926-1-lijinlin3@huawei.com>
In-Reply-To: <20220916023241.32926-1-lijinlin3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4337:EE_
x-ms-office365-filtering-correlation-id: 3328fce9-b93c-471b-baa4-08da98c9f71d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ud6ncRr1cPKtkmk+CDO00hnQu2GcRG6Ubv3CIMRmQe4B1H+IxbxwCt31My4d26p+H4jUQAMUCUgy5E88tFpO33p4WQ2kHBLIP6n6+OJNMn/VVdRlMxvd0XwLtbkgpcGTyEic8EskoIr//ZJNWXHzcLKFkNERPB6mctFiEl/u2kkX7Bt8Gn/+YfJcj/gksuuHJqaUS4ohnSQW2vUJ1aLQVD6GoPLU/WQYsLPLjZRuNeM/dyXHMp86+iCh9pLgkNE60cFDBO3ssdT0+QbttZpXP4yLc8Z1f/kk/W3IR+/rwkIEryl0Mceni8pafhoe1FJIqBo33efq5BEnBM1aqnZsm06y/RWbR/qKaKlSKbYbswOZ38wTcn7DcKdLWZ/txOkRRhoP1fGJyv6R5bJjzxvDEZ8zmkkGYwh9u3nl2l84IZYj99rTyZZ6ASrQxaX3ka3TF6Vwn8bq8lERITIPs4Nug+8ALIFmooLyBuAi6096Q03t/0ZQyi/3CGnn2AmOlZCzsWeFZWQlIiSlh/ZTsJI4JDRP+2CVK4zNx7zHg/MpPiBGr8y55kOpS1V5h/JhRIdNeHoPRh0tAykR2e6QRlnQEEHKLM89X0EVLiz/bKc2Kl1Sf2FW+WbzHpE2qtRaL74/YAE/VV1x1CyJiq/LTY9jaoD5IqtnUPm5wUTLsLMycIKD6qgzoU6+6MM74fi4A+zGTGYtW5qYzG6MZXFPfgode8amFTcesH09BChZMFb404SidAT+bcri0jHMnLJdSlKo2V0thon9R7fpiwA+Z02LuzfeX02SCj+LnuSYwNO7G7YrsEOpwgAgzEGg9IGoedGGSJ5ocC35+/dbVzSrho1DWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(558084003)(186003)(5660300002)(66476007)(66946007)(76116006)(64756008)(4326008)(8676002)(2616005)(8936002)(2906002)(66446008)(6486002)(478600001)(122000001)(316002)(38100700002)(66556008)(54906003)(6916009)(71200400001)(83380400001)(36756003)(38070700005)(31686004)(53546011)(6506007)(86362001)(91956017)(41300700001)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlZKd2NVS3lPeWdMODg4M2JiNTJhQkJBV2NSeUxxTG8vdytjM2J0OU1wTjlp?=
 =?utf-8?B?SzZJYkZzblNWOXlWMmlBN3RvUGw5bDhFOHhzK2NhSkY5eGo3WFhrZTFKVTJW?=
 =?utf-8?B?dnFTTFcweUdBa3dRL0hDZWwvTGFpUUtPTGplV2g5VEtKQnZZWGh5dnYzU2pY?=
 =?utf-8?B?VXNLMXdsTGljUVFTWS9HTXNIcVZGQnU0OXBVNjA2bmVCdFdWRXV6Y3BidUt5?=
 =?utf-8?B?WmZBN1RXaDAzUWpTMnBpUmg3RjNPNnA3MmlzUnpJcG16SEVZc1QzUGJiYnVI?=
 =?utf-8?B?RVlaaW1MNTAyNVV2WmdsTnFGRndIMmVXQS96Q2FFNmZKSXBlWGJna2JqM1R6?=
 =?utf-8?B?VDR6ZFhmaFdiN0I0RXFadXE1a3lEZ3R6aTV4SDVGTGdmaUVpc3kzZFBGNjFJ?=
 =?utf-8?B?VW5xb2lWaVZtVExEMGdoSUMva0MzRVgyUVNobWMyUE8xOUZ4L2pIeFR2K1R6?=
 =?utf-8?B?QzRVS0pKVjRLMk1xcUR0UmpZUVlEM1EreS9IS21TY01MYThMOXVGS3g1Q0Rz?=
 =?utf-8?B?M1g4cm1FVlNnWlVpMDBkUXJZVHV1ZW5QV1FneGN6SjNqb1NWZWVwTElhbjRt?=
 =?utf-8?B?dER4clY3Yjl0Nm9jZFgxVEtEQjdjcmNTYlBmQ2poNUtNZGE4SVA4YVg3S1k0?=
 =?utf-8?B?eUxmMERUVnlSTXlHZ0tESm9ndkQzTmZDR3ZQUEJ6UXdaU0FtSG1JNC9uUEFh?=
 =?utf-8?B?dG5iSEVDNzZUT1ZTVlFkT3d6YTVnNFFnMHlldDh3eVJrcGE0MG5GRmtOU3FM?=
 =?utf-8?B?YXlJckRIaml1ck1XTzh0bDl6Uitlazd0UkxkSldvalQwMmFvR0FhcXhMdnk4?=
 =?utf-8?B?bXhUMGxKMUYwaXlLYlVIUldhcUlwTFVuMDU3ZENYOWE4Z2pYVXZlcHF4VmpZ?=
 =?utf-8?B?T0xlbXlTTFFUdktwak5JT3U1M0ZncUNwNk1zdUJ1a2JuU0JKUDJRRnErbXdW?=
 =?utf-8?B?eGNqcmUrVEV0Q2w4eXVESmdpSHFJc0lqeUtTUzkzZC9JUHBvUDdPWk9uSHNq?=
 =?utf-8?B?OEJlOXlwWFp5K3B0SDNlTkpDcnh4S3JUZ3ZaMjBRMnJTajh3MVVpOFEwcWR2?=
 =?utf-8?B?dWx3bWI3cklkbHdZQlZuUndrSmNwWVJRZi80R2dkelhsdHM5blMwMktrNzlp?=
 =?utf-8?B?R3NLbCtKc1VYd3BrNklGR094RTNlQU9ValZleEZwVnBWS2NsSXkzN0dVM1Bk?=
 =?utf-8?B?bGw4T0pLTHBaV2h5cUpvK2dYMTZIb0xUdGdVcTl5Rnh4cFlOUWpucUp4UE9R?=
 =?utf-8?B?enFWU1NzKytsQUNjek03SWcwdU9GQlZmaDE1SWV4dENqZGdjNlkwRTdWVjEw?=
 =?utf-8?B?cUFPdGlMd3NyejRPSGxSSzRYRndSSHlVOGxZSjFQNVp2VUxlTWx4QWVwVENo?=
 =?utf-8?B?UGZiT29SMk1MUzRpNXFuTlVPbE02U1VCZG1hR2V5WlFqQ1A3ZjExK2o3OWdx?=
 =?utf-8?B?SWRZcWxHR1g0VUlRaHVuQisxMktHRzZqb2dDVWdYVUUvZ2RrWWRJcU9NdHJm?=
 =?utf-8?B?Z3FEQXhsM3NBeVRNeEpkNHJxKzNlbXlpdnRzODU2MUFVVFBSTXZLOXp2UDly?=
 =?utf-8?B?Y3VFS3cvZ1RROVowTkJ6VUwrYXI3dUZmMW41M0Y4MmU1K2dGbERnNmxkOGxN?=
 =?utf-8?B?R0s1TFFYYUFiNWVJNE0rU2I2Z2c5VVB3N1Q0bk1vODhoQVVQSllMaWNSV2Jj?=
 =?utf-8?B?bExKbjk5U1VqRVppYkhxTFZPeXdxV2thYnlWZDhNWEVyRXhHZDk1YlFQWXZ1?=
 =?utf-8?B?SkxDT0FZMXRWTWFRQlBmaFBVdW9FYVUwdUFhMzh3cUV0Nm5sVFI4Z0NuMGtI?=
 =?utf-8?B?V1ViQWh1WG9HWU1pV1JYaHhyb2RHZGRqLzNnNHdKNy9LN0FhSHdRS1dOWVAw?=
 =?utf-8?B?VkkxVDl6elQzNWFWNmhQSVI2M1NqMmx6NUlZUDJrMkdhaUxNSStyeVNvUVp6?=
 =?utf-8?B?UER3bVVzMzN0RzdVazZ1RStZcW9qL0JkRVFkaDU2bnozOVExYUV6Mkh1QUpD?=
 =?utf-8?B?TjZrN1VYOWJwaFZwNHhacGFqMHhISlFLWmFNSXNwa3ZxVnppVzdBNngvSkhw?=
 =?utf-8?B?bzdrOGVUclN1L2c0TDdpelA2dzZrVXQyakZTVHR3cGp1NURXck5LMWRIbHB1?=
 =?utf-8?B?R2xLZE9TYkludkxvb01nR2kvRmJnS1JwZmp3b2RTeXlnSzVNU01sTnZFMWRk?=
 =?utf-8?Q?hp0wY3iPc69ozKd6sM0jB5lqC6mMHi7fiiijjhylE79g?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E37C28C4B51AA46B225A58847A7BB35@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3328fce9-b93c-471b-baa4-08da98c9f71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2022 16:30:42.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKD/3EydKGgvcFhfJBgvMMqYc3Xs0cvrVwdRdHAn3NIkFAPnQPgQKf3PPqRY0ugiLZiRTWSYvbhdnAtwBgDTzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNS8yMDIyIDc6MzIgUE0sIExpIEppbmxpbiB3cm90ZToNCj4gU2luY2UgYmxrLWlvcHJp
byBoYW5kaW5nIHdhcyBjb252ZXJ0ZWQgZnJvbSBhIHJxb3MgcG9saWN5IHRvIGEgZGlyZWN0IGNh
bGwsDQo+IFJRX1FPU19JT1BSSU8gaXMgbm90IHVzZWQgYW55bW9yZSwganVzdCBkZWxldGUgaXQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBKaW5saW4gPGxpamlubGluM0BodWF3ZWkuY29tPg0K
Pg0KDQpQZXJoYXBzIG1lbnRpb24gYWJvdXQgd2hlbiBpdCB3YXMgcmVtb3ZlZC4NCg0KRWl0aGVy
IHdheSwNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==
