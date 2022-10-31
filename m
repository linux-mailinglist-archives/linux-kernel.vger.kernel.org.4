Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412DD613386
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiJaKYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJaKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:24:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D5BD2F6;
        Mon, 31 Oct 2022 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667211874; x=1698747874;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=7PDwtqc3kp/u22NMvrxMHlwwH3jKiGzo35WegZ6P6xU=;
  b=Ld6AjVmxU8q45md4KQBus9T/qiqCtJyIjzkCSK16nDfOGCHBJHLG5c74
   T0GcBXlSYdQ+aaTmIoRlxSfSaT8fA0RogVmZVhCNFvyqPliPW/1qklnMJ
   HjOK3OOuy4lLKQA8TqLDEKquqkacYduxFOtaRWbJwfBsc8Gc7oS7Ke/gG
   HJGEjvW5V1g88+R9Kl/47+qC0RAAEAswDel9gy9OKFfVRaEfUwu68V2l+
   KwJmeogFZ246nDWW7P5dZpAkMy+7BJ8UOY27BfrdRD8CH0h+ki9gtJl08
   F6ZhIeL/xAwSSNtcT1irSuVX3jLjPD8jG6uP4Le37lCkoJBIxb5089LSq
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="187031010"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2022 03:24:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 31 Oct 2022 03:24:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 31 Oct 2022 03:24:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwiQ1FEgfpEm+YG2Xgpz4+6TjAF+j0/ns2Zirzb8xsHJzp7jskyAICEI9NK/VwfLlRO3tANlXRxjnZKogcJq4RyMMIPH5K69mi0qJK5SBB4u/DZrK4pZim5KFx9IJu26E4pEcMZevob9SpoCOhEBXBr395o0iRc1vKBHTcyToIk5AgkXjf2KtCcpLfkw/HWbF9wltQzY50+4H51Nzv/KjZ8tnrJyXEyjY8p88pnsaphEAP6AYUv8vJesZOUkXsFpHDWVOHZip+GVe4RGtsCIqk7USBKjMXucIk8uV2P6SI8gO+FQ6Ft11a2qzEgEnhQAD8wMrXeZruVuQFrbTeEoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PDwtqc3kp/u22NMvrxMHlwwH3jKiGzo35WegZ6P6xU=;
 b=bbly07t3NZOcbh5PfslgA9QP2vZLuToBKUv07SEJoWNbX8Ni/8WKxUubwfDhAhglWrfgUYwMvD2bbn5GuHBiEx2vzZpiNwxLGAub/uwGMpFOfudMf8uvLTzKss4aZ/IyU8IDvVVSrTyX7v2ZX600ZyJdcrZu/6J4/XFataHtIP56fVPrC8Xw6LjXs5UuthZIhQwj9Gv0RrmEUVyH8bDz1UnL2bbGrMRV4y4wnWzjTtaIu3dyJ4hsY8d2zJiYotcjGsJ+2NrFK/D0cFO5raYe5T2whdqZjeC0mFgN566kZEDHRYlu2ZYL4yGkOfa4uZXhCkgiZrziMWHbWaI5tiVBUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PDwtqc3kp/u22NMvrxMHlwwH3jKiGzo35WegZ6P6xU=;
 b=aXNjdNAPXAqNNiGUVyH6Lbi4JtOfBKvUHjYSGMaR1R7vdsJk7nF3AvwhkJkFa6I5Bwey2NL/FcVRm0ldQKJJqJ15i9u1oXmWDJBiXLbYWMM/NpjbgkOYwIePJXAv8rzz+7DQybwDSmq6oplnYMSjvDVqwUIrz3GY6Mv7tS/1uPQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH0PR11MB5506.namprd11.prod.outlook.com (2603:10b6:610:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 10:24:29 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 10:24:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Manikandan.M@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCHv1 3/8] ARM: dts: at91: sam9x60: Add flexcom definitions
Thread-Topic: [PATCHv1 3/8] ARM: dts: at91: sam9x60: Add flexcom definitions
Thread-Index: AQHY7RL1Led/a3SkiUKcAhOclc49kw==
Date:   Mon, 31 Oct 2022 10:24:29 +0000
Message-ID: <2f09ae34-6dff-3bb3-172d-a2a12741ce5e@microchip.com>
References: <20221031033653.43269-1-durai.manickamkr@microchip.com>
 <20221031033653.43269-4-durai.manickamkr@microchip.com>
In-Reply-To: <20221031033653.43269-4-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CH0PR11MB5506:EE_
x-ms-office365-filtering-correlation-id: 56ed442c-37a8-4da3-fe95-08dabb2a183a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CrfVMbXVLwgXFiY1BirquBjmEWKKJMRdn2eAFFTMlizDDnJ2b1avJUeBTdpW2ilVcQKSnWWi9FD1P2mq44JTWSyrbr5Qe1kh9PplFhJFlQqbBpAIWUHr52ysfFKrrHC03UZcG0xq95dZaq3eqD1MwnAJOSeZpJpJZtKuHmUSgIZsITJjTQFVOelmid3r34Gq3NNb3alVD4GIFmhw4ReGh04Hb+6/VuXhDQMO16HZuOqft/aqENA0lZHwPWU9ywSbRCpq5jE1kroRBpbO4JUj3QXLhAfFZXnPeNkUFE+pj7nXnlY7fd4zl8zHkZIKh2COOj4HVaatCJE3gCyOQddt1V3KeBFCRcAHLIVjY+t0oL+PLLPREJOcitWY/k5pGj7+pMHxrXl+jvA+WfRibgk4AkpCR9/Z0DJIHojoGRniaPwyBGSNyHFLu7MWzt15PEcqF43Szmr6Rbe9coH+M6Xd5Fc++jiGyVJ1VR8zyRlagrIJkXVJcZlPBK1MS9Tnz8afgX/DtcORwO4qJOyPCtAs/uOAutdoltkSOqu49fkXuSGfRQ1QyTY4HzI2WmwAjIbQv9zvM7vu+WDi+f4grJYegfK2lzohTv8+SidaCdoGFJ5Ux0FPYdvM60x43SQR6Cu4T2azxt9IaXJM6a8FirJRLTk+HcWU54bwjwPdLehC/eAdiV4eM5qxyycN+N+bohNZ5gbZkgpCqyamaazS9lEHcoOvkOIOb3DrI3tCCwTgeL+HGe7jVAacXj2pOMmsu7I5cVyNb//MDbICKuivJNL8aVJXpR90BBlcchDqTnpRRXPvs528QWD0MwCrlT0QZGiVPQ6WFq77c03s6L3axKBQ+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(921005)(38070700005)(31696002)(86362001)(36756003)(41300700001)(6512007)(26005)(53546011)(8676002)(6506007)(64756008)(2616005)(8936002)(5660300002)(66556008)(66476007)(66446008)(6486002)(186003)(71200400001)(478600001)(66946007)(6636002)(91956017)(76116006)(316002)(110136005)(122000001)(38100700002)(2906002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU5rZXdKd2dFTkZ3L05yNUlKTmlndUE4QTVpRGx1NnU3UVZueUduK1hJaytq?=
 =?utf-8?B?Nml2RFVOVU5LLytMb2pjUTZjNmdDWU5IajVCSC9sVHBDajBRampRRjBFUWtl?=
 =?utf-8?B?VHpxSDhmeVdIZlc4cU01Y08wL0VLWC9aZk42clNHL1RxT0U1Nkp3SlBPamd3?=
 =?utf-8?B?RG1iUVNEbzl6VFFPbWE5VDhmQXJUU2U1cjFqMk9CbEc4dzlRcEdFaG9YdzM4?=
 =?utf-8?B?cGpNUXVPL0U5dVlnN21QWm1XaFpGYUN3a2N3UTBDYTNoeXR0TUpSSnZKcmRt?=
 =?utf-8?B?WjlrQkpwU1RScjg1MDQyQXNqcjRyK1BSaFJtZDJGNlh6akNVZ2RBa3NUNXNQ?=
 =?utf-8?B?MEhMKytkV1NuQUlTUk53akVOQ2g0YUVYVXNuTnZONnB2L3pwQkEyc1BGWkxS?=
 =?utf-8?B?V1BYZkFLRlhPUEQxc2lkNisxUWN3eUFCSzM1UlVSdDFHdVRZYWlFNjR6NHB6?=
 =?utf-8?B?Yk5ZQmVyM0ovWDhUWC8yTURSbUtWaDV2c2ErS2pubFBSUzlhMTErMFNwQnY0?=
 =?utf-8?B?M0hZeDZRZUxWSnlyS2Z6RUp5NWN5ZWt5VU1QbGRDZVNlQnFGYWhvQzFuYjU2?=
 =?utf-8?B?WGpBekxsdmV0VU9wVHozSlhxcjZGbno5YkhQbFRFejBtbHBTZE9ZYlluQVBU?=
 =?utf-8?B?dWlDdDIrTExNYnB3d0xDY0IreCtWVmlWRDU3S3o5UHVZaWhhMFRTVE91QnBm?=
 =?utf-8?B?b21xNktXOEpMS3VJbnNWYWtadGNXdVMwK0M2cEhwV3EyLzdmM2NxbjZGOHpI?=
 =?utf-8?B?ZCs5K0dENDQxM3dreURtNXJtc1NlWXplQnlGcFhKUmRNaXBVQVpzTmZVZTRO?=
 =?utf-8?B?Z2ZUdGxTdHcxbStUUGZJQVJoaHNOMS9OWDB6Vk1lWnp4dE5rd2N1UmNmam9s?=
 =?utf-8?B?VnpNWmRUcmVxZzhtOUQ5R0trYWE1K28zNE1ESUxOY3I4YjNvM0UveHFQV2JH?=
 =?utf-8?B?OW5kTkZyZlZ3NEZnM0FZOFZIQi9qY0dvMWdpOEVuSnUwR2pqSU1IcjU3MTNj?=
 =?utf-8?B?MEdOSG1sT0t0eDFtYytueVFkNmlXWThCTlBqeHQvd0Y5RkorWnNZL1VZbXNz?=
 =?utf-8?B?ajRqSG85cmx6clZNME1KNnZrQWo5c1dhZHJYT0VrUnFIVWFaS1VBTVZiVXps?=
 =?utf-8?B?NnNscXE2ZmNKTTZyWU5FcDJXdnFvR2J1d29MQk0xeGZQcWg5MWg1SGhQMUhL?=
 =?utf-8?B?dDMvdnJGOGl0eDNBQVIyMEY1d3k5Z0xFU0x0TWlWVFlMWEJTdUFsaVZvUDQ2?=
 =?utf-8?B?OStPUXcwU0R5eW43d2l1R3lmWDczNVJGdXZJcHh5S2ZRazM0NEgxSEdOVENC?=
 =?utf-8?B?RWRnWkVid3VTaFpOVkdDcDlsZGQ5alhMSEZFQTN0SkxLUldCUk1IOVJ0UW5X?=
 =?utf-8?B?dUJrNUVIWTY5aHcyUXkrSDYzZ3d1d0R0Yll5L3o5YzVuNmlTajRYQm04Wmpx?=
 =?utf-8?B?bkhIak5SYkN0elU0eHptTnVSeW44QllsT0ZJNjZ3WFdScFhCY0lzNzZWNjRp?=
 =?utf-8?B?YjNqc3p4ZHAxNURSVThMbExaLytCeFVLS0MvbDFjRTVaRnM4NXlCNlZnUlc1?=
 =?utf-8?B?RW1jbTN0eE94ZXBaL0ZTL0ZkT2U1S20zcE0yblZqdXdjcUo0NXBidnhhcXNF?=
 =?utf-8?B?T3ZhUDlKWEM1SlllMnBwRVRnTVkzRUdBbXlPaUk2VHZEaEd0b3JYOXEwemQ4?=
 =?utf-8?B?d2FrSmpMZ2JBdjdWRnU1eDRxNTgrU1R2UTZJWHZWeVNLRW5RSjZGNkVpVGM1?=
 =?utf-8?B?WWdCb1hybHg5anRMQUdMMFRUZ1ZvdTdRZXFEZ3kvb2NWRWZPWWc2bEg3Zkt3?=
 =?utf-8?B?eWRnWldVcElidnhNN3pLSXNkL28xNjVqcXJSbzIzQ3JmcTdRZ1pKbFBhMzQ2?=
 =?utf-8?B?eDhJdWVpZ1lVcUpmVmRjNEhlU1FLei9xZzI2Y0FQUjZwTDBmN1g2akRMZHBu?=
 =?utf-8?B?VER1T0RpdnEvTEJJajFHVnVQVmo0SCtWUTE0OFpEVTBodVF5VXA3V3J1SlRh?=
 =?utf-8?B?S2dNOWcyTlNqR1QwRGJmSE0yaEFWc2ZCU0dTQjB2dzJlUmNjNXB2UlBselZC?=
 =?utf-8?B?YWovb3d6RUlyQUM5QVVzTkhqMWhudTZKejdXeWU2Z3lRT1VqZ1BHc2htQ3J3?=
 =?utf-8?B?T01JVlZ3ZjVtcjkwL2FEdjJtNEFJSU5ENVZaQXVGV2JhUUUwSm5iVGhVYWs5?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B369D988B571C64292CEFC8B9A9FE73D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ed442c-37a8-4da3-fe95-08dabb2a183a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 10:24:29.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /iwG9muURemqfVp19XCrnKKCBZSDxYSBNpiGgRpo1JFJdIHQsjCxhxsT4r6ZC+qPvV75t+CP0WUZQK8+TMnCt5TXPaGTfhRGmhuankn8IDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5506
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMTAuMjAyMiAwNTozNiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEFkZCB0aGUg
ZmxleGNvbSBkZWZpbml0aW9ucyB0byB0aGUgU29DIHNwZWNpZmMgRFRTSSBmaWxlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRHVyYWkgTWFuaWNrYW0gS1IgPGR1cmFpLm1hbmlja2Fta3JAbWljcm9j
aGlwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFyaSBQcmFzYXRoIDxIYXJpLlByYXNhdGhHRUBt
aWNyb2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FuZGFuIE0gPG1hbmlrYW5kYW4u
bUBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRz
aSB8IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA1MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4
NjAuZHRzaQ0KPiBpbmRleCBlZjA3ZDI4MWEzZGIuLmZkNGY1ZDQzZjdiYiAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL3NhbTl4NjAuZHRzaQ0KPiBAQCAtMTcwLDYgKzE3MCwxNiBAQCBmbHg0OiBmbGV4Y29tQGYw
MDAwMDAwIHsNCj4gIAkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gIAkJCQlyYW5nZXMgPSA8MHgw
IDB4ZjAwMDAwMDAgMHg4MDA+Ow0KPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4g
KwkJCQlzcGk0OiBzcGlANDAwIHsNCj4gKwkJCQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2Ft
OXg2MC1zcGkiLCAiYXRtZWwsYXQ5MXJtOTIwMC1zcGkiOw0KPiArCQkJCQlyZWcgPSA8MHg0MDAg
MHgyMDA+Ow0KPiArCQkJCQlpbnRlcnJ1cHRzID0gPDEzIElSUV9UWVBFX0xFVkVMX0hJR0ggNz47
DQo+ICsJCQkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgMTM+Ow0KPiArCQkJ
CQljbG9jay1uYW1lcyA9ICJzcGlfY2xrIjsNCj4gKwkJCQkJYXRtZWwsZmlmby1zaXplID0gPDE2
PjsNCj4gKwkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsNCj4g
IA0KPiAgCQkJZmx4NTogZmxleGNvbUBmMDAwNDAwMCB7DQo+IEBAIC0xODAsNiArMTkwLDI2IEBA
IGZseDU6IGZsZXhjb21AZjAwMDQwMDAgew0KPiAgCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAg
CQkJCXJhbmdlcyA9IDwweDAgMHhmMDAwNDAwMCAweDgwMD47DQo+ICAJCQkJc3RhdHVzID0gImRp
c2FibGVkIjsNCj4gKw0KPiArCQkJCXVhcnQ1OiBzZXJpYWxAMjAwIHsNCj4gKwkJCQkJY29tcGF0
aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC11c2FydCIsICJhdG1lbCxhdDkxc2FtOTI2MC11c2Fy
dCI7DQo+ICsJCQkJCXJlZyA9IDwweDIwMCAweDIwMD47DQo+ICsJCQkJCWludGVycnVwdHMgPSA8
MTQgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gKwkJCQkJZG1hcyA9IDwmZG1hMA0KPiArCQkJ
CQkJKEFUOTFfWERNQUNfRFRfTUVNX0lGKDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BF
Ul9JRigxKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMCkpPiwNCj4gKwkJCQkJ
CTwmZG1hMA0KPiArCQkJCQkJKEFUOTFfWERNQUNfRFRfTUVNX0lGKDApIHwNCj4gKwkJCQkJCSBB
VDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgx
MSkpPjsNCj4gKwkJCQkJZG1hLW5hbWVzID0gInR4IiwgInJ4IjsNCj4gKwkJCQkJY2xvY2tzID0g
PCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCAxND47DQo+ICsJCQkJCWNsb2NrLW5hbWVzID0gInVz
YXJ0IjsNCj4gKwkJCQkJYXRtZWwsdXNlLWRtYS1yeDsNCj4gKwkJCQkJYXRtZWwsdXNlLWRtYS10
eDsNCj4gKwkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsNCj4g
IA0KPiAgCQkJZG1hMDogZG1hLWNvbnRyb2xsZXJAZjAwMDgwMDAgew0KPiBAQCAtMzkwLDYgKzQy
MCwxNSBAQCBmbHg2OiBmbGV4Y29tQGY4MDEwMDAwIHsNCj4gIAkJCQkjc2l6ZS1jZWxscyA9IDwx
PjsNCj4gIAkJCQlyYW5nZXMgPSA8MHgwIDB4ZjgwMTAwMDAgMHg4MDA+Ow0KPiAgCQkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJCQlpMmM2OiBpMmNANjAwIHsNCj4gKwkJCQkJY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1pMmMiOw0KPiArCQkJCQlyZWcgPSA8MHg2MDAg
MHgyMDA+Ow0KPiArCQkJCQlpbnRlcnJ1cHRzID0gPDkgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsN
Cj4gKwkJCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA5PjsNCj4gKwkJCQkJ
YXRtZWwsZmlmby1zaXplID0gPDE2PjsNCj4gKwkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4g
KwkJCQl9Ow0KPiAgCQkJfTsNCj4gIA0KPiAgCQkJZmx4NzogZmxleGNvbUBmODAxNDAwMCB7DQo+
IEBAIC00MTYsMTAgKzQ1NSwxOSBAQCBmbHgwOiBmbGV4Y29tQGY4MDFjMDAwIHsNCj4gIAkJCQlj
b21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDItZmxleGNvbSI7DQo+ICAJCQkJcmVnID0gPDB4Zjgw
MWMwMDAgMHgyMDA+Ow0KPiAgCQkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwg
NT47DQo+IC0JCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+IC0JCQkJI3NpemUtY2VsbHMgPSA8
MT47DQoNCkFzIGZhciBhcyBJIGNhbiB0ZWxsIHlvdSB3aWxsIGdldCBjb21waWxhdGlvbiB3YXJu
aW5nIGlmIHJlbW92aW5nIHRoZXNlDQpwcm9wZXJ0aWVzLg0KDQo+ICAJCQkJcmFuZ2VzID0gPDB4
MCAweGY4MDFjMDAwIDB4ODAwPjsNCj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArDQo+
ICsJCQkJaTJjMDogaTJjQDYwMCB7DQo+ICsJCQkJCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNh
bTl4NjAtaTJjIjsNCj4gKwkJCQkJcmVnID0gPDB4NjAwIDB4MjAwPjsNCj4gKwkJCQkJaW50ZXJy
dXB0cyA9IDw1IElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+ICsJCQkJCSNhZGRyZXNzLWNlbGxz
ID0gPDE+Ow0KPiArCQkJCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKwkJCQkJY2xvY2tzID0gPCZw
bWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA1PjsNCj4gKwkJCQkJYXRtZWwsZmlmby1zaXplID0gPDE2
PjsNCj4gKwkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsNCj4g
IA0KPiAgCQkJZmx4MTogZmxleGNvbUBmODAyMDAwMCB7DQoNCg==
