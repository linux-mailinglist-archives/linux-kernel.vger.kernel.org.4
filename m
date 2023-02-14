Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC36961EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjBNLHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjBNLGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:06:43 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EDA2820B;
        Tue, 14 Feb 2023 03:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676372760; x=1707908760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DdiCfgZ9rKST7/JIbqzZScbpYDeb6Yq4nvd8xE9fMhY=;
  b=1Kl6YRxIVp/Skp4Cf8hN+qYgXJmrQoMeNwau8ymk/jQXRLhgdB95rvB4
   AvdrjL1nw+ywmdF8yeafmfEyVDIpSEDQRtQhZOYNTqDNkA4RH/F+b+0iO
   vz6tn78uG53RAOButmUyyfntIWu4DJzvbpKxGDNjvLWuqFDvyIQmhzIRJ
   lth5VLc+RKvxNUwf+eIXnDe5+hx2WjJijKebcawAfiXJtKOgn+UXL5bRP
   bJawUEhCm0jx2w0CP0g/22TIXTxxgu/GVNQ+6o0ZLlK4yj+yEm58X0gkH
   9EuMhu8ISSYyGXnYhgMbfelWPM/OxcCJFyAsf1OpGNgHWwvuNssJ7EUWt
   w==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669100400"; 
   d="scan'208";a="196828471"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 04:05:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 04:05:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 14 Feb 2023 04:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQKB/GDxJ1pujA0bP5JAUka81HfNbY2BsFgdopitEDWEvqoMkC5T2/QuoAIiAHdcWQhBzfSprxuFUHm+EjXA+BG80vE8oN8Fo2Z6yNRB8R81j84D9ZoediGptM5pABj6lA6W+qWSir2qcyTxTqFGv3v7T+1JTfsqkKC0qXIBnYzeOuwyB5jzvse5uWYoP6bmI/zXsDunYt0BLcHe2G9kANG5gJE+K48nREoQohFBIPV1brNrRZuu51yjhBFaOgUNsH+vaHZv4W8PGuJe62Cit9JaQzeLjcGQrZADlg54elFWcNYK5uXqH3M6WpNQpllwKIor/KtfySLhldlH3YKubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdiCfgZ9rKST7/JIbqzZScbpYDeb6Yq4nvd8xE9fMhY=;
 b=XR0nM+iCYmhst61E+fqLewWmjbq/PRqRgIEN+MimeMfljfS8FyXx4WL46K0MFwfHIVkBRm/opNJLpHYYdVngdYx5hfI3/lM9XW1tvbZVeEFLZNVpzCJslc+WNgSH26Pxefy1SUYSUUrEONiRDwZQbHqzN33uhYQwqTEV2tpF7246hvVWNKqTQCLOxO3CWHE1n36HBGJmSq7sC4qLzwIRb9iQPzpZTFS2hDpzh/6gSPfq7qZOyXqNrlMzZPwViaHsj7AdNdB874W5wv3qD8Sl2zVGxw63XLbKw/LllTGtWJz7gX0j4r5A1lbKIerYKwss7N2n1R+F3bXZY8ycWmttCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdiCfgZ9rKST7/JIbqzZScbpYDeb6Yq4nvd8xE9fMhY=;
 b=rXwjCSzo1cNGm2Bye9DnAU2jfIlsRIVlWVcZ2ZF4WwFoI5sDBVGjOytiSPN5wgzP5IoImMzHQtYfJH30+DdNIDQBLZl/d2Jk+mCjbVhrtU1pUPfLErNQSXT9dzzv8pjBCd9CjneYGWqGBIGRvldY6c1y7XXdchh5wLi7duLzMAs=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 11:05:16 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 11:05:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <linus.walleij@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 2/5] pinctrl: at91: Don't mix non-devm calls with devm
 ones
Thread-Topic: [PATCH v2 2/5] pinctrl: at91: Don't mix non-devm calls with devm
 ones
Thread-Index: AQHZQGQ3G4Ywg7p7kkCcw/CDeF/CwA==
Date:   Tue, 14 Feb 2023 11:05:16 +0000
Message-ID: <3c58452a-1db9-a16c-b25c-bd21b36884f0@microchip.com>
References: <20230213154532.32992-1-andriy.shevchenko@linux.intel.com>
 <20230213154532.32992-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230213154532.32992-3-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SN7PR11MB7637:EE_
x-ms-office365-filtering-correlation-id: 1f9d93a8-db53-4045-ae68-08db0e7b5a69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XjDkPAs0Ru/SUMBkqdkZEALVVlATArwN4heZil1WvfGnOXGdgD5In1gEmIRPY1Z+FMbh9aVRRt/clhDudaPMs05udixcqzv6uqEqTP9mUkIvkAwdakwikYRsXcV7BRbr1CkoVOoeDpwv6jYvMDea84iv8V/RHetSyyYsCsRuL+3IThYIJTueLEjEmy07Ia8JGqPjKKKpjaKAJoGhmzRsFU2wvftJImWbIzC7Lr8OZavJIlmvHvvq7AVUyTwsQxHNJsTnqfuai7ZX4ItW9o4YpB9j3JLcNYeglEKU8UwirC2AGghzLATYq+ad/H9q8dS/c8I2v/5AMW+Kll9YW6TOSDuqdJ9Vu81WSVXxWVJpj2Qb87+yH8cF0kiPW8XYkt+KMeLzWmBBDfQCWyNRBrdQAyqV0qfBFQF6816r6UQrYaYA11gLf4F95W4modgHjviQVBaUEXkEXqimz7DFFrT8CvsfXI3kjIfns2oPzgMLmJFHu2s6qxJJg5mMiVhgafkUAM6Odw1YqzQ5hM1uxwVKr2ICkYLXxRqfhNw81WCN0gzBioHnymfCETeLt1iDzNR7SnvpyqVHOEAXkFLzPkmRx6RW9NUG4lQnLy/uOsTCB0uTtl6dZXZu1IlCgM+Mh3mcPj8UQI6xERX/AVBA2K0hrnPsjBDh6AuC5wwPu0dzCc4xkboEuZUVemRnMMDnHpYrtPbzB9QaOo8tOqNu2vo5aDSwYrjWnwlGkBxUW0vWcvcUr/nvGDCzsh9FpzYsUbG0J94zQ/99i/Hcw+N2vWDF/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39840400004)(346002)(376002)(396003)(451199018)(2616005)(122000001)(478600001)(6486002)(36756003)(41300700001)(31686004)(6506007)(53546011)(5660300002)(6512007)(26005)(186003)(8936002)(2906002)(66556008)(38100700002)(71200400001)(31696002)(54906003)(316002)(66476007)(110136005)(86362001)(38070700005)(4326008)(83380400001)(8676002)(66946007)(64756008)(66446008)(76116006)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3g3MzhRSGpXekk0bi9tN2VpWXpZMFN5VFNtaUtHVHpIUXZmYy96cGpFdDls?=
 =?utf-8?B?dVZYRzlEemcxL3hFVjI4NHl1UlBxTlhmNWp6cVlram9IcXRtWmJZMEdXUDlw?=
 =?utf-8?B?ZklPQmVjT2NhZWthN3dTakFtSkNPL2NEUmNvMCs0U2JBcU95WjFhLy9BTFpQ?=
 =?utf-8?B?UTJBV2s1TExnU2cyN0lKY2IvWkFmakRZcTNBRzVkbWF3RkNSZURob3NianFQ?=
 =?utf-8?B?dlp1aytVTTl1a0xid1laYVFETjIxZXByNnpjVVMwU21NOFhBMzBCWU1na1lR?=
 =?utf-8?B?WXg4T3A1NmVuaDBmM09Tb1piMjM3ZVpDb1RvSTNuc21ONllGc3FBU0laVnIv?=
 =?utf-8?B?eXhwNHAzTlVCZ0ZUUjRTVGQyUlB4UVZVY285TlZMeWcwRE02TktwaW5nUnRY?=
 =?utf-8?B?OHZ0dmNyZml5VkNLNkYwdHlJQ0ppWVZhcFd5djlkREh0bDRLUXZHMWtNbTMx?=
 =?utf-8?B?dkVaeUsxc2hlT0NzRDliTW1aM0dncHMvWnZGTFZBZUlJY2l2cjhxUHJRQUw4?=
 =?utf-8?B?SlN4WHRKNStjTzJWa3RKdU9Wa3hsMmdtd3d2VXNMZmNUM1U1RW5sR0QydkQ1?=
 =?utf-8?B?M20vZUwxamtGWmxSWk9heEJhKzNoVGdja29OdlQ3YWJqSm5RLzJyMmhZMTN6?=
 =?utf-8?B?OWVScDFCVU02cmYzUHZma214clM3N0xHVlZsUm8vbjc3KzdYTlIrMkNPSUNM?=
 =?utf-8?B?S1pYWUVmWklEYzdpWk4vQkRsajkrM0FvT0tkYzJzRGt2RE9PRzVCd0ZlQVZD?=
 =?utf-8?B?S1RJKzhjYzdidlZyKy9jVGlaeStBQ0U3aTJNOXlpM21BYWprSlltSVdlUThC?=
 =?utf-8?B?MFFwNHM2UzhQNE5IU0J2NGkrWlN2VGZ5TEViTmZQc1V2MjRkRVdNVTk0TXhL?=
 =?utf-8?B?Z1JpV3p3TEZKMkNhOE1jL081eHVrNldpMld6bzJzUjRUSmdmOFk0eDBDa1RT?=
 =?utf-8?B?bE1LZmp6Y0JzNDFKVWRzQVExWE5VeHh3Rk8wdXpSNmlsdmNPY3l3cVU4THlC?=
 =?utf-8?B?d2N4bVFPK1Nob2NFNUQ4QmJDZHczVStEUjdaRTdPQVVvWWJPSG9wZ0FLL0tO?=
 =?utf-8?B?VkJpUkU5SzhralExN2Zkbmc2M3lUK3NyOTBBZFFKMzhybmVtaU9HcDYrdlFs?=
 =?utf-8?B?SHQ0TnFFWktQZ2M4WDhodDR5ZjRUVWwvZy9BK3VkNGxGUDRRU3ViWmg1MmNY?=
 =?utf-8?B?b0FKNU5CTENtOGt1ZVVtdHVzT2ZYd2M0STU4U2RmRGQ0M2szR3BMZlB3cEYy?=
 =?utf-8?B?bWR2S3VoYm1vUlBlS0hvWWN6T29rSFRNRVJDVktLWStNaU1WdXJHQkQ4NGJt?=
 =?utf-8?B?cEVrOXhKR2lWa1lneTRsNmNNcFYwYWlUM3VRekdEbWZyei83MjRyWW5PY0ZR?=
 =?utf-8?B?M0VDL2xjVTJOdHcyOEQvNm9jTkZSRUx1UmxDVFpRSDlLemtTQk8wdWMrYlo0?=
 =?utf-8?B?cXNhcUVGcXh2K01CanBaRjNETWliRGMzKzhDS01rWWNWM2lqa2krVk5ZMG1x?=
 =?utf-8?B?SityVSszTGcrdXgvSUlnblkwaE5Xb044M1NoaHRMaVMzOTM5UWpiT2tLSTlC?=
 =?utf-8?B?eDA3NEFTQ3BSd3dmQU1BdkU5bUYvYi92NWcyaGtZUjlmRVQ0MGREM1dtSDFz?=
 =?utf-8?B?Q0l4clROcFhRd3FqLzlqMnMzOHNHRkdOK21DSWs0bWxIVWtZemtQKzNMMFVV?=
 =?utf-8?B?ZkVpK2pJaXA0ZVhFRGtQcGdXRlFhK2ZYYnJKaTk3cG1SbFhabnRnWndTVGg1?=
 =?utf-8?B?dUJGR0pzWXVpZU1pWFFZbTB2bUxMbHBuWmV3em5URGpJNitJVUNXSVNBQTlR?=
 =?utf-8?B?bEpDT1NlK1FYai9EQ0liRUZsNjhCMS83R1krS250MWUxTGk3TTRCZW8wblpC?=
 =?utf-8?B?SlBVTXYrSTA3NjFuajBFdHJzREZBaVBLMGNDMXc2elorcURqNGFmVEpqamx6?=
 =?utf-8?B?azNMSCttVkJMMWhtS3dldkVLVk1XYTNDQldBMWpBN0ZSZHRQUUlqcm4xMWE1?=
 =?utf-8?B?WTAxTXk4bkN0Q1pSSUVBRHh5S3NUbHpOQlNKTnVZaEtHMTRMUytFM1EvOE9Y?=
 =?utf-8?B?M2dKQktoZmVhT2lKQ3l5YXd5NXozYnROR0Z3QXg5YUQ4OUxrZDZ5U3pyYWZE?=
 =?utf-8?B?eFFJOTZWdTBsK2Z6a2ZacVJycHhrdEF5b2VnQ2VXOThFWWZEWWhTTENhdGVi?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <348C35C7F746B2488EBD7F5A8F709798@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9d93a8-db53-4045-ae68-08db0e7b5a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 11:05:16.3386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j22xJ1c3Ns+S5AOgy8Ab0GwjjcyKkdUONZnSJ32niszt/Vq8QB6yIYvHEN101Li3mYvZghGl1eQEUwKUbZfcdhC60ziHjaPx7UvE7mR6XNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDIuMjAyMyAxNzo0NSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFJlcGxhY2UgZGV2bV9jbGtfZ2V0KCkgYnkg
ZGV2bV9jbGtfZ2V0X2VuYWJsZWQoKSBhbmQgZHJvcA0KPiB1bm5lZWRlZCBjb2RlIHBpZWNlcy4g
VGhpcyB3aWxsIG1ha2Ugc3VyZSB3ZSBrZWVwIHRoZSBvcmRlcmluZw0KPiBvZiB0aGUgcmVzb3Vy
Y2UgYWxsb2NhdGlvbiBjb3JyZWN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hl
bmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBD
bGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NClRlc3RlZC1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+
ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMgfCAxMiArKy0tLS0tLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEuYyBiL2RyaXZlcnMvcGluY3Ry
bC9waW5jdHJsLWF0OTEuYw0KPiBpbmRleCA1YzAxNzY1YzdhMmEuLjZkOTAxNWVkOGEzYiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jDQo+ICsrKyBiL2RyaXZl
cnMvcGluY3RybC9waW5jdHJsLWF0OTEuYw0KPiBAQCAtMTg0OSwxOSArMTg0OSwxMyBAQCBzdGF0
aWMgaW50IGF0OTFfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
ICAgICAgIGF0OTFfY2hpcC0+cGlvY192aXJxID0gaXJxOw0KPiAgICAgICAgIGF0OTFfY2hpcC0+
cGlvY19pZHggPSBhbGlhc19pZHg7DQo+IA0KPiAtICAgICAgIGF0OTFfY2hpcC0+Y2xvY2sgPSBk
ZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgTlVMTCk7DQo+ICsgICAgICAgYXQ5MV9jaGlwLT5jbG9j
ayA9IGRldm1fY2xrX2dldF9lbmFibGVkKCZwZGV2LT5kZXYsIE5VTEwpOw0KPiAgICAgICAgIGlm
IChJU19FUlIoYXQ5MV9jaGlwLT5jbG9jaykpIHsNCj4gICAgICAgICAgICAgICAgIGRldl9lcnIo
JnBkZXYtPmRldiwgImZhaWxlZCB0byBnZXQgY2xvY2ssIGlnbm9yaW5nLlxuIik7DQo+ICAgICAg
ICAgICAgICAgICByZXQgPSBQVFJfRVJSKGF0OTFfY2hpcC0+Y2xvY2spOw0KPiAgICAgICAgICAg
ICAgICAgZ290byBlcnI7DQo+ICAgICAgICAgfQ0KPiANCj4gLSAgICAgICByZXQgPSBjbGtfcHJl
cGFyZV9lbmFibGUoYXQ5MV9jaGlwLT5jbG9jayk7DQo+IC0gICAgICAgaWYgKHJldCkgew0KPiAt
ICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHByZXBhcmUgYW5k
IGVuYWJsZSBjbG9jaywgaWdub3JpbmcuXG4iKTsNCj4gLSAgICAgICAgICAgICAgIGdvdG8gY2xr
X2VuYWJsZV9lcnI7DQo+IC0gICAgICAgfQ0KPiAtDQo+ICAgICAgICAgYXQ5MV9jaGlwLT5jaGlw
ID0gYXQ5MV9ncGlvX3RlbXBsYXRlOw0KPiAgICAgICAgIGF0OTFfY2hpcC0+aWQgPSBhbGlhc19p
ZHg7DQo+IA0KPiBAQCAtMTg4Miw3ICsxODc2LDcgQEAgc3RhdGljIGludCBhdDkxX2dwaW9fcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICBuYW1lcyA9IGRldm1f
a2FzcHJpbnRmX3N0cmFycmF5KGRldiwgInBpbyIsIGNoaXAtPm5ncGlvKTsNCj4gICAgICAgICBp
ZiAoIW5hbWVzKSB7DQo+ICAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0KPiAtICAgICAg
ICAgICAgICAgZ290byBjbGtfZW5hYmxlX2VycjsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJy
Ow0KPiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IGNoaXAtPm5ncGlv
OyBpKyspDQo+IEBAIC0xOTE1LDggKzE5MDksNiBAQCBzdGF0aWMgaW50IGF0OTFfZ3Bpb19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAgIHJldHVybiAwOw0KPiAN
Cj4gIGdwaW9jaGlwX2FkZF9lcnI6DQo+IC1jbGtfZW5hYmxlX2VycjoNCj4gLSAgICAgICBjbGtf
ZGlzYWJsZV91bnByZXBhcmUoYXQ5MV9jaGlwLT5jbG9jayk7DQo+ICBlcnI6DQo+ICAgICAgICAg
ZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbHVyZSAlaSBmb3IgR1BJTyAlaVxuIiwgcmV0LCBhbGlh
c19pZHgpOw0KPiANCj4gLS0NCj4gMi4zOS4xDQo+IA0KDQo=
