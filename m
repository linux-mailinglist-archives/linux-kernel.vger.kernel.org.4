Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC185748662
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGEObq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGEObp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:31:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C2CF;
        Wed,  5 Jul 2023 07:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/IBpFsVLoN2dlpVcEfFERwMuq6EAhgRxvr9P5QFOBxgp5UNmBhrMGMwaCcnP8YFtpG81IV2DKQOzUz4ijQuUroHU6NIQx8TziwheEeGh+JlBO8ZN9H47v/95b/LMX9x8T4EMESdDZMqHAnULSz+d4WXMkl3/37a8Sbcj26o6gTMpoxQ9AA0ct5QxJ/11zVDXUkX26ozlGYK+nUHBuYNi85OiFaSOLq4MTA1p6wJh9LCX7BXLAyfx2iYqT8G7B5/g7iW7NooMwIErrLvjzxYFHZ0p5s4qLjqTgqJnLPhFsIvyhZO24HSZboW5uO2dX4LSfcHbX0z4gZlZJ9y2yvdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BOQA0O9GtVueLuoaSROb4sRY7fVHYytU5yfB/tr7II=;
 b=iK13D3wfp9/S4GriN2dkxb82cTP3yb2xdIZiWqYjCk50fZdmwhk1nCMyMUAzvsMbiZGTyD8TqjdXkC+UNmKlS5YgLR8o3mwra3EPeGIGW4MowEbqFWwAWC96WphO6LR4oqq7tPrkeGhBwVlXQb8WO95VbCAhjIqRv7hk/SjrI0WgMWwOtv8KIH5M+Uc6K8fzd0wZeLDZFqgNOeJIwftpJvTJMKPiu66mX7dWVf/6+ITMqt4combIpoZKaVhTUaebA52ojg/AAxIkLARqTv1jrqXYtADFIdzcBcRSS3U2Hu3OVnieln3IexvWAcv/LhLIEZePcPGZPe68J5Ez+/sKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BOQA0O9GtVueLuoaSROb4sRY7fVHYytU5yfB/tr7II=;
 b=CxPj+GZ/Q7eI2eBum6CKiroQh8tr8ojUy4EfFRbfyaOr1ttVyAFCK6iBMhUaea9vzem6iLMNI20d/dZVQ2kElf0NTqlx73jNnETbnxgaPvCARuUv18Sj6kDFDw4JhMN25BGcURV95VvB2c6o/IcNsjQI9eojGPvyhmqfx8AWvw39GIqaIdddScIhmHd7/uHuwJaaZdCx35MaGAClut9qUhuxsbu3bRt8n9og7ytna/n9PSIaoHzGK112UyeAJ6Vq5sUcdzpVERwYZ2MdlX1dzLsRbP0dh4q7fhkYvHE//b6pFLi9BXWsg5rtMaedUjW0R746kGPIbM7MpYikEr/YGg==
Received: from AS2PR08MB8808.eurprd08.prod.outlook.com (2603:10a6:20b:5f4::14)
 by PAXPR08MB7352.eurprd08.prod.outlook.com (2603:10a6:102:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 14:31:41 +0000
Received: from AS2PR08MB8808.eurprd08.prod.outlook.com
 ([fe80::88d8:ddec:561b:c061]) by AS2PR08MB8808.eurprd08.prod.outlook.com
 ([fe80::88d8:ddec:561b:c061%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 14:31:40 +0000
From:   Nate Drude <Nate.D@variscite.com>
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
Thread-Topic: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
Thread-Index: AQHZrpVBPm+/gN/VEkSHlntmlBO4DK+p05CAgAAByACAABF6gIAAK+EAgAAF7oCAAAcGgIAABiQAgAATnoCAAPRygIAAAK3AgAADNYCAAAoQAIAAAama
Date:   Wed, 5 Jul 2023 14:31:40 +0000
Message-ID: <AS2PR08MB88085D6B7338AD6D4D3C9956852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
References: <20230704150240.2022020-1-hugo@hugovil.com>
        <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
        <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com>
        <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
        <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
        <20230704125541.f361cab8de3faacd830418ab@hugovil.com>
        <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
        <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
        <20230704164140.824f6890dae5c87fc92531b4@hugovil.com>
        <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
        <20230704172801.f11422b3f947c625f53af871@hugovil.com>
        <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
        <CAOMZO5AZiuEAh6nJB8Oub83At6bsvLhzOhsT_yOniZSucrAUMQ@mail.gmail.com>
        <20230705093507.7458eada3ae05e0e1740a10e@hugovil.com>
        <AS2PR08MB88082608DB46EC1287C6E54B852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
        <CAOMZO5D-a4sUEqqsppjpgkCRFfeetY32+QP0CvrGw6v5q=J+KA@mail.gmail.com>
 <20230705102502.d8c9fa894bd271a5526d81f7@hugovil.com>
In-Reply-To: <20230705102502.d8c9fa894bd271a5526d81f7@hugovil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR08MB8808:EE_|PAXPR08MB7352:EE_
x-ms-office365-filtering-correlation-id: dd912996-a2de-4aa1-0aac-08db7d648c71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h46ncdXkP3xwXk2QV/b/GsgNrem5ckvbMgZllBR5EapjDuBy6cvjasxToUNxgRaOloenVgBMfiX2kEmDLdFBMwA8ojxypOF6ckul7P/4Da5H4oRn/Gm8ZVQZZh84M1AMHl4dxVogvwsN3RNngcs0fahK6bNgNDVE2CiG4K7FnAXtwJ4nLcw9yR8quNQohW+WYP3wIWqFyk3CbeXIdBCgh/4UKHYBV5BTrht3xTjyBxxXKR/uEWMaF1M+3zIFbUj9sWoWh74go8UP2iEmLCkqoheLmrwrFObN3TEFhaJtOe32K0kfqh6EsgXgzPrJ6xPhEwF9p4GBgyU1samkU7J+agMsGhDsg1V1PcxNtl+mC10BqQoohqhKUVbavTtpGGvFhGFXgsTExS1Sihd0rmUlXGpJvKG4agkJ929uZu15wbMSx4UpE+GJSev5zF0XXLN/nFsgL+RAGkByTbwu1J2VG7p04eCczOXBVpC9PpSbVwbvQNZLNo64nY5lDXl0YGSxl5L+QpX+kNIGbpkuYHwGAC96PrO9Pw49BfBtz4mE/eLFrOVJ9RQFOa6qap7hQ3hip87DY+kYNjvzD0rUO867PNG7y3V/IWesrlRBRBULw4knXfXsNcYF1Dp9AoJU2yKc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8808.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(451199021)(41300700001)(86362001)(38100700002)(122000001)(83380400001)(71200400001)(53546011)(6506007)(26005)(9686003)(966005)(55016003)(7696005)(110136005)(54906003)(38070700005)(478600001)(316002)(66476007)(4326008)(66446008)(76116006)(66556008)(91956017)(66946007)(33656002)(64756008)(8676002)(8936002)(186003)(7416002)(52536014)(2906002)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0FlYU5hUHV3Ull4THJwd0tjM1JPWWpmOGdtUXk1NEZvZFBXSWt5MjBaNEpW?=
 =?utf-8?B?ajNlRTJxM2p6bzdnQkFtOFRYMEluT2hoYUU2QWNiTkNleWg3MzI5RmdBanVm?=
 =?utf-8?B?bTF0WThwZjMxNUJWQXZPcXBaU3JkaGZCeXdrYUFEWHVpSXYrNC9vRzg1NFN1?=
 =?utf-8?B?ZWovY1lLY2ZHZ2lPL2Rnb2J4ZjhheXdlcngzTXk0dVBDZkpHaDcxaVdzbUVs?=
 =?utf-8?B?TkN2c2xZUGFxdk5XUWFQVkxrT09YMXAyQ3ZabE5OdTFRYVRnOGtJTWI2aXUx?=
 =?utf-8?B?aTE5OHdZdkRCU0ZFbnFuZ2tiNnlZcXpVSGhZa0MvUElJdGhENDExZzlPZHhT?=
 =?utf-8?B?WE9hZFU1MGhaZEozWFRSanJjbzQvbld2Wk1yek9nL2RNNXBvV2QyRU5DclhW?=
 =?utf-8?B?dWdzdXNmdEphV3RZalVwZVFkbzN6SjllVkVkL1dJays5NGJ2ejZSS3M0dDk1?=
 =?utf-8?B?eE9mZmhhRnNocDRsSnJYUjMvQjIzenNvNEl5b0tFbVA5Q1BlTlRzWTAzeW1C?=
 =?utf-8?B?ajdyTVJEV1lCNWYxTmpqMHBycXlmN2ExQlRWYkU5VkVtNWxKZk50dXZCSFJW?=
 =?utf-8?B?blNzK2FtMG9zZnlVeEJuKzJmOXBNY05WUW9ZN2ttTHdZd0hCWXk1em5oRDFK?=
 =?utf-8?B?Wk8vc3l0VmpjdWJqZXJkaGF5YzRDWisrTkpZL2ZSaW1JNDRVbjluSnlZMEM1?=
 =?utf-8?B?UnJmL2YvejcrSThicHZVa1ArcWV2YTdiQ2Q5K0M4UStjQWF5ZG5ZNUhsNmNY?=
 =?utf-8?B?TkpHejlZUDgwQ1NwZUZWUnlUdlRSRlhQcFVza3o5SW0yOUNSYmRUcklieWlZ?=
 =?utf-8?B?TlNPMjdUbUtWWG1jM0h5MTYxc2ZCaEVua2t3Y20rckx2aDVSZ01GR25OWHdy?=
 =?utf-8?B?eERyR3dnY2RvakREQUU1RitYTEpUamIrdUxOcHhiZGprWjBBSmNtdGpqS0RP?=
 =?utf-8?B?QjFoWFdGK3c3MzB0eDZsUCs0R2JoV0dyWFdKaEM1TjhrbUdmZTVkVHRjRitK?=
 =?utf-8?B?dlhZUlJmbXhyaFhMS1lPZ3RZREtTSGRzR2Y5MVMvcHVzaWlqWGg4UnhSU2RM?=
 =?utf-8?B?cnQyNnBuTndFMGgyY1FVT0NSSHAvLzFzcStSZy9xR0NSeHgyUXcxN0Q5S0JE?=
 =?utf-8?B?eXhaSjFFZWI2VXBKZkpXNTVMN3ZtRXhvRVpMYkFaOEY2cUdBaGl4dktkQ0dM?=
 =?utf-8?B?V0hwdThnbkRCQUJWc0VmNkJsRXZvUVJONGFvZVoySjhOVGM4bjB1NGYwa3l1?=
 =?utf-8?B?SmVyU1EzcUJkc1U3TkErV0dVUk5Uazk5Rit4YndwMFI1ekVvWWlTYWtIMDJN?=
 =?utf-8?B?cEJTMG9iRExhZDRQd3BHMmx4Nm9qL0JaVExIQjVLSkxBQlhWZjZBanBnYTVs?=
 =?utf-8?B?OG84M2hlRU5DZkZTT1Z1TTBSWWx6VTRwTHVGWFFYcG94MWJWbG1wMVBqd0lF?=
 =?utf-8?B?VDJycE5jRFI3d1NDMC9rNzVzQ3Y4Rk1za0QzbGpzUGpqT2EwR1JhQnJ3akFC?=
 =?utf-8?B?RndpbXE1U1dGNGdEV2x0Y3RoWTBrbjdTY0tVSHdMNis2VWM1aTBzOVMweFcy?=
 =?utf-8?B?bGhicmZjQ2FxVTkxTUxiR1Frc21RVVpnbThNVEhXMkRMRFhLUFlwYWxleUhU?=
 =?utf-8?B?LyszRFNVTjQwcXBqVnJzbkQrak1zUzVkQ3dFcnZaY3diZ29OMW5rZE1HK3BQ?=
 =?utf-8?B?YWtKTzdrL2RYRlBDem9IeC8yQjBvbmVXNXFZNlJWd0xBNzBHeFFhM25BNzdo?=
 =?utf-8?B?RWZuTjR2OW5JSHMvUXJJU20yWVZVK2w3V3R2Qk11MU1vRDZxdEd6STAyS3Rx?=
 =?utf-8?B?NWtLWlZ0Qm0wV1UvdktOeVVhdWsrZnFpOUFsamRpK3RObkR0SVBJTk05bWEr?=
 =?utf-8?B?dUNuNStCZkgxYWJsUzVtbVhWblozM1Zyenk4NUNpMkFKSzQ4NGwrVUx0OFU2?=
 =?utf-8?B?UXphVkxnMXE4Z0VQWEpBTlJEY2RRYW9vdmNNd0ozZjd0dUliNWhPWlVMSm9D?=
 =?utf-8?B?NDFBa2Z3TC9yRW5naVlJbkNRdEE4RnhoRHhRdjV3YzBCZUpZSW9UZGRmanU4?=
 =?utf-8?B?RkZjNkVtSUNxT1JNQ1VCMjkwZXZnaDRNTTc0TzNSbEJ0aUxVU3BnTEdCQ0Ez?=
 =?utf-8?Q?6NBQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8808.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd912996-a2de-4aa1-0aac-08db7d648c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 14:31:40.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Ed6KlmlDmTksLXKXSlaFO9wlNS8fInc71fI3NcfU0NAi40ooUctbX0RAQuIb3l0ve2GraIEiCDZ1j0kOwO7xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7352
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSHVnbywKCk9uIDcvNS8yMyA5OjI1IEFNLCBIdWdvIFZpbGxlbmV1dmUgd3JvdGU6Cj4gW1Nv
bWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWls
IGZyb20gaHVnb0BodWdvdmlsLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0
dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdCj4gCj4gT24gV2Vk
LCA1IEp1bCAyMDIzIDEwOjQ5OjAxIC0wMzAwCj4gRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21h
aWwuY29tPiB3cm90ZToKPiAKPj4gSGkgTmF0ZSwKPj4KPj4gT24gV2VkLCBKdWwgNSwgMjAyMyBh
dCAxMDo0MuKAr0FNIE5hdGUgRHJ1ZGUgPE5hdGUuREB2YXJpc2NpdGUuY29tPiB3cm90ZToKPj4K
Pj4+IFRoZSBwYXRjaCAnZHJpdmVyczogZXh0Y29uOiBwdG41MTUwOiBBZGQgaXJxLWlzLWlkLXF1
aXJrJyByZWZlcnJlZCB0byBieSBGYWJpbyBpcyByZXF1aXJlZCBmb3IgT1RHIHRvIHdvcmsgY29y
cmVjdGx5IG9uIGFsbCB2ZXJzaW9ucyBvZiB0aGUgU3ltcGhvbnkgYm9hcmQuCj4+Pgo+Pj4gSSBj
YW4gc3VibWl0IHRoaXMgcGF0Y2ggbWFpbmxpbmUsIGRvIHlvdSB0aGluayBpdCB3aWxsIGJlIGFj
Y2VwdGVkIGFzIGlzPwo+Pgo+PiBJIHRoaW5rIGl0IGlzIHdvcnRoIHN1Ym1pdHRpbmcgaXQgdG8g
Z2V0IHNvbWUgZmVlZGJhY2sgZnJvbSB0aGUKPj4gcHRuNTE1MCBhbmQgRFQgbWFpbnRhaW5lcnMu
Cj4+Cj4+IFRoYW5rcwo+IAo+IEhpLAo+IGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoZSBp
cnEtaXMtaWQtcXVpcmsgZGV2aWNlIHRyZWUgcHJvcGVydHkKPiB3b3VsZCBiZSByZXF1aXJlZCBm
b3IgbmV3ZXIgRVZLIGJvYXJkcywgYnV0IG5vdCBmb3Igb2xkZXIgYm9hcmRzLgo+IAo+IEhvdyBj
YW4gd2Ugc3VwcG9ydCBib3RoIGNvbmZpZ3VyYXRpb25zIHdpdGggdGhlIGN1cnJlbnQgZGV2aWNl
IHRyZWU/Cj4gCj4gSHVnby4KRm9yIHNvbWUgdGltZSwgd2UgbWFpbnRhaW5lZCBhIGxlZ2FjeSBk
ZXZpY2UgdHJlZSBmaWxlOiBodHRwczovL2dpdGh1Yi5jb20vdmFyaWdpdC9saW51eC1pbXgvYmxv
Yi81LjQtMi4xLngtaW14X3ZhcjAxL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bi12YXItc29tLXN5bXBob255LWxlZ2FjeS5kdHMKCkhvd2V2ZXIsIGl0IGlzIG5vIGxvbmdlciBi
ZWluZyBtYWludGFpbmVkIGluIG91ciBuZXdlc3Qga2VybmVsIGJyYW5jaGVzLgoKUmVnYXJkcywK
TmF0ZQ==
