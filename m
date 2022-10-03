Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BFA5F282F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 07:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJCFgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 01:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJCFf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 01:35:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F4F32060
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 22:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664775356; x=1696311356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8mgmY1FOPlu4VDRkm5VGX447wLvF5OS3WgUQu7BmwlQ=;
  b=S7/JcBZlMvThqGlCfNyyllIzxFGNSFmQcjIi0RJxgrXwZPjDqMom1caT
   5r4KbDBDnT/oI0InT4rrT9IwxCfiPndu9X3uwDSTplGmStMlLfJ+10oLl
   ZqswT9zXnQc7iYY0Xefx+KEPV7ziBNr7FuMzu9KcLRUPiYVutYMA00Wyx
   PmdVRdoaEhoWlWLuSunWfk3/RvkR34uf/JuD5b3X5bw1zHA+y7Ezy0oWs
   NFgr8mG3aABKmHUo4u0EtWacr8qfGrvpdeYbhc/a4F5nzU6NCV+bRE1gr
   1HOKD8LjZtcau0AbZesGVl01qKbLEnvCin55q3+9fK9UICFsR1nycUCvN
   w==;
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="116515486"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Oct 2022 22:35:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 2 Oct 2022 22:35:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sun, 2 Oct 2022 22:35:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX0dxuDJfVAu5Rdox/INJPcGp0pRzD6ORftf1SEvuMwhbLjN7LNq9iM4AdmmAzrkB4vgarbEChhvE+RNVsegy8KuckzvuBwmTFGkfVe+BWm1Q8bLqbdUJegwcwK2yGnGnQJHP0pPvi1z/j0EzSOnzFgNZBOqflafB2Vh8ZrnLl439yToCd4G2/Z+43qsdCh71lr8Dt1kBKI8OIQDw6yq9XPzaPPMLeqrSOhKwkrYGkZjN0EaSgWcOFj1XfdpO2gmOgAx6a9OeOdVXB5MoIm4EB81QxjBFNIpJO8Ea/ekblicvwSg53J8p8ojf1DlGxbXhqnfDfXNH4UrFVo5vXhafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mgmY1FOPlu4VDRkm5VGX447wLvF5OS3WgUQu7BmwlQ=;
 b=RUAVVwSJCN8IeBJhxQyuloVn4RexTSLHMF4nOJ3RbPmcW6viOQAZmBUXxUsNnoRdyX/+Sg0UR36dXv3Gas2jP/CnZS5nPHTa49UhuSapBxI4IjQI3NfgXAM7/vRZVEGfSxs9nExE5kf97uqWXQr+2LIQkjGmthFieUUvxcFA5edCf1LLqDlvNibTpXnzdhaHcbjYgGS4Stnc0UkvWZC0yHCue1qTzTxV8Qm3WpnP5Ex2t9mh96zcGay+34sn4gVpZKZTM0Udb6Iw1eTE3ACn0ro2zT5lmsvnArXIlOQpZKwZWByXy7dx6fJ4LKH0uM2va2pPAIXDlBKONhgbXOZOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mgmY1FOPlu4VDRkm5VGX447wLvF5OS3WgUQu7BmwlQ=;
 b=fn1/F9StQ7pMr0d3io/rDKi3TbJTZ/DXu0o0OGPp25gnypll5V3PE1xcrH5WGJQ41vWKSxoJvPoJaq6+iAeXD5AOwSpDj7klNzarUXDzG0ed3W33Bt7P1wGOd8WU6ml/doQmEpe8Am3Y7EO2RV6bnFqChJxS3nMbBvSvECaCuN8=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 05:35:35 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::416e:c09:92d7:fd37]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::416e:c09:92d7:fd37%7]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 05:35:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <yaliang.wang@windriver.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: gd25q256: replace
 gd25q256_default_init with gd25q256_post_bfpt
Thread-Topic: [PATCH] mtd: spi-nor: gigadevice: gd25q256: replace
 gd25q256_default_init with gd25q256_post_bfpt
Thread-Index: AQHY1un1B2QwCOqq/0GzsopZd2ehTw==
Date:   Mon, 3 Oct 2022 05:35:34 +0000
Message-ID: <1dddc60f-44fd-df65-f491-be8379fe2380@microchip.com>
References: <20220913084023.2451929-1-yaliang.wang@windriver.com>
In-Reply-To: <20220913084023.2451929-1-yaliang.wang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|SN7PR11MB6994:EE_
x-ms-office365-filtering-correlation-id: 24376912-5035-4e89-80ab-08daa5011860
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EsKwea215dAGUyxFpRmXBCH1pJ2G8BcKnqfJn4gL6rh+HH1OZZ6/BLpw31J7x/bzdFRG8uZNhAVtjejlUaDG/zAh+7gEbjDOPiTKUO2S/UjHIqptZgaHrqU2FRBWh1STjf0iqTAIcgkV+i5LHfSKRgFdpq0BbmMxbxGxT5jTU6YQJjDRJO7J9JVjCKrjgf7N0JVH9ut9ly35SyPbPgZomAArlS8WATdF+QIAPHzePn30z1SVxhSPCjlsmsehPRXT9vILk0B4cqsQVVQQh0iGSPmkv3RNBE7SCIdG+eBzVaZcmC0bGbxG08GT3YvvqXIw4SzZN4SO8elDxx9jU4Z3CkRqAOokJ6pTHBF5J+kTYPnlj9omjzw1KZsxnGLLBDpVgDayYg+0Nogpo3gyT6h9q/9/Rg6slUy+yXkQNsz30MTWidJbgBXM2Mtsuir2hU6V18l6nwGlnobSyShqXqEDHD1gGhDVIQYQeZpSjoiSMs4JwL2Xfah17f2DKXHn/KU7NoQdXgC35EmaMLhb2hrZ01Um6O2t7Bv04JXM5lr2IuqNqFAN51sOkyRoJcPwvXmjm7qyk5PAASS6aSEep6M5thSofg3Wdfc+GPdjfH9d7SPYzLR406bUzcmYNo2H//nFksuEuPixf/2yQq6v6SOlV0W0QHDaGVd5Iv+bDHNUm/pyEMCk90uoXI82LQy6zv55GfnMmTmlE3JDFxrOQaxq7qxwmtpYC/5zWWNlhlsnqd9szS+zOFKQCHx1TMezGzJXrdQEHDi2dEZcATqFkxUaSqi7tbVZUTchLtlMgh2OLXzmDPP6AQUXOX0FXz0XMgmxc1hGxfZ5oTPMiQFAgO+R+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199015)(36756003)(66946007)(122000001)(8676002)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(41300700001)(54906003)(316002)(38100700002)(110136005)(91956017)(83380400001)(186003)(53546011)(86362001)(6486002)(6506007)(71200400001)(31696002)(478600001)(2616005)(6512007)(26005)(31686004)(2906002)(5660300002)(8936002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXV2end6UjhsVjBPZ2c5cjNDSlVhR1NqTVU0cUhCS0hhS1NTbFpZQVJQNEZi?=
 =?utf-8?B?VE9oZEdPQXZKL01TenFRSTdmSVF5aWlTd3RKU3hvTlRYakQ2dlphTU92ZjhC?=
 =?utf-8?B?N0JTbkZVckw2UlhlRytDQ3FCRkU4V2pXNXJXU2lmRkRVT2pSWkxRZHZjVkFs?=
 =?utf-8?B?NlNqSFFRNkFmVWhtN1ZERlhaZGVRQ29iMy9SczY0U2hqSTQ2eDVzbnF2cHFC?=
 =?utf-8?B?YUpEdkNONHNTLzF4dVdJN1FWTVhxaFcrOEpWRzd2NThnbWRWWFNkWW5RR016?=
 =?utf-8?B?UFR4L0czbjJTSktxMSt5TzlKTFJPMGlabGJMOTV6UFVvN0VGbDZycy8wa3JT?=
 =?utf-8?B?U2dvV3NSTklGZVQ5SUkrQzFoNGRXZXlUTG1NTHRmYjVlclFkZUladWxzWDBs?=
 =?utf-8?B?MitsZDRycTQ5WmRqalk3S0FWRWIvREs3OC91U21ZcTFUV3Y4ZFBkNk9JZ0lE?=
 =?utf-8?B?RTNtSzQ0TGt2K09rNjl3eGtpdGcyaEtXRTUrNVJtY1o1bjBrOTI4dnJhWmk4?=
 =?utf-8?B?UVoxTHdWeVo0NE5JVnRXSnpzUUVLZHR3aTVDQUdpODJWSHRLMGRvekZlMTRo?=
 =?utf-8?B?aHd0ckFwSDRJRnFIMW9reFFSK2Z4MXBwU1pibHZIM09rVTZvWlVnQzVGUWRD?=
 =?utf-8?B?aVBkdUUyd2d5VWV3RWlyRU5pZVAzSWZLcUVNOW8xRmxFcHREUVJCQjdNcFBY?=
 =?utf-8?B?dFBLcXZTSmtKdisvdjQxTEZsTUEvNTdLSS9jcHJuWlRSZGIrdDFMQmFpa3Qr?=
 =?utf-8?B?aUYwUm5iT1NxOUJ2cXIrNzhPMWw3MGlFRGJaTERybzJpTWJPYkkrZnBLTGFo?=
 =?utf-8?B?WE9WZnJQS0RjbEFKZnB5L21XUTlXTXUybGNtaERoZ2pBL2dyUmJhN2dsWkc5?=
 =?utf-8?B?azgrZFhZOE1jYXZPUEZhblh0clh5OHN4Y2cySHFsZlJ3WkVmN2F1SDN2Zkd6?=
 =?utf-8?B?cTUyUVZDK2JDRWtWY2NvRUxrMFA4Lzh2S0YwbnJYNU56dWErMnV1TVl2OTVt?=
 =?utf-8?B?dTJrTDYxMzY5Rmh3YzhyK0Z3OXBIMUlnS094dkpCeUd3L2trelZhck9zYmxK?=
 =?utf-8?B?TjQxL3VnOW1ubktnQjB0a0ZwV0Nib2pZVTYzM1NFanFEZys1d1ZnbllXY0hq?=
 =?utf-8?B?Ynkwa0I2MFlxS1hsTTc0MjFrRWliVU1ocnRYeGJZVjRGVktwSDdYZ3NWS0FQ?=
 =?utf-8?B?YnR0Q1ZpNDl0c2MzRUNrd1ZoNEgzRlcwV1FISElERTI4bUdiK3R0S1NVYUxF?=
 =?utf-8?B?ZHhLdzdmQ2NOdzluRVpGTG9ZK05ZZkFXKy9oeVc5dWRtM3NXQjYwcGJ6cU01?=
 =?utf-8?B?Y2JVeU05MlFPTVVFdEdRUGMyV1FVcERJUFNYU1lsSXhSY21LMGw1cWFIS2dZ?=
 =?utf-8?B?S0hCR1FOSzBLVlMramlaMmxGV1BoWjZQcDV3Zkw2MTlGQWt5clpCKzlvVGZU?=
 =?utf-8?B?WVptUGhnWXBMRnlpaEN6WC9GUXUyVHRDeHlwcVBQbDFYRmZaeDlRZk03L25i?=
 =?utf-8?B?TDc4ZFRSaVdpWEc2NjZ1UDBkZXo3ai9BdjU0VmxLYUdlS3lhNWhabUp6bnRk?=
 =?utf-8?B?RU8wOFF2Qkl2UHN5bkprc2tYdk1SSWFuM014NmgwcWlEd3A1MXlpMllkWGJJ?=
 =?utf-8?B?Ly90QUl6QzNLUWRMejl0QW94ZTA3by9UcGlLWXJsOUw2ZXJIeE1RSGppZTJi?=
 =?utf-8?B?Nzh3M2JlcHhqMk44eXF0VlN3RFM0dEJldm80RTQyQXZWVThwWkdlanJ3cU9U?=
 =?utf-8?B?VzJGNEZaQ2tzU1I2d0piMmQwR3cyUTljRUVnejExZlovYWpzVWpsbWxWRzF2?=
 =?utf-8?B?Z0t6TGpQaGFzZkduZjU3b3EwN0FRc2tpVVZqc090WmF2aVJ3a3YreTdaL0l6?=
 =?utf-8?B?cnpOVS95Ti9FNlFTU0dZRWlsYWVLSzRwQnRUeDhEenlrT2Z0QitpZW90RUVm?=
 =?utf-8?B?VXlVVjJMTnQrcDZXVHlyazI3TzRiREtqNEp3bVNGME9OVUVMNVZ4WUdTQnJu?=
 =?utf-8?B?d1hDMmwvMTZoSk5IbTRTNXUzY1c1SERvc05RbkJYR2NTbkZsb1pVUkRYTHNB?=
 =?utf-8?B?aVRiMHJJSzdId1NTODU5eVJWRG92TE03eVM3TmhVSTdJYi9GQzYzT1JSQXBI?=
 =?utf-8?B?WE8vQm12VmFvdnJvRGNjU3BNZyt1OEkzU2RYbllaZ3FlZkFKWFEvZEZqV2Rn?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82C9B4D95BC80445B49865B66F90AD5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24376912-5035-4e89-80ab-08daa5011860
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 05:35:34.8248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtT6X6aBFFdVOTQSK4bobGzLjMgkoA603XVSMyzeI1ISkWpopqzM3azqiQvZfuH04wM8OL3kezjuhOKp1KTYFZJb1Rha9sC8PQvSPZPuB0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMy8yMiAxMTo0MCwgeWFsaWFuZy53YW5nQHdpbmRyaXZlci5jb20gd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTogWWFsaWFuZyBXYW5n
IDxZYWxpYW5nLldhbmdAd2luZHJpdmVyLmNvbT4NCj4gDQo+IFdoZW4gdXRpbGl6aW5nIFBBUlNF
X1NGRFAgdG8gaW5pdGlhbGl6ZSB0aGUgZmxhc2ggcGFyYW1ldGVyLCB0aGUNCj4gZGVwcmVjYXRl
ZCBpbml0aWFsaXppbmcgbWV0aG9kIHNwaV9ub3JfaW5pdF9wYXJhbXNfZGVwcmVjYXRlZCgpIGFu
ZCB0aGUNCj4gZnVuY3Rpb24gc3BpX25vcl9tYW51ZmFjdHVyZXJfaW5pdF9wYXJhbXMoKSB3aXRo
aW4gaXQgd2lsbCBuZXZlciBiZQ0KPiBleGVjdXRlZCwgd2hpY2ggcmVzdWx0cyBpbiB0aGUgZGVm
YXVsdF9pbml0IGhvb2sgZnVuY3Rpb24gd2lsbCBhbHNvIG5ldmVyDQo+IGJlIGV4ZWN1dGVkLiBB
cyB3ZSBkbyBoYXZlIHF1YWQgZW5hYmxlIGZ1bmN0aW9uIGRlZmluZWQgaW4gQkZQVCwgdGhlDQo+
IHBvc3RfYmZwdCBob29rIHdpbGwgYmUgdGhlIHJpZ2h0IHBsYWNlIHRvIHR3ZWFrIHRoZSBmdW5j
dGlvbi4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiAwNDcyNzVm
N2RlMTggKCJtdGQ6IHNwaS1ub3I6IGdpZ2FkZXZpY2U6IGdkMjVxMjU2OiBJbml0IGZsYXNoIGJh
c2VkIG9uIFNGRFAiKQ0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRl
bC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbGlhbmcgV2FuZyA8WWFsaWFuZy5XYW5nQHdpbmRy
aXZlci5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9naWdhZGV2aWNlLmMgfCAx
MSArKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2dpZ2FkZXZp
Y2UuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvZ2lnYWRldmljZS5jDQo+IGluZGV4IDExOWIzOGU2
ZmMyYS4uYmRjNGQ3MzQyNGFmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2dp
Z2FkZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2dpZ2FkZXZpY2UuYw0KPiBA
QCAtOCwxOSArOCwyNCBAQA0KPiANCj4gICNpbmNsdWRlICJjb3JlLmgiDQo+IA0KPiAtc3RhdGlj
IHZvaWQgZ2QyNXEyNTZfZGVmYXVsdF9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICtzdGF0
aWMgaW50DQo+ICtnZDI1cTI1Nl9wb3N0X2JmcHQoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gKyAg
ICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBzZmRwX3BhcmFtZXRlcl9oZWFkZXIgKmJmcHRf
aGVhZGVyLA0KPiArICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHNmZHBfYmZwdCAqYmZw
dCkNCj4gIHsNCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIFNvbWUgbWFudWZhY3R1cmVyIGxp
a2UgR2lnYURldmljZSBtYXkgdXNlIGRpZmZlcmVudA0KPiAgICAgICAgICAqIGJpdCB0byBzZXQg
UUUgb24gZGlmZmVyZW50IG1lbW9yaWVzLCBzbyB0aGUgTUZSIGNhbid0DQo+ICAgICAgICAgICog
aW5kaWNhdGUgdGhlIHF1YWRfZW5hYmxlIG1ldGhvZCBmb3IgdGhpcyBjYXNlLCB3ZSBuZWVkDQo+
IC0gICAgICAgICogdG8gc2V0IGl0IGluIHRoZSBkZWZhdWx0X2luaXQgZml4dXAgaG9vay4NCj4g
KyAgICAgICAgKiB0byBzZXQgaXQgaW4gdGhlIHBvc3RfYmZwdCBmaXh1cCBob29rLg0KPiAgICAg
ICAgICAqLw0KPiAgICAgICAgIG5vci0+cGFyYW1zLT5xdWFkX2VuYWJsZSA9IHNwaV9ub3Jfc3Ix
X2JpdDZfcXVhZF9lbmFibGU7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gIH0NCg0KTWF5
YmUgd2UgY2FuIGdldCByaWQgb2YgdGhpcyBmaXh1cCBob29rIGVudGlyZWx5LiBJZiBpdCB3YXMg
YSBkZWZhdWx0X2luaXQoKSwgdGhlbiBpdA0Kd2FzIHNldCBiZWZvcmUgdGhlIFNGRFAgd2FzIHBh
cnNlZCwgc28gdGhlIHF1YWRfZW5hYmxlIG1ldGhvZCB3YXMgb3ZlcndyaXR0ZW4gYW55d2F5Lg0K
V291bGQgeW91IHBsZWFzZSBjaGVjayB3aHkgdGhpcyBtZXRob2Qgd2FzIGludHJvZHVjZWQ/DQoN
CldoYXQgUXVhZCBFbmFibGUgbWV0aG9kIGRvIHlvdSBnZXQgZnJvbSBTRkRQPyBJIGV4cGVjdCB0
aGF0IHNwaV9ub3Jfc3IxX2JpdDZfcXVhZF9lbmFibGUsDQphbmQgdGhlIGZpeHVwIGhvb2sgdG8g
YmUgaW4gdmFpbi4NCg0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMg
Z2QyNXEyNTZfZml4dXBzID0gew0KPiAtICAgICAgIC5kZWZhdWx0X2luaXQgPSBnZDI1cTI1Nl9k
ZWZhdWx0X2luaXQsDQo+ICsgICAgICAgLnBvc3RfYmZwdCA9IGdkMjVxMjU2X3Bvc3RfYmZwdCwN
Cj4gIH07DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIGdpZ2FkZXZpY2Vf
bm9yX3BhcnRzW10gPSB7DQo+IC0tDQo+IDIuMzQuMQ0KPiANCg0KDQotLSANCkNoZWVycywNCnRh
DQo=
