Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B673E5CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjFZQvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFZQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:51:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2099.outbound.protection.outlook.com [40.107.113.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3E918E;
        Mon, 26 Jun 2023 09:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsIxsb3VWoP1BH50NbE/bBs4swpnV6oo4GqTvS46z6+g/SQ0AWqPK3CuHle2pkrk9lHVDyy+/IIUt7qobwsQ1WqWVldPwZSgyFIBNXKYD/2A/ewNW6NRQYQx8lPFp7oRAbY60dqMG0VPfEw2hdIn3HOyBeeYpY6Ng2kxRHr9x/3bdwMj99kT3Eavxzqx7hsdx3o0k9Pq2doOG6ApRI/gOydIUd65XopXNjAwkV135ckH4S2761EHw89fOu4+wkqKM1jKDTWXajkNvCs4SJCBTQsf3Hts1K9xuTwQRKTV4JwwrIRnQ8kT3kB98iqnt00rKjzqbXyOKLjFP6yK16K5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/tcLkEp7LBsbXHHS+jDqBJLLqhrqtNxRx/4MU6Qlrs=;
 b=MmLyB3mB6AiwNeru4N3uV9J4N20OXn1Riq+wRJE0dLhziak0rb+yFsG6TuhLm0hY+D82QfB2f5kBhYZNMvqusJnewB88cm3zt5j0c3Bj/xlIuz03LjJPlLvqYfVe+GivV1UglBx+YS/CjHYNMPXi/Er8J4QcgggWUK9QR2U/NfM5x7mo+QEZYG4uo51jj5jb8+KmuHKR1EV6w1eJ0KMB+I77oyOVMfK7jC5tTBY8qfPCPAu+vAQV8+IfTizcdHSDOQEoPQ3EJJPDd3XWCLtnCy2NmRcVXwjbeIdEYlorwJ6bCf3OQx5C3jvTCg7qkiXZEMUA2gUarLL3nSbuvCyQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/tcLkEp7LBsbXHHS+jDqBJLLqhrqtNxRx/4MU6Qlrs=;
 b=GXCQ+FqdULQFxHMzwy3s7hTQipRMDpbdnqE3xAzZ6FoOrVJYWyp9tGtUIwte3Cji9zeCrS3+Y0TBAB9zewxjdJw5qYNaDaBkxADpAn01boOmRbYPfe/vvsZS9vqNSDLFVasXJSoqR5P+XTr9q4SHa+MgDGgEHARbqZWUQtOpll0=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB3702.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Mon, 26 Jun 2023 16:51:30 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 16:51:30 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kent Gibson <warthog618@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: gpiolib-cdev: Fix potential &lr->wait.lock deadlock
 issue
Thread-Topic: [PATCH] gpio: gpiolib-cdev: Fix potential &lr->wait.lock
 deadlock issue
Thread-Index: AQHZp3MKCKremSKpfUKxLQfpASRqla+cr0sAgACNwYCAABD0AA==
Date:   Mon, 26 Jun 2023 16:51:30 +0000
Message-ID: <27E80FC7-7B66-4C05-9D16-690457BFE0B9@connect.ust.hk>
References: <TYCP286MB1188B6A0379F7928C63288DF8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <ZJk87rWsDj7pWJIP@sol>
 <CAMRc=McGOV+A8ROXRinUkWG0POTe37RWphRHDW6sy7UMU-e2UA@mail.gmail.com>
In-Reply-To: <CAMRc=McGOV+A8ROXRinUkWG0POTe37RWphRHDW6sy7UMU-e2UA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB1188:EE_|TYCP286MB3702:EE_
x-ms-office365-filtering-correlation-id: 4f86ffd9-416c-4bee-44db-08db76659723
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kU9ouzoFt9x5LVJcsov3ExRdKGAxa8Od/QTlfHSf4A+/MgRjIRZE5UcUOpy7wUDsKaSxJH2XfXuKb/clU1LA9yfElK4+uZYaqAtK1qG71dxFugwoqebBSjCXrXiw2rbPhJ+zsPBsmIF3qQVcrsFFtW3TPR0LsLk4M9kqdtc/fDqlkKKSAifgNNDt9CWGDzXdQRpQoSECjmUxEgr5NpwKFoaKZob7G7tnVhIygM+rJGQqzHan7PMPY6Fr73wOMzJbPg1NBMk5D55JNWYOlUREEQR2RfZdbVpHMJxbOlMQ5rUdJ2uM5RTeYq66rwqfNgpZrRe1sj8uJJonRLghjwFX9PG6VADt9Lep+9ulP0sbBlTrEULDHRDfvaU1Qse3Ls4bombwBVm5qC7WS529j3lBC8xYJtmE4W1+puohaGhvTH7OUtmdPBh2qPhVbkCNnxmazKgO//oadpdxIOVYzRhMlIs27D+MYVL7JpLa9zmolyxLZiHzWXOtvEBGxMgOofl/7D6tlaGiFgOtxPHrFm0L4Nj1IX0tHWqAA7LQHBdn/yGz9PaJD9tChkOgw1FEPYKZ4KK3nvb6Fkqk7D1yo0l5/3tqihGecByEZLHIvJfeA34+h2sFbOqCrOP6wMPKHuwprUFZ3p7+xHdxi2nQNXkIaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(2906002)(6486002)(71200400001)(2616005)(122000001)(38100700002)(83380400001)(6512007)(6506007)(26005)(4744005)(186003)(41300700001)(54906003)(86362001)(38070700005)(478600001)(786003)(316002)(36756003)(66556008)(66446008)(4326008)(66946007)(91956017)(6916009)(66476007)(33656002)(64756008)(76116006)(5660300002)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVAwRmdqeW0vay9BV0ZYYkdsdGNiaG5Pb0ZYZDN2ejFMdmdjZTUxbWNMcFlu?=
 =?utf-8?B?OVZUVnpEWE1QakZEbkR6SXgyTzVCSW9nT25pWXg5WHRzQjdOZk9CeFM4ZTg1?=
 =?utf-8?B?endOb3k5U1FsWVNEWVlMZlBvSS9tdDM0elE5VjlRYWdVT2ZsczhGQW11d240?=
 =?utf-8?B?Y2FFTnpPU3J4ZlM0c2R5eWpWQjRtQUF1dHZFWmFKSE0wR3N0MVdIb0d1aUha?=
 =?utf-8?B?UVFrVTZRZUdKMDk4QllQZkI2cmpTMGtRVDFPbnJ0U0lzV1NEbHdpZStvNzdY?=
 =?utf-8?B?VTYzQzN5c2wyVzl1S0ZlVzRQMUNHQjBLclZuZ1BUZlJoT29XanNiOXkzWENr?=
 =?utf-8?B?dC9mWFRuK2YxUkVCQU9JY1JwbHAveDk3S3U0MndrU0hSTFl1N1c2bzR1RHhq?=
 =?utf-8?B?NnBFaFcvZmFLNUhCR1hLM0VWRzcyU1FicitpUU9OTEtObmpaOVF3QnVQUWd6?=
 =?utf-8?B?V3V2VjBPbU5tU040VXlnUmU3eXc2b2w0L21LeVNCb1IzOXlSRU4zN2NDWTZW?=
 =?utf-8?B?Y0hWeXdLR0t1N3llK3VoY0NQUWJhY3huQjNXZnl1Z1dKek1yQ2hSaWtFb3Bo?=
 =?utf-8?B?a1krNXJuUDlLWXBGRmhNbGZXY3ZVcFhJd2ttR0t5WjFkSklNUk84SW54WXpU?=
 =?utf-8?B?cW9nVS8wTURydTkzY1hvUDhwZzQ2TGt4Tzdhb3gvOTZ6SG5ncEtzWGl2SjJx?=
 =?utf-8?B?YWdGQkt2SXV0TC9qRXhBSnUzeTdUTFNWYTlQZThJM0w0UVZybm1uOXZRUDlv?=
 =?utf-8?B?bURaRWVhQ2Ircm9BVU4rRW9kOHl2bEJRWDliakw2SHVUS3VQVDJOZ3ZMM1ZQ?=
 =?utf-8?B?WnZGTStLTk1qQ2tPby8xVEJPUzdrcVJkdHB2TjgrckRHVFZqK0pyb1JZOHpp?=
 =?utf-8?B?eDh3U0kwNnRiYk0zTGI4VGhzZ2hqWDFDYTBVdVd4REFFSnFtL3BMNWIrZVZ1?=
 =?utf-8?B?bXB2L2U5cGRnZFlMT2hzd1FOb3RQdVRZVmRwcWdaVjhDTWgvVWtnMHBTNGND?=
 =?utf-8?B?S2VvUVNDa2RhMDZFQjd6aE1vaXd5eXByZW1rMTUyZEswdTJ2YVQzZjRWYTA3?=
 =?utf-8?B?ZWMrd1BMVGc1L2ZLcGlWeCtpS214dkZ1aEx2UURjSndoRngwc29ObmFpQURS?=
 =?utf-8?B?MnpKbXBEQjlEN0ZLWEI2Z2ZqSjRIclE1TXd1UnM1QUdZV1FxU3NJdkR1cmFT?=
 =?utf-8?B?MXY1RTh0WjFsbTJpRGY5WnpnYlBhdTlwR05tdnZHUlNicVRsakt2aHZFZ3Iz?=
 =?utf-8?B?VDNqY2V1N1Q4OWxQOW9vc0RJYXVaN0I0M2JqMmRYVlJUd1JvNWM3Z0tSR2pB?=
 =?utf-8?B?SzZZWE9Rc05MNlZ1SXhtTXZHMkVKVDIxcUZKNXZsMFZjYVhTQjRNbkptZDN1?=
 =?utf-8?B?S1Rxa3AveDZZSCs0dDRsbkZsZHFpK2hwbjJGNm9SNnlaOG8yRUxXRDhjQmQy?=
 =?utf-8?B?MFZRRTZSVU9QQVJJYkR1K25kZ20yRitCTkNjdnFIMzZuMUZOeVJNSndZSWNU?=
 =?utf-8?B?cE13R3hHMXRSaGZwdVhlRmlVU0lLOE5yVTh2ZzNvMjMrNmVxYVpPTnZvdzdj?=
 =?utf-8?B?amc2ai85b0hCMVUzc3BRYnVzM2QvR2l2K243L0s0M3NSRDExdmNjekx5VzYv?=
 =?utf-8?B?dUtEak5BUVhmMUpMZ0VUTEZKTW5NRGxJYkJrVHl6MVhtRFVWdzlqY2ZJRUZw?=
 =?utf-8?B?N21DM1o1NGZGM1pQVEJvU1UwQVYzRFVqUnJ1YnZseDRoL1p0KzllYlpwN3NM?=
 =?utf-8?B?VjlnOXdLL29JUjdLV3lKei9udFBVMlp6emc2SVl3TGx0bUJIaUJ6SG01emps?=
 =?utf-8?B?UWpyS3pzTnQ1dlhOTSt5YldHUWhoa1NBM00xZXBadUs5ZUgyRmxUZGVNOXFY?=
 =?utf-8?B?c05UajV6STdhTklzUXE2SFI2MkJiNVk4MmVTbkF5alVvcUQ0OVJkRXc2cEpG?=
 =?utf-8?B?WXNCa0JaV3AyUloxeDdxZEEvaW9HZXkvWGREUFRsYWg4T2lmR3JkUXVJaGRo?=
 =?utf-8?B?Y0hzZ1JMUW5kV1JtMVlFc1dHTU5WWWRiRTBzUW0wcnZqMlNYakN1NElrRW9o?=
 =?utf-8?B?SEtNbTl4Z2QvdXRqWkZSZ3hod0tNbzNxNitpdU52SHVWRGxkN0J2aUtMSjhq?=
 =?utf-8?B?VzlTWkVKcXM1M081WlJLd1l5RkhMdllWeG5XbkRiTWh5YlVkdEM3elRZMjQ4?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F68BF8EDD597144A8D372C02C7CA4E40@JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f86ffd9-416c-4bee-44db-08db76659723
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 16:51:30.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ac+2ZyeiTQCwni4FJ9btiDxs7DzGP7diTV1jWlLDIL+K4LNNQPXkK2UPpAX1cY+punXLf7xUGtEKlCtiqz5Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3702
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZZWFoLCBJJ20gbm90IHN1cmUgdGhpcyBpcyBjb3JyZWN0LiBlZGdlX2lycV90aHJlYWQoKSBy
dW5zIGluIHByb2Nlc3MNCj4gDQo+IGNvbnRleHQsIHNvIHRoZSB3aG9sZSBwcmVtaXNlIG9mIHRo
ZSBwYXRjaCBzZWVtcyB0byBiZSBmbGF3ZWQuIFdoYXQNCj4gdG9vbCByZXBvcnRlZCB0aGlzPyBD
YW4gdGhpcyBiZSBhIGZhbHNlIHBvc2l0aXZlPyBIYXZlIHlvdSBzZWVuIHRoaXMNCj4gDQo+IGhh
cHBlbiBpbiByZWFsIGxpZmU/DQoNCkl0IHNlZW1zIGxpa2UgaXTigJlzIG15IG1pc3Rha2UsIEkg
bWlzaWRlbnRpZnkgdGhyZWFkX2lycSBhcyBydW5pbmcgaW5zaWRlDQppcnEgY29udGV4dC4gVGhl
biBpdOKAmXMgdHJ1dGggdGhhdCB0aGUgcGF0Y2ggaXMgdW5uZWNlc3NhcnkuDQoNClRoZSBzdGF0
aWMgYW5hbHlzaXMgdG9vbCBpcyBidWlsdCBieSBtZSwgSSBub3RpY2VkIGxvY2tkZXAgb2NjYXNp
b25hbGx5IHJlcG9ydHMNCnN1Y2ggc2ltaWxhciBkZWFkbG9ja3MgaW4gb3RoZXIgcGxhY2UgdGh1
cyBpbnRlbnQgdG8gYnVpbGQgYSBzdGF0aWMgdG9vbCB0byBsb2NhdGUNCnN1Y2ggYnVncy4gSXQg
aGFzIGRldGVjdGVkIG90aGVyIHRydWUgYnVncyB0aGVzZSBkYXlzIGJ1dCBpdOKAmXMgYSBwaXR5
IHRoaXMNCm9uZSBpcyByZWFsbHkgYSBmYWxzZSBwb3NpdGl2ZS4NCg0KSW5kZWVkIHRoYW5rcyBz
byBtdWNoIGZvciB5b3VyIHRpbWUgYW5kIHNvcnJ5IGZvciBib3RoZXJpbmcgeW91IHdpdGggdGhl
IGZhbHNlIHJlcG9ydC4NCg0KVGhhbmtzIGFnYWluLA0KQ2hlbmdmZW5n
