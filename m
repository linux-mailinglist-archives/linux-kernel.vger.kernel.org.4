Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF01704E75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjEPM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjEPM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:59:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DDC49CC;
        Tue, 16 May 2023 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684241947; x=1715777947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dwQZpfDTdWN3GzJcpFPCPaiGQ6ouAWKzLOyNe3ZAaMM=;
  b=X6RIGyalSc0KPeDS0yO2iZf3WaUEQ9iBSfSRF7Qz3QMgOYAz17FwJI8Y
   4wC3rk0aI9XLMiajPGdpTpj77SbFcJ+F24dfQiMKhjXUt/eT6KGNSsf6M
   eLYQcqEHEwo+ASjzo2DCtZ4CazSOGKdTwcGgvfl5u8lTLPngkdHHrC5Ql
   Qb59alGnbbMdPof3niIuFQRlN/D4uXc9l2869CGizbL+W1e54h3mN25Tq
   twFKhqtDw2To5QCjLTZeS5P3CodRIAN0tC5vho5iWVQhpO6FbJRlnRzli
   2pz9DKHwt2sRksH2Cy2FwUjkpbvtISmPJhb0EEPcJXCOWFXqjZGUnWqTe
   w==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="scan'208";a="214091012"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 05:58:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 05:58:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 05:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZqXdNWs8Q0JQHr+y+CsYeEi5TbzKRkE6u+xlksTnj/+uW0CISuBhb3yUtAtGJH2Vw+ZemkYVlqtDOy3H7MCbdJW7wdTvmH0nhYQFelvBod6bk13Juv+hOHYapHvoEfho21TyYQKcy8bbWmCfVspxm+JmG3gQeTUyVVjUWIS1Oz7Yjuzm1oxyQGYdjZ27r62uCae7bbpm95DvchaIl3oLsz4bZIik7al1gNgTeFeRoiPr7fNkbnSNoxsFkMKFqtuxVSi5mHav0F7vBSHmkZhqxLFinV7s6n9yIksKBa8JvsFFiN4nsoI59lOfy1Odv6UWStgYQIddYibFh6FyESduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwQZpfDTdWN3GzJcpFPCPaiGQ6ouAWKzLOyNe3ZAaMM=;
 b=lidVvdv1/A+5GmHQQjCE2pTDlNQNgWRSOKKpcIvGgwSPIBYoH9uPkW7t0aiaQe80ndLe8sHHXgwAIEWCASy3JvgkQg2ILyQ1Ip2eF4wgOzzbpIp/vpOC8keW0JdRTIyXZ8+B6qHaetB/3OAt5x3OLPMKvfbOcF9h8pMg/cfqlYXziH4mK7Qz0iK8w+2npmYtA6gWZXSUYH91Jphf2b0aPem2saznb/eLq3c/jwKQZqUqdO/W7yw9PZoXKyhivKH0zBd0nYoLenM4cYEDs55RvuVIXSh2PGX+m3t3EcrSZ8PW00L8somcQ6VRYluIO+/1OUZGwM4Vm9niR+4EgPZryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwQZpfDTdWN3GzJcpFPCPaiGQ6ouAWKzLOyNe3ZAaMM=;
 b=GnrkrUCDHld641Au6O3BSj08120y/WRhmB8LqtR5zMrrSKuedvdcmB2KS6TV6ffnup5mZeN4SSh5p5lOqRjwU0defxkjKzmkmreIHBcv3+cTneJLKzRyc7sLD7gFv0qxFY9s1bNUl1rTdmjwzMkntxYmnjAc2ICneHD7Xzgb+IU=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by SA3PR11MB7434.namprd11.prod.outlook.com (2603:10b6:806:306::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 12:58:38 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 12:58:37 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Thread-Topic: [PATCH v4 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Thread-Index: AQHZh/Yh0zqcaeQuVUGXMncnVcU1GQ==
Date:   Tue, 16 May 2023 12:58:37 +0000
Message-ID: <a42f5efd-0847-6a7d-5d2f-ad5772466664@microchip.com>
References: <20230516051836.2511149-1-claudiu.beznea@microchip.com>
 <20230516051836.2511149-3-claudiu.beznea@microchip.com>
 <20230516-modulator-reason-1d3a754c6dd7@wendy>
In-Reply-To: <20230516-modulator-reason-1d3a754c6dd7@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|SA3PR11MB7434:EE_
x-ms-office365-filtering-correlation-id: 7a362d76-c6ad-425b-868c-08db560d43e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXq8BkBGzF25oWOlwScx2pYn/phynFHUGEcIeX/2ovDE+jLfQYFALM00RYA/f6gdkTJf1R2D3GXX10sa8hMQ2lLTcyIi2R2nHWZBF7U9NRd91kOArazuZV/NsBLeLCSaM8mDOk5jjS7ZtmTyxvcp/b+FViS5n3pSzZvTA6umw+CymJpJ6zbytfWfhvDK5OViY7UkLPG199T0l9YCN0NxHwpAS8bw+w1MAxZMGuoOnhR0c2PN0K6zpsTK2Ha9JZY7EwAjQEd19iKTw3Yu4Gm8oQtcao5XPcZHVTyze5S3kOy6ImehM6EHm+gApLQpatiY88uoYWBe5zHBgalWaUhqaMFVYCCbg4XRxVeGsrlWkAY+HOmIK3LUMTmWgkw1FrDEtaJkB9DHHBorMaXyw3Z43OqmSJfxTWIZZdgXaf8IbS8tqmmaK4lHC2lXXjmHSBksBLmCQwdMtyvFJykob5YE/QvVar5euG0nEDd6obapYk6l4kkScgJ3prLLlXcumSjWKc3n29dLVzV5upGhLHTTbHji+Al4IuIwyVpE93A4QiOkDjdaFP03sw999DbWxlC2dDgefbe7UQw4f/VlF+N9v00KAPTezFgUQTQxfDZChPAFdzRd1qCfWjKv2r/hAWajIpl8QOnsBd9Zo9VHL047XuO2x3BJ1ZZ7u33Z9C01iPuxRRRKIOzcRZQpDgP3/pIXEanvuzDU+Lt2bLve0xxLAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(53546011)(26005)(6512007)(2616005)(83380400001)(6506007)(41300700001)(38100700002)(6486002)(966005)(71200400001)(31686004)(186003)(37006003)(478600001)(54906003)(66446008)(64756008)(4326008)(6636002)(66556008)(66476007)(316002)(122000001)(66946007)(76116006)(8676002)(5660300002)(6862004)(8936002)(38070700005)(2906002)(36756003)(91956017)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHdaU1k3RHBZNXJaRXUvYjRETG1hMm9nYWwxdlRQVHhjNFFyZS83M1dpalBq?=
 =?utf-8?B?VVZ3aVViZTlKVm4xcnM0OXNtMnNlbGgrYmpJR3JuekRlSUJkM0JaWFA5WWFE?=
 =?utf-8?B?STZydnFkOUZGMWVUakphTUhUUG5EUERTVlFtUGZxcEo1VDI3Vm9jRjZrRzc2?=
 =?utf-8?B?b0J5OFJYN1V4KzdnTmNtWWQvbGM3d3VackxjWjEreU5Jblo5TWNrOFJFNkky?=
 =?utf-8?B?b3kxQ0MzRDBXWThiL3llTTB4Rms3blBmVG1aUzZNTWx0MDJpM3ZRa0hYbWVr?=
 =?utf-8?B?MXlMaGJyQTVubzNLVktZWE5SYWVJVDNxNVF3YUU3cHltRGRCZFhyS0tPbjRU?=
 =?utf-8?B?UWdodk9TcUF4QU9qUzFXOFlpMEl5ZHBkVmk3U3I1VlN5RDBtSkdmbTBSdGtP?=
 =?utf-8?B?bHh5TlpUdzZuVkdrNFprY2o2M0Z1bWJvcHFORWg2RTIxRFhpc2lmbDFpaDB5?=
 =?utf-8?B?TTFobk9yQmpqL1VXakhMblpRZUNicHpIeG5jVzlNenhkTitHZU9FWXl5Tk1j?=
 =?utf-8?B?elFFWjdxZXdZdHFnenNPREhzNElsdFVITmpmQzl0YitManYwUXpLOWw2QXNS?=
 =?utf-8?B?MURDYWxsME5TdU03YnZIRytxaU14Ni85N1hzWWJMU3dxdExVMmpFaEtmQ055?=
 =?utf-8?B?RkxYRUFoRnpJK29WVjhHTW1YMDg4eVZPZUF3Kyt1M1NXcThkUEpxVnZwSUYr?=
 =?utf-8?B?L0JkaDl6WGVZSnkyZjFoZEh2Q0VYV0NMRU9NMksxc1VoTlNRVkZKTjVMeTBP?=
 =?utf-8?B?VmY0aFFtVCtING9qZURZajVxSGxRS2pZYmFqZkhjRjViZm54YTd4aS9oZHAy?=
 =?utf-8?B?cW1jaEpGRUs5ZTJJcE1EWkxpRUN3eDdvVW82WkkxdDhwMXAxZU9IVS9LNFhx?=
 =?utf-8?B?Z1owTjY5OUtHbEJOb0dNdm4rRVBmN1IvaCtSTXRwOVFDdXhUZTNZeVc2UnQ5?=
 =?utf-8?B?TExzSGg0VHlncHRCSk5ZejUvZkI3THJRQUxLQ0llRXY4RlZmeU83cFFzL1U4?=
 =?utf-8?B?QTJ0Uzc3R1lCand6N2dGQ3FncjhhWmZuNHpJMkQzeU5NcE5HVlloYmsrQjF3?=
 =?utf-8?B?VU9pT01ZYTdtVVpuVEVqRTdOVVpFZTNYYXpqUnZ3TWZXTHdqNDVoZXRmbkdL?=
 =?utf-8?B?bmNNWG15THJqRTNYZ2ExY1F0U2h4TVpmL2RpVW5PdXNXZG5MTGhORFAvanZZ?=
 =?utf-8?B?emt1c3BMc2dHYzg1V3BqaWJlUWV6aEU0RHdSQ3Z4cFRpN3VRaFkyN3ZrVlFI?=
 =?utf-8?B?MlpScWs3RHcwaTh1VGh3RUxTUVk2b2IzZkxSYUZYVUlndGh4bksveUhMdm9C?=
 =?utf-8?B?M1RrUXNrZmNPelRIS291M1lRQTN0WUM4UzhZZDdjWjk1RTdrVmR4Y2REREox?=
 =?utf-8?B?TDQ5U2FxLzhwKzZBMUxUN1FYaEo3MDRla0svSUJSOGJ5RFIzcWpoWWsxdTJ0?=
 =?utf-8?B?WHhacTJ3Uk5jWXNlOWlRNEVkMlN6Wmxyd3kvMjU0a3J2c1hRZTVnckh6N1c5?=
 =?utf-8?B?OHNPZnA0Q0RLM0hMN1llR2ZpTkg3V1RDdWcyajJJeUZ3OGJuWmpGZXZ5VXNN?=
 =?utf-8?B?QU9sTTk3eUhPQytyQS9GL25JdE1OOE9PeDlSS2Zma2Ixc1FoQ3FZUHpQa1Nj?=
 =?utf-8?B?WlBGdVAzV2ZsRDVQd01hWGZib0lqNGhPckwzRy8ybGlXcUVuM3g1WjZMNE9E?=
 =?utf-8?B?VzVsM2g1aXZtRlZ2TCtQeDFyYlozSDNHelVCRVpUUStkN3FKOTFyUWFFYTRp?=
 =?utf-8?B?VGYwUzQ1d05jMFFLTVhJcmhyQXh1SWZIWmdtZm54YmhxSTRFaHhTemNBVVli?=
 =?utf-8?B?NmZ1d3FOamhKcDgwbGNoUkNGektnWmhkVHl2eUk3aDlXVXZpY2paTUpRc0V1?=
 =?utf-8?B?b05rYmJxelU4U2dBU0h1ZmtOMUtBbTV3dmlMZGZUS3hCaTF2R1pic0h3aGRQ?=
 =?utf-8?B?R2FxWjVVWGY4b1RPWWRkQ1NHdmVGakdEbTNITGEwYkYvc2szSVVBNUo2aDI5?=
 =?utf-8?B?eXNad21zN0xEL3M2VXFPclpKbGJxWXhqTGp0TFQvMkF5TDBTdVZLci8rQUhk?=
 =?utf-8?B?bEhIOHVyU1JQRUJmRzBMMGxJY2cwQm9CM1RjbEI2eHlRcC9taUk2MkdvcGRv?=
 =?utf-8?Q?pJQRNAorfLy04EGlwA6vtamUT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A75A2764B9153647B345E7812C205769@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a362d76-c6ad-425b-868c-08db560d43e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 12:58:37.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhJC5/hvFqjtW0Lpu3huM4v0a+ERxK+WUP8o5PPIRLrGxC2z0jv3dsCiu2QcCcwzia/mX//gF2RQGYznFXJlRMY4OfTUAqeqxpsGWxdVIEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7434
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENvbm9yLA0KDQpPbiAxNi4wNS4yMDIzIDE1OjAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IEhleSBDbGF1ZGl1LA0KPiANCj4gT24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgMDg6MTg6MzNBTSAr
MDMwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBDb252ZXJ0IEF0bWVsIFBNQyBkb2N1bWVu
dGF0aW9uIHRvIHlhbWwuIEFsb25nIHdpdGggaXQgY2xvY2sgbmFtZXMNCj4+IHdlcmUgYWRhcHRl
ZCBhY2NvcmRpbmcgdG8gdGhlIGN1cnJlbnQgYXZhaWxhYmxlIGRldmljZSB0cmVlcyBhcw0KPj4g
ZGlmZmVyZW50IGNvbnRyb2xsZXIgdmVyc2lvbnMgYWNjZXB0IGRpZmZlcmVudCBjbG9jayAoc29t
ZSBvZiB0aGVtDQo+PiBoYXZlIDMgY2xvY2tzIGFzIGlucHV0LCBzb21lIGhhcyAyIGNsb2NrcyBh
cyBpbnB1dHMgYW5kIHNvbWUgd2l0aCAyDQo+PiBpbnB1dCBjbG9ja3MgdXNlcyBkaWZmZXJlbnQg
Y2xvY2sgbmFtZXMpLg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxcm05MjAwLXBtYy55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2F0bWVsLGF0OTFybTkyMDAtcG1jLnlhbWwNCj4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmU1ZjUxNGJjNGJmNw0K
Pj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Nsb2NrL2F0bWVsLGF0OTFybTkyMDAtcG1jLnlhbWwNCj4+IEBAIC0wLDAgKzEsMTUzIEBA
DQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1D
bGF1c2UpDQo+PiArJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvc2NoZW1hcy9jbG9jay9hdG1lbCxhdDkxcm05MjAwLXBtYy55YW1sIw0KPj4gKyRzY2hl
bWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0K
Pj4gK3RpdGxlOiBBdG1lbCBQb3dlciBNYW5hZ2VtZW50IENvbnRyb2xsZXIgKFBNQykNCj4+ICsN
Cj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVh
QG1pY3JvY2hpcC5jb20+DQo+PiArDQo+PiArZGVzY3JpcHRpb246DQo+PiArICBUaGUgcG93ZXIg
bWFuYWdlbWVudCBjb250cm9sbGVyIG9wdGltaXplcyBwb3dlciBjb25zdW1wdGlvbiBieSBjb250
cm9sbGluZyBhbGwNCj4+ICsgIHN5c3RlbSBhbmQgdXNlciBwZXJpcGhlcmFsIGNsb2Nrcy4gVGhl
IFBNQyBlbmFibGVzL2Rpc2FibGVzIHRoZSBjbG9jayBpbnB1dHMNCj4+ICsgIHRvIG1hbnkgb2Yg
dGhlIHBlcmlwaGVyYWxzIGFuZCB0byB0aGUgcHJvY2Vzc29yLg0KPj4gKw0KPj4gK3Byb3BlcnRp
ZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBvbmVPZjoNCj4+ICsgICAgICAtIGl0ZW1z
Og0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBhdG1lbCxhdDkxc2FtOWcyMC1wbWMNCj4+ICsgICAg
ICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTkyNjAtcG1jDQo+PiArICAgICAgICAgIC0gY29u
c3Q6IHN5c2Nvbg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gZW51bToNCj4+
ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnMTUtcG1jDQo+PiArICAgICAgICAgICAg
ICAtIGF0bWVsLGF0OTFzYW05ZzI1LXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkx
c2FtOWczNS1wbWMNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTl4MjUtcG1jDQo+
PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05eDM1LXBtYw0KPj4gKyAgICAgICAgICAt
IGNvbnN0OiBhdG1lbCxhdDkxc2FtOXg1LXBtYw0KPiBZZXQgYW5vdGhlciBjb21iaW5hdGlvbnMg
cXVlc3Rpb24gZm9yIHlvdS4uLg0KPiBXaXRoIHRoaXMgYmluZGluZyB0aGUgZm9sbG93aW5nIGlz
IG5vdCBwb3NzaWJsZToNCj4gDQo+ICJhdG1lbCxhdDkxc2FtOXg1LXBtYyIsICJzeXNjb24iDQo+
IA0KPiBJcyB0aGF0IGludGVuZGVkPw0KDQpObywgSSd2ZSBqdXN0IG1pc3NlZCBpdC4gU2FtZSBm
b3IgdGhlIGFib3ZlLiBJJ2xsIGhhdmUgYSBuZXcgcm91bmQgYW5kIGZpeCBpdC4NCg0KVGhhbmtz
IGZvciBoYXZpbmcgYSBsb29rIGF0IHRoaXMsDQpDbGF1ZGl1DQoNCj4gSSBub3RpY2UgImF0bWVs
LGF0OTFzYW05MjYwLXBtYyIgaXMgYWJsZSB0byBhcHBlYXIgYXM6DQo+IA0KPiAiYXRtZWwsYXQ5
MXNhbTkyNjAtcG1jIiwgInN5c2NvbiINCj4gDQo+IFNvIHRoZSBpbmNvbnNpc3RlbmN5IHN0YW5k
cyBvdXQuDQo+IA0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBzeXNjb24NCj4+ICsgICAgICAtIGl0
ZW1zOg0KPj4gKyAgICAgICAgICAtIGVudW06DQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0
OTFybTkyMDAtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05MjYwLXBtYw0K
Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWc0NS1wbWMNCj4+ICsgICAgICAgICAg
ICAgIC0gYXRtZWwsYXQ5MXNhbTluMTItcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0
OTFzYW05cmwtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDItcG1jDQo+PiAr
ICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDMtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0
bWVsLHNhbWE1ZDQtcG1jDQo+PiArICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLXBt
Yw0KPj4gKyAgICAgICAgICAgICAgLSBtaWNyb2NoaXAsc2FtYTdnNS1wbWMNCj4+ICsgICAgICAg
ICAgLSBjb25zdDogc3lzY29uDQo+IE90aGVyd2lzZSwgdGhpcyBsb29rcyBncmFuZCB0byBtZS4N
Cj4gDQo+IENoZWVycywNCj4gQ29ub3IuDQoNCg==
