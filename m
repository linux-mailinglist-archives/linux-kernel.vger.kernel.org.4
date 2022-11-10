Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30F06248CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiKJR5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiKJR5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:57:05 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120070.outbound.protection.outlook.com [40.107.12.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454A84385F;
        Thu, 10 Nov 2022 09:57:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On7eGjJPV+/LBR2Nqy+9vGpIiP5Ajool7bmIbiP3Ck6VYZcWTsylQiKgdJZJT/D/vJfbIXUaQpBDN+9kor4FoF4ZYtbC5Ao5JK3UXCfnFiXG1M5on03/c8oAoen20IGiABwK9Gn+IzhK99C7O86FMQw0E/NYuuYmZHIWJVLH+CdRBkLatpUoQAblgvhSMcZChlszloOAzRyUfBnTs7sql6GUg7etVvdM/8SB3O8Sb78zNsrNCip7caoI6oXpC7kOSxfXpXO9M9uEW3W40ZUeLRTmQfe69BMKkpahieQ4VNCKL3KRbYzPVseo6LwgUkXltmgKalQs6/3vTc1uYdOpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hrl7qHSFLCxddOXjFg3Pf7PzoHucQpEiIy0UVXViYOE=;
 b=Rcy8GuqvIJUtLng3JlITJcpcYOwoTHb87Uou41hldc/i4s8jtkHdFvnFpUNcirNSCj3QC/0wt00j+w1R0RL5UY4UoSKN2YoOmJO2fOc8NV2f5ZtzER+v2qVymxn7v41K1ZIigWPLOwLy3txM4//uR/seYjjqgycMQocpxLCgZ0z9BohgtHPznin3cue2CqHu8F9qngrU/As2DLcH0gHTB4sFRfiRGTiHb6a/loYBIHVAW6KD1e7GBtdb/wsKPIKl1I7o/VUVThIEqubJGz/72oE5J7AIOocQaEgl7LNmrTRVAgAtD0edf/Pl5+EhQ3FeEfaL78nMe+27u2gIWDgTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrl7qHSFLCxddOXjFg3Pf7PzoHucQpEiIy0UVXViYOE=;
 b=1oZzD84zoaAfSE74DcA6HorwX9S/oY5qf/nzO77gOlybHXhpR8LMS2BYR33aPK4i02t4chRgFb4IezAXSMJmxGgSiLvrSaKvMUCidkKaW1pIpNQbwvuenCKtIvVG3fDe7uVOTwYiaVi3JwjjsXVIVsnZ+iwW6bxV5rj7PdesILedpJqfTCnuWLN9Vu69nZYGsVsTSQeqWfB/1rABq1oWW+S1Qw5v65IV36mGXpmyJ9yz1hoYkHlG3pawxkJMhWGDiU1zTyqOyBlplp/T4kmzZL2WUgQtAF6JVPK2cAYYa3ZX8kususazOzVnwdN3vAz0Ojz1RoAD+NZRSSkkj4qTig==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3405.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 17:57:01 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 17:57:00 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: Replace NO_IRQ by 0
Thread-Topic: [PATCH] usb: Replace NO_IRQ by 0
Thread-Index: AQHY2UK+PJcRly8Gk0ii4TX51MgeQa4BYqiAgAADNQCAAAZdAIA3PMEA
Date:   Thu, 10 Nov 2022 17:57:00 +0000
Message-ID: <96c221b2-a373-3abf-b1e1-c79267798ecb@csgroup.eu>
References: <63f6d2e7ea17f6522f36abd6cf5e6a7f25f215c6.1665033267.git.christophe.leroy@csgroup.eu>
 <Yz7dI5iTaguhn73K@rowland.harvard.edu>
 <0d2056d8-ed12-88d3-b9c1-d6c1e772dcf3@csgroup.eu>
 <Yz7lKhs5qUXaoFsF@rowland.harvard.edu>
In-Reply-To: <Yz7lKhs5qUXaoFsF@rowland.harvard.edu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB3405:EE_
x-ms-office365-filtering-correlation-id: 0b14d425-5bbf-420f-9b93-08dac344f7b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rTa2mGVyH/uoOwMYtYNI772xPYQmoZO+gMsoNN4RLIneVGClfXeEEzeb7lgIFUEyKqFNvWH4RjiHaKSzl1n8pxEdbOuaaFjZOSQN5cFt0+Xen1Y7uGU4RWo0XRHKyEeOEt8vXXOTXt5obgC/FejXqb22it7F4U//pXaKjL1KXwgcbt9BMgZSev9f7nCtIjmtJzxTVq/JFSPNs8vFmAbbtrQ6onEh4nvnFVytqAVm+lcrrmsbN0yM0hqwzwgR0/bA9rBWaNis0bYp+nXRmPFpmZ49vBrfZd24IE7KXyQ9BNJPDODg858lFZpfaTzUxnjzF7BKnRinVsy+36dyk8sQl7yW5ftcWNaGTHjOA2R+YTQ19HG0dSMmtWFZ4OwBD6aHRaTuE4aUCJBqgLsUVgJKyddu09aWqVpJMHd3vCo57d5IErL+KOjU6l07pRMiGnpzq78Ig/44ItrPAsaRTmHDSJaS8F0aduWOGEg6O8gt0S+yGMAmlvjBL46poZHwhMOKQSmrNCWiT0SCk/QOwCb8JNh/mANovK0AbtwN8wXrqYYHDoJIR4yAKGW+Il807U8jcOjV3CpNUEwNEzMj053alnq9vkmGsQ4ShA6Is5lwPF8ANvZ+CvntuS5BW1up8bKLDCHIlIETRFkmwokALAZGhQes//hgWiQ6p0oZ/CucWJFy+0ZtO9wH39BmrF3ehABPNwu2V/UNr2MdMCRx6u+rHqCFV43evIaqvFIthH6Qrg6vYW6sX1D90IWJFWxqIr7YmOSRhWn5uwa2zljanFfyr/ODsr99P17mAat7ZCPtxtciDxSDcg/XLTLTOsBggimXNM2OTcMWfFyynl7hm9yRrqAf15ltFsg0DFyMBD+DbBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(122000001)(38100700002)(44832011)(2906002)(86362001)(31696002)(4326008)(38070700005)(6506007)(6512007)(478600001)(966005)(64756008)(316002)(66446008)(26005)(66556008)(6916009)(66476007)(91956017)(66946007)(8676002)(6486002)(71200400001)(8936002)(76116006)(5660300002)(186003)(41300700001)(36756003)(83380400001)(2616005)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0FYTjJZMkFTdXdCamwyTUxiYjl0d1hmVWl4NVhvTHRSZ09uVXI4ZTN0eW41?=
 =?utf-8?B?b0o2bXU4S25obFpQU2VsU0prQ0lQdjV1SnVsMWFlN1NWNjJlUzlpdVJUSWc3?=
 =?utf-8?B?V1Zhank3anlGRHpwUHlzYVFDUnpSNEtHVlordVlSdEM2cCt3WTYzeCtGaitP?=
 =?utf-8?B?OE80MzJGY1lXUEYvZ1RKQUJFQlkrZ2tIdnBzUVhnL3VnRHk0RWwyalo4M2xO?=
 =?utf-8?B?b2k1UVRUanIxVjFtR2FDUDhRZjM0YzdIUHIyV0s2UUM4eC9rTFpoWU5jMHRF?=
 =?utf-8?B?eE9QaUJZREZ0UXhDWXFiZXRpdk9mYm9ERFVhc1pFWUZYL2JoUjdVVVVzQkQ2?=
 =?utf-8?B?b21HdFBWekFRZWtpc2VMM3lYN2V2MVdUY3ZFc0FhejQ5cE9McTlqMS92Qmtz?=
 =?utf-8?B?aTRYT3FWSGtnOGZZOGUzUWlnTEpKelpRVlJ6djJUTlcvRW1wc3ZFYVo0OFJC?=
 =?utf-8?B?QXJUOXZ4R2hwOEdKeGFJc2FNZnZldi9qOEZMclhyVzJ6dFRnN2l5MnJzblhv?=
 =?utf-8?B?Z2duQlRuMzlmTHpLNjRFQ3pLSDY0eVdyOEJEM08vYXFBYnNybWdoR2Q3RjQv?=
 =?utf-8?B?RjQ4cnlhWTRqQmloS1FMK2RFcG9PMGJpWm5lVmdTZThlcDlTU0h5SkhkUi9F?=
 =?utf-8?B?aXozZzNxUXNxNHJ5ZWEvZEZqUjVUdjhuekNtTFQzUEtvckY3UVNCVkgya2J6?=
 =?utf-8?B?c2tXcjZ0SkYvSG9jc3hLQmk2NEdkRVNmVjR0Q0pDSnltZnp5M000OEUvUHpH?=
 =?utf-8?B?bms1aXc4cnNTbHF5RmpTWTFyUjNZSmxCSkRCR1dUa281aEFuWldwbE1vbVl1?=
 =?utf-8?B?cDNLYXFyeVdoQ2JjZVR5cmQ3USt2T2FWdERLd1VmQUd2RDJJMHIrZHdVOGN4?=
 =?utf-8?B?QmdldSttUHB3NUZsaktkbkpERVYvaHhFWUx4aEVpQlRwWXl6Sko1WXQ5TFZM?=
 =?utf-8?B?WGN0bDNLNkZqQXQ4dGlxY2tVaWg2VThVMGE0MER5cWIvVkRTdlVuSVpPOVRn?=
 =?utf-8?B?djlGZFlsSEZ0NXp5bXVybVkxdlBVdkFpd0xRRGdJNGE4a3J1N1FJamVEdUtW?=
 =?utf-8?B?TGRDL2RySUdOV1FMZXJkdzlsSktKbEVQYnhnd3dJclJOUmNkd3ZpZldHaGFF?=
 =?utf-8?B?MHVPd2VSOVNhTTVpM3c1U0xNSERHNTNRSERYZWl2N09TeTV6RldNMDFwcERN?=
 =?utf-8?B?T1lSRGtnWXJEOUZ4M29IUllzcGRPSUZ2bFhsbG1jRzdiTVdlWmUvWmlmWC9Z?=
 =?utf-8?B?RHNVNUFYamVwdk5VU2FOY21sRlZ3SXZEODhzSDd2NldBdUZ5ZlREWVg1a1NL?=
 =?utf-8?B?ME8rUnhnY2RKMDY1RURCa1pxU2NmbGFFaGRpaTZwYUIyQXN0ZE1OeUZQMU5h?=
 =?utf-8?B?blNUUWpGd2h5bHNzbFFIOHlFWVRKS0dMUFBudEl3RzhUckJ3REtzaHdEcU5E?=
 =?utf-8?B?Lzg5ZzBXV0xPYURzdmJRY0E1eHFrZ3ZNNGFzTWJRbWZHTU02M1ZEa3ZDdy9D?=
 =?utf-8?B?aURuMmpmQjYwQ0c4SVBlQnRPcjhKOTVIL3pKb0ZtM044NlhvRmg5ZHZ3NHlM?=
 =?utf-8?B?YUk3ZVhUYjJxZ29zVGJhSnpjY3VndDVKS0FOUU5WVGxXODliUHdGc2Y3bXc0?=
 =?utf-8?B?NnFzUi9mV2oxTHhBNlBhMkpyZGhiZ0R5WVpMOUprblFYUUxRUmlncWxuWWhQ?=
 =?utf-8?B?Sk0wTDNSL2w4THRVYW9leS85N2ZTbkg4a281ODdUVkJEb1A4WWdlcE5pSzFs?=
 =?utf-8?B?WHV4L3ljOEloUWcyc1kwSVBzZGUrTC9VUDdsZXRWYjIzalhLWTY1eXQ2aDds?=
 =?utf-8?B?R3duYjVFM1dEUHNEbSs5c2pCQUpoS0Z2MitFTERwWmhsZDZ3T2VxSFVVMlJh?=
 =?utf-8?B?eDNJQm9MbEF1d0hWZGZtWWF0UDZTOUhtRkpvSlV0c1cveTFVbXZwa2VhcmZ2?=
 =?utf-8?B?MDg5dUtHOTN5SG9XM3MvRW5Ya3FXWlh3Ty8xaG5MTFRJQk9yK1dWRkpGQTk0?=
 =?utf-8?B?N3ZRVkFQQzRFeGs5cUFQcVhZSTFEMVcwMzBCOTdYUEtCRVNPTUx5VGVCekZR?=
 =?utf-8?B?Yno1Q25BZWg3M2x6aDI4bVpDenZDdi9XQkpFMkYvSGJBb3d6Z21pOUJyRFIy?=
 =?utf-8?B?ZVpnRXU1enRkT3pCNFhBQnVSbDNkM1o1SjNVTHRGNVh4Q082dDZWOGZaTzNI?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23E042FC3E015B478762FDE3D450A773@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b14d425-5bbf-420f-9b93-08dac344f7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 17:57:00.7256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onUSatR4yaOWTLw7W6bHK6ELD+Yg95aL6rrY66quNihOIzrtv08Jlwy6lKQrsKaU+1y0nlEcPbH5L5kwuoIn8rJ97HtQA3G16r2r6mjjgig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGUgMDYvMTAvMjAyMiDDoCAxNjoyNCwgQWxhbiBTdGVybiBhIMOpY3JpdMKgOg0KPiBPbiBUaHUs
IE9jdCAwNiwgMjAyMiBhdCAwMjowMTo1N1BNICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPj4NCj4+DQo+PiBMZSAwNi8xMC8yMDIyIMOgIDE1OjUwLCBBbGFuIFN0ZXJuIGEgw6ljcml0
wqA6DQo+Pj4gT24gVGh1LCBPY3QgMDYsIDIwMjIgYXQgMDc6MTU6NDRBTSArMDIwMCwgQ2hyaXN0
b3BoZSBMZXJveSB3cm90ZToNCj4+Pj4gTk9fSVJRIGlzIHVzZWQgdG8gY2hlY2sgdGhlIHJldHVy
biBvZiBpcnFfb2ZfcGFyc2VfYW5kX21hcCgpLg0KPj4+Pg0KPj4+PiBPbiBzb21lIGFyY2hpdGVj
dHVyZSBOT19JUlEgaXMgMCwgb24gb3RoZXIgYXJjaGl0ZWN0dXJlcyBpdCBpcyAtMS4NCj4+Pj4N
Cj4+Pj4gaXJxX29mX3BhcnNlX2FuZF9tYXAoKSByZXR1cm5zIDAgb24gZXJyb3IsIGluZGVwZW5k
ZW50IG9mIE5PX0lSUS4NCj4+Pg0KPj4+IFRoaXMgaXNuJ3QgY2xlYXIuICBEb2VzIGFic2VuY2Ug
b2YgYW4gaXJxIGNvdW50IGFzIGFuIGVycm9yPyAgSW4gb3RoZXINCj4+PiB3b3Jkcywgd2lsbCBp
cnFfb2ZfcGFyc2VfYW5kX21hcCgpIHNvbWV0aW1lcyByZXR1cm4gMCBhbmQgb3RoZXIgdGltZXMN
Cj4+PiByZXR1cm4gTk9fSVJRPyAgV2hhdCBhYm91dCBhcmNoaXRlY3R1cmVzIG9uIHdoaWNoIDAg
aXMgYSB2YWxpZCBpcnENCj4+PiBudW1iZXI/DQo+Pg0KPj4gTk9fSVJRIGRvZXNuJ3QgZXhpc3Qg
YW55d2hlcmUgaW4gY29yZSBmdW5jdGlvbnMuIE9ubHkgc29tZSBkcml2ZXJzIGFuZA0KPj4gc29t
ZSBhcmNoaXRlY3R1cmVzIGhhdmUgcmVsaWNzIG9mIGl0Lg0KPj4NCj4+IGlycV9vZl9wYXJzZV9h
bmRfbWFwKCkgd2lsbCBhbHdheXMgcmV0dXJuIDAgb24gZXJyb3IuDQo+Pg0KPj4gMCBjYW4ndCBi
ZSBhIHZhbGlkIGxvZ2ljYWwgSVJRIG51bWJlci4gSXQgbWF5IG9ubHkgYmUgYSB2YWxpZCBod2ly
cQ0KPj4gbnVtYmVyIGJ1dCBpdCB3aWxsIGFsd2F5cyBiZSB0cmFuc2xhdGVkIHRvIGEgbm9uLXpl
cm8gbG9naWNhbCBpcnEgbnVtYmVyLg0KPj4NCj4+IEknbSB0cnlpbmcgdG8gZ2V0IHJpZCBvZiBO
T19JUlEgY29tcGxldGVseSBpbiBwb3dlcnBjIGNvZGUsIHRoZXJlZm9yZQ0KPj4gdHJ5aW5nIHRv
IGNsZWFuLXVwIGFsbCBkcml2ZXJzIHVzZWQgYnkgcG93ZXJwYyBhcmNoaXRlY3R1cmUuDQo+Pg0K
Pj4gTG9uZyB0aW1lIGFnbyBMaW51cyBhZHZvY2F0ZWQgZm9yIG5vdCB1c2luZyBOT19JUlEsIHNl
ZQ0KPj4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMDUvMTEvMjEvMjIxDQo+IA0KPiBPa2F5LCBn
b29kLiAgUGxlYXNlIHJlc3VibWl0IHRoZSBwYXRjaCBhbmQgaW5jbHVkZSBzb21lIG9mIHRoZXNl
IHRoaW5ncw0KPiBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uDQoNCkkgc2VudCB2MiB3aXRoIG1v
cmUgZGV0YWlscyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ0K
DQo=
