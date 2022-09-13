Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1495B6A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiIMJTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiIMJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:19:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E62DEF;
        Tue, 13 Sep 2022 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663060775; x=1694596775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0dFAibKpYm1f7rPnHlhlDVXmQAzDJAhv3nTHnELk21E=;
  b=kO1JQHmV+6uKKQkmBWcQISnBkFKTgahW03AQVVG0dIV13Iv1Pegt7nNr
   j25iYfddAA0bzkP7OD4AkrrvD+DDPPDOevtJkvZtSttdqlM0Er1L6Z019
   ie42lUKyVJfO+dK6oqAq/W+oRWTtH6pEzkjBuJqg7CawcLUhCMZjcRfY8
   41CfVRu+tr3ahu1n86mETNLlOXTPzI2Br/joqjnHuoNOL2ACvn/7EmrN1
   xDfxerFJAi6cfMmg90SGusoaxfo1Pfsm+BjxAdOBnNk8YE2Hpjp2HTzQH
   1wUdSKd0gwoENfD9r7nWGVqXWa6trI0jRDif8FXocfL7JbkpKmXjDO0YO
   A==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="180153374"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 02:19:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 02:19:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 02:19:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaavlKZXS3YnQnbDeU48MoLl3JT3jVk3TpwiMJ8UWv1YuQufQ1lIRXSR8yTOBM6unPYB5xzbLZG7pUCndRRrfUu4/FXMGMcC4NZuZ6lmQZV28SCu8jdeVuwmBML0w9S6XM6BBRY9w07K4QR+gQxy+SqfBb4h9oRNI5qoFKGWPtiyZ5eioOWHUhtj31xkmERfpm7pkGz9Goaiqa+CBKj5LhiaJp4JQvpxNViqZH9X+tx7dqkiUg2fDXtiUrlY8Z/JXBsUIl8L/KdBkof8TMypczgws8mNy1SxOluBAmKFnuvYmwgTY+9MRx6wVH+p70zNdyOTjgN2sN5VaAIkD3wa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dFAibKpYm1f7rPnHlhlDVXmQAzDJAhv3nTHnELk21E=;
 b=jeodYOsaKUaPKQCmEZZIkZooO2ZVs8IGgkgrVpXj2w0Y4RsENpwCko8WjwGUD8SgYnbbnDZ4BadAz2OmJhtZ7eCPP6EdMjadCrUiGzV3VEo2SdY5sNyUO4edYT6REvNIjYMVQUZ89fUkoQkwwnMmHPouGWo0Z3KuVDW4S32Y1kwhK6VzL9b+KcrlbVnM8PG1+TMnmIOJnbJgBLVIJv+Dkuo0qPh7uGcv8dyef2BvV7PvqmlUuwHNZNb8/joTZ3nI/znwr6U4Lc/63sPr4lCXqTfdH9p2QGlidpPiQ6DTFfs+iSwq++Ul3OmtECflmWv+3A17vGE/bsCxGxwbnh0uJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dFAibKpYm1f7rPnHlhlDVXmQAzDJAhv3nTHnELk21E=;
 b=LLjk1oXdqx+d5ZbMg/QF3KGnHby1Ng8msd6Q9hZ5IXtrBXy6QDmBJ49lIcoZuDQCpdwVsMw2Dyp/JoQ+7x2KQ6o1ZME5z1FPpBluKPaCBv3EIP+Hgm+cYRH2bTaSv1nmCC/difDYOg6ufNIZrYb0uyIhoDWur5B5EpRNdNQKBek=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by PH0PR11MB5579.namprd11.prod.outlook.com (2603:10b6:510:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 09:19:31 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::e8ff:82ac:b76d:c61c]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::e8ff:82ac:b76d:c61c%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:19:31 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>
CC:     <lee@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <richard.genoud@gmail.com>,
        <radu_nicolae.pirea@upb.ro>, <gregkh@linuxfoundation.org>,
        <broonie@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Thread-Topic: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Thread-Index: AQHYwfjCQbG755VmlEGUqK2TrhMH7a3VeaSAgAAuKICAAK1+AIAFHfCAgAAyC4CAACijAIABTCEAgAAF4YA=
Date:   Tue, 13 Sep 2022 09:19:31 +0000
Message-ID: <888b8ab9-f8cb-2e1f-465c-3cb97187fce0@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-7-sergiu.moga@microchip.com>
 <9aa29d74-b1fc-d00e-dee4-57f277a366ab@linaro.org>
 <c30cc112-0fb8-01e6-1bb8-eed7db0b9049@microchip.com>
 <20220909013644.GA3731620-robh@kernel.org>
 <b6b044f6-de87-e85b-0b51-e957b90622ab@microchip.com>
 <aa6d8c7d-1723-7674-2142-a5aafe30e570@linaro.org>
 <77d38e3f-6d8c-dbb1-2e66-c768d95b5e35@microchip.com>
 <5f8ca612-5a89-db3a-42f3-a0613c192a87@linaro.org>
In-Reply-To: <5f8ca612-5a89-db3a-42f3-a0613c192a87@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|PH0PR11MB5579:EE_
x-ms-office365-filtering-correlation-id: 3078cf37-f018-4843-9ed9-08da956910c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GxNC4igJBrteuMZpi4mGCLHy8qTJFJKyu3g4o8AKQrZEairuO8sLr/9Ro/LRDgr7m2g8O3hbhE3QlsK3Oldu7jkNfcPh/kXT/e4qxvkiT1bVNuFbTHQoB03Bk1WQWMcC61AB/hN/o/ndWOoyAo0CilAqSC+AzDJhV9wJOYFJyBjbdcBAjIDI6TOrGToXTfZ3iI+JgJKxoTOtDiwunY5t7oPHUmcX5mcxBRLd5N3+a7wCCnt+dljSUmdkKo/PzLUPOaO+NZ66XCekzUVv4b5KsgDyFsEoktKih3woOIJu+vnN56FBswPuON7iDz1szymF4rJ9PUpGpRRdyVKmRmJPqZcXzNuQFIcDPxNvUoBDXHCcGZOjLNcejJW1FxMZazvf9VueZRpZYXrFSMAEB4oTHO9lwnXi5dzwALK6oIjz7XfUogU+ESsI1/WRBKrwE42yDacGAsjvqrSmuOVupKoA5OCCJqh9RK75R0jDCofM2cbCNfCeYx92WAac+aLVpp/RFYN7NIuBhXVDT5TXHoQS+/zhqAQoptPjRvxGCP2LkO8AZSdUroi2SI1S3x8/qlKgyHVL1pYv/Qet/jXMR2L7PRTFZ8Cr9zSKNgrbguzQt/llfMlrLBnGJySFVpgaa2C1RI44X7LUJQZu7U5T3fL6CANCmLkz8K90CGxfz74Qti/Mm3VXPsDyaUY2E60frtjeN6nZgnpiy3SbszKtlfxr1z5jvJ7v24r4WUhQhf82nO7QQk+lHW+zXy0eTbnGczuv+ovM5byetLHBRJwg2L7NLF4jNqKBUjX5fSjwZ2lJxds=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(8676002)(7416002)(5660300002)(2616005)(66946007)(66476007)(41300700001)(6512007)(186003)(26005)(53546011)(316002)(38100700002)(31686004)(2906002)(122000001)(478600001)(4326008)(71200400001)(76116006)(31696002)(36756003)(54906003)(86362001)(64756008)(8936002)(110136005)(83380400001)(6486002)(91956017)(66556008)(66446008)(6506007)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTJPdFRrSWtmYjhGU25zTWpDWUlNdTQ0WU1INFhrWDVnTDlzNDZTTVZZeDdk?=
 =?utf-8?B?aUJzMHh6Ry9jM3RlcGRTSmY3TW9WQStaUUdZajlYTmZHaDJMY1ZzUVJpL2ZQ?=
 =?utf-8?B?T1FmS3ozYUhOL1dBclRRNzRRSlJRd0t5bVkyUDkxbGxtVVp0QWJSVEJ0UzZj?=
 =?utf-8?B?NzRQcElwYjRaeUttWlRHT3pITEQ0eGVkd3BwNTFmZXlyM2w1clpyQVdFVm9Q?=
 =?utf-8?B?T004cU0zd2N2bnRGTWpVS3NTY2FEbW9FQVhKMXFlelVKQ0dwdlVsOC85dWR5?=
 =?utf-8?B?WDdCREZHSXErcGN6cjBoK3BYMHJ6MFRJdmk1Znc4VVBTTGFJaHFLQUsyQ2RY?=
 =?utf-8?B?MVJZTjdwZkdNRHlJZzFIL3dwOSt3UW1yTHpuWERKek41T1g1SWk0d2IxYTdL?=
 =?utf-8?B?anpMaTlBWUFVMEk0WU1TZG5yb2dncFk2TUpPTnF5SCtMWnlOY2FwUm5FSm81?=
 =?utf-8?B?L1dDN3JOeGlvNnBkVmlOakZQazlCbHZzZEZEd3NEdDhHUy8vUXNIenpxb1FO?=
 =?utf-8?B?ejdNR0hHVFVCMFkzemdzZDc4K2FUalgxWEpRRURidVRmQ0RYU3V0U1BmV3l6?=
 =?utf-8?B?U29FMFZSMGpsWFBpbXV5VTNpVDVVdjVQWS84VnBrWmhhQi9IRlMzS2tkekVT?=
 =?utf-8?B?NmZnK2VlakxvdjU2aDNiSDJDM2ZGOThMSlEybXJjNGxlTlA5RllmT0F5YUdM?=
 =?utf-8?B?OWovVXcxTjYwbFRqZmN0MzBSem04aCtlL0VOM0xEVTRWOUpWd3dXYmlSc2R4?=
 =?utf-8?B?cm85K0w0TGJISzQwbW9kRE1BY1VhcUNLcVArWTAvbnVjd1h5K21ReUdjMDl1?=
 =?utf-8?B?VS9Xd0NOWVVWZ1BZUFFLVnJUdkw2RTZGTWRVZ25SanRoU1NzM0VHdWtTemlz?=
 =?utf-8?B?aUZJVUZaSGxtVXlyakI3Snlxdy9PK3pKVWN0M3dnbU56TDZKOFpKajVNZFBD?=
 =?utf-8?B?czBmclB3ci9sQ3VQeUJ3VVJIQndJRDhSSEI5MXdqcmRsSm5jOTJCL0JBdVUy?=
 =?utf-8?B?cDRieG5vSFJZSnU5Z2NSdXJPdFVjZFBRTDdDVFdBR1FXSTJrd3JwOVlRMklM?=
 =?utf-8?B?dWtMUXVnNi9mSUYzeTNjMXJ6YTJiM3cvRExtM3pDa3BjTzRqSG8ydmFGS3JE?=
 =?utf-8?B?WjBqMTYxUTd3MzdjeVkyeVh2NFVkUmRQWExHOUNERThpdGpHZWZMYmVKMjlt?=
 =?utf-8?B?WjlkbXd4Wm9rSkdpV0tOczNhdUZXSHlGbFJNcTY2Z2N3RlV5WmtzbG1HZlU3?=
 =?utf-8?B?RHoya0NKOFRJeXh6MHVCSFR6WWQ0V2E3bnBKUnQ4Q2lPYjRiSlY0OWFRUEtz?=
 =?utf-8?B?UlNob0NabVhkSzY1YVY1UXR1T0pFZjBsc0NyS24yYmpJRmFRS3A1U0N3YVBM?=
 =?utf-8?B?Y2duRmo5UUJIYVR4VlR0OURJaWVCb2hTN1hZdUNmcEtEU0ZZTFhBS0hIZHB5?=
 =?utf-8?B?ODI2NFhSWWVzalZCQWkwc20zRGVzcmZCSVF6Z05FdGhlVUlkWEU3Wloxd2lq?=
 =?utf-8?B?T2NvWnZ4TkNvbmo4S1d1KzJnUEtjSTlab05ieitzS1RUckZFb3pLNXFicU1E?=
 =?utf-8?B?WStBSDhzbHA1dGY2cTlHVUo0Q0tUdEFmZmdnZ0JuOHQ2TWdWYlZXanQ1YkdU?=
 =?utf-8?B?Ry9vY2prSXM5TWJDdk1QcStoMVRjZkZ0OTAvL1hIaGR1Y1JJczJkNi9Ca2ZG?=
 =?utf-8?B?V2xrU3BCckw3WXlEbEFBcy9oei9SU1lDNFloSmJoazdFQ25lVDd2Y3EyNFI3?=
 =?utf-8?B?SDcvYlNGQndoVTZTSkhOeWNBc3BFQ1NBUVU2Q0dJR1YxWklFN2thRHhTYnBW?=
 =?utf-8?B?WUwrcDNHTForRVZmQmR6VmpiR3o0V1FINGplSkw3dVg0bUN6YngrQmIvQ1Jl?=
 =?utf-8?B?TmIrVkc3Q0JnWWk3T2xNZlIrWkZkUXpWYzNzUEJKUFdBRnkwK0p6RkFrYTFm?=
 =?utf-8?B?ZVJCQlV0ZFhYR0hnVVlUQXhoU0RQeFZxRUdCcGx4dXExREVZNTI4VnpmYSsr?=
 =?utf-8?B?SGhzVUUyZGtaRXJUT1BXd2ZJbG0zTW1GTU9lQ29XU2d4VlU0aUZGMmhwbFJh?=
 =?utf-8?B?VUNEYUhFMHFMSmY0dVFjcmpBbGFMZTVma0dHUEJVcHNwNzljcTRnSDZNNHo3?=
 =?utf-8?Q?RBqLnrZ7kM9TuuyfVE2JNVFX0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D87C255AB30E91409A9E5DF6B30300A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3078cf37-f018-4843-9ed9-08da956910c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 09:19:31.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qzp2AGFC8NVm/pan2pZRU3R1O24CBvtJ8ngbiMcszNTjdxNAdWwCgrCzbi7E5eWtqwU11YyU/jrNsImaNfoyvGyK1Hg3pDh5+c4pfz1o6a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5579
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDkuMjAyMiAxMTo1OCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTIv
MDkvMjAyMiAxNTowOSwgU2VyZ2l1Lk1vZ2FAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDEy
LjA5LjIwMjIgMTM6NDQsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4gT24gMTIvMDkv
MjAyMiAwOTo0NSwgU2VyZ2l1Lk1vZ2FAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4gT24gMDku
MDkuMjAyMiAwNDozNiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+Pj4+PiBPbiBUaHUsIFNlcCAwOCwg
MjAyMiBhdCAwMzoxNTo0NFBNICswMDAwLCBTZXJnaXUuTW9nYUBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4+Pj4+IE9uIDA4LjA5LjIwMjIgMTU6MzAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6
DQo+Pj4+Pj4+IE9uIDA2LzA5LzIwMjIgMTU6NTUsIFNlcmdpdSBNb2dhIHdyb3RlOg0KPj4+Pj4+
Pj4gQWRkIHRoZSBBVDkxU0FNOTI2MCBzZXJpYWwgY29tcGF0aWJsZXMgdG8gdGhlIGxpc3Qgb2Yg
U0FNOVg2MCBjb21wYXRpYmxlcw0KPj4+Pj4+Pj4gaW4gb3JkZXIgdG8gaGlnaGxpZ2h0IHRoZSBp
bmNyZW1lbnRhbCBjaGFyYWN0ZXJpc3RpY3Mgb2YgdGhlIFNBTTlYNjANCj4+Pj4+Pj4+IHNlcmlh
bCBJUC4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2Vy
Z2l1Lm1vZ2FAbWljcm9jaGlwLmNvbT4NCj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+
DQo+Pj4+Pj4+PiB2MSAtPiB2MjoNCj4+Pj4+Pj4+IC0gTm90aGluZywgdGhpcyBwYXRjaCB3YXMg
bm90IGhlcmUgYmVmb3JlDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+ICAgICAgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwg
fCAyICsrDQo+Pj4+Pj4+PiAgICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+
Pj4+Pj4+DQo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NlcmlhbC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2F0bWVsLGF0OTEtdXNhcnQueWFtbA0KPj4+Pj4+Pj4gaW5k
ZXggYjI1NTM1YjdhNGQyLi40ZDgwMDA2OTYzYzcgMTAwNjQ0DQo+Pj4+Pj4+PiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2F0bWVsLGF0OTEtdXNhcnQueWFt
bA0KPj4+Pj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nlcmlh
bC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwNCj4+Pj4+Pj4+IEBAIC0yNiw2ICsyNiw4IEBAIHByb3Bl
cnRpZXM6DQo+Pj4+Pj4+PiAgICAgICAgICAgIC0gaXRlbXM6DQo+Pj4+Pj4+PiAgICAgICAgICAg
ICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2MC1kYmd1DQo+Pj4+Pj4+PiAgICAgICAgICAg
ICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2MC11c2FydA0KPj4+Pj4+Pj4gKyAgICAgICAg
ICAtIGNvbnN0OiBhdG1lbCxhdDkxc2FtOTI2MC1kYmd1DQo+Pj4+Pj4+PiArICAgICAgICAgIC0g
Y29uc3Q6IGF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoaXMgaXMg
d2VpcmQuIFlvdSBzYXkgaW4gY29tbWl0IG1zZyB0byAiaGlnaGxpZ2h0IHRoZSBpbmNyZW1lbnRh
bA0KPj4+Pj4+PiBjaGFyYWN0ZXJpc3RpY3MiIGJ1dCB5b3UgYmFzaWNhbGx5IGNoYW5nZSBoZXJl
IGV4aXN0aW5nIGNvbXBhdGlibGVzLg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBEb2VzICJzaG93
IHRoYXQgdGhleSBhcmUgaW5jcmVtZW50YWwgSVAncyIgc291bmQgYmV0dGVyIHRoZW4/DQo+Pj4+
Pj4NCj4+Pj4+Pg0KPj4+Pj4+PiBUaGlzIGlzIG5vdCBlbnVtLCBidXQgYSBsaXN0Lg0KPj4+Pj4+
Pg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBXaGF0IGRvIHlvdSBtZWFuIGJ5IHRoaXM/IEkga25v
dyBpdCBpcyBhIGxpc3QsIEkgc3BlY2lmaWVkIHNvIGluIHRoZQ0KPj4+Pj4+IGNvbW1pdCBtZXNz
YWdlLg0KPj4+Pj4NCj4+Pj4+IFlvdSBhcmUgc2F5aW5nIHRoYXQgY29tcGF0aWJsZSBtdXN0IGJl
IGV4YWN0bHkgdGhlIDQgc3RyaW5ncyBhYm92ZSBpbg0KPj4+Pj4gdGhlIG9yZGVyIGxpc3RlZC4g
WW91IG5lZWQgYW5vdGhlciBlbnRyeSB3aXRoIGFub3RoZXIgJ2l0ZW1zJyBsaXN0Lg0KPj4+Pj4N
Cj4+Pj4+IFJvYg0KPj4+Pg0KPj4+Pg0KPj4+PiBUaGF0IGlzIHdoYXQgd2FzIGludGVuZGVkIHRo
b3VnaDogYSBsaXN0IG9mIHRoZSA0IGNvbXBhdGlibGVzIGluIHRoYXQNCj4+Pj4gZXhhY3Qgb3Jk
ZXIuIFRoZSA0dGggcGF0Y2ggb2YgdGhpcyBzZXJpZXMgYWxzbyBlbnN1cmVzIHRoYXQgYWxsIDl4
NjANCj4+Pj4gbm9kZXMgaGF2ZSB0aGF0IGV4YWN0IGxpc3Qgb2YgNCBjb21wYXRpYmxlcy4NCj4+
Pg0KPj4+IFRoZSBjb21taXQgbXNnIHN1Z2dlc3Qgb3RoZXJ3aXNlIC0gdHdvIG9wdGlvbnMsIGJl
Y2F1c2UgaXQgaXMNCj4+PiBpbmNyZW1lbnRhbC4uLiBCdXQgdGhpcyBvbmUgaXMgbm90IHJlYWxs
eSBpbmNyZW1lbnRhbCAtIHlvdSByZXF1aXJlIHRoaXMNCj4+PiBvbmUsIG9ubHkgb25lLCBjb25m
aWd1cmF0aW9uLiBJdCdzIGluIGdlbmVyYWwgZmluZSwgYnV0IGNvbW1pdCBtc2cNCj4+PiBzaG91
bGQgcmVmbGVjdCB3aGF0IHlvdSBhcmUgcmVhbGx5IGludGVuZCB0byBkbyBoZXJlIGFuZCB3aHkg
eW91IGFyZQ0KPj4+IGRvaW5nIGl0Lg0KPj4+DQo+Pj4NCj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4g
S3J6eXN6dG9mDQo+Pg0KPj4NCj4+IE15IGFwb2xvZ2llcywgSSBzdGlsbCBkbyBub3QgdW5kZXJz
dGFuZCB3aGF0IGlzIHdyb25nIHdpdGggdGhlIGNvbW1pdA0KPj4gbWVzc2FnZS4gTXkgaW50ZW50
aW9uIHdhcyB0byBlbnN1cmUgdGhhdCBldmVyeSA5eDYwIHVzYXJ0IGNvbXBhdGlibGUgaXMNCj4+
IGZvbGxvd2VkIGJ5IHRoZSA5MjYwIGNvbXBhdGlibGVzIGJlY2F1c2UgdGhlIDl4NjAgc2VyaWFs
IElQIGlzIGFuDQo+PiBpbXByb3ZlbWVudCBvdmVyIHRoZSA5MjYwIG9uZS4gV291bGQgeW91IHBy
ZWZlciBpdCB0byBiZSBqdXN0IHRoZSBmaXJzdA0KPj4gcGFydCBvZiB0aGUgY29tbWl0IG1lc3Nh
Z2U6IGBBZGQgdGhlIEFUOTFTQU05MjYwIHNlcmlhbCBjb21wYXRpYmxlcyB0bw0KPj4gdGhlIGxp
c3Qgb2YgU0FNOVg2MCBjb21wYXRpYmxlc2A/IFRoYXQgd2F5IGl0IHdvdWxkIHJlYWxseSBvbmx5
IGJlIHdoYXQNCj4+IHRoZSBjb21taXQgZG9lcy4NCj4gDQo+IExldCBtZSByZXBocmFzZSBpdDoN
Cj4gDQo+IFdoYXQgeW91ciBjb21taXQgaXMgZG9pbmcgaXMgcmVxdWlyaW5nIGFkZGl0aW9uYWwg
ZmFsbGJhY2sgY29tcGF0aWJsZXMuDQo+IFRoZXJlZm9yZSB0aGUgY29tbWl0IG1zZyBzaG91bGQg
YW5zd2VyIC0gd2h5IGRvIHlvdSByZXF1aXJlIGFkZGl0aW9uYWwNCj4gZmFsbGJhY2sgY29tcGF0
aWJsZXM/DQo+IA0KDQoNClRoZSBhZGRpdGlvbmFsIGZhbGxiYWNrIGNvbXBhdGlibGVzIGFyZSBy
ZXF1aXJlZCBiZWNhdXNlIHRoZSBkcml2ZXIgaW4gDQpxdWVzdGlvbiBvbmx5IGtub3dzIGFib3V0
IHRoZSBhdG1lbCxhdDkxc2FtOTI2MC11c2FydCBjb21wYXRpYmxlLiANCkZ1cnRoZXJtb3JlLCBp
dCBpcyBhbHNvIGEgYmV0dGVyIHJlcHJlc2VudGF0aW9uIG9mIHRoZSBmYWN0IHRoYXQgdGhlIA0K
c2VyaWFsIElQIG9mIDl4NjAgaXMgYW4gaW1wcm92ZW1lbnQgb3ZlciB0aGUgc2VyaWFsIElQIG9m
IDkyNjAgKGl0IA0KY29udGFpbnMgbW9yZSBoYXJkd2FyZSBmZWF0dXJlcyBub3QgeWV0IGltcGxl
bWVudGVkIGluIHRoZSBkcml2ZXIpLg0KDQoNCj4gSW5jcmVtZW50YWwgY2hhcmFjdGVyaXN0aWNz
IHNvdW5kIHRvIG1lIG9wdGlvbmFsLiBJIGNhbiBpbmNyZW1lbnQNCj4gc2FtOXg2MCB3aXRoIHNv
bWV0aGluZyBvciBJIGNhbiBza2lwIGl0LiBCdXQgeW91IGFyZSBub3QgZG9pbmcgaXQuLi4NCj4g
c2FtOXg2MCB3YXMgYWxyZWFkeSB0aGVyZSBhbmQgbm93IHlvdSByZXF1aXJlIGEgZmFsbGJhY2su
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpTbywgd2hhdCBpcyB5b3VyIG9w
aW5pb24gb24gdGhlIGZvbGxvd2luZyBjb21taXQgbWVzc2FnZToNCg0KIkZpeCBzYW05eDYwIGNv
bXBhdGlibGUgbGlzdCBieSBhZGRpbmcgdGhlIHNhbTkyNjAgY29tcGF0aWJsZXMgYXMgDQpmYWxs
YmFjaywgc2luY2UgdGhlIGF0bWVsX3NlcmlhbCBkcml2ZXIgb25seSBrbm93cyBvZiB0aGUgbGF0
dGVyJ3MgDQpjb21wYXRpYmxlLiBUaGUgYXRtZWxfc2VyaWFsIGRyaXZlciBvbmx5IGhhcyBrbm93
bGVkZ2Ugb2YgdGhlIHNhbTkyNjAgDQpjb21wYXRpYmxlIGJlY2F1c2UgaXQgZG9lcyBub3QgaGF2
ZSB0aGUgc2FtOXg2MCdzIHNlcmlhbCBJUCBzcGVjaWZpYyANCmZlYXR1cmVzIGltcGxlbWVudGVk
IHlldCBhbmQgYWRkaW5nIGFuIGVtcHR5IGNvbXBhdGlibGUgd2l0aG91dCBhZGRpbmcgDQpzdXBw
b3J0IHNwZWNpZmljIHRvIHRoYXQgY29tcGF0aWJsZSB3b3VsZCBiZSBtaXNsZWFkaW5nLiBUaHVz
IHByZWZlciB0aGUgDQpmYWxsYmFjayBtZWNoYW5pc20gaW4gdGhlIGRldHJpbWVudCBvZiBhZGRp
bmcgYW4gZW1wdHkgY29tcGF0aWJsZSBpbiB0aGUgDQpkcml2ZXIuIg0KDQpUaGFua3MsDQoJU2Vy
Z2l1DQo=
