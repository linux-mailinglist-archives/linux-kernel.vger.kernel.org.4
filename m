Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681B65B37D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIIMfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiIIMfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:35:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1849109D3F;
        Fri,  9 Sep 2022 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662726909; x=1694262909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bWbth46AUREV1ilrFjiUgVEUNbd2x5OVXIysjczxF4s=;
  b=ATWvfbSqc9LBXM3lrDHCt/CuGOkX43RiAXXKnjkGG0tQ8CfYHRF3T9tS
   zBpVnUA1D1O7Q8tCV0rrNbfRnvTWVL142CsaO5aLH5KWKv5fYf0Mm4iW7
   gi0lG/Et8vs6Zfbg+4O2H4Fpr6vz4Tvh9shFyGGxon2SoH8Q21bKv77gU
   33/AGeqsoDk70imP996cACdsXyhwQKyDvyxQlfoCs2bCCj0Oir4vHN7T1
   QMlL4H7mXMgM5hdu8cqKwa5bkKPNkKCI+B/MYbbZFTB/qL5HSBFaJSY5W
   AkQ6tD+EtgDvh4DxMn0TfyS/tAXDLG1x/4o/DVxcSzrpMFywj8YfQmXSF
   g==;
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="190138395"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2022 05:35:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Sep 2022 05:35:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 9 Sep 2022 05:35:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBwLz0yPbqcq/onBBewp7Gc1p4UYi5z1HNQDWLpNg9Ano+ZWpsSA08ZSpJd+gb+6BoEgvA4MQQsfUJIYjhOmxEFaV149O2sUlMMZbJzX6OTYrrtMzFMQohJCwhL6MpDl9q9PEaFA3Yx9Uh4pVD6SJHIc5ZFzRyNtn+ldiCBbgdESXPdiR8QVv2U7FKD005eCO9D0OfPNdoaWxdAp2uGTWzFRqGLhzqS3o5G8yxeYGNUfVwAbImhsHhXKPzcaw1FHFG+9kgGliDZWCTUPT6I/GynbjGjRHtk4NYp5O3I6i1Z2tXMvEOMMVijuFwpYDWyugd0yBk092a4y8nxjESgLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWbth46AUREV1ilrFjiUgVEUNbd2x5OVXIysjczxF4s=;
 b=fSAaOab7V9kP5MeNonF5dktZ1oJjSNagfLJirkM2LZy0rNDlX7b5wJU37VyJgC49Clf9dZ+ZijDJRMKhfmYpVMX99CkLThMIbCL/A1DF16ZZzsmSnbv2Z/QC+jrNHIOmTRRx+XfFq0RbOeS6q1wcM0Knnt1H54KqFE0pRujrDdFzYU8L7qs4Ja37yr1JaVUguQi5FQmQVTFiuzcYhY9zhfMmBf7NRe3PTJgc1yt9AXRxX/x14OZyZa2rziCSvgGZueRk2H11ttFKZ5XOl5/SSuvuwHfI18XyroFL+h4+s6Zgw9dYPyneTuxB/2eKm0vtTiwL/rclXP7t9/CfmaXzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWbth46AUREV1ilrFjiUgVEUNbd2x5OVXIysjczxF4s=;
 b=dpOyFydZ3I4oLJc9YXuXwveyVAdrioFAyWbAv/kGP5cLTneUUa47SEBuFV1NOq5wH+6JcIuZ3LiIvpPj6MGGLbxqRnzuU5qjxVOzv6WkQs3ixaXlTIAFkYvHdH0lqSdXoF1/640YZMffCWLm1FxhOZ1YGvJ7g4z+PPCsl/clqis=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH0PR11MB5157.namprd11.prod.outlook.com (2603:10b6:510:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 12:34:58 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.022; Fri, 9 Sep 2022
 12:34:58 +0000
From:   <Conor.Dooley@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <palmer@dabbelt.com>, <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <Claudiu.Beznea@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 00/14] PolarFire SoC reset controller & clock cleanups
Thread-Topic: [PATCH v5 00/14] PolarFire SoC reset controller & clock cleanups
Thread-Index: AQHYxEgnw2pJ1u5LQEyPiH1+3wfi663XCHuA
Date:   Fri, 9 Sep 2022 12:34:58 +0000
Message-ID: <d100f6af-e6d6-1ff4-f6e2-d987a02e5310@microchip.com>
References: <20220909123123.2699583-1-conor.dooley@microchip.com>
In-Reply-To: <20220909123123.2699583-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH0PR11MB5157:EE_
x-ms-office365-filtering-correlation-id: 37640505-c757-4b30-775d-08da925fb536
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /W53lyo/famStVAR7k7E56j9pkW9ma6tj2vPvBJeqpwLOLQ3DSl+g6yatg7ucoBZuooBxF5oWRyvpgHZULQQfCywcioMboO+ShiaQLcmPNtqLo73oQfZZ9h86UGmud2lI0KTZ5UzKCz5rcDsrX9xrSgIoUuh4BJc57HWVxGu6KrE+G6CfoWKzdJu1myFnTIFXhgAvW4qOBNM0FnYza4KrQmyXBbZSsu5HLSpBy35fCgGaLTmoZIhLIw8pcpELGJzmC8JVCRxhaX+5tAw123hukgE9kXiwCpvuQofkNzqIMgj2OfNzyR9FojEUbjGlyB4hVIixN3q9FrgRV35xGYEFhD9auSXfMc44rmChdxbkDHbPk/a0b00mREfC37QRSRKDQ38P1UqXiBvVpRCp5AD3KOQaS8uzQifLEOEqbFcviHvhuI5P5WP3KdVWu21oQ1WNLjiyfHbM1X2SkAjjiUxF/aYoPEbnla0epQQDhOcJ7yhgOv0SoervRdnKz5B7jTB6JGHYEHMbhtP3mXQoHjvCwly5ejczx6U4/d4NZI+qg8pvJO7YIzSpapNPZu7nZfv8Kop+bLUSU0wEdZ5PuCWDQcbKWZ9Y1e45AoFlmqOCG9cEiP2L7tyN4vHRDAP3Ik6eHOsCSMqGUPf0Zt8HsbNQwaowJVg+RyiS6TkJbGMs1TwImSYqusWDqxf5FKePrXaxSiUYGoFYW1RlMpfQdU8Y4H/l0t5ZhnKDOV1bf9JB6b5e2rGBk6ZrUwpT5lcmUkNgBc6X9vPcaI0w29PNb/Xbt+Uv6SbFNBKyLjjYUwpuOXpdXgZbolcH08MGI9gY+VTBu2WClLOvx1epKFRibCDWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(346002)(39860400002)(66446008)(110136005)(31696002)(6636002)(2906002)(86362001)(54906003)(316002)(66476007)(64756008)(38070700005)(8936002)(66556008)(66946007)(5660300002)(478600001)(7416002)(8676002)(122000001)(4326008)(91956017)(76116006)(36756003)(2616005)(71200400001)(38100700002)(83380400001)(6486002)(186003)(6512007)(41300700001)(26005)(31686004)(53546011)(6506007)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVQ1NzAxOEJqVUdxSVdodUdEYmVod2h6Q01EU1hpTjYyWkducGhnYUl6T1Iv?=
 =?utf-8?B?cTB4S2M2RkhSbkQ4V3htM2dYRGx3K3pDcEh4b01nM2R0VHpoRStUaHZteElo?=
 =?utf-8?B?UGFyYUh3b0FRVVQxQ0dQd3RuOWI2bWdmVWR4NDBNVnlmTjU4RDZnd1BJaGVo?=
 =?utf-8?B?c0czM2pEaGZQQXZEVGlFdlVRa0dqME55UGd0cXpnWWh2V2gvODlKaHJ3ZmlU?=
 =?utf-8?B?WmNBM204NERvZ0tURi9MTFNBS3N1NHhnYU50RVUwaUZFRTVaQTNQdDk1WXFF?=
 =?utf-8?B?bFIzV0RrcGFWQk1ob0xHMnA0blBqS1hIeTZNbERwVWlLVlVxZ29PTC8yY0tO?=
 =?utf-8?B?dy9jS1IwNTlaWXdLbVN4V1ozdW9mNGhmaU5oVXFjTXE2ekhSbGN0NExNVzNp?=
 =?utf-8?B?aDZxWnRZaDRnNXR5RTFtUTJBbHoyQml5bmMvUXVQamRCdTVuWXhLQXFxbXJM?=
 =?utf-8?B?V1RhR1VMKzFlbzdRRk9mOTVwcXZRK3JYeURMbk1pZWwvZ2VvYnRJeUdVaXBX?=
 =?utf-8?B?cm9aNklQSDZvZHpmUkxMMlNORnZTQjN4R0tTWXFJZDRQNXJYc2Zyck9WWGpQ?=
 =?utf-8?B?U1BtaTRONm1iL3FlM0d5QUhyRmcrWTlPL3J0dzM5K1NOdnRqNGJFdkJIYjQx?=
 =?utf-8?B?QU1vcW0reXAvbjlTdjRlaDU3WDAwbWM3MFJ0dlJ2TlczZ25pUlIxTUhCQ0NB?=
 =?utf-8?B?cnd2ZFJGZVZYVTNpbFFBd2I5a1FVLzNqaDEyMnNlQmhmYkFrUkJtOEQ3cnlN?=
 =?utf-8?B?d05BVVBERDRPR096ejhXaUpEcWxSNzZIQ2RGVmQ5OE5JR3dua2ladERvQVRF?=
 =?utf-8?B?VndyUlhCejE1VEdVNVIvazNrb2hjM1pta3dNTFZ4V1FmdnpqOUZ5a09mdTRV?=
 =?utf-8?B?RXFWOG5VekhITHNtQzlrcXpvcnlmMTZMbUhNeERIOWFqaFNZWVl0ZzdqYVlp?=
 =?utf-8?B?Znp0NHhpSitZVjh6VkQwUHF3OUhvbTVlc0FCeS9Pd1k3endxaUwxQWlWVVp3?=
 =?utf-8?B?K2Q5Wm9zRjdJSWg0TE9QcFN1ejlGZXlqTWp3M3hBaThtTVhrVFY4c2Nua05C?=
 =?utf-8?B?cmgvTER6U1MvVTF6NnJ6WVpCZWxVMjl3enpKdElaYjhjaWZsM211Mkppdk84?=
 =?utf-8?B?RTZmb3pjU1E1bDRJZDBvSWN1Qm5oeFMvcUFpeWVEc0xJYTErMjRBZTRvMW1R?=
 =?utf-8?B?b1kxUFUwam5HYWVMMDRIeWNORVlyTzBOTytJRUVrSkc4aW9KUmdaanBhOUJn?=
 =?utf-8?B?Y3NjN29zOHFSbVpISjFuMmtDY040QkxXUERJdVJwK29rdjcyTzZ1dHBLc1ln?=
 =?utf-8?B?V1RkRXVaYXI3d2lpNm5RMjF1ZjI0K3BEYmtsSXlvZ2ZsdnZ3L0FVcFUyM0hX?=
 =?utf-8?B?NStoMnNjT0FXampNcmMwOEtIcnJtdHppL0JTSXhSaTFValJleVFOTUxTMUdE?=
 =?utf-8?B?eTRuSXNRYUllcEJ6YjE4MUJIQ1FveGRQMnorcXorbXNrVG9ENllUL0IyaHlU?=
 =?utf-8?B?QWpVWmFOMkViaWVWK2dJWVdlU29nR3FHOHBsYXhLSzlIUStpZFgyODdRNW8v?=
 =?utf-8?B?U1JidFhLR1FjT3IweHZSemFUSE5SNW5nVDRFOWFBQ2JUcW16SU5EUURCQVpM?=
 =?utf-8?B?TnN6NzlaMWxBa3pyNTdZSkwyWStNaWNWaFUyNDB0b1FMY3hRelRwSmlTZE5p?=
 =?utf-8?B?RXE1VnpxaUxSZWlJY2xFM2hOWXJDaHQ1MXcxcGZWYWhVQUVuakVsRWc1LzZ5?=
 =?utf-8?B?SUlOQldVN0VzcjhGWjE1ZW8xV3pSN2FLcmpXK05lQm5URGpzWUpvVjhLUFI1?=
 =?utf-8?B?RXNSYXNKeDJWUHVtVnAvZUMxc1AvSlVSOWpRL29aUGdsMW80YmVSV2VOMXBL?=
 =?utf-8?B?L285THRwb0ZrRkxsVTczU0lOay9PRE9hM0V5UHN2SS84bjJlUlRGUkJjeGd4?=
 =?utf-8?B?aXorTnRhY2IwS3N1cjgrOWI1L0duVXhLcXNXZ1FVV2l6bUJNRm1SQzB4OGlD?=
 =?utf-8?B?Z3FzTkJQRTEzUGp2emIvQUJjYTFvT3ZENWpwWUdxVGgyeWlLb1k2VzZWaHJ1?=
 =?utf-8?B?THdIOWxaeHNvZ0pYd3pjazJkYzdxYWM0QVg1QkdkUHIzZkJmMDJQRG9oNkZ2?=
 =?utf-8?Q?Ls/aAp+Sjk8ThOGyt37dJr0ou?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <523A02D569458F4F8E39AF690DECE6E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37640505-c757-4b30-775d-08da925fb536
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 12:34:58.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eNLyvfVwJdukLzQROeNXzP4JhabyCzPCxySOrMdzT0wHq4Qi1GEajmC/6SzbfAXbF5Z6GWSasp7wQGuql8izpjbdBk9b3GoK6aM5olWMK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5157
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDkvMjAyMiAxMzozMSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KDQo+IENoYW5nZXMgc2lu
Y2UgdjQ6DQo+IC0gdXNlIHRoZSBhbHRlcm5hdGl2ZSBtYWNybyBDbGF1ZGl1IHN1Z2dlc3RlZCBm
b3IgcGF0Y2ggMQ0KPiAtIGRyb3AgYSB+dXNlbGVzcyBpbnRlcm1lZGlhdGUgdmFyaWFibGUgaW4g
bXBmc19kZWFzc2VydCgpDQotIGFkZCBhIG5ldyBwYXRjaCBtYWtpbmcgdGhlIFJUQydzIEFIQiBj
bG9jayBjcml0aWNhbA0KDQo=
