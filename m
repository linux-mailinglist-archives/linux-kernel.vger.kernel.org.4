Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54078707A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjERGDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjERGDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:03:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CDF2102;
        Wed, 17 May 2023 23:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684389809; x=1715925809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6UEDa+KRdu9f+XcdqXzJbY4Ep7Pzh4XXvXqo2mhxdMI=;
  b=j9yC80zP8VDfXXcRIOiIdGL91vrSpbfuVkLpXor0EC4dkrovCam82RXc
   rjlmNCtcgYUY327k9HWXET7YxzvlgZQhudx0LN7dhDr4Fsoh5DHUtaRKl
   IlErODAZAFfPGRF5Ui2Ekb2gw2x3SK79ookvwpkXW3kev2zQcfkzWW/qC
   NvR3FJZPg2L9DlWzs57RPpiDRE2EODvHYk1ciAuhU4gPCbOl6Jox/m/zc
   Hz0wM+NWQwANdPmZ01GNTmOM/nvRbJmtfI457JLBh6AftwGx+JvzvQcMF
   79RjFvTrmcjN4t+J66ANp0QqMZJH0a8iP+u3gRPf5lSsWy+hNBvqbUHAu
   w==;
X-IronPort-AV: E=Sophos;i="5.99,284,1677567600"; 
   d="scan'208";a="152687158"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 23:03:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 23:03:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 23:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4rEyk2c5JQtFSFVzp3hxRNmZr/snSfAX7hQmzLF4JXcWtcXHADIZlnmOs+oyemUj71984bhuHBwBW3RievlvuM/fnxAhe+fmfHl/QOKUQcL2IyAuE5PtjBe+3gp6U3eznpvZWBu2uRz8ZN7tYchDKEobkwM0ZdQOLrffTh7Qa1bHDQqjJah8nsDMA/tCd08BoYRxZZ35qLyKhV+2/rRJKIfMhoHod39wwz+L+xofGAVwLwrHlNUs5ZbmW3/I/F2NhbtI34enGae6E0GCUb+e7UA0Q2jz2rMtDdphsBhpWRgdurSl13SNKLCZ+y+hEViUaWgIUrkboLijAxArqArRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UEDa+KRdu9f+XcdqXzJbY4Ep7Pzh4XXvXqo2mhxdMI=;
 b=SF30Ls/7g0eminghW3g4rzzPndXniAYJQYApH3WR4HYvvYVbRvcn9h4KEQMGOgHphprxirHYqddCL+RN2z/xD5sPQnicPkbY3ErzOj2NBuk1OTJTgK8OTBrZ6eaTNfskX8TiaO1YVeZUrAONJaYGKKMTI3rYGqxWBeVSqd3NgWj0z1mki0koHPlStxjnMbu0D8MDAq/hO5wovFL8VLgT2FQ2mrX6cYEDZe5PtpHQrOqi17CQc8wnUnp7HnWV2DLgav3yaTHiAgofr5uldRQLegkAq0xsYv3ltCE1Sfif5RGGHEijU4gQfX+cudvbybCGV8F1VQEN4rxFsmaNBj/2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UEDa+KRdu9f+XcdqXzJbY4Ep7Pzh4XXvXqo2mhxdMI=;
 b=nCKGuaytZWk+YT78PuwA0ZQHaGqyMKqjzVLSvUdFTEvD7hV/NWT7YR1151+TkvgRPGL03z3dLq+sgMQLtQLg7cBlllwsb51/gPDt0SzZKSby050b6wi+9BK6XTy7O3tEBaf/s5xj2WOvPW+73iAq70kYE8bsOPVE1rnGqIMowbU=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 06:03:22 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 06:03:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Conor.Dooley@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Thread-Topic: [PATCH v5 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Thread-Index: AQHZiU5zKZL6Rhh1HESEigeJj/zbcw==
Date:   Thu, 18 May 2023 06:03:21 +0000
Message-ID: <d115cd4d-2a4f-552c-692c-c69ae49fe21e@microchip.com>
References: <20230517094119.2894220-1-claudiu.beznea@microchip.com>
 <20230517094119.2894220-3-claudiu.beznea@microchip.com>
 <83f484ff-f170-6f32-f4b4-9743eb6d0b4c@linaro.org>
In-Reply-To: <83f484ff-f170-6f32-f4b4-9743eb6d0b4c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|CO1PR11MB4788:EE_
x-ms-office365-filtering-correlation-id: c4901b81-5e6c-4834-320b-08db576595b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1RGCoKfAKQfb5SRlso0dqvCpooREzr3G6tJ8wK7EvFhO3zuXQoeS3+7ou5qAeHSaRcFlmVo1DxQTnhi7CUMWt2zOHpzwpRNv6fadgAutM2PIxrZTD50zRRE0lKI2sM0ZF7ZGYj8bXh9E5lOVW6n/mHksRpwRQ8c468kPdQQLE5QaX1LReDf1FmwuDOyqqesRkibAeAliHmboMU7V3mcW5nJkKjkn0Zha50BBqshHzHxlVMi5nrIfa7oMdv11jHQDSk1ahrJo0WEThbP23CuOeNa3Woc/73+gKqoUKx3xF+WdyBXllggmV30VbR2G8MVxNoI3uPsdd8ikpf0bk1K11ipTIokIX6+QH4VnrgQcg2gV1Y/RPh56S3Lbm6oVyRbInkUwMBNB4UFAe4t4dXEfEMWVSl3HwE7pgf1aU9PvMWqXrqpx0GB92atIV5BEiUL/At6efTNNfxU0zG9IA03RQLoeVX0G9rssRUxnHmwz3R6zXjrcjyIOsUKSL6Z7wgCGrKpCBCjatusoFIs+WBmcGuTQgzW4J9mSXyYGLb8f8RBgnqosm4VoWzAui3aINSAEO5Siwdvjc2Cu8KDkBRSlrDUenzs7Z9D6AvZstGzVzQ1pL2/7GJ4kL+oAZTBWlpTQtJ3awVTYyn8JHZnJjiOKQyYKUjK0GKFEBJ7uff9mrV930YB51+AmHBf8EhLNrWTn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(31686004)(2906002)(8936002)(7416002)(41300700001)(8676002)(5660300002)(66946007)(64756008)(4326008)(66476007)(76116006)(66446008)(66556008)(91956017)(54906003)(110136005)(71200400001)(478600001)(6486002)(36756003)(83380400001)(122000001)(2616005)(53546011)(186003)(26005)(6506007)(316002)(6512007)(38100700002)(86362001)(38070700005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU5ia004cDlPb2RENGNhQlR1cnFxaVhqWXdUYlpic3ZVSE1ITlAreHZGTnYy?=
 =?utf-8?B?ZDJzbW1WV2duNXpUbWVEdDRHVlVoMUZCSkRQOHFWMUNIZk1OUWNpbU4wZGxq?=
 =?utf-8?B?U2FxQkFUZVZiRmZtYnF5QXFiZ0JCZE5Ta3kwM2NyV08yVHZ5b3lmQ2Y5NVlN?=
 =?utf-8?B?N0w4Rmp1ZXhRUUlyUW5Fa05xU1JhUnlDaFB6UGJQaktuL3ZHcUpuNllLZFNR?=
 =?utf-8?B?YmpPcHBVUks3MGtXYS93d21Ld0FYVW42aExKaUJxU1c4cWNPOElTcEFGaGtI?=
 =?utf-8?B?V29ERUgvOSszT3VBbHJWRG42Z09VMk1xZ0tVTXlIQW9xNSszNTUydmVRdFRy?=
 =?utf-8?B?S2JHL0h5ZThtam95OG1hc0NPMGNHb1RGeFpjZHFoNmdkdU5nNUxsWkJrV2VI?=
 =?utf-8?B?NDZwaklGM0lQd0dMWTdTNVA2YXhJZWh2TFhCak4weGovekcxVEJtekJQb0JQ?=
 =?utf-8?B?MUtZWnZsQWswRE1nYlA1MGVkdzc3eURkMWMvZXp0aGk3NERQYXROeFBqRU00?=
 =?utf-8?B?d0tiTlF2VkhLQ2ZJTE93azJieFN6U1JCN0J6N0JwaDZ6NGVpMnk3RXZqWFlh?=
 =?utf-8?B?L29PRE5oV1p3V1B1VXpsYnE1MzErbnd5WFk4L2FXTW5QWnYwSkpscEZZSUZq?=
 =?utf-8?B?Rk5reGdSUHJVcnkycHlKL05WSEcrQ2pFcTJ1ZFlnb0lXdkNQYmhSbkxLVEcz?=
 =?utf-8?B?WjJVbWsxUXd2Mm8rd0dYNlZkYjlpMGphV2d3bEdiTXlkUTZ3T0o0NE81Rmxx?=
 =?utf-8?B?VFB1SWlacjVwS25tc1F6ZnZxMm9HYWZ0QUh6M3RvZlVXVWxrd2NwdUVYY3N6?=
 =?utf-8?B?c2M0VEdYdDFrbFlkVmEreklPNlFrSGlqdm9XbEFWZVdzWkMzRU10VVlGYnlR?=
 =?utf-8?B?QWVxdWpzQlVnNmJtai9hcG5YbkFmeFR6cnIwSGd2RjBPM1NqY3cwa3pLOXdo?=
 =?utf-8?B?ZmFTemJOVHFtK1poZmhkNmc5dzBEMXNUb2p6U2l2RzB5U3pOd25GVXpWTlhu?=
 =?utf-8?B?bFhENmlJQ0tkQVBRVUliZzdVWm1obkFHMHFtTC8zTCtleXZuOU9scVFQQktS?=
 =?utf-8?B?UURJS3F6NEt3RXlhRDdWNWJqZElSMGl6dWVNbGpKSGJyVHpzMW9jWDcvNUcv?=
 =?utf-8?B?anFvOExqSlRNNWIyYlc2aFh5M1BMZlFLRW01NjVMZkxkUHg0WXB3Nk1nNVJn?=
 =?utf-8?B?RmVpaDBFZTV0TG5JdWhTZG9PNUhsb2gvYzdoQVZmeEMycHk0b2xWUFdaaDJz?=
 =?utf-8?B?U1hPMnNnVWtMdVAvNk95OE01Wmxabm5TdFdpVjhYekZQQWc3VkVBYlVRRnJn?=
 =?utf-8?B?eHIwVkc2SWJ6MmpoZnpMeVkxUFdjRW5TV29DdmdLT1NEMmxFTGNwMTMvcGVz?=
 =?utf-8?B?U1RMamc4aStFSTAwby92dkM2bEhjM1ducWZmZ3NUNkJWRFVLVVBGMmVycE4v?=
 =?utf-8?B?OEczRHpwaXFZV0VHeVh6Ny8xbkZHbklvaWhNS0tqN2UxQ29ORk1KME5kZE83?=
 =?utf-8?B?T003OHJlN1Fnc3FYZ29nR2JZdlExcVluSTV6M3NzNE10OGo2RVBGRlM3WDFV?=
 =?utf-8?B?dllOT1Z0OG9EWVc3Q3pVZXl6b1BkNUZtTFU2MFhZYS8vNy9EQnJWb2c2cG8z?=
 =?utf-8?B?VE9SZk44YXJkOUJnVnIxSUhRM2psdWFRQkhaa2N5d0pyMGNNVklEdEpiL0dC?=
 =?utf-8?B?NGhXTkZEV0llMkxHQjBvVkNOVWhZbVgraWlnWXJPaklpWnZMNnhyTGtLeTM3?=
 =?utf-8?B?TkIrR1dDRkcxZUUwSTRPTW52WHhWdDkwZkpUOHpkQVR4b3RXOFdyRU1RMEtH?=
 =?utf-8?B?bkhQS2I3RjhIM0lFQmt4YkxzWFVBZlVHbUVlNmpzN1ZWUU9qckFXU1k1L2c3?=
 =?utf-8?B?RWFuKzRseVl2RXU5RnhXRm5XZ1FFeW5yVUZzUzlHRU8wMUQ2dmdaU1BKRTFs?=
 =?utf-8?B?R3Erc3paYklsY3RnZ1lLTVk0eDRWUytqblkrNFF2R05XSWEyY2RNNDlBOXV0?=
 =?utf-8?B?aE9POTdaeVl2RkdWNmZJNjNWLzE3U1NoeVJJNTNBUEJoTjBwRDAzQzN2V2NP?=
 =?utf-8?B?L1greThIY21TblFKY0VKTjdxd3o2bjJsU2hrNjF6VytkQnJtRHgyeWtsS1Jj?=
 =?utf-8?B?alI5V0I3OEQzMFYzSEc5NzZqcWJSaXhXQjlGc1o0anFaMEFWRlFvSDBEazcx?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAB431279614104EA7123B6DD6396719@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4901b81-5e6c-4834-320b-08db576595b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 06:03:21.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1vTazYjGQL+Pk7ZiZgTXBQXhVQK2VS4bXNfhhP3kyBcfcUOlfz9WKPcoRhTGi4sbFL7zj56aDyQwDvEryOkcz6LaHhQDIv+qisKOfrTw6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDUuMjAyMyAxNzoyMSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxNy8wNS8yMDIzIDExOjQxLCBD
bGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IENvbnZlcnQgQXRtZWwgUE1DIGRvY3VtZW50YXRpb24g
dG8geWFtbC4gQWxvbmcgd2l0aCBpdCBjbG9jayBuYW1lcw0KPj4gd2VyZSBhZGFwdGVkIGFjY29y
ZGluZyB0byB0aGUgY3VycmVudCBhdmFpbGFibGUgZGV2aWNlIHRyZWVzIGFzDQo+PiBkaWZmZXJl
bnQgY29udHJvbGxlciB2ZXJzaW9ucyBhY2NlcHQgZGlmZmVyZW50IGNsb2NrIChzb21lIG9mIHRo
ZW0NCj4+IGhhdmUgMyBjbG9ja3MgYXMgaW5wdXQsIHNvbWUgaGFzIDIgY2xvY2tzIGFzIGlucHV0
cyBhbmQgc29tZSB3aXRoIDINCj4+IGlucHV0IGNsb2NrcyB1c2VzIGRpZmZlcmVudCBjbG9jayBu
YW1lcykuDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guIFRoZXJlIGlzIHNvbWV0aGlu
ZyB0byBkaXNjdXNzL2ltcHJvdmUuDQo+IA0KPiANCj4+ICsNCj4+ICsgIC0gaWY6DQo+PiArICAg
ICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+PiArICAgICAgICAgIGNv
bnRhaW5zOg0KPj4gKyAgICAgICAgICAgIGVudW06DQo+PiArICAgICAgICAgICAgICAtIGF0bWVs
LGF0OTFybTkyMDAtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05MjYwLXBt
Yw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWcyMC1wbWMNCj4+ICsgICAgdGhl
bjoNCj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgY2xvY2tzOg0KPj4gKyAgICAg
ICAgICBtaW5JdGVtczogMg0KPj4gKyAgICAgICAgICBtYXhJdGVtczogMg0KPj4gKyAgICAgICAg
Y2xvY2stbmFtZXM6DQo+PiArICAgICAgICAgIGl0ZW1zOg0KPj4gKyAgICAgICAgICAgIC0gY29u
c3Q6IHNsb3dfeHRhbA0KPj4gKyAgICAgICAgICAgIC0gY29uc3Q6IG1haW5feHRhbA0KPj4gKw0K
Pj4gKyAgLSBpZjoNCj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgY29tcGF0aWJs
ZToNCj4+ICsgICAgICAgICAgY29udGFpbnM6DQo+PiArICAgICAgICAgICAgZW51bToNCj4+ICsg
ICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVkMi1wbWMNCj4+ICsgICAgICAgICAgICAgIC0gYXRt
ZWwsc2FtYTVkMy1wbWMNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVkNC1wbWMNCj4+
ICsgICAgdGhlbjoNCj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgY2xvY2tzOg0K
Pj4gKyAgICAgICAgICBtaW5JdGVtczogMg0KPj4gKyAgICAgICAgICBtYXhJdGVtczogMg0KPj4g
KyAgICAgICAgY2xvY2stbmFtZXM6DQo+PiArICAgICAgICAgIGl0ZW1zOg0KPj4gKyAgICAgICAg
ICAgIC0gY29uc3Q6IHNsb3dfY2xrDQo+PiArICAgICAgICAgICAgLSBjb25zdDogbWFpbl94dGFs
DQo+IA0KPiBUaGlzIGFuZCBwcmV2aW91cyBpZiwgc2hvdWxkIGJlIHNxdWFzaGVkLiBZb3UgaGF2
ZSBleGFjdGx5IHRoZSBzYW1lIHRoZW46Lg0KDQpDbG9jayBuYW1lcyBhcmUgZGlmZmVyZW50LiBP
ciBkbyB5b3UgcHJvcG9zZSB0byBoYXZlIGEgaWYgZm9yDQpjbG9ja3M6DQogIG1pbkl0ZW1zOiAy
DQogIG1heEl0ZW1zOiAyDQoNCmFuZCAyIGlmcyBmb3IgY2xvY2sgbmFtZXM/DQoNCj4gDQo+IA0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg==
