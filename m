Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0521E6DEB68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDLFn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDLFn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:43:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742C92139
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXtHxXn7/pchsXjaiRm9ujp5LkD1XCosv1qVXuzqEH+GNGill8qoJriSh4j+tmBlLp1AKDCypztZ8UujQD5qWn/PYFJo6W9bzKud/cmQIYcmoW6cW5glYLjexe+btwgWt4ODkx6AyXj8WnmYkUjioysEvpTMXfYgA2LJI3j6k6H8n4sQy18VCs3mMClAwhtc5TJXYlVG4r+p79YpZTzAuMnhRXlHosjthUoxtM2Q7yLgq1u/e2mpGFVCLL5dLQKMYSJkKS8k8dxTdPwBwSfvkGppD4ZssLzxEXzVH0sfNngziXW5WT7a8i+b4gnMOJzHeM5zTSMx2wMqI6aAZGMfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6U+obNgXE75xMm3TpljbgKTrxxwpyVkOaloHyelx9Go=;
 b=CV8ag/MDKFFH36ncV+92u/yOqyyDWShDfmAfglBRwLg3X6qHbcc9fGPOQqkGTVKSgR6MaDyVH4gmbw5ElGwwkSLAp8LcqAuiarwXb8uF8TEsqdSJUYDTIR6d2H9clj6pRe+rYy2wwZSTei8+7u8zWYDtndnjdZGvzx4CDzdcKiqozHFykSVnbi6PSiZ9a5DoWyef6WFylAbN6R7S4ElonI9t9zXLDNoHRu3/F8TwK31ZIUd7H57OLL13xl0FK17b3BWbEiS8/Ac2Pq+ZIEYTPLiz2kZkuhTqNzIna75aAKfJo+42+6xDraUYM44Y9xHprT0zyAIWUYbnilh1keh7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U+obNgXE75xMm3TpljbgKTrxxwpyVkOaloHyelx9Go=;
 b=iDWXyp40v5E5OkgumKuLUbs86vHmg84+H2xl66FJm+s+H1moNh8mbeZSQTEixrZzeuYxEocrtCHlbXSQS/Mccz4GFqRNzhlz4mmh+9uTomeEEu8ZCwXLcg7jppVWICnUpplyFGqVvbEsRoK8NX7LUi+WSmUFh4xfzdrWSMSEppT5K4j3zxvRA4so6DyO3MzegNaqVkmFzm8OKFJg1/PAo+S3AFUdD/7dKS7stWIOMIyc3PsF8NdhQBqh7bVGDXSYwRYpk/Ufy/XWdi4OjHRCik3SryWmbZ4mC5gumuuFcay18XsN5vpiSHzO/DxfoeuCjY8Tkr840spymw9/UYOUHQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 05:42:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 05:42:09 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "j-young.choi@samsung.com" <j-young.choi@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-integrity: add rq_integrity_payload_size helper
Thread-Topic: [PATCH 1/2] blk-integrity: add rq_integrity_payload_size helper
Thread-Index: AQHZbP7Co8vLUQDJDkye1nvZzRpZ2K8nKMiAgAAARYA=
Date:   Wed, 12 Apr 2023 05:42:09 +0000
Message-ID: <83fad2a2-5c31-b869-7e30-fb2182659518@nvidia.com>
References: <CGME20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
 <20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
 <91df2b07-02a2-d034-bd8b-a67c13ca085a@nvidia.com>
In-Reply-To: <91df2b07-02a2-d034-bd8b-a67c13ca085a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL0PR12MB4865:EE_
x-ms-office365-filtering-correlation-id: 296b02ca-e530-4ee6-15f2-08db3b18a87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MWdBmKOW4EUtGB6LMiAqD3lhBYH9leeC5D1NL1je7rhlhu8khOAOAZD3h4jC+Zo/Qiudcm63yEfD/sAHKcbWG0nXWBAWDxsz2gqQHEEmlMNxxZbblYlh128hsRM4ZovitK+5Vb5gl7VLuO7E8odPQw98iwBT/cnRSiKMcOSBTKLFFY8FkCFWBU63JfyMc39k/M1H78cQfJ22lgUwtKX+GU4Z1MFCDTLMWXEjV7bXWdfhq45tFUIGbdLBGcvIt7Tpa2uRRcvAIsgVaBv6eugg3Ylsr63yQs3hBoTi/9NjYYXSqYxL9bHgzg9eLT4YO5Es78tL8wecDRRcDqc+sOkPf7W+BqHZaAhLDiDfbOeKXvqi/2hW+/iNVOt8zEZT3eBayZ1HzjFHDSP9IZ7U0n4UU9FhSDCfDgvO9EqDw92yHBK/KKaUXb7yfuZEG3mJQg6JLpGccCWxqf6N9D9/XzKcadZl472vW0G8pyD1fyULipgb7YE/sZhjYI0fIRZ7HuciiIppcGLrBSJ1s/VuwjzjKS1NgXrFm0t6J5aG2Q3TbDmEo/vHjb0d9uLkggl8FR75JRqCLOIgkJ++/hL1dz9Mf7/bDfT+DY1tuHjfO1i0cqb3CPLOaZF95AKmYLCg4Irup9NGBdA5ISsO7CRiOu9y+NGdw73JjKFsnGUNSGu2QFld0Om38G78sfIqamO/Plzc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(316002)(41300700001)(6506007)(6512007)(122000001)(38100700002)(186003)(31696002)(86362001)(6486002)(71200400001)(38070700005)(2616005)(83380400001)(66446008)(66476007)(66556008)(64756008)(66946007)(110136005)(36756003)(478600001)(91956017)(76116006)(8676002)(8936002)(5660300002)(2906002)(31686004)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlBvWVhnazhSV2ZxYzJCdVFPaWtRZVMxNVM3ZEY4WnZ5alZsRjE4cmFCb3l1?=
 =?utf-8?B?bnVkNnYrZ282Ujh0b0IrQy9ZNWgxeHNjNEtmRHlyKzhqdTk0cE43cld0Wjc1?=
 =?utf-8?B?cXUwdjk3THdnbEJ4WWZCT1k0d2FTZE8venFLaStOWDg5UnovWWZMeHNxY1hH?=
 =?utf-8?B?OWl4R1RrR3U5cUlyUWJ5SW9tSTlUdnhxNjgrQ25Fc3dMeHhWY2puL0JFNDBT?=
 =?utf-8?B?UVIydTFBN0hSZFRHam1ta3V4azFVcC9YMjU4RUI5QmNpRVJYQ1hGRmZLSkVk?=
 =?utf-8?B?SWZMNzg3WUxZRjhZOG42QzNkLzZZaXgyZVMzNVpGSVlSYXZEQldmeW14NkIx?=
 =?utf-8?B?VU0xVUFYeSt4Y09xWFNFNTg3WVE1ekExUXBzTXdoWWtxUUJIWDB2RnJrdVUw?=
 =?utf-8?B?dkFWRnVqdFI1S1V1cG9sOThFTDRVVnJ6STdmOHlEbW5tVFZQSkI4QTYzWVkz?=
 =?utf-8?B?TDZpZnk0eUtmcWxldURmVUdiOTU3T0xsUlk5L09iNmlOQ1MzM1kzSmpyK2pv?=
 =?utf-8?B?VWhmM2VBSHladHBRL2xUUXRlOTd2TEUxSE82OGhZN09naHRmdDlZOWlhc0x6?=
 =?utf-8?B?d05xRlR0bVM4UkdlRXdpM3NBYU9oMzdGdHJvTjYwRHQ1TFkvS1p1YVJiOGh2?=
 =?utf-8?B?RmxsS3J5QUd0MzYzTUxJQlEvZHFtQUI4N1lBekMyU2xhNzBlTjB0Q2RsWWpm?=
 =?utf-8?B?U0RPTnVUZ09lcktqWGwyV3RYNzY4YnpFMTRLYlkrcGloekFoSmE5Q1RvQUht?=
 =?utf-8?B?NFV5VnYxelZHODJpRSszcUo2SEdoZkFUNGdsL2FUZVYwdUJ0VUIxbE9ZdmlK?=
 =?utf-8?B?NVZZdlE0aHQyRGFtbk1oeEl2YVRoODN6a1VyQmZqeWZsbURzd0tEM21QZjlC?=
 =?utf-8?B?bGpPTVJKU1I2QUlqSldRV2k3YjJYS1BhZTVmZHczbThTaU5RWlQvUlo0SUN2?=
 =?utf-8?B?M2I0WEFrc3pTNmNpWGdDeW5KNVdxM0RRekJpa00rci9pc3pCbm43cFRqSEtY?=
 =?utf-8?B?VCtMSnpIRC83TjZkZXpIS00wazV3VTdsdUlUd3ZqR2xhbTljQjYzbVY0UFpR?=
 =?utf-8?B?eWo4eVlJdUgvTWdGVTQ2UjBrNEUvL0RGRXRpV2dMUHY5bGkyWUtPMkVacnJh?=
 =?utf-8?B?VGIxaUJLVlM3dWhNYUZlSndFZFVNY2kwQ2hQZWgxQWhVRnhNU1BtU1VGRTQv?=
 =?utf-8?B?LzZzOHhOQS84OHNUbVF0QlVtUERteDFKVEhISjJSaGtLOVdJZ1EvZGNqTEVY?=
 =?utf-8?B?cm9Ec3ZMRUJWZUFOU3d4OFJLOTl0NFQwaUdiNnpTRTNjVmprOGRFTVF1Rlcw?=
 =?utf-8?B?WnZuanVnWGJBZm5QekVreUpyNldZYW5GZGRVSXFhcWVZakVOZDgwTHRrQksr?=
 =?utf-8?B?V3VpaXhlZWs3R3ZrQXNJVHZ6K24rR0VOZk9yMTB1VUtOb0pCRmdZQXFhK045?=
 =?utf-8?B?NmpremdxS2FGd1l1eGV3OXN1T21VdlBJY2lxdVVmZlJjbG1vdURTM1c4MFA2?=
 =?utf-8?B?Rmt1azF2SkZiMWE2QVR4NGtJdE1yeEt0Qk94ZThwdGJsUngrdHVFbnBNaTBJ?=
 =?utf-8?B?YlE4bjMxVlZMN1NuOG01WndGTlBBYzFqRVJiNDZvbWRFOGliYWZVWlNIS2ZS?=
 =?utf-8?B?QWpWZWNRVk9GWHhpYjdJMzMvUVE2ZDJ6V1ZrTjc3SlpsOG04R0NyUUlzZmdI?=
 =?utf-8?B?bXJrdnBLYXhOa1AxK1ljeVhYSC9lenNFUFQwNmErRHlqZkVDWHQwYjhrMTlE?=
 =?utf-8?B?Y1RyT2k1ckdNemtyeksvelpselQ4RDF0UlhUbW9JSDEvTzNrNkIyclcvL2FW?=
 =?utf-8?B?K2xRVWcxZ1BhcSs1am5MVmtsYkR4Mnd4WFkzbzdVMDVWRTdDdG9mRXIwWkNl?=
 =?utf-8?B?U2R6aDlOK1hKajN1eE1vd1BRQXZqTUltcEUrcmpNdDd0eDN3Q0djUzZwMTBw?=
 =?utf-8?B?djJlWFF2ZW1LU09GSVRZaE5pdE90NXVqTWprc3RMTi9DR3dOcmcxY2h5enZl?=
 =?utf-8?B?dkl0SE4vZGZoWHBwV3RWbk53ZkhzWnBKSGUyNjBWd3VxMmVzc3FQdERscktt?=
 =?utf-8?B?Mi96YjFEK1dDb3NJbis3cFIxaXAwUllhWVZ4bzl3NmZhV3ovd3B3aVlMVllL?=
 =?utf-8?B?Um95OFp4U1NDbHhDbGJlSkhaZ2padTh5S1BJWEoyaUhLSnFvWW42WVZkZXRt?=
 =?utf-8?Q?7yrHThtE0mUOfJbIxQEtnIYa++60HP0Fma1jfOkTL2e/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD50DD5B94F70C45983A82B4CEAC8EA0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296b02ca-e530-4ee6-15f2-08db3b18a87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 05:42:09.5007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpBrHx2AIfpU4W8h57pYju4j5areIUxGGHGoXpqGzfwAPfgZM2+0DLxaYezDY7V2mnMWZi+cdOmvJsItEqUk+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiArDQo+PiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgcnFfaW50ZWdyaXR5X3BheWxv
YWRfc2l6ZShzdHJ1Y3QgcmVxdWVzdCANCj4+ICpycSkNCj4+ICt7DQo+PiArwqDCoMKgIGlmIChX
QVJOX09OX09OQ0UocXVldWVfbWF4X2ludGVncml0eV9zZWdtZW50cyhycS0+cSkgPiAxKSkNCj4+
ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+ICvCoMKgwqAgcmV0dXJuIHJxLT5iaW8tPmJp
X2ludGVncml0eS0+YmlwX2l0ZXIuYmlfc2l6ZTsNCj4+ICt9DQo+PiDCoCAjZWxzZSAvKiBDT05G
SUdfQkxLX0RFVl9JTlRFR1JJVFkgKi8NCj4+IMKgIHN0YXRpYyBpbmxpbmUgaW50IGJsa19ycV9j
b3VudF9pbnRlZ3JpdHlfc2coc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYmlvICpiKQ0K
Pg0KPiBmcm9tIHRoZSBjb21tZW50cyB0aGF0IEkgZ290IGluIHRoZSBwYXN0LCB5b3Ugc2hvdWxk
IG9ubHkgYmUgYWRkaW5nDQo+IGEgaGVscGVyIGluIHRoZSBwYXRjaCB0aGF0IGlzIGFjdHVhbGx5
IHVzaW5nIGl0Lg0KPg0KPiAtY2sNCj4NCj4NCg0KZGlzcmVnYXJkIG15IGNvbW1lbnQsIEkgdGhp
bmsgdGhpcyBpcyBjb3JyZWN0IGxvb2tpbmcgYXQgdGhlIG5leHQgcGF0Y2guLi4NCg0KLWNrDQoN
Cg0K
