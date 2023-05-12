Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C9700876
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbjELMvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbjELMvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:51:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D05414350
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAiNYQyO8KxAf6P7marpUJMcMVFEFXRRb2pJJzABeAj5p6+hNAxLBhAee1luKr+0FFUfE4tFpnflNZxH6CD6pxJRdG1esxuknaK+WdDc6N0rfhv4HwFEoS7X6F5kUCqu/F5L9YQWfHN7AjaRHU7B5iR/thGrEc0YcHO6ZfI/8GqblkybfSzPMFEnbr8mG/rAEQXwZ6eEAA64VoV3kkaQHKr7ax5AqoIFVGjfMAhuZ3BJ6JVPSANMumunMiK+dhDFC6rHCg8CVZmftAqZFlqsG5UlQ81rVsHYm5qPU24qtyj66L0x7Pc0JoOITAZSb783VhS+YGuLdQB8ihKODvW9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyWMMyU8ME7xOd3KWIdC95Nt3Z88rQ2NQ/uMU/lCwoc=;
 b=IHkE2Rlv/miQhPLUFSIJEyi+ng6iX14EZyCAI0FsP3v6iMCPawhVGqyA6FLeURulpGKsrN/TOxcQ4FUGp4UmFRwkCIrK2ltiKFKGvNcbpU2bafvcS6zZEojudG6uG0dJnvPSODnTpK+Bxp+OfWwWANaJN9bwDUhoNVcfpNNudswl0rPxudh48duRlk7WdV8wrNOKgEsG6xqwtEvLW6bsk2lX+KmBETIfk/0jDQiTjNQgAARBimqysUi46d+7FNMufI8QyeDn8vMpmJUBl6TJI0E5tnZdEzasyILcly0swin43wpyBzUgKC3HhLQE00UKJJ72HPy2MczJ8wWFLp+cSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyWMMyU8ME7xOd3KWIdC95Nt3Z88rQ2NQ/uMU/lCwoc=;
 b=Emi53xVvt5hGKzgzAlRQCuFvJCRJOWRnx/Zz20enteJw+E0iNBaxG12DrDGZlsmZmibx4D8+kqiqPkv69r2VJ9rvvVIlrrLeTKX+aNXVHymi3ILwjNRQ6j/q8rRQLFple1ijaKGHTvZ7f1dBo2k85NE32roIG/AbJOJ/itNNWD0tnPhbWx1itFm+cayMo+wa7z8hcWKsXGCake1J2Bh1Wmd8yzfiaNrvCn+W1jt6p0pkwOPKOW4MH+q4DdlDIlCCkpuv6wRGSGY4I34YzIKlo1nRjMdAjal/tYnaJhAXo7lhuc9mbsmihPIZpM59r1mxFySFMXY12zOICu9ifjGCsQ==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 12:51:22 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::9e8a:eef5:eb8a:4a02]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::9e8a:eef5:eb8a:4a02%6]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 12:51:21 +0000
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     Feng Liu <feliu@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Gal Pressman <gal@nvidia.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Thread-Topic: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Thread-Index: AQHZfo9/nZP06ML0wECcAFMaORWcJ69KWRYAgAAcyYCADC3pgA==
Date:   Fri, 12 May 2023 12:51:21 +0000
Message-ID: <8e1f076cb09560ee2bcda2092c0de10a701ba00b.camel@nvidia.com>
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
         <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
         <20230504145110-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230504145110-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|IA1PR12MB8517:EE_
x-ms-office365-filtering-correlation-id: 28aee20f-e32a-4aab-5bee-08db52e79671
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 63LSuP1Mn7aiU2rpl0slt++wge1PI84I9Z5e/XBfCz7iB5i60GjHFTm5KLhtY8tJWVSE59CtXcV7a0snj6bqRKO7hWKmgezHzlHXA8Qzy+bEbiaiPJaKWqOzpY1jJCn8eVYy4zusHH4jZZpxMJnxXuInThm/xSGj4GcOlUYqTkLMmM/6AJN2srk2x0Y6cPU+RbTsIG8x1nSqcCvPG47A4lSKIcoXLyd2iiGuLQP7E9n69hssSeQFTs6cQ42kaJF0CLQQu6GqWpY0QtOfluGjcMw9itQcznSi93c6Ct/x6deqeJk2okIaGTKUajx3+WJLXfN7Qu1MO54mKhGFsXKrBU45sbk0sVxpFjKHcT/9/7+pkOTcUG1ogESx5Rx4fwYpZFaIW5oLrb6YWATw5anVwQpTJdQxxlBpuIjUNlQ9tPE4hVErU6QiTXZuu7cZHvcU84ceJbyJ6ua5D9O6gIIt+Bbs741JMWyrAGGJaSi/TlDdeqlTGwZxNTZ8Yn/AU1gUEf4+hifAc9yTdBO0Lct4y130qc6IrBZCjVzQCMgdccl4nkELWemywlanGUtGy/aiQchOEGh48Oe3aLa/zfuQAVHT3x6ydnt3j9Lz36nUgezvd/aOS1vwROe7GUaXnVlj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(41300700001)(66446008)(64756008)(66556008)(91956017)(66476007)(76116006)(66946007)(6506007)(6512007)(4326008)(71200400001)(6486002)(110136005)(54906003)(478600001)(316002)(8936002)(8676002)(5660300002)(38070700005)(86362001)(2616005)(83380400001)(2906002)(186003)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFIwWnp0aFdYUmZVWUxxU1MvWVBwNnhUdVlwQjAxajFGNldmK2NpZkV6aWRG?=
 =?utf-8?B?TEY0VkpGMTBJM2g4ekNDdXRISk43elRoamxPWmxrZTJmeVVYME50dHBQdm12?=
 =?utf-8?B?aVhDaU1nUWdaT2dib0JCQmxSOVNnamRIdFRxeHFuWDFrSm9aNmZQeW5kV1ds?=
 =?utf-8?B?ODdDRGgzR05GZEk2V055USs0d0R3RWxVZmtnWWJsQzVaU045bDRhZExrTjhR?=
 =?utf-8?B?V0x3M05SV0xIRVVvZG4xTFJBVFNOOU1aOXV0SzdTSjRmdG90RXdaNW96WWdW?=
 =?utf-8?B?RXBKQjRYekJkQTFHSTJGMitxdVVISEw1UnpJc201dWFzVTFObFVtWmV2QTBw?=
 =?utf-8?B?ZFpXREZxYU9YYWlIV3d5bkQ5RlNGZDNUNGJ6b1pBL1JHTkZ1SC8rdnRCK0l4?=
 =?utf-8?B?K1JFVWZacUZXV0t4OFlvTEF2cG9nWFNqNFc2Rjdxd0IyQzVTalR6ZFVRc2VN?=
 =?utf-8?B?RVpUY29zZVEzOU1SUjJSZmdtOGU5NnpabWZlTXVsRzdqM1gzdjV5bWxTemNR?=
 =?utf-8?B?Y3ErUnM1a3JtNElkdEhtczNHQ0ErVld4K05ZT1lVL3lhQXo0dDJWUS82OW0w?=
 =?utf-8?B?MXlObzIvNEYrODY1YzF2S2pjY0pKY2NoaEZZZUpYV203UnJmRktseS8wVEpW?=
 =?utf-8?B?U0NnQzJTODMyU2I5QUVqSy8wNmdtUGFRU3paM2Q0dFVtVlZjN1BZQjVUOW4y?=
 =?utf-8?B?Qk1VcXp4S0pRazBZdUwwTWtDc2ozZnRpdW1aNXhvNXRTd3lDODhLZTlCcHNK?=
 =?utf-8?B?eXpYbkZMcXNueExrUVhvUmllckxrNFI2OU81dmM5bTAwRU9hQUhUT0ZuRER4?=
 =?utf-8?B?WjJiL3lTdm9KSkFBQVlxRmdZNXBmb1F2TkRVZE44d2tDMml5ZVNFRW9iWkxa?=
 =?utf-8?B?TjBpcXo4Rzl4QWthb1FqdGx5d3o1UDNXWnhscGhabG1xQUdlUTZOeEFVUXl3?=
 =?utf-8?B?cDJpK1NuTjVyVTJNUUxxUk43VGw2TUdQNVYyeTRpSklYNTA1R25aa1RreStt?=
 =?utf-8?B?aHI5RzZtb1M4bWpxelYzb0luT3VZZVBqelF1b3VoZ3BBeXVzYnFnejhsc2Jm?=
 =?utf-8?B?NUJRV0hTRnhNbUcwZHVWNzBaV2dpcnFWTWJOVHJmZ2R3UzVCUnNSRmJaQStI?=
 =?utf-8?B?cUM3dEYvMkM3NllybEpBNjdMSCtlM1BDa1JXV2kxRVMyelg1YkxpQWszSmhN?=
 =?utf-8?B?SWU3M0E5d0gzem1rZjhyTUdqbEZEQ1c4cDY2d2lPa2RoUzFOM245R3licmdm?=
 =?utf-8?B?dnRZK0RyUlo3cXBiRjNmVnAwK1QzYkJKQWUrMmxwUlBLa2kxSVFkQXM0K3ND?=
 =?utf-8?B?dlFzMmtkOHlnYzZDN0FrcEg2TWRxVkZCVEhzc1krN1dzTjRHNVBSZXR0VmYx?=
 =?utf-8?B?K0VjVy85VitjbTAycHlCVTg3Q2JIUU1WRVppQmNWcW5zaGdsRGI4bGgrMGY4?=
 =?utf-8?B?WWVYellpMHBhaFMrb0k5dWJjUUVpUmt5WWNzeHZhUWI0YmUvRWd3djVQNW52?=
 =?utf-8?B?bkMrUmZJYUN3dGxBenpEUTk3aTIxWERLZTBoMzJOWi9nNURTVzR4NnMzODZG?=
 =?utf-8?B?bkZab2o4ZzVqV2MyelNpd0l6aFdRdmhzQTNzQytVSXQ0TzhIaUVtWnhBRVZD?=
 =?utf-8?B?RlllakIxdFAxNklSOUtOMk1HZS9vajF2OTRUQ0pTajVJbGxsSWdjTXJVRGNZ?=
 =?utf-8?B?NUFhblhTTHVobmZSSkpTTlo3WlFPYi9zZ24zSWFLOXI3SVdvaGxIUnhha214?=
 =?utf-8?B?cDUzd1pxV2NrenZOb0ViUy81eTVLN013R3VRVU9UZk1yeUk1Q0J1T093VEM0?=
 =?utf-8?B?TER6UjJvc3F6MEl1RDAvQ1pvbzBDSURkbmtkVVRKelIwbnZUN1U2VUcrNGRi?=
 =?utf-8?B?d1ArRitneUR1bGJZQWpnL1pmMEpPRjlkdmRtWjJobERpQnBNaGFzbXVlVUFE?=
 =?utf-8?B?UkxpVmxYd014bmMrY2Z1eHNoeHdCWWpmS2p5bEhYb0RkZnNlRC8xekVvdlZ0?=
 =?utf-8?B?WU9WbTZFbFp1R3VNbDdUcS9nN1QwM3d5ZlN3elY3QjZGeFlzSnd0S3A4RXgr?=
 =?utf-8?B?TlhUbE5zL0JsdWpFekMyQkI1MW5zbm82a1dIeFE3SDJNUlp5dC9MUU9UVTZh?=
 =?utf-8?B?VzJBYW5CaXRPRENVbGNZU1RxdFo4cm9BV3FUMFpOUWRTdkVKQllQUXJZSncz?=
 =?utf-8?Q?Mo6e4MmrJmBvp/lYpDkIa1nYmc6kMKJEEL7hIeoj2eBF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D99850CFE4B4024692D6D6C499BA338C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aee20f-e32a-4aab-5bee-08db52e79671
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 12:51:21.7991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXW25WpJ5mf1S6PYjaCqvLkyDNhGe9wTfOjra84NgF4zteIu0UXXCqhIVTTSv+6dFO1ZYpM6FkLCaYhEBTNCrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA1LTA0IGF0IDE0OjUxIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIFRodSwgTWF5IDA0LCAyMDIzIGF0IDAxOjA4OjU0UE0gLTA0MDAsIEZlbmcgTGl1
IHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+IE9uIDIwMjMtMDUtMDQgYS5tLjk6NTAsIERyYWdvcyBU
YXR1bGVhIHdyb3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGUgcmVmZXJlbmNl
ZCBwYXRjaCBjYWxscyBzZXRfdnFfYWZmaW5pdHkgd2l0aG91dCBjaGVja2luZyBpZiB0aGUgb3Ag
aXMNCj4gPiA+IHZhbGlkLiBUaGlzIHBhdGNoIGFkZHMgdGhlIGNoZWNrLg0KPiA+ID4gDQo+ID4g
PiBGaXhlczogM2RhZDU2ODIzYjUzICgidmlydGlvLXZkcGE6IFN1cHBvcnQgaW50ZXJydXB0IGFm
ZmluaXR5IHNwcmVhZGluZw0KPiA+ID4gbWVjaGFuaXNtIikNCj4gPiA+IFJldmlld2VkLWJ5OiBH
YWwgUHJlc3NtYW4gPGdhbEBudmlkaWEuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRHJhZ29z
IFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IMKgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCA0ICsrKy0NCj4gPiA+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
dmRwYS5jDQo+ID4gPiBpbmRleCBlYjZhZWU4YzA2YjIuLjk4OWUyZDcxODRjZSAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb192ZHBhLmMNCj4gPiA+IEBAIC0zODUsNyArMzg1LDkgQEAgc3RhdGlj
IGludCB2aXJ0aW9fdmRwYV9maW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZQ0KPiA+ID4gKnZk
ZXYsIHVuc2lnbmVkIGludCBudnFzLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9IFBUUl9FUlIodnFzW2ldKTsNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9zZXR1
cF92cTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wcy0+c2V0X3ZxX2FmZmluaXR5KHZkcGEsIGks
ICZtYXNrc1tpXSk7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAob3BzLT5zZXRfdnFfYWZmaW5pdHkpDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3BzLT5zZXRfdnFfYWZmaW5pdHkodmRwYSwgaSwgJm1h
c2tzW2ldKTsNCj4gPiBpZiBvcHMtPnNldF92cV9hZmZpbml0eSBpcyBOVUxMLCBzaG91bGQgZ2l2
ZSBhbiBlcnJvciBjb2RlIHRvIGVyciwgYW5kDQo+ID4gcmV0dXJuIGVycg0KPiANCj4gR2l2ZW4g
d2UgaWdub3JlIHJldHVybiBjb2RlLCBoYXJkbHkgc2VlbXMgbGlrZSBhIGNyaXRpY2FsIHRoaW5n
IHRvIGRvLg0KPiBJcyBpdCByZWFsbHkgaW1wb3J0YW50PyBhZmZpbml0eSBpcyBhbiBvcHRpbWl6
YXRpb24gaXNuJ3QgaXQ/DQo+IA0KPiA+ID4gDQpzZXRfdnFfYWZmaW5pdHkgaXMgb3B0aW9uYWwg
c28gaXQncyBub3QgYW4gZXJyb3IgaWYgdGhlIG9wIGlzIG5vdCBpbXBsZW1lbnRlZC4NCg0KSXMg
dGhlcmUgYW55dGhpbmcgZWxzZSB0aGF0IG5lZWRzIHRvIGJlIGRvbmUgZm9yIHRoaXMgZml4Pw0K
DQpUaGFua3MsDQpEcmFnb3MNCg0K
