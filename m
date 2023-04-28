Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2C6F130B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbjD1ILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345622AbjD1ILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:11:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC7B269F;
        Fri, 28 Apr 2023 01:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqeLDf/tqXKce2YeaEmVBEkHSaExjUt/Itsj1lOtH63AdwEaFinDzeH9SsztXxYSQcjblIC3jndEXebIQKIuVlm07P2Krpuw313ehj4poE19F9DEjkDIyw7Rjkm2I21O27gxqzYXpd+skMLNC/Svohb4Fufxt//pEvUc03/Bbb7LC+6YITAHPld5OnuIpCPwtbmGOfP2vNaztSFET9B6lftjMrE4ACtPQE3sEzj5xI4ajTSymLC4DN0FzEXr7BLQOT0001ryVy0ogvu6YvoBL5CnqmGc5Tqb6JFzhgzEZSAbyPmVJLqpQVhtwGDZwlzrpVbNCtkFY5BrURhbnrdjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMojACbac+AICGoSQMdUehAIV/ibBMtPF1JGqTpDwRM=;
 b=Ag+1AkK/6IXw3OMFRkJEo3XeknOTrqz92sZQgyg30F50SsmUUdyljnC5+RhLK0r1DBq/WvUMHKo0vY8sKruQGrEpyPKuDrcdeiaTQPMtNz8xB57GW+nLBULiX1yImVQt0xu9vvjOi/1wWSvZ/FLjSE8vKj2BHcqyl9JCVkvjEexvtyedxydTCue2vv+r97/GwH82N2bM3I2ADhV9bd4wCIM3Ag7UCdbLun6gfQtYJ7Bpw68EK3YXuv+zpDxhie5vEe2Q9jTFqQuBwDknoJaUivnliSD/IqzzyNyXAT/1fZcl7kDJ0RCClrKiBBZseRIT1q+AqQQn0Wsm8UXgT7+SRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMojACbac+AICGoSQMdUehAIV/ibBMtPF1JGqTpDwRM=;
 b=qrLLP5S0qXGD3RtDmQ5hyOmtZ0XrWLlz42awBzKCn1uV0bMFSAGebwk9WbHv1PKJd62ddRb7Z+c2cWkv39OtGOa14qOkG9S9E/9fZaIrrlZSDudp8G8lGIeE0fCXCJNcosPSejljn3NQuMB4fuEM6aoOZBwN0a9RsGc4dByQ131/0v45TVKagYo+zfw0pCp8sF9wBJsgz0D/4VcwHJa7r1Y6tKWiUTR4AV+7/DnVKzEtag1KFIesRRfh44YdC81Xf86RtMwM9DRbToc+B4IEqNZVccceuMQ2ombToW6LnQ3bKKZfeNZBDql18Dvn0LX6mvy6zuXlsCH586ZkZqKLRA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 08:11:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 08:11:28 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Thread-Topic: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Thread-Index: AQHZeUEoV9vRcEcRDUeYawN1RnJsFq8/yOIAgACL7oCAAAq+AA==
Date:   Fri, 28 Apr 2023 08:11:28 +0000
Message-ID: <f1aea5d9-ca7b-ecf4-b162-cf760eafbe6c@nvidia.com>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <67a9e53e-4ac9-7ba8-9713-96c1dfe1e341@nvidia.com>
 <c704568d-16d1-bbd8-2b59-1d719f2bcf8c@wanadoo.fr>
In-Reply-To: <c704568d-16d1-bbd8-2b59-1d719f2bcf8c@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB8219:EE_
x-ms-office365-filtering-correlation-id: 97fddfbc-fd54-446e-3061-08db47c02b37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9nr4x+zkMqsRRsbgm25wDJVcFdyegErYd6lxfUaK0cpX9329Dx95SOZKGQU7bEUMPN596de52VNNndU7dySWlXDHRj9Fpgh0L0EAnK7zgy3oj5t2I7cepyZ1i3w43jsvzv5RUioZkynSrohdnakBbpj0n3pbq+0wkc0HzrLOLAIW7boX4YkgThBkVgSyUYrrgVophy+sWCzsmBj12FY/FKluVq8tQO6/vKjnTrWFG9eDyGMjt2tgCdZvmgtUC4lVCwjTZ+iSv57pjiyuFt/cGs0nc9uyq3/p5S/YFQBgiHbRhaN9YAWz4/i7Eg1226zsQ5jU3B4s6iHtrwTgSDKFDcvm9P8bKeWEt5jML5vD8V7QsXY6vxTqtGv9ZGNv8n+Pp9Bl3j22hvK48qdIs0fG+qIbPj3BLNIrcYTYCOUnu4PKCNxapl/2hCVhr0iZl6rV9d9nEP8PGYBMPjKzdVuGYxNew29/WxvMzoZuvVvaVatm9sMb7YCdaD10wLIglM6hfvrGZaB3+aFetuh0icEhBkYV2BrO72MvJmFIRXfwllqrQMgDDVb9Ves1MRBUbhQCwe03tyvY+KlkzvhoJXUFal3NAjWB8sigsqcDhS0TU0YmidHAYY7QlWG38JcvIqnqcQJb63kLXRikvtdYO9NCoos8PgwFiTfwNork1hNlnM9suSYD7dMgv82ScllhhHm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(84040400005)(451199021)(316002)(4326008)(66556008)(76116006)(6916009)(66476007)(64756008)(66946007)(66446008)(91956017)(54906003)(71200400001)(6486002)(8676002)(86362001)(478600001)(36756003)(31696002)(186003)(6506007)(6512007)(53546011)(5660300002)(2616005)(122000001)(41300700001)(2906002)(38100700002)(38070700005)(83380400001)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDdoRGloajdBYVBCSDhITGpocGE2T2x3dzNWU1dEOXBxc3VWTVRDenkrUEIy?=
 =?utf-8?B?TzMwRkFPS1h3QTFsandmV3IwbzV4cGpyNzQ2Z3BjVGVCTnNUMERPZVB4RExD?=
 =?utf-8?B?Sm5iSlZzbHNMNnFFMFpKRlROdHRlcFBDVDdvd0dGMTEzNFJscFZFWEZaME92?=
 =?utf-8?B?T1JyZ1BDdDJaRTRiU1E2NXVRbFUzS1BDMnZGZ3NvL3V4SnhLU0x3aWVpL0Qy?=
 =?utf-8?B?aW5XWXV6aUlVeWRTMFhTOFNwYldrZVA3R0RXempGT1Irc01MeUpidDMvYlJE?=
 =?utf-8?B?cXZxN0NiZkpiS1ByVWZQdGdpeVBqd2V4dlhpUTRHdWJNbzFrTWpyOFRpLysr?=
 =?utf-8?B?T3VSZTNzQmVzL0F3TjQrRVJzaFh4a21MSGVhT2R1ZlVhWFFtTkQvbGdIQi85?=
 =?utf-8?B?QzZSN2xoajMzVFQ4eCt2Z3R2aEVIOW1qZDdNTnhINkY0dzJkSHdGSS9qM3FR?=
 =?utf-8?B?QlplYlpMY3pXMDdKVU14RndIZjRJL0ZhMmZCS2pzN2NjK2plNDBaVlpmMktK?=
 =?utf-8?B?UzZsR0ExMFJ2cHFGRUZ3NjVwUm5teS8rV2dIWWFtd2ZBdUt0TkhYMVllZ1hj?=
 =?utf-8?B?Zkx3U041ZlRpV0RIVDlieTRmQUxXclRBcm1QMmVQRWM2eklMZGQ3R2tmRFF2?=
 =?utf-8?B?RVZ0ODhENjQ0d0NvQ3poQkttYnRsZk54d3VqcTZ2VE9QK0VveDF4N1cxcXVD?=
 =?utf-8?B?R0xsT0hLTUFaejVWWVZJTEE3V2NBQkVjbW5pOEk0eUs1cnF0cWxRWXBPRU1a?=
 =?utf-8?B?eWJ2aWxxMkU2cWZvV0FhLzlZenkxeFdMVWg1SkZSOUsxamhoaXNqc24ybkE1?=
 =?utf-8?B?M3hzSlFkdTBZZHBXb3NIQTg5ZC9NeTdJSHBvazdxZ2dVTzU4cEVETS9QMkV5?=
 =?utf-8?B?WnV0QUphS29ad1lMS2FpeXpMV0c2SjI4OTFJbGhOKzlzWlArR2hMNlJmRjBp?=
 =?utf-8?B?UFUvYU5sWVp0MCtzUWdUMm14K2NzQzlVRDYyY0FiY3AybzVIVkZVZURiL0px?=
 =?utf-8?B?WEtYckYxMTU0Yzh4ZEV5YjdQbEIwUGZuRnpMemdJVUI5ZjlzNkovUThJeVVQ?=
 =?utf-8?B?REpxbFlRR0Iza2czbGZOTUtzYkpyZlZoczl2cGpuTkxrMnRUSnFwb2F4WE14?=
 =?utf-8?B?aldHcVpSODlwY0FUS01JZ3YzSVluTWtWeHBRNHdhMEF6TFdqbFdwZnBXbGIy?=
 =?utf-8?B?L0pTUmpjbG01MW8zUUhiL0RBVmI0eWFWS3lpUnVoeWRVaVZMcEV2L0JkUlJ0?=
 =?utf-8?B?U3JLR0RReG96dXBvL2ErOUdNVDBPWUpIMXp5bFFoSkV4Y25QeHl4bnF3bGZ4?=
 =?utf-8?B?eFRobXBaTHhsYjkwSk80MWZyV2VDbUNGTnUwNGY2UFY3cnJBRnpha24waktk?=
 =?utf-8?B?SWg5aDloa3hmS0gxaUltQVJ1MVJzenF0ajBESGoyVEk4SXA2a0JjNDhVTnQ2?=
 =?utf-8?B?YUR5aEQyZGhMVWxMTTZlOVlHQU9BRWtKY3FQLy9IUGp0SytXc1lIbTRja0RD?=
 =?utf-8?B?cFNmR3ZpUnFZbE9VdU5aa25DaFVQYU12L0IyUWxJWGxBTGVTUUI5LzlBaWZj?=
 =?utf-8?B?ZFkxNUpNSVZIeVZqSTB3VGRUMTRqenNnYmZLTThRSVlhOXB5ODIrYUNoMjBp?=
 =?utf-8?B?QWN4MzkrdUJqUlZ1Ti9vYlYyUkNkdlpMQ3EzanBzOGhaMlhtOEpkSkF4bkJv?=
 =?utf-8?B?QytrOG5vbWs4Q1R5c2YvTTNoaTVNWXFma1ZzMzlucHFSc0hrK2s0MFZ2MlM0?=
 =?utf-8?B?T0dLNFlaVHZ3bGtMdXo5Y1IxVysvNFdxMENFcjNCV3A0QUtoUW9PdFJURmIr?=
 =?utf-8?B?VjBEMUVhR3JrWWNBWE1GcWIzRWlPbG1ISHg2WGpZSGRoTEVkOGxNam50VDZP?=
 =?utf-8?B?cWg0cEJSUVNBOGV0SHpjVEkxdXR1VmhmQWxPbFFLOFhxa3VhTmg5N0paUVI5?=
 =?utf-8?B?K21RTzg2U25EMjEvZjNqNWZlSkpSRkRsd1VQN2ZPNFg0OTFhL1RxRUdsWlpi?=
 =?utf-8?B?c3RxRGh2QkxuZ0k4MXFJOExCSHQvbCtXOEtDY2tacWJXMW03K09qKzVtTk9s?=
 =?utf-8?B?SzZOK2xCRGNQQURBa0ExTFF3S05JaHBLejV3bFRDeTlJQ2xiUDhQWmRsT205?=
 =?utf-8?B?c05MblE0TDhoVFFsTGIwZitHWHNUWVpMbHU2ZWFhU0RUbkRValNhY0lwQ3Ar?=
 =?utf-8?Q?4FPyc6edFX+VDZhFrdDeyGUdKRlUrwCZMXABMusNMNjV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E61A1D4DC300B04D9DADC7D5CAB76AE7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fddfbc-fd54-446e-3061-08db47c02b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 08:11:28.7355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g67eUDIvxjCFFdZOXvCSUkN1slsQ8i4djezi/Taidn/OkmU+FWaja+bVx5iEY5Ecm4usFRrWRP7GIcQbuNOobg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOC8yMyAwMDozMywgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBMZSAyOC8wNC8y
MDIzIMOgIDAxOjEyLCBDaGFpdGFueWEgS3Vsa2FybmkgYSDDqWNyaXTCoDoNCj4+ICgrS2VpdGgs
IGZvciBob3N0IHNpZGUpDQo+Pj4gLS0tDQo+Pj4gTW9yZSBhZ2dyZXNzaXZlIGdyb3VwaW5nIGNv
dWxkIGJlIGRvbmUgdG8gYmUgbW9yZSBmdXR1cmUgcHJvb2YsIGJ1dCB0aGUNCj4+PiB3YXkgdGhl
IHN0cnVjdCBudm1ldF9ucyBpcyB3cml0dGVuIHN1Z2dlc3QgdGhhdCBzb21lIGZpZWxkcyBzaG91
bGQgYmUNCj4+PiBrZXB0IHRvZ2V0aGVyLiBTbyBrZWVwIGdyb3VwaW5nIGFzLWlzLg0KPj4+DQo+
Pj4NCj4+DQo+PiB5b3UgY2FuIHNlbmQgUkZDIGFuZCBJJ2xsIGJlIGhhcHB5IHRvIHRha2UgYSBs
b29rIGlmIGl0J3MgZ29pbmcNCj4+IGhhdmUgYW55IGJlbmVmaXQsIGl0IHdpbGwgdGFrZSBzb21l
IHRpbWUgdGhvdWdoLi4NCj4+DQo+PiBmb3IgaG9zdCBzaWRlIDotDQo+Pg0KPj4gd2hpbGUgeW91
IGFyZSBhdCBpdCwgaXQgbWlnaHQgYmUgdXNlZnVsIHRvIHRha2UgYSBsb29rIGF0IHRoZSBzdHJ1
Y3R1cmVzDQo+PiB0aGF0IGFyZSBhY2Nlc3NlZCBpbiB0aGUgZmFzdCBwYXRoIG9uIHRoZSBob3N0
IHNpZGUgPw0KPg0KPiBPaywgd2h5IG5vdCwgYnV0IGNhbiB5b3UgaGVscCBpZGVudGlmeWluZyB0
aGVzZSBzdHJ1Y3R1cmVzIG9yIHBsYWNlcyANCj4gY29uc2lkZXJlZCBhcyBmYXN0IHBhdGg/DQo+
DQo+IENKDQoNCnlvdSBjYW4gc3RhcnQgd2l0aCBudm1lX25zL252bWVfY3RybCBhcyBJIHJlbWVt
YmVyIG52bWVfbnMgaXMgdXNlZA0KaW4gbnZtZV9zZXR1cF9yd19jbWQoKSBvbiBob3N0IGFuZCBu
dm1lX2N0cmwgaXMgdXNlZCBpbg0KbnZtZXRfcGFzc3RocnVfZXhlY3V0ZV9jbWQoKS4NCg0KSW4g
Z2VuZXJhbCBudm1lX3F1ZXVlX3JxKCkvbnZtZV9yZG1hX3F1ZXVlX3JxKCkvDQpudm1ldF9iZGV2
X2V4ZWN1dGVfcncoKS9udm1ldF9maWxlX2V4ZWN1dGVfcncoKS8NCm52bWV0X3Bhc3N0aHJ1X2V4
ZWN1dGVfY21kKCkgYXJlIGZ1bmN0aW9ucyB0byBzdGFydCB3aXRoLCB0aGVuIHlvdSBjYW4NCnNl
ZSBzdHJ1Y3RzIHN0YXJ0aW5nIHdpdGggbnZtZV8gcHJlZml4IChtYWlubHkgcmVsYXRlZCB0byBu
cyBhbmQgY3RybCkNCndoaWNoIGFyZSB3b3J0aCB0YWtpbmcgYSBsb29rIGFuZCB0aGVpciBiZW5l
Zml0cywgYnV0IGJlIGNhcmVmdWwgd2hhdA0KeW91IGFyZSBtb3ZpbmcgLi4uDQoNCk9oaCBhbmQg
bnZtZXRfcmVxIHRoYXQgaXMgYWxzbyAuLi4NCg0KLWNrDQoNCg0K
