Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8066B7B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjAPHDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjAPHDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:03:44 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355217ED7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:03:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSS4OG+stPmoGy6kfeC2PGGvoiUeHvq/3MjNLPKBLOLPYSsHwlJpNg9fPY/n54jeCaeTtz8zbTAg1ZX2BQCINfOA3w2h8Y6WD8Fhrdlq4JUC+pfoUaMmYNeStcyY9PTzaOHwRZk4/21chb6n/beOEyBCeXXf5T3hoMQrBagbIiJU79svje65ScNHokLkA184+RKsItyrE7QyqumYsDnbryaAFlmq7cTmoFL+RfnfgacH5YmVNY4ahJKu6BakQv9anXO6hsSClopGpISzLFxvYXGEQgjqjDteBKJbLLwoaiRDBoN24D9i7NcNq4k+kaGHiQaN5y33VYMPcc3wGRucBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKmfj/ObKP39F/atXZijbLiXHgfYkpmPCJh2wUCkDp8=;
 b=D09BEDgeJkmA9ex51ltFkgw+M/ibKfUiiEGtfB4ZWumKyKj7KzIPLgosW3HPPwkUrV0pGJbLiBjgqFoxEGqdjI1v8pDN8kzBLbkgY+Q2V3T1JrntNYapNfHHpxJo9Ij4UjAHDKeqicbFxZiX3O6yLHWLdaIpv/k3yXIlTwbZAijuB1rEPhoBwH8re7YQZ1B5BDyZtIZKe/+sbv73LNJ2z3jD41UvTfm6yR9Ag/on20bofKNozS5SErtQkdPrra8QtzSs6A9XeN3h5cmi0vHKsiOwRzj2DN0PigMo9E0FT25Vh5pmTpr1KX3g1IcBwfYCPAXRnP4r5q73mFCHJa7odA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKmfj/ObKP39F/atXZijbLiXHgfYkpmPCJh2wUCkDp8=;
 b=fln0+3N3IeV3Hkb8pN47d8hdAFn2t6Rbm+Lm81jM2DI/xu/DCKLj1u/V9q2biwGN/9MoOI4NLITpKeMT1Nx8mLRxQJmf3koKXmSQWl5+tuRt+9nY7qsOt5ibRDrmXWFXKUgWlS6T3/84Hb82Glb1ySU97I8kQs/6y8MiEOPtFj4HBRM9/AQgoA9nh2KdeMsIfXeeHgD7lINz/GJ5W4sgEUnb9EgfAfq3mNXolVKgx+MjlpwjLXfHx9ZR5ca9SQoiohXZoc6APkMKUiGLHP/CXUcKglkKKl0ByyLuDsJID1axQYXCEHVZ6mgMzjxLOqcxfdgFG6zD6sl5XPJAO55mew==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Mon, 16 Jan 2023 07:03:41 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 07:03:41 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
Subject: RE: [RFC 2/3] vdpa/mlx5: conditionally delete cvq iotlb in destroy_mr
Thread-Topic: [RFC 2/3] vdpa/mlx5: conditionally delete cvq iotlb in
 destroy_mr
Thread-Index: AQHZJpFNg7uii2wtYkG6+9IIMARJcK6gox6w
Date:   Mon, 16 Jan 2023 07:03:41 +0000
Message-ID: <DM8PR12MB5400B2FF15EA6DB00AB840EBABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230112142218.725622-1-eperezma@redhat.com>
 <20230112142218.725622-3-eperezma@redhat.com>
In-Reply-To: <20230112142218.725622-3-eperezma@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|DM4PR12MB6423:EE_
x-ms-office365-filtering-correlation-id: 7db3c457-5d1e-4e49-0579-08daf78fcc9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U8YQMDwhTGfXT3IBbjtRuD7+yXFUZlXbZZt2F+PvxoncTw1jHbrxtsNd659ZLpM5FlYsE6CeWftTivWSYc2C/sP71IbLQXu+1fEZPHElecfEYifjEp8205S/aJTPLALnVkvSyS+JjIo/LYezyXWVKpXKEyxmtbYG4xLpW1065WKRFLUyW0Ew+eCWm5W/QuVy/nuruFaDYIfOuju4ku9d3Cg5Hs5wa4HGi8XCDhtye7kXBffpvkv7top7g5ov7DgI7TLmDHDq0tb5vLpX8hnN8XJCpFc65+V87Zi3g+GRF7Lo5mYQTmdVEdN3ELBDC60+lX7snP5PzG8T1qPJ1dTRbbougcBIT1h/cWP5VaAHKeehsIbyrvApIe4eXauv+67vch4hH+4XA+IfWKY+A2ignx+rKEa2NVXSPRz507lVF7UqGnRruk1Jyasf6pcPeYMLr3FGfNyIG4+gfmt1cVLbU6MKjvBj6xFG5puwLWx5HfMXXIrJYkrYMkikHIEgRqiaogP+vasW59zEekiZ0DqdCOzr7a7GRqlPnf9/H4tMFGNs1xoLXNKMmMGg+nf+wYTnrwC9+jisTZZqbc1tpSlsuiur+3nqKDxroFxxQPaA7LRBpl/1Xv4sDmI0K5VMlwZdykP+DdTd5jWLoFio2x/P/R9LP2V+yr1+ypttMYh+pDDYnXLBe97YZt4FZEBW9+eYruBywX1wVrUx66/47mZXCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(86362001)(33656002)(26005)(9686003)(186003)(4326008)(8676002)(64756008)(53546011)(66446008)(76116006)(66556008)(66946007)(41300700001)(66476007)(66574015)(6506007)(316002)(71200400001)(7696005)(54906003)(110136005)(478600001)(122000001)(38100700002)(38070700005)(2906002)(52536014)(83380400001)(5660300002)(8936002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmV1NkRiU1lRSDMwZVF0VW1JWFlBbzZPOUVkd00zZXBwUGdKYlB1OHRVU3dO?=
 =?utf-8?B?eFE2aUxPOXNXM3NqWXV5K1hKZXhaRlRmSmRpY1VKUTBTUXg2ZlFnQlhKbjI3?=
 =?utf-8?B?MWZzcHV0eUxPMVRBTGViNGx5NUtTSWxjZ0RweUp5VDNreHJUU1JxNyszQis1?=
 =?utf-8?B?OUpqOGYrbDhpQ002a3JwdkhtdFhxUlFhYXp6Y1ZoZGlkTDhIRTlMdXNmUWxP?=
 =?utf-8?B?ZC9RTzNkdE0rSXZCVEhRS0RRWTcwZkljTXh1dk5Qa1UzNHBNK0NlU0RicVpC?=
 =?utf-8?B?VzlYYlBwZS9pRGJtTjhQWHpkSFdEU3hONkYxSEhsd3U4d3NFbGdodUl6WEJQ?=
 =?utf-8?B?Z1IxOFBXTTlpOC9WSUlRTFV3a2JRYlFOR0ZQMGpPSFQvdE5IL21IcXAwRElT?=
 =?utf-8?B?NnhkcUtzN2s1Z3RJQ0lrbGVzZ0dTQTMzdW5QUVl1UlQwS204dVludEcra2RF?=
 =?utf-8?B?QWkza01WaGdiVFNPakdNRzF1YUQrakk3bFNQdk10VGZjL2dWcEsrZE84bjVu?=
 =?utf-8?B?U0dwUGcxdjY5RTN5WVJ0bzI0bTZOTmdKeEVwQ2JJdXNwWjIyd042Q2ZIOG9M?=
 =?utf-8?B?Si9JYlRjMGFWZER1MFY3QWRGeW9YVVhXQWl6RUh5WEdDZGhxTC9VWlFveUt1?=
 =?utf-8?B?Y3lPMEMyUTZzVWcxb3hoUmVoaFZSaVU4NThXMTJoZzNZVVpiRFBwQ3N3TmIv?=
 =?utf-8?B?ZjRHc25DNUsvbmZLdWZtUFJNT09BRUpLa3lxWk1iVG1CTHhsRDJ5M1dqTXB1?=
 =?utf-8?B?eW9aM3F3MkdGRUdsNmhlRVRScURsdHM5ME5laExKTFVPMjZTWTdnNXA2S0o5?=
 =?utf-8?B?S1dsUWdQUGl5SGErRVNxVmhjMFpkR3U5ZDc2NXJYd1dLOXNQNVppUlB0SWlE?=
 =?utf-8?B?N2Y2NmhwaStoMTRzcy9RTy9HM1duMEorTmwxL0R6TkZERjdGaW5ZSlNKL0lZ?=
 =?utf-8?B?SUNlaVM0YkF0UTgxRFd4aEcyaGVOVFZNUSsvNFVTY0V4bDhNQnZnQ0Jua05I?=
 =?utf-8?B?R2toTktsbG10WkpqOWJ3b2hRaWNqWWppcnNBZ0M0dFRWekdpcjlCbnBNT1hr?=
 =?utf-8?B?WjdwbDdReEhJZEkwUWdUQlVOV0gvQUZSSWMzWERtYXRESmg4ZEpOVE9kVWRM?=
 =?utf-8?B?R2w1ZkVTSy8zcVJQTTY4T0ZmK1RUakV3TElybFdkNG1zRFNQR1pPYW5sUzFn?=
 =?utf-8?B?a3lsTERpdXJCd2VuUUQrVXcvL1ZFeDBLbzN4WmZmNVk5MVdITDRBSmJDTG1L?=
 =?utf-8?B?QkJMUjhzTEdNTTIxZys3M3pSRFVzSEdhbklwU0tiSlY1TDloRVo5a01DWHBM?=
 =?utf-8?B?dzlnenFjSlYxeWhuektkZmpjeFA0RmpndkJlMTEzMDdzWkd5STdheTA2M3Nh?=
 =?utf-8?B?eXdNb0l4MUx2MWhVcVMzaUZqVXJPQVZSYVMzOEozVEVzaUh3NFVtR2FNZFF5?=
 =?utf-8?B?eHBnVDhGaGZwdHlVNXNPY0t3RmtTL3FlQXRwYW45VE8yWDhIclVQNk5yOGhi?=
 =?utf-8?B?bEdCZVlZanIxZEpkLzI2NGpNTFo3cEMxbWJaeXI3UktuRjNpWFEzTzQ4M2dB?=
 =?utf-8?B?d2Z0c2pON3NNSmlzYWtndEtQNkpKeXZuUFQrQWlodjlNS3Fod3cwVWl4d1dS?=
 =?utf-8?B?M2R2N1lJM1Vwb3lMbmNCRXN2aE14amNtOGRoUENLOVRDOE9JL05ZOFFGalQx?=
 =?utf-8?B?a3FrUjRaOXBxemRvdWhGYmJ5K1lDSTRXcnhFLzFJYWNJY3ZBeTdUWHY5ZE1M?=
 =?utf-8?B?RGtjdUkvVHZ6WlBuejh4c2hyZDU3RkhGaEEzVkFTZkZUc2RJeHpxZ01Fampj?=
 =?utf-8?B?LzdrRkkwN0J0eFFPTkNhTGptZlQydmJIbEJmN2lTc3JsSjRRZWlhN0NVb2pQ?=
 =?utf-8?B?ZkhsMmMzNHB2RGwzb3hoT3h1eDNoRlpFRmZQaWRUQnpTd01VODBJOG4xT1JN?=
 =?utf-8?B?c1dpVk5GTGUwYWdkbXI5eUJLSS9FejNieE5NS2RlRzE3eHY0NXdJdFM3SkZ1?=
 =?utf-8?B?bHVLcjBwazE4UjlKVmp2dlVWaWpseTMzT0ZrUUd1ODZMYUNuNDFGYUFXMGtQ?=
 =?utf-8?B?Ri9wN1VLLzF0UXAzUkJXeDA1UGEvb2M2OEdENkRmamJXd2hlLzZaVGZzQTNK?=
 =?utf-8?Q?8aLE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db3c457-5d1e-4e49-0579-08daf78fcc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 07:03:41.1220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NXQG4hQHp7cLiAWKLkStG606xjqAynRExl+Quef3aGMr4H1wy8GA1yo6nRpY/s1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIDEyIEphbnVhcnkgMjAyMyAxNjoyMg0KPiBUbzogbXN0QHJlZGhhdC5jb207IEVsaSBD
b2hlbiA8ZWxpY0BudmlkaWEuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPjsNCj4gbHVsdUByZWRoYXQuY29tOyBq
YXNvd2FuZ0ByZWRoYXQuY29tOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC0NCj4gZm91bmRh
dGlvbi5vcmc7IHNnYXJ6YXJlQHJlZGhhdC5jb207IHNpLXdlaS5saXVAb3JhY2xlLmNvbQ0KPiBT
dWJqZWN0OiBbUkZDIDIvM10gdmRwYS9tbHg1OiBjb25kaXRpb25hbGx5IGRlbGV0ZSBjdnEgaW90
bGIgaW4gZGVzdHJveV9tcg0KPiANCj4gbWx4NV92ZHBhX2Rlc3Ryb3lfbXIgY2FuIGJlIGNhbGxl
ZCBieSBzZXR0aW5nIGEgbWFwIHRvIGRhdGEgQVNJRCBhZnRlcg0KPiBwb3B1bGF0aW5nIGNvbnRy
b2wgdmlydHF1ZXVlIEFTSUQgaW90bGIuICBDb250cm9sIHZxIGlvdGxiIG11c3Qgbm90IGJlDQo+
IGNsZWFyZWQsIHNpbmNlIGl0IHdpbGwgbm90IGJlIHBvcHVsYXRlZCBhZ2Fpbi4NCj4gDQo+IEFk
ZGluZyBhIGNvbmRpdGlvbmFsIGluIHRoZSBmdW5jdGlvbiBzbyB0aGUgY2FsbGVyIHNwZWNpZmll
cyBpZiBpdCBpcw0KPiByZXNldHRpbmcsIGNsZWFuaW5nLCBvciBqdXN0IGNoYW5naW5nIGRhdGEg
bWVtb3J5Lg0KPiANCj4gRml4ZXM6IDhmY2QyMGMzMDcwNCAoInZkcGEvbWx4NTogU3VwcG9ydCBk
aWZmZXJlbnQgYWRkcmVzcyBzcGFjZXMgZm9yDQo+IGNvbnRyb2wgYW5kIGRhdGEiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIHwgIDIgKy0NCj4gIGRyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbXIuYyAgICAgICAgfCAgNSArKystLQ0KPiAgZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jICB8IDEyICsrKysrKy0tLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgNCj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL21seDVfdmRwYS5oDQo+IGluZGV4IDA1OGZiZTI4MTA3ZS4uMDAwYjE0NDAxOWVjIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oDQo+ICsrKyBiL2Ry
aXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgNCj4gQEAgLTExOSw3ICsxMTksNyBAQCBp
bnQgbWx4NV92ZHBhX2hhbmRsZV9zZXRfbWFwKHN0cnVjdA0KPiBtbHg1X3ZkcGFfZGV2ICptdmRl
diwgc3RydWN0IHZob3N0X2lvdGxiICppbw0KPiAgCQkJICAgICBib29sICpjaGFuZ2VfbWFwLCB1
bnNpZ25lZCBpbnQgYXNpZCk7DQo+ICBpbnQgbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4
NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYg0KPiAqaW90bGIsDQo+ICAJCQl1
bnNpZ25lZCBpbnQgYXNpZCk7DQo+IC12b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBt
bHg1X3ZkcGFfZGV2ICptdmRldik7DQo+ICt2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgYm9vbA0KPiBkZWxldGVfY3ZxX2lvdGxiKTsNCj4gDQo+
ICAjZGVmaW5lIG1seDVfdmRwYV93YXJuKF9fZGV2LCBmb3JtYXQsIC4uLikNCj4gXA0KPiAgCWRl
dl93YXJuKChfX2RldiktPm1kZXYtPmRldmljZSwgIiVzOiVkOihwaWQgJWQpIHdhcm5pbmc6ICIN
Cj4gZm9ybWF0LCBfX2Z1bmNfXywgX19MSU5FX18sICAgICBcDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMNCj4g
aW5kZXggYWUzNGRjYWM5YTNmLi44NzhlZTk0ZWZhNzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbXIuYw0KPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMN
Cj4gQEAgLTQ5MSw3ICs0OTEsNyBAQCBzdGF0aWMgdm9pZCBkZXN0cm95X3VzZXJfbXIoc3RydWN0
IG1seDVfdmRwYV9kZXYNCj4gKm12ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX21yICptcg0KPiAgCX0N
Cj4gIH0NCj4gDQo+IC12b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFf
ZGV2ICptdmRldikNCj4gK3ZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2LCBib29sDQo+IGRlbGV0ZV9jdnFfaW90bGIpDQo+ICB7DQo+ICAJc3RydWN0
IG1seDVfdmRwYV9tciAqbXIgPSAmbXZkZXYtPm1yOw0KPiANCj4gQEAgLTQ5OSw3ICs0OTksOCBA
QCB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2DQo+ICptdmRl
dikNCj4gIAlpZiAoIW1yLT5pbml0aWFsaXplZCkNCj4gIAkJZ290byBvdXQ7DQo+IA0KPiAtCXBy
dW5lX2lvdGxiKG12ZGV2KTsNCj4gKwlpZiAoZGVsZXRlX2N2cV9pb3RsYikNCj4gKwkJcHJ1bmVf
aW90bGIobXZkZXYpOw0KPiAgCWlmIChtci0+dXNlcl9tcikNCj4gIAkJZGVzdHJveV91c2VyX21y
KG12ZGV2LCBtcik7DQo+ICAJZWxzZQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jDQo+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+
IGluZGV4IDY2MzI2NTFiMWU1NC4uMWYxZjM0MWY2MDJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jDQo+IEBAIC0yNDMzLDcgKzI0MzMsNyBAQCBzdGF0aWMgaW50IG1seDVfdmRw
YV9jaGFuZ2VfbWFwKHN0cnVjdA0KPiBtbHg1X3ZkcGFfZGV2ICptdmRldiwNCj4gIAkJZ290byBl
cnJfbXI7DQo+IA0KPiAgCXRlYXJkb3duX2RyaXZlcihuZGV2KTsNCj4gLQltbHg1X3ZkcGFfZGVz
dHJveV9tcihtdmRldik7DQo+ICsJbWx4NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYsIG12ZGV2LQ0K
PiA+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfQ1ZRX0dST1VQXSA9PSBhc2lkKTsNCg0KTG9va3MgdG8g
bWUgd2UgbmVlZCB0byBoYW5kbGUgdGhpcyBpbiBhIG1vcmUgZ2VuZXJpYyBtYW5uZXIuIFRoZSBh
c2lkIHNob3VsZCBiZSB1c2VkIGNvbmRpdGlvbmFsbHkgZm9yIGVpdGhlciBDVlEgb3IgZGF0YSBW
USB1cGRhdGVzLiBZb3UgYXJlIHByb3RlY3RpbmcgQ1ZRIGJ1dCBzYW1lIHRoaW5nIHNob3VsZCBo
b2xkIGFsc28gZm9yIGRhdGEgVlFzIGlvdGxiLiBNZWFuaW5nLCBpZiBxZW11IHdhbnRzIHRvIHVw
ZGF0ZSBvbmx5IENWUSB0aGFuIGRhdGEgVlEgdHJhbnNsYXRpb24gbXVzdCBub3QgYmUgYWZmZWN0
ZWQuDQoNCj4gIAllcnIgPSBtbHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCBpb3RsYiwgYXNpZCk7
DQo+ICAJaWYgKGVycikNCj4gIAkJZ290byBlcnJfbXI7DQo+IEBAIC0yNDQ5LDcgKzI0NDksNyBA
QCBzdGF0aWMgaW50IG1seDVfdmRwYV9jaGFuZ2VfbWFwKHN0cnVjdA0KPiBtbHg1X3ZkcGFfZGV2
ICptdmRldiwNCj4gIAlyZXR1cm4gMDsNCj4gDQo+ICBlcnJfc2V0dXA6DQo+IC0JbWx4NV92ZHBh
X2Rlc3Ryb3lfbXIobXZkZXYpOw0KPiArCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2LCBtdmRl
di0NCj4gPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0gPT0gYXNpZCk7DQo+ICBlcnJf
bXI6DQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gQEAgLTI1NzgsNyArMjU3OCw3IEBAIHN0YXRp
YyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdA0KPiB2ZHBhX2RldmljZSAqdmRldiwg
dTggc3RhdHVzKQ0KPiAgCXJldHVybjsNCj4gDQo+ICBlcnJfc2V0dXA6DQo+IC0JbWx4NV92ZHBh
X2Rlc3Ryb3lfbXIoJm5kZXYtPm12ZGV2KTsNCj4gKwltbHg1X3ZkcGFfZGVzdHJveV9tcigmbmRl
di0+bXZkZXYsIHRydWUpOw0KPiAgCW5kZXYtPm12ZGV2LnN0YXR1cyB8PSBWSVJUSU9fQ09ORklH
X1NfRkFJTEVEOw0KPiAgZXJyX2NsZWFyOg0KPiAgCXVwX3dyaXRlKCZuZGV2LT5yZXNsb2NrKTsN
Cj4gQEAgLTI2MDQsNyArMjYwNCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3Jlc2V0KHN0cnVj
dCB2ZHBhX2RldmljZQ0KPiAqdmRldikNCj4gIAlkb3duX3dyaXRlKCZuZGV2LT5yZXNsb2NrKTsN
Cj4gIAl0ZWFyZG93bl9kcml2ZXIobmRldik7DQo+ICAJY2xlYXJfdnFzX3JlYWR5KG5kZXYpOw0K
PiAtCW1seDVfdmRwYV9kZXN0cm95X21yKCZuZGV2LT5tdmRldik7DQo+ICsJbWx4NV92ZHBhX2Rl
c3Ryb3lfbXIoJm5kZXYtPm12ZGV2LCB0cnVlKTsNCj4gIAluZGV2LT5tdmRldi5zdGF0dXMgPSAw
Ow0KPiAgCW5kZXYtPmN1cl9udW1fdnFzID0gMDsNCj4gIAluZGV2LT5tdmRldi5jdnEucmVjZWl2
ZWRfZGVzYyA9IDA7DQo+IEBAIC0yNjkxLDcgKzI2OTEsNyBAQCBzdGF0aWMgdm9pZCBtbHg1X3Zk
cGFfZnJlZShzdHJ1Y3QgdmRwYV9kZXZpY2UNCj4gKnZkZXYpDQo+ICAJbmRldiA9IHRvX21seDVf
dmRwYV9uZGV2KG12ZGV2KTsNCj4gDQo+ICAJZnJlZV9yZXNvdXJjZXMobmRldik7DQo+IC0JbWx4
NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYpOw0KPiArCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2
LCB0cnVlKTsNCj4gIAlpZiAoIWlzX3plcm9fZXRoZXJfYWRkcihuZGV2LT5jb25maWcubWFjKSkg
ew0KPiAgCQlwZm1kZXYgPSBwY2lfZ2V0X2RydmRhdGEocGNpX3BoeXNmbihtdmRldi0+bWRldi0+
cGRldikpOw0KPiAgCQltbHg1X21wZnNfZGVsX21hYyhwZm1kZXYsIG5kZXYtPmNvbmZpZy5tYWMp
Ow0KPiBAQCAtMzIxNCw3ICszMjE0LDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfZGV2X2FkZChz
dHJ1Y3QNCj4gdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KPiAgZXJy
X3JlczI6DQo+ICAJZnJlZV9yZXNvdXJjZXMobmRldik7DQo+ICBlcnJfbXI6DQo+IC0JbWx4NV92
ZHBhX2Rlc3Ryb3lfbXIobXZkZXYpOw0KPiArCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2LCB0
cnVlKTsNCj4gIGVycl9yZXM6DQo+ICAJbWx4NV92ZHBhX2ZyZWVfcmVzb3VyY2VzKCZuZGV2LT5t
dmRldik7DQo+ICBlcnJfbXBmczoNCj4gLS0NCj4gMi4zMS4xDQoNCg==
