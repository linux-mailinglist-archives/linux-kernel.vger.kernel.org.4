Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149AF73631E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFTFVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFTFVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:21:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628311A8;
        Mon, 19 Jun 2023 22:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcOj2vTh1//k/nvbY/tCf9wA1lUo6FuXfP3nnJFK8UtksJyCmrHmYZZvJwkSQMB8vdRQ1JcmQZLFFh7jERTsA9HzC7keghBXeulmGLChWmGw6Xe8+dbUnIrnWdJd53nxQYYPuwjCoR1FLr9VavAuo3gx463F6BT6ec2WZ2r7jxfVoo48RAaPub34X4o+ZpSa6vVjT5ZMBKwxKR29742GHRhM9aAM7yuZnmBgkIcVSuDW9I6z06bgCojwSDWZO2HmGWj2C9prDCLqxjKEdEbLADCLXNI6EucX3dUn4FcW41K6RQuA1zQRJdhXZyh74ey943JP0ZqQHcNhOBY6+AN7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUpmgQIMsaJh8RUjb9MLBzwqp/Lsqf55aLDuMl0ABh0=;
 b=EAzqPc4Dm2FyaDF0s5khvFUcr1rMjtd1PyhHGmtvrMilvjVUf1nl1jsNQal9Ltnn+vkylxgMzoCWWMrmLtE1uFM6KDsFXwDoYJNXfDKW7vBuS4ovDSMQGXXUBtfxXJy4SqKov1y2SjEj1yXOXNd1PCdmubONEyNDUcdv8Vi7M36C6LbqsFY2HIW8Vbo9DqcfWWjWhquvN1z4ukMhUUOsBow/3mCnVpqvp2xXbFW+uOVnclXXWZxFIBGxHhFWyi5DOzQtklw3osKONdrKC42wqB/cnt4Nk7l0fZ+lhhT+SytdCdx/ApO7CfPAyP1K5bbZQCCsU9oYJ67U4ZKwm82JPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUpmgQIMsaJh8RUjb9MLBzwqp/Lsqf55aLDuMl0ABh0=;
 b=pIi1Hty6TC3dcUX2H0FY2cmkllTkWxf6cs9TE+9lGyTajTJlGXCq2NT67Z9mW60ILZYgVAZBJowDV6yjvH6o6g03A4F5hRKxz5mmIqNv4Avj5wSrOvWPrOrlVkvKoIfgOUDNq+yexrz+CRe3Qu2QeR3bBEUse6Wji8LXOZHM/YeFfDBeOD26v6H2YWnWVRTBVwpTQ0xqy6NdVOz4sAMiTU/bgO5NlwpJ0tDczo79b/M8xyx7BH3KzO/ki6A7GHacftyivRT4/1PkKGNKkBhwa9VH3KHs+VNLJmxVEiLe9oesuHdk3P2TwdImi7BbbqBxfNscDOuyT17lV1Ohc+P6GA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 05:21:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 05:21:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Thread-Topic: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Thread-Index: AQHZeUEoV9vRcEcRDUeYawN1RnJsFq8/xVEAgAAAdQCAAAHcgIBS9/8AgAC75QA=
Date:   Tue, 20 Jun 2023 05:21:08 +0000
Message-ID: <4c6438a1-c613-a2fe-1113-5ce8d626a44c@nvidia.com>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
 <3decbaf1-250b-9b73-70fd-4cb9a204c452@kernel.dk>
 <00537d0c-159c-a802-6ed8-209109a69660@nvidia.com>
 <e74dedeb-8fb0-8abf-5b14-1aae8e1462d2@wanadoo.fr>
In-Reply-To: <e74dedeb-8fb0-8abf-5b14-1aae8e1462d2@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH3PR12MB8210:EE_
x-ms-office365-filtering-correlation-id: 230c77a8-46e4-4500-26fa-08db714e273a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SseMdcYB/BVmpGtPDoXBo9t9xl9gyONe+lVOJ9ZW+ocLJMoGKd2FG4qmA03/H2YP7r+CvvxJGdl/eCVbsocW1vUmZ9KTmNTfNx0kVRZmZP1H+RfPWpKJyGQOKpIcQPu0iuspMlvBRjzizFfWDERxwzq0PTXm7FIZM5LcdIMOgs7Mhgnrwsdy15NZq+sNFaupvJWNIuOeYl2TezofzYuJDhfvEIQW5KSfv2JgYbwfaYhJHVxQZjdzP3vdB7cDdWe6CnNIxZO3mJNiZmZ/J0Ux/nTSwuNhtkQ5vs4vnqh0GbrloiiBOUz09X57J1qeMylOPbToQXUF5JG89zuEMl2QAJ0oszfqmmeP34+9xVqOoJEsvNB/0t213oxCcJzP0NeDI79WuUIMCR/niPrChY17H4e0nEVn5BYAnplg9f7WhO0npDBwnTgtol8MPptkEMkimK50vZHJ0LR+A2aGeb4IZ8CdqDc4H1YjuS1GwHbVJJ8CQu+NEgIh6RDBNFLBJWeqUfXC1sxBpDfTytRrCpVgx8flChojoGtWIhS/hSkfzHidqGlrKAXqUjvVJ3ceY8fYxymX78Xw5tJffyMX0fRHBfU1I0YmWyaqgYsCh4aic2trKGNjgefWq1oMn9VFuxV9IbUVPR6Dm+JffXC77Jv74XaPeJ9FZWZASGmZZ4e7qfD9Fqe4fM4MgLC/slZ06sEv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(71200400001)(6486002)(478600001)(66574015)(186003)(6512007)(6506007)(53546011)(83380400001)(2616005)(36756003)(38100700002)(38070700005)(86362001)(31696002)(122000001)(8936002)(8676002)(5660300002)(31686004)(316002)(4326008)(2906002)(76116006)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(110136005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3RKZUNoQ1ByNjF6enhwNzNJYTBBQXZ2d1R5VFRpN3crUlJSVldzQ1VWa0NS?=
 =?utf-8?B?UC93SEtGOGNPYnZjcnNMZEthSXFnU252Z3VPWGRrV2ZFS1dzTXJwUTJnSTVX?=
 =?utf-8?B?aGVzSWVWZzRyZ1BuUld4c2UxcldITkpTVUg4Sk1zMk9MQmp4QUh3NnZBNkVB?=
 =?utf-8?B?RkRaUU9MQzkweDRZVUdTUUxYU0RhdDhSRVoxMkdoVDh2TE5pMHVGS3ppcU9O?=
 =?utf-8?B?YlMrb0VkQm52WXN5OEp2N29QTFhncFpMT2hjaHoyYjZmU3pGelhIbFV6MWM1?=
 =?utf-8?B?VHhtNVJ0VE96NnF6UXdmaE1hbm05Uis3dXRJRTZwcm9IQ0x5VFJsaFV2RTJV?=
 =?utf-8?B?b01CME5kVk1Kbml0SWhvQlIvVFp1dXd1bEIvc0FkWE9ZVzVGWE55aDF5azlm?=
 =?utf-8?B?Z1BHY1VnV2ZSVmlXd2hVUWlTMzVhQytKTzhMRDZacVZDN0NCcnBENm43NVlz?=
 =?utf-8?B?ZUdoTXk1VU94bEo3TzRxZXBDMDg1K3FhamYxVmZpTVRWSFVpeHZVc21FekM5?=
 =?utf-8?B?L2piTmY4aDJPaWxjcVJSb3IrOCs4M0puSmNvQjh0YzNWbGttQWhOek5MbHZI?=
 =?utf-8?B?NERGeWg2Q24rNW1vVjNzRG1vYjhwcXdVNVZMaGJsVlR6V3loUEJlYmtMSm9x?=
 =?utf-8?B?OCs5Wnh3RVUxUzFpMzhreVovSW5jZzFvcmdraG11RHBJVlE5OTd6Rk9CY2pB?=
 =?utf-8?B?Z3J4c2dMNS81S09odTdVejZoVWU5L0VYdmxVNHAySEdRaFY5eWMrSm1pRVFk?=
 =?utf-8?B?T3VLdEZ2MkhyRlo2aUtGYTMxd1ZQTlVrMHRzcmI5Zlc4YTNTOGM5UytQYWN6?=
 =?utf-8?B?elJsaWZIYmRHL3JxbWNXUGNzSVJ4UjA3QmQ1MWJlSGtMUHNpZ0MzWnBrUUww?=
 =?utf-8?B?QlhqWjJSV2NUdm92bjVRR2FkMnhRc1Zab3pyMzR2TytFTm93RUd1TlkzV0kv?=
 =?utf-8?B?N1NOaURNclJnQ3VIenVoTTF3bXVCS2grNUVVZXM4OHBPQWZwMmFVTUI2STRV?=
 =?utf-8?B?bXhzZ0ZlV1Y4R1Nqb0xjclNJVXF0T2dueURtRThacFZETWdxRXlpbG5rT1RK?=
 =?utf-8?B?eVdYeDdjVjRIYkViVVR6Z3VHR3VZRmt2Ujc1NE1ib3JNNDFmdTIvWjJCbmdk?=
 =?utf-8?B?OE02WU5hWVA5dFVUNk1iU1hZaWM1MzZCZzgzQk8xemRFelNSNUdxQXYwNzha?=
 =?utf-8?B?dExObDZENmFDMGpyQTY5WmNQekY1VTFaTnI1ZVZHSnQzb1ZYV0tSaVQ2UHND?=
 =?utf-8?B?REZnVStjOHVQRUpjK1lDa3dneDlzcGx3SlNHZzZFL0JKYXN1WW1FNWg4YU5k?=
 =?utf-8?B?c1lMa2o0Wi9UUEk4K3VPM3dlWW0wQUdCSzdSNEtPNFd3ZG5tOXZ1TlFad1ZC?=
 =?utf-8?B?aER3b2poR3N6cEFQQWxDeUNlS0greU9QR3pOR2d3bklveHU1SHVZNTFYcDdq?=
 =?utf-8?B?bWFYcFpzbzVmNCtNc09SQ2syeHhTRExDTmk3d3RYeUpjQ3lMWnJ1VXN4WFRj?=
 =?utf-8?B?VXFTbkxvVjQ2RE5yYjBna2g0ZitnNVc2SFN5MjZSWWVzeU52T1JycHFsUzUx?=
 =?utf-8?B?dVR6YyszR2ZubHF5R2x4SitvR0RvU3pQY2hJSzZUUVFRa3ZyYWQvS1JPKzAz?=
 =?utf-8?B?VEovUFBNd3E2YW94bVpXTXdtR2lqT01aaC9BbVd3MUtUZFB0a0crZmtOQS9k?=
 =?utf-8?B?dmdGVkVzU04vVklGbjhVbitHaHZsbi9ZakZ3anNHT3FhSFU1NnZYOEpYSkZs?=
 =?utf-8?B?dzVRenl2NGNCR3doVWtwUldYdzFjYlR5WHk0SmpuZXUwUW04b1ArWUY4eVdr?=
 =?utf-8?B?RURjT1dwTm5zUzA1UWMrN0tFTG5ZYXp0SzNJRFhQUnZRV1Bud1NsbWw4UWdD?=
 =?utf-8?B?ZmFFRmFheE9ybm53S2Rad3Vvem41ZlBKL3p2WEFFdlFWOXVJdzJseFRxb3dq?=
 =?utf-8?B?K2FHT1FxcTF6SCtrNERrUmZKUC90RHlLMndMZncxbVh2VUkwL0pybFlHTVM4?=
 =?utf-8?B?U3lDazY1NEtvNUQraC9iYnFLNVV4ZWF4NjNwUkcrZnFXUzZsRDBiLzQrMXo0?=
 =?utf-8?B?ZXhUQnBkN1pEcDBENDlXOTJzdUlBQ2pONDlvUE9BZ2k2TDRqVXAzNkFmV2Z3?=
 =?utf-8?B?MGpIL0thTDJYaEhYZU5hVEtjSEtiNXR2dTE5dkVjZjJWNVdGcmp6cEFIaGFR?=
 =?utf-8?Q?Wl7pcx7iwO6t41lgFtkXM+eatmLhL37sv68cTO939+qj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41C0B8D03CB9864EB6176234C8ED8F54@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230c77a8-46e4-4500-26fa-08db714e273a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 05:21:08.2554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHP2sIy4ZSUECEQSefj57sxhjteuRzG0kV35foPJz/RksgF1IHHzAUJLdWj1Le7UM4AHrL264xfLlz94jibcYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xOS8yMDIzIDExOjA4IEFNLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3JvdGU6DQo+IExlIDI4
LzA0LzIwMjMgw6AgMDE6MDcsIENoYWl0YW55YSBLdWxrYXJuaSBhIMOpY3JpdMKgOg0KPj4gT24g
NC8yNy8yMyAxNjowMSwgSmVucyBBeGJvZSB3cm90ZToNCj4+PiBPbiA0LzI3LzIzIDQ6NTk/UE0s
IENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4gT24gNC8yNy8yMyAxMjo0NywgQ2hyaXN0
b3BoZSBKQUlMTEVUIHdyb3RlOg0KPj4+Pj4gR3JvdXAgc29tZSB2YXJpYWJsZXMgYmFzZWQgb24g
dGhlaXIgc2l6ZXMgdG8gcmVkdWNlIGhvbGVzLg0KPj4+Pj4gT24geDg2XzY0LCB0aGlzIHNocmlu
a3MgdGhlIHNpemUgb2YgJ3N0cnVjdCBudm1ldF9ucycgZnJvbSA1MjAgdG8gNTEyDQo+Pj4+PiBi
eXRlcy4NCj4+Pj4+DQo+Pj4+IEFsdGhvdWdoIHRoaXMgbG9va3MgZ29vZCwgd2UgYXQgbGVhc3Qg
bmVlZCB0byBkb2N1bWVudCB3aGF0DQo+Pj4+IGhhcHBlbnMgb24gb3RoZXIgYXJjaChzKSB3aGlj
aCBhcmUgbm90IG1lbnRpb25lZCBpbiB0aGUNCj4+Pj4gY29tbWl0IGxvZyA/IGlzIHRoZXJlIGEg
cG9zc2liaWxpdHkgdGhhdCBzb21lb25lIG1pZ2h0IGNvbWUNCj4+Pj4gdXAgd2l0aCB0aGUgY29u
dHJhZGljdG9yeSBkYXRhIGluIGZ1dHVyZSBmb3IgdGhlIGFyY2gocykgd2hpY2gNCj4+Pj4gYXJj
aCB0aGF0IGFyZSBub3QgbWVudGlvbmVkIGhlcmUgPw0KPj4+IFRoZSBjaGFuZ2UgaXMgY2VydGFp
bmx5IG5vdCBnb2luZyB0byBtYWtlIHRoaW5ncyBfd29yc2VfIGZvciBhbnkgYXJjaCwNCj4+PiBz
byBJIHRoaW5rIHRoYXQncyBzb21ld2hhdCBvZiBhIHBvaW50bGVzcyBleGVyY2lzZSBhbmQgYW4g
dW5yZWFzb25hYmxlDQo+Pj4gYXNrIGZvciBzb21ldGhpbmcgdGhhdCBtYWtlcyBzZW5zZSBvbiA2
NC1iaXQgYXJtL3g4NiBhbmQgc2F2ZXMgaGFsZiB0aGUNCj4+PiBzcGFjZS4NCj4+Pg0KPj4NCj4+
IGRpc3JlZ2FyZCBteSBjb21tZW50LCBsb29rcyBnb29kLi4uDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+Pg0KPj4gLWNrDQo+Pg0KPj4N
Cj4gDQo+IEhpLA0KPiANCj4gDQo+IEFsbCBteSBvdGhlciBudm1ldCBwYXRjaGVzIGhhdmUgcmVh
Y2hlZCAtbmV4dCB0b2RheSwgYnV0IHRoaXMgb25lIHNlZW1zIA0KPiB0byBiZSBtaXNzaW5nLg0K
PiANCj4gU28gdGhpcyBpcyBhIGdlbnRsZSByZW1pbmRlciwgaW4gY2FzZSBpdCBnb3QgbG9zdCBz
b21ld2hlcmUuDQo+IA0KPiBDSg0KDQoNCkkgYmVsaWV2ZSB0aGlzIHBhdGNoIGNhbiBzdGlsbCBi
ZSBhcHBsaWVkIGFzIGlzIG9uIHRoZSB0b3Agb2YgbnZtZS02LjUuLg0KDQotY2sNCg0KDQo=
