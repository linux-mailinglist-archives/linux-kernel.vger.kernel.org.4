Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2B15BA7F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiIPIQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiIPIPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:15:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC859E6A0;
        Fri, 16 Sep 2022 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663316130; x=1694852130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TShlP81hNM0tuvu/jdZj31cm7QmccVpDiBAAnSGL04g=;
  b=yzHNVjRVHQOMtF+gd5MMKg0Rv2d2f7cHvgMX2AnxeoCMnnmfGaAss6Bm
   nxGxqesFKyu1ymhMRmc7CkKAJ0sYcoOWW9qZfy+xWBD69ejNOiXTAHocJ
   DhiRtpTpgEFnsQ0yQalNO5foxPlON94qytA/ca/RPDA7uwUDQOlxsY2PX
   oxYjtvLsnQczoYVeJ6X1JS4bhahpvArvOte33biiGQEcsXAl5DgEtvNXN
   hRn7HqIjJv7RIDRTxZR2ySyvko10dPOgre6j8cUJmLA05RqSxbH4lVg8H
   R8kumlkFFO5pK2UYq8RDzD3MgQDPFOZJ9LM2nWwlW0QPQ3AeZc/38P9nb
   A==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="191123057"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 01:15:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 01:15:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 16 Sep 2022 01:15:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0pWBBIN0vKZaT0jzLnYFzyJjUwar3L0UQuHEgSHUfhkWN8PTKlfZRtx2K0v1nGYj8ivTLaPA4P8nbjwuuE4YbnLuGnfvxqvCjGChmNWMCcGlCK9aXyHMXIXhKXdWR1G+Ex8KrwNMjzXLb6hNK4tH4eHA0uTnfuipDZ2WhujZF9YZzcAGSA3jfGQ3EU71AnlM3D6sJmqmOf3KPKf4C8/dlDKrWn2MVCP1je8m+x1JyTAgcqdtVFgoSFAwpww66Wzjq4zFAZjQBbmUh9DbFG9MOBccrwNY1B6bk+fIbvJ3uKODqsIsgO6q3sFgPi0ePW5rdfpxIJ71QZ4WRkOYadrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TShlP81hNM0tuvu/jdZj31cm7QmccVpDiBAAnSGL04g=;
 b=WeCCjIiMGhqyVmL2rPzTCEKm9LP8AxbYi5GqtuHA93u/UsFkHZ2jCBeoYpgX68GCjkiFAo5OcKBsCohDeFmpJrrFUsv1rIP/hqRasNXZ4jvp34+4Ss/ymOQkaohReJp+sBXb31pxqDtpuUeg1TAummQhbVKcJV2+rMJx3PdbWyEMBHV67mx6xBhaDN4uBQCbGv+w01GHosj4Bql5x20yjdEMt7gYgdFmtHFyf1kxfBu5KX8hC/IW9h+GJHyrrdcrXDrNev3ZADaf/jXScIZ/3DH/+Qi5KWiccTGYOsdi5mSeo8J3MQ63kBYC9ca1bFI7I5wTEEJ1tlzWi01LP2rt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TShlP81hNM0tuvu/jdZj31cm7QmccVpDiBAAnSGL04g=;
 b=GtrKD9ryZJkGgAIUR45dLEmA/krJZsn7iDY41WwCFMWV6i8mC81Wfp+SlXAVLFMSaDFsKt8/PiMRDYnJa0BaiJR1s6ISkhdiqGiw+4KqxPi2NGNpqmNz8zL/Smg7Xi8fdTgsGNHwKqPUfuDXcQ5xg7Ohxf3rAMmS7pHigPjP9c4=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 08:15:27 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::25b7:6f88:f38c:a675]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::25b7:6f88:f38c:a675%4]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 08:15:27 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 04/14] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA
 related properties
Thread-Topic: [PATCH v3 04/14] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA
 related properties
Thread-Index: AQHYyaR6wFNgbemTh06qddozaX2p8g==
Date:   Fri, 16 Sep 2022 08:15:27 +0000
Message-ID: <3234cd79-65db-1210-50c1-e880ec6d87a0@microchip.com>
References: <20220913142205.162399-1-sergiu.moga@microchip.com>
 <20220913142205.162399-5-sergiu.moga@microchip.com>
In-Reply-To: <20220913142205.162399-5-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1960:EE_|BL1PR11MB6052:EE_
x-ms-office365-filtering-correlation-id: 8904e8ac-dbbe-4a17-5538-08da97bb9d29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OoyJEesgKUOfZkR7JihLOtqVUR0jSjwF8NN5zXDXAhzDFEkbBhdMzwG5GkvRY3R5MHkkdF57PKfACcg3tVTrKVwUZxOfXvSmF35TfRbImaO4JvCTTW4e1ACdlvvTWmbdT+lwwBLRVs1CJXvWUsbTwrUu3OSwR+ZntAeaU1i3emiFtilKsgGveQH5BtPg8pTZzuw3k9u8h6ocRwQJtb5HVRE15DjVypK5iKbv9FpcG2zrFpoja0o4pKcn0jyTUN+vXG2wLTdQUCXDaEPHLeb1Ubg17TOEX6wuwaBM8Fzg5ynlBKSqmaTveouKOBWfShoXZ6c+QC13gf5GYA14Ju2HDs2oWEnNmdAdMV0lMe/NaLVRV897nSs6wLLLoMQQUmltN2bAaR4ZPhzEeesNu1xhta4al6N0Yx4G4Rq758tXMO49YVzeutMEostlhr9ujhAExm5lASfrQvbZ2YyZdVDnTakq1vbt4BA9cetT9lrXXc5vjMKzFk+YnMzFGLi69iSzc+2Etb6nWB9ytT8vDXgxug5HC1DN/cvCtEPELz8QOybEwIojBTyWYP3OrIJNob22yiv0YoIkXzBOIgZ1hpyc9UzzMWJGrmslTPqYAoYY2UaaEw18vYZRd2/LmaJftNOivJVy6PLEPGF+xoI3KFVwG0/Mey7j6TNGLIf93TfgbNxKIH/q93V3JxsRL33g09aSeQNbyVyEat1bL+ggsaHTarCjkW/5gD1vrMt39fqxTnjo3P4ur5cBpoC2mDvCbi5EJjNnqOhnRWI4YF9zh+sH0VFKh7MmOnT9CqQ1IxLtfWNwDuPHXBemP/HkEJoZ5G1eRM7xBIkQjjcaauzNExWpdcGJ8clHoWEDQ8QPCUp3gl8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(66476007)(7416002)(71200400001)(66446008)(41300700001)(316002)(66556008)(26005)(122000001)(31686004)(110136005)(66946007)(4326008)(76116006)(91956017)(31696002)(5660300002)(86362001)(8936002)(54906003)(36756003)(8676002)(2906002)(6506007)(478600001)(921005)(186003)(64756008)(38100700002)(2616005)(83380400001)(6636002)(6486002)(38070700005)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVNpWjZ6bVNTWlNVdFR1UXQxd3VXV2RTYk5VTlR1WExobnlSZnpSSWpvYy8r?=
 =?utf-8?B?LzIxSWtBamdTekpDbUl3Z285dG1kMVk4bzdWWmhwdXE4TGo4ZnpaaUZFZmYz?=
 =?utf-8?B?OU4vYU4zeUgyaHdlL09jQkhhVlBJekUzWGpwOWtYcXlKMFZVV2lzVExjS2RP?=
 =?utf-8?B?VEM4dm82aEtWM2tISzhsck0zdzkrMW1uV3pCRU5ucG5tSm8wNUdST3hiaGNP?=
 =?utf-8?B?TlUrcHlQNkZWNzFNd3JEaXpvOE1tRS9EYnU0cDJSWTNDdjNEaGdPU0JibXps?=
 =?utf-8?B?Unk5VUVnTWhNUGdEZlFyeng1clVVU2EvTURlaFVqREtENEt5WllCV3pqZnFi?=
 =?utf-8?B?Z0VYcy9nbXB6cHNldFdxYnE5eW9OcnV4bkdoY3h6aWZxc1BybFJtRzhUOTZ1?=
 =?utf-8?B?ZG4zdDF2TGJJZUhwVmNwbTY1bkRIS0pUWXFUYmdKdVNGK05WMnY2UUljaThU?=
 =?utf-8?B?Z1BrQ1lJblZJNXA3MlZDcjBXQlVPa0swQUo0VkNMdXh0aCtjTkZmU2dVR2o2?=
 =?utf-8?B?NlVQdUJvMU5DMzRqK1VlUU96czI2ekh5bVpvK0hVaG9zc2lqRzJ6YWoxWDBI?=
 =?utf-8?B?UkN4MEU0QUZoSTF2ZnVqTHdoZFRHYldWWDFGVW45U054dmtyRk11WnpIZVE0?=
 =?utf-8?B?eVpNZTFjQStPNW1ZNmdFVDg5OE81NkwrSGFJS2hoS29LK2x2bGJSd2hNejB2?=
 =?utf-8?B?dXFvdjBUbUpCa3RxRytlbjRYMjRSZ1VSSkFDa0Y0TGpKeUhON3d6ZXYrRSth?=
 =?utf-8?B?UUFyeSsyTlpEa3dpTjdwWU4zeEorQnpueGlaWmNnbjVhSGQ3a2ZCODJJZmdD?=
 =?utf-8?B?WFZ5QnQ1YUhHQnFRTGp5V0NOdnVVWHJkeFlFd0JRMGQ3blRMVXRpNW8yUDRY?=
 =?utf-8?B?QUZwVXhoMC9neHVQbnN5ZE1xK09uOHdTYUxvTEtyMTV0Z2d0MHBtK3pHcHJC?=
 =?utf-8?B?c1BEVk40WngwN05nNTc0R3NkQ0pDdDRaNEdnV0VkNHZiQytIQUhiT09JVkFR?=
 =?utf-8?B?b3BqbCtQYlNaRWlScWk4aVJaczFVN3JUVkhOaGdtcUtZZ1lzT0o1SXhkWjVo?=
 =?utf-8?B?ZEErUUdtTmY2UHRWWSsvaUdOdzNMTUFtejhPaDhZUWt4Zm5wc3dhOGoyVlNy?=
 =?utf-8?B?ckZubTkzWlFWTSsyaW4xbkRnU1p2ZnNvZGNKS25iaVVDdS9vNEx1N2M2REJ4?=
 =?utf-8?B?YlA2bllEWU5GNnorTW83YWd2ejA1QlVOdjVKVHV6bG5OUitIdHNCT3RJaGJP?=
 =?utf-8?B?VTlpeVlZLy80MGt1dTYrUmJ3RmovRmtiWW9ZbFZLc09FUm5LM3V5VXJTQWhl?=
 =?utf-8?B?ZUlmMkhxUnUyc0Z2elBBblUxVk5vYmpuRnVUWkFpaytraU9pMTIySGhOVzds?=
 =?utf-8?B?QmwvaWUxUmhHYVFEMmhtN25KMjlaQ2RpNm1oUXhlR2F5MDVSYWh4SHNvcXp5?=
 =?utf-8?B?RiswRkoyZlZnNStHdFB6cnZ5b0NUNDk5ckZLU2RiOW5FdzM0MGNtZEpZVHdV?=
 =?utf-8?B?aXNWZEU4WkFNcFFMZXZ1dmFDUHlQL043REM5am55YlA3UDBiaGtEZjE4cTB1?=
 =?utf-8?B?b1AxdFhkd0l5aDhtZFhiakhyM3JqYzlyczhMMU5Keko0L3dxb3BTMTRRVnVJ?=
 =?utf-8?B?cmdSUTlMTytENlAzVmJZbDNMYUUvQWN0VHhITVJnL3dtYTFNOExpWnBjZUxy?=
 =?utf-8?B?TW1aaVZZaDZ6NmI0TE55QUovTmQ0bEtkU25nbHF1dm9HQVdNSjJ3aXpkaE5U?=
 =?utf-8?B?dVE3YmhXcGVFdlAxRDMwdEtPTVhKaWRUUWhQTmZVaEdLSTlSYXJ2T3g1N0xr?=
 =?utf-8?B?WWplRC9qOC8xWjNaRmZJZVdJNFZXOWxER1RmYlpZdW5jbno1U3ZPODZqZnlj?=
 =?utf-8?B?MDY5R1I1cFZWTStzdUhIVWpabm5zcHpVNG54aHNzcmRkd2hZa1hXZnNaZjFV?=
 =?utf-8?B?blh6QjlDWGpBZ2VFdFhSWmJ6ZHBCanRsY1J4dHZSdktsSHBSTEdOVXkzcWdN?=
 =?utf-8?B?Z3RWOFB4amtjZVhqYUhYUXRvbTc1TTR5dENkMU50ZnhFelVpcGIrcUY3bENZ?=
 =?utf-8?B?QVJnWXRHaHowOGFxRFo3QkVyU05xVEg4eFFkSFFlYjNxVTAyVDFVeDNZUU1i?=
 =?utf-8?B?SEdySTdGTzFsbGtZN0FxcklySjZ5TFNiRmM4UDNRRlh6cmFrRGRtVzZyeFdN?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A80E7D527911EE449EDBD8FB45E504AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8904e8ac-dbbe-4a17-5538-08da97bb9d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 08:15:27.7444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPNqpJcOtzD4bL/7isTrW6wMLdN2FIYtJP9cFn/RDoK+zIMySxKf60lRYzqaDiPXv2KtOxXnc/iOxiPNLYCqRhEVTmrlQ2D67WT3XhpghEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDkuMjAyMiAxNzoyMSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IFRoZSBEVCBub2RlcyBv
ZiB0aGUgU1BJIElQJ3MgbWF5IGNvbnRhaW4gRE1BIHJlbGF0ZWQgcHJvcGVydGllcyBzbw0KPiBt
YWtlIHN1cmUgdGhhdCB0aGUgYmluZGluZyBpcyBhYmxlIHRvIHByb3Blcmx5IHZhbGlkYXRlIHRo
b3NlIGFzDQo+IHdlbGwgYnkgbWFraW5nIGl0IGF3YXJlIG9mIHRoZXNlIG9wdGlvbmFsIHByb3Bl
cnRpZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWlj
cm9jaGlwLmNvbT4NCj4gQWNrZWQtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4N
Cj4gQWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZz4NCg0KQXBwbGllZCB0byBhdDkxLWR0LCB0aGFua3MhDQoNCj4gLS0tDQo+IA0KPiAN
Cj4gdjEgLT4gdjI6DQo+IC0gTm90aGluZywgdGhpcyBwYXRjaCB3YXMgbm90IGhlcmUgYmVmb3Jl
DQo+IA0KPiANCj4gdjIgLT4gdjM6DQo+IC0gYWRkZWQgQWNrZWQtYnkgdGFncw0KPiANCj4gDQo+
IA0KPiANCj4gDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwsYXQ5MXJtOTIw
MC1zcGkueWFtbCAgfCAxMCArKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zcGkvYXRtZWwsYXQ5MXJtOTIwMC1zcGkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwsYXQ5MXJtOTIwMC1zcGkueWFtbA0KPiBpbmRleCBkODVk
NTQwMjRiMmUuLjRkZDk3M2UzNDFlNiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbCxhdDkxcm05MjAwLXNwaS55YW1sDQo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwsYXQ5MXJtOTIwMC1zcGku
eWFtbA0KPiBAQCAtMzQsNiArMzQsMTYgQEAgcHJvcGVydGllczoNCj4gICAgY2xvY2tzOg0KPiAg
ICAgIG1heEl0ZW1zOiAxDQo+ICANCj4gKyAgZG1hczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAg
IC0gZGVzY3JpcHRpb246IFRYIERNQSBDaGFubmVsDQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBS
WCBETUEgQ2hhbm5lbA0KPiArDQo+ICsgIGRtYS1uYW1lczoNCj4gKyAgICBpdGVtczoNCj4gKyAg
ICAgIC0gY29uc3Q6IHR4DQo+ICsgICAgICAtIGNvbnN0OiByeA0KPiArDQo+ICAgIGF0bWVsLGZp
Zm8tc2l6ZToNCj4gICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91
aW50MzINCj4gICAgICBkZXNjcmlwdGlvbjogfA0KDQo=
