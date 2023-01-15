Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05D166B083
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjAOLHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjAOLHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:07:21 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB16CF757
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 03:07:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNURuzf51iM4siFc/YmHAYRZ/yWfn5yd0SE2XTi2eHJOd2fqv0vclnOyPAJzaJ5YpB3T1A0rvP/dQsOR1D1IPzHipcz6zLIUT6qoxSYDhhFSeoG3U66FEVBAc1XwLSAnUoXPRzDHwwBKHZdprveVgbfTRZexjoH5r101ojUQTBc8Vk4lSQ9C9yWwCVo9WA52aVLwcyPsDAPAyQO8mP1uEk/rUVffmvqySkxwHN7UqzkvYG5RQHGfDfKZz6XHHEhUfbOeQw7ud49hgB7RG1PGgrNYWyMhLwBONTEqZjMAJiQtlCz93VT71pHy630Km4RKog+yhCc75vxosPOvXP1JqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raI9y7k3F7L1LcJtVJ6P+cWrF/zreEyBlbzNwk1djow=;
 b=As7ZuTcRShSkg6O3I4C8wjpC/AzytfwNGlnFtHoyrtheRFcxK6cB022udnv9jvTgleO4RShb3s0jUEHTniocjLCXIc+LNzK7fPS48zWTVezCkOeqTKLcgDdRmXvuuxE+V7xA4YObpcK7EWZ9ikuZQBfAuaaSZCtrlqaxAKWxf00wTaBGNXdlIpctrq9fOsc0Riie4vL1sLJOnkZGVxpnFtptYXIUvMpn5hLkdR9Bqb/BLNjgs3ifm6c0usbL/bNdkrBNsFWXLHfGsIO4ka07IiSKbZbRXA4Lf4fA7Lm87bNxg+FMbA8D1HbsNwFyFI7krJ856qo8uVobYFdOiHhZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raI9y7k3F7L1LcJtVJ6P+cWrF/zreEyBlbzNwk1djow=;
 b=l7d7fU+34LSn4EyYJ2i2L8Yw8l2JjAvBtrpuWUB/drcmsVxKAU4ifGV5BjcA1ImZRXwmleeovhxydvTc5AQ3OoltkExTt0yKYOz4oeM6TK+djmHfLt+P+loRRR0Er3yt8WidLVkygRglBG62ljN002pj4Sd9o37MreciyUFdmAY/ZSJ/QlQ6QbPXUYdPiTBI/fAqH9vOg0VubpDrdJr16T2PK3R1r661KCq37UACIMLKDIgp9JYuBcKZAOV3dR8bdJTXNrrRujJIdgMzTZ2ffrciI1DEIV9y1cFYvfRre7IyGfyVj0Y1Uq3FJ3r8kfJJX+ntHhgmTI9jYzxiMpG2dg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Sun, 15 Jan 2023 11:07:18 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.023; Sun, 15 Jan 2023
 11:07:18 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Subject: RE: [PATCH 4/5] vdpa: set dma mask for vDPA device
Thread-Topic: [PATCH 4/5] vdpa: set dma mask for vDPA device
Thread-Index: AQHZJYXwjJHDehOfMkOQgM8HlngwGK6fV/iA
Date:   Sun, 15 Jan 2023 11:07:18 +0000
Message-ID: <DM8PR12MB540077DC5AC4D33D087734E2ABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-5-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-5-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|CH0PR12MB5219:EE_
x-ms-office365-filtering-correlation-id: 6265b22d-0c36-421b-fd27-08daf6e8aaca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +d7lysXHIpJ0XPksiq7Jw3DHhRnpUd12V9unRm8wzGHvxIc/zJmdxS3aoKGqaKVe0ZuKwWq7oPvSYqAcmmzEo0vKp1gr14KQFQGMnPVdLVbxJM9x1/ulLmD5VQPhyYrxxdBM4fBcuf0bMbrP1Z3dB1SdLN47o2vL8Va+t2JGPT4pgSYv/gBc9a6ZfFlTAUYOTsmf8qeUsqMFBkkYsnH4pwDfLui6TjTod0EOSxAhyZXYd5huOfTVkVrMxQ7LqpFz2cUYWbgitBnfZ/9OrBdy4KgMvPBIfGaokiqrqemygiymGiTOLxE7YIzQ+OiyCJ+16uNNzS6EOLN4ACzjFMlcXKO1kJwvpH+vbjDL7TW66boHyepCxoa84vtXG/NAxOSJwyNFSXrzd3+XovfipU7R1Yx2w0+OPXlhxddEn6PQ1pct6qCm4x658Brf3SFvz6U1Z7ZDNPsF1bD7yaQTCgXz9/+SYQ3QNt3hLRaqxzVzM67WaA9FRv1qhq+umk85fV5+FDn9T7blCj1k83LgqsX0qKcsSC/UMG0v9S4bzPiCRv+xAAAagl0iZNstWusNbUWhSRBU3Rc+MZEelezMOd7z5b03A08VKzZTC5+m34xL8Qmn9h1EWXiyMkowZpD5E5zsW1BFp17nIIx51bwmovHrjVsDVHQHBlYFn0vYv6h1g7KX99NaQ2jvBPD8mVIUjJOVhRCIFf3Hzi6cF/OlZGL/+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(7696005)(71200400001)(33656002)(478600001)(4326008)(8676002)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(41300700001)(110136005)(54906003)(316002)(55016003)(38070700005)(38100700002)(122000001)(6506007)(53546011)(26005)(9686003)(186003)(83380400001)(86362001)(5660300002)(2906002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0dtQXN3RWhjK1BKZnpWRERzZnNYdkhOdHc0T2Zhci80QXdjVGtRZkl0TTVS?=
 =?utf-8?B?VWRHcmF3U0s2MHZMQzRFdWZ2RHltQ21rQ2N5eGZBcmMxb29RSHlOYzBqS1hW?=
 =?utf-8?B?MG5ZUGtZQ2hxZnZYNGIwSHRmU3NLNFE2OS81cGtieGFibFVPdzZGMXJlOUVt?=
 =?utf-8?B?Rno0VG5wUng2bWk2emdZU3ZxVWpJTkxmSzJaaEJJcnEzZjZFOU01SldjOU9w?=
 =?utf-8?B?WUZLbWk5UWtReS9zRW9Yc3hhZUFNS2Yrd1I0QjlFbUtFcWU5NEhSc3ppYmZ3?=
 =?utf-8?B?VG9ZWWNkaFRyTFJIMEJKNGhsSEhpdzk1RHdDaVZtRDJBWmFUQTZNLys5RlJS?=
 =?utf-8?B?bU91MDFBb20zY3VOd2FOZElGS2EyNkhhZU92REE4YXZHbU5ZTGtkci9ZSHdx?=
 =?utf-8?B?TFdnR3luNHZJM3FBOXhEQmVuWGVFUUFUUUh2cStacHZhVGlENjVrV2t1SXhV?=
 =?utf-8?B?MWJ3UFFtQndCL3psR2I3NzJ4NXNqeXdqalY3RXdtT1FndlJLZGowbmhzMEts?=
 =?utf-8?B?Sm1rbnB5UnRsbW16K3BNOTNmczVRd3NMME41OE9Kc0duWHRxcC9Kbm8vczM3?=
 =?utf-8?B?eUg2eWt2WnpsL2dhYVVuZE1BQ04wTlNHR214WGtYbGdld01QZjdDVzFJK014?=
 =?utf-8?B?RDVqT2RtL1dMTWp3MHQzVzZKNnd2cU5TNlJHcVF2RXZsRFIwT1VEM2QyOEty?=
 =?utf-8?B?NlhvQ0d0M3BOZUhzRGh5NU52c0FiQWVNUXd6UStXdmhRTXhMTUMxTTFhT0Fm?=
 =?utf-8?B?WUpSRktsV1pIajd1V3FCYmJna0tPQ3B4VUlzT2wrZHZabm9zNjVHMzVOenRT?=
 =?utf-8?B?RzkyS1h0VUI2bkVwdzhlcmY0Zm0yVjRZNGJwUEgycjFRWW9jS3pxZDJjMHM0?=
 =?utf-8?B?VVVKaUNNT0YrQyswL2dVTTRwd012Tkt1M2ltK1YzT1FkekNONHBaaWhpb2pQ?=
 =?utf-8?B?MXlmNjROV0MraFJyZ2dIcTB4MFo4KzBlSTJnWW9qZjZzd2xRazhnMDVHcmNU?=
 =?utf-8?B?OFVua1lLT2s3RW9xeGppZEdxallycGVqQTRyblp3aXpjNC9yWnFmd05zMnJG?=
 =?utf-8?B?ZGZzSE9XYTFlSkN0cjZkaXVMVHgxbDhOZFhqbGloeDkvcnFpcmVjdk45OTdh?=
 =?utf-8?B?ekZuMVl0bUZrd3FsbyszZW0vQzFYRGlBVHJjUjNWako2ZUlkYWlMbC9pd3dt?=
 =?utf-8?B?Ni9oM1NNT0N4eXoyeTByYU94dVNtQzdkRlpIMlhoK204SHBlSUovY1k2WGZV?=
 =?utf-8?B?bFFUd0IvcEtSN0Npdm1nNEdYOUR1dUEvOEpOK2JjakpXMk5sbUpPR1B4UEE3?=
 =?utf-8?B?cjcxbFA4SUxxUUc5T0k1STJrWkwzbjdGN1J5Z29aZERBZHVscERydjYrRWFN?=
 =?utf-8?B?WTRWeE96QnQ3OE1Ham9hMUJ1SzVHQUVsSTBVMjJYVm1UREZQUytLVUFpdHFl?=
 =?utf-8?B?KzMyMzF4YysrUUpJMFEvcFMwaUlpeVJLNHhVNmY1Vm9QQXhMQVZkUm1wNnl2?=
 =?utf-8?B?SlkwY1FwQWVEbHFyd3dFQmZVR1pVRUU3c3UyQWpEMmZWMTZPSHYxVFpiVnZZ?=
 =?utf-8?B?NmJHV2xnajJEMU1pQnVITTJ0SFRsVkxRYy8vTjE1djZHRTdJVjRwMmtpeWpM?=
 =?utf-8?B?czV6em45UE9XZGpOK29nMExpTlB3SGxuZFRKUHhXVGpubFo1eGJOZnl5VU9o?=
 =?utf-8?B?VHFIM3h1b3ZKZ2o1enpteDE4cnMyQUR3bmVCaVljajNCOVc3ZHRNRmRTUXFp?=
 =?utf-8?B?ZEV2KzF6bDl4VExHM2hFUWRMR2hSajdYdXVMTVpTUEF4QTFuV2xJT0pMUTB3?=
 =?utf-8?B?RjZqUGhzRENjRFRteVVwZ2FiME1JK0xaWG9HelgwMDVYVWVIcXpkaGp4QnNC?=
 =?utf-8?B?REx0eUJjUTdMRzRKR0t3dWxqYTJLQ3NFdVVtVW41SnVML1VudjY0alBPWFlI?=
 =?utf-8?B?QjdlVzk4Z2ttakNaNVc4SmxNWi9ySFhYcUZIUU54N2tBS3h1enRqT3VtKzZJ?=
 =?utf-8?B?OU54UVV2Nk9POExENVFhVDVmTHc5cnR0ZlpnTE5yRVhFeDdmTnU3WnJzL3Rl?=
 =?utf-8?B?ajB5WGxoWXJPcmQrVUpxeU8veEo2emVUWFhNdTA1Ym9mNEphdng5blB4aFEw?=
 =?utf-8?Q?6UCs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6265b22d-0c36-421b-fd27-08daf6e8aaca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2023 11:07:18.4465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72soYuWvCCXMRqFu8YjpThlFFzd0ER2HUCzG7oQXI4nfOLF49jOqVsCxjqjj4nhR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIDExIEphbnVhcnkgMjAyMyA4OjI4DQo+IFRvOiBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdA
cmVkaGF0LmNvbQ0KPiBDYzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+OyBnZGF3YXJAYW1k
LmNvbTsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHRhbnVqLmthbWRlQGFtZC5jb20NCj4gU3ViamVj
dDogW1BBVENIIDQvNV0gdmRwYTogc2V0IGRtYSBtYXNrIGZvciB2RFBBIGRldmljZQ0KPiANCj4g
U2V0dGluZyBETUEgbWFzayBmb3IgdkRQQSBkZXZpY2UgaW4gY2FzZSB0aGF0IHRoZXJlIGFyZSB2
aXJ0cXVldWUgdGhhdA0KPiBpcyBub3QgYmFja2VkIGJ5IERNQSBzbyB0aGUgdkRQQSBkZXZpY2Ug
Y291bGQgYmUgYWR2ZXJ0aXNlZCBhcyB0aGUgRE1BDQo+IGRldmljZSB0aGF0IGlzIHVzZWQgYnkg
RE1BIEFQSSBmb3Igc29mdHdhcmUgZW11bGF0ZWQgdmlydHF1ZXVlcy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQpSZXZpZXdlZC1ieTogRWxp
IENvaGVuIDxlbGljQG52aWRpYS5jb20+DQpUZXN0ZWQtYnk6IDxlbGljQG52aWRpYS5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy92ZHBhL3ZkcGEuYyB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5j
IGIvZHJpdmVycy92ZHBhL3ZkcGEuYw0KPiBpbmRleCA4ZWY3YWExMzY1Y2MuLjY4MjFiMjg1MGJi
YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYw0KPiArKysgYi9kcml2ZXJzL3Zk
cGEvdmRwYS5jDQo+IEBAIC0zOSw2ICszOSwxMSBAQCBzdGF0aWMgaW50IHZkcGFfZGV2X3Byb2Jl
KHN0cnVjdCBkZXZpY2UgKmQpDQo+ICAJdTMyIG1heF9udW0sIG1pbl9udW0gPSAxOw0KPiAgCWlu
dCByZXQgPSAwOw0KPiANCj4gKwlkLT5kbWFfbWFzayA9ICZkLT5jb2hlcmVudF9kbWFfbWFzazsN
Cj4gKwlyZXQgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGQsIERNQV9CSVRfTUFTSyg2NCkp
Ow0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gIAltYXhfbnVtID0gb3Bz
LT5nZXRfdnFfbnVtX21heCh2ZGV2KTsNCj4gIAlpZiAob3BzLT5nZXRfdnFfbnVtX21pbikNCj4g
IAkJbWluX251bSA9IG9wcy0+Z2V0X3ZxX251bV9taW4odmRldik7DQo+IC0tDQo+IDIuMjUuMQ0K
DQo=
