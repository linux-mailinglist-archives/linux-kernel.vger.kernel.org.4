Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2377964DF98
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiLOR0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLOR0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:26:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE5529375;
        Thu, 15 Dec 2022 09:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671125170; x=1702661170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ISzLtESZiP52nLYqieTz73pWUJBhMCbgwP2d8VLj2KI=;
  b=S/fW9w7dIhQ0KAgn0GFqmSA6J4zJjdat/kfrj1WNalOASxh2LadYhqwD
   BBDOj/s7V53GokgIReV8KduUW4PPXhR8PZVXEibXjZl3oLmdLWwCXYnj8
   ILMllNlpGQe/Vuzty8V+PmfgGFI5qYQ1eg2ygAoWqnJPabmr88SXppXMv
   DTMuB36/ZxZJUbJO5FNHyhr8QFT//K5YDZKCpSNE2XOtwNruBKimW0u3t
   kLUxUdlEnQIFIhkH40h3YaEGKIP8IeCf0wfVqwk8vis5L5dgS0rkkSUKX
   EFmYV7Sosiw1R/5+g14ZI87gM6LFWBIGC/FqnlOiuXwxOaWc4LfI9EJTo
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="188369921"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2022 10:26:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 10:26:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 15 Dec 2022 10:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMC56mGAcWls6vCWMVZlq3Sz9ceCk2IYQK+F7cd6dB087Ae8vUPT1zQOg/B/E9KI3jPPV7PakSg7E86gZN7V1QTWAo4z/0VWXu6tPwGWp5hOHFsy0G572kn8oqEbIRNZSisJH4lB6hElrXnS8+XVpWi7l2E6+cVtucaefx/tBmf+xj4HoYZ4kSYPK260A4hNZrAqgCA5VjLzb5EdGI790SBLoLAnr1FZ9YlGfMJ2bysJr+ZtEKZGbIABNGP/O4PtNxnnhx7Rl2sgN+95AbYqoQrmwkqgeF7NYZQX0RjT/+tIrM+L4uqBdg+5J4cS2jqZXQE5efoL5ttXfjXS/goEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISzLtESZiP52nLYqieTz73pWUJBhMCbgwP2d8VLj2KI=;
 b=OYg5igxWW3Bg7eUaxYWMc4YXucaP4DFZDUFwyAXcacmPA2LEq5+XxnMSXw8S+HXEbH9Bph+dURlDrr6npcwGBybkHb/7UqNJ1y9MfvyRVG1wFcPFMb2PIMvxbOukvlpx/U5NUgNbNqOIuRafAe0L/9b1gGxC5hVoK16emIp0in/yjRpnHug/eobW/6YY0yKSpDBQ2qutZkVCXAM+iygv5hANE60QTcky7m8LErTl9reZSxIkTD/c5P9odlEC3l/Z7ZQ0GgmVn3N07UK8pjfn2O5SsfNris+GtzDsnAa0dYYFi7qCy8og6jJ0rU+L8a1qc8Jf70hbN4gv2bat+k4wxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISzLtESZiP52nLYqieTz73pWUJBhMCbgwP2d8VLj2KI=;
 b=YuLNxB0w9PqWiD5/B5L8n/YXHIVoYhIiWJ4bAIFDuq3wigVN3T4QvQa6jsLn6qdFHkZ+TxxPR8+JBLzPxh8cAslIH4ioTS8BU3R8iDZYnFdUo6Eq0u3ZNeci4unDrgYXKFs2S4S2pkbQUFCTpl2V6FQo/RFvQluMaJtjGWvIlIg=
Received: from BN7PR11MB2657.namprd11.prod.outlook.com (2603:10b6:406:b1::19)
 by CO1PR11MB4900.namprd11.prod.outlook.com (2603:10b6:303:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 17:26:03 +0000
Received: from BN7PR11MB2657.namprd11.prod.outlook.com
 ([fe80::65d0:db90:d46e:3e20]) by BN7PR11MB2657.namprd11.prod.outlook.com
 ([fe80::65d0:db90:d46e:3e20%7]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 17:26:03 +0000
From:   <Ryan.Wanner@microchip.com>
To:     <arnd@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <linus.walleij@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
CC:     <arnd@arndb.de>, <andriy.shevchenko@linux.intel.com>,
        <slark_xiao@163.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: at91: convert to NOIRQ_SYSTEM_SLEEP_PM_OPS
Thread-Topic: [PATCH] pinctrl: at91: convert to NOIRQ_SYSTEM_SLEEP_PM_OPS
Thread-Index: AQHZEKSrFo9b16gnm0KeR+zOPaxF9q5vM2oA
Date:   Thu, 15 Dec 2022 17:26:02 +0000
Message-ID: <a08f7603-abb8-f7c3-83bc-168892212526@microchip.com>
References: <20221215164301.934805-1-arnd@kernel.org>
In-Reply-To: <20221215164301.934805-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2657:EE_|CO1PR11MB4900:EE_
x-ms-office365-filtering-correlation-id: 74e2276e-7e42-4efe-8a41-08dadec170e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYZJtUEot7jhKQhsTSiTGcBKmCru7O18CSsyNyox7mKTSghEd/fBXaorWD7OhwCHxud8fXWHS05yxwKvS1r/f0XuEpW0Jp6HYtgv4gnYpAkeJv+sbJY6sEyDzrDIzRMeyKvX8E3wK9g3oQ7DRkrR+v2Qe6rDQ3Nyjs6GAX4DT5P1AA3d5e4HMNBv6ZNmWeFv2G9Gl8AHC/BRFQ6vaQAE/RuxUi89S1MbWNCd+HzS3JpYCz+YQyLocorVyGTx5neRha5d6QLT1O+8kM+OfD9GtbigQmBGFlivE42U1WTkdozyNEV6tUwX6Cf0ySUuD0BFrF50kAVECs4Uc4IKKp1axpHRrE1G7q62+fk/cIXDTqmsb3asu5rrxREQQ/guQxVP4w8vbJ1c5TB1H4kBI8aTnw/N26Dknh7jUpDGitqS0Z6x2ODYp3kRKMOfrxDglLOAKEyLXzyUHorFqLX9IYnizuniE8INafoegVygvC6esSt5vhi8j4203cdFBYO6fs6K/ermRQcxYTKQM+i+6OfoDptUkxXnElQF6GHyS9yA6iyGAIUjP1BZV0W+IqPEYBmoNs2xgfrEK9ZRErBIkEG3bwHNqrE8J1wLFQjDPr0/bWpN6GpcFlrK4aXsrCUUdY93XkgBKcfEPZgY1RHuxkVoO7swTSVUv2J9bDSSmNQHTJb3kmEjMq1MNlbf4ynUifGj8HB0jJmoQrf0dUn7vgjRAK/aDMv1S2Y4214lroSbjKfcErPmnHgEADCRc5VX7LjPPriA6zd0NIlD0E/a+7D6kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(36756003)(2906002)(38070700005)(8936002)(5660300002)(41300700001)(83380400001)(38100700002)(122000001)(31696002)(86362001)(31686004)(966005)(478600001)(6486002)(71200400001)(54906003)(110136005)(6636002)(6506007)(4326008)(53546011)(76116006)(64756008)(91956017)(66476007)(316002)(8676002)(2616005)(66446008)(66946007)(66556008)(26005)(186003)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2EvSTVpNGhuZWxTWWdtb1Z4MW9WR2NGa2FjelZ3Mlp5T241RjlEMnJ2Nmhs?=
 =?utf-8?B?Mi9jTk5rR2U3aHJzVWVXdmtDSitINmU4ZGphQjQ4R0ZBZjE0QnhCU0E2UVhp?=
 =?utf-8?B?YXNvR3dDeFZUd3UzdW5WRDIvdExUSmIwbVBDTjdpL1U1THJpQmhOeHJrbStI?=
 =?utf-8?B?cnZnTVpMUVlmaWZUMlFxdlZCdGpwN3hSNjZJODA2ZFR6dnZJMWxZQTRyV2da?=
 =?utf-8?B?MXJEcnN6Qy93L1hmTzgzS2hDWHdWMWE4OEhjZkdSNzM1T2dXd2RuQlFUWStY?=
 =?utf-8?B?QklpZmprVVlLYXJkcms1dVNoRnFoYWFURm45YWo4MEhMNHcxQUhtYXZMYkJG?=
 =?utf-8?B?Lzd3WE5KTDZ3b0lBZjJ2eDQvdFltSE5uQkNTTmRYZm8rTmFHclNvcEZxemFY?=
 =?utf-8?B?YkFmdnRCcnZkV1NOaSt6K3AwcUR4blcrYlU3SkxocXh1cUlXbE84OCtFaWNV?=
 =?utf-8?B?eFFCN1dWSFRnUU1ZWU9WaXpWOFQwQmJKZEp1d1p6c1JnMzVlREtJdmRiY3Fq?=
 =?utf-8?B?RllJcEpYSi9DZlRoemVJYlh0dzhibW1wdkdZNHZodVhXd2FHaE1GRGFJODFu?=
 =?utf-8?B?Z255OWtsYjBsajExNktRakVRU0dFSlZ2aGdkaWRidllXQVZ5dzJlVUNWUzZi?=
 =?utf-8?B?TGg3bHNZbmNITnlYN2tXc3g3OGdZcTNjM2JxUVRNZ3VqYXFQWWh6bHRvMzhZ?=
 =?utf-8?B?TVhRNDlWeDNHY2VEZUdWT2hPS2puWFRKZkFIclozT0dWQ3hQYmFlVFd1UFJk?=
 =?utf-8?B?WHNLbUZ1VW15R1p2RFEwKy9ycXVNNENKVkt6VktFY2lmTmlzL0VNV2drdWpN?=
 =?utf-8?B?b0RnQi9ONStTWHNQZ0k4OVVPYzBDd012bktBU2xoeFFKaHZZTityYXlhYVpS?=
 =?utf-8?B?a2dhd3l6M25WejJTalR6cTZKZ3FmR2JYRkoyL1NLZzNXYi9KK0FsTEZWRlh4?=
 =?utf-8?B?WERjejdySVhCbHNSdkZ1eFdhV0NIaXBWZnJZWVNNRFlNS29icG90UEMzMHNS?=
 =?utf-8?B?YTMyVVI2UndLTUxWMFlhZWtXTVRQSHg2a2dBVFlpYUxDM1ExK1AxMm1LbmVv?=
 =?utf-8?B?SDk3VHh6ZEFCMWxKV1pPRnk1eVpCTkdBTHRxRzJlSXhnVUdxU2d0c2YyT1FO?=
 =?utf-8?B?SG0rak9Oa0JZTlZZQlNTN0dENUk3RFFqb0d5RXE0ZHpSS09QT3dXVC94Zklq?=
 =?utf-8?B?Tk00REE0MlFCZmdObjRLM2JBdjJ1bkZiSzJjVlg0LzlldlIxU0lCaVYxaHZK?=
 =?utf-8?B?MG1SUVJoZWdwU1ArckxIT05IRFB4dTNrMlZ5SlVNbVU5U3N4QnovR2VLcTIw?=
 =?utf-8?B?eFNBQzl0QWcxNkhoQm9LdnZ5VXZEK0x4R1lkOG5RenphbTk4L3o1Nldvd25m?=
 =?utf-8?B?SUplWXd5d2g0MkZOR1UzUkhhZlU0SEdpU25IMjA2YTQ4aDgreEZUOE1nMncw?=
 =?utf-8?B?Yk52U3dyUVdvbFVXQ2Y4USt2Z2krR29FbzJTWE9sQnAreFBYQzVlQWU2MmNT?=
 =?utf-8?B?RWZ5N242OFhUbG9rZTUxbC94R1NWeGJFeGpLUUxmOS9YRjRxOEpTMnllMHlF?=
 =?utf-8?B?cjNXZ3ErQmRvZG8rNEpKWk1rTlc1aVZkR1hocDIwZEtVdGVBM2NTU04wOEpz?=
 =?utf-8?B?dXhzVW52MWNGWkxIdkpDc2FRQXRvaDRmZkF2REN0TVFvMVRtSXZnK2xlNEVl?=
 =?utf-8?B?cXE3NDVvMVVIbk9acG5XME4rOXJtZkNIaFpkRUxsaXJKUS9RSzIwcHhPeTRh?=
 =?utf-8?B?dERFeHRiM0JoNGYxTEVWNndLRG9zQ0FOY05FTjFxWW02NnB6YUVFTFBGNXU1?=
 =?utf-8?B?T25UZXFOREpha2FnZWtlTjNRcEFkM0ZmMFJMbTJMbE9SaCsvK2NDT3BWMzVV?=
 =?utf-8?B?dk1LN2NFUkRyTTBWY1JjeG1jelQyaEhvYVp1YVYzYktGL2ZpNHRFZ21yWE41?=
 =?utf-8?B?bkszQ2VuVmttRUI0M0QxNWRZSlBCTW9ZelVsbEp3YjhxVEpYWDRtdjI5b1Ry?=
 =?utf-8?B?bmFGV29KTExkM2hxSGkrYzZUMnQ4OHc3ZzliNTU1VHBHdXhkQVY5MW1QQkJ0?=
 =?utf-8?B?RnBEQUlhTVpWNmRMcGk1akIxZ3lOVzg4b0gxa21uUVMzdFovUEF6M2JoZWps?=
 =?utf-8?Q?pBiyTy+lR95aPxw4Lwa/tVSr7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C664A8CEC9460488FDECDE6DAB1AB15@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e2276e-7e42-4efe-8a41-08dadec170e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 17:26:03.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/wCAt2bMQSLcECqJlHfGg/gNr3j1UZBQ5T3T/wNFgd88Et8YgSspP4zqkZ2Gp9ezJdO4enx/0azOr0AnGx/P3hN7aYlNEenGLgvyhp03iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4900
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTUvMjIgMDk6NDIsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IEZyb206IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IA0KPiBXaXRoIHRoZSBvbGQgU0VUX05PSVJRX1NZU1RF
TV9TTEVFUF9QTV9PUFMsIHNvbWUgY29uZmlncyByZXN1bHQgaW4gYQ0KPiBidWlsZCB3YXJuaW5n
Og0KPiANCj4gZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jOjE2Njg6MTI6IGVycm9yOiAn
YXQ5MV9ncGlvX3Jlc3VtZScgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWZ1
bmN0aW9uXQ0KPiAgMTY2OCB8IHN0YXRpYyBpbnQgYXQ5MV9ncGlvX3Jlc3VtZShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+DQo+IGRyaXZl
cnMvcGluY3RybC9waW5jdHJsLWF0OTEuYzoxNjUwOjEyOiBlcnJvcjogJ2F0OTFfZ3Bpb19zdXNw
ZW5kJyBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtZnVuY3Rpb25dDQo+ICAx
NjUwIHwgc3RhdGljIGludCBhdDkxX2dwaW9fc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCg0KUmV2aWV3ZWQtYnk6IFJ5YW4gV2Fu
bmVyIDxSeWFuLldhbm5lckBtaWNyb2NoaXAuY29tPg0KDQpUaGFua3MgQXJuZCwgYmVzdCwNClJ5
YW4NCj4gLS0tDQo+ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMgfCAyICstDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMgYi9kcml2ZXJzL3BpbmN0cmwv
cGluY3RybC1hdDkxLmMNCj4gaW5kZXggMWUxODEzZDdjNTUwLi5jZjI0MjM4NTVhODAgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEuYw0KPiArKysgYi9kcml2ZXJz
L3BpbmN0cmwvcGluY3RybC1hdDkxLmMNCj4gQEAgLTE5MjMsNyArMTkyMyw3IEBAIHN0YXRpYyBp
bnQgYXQ5MV9ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB9DQo+
IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGF0OTFfZ3Bpb19wbV9vcHMgPSB7
DQo+IC0gICAgICAgU0VUX05PSVJRX1NZU1RFTV9TTEVFUF9QTV9PUFMoYXQ5MV9ncGlvX3N1c3Bl
bmQsIGF0OTFfZ3Bpb19yZXN1bWUpDQo+ICsgICAgICAgTk9JUlFfU1lTVEVNX1NMRUVQX1BNX09Q
UyhhdDkxX2dwaW9fc3VzcGVuZCwgYXQ5MV9ncGlvX3Jlc3VtZSkNCj4gIH07DQo+IA0KPiAgc3Rh
dGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXQ5MV9ncGlvX2RyaXZlciA9IHsNCj4gLS0NCj4g
Mi4zNS4xDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KDQo=
