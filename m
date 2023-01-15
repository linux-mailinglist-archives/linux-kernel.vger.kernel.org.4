Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D320B66B081
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAOLGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjAOLGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:06:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C554DA244
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 03:06:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfn9o2jdnuQOQ4Bj2qGUM/1CKkBXdwbMps2J/Z7AwZHNFMaVprVfjn3O74sEVOXqLl/oHwVn4tMCzVSqLEEtCe5lK0UHiVT5E3soma/70fLIn9+b6tk7PX6Xy4FGrJIuql0o+jlTtSflclge4cNMagHYkpdSyr7s0AbIehWUaBMUB1QSoUaUM+SARLIR0xLhO6bMRVSwGK7hTOmy8vRp/tS+sRhtjsCro9QwvTL4L3ftiAI/W+hXGWjvF8kVbOMLmEGydaw3o63cY4l5msJ+RTKLeSf6Lrx+BVWdn2JrvteF2oZMnXjuaFL+shbNnqATJxgNRu7y7+zxh1G10lV6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtLb6Px+Hx+9jVXMpnh4J/y2y554h1EtcBAThZTHx7U=;
 b=DR9sHZzj0tbveyQbaNt3SDAxFnQSUt9xDtND7wVrlTitPF3E+0+wDCxecOxY1yP4BMy1esUDWBWWpCCu6oJknk0JI3JkLBGEgb5wGUs1x/x+xIqXJWiTBwaHgfk1f5DFWRTXJSVCBJV1SWkJp/4fs5Vu8yZA+y9blEfUiS6nDdGPALo3WpnRhDgy38MGn074leCV3f9PiVVAaaeSsrfK+tT4RUTBy+aQgib0sM1TJ4SS7+NnWo0wkEZJcYG68Oj1LGWgdCOw271QwBCLKUmEL8lT7nqDk7siVXgQT+tKo65YPVgxL5XiI/OFk0n3jR82vN+4A5PPoAFRQ6XAekZoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtLb6Px+Hx+9jVXMpnh4J/y2y554h1EtcBAThZTHx7U=;
 b=Sn6FZAnSS++ug0BWfivPkv46LdNFoG0Ad8VM/vTgppUEWhkhWsoJXm6otJ4Lh3sfAqwIMYI+9UL314Mha2Y3SLMyJ/tckIsUDC7LpEWElpz6gxtJCd+k2zmaepU49X2amuxhLoeI44dPefEVJq9+BeUUW0DLUeZeKVQLiw/8z6OZ2PX6Rm04Szghmk4qVZGMUiwRmlvzMpLciJ2uVIvvtFMqkz+yCzDSADObukqumG4nommioH6LFUAPCbI0/J9ebU2HYaE4M6kBBjGNwCreRr0vcUXZyae+fh7ZphxSVnk4/OM5JpUCpSUvyrX32jE25vd1c+hFRjxichGWKOw10w==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Sun, 15 Jan 2023 11:06:30 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.023; Sun, 15 Jan 2023
 11:06:30 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Subject: RE: [PATCH 2/5] vdpa: introduce get_vq_dma_device()
Thread-Topic: [PATCH 2/5] vdpa: introduce get_vq_dma_device()
Thread-Index: AQHZJYXquePtWMGgkkSpyJ8Opc/oP66fV7tQ
Date:   Sun, 15 Jan 2023 11:06:30 +0000
Message-ID: <DM8PR12MB540083D857A5FEF984AC0C4CABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-3-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-3-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|CH0PR12MB5219:EE_
x-ms-office365-filtering-correlation-id: bc6a7bde-10c2-4660-2867-08daf6e88e31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 571x3rr+gCmS904RWqC/mV/Dt0HLZm97Wst8VKwkBS/3g6yC0kTKUibTdOsYkhgwryaF4CSZy2sd0AVi28ZSrVWrtwN2Uu92BL1b2qFXsKeyM01dFK64kqXH+A+r7bxs7LAYoQVmLQIeHem7n64em7j+co1Gqw/wNeXGr5UXHirqBWNQontPwcIV1XONJJ1C6iXbv5li2/nZ2PK7C4c0E99HfmlO9GF+hAWSz6SpC4l1mit6/xM4jod+Is8MvMzM/ckrECJKJEc5MoK1Ow+glitVQAYUk7Quv+FVOkeS0b8DYEO4w0FHnsTQ0/8T3WXRNSs4qbHRPzQY6dKxdC89jXz8TomfIXJJvCJIBojypITK0dzk7pM8B1hlNjYiUeJbYZj3wZC/67bKOn7dQYdnVgo1D+SksatqXuvOqdSXDCwNcCTkMcNWAoZtvb9eGLsDsxcWe5EQoFinkAtpEloksaVzTEtuNQCjiCYg8TyED2Qydtq4RCUZquCZNwWwWRvE4t05V5sB9iWxZbqTj5Mxlg93/v+d5QwnJKCIk6TGeCNFr7cfWczwuEEekx0/9rfXLAlYjeBV5oYJMyL+ULV2Ybd9tyGfG6LjalWoml+6x8BsIu4TKeVUBiz+y+VZ5/Qy9wMWHMQSyxoq1pI8f0bq/t6sm8tXtYWXP6Yx6vW8Hh9E2tNVexzibhZmgsdKYZ0VlBjZuQ7ku7fbU8FGVj1SHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(7696005)(71200400001)(33656002)(478600001)(4326008)(8676002)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(41300700001)(110136005)(54906003)(316002)(55016003)(38070700005)(38100700002)(122000001)(6506007)(53546011)(26005)(9686003)(186003)(83380400001)(86362001)(5660300002)(2906002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDJqL3N1UldiZ2FWcVROQ282ZWc1MTdEYXlZanVUZ0lHNTk2N0h6Q0xaWUli?=
 =?utf-8?B?L3lWWEZ0V3h6YjhVNk8zRWphaXdvSmlQT0Qxd3RSWSs3Ykx3RFB4aW1NSFI1?=
 =?utf-8?B?VlBnSGxTMWhObEhEYWlOeFo2b0dBYnV5S2t5TGZpNkRzcm5EL1BRRFdYd3Ev?=
 =?utf-8?B?OWhzdHlZUXVzTEFXbUV2UFROT0VYTkJoV0ZVNWhrbWNzZUU0R3hWeTZ6RFcv?=
 =?utf-8?B?cG1ZWGlldzRoZS93T0MzZXowcVhXUEpUK1R1RDdoallXNmJWV0FrWnJvNE5H?=
 =?utf-8?B?R3VINFdQYVl1S1F3VmNic3U1NUlIbWh5Z1JTUzFaTDI0clBWcWtKb2tUSEdL?=
 =?utf-8?B?R0xnOGhqK0JqbCtqb2hBTWl5RXo4N1pXZDNJSEE3M21aaklkK3ZGcDNOekpZ?=
 =?utf-8?B?VkpZV25UUEloU1lzTmMvOEsycng1VVhtcmVuLy9Edno2ZnBuM20ySXI2MWlk?=
 =?utf-8?B?SXpZYTR0QVE1SE1XdHFWaWttbGc3ZkVRMVNzZWgrQ1ZScHdLVFJtdkRhL29Z?=
 =?utf-8?B?cDdpNWxBcTcwVEZ5dmRzUlFsUi8rQ0JJcWZvcFhZVUZ5c0h4WGdRc2c5MGh5?=
 =?utf-8?B?SWRvbGZ4U0VweEE5MjMyTUplZm0xdnhMZHM4N2lyYnk4dEQ1VnpabkxUb1lR?=
 =?utf-8?B?T2xhOERFVDhnc2dRYmlwN213dFhENDhUOWNycjlwNjJnTEhrOVhvZ3crWVVp?=
 =?utf-8?B?OS8wa3V5TWlyVnJWcytrcXJPbGFVZVd2T1pDTmZUZzE5Ti83OXk2YlVDTWZZ?=
 =?utf-8?B?emF1QkFRVzhXNmFGK0pGU2loMG9yRW9hRXJvb2ZXN0l0WDR3VWltM2ZyRWJY?=
 =?utf-8?B?U0s3dUJTWi8zeEFqQ3VoY3BBcDV3VC9mei9aOGVhekwranlsUTJhamJSV1Z0?=
 =?utf-8?B?dHljRUVNTURHdW5oNktuNVZNcEplVjN2MXNrMktlek1VQjBJV1RFaHJ3cXN6?=
 =?utf-8?B?S0U5TmtaS2tMMHQxell5Y0JiTFZudFFMMUsyTVl5aHFBMzA4aWZIVHJVUUdT?=
 =?utf-8?B?Z3k4VmduQnZQNURqdlRZdTFQS3lxNFBSRGJkN3VLMWlGUXRUY1dqR3IxZ0Mv?=
 =?utf-8?B?V1d4OCtsdDhDRHllU244Ui8zRGFYaWpzemM1aWdsTDE1SFhnbGlJL3I5eE1G?=
 =?utf-8?B?eVVJMitBMFY0UzFJTGxObDRqYzF2czZ6MHcybUlCMVdQeEQvWUM0L3p6MDFW?=
 =?utf-8?B?Y0hkdURtaFU0bng3eXJOZDlMS2JFUE5JVkpSeVppTGhYblNPK3oxSGVGZ1p6?=
 =?utf-8?B?YnhCdUE0RFIvK2cyR09QQy91eXpiWnpvR2wvaGptQ0ExK0RRTUt5YURUVzVu?=
 =?utf-8?B?cWRvZUVJWXR0TGE3THQrRDhHeStzVWVCaVBiUlVKVldRRVZKMnV3d05aUjBF?=
 =?utf-8?B?ckRrc3F0M25jTmMwMGZ1Ni9yZFgxOWpVQUZNam9zQjJURHI4TTAzUUNYckpw?=
 =?utf-8?B?U3hqZGdidWw4K0tWVzV4Q1VsbHVOYllMQTFuS1lVR0JJa3RvOUtQcFRqSEpq?=
 =?utf-8?B?U3dVZ0JOeityTEJTQ0MrRUJnYS9LSk9yeTNQekp5QXpuZ2lFc0IzQ3A4dC9l?=
 =?utf-8?B?QWtUNmZRLzdlN1ZpYXJNdVAyMnVqaXhjaTh4RC96REw1T3daQndtQ21VZnBN?=
 =?utf-8?B?SHMwREU3cGZYZHBzZ2o3RnVzK0FLQkxRRVFBYVRBZER0ak1kUmRrZEVUUVJr?=
 =?utf-8?B?RVZXMUsxQUFMemtLM0o4dUp3Yko1WjN3ZGlwZU5Rd3RYNWdBNnBHZFlaT0tX?=
 =?utf-8?B?UlVGTlpwSDhFNlRYd3RpZlRjOWp0OXlsd2o0SVo4eG1RMVdhZm12SlU0c1pp?=
 =?utf-8?B?TElUaGRiNk4xdk8xaG5kb29lSTB2Q0NYYmVLeFkyeDcrMkIreDkrL1kxVnNZ?=
 =?utf-8?B?cHhsSGJ4OGMvYk93YnErU2ZmaFNYSFM2U3lGdGltZG1Hcm12QjQrdHBRU2Jh?=
 =?utf-8?B?TVpxN0RjZXBMekt6WmpyMTFZTHlXK0YyZ2gySnVZek1KUllCVjVtSFZTc0No?=
 =?utf-8?B?T2J2aUhEU1A0OHhLdDREWW9PRzA2SlBOTWpPTzk3TEJmMGs5TFFhcnRBcTQ0?=
 =?utf-8?B?S0xWSyt0c1FuWVlGZktFek40blYvdHFJNU1id3NTTS83TjdtbUIrSjJDRlNs?=
 =?utf-8?Q?0k+8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6a7bde-10c2-4660-2867-08daf6e88e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2023 11:06:30.4153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0pDo8i9IAVfUAlZg7Qmh3orJEZ9UOBwJXJUaeRzwDLusa6Llxr+2g1XzUbWm+YR
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
dDogW1BBVENIIDIvNV0gdmRwYTogaW50cm9kdWNlIGdldF92cV9kbWFfZGV2aWNlKCkNCj4gDQo+
IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIG5ldyBtZXRob2QgdG8gcXVlcnkgdGhlIGRtYSBkZXZp
Y2UgdGhhdCBpcyB1c2UNCj4gZm9yIGEgc3BlY2lmaWMgdmlydHF1ZXVlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NClJldmlld2VkLWJ5OiBF
bGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NClRlc3RlZC1ieTogPGVsaWNAbnZpZGlhLmNvbT4N
Cj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92
ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaA0KPiBpbmRleCA2ZDBmNWU0ZTgyYzIuLjNlYzEz
YWVlMzVmNSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgNCj4gKysrIGIvaW5j
bHVkZS9saW51eC92ZHBhLmgNCj4gQEAgLTI4Miw2ICsyODIsMTEgQEAgc3RydWN0IHZkcGFfbWFw
X2ZpbGUgew0KPiAgICoJCQkJQGlvdmE6IGlvdmEgdG8gYmUgdW5tYXBwZWQNCj4gICAqCQkJCUBz
aXplOiBzaXplIG9mIHRoZSBhcmVhDQo+ICAgKgkJCQlSZXR1cm5zIGludGVnZXI6IHN1Y2Nlc3Mg
KDApIG9yIGVycm9yICg8IDApDQo+ICsgKiBAZ2V0X3ZxX2RtYV9kZXY6CQlHZXQgdGhlIGRtYSBk
ZXZpY2UgZm9yIGEgc3BlY2lmaWMNCj4gKyAqCQkJCXZpcnRxdWV1ZSAob3B0aW9uYWwpDQo+ICsg
KgkJCQlAdmRldjogdmRwYSBkZXZpY2UNCj4gKyAqCQkJCUBpZHg6IHZpcnRxdWV1ZSBpbmRleA0K
PiArICoJCQkJUmV0dXJucyBwb2ludGVyIHRvIHN0cnVjdHVyZSBkZXZpY2Ugb3IgZXJyb3INCj4g
KE5VTEwpDQo+ICAgKiBAZnJlZToJCQlGcmVlIHJlc291cmNlcyB0aGF0IGJlbG9uZ3MgdG8gdkRQ
QQ0KPiAob3B0aW9uYWwpDQo+ICAgKgkJCQlAdmRldjogdmRwYSBkZXZpY2UNCj4gICAqLw0KPiBA
QCAtMzQxLDYgKzM0Niw3IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgew0KPiAgCQkJIHU2NCBp
b3ZhLCB1NjQgc2l6ZSk7DQo+ICAJaW50ICgqc2V0X2dyb3VwX2FzaWQpKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdW5zaWduZWQgaW50IGdyb3VwLA0KPiAgCQkJICAgICAgdW5zaWduZWQgaW50
IGFzaWQpOw0KPiArCXN0cnVjdCBkZXZpY2UgKigqZ2V0X3ZxX2RtYV9kZXYpKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldiwgdTE2IGlkeCk7DQo+IA0KPiAgCS8qIEZyZWUgZGV2aWNlIHJlc291cmNl
cyAqLw0KPiAgCXZvaWQgKCpmcmVlKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOw0KPiAtLQ0K
PiAyLjI1LjENCg0K
