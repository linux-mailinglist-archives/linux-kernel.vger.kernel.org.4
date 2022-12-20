Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366B565293A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiLTW5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiLTW46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:56:58 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35289167FB;
        Tue, 20 Dec 2022 14:56:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MynJ7z8jZRxst8cnRPiXAeqrMugVW2fazJCCU7MiNZdM9ZUjY+CwxEWjVO5V9REyuOusckp3pCdYXohEePLJkVGXo/Po7gtwGpYyCIasxW2WAir4ySY5FBA78CXGQDFoE1WM9BauOWW3XFxIU+0u9KbZQKPBUQ85yxIs4nFiFm46e/s22ss69O1IjHSN+GLO4T1Hj5tPG0I4BbZRQuw9b3Jn8bx3UShOUSiJHv5IFz5jQjU+AFELCoTUte+dUHVID44QNmXFqmBz138PUoAJF7S9CZsj9pOfj5+Wx750X0YgqEoNnibsh/EgyCigJvi96YH/x7ZlvCN0OfGZTiaLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwDofnsD8XLueTyQNM3S6VqT+uI1zUY0IAcC4JNcmrI=;
 b=kHqhW8+39LZXS4MaJUKybv4c5GjadSjo17CCGqM3bNR6s7z0GGn2UZq9mRqv9B/aJgcgzdb6wSiuk0qFfOSyBc0q3LSYoKlzRohYCc6ly+H+wX2tdqdLmBWZE5ILHUC9kanRrOV5fiMxApjmTjGyQ3VYQopWUd7vhEf4+3m8vxSPEqUt9MdpVH0kVoFF6fciu/EqSO/CYQs1vYsFAr/OdJW0dg7IyrEUvEsZzLqhmtCoFsyDBTBgYhr+ICxIf2VwzwHvUdl2d+xmVzItcpvQdSvFV8tLcicmr/qXLeIkUeCwWCSQpD52GjRGoPyL3eI2X6Lo590YJOdFGf+/dLJj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwDofnsD8XLueTyQNM3S6VqT+uI1zUY0IAcC4JNcmrI=;
 b=ITPgvOMIptY1y6XRPTMgKje3zbpj0XxEDNAfM4n/FFUlNCIUJSzrziQEPVGBaixyuYV9ckgvd4kVy5QbBvF6vkXggP5hluBiAayM95yQUP6ht374KwQgciwiNXhtcIxyOijv8t2vRrAe2jOp4FEkvI6VBTL7DbVm5FkCyHbQIABuLUsiAxCSalTe26itszqGzozWGUuK/gJRsDUOKkGSsjtvbYOKkiEIQmB5N3DUg0rSukPWQ3vehpTvWPVhMutg17aY7YoGgNYHEcX1QXVIq6RpPQJQCkE3/unK3DmqrCvKA1B6eKXq9pnddjp8FP4/kWVqTWAO3ltuBPBIXMN8mA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 22:56:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 22:56:55 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio_blk: temporary variable type tweak
Thread-Topic: [PATCH] virtio_blk: temporary variable type tweak
Thread-Index: AQHZFHB7But3Rk/qfUGrs/4yu894La53Y9WA
Date:   Tue, 20 Dec 2022 22:56:55 +0000
Message-ID: <8fb7c0ac-a51d-7d7f-a6e5-791923b6f95a@nvidia.com>
References: <20221220124152.523531-1-mst@redhat.com>
In-Reply-To: <20221220124152.523531-1-mst@redhat.com>
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
x-ms-office365-filtering-correlation-id: 0627debe-0d65-428f-2ab5-08dae2dd7e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6P9wwo/puO+QN1vDRTGkpUowifRh9C+G5hAzMg+tpKXwOziUDop2UGP0wL+TXUOxOJ9+NN2uR8yx7X6ibdgzKhaCH59SfI87vke6n9eUnaRWWZ4pbvTSgsbNq4IZdy5uWz0TOOI8lfF5rdNyiIsoIedPXh2gvVNiHMpYOmN6QHRycrawCgBgYwTEYE/P+s84/dRgfhb/mcPysCKRUocq8WyN0DRgS2tCfGB6oRGVssoaMWXt2RXMfnUZnJri24hiTUeYXCMeuZ8OXh3+S4n2TtR04hWcN4c15f9PBisXtrzCo+eOkKhaYSavr0ORvBv2wHRP5bKovtECZa1Vit2JOQ6cbnPZb2x+qoRr9GdUbHSCQCvaK1y9g5QRyxW2UyDnggSVoq5j+QtUIPGgy/qitaShuO2ne2/LT3AxkHXB0xHutCZBY6pvjD22oLzy2xigeOvvFIOoxPgMzA1+rLHC/Qsqzndy6g5Aime0kOP1HyxSBcd6s2KzNTc96iYPxvAgImPn0F5l8o5Sw1N8ejfSJdFf6MukSIzrxEuOlvdSdNnSr5q0Jrmye6vf40EeaifFAjsO83l0pj1g99IqNmOigHnIeU4eqzaqvIMxhD8+FToGcmgjgrdmDeHv8G+SC+bkRjuG97m4z1/Y87qEvXg4Wyyz3Exb5RMHMtCxzCSr8S6m5K0BoHsOyCcZCGgCWT1LONB3N6KdN4jqz+ImIjntZhnBRenIWbgBI/r0sfIbmpVyIiZf7vaHVFsOS79DhTTv8GFEtixz1H5EVlLNGtjOlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(4326008)(8936002)(478600001)(91956017)(66476007)(76116006)(66556008)(41300700001)(64756008)(110136005)(66946007)(36756003)(38100700002)(53546011)(122000001)(83380400001)(38070700005)(6486002)(86362001)(6512007)(316002)(8676002)(186003)(6506007)(66446008)(2616005)(71200400001)(31696002)(2906002)(31686004)(54906003)(5660300002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU40YU50Z0dBL0ZnaTRxVGV3aDRhL1daSXUyc3huSGNqSWVwUDA1cEttcG5M?=
 =?utf-8?B?RmR1VWEzVDArZ2Q0UFhLSnh0ZHhkVG16L3NrZFc2TlVtTHJJajZRRDMxcjVG?=
 =?utf-8?B?T1BlZUV6djlYT0xBYXJZODRUWHUvdWt6UEZTTlZwOHBIZVdKalNMaExOWlVy?=
 =?utf-8?B?dGh4ZXduUGNLN3JUekt0Z0ExeEtwQkt3dmRDWDZITklpWHJ0dGcwRVdocU5h?=
 =?utf-8?B?K29QZCtKTXpRejhyMjVVWmFuOWw5SmF4NkdNZW1rNzlIWWY0RjNob1ZZdlJT?=
 =?utf-8?B?Rjg3YUxnR2c5ZVh3RUpzbzFIZ2N4dkx0dHZuUUNpT1J4dldXcWZPdnRtS0NX?=
 =?utf-8?B?UEgvUS8rWTEwVFd3dW1kWjhVdjJuOHJwV0ovZTZ6TnhRY01LMmJ2SDJOa1R1?=
 =?utf-8?B?cjNlaVpVTGhRNzdUeUYrV0U4TFZxQXB5bElNTlovRmpkV3BZNDlaNTZnbzdw?=
 =?utf-8?B?bUJvMHlJeTBIUXhPZmRBUDlpTk5Ya2xRblNQUHdNMFJGMzVHajlFMU40bUpZ?=
 =?utf-8?B?Q3VNNnAvYzAweElIdXVFMjhERHNPRTJBRG8xWENKUEs3UDNiTTlwOVAwWlRu?=
 =?utf-8?B?Sk1WWkdEanViTnlCa2dzMTh1M2dYWUZYWE02UDRiRWE3Sk02eHhEcUoyY0Vz?=
 =?utf-8?B?QmRvRGVRck5VYlRWYjRRM2RheExlOTd4bUhyTVhiSHRtd1RjYVVKYi9nRS9R?=
 =?utf-8?B?WHIrR1hlMm1Jc2c1SU9YQkx1a0RIS05ueC92ZCt6Qy9LOEdvN0hSSUlSZWdu?=
 =?utf-8?B?ZllGb1ljSjlaeVJidklkSUlPOFpJaEYzbjlSQUY3M09PUkVJZGViY216MzVD?=
 =?utf-8?B?UkIxM05YSXh2djBST21oWUpYUjJVVnZtNXlsdlE3bW9VZUg2N3dmenlrV2RQ?=
 =?utf-8?B?eVdxS3ZPSlFsS011Z2d4USs5c0lKMTZvKzJZaDU0dGtLTFRBbm9DQ2NLY05x?=
 =?utf-8?B?by94Q1NtUDFkU0FQbmsxT1VoUDBqN3h4WE5iTGxRUnlrc2ZOZTlOSlIyMmdR?=
 =?utf-8?B?UStLSmhMd1FQbjhaVFluUVhKZlJXVmdVS0dsMmlvVG1kNG42QVhCRWxheTIv?=
 =?utf-8?B?cjZIWi9aVUZNbUxZZWpZaDByUDR4cTJNYTlYWlpQYzdBM1laSG5HTUpKWnVl?=
 =?utf-8?B?UUJMaERyN01uVDlGMC9ZYzBPNngzUjljM25aV2R2SVJxbjB6dEtiRDdZTG5x?=
 =?utf-8?B?b0JTMGMyQ292MDc5NUxTQUovWmVmaXhJVzVOemFoWC92V0ROS0s4VnUrb1BO?=
 =?utf-8?B?cnJVcWY0dUZGWUpuRENSbk1JQ3l1V1d3NHZma2IwQmRUbEhTVGEzRWN6YUF1?=
 =?utf-8?B?ZHlyT3FxK2dkUi9ESDZFcFdLL2tuVUk2a0hCWDI5WjRCQUxSaGM1RU80dXJJ?=
 =?utf-8?B?b2dLTFZMN1ExakptUExXOTJ3WUZhTzllWThySDdkMDZrZE9IbEgwa3B1Ky9T?=
 =?utf-8?B?UmdXL2x6UGNQNk9VUHUxNXNkc2k3cFdoYW5xUk5YUDdvR0ROc3RueEhqZy9I?=
 =?utf-8?B?R3F5c25kSjJsMkdwMG5vaU1wcnc4N3JkWWErL3dja2EreGZSc3k5L3BQRXBF?=
 =?utf-8?B?S3ljdHk5TlV6RmlOSWhYa1ZldFR0NTlPVnAxdktlZUNzaUNEcG14WVYxeE1C?=
 =?utf-8?B?OWh3RHhBZGhSTjVrdGlOTHBqRitIOGlEa09nWldyTy8yclhTWEZITWVjeHpI?=
 =?utf-8?B?OThtZE9wc2hGVGtGTjZ0Z252YmMveUN0dmtQcDJuazNINGJXbWhtdW5oLytq?=
 =?utf-8?B?Sk15Uzg5ZStjdjJOOWpJc0FYekV2R2pxQ2ZxVU03NFdsQnFtcjUzeXhVZXZa?=
 =?utf-8?B?WHd1V2JDMmZ4Y2Y3Q0J2UWwzM2M4YXdyZkw4ZFdtMEdVWC9KeXhwbGUvdzl0?=
 =?utf-8?B?R0dwdEVnaG9vbFVmRFQvSk9tWDF5RnVWZERpMHg2aHlSRXdqdkw3UU0yczN0?=
 =?utf-8?B?NVF6WklSMFU5d2wwK3BNMTVaZ3RNRWZMcG5paHlFbDhMU0g0YjVVK0Nod2xC?=
 =?utf-8?B?Y09rbmc0eE9xb2x5U0gwUk5YYllTY01KZ2hkQVV6NTJud0drQ2o0ckNXSDJy?=
 =?utf-8?B?eXJ4L0UwQ2NIb3pFME5zcGNlb0oxZWljVDlab3FCYUd1ME9YZkVybnpvdzB6?=
 =?utf-8?B?NHh0OW5OT0d0TGcwaEtpZ3FIejdQekNCZHcvazh4MVFBTDlXeUt3TDJORDg1?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23F7FD0656BE55458C0825429764F7B2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0627debe-0d65-428f-2ab5-08dae2dd7e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 22:56:55.6803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKZAAEX/TAIs4yxxIgDGHo/Ueec+ZRluQ8YQsdqEAVB7wyAWWj2E1YZcsrgmmtXz4OcmEFSxZ9X4CvPVAuniRw==
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

T24gMTIvMjAvMjIgMDQ6NDEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gdmlydGJsa19y
ZXN1bHQgcmV0dXJucyBibGtfc3RhdHVzX3Qgd2hpY2ggaXMgYSBiaXR3aXNlIHJlc3RyaWN0ZWQg
dHlwZSwNCj4gc28gd2UgYXJlIG5vdCBzdXBwb3NlZCB0byBzdHVmZiBpdCBpbiBhIHBsYWluIGlu
dCB0ZW1wb3JhcnkgdmFyaWFibGUuDQo+IEFsbCB3ZSBkbyB3aXRoIGl0IGlzIHBhc3MgaXQgb24g
dG8gYSBmdW5jdGlvbiBleHBlY3RpbmcgYmxrX3N0YXR1c190IHNvDQo+IHRoZSBnZW5lcmF0ZWQg
Y29kZSBpcyBvaywgYnV0IHdlIGdldCB3YXJuaW5ncyBmcm9tIHNwYXJzZToNCj4gDQo+IGRyaXZl
cnMvYmxvY2svdmlydGlvX2Jsay5jOjMyNjozNjogc3BhcnNlOiBzcGFyc2U6IGluY29ycmVjdCB0
eXBlIGluIGluaXRpYWxpemVyIChkaWZmZXJlbnQgYmFzZSB0eXBlcykgQEAgICAgIGV4cGVjdGVk
IGludCBzdGF0dXMgQEANCj4gK2dvdCByZXN0cmljdGVkIGJsa19zdGF0dXNfdCBAQA0KPiBkcml2
ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYzozMzQ6MzM6IHNwYXJzZTogc3BhcnNlOiBpbmNvcnJlY3Qg
dHlwZSBpbiBhcmd1bWVudCAyIChkaWZmZXJlbnQgYmFzZSB0eXBlcykgQEAgICAgIGV4cGVjdGVk
IHJlc3RyaWN0ZWQNCj4gK2Jsa19zdGF0dXNfdCBbdXNlcnR5cGVdIGVycm9yIEBAICAgICBnb3Qg
aW50IHN0YXR1cyBAQA0KPiANCj4gTWFrZSBzcGFyc2UgaGFwcHkgYnkgdXNpbmcgdGhlIGNvcnJl
Y3QgdHlwZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0K
