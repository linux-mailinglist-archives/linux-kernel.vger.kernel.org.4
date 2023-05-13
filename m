Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EFE701393
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 03:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbjEMBBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 21:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjEMBBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 21:01:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16E459F3;
        Fri, 12 May 2023 18:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXT8Wdc5tHRp28bHLN22Rf5h5L3j5yqsZzVaH/KODzT8PjMUPTQo2EYKmq+8/Kprs12L9bG/mBCWybGkdk4xvA/e++NR2/mCL5ZCqi7PJJH1ZpBuceb6BYYlo7ED80yrF6JoBH3HncAy29R+KdY9crRoz17wduNoRvDrzjDrU+HjRt5XHiUpSmmdeYdnF3HsIOze11CD+VU8RL9maHhlm7cXyfXOJgO7YK8kQqQY0ZogTkm5v6sorvNa/NC6k9z35DRhkD3SNXODeJr5RLPH1J2BZtO8bcRgclFWBXf9hMf/RvvRM675k5TMC0Ro2uTjoXCKafWptPVmGRczrkc7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E3oJfzMccuoq8H8I4gyosPBY4A9XD3xBfRI4W+F26A=;
 b=P8ca0FcnUSFbzbnPm+itVHXTABoG0TBVjKq2pDsk820p5+SfblxscxU+WzN4v7W0q4wEBrRbV05DRULP/Ek00I5YUU7JWiluzS9qVn3u+D4EXrDP18EEF7bTMVrkRGFdwhDgzM3VsTXLO0QDFibZPm7dYnCYo77T+dHOtiFFZl1iurV7hCUmQ1ijVyAhHGbF2Cywm4Zm1JZeE1fBrdztmTFGOAMWE40gCeZ966BJYgDq+dxTUZPj9jlIRObFl3TFTn3151K94BqPTe7wQ9znlQjXB1xgv7Mph8TrKdhFM4Ow8re+ZMml6XUXurJM9XWt1qW7gZzgzCTjSh1pTx/Jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E3oJfzMccuoq8H8I4gyosPBY4A9XD3xBfRI4W+F26A=;
 b=tIjoiIwIU3dKWQljZjuZShbXh4H6jndPGMPCygtgwk2dWat/YisIQbijAgFabxyktyEVc4cGr2cCnS0QxOMOkYgZs480uDCyvcXMxwwztoYJhCBqp9+I1z5vqqnUaB2gUsiwiiupGbm1OnG9dwaPXNYW9/oH4QMlrW2BdVfd4oFD3V8mKEM4RpNV0q2I4heMFjFVf4qXTpwgHHWxKgzwTxwa0gFROORW4PDdEyK5zB6z+dC5riX597WvBjBobocdRmB36j0Qg85KFrR4eDeKmKPpqZliUABWQCQqf1a1W2z3E6FQl+qq5q5lP50jrkIyFC7BQppdyLjkulC19FJF3w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Sat, 13 May
 2023 01:01:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.021; Sat, 13 May 2023
 01:01:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 0/5] optimize some data structure in nvme
Thread-Topic: [PATCH 0/5] optimize some data structure in nvme
Thread-Index: AQHZfComg/k4+KqgukqPil3tfT4uRK9XdKmA
Date:   Sat, 13 May 2023 01:01:49 +0000
Message-ID: <3ed34562-f366-2bb7-1a8a-e7cc9cc1c7e4@nvidia.com>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7433:EE_
x-ms-office365-filtering-correlation-id: 067f7447-c2a4-4ae6-b00d-08db534da207
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wMHNHq//ldiV1UnG/6JRts+9WXMkOmEe7tSTlBAypwckX5m4quK6mq1cP1h7DoA95uCIFrc0OVcmJNsYuqu8OsGwrod/URlgrjAtoxc3HPf7ovi9ibbHhDEHXcjKAdRG6BSlY0eS0T7He3mdniV2YSER6wa+KvKIhaOVx+YS/GJTEjo2fzTNdEUp9BSyRbPumZhs047lzfuw0pJwdZaFzrh+EUrTCVLE+qzkJ4u3OXsKqGjCPWYE5jABJaMzw7Rk12mO1JZSc5htezBNCb+xDhuXBtxWTIhtPleOxykxd6IPvrZYSfokQ4MEHMfoqzjO98Dm4TXZvk7/MXIRcf9vKRe1qFbyMtHwDGZrQHPKtHLhETRfa0YjSbm3DqzYt6nce3UAOy72fQn3Tjiw3nw2Wcge0hBhsQLcqFgisxSzh87eobaVZztJjmkNP+jiIxV/+fF1o8Xy6bis1l4Gi1LYlzxnqRxVjwpAIIN5td0alNToe7GuJ1n5zo2ODM8aZIkJnkXGNxYjk/hy+O16vyjASM22f/ayZh9zFMwP5qGc4imnUuslIjFg0utuUseCH6gnxXU4CxHqcY+kcXXqL2/il2XqAEJBaQK0MjTFS1cuYsh2qokdUpCwK/66zg+RWTdC6E4gnO8xZHl4tHB5C8bwSkGgNaU+gqvoTjwewMncv64l9J+ST6Le/kSIcoBVP/LycFnMMlXo6kMtcd00NdzSI1iexphinPM3B6Nv9SvPOFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(122000001)(38100700002)(36756003)(38070700005)(31696002)(86362001)(5660300002)(6486002)(316002)(8936002)(8676002)(966005)(2616005)(6506007)(6512007)(53546011)(2906002)(66476007)(91956017)(66946007)(66556008)(66446008)(64756008)(76116006)(478600001)(54906003)(6916009)(41300700001)(31686004)(4326008)(71200400001)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejRadDVtN2tibDZQazVLWW9YczNTdlloTWtzcElDSCtVTDdJSzA2S1dZWWtR?=
 =?utf-8?B?RFpPb2VJQ0xrSnExWjBXUXo2cGVrVXJqYkZXNTRTNlJrQVo5b3Z1L2hzRmdT?=
 =?utf-8?B?cmlrcGhFT0FZcFVCQmZ1SDRhcVBUV0NJZmNLcjVnV3VBQmVhMVFpeEF5dFB1?=
 =?utf-8?B?bDhnY1ZUUmlGZklSY0NkYk90K1BFdFR3c0U2K3Z4YzhGMWxZc1JWNWN1LzJE?=
 =?utf-8?B?K3dMR0RKL0VzMlAzbW14aE1scVhPNGNlUWJscUcxZlExN0FsOW1BSzVoanJE?=
 =?utf-8?B?U2Nvam40RG1vb3RuZTc3SGV3WnJLSVRCUS9OODkrQjZSb2FkeDJhL2hMWURm?=
 =?utf-8?B?Mk9GbDRQSnhobnFTdXl1eHpFdi84VGN1RlJxdkh5SFZWblNDZ1ZRUlNwMnZr?=
 =?utf-8?B?aDV1WE16MmdTODJQL3pFU2NneHNvV3dxSDJob1RzM1AxT1JFRzhOaTZXWlhw?=
 =?utf-8?B?WTR2MVhGdWI2SlJOWXRmekFDTEFnYXprTlBEOTUzZ1R3UFdQYlhLZmdjWmNF?=
 =?utf-8?B?Zy91TTNiNklJbjUyeFdKRGF2UlpvUlUvUjkzQlRCMDFpWFU2YStQamlydVJN?=
 =?utf-8?B?Y0w1QXVYVC9relRYRG8zUXdjblVsZjlNSXYxbWMwY2NBL2hqQ2wvZWluYW5m?=
 =?utf-8?B?MmlVYy9udkJmcUJFOHhBSThSbHBSUWtvQnNsWTdyR3RMNG4ycHl0N1p5R1R2?=
 =?utf-8?B?aENnNHdkOTNQNStFS3BTWnNCMnVRL0JJM014S3ZrNmFJZ0xuV0ZsNGRGRDFE?=
 =?utf-8?B?NTgvRDBUdUYzTjdCNmMrSjQrdmJPN3B2L0Y2aWZuNS9aUDVmaEx1dVFVODlY?=
 =?utf-8?B?OER3YmlSeDRMa0EyU1JnRXQrVC9UbmFDK09FakkzVDFoeFR2OXdhWUh1TEEx?=
 =?utf-8?B?UUlkRzdZZm9QWmhORXRVRDAzWTh0Wlp1VGVHNGtsZVR1TnNUcmowUWdmbHNa?=
 =?utf-8?B?dUVpTzIxUHdVMzhQVEE0d25BOTBQMzkxUUF4U09oWk1TTHhZcG5zcHBrb3Vj?=
 =?utf-8?B?OUFuOUl2THBKbk9wR3FnRE1hSEFqa3hER2dKSGpEV1JFK2JrWGZjVkFsK1Q1?=
 =?utf-8?B?TGNsVHFzeGxpVW04MGt5aXpnNmhRN0NHY3ZvMWVWcXk4K2RJL2NuSXpHVU9r?=
 =?utf-8?B?Yjd0ZmFScklvdkFGN1ppVWRRS01Eb1Y0Skl3bmduWW90SmZVdWk0emdUUmF5?=
 =?utf-8?B?SGhSczhXcmgweVdjbHA5QUFXUVVSZ3M1MVMxS3ZvSWxDNmFhQy9KWXlBbnYz?=
 =?utf-8?B?bDZGRFF6SERLOHc1UlplR2djdW92OUNjYlhtVTdESEg1VHlWN2k3VXBCdXN6?=
 =?utf-8?B?S3QydDVoNUJuejNmS3l1YUdpYTFGRFFheUlnbWdPTTgwWnlRUGZoTDFUejhq?=
 =?utf-8?B?Y3hHL2Z6WHM2ZUhsVzlrMHR1VnhHVEo0dzljZlRLbThCR2dlMzdaN1NFYU1Q?=
 =?utf-8?B?UnoxbVQyNEcwc28zMnFvYW5zK3FoNlJ1djNYazVoZ0lBZ0ZMd0RwTEZZdUpK?=
 =?utf-8?B?elVwaUlWREdSY1llVVJiQXJTMU4vTTRiUDFQSTRCc3NubHZsVS9NK2c5ZHh2?=
 =?utf-8?B?ZThyTlZNR3had2h4UnM4bFBCWjBhQzlVaHR4c3E4aHBlRlJsUnNhUzRKc25C?=
 =?utf-8?B?OTNENGMvZ1VSUjh5WjdKTDZJWHNSa1dlbVRjOXFPVVpuN21udkN2aXV3VThX?=
 =?utf-8?B?ZjY1OGxhN3Z3ekhVTzU5OXJ4T3NwMThEWDNBSEE3eUMxTXdweVBuaVIxR2xL?=
 =?utf-8?B?aEpRRmNpcnc0d1FRVGVvL2k2RDZiL045dEpWT1BMSTkwTVJMWTFMSjdQOXNp?=
 =?utf-8?B?ZFlveDFIUHlhcE1ONUIvRzNQajRjZUNDNktNbEEydmxUYXBzcDl1L09uS2d6?=
 =?utf-8?B?ZHBHeURlQVpHYWFmbm53M1YzUk1VMXNQRVF5d0szc1RoYTRKUFVLK1c1QVZi?=
 =?utf-8?B?cGdBd1VJalBjTlpWWXh2KzIrZjBaSW5nZUlBRGFkMnpyRTBzOWNycTQwTnph?=
 =?utf-8?B?UC9nS2drbC9mcXUyRG50clBZeUhyS1o3NlgvcmJ2aE50dlBJeC9MZURGdUhu?=
 =?utf-8?B?MytYeU9vajB0NlpmdVlMYXFkeVZxYTlmUTYwM3NsMG1YZnRSZ0xOV25qWkFi?=
 =?utf-8?B?Njd2NlZGL2t0UDZ2U3Y2Nms2MlU1UXhDc0RQYzIzaWlqVjhyQmt3WGZKSGxM?=
 =?utf-8?Q?gP2swZO3oeZcVU1zLZKs5xEmcvP7Nxo0k79lgmpPk79p?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63B22A20FB911449A20AEFC4802B0DFD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067f7447-c2a4-4ae6-b00d-08db534da207
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2023 01:01:49.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6KG+CGC4P9iKIVmXpEOTsT+9BNN/Mx10H6KugWZ0wtQ0pnenbSto9vN8BjxxWrF6gQrs6G49B6xnw6dXvhSsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xLzIzIDA1OjQwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3JvdGU6DQo+IFRoaXMgc2VyaWUg
aXMgYSBwcm9wb3NhbCB0byBzbGlnaGx5IG9wdGltaXplIHRoZSBtZW1vcnkgbmVlZGVkIGZvciBz
b21lDQo+IHN0cnVjdHVyZXMgdXNlZCBpbiBudm1lLg0KPg0KPiBUaGlzIGZvbGxvd3MgdGhlIGRp
c2N1c3Npb24gaW4gWzFdLg0KPg0KPiBIb25uZXN0bHksIEknbSBub3QgY29udmluY2VkIHRoYXQg
dGhpcyBzZXJpZSByZWFsbHkgYnJpbmdzIHNlbWV0aGluZy4NCj4gQmVjYXVzZSBvZiB0aGUgd2F5
IG1lbW9yeSBhbG9jYXRpb24gd29ya3MsIGFuZCBpdHMgb3Zlci1hbGxvY2F0aW9uIHRvIHRyeSB0
bw0KPiBhdm9pZCBtZW1vcnkgZnJhZ21lbnRhdGlvbiwgc29tZSBsaW1pdGVkIGdhaW5zIGFyZSBt
b3N0IG9mIHRoZSB0aW1lIHVzZWxlc3MuDQo+DQo+IEl0IGNvdWxkIHN0aWxsIGhlbHA6DQo+ICAg
ICAtIG1hbnkgaG9sZXMgaW4gc3RydWN0dXJlIGNhbiwgYXQgc29tZSBwb2ludCwgaGF2ZSBpdHMg
c2l6ZSByZWFjaCBhIHRocmVzaG9sZA0KPiAgICAgICAodGhpcyBpcyBzcGVjaWFsbHkgdHJ1ZSBp
ZiBzdWNoIHN0cnVjdHVyZXMgYXJlIGFsbG9jYXRlZCB3aXRoIGtjYWxsb2MoKSBvcg0KPiAgICAg
ICBrbWFsbG9jX2FycmF5KCkpDQo+ICAgICAtIGl0IGNhbiBzYXZlIHNvbWUgc3BhY2UgaW4gc29t
ZSBvdGhlciBzdHJ1Y3R1cmVzIGlmIGVtYmVkZGVkIGluIHRoZW0NCj4gICAgIC0gaXQgY2FuIHNh
dmUgYSBmZXcgY3ljbGVzIGlmIHRoZSBzdHJ1Y3R1cmUgaXMgbWVtY3B5KCknZWQgb3IgemVyb2Vk
LCBmb3INCj4gICAgICAgZXhhbXBsZQ0KPiAgICAgLSBjYW4gcmVkdWNlIGNhY2hlIHVzYWdlDQo+
DQo+IFdpdGggdGhhdCBpbiBtaW5kLCBwYXRjaCAzIGlzIGEgd2luLCBwYXRjaCA0IGlzIGxpa2Vs
eSBhIHdpbiwgdGhlIG90aGVyIG9uZXMgYXJlDQo+IG11Y2ggbW9yZSB0aGVvcmljYWwuDQo+DQo+
IFRoZSBjaGFuZ2VzIGFyZSByZWFsbHkgbGltaXRlZCwgc28gZXZlbiBpZiB0aGUgZ2FpbiBpcyBt
YXJnaW5hbCwgbWF5YmUgaXQgc3RpbGwNCj4gbWFrZXMgc2Vuc2UgdG8gbWVyZ2UgdGhlbS4NCj4N
Cj4gRWFjaCBwYXRjaCBnaXZlcyB0aGUgbGF5b3V0IGdlbmVyYXRlZCBieSBwYWhvbGUgYmVmb3Jl
IGFuZCBhZnRlciB0aGUgcGF0Y2guDQo+DQo+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzY3YTllNTNlLTRhYzktN2JhOC05NzEzLTk2YzFkZmUxZTM0MUBudmlkaWEuY29tLw0KPg0K
PiBDaHJpc3RvcGhlIEpBSUxMRVQgKDUpOg0KPiAgICBudm1ldDogUmVvcmRlciBmaWVsZHMgaW4g
J3N0cnVjdCBudm1ldF9zcScNCj4gICAgbnZtZXQ6IFJlb3JkZXIgZmllbGRzIGluICdzdHJ1Y3Qg
bnZtZV9jdHJsJw0KPiAgICBudm1ldDogUmVvcmRlciBmaWVsZHMgaW4gJ3N0cnVjdCBudm1mX2N0
cmxfb3B0aW9ucycNCj4gICAgbnZtZXQ6IFJlb3JkZXIgZmllbGRzIGluICdzdHJ1Y3QgbnZtZV9k
aGNoYXBfcXVldWVfY29udGV4dCcNCj4gICAgbnZtZXQ6IFJlb3JkZXIgZmllbGRzIGluICdzdHJ1
Y3QgbnZtZWZjX2ZjcF9yZXEnDQo+DQo+ICAgZHJpdmVycy9udm1lL2hvc3QvYXV0aC5jICAgICAg
IHwgIDYgKysrLS0tDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5oICAgIHwgIDggKysr
Ky0tLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggICAgICAgfCAgNiArKystLS0NCj4g
ICBkcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmggICAgfCAgNCArKy0tDQo+ICAgaW5jbHVkZS9s
aW51eC9udm1lLWZjLWRyaXZlci5oIHwgMTAgKysrKystLS0tLQ0KPiAgIDUgZmlsZXMgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+DQoNCnRoYW5rcyBhIGxvdCBm
b3IgZG9pbmcgdGhpcyBhbmQgZm9sbG93aW5nIHRoZSBjb21tZW50IG9uIHRoZSBvdGhlciBwYXRj
aC4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
