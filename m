Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B064E8B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLPJij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLPJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:38:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A026554;
        Fri, 16 Dec 2022 01:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671183515; x=1702719515;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=dfCuKd+0vYUzfGZcdnKggnRbPQ4m56jeZHqbVigtdrM=;
  b=rg6ZfycmIvSn1oZz4xL4LhwegsOk6bsOhdCqv6gSnl/YaV/Of944g3Jd
   0eFOT1plDFdz1kPjOZ89vzqR/4YTlCLq5dWuH5//rWOwi3Ss9DhKPyZ7w
   pWHe8XZVWkcjaoBBRahSqSnMV5+EyR4RJgk645CLrI05ICrLmV52ALqlS
   zw6E3wYFXCiblKXEi8/a6Dq88piHvpe8PVXmxzokBsNAQr1cRF5o3L67F
   aC+i0GTHRwEA4Tvky8yeMcHecU8aXVAV9AIVWhGdx+hN5bZ1O5ZReQ4eb
   ireA4c4H24MGIg+lqUJf1d52bwoMyHRouaUzx5vna2n03xSK1XO8yocSK
   A==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="191997207"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2022 02:38:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 02:38:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 16 Dec 2022 02:38:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyINUn2D/4ROTh5vWu8yduefHXRHNpS09AufVQIT2YykLnTsFvM+JgXMZjoRB0rSfhaHi4saaZf0HWqi7xmwqVjBbO3IS7jtVziqrx6Nj8H4jSJFo9kIn54tPwE/ib39hyz6q01T7wQi1jH/vRvgwmsjis8LlcOsxYbebl4VWzgPM3dnf0CIVIEFwBIUj9EW6pP858/TwP3APR+tzl+tL3kwbFc99S694+iCnvt+7F6LXLh7Abr/67AQWRSAmI0zHQy0YjMjGmjqgkouBuMEGOhvBO9Z/Jr1wkAXOUpKaL7ysGhX0uUpE8ELa3l1cAxlSFWhNPMiVf34YLPVzyQWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfCuKd+0vYUzfGZcdnKggnRbPQ4m56jeZHqbVigtdrM=;
 b=WPWoJ4J4CS+THARLHUaWnkOqENz9W2C0pVAlA+ZKSjK3SERcosTspGY3CvRDpv9o3XAsJDOIsGbKV/j338mSLAXfMcX7zSwaYSDY6OXZ1rRNCDMtOpWeDlr8S7RQwi2gB3mydTH41UTFHoaERzGN6cIPug4YhK3qPKkBmbiEBOhAtqsFdN9dXvZnzDY5PX9osvZq3yfKqHdl5ZOYl0kwvZCNGr26ete/YG4KbhKi0ymbY580BczUzOibGG1s2XZ8EP1kzqELMUtpYwEwd9vDBnJy8e8Z9/l4fPOFYV/kofGhx5tTq5dM6FyZ4w1zoYtIQpV+hc0pEac/Jm8HcS4BTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfCuKd+0vYUzfGZcdnKggnRbPQ4m56jeZHqbVigtdrM=;
 b=SbCIpc26fM7/yns25gWsmWgUMbng8RtbKOiMnOdnhxcSEpTGbX0N/XJSgd5t7FKmZM5hDu8sw/eeF5wARDImY8IM2c9Uy8mWUidTtnADrrNSW0yOmUFJa4nJLxsFXCWN0rGaDtQXZj7zLDs2BajcGQZpMdI/DlRYOqGAt46PbWA=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 09:38:28 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf%3]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 09:38:28 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Manikandan.M@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Dharma.B@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <Jerry.Ray@microchip.com>
Subject: Re: [PATCH v3 2/8] ARM: dts: at91: sam9x60: move flexcom definitions
Thread-Topic: [PATCH v3 2/8] ARM: dts: at91: sam9x60: move flexcom definitions
Thread-Index: AQHZETIml3Orcqj65EKC3tY39UXt+A==
Date:   Fri, 16 Dec 2022 09:38:28 +0000
Message-ID: <50d236ae-c3b7-70fc-f699-5ac9c9939b3f@microchip.com>
References: <20221213120655.672666-1-durai.manickamkr@microchip.com>
 <20221213120655.672666-3-durai.manickamkr@microchip.com>
In-Reply-To: <20221213120655.672666-3-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|MN0PR11MB6280:EE_
x-ms-office365-filtering-correlation-id: 292fc4c8-3535-44b4-6b74-08dadf494966
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1T9fsAnpTpm3mamECmW25XcElyUO+hzGkg0Cdf23hqCSOLm/boluhzn7wf7yOkIQ1qj5Lny0O8uwaj4mB1pp42egn7bDnpwU9y7d53qEIQPn7ZZCRxbJ6CDI2LKiEg1bLsw9njjFqIYtG56r2H6uvKoFj/g20jm67PyHsBLvWFWc+Pb9ybx1uF8LfDTdrXAuTwh/TJEiN0zDwWNfHsMn5kvzuzsLDhs0lvJSQKIoK72DJMm1K6HCJPLiy0VzH4o0Q+KklEvK1NMmXycCjPwBORiDIugNVNM6IEwPV+Ig7cW9zOZnhiGV/pDDqdfeNlYwXJiExasPwfdB9HxBV5Q/YHEC7QX0kSLgkoWPImIG1JAQ1PGPWYCOt41A58BKWNIftyIvvx4yh9XjQGpyekoqsMAa2xG+86i+gMvcgvLwCdW9aZUuo9FbIJ6NzSD8ewqkDlfdgGe/Xyhqj7DDJWkdBptF9/y4rM4pVq4fiNLcY/MXsypGNvzOb67pOHhkcZaoD46m5xqQgqoBYw7Buo21ONCYVl2QEBb601xi3sG5Dzfef/bJ3ODsIw37va8mHczfKv9nDrf5FmY5Z1RYao3TBX35av1iKHpSCQxhKe4C5OANJqO9Fsv81x4bjwdqX17kHXpek8s2BBl1M4lBe/RWg+uMCxl1ekkQFyNFTZq3lre+7bjQQVwDna0x3qtI1P7NAfy+tW7U3UP29TyCose97t1w8sZbiYU4FFxm+Zc83qxzj1ScsvU1cfsBGDbS5BAYpV/xTBzsT0zWi2UvPRr4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(64756008)(2616005)(66556008)(66946007)(2906002)(66446008)(76116006)(66476007)(36756003)(41300700001)(7416002)(5660300002)(83380400001)(8676002)(8936002)(38070700005)(31696002)(86362001)(921005)(122000001)(316002)(478600001)(38100700002)(6512007)(110136005)(6636002)(26005)(186003)(53546011)(6506007)(6486002)(31686004)(71200400001)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnBJekF4L3lZMGluVEZjU3ppV1pzNW44WnZ4TzlUdVJSb3RKWFdGWXFwTUdK?=
 =?utf-8?B?cmF4aTNpZzVTM3Y0SGYzbXR2QXVXaE1QbmNaNnpuSG9uOVp6OGQ1T2xnQTdm?=
 =?utf-8?B?N3AzblVHOXhhNXkrZEdnQTVHRnJ6QnBaTkJITm95ZTJsY1JBSHc0NWxqRmtO?=
 =?utf-8?B?R3Brb2NmZEdOQ25Iem9LT2RFMHBlZklFVFZld1VrKzUwemlQT1h0eHhmeUlk?=
 =?utf-8?B?empmcllOVDl4L3k5NStrNUF1c0NRVU1wb2VLV0Jqa2pUendBOU9QVG1BTVJo?=
 =?utf-8?B?YlJ3ckxrZGhHS1JJTW9UTU9zRTM3dXhBajI3R1l2U0JSV2pHdzN3UTZtNTFz?=
 =?utf-8?B?RFZpWkNqOCtYZTZXTWZVcmFwYVBpYTFPN0poTnlpa2EzczdnL0w5dGIzLzNG?=
 =?utf-8?B?bGV4blZMQzdVUmRNdGVRdGZMNU1WTGtLVUlYdFk4dk5ydDJ5L2FKVk9lL0sr?=
 =?utf-8?B?VEpVWFVycks0WDV6cWVxMnhoRWhuRDVCYVhZWjh2NFVGM0E3bUFWMEw2ZkV1?=
 =?utf-8?B?cUhrNEphYy9DbWswdDhkbGliZDFnc2MvaHkxUlJkNFNDVGN5WDJLVkF5TzJ6?=
 =?utf-8?B?QmpzSSt5MmoySFMzTVJkNStsMDlaSlhsQ3l1LytiS2dzd09taWVaOTFKekVu?=
 =?utf-8?B?dVQ2ckxKWk9VNnVSSndIakVldFVFTFRXK0QvNm1qOWROUHIwVWJKbkRxWmZQ?=
 =?utf-8?B?N0NNWWprVjRSM21LeUdzRUNqWUxabUtqUjBXeGxsbWlmSEV4RXN5NnJFaWlR?=
 =?utf-8?B?cHRWUFRnSXZURnVhSGZtQ3dCNkpzbGlUTUZXaStjbUhUQkh5dWpsS1dndm51?=
 =?utf-8?B?NWtkY0hhQzdSQy9NQ3FYSURuOUxYKzIrTHZYdVhHMDlvRTZESmU5TkYyM3Jk?=
 =?utf-8?B?a0JpbXcrcDEzb2JmU3IreHpGVUdqbyt6TVVJUzU2Nkt3eGtXRUFMakxTZWEv?=
 =?utf-8?B?VXIxQSszbyt1Sk5nWjZEY3BVbkxJekpGa0VmL1pMeHNzbzVyamNlaTFEb01Y?=
 =?utf-8?B?YjRhUU9yTDFPMHVhYStzNHYzeXgxKzdNajFRN1ZGczRPSjUzdVRab0JOM3dN?=
 =?utf-8?B?cHhHbVdldUtHWURHMXBwNDJFR0l2Yi8rV2M3N2dOcndhdVhoVUNMSXJsZEZ4?=
 =?utf-8?B?enlBVXYwRnB2S2x5cVVTbnFyOGFrV1BDUEhKOFB0eGY5aUxYbmJld0hSejBt?=
 =?utf-8?B?WGtYUGpnelY5YitmcVpmKy9hUG43NlU4dUN3eTNPVFY0K2ovbzZoYkltczlq?=
 =?utf-8?B?RGJzdWR1Q1JVcEpla3ZPVkx1MVZrNmt4TDZBbVRxSVVCcGRiSnNVTDdpd0FV?=
 =?utf-8?B?UmZVZGhscUtSaDFTaWJtMDVTc3BOQUtDSlJKM0ZId2F3SUs1TE5vRlNIMVlC?=
 =?utf-8?B?aGtYdGNCS05YckxOL1pxVjdqd2VRbWhUWUJUL0NnUlRvUDdxbkt2T2dVWXB6?=
 =?utf-8?B?aktDY0ZsRk82ZndrSkNGcUFWNFNUeTJaR1d2TGYrMWhLVEhQQW84cTlwZXdq?=
 =?utf-8?B?UnA4bVpubm8veVc0blpsT1dUUENaazM3MFZ6SjJaTHNIbGdKb3luU1hBbWdM?=
 =?utf-8?B?dVFLWU5vd1cyZUdEWU1WMzM0d3RabDlpalJKZVNldWZzeDA5c0gxdldNOFNk?=
 =?utf-8?B?VHlCTXpCQkxTVWtOSWFCL0RCaVU2cU9KUlo1UWtQZWxYa2NON3RhUUptc1hw?=
 =?utf-8?B?YVY1NWYxdUQramxQMytvUXFJQ0FCblFwQ1FtSlkwYlZhdWpaNlN5SUJ1eWMw?=
 =?utf-8?B?akJtdjRMS3FxSkMxaFplNjhwUHhpT2ZPcXJaWk5XYTZ0QmJUcXlIeE5wWUpq?=
 =?utf-8?B?YTNDa1R2dnEvZUdHNnBkVnRkSVNjRDdHQVgwZTM4R0VLNzdtcUgydUplWGg2?=
 =?utf-8?B?R1VEZ2hYVlArVXQ1ZTJNRGNteXRJQncwai9XdDJrcHhxaWpON0tnYXU1cy80?=
 =?utf-8?B?ZWdMcGp4Vm5uTUFmY0xxL0owNHBqc2ZhblFXbkpKUDNUdExiUGVqNVIwL3Uw?=
 =?utf-8?B?TGMvejBRczh2alYxWnB0SU12Ujg2dnB3VkxSclJqRWIzVkM5VWRiTk5PS0Iy?=
 =?utf-8?B?YkoreVRNVVgzOHBLbkp0QXNwMFAyRzBSMldONlhJa281MHd4MmZ1QnlRQk9N?=
 =?utf-8?B?dTBHd1g0V3lUTTFiZ0dnUGcyYW1Tc1dCOFNLTG1GSjV1RURWVitmUTFVWXk4?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95C023FAAD9EC54283BFAF992F77B57D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292fc4c8-3535-44b4-6b74-08dadf494966
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 09:38:28.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3ojcwx3cAiU8gdc9gw8ihRKeN6l8bz8ztkyrGGPAPaf0dUIpyaZkL4Cb8fUKpGAVTGrnfMXjt2fPkyhOViSNQr8sNJL7IovCtD8Ctxl6oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6280
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMTIuMjAyMiAxNDowNiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEZyb206IE1h
bmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCj4gDQo+
IE1vdmUgdGhlIGZsZXhjb20gZGVmaW5pdGlvbnMgZnJvbSBib2FyZCBzcGVjaWZpYyBEVFMgZmls
ZQ0KPiB0byB0aGUgU29DIHNwZWNpZmljIERUU0kgZmlsZSBmb3Igc2FtOXg2MGVrLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4gPG1hbmlrYW5kYW4ubUBtaWNy
b2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYXJpIFByYXNhdGggR3VqdWxhbiBFbGFuZ28g
PEhhcmkuUHJhc2F0aEdFQG1pY3JvY2hpcC5jb20+DQo+IFtkdXJhaS5tYW5pY2thbWtyQG1pY3Jv
Y2hpcC5jb206IExvZ2ljYWwgc3BsaXQtdXAgb2YgdGhpcyBwYXRjaF0NCj4gU2lnbmVkLW9mZi1i
eTogRHVyYWkgTWFuaWNrYW0gS1IgPGR1cmFpLm1hbmlja2Fta3JAbWljcm9jaGlwLmNvbT4NCj4g
LS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMgfCAzMyArLS0tLS0t
LS0tLS0tLS0tLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSAgICAgICB8IDUw
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTEgaW5z
ZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05
eDYwZWsuZHRzDQo+IGluZGV4IGNmNWQ3ODY1MzFmMi4uNGZmODQ2MzNkZDQzIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IEBAIC0yMDcsMTUgKzIwNywxMCBAQCAm
Zmx4MCB7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgDQo+ICAJaTJjMDogaTJjQDYwMCB7DQo+
IC0JCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtaTJjIjsNCj4gLQkJcmVnID0gPDB4
NjAwIDB4MjAwPjsNCj4gLQkJaW50ZXJydXB0cyA9IDw1IElSUV9UWVBFX0xFVkVMX0hJR0ggNz47
DQo+ICAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAgCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4g
LQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA1PjsNCj4gIAkJcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsNCj4gIAkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZseDBfZGVmYXVs
dD47DQo+IC0JCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+ICAJCWkyYy1hbmFsb2ctZmlsdGVy
Ow0KPiAgCQlpMmMtZGlnaXRhbC1maWx0ZXI7DQo+ICAJCWkyYy1kaWdpdGFsLWZpbHRlci13aWR0
aC1ucyA9IDwzNT47DQo+IEBAIC0yMzUsMTQgKzIzMCw4IEBAICZmbHg0IHsNCj4gIAlzdGF0dXMg
PSAiZGlzYWJsZWQiOw0KPiAgDQo+ICAJc3BpNDogc3BpQDQwMCB7DQo+IC0JCWNvbXBhdGlibGUg
PSAibWljcm9jaGlwLHNhbTl4NjAtc3BpIiwgImF0bWVsLGF0OTFybTkyMDAtc3BpIjsNCj4gLQkJ
cmVnID0gPDB4NDAwIDB4MjAwPjsNCj4gLQkJaW50ZXJydXB0cyA9IDwxMyBJUlFfVFlQRV9MRVZF
TF9ISUdIIDc+Ow0KPiAtCQljbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDEzPjsN
Cj4gLQkJY2xvY2stbmFtZXMgPSAic3BpX2NsayI7DQo+ICAJCXBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7DQo+ICAJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mbHg0X2RlZmF1bHQ+Ow0KPiAtCQlh
dG1lbCxmaWZvLXNpemUgPSA8MTY+Ow0KPiAgCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJ
I3NpemUtY2VsbHMgPSA8MD47DQo+ICAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IEBAIC0yNTQs
MjMgKzI0Myw4IEBAICZmbHg1IHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICANCj4gIAl1YXJ0
NTogc2VyaWFsQDIwMCB7DQo+IC0JCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtZGJn
dSIsICJtaWNyb2NoaXAsc2FtOXg2MC11c2FydCIsICJhdG1lbCxhdDkxc2FtOTI2MC1kYmd1Iiwg
ImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0IjsNCj4gLQkJcmVnID0gPDB4MjAwIDB4MjAwPjsNCj4g
LQkJYXRtZWwsdXNhcnQtbW9kZSA9IDxBVDkxX1VTQVJUX01PREVfU0VSSUFMPjsNCg0KWW91IGxv
c3QgdGhpcyBwcm9wZXJ0eS4gTm93IGl0IGlzIG5vdCBwcmVzZW50IG5laXRoZXIgaW4gZHRzIG5v
ciBpbiBkdHNpLg0KDQo+IC0JCWludGVycnVwdHMgPSA8MTQgSVJRX1RZUEVfTEVWRUxfSElHSCA3
PjsNCj4gLQkJZG1hcyA9IDwmZG1hMA0KPiAtCQkJKEFUOTFfWERNQUNfRFRfTUVNX0lGKDApIHwg
QVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPiAtCQkJIEFUOTFfWERNQUNfRFRfUEVSSUQoMTAp
KT4sDQo+IC0JCSAgICAgICA8JmRtYTANCj4gLQkJCShBVDkxX1hETUFDX0RUX01FTV9JRigwKSB8
IEFUOTFfWERNQUNfRFRfUEVSX0lGKDEpIHwNCj4gLQkJCSBBVDkxX1hETUFDX0RUX1BFUklEKDEx
KSk+Ow0KPiAtCQlkbWEtbmFtZXMgPSAidHgiLCAicngiOw0KPiAtCQljbG9ja3MgPSA8JnBtYyBQ
TUNfVFlQRV9QRVJJUEhFUkFMIDE0PjsNCj4gLQkJY2xvY2stbmFtZXMgPSAidXNhcnQiOw0KPiAt
CQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmx4NV9kZWZhdWx0PjsNCj4gIAkJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsNCj4gLQkJYXRtZWwsdXNlLWRtYS1yeDsNCj4gLQkJYXRtZWwsdXNlLWRt
YS10eDsNCj4gKwkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZseDVfZGVmYXVsdD47DQo+ICAJCXN0
YXR1cyA9ICJva2F5IjsNCj4gIAl9Ow0KPiAgfTsNCj4gQEAgLTI4MCwxNSArMjU0LDEwIEBAICZm
bHg2IHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICANCj4gIAlpMmM2OiBpMmNANjAwIHsNCj4g
LQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1pMmMiOw0KPiAtCQlyZWcgPSA8MHg2
MDAgMHgyMDA+Ow0KPiAtCQlpbnRlcnJ1cHRzID0gPDkgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsN
Cj4gIAkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAJCSNzaXplLWNlbGxzID0gPDA+Ow0KPiAt
CQljbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDk+Ow0KPiAgCQlwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOw0KPiAgCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmx4Nl9kZWZhdWx0
PjsNCj4gLQkJYXRtZWwsZmlmby1zaXplID0gPDE2PjsNCj4gIAkJaTJjLWFuYWxvZy1maWx0ZXI7
DQo+ICAJCWkyYy1kaWdpdGFsLWZpbHRlcjsNCj4gIAkJaTJjLWRpZ2l0YWwtZmlsdGVyLXdpZHRo
LW5zID0gPDM1PjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRz
aSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaQ0KPiBpbmRleCA4ZjU0NzdlMzA3ZGQu
LjlhNWRjZjhhMmI3NCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5k
dHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaQ0KPiBAQCAtMTcwLDYg
KzE3MCwxNiBAQCBmbHg0OiBmbGV4Y29tQGYwMDAwMDAwIHsNCj4gIAkJCQkjc2l6ZS1jZWxscyA9
IDwxPjsNCj4gIAkJCQlyYW5nZXMgPSA8MHgwIDB4ZjAwMDAwMDAgMHg4MDA+Ow0KPiAgCQkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJCQlzcGk0OiBzcGlANDAwIHsNCj4gKwkJCQkJ
Y29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1zcGkiLCAiYXRtZWwsYXQ5MXJtOTIwMC1z
cGkiOw0KPiArCQkJCQlyZWcgPSA8MHg0MDAgMHgyMDA+Ow0KPiArCQkJCQlpbnRlcnJ1cHRzID0g
PDEzIElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+ICsJCQkJCWNsb2NrcyA9IDwmcG1jIFBNQ19U
WVBFX1BFUklQSEVSQUwgMTM+Ow0KPiArCQkJCQljbG9jay1uYW1lcyA9ICJzcGlfY2xrIjsNCj4g
KwkJCQkJYXRtZWwsZmlmby1zaXplID0gPDE2PjsNCj4gKwkJCQkJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsNCj4gIA0KPiAgCQkJZmx4NTogZmxleGNvbUBmMDAwNDAw
MCB7DQo+IEBAIC0xODAsNiArMTkwLDI2IEBAIGZseDU6IGZsZXhjb21AZjAwMDQwMDAgew0KPiAg
CQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJCXJhbmdlcyA9IDwweDAgMHhmMDAwNDAwMCAw
eDgwMD47DQo+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKw0KPiArCQkJCXVhcnQ1OiBz
ZXJpYWxAMjAwIHsNCj4gKwkJCQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC11c2Fy
dCIsICJhdG1lbCxhdDkxc2FtOTI2MC11c2FydCI7DQo+ICsJCQkJCXJlZyA9IDwweDIwMCAweDIw
MD47DQo+ICsJCQkJCWludGVycnVwdHMgPSA8MTQgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4g
KwkJCQkJZG1hcyA9IDwmZG1hMA0KPiArCQkJCQkJKEFUOTFfWERNQUNfRFRfTUVNX0lGKDApIHwN
Cj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1B
Q19EVF9QRVJJRCgxMCkpPiwNCj4gKwkJCQkJCTwmZG1hMA0KPiArCQkJCQkJKEFUOTFfWERNQUNf
RFRfTUVNX0lGKDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+ICsJ
CQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMSkpPjsNCj4gKwkJCQkJZG1hLW5hbWVzID0gInR4
IiwgInJ4IjsNCj4gKwkJCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCAxND47
DQo+ICsJCQkJCWNsb2NrLW5hbWVzID0gInVzYXJ0IjsNCj4gKwkJCQkJYXRtZWwsdXNlLWRtYS1y
eDsNCj4gKwkJCQkJYXRtZWwsdXNlLWRtYS10eDsNCj4gKwkJCQkJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsNCj4gIA0KPiAgCQkJZG1hMDogZG1hLWNvbnRyb2xsZXJA
ZjAwMDgwMDAgew0KPiBAQCAtMzc5LDYgKzQwOSwxNSBAQCBmbHg2OiBmbGV4Y29tQGY4MDEwMDAw
IHsNCj4gIAkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gIAkJCQlyYW5nZXMgPSA8MHgwIDB4Zjgw
MTAwMDAgMHg4MDA+Ow0KPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJCQlp
MmM2OiBpMmNANjAwIHsNCj4gKwkJCQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1p
MmMiOw0KPiArCQkJCQlyZWcgPSA8MHg2MDAgMHgyMDA+Ow0KPiArCQkJCQlpbnRlcnJ1cHRzID0g
PDkgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gKwkJCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZ
UEVfUEVSSVBIRVJBTCA5PjsNCj4gKwkJCQkJYXRtZWwsZmlmby1zaXplID0gPDE2PjsNCj4gKwkJ
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJCQl9Ow0KPiAgCQkJfTsNCj4gIA0KPiAgCQkJ
Zmx4NzogZmxleGNvbUBmODAxNDAwMCB7DQo+IEBAIC00MDksNiArNDQ4LDE3IEBAIGZseDA6IGZs
ZXhjb21AZjgwMWMwMDAgew0KPiAgCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJCXJhbmdl
cyA9IDwweDAgMHhmODAxYzAwMCAweDgwMD47DQo+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gKw0KPiArCQkJCWkyYzA6IGkyY0A2MDAgew0KPiArCQkJCQljb21wYXRpYmxlID0gIm1pY3Jv
Y2hpcCxzYW05eDYwLWkyYyI7DQo+ICsJCQkJCXJlZyA9IDwweDYwMCAweDIwMD47DQo+ICsJCQkJ
CWludGVycnVwdHMgPSA8NSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiArCQkJCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gKwkJCQkJI3NpemUtY2VsbHMgPSA8MD47DQoNCllvdSBhbHNvIGFk
ZGVkICNhZGRyZXNzLWNlbGxzLCAjc2l6ZS1jZWxscy4gVGhlc2UgYXJlIGFsc28gcHJlc2VudCBp
biBib2FyZA0KZHRzIGFuZCBzaG91bGQgc3RheSB0aGVyZS4gVGh1cyB5b3UgY2FuIGdldCByaWQg
b2YgdGhlc2UgMiBoZXJlLg0KDQo+ICsJCQkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQ
SEVSQUwgNT47DQo+ICsJCQkJCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+ICsJCQkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ICsJCQkJfTsNCj4gIAkJCX07DQo+ICANCj4gIAkJCWZseDE6IGZs
ZXhjb21AZjgwMjAwMDAgew0KDQo=
