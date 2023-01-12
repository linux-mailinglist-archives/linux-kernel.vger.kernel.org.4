Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114B8666EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjALJxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbjALJwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:52:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0C92FF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673516948; x=1705052948;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=0Tba8ULd8cnOTxWsmro2UhkXTlsozPFpVZ0lFCGV9CA=;
  b=bl1xQkm36rdeC0L9D9U+45Bo/bcmW8fVAoxuA56nli67z6Ga8LBp16j5
   PmvDVP1b6VU+bflmhdBcuMd3JNtrgBU/5hWe0ImTU9e1NR3o0AN1UQeqd
   Q3nvAALzBc39C/WPNaLEfa+scnw5TSLU3f60Rf/AyQSTraGKH2ZCOTQPZ
   +fjIRdTs6VcrirTOe/3bSf4y5dWEzNN+CVPozDAivbfCxiqLmgkrDWlu1
   ISE8BjOLZLOeTtASk0y59VzoTr6MMETT1IbHKzWFaDTnMR0gj/TmPhbtq
   BKT/ZjWmSqj0Kwxnv7FjzGF0fHud6593ZNotLgohJNZ7It1dkCk+5PTNr
   g==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="195424609"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 02:49:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 02:49:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 02:49:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt/ioDT3+cSbLpa3b5KZCsLGwl/150GQ5oy43Ucae1YEfFBCAClPJUA2xmw7WUFpZmhwHv3ngKx72B2RwAsPzAAQ+P0KIPQ+GUR1W4NG+UwoZv6RknTGqn/KmALd3JYLMQvvdcT8BQknSjxjSVCAy0/ycrzi1N9UUaYwK1xAqMpnKMbqH9uDRR94A4pxJHfsDLYlasEYkduaqb0za+8g7NLzNyYOueqCAZLA+8QI8Om/T9dJomWsPcDeqBgd3OmLJs7d3dVUeZKPqNVKMXE/Xvy3RqnebgEwMXBCGao1lahq6/VQzWdA5ajMXD4E6RsGo+FdbPaC5A+mAfJ64+oE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Tba8ULd8cnOTxWsmro2UhkXTlsozPFpVZ0lFCGV9CA=;
 b=aM8ceDREii6OZBn00wsySw1VO7ErVK0xvEuzBTkOCTgAd3eTCxkPynS1nEntscoNYCYIjmwnGIaH2TBWShStOLy7yRHqEizkYc7Z/egPeXr96UsKxux/mP1FqypjdccaQuCuYMVRDn3o/kJJDQKdB5uh1L3iS8V8ENWaIV3C7kE7Gh7G5wYpLza+RMcaNlwEKwwojY1vjWTGwcuD9qP3yPHrlk7nEx8I5zJImnjkFSlZWLHrLGQGkd4HnVRtZL4GyAVZM8XVxDk2imOOqUfxyJIZo/lY6l9MmijxlVSA++fyBFF4CjeTZv+KCtvIrr1GHdVTen23l8kYaCgpfvbQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Tba8ULd8cnOTxWsmro2UhkXTlsozPFpVZ0lFCGV9CA=;
 b=Fkk2k345fXTF7Adw8IVchsln3Y3hI8MlZjtY85iVoy9NSoan+gB8aygyERKjWW30awIaF5pcxSAWACNErgv/uSFIyXfKZTKPmhH09dTF9u8+EQ3brMocQpsj7Npl5cnD4ekNHERv/u8DK5LX2XwnBESVwWTpoFKutqTCl4bCo6o=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Thu, 12 Jan 2023 09:49:02 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 09:49:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Mihai.Sain@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: at91: add support in soc driver for new SAMA7G54
 SiPs
Thread-Topic: [PATCH] ARM: at91: add support in soc driver for new SAMA7G54
 SiPs
Thread-Index: AQHZJmsZU35Ov1aKUEym3lOtxUHw4w==
Date:   Thu, 12 Jan 2023 09:49:02 +0000
Message-ID: <12255cf7-eacb-3bf0-db47-d81238f97ba2@microchip.com>
References: <20221205070108.42624-1-mihai.sain@microchip.com>
In-Reply-To: <20221205070108.42624-1-mihai.sain@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DS0PR11MB6399:EE_
x-ms-office365-filtering-correlation-id: 113c057b-0acc-473d-a3f0-08daf4823c86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BY7YSjnH/MkFi9FT2pfnb0FzAJa1oz84vjKabD6Mov2XGno6H7Net/9AYcza+05Al8/34vtviQHI1gCMX0jOGKng7tx2P+eT9EheR+bTEbLVOMiME2oHe4IlgFygyMqbCM1nVyCtVEXCIivkb3YzpvSE75YHsyEuJzPQL1XxbGNAqgbHvXzKFqXjG8mxJqiCpRoeiq4uTuKF9trUqCuXtTf0XptfewuZXMPWCiW0LcIdhgF+yOULZ9rWyevvpdNbwjxVbtwtp2UeyYeUpDs0t114Kz34L+K/MmCAV7VBe1L301JkZGlAoVOrR/Ml42QolDQzZymcnftykasVcdOmZzqQcteFbujyS1dsoHkeql1mT6ApJzFwkb/NrtsKyE8hcnd7vt5wN3ygmLRZlDmYdLM24dw/ywXdWpBdjsViG1p8q0Fs3enzJBsgWa+J6fjNb6UiiSCmHMpZkOKL8DuYsbSyT+vfOPz7LNylLa3JpBlQAHWFUoVGlj6tdhO2GGESkzAHenbXPGZ4mhQirP20TSUlVlQmUIgmplJeEOnrT5vaWBaeM31zVNIcHwLbGJz+UBkYpBlvkHH9eJRt+PoQEtCke85xXj99yMWrMNJgvoe23DGY5jkAm6LNevfegxLUd2yIa/FmIJ+JqJ0p1hRYP9HEx815ZwUZ+/+BMIoQlMcIR2dWa5mVkE7/2fpeU0LIQrg1BG1iHIzmzVMuerRAGxtBKo9CQZoUbtpBr0LfIoIrL1R8p9aDlI2b73iIu6+X5/aoQvDjqYNxI76CvRMW0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(6506007)(478600001)(38100700002)(122000001)(31686004)(53546011)(2906002)(6486002)(2616005)(26005)(71200400001)(316002)(5660300002)(186003)(36756003)(8936002)(6512007)(86362001)(83380400001)(38070700005)(31696002)(66476007)(64756008)(8676002)(41300700001)(110136005)(66446008)(66946007)(91956017)(66556008)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHd0aS8xcEdyM09oN1RhR0wxeFp1SVhSTHR2cmV4cnJRNVVmSE5UYktFY1d4?=
 =?utf-8?B?ckdSbVRaUjQ2ZE5KSTkwamdxb2Nza3djbitTTVlxU0tmME5veVhxVEdkbUdh?=
 =?utf-8?B?Z3pmbjBhenpGcG96eHNtcnd2VkZ4dS9kR3hEZWFUdFBLK3FaRFBlMGszRW9x?=
 =?utf-8?B?dnoweWdaU3kwclVOaDJkbDFDTnltd0lDS1RkRGhZTGEvdldJNU1UUFhSYm9h?=
 =?utf-8?B?bkl6YldRWTZVL3lLeitGc3dhaldCQm80dlJlSTJ3QTJKUlNPNi9qN1MvOExP?=
 =?utf-8?B?RDJpL0ljNmVXMHNydHdoWHh1eWhhTnh4Q1B4YlYvUWVaTGdPS2tVSTkwVHhW?=
 =?utf-8?B?bVAyUHJ3b1BuNHlvRWw4Sm5RejVsYjcxejVzbDRLV3pzUWFhd0ZEb0Zka0lB?=
 =?utf-8?B?dTNqMUVmdlBqYmF6ZnQ5MjZZQzU5dm01ODNObmllUTYwSm5rZHVqMkxXUjgr?=
 =?utf-8?B?eEF5ajAyNnVxYXVaaE5PL1NzN1NIU0swNDg4Z0JldnllcHZpcS9xMmxodS96?=
 =?utf-8?B?aHp1QmcyYWN0R0laVEIxZ2VWZHRaQVA3Qmw2QldJWE1Xd1Z6Zm95QWVMTUJq?=
 =?utf-8?B?ZjVIbzlMUzMwaVF5RlNsTmhNdVFRRjB4QkdkK0NCSGRYamYyNTFDZzY3WFpt?=
 =?utf-8?B?OGdhNFI1SEVTT2JuQ0kyOGFyNGVJcnN4eVllcjlyV3N4Wm1yaTB4U3BOSWRE?=
 =?utf-8?B?bHBUS1NaY0Q5NGFUeS9JTnlSbnFtdmhTS1h2U1JGd2E3SExBSHJwaG5HczZi?=
 =?utf-8?B?ODR6S3pYKzlvV1VVbEZ4ZkxHZjRIeC9rMit6ZklJajh0SElhbFIxdTh6OWVs?=
 =?utf-8?B?K1ZIaXRjODN6eXVDKzQwb0dnNjFvSHorYWJNUk1VZnNERXRUUUxqczdqaDE5?=
 =?utf-8?B?WDBaSXh4ckVkaGt6TmNXNmZQWDlDeVdiOFQ0T2g2cG9Ecm9vcXFLRXlSWWFa?=
 =?utf-8?B?b25vRE5wUU5Nb3dsRExQQkJxMzFWM0dtblgvSVdHbDZIS05OMExxNWkrMnpl?=
 =?utf-8?B?QzFvYk54NnZKdEZzY1FQQVBpeDdLMll6c1JRVEpUSnMzL3djViszdkU2U28w?=
 =?utf-8?B?YlNlc2xwMWdsYkFneHdCZGlUUmw1c2xaeHBla3JSZlhtbFN2OU9tSFY4VHF6?=
 =?utf-8?B?RkNhTnBseTA1cW82OWpKYkdKeDFISjMvM1dYQ3Q5WFl3VTNsT3FPM1ZValda?=
 =?utf-8?B?blY4YnJUL3A3blRONmIxbUFtNTUyeDMxSERLeEVjclZVWFpCVUhyOVBYZ3lp?=
 =?utf-8?B?NFE2ZFZUams4eW1aN1E3eWM3cm15UG5RcmtsSTJrSjduQ2I3Yy8yUXUzbnlG?=
 =?utf-8?B?RFQrVTkxa1V4RW5NMXRVSS9GSHJRTFpxYi83NVVMUTl2cmpWVFJObDVJK2wx?=
 =?utf-8?B?SFdjWEhMSjZ2VGFuRTlJS1doYnlKQTVPWXVkK2Q2Q0licDJaUmc1OFkyYmZE?=
 =?utf-8?B?Y2V0VE00SDkzdWxId3J1dUcweFNuVm56RUE4OFVoWXdMaWhjZ0JwbWtRYVdK?=
 =?utf-8?B?aGVQcEdLQ0QrUm5HWmw3WVFXTWs3L3BJQ29jeElyU0xPZC80ZDk5RFMxTjMr?=
 =?utf-8?B?TTl0TkVRaXZKaGZPUmV5YnZqMkYyK3Y0ZFZkNTExNDlrWU5WU0E0cVdFRHJS?=
 =?utf-8?B?VFkrVnhETjRrK3pqSFVycUxjdkhRa2srNGFWejBTd1JRWWRjYUNjZU5JdjdW?=
 =?utf-8?B?WjM5VVM1dngyd1FvVDZVZTBEWTVCL0E1ZTBkNDVMdlB3cTdDa3NaRGRDQ2tW?=
 =?utf-8?B?V2poUEFNWkFZRWN3ckpOckd1NzBlQlpWK0phVVVwUEw5TGlMVm9sYjdWa0xj?=
 =?utf-8?B?S0tyQVUyUEg1ZXBCdVE3eU9aS0JNTG5NakpxbmVpS0NaMFlDcEljZUV0Q2VU?=
 =?utf-8?B?TEw5WUl2RTJZZ0VEN0NLMzJPSlRPdmdobVAzZ3NxcHNXNy9QVUdsM1NnVHpr?=
 =?utf-8?B?YTAxaTZRdm0xT24zMkZvSTViVnVoY0RWaGNERHFiSFdJTCs0VGdRQlJRKzhR?=
 =?utf-8?B?OEFHaHhSUzl6L3gzMzM2dHJtVFJ6UU5weWxHb04rWThBSjkxYTVndHRWUkRG?=
 =?utf-8?B?dTNNLzdjK0c4UVY4WURIVWVHOVp5a1p3bEkyUkVlSXk5L2dXdVJwYlFvdWEx?=
 =?utf-8?B?dlowdTJZNis1VTRZaEVpK2U0YUN3bGo0UDVWU1hjMWFmSDR6Nlh6eGc2a0RE?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF30364081CE634DB00451D2D57A6727@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113c057b-0acc-473d-a3f0-08daf4823c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 09:49:02.4260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3Pb5Xrc+OkyUy1lCGDNDDRqjr8Vum9Ub3Fw7ivVlqk4tnDGdJQDVch0QE8jeL77Y9BA+EDrvuUoX6waKX2itw7Vl7u0RWqNi2fYtmVWSJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6399
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMTIuMjAyMiAwOTowMSwgTWloYWkgU2FpbiB3cm90ZToNCj4gQWRkIGRldGVjdGlvbiBv
ZiBuZXcgU0FNQTdHNTQgU3lzdGVtLUluLVBhY2thZ2UgKFNJUCkgYnkgdGhlIFNvQyBkcml2ZXI6
DQo+IFNBTUE3RzU0RDFHLCBTQU1BN0c1NEQyRywgU0FNQTdHNTRENEcuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNaWhhaSBTYWluIDxtaWhhaS5zYWluQG1pY3JvY2hpcC5jb20+DQoNCkFwcGxpZWQg
dG8gYXQ5MS1zb2MsIHRoYW5rcyENCg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL2F0bWVsL3NvYy5j
IHwgOSArKysrKysrKysNCj4gIGRyaXZlcnMvc29jL2F0bWVsL3NvYy5oIHwgMyArKysNCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc29jL2F0bWVsL3NvYy5jIGIvZHJpdmVycy9zb2MvYXRtZWwvc29jLmMNCj4gaW5kZXggZGFl
OGEyZTBmNzQ1Li5jYzlhM2UxMDc0NzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL2F0bWVs
L3NvYy5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL2F0bWVsL3NvYy5jDQo+IEBAIC0yMzUsNiArMjM1
LDE1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXQ5MV9zb2Mgc29jc1tdIF9faW5pdGNvbnN0ID0g
ew0KPiAgCUFUOTFfU09DKFNBTUE3RzVfQ0lEUl9NQVRDSCwgQVQ5MV9DSURSX01BVENIX01BU0ss
DQo+ICAJCSBBVDkxX0NJRFJfVkVSU0lPTl9NQVNLX1NBTUE3RzUsIFNBTUE3RzU0X0VYSURfTUFU
Q0gsDQo+ICAJCSAic2FtYTdnNTQiLCAic2FtYTdnNSIpLA0KPiArCUFUOTFfU09DKFNBTUE3RzVf
Q0lEUl9NQVRDSCwgQVQ5MV9DSURSX01BVENIX01BU0ssDQo+ICsJCSBBVDkxX0NJRFJfVkVSU0lP
Tl9NQVNLX1NBTUE3RzUsIFNBTUE3RzU0X0QxR19FWElEX01BVENILA0KPiArCQkgIlNBTUE3RzU0
IDFHYiBERFIzTCBTaVAiLCAic2FtYTdnNSIpLA0KPiArCUFUOTFfU09DKFNBTUE3RzVfQ0lEUl9N
QVRDSCwgQVQ5MV9DSURSX01BVENIX01BU0ssDQo+ICsJCSBBVDkxX0NJRFJfVkVSU0lPTl9NQVNL
X1NBTUE3RzUsIFNBTUE3RzU0X0QyR19FWElEX01BVENILA0KPiArCQkgIlNBTUE3RzU0IDJHYiBE
RFIzTCBTaVAiLCAic2FtYTdnNSIpLA0KPiArCUFUOTFfU09DKFNBTUE3RzVfQ0lEUl9NQVRDSCwg
QVQ5MV9DSURSX01BVENIX01BU0ssDQo+ICsJCSBBVDkxX0NJRFJfVkVSU0lPTl9NQVNLX1NBTUE3
RzUsIFNBTUE3RzU0X0Q0R19FWElEX01BVENILA0KPiArCQkgIlNBTUE3RzU0IDRHYiBERFIzTCBT
aVAiLCAic2FtYTdnNSIpLA0KPiAgI2VuZGlmDQo+ICAJeyAvKiBzZW50aW5lbCAqLyB9LA0KPiAg
fTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2F0bWVsL3NvYy5oIGIvZHJpdmVycy9zb2Mv
YXRtZWwvc29jLmgNCj4gaW5kZXggMmVjYWE3NWIwMGYwLi43YTlmNDdjZTg1ZmIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvc29jL2F0bWVsL3NvYy5oDQo+ICsrKyBiL2RyaXZlcnMvc29jL2F0bWVs
L3NvYy5oDQo+IEBAIC03MCw2ICs3MCw5IEBAIGF0OTFfc29jX2luaXQoY29uc3Qgc3RydWN0IGF0
OTFfc29jICpzb2NzKTsNCj4gICNkZWZpbmUgU0FNQTdHNTJfRVhJRF9NQVRDSAkJMHgyDQo+ICAj
ZGVmaW5lIFNBTUE3RzUzX0VYSURfTUFUQ0gJCTB4MQ0KPiAgI2RlZmluZSBTQU1BN0c1NF9FWElE
X01BVENICQkweDANCj4gKyNkZWZpbmUgU0FNQTdHNTRfRDFHX0VYSURfTUFUQ0gJCTB4MDAwMDAw
MTgNCj4gKyNkZWZpbmUgU0FNQTdHNTRfRDJHX0VYSURfTUFUQ0gJCTB4MDAwMDAwMjANCj4gKyNk
ZWZpbmUgU0FNQTdHNTRfRDRHX0VYSURfTUFUQ0gJCTB4MDAwMDAwMjgNCj4gIA0KPiAgI2RlZmlu
ZSBBVDkxU0FNOVhFMTI4X0NJRFJfTUFUQ0gJMHgzMjk5NzNhMA0KPiAgI2RlZmluZSBBVDkxU0FN
OVhFMjU2X0NJRFJfTUFUQ0gJMHgzMjlhOTNhMA0KDQo=
