Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA9E6E57F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDREGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDREGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:06:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E913C3B;
        Mon, 17 Apr 2023 21:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwNusfgjCBNsx7cpZHS8aKpdtC5nlwSYm5HC+AMNhDyTzfWaUDHFav0evheiqkEk9nDj66B+UkM367fjW1EbLEl2qWJgtPJscbwIyO2ERqDBE1h20d3wmG8xpNio7KSseawdBbQcCcfNt1GsoFcB8/jjMmindncjdT3Nk1+5pwc8PLzu7nlbY6IOHJhiIiLPKJnJwPPZXjL/bSqrV9a7WraHJ18PNfxW9Q8kMe667I+VLlwqiwf5/obh1f21CcgMi8Suyi6UmV0jlAACj9hnZpCQmUxjjS2hVjY0YPIMzadDbmFTgRYIXhwF/wwF575gmVCGISIzDZW2re2aEYWNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EewxroUGehlOKMKwUgSbdoNw/+gSGICrsarIlIRoUeY=;
 b=MmLna7T3GGg1ERWfc1arSD8caUwjHSGUif+4Y0CJWPWcFJzx7wHFU8yrJMTGNDdvvbbb4oKKJxA4MRopPGygr/HQoZVwVhEM9GFztVDDmGgdZ7tmzSrEWcwCYT7FfnQWt4+Iy+x5uWxb2frV+KJowxZPKsSX/UW8z9RLOhN3iLtMIWuM0aUNUa+pXoU0IHOVuB/EqZsIQWSj4O7VU5QaczdNXGA/vJgjZzyiGL//sN5ezoAt1kkJICA8KT5+wIlA4xDyKgtLdLgCClA3cn55Hq4DFPL66JRLbEX06mvwzlQnQeFWga1LPVnV6XuxJxlDxTiknnlF5+eWaVfgQkfQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EewxroUGehlOKMKwUgSbdoNw/+gSGICrsarIlIRoUeY=;
 b=IKeoeq+eAXh1HgdsORh5bHHHlxBUOmkOiCbfbERlrLUGz1G1hnFl9iQ4+xQi+URw3jaqgVkrQi3NqsuxvPeJLo/+BuQ+9DujWg7zRfdIYS5N7zoIJV3bWDd2t1ha+Fa0XR3PtlGW50eINyGMXyLvTfBqFHPsduHanXaXg2q1+h+IqIKtlaClhk6YtF8UgPowSTogai+szpPyvOtvEqZc/gFCAGrZow4c3iD9HgZjpQw0cv8FWNXv5q3jDwZjk/2/lxUjRzueS28sGBHE55X2EEd2FhffUmPdR/SdGfbnJ95GAI386Vhiu2y9RYnR5vifuJYcIqRjq39sYZGQlbnIrQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Tue, 18 Apr
 2023 04:06:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 04:06:30 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet-auth: remove some dead code
Thread-Topic: [PATCH] nvmet-auth: remove some dead code
Thread-Index: AQHZcWz2L/dwrwUv/ka0G5cN+hJlGq8wc3OA
Date:   Tue, 18 Apr 2023 04:06:30 +0000
Message-ID: <f1b9c50c-3d1e-6e83-d861-76b33b9ee095@nvidia.com>
References: <e6f0e506459eaec9dad74946c1e01aac74874054.1681764032.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e6f0e506459eaec9dad74946c1e01aac74874054.1681764032.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB6415:EE_
x-ms-office365-filtering-correlation-id: 566aafb7-2fc3-45ae-2fa8-08db3fc24a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2he72BZ6PW3LXwgY7yemh27f+lPkfBucI9hJ8IPrGB9/7Okldp0EPgQbz0bmf04DxXw/EujyEjom+l6rAPRC3nHrVLnUNlttPZmb0AmSPv6ILVULXW5yevn5wVR1Vpk4oGNg/j6AZD9WtLwq3WZuzVaeuw6KBrL0b/X/+PV+YpWv9yF9ijq0pfhXCinl8EzqmW23mAe4oRohpLeGsPcglL2oo5/f7nP/Ls2zb7Gmk5a0b9gooVyCBeqx5DLVxojEbhWMWZt75c8dSpWed1MAvke9kskm3b4u2bOh37RjQXK2iN+ydV5aC2TnBM4lHFAcSTwAamvcvuEQm2PUUCs5z5zQZCKGhz++N8WUuaOgmB7ApzMDbo/46diZMuRpNAxN9xY5k/VbSPMgGsELCjM33pNxWFtcOBV8ex22uPcjvwlaoSIdBh7WNRIWaUXC5A7y7bOcmoI0/mO3hBH4DMmYaJLmb6hfNJOYXf4JCz9v2J1P8wJcS8abvsL+CbJhX+hOA7PndVJhQ37G4dYKfqUXttVMk1BP9/Fbhp/tpiYW7fBTXFSlNOweq7xdaT9+7xMLcvC6qZGJ9w5X/XvFa0C58Bw/Lwm4j7jDxqhsU2+v7G+3gkMx1k8NBnF9sFEiOtX6h2aGni+PafKC1Jj27i0T8xECpFifZz72meh6XB0vcVJBYtgd2kIWnqNou9dQnxWL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(316002)(4326008)(38100700002)(64756008)(66446008)(66946007)(66556008)(76116006)(66476007)(91956017)(5660300002)(2616005)(86362001)(31686004)(71200400001)(36756003)(31696002)(6486002)(41300700001)(54906003)(53546011)(6506007)(6512007)(186003)(38070700005)(2906002)(8676002)(8936002)(4744005)(478600001)(110136005)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTRROUtRdTdSbVMvdmVwMlZMOGwxN3pSNGJHUDhaV3RVenZJK3ZZSG5GK2RQ?=
 =?utf-8?B?K0YydER5MjM1YTh5K1NVOExuajIxOFpDL1RzUnVJdGtGRmdXazhSUDA4RE5z?=
 =?utf-8?B?NjNUcjliUGVwL0kyejg1YnFEeGZYQjlRRjlHZXlQeVpTd0llZlRNY2x4bFZs?=
 =?utf-8?B?U0JQNW1TTnVldThVaG5zMDgzMUdCbUFvb3hYMm15Z2NGVlBmM2FJazZUNXBL?=
 =?utf-8?B?S1NNY3NualA1K2tBaSt1Y3JGYWozYWNPWnRQTVUvWmpqa2JockJtNDZkc2sx?=
 =?utf-8?B?WVVQVVo1RWg0YU1pMVV6RE5ZTEU4QWh5cFljUUZQRWlMcGhjc1VBcjY0dXlG?=
 =?utf-8?B?OUx3elVYeUVsOTlCTnUxRGViOUdnbGY0ZEM0N1V4OVI1SnZML3JScXRLK1E0?=
 =?utf-8?B?NFFmaVpodnRncVp5YzY5WGZLM3g5V2V6dU0yK3lROFg4NlRIdmg5N05HTnpP?=
 =?utf-8?B?Vkx3T3dxc3pJdXVSSnd3RGZGOHpybjRGNXhoZm5DWEVoeTFZRm55cGF2YVhT?=
 =?utf-8?B?VVNhbE9veXZWNi9MOGpkUVNqeEdxaW5uZTlKZUNWRnB1SzVEaUF6cUR5MzQy?=
 =?utf-8?B?MEs3QlVVbmNiUjZ5WFVRb1M2Z3psbVhKRFVNMExmanVZRUZrWEJOOTNFUXFZ?=
 =?utf-8?B?S3VEOXJVbHJXcU5NVm5hVkgwRVhPL1lyenM5WWc0QUhNLzk1WjZtUWpSb0R1?=
 =?utf-8?B?Y1ZKYlMwTUs5VllWamRuNXoyTXpFTTgzTURuVUVpWnVjQUt3QkRSeHVzVnNj?=
 =?utf-8?B?SS95NlFVLzhpTVVTR0xST2lGalhGQnZmM2F4SG4xQi8vYUR5SU9FMDRMQms3?=
 =?utf-8?B?SWZ6VjRvZVB6ME9xMmp5d1V2amlJNmg1N1FmcjhxRzdvTU1Kam9TUyszemhX?=
 =?utf-8?B?N21NZ3dwWjBIQk9Wa1NjL3hYelQvTlAwU25qLy9YN1BvRzRRbnoweEVuYmVQ?=
 =?utf-8?B?QVdXRUNpV3RGTVZicXFtYy9aa3c1b1kxck9oVTZXRFFlZDJ3SGlrTkQzMlFv?=
 =?utf-8?B?N1hzck1ONGsvUXh3ZEt3RUJueVVpOEZSdFBJeFE4a1RLdjZ1M3l2QWorUXlF?=
 =?utf-8?B?MGhuOGhybGdFWTd1N3pKZXdrZXZoRHdHeWdQbW9oV0JSM01CWk5UT2w4Nm8y?=
 =?utf-8?B?NVdXS251cEJtZTdTQUYvMU4yTkh2eExBU3AyeXk3aWRoVE9KdUtEVTZwT0xy?=
 =?utf-8?B?bXN3NXphaXowZGRnQXNMenFoTzdBN3VCNjMxNGN0eE00ZkNtYWdQTElhTkVF?=
 =?utf-8?B?bjN5WXgzMWJ2SmF2cFFqbS8vRGdIRm5CbVpzL0NxTzhyTDQ3dm1VSEgraHhs?=
 =?utf-8?B?M000TE9kQjVyaUduZ3RJT2tGZTA2MjFXSE8zS0hnaDNWMjdMUU9JNk40Sm9i?=
 =?utf-8?B?TEE1Skk1b3VzZGVDeFZBWW5iaDNTc1J4YjhLSU1lVU0wQ1hPYjNMaktnOVRq?=
 =?utf-8?B?Zm9ZOHdETXZPSGJZSGtTNlkyRmNCcWJ3UlNxaGJBTk5FRTA1dXk2aG80VUdo?=
 =?utf-8?B?VEpwL3JXcVllV0l5c1BBaFJGUTdDaFB1WTl4VHdqRE1wYTZxNUNPWDV5c1Jj?=
 =?utf-8?B?Wlk3NEM5c1NZZEZlekd4L2xyRWtHbXRDTWpIVUdUZXE4bUpNcExTVHRYQWZn?=
 =?utf-8?B?aUZOaXgvQk8vYnpRMDc0anVqb0Q1bUt3eVA5YlVMSVpPSUt0bm9ObytIR2xT?=
 =?utf-8?B?RkoxeFJwK0lMSVNtalRMOEpUQXlMWHJUSXN0eTZMczNURzdaM3RGTzdVTVV3?=
 =?utf-8?B?Rm1VR014V01wT20yMEVXaC9teFF1NW5EVVhiM0NINTRUNmNFL3JYTTFSdy95?=
 =?utf-8?B?TW5jZ0RFNUFHemRWL2V2NFlzSE1XU2ZhQUFMM2VKbVdjL0JaS2NSR3B0Wk50?=
 =?utf-8?B?aTZFYThVVGgycjM1cTJVQ1pFMnpGTWI3UDAzQml2SVl5VjRmeFp4MzFhdVRh?=
 =?utf-8?B?NC9JRk1KbDBzRTdSMENqTGRsMEdtaU14QlZibFlpeFl4akNTVVl0bXdJSWNu?=
 =?utf-8?B?RDRja1RyWXhhMDNQV0VINWFHK2NXb21wdUZzdGhNb0l6WHBidzNvR1pjY3E2?=
 =?utf-8?B?TDE5S2lrQm0vOGxCWk81aXp3ZGZEMml6OUU3c2hBc2c5eW9CSi9kQU52V1dD?=
 =?utf-8?B?TGgwL29PQlR1aVBNVTc1OUlyMlNGUWZkdG1hcFNkM2N0bjNyZUZPV1NzcG9S?=
 =?utf-8?Q?s7m31eRCLnV0ZvbkfjS+ayex9nG8FpAK/f9O3CaYRIB3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23B17CC3AFF9F041BA83CF4A26A77626@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566aafb7-2fc3-45ae-2fa8-08db3fc24a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 04:06:30.0543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQNvqgqGPf76q4+gwisy+t9XI8hyntaqJQVZ9zUQ7QNPO1wrVtbG4xVnZ4kd9USFVh4RMtbEBzyF56Tsgjj5FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNy8yMyAxMzo0MSwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiAnc3RhdHVzJyBp
cyBrbm93biB0byBiZSAwIGF0IHRoZSBwb2ludC4NCj4gQW5kIG52bWV0X2F1dGhfY2hhbGxlbmdl
KCkgcmV0dXJuIGEgLUU8RVJST1JfQ09ERT4gb3IgMC4NCj4gU28gdGhlc2UgbGluZXMgb2YgY29k
ZSBzaG91bGQganVzdCBiZSByZW1vdmVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhl
IEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPiAtLS0NCj4gVGhlIGRl
YWQgY29kZSBiZWNhbWUgb2J2aW91cyBhZnRlciBjb21taXQgYmUyYWRhNmQwZWQwICgibnZtZXQt
YXV0aDogZml4DQo+IHJldHVybiB2YWx1ZSBjaGVjayBpbiBhdXRoIHJlY2VpdmUiKQ0KPiAtLS0N
Cj4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
