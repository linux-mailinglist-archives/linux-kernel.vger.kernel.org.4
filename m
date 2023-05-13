Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E15701626
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbjEMK1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEMK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:27:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E84A2707;
        Sat, 13 May 2023 03:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTC6npGeGTg8J8WPRv4dXs2xrPYWsh8rCiqMOBEQWRNy8DtLwCFD5VSxflswhxI8HEqKy1ewuw3LHGfqwPLVYTVWwtnn+Toy02QsTHsY9F3LcSsog/SVv6OZHIqP1TVkcIsM1C0aF8W9+kg7IOCcBJFQIDpORm6BcMUU4efuyGbL8nrHxSCOujb4IFdz+5QHiSMgPA2OBmfOpm8SYAU61YzqtfoJc0Hnj18qhzU2gtNo3yFjAQs+YzKrfBeeBT+90o+9TAUDiarQ0YjjEFj9uzSePSPWGuUbMt3ZmYcSOjaTOkICCk+o+aBXZ72V9fyC3ZnZ11MFGresjocSdc2ROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJnrdhMxKqyLuxRcLrXAxzpbSeL3hOmdj2AKDL65fwE=;
 b=fnpzQ6m6Qdn7GDv4Qoxb76RviKQSvoBHRX6vy3nFi0/wLLjZuNjcg9tChvaaIw4IY35Giyv7lO8I2hccVfCouehgbO0OIx0BGL0OLWTUCtWniA2fjJnWVX76oz2VpAckQKEcNuKO4zeo2eycOtNvzIfv9NeMJRWP83Nu7b5VO8IlnLd+HWuVYYNNxXB1NGtsRy507tEY7hXw6O907I2UqixSId3VTIlHeetWKaWoRTMXcfiufXMAIbLrZYbV3+uw2v2gxjsR39IsWRha4Ot7JME/YmasR595IkF4sazyoshCTJ8uZrzTvGp/2Ad85IzyZua/49kJtwHNaOq9dLVMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJnrdhMxKqyLuxRcLrXAxzpbSeL3hOmdj2AKDL65fwE=;
 b=kPG/4+ghiSZGvsUFn5Lpica4Ytsb3ABL4MA5c+5eC1/dw2W+bDP63qivmbUM+7odJPf57FLRbQ08vqexG+V0w6V6cuQaWu0nBwZI0wRi8oYi7otW3VgIwh/WUVU5tYeqtoSW0oAi+9rLUHMTpBvOVFWEpYPRpl0Ky7DjwwiBaJAkHD1pHL+FVfPxmTxKqmiW8ARa/bS1MBugdYNxFN14zG/pX6h2vdU8w9dMkC1Y4PTMVl18QZuFqvrqFzdDOwdUwEV983eY8lf3OU7TsY+usprLREjuHWRFAQUh6hBSOppmW8cCM7Ktjbil7a8y1U3nLh3ZGY5CbpnJIskztWI2ug==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB5502.namprd12.prod.outlook.com (2603:10b6:a03:300::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Sat, 13 May
 2023 10:27:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.021; Sat, 13 May 2023
 10:27:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 10/11] nvme{002,030}: Move discovery
 generation counter code to rc
Thread-Topic: [PATCH blktests v4 10/11] nvme{002,030}: Move discovery
 generation counter code to rc
Thread-Index: AQHZhBJVmrYCeJQRJUGAPqu3bNa3C69YAsiA
Date:   Sat, 13 May 2023 10:27:11 +0000
Message-ID: <5c8dbd74-4bd0-a864-98eb-8866bb11fbcb@nvidia.com>
References: <20230511140953.17609-1-dwagner@suse.de>
 <20230511140953.17609-11-dwagner@suse.de>
In-Reply-To: <20230511140953.17609-11-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB5502:EE_
x-ms-office365-filtering-correlation-id: 30979252-8efc-4ab3-d852-08db539c9d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /BXP8F5SxzIFB4MbVIvlAJL/4xNpbJ3ylLihVYV410yh2N9/61AXqDH44OHYUZsqMlRxl7Y+b2ANcEAjuc4LahLyY89kqyJp1K+NJXS+ihmGmt34h3JjOqx6OXt7d9CzzGbmikVtWPhISETgOrivH/8T5frAOqWJQw51jzQdVtliawItWsR4TAH7ueILOa3VJMOyaAQ5PWsZ1AMTk8/I1W6Yve1fh8FhXhXPt0yghrs6UG+NBnmTvM42EVhCsbicU0u+cb9EInSCHtWlJICoz1kg+90D00agBnlzu9MTReLn5VUDC3Ls4DOjzosaAkO5+eKZPuaiRI6iwtbe19ouDd3L3A03xNYvjbMqy228YcgvHzD5uQ3eKgCWbYgaxBaJsD7F088IXNowARxPirpW0wDN3+7rKP4vCPFywBW56Tga4emMzrB6mnr7pH1xh0NcSoZwVQvcSet9xsCKYIMOhXNjo30oOHKpil6roDZ90DYBcXnR16YASA6gH3oXcc8/dDPY2A6F/i7w1u92wFv+w/PwPGDiFG1Hf4FK1OKub/mcUrosh6zgBCFvAd1k4nO6y9TrGHBryXoa4h3PzJWiqma6EYhKI6GQXqXr4cD5Fy6DsFLnFH4B/ckNI1+k3FvdJlO9rssn8T9dDheRfdDqKXDII8le7ooNfrqy/Uvzrlv3d0+cztE0EMheDuYJy0JU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(2616005)(186003)(2906002)(36756003)(38100700002)(31696002)(558084003)(86362001)(38070700005)(122000001)(316002)(66946007)(76116006)(64756008)(66476007)(66446008)(66556008)(4326008)(91956017)(54906003)(6486002)(71200400001)(41300700001)(5660300002)(8936002)(8676002)(53546011)(6506007)(6512007)(110136005)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjFHUzNtZWNrcTQ3b0l4RDl1d0pldjNtdHBya0FoQitBaitwZDNjQ3k5Q3pt?=
 =?utf-8?B?STdvS0tvcGg2SnB5dGFrNmtSOHBTRHR0VjJBVXN5bUxNRHdoUHJ4eCsxL09v?=
 =?utf-8?B?Z1V4Lysva2xGUWcrQlVVZm1zOUx2TEQ2VVFvYmM2TXpNQm9JT3l6OEZlWisv?=
 =?utf-8?B?RFpBc0VMY0xGMy9pamRMemx5OUhua2RhaXRiU2ZaZ1VrS004TzJiSjN5b3NP?=
 =?utf-8?B?QzBDRTNlSUZuVDRBekRNWWVOQk01em1BMlBqa1g4N29CbThQclU3SldxWXpR?=
 =?utf-8?B?RERieHEzclg4dU10WXFOU0doRlJlMmNUNXdHRGdKV0FISWozNysvZ2s0aUp3?=
 =?utf-8?B?TTlxNnFBL25FQTRjMFlaN3QrcGdnUlV3T0ZnaTMzS0Zha280L28xN0s1ZEpR?=
 =?utf-8?B?YXhqaTA1di90ajFQeWJJM1h2a1BzeUNPK2RpM3B0M1JLck1DVnRJbEd1MmFF?=
 =?utf-8?B?Y3pOZ1BqSS82OG9tMml0RnJ0bEtiUDk2d1d6U1NJME8zVkZ1V0VWaWdIN3lh?=
 =?utf-8?B?UjVQYi9NaHNpZzdQM3A1c3ZycCtZbmtQWDMvZy9MWXE0Uk5yTlpKL0NIRnNE?=
 =?utf-8?B?bThNQTk4cldlZzhxRXB2aFJZa1NJY3RkVFQ5LzczWUJ5QUxIV1JGVnduR0Jq?=
 =?utf-8?B?NzFZblRkTG1MZjlqZC8ybXltTmtjQjlNMDlqeWZlaGk4RWI3WnF0T3BoNUxQ?=
 =?utf-8?B?V2pxRWJPY3NMZTc0REJiTjFuYmd3V1BLUWlDYm1sRWtrcUJENmRrL1lRakQx?=
 =?utf-8?B?L2hmUnB6NGF3RmVjSlkyZmxaNmF3TVA2L3VqZUswc0FqcDRzUXFiQUFXR2FE?=
 =?utf-8?B?eU4wQW1FZ3Z6ZGY3OUI3a0I3Slc2WGY4algwd2xac3draEdYV2VpUUQvei9N?=
 =?utf-8?B?MXVHY1d6d1BCalZ2Y2dDUndta0FTM2ZnU1lsSHpmWVFvbXpSMUJnNGJxNTdU?=
 =?utf-8?B?bmFiT0hQVUx2eE5GRnUxeTJ2dEtadzcrT0IzdGFlN1k2bXdJQ3ZhTkpJSExS?=
 =?utf-8?B?TEpSeG9WRjBuVWVsUFdjRUVlemtqU2tSZGpGV0JFZE14b3F2Q2loNGt2eE12?=
 =?utf-8?B?QWhlUk8xT3R3Sm1xaVc0TXZwWXM3WGRlRHhqNVBRellRdDc5TVM0b3pNVlNa?=
 =?utf-8?B?U3lrRUxYejNrMlI0UDY0OWxqOWlxVW5nZlBEOUIzL2JKd0dDdmlVYVJld0c2?=
 =?utf-8?B?ajBaejZ4ZUt1bE1uczVqMVhxemt3UERHbUJMbkM4NldndTBhR0F3TVdJem1P?=
 =?utf-8?B?WmN4cHJvZDZ6TnRJTERqKzJBUjM1cW44MVVDR3BoYmNVR2dSRkxsS28wZTY2?=
 =?utf-8?B?eUwrUHdxZFBnd2x5SkYzNk9ybUtuOEVyUU9qNVJtMVRwd0Nrc01JTlRjK2cv?=
 =?utf-8?B?UTFxT3FXMlNubHhDc1gyS2x3OVNQMlp3QzM2dGNlQ0lwRDhpdnltZW1aRlBS?=
 =?utf-8?B?WERzZnRqTTM5TDVES3NtMGxiL0NsYmVBcEhLZUIwOENHRVlad1pvM3NBVFJm?=
 =?utf-8?B?cjFlSVVUcXc4QVRBUWEzNVlwZVQvQnExTnlWTUV6WGk1N2RiYTZMQW0zK2Vp?=
 =?utf-8?B?bmlGVUk5VHBUVTVyM3Z4b09nSGFzY1NuWUIwdUd1TCtRV3RJWXhWbU1ycGp0?=
 =?utf-8?B?Rm5ZbHNGRlZOZ0dnMmlKN1k5azJjdWxJSUZtZDhCd2ZjcTV5cnU0cGRRL21T?=
 =?utf-8?B?V3puTUx2Sk5LVjdZVHdFL1hqRlJWa2JGMUV0dUQyQ09UUG5zTGNEeUUyQWJW?=
 =?utf-8?B?djE1a3FMUFJFRVRPNnVnbXArSHhrdGFpRU1KSjc4bE9VbC90Y21qczAxdytR?=
 =?utf-8?B?NjRsanZib3VtRnU1UWV3SkFmbmhnSVdZOENuM2V5RThZMVdyUnBraXpiYy8v?=
 =?utf-8?B?em1pb0ZPRHZRV285SnFsZ0hxRTg5anh4dHBtRVpoZ0RlWkVtZnhwT3dwN2VI?=
 =?utf-8?B?dFlpVEI5OE9VSVFuU05Vdm5VQzl3b3JxVUhWSXNoRFJiaHoxZlhTeE1GcmZM?=
 =?utf-8?B?VGhRQUo4b21INEtrMEd6MjZ4MlJDY0YzQ1VsQVg5VGc1UEtCaDFZYVJQSXYv?=
 =?utf-8?B?a2xmejA1S3NvTldMRC9PREFsMWpvMTQ5RlN3RnY3ZC9Ra1JZVWg5R2NrNXM1?=
 =?utf-8?B?NWJ0enJtZkg2Y1RhdjBhNVNIb3RiSUs5WUpWcUdKRTBUWHBWNGE2cElycnZ5?=
 =?utf-8?Q?fJpBKxEsw5dCU25sr47HDvAF3vrO//4Aw9neI7rxFNRN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CABD7FC21C46D4E8CBAC3FD1A6A7BD3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30979252-8efc-4ab3-d852-08db539c9d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2023 10:27:11.9299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KaQxo8Ue+HYVTdClQYyKksSQ7z74l4pkScP0KNa6vnuF4tW0bcC+HRtuptMLUlZAHhmJlFoQ5VepPv1oAuX/Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xMS8yMyAwNzowOSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gTW92ZSB0aGUgZGlzY292
ZXJ5IGdlbmVyYXRpb24gY291bnRlciBjb2RlIHRvIHJjIHNvIHRoYXQgd2UgY2FuIHJldXNlDQo+
IGl0IGluIDAwMi4NCj4NCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNl
LmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+
IC0tLQ0KPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
