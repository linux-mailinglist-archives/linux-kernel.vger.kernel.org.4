Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD66D6E7690
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjDSJmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDSJl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:41:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A1F1BC5;
        Wed, 19 Apr 2023 02:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUAdvd/AR9YgdE5MHIxwl6V1uP5CP/gRIXmNYpqt0kJ8YQ1wBdigV3uEJRrR84bNmjnPVsJFhTejk9f1JpZxhJKqNWs2M/D5/WfcUddVaVvjv3WYamu9TvgNTSIJAQQEBBWKuIxSOhYKh5ZN+shH1dpcRmxPZkVbTEmTcCGrSXLzPChS+1O5MqiWlroh+BG6JY0f5jvFmIZS4gQYE4nac6fzW/VlOONgOvwZXjWmTQgIblbPWH4ReJLG8kJ8ajq66oTpfmCzn9FKz4qFHjViW2epXAL9XgEEHivMzeiEoHHcO48pG5rYfTBzx3xT5GBH5RHHF72tWaU9sR6ES5rRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJiNBe8wuin6Xnk/CuRX01gzk1fCG3OJZ1LQof6LznA=;
 b=U5GH1SSPuCaR3T4t2JFBIIHDmQafeQld9eBEtfMi9FiZAAAGdgQudQqJ7D+khfnacQddVdov5/7QkUtv9YT93LIUSb0tyjgWFBS2RbQHvzZdrGreGmkzQWrCqk9snU0eLUGwJ3iRG2o2LvLECjYBb0YI4w3kTRSeKCep+LPMzqIeZ951+09Dw+Ui128ZKp4cNRhXdngkvU4NWf6FmB/misWLliKx3rtZHI21yzs22aHW0mUquPlnlSyT41SK5XEwS0sjREMX83+v2TTzpbgty6xRGwyPSL/1JfETFdBqiuIe4dZ4n3S/30Li5JgGMQWOOwu0yHUSHXIm7966R6nIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJiNBe8wuin6Xnk/CuRX01gzk1fCG3OJZ1LQof6LznA=;
 b=kAxb9J+BalJBOJWMvg+Z+SJKBqLMXpuW6e053cHx/2/H5Y5yCz/kLklADZ4Q8s4RhpWorsxMq3dSiqUVIuzNemQRRmQ/XQu3kgGvOyezdL7O02+EZ6ONCQn1V4PGY4vhDMsvDYwkf4hztVcqzFIHZ9zGMVxvGaSODaRbnky1QkN/u12gV8Q2h1om4FW5aavkWmNz+kYW1Y/8bVJI0kKNBQ7Gc8wEDInFOK7a2sJ7xzzQ4mF6lu2PTYfFBKdTnpO8DABFbR4E7qOI7nbvz6jQUgeEy1p9rb0aLt8c9kGG397zOIpyQXIm9Lg+8hRqiWy2vTyEhfZ9MArgaHCkwl5WpA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 09:41:29 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::bff7:b47d:5567:71c1]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::bff7:b47d:5567:71c1%3]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 09:41:28 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Thread-Topic: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Thread-Index: AQHZcpuo2+Eqx2a4MU+xtBGjjFI9R68yYQMA
Date:   Wed, 19 Apr 2023 09:41:28 +0000
Message-ID: <dd3850e3-045f-75a0-4980-9f44a05fd397@nvidia.com>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
In-Reply-To: <20230419084757.24846-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|PH7PR12MB5687:EE_
x-ms-office365-filtering-correlation-id: 658469c0-0c02-4e59-639f-08db40ba3fe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6CuZoVYGLKH4PH24SOuDjgccACraAx+pZrhhFaYwD4ScL9i7rZ9w69FN5I5EWJukizHZudML6LvDSY0EeOvRz6rcTrTZoUTLI+8ksNA4EywRain0/MnwgZVpOqfcU0T3XUi+5/hlhJv6G78FR+gCV2YjhtaPHNf/hYdPBTAIHR4GS0ARA9uCF70jhGQ2yyZMWQI8Oc+Z4/RaP8ViGHxZJHK57NH8I6uZrkJsuELyduOuYouQw3cyxXaqV8QSF7zIOS8ox0zW/cgmnh0JdFlY9+Yp6fO/xEKQxaeLGCD+znLlYlV9Kbtl8FJtfa8GzAaaCIy7wZE4THg0gG490TMFGLdI4n5QI+UVK6qmUsT1vbSnL8TPEQi7SfkkNhbK6nJHCmpd8A4l5ac3CjCesOr+oL3HKhJUx6M0LC+xr+DYxpflg3atPAuTV4DqjIepbOll0CL2DRl+4env8NTXXZNLkqh9eVhF0vkyzQuqxgG2wuybuAKhOhxooVbGmEEAbNZ20DGAfssxnstilXsBtTIphXjYKkpOTLhaGIBpOAThuZWC9f4xbfkNHEs9BQem8lF+nylrlDaSUO4MLABCDNR11CYqLMcHRW4QuB5HX5wpRKQstjKNWrK7eV5fKC2CWvMZlhfganoQaEuF/FQkhC5VBavavfjDGfcmwuckX0HDOMThTS1SXURMHVvVOSTrcSLO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(31686004)(4326008)(316002)(110136005)(54906003)(66476007)(66946007)(66446008)(64756008)(91956017)(66556008)(76116006)(53546011)(6506007)(6512007)(38100700002)(2616005)(186003)(83380400001)(41300700001)(8676002)(5660300002)(478600001)(71200400001)(6486002)(2906002)(36756003)(38070700005)(86362001)(31696002)(8936002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djhQVkFrY0ZpUnFSemJYTFhrcHVBQXNXdzQvMzJNdDlsdDNFckkwY2gxWUdq?=
 =?utf-8?B?RktNRVMzVGQ1dlkxbkJieDF2UzM5VkhwNUQvWjByU2tSWWhZRVRvbzl5M0o1?=
 =?utf-8?B?ZlNCR3Rkb0RTYnkxbUdVbVlDSGQ2TnVRUnhZYTRQemd2N1d5SXB5cTNrUk5r?=
 =?utf-8?B?YkZsclVOV1F1N1k3ckp2SDIxOUp4ZVBjNkI5N1FIR1A5MENHK0JEQlJoZlJI?=
 =?utf-8?B?emhBNFMvNnM2aVUwU2hWYS9rc1Vabmh5bWlIR0JTZ1N3SGZNUWtOK2R6MVB3?=
 =?utf-8?B?THV2SmM1U1FvRDBuT05pRThYdUwzNDhsRnpQUER4dEdvK24rUzNYT0phS1Bk?=
 =?utf-8?B?Qy9hN1pzRytNc2txeWRYc3pTc0hLR3VFRmZwdGw1SXZKc01rZlRaNjVlSUR0?=
 =?utf-8?B?akZYeCtmbkh6WTNVUFJ4UmxNWFN2SDJmSmxkMGRSVUdwdlFtNWJpc001bjBV?=
 =?utf-8?B?ZXY5QjdlcmQ1bC9mSjJDd2c3a3hrUU95WnorZE5kb3J6VnRORjAxb3g3N3RV?=
 =?utf-8?B?TysraWk5aXk2Z3FEeTQwd3NMRjBQaW96akcrV3FnWjhRclRySmcyMnJaMEFq?=
 =?utf-8?B?MEg4ZEtPTUc2cjdCMXh1b1VkSUw0NjR6TURCc2ZrY1BDaEdzNGlPZTV0YTk3?=
 =?utf-8?B?STNiaTdTSC9JZ2pHaEhnVWdoU1pKL3JaRjhsT3Q2VGVpZzlPQ2wzbTR5QUM2?=
 =?utf-8?B?bzhhUTlqWXJxYXE4Q1dhUHpOMHpSN0RGdlgwTmplY0dxTjdzcVhOSDdHOTF1?=
 =?utf-8?B?emJ3U3hIN3BncTRoZzZNWmNrZXJvbHlFKzZQaklMOTkvWWMyUXJSdzNzdkdu?=
 =?utf-8?B?N3VLTDRWS3czSHlOOXBHcFpBYTVQYlh0azZmcnBhWVZuRER4L094TmtwbnR1?=
 =?utf-8?B?enVaZU95R3QvWVROYTFZcU83TGY3Z1doU2ZMdGVDYW9XOGNkSmhjVFh0R094?=
 =?utf-8?B?QUdHaU5OQngzclNTb2hLTkNXZjNHOGhNR1FwMTVOZkRuZXZFN3Z1Y1BoUllI?=
 =?utf-8?B?TWVEQ3h5NlVFYlpTZ2tZeVFjVXV3Z0wrb2pINFBMamc3SDFnM3l1TUJWL2tG?=
 =?utf-8?B?MWs3QjZCTU5MY3Z2Y1M0RHhFVjVMMkpYellwNmc1bU1XSFh6a3lodUN5czJK?=
 =?utf-8?B?akhON3ljdlRNcVNoMHpxQU5VMUFBWE9OMGJvSEJ3b21WUStzc2wvVVV0UGNy?=
 =?utf-8?B?T0lERytvUEhWRUc3dE9OcytPOERQdEZScy9qeHZ4VnY0MSs0RkhENlNDS3dG?=
 =?utf-8?B?ZFBQenFIYlNzK0NHWkVnOXVSNUdCdS9tUGtqQXZSalBvSUpnYzhkVTMyWUVi?=
 =?utf-8?B?eU5JSWJWWUdpWWs2WC9kdXlVQkxjSXNqTVFUTHJzQVlvNHNDUTVLdUxmUmFI?=
 =?utf-8?B?emdrWVRIdDRQcTNhTE9VU0owYUVQQ1NQRytCTXZSQitKK2ZuSEtLbUJWQWQ4?=
 =?utf-8?B?ci85dGlZQmRBU0Zvb0JySWt3MWNPWTlvdlBDbkQ0a2hrdU5IVVd5eW9TdG94?=
 =?utf-8?B?Qk9VMWovcVowMWQ0K1labHVuSWNua1N4dlMvTEVOY2NiQTRFenNWa0FrNlBj?=
 =?utf-8?B?ZXM5TWlWSUd2YXI1dWh5N1RnWnBXSjdaQUtrOHVWYWRlTmxndU9qdzJBa3Ix?=
 =?utf-8?B?M0NodWYwRnZOQ0IrNGZSNmJXa012ZGM5ZDVYakVjQkdNSUtXNTVJUE9vRUp2?=
 =?utf-8?B?QXAxWmV2QmoyRy9kaXBsWFp6b0RvakREVHRCcXFyZGoyZk9uM1hObWpUaTFV?=
 =?utf-8?B?anhvWHEzOFBzbnhMWHZVeHZnKzVmZmFlVDE4OXl3WENZc2o3OEZ4aGI1alNx?=
 =?utf-8?B?dXhHR1AxYnhVaHh2WGdCUEY1M0FzQWNBUlg1clFFTzJyaDh0bnVWTWhvSXRV?=
 =?utf-8?B?NzhMMmx0VTNCaVNXRnU3UGlBK25FWHQ2RFVDMEFXS1BWb01YMTdWbEdtSGJD?=
 =?utf-8?B?Q1ArWXNheDFmeFllb2E2c0hvR3p6dGhiL2dsMkMwSUJTcDFrYlZrWVE4d0Rh?=
 =?utf-8?B?V1Jiak1oN01JYlBjeWFhZHJsakJ2emRtK3lqeGhmVkNleU1GVlZNR1ZvdkI1?=
 =?utf-8?B?c2p4TFoweU9sYXd3Tm43MTBqb2tqL3VBNzVudFEyRWRSdXYxejhETmYxY24z?=
 =?utf-8?B?bytOeXFUZWFRbFNwS3Q2eGtZelRmMERLVENITnFOU0xuLzNDREV2SitXRlZy?=
 =?utf-8?Q?9Bt6UCncX9pgJAw3HJjPflGPMenMhTu8YVgfbSR3k4pN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C125D47E9C0B244DAF68B9F7464F3ED3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658469c0-0c02-4e59-639f-08db40ba3fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 09:41:28.2778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HU/1SqvX3fBJuGJ+1lcUCYUKrOx4ZOmlo/erN0KZrxxvwIZSHX5ihXONPMoNVMtOdUoilUdUJF/XyC2Re8No+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOS8yMyAwMTo0NywgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gQmVmb3JlIHdlIHVubG9h
ZCB0aGUgbW9kdWxlIHdlIHNob3VsZCBjbGVhbnVwIHRoZSBmYyByZXNvdXJjZXMgZmlyc3QsDQo+
IGJhc2ljYWxseSByZW9yZGVyIHRoZSBzaHV0ZG93biBzZXF1ZW5jZSB0byBiZSBpbiByZXZlcnNl
IG9yZGVyIG9mIHRoZQ0KPiBzZXR1cCBwYXRoLg0KPg0KPiBBbHNvIHVubG9hZCB0aGUgbnZtZS1m
Y2xvb3AgYWZ0ZXIgdXNhZ2UuDQo+DQo+IFdoaWxlIGF0IGl0IGFsc28gdXBkYXRlIHRoZSByZG1h
IHN0b3Bfc29mdF9yZG1hIGJlZm9yZSB0aGUgbW9kdWxlDQo+IHVubG9hZGluZyBmb3IgdGhlIHNh
bWUgcmVhc29uaW5nLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVy
QHN1c2UuZGU+DQo+IC0tLQ0KPiAgIHRlc3RzL252bWUvcmMgfCAxMiArKysrKysrLS0tLS0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvdGVzdHMvbnZtZS9yYyBiL3Rlc3RzL252bWUvcmMNCj4gaW5kZXggZWMwY2My
ZDhkOGNjLi40MWYxOTZiMDM3ZDYgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL252bWUvcmMNCj4gKysr
IGIvdGVzdHMvbnZtZS9yYw0KPiBAQCAtMjYwLDE4ICsyNjAsMjAgQEAgX2NsZWFudXBfbnZtZXQo
KSB7DQo+ICAgCXNob3B0IC11IG51bGxnbG9iDQo+ICAgCXRyYXAgU0lHSU5UDQo+ICAgDQo+IC0J
bW9kcHJvYmUgLXJxIG52bWUtIiR7bnZtZV90cnR5cGV9IiAyPi9kZXYvbnVsbA0KPiAtCWlmIFtb
ICIke252bWVfdHJ0eXBlfSIgIT0gImxvb3AiIF1dOyB0aGVuDQo+IC0JCW1vZHByb2JlIC1ycSBu
dm1ldC0iJHtudm1lX3RydHlwZX0iIDI+L2Rldi9udWxsDQo+IC0JZmkNCj4gLQltb2Rwcm9iZSAt
cnEgbnZtZXQgMj4vZGV2L251bGwNCj4gICAJaWYgW1sgIiR7bnZtZV90cnR5cGV9IiA9PSAicmRt
YSIgXV07IHRoZW4NCj4gICAJCXN0b3Bfc29mdF9yZG1hDQo+ICAgCWZpDQo+ICAgCWlmIFtbICIk
e252bWVfdHJ0eXBlfSIgPT0gImZjIiBdXTsgdGhlbg0KPiAgIAkJX2NsZWFudXBfZmNsb29wICIk
e2RlZl9sb2NhbF93d25ufSIgIiR7ZGVmX2xvY2FsX3d3cG59IiBcDQo+ICAgCQkJICAgICAgICAi
JHtkZWZfcmVtb3RlX3d3bm59IiAiJHtkZWZfcmVtb3RlX3d3cG59Ig0KPiArCQltb2Rwcm9iZSAt
cnEgbnZtZS1mY2xvb3ANCj4gICAJZmkNCj4gKw0KPiArCW1vZHByb2JlIC1ycSBudm1lLSIke252
bWVfdHJ0eXBlfSIgMj4vZGV2L251bGwNCj4gKwlpZiBbWyAiJHtudm1lX3RydHlwZX0iICE9ICJs
b29wIiBdXTsgdGhlbg0KPiArCQltb2Rwcm9iZSAtcnEgbnZtZXQtIiR7bnZtZV90cnR5cGV9IiAy
Pi9kZXYvbnVsbA0KPiArCWZpDQo+ICsJbW9kcHJvYmUgLXJxIG52bWV0IDI+L2Rldi9udWxsDQo+
ICAgfQ0KPiAgIA0KPiAgIF9zZXR1cF9udm1ldCgpIHsNCg0Kd2VyZSB5b3UgYWJsZSB0byB0ZXN0
IHRoaXMgd2l0aCBSRE1BID8NCg0KanVzdCB3YW50IHRvIG1ha2Ugc3VyZSB3ZSBhcmUgbm90IGJy
ZWFraW5nIGFueXRoaW5nIHNpbmNlIHdlIGFyZSBjaGFuZ2luZw0KdGhlIG9yZGVyIG9mIG1vZHVs
ZSB1bmxvYWQgYW5kIHN0b3Bfc29mdF9yZG1hKCkgaW4gdGhpcyBwYXRjaCAuLi4NCg0KLWNrDQoN
Cg0K
