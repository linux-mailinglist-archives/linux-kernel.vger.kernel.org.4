Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6C6663960
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjAJGbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAJGbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:31:45 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2042.outbound.protection.outlook.com [40.107.9.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B130D2E4;
        Mon,  9 Jan 2023 22:31:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHl785qWtnaewNnFQGlSqBnyMxzGxct/4eod3tXGoUQGUxGqNUzfuvXhxAXG3qfF3RfQUdxbXfLthQ0Lva8vqvNY9VKGepDW2NY5uMO6qRkHn7eEjmfQs90CFZsZg0qyy/XW71ZAObOwXST7iDX95w/Yl1x4+jceikEZMY+Lrw/BkI+eHLYk5EhZJCetgYnDH5hISq6U+l5E+YwAXNVppwVe/bY9fl8nSmgzopJeMVSEXHsEPJ0YzzlJ3Yge1dfY/+PRiwA3nkgLNHoFmz5H1rP+vWV6UiHD3nvd3YLQcMgb7OwcwVyUt6nrW8LElvUc6VBvbMH0t1QJGPqJlYyGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwg7JHRbZDvOQ6PoT3ZPpVRl9RI6DEXQorqxg7AR2+A=;
 b=M8ByxQSZOcretvmD6t2MKs59z3FxBld2FawfogJmsWUwi+LXiOjyaSu9cEq30XObZ80T1WEeDBcjVuWI/fM9BAsi8UurM9rJ2fIsr7LQ0PQTRtTFK5nA4E2qwAre4hz00T6i9r13+9H/rggSLWFuczLU3jVJ2nVLsmuUJwvJWkDJVXtHAcA3dYU2OLHvcTJLVU0qTnrvwu1EMBHBI29mVCv7M7qCeQW3In9b6EKARM7Dil1GQF+Ubg+fHBP6RHHSqHWAmktnL9lHscSxVLtE66Le7cD0YfscRROTXsARBHu6eCVXs/iXOwAuFI2JpPDOXERkmGKJl0RepQNwdgG8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwg7JHRbZDvOQ6PoT3ZPpVRl9RI6DEXQorqxg7AR2+A=;
 b=WJdrYyGywiIv1en0/eFAf2MvyLbAw1tO1aOzIk1ACK/LtMWnginxEze3bg/ZA0CudDG4aW7S6HWiEAQouDGBdHQPtbM8xdww6eNrxAa8rTjwbuCH9yzhL4GaNlR/rzeoGKptZ4rVjnGE2kHfKACNMYe0WYsReU5xW7HUN8baWv7Ra29pAoRaezDuZgR7+M77DegJ3pOquG7qeRIVV3JAQx/0NyjTwkVB8HKWfjwhLEvyEp23vDacVCHTf9aSJnpaf2D9jW/d668EOgiw8ozfHS47v5iSy6PF+fTOT1/yENoUMyctts26fr3eaTFFS5RQzRZE/hWKCLfFKXal06LDxQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3096.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 06:31:41 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 06:31:41 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Song Liu <song@kernel.org>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
Thread-Topic: [PATCH/RFC] module: replace module_layout with module_memory
Thread-Index: AQHZIhvLUt8720RkIEmV5/vANaeHba6WZSyAgAAF1gCAACk1gIAAofYA
Date:   Tue, 10 Jan 2023 06:31:41 +0000
Message-ID: <154ed99c-5877-35f6-5e7d-9d7abada7d33@csgroup.eu>
References: <20230106220959.3398792-1-song@kernel.org>
 <83941b74-7585-235b-ee54-3b127ca70d9e@csgroup.eu>
 <CAPhsuW6S8qJWFzSLpVf_4ZpyM0Cxty=-pS2_K=tgF52s95Zhag@mail.gmail.com>
 <CAPhsuW7+BG9wYaoD6EYH-jnWqX30JdgNr5_733sO-++SzR5v3w@mail.gmail.com>
In-Reply-To: <CAPhsuW7+BG9wYaoD6EYH-jnWqX30JdgNr5_733sO-++SzR5v3w@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3096:EE_
x-ms-office365-filtering-correlation-id: 0d6a327e-e368-40ac-b836-08daf2d455bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJ1acRWN5sBLozsmatcbYJkHvZPzG/uRfuLTwcNNBsjQkTlv+9uh+jPmOTtD8gN9W7New/g2qS4pnFugRnyYpp+uvSAZVZmg0rQLgZ3JT4JMAGlQshpxlBDmzCRqEmxuBSKQkvPnScq3dIUD3hp5ib783mPPLwE65HK9VtBbd5fsDhKR1fONS8GKOqYgIXO5gXwkyrvgZj6siFv27WQWUKy19J9YxbJA4Eo6JM6IyeSjqcSxmtz2gG4ayZKGvanVIQzVJiZa/axuEqsYITI35CAmPxx2slXv/iPBubDVpb4KdtEBcyXVmelv/QupWFuVHRAWSADZTs6N7EbnvoyBWh6i+TdWdmYjMujFl0MAP2ZCHzlqKDyoLRNnMMp3BkffHAMeSArkf4WAyc5YdT8vbvJNhdjlPB7zntYJFGRwEnEuUo+az2YJqSuLOcWwIe7bu9b+wyz9OBl7VRgnrc92Qjhtk2m4asCTyH4t/V2kfO5egZfjiYiN+VtuOC5yUGckJ2Mq1gBiuwag1f0kkCeJ7hkf2C5e2ZPsQ9M4K6PRLg+rU66iF29UfH0csKypx81S06KU+47oqpVnZTlVyR8RA1dEDl2nIGISuMnr8VvDWEq74rqh61Q1DR/irJGvAumDCDagP4VPr0dIUCqJfHZYsQlGuGBIuYoEcmoJ5uGc5zHG5elnqn3h9zi9mGz3aWazyX2A6KDAhVY426Vrbzy+/5VVwwmLBP/BGzk57l7yva+sK0gP6IRnhvb4H6PeYqih5AozxHcTbnh6kFrEConpyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199015)(36756003)(8936002)(186003)(26005)(53546011)(122000001)(6506007)(6512007)(2616005)(54906003)(66946007)(5660300002)(66476007)(64756008)(66446008)(66556008)(6916009)(4326008)(316002)(91956017)(38070700005)(86362001)(71200400001)(31696002)(38100700002)(76116006)(478600001)(6486002)(31686004)(41300700001)(8676002)(83380400001)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmFyayszR2U5dk1JbDJIMWZpRXZwbnNzcjM1byt1YkM5REVLMDN6aWZmY3Vm?=
 =?utf-8?B?VjNYRUY4eU16NStPQXk3Tm93UCtFNUE2L1pWSHBBSGIwQlQyNTJNSmRJN3NW?=
 =?utf-8?B?c2kzRjFyVWVmWm5Pa1RZUytKeTZ4TUhRTkJNLzllR1NIL1YxTGNJVEhSUEhS?=
 =?utf-8?B?ZVlJV1dJalZDdjYzckVsVEZESHd0bVBFVkpBbzAvaHdYcDFSUXF5YmwwQVB6?=
 =?utf-8?B?MHNNWGRmS003aW1PMHdlOUxhMGNaSVFQKzd2KzI0UFg1bURDWkh6VVV4SzJi?=
 =?utf-8?B?MGxJL2h2cEYrbmtRMzNndlpMRmpGem1aVmNwNmpCcW9YYTI4V1grUjdDRUJ1?=
 =?utf-8?B?QlhUSXlVMGtzbStrSHJxOFJHYVJFUSszSEZ3Nnh0aS9xaEs4WFRnZUpyOVhw?=
 =?utf-8?B?Y0FSNTRXRTVZbm5ieU8vMmlETjJhWUFoNEJaVUsvOUk0WHlLV0FVczRFaHpL?=
 =?utf-8?B?d2pLUU43WEF4aTh6NzFMbkxMZ3RzdGp1VzNadWFnYzhXbTBiSUlkaVJwV3F2?=
 =?utf-8?B?RmVwQlA1eUo3Z0Rsd1d4a3ViT3lFZlcreUwvWmRMRDhMcUJITnp6Ym94aC8y?=
 =?utf-8?B?YS8vTXMwb09OYjFMM3hJeGIrQk54TERkaFVhcjBSNjdybjJTTk5tVWtZaG5E?=
 =?utf-8?B?cFpFQVNqSXAyM2tDS1A5UFEwWEsxQmZ0QTkwN05KcXRLT1Jsbmdydk5zdVBB?=
 =?utf-8?B?SU1UZndYSSsxNUhSV1k1YkJuSWgvaFhEV1BNdjZNVjRDNFlKcVRPU3Jsc1FH?=
 =?utf-8?B?eWxnM2s4RmFtbnU2L0RoSXg1RG1RVnJWUE5YUmhEajhWc1RhOXB4bDJPS2cx?=
 =?utf-8?B?MnF0OTZObWpRK0FDdTlIYVpsRmI1TEh3bWtDNWhFbVkzOEQrVTFqd1pRKzFj?=
 =?utf-8?B?c3Z3ZDFuVmJlOWUxNUFnMFJQQytGcWxoa1NsOUIzMWwyUTNLai9VL2llRXJX?=
 =?utf-8?B?NklBVHBWejhvamhIWm4vdlhwM05CVWxVNWJqU3FYVXp5TENwemt3Qld4MzNk?=
 =?utf-8?B?WGhBbXBSeEI1TjRZeCtJcmNoOUIwRGFjdUIzTnJmbXZwUXJBay9UWEZRaS9P?=
 =?utf-8?B?S2ppYzB5eVlwTzNodnhKcUMzanc0Vjl3RmpFTnJCSVFBSDgwS3ExdjIvSEh6?=
 =?utf-8?B?dXNFQ1FZL1lKelhqVjNwNGRLK3dmbXM4U21WbEJyWDltSHFzNUF3MDczcWxH?=
 =?utf-8?B?c2o0b0grRWZBRVg4bkJ2eXViUlIvRitjU2docEY3M1Nlak1OR3pTYVV1VGJq?=
 =?utf-8?B?WjFjQjFhQ1gvMzNUTTMvYnFXSVJuUktsYmVsNW5wZHpKUEVKU1FPN0JmYlcy?=
 =?utf-8?B?c1dtdkJPQ2JxYzlFaW9PclRRd3pwWkR0cGM5bktLV3RzYlppRXJLeWJ5RTNl?=
 =?utf-8?B?TWsrWXhxWGFYc3YzU2FvSmMzWU1xVWhjRWFXeUkzY2p0QkRmV0FXNlpvSnNY?=
 =?utf-8?B?RFJJNC9tS21FNWJwU3lTZXRSSmxvNnRNcWdOUkJXRzZROXpGOENnY29TUzR2?=
 =?utf-8?B?T2FvUjhGQ0tuOXJMUjhSWjM3dzVmSitXUjFXUnJqTk9jL0E4bE9OZVFaaFBD?=
 =?utf-8?B?R3krSzNTNkdaa0x4UTh0Y0R6ZFBKN3k3eG02NU81R043eUsyQnp6dVhMRTc3?=
 =?utf-8?B?NWhIbFdndUVmTkJqV215aFIrTUkrZklCSktFbGJzZXhlVmt5ZHhnL3dNY1RX?=
 =?utf-8?B?RmlGRVY3VFQxZTI0TTFwRURaQkFHRDZDblpoTWV1bTJraUNPNWRRbGFWdXNu?=
 =?utf-8?B?MXdUMURObENJOGNnUmE0VVNodlJ3WTUwb2RiQisxenZrY3QxcGF4S0dDbGd0?=
 =?utf-8?B?aVAraXV6WWwxbHhhMUdyc21NelJGQURjdWc5aitZQ2FVTUJsZmJzMW5UWElT?=
 =?utf-8?B?OUVxZXZHQ3ppaXdTZnVBS1hpamJqcENhc0pmWWFyMWErMTRzSGpSbG4xcFR4?=
 =?utf-8?B?RzduZkFONzhQZldHNFpQQnV1R0grWHJZbkMwVnpMTDd0QmlqcVd1ejBab2l0?=
 =?utf-8?B?UDFtWHEraGRiU1FyOExFc0tnVEpvRFdtWjRTRXhvN3phQlFkTXZncDhBakdv?=
 =?utf-8?B?REFZL040SklkYjNic2xrcXJUYko0QWNxTmhVaU5NNW94b1lYOWZhSXRqaExi?=
 =?utf-8?B?MlZnTlNLbnkyZHc2eWUrengyaDFzSThkalpIaHJZaWNpc2dFeUlJbDZUTnRN?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDE2482555DE2C4EBAB700635157670A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6a327e-e368-40ac-b836-08daf2d455bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 06:31:41.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUo0mVNZRGUemPO3cur49Vxi6Z6cjtjdSug3IdmYseSWmngevGe6Bqo/PphgaWS9Zo0SUS002WUqFSCdtV7gSXtL16xXu64LBNVHQV8VkI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA5LzAxLzIwMjMgw6AgMjE6NTEsIFNvbmcgTGl1IGEgw6ljcml0wqA6DQo+IE9uIE1v
biwgSmFuIDksIDIwMjMgYXQgMTA6MjQgQU0gU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4gd3Jv
dGU6DQo+Pg0KPj4gT24gTW9uLCBKYW4gOSwgMjAyMyBhdCAxMDowMyBBTSBDaHJpc3RvcGhlIExl
cm95DQo+PiA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToNCj4+Pg0KPj4+DQo+
Pj4NCj4+PiBMZSAwNi8wMS8yMDIzIMOgIDIzOjA5LCBTb25nIExpdSBhIMOpY3JpdCA6DQo+Pj4+
IG1vZHVsZV9sYXlvdXQgbWFuYWdlcyBkaWZmZXJlbnQgdHlwZXMgb2YgbWVtb3J5ICh0ZXh0LCBk
YXRhLCByb2RhdGEsIGV0Yy4pDQo+Pj4+IGluIG9uZSBhbGxvY2F0aW9uLCB3aGljaCBpcyBwcm9i
bGVtYXRpYyBmb3Igc29tZSByZWFzb25zOg0KPj4+Pg0KPj4+PiAxLiBJdCBpcyBoYXJkIHRvIGVu
YWJsZSBDT05GSUdfU1RSSUNUX01PRFVMRV9SV1guDQo+Pj4+IDIuIEl0IGlzIGhhcmQgdG8gdXNl
IGh1Z2UgcGFnZXMgaW4gbW9kdWxlcyAoYW5kIG5vdCBicmVhayBzdHJpY3Qgcnd4KS4NCj4+Pj4g
My4gTWFueSBhcmNocyB1c2VzIG1vZHVsZV9sYXlvdXQgZm9yIGFyY2gtc3BlY2lmaWMgZGF0YSwg
YnV0IGl0IGlzIG5vdA0KPj4+PiAgICAgIG9idmlvdXMgaG93IHRoZXNlIGRhdGEgYXJlIHVzZWQg
KGFyZSB0aGV5IFJPLCBSWCwgb3IgUlc/KQ0KPj4+Pg0KPj4+PiBJbXByb3ZlIHRoZSBzY2VuYXJp
byBieSByZXBsYWNpbmcgMiAob3IgMykgbW9kdWxlX2xheW91dCBwZXIgbW9kdWxlIHdpdGgNCj4+
Pj4gdXAgdG8gNyBtb2R1bGVfbWVtb3J5IHBlciBtb2R1bGU6DQo+Pj4+DQo+Pj4+ICAgICAgICAg
ICBNT0RfTUVNX1RZUEVfVEVYVCwNCj4+Pj4gICAgICAgICAgIE1PRF9NRU1fVFlQRV9EQVRBLA0K
Pj4+PiAgICAgICAgICAgTU9EX01FTV9UWVBFX1JPREFUQSwNCj4+Pj4gICAgICAgICAgIE1PRF9N
RU1fVFlQRV9ST19BRlRFUl9JTklULA0KPj4+PiAgICAgICAgICAgTU9EX01FTV9UWVBFX0lOSVRf
VEVYVCwNCj4+Pj4gICAgICAgICAgIE1PRF9NRU1fVFlQRV9JTklUX0RBVEEsDQo+Pj4+ICAgICAg
ICAgICBNT0RfTUVNX1RZUEVfSU5JVF9ST0RBVEEsDQo+Pj4+DQo+Pj4+IGFuZCBhbGxvY2F0aW5n
IHRoZW0gc2VwYXJhdGVseS4NCj4+Pj4NCj4+Pj4gVmFyaW91cyBhcmNocyB1c2UgbW9kdWxlX2xh
eW91dCBmb3IgZGlmZmVyZW50IGRhdGEuIFRoZXNlIGRhdGEgYXJlIHB1dA0KPj4+PiBpbnRvIGRp
ZmZlcmVudCBtb2R1bGVfbWVtb3J5IGJhc2VkIG9uIHRoZWlyIGxvY2F0aW9uIGluIG1vZHVsZV9s
YXlvdXQuDQo+Pj4+IElPVywgZGF0YSB0aGF0IHVzZWQgdG8gZ28gd2l0aCB0ZXh0IGlzIGFsbG9j
YXRlZCB3aXRoIE1PRF9NRU1fVFlQRV9URVhUOw0KPj4+PiBkYXRhIHRoYXQgdXNlZCB0byBnbyB3
aXRoIGRhdGEgaXMgYWxsb2NhdGVkIHdpdGggTU9EX01FTV9UWVBFX0RBVEEsIGV0Yy4NCj4+Pg0K
Pj4+IEkgZGlzbGlrZSBob3cgaXQgbG9va3Mgd2l0aCBlbnVtcywgdGhpbmdzIGxpa2UNCj4+PiBt
b2QtPm1vZF9tZW1bTU9EX01FTV9UWVBFX0lOSVRfVEVYVF0gYXJlIG9kZCBhbmQgZG9uJ3QgcmVh
ZCBuaWNlbHkuDQo+Pj4gQ291bGQgd2UgaGF2ZSBzb21ldGhpbmcgbmljZXIgbGlrZSBtb2QtPm1v
ZF9tZW1faW5pdF90ZXh0ID8NCj4+PiBJIGtub3cgaXQgd2lsbCBjb21wbGljYXRlIHlvdXIgZm9y
X2VhY2hfbW9kX21lbV90eXBlKCkgYnV0IGl0IHdvdWxkIGxvb2sNCj4+PiBuaWNlci4NCj4+DQo+
PiBIbW0uLiBJIGFtIG5vdCBzdXJlIHdoZXRoZXIgd2Ugd2FudCA3IG1vZHVsZV9tZW1vcnkgaGVy
ZS4gQnV0IGlmIHdlDQo+PiBhZ3JlZSB0aGF0IGl0IGxvb2tzIGJldHRlciBsaWtlIHRoYXQsIEkg
YW0gb2sgd2l0aCBpdC4NCj4+DQo+Pj4NCj4+PiBBbHNvLCBjYW4geW91IGV4cGxhaW4gaG93IHlv
dSBzd2l0Y2ggZnJvbSB0d28gdHJlZXMgdG8gb25seSBvbmUgPw0KPj4+IEFzIGZhciBhcyBJIHJl
bWVtYmVyLCB0aGUgc2FtZSBxdWVzdGlvbiBhcmlzZWQgd2hlbiBJIGltcGxlbWVudGVkDQo+Pj4g
Q09ORklHX0FSQ0hfV0FOVFNfTU9EVUxFU19EQVRBX0lOX1ZNQUxMT0MsIGFuZCB0aGUgY29uY2x1
c2lvbiB3YXMgdGhhdA0KPj4+IHdlIGhhZCB0byBrZWVwIHR3byBpbmRlcGVuZGFudCB0cmVlcywg
c28gSSdtIGEgYml0IHB1enpsZWQgdGhhdCB5b3UgaGF2ZQ0KPj4+IG5vdyBtZXJnZWQgZXZlcnl0
aGluZyBpbnRvIGEgc2luZ2xlIHRyZWUuDQo+Pg0KPj4gQUZBSUNULCB3ZSBvbmx5IG5lZWQgX19t
b2R1bGVfYWRkcmVzcygpIHRvIHdvcms/IFNvIG9uZSB0cmVlIGlzIGVub3VnaC4NCj4+IERpZCBJ
IG1pc3Mgc29tZXRoaW5nPw0KPiANCj4gRG8geW91IG1lYW4gb25lIHRyZWUgd2lsbCBjYXVzZSBh
ZGRyX1ttaW58bWF4XSB0byBiZSBpbmFjY3VyYXRlPw0KPiANCg0KWWVzIGF0IGxlYXN0LiBPbiBw
b3dlcnBjIHlvdSB3aWxsIGhhdmUgbW9kdWxlIHRleHQgYmVsb3cga2VybmVsLCANCnNvbWV3aGVy
ZSBiZXR3ZWVuIDB4YjAwMDAwMDAgYW5kIDB4Y2ZmZmZmZmYsIGFuZCB5b3Ugd2lsbCBoYXZlIG1v
ZHVsZSANCmRhdGEgaW4gdm1hbGxvYyBhcmVhLCBzb21ld2hlcmUgYmV0d2VlbiAweGYwMDAwMDAw
IGFuZCAweGZmZmZmZmZmLg0KDQpJZiB5b3UgaGF2ZSBvbmx5IG9uZSB0cmVlLCBhbnkgYWRkcmVz
cyBiZXR3ZWVuIDB4YzAwMDAwMDAgYW5kIDB4ZWZmZmZmZmYgDQp3aWxsIHRyaWdnZXIgYSB0cmVl
IHNlYXJjaC4NCg0KQ2hyaXN0b3BoZQ0K
