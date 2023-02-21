Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36D169E69E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBUSAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjBUR74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:59:56 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9A794;
        Tue, 21 Feb 2023 09:59:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/92kvWSqoGRC3AykU3OzI2wIKYvW5MyfTFfnTOvZ3EzUj3zUEuT1GWETv1aEKr1b5By6W4qQTVSFYiapE1U8B5XH8ORmEKS1ft2sNiUl4ZDbuvYSqau+6+XZEiMMVoDr2n//znzSsIbVImA5yDGlfJ+qHOu7NNDgMOVDWR7EfMowZ4gbjcKPOTJgcqXlMF9BJrvdpmsWnMipmMxcXiDlO++qvLhcBzGAJLhrXmXs5fkuGD71JNYlud7jcjSwf3oH6bZZsPzyoVtmVW3Ir0xRMULwh44cbIvwEAAEsaGAbnfOh7EjoF37Nv06kBppO2wH0PZma0cyZzM+AvVaYj7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3YWVCc1DBFiLprXUjVsduaVwQYhUcbf/evKUyLgCgw=;
 b=D9ukg459gHWe5EVNGCWaK8NoHcDjDaitNm8G/DrF1pKMmwNeYpwTpMcJ9/lv+DVMKyflw3bcg+U8Jp6K5Z8ak4FBs9eLNtJ3KzI/DwKGzrMgwGLmlEUXFoqXYH7Joh+I1zHyGkh4/vdXEjXQ6yeekgHc/73QfRDSv/1RRwaa/b47S6sgwXg9IqFxuDD1+F4SM5UDg7NvLkhGlqWqj8Timh9x5O2QRHeCQzIb+FEvGFoeyUKZ7a8I8QqapDklQl9T8heUpV/ktc14p/dOMuxM2v5QgCYJW7uglZeyBIjae01lfgN8IpPgmH9CDnHK3tcUaiKpi/J+GFv9TokIeMeArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3YWVCc1DBFiLprXUjVsduaVwQYhUcbf/evKUyLgCgw=;
 b=Pj/vhZZ32II7Ro6M8cmicC+VjqvQpK9YFUb+AkXWK4xTvLYsFMvJDtY/jrW1YPxP00gDqRi3AzCcW8o0p/3UCt97Zgd+6ikxfPgvkbKJ8qnPKVuInDrMYDPkRYZ++A28yPDDIFzWCpssju8eWTH5Jm601e5zbZ5Z4RX1hxN2/7fpmSJUmlaKo+cWod2OcT7ircFXBQ11L/SwFLl9Kn6sNCHnbHs3zUO5EclvZGq/WfraPNHnAB5aAaNpzUPp9hmmYFtsUCFCYSz0mpEJpcBgIgNN4jzJPXcvpq1XrVamm3jbuj+VnaaH9nbqKur0xkRBSjIXVIp/nkY4+mtINgCITw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 17:59:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 17:59:50 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "zhongjinghua@huawei.com" <zhongjinghua@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "code@siddh.me" <code@siddh.me>
Subject: Re: [PATCH-next v4] loop: loop_set_status_from_info() check before
 assignment
Thread-Topic: [PATCH-next v4] loop: loop_set_status_from_info() check before
 assignment
Thread-Index: AQHZRdazZY90rcUjwUmHq/IvLCg65a7ZsOmA
Date:   Tue, 21 Feb 2023 17:59:50 +0000
Message-ID: <7b2240e8-6776-9b3e-b054-eeb16d87142b@nvidia.com>
References: <20230221095027.3656193-1-zhongjinghua@huaweicloud.com>
In-Reply-To: <20230221095027.3656193-1-zhongjinghua@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7195:EE_
x-ms-office365-filtering-correlation-id: 30a25871-07e4-4aa5-5dc3-08db14356d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ziVkaNA5VvRkUJ/vpGDnqUNMzegv5tS3lN5gc8ybDDV+8dUkrc1D1zUhDq+XXPH1CI/fStiHOz7tz7dRXGYd9Xxv2zUdHJclsMx3ZlecwziFTg7GdwF2DFAUtQDqADZejqEhC5sP6uUPfr9InlIZEQrspqAq6tivpLmZtbD0kmugsEI0xOM8Y66kDbhebwewqEaWkhCqsZ/YPbvqsN02kfcTOLbpcpatL1fIujFpUqaCYLH2m2jZyzfppeFbcF5XOF8xnf8szRMUCrkRxxyEMn+dp14dVSdwFHVCSpkcUJ5GettIjosEef4FeMcCG0lCVuQ1aaO8w6VH3vmgPvDiqGJwxiC53QuAjQ9d6CTWPFxLSyHCylSrlVYaaSxiqhEGHL4e6Oi3sCQ9kFiO8N3JBfu5gvCSlmFqwDo5qdk9MdX3uZaqJ8lLkpjR1IN+OT/oY82BZ0oz4oL/6JZuYdCaQ9FQ1TwVSHhUZWMFeg6wGdjh+KMebn1aoFoCXtc2QgoezanPz7wx0Dpl4J5950OOGG7ZSyAqBH70+usSPc6vH90Heckb4oTcP9Qki0/mxw6/33pqGxV36PtNebM/VNCkF2xpLdIRudlgx//+9ToeNTrzTDkDLxRscNR6NUymM89fZWOuEW+VzTNOoTl4RakvQKMIJGo7niqNicAjSmyCHmp8hXcNuPXSkAY3KxoK6iEoKywtii/L5gjUXdLFCFjCSdqXh+znL/eDsK0W4IU8NtJkvYqKn4NG74H+ByqcH9AILYQatjXF09+mTPu4K3Leg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199018)(478600001)(5660300002)(6486002)(2616005)(4744005)(38100700002)(7416002)(41300700001)(8936002)(31686004)(2906002)(76116006)(91956017)(8676002)(71200400001)(66556008)(66946007)(66476007)(4326008)(86362001)(64756008)(122000001)(38070700005)(83380400001)(110136005)(66446008)(31696002)(6512007)(186003)(6506007)(53546011)(26005)(316002)(36756003)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTdPWnN4WS9pOGpZek5iYURjdUpzdXFqVlZIQXBHbmt5dzBHUlg1K0ZOOHJP?=
 =?utf-8?B?ZmxUZ25UQW9QNlJlbU5yRUQ0cGg4VFY0NlZaQlJvMDRJbU40N0pjTk1MQTFk?=
 =?utf-8?B?cjJxS2tscURER0pXL1pNMlVXcmVjNzBoc3R6TldVUGtGWEZ0NXFPenRsZnJs?=
 =?utf-8?B?VWNUUnhOVVpDNmdCSTNBeTA1d2dUZ2p5WjJNV2ZCVmc1YUJJYWNwRm50L1hu?=
 =?utf-8?B?Rk1wOG1GOFhaL2F4NXVRenUvNlY4NjJoc0Y5M0tRaWNQdCs4blJ0RmlxUGM2?=
 =?utf-8?B?S3I5Z011NGdVME5rc05OdTdFTHRTeVI2MGNUYUx4TnBYUWl6SXNOdWtKUkNC?=
 =?utf-8?B?elVKakZaUm5GdlNrRnRaZUplUEovS3dwbFBwa0Nxc3FiWUp1VVQydlcxWnZr?=
 =?utf-8?B?QU1PQmY0bjczaGd4NGNmck1ScTlwVVJsakN1OWlnM0VUOURuK3dZVVJ5Y3VL?=
 =?utf-8?B?cmdEdXB4TEZsVEFqMlNaOEUxZGhrRUU2eFh2aVlQUWhJb3JSV25pMlY1SHZI?=
 =?utf-8?B?QVVHVVM1dEFjU3FLdzVHSFFFbzNDeUFHLzk5MW0rWDVFRG8xMUs4SVBOWVh3?=
 =?utf-8?B?Y0VuTm1nOHpubGcyb2xIK2pqc2NnK0E2WGFTRVNMWjg3R0pQNjhQMjdrTC80?=
 =?utf-8?B?Qys0V0xwMXNycFhRRHpwVDhiT1ZnZXRTR2ZPcGhQbFl3Y2R4TDZLRnEyZmFo?=
 =?utf-8?B?NjNmVUV1ZjNLOVFoMlFMY3R4Z0hTbkJ0ZldIMVBpZzRwa0ZXNStuc1V5RWJo?=
 =?utf-8?B?RFZkN0VDVjRXWHFlWExrc0M3eGZpVU5Gc2YwRkhOa1lWcXhLS2NPZlJ2SG8y?=
 =?utf-8?B?UGdMY2lQR3BRZExWWEFFQ0dETS9NRVhMUFdYanBzL0RWcUR6VEtTRTc0SWdV?=
 =?utf-8?B?cDYxNTEzb2xpOXlaWWdGbENSblJSMFczRWxucGs5Ry81cDlmOW9WTGJocC8x?=
 =?utf-8?B?Nm85SlVqbGdIem8wNFdnZW1DaklYZUFwcDNFMU5YMzc1MVVvdkxWdVQ4Yk9z?=
 =?utf-8?B?WjZyZlhsczBnRVI0d2gzdFZzM3Y1Q0pjWkdXVXJUZFpLWS9kTE5McnpHQmhn?=
 =?utf-8?B?Z3J0QXlEU1VYQVNYVnlVVkZWc2RSQXVlMkVBVXc4TnNwVFdybWhxaFFVenRQ?=
 =?utf-8?B?aXBEaTR0QXF3SS9XSDIybjNqVlhHVHA2WkFDS29uZEsxcFVTZUlNTVhITFJq?=
 =?utf-8?B?dTU1QnJoUS81bnk4Wlp4cEszZ25tOURZaS9zazd3ZFJ4akpMT0ZrdDFmdGMv?=
 =?utf-8?B?U2Y0ZWZKK2JHY1JzdUdMU3JXNXZIL09PQ0VQck5kS1FEcm5BZ2tGWTFwTXlj?=
 =?utf-8?B?bllZOFVzZ2pzb21BTVcyUnR4TnFqN2ppMUpUSklOd0pZNm5wWjF6bjYwVFlF?=
 =?utf-8?B?TzJYZmkySWdXUDN0anR2S2J0QWpDVGJyU3lBYjB1dXY2N0VSUitSZkdMT1Az?=
 =?utf-8?B?c1JVRi9mOEQ5SU5RRVhpaGVNdVp5MzN5TGQwc3NraDg4dy9HUi8rV0JCbnNi?=
 =?utf-8?B?R3pKVjhEM0E5OHBuaGlWc0NjNjFZV2NWUTUrcnExZ2ZGVjlnMjdsZ2d0TTVM?=
 =?utf-8?B?eFZ3TDZtcytoNFBrbmFMaEU3eEtOWjlmLzJhWGZ5T2VxRlRKWFQ5VTh5L3R5?=
 =?utf-8?B?L3V2N0NIb3J0dlJIZDNUV3ZJZlROV1htcVRQQlZMdTZFS1RhRjVmNGF5YWNQ?=
 =?utf-8?B?SldlREM2cHlmYmtTQjFaVXBkWkZ4VlUxOW94ZmQrL2ZUMG45bU55VXd3NmVj?=
 =?utf-8?B?c1VhVFZ1ei9tb082S1RFc3RmOVBqdWFqTnN2NWxCUHJlK0pyY1hpL09oaDRy?=
 =?utf-8?B?R3BsSWk1MXZ2cTZTcEpKMHFVdWR6YUpDQUxHbDM5QS9QVWYxMENnS3RQVG9N?=
 =?utf-8?B?RGZKQXpyT2lVWmZGb1JrUDhTTldCcFlWYXRqREdwRS9jYlBRcm54bEl0bVdL?=
 =?utf-8?B?UkhaMC9TT2doWlNaVTZ3MkN6cnZmMEdyTGZCeE9oMkZ4bkdNUEZlaEhrVXJj?=
 =?utf-8?B?ZEdQRjArYm9rK3ZhYzNVaU4zNE9zYmdtTWJqTnlJQjd2MUR3bjBGbXUxbSsz?=
 =?utf-8?B?L1pYWHFPelVER3R3MWMzeTE5ajVubDZEckIxelc3MGttUS8xT2FJd3hTRTg1?=
 =?utf-8?Q?/AAgt0VjQpBGV4SaA/RpX9GbX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <766EA811A42C9A468B61280D9B35BA04@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a25871-07e4-4aa5-5dc3-08db14356d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 17:59:50.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ognum27RZTm5LYM88Ih5OddNEr5RsJIpIsdSxmjcStMLueSUKRAALE12VjSsXRjxZ6VFAgau2PkgT5DJ4tVBCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMS8yMDIzIDE6NTAgQU0sIFpob25nIEppbmdodWEgd3JvdGU6DQo+IEZyb206IFpob25n
IEppbmdodWEgPHpob25namluZ2h1YUBodWF3ZWkuY29tPg0KPiANCj4gSW4gbG9vcF9zZXRfc3Rh
dHVzX2Zyb21faW5mbygpLCBsby0+bG9fb2Zmc2V0IGFuZCBsby0+bG9fc2l6ZWxpbWl0IHNob3Vs
ZA0KPiBiZSBjaGVja2VkIGJlZm9yZSByZWFzc2lnbm1lbnQsIGJlY2F1c2UgaWYgYW4gb3ZlcmZs
b3cgZXJyb3Igb2NjdXJzLCB0aGUNCj4gb3JpZ2luYWwgY29ycmVjdCB2YWx1ZSB3aWxsIGJlIGNo
YW5nZWQgdG8gdGhlIHdyb25nIHZhbHVlLCBhbmQgaXQgd2lsbCBub3QNCj4gYmUgY2hhbmdlZCBi
YWNrLg0KPiANCj4gTW9yZSwgdGhlIG9yaWdpbmFsIHBhdGNoIGRpZCBub3Qgc29sdmUgdGhlIHBy
b2JsZW0sIHRoZSB2YWx1ZSB3YXMgc2V0IGFuZA0KPiBpb2N0bCByZXR1cm5lZCBhbiBlcnJvciwg
YnV0IHRoZSBzdWJzZXF1ZW50IGlvIHVzZWQgdGhlIHZhbHVlIGluIHRoZSBsb29wDQo+IGRyaXZl
ciwgd2hpY2ggc3RpbGwgY2F1c2VkIGFuIGFsYXJtOg0KPiANCj4gbG9vcF9oYW5kbGVfY21kDQo+
ICAgZG9fcmVxX2ZpbGViYWNrZWQNCj4gICAgbG9mZl90IHBvcyA9ICgobG9mZl90KSBibGtfcnFf
cG9zKHJxKSA8PCA5KSArIGxvLT5sb19vZmZzZXQ7DQo+ICAgIGxvX3J3X2Fpbw0KPiAgICAgY21k
LT5pb2NiLmtpX3BvcyA9IHBvcw0KPiANCj4gRml4ZXM6IGM0OTBhMGI1YTRmMyAoImxvb3A6IENo
ZWNrIGZvciBvdmVyZmxvdyB3aGlsZSBjb25maWd1cmluZyBsb29wIikNCj4gU2lnbmVkLW9mZi1i
eTogWmhvbmcgSmluZ2h1YSA8emhvbmdqaW5naHVhQGh1YXdlaS5jb20+DQoNCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
