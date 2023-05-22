Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD12D70B8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjEVJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjEVJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:31:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FB79D;
        Mon, 22 May 2023 02:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw3cEjI18PBKMYCDYQ9f/PoVpPyyjGkzbZseAx+pMFezoNYuZUYwaERV1KDff1wBI7jsuSs1vL1TF3dvgynWArnCuTmUpwdIPahObB0+Djbytdc3oTkpRiNBVrlKB3MAUQPXHJGw35ouP5XUkaxDv6LosiAl7rPsLiKk6Oi92PqvkGgqyMX8FP3I4JCH4X9ew7ufWlvq8bvdILSkDVtHkgvdQvNDaxWsatBLggFVusMGUIqhGkFK/r4OqTDpLZ6j2QMM5NycWnrBySEwTl4/uJlZEucLwee8naJdvYNN4W6IHMnH5gsCSZ2y6wm9yvP5JDMNwLPm2+5C3uMoZpD8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBNkvb0PJje1j09YWemOKgc6444MZG+SUNwuaJ6mPik=;
 b=MEu0b+FH3KBNrJ+ZXLcsfOJflto+LphQwcnaDPnIGDByNQfER88sjf/W3JCCsmuVCL7f5EptzMtujRbMbbs56SWUGNdb00ZeVIwkIL6WNeOvq8GzJe6v0azzvhYtKeghpsvvWQXB80K7MfPJYmMkOv3jm9ZGbc/MSemGRbQ3yrkwSGxX3kfdGWSMzwiXyQe/X3Oiw1RX06+BentM4DMy9N2PVhxMSKY3/UTyv+N0hOf+RRpPdLlohIsTUkGj3LemdEdvt8Y+2l85x8V31RlaYJHQltBUJWruiiVtphyEoiVA3LfSeqr8pP0j/tqXPBreyIcqBRMicN3w3MA5Gb7paA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBNkvb0PJje1j09YWemOKgc6444MZG+SUNwuaJ6mPik=;
 b=MmsvAX5jbQt1/FO3GQup95tObo2JEBj5IoNY0E2B2FCijtkTUHP+8gmUo4I6i/syrH3jVHGLjNVhJbSw2rEXpLoc1S9f5jrumopdOiMHJcHrsUNtSlveT/C4crSlAmd0WW6DveuSP3+d3EZzc8kUeFra+PSecioHFX+6Th+kM3zFGMiCvMZejpFRfw92EWkFdW+MYbh9mxnkFWR8mv/SexTuZL4HOYExY88up2oRj63GANgf6ycIU1GseFekxNPU3cgOQr0nBJ0zdSO09uZ0qL4O6ZYu7uZoVtfx6CcdBECj2gAp6PZ+0SGOyvYJ/5I3aBVHnKo9lOv4JVyfewsazg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:31:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:31:55 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linan666@huaweicloud.com" <linan666@huaweicloud.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linan122@huawei.com" <linan122@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH] block: remove redundant req_op in blk_rq_is_passthrough
Thread-Topic: [PATCH] block: remove redundant req_op in blk_rq_is_passthrough
Thread-Index: AQHZjItI5ctRbN0MoUKxX/1FPIxTvq9mB2YA
Date:   Mon, 22 May 2023 09:31:54 +0000
Message-ID: <41a739cb-1d17-3713-0648-1f91e2267cbc@nvidia.com>
References: <20230522085355.1740772-1-linan666@huaweicloud.com>
In-Reply-To: <20230522085355.1740772-1-linan666@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA0PR12MB4366:EE_
x-ms-office365-filtering-correlation-id: 00f31260-a8b2-4314-c82f-08db5aa761c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ty8BFR4JYKoXBdSE47TYgTE9x36U0efDPlEXXuyXHzKtidNysmDuA8FVP1nhJPNOiDAm8pplAj/v8xlzSEGoCTm4aw00UFg7bYtn5tSq3J9EJtudpOKFNnXHhrE2k6tU0UGvALMX2wS9PmtDFtsC3p1CEzId+WDTX+Nx9mg/Lpfq5rAvsPI+wAB47ej1r5bssrPEOTg/W0CHi9ukrOtVXQNXF6ZOP5kWGMEgUO3/MTuz278yiZzITREGzTRM30pjBK+sjDkBcM3uHgzWlVWRWiOgWQa8aX9CDIJvEvfQNunmsmsjoU3RkRT99d1MRFBZc442HvDI9wi1Kyt0cX85rmrXJstzR63ipMHKBxlj6MIQ5NFQM9hDv04jJjdneiw+UaP2yp55wBcwrb+GGCLyCiCuZMa2QRpWpO6MvQH30H+TmMV0Eu068/lGJTuo0W6AWnqmlRcuq66dOgvN8ZqBvOrVnyVuiHAnTFe66cNY3DsvSV6ABINX710uekeghTueb0UEMcsx6H46sMmRPlfDeVASgZ7rYYVZnH5fHusA1A5sLITUK0nF4acY+hJRudh3P0CoyiINtXrA6cvLnh1BXAJrE+Xf846JwvXQOIM+jsD8CUCqYxdvZtY7B7zykPpQ/DMxCQQKf/OD/MVIhTtc60BikIrxWKQKnZDS6HNMNGk3cg4l0jPfP5mEfuWb9zhxLMt0YAWH+XJOugL6D5oE3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(478600001)(31686004)(54906003)(110136005)(71200400001)(66446008)(66476007)(5660300002)(26005)(41300700001)(6486002)(186003)(316002)(4326008)(64756008)(6512007)(6506007)(8936002)(8676002)(53546011)(2906002)(2616005)(83380400001)(66946007)(91956017)(76116006)(66556008)(122000001)(38100700002)(38070700005)(36756003)(31696002)(86362001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3pXOE1ERDg0M0RFZ3A3aEcrVlNVRXZwYWo0c3RYcFlyaEhVK3NSdFpocjZI?=
 =?utf-8?B?UXlYb1l6bDZ0RjBleFRXNWVEU3JFZ3Z2NjBtMXI2cXNpOC94L3d3T0Zhd0NY?=
 =?utf-8?B?TE1zckpCNzBOU0NzYjAzd3A3UFpvZ3RaR0xBbUVuKzFjZVNnMGFIUmxkSEpy?=
 =?utf-8?B?NEw3anozQ3lFSVF0V0VZaDB6azdwVGx0YTA1aHZpSVhEZUc3S2kyeTZBUERW?=
 =?utf-8?B?VGs0ZzBRM216bGhsdFFiRHJhQWwvMjZKVTkzL3l6c1FRQkQyNFdzMDczTHBz?=
 =?utf-8?B?UlFNNlVsa05kUVNMT0dwbzYwWU9TdHVEaERyNUJNOWxITnA2YXVBZi8vQ2la?=
 =?utf-8?B?VzJGdUFQUHArT0FZYTh4WlpkYnZGZk44NlF1YlU2UkwzMTRnWEZiQ21KeFpW?=
 =?utf-8?B?MzhIM3BjNkozS2hsMmhEb3Y5d2l6WTc4eldmb1ZOejBVSVhVNmxacXZjZlNw?=
 =?utf-8?B?L0RkRXc4YnE4VWhmbXc1bTl0T2hTdEw2T0QzSjFXR0VmQ1pmN1dLbDhqdEtv?=
 =?utf-8?B?cGJDZjZmd0p5QU9CREQrWVI3czVUTmdlWGlDWFlKck0rTG9zUFN5N2NlZEQy?=
 =?utf-8?B?ZnJTcWlCSjg3K3dnNTU1ekIyZGowSlBNNDFFQ1dvVDBYSVQ4OGxHdCtyQ2sw?=
 =?utf-8?B?ektJNjFmaFdkTHdxTDhycXJOMVlpYlVjZ21NMnN5RkdqWEtyWkd4NEwraTRG?=
 =?utf-8?B?dWhVYXlHT29xTzQ2TStSU0h0bFlYOHlwR1ljWlMxNnZYdThVSXVQSzk0YlZS?=
 =?utf-8?B?N3ZLVmcrM1VqeDNTQ2FYVHdXUHljSzRnTzJ1d1RNUmFTMjJzWGpoSWZSNkxL?=
 =?utf-8?B?eW9jYVVXcWd4Nkdkd3hPZktaL3J5THNNakd3cWphdG9IQXlhQTdvNmZtZkFl?=
 =?utf-8?B?NFhNWElYVTZOTmRlTzl6S3Z4WDlMRDJxc05OaFlLa3RnMVhIbUdxSzJXc0tp?=
 =?utf-8?B?RkQ3UVg2aVZQVU9MMlJpZFh0bXJITk9leDk5VG1hcGFrSC9Id2F2NkJsWk1H?=
 =?utf-8?B?ZnEzQ01Vc0FuS3VWcEQvQnFGWjY3Rk9Lak1pTS9VYXdqTGhPRysvcUhLcWdi?=
 =?utf-8?B?bWdBTS91UnZ6bDEveUFwbTRMbm9mYW1rQ0NDNDlMMlZMamRLcjIzRUhSLzRj?=
 =?utf-8?B?K29XVXgyOVRRYkVCM205YndNeGwwdFhGSjdLTWhIbTI3WGJFdTVmMnJ0VnFE?=
 =?utf-8?B?U21tTzlHSE5RVFRuR2tMQ012eWgxOW12OVRaQkVmTHdVREF1dUhKeHFVY3BW?=
 =?utf-8?B?ZGUyaEpJbVVyT0ozeVhqMUs1a1BYbklVc1ZEcHRFbjJRelo1TFgzeURqTStS?=
 =?utf-8?B?VmdJVklzdFdJcDJsbmlaSmlLVEtzLzRyajJCUUE5enBWQ21QTzBhVnZmMFNt?=
 =?utf-8?B?Tjc2aHBQbWRhekxCbS93V3Z0WFdMUXdOcDBuaVRwTjZxemNuRS9xREI5Q3My?=
 =?utf-8?B?VS8rSzVxcW9odkhrNHllY2xLUEFWaHByVmFXV2tyY2dML0ZLNXd3dWphL2Ru?=
 =?utf-8?B?Tks0S3A0RktwaTVKZ0RobVBvVzN5YmZpS2QzWGR5aFVGWEdRaEg2R1A4aDRJ?=
 =?utf-8?B?eWZkbkNoV0gxYmNmTE9OZGJBVFA5Y0RHYjByQ2p5ZkFaTTkwM25HbkYwZ3RN?=
 =?utf-8?B?SVh5ZFRXdlhBSkVxY2FGdi9sak5UNFhqYmJKL0NBTzhuY1Zldi9aSUVoVjhF?=
 =?utf-8?B?MEVWeUdhOFM1ekpSQlhvU1dzWEZkMkIxbnFQbGl3ZzZoTU5Pa21VZEVDc0FF?=
 =?utf-8?B?L2daOGtSUzcwYkNOckh5cVhlbThYNFpBWkFLcDE3MERhZlpNYVZ0RDgzS01Y?=
 =?utf-8?B?UmRaVFc3dFYvNEtIRVJ2WjgyQjlUVFlLbUtZV0QrUDZpODBJQkJzN2crY3RH?=
 =?utf-8?B?YzhRSHRsQ29yenNFS0hEeENrVzRPM0VoMS9HZWIrT1R1WDl4SDh4Z05ueDB5?=
 =?utf-8?B?QVFZMHJDWkxyMGdCd3hzUlBGQWtoWWMyUVhabFVRWU92SWYxUFp4N3J0TGNI?=
 =?utf-8?B?dHJWWDc2bTVYbkUvbUNFOElIR2hyazBRNkZ6TzQrK3A1dU50cldiMHN5NXVZ?=
 =?utf-8?B?M2pLZWZtS28ra0xiRG1JVmdGMG05UDRjS2cyS0IwclgzY0t6cml3VExiNWVY?=
 =?utf-8?Q?dfdZtW0eU4FCV8+EpbiwL8i0e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13B6314EF3FD6742A19BB4D72775E0B1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f31260-a8b2-4314-c82f-08db5aa761c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 09:31:54.9056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20jUCv90aAtbHEFBucW2R1P/tL0Am9Jg1iOESRhTMcc58pt+xVv+o5oTkHtKqeseFFUZlIyRTvChHyMZeqtstQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMi8yMyAwMTo1MywgbGluYW42NjZAaHVhd2VpY2xvdWQuY29tIHdyb3RlOg0KPiBGcm9t
OiBMaSBOYW4gPGxpbmFuMTIyQGh1YXdlaS5jb20+DQo+DQo+IG9wICY9IFJFUV9PUF9NQVNLIGlu
IGJsa19vcF9pc19wYXNzdGhyb3VnaCgpIGlzIGV4YWN0bHkgd2hhdCByZXFfb3AoKSBkby4NCj4g
VGhlcmVmb3JlLCBpdCBpcyByZWR1bmRhbnQgdG8gY2FsbCByZXFfb3AoKSBmb3IgYmxrX29wX2lz
X3Bhc3N0aHJvdWdoKCkuDQoNCkkgY291bGRuJ3QgdW5kZXJzdGFuZCBjb21taXQgbG9nLCBmZWVs
IGZyZWUgdG8gaWdub3JlIGZvbGxvd2luZw0KaWYgb3RoZXJzIGFyZSBva2F5IHdpdGggaXQgOi0N
Cg0KcmVxX29wKCkgcmV0dXJucyB0aGUgUkVRX09QX1hYWCB3aXRoIHJlcS0+Y21kX2ZsYWdzICYg
UkVRX09QX01BU0tTLg0KDQpibGtfb3BfaXNfcGFzc3RocnVnaCgpIG1hc2tzIG9wIHdpdGggUkVR
X09QX01BU0tTIHRvIGNvbXBhcmUNClJFUV9PUF9YWFggd2l0aCBwYXNzdGhyb3VnaCByZXF1ZXN0
cyBSRVFfT1BfSU4vUkVRX09QX09VVC4NCiDCoDI0NQ0KIMKgMjQ2IHN0YXRpYyBpbmxpbmUgYm9v
bCBibGtfb3BfaXNfcGFzc3Rocm91Z2goYmxrX29wZl90IG9wKQ0KIMKgMjQ3IHsNCiDCoDI0OMKg
wqDCoMKgwqDCoMKgwqAgb3AgJj0gUkVRX09QX01BU0s7DQogwqAyNDnCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBvcCA9PSBSRVFfT1BfRFJWX0lOIHx8IG9wID09IFJFUV9PUF9EUlZfT1VUOw0KIMKg
MjUwIH0NCiDCoDI1MQ0KDQpQYXNzaW5nIHJlcV9vcChycSkgYXJndW1lbnQgdG8gYmxrX29wX2lz
X3Bhc3N0aHJ1KCkgcmVzdWx0cyBpbiBkb3VibGUNCm1hc2tpbmcgb2YgcmVxdWVzdCBmbGFncyBm
aXJzdCBpbiByZXFfb3AoKSBhbmQgYWdhaW4gaW4NCmJsa19vcF9pc19wYXNzdGhyb3VnaCgpLg0K
DQpBdm9pZCB0aGF0IGJ5IHBhc3NpbmcgcmVxLT5jbWRfZmxhZ3MgaW5zdGVhZCBvZiByZXFfb3Ao
cmVxKSBhcw0KYW4gYXJndW1lbnQgdG8gYmxrX29wX2lzX3Bhc3N0aHJvdWdoKCkgd2hlbiBpdCBp
cyBjYWxsZWQgZnJvbQ0KYmxrX3JxX2lzX3Bhc3N0aHJ1b3VnaCgpLg0KDQoNCmlycmVzcGVjdGl2
ZSBvZiBhYm92ZSBzdWdnZXN0aW9uLCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
