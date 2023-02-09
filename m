Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6069007D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBIGi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBIGi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:38:57 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAC44345A;
        Wed,  8 Feb 2023 22:38:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7Be1Ox9kUglPVma9xIvVts8PcI9CjAi/ULDHorE9DaBFLzRjvSkYAek0YtshEHY8LNivlCDRPxoRxZ317SMdn2LzTKgguI+Qybv9Nvip53A34xtCVpmtDlnuUkY71vrcX2OChaMVPu7f5D6GhG53tp1N1qRtFwX6HcH87qhsGAK3nf38qUatU6FzezYp/5HiqT0oNgKADSPoA3U252lLyU1lM8PD3nO9cuY1HxeuvZbvNQTjkotVggILxMKkf29tDFbrfqhx5KiZe0wTisv8D9gEaAHdbRmrOrgooyVpv41tCoXh2aVl/8ME1x4mR6yhy5JDncG66LmhEx3T7KsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or7cMk9qLY7TVvKlzrf670K4y9T0prgU/RAR9KIZclU=;
 b=BQFQes6COv9EvXRHJGxbUbEmhvVpYR5mfYRYz9Y2XCu0j6y1wCNYEWj3GrOc/c+hzYLQ2Yuh62uNASv6T/T27JfnKLbBWymP498bukSYQmfD1tHy2bjnU06NhYf7mYWEVYWrZYpsG51OFxNVNJq8pHPKOyFPspQWY1sT7/CTZKLl3HPfa/DJf4JMuSjpsqvWm3I2bsGnSSvmRuBsvfeGwnE4pCM5J01qUSWa7vrdkUppNGZq6YYOZxINC4Y1/ujB0u20X71MRz2VHAEXSBT28JvQdmf1x5/nOwteBBsLStDc7+ERwbsndfuj3Zexcq25vY8QdX/IoqlmihQLIVSO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or7cMk9qLY7TVvKlzrf670K4y9T0prgU/RAR9KIZclU=;
 b=RMFZDvFKHb4bGg0OYvwfErniSu7DH6ZvCz2ECwB9vo77HQmAngghvUwM7REZBG2DFqNtdVJo+qxrSPdipLrSLaz7KpX21fGD7S4FXcr8ZzIZE/N7mJAUjhRZT5MWdUH13/kM7hb8TYhfC8+XZBJR/APPbpwCXQwO7RFfQb/SDaR1E44RjZ4J3HEq8+xKjIpwq3dCFwFN2shfDQ2WLk53ZZdbc0bng1vn1czv9NpNtGcuPG260Ka3Jx5RRxGlIBVTw2eHLZCrgivj4UDKbzIg8SlmSQHg1gDOm+ZlywDyzXlnhVs8iwk8SvnXhllTn7/j4TaAEDZkyZNTkrJcxeSlow==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2446.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 06:37:55 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%6]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 06:37:55 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Song Liu <songliubraving@meta.com>
CC:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v10] module: replace module_layout with module_memory
Thread-Topic: [PATCH v10] module: replace module_layout with module_memory
Thread-Index: AQHZOosZZk5xmhlffkGn7YoYAd2Wp67FVf+AgABsgQCAAGp9AA==
Date:   Thu, 9 Feb 2023 06:37:55 +0000
Message-ID: <e46be975-0f57-c654-0018-20151618e778@csgroup.eu>
References: <20230207002802.2514802-1-song@kernel.org>
 <b40ec330-8c9e-0265-19b9-d82b516c95c1@csgroup.eu>
 <70DCC6C0-53E2-4C18-B147-B2F600C66E54@fb.com>
In-Reply-To: <70DCC6C0-53E2-4C18-B147-B2F600C66E54@fb.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2446:EE_
x-ms-office365-filtering-correlation-id: 47c56e50-e720-4ce6-08ae-08db0a682d20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A59ZaNiKBA4mB3/R46Tadweb9IHU5rgrg4kjumodL2qjHV5/k6Onh+84aQoERSSLUZLQkNsc4Z46vxWQ+aPy4WQSSJFNAC3JdLKY4b4lkIfQzT33U82eHm3e2pQdkFiKlaRo7fj6kY7RAr5XXLzAay31HPwdTse/l8SJgvFEzuHv7MH6yhNPF7JI/B7mcRlrwxOZrf0zcJQLW/sCHxZZm/XKEy7WCOmBnwC7XIyUS4yhywV7U6GT2D4zpPafRmXMon3zU4MVqIJss2UWzrbX+U6+3qMgQrGI0+m8GoHmIyAps+wUc50WkIsz5OMjkVZ+Gmoir5jlW2msPQ03gfhd2dKQJ8V8WbzR2PJIbagkMJ1mGqyuMn4y/owyupz08Vn8qzdeWARlgZfib6LVsKu6MHCBO25Z6q7HwS2xg9aD8yZRqaaOi1g+ZOWIZ+sE5lSH1PRzOEQdGGfssq/U8lz9jSRrZlZs9ne5yxcJKhxz71imhZyCIKGG5MUzB/9i1szOLm/XCGYyamRGsYw5VrZ5p3P8YaveonbC9kvVl/uCmOnFwjm3xz1PEj8iFO2Qjh2xioZYhGi1L7PklbleqVfOVP/awRpRN67ZXPkN02PDMVpb76HAqR5YSx9drblqJqSkMx3nPMJFAsDy1pRxm0whspACTCU+H73mtDPKyWbg4YdGgvHx0W2Yu3r0ZDQdcUlYUt9fXx9jI5NN+Ghmh3QPccq8Md6T2YPleIcqzBPSPswUVrprLPY3aSNVjad3Ky+OqN4JGv4LWcWuBFKvUAiNww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39850400004)(136003)(346002)(366004)(376002)(451199018)(31686004)(83380400001)(2616005)(478600001)(54906003)(2906002)(316002)(76116006)(38070700005)(91956017)(6486002)(38100700002)(71200400001)(36756003)(122000001)(66574015)(41300700001)(66946007)(4326008)(44832011)(66556008)(6506007)(6916009)(8676002)(8936002)(5660300002)(26005)(31696002)(7416002)(64756008)(86362001)(66446008)(6512007)(186003)(53546011)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkozMTlJbDdDZUY4MDdRb2JpcU9PYzE2ckxRRFFhNzEwOVhXNmRPSkVvVHlY?=
 =?utf-8?B?MmU0YUZBQXZuVVZjWVhrVkc0akUwc0JkWEZiV0NGL2dCS0REZm9VcjN1NjFM?=
 =?utf-8?B?QXZzL0hRODVUSXl4TUl3K1gyb3IxVEtPb1hpa21qL1R5ZlJSbkFEMFcvTEY0?=
 =?utf-8?B?QXRkNWlJeUdaTmp2NFdFYUplUHR1a0tHV052VWlPQ0dqSlhob05Wa3VIRmx1?=
 =?utf-8?B?Z016bmh1R2lYQWp1TFNlL1JSZzBmS2JlWnRmWi9IK1dtMDJiazdpTWhnd2Nv?=
 =?utf-8?B?bE9HV3VYVnlQYXI4clJmOWpKUjVleFNaSmJzN01TTUo5NmVXSG9NYklEMmFh?=
 =?utf-8?B?QnZ5N0ZMeUU1Tmp3YmpaaEE4R3NYbjFNV1BPMGFDRCtkbVplLzBFb0pQSEV5?=
 =?utf-8?B?aXBzNnFSZmQrWFViV3NlMFBFVXQ5ZHRCQkI5U3dicUpnSFl1SDFONXJEVzdu?=
 =?utf-8?B?WHdDQ0FCTXpaUGhyOEUwZ3FZdXVGbng2UitUaWd5eDY5alNFTW9VVzdsamxk?=
 =?utf-8?B?Qldhbkp0TEdBQUxJeEVDODlGdUxvcUJ2Q0QwTFFQcWNjWXZTSTZwc2g0L0da?=
 =?utf-8?B?TFI5RitxMnlrZ2o0MkN6YmszZVI0WEV3bzM4ZVRHL1V3blJMOUFBYmROT3RZ?=
 =?utf-8?B?V3VndTArOElGVTRQMDVESnlPNXJHS1F5Nk5OZXkyWnhlVUx6OXZQclIya3RH?=
 =?utf-8?B?MGdxcHVhMW96WUkyQVNiTWptcFZTQkRTbWY2bEd0ejBTVW1wM0pnYWNTK0hy?=
 =?utf-8?B?RHUyN292eXY4Z1ZOMDhhNy94MGtKVlFVS2x4ZDBYUHk2ZGI2eVBtSis1am1C?=
 =?utf-8?B?dDlQZm1JR1piYXR6aG9xNldRbzBOR09lZ0FTdXVaS1Jxb09wNUF2VEcremVL?=
 =?utf-8?B?bmtlSm9ONmQ5TWpvbWFZaDQ2S2NzaHlSSDJ4QktIVEkvL1JjRjdadldvNFVM?=
 =?utf-8?B?cW9iK21SU1NvbG1vZHF6aDhWbHpTbWk5ZDBhNzBqdmpmZk10eWM5SnhGSXUy?=
 =?utf-8?B?M3A2bkxmakkyejVwRW5zQzBaVEJ5cVZSdGp2djByOVRPdkVNVGxJR202dUhT?=
 =?utf-8?B?NmROVHRpaGlndGkxYm5HbmN1UU9EMDNrVnhwZjBwRVRlOUZmaHNFVGRvVFh1?=
 =?utf-8?B?Y1ZuTVgwOHJnU1ZXNXdoWWd2eWlpSmJQRjRqeW43OUVINElzVGZSSllTMisv?=
 =?utf-8?B?aHJaWDZkRU9hdVEwSnZYNHIzVlpoYTdFVit3WUtSVlNxYlVSMzBDY1YzUWxE?=
 =?utf-8?B?S0xHUWg2MWF2ZUkyNHRtUXdXL1JDUkJqYUJubm9CTkpJTW9RaWtIVEY2K3h0?=
 =?utf-8?B?OG0rempQaVNoT2FTOGtrRUJySnRCR1hyQjBQRXlja2pERHAwbWwwZldtVGgz?=
 =?utf-8?B?RHlCNHNKWk5oOFlNSGVlNWtPNEtUMHZra2dlSFdZN3VkdFUvT0xKUzB4c1kx?=
 =?utf-8?B?bEFMcitObzljbGR4L3pBOWZuZDZ3SytFS1UwVVBwa3VLZmJjQzQ2S2NPMlB3?=
 =?utf-8?B?OHI0VmlSaU5KUDVwTHdzM3pPOW5lQXVoVHNjV1pqZzBoUjIvQVJqYTNYNjUy?=
 =?utf-8?B?OFFEeHFRSk4zZ1ZoZis4TG1lalc0eW9hSm9HT3JzQkUzdmNaTDJHOHkvQ1Zx?=
 =?utf-8?B?RS9IalE5Z0tJRUs0dGx4Ukdpdm5oUWFqUDdlTkREdXBFSzdSQm94d2hGMGtm?=
 =?utf-8?B?OTMyLzlhWXZtak43WXpMbTBGd2xSbmhoUXViNG5scy93c3NiVWVYUkF5L0dr?=
 =?utf-8?B?V0VKMXF4ZlUrRVo5NXVpSnh3a2h1dnErOGxkaDZMWDl5UThOVS9qS2QrczJR?=
 =?utf-8?B?RGVZc1lxQ0FCSGRqZXhac25TTVRxV29nUTk4aGxvVEJGWHpZZUNObnlDaVh2?=
 =?utf-8?B?SkswV2JNRmJXWG1kc3J1b204aG5mQTgzcUVTMjlKZGhTL2lqQlczbmZBSzVs?=
 =?utf-8?B?SEtHWWV3eTFtTnd5cDNnaEJNTkdaaERTb25ZY2FFeVErOWVZaHliK0dMMzdD?=
 =?utf-8?B?MjV2NXVkZGMxa2lDejVueDZMR200dk56bVB3V0g4M1dIRStZT1Qzbk1haHRG?=
 =?utf-8?B?cUVTVWdyeTQybTNDdXhHYWYyMzhXTUdSMGc2YWloeFNkY2htNkhTTk5JWTdX?=
 =?utf-8?B?VzVOcWRXOGpIR0lYU0lzWHVReXk1U3VkNzYweUpGb3UwMkpRNmlaMWVJVklU?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3137D0AA750E64283F70866E25633BF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c56e50-e720-4ce6-08ae-08db0a682d20
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 06:37:55.2382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JceX2jZPSGyjNosJ/grYNeA3kT/38BCIboh3DlUmW+ew8Sgp07ME1qEb0/1SxROCAe6d3Hm0amFcsS1DvQl+PaNR+fdp6/W3OfdFuT5nLTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2446
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA5LzAyLzIwMjMgw6AgMDE6MTYsIFNvbmcgTGl1IGEgw6ljcml0wqA6DQo+IA0KPiAN
Cj4+IE9uIEZlYiA4LCAyMDIzLCBhdCA5OjQ4IEFNLCBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3Rv
cGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+Pj4gICB7DQo+
Pj4gICAgdW5zaWduZWQgbG9uZyBtaW4gPSAodW5zaWduZWQgbG9uZyliYXNlOw0KPj4+ICAgIHVu
c2lnbmVkIGxvbmcgbWF4ID0gbWluICsgc2l6ZTsNCj4+Pg0KPj4+ICsjaWZkZWYgQ09ORklHX0FS
Q0hfV0FOVFNfTU9EVUxFU19EQVRBX0lOX1ZNQUxMT0MNCj4+DQo+PiBBICNpZmRlZiBzaG91bGRu
J3QgYmUgcmVxdWlyZWQuIFlvdSBjYW4gdXNlIElTX0VOQUJMRUQoKSBpbnN0ZWFkOg0KPj4NCj4+
DQo+Pg0KPj4+ICsgaWYgKG1vZF9tZW1fdHlwZV9pc19jb3JlX2RhdGEodHlwZSkpIHsNCj4+DQo+
PiBpZiAoSVNfRU5BQkxFRChDT05GSUdfQVJDSF9XQU5UU19NT0RVTEVTX0RBVEFfSU5fVk1BTExP
QykgJiYNCj4+ICAgICBtb2RfbWVtX3R5cGVfaXNfY29yZV9kYXRhKHR5cGUpKQ0KPj4NCj4+PiAr
IGlmIChtaW4gPCB0cmVlLT5kYXRhX2FkZHJfbWluKQ0KPj4+ICsgdHJlZS0+ZGF0YV9hZGRyX21p
biA9IG1pbjsNCj4+PiArIGlmIChtYXggPiB0cmVlLT5kYXRhX2FkZHJfbWF4KQ0KPj4+ICsgdHJl
ZS0+ZGF0YV9hZGRyX21heCA9IG1heDsNCj4+PiArIHJldHVybjsNCj4+PiArIH0NCj4+PiArI2Vu
ZGlmDQo+IA0KPiBUbyB1c2UgSVNfRU5BQkxFRCgpIGhlcmUsIHdlIGFsc28gbmVlZCB0byBrZWVw
IGRhdGFfYWRkcl9bbWlufG1heF0NCj4gYXJvdW5kLiBEbyB3ZSByZWFsbHkgd2FudCB0aGVtPw0K
DQpJdCBpcyB1cCB0byB5b3UuIElmIHlvdSB0aGluayBpdCBpcyBub3Qgd29ydGggdGhlIGVmZm9y
dCwgaXQncyBmaW5lIGZvciBtZS4NCg0KQWxsdGhvdWdoIGl0IGNvdWxkIHByb2JhYmx5IGJlIGVh
c2lseSBmaXhlZCBieSBkb2luZyAodW50ZXN0ZWQpIDoNCg0Kc3RydWN0IG1vZF90cmVlX3Jvb3Qg
ew0KI2lmZGVmIENPTkZJR19NT0RVTEVTX1RSRUVfTE9PS1VQDQoJc3RydWN0IGxhdGNoX3RyZWVf
cm9vdCByb290Ow0KI2VuZGlmDQojaWZkZWYgQ09ORklHX0FSQ0hfV0FOVFNfTU9EVUxFU19EQVRB
X0lOX1ZNQUxMT0MNCgl1bnNpZ25lZCBsb25nIGFkZHJfbWluOw0KCXVuc2lnbmVkIGxvbmcgYWRk
cl9tYXg7DQoJdW5zaWduZWQgbG9uZyBkYXRhX2FkZHJfbWluOw0KCXVuc2lnbmVkIGxvbmcgZGF0
YV9hZGRyX21heDsNCiNlbHNlDQoJdW5pb24gew0KCQl1bnNpZ25lZCBsb25nIGFkZHJfbWluOw0K
CQl1bnNpZ25lZCBsb25nIGRhdGFfYWRkcl9taW47DQoJfTsNCgl1bmlvbiB7DQoJCXVuc2lnbmVk
IGxvbmcgYWRkcl9tYXg7DQoJCXVuc2lnbmVkIGxvbmcgZGF0YV9hZGRyX21heDsNCgl9Og0KI2Vu
ZGlmDQp9Ow0KDQoNCj4gDQo+IEJ0dywgd2Ugd2lsbCB0aGluayBhYm91dCBhbGwgdGhlc2UgZGV0
YWlscyBhZ2FpbiB3aXRoIHRoZSB0eXBlIGF3YXJlDQo+IG1vZHVsZV9hbGxvYygpLg0KPiANCj4g
Wy4uLl0NCj4gDQo+Pj4NCj4+PiArDQo+Pj4gK3N0YXRpYyB2b2lkIGZyZWVfbW9kX21lbShzdHJ1
Y3QgbW9kdWxlICptb2QpDQo+Pj4gK3sNCj4+PiArIC8qIGZyZWUgdGhlIG1lbW9yeSBpbiB0aGUg
cmlnaHQgb3JkZXIgdG8gYXZvaWQgdXNlLWFmdGVyLWZyZWUgKi8NCj4+DQo+PiBJbnN0ZWFkIG9m
ICdyaWdodCBvcmRlcicsIGV4cGxhaW4gd2hhdCB0aGUgcmlnaHQgb3JkZXIgaXMuDQo+PiBBcyBm
YXIgYXMgSSB1bmRlcnN0YW5kIGl0IGlzIG9ubHkgdG8gZnJlZSBNT0RfREFUQSBsYXN0LiBFdmVy
eXRoaW5nIGVsc2UNCj4+IGRvZXNuJ3QgbWF0dGVyLg0KPiANCj4gSSByZXdyb3RlIHRoZSBmdW5j
dGlvbiBhczoNCj4gDQo+IHN0YXRpYyB2b2lkIGZyZWVfbW9kX21lbShzdHJ1Y3QgbW9kdWxlICpt
b2QpDQo+IHsNCj4gICAgICAgICAgZm9yX2VhY2hfbW9kX21lbV90eXBlKHR5cGUpIHsNCj4gICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgbW9kdWxlX21lbW9yeSAqbW9kX21lbSA9ICZtb2QtPm1lbVt0
eXBlXTsNCj4gDQo+ICAgICAgICAgICAgICAgICAgLyogZnJlZSBNT0RfREFUQSBhdCB0aGUgZW5k
LCBhcyBpdCBob3N0cyBtb2QgKi8NCj4gICAgICAgICAgICAgICAgICBpZiAodHlwZSA9PSBNT0Rf
REFUQSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiANCj4gICAgICAg
ICAgICAgICAgICAvKiBGcmVlIGxvY2stY2xhc3NlczsgcmVsaWVzIG9uIHRoZSBwcmVjZWRpbmcg
c3luY19yY3UoKS4gKi8NCj4gICAgICAgICAgICAgICAgICBsb2NrZGVwX2ZyZWVfa2V5X3Jhbmdl
KG1vZF9tZW0tPmJhc2UsIG1vZF9tZW0tPnNpemUpOw0KPiAgICAgICAgICAgICAgICAgIGlmICht
b2RfbWVtLT5zaXplKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgbW9kdWxlX21lbW9yeV9m
cmVlKG1vZF9tZW0tPmJhc2UsIHR5cGUpOw0KPiAgICAgICAgICB9DQo+IA0KPiAgICAgICAgICAv
KiBmcmVlIE1PRF9EQVRBIGF0IHRoZSBlbmQsIGFzIGl0IGhvc3RzIG1vZCAqLw0KPiAgICAgICAg
ICBsb2NrZGVwX2ZyZWVfa2V5X3JhbmdlKG1vZC0+bWVtW01PRF9EQVRBXS5iYXNlLCBtb2QtPm1l
bVtNT0RfREFUQV0uc2l6ZSk7DQo+ICAgICAgICAgIG1vZHVsZV9tZW1vcnlfZnJlZShtb2QtPm1l
bVtNT0RfREFUQV0uYmFzZSwgTU9EX0RBVEEpOw0KPiB9DQo+IA0KPiBEb2VzIHRoaXMgbG9vayBn
b29kPw0KPiANCj4gVGhhbmtzLA0KPiBTb25nDQo+IA0KPiBbLi4uXQ0K
