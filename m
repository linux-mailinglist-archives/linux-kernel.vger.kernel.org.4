Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967C86AC1E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCFNxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCFNxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:53:34 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA9A211CF;
        Mon,  6 Mar 2023 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678110812; x=1709646812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p+ORvlMndkMKqNWk/DaVz30SQlf7MKZC4tqATKR8Wsk=;
  b=otOBiOQb2I+DCdOyuIWM1pU0IhB2mx7U0T0kUgNIC4UQ8924+L3ALwUr
   6mbew5agYLyVMC58dBKqnMt/oE4bhwQ/fGmJmbLtDbJHh7mJOpK1PiPF6
   n9T30HYnuCUQfnBSxO+vfIMG2CiiWwzkMZiMSuE5dyDfHGhmR7vq3THWd
   0OsbvVqPQB1f717f3Vhdtv9+WoFP2t7vrbEMPlxoNXNThIUDCF2UyIxo6
   HiPrafJcT/mpXeSmLYm+Z62A48hlmGvra4QZixt9W11ICN3wFyazIkJs0
   ILmjjTxGJdM5pVJeD++OdLnjCUOkJOOlJXCBSZ5aS5j76c2wUB4Dx/tKq
   A==;
X-IronPort-AV: E=Sophos;i="5.98,238,1673938800"; 
   d="scan'208";a="203822616"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 06:53:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 06:53:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 6 Mar 2023 06:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv2R6YeFwN2O0w7qE6ccps4g46+qxnrj9tjZm+tUqy8InpHn25sTDWS7FVZhWhkgMau/xENjheO6vjht/tRCoOZU/Vj8cj5DpiK2vEW/VBmpaQwCvUFB2UrENe29T7YmzHKylObNbYvUCsG94EMwWFkYcKRBK0V+Sx645aJp/ds/zrubxP1LDUY8/4h2+7mbXNnyjuGVBU0LDI8AFHY0UXTe+IuesBXwtghkNUzZQDXW9o9rHsNAgFb2D2A/x7xottL8gc6emve4yV16dmYHlrMuzq6n0mhx3MbnJ6GsR4Yih+9PEmt03eeXCgUA/RfUuuQxeI6xHUC6DiZwxqaGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+ORvlMndkMKqNWk/DaVz30SQlf7MKZC4tqATKR8Wsk=;
 b=jhgGQx/dF1qUax75hRCZ5N72Lo34PvLYSVtbjfCnkWkz9LfB/sOCl6ghFBssssrW6jgr6lpKNI0yDolHkelRYA4Y3UdSIDE3e0rvhcjvuw8DxGH5blYGxAUbWk7MCWfH8xrfnS03v7pFl1YofvGmyc3S/va5xIVjdEVMAEzf08FQCWAV2n9VV+W/uZmEzoA8t5K4Ht976nzAeKROJx17QDp9EAH46Bypp53d4GyIbrdcFH8RXzyEK9ByG1fNkVdP+H659SwqaYf1OFtuEwdvuQoR+lkdvq+KlVlD8zGySHQclMjyuKaH5pCIhkwo1h40xS2Fogj9z1panne5UBkFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+ORvlMndkMKqNWk/DaVz30SQlf7MKZC4tqATKR8Wsk=;
 b=LAlaATepzbiNJSov61KN+dIopetGljVMBCZoK7UJv8lUE9Lt9QybW96H7xeGXE+fGgwsXTZNXHUzNNeULozh5JUgot74K8AtrUJavhc5ujNR0N24z4RmHiOCq45beXc9C2V7cn62vxK4pG0gwEN9+0IhJy45Tv+rCNiY3nDyihg=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 13:53:28 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::bd74:bb77:f00d:7524]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::bd74:bb77:f00d:7524%4]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 13:53:28 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>, <krzk@kernel.org>
CC:     <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Thread-Topic: [PATCH v1 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Thread-Index: AQHZRSd/Ccf0+w7GXEi8EUEF8u6SOK7ZassAgAaE8oCADewAAA==
Date:   Mon, 6 Mar 2023 13:53:27 +0000
Message-ID: <2f1a14522a7a8d46e3b037a285af4c3dd9b17cbc.camel@microchip.com>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
         <20230220123232.413029-2-marius.cristea@microchip.com>
         <c38afa67-d24f-0390-f18a-81bee15b7eca@kernel.org>
         <20230225171723.15e822ec@jic23-huawei>
In-Reply-To: <20230225171723.15e822ec@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|DS0PR11MB7381:EE_
x-ms-office365-filtering-correlation-id: 230877ba-ba69-4ca0-6e36-08db1e4a29c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pN1KE/KDkE/cbu14ze7m9zcQfwECGbXAE9ULQaKt+7f8ZG0dSObi7JElECkcpwnui4C1Jc9SYldrHgV48esoz2sMkHvZBIXnSIHI2KM/W9a4ISwJwrDAUaOEuVORTbPCDVpLNuZhF7tEUR2iBjuWDekLwbwWDfyykkcr9MdOPwGGz21hdv0p+9izjg6djSl64rCg/Lo2R4gpqc9JgTzvAlEI+nEwHgQvg+ayt+L/hUZj0RgcRaLRDH4391A+DwRZn/V1/llXJuePscjFKEZ//HANyjC1FNveOaqecdFd7Z6Qqt+BjGHyoGWQvCls4DCvpw7twJ/pQuJkCZqu5xqlu95M9Af8eEZgSpviF7+sDVLvaFjfUloSayZHhJkfE03gjv/sSw+qurCtvmzgmrxSxqwjNgY2txrEWd8N8LSK/vcvAzdmVejmPXbBNL/bIqUhOOmoWTF7Q72iCTfA85cllFS74SToJGjmlKilIxIeMzfM5J/bOcQUk1glAc++OLXvitUgAQ/aVwk/f743CKgnvX5Qj9Rl5g1JM5AIO9R9sox+jZIEnSlE+Q3iW+ZHQEk7F2a3J8Wplfd7/FCDK/zcnxGPORwm7NdQiaWyjNoYg88UqjA8yZ1F+J3/1xLdwSAfc8AXTgYvje7BpRGoRj/0tah4ip0vAo+z5jeny75unH3PfvuP9jf3JH1zegvSdS2SdylAgjnEk1iukJX98o2qpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(186003)(91956017)(122000001)(38100700002)(38070700005)(8936002)(66446008)(66556008)(66946007)(41300700001)(4326008)(8676002)(2906002)(5660300002)(76116006)(66476007)(71200400001)(478600001)(2616005)(6512007)(6506007)(26005)(64756008)(6486002)(36756003)(316002)(54906003)(110136005)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0tvazFiTkEvYnRYRExSMGpQYnJHem5XZDhHUk04V3RzU1l2VEFUZzBiY0Ns?=
 =?utf-8?B?ZTNaekJPelVVNzlINlZYWGdncFltUHVIeFo0VVg4czJhM1dKa1hrc3lRQXNy?=
 =?utf-8?B?ajlPU1Btc2U3MFpiNFU4d3psWEo2OGpKWERHWjMrWnBQTEpldnhxdTAxUUVT?=
 =?utf-8?B?V1htSXViWFFTbXFGNDVUTFZMeUVUTXlkcFFVb29PR3lzWjlJYmJqS3NOSHlW?=
 =?utf-8?B?QkM5WUlOS25zQWtpZTBSNUZ5KzZMTmVHYXNkdXpYOXVCUzRHQ1U0eWF0YXVC?=
 =?utf-8?B?OFJJUjhGS2tXTVZqZFU5NUhyYXB4Vmx1Z0NOc2NmWkd3T1FMVnZBdTBoQkZ2?=
 =?utf-8?B?QVl5azVCRDJoK0lyQUdnNEdDdjZZQnI2T0lsVFRIRVU3eXo5ZE93ZFdRd1Zt?=
 =?utf-8?B?L084bldMN2ZIWHZTVjRpSm1kcTBSd2dRTHEzZi9OLzJlQS9vUzlkdmlkSU9P?=
 =?utf-8?B?ck9NWGRibTdVUnpUbGNpeWo3cEpwdXdvL1NrT0ZnSXZIb2NVSCtweVhjTHY1?=
 =?utf-8?B?dE1HMzZOMEZFdVF4cE9Sa3VZR0k1YWxtYk5lY245T3Q5VjRsUDFiVkRSOE82?=
 =?utf-8?B?YytBTi9jeFp1NloyOHg3dTBGRlo4a29OUFZaZTMyMWVVcmg4TEZwbWJCK0tY?=
 =?utf-8?B?WkYvVG5IeW54Rkt6NkRRY1U3eGhSbzg4U0dMdzNCL05QaEVwa0I2cUFPSkNn?=
 =?utf-8?B?NzZGbGF0UitYb3lnS2FiblUvUWt4TUJMbHE1ZVorcXhDSmQ1a3BmS1JhckF1?=
 =?utf-8?B?UmdwU1hpck9hakt4V3JWYkVtRVhSclczY1B6VXVnT1dDM1F3UmVES01PenJN?=
 =?utf-8?B?eGFDWkdVR0RuYmJUTHZhTmg1L0dOdGZtMkIwempSdllEMWFNQkRibURWd1pk?=
 =?utf-8?B?aVIvaURQc0tVZU13a0d4YXptcWdOVTlGSGRhdzBDd0cyK1pUQzhwdElBSXdT?=
 =?utf-8?B?Slg0RjN1d1Y0NkNGQzJxMUdLUmdjdlhxWUI0Q2VVOVU5U3Uvajk5MWsvNUJw?=
 =?utf-8?B?VXVYaFhxVnZxLzNOcklvRUQzN3NFb3RtMjBLbTJ6RkJWT1N5eHBhQmV6RGhY?=
 =?utf-8?B?YlpyQ3hJbHBRSEoxblFYV0c1MkNhMWpWTnVSbHVabVVDMXowNjlTYWt2TFhr?=
 =?utf-8?B?MVp3VWhmcUM5TUtYS2VIeWVKVzdSQUFOOHpwaFlpYWxqZjhPdFlhWkEzeFl1?=
 =?utf-8?B?MXY5bEJrZXY2RVBCREgvbFdCREIwNXJVZStjQXVzRkR2SGtkcVNIc3VLOTl5?=
 =?utf-8?B?bjJ2UGd2bDcwbWhJd2RKUHZMQjhQNVZLWnkxZXpvZG1UVDFtODg0NmEyNndT?=
 =?utf-8?B?VzU4bG5BS1NUWVlTVUVvSlU1VXFFQy9DMGFNcUwzcUpkMU1iUy91M0UrcUhE?=
 =?utf-8?B?azBQT09vWHFhZG1JblJyK3p5UlRiRkZaaWhXdzhvbmYvQjBoZi9xVWVuTXZE?=
 =?utf-8?B?SGwzYjlWMnpENHRKcEQ3TnhTbmx1RjFpcFZOc1prY0x5T2wraC90aFVDcHRM?=
 =?utf-8?B?alp1cHI3RmE2WjEwNDlrYVZNeEhPQmpkOU9XZWlBNW9jbzVleUxzaUdqbjQx?=
 =?utf-8?B?d0lDTTh3WWZUUmN0aG4vTW5yTVRia3R3MkFSenpDNmNDbGV5ZUIrYlZERU9J?=
 =?utf-8?B?di9FQkNZNDdtN0NCMEVjMlovMGRCV1dVeCs5Z1ZpYlEyU2VKNHdiZFRkWkZZ?=
 =?utf-8?B?MWxZaFg3bUVuTVZiMUdINFpMMjFYSGhoTWpyK1dxWjNKQ2VMU2M1UnZHNUo0?=
 =?utf-8?B?M1A5SUg0Uk9ucUo3VlErdUZ1SDNqYUoxTks0WjFzNDhtTXJ4RUJKc3Izb3la?=
 =?utf-8?B?dDYwWG0vVTNCMFZiNDdMRzBBdzBiZDE4WW9nakpWZ1RqLy9hT0NMQnQzR1Vs?=
 =?utf-8?B?eExUMnpWYWJvNUt5QzUzL3NQSlM4Vmh1WnNIcml5aHJ2c3BFa2Z0NktiUklN?=
 =?utf-8?B?T1JnNlRDQkpzeHFKTmlYYWJsN2RoSWcwakJiWmt5ZVNhMVBQak9RbE9zU291?=
 =?utf-8?B?SXBZMGJDL2pxQm8yaEJJWXNGMEI1MkR1TzFOQkRacHFZUzVDL2ZmRUNKcEpa?=
 =?utf-8?B?aXF0OTRrSjNRbTdVRVgwdEx3cCszNlAzQjc0WGZWWDY3QnhYVFFDUi85LzRj?=
 =?utf-8?B?OEx3S1M3eUh0ZnoxTTN0b0EyeTBEeWVWNzZYZmF1ZElHSWNpa01wa1JwOWtM?=
 =?utf-8?Q?xbBT+xYvN45Og6dzkhTpVZ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9AAB657C7B74B4795D31BA4F8DC68B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230877ba-ba69-4ca0-6e36-08db1e4a29c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 13:53:28.0068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +sZqnig7MPHiLGQpQlXetkzJ1YGkrKtPSf6JCE///Ohv6H/9/BD5noQLiYdIrj4uOQ4BGanvAqqMNDZLXcPBRXuUbV9kTHQfoTiGVAqz0ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7381
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBKb25hdGhhbiwNCg0KICAgVGhhbmsgeW91IHNvIG11Y2ghIEknbSBoYXBweSB0byBjb250
cmlidXRlIHRvIElJTy4NCg0KSSB3aWxsIHJlbW92ZSBzb21lIHNlY3Rpb24gYmVjYXVzZSBJIGFn
cmVlIHdpdGggdGhlIHByb3Bvc2Ugc29sdXRpb24uDQpGb3IgdGhlIHJlc3QgSSB3aWxsIGNvbW1l
bnQgYmVsb3cuLg0KDQoNCg0KT24gU2F0LCAyMDIzLTAyLTI1IGF0IDE3OjE3ICswMDAwLCBKb25h
dGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+ID4gKw0KPiA+ID4gK8KgIG1pY3JvY2hpcCxzYW1wLXJh
dGU6DQo+ID4gPiArwqDCoMKgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3VpbnQzMg0KPiA+ID4gK8KgwqDCoCBkZXNjcmlwdGlvbjogU2FtcGxpbmcgcmF0ZSBmb3IgYWxs
IGRldmljZSdzIGNoYW5uZWxzLg0KPiA+IA0KPiA+IFdoYXQgYXJlIHRoZSB1bml0cz8gcmF0ZSBp
cyB1c3VhbGx5IGluIGh6LCB3aGljaCBzaG91bGQgYmUNCj4gPiBleHByZXNzZWQgaW4NCj4gPiB1
bml0IHN1ZmZpeCAocHJvcGVydHkgbmFtZSldDQo+IA0KPiBJdCdzIHVudXN1YWwgZm9yIHNhbXBs
aW5nIHJhdGUgdG8gYmUgYSBwcm9wZXJ0eSBvZiB0aGUgaGFyZHdhcmUgYW5kDQo+IGhlbmNlDQo+
IHN1aXRhYmxlIGZvciBEVCBiaW5kaW5nLiBOb3JtYWxseSB3ZSBtYWtlIHRoaXMgYSB1c2Vyc3Bh
Y2UgY29udHJvbA0KPiBpbnN0ZWFkLg0KPiBJZiB0aGVyZSBpcyBhIHJlYXNvbiBmb3IgZG9pbmcg
aXQgZnJvbSBEVCwgdGhhdCB3YW50cyB0byBiZSBtZW50aW9uZWQNCj4gaGVyZS4NCj4gDQoNCkhl
cmUgSSBjb3VsZCBjaGFuZ2UgaXQgaW50byB0aGUgZGF0YXJhdGUgKGFzIGluDQppaW8vYWRjL3Rp
LGFkczEwMTUueWFtbCkuIFRoZSB1bml0cyBhcmUgc2FtcGxlcyBwZXIgc2Vjb25kLiBNeQ0KaW50
ZW50aW9uIHdhcyB0byBiZSBhbGluZ25lZCB3aXRoIHRoZSBkYXRhc2hlZXQuDQoNCk15IGludGVu
dGlvbiB3YXMgdG8gbGV0IHRoZSB1c2VyIGNvbmZpZ3VyZSB0aGUgc2FtcGxlIHJhdGUgYXMgc29v
biBhcw0KcG9zaWxlIGR1cmluZyB0aGUgc3RhcnR1cCAodGhlIFBBQyBkZXZpY2UncyBvd24gcG93
ZXIgY29uc3VtdGlvbiB3aWxsDQppbmNyZWFzZSB3aXRoIHRoZSBzYW1wbGluZyByYXRlIC0gZGVm
YXVsdCB0aGUgY2hpcCB3aWxsIHN0YXJ0IHdpdGggdGhlDQptYXhpbXVtIHNhbXBsZXMgcGVyIHNl
Y29uZCkuDQoNCg0KPiANCg0KPiANCj4gPiANCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoMKgIG1p
Y3JvY2hpcCxiaS1kaXJlY3Rpb25hbDoNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCBkZXNjcmlwdGlv
bjogV2hldGhlciB0aGUgY2hhbm5lbCBpcyBiaS1kaXJlY3Rpb25hbC4NCj4gPiANCj4gPiBEZXNj
cmliZSBoZXJlIHdoYXQgaXMgYSAiYmktZGlyZWN0aW9uYWwiIGNoYW5uZWwgZm9yIEFEQy4uLiBN
YXliZQ0KPiA+IGl0IGlzDQo+ID4gb2J2aW91cywgbWF5YmUgbm90LiBGb3IgbWUgaXQgaXMgbm90
IGFuZCBub25lIG9mIG90aGVyIGRldmljZXMgaGF2ZQ0KPiA+IGl0Lg0KPiA+IA0KPiBGcm9tIGRh
dGFzaGVldCB0aGlzIHNlZW1zIHRvIGJlIGEgbm92ZWwgZGVzY3JpcHRpb24gb2Ygd2hldGhlciB0
aGUNCj4gQURDDQo+IGlzIG1lYXN1cmluZyBqdXN0IHBvc2l0aXZlIG9yIGFsbG93cyBmb3IgbmVn
YXRpdmUgdm9sdGFnZSBhcyB3ZWxsDQo+IChpLmUuDQo+IHRoZSBjdXJyZW50IHRocm91Z2ggdGhl
IHNodXQgcmVzaXN0b3IgaXMgZ29pbmcgb24gdGhlIG90aGVyDQo+IGRpcmVjdGlvbikuDQo+IENh
biB3ZSByZWxhdGUgdGhpcyB0byBhIGJpb3BvbGFyIC8gdW5pcG9sYXIgZGVjaXNpb24gb24gYSBz
aW1wbGUNCj4gdm9sdGFnZSBBREM/DQo+IEZvciB0aGF0IHdlIGhhdmUgc3RhbmRhcmQgRFQgYmlu
ZGluZ3MgaW4gaWlvL2FkYy9hZGMueWFtbA0KPiANCg0KWWVzLCB0aGUgUEFDIGRldmljZSBjYW4g
bWVhc3VyZSB2b2x0YWdlcyBhcyB1bmlwb2xhciBvciBiaXBvbGFyIGJ1dA0KYWxzbyBjdXJyZW50
IGFzIHVuaWRpcmVjdGlvbmFsIG9yIGJpZGlyZWN0aW9uYWwgKHdlIGFyZSBtZWFzdXJpbmcgdGhl
DQp2b2x0YWdlIGFjcm9zcyBhIHNodW50IHJlc2lzdG9yKS4gV2UgYXJlIGFsc28gcmVwb3J0aW5n
IHBvd2VyIGFuZCBpcw0Kbm90IGEgInVzdWFsIiB0aGluZyB0byByZXBvcnQgcG93ZXIgYXMgdW5p
cG9sYXIgb3IgYmlwb2xhci4gQmktDQpkaXJlY3Rpb25hbCBwb3dlciBtYWtlcyBtb3JlIHNlbnMg
aWYgeW91IGFyZSB0aGlua2luZyB0byBtb25pdG9yIGENCmNoYXJnZSBkaXNjaGFyZ2UgY3ljbGUg
Zm9yIGEgYmF0dGVyeSBwYWNrLg0KDQoNCg0KVGhhbmtzLA0KTWFyaXVzDQo=
