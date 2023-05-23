Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB570D30F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 07:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjEWFFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 01:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjEWFFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 01:05:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA32109;
        Mon, 22 May 2023 22:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684818345; x=1716354345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sgvFwBP+L2vrTKY2qxGXJGH4HnWIjoxfXG0lwo+GEs4=;
  b=r/2P7HA/4TERzB7G3GT3arv13cjmr4qxAjFXbhrBcQGmxOZjYqZu8GW5
   4HCKF3mbGJSgqa5kinQ1brXVTkQJKNrf8x7bEigKNiOOdT5vDOfyN/V5U
   +U4GyGcSS/P7IF2q4skwOvzAv6uIdK++v2J+14fYvq3qGZGcmu1o4jQPP
   0zupgekDdram+pim7vrWRmMc75QTibK/78fv5PjD3i1oPrFFtQCTci6if
   //vlHSw50QnIywbXQ7DsdZBbc34gfRTKTe50CdYz26qUS29x5rEcOKvqL
   lbgItvLnKaE9aofFqA3l6cd/ufMpoxqQGc/f/V67OfLi7KkbY4HHel39B
   A==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="226531572"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 22:05:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 22:05:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 22:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4cT8e3dg8fZ7B4r5qjwvOzMeE6CiTQkB0eo3U7PI+4UILxW30ePi1k3BdJ/Gco+ljjuRcC7+MBQNgX9Tch3dM6Ki39a16uqSMKZ2pP8p97GGkhtsO1xAgmJMG3qE4oOcgBeab6JlzQcrq4/3TDs0SGTEJvBzARfpP1rUgIVPZttWsI33BL/rJ0wazD3GjTNWrVyrBOWtG/81XNZ74ziZ/cm0U00/TE1LTOplc38Dsr8YS/bBtnpQpgKqpYZIdjZDpq0ywQph79SsGBAD7xLyPqH+F5/hhq3MWso2Gg2UPmZ3xWkzL09UWbBeaM80b4yVUmosxeTcDzhwGsawO0z+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgvFwBP+L2vrTKY2qxGXJGH4HnWIjoxfXG0lwo+GEs4=;
 b=C7Fc5193DPgILNnX68/7IWKsfF1V2k2PeXBQg/Sem20LVg/IMd4PxY6OwrzrXDeLngK55wUZSfKiJyvykjj9EpYJbo2MiEiwSpHIL7246ugpBxjz23Xi+LROPTpX0Yc/GvgEwFM9SjHuVU1zxP7tjfrjTMt8w182kbGVlNBiXy6ttwFoEmUQphunVG5QqsKUnA29WUonHv1V56bZJuVMtNZdheikQ7ujbzawkzI1K8xKorKctPTWGGBQ+kHzUplHnJbdFIO3a8L1vCDovXnU+x0kFAiBSOSRfpoBc+dmIVk8E3cG+Mbpgc8ZtirxIt2wzOQ/78m6/rZ0+Bv2Ad7Pww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgvFwBP+L2vrTKY2qxGXJGH4HnWIjoxfXG0lwo+GEs4=;
 b=dMklv+Clage96kUpdy++KG76SBoY6OSyvxzKYFOCVEyEjYhpORpWV5CTJLuR6ISerpx68WMvEZan1GBjGcMx/17xjvDrqsr56Q6OLG0u3gICgmo5PssLJohpc9LLeNl/mCP8U8i7a9pQTJC/GXZprSFYsXu/gi7fIf6wq6aKXBE=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by SN7PR11MB6921.namprd11.prod.outlook.com (2603:10b6:806:2a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Tue, 23 May
 2023 05:05:42 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 05:05:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <Ryan.Wanner@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <linus.walleij@linaro.org>, <Ludovic.Desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: at91: Return to boolean properties
Thread-Topic: [PATCH 3/3] ARM: dts: at91: Return to boolean properties
Thread-Index: AQHZjTQ5Wzg3tN0mOEaLD6ICUAKHaA==
Date:   Tue, 23 May 2023 05:05:42 +0000
Message-ID: <d74f957d-d12f-53fa-b7fe-fe40cd32c3f2@microchip.com>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
 <6f06be9e393c02563bc877498c8af75daf3b47f8.1684313910.git.Ryan.Wanner@microchip.com>
 <8241a7ed-6c02-df96-fdcf-39339f50a6e0@microchip.com>
In-Reply-To: <8241a7ed-6c02-df96-fdcf-39339f50a6e0@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|SN7PR11MB6921:EE_
x-ms-office365-filtering-correlation-id: c7b8ecb5-8c07-42a2-5917-08db5b4b5ba3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RRkyEYtkTH/GJ8soNgRY2Z3cZNVK3/yTvMYKk6OUI+1yX8boIWYVuuxdBQAldEaJ0QiK9Hu5cjzx8klT3C9iSifGgstmpdlk0s8ZCbkovdhoYxheDjLPjMBWkUUYbfjCAeyqxtmFiiB+J+iidSAsORGh7wSR9cPD0284PYeOtt0lhoortXiUm+KDYT0PecfwOHQYWZqVox3zcOxuW10PqI/Okp2mfyAzOjGeFM1fB97wGpesip7MAFPnPghIJLXHQr573OYt7+7MNQRF6YVfr40Z2Nul6IeScZNHmGnXv3fI20S2bHZAS7bhHSFOPLOtNK9gUaVQr4ONtgmbRQSFjcRoLjaJHkRLmOM2BTThk67femwHVelmNAn9MH/m6YsD9LtPs7vhaC3Bpy2J8SP6ReLAbdGJjdWjbR1Yx8RL7QFS2Xnp49u4cVjaH2ZJWqOZXiZ7VmOlnEHWfdZVxvXhU8Auv1Q/LtmBYjm8BrdZF9SXygjvmg9u9b5CJguUpfhAVmRlTpqPB0HKRA+FBpQydJjb+8LxOCJddVC0olYB9aiQdHM7JDp8MGO+Bwx3mQUHCx04jam3lQwz0a5acXDL8VNTdE0QSSCof2Uv54dVxOmbQVvhsOGGOSMc722CuQ/BathLWwt2wv8S+52KF1zZUJe5+b1aDM815LwzcytyccIpLXqhMw6SMqgRlvAsC4H7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(38070700005)(91956017)(4326008)(6636002)(316002)(64756008)(66946007)(76116006)(66476007)(66556008)(66446008)(54906003)(38100700002)(6486002)(478600001)(110136005)(8676002)(2906002)(31696002)(41300700001)(8936002)(5660300002)(83380400001)(122000001)(86362001)(26005)(186003)(6506007)(6512007)(53546011)(71200400001)(2616005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHhKMEU0RVJGMTk2Y2pNeUd0WUc3aHpkSDQ3Rm52bU5JVVd5dXA2VWhtYXh6?=
 =?utf-8?B?QWFBWDVPQm45WlZiWm5EakhGaGtZMk9CU3BiQ1JGSkFVdVk1RWk1RVh3NFIw?=
 =?utf-8?B?Q0c5b2FZei9LS2VOejZERHk3NElpT09hbXhlU3A2aVJuYWk1N0xSRHRIeElE?=
 =?utf-8?B?V1hmY0o1Z2taa0FPcmJPMjM5eE1zajBYU0ZjTnNLcTlmYTk0N000ak5wOEZz?=
 =?utf-8?B?b2kxM0NSZFphMmw4bFd0ekZoVStQN0dSbzFrRjBZR0Zpa1piME54ZUVQQkNJ?=
 =?utf-8?B?RUhCc00xZkRubmlnRlhRU2x6bG04TmU4bk05QWZSSUltNThGbC9UWmxZTmFy?=
 =?utf-8?B?Szdnb1Jyb1ErYjBnQXF4QUF2dHZleUkzQjNhQk1Cc3BHdFRoVkR5VXdpZUZm?=
 =?utf-8?B?VlgwOEdpaTBqOU9KN1dmLzAwOHFMNG0zVWtkRkhGemlJSmxnWFRZNUFCdzg1?=
 =?utf-8?B?Nm96cHFiU2kxM09xTXFhQWhlbnFOMWMyZXdjeTMvZE1RL1dwSkNSZyt1UWpj?=
 =?utf-8?B?ZlYxTjVsU1NaT05JM0RSZGRYcGVYRlNjeUFoTlVXenNtQlNsTTVJNDZxOWlB?=
 =?utf-8?B?WFNCdjZHZURLV2ZiL1NhQU5sYngvKzRsWER0WVF0ZGd2dFQya2kxUTNzV1lv?=
 =?utf-8?B?NkhYT1JxRlZDN1d3WUNTZktxU1NrZy9SakI4elhKc3o2RUtKNHZhSEsvNndk?=
 =?utf-8?B?cG1taHJiOUJ4alZlRFlraFlTODVEdHhnSFd4V2FrcWV2Qmc3SmtpTHNIL3RZ?=
 =?utf-8?B?b05sSmpvU2dBdjgvTUI2SXlVSjFBSUV0aGJ1V2FXOEFhYU9ZUkJLdm44aTZv?=
 =?utf-8?B?Q1ZOTFhSZ09OU3FwSHZhWU5reUVDaklCTXpxUFIrTlNVN3d5dUF6ZHMvMC83?=
 =?utf-8?B?dytrem9xWkFuajk5R2lJc3pIQjBKWHhqUnJ6WUx1S1I1SkRhdmNsN20raTdr?=
 =?utf-8?B?RE1sWHdIc2U4ckxIS3pMejlLVkFQK3lrL3NXQ2UwcmRMNlZ6Zm1xNTE1akNY?=
 =?utf-8?B?RXJDNGJHNmw4UkVvWStIczF2YjJIM1EyVDJtdzV4OVN6QzNacGJnSTZQOWlI?=
 =?utf-8?B?ME1WSXFDVnFxeGVLeEo4dVV0ZkRvN2hUaWVTenYzUmJ6LzBSS1E5Z2JlNDFt?=
 =?utf-8?B?YWlQeHkvVTZMNGp2SkdLR0RHZmV6Si9WMHZwdjI4dEFyQ3V4Yzhva0dtaXh6?=
 =?utf-8?B?OGRaUS9aeTRqSnM2YWovK01pQkU5U2svWWNyRWtXeEwweVROM3F3Q2tJNmJu?=
 =?utf-8?B?N3RhRlMxdUY2MFpoMXJhZE41QnliOHlVMXNIa3Z3VFJoSlRCbU95TTdQcEVH?=
 =?utf-8?B?bkZTaFpUZCtpUUdpZU10bThERTVmSXJwcTBPazM5TmMwZEN0bHlnVDEvSDZ4?=
 =?utf-8?B?L2FZSFczcDNXZEtrQzVYdXRQd1dQMzhQeUtpeDRWejFic1ViV0ZzL0UzaW80?=
 =?utf-8?B?U0xKc2M0cEc2WFNRamdienJTbHp5aGJubVVjaVIzekZpM2NOalNCV1F5VFhV?=
 =?utf-8?B?Z0pKRlV4U2tRdnlNTjdYUXZmbnFuOGpNd2g0VTYzKzRYREIzMjJjMTYwb3dC?=
 =?utf-8?B?V2UyVXdlTlZBWVp5ZWROZWYvZDRna0srMjdDWXJCOUFtNGhBcGlXRWNmVGZS?=
 =?utf-8?B?M241VENHY3o5a1NpSW1aTDRIK2xUR05xYnhycWE3VWlMMGZ2SDdSM29MMGVi?=
 =?utf-8?B?L3gvaGEwMDhKVDI3YTA4OG5meXFuNU41WXg1dnVEczkxVDN1NUtsKzYxams5?=
 =?utf-8?B?Y3RSajY3Y2h1U01vN0plcnVhSHdiZ281c3dnbzBXcDRkSUNza0paZDJWNjZG?=
 =?utf-8?B?Ym1VandlRXErSVFIaUtDcmdvblJhemtCWHZjVnFsVnp4VWk3dTJhSERacjFT?=
 =?utf-8?B?UEtnaU5QdGgrdmdvY2dYSlFlSlN3WnhYUjJ1R0FoTWplYVlZdjhpeGlXOURD?=
 =?utf-8?B?L2JQZkl1TllqVkFSQzR5emFjZjM3M1NJcVJLZ0grY3R6T1Y1VGMrWkh1K3JW?=
 =?utf-8?B?SitSU1dnRzFINkV2Z2JaaFh5RVhGMDJoV0U0VVY1QUVGTWZKS0wvNlpoOXdj?=
 =?utf-8?B?djZVa0RoRjEwOGlEUmdpcVlwQkxseVl5MzFScG5FMThPeVBLWkZYQ2R3d3gw?=
 =?utf-8?B?ZVlJQVk2QnorKzFVTmsvSnN0TEt6bnpSWG1vZ2hsTm0xZEZnN2UwL2tFMFJD?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7222B3DA7A6F8A4E8915BF6B97469A13@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b8ecb5-8c07-42a2-5917-08db5b4b5ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 05:05:42.0809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: II9xCn0jPt4XfSK7DoKuS9xVX18r6aauyIBOzGS/xoasiSHxMNBGslT2UUX0MURtiBGIeLiz8oeXG74HpgrLxU0woxs6WxkjwUTegyVKY/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6921
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDUuMjAyMyAxMjoyMiwgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4gT24gMTcvMDUvMjAy
MyBhdCAxMzo1NCwgUnlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEZyb206IFJ5
YW4gV2FubmVyIDxSeWFuLldhbm5lckBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFJldHVybmluZyBi
YWNrIHRvIGNvbW1pdCAwZGMyM2QxYThlMTcNCj4+ICgiYXJtOiBkdHM6IGF0OTE6IEZpeCBib29s
ZWFuIHByb3BlcnRpZXMgd2l0aCB2YWx1ZXMiKSBhcyBwaW5jdHJsIGRyaXZlciBubw0KPj4gbG9u
Z2VyIGV4cGVjdHMgYW4gaW50ZWdlciB2YWx1ZSBhbmQgZXhwZWN0cyBhIHNpbXBsZSBib29sZWFu
IHByb3BlcnR5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gV2FubmVyIDxSeWFuLldhbm5l
ckBtaWNyb2NoaXAuY29tPg0KPiANCj4gT2theToNCj4gQWNrZWQtYnk6IE5pY29sYXMgRmVycmUg
PG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCg0KQXBwbGllZCB0byBhdDkxLWR0LCB0aGFu
a3MhDQoNCj4gDQo+IFRoYW5rcyBmb3IgZml4aW5nIHRoaXMgYXMgd2VsbC4gQmVzdCByZWdhcmRz
LA0KPiDCoCBOaWNvbGFzDQo+IA0KPj4gLS0tDQo+PiDCoCBhcmNoL2FybS9ib290L2R0cy9hdDkx
LWtpemJveDMtaHMuZHRzwqDCoMKgwqDCoCB8IDIgKy0NCj4+IMKgIGFyY2gvYXJtL2Jvb3QvZHRz
L2F0OTEta2l6Ym94M19jb21tb24uZHRzaSB8IDIgKy0NCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9hdDkxLWtpemJveDMtaHMuZHRzDQo+PiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2F0OTEta2l6Ym94My1ocy5kdHMNCj4+IGluZGV4IDcwNzVkZjY1NDllOS4uZmVjNzI2OTA4OGQx
IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1raXpib3gzLWhzLmR0cw0K
Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1raXpib3gzLWhzLmR0cw0KPj4gQEAgLTIy
NSw3ICsyMjUsNyBAQCBwaW5jdHJsX3Bpb196YmVfcnN0OiBncGlvX3piZV9yc3Qgew0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHBpbmN0cmxfcGlvX2lvX3Jlc2V0OiBncGlvX2lvX3Jlc2V0IHsNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBpbm11eCA9IDxQSU5fUEIzMF9fR1BJTz47DQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaWFzLWRpc2FibGU7DQo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkcml2ZS1vcGVuLWRyYWluID0gPDE+Ow0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZHJpdmUtb3Blbi1kcmFpbjsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG91dHB1dC1sb3c7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfTsNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBwaW5jdHJsX3Bpb19pbnB1dDogZ3Bpb19pbnB1dCB7DQo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvYXQ5MS1raXpib3gzX2NvbW1vbi5kdHNpDQo+PiBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2F0OTEta2l6Ym94M19jb21tb24uZHRzaQ0KPj4gaW5kZXggYWJlMjdhZGZhNGQ2Li40
NjU2NjQ2Mjg0MTkgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLWtpemJv
eDNfY29tbW9uLmR0c2kNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEta2l6Ym94M19j
b21tb24uZHRzaQ0KPj4gQEAgLTIxMSw3ICsyMTEsNyBAQCBwaW5jdHJsX2ZseDRfZGVmYXVsdDog
Zmx4NF9pMmM2X2RlZmF1bHQgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBpbm11eCA9IDxQSU5f
UEQxMl9fRkxFWENPTTRfSU8wPiwgLy9EQVRBDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgPFBJTl9Q
RDEzX19GTEVYQ09NNF9JTzE+OyAvL0NMSw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJpYXMtZGlz
YWJsZTsNCj4+IC3CoMKgwqDCoMKgwqDCoCBkcml2ZS1vcGVuLWRyYWluID0gPDE+Ow0KPj4gK8Kg
wqDCoMKgwqDCoMKgIGRyaXZlLW9wZW4tZHJhaW47DQo+PiDCoMKgwqDCoMKgIH07DQo+PiDCoCDC
oMKgwqDCoMKgIHBpbmN0cmxfcHdtMCB7DQo+IA0KDQo=
