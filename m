Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7589A6CA7CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjC0Ofh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjC0Off (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:35:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA7E8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv6Cj5Ud2a5StVCD3WQC/h155vij/iz0+ljQJl69fHTPJXKUQ0zE3N5Auhfn4njG0Q1nd9HzOo5fGUAwP7eYGQd2JebvagtwCF0o8qFAPA+QTHsTSGcNCV890LuAh60um58MqCYicEQLKwQTpwdK3jp8pdMW6GQA6jsCE7bQmNzu5kyhDl5a+Mkt+qILBGQZ6wqHTrANz1k194mZSYVbNCd9jjjwpxJhF9EpjYzeNvZpHQlx2FhV7S53h1yIO/f8dGvQJKaeIsfFmTv2lDNRbH2tm3vO3GWqLXmkL+CWEECLaMCdlrynamHpw7/2Qw/w2nfd+m0sDTeDznMCbL8XWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3miByYP+hB7rcbxr0jGJY/V1KdQGTwBd5Qh5NEvavS4=;
 b=S1B0qNj04rD7q8cDHZH2GPfaqGY3I1n5JOdaQPDtwDcO3olUKAMyCeUhFrAwYrYYyf9zSl73c+qdHkQhxLrEbg0fr0WMNs9dZP1G9qKp51AcLHb1D6NwryiPatQ44yaO5eteS6XQgIkgnMBA9+IQtPINKL2hYm1y3oNYD5bqxTy8IILajmC1tLn0Yp6Zpy3nqyU6lI0IuFCNEYKmgA+hpEMHUs0FxMIAa5tseSPhVgNEHYd8Q0YuFMhJ6thwvhsUdae/MAus8rAqqXqUei1BAOyskDXhywKyq2yqF99nUI4e4b0dRn/aUTtPWO+OnYTMf42wPzzR8QkRoPc/bh5YGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3miByYP+hB7rcbxr0jGJY/V1KdQGTwBd5Qh5NEvavS4=;
 b=AFDBhPVXA6SCCO4v/a5N3piUCIMhTnPF7OD+TMf/BlGlRBBrPYS4Br4vJ/EoOCjoNhVzRlcCviDnWYCCfYvsichJsmu/aG+XEnnlqqv/lDGqYJoxqDb927xEzCRtTzO0Gt0sUJoVb9s1OfJvJXxPWabd3xauaKTz0kUIu3qsTo8=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DS7PR19MB6399.namprd19.prod.outlook.com (2603:10b6:8:94::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.28; Mon, 27 Mar 2023 14:35:28 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69%4]) with mapi id 15.20.6086.024; Mon, 27 Mar 2023
 14:35:28 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Hillf Danton <hdanton@sina.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrei Vagin <avagin@google.com>
Subject: Re: fuse uring / wake_up on the same core
Thread-Topic: fuse uring / wake_up on the same core
Thread-Index: AQHZXonZnrNnGQvxikaxtbJ88GLEB68Khz6AgAAdDoCAAG/TgIADoY0A
Date:   Mon, 27 Mar 2023 14:35:28 +0000
Message-ID: <1b3ca0e3-cabf-a783-7bde-5bc6d51890fc@ddn.com>
References: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
 <20230325002815.1703-1-hdanton@sina.com>
 <d9151806-c63a-c1da-12ad-c9c1c7039785@amd.com>
In-Reply-To: <d9151806-c63a-c1da-12ad-c9c1c7039785@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|DS7PR19MB6399:EE_
x-ms-office365-filtering-correlation-id: e857236d-556c-47f1-44e6-08db2ed082d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ut0EE3H6MJu3VOUgEfsltgx9mFaQCuUHrmtcUq4iP76nF68ROGi9tly/N1rKVF8GrpwUyk3Wyhgpc7rKe8o4DMZjleGhs2Tfx80Lcni/lQxeV5GjdgY0ITa1h11d0GA7c1M8UR646Zy0prcWC3fEi3cJB4u/tbNfHb0vepQaLQGAIsPiOZjpVmHOWURLvXtG1gy/ZDE+dFkoa9brBcInxe08L5R7wYLuVucC+DQJBrdWXo3+1/wEchLnOGkB8Cl6YV1OpxX6ah93dH9Uj1mPCRg8gLxHIg4xISyULnV//IgmRKOIf1kR727O4UydNRdKu1VaX7bAzb9tQ6FyUnFfbT7YJRupXvsPWp5VGyFm72PnNK9SDMrfEokuOSieNPClBeip2VbQ/fLhbmDwwDoHul/aaYcc7cTr1vh+qJFIGcx48mJ5aa0f1rqCOz3z9cA04EtNU0LRe/ipQ4pN1lkZnpb6nFtHVarSuV35WtHXi+ZhqV3R1rxf2cLRBPxnZA6LLoEQpethnVLMXbXzWCZmfkMNz1ZQ0A7FjTEJRC29j08MUq+cztI1TDPI0RAMjwkFQu41ZtUzcPDP6m7Bf2oMF7wLVZB+bWPbV76OMG1IxXZ8UDawmnI1PswdlYlwvBb1/g5xIlGLOwv0zLJWWjpMui9tQstUxc35jn4aVkoHMp/ay4Q+IjyqFt7WFDT2LByW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(451199021)(31686004)(2616005)(91956017)(83380400001)(41300700001)(31696002)(86362001)(36756003)(5660300002)(38100700002)(8936002)(122000001)(54906003)(6486002)(66446008)(966005)(478600001)(71200400001)(76116006)(64756008)(8676002)(66946007)(66556008)(4326008)(2906002)(66476007)(38070700005)(53546011)(6506007)(186003)(6512007)(316002)(110136005)(49934004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzI2Q1B5YlVOOW1JSWk4aE9VYXI2eHByL05WanNmMEVSMFlrWEhRdlBsRkVR?=
 =?utf-8?B?dFRVVGd2elJFR0FkUWhOaW1Oek9rZDdsQUtBN0ZyRUNsMlRJYXdKczdUZ1lB?=
 =?utf-8?B?NUxZeDV5Q0NyVk9pOS9XVWxRNmdLcTVvcHNYVmJDM2NxQjBDbGJ1dHpXY3VF?=
 =?utf-8?B?WWk4MytBUXp0U2FZSmxzM3F1OWVkTEI3Nk1XUkRYUW1NZE9hL0xNOTMrd1BS?=
 =?utf-8?B?ZUZzeXA5SDB6RjRkWDhVY25MdVJRU09iZkdJWWR3WnkzdXN4QjBOSzJVaTJ1?=
 =?utf-8?B?eHB2NExuVGpMdEN6L3JleFNma1hWV2g3ZFpFZVlOZW50V1BWcTd4bHdGcUVY?=
 =?utf-8?B?dVpxblRPSG45YjlGV0pUamthSnIzcERxNkRlbW9WeGVYejVvTnFnUzhNSCtU?=
 =?utf-8?B?V0IwN0gxWjVPeUFWdG1tYUVxRHdUMHAzTFFHUlg1TldCYjFXS2w5M2tUSEN3?=
 =?utf-8?B?RnFGY2pucTFTL3drQk41aWtjR2hzL2lpSmFsZ1Y2TVp5TDdVamM4cXljT1dO?=
 =?utf-8?B?czU1TGsyV2pvVVd2bzFKWEtYR0xmd1ZaTzM5NFZyakd1dUlCeXpMaGFDdVpM?=
 =?utf-8?B?a1dvdzVBeVRRd1NmWjdnSCswdk1zeHZ0cTVTZUF3QmtuamJxbWJmdVRSdm5N?=
 =?utf-8?B?d0pBa01Hd0x1SGhLaWdkR3VjOElHNGMvTXZ3Qk1XU1BOUHJ5Vm5GcWtMaGlY?=
 =?utf-8?B?YWZ3RURXMGErODhyYWtuYWpYdzNvYTg3WHptdDk1WE91My9xblVhTFVUZlZ3?=
 =?utf-8?B?VnRWby9YUllJeVNoRm5RbXZhdEMzeTE5Ry9CQnJXTjVyU1k1dkMzVitQNUp3?=
 =?utf-8?B?L0tETGNRU1BYUEVTVTVxcjRRdWkwL0xvVVVUOW9WY3N1bCtrUFJUMmxXY2R5?=
 =?utf-8?B?akM0dlRxUVhvRzNCMmgram8zVzRpNkVXNmE4UFB6WHprd2dKVHJXVXc4c0J1?=
 =?utf-8?B?NE8rWm9CeUR3anhja1BXRS8vN1FjRElZa1J1dzhsT2ZuUFBYUzhBWDBDK0w4?=
 =?utf-8?B?S2ppVnlYVDZvVkN5ejlCMmp5UTFtZndtRm9oZGVNdzNoWGdpYTY5WGFxMmtI?=
 =?utf-8?B?TjJzdEtYWjBOb0tGZHZGRkRQRTkwYWNheVpFNVpVeXZNZHM3dnREdHZOODUz?=
 =?utf-8?B?U3kwOXVTV3hYSGxRVWlTYzU5RW9CbUxmWDZ2N0Z6dmtXTzN2dEEwcVRIUDJn?=
 =?utf-8?B?U0VrcjRrdkJBQmozWW1ubDNqaE13UGJFdHNRSzFSZGhkbHEzRFRDRFNSeTRO?=
 =?utf-8?B?cDdlYzFXc0ZiUWFPN0dwTTBLamVkY2F2dEdqNHVuc2QrN3gxaDFPWUdJNmlV?=
 =?utf-8?B?RDFDVE9wanp4SmdSS0hRWC9mVUVtbzVRMjhmaHdFclJZSnFvcDNjNGp2OVkv?=
 =?utf-8?B?UkhDNkUyT0x5VU1XQzBnU0l6NHpVYjFRTlN0YjhjZGk5ZjhadDJpbkk0cWtE?=
 =?utf-8?B?NFJvSndBSURWbWQ1R2J5TjhqTkZxdUlpcnZLb2RPaXZjK2RESjlRZWFEaEJW?=
 =?utf-8?B?blNDWjJKc2kvTW5XajZ3a09qZTJTZUZqRUI2Z0RSVzQwVEFkV3ovTHFLd0RO?=
 =?utf-8?B?dktkMTR3UzZvQnduYjIvUXpneXZRb3pyN3NvOU5VdVM4MDkzbTNDd3ZUWWYx?=
 =?utf-8?B?cHAxSHdXdU82ZG9uNmZHL0pKalpkUlM0TUVidWVUSjkrbXZyWWY2RGQrUi9a?=
 =?utf-8?B?RDkyUm9tR0l5L21yTUFNMjdGd1lxdFpsemlhNVF0NVhLK2ZwbE0xL1I0YnRR?=
 =?utf-8?B?c2FpUnJieEd1ZGhpY3hZWEVubU8xRHF3Vm9xYjVLeHdlUmtMdUVMKzVsMWI4?=
 =?utf-8?B?SGpCT2lmVFhScE8yVGt3S3k5VUlMUmR6aU5hOEs4a2ljS1B6RjdxMmM4M01v?=
 =?utf-8?B?L3NDcHBwWkFsa0YzbkU0WEc0cWEzQVJNaFRCdE9IMVhtVCs2UUduTXhuNjdT?=
 =?utf-8?B?ZU1HeC81YlBRUlNHY2tVNHRJcEZlN3RBdG55aWc4TTBrcU5XZlREaWdtZHVm?=
 =?utf-8?B?cmtwZU4yaitjaTNSVllzK0trLzNOOWNWS3VJT1IvWUFlQ1l4NlU1STNPZGFy?=
 =?utf-8?B?ZXVyaFFKenJlTFduYytnb2o1ZTRrS1JpQlIzV2NlMk1qNzBZVm8zQjNWK0pL?=
 =?utf-8?B?alFSb2w0MHB1OTRrMllkODlTT0pMRjByUnd4YlRLTGFqMFdLU0tzYXgrZ285?=
 =?utf-8?Q?G3mhordlwkmZG7ispmVGP7Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <999B78E73B29D54ABAE30D67B2173B2E@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e857236d-556c-47f1-44e6-08db2ed082d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 14:35:28.5194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDeOIRIAKRbUZQaOxPEzjhWhj4uqekOOICQI1VrmKhXJ8ywws3y/Q1+76T7owuJVZINJcBOwX9SOgj6BT/Pw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6399
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yNS8yMyAwODowOCwgSyBQcmF0ZWVrIE5heWFrIHdyb3RlOg0KPiBbWW91IGRvbid0IG9m
dGVuIGdldCBlbWFpbCBmcm9tIGtwcmF0ZWVrLm5heWFrQGFtZC5jb20uIExlYXJuIHdoeSB0aGlz
IGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmlj
YXRpb24gXQ0KPiANCj4gSGVsbG8gSGlsbGYsDQo+IA0KPiBPbiAzLzI1LzIwMjMgNTo1OCBBTSwg
SGlsbGYgRGFudG9uIHdyb3RlOg0KPj4gT24gMjQgTWFyIDIwMjMgMjI6NDQ6MTYgKzAwMDAgQmVy
bmQgU2NodWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPg0KPj4+IEhvdyBtdWNoIG9mIGhhY2sgaXMg
dGhpcyBwYXRjaD8NCj4+DQo+PiBJdCBhZGRzIGEgY2h1cm4gdG8gbXkgbWluZCB0aGVuIGFub3Ro
ZXIgUkZDIFsxXSByaXNlcy4NCj4+DQo+PiBGZWVsIGZyZWUgdG8gbWFrZSBpdCB3b3JrIGZvciB5
b3UgYW5kIHJlc2VuZCBpdC4NCj4+DQo+PiBbMV0gU3ViamVjdDogW1JGQyBQQVRDSCAwLzVdIHNj
aGVkOiBVc2Vyc3BhY2UgSGludGluZyBmb3IgVGFzayBQbGFjZW1lbnQNCj4+ICAgICAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDkxMDEwNTMyNi4xNzk3LTEta3ByYXRlZWsubmF5
YWtAYW1kLmNvbS8NCj4gDQo+IFRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdG8gbXkgc2VyaWVzLg0K
PiANCj4gQW5vdGhlciBwb3NzaWJsZSB3YXkgdG8gdGFja2xlIHRoaXMgaXMgd2l0aCBhIHN0cmF0
ZWd5IEFuZHJlaSBpcyB1c2luZyBpbg0KPiBoaXMgInNlY2NvbXA6IGFkZCB0aGUgc3luY2hyb25v
dXMgbW9kZSBmb3Igc2VjY29tcF91bm90aWZ5IiBzZXJpZXMNCj4gKGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyMzAzMDgwNzMyMDEuMzEwMjczOC0xLWF2YWdpbkBnb29nbGUuY29tLykN
Cj4gDQo+IEluIHBhdGNoIDIsIEFuZHJlaSBhZGRzIGEgV0ZfQ1VSUkVOVF9DUFUgdGhhdCBhbGxv
d3MgdGhlIHRhc2sgdG8gYWx3YXlzDQo+IHdha2Ugb24gdGhlIENQVSB3aGVyZSB0aGUgd2FrZXIg
aXMgcnVubmluZy4NCj4gKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzAzMDgwNzMy
MDEuMzEwMjczOC0zLWF2YWdpbkBnb29nbGUuY29tLykNCj4gDQo+IEkgYmVsaWV2ZSBCZXJuZCdz
IHJlcXVpcmVtZW50IGNhbGxzIGZvciBhIGEgV0ZfUFJFVl9DUFUgd2hpY2ggYWx3YXlzDQo+IHdh
a2VzIHVwIHRoZSB0YXNrIG9uIHRoZSBDUFUgd2hlcmUgaXQgcHJldmlvdXNseSByYW4uIEkgYmVs
aWV2ZSB5b3UgY2FuDQo+IG1vZGlmeSBmdXNlX3JlcXVlc3RfZW5kKCkgKGluIGZzL2Z1c2UvZGV2
LmMpIHRvIHVzZSB0aGUgV0ZfUFJFVl9DUFUgZmxhZw0KPiB3aGVuIHdha2luZyB0aGUgdGFza3Mg
b24gcmVxLT53YWl0cQ0KPiANCj4gKFAuUy4gSSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBmdXNl
IHN1YnN5c3RlbSBidXQgdGhlIGNvbW1lbnQNCj4gIldha2UgdXAgd2FpdGVyIHNsZWVwaW5nIGlu
IHJlcXVlc3Rfd2FpdF9hbnN3ZXIoKSIgaW4gZnVzZV9yZXF1ZXN0X2VuZCgpDQo+IHNlZW1zIHRv
IHN1Z2dlc3QgdGhhdCBpcyB0aGUgcmlnaHQgcGxhY2UgdG8gYWRkIHRoaXMgZmxhZy4pDQo+IA0K
PiBQZXRlciBmYXZvcmVkIHdha2UgZmxhZyBzdHJhdGVneSBvZiBmaXhpbmcgd2FrZXVwIHRhcmdl
dCBpbiBhIHJlcGx5IHRvIGFuDQo+IGVhcmxpZXIgdmVyc2lvbiBvZiBBbmRyZWkncyBzZXJpZXMN
Cj4gKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvWThVZ0Juc2FHRFVKS0g1QUBoaXJlei5w
cm9ncmFtbWluZy5raWNrcy1hc3MubmV0LykNCj4gYnV0IEknbGwgbGV0IFBldGVyIHJlc3BvbmQg
d2l0aCB3aGF0IGhlIHRoaW5rcyBpcyB0aGUgcmlnaHQgd2F5IHRvIHRhY2tsZQ0KPiB0aGlzLg0K
PiANCg0KVGhhbmtzIEhpbGxmLCBQcmF0ZWVrIGFuZCBQZXRlciEgSSdtIGdvaW5nIHJpZ2h0IG5v
dyB0aHJvdWdoIEFuZHJlaSdzIA0KKHdpbGwgYWxzbyBjaGVjayBQcmF0ZWVrIHBhdGNoZXMgbGF0
ZXIpLiBPbiB0aGUgZmlyc3QgZ2xhbmNlIA0KV0ZfQ1VSUkVOVF9DUFUgaXMgZXhhY3RseSB3aGF0
IEkgbmVlZC4gQXQgbGVhc3QgZm9yIGZ1c2UvdXJpbmcgbm8gbmVlZCANCmZvciBhbm90aGVyICdX
Rl9QUkVWX0NQVScgZmxhZyAtIGl0IGdvZXMgYW5kIGNvbWVzIGJhY2sgdG8vZnJvbSB0aGUgcmlu
ZyANCm9uICdjdXJyZW50JyBjcHUgYW5kIG9ubHkgc3dpdGNoZXMgb24gdGhlIGZpbmFsIGNvbXBs
ZXRpb24gLSBzdGF5aW5nIG9uIA0KdGhlIGN1cnJlbnQgY3B1IGlzIGFsbCB3ZSBuZWVkLiBXaWxs
IHRlc3QgdGhlc2UgcGF0Y2hlcyBsYXRlciB0b2RheS4NCg0KDQpUaGFua3MgYWdhaW4sDQpCZXJu
ZA0KDQo=
