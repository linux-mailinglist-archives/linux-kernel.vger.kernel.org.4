Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57173CFB1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjFYJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:23:14 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2050.outbound.protection.outlook.com [40.107.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360C2E52
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 02:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUcLtu7RZe4B1xJ46P7+bTDyndJrykSB1pJnngygRch8cYQb4YCUr3XBGwxkyK977EtmF/R8dSvsyu91ziy4zbfr2K6X/FrSJVd5AtcvkTqgnsDFvWiHj9qROSQh1UHmG+PeSlUhwqFQb/+YI36LTe0dcgS30G1c06BYlswAhkbiDxrBJkfNIhtHQSOS3TqBfqCGLcrWqWOBMDY6Wfgh107fIYJwJmdTbOBK0DYKVr4E0WkDUQmCTsdb0gOTrtd1MvFA9HTQY0AK2D+8ewJ6FidirBOmecEm9fCFv0q7VhopdpxQvMwzWQG2iFvfjHN+SKKSd8iWvb2QavpZvou8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzSbHgTLZBGFGSHQfcLnuaj4tPHXCvY1abu5D86mlvw=;
 b=MERJTg7ZF2t8fOaG8wrB6zr+jJvy7hwDiQEJxGaMRQZVjomjDU4Qwr9jILA1ADrD6YzNVOaDXLO4Qk92qjA0cCqpgqvdwBgvwa+UyxfTfme+MVtzbtUt/1V1I3mijMsVCv/SIxk9H/sdsDvDZsXbpGxE+/CzhdSwOXqc6dnQzw2SBpJeYd2yatQYKDFLiRM4ENf91nASYF+c1Og4cuRsSeRyH/3vEE2QTCq2K6pSHXt+jDp4I22adLonzCGf8QjG57q4X+AKd318DqoVy+EDO1eknbQykK/ttwDrLXWlXz5+7FhMYdR2HQWYipCSbypNKMCAl1eAJg4dwUk42N0XJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzSbHgTLZBGFGSHQfcLnuaj4tPHXCvY1abu5D86mlvw=;
 b=ffTEZo1vUkIdyx9iQAqjN6b35Hs/NxWAtcsjf6WyJMg5wmgNS2tx+EqIWRoO84pEiIpHVS92w2wgdKZMMcX355OX/I3rUD8EajFJOilEDVEPxZq35hU8zu7599Oe+zHXBYwHlhYwxzTZJir9DYndiuOYHIoKld3VOBMllQbhuuM=
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by TY0PR02MB5693.apcprd02.prod.outlook.com (2603:1096:400:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 09:23:07 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::2e7:47a3:69c4:9e8e]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::2e7:47a3:69c4:9e8e%3]) with mapi id 15.20.6500.020; Sun, 25 Jun 2023
 09:23:07 +0000
From:   =?utf-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>
To:     David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "gregkh@google.com" <gregkh@google.com>,
        "zhangshiming@opp.com" <zhangshiming@opp.com>,
        =?utf-8?B?6YOt5YGl?= <guojian@oppo.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tOiB2bXNjYW46IGV4cG9ydCBmdW5jOnNocmlu?=
 =?utf-8?Q?k=5Fslab?=
Thread-Topic: [PATCH] mm: vmscan: export func:shrink_slab
Thread-Index: AQHZoDPrkT68DrtoVU28xugv80V2AK+NLWcAgAXQczCACE4q4A==
Date:   Sun, 25 Jun 2023 09:23:07 +0000
Message-ID: <TYZPR02MB55950D4E176AEEB2FF8EDF6DC621A@TYZPR02MB5595.apcprd02.prod.outlook.com>
References: <20230616092112.387-1-lipeifeng@oppo.com>
 <33eabee3-f6f4-ee0c-d74b-98815a9567c4@redhat.com>
 <TYZPR02MB5595CE108D89A51973CF551AC65CA@TYZPR02MB5595.apcprd02.prod.outlook.com>
In-Reply-To: <TYZPR02MB5595CE108D89A51973CF551AC65CA@TYZPR02MB5595.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR02MB5595:EE_|TY0PR02MB5693:EE_
x-ms-office365-filtering-correlation-id: 77527ce0-6174-4cf2-2910-08db755dc960
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LHFYWAyrzQTVL4M18/FfF7t/KaeA6tn9Z7lgGJZ5M1XT6s9FslX2UB93f/00G3N11AI1jAQ6iak0hi9A+35U17zbCMlrdAcVTYb131tWh3GPsnwqnJgfQHPjv4PCU+8So+JCcQE88nIy6AgqwLkjxknl366Gppj24hC/Q9nPKN2UkUNOu625aBdRsCeqLKifprbEnlXKZy5fk20FnwlvCsen1UC1Svzssu/ULtk9esYDZM1HOwCC5G3IWx0pATpBVHgCAj1BJycByDHjtP6uxvMFtsYkUS3YNGIlGpAPkh8zmMRqhbQNBt8yyCW91WRWCZ/lo+ed4hOWI39H1KRbkd7UkBQN05owrmGcdQLzswjH6pE7eRvmgvPYmHp8RP+kY6yfiuqJf2fUNOAKcoAndfYLFe0NarCno7L4SRE6bMyFdRfxvdkWwPcpYK/vJatHjjbhQCstkdPLdKcT7MuyhxKkinuRbfFgiXvW/7zHCdPdnSvHoApUMdSL1wYg6ubrUFDnddrjZBDO70wJiwJnnsa47MAHQXUnV72JouCq7Vpasei0o1AR6M/RMzWIETevIVId313G+l5LoTXh6TCTellIW3sS1y2kz8rnzguYlNMmEyYsvBZV19jg+70rqAa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(7696005)(71200400001)(478600001)(110136005)(54906003)(76116006)(83380400001)(224303003)(85182001)(33656002)(86362001)(38070700005)(55016003)(2906002)(66946007)(186003)(53546011)(9686003)(6506007)(26005)(107886003)(38100700002)(122000001)(316002)(66446008)(41300700001)(66476007)(52536014)(66556008)(8936002)(4326008)(64756008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHJLdzNRbWtHMzNscjdxWTNvbU1uVW53ZVBpbkZMZjliVlBLTkY0VXZvMXNH?=
 =?utf-8?B?c2Uwb0s5MXhwQjZ0Nk5FeHNBaFVaWUdqYlpwT1JVaFh6eEp2SURWb0ZZaG03?=
 =?utf-8?B?bDRTR2krZ0ZLVm8zODFINXFyZ0VBQy91L3lrQmxMVmpLZFBVQ1RublB1blVK?=
 =?utf-8?B?UWN3QjVWbFRMcFI5Um1ZUnQzd1lFbVlkSzNUaVRSekhyM2ZIZVRHYmJBaXJx?=
 =?utf-8?B?MmlZK05RN0NjbzZwb3ZJL3VFWWQrdjJvVngwVkxOUXZoVkdmcDhsNnJXT3ho?=
 =?utf-8?B?UnZ5emJDUGpoYXBZUFJFRnBBcnp1bndiUFJxKzdhYW9memFWWEdJN054Yklq?=
 =?utf-8?B?OVJVeHhkTUJwM0c5M2FYRzQydlpXSFpib0JOeUVQODV0T1NWZ2RielpoU0RU?=
 =?utf-8?B?LzNSeE9QZXM2cVVwMXgvM1MxblFnY1ZKa1c4VG5Xb3p4MzVJbENUZGYxckFZ?=
 =?utf-8?B?dzIvRnlyd2N0cldXTFhmKzJXZUpxeHVtOThUaW1WMGVSNXZXRkJHaFdSYjR6?=
 =?utf-8?B?Nk14SzlUQWU4QmN0YXl2alBVM1ZUVFI3RWl5QjBiQU9rVGdtZkdxVnVlYmxE?=
 =?utf-8?B?Q3NEQWZzOXVaeGlmUk4ySVNQc09qZnl6a05IaS9lamJ0T0ZYVHBqWGJCTmdo?=
 =?utf-8?B?ZnVzKzdiclZuOEsrWXEvVTZKQmg3OXlEZWNXNjNEbGhjdjZMbXNWVmJpT0J6?=
 =?utf-8?B?UlkxSnFXZTA5UGYramVOSlJ5RldoRWtXVjhWZk14NW5mcnlaWkRjYlVoYytB?=
 =?utf-8?B?OStvNWx1LzRCaWZuaEo1ZGprRFVwNjNrTHRuQlRFN05ERjZBMFlTQTgzVFhX?=
 =?utf-8?B?alhFbU9XN1ZPalNmVVI4dnlqbjMybVFwMi85VXlJYjVyS2RRMUFWWERBU3Rq?=
 =?utf-8?B?d2ZLaUpQZnA3dkdXc213OG8zSW5RY25EcnhIbmljTG5tMVFXV2h5YlFtOEcx?=
 =?utf-8?B?dWorSnlnZVZ5TzFFWUVYYndqbXVhOXBFRHUwQytXd3FkWStEV3NGVTlYVFlz?=
 =?utf-8?B?TTJxOEtPN1grY0tMR0JQcmYvNys0eVhwMVVVd2p1dHNkT3NjNnJLMWlmdTRP?=
 =?utf-8?B?L2M5M1hzdnhqNktzK0VnaHQxNHdGT1lGV3QzWEtpYU5uTURwZVRHdFpqK2dS?=
 =?utf-8?B?VnpRQjQxelB2WURkd2Y0YTlpbHJTeDFFT24xQ0E2bHhHVDgzcHFlMHNaNXQ5?=
 =?utf-8?B?L1ZBZUZuNWdacTl0cU11clZmYXZnSVdza1poM0tVclN2Nzd3OS9NKzlvWVZQ?=
 =?utf-8?B?ZTVNZGVQMEg1blZpOWF4MHBTQUR1bWhHci9nbjFoRmd6VDViOWcvZkdLK2dx?=
 =?utf-8?B?elVCa1JCZ1BvZHg5anpIeVRqSlFaNUYwU1U0VzZNSnArc2RTbFFpUUVKLy9i?=
 =?utf-8?B?Z0FBYmRHcVBOQ1F1T3hueVFNYzREUzQ3Mi9veUFQVzVkUUhoNTlwb0xsay9P?=
 =?utf-8?B?cVhPMm1rS2NBdGNremRIaXlpSThxMGx4cUR2MnlGc0d5R3FQZUpZOW0zU3pS?=
 =?utf-8?B?cjl3UTVSUW1oUGN1ZWd5dDk0d0xGM3JjYlhiVWZQeXNkYjJ3RUpmNkRudVlq?=
 =?utf-8?B?NTl3WnJyREMwK3ZqTit0L2Rxb3M4b1JwSWUrVUFmc2tVMHVvdjRyeEhVa01V?=
 =?utf-8?B?Qk4vL2swTThENzltZGJEOU9FY3JHdDFzZ0JWem5lbUtYc2lkSllMaWpaRDBh?=
 =?utf-8?B?ZnJRVW1waGpMYU4yUmJaZlRGVFhhenRtN0V0ZFNpVWljY25EbnBWaVNKMkpX?=
 =?utf-8?B?azV3bFJ5RlBQTHM1RGo0K0dZWThVa08rN3RpUUlTOTVtUng1RGhLRndkSW95?=
 =?utf-8?B?R00rZmlDSFdMS2hIWVBhb3pDOWRPWEt5SFpKQXhPeiswcEdCSDdyZUpENkVj?=
 =?utf-8?B?dm9KZ2EybmpOY2hPT2QweDR6eFp4Y3BVTjZ0THBTMnBEWHhjM2xEL2FQaXdJ?=
 =?utf-8?B?NzkramxLOFBLWnNtZ3NmR0hjWjZpaGgzcm12TXpETW1MdG92Y3VtNjczajFy?=
 =?utf-8?B?aXordkRINlFiMXlGc0pxTFpHUGp2ZWlZSjFNekdvR2VpdTNCL2VjeitDR1B6?=
 =?utf-8?B?M3hPNlc1NGozLy9qcitvSk1tczZHMHVHSjRCaEN5N2FVVi9SRHMwNFBFdDZo?=
 =?utf-8?Q?LS/fz1CJNZE4SYzY4RiS8z/S7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77527ce0-6174-4cf2-2910-08db755dc960
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 09:23:07.3788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8N16wjA58Pval9wwYd8QPJZH2abL5CfIm/fsATL648bccRhCy/d/2u1DIkaY0JNmxna4ofN8jb3eNhG3+IqQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5693
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+IE9uIDE2LjA2LjIzIDExOjIxLCBsaXBlaWZlbmdAb3Bwby5jb20gd3JvdGU6DQo+Pj4gRnJv
bTogbGlwZWlmZW5nIDxsaXBlaWZlbmdAb3Bwby5jb20+DQo+Pj4gDQo+Pj4gU29tZSBvZiBzaHJp
bmtlcnMgZHVyaW5nIHNocmlua19zbGFiIHdvdWxkIGVudGVyIHN5bmNocm9ub3VzLXdhaXQgZHVl
IA0KPj4+IHRvIGxvY2sgb3Igb3RoZXIgcmVhc29ucywgd2hpY2ggd291bGQgY2F1c2VzIGtzd2Fw
ZCBvciBkaXJlY3RfcmVjbGFpbSANCj4+PiB0byBiZSBibG9ja2VkLg0KPj4+IA0KPj4+IFRoaXMg
cGF0Y2ggZXhwb3J0IHNocmlua19zbGFiIHNvIHRoYXQgaXQgY2FuIGJlIGNhbGxlZCBpbiBkcml2
ZXJzIA0KPj4+IHdoaWNoIGNhbiBzaHJpbmsgbWVtb3J5IGluZGVwZW5kZW50bHkuDQo+Pj4gDQo+
Pj4gU2lnbmVkLW9mZi1ieTogbGlwZWlmZW5nIDxsaXBlaWZlbmdAb3Bwby5jb20+DQo+Pj4gLS0t
DQo+Pj4gICBtbS92bXNjYW4uYyB8IDMgKystDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL21tL3Ztc2Nh
bi5jIGIvbW0vdm1zY2FuLmMgaW5kZXggDQo+Pj4gNmQwY2QyODQwY2YwLi4yZTU0ZmE1MmU3ZWMg
MTAwNjQ0DQo+Pj4gLS0tIGEvbW0vdm1zY2FuLmMNCj4+PiArKysgYi9tbS92bXNjYW4uYw0KPj4+
IEBAIC0xMDQzLDcgKzEwNDMsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBzaHJpbmtfc2xhYl9t
ZW1jZyhnZnBfdCBnZnBfbWFzaywgaW50IG5pZCwNCj4+PiAgICAqDQo+Pj4gICAgKiBSZXR1cm5z
IHRoZSBudW1iZXIgb2YgcmVjbGFpbWVkIHNsYWIgb2JqZWN0cy4NCj4+PiAgICAqLw0KPj4+IC1z
dGF0aWMgdW5zaWduZWQgbG9uZyBzaHJpbmtfc2xhYihnZnBfdCBnZnBfbWFzaywgaW50IG5pZCwN
Cj4+PiArdW5zaWduZWQgbG9uZyBzaHJpbmtfc2xhYihnZnBfdCBnZnBfbWFzaywgaW50IG5pZCwN
Cj4+PiAgIAkJCQkgc3RydWN0IG1lbV9jZ3JvdXAgKm1lbWNnLA0KPj4+ICAgCQkJCSBpbnQgcHJp
b3JpdHkpDQo+Pj4gICB7DQo+Pj4gQEAgLTEwODcsNiArMTA4Nyw3IEBAIHN0YXRpYyB1bnNpZ25l
ZCBsb25nIHNocmlua19zbGFiKGdmcF90IGdmcF9tYXNrLCBpbnQgbmlkLA0KPj4+ICAgCWNvbmRf
cmVzY2hlZCgpOw0KPj4+ICAgCXJldHVybiBmcmVlZDsNCj4+PiAgIH0NCj4+PiArRVhQT1JUX1NZ
TUJPTF9HUEwoc2hyaW5rX3NsYWIpOw0KPj4+ICAgDQo+Pj4gICBzdGF0aWMgdW5zaWduZWQgbG9u
ZyBkcm9wX3NsYWJfbm9kZShpbnQgbmlkKQ0KPj4+ICAgew0KPj4NCj4+SXQgZmVlbHMgbGlrZSBz
b21ldGhpbmcgd2UgZG9uJ3Qgd2FudCBhcmJpdHJhcnkgZHJpdmVycyB0byBjYWxsLg0KPj4NCj4+
VW5yZWxhdGVkIHRvIHRoYXQsIHRoaXMgYmV0dGVyIGJlIHNlbnQgYWxvbmcgd2l0aCBhY3R1YWwg
ZHJpdmVyIHVzYWdlLg0KPg0KPkhpIFNpcu+8mg0KPg0KPlZpcnR1YWxseSwgd2UgaGF2ZSBpbXBs
ZW1lbnRlZCBhc3luYyBzaHJpbmtfc2xhYmQgaXNvbGF0ZWQgZnJvbSBrc3dhcGQgYW5kIGRpcmVj
dF9yZWNsYWltLg0KPlRoZSBnb2FsIGFib3ZlIGl0IGlzIHRvIGF2b2lkIHRoZSBzeW5jLXdhaXQg
aW4ga3N3YXBkIG9yIGRpcmVjdF9yZWNsYWltIGR1ZSB0byBzb21lIHNocmlua2Vycy4NCj4NCj5C
dXQgdGhlIGFzeW5jIHNocmlua19zbGFiZCB3YXMgb25seSBhcHBsaWVkIHRvIG1vYmlsZSBwcm9k
dWN0cyBzbyB0aGF0IEkgZGlkbid0IG1ha2Ugc3VyZSBhbnkgcmlzayBpbiBvdGhlciBwcm9kdWN0
cy4gRm9yIHRoZSBhYm92ZSByZWFzb25zLCBJIHdhbm5hIG1lcmdlIHRoZSBwYXRjaCB0byBleHBv
cnQgc2hyaW5rX3NsYWIgYW5kIHRoZSBwYXRjaCBvZiBkcml2ZXJzIHdvdWxkIGJlIGNvbnNpZGVy
ZWQgdG8gYmUgcHVzaGVkIGlmIEkgY2hlY2sgYWxsIHRoZSByaXNrcy4NCj4NCj5Tb21lIGluZm9y
bWFsIGNvZGUgZmlsZXMgb2YgZHJpdmVyIGFyZSBhdHRhY2hlZCBmb3IgeW91ciByZWZlcmVuY2Uu
DQoNCkhpIFNpcjoNCg0KUGxzIGhlbHAgdG8gcmV2aWV3IHRoZSBwYXRjaCBtZXJnZSBpdCBpZiBu
byBwcm9ibGVtcywgdGhhbmtzIHlvdSB2ZXJ5IG11Y2guDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0t
LS0NCuWPkeS7tuS6ujog5p2O5Z+56ZSLKHdpbmspIA0K5Y+R6YCB5pe26Ze0OiAyMDIz5bm0Nuac
iDIw5pelIDExOjA1DQrmlLbku7bkuro6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQu
Y29tPjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZw0K5oqE6YCBOiBsaW51eC1tbUBrdmFjay5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN1cmVuYkBnb29nbGUuY29tOyBncmVn
a2hAZ29vZ2xlLmNvbTsgemhhbmdzaGltaW5nQG9wcC5jb207IOmDreWBpSA8Z3VvamlhbkBvcHBv
LmNvbT4NCuS4u+mimDog5Zue5aSNOiBbUEFUQ0hdIG1tOiB2bXNjYW46IGV4cG9ydCBmdW5jOnNo
cmlua19zbGFiDQoNCk9uIDE2LjA2LjIzIDExOjIxLCBsaXBlaWZlbmdAb3Bwby5jb20gd3JvdGU6
DQo+PiBGcm9tOiBsaXBlaWZlbmcgPGxpcGVpZmVuZ0BvcHBvLmNvbT4NCj4+IA0KPj4gU29tZSBv
ZiBzaHJpbmtlcnMgZHVyaW5nIHNocmlua19zbGFiIHdvdWxkIGVudGVyIHN5bmNocm9ub3VzLXdh
aXQgZHVlIA0KPj4gdG8gbG9jayBvciBvdGhlciByZWFzb25zLCB3aGljaCB3b3VsZCBjYXVzZXMg
a3N3YXBkIG9yIGRpcmVjdF9yZWNsYWltIA0KPj4gdG8gYmUgYmxvY2tlZC4NCj4+IA0KPj4gVGhp
cyBwYXRjaCBleHBvcnQgc2hyaW5rX3NsYWIgc28gdGhhdCBpdCBjYW4gYmUgY2FsbGVkIGluIGRy
aXZlcnMgDQo+PiB3aGljaCBjYW4gc2hyaW5rIG1lbW9yeSBpbmRlcGVuZGVudGx5Lg0KPj4gDQo+
PiBTaWduZWQtb2ZmLWJ5OiBsaXBlaWZlbmcgPGxpcGVpZmVuZ0BvcHBvLmNvbT4NCj4+IC0tLQ0K
Pj4gICBtbS92bXNjYW4uYyB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL21tL3Ztc2Nhbi5jIGIv
bW0vdm1zY2FuLmMgaW5kZXggDQo+PiA2ZDBjZDI4NDBjZjAuLjJlNTRmYTUyZTdlYyAxMDA2NDQN
Cj4+IC0tLSBhL21tL3Ztc2Nhbi5jDQo+PiArKysgYi9tbS92bXNjYW4uYw0KPj4gQEAgLTEwNDMs
NyArMTA0Myw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHNocmlua19zbGFiX21lbWNnKGdmcF90
IGdmcF9tYXNrLCBpbnQgbmlkLA0KPj4gICAgKg0KPj4gICAgKiBSZXR1cm5zIHRoZSBudW1iZXIg
b2YgcmVjbGFpbWVkIHNsYWIgb2JqZWN0cy4NCj4+ICAgICovDQo+PiAtc3RhdGljIHVuc2lnbmVk
IGxvbmcgc2hyaW5rX3NsYWIoZ2ZwX3QgZ2ZwX21hc2ssIGludCBuaWQsDQo+PiArdW5zaWduZWQg
bG9uZyBzaHJpbmtfc2xhYihnZnBfdCBnZnBfbWFzaywgaW50IG5pZCwNCj4+ICAgCQkJCSBzdHJ1
Y3QgbWVtX2Nncm91cCAqbWVtY2csDQo+PiAgIAkJCQkgaW50IHByaW9yaXR5KQ0KPj4gICB7DQo+
PiBAQCAtMTA4Nyw2ICsxMDg3LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgc2hyaW5rX3NsYWIo
Z2ZwX3QgZ2ZwX21hc2ssIGludCBuaWQsDQo+PiAgIAljb25kX3Jlc2NoZWQoKTsNCj4+ICAgCXJl
dHVybiBmcmVlZDsNCj4+ICAgfQ0KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKHNocmlua19zbGFiKTsN
Cj4+ICAgDQo+PiAgIHN0YXRpYyB1bnNpZ25lZCBsb25nIGRyb3Bfc2xhYl9ub2RlKGludCBuaWQp
DQo+PiAgIHsNCj4NCj5JdCBmZWVscyBsaWtlIHNvbWV0aGluZyB3ZSBkb24ndCB3YW50IGFyYml0
cmFyeSBkcml2ZXJzIHRvIGNhbGwuDQo+DQo+VW5yZWxhdGVkIHRvIHRoYXQsIHRoaXMgYmV0dGVy
IGJlIHNlbnQgYWxvbmcgd2l0aCBhY3R1YWwgZHJpdmVyIHVzYWdlLg0KDQpIaSBTaXLvvJoNCg0K
VmlydHVhbGx5LCB3ZSBoYXZlIGltcGxlbWVudGVkIGFzeW5jIHNocmlua19zbGFiZCBpc29sYXRl
ZCBmcm9tIGtzd2FwZCBhbmQgZGlyZWN0X3JlY2xhaW0uDQpUaGUgZ29hbCBhYm92ZSBpdCBpcyB0
byBhdm9pZCB0aGUgc3luYy13YWl0IGluIGtzd2FwZCBvciBkaXJlY3RfcmVjbGFpbSBkdWUgdG8g
c29tZSBzaHJpbmtlcnMuDQoNCkJ1dCB0aGUgYXN5bmMgc2hyaW5rX3NsYWJkIHdhcyBvbmx5IGFw
cGxpZWQgdG8gbW9iaWxlIHByb2R1Y3RzIHNvIHRoYXQgSSBkaWRuJ3QgbWFrZSBzdXJlIGFueSBy
aXNrIGluIG90aGVyIHByb2R1Y3RzLiBGb3IgdGhlIGFib3ZlIHJlYXNvbnMsIEkgd2FubmEgbWVy
Z2UgdGhlIHBhdGNoIHRvIGV4cG9ydCBzaHJpbmtfc2xhYiBhbmQgdGhlIHBhdGNoIG9mIGRyaXZl
cnMgd291bGQgYmUgY29uc2lkZXJlZCB0byBiZSBwdXNoZWQgaWYgSSBjaGVjayBhbGwgdGhlIHJp
c2tzLg0KDQpTb21lIGluZm9ybWFsIGNvZGUgZmlsZXMgb2YgZHJpdmVyIGFyZSBhdHRhY2hlZCBm
b3IgeW91ciByZWZlcmVuY2UuDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujog
RGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQrlj5HpgIHml7bpl7Q6IDIwMjPl
ubQ25pyIMTbml6UgMTc6NDMNCuaUtuS7tuS6ujog5p2O5Z+56ZSLKHdpbmspIDxsaXBlaWZlbmdA
b3Bwby5jb20+OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnDQrmioTpgIE6IGxpbnV4LW1tQGt2
YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3VyZW5iQGdvb2dsZS5jb207
IGdyZWdraEBnb29nbGUuY29tDQrkuLvpopg6IFJlOiBbUEFUQ0hdIG1tOiB2bXNjYW46IGV4cG9y
dCBmdW5jOnNocmlua19zbGFiDQoNCk9uIDE2LjA2LjIzIDExOjIxLCBsaXBlaWZlbmdAb3Bwby5j
b20gd3JvdGU6DQo+IEZyb206IGxpcGVpZmVuZyA8bGlwZWlmZW5nQG9wcG8uY29tPg0KPiANCj4g
U29tZSBvZiBzaHJpbmtlcnMgZHVyaW5nIHNocmlua19zbGFiIHdvdWxkIGVudGVyIHN5bmNocm9u
b3VzLXdhaXQgZHVlIA0KPiB0byBsb2NrIG9yIG90aGVyIHJlYXNvbnMsIHdoaWNoIHdvdWxkIGNh
dXNlcyBrc3dhcGQgb3IgZGlyZWN0X3JlY2xhaW0gDQo+IHRvIGJlIGJsb2NrZWQuDQo+IA0KPiBU
aGlzIHBhdGNoIGV4cG9ydCBzaHJpbmtfc2xhYiBzbyB0aGF0IGl0IGNhbiBiZSBjYWxsZWQgaW4g
ZHJpdmVycyANCj4gd2hpY2ggY2FuIHNocmluayBtZW1vcnkgaW5kZXBlbmRlbnRseS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IGxpcGVpZmVuZyA8bGlwZWlmZW5nQG9wcG8uY29tPg0KPiAtLS0NCj4g
ICBtbS92bXNjYW4uYyB8IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL3Ztc2Nhbi5jIGIvbW0vdm1z
Y2FuLmMgaW5kZXggDQo+IDZkMGNkMjg0MGNmMC4uMmU1NGZhNTJlN2VjIDEwMDY0NA0KPiAtLS0g
YS9tbS92bXNjYW4uYw0KPiArKysgYi9tbS92bXNjYW4uYw0KPiBAQCAtMTA0Myw3ICsxMDQzLDcg
QEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgc2hyaW5rX3NsYWJfbWVtY2coZ2ZwX3QgZ2ZwX21hc2ss
IGludCBuaWQsDQo+ICAgICoNCj4gICAgKiBSZXR1cm5zIHRoZSBudW1iZXIgb2YgcmVjbGFpbWVk
IHNsYWIgb2JqZWN0cy4NCj4gICAgKi8NCj4gLXN0YXRpYyB1bnNpZ25lZCBsb25nIHNocmlua19z
bGFiKGdmcF90IGdmcF9tYXNrLCBpbnQgbmlkLA0KPiArdW5zaWduZWQgbG9uZyBzaHJpbmtfc2xh
YihnZnBfdCBnZnBfbWFzaywgaW50IG5pZCwNCj4gICAJCQkJIHN0cnVjdCBtZW1fY2dyb3VwICpt
ZW1jZywNCj4gICAJCQkJIGludCBwcmlvcml0eSkNCj4gICB7DQo+IEBAIC0xMDg3LDYgKzEwODcs
NyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBzaHJpbmtfc2xhYihnZnBfdCBnZnBfbWFzaywgaW50
IG5pZCwNCj4gICAJY29uZF9yZXNjaGVkKCk7DQo+ICAgCXJldHVybiBmcmVlZDsNCj4gICB9DQo+
ICtFWFBPUlRfU1lNQk9MX0dQTChzaHJpbmtfc2xhYik7DQo+ICAgDQo+ICAgc3RhdGljIHVuc2ln
bmVkIGxvbmcgZHJvcF9zbGFiX25vZGUoaW50IG5pZCkNCj4gICB7DQoNCkl0IGZlZWxzIGxpa2Ug
c29tZXRoaW5nIHdlIGRvbid0IHdhbnQgYXJiaXRyYXJ5IGRyaXZlcnMgdG8gY2FsbC4NCg0KVW5y
ZWxhdGVkIHRvIHRoYXQsIHRoaXMgYmV0dGVyIGJlIHNlbnQgYWxvbmcgd2l0aCBhY3R1YWwgZHJp
dmVyIHVzYWdlLg0KDQotLQ0KQ2hlZXJzLA0KDQpEYXZpZCAvIGRoaWxkZW5iDQoNCg==
