Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440A962A10C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiKOSHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKOSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:06:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96AF12D3B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668535599; x=1700071599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qtoyut3+YM7mG0RZ8MA/FZligstEeM5Cj3OLMaiR4So=;
  b=19kxEpp6CkadgV62GaHluuldoESgFm8EeVPmDeWut/RrjlfghVBsdel/
   NH+moL86ursJqR6K6A2+TIlHSUaX/tUhoOCXp3yb45Ypg+g8ACeE52+81
   UEcEPcgQbYFO7Jd4kRiGfZaC7EmwqZKM0KEgK9P7vXRrOqVs4wKs1mBCB
   VA1BoUA8ydvz4JLTyHmwYyZg8IYAbE2Qd+FXv77uIiQr9q9N9ybhdGloi
   ohxW7hBMyttdyg9o4NPu6Tku4W8xmDEGd7/3BbuelmpCYMlF2pcbE3eKs
   FoWrm603DP+Ry37Is0UDq0m5woAPWPgDnWD4+VY2Zx6jvDrAYqMbau/tS
   w==;
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="189089862"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 11:06:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 11:06:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 15 Nov 2022 11:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+Zsw9EjaJxqGVqCbG+SRV7RqeHi5XP/aSDojksyIzjZdZS3b5vojPbz1Z52Op8tvdSZZ9Sq8+cKgoLhMCXxAsgWMJKVGrp4eCmDeXGa308l34rS5JFr8R6Ath7SBJWTkVUbX07qj6o12moNk9jwwBE26AX9nKvPE2RQBy4UWkiSNrtuy8tcqDerhc0bWG/GhFhCvxfHX6wtc81oB1ZyfZ1Evfw5+itzfZkWOYInsMJezPwzt3cMrkTgcrCg4uO6Xb/dQ334N7pqLL5W2sbfxeZhfZL/Bb7jHPi6SLEuym96P6K5hZ/pEjMXwt/70lWCI7BF6LN5DKPFBuzgF867yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qtoyut3+YM7mG0RZ8MA/FZligstEeM5Cj3OLMaiR4So=;
 b=dkX50zkaY/EY7734UPpgDe9KMqTE0PTrSJytDw55qQWxVlnlBUSLV3bvGTYnwqyyXz/5e9nXn1RDhEm0Hk9lATGI5UFhlBz7cIUEzemZCL4q3UDHxorAVJ55frnTBOJYR3wdRTLmEay/mCpKpIOrYtmtzv6EP9fWZJ40NjbCFM59BxY1CpkxryZz5l/WsUtFo857usKtnbGkgzaSMm+9J2eQ2y5Zk6Hy7G352pP5gvrLDHMJvos+1z715sY7+BviuUvoUwPfmwvmpsa7604oKsX8ESGkdd/hByCA0Z4rdeN8zJWbT08SMcmUSumB4rUN5QAh2ZjJVCf9MNV8fvELGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qtoyut3+YM7mG0RZ8MA/FZligstEeM5Cj3OLMaiR4So=;
 b=EQ9v01ZdksrWIZZj0Y2opFMMKTd3WKaAREXYjWnDt5+GAtH5/NwqjYsOhjwYbWzZR951fl7SGx9cKOJPOTVgJUwYI5R4F2WCAOJeiZXoIc+yzqgnEuEjfVIHUx0MxXQDwNOI89WXso6DSwVcPvgk520JoHtiW9ska0J7R3j+ES0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 18:06:35 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 18:06:34 +0000
From:   <Conor.Dooley@microchip.com>
To:     <debug@rivosinc.com>
CC:     <aou@eecs.berkeley.edu>, <jan.kiszka@siemens.com>,
        <kbingham@kernel.org>, <linux-kernel@vger.kernel.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ajones@ventanamicro.com>, <linux-riscv@lists.infradead.org>,
        <bjorn@kernel.org>, <atishp@rivosinc.com>
Subject: Re: [PATCH v3] scripts/gdb: add lx_current support for riscv
Thread-Topic: [PATCH v3] scripts/gdb: add lx_current support for riscv
Thread-Index: AQHY+M+F8Me2zhG+JUa8j8R4JavkwK5ADjmAgAA1SQCAAATcAA==
Date:   Tue, 15 Nov 2022 18:06:34 +0000
Message-ID: <4f293c39-6a0e-dd25-9ed2-10088bb971e1@microchip.com>
References: <20221115012917.1781185-1-debug@rivosinc.com>
 <20221115084923.1822572-1-debug@rivosinc.com> <Y3OkY6myfea00BaK@wendy>
 <CAKC1njRi9C0m3JKpu0ebAFCC25161EST=tFFWiAj1yZBbnak6A@mail.gmail.com>
In-Reply-To: <CAKC1njRi9C0m3JKpu0ebAFCC25161EST=tFFWiAj1yZBbnak6A@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|DM6PR11MB4723:EE_
x-ms-office365-filtering-correlation-id: 8e58095f-c478-4350-fece-08dac7342200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFoVgzV6gH6MtOcIE8zLKYZ8zxA8FM6mglKDRE31PIQn3CSnVLwp4gGqeaCoAyqa0vSSWPfC58qsngz2Ip/PErwLGmA8qQ1Dr2d6mI4/dORAdwOp8O61Vzqm0mAxpT0WxOh3AxlQgwYZJQgNEOujgJm0mctFFMqs1QwJR2LrvrljIXUAZNWxLFuXwIFRhTugUdWrwK+ifh05Vq5bhwjid0nCvvGZYCcIwqQe9/ErnhAdLhCgIOeQZ4cWlUjI8qVUx82PlnT6nxgiJ7ofKkQ0xZagUpNyGAhd7rrj3DUW5/9QgekUPHdOAslIpCf1BtIiWOKDqTnacoPrqBsqMd7cKwIzzeXrqfaa0wNWWcjT97eXvRDEdP7dTQNXyn47iCquYTrY9rS+mg/dyy2MnH5fECr0+4nZvs1s9J8y/L2CeSIs5vnP59fneja0wMmmksQvh9yfmR99UZMpRzEDgBRwbIqP35CTvFDObW7jQW5KuTpuorj0fEMhg6wfLu9hyWeAhJSa9KcVWRINB7jY7Q2X11pczw/c6RFSgVUAL9uQsj/uI2f+0O+3u88u+qdm+EnBCw0FuVcO/rUxJB/RD3T2AOfpwCpZeiObVf4TU4qNYnFiZhmbbSXUiJXJhWWCZ8rU1QtVSq+TrBgb0Zq+6fTUJFQH7c1xsujJhrtNF3S0iLvXaubCwusYTZPy4aWNSoVBlKjqH5iShHsKXFGw28pi1ijDZ/prDIGxP5PK8fK2v3ZQY5updjoR6bkN12W2km+sTm41dyIyRNMdTuYzyofCoDYSPJmbodCGL6yWfaQGuG9Trm9vSXvaQpAgA60bdVGtNX5TGgboSWfphX9mMabvKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(31686004)(83380400001)(7416002)(186003)(5660300002)(2616005)(8936002)(41300700001)(38070700005)(122000001)(6512007)(26005)(4326008)(38100700002)(36756003)(66476007)(6486002)(478600001)(66446008)(76116006)(66556008)(64756008)(66946007)(53546011)(71200400001)(6916009)(316002)(91956017)(6506007)(8676002)(2906002)(54906003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXBQVlZzZWsyVzYycFVsREhBYjJ2VXVqZUlYQ21QeEVYZ0NqNVNqS3h1QXo3?=
 =?utf-8?B?TnFWbENRUGVoRTUyUUpsaTZReHNIS1o4ZzR4TVR3eEdtNkN3THN0cy9vSTRp?=
 =?utf-8?B?R3ZjNThFOGpLLzBsL3k5SVZsZTFNYVQ1RXRsWnNZQklvUk51MGFyeXdMaVZY?=
 =?utf-8?B?Nk5xVnd0NjBuNnVUcmpHVElFQmNZbmRERlMycmRCaVY2Rk01b2dLKzloTG4y?=
 =?utf-8?B?ejhBQXRSbVBVNm5neTU2VU1WUm9zZjFEZzdiTVdPUENxcHVkVGVpS2dobUNI?=
 =?utf-8?B?OGJnVFFnb3cxK3ZxWEJQaHdGT0ZvTWtXRTV0bVBDb3liTEc3R0pnNnJDZCtE?=
 =?utf-8?B?WmVLb1MrUnNSWTN2Yk1mUjdla1drTTdXMkRRSm5mL01RNFMzVkF5OXczOG9V?=
 =?utf-8?B?Y25VMjF3bDNCYS9kSzQ5UVQ5dW5KOW51N21XelpaenZkUXU5MkdudE5vN1Uz?=
 =?utf-8?B?bERWM09ibDBkR3NmbjlFNzI2RWZpQlFWc2hvcGJjeDl1d3RIN0dyc0VkREdJ?=
 =?utf-8?B?bmx4clVDeisxLzVhV1cyV0ZucWtkbzR6eUZtYjFhdXIvcERMQjNuaTFXWU5z?=
 =?utf-8?B?WmllYXdmdnYrSEIxMVNQTFg4cGxBdC83b3NVZFpwbEdpby8vVFYreTNHbkIz?=
 =?utf-8?B?UjFockxmQ25MVVFQenBsNDZQUDJESjhnQVdUbkkrZW0xcVNXRy9SMmFFNFlX?=
 =?utf-8?B?c3ZjdEx0Ynk5eGs1ZjAvVnNUWHJCaFExLzJYYUlqcFZibDBHa0JSK0tIamRr?=
 =?utf-8?B?RnV5V2Nld2RpQzdIeUdZU01lMW1kS3lNcEVLNisvb29KNnJ3YXpPbEEzVlNK?=
 =?utf-8?B?NDZRR1BydDRQdCtock5neVM2ZGZpbVhuTWxQT0EzVG1tMHNXYytZbnBhUW96?=
 =?utf-8?B?Nk1pOE1HeU05ZW9mRkFDTGFyNnZnenBvVGZnVEdwZmp3WDV6cWNLWGhpUjln?=
 =?utf-8?B?OWRUQnBZczhSN1R0UEVPMUtKU21LQngxUFBRL0N1aFRlWVlQWS80OHJkendt?=
 =?utf-8?B?bDdVRkNKSGlicnc0eEpvVDRueEwvK3NZWkxmVG5HdnY3ZlE2YkNsQmkzdWxh?=
 =?utf-8?B?aWdBcEpMSnFOdjVMZEJlckZuV2docWNpYmFaWEZ5enBwZDhjMUFjNXBoVnY5?=
 =?utf-8?B?cGxWaWxnSFZZVWlxVXhQTHNGYStYbmhCM1IyVjI0bS9IWndkbHhQQWR5VmVW?=
 =?utf-8?B?NHNKT0ljd2swZkZiQnR1K1c3WTBVMmJ6OFJNb0tkcEdDbWJ5TTBqMVZGTHBS?=
 =?utf-8?B?MXJsL0IyQy8zMHZldzhjc1ZWWFJFVjZuSGprNEtwN2tPa1RzbXNDcTN3N1JJ?=
 =?utf-8?B?NllabzNNQTNPaklEZUtrQkN4QlhUQmtGMXo2YjlDdGJVUnV0V3dsRXBRM2Mx?=
 =?utf-8?B?R0VOcmM0RDV0bWE0NGxjdkY3KzFaa2V4dTdlMzNaRnB0d2wwbHBuQTFHMUxw?=
 =?utf-8?B?S05ISm1jeW1FR0R5N3dvYkhWQk8rL2JCc0p3TEE1dlVLZlVlUENCSElhWjhw?=
 =?utf-8?B?OHc5aXhwSDAraXBHTkV4UXNiUXoxWm9kWHNNZUJQN0JBMGF5UmlyejRuR1VE?=
 =?utf-8?B?bEVvYUVKbk5pMGhXbm0wMXJlWk1YVlMwSWxJSmQxM0NhNktjMHhnUGFncDlS?=
 =?utf-8?B?aDNSZi8yd2ZVZGlEdHBCbVVyaDdmakxPNW1zTXhKRi9hYzRjK0RBaEFPSHBE?=
 =?utf-8?B?VVkvSFVKQU9xYWZFd2hEeFRkMkZ2aWRRRWZCcy9KbHFhUGIyekM0QmVxc2xH?=
 =?utf-8?B?dDlDZjdqU0hCRlU5VEhuSlRLa2xENEhQL0FySUJHNk1iUjJEREhEK3RncFFm?=
 =?utf-8?B?TWEzQmw5aU1CSEtkeXNQSHBLN2RvcXh6RmtkUHpnRDkzaCtBU25jMmgvdEY5?=
 =?utf-8?B?ck1lekcwL2VQL1BET200blNzSXJPVlZtZFBTSHNQbHZGckh1UmdueEVLMXp4?=
 =?utf-8?B?UjM0L1I0RjNpYjZpTitybGxLMm1EbkNRWHl5dGlKZE13ZjY3dXAwa2ZySEpI?=
 =?utf-8?B?ZEx1NUNVa2dCVUxQTWhQMlNrVVRvMDF1RkpPN04rOWdMaElQcjBsZld2UGNS?=
 =?utf-8?B?UkRKQlVXUXRSOG5yREROamxNSWo2QlZ2UzZuYmFEQ0xwSzdiNjB4eUlTeXV2?=
 =?utf-8?Q?/A7lws9Oai97zp4sTpioAj2+s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF9D2E4133BC5349BE6DAB48F81485CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e58095f-c478-4350-fece-08dac7342200
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 18:06:34.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHep0yOkNaQ8gtcMAad4k/zrxxYB4/FJ81jwtdqkLF5nt/SrKBNGdje1cfWq2rZGKcMbPyXY5PoJQCqf0EbgienXti9fmSHWc0YI0uYjUew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IERlZXBhaywNCg0KT24gMTUvMTEvMjAyMiAxNzo0OSwgRGVlcGFrIEd1cHRhIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gU2luY2UgSSBhbSBuZXcgdG8g
YWxsIHRoaXMuIEkndmUgaGFkIHNvbWUgb3ZlcnNpZ2h0wqBhbmQgYW0gc3RpbGwgbGVhcm5pbmfC
oHRoZSBmbG93Lg0KPiBSZXN0IGlubGluZS4NCg0KTm8gd29ycmllcyBjaGllZi4gV29ydGggbm90
aW5nIGlzIHRoYXQgdGhpcyBtYWlsIGNhbWUgaW4gaHRtbA0KZm9ybSwgd2hpY2ggdGhlIG1haWxp
bmcgbGlzdHMgcmVqZWN0LiBOb29uZSBvdXRzaWRlIG9mIHRoZQ0KZGlyZWN0IENDIGxpc3Qgd2ls
bCBzZWUgdGhpcyBtYWlsLiBNYXkgYmUgd29ydGggYXNraW5nIHNvbWUNCm9mIHRoZSBvdGhlciBS
aXZvcyBsYWRzIGhvdyB0aGV5IGRvIHRoZWlyIHBsYWluIHRleHQgZW1haWxpbmcuDQoNCmlrIFBh
bG1lcidzIGdvdCBoaXMgaGFuZCByb2xsZWQgc3R1ZmYsIHNvIG1heWJlIGhlJ3Mgbm90IHRoZQ0K
YmVzdCB0byBhc2sgLSBidXQgdHJ5IEJqb3JuIG9yIEF0aXNoPw0KDQo+IA0KPiBPbiBUdWUsIE5v
diAxNSwgMjAyMiBhdCA2OjM4IEFNIENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hp
cC5jb20gPG1haWx0bzpjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4+IHdyb3RlOg0KPiANCj4g
ICAgIEhleSBEZWVwYWssDQo+IA0KPiAgICAgT24gVHVlLCBOb3YgMTUsIDIwMjIgYXQgMTI6NDk6
MjNBTSAtMDgwMCwgRGVlcGFrIEd1cHRhIHdyb3RlOg0KPiAgICAgPiBjc3Jfc3NjcmF0Y2ggQ1NS
IGhvbGRzIGN1cnJlbnQgdGFza19zdHJ1Y3QgYWRkcmVzcyB3aGVuIGhhcnQgaXMgaW4NCj4gICAg
ID4gdXNlciBzcGFjZS4gVHJhcCBoYW5kbGVyIG9uIGVudHJ5IHNwaWxscyBjc3Jfc3NjcmF0Y2gg
aW50byAidHAiICh4MikNCj4gICAgID4gcmVnaXN0ZXIgYW5kIHplcm9lcyBvdXQgY3NyX3NzY3Jh
dGNoIENTUi4gVHJhcCBoYW5kbGVyIG9uIGV4aXQgcmVsb2Fkcw0KPiAgICAgPiAidHAiIHdpdGgg
ZXhwZWN0ZWQgdXNlciBtb2RlIHZhbHVlIGFuZCBwbGFjZSBjdXJyZW50IHRhc2tfc3RydWN0IGFk
ZHJlc3MNCj4gICAgID4gYWdhaW4gaW4gY3NyX3NjcmF0Y2ggQ1NSLg0KPiAgICAgPg0KPiAgICAg
PiBUaGlzIHBhdGNoIGFzc3VtZXMgInRwIiBpcyBwb2ludGluZyB0byB0YXNrX3N0cnVjdC4gSWYg
dmFsdWUgaW4NCj4gICAgID4gY3NyX3NjcmF0Y2ggaXMgbnVtZXJpY2FsbHkgZ3JlYXRlciB0aGFu
ICJ0cCIgdGhlbiBpdCBhc3N1bWVzIGNzcl9zY3JhdGNoDQo+IA0KPiAgICAgbml0OiBzL3NjcmF0
Y2gvc3NjcmF0Y2gvID8NCj4gDQo+IA0KPiBXaWxsIGZpeCBpdC4NCj4gwqANCj4gDQo+IA0KPiAg
ICAgPiBpcyBjb3JyZWN0IGFkZHJlc3Mgb2YgY3VycmVudCB0YXNrX3N0cnVjdC4gVGhpcyBsb2dp
YyBob2xkcyB3aGVuDQo+ICAgICA+wqAgwqAgLSBoYXJ0IGlzIGluIHVzZXIgc3BhY2UsICJ0cCIg
d2lsbCBiZSBsZXNzIHRoYW4gY3NyX3NjcmF0Y2guDQo+ICAgICA+wqAgwqAgLSBoYXJ0IGlzIGlu
IGtlcm5lbCBzcGFjZSBidXQgbm90IGluIHRyYXAgaGFuZGxlciwgInRwIiB3aWxsIGJlIG1vcmUN
Cj4gICAgID7CoCDCoCDCoCB0aGFuIGNzcl9zY3JhdGNoIChjc3Jfc2NyYXRjaCBiZWluZyBlcXVh
bCB0byAwKS4NCj4gICAgID7CoCDCoCAtIGhhcnQgaXMgZXhlY3V0aW5nIHRyYXAgaGFuZGxlcg0K
PiAgICAgPsKgIMKgIMKgIMKgIC0gInRwIiBpcyBzdGlsbCBwb2ludGluZyB0byB1c2VyIG1vZGUg
YnV0IGNzcl9zY3JhdGNoIGNvbnRhaW5zDQo+ICAgICA+wqAgwqAgwqAgwqAgwqAgwqBwdHIgdG8g
dGFza19zdHJ1Y3QuIFRodXMgbnVtZXJpY2FsbHkgaGlnaGVyLg0KPiAgICAgPsKgIMKgIMKgIMKg
IC0gInRwIiBpc8KgIHBvaW50aW5nIHRvIHRhc2tfc3RydWN0IGJ1dCBjc3Jfc2NyYXRjaCBub3cg
Y29udGFpbnMNCj4gICAgID7CoCDCoCDCoCDCoCDCoCDCoGVpdGhlciAwIG9yIG51bWVyaWNhbGx5
IHNtYWxsZXIgdmFsdWUgKHRyYW5zaWVudGx5IGhvbGRzDQo+ICAgICA+wqAgwqAgwqAgwqAgwqAg
wqB1c2VyIG1vZGUgdHApDQo+ICAgICA+DQo+ICAgICA+IFBhdGNoIGFsc28gYWRkcyBuZXcgY2Fj
aGVkIHR5cGUgInVsb25nIiBpbiBzY3JpcHRzL2dkYi9saW51eC91dGlscy5weQ0KPiAgICAgPg0K
PiAgICAgPiBTaWduZWQtb2ZmLWJ5OiBEZWVwYWsgR3VwdGEgPGRlYnVnQHJpdm9zaW5jLmNvbSA8
bWFpbHRvOmRlYnVnQHJpdm9zaW5jLmNvbT4+DQo+IA0KPiAgICAgSSBub3RpY2VkIHdoZW4gbG9v
a2luZyBpbnRvIHBhdGNod29yayBjb21wbGFpbmluZyBhYm91dCBjaGVja3BhdGNoDQo+ICAgICBl
cnJvcnMgaW4gdjIsIHRoYXQgYjQgaGFkIGFjdHVhbGx5IGRvd25sb2FkZWQgdjMgYnV0IEkgY291
bGQgbm90IHNlZQ0KPiAgICAgdGhpcyBwYXRjaCBvbiB0aGUgUklTQy1WIGxpc3QuDQo+IA0KPiDC
oA0KPiBJJ2xsIG1ha2Ugc3VyZSB0byBhZGQgdGhlIHJpc2MtdiBsaXN0IG9uIHRoZSBuZXh0IHNw
aW4gdXAuDQo+IA0KPiANCj4gICAgIEkgZG9uJ3Qgc2VlIGEgY2hhbmdlbG9nIGFueXdoZXJlIGhl
cmUNCj4gICAgIGZyb20gdjIgZWl0aGVyDQo+IA0KPiANCj4gSSBoYWQgYmVlbiB0YWtpbmcgaW5w
dXRzIGFuZCBzcXVhc2hpbmcgY29tbWl0cyBvbiBteSBlbmQuDQo+IFlvdSB3YW50IG1lIHRvIHNl
bmQgYSBjaGFuZ2Vsb2cgb2YgY2hhbmdlcyBiZXR3ZWVuIHZlcnNpb25zIG9mIHBhdGNoZXMuDQoN
ClllYWgsIGl0J3MgbmljZSB0byBzYXkgc29tZXRoaW5nIGxpa2U6DQp2MiAtPiB2MzoNCi0gcmV3
b3JkZWQgY29tbWl0IG1lc3NhZ2UNCi0gZml4ZWQgY29tcGlsZSBlcnJvciBpbiBiYXIuYyBpZiAh
Q09ORklHX0ZPTw0KDQpNYWtlcyBpdCBlYXNpZXIgZm9yIHJldmlld2VycyB0byBzZWUgd2hhdCBj
aGFuZ2VkIGJldHdlZW4NCnZlcnNpb25zLg0KDQo+IMKgDQo+IA0KPiAgICAgLCBub3IgZGlkIHlv
dSBwaWNrIHVwIERyZXcncyBSZXZpZXdlZC1ieS4NCj4gDQo+IA0KPiBJIHNob3VsZCd2ZSBkb25l
IHRoYXQuIE15IG1pc3Rha2UgYW5kIGFwb2xvZ2l6ZS4NCj4gSSdsbCBmaXggaXQgaW4gbXkgbmV4
dCBzdWJtaXNzaW9uLg0KPiDCoA0KPiANCj4gDQo+ICAgICBXaGF0J3MgdGhlIHN0b3J5IHRoZXJl
Pw0KPiANCj4gICAgIE9uZSByZWFsbHkgbWlub3IgdGhpbmcgYmVsb3cuIFNob3VsZCBiZSBhYmxl
IHRvIGZpeCBpdCB1cCB0cml2aWFsbHkgdXANCj4gICAgICYgc3VibWl0IGEgdjQsIENDaW5nIHRo
ZSBsaW51eC1yaXNjdiBsaXN0Lg0KPiANCj4gICAgID4gLS0tDQo+ICAgICA+wqAgc2NyaXB0cy9n
ZGIvbGludXgvY3B1cy5wecKgIHwgMTUgKysrKysrKysrKysrKysrDQo+ICAgICA+wqAgc2NyaXB0
cy9nZGIvbGludXgvdXRpbHMucHkgfMKgIDUgKysrKysNCj4gICAgID7CoCAyIGZpbGVzIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKykNCj4gICAgID4NCj4gICAgID4gZGlmZiAtLWdpdCBhL3Njcmlw
dHMvZ2RiL2xpbnV4L2NwdXMucHkgYi9zY3JpcHRzL2dkYi9saW51eC9jcHVzLnB5DQo+ICAgICA+
IGluZGV4IDE1ZmM0NjI2ZDIzNi4uY2E1MjE1YTY2MGM3IDEwMDY0NA0KPiAgICAgPiAtLS0gYS9z
Y3JpcHRzL2dkYi9saW51eC9jcHVzLnB5DQo+ICAgICA+ICsrKyBiL3NjcmlwdHMvZ2RiL2xpbnV4
L2NwdXMucHkNCj4gICAgID4gQEAgLTE3Myw2ICsxNzMsMjEgQEAgZGVmIGdldF9jdXJyZW50X3Rh
c2soY3B1KToNCj4gICAgID7CoCDCoCDCoCDCoCDCoCDCoGVsc2U6DQo+ICAgICA+wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByYWlzZSBnZGIuR2RiRXJyb3IoIlNvcnJ5LCBvYnRhaW5pbmcgdGhlIGN1
cnJlbnQgdGFzayBpcyBub3QgYWxsb3dlZCAiDQo+ICAgICA+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgIndoaWxlIHJ1bm5pbmcgaW4gdXNlcnNwYWNl
KEVMMCkiKQ0KPiAgICAgPiArwqAgwqAgZWxpZiB1dGlscy5pc190YXJnZXRfYXJjaCgicmlzY3Yi
KToNCj4gICAgID4gK8KgIMKgIMKgIMKgIMKgY3VycmVudF90cCA9IGdkYi5wYXJzZV9hbmRfZXZh
bCgiJHRwIikNCj4gICAgID4gK8KgIMKgIMKgIMKgIMKgc2NyYXRjaF9yZWcgPSBnZGIucGFyc2Vf
YW5kX2V2YWwoIiRzc2NyYXRjaCIpDQo+ICAgICA+ICsNCj4gICAgID4gK8KgIMKgIMKgIMKgIMKg
IyBieSBkZWZhdWx0IHRwIHBvaW50cyB0byBjdXJyZW50IHRhc2sNCj4gICAgID4gK8KgIMKgIMKg
IMKgIMKgY3VycmVudF90YXNrID0gY3VycmVudF90cC5jYXN0KHRhc2tfcHRyX3R5cGUpDQo+ICAg
ICA+ICsNCj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIyBzY3JhdGNoIHJlZ2lzdGVyIGlzIHNldCAw
IGluIHRyYXAgaGFuZGxlciBhZnRlciBlbnRlcmluZyBrZXJuZWwuDQo+ICAgICA+ICvCoCDCoCDC
oCDCoCDCoCMgV2hlbiBoYXJ0IGlzIGluIHVzZXIgbW9kZSwgc2NyYXRjaCByZWdpc3RlciBpcyBw
b2ludGluZyB0byB0YXNrX3N0cnVjdC4NCj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIyBhbmQgdHAg
aXMgdXNlZCBieSB1c2VyIG1vZGUuIFNvIHdoZW4gc2NyYXRjaCByZWdpc3RlciBob2xkcyBsYXJn
ZXIgdmFsdWUNCj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIyAobmVnYXRpdmUgYWRkcmVzcyBhcyB1
bG9uZyBpcyBsYXJnZXIgdmFsdWUpIHRoYW4gdHAsIHRoZW4gdXNlIHNjcmF0Y2ggcmVnaXN0ZXIu
DQo+ICAgICA+ICvCoCDCoCDCoCDCoCDCoGlmIChzY3JhdGNoX3JlZy5jYXN0KHV0aWxzLmdldF91
bG9uZ190eXBlKCkpID7CoCBjdXJyZW50X3RwLmNhc3QodXRpbHMuZ2V0X3Vsb25nX3R5cGUoKSkp
Og0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXl4NCj4gICAgIGV4dHJhIHNw
YWNlIGhlcmU/DQo+IA0KPiANCj4gSSBkb24ndCBzZWUgdGhlIHNwYWNlIGluIHRoZSBwYXRjaC4g
Q2FuIHlvdSBjbGFyaWZ5IHdoaWNoIHNwYWNlIHlvdSdyZSB0YWxraW5nIGFib3V0IGhlcmU/DQoN
ClRoZXJlJ3MgYSBkb3VibGUgc3BhY2UgYmV0d2VlbiB0aGUgPiBhbmQgY3VycmVudF90cC4NCkkg
cHV0IGEgXl4gdW5kZXIgaXQsIGJ1dCBpZiB5b3UndmUgbm90IGdvdCBhIG1vbm9zcGFjZSBmb250
LCB3aGljaCBzaW5jZQ0KeW91J3JlIHJlcGx5aW5nIGluIGh0bWwgeW91IHByb2JhYmx5IGRvbid0
LCBpdCBtYXkgbm90IGFsaWduIGZvciB5b3UuDQoNCkhvcGUgdGhhdCBoZWxwcywNCkNvbm9yLg0K
DQo+IA0KPiAgICAgwqANCj4gDQo+IA0KPiAgICAgPiArwqAgwqAgwqAgwqAgwqAgwqAgwqBjdXJy
ZW50X3Rhc2sgPSBzY3JhdGNoX3JlZy5jYXN0KHRhc2tfcHRyX3R5cGUpDQo+ICAgICA+ICsNCj4g
ICAgID4gK8KgIMKgIMKgIMKgIMKgcmV0dXJuIGN1cnJlbnRfdGFzay5kZXJlZmVyZW5jZSgpDQo+
ICAgICA+wqAgwqAgwqAgZWxzZToNCj4gICAgID7CoCDCoCDCoCDCoCDCoCByYWlzZSBnZGIuR2Ri
RXJyb3IoIlNvcnJ5LCBvYnRhaW5pbmcgdGhlIGN1cnJlbnQgdGFzayBpcyBub3QgeWV0ICINCj4g
ICAgID7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCJzdXBwb3J0
ZWQgd2l0aCB0aGlzIGFyY2giKQ0KPiAgICAgPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9nZGIvbGlu
dXgvdXRpbHMucHkgYi9zY3JpcHRzL2dkYi9saW51eC91dGlscy5weQ0KPiAgICAgPiBpbmRleCAx
NTUzZjY4NzE2Y2MuLmRkYWYzMDg5MTcwZCAxMDA2NDQNCj4gICAgID4gLS0tIGEvc2NyaXB0cy9n
ZGIvbGludXgvdXRpbHMucHkNCj4gICAgID4gKysrIGIvc2NyaXB0cy9nZGIvbGludXgvdXRpbHMu
cHkNCj4gICAgID4gQEAgLTM1LDEyICszNSwxNyBAQCBjbGFzcyBDYWNoZWRUeXBlOg0KPiAgICAg
PsKgDQo+ICAgICA+wqANCj4gICAgID7CoCBsb25nX3R5cGUgPSBDYWNoZWRUeXBlKCJsb25nIikN
Cj4gICAgID4gK3Vsb25nX3R5cGUgPSBDYWNoZWRUeXBlKCJ1bG9uZyIpDQo+ICAgICA+wqAgYXRv
bWljX2xvbmdfdHlwZSA9IENhY2hlZFR5cGUoImF0b21pY19sb25nX3QiKQ0KPiAgICAgPsKgDQo+
ICAgICA+wqAgZGVmIGdldF9sb25nX3R5cGUoKToNCj4gICAgID7CoCDCoCDCoCBnbG9iYWwgbG9u
Z190eXBlDQo+ICAgICA+wqAgwqAgwqAgcmV0dXJuIGxvbmdfdHlwZS5nZXRfdHlwZSgpDQo+ICAg
ICA+wqANCj4gICAgID4gK2RlZiBnZXRfdWxvbmdfdHlwZSgpOg0KPiAgICAgPiArwqAgwqAgZ2xv
YmFsIHVsb25nX3R5cGUNCj4gICAgID4gK8KgIMKgIHJldHVybiB1bG9uZ190eXBlLmdldF90eXBl
KCkNCj4gICAgID4gKw0KPiAgICAgPsKgIGRlZiBvZmZzZXRfb2YodHlwZW9iaiwgZmllbGQpOg0K
PiAgICAgPsKgIMKgIMKgIGVsZW1lbnQgPSBnZGIuVmFsdWUoMCkuY2FzdCh0eXBlb2JqKQ0KPiAg
ICAgPsKgIMKgIMKgIHJldHVybiBpbnQoc3RyKGVsZW1lbnRbZmllbGRdLmFkZHJlc3MpLnNwbGl0
KClbMF0sIDE2KQ0KPiAgICAgPiAtLQ0KPiAgICAgPiAyLjI1LjENCj4gDQoNCg==
