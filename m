Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC135BA27F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 23:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIOV5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 17:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIOV44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:56:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377FA89CC0;
        Thu, 15 Sep 2022 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663279014; x=1694815014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KnUFgZSjAsCsvnLpCcCQ1eJWCsyfI/CVfOufUY86Rpc=;
  b=0XUss/dCv6zV6oU91FLTkVw/8BhCq0aIsLM74Hsqjz0Sbj0564byF1kH
   17kUFUTuLiRZlINUY1WDkZELWpD+DI/FrM/Z84s8zy3nJ+QS/UnX3vU6/
   Tmf/x8ZJeraMNp/GOn6lGhS+jHe7OzVH2S8Qo/XVW6BJFhIEAVHGnBq4V
   wgVt0KX9AkCFSPe2gbJGOI9Xd12nyuwifq+Lk3N8E9Rax9O+K6tPsLVMr
   NDIPYA6uodFuHW4Qre4hYXnmzh6dKnykydH/1cCcu6um6ilKuM/z3FzOt
   PJ4g21QyLVPMcmuZWSGTMcZBH1CkWVHDT2izcbITUkXZRwQqkL0zVrbiS
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="191071851"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 14:56:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 14:56:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 15 Sep 2022 14:56:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5gVHt/TK1wfDN4HhT8jP4+AGSjqbnwdmC2bjr10kYUabr7PiQP0L5GA1y6qqoKHzvlsXdOBfwNZyvxPMlRUHJecHaZ0pe+aNk6wCI0A+4lTTPO+UziQTyEFY6N6i8dG5OnQdQYdT++LVv6Xu40yAmQF+aCDEDlLTkTdRiLXSrbh3kqNQGoZhkpstsGfrkDxoDXzjeCzziebNqqZg6fRviOVRj7ngoitJpIFHgR+6X5UXF/FmxYl89tpeCRoEAmqBezly5aHkAJ2Rz4MFbN253jsTHl5oxbZzCXDWstLk8wnLFCYEr5/MCqW2G9ZjpGbBB9D19vTb5jXhxs0gZ+1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnUFgZSjAsCsvnLpCcCQ1eJWCsyfI/CVfOufUY86Rpc=;
 b=FstZ03gbiz2uqbAu2lWpX3RrmusCd3zcGKfb02Kln0Gfk77D0ahIxjsXIVofdAcOoe19ISm+8aApXKFPh30PD9xZV6GK3o946osJrP9IkVUkEkYoRg7f6iFeSSyIzpuu4ndw7Y9l+fl1FelVJlPBZpjl6o4C2SwmwfkpkO20ysWGFwTluXIzwUi16DxpPjsJZKMkVX5fl7P4XhhnHEDo7VUuJS1us28IZa3mJ5YE5dLegGOmxoFSH14uyQClsZN0RqDWxUjIjwAzhRGOEQ6btH6n4nHn/+AXpQuZYbAJFFAKHtI49OTQBUsoB/JXuHza/a5Xwl2HtfPxMkECIRAtyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnUFgZSjAsCsvnLpCcCQ1eJWCsyfI/CVfOufUY86Rpc=;
 b=lDMZUslBNdEjLeLaxgo+MBmDugmMnFpA8vnzIT3IVuO8BkS8xm4IAqaAUiz+0yhlyW+UZ6Bp/C8HfWSv0qv6qVsVFVCpUJt3Hl0OSNmesIJqnCwY/OqUMc+mAcCq93xUrqRnGyt+3lsd2meXIfmXVvme2yTyHVU0N9urLimRtOk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 21:56:51 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 21:56:51 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.csengg@gmail.com>, <geert+renesas@glider.be>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <heiko@sntech.de>, <atishp@rivosinc.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 08/10] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
Thread-Topic: [PATCH v3 08/10] riscv: dts: renesas: Add minimal DTS for
 Renesas RZ/Five SMARC EVK
Thread-Index: AQHYyS+CXmAo8qhj2U6alOFiZ8SwGK3hCb+A
Date:   Thu, 15 Sep 2022 21:56:51 +0000
Message-ID: <ce1bb9c5-c1e3-b6ff-ec8f-c9ae1f0bf3b4@microchip.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|IA1PR11MB6147:EE_
x-ms-office365-filtering-correlation-id: e44c2180-59de-49ae-2574-08da97653253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ym5kAgzaqBzMVE5aD/0ut+7e4Am9EwcVeKeB18HOW/Dknz923EqnXsE7qmha5Rqd5OxdDCSBmWMLSg3kOhTaWuSBkSpFYJMRZtFBWxTfD379V7+2JWb37vgfifvf0jmVfo24UbT0KiJcWxBqyJM7LUz1owWpqFEEifGPX+M6iRb3mhYxL++MM2K2t+MwJWK+t1GSfMTb71WzqENkxMTlRn0zCbSE90pa7DuVxvDpnaZRegGknSzGzHb8AolxcYpHMq7BBUzJm7tPzqbzA4Yuxyk1VBBBUTJ12M7tYOGvVlE9nr8CmGZwKyJMZ+Jq+lcrCR2gvmvNbx0pqAUqm/liSuDypS6RWOZ/ln8VQTgis3QrMSTWzRMgc+d09VEc3eKHnCBjybx9PunBQLR7A/jJ8JzOpDc/6k/PiMk9EpF3JkahpNwmqKj+64SUjsjrgmsSgeJdCHa9KHFkoe5p1RvxA3GpY+fOkWHk/H8sPLhKuOBO+kAMdbxoNuIO/fTx1oobCI9iGddmwqfuojw17pY+O81nEBEj5FFgeYuij/mssKIaNeaXvxq9Uo8S2u5/CgKXoFX6gbwlxsf521o2/oKYwTLMhVsAXmPIiwqrMzoDzODG11FWqXtcir6KEYHe2N3EQdaau7UOvLeNugIZdB25avnoOL5tgSoaUKf0tRuTN+zvq20Tt5vqSGXlxpFWd3bpgAX+8Oq5mtrL2ECFCUKnqBUBYLsHFuHLe2drwKomvLXvtf6rjwM3Z6/6LqV5Czp6t1Pcm4TrOC3Pt0SeW5jy7HeGU2q8GHdQba4FMLDytXUCDaWm4piIh81qTLP4I0uc6MUu0QgQBav79euRpRclJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199015)(71200400001)(122000001)(41300700001)(66556008)(31696002)(4326008)(38100700002)(66446008)(38070700005)(64756008)(91956017)(8936002)(110136005)(8676002)(26005)(31686004)(6506007)(53546011)(86362001)(5660300002)(316002)(83380400001)(6486002)(2906002)(76116006)(66946007)(186003)(478600001)(54906003)(2616005)(6512007)(66476007)(36756003)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUFJS2dyTEd1Y05hVFNUc2trWFg0NFZjbmVxM1Q1MVdsMUlZSDFwUTNTLzJt?=
 =?utf-8?B?NmxIRkladFZXay9kbzdsaXpUeGlHUnY4VjhoaDBiVXphN2xPWGVibnc5RTI4?=
 =?utf-8?B?WWhUUysrV1pHSG1TcDF0NUlheCt6L045R29jcFJGZ2VMamJER2xwdERJaGNp?=
 =?utf-8?B?UUhLRG9QcUx6QVdac05wYWVMWDROaTlEYWlyTWU4TjUvb2ZGVzd2Tnd2WkF0?=
 =?utf-8?B?LzBNODI5OG1palBrMzZyd1FUQit0YlJVSnBLUTQwb28rczFURFg4WHhUZTNL?=
 =?utf-8?B?MGVmOG1tbkkzT1VQQW96VUtJZXpKRVB1akdod2JXbkFiQ2pZaGw0TGc2L2N4?=
 =?utf-8?B?SUtQVXMydDB3Um1WejdUMlNUSFBTSGY4dnY0NDdZYW5ZOTl0Q2N5eGZkMVkv?=
 =?utf-8?B?NXl1ZUhFNlBsTVFwUmUyYXRmUldUWEZEdkxHTlhRWlhvekorZ0RjU3p3OWJa?=
 =?utf-8?B?bG9VN2tUa3g5NjRFcDVGRWtZMXpZS09QOGxuZUlaMC85OUtZUll1NjZCTi9k?=
 =?utf-8?B?MWVJdUhJSTl6NDc1aGNCaFVDUnA5bGM1TjBEWm84MG11elJ2VExnUmFza0dq?=
 =?utf-8?B?aXJMMktFUjZTMWcxYUV3ZTZsNm5HY3VJTEozWjZtNW9URFNDRHhVbzF1S2xF?=
 =?utf-8?B?SXhFSXpEWEFXcnFEOXRjTWdiTlFUN0JyNTExaThRT2p1dHQzVEg2eUFtRWl6?=
 =?utf-8?B?YjAzcEJtRkg2bnZBS0xIT0g3Q2Z5TlhZRldYdGtxQlBZaEJxSHZoT2UySktw?=
 =?utf-8?B?MXgvU2N2K0pjT01kMTNqRGE5MHRKTE81dDZMQ3RpeG01Y0tSMEhoSnFNanVE?=
 =?utf-8?B?RVJGSzB2UFpmdllKQ0FSY0pDQUVMY0hkdjVuZEt6dWg1UWpWYmtxcmlha2U4?=
 =?utf-8?B?dHBsMFBkTlBMcVJRY3pxbE45UUN2M0hkSWlJTFQ2TWdoOGVWdFZ2RHY1VTUw?=
 =?utf-8?B?bkZCWHY1anVYN054MW5ZNnNjUTdkUUhZSHRsUWtJd1luK3VRVGVyMExGNlRu?=
 =?utf-8?B?SitHQUtuV2VBbHNzOHZKR0tlWTZGWFJvdEJYRDgvSWVVTFpraTJuU2liSTJo?=
 =?utf-8?B?aXg5dGxnTnR5Z08yeHlra3FoU3kvT0dNYlhRT1ppQ29xOUFtNnVnL2EvWXBK?=
 =?utf-8?B?SmpLeHB6ZnNjMFV0RkdYNnJEc3E3RVM4SjVrT0NHZzF4TmI1VThCUzh6VDgx?=
 =?utf-8?B?U2hhcFpnRVNHTW8zSE5rTHp3KzFGQnRkZDA4aW1aNldUMkMwZmpZZzB0Tkxy?=
 =?utf-8?B?djA3V2wwZmhMTjFZZTBETjJyUFZMRnN3Q0VPVCtwSlp0N2dvMjN3YUZSdXc4?=
 =?utf-8?B?QzIweEIvWjl1aHFzemdjdnlMdllTUDlQSkpSOEt6MkU1Sml1bWpDZjgzaDRw?=
 =?utf-8?B?b29PMU9SVnFWWlovWUZhTFVDVGdJWitLSHc5UzRVcGFnQ3ExQVBMeFU1bzFN?=
 =?utf-8?B?TWhoMFZUK3BtcE5BRWhOaVM3enhOQTVHMW8vdU9XVDRZWTlLWFhUaTd5UnNi?=
 =?utf-8?B?VXBZMUhuR0pnOGVSYTRnOWN3bjhScE1ob2MxMW1Zc2lJUmJ6Ky8wL0UvU2ha?=
 =?utf-8?B?YVRjd3JvalUybVgzckw4Z3JwcWxmM1JvZEdOSXdCRzBRUysraEpOZGNabmRN?=
 =?utf-8?B?akMvZWY1TjhDcEVlSVhhZXJmKzRrQUNoN1g0a01GNDd5QzU3Y1kyd3ZmL3dh?=
 =?utf-8?B?eWZPRDc4ZzFjdUVTaUpFVUNLcmdmTHBkaER2Zzc5WjJzQ1h6a3dOV2pkbGg0?=
 =?utf-8?B?ZnlIQTMvSlVtYmFNL3BGeFN3MUNyWVg5c0wxZXRrTnpNVGFyS281bEJyeGRT?=
 =?utf-8?B?ekhYY2dWM0FSbWRka1B3VnlXYXNudnRCeVc2ZzdPd2dKdmpSOTlVQnVIRGhW?=
 =?utf-8?B?bk0vbGlENHRKYmpZZlVGU3cxNkx5VUZyTGJjUDJaRml1aVA0bElMcVI2eDU5?=
 =?utf-8?B?eTl0L3VsSWIwaytXWkp1UGlkOXk5eTJzR2xVRkZvUnJ3ZElwWlFCYm5TaXRy?=
 =?utf-8?B?SGR6MVVuMnFReGRiQlVIUTlva0R4ZmdONjdlM2pwWjY1UmhnMzVKRjU5akM2?=
 =?utf-8?B?bXZwYkY1b0hrcXZ3Z3BTR3FRQ2YvR1lXMkdFYm5oSnFTK3ZpT21xSkdGTits?=
 =?utf-8?B?S2hXOElhVVR3aWRobWpYVC9qaVlxWWJ0UEZUYUlUeVZJVEtheXplMmExNDdM?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49F9DEE055515D4CB6820817E651CBD9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44c2180-59de-49ae-2574-08da97653253
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 21:56:51.7522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uq9YU3TZBbsiPc/4Nv+6OacNo17dRBxSjH9xy58kIRMSChfLJ26DPWdWAJAKIl9PUmM6vP1dFzCD4iYMkIZriR1RtalOHXa/2Fuc6fO+ydI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDkvMjAyMiAxOToxNSwgUHJhYmhha2FyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5t
YWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IEVuYWJsZSB0aGUgbWluaW1hbCBi
bG9ja3MgcmVxdWlyZWQgZm9yIGJvb3RpbmcgdGhlIFJlbmVzYXMgUlovRml2ZQ0KPiBTTUFSQyBF
Vksgd2l0aCBpbml0cmFtZnMuDQo+IA0KPiBCZWxvdyBhcmUgdGhlIGJsb2NrcyBlbmFibGVkOg0K
PiAtIENQRw0KPiAtIENQVTANCj4gLSBERFIgKG1lbW9yeSByZWdpb25zKQ0KPiAtIFBJTkNUUkwN
Cj4gLSBQTElDDQo+IC0gU0NJRjANCj4gDQo+IE5vdGUgd2UgaGF2ZSBkZWxldGVkIHRoZSBub2Rl
cyBmcm9tIHRoZSBEVCBmb3Igd2hpY2ggc3VwcG9ydCBuZWVkcyB0byBiZQ0KPiBhZGRlZCBmb3Ig
UlovRml2ZSBTb0MgYW5kIGFyZSBlbmFibGVkIGJ5IFJaL0cyVUwgU01BUkMgRVZLIFNvTS9jYXJy
aWVyDQo+IGJvYXJkIERUUy9JLg0KDQppZGssIEkgYW0gbm90IHN1cmUgd2hhdCB0byB0aGluayBv
ZiB0aGlzIGFwcHJvYWNoLg0KDQpXaGF0IGRvIHlvdSBtZWFuIGJ5ICJmb3Igd2hpY2ggc3VwcG9y
dCBuZWVkcyB0byBiZSBhZGRlZCI/IElmIHRoZSBzdXBwb3J0DQpkb2VzIG5vdCBleGlzdCB5ZXQs
IHRoZW4gaXMgc3VyZWx5IHlvdSBjYW4ganVzdCBhZGQgdGhlIG5vZGVzIGFuZCBpdCB3aWxsDQpi
ZSBmaW5lPw0KDQpDb25mdXNlZCwNCkNvbm9yLg0KDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExh
ZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4g
LS0tDQo+IHYyLT52Mw0KPiAqIERyb3BwZWQgUkIgdGFncyBmcm9tIENvbm9yIGFuZCBHZWVydA0K
PiAqIE5vdyByZS11c2luZyB0aGUgU29NIGFuZCBjYXJyaWVyIGJvYXJkIERUUy9JIGZyb20gUlov
RzJVTA0KPiANCj4gdjEtPnYyDQo+ICogTmV3IHBhdGNoDQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9i
b290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgIDEgKw0KPiAgYXJjaC9yaXNjdi9i
b290L2R0cy9yZW5lc2FzL01ha2VmaWxlICAgICAgICAgIHwgIDIgKw0KPiAgLi4uL2Jvb3QvZHRz
L3JlbmVzYXMvcjlhMDdnMDQzZjAxLXNtYXJjLmR0cyAgIHwgMjcgKysrKysrKysrDQo+ICAuLi4v
Ym9vdC9kdHMvcmVuZXNhcy9yemZpdmUtc21hcmMtc29tLmR0c2kgICAgfCA0MiArKysrKysrKysr
KysrKw0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9yZW5lc2FzL3J6Zml2ZS1zbWFyYy5kdHNpIHwg
NTYgKysrKysrKysrKysrKysrKysrKw0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAxMjggaW5zZXJ0aW9u
cygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNhcy9N
YWtlZmlsZQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNh
cy9yOWEwN2cwNDNmMDEtc21hcmMuZHRzDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNj
di9ib290L2R0cy9yZW5lc2FzL3J6Zml2ZS1zbWFyYy1zb20uZHRzaQ0KPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNhcy9yemZpdmUtc21hcmMuZHRzaQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvTWFrZWZpbGUgYi9hcmNoL3Jpc2N2
L2Jvb3QvZHRzL01ha2VmaWxlDQo+IGluZGV4IGZmMTc0OTk2Y2RmZC4uYjBmZjVmYmFiYjBjIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL01ha2VmaWxlDQo+ICsrKyBiL2FyY2gv
cmlzY3YvYm9vdC9kdHMvTWFrZWZpbGUNCj4gQEAgLTMsNSArMyw2IEBAIHN1YmRpci15ICs9IHNp
Zml2ZQ0KPiAgc3ViZGlyLXkgKz0gc3RhcmZpdmUNCj4gIHN1YmRpci0kKENPTkZJR19TT0NfQ0FO
QUFOX0syMTBfRFRCX0JVSUxUSU4pICs9IGNhbmFhbg0KPiAgc3ViZGlyLXkgKz0gbWljcm9jaGlw
DQo+ICtzdWJkaXIteSArPSByZW5lc2FzDQo+IA0KPiAgb2JqLSQoQ09ORklHX0JVSUxUSU5fRFRC
KSA6PSAkKGFkZHN1ZmZpeCAvLCAkKHN1YmRpci15KSkNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvcmVuZXNhcy9NYWtlZmlsZSBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNh
cy9NYWtlZmlsZQ0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAu
LjJkM2Y1NzUxYTY0OQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9k
dHMvcmVuZXNhcy9NYWtlZmlsZQ0KPiBAQCAtMCwwICsxLDIgQEANCj4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4gK2R0Yi0kKENPTkZJR19BUkNIX1I5QTA3RzA0MykgKz0g
cjlhMDdnMDQzZjAxLXNtYXJjLmR0Yg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0
cy9yZW5lc2FzL3I5YTA3ZzA0M2YwMS1zbWFyYy5kdHMgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3Jl
bmVzYXMvcjlhMDdnMDQzZjAxLXNtYXJjLmR0cw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBp
bmRleCAwMDAwMDAwMDAwMDAuLjk3NDdmMzBjNWRiNQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBi
L2FyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNhcy9yOWEwN2cwNDNmMDEtc21hcmMuZHRzDQo+IEBA
IC0wLDAgKzEsMjcgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1v
bmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKy8qDQo+ICsgKiBEZXZpY2UgVHJlZSBTb3VyY2UgZm9y
IHRoZSBSWi9GaXZlIFNNQVJDIEVWSw0KPiArICoNCj4gKyAqIENvcHlyaWdodCAoQykgMjAyMiBS
ZW5lc2FzIEVsZWN0cm9uaWNzIENvcnAuDQo+ICsgKi8NCj4gKw0KPiArL2R0cy12MS87DQo+ICsN
Cj4gKy8qDQo+ICsgKiBESVAtU3dpdGNoIFNXMSBzZXR0aW5nDQo+ICsgKiAxIDogSGlnaDsgMDog
TG93DQo+ICsgKiBTVzEtMiA6IFNXX1NEMF9ERVZfU0VMICAgICAgKDA6IHVTRDsgMTogZU1NQykN
Cj4gKyAqIFNXMS0zIDogU1dfRVQwX0VOX04gICAgICAgICAoMDogRVRIRVIwOyAxOiBDQU4wLCBD
QU4xLCBTU0kxLCBSU1BJMSkNCj4gKyAqIFBsZWFzZSBjaGFuZ2UgYmVsb3cgbWFjcm9zIGFjY29y
ZGluZyB0byBTVzEgc2V0dGluZyBvbiBTb00NCj4gKyAqLw0KPiArI2RlZmluZSBTV19TVzBfREVW
X1NFTCAxDQo+ICsjZGVmaW5lIFNXX0VUMF9FTl9OICAgIDENCj4gKw0KPiArI2luY2x1ZGUgInI5
YTA3ZzA0My5kdHNpIg0KPiArI2luY2x1ZGUgInJ6Zml2ZS1zbWFyYy1zb20uZHRzaSINCj4gKyNp
bmNsdWRlICJyemZpdmUtc21hcmMuZHRzaSINCj4gKw0KPiArLyB7DQo+ICsgICAgICAgbW9kZWwg
PSAiUmVuZXNhcyBTTUFSQyBFVksgYmFzZWQgb24gcjlhMDdnMDQzZjAxIjsNCj4gKyAgICAgICBj
b21wYXRpYmxlID0gInJlbmVzYXMsc21hcmMtZXZrIiwgInJlbmVzYXMscjlhMDdnMDQzZjAxIiwg
InJlbmVzYXMscjlhMDdnMDQzIjsNCj4gK307DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jv
b3QvZHRzL3JlbmVzYXMvcnpmaXZlLXNtYXJjLXNvbS5kdHNpIGIvYXJjaC9yaXNjdi9ib290L2R0
cy9yZW5lc2FzL3J6Zml2ZS1zbWFyYy1zb20uZHRzaQ0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjg1NDdjMjczZjE0MA0KPiAtLS0gL2Rldi9udWxsDQo+ICsr
KyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvcmVuZXNhcy9yemZpdmUtc21hcmMtc29tLmR0c2kNCj4g
QEAgLTAsMCArMSw0MiBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
LW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiArLyoNCj4gKyAqIERldmljZSBUcmVlIFNvdXJjZSBm
b3IgdGhlIFJaL0ZpdmUgU01BUkMgRVZLIFNPTQ0KPiArICoNCj4gKyAqIENvcHlyaWdodCAoQykg
MjAyMiBSZW5lc2FzIEVsZWN0cm9uaWNzIENvcnAuDQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUg
PGFybTY0L3JlbmVzYXMvcnpnMnVsLXNtYXJjLXNvbS5kdHNpPg0KPiArDQo+ICsvIHsNCj4gKyAg
ICAgICBhbGlhc2VzIHsNCj4gKyAgICAgICAgICAgICAgIC9kZWxldGUtcHJvcGVydHkvIGV0aGVy
bmV0MDsNCj4gKyAgICAgICAgICAgICAgIC9kZWxldGUtcHJvcGVydHkvIGV0aGVybmV0MTsNCj4g
KyAgICAgICB9Ow0KPiArDQo+ICsgICAgICAgY2hvc2VuIHsNCj4gKyAgICAgICAgICAgICAgIGJv
b3RhcmdzID0gImlnbm9yZV9sb2dsZXZlbCI7DQo+ICsgICAgICAgfTsNCj4gK307DQo+ICsNCj4g
KyNpZiAoU1dfU1cwX0RFVl9TRUwpDQo+ICsvZGVsZXRlLW5vZGUvICZhZGM7DQo+ICsjZW5kaWYN
Cj4gKw0KPiArI2lmICghU1dfRVQwX0VOX04pDQo+ICsvZGVsZXRlLW5vZGUvICZldGgwOw0KPiAr
I2VuZGlmDQo+ICsvZGVsZXRlLW5vZGUvICZldGgxOw0KPiArDQo+ICsvZGVsZXRlLW5vZGUvICZv
c3RtMTsNCj4gKy9kZWxldGUtbm9kZS8gJm9zdG0yOw0KPiArDQo+ICsvZGVsZXRlLW5vZGUvICZy
ZWdfMXA4djsNCj4gKy9kZWxldGUtbm9kZS8gJnJlZ18zcDN2Ow0KPiArDQo+ICsvZGVsZXRlLW5v
ZGUvICZzZGhpMDsNCj4gKw0KPiArI2lmICEoU1dfU1cwX0RFVl9TRUwpDQo+ICsvZGVsZXRlLW5v
ZGUvICZ2Y2NxX3NkaGkwOw0KPiArI2VuZGlmDQo+ICsNCj4gKy9kZWxldGUtbm9kZS8gJndkdDA7
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3JlbmVzYXMvcnpmaXZlLXNtYXJj
LmR0c2kgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3JlbmVzYXMvcnpmaXZlLXNtYXJjLmR0c2kNCj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi4zZmRlNzE5MjI0MWUN
Cj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3JlbmVzYXMvcnpm
aXZlLXNtYXJjLmR0c2kNCj4gQEAgLTAsMCArMSw1NiBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiArLyoNCj4gKyAqIERl
dmljZSBUcmVlIFNvdXJjZSBmb3IgdGhlIFJaL0ZpdmUgU01BUkMgRVZLIGNhcnJpZXIgYm9hcmQN
Cj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIgUmVuZXNhcyBFbGVjdHJvbmljcyBDb3Jw
Lg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlIDxhcm02NC9yZW5lc2FzL3J6ZzJ1bC1zbWFyYy5k
dHNpPg0KPiArDQo+ICsvIHsNCj4gKyAgICAgICBhbGlhc2VzIHsNCj4gKyAgICAgICAgICAgICAg
IC9kZWxldGUtcHJvcGVydHkvIGkyYzA7DQo+ICsgICAgICAgICAgICAgICAvZGVsZXRlLXByb3Bl
cnR5LyBpMmMxOw0KPiArICAgICAgIH07DQo+ICt9Ow0KPiArDQo+ICsvZGVsZXRlLW5vZGUvICZh
dWRpb19jbGsxOw0KPiArL2RlbGV0ZS1ub2RlLyAmYXVkaW9fY2xrMjsNCj4gKy9kZWxldGUtbm9k
ZS8gJmF1ZGlvX21jbG9jazsNCj4gKw0KPiArL2RlbGV0ZS1ub2RlLyAmY2FuZmQ7DQo+ICsNCj4g
Ky9kZWxldGUtbm9kZS8gJmNwdV9kYWk7DQo+ICsNCj4gKy9kZWxldGUtbm9kZS8gJmVoY2kwOw0K
PiArL2RlbGV0ZS1ub2RlLyAmZWhjaTE7DQo+ICsNCj4gKy9kZWxldGUtbm9kZS8gJmhzdXNiOw0K
PiArDQo+ICsvZGVsZXRlLW5vZGUvICZpMmMwOw0KPiArL2RlbGV0ZS1ub2RlLyAmaTJjMTsNCj4g
Kw0KPiArL2RlbGV0ZS1ub2RlLyAmb2hjaTA7DQo+ICsvZGVsZXRlLW5vZGUvICZvaGNpMTsNCj4g
Kw0KPiArJnBpbmN0cmwgew0KPiArICAgICAgIC9kZWxldGUtcHJvcGVydHkvIHBpbmN0cmwtMDsN
Cj4gKyAgICAgICAvZGVsZXRlLXByb3BlcnR5LyBwaW5jdHJsLW5hbWVzOw0KPiArfTsNCj4gKw0K
PiArL2RlbGV0ZS1ub2RlLyAmcGh5cnN0Ow0KPiArDQo+ICsvZGVsZXRlLW5vZGUvICZzZGhpMTsN
Cj4gKw0KPiArL2RlbGV0ZS1ub2RlLyAmc25kX3J6ZzJsOw0KPiArDQo+ICsvZGVsZXRlLW5vZGUv
ICZzcGkxOw0KPiArDQo+ICsvZGVsZXRlLW5vZGUvICZzc2kxOw0KPiArDQo+ICsvZGVsZXRlLW5v
ZGUvICZ1c2IwX3ZidXNfb3RnOw0KPiArDQo+ICsvZGVsZXRlLW5vZGUvICZ1c2IyX3BoeTA7DQo+
ICsvZGVsZXRlLW5vZGUvICZ1c2IyX3BoeTE7DQo+ICsNCj4gKy9kZWxldGUtbm9kZS8gJnZjY3Ff
c2RoaTE7DQo+IC0tDQo+IDIuMjUuMQ0KPiANCg0K
