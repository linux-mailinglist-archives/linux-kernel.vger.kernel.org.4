Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F946323D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiKUNgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiKUNgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:36:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3040BC2853
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669037762; x=1700573762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GN0pWeAXZiFs4WWAQuxFAhRPg0wz2yfE/sbOHJasFi0=;
  b=dA+2G6C8tgL4twEH3UmDapwbWsubHAeLvywKG1/eSWxs52mCQdCa2I4E
   2aMYV3QTiNoMjZt/yIKGX2hBr+7Onh6x/HqcPkiFEUywwNWoVvWAv4Gsh
   Vw3TE7abjsoEX3+PuA3ptBaTgJ6limvNVnY8u60tKweCVn8Y5MANHF8Y2
   H3qmzXLJitnrgFGlvG7Zz2kGPiVOQl5vJdfP+Dl3EqRB/acIdibyJWOQG
   uiPGS942cyb3Fe+wYUbZ0dvrypGttBwhbWTv9SF1QMjF+tbw4R91Hpnvf
   WwO1mFfRZ3mDlMsMx4u3MNeNQVLP4yNoZTJhhyNF0D7rFsnGGmoVNGUPa
   A==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="187950228"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 06:36:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 06:35:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 21 Nov 2022 06:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCuzfeZapPmoTipa0fe8ecOG8BnYD8CecYmFXM4YGpTH8WtWAmpeC4pxWUEuBfF7bUt5RfrrdVcEEzEVYf4rA9QBQvEum7SEqFdZWc+Pq4T7nYzO6WNs8I5nK8sHNE01CYnE99H6rUGZWvxODzxJfdmgl3+aDdk79SckFkGVBQF+fDJBf/B4zqqDnEiAruU2oUVEODx9fs9PUq91bwgCvUGdRs1NSAeKetn7QRj4UXQ0Cl0yjTowK0p7FH/+ao7YyBKd5zMnLL3aVowVlwzvc3uAgLnBl6PkFNtLk8F4XxN2SozGUN5sIbR3uA+9JWxVy8j1UF4WAS6ShkPUjUfvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN0pWeAXZiFs4WWAQuxFAhRPg0wz2yfE/sbOHJasFi0=;
 b=Y3GOMt3M4nr1zw4QuUAkyq0k06RGW+JV5pHzhqGiJRYf5dDRfTfAXUaqUADF+SM/EXK9Oin90Xl+cyo34foc2RxLX/G4CLl+molw7fVSmIRji6n+o6drL0CFATZv5mWKb4rm0vj/3SY6bKrnELDDtgEuNq04mJRH6ywprKEtbFhdm2O/nl7sgf9PkDRPXQ8/OassKvDr+RMHLilLNOMQNAIp9iPv7p1ujTBSyKuWdCDGHhxXUq2cZZcSOwrstEkAFJAqtB5/eC431wRMO4oTH32VDgW3DsAllG7EKXwgBIIazTWmbJnXdEjxCCzvUfKxtu6A8owWIl0R39W2+q1YVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN0pWeAXZiFs4WWAQuxFAhRPg0wz2yfE/sbOHJasFi0=;
 b=btIj+47yieZsvdj1MlLd+FIKae2Mw53zid9JYCtjSZIUoEBf2fM5ysoCadSo+ZM3CwdPZVeqUHw/4xqnaM1zIwMFYM4NyipMfQB9dTyPazTp+pWmBOY9Re6RG8pqCEWuX3cGymSh76Z/bmVh9uT8g8HRb798BNssqnfrwW3uLMA=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 13:35:57 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b%5]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 13:35:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <pratyush@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 6/7] mtd: spi-nor: add generic flash driver
Thread-Topic: [PATCH v2 6/7] mtd: spi-nor: add generic flash driver
Thread-Index: AQHY/a4wiDTi1a3iJE2+xt2R4rtYtg==
Date:   Mon, 21 Nov 2022 13:35:57 +0000
Message-ID: <d5374b58-1434-acda-eae0-8e39aeec0d90@microchip.com>
References: <20220810220654.1297699-1-michael@walle.cc>
 <20220810220654.1297699-7-michael@walle.cc>
In-Reply-To: <20220810220654.1297699-7-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|SA0PR11MB4623:EE_
x-ms-office365-filtering-correlation-id: 846df211-2fe3-41d8-e925-08dacbc55240
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUE4FCSjViTAFheuL7vfAyIanJ2CuAZyRe8MF2GLLjTrdt+UhCHJHnD5l/isygksXXl4+8pVbdsnkU+B/nQ20UBraZjvrVc2bfwwrjVz4wP9vqp0hQEVu4qUsCIYEN0yvmHNwOemJRqSZkTFEbJTM9tllf8kvjA1re7YS1i7xS+zjix2NmFBDu6ah23FwyEUkxlyrPiJzi/8s9D+7GjBdM1LGEhuEaIrDtE3FBRcHGlL0o+Ai7Nmzywf5y2zwtRlhz6RmAMz1A1A4U+W5KYluCHaksJmi6uzsWVGi7P4nqNdA6rYQiGgwSB+AGUJuqzXT7Llnq7OdEq9BtndWZ3pQvLue3uXoOGzwsnES7HvjLn0IuudbufL/dAUD3aj7U15ZOUdZA5wMlB3q8vbUvKZ8tAVQxYy7nY7imnbSt3OOYw91N+MyHKT7Erh+VtJvzWl4Ngqtx0gAqgugbVZCyh4WnDR4msYs45cz3VuxQ7AMQfkl6wPe8edPW3YaJTh0z1L2Px2O5JHSly+kEmkHHDbE3JDyEgqVY7hJ6JUryjScyc7XZIfGMyLPQZcQQi+xPgCPg4q5h102OEV0ET3ZFmJfuVrV7bEvbX5gqq/CUyo8UJ7aXbFT1hB6nGPT0VKRZ6lPdgMg+hAOJp+4FZMby51YHx5tmm+GDruSzcviGVcn195iuyDZE1iDh0WpN9qX4stsaXE9iB5sAZ+s4u0DjQHoi+5bHPo5mCj2l/o7FPF3Rz2bnBO/rkbqVXtmqR2gt2fnkMc3qsY8K88VjtstwHZJ6o4jl24Magc+SkHkSc+0w4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(122000001)(38100700002)(26005)(38070700005)(31696002)(86362001)(6506007)(478600001)(6486002)(71200400001)(53546011)(5660300002)(8936002)(4326008)(8676002)(76116006)(66946007)(66556008)(91956017)(64756008)(66476007)(41300700001)(66446008)(316002)(186003)(110136005)(4744005)(2616005)(2906002)(54906003)(6512007)(83380400001)(31686004)(36756003)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2JQQmxZZjJudkJXUWFiR0FWbDU3ZlZUVGNnZVFJTlVOMkJjb3NFVWh5NnNW?=
 =?utf-8?B?OHUvUEdYbE5weDRJWDRlUXJqL3EwaUlTM1A5TnQwSkN5V1ZlSDM3SDZSaGpW?=
 =?utf-8?B?ZTQva0FoUUtyNWVjc1l5NEVRdm1VbmJQS1dqRmtDRzRJRHdKK1loNkJtTStN?=
 =?utf-8?B?d1ZRamFzWW5nRk5GN2h4d2VqZktvWDdraVdPRDYrbTJESlFIVlk0Q3VOZDlN?=
 =?utf-8?B?SDBmYVRmbE5KKzZIZ1FBUElqTVlvcktuYzVzOURLdmxKTWZwV3h6TlBHWmdV?=
 =?utf-8?B?RnNaVlBCakJZRER5TVdPd2tvQjd4d1J3dS9rc3ZjZDBnbWM1cGN2RGdaUTJY?=
 =?utf-8?B?ei9YdzIvd3VoT0ppQ2FobEI4L2U5bmxXVGhlRXFEdERqS2kxT2ZlM3hhRVRT?=
 =?utf-8?B?Y3NFOVFTR2ppRFNrOU96S1lEaGVJT3V6NzR4R0tzamRra0FGSk5KYk9XZkhi?=
 =?utf-8?B?UjM2WTNKV0dVNWgvaHlZZG55TzA4QVFncUI4STZLS2RXRmgxcnlNRG1ZSnJv?=
 =?utf-8?B?VmhiY2FIc2xTYnBHakNqcEVOOGRsYW9UL3JKN0ZqYmN2RFBEaS9LUFJwN0x2?=
 =?utf-8?B?MERwNEVuS1JwNGkrZklwRWNROW9naVdyS2pheGh2YzBTQVc1bzJOK0hVaTVh?=
 =?utf-8?B?V1Zhb3JYMzUvTEdoRHRuS25DT0ZPL1o3SDNMMU85b0xmdHlPc3Z3Qi9oTHBE?=
 =?utf-8?B?N0Nic0czYmFIdmU3YVg3aVlLS0RwNXZyUFYvYXJXQkZVc2VUdVY2bTJ0TW04?=
 =?utf-8?B?WnhobnRZQWx5bUNMbnBtbEFvaW8vUEp3Nm5rYTRDYzhoUXlSUjkrTk5FZDJ4?=
 =?utf-8?B?QXY4WFJJQTJtUmg2SDh1aTY0VjJ0eXBBWnpYQVlnaFpXamV3VmRWTmFVZHo1?=
 =?utf-8?B?eVVmb2dHeDFwZm51bld6bnk3K0pxT3NOZEY0bTQyYWFwUzA4OFVXdExKMmsr?=
 =?utf-8?B?bTU5YTBRN09sVTlSa1hyWGRaSERqcWlmZlNNYnhnS2I3Z0E0UFBNTTRUT1VF?=
 =?utf-8?B?QmFmZHE2U0tZWGhrSWNneFZJMk1LTHVKT2VsRTE0aFhqMkhGL0RQZVUwWEhX?=
 =?utf-8?B?azZLdFpIcGwvb3pwUnZ0UERwcXk0U0FwR2txcjBRMm1ncGNJL2JZMjJtYUdG?=
 =?utf-8?B?dk82U0lNOFhzdHA3Snk4ZGZxV25JRGxVcnJQSXg4aytUTWROaFhweHlaZkNP?=
 =?utf-8?B?RWhSMzVXVU9RYlFxcGFOMGVvVzFIOEVDbElvcHU4MWlkQU9pOExzaElUY0Z0?=
 =?utf-8?B?Qjlqd01sSFA3ZzJ5eGl0VVVLQTIrcno2SFU5b2hwWWQxakhyMEQ0MVdsLzFD?=
 =?utf-8?B?ZWxHWGhYaDdBTFdFbkZpY21Dei81NXdxUzEvRVB0anA1dE1GZWJlNUN3NTVn?=
 =?utf-8?B?RCsxc1h0eHM2RmY2R3pIYTU0RnIydU91bnphR3V6dEFqZTNRSm9wa3ZhVVIw?=
 =?utf-8?B?RlAvbCtMd2JraFlpc01VZjZBOUk1SXVJSWR6M1JOTjk2eHF4eGo0TitaNk13?=
 =?utf-8?B?S2Q1RnpoVjlWYTdCRUJCa1FFamZTc3NQWWUvSEQzUUtnYXd3RVdxTnpOcms5?=
 =?utf-8?B?d2dtOEVpTTZ4UDUzSDlHWkpCekxxL0J0cWg0c2ZWcWtpU2ZlVnA1dDFCc2hD?=
 =?utf-8?B?dFV5SW1nWXdZbmFQTnF6aHB0b2pmdGx4WG9DR1loWitHQnVVV2ZOUFVyekJZ?=
 =?utf-8?B?eE96VTAxVWpFZVptOWRJSUxDdW5KdmxvNW5sZVdUT21KdW0yclkzOTZ4bGcr?=
 =?utf-8?B?V0lZcGx2ZlJQRlErbVJoZGlvcjhNNUkycFZpMC9FaTA5ZUFoTjk0SE05MnBR?=
 =?utf-8?B?cUZWY0JBRDc4TTlQUlRyVGZXMjFpYmZwZ3VvTElsbnkwbXpIQVV6ejZ3RzJG?=
 =?utf-8?B?dnRxTlV6UnBJTm0zNUJnVTlMa2c5aFNpNStPU1YxWTU1TGs2MW9Ra1gyNmVE?=
 =?utf-8?B?MlJYUVZhcjdJNkRTN3J5M0NUeXZpT3JlOFhQU0RXdXhoT2d2RUl4UWRCZnM0?=
 =?utf-8?B?bE9VenRsTnBDb2tuTis1alBndlVmWXI1cjl1TURnaWNIcWE4Y0l1MUNYSVBV?=
 =?utf-8?B?WEJMc2Y4NGQreUdOL3JXMHo5STlBbnAvL1AzZG9naHV3T3lhWjlpOEVURlBD?=
 =?utf-8?B?WnR2SDAxekd0cC9xdHlvUGRqdUMvdG1kdzJ6OEgvZVRIS2dhRHdEMm5nL0FC?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4DFF407C7CA3343AFFFA7219A33B979@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846df211-2fe3-41d8-e925-08dacbc55240
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 13:35:57.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GB2Uw0zQoNaFWb+Ds/fu4tE8DhUP/usWLSlm2Y9vsx+BCrNz8cibyDk2VfCVaYxzYNhAgVdGiwd7uDlQk53hFz/9GHCFAflrIHog0q75Ojg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMS8yMiAwMTowNiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPdXIgU0ZEUCBwYXJzaW5nIGlzIGV2ZXJ5dGhpbmcg
d2UgbmVlZCB0byBzdXBwb3J0IGFsbCBiYXNpYyBvcGVyYXRpb25zDQo+IG9mIGEgZmxhc2ggZGV2
aWNlLiBJZiB0aGUgZmxhc2ggaXNuJ3QgZm91bmQgaW4gb3VyIGluLWtlcm5lbCBmbGFzaA0KPiBk
YXRhYmFzZSwgZ3JhY2VmdWxseSBmYWxsIGJhY2sgdG8gYSBkcml2ZXIgZGVzY3JpYmVkIHNvbGVs
eSBieSBpdHMgU0ZEUA0KPiB0YWJsZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdh
bGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiBSZXZpZXdlZC1ieTogVGFrYWhpcm8gS3V3YW5vIDxU
YWthaGlyby5LdXdhbm9AaW5maW5lb24uY29tPg0KVGVzdGVkLWJ5OiBUdWRvciBBbWJhcnVzIDx0
dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICBkcml2ZXJzL210
ZC9zcGktbm9yL2NvcmUuaCB8ICAxICsNCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jIHwg
MjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDUyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
