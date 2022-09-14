Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E55B806B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 06:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiINE4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 00:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiINE4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 00:56:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F372659FB;
        Tue, 13 Sep 2022 21:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663131400; x=1694667400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fwagBTHl1HNcBiHWjycpfa8kumFC1CBoBE8ys/L3RMs=;
  b=Vr49tsV/69IUrCwqYmW93LX5Ee0yz6RLVXJmdF5+CdRyPFJCV1kVOSsL
   6EDyLCAzA30XcpKng/QtpKzk24tVevwRCtaXFB2i649UGIWwDRwzPJcDm
   UxZbmzU9SeLP5gWKMdesOic+2qWt1884ivb4K4i4ur9FppxCD53fxy2+g
   eyn8hVvadXUCeGkc5sej8znPymy5Kz76hi3KL0LGv4XFuyjxmsP/C64Ov
   jk9ynp6j5eq5tj+WkDbJWSj3Sh5eTbIzJH7hwnyZZuFksC00TlBzNBeGa
   jR0ilgIftqS3ZBiIczINzhYmRytUW+QzlJ1bUMnBzQFkhSJH/Qp2Qc3DG
   g==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="180302226"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 21:56:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 21:56:38 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 21:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHOl3CMZYfYCn/bo/g6d6iv/VDJY72rxOU2komSxQo5aJBtMZtPwToJHZS27UEiAa82gMfudFlIHTq8Qxh0nwBsp2tfx7KEyDztcukAIJkZchzaz8sRwiFrg/ijGwJjZ84LNO5Y/vML3+XmZzXQ6Fs76cOIYuEtjvLRlwCtUIpW+b5ryJ90KKwTWupy3jXIWsFkI3ski/q7mApsmE0q+CGdW/dwVoHOsou+Dmki5PexmGwbtmEJsBTIAbddI4BHn+3xltnRHGn3LER/rDIFfmhau6+cgPejj0NNnZx7Ym+pyV4a7VxvDvfrq3KUG5fx9fFRWcPmMKqfsBAeF9PejeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwagBTHl1HNcBiHWjycpfa8kumFC1CBoBE8ys/L3RMs=;
 b=jaHWoWPkWD7eG6YOxjjkvKoUoyurF2pM9Uz4nh9pyZnn1MMnfg7Xgwy9pyAvV8V8USO0B6e0k/JCp6p4vgzv7mNJfxcd7XzD2mNfBA0l3t0NJrPBWnbgIwBkNcOR6H5gELkRVb3x8NsFwCo0djOqGOgKl50u3lho4xXTMzh+eMmtpzFcvGBRiC6BiT4Mk51A4/ZylHxNdgyTwSHqZrenEY9IauJQCEw/hY07nfG8u5CCuTtEQQH34n8RxO2aR1Da2mE2gWNvcMzBCl5uyYA1OYjDVK3v8RemZ7qqxcRu1dIi8oCWUWA1iKFI9r2oPcsOK1z6asc9FA42wAHaPup9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwagBTHl1HNcBiHWjycpfa8kumFC1CBoBE8ys/L3RMs=;
 b=WRgmBOdW2UWBjtzFS1clTp+ko5+Kttrj4tLyLtTLv57G8KV9IbuzrRl+dJKgWS9Q+oDw9yZ9Riw8cN7tPpI5hU3qXORk9bMisSAkRuFB83CGLrK19j/OAb/i/hsCnMyebVb+Udx78moFrEKiah3l62YuP1Z+cBQsg/9/oHRWbmU=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by SN7PR11MB6601.namprd11.prod.outlook.com (2603:10b6:806:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 04:56:33 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f851:80cd:172b:4b1c]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f851:80cd:172b:4b1c%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 04:56:33 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <lee@kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <robh+dt@kernel.org>, <Sergiu.Moga@microchip.com>
Subject: RE: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Topic: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Index: AQHYw5S351ZiP2+bvEqYZuXgNIsbDK3WCUwAgACWniCABNh4sIAALv0AgAAK+ACAAWkcgIAAEInAgAE5TEA=
Date:   Wed, 14 Sep 2022 04:56:33 +0000
Message-ID: <CO1PR11MB486530021339393DDAA558F192469@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
 <20220908150658.1839520-2-kavyasree.kotagiri@microchip.com>
 <1662671776.565921.3355400.nullmailer@robh.at.kernel.org>
 <SA2PR11MB48742AF8A0C9BC6D32D57A2892439@SA2PR11MB4874.namprd11.prod.outlook.com>
 <CO1PR11MB48654A4239AB7A760193497992449@CO1PR11MB4865.namprd11.prod.outlook.com>
 <eea8e746-6561-71ca-12f0-d010a0672edf@linaro.org>
 <CO1PR11MB48650B395FB6A4D94B51CE0792479@CO1PR11MB4865.namprd11.prod.outlook.com>
 <98ab5118-aa32-af20-a732-dcb5e362717b@linaro.org>
 <CO1PR11MB4865D623FA957BE718C7A75292479@CO1PR11MB4865.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB4865D623FA957BE718C7A75292479@CO1PR11MB4865.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4865:EE_|SN7PR11MB6601:EE_
x-ms-office365-filtering-correlation-id: fc53ff4a-fa76-40f1-159f-08da960d7ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0BN5vkTQBHtajV29VVmWydNBw83pIc7cgaO44SHpknbJ5Ob2HyyjWmaCg2gKhqzaK6J2EP5wh7xiJAlAsxeIMo8N6v8BUqo8jdhOI+HyjaMy57NN1/wwPW6iyNcZn37RCJ0f8M4tIlo5vW7dk3UaDHr8mtaD+W3e9yBXSyrcF5+uOt63G3V3KicwlB/33p9JwwBwePDzTZ/uLhW11W/hoK8xYmN2f5HKqY3ncQo3sqOnrD/IdR6q4qdbh+4aGGtouIlwLGeHbm4Y2qyimYw0DNHcWGqoE+5Fs9i2R5DV4l406+4vDaTv1NkoDzI07HEBIEYX+5pGjcQu1TcoA0lzCAuF9BC+lNIhDm+CdqG/fk2Vmt06GoWwGlJjM20/HlGvWUtlmH7qijVzRBwMhMoA5ENqb+BgxzhGDjcRnjHb5X9Ol3cO/Pub+91srNcO0TCOfrqqOY502XOSUw8GxW2ZNFsv+UBwhnSLmWrFH4/ZcWcItHQFV+C0aHzl7VM2Dn/U8gY//RoSmY3qlnfCjhG1oXQK4FZlHgn6Un5Gj00v8lmlA+2xUj4eyr2rx74xS3xKGkxRmULNkuZW9ShPVgvY2TGhvLd/k9HLzD0TjEP56Du3n15ryxapPJgwHO7KEhZCH30h2Ru19FEPa0uLoJjtdAyvSQHUuTmHyEsNuDops3rOWONat65ASg44tL46LRsIbWyeUQDpyXHTUOmJji0V4mW0VsSclWMB2QkECrdA1EQjNvWUCKPUntyiz0E++Hhl6WQM/WVHmZqzRXMqzpN3N9FTIQDpkbAsljqY1wXdVE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(5660300002)(38100700002)(6506007)(66556008)(110136005)(54906003)(53546011)(64756008)(66446008)(86362001)(8676002)(71200400001)(33656002)(66476007)(186003)(107886003)(8936002)(83380400001)(9686003)(316002)(122000001)(38070700005)(55016003)(41300700001)(52536014)(966005)(7696005)(4326008)(26005)(66946007)(76116006)(2906002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU9rVkxRNkVhV3cxSTdtNlRmVlp3RFIvZit0TklyWkRhZXJOeHhZRWZaK016?=
 =?utf-8?B?WkYzeWg0N25HQzRWa0VDbENWVWYwOHBPcnFNZjdEb0IzK0w1S1Vmb3IzdVBY?=
 =?utf-8?B?aWhrYkNsSGhPQXdRYUxPeW1jak8xamQvYTZKYi9VNkY5bkVwZU1MbFNFNjVl?=
 =?utf-8?B?UzRWbGhEdUtIdTl6KzMwMWRWT0tTNWRrc2NaRGFTVTRIUVVoc2lBczRMY0NQ?=
 =?utf-8?B?R0E3NXFXY0NTUVNLRlplRlN1SlFaRjVJOXh3MTJqNjYraFgxRlV1Ynk4em5F?=
 =?utf-8?B?K3RJRkxKZnFjMzVZa3BKamJXcFc4Zlh6OWZiVGtoQW9NK2JDYS9Ja2J2dVFB?=
 =?utf-8?B?OVNnVTFVaG4xK3NNVWhoSzhnN21vL1FvVWpNdlM1azVNNEpjcXFoTFNjY3Ey?=
 =?utf-8?B?OWtCZWlmTndmem1vd2lRNUpJbFhvS1NQLzc0S2FiUU4xZ1liOXd1eG5pYkJi?=
 =?utf-8?B?VWdhT2YxOU50WTJXTklqdUxZZlFsNXhMYm9XT3ZraTFyMXRHUElHbGgxdGxk?=
 =?utf-8?B?bWY2SnVGNStjY2JmcmdHcER1dklLRnFwVGVEUlpHajdFTjBOUWkveW1OZXN6?=
 =?utf-8?B?OW0yMnhyS0FWdzk4eWsxRnVIdHg4Y0VFN1NkU1Z5VjE5UzdZd0hmQUIrbktI?=
 =?utf-8?B?cmlVTlUrL3lBUVBIZWQvMUxGWVZBTHFMdGhkMFNSRU9SalpMUHBkT2ZLZFpq?=
 =?utf-8?B?bW9TWkVSTmdEVnRNaDV6MFVlZ3BTNzFZaytHM2VQa0pqZEM2am1iMkU0dXV6?=
 =?utf-8?B?L0ZLTDBsZHVRUzFZb1VENjAwLzN1enFIYTE0YkhtMXpPK21nekEzOXZEYSty?=
 =?utf-8?B?MU1GRmNTd3NrUTAyN0VRWFNMSkhZSDhJc3IrNXlzd2VyQy84d1pVUFZHU3I5?=
 =?utf-8?B?TEd2akplUnIvM05mOTM1eHd4NDJXUkxVZWdPUkt0T0UrNHlGZGIydlV3L0c3?=
 =?utf-8?B?YnhwL0pXZDhFTUxKNnM4M2hSQzA2MUl0K3lRam9iUjVzblhENEIvZmo5Rm9y?=
 =?utf-8?B?YUNYZU1uL2NMbFhJd3pSMXBmV2I3dUg4MU44L2t1RWNxSXVwUC90a3hMZThI?=
 =?utf-8?B?bTZ2YkFMUzBNWXVjaDdsL0t0dGNLc3gvenphWEhPWXBTaUhLUGwybGZ1allS?=
 =?utf-8?B?T2dkd21aSGw5cUNjWnJIMGhHK0MyMG5zazJhMjlpbkQ3c3BnZ1dNaUliK0NO?=
 =?utf-8?B?Q0dmbmFUYWZIMmE0VVhoVDhPN05udjNhSHpkNXJ6K3VRZlRWell6bnlWclNl?=
 =?utf-8?B?SE1EajlMU1hGU1MzMlJld2ptVGdaSkRDdzduYUZMSm1Sc2RzOU93WE5sb3VM?=
 =?utf-8?B?VzlrYVZVaW9tNWhuOVgwSTRxMWVCRHZSZkJyUGxIVWNJTHNyZzNoeWFsTTIz?=
 =?utf-8?B?b1A1UzFvSERDMzExRVFmQjVzRGJMSFg4alRNZ2VEWHhqblRXSFkzZG9aNzU0?=
 =?utf-8?B?K3l4NmdBclNNQ2dTY3lCbmdlVWxOb1h6MkgvLzJ2d1JtVzQ2TmNzVm5kYmJy?=
 =?utf-8?B?TE4reVJUYks2VlhzU0p3eFVmWnpsWjVHbkVaVE9keGlqbXc0eG5UVWlMTTI3?=
 =?utf-8?B?NmhCYlNHVUFYeXZmUjFnVnRIL1FXek40SlNPL1ExZ1lsbUNxUW9qV1M5emtI?=
 =?utf-8?B?MkxyZlYvaVhscjhzdFJEKzg0Z0FjdW0xSWF3bHpKbE8yVXRXd25QTW9iVk5o?=
 =?utf-8?B?OHgwSnQ4NGpyRVNic3BJYzFZVVJYWmRqam85ekpZWlFtOXZlTlRnbFVEL2tD?=
 =?utf-8?B?Yk10Z0ErRmxBWm1ScExaMHc5Y0RWSWRJbkszTy9JWndLTjRQZm1scW1jV083?=
 =?utf-8?B?N0pXV05NQ2tUc3ZBZG9hWGVWRGI2SkpYTG55T1F2SWNIbE45ZnE2dE95ckZq?=
 =?utf-8?B?NDJtRUdrRVdnRXdSMDdDTk9PeTlUUm1TeGU0K2NzWmRxdUUxN1FPQnVkc0E3?=
 =?utf-8?B?V2k4d0R3MU9QMk5KVWJWYVd0bFR3YXdpM2IzWU01OU9DRXpLYzhncXJ6blN4?=
 =?utf-8?B?cHl5L2wrQ1JRbXZXRXNEb1lVQXRwRHEyNDRBbTJ5dkdsRWM0a2kxczVBOFNk?=
 =?utf-8?B?N1h6S1R0dmtlL0NMM1BGMmltdDhSU2ZQVlZWc2k4WEYxbzNNT05KRmNaMSta?=
 =?utf-8?B?c2Z4RFdPb1pscUpsS0M2QkdwcU5oS1pZcHJ2UjBZdkhOSzk0R3lLd2F6OWp4?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc53ff4a-fa76-40f1-159f-08da960d7ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 04:56:33.1858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQ5vi219jPXPrU/YW23chZc5SMdx8HZDb85zE9mJURH67anvTGYTZeixxh7jFKuNzLJTU4gZtKANGytZfyb5V82/pWbLRL9WVKqrKZdLYyJyyTUiDttgwK58lZJY4l5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IE9uIDEzLzA5LzIwMjIgMDc6MjksIEthdnlhc3JlZS5Lb3RhZ2lyaUBtaWNyb2NoaXAuY29t
IHdyb3RlOg0KPiA+ID4+Pj4+IGZsZXhjb21AZmMwMTgwMDA6IHNwaUA0MDA6IFVuZXZhbHVhdGVk
IHByb3BlcnRpZXMgYXJlIG5vdA0KPiBhbGxvd2VkDQo+ID4gPj4+PiAoJ2RtYS0NCj4gPiA+Pj4+
PiBuYW1lcycsICdkbWFzJyB3ZXJlIHVuZXhwZWN0ZWQpDQo+ID4gPj4+Pj4gICAgICAgICBhcmNo
L2FybS9ib290L2R0cy9hdDkxLWtpemJveDMtaHMuZHRiDQo+ID4gPj4+Pj4gICAgICAgICBhcmNo
L2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDI3X3NvbTFfZWsuZHRiDQo+ID4gPj4+Pj4gICAgICAg
ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDI3X3dsc29tMV9lay5kdGINCj4gPiA+Pj4+
PiAgICAgICAgIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl9pY3AuZHRiDQo+ID4gPj4+
Pj4gICAgICAgICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfcHRjX2VrLmR0Yg0KPiA+
ID4+Pj4+ICAgICAgICAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyX3hwbGFpbmVkLmR0
Yg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IGRtYSBwcm9wZXJ0aWVzIGZvciBzcGkgbm9kZSBpcyBhbHJl
YWR5IGJlaW5nIGNvdmVyZWQgYnkgU2VyZ2l1IGluDQo+IGJlbG93DQo+ID4gPj4+PiBwYXRjaDoN
Cj4gPiA+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvYjQ2MjU1MjYtOGY5Yi1hZGE4
LWY4NTQtDQo+ID4gPj4+PiA3NTFhNDg1NDU1NzZAbGluYXJvLm9yZy8NCj4gPiA+Pj4+DQo+ID4g
Pj4+IEhpIFJvYiwgUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgY29tbWVudHMuDQo+ID4gPj4NCj4g
PiA+PiB0aGlzIG1lYW5zIGl0IGNhbm5vdCBiZSBjdXJyZW50bHkgdGVzdGVkLiBBcmUgeW91IHN1
cmUgdGhhdCB0aGVyZSBhcmUgbm8NCj4gPiA+PiB3YXJuaW5ncyBpbiBhbGwgRFRCcyB3aXRoIHlv
dXIgcGF0Y2hlcz8NCj4gPiA+Pg0KPiA+ID4gWWVzLCBJIHJhbiBkdGJzX2NoZWNrLiBJIGRvbuKA
mXQgc2VlIGFueSB3YXJuaW5ncy4NCj4gPg0KPiA+IFRoZW4gdGhlIHdhcm5pbmcgY291bGQgYmUg
cHJvYmFibHkgaWdub3JlZCAoSSBhc3N1bWUgaXQgaXMgcmVhbGx5IGZpeGVkDQo+ID4gd2hlbiBi
b3RoIHBhdGNoc2V0cyBsYW5kKS4NCj4gPg0KPiBZZXMuIFlvdSBhcmUgcmlnaHQuDQo+IA0KSGkg
QWxsLA0KDQpQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBjb21tZW50cyBvbiB0aGlzIHBhdGNoIHNl
cmllcy4NCg0KVGhhbmtzLA0KS2F2eWENCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBLcnp5
c3p0b2YNCg==
