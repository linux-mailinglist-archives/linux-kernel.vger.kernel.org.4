Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DECE5B8DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiINRQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiINRQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:16:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E239580362;
        Wed, 14 Sep 2022 10:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOaIG/Xa7p7JKqR7mmyc0dOP0662yMivl98D9Outi5gNRwHLpsLc8UCOC1C88jq+EBrSbPPLQ1KNYVjE/B0iDb/lAUvofcP+wuUNR0K5mWoTauLTBDNF+F2P2jaSOhcBhmLzFeOJUlQhB9dOCbOjPirNof+Sw30FEuj+DAkDjUsvmpAU27UP8ayAl8kHbwQ72Xk5Muzl4qJAMUPLaDNIeAExtSfKTEEpkKcjaA4hZpodBCOr350vepwnRKKRbTyFD3rfUDNB+DMh+rKcqg5QxOFjAXJ4sz4AUB8S93gV1+882YX6/QpmmdYgl7xcSpBYEXPCtmOup5xfVx23T6x52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqEgn04zuQKrQlStvg/voE3I25tRR3LeRvISJcp1a88=;
 b=jceOauymZDecgqr2BP0dA/BLPgFa3J0sr/vD+r3Tmx7PEn1BioySso2t5ZSsPvwxrmOTTGUn4ZYChZYkRK1P325uyxYvQX+cV38VkSwCYj/NHu/TgMnB7ILgLZFuYOJQpz/K0dfbHWFPn3/HwFjP0JaEGbhgbZPhW66I2Cnj1QLEm22Axila0IHkjoc+20m6yqPcVw8Q5vaNL/qCqhSa7lEdltXfJO2LHD2SmlPxisCBTJxbzU2SGqffnV5nWsur+4SYvKYZ0UW6Vl3KrfUCxSRxJlEG7ii1MA35OsUyYTxghUpiKvY1VRXMqovx8FWdP/g40Wj+9BudwapyPvNLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqEgn04zuQKrQlStvg/voE3I25tRR3LeRvISJcp1a88=;
 b=ADynS1d7pvk77pQ1Qaqgo29J8KAaE6ixHZP9P5qHwI6Hozgw5lxa/InYtzbX9CVVmhtBymajQH8+wLKt9rJcH435lxYCKNRp9wYJxn5IA+1eepT9AZv6ea3TcycVH8lqofQMnSdXFGg1gCExTgQu4i0ApP8cxM1tW4Oskch8OADj97oh4awvWHQwSWKgSvx1IH5QIonpCveauQJVKdNMeqOxPF1dMXSN75dzGcJ7yqR03PfL7nvsVARj1OXq4GAg+cTKv0ucrAb/JZSPV3cGPj9+yhdiVl9aABPROp5Wd3kWewbXY6jcPORl1VihU0hyuwEr0unmWGwmZA8BDqU+wQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 17:16:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:16:27 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "agk@redhat.com" <agk@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v13 04/13] nvmet: Allow ZNS target to support
 non-power_of_2 zone sizes
Thread-Topic: [PATCH v13 04/13] nvmet: Allow ZNS target to support
 non-power_of_2 zone sizes
Thread-Index: AQHYxoEEfkoL2N3az02viUUiX825YK3fLnCA
Date:   Wed, 14 Sep 2022 17:16:27 +0000
Message-ID: <435aa30a-9d1e-e8e6-6a14-6f5f612cf083@nvidia.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082210eucas1p2a27e358b12b0e4b06a7e00938251c90c@eucas1p2.samsung.com>
 <20220912082204.51189-5-p.raghav@samsung.com>
In-Reply-To: <20220912082204.51189-5-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4052:EE_
x-ms-office365-filtering-correlation-id: 28fcf567-af3b-475b-9bb7-08da9674dbeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WkZEtKCDZTFfvgfZZo4ShG4c5vfjcxkTFnBPS8KejEyQ6NNKmrvZ18O0xTKBCOlwvTDWi3Dv++YdR3HDKDIAoT22+ClqyMd7bQpTwZO9HOYgUo+i3gk89L1ly75yxA8a1f2IFAM/9uSaGVfPZ6HWrgE7Dlwc4zhpO52AUlWiXSEJfUowLp1RvSYRq0uPgpHr8/2zQt2ZAQ2Up7rTr++9KK91GFL9Mca3cwPzojUhDb79zB9qu+AgGDD0YLFvhN7hR2+aBjmw+N34vb7y6KxeUBY/IkpMUoZOYvb6uNN+HPKXRWJ2gQWW8LU2/P/CTdDMu/LuwcoLLGXr6UlpjrFlGHuTSUDtTzjIF+HWPlB4DEOwRwe2pmE5SPVzWDVA0avegDJspcW4vRm3gT7ReNZ2z6wIN1miIX9p2ob9r7Atxs9oZJ41euvh/SGv35fqOyACQy3uhxSHsjZ8kY0DnK9V4Zn3z4F6v77MJrpKM3iDulO8qzXc0KI5bM03xK/XBlieE76tg0i8vGoke+UnR0T4bCvo+snKEnNdOiHOYnnOrP9HEttjPcsYaO+E7tibCmtxEkhAXYnzcuE1K3ac7dV5LJxiUK6nb4urTtKefSEtOvgxQwmAqpdTOJsSoVy1+DdE2F6a5Y7z1j2pZo8nFzq4RSHHr0JHazOgsJJjpT2AL3T/nujyOvao2Rsx46vhqn581B9nBUc7hql6CUqxcefqwhYTHmtw44GNPGYmjmokUCOGAJnoLDvcENDFDhUDO0aCD8TiYJfDChAe8kR5qQg1wGvRM11BreOnFYT2XLfYX4J6Gdur9UnHiKcRqyorldzCWejjlFAPUe1PktAg3POaug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(8936002)(71200400001)(110136005)(6512007)(83380400001)(38100700002)(8676002)(26005)(31696002)(38070700005)(478600001)(66946007)(6506007)(4326008)(86362001)(7416002)(66476007)(66446008)(64756008)(186003)(76116006)(66556008)(6486002)(53546011)(5660300002)(91956017)(2616005)(4744005)(54906003)(36756003)(122000001)(31686004)(2906002)(316002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTByVElJaEF2ZWRsZXRybzVZRGtHWEJFL1hZWUFJc1JTL084RkNmWnM3dlFj?=
 =?utf-8?B?MkZXZ1RJaXZ6UVR4RnpidDZXOTlGYnpNMFBna2h1UE1seFdPNXZtMTlqT1FH?=
 =?utf-8?B?d1NxSXdBOTBmWjBpblJDVW0vcCtSYUw5STc3NTlmaUhCa1ZQbDBseS9SRDVF?=
 =?utf-8?B?QTBHT0U3QWpiSjc0MlBUVGtyMjcrdGpiTlJJUEcxWkRCNWxFWFlLU1lwcW5h?=
 =?utf-8?B?OXlsQUZlekp2LzJ0a2VJWkt5R2x4c2YvNDkxd2hndlJ5d3FtSkh2dFNyRnJn?=
 =?utf-8?B?b2lLMGZBa1U1WEZSaUNjck9sL3NUSks0VjJ6aE5SR2hFNUFnOWk5R2tvMnVO?=
 =?utf-8?B?SFJtQXI0Y2d0S0dQN3RPVldpZHhWREdyV0VETVBHVzZmSjRXWWRVemtpVDBC?=
 =?utf-8?B?MXF0ZEZQcWQ2empqWThxbEpXTTkvYWpQaFRkNEFpMi9LWUhMQ1ZxdFpOVlh4?=
 =?utf-8?B?TmdoWVJoeXFuNVdRNEVsR3NFbjZmZkY0SWduMnkramxQaERaSTBRUGVZZkJ1?=
 =?utf-8?B?a094VVFHWXlqdmVyWm5lS05sVWg2ckVCK05ubFI2R1pBT1FjWVlVaVBpYytP?=
 =?utf-8?B?NUZvYUtIYmJjTnJ3ejYzWHFVQjkvQWZFbEh4VGZJQ25xcE1WR01WV3p1T2lX?=
 =?utf-8?B?Qm1UR3hjRVozNmFHdmZLTVR4ejNielNyUUVhR0dFMEFEd0hXSE1OWkpsWjR2?=
 =?utf-8?B?dWZTOUpQOXkxcFpmNTA0dHk0VkJ2d0FKWnhDckM0R1pOOHFCUnJlRlpNNEI4?=
 =?utf-8?B?TDcrS3cvdEZpMDZPZFZVY3R6dS8wSEVjdFNTNjZUUWJMMXJBU2tlN3IwTStY?=
 =?utf-8?B?TlQzWmw5OENkVGtSczludW9vQ0pmeWUrL1Zma0NkWUpoaEZjN0ttazVLenlZ?=
 =?utf-8?B?QjlIUkFJQ0xSNDBEY25FUG1qaGZNRWRvT211WDhqK01WR2k1dlE2ZXV0RWxV?=
 =?utf-8?B?dmt0Z0w5aUdxL0VSemM4aUxZUGErZ2xhUElMZXE4RVlHZENkOHV3MVNwTWdx?=
 =?utf-8?B?elRMNmprMG1rMnMraG5NSytQbGZBRHZWeThkUHloUVhkTkozN2o1WGlYcmw5?=
 =?utf-8?B?YnN6L3JmOUpya1A4YncxVzNCZk5MNEdhOWdGUG1FOEZxVm9wb3JiOURNU0VD?=
 =?utf-8?B?dmlSOWpSSFVFLzBRbjBBaldSRmZZNXVtV2o3RnJ6VnI1M0s2UzlITmZFanhB?=
 =?utf-8?B?TnRXQWJTWlZWeEE3bkMyeDM2MlcvZ0VqbDBwM1pJQ2tSd3grSjlneGlSeFRS?=
 =?utf-8?B?enBJN29rQmxhdS9mWDhNTVlLLzEvS3lCd3lCNVMyYUo1SDFZTEZzbTBqVFor?=
 =?utf-8?B?SFlNU0wxbjhRY21RR29GYzMreWwzQ0wwNGxBR2gvUnUzaUE5UFl1ZDVxaWE3?=
 =?utf-8?B?TjkzY3BGaFROMlJxKzhQRU9WbC9pM2c3VFhJam01QW9OaTFoM0tYeDc2S3g3?=
 =?utf-8?B?V2Z6aVp4VVNKb1BiejRXbmpTbEFndUZjMEhzbXFqS1k4UWdMZ0hkZXBUcytC?=
 =?utf-8?B?TTZ4MTNydHFtS3VKOFVhcmt0T2ZPQjdqNVJtOXVydXZIbjk4eDZrVnE1c3pI?=
 =?utf-8?B?ZEZwS2ZqZU0zTnBVY1VSRHZlU1ZTMXR2U3kvaGh5Y3JRMHUrQXExdDBLci9h?=
 =?utf-8?B?eEplMG1mWFNORlM3djRSRWU5ZnBtVGJ3OGcvS3hHeEVCejdmV2l5TXhiU2lw?=
 =?utf-8?B?QkNaS05FeXMxM005M3ZneUlCUWUvOExHdHBFbkVDZUd2YTVGZWkwQi9La1g0?=
 =?utf-8?B?ZFIxajJBYVFnTk9kODFESGJtQmJrYnVlM2pSc0pQM0hrTzhKZkc1eUJoWFlO?=
 =?utf-8?B?RGJ5Q085RXhXcGxtdVlZK0s0QkJCRjlNQlRlM25KaDdxMXpWRnptMU41L05U?=
 =?utf-8?B?NFNrQ2JPTkRBWTg4ZHlKVTJtVktYWURTcm5iK29zZk4yeWw3UjR6SzNiUkUx?=
 =?utf-8?B?ejhpODdaY2pKdzRlN2crOEdkbUx5QytVengwckFuNmRGVER4Sk1wTWhlRlBV?=
 =?utf-8?B?c29rZ2wxb3padzR3OE1zYTZZZDRnOWdRTzdIc0hpRGczRkZ4VnNEMkc0V3Ji?=
 =?utf-8?B?bEZhUGQwUmFkU1dnNDNYTG5mMUV1QVZpbEdDTkFOUXBsbk0vT2NtWnk2SHJu?=
 =?utf-8?Q?VpDOf3vFDw9IWe3QD2b+1K9Of?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC7046F66C2B584A80F843CE77E93CCA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fcf567-af3b-475b-9bb7-08da9674dbeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 17:16:27.5901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NySOkDQZHkV1J3ZfMW0NeDnMPVbh8zyvX8FW6QogRO8sTGQznsaNUG1BruMzGshvPq0MQbgZNj/CWYD6c9ESuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMi8yMDIyIDE6MjEgQU0sIFBhbmthaiBSYWdoYXYgd3JvdGU6DQo+IEEgZ2VuZXJpYyBi
ZGV2X3pvbmVfbm8oKSBoZWxwZXIgaXMgYWRkZWQgdG8gY2FsY3VsYXRlIHpvbmUgbnVtYmVyIGZv
ciBhDQo+IGdpdmVuIHNlY3RvciBpbiBhIGJsb2NrIGRldmljZS4gVGhpcyBoZWxwZXIgaW50ZXJu
YWxseSB1c2VzIGRpc2tfem9uZV9ubygpDQo+IHRvIGZpbmQgdGhlIHpvbmUgbnVtYmVyLg0KPiAN
Cj4gVXNlIHRoZSBoZWxwZXIgYmRldl96b25lX25vKCkgdG8gY2FsY3VsYXRlIG5yIG9mIHpvbmVz
LiBUaGlzIGxldCdzIHVzDQo+IG1ha2UgbW9kaWZpY2F0aW9ucyB0byB0aGUgbWF0aCBpZiBuZWVk
ZWQgaW4gb25lIHBsYWNlIGFuZCBhZGRzIG5vdw0KPiBzdXBwb3J0IGZvciB6b25lZCBkZXZpY2Vz
IHdpdGggbm9uIHBvMiB6b25lIHNpemUuDQo+IA0KPiBSZXZpZXdlZCBieTogQWRhbSBNYW56YW5h
cmVzIDxhLm1hbnphbmFyZXNAc2Ftc3VuZy5jb20+DQo+IFJldmlld2VkLWJ5OiBCYXJ0IFZhbiBB
c3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNr
ZSA8aGFyZUBzdXNlLmRlPg0KPiBSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hh
bm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTHVpcyBDaGFtYmVybGFp
biA8bWNncm9mQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFBhbmthaiBSYWdoYXYgPHAu
cmFnaGF2QHNhbXN1bmcuY29tPg0KDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
