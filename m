Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6301866720C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjALMXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjALMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:23:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07FA13D;
        Thu, 12 Jan 2023 04:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673526202; x=1705062202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ho1fbOmiH9/0BKzclWXsbRvX1p09pTuM+Xu6UmMNdcw=;
  b=Qyq//HZBWoHVRstPXBZjPtCT+s9ATfZU4+5gfWJOt0i7w6BcAmEk9Tol
   28NCousE1PuOflEYEFR32Fj6afvV23QpewCYClPSszMP9iIu44u809tkl
   xSGrmNiZf29738tLsPRsT1dVc2MFnPaky50Rfvp1M/oj7ouEXzWCg2KPv
   iVbHqECjq4fTqiC26fx3JnXH4lU2LupUSgU8zMMCUXxMSYo/IvcrziQC9
   MzeT1cx6qv0A7KTOReeBhlmH0hNIaefL3ZqpyODZOMSy5WsvJB3Y+/lkB
   cWXjcQbGy4lceEuT0QJFRlLtQ8E/TXXPtve5Fe6IY0Qxbb3rBW9p6iAHU
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669100400"; 
   d="scan'208";a="195439102"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 05:23:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 05:23:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 05:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClcadLa3Rq2yIgwCL4q6Z1sV6J2GL6A6ZsDaySVTrnzwc+GudjFvJOIH9XTMm+DfSgjZcV7fVxZof8ddku6JZ8wn1vyt1OinxjrbYe3Uf1p58yVLAlDd/A2+1pULsuTFkebpdQNC9LYjzjROnrPKNKcqmIP9ODv8VC5XfWUa8eyZ9eP0arna+QUUZobn/CTejcpOvgyJuml4hxqdwTbM3ii5677rlywy+fftUJKUTG6mtTHHqCEUVZGxrI4THw1HlnR7rL7t8hDGWmpqN2Y+k/zTgUiWyEOgK+omH8USwiCptN9ctXxfFJ/ZpyVwvYu7UvMPm50/NzdBc+l+FmXMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho1fbOmiH9/0BKzclWXsbRvX1p09pTuM+Xu6UmMNdcw=;
 b=eDs7loDpPMgdAh/WuQMW7raGPDoWWSlZTLYthZdY53u2r+bfILkqzajMmPlcmUAPt8W1WqZ87ORGHovpyUdar/rkeaYnuPvSZD/Lz850P6hMlR5jfCQoDH6/MepWJZDsFtkpljUTEvPsPLC4IxHavkoZJUqsJsivA4fixcB/p1721DDBRA3YwNOSvEjhpD2MOBULy+d1Ssisc+IqWxvJqgnI3lK9oInZbelwyrWbN5ni6l+fiQZnoHBenM9SkRoArl6B+DqLn2sXsW5jHUY/wvh+xvWIvTCJX0h9XodFRGY6vb5STCocN2VRI3/53hHXeHQsQh4LhMghoz1Wnh3D7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho1fbOmiH9/0BKzclWXsbRvX1p09pTuM+Xu6UmMNdcw=;
 b=Wf1oij9Duvaeg9LmKAVPF6vJGvJdvIfLqzIdeGVn7a9phYW+RZYcW6OZAxSbolSfHo6MGfOtGVPK+Xobd29PHJ+o8VQ1IMBo2LYowMEAhrDax67UH+oGRZGVPiQPXgZdImOWa7Z+cHNnTeUTUsSzHyNMN3OSWvJRis6GxifsBc4=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH0PR11MB5347.namprd11.prod.outlook.com (2603:10b6:610:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 12:23:16 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 12:23:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <Sandeep.Sheriker@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sam9x60: fix the ddr clock for sam9x60
Thread-Topic: [PATCH] ARM: dts: at91: sam9x60: fix the ddr clock for sam9x60
Thread-Index: AQHZJoClTLTv1s9n0EWfnvb0mY7Rwg==
Date:   Thu, 12 Jan 2023 12:23:15 +0000
Message-ID: <71af3b87-2bc5-b518-85c7-b4510fe56175@microchip.com>
References: <20221208115241.36312-1-claudiu.beznea@microchip.com>
In-Reply-To: <20221208115241.36312-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CH0PR11MB5347:EE_
x-ms-office365-filtering-correlation-id: cbf2e6bc-cb86-4ecf-010d-08daf497c810
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dGYsWU/pNO+1BRoyt+pFq0dmmW04itNdHt/Ht1ljVAfEDfr0VO0iHINqN/WWdTvcxAjuNE6828Ny2XjoXYe2OzwAMZ3SWY3HP15acY46iNA2pF8hX5q2DEdhhufQiWOUkN8QG1nePUXZjm1EivBMazY2JtYSumBX7wS1CGQrj8PbB569wQ5E16HQMG2QVrqKHTNPu74ngFq5UTqjx17B7rk6EZTSX5lweAni+8aGOKa4q57GUT6k45K15ye23GxQZpJhm2Noxc3BkhqzcUWzS3ASTJZkr7Kr1TEKjk7WkZGLuIlGc2MWAJLDu7Bk9sBf1XwmbiMPJfM+Ppq043+DObKulhur2JrPkq1SiP6RXTQjVV4nhAciR2oJspBSxTnIeSLfWHnOS/mLUR26FoKDxq5ON+ndd54vurzx5iPc0TYJzxBROozkUelqdtjAdH5ZXl9KrkMLQo6+qP+dKDheGwAF5i12sjO6ypX25lywqcowzM3+KHSPKDBStu0hMjcH0L3ZXGsWU+xOHdd/KHmwzi2fAbEPEq2GjMT3xwtRlCRULjO5jr1DzllCCFthSDolvFTuA+r6f+n6pM57Om62BnajRe6HtWbaO7hLviHKEAZlBpArt98cIDtzlchWvS+oyaXGQ//cIgLug3c4dgkFOmJ/RSiYujdyIw2iS3wSg7QHG+n3b5kF5zWWGPYLwdO0iXuBSPOlNQztgJyjP2so9r8Jcrcgw9ZuMak2/3rRzoRBwp//Px92Z0l9C6W+eHdd80U3Qi1bCwBrli+VJQ+a4Wqsbf2xjpWux/RNiS0oPxY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199015)(6506007)(2906002)(122000001)(36756003)(5660300002)(53546011)(4744005)(31686004)(4326008)(8936002)(91956017)(64756008)(8676002)(83380400001)(66446008)(38100700002)(6512007)(478600001)(41300700001)(38070700005)(6486002)(66556008)(66946007)(26005)(76116006)(186003)(66476007)(86362001)(71200400001)(31696002)(2616005)(54906003)(316002)(110136005)(138113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME5rUytORXJVTUxsd3RKUC9XYkd1ZXNkcE50V0FEZml5TkFlUUtSWUdUVHRX?=
 =?utf-8?B?clJMYlpWV2xtRi9OeG5WV2RtcEs2eXN4UWFDeXFZYmxMQlkwM2FGdy9CWDNJ?=
 =?utf-8?B?YVlKU0pHY3VlbFIxK3B2QWdyQUs5ZDdYWisxRnJ5dUY1MUZzeUVrMXpxeFNs?=
 =?utf-8?B?Tmd1dUU0eFIzSC9JQjgrcEEwOTd3czFWOEQ4WDdDUnRkSVBSalVtb1ordWda?=
 =?utf-8?B?dFJHclU3bEJ1VzA5azk3U240aXBDeEsyMGtycEhoZEw2eXpmb3BYUS93Yk1y?=
 =?utf-8?B?aGxaQ3lUdHBHOWwzelB4VWc2NTRqOFk4RWN2M0pUVGpoWVR4VTNGVllqdzFV?=
 =?utf-8?B?amZOY3ZLb3dLcmZ4TklHb0xRYjFiVW1wTnd3bFoyUjk0bXZKQWdta3M3RzFR?=
 =?utf-8?B?TVREUDdsU09BYk5qUWYyMGVPZVVESFJTZzgxb1dMMk0waFBhb1V4VlpiR2Ru?=
 =?utf-8?B?QnpQRWw0bWFUd3pYZzR4TFdkc05LQm5pcmZsYmFSSDR5RlhjZGZOYjZWMU1n?=
 =?utf-8?B?ejdYa3kwV2VnN1RRZzhlQjhRenlXcko2REdkSHdjb3pJbEhhTUdBZzBrYmk2?=
 =?utf-8?B?NFlzb0d4aVlhSVkwRkQvSk9aaGV5VTY5Zm5MUmk2dVhVWEJHdlpjdUdUZW96?=
 =?utf-8?B?MHlMcWxBU2JZV0t2RzlCaUFSMjdLNFk0QTNvdys5R1VrcGx0QTJkaVY3blg1?=
 =?utf-8?B?TkludG5VcHprd0k0SDUwOGNFS0dBamhxeFoxelRkN1pQbjhQNVJxSTZVWlcz?=
 =?utf-8?B?VzJkQzB3TldJZmE0YkF6L1ZkbHI4U25GL0FNaTJQdHYwWW9aMjBucmVRbTFs?=
 =?utf-8?B?WWVoSHpuNjM4eWpQSlFwTFRocndrQzluL1hJNWNNaUEzVmR5S29VelhKQjlW?=
 =?utf-8?B?azExSFhoUEVraFBVemJmUmVTcDRVNDdXWHEydlFjT3BsUTJSQjFMdmxHejBF?=
 =?utf-8?B?eHpMRndJQ2dKYS9zanpWdXBOM09aWXlycml5RE1KU3NHK1pvTHNjNS9Zdllq?=
 =?utf-8?B?bmMyTjdNa2hxU3RuVUZkNUpocUR5NzVLYWZ1eUYwdlN5RUo1TGNJS3czQnFz?=
 =?utf-8?B?ZlVoL1NiYTBOandTYVJwNXJpdnBMdkg5OHZtQWkwQysvS0dtS01DMEpxV3Fj?=
 =?utf-8?B?L1Q1ZHNPMHgrYjN5L0JGalJXL0lVcnM3bzNhTzZIbTJOWFR0Y0R4WnhoSTNs?=
 =?utf-8?B?eDBiK0U0Ym8zaVFGVlVWZE9QVnpNbFVkdThIVjJSSTMxYktsOXYxWFRmUVFN?=
 =?utf-8?B?QW53dFFNMVFadmpGQ1VmbXNkeUFSM3VIMzJZR2RmalpzMGFCVEJEV3kveUpy?=
 =?utf-8?B?Rnp2VmJLeDJXK3ZRWjhqRHRjVkp2bGxOVU1WQU9GQ2NYZHRZc0VJb01qaGJh?=
 =?utf-8?B?ZkZqdzVxS3NSSXVQVTZSUkl4MUFNR3NzbldZNW5jY3hRZm5Ka0J0U3cvREJW?=
 =?utf-8?B?eU5qN1Exd3RyOTVKcmc1VzJ4bThuWlQ2TWlxTjFOK25pbk02ak9rTTU2dlo4?=
 =?utf-8?B?bW5DZ1JCbUIxSi9aVGNFaitmb1ROMGJMMzJWcEMyTkZZdStvRUpPTkNJTXgy?=
 =?utf-8?B?UHl6VEI2OU8rQlhDQUN1Y3Jmd2ZadDRxc2pObXZ1VXVpc1l3K1ZVa3dHMzZa?=
 =?utf-8?B?SVF4bndMQ1lRZHF3ZytGWkdINm5sTW91bDZtUTQwZkl4cTRqbFNia0lRRWtF?=
 =?utf-8?B?eExma285c1hWaGhqS0xRbjhiakFDdkUxdXNnNU10OXVGc2QzSDBsU1dDOUlD?=
 =?utf-8?B?eWNsQVkxTUp6S1pKczhzc1lmOG10QWU1b25abkdscklGM0g1cVVTV2t1RVRR?=
 =?utf-8?B?MTBMVWNxajczU1A0bTJNTGtwZFdXczNPekR4T1BVblNoYmNINXRGaFpGdHhF?=
 =?utf-8?B?MzJSSXlwM0xBbFlkdE91Ni9jMC9LdCs2anFHRDA0NXNVV25CdkpmKzYzVFow?=
 =?utf-8?B?WldaM3Z1b3VSd3VOUWVLUmJYb3VFRWdPQlpKKyt0cGRteFNERDJUaFQzYk1q?=
 =?utf-8?B?RzVIaW82WEJMWmoycFB0T1kvVFZqMW14MThHR1VqUXBwdThQemI2Nkwydk9M?=
 =?utf-8?B?T2l5c1loeUxuRWdTNWhIN3pKNUxiZWIrVVp4NWhMelc4QWxIQkxXNnROTHV2?=
 =?utf-8?B?c3c2eEJ6QUhSc05JSzJ2bFlqR1FwK3dGTURETU4zZW9xemxkbFpQKy9QYSsr?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E1D0A78DB38FF46B93B4516AE697C1B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf2e6bc-cb86-4ecf-010d-08daf497c810
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 12:23:15.9765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgltkayzIRr/0lH1/UoyrIIlrDxpj0xgF9WUrDIusN0rcwg1Yi1lnAasiSra003L0RiBjXZ8OPD+3+lv0VZTpjyGJHZ7xyX/kZ3J+7w2XNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5347
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMTIuMjAyMiAxMzo1MiwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IFRoZSAybmQgRERS
IGNsb2NrIGZvciBzYW05eDYwIEREUiBjb250cm9sbGVyIGlzIHBlcmlwaGVyYWwgY2xvY2sgd2l0
aA0KPiBpZCA0OS4NCj4gDQo+IEZpeGVzOiAxZTVmNTMyYzI3MzcgKCJBUk06IGR0czogYXQ5MTog
c2FtOXg2MDogYWRkIGRldmljZSB0cmVlIGZvciBzb2MgYW5kIGJvYXJkIikNCj4gU2lnbmVkLW9m
Zi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFw
cGxpZWQgdG8gYXQ5MS1maXhlcywgdGhhbmtzIQ0KDQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9k
dHMvc2FtOXg2MC5kdHNpIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc2Ft
OXg2MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+IGluZGV4IDhmNTQ3
N2UzMDdkZC4uMzdhNWQ5NmFhZjY0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9z
YW05eDYwLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+IEBA
IC01NjQsNyArNTY0LDcgQEAgcG1lY2M6IGVjYy1lbmdpbmVAZmZmZmUwMDAgew0KPiAgCQkJbXBk
ZHJjOiBtcGRkcmNAZmZmZmU4MDAgew0KPiAgCQkJCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNh
bTl4NjAtZGRyYW1jIiwgImF0bWVsLHNhbWE1ZDMtZGRyYW1jIjsNCj4gIAkJCQlyZWcgPSA8MHhm
ZmZmZTgwMCAweDIwMD47DQo+IC0JCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfU1lTVEVNIDI+
LCA8JnBtYyBQTUNfVFlQRV9DT1JFIFBNQ19NQ0s+Ow0KPiArCQkJCWNsb2NrcyA9IDwmcG1jIFBN
Q19UWVBFX1NZU1RFTSAyPiwgPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA0OT47DQo+ICAJCQkJ
Y2xvY2stbmFtZXMgPSAiZGRyY2siLCAibXBkZHIiOw0KPiAgCQkJfTsNCj4gIA0KDQo=
