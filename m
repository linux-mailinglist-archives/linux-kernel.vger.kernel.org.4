Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96E729478
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbjFIJOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbjFIJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:14:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AE65594
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686301789; x=1717837789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pwjf5YlV5+atY7YkofQH6E2bEH+biJaFC/iQiYiHxDQ=;
  b=l6pqQWQBAOobB77ULW78YKQ3SRdBwNHizngVm1+Ca85oB+srs5uVLI5M
   92FjFtpiv7mtmgi4rhOHCyu39boF6wvnQLoLdNFMeG774sCLNxza/mLDI
   OS7Ukh8AoJQCwxJNPAlDKxPFQ3GCK//F4AkAAnBgpelO0LwAicmi0XL4L
   RockxLQlubdLE6G6kxV/Mt+mAWym4/Vdl6JgXURrU4rNdtu+WdlZSt9r+
   f+vMIT/eXb5LZPyo4LHxkv2YIz6qrzxc57PtoPpVd8Tn1ikBWIIvXs986
   7spv90YHEZmJ2bt9X0QoaRNytG4Hf2DSRXABrvo9gYLsItvxBe9Iz5SsJ
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="217032712"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2023 02:08:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 9 Jun 2023 02:08:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 9 Jun 2023 02:08:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBQtLky9ZuNB2NU2Y4GfC573DFaVvYjlgnnic4TP506Xp3rlyOLt7iHFAymBHVNt5dKrWB5xyAsPt6h7Q09UVTv+TVxYU8VaEvpOxJqw+iabYJV1a8/mAzKq14nnBbNqeNodQwgWqMnALX7E/WVDsuoiRRhBHDOoeqvD41a3tglnXOcVvSO+PJxOdKXGuWKWi/pEyMy9nKoQqzIT4cLnqSElEHPinOrWUd+mZV+ghDiJ8nvrziqRUgWCxDXtkmKtqgkc1LDsfLq/TfN3NMK4a+ZIEGTf0bdndhEt60desTTfE5Jj+oBI68/9jH/SzYMDWeJJIW072kkz9oZE332xuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwjf5YlV5+atY7YkofQH6E2bEH+biJaFC/iQiYiHxDQ=;
 b=n7Uliw++9vaxTY+4CVM1z7tnsQ9pCyhI87sqWFS0dTwHlimge9IBehR/oie0MDyMpMBJdEl6oO6jeTp/+950A1z3HqhG5Id2kwpOk1wHs65r5hyp+cf5BmK60yQyc5ESqixnWsQu54DjBy/bpxAsxo2VLgUVz9CZklFIm8PV/nFsgFYOS9qYsUrfQgV8vPzV7MT3dp8T4bSNS+671dCreP/0C8JyDXJtX6Oh1earkT93T4bJjkzhN7btRe0kEyfCyvqfLidk+gETSY7KVjwCl1/IEI/qN3+sAjvy3yEqtJWOPApmNHi63KS77MHEg+/lccm+bOztpb28L46GStXzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwjf5YlV5+atY7YkofQH6E2bEH+biJaFC/iQiYiHxDQ=;
 b=Tx6hvUG/dmekuLq26A1yNj54f6AsDPUFiRcv8wYu0d8494LQkmcRb+9DWA092rLh6oUVW4SXx//P925nsiUo4t3cSBB7fU46nZkDTk4Xqiy/qJuoQx5npcw11w3HAIJVM2FEDZAxwE9ZtPzA6JEN4NyGUxAR9UxUh4xw9WFiJcg=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by SA2PR11MB5017.namprd11.prod.outlook.com (2603:10b6:806:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 9 Jun
 2023 09:08:26 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.024; Fri, 9 Jun 2023
 09:08:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <walker.chen@starfivetech.com>, <broonie@kernel.org>,
        <dan.carpenter@linaro.org>, <lgirdwood@gmail.com>,
        <tiwai@suse.com>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: starfive: Remove some unused macros
Thread-Topic: [PATCH v2 2/2] ASoC: starfive: Remove some unused macros
Thread-Index: AQHZmrHzuXWqWu7rCEu8p6L75U9C9g==
Date:   Fri, 9 Jun 2023 09:08:26 +0000
Message-ID: <45793158-b1af-ce7f-1da1-9a63cea670d8@microchip.com>
References: <20230608135750.11041-1-walker.chen@starfivetech.com>
 <20230608135750.11041-3-walker.chen@starfivetech.com>
In-Reply-To: <20230608135750.11041-3-walker.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|SA2PR11MB5017:EE_
x-ms-office365-filtering-correlation-id: 5bb2b9a0-a957-443a-db7b-08db68c91585
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ErF6J8yfhTPTD8E2+4vxiP+xMHTCagnMLXMLC368PX7j4WcZ/Y1+otT/DOsMt9z1PbXaC2v6/pEGQYiMsOxliPy/XJ25Jj+UoMLf43tG+innb6YZDo/DIECaFkxfTYEX1/2esGf+aLRXW2gqZaEWBqHb9VuG16zGIDbl16McfDzkbjz/PTD42K5/XhlDADRiG8Ik7FsUAx5EeodjwxbtFRTuvueqGPUuEYe8EXg9FVxqQgdKfE/DsKsVDiZGUmSTqrfDq6+B+CZbC8UvilCfhR6YbXRtQANGhrmYA0LO9CxyLCEVGdTeqP+o/BSJ56i2wESBeJZwqBveKTL8L6/TAW5sOHFq+DXlJ2zmhTmAdAe4UQJu5SEbJoOj+N2+MqO82hSOK9Uz2K+xkq01DNdEpPOFpUQqplug7DoIc0389bqCHkVHuhyMkJwLxdCgI0llxDT0MiWEpjaf7vXpxC5L7F8XtT5PmC7zq4u8HgYEv3e4wH6Z4pONO54Gl3WL889CwEIs9lyN7W1EZ5//EHuGbPZ6nruT5y57t/vMn9iLSlw+z7fI87S1t5om47myCZ9/bOD8X+kc31w1O4cTIfqKheGIEtcwXfO4JYiDbmGNO9jKDpaH0M/1eCbQ8NdVWaFMrmtpr13X7BRmTK8LEDYslDq6pDEi4AwXzJmS2ejbkY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(186003)(478600001)(110136005)(54906003)(36756003)(6486002)(26005)(6512007)(6506007)(53546011)(71200400001)(41300700001)(83380400001)(316002)(38100700002)(38070700005)(2906002)(5660300002)(8676002)(8936002)(31686004)(86362001)(66946007)(76116006)(91956017)(122000001)(64756008)(66446008)(66476007)(66556008)(31696002)(2616005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG1KQTNXMmcxT0ljOC92cVg0ZnFMVmx2MG5TUlgzbVB1eUpmL2ltSW80c3M5?=
 =?utf-8?B?NEhKVnhFUGRpTlczMnlhSHRmUDhqYklUNE9jSzN2bmIzd0dVTkZaYlZZdnJC?=
 =?utf-8?B?REVBektsNWVDWEVPR2dEckpHQ2l4SnJxazJOV0Nvbnl6a1dJL09pbUJQOHRj?=
 =?utf-8?B?Z1BZRmZIZHk5VWZtS1RiQ0cwRHhDVVdPa0dOeUE0WG40cEJ4SFlCSG0rRmxK?=
 =?utf-8?B?UFBEK0VsVnJRMk1MT01yZUJDRExET1RCRlFxUTA2Y3JTQzhlVFZjV3kvN2ZB?=
 =?utf-8?B?VG9odGt4MnNMNVdvZ094MWxZM1V1cE42ZjdrYXBqMzByakkxQjVqNXJqWGlr?=
 =?utf-8?B?NVMwTnNSLzNJOC9wb0xwS0VDRXE1UXJSMTRvUEQveVFQb1ZpWk0wVE9zZ2g1?=
 =?utf-8?B?YVRwdXNCcDBhbGN4LzE3dUJIaTgwMVZTV25FbGc5SmlsNU1QbGFJMGtFeTRu?=
 =?utf-8?B?ZUo3MzBKdTVjWFFlVEJPNVg2QlJBdm5jYjFNbFRqa0hCV2JoZG9jbm10QmhR?=
 =?utf-8?B?aStGUVNMMHhLUk5rVGNJKzBOMkdBTm4vMHpzbzFoemdsR08zMWNzNExOY29t?=
 =?utf-8?B?YnZEMGlPYkF6LytsUy9aVnlHUTR2SitlWjlMOTZpeFZESWUyVkgycjY5c1hV?=
 =?utf-8?B?c0RpeVg0WUlLNGljM2YyRkM1amM0bkJHdUhJMHNhZ3hYbkg2Y0VZWHNuV3FH?=
 =?utf-8?B?WDJPbXd2M1ZTNmRNaFRYeEJhLzh4NlBZdHJMWmoxQ0s4a0VReVRaQVRpQkNz?=
 =?utf-8?B?UFczVFI0LzhMZHZNcUgyNkI2OGdUOGp3VkVweFFGbVc1d3pJOHVrR2pOc0k1?=
 =?utf-8?B?WTMzR0I3eVY2bncwbko0bHFNd2FFNEtMcW4wN1dMWTltUlNNd2xrR1JUOVdz?=
 =?utf-8?B?ZzZrb0J5Q1BMSUFwSVZWeGRMUVM5OTZacWNpYTRReWJnNXlIMUhOY0pUQ01I?=
 =?utf-8?B?UTVZMkZrd2FZOGpKck55eHJOR0toWkM1Y2x1RTF6SnZKV1V5b2xmTnMxZlE1?=
 =?utf-8?B?ZmE2MlVoS0UwVURBb2JYZkJXb1NaQzdzU294VWh2NGEwYXZzSmVGSzVWN3FR?=
 =?utf-8?B?WUNyd05wQk1QL3h4Sk9XWWJSWUE0aGpnSlo2S2lMTmlGU2E2N3J0MzdnVXFP?=
 =?utf-8?B?VjFXSC9seGgvQkh4dHNaUktmQTVOOERGT0lzUGxJYUdFMEdkK0FrTmwrQUl6?=
 =?utf-8?B?Wm1WRFdkMlZacjVBNlc2YU40YnlWT2hwSFJ3MHFWL0hFY2J6eFRUWnFFeHVK?=
 =?utf-8?B?Ym1SdFBQRk5ZaXdUTHAvQk1pZFd3NUthT1lpeTBzaHdneEJraGhoa0liZ0h6?=
 =?utf-8?B?QXE3YjJ6djNmQld5QmwrVVB4WG03S3M2SXFWb0g2OVBObjFQZ0FNVTBIb1lH?=
 =?utf-8?B?QnRDQUIvR2dvTTBaVjhBUzBsSFlJSVIvTnlqMUY4c3VJSXNPMGNyUTdhck1a?=
 =?utf-8?B?NWN5VTEwejdaN0IwTVIrM2xMR0MzeWdpMUk3RUl5M0E2L09aektCd21sbEN1?=
 =?utf-8?B?L0tQMDMwRkN4KzFEM2o4ZnV0QXZFdkVOMTdidGtjODduM1ljTnpibWFZYzg4?=
 =?utf-8?B?M3BKb3M4V0U5VUVxUVFkWDd1NDM2a2hDQ1RjZHNHSE5PNGRONGJsZEdGRzVy?=
 =?utf-8?B?UlA4REhMYVoySlJRSDJiWHRSbHIremRoU2ZxeFJRSjFOK1NJK1hUTlF1Nktk?=
 =?utf-8?B?WXVuVlN5NGZLdjZZYWJQQkRQRXg0ZWZ0VUxJMk1yaVZ5b2g3Zk1Scm9sejlo?=
 =?utf-8?B?OGh1UWhKR2VveHZXY2FPV2VLVE9GL1NsRThVd0lLZGlDYk9RODVMS1UyMjFp?=
 =?utf-8?B?Rk9MTnZVZWZ4TUtOWnlVZFBBZTIxSUdxeWNRV28vNXYxSE9lRXIrZEhGditF?=
 =?utf-8?B?dUZXN0huMENhYmRlOVJPdTZqSUtTNW1jZ0lGL3pIMEExUzlvQkc2bWJtc2pp?=
 =?utf-8?B?ZWcyV1BaTXl4czZkTXg5WkZSZ1hkVi84UzVRcE10Rk5tSGpqOXZxOXgyVGNr?=
 =?utf-8?B?VjNiK1N0R3I2ME1kOGIvSGJIYjhkdTN0L01ZZVp0ckE3VS9Vd1ZPOEZCRitj?=
 =?utf-8?B?dVAxNTdiOWRUY1FaaVpWNndkSlZZeFpwOGNuZGN3d3lLVHpVejRqdHlINzhS?=
 =?utf-8?B?cmRuRUJZTm9Bd2xmR0ttUTg5WFdIeStVWG9aOGRDTlN2SFc0Q2hkUjhOV0dI?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F18A7C7683D2045BCE70599A37FC52F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb2b9a0-a957-443a-db7b-08db68c91585
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 09:08:26.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6n156p9uBdAOxmfgIC/83+iKxCMCM7gK5+X/FcyPKhMvZBUix3TH1cAz6+eED18U3YQvAr1kIg/gdaiR8gGQyAxl+q1VZaTThUkrqwzxUQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDYuMjAyMyAxNjo1NywgV2Fsa2VyIENoZW4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlc2UgbWFjcm9zIGFyZSB1bnVzZWQgYW5kIGNh
biBiZSBkcm9wcGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2Fsa2VyIENoZW4gPHdhbGtlci5j
aGVuQHN0YXJmaXZldGVjaC5jb20+DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xh
dWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KDQo+IC0tLQ0KPiAgc291bmQvc29jL3N0YXJm
aXZlL2poNzExMF90ZG0uYyB8IDggLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zdGFyZml2ZS9qaDcxMTBfdGRt
LmMgYi9zb3VuZC9zb2Mvc3RhcmZpdmUvamg3MTEwX3RkbS5jDQo+IGluZGV4IGE5YTNkNTJiZGQy
YS4uZTRiZGJhMjBjNDk5IDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9zb2Mvc3RhcmZpdmUvamg3MTEw
X3RkbS5jDQo+ICsrKyBiL3NvdW5kL3NvYy9zdGFyZml2ZS9qaDcxMTBfdGRtLmMNCj4gQEAgLTI1
LDExICsyNSw4IEBADQo+ICAjaW5jbHVkZSA8c291bmQvc29jLWRhaS5oPg0KPiANCj4gICNkZWZp
bmUgVERNX1BDTUdCQ1IgICAgICAgICAgICAgICAgICAgIDB4MDANCj4gLSAgICAgICAjZGVmaW5l
IFBDTUdCQ1JfTUFTSyAgICAgICAgICAgIDB4MWUNCj4gICAgICAgICAjZGVmaW5lIFBDTUdCQ1Jf
RU5BQkxFICAgICAgICAgIEJJVCgwKQ0KPiAtICAgICAgICNkZWZpbmUgUENNR0JDUl9UUklUWEVO
ICAgICAgICAgQklUKDQpDQo+ICAgICAgICAgI2RlZmluZSBDTEtQT0xfQklUICAgICAgICAgICAg
ICA1DQo+IC0gICAgICAgI2RlZmluZSBUUklUWEVOX0JJVCAgICAgICAgICAgICA0DQo+ICAgICAg
ICAgI2RlZmluZSBFTE1fQklUICAgICAgICAgICAgICAgICAzDQo+ICAgICAgICAgI2RlZmluZSBT
WU5DTV9CSVQgICAgICAgICAgICAgICAyDQo+ICAgICAgICAgI2RlZmluZSBNU19CSVQgICAgICAg
ICAgICAgICAgICAxDQo+IEBAIC00MiwxMSArMzksNiBAQA0KPiAgICAgICAgICNkZWZpbmUgTFJK
X0JJVCAgICAgICAgICAgICAgICAgMQ0KPiAgI2RlZmluZSBURE1fUENNUlhDUiAgICAgICAgICAg
ICAgICAgICAgMHgwOA0KPiAgICAgICAgICNkZWZpbmUgUENNUlhDUl9SWEVOICAgICAgICAgICAg
QklUKDApDQo+IC0gICAgICAgI2RlZmluZSBQQ01SWENSX1JYU0xfTUFTSyAgICAgICAweGMNCj4g
LSAgICAgICAjZGVmaW5lIFBDTVJYQ1JfUlhTTF8xNkJJVCAgICAgIDB4NA0KPiAtICAgICAgICNk
ZWZpbmUgUENNUlhDUl9SWFNMXzMyQklUICAgICAgMHg4DQo+IC0gICAgICAgI2RlZmluZSBQQ01S
WENSX1NDQUxFX01BU0sgICAgICAweGYwDQo+IC0gICAgICAgI2RlZmluZSBQQ01SWENSX1NDQUxF
XzFDSCAgICAgICAweDEwDQo+ICAjZGVmaW5lIFRETV9QQ01ESVYgICAgICAgICAgICAgICAgICAg
ICAweDBjDQo+IA0KPiAgI2RlZmluZSBKSDcxMTBfVERNX0ZJRk8gICAgICAgICAgICAgICAgICAg
ICAgICAweDE3MGMwMDAwDQo+IC0tDQo+IDIuMTcuMQ0KPiANCg0K
