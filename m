Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4796269AA45
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBQLYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjBQLYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:24:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC8642D5;
        Fri, 17 Feb 2023 03:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676633090; x=1708169090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cAuEMGETFl79pOEcw9mV0XgyZSlnWvW7+ZqgOAZboWA=;
  b=1FFSBJTYFhc8p8LMxs9l1mE0NwwQi1T8bl0L9cEnrisvmIweqWjXfBxR
   oEJ7X0HTyKMxz9xVO7gkn8xQLnAl/WSIwf7PyTBgIPzraP6BgIV+QKz+Y
   zavdhjQ3cYdfjamm0cF5bB9hnjFqdrAM2/B0iJrjmP5FdFJvh9al+zkAp
   u1RPeEFHQJgj7j1KhwGbGIxCl66vkWZC5G4J/Ry825qGe02TkZ9GIFDYr
   WVNIV/5GZKdIGzgplvuTywC4X7jeImJ82QeRC9h0qEZUf5xkHTlNpldmu
   upHUfdtCJDvW/84DthqQieHiatijIXPaZPygRlt2PDRFYHDHN8G5Pg6Wy
   g==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="201105211"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 04:24:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 04:24:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 17 Feb 2023 04:24:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9fnIzZebcZkSvx1FctWzV+drVB/HmTivAZ1UMRrZk/smBMowVfl0q/iLFnVglI6x9E7KqBSEMEFxOWkJhK/gFKyQdkxJ6j3+/NNvNiLh0TEas+GgY5M2MaKLtjQBkAnWNLbUvTHHR4uO4OYw1A91H8j9x90vCt5D4mxuGs5+L5Cr59u/VMj9vr06BldboTAi87am7ucHtwVO3hf8ciumAerJyWu7No1m9qfazy6PK570hdFZV+uUK0Lw9pdDG+FYjO5T3BffIyCe3W1pZoydvkIzqzFahtF5TgxjDyo0nv4uq7UWpP/4FuUELvKfQbwqm47npggMt4uPNoZm4iLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAuEMGETFl79pOEcw9mV0XgyZSlnWvW7+ZqgOAZboWA=;
 b=Aw6nbx/6qcWSkxUbIFAkodyJioGmKodJoYzSqvutTXdfXEJ4RkwkwR0LyXTA9Gq0nuq26LZSICI2Mbgbts3HuSh0zVxtZfEdRpmv0mFMEHTWv2Bu9aYT2lDsR1WGvteaGRyS2Oc0vUkstMtwX6xbu4kvxc9BMEnImocQz/uKhsvypvstlzuQLO/Ms+l/rm4XRXK//0YB9AVSrter6WFnsKe9jLI5J5jalBKwgLUROgxltzPtKNka/tBFPDOA5xH/eUIn7+Xg8WwkXt+3EdlGx0fLNAqr0l7AYOayzR1ZnRllUUe6JdkyOTQs05p0UmcmhzwXmqn+H0l0L7xGfrOsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAuEMGETFl79pOEcw9mV0XgyZSlnWvW7+ZqgOAZboWA=;
 b=DDCjO7qUi7kBnZiPylI6AoABO31xpeR2Km/5R6ZxOvvLyLRudY6hNtDiKIPM/+dbckR9AAdFBIXhZxAiRrMe07eKHlv2ySkfaK9i3UFmViS91C8TCm5I0RA8X13HMIh/xuuwfGHg6+CGx+VxSG6RGNNMOIh1wHqMdvGdJb1np6A=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 11:24:45 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 11:24:44 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Ryan.Wanner@microchip.com>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] pinctrl: at91-pio4: Implement the correct drive
 values for sama7g5
Thread-Topic: [PATCH v2 1/2] pinctrl: at91-pio4: Implement the correct drive
 values for sama7g5
Thread-Index: AQHZQsJv3YAIyxvHKEuauq0RrH9Dlw==
Date:   Fri, 17 Feb 2023 11:24:44 +0000
Message-ID: <a0f152a0-8b09-7588-953b-751c9f3ea00d@microchip.com>
References: <20230216222524.3107759-1-Ryan.Wanner@microchip.com>
 <20230216222524.3107759-2-Ryan.Wanner@microchip.com>
In-Reply-To: <20230216222524.3107759-2-Ryan.Wanner@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA1PR11MB7110:EE_
x-ms-office365-filtering-correlation-id: 2ab15245-00cc-4862-5f7d-08db10d991de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+eCw+KSEgZ/25m2MHpJ7ZzQoGEEnFYypaMLfP6jHr7FooFp4DfrZRsvVtFrYCEP/m56t/X7+F8bzVgEjiO1V3lqGmh90BZhMYiB0s+XoPp/sGhwrubTFY3GPpG0eQ0ss9LaT8VW8bFsnHIV/5u59GfI2UQfMu2o1JVpuWn1eP1hCPvSoz2pbH3AgFQi+BSlHE1jzbZ17dUKyq69NyrUZtikz/6Ga6U7hHh9PT8kiIcD0bWDYaSA4F21PhuA0MXJ3xjiRfTCUH967o7uh5in5Cz7Vod5bn8/R3fLHrWl2MrFi3W13tzN2QOxG3yzkrqJ1MLQhElp+I95hGQ33JtDdPFFPdoSl3c2Tv0m83T53WYmpwjQ1MaLAcw1s4/V5/m8jq6Pwl2frsFuEty4EQu14/jFcdK/6gjueUN8fttuXXHGCmtvjD4PYVc1lsNfpAje3yvG8Nv80by9By9LdbNAxF4AX7F0JNn3tu+to0wlbBYQZ2bPsuOA5TP8ZD7pDK3sYDhxmhyMOvVs1eEsKc4ns77+pqANKXR1ewTptIOtepLxj0QhnjF/DibB1NaGhTQhNvCQw1O2QAtAInuhYghXwRyxxdlNpGJErpOajIOwrh/8JomcZI68dqSBYWdv7EzTz2dA14mWaCvUbKRollN9cxR+5YI4+LoYPAfC3810zIpLkJUg7ZjcLXiDIPVD2meiucPgUcR11jlKM87wU1ltvZ+33lydzRwjVlubB/ks2BbBw7XglsO58WNE+rDK1KJV0nOSORyhqgwl/Kpr6guU2bVGkzPSrKmehK0o2XuO64w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199018)(316002)(31696002)(66446008)(38070700005)(6636002)(86362001)(71200400001)(54906003)(110136005)(6486002)(478600001)(122000001)(38100700002)(64756008)(66476007)(8676002)(53546011)(4326008)(91956017)(36756003)(66946007)(41300700001)(2616005)(2906002)(6506007)(186003)(26005)(76116006)(6512007)(5660300002)(66556008)(31686004)(8936002)(83380400001)(138113003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGRDU3Aya1ZienF3RlYyenQwSHJ0RERUbU0xT0VRTUVsR2VPdTNkdTROS2hJ?=
 =?utf-8?B?eWFPT2gyMnViTUVVZ3hCdzg2T0FiM1p4aEdGZ3dVNmVTSkI2VDE5MkF4Slk1?=
 =?utf-8?B?RG55b0N5NEtiVTRDUVlsTzNvYXhBajRoR042TTRvYjZCL2ZkRUdxWng3VXhF?=
 =?utf-8?B?ZTNqaXRxTjNiVHQ5eDZVdmd5NU5jUmZ0bkE1TnRWVWlOUTlhWEhLenduNm9V?=
 =?utf-8?B?MGNIMEsyNjlnTkg0c1VMWXQ1ZncrQkJNeG1wWjE1cktJSy9PZUV6bEhwY0hZ?=
 =?utf-8?B?NzhOcUlqRThDdks5UE1GVDhrcDAwc0dUQzNud01BUXNnYlF4ZHVEblUvck5p?=
 =?utf-8?B?Wm5nTnE3aEE2aWxOL09seFR6ZkNUdXFuZG1FZ1FGY0ZsWHJ3UUx6Nk9BWExF?=
 =?utf-8?B?TWJINVk0elB0ZkgxU2N0a1N4WWVZbVJmSzllbzhKNjFXNk9JcStoa1E4WlhO?=
 =?utf-8?B?ZS9xUmhpVkx6c1dnUk9xRUQ2SDBHbjJoZzVxZ1dubkVrOUNZam5LTGRPOFNH?=
 =?utf-8?B?UHdqdUNLZzZTZnhhNEQ3M3NZVXk2TmhaaDhGYUxNclFnOXdRcjAwZGFWZ1kz?=
 =?utf-8?B?TGQwVndsWmRDZVFUZ2xaNFRpOUlFUE1obm5IMmsvWUIyb1A3U0FwZStkUmtZ?=
 =?utf-8?B?YXZnSlVoYzhzb1lWeG9vWUxMaHpWRGlYTWkveU4xbG5YVFJOZzgxU3c3Vk9p?=
 =?utf-8?B?RWVGblNQaXIvcWlxcnp5aUxxTDNJbnhhSmhqVXB0MkZ1SXRmTkt4WWErVStK?=
 =?utf-8?B?ZGJuSnowb2Fia3M4bjh1SUNUSFRnUXJ4ZVQrTmdoTXB4bys1L1VLMlBoWDh2?=
 =?utf-8?B?aVFGYVhhL2ZPdEVmdkZQZjN5dGJKWFZrdTl5VTRoeGFTamN2UTd2bWM4UTFi?=
 =?utf-8?B?dXdxVXpUQ25QazBjTlU3QlpYVGVoYWpHazlUNGNUQmVRb2JvZE5KWFdRN0dT?=
 =?utf-8?B?YW9WQVhLUjkvUDFrZmYrSjMwMjFiZFh5MFJhdHNqNnFTRTgzK05ZOXdNNXlK?=
 =?utf-8?B?ekZiNWpCTDUxSXhSWEIwSzV0UmlVamZRV3pXdm91NWxHSEtqcSszZHkvOFR5?=
 =?utf-8?B?UzZYdWdCMThDVTQvTDIvRmlvalBSQ3FacXlZaDUxdUNYdnlzbjVBOHp4R2w5?=
 =?utf-8?B?MEVETjdzNERHbUpneFA3Y0Y2UDlRTS90Umpuc25yN0tIamFwZkp2bHh5TXpI?=
 =?utf-8?B?VW1wajlJWUlRdCtGNFZFL1NWWDNNMStWbG9hYlFJSzUwYWI5K0NlaDhaU1hp?=
 =?utf-8?B?QVVvNDNZdk9qQXVCV2ZkVUhsbUFQb0trQnVSUVRJalVDNzJuSEtFVVBQQ1g5?=
 =?utf-8?B?R2tZVW95THJEeTVyVlVCV2lreGN4NnkvMUUrN2RXQ0JGZEFrV3E3Wmgzc1ps?=
 =?utf-8?B?WmprTWlCK09vQjlCdmpIL3ZlTE1QUHd5WFV4c25WMVpyamlHQmhTSnBhN3Fi?=
 =?utf-8?B?OFRlRlk4VlRhb29XQWxmdmtsUTc5NUQydnR6ODlQZklYVVFjSmVaNEc3LzNI?=
 =?utf-8?B?a1h4WGpqcGJtRlZqcVpvQTZnRUFObG1tc0U0a2Y3RUZoNFdNRERQamRxMTlQ?=
 =?utf-8?B?WGtUOEd1cnJCQncrZzgxZnFQamVyU1g3VXlId0dxbzlINmRZY0ZtK3l1WElq?=
 =?utf-8?B?UURuVEhiVVZXZm5NckJGcVh3bHVBZFZ2WmRvSGs1R0FZWkJYVFNXUU9QWUVk?=
 =?utf-8?B?azV0VTgvc0RuVnBUTVZ5RTIwdVJmbEwrc3N4QVhtelRpdWJta0RHRnZubGlv?=
 =?utf-8?B?Vko5YStyYmZqdnVjM0VodXJ3TmVwbllzOG9yenI4bnBWeEJxaTVqQTFLVnF2?=
 =?utf-8?B?Vlo3dTRSYUVpTEhtSEE0VG5tc3hsUWQ4RC95TVFKWnIzRWxMNDZKV3hVeTNo?=
 =?utf-8?B?OEVZVnE0bVBrMWpKam92KysyODNkVGFrbzVPbGJVa0NxYTdEazB3NzZUdklo?=
 =?utf-8?B?bmRlZjI1blZvU3hFZ25RcTdCZzRWV21EV1FKS3JxZ0N2TEk4cW8xZUNpS0dV?=
 =?utf-8?B?cUF2TFhNUTdSWGRualdrWnErOFgrTExBVTdMY3lVY0lxMVBYdVkwczgzWkJr?=
 =?utf-8?B?b3pmTENFWk5kQVMwRWRLeUxQbWp4c0d5azVLVnp4M3ltSUV2a3BhZ24ySFJo?=
 =?utf-8?B?aUFUdFAvMzZwbXYrQmt4YlFzbjVTSHE4elJZRDBGRnZTVmFsc240cVVKMUkw?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46185F1A9EAF9741ABAC4EC7CDF37FD6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab15245-00cc-4862-5f7d-08db10d991de
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 11:24:44.4118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kz0ZCPy7ycsNpqI/IRgPM8Z8hxnbioji/0KK70AxUnsxGxJA3/VjWT8s4f8DlWpzxZvNP7Z+67aIs04qqq4dPJeg1RttaQp55JQysBD4WHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7110
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDIuMjAyMyAwMDoyNSwgUnlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4g
RnJvbTogUnlhbiBXYW5uZXIgPFJ5YW4uV2FubmVyQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBTYW1h
N2c1IGRyaXZlIHN0cmVuZ3RoIG9wdGlvbnMgaGF2ZSBiZWVuIHVwZGF0ZWQgZnJvbSBwcmV2aW91
cyBwaW80DQo+IHByb2R1Y3RzLiBOb3cgdmFsdWVzIHdpbGwgY29ycmVjdGx5IGFsaWduIHdpdGgg
c2FtYTdnNSBkcml2ZSBzdHJlbmd0aA0KPiBvcHRpb25zIGhpZ2hsaWdodGVkIGluIHRoZSBzYW1h
N2c1IGRhdGEgc2hlZXQuDQo+IA0KPiBBZGQgeGxhdGUgdG8gc2VwYXJhdGUgdGhlIHNhbWE3ZzUg
ZHJpdmUgdmFsdWVzIGFuZCB0aGUgc2FtYTVkMjcNCj4gZHJpdmUgdmFsdWVzLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUnlhbiBXYW5uZXIgPFJ5YW4uV2FubmVyQG1pY3JvY2hpcC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS1waW80LmMgfCAyNyArKysrKysrKysr
KysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwt
YXQ5MS1waW80LmMgYi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLXBpbzQuYw0KPiBpbmRl
eCA4MmI5MjFmZDYzMGQuLjZiNWE3NTNjY2QzNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waW5j
dHJsL3BpbmN0cmwtYXQ5MS1waW80LmMNCj4gKysrIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwt
YXQ5MS1waW80LmMNCj4gQEAgLTcyLDE3ICs3MiwzMiBAQA0KPiAgLyogQ3VzdG9tIHBpbmNvbmYg
cGFyYW1ldGVycyAqLw0KPiAgI2RlZmluZSBBVE1FTF9QSU5fQ09ORklHX0RSSVZFX1NUUkVOR1RI
CShQSU5fQ09ORklHX0VORCArIDEpDQo+ICANCj4gK3N0YXRpYyBjb25zdCB1MzIgZHJpdmVfc3Ry
ZW5ndGhfeGxhdGVfc2FtYTdnNVs0XSA9IHsNCg0KWW91IGNhbiBnZXQgcmlkIG9mIGFycmF5IGxl
bmd0aCBoZXJlLg0KDQo+ICsJQVRNRUxfUElPX0RSVlNUUl9MT19ELA0KPiArCUFUTUVMX1BJT19E
UlZTVFJfSElfQSwNCj4gKwlBVE1FTF9QSU9fRFJWU1RSX0xPX0MsDQo+ICsJQVRNRUxfUElPX0RS
VlNUUl9MT19CDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3QgdTMyIGRyaXZlX3N0cmVuZ3Ro
X3hsYXRlX3NhbWE1ZDJbNF0gPSB7DQoNCmRpdHRvDQoNCj4gKwlBVE1FTF9QSU9fRFJWU1RSX0xP
LA0KPiArCUFUTUVMX1BJT19EUlZTVFJfTE9fMSwNCj4gKwlBVE1FTF9QSU9fRFJWU1RSX01FLA0K
PiArCUFUTUVMX1BJT19EUlZTVFJfSEkNCj4gK307DQoNCm1pc3NpbmcgYmxhbmsgbGluZS4NCg0K
PiAgLyoqDQo+ICAgKiBzdHJ1Y3QgYXRtZWxfcGlvY3RybF9kYXRhIC0gQXRtZWwgUElPIGNvbnRy
b2xsZXIgKHBpbm11eCArIGdwaW8pIGRhdGEgc3RydWN0DQo+ICAgKiBAbmJhbmtzOiBudW1iZXIg
b2YgUElPIGJhbmtzDQo+ICAgKiBAbGFzdF9iYW5rX2NvdW50OiBudW1iZXIgb2YgbGluZXMgaW4g
dGhlIGxhc3QgYmFuayAoY2FuIGJlIGxlc3MgdGhhbg0KPiAgICoJdGhlIHJlc3Qgb2YgdGhlIGJh
bmtzKS4NCj4gICAqIEBzbGV3X3JhdGVfc3VwcG9ydDogc2xldyByYXRlIHN1cHBvcnQNCj4gKyAq
IEBkcnZfc3RyZV94bGF0ZTogeGxhdGUgZm9yIGRpZmZlcmVudCBkcml2ZSB2YWx1ZXMNCj4gICAq
Lw0KPiAgc3RydWN0IGF0bWVsX3Bpb2N0cmxfZGF0YSB7DQo+ICAJdW5zaWduZWQgaW50IG5iYW5r
czsNCj4gIAl1bnNpZ25lZCBpbnQgbGFzdF9iYW5rX2NvdW50Ow0KPiAgCXVuc2lnbmVkIGludCBz
bGV3X3JhdGVfc3VwcG9ydDsNCj4gKwljb25zdCB1bnNpZ25lZCBpbnQgKmRydl9zdHJlX3hsYXRl
Ow0KDQp5b3UncmUgdXNpbmcgdW5zaWduZWQgaW50IGhlcmUgYW5kIHUzMiBpbiBhcnJheSBkZWZp
bml0aW9uLiBDYW4geW91IGZpdA0Kd2l0aCBhIGNvbW1vbiB0eXBlPw0KDQo+ICB9Ow0KPiAgDQo+
ICBzdHJ1Y3QgYXRtZWxfZ3JvdXAgew0KPiBAQCAtMTIxLDYgKzEzNiw3IEBAIHN0cnVjdCBhdG1l
bF9waW4gew0KPiAgICogQGRldjogZGV2aWNlIGVudHJ5IGZvciB0aGUgQXRtZWwgUElPIGNvbnRy
b2xsZXIuDQo+ICAgKiBAbm9kZTogbm9kZSBvZiB0aGUgQXRtZWwgUElPIGNvbnRyb2xsZXIuDQo+
ICAgKiBAc2xld19yYXRlX3N1cHBvcnQ6IHNsZXcgcmF0ZSBzdXBwb3J0DQo+ICsgKiBAZHJ2X3N0
cmVfeGxhdGU6IHhsYXRlIGZvciBkaWZmZXJlbnQgZHJpdmUgdmFsdWVzDQo+ICAgKi8NCj4gIHN0
cnVjdCBhdG1lbF9waW9jdHJsIHsNCj4gIAl2b2lkIF9faW9tZW0JCSpyZWdfYmFzZTsNCj4gQEAg
LTE0Myw2ICsxNTksNyBAQCBzdHJ1Y3QgYXRtZWxfcGlvY3RybCB7DQo+ICAJc3RydWN0IGRldmlj
ZQkJKmRldjsNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUJKm5vZGU7DQo+ICAJdW5zaWduZWQgaW50
CQlzbGV3X3JhdGVfc3VwcG9ydDsNCj4gKwljb25zdCB1bnNpZ25lZCBpbnQJKmRydl9zdHJlX3hs
YXRlOw0KDQpzYW1lIGhlcmUuDQoNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBjaGFyICog
Y29uc3QgYXRtZWxfZnVuY3Rpb25zW10gPSB7DQo+IEBAIC04NzIsMTIgKzg4OSwxNyBAQCBzdGF0
aWMgaW50IGF0bWVsX2NvbmZfcGluX2NvbmZpZ19ncm91cF9zZXQoc3RydWN0IHBpbmN0cmxfZGV2
ICpwY3RsZGV2LA0KPiAgCQkJCWNvbmYgJj0gfkFUTUVMX1BJT19TUl9NQVNLOw0KPiAgCQkJYnJl
YWs7DQo+ICAJCWNhc2UgQVRNRUxfUElOX0NPTkZJR19EUklWRV9TVFJFTkdUSDoNCj4gKwkJCWlm
IChhcmcgPiBBVE1FTF9QSU9fRFJWU1RSX0hJIHx8IGFyZyA8IEFUTUVMX1BJT19EUlZTVFJfTE8p
IHsNCj4gKwkJCQlkZXZfd2FybihwY3RsZGV2LT5kZXYsICJkcml2ZSBzdHJlbmd0aCBub3QgdXBk
YXRlZCAoaW5jb3JyZWN0IHZhbHVlKVxuIik7DQo+ICsJCQkJYnJlYWs7DQo+ICsJCQl9DQo+ICAJ
CQlzd2l0Y2ggKGFyZykgew0KPiAgCQkJY2FzZSBBVE1FTF9QSU9fRFJWU1RSX0xPOg0KPiArCQkJ
Y2FzZSBBVE1FTF9QSU9fRFJWU1RSX0xPXzE6DQoNCllvdSBtYXkgd2FudCB0byB0b3VjaCBhbHNv
IGF0bWVsX2NvbmZfcGluX2NvbmZpZ19kYmdfc2hvdygpPw0KDQo+ICAJCQljYXNlIEFUTUVMX1BJ
T19EUlZTVFJfTUU6DQo+ICAJCQljYXNlIEFUTUVMX1BJT19EUlZTVFJfSEk6DQo+ICAJCQkJY29u
ZiAmPSAofkFUTUVMX1BJT19EUlZTVFJfTUFTSyk7DQo+IC0JCQkJY29uZiB8PSBhcmcgPDwgQVRN
RUxfUElPX0RSVlNUUl9PRkZTRVQ7DQo+ICsJCQkJY29uZiB8PSBhdG1lbF9waW9jdHJsLT5kcnZf
c3RyZV94bGF0ZVthcmddIDw8IEFUTUVMX1BJT19EUlZTVFJfT0ZGU0VUOw0KPiAgCQkJCWJyZWFr
Ow0KPiAgCQkJZGVmYXVsdDoNCj4gIAkJCQlkZXZfd2FybihwY3RsZGV2LT5kZXYsICJkcml2ZSBz
dHJlbmd0aCBub3QgdXBkYXRlZCAoaW5jb3JyZWN0IHZhbHVlKVxuIik7DQo+IEBAIC0xMDEzLDEy
ICsxMDM1LDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBhdG1lbF9wY3RybF9w
bV9vcHMgPSB7DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGF0bWVsX3Bpb2N0cmxfZGF0YSBhdG1l
bF9zYW1hNWQyX3Bpb2N0cmxfZGF0YSA9IHsNCj4gIAkubmJhbmtzCQkJPSA0LA0KPiAgCS5sYXN0
X2JhbmtfY291bnQJPSBBVE1FTF9QSU9fTlBJTlNfUEVSX0JBTkssDQo+ICsJLmRydl9zdHJlX3hs
YXRlCQk9IGRyaXZlX3N0cmVuZ3RoX3hsYXRlX3NhbWE1ZDIsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IGF0bWVsX3Bpb2N0cmxfZGF0YSBtaWNyb2NoaXBfc2FtYTdnNV9waW9j
dHJsX2RhdGEgPSB7DQo+ICAJLm5iYW5rcwkJCT0gNSwNCj4gIAkubGFzdF9iYW5rX2NvdW50CT0g
OCwgLyogc2FtYTdnNSBoYXMgb25seSBQRTAgdG8gUEU3ICovDQo+ICAJLnNsZXdfcmF0ZV9zdXBw
b3J0CT0gMSwNCj4gKwkuZHJ2X3N0cmVfeGxhdGUJCT0gZHJpdmVfc3RyZW5ndGhfeGxhdGVfc2Ft
YTdnNSwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0
bWVsX3BjdHJsX29mX21hdGNoW10gPSB7DQo+IEBAIC0xMDY0LDYgKzEwODgsNyBAQCBzdGF0aWMg
aW50IGF0bWVsX3BpbmN0cmxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
IAkJYXRtZWxfcGlvY3RybC0+bnBpbnMgKz0gYXRtZWxfcGlvY3RybF9kYXRhLT5sYXN0X2Jhbmtf
Y291bnQ7DQo+ICAJfQ0KPiAgCWF0bWVsX3Bpb2N0cmwtPnNsZXdfcmF0ZV9zdXBwb3J0ID0gYXRt
ZWxfcGlvY3RybF9kYXRhLT5zbGV3X3JhdGVfc3VwcG9ydDsNCj4gKwlhdG1lbF9waW9jdHJsLT5k
cnZfc3RyZV94bGF0ZSA9IGF0bWVsX3Bpb2N0cmxfZGF0YS0+ZHJ2X3N0cmVfeGxhdGU7DQo+ICAN
Cj4gIAlhdG1lbF9waW9jdHJsLT5yZWdfYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNv
dXJjZShwZGV2LCAwKTsNCj4gIAlpZiAoSVNfRVJSKGF0bWVsX3Bpb2N0cmwtPnJlZ19iYXNlKSkN
Cg0K
