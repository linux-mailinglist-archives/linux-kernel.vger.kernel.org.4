Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F767613044
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJaGZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaGZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:25:31 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2099.outbound.protection.outlook.com [40.107.127.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4F462E1;
        Sun, 30 Oct 2022 23:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke+9DSzpIpEutd6ofWwNmZGMg3W7UsvOX4mDTqq42hI+bzdXks9oJqXI2zWbvK1lg+LChCnS67+HqnztIgtnOTcjwJ4+j3wFQGtvDOznCp4mfhYBF+7By5mrztVPS00P/c2L/7akRRxeOLjBnA993RkBMCB8C2yhmhVxh2NGnSxOaihhSF3WUcXMqYpYhbbuOzvAUwvVhNfT4qQFEWxWguUOYw9cPl1yTboPqhJnnChPxpqCsbhGVf+d1PFAG+npcUabH1Uw7fruJiRhVvEQyHVUQIriTjshVq2fO3ZpMU8YNIZzXyzEIswEobGMJya1WlrcszVSPA1EscKASJdt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2dxDrJvCFMH1dKgex81/ynC88xq3bpRyw4LAlF36d0=;
 b=lBoaAk2mQeo+miTSov0Zsxq7pguFYjrrQ94uIXMWCumi0qgFNpuQNExFjQKUI4V6/9o1Sz/HTIN4Q+1s8+XZeJ3x9nOF4n2pxD0j1K+gc/8iZyEiYGLVAQfKJRZbN0ri25XymOk0efeO/iXDa90uob2qn2lEdvpW4OJGsRhXKC01Dm1HbRkHKzCX9BO6ScHbfcHNHmadXWeiM1wKO6czOZ652SJbba9unYQZyw0aSqKySgLDhaik3f0hSpVYiRPhyXxDJIWNj2ED7hwhdat+69RHf8Pb2FCWmRbufJIAS4xyImARPmcvpmtNNSDj9hD9EkQYNhEmt3xanqayiD1VBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2dxDrJvCFMH1dKgex81/ynC88xq3bpRyw4LAlF36d0=;
 b=QsgvM4Yyvbbdy+NeWlLSnA0Q25M1r82n+A+SJ1Otp4dMnsZBtm60AtlxTnLTLNxLofjdYHlP/VI9VppyfawR4nf9wbFyjn6b/5reDr+kX1QYQdrOX8INiAZxlItLZrGVVvakfDZ1UzVAbKcN0v/SoZM8RhwpAxAP0VfMQbyLYg8=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR0P281MB1515.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 06:25:25 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bec6:d44:3d5f:317e]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bec6:d44:3d5f:317e%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 06:25:25 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Thread-Topic: [PATCH v4 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Thread-Index: AQHY5T98AT1ReJwESECTIGmO+IYC7K4b3sgAgAEuDYCACD3TAIACzfcA
Date:   Mon, 31 Oct 2022 06:25:25 +0000
Message-ID: <65da14ca-5e99-0d2f-be9d-fac515032fb6@fi.rohmeurope.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
 <7baf3dd482ab1db0d8a3676d6d5d3e4ab7f3cf9d.1666350457.git.mazziesaccount@gmail.com>
 <20221023124316.239427a7@jic23-huawei>
 <df01792b-fb9c-017c-1feb-ee8f5d8eb692@fi.rohmeurope.com>
 <20221029123542.335f0bea@jic23-huawei>
In-Reply-To: <20221029123542.335f0bea@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR0P281MB1515:EE_
x-ms-office365-filtering-correlation-id: d30468f4-2399-4a46-e7a8-08dabb08b252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LeASjln1csaSAcjvdfGW1DsXHMbrE3dXlsj6eh9NOJezrf67SSz3+vwm+aeeD2gIIG8h6MNuhIyvkTwHjQwGx8ODpCiEKKxi8kS7Z6qx7oVvVpzD9HtEVUv46HEfEdX1LZHs+Po4S9e5JqTV9GtVkSOyPNACK75RCRpKnXt1Btv4pQVzC2ajf5h0+3SIci75LeEwadBt9aeDzYglrEXXtFwg1YjIC2Hhox3xEdoLhU8quY07WWm5PKVLCwmrJRlPY1CYAk1+UsRHY+8ovzaV8b/qQuc/b+fT4TenaksOO0pcG6FSOCNI/fV3kza7C2owUpHIAbYHnVdr6MWbaJU1hGlYg36byvQnBkWvUw8D3rhGqlNHO7VTe+0WvFs0KnA7UvUleoT5FDj5INMuvAOeUSFPR+5TJZ0wfDFrzji/YtK0p4uwVkukRJ3CQIWD03KGfeqn7S2XxOnIVRGLW09JTfOaXoegcgbdRVfII4tgP5+MypcLMc1JJG2yNlQKU3QWjd0o4jOj488fRlNW402NUVS0s/M3Y+PCvxz6cajmu0KbwAnVija7WdMU34asRj1RQjjXGgM2V22bJrAOhNlWoU5+Gtsbuuhi6lWkS0Mc8FLjMwpIK6mzm2mSY4UKsDSuxs5+5PBzZg9wJMTtIF6rE7n6/KA37mLIMU3CJ9mDuXt7jJAPNWEAHKXIZU8bDj9zBFUAydNn/2+uB1AXebuHUw7lSLK6NJ17SmXWH+pc8Nh1Gomu4ZMtCsz72dL5hcPvd16z3RqCUPVLwuyKlwAB2hsSdsosx9LEw5f1bCS32bfZz3DG6v2aqGA47zx5k4eb5oYFWZ8XEyowNGyoqaLSkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39840400004)(451199015)(31686004)(38100700002)(5660300002)(7416002)(2906002)(122000001)(83380400001)(86362001)(31696002)(38070700005)(6512007)(316002)(186003)(2616005)(478600001)(71200400001)(91956017)(6916009)(54906003)(6486002)(41300700001)(66946007)(76116006)(8936002)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3FHVFdMZXEwZ3J3dG1qSGNNNGdEbEVWL2dQQk1VOEU5enJleEpFWnRWNzZk?=
 =?utf-8?B?STN6WVVwUC9rNitlRyt2bWlNbGhXNi91bjVzMndGYUFKZkdOb0dKUXdxcThW?=
 =?utf-8?B?WE9oUkhIZmZYYThZRC9Qd25GUWtQeU15TmYvSkNzdlJXcVFDUXdtN1BkRUJt?=
 =?utf-8?B?c0NqZ3BtMlVaaCtjT1hnTlorWEllL1gvakp3VFFOZU1CWVdEQjR0ZmoyV3Vt?=
 =?utf-8?B?T0xUcUpOb3lZa0xUY2dmSUFUQ3BncVZtZGhtblF5ZCs0Vkt3WURHSlZnZUlq?=
 =?utf-8?B?emllU1ZSczgwbTJqUjJPMUVnb0xOb3Yva0kxLzkxQnI5NGV0WUg1NCtTVC9n?=
 =?utf-8?B?KzZTV0RhVHRMWlNzalpBQjljRFJBNFBDVUtrMnJURS9zSGJ6WFRxVFFHQjBq?=
 =?utf-8?B?SEhuNTNmU1c5U1FFN2FTdzRoSFFmeHF1dm5GNXZrZjN3VWQ2SW1kK0VhQUQ4?=
 =?utf-8?B?ejdNZ0dxOHdHbDFXOGdiZVFPa1FpR01kZXNiRGo2bzI4SWtaZFlDMEFVcS9U?=
 =?utf-8?B?djhIbS94V015dXJBbUVZeUlDR0tqeTRBRjFUcDRKcHFCRVZ4aWZqenloSUVN?=
 =?utf-8?B?ZXI3c1ZRYUs4S0JUd3hDeEEvdnhDbnlZUTgyMExMb3VtT2o0OG90WnJxSkVj?=
 =?utf-8?B?Ky8wVDdrSnNJWnZQcG0xZjcweVRZNjI2SkpzclEyRkNzYWdnVktsZEgvZnZD?=
 =?utf-8?B?dGRaR0dVWGZMbEhFTXI1L2tMZjdCY2FrSDEwQVhlUjFWVmYrM3g1QU9MRGxN?=
 =?utf-8?B?MFdEMlZVUi9JNTVUUmtHYWJOT203cjNxZDduV3ZMbUVETy9qRUZXbEdxNmty?=
 =?utf-8?B?SmVPbk9FSjVQMnkra1ozMmc4bDVlb0FyK04xYktvT0lBNW5uYjVPRWZseVBP?=
 =?utf-8?B?RW9WRGttZUJJUEpEMUhSWlZmTGJ1NmxTWGpVNFBYWmFWa0VEUXFoOUxTbmF6?=
 =?utf-8?B?Q1U2OUJsY1dZSWpZWDJnSU4rUlR0eDVaUS94RW5PSGpJY2djM0F2dDB2MGNx?=
 =?utf-8?B?UldzUVlkZC92V2JHbVBIVGVDUmdwVUR0dU0xcno4K2E3elYwbDRSa0I2U2dJ?=
 =?utf-8?B?NDRITW8xQTdqcW9VbkVQOHUyUU9YcjBoOVV3Z3o0NmpzNVhScndwcUJSc0NT?=
 =?utf-8?B?MThUWW5jc3NzZmlkSmc5bjZ1dGpvNEZCbW9yQ2Ntck1CSHZHNkFUNUNhWEht?=
 =?utf-8?B?aTN2ZVhTVFQxanBVWisxOFNpcjhzOXlVKzFvS1lZMEhFdWxUckF1UUVZenYv?=
 =?utf-8?B?Qm5vcmMyVHIzb3pUSmxaaURYblVTMmVYaU9SRHI3cEY1N0taQUVSbEhrK3lu?=
 =?utf-8?B?Z2owNndlVVQ2bEc5Qm5DeXJJSXVoL1Z0RGhRT2IxaVJhSTF5Y0NFbEQxWkxT?=
 =?utf-8?B?SUVoNVU1QmxKTnlhTUR4bzg5L05xQnFwbDhZYVFIRzJsZWtySFdrMm9kWkJW?=
 =?utf-8?B?eVJzU1pLU2cwMEN2ZTZ3UnZESGdNR1Z4RHZEazJkSnY3SFk2aVkxSGdmSjFn?=
 =?utf-8?B?c3Bwa3N1TWMzUHVwN2QvREd3cXhnZkRieVZxQkNaaSs3RDJRSEpSSFpZQmRj?=
 =?utf-8?B?aytPSzc0UlBnTTNreE02SnB6YzFLRTc2ZEt5cGlJWmozK2xOWTA1Vk8wMHNE?=
 =?utf-8?B?SWZaOTBScGdJSUllaklkNGw2NDVEeEJJdkRqU1FXZzRjZGpQUHp5NklVa1M0?=
 =?utf-8?B?Tmd0TVVxOSt2WEt0N1prWnRPZ21NWWZCdGVQcUYyZUZNdFFkY0ZiMEFuVVpt?=
 =?utf-8?B?eVZsUTI5bkZpYko5MW1HMUVLZ0V4Rm1EWFdSaGo2czlPRTdnN1IySTBUT3RN?=
 =?utf-8?B?cms2TFJ2VHl4c0NoSStpdHJldEZNZTU5c1hvYUY5ZnRGRHRneXZDMHRrUzhB?=
 =?utf-8?B?bEhyamVWNXgzRkMveXppazJvaFI2QVhROXJPTFlYd2V2SENNUWIzVGg0TERx?=
 =?utf-8?B?eEVCMm1RNUM2dm1SblA0WTR5SDdnekZ6eHN6QnMvU2lQWDFMbUtnYnVUc2V2?=
 =?utf-8?B?dDNBTFlXbXVwQklONDlZMHJRZHFJd095cGlUanNvcnhNTHlNQlBmWFpRbVJY?=
 =?utf-8?B?dHZJR1BTa1ltR1NTN2QyUUVHSytFTStQSzV0QkN6dUpGbkd5NS9jeC82M0ta?=
 =?utf-8?B?RVpYdjZRUi9jRkpZMXJRUytjalA5d0k2Uk9jTnhtcVRKRWIyOFBQd1E2U2cw?=
 =?utf-8?Q?vYhEFG5649QiQ57kiS8l5sI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <142FAD511BDBA44E9324692BC2EFF435@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d30468f4-2399-4a46-e7a8-08dabb08b252
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 06:25:25.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8akWtyoKcS3jz1AS4VlkWClZKdFEFMYJZTWNYtxsHQu+2YhViUJBavionbftXf+XIQGi7gKpY+/y6l9/BmW+5A2a4dKXDXTjfeFKRi1DHmg6bWmLnuQffKY/dg28MEl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1515
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjkvMjIgMTQ6MzUsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIE1vbiwgMjQg
T2N0IDIwMjIgMDU6NDQ6MjEgKzAwMDANCj4gIlZhaXR0aW5lbiwgTWF0dGkiIDxNYXR0aS5WYWl0
dGluZW5AZmkucm9obWV1cm9wZS5jb20+IHdyb3RlOg0KPiANCj4+Pj4gKw0KPj4+PiArCQlpZiAo
Zndub2RlX2lycV9nZXRfYnluYW1lKGZ3bm9kZSwgIklOVDIiKSA+IDApDQo+Pj4+ICsJCQlkZXZf
d2FybihkZXYsICJPbmx5IG9uZSBJUlEgc3VwcG9ydGVkXG4iKTsNCj4+Pg0KPj4+IFdoeT8gIElm
IHlvdSBnZXQgdGhlIGJvdGgsIG9ubHkgdGhlIGZpcnN0IG9uZSB3aWxsIGJlIHVzZWQgYnkgdGhl
IGRyaXZlci4NCj4+PiBOb3QgcmVhbGx5IHdvcnRoIHdhcm5pbmcgYWJvdXQgdGhlIGxhY2sgb2Yg
ZmVhdHVyZXMuLi4NCj4+DQo+PiBNeSB0aGlua2luZyByZWdhcmRpbmcgZGV2ZWxvcGluZyBuZXcg
ZGV2aWNlIHdlbnQgYWxvbmcgdGhlIGxpbmVzOg0KPj4NCj4+IFByZWNvbmRpdGlvbjogVGhlIEhX
IChhbmQgZGF0YS1zaGVldCkgZXhwbGFpbiBob3cgdGhlcmUgaXMgdHdvIElOVCBwaW5zLg0KPj4g
MS4gQm9hcmQgZGVzaWduZXIgcmVhZHMgdGhlIGRhdGEtc2hlZXQgYW5kIHVzZXMgYm90aCBJTlQg
cGlucy4NCj4+IDIuIFNXIGVuZ2luZWVyIGZpbmRzIHRoZSBkcml2ZXIgYW5kIHJlYWRzIHRoZSBE
VC1iaW5kaW5nIGRlc2NyaXB0aW9uLg0KPj4gMy4gU1cgZW5naW5lZXIgd3JpdGVzIHRoZSBEVC1k
ZXNjcmlwdGlvbiBhbmQgaG9wZXMgZXZlcnl0aGluZyAianVzdA0KPj4gd29ya3MiLiAoQW1vdW50
IG9mIGhvcGUgaXMgcHJvYmFibHkgaW52ZXJzZWx5IHByb3BvcnRpb25hbCB0byB0aGUgYW1vdW50
DQo+PiBvZiBleHBlcmllbmNlIFhEKS4NCj4+IDQpIFNXIGVuZ2luZWVyIGdpdmVzIGEgZmlyc3Qg
Z28gdG8gdGhlIHNlbnNvciBTVyBhbmQgbm90aWNlcyBldmVyeXRoaW5nDQo+PiBkb2VzIG5vdCBq
dXN0IG1hZ2ljYWxseSB3b3JrLg0KPiANCj4gQWggYnV0IGl0IGRvZXMgIndvcmsiLiBXZSBzaW1w
bHkgZG9uJ3QgdXNlIG9uZSBvZiB0aGUgSVJRcy4gIFRoYXQncyBub3QNCj4gbm9ybWFsbHkgYSBw
cm9ibGVtIGFzIHRoZXJlIGFyZSBsb3RzIG9mIG90aGVyIGZlYXR1cmVzIHdlIGRvbid0IGZ1bGx5
DQo+IHN1cHBvcnQuICBOb3QgdXNpbmcgc29tZXRoaW5nIGlzIG5vdCBub3JtYWxseSBjb25zaWRl
cmVkIGEgcHJvYmxlbS4NCg0KSSBndWVzcyB5b3UncmUgY29ycmVjdC4uLg0KDQo+IFNvIGZhciBJ
J20gbm90IHNlZWluZyBhbnl0aGluZyB0aGF0IGRvZXNuJ3Qgd29yayBiZWNhdXNlIHdlIG9ubHkg
c3VwcG9ydA0KPiBvbmUgSVJRLiAgVGhlcmUgbWF5IGJlIGNvbWJpbmF0aW9ucyBvZiBpbnRlcnJ1
cHRzIHRoYXQgYXJlIHRyaWNreSB0byBoYW5kbGUNCj4gb24gb25lIElSUSBsaW5lIChvciBtYXkg
bm90IGJlIHN1cHBvcnRlZCBhdCB0aGUgc2FtZSB0aW1lIG9uIGEgc2luZ2xlIGxpbmUpDQo+IGJ1
dCBzbyBmYXIgeW91IGRvbid0IHN1cHBvcnQgdGhvc2UgYW55d2F5Li4gIEFkZGluZyBhIG1vcmUg
aW5mb3JtYXRpdmUgd2FybmluZw0KPiB3aGVuIGFkZGluZyB0aG9zZSBmZWF0dXJlcyB3b3VsZCBi
ZSByZWFzb25hYmxlDQo+IA0KPiAiRmVhdHVyZSBYIG5vdCBzdXBwb3J0ZWQgYXMgb25seSBhIHNp
bmdsZSBJUlEgbGluZSBhdmFpbGFibGUiLg0KDQouLi4gYW5kIEkgYWxzbyBmdWxseSBhZ3JlZSB3
aXRoIHRoaXMuIE15IHRoaW5raW5nIHdhcyBzdHVjayB3aXRoIGVhY2ggDQpJUlEgbGluZSBoYXZp
bmcgYSBwdXJwb3NlIGZpeGVkIGJ5IEhXIC0gd2hpY2ggaXMgbm90IHRoZSBjYXNlIHdpdGggdGhp
cyANCnNlbnNvci4NCg0KWW91cnMNCgktLSBNYXR0aQ0KDQotLSANCk1hdHRpIFZhaXR0aW5lbg0K
TGludXgga2VybmVsIGRldmVsb3BlciBhdCBST0hNIFNlbWljb25kdWN0b3JzDQpPdWx1IEZpbmxh
bmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28gdXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMgY2FuIGFsd2F5
cyB0eXBlIDpoZWxwISB+fg0KDQo=
