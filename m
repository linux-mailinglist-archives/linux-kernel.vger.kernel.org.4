Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224E3740449
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjF0UHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0UHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:07:17 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2103.outbound.protection.outlook.com [40.107.114.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EF71BEA;
        Tue, 27 Jun 2023 13:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5ePT5Dp6FPRUEMpVi1BnLxxmJdWrTGC1Uv8SO+t7M2wziwXCBLFU1MjB2dsWp9WaQGUQ36B/LWlVfGS1LML05v2EYzi0aTwa+Nf4I8ovqaWb+VlBZySG6QrzkIX+EFuF/S17DczDm94Bfw234RjjvLQC615x+pidLCYdEUNOVLYnQrUGIi1+TzdMRkQkd+ZeTv/aUvYQpLS5Gmqvvv/0eW8fNWMeEqdr/eTOaS/i0J3VxBDOzRgEWqce39r5VUXCAEr4nsAWEaOquxTcoXK45DeRLwgjtOyUSkzlVrdBEhO6uQBT7WLDU58K4McTfGi1skkNPOfV/Yuneb2qpkVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9S6NxrDhq6v7HuKD0NdKtKlR1h76eQBtiwhHjL22kY=;
 b=XbWTYGTXXOIB++fW51OgqW19U9JjM1nrBRtVNotp7NBDytQQ7lwXEzHY1NHu2nLiU9anE1KLzB2jqcdHiy3M9j9YbR7OWoVMm79eDY4+05kUmCuAcEbWj3K1D5+FhR4aQigXwVqmUkLNyYQC4wbDrOyxdEs9pL9AiUUCpkg/yiZ3bP2t5QJnJhoO+r9BGs/UqwXkQ3p+dC/0UFGoLGOrBaxUB+h9+8CBfWcCI/ekceEVq3yiYONLZFFqSyjYpRtZXAYfoVeA8kBoEVMeRbS+TRd9YceZjovKbMXWRC/C2dc8GIPNxjos5kZUliGK92MCtZaLOjElIlP1LJqFMyORcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9S6NxrDhq6v7HuKD0NdKtKlR1h76eQBtiwhHjL22kY=;
 b=ifWSdXSTmmw2y0qTOxSdgsUmHUKFqHOPXeGguUTe94rKT8WjDzxEXZBWTUdgOXHNOxoOZkAqNVdnGfJZkAqyP1xfVhA0v1NiqQjA8h2vei7+ZtV+lupnV66ucR8Bqql+PXm7N1E/f+8U8xOd/OZrvPopJiBYqfDJ50MaO7qf2PI=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYVPR01MB10876.jpnprd01.prod.outlook.com (2603:1096:400:2aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 20:07:12 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 20:07:12 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>
Subject: RE: [PATCH 5.10 00/81] 5.10.186-rc1 review
Thread-Topic: [PATCH 5.10 00/81] 5.10.186-rc1 review
Thread-Index: AQHZqF5EHqH/lVoNmECbwAlC7a/mJq+fD4NA
Date:   Tue, 27 Jun 2023 20:07:12 +0000
Message-ID: <TY2PR01MB3788F95356FD458BE108ADA1B727A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230626180744.453069285@linuxfoundation.org>
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYVPR01MB10876:EE_
x-ms-office365-filtering-correlation-id: 2c82d33e-7623-4611-d11f-08db774a187a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZmapjsxs93HKNXQcb9G0X0orVYUcGLtnPbpphl+iRnfhrTiU7hDzMWEAFAJnAgJbwWrWpU2iSKF2ydCGwTu77L7P+wZzyzjbf52grWEBqA/Agq5SCioU8qZUV1lsncA7LdHlSr53PVy7PfntmhwFj+4tbCGMipiWCt2vSGSkaEHx/aH73iYmCajbUJAiGf4bf6BniReT26GzpD21vgzpZGTmhvyGkXKTNpKDZy7GR2ktFbeixSgQiTzwtLGOcZc+HvIBqRvsBK+5Qb1H68UOueYm9HZkBxZfLc+i1+pS44E+7GN0GEEMWiyVOtplLrryaoK2WD0DyWQQLLwxBqCh/u/TvsVJsUUXz/mYxmaAaFQTWSO9D9TrP0cv7ewMSZI8u4eJT4wwWvtXqtD7DzNeBpvnFIWa0n4byxArHOprSo5dNlIlAcl4lYzolTbpXfzMwzSdrCPrs5Msu3g52Dop3qh8hx39bwrGTnAsY5dX+ry+KPTuoiUF8hxNLLzOXIahWc/qD0wkltUhE6uctWXfqmUmHHaI5pB+AfdshYhyf/TTzk/LBsrqtnkRuMfBfmdvtfCecJ8+03A0Hq+RubtfH0l8pu5DBSnMEgVBZMnQ9w/FdQK2iQ+PmnIfrFM9budX8vyhNV7PxBqsdZc3IdHmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(8676002)(66946007)(66446008)(64756008)(4326008)(55016003)(66476007)(66556008)(41300700001)(8936002)(316002)(76116006)(6506007)(186003)(26005)(4744005)(966005)(9686003)(110136005)(478600001)(54906003)(71200400001)(7696005)(5660300002)(2906002)(7416002)(52536014)(38070700005)(122000001)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFd6ZG9zRy9KbFVtbWZiaUNKNUphWXpZWmt0dWluem9SYStYSHE0RjYvODF4?=
 =?utf-8?B?ZGpwVkR0dVVYUjV4czdGWFgvazFzVzE5cjQvdnBCTzgzTkYzSDVuM3J3NWtW?=
 =?utf-8?B?Y2RkdjhsL1Z5UWNLS2hZT3daRHpCTFZDQW9IWDVBS3BScDNuVkcvYkRnNjg2?=
 =?utf-8?B?cXQvZmVyUkVQQXkzajRTRmYxcUFzMzZySGlzUTFydnNxMjIyQjFzWjROZVN1?=
 =?utf-8?B?eDNwYkRFbGU0YWdOSDduUGliREFTdWd1OEo1OFpWaXR3VjFucWNSVnVYZERJ?=
 =?utf-8?B?MTRZR3k3NFA4MjQwL3NqUlZRcVJiMHM3aWhLQnI3T29xVXFLN3VjcVhmMm9u?=
 =?utf-8?B?Q2NVRnJXVVRkaWl5cWtUenkxQjVaeERPdGliMloyTE1kQmJKaFI1TWFYU3I3?=
 =?utf-8?B?ek9xcGszUDVDVUpxM3lRSWdHM2NDeUJYdk9hYU1TY0dUc0pseDV4cHdNSC9N?=
 =?utf-8?B?bGM3SVZxR0hFRjhjbkJIZUw1UXpJRWRqdVRUZE8yT05EZlZPSTcrUkpDS2lh?=
 =?utf-8?B?SnN3a1FYVFlMbjgzZW1PdjNUUjQrN3h4TU5zYTR0OEVwclM5NU01WDEzT1ZS?=
 =?utf-8?B?a0ZVdVJnZ3h5YW5tMXNzZVpBdlhjZllBRVhvSzRxQkFnT2xDaXpsc2R5d2J3?=
 =?utf-8?B?MFEwa1E3YTBUS2JnMFJrVUkzMHgzT3UyVHNPUFJ4cHRveE05YjBlRys5bUVh?=
 =?utf-8?B?aUtZVVZpQllYTDFHVVhLMXllZG1kVkNzRHhPTCtpM1FkdWMrNWVmSWhnQmxG?=
 =?utf-8?B?eHVWMVBjb2tzSVllOU5aeG9ZUmRSQ24wVFU2VnozVnVnN09NQnhUME9qNGZw?=
 =?utf-8?B?bUl0ald4Ym1BcGdyYW9wVXpBSDFQRmFhcXRTQWl0dnlZNlBjaG1kbTEwU0lZ?=
 =?utf-8?B?R25GRjFUWHIydFlNZHVWY29WWTl4Y2pOMkp6dUROMTFlMTF0dTBFZlpjNXNy?=
 =?utf-8?B?aHZTUE5JWUF2NnV1ZTlwR0NiTXNtT3JEd3Q1SzhqRXVFWWczUU15SFNuSFlQ?=
 =?utf-8?B?T0tQSldEMWxsOVk4eWRTbTAzWFkrUG1sUUtBWExsVFAzU3pPUU9VdFdqK3o0?=
 =?utf-8?B?UDQ3S245OTJpRWUxMGdwZG1FYWx3OSsyZTZuTEswK3pVWnM3UWt3YlQ0YWVy?=
 =?utf-8?B?KzltblRHbUF0SnErZWdVTzdGTzBVbkhNSjNtd2tlMklHR2FlMVdOcHZzQzcr?=
 =?utf-8?B?UW9oellxOW45MEpYdms3T3ZXMTNEU3BHeGpDRWpIc1VjWEZnOHRDVUMyUVE1?=
 =?utf-8?B?aEdqb081MHRXVW5ZdzNMalJoZjRINVZuOWFUN05QSjlVV1hYMVpOeXhiOXBu?=
 =?utf-8?B?WnNEdjdjaTNOZkZjcGJkSW9ybzJSeDU0YWNwMDkzU2l0TlZ2QUFiQ0kxRWs1?=
 =?utf-8?B?SVlSZWlTZHhLMGJ4MmFOcHZMTlg0MkFTWXdFWU1kckRUYkVidG1wbTN4WEJB?=
 =?utf-8?B?dGVuT1hKYkZlRm94akZtR3VXb3pYMU9BL0dkL1NvOFlLSThlakxHOUJ1djZq?=
 =?utf-8?B?eG5OektHWnJlM05aWk44bHVLa2NQbzdjaW53S2N0bVl5elE2eWUwTjdZR21v?=
 =?utf-8?B?SlVOeTZrTXFxY0l0b09Pb0k4Szh1NlRrL01IaFEzSGRxbjFqSHJ2UjVVMVVn?=
 =?utf-8?B?ZGw2N1pNNG5kTG90b3ZLOXp4ZExYVW5qaUszT3N1YitlWUFIMzZLMVNvcUZl?=
 =?utf-8?B?b1hlR1M2ZmdScWNXSnIxNmY2ZEpUcjRjakJUQ1VlV2NTNUVkMGpHais2WE9H?=
 =?utf-8?B?aWptQXJZcjJDWUl0L0tLWHFNUG5MSGJBNnk4TDdsNnNIM0owK2VhYkV4RlhF?=
 =?utf-8?B?a0thdWNLd1VFK1Y2QzFZVGtuTGJjd0dMSHlOUFlyV1o1MnhVZU9kVUEwTVI3?=
 =?utf-8?B?YzRCQnJoaUpqeTQ3bzBZMHdjdVRXZ3JkbFJOUVBBT2J2RWZKdmd3bXBrOHZz?=
 =?utf-8?B?eUdwcGF1RE9rd05MYUVIdCtnVzNZSnE0SFh0Q0pSMG5nTVo5bXJkZit1Slli?=
 =?utf-8?B?dkkraW55ZlRQQ0dQSXlTMEJja2x4a2l1a25jSkJPbi9LMTc1T0R2Mk85Q0hP?=
 =?utf-8?B?R0F2K0M5ZlBvYzJEZXh0VFpQU0F5Rmo2V2VHQVc5S2Q3bUhzWk1PTnBwRndk?=
 =?utf-8?Q?ZxvDJsiWPyB8BoYe3NQFalPq4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c82d33e-7623-4611-d11f-08db774a187a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 20:07:12.4468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3whC+sT8/BPx2FgYSdgA72PYOlauKe+WShFeLGzy3LQvOQhL7/1p3x5tY2eUIvk2naMcIHPVLlv50fclVWeWKBqTX6tuo1npbIn3vsBpTMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gR3JlZywNCg0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjYsIDIwMjMgNzoxMiBQTQ0KPiAN
Cj4gVGhpcyBpcyB0aGUgc3RhcnQgb2YgdGhlIHN0YWJsZSByZXZpZXcgY3ljbGUgZm9yIHRoZSA1
LjEwLjE4NiByZWxlYXNlLg0KPiBUaGVyZSBhcmUgODEgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcywg
YWxsIHdpbGwgYmUgcG9zdGVkIGFzIGEgcmVzcG9uc2UNCj4gdG8gdGhpcyBvbmUuICBJZiBhbnlv
bmUgaGFzIGFueSBpc3N1ZXMgd2l0aCB0aGVzZSBiZWluZyBhcHBsaWVkLCBwbGVhc2UNCj4gbGV0
IG1lIGtub3cuDQo+IA0KPiBSZXNwb25zZXMgc2hvdWxkIGJlIG1hZGUgYnkgV2VkLCAyOCBKdW4g
MjAyMyAxODowNzoyMyArMDAwMC4NCj4gQW55dGhpbmcgcmVjZWl2ZWQgYWZ0ZXIgdGhhdCB0aW1l
IG1pZ2h0IGJlIHRvbyBsYXRlLg0KDQpUaGFuayB5b3UgZm9yIHRoZSByZWxlYXNlIQ0KDQpDSVAg
Y29uZmlndXJhdGlvbnMgYnVpbHQgYW5kIGJvb3RlZCBva2F5IHdpdGggTGludXggNS4xMC4xODYt
cmMxIChmN2FhY2ZlMTBhMjUpOg0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10
ZXN0aW5nL2xpbnV4LXN0YWJsZS1yYy1jaS8tL3BpcGVsaW5lcy85MTIzNzMyNzMNCmh0dHBzOi8v
Z2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1zdGFibGUtcmMtY2kvLS9j
b21taXRzL2xpbnV4LTUuMTAueQ0KDQpUZXN0ZWQtYnk6IENocmlzIFBhdGVyc29uIChDSVApIDxj
aHJpcy5wYXRlcnNvbjJAcmVuZXNhcy5jb20+DQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg==
