Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B46CFAB5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 07:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjC3F1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 01:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC3F1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:27:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986B15245;
        Wed, 29 Mar 2023 22:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680154049; x=1711690049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uPMf2oZtJmGfVIxMQ5hh9qr0untZ7oLpTv3Faw/sHgA=;
  b=ieqVazvNvbNE+snOpELwMiTBg1LoBVP8AAOoFFFbHBgMArMMwwmzZy+Q
   Q2JAYlp4uiNC06VhcwRTAll07rDtNjRPFUkA5hwn1rTBMAVJs8dVT6e7w
   b8YZpE+mY29jiWcZYgj43Q5WnMZaNw8H8bGx0gd5f9qb9Qkw2aHWhV0ck
   2iDpxL+V7sAE6ksBzkSm+cPayqkx9tM3v1YvQYkP4+ji65TYJBLk9PdIR
   tGLPq7YalavK53oK8R6QUJRUJIxJ/uwaXBFFrgB57XKqgkY8BuxPPoHD5
   8p5cUG8Zko/bbrJZDBSCqqarUNrBZjoYmyKe6v2kxPtnDmTVSzR3TgNYC
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="scan'208";a="218633126"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2023 22:27:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 22:27:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 22:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=athgMshlZ5XueSSgyIYCgQ9wZSLl4J7QnB4nkfS+bTINvvMgeS03e1P+WARugBI5yG4aKsuBEiornLFs2VmtegfmQQ8Q5CGEw8h/XR7mPLRRrn4mE82reQ87YUw04vJfkWYUYODig+uCu1TmtN9lKWh/9Ov/K7JQOHVi6TM/S4LivOC6Q39+mNc7nd4FwBddAF2O74zcEiYlTlXThR4hOVc+GBZRb/ryGa1KFFxuiMvgAmg56IioWUeTGJnKh0eN15t2RVqr2DAzXwkP3dSB7B6DN/vxjZdSDB511G2fxtYCMNQpeEC+67G7KrPTVbzn/sd876060TrlnNm8Mp3DMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPMf2oZtJmGfVIxMQ5hh9qr0untZ7oLpTv3Faw/sHgA=;
 b=X8sLqsF8s1o7w77FwoKOw0KGLdTEl0uRurtOUcrN1bv87lw4bho1B3yEsJ2ZEBTxuhv9+QRUyxbOjLyhhiQJpM3J4Yt3h7Qc8uEdYdqgO6FZu+gNGE6wQiodkoC64+OXaI7Cd7dzYOfTFJ54GryUQt4Zsdg5Hd/B9OQhO9wvxFxARkxfjAICTJqTYdMaTq9CHiYgAMU6M1Vn8+MKVpLQbjRWoucSQGnRHlzeJ5o2MUy3SKvJ80/pAiTE9WLA1Hq27l7qMTDDQU6/r2YCGSL5wSNqXG0CKlvjhKoUlpPLc8EBFa7oCdVTxHOn5tfb7sSZ6S663zudse9VmzAGYsyDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPMf2oZtJmGfVIxMQ5hh9qr0untZ7oLpTv3Faw/sHgA=;
 b=A9TYh52YpJcm8tnJ5kBlkOvf6K6Lg8cNQxuJqJkjtanNudODQAozTurcpps/319xc+6DPUIiYwpgn2vOb3kBo65sNPzS5o2a03EWYbl3AMcoNhkKVhIiwlwH1DNo/8AgWQjlmFNUiMdmLSEjew+hmJe6272pFkSm3+Pj2xXnpDs=
Received: from MN0PR11MB6232.namprd11.prod.outlook.com (2603:10b6:208:3c3::7)
 by DM4PR11MB8160.namprd11.prod.outlook.com (2603:10b6:8:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 05:27:26 +0000
Received: from MN0PR11MB6232.namprd11.prod.outlook.com
 ([fe80::5939:1be9:fdb0:d5c]) by MN0PR11MB6232.namprd11.prod.outlook.com
 ([fe80::5939:1be9:fdb0:d5c%6]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 05:27:26 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <arnd@arndb.de>,
        <Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v8 char-misc-next 2/5] misc: microchip: pci1xxxx: Add OTP
 Functionality to read and write into OTP bin sysfs
Thread-Topic: [PATCH v8 char-misc-next 2/5] misc: microchip: pci1xxxx: Add OTP
 Functionality to read and write into OTP bin sysfs
Thread-Index: AQHZYYNXhP5XbJfQEkWrMJWz/sBaT68Rh8WAgAFF6QA=
Date:   Thu, 30 Mar 2023 05:27:26 +0000
Message-ID: <397a47f49c17ec1952be7cb15f81ce2416c5be18.camel@microchip.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
         <20230328144008.4113-3-vaibhaavram.tl@microchip.com>
         <ZCQMawjj03rlmUxK@kroah.com>
In-Reply-To: <ZCQMawjj03rlmUxK@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6232:EE_|DM4PR11MB8160:EE_
x-ms-office365-filtering-correlation-id: 67d87ff1-3020-45f7-9906-08db30df72f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NwmLG2LZ8OFsw5sIYg+AOIKhmHjXWbF3ZYJSWhrfjYGp1t6bK9Scii8qHl+0M/YOdY8rQVDJ5Eupkk/1yLNjXuFVlwL0UXHotey6fsx/wQpvnTgU7LKd4Pq680vMyoS7dHHPLJFot+HE/GbYCSQcBsfxvDneMxH7M5n2uwtWPNQ2NuhZmqxl7mV3ZR/3c6bi/6m+cg/Ukp+a6qO9wzIqUcuwm4WsahmhcnKakFlyyeLY0Nco18IDfzDfaDFTmWvRW52wBtcFzk1QilO1upppQUIzjW2ULwrd9BmKrBa1zdwL/ev3/G8oreu3ycbHEJKrLS/wCKVwXmGNVkcaKaVYUrFeK18YUboIPfdXYiyYY/kUXnMAMo4e1Ttd8goHV8eNo3mUfe5V67+pRmpOcMY35RdR8mbvqzvkZAYwP0FJ6f1ZsyjZcyFvxdWpwYnNMZYOrOhgqW8+wf0r0XSMFWXhtnPyTfjKC7w46B4M/X6axAf8V9jyU4igi8os/lh7zqZdU3uw/xXZIB7rojTHJmhApAACf+95LpcBha93Qzz5udhdYPo0otr+CmdSqPw2DKHo72gLhxU1ELgfBw1e3M3rDV/2shjRGgsI5+RGc0r0/0kVTSiKhMh2kC4rpJ/sEXO5DrkItqINyXCHcK0A92zpTNzQFLdX/pkZibiEtP/PGo00NHK3P5BOsQp/ouE5+9+C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6232.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(2906002)(41300700001)(2616005)(83380400001)(316002)(66556008)(71200400001)(8936002)(6486002)(36756003)(66446008)(8676002)(54906003)(66476007)(4326008)(6916009)(64756008)(91956017)(66946007)(478600001)(966005)(76116006)(86362001)(107886003)(122000001)(6512007)(6506007)(5660300002)(26005)(186003)(38100700002)(38070700005)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkhrOHN6d0lNTUc4akxENXJwbGVQb0RkRUEwdjRVb1lVMzhpbHNrMDVBeUk4?=
 =?utf-8?B?S3c5a1BvOURIU0xOVVhpdnVsSHFrMUQvQ1ZBVktsalhva04wWW5vdmF1bEdk?=
 =?utf-8?B?SDVpZ3YwWmI2Q2xoK3BQZDIxNWttaUd6RVhRTHdRSy9HbnJrWHR4dDZGQ0Mx?=
 =?utf-8?B?QlBUbkNrVHBveHIyUTlkbHhHNHliVUFkSnVzaE96UzY0cnd2a3I5MFZjaFdv?=
 =?utf-8?B?Ym1HT1Rneit2RW8xbUtTNjZWWGZqNHpTczlyT1p6WEpkc0toZzhxV2prYWc0?=
 =?utf-8?B?eitmczNYNm1NWkYzWGk3VmtXK1N6Z2VFSjkrRjZWNW05Zzg2NlhuVjVzNEo0?=
 =?utf-8?B?YkdUUjZQNVQ4WWlqd3A5NE5HUlYvSGtVcWw4MHQxUE9ac0h1QVBtR2piR2Jv?=
 =?utf-8?B?RFc1ZldVUzQ3bjZQMENRcUNUcGtlNm5yTHkvM0hTUzlLUVJTaEc3Mnd0UGIr?=
 =?utf-8?B?aXJEMXNxZzFPTVRFeUtMeWVESmJBNXRsV0dwWVpTb3JPdCtpcUJQVzlaSFdt?=
 =?utf-8?B?a3oxS2NqcWNCOTZxYVE2QWJXVXV6c0JYaE4vdXp6aUVtWElRRzdmbnVUM040?=
 =?utf-8?B?MS9NcEcwUmhya0M1Ri9mTU1GMDhBMXhacUhKcVFPV3JONFBNLytoMnVqU2ZS?=
 =?utf-8?B?UkRmZDhYbWhsWWhPT3Y1SnkrK3FKeEI2cGFTUzFDUUNzdnRMbGJKSlI0aHQ5?=
 =?utf-8?B?aVhxZUJoZFJraVhGTG1NTmRKbFI0RE9LaXRhL3VTZ0JETC9saSs3QjdWckNW?=
 =?utf-8?B?VGlyUkxnazQ2bW13V1ZUN0x0bFBEYlIzeXhxZ1l2Q0F4dzYzcGVCWVhsKzl6?=
 =?utf-8?B?S0htaElTU3FpdG1ma1FJRGFaaFFwOUFXWXJIVkYwL1RYdWpNTWJQNjRham50?=
 =?utf-8?B?MzFYbmY2ZlA0cy9PV2NEMmFsbktyRkRkYUZUT2lnZUtzT05WUnlrUXhDYVFY?=
 =?utf-8?B?ejVmUytkdks4ZStjMHdQMThKcm0xK3FQNkwyc08yV3JrODhNallrdStFNDY3?=
 =?utf-8?B?SkFuK1RkT3F6bzFvMTlrQ1I4K3Rhc09XNVRwR2V1VGkvZE5uZFlCR0NxTFZK?=
 =?utf-8?B?eVh6Y1lqR1cvQ1lFN0pTSnFTc2M5VUwvNEMvOXVDQUE4cG5UclZ3SGpEb2Ja?=
 =?utf-8?B?SlV5bVRZYS9hNnJvcTB6QUpqdnZOb0ExOTlFTkxRRi81cE1pbmp4b2NOdXd5?=
 =?utf-8?B?KzA3enRBb0hrTWR0WTFoQlB0MkFpQ1pZdnR2UXNBY04rWnQySEZ3MTdPQlFN?=
 =?utf-8?B?T1RqMTBBbVk2ZGF5N3FrdHhUa3ZpT09QcU4zYzJ0bkFnTENwQVJmMnVkSnBi?=
 =?utf-8?B?SXBJdXBBM0pEbHJiN1N0WndJcjFUbjFraGZFZy92Ni96NDRybTRlOUlPZjNG?=
 =?utf-8?B?Tkx1NklOS1dxcjVRZFV0ZnJ0VTNXUWRrMjdXRFFIRDJabytvdjNPT2l4Qloz?=
 =?utf-8?B?aGNDd2g3ekV6ZUt0MmtWQnFKdHlzQlRLU2U4MGxna245ZWphSnJaczZCWWti?=
 =?utf-8?B?V1FVYU1UK0tBZ0UxQzNNRWQ2OXR6dVFrL3Z1WktBT0tkSlFkaEpOSnJiTkV1?=
 =?utf-8?B?UGpUcXl5b20yZGY5R0dZVkphZ2U1aEwyMC84eThRZFNVeDVCcmErOXRCeGFs?=
 =?utf-8?B?SFJaRldZbWhSeFVKdWwzeHkvTHFCVlR6NEU1Mm1qNmVvUTNtKzlEaldGNWhx?=
 =?utf-8?B?dTBXYlhIZld6UWlPWFJPeVVWVUlxbEMzTDQwTUkrYTR0aFNvc01CQ2V1c28w?=
 =?utf-8?B?UXoxbmprYmluQ1NRRlkzK0RiWXpOaWdoeGlta3NhVkJPbHFPeWh1WmhwNEMx?=
 =?utf-8?B?QWNxWm83YzlBclVsL2l2OHluTTluSTVPYndkY2JTSlFuTFlBQ0FvY0dNM2FT?=
 =?utf-8?B?eEo2cmlTRjk1T2RUQVZuMEhpaEFibjV5VThTbVZHRnlaL2hMcG5qNW4vYUgz?=
 =?utf-8?B?NlFCVzcwUTA1azRqSGZoQzVNNGtXbzRjVTVoRjlMUENTd1R4aEkrT095WEZS?=
 =?utf-8?B?TFRUeGYrTWpmVlFnMEhqVHJCaUhoTDFnVU1DRGsxejZjeFNmclc2ajdUMERE?=
 =?utf-8?B?OEdXZ1JhZnhVSzhSd0ZuOUJ6VDFHRVhKZVM4cTJXMEs0MkZOLzcxbXVDV1M5?=
 =?utf-8?B?Tkx3SisvQzFrMjRCTXhsbXhsdFhORFgvYXdrSlE4dWtnOWY4QkhlczB4blF5?=
 =?utf-8?Q?vwDovJXDVACi8ySDRI6KNC4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD646E637D9BA84AA27D3E1261651405@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6232.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d87ff1-3020-45f7-9906-08db30df72f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 05:27:26.7488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sM7HV7EJf4yntQ4Kl85Oq3fKiLaUyQfYu5GFj2LKOBY0YF3WsD0mx52DNDgrwUszMnePCLFY0/UI7YdNFZcIEFvLpRnNoIJmvNxFj9MWNtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8160
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDEyOjAxICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgTWFyIDI4LCAy
MDIzIGF0IDA4OjEwOjA1UE0gKzA1MzAsIFZhaWJoYWF2IFJhbSBULkwgd3JvdGU6DQo+ID4gRnJv
bTogS3VtYXJhdmVsIFRoaWFnYXJhamFuIDxrdW1hcmF2ZWwudGhpYWdhcmFqYW5AbWljcm9jaGlw
LmNvbT4NCj4gPiANCj4gPiBNaWNyb2NoaXAncyBwY2kxeHh4eCBpcyBhbiB1bm1hbmFnZWQgUENJ
ZTMuMWEgc3dpdGNoIGZvciBjb25zdW1lciwNCj4gPiBpbmR1c3RyaWFsLCBhbmQgYXV0b21vdGl2
ZSBhcHBsaWNhdGlvbnMuIFRoaXMgc3dpdGNoIGludGVncmF0ZXMgT1RQDQo+ID4gYW5kIEVFUFJP
TSB0byBlbmFibGUgY3VzdG9taXphdGlvbiBvZiB0aGUgcGFydCBpbiB0aGUgZmllbGQuDQo+ID4g
VGhpcyBwYXRjaCBhZGRzIHRoZSBPVFAgZnVuY3Rpb25hbGl0eSB0byBzdXBwb3J0IHRoZSBzYW1l
Lg0KPiANCj4gV2h5IG5vdCBqdXN0IHVzZSB0aGUgaW4ta2VybmVsIGVlcHJvbSBhcGkgaW5zdGVh
ZCBvZiBjcmVhdGluZyB5b3VyDQo+IG93bg0KPiBjdXN0b20gdXNlci9rZXJuZWwgYXBpP8KgIFdo
eSBpcyB0aGlzIHNvIHNwZWNpYWwgdG8gZGVzZXJ2ZSB0aGF0Pw0KVW5saWtlIG90aGVyIGluLUtl
cm5lbCBFRVBST00gQVBJcywgdGhpcyBPVFAgaXMgbm90IGFjY2Vzc2libGUgdGhyb3VnaA0KYW55
IG9mIHRoZSBpMmMvc3BpIGJ1c2VzIGF2YWlsYWJsZSB0byB0aGUga2VybmVsLg0KDQpJdCBpcyBv
bmx5IGFjY2Vzc2libGUgdGhyb3VnaCB0aGUgcmVnaXN0ZXIgaW50ZXJmYWNlIGF2YWlsYWJsZSBp
biB0aGUNCk9UUCBjb250cm9sbGVyIG9mIHRoZSBQQ0kxWFhYWCBkZXZpY2UuDQoNClRoZSBhcmNo
aXRlY3R1cmUgb2YgdGhlIGRldmljZSB3YXMgZGlzY3Vzc2VkIEANCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9ZKzlIT2RIR3FtUFAlMkZVZGVAa3JvYWguY29tLw0KPiA+ICtzdHJ1Y3QgcGNp
MXh4eHhfb3RwX2VlcHJvbV9kZXZpY2Ugew0KPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgYXV4aWxpYXJ5
X2RldmljZSAqcGRldjsNCj4gPiArwqDCoMKgwqAgdm9pZCBfX2lvbWVtICpyZWdfYmFzZTsNCj4g
PiArwqDCoMKgwqAgYm9vbCBpc19lZXByb21fcHJlc2VudDsNCj4gDQo+IFRoaXMgZmllbGQgaXMg
bmV2ZXIgdXNlZCwgd2h5IGhhdmUgaXQ/DQpUaGlzIHNob3VsZCBoYXZlIGFwcGVhcmVkIGluIEVF
UFJPTSBwYXRjaC4gV2lsbCBjaGFuZ2UgaXQuDQo+IA0KPiA+ICt9Ow0KPiANCj4gV2h5IGRvZXMg
dGhpcyBuZWVkIHRvIGJlIGluIHRoZSAuaCBmaWxlIGFuZCBub3QgaW4gdGhlIC5jIGZpbGU/DQpU
aGlzIHN0cnVjdHVyZSBpcyBzaGFyZWQgYnkgYm90aCBtY2hwX3BjaTF4eHh4X2dwLmMgYW5kDQpt
Y2hwX3BjaTF4eHh4X290cGUycC5jIGZpbGVzLg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBr
LWgNCg0K
