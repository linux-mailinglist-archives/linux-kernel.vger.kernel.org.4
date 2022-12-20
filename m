Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062C7652937
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiLTW4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTW4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:56:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AFABA8;
        Tue, 20 Dec 2022 14:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nnl19Vri52YAbEtZ7UYlJo+gfKyrF4lOlX4wAn8G/Y4eGN19kEwax+UWmfVNmxD84ZtkkrqI10rZJlnWEOiVZRdGPn0ATaEzZVFD05+xNUvPgqmjk432g7/r6AQw9ka5za4ST5ZN+aDTIyho/gQQjMa66RmEW/pm1U+Q1Pd/il5ogKqbCIWBxyLtzPnwbZYJAwpbE7PVQC0TwIAAPGZsHpbbLe+bw9+L8orqogYVcojdky34YkWVgWzhymiyZ49sbnsIYrA+rOiYjK/93SXaamlGFGn2XMWhTTOG8GWJIQQx2gv7vNiSEjADEdHE1/WWQ/k2Doyoo19NZ6ZJqPawhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvBVB/DF1XXxqUlj7HPicxWAqIHk0fcS167YG27OAdc=;
 b=D/B1mFb1DPTHIth7Pfb761GtVekS2vQ5ixZkZWXmOF1hZQoNmstB1eESHIm6nav9cWll4kS6JKzcm/+0Moux6P1Py6i/a1zftZG+kB19c85b4WcXEhVbXjpPFa37Nk8UAv+vQ2K4l26b8Az3mjUSw8hSPHqDx1X46W+AB8QkwKnMNekfRyQHVuvV1mL80Su/vaMtQnqfT6pCXq8xInIA+SAFiJT/EVvPgTGmk3jcMoBq8OBGV4vBPwu7B7RG+aZ3jN0Gc4KwGlQwjuxEphYVNwV6WHIWwGtSwf3YI7cbATRzmc7Q3yt6owkahLiJd2XgDbgdHm40zPZMuABs4mUqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvBVB/DF1XXxqUlj7HPicxWAqIHk0fcS167YG27OAdc=;
 b=d8TgZb26VryaxCm7vese4z3HdLbbMH92sqemugNEIqTs/z5acr+JsIYdTGCS1iW1zTSC1gJD0bb/Yuktq814tt6qwpssu3lJiETbjeOw1JlTA8WvlxF6WTjcFsmGwBpK5BLnKyulRfYmZ+wxCG2dbZI+tG/8vlcxJ/x1QsrmkbUkN673JI2JX7Gr6lF8iLN5rmIg29H7YN7t7bg0gsFsTG/k3tiDCb+YwMeoyR4cd0j/vzDPMoswXyb0QxDKnkhkKGWyOcQUf2dW2tW+0JuqG6zeN1ZZFL8r/ZJJl0fu72zbiimxiQkvtzEHZ7T10Po+c0B3RQj9tSA7Ot76LnWU6A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 22:56:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 22:56:01 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio_blk: zone append in header type tweak
Thread-Topic: [PATCH] virtio_blk: zone append in header type tweak
Thread-Index: AQHZFHH4oOTnmKndB0uRqhZGeI3qjq53Y5AA
Date:   Tue, 20 Dec 2022 22:56:00 +0000
Message-ID: <c06737ab-66d1-77bd-7afa-0a23cbe6aeef@nvidia.com>
References: <20221220125154.564265-1-mst@redhat.com>
In-Reply-To: <20221220125154.564265-1-mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6493:EE_
x-ms-office365-filtering-correlation-id: 9686202d-af2a-4bad-64be-08dae2dd5d7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBxoDS+YoyAgosiNlKyFBt5tw7IZaxYaUYqU/8Jdkt0fDiNlQlA58zxiRYmQw3eNIIaKIHpQ6UXv/rpJp2acquMnzaOv6x10fMJY2bzHckTIi9PeIsrgV9PAiwgHEsNnGZT/supkhzkWgYBaD/rb6OpIETU2oW6b0Kh3NP7v063fQHqvy6JFzLL7mY6l6K3JyzV9nYourfspyAZSsEpcfKnegvqew6lqwBXMS3FLbeH/ntRB8GtIbXmLpf2b87MzbAhRta3Yqy4VKBGBy1Pl6jE0566t6qK/7oz3boS6ToCgt8jK/Q1Mbkym0bMmcjs68+JOJa+Ysj2vy01a3BrxQlHVkA9b8Uex46OlegSsMLAE9eDshI1BfY0qO7Hd+BcKK32obTSuGx+Ecc2dOip7FacndhP85cdUKdKOgERh9WYVJquru4CleAQpKVh8sgsDHeDySgngAnYNoX9dBrogR5hM0B5S8n84VCDWZ4a5EpH+JwvcIwAdyZ06MJD2hIxD4JkDXST4etGqV+eNXcQw6epAtqUK9bXmNQlsnFqx3w63TMZkUR9GgPgzJ/KAFPyLTgxQS/1Ro7E5+Lkljk+002cptEHftQaC6TsUBpQq7WhFQMoTdztrNmOEIa81d3UW7bK4Dxc+GicSAwl3jGlxeZH//0d2AQxs1go0I4BR2UHaQTGtmyx7Qv/6pnkqzcn6unhIgcN+/X/ciP0thIKUP4z4OgWefHw//yL+1VgiunqNlOCxkTn45pXLLUrZwc13
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(4326008)(8936002)(478600001)(91956017)(66476007)(76116006)(66556008)(41300700001)(64756008)(110136005)(66946007)(36756003)(38100700002)(53546011)(122000001)(83380400001)(38070700005)(6486002)(86362001)(6512007)(316002)(8676002)(186003)(6506007)(66446008)(2616005)(71200400001)(31696002)(2906002)(31686004)(54906003)(5660300002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFhRZ2FPRjZvNFZQSkRUY0FXQk9uQm5uamJuOHpPYWxPMVNFSVFXT0RWR1Rw?=
 =?utf-8?B?OUhaWFhFa0kra0I2NGhiQjdqenlaeGt2eUI0Z0dMUVdReU9Zd0pPZXIxc1pK?=
 =?utf-8?B?T29ONlpSNWlWaUdyU0ZnS1JNNE1zM2hoYmhodWhCY1lGTXRvR0VHellpcWV3?=
 =?utf-8?B?Y3VvQ2kwd0YvcTZodGZDMk1ERzRBZ2JFdC84enR3QUFhT2VmczdMZHBEUFpR?=
 =?utf-8?B?V2V4MElVblYvQXdLNE9QYlJ1c092cGRidkFENjBsbW83TmxYaUtiZWliZDFp?=
 =?utf-8?B?dk9jUmlUWXc1VDlvR1RMSDFEMmlodVFITzdmQWJxQldDSlV2bzMzY2tvOWJ0?=
 =?utf-8?B?emNySkM0QXpXZE1hU0VLeTVpSEgxU1hzanRnNlY2MXpJa0hVQ2VzbFd0R3pz?=
 =?utf-8?B?VnVhQmZvYlhzMklEMStWb0V3SVY3NVUxZmxTTVF3a2dLTWxHVjJPbmw5NXZY?=
 =?utf-8?B?V04yL1V4dnExM2R2ck1qdFBwazQ0UzNONC8yVm9VY09FSStHNlVWNXVidTgx?=
 =?utf-8?B?aS84TTlscDl4dEhsRmc1RzV2aHNlTG85ME11blZObktZWHVENlFWdzlYajBR?=
 =?utf-8?B?a1lGdUE0cW84ZVZGN011TzhiRFJ0cDc0K201RVBEczJZNG5IejZrZHRMWE1w?=
 =?utf-8?B?TXVPSWo4Z242eTBoQi9PZkZpYkIyVEh5RkM5cGZoU2w4VVdYb3hUeHlMaWZm?=
 =?utf-8?B?UXYyWHI0WkNDQm9DM3dlTmdLMVJiZHE1Z1ZGbGRjVzhEeExzOUE3eTJuN3lR?=
 =?utf-8?B?UjlqMDlLL1p3ZGl2SlVGZEc0aUFyWkpSL2J3YUNrdS9SUDgrYVJ5dEFhZm9P?=
 =?utf-8?B?aE1qSXRVV3R4MDB4Q0xkN0RPNGs0QVlXa05UWjF2Y2F6YXgvRy9wYy9aemhR?=
 =?utf-8?B?Y2I3R2x4M3pYOFlvTWsvY1V3Yk9QTFIvSzVPRElGWWI2a2Jza3J4YjVtejlC?=
 =?utf-8?B?WmNwRkl5czBuNUYzL0c2SGJ5V1pKOERKUnY5ZzBIWWpmTWR2TnJlZTBhTS9h?=
 =?utf-8?B?cjY4d3JUVUliS0ozOGdEOUIzUmZYN1J4MGZGWFF2Q1FQVmhsOXdpblA4V202?=
 =?utf-8?B?eEliVFpQUnNQN29BRmxtaUhNV3c5bWRrenRPSElPQjl3cy8yay9zMmpjZkpY?=
 =?utf-8?B?VmxjanladHp4Wjhyc0dkcGlseTg0SElvWDhieU9aNDZIcUlUODVicW5EUGFs?=
 =?utf-8?B?eUgvcVJ2S1Q0a0JRZjdXdG9nSmNlRGlHTTJMVjRIakhWK1dCYXVXZjIwZVZR?=
 =?utf-8?B?NE5YdVRlakxoaVR2QU55S1dKekRHbHowMTgxK0pwNTNCeFZBZVJ3cWNlQTV2?=
 =?utf-8?B?ZUhXeFFFUzBiRGRab1dKUnFYRGVTTE90ekJVNmgySzIrYmwvVzZzTmgydzc2?=
 =?utf-8?B?NStmWVcvZlR4aVpGZjByeGJFb2lVY3pNV2d1R2VIU0xvWjVDT3BQeDdzZzBr?=
 =?utf-8?B?Y3ZHd1lmeFZneUNBR25lU2U4WWtLdHZpaE5lQ1hIYlRSYjdwT01weEpiL01o?=
 =?utf-8?B?bUtvS3hBSUxSRGpYL25HaC9DOWE2NW9JM2ZTZjYzWnRkZW5nWDZsSlYzVUUx?=
 =?utf-8?B?NUJBbEFtN3diNUJKR2lkS2V3NndUc1piLzlYcVdJNUlFMnF1ZzZSVG84YVoy?=
 =?utf-8?B?VGdNSEZMU09vckI5TkVsd3NlU0REWXpsc0hKSXZHL2hUd2dzRHUzTnNsQ2I0?=
 =?utf-8?B?b0FLMitwTm9RZlE1cTZTTmhvOVpZK3VTVE4zbktrT05DVFQyYTl4NE0zbVMr?=
 =?utf-8?B?OVh2WXpPVXNUMGtxUjRVNEZrODJzNU9Qc0FRMDZkSDR3Nk55NVY3eVorb1ll?=
 =?utf-8?B?TnJEVi9TRXFtWEJDY2xmWEFuazFHbVBjUE4wNXRLb3lTM3NDb3pBYkFBYnY5?=
 =?utf-8?B?QVEzdVpsWEYyMXZhTThtR0ZqTXZvbURCdFpMK3BjbEx4SFk3M1lFbmFRaDlW?=
 =?utf-8?B?ald1R0NmaUFLMGJVbVJEM3ZhcGdIczRMRno1NFV0YVo5RWJrYTFxQVk0RFNv?=
 =?utf-8?B?WEhDUHlGYW84WEpNRmhwQ2JIK1FYM21menJwWWJGMWt5RGNjL01RenRzckxB?=
 =?utf-8?B?d2wzQ3Vpd2RDWUNiTFlHeWF1dDV0T1cxZnRLc3NLWG4xRHlaRXdGRWp5MVFN?=
 =?utf-8?B?aTRQRyt3MmR0UElWK1IwdTQxQ09zVUFSWHg0MUFXQitybks4RFlEOWZvWXh6?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <507357BC8CBA4A4BBAC5A0C7A6150A05@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9686202d-af2a-4bad-64be-08dae2dd5d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 22:56:00.9960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+YxDC19aIFXcEsuJ7Izd6TQduqJWSqbqzlDx7Nr+YihTubOQyNxNW4pKlcxpLAEpZ+sCJw+se3VHPJ631vB8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjAvMjIgMDQ6NTIsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gdmlydGlvIGJs
ayByZXR1cm5zIGEgNjQgYml0IGFwcGVuZF9zZWN0b3IgaW4gYW4gaW5wdXQgYnVmZmVyLA0KPiBp
biBMRSBmb3JtYXQuIFRoaXMgZmllbGQgaXMgbm90IHRhZ2dlZCBhcyBMRSBjb3JyZWN0bHksIHNv
DQo+IGV2ZW4gdGhvdWdoIHRoZSBnZW5lcmF0ZWQgY29kZSBpcyBvaywgd2UgZ2V0IHdhcm5pbmdz
IGZyb20gc3BhcnNlOg0KPiANCj4gZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmM6MzMyOjMzOiBz
cGFyc2U6IHNwYXJzZTogY2FzdCB0byByZXN0cmljdGVkIF9fbGU2NA0KPiANCj4gTWFrZSBzcGFy
c2UgaGFwcHkgYnkgdXNpbmcgdGhlIGNvcnJlY3QgdHlwZS4NCj4gDQoNClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
