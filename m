Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B609F6038D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 06:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJSESu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 00:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJSESr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 00:18:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3EC7C303;
        Tue, 18 Oct 2022 21:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666153124; x=1697689124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e1zL/Ka4gIn94qfNRYFyocT++qT1q8BakHOL6QvbrVQ=;
  b=fDnAO1AeKpY5g1waESqUZ5blUvc9P7Ljq2dqm/26bNSldg9k8XgYVmGO
   k1xEtM+3DdAqIQjwYhSbYPALw2Q2j4jgN/v8DVN0rn2iuG6KjxkkwVjaJ
   Za5nVjkO/VxEAhLqKZHgI5aLmLXm7cUuxHEnBcsJC1wktl7x6GrvRiWaR
   +Mptp1f8rLt71w6NY8RUdtfFMzbeWILD8K/GXvvese8GhKC+KmHtXMl8L
   OfMv1cdxh5kPiBMtrjPeP6aYmDytcyqI21061WzwqUVUR2ki1pL3yiG6C
   QYBhVObGflyn0xQJne4FDJ/vJsWiEMMEvlACGACRcdDhjiJAWXPjR+heO
   w==;
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="179473883"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2022 21:18:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 18 Oct 2022 21:18:42 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 18 Oct 2022 21:18:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5efwn6T7qOtoGfT8RUWgxrVkl02kMlGRclRE6u8pb4PZwheyb3p5aOkdNHGHG2nkURZQnH5OCqzcbA2tN1e7GPZ89hWqT8EqgagBkACS5udqdYAuG0PrjgG7vcp1p9MKA9NNyE5mmSlo/XzU7k6h7JjimZxjIS3ukUhM7dtOpkM41NwvbXLf7bWjSNU3kmk0v6+ZKk26+meZfCEqcM09/LuTw8ywtPFFVT0yyea9P3a8SX8iTcFxQfPhBs+6M1m24iNUA6+P/lvjiRH0fo7uQy6ektzLUSWxpEk+qRx54RVkCKSa209752vaOssr8nJbj6BouEMbzG+22aTCVJTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1zL/Ka4gIn94qfNRYFyocT++qT1q8BakHOL6QvbrVQ=;
 b=Uo62ACyQqcwoTpJIRMOuWddwU2fB8mThUamEx45DBHhtJIN5pbevigRGSrgpKadK4dI2Xi7jC8HMC3eiV3ks+yARIuujz864KnReTrGwMBdIXx//E32HVu9YAyehtom7WshrpYjAZJrgO0RrBPPr+lJ+iwbD9h/5yFtcwJsFl3K5s7X1uBApaWUoDbsUutwEf+mKELuJ46ZMdFwB+POaDMGYWlM4BsBEryrKQpAsAeXPBepoQrG1njBGxTH59zMfS4XmcHcn9Rg5lwfS9w7yt1VkZKW9nwXBfeNvpnsVuIIIprH/2pGVxaVUhI+UPkxYzrMMkVNeWcf8nMCqaMaFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1zL/Ka4gIn94qfNRYFyocT++qT1q8BakHOL6QvbrVQ=;
 b=Imx5zgVAjqqHhX0YzdskXCjKCgO/hJ2X11tZK6rEmAouAgEmr9yfnlj1/59c/RmI4P9ZlSsjfvG+GeVfL1XVTCsg8xLMRxzeo/bgUhcHld3EkN5iFx1kPgjC8qITF7Wf5pGqlLMjWlnxWLoiLGcD5VpXUKjyQNkJ5hqKXf/d7os=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by CO1PR11MB4785.namprd11.prod.outlook.com (2603:10b6:303:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 04:18:35 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::3c5c:7050:7ea3:6ac]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::3c5c:7050:7ea3:6ac%6]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 04:18:35 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 SPI for-next 2/2] spi: microchip: pci1xxxx: Add suspend
 and resume support for PCI1XXXX SPI driver
Thread-Topic: [PATCH v2 SPI for-next 2/2] spi: microchip: pci1xxxx: Add
 suspend and resume support for PCI1XXXX SPI driver
Thread-Index: AQHY2UFBTyfpeUhNekua+ha6owgtXq4MXsyAgAjS5AA=
Date:   Wed, 19 Oct 2022 04:18:35 +0000
Message-ID: <b917c888a832eccae03f6727d3bd27d5a79a2755.camel@microchip.com>
References: <20221006050514.115564-1-tharunkumar.pasumarthi@microchip.com>
         <20221006050514.115564-3-tharunkumar.pasumarthi@microchip.com>
         <Y0gUH1fbB/LijKLw@sirena.org.uk>
In-Reply-To: <Y0gUH1fbB/LijKLw@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|CO1PR11MB4785:EE_
x-ms-office365-filtering-correlation-id: 1b6e8d2c-f5d9-45d0-04c1-08dab188fdbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8oiN8E6F0fen670ix2Vvvrzzha4S0ErsRTyNFtmf91xK7mhlLU7YjcOSmvofmu+LhyK/c8IShgeNdKediBPnaNe9ZaLXtr8CXZEp3r/rhXewSIt62zwHPYCWll5LkfflkpName3NC/Os8IQkbEITEUA8eOi+kHkyJwMFYru/+7sMXkMs5Ay9+/k25vyMtR6du2MQAE3o0OxBTi0fKC0Rx3mdglFyhG2D/aZdGbTTfYS9evRfempFa1j8se9aR61Q2LivoLRUHwl3KtYKYv6q7nDoPtEkl9c9HoHvaLhy0N0W117ED+iCFIuFIBWFXAO3zFIbR5Uh17INdcUzsu1M3unGhd9C+1sDDPXoYASy0Bl0WbJkWvSQMyPRWCgVVhhvNioLZ5qW/xTi2rImjpLz6xP6DSJ+AQrv8vEdNTumJr7GDHAMt2fXogqT1U3mycxArXmvDFrehdhRVwiq8PBH0EMAgrpj/p7Fl97tmeaVJ/IfbcPmpC4OktF8VqoCnISgG8XUjcbh0HvZC8XGiwEauuQp/nXQbFyyGoUaT0bid52EH28Y7WrvpRCOjNpg73uxFmdHrhIcyaO/0bP7KWqah1ZofeCqAh+q1tT8zmX8rZeFCmMfJfUBj3WSn5QMoyXPGK0xfoEJ/FRIB6I3S6c1NqilLWP90ckvw1HayLSvnegyWHtbUsJ4zqLg4GiLnEuG9Q9i/Dzgo0VEURk2dIXXWWxM+Ta6Pu93wL0LIN99pfmvfZAWtIidpVEG/adjTRUPKDASHvIdQNb4ldW4p+ARQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(26005)(4744005)(6512007)(6506007)(41300700001)(86362001)(83380400001)(54906003)(36756003)(6916009)(66446008)(64756008)(8676002)(4326008)(66476007)(76116006)(66946007)(66556008)(5660300002)(8936002)(91956017)(107886003)(316002)(6486002)(38100700002)(2616005)(4001150100001)(71200400001)(2906002)(186003)(122000001)(478600001)(15650500001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW1JV2RpNDIxamFhaEVBMTJFVUhEYUU1MWQwcEhUWTQ5RXIyTVRPbkRpYWU5?=
 =?utf-8?B?Y1N6VVEvbjZIdm1xTENKa3Y1TGh6ZmhnZnNUdURQLzlIK1JLQWloUXltckF2?=
 =?utf-8?B?cXJvYUZITnJoV25NNjVSVzRkNkJOL1FZNENKKzQrUTJ5TW16UWl3U3I5OTAy?=
 =?utf-8?B?VFhIblNLMHYrWkoraUQ2VTE3azBpMkQ4elp3dXBhQitJcEVIbHd5cVlCZlhT?=
 =?utf-8?B?TCs2dkxUK3NHT2Q0UWNkb1J1SHlaWEhKNXllNWV2V2NXK2VBRjJmcUZBY2VJ?=
 =?utf-8?B?MFpTT2hGQ2RpT0JNV3B2SUpJYzJiWmIyVkZ3UEVReHI1czlTaTAycmxpajE5?=
 =?utf-8?B?bXlWNEdtUTkrK1A3dnB3UFN3c25pejI2a20xQ0tyZW5KRFpibklDeDBCNnVF?=
 =?utf-8?B?aVJnNnM4Sko4dzdNbEh1cXgxdW1WZVh3OTV1VUcvWEJ5WWVnS1F2NS9Zcldo?=
 =?utf-8?B?Uk1GZ292eld3cDkxdDFva3orYmZGcXgvZWlLVEdzR0NOZWc4dHhBT1VyMlNM?=
 =?utf-8?B?S09uTTlBOHRGajNPODJzR09ucU84c1A4U1pIQ1A3VEVpRWNTdVkrUkNaQlVj?=
 =?utf-8?B?UHdJd01hTThVbnBIaWFGRG9sL29raHQ1RTd5czVzSnUrSVVRVkV1QXk1ZTFL?=
 =?utf-8?B?cnpJclF4c3N1SENIbmtPOG5LWXkrNXM1VmZ0UzdYVmdqRllONlk0WklBV3pk?=
 =?utf-8?B?NS9FQmVQazgxV2h0dUI3SHRpa3pzN0E4Z0d0Sng1MGhXK2x1cW1DRW1iQyt1?=
 =?utf-8?B?NDdRMlA2SEdZSTNjbldVS2pEdHlDSjBjUTkwOUpCeXJaRTM5OHV2QWltS0VY?=
 =?utf-8?B?TXZQNXJDUkIxc3pFRXd0VWZhQmVpNEhzNzJ6QlU1cjAxeHpTSUZ2NXhRYVg4?=
 =?utf-8?B?R3R5SGQxRHRuS2Zaa1FIU2RDbWJMayt1dDZMbW1oVlFyL3NWd212dGlJZG1M?=
 =?utf-8?B?MFd5WmNpbldBNnBnT3ljaTdaRnZ0YkpIcCtMcXd5RTVkRFUzQ1FsNytKR0VW?=
 =?utf-8?B?RWM4OFFRZ3kxQkVqRkM2NGZzcHhITVNIckt0eHFGQXZWK3ZBWVJuYURyREJ5?=
 =?utf-8?B?YWdTVDc2QnhGNHVRTWN2OWFIR0pwU0xaeTBpQStUck4waGF3VzhJQ01Zd0ZF?=
 =?utf-8?B?RVI2TVpqcjFhMTk2VWpYKy9ta3lVRXhwRjJzMWhpK3UxZXduaWFQMVlmTkdL?=
 =?utf-8?B?RHRMMTdYNGpkbVhsam9za09kT2Z0eGJTRHM4T3ZXejlaVDdlK2JDNGpYSnlk?=
 =?utf-8?B?UElDeUJjYnVIMnYxS3JCbWU3VHZMcGJhdEs5Z2c1U0h5eUFpMVhpYXZsc1NB?=
 =?utf-8?B?aW9XQytHNmN1SGdnTTN1bm9hbjN2blRwTUhUN3hUZU1sNnJPRmNVcUJwMUla?=
 =?utf-8?B?cFBOMEI0UjhucGN4N3pQWTRKZGswK2p6N3JCeUhOcEVNMm52OWtGSHFuYTF1?=
 =?utf-8?B?TzFyMTlQVE50WldqWGR2V3ZjVjZzVVowNFg2aUVJTU84emZFU3pQVjFuazdt?=
 =?utf-8?B?ejQ1T3dHVG5XT3lUNngxdlhldEwyVGE3MnVHRCtVREpMYnpTNmE4a2M1eHpS?=
 =?utf-8?B?bkVMZmpDNFlDdzFPN2Nyb21UdjJWWEVWRHkzeFhYTnBDRHFiRGRvNXRGUE4y?=
 =?utf-8?B?Q2QvRFYrdExQcWpkcGZmSldlYVgrNThtazVZZFlmVGZIV2RUOFRSKzU5ckEw?=
 =?utf-8?B?YXhyelZuMEJpZ084WU1sdmczWFY4bXBEZXhDOVpUelNidkRmZTFTNlBidWEv?=
 =?utf-8?B?M0RLbytmekdHMGNCaVN1blJvZ0NacVcraVYxRFAra2VzZ0VpbXR0OEdEQkZV?=
 =?utf-8?B?SGRzUlZLVldIVWF6b3AxRllpdko5ZFpaR1pJcEYyUkY2Z3EvOXBDZW1uNEtq?=
 =?utf-8?B?NHlFaVQzL3dkQSs3SisxY0JKTmd0bkh3bEJSZmVqUDZDTjB3Sjc3bzdDbEJ2?=
 =?utf-8?B?L09yNkF2c1R4bDdaRUVzR1I2ZkdxM3hsQmRoeTArTGUrd0VaVk5ORlNhUjFq?=
 =?utf-8?B?cmthVm1wMitSQThXSnJGdlJJeTZMZDkxcy9EMXVWOWE3YnVJUDJVQmFVeHhO?=
 =?utf-8?B?ZTlTZFVOMGtnZVpUU211bHNveTN5ZUhBN2lKS3hST0NIMXlScTJES0h1M1cz?=
 =?utf-8?B?SGNCMWtxK0RTaytUSm5kRGp5T2lqc1E3NVRPL3VrSUU0eVgxQkdhRjM2OHVq?=
 =?utf-8?Q?Cjz0mLRI2ZOu4RzzeLX57ZT7jSXePtQ3hmbmZikmhMzE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E52B649E51BA4449BB01C0074FECC844@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6e8d2c-f5d9-45d0-04c1-08dab188fdbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 04:18:35.6282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwoP20iK/HAvK+gWiOXplTMWZnNLADNJ+LRj6ufzW1U18827X/l9ZrtjCfOWjhLR4lwEpS459uIMwO3Yil86jm6KMsSqyCuj9iNqgIYuEkuABg68sgE+wRwBDvpffqK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4785
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTEzIGF0IDE0OjM1ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gVGhlcmUgc2hvdWxkIGJlIGEg
Y2FsbCB0byBzcGlfY29udHJvbGxlcl9zdXNwZW5kKCkgaW4gaGVyZSAoYW5kIHNpbWlsYXJseSBp
biA+DQpyZXN1bWUpIHRvIHRlbGwgdGhlIGNvbnRyb2xsZXIgdG8gc3RvcCB0aGUgcXVldWUgb2Yg
b3BlcmF0aW9ucy4NCg0KT2theSwgSSB3aWxsIHVwZGF0ZSBjb2RlLg0KDQoNClRoYW5rcywNClRo
YXJ1biBLdW1hciBQDQo=
