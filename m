Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5338971498A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjE2Mej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjE2Meh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:34:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10242C7;
        Mon, 29 May 2023 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685363673; x=1716899673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qQz/LQjsk698BfLhb5993NtU0SIkXX3SMUXSfC9AWCk=;
  b=gmD9ugwwUMjDCONzJCt6bVbNQ96qtmMCTYHPOgwsaZpNWhOszolemzMq
   /VFDbOuHRPtWB0vqFxf6F3tF/NMnh7NouKCbjMC+DPnItb6+aMFq1fGXO
   Ul+PzFQ5AuMFL1o/dh9ZNkRqLH5K3ti+DdzHXYWR6+IPvUZ/2pphwpgdv
   aqy8tDU2cqY4uA5LMNCUPzHB4K7fS43RtGHevat8YsCVIFM86xI1dvVwA
   exJ6wROjfAmEIcygJ2AE2Rd/7TaQmxCP8HmG8KSNyRr9j8eyWZCdaDu3/
   vMOfSl1IsE6yoQr2MAUJRPodsUenQzb2XQr9IYta16+WDvd++ywCSXSu1
   g==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="154426924"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 05:34:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 05:34:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 29 May 2023 05:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/sxzAXb1H0G4eBSphtWwDnzrq/wC+ztPxsnniDTD83+WPkttGBOEAE3NETXDy+TarzbiMz1gZLMYISc/XhvexKIlO7uFkMtzoCU2x0kQbHR3RtLZKj7OC5skBaCEtE1r0TXGmFWUHrIhRaZegSje4KqwwZKLYsq+7wFiBiYvoZvm212vLb6oOHZCD7kIkNzN/Y9/TtyPyyhiIr4hPlQrdox6KxqYd8dqwkAAxs27Ia/vAnJUq71a7AZp+Vx2bOs6bg8Xas29aimY/dOClUISNsuBHIW3ab90uKdnTBvOmq/m1iZwiY3IWHGG9GUYP9SVINKf5Pm7uFbomKOGorgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQz/LQjsk698BfLhb5993NtU0SIkXX3SMUXSfC9AWCk=;
 b=YMLVcIKXbPEs/Bw4Xg8Vay5UvMfTw6s9HtWrX64FoVc1vvM9Xuc5bijhQjD2oGSDEi0Zg/y1Yyc/jSeAvObZIh07b3MbCQ83r49+QxsgQR67BKoIltTMxEsAhJUx8o6DUM4D7oVAiAVrHpX5IDtmBHDUV2TEkxwfr+gXbbqBY0JgQrbr51z9qNHU3WimoH0FNupAE3gHqcKlIqf9VaOnciEkNRm9/vIX9Q0HqIlvuZlCyCx0ZAWeTUlzfyj1PW9HZixiSWXCViiMpKM/8OAlOWnCNxZRsYExQ7Sg16EGDsVslOnHTROYExuBL17ClU+E+JtbKi2ChIVzwZZdZXaGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQz/LQjsk698BfLhb5993NtU0SIkXX3SMUXSfC9AWCk=;
 b=UnncO+NBAX1OAIMALMaHybyiJgABfMZZ3C/ooG1hCr523gXHClrKt1JLZu8uNk4GFSoc9PqQrNeAC6aSxncF7ElNHIRLh+FSeLnaoRLjxzMQ8QMvNXh67+zdelppK75g8aYi/wgxsYYAcnKpnyDXz/nFbCld/2nThKRI83HQlUA=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by CH0PR11MB5524.namprd11.prod.outlook.com (2603:10b6:610:d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 12:34:27 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 12:34:27 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: timer: atmel,at91rm9200-st: convert
 to yaml
Thread-Topic: [PATCH v2 4/4] dt-bindings: timer: atmel,at91rm9200-st: convert
 to yaml
Thread-Index: AQHZkino0ZJOzwIB00m3eBZU2PYJWQ==
Date:   Mon, 29 May 2023 12:34:26 +0000
Message-ID: <3f85d3c9-05c1-1d80-94ce-84b1581f3404@microchip.com>
References: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
 <20230529062604.1498052-5-claudiu.beznea@microchip.com>
 <20230529-frivolous-refinery-43d91975fff9@wendy>
In-Reply-To: <20230529-frivolous-refinery-43d91975fff9@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|CH0PR11MB5524:EE_
x-ms-office365-filtering-correlation-id: fba40c89-1e75-4466-969a-08db60410a91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jVh93TQVU7zGlUTdJLNVCPbd9wwcQiozEMymVmHr8BcUYavgq1boxyJzQSYSDN7Ldv0wDdWfZP7zzGVsEN8lSkmsAQYZ+3qnZqDsRIyG6X+40gjHtoSvm060QJfJAP6AVw4kiy2cit+OW7MEomyLnY7HzdKbPZyOWuKjta2lcUFcFXJo/J1tiX3ND809+wX89Y40Fa5+6rpMZBImLV+FRyqSX1U5iIp4cs/kJaO2vi8li7vNw4cFfinRX48gMfkLvQS0zDaj/XDQ+kU8aULJIFKVi0vtJ+/doKT0YmlXv8BXHp+S3bJThHv+IGaTekCfcchTVvwwdGxBDkf/VvTSVikl+um5xOQ/QxvKmXGdgeVa7W7vLErISdgWKEcKPaVsAjrSAq1Ufwf5Js9bNs/qb+t1Js9+LBgx4Rz9NjcFhvtYeVEoP3CXJDthJuWE7PznFUmO3gq7fowgoK9VhFWqLBumzc+k0pjTuy8m67ETIkcIDiRfJKiLmNKHdYgHooQ6Wt5h9dsQfJTeXT25yB60Mlcnus/+gcUMUHsxvRWs8vLOZPwkSvjLI0hQ1moCtOaZH1PaxO8DY9m04PUJrpB9FaySHTER0ac9ob7AOTF3LPE9nfp63MUrP0zzyD0u1edHYXC3aX5GjORsugvkYX+u+hOqzFis9DS8VMRWAEgZDLNTDySwPI4fs+OkpC85MA0Zl5XiNIyJvgCkX6L8aIQJLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(83380400001)(71200400001)(5660300002)(316002)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(91956017)(7416002)(4326008)(6636002)(31696002)(36756003)(966005)(6862004)(122000001)(8676002)(8936002)(41300700001)(38100700002)(6486002)(86362001)(54906003)(53546011)(2906002)(2616005)(6506007)(6512007)(38070700005)(37006003)(186003)(31686004)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzBFenRyY3V1dVFPS2ZRanhKTVZCL01uY0NJSDBEWitvdHlxVFlleXkrQlBi?=
 =?utf-8?B?VHNWL3Z6aFlCVGwxRGVBdWNQdVAxZXZVVFplaTY1UzZWY01SM2Rmd2xaVVc2?=
 =?utf-8?B?OHVQSFk5L0hFMmEzeEJFaTR4ZEVDN3RXZ04wNnphK2ZmR2ZadnZ5KzhTTTkx?=
 =?utf-8?B?Wlp6cWRyN2tWTTA0WER3WklUV3ZjendnMExOYkhmU0IvbTU1S0VOdzdQOTNp?=
 =?utf-8?B?bEp6VHRna0sxOVd5RmtwS3IyazNabjVhOTFmeXc5ZzBZZG9OTlhvT1l0aEw0?=
 =?utf-8?B?Qml0RUF2d00wWmZCVE1lbnNmYmNGV2xiem5NS3lDeWhuN3RhUm8vcVVpOGd1?=
 =?utf-8?B?VGpZN2p4eE52VjhNMlphWmIrS0ZNeGx4SFpzVElYMkI2bmwxRW12L08zRllP?=
 =?utf-8?B?clVoSE5PaHNCUkxDbUNVNjI1ZmJDU2xpa3ZzQ0ZXZm1wT3BzTXBjckQ5aVll?=
 =?utf-8?B?dUdpTlRTOU1zVzNqV3lsSWNzV09ES0QyQ1k0Q1NwRTNUbVc0dzcvTXRJMnpW?=
 =?utf-8?B?NUFlWHJIN2MzeGdNK2xMa3lvd0pxSk9lejRwMVNieGRVaTRjQkM3c3Z3Y1Nh?=
 =?utf-8?B?dS9iMVFNT0pieUhkRGFuSVFaNHpSdndKeGZDNUhzYiszSkhjTzlhV2JtbUpq?=
 =?utf-8?B?anlPMHluRTBVQk4wUk84bThDQWdsb3ErT1lvOUVwUkd0Y2d6cWpCZ3ZiNkY5?=
 =?utf-8?B?U1d5aDBuSmVzUnpvM3ZTbHd1VUxSbkYzMEJOTUx1V1BpU0V4RjYxeFkyaU1Q?=
 =?utf-8?B?Z0t5ZGo2cWpaS0pLZU1hbkRpUHdacnlsTE05REhTQkpwTmE4ZDR3U25OdGdz?=
 =?utf-8?B?YTBVWGhDTFNpVXFxTmNoY3dJK29wKzVNZWZGZkxiOWgwRjBMQ1RxNkMzcHhJ?=
 =?utf-8?B?UWZiYS9jK1F5NWpNZzVYV1ZCdzBPV2dTd0cwWVMwcWNpVkN6RDJkWUdUTzhk?=
 =?utf-8?B?Q3RvcWhVcmJZRUVCMW9ROTFFM1RnWXlWcGVWUEdvS1pPNlBTUmJMbUg1SEE5?=
 =?utf-8?B?TXhFZXI2enhnd1lWS0pwbVl6VVA4TUw2QWNQTFlEOUZ6QzBSTFVha3ZSMHZj?=
 =?utf-8?B?aFhlekx3NHc3RnVjQURaNWpnc21TSmhCTzd3aytuZm9PVjg3Q2pQdkhxOXEy?=
 =?utf-8?B?V0VENTlMR3pBU3ZBYzgzT0N6TDd2b1dSbjZEQzlnMkdCZFFSK3pNSm5RSUxk?=
 =?utf-8?B?NlN4SEM5ZW8yL25vTThBd2wyWWQ2d2lQT3V3dEN1eFhyYTZhRFZRNHRrcmdt?=
 =?utf-8?B?d09IR0Y4YytLaUVDTEJ1WmhiUGJWeGdyQTdDODdYRXpNZnNxNVJHbUtmUkRh?=
 =?utf-8?B?d1ZrQmVZTXkwRnZEcHBIMmxoRHBTOU8xM2RXNmNZSXNabWZocTU4NjRNQlR1?=
 =?utf-8?B?eTl0ZEUwZUpaRUwvdnh5ZVRxeHB0MjFXZDlnMWM2K1hpd29mSDNnemJPYXdE?=
 =?utf-8?B?UUYwei9uczhDeDVJd2xaRXBCUnh3QkdKWTlGeUlOTGp6aXNyVlpobG0yMldQ?=
 =?utf-8?B?OTVZbGprUE0rZ3N6T0dISTRzTmlsSGJpVGpGSzUwcldkcTBZRnJJMFBIL3pC?=
 =?utf-8?B?R2FodTJ6TWdQRG9qNk43UUU1VEZIWVVPN0lZZFJYUlE1MGtFY0ZwNGsvZ25v?=
 =?utf-8?B?YnNScWJEUjRaY1FPbnBGN00vUGlrdHdndyt0WnBrK0R5UFU4M3FuLzJBdy90?=
 =?utf-8?B?Q2xjUm5nSVVON0RCRzNDYlhaSmdzQmNKZFZUc1ZJZVlwbGQ5dG5ETXcwRDdm?=
 =?utf-8?B?Z2FMK21Ra0JHUFFuR2pXdHpyWm52cFIxbHc0dFB4c09tQktTMEVQeE83YnUw?=
 =?utf-8?B?NXU5YUg2Ykp2VWtURE5WWlY1ckovbExycnJkRmRQbXVOWkhscXR6TGZpZyti?=
 =?utf-8?B?dTNCdHR6N2JjdVp4WGxGMWtFYzBPejAyb25mYlh5bmpTRGxobGM5S0YxbEgr?=
 =?utf-8?B?cXlNQWh1ckd1NHU4Zk1HZkNKYlZQVnZ0U2ZIVFZaRWVTLy9sd3lEVmdSbzVr?=
 =?utf-8?B?dVNlOCtmZkhJSUhCTUcyMlJweC9EcDlxeTdkSnNnUEgxNTkrYUQ4SFgzZFdr?=
 =?utf-8?B?ZVFnTHBaaEEwUUI0a3NYdHBnbUgvUUZQTGRkTHpVQXVIbUxqajVDL3JJR1Jk?=
 =?utf-8?B?UkZHQURxcXRqWGpMTk13YzRSN3dKWVhDV1c3cDNzOFAzS0FsK1lpdGFVK2Zj?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <937BD9C8AAA22848BA48A2A7E0BF2AEA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba40c89-1e75-4466-969a-08db60410a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 12:34:26.9000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: au3aqMhzkZzTj5Y3YmG543cl/6iWcWClD93ZE+veCyjhIwv2okCQOZknegApeUE+W2Gipd0zrDbIdgCSJL8EdfvxBg0KSJ0HnY6azvuCQQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5524
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkuMDUuMjAyMyAxNToyNCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBIZXkgQ2xhdWRpdSwN
Cj4gDQo+IE9uIE1vbiwgTWF5IDI5LCAyMDIzIGF0IDA5OjI2OjA0QU0gKzAzMDAsIENsYXVkaXUg
QmV6bmVhIHdyb3RlOg0KPj4gQ29udmVydCBNaWNyb2NoaXAgQVQ5MSBzeXN0ZW0gdGltZXIgdG8g
WUFNTC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpu
ZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9hdG1lbC1zeXNyZWdzLnR4dCB8ICA5IC0tLQ0KPj4gIC4uLi9iaW5kaW5ncy90aW1lci9hdG1l
bCxhdDkxcm05MjAwLXN0LnlhbWwgICB8IDY1ICsrKysrKysrKysrKysrKysrKysNCj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+PiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9hdG1l
bCxhdDkxcm05MjAwLXN0LnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVncy50eHQNCj4+IGluZGV4IDU0ZDNm
NTg2NDAzZS4uNjhjMGVhY2IwMWFjIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dA0KPj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dA0KPj4gQEAgLTQs
MTUgKzQsNiBAQCBDaGlwaWQgcmVxdWlyZWQgcHJvcGVydGllczoNCj4+ICAtIGNvbXBhdGlibGU6
IFNob3VsZCBiZSAiYXRtZWwsc2FtYTVkMi1jaGlwaWQiIG9yICJtaWNyb2NoaXAsc2FtYTdnNS1j
aGlwaWQiDQo+PiAgLSByZWcgOiBTaG91bGQgY29udGFpbiByZWdpc3RlcnMgbG9jYXRpb24gYW5k
IGxlbmd0aA0KPj4gIA0KPj4gLVN5c3RlbSBUaW1lciAoU1QpIHJlcXVpcmVkIHByb3BlcnRpZXM6
DQo+PiAtLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgImF0bWVsLGF0OTFybTkyMDAtc3QiLCAic3lz
Y29uIiwgInNpbXBsZS1tZmQiDQo+PiAtLSByZWc6IFNob3VsZCBjb250YWluIHJlZ2lzdGVycyBs
b2NhdGlvbiBhbmQgbGVuZ3RoDQo+PiAtLSBpbnRlcnJ1cHRzOiBTaG91bGQgY29udGFpbiBpbnRl
cnJ1cHQgZm9yIHRoZSBTVCB3aGljaCBpcyB0aGUgSVJRIGxpbmUNCj4+IC0gIHNoYXJlZCBhY3Jv
c3MgYWxsIFN5c3RlbSBDb250cm9sbGVyIG1lbWJlcnMuDQo+PiAtLSBjbG9ja3M6IHBoYW5kbGUg
dG8gaW5wdXQgY2xvY2suDQo+PiAtSXRzIHN1Ym5vZGVzIGNhbiBiZToNCj4+IC0tIHdhdGNoZG9n
OiBjb21wYXRpYmxlIHNob3VsZCBiZSAiYXRtZWwsYXQ5MXJtOTIwMC13ZHQiDQo+PiAtDQo+PiAg
UkFNQyBTRFJBTS9ERFIgQ29udHJvbGxlciByZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPj4gIC0gY29t
cGF0aWJsZTogU2hvdWxkIGJlICJhdG1lbCxhdDkxcm05MjAwLXNkcmFtYyIsICJzeXNjb24iDQo+
PiAgCQkJImF0bWVsLGF0OTFzYW05MjYwLXNkcmFtYyIsDQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2F0bWVsLGF0OTFybTkyMDAtc3QueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9hdG1lbCxhdDkxcm05
MjAwLXN0LnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAw
MDAuLmE3NTY0NGUxYTJmZQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2F0bWVsLGF0OTFybTkyMDAtc3QueWFtbA0KPj4g
QEAgLTAsMCArMSw2NSBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
LW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDog
aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvdGltZXIvYXRtZWwsYXQ5MXJtOTIwMC1zdC55
YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29y
ZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBNaWNyb2NoaXAgQVQ5MSBTeXN0ZW0gVGltZXIgKFNU
KQ0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBOaWNvbGFzIEZlcnJlIDxuaWNvbGFz
LmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+PiArICAtIEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5k
cmUuYmVsbG9uaUBtaWNyb2NoaXAuY29tPg0KPiANCj4gSXMgdGhhdCBhIHZhbGlkIGVtYWlsIGFk
ZHJlc3M/DQoNCkluZGVlZCwgdGhpcyBpcyB3cm9uZywgdGhhbmtzIGZvciBwb2ludGluZyBpdC4N
Cg0KPiANCj4+ICsgIC0gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5j
b20+DQo+PiArDQo+PiArZGVzY3JpcHRpb246DQo+PiArICBNaWNyb2NoaXAgQVQ5MSBzeXN0ZW0g
dGltZXIgaW50ZWdyYXRlcyBhIHBlcmlvZCBpbnRlcnZhbCB0aW1lciwgYSB3YXRjaGRvZw0KPj4g
KyAgdGltZXIgYW5kIGEgcmVhbC10aW1lIHRpbWVyLg0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+
PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBpdGVtczoNCj4+ICsgICAgICAtIGNvbnN0OiBhdG1l
bCxhdDkxcm05MjAwLXN0DQo+PiArICAgICAgLSBjb25zdDogc3lzY29uDQo+PiArICAgICAgLSBj
b25zdDogc2ltcGxlLW1mZA0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0K
Pj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAg
Q29udGFpbiBpbnRlcnJ1cHQgZm9yIHRoZSBTVCB3aGljaCBpcyB0aGUgSVJRIGxpbmUgc2hhcmVk
IGFjcm9zcyBhbGwNCj4+ICsgICAgICBzeXN0ZW0gY29udHJvbGxlciBtZW1iZXJzLg0KPiANCj4g
SSBkb24ndCB0aGluayB0aGVyZSdzIHJlYWxseSBtdWNoIHBvaW50IGhhdmluZyBhIGRlc2NyaXB0
aW9uIHdoZW4gdGhlcmUNCj4gaXMgb25seSBvbmUgaW50ZXJydXB0LCBidXQgaXQgY2Fubm90IGRv
IGFueSBoYXJtIEkgc3VwcG9zZSENCg0KT0suIFdhbnRlZCB0byBlbXBoYXNpemUgdGhhdCBpdCBt
YXkgYmUgc2hhcmVkIHdpdGggb3RoZXIgZGV2aWNlcy4gSSdsbA0KcmVtb3ZlIGl0Lg0KDQo+IA0K
PiBPdGhlciB0aGFuIHRoZSBlbWFpbCBhZGRyZXNzIHF1ZXN0aW9uLA0KPiBSZXZpZXdlZC1ieTog
Q29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gDQo+IFRoYW5rcywN
Cj4gQ29ub3IuDQo+IA0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgY2xvY2tzOg0K
Pj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgd2F0Y2hkb2c6DQo+PiArICAgICRyZWY6
IC4uL3dhdGNoZG9nL2F0bWVsLGF0OTFybTkyMDAtd2R0LnlhbWwNCj4+ICsgICAgZGVzY3JpcHRp
b246DQo+PiArICAgICAgQ2hpbGQgbm9kZSBkZXNjcmliaW5nIHdhdGNoZG9nLg0KPj4gKw0KPj4g
K3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0KPj4gKyAgLSBpbnRl
cnJ1cHRzDQo+PiArICAtIGNsb2Nrcw0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBm
YWxzZQ0KPj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4+ICsNCj4+ICsgICAgc3Q6
IHRpbWVyQGZmZmZmZDAwIHsNCj4+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXJt
OTIwMC1zdCIsICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+PiArICAgICAgICByZWcgPSA8MHhm
ZmZmZmQwMCAweDEwMD47DQo+PiArICAgICAgICBpbnRlcnJ1cHRzID0gPDEgSVJRX1RZUEVfTEVW
RUxfSElHSCA3PjsNCj4+ICsgICAgICAgIGNsb2NrcyA9IDwmc2xvd194dGFsPjsNCj4+ICsNCj4+
ICsgICAgICAgIHdhdGNoZG9nIHsNCj4+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gImF0bWVs
LGF0OTFybTkyMDAtd2R0IjsNCj4+ICsgICAgICAgIH07DQo+PiArICAgIH07DQo+PiArDQo+PiAr
Li4uDQo+PiAtLSANCj4+IDIuMzQuMQ0KPj4NCg0K
