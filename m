Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4C55B550C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiILHK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiILHK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:10:57 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01lp0107.outbound.protection.outlook.com [104.47.25.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375518396
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD3+cw3c33vlUkS2WaO14z2PXgWMq5GQgrCax2Ge89TFOQ3fWd1F67RyJ040CzmLBJfAc0YdtvkSdCx5AakgPGxQLngLETQWq9Q68Yz3/M70Rc+CPUchor5Sc3VVEaTzOyH37AEiq4RCDdqfHuoCM7iWH11PDRQwbeWg6lvJTR3nlUMNUcQFBN9Ddl90st4gxsQuUASpTtKazNHxq9fcDswm/nYMMShtf5uUiBZh+5BO9eNXj046AZc1yttqMmMQlkioc2c0nzdDpr9VqUHiB5kBbdVkEylX5yWIZjEig3rJj8f+krZBe8gd34MVR8i8TopAUnoyxupo27CeJmKvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoH5a9C3dbKVUmoY4XDZrIHIpkwzXS6E3rZB5qnw3dc=;
 b=hdBPuQwi9vBzafWwygZgXhAvBIb8Gql/ZjqF7W4wHkb7hoLjEQC6d5jARf9+TwnlT3DzLLFr1cMq1WTejKz0arzDRKzlY6S74U9QIUO+j2CuAbZpibWjcVYtXk1X6J51AQtgyJbZxMk3odOmzjhXQCuZKeUe+DnGVosjuvHwX69Lo5oDtpKJiWZB3+JEZJMENz0Y6nNa5Gttghsp3CNGFhCrJjRzlwdbE3fgckc4k9j0en9nf56dHDSZVa90h98fPsMHFgSpTooZlHCbQVnCtXAW7BBwkLynzK2A2QrVNQc03tYxMTVWd4ivCgA/uh2CjMCP1Ra3++D7Swa8Y5oDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoH5a9C3dbKVUmoY4XDZrIHIpkwzXS6E3rZB5qnw3dc=;
 b=TEhZsMyRWTlBVbE5wqbwZgLlDBXEU7l6b/9HaNalAsS8sePHr0qMzhgGLe5PsxMrvv4U8ZWc8EEke8Mvk/Saw6bU0lJz1v2KbZaTKw6yYbBJoHMOq0ihBJ0iXEZ6XxjSFJ43d0MliY6EOJsneEqO1z2QBEWWY+KPsX+ye8ydRuAmye1letfFe0x6Xe16XzNptJwdXtcRvsMeM1XAmy7nCd6QDcHuCQoU+q060RsTSARvENrX1Q+PKr1lFHnWpqymbRBjkmASAMa+3apH12StoXQnMegWDntnRpCPqES9A94/CHXXt4N4m54ZqoJxYxDoPZa0VjzIHynGaWO57RZtoQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2296.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 07:10:51 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%5]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 07:10:51 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 02/11] mm: ioremap: fixup the physical address and page
 prot
Thread-Topic: [PATCH v2 02/11] mm: ioremap: fixup the physical address and
 page prot
Thread-Index: AQHYtCx+rO/zUftR00aLhjCOF9ttT626eSKAgAE7M4CAAEcjAIAAdQ8AgABtGoCAB1d7gIAXCOgAgABHN4A=
Date:   Mon, 12 Sep 2022 07:10:51 +0000
Message-ID: <6ffdbdbb-0a21-25a6-13f6-4c4be3b87e50@csgroup.eu>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
 <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
 <YwQrC3X3PHa0pNDy@MiWiFi-R3L-srv>
 <54b7afcc-056d-7f33-6858-d451a3222c70@csgroup.eu>
 <YwTI6jAjY68QK5h6@MiWiFi-R3L-srv>
 <8df89136-a7f2-9b66-d522-a4fb9860bf22@csgroup.eu>
 <YwtND/L8xD+ViN3r@MiWiFi-R3L-srv> <Yx6fvuXakMnCwinB@MiWiFi-R3L-srv>
In-Reply-To: <Yx6fvuXakMnCwinB@MiWiFi-R3L-srv>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2296:EE_
x-ms-office365-filtering-correlation-id: 2b4467b9-60e2-4c6f-a0ee-08da948ded36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2HFhMMt9oheeNyn2QDMMuCqvTaHNOYp4q1YMtXeHlnIFZLhlc2fXnNm4TBAL24KMFufGFGVJOiZ8skJaNfwTqPWpfW17QaPQv7L9HpJx7FJlGN0ganGnT3SUDb4gg0Nso7nf26ZXr62eYaX0LLWvwsSzLCZ7E54IFBmn0rd/8XCG4oCkLp1JKbNHc6satLnPvBpjU/zhYwZOPDcWyvcgQSlD/JHoWTbAbcUqEW1/Ke+n2hZNrzX7Fk85dmyZnGZBLBVFQUY86AxR5WhANuc9i7sJAQPQaR69TA1gaKUGwvvDfHgcG9BNZfKIcmO/m83SudHjs6zR/YkORgyZSBRPyoj4+SPDFr7oLoLWUviaiKhbBzKE+oBwKLtEkh+QoNDO7tN29EYQgfZXsKZnEYqtBbbcBviSrSp3fsVYHy6tALa9NkIIznR+FZjoHl+zRD9VMIcy7dLlaHxAhCXvNtCDpLqHEogA2Zu4LCHzpjaB2u0xWW133vwUKUTSBuRPso/F3CEpmRpP6CkNmK7fGRjq5dNDP5j/LjUBE8LMrGM9Z86aFSBRvUgTLsPRc27e46gaGzqcr7FG7LeTVfwe6Iqd5xI5qAcv6Vz+oUBMVaOVCmIJtjCM0IKaboNhOgAstf83W5OppvG4twMnk75QaML4pTERa7PxGH405Zh536XyHIOOzVvNZw9e7efQlYenJzGs2W6z2zcVdhx7uGsXOsEPPDlQOyrC0OsEIJ8yJXafMYgqT70UO5ZDvqMwPZP6AtrE26U8g4u863bof0wE0lHDN+fBQtv7wDJXPqfKP0UqhqqVSQuVFntRLT5ARH5OgQnmK7tVfLntGiM1pFgkcV2BgxqwtCzuy8O7Z1fMMGOGFBs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(366004)(136003)(346002)(396003)(6506007)(2906002)(44832011)(6512007)(26005)(2616005)(66556008)(66476007)(66446008)(71200400001)(64756008)(6486002)(5660300002)(8676002)(54906003)(91956017)(6916009)(76116006)(36756003)(66946007)(41300700001)(316002)(966005)(122000001)(38100700002)(8936002)(478600001)(4326008)(38070700005)(186003)(31696002)(66574015)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1VqTmVIcDIwVVczQlJ1eXJvNmpIS3VqZmZjQUU3aU9mdnFkZndGNVJ0OGs3?=
 =?utf-8?B?MWEzcW0yckhuU2ROdHd3NGM3Y1N0N2pRTkYrM0JWTjVhd0lPMGRNaGVsM3hC?=
 =?utf-8?B?Z004UnBoaFVRaVMyQlVFOW5MWE9ONjdEOXRNbTdreVRJaXEvTGdFblpqeXAr?=
 =?utf-8?B?NVVJK2hjQjBvZVJlMWMwZHhpMlhSVmF6cDhCemM2MFRQa2d0Vjd6ZEo0Yzdr?=
 =?utf-8?B?d3RxbWp1ZHdEQlhnV29aRDI0aloyQ0g5clFGMHZaRUdqdWFzQkpaUlhTUkRv?=
 =?utf-8?B?ZW5tSk1ZY2IvcnltOG5CZXNWdXBrejhrczdDNks2RkphcDFtOFJUODVEWW0w?=
 =?utf-8?B?UmYvZzRzeEYxcFhVd1RWNG5vRElPTTQvbDQwM1ovTTVJZlpLMTFWNkQ2L1B6?=
 =?utf-8?B?QmMzbkVPZ2VQVUI1YUhST1MydDAxRzJuaGExN1FLM0dQSzlzc3U0eGtTUHB3?=
 =?utf-8?B?dzh5ZjdMSWw5OWZFcHRUL2wxb0NHa0k3NktZZHdoRGMwbVQ2QXREUGo1RmFi?=
 =?utf-8?B?M09pOGNMMGtVMjI5UFUxVzdTUzRMS1Z2QTdBdHFDWnM1M2lRUnlXQVVMeWZH?=
 =?utf-8?B?aGRLK1FDSm01MFcrRXBQMHViZUNHMkFPejNJcGJUbkt4eTcvdmxON0ZGVEtv?=
 =?utf-8?B?UjREaVB2Rmk3VUR4eEc2ZmxuTVhDdzFCc2dZSUlkTXc3MDVoeC9jeG1PL1ZS?=
 =?utf-8?B?VUFNRWhVU0tzN1NWZFNPZWt0Ny9GQ252ZXBVY3c5UHFQTlBtaVhCMS8vTkVq?=
 =?utf-8?B?YVJOOTU2ZGw4ZGFQWS9TTlRoMEtUZXJtS1FQZS90SDk0SHc5V1pLV3VOVlBN?=
 =?utf-8?B?akIwbzRiMTFlSzV1Q0phcXZzaEs1MlB5VHE1c2crcnhFeUtEZGkxTktSTHZ4?=
 =?utf-8?B?a2R4SFMwS3Q3TVRSNlVwTkhReWNMZGdUVWQ4cC9Ga0VkM0Exd1dwNktDZGNa?=
 =?utf-8?B?dzl1RUNTVnFOMlc0aDh6OWtBZDY4UWRGcHV6VVV5VmNsVnBpdVA4OHNRYmxV?=
 =?utf-8?B?bmo2UEp5dnVGNkd5ZEY2dXVkSGV0L01Xdy9iRUZDUllXUGlGaDFad2EzQk5j?=
 =?utf-8?B?Wll2bFpsZ1cyUGRRU3RCT3lBbjFkeDgyUFJEUm5nT3cxQWladlVKcWlVVW1h?=
 =?utf-8?B?SEpDRUNaMGl5Zm9iTFVFRURCVnRyQThYTVM2WU9oeTVYZ0FPSGZDMnNCN2lN?=
 =?utf-8?B?aHRwcFNsTlViTDIxbnZ1N0dMaDQ2SmFVQVhCU1hFRDBGN0hDUkY0REFxMTJX?=
 =?utf-8?B?VDhHSk95UFliaXEzZGJVVXNhYzhyMHVSZ1FkUFQ0T2hsZDg2clZrSTZ4a1lq?=
 =?utf-8?B?ZW00V2M4SUZYcytqcjE1ZVYyejNuQjE0ZHRLV1V2Y0l3cmRDOGpBQXViOE92?=
 =?utf-8?B?dzBUdlZZWHdMUUYwRVNPOXhHTEh2a2ZSbi9sazZaeFhWZFNsUGtjVmgwNTVy?=
 =?utf-8?B?bmJMZUVhanpKd3JxejVWSFQ2ckNTclRzYlcvemNzVWNkMlo3ekF6YjBaODFT?=
 =?utf-8?B?RzM0K1p2MmpSU0dzQUdZMmUvOWdLQ3h3am92UDJ2WGRBcmlKaksyZzRRNWpS?=
 =?utf-8?B?QXNQZUFucFRtckI2dmNXMlJsa2lSOFZWcVRTVTBUZ0NwOHBBaEtpOHppMUds?=
 =?utf-8?B?cjdqTFV5SXRJczZobE9Ca2UxRFdSZ3B2dWtoYnc0Mk1wM3RGN2czRytCaTUr?=
 =?utf-8?B?bnNuZkFtd3NZdStETGlzcmgrUHdFYUJrQXRoK05pNmIxbXg2RTFhcVZ4Tlly?=
 =?utf-8?B?TTN3MFZXZ0ZrbVVxSFF0QUZVUzI4Q3dVczZHWUFRb3BxU0M3RUlWL2NzaWhI?=
 =?utf-8?B?UmJZMTEzbC9SQnYycHRKbHRJUTJSRXhudEpCaGE3a1R4TkdONTNRakh6RTNN?=
 =?utf-8?B?bUY4R0J6aGI4ckJkc1BGSUlQNHlzaGJCVyt4SE9SVUprRGV2VzZ1MjdTU0Nx?=
 =?utf-8?B?bmdsc3hsREx0T0d4K3RVQTFuNnFFRHd0N3d3dGszZ05QSC9vem9CbW9iNmNQ?=
 =?utf-8?B?UFRwdDdoQU40d1pJcjZFSXl3V1Jhd3BvZVIyeXdDdytZNnIyK2hMSWRnTFBV?=
 =?utf-8?B?OWJpeHd4M1I1bkJBc0Nnam9pNzZlZjZ2V0RkS0lTalRzR0k0bHI5SkNuNUJi?=
 =?utf-8?B?bjN3Tk13UlBKT3VaK2pJSGdOVGNCNDlwaG05ZHZhZFU4TDNMNkVKYlNiSmh0?=
 =?utf-8?Q?Scvp/6GR4UmazpEuCWK/92I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E114F7B427B08E41ADAA7245391187BF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4467b9-60e2-4c6f-a0ee-08da948ded36
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 07:10:51.6957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYCnJM4CrrmjuLGfQPxfT8bjxB9DYskJivPvwF1gZfb0CSJlV6MsGweWmyQJKzAUdWSLXIaeTj6Jd5HaYiCF0KgHs+xBlDK4BAOCLxIBGMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2296
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFvcXVhbiwNCg0KTGUgMTIvMDkvMjAyMiDDoCAwNDo1NSwgQmFvcXVhbiBIZSBhIMOpY3Jp
dMKgOg0KPiBIaSBDaHJpc3RvcGhlLA0KPiANCj4gT24gMDgvMjgvMjIgYXQgMDc6MTBwbSwgQmFv
cXVhbiBIZSB3cm90ZToNCj4+IE9uIDA4LzIzLzIyIGF0IDA3OjAzcG0sIENocmlzdG9waGUgTGVy
b3kgd3JvdGU6DQo+IC4uLi4uLg0KPj4+Pj4+PiBJcyBpdCByZWFsbHkgdGhlIGJlc3QgYXBwcm9h
Y2ggPyBXb3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gaGF2ZSBoZWxwZXJzDQo+Pj4+Pj4+IHRvIGRv
IHRoYXQsIHRob3NlIGhlbHBlcnMgYmVpbmcgY2FsbGVkIGJ5IHRoZSBpb3JlbWFwX3Byb3QoKSwg
aW5zdGVhZCBvZg0KPj4+Pj4+PiBkb2luZyBpdCBpbnNpZGUgdGhlIGFyY2hfaW9yZW1hcCgpIGZ1
bmN0aW9uID8NCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgaXMgc3VnZ2VzdGVkIHRvbyBieSBBbGV4YW5k
ZXIgZHVyaW5nIGhpcyB2MSByZXZpZXdpbmcuIEkgdHJpZWQsIGJ1dA0KPj4+Pj4+IGZlZWwgdGhl
IGN1cnJlbnQgd2F5IHRha2VuIGluIHRoaXMgcGF0Y2hzZXQgaXMgYmV0dGVyLiBCZWNhdXNlIG5v
dCBhbGwNCj4+Pj4+PiBhcmNoaXRlY3V0cmVzIG5lZWQgdGhlIGFkZHJlc3MgZml4IHVwLCBvbmx5
IHBhcmlzYywgYW5kIG9ubHkgZmV3IG5lZWQNCj4+Pj4+PiBhZGp1c3QgdGhlICdwcm90Jy4gSW50
cm9kdWNpbmcgb3RoZXIgaGVscGVycyBzZWVtcyB0b28gbXVjaCwgdGhhdCBvbmx5DQo+Pj4+Pj4g
aW5jcmVhc2VzIHRoZSBjb21wbGV4aXR5IG9mIG9mIGlvcmVtYXAoKSBhbmQgdGhlIGdlbmVyaWMg
R0VORVJJQ19JT1JFTUFQDQo+Pj4+Pj4gbWV0aG9kIGZvciBwZW9wbGUgdG8gdW5kZXJzdGFuZCBh
bmQgdGFrZS4NCj4+Pj4+DQo+Pj4+PiBJIGNhbid0IHVuZGVyc3RhbmQuIFdoeSBpcyBpdCBkaWZm
aWN1bHQgdG8gZG8gc29tZXRoaW5nIGxpa2U6DQo+Pj4+Pg0KPj4+Pj4gI2lmbmRlZiBpb3JlbWFw
X2FkanVzdF9wcm90DQo+Pj4+PiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgaW9yZW1hcF9h
ZGp1c3RfcHJvdCh1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPj4+Pj4gew0KPj4+Pj4gCXJldHVybiBm
bGFnczsNCj4+Pj4+IH0NCj4+Pj4+ICNlbmRpZg0KPj4+Pj4NCj4+Pj4+IFRoZW4gZm9yIGFyYyB5
b3UgZG8NCj4+Pj4+DQo+Pj4+PiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgaW9yZW1hcF9h
ZGp1c3RfcHJvdCh1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPj4+Pj4gew0KPj4+Pj4gCXJldHVybiBw
Z3Byb3RfdmFsKHBncHJvdF9ub25jYWNoZWQoX19wZ3Byb3QoZmxhZ3MpKSk7DQo+Pj4+PiB9DQo+
Pj4+PiAjZGVmaW5lIGlvcmVtYXBfYWRqdXN0X3Byb3QgaW9yZW1hcF9hZGp1c3RfcHJvdA0KPj4+
Pg0KPj4+PiBNeSB0aGlua2luZyBpcyB3ZSBoYXZlIGZvdXIgdGhpbmdzIHRvIGRvIGluIHRoZSBh
ZGRlZCBob29rZXJzLg0KPj4+PiAxKSBjaGVjayBpZiB3ZSBzaG91bGQgZG8gaW9yZW1hcCBvbiBB
UkNIZXMuIElmIG5vdCwgcmV0dXJuIE5VTEwgZnJvbQ0KPj4+PiBpb3JlbWFwX3Byb3QoKTsNCj4+
Pj4gMikgaGFuZGxpbmcgdGhlIG1hcHBpbmcgaW8gYWRkcmVzcyBzcGVjaWZpY2FsbHkgb24gQVJD
SGVzLCBlLmcgYXJjLA0KPj4+PiBpYTY0LCBzMzkwOw0KPj4+PiAzKSB0aGUgb3JpZ2luYWwgcGh5
c2ljYWwgYWRkcmVzcyBwYXNzZWQgaW50byBpb3JlbWFwX3Byb3QoKSBuZWVkIGJlDQo+Pj4+IGZp
eGVkIHVwLCBlLmcgYXJjOw0KPj4+PiA0KSB0aGUgJ3Byb3QnIHBhc3NlZCBpbnRvIGlvcmVtYXBf
cHJvdCgpIG5lZWQgYmUgYWRqdXN0ZWQsIGUuZyBvbiBhcmMNCj4+Pj4gYW5kIHh0ZW5zYS4NCj4+
Pj4NCj4+Pj4gV2l0aCBLZWZlbmcncyBwYXRjaGVzLCB0aGUgY2FzZSAxKSBpcyBoYW5kbGVkIHdp
dGggaW50cm9kdWNlZA0KPj4+PiBpb3JlbWFwX2FsbG93ZWQoKS9pb3VubWFwX2FsbG93ZWQoKS4g
SW4gdGhpcyBwYXRjaHNldCwgd2hhdCBJIGRvIGlzDQo+Pj4+IHJlbmFtZSB0aGUgaG9va3MgYXMg
YXJjaF9pb3JlbWFwKCkgYW5kIGFyY2hfaW91bm1hcCgpLCB0aGVuIHB1dCBjYXNlIDEpLA0KPj4+
PiAyKSwgMyksIDQpIGhhbmRsaW5nIGludG8gYXJjaF9pb3JlbWFwKCkuIEFkZGluZyBoZWxwZXJz
IHRvIGNvdmVyIGVhY2gNCj4+Pj4gY2FzZSBpcyBub3QgZGlmZmljdWx0IGZyb20gbXkgc2lkZS4g
SSB3b3JyeSB0aGF0IGFzIHRpbWUgZ29lcyBieSwgdGhvc2UNCj4+Pj4gc2V2ZXJhbCBob29rcyBt
eSBjYXVzZSBpc3N1ZSwgZS5nIGlmIGEgbmV3IGFkanVzdG1lbnQgbmVlZCBiZSBkb25lLA0KPj4+
PiBzaG91bGQgd2UgaW50cm9kdWNlIGEgbmV3IGhlbHBlciBvciBtYWtlIGRvIHdpdGggdGhlIGV4
aXN0ZWQgaG9vazsgaG93DQo+Pj4+DQo+Pj4+IFdoZW4gSSBpbnZlc3RpZ2F0ZWQgdGhpcywgb25l
IGFyY2hfaW9yZW1hcCgpIGxvb2tzIG5vdCBjb21wbGljYXRlZA0KPj4+PiBzaW5jZSBub3QgYWxs
IEFSQ0hlcyBuZWVkIGNvdmVyIGFsbCBhYm92ZSA0IGNhc2VzLiBUaGF0J3Mgd2h5IEkgZmluYWxs
eQ0KPj4+PiBjaG9vc2Ugb25lIGhvb2suIEkgYW0gb3BlbiB0byBuZXcgaWRlYSwgcGxlYXNlIGxl
dCBtZSBrbm93IGlmIHdlIHNob3VsZA0KPj4+PiBjaGFuZ2UgaXQgdG8gaW50cm9kdWNlIHNldmVy
YWwgZGlmZmVyZW50IGhlbHBlcnMuDQo+Pj4+DQo+Pj4NCj4+PiBBIG5ldyBpZGVhIHRoYXQgd291
bGQgaGF2ZSBteSBwcmVmZXJlbmNlIHdvdWxkIGJlIHRvIGRvIGp1c3QgbGlrZSB3ZSBkaWQNCj4+
PiB3aXRoIGFyY2hfZ2V0X3VubWFwcGVkX2FyZWEoKS4gTG9vayBhdA0KPj4+IGh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjAtcmMxL3NvdXJjZS9hcmNoL3Bvd2VycGMvbW0vYm9v
azNzNjQvc2xpY2UuYyNMNjM4DQo+Pj4gYW5kIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xp
bnV4L3Y2LjAtcmMxL3NvdXJjZS9tbS9tbWFwLmMjTDIxMzENCj4+Pg0KPj4+IEluc3RlYWQgb2Yg
aGF2aW5nIHRoZSBnZW5lcmljIHRoYXQgY2FsbHMgdGhlIGFyY2ggc3BlY2lmaWMsIG1ha2UgaXQg
dGhlDQo+Pj4gb3RoZXIgd2F5IHJvdW5kLCBoYXZlIHRoZSBhcmNoIHNwZWNpZmljIGNhbGwgdGhl
IGdlbmVyaWMgYWZ0ZXIgZG9pbmcgaXRzDQo+Pj4gc3BlY2lhbHRpZXMuDQo+Pg0KPj4gVGhpcyBz
b3VuZHMgZ29vZC4gSSBtYWRlIGEgZHJhZnQgcGF0Y2ggdG8gY2hhbmdlIGNvZGUgaW4gZ2VuZXJp
YyBjb2RlDQo+PiBwYXJ0LCBqdXN0IHNob3dpbmcgd2hhdCBpdCBsb29rcyBsaWtlLg0KPj4NCj4+
IEJvdGggYXJjaF9pb3JlbWFwKCkgd2F5IGFuZCB0aGUgYXJjaCBzZXBjaWZpYyBjYWxsIHRoZSBn
ZW5lcmljIHdheSBsb29rDQo+PiBnb29kIHRvIG1lLiBKdXN0IGl0IHdpbGwgdGFrZSBsZXNzIGVm
Zm9ydCBmb3IgbWUgdG8gY29udGludWUgdGhlDQo+PiBhcmNoX2lvcmVtYXAoKSB3YXkuIEkgd291
bGQgbGlrZSB0byBoZWFyIENocmlzdG9waCdzIG9waW5pb24gc2luY2UgaGUNCj4+IGludHJvZHVj
ZWQgdGhlIEdFTkVSSUNfSU9SRU1BUCBtZXRob2QgYW5kIHN1Z2dlc3RlZCB0aGUgZWFybGllcg0K
Pj4gYXJjaF9pb3JlbWFwKCkgd2F5IGFuZCBjaGFuZ2UgaW4gdGhpcyBwYXRjaHNldC4NCj4gDQo+
IEkgd2lsbCBtYWtlIGFub3RoZXIgcm91bmQgY2hhbmdlIGFuZCBwb3N0LiBTaW5jZSBDaHJpc3Rv
cGggZG9lc24ndA0KPiByZXBseSwgSSB3b3VsZCBsaWtlIHRvIGNvbnRpbnVlIHdpdGggdGhlIGV4
aXN0aW5nDQo+IGFyY2hfaW9yZW1hcC9hcmNoX2lvdW5tYXAoKSBob29rcyB3YXkgaWYgeW91IGRv
bid0IGhhdmUgc3Ryb25nIG9waW5pb24NCj4gb24gdGhlIG5ldyBpZGVhIHRvIHJlaW50cm9kdWNl
IGlvcmVtYXAoKS4NCj4gDQoNCkkgc3RpbGwgZGlzbGlrZSB5b3UgYXBwcm9hY2ggd2l0aCB0aGUg
YXJjaGl0ZWN0dXJlcyBtb2RpZnlpbmcgbG9jYWwgdmFycyANCmJ5IHJlZmVyZW5jZSwgYW5kIGFz
IHlvdSBzYWlkIGVhcmxpZXIgSSdtIG5vdCB0aGUgb25seSBvbmUgOiAiVGhpcyBpcyANCnN1Z2dl
c3RlZCB0b28gYnkgQWxleGFuZGVyIGR1cmluZyBoaXMgdjEgcmV2aWV3aW5nIi4NCg0KU28gSSdk
IHJlYWxseSBwcmVmZXIgeW91IHRvIHJlY29uc2lkZXIgeW91ciBhcHByb2FjaCBhbmQgYXZvaWQg
cGFzc2lnbiANCnBvaW50ZXJzIHRvIGxvY2FsIHZhcnMgdG8gYXJjaGl0ZWN0dXJlIGhlbHBlcnMu
DQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ==
