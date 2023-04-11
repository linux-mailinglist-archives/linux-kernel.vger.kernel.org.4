Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47E96DDE74
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDKOtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDKOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:49:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2032.outbound.protection.outlook.com [40.92.98.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B61A4;
        Tue, 11 Apr 2023 07:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyxDYQsUApkV6kCibqTuTsh2dNDRNIssyRTJSMgEnpJZ1YM9ptTVu0QsTWTN2LfRYtp8xKUxkDjpbmLChtmwXsYGui/fgOtUMW76g0tZ8CvIMbsENN07Pk3TFcJNovzMQzOjlqpuikb5D91AcuAh3hMYqpvipjMe3ca8LLovtvMPHx7KKBd+n50fe1rAo3wUkt5WwgfLSno13aRxHkFkVer9PWIcvsJs9tg0jN2ZoD6qt4crwc7TEremckPVoEbRZUda3z5VuMUhF6gZ9XrVljDBDEVzjE9THYfJmq7Gvd/RomrKRX7PscvYUMuuWdfyd3cg8ichiP6TBBiP1J9lpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tfD+C06XmngEzQnwefORDWGXTPuxqw5Iy6xTqiUhOk=;
 b=oXrMn0T2RibUjgMrq9lE5cDDp67ahHmqUmFjGOcgXM1Fbqh8eUZaesD9R2/D3raGCZ4Hr8gPrXvclT8NdYy33WQcqzoIy8sFH77a5sao2sQlAl5DCHolymdoTOGi8e3oDuym779dXfg7bJ21pjK/K77KYzOT6HEA7OUATCOAJCOW4wyDqS8xE7GXy5Esi2f73vva81dqk3QrepGNSm0RoFnhKyR1V1J0g3uHvZ4xPX0hJPasCFo83TRlpzRovcEg9jl8T2kN+huua0GDjNL/D7c4SFYyAuiosdXEXjQo6rCPOFs3o1cTGduUCeWJzs1LLQFK5u+uSHJVWsoVc1m3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tfD+C06XmngEzQnwefORDWGXTPuxqw5Iy6xTqiUhOk=;
 b=I2rJwVlATOOyvPpqJCXJaah5tuyGd9uJXnyuOyahRLm3kPhjd/7eW9CM2fNcRVsmJory9IF6REOiY1uw8mXvJNyQGCBXlMPpNMJil5vw/fKFWYblgPiO87XPEczPQdpF22lSil45zUeWwLzOEhUfapHTYkz00Lk43rBM2+hyWiC+Lh0Lz3K/xem9BJkDaCFaY+RQvrAZacJozVL133fktUkcn//Z46iszsgD10GEtxUfIkP7hvBRZhex5DNcF/gyY8saQ5AtFUzt+juarE/3h8D1UGA4hgGZw1xxmP3+262gSj/5769+yF0mZUss8k4Z2+GdZLYx5x2debQ25RLiiQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYYP286MB1716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Tue, 11 Apr
 2023 14:49:15 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 14:49:15 +0000
Message-ID: <TY3P286MB261181FB1FDAF6B14CDB266B989A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 11 Apr 2023 22:49:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Conor Dooley <conor.dooley@microchip.com>,
        Mason Huo <mason.huo@starfivetech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230411083257.16155-1-mason.huo@starfivetech.com>
 <20230411083257.16155-2-mason.huo@starfivetech.com>
 <20230411-chimp-unvarying-142394732ff5@wendy>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v1 1/3] riscv: dts: starfive: Enable axp15060 pmic for
 cpufreq
In-Reply-To: <20230411-chimp-unvarying-142394732ff5@wendy>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0l1xLDjruSTSYlGKONKYJurz"
X-TMN:  [v7yOvRkMhXdwWUR6ZhZhFNsWFzT8btxw]
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <36424b12-5155-aba4-6dfe-9dd99a15141a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYYP286MB1716:EE_
X-MS-Office365-Filtering-Correlation-Id: 516be664-bcd2-4229-f264-08db3a9beb77
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huQE2W/hKu7wrabZxLbLdTmVzysWDDqr18qmdRie6iu3JyEOgFcs7rXO5vNZU3sAYxkHsvQtNdWyaP+S67PeX4fQD8OOmI4/z/hoGyoPQOdz1eE9217lYI0PIFvsbHiUgkAOzOzKIBah3FSNcIeMZRiwG0+RwW95gCib0vWwHReYAwQmFH5FtWKTO8/IOZ3gkyPAElYcCdAS4IB+bJ6YsLV08EVH41gEUkmNqj/gCroqxF4t/o16wI4KVu74qQurHqXO/qdvy2Gw5CbfEjS16KD5+eDKa5R1JgUHRnotCy6cRX82E9ecZ8U4GZ0NmW+/tB3NN7en+3FEnXTB3Gv8KJtf5KwksK8Dd9gYi057RBHlhac9F9ZwYCpVD7IYdsNS7MR0CvaMkiE1OY9kYyDUN6NNbEr4yqi9eUCBYOBuLdqZcgq4ywt+irFMNtrDjQ30sXXy6ct6NYBNXqZIqwYedenZvgVuqyECEsYwZnYbivTUG+iI7cM1cBA6eYA9RlUZrwiTf3pWDB5RhetWsWb1++ZYEajHnmIqkoQx1bMR7GVHfw+9enUz8FUv1UtMqoS7UI25egxQj7OjR7mQMK4fXT2VwcUVxoXWLkJ8gEjLI8a9ro3FAwSJxoswwcFREK6I
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2p2T25PdG8wMEFDaVh3dStXalBmV3Nnd1JVK3pXUDNoUEY2SUtDUU51OUpp?=
 =?utf-8?B?M2pjdXByeFl5MWN3ZU1zTVZ5bzFTVjFhQ2VwcEp5OXFWTWVmaEF3VGpjOU91?=
 =?utf-8?B?ZHhySURBdFdNK3d1VlB4OWJ2eVlSZm1hU2E3NUFOR2NHdFJnKy9JMkVvb0dn?=
 =?utf-8?B?UEFLRUU4eXJnU3k0dXd0bnZ6ZnUxbzIxNFA2VWlUdk1FdFVRZElPRWg3MTM0?=
 =?utf-8?B?QWVTc2hBSUsrOS9uaWtRN04vNE5QMVBTc0wwTjlzY2haQmFrYzRlRm1ZWGdk?=
 =?utf-8?B?b1FRRHlEMW00MmsxWTJuSUFZSE90VHgvM1paOFNKbXV1YkFOK0FBVVZ4VlNZ?=
 =?utf-8?B?RXNHekkwRktXWiswTjdDaWNkR3RTS09KRnRzYmhUQlBKaWdIV2ZIZlJnUGw5?=
 =?utf-8?B?Tzg2dEg4WlRvZ09CZytzaUc4QUx0aERRR1RTUUYrVUNKenlzTEN6c29aMVIv?=
 =?utf-8?B?S09NQVg1cFJidDNleUlDRW82RnZINS92eFdmU0FyUHErdndwL2RndzhEVmRS?=
 =?utf-8?B?UnRBbUJyTFRRN0VHYUhaTzBuU0JRTVlyRFBtdlJ6STJVYzh0WWd5cW5GeUsz?=
 =?utf-8?B?aVNpL3pZa1o2UTJ6ZXowaUNCeDh3RUYrd2dQZWs2SUV3ejRHdmNPVFQxenVT?=
 =?utf-8?B?Z1gya2o4aVpJWEVOUUI4NGtmRTkrbGh2ZWU5dytCS1ZsdkN3dzEyemJicSsw?=
 =?utf-8?B?Y3lZWjFPVnBnYmw1UHpFTDdibHQ1eXJpK2FnRy9HbThJa3B5VjA4WjVOMUxH?=
 =?utf-8?B?YnNsdjVZelE5VUhkUkZ1dEFocm0rcW54aEUreUhjYjNjWmYreXViL21IRGRQ?=
 =?utf-8?B?MDFqbG1NcVpEVkcwc1VVeWNSUm9BNE1tKzdxY0FmVTBXNHJ1aXBPY05mM3Mr?=
 =?utf-8?B?UTB3TThXbW5hYUJGbHM2UFhXVnNzQzlTV2Urck9jNXp0UjlpMFJKbStYWStt?=
 =?utf-8?B?QmwrVnFrLzg1dEs0NmUzcTNFSC84SVJoemF6SEQ4dGxtSXplNVhxcE1FUk10?=
 =?utf-8?B?RjZmeVR3QTF3OC9ramxRbFdMazVzeG5ZcktWNXBVa052QVhPY3orbjFPMXJv?=
 =?utf-8?B?Zlk0NzI5NGk1RUhxOVJCRXdSSitGclRvdWl5bkxnRVVGTDVkTXl5dnZteFpo?=
 =?utf-8?B?Sk1aaHh2Zi9pVTVQU3F3dSsvS2lKT1E3R05iV1FEMnVWTmpVN2ptWElEaUhw?=
 =?utf-8?B?YVpvMVVKUUkxUGhMZHlMZGQwc1c4NEZsbXNuTFMySnMzNHp1ZjNBRTBieWhR?=
 =?utf-8?B?RllNb0YrbkI0Z2h1d0EvZ0R6S1VQa3l6elVRQWNPRC9oaHNCWE9ZOWFkM21J?=
 =?utf-8?B?eTFydHZOUml0dDhQclZOZndvMXVHTEVoUXdBelZLVXFuQkV1eUtkcWNrZVI0?=
 =?utf-8?B?cHkrU3AveGw1WWtLVGZqeW5rY3pCV2UxVWRiWVdHZnMvRUtYNmlvaHF5cTVh?=
 =?utf-8?B?dFhzVnZoaWFxcUsvU1NtU0VvOEkyMzdHdXNxS0hDeFcxVnA3TzVEYUFQVUxu?=
 =?utf-8?B?SUJaRGZ1SmsxM3V3dnZXaEhqR3kwZTMyb0pnU1RtMU8vY1EvTlp6a2xvWmRK?=
 =?utf-8?B?TlNQdjIzclVncjh0Z2s5MVdGay9FbkFRUHZUVlQwRjRONVM4bE56eDYrV0F6?=
 =?utf-8?B?UlpuNDhDVUd1L2xLMVRDd2ZuWTkxSVE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516be664-bcd2-4229-f264-08db3a9beb77
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 14:49:15.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1716
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------0l1xLDjruSTSYlGKONKYJurz
Content-Type: multipart/mixed; boundary="------------u4VUGiq1YhmL9Tgf0KCdbfu6";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Conor Dooley <conor.dooley@microchip.com>,
 Mason Huo <mason.huo@starfivetech.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Message-ID: <36424b12-5155-aba4-6dfe-9dd99a15141a@outlook.com>
Subject: Re: [PATCH v1 1/3] riscv: dts: starfive: Enable axp15060 pmic for
 cpufreq
References: <20230411083257.16155-1-mason.huo@starfivetech.com>
 <20230411083257.16155-2-mason.huo@starfivetech.com>
 <20230411-chimp-unvarying-142394732ff5@wendy>
In-Reply-To: <20230411-chimp-unvarying-142394732ff5@wendy>

--------------u4VUGiq1YhmL9Tgf0KCdbfu6
Content-Type: multipart/mixed; boundary="------------04iYyEAMsoha52dNQ3mhVV3J"

--------------04iYyEAMsoha52dNQ3mhVV3J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBPbiBUdWUsIEFwciAxMSwgMjAyMyBhdCAwNDozMjo1NVBNICswODAwLCBNYXNvbiBIdW8g
d3JvdGU6DQo+PiBUaGUgVmlzaW9uRml2ZSAyIGJvYXJkIGhhcyBhbiBlbWJlZGRlZCBwbWlj
IGF4cDE1MDYwLA0KPj4gd2hpY2ggc3VwcG9ydHMgdGhlIGNwdSBEVkZTIHRocm91Z2ggdGhl
IGRjZGMyIHJlZ3VsYXRvci4NCj4+IFRoaXMgcGF0Y2ggZW5hYmxlcyBheHAxNTA2MCBwbWlj
IGFuZCBjb25maWdzIHRoZSBkY2RjMi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNYXNvbiBI
dW8gPG1hc29uLmh1b0BzdGFyZml2ZXRlY2guY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9zdGFy
Zml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLmR0c2kgICAgfCAxNSArKysrKysr
KysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtc3Rh
cmZpdmUtdmlzaW9uZml2ZS0yLmR0c2kgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZl
L2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRzaQ0KPj4gaW5kZXggMmE2ZDgxNjA5
Mjg0Li5kZjU4MmJkZGFlNGIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRz
L3N0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRzaQ0KPj4gKysrIGIv
YXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2
ZS0yLmR0c2kNCj4+IEBAIC0xMTQsNiArMTE0LDIxIEBAICZpMmM1IHsNCj4+ICAgCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiAgIAlwaW5jdHJsLTAgPSA8JmkyYzVfcGlucz47
DQo+PiAgIAlzdGF0dXMgPSAib2theSI7DQo+PiArDQo+PiArCXBtaWM6IGF4cDE1MDYwX3Jl
Z0AzNiB7DQo+IE5vIHVuZGVyc2NvcmVzIGluIG5vZGUgbmFtZXMgcGxlYXNlICYgInBtaWMi
IGlzIHRoZSBnZW5lcmljIG5vZGUgbmFtZQ0KPiBmb3IgcG1pY3MuDQo+DQo+IENoZWVycywN
Cj4gQ29ub3IuDQo+DQo+PiArCQljb21wYXRpYmxlID0gIngtcG93ZXJzLGF4cDE1MDYwIjsN
Cj4+ICsJCXJlZyA9IDwweDM2PjsNCj4+ICsNCj4+ICsJCXJlZ3VsYXRvcnMgew0KPj4gKwkJ
CXJlZ19kY2RjMjogZGNkYzIgew0KDQpyZWdfZGNkYzIgc2VlbXMgbm90IGEgZ29vZCBuYW1l
LCB0b28gZ2VuZXJpYyBmb3IgaWRlbnRpZmljYXRpb24uIEluIG1vc3QNCg0KY2FzZXMsIGl0
J3Mgc2FtZSBhcyByZWd1bGF0b3ItbmFtZSBidXQgdXNpbmcgIl8iIHJhdGhlciB0aGFuICIt
Ii4NCg0KPj4gKwkJCQlyZWd1bGF0b3ItYm9vdC1vbjsNCg0KSXQgc2hvdWxkIG5vdCBiZSB1
c2VkLMKgIGluIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IN
Cg0KL3JlZ3VsYXRvci55YW1sLCBpdCBpcyBkZXNjcmliZWQgYXMgZm9sbG93czoNCg0KIlRo
aXMgcHJvcGVydHkgaXMgaW50ZW5kZWQgdG8gb25seSBiZSB1c2VkIGZvciByZWd1bGF0b3Jz
IHdoZXJlIHNvZnR3YXJlDQoNCmNhbm5vdCByZWFkIHRoZSBzdGF0ZSBvZiB0aGUgcmVndWxh
dG9yLiINCg0KSW4gdGhpcyBjYXNlLCByZWd1bGF0b3Igc3RhdGUgaXMgY29tcGxldGVseSBh
YmxlIHRvIGJlIHJlYWQgYnkgZHJpdmVyLg0KDQpCZXN0IHJlZ2FyZHMsDQoNClNoZW5neXUN
Cg0K
--------------04iYyEAMsoha52dNQ3mhVV3J
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------04iYyEAMsoha52dNQ3mhVV3J--

--------------u4VUGiq1YhmL9Tgf0KCdbfu6--

--------------0l1xLDjruSTSYlGKONKYJurz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmQ1c2QACgkQX75KBAfJ
sRk6chAAiBI7B2hkfnnirtvG+SEldJ/I0nIHjKiDnkP8Gj0H4he6b9i1u3JSxtcC
WbTdMGvcQBW1aAMzzpFnWf+19LXkt0B8eeNEvBDj0MBkfusY7o9aVghHUK41QP4g
IcwOJFHNvjAJGxGnotuWAYPUMfseCmGjX+xcO8AKnFokG+A9JIFM8uvYzRGoFrsU
3JAkaK56EHpsIb0CngP6KI0JXc60TmuvEPz5Oaj7gMTjBRQcZuTnrM1v3XnT4wyg
JCNLs5Cx/DhzG5ECpbKTDoZPIKXgwWuFxGc/mARC+dp98heOpqllFrn3EdC8fu7u
vkbF/zxCi7mysKlKBeIG+GP9aTJU8vfo4nBoIjontQTEPaCcHeaymHa0Y00TNsA9
xOnjb+X2MSRd8g2dJTqhb+MjmGtP62ZAidzjDG7TKEFY/gDv3wbzV53ZP8PHpV4q
wh12bRZqOybkLp1dWKp64HiBED0NmIVdt+QKfC3uywMTByQv8AFa96W0iD9aFqog
PXzwYldbp/iPORvUWzzQeKqVFXQjkRMLniJB2PY71Wv17WNfqU/XulcIjwTZiS43
ujLRd0wXK8Eu9unZltO26taObwdDj1Xb3HPpRcJBMxK0apDLqmflMy732qzo3yuG
FagpE9cXzMAoHZqMCxbA7WT4rjfZroiCwsG5l4Nq59Xg1/GvOQ0=
=Q63R
-----END PGP SIGNATURE-----

--------------0l1xLDjruSTSYlGKONKYJurz--
