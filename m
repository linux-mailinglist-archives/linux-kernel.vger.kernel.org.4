Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEC86E3382
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 22:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDOUVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 16:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDOUVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 16:21:20 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8754F26BE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 13:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsS06XGRhAOv/o0ZBfon6J2Sqkv1AujEeMyxB1n7ikCdEooR3yYnYHxfWjzCgf/7RY2SSsIj8YBICTc4Ya3ig/yvO78BmJg/sRidXUpEWaeCTYcUIjE7q5Ny+uT4FgYHhZbd2M/4C9uZeIh13AxxrTg78udQ8780zMGCWF+xphylL06mjb02N7g7wwsbOm+8UCfPNyhMQWnPE0OJYr4AHrqF1l9kTuCTEMqq6/MYa+aa6F+viB8RpR+voWhfMZy0XxFNY+lljO3cvTR8eoCuDjOS8xSHz4coK/zun+0Bc7XRKJdPDbAduPksGQlBSV6XtrfcC3qXZ2hCqc112qyljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41/vuNhP1UPBF98FxBAq3fGFBOoi77AUJ1jyPEZaHg8=;
 b=UR/h8qoMRd8QVlUSCLIkAZ6BAa1iP4Dq1EjAO4mmZnWr4S+/hMoW4uMUPyiEA5ASZZYyMgQa87p6LXh7WYnGRoD/jT/gKXwd0ure8d6Cs3l+WqyO0xuugW7DN1w78JRwThGeCkuBQk1MayrHAIbi1ZSlYSHxU0QDkKFEwUU8FHf2kN5wpevauaqerB/YH+4KzXj8UaMIkDUK8IKInQtYy4ABaF6YtSL3dOYedOiVGDSfJnpkkRl9daNXnFT/7R6kccGk6GLbwngx2f0J94cN7cpI/gS5z4cVuNsA0vyldthXIqaD59/yg1uH08WwArS3MiB26qkzinQ9CU/3ebMTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41/vuNhP1UPBF98FxBAq3fGFBOoi77AUJ1jyPEZaHg8=;
 b=hcf+gTsND5RV6BW65RgyV57cv2mx+dh1ieGE567wZZacWKGxtQKU7Z3AUSZeDL2rpB7PAnNh5c3bdiWPbOk3Foifh/DHWSRXVRkXZL4dBHqjttJu84HV53SHa8+NFRIuW5hE7bYRkdRZdMa1VNKHnUfm/vf1WEkrKR2lamhDWolnuoQVKi956OkxrW74YdG7DCTPsggG8C4AlGP5pQ+E2F7L3rocchi0Yf8HkwnfVuStClpM5SVLimbfKP04roadSYHGugkfQJGbNJISo6Bl6x3Zuragaeq7lThrr20X+PzIHxsueCYEBqDvVvgd+frjuNYP/n+XWASP+l6tFpfgdA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 20:21:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.030; Sat, 15 Apr 2023
 20:21:15 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Li Feng <fengli@smartx.com>, Hannes Reinecke <hare@suse.de>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lifeng1519@gmail.com" <lifeng1519@gmail.com>
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Thread-Topic: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Thread-Index: AQHZbgwnV0iLUENCWkmbAIpD61K0wq8qfGCAgAAQZoCAAkbIAA==
Date:   Sat, 15 Apr 2023 20:21:15 +0000
Message-ID: <46946ce9-ad21-0550-4522-f580f77eba1a@nvidia.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <94d6a76c-8ad1-bda1-6336-e9f5fa3a6168@suse.de>
 <CAHckoCxcmNC++AXELmnCVZNjpHcaOQWOGcjia=NBCnOA7S7EeQ@mail.gmail.com>
In-Reply-To: <CAHckoCxcmNC++AXELmnCVZNjpHcaOQWOGcjia=NBCnOA7S7EeQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH8PR12MB7351:EE_
x-ms-office365-filtering-correlation-id: c175ca12-505b-41ce-041f-08db3deef699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yn7PzGbB7GEX+8odAbWsFPq8oDMsgbiWcVYGDVn2DUbcfeAW6E9Vq8avtcE0LQwpUXxYnses2k/CyzfyDExNBQJ6fDrjT0BrVhGs02WveFPjd9nYAEUb5ndL8L8wPAuPpLVYuXYOUtTtx1xs8TwyCMun22X6Jwe7HLiO21HtG9Z7z1qZ64L5EtOYWEYKEJSUQRnNMZQCZeNz2f//T8CQYRDFDHSui3g+hUa1SvzZm6BiHjULWR45/znIvp7j+aLOqTf3E6ZEHx3Vy3HB9HnMD1Ff8A3pS51usm1EGanUKxD13UQIDnPpDB498LTCqtf3XwiFqjnkU1F1mgbkQ0uF1xTFiGZUR6NxmQPMbE1sK36jIekGLRmF57ga+Lta27havkiupTEAOVCcNaiYgLQ7NxlRFqqpRyS0p2+SHOdU2SIUy5If3KJ4Uh+1e/UnZ0i6XXzo3lnJDRbpqXv2ReYxFuObtpiTjUPk6022SZIzImt69RAyVEWmMM+KvLXanUuqop3TM3K1ryXzQfAkyCMXzGxPp8R1WQ4Em2W+04AkkZoAArnTZa7GUfb4rJojsJXgLGi/dwdG82ndPYEOYni6f0LBaRP2XFP39zgF2x5eWqgVkx9buu/2YSowIK6GgwlD0FjbuofpUTOuGTDe3eUgFp0CgKNEpjx1ooOOpLlDvPt0942QNu0LhGDDY7pKkoWE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(5660300002)(71200400001)(6486002)(66556008)(66476007)(2906002)(66946007)(4326008)(91956017)(76116006)(64756008)(36756003)(66446008)(86362001)(38070700005)(122000001)(41300700001)(478600001)(38100700002)(316002)(8936002)(8676002)(31696002)(54906003)(53546011)(110136005)(31686004)(6512007)(6506007)(2616005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0JzenZrWXhPRUQrS2FBdzQ3SGpaUml2ekJyMjI4VithZGlOY09nY29kR1pM?=
 =?utf-8?B?VnAzQ2xQcVRieWtQZnYwWVd4SEE1bG55clA3Z2dJS2FKVE5PSmdzU2xGelpm?=
 =?utf-8?B?eUQ4emQ5dWJSRzh3c2pKQmIzczdnd1B5YVN5azE0dHdwVjRvY0tHTFRQRzFR?=
 =?utf-8?B?MUdRcitVVzFMRWJNSHRCWmNVVHlPaFlWVE02a2lDZ2VqZjIvNDNCUm1ORjVE?=
 =?utf-8?B?V2ZCQlQ5Njc2OThnc2R6eXVjaTMvRnpsbjhzRkltekZqWEYwK3Vwdko2L3Vv?=
 =?utf-8?B?L2grRWNzUnMrOEpHbkl2Rjl1UXR1VHZBZlBDRExqb1AvaGJ4b2VSWjNIWkpa?=
 =?utf-8?B?UzBDYkNNNkFUZVk5MkVTa3NSRFRCVzIzK1d5Q3FKcGJVdEUwdHRlNHlveHlC?=
 =?utf-8?B?RmN4R1IxYm1sN0YvUkxnZ1o0WnhpRjBRU0pYTmFRS05YVUtIUTh6aUNLK1hD?=
 =?utf-8?B?bGpjLzRqclJTLzhuT0ZzRUdZamhsWFNiZ0V3VVkyMVhvbWl3ZVgxZHM2VHhN?=
 =?utf-8?B?L3dSZEY5QkQ1QTVrSG9jbmVleWEvR0luc050S3FGZktCMDJ4VWhvSUNUMDh6?=
 =?utf-8?B?eCsyRDF6b0N5TndIa3lrMERJQ3NJUmJPMG83YVRuVDlHOTJNR3VqL2YrRGx5?=
 =?utf-8?B?ckVmNEJxZEIzTEZxZ213WmVEcGhvK3lwd1ZqOHhOSmgrT1Z1d05EZVR2dTVz?=
 =?utf-8?B?NjZ1ci83d05jMWpucVl5Qld5aGt4SVhkT2lWQW5wL1FXM1NhQW9LQ0ZiRGNX?=
 =?utf-8?B?aW1SS2NKdnBYSVZtelNWZmJrV1g5bmpGamUzc0dyK2lzMDBtemVGaU5pOFVj?=
 =?utf-8?B?R3Z6cFUyWFh0Rkk0K0ZOTWYxc0hZTnBSVEdYZ0ordUhaNi9TUFJyUnloekRY?=
 =?utf-8?B?elMyL1Q3QVZHUTRkSzJobmJ5ZEdxcEdEdUhPSm8wdzEyS2hMRXVjOThiNkd0?=
 =?utf-8?B?NnBlKzQ0emUwb0lnRGwzYjkwb3ArMkFFdEdxVHZsZ2ZLeU9BZW9aSTBjVmVG?=
 =?utf-8?B?Wkd5UldCaVY3eDE0MHZCVU11ckdrSG1zbDlYZmNOSTN4eXJ5MWRIM1NYUlZE?=
 =?utf-8?B?MnV2SnIrMzdoR09aUGZoZUFXWWpzclZFOG9KZ1cyNjZqcllVUXp0NUsvNDBs?=
 =?utf-8?B?V3ViUkEwbm44Zjd6eFRvSGRxSm9pREYwY2IxdThrZnQzdVQrZWlIeTA2TnBR?=
 =?utf-8?B?M2Fta01NYy9RMFBxT3hvNFNob1E0S2UyaDg3RGoraE5wMFh3bUlFWFg1UFJh?=
 =?utf-8?B?WnJlYWhPNnY0ZzFqTUNWU0ZHTnE2WTN6U0crVHp6WWVqVUllUk5qMVRrY2xT?=
 =?utf-8?B?L2luN09VT2FTYXNmWkFrcUdGT0pkZWNraXYrd2RuVmU2czRhdHMwckN3N0RI?=
 =?utf-8?B?Y1dUeXl5NWZyTjdYdmlTOEU2aDlQS0NUcERnWW5VWXdNQklINmsvTHVidmRk?=
 =?utf-8?B?OVBWUG5RUkVUbWU2UVdDTUErZjUwQkJkaktOTnlLNm5mTmRnNWJ0RHEyVDV1?=
 =?utf-8?B?eUhRN2lQNlFINjI2U05uZEFwUll2SVRhYzR6YWN4QXR6VFlWVnEyNnFwY3dH?=
 =?utf-8?B?UGpFQTV0TDEzcVpvaHFoWFpzUXNBbEVFRVd0QzEyQU5kbVNJMk85KzFMVWlM?=
 =?utf-8?B?NkcreUlaKzZBNnZHSXhvcWZOdzZVK2hOczRDbG9HY2FTZUxoNDJLTjA4Y2Fm?=
 =?utf-8?B?Sk50dStjMUNUTVR3YU54VjBDMkRleVdscGVBemQ2YTFpSkcxS2oyaDdqZFdl?=
 =?utf-8?B?V0xsMzY5c243MmhpS0RNajcwbC9nZkxUVmFCMjZoU3R3VG9nYnlHVzk0cS9r?=
 =?utf-8?B?MW9VTmpEWmNBbCt2bGF2QU5EaXBoL1kxTWpadnJTS1JPMmJoTlorSFQxL1Iy?=
 =?utf-8?B?U1NmVENwd2xhT2tFSU9Vb0VYbS9BWUdBeWtTSzJXWGNwMVFlQUZxRnZ4OWlz?=
 =?utf-8?B?WlZ5UytlSnNua20vNnJTMXhrcXh1bHFNOU1tZXZMaFQySUljbTVkdFQ4OEpm?=
 =?utf-8?B?dGdvWEdGenYzREpSSE9KNkFCTzJ4STV4cmU1YklKWEdVSGN5bkJqcXlua0Zm?=
 =?utf-8?B?WHJNclZrLzNZZWpRRFdtRTVJWGh4TnUxQmdmUVp2R08vTkpTTzNyVFRGeXNw?=
 =?utf-8?B?RXFQVU9oSmpGaElqSWl0b1NNY3hSdEduNnduWi8rOWh2VFpDME9oUzcyOWsx?=
 =?utf-8?Q?sGg17xy6jpnWAj/glwW1xthLraXs5c2TaYimtb9GSun2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A09EC4ED35F2B247B65EFB683145E4B5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c175ca12-505b-41ce-041f-08db3deef699
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2023 20:21:15.1420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzQPsYZ/W8w5SCnLUNIhXB3z5MglFAjL9n76U1TVqImIGrbmde8mEmEDfHh6tGaOujmOwDjv0p85X2sgftGKFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNC8yMyAwMjozNSwgTGkgRmVuZyB3cm90ZToNCj4gT24gRnJpLCBBcHIgMTQsIDIwMjMg
YXQgNDozNuKAr1BNIEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4+IE9u
IDQvMTMvMjMgMTU6MjksIExpIEZlbmcgd3JvdGU6DQo+Pj4gVGhlIGRlZmF1bHQgd29ya2VyIGFm
ZmluaXR5IHBvbGljeSBpcyB1c2luZyBhbGwgb25saW5lIGNwdXMsIGUuZy4gZnJvbSAwDQo+Pj4g
dG8gTi0xLiBIb3dldmVyLCBzb21lIGNwdXMgYXJlIGJ1c3kgZm9yIG90aGVyIGpvYnMsIHRoZW4g
dGhlIG52bWUtdGNwIHdpbGwNCj4+PiBoYXZlIGEgYmFkIHBlcmZvcm1hbmNlLg0KPj4+DQo+Pj4g
VGhpcyBwYXRjaCBhZGRzIGEgbW9kdWxlIHBhcmFtZXRlciB0byBzZXQgdGhlIGNwdSBhZmZpbml0
eSBmb3IgdGhlIG52bWUtdGNwDQo+Pj4gc29ja2V0IHdvcmtlciB0aHJlYWRzLiAgVGhlIHBhcmFt
ZXRlciBpcyBhIGNvbW1hIHNlcGFyYXRlZCBsaXN0IG9mIENQVQ0KPj4+IG51bWJlcnMuICBUaGUg
bGlzdCBpcyBwYXJzZWQgYW5kIHRoZSByZXN1bHRpbmcgY3B1bWFzayBpcyB1c2VkIHRvIHNldCB0
aGUNCj4+PiBhZmZpbml0eSBvZiB0aGUgc29ja2V0IHdvcmtlciB0aHJlYWRzLiAgSWYgdGhlIGxp
c3QgaXMgZW1wdHkgb3IgdGhlDQo+Pj4gcGFyc2luZyBmYWlscywgdGhlIGRlZmF1bHQgYWZmaW5p
dHkgaXMgdXNlZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IExpIEZlbmcgPGZlbmdsaUBzbWFy
dHguY29tPg0KPj4+IC0tLQ0KPj4+DQo+Pj4gVjIgLSBGaXggbWlzc2luZyBzdGF0aWMgcmVwb3J0
ZWQgYnkgbGtwDQo+Pj4NCj4+PiAgICBkcml2ZXJzL252bWUvaG9zdC90Y3AuYyB8IDU0ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+Pj4gICAgMSBmaWxlIGNoYW5n
ZWQsIDUzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+Pj4g
aW5kZXggNDljOWU3YmM5MTE2Li40Nzc0OGRlNTE1OWIgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVy
cy9udm1lL2hvc3QvdGNwLmMNCj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KPj4+
IEBAIC0zMSw2ICszMSwxOCBAQCBzdGF0aWMgaW50IHNvX3ByaW9yaXR5Ow0KPj4+ICAgIG1vZHVs
ZV9wYXJhbShzb19wcmlvcml0eSwgaW50LCAwNjQ0KTsNCj4+PiAgICBNT0RVTEVfUEFSTV9ERVND
KHNvX3ByaW9yaXR5LCAibnZtZSB0Y3Agc29ja2V0IG9wdGltaXplIHByaW9yaXR5Iik7DQo+Pj4N
Cj4+PiArLyogU3VwcG9ydCBmb3Igc3BlY2lmeWluZyB0aGUgQ1BVIGFmZmluaXR5IGZvciB0aGUg
bnZtZS10Y3Agc29ja2V0IHdvcmtlcg0KPj4+ICsgKiB0aHJlYWRzLiAgVGhpcyBpcyBhIGNvbW1h
IHNlcGFyYXRlZCBsaXN0IG9mIENQVSBudW1iZXJzLiAgVGhlIGxpc3QgaXMNCj4+PiArICogcGFy
c2VkIGFuZCB0aGUgcmVzdWx0aW5nIGNwdW1hc2sgaXMgdXNlZCB0byBzZXQgdGhlIGFmZmluaXR5
IG9mIHRoZQ0KPj4+ICsgKiBzb2NrZXQgd29ya2VyIHRocmVhZHMuICBJZiB0aGUgbGlzdCBpcyBl
bXB0eSBvciB0aGUgcGFyc2luZyBmYWlscywgdGhlDQo+Pj4gKyAqIGRlZmF1bHQgYWZmaW5pdHkg
aXMgdXNlZC4NCj4+PiArICovDQo+Pj4gK3N0YXRpYyBjaGFyICpjcHVfYWZmaW5pdHlfbGlzdDsN
Cj4+PiArbW9kdWxlX3BhcmFtKGNwdV9hZmZpbml0eV9saXN0LCBjaGFycCwgMDY0NCk7DQo+Pj4g
K01PRFVMRV9QQVJNX0RFU0MoY3B1X2FmZmluaXR5X2xpc3QsICJudm1lIHRjcCBzb2NrZXQgd29y
a2VyIGNwdSBhZmZpbml0eSBsaXN0Iik7DQo+Pj4gKw0KPj4+ICtzdGF0aWMgc3RydWN0IGNwdW1h
c2sgY3B1X2FmZmluaXR5X21hc2s7DQo+Pj4gKw0KPj4+ICAgICNpZmRlZiBDT05GSUdfREVCVUdf
TE9DS19BTExPQw0KPj4+ICAgIC8qIGxvY2tkZXAgY2FuIGRldGVjdCBhIGNpcmN1bGFyIGRlcGVu
ZGVuY3kgb2YgdGhlIGZvcm0NCj4+PiAgICAgKiAgIHNrX2xvY2sgLT4gbW1hcF9sb2NrIChwYWdl
IGZhdWx0KSAtPiBmcyBsb2NrcyAtPiBza19sb2NrDQo+Pj4gQEAgLTE0ODMsNiArMTQ5NSw0MSBA
QCBzdGF0aWMgYm9vbCBudm1lX3RjcF9wb2xsX3F1ZXVlKHN0cnVjdCBudm1lX3RjcF9xdWV1ZSAq
cXVldWUpDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIGN0cmwtPmlvX3F1ZXVlc1tIQ1RY
X1RZUEVfUE9MTF07DQo+Pj4gICAgfQ0KPj4+DQo+Pj4gK3N0YXRpYyBzc2l6ZV90IHVwZGF0ZV9j
cHVfYWZmaW5pdHkoY29uc3QgY2hhciAqYnVmKQ0KPj4+ICt7DQo+Pj4gKyAgICAgY3B1bWFza192
YXJfdCBuZXdfdmFsdWU7DQo+Pj4gKyAgICAgY3B1bWFza192YXJfdCBkc3RfdmFsdWU7DQo+Pj4g
KyAgICAgaW50IGVyciA9IDA7DQo+Pj4gKw0KPj4+ICsgICAgIGlmICghemFsbG9jX2NwdW1hc2tf
dmFyKCZuZXdfdmFsdWUsIEdGUF9LRVJORUwpKQ0KPj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9NRU07DQo+Pj4gKw0KPj4+ICsgICAgIGVyciA9IGJpdG1hcF9wYXJzZWxpc3QoYnVmLCBjcHVt
YXNrX2JpdHMobmV3X3ZhbHVlKSwgbnJfY3B1bWFza19iaXRzKTsNCj4+PiArICAgICBpZiAoZXJy
KQ0KPj4+ICsgICAgICAgICAgICAgZ290byBmcmVlX25ld19jcHVtYXNrOw0KPj4+ICsNCj4+PiAr
ICAgICBpZiAoIXphbGxvY19jcHVtYXNrX3ZhcigmZHN0X3ZhbHVlLCBHRlBfS0VSTkVMKSkgew0K
Pj4+ICsgICAgICAgICAgICAgZXJyID0gLUVOT01FTTsNCj4+PiArICAgICAgICAgICAgIGdvdG8g
ZnJlZV9uZXdfY3B1bWFzazsNCj4+PiArICAgICB9DQo+Pj4gKw0KPj4+ICsgICAgIC8qDQo+Pj4g
KyAgICAgICogSWYgdGhlIG5ld192YWx1ZSBkb2VzIG5vdCBoYXZlIGFueSBpbnRlcnNlY3Rpb24g
d2l0aCB0aGUgY3B1X29ubGluZV9tYXNrLA0KPj4+ICsgICAgICAqIHRoZSBkc3RfdmFsdWUgd2ls
bCBiZSBlbXB0eSwgdGhlbiBrZWVwIHRoZSBjcHVfYWZmaW5pdHlfbWFzayBhcyBjcHVfb25saW5l
X21hc2suDQo+Pj4gKyAgICAgICovDQo+Pj4gKyAgICAgaWYgKGNwdW1hc2tfYW5kKGRzdF92YWx1
ZSwgbmV3X3ZhbHVlLCBjcHVfb25saW5lX21hc2spKQ0KPj4+ICsgICAgICAgICAgICAgY3B1X2Fm
ZmluaXR5X21hc2sgPSAqZHN0X3ZhbHVlOw0KPj4+ICsNCj4+PiArICAgICBmcmVlX2NwdW1hc2tf
dmFyKGRzdF92YWx1ZSk7DQo+Pj4gKw0KPj4+ICtmcmVlX25ld19jcHVtYXNrOg0KPj4+ICsgICAg
IGZyZWVfY3B1bWFza192YXIobmV3X3ZhbHVlKTsNCj4+PiArICAgICBpZiAoZXJyKQ0KPj4+ICsg
ICAgICAgICAgICAgcHJfZXJyKCJmYWlsZWQgdG8gdXBkYXRlIGNwdSBhZmZpbml0eSBtYXNrLCBi
YWQgYWZmaW5pdHkgbGlzdCBbJXNdLCBlcnIgJWRcbiIsDQo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgIGJ1ZiwgZXJyKTsNCj4+PiArICAgICByZXR1cm4gZXJyOw0KPj4+ICt9DQo+Pj4gKw0KPj4+
ICAgIHN0YXRpYyB2b2lkIG52bWVfdGNwX3NldF9xdWV1ZV9pb19jcHUoc3RydWN0IG52bWVfdGNw
X3F1ZXVlICpxdWV1ZSkNCj4+PiAgICB7DQo+Pj4gICAgICAgIHN0cnVjdCBudm1lX3RjcF9jdHJs
ICpjdHJsID0gcXVldWUtPmN0cmw7DQo+Pj4gQEAgLTE0OTYsNyArMTU0MywxMiBAQCBzdGF0aWMg
dm9pZCBudm1lX3RjcF9zZXRfcXVldWVfaW9fY3B1KHN0cnVjdCBudm1lX3RjcF9xdWV1ZSAqcXVl
dWUpDQo+Pj4gICAgICAgIGVsc2UgaWYgKG52bWVfdGNwX3BvbGxfcXVldWUocXVldWUpKQ0KPj4+
ICAgICAgICAgICAgICAgIG4gPSBxaWQgLSBjdHJsLT5pb19xdWV1ZXNbSENUWF9UWVBFX0RFRkFV
TFRdIC0NCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3RybC0+aW9fcXVldWVz
W0hDVFhfVFlQRV9SRUFEXSAtIDE7DQo+Pj4gLSAgICAgcXVldWUtPmlvX2NwdSA9IGNwdW1hc2tf
bmV4dF93cmFwKG4gLSAxLCBjcHVfb25saW5lX21hc2ssIC0xLCBmYWxzZSk7DQo+Pj4gKw0KPj4+
ICsgICAgIGlmICghY3B1X2FmZmluaXR5X2xpc3QgfHwgdXBkYXRlX2NwdV9hZmZpbml0eShjcHVf
YWZmaW5pdHlfbGlzdCkgIT0gMCkgew0KPj4+ICsgICAgICAgICAgICAgLy8gU2V0IHRoZSBkZWZh
dWx0IGNwdV9hZmZpbml0eV9tYXNrIHRvIGNwdV9vbmxpbmVfbWFzaw0KPj4+ICsgICAgICAgICAg
ICAgY3B1X2FmZmluaXR5X21hc2sgPSAqY3B1X29ubGluZV9tYXNrOw0KPj4+ICsgICAgIH0NCj4+
PiArICAgICBxdWV1ZS0+aW9fY3B1ID0gY3B1bWFza19uZXh0X3dyYXAobiAtIDEsICZjcHVfYWZm
aW5pdHlfbWFzaywgLTEsIGZhbHNlKTsNCj4+PiAgICB9DQo+Pj4NCj4+PiAgICBzdGF0aWMgaW50
IG52bWVfdGNwX2FsbG9jX3F1ZXVlKHN0cnVjdCBudm1lX2N0cmwgKm5jdHJsLCBpbnQgcWlkKQ0K
Pj4gSSBhbSBub3QgaW4gZmF2b3VyIG9mIHRoaXMuDQo+PiBOVk1lLW92ZXItRmFicmljcyBoYXMg
X3ZpcnR1YWxfIHF1ZXVlcywgd2hpY2ggcmVhbGx5IGhhdmUgbm8NCj4+IHJlbGF0aW9uc2hpcCB0
byB0aGUgdW5kZXJseWluZyBoYXJkd2FyZS4NCj4+IFNvIHRyeWluZyB0byBiZSBjbGV2ZXIgaGVy
ZSBieSB0YWNraW5nIHF1ZXVlcyB0byBDUFVzIHNvcnQgb2Ygd29ya3MgaWYNCj4+IHlvdSBoYXZl
IG9uZSBzdWJzeXN0ZW0gdG8gdGFsayB0bywgYnV0IGlmIHlvdSBoYXZlIHNldmVyYWwgd2hlcmUg
ZWFjaA0KPj4gZXhwb3NlcyBhIF9kaWZmZXJlbnRfIG51bWJlciBvZiBxdWV1ZXMgeW91IGVuZCB1
cCB3aXRoIGEgcXVpdGUNCj4+IHN1Ym9wdGltYWwgc2V0dGluZyAoaWUgeW91IHJlbHkgb24gdGhl
IHJlc3VsdGluZyBjcHUgc2V0cyB0byBvdmVybGFwLA0KPj4gYnV0IHRoZXJlIGlzIG5vIGd1YXJh
bnRlZSB0aGF0IHRoZXkgZG8pLg0KPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudC4NCj4gVGhlIGN1
cnJlbnQgaW8tcXVldWVzL2NwdSBtYXAgbWV0aG9kIGlzIG5vdCBvcHRpbWFsLg0KPiBJdCBpcyBz
dHVwaWQsIGFuZCBqdXN0IHN0YXJ0cyBmcm9tIDAgdG8gdGhlIGxhc3QgQ1BVLCB3aGljaCBpcyBu
b3QgY29uZmlndXJhYmxlLg0KPg0KPj4gUmF0aGVyIGxlYXZlIGl0IHRvIHRoZSBoYXJkd2FyZSB0
byBzb3J0IHRoaW5ncyBvdXQsIGFuZCByZWx5IG9uIHRoZQ0KPj4gYmxrLW1xIENQVSBtYXBwaW5n
IHRvIGdldCBJL08gYWxpZ25lZCB0byBDUFVzLg0KPj4NCj4+IENoZWVycywNCj4+DQo+PiBIYW5u
ZXMNCj4+DQo+IFRoZSBudm1lLXRjcCBjdXJyZW50bHkgZG9lc24ndCBzdXBwb3J0IGEgKmNsZXZl
ciogbWV0aG9kIHRvIGJpbmQgdGhlDQo+IGlvLXF1ZXVlIGFuZCBjcHUsDQo+IGl0J3MgZGVjaWRl
ZCBhdCB0aGUgYWxsb2NhdGlvbiBhbmQgZG9lc24ndCBoYXZlIGEgbWV0aG9kIHRvIGNoYW5nZSBp
dC4NCj4gRS5nLiBPbmUgc3Vic3lzdGVtJ3MgZmlyc3QgaW8gcXVldWUgYmluZHMgdG8gQ1BVMCwg
dGhlIG5leHQgaW8gcXVldWUNCj4gYmluZHMgdG8gQ1BVMSwgYW5kDQo+IGlmIHRoZSBOSUMgaXMg
bG9jYXRlZCBvbiB0aGUgb3RoZXIgTlVNQSBub2RlIDIoQ1BVMjQgLSBDUFUzNiksIGFuZA0KPiBi
aW5kcyB0aGUgZmlvIHRvIE5VTUEgbm9kZSAyLA0KPiB0aGUgbnZtZS10Y3Agd2lsbCBzdGlsbCBo
YXZlIHBvb3IgcGVyZm9ybWFuY2Usc28gaG93IHNob3VsZCBJIHR1bmUgdGhlDQo+IHBlcmZvcm1h
bmNlPw0KPiBJIGhhdmUgdG8gY2hhbmdlIHRoZSBuaWMgaXJxIGFmZmluaXR5LCBidXQgaXQgd2ls
bCBodXJ0IG90aGVyIG51bWENCj4gbm9kZTIgYXBwbGljYXRpb24ncyBwZXJmb3JtYW5jZS4NCj4g
V2Ugc2hvdWxkIG1heGltaXplIG9uZSBzdWJzeXN0ZW0gcGVyZm9ybWFuY2UsIHRoZW4gbWF4aW1p
emUgbXVsdGlwbGUNCj4gc3Vic3lzdGVtcyBwZXJmb3JtYW5jZS4NCj4NCj4gVGhpcyBwYXRjaCBn
aXZlcyBhIGNoYW5jZSB0byBhZGFwdCB0aGUgbmljIGFuZCBjcHUgbG9hZC4NCj4gQmVmb3JlIGFu
ZCBhZnRlciBwYXRjaCwgb24gbXkgYWFyY2g2NCBzZXJ2ZXIgd2l0aCA0IG51bWEgbm9kZXMsIHRo
ZQ0KPiAyNTZrIHJlYWQgdGhyb3VnaHB1dCB1cHMNCj4gZnJvbSAxR0IvcyB0byAxLjRHQi9zLg0K
Pg0KPiBUaGFua3MuDQo+DQoNCg0KRm9yIHBhdGNoIGxpa2UgdGhpcyBpdCBuZWVkcyB0byBiZSBi
YWNrZWQgYnkgdGhlIGRldGFpbGVkIHBlcmZvcm1hbmNlDQphbmFseXNpcyB0byBzdGFydCB3aXRo
LCBib3RoIHdpdGggYW5kIHdpdGhvdXQgdGhpcyBwYXRjaCB0byBwcm92ZSBpdCcNCnVzZWZ1bG5l
c3Mgd2l0aCBxdWFudGl0YXRpdmUgZGF0YSwgdGhhdCB3aWxsIGF2b2lkIGFueSBmdXJ0aGVyIHF1
ZXN0aW9ucw0KYW5kIGFsbG93IHJldmlld2VycyB0byBjb21lIHRvIHRoZSBjb25jbHVzaW9uIGZh
c3RlciAuLi4NCg0KQWxzbywgcGxlYXNlIG1ha2Ugc3VyZSB0byBjb3ZlciBhbGwgcG9zc2libGUg
Z2VuZXJhbCB1c2VjYXNlcyB0byBhdm9pZA0KZnVydGhlciBxdWVzdGlvbnMgc3VjaCBhcyBvbmUg
c3Vic3lzdGVtIHBlcmZvcm1hbmNlIHZzIG11bHRpcGxlIHN1c2JzeXMNCnBlcmZvcm1hbmNlIC4u
DQoNCi1jaw0KDQoNCg==
