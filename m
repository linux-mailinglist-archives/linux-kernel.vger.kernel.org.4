Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E5D745854
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGCJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGCJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:28:57 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82E112C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688376536;
  x=1719912536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I3Z2qaa+48wL37sN9UCObysJs7RXT+LwAkTT//h49so=;
  b=p4SS09OZN/luUC7uQRFMM3mXb/4Pj6+hbhahZNwIN3DLbnYjZyxoh4+p
   YuAZaIrciDlrnlH6+BI4XW0SwWZ/ppCQ+30AIxve+2jT6vnuqqpWaTuEF
   VNDbqNhh2KY4yORvsJuqN0pLSAKlW4UzEKPPKqcLK+7ToxVk3q/GgFNfI
   yqXc18LvaNgTP/LO8BnWIEmhC2YghxQb3XGK8otlwgtZItWzZoFH03N16
   dYAtu8mAOVTksuz7Mmy05n3lM7xORSbbI2zT9YHlW0jr7v22pVuTEryTZ
   itRYO0B6yO6DheFzTC/tNfaUxGH2IFHhfM74FnVJMyoT2KV7Qq+Q+oMAn
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMv4JMmGFjfOFb86ejkel97eHpfKOyO+j/P+eUfGnzQ0U3nwPu7ywvambsaM+k0MMaU0G//hEvRI+jNHcZvBJxZesmzlmJMKkPLN6PJGRhr7oKdk93lvm4h7cCmzKjNNzBk2DDvPCKqcTG5mw8BJBkmlscEokveMIT4h4KOvZPOBCXx/mirfvNXrKoHIt9z+BpHdjvKluSFgtIT00H3MsdgF3dgs6MxXu+51YK/Xp33h3TQ7J4aAvEKVLSaiGQxTHg8JcbWllEP+yCh+l3NsPRQ9YEiFouhFJ040EWyj9gWOUAAG1t2VjRYDWsWCwSjTMejyZePXUCEspE3f+k3tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3Z2qaa+48wL37sN9UCObysJs7RXT+LwAkTT//h49so=;
 b=BpY7PWsKO/j8dMnolkmuQd8z2NOtDiPdXFDINsn8NSMRU2y9+sfLq7wJThYAi7TKQMB5KTzzDbZUCNdNYOZLM3epxhzv7v4MxThu0nx7sz+WnxmRdPqSMHoDpMJc5uKtZmXAW/Z2S3Hrk6TSrhvN27jWmzd5ebqsrqzLbkhzx01g6C/dudYBsVVLeYxb1m51dcH0RjHSCjK5KVcuF/tFujtCWE0gfldkxk0XTMFklWnKWzsofFcsSC3beXVmsK/dWR4DzIM7ySE5xrs5G2muvF5y2RakA/0xlb9uFwLuEjzrihcNMjHHxgAYHyb7/L3rKhNxz6s0cLwE7oR4i2dkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3Z2qaa+48wL37sN9UCObysJs7RXT+LwAkTT//h49so=;
 b=csSgL0YwZPoBVpOVkAWk1Ovy4E+y6Zw+RdLgQaGkCqIuQBYj7xcr/1Srphq7CmZeNVCveA6OqgB/umQnJqDPhCgPlQB/rJvXcJSxTS5C3HhfbmMPznGTeLOdFeCrglOGAbyfX/TMPJH7aE4J7sXpjeAmfFr2+9og8c19R4fUiHI=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        Vincent Whitchurch <Vincent.Whitchurch@axis.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH v2] genirq: Fix nested thread vs synchronize_hardirq()
 deadlock
Thread-Topic: [PATCH v2] genirq: Fix nested thread vs synchronize_hardirq()
 deadlock
Thread-Index: AQHZo2icv+cFGb9yXEOUs6z++IYGLK+jHa0AgAS9EQA=
Date:   Mon, 3 Jul 2023 09:28:52 +0000
Message-ID: <e52e4b71611c984281352d2fb1ab746ff09f4d10.camel@axis.com>
References: <20230613-genirq-nested-v2-1-fd5114b1e90c@axis.com>
         <87leg1z5c3.ffs@tglx>
In-Reply-To: <87leg1z5c3.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AS8PR02MB9627:EE_
x-ms-office365-filtering-correlation-id: f3a8e2cc-834b-4214-6ea6-08db7ba7ea81
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6j5aC/BP8bNq/RaZvHH/nOCRmQOlLMmugBTzaD0/k6fnJ15g+vfdfuIPzFn/YDzm7ByQIH0INBtvTVVYZTxiAElOyG07lmHexRu30d7OPq8jEDSpvJL3+65GrGZZG+9yYuczRdPEVZ5YCm8ESyEq+X/iif3zryt9kfJczj1RQh68XbAA2kuvtf6bSuVpMPIC1i/AjmEnfRHkJPzaaZzHqThgkM7MGY9g8tvnkwwLfJnGSiyA7GJh0MyiTB+ixu2z4JH6KpdohjU//nv8uDcafe3uhU8PpRXUbTXBI9RZhSyBQPyKpDx6tlZsxR1B9JBUCHt27U3oKyM7vuo0UQ70dPCsuPVaAD7uUvdx5ZuFIR+oBcRmIXF3UZkBGzBLaOYDkFdf8HmH/tylpuKZSjhWdHyOGT1lo+DPNyaU4Eb/gIHZpSx8i8WBIxsG8dBLmKKDplBNZNOvnkY60c+G0bbTHFh0h2A63ZUmWZh7Bu3R/0lRBrSsISLqmNOaNzQ1A/Wrx9s3zOgaLt45QK1VmWgNQQ8TixMuDnJ9hKUvDWAZsPTGFIIRYC81cAboLyZfQ6rQFgW6th7dPkbp7pRIP44lOx+bxI53X6aYRNQpVmJPERr/AQtu8bAso8JeYuGHS9Xt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(38070700005)(2906002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(186003)(2616005)(478600001)(107886003)(26005)(6512007)(6506007)(71200400001)(6486002)(91956017)(122000001)(76116006)(316002)(4326008)(66476007)(64756008)(66446008)(66556008)(66946007)(38100700002)(54906003)(110136005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnovekgzUzA5Si9HaGV3OGE2YjgyY1BLUFQxNHAxQ2toclo3SmI2VXQzZnRJ?=
 =?utf-8?B?YlBTdEg3ekxCT3NOWHhqRWdvSGQ0T3c5ZTFGeTZLYUFwWHJqcHpPMU9HSU1O?=
 =?utf-8?B?dFZUK2k2UUUwSVYvR2JvQWIva3BOb2JqRzhVS2hQNjA2UnM3Ny9FU1Z6QU5w?=
 =?utf-8?B?TWg4Rk5XMmJrT1R1Z1NYS0hDSTdtOG14TzRscEdqeXk1b1BERFd3R28yaTRK?=
 =?utf-8?B?ZDZQdGI0R2NTeEdTd1ZoODVLSGMvSFRGYVArT3FxTC94U2tac3Y2aGhWNXRR?=
 =?utf-8?B?Zmx5ZVNjQU1Lbi94UXJxelZ5NEFwdXNUVGFIMWJIMHh5V2cxSUIraExoY29V?=
 =?utf-8?B?UVBpMDI1TWFFdnR5enFmbngxQjVYVjdyTXQ3ZUNNbkZ6YkVBNkp0d29OVGdI?=
 =?utf-8?B?dFNzT3R5cElvVU54QTVKTnlvaHpOVGdsOStJYkgvSDNtRXRncXlUZHlVVk1x?=
 =?utf-8?B?Nk82MmRMZWxuLzd3V3hrREZFQnloV1lxZ0EwaG9GbFc0OUtHRWs2ZkdrY2h3?=
 =?utf-8?B?OEZ6QmdKR3JhU1pUQ2F6T3lhMmNYVzZGRFJhMUxGRHNmN3lqWTJFZHRvd0pZ?=
 =?utf-8?B?bFdwbEU5WHpxQXJLbmxoYTVDdFU4Q2JoVndHbXZlQkVodGZUbFA4ajBXb3NN?=
 =?utf-8?B?aVBWN3RUbkoybnhCNWFuT2p4LzNFZnVhOExEVEE0NysrLzJyNlBmRTJzMmVF?=
 =?utf-8?B?NVd5ZW9mUEovdU1DVDB6V0UvSW1PakYzZm5MK3VGK0VxbUh3OGt5Y2U5eng5?=
 =?utf-8?B?Qmw0aGFhQnowZUVEZTk0ZGZuemV1cEExRExkRUhJNDZjd1puTDFXb083Mi9J?=
 =?utf-8?B?Qk9XRElmSGgySTgyeTJRV3I2SVlrRDIyUGpwR2E1Mm9BOXJVb2ZXOURTbXdW?=
 =?utf-8?B?dnFvQVFqRXR2S1RUcWVYcUJyS3ErTG8zOE11T25ZcmhrclFDMWJma1BiYzJq?=
 =?utf-8?B?OVMreVFHcDIwV3hVczI3a1BGbzdxc2trVjFIcU9Seld2OUFuWEdFbDZXTWNL?=
 =?utf-8?B?ODlwVUdsM0xKZUNJUlhMeWNtUlJWVXo3RXlRTGhWUnJrYlV3WDBmTjNpZ0Nz?=
 =?utf-8?B?cU5YeFRlRFZwYXU2dGpzQnFIRU41Ty8rUXZrOEhvVlpqeGxlUTUvZkZOeVE1?=
 =?utf-8?B?Q3A2a3VvUVRSeUxrYUZNVStpbjk5YWFPVXpEZzJsdWZNM0dlbUtiM01udVlD?=
 =?utf-8?B?cHNoaWY5bnA1aFg3WTh1Kzh2anBTMFp1TDB4K25ibXNGWUxkTnZVSFk0M28z?=
 =?utf-8?B?SE9yWFc5aUxiNWhpNjY0Y25wTXd0VEl2UG5oNmR3Z2Z6VW0xTWU3VGhjbmJm?=
 =?utf-8?B?MU9aOGJnNnJpbjJIOSs3ZE5zQnFIVEZjOWJPdEJ4TVRydnJlSllBSEY0VVV4?=
 =?utf-8?B?dndLRzR2TDk5c1RaaVowazd5UVc1OGZiTVVNSzM3YnpWWFMrQkhxYk5wbHZ6?=
 =?utf-8?B?WE41SEF3TFE5VGYvRnFYdnVXUXdXcFlWNllVMUN5S0Ywa2E3S1l4blpTTTJ1?=
 =?utf-8?B?ZXhibm5NNGpDTVBmRHREREd4cmQ2amxJWDhrbzRBc1E4ejNiQVN0OThIMVh0?=
 =?utf-8?B?UmJ0M2x3R2xvOHVpY2dQcS82a2l2MXpWWCtGSnNBOUY3Y3labytTVEpJNWtD?=
 =?utf-8?B?YkRFaW1nTEJVSGhDaVBFandCY3JDVFFadXFXdmxCR0FDckFKS09reFFQS05C?=
 =?utf-8?B?b3FVTWxHQmFrYnc4SWhXazdIcm9Iajl4WWlZeWs4elVsVTRJTFZtQmtJRjUw?=
 =?utf-8?B?TkdqY2F5UUJFMWRiSTU5UnJ1TVorb2ZCeEhoVHZwQmNQVjErdExzcTJMOHEy?=
 =?utf-8?B?Yy9mdmFhSXk5WTNadGRrRWw1cVI4OFlvU2pOUFpqUVR2UG0xU0E2ZzNYdHYw?=
 =?utf-8?B?eGtoY2srTklXSWd6alZLcTN2dTVSbXk5UU9zWE16anIrSWRmcmc1bkVsVHNs?=
 =?utf-8?B?YkRPUWszVlRzcEg2alpxMjRVazAvbjJTWUZoNmttbHpJZk5DaU5aV0J4QTE4?=
 =?utf-8?B?QmJHaUlKTWMvWVozY1I5K2lweTVZTTJaSU1TVDRNZ29Md05saWdsMHByMGJZ?=
 =?utf-8?B?OHFKK1FmVEExZCtXRXdja1JhWFJtajgzU2p6Q1h1aERZb0dTUEMvM2tzRVdi?=
 =?utf-8?Q?VaYBsMyjZBXMbOQQg3by9E7vF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E622588529B4754CB4D6D718F3BA35F9@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a8e2cc-834b-4214-6ea6-08db7ba7ea81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 09:28:52.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lR3LR7ynh9PCR0lGLQvQchynDH0pTsQt87Vr3LJLkdyrPy+lk0PBIV7sMLRMX8M0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9627
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTMwIGF0IDExOjA3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFR1ZSwgSnVuIDIwIDIwMjMgYXQgMTM6MTYsIFZpbmNlbnQgV2hpdGNodXJjaCB3cm90
ZToNCj4gPiAtLS0gYS9rZXJuZWwvaXJxL2NoaXAuYw0KPiA+ICsrKyBiL2tlcm5lbC9pcnEvY2hp
cC5jDQo+ID4gQEAgLTQ3Niw3ICs0NzYsNyBAQCB2b2lkIGhhbmRsZV9uZXN0ZWRfaXJxKHVuc2ln
bmVkIGludCBpcnEpDQo+ID4gwqAJfQ0KPiA+IMKgDQo+ID4gDQo+ID4gwqAJa3N0YXRfaW5jcl9p
cnFzX3RoaXNfY3B1KGRlc2MpOw0KPiA+IC0JaXJxZF9zZXQoJmRlc2MtPmlycV9kYXRhLCBJUlFE
X0lSUV9JTlBST0dSRVNTKTsNCj4gPiArCWF0b21pY19pbmMoJmRlc2MtPnRocmVhZHNfYWN0aXZl
KTsNCj4gPiDCoAlyYXdfc3Bpbl91bmxvY2tfaXJxKCZkZXNjLT5sb2NrKTsNCj4gPiDCoA0KPiA+
IA0KPiA+IMKgCWFjdGlvbl9yZXQgPSBJUlFfTk9ORTsNCj4gPiBAQCAtNDg3LDcgKzQ4Nyw4IEBA
IHZvaWQgaGFuZGxlX25lc3RlZF9pcnEodW5zaWduZWQgaW50IGlycSkNCj4gPiDCoAkJbm90ZV9p
bnRlcnJ1cHQoZGVzYywgYWN0aW9uX3JldCk7DQo+ID4gwqANCj4gPiANCj4gPiDCoAlyYXdfc3Bp
bl9sb2NrX2lycSgmZGVzYy0+bG9jayk7DQo+ID4gLQlpcnFkX2NsZWFyKCZkZXNjLT5pcnFfZGF0
YSwgSVJRRF9JUlFfSU5QUk9HUkVTUyk7DQo+ID4gKwlpZiAoYXRvbWljX2RlY19hbmRfdGVzdCgm
ZGVzYy0+dGhyZWFkc19hY3RpdmUpKQ0KPiA+ICsJCXdha2VfdXAoJmRlc2MtPndhaXRfZm9yX3Ro
cmVhZHMpOw0KPiANCj4gVGhpcyBicmVha3Mgb24gUlQuIFRoZSB3YWtldXAgY2Fubm90IGJlIGlu
c2lkZSB0aGUgcmF3IHNwaW4tbG9ja2VkDQo+IHJlZ2lvbi4NCg0KT0suICBJIHdpbGwgcmVtb3Zl
IHRoZSBhY3F1aXNpdGlvbiBvZiB0aGUgc3BpbiBsb2NrIGF0IHRoZSBlbmQgb2YgdGhpcw0KZnVu
Y3Rpb24gc2luY2UgaXQgd2FzIG9ubHkgdXNlZCBmb3IgcHJvdGVjdGluZyB0aGUgaXJxZCBmbGFn
cy4NCg0KPiBBbHNvIHRoaXMgaXMgb3BlbiBjb2Rpbmcgd2FrZV90aHJlYWRzX3dhaXRxKCkuDQoN
Ck9LLCB0aGF0J3MgaW4gbWFuYWdlLmMgc28gSSdsbCBtYWtlIGl0IG5vbi1zdGF0aWMgYW5kIGFk
ZCBpdCB0bw0KaW50ZXJuYWxzLmggYW5kIHVzZSBpdCBmcm9tIGhlcmUuDQoNCj4gPiArc3RhdGlj
IHZvaWQgX19zeW5jaHJvbml6ZV9pcnEoc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KPiA+ICt7DQo+
ID4gKwlfX3N5bmNocm9uaXplX2hhcmRpcnEoZGVzYywgdHJ1ZSk7DQo+ID4gKwkvKg0KPiA+ICsJ
ICogV2UgbWFkZSBzdXJlIHRoYXQgbm8gaGFyZGlycSBoYW5kbGVyIGlzDQo+ID4gKwkgKiBydW5u
aW5nLiBOb3cgdmVyaWZ5IHRoYXQgbm8gdGhyZWFkZWQgaGFuZGxlcnMgYXJlDQo+ID4gKwkgKiBh
Y3RpdmUuDQo+ID4gKwkgKi8NCj4gPiArCXdhaXRfZXZlbnQoZGVzYy0+d2FpdF9mb3JfdGhyZWFk
cywNCj4gPiArCQkgICAhYXRvbWljX3JlYWQoJmRlc2MtPnRocmVhZHNfYWN0aXZlKSk7DQo+IA0K
PiBTcGxpdHRpbmcgdGhpcyBvdXQgaXMgZmluZS4gTm90IHJlZm9ybWF0dGluZyBpdCBub3Qgc28g
bXVjaC4NCg0KV2lsbCBmaXguDQo=
