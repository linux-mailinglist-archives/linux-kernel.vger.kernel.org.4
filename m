Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309F85BA749
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIPHQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIPHQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:16:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCFD95E7F;
        Fri, 16 Sep 2022 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663312564; x=1694848564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r2U1BIZ65EgjZybRs0BxH54M66o7w6jK84GIkwKHQeQ=;
  b=DHbkAcgxA1lGw//lXKinX8mxX/vIGdIdV8+bxCjgo6lxb3gHJYT31nUg
   VdF6N75wp7fvTMijJFAr9HM9jyy4OR7jEqDbJiaNisvl0QTPaXIrJ1Rcu
   +a+5JlyfFPM6lC78FFaFXqrn3+RJZLRMhY0mjWIxH8EDk7Qvyrr6qchWC
   UdVreZTV1uGE75+1aH6AGfmwFK36uOzz+CoEmcLF6qODTOTDrxKyafoxY
   F0HRn+3RugTvPN0vWMMXd3plxBWDTuSZjXSAso2E5QM1n2vx+w/aSUW9W
   bMzoFscU8gifuv2aMbZbQyBoR0W+EzQHc5YAH0D8YTwAPYTWY/3c/8wZl
   g==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="174158524"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 00:16:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 00:16:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 16 Sep 2022 00:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GO4RALI457IqCF4iWczRY1WZJ7L3EsljEb5x/cS8FcSDviUTxTAS5oLCP2L4SL0NBe77W+zvzm95juCiYP4Wekd9L4s9eOeNraFcOAIvUpUvFhlIFZO9WVbBeFNj3Il8uCTrpIi27odMGduB9YnaEfV1YDvpUAJxhQEaKYgqKlmNIAGDBcnrDHQgmRxs1BRU4TcFCtx64KWOM/HyJPp/JczRqHOn/7VnyTitOpfQH8cW1bwa7MbcXwn4240AwAEmjNdLJS1qAZE4KebFrRxl6dJst9UlsxGxFJPd/If9ZN+QVqYcTyIhKhyQ6wIZnPyveo8hHfMr+OrYooymqLY4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2U1BIZ65EgjZybRs0BxH54M66o7w6jK84GIkwKHQeQ=;
 b=Awd0bkoCVMybK9flmJ5OB53z2kQ19rDS4uKpiX8Z9VVWzMg8OTQo/3AhDN7N+S43Z/ea814ogJ/WXrkc8BFDqZEsT8H3pc3Q/0LFmEqSnevpZMDPJ/UpwLruQu7nRcKQgRgneydnjbwDqA4wGhIzVpAuLI9P8sP/Twvzv5tJYyZVaj/7L+PTEiZXKTa+/JFbrYHPWH2icK6NIYm+/SqeqY3L/a9ok0f3UigwltAv3WqjNicnJv0PK9uaq7xOHSa4YoOKq04/qbMMM6LDvqMKkdjt38zp9EPSowvYIc0JVW9B9+y4sotGfNWYk2XAK+pgyqGJStuoqJk1rbRVVRnRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2U1BIZ65EgjZybRs0BxH54M66o7w6jK84GIkwKHQeQ=;
 b=qhbJasyIchfVDG9N8eqhj9Ub3UKTq2YTjnQXLMKCKahkW/+f3IlqwyeF0u7wQ3Dj3rt9fJzK1kbsrMSH1DnbpSPCmCLCsKL0lUIAi+f0PxY6BxBwk4EHvfHTNTMFO/9d/VSWha9GEcP0gh91ZT+wV3S3e3DodVG/TKIrCE9OkcI=
Received: from PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18)
 by MW3PR11MB4715.namprd11.prod.outlook.com (2603:10b6:303:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 07:15:56 +0000
Received: from PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::3782:ca8d:1fc0:d1c8]) by PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::3782:ca8d:1fc0:d1c8%3]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 07:15:56 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <Sergiu.Moga@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <robh@kernel.org>
Subject: RE: [RESEND PATCH v8 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Topic: [RESEND PATCH v8 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Index: AQHYyOfjSotc/P5AA0O6jif8i2w8Wa3gnvSAgAAAbwCAAQa4YA==
Date:   Fri, 16 Sep 2022 07:15:56 +0000
Message-ID: <PH0PR11MB48724AC25623EDE473FEE2E492489@PH0PR11MB4872.namprd11.prod.outlook.com>
References: <20220915094453.1872798-1-kavyasree.kotagiri@microchip.com>
 <20220915094453.1872798-2-kavyasree.kotagiri@microchip.com>
 <522952a9-e413-a042-5e76-54329758712b@linaro.org>
 <15e029f2-874e-a83e-e58d-72e42d0a4c89@linaro.org>
In-Reply-To: <15e029f2-874e-a83e-e58d-72e42d0a4c89@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4872:EE_|MW3PR11MB4715:EE_
x-ms-office365-filtering-correlation-id: dea6a826-c980-4afe-ad3a-08da97b34c9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c4tSicr2rT63eHremqtvtUeMdOrm275KVYPGqNINjg2ii3Y4/wrqIT0j61peFM/AtU8tJqNPvqzlziMc76vP89Fe45zcuOvJFQYai82vnW/XlRCfkSw20UMzm2eYqyLOMZqAn/y0SwbmixoMev1wVORE55kJbHgNLPAakwrGUqnfdmn+WYmk3OuVd2QB56AwRM7Mm8E73Rv47uBUEDJqM1hVLIPrGkE1rhD7LDbVV5/Oi8QT8gfkShZLasSqNqYO7XKm9ABJh9hNm4tKCro8bp7sELZ3A9vkhVOiE8cpvyq5Y+gQ/hHeTVQ5TD8qhNPBdYRBLvjw278JXy3sr6bfwh9bD5xnexCIwxWT9fvh32kVhiWdgX1+rElQSohxU7cj7m6xg9H2KQpg9OqzZc4nFgVyNHYEVvSBH9bZRjQ7l7I+4DDJeKP5S4kn53TkYHMG6mRp7kkxGThivKd6tWQ7GKpqB56zMD7t6f2FOwctfa+xzg9+495JR+hf4m0WliTydn9bnoRs3HKwqPKmJSIQvFn4TQRyVokzw6tb2q+SKzn7DuO8qSN/loOUCtzkoBfuKUQEm4aAwsOk1NUtz9XtHmnorcZ1DAC/Ob/p+60StcnAWhegKKwLSShNvv3sCboWc+2Szp2KwSBp4Zb8PRknGHMIMpUz8476uMsPrz+EbzJHFu9kIzy+SzaSHptc7W2XSHA5nX0TnDe7wGbaemvS2eIaSFWXr9aZM/jqZCr9rbBelQIMbnfU7Cmw8F5YTq7So9/SX2207ahXQKf4fqHNDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4872.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(38100700002)(8676002)(7696005)(478600001)(110136005)(71200400001)(54906003)(6506007)(316002)(38070700005)(9686003)(2906002)(186003)(83380400001)(4744005)(4326008)(26005)(64756008)(66446008)(66476007)(66556008)(66946007)(52536014)(5660300002)(8936002)(76116006)(122000001)(41300700001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T29jRkZheEtLbWZIaEdRaG1DdnhuK1NkUDVYNkNacHhncnp6L0FCZG9lR2Na?=
 =?utf-8?B?WTNKTzhacWNVL3l6bE5YS1hHWElxNnA4LzZrWlZjenVTVGt1aVlVbENCRHJq?=
 =?utf-8?B?cFFMMllEazZ2NjdVVkxBaEYyblRhUkI2eUhYSDhjWHRGcDcxa2IzZEZMMWhZ?=
 =?utf-8?B?UXhBTUlOcWlSUUNJbFZRNVFXSVhpY0NpUkNRekZpaXFzT0p5cmlqQ29QZnoy?=
 =?utf-8?B?TWhmVmtKTGx4MytPUDZ4NElQTUw2MXF0Zm92TmhSdFJhS0M0T1V5aE52Nk5C?=
 =?utf-8?B?Nk1TWXdDT3JjTDVyMEg3Qm5MdmErZW9HOEhwNi9ETTdHVlJlbkdXT2R4N29C?=
 =?utf-8?B?YlBySjNIaDlXV28vWjNmU1p5N1pyMTZvTDlraDcyV1VzemJyQnhId3R1WmRF?=
 =?utf-8?B?bS8zZWRDemUwZ1pzTGZtTE12UDRWRXhvQU4wdlRRaWI5S3QrT2xmU1J3VUxv?=
 =?utf-8?B?bGNFWmFzc0JIVnBSbXQzWU5CY2NKWkJCSmIyWVdaRzR6OXB6V2x6eWRtM29s?=
 =?utf-8?B?QnJUQjB4MlNUa0RITEk2dEp0a2ZMa0Y5TTMwelRRQnVPekQ3ZkJieXd1dGNO?=
 =?utf-8?B?cEVwaFpMdXVzTXpzOElrM2MxOXI4MzZqLzRzZ0xjdTQzTDV2enNZbWJOOXE4?=
 =?utf-8?B?MFFPa2FHOE82bTY0LzJuVG03bERHWUM2Rkl4MDVoc0lhZktJdHV5dWZZa0pV?=
 =?utf-8?B?N01wTTl4Sk8raURWNnFFMkxYWTd4bFlRMjV3RXFLbXpNbjVSSElua1R1ZkVV?=
 =?utf-8?B?bUNqMURpTUhoa295WnRPYndDUmovRHpmSkdXTjNvY2l3dmJQSmJpSStjY0lL?=
 =?utf-8?B?NjJlanBuWE53UDdnaitPd1NhQk9KbE9rVjd0TC9PbTJxZCtkL24xWmY4RXFv?=
 =?utf-8?B?dGNHN1BYcFlSNjJtcFJISC9Nci9EaUtyMTdwam9aaDI4K2F2MHJ6Z1RhZVZ1?=
 =?utf-8?B?RjgzcnpNTlovU1JLZHlPWUxvdlV5U093dFVDSlZDdjYxcUFBcXZ0TnhSWWxr?=
 =?utf-8?B?ZmVVdE1pdjlhd3VMdFZmUEVRSmFhcnhmcTAvaDB0VjFkU0tQbzVXV1YvSUs1?=
 =?utf-8?B?MjlLQVF5N3JtYWgwZ2ZZeDd1aFYyTGJ4eVZ5QlFTYTZVNlk3QzF4YUtIRWJT?=
 =?utf-8?B?emJ0Y01wY041cDVxdWQ5aVBKbkJVbW5uVzdPanJWSWorVURxaUhGYjZzSzdu?=
 =?utf-8?B?N1ZSRHRzVVhnaVRHaUF3eS9PRG40MmgyZjYzTVlBdStTS2p0SmVWYTdFK3Rz?=
 =?utf-8?B?NUV3QW5jQ3dlY3R6KzVPZmF6ME9BcTdjNEQxZFhVTUNJQk0xcEoySkpsVFp1?=
 =?utf-8?B?Ri9yS09HaU5qNll6bnpyVGpIdTdDWmI3OGtvcDFzaXRuN2RxVUUyMlFoUGtU?=
 =?utf-8?B?RVd3NUprTE95cmpRL2hLMTlEYVkvTFJjekJ5ZTNrbm8yWWRkV3F0S2lJSzEr?=
 =?utf-8?B?dnJ5SFFlWkNuSlgwMnU5MktNbU56Z1dPK3hwUXVFMHIzWnFvaFMybGk2WHg3?=
 =?utf-8?B?Zks3WHRVaFFRNkdsOVNpNjdPemFxb2k0WkZ5ckNNVTdGaVVsbWk0MDdER1JG?=
 =?utf-8?B?cSsxNXRiOHBYbHJwdlRGQWU0QUJaNllqeGFPaWJFSjA3S1dSMFp4Y0xPZXF2?=
 =?utf-8?B?SDM4QmhNaExBdDRMZXhGSHA5cmdzWjFtRUNRQW5SZ3Y5bm1kcFFIVWJBWFFi?=
 =?utf-8?B?M3BEMzk0VTZpN2RsTFdVb2trdEEyZGVvb2NwOFVwaUVMcjZDSDlENCtId1hl?=
 =?utf-8?B?ejhKUVdlbkJlL3M3dGhsNXpxb3NzamFxWXEzdmpKdU9VeGFYRzF3MnEvTnd5?=
 =?utf-8?B?M0p5R3FYUHl3N0hpa0RLZ3VHU1pkRmhkZmh3a2pDNHFNYUhzZnBadUVBdmlI?=
 =?utf-8?B?T2U2SUF2NXYrc1NrYlp0RmFwYWZEK0NOTDdkSkp3KzB4NlBOV2lLMmxxcmJC?=
 =?utf-8?B?b1lBYUJiNkJscE9vYkVNbTg2RytRN3IrdEtCb0lyNGVKMHdnOVlSQzlJaHRO?=
 =?utf-8?B?Z1BJZ3FSWUh2YXNsRExFZ2ZEbm5MeTdRS1dFaE5mWHFNWmZ2ZDJzZko4QTJG?=
 =?utf-8?B?ZFkxUDZRVm10di9iaFhtR2FPVWxGL1A3VTQ4dEpvbXJNQlJJU2Z1YkVIVFlN?=
 =?utf-8?B?UUorZ0xTeHM5amVjN1pVYUlYR2Y1UGxueGxZejVhSE1Sa3lSYk5TZjYxekky?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea6a826-c980-4afe-ad3a-08da97b34c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 07:15:56.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHq/Z+eTXAqXVmF2bE6VIFA7bQsF4AtvIiOUS55oU4ACGs48m0Llp83wG2h2f/xYPhmWgQhwRgwOEpZTQKOBmzKKqQxaTr3TzBmcTn7G/OZYKqCwhmJR2WKVLdTOq/pB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4715
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiArcGF0dGVyblByb3BlcnRpZXM6DQo+ID4+ICsgICJec2VyaWFsQFswLTlhLWZdKyQiOg0K
PiA+PiArICAgIHR5cGU6IG9iamVjdA0KPiA+PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+PiArICAg
ICAgQ2hpbGQgbm9kZSBkZXNjcmliaW5nIFVTQVJULiBTZWUgYXRtZWwtdXNhcnQudHh0IGZvciBk
ZXRhaWxzDQo+ID4+ICsgICAgICBvZiBVU0FSVCBiaW5kaW5ncy4NCj4gPj4gKw0KPiA+PiArICAi
XnNwaUBbMC05YS1mXSskIjoNCj4gPj4gKyAgICB0eXBlOiBvYmplY3QNCj4gPj4gKyAgICBkZXNj
cmlwdGlvbjoNCj4gPj4gKyAgICAgIENoaWxkIG5vZGUgZGVzY3JpYmluZyBTUEkuIFNlZSAuLi9z
cGkvc3BpX2F0bWVsLnR4dCBmb3IgZGV0YWlscw0KPiA+PiArICAgICAgb2YgU1BJIGJpbmRpbmdz
Lg0KPiA+PiArDQo+ID4+ICsgICJeaTJjQFswLTlhLWZdKyQiOg0KPiA+PiArICAgICRyZWY6IC4u
L2kyYy9hdG1lbCxhdDkxc2FtLWkyYy55YW1sDQo+ID4NCj4gPiBObyBpbXByb3ZlbWVudHMgaGVy
ZS4NCj4gPg0KPiANClNvbWVob3csIEkgbWlzc2VkIHlvdXIgY29tbWVudCByZWdhcmRpbmcgZnVs
bCBzY2hlbWEgcGF0aC4NCkkgd2lsbCB1cGRhdGUgYW5kIHNlbmQgbmV4dCB2ZXJzaW9uLg0KDQpU
aGFua3MsDQpLYXZ5YQ0KPiAuLi4gcHJvYmFibHkgYmVjYXVzZSBpdCBpcyBhIHJlc2VuZCwgd2hp
bGUgaXQgc2hvdWxkIG5vdCBiZSBhIHJlc2VuZC4gSQ0KPiBhc2tlZCB0byBmaXggaXQsIHNvIEkg
ZXhwZWN0IG5leHQgdmVyc2lvbi4gSWYgeW91IGRvIG5vdCBhZ3JlZSwgcGxlYXNlDQo+IGtlZXAg
ZGlzY3Vzc2lvbiBnb2luZy4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
