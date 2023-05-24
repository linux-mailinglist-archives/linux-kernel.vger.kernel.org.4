Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A691070F05C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbjEXIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjEXIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:12:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17269E;
        Wed, 24 May 2023 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684915967; x=1716451967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q6SPjHCYnjHtTp9P57NIQsZKdmdNpTPluq5XT76Yah0=;
  b=MFPOfvMYl2LJv0Fp804m1SV3JxmETYCPFXZNt+DpUQZyb1gba9wlqisk
   rKxgEgf9+MbbI6V36fxU4b88nwN4s9C/KWOjI8rPGwEqOy4TwPTGHYhMe
   lzWcGgRK+NCpjShkPurDFqJipf4iccE7ymZhmpMFleYF19eou+Nd5qpVg
   QipvauW70ISXi3r0CCVGWFoo7MEC2Fc8E83p1l/z2LsXJgItytpHeztCW
   4PVvbcqAKt41PsiJ8A5DSdJw8C5YPXhyVIYNIgYBZdPtqFk2Tsll1eP1N
   1xUti8AkTNYdLEfJqfHt+uazNDzcjtwPSY3c2O7nLtSeam0u8Pubn4bDx
   g==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="215240717"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 01:12:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 01:12:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 24 May 2023 01:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgth0Za7RPm6TBQ1MgvyOAIscYh5i5hmdfiyb9C5igAkyY/+GjSgHc1mLXih7sDEB5SrhCITY+9+RdRPhuHFFf3jgHtfbMnXuydzGSvFiPgoIMAi7jWGnIn2M3o/Gg0FaoUo+zvDP3PVJBbZo/NV3+U89zINwp2n6mFQbiXH2y82VKxZWL/FhASoYZasKTc2droq3DbCR8S3Q2yTCwZthN1xVmub5EGX4jnqf3iebwXs3ra2xu7b0b3sLOc2plL9ibXrlkaUiUFsLGGJltJTd8hCZHU7Sp0CirLeH+1HLCoJTUn43BqEn0at9Q+8hbe/u83eRkOqwqk2ZqlsSDnFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6SPjHCYnjHtTp9P57NIQsZKdmdNpTPluq5XT76Yah0=;
 b=T3s25YNqdE6jfJspZHPPpVTxk+ZjlFLP9NYprGgTSqixRso/la9KVt51nTgAnL8XjO90FC2L7BN1YTB+MMnWDoNRDac58cj1H5pxHKmuA384CHCYDe5a5dhW9dhavcX0zVLnCGpn9x/kBC6F/CHw5m30XwpWbABnHde8zCNpB1ubPpyevODbcdF4MnEJLr7IDhxg7M8yuwvIqBBxixepIKRAw4YHqMoNaJg+i/OHoVCXOFKJ79HhVuN1VBmY6G7yQuqqZwmDNKpC9qCSzk4+65tapq8BRHYYggK1QKHaBN02G2i/ONdkt+Gp0+xjVaT8fzjfbU1K6O0lF9OZktWwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6SPjHCYnjHtTp9P57NIQsZKdmdNpTPluq5XT76Yah0=;
 b=DxS7XyzeQkRz7On0yzC2d44kLuq6oXuWjTiunQFEthtGUdFQSb8bNe3CbVnOHJaB4322DYNaWK95HxDtRdY0f0abyTdYSWUHMDYVq6sDW2XjVWoGxe9LDJ3/CpsG9SuqxGF1VuvCDIihlWkof04JAT60Z5sJd4LPNzVqidnxXEg=
Received: from SJ0PR11MB7154.namprd11.prod.outlook.com (2603:10b6:a03:48d::9)
 by SJ0PR11MB4926.namprd11.prod.outlook.com (2603:10b6:a03:2d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 08:12:41 +0000
Received: from SJ0PR11MB7154.namprd11.prod.outlook.com
 ([fe80::8052:da5b:3a4d:45a]) by SJ0PR11MB7154.namprd11.prod.outlook.com
 ([fe80::8052:da5b:3a4d:45a%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 08:12:41 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <conor@kernel.org>, <Claudiu.Beznea@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Conor.Dooley@microchip.com>, <alexandre.belloni@bootlin.com>,
        <sre@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: power: reset: atmel,at91sam9260-shdwc:
 convert to yaml
Thread-Topic: [PATCH 2/4] dt-bindings: power: reset: atmel,at91sam9260-shdwc:
 convert to yaml
Thread-Index: AQHZjheCKKu8qtf8yUipY0s4lN1vHg==
Date:   Wed, 24 May 2023 08:12:41 +0000
Message-ID: <e0c5cb71-af1e-e11d-7b8f-46a47a813d25@microchip.com>
References: <20230523061512.195271-1-claudiu.beznea@microchip.com>
 <20230523061512.195271-3-claudiu.beznea@microchip.com>
 <20230523-depletion-petty-978775d05b22@spud>
In-Reply-To: <20230523-depletion-petty-978775d05b22@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7154:EE_|SJ0PR11MB4926:EE_
x-ms-office365-filtering-correlation-id: 60a930f5-1dcc-4aff-e4c4-08db5c2ea539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AhWsndASRK4/gqi7R9RPPQMh6JYe4NRrlo+uFogj2MNxV9UqBipLogxNeoRpsrpqXS+5niqy9OdkJ8/kXLdknJMh7dbZ5DKFlb7w0BEgIqpNCZt26Si+Qcquu2c+6H8qm+KOMiOhIwipA6HiHYPHYypcR7FCf4VlyTJw8c9y9sxKq24gY78hPSPSa4cKO9ud9D5YZTMNoDBjwmR4PGzURjQthTRG6togWOFokn3YaVqFoFBJfzOCaUIOpvJ3MqDd7HYip2qcMu1s/D3BOlJR4yevyMDd+vWzjSzvEj0av5zgzF9OolL3+9hlapJ+24IZXXvmeGU3nCpg4UkmFRt0IrcR1IvDXAn4AktqwxEacy1BSZ0I0RFjO3Q2whuDAGrE4fr5DM4AmKUJC9knQqMdnzjCYNlLMy/5eb4kYC0nuWinO9OyKq8HbrXSiP43ihZLODE7nTg1XggvOo+6nlp+9Cpoxdpm5NU3gTKrTe+1izo42QZgrYzhPurcw2w/YTkNh2vUkfQPAnSDghW7TbwXkfcIv8x7SUQws4Dx+NTAMzTtizuXeLQ7vnv1rxfwAzWplFcd6VB5tIKmyqPIgwq2qYOIBvXG7rkoY0sXgdpMGAeH3hTCxdD34DLTrL94rEsxQ2oU3kqS1GbrO7f1L5Wxr9oyw2A2aVj6dVNy6DACpWWDstBentuF0YYV7zVfl/lX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(2616005)(4744005)(2906002)(186003)(36756003)(86362001)(31696002)(38070700005)(38100700002)(122000001)(8936002)(8676002)(41300700001)(6486002)(110136005)(31686004)(54906003)(478600001)(5660300002)(4326008)(316002)(6636002)(66476007)(66556008)(71200400001)(64756008)(91956017)(66446008)(76116006)(66946007)(6506007)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajN3S1FYUkhrQjd4MTljK2w1cWRPeUkwa2EvYzF4R3RFdE9xakI5NUpZUEdi?=
 =?utf-8?B?NW9KTUdlS2YybkN0WTlQeUpybGNxU0l1V3lXNThLRk9ZOEVqUEVuaXdhMnFN?=
 =?utf-8?B?Wjc1MWw4TXZ4azBUUktyMnJEUkFqd0pmaW12S012UHFEL3dPKzhubnAwY0pJ?=
 =?utf-8?B?WjNIVGNkdDc3eWswTzFHNEV4WGpsKy9pTVFKcThhQkdzWW1yM2hVQ21oSndx?=
 =?utf-8?B?NkI3UDNpVlZyczY1cXhQUGhQSUxNMmFtd1dLRndMbXg5TFRFWC94R3ZrS1pv?=
 =?utf-8?B?bE1PV29hUS9UVVM2b1BNSGx0RDFHKzVZTFl2ZisvYWhBVVl1MWlLTWtHcXU1?=
 =?utf-8?B?bS9pRVFxR1ZqWUh6cmxycnNPQXF2Q0tuMjZIUHg0eWc5Zi9tNS9IcGRNQ3Nl?=
 =?utf-8?B?M1VrTDlhZ0NSSnlYZVFLNGEwZVl5ekppZWVaU25UMjIxUEU0ZEh3RGtBeHlm?=
 =?utf-8?B?RVJERGM1bGZoRFpQM2g1YmZJMCtkcDNvZjF4dS9LTkNJNHlCVURnTlpZaDVa?=
 =?utf-8?B?Ynl1UG1SUVR5RXlpVGdzdTc3R0IvdTl5L04xVjFxdGFaNEJiQityVy9UeStI?=
 =?utf-8?B?WTU3U1N5VlpUWmZxWEV2Q0tTSjVMQkY0WE40Y1ExSnFJTmttUGNGTmVtcjBZ?=
 =?utf-8?B?ZHE0eFliMUJlc0Y2RXg1VGZ6NHBIemJVRUhNdjBIaDBwcTdOY2lwaUdJNjJj?=
 =?utf-8?B?eFVjQkU0YVNmbmgxNmUwbXQ4bW51aWhOZnBqNnhMT2E2a2xvS1VnRXJzViti?=
 =?utf-8?B?b3c4YkxXeWJmQnZlMjI1MW1tWFB5QmVWVitjbjlaK1lKeGJmU0lGL1hiMmFu?=
 =?utf-8?B?MXIrZTBCKzE5T01iSVYwM3ZXNGtKQ3VFbjF0VUNJSk1wdXZhZnhySE9PbENx?=
 =?utf-8?B?dWtWY2pWVU9NMXY2U0p2Sm80U2M2NXVMdDV6T0RSU1ZualB5bndsR01rTis3?=
 =?utf-8?B?dTcxb2FNMGpIay9XbVo2SElWaUlYTGZVL01DU1FPSWNHWFI1MWZMdFhiT2w3?=
 =?utf-8?B?bG9kUkU2MEs5NkpyM2hJUXZxWGxyeFRPUHBVVDFVMDNoOUVJUHlGNis3cEtB?=
 =?utf-8?B?amJLSmM0L2VQK3hocnRPNVNvTThxcGUwOG9OT1g5dEJNdTR3bCtvRjNyem00?=
 =?utf-8?B?Wk5vVlFjNDZSM25BNTRkZGUzblF0QWpwa3E3ejdIcFUzbmV1Ull0NGw2bjMz?=
 =?utf-8?B?dmN4bkVrVkVlbHFlNTY1Rms3eEpJczMxcTJkc0FzMUtCNDM5QS93N3NzT0tM?=
 =?utf-8?B?SUpUbWZyamE3TGk4ODVPMHVEa1hwTWV2N1l5ZVRsbEc2QW5OSmhEQzFCektx?=
 =?utf-8?B?Y1MwcDFmc1FudS80NkZnVDQ0QTdTTVczRTJzTUlMKzBweWdaM0I3R1BiYnpT?=
 =?utf-8?B?VE5pUDJHck5PWHhKbnc1aVFhVldrNkg3L1k5OEpmZ1cwTTV3Q3dodHJabmlt?=
 =?utf-8?B?NVVBT1pGNVJYbHB3Nkx6cGYwdmxHVXoxZTRQOG80N1lYMkpseFN6STNhcXhM?=
 =?utf-8?B?bU9PNHJZamlPQ3k0VUJNYldLbFlNMkJDb0lnRHQrbHRsWUZSaHArWlcwajFW?=
 =?utf-8?B?T1k3SzZlVDh2NXdabkEyNXVPNVI5bnoyR0lMYkEzL3lMYmVzbC9zY0lkYWNH?=
 =?utf-8?B?VzZqUWJ1dGhrR2ZpUW85TnpwU3puZ3hMYnNiR0RjNDdiVXZacCtybjgxNHUr?=
 =?utf-8?B?MXFneWM2aVRSVnZyYjhRbzc5SzBIdi9TTkpQbDNISEdNMDdHbTJ5VjM1WW9q?=
 =?utf-8?B?eXdOR2xVU0hNeHNMTGdCcWxxbHFUcGFQZTUrdGdObUc3enZIR0xHN1lCNGxB?=
 =?utf-8?B?bGdhRDFlRkN2WHZXWTExNmxOK0pYQ3daQU1ib3dQVS9zVmZMUGVQWnY1eU5q?=
 =?utf-8?B?V0xuU1BDeklJbjVmZTdCTERRL2FnVjQzdlI3ZjNkNUVzWE0wRHhjaEdQY3JY?=
 =?utf-8?B?MVJaL2lNV3FMdjFiK1RqUFZxWFR0L2dBK0tCVFdaNnp4VG5DbnlWbDBrS3Bl?=
 =?utf-8?B?a1BCUStuWmR5eG9seWRUR3NjRE9haGk0RGFzR2tGbkJQV3FJZkpsS0ZCVUp4?=
 =?utf-8?B?dUJDZCttSm51Q2FPd2t5OG10eTd5TlZyNGlGNWNBMDZ4by9URkZwMjFNZWdH?=
 =?utf-8?B?QTFLbTBFd3d5MzRxOUNqZlgvUktnTzZ6TXNVMVhyZWF5a2psSWoyajQrb092?=
 =?utf-8?Q?kPlMCdJ4iI+a9dg2wA/0kNnSjjHREFnk6iB+sCpwMGTc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A1CCF05DD6A90419A8E69587EB79867@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a930f5-1dcc-4aff-e4c4-08db5c2ea539
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 08:12:41.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNewgThiiKiMHNl2ur4MNocmEXUt9SwiKHxfyx3jyfWaii86KnChLCxs4dQMQ3oAdaqDXzOVXzBFPlbeXUBl9+65txm0x37MgSynCHchjjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4926
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29ub3IsDQoNCk9uIDIzLzA1LzIwMjMgYXQgMjA6MjcsIENvbm9yIERvb2xleSB3cm90ZToNCg0K
Wy4uXQ0KDQo+PiArICAgICAgLSBhdG1lbCxhdDkxc2FtOXg1LXNoZHdjDQo+IEZvciBteSBvd24g
Y3VyaW9zaXR5LCBpcyB0aGlzIHggYSB3aWxkY2FyZCBvciBwYXJ0IG9mIHRoZSBwcm9kdWN0IG5h
bWU/DQo+IFF1aWNrIGdvb2dsZSB3YXMgc2xpZ2h0bHkgY29uZnVzaW5nLg0KDQpJbiB0aGlzIHNw
ZWNpYWwgY2FzZSwgdGhlIHggaXMgaW5kZWVkIGEgd2lsZGNhcmQsIGJ1dCBhcyB0aGUgdW5kZXJs
eWluZyANCnNpbGljb24gaXMgdGhlIHNhbWUsIHdlIGNob29zZSAoYSBsb25nIHRpbWUgYWdvKSB0
byBhbnl3YXkgZ28gd2l0aCB0aGlzIA0KbmFtaW5nIGZvciB0aGUgIjUgc2VyaWVzIiAod2hpY2gg
ZG9lcyBub3QgY29udGFpbiB0aGUgc2FtOWc0NSBCVFcsIHRvIA0KbWFrZSB0aGluZ3MgZWFzaWVy
IDstKSkuDQoNClJlZ2FyZHMsDQogICBOaWNvbGFzDQoNCi0tIA0KTmljb2xhcyBGZXJyZQ0KDQo=
