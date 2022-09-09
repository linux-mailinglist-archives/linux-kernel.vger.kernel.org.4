Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E0C5B2FA5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiIIHSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIIHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:18:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C3B7ED6;
        Fri,  9 Sep 2022 00:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662707926; x=1694243926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=diDQP24IiNFtKn+DEEzh+hhfY/omImMcRIrHc2XD5zw=;
  b=DdEPvBIYQhsvypD24blZvcpoRnG3K6npgC7SggdMxaVodoYmBWz7MsDW
   Ii/WhYQDPrDZnwNZVGGESi2Ti8PocDNWQjgkeBZjMGozq5mEOPsBBw0H0
   vS30uMBWBXy4tNsHGyLJRmFOP+8Nlg1gp86rXNtiFlk3fgD8MPi6CtdNB
   m//b7/KzZzljbmkdZhe/HpKJs43BcreyT2aVeWtvWoK4nyo6Tw9UBOwQN
   n/hG5Ltdz0q97taM++dQrL0Ui2X2Yi/+anbjB2AfrP4J/bK4UmYYZnExX
   0Phe/h1ZGnFfTIi2/cY+1op+1kc1oG49pOgjpNbIeF/pnjZZQDuurkJQc
   w==;
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="190111382"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2022 00:18:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Sep 2022 00:18:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 9 Sep 2022 00:18:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0yTgtC+h3sfsR6CEOx4/rDGyepj3qjrCphsIJhjz18ndx/tyLdxin8YXdzuPnKS0ZXlUTuAYYGFCj8Q5OQciY4hajcb+UD8W1zPRnmR1xIFgHCz6o5yi3nMn8sZg0Cz341Y2isy55oVLboRrXl+5Fyi7XvSszm4hbPlT1qxEljQjBknmVmkmUxN61DfR/8EMBNu/J0yjcWrXgBkWwgueWizKW2PpBmZ82a2uUEnNPUCH52w4JWi27EbVFIRQU1pd6OanjWqMdAkaQ5soKbB8KLvczn+TL2UIB8cGFW5Xc5zb9hu4JCoVhAJd9IQVF2gGKvQ2Vpu699wXt/jSpC/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diDQP24IiNFtKn+DEEzh+hhfY/omImMcRIrHc2XD5zw=;
 b=Q2Ms4s5+96h++Cva3CttB4Zgd9zrmxcde63JOn9FfiZWqMcJLUTMdYnskwEopdRImnce2yYmV574HYllhZoU9efIza58lI3qrAPLTYAC4IundzWdEtQyXWJAENkjDDVvMN0gE9vigpw1NUhFvZ9zwLdwiRaQlxCZhHb9BQc80KmdRJ2FSqyHW42Q6DqX1D+t3iUomoy9bKHWQUAqzGL28PSAHH6cd3wnFWQqgHQOL+u0CFEOGiZaWg9YSRkBk8oUmqDhHQaO7T7RradK2FVWYnD1WTM74FBlglZTUn3aJKvnWom7+OrnS2C4I2WYOD9pvYhSE2b6dsGC/WH3TaAHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diDQP24IiNFtKn+DEEzh+hhfY/omImMcRIrHc2XD5zw=;
 b=D5Run0UbEdCtXSudKr1BONKWtfrDjNbjzcTP6uLiFPmQGSvlsU/L6wI2wSB2xsbxhjbzwkM6qUSXuVnWpoH2KeQS8Xvkiv9UkVn0ipqfGS2LgF3NystTuOVNre7gYR9PqEm5+qs3N+b+FZ+atnVYAHRQGNBaHc+6VeOTb07p57w=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 07:18:41 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 07:18:40 +0000
From:   <Conor.Dooley@microchip.com>
To:     <samuel@sholland.org>
CC:     <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <linux-sunxi@lists.linux.dev>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <heiko@sntech.de>,
        <peter@korsgaard.com>, <uwu@icenowy.me>
Subject: Re: [PATCH 07/12] riscv: dts: allwinner: Add Allwinner D1 Nezha
 devicetree
Thread-Topic: [PATCH 07/12] riscv: dts: allwinner: Add Allwinner D1 Nezha
 devicetree
Thread-Index: AQHYsGUr+3EH8+Kn3EeAQmOckfNsnK220EMAgB/avgCAACzkAA==
Date:   Fri, 9 Sep 2022 07:18:40 +0000
Message-ID: <52217b50-c22f-5a21-e509-05d178e4a173@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-8-samuel@sholland.org>
 <adc4a8e2-7347-7616-99b9-59762023b2ff@microchip.com>
 <8a2194bf-93bd-de4d-8d39-0cd72aabb0a9@sholland.org>
In-Reply-To: <8a2194bf-93bd-de4d-8d39-0cd72aabb0a9@sholland.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|MN2PR11MB4661:EE_
x-ms-office365-filtering-correlation-id: 1f4b58f0-c0c3-4d3f-687a-08da92338592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o8wzWTVyRuJG6kD5D9/cJszZYi6cp7NJhN8DAsVATeiqCJOZ188hjx8yzjMErHUBAl+ofnAxbiD6AV+i2UgwkueuAiUqpxg3V8rQRUGOenDE/d2oJfic+KdXzUMc4b5/1gspS0jGPyPQUcXYdm6XPaJpaCpZ/gzHe/HtnX1HW+WzeSU8y6H1wAJe8gMCzvi+n1uNwJUoudwRMFjOV3E4d6SvLhi1WPpcx/G9f4kgzzIRz+fEMTWq3rKmnTZCwNuZmV4nyR2toZ0u7OkeN5xIA3Yu9+u/M0sbVYz3fataKq9brqgANLoyEbrsnyow8RcEYdWTF2uefdX4qLWMxFE+bMBx9fpDn+cSYalSbxnaewuWk3zYSl1fEfeLplDbRfYbGUUy/aNwQx42BGpsxQqMyW3wxwNLveYRtSkwyuZwf/ZXO47DoZLLYvA59SSNQuSnCXS2ijwrqoG0BbalVBAlUfv3v3TotS3kg7lP1/rvn7ddYvrsc8rsfYk4UnzVPdaeGQSX8Iwcd3sfxJiOSXBeTwQhQ+Q9rSr5TP9LS6T9n6BRb2RFIVfLoJiEGMxSewMpweolUFY1pQK4FKDbMx6UpowsaQWgkTVfdHuJSdE15pdeXok102OxD4HoU1x5gLWEctudceazlB/YBp5ffN8x1GaMgNHPbLavJYZ53TCpuFjX/pzD/NvehQRFu1CS3ZuzMUw8aO6BKiPy3Qb4JMUcCUrcPHMAdSj4OIYYHeaJG2BBoIDWYQgoCXxHxtYmVeqCbVw6PMDwtp9PqNW3Tn91sy/6P9GupB/nI/I+D80xaJVhyd49cq7GBVfZFkDg96rs/rlQ2jVBFTumizTfev/oGdsM8NGQ7Pvv1cmgd7FwOF8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(71200400001)(6486002)(316002)(6916009)(54906003)(31696002)(86362001)(186003)(122000001)(83380400001)(966005)(478600001)(2616005)(66556008)(41300700001)(53546011)(38100700002)(26005)(38070700005)(6506007)(2906002)(7416002)(8936002)(5660300002)(31686004)(6512007)(76116006)(36756003)(91956017)(4326008)(64756008)(8676002)(66946007)(66476007)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmpnYVIxZjJ4MzZQQ3RNNTRsREpYa1gwTURldHJ2c2NDWGF4WUp5MkZRb2Fj?=
 =?utf-8?B?dnNXWVZUL3ViRkRkQStOZmtaNDFBNGh5QkNtRWZVNjBKWkxlQnZYNUFYTnAr?=
 =?utf-8?B?TjlSUXFMMWRPb3U5NmROR3YybWZLek9hMXJBZlA3MVVUQU4xQkdTUlpSdHJL?=
 =?utf-8?B?NkhFdGVvczZOWEN0eFg0cy9YZFlSQXFPdzVoVy9nU2ljVWlzWUZtcEZQS2JG?=
 =?utf-8?B?dW4yeE01UDVkbTRDTHhwbEdhZEo3NkpmRDduL1ptclFaTzlTRVo1SE9EaUNt?=
 =?utf-8?B?SWpjeHh6OXJSK0hEaU5NU2dUMUhEdTN1Q0pNSzBPclRQZWhHenMrR253bDZm?=
 =?utf-8?B?T2pWTFZtOUg5dWZlQ1hLL0xCNXluT3JHU3FDWW5Hb0hPakV3SXZaZllVR0I1?=
 =?utf-8?B?dGhxQnN2VGpOSkUyNGlkMWtSSlZFUEpmVVRTZUhJN2ZtS1NsM2FkZGo3NERt?=
 =?utf-8?B?aDlXWmo5VUtTa0V3Vm9RVVhPeFR4RUFGUDZqWmY0R1M0Wm1waEZUYW5UQlpo?=
 =?utf-8?B?a1FHV0NWTlk2ejJ1N2huUzNZSDB1YmFXSE1kYlNveWdNZ2tJMXI3SXZuczFk?=
 =?utf-8?B?cWlNa2JUVm5ldFA3R3JHR0UrbHNCZ2tFNENJZndxRkRoeTA0Wmd0YWxUaFd5?=
 =?utf-8?B?ZHhnRjNQS0dFd0dwTWp2UXFFUVV1eXFqdi9raU1TY2swV3k0K3Rrblh4TWNz?=
 =?utf-8?B?RWFURzkxbm1URGVNc3drekNVQ3RrL2ovMTA4dEc1b1hRRUJ5NVVUN2EwVFlK?=
 =?utf-8?B?bUJZVTZsZmVNWTQybVhUNnp5akFaKzBlWjBDK1FIYlFNOUIrRCtiNmswa2tJ?=
 =?utf-8?B?RnNWVWNidC9SR3VqSUxUbXhPcmtpOWNMVGNNRGNXSEFHODZoQjR5MEhxbENW?=
 =?utf-8?B?Ry9JUmtzY29IYXFKSWdaR2srMnQyV3FUZWdmUGlJbmJlUEZvZCtSbzZQeUFL?=
 =?utf-8?B?NDc5eU13cnpDREdrRnhhUVl6MXJXWmVPcCtrTGZ5bGJlMStRZFVydVNlYk9m?=
 =?utf-8?B?VFluUnRiUVdQYlFzZXBSQmQ4eXJNNEROMnpaQlNodCtWV2p6N25ZUkxxbEtV?=
 =?utf-8?B?TzBsVUh1VmFjSUNMdU9rWlQ2Wm9IemdEYTFRQThTa3RyRWtTQ0JqdTVlTkZF?=
 =?utf-8?B?aG44Y25MT1NRYVE2Ky9LM0NWNVliR29QcEErREhKQWl6UUNyTngyQjNXcVNL?=
 =?utf-8?B?SjZlL2lIVkZIblV3bHo4VHBJODNCRzlDd0RyYlhzbkNXeEhGTHRtS0pJZko4?=
 =?utf-8?B?dDB4NTFvb0o1ZGJPOHdsaTRFb3ROdldXQzdOZlVEblI3NHJjQksxc2EwRWpp?=
 =?utf-8?B?WGN0cmExV1R3cEZIUS9nUkpxbWZsVDgvOUxXdXZJRUlZN09TWFVEckphWXR3?=
 =?utf-8?B?VHdSWjlqdWFMRzA1bThWait2ZlRsTnZZV2RoV3RPa3NhVmkwQ2YvMXJMaWdz?=
 =?utf-8?B?MGlRS2VnZzN3RWNUZlRnK1E0cFg5TUdCZ29oWUwvKzhOS1Zzem41WFFqNW1y?=
 =?utf-8?B?NlluRUl5aGpDWjBWay9SNGZOSllCMHpBMVFaOEJOUVlJOXBqN05wSFJkT1Zu?=
 =?utf-8?B?OFViNXpQSXpSdFVtcFVybkRhc29CWmFMK0dGdHU4T3ZMMmtpeExiR1lwVjVw?=
 =?utf-8?B?U0ZoS3VhQ1NEOHJWY2tkb3B0aFZ3dlZGR1poTFRmTWNJVkkweFZmRnVTVXlq?=
 =?utf-8?B?UGozODZJQVUwVkhaRW9hQWJYMzF5bFRGUHhyWkNaSGlPRTlLTURqc29jaW8v?=
 =?utf-8?B?WjYzNzJ6STArRXlKWm5FWVZUNjBmcDlGOHkrUzJ5OUZDUFBwY2VFVGJ4ejVQ?=
 =?utf-8?B?dmFWSU4wL25aMUxXaVBZNlJGZWp2RFlENzRhWjQ0SitKZEo0Q0FibGl6cXB3?=
 =?utf-8?B?NkxvSElPZWpNaTIrWTFBcm5hV3hDakUwUFVxRUdUNnVjRmJhd1V1ZGRTR0lS?=
 =?utf-8?B?clZQY1EvMmJvZW9YVSs2TVl5cGdtbmMxdnJFQzlvSHFWeG85MWk2aWI3YVgr?=
 =?utf-8?B?K1FETnpsWmdldkRGakNxRE5KenFyM2UzL0F0dHlCSlJzckxYRThhOU1wdllB?=
 =?utf-8?B?UlNacTVVWmNEUVltSEEyYnhzWlNZdFJFVzY5ZFZWc2tCanhLSWE5aHpPV1hq?=
 =?utf-8?Q?6pX/qYOcitN02cOMkkQrrC3da?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99EA7BB1B9232C4F977909B171D7355A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4b58f0-c0c3-4d3f-687a-08da92338592
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 07:18:40.7049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Su60opjn0vpBfMEeZl8RnvEsNNN7YI21FmuEfKpOGtu8IhXcJjILhq8UKIX0zYtx5jOrgt/rX+4uMGK99UF7/71PyHGIiDriVTN5vIR8y0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDkvMjAyMiAwNTozNywgU2FtdWVsIEhvbGxhbmQgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgQ29ub3IsDQo+IA0KPiBPbiA4LzE5
LzIyIDU6MTAgUE0sIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gRmluYWxs
eSBnb3QgYXJvdW5kIHRvIGdpdmluZyB0aGlzIGEgZ28gd2l0aCB0aGUgZml4IGZvciBsb2FkaW5n
IA0KPj4gbW9kdWxlcyB3aGljaCBpcyBtb3N0bHkgd2hhdCB3YXMgYmxvY2tpbmcgbWUgYmVmb3Jl
Li4NCj4+IA0KPj4gT24gMTUvMDgvMjAyMiAwNjowOCwgU2FtdWVsIEhvbGxhbmQgd3JvdGU6DQo+
Pj4gIkQxIE5lemhhIiBpcyBBbGx3aW5uZXIncyBmaXJzdC1wYXJ0eSBkZXZlbG9wbWVudCBib2Fy
ZCBmb3IgdGhlDQo+Pj4gRDEgU29DLiBJdCB3YXMgc2hpcHBlZCB3aXRoIDUxMk0sIDFHLCBvciAy
RyBvZiBERFIzLiBJdCBzdXBwb3J0cw0KPj4+IG9uYm9hcmQgYXVkaW8sDQo+PiANCj4+IEkgYW0g
cmVhbGx5IG5vdCBrZWVuIG9uIHRoZSB3YXkgeW91IGhhdmUgdGhpbmdzLCB3aXRoIHRoZSBtZW1v
cnkgDQo+PiBub2RlcyByZW1vdmVkIGZyb20gdGhlIGRldmljZSB0cmVlLiBJIGtub3cgeW91ciBw
cmVmZXJyZWQgZmxvdyBmb3INCj4+IGJvb3RpbmcgdGhlc2UgdGhpbmdzIG1pZ2h0IGJlIHRvIHBh
c3MgdGhlIGR0YiB1cCBmcm9tIFUtQm9vdCwgYnV0IEkNCj4+IHRoaW5rIHRoZSBkZXZpY2V0cmVl
IGluIHRoZSBrZXJuZWwgc2hvdWxkIGJlIHVzYWJsZSBpbiBhIHN0YW5kYWxvbmUNCj4+IG1hbm5l
ciwgZXZlbiBpZiB0aGF0IGlzIHRoZSBiYXJlc3QtbWluaW11bSBtZW1vcnkgY29uZmlnLg0KPiAN
Cj4gVGhhdCBpcyBzaW1wbHkgbm90IHBvc3NpYmxlIHRvIGd1YXJhbnRlZS4gQXMgYW4gb2J2aW91
cyBleGFtcGxlLA0KPiBjb25zaWRlciB0aGUgTWFuZ29QaSBNUS1Qcm8gYm9hcmQgd2l0aCBzb2Nr
ZXRlZCBEUkFNOg0KDQpZZWFoLCBJIGtuZXcgaW4gbXkgaGVhcnQtb2YtaGVhcnRzIHRoYXQgdGhp
cyBwcm9iYWJseSB3YXMgYSBub24NCnJ1bm5lci4NCg0KPiANCj4gaHR0cHM6Ly90d2l0dGVyLmNv
bS9tYW5nb3BpX3NiYy9zdGF0dXMvMTUxNjIyNTU1OTIxNDU4MzgwOA0KPiANCj4gQnV0IGZvY3Vz
aW5nIG9uIHRoZSAvbWVtb3J5IG5vZGUgbWlzc2VzIHRoZSBiaWdnZXIgcGljdHVyZS4gVGhlIERU
Qg0KPiBpcyBwYXNzZWQgdGhyb3VnaCBfYWxsXyBvZiB0aGUgZmlybXdhcmUgc3RhZ2VzLCBhbmQg
Z2V0cyBwYXRjaGVkIGJ5DQo+IGV2ZXJ5IG9uZSBvZiB0aGVtOg0KPiANCj4gLSBTUEwvYm9vdDAg
YWRkcyB0aGUgL21lbW9yeSBub2RlIHdpdGggdGhlIGRldGVjdGVkIERSQU0gc2l6ZS4gSWYgdGhl
DQo+IGluLXRyZWUgRFRTIGhhcyBhICJtaW5pbXVtIG1lbW9yeSBjb25maWciICh3aGljaCBmb3Ig
YSBib2FyZCB3aXRoDQo+IHNvY2tldGVkIERSQU0gbWVhbnMgdGhlIHNtYWxsZXN0IHBvc3NpYmxl
IGRpZSksIEkgZ3VhcmFudGVlIHBlb3BsZQ0KPiB3aWxsIHVzZSBpdCBhbmQgY29tcGxhaW4gYWJv
dXQgbWlzc2luZyBEUkFNLg0KDQpUcnVlLCBidXQgdGhleSBhcmUgYWxzbyBjb21wbGFpbmluZyBh
Ym91dCBtaXNzaW5nIERSQU0gYXMgaXMgOykNCk5vIHBvc3NpYmlsaXR5IG9mIHdpbm5pbmcgaGVy
ZSB1bmZvcnR1bmF0ZWx5Lg0KDQo+IC0gVGhlIFNCSSBpbXBsZW1lbnRhdGlvbiByZXNlcnZlcyBt
ZW1vcnkgZm9yIGl0c2VsZiBhbmQgYW55IHBvc3NpYmxlDQo+IHNlY3VyZSBwYXJ0aXRpb25zLiBS
aWdodCBub3csIGJvb3RpbmcgaGFwcGVucyB0byB3b3JrIHdpdGhvdXQgdGhlDQo+IHJlc2VydmVk
LW1lbW9yeSBub2RlIGJlY2F1c2UgdGhlIFNCSSBpbXBsZW1lbnRhdGlvbiBpcyBsb2FkZWQgYXQg
dGhlDQo+IGJlZ2lubmluZyBvZiBSQU0sIGFuZCBMaW51eCBpZ25vcmVzIFJBTSBiZWxvdyB0aGUg
a2VybmVsIGxvYWQNCj4gYWRkcmVzcy4NCg0KU3VyZWx5IHRoaXMgc29ydCBvZiB0aGluZyBpcyBh
IGNvbW1vbiBwcm9ibGVtIHRob3VnaCwgaXQncyBub3QgbGlrZQ0KYW55IG9mIHVzIGFyZSBkb2lu
ZyBzb21ldGhpbmcgdW5pcXVlIGhlcmUgYXJlIHdlPyBBdCBsZWFzdCBpZiB0aGVyZQ0Kd2FzIGEg
YXJjaCB3aWRlIHBvbGljeSBhYm91dCB0aGUgdmFsaWRpdHkgb2YgdGhlIHVwc3RyZWFtIERUUyBp
biB0aGUNCmZhY2Ugb2YgdGhlIFNCSSBldGMgaW5mbGljdGluZyBjaGFuZ2VzIHRoZXJlJ2QgYmUg
c29tZXRoaW5nIHRvIHBvaW50DQp0by4gSSBhbSBqdXN0IGxvb2tpbmcgYXQgdGhpcyBmcm9tIGEg
ImV2ZXJ5b25lIGVsc2UgaGFzIGEgdXNhYmxlIGR0cw0KaW4gdGhlIGtlcm5lbCwgYnV0IHRoZSBE
MSBib2FyZHMgd29udCBoYXZlIiBwb2ludCBvZiB2aWV3Lg0KDQo+IEhvd2V2ZXIsIG1lbW9yeS1j
b25zdHJhaW5lZCBkZXZpY2VzIChlLmcuIEQxcykgd2lsbCBuZWVkIHRvIGdldCB0aG9zZQ0KPiAy
IE1pQiBiYWNrIGJ5IGxvYWRpbmcgdGhlIGtlcm5lbCBhdCB0aGUgc3RhcnQgb2YgRFJBTSBhbmQg
U0JJIGF0IHRoZQ0KPiBlbmQgb2YgRFJBTS4gVGhlbiB0aGUgcmVzZXJ2ZWQtbWVtb3J5IG5vZGUg
YmVjb21lcyBxdWl0ZSBpbXBvcnRhbnQuDQo+IA0KPiBJdCBhbHNvIGFkZHMgbm9kZXMgZm9yIENQ
VSBpZGxlIHN0YXRlcywgc2luY2UgdGhlIGF2YWlsYWJsZSBzdGF0ZXMNCj4gYW5kIHRoZWlyIGxh
dGVuY2llcyBkZXBlbmQgb24gdGhlIFNCSSBpbXBsZW1lbnRhdGlvbi4NCj4gDQo+IEl0IGFsc28g
cmVzZXJ2ZXMgZGV2aWNlcyB1c2VkIGJ5IGl0IG9yIGJ5IGEgc2VjdXJlIHBhcnRpdGlvbi4gQW5k
IGl0DQo+IGlzIHJlc3BvbnNpYmxlIGZvciBleHRyYWN0aW5nIGRhdGEgKGUuZy4gTUFDIGFkZHJl
c3NlcykgZnJvbSAic2VjdXJlIg0KPiBlRnVzZXMgd2hpY2ggdGhlIE9TIG1heSBub3QgaGF2ZSBh
Y2Nlc3MgdG8uDQo+IA0KPiAtIFUtQm9vdCBhZGRzIG90aGVyIGluZm9ybWF0aW9uLCBsaWtlIGJv
b3QgYXJndW1lbnRzLCB0aGUgYWRkcmVzcyBvZg0KPiB0aGUgaW5pdHJhbWZzIGFuZCBmcmFtZWJ1
ZmZlciwgZXRjLiBUaGVzZSBhcmUgbGVzcyBvZiBhIGNvbmNlcm4NCj4gYmVjYXVzZSBvZiBjb3Vy
c2UgVS1Cb290IGNhbiBwYXRjaCB0aGVzZSBpbiB0byBhIERUQiBsb2FkZWQgZnJvbQ0KPiBkaXNr
LCBidXQgdGhleSBhcmUgcmVsZXZhbnQgaWYgeW91IHdhbnQgdG8gbG9hZCBhIERUQiBmcm9tIGEg
bGF0ZXINCj4gYm9vdGxvYWRlciBsaWtlIEdSVUIuDQo+IA0KPiBJZiB5b3UgbG9hZCBhIERUQiBm
cm9tIGRpc2ssIHlvdSBsb3NlIGFsbCBvZiB0aGUgY2hhbmdlcyBtYWRlIGJ5IHRoZQ0KPiBlYXJs
aWVyIGZpcm13YXJlIHN0YWdlcy4gT24gQVJNLCBVLUJvb3QgdHJpZXMgdG8gd29yayBhcm91bmQg
dGhpcyBieQ0KPiBjb3B5aW5nIGEgZmV3IHNwZWNpZmljIGJpdHMgb2YgaW5mb3JtYXRpb24gZnJv
bSB0aGUgZmlybXdhcmUgRFRCIHRvDQo+IHRoZSBEVEIgbG9hZGVkIGZyb20gZGlzay4gQnV0IHRo
aXMgbWlzc2VzIHRoZSBwb2ludCB0aGF0IHRoZSBTQkkNCj4gaW1wbGVtZW50YXRpb24gY2FuIG1v
ZGlmeSAqYW55KiBwYXJ0IG9mIHRoZSBEVEIuIChTbyBpbiBwcmFjdGljZQ0KPiBVLUJvb3Qgb24g
QVJNIGFscmVhZHkgbG9zZXMgQ1BVIGlkbGUgc3RhdGVzIGFuZCByZXNlcnZlZCBtZW1vcnkgbm9k
ZXMNCj4gdGhhdCB3ZXJlIGFkZGVkIGJ5IHRoZSBQU0NJIGltcGxlbWVudGF0aW9uLikNCg0KQWxs
IG9mIHRoZXNlIHRoaW5ncyBhcmUgdmFsaWQsIGJ1dCB0aGV5IGFyZSByZWFzb25zIHdoeSB5b3Vy
IGZsb3cgaW4NCnlvdXIgYm9vdGxvYWRlcnMgZXRjIGFyZSB0aGUgd2F5IHRoZXkgYXJlIG1vcmUg
dGhhbiBhIHJlYXNvbiB3aHkgdGhlDQp1cHN0cmVhbSBkdHMgd2lsbCBub3Qgd29yayBmb3Igc29t
ZW9uZSB3aG8gaXMgbm90IGludGVyZXN0ZWQgaW4gdGhhdA0KZmxvdy4gQXQgdGhlIGVuZCBvZiB0
aGUgZGF5LCBJIG9ubHkgY2FyZSBzbyBtdWNoIGFib3V0IHRoaXMgYXMgaXQgaXMNCm5vdCBtZSB0
aGF0IGhhcyB0byBkZWFsIHdpdGggYW55IGNvbmZ1c2lvbiBmcm9tIGVpdGhlciBhcHByb2FjaC4g
SSdsbA0KY29udGludWUgdG8gbW9kaWZ5IG15IGR0cyBpbiBVLUJvb3Qgc28gSSBjYW4gdGVzdCB0
aGluZ3Mgd2l0aG91dCBtZQ0KaGF2aW5nIHRvIHJlLXByb2dyYW0gdGhlIHdvcmxkLiAvc2hydWcN
Cg0KPiBBcyBhbiBleHRyZW1lIGV4YW1wbGUsIGNvbnNpZGVyIHBhcmF2aXJ0dWFsaXphdGlvbiwg
d2hlcmUgb25seSBhDQo+IHNtYWxsIHN1YnNldCBvZiBEUkFNIGFuZCBwZXJpcGhlcmFscyBtYXkg
YmUgbWFkZSBhdmFpbGFibGUgdG8gYW55IG9uZQ0KPiBPUyBwYXJ0aXRpb24uDQoNCk9yIEFNUCAt
IHRob3VnaCBub3QgbGlrZWx5IHRoYXQgdGhhdCBpcyBhIHByb2JsZW0gZm9yIHRoZSBEMS4uDQoN
Cj4gRnVuZGFtZW50YWxseSwgSSByZXNlcnZlIHRoZSByaWdodCB0byBtYWtlIGFyYml0cmFyeSBj
aGFuZ2VzIHRvIHRoZQ0KPiBEVEIgaW4gdGhlIFNCSSBpbXBsZW1lbnRhdGlvbiwgYW5kIHRodXMg
SSBjYW5ub3QgY29uZG9uZSB1c2luZyB0aGUNCj4gRFRCcyBnZW5lcmF0ZWQgZnJvbSB0aGUgTGlu
dXggc291cmNlIHRyZWUgZm9yIGFueSBwdXJwb3NlIG90aGVyIHRoYW4NCj4gdmFsaWRhdGlvbi4N
Cg0KRnVuZGFtZW50YWxseSwgSSByZXNlcnZlIHRoZSByaWdodCB0byBjb21wbGFpbiB0aGF0IHRo
ZSB1cHN0cmVhbSBkdHMNCmNhbm5vdCBiZSBlbnRpcmVseSB2YWxpZGF0ZWQgYXMgaXQgZG9lcyBu
b3Qgd29yayBvdXQtb2YtdGhlLWJveCA7KQ0KDQpFaXRoZXIgd2F5LCBJIGFtIG9ubHkgZ29pbmcg
dG8gY29tcGxhaW4gc28gbXVjaCBhYm91dCBzb21ldGhpbmcgdGhhdA0KdHJpZ2dlcnMgbXkgT0NE
IGFib3V0IGtlZXBpbmcgdGhpbmdzIHRoZSBzYW1lLCB5b3UgaGF2ZSBhDQpUZXN0ZWQtYnk6IENv
bm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQphbHJlYWR5IGFuZCBvbmNl
IHRoZSBvdGhlciBpc3N1ZXMgYXJlIGNsZWFuZWQgdXAgYW4gUi1iIHRvby4gTm90IHRyeWluZw0K
bWFrZSBhbiBpc3N1ZSBvdXQgb2YgdGhpcywganVzdCBleHByZXNzaW5nIG15IGRpc2xpa2UgZm9y
IHRoZQ0KaW5jb25zaXN0ZW5jeSBiZXR3ZWVuIHRoZSBEMSBzdHVmZiBhbmQgdmVuZG9ycyAtIHBh
cnRseSBpbiB0aGUgaG9wZXMNCnRoYXQgdGhlICJoaWdoZXIgcG93ZXJzIiBnZXQgaW52b2x2ZWQu
IEkgY2FuJ3QgaW1hZ2luZSB0aGF0IHRoaXMgaXMNCnRoZSBsYXN0IHRpbWUgc29tZXRoaW5nIGxp
a2UgdGhpcyBjb21lcyB1cC4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCg0KDQoNCg0K
