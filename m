Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD9A661F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjAIHmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjAIHmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:42:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2186165;
        Sun,  8 Jan 2023 23:41:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKKokAS5OJkiFQ2/nvURq/2nTabb52psDlCxEQf6pMrNc4TzMo3WYu2eXkgEvJM/W75PpS0BWCkywD3CViW1XSdcw7UkFWpJqF5gcOngwrfn1Rtq5gsc73peZVx7X5AZXOS7y0bl04XQ3cJi/9UxACbGj3qgOC2NEjvQf8Ybw4SpXy1ojD3R5T79dPT6zUm+PVEgeKvl+IRYIVyQd1XY6Y+FPyVt+ZC8+u8OSf1p539gb5fGFwVTuOclxEyg7KJ3CLzet2xHWn7nL1aURnDGuIxDVGvZaWrDUZcDQzWhN3/MVoHVk41FF5dU+gSlRB7nl2J2xlfDDXYZPLgwa++LCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF1K3tigoAHYbLGRL2IiCtaxciCUoCTmq9oJvzTK0x4=;
 b=MJZphbImY2z8z0OSzNGY4MLcFSNHHVnGfk5hmNCn+WMvT1Zy1YzVEkVhfALp1YoPCz3R7pOCWHQgTMMvvlm7ydy3mQZSX3ks+tqz0GRLOuia3gAYMKdPRy1jumokhdEjhDhMa8A/AFFF2kLz9muayFFZMjIXb+4Cx9mnLPQKhH7BnUjpjzRfX+MBMKR5SsDa0KnI+RSItK/J3xp64yrxE0q+EkkWx4B2dc3Un75E6dlqSHFoanZjoSclYrDjW/o74nr/j7P/KGMpzgPCpcBCX6r4s5OWOsMko4BBqRxssFEnL4KjaESU8XwRR0hiaomCCD/70xwUW9w92k9AuOL0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF1K3tigoAHYbLGRL2IiCtaxciCUoCTmq9oJvzTK0x4=;
 b=EaI+5Bxzpuv5LxnY2pz83xqjeCuAqEz359iniRaa2sG6hPg+OQSzz9T7aesxPN/j12Cm7mMyLR7E4HqzZ12y+WEWCDE+cCyJgAF0Lk4k+ensCLERXKNJcygIdqtP3+Ud6P6uSBtFit5NTgbv+tbqwKS+hIjsG+/MGO1iogvGM6j/FL5FcsMtb1age2KnDGtc8woPovWBPmTqpo3s/68mneB8jrxi3tp+c5bGPAZAX36e9Cj4sp9nijUCLx1Auk5SQUK0WdUqedfnpgn3AJmSTcAGlnwadYa6kw9i18NT/VjgXJzBBteYFKMIpHtf6ovT5uUFReop1/KaBvUibUeShw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:41:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:41:56 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "kernel@pankajraghav.com" <kernel@pankajraghav.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH 1/7] block: remove superfluous check for request queue in
 bdev_is_zoned
Thread-Topic: [PATCH 1/7] block: remove superfluous check for request queue in
 bdev_is_zoned
Thread-Index: AQHZIammwKDv9lFNrUaYH7I9XXAa1q6VuF2A
Date:   Mon, 9 Jan 2023 07:41:56 +0000
Message-ID: <71b2163b-8d25-ad50-4852-3a0669df11bb@nvidia.com>
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038@eucas1p1.samsung.com>
 <20230106083317.93938-2-p.raghav@samsung.com>
In-Reply-To: <20230106083317.93938-2-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7250:EE_
x-ms-office365-filtering-correlation-id: aebb343f-28ee-4e5a-a253-08daf214fbc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOzwKS1g39qMxb+qVS9lNjwKwufRRZiSXZ4uw/0RzIbM9PFW+2uDLzoftDe5ns8rmr+flbZ5E+0P1lMBkr6d3FqGMUnozI0tPedbxVYL8tkZlaIaccAjLbVwE1Tndkqg7LKchYq0lNqtcULmlskh4loWBga58cfsXYR5rGWQYUTlxtFO5gBYOrk78vRKh3b0XKHys/02CnIHaT4TGU/0mp0H5AM0e1Ey3gW4GI20sFu8DTNPnL8PHUQrPIDjAGY/W53gf6iegLBCBLOiD5meyUDppQCvudrdDMhie0jNtS5EoRCJBQ5TikL2xAanR7xHc72g91WqRITq3N+DNRH23asy+udqNYwUTd6mX6Qwq9f8QM4JZOURnV5z3Jn1GdnTT18ytpobNZMQwrKAkZ0RDGz3eSAUiNaelI1b3DyGt9R6GpRsVhnuj2HD6/WjzUeT8Dum76Xk0juHR9rDn/sVWFzYOGOXCfXcP6yhdZOJnQyMa7R01VemhnMBM4UyDwm5f7sa10LZDyzYDkvKUp7t51uzbNZNiHDmR1pxUL1H1zWJyxxFK2/S9Ag1a1slYBkQwF8L4Pn5CxJjdX0HJFs789c37qp0YjRWsClBVR0S0khQN7hB1JznA/M1VHXvwR6gFHI3+IUnTsiX0la62rRnWtDOOQqOX8qJg5AUqZOb9o95teu9cK4mnXMNxe9lsWp81fJfDoT96sICOsH9Qco897bKfgtMlaJvkxJeU3nqlkF9cOykwnYmP+sT2J0e6GIk1hKYekCk4jTBR4CJyENCIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(6506007)(38100700002)(122000001)(53546011)(31686004)(2906002)(6486002)(478600001)(2616005)(558084003)(186003)(6512007)(5660300002)(316002)(71200400001)(7416002)(83380400001)(8936002)(36756003)(38070700005)(86362001)(31696002)(41300700001)(110136005)(76116006)(66476007)(8676002)(91956017)(66946007)(64756008)(4326008)(66556008)(54906003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTIxQURFd2hza2dyRzR0emwvYVVsK1FCckdXWjB6M2Zlb0t4ZlFHcmtibWxT?=
 =?utf-8?B?TlRNM3JnY2FDT1FuMkJ6WTVpOXdVQytnVFZQSXRQamM3d3FIdm00MklpbDZr?=
 =?utf-8?B?RVo5Q1ptM1pydFVsRXZac2RwelZoNEV5SUQrZzJhRHRzNExoU1hzSUs2RGY1?=
 =?utf-8?B?bXZvWW5EOUIrWFQrOXhaaXBPQTNsUG5mY3YzN2xSbE9rcm9ycEF6dWFISW1o?=
 =?utf-8?B?UHFtVE5xMEhHT3AwSnIvZFRHYTRRV283RUhuVDVqcmZyVWFJNUNOKzJvZUxr?=
 =?utf-8?B?S244a1RpUmhxemkwYjMvaGRWc1Q5RE1DNWxxellzb1VhcUp1UjcrSzAxNjda?=
 =?utf-8?B?cjY0WnFWc2svaDFqOFFCZk4vRFhDeWhIYzFjajFpYXkvc0FCWDJTcXFCaDVE?=
 =?utf-8?B?UVo2OUN3am5RUjlNOGUrNEhkQnZCQlBIWHF5OTNwR1BTUGpRV0pjZzc4R3lM?=
 =?utf-8?B?N2pybHNNdE51b1JhcTcrWjhHQ2ZpeWtleURwOVo0RExwY0N2ZjZCNkFpM3Iy?=
 =?utf-8?B?RXhEeGpJdWZ5ZHRZQ1VwSWlGdVdsQ3JxQms3KzMwWlkyQS8rZHAxT3orOUo5?=
 =?utf-8?B?WWZzd0tVTGdHQlpaSFV3N1VSTjJFTTQ5Y3BJNmVBSUtLT2xVSCtwRG5jMzE2?=
 =?utf-8?B?NVhyZVRwZC9ZM0I0VjNKNGxjUmsxOGhyWHdrRjhiWmdkcUVqRTFmZUVhVkF2?=
 =?utf-8?B?UlhnUzNleENIS3lFcVZFOTIzc0F5cXlhYkY4MTdxVFdwRHYyLzlDTXlZQXlU?=
 =?utf-8?B?NmU0Y3MwbFhRQVBXUzMySHlMTWFNVTFkUHRqeXJDT1dxNHMyVnJ0MTBQV1Yz?=
 =?utf-8?B?YXcwRjFNeW15WjhsSmZaajFacTNFd1NTS1E4SWJ6QWVac2pNa2FYR1JiSFhZ?=
 =?utf-8?B?TzZOUUxGVlcyWjRuWmZYbHdaUEJzVlJ0Q29MZEpTT3lyK2tFaVBKcjQ0dkxR?=
 =?utf-8?B?b3dnQThWSWdMaHVNQk9ZMkZhVTRNMzBONWM5S29rTG1MOWhQaGMzOHlIOU1s?=
 =?utf-8?B?ZS9qMHE4NEdvRzlCUDhKYWhReExzeEdYT1l3WnNFSEJLOEl6MUJZSlV3Tnp2?=
 =?utf-8?B?QUV3MFpjYmt5d3VMUElaWVJ2b256TTFRZEtDL1cydXlNcVlXWnhJc2VZRWlB?=
 =?utf-8?B?L2RWUVBsQ2hVYU9WMEl3RkZCeC84UlNaTXNkb0FpUkhMdVBJc0xpUDJBRkdq?=
 =?utf-8?B?N3ZUWWVpZ1ZXQWU5bDgxUHQrNkoyZmlRdkluQy9MbnlMQVUxN1BKTm5uelhk?=
 =?utf-8?B?K1V3blcxdldBOU5aRXErSVIrYnFlZ3RUUXpSWVVuNjZrZGFxLzdVM29zMzM1?=
 =?utf-8?B?Tmt0dmU4ZVE2MTdCMTRqQU92QlVBLzFHRy8zV2pUYVRzYVFBV20xS0pYZTNI?=
 =?utf-8?B?TC82L05BUHNSNUVCYzJiWHIyWE0xVi92SmZjTm0wcWl6bE5uUW01SVRtdkpz?=
 =?utf-8?B?RmdQUjdDZmFoVzJsakZUcFlhdnRiRUdVYTlxb0JXM3J4YU9PV1RaVER5OFJj?=
 =?utf-8?B?YlBydEdYdHh0MTZwVWQ3SkJvbWNsbldlZmJUbzZNWUx6WGZ4YmRPb0hsNWZk?=
 =?utf-8?B?WlVVSWdBNk5OZUZ6cjVQTXB2ZmZZSmQzYUJoZ3VDY3JWWVVJNDVPVi9pZDZu?=
 =?utf-8?B?NkpLSnVuN2RseEhhRlFINUxnTWFXaGVUUys5QWthRzBkbVY3TVJIUVZQK1NZ?=
 =?utf-8?B?VFo4YjZ6dnlOVDNHcjdLK3NmcGhxV1RMY3ZqQm5KelVtR2lUeHdrcmNVYTZD?=
 =?utf-8?B?STAzT1daeTMzZk1tbkcrYzluVEJFZDBMc3BkRk05OVhZTnRKdFR0ZnVjNXQ5?=
 =?utf-8?B?TVRaQzRJYmFXdktEWFcvYmJwWWR3NjNtU1RraFplUWRweE1PRHNSZEFkRzlY?=
 =?utf-8?B?NkRxcHV6dXNLM3ZuSUFKaFBYSnpPa1lNdzhUbmhtVW5ua3AyR0w4SjJZcVZM?=
 =?utf-8?B?ZVNBVmpUdGdmaXVyamZKRmVxOWNYOXI5UHRCQWxvQjFnZU1GS2F2UFpiUThx?=
 =?utf-8?B?Rm5rUzZvTklkYTFxcWgrVWZuSXFPUGIvRzQwODNsRy9lSllhYThqM09TM3BB?=
 =?utf-8?B?UG5FTXUzZi9oSThEeUxZVTZ3MlhIa2xlaXdHZE5mVVVkQ2kxRUE1KzhjazI0?=
 =?utf-8?B?OE5SS0JscEkxRFJWdWF6UGJ4TFNYSVpWWGlnSlZsa0hVNmFyUW9DVXZObXAr?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79B9F0E9CDA52C47903779A79E81EF3B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebb343f-28ee-4e5a-a253-08daf214fbc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:41:56.2851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68+b8vmEB/VEL22BZ+WXCC6hDJWcpk0fCpNbpkGjBiy+PcWF5jEw01JUTHlbfq3WRnz7Y2S6xD8ggh1zY7bd2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS82LzIzIDAwOjMzLCBQYW5rYWogUmFnaGF2IHdyb3RlOg0KPiBSZW1vdmUgdGhlIHN1cGVy
Zmx1b3VzIHJlcXVlc3QgcXVldWUgY2hlY2sgaW4gYmRldl9pc196b25lZCgpIGFzIHRoZQ0KPiBi
ZGV2X2dldF9xdWV1ZSBjYW4gbmV2ZXIgcmV0dXJuIE5VTEwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBQYW5rYWogUmFnaGF2IDxwLnJhZ2hhdkBzYW1zdW5nLmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
