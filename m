Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3736865A1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBAL7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBAL7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:59:11 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120DF27D72
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:59:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkiHgtPKG9XsR/XUGN0ie8FPmzfFckcjMAQ3syTc6WEy9UQIJt3pthbo/2j908oiHEb3PcQHchz5Cc3zubvIhweTzS1S28KPRdyJ8u+VYllCC29QZlF55eqZF9dJk/OjlG0j/TNCGiJMVdvRRxTu4Tb6+HP+LXu10AUrCk9s1N9LIu8rAgwjE5QMOzsE7gMhtEfZbOnhorqz6hhqLvo6REdlZSC11v9FK47Eu7z+E9VU54pCvm1J6sbbsoEjBzUGvem8JPWKDg+Piv/wMnnJwA9qVsPzLE+wIqGnIQNq2QWHtNNwoVj/gy3LFX+MqdlbmKp2h+3PV7nBVGoIqdGtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCCFwp+qW7N4AHz2k91eUtbwPqGLhGtLp2bZImW0ZS0=;
 b=Ms9Zv/qMTcIzJyQHBXViH+QPNfiQr1Q7ObTSuwxi5eVL3EMvgZ5KRzrNl9bKc38vTVQSeMVw1A3BOZ00CwX21y/mTGMKzlf2FDNRgCx/iD9JGOOERO15bZnN/bTZog8bCqPOWySBA6ENNo1gnzZ0l38ct+SfAWsOrZ9lKZkJ4OHl6qtKQlccjbqcXYh2eCl0g+yCEITGzvOQjM7bWOx9UFS/g1v5eLZ58xgXLKIx7LJJ1Kaidq0kmzpKdtOe2BHAqaAdWZgUKI68uNAsKzyqJ6Go3OlxvuPZIQ+KgZSihRSO99bGdHx5f6ctpyuGnSXnjD26ckA9HXdxWgNsZA0USQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCCFwp+qW7N4AHz2k91eUtbwPqGLhGtLp2bZImW0ZS0=;
 b=nQWyPjap8lPdgkyrk/CENdgu7tm0VxTPSVB8PeC/JOiN3BuOMNoOjnx5pCLxwZF5zXpHubhZY1FgYEWyOsYAG4/FZgTdDBfVfbuW4aZxgB824H7a4qljaYkLWRNLpuYfcKe8m9psCMFaFPLdhjW3OE7oLEtJvC8F3ER+pOoV8QpDdnj/6hn0iguehTtN9ScTe/rdIbj3kZZDQwZ+6jix9EAq0huioG6NXcsK38n2E65vL0zOwwfqvlGZPTQ5mQ4GboPI4zUBKR0VtskK5z+3uIj8vNuc3sptbetqb3tq0MxMX1QyPu+kH55E3dNTLTshc5xGsLeDvHQpM30sb5cFsQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2041.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 11:59:06 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%5]) with mapi id 15.20.6064.024; Wed, 1 Feb 2023
 11:59:06 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Hyunmin Lee <hn.min.lee@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4] mm/vmalloc: replace BUG_ON to a simple if statement
Thread-Topic: [PATCH v4] mm/vmalloc: replace BUG_ON to a simple if statement
Thread-Index: AQHZNjOS2Qd2FeLiuUKIZX/WDiEk8K65/MQA
Date:   Wed, 1 Feb 2023 11:59:06 +0000
Message-ID: <fe4337c7-0ede-dfa3-13ac-2cb225904ef4@csgroup.eu>
References: <20230201115142.GA7772@min-iamroot>
In-Reply-To: <20230201115142.GA7772@min-iamroot>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2041:EE_
x-ms-office365-filtering-correlation-id: 923d94de-d51d-4432-a171-08db044bb878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2D9GJKW9gP4aYq0OBm+JmwauDREJmkV9ZtnMjzEKvjEsJfYPTTiBQIj3p4wdcHfU9TSaObqFr3vEgjT21Ak27ljMi8aiy18FkBfFjZBOEfjEiJD5wQXaqzBgI3qpqm1u1gCvPdThUDdUjnSemFBh7KGRvmL90cZP1yAQLRyOX8jUf+BARl6ExQjiQ8DwSMaeTqFa7JugVoLYVv4JZqqhMI2hurIHkktzCjPB6T3qDSkcd1R7EjrQvfjoxi43RbW5widrB5WE3oBNkDepfQjibZvyi5Z1s/MP8y2BuQAqwnjFOt+pn71zEcuOCPaVRBEtziEMiBD8CRE+vEgSEJxgSj7SuzC3rtNisDFk7sxvKFgY8ncEBJOnAa87/4/4v1IA7czgh6goysWq/92qCjNaX7a4uWMItbeby9D+Yp30sPQE0wkDvM16DJTbtT7QqK/6FycjUL3o6MlYR+LNqr35UAjsKnrrnrxPvfmy8U5ewj7abBq/HHbKBoQ1xQyNssTa3EO/3U76cmPdXd6oY7ZH5QEt/KkZyD1J6N8wihmfIRUwruw3IMKlySyF5zYqioSPE1QeBzIDGFoKMr+Xu9JXoAFNDJ2gqsAoe+gBNk/vBL1qs4hc77IZyibk11cO+goZvXwaOEvfXfzXP/LhMR2kNLehyqya3DarvNGRH2tHtRjeFsrHWNnftC+GF9SlE5kKCpeqpDODA9cMayT2lzbPOQuVltaKEaG1LeoYFit0usQQq3KbE9wtNjrWl39PwExhj4qPbLzo95i3G07LPEox8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(39840400004)(366004)(376002)(451199018)(2906002)(36756003)(44832011)(2616005)(110136005)(316002)(83380400001)(54906003)(71200400001)(186003)(26005)(6486002)(6512007)(478600001)(6506007)(66556008)(76116006)(66476007)(91956017)(66946007)(66446008)(64756008)(4326008)(8936002)(5660300002)(38070700005)(86362001)(41300700001)(31696002)(7416002)(8676002)(122000001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1pJYXdBNDlaT3JRdzI1SGZUVnQrL2N3cW5RTFZCQWNtT0MvNGNZbnQ1WmZV?=
 =?utf-8?B?K3BSUlpmWU4zRzhSTm54WUNvTnl2ZDVsdGN4eFYzcXNETFdyR2dWbHc1VWxZ?=
 =?utf-8?B?Y2tyaXNTeXE0VVRzRzlmejQwWVhGcllvMkp5TEpJUFRBZUtyK3kxbW9hd3ZO?=
 =?utf-8?B?ZU5KQUVvNUhHNGRkSnNTeFlQZ3BGWXVmTzZWMWhYMDZaTGV2RTR4eEpPekxU?=
 =?utf-8?B?Zk04dEl0QmVjVzZlL0NjcU9YMWRPdHBlc0tqSkFvWGt4N3JxWlQwQitBTFVv?=
 =?utf-8?B?aEFzWkc3THVlbTRxZ3MwMlEvWWhiVnBuKzQrRmFLcitpa2VRTXBKdVdxeEE0?=
 =?utf-8?B?VU9GVWlQNm05THBBYzd3ME4rNGQ0d29VSzdzcitJQk16bkI2bUlxcGdGR0Rl?=
 =?utf-8?B?OVFPQk1TV3dLNVpxcER3UGw0a2grZEtucWI3b24vbFhzOSs4ZnBROUxhbmlC?=
 =?utf-8?B?Qm1obXd4SHVKSVBiaTl3MGtRRnpEMXZjUnVPSWFCNVRsa2JQdjh1WE1iNlJ2?=
 =?utf-8?B?OUVYVEVNVFlSQ0RwdGRZazBUOGZOb1ZEQUh2VERwbk95RkVVendqa3RhdDg5?=
 =?utf-8?B?VHVZb3ozaGtSRG1Oc0hEZ2owVUxXVy9Pd2k0MThKSmZldkdBVXB3M0t4Qk8r?=
 =?utf-8?B?Wkt3YjFIZlF4eFRsbzFzdk5mZGdkVGlUNjgrMlpIRGZwbUc5OGNaNlZGbjVu?=
 =?utf-8?B?bTFzbTVsbmF6YjV2RENjSE15WVpIWU1kVTZiSGRINHpiQ2FMVmpoeGtHa1Nk?=
 =?utf-8?B?SEVmdUxPT3I0MFZaNk5EUkhYRGhqTEtlY2JaTXVGUkJuYUoyVGtjVHlIWmti?=
 =?utf-8?B?djZKWm1YL0NhcnRXbWlvTHhWZENoWlFYMzFEU0R0cnd4UkZaamJKMVFUeWZQ?=
 =?utf-8?B?RjJSQmpYQlhFTjZhbVVFbnphZmdoQUk4dmRmY1FraS92UzNrRVQxdFl5ZHFz?=
 =?utf-8?B?RTE3RFRuTFRvQURkenNudTR5N2FVUWdleG5rZWMyOWxWeG9DUkZETEtWT3hr?=
 =?utf-8?B?UXMyL1Z1U3l5NThhZ3FpTzRTM2dNSXVWWmZ3Vm43RTgxQzZ4LzJRYjdLS2lE?=
 =?utf-8?B?dmlTTmVUU01qRGpLdGVXUTlOc2pXV2prRVpVNUYxdjNFODdrZVN4UW4wa3JO?=
 =?utf-8?B?blBXdG9TWmhsb2xySGJjZXRnUVB1dEtibyt0NmtpeUpPandQQjh6WHNQcWJD?=
 =?utf-8?B?UlpkR0ZHV3paOGhzalBoQWJtNk1HcEhyS0pCREN3OXlGNnllSGUzWm1ab1l6?=
 =?utf-8?B?T0VXM2JRWTRORzM3RWQzWjRWaW5HMnBWSHduSzBGUWdFRjM1WStVYUpTRnlw?=
 =?utf-8?B?Y1FnTHpoS1NPZzluU1FpTldMa09pM0hFMWd5MzFlVFF1QjFGSkhvcVBMUmV0?=
 =?utf-8?B?WmxJbllNRURkREZyQzEyY0VCeVBpd0QxM2pMNzhpVHZtakZKSkthYnVsbDRD?=
 =?utf-8?B?OGx1dnB0MVJlWU1KcktBTHR1ZE9DVjZiclVDT3ZHT3B1Tk5QUVlEREZwMHlk?=
 =?utf-8?B?SWFoblNUSjFJTVpNcisrMVk2UldVd21pQUl5WmxxVzhGSkNFUVBWR296L2lT?=
 =?utf-8?B?bUxIaFlTVllGdDJKd2s5a01xOFVwSk1OTk02SEpsN1JjRzF4U2tYbGFYY0Ey?=
 =?utf-8?B?WTdBNk54Z3k3NTZNSTRkTzNxeW8vNjEvSWxDdGswcktmWm1kVmJqcktIV0Fx?=
 =?utf-8?B?cGI5VmJrb1FtbTE0VzVqNVd1SWJzdnhia3gwSWd3NnJmVGtzVi9HT2hSN1A2?=
 =?utf-8?B?bEdkSzJTZVlmQUV5TjVTTEp6RUxyYkUxWXJ4S1lVQlJKWm5pc1dpSnZwbmVu?=
 =?utf-8?B?TUJHVGVLOGpMYTlHSklzQktpQ2I5YlJSS1lwWnBBSE9KNExFeGM5TGcxL0J0?=
 =?utf-8?B?V0NobUY3VnY4M0JHa0RPQi9rTTByb1Q3YUVHcmhQQVY0dm5laW04OUZDMm9a?=
 =?utf-8?B?MUc5OFVLcFZFNG1na1Nmdjdlb2lNNjczLzExYWZqQisvVUdpa0lNby9RR2Y1?=
 =?utf-8?B?NVZBeEdKeTRER0lETHJ0MFdEdEw4c0tnWlBmSFkzN2hwQzV3eFRMZ0tUYkdZ?=
 =?utf-8?B?QUFqWUtqQ09UaXdtNkJ3MnhibUNMckphUFptNW0wajRIQ3FnN2lwa1JDdXk0?=
 =?utf-8?B?a3hxR1VtZi9ORHpXbXRieTdvcWNKdzIxdlcvQmZudktuMlJyc0oza2ZaL0hm?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <124DFB5A10CA0D4781FE918BF940F0B0@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 923d94de-d51d-4432-a171-08db044bb878
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 11:59:06.6716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xT2p5bixDj+JmFUrnNyJRuHIF/eoohduFb8C35jReN4lsLwGpwA1uKhH6BRO0PRj1AjGA1GWbuTpVM4MzPqaZ9RqqbqaE65fzLnnMwPLNrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2041
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAxLzAyLzIwMjMgw6AgMTI6NTEsIEh5dW5taW4gTGVlIGEgw6ljcml0wqA6DQo+IEFz
IHBlciB0aGUgY29kaW5nIHN0YW5kYXJkcywgaW4gdGhlIGV2ZW50IG9mIGFuIGFibm9ybWFsIGNv
bmRpdGlvbiB0aGF0DQo+IHNob3VsZCBub3Qgb2NjdXIgdW5kZXIgbm9ybWFsIGNpcmN1bXN0YW5j
ZXMsIHRoZSBrZXJuZWwgc2hvdWxkIGF0dGVtcHQNCj4gcmVjb3ZlcnkgYW5kIHByb2NlZWQgd2l0
aCBleGVjdXRpb24sIHJhdGhlciB0aGFuIGhhbHRpbmcgdGhlIG1hY2hpbmUuDQo+IA0KPiBTcGVj
aWZpY2FsbHksIGluIHRoZSBhbGxvY192bWFwX2FyZWEoKSBmdW5jdGlvbiwgdXNlIGEgc2ltcGxl
IGlmKCkNCj4gaW5zdGVhZCBvZiB1c2luZyBCVUdfT04oKSBoYWx0aW5nIHRoZSBtYWNoaW5lLg0K
PiANCj4gQ28tRGV2ZWxvcGVkLWJ5OiBHd2FuLWd5ZW9uZyBNdW4gPGd3YW4tZ3llb25nLm11bkBp
bnRlbC5jb20+DQo+IENvLURldmVsb3BlZC1ieTogSmV1bmd3b28gWW9vIDxjYXNpb253b29AZ21h
aWwuY29tPg0KPiBDby1EZXZlbG9wZWQtYnk6IFNhbmd5dW4gS2ltIDxzYW5neXVuLmtpbUBzbnUu
YWMua3I+DQo+IFNpZ25lZC1vZmYtYnk6IEh5dW5taW4gTGVlIDxobi5taW4ubGVlQGdtYWlsLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogR3dhbi1neWVvbmcgTXVuIDxnd2FuLWd5ZW9uZy5tdW5AaW50
ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKZXVuZ3dvbyBZb28gPGNhc2lvbndvb0BnbWFpbC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFNhbmd5dW4gS2ltIDxzYW5neXVuLmtpbUBzbnUuYWMua3I+
DQo+IENjOiBIeWVvbmdnb24gWW9vIDw0Mi5oeWV5b29AZ21haWwuY29tPg0KDQpSZXZpZXdlZC1i
eTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KDQo+IC0t
LQ0KPiB2MS0+djIgOiBBZGQgY29tbWl0IGRlc2NyaXB0aW9uDQo+IHYyLT52MyA6IENoYW5nZSBX
QVJOX09OKCkgdG8gaWYoKQ0KPiB2My0+djQgOiBVc2Ugb25seSBvbmUgaWYoKSBmb3IgdGhyZWUg
Y29uZGl0aW9ucw0KPiAtLS0NCj4gICBtbS92bWFsbG9jLmMgfCA1ICsrLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9tbS92bWFsbG9jLmMgYi9tbS92bWFsbG9jLmMNCj4gaW5kZXggNzRhZmEyMjA4NTU4Li4z
YjdlODg1NmJlMzUgMTAwNjQ0DQo+IC0tLSBhL21tL3ZtYWxsb2MuYw0KPiArKysgYi9tbS92bWFs
bG9jLmMNCj4gQEAgLTE1ODcsOSArMTU4Nyw4IEBAIHN0YXRpYyBzdHJ1Y3Qgdm1hcF9hcmVhICph
bGxvY192bWFwX2FyZWEodW5zaWduZWQgbG9uZyBzaXplLA0KPiAgIAlpbnQgcHVyZ2VkID0gMDsN
Cj4gICAJaW50IHJldDsNCj4gICANCj4gLQlCVUdfT04oIXNpemUpOw0KPiAtCUJVR19PTihvZmZz
ZXRfaW5fcGFnZShzaXplKSk7DQo+IC0JQlVHX09OKCFpc19wb3dlcl9vZl8yKGFsaWduKSk7DQo+
ICsJaWYgKHVubGlrZWx5KCFzaXplIHx8IG9mZnNldF9pbl9wYWdlKHNpemUpIHx8ICFpc19wb3dl
cl9vZl8yKGFsaWduKSkpDQo+ICsJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiAgIA0KPiAg
IAlpZiAodW5saWtlbHkoIXZtYXBfaW5pdGlhbGl6ZWQpKQ0KPiAgIAkJcmV0dXJuIEVSUl9QVFIo
LUVCVVNZKTsNCg==
