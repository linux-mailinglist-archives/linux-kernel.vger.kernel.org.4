Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE48A73804E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjFUJmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjFUJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:42:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE351997;
        Wed, 21 Jun 2023 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687340530; x=1718876530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mXT8+AA7dIsA+92A+OUDauxuKS/MkoErT+s1Mxl4QSs=;
  b=NqvLZ3qw3wTudVQ3mBe+Yk79HBNofJfNUdUMaAGEV2H5SQXTczRHrFS0
   2PS45+mtdqz4vQj7gM3qYFl6Rsqhm/snGMMUOnT94IAVBonzKnCswMiwv
   gicVl+RB4pAt0pYaUyhYSvw9CqrPOBFHvZ3xXPIVbOMJceCDjGZb1H4Vl
   5isXty8dJ5UO44fZ3sniEcFvWd9EXGrwoQpHshCvwHxym2CDY7/be3rSN
   gP/WJiuc3nXl3F2tgzqB7zvQm8J1fejuEJ6PJDm6k+vFuK89mnOlNVxpY
   KcS2HRBC93+3Q0FBlTCatNLaIOl2hevbjJ0YxlxGDtOUTTFWAAUZGSRiw
   A==;
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="219025043"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 02:42:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 02:41:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 21 Jun 2023 02:41:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvCoWuGQ5Cpnseaxg3EKtLNtoeiAwNDWK1TGpEMRIFF1sIchh3scRa9gp4vaHvuaZ8RV29IRwCWCPDRmAjL0Dczics7HhCQvEuU58itRBXvzU7tk+iJmEsH4/Ku9DfMXJIkfTb6YUxD5XOOOGWTE3kayaDYQ6Jddf1BDRxmsJHXhWK82/hYrCjEzHSYUCYRV6/FCpEc06JyipmVKqEFeRsD1ZBmH1sr46fdv9fzx/AB72yJJs2tFZcVb+ZLf2wXODH1sPdcswRqk1vQiskpAK7wCaeddcWMIfQ3+sB1Ms+z57DwaAfqEHOhROs4QOi/Htk5e41JzcfTu7cJ71iSLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXT8+AA7dIsA+92A+OUDauxuKS/MkoErT+s1Mxl4QSs=;
 b=UQRqrN9GFoXNxcJevTGx1tvxd9+Azmu8s55kCP/6bCL1fKCrrRbvABAy7mWm5uWnvDVDjT1oP3HN52m2zAKSeQrUemnU88OS7KmPnQVHIx/eO2YpK+LUwnEGBEveoxeQuKQSWd3bnBREwEwqz3kO0JO/ndHZCpRY3iVG634RwJ3J/bhimEINVwdsSQY64HZnVjLya80utV7SWjUwgBqaVnlFGy+iNW0ukbn/IGyDiFgH0Pfiu4ccTvDj/ABaiOQWCYR9gV14YfM8VdkfohFwwqNF8wbv7GqqlMti4qyS1WyLDiTMr/WtaR9yT2Lem6o/t/dQKu+4eJ0gcuzwoE9Tjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXT8+AA7dIsA+92A+OUDauxuKS/MkoErT+s1Mxl4QSs=;
 b=gTv6iR6/uL37DEYs8ziNXgZiaCfCNChPUCASvcfBnsVuHs1yR1Uj3d6LssZ2p0UvUuHuEWGGu2ElV8VXk69Zf3tZM6nbGfKSs91m0BZIw/NV+twY7TJPF4W7wkF8yHrJfbyAMy6mLIg/09ntX94L6wJkxLFbhZGlbZ9oIGzedzA=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by SJ2PR11MB8566.namprd11.prod.outlook.com (2603:10b6:a03:56e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 09:41:51 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6500.031; Wed, 21 Jun 2023
 09:41:51 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <m.grzeschik@pengutronix.de>, <maxime@cerno.tech>, <windhl@126.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/11] clk: at91: add support for parent_data and
 parent_hw
Thread-Topic: [PATCH 00/11] clk: at91: add support for parent_data and
 parent_hw
Thread-Index: AQHZpCSbXtbtbNr9ZUqwrQ5gpio4tw==
Date:   Wed, 21 Jun 2023 09:41:51 +0000
Message-ID: <aa433bf7-7298-5a92-419a-62f6333bc94a@microchip.com>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
In-Reply-To: <20230615093227.576102-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|SJ2PR11MB8566:EE_
x-ms-office365-filtering-correlation-id: 7c46e291-4e9d-4834-0790-08db723bbdd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQz+bOK/aBBB6FRzXmJ1Rwj9OxqrWem7Zwlt7xwRS0p0EBzpNbpJ3OSEqO6++I5XlaJQ7U1bWY/DRepSPJ0sEq0zOgyDzzX426eFH2YXw/CZhVYDYFEB0oS+AjeHraK2gqJHeRZxDRQBsyAYcy4x5X8DSe0JTz5w0tCBzUNmptJ+OUpS+cRoX6Qp13x10nm6NjOTBSHoZsqNq1L1HZUdP4T0JcU5aAvYOwjZ7cBVsA53ggN4oeEgjcD9YnNRslArKWBT6/TweDjE2cSVe2CoBD41+G6OFJ3FkgBScrgdtioOY6akEjK5quwBITctPVEavGHb1Lm786+RDb4EEOsaGB3VC0D7nRSVoI1CO44SohUHIxl3QcsfloAGtzuDTCXG+lTSq9L84JTB/KjgW7yA8PUEg2FxHTb1W13o5LsdQ4OaqDc/zElGuOerwnnBGXPqlpMiRr6Do7RQTyJW0Ff7aEqPilXnVtKevle9VgTV7/NDp/277XwVelAGQyufidIZgn/yFMsIfQEWqSGen7hghamh6bAGvRiBFEO5KAPebJtX1dM5tJdUZNXBtVHqacgOQA+JkAkIYyp2XOKdEsDcx58qkVwo1U+Jr30QxjHZF2VVijMreXVxKjpY51G6yde9qJwH7LiJhj+SI2W28w0BbV7Nm13Xj2QPEWiM53SVhXsogkDjwx/LsqCGfPOXIN5Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(38100700002)(122000001)(53546011)(26005)(6506007)(83380400001)(6512007)(186003)(2616005)(2906002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(71200400001)(6486002)(38070700005)(478600001)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(91956017)(54906003)(110136005)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWt3bmhiUlZhalBHUTFRWWtDSEF3V1ZBcTZPeHFwS3U4TTlPSEs3eWh6QUQ4?=
 =?utf-8?B?bXgwWmRkblVmQ0FiMWhLTzRJZmwyaXdBaTNpdTBZWnVFYnBDSzIvK2NGQVlV?=
 =?utf-8?B?SE40VmFucDRWZGMyOGJPaTkvN1l4ZlhDclk1eFhZRDQ1S3RJU1E4YUU1Tjlp?=
 =?utf-8?B?LzJ2NzFHTzFWZ0Yyd1NmTm9SY3NCaFZWV3NUVW92ZWNXcWpkQW5PYS9sVUVk?=
 =?utf-8?B?ZkphekZhcC9oVllYN1lWY2RpY1JrMFlkbEpqMVZHZk9iWUFXODFjb3I5WnRx?=
 =?utf-8?B?NVhobjRuQ00xTnV1Wm16a3kzcnYvQlpQdG56TTVzN2dxM0txcEJMdS82K2Nx?=
 =?utf-8?B?SlBWZE5yTEdiOHN1d2dqWCtEMFVEcXJVcVU4RU9sTXhyQXU4bGRVWEhhMFBD?=
 =?utf-8?B?OUd0ZUJTR0x5Sy80cXBUNkFLSTRJV2xCS2dvTVRpYVIxS3ovaVNyK2dIUVgv?=
 =?utf-8?B?azhVeEVlYjROQ1NtV2REelRadG1wQTArRStPMTM0RnJHUm9ib2FoeWUrUTZY?=
 =?utf-8?B?N2ppMjRxRFZPTUM5ZVM1dFQyd21IZ1V5S0EvSkMxdXZlTzVYb2ptaTNnRDNH?=
 =?utf-8?B?ak9PNktlYXh6VVZKbkVqZ1BRazBEeUU2ZHRWVlhXMGhlVHRaVyt6UkgxTUpa?=
 =?utf-8?B?Z0wzRzFyRkx3SW9xOU5zWFN1Y2VhZ0RISU1ReHZCb3FDbExMd2NYOWdBL0hZ?=
 =?utf-8?B?TDk3dEZaa2pqOUUxNm1KZkRVclcvWGwzL1hiZ29qZlh0TjBEd01Tcm96WmJJ?=
 =?utf-8?B?bkZjd29DRTZkaElQU3kxNTRSdE8zRy9WUDRCTmw1VnZSUWZpTXM0SWxlQmF1?=
 =?utf-8?B?aFR6UUNBRVkvSkhhYTc1NnJQWUNMcGFZY3RUd2JFZytHeUJod2trNXY2em5M?=
 =?utf-8?B?dlNRS2RuN2s4NWI3SUErRUlDSTJCVmd6eTlPMnpXVkVYTFlMTTYzR0xRU2FM?=
 =?utf-8?B?OHFYWGlWN0haV2k5MVVHNzlNTFQ5cWNETkROZXJOQlh0c28rb05qNTlkc3Mz?=
 =?utf-8?B?THFpT1FVdVI1Sy9ORjhlSmNFRHpkOFdTQm9iaEV4SlR4eEZra25Fc3dmQVJB?=
 =?utf-8?B?SXJrbTRuSDE5c0tHSEtsblVGYTdxVFFXdldaTVEzSHYxcTUxVkxEWGlDUkJK?=
 =?utf-8?B?WlhhTjJkWlh1WmlUYkd0M1NOdHMwblpXSkVaWFA1M0VSZDUwUUovcDBZN0ZC?=
 =?utf-8?B?Mk5BU2Q0b3hxcVFzSnFMZmRQR1BqS0dPWDl2NzJ1b01nY0hGN1lOQkkzS21q?=
 =?utf-8?B?SGk2Sm12MjRsMzBzWStVYVlYOXk3TGYwSDJKT3NGQ0toSkkxU21pVmJKR294?=
 =?utf-8?B?Tm9uUzQrczJydW5JT0grTk5TNSthT0dIdmZqVkpMamtITXdNVUtQdDFmZUx4?=
 =?utf-8?B?dGhkQVdObkozcnhXczQ2dVl4a3BkZ0FqUkd6S0RwelhvQVZHRDdQTUphb0xX?=
 =?utf-8?B?WXZDNWxlSnB4QllPYUhiOGF6RUR6RDV1M1BKc2NhVmZWUTJ5RWl2b2NKSUdq?=
 =?utf-8?B?QllhRjFpYmZHdGRJY3d2Tk1pRE10Z1FTeGZORnlacjVhMmFCZ1EyV1liNWM3?=
 =?utf-8?B?a3FmdTVOZGZGQVFRLyszUytjZE0yclVHNy9NbnFEakQybVU1bU9Dcy9GbjE2?=
 =?utf-8?B?cG5UZU9sVno5TTVpVEQ2NHFzZ3RLTGpReWRCT0pFRVUzRkYraVpDcEUzNnc5?=
 =?utf-8?B?bldjR3pTcHdlYmJ5S2dXNXo0djhVVkFBNjh4ZmphbzJ2OVNxN1hBWGhTc3VL?=
 =?utf-8?B?dS9IakEwVkZPMngyUU5SUEwyT2xyVWw5MlVXbWdmMEgzUXNTMEdGakU1R09J?=
 =?utf-8?B?T0JjcmdabmNURnlaTTR0dnBPQ2JTOHN1d0pzTEFYSEkzZXpUOGtqTEVwM3Vz?=
 =?utf-8?B?YlVSN3lDV1dYL0ZNRDJGYlV4YVQ5dURFWU5uVHVwQkNxVXJ0NlJRU1p5dVRJ?=
 =?utf-8?B?NFRFWGNDU2thVWZyOEZVc1o5czdNTlcyeUhKZ09LNDArOEpGZkNxZzU2Nm5u?=
 =?utf-8?B?VGJXYW1ROHE0Rmg2YndnT013dWJyYnV3TGlFcG5MNlV1YlR3aDhBOWpWa1BE?=
 =?utf-8?B?V2xjcm5TRXo3WGFXclVBMElZOWprMnUvMm9XelRnd3ZIWUh2ZHBiaHN5bm4x?=
 =?utf-8?B?SkhpTndESERrR1lJc0dGV05KTkNYQ2RtRWo0Rk1DVzBJMENQalJ1VHNhWVFj?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBADBA0AA3DA6D46A4B597F45F84602F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c46e291-4e9d-4834-0790-08db723bbdd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 09:41:51.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7D5TR29CY6VTwuEpQ5m7JX1XSFxxoiLoQ5FOqcgM8vMKsY+2JRfCTDxDnWrEmWw46+00dCAVMEtqwhF+f5La8BN7pnsbkmM4f8cLXoeB4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8566
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMDYuMjAyMyAxMjozMiwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksDQo+IA0KPiBTZXJpZXMgYWRkcyBzdXBw
b3J0IGZvciBwYXJlbnQgZGF0YSBhbmQgcGFyZW50X2h3IG9uIEFUOTEgY2xvY2sgZHJpdmVycw0K
PiB1c2VkIG9uIFNBTUE3RzUuIEFzIHRoZSBkcml2ZXJzIGFyZSBzaGFyZWQgd2l0aCBvdGhlciBB
VDkxIFNvQyBhdCB0aGUNCj4gbW9tZW50IHRoZSBwYXJlbnQgbmFtZXMgc3VwcG9ydCBpcyBwcmVz
ZXJ2ZWQgYW5kIHdpbGwgZXZlbnR1YWxseSBiZQ0KPiByZW1vdmVkIHdoZW4gYWxsIHRoZSBBVDkx
IFNvQyBjbG9jayBkcml2ZXJzIHdpbGwgYmUgY29udmVydGVkIHRvIHVzZQ0KPiBwYXJlbnRfZGF0
YSwgcGFyZW50X2h3LiBGb3IgdGhlIG1vbWVudCB0aGUgc2VyaWVzIGRvZXMgdGhlIGNvbnZlcnNp
b24NCj4gZm9yIFNBTUE3RzUuIEV2ZW50dWFsbHksIHN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIGFk
YXB0IHRoZSBvdGhlciBBVDkxDQo+IFNvQyBjbG9ja3MuDQo+IA0KPiBTZXJpZXMgaGFzIGJlZW4g
dGVzdGVkIG9uIFNBTTlYNjAsIFNBTUE1RDIgYW5kIFNBTUE3RzUgU29Dcy4NCj4gDQo+IFRoYW5r
IHlvdSwNCj4gQ2xhdWRpdSBCZXpuZWENCj4gDQo+IFBTOiBhbG9uZyB3aXRoIHRoaXMgSSd2ZSBh
ZGRlZCBwYXRjaCAxMS8xMSB0aGF0IGZpeGVzIGEgdHlwby4NCj4gDQo+IENsYXVkaXUgQmV6bmVh
ICgxMSk6DQo+ICAgY2xrOiBhdDkxOiBjbGstbWFpbjogYWRkIHN1cHBvcnQgZm9yIHBhcmVudF9k
YXRhL3BhcmVudF9odw0KPiAgIGNsazogYXQ5MTogY2xrLWdlbmVyYXRlZDogYWRkIHN1cHBvcnQg
Zm9yIHBhcmVudF9odw0KPiAgIGNsazogYXQ5MTogY2xrLW1hc3RlcjogYWRkIHN1cHBvcnQgZm9y
IHBhcmVudF9odw0KPiAgIGNsazogYXQ5MTogY2xrLXBlcmlwaGVyYWw6IGFkZCBzdXBwb3J0IGZv
ciBwYXJlbnRfaHcNCj4gICBjbGs6IGF0OTE6IGNsay1wcm9ncmFtbWFibGU6IGFkZCBzdXBwb3J0
IGZvciBwYXJlbnRfaHcNCj4gICBjbGs6IGF0OTE6IGNsay1zeXN0ZW06IGFkZCBzdXBwb3J0IGZv
ciBwYXJlbnRfaHcNCj4gICBjbGs6IGF0OTE6IGNsay11dG1pOiBhZGQgc3VwcG9ydCBmb3IgcGFy
ZW50X2h3DQo+ICAgY2xrOiBhdDkxOiBjbGstc2FtOXg2MC1wbGw6IGFkZCBzdXBwb3J0IGZvciBw
YXJlbnRfaHcNCj4gICBjbGs6IGF0OTE6IHNja2M6IHN3aXRjaCB0byBwYXJlbnRfZGF0YS9wYXJl
bnRfaHcNCj4gICBjbGs6IGF0OTE6IHNhbWE3ZzU6IHN3aXRjaCB0byBwYXJlbnRfaHcgYW5kIHBh
cmVudF9kYXRhDQo+ICAgY2xrOiBhdDkxOiBzYW1hN2c1OiBzL2VwX2NoZ19jaGdfaWQvZXBfY2hn
X2lkDQoNCkFwcGxpZWQgdG8gY2xrLW1pY3JvY2hpcCwgdGhhbmtzIQ0KDQo=
