Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE174C6C2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjGIRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGIRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:35:22 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2187.outbound.protection.outlook.com [40.92.63.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4ABC9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zvydu+wrxE0ZZgY+dq30wIrl0lpt/kWTWrhN2j4JHSX/iTK3OhNf0VZUxCEEXn+XmFhwv9FXmHxt5t5GmyDip3SF8Kq1SExKbf35hcd3/O1ad4MGxEgeRK7zEV6x9T2lyJTkw2RaLKl2dYpxJ194iMMOcaV0oo0zGSrPIgYP6DJDOHtulfNwWUQbXkn2r476Byr840q+2waV9oNgJHwp6bpMHgW0SXpYUrIJtu9O0Kt1BwIp3rXNM5Mj4BT5e12M7HMmr2AZIOAaX/GDCa0py8nFBtHEfkVE00GJv4C0psW3UiCOS7hVZ83NlQW1MNvmZOEyGGcyk/ZHy9WTvbkilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OaiLQIAZs6zH+CDBJPYXe0ccSkEwAo9ixLZYWFm6t4=;
 b=h8D+WoF1+Rofm5p2RJV+mwFOZC55Zpt1tJqrh5FzyOIjzZ2lYY5fpP3cz1xJBPfE7invMZm3q0Cv8aasSDnvJ0pelOwqngYVnwzv8yfjqQBqyKFPfBIcsd8IsD7cxcQXQX3i3zaNpL7GC7CHGVcbUdnkaGrACiIg9d3n484xS1GPISvl6ckG8e0qKQ1RegBY4bJbyisSGa1KUcBq3VYDL81vLyA++Q9YpdTzf+Dqi6Z4oCWB6+9gmgyEi73EfgjZHwH55IspF/bL2pgdXHdVXr/hUORuf1MLd0dOMkyBzzF6p/OTik4gXNFcCByMulkl3nSrFIT3f/U0BZha5RG5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OaiLQIAZs6zH+CDBJPYXe0ccSkEwAo9ixLZYWFm6t4=;
 b=gV1VWV1oiWDLVXw5gDhcUWpzcQVG/hhdfCtYlaAJfe5uEjMtnyn9A3RlWMs2XksPtSG2ZzkXYr/ux6xx2OZ4NlYL7FtQPbmijqIL5ChdTucRCxrQeZTcKD0Lt7Vi5/JgOfHOD2qzZm0CIc3HVtKZUbZ/x05by1XptAEJM13TxCLoMLqXkFPGAOFeYsVAGkNTPyAJR2k/ll1RKWnWLT2SPkXUwtRLZkgCZR16K+bgVGnRH//GjrmYmVml/kXhfSeAlwM0ZGnT0QgWGFYrLSX7LJItwc1DsyD1pc1rXI87O0HbDohZxYPnbfTQBXAGZoY69e4L3avA0oI5yy83v2/lFw==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by SY4P282MB3873.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Sun, 9 Jul
 2023 17:35:14 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 17:35:13 +0000
From:   =?utf-8?B?4oCOIGRvbm1vcg==?= <donmor3000@hotmail.com>
To:     "chenhuacai@kernel.org" <chenhuacai@kernel.org>
CC:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "zhoubinbin@loongson.cn" <zhoubinbin@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "tangyouling@loongson.cn" <tangyouling@loongson.cn>
Subject: Re: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Topic: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Index: AQHZsmnnf7L6P8pq70KmLgqGjaEZu6+xj+EAgAAiuAA=
Date:   Sun, 9 Jul 2023 17:35:13 +0000
Message-ID: <62e81ce06e69d549b12d1145429730f8b27ad156.camel@hotmail.com>
References: <MEYP282MB2597CD6E861D659E3218148DD933A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
         <CAAhV-H5P_NgJ5kTQ1iO-eL577D=-COjEZ6u9_OgvrHpWJLqsXw@mail.gmail.com>
In-Reply-To: <CAAhV-H5P_NgJ5kTQ1iO-eL577D=-COjEZ6u9_OgvrHpWJLqsXw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [rhbjT9LNeZgDB8m9LPtEeD/kFDe19uKgAYBh5v0PieiM3+RVDIDi1A1I7S5qSU+z]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|SY4P282MB3873:EE_
x-ms-office365-filtering-correlation-id: 209370aa-b06d-4658-2582-08db80a2da38
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5/CWeSWQE9RzWZL/d/743A1umlR/zZtZAgr5Ny3Xn291x7PCAgLGj6mDR1L9Ev5lWG2u8RS6zn4YSKmO/sLjv58JtjzluITQL5twr5jJxhy97uKJVmAlO94XHLPT6i/wrZiKzFRz1PNt62u3B5qbbtc67szb9k82opuEV8ncpm3EnZ5FGrCSr1OFu6rbaf4S1Bzz1vnpxHaOrdOTPW4Vi2RwoHT/yUnTOU+M4BWgzSPlvjyLV2qgP6bqyNrl+dbz/z5PvoUyYip4uJ0HxzxTd1LrPO4+4vyac53tTwV64VltfWZ+t8es4iWX+aDDG6Qv0d2qGQmAX6saLiIQlfxURQS6JRdk4KU7zw/tx4UvNETTwfCt3BodGpSGanXu5orz+xEvowcc3wLvuzWmrO1j/TCDRREbaqdSklieuKiwp7bBmYrqrNvluD3SQZbEdi9+47vLHrwylgAbTOcRFnQnjIcSCDi49LwHx98A4QDdWgmK9Z0KV4JBhx48o2P0T2pvihfgzV1MQD91D/qNsdQZeSB2NF9jCi/+sTECNbxjkNjBGTWlOPTDLR2idDI41qMq
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFlHNDBSYmJTNTlreW5oRUREcmJ1aWp4Nm5JTnFjNnNzZ2VXRVJvL2xUelBj?=
 =?utf-8?B?bHRXT0FpV1FPb0ZiV3RnYUxzUSt6YlNTQ2JJcEI2bStWR3V4WlpCa0E2SlMw?=
 =?utf-8?B?YlBOODY0UWNOUldSWE1qNDhFdWl0c21FZnJQTGZ5dDUwOEg1VjdwbTcrblUr?=
 =?utf-8?B?TmVOSnRadUFQOVF2Z0RjeEpoRVFWWVpJc3lkOW45K0tobG1UalpjcjVYczBv?=
 =?utf-8?B?b1FDODdtOHFGbGJwck8xVFhaYzV3Nnh0VG5OTFZSL2YrQk5FMFJaKzlRZEwr?=
 =?utf-8?B?cHlZM0NKNG83aHhyekt1TlpGWUZuV3RUWm1xTVhZNWdRalhZYkVwc0JLck83?=
 =?utf-8?B?YUc4ZVdrdTQwUTVhTHIzQ2c0ZStkSXZUeEgyNE1kWVdkSzVqZklIK3RiQ0J3?=
 =?utf-8?B?TTZSMXdUZkFzVVQvUmw0MjhoaEdybzZSb240L1pwTlR6TjNtMGdCVFU1bTRJ?=
 =?utf-8?B?WVdVR2p5VWhyMWFKWkFXTXdyRXovYm82ZlBKOTRRNUNxWS9vcWp3dUtvWCs1?=
 =?utf-8?B?Q2JGMXpQUkR4MzVJdGYyQlFHaHhaWDJGL2dyMFNhRy9jeFprS1hPMHBybGdL?=
 =?utf-8?B?cnlBWkZyWU5za3crNWhxT1llRkY0RUFHK21WdzhKQWs2bmFQa1dGaFMxY041?=
 =?utf-8?B?ODBkYTJIeStwNkg1azlOYUIydnZIVXlYOWRUNm95a2VXcEo0TzJtL1h3Rzll?=
 =?utf-8?B?TUtScTZGVmJLZDNqQjZvZlRZZXduNDBCNDduQnFvMGYwVkdrOUllYzE0Yk5C?=
 =?utf-8?B?NzJlMmNNc2JzQ0swenlmb0IrMTdUZkI5clZ4WGxZM2FOZno5QTEwNWMyVTU1?=
 =?utf-8?B?UHZvQjlTaXlHbytKd2lCYzVSQjBMNDY4YnkxeXlwRmMwMzVJOERxSmc2ZUdh?=
 =?utf-8?B?UnNldDRibm93TlYySko5ZXgyZ25aMm1uV3ZmcWhNcXJ4NlA2NEY1a2VLelhl?=
 =?utf-8?B?bFVGRlZETGpuSmJ0OWlNZjlEeHRlZHl4dEw3d2xFQXRKN0FqZnFza3ZTQ2hs?=
 =?utf-8?B?S0dIa3VtZ3RBTzY4cVRHOExYY2w1WFg2OWZFWDBELzh1SjJESlM0Y3hmcmxI?=
 =?utf-8?B?a0cxaXRGT0lQR241S0FLN2lKRVdZRkZ6R2Rvd2hHN1NXZVNpcmlpWFJrNXMv?=
 =?utf-8?B?UWl5SHhBYW5pOFloTmE4YVBnM09yYm0vdTlqeUw3Q2ZHT3lxUWxiQ1NHTWZy?=
 =?utf-8?B?dUloY1pQbGEwZlM5Q3AzZEJxWVVZaENjY0xUd1JQa1RWWjV0Y1Z1RnY2ODFD?=
 =?utf-8?B?SURBVVBKVjFuQXlTY1NScU1UMlpSSFFQMGd2QkJMWkMzT2lsbXk1bndkYUo2?=
 =?utf-8?B?NzVCWXZyM0FlNmU3OUJhcVpLVm1rMldsRHZBcm1hRXBLd3hHNXgrOEU5YVpT?=
 =?utf-8?B?TEtGUWZaUWlKeEdWaDIxa3pYWjZlbDhDVWdTckVXQXFoOHpBcSs1RWs4NnBT?=
 =?utf-8?B?V1lvL01vdHVHYVJ5TzBXa1hoZzhwZFFsTDRPRDlDaEduMFJJVmFlQ2lOYldl?=
 =?utf-8?B?cDlTb2ZFVG9ZL0R0d3ZSMzFoanhleWxEQWhpOHRQSHRZbFlnOXdLR2R2YkVM?=
 =?utf-8?B?aFNKb011cml2SHlQc2luSmQrb3A5MnVXRDk0Z3Z1REVneU9tcXBxRWtqMHFw?=
 =?utf-8?B?UXdKcktma3RURTJMZXBRWjNWZS9kUG5QK2tWaEQ3amJEdGhLZVdjSENKazJm?=
 =?utf-8?B?NWN4TzhuZkFxLzJWZUtCRWh6cGZPajVVZUJSMWRvRkUvTUgyWEU4eUtXVzFa?=
 =?utf-8?Q?Q2vatbE0OXtmRyMeV0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <680C8F2CB789CD4589A374553B13191A@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 209370aa-b06d-4658-2582-08db80a2da38
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2023 17:35:13.7000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3873
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDctMDnmmJ/mnJ/ml6XnmoQgMjM6MzAgKzA4MDDvvIxIdWFjYWkgQ2hlbuWGmemB
k++8mg0KPiBIb3cgdG8gcmVwcm9kdWNlPyBJZiB5b3UgdXNlIFVFRkkgZmlybXdhcmUsIHRoaXMg
aXMgaGFuZGxlZCBpbg0KPiBkcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaS1zdHViLmM7
IGlmIHlvdSB1c2Ugbm9uLVVFRkkgZmlybXdhcmUsDQo+IHRoaXMgaXMgaGFuZGxlZCBpbiBkcml2
ZXJzL29mL2ZkdC5jLg0KDQpJbiBmYWN0IGl0ICdzIG5vdCBjb21tYW5kIGxpbmUgcmV0cmlldmVk
IGZyb20gZWZpIG9yIGZkdCwgYnV0IHRoZSBidWlsdC1pbg0KY29tbWFuZCBsaW5lIHRvIGJlIGNv
bmNlcm5lZC4gQ09ORklHX0NNRExJTkUgd2FzIG5ldmVyIGJlZW4gdG91Y2hlZCBkdXJpbmcNCmJv
b3Qgb24gbG9vbmdhcmNoLCB1bmxlc3MgQ09ORklHX0NNRExJTkVfRk9SQ0UgaXMgc2V0IGJlY2F1
c2UgdGhlcmUgaXMgY29kZQ0KaGFuZGxpbmcgdGhpcy4gVGhlcmUgc2hvdWxkIGJlIGNvZGUgaGFu
ZGxpbmcgQ09ORklHX0NNRExJTkVfRk9SQ0UgYW5kDQpDT05GSUdfQ01ETElORV9FWFRFTkQgYXMg
d2VsbCBidXQgaXMgYWJzZW50IGJ5IG5vdy4NCg==
