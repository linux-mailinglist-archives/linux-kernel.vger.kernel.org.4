Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73B66B77C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjAPGdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjAPGcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:32:43 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAA91041E
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:31:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9rl2wRgaNkfwy6J0Y0f5IRcyKzd+YqgIx9WEIdUYBs4vrKb61C5mi43dsporVRiSybWdujagtVTgjQt61aZvE80iIRpOF4XnWyF7Yz+GUxU2RXxq9c0c9zuYdv0fN5hlP/J5h9K2wUgzXPbJGQldJ4J1xf+o6oqLlB0fXFLvaWr9IHrnVtjJNl/s5qy2JhY40ACKKZOPtSLLE63CQufDbxNCWickA6d4XOgsQN2O/Z1Tig2/OQnnbLPAkv9WfcXp6cVUup+IVtj+kV9riYWqVllBZ8cL0iwI6v31Y7CigAx61LjzvB2lHpUtZ4xLMo8nDBM8AaqK7dpehgaNXurhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZmE7o3/B+5t6Jy43GCfgfVm8O/QZAfX0ycfcCNw+/A=;
 b=fxBKXsauQkyMuSrD7nzsaEM29g3OMspXkM8jiFRmbBcK1JLwcoXGxyJ50Pj3v6Hzw7YWTFDt0blVWuGNtV55UWlWkVpNr75CdIMEdgqNONHuJ7pYJJ9EhcIBoTX3Jcgmciv7LcOjMblCSty536vrdr0i+VBu+kYT8ztXiUadXltTz8NjpMQJKl4kbfep0uMUMuNlH8bYH0JA5ror8XXrQRDzGagwcqNMTgHs8nD4YroAsDX2SPVML4g126nRujK9QwJsj84g9yi2TyblggA0/UNkDUV8vcTGOOr3DLbovGROX0t1B2V5Ug+R1Q5qpZ8mi+BxSrKyEi7DyTjzpSgVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZmE7o3/B+5t6Jy43GCfgfVm8O/QZAfX0ycfcCNw+/A=;
 b=Gg9xFy4MzL+sWkIXNu+8IFRBNmiWMuHvj10DDoibUo9gLMmPYhpzeoTAUPZhbzopPU08DrHt601R1ze2uOLTk/fzOPs65gXj1TlYMp6k+ZN797ZniqRNA30Ez+hkOGYhcA+/omYiLp+dgmD1Jy3xgY1py66hhiWCDw+tsC+Za5tj4MvLWIxowAbUg6nJfUs2oIqANRzWuVq9vB0BspJEP/Q10k9XuRhA3nUUqt5ORYHNQ5/UAi/FBSNm60mUOFXlcudoNqJQfLCpUQlwB9lT0bR37F58wYow7VaMN6cvzC7DCd3Oll4ELKtCFEvrnlwEe+j8wYJ4EopX2PBABWPQDg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 06:31:57 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 06:31:57 +0000
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
Subject: RE: [RFC 1/3] vdpa/mlx5: reset iotlb at dup_iotlb
Thread-Topic: [RFC 1/3] vdpa/mlx5: reset iotlb at dup_iotlb
Thread-Index: AQHZJpFNRxLN/nFynkmcbQ/cCzeaja6gmgdA
Date:   Mon, 16 Jan 2023 06:31:57 +0000
Message-ID: <DM8PR12MB5400550E8664315306F04DFAABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230112142218.725622-1-eperezma@redhat.com>
 <20230112142218.725622-2-eperezma@redhat.com>
In-Reply-To: <20230112142218.725622-2-eperezma@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|SA1PR12MB8144:EE_
x-ms-office365-filtering-correlation-id: 8913d265-df44-4bb0-3b5c-08daf78b5dd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9ZG5g8Fzp3qvJKRar9bsThKwaoR/+n1rtwLGV7mhZRy9noFdxpAnb11xFKCGdyL+alfD48Wn5gkQIG2QTEKrw5BqBlTAz1311pC2jhNyvMI1AK9vbDt/E19rndrgfEHw18exOJ1BzBZ8ilL5l3IQx7sHoIW4w0gnwpAtdwKUg05+6slRxHrgoTLmGCoTIY3CG69djG+c5Q+7lYIiXiXrOhw3Tqyp04NgPP4ppB4Vsh6h1riXBhCvo+yhjrushNgXRb0yiMPbnJzTO9IMdyQNNcNJw4lJ7oMPOmjEWocxYoLWTO52oXMajNTk7mfqWr/PAHC/wbgyXwC9+pXqqx9FF091Je7ToBL0pG9lGgETThLzuI6Qs69Ha0780BcyuP5kZuYSwgGQq/bfqbMCLiWIa+HWwcBfESQp/SzNuosZDrSp01BjZIIy0uRzsgiVeHdX/dmVxLu7iNApMCQQZhE1y9qvgmmaFRFMNYSPo8NxGPNNtaYRAQBdxqBaesDXghsIBXjWAmcmCa0n6bim5xPe00jBU1+yv0g3pGP8Ye/zG0mPaxaZlzLR4o3zNIzaW1jkOXl/tU/5926w2eP89uY0jWgQnP3ua+KHuSKlJ2OywdMyFsdmuNasBh2dlKrbgMRqHNcPZNsbtCJ2LQJWn7MpoIdmxr8OrQ913RhdyePuYLIbd5WkhAM/vCTNs2ge+kIapUhf+8V3EMqjQG1frOlMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(38100700002)(83380400001)(122000001)(33656002)(86362001)(38070700005)(2906002)(55016003)(5660300002)(8936002)(8676002)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(52536014)(41300700001)(9686003)(6506007)(186003)(26005)(53546011)(66574015)(316002)(54906003)(110136005)(478600001)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2lta0Q3WlJvbm44VGcreW5pczJteVkrcHpMZGU2ZVhidDJYSElqTUdEMTMy?=
 =?utf-8?B?NmdmNEVhdDVWTzdDZnFhN3BKalhBTEFiN2R6bjhtdmVTSStyYkE3Mkp5L1Z4?=
 =?utf-8?B?Mit3NHdXRmc2b256MllZQ25KM25PckpmRVZMTDdJRWVLMlV0TEJOYTUxVkJW?=
 =?utf-8?B?NDNPcjhqN1VDZzBXc05rVmhlc0EzdTZNRjZJR3R3SDluMDNxcGcydEIvdm8x?=
 =?utf-8?B?TGE5QnF3d3lCQkdvUzlTVEMwRVdlc2xhRGh2ZGF2SmE2Q3FDczFRcG03VHFx?=
 =?utf-8?B?QjQyYVpSQmswdUxIZjE2OHpxS2x0SDRPNFNWUGZrSkcvbGVtUE1iNy9nSVhT?=
 =?utf-8?B?ekM3SDgyZmllZFhMVmVieC9XZmlaWWJtZDk5M2NtMXBZRWcxRzcvMTA1ZmZE?=
 =?utf-8?B?Q2dtay9qYkxUY0ZpRDQwa21NNkI1Q0RlRTROVnl6VUkyVXJTVitKN25mRkZF?=
 =?utf-8?B?VWxRQkxINzdnSnJMWXM5Wkk0VnlUazRxYUowOEY4bUdXQjdBY01DVTlCZ0U0?=
 =?utf-8?B?M1V6OHczb2hYOG1NY0ErdWZXeEVKeXFjdVlvWG9RQlV6UjNNeUVYMndiUjNS?=
 =?utf-8?B?VXhJb2tva3g0RDEwUnl2YlovU0FqTmZKWm80bmwydVJsSDVMSUU2NkZ1VDNG?=
 =?utf-8?B?NDV2Vi95NEFGdkFETzZ2N25BNHZLM2k1Q3VScExyeVp5U2U0ZlZEQ2NHL1J4?=
 =?utf-8?B?WVFDdmtBV3ZReU5BRW45SDlEdThOVlBwUUZFdkFMQmcvOFd5NmY4dzBRUGxW?=
 =?utf-8?B?TFlJV1A0aFhzVS9EMWxVWDllS25UOUJGT2xFV3hmb1NMRG56dWpzUGFSVDB4?=
 =?utf-8?B?bFI2YUVZZDlhVUdGMm0zVEVvUmZ5djB2QnRxOVNDSzZiK01Md0w2VFErOThy?=
 =?utf-8?B?aVlDNkRJVEpBMzJoWWQxQmtsVkVxOVNCY0ROb040b1VPeUVHQjZLcTJsM2lm?=
 =?utf-8?B?Zkt5TWlFRGZvN01UajNSNGpFZXBHOWF4eU55YkVqTWVvOFp6b3RIS01vQmVG?=
 =?utf-8?B?aWtHUUZhVUVrcFVjNzNYWkxCR0hsRUVHTm5MSGF0a3BCY1dIbmt4L3FTKzBT?=
 =?utf-8?B?c2ZKWVN2OFNWclJWTE8xYU4rTS9kVEFkYVNxUW9WbExtQ2trZU95M3BmcUY1?=
 =?utf-8?B?OUdXMTJpaXZmQkdvV1RXemROV2pDRXRhYkF6R0RHNmVRbTR5MngwZTVCZ0Zm?=
 =?utf-8?B?TU5aYVBTYXAvdWxjME02QnpFN1V1cWZwcE5raHBPZUV2OUJWdlUyNVcrcmgx?=
 =?utf-8?B?TDVWV1JhZUEwZTFIZENJS2YwZmhRaEE2dm9TbEdOQlpKWjlDTnNkTDRVaitT?=
 =?utf-8?B?VlgwT0NGMmltc3JVMUE3U1VFUE9ydlZLUE11ZDVyRGNQTWRjVHBraWswdi9s?=
 =?utf-8?B?a3NzUUZncmQvUGRZeEhjRGJTdC94SUJ3Q3o2bjlVU3cyY1BWVlBLaEpydVp5?=
 =?utf-8?B?ZFg0ZzZ1M0xWTXF3RUhCLzRkSFU0ZlZZYWVqemVJdU52WS9LSVlWUlk4MlVh?=
 =?utf-8?B?L3ZpUjB5dytPeUFkN2JwVVFqVDJKM2RjSmpIRC9KaWIwWDFaenFEWXZRait0?=
 =?utf-8?B?WVVwQmlRNTVNbXlPU0ZPWW83eVJkU2RPbTZoL3ZBdUtPZEgwZlJMYlc1SStk?=
 =?utf-8?B?UWRGWVl6a0tmWHRtaGhadHhYZE9WV2dTQjlpejB0OGc5Wklaajc1b05WUnBZ?=
 =?utf-8?B?eGY3emYxSGZDZzV2aUMzS0ViQkREZXBnQWtkTjJiL3ZxbXJ5Z3NkekNwVmJB?=
 =?utf-8?B?b25OTThETzNmU3VndUIxN0dwU2x2RyszZ3gyT0ZCaWR0TFpKYjU5NHhiUkZD?=
 =?utf-8?B?Ujh1OUVXMTgrMlZzK3k4azdpLzNqMWMxdFhJU2lLQjZURW0yY0poc2dkZHpO?=
 =?utf-8?B?ckxXSGFSYk9qYmF0aXQrdWhTWDNNc3dBMXFuUVpXQ0FWTTVqcmluSnZ3eUdB?=
 =?utf-8?B?NlNRSXdWa1RmSCtiSUpGRDVDWDVRWE1uL2VZNDVaenpNVFVVY1JmSU5wczVy?=
 =?utf-8?B?b1VoWDVWMGFrb3F5Y3EySzM2M00rMldqMWpEZUZLZDZnVTUxdW11VW10VjZP?=
 =?utf-8?B?WVVJYlRCQnpqdnAvZU5LclJjWnFvZzZoVlRnOFM2bERSNUJEZHE4dXNRbDRV?=
 =?utf-8?Q?m5LA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8913d265-df44-4bb0-3b5c-08daf78b5dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 06:31:57.2542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Fd8zq5Kbp/zOWdlyT6ydaMVTsMh2l0ZH2FmmrP4KVi1EJoRCzjlXJAo9z5yutLc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
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
dWJqZWN0OiBbUkZDIDEvM10gdmRwYS9tbHg1OiByZXNldCBpb3RsYiBhdCBkdXBfaW90bGINCj4g
DQo+IFJlZ3VsYXIgbWVtb3J5IHJlZ2lvbiBjaGFuZ2VzIGFscmVhZHkgcmVzZXQgY3ZxIGlvdGxi
IGF0IHNldF9tYXAuDQo+IEhvd2V2ZXIgdGhpcyBpcyBub3QgdHJ1ZSBpZiBDVlEgYW5kIGRhdGEg
VlFzIGFyZSBpbiBkaWZmZXJlbnQgQVNJRC4NCj4gDQo+IENsZWFuIHRoZSBDVlEgaW90bGIgZXZl
cnkgdGltZSB3ZSBoaXQgZHVwX2lvdGxiLg0KPiANCj4gRml4ZXM6IDhmY2QyMGMzMDcwNCAoInZk
cGEvbWx4NTogU3VwcG9ydCBkaWZmZXJlbnQgYWRkcmVzcyBzcGFjZXMgZm9yDQo+IGNvbnRyb2wg
YW5kIGRhdGEiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVk
aGF0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgfCAyICsrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL21seDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jDQo+
IGluZGV4IDBhMWUwYjBkYzM3ZS4uYWUzNGRjYWM5YTNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvbWx4NS9jb3JlL21yLmMNCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5j
DQo+IEBAIC00NTYsNiArNDU2LDggQEAgc3RhdGljIGludCBkdXBfaW90bGIoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LA0KPiBzdHJ1Y3Qgdmhvc3RfaW90bGIgKnNyYykNCj4gIAl1NjQgc3Rh
cnQgPSAwLCBsYXN0ID0gVUxMT05HX01BWDsNCj4gIAlpbnQgZXJyOw0KPiANCj4gKwl2aG9zdF9p
b3RsYl9yZXNldChtdmRldi0+Y3ZxLmlvdGxiKTsNCj4gKw0KDQpBcyBmYXIgYXMgSSBjYW4gc2Vl
LCBtbHg1X3ZkcGFfZGVzdHJveV9tcigpIGlzIGNhbGxlZCBpbmRlcGVuZGVudGx5IG9mIHRoZSBh
c2lkDQphbmQgaXQgd2lsbCBjYWxscyBwcnVuZV9pb3RsYigpIHdoaWNoIHJlc2V0cyB0aGUgY3Zx
IGlvdGxiLiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KDQo+ICAJaWYgKCFzcmMpIHsNCj4gIAkJ
ZXJyID0gdmhvc3RfaW90bGJfYWRkX3JhbmdlKG12ZGV2LT5jdnEuaW90bGIsIHN0YXJ0LCBsYXN0
LA0KPiBzdGFydCwgVkhPU1RfQUNDRVNTX1JXKTsNCj4gIAkJcmV0dXJuIGVycjsNCj4gLS0NCj4g
Mi4zMS4xDQoNCg==
