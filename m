Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF636290F7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiKODtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiKODtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:49:39 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C437EE1B;
        Mon, 14 Nov 2022 19:49:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djlGHK1p+J8dQ0qfp95Ws9BjU4xqH8BGAKOyt2M/BBwwOFCcOh9x5VupCkZowxERPE1PxCRVPnCYjpG+g1dU1P5TgF1DEID7+zxNcBmgkX1oz7YG3+0MbefRqTtQeL+i2oGK9TI8k4OMwgNmje/v+FIt2SJjVEMCN9kESHTROYmOh1gbGWqwhHpQlO97ttFn1HBZtxj5n7M6b5auk03//kFbsLbE/+X0UGm5OPTcXdUl1cStgdtnT5CtnRLiuawE+JHNZAdEDdyQTVsD0sICJRPEcNaglf/sHOUUKbWxBeBsb8DM368Pxy+8E02Zg2dTARFFCYTYzVSRALna2wnxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS9B7wxuAhQoIv4S2JclC3+9m6hWPeiEx1kqOdLWZxk=;
 b=OzOYSvR6Nw1wvDmlFd4R65w71oyHfuDjJXPm0eZRNA/cDE3oTIMYBDet6/hC1F5jAVJFXedu5HiBVSYgn0lQYV/SITdW3v6DfD0wwBF0SMwlEfNEIqHW2zsUGXytNudFwXIKnDYE+DZwQhv6YCN/GjA92/eFNOOb3lPBkNcR4U2vEZILDc/UdzTcDbtgRIzgec19NjNTmxeoGOgeWU2n2g16jc0Qn+IE+Ap8jKKF5iT2DtCq3AZ+CH9tH+SAq3k+4kSMueTiXIjr5jTB0eZQaYWfRf3tin8n7EYA0tnHGk2WeuRbwt8T1wnJvEkbUkNprvSaDOaObTAvLfksn5XVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS9B7wxuAhQoIv4S2JclC3+9m6hWPeiEx1kqOdLWZxk=;
 b=FrbfALLk7zE7umyuHCO7ZDB/jpyxij1lPSsC65XOzL3cw3zihZqBdvXycm5TQAOv06tYNHhA/RwWUg9MumvoYU0jaoTieXELnufQZDN8SFUioeffq/9KywQd+DCG6CjtnzQ0TzyL+SLdzheRHrpriYZ6JEAyHRZzb6tRfCRl6B/zE4bFroouQhnrFm/752L3V2t1iW5yiqFYgBY9uG9c8+CJchxUV5vjAIsL7hFVVg98Xymvk2QqaFkzawcwFjUlUEChkmJujRKT5QzB8hoWHiySDrHeeFbJH5jXQg3zEOVYXsOHCghGpmnrJJkgPx6eeLhn4o0G9GuPcW5685ujQA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Tue, 15 Nov
 2022 03:49:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:49:35 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH V2 4/7] null_blk: don't use magic numbers in the code
Thread-Topic: [PATCH V2 4/7] null_blk: don't use magic numbers in the code
Thread-Index: AQHY2TJ1xH49Ed40BkazSiu/xoMjeK4/Y00AgAA024A=
Date:   Tue, 15 Nov 2022 03:49:35 +0000
Message-ID: <f563e7d4-6409-5571-9cba-045c1e42d5f9@nvidia.com>
References: <20221006031829.37741-1-kch@nvidia.com>
 <20221006031829.37741-5-kch@nvidia.com>
 <475fba10-c471-4922-91d5-3b84c4cce149@acm.org>
In-Reply-To: <475fba10-c471-4922-91d5-3b84c4cce149@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6600:EE_
x-ms-office365-filtering-correlation-id: 5efeb463-67f2-474e-df24-08dac6bc69da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /x7JL6bGh0Sf6UYwlbZOunYgw4shZiVCKYoAB9EasSIJXDymeP7dDQV4E+anz72Ae1rcF4MHa/ZVOOeGjAG/z3I4wAF+ezeYw/n95NaEw6qMHKjY75Gq+w4scIMV3Q9to9IBUw5k9d7aeye9DTWEA0MY4oixFxO5gyvQUqFso9UXYqel0bYtCPCTJbtY3+sPlWWLZvt/BiX+fR8JoYrT0/YcuxM016jD0ooRbyYcEVQOvZ6brO3qmc7z/InW5xJPPD5Tmr1To3rwlcryFMREqFr2eemws5uj1BNCQi0QPT4JxCUjAh8dKUyBNwlxhKs+HIiFa0/ZfWWK7lU/qQ+fP8qcYJ1oy+3zfsJ5a1xuCvA+qNAIK+jJlddlodNqDIggvTPyVm7wQCG8ME/nEhluyvQf3K5zQspEZ0f+fcqM7iWCbWl8IzqZVRIAYTwWdktPMKZZebFxONMemmw6DnVi2jGbqooGIZX3XbrNG0itIPnIbJfdcd8oQGDrVO0xMlwhjS4lkkVBvRChNGxTNfa4CmvPBLyr9SwrVA+Te3QkfyC/2yo3tUKaBKYypmRTitM9CZzLybHwtQkVZp9B6N4EEdpNrC7ORMQZc6Jw81qj1pGOikf5ygjrELA1FEu6bA/C9Or5z2c/mhyNYsl2gTggIY/Hp9tbS7ZJvmewSSuYwjR7ukzzB9OzzXKV9qw86CxsdJN/YrX8+Yh23drIXM7tD2/XNM+BAV8kJapg8FPpY/cxI61WbH29+hzvwN9dIXnmMBAxDa6Hol9lXqvbKYUD6OYfgb/CqqbhRCWAWK3jffMpqHgwc9YR644lEU9DF8Uiz45NITr4zOWDfBbRpPLnJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(31696002)(86362001)(66446008)(38070700005)(2906002)(4744005)(38100700002)(8936002)(4326008)(7416002)(53546011)(316002)(66476007)(66556008)(64756008)(122000001)(41300700001)(5660300002)(8676002)(66946007)(76116006)(6512007)(71200400001)(6506007)(186003)(110136005)(6486002)(478600001)(2616005)(36756003)(54906003)(91956017)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHFCR0tuZ3A1dlJTOHB2SzZhc3d6MG42QW5vSzhBd3NwcXdvWlBpVlc5L0p1?=
 =?utf-8?B?ckVVRys1ZVBUVEN3eDdZMVVXTnNVVmh3OGwxUG5tcHV1VnpXRy9nMmc0VEhm?=
 =?utf-8?B?TXM3bVR2aXZkVzRTM2U3bit4c0JBSW14a2JwemgvM3RJeVJLc2Q0T3NVNEZ2?=
 =?utf-8?B?VnlRdkFjS2FPTWFBejR4aFVod3JPeFpJNG1kZjBTUFhPSjhCZTNnZWV4VDlU?=
 =?utf-8?B?QXdwMHAzdTBFSGpVWXByRFBBYWduTVRrTFhNV1BzcEZEYVJjRE1DVWtkUGls?=
 =?utf-8?B?bkJaWlNMbDlRay83V0NMYWpXdzYxc3VNT2ZBL2tJTUFtZjJxcDMvTW5OWUhp?=
 =?utf-8?B?dlA1clNiZVRNVkRpanBFaURyZldUYS8wRDEzbXVYSm5tbWFZdkhqTlVtaUN5?=
 =?utf-8?B?TjFsajRzUlNKRjZ4WGNoYnRETjBSc1pCdERFQlBEMEROMllFbDN1TlJsUUVW?=
 =?utf-8?B?K3hSNUZPdXNIL01CSW1ubnNKV0N2YnAxWm1tV0c0WHdML0V4S3JXQW0zdzJU?=
 =?utf-8?B?N2ROWEJJY1VacnZKNlBoeW1KalFhZEx0bmVVY0VYN282U1IxQWNwTXlJSXVS?=
 =?utf-8?B?eFBwUE1kTG05cWNXQ1ZEaC9LYS95U1ZSQzl0ZUhWWlZmaFYzRnFVdGRYb1gr?=
 =?utf-8?B?S3dWYmh1UmV6T3BHRWRMNHNTUFFXaUpYaWNnSlVFdHdTVWNxVklBNm9Fbk5j?=
 =?utf-8?B?RGlrSjdrcytwaHdTS2F0SFphTzRwb25pSi9tRkgzaTBYYWNWNENiMVZSNzVq?=
 =?utf-8?B?NWtSSFYrR3JQOGJPSVpaSnQ3UCszWDJUMEJPRXlFUnJIdCtkdWRHSzk0R0xX?=
 =?utf-8?B?Z2ZEbDQ4UDFuMG9ReTFvWHoxZFR4SmZ2MFdhb2tzUTd2N2tGcEcycGh0QThx?=
 =?utf-8?B?K0V2Q1AxckVGLzdLamwzZU56WGExbmhXWC9tdHN0TFA4d2xJSTdrU0tFK285?=
 =?utf-8?B?Z2lDNHZ6OFV3alZDc3Jucm0vVGlaeE52WHh4ZXQrMkFaTGVOM2g4eDVBODZy?=
 =?utf-8?B?YndjZThGd1V6Vk1SRndPVGhWd2xUQXduaWVRRG5ydGVoWDNQNE16OWZZbjVY?=
 =?utf-8?B?UVUxYmd4OVNsZnNrSDAyeEFzUGYzN1Fva1NYYUhDcUVJUVhaMkl0YWhuWVd1?=
 =?utf-8?B?QThYdlFVYkJ2c1grVVRhanh5dDBIb0RvMkJPb05rREtaRU1NcFQxZTUyR2t1?=
 =?utf-8?B?ZjZnaHljQkpPcU5rL0t6cVR2MFZqejNpck1XbXBMZjV3bkdROXJ1VU5KSjBF?=
 =?utf-8?B?RURKYWNJRzRZN2c1QTNHeFF0cEZyMlBDSUsvcThxR2VqYWt0Y2NSbCtPVnEz?=
 =?utf-8?B?bE9PcFZmWE8rSmppWi9UWjRPemMxeFY4bU5pSUFvV0lONzRCWGJPLytnTkQr?=
 =?utf-8?B?SXZYK0JRRTd6VGtGRXZGYzN3anpWbmpkUVJBVkt1R2g5K0FxWDFvWjd2UUJP?=
 =?utf-8?B?eENIZEhISUVqbHpOM29PTWFpSERnTTZaM3owc1d3Ym5MMklKZ280ZmVuMXRC?=
 =?utf-8?B?RWxpWmU2M1RJREVNYWllbU9NV0RQeEhOQkVUeVZmbERXTmRSNlkyV0pKckFK?=
 =?utf-8?B?bDVFZWpyYi9DaXBOVEVsTXQvaXVteG9JRllOVUd3TEQya2dnQzJmdHpUbjFm?=
 =?utf-8?B?Y3R4REhNaXB3NjRrSHRMbE1mOENvUmhIM2NHZTNsZG5hbitINzd4OVZtNVl2?=
 =?utf-8?B?Q2NJTnFxWnFnZnFmUHkrRnh6YTFZVXZyMFBXRlJscUJDT0JLK2IvbkJjcWY1?=
 =?utf-8?B?Qm16dlovNU5CU21vLzFyRHlMLzdzb01IOGwrbFFpR05xQ2grUUYzczNVTzF4?=
 =?utf-8?B?SFZIZ0ZiTVRtbEFlS2EvV3hSdzl3NlBDczQ3TTdGQVY2NnQraUlTTTJua3RW?=
 =?utf-8?B?Y3NRV2pBeGR4OFdaTGwrNnJqdk5KTlhNWUVXZ29TNExHcXBlRmxIZ0hNOHZM?=
 =?utf-8?B?MTlFTUlNU01YdTJPT0hLZ3M5ZXBzS00yRXhMVTlpL3VwMGI2bWpIRjhWbnJS?=
 =?utf-8?B?N3dHRXZJTk5aZDd4SFoyUWZtRzIzYnpESitaN0tLRTJ0a3ZyWlNsL3NRM3lq?=
 =?utf-8?B?ZlE3UytjU1M3dE82ZnJmTkU5VGJXdkNjMS9QTWM4bFZ3SzVVNnpwbjhZYWRp?=
 =?utf-8?B?bzlsOVdla2M0VTlvMUhrZXRVOFlVUEpOMis0Umt5bFkxbkdacVlMSEErcytP?=
 =?utf-8?Q?jdZGp5fBHnBpZwi5HdWfhmxnChM9NRLGqAbBTUoAH9qL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <626836767FBCF747A9A1671CB63EEC4D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efeb463-67f2-474e-df24-08dac6bc69da
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:49:35.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGfken+Ft0SiwXTMcm0IZBEQKdhft1JFjqH6I8lw6qWQD+Hn/WAUWH+j+vGER0Pct+sGcYhCEUcJLYiZAvE/Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTQvMjIgMTY6NDAsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gMTAvNS8yMiAy
MDoxOCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gSW5zdGVhc2Qgb2YgdXNpbmcgdGhl
IGhhcmRjb2RlZCB2YWx1ZSB1c2UgbWVhbmluZ2Z1bCBtYWNybyBmb3IgdGFnDQo+IA0KPiBJbnN0
ZWFzZCAtPiBJbnN0ZWFkPw0KPiANCj4+IGF2YWlsYWJsZSB2YWx1ZSBvZiAtMVUgaW4gZ2V0X3Rh
ZygpIGFuZCBfX2FsbG9jX2NtZCgpLg0KPj4NCj4+IFdoaWxlIGF0IGl0IHJldHVybiBlYXJseSBv
biBlcnJvciB0byBnZXQgcmlkIG9mIHRoZSBleHRyYSBpbmRlbnRhdGlvbg0KPj4gaW4gX19hbGxv
Y19jbWQoKS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJhcnQuDQo+IA0KDQp0aGFua3MgZm9yIHlv
dXIgY29tbWVudCBCYXJ0LCBJJ2xsIHNlbmQgb3V0IFYzIHdpdGggZml4ZXMuLg0KDQotY2sNCg0K
