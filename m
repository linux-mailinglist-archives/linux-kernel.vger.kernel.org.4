Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375B06FD964
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjEJIb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjEJIbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:31:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE7E40CD;
        Wed, 10 May 2023 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683707479; x=1715243479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2xV+kDgrYLLQN4Ms1qa4UA0oTz6BNB0JKfHXOkduhXc=;
  b=QPrV2ylsNN7/KXN65KRYe4iuto1y8zDQeQXirLwpDuCg+jUeymdFQwaN
   0dRYR9FTceBt1CpYT8hFlVA5PGj8+x4+j3hlSOjNIEFyGQWnzgyRY6sDv
   qPu7TOjHBD01MYOQWOi+DUoETjf+L2F1ng89wPi1N9UzGXTkMJrT/3t9Y
   WNljw9XWug75lp7YGPyu8lbiWA2q6uP7maZcpOXABmfwBXYP+jB0SA1jS
   1Xh2zuTAIFSvOSBHjUSBaPgn6b++aV+6oxMPCk8AYjuuW3FSA9ErUEN+U
   c7Uopf2gYvueqDKNqFgR4ouh1dZhAqj0LM+4LPGjXID5OxCr/Rt7ym45v
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="scan'208";a="213235278"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 01:31:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 01:31:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 10 May 2023 01:31:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOBasu94WgzdfxEQuhS0/SKPWpjHLiVekUU22Sbek3sP+CjHfd6E6kGv2J41u3/FYQ2gnSGwJnvacsJcTOg8iJQLPStjKsV+2vooh2K/UjfB162QK2Q1dNwM0AQVaIJyIQofK6gtk7WtW5SvgjC1tWwwT57jDdBlg46RJZRk1KydmlfBKfE9lNyiMsyxDa6FEqNYR8C5bXfiUYOdmTjGEDOjTTPH4TCYiLNrnItx7dTiyt9TMlA4mnCEgQLiR8StQRml2ipkRDsXVZCaYlA/HnU7pViImCuoIKTyeVe2Qbc5ump1xtetHX3nCgXceBrVFz/ziZOMTlxd8xbtthh2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xV+kDgrYLLQN4Ms1qa4UA0oTz6BNB0JKfHXOkduhXc=;
 b=kx1mWYzXepSZ2JXn5IAFmRSVi0h9T8RXP4U6VPf/TaGgDwpK4DvCnV38K1thxJhGqbEr03tsX4dNaAQUrPD4BCpLxVrA9AdymBYfEAzlonzp/4loVSBKmSfRmCj63Sku4UcSO3Dp35Uey8RJVTGKDadyI51QtdaJy0/krJt/JBUMa0aS0nC5Wo2xJ2dAUORkimpYmqTUs/XNvy+FjGY/U0NIEMBBsYGNcugs9YkUgh+hEAbumCdjyT1Yfl3yDPp+mGHuMAydf1rvalUeX59o2YtOlSght1PO7jYfqooHb9WFo9YUbHt9JahWd9OmKeznKLrxamYQtuDTx/Tl1LCaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xV+kDgrYLLQN4Ms1qa4UA0oTz6BNB0JKfHXOkduhXc=;
 b=TyxPkgv3bL1vrQsCG5O4f/YOUn3Ydueo/tmT3QNOazlRAOd2P+0ENWa5vuPiV8EJSh7vknPnRuNv72NHMLrG2duUmswiO9NIdwM0h2oQ3ysRf7/FT9Pgg6uGRYq4/1FKHavymBXnqgRPEe7xuNkSbFC0gBOmoURQQHcuQmHYPfA=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 08:31:15 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%2]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 08:31:15 +0000
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
Thread-Index: AQHZgxnIfYKPP/SM9E+eB8mi00kLiw==
Date:   Wed, 10 May 2023 08:31:15 +0000
Message-ID: <71a1e8de-932d-09a1-efeb-af459fee9423@microchip.com>
References: <20230509052757.539274-1-claudiu.beznea@microchip.com>
 <20230509052757.539274-3-claudiu.beznea@microchip.com>
 <e463eb68-3ea0-5230-76fd-4a2ee66bf397@linaro.org>
 <773d0d90-29c7-b1bd-bd16-898b435eafb6@microchip.com>
 <b3c7db03-6614-47d9-a9e0-a8e51c836d86@linaro.org>
 <a4d934c6-ec28-50d0-b9bb-9b11fee7ebb6@microchip.com>
 <1c2aa022-348a-8ac2-1a26-eedf57aadb77@linaro.org>
In-Reply-To: <1c2aa022-348a-8ac2-1a26-eedf57aadb77@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|DM6PR11MB4657:EE_
x-ms-office365-filtering-correlation-id: b616a328-4b22-437e-95fe-08db5130eb4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oa/W6f3373+Jd5GBkY+V4oi6g4X5y1dLFCZZp3yHjE5dOrABYIGDopovpYyeD/kYdgwUOEQJzL53Ya9UzlC0lEThzTc1TT8AF+goeGGP0MiotMzVcEMxo66PDh7DmkA/W11NusfE0TrG8zRNc85EN9C/I/Dc5/BPpxq60ZdtPGfHaJ834lNWbGEGx/X8sMIbmebFLrIPgl3ymUjqWLJsymKfNfDSMAI+XAxkFPaj8YdNTNv/CqvXpfcB8XEr+GvPuqTi8WL5H04EKDIe/6cS8EGVCwe1onGElxFM7sAET91aSErPBgyRBGWe7CAjH8vwYF/uHcIjjDtvcotPy6yLrVhhkaSqCyVFUTjQpPzqKJsj8aN4HdUihQyAiljEwIHbXo8oWHKWQuiLQ7PLjzWeLbtNxWpdaa3TfM8RERY7aU6TmHGcGQGjRNClMfbIIH+rdH/J1PobLoyptnXDmIowWYUFyG9n03U896snjdrL+aovQSe1hUu8u8T/+i18OL+GUCAI8Qr6CWss00o8MvX37uKRq9DRrE/ArW6EECauXniwei+QJaFNI1dimMkmNQ+49Yc8nqLfWP73EBb/KW9XV5whDtGiMc589xApH2e1r+qonLouMP2roy8wTdQyhfNWUo5xDBnx51V5UfN2ukK3ixtCVUJnLQnNBXdaIWTNpyGb4q4mhTzTwIfoP04elNAY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(41300700001)(2616005)(38100700002)(36756003)(2906002)(38070700005)(316002)(4326008)(6486002)(64756008)(122000001)(91956017)(66446008)(76116006)(66476007)(66946007)(66556008)(86362001)(53546011)(7416002)(8676002)(8936002)(110136005)(83380400001)(54906003)(5660300002)(31696002)(71200400001)(6512007)(6506007)(478600001)(31686004)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDhuMy9jeHdqNThQK3NicGF4QWtjUkwxTGQ5cXY1L2V4SWw4WERsRmQ2NWFy?=
 =?utf-8?B?T2pKZk15S2FZazY1dEl4NFdWSFI0YU0zZ014alYzMnZIS1RQMXF4cVhDcTBi?=
 =?utf-8?B?eGdjWnNaMlFEemhuTURzZTJmRmRlciszNW9SKzI1c1FHQUtIUWRQd2pHUlUz?=
 =?utf-8?B?aEFkUG9lbzNZVHpRbmwxQ0UvdStVb0tTSk9TM0lEVzA4aE9zQ2Z3UVRnRDJ2?=
 =?utf-8?B?UVM4VWJxbVBKUDRTbDE4V3plajZnOGNZbk1HaEJLaXNaTElGMGNDWkZ5QXdq?=
 =?utf-8?B?UURpaXJXZW1uNkdPSmNjQ3NUVndHOVpIeE8wUmRnNHNLWFJhK1lUQWU4NVR4?=
 =?utf-8?B?dTR5bk91VzFwcHhrSkp0UGJTbjI1dUd4eEVmUW90SEV3dDJiMXdUZ0h0VGpm?=
 =?utf-8?B?dEd5UW8yT1lwNUx5eWdVazFyeFkrdncwWDY3b2J2UGgyZzBwUVc1UjVjNTFv?=
 =?utf-8?B?VThpQytpTnUzdDhidUY1eU1NNklVTVZ4SzBZUFFSM3hBbEh6WU1NcTJsaDZ4?=
 =?utf-8?B?UW12V3dNY3RKVnBGd0VsZDZDSGsyQitoa295K2VJRzdKVzM1QXFPeUpyeFYv?=
 =?utf-8?B?VEx1VHJRaTUvVDZURTRRM1ZWNkJ2OTNOL2V6L0VXQW5COWU4c2JnbnhmSDZn?=
 =?utf-8?B?VjNjZEh0SGw3Q1pyN3ZVK2FybE5yQlR1K1JOa2cySC85S2lWZ2lPN2t5TmJ5?=
 =?utf-8?B?VmFqZndEcG5qQnNxOC9YWHliQkNOSHVKS2pUR3hvWnJaWDA4ZTJXclNNdnUr?=
 =?utf-8?B?SStQY0hBWGJ2NWN5U3NtcVhGb2dyMlpuSCt6TVVNV3Nhayt1emg4VGFFdWJr?=
 =?utf-8?B?dlVuMG10TzJWbDQya3hmWGdpMGRzVFcxQnlNNTVsVjdRQlM5Zml0NkRWWFpn?=
 =?utf-8?B?Z1NNdFhTZHZjaVU3VlR2YVBiNHpab0d6SHN3MXNkVHZGelYwN3c3bVdjRTkx?=
 =?utf-8?B?RkJtOWtXdkRNQlltK1NKVEYxdlBIbUFLVGl0S1hVSXlsVzkwQ3l6bGErZlR3?=
 =?utf-8?B?OUUxeklxMWxsak50eEFKOS9mNDlwK0pyUEFKSGVpMkNsSVZZWFJpbExWOEhl?=
 =?utf-8?B?bFhGU0FEQ3lQRmZVY1c5UFk0aklkWmZzMWtCaXhWR25hVVl4UHMwQXpnSHpk?=
 =?utf-8?B?eExza2VGYVRVRFVtVloySjRqWldmQlNNTnBnODk0VVFYQ1lIbGZHNTdEYzZn?=
 =?utf-8?B?TEdpdHVadG0vWkk5cEZPYWV2N3QwWXRZYy9CTDdxaTZ5L3lyUklOMEZrUTg1?=
 =?utf-8?B?ZU9TQWNOdFRuZ3JuUVR5ZktXS3R3bjVpa2JWM3pWd2ltRjQ5SytLVXBwREpu?=
 =?utf-8?B?VytQVzBnUitQNVd2anBUSGVmeW0rMGVvN1pFUEkrOFV0blpYQW1HczJDWmQx?=
 =?utf-8?B?aWdVRWVpYXNXZGMwMHZrcGJ2TmdIU0V1RjBZdlZQQm5uM1B2K3BFbUdOY2dY?=
 =?utf-8?B?cHFvUW5ZWVNCV2pFQ3dLZVh5K3ZjU3hWWlp1SFNjNCtETTNpSitkL20yL1VW?=
 =?utf-8?B?akpDM0FvV3lKdzFFaHAxNXdFYXltS050NzZDTmpGNitFYkNGenIzN3UrWllD?=
 =?utf-8?B?T2NkWThJNTlkZWRhSlJxT1BxTGVLT2FsZU5wZUFJNHBESGNtODRIVjAvS0I4?=
 =?utf-8?B?dXJOelZ0Tm1JTmdveEJRay91NmxMUTRnUUk5WWkzdXRiMmEvOUZCM2Z1Z2l2?=
 =?utf-8?B?aVY4aDRLeEtjTE5nSFdvWU5vYmdNdDErU2VHVHR1R2pYRm9PRVQ3WWxXaC9l?=
 =?utf-8?B?WDhJQzNTVmZRTURzMDFkSTRCcG9zSml2ekNXQzZpYVpOZmc3am5IUUdiT1NV?=
 =?utf-8?B?M0lkb2RIeHNQN3d5QUN1N2VCeGN1WFhCZldNdFRhK0E1cS9OOHFLZUV4Wld1?=
 =?utf-8?B?ZGxuMUtsckY1QmdUM0hBUlJOeXUzYnZwRHZ4SG1rd0FsQnN6M1VPT1o1ZnpT?=
 =?utf-8?B?OGhYOEN2NWNqUzM4Z1paaFJiMWxEUXJ1SFlTclRHdU80WS9GTGtvRklEdjlv?=
 =?utf-8?B?eG9mZ0txSGU3WFI0K1NNajFJT3haR1ZrSXZSWGFiL0M0aU14bkwyd2NlU2ly?=
 =?utf-8?B?NTRIOGlQUHQvYzU0a2JEenFJeHgyMjluUzlUMUlINHNxQnlnUnovc1kzRkxu?=
 =?utf-8?B?TFFvQWZDRE5aL2pRRkZTYnhycUZBaVpwaXBnZDl0R2ZwUk1rZTc1SDZLYlpj?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5FA61BEBEDCA54AB3B37ED393239F59@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b616a328-4b22-437e-95fe-08db5130eb4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 08:31:15.0936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5joZsDbXLupJVzqdRxKmE1klodm3gGDqBJxdSfPI7dcrxyGGUzjkps75qPCeRQ40awyzl4Bqxi2T/qX0HNsHbJF+Lw3URMIPavlr+BC7Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4657
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDUuMjAyMyAxMDo1OCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMC8wNS8yMDIzIDA5OjE0LCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMTAuMDUuMjAyMyAxMDow
NiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDEwLzA1LzIwMjMgMDk6MDAsIENsYXVkaXUuQmV6bmVh
QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IE9uIDA5LjA1LjIwMjMgMDk6MjUsIEtyenlzenRv
ZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUNCj4+Pj4+DQo+Pj4+PiBPbiAwOS8wNS8yMDIzIDA3OjI3LCBDbGF1ZGl1IEJlem5lYSB3cm90
ZToNCj4+Pj4+PiBDb252ZXJ0IEF0bWVsIFBNQyBkb2N1bWVudGF0aW9uIHRvIHlhbWwuIEFsb25n
IHdpdGggaXQgY2xvY2sgbmFtZXMNCj4+Pj4+PiB3ZXJlIGFkYXB0ZWQgYWNjb3JkaW5nIHRvIHRo
ZSBjdXJyZW50IGF2YWlsYWJsZSBkZXZpY2UgdHJlZXMgYXMNCj4+Pj4+PiBkaWZmZXJlbnQgY29u
dHJvbGxlciB2ZXJzaW9ucyBhY2NlcHQgZGlmZmVyZW50IGNsb2NrcyAoc29tZSBvZiB0aGVtDQo+
Pj4+Pj4gaGF2ZSAzIGNsb2NrcyBhcyBpbnB1dCwgc29tZSBoYXMgMiBjbG9ja3MgYXMgaW5wdXRz
IGFuZCBzb21lIHdpdGggMg0KPj4+Pj4+IGlucHV0IGNsb2NrcyB1c2VzIGRpZmZlcmVudCBjbG9j
ayBuYW1lcykuDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2gu
IFRoZXJlIGlzIHNvbWV0aGluZyB0byBkaXNjdXNzL2ltcHJvdmUuDQo+Pj4+Pg0KPj4+Pj4+ICt0
aXRsZTogQXRtZWwgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sbGVyIChQTUMpDQo+Pj4+Pj4gKw0K
Pj4+Pj4+ICttYWludGFpbmVyczoNCj4+Pj4+PiArICAtIENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1
LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4+Pj4+ICsNCj4+Pj4+PiArZGVzY3JpcHRpb246DQo+
Pj4+Pj4gKyAgVGhlIHBvd2VyIG1hbmFnZW1lbnQgY29udHJvbGxlciBvcHRpbWl6ZXMgcG93ZXIg
Y29uc3VtcHRpb24gYnkgY29udHJvbGxpbmcgYWxsDQo+Pj4+Pj4gKyAgc3lzdGVtIGFuZCB1c2Vy
IHBlcmlwaGVyYWwgY2xvY2tzLiBUaGUgUE1DIGVuYWJsZXMvZGlzYWJsZXMgdGhlIGNsb2NrIGlu
cHV0cw0KPj4+Pj4+ICsgIHRvIG1hbnkgb2YgdGhlIHBlcmlwaGVyYWxzIGFuZCB0byB0aGUgcHJv
Y2Vzc29yLg0KPj4+Pj4+ICsNCj4+Pj4+PiArcHJvcGVydGllczoNCj4+Pj4+PiArICBjb21wYXRp
YmxlOg0KPj4+Pj4+ICsgICAgb25lT2Y6DQo+Pj4+Pj4gKyAgICAgIC0gaXRlbXM6DQo+Pj4+Pj4g
KyAgICAgICAgICAtIGVudW06DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2Ft
OWcxNS1wbWMNCj4+Pj4+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05ZzIwLXBtYw0K
Pj4+Pj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnMjUtcG1jDQo+Pj4+Pj4gKyAg
ICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWczNS1wbWMNCj4+Pj4+PiArICAgICAgICAgICAg
ICAtIGF0bWVsLGF0OTFzYW05eDI1LXBtYw0KPj4+Pj4+ICsgICAgICAgICAgICAgIC0gYXRtZWws
YXQ5MXNhbTl4MzUtcG1jDQo+Pj4+Pj4gKyAgICAgICAgICAtIGVudW06DQo+Pj4+Pj4gKyAgICAg
ICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOTI2MC1wbWMNCj4+Pj4+PiArICAgICAgICAgICAgICAt
IGF0bWVsLGF0OTFzYW05eDUtcG1jDQo+Pj4+Pg0KPj4+Pj4gSSBtaXNzZWQgaXQgbGFzdCB0aW1l
IC0gd2h5IHlvdSBoYXZlIHR3byBlbnVtcz8gV2UgbmV2ZXIgdGFsa2VkIGFib3V0DQo+Pj4+PiB0
aGlzLiBJdCdzIHVzdWFsbHkgd3JvbmcuLi4gYXJlIHlvdSBzdXJlIHRoaXMgaXMgcmVhbCBoYXJk
d2FyZToNCj4+Pj4+IGF0bWVsLGF0OTFzYW05ZzIwLXBtYywgYXRtZWwsYXQ5MXNhbTkyNjAtcG1j
DQo+Pj4+PiA/DQo+Pj4+DQo+Pj4+IEkgaGF2ZSAyIGVudW1zIGJlY2F1c2UgdGhlcmUgYXJlIHNv
bWUgaGFyZHdhcmUgY292ZXJlZCBieToNCj4+Pj4gInZlbmRvci1uYW1lLGhhcmR3YXJlLXYxLXBt
YyIsICJzeXNjb24iIGFuZCBzb21lIGNvdmVyZWQgYnk6DQo+Pj4+ICJ2ZW5kb3ItbmFtZSxoYXJk
d2FyZS12Mi1wbWMiLCAidmVuZG9yLW5hbWUsaGFyZHdhcmUtdjEtcG1jIiwgInN5c2NvbiIuDQo+
Pj4NCj4+PiBUaGUgZW51bSBkb2VzIG5vdCBzYXkgdGhpcy4gQXQgYWxsLg0KPj4+DQo+Pj4gU28g
YWdhaW4sIGFuc3dlciwgZG8gbm90IGlnbm9yZToNCj4+PiBpcyB0aGlzIHZhbGlkIHNldHVwOg0K
Pj4+IGF0bWVsLGF0OTFzYW05ZzIwLXBtYywgYXRtZWwsYXQ5MXNhbTkyNjAtcG1jDQo+Pj4gPw0K
Pj4NCj4+IE5vdCB3L28gc3lzY29uLiBUaGlzIGlzIHZhbGlkOg0KPiANCj4gU3lzY29uIGlzIG5v
dCBpbXBvcnRhbnQgaGVyZSwgYnV0IGluZGVlZCBJIG1pc3NlZCBpdC4NCj4gDQo+Pg0KPj4gY29t
cGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOWcyMC1wbWMiLCAiYXRtZWwsYXQ5MXNhbTkyNjAtcG1j
IiwgInN5c2NvbiI7DQo+Pg0KPj4gYXZhaWxhYmxlIGluIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTFz
YW05ZzIwLmR0c2kgKzQ1DQo+IA0KPiBOaWNlLCBzbyBteSByYW5kb20gY2hvaWNlIHdhcyBhY3R1
YWxseSBjb3JyZWN0LiBPaywgc28gYW5vdGhlcjoNCj4gDQo+IGF0bWVsLGF0OTFzYW05ZzE1LXBt
YywgYXRtZWwsYXQ5MXNhbTkyNjAtcG1jLCBzeXNjb24NCj4gDQo+IElzIGl0IHZhbGlkIGhhcmR3
YXJlPw0KDQpUaGlzIG9uZSwgbm8uIFNvLCBJIGd1ZXNzLCB0aGUgd3JvbmcgaGVyZSBpcyB0aGF0
IHRoZXJlIGNvdWxkIGJlDQpjb21iaW5hdGlvbnMgdGhhdCBhcmUgbm90IGZvciBhY3R1YWwgaGFy
ZHdhcmUgYW5kIHlldCBjb25zaWRlcmVkIHZhbGlkIGJ5DQpjaGFuZ2VzIGluIHRoaXMgcGF0Y2g/
DQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQo=
