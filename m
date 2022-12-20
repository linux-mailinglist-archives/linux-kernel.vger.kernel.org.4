Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB0265293E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiLTW5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiLTW5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:57:35 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FF9192AA;
        Tue, 20 Dec 2022 14:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0y4CHQTxqcVsjY0fJNyLh9Lb1oS++f8k2oZgViVAFgNORHeYgf0rbn9mH8TQiAEqCEBOBgWsib8qfCePZuMtDCRGte887AZRHNkmfPK9z3xh8CMbDn6fOqpxMFRPs0iwHS3v9Zhj2g1htZ0rk4HEVnD9zQVW5KTdqvDVNq0phL97brBSJGp4OalJtr7I7B6RiEkJW2+dVRhT4pH778AjQ0By013hwxXUUiG/QfQAAq906m0+USWPIri5fWrZr3NFQPaEbexY4htQewYbjFzshvcnUSS4sSR4CEGvdvEV9kDVgL9SN1mb1tW3XXdmfk6OBMhO3NTXg/0h/USAuUI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gl1onKwoK8P6+JcBdtsdWTP+JfwPtTYf6Ekz62E4Mks=;
 b=bucBzT6RaNeAiuH6ECFBDREdFlnNOIkJFesdwncQ2RSEJJH/YU1YHSyAxwEInKzj5g0FvW7xGCVcIMT7ozkDg5H2zfq3TofYILNPgVdZOFvS/4U5sX+gD4pDndOSA5FzjAAi9PzKZBlskpSP91p9162Kdyn8awbYZ4rkV7E6LQoTIpaplTzAn9n5BzH5OMnhcvFRswUhw+wyV1C1yBaj1uQBtfEgy9FpLuEfSsD0ZCdFmFqr2JhZ3yhQakCGp3jKHvAx3bl2s2wAjnxt3mubm+agUIa19HfVLxgW4FwEhwa+bFY+fCO4MQAXcS2sob0xkkoSWeKh/v/8dGR8DQBIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gl1onKwoK8P6+JcBdtsdWTP+JfwPtTYf6Ekz62E4Mks=;
 b=U9o9czHNv6hNZuaqpHLrdftuI/j9/4gjLLTkEX73cWQBm6508b+KR8tJH05/sE8U716lOiYT+Rjem9tl9H4Vy8041f2FCkU7sJyUSrihM00fXMnJ6eZK47zG0E6hICJqlaSl9GJecmsnqRIMe7rSheEMfGEDqUZAQJHIL61Y7iWU7oMv1RRJBLhTKwCQ5i83Fm7DxK5wcVb9mkee4cI+ftoYhqvuqIuAfYsxIan18VxspJzW/y6WnH6/219Ogd5bgauhavquqozuNdYHsQ4mwIR2c995kyuh6YbE+stVKOokVAP78vWvnUt2tmxvhHQfMYE8Xz4nfLSvRktDeJD3ig==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 22:57:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 22:57:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Anders Roxell <anders.roxell@linaro.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-blk: fix probe without CONFIG_BLK_DEV_ZONED
Thread-Topic: [PATCH] virtio-blk: fix probe without CONFIG_BLK_DEV_ZONED
Thread-Index: AQHZFGWSgcSEB8lvpU63pBcIF++TKq53ZBcA
Date:   Tue, 20 Dec 2022 22:57:33 +0000
Message-ID: <9bd69a6d-d2df-448a-ce1d-c87344085142@nvidia.com>
References: <20221220112340.518841-1-mst@redhat.com>
In-Reply-To: <20221220112340.518841-1-mst@redhat.com>
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
x-ms-office365-filtering-correlation-id: fc0aa534-cfc2-4b81-b8c5-08dae2dd9464
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BD66THPmhUJ7buDdjhr4up72bLAfd/G5nfrKsJeuirZCweNPnyde5R2FEYveW9b92j+yWKq+3TmbHXBMJPozMTufVQA1R/jNlvK7QvNg9PR9O6LG7LLifcM94KQS4C8r4gH52FR0wRFlzQ8JLvROd8pzHgRXUKBaFvVEu/OOpUsXiaNqfuqGp4UKzlUVdvr+9kMVp+/SEp6Mm4gkjdBQd+2OXE6cvEAD4hwgCCSI6kxhBSnsOHgQO48Tj3tLE7tS4CTrwpkeI7eIvWzYxR0yoOjKqITE+H418rW+x0ijZsc9gMatNm+oXv+eZVYfBY4fYEUDd46Ifho6pRJKxe4afHKa0aNuBFL6kvMMRFiqi+0l3uKagLe19bA/K/z4qHLY9/qvU5wM221MvwdHHpyY9QQEXC2WRnNP4F+4SH/n/J8FbsEz8Gku0CgEsmcEO8Hf4xmcmdS4HKu4r7dunfHS60J4yDa9J3hB/yxea65n78qH2jkDhthwv1EmCeSdiABRB6J4/zdRQQSAkTxyBoNZ7BELrAMMnkJeUaFykQCIjpZ2QhM8byScKYj8g49dCQXngHjV/Aerw4uW6TpnaaEUwkD/TO9MSmM7YZjls7wQJ3EJTBL6z2vG7C15K3S7XNacietoBI8t7TXm/rgq59K1oqHloDxqAjCs3zruyA4po2CrV0JHnBFVKVKvYtdXnCV81V2WhXaRZztWIx6FVSDA6tKhvcRuT0O/vkXEKGiEgePw1zqfbJ78kZlnEx7uFl0E255OmTFFNz0bpirMY37Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(4326008)(8936002)(478600001)(91956017)(66476007)(76116006)(66556008)(41300700001)(64756008)(110136005)(66946007)(36756003)(38100700002)(53546011)(122000001)(38070700005)(6486002)(86362001)(6512007)(316002)(8676002)(186003)(6506007)(66446008)(2616005)(71200400001)(31696002)(2906002)(31686004)(66899015)(54906003)(5660300002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVMrcEZkUEVzVXZnczhPa2M5cVlaeVowbE5XaFR2d0h1dW1MRTl6Z2NzWi93?=
 =?utf-8?B?VkJaUlI3REhxZEhRMUs5TUtsdm83c0FLT00rV3IxRktnb0JNdml0Y2h1WWhZ?=
 =?utf-8?B?V0U3cTBhWkI4T3ZiRmNicDhjd3c5eGZLaXZGUFVQU1NZd1BJL0pVdklZYVZJ?=
 =?utf-8?B?TnIybmZxc3BnY20yUDI0VEdVMDVkc08vZlkrVFhOaEYycmhqYXIrQnRXS3VR?=
 =?utf-8?B?enJKWnN1Rk0veVJiQ094dW1jVzljM05vZFdQbmNtQmlIVmEvejFaaWJhRHBM?=
 =?utf-8?B?RFppbnkwUDFOZXgyMTI2NjdEenVleGhFNHNPVFhTNlp4TU83V3dIL2pKdmE1?=
 =?utf-8?B?VWFMcVovTlBkTC8wY1pHWVRZeWJiNFhlaFc5STE5dVMrMTJVMDVaL0p3dTkr?=
 =?utf-8?B?Zm9vaXlucXlYclhVYUExZFBIMEFjYWVhR2tlRHRpcytOT0diVWwvclFxYjdG?=
 =?utf-8?B?SFMvdjJPakRQTnZTelhkYmZVNTQrM3FrKysvSGdaSDZxV1BtakRiUFE2OHpB?=
 =?utf-8?B?T1gyak9sQmYxWGFMbEVCYk43blVEUjNoOWpMN2lBY044bEtkMFBSanQySHpJ?=
 =?utf-8?B?czhLU0RUK3VvQTR1ZlMxU1NVWCt5cnVtWDVvaXZPcmdhTktBSW5HeDlGMU83?=
 =?utf-8?B?eUZiazZDNVg4M1hUc0NaWFpYYmY4S2xzUXlkYUU3a3c0aURsaFVwQ0VGYWlH?=
 =?utf-8?B?RUpXczVDKzhoOW1VRmJjREpzNU1TZ2hYRkpRVWszeWdRRGhhbmZtRC9WUkNW?=
 =?utf-8?B?MzV2WC9ac2U3cDIwbWpjTC9jMHdtS3lIUDA1RGhEYnVGSWUwUmp1eWU0MWFJ?=
 =?utf-8?B?ZVhybE1qN0hNbUtITU1zNU81YjJzQWZKbXhja2hQTTBoSGQzQmMweHJZVjJ0?=
 =?utf-8?B?dHh0VGFnMnFRVHFNOWxjd1ZQcFk3eDBIS090ZnFCUGErQWp2aTZzbjZKRXQr?=
 =?utf-8?B?WHlaVmE1Y0M3NTF3dnM2ZExnV2h1ZFFEL0J3ME41QnFPcUV5Tmora2pxWC9v?=
 =?utf-8?B?Z0ZtZ2hwNlJyNW1sWmh4SGY0UldQQkc1eFR4d2Jhc1U1T2wrbWxOWDNYemZV?=
 =?utf-8?B?TGJwNFFGVzh5ZlpsRlF5NWJxYlNsNmRlcDgrWmJ4b0Rwa0Y3Q2ZROUdaMGVo?=
 =?utf-8?B?YVlrZGdHT0RhZzAvSlIxL0U5S3FkTHdkd1o3RnIrbWN6YUo1TWpwMktBMlVX?=
 =?utf-8?B?QkZLVDhMOGxvc3ZNeWw2N29DdU00QW1EVTU5VVNTMVU5WFdYNFRMVlpqL1Bp?=
 =?utf-8?B?aU9nNm5VTGNBWmV0eGlKelRQUG5DU01hbUgrTGhSb0lUQXFhYlRYVlpxb003?=
 =?utf-8?B?akUvVXBsUWhSeEdyRUk5STY3VGJ2UEhNWlVRK2NCTWpseXBKd043dG05RkJO?=
 =?utf-8?B?bUE2cnRjUDhWTW1MYStWT01aUFE2N1lTTUxTNkRGU1hPZUNaVkN4MWswUDlM?=
 =?utf-8?B?NmtzMDFPWDg4L1dvc0trWU16TXpNbkRBVTk5VUROeDJRSU0zRm1KZEh5TXk1?=
 =?utf-8?B?UFdxM083VndNZ3ZENUVnbEFENCtneUh2WVR2VGRnU3RncEE0WGFZUHdmaVR2?=
 =?utf-8?B?M281NmtRS2VpNHRLYXpEaG5lZC91VTNpaExwUmlDQ0Y5UGluQUI5L05GUW93?=
 =?utf-8?B?T3JQbFc3ZlVwMHEzMWkvUTIwdFlFVkpMNFk4b0pvOWtMeENiMklTWXRKZHhC?=
 =?utf-8?B?TjlzcW83NGhKVTcvSk9MVTZtakpUQU9VbUcyUC9PeWM3NmhkQmpFVWpjQjI3?=
 =?utf-8?B?ZTJ1clRzKzhBT0FKR2ptOWFSYVZCamtOQlBKd2loUmhQRWVaeDZsclNjWkhx?=
 =?utf-8?B?U2VDak9VVm00MjkzWkdLd2tVSjhtQWFlQ0RwenZpRThYWXlXTDR5blkrTW4y?=
 =?utf-8?B?VUc1QjVJWlV1RkxsUVl1YjJES2Iyb2FLWGNJcXhmK2FRTXdwYWVpY0U5UkVO?=
 =?utf-8?B?ODNnOTliSHgyTHVNd3p0cUxob2hlbTArMG5mTEhqa1I4UU9OeXVSenJtN3dR?=
 =?utf-8?B?b0NtT1V2anREckhZdHR0d0k5aXFMRE1NZUxJcDlhVGgvYWNaN3hDampTU3dn?=
 =?utf-8?B?MUliZE4wMTV1S21id0J0MDRGUG5pakt3YVp5VmpnTmV0UXFWcEhUd3hCOW03?=
 =?utf-8?B?NnRlS2tsMEJzdjdGYVMrSFlPVGdnYTlyajFzR01WaUQ4bWNsNmswem16cGRz?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7DA84C7FC0063489BF02BB5683FB12C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0aa534-cfc2-4b81-b8c5-08dae2dd9464
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 22:57:33.1312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gh4oBBnYrvh36T0Xc9OkasLgukdXfpsrXKLlJuuSDHFXoNsMp3Ik+YqBRYUPmT7Jtu5fiEA2vbe7Ss7Y02oy2A==
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

T24gMTIvMjAvMjIgMDM6MjMsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gV2hlbiBidWls
ZGluZyB3aXRob3V0IENPTkZJR19CTEtfREVWX1pPTkVELCBWSVJUSU9fQkxLX0ZfWk9ORUQNCj4g
aXMgZXhjbHVkZWQgZnJvbSBhcnJheSBvZiBkcml2ZXIgZmVhdHVyZXMuDQo+IEFzIGEgcmVzdWx0
IHZpcnRpb19oYXNfZmVhdHVyZSBwYW5pY3MgaW4gdmlydGlvX2NoZWNrX2RyaXZlcl9vZmZlcmVk
X2ZlYXR1cmUNCj4gc2luY2UgdGhhdCBieSBkZXNpZ24gdmVyaWZpZXMgdGhhdCBhIGZlYXR1cmUg
d2UgYXJlIGNoZWNraW5nIGZvcg0KPiBpcyBsaXN0ZWQgaW4gdGhlIGZlYXR1cmUgYXJyYXkuDQo+
IA0KPiBUbyBmaXgsIHJlcGxhY2UgdGhlIGNhbGwgdG8gdmlydGlvX2hhc19mZWF0dXJlIHdpdGgg
YSBzdHViLg0KPiANCj4gVGVzdGVkLWJ5OiBBbmRlcnMgUm94ZWxsIDxhbmRlcnMucm94ZWxsQGxp
bmFyby5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhh
dC5jb20+DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
