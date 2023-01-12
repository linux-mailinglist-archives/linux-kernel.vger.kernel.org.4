Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769C4666FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjALKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjALKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:33:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C35791E;
        Thu, 12 Jan 2023 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673519298; x=1705055298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E4TkWUQ40sieuoZzHz+ouCLWHPTugd/4whW90PLVmAU=;
  b=fTelA9W5jA/5hJOkue6TglYhPlNOPA9tpPneALQgUh4VaHiqkUTBAki7
   sx7Kx4NsILFo1iRudf+dHG+OIpCtt1WFIsZBx2Up6moP5tq5hPfAdMHte
   +zqIgbc/FxNoU8UqfE20AKOZI6FVL09zMLirrDG1+qpzkILBE82ujw4l7
   d+/AZlId58KnKnPPP0EG6NA697HOhTJB8dbuTdVUJU8RAfoXpKLXZww4I
   qJofmaca9samoYIUAMUV05MDwZ3eUFqRtOWB9j7550b/PHps0xrLQXdjq
   wDhH/tlkHsJUqS5wWE2gOhrit8mMkQyVCo0/rlnN8lRdwOuI17ParDkzN
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="131988453"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 03:28:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 03:28:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 12 Jan 2023 03:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ/ThsKjgP60zbiw9eAzfJsaQxjDwdgMJYXiZ5V41sF7bf5ZbSJhD9jAA5k+G2A9RwTorvp+x65xx0ORszKTBTMna8opVp53C04c2UEYKgMUWEuHqC998Bx6laHDD8AJEKhi+Ew/N8nl1zRUdeG/7kRRQvZPyzoj1rBmf1jXAzuOMvpVWkYxnDZqiu7nHqiao7DUqanSG5Mv5JnLDHkjrkpb/tcmwFOQgCOoHgZxTpGASvYVFPkeBNRUMC+vp46qveak+ytP13FzkGba5wFSU1J2ChL6T21iCclde2BII8cfkji0Hn32+gIAVyE7ctCFSV/Sdc4GlwkdsLTe35BtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4TkWUQ40sieuoZzHz+ouCLWHPTugd/4whW90PLVmAU=;
 b=Cy8qUtU7xXADwL9JoiF2hV+BEbwho/eg2H9Ve2hoXywijxpu+a5uyEYMAFT1wunRyvgHAEQcZ7cRLrr9MrEsOKC8H8hXXdgY5TQ0TrG3Nl9rDG3PhTwtKichqWR86vuEJ0TKJ6B7ngzOq0bDZkLOsfsZ6jSa0rVeEz/okyG4yESm92GSDafgzf1TwK/NR7Edw9BB8Vy66KqKVRR1JZ82pNjOjmeShPDcZrF84t0adnCnv50wcQXnH/1rpvfc4zwUPX7m6RTmBYDSp7U4q+qYm3FRYiMaY5Y/rR4OdCiG40vKUJLyJ03LBRd7JlxLviXCDqUrcuJ3OMxUJQAdEBByEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4TkWUQ40sieuoZzHz+ouCLWHPTugd/4whW90PLVmAU=;
 b=J1PIGoSX4l6XMSnU01kWDs9EYWYM3SLsXyQLBSqJfXkEKfCWM3tMbH5sucSVHqd+QgjCva+H6okrL07KqTto2eSzRgclFZ+nCxXWM3QgeMdnZwbKA06mAQcXFKtYAJkbSxYfxnc9LTAIfBHLvCes942yC75yj9fpYgwfd1N+XAQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH0PR11MB5409.namprd11.prod.outlook.com (2603:10b6:610:d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 10:28:16 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 10:28:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] clk: at91: do not compile dt-compat.c for sama7g5 and
 sam9x60
Thread-Topic: [PATCH 3/3] clk: at91: do not compile dt-compat.c for sama7g5
 and sam9x60
Thread-Index: AQHZJnCUc3AyhMhubESOhSaqmCoigA==
Date:   Thu, 12 Jan 2023 10:28:15 +0000
Message-ID: <ccf6e228-ee63-7f95-dfed-76f7adc41915@microchip.com>
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
 <20221208114515.35179-4-claudiu.beznea@microchip.com>
In-Reply-To: <20221208114515.35179-4-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CH0PR11MB5409:EE_
x-ms-office365-filtering-correlation-id: f9483617-113e-44b8-4e16-08daf487b75e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMIFY4h+c1WmQzG2tZSiNXK8fLMhqtzB5OrGh36d3/pV38mkFUAESQnqMQrl/iZ6Cl4NMM5kqUEvG1Xn2MhwAWFKR4BDOBVf2lmB+UhaPcw9aQtfodFflOB8mJvwXx3viVo7C6Iv5LKvvjt5iw0LJRrsN72AqMH5px0wVPXsMNp5k+MqV2lN5WPE6yhg6xVwS4GMgXYLZEl/9zpSOQSTB4ELlKKn0HGOPjfjOyDEsE+xtRv2IdxgZEg4xPorq9HSqF+RP4/FSRu0JXio0dL6ZyiZ14nraD7Fej54+8L0maOkxscHN5NzHAnt1F4xGlBC8e2cfgsEC0Vhf5e614Tuwt6w8+z0pR163V3C244RtdoeZ4viysZfSLCXJ6HyWojAZR3guKU/Ws6fwb7eJu3bisNGwtmv04uma5EfxAkINXVMCDoS/hJOMXe03z1LI4/MPzWG8KZAR7aErRn+JkDcXKbC01ZoicvYTCpCg1wlcW0wX7oZlNwVYGX6LhC9gsdcmbhlJJrGUWEIic63WshNEAblYuB9UhOLvIpozTtiyFRwbQMSMcv0Rso63NB4eu4FgDvhw4YgwaWKJztsS0ci46/S6UkyGkpo/o7Ga5ZfeQzXZl+7E1Zejq3yLWUgAG0wHBaKfFOHvFmoQmWQilrRLDptQlb5+gWWSza4WmWPMSYefWHve2EirPraY/7uJVV5STSPP6mq9VPHNV0EijWZEm49Zodfp2IemSritiC2vG6LdEjF8+P8ra5X1/GJbOLip1a8nHQSptnRBZzrG8xpss9gKBUTLVYq88Hr63y1BtA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(2906002)(83380400001)(478600001)(66446008)(66476007)(64756008)(66556008)(5660300002)(66946007)(8936002)(53546011)(122000001)(26005)(36756003)(186003)(6506007)(31686004)(6512007)(6486002)(2616005)(41300700001)(38100700002)(110136005)(8676002)(54906003)(76116006)(86362001)(38070700005)(316002)(71200400001)(4326008)(91956017)(31696002)(138113003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2Rja0J3Wm5zNWY3V2VidURwT0NCT05IQk01b0NpVFlNV1B0L2Z3YzYxbWNa?=
 =?utf-8?B?NHJJQ05FRWJNcnB0UGJQNmRYcmwzT0d6RnhjblN1cFV0TGYyTWpIcTBGcm04?=
 =?utf-8?B?RTNWRTNxeUtkYUJCanY0MGtoWWFJMVdQRUViVnEzRmEvTG90ZUFaekNsZERJ?=
 =?utf-8?B?RmVUUTAvSWZpa1EwTkdhdzZNTG9QSStFa3R5SXJTU0wrd05MWFBLRXprOHRD?=
 =?utf-8?B?dkFJZWVLY1NGaFhsSFdMRmpRVEJ3aktjRFVxNzlXVkp5eE5Lck53LzArMFR0?=
 =?utf-8?B?L2tlUHlOd0srNUQ2OWdIVks4MmxrSy9mVmgramtvTjlEQUpMbXhjNWFzTFBG?=
 =?utf-8?B?c3lhaXpIU3BNZUM1RlI3ZWw4VlhHWENqMDNONE02NzRRU0lWd0xjT2E2UE9v?=
 =?utf-8?B?R3dPZnBkR3c0UWZYd2VkTVpHZUdYM2pXUEk2cTRCRkdDS09JbCtDbktRdFg2?=
 =?utf-8?B?Ylk4RjZVeWF0Nkx5TFFTRFc5TlozSVkxWE1qL01KSnlEMmpvVFdqbGlvTUdO?=
 =?utf-8?B?VWRPdlhJaW43bWFWdCtDNEt3aW9UamZPSU5jdzFmNXR2RGJYMXZXd2g2eXE1?=
 =?utf-8?B?ZVJxUW00a010VE05QjlyeTVXRVZwWUJuMHNEUHFxMytjLzNqVmx3WXVDTkVZ?=
 =?utf-8?B?dHpNd0cxSzVpM0hsYjdXSks0ZmplZncyQ2xPMXdNbFc3WUYwQ2F2Z3U2Zk9L?=
 =?utf-8?B?cFZFdUtrM25CNDRBRi8rWE9SWDRySmJydjR5NGNZcVd1c0xQbTZxUnRtMW9y?=
 =?utf-8?B?RGVnZ0lnd3N2Z2Jod0RHSnBScVpyZ0hsZi9PVks1UU1yYWNZNFMrcC91MEt4?=
 =?utf-8?B?MmFseHpFMWZEWDc5d1p2MTJVRnBrTGd4aXRxVzFvdUJFVkVjZldEcVJ1THVG?=
 =?utf-8?B?dk51bHluSjRBQ2ZIMSs3OXg3cTFWMDVCWFg4L1Fpa3BjaFltQTdGMFJ4STNU?=
 =?utf-8?B?cEQvQWtWbnpCQ1BvdXlVUFhxNEVRbmxrRzdlaGtTZUdSbVovZlA4dkpKUkNF?=
 =?utf-8?B?RDRJeEtWU0prOGRmZ0dCckhXdkZONzY4cFBsVFRrdzkrem1uZTRYaEZERGZG?=
 =?utf-8?B?aEIrL0xOYUFyQzFhTFI5N3hEaEdCWHMzZnZtRlB4WmtYSmFmZnlBQkQzcUcv?=
 =?utf-8?B?SXk1YlFISWZ3N1ZidHhsT1kzKzBtUmU1Z0lvWnpzNEYxRmNBekN3R1FWa3VV?=
 =?utf-8?B?V0gzd1N2ckU3V2loMCtUbHloWkhidWp2UTloKzN3cWREVkwrVzJNWHA1TkdP?=
 =?utf-8?B?SlREM29HcFZIUnZrcjQ1dG1iUjhaZUtQaE5NV3N6VDg4cTdxaGNPNTNNNVFn?=
 =?utf-8?B?VnZ6ckh5Wm1tSEplcm5iajJDdjZxYVBYUDltR2MwUmdRcGhjM2NJQ1VTNmpl?=
 =?utf-8?B?WGtTQUlHcnVtWDFrN0tzVUlGWSs3QkdkejB2L1FrTldIVTRGTTMwcURVc3B1?=
 =?utf-8?B?VFdTYjZzbDRHdnFKT3FrZVdaUDdWL0FTVFQwcXV0V2lwVFdKOUJvaFhicEZU?=
 =?utf-8?B?RUZMbDdNM0ZzQlEvNjNwU1RqOVJWSkg0aWNwYlJqZE5ibk1uSU1Bamk5N3lD?=
 =?utf-8?B?Y2dpSDhDam1jR1V6YzZQNkZxUUpGcVVmekwzbEpTeFhWVVdwYThPSEtqVzhT?=
 =?utf-8?B?OWdQVDVKUWZuTlhQTVVzeDg1YUN2QmxsZkpmZlo5ZFlEcytBVlk2Vm00L2R0?=
 =?utf-8?B?YTV0NUhpZkFnWVczMHdJZ3lBQzJlMi9SSlVYeThqYzRGMEVabWQ3NlhDVlJ5?=
 =?utf-8?B?U2s2S0FQZ2pWNjVEUVJuRWF1V0krT1JuZFVINHNSMnF2SFA4ZU0zbjdVVm5J?=
 =?utf-8?B?Q1Q0RjBBUi85dWpmZzBhTDJOaWFUODkwbE95MUdZNXZ5eVBacXBHM0FOenhl?=
 =?utf-8?B?akYzNlZZdm1LRkc5RXYrSG42SlkxdzhpODhKRGdrR1hEVHg2YXhiOXl5dVpo?=
 =?utf-8?B?SUd0U1NvM1VyV3VORUNlcnVBWXk0aERuU0pCeGxyRGNQdUt0NDFlekM1YUdN?=
 =?utf-8?B?Zzc2L01XWTN4SU96Q0VQbjE3OU5jSUs0S3hJNmhZN0RETElNMWRpcWZrUGRj?=
 =?utf-8?B?dW1HdUJiSEg1NHpnL1lVaUR2U1NIVDYxcXBvSHpsNVdiTjNpWWtwMjhDWkdn?=
 =?utf-8?B?bGIrZmtWSkZTcUJBaDlueEgyN2NoOUVtVElUb3lDNDFRQ1pva1F4MzFGanFB?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5727D3A153280943AB5B0BCCB2228CD0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9483617-113e-44b8-4e16-08daf487b75e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 10:28:15.9894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBKv0mfUaSJe3Upjp6zTpAba/HqrRnFfVYitum4wkUSRHfykQvEDGfQMLBVwkLO2EwsgYIrW/ceQ0DJrZI9GfLpNXG06i8jbsBz6/9p2xIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5409
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMTIuMjAyMiAxMzo0NSwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IFRoZXJlIGlzIG5v
IG5lZWQgdG8gaGF2ZSBkdC1jb21wYXQuYyBjb21waWxlZCBmb3IgU0FNQTdHNSBhbmQgU0FNOVg2
MA0KPiBhcyB0aGVyZSBpcyBubyBpbiBrZXJuZWwgZGV2aWNlIHRyZWUgdGhhdCBjb3VsZCB1c2Ug
aXQuIFRodXMgYXZvaWQNCj4gY29tcGlsaW5nIGR0LWNvbXBhdC5jIGZvciB0aGVtLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5j
b20+DQoNCkFwcGxpZWQgdG8gY2xrLW1pY3JvY2hpcCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9jbGsvYXQ5MS9NYWtlZmlsZSB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvYXQ5MS9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL2F0OTEvTWFrZWZpbGUN
Cj4gaW5kZXggNzkzMDFlMWMxYzM2Li44OTA2MWI4NWU3ZDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvY2xrL2F0OTEvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9NYWtlZmlsZQ0K
PiBAQCAtMyw3ICszLDcgQEANCj4gICMgTWFrZWZpbGUgZm9yIGF0OTEgc3BlY2lmaWMgY2xrDQo+
ICAjDQo+ICANCj4gLW9iai15ICs9IHBtYy5vIHNja2MubyBkdC1jb21wYXQubw0KPiArb2JqLXkg
Kz0gcG1jLm8gc2NrYy5vDQo+ICBvYmoteSArPSBjbGstc2xvdy5vIGNsay1tYWluLm8gY2xrLXBs
bC5vIGNsay1wbGxkaXYubyBjbGstbWFzdGVyLm8NCj4gIG9iai15ICs9IGNsay1zeXN0ZW0ubyBj
bGstcGVyaXBoZXJhbC5vIGNsay1wcm9ncmFtbWFibGUubw0KPiAgDQo+IEBAIC0xNSwxMiArMTUs
MTIgQEAgb2JqLSQoQ09ORklHX0hBVkVfQVQ5MV9IMzJNWCkJCSs9IGNsay1oMzJteC5vDQo+ICBv
YmotJChDT05GSUdfSEFWRV9BVDkxX0dFTkVSQVRFRF9DTEspCSs9IGNsay1nZW5lcmF0ZWQubw0K
PiAgb2JqLSQoQ09ORklHX0hBVkVfQVQ5MV9JMlNfTVVYX0NMSykJKz0gY2xrLWkycy1tdXgubw0K
PiAgb2JqLSQoQ09ORklHX0hBVkVfQVQ5MV9TQU05WDYwX1BMTCkJKz0gY2xrLXNhbTl4NjAtcGxs
Lm8NCj4gLW9iai0kKENPTkZJR19TT0NfQVQ5MVJNOTIwMCkgKz0gYXQ5MXJtOTIwMC5vDQo+IC1v
YmotJChDT05GSUdfU09DX0FUOTFTQU05KSArPSBhdDkxc2FtOTI2MC5vIGF0OTFzYW05cmwubyBh
dDkxc2FtOXg1Lm8NCj4gLW9iai0kKENPTkZJR19TT0NfQVQ5MVNBTTkpICs9IGF0OTFzYW05ZzQ1
Lm8NCj4gLW9iai0kKENPTkZJR19TT0NfQVQ5MVNBTTkpICs9IGF0OTFzYW05bjEyLm8gYXQ5MXNh
bTl4NS5vDQo+ICtvYmotJChDT05GSUdfU09DX0FUOTFSTTkyMDApICs9IGF0OTFybTkyMDAubyBk
dC1jb21wYXQubw0KPiArb2JqLSQoQ09ORklHX1NPQ19BVDkxU0FNOSkgKz0gYXQ5MXNhbTkyNjAu
byBhdDkxc2FtOXJsLm8gYXQ5MXNhbTl4NS5vIGR0LWNvbXBhdC5vDQo+ICtvYmotJChDT05GSUdf
U09DX0FUOTFTQU05KSArPSBhdDkxc2FtOWc0NS5vIGR0LWNvbXBhdC5vDQo+ICtvYmotJChDT05G
SUdfU09DX0FUOTFTQU05KSArPSBhdDkxc2FtOW4xMi5vIGF0OTFzYW05eDUubyBkdC1jb21wYXQu
bw0KPiAgb2JqLSQoQ09ORklHX1NPQ19TQU05WDYwKSArPSBzYW05eDYwLm8NCj4gLW9iai0kKENP
TkZJR19TT0NfU0FNQTVEMykgKz0gc2FtYTVkMy5vDQo+IC1vYmotJChDT05GSUdfU09DX1NBTUE1
RDQpICs9IHNhbWE1ZDQubw0KPiAtb2JqLSQoQ09ORklHX1NPQ19TQU1BNUQyKSArPSBzYW1hNWQy
Lm8NCj4gK29iai0kKENPTkZJR19TT0NfU0FNQTVEMykgKz0gc2FtYTVkMy5vIGR0LWNvbXBhdC5v
DQo+ICtvYmotJChDT05GSUdfU09DX1NBTUE1RDQpICs9IHNhbWE1ZDQubyBkdC1jb21wYXQubw0K
PiArb2JqLSQoQ09ORklHX1NPQ19TQU1BNUQyKSArPSBzYW1hNWQyLm8gZHQtY29tcGF0Lm8NCj4g
IG9iai0kKENPTkZJR19TT0NfU0FNQTdHNSkgKz0gc2FtYTdnNS5vDQoNCg==
