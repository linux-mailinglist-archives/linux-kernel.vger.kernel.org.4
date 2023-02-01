Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E668646D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjBAKhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjBAKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:37:38 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2056.outbound.protection.outlook.com [40.107.105.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3BB5A810
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxqtDqKn4AocwQAc7+CP+zWrL+uvXJXzl8m3xzPw/cFMzK8YKoQdE9l5fMMWRGPTwAgITx1oXHH81CjfTMYsLHXRLGTjM59r2nVArPBc/zWGavI+siPWTX+ZC+NZ+Zg7RRzbLg82AJII9EGgbn4spOzu3rrkpLbAWLZ7kApbk+9G5xEIk0NRwf70i0lcfEeRTIVGKr/mCne1BIeXaXu/desUMQJ4ve/M3m/ZxKKmFnlRqvZXmFf05mF4PIzr0SyhjSayoS0x58+3Q/eafZiabv+BgemYBRX1IuY56i9xI9EDGcJxWzQi8DYuKzyqMne3EIlOZ8vYpeQouE/jhMIOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vHvH0NT2N9zZAOo2IM8NlTMl6g9qZXg99Y/LNpuMZc=;
 b=I8YuXJNb3GBTLscthHW2k+TjDLX9PErDVGys/XN4/KgP4eShUkCcPHLhsqVhiPnrgzX3AKWu93EVlPEGpxDtLf4sWgBHOKBqJoFWeS4VxpG77lZOswQHuZjRkIfogYZrY8FuMsp8x1sifaNmzH0HThYCeAW+28FnwTzDLQ1MRyzvXW91WoP+OYnglqo8ai1nS3QYSbqGVoLN+PEqqW44KBtiNpf8PCUZViSDRGoTxMV9hbGCjfBR8YwuuxL3hdw2+9TXMYMRdPcm3vqrIU6bQrvS1VnVdZTlRBKE2P31WwXV3LdR0i3RbdQw0zKuuhylhPU+yiGdfRkC5rv7PD9LdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vHvH0NT2N9zZAOo2IM8NlTMl6g9qZXg99Y/LNpuMZc=;
 b=N4cWL50hQlr+28ZgppRWyh89AQ31cm31gfCzsEusDMlCnVx9JkoqQ284moXcsIbWI4A5najsfjI6aeTyalBOZJM4oehcKJR14neAj4qxmQYGVxsSqgJfKxRyFNnZVaM4Cbs83Jh/KTu8o+1nn3u8h4x/YVCJMIWwfhuQEaOJwUh1SOCHM0umf+A6+5IuYD40+bYY4mzSot3deyCKuUFa00BMNhFgq2SHQmSjhX6tKMho3J3mTAXzS13tzKRGb/bjdLzlN4jV6x1dkcsXUi1fmvNFIA0rhaCJbJo1waMaCrUDxjVYP6A6H+CD7dH0Z81VN0KWKY1GzyRsLxIeZmuTMA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1757.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 10:37:19 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%5]) with mapi id 15.20.6064.024; Wed, 1 Feb 2023
 10:37:19 +0000
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
Subject: Re: [PATCH v3] mm/vmalloc: replace BUG_ON to a simple if statement
Thread-Topic: [PATCH v3] mm/vmalloc: replace BUG_ON to a simple if statement
Thread-Index: AQHZNiWi8RKV+aZs9kGnscBRX8CPUK655gaA
Date:   Wed, 1 Feb 2023 10:37:19 +0000
Message-ID: <9f507a28-bbe3-7ebd-6e32-b5dc046c310d@csgroup.eu>
References: <20230201101152.GA5535@min-iamroot>
In-Reply-To: <20230201101152.GA5535@min-iamroot>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1757:EE_
x-ms-office365-filtering-correlation-id: 09a01338-214b-483e-1a90-08db04404bc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D+gR5ZMuEQGZEXj41TQee3hDaobzaul/3cK57ancgYLnHMORmFY5Ps7JgNyLuonQdVvnkXJgalDX5ySMXMi6gX9KTbUsInO34VMu7gLKL9HY5aekPulwEtIgSmPv+w4Sq+qk67NVWAqkWOmo2mM93AkMpFkQbPMo2+JiWtMikZCxKTagTGx7hsLEgpCeoeudDU5Oc4sBV087lTHYHQbOxHigVQRJolocLctsgVs3A3ppHdu+AqFLhTfxUF1YPK49S9SPQ5VyPbVbG96m0WPsMvOhQY8aXgqDTDtHH1j62y6+ukEM0iVWMiKelpVDn+EuZJrpULInxZHuPFs3eEwWDy+9734EQuBnyv9n53doxpYCmqZcKZZkp79++tAo5cdusDXxr7+KgZAp8sxMtXkmiKEMm+DFA4Giv76UiS6k+4G+/vR4tmoigKqmugdFUhTTGmx2CGn16+3PpZeYexZBneajuTQJEFOyYJM4b/upMjAltZu2Zmgm5fUF1XxJhsfF81C9gGJuhgBZigXHxkVE09dQxdlDkIZ/eSpCgPke7ebJusAT/iZbtPivIoUk4JQBkrhlcERWVFJReBoeqPTZnzpGPRCdNkBJ0f7hgs6Ll7L/YhhLAijUnltFpqxAS/5v1j8U4xmwjhbhkKKpIeJbqX5+rorospHmUAIJYTRsmMebkxGUqAK+u9+spnMaBZREOuHw4dCIB4r8NwIlGkUO3ErQSb2ZEu3XoBjIP/hGRPCbTt9WVuxX+RXoF2Scxo+ftDB282G91UNmTxL959WjPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199018)(8936002)(41300700001)(8676002)(66946007)(66556008)(478600001)(71200400001)(31696002)(6486002)(86362001)(66446008)(64756008)(66476007)(76116006)(91956017)(4326008)(31686004)(316002)(7416002)(36756003)(54906003)(6506007)(110136005)(66574015)(44832011)(966005)(5660300002)(2906002)(38070700005)(6512007)(26005)(38100700002)(2616005)(122000001)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnBOK05iQUgrbEZYQVJ4eTdJRURPUnMzTVRkSWZacmRzb292OGFPS2YwS0Vy?=
 =?utf-8?B?ZlBBem1IYnV5N1VoaGl6OTRucm01MEhwWnpqZjROWTdJenZ2V0NENzduLzMz?=
 =?utf-8?B?RHBxSmVWbHpDckZGREtlZk5yMzBZWWtwTFBQU3NNYUNjVjhHbnJ0VzFqb2l5?=
 =?utf-8?B?SG1lbVVvRXpDZCtIUVgrL1U1bTcxdFJsT2RWWVdJejhkLzBZc1hjZkNlT0pj?=
 =?utf-8?B?dmlIWFJvOHYzWGZ4alp3Y2pLWWovK1V3cE5vVEhlQVQ0SFkwWnRBd1BpeEFv?=
 =?utf-8?B?TG9IRU8wTE9KN1oxMUhSREt5QzZCYk1TT1J3ZXpSQWY4R3h6QlpiNUlIVk11?=
 =?utf-8?B?U2FxS0FNbTRzbjVLL1luQXBLV2h5cWtXSXhMK1V3QTRkU3pjQ3FXY1diaGt4?=
 =?utf-8?B?V2ZQcTBrSVRnd2hTNTFBbWtUUUZQeVRmM1lJUlJHOS85a2RCdGhkc3BNbXpK?=
 =?utf-8?B?YVZrOHk2Y0czaHZPSHFGRStLVm4xeFVjTit1cTJSazg1UjVFaHlBUkFBcEVS?=
 =?utf-8?B?bmNHMXpNemVFdTc4bWlWeXRSaGR1S1g1VXExdGVZQjdzeSs0RjFZaGtoTFhF?=
 =?utf-8?B?U09HSGozdzJWWS9NNHVXc1hMSjcyRTg0QkFodGtHakhoN3FCZ05vQ3g3TjFi?=
 =?utf-8?B?bzhlbElhaEhYcnRRMnNaaTFhU2NtUnFHc2FwYkEvalRxZExyVkNkNEd5bk8w?=
 =?utf-8?B?T1VRdjdxRUVBczRHcGNreDQ3eEdiM1lyeDU3bHJiLyt4cVVXZjZET2xwbGlk?=
 =?utf-8?B?MGh6dms1VzRUTG5OVkoyOFhOdUg1dHVVazJMRDFnc01vcWpGRGJFRjNtSlBV?=
 =?utf-8?B?UTdVbFFGSURPc2RqYnRVb3p4S1hJdVl4TVFsMHRqNUdzRkVlaWN2MmJPT0c3?=
 =?utf-8?B?MlQydHA4M3B0TXF6eXA1aXNxQkZrRTc0anRUV2x1TVo3Vk13ZHFpSnM2OGVO?=
 =?utf-8?B?d1hLWm9JTVVBbDFaaVJDamtmTlhLdDVsVzJ6c1VlNGJuZUIxWUJFYWwyQ2Y2?=
 =?utf-8?B?RnlaK0l0SlFxanMrL0RnOXQvZEI2UVl0ZTRTU0FJU0lGRXdxQm9uYnZEckNv?=
 =?utf-8?B?Tm1EYzd5L2lSempBYjNzUUFMUlo4NmJBRDYyby9NMU1aV2J6M0tkR3ZMLzly?=
 =?utf-8?B?aVNQRE1wZ1M1Q1J5NlJUWUQzUjlHbmJ2RTVZY0NHTXB4aHQ1NzI1OHk3bXQy?=
 =?utf-8?B?VW1LV0R2QnY2VzFtYS9KNWI4RnRDRno5Rk1Odmh1VzN4cXU4SnNHWUZMOXdC?=
 =?utf-8?B?MUxLdUo3R2lYYUwzZWVsWFhSRXU2VE1QUzRuekRJVW9kaWt1QkZrMzA1ZVFp?=
 =?utf-8?B?MVJkczRhRmFmNERrUGJXZmJhOWdQbHJuOGNSMytZODNtbDNyTnorcnNIMm1t?=
 =?utf-8?B?ODNEMFhVeG9URjZ3QmNLaDZZaXBZWkI3clh1L05uem5LZitaa2czU0lUNm0z?=
 =?utf-8?B?MzVYMit5ckkrMzlZZDdCKzBSRVFOT0VkQ096bG9EbEtkTklhT0VGTXV4SExv?=
 =?utf-8?B?bGFSWDJsYTNSdWlVSzVvbElkZHhFakFuVWVrMEtCSzFWM3Z2b0FIZDlUL2dC?=
 =?utf-8?B?S1d6ZUVmVlFXWDI2enV4Q1hKMDJvLzdiN2lRcmZIZm4yQ3JnaWRFYVBwcUxJ?=
 =?utf-8?B?THZiZk5ldThiN2pZLy9jS2ExNy9ld044bmVSRWRQVDdiRGNNRE5iTi9mditl?=
 =?utf-8?B?ZTB0TCtoNnNWaUhOWUg0Ly9qR0pkekNveDFRU1VhOHhGZTQ1WFZBbVpUUFox?=
 =?utf-8?B?S3ZPSUlLMU1SR2JGN0tHalBhMEk0TXZ2UVoxbXJIN2ZaYStpMTRoK1ZoZEY4?=
 =?utf-8?B?RFhtQng3bW5DckdoMEpVVEN6SllVNUNvd2lFN2FucStDUjJoVmFMcVduQzAx?=
 =?utf-8?B?ek5jSkFmY2N1U3FaUEV0Q1ZieGsyRDVlTURaVHcwQXBNQlgvWU5acmozMzBv?=
 =?utf-8?B?NFlFNXE1L2Z4RTdqWFAzaUhoejFnRW9pTHF6b041UkFsYXd1OHd3TXhETDZC?=
 =?utf-8?B?Szd3MUs5emYvQjlCWkZ0dVZsanFybGNDZVJDQkxOT0dLTXV0Y1d1cXhCYjV2?=
 =?utf-8?B?MUdlM0hYOVlVWm5McG1LQkVFQzN6NDF2ZzUrZXNwVExTOU02K28yZVlsL05Y?=
 =?utf-8?B?SWRIR3ZrV0pqRmlZRyswNmpQbGxCbTlhQ1dWUHJhOWRSaWlySE5MYitWU3oy?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DDCAB6310A7944FBE6BB28D99073DF0@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a01338-214b-483e-1a90-08db04404bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 10:37:19.7927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXeSNPOLlmOpRZ+VlPDpqwfJn+7+ilrs1hWyP0QJa3Rge2hYjh7kcBhlT3HqzKDYlBJTF8edyspiPJXzJKzgpnbMS34cnLwCeobbBBW9HhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1757
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAxLzAyLzIwMjMgw6AgMTE6MTEsIEh5dW5taW4gTGVlIGEgw6ljcml0wqA6DQo+IFtW
b3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIGhuLm1pbi5sZWVAZ21h
aWwuY29tLiBEP2NvdXZyZXogcG91cnF1b2kgY2VjaSBlc3QgaW1wb3J0YW50ID8gaHR0cHM6Ly9h
a2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEFzIHBlciB0aGUg
Y29kaW5nIHN0YW5kYXJkcywgaW4gdGhlIGV2ZW50IG9mIGFuIGFibm9ybWFsIGNvbmRpdGlvbiB0
aGF0DQo+IHNob3VsZCBub3Qgb2NjdXIgdW5kZXIgbm9ybWFsIGNpcmN1bXN0YW5jZXMsIHRoZSBr
ZXJuZWwgc2hvdWxkIGF0dGVtcHQNCj4gcmVjb3ZlcnkgYW5kIHByb2NlZWQgd2l0aCBleGVjdXRp
b24sIHJhdGhlciB0aGFuIGhhbHRpbmcgdGhlIG1hY2hpbmUuDQo+IA0KPiBTcGVjaWZpY2FsbHks
IGluIHRoZSBhbGxvY192bWFwX2FyZWEoKSBmdW5jdGlvbiwgdXNlIGEgc2ltcGxlIGlmKCkNCj4g
aW5zdGVhZCBvZiB1c2luZyBCVUdfT04oKSBoYWx0aW5nIHRoZSBtYWNoaW5lLg0KPiANCj4gQ28t
RGV2ZWxvcGVkLWJ5OiBHd2FuLWd5ZW9uZyBNdW4gPGd3YW4tZ3llb25nLm11bkBpbnRlbC5jb20+
DQo+IENvLURldmVsb3BlZC1ieTogSmV1bmd3b28gWW9vIDxjYXNpb253b29AZ21haWwuY29tPg0K
PiBDby1EZXZlbG9wZWQtYnk6IFNhbmd5dW4gS2ltIDxzYW5neXVuLmtpbUBzbnUuYWMua3I+DQo+
IFNpZ25lZC1vZmYtYnk6IEh5dW5taW4gTGVlIDxobi5taW4ubGVlQGdtYWlsLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogR3dhbi1neWVvbmcgTXVuIDxnd2FuLWd5ZW9uZy5tdW5AaW50ZWwuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBKZXVuZ3dvbyBZb28gPGNhc2lvbndvb0BnbWFpbC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFNhbmd5dW4gS2ltIDxzYW5neXVuLmtpbUBzbnUuYWMua3I+DQo+IENjOiBI
eWVvbmdnb24gWW9vIDw0Mi5oeWV5b29AZ21haWwuY29tPg0KPiAtLS0NCj4gdjEtPnYyIDogQWRk
IGNvbW1pdCBkZXNjcmlwdGlvbg0KPiB2Mi0+djMgOiBDaGFuZ2UgV0FSTl9PTigpIHRvIGlmKCkN
Cj4gLS0tDQo+ICAgbW0vdm1hbGxvYy5jIHwgMTEgKysrKysrKystLS0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L21tL3ZtYWxsb2MuYyBiL21tL3ZtYWxsb2MuYw0KPiBpbmRleCA3NGFmYTIyMDg1NTguLjUyYTM0
NmJjMDJhMSAxMDA2NDQNCj4gLS0tIGEvbW0vdm1hbGxvYy5jDQo+ICsrKyBiL21tL3ZtYWxsb2Mu
Yw0KPiBAQCAtMTU4Nyw5ICsxNTg3LDE0IEBAIHN0YXRpYyBzdHJ1Y3Qgdm1hcF9hcmVhICphbGxv
Y192bWFwX2FyZWEodW5zaWduZWQgbG9uZyBzaXplLA0KPiAgICAgICAgICBpbnQgcHVyZ2VkID0g
MDsNCj4gICAgICAgICAgaW50IHJldDsNCj4gDQo+IC0gICAgICAgQlVHX09OKCFzaXplKTsNCj4g
LSAgICAgICBCVUdfT04ob2Zmc2V0X2luX3BhZ2Uoc2l6ZSkpOw0KPiAtICAgICAgIEJVR19PTigh
aXNfcG93ZXJfb2ZfMihhbGlnbikpOw0KPiArICAgICAgIGlmICh1bmxpa2VseSghc2l6ZSkpDQo+
ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4gKw0KPiArICAgICAg
IGlmICh1bmxpa2VseShvZmZzZXRfaW5fcGFnZShzaXplKSkpDQo+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4gKw0KPiArICAgICAgIGlmICh1bmxpa2VseSghaXNf
cG93ZXJfb2ZfMihhbGlnbikpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVJ
TlZBTCk7DQoNCkkgd291bGQgaGF2ZSB3cml0dGVuIGl0IG1vcmUgY29tcGFjdC4gV2hlbiB1c2lu
ZyBCVUdfT04gb3IgV0FSTl9PTiBpdCBpcyANCmludGVyZXN0aW5nIHRvIGhhdmUgdGhyZWUgc2Vw
YXJhdGUgbGluZXMgYmVjYXVzZSB5b3UgZ2V0IHRoZSBsaW5lIG51bWJlciANCmluIHRoZSBPb3Bz
IG1lc3NhZ2UsIGJ1dCBoZXJlIHlvdSBhcmUganVzdCByZXR1cm5pbmcgdGhlIGV4YWN0IHNhbWUg
DQplcnJvciBjb2RlLCBzbyBpdCBjb3VsZCBiZToNCg0KCWlmICh1bmxpa2VseSghc2l6ZSB8fCBv
ZmZzZXRfaW5fcGFnZShzaXplKSB8fCAhaXNfcG93ZXJfb2ZfMihhbGlnbikpKQ0KCQlyZXR1cm4g
RVJSX1BUUigtRUlOVkFMKTsNCg0KPiANCj4gICAgICAgICAgaWYgKHVubGlrZWx5KCF2bWFwX2lu
aXRpYWxpemVkKSkNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRUJVU1kpOw0K
PiAtLQ0KPiAyLjI1LjENCj4gDQo+IA0K
