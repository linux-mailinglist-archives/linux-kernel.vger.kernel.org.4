Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E94A66D83C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbjAQIck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjAQIcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:32:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20F18AB7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673944351; x=1705480351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CChxj8JcPp3jceyFWR3ENTE8M+5nkbDPZv8by4tDr7c=;
  b=RT43BWsF9qXnZcURN0cbdMcc8ZFPsLK8XNYncB51s0DsY3+aAP8jRh9r
   J4nlgSUEMAJu8sHZDws1nQ3f0JxBqOMn5V6VAjgXbhK9jLW3HXHp0t4/J
   LSQe0QocWh9uYF1/JtBoV5znIen33jCAGJUHd0eaO5P6lNWuwGziSE4B0
   U80MBLNzl5ijURV3e8zRvmx4Rnixwr3AklSRcZ0cjItHA14wknaRaELjg
   QB1GkhPwfx0aB7CN2XhmTacQtCQGxJhwyY49TxuZR9mUhxC+cScsZQQ3I
   qgmv/QceO6niCQvdIhh1TqxlEAqiBxfcC9JYtUKxogt+lVuDvkgcSiphT
   g==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669100400"; 
   d="scan'208";a="132672223"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2023 01:32:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 01:32:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 01:32:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPY/gQHy3S1AbHrY+WSsdIoitllTlML9jtPmwJkUoMZigjakhXBtWOPVxj41MXttDNEsezx4au4slSI65LNy316fTrzEyXWX/6tf/KgrBcQC7+Ugv9qmyKoO92fdiwaHTfb+9AiPAO1aPXqeYXYpdPZjAKNTgapx9ryF8Kh176LSAjya819KiKIYekS5rw40vUyfQESII4lMgGuYgdjNIgKdfnoIxIb/nuZoROgJL9Fdr+qH/hN0aFNaGDueW3aWDZWXwKODGgAnyOidsNwcqas9C+UrKmFRlPNBDi0zw9Y18I4K6Gfhq/lN0MrK/5cfOjDAl0Iv9fLVYvWij0gWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CChxj8JcPp3jceyFWR3ENTE8M+5nkbDPZv8by4tDr7c=;
 b=aZOpujuZmeiouPzxJM4t34rHUQu/vOUJgznl8YdETm73U/zmG+FScbsb4FoQZM4lTJjqNVyDOYAxPyFvbJc7EahXGByQjQPzl/NK0lNZaMuDK0uj80mKe5n4n90Fr40p25GUEEwPkEz99rx49s5sr0KPfpc2NW/adA22YNdavW7MN9SjUbBEXhfJUFGyhWeSzYzx2R+R81qIlpeRShRQE7FSTudVw7WOXLJxGHuvAh+KkMWR0hqk5xRg0oM/KiRHzupm5XsoeAbAIAJHoCkc2j48jRprqxwXTPEIZ3qFDpyEwRWptzuQJr5K3gR6km+M/oK57SPXofgu/6WN/6dqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CChxj8JcPp3jceyFWR3ENTE8M+5nkbDPZv8by4tDr7c=;
 b=ogCzJc9lIoljMlHSNt+jgwZRNvFKHedUow6lZXhxGgOEP6Rno0S8sOQjVaBajdkNePCuLMucHpqXoyKhXDDJ3c0ITWenItNcFYEQjJqgoUX6XrI0r8QWH+2HphbUF1jskjvff1R/5Zqpd2Skg2jKX3pxqMPNupkxe78SyHDCTDI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 08:32:28 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 08:32:27 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <andrei.stefanescu@microchip.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] regulator: mcp16502: add enum MCP16502_REG_HPM
 description
Thread-Topic: [PATCH] regulator: mcp16502: add enum MCP16502_REG_HPM
 description
Thread-Index: AQHZKk47GjUUcUTSe0ameWkCEop7Pw==
Date:   Tue, 17 Jan 2023 08:32:27 +0000
Message-ID: <c8a2c56c-b372-6888-404b-7f548e52275e@microchip.com>
References: <20230117070139.28905-1-rdunlap@infradead.org>
In-Reply-To: <20230117070139.28905-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH0PR11MB4855:EE_
x-ms-office365-filtering-correlation-id: ff387b03-449b-43b0-dd6b-08daf8655e07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85ItvCSHemwLy7xLj5WHFmNxHEhMw9cRq73jLWsFEJImmj+esnsF8sl001M+SBK2cMj6Ndv1AZz7N1eqz6amn1T48h6QVtwY2Eba5CDkCmuH99bGjN40eWdXuWbfozoBLZW1BZ20myOOY0oqMSW/MFaqXkR6gHnesMcTtchxlcrc5sp+8wB2YNJ5vuKmiEiL6HDmJGMwRX42QJllmsLX6PF2RT6TQ1ZAoqfHRYtl9OIhUCtjalk4LrJ7LttQ4xQk45vngkTqg/BgibYt9fo6NGSSYShy981eJ/qXd8rMnMJG8asCuDS9QfWhACceJehE3yPUrvmkNx0++ccpggu4/XRKqXzwPAZmsES2xrP5xBw3YO7mLVyB+6tV7+AyMKIUhx08IWFIVlGqls8ZhNVUrrNXSzhBtcS0HSICacHM2L3RIgzCIanq65MlF6UreQcpCZxI4JGjViW/FnjVgT1kuZsZEmpIx0p5t5YvVHxDota2jbe94uwb/8zlXSVtQn6Vz3sPgCLdqoVpKiOedC19SYYvsFo6C6ccg8kO4NL3+8/7NBpSRHlZkhUQ7G8HRMS1L6ZUcUjnJ2c10oQPNpGAIBEuNAaKM8JkV2ZQQ+yfTh0EuUKkDxG4lLbofNJC4tmVk0GX9ginHFRden6a7Rvg50Gi3Adw5vyJcxHK5KlQCuvyynaPSpnTeuY0Wfrs5BU9xLCUSz5MdHay8+rR6FXl7xUMJwiVGGMiUZQXnvpXsSa7QiyTxjpFdyJKptHuJZNx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(36756003)(53546011)(31696002)(86362001)(91956017)(186003)(4326008)(6512007)(8676002)(64756008)(26005)(66556008)(41300700001)(66476007)(76116006)(66946007)(66446008)(2616005)(71200400001)(316002)(6506007)(110136005)(54906003)(478600001)(122000001)(6486002)(2906002)(38100700002)(38070700005)(83380400001)(5660300002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0ZkTVVjWTl2K0FNQk8xVjN3UEQvbGEyWjZGcWhIWnpuSFFaTUlkVkdYNG1i?=
 =?utf-8?B?Q0VBYjVmbFhsdG9VZHJadDNnWGxpL25PdFZvd3pLeGhDS1l4UXlUb0xrbW82?=
 =?utf-8?B?TWx3TTNrQ1gydEU2Snc0SFhEZFVEQ3pSTTVLZEt1UnNGY3hzbGt3WFFXQTdJ?=
 =?utf-8?B?TlMvdU9GQkx2SHM0eTFQeDNXa3RWd01qTWd0VlZjZmE0cnNQUU9ldzNsbTFT?=
 =?utf-8?B?UXltd1NvS0o0S0k0NVc5bVQwRW4waitxTkV5di84Q1hLRzcvRWk1VkFSNjhh?=
 =?utf-8?B?MVkzZTRPZzM1T1NZcnN4YUpHQ0pVNjZHRkJFcCtJWU1YYll1TTYxVnZyMUVC?=
 =?utf-8?B?d1pmV0YwN0dZcUJBVC9yYno0WEZPNmg4a3FvaWRZWmRVOVFvQ013Wnpybmhr?=
 =?utf-8?B?YzNvQ1RnaFRJMWJNQi9WRHZ0TVZTMzFVcHdRbmJ4N3dsU1BqYTNjUUFCSEk1?=
 =?utf-8?B?K28wRFh3WEFCaGQ1UndBZ3dKR2s0OTcraXNsOWFubW9DYzNRM3gxQm9iMFl4?=
 =?utf-8?B?SlNrRWpOS3FiUDVpaDhEOUN1ejBhSncvSnBqcjhoZ20rMGxUbkxXSTlaaHhX?=
 =?utf-8?B?czh3NjhKeXA4bFozQmRSUDFEclZLMGxNZkNkV1BVZWdpWFVQdjI2SlBma1lY?=
 =?utf-8?B?TUxaWDNXeC9CZjBkRDlvT0htb2pTQy92L0RPWVdmZEkrK1FTbXBaODRKa1FY?=
 =?utf-8?B?OVEveDNNMDFmbUpSczNqRkFqYXZZbG1NNVR1VUZhVVFlQXFzNmU2ZGY3bElS?=
 =?utf-8?B?b292b05DUTFDMXR2dWxES0xqRHRNWFVBVTQ1dXZsQjRrMlRpVjlPZ1FLYXVX?=
 =?utf-8?B?WDgyajR5WFcycXd5aTFTNmw3RngxdmFRTTA0YlJvKzlibllONkU0V2ZpV2Qy?=
 =?utf-8?B?WUNnWlF3SzZPN1ZUQk5vRnF6T21nMWR0WExWN0dFWFF2VWpadWNkYWdITGdp?=
 =?utf-8?B?V3FOWGdJWXVCMURtaFd6bEdUOGZIWlBpL0N1aGluMDZJaHFVbnRaNlVuY2xp?=
 =?utf-8?B?eDl5WnJjS3BKNWhKZ1R2QTQ1MVZDN0JVdXlkVTdqY0JGQ3Roek1iTVRYSThR?=
 =?utf-8?B?VDNvbUtpNlpjdnhVTnllS1BuTW9vdWNMTVVyejlmWVlab1R6VlRzNEI2ci9T?=
 =?utf-8?B?Z3Fxa1BwNEJjWWttcWc2dy9aREVTUmp1Y1NBZ2dZWWNEQngxN2pXZzRxSytI?=
 =?utf-8?B?Zm04b21GQWErdFdRY09OWUV5bTNDZm1IczNyczR5VG1ZY0w3OU1UaVdrczFN?=
 =?utf-8?B?Vlo0RG15V2JwbFZoN2NBSWQwY0pGT0ZNYnhvcGhJY0dtTHEzeTdvTFhKYmdp?=
 =?utf-8?B?QzE4VFM2L0NJQzJvRFhBdTFUbEltVldhajBLdDAyc0duUityeGREQVpabTVW?=
 =?utf-8?B?ODdaZnczZ2VLdW8wTVdJSUZ4N1JGWUE2SmVZUGFxQ1Mva2dIQmkxa1NSOUZp?=
 =?utf-8?B?RzNwNmNOZkw3Nll0c3VHVFM4MjZPUmVhL2xKNmpiTkZoN0RXam5qbnZCRW1J?=
 =?utf-8?B?TmVJMnBWM0gyVUh1TndxdmxWZjJIR29TODNuQk1OUWduY0FTNTFBU0h4b0Mr?=
 =?utf-8?B?b0N3N1dvaDRGak1yekJZU0RCblU5OURkcnMrc3VCV2pDMWRzSFljVmRtRis5?=
 =?utf-8?B?RWx2MUR4NnJROEQydHcvZkJQMGNYK3NjNjBmYkZzcnowckpWbGpoZEM2VXUx?=
 =?utf-8?B?bjA5bXJHdGVhWFpkSUZ6blVabVRnZ0VsTXNWOW50czd6UWtwS25oYTVWVHdv?=
 =?utf-8?B?VGhxcVd1REF5cTNqV0pnOUwvSjlsK21BWSswcFJhMTQwRm4zbXBJR0JPUEJr?=
 =?utf-8?B?UWc3bDdyWmpzd0c5Q004SUQ3QUFkSzBWM3VZYmFISW1GWEN5dThvR2pkRGVC?=
 =?utf-8?B?bGtoRDhlb1R2eVd4bHEwM3RGWC9MTU45dHJJV1JsODQ5YUp4eDBsOE9KcjRK?=
 =?utf-8?B?Q2dMa1FSVzRqQThuOXJjd2xmN0V1c1E3eWVYcnNGVU5ud0VNMWtuZjRWbldx?=
 =?utf-8?B?ZzFxSUxlc1N0enc3emRuUmtnTjZ2TDIrN0VQQklzZ3FwZ1g5Qkh2RXJ0d2VG?=
 =?utf-8?B?TEtGOFg3b0FCaXMwOExDL05weU9VWEQ5UDZBNDhJUFRpdVJPNld0VE54bXA1?=
 =?utf-8?B?Skk4TW1ZNGFYbG1vajVZWlVudFRkWmVjMEtPUmczUCttckEySzY4OHpMOE1k?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCB3248C64E1614E94B91581A498D56F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff387b03-449b-43b0-dd6b-08daf8655e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 08:32:27.8993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCzSKcP8fgYu3cR2lH+D+KmptymGzZJvYgangs4rawXV9ZQxvT4Rpi2PurRlj3IC9u6H7wdZh1JO7V53k7pEh1Qaordu4QFAmUQb4W60tEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDEuMjAyMyAwOTowMSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFkZCBkZXNjcmlwdGlvbiBmb3IgTUNQMTY1MDJf
UkVHX0hQTSB0byBwcmV2ZW50IGEga2VybmVsLWRvYyB3YXJuaW5nOg0KPiANCj4gZHJpdmVycy9y
ZWd1bGF0b3IvbWNwMTY1MDIuYzo5MDogd2FybmluZzogRW51bSB2YWx1ZSAnTUNQMTY1MDJfUkVH
X0hQTScgbm90IGRlc2NyaWJlZCBpbiBlbnVtICdtY3AxNjUwMl9yZWcnDQo+IA0KPiBGaXhlczog
M2U1NTMyYTAxMWIwICgicmVndWxhdG9yOiBtY3AxNjUwMjogYWRhcHQgZm9yIGdldC9zZXQgb24g
b3RoZXIgcmVnaXN0ZXJzIikNCg0KRml4ZXMgdGFnIGNvdWxkIGJlIHJlbW92ZWQgYXMgdGhpcyBp
c24ndCBhIGZ1bmN0aW9uYWwgZml4Lg0KDQpXaXRoIHRoYXQgYWRkcmVzc2VkOg0KUmV2aWV3ZWQt
Ynk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQo+IFNp
Z25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBDYzog
QW5kcmVpIFN0ZWZhbmVzY3UgPGFuZHJlaS5zdGVmYW5lc2N1QG1pY3JvY2hpcC5jb20+DQo+IENj
OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gQ2M6IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAyLmMg
fCAgICAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAt
LSBhL2RyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAyLmMgYi9kcml2ZXJzL3JlZ3VsYXRvci9tY3Ax
NjUwMi5jDQo+IC0tLSBhL2RyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAyLmMNCj4gKysrIGIvZHJp
dmVycy9yZWd1bGF0b3IvbWNwMTY1MDIuYw0KPiBAQCAtNzcsNiArNzcsNyBAQA0KPiAgICogQE1D
UDE2NTAyX1JFR19BOiBhY3RpdmUgc3RhdGUgcmVnaXN0ZXINCj4gICAqIEBNQ1AxNjUwMl9SRUdf
TFBNOiBsb3cgcG93ZXIgbW9kZSBzdGF0ZSByZWdpc3Rlcg0KPiAgICogQE1DUDE2NTAyX1JFR19I
SUI6IGhpYmVybmF0ZSBzdGF0ZSByZWdpc3Rlcg0KPiArICogQE1DUDE2NTAyX1JFR19IUE06IGhp
Z2gtcGVyZm9ybWFuY2UgbW9kZSByZWdpc3Rlcg0KPiAgICogQE1DUDE2NTAyX1JFR19TRVE6IHN0
YXJ0dXAgc2VxdWVuY2UgcmVnaXN0ZXINCj4gICAqIEBNQ1AxNjUwMl9SRUdfQ0ZHOiBjb25maWd1
cmF0aW9uIHJlZ2lzdGVyDQo+ICAgKi8NCg0K
