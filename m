Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016E466BAE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjAPJvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjAPJu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:50:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2787C65D;
        Mon, 16 Jan 2023 01:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673862653; x=1705398653;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4e/lVllVgxZxekVMLc+WN70npMeD36bsF3y94MU5zDM=;
  b=KqoTeBZos7uXy9MFASmPg08fnzGxsNQlW8bGJqxIwK4jS47wE1OFNLhE
   zAXteDVa9b5inheLs6At3J6ybQY6yojMhUiRZYW6UgWZJ2S2ciWOnrtYa
   hXLWMBtsJqx9AutIuo0GPdnZJuYFdfTV1g+ey7BqgVB6PJLKfkAbYF1wo
   7yfA+JvSWlS1Y6UFfvCG4qVeFiIcOWjMzCG5R4X4na9z3gkmBssyzLxYL
   ltYwGz0PBxIbqK2QyA/sukSb4b4AFeP+GNikNVslTmVVfh+nASlORFoSU
   O6P4YQ4NMCnzMt6RjuRoQBOt50XODefe/l0+objk0o2J8hq7qTjcmZUiL
   A==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669100400"; 
   d="scan'208";a="192407782"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jan 2023 02:50:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 02:50:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 16 Jan 2023 02:50:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsVN7CB8jRFqp4qwBUjQjPXCohb9cMCg3vbc6nbOOwDJ+hxrXnCJMxyYtlaMLRyezxc1be5S/MIWdvJZwupbVu5wlzVNxgJE81u8Oq9a9WWKj0I4ZVjyoQj48BRqMjoqPjn+mFdM+w+yKcenvcRS57r1LmXNX0l/52L2V7Tx4+nwiRe8tQs1QPnsTKtX/1BnXI9BYzTZqtYy1Spln6Js3G7tuOKQNDKhDQabcRI/oRYebrwONCICpXaxCfmGZD4way+Lw0VKYplPCcfITN6EdtmbWoJVdUbjC1ZQUdY+lmoDKb9Wd437U9TVVmW6qHjTj19/cRaWL32nqVRiCKTurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4e/lVllVgxZxekVMLc+WN70npMeD36bsF3y94MU5zDM=;
 b=OM87jzL0vmiV9/zauwsVIqFO5z54159ySDZhXVklVf97p9lMUQHwpixSOPFwOmiWuhi/lBXAsZTLw7iDyAuZoL5U6FJt5vB7A8vgQBlyB24mEaP7sIblahC1G1lW3nwmr7CDjFRQPdiZ45S8M4rWTYmg3KOniVuNeupQ6cGY1ia2kdwqDk2dCZ6yDuS67hmAiOMNOC+FoPC6BbrBT6uUZAEuWFo4Sjn3yRo1p+/wAiqUfnespsW61wXroiuzqb9Cns+TVnlxtBe6xWe+vS2RXIrncK5nP6GCyYPKLkJC0fffoJ6YLwTXsVqEV+G1dhzCSHPi88ZUvrV8OZt1m4mb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e/lVllVgxZxekVMLc+WN70npMeD36bsF3y94MU5zDM=;
 b=Lrwy6fT1A0AVrSdvXD4gtsXyxIia1osPDVq3c5daw8VeW9IvHbhZIFjjxJHJufRBxFmhldtS1FeZAjxp/ifihGnsMvREelAE+mLkX9T6hPgzu+MjEcjc/vmzTgNMzSrW7WIUOxZXtAhYHSmY8lLjfAa0iBlh1XmGeGQYcTH4fAE=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 09:50:49 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 09:50:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Manikandan.M@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Dharma.B@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Balakrishnan.S@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <Jerry.Ray@microchip.com>
Subject: Re: [PATCH v4 2/8] ARM: dts: at91: sam9x60: move flexcom definitions
Thread-Topic: [PATCH v4 2/8] ARM: dts: at91: sam9x60: move flexcom definitions
Thread-Index: AQHZKZAC7sa4BunTbEOUQgtBv5/HsQ==
Date:   Mon, 16 Jan 2023 09:50:48 +0000
Message-ID: <596da70f-afe5-018d-6869-ef5a03794644@microchip.com>
References: <20230112110208.97946-1-durai.manickamkr@microchip.com>
 <20230112110208.97946-3-durai.manickamkr@microchip.com>
In-Reply-To: <20230112110208.97946-3-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BL1PR11MB5977:EE_
x-ms-office365-filtering-correlation-id: fee8a615-6243-4553-78c2-08daf7a72573
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMck5lqarSc1EV42hEiFUnbSJoVtBDKS1UCpFUx6F4zxgPtIBQQFD8+ZvsHwZrQuik9MwgDeNDZ2J4uR6volprflsojzQAuVNth5lqi/6pzFwY1+7dm2liSwX9Q4GTxGC5vGMC8D1q8MT+McWhcEou1LSMN9CSjMI8rLM01OaNkb0nqLFXQ+1T2hNI9fqfKhV0nR63WUv3a9WiYqThY2j+2LWOSc5yRzmJn/7WosNvizloaBg0M8+K7GDuewhj05ZJO+xX0A8bZEAn+PEE7F7NUWMAxrznAGsaY21DYNKeQ53iK/1HFRJ/iZsTDUplMlyCXecsBACTi/8uYIcxMzlX7fJw2O8eJ0WSL5QiQE4rWy469M460j7yHXyrYzlweN2CaWegAe9B9V3XoDZMPDVqKcMqtmLYSLkLbo6ej1UOaL4rHVUrowIKhLh62vaxnz4++Qf4zompnPiecMyZ19KIwton/JNOi8Sa9hSJxMdXz5nWT9MW9J6apLv04Iv5eXOXOFhJugzNR0CSd9n4BegRfySAn4iUA2zFpPU+dPqL1tTfVSZ8DwQCzQ83l0vTEaLhWjm5J+RjPr88GK6eaq1ziXp4Ha252vE0lUh+/6XjUwDOIsAyxJbMfwAb/d7AESZowm5KiDzNIGXuh5uYrqn3nFiJOPgDFT+OsAYEyD3fTGw9+13lVHa76WuhJ+otr/aXkhCSHeB75EYa5wDCK/os4DL9K31YARFT3GgX8N9kc2I8VQGEQMvFJlRQdsvuZlzhnHDFLAFhnDBBScjEcPeB+HLadtlAdWfmDEaSe1lIOgnnvomxmvgK2EFtQJ/2zv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199015)(83380400001)(38100700002)(122000001)(41300700001)(38070700005)(921005)(86362001)(31696002)(8936002)(5660300002)(7416002)(2906002)(8676002)(66946007)(66446008)(66476007)(64756008)(76116006)(66556008)(478600001)(91956017)(26005)(186003)(6506007)(53546011)(2616005)(6512007)(110136005)(6636002)(316002)(71200400001)(6486002)(966005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlVxVFVRMERYelVZMjZUOFpxbllHUXQ5QlBUS2QzaTBZeU8xMzc3K1JlMk5a?=
 =?utf-8?B?NnRtTm95RGhsUkpmT2Vldk15ajdWY1ArSUd0eWhqamxVTGdsYXkrWUJjM3J6?=
 =?utf-8?B?clg4dkVJcTI5NWI1eXlmQnRrb0NRSkZ0b253YWtUaUVGSlZwRGJjSno2Yncy?=
 =?utf-8?B?cnhUai9UTkJ3aVRLd0svVUU1Y1FPMXMwRFFWWGdKRDdTRTA0cXFGTndDRzJr?=
 =?utf-8?B?TlMwUElWZlNGeGdlOUFZN0ZrQmhrRzFISnpyWFFxVlByODU0M0NFYzh6LzFU?=
 =?utf-8?B?bC9MNDkyQURIT3dBRXpLWGNnYVpjWFFTamlMeEJBYUtYNmJETUVRZWhHTW9O?=
 =?utf-8?B?ZS9FOXA0TytUbDV0WEJKK25zY1pXeXFTK0F3aFNzWUxZOGVwZ2xGOXlUMC80?=
 =?utf-8?B?Ukp1NHpyd2VyUEFXSXBkS29pRXovRWVWY05TT0ROMnZ2SmFzVzBRZDhrN2R1?=
 =?utf-8?B?dGxvOCtlUVc0dGZJamc2bWZpV0k5LzAyOERIbndVd0twelg3Y0JyQWtQVXZV?=
 =?utf-8?B?WkdZSlhoWjZINXBnazJoMlgyNm1BWEFVbTczNVNOc25TMWduN04yaWg1ZUdh?=
 =?utf-8?B?U01lOGJudFVVYmN4c3QzZ3dnODRNcG01THhLY0g5Zm1pNnlsRFF3R0tZTXoy?=
 =?utf-8?B?YUdGcHR0dGtWVlV6dHBDNTB0YkpNUnV6SzZBMDJlbmdjaGVNT042TWcwQUVF?=
 =?utf-8?B?TkVxUFUzeXBiN1FhZFJiSm5VeXhUTEFDNGw3NlBHTHFqdGFDUHVWcjZObHJu?=
 =?utf-8?B?RFZWRTdraVBMV21ESENVdExIdUpjakZ1OG54MVVJcStNN0xRVldxSmplQ3RJ?=
 =?utf-8?B?Q1J5czVxbk41OVovRThvbS9wdjVpV3hvL0xycTYyQVlaWm9ZM1lOUUVmNUZn?=
 =?utf-8?B?YUsvL2FTTGJMeFdNajZrTG83aUF2NlFwOGdmc2VaQm1tOEFESjQxYU5pOHB6?=
 =?utf-8?B?TjdpV1RlaUtWSUtoMUMwakpoS05ZZUErVnU4djVuMDRjN1dSMmhCaUY0QklV?=
 =?utf-8?B?NFlaVEgwSVg1RTZiZ1RjQnBiQTlzRjZmMy9yMVNUdWlTeVQ4ZS8xZUxmUzFj?=
 =?utf-8?B?Z1Y2UkdUU3pZcFkwei9oOXQ1YTBjQ0dPalQ2bFhHTXdrSzlMVWZ5M1pMTE5t?=
 =?utf-8?B?dVRYYjZRVk9qVy9aQWxzaVJDdGVNQnhZdC9iREI3YVJGNWtoSVVSVUxzWDRG?=
 =?utf-8?B?YmlqK2o4U1RzajZORmJNM2l4M2ZKVWVhWk1LR0N3czNTMWtObXNycHRrSFBp?=
 =?utf-8?B?RWhtT01CdnRud0ZUajhiNDBaZEV2UGdYWXBKWCtJZFNNSUJycm1HNnpzYit4?=
 =?utf-8?B?Rzc1d3pTVXZpaFZUdGtidlJkck5mQktqZm54U0poUXAwMUt0d09VV3JUeTVQ?=
 =?utf-8?B?RWpTZk1hemNzR2UweWlhTjhvOUJ3L0hkaVdqNkNWMUVTMm1GcDQzL1dHcmRI?=
 =?utf-8?B?V3pjMzBOZkFPalVYZ3Z1Ymo1YmFvV1VHTTVtZ1dKU0J2b3o2b3dyWFBaTUJ1?=
 =?utf-8?B?L0VPRzY4U1ZzSjdla3dZeTRUdUF2WmlpdXBQVTV1eTJROC9EZStxUEo1TkNp?=
 =?utf-8?B?ZXlieTB4THJNMHpjTjcxRjNJbTF5cDcyaytxb3BmOStrQVAzL3h2c0p0bFM0?=
 =?utf-8?B?eld1ckVHdWRIOHFpVlY5VWRwKzFNd2pScVpzc3g1WUVSK0ljUkgydWlWaXJX?=
 =?utf-8?B?bzhmR2JjTStrQm5TY294NDlWdDhOVnhvUnBZWTNSMXdLWCtBYU9QanpCNHVU?=
 =?utf-8?B?Y2N1REo1Y1VraWtZWGxLemd2QWp6T2xJWEtsUjBySmk4SkFBWE1HMTg5Wlo3?=
 =?utf-8?B?M2dPcVA0dTh1VDEzTUZZNnh5S1E0bCs2ZWFISzh3bWs4UEtWQlFwU2h1bHU2?=
 =?utf-8?B?QTRhRElUaVlMWUhSRGcreEZCQThTeS9JeU0rcC8wR1VQOXphbHAwbTVtaXhG?=
 =?utf-8?B?YUNhT3RBaUg1MDBqY2JoWm1MbjVlMU1qNzVQS2pydUNsUGRWN1k4SmxHYXdE?=
 =?utf-8?B?bE01S0xkN2VuVnVJcTY1QW42NUlvS0E5MnUyV1FtVmJZN3RvcEJmZStvYXZZ?=
 =?utf-8?B?eUdpeWxLRXVYUm1Nd0NLYzlvYlZ3VzJqczgyTmtPbHVQZm50RmhleUh2V1p3?=
 =?utf-8?B?WmNEeUtaaU4wdzFPWk1yVHlMVE0yR0dsc3lWcEdOWEdtcDNZZkJZZis2TzND?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D09873B48F03584D8114B697146DAE41@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee8a615-6243-4553-78c2-08daf7a72573
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 09:50:48.5957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QInK7OZXNCJNDpl7THYfR9T5iugBVMzWQRR9H8OWncjlUtnDJTelqzu4AWuT4cWoisWAJy+f4zlsAXHCTawKLoE8grnyl5GPw5ugPzJyAPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDEuMjAyMyAxMzowMiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IE1vdmUgdGhl
IGZsZXhjb20gZGVmaW5pdGlvbnMgZnJvbSBib2FyZCBzcGVjaWZpYyBEVFMgZmlsZQ0KPiB0byB0
aGUgU29DIHNwZWNpZmljIERUU0kgZmlsZSBmb3Igc2FtOXg2MGVrLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4gPG1hbmlrYW5kYW4ubUBtaWNyb2NoaXAuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBIYXJpIFByYXNhdGggR3VqdWxhbiBFbGFuZ28gPEhhcmkuUHJh
c2F0aEdFQG1pY3JvY2hpcC5jb20+DQo+IFtkdXJhaS5tYW5pY2thbWtyQG1pY3JvY2hpcC5jb206
IExvZ2ljYWwgc3BsaXQtdXAgb2YgdGhpcyBwYXRjaF0NCj4gU2lnbmVkLW9mZi1ieTogRHVyYWkg
TWFuaWNrYW0gS1IgPGR1cmFpLm1hbmlja2Fta3JAbWljcm9jaGlwLmNvbT4NCg0KVGhlIEZyb206
IGZpZWxkIGlzIGZyb20geW91IGFuZCB0aGUgMXN0IFNvQiBpcyBNYW5pa2FuZGFuLiBGcm9tIGFu
ZCAxc3QgU29CDQpzaG91bGQgbWF0Y2guIENhbiB5b3UgY2hlY2sgYW5kIHJlc3VibWl0LiBTZWUg
dGhpcyBmb3IgbW9yZSBkZXRhaWxzOg0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92
Ni4xL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjZGV2ZWxvcGVyLXMtY2VydGlmaWNh
dGUtb2Ytb3JpZ2luLTEtMQ0KDQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05
eDYwZWsuZHRzIHwgMzMgKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMv
c2FtOXg2MC5kdHNpICAgICAgIHwgNDkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMgYi9hcmNo
L2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gaW5kZXggY2Y1ZDc4NjUzMWYyLi40
ZmY4NDYzM2RkNDMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtOXg2
MGVrLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4g
QEAgLTIwNywxNSArMjA3LDEwIEBAICZmbHgwIHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICAN
Cj4gIAlpMmMwOiBpMmNANjAwIHsNCj4gLQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2
MC1pMmMiOw0KPiAtCQlyZWcgPSA8MHg2MDAgMHgyMDA+Ow0KPiAtCQlpbnRlcnJ1cHRzID0gPDUg
SVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gIAkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAJ
CSNzaXplLWNlbGxzID0gPDA+Ow0KPiAtCQljbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhF
UkFMIDU+Ow0KPiAgCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgCQlwaW5jdHJsLTAg
PSA8JnBpbmN0cmxfZmx4MF9kZWZhdWx0PjsNCj4gLQkJYXRtZWwsZmlmby1zaXplID0gPDE2PjsN
Cj4gIAkJaTJjLWFuYWxvZy1maWx0ZXI7DQo+ICAJCWkyYy1kaWdpdGFsLWZpbHRlcjsNCj4gIAkJ
aTJjLWRpZ2l0YWwtZmlsdGVyLXdpZHRoLW5zID0gPDM1PjsNCj4gQEAgLTIzNSwxNCArMjMwLDgg
QEAgJmZseDQgew0KPiAgCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICANCj4gIAlzcGk0OiBzcGlA
NDAwIHsNCj4gLQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1zcGkiLCAiYXRtZWws
YXQ5MXJtOTIwMC1zcGkiOw0KPiAtCQlyZWcgPSA8MHg0MDAgMHgyMDA+Ow0KPiAtCQlpbnRlcnJ1
cHRzID0gPDEzIElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+IC0JCWNsb2NrcyA9IDwmcG1jIFBN
Q19UWVBFX1BFUklQSEVSQUwgMTM+Ow0KPiAtCQljbG9jay1uYW1lcyA9ICJzcGlfY2xrIjsNCj4g
IAkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gIAkJcGluY3RybC0wID0gPCZwaW5jdHJs
X2ZseDRfZGVmYXVsdD47DQo+IC0JCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+ICAJCSNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KPiAgCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gIAkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gQEAgLTI1NCwyMyArMjQzLDggQEAgJmZseDUgew0KPiAgCXN0YXR1cyA9
ICJva2F5IjsNCj4gIA0KPiAgCXVhcnQ1OiBzZXJpYWxAMjAwIHsNCj4gLQkJY29tcGF0aWJsZSA9
ICJtaWNyb2NoaXAsc2FtOXg2MC1kYmd1IiwgIm1pY3JvY2hpcCxzYW05eDYwLXVzYXJ0IiwgImF0
bWVsLGF0OTFzYW05MjYwLWRiZ3UiLCAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiOw0KDQpUaGUg
Y29tcGF0aWJsZSBsaXN0IGhlcmUgaXMgZGlmZmVyZW50IGZyb20gdGhlIG9uZSB5b3UgaW5zZXJ0
ZWQgaW4gZHRzaS4gSXMNCnRoZXJlIGEgcmVhc29uPyBJcyB0aGVyZSBhIHJlYXNvbiBmb3IgdGhp
cz8gSWYgc28sIGNvdWxkIHlvdSBwbGVhc2Ugc3BlY2lmeQ0KaXQgaW4gY29tbWl0IGRlc2NyaXB0
aW9uLg0KDQo+IC0JCXJlZyA9IDwweDIwMCAweDIwMD47DQo+IC0JCWF0bWVsLHVzYXJ0LW1vZGUg
PSA8QVQ5MV9VU0FSVF9NT0RFX1NFUklBTD47DQo+IC0JCWludGVycnVwdHMgPSA8MTQgSVJRX1RZ
UEVfTEVWRUxfSElHSCA3PjsNCj4gLQkJZG1hcyA9IDwmZG1hMA0KPiAtCQkJKEFUOTFfWERNQUNf
RFRfTUVNX0lGKDApIHwgQVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPiAtCQkJIEFUOTFfWERN
QUNfRFRfUEVSSUQoMTApKT4sDQo+IC0JCSAgICAgICA8JmRtYTANCj4gLQkJCShBVDkxX1hETUFD
X0RUX01FTV9JRigwKSB8IEFUOTFfWERNQUNfRFRfUEVSX0lGKDEpIHwNCj4gLQkJCSBBVDkxX1hE
TUFDX0RUX1BFUklEKDExKSk+Ow0KPiAtCQlkbWEtbmFtZXMgPSAidHgiLCAicngiOw0KPiAtCQlj
bG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDE0PjsNCj4gLQkJY2xvY2stbmFtZXMg
PSAidXNhcnQiOw0KPiAtCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmx4NV9kZWZhdWx0PjsNCj4g
IAkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gLQkJYXRtZWwsdXNlLWRtYS1yeDsNCj4g
LQkJYXRtZWwsdXNlLWRtYS10eDsNCj4gKwkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZseDVfZGVm
YXVsdD47DQo+ICAJCXN0YXR1cyA9ICJva2F5IjsNCj4gIAl9Ow0KPiAgfTsNCj4gQEAgLTI4MCwx
NSArMjU0LDEwIEBAICZmbHg2IHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICANCj4gIAlpMmM2
OiBpMmNANjAwIHsNCj4gLQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1pMmMiOw0K
PiAtCQlyZWcgPSA8MHg2MDAgMHgyMDA+Ow0KPiAtCQlpbnRlcnJ1cHRzID0gPDkgSVJRX1RZUEVf
TEVWRUxfSElHSCA3PjsNCj4gIAkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAJCSNzaXplLWNl
bGxzID0gPDA+Ow0KPiAtCQljbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDk+Ow0K
PiAgCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgCQlwaW5jdHJsLTAgPSA8JnBpbmN0
cmxfZmx4Nl9kZWZhdWx0PjsNCj4gLQkJYXRtZWwsZmlmby1zaXplID0gPDE2PjsNCj4gIAkJaTJj
LWFuYWxvZy1maWx0ZXI7DQo+ICAJCWkyYy1kaWdpdGFsLWZpbHRlcjsNCj4gIAkJaTJjLWRpZ2l0
YWwtZmlsdGVyLXdpZHRoLW5zID0gPDM1PjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL3NhbTl4NjAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaQ0KPiBpbmRl
eCA4ZjU0NzdlMzA3ZGQuLjc0YzkwMTU4ODAxYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9v
dC9kdHMvc2FtOXg2MC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRz
aQ0KPiBAQCAtMTcwLDYgKzE3MCwxNiBAQCBmbHg0OiBmbGV4Y29tQGYwMDAwMDAwIHsNCj4gIAkJ
CQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gIAkJCQlyYW5nZXMgPSA8MHgwIDB4ZjAwMDAwMDAgMHg4
MDA+Ow0KPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJCQlzcGk0OiBzcGlA
NDAwIHsNCj4gKwkJCQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1zcGkiLCAiYXRt
ZWwsYXQ5MXJtOTIwMC1zcGkiOw0KPiArCQkJCQlyZWcgPSA8MHg0MDAgMHgyMDA+Ow0KPiArCQkJ
CQlpbnRlcnJ1cHRzID0gPDEzIElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+ICsJCQkJCWNsb2Nr
cyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgMTM+Ow0KPiArCQkJCQljbG9jay1uYW1lcyA9
ICJzcGlfY2xrIjsNCj4gKwkJCQkJYXRtZWwsZmlmby1zaXplID0gPDE2PjsNCj4gKwkJCQkJc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsNCj4gIA0KPiAgCQkJZmx4NTog
ZmxleGNvbUBmMDAwNDAwMCB7DQo+IEBAIC0xODAsNiArMTkwLDI3IEBAIGZseDU6IGZsZXhjb21A
ZjAwMDQwMDAgew0KPiAgCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJCXJhbmdlcyA9IDww
eDAgMHhmMDAwNDAwMCAweDgwMD47DQo+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKw0K
PiArCQkJCXVhcnQ1OiBzZXJpYWxAMjAwIHsNCj4gKwkJCQkJY29tcGF0aWJsZSA9ICJtaWNyb2No
aXAsc2FtOXg2MC11c2FydCIsICJhdG1lbCxhdDkxc2FtOTI2MC11c2FydCI7DQo+ICsJCQkJCXJl
ZyA9IDwweDIwMCAweDIwMD47DQo+ICsJCQkJCWF0bWVsLHVzYXJ0LW1vZGUgPSA8QVQ5MV9VU0FS
VF9NT0RFX1NFUklBTD47DQo+ICsJCQkJCWludGVycnVwdHMgPSA8MTQgSVJRX1RZUEVfTEVWRUxf
SElHSCA3PjsNCj4gKwkJCQkJZG1hcyA9IDwmZG1hMA0KPiArCQkJCQkJKEFUOTFfWERNQUNfRFRf
TUVNX0lGKDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+ICsJCQkJ
CQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMCkpPiwNCj4gKwkJCQkJCTwmZG1hMA0KPiArCQkJCQkJ
KEFUOTFfWERNQUNfRFRfTUVNX0lGKDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9J
RigxKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMSkpPjsNCj4gKwkJCQkJZG1h
LW5hbWVzID0gInR4IiwgInJ4IjsNCj4gKwkJCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVS
SVBIRVJBTCAxND47DQo+ICsJCQkJCWNsb2NrLW5hbWVzID0gInVzYXJ0IjsNCj4gKwkJCQkJYXRt
ZWwsdXNlLWRtYS1yeDsNCj4gKwkJCQkJYXRtZWwsdXNlLWRtYS10eDsNCj4gKwkJCQkJc3RhdHVz
ID0gImRpc2FibGVkIjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsNCj4gIA0KPiAgCQkJZG1hMDogZG1h
LWNvbnRyb2xsZXJAZjAwMDgwMDAgew0KPiBAQCAtMzc5LDYgKzQxMCwxNSBAQCBmbHg2OiBmbGV4
Y29tQGY4MDEwMDAwIHsNCj4gIAkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gIAkJCQlyYW5nZXMg
PSA8MHgwIDB4ZjgwMTAwMDAgMHg4MDA+Ow0KPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
ICsNCj4gKwkJCQlpMmM2OiBpMmNANjAwIHsNCj4gKwkJCQkJY29tcGF0aWJsZSA9ICJtaWNyb2No
aXAsc2FtOXg2MC1pMmMiOw0KPiArCQkJCQlyZWcgPSA8MHg2MDAgMHgyMDA+Ow0KPiArCQkJCQlp
bnRlcnJ1cHRzID0gPDkgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gKwkJCQkJY2xvY2tzID0g
PCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA5PjsNCj4gKwkJCQkJYXRtZWwsZmlmby1zaXplID0g
PDE2PjsNCj4gKwkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsN
Cj4gIA0KPiAgCQkJZmx4NzogZmxleGNvbUBmODAxNDAwMCB7DQo+IEBAIC00MDksNiArNDQ5LDE1
IEBAIGZseDA6IGZsZXhjb21AZjgwMWMwMDAgew0KPiAgCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0K
PiAgCQkJCXJhbmdlcyA9IDwweDAgMHhmODAxYzAwMCAweDgwMD47DQo+ICAJCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gKw0KPiArCQkJCWkyYzA6IGkyY0A2MDAgew0KPiArCQkJCQljb21wYXRp
YmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLWkyYyI7DQo+ICsJCQkJCXJlZyA9IDwweDYwMCAweDIw
MD47DQo+ICsJCQkJCWludGVycnVwdHMgPSA8NSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiAr
CQkJCQljbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDU+Ow0KPiArCQkJCQlhdG1l
bCxmaWZvLXNpemUgPSA8MTY+Ow0KPiArCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArCQkJ
CX07DQo+ICAJCQl9Ow0KPiAgDQo+ICAJCQlmbHgxOiBmbGV4Y29tQGY4MDIwMDAwIHsNCg0K
