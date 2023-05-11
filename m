Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593896FEBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbjEKG3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbjEKG3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:29:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862A519A6;
        Wed, 10 May 2023 23:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683786585; x=1715322585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kzcvCdS0TaPlJQv00YyIu21jQ+utuVkU2zAXgIRj0UE=;
  b=LYaqMIKZAzvMPh1IDuqKgnqUL5yZbSUV/8N4LTotmsi3QL0MhCq7O1Ou
   lFaPoRSN33jjZFfbz/lv8HAKlj1FElGwxxMW9Sq1o/dMd9tz/nP9Xkxzp
   isLa59/fK61qF2p4UIhnkmCpsJ13HoTOmfZcWxUX9nKOvoPuIfD4nVarP
   ODuYJ5pw7bIo2o46UE8W5pxyDeAN0DMOWmczc2uboCUqchjAD7ZzVjZ7s
   MJukb9KUFYtLuX+DTnx/f5ZXIHSGFOPG25cK3C7lJIq1AZorgJ92IENWs
   5VlL00BDwShGg2g6YyV+WnL9vFoYCqtDM/kjMgJ/dUCx5JtYvzpPdeEYx
   g==;
X-IronPort-AV: E=Sophos;i="5.99,266,1677567600"; 
   d="scan'208";a="214810438"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 23:29:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 23:29:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 10 May 2023 23:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH/zYGrK0MY/GuXryj8iqp8e6vyGyQTlkto3l7+cj7u08PIdXG3qO69SM9ijjl9efglDGU5V5Xjho5E6KSeYdq+sX89J/yTYSnyqaMQOKdlRE1PQbBV4L6125xo9fBcZNbDPrZuxv3gMonZJDv6iRGt/x1tXFDbgo52olvvGQxCr8PCTFyrh+xler4dka9yk0pSGiWZg1lCnsTZoDkd2pGtJO+YHLgxbRexat1zf5l5hlucHGuKgVc6MyFQ60BG81MbGF57QvcjjTNty4nyDQURyoQ4htk+wmM0kW80yHvG3DtVqLcfPZNWacC00ZijqUWlvEdXx4PyWZSpyILoyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzcvCdS0TaPlJQv00YyIu21jQ+utuVkU2zAXgIRj0UE=;
 b=NNXB576Qtbj+JfZmnPNybR4UX73qEOAx8wIlNzJ5jUFdefaIi0RKBYEc8531TB34J7mL2txLcNjLwtOYxE/m4AViRAaaQl4yBgFGNAUm7OypRjHIISvD5JdRxstJa1aoEz/Pqcms0zh8w/Rs7d7fLqezCcMJ6TbvZHe6GGAAagM+LRsNWmzWBwALtsitkNMqsIbxeBu0AdHp15Ju+ZQGwYRyoi7dgoUh4ntXZ1L4XT8pMtPT60cNMiLUJbyLNY/dGT8D/hH3HDiP4nNJPjS5FKyxmjJK5XRAMh02/IA0NvKySl89wgk1599/3Gx4piqT4gZIxjEBzR9UbwszQS2lWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzcvCdS0TaPlJQv00YyIu21jQ+utuVkU2zAXgIRj0UE=;
 b=rLAst/Xx9OVuiOrr1YAVkjmmpfJHTbysFTk/yTIy8CtITnp8WQK1yDNAIakiRGohjbowUbhAH8a0pN2TCwyusAHVH9B7m3I3TkMATDK8BJfYivJhUmpItRJYybUweL7w9UTZwzj43FUeI1KCfn3zquP2tNSN2d0yqEnOcTUEzVw=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 06:29:40 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%2]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 06:29:39 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Thread-Topic: [PATCH v3 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Thread-Index: AQHZg9H2I8l97WgyBU235juERGiPEw==
Date:   Thu, 11 May 2023 06:29:39 +0000
Message-ID: <e8e2de0e-ca7b-44e3-7853-5693a7926a2b@microchip.com>
References: <20230509052757.539274-1-claudiu.beznea@microchip.com>
 <20230509052757.539274-3-claudiu.beznea@microchip.com>
 <e463eb68-3ea0-5230-76fd-4a2ee66bf397@linaro.org>
 <773d0d90-29c7-b1bd-bd16-898b435eafb6@microchip.com>
 <b3c7db03-6614-47d9-a9e0-a8e51c836d86@linaro.org>
 <a4d934c6-ec28-50d0-b9bb-9b11fee7ebb6@microchip.com>
 <1c2aa022-348a-8ac2-1a26-eedf57aadb77@linaro.org>
 <71a1e8de-932d-09a1-efeb-af459fee9423@microchip.com>
 <8f21f892-de54-9bc7-d4b9-f36aaa6b4a7c@linaro.org>
In-Reply-To: <8f21f892-de54-9bc7-d4b9-f36aaa6b4a7c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|CO1PR11MB4884:EE_
x-ms-office365-filtering-correlation-id: b973bb13-95ca-4e96-78d9-08db51e91957
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYl3RKCZcPCEB8nyrdZGhvqQlkP9yRH2+hroX2c34hkZn1VSi6oMpRYZgQXNZQ7ZBawR2UmxdEuDYT6Q8viBgjSwCoQ5jigRIf3myOqXxzWop79sEjXulx4rxiFd6nE5bJ9nlu0PJxhkHpMuMzbECm1UZsOKeN9Z1+VeLXPxSkYBMP26gy6OpaeR6BgZRAVJggit1pkNWznbB+ZalDDmEOk3CJ5xH8+n2ndzm4tlxdfG5rLm5MyyXwBuyiVTHThBGPzbxdbPmfqvAlJCcM/yvx0v8xpFc29kxtrK5ivH4+oSc0GEvkFEw+vZnulMDLyIUNgltnnJU54FaCyOO9MBtu9wIGfWK7/PSJ4otreu1FCOm56gDA6TayTs87voYJyi4JFyw4NegTWT61BGTjTsPQ0JRK9y9intvTtVbN2Hyveaf4hSjDXYLHp+ZZ1givohIUPbLsOqtwWunBQfIWEfltppa7Uqte7RIO0MaoyjQE2x7yZTeG63ntFGS4RVy9QbXZuQCJd1GNJNggif9n/h9Ml1SXxBbA5gJ6pbmBFdsQhdbNMNLq1cdNsTaaOU8VyFKJq2jEuHiyWcrPgNi6ZEy8QXnsm669twktutUeocT9JnN/T0yfx6MXYEUu9GDGed4VUnboBV2dfkN5Yz/IwujhpaaW1RLVYcxyLfjsT0y0ETUqPbjO1pF5w/LunytzQ0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(83380400001)(2616005)(186003)(2906002)(31696002)(38070700005)(38100700002)(36756003)(86362001)(122000001)(5660300002)(8676002)(7416002)(8936002)(66556008)(66946007)(4326008)(64756008)(76116006)(66446008)(71200400001)(91956017)(66476007)(6486002)(41300700001)(316002)(31686004)(478600001)(53546011)(6506007)(26005)(6512007)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXFpQlhBcC92dFZwd0F0djN0REN1Z21aQmhXeU53Tk1VeHNIM3pWVTVxcXZi?=
 =?utf-8?B?WUpudnVuOWF5cVAyU3JWbVVCa2xKK1JJRDRWTU14N3pvek9VL1NIMHRERndG?=
 =?utf-8?B?TE8vRGNZSnhRRDBGdVpkcjM4ZkF0Y2ZwRG1NUU5kbExEK0RrbE1FdWJtazVh?=
 =?utf-8?B?UDRIT0FLbmFEZ1J3YWlveVVaR3czRGJYMHc2YjRGMmtQL1B4WUdOelZrOG1v?=
 =?utf-8?B?MHRVV3RaVUorOTNFYXh5ak5yVFAvVVhKVUw5WkpCODRiNDczdFMvOWhHVzRr?=
 =?utf-8?B?ZmR6bUQrZEZCbUxnSGtpeWZWeEVydy9udENreGF6dFhQR1pUQ1dsZzh3dmFr?=
 =?utf-8?B?bXk5WU5jUFo3SFdwbXhPOWczMlI1RGNhRU9KYk03MnhsRXovTlpZS2Fvd1hB?=
 =?utf-8?B?WGptUWdob3hKN1BvM2RWbXovczJucHZRek5haVk4NTNnZWdvOTMxSlZHTEJP?=
 =?utf-8?B?dk1zb1BMYmJ4WThpYy9sU3BsZm96MzV6Zmx6Q1ZVWVpVd1Jsb3RUVlcvbGVL?=
 =?utf-8?B?ZS8wY0taMHdqUEpicklZMFRmcmM4MUdlSEVLRXl4ZlJUbm1hQmlQemJUZ1Ix?=
 =?utf-8?B?ak9DUVZ6MW81YzVuM0k3ckVsc0RaWVg2WFliWmdyOG1ob2EzbkxXaUNyOW1Y?=
 =?utf-8?B?MlVnUmZXM2hiMVBWZ1V4aVoyc29xd3FQaHg1N3l4RjhiVUVzaFRrMTIrV1J6?=
 =?utf-8?B?T1B4bUZvMkx5dU45a3hESEwwSnZwMWNJYXNsRzJIVERIQTdVV0x1QzVyaWw1?=
 =?utf-8?B?azhsWUpUVmY4K3V3MEwvTlh6QWNQUk5RY25WZjhmek1BbDFkenBPNExuL2di?=
 =?utf-8?B?aThUWGNyNVdRdXRiOXgxUGV2RXV5RVcvSGd5blZodkJQc2NteitpUlJoa01T?=
 =?utf-8?B?UUhFbFZyMkh5OVUxK2dQRFhDd1lRNkJNVHZyb3MzakhsSXZWMDJBTDVxNzJm?=
 =?utf-8?B?NU56Sy9naW11aUg4aEswMi8wTHR4bGFsYTBYYUEreVNpVmxicjlDQXhXQUdU?=
 =?utf-8?B?WGhhVkY1MmQzQzdacmJ3WDEyM0orSWlrbll2THNscUc4b2ZycXRNMVFzNWlq?=
 =?utf-8?B?QjVEUFBzSHYzVVF1OGkwT2pabC9aT3ZrTEZGVjZQUjZYNGpVekQzanVFNEtr?=
 =?utf-8?B?cjc5T05SQXBSdXpmaGxkWG9vRlo1Tk9yM0dpTlcwTjBHdC9WWDlqb2UwYmgx?=
 =?utf-8?B?RmRwTG1na0t1ZmUyQXVJSkgxbmxFWnNLZ1FmOWFlMDdPaVBhVytYMnJZRzAx?=
 =?utf-8?B?UVdYcFd5cnBRaVhlbW9VNDRKSWtyZWxwaGt3TExnaUdUM0oxbHcxSTg4OEJ2?=
 =?utf-8?B?VHllUnJqL05pQWVKOEdYWno1U09iU0VzdHRzZmhsdEVrSmZacDU4Mm5Zemk2?=
 =?utf-8?B?cnJIWENDcDNNWXJ4Y1h6WWViS0diUDZJUHdudkFYeFZXNWUyVVZRNkhsSnRa?=
 =?utf-8?B?QzZDTzRhQVlobExobU5OQjdJTDhhR3JmNVErUE9STGdNZmw0MTZDenBaRGY3?=
 =?utf-8?B?d2tYa21ZcDdwa0xoY25acHloNjVwNkRWdmdXMXkxdktJMDluOGZ2VXVpRVpR?=
 =?utf-8?B?VzRNaHpSZzBIckNLaVFkZ2RsRWVTRStlU00yTDVTTmJiWTI1RVJ3Tm5DVkND?=
 =?utf-8?B?ZWUydWprVElORDRacUhEY3g3ZDNuQ2RadE5wVStWQXNZUXRNZ1lyRFJqUnJr?=
 =?utf-8?B?NjNDaU5oVjBCZVlCb0xsNko1U0h1cEJuQ1BSekVHYnFVd00rOE5wQ3BZUVY2?=
 =?utf-8?B?Tk1kQlpnS1ZDYU14cEN4elVFa1RaR1lXdksvMENIalRJOFFTTTI1QWZFMHNl?=
 =?utf-8?B?OXo2UEF4SE1oL2N2azg2WjRONzJnUTBBRTFualZYUGcxMEJlTys4czhhcGho?=
 =?utf-8?B?cDVJMldaWDZKb1A4ajNOa0JUMm9PYTJVRDh3WG52UEd1OWdKYVdWUHVDZlJU?=
 =?utf-8?B?TlpIdGVCSEhrcGtxbTI0K3lHaWNKanB0bm1XZFpNc2pUT0pKT2l0THhGTGpB?=
 =?utf-8?B?OWhjai9ZbFJ6aVVrZEVPeUU1R2RHWEwvajRUNjZPRGk5VFloTDI2RXBXMHo0?=
 =?utf-8?B?VUZpV2wwMUpPSm41cWpFc1NDMzh0UUMyMW9ralBQQ1RQd2x3MmRzUFdZazk2?=
 =?utf-8?Q?5e7tB2FFwqK+CV9l49BADyxPg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <428D7C5D8827A84EBD0A6813203AB86D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b973bb13-95ca-4e96-78d9-08db51e91957
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 06:29:39.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCS3JxfD6SCrFdpFk7YuGZ79jDFGY9Y2SEtumpbLNYSFFj0CHXx7oZBqp7/UiUdg8nLzxTMDhpX3uyaSEWKl7+dLrK4o3OVvJPaBzNhzYkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDUuMjAyMyAxMzoxMiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMC8wNS8yMDIzIDEwOjMxLCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMTAuMDUuMjAyMyAxMDo1
OCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDEwLzA1LzIwMjMgMDk6MTQsIENsYXVkaXUuQmV6bmVh
QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IE9uIDEwLjA1LjIwMjMgMTA6MDYsIEtyenlzenRv
ZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUNCj4+Pj4+DQo+Pj4+PiBPbiAxMC8wNS8yMDIzIDA5OjAwLCBDbGF1ZGl1LkJlem5lYUBtaWNy
b2NoaXAuY29tIHdyb3RlOg0KPj4+Pj4+IE9uIDA5LjA1LjIwMjMgMDk6MjUsIEtyenlzenRvZiBL
b3psb3dza2kgd3JvdGU6DQo+Pj4+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBPbiAwOS8wNS8yMDIzIDA3OjI3LCBDbGF1ZGl1IEJlem5lYSB3
cm90ZToNCj4+Pj4+Pj4+IENvbnZlcnQgQXRtZWwgUE1DIGRvY3VtZW50YXRpb24gdG8geWFtbC4g
QWxvbmcgd2l0aCBpdCBjbG9jayBuYW1lcw0KPj4+Pj4+Pj4gd2VyZSBhZGFwdGVkIGFjY29yZGlu
ZyB0byB0aGUgY3VycmVudCBhdmFpbGFibGUgZGV2aWNlIHRyZWVzIGFzDQo+Pj4+Pj4+PiBkaWZm
ZXJlbnQgY29udHJvbGxlciB2ZXJzaW9ucyBhY2NlcHQgZGlmZmVyZW50IGNsb2NrcyAoc29tZSBv
ZiB0aGVtDQo+Pj4+Pj4+PiBoYXZlIDMgY2xvY2tzIGFzIGlucHV0LCBzb21lIGhhcyAyIGNsb2Nr
cyBhcyBpbnB1dHMgYW5kIHNvbWUgd2l0aCAyDQo+Pj4+Pj4+PiBpbnB1dCBjbG9ja3MgdXNlcyBk
aWZmZXJlbnQgY2xvY2sgbmFtZXMpLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhhbmsg
eW91IGZvciB5b3VyIHBhdGNoLiBUaGVyZSBpcyBzb21ldGhpbmcgdG8gZGlzY3Vzcy9pbXByb3Zl
Lg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4gK3RpdGxlOiBBdG1lbCBQb3dlciBNYW5hZ2VtZW50IENvbnRy
b2xsZXIgKFBNQykNCj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+ICttYWludGFpbmVyczoNCj4+Pj4+Pj4+
ICsgIC0gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+Pj4+
Pj4+PiArDQo+Pj4+Pj4+PiArZGVzY3JpcHRpb246DQo+Pj4+Pj4+PiArICBUaGUgcG93ZXIgbWFu
YWdlbWVudCBjb250cm9sbGVyIG9wdGltaXplcyBwb3dlciBjb25zdW1wdGlvbiBieSBjb250cm9s
bGluZyBhbGwNCj4+Pj4+Pj4+ICsgIHN5c3RlbSBhbmQgdXNlciBwZXJpcGhlcmFsIGNsb2Nrcy4g
VGhlIFBNQyBlbmFibGVzL2Rpc2FibGVzIHRoZSBjbG9jayBpbnB1dHMNCj4+Pj4+Pj4+ICsgIHRv
IG1hbnkgb2YgdGhlIHBlcmlwaGVyYWxzIGFuZCB0byB0aGUgcHJvY2Vzc29yLg0KPj4+Pj4+Pj4g
Kw0KPj4+Pj4+Pj4gK3Byb3BlcnRpZXM6DQo+Pj4+Pj4+PiArICBjb21wYXRpYmxlOg0KPj4+Pj4+
Pj4gKyAgICBvbmVPZjoNCj4+Pj4+Pj4+ICsgICAgICAtIGl0ZW1zOg0KPj4+Pj4+Pj4gKyAgICAg
ICAgICAtIGVudW06DQo+Pj4+Pj4+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05ZzE1
LXBtYw0KPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWcyMC1wbWMNCj4+
Pj4+Pj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnMjUtcG1jDQo+Pj4+Pj4+PiAr
ICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05ZzM1LXBtYw0KPj4+Pj4+Pj4gKyAgICAgICAg
ICAgICAgLSBhdG1lbCxhdDkxc2FtOXgyNS1wbWMNCj4+Pj4+Pj4+ICsgICAgICAgICAgICAgIC0g
YXRtZWwsYXQ5MXNhbTl4MzUtcG1jDQo+Pj4+Pj4+PiArICAgICAgICAgIC0gZW51bToNCj4+Pj4+
Pj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTkyNjAtcG1jDQo+Pj4+Pj4+PiArICAg
ICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05eDUtcG1jDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEkgbWlz
c2VkIGl0IGxhc3QgdGltZSAtIHdoeSB5b3UgaGF2ZSB0d28gZW51bXM/IFdlIG5ldmVyIHRhbGtl
ZCBhYm91dA0KPj4+Pj4+PiB0aGlzLiBJdCdzIHVzdWFsbHkgd3JvbmcuLi4gYXJlIHlvdSBzdXJl
IHRoaXMgaXMgcmVhbCBoYXJkd2FyZToNCj4+Pj4+Pj4gYXRtZWwsYXQ5MXNhbTlnMjAtcG1jLCBh
dG1lbCxhdDkxc2FtOTI2MC1wbWMNCj4+Pj4+Pj4gPw0KPj4+Pj4+DQo+Pj4+Pj4gSSBoYXZlIDIg
ZW51bXMgYmVjYXVzZSB0aGVyZSBhcmUgc29tZSBoYXJkd2FyZSBjb3ZlcmVkIGJ5Og0KPj4+Pj4+
ICJ2ZW5kb3ItbmFtZSxoYXJkd2FyZS12MS1wbWMiLCAic3lzY29uIiBhbmQgc29tZSBjb3ZlcmVk
IGJ5Og0KPj4+Pj4+ICJ2ZW5kb3ItbmFtZSxoYXJkd2FyZS12Mi1wbWMiLCAidmVuZG9yLW5hbWUs
aGFyZHdhcmUtdjEtcG1jIiwgInN5c2NvbiIuDQo+Pj4+Pg0KPj4+Pj4gVGhlIGVudW0gZG9lcyBu
b3Qgc2F5IHRoaXMuIEF0IGFsbC4NCj4+Pj4+DQo+Pj4+PiBTbyBhZ2FpbiwgYW5zd2VyLCBkbyBu
b3QgaWdub3JlOg0KPj4+Pj4gaXMgdGhpcyB2YWxpZCBzZXR1cDoNCj4+Pj4+IGF0bWVsLGF0OTFz
YW05ZzIwLXBtYywgYXRtZWwsYXQ5MXNhbTkyNjAtcG1jDQo+Pj4+PiA/DQo+Pj4+DQo+Pj4+IE5v
dCB3L28gc3lzY29uLiBUaGlzIGlzIHZhbGlkOg0KPj4+DQo+Pj4gU3lzY29uIGlzIG5vdCBpbXBv
cnRhbnQgaGVyZSwgYnV0IGluZGVlZCBJIG1pc3NlZCBpdC4NCj4+Pg0KPj4+Pg0KPj4+PiBjb21w
YXRpYmxlID0gImF0bWVsLGF0OTFzYW05ZzIwLXBtYyIsICJhdG1lbCxhdDkxc2FtOTI2MC1wbWMi
LCAic3lzY29uIjsNCj4+Pj4NCj4+Pj4gYXZhaWxhYmxlIGluIGFyY2gvYXJtL2Jvb3QvZHRzL2F0
OTFzYW05ZzIwLmR0c2kgKzQ1DQo+Pj4NCj4+PiBOaWNlLCBzbyBteSByYW5kb20gY2hvaWNlIHdh
cyBhY3R1YWxseSBjb3JyZWN0LiBPaywgc28gYW5vdGhlcjoNCj4+Pg0KPj4+IGF0bWVsLGF0OTFz
YW05ZzE1LXBtYywgYXRtZWwsYXQ5MXNhbTkyNjAtcG1jLCBzeXNjb24NCj4+Pg0KPj4+IElzIGl0
IHZhbGlkIGhhcmR3YXJlPw0KPj4NCj4+IFRoaXMgb25lLCBuby4gU28sIEkgZ3Vlc3MsIHRoZSB3
cm9uZyBoZXJlIGlzIHRoYXQgdGhlcmUgY291bGQgYmUNCj4+IGNvbWJpbmF0aW9ucyB0aGF0IGFy
ZSBub3QgZm9yIGFjdHVhbCBoYXJkd2FyZSBhbmQgeWV0IGNvbnNpZGVyZWQgdmFsaWQgYnkNCj4+
IGNoYW5nZXMgaW4gdGhpcyBwYXRjaD8NCj4gDQo+IEkganVzdCBkb24ndCB1bmRlcnN0YW5kIHdo
eSB5b3UgaGF2ZSB0d28gZW51bXMuIFRoaXMgaXMgbm90IGEgcGF0dGVybg0KPiB3aGljaCBpcyBh
bGxvd2VkIGFueXdoZXJlLiBJdCBtaWdodCBhcHBlYXIgYnV0IG9ubHkgYXMgZXhjZXB0aW9uIG9y
IG1pc3Rha2UuDQoNCkknbSBub3QgYXQgYWxsIGFuIFlBTUwgZXhwZXJ0IGFuZCB0aGlzIGlzIGhv
dyBJJ3ZlIG1hbmFnZWQgdG8gbWFrZQ0KZHRfYmluZGluZ19jaGVjay9kdGJzX2NoZWNrIGhhcHB5
Lg0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg==
