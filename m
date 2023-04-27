Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9796F6EFF65
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 04:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbjD0CgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 22:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjD0CgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:36:05 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011005.outbound.protection.outlook.com [52.101.47.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D4EE41;
        Wed, 26 Apr 2023 19:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FStFeQMzJx7Vs/54ooL151e3NAEMpTKlzmvoaS7tlfW+ga1VW4BIOOwHdJ8emPeplEqzXZgMPBDJU8o1UC53+adZq0f0LqYQWs34QkSlNSIEWPS1efc7DJOgf/Oz4VgtwCTUXCohQcH9bT70ABeS51uzoyQN3a+qpuCi7UsWvQVWQsyR+In6NgMj90Wg013zIbPj9RkalSmFz8NZbC5Wj56eRVZCFRgqobZxD9jgtjBreZJhZikcyTEAoQEDiD7yYCJrsS4HGDUrf//dvEVqw4GCzM8frOrcxC7Rc2XWYpOfqKyudN/hsu0Dp18aNdmCnRUefxGxQABxJr++6+D5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD+mhCvU26fsB/4WCidRI6dyoM9FKuUR0yMa7LGqeL0=;
 b=nLOmss8opuuKdsDh8o2o/8xqup5McZHt7EflUccmLEsPl0n4dVQ1ViqgSpeL826mmvMuTIYWhD6+Ato0QMvv2clhM1r0kBcMyyVUhe+SeMg3LsMet6MK7sW+1A8WHztXMlVQb+itMq7PJpDqh2SzB6zAzT6EANTZmUu+kSh/7KcdDWi6zZeVAr4TgyUbi9yKXzK+TqNdPbc23Z1KcpzDS3elQglfNPdDa81OwWWAoApCQzbEQKpexJh2Kc/0kHuLeQwM3/mIv//+qZNyLtIMRV4B97lZj6l5DaJbGMvjfU4uPIXkGUCkzFUoac7HkZkDcAG+8TOmasErOUPQoYensA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD+mhCvU26fsB/4WCidRI6dyoM9FKuUR0yMa7LGqeL0=;
 b=NpIHYbBp6LoxE3EA7aETPyLR8CNq5cFb2bRyKvO7bPaIYjVA9wgejHyUz0oZo6DR7MLIum6BnyvLKWAYtMAET1lKqGwRlrU9bcTY7i7Msw9kmysK17SndgsqApnYwpZiTOzabq8Ah9STKkdyQtlfAHRIFgMDovCzwXy51DbNJpE=
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 (2603:10b6:610:155::10) by IA1PR05MB8947.namprd05.prod.outlook.com
 (2603:10b6:208:3d5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 02:36:00 +0000
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::b4c3:9441:f0:efb8]) by CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::b4c3:9441:f0:efb8%7]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 02:35:59 +0000
From:   Zack Rusin <zackr@vmware.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "zhouzongmin@kylinos.cn" <zhouzongmin@kylinos.cn>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] Input: vmmouse - add macros to enable vmmouse
 relative mode
Thread-Topic: Re: [PATCH] Input: vmmouse - add macros to enable vmmouse
 relative mode
Thread-Index: AQHZcyp1IdFMBR96qUWRHyEheNCnDq8+e6oA
Date:   Thu, 27 Apr 2023 02:35:59 +0000
Message-ID: <3a4f27ad2122fe0457dc2a41a3b1b24ac556d26c.camel@vmware.com>
References: 59df37cf089230dc6d2d62f2ee539ee90f72388b.camel@vmware.com
 <rk3ip31xbz-rk4smwgz5s@nsmail7.0.0--kylin--1>
In-Reply-To: <rk3ip31xbz-rk4smwgz5s@nsmail7.0.0--kylin--1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR05MB10206:EE_|IA1PR05MB8947:EE_
x-ms-office365-filtering-correlation-id: 629ca460-6541-4889-7125-08db46c822e0
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hu1WSH24Hq2dsfaNq3aDt23+sM5XA8v62zZlLiVt3OZcHZ60QlOspBGUowYbwJbbRT6lbiaqvvMvqVvom/2cRyoubTVmMiQgdnTr0jjc2BsobZzQnmzbUa3pyH2oH3RYatfm9AR9f8Afbr/PfF/4mWAOhrx24v/GLCfJ4y4BtDgEGrp9wo+qo54kBKPK0LIZi2IOLAc/63/AmHumJy77pEAKJGjyZykqG6zFOlyb35vVT+3be3XrJo9H0c6EkkWvlZ47wIvAxDgcXwydG194CUr0G1ohxw1DhVcqYp3vRqNWYkNfS4UjqeEhz+krW8njr4lqvNO4piL+i0jkLyA8SKLaqWiYbWM5j2IE4b1ivOONoPPwwmeeZ6qGJMk8XCb4CC54ceZjzmx/hmjhORwGap4Vt1b730bp2DhAAKH24E347kbB8Itgd7GNS2FyoplVv/CjLD7Z5hC04tZQcngpVKJRbMyfadlPaX4OXujzqssH6vP+D9WwxBWyNXWyiLfWLhooVJnK+73IbNml8y9/nYNHuyD63342Omiu6PQZUtk368X0Hk5C7O1MLodS5tun3+BrxazdkWYXEuTqRD+jwUpv+aILbY/9Zh4JxjlnbhUHtw1SIAeW/gr1myVWQ1nL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR05MB10206.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(8676002)(6506007)(6512007)(26005)(2616005)(66574015)(41300700001)(36756003)(6486002)(71200400001)(186003)(83380400001)(54906003)(110136005)(66899021)(122000001)(478600001)(91956017)(66556008)(66946007)(64756008)(66476007)(66446008)(76116006)(316002)(6636002)(38100700002)(4326008)(5660300002)(38070700005)(2906002)(86362001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG1HWi9VZGtpQityak5vV29iYmc4enhpOVkwTlFhQWVXbG96ZTB6Vnh0TmVK?=
 =?utf-8?B?dVFMOEc2RGk2RVN5aDlJWHFMZUMvWW5nL282WjVmQzZXdU1TRVdZQXNaaVdm?=
 =?utf-8?B?VlBlTUVnY0JOb0kxYmN4dERBeXJFTFFhcjZ1UzNwTkc1ZGh5YUYrRkd5YXJu?=
 =?utf-8?B?bjlFMEZnUi9nekpZNGRERHVvOUdWVWg4dUpoSkdFNUtXNHUwcHk1VlJoRXJU?=
 =?utf-8?B?aGMwVXZ5TTNiN3JvUXVmcTNzMElVZ3F2SjB0S2RMZ3dZVHZrQlRjMVJOd1d2?=
 =?utf-8?B?R1Z5VjF4TFk3RERvaERndGlrSXo1UGlXdlNBSnR5TGV1OURyMXdQMWgzamFu?=
 =?utf-8?B?MW5HaWlWVks4ZWtDaDAvSjdjbjVpQzJUZkNBTEl6YU1SVDNZYm5RUzVlOHR6?=
 =?utf-8?B?N2JuQ290N0dVdGpZOUFOMWU1WFNJZ09oZ29iYzlIODNhYzdQSGkzU1UxNytD?=
 =?utf-8?B?cW1QemJ3S0VjTE1EdEt0MTQ5S1FxVmc3Y0d0OG85NGNLdWk0eEdodFZnNEF2?=
 =?utf-8?B?dlpQYnFvMkRTSG9xRTlhOC9nNEx3emJtdEY5WlVhc0pxUmFHNHdxYjYzRk9w?=
 =?utf-8?B?c09VUWMvRUEzQU5oR28yazFhNEtPbitJMDdNZFVzeFQxWklQVjNNa0IrMXhs?=
 =?utf-8?B?dENVZ3pBWXNRS3c4SnZEdDlSKzYrMVdjOWhrQTVYUDVQakpHcXlrdWJ4bUgx?=
 =?utf-8?B?dHYzb3BQVm5DRDUwL0c4bFFJQTNwRGkveHhvL1FBRXNLQ0lQN0ZHRUtTNG1m?=
 =?utf-8?B?WnF3TFl5RmdyYWUwSkpycnBNN1l3QlBIYkM5RkNCQnBYanZ6MkV0S3BJRngy?=
 =?utf-8?B?RWd1MXdzZldQTVlBVWRaTDdZM3BKQUNyU1phSHNPbGxDRVhSRTN4U2hyQkFN?=
 =?utf-8?B?TXBxN3Q2YUFRZndrMlMvV2RRdS9sK2lIN1FySTQ2TEdPKzlSeXp3aDNSdEhP?=
 =?utf-8?B?empGbjVxT3V4WEo3bHV5eHB6V080NGV3L0ZlVWU4ZlFUdWxBTnBPN2hwMldV?=
 =?utf-8?B?ckpqejhZUWdnQzJ2S3RPL3ROZVJpeWdhM2F2THI3VGthUTBycHNkR1VaVlJX?=
 =?utf-8?B?WHlXTjAwWDk4dGFST2ZnUzFnajFIZC90SDM2ODlMbFNCK2t2dkVlY2p0VVQ0?=
 =?utf-8?B?eGFqR2JVVGIwdEx1VTFFcnU2c09HUVlQcDFXWFUxM0VaZHRFb3o1Z1hoczZK?=
 =?utf-8?B?YWJMM0E2dHo4eFI4R1VHZlc0QVdjSVRiekJ2Rlo4UUdjZUxUTm1NNWxreUJa?=
 =?utf-8?B?aWoxZEdGeXpZM3p2WkxVN1lVOFk2dkl6ZDN0bzZuOGNkd3pJb21uREFnNDVi?=
 =?utf-8?B?NTdNTytWRVlvYWExbW1iUExtK0VDaG5hTjJYbWlKMGxzZ0IyTVN5TU5mcmh1?=
 =?utf-8?B?dURrazkvb3hZd3oxTjZtL0VNL2c4dzJlOHFnNThrSHl3MytaL1MvLzV5NTJW?=
 =?utf-8?B?VklVY01qVjdWQkN6bEJPc2JXaS92d0JwbVVqVEhZOXlmTStFL0d1blhGSnU3?=
 =?utf-8?B?bjlhRW5TU2dha25Yc29RSWlYaVpucnJ0ZUVSdzFzZDB2R3JDelM3ZzFYOVpu?=
 =?utf-8?B?dFRVOFYzQnI0R0kyelN0SWdSTVM1cGdvTEZuWmdFV1ArZ2I0REtLSUdHVFRk?=
 =?utf-8?B?QnZaaGNrV1MvMkFBYnZXTkh6eFhEdG1Qanp2dGVUUGRUazNTbGtoNUpndC9U?=
 =?utf-8?B?UFZFenhTbVh6Y1ZZdVJjSUZtTkRYdTZCV2E4a1ZUbjNtdFhwb2FhUzdyUEhS?=
 =?utf-8?B?RHNWWGliTk9TdmhmOGFNNUJkUzlLdWdUc1lNaXg4SURwOEFFWVFDME5DT1o2?=
 =?utf-8?B?R1NJM0VTS1F5eVFXTWs1Q0lqSTlBaElBN3c4NUxiV2IyRGpHQ0E5MWU2V0hj?=
 =?utf-8?B?Q2Uvc3dkelR6OGx1Q3JLejJlbDNkRWhpOFRBYkxRdm9Xd29Za3p1Tzh0S2NF?=
 =?utf-8?B?UGFjK0R5TDI0ODRkbWdCU05zTHllSXVTS0IxQTJzR2VHV0p4S1J5UDRTMEJv?=
 =?utf-8?B?VzRaMmR5RXlXRExjS3laNVlmODM2UExwOVBoTzJFQjF5QVhOZVlUZkpXeWRB?=
 =?utf-8?B?ZUtIbDRYVmxFZWY3VlZFeTV2ZmM5R29Xd2ZiaHZ1MWhidlhQUjdKd1NTRDRp?=
 =?utf-8?Q?T4xerHEDAMDvweAUo4aZJ9sUA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6F7E5218B7D724CADDB3FDF73EB70B0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR05MB10206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629ca460-6541-4889-7125-08db46c822e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 02:35:59.5082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTOokF6KmVZJAoUDfsIPP3JZCQuLr1fq5eCb7IkYXLRUzJ7/VSQ/rTfRBnOQP9izzqjCmfgBhoUBx27BZ5AO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB8947
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA0LTIwIGF0IDA5OjQ5ICswODAwLCDlkajlrpfmlY8gd3JvdGU6DQo+IERl
YXIgemFjazoNCj4gwqANCj4gQXMgZmFyIGFzIEkga25vdywgSSB0aGluayBpbiB0aGUgY3VycmVu
dCBkZXNpZ24gZm9yIHZtbW91c2UgZGV2aWNlLA0KPiB0aGUgbW91c2UgbW9kZSBjYW4gb25seSBj
aG9vc2Ugb25lLGNhbid0IHJlcXVlc3QgYm90aCB0d28gbW9kZS4NCj4gwqANCj4gVGhlIGZsb3dj
aGFydCBmb3Igdm1tb3VzZSBkZXZpY2UgYmV0d2VlbiBob3N0IGFuZCBndWVzdCByb3VnaGx5IGFz
IGZvbGxvd3PvvJoNCj4gUUVNVSBWTU1vdXNlIGVtdWxhdGlvbiBjb2RlIGRlZmluZWQgdmFyaWFi
bGVzIG9mICdzLT5hYnNvbHV0ZScNCj4gdG8gaWRlbnRpZnkgdGhlIG1vdXNlIG1vZGUgcmVxdWVz
dGVkIGJ5IHRoZSBndWVzdCBkcml2ZXIuDQo+IEJhc2VkIG9uIHRoZSB2YWx1ZSBvZiAncy0+YWJz
b2x1dGUnLHFlbXUgd2lsbCBhZGQgZGlmZmVyZW50IHNwaWNlLWlucHV0IFZELQ0KPiBJbnRlcmZh
Y2UsDQo+IHNwaWNlLXNlcnZlciB3aWxsIG5vdGlmeSBjbGllbnQgdG8gdXNlIHRoZSBjb3JyZWN0
IG1vdXNlIG1vZGUsIA0KPiBhbmQgdGhlbiBzcGljZSBjbGllbnQgd2lsbCB1cGRhdGUgbW91c2Ug
bW90aW9uL3Bvc2l0aW9uIGJhc2VkIG9uIHRoZSBtb3VzZSBtb2RlLg0KPiDCoA0KPiBBYm91dCB0
aGUgVk1NT1VTRV9SRUxBVElWRV9QQUNLRVQgZXZlbnRzLEkgZ3Vlc3MgdGhhdCBkZXNpZ25lciBt
YXkgd2FudCB1c2UgaXQNCj4gdG8gZGlzdGluZ3Vpc2ggcmVsYXRpdmUgZnJvbSBhYnNvbHV0ZSBv
ZiB0aGUgcHJvY2VzcyBldmVudHMuQnV0IGRvZXNuJ3QgbWFyayB0aGVtDQo+IGFzIHN1Y2gNCj4g
b24gUUVNVSdzIHZtbW91c2UgZGV2aWNlIGNvZGUuSW4gZmFjdCwgdGhlIHN0YXR1cyBjb3JyZXNw
b25kcyB0byB0aGUgZm9sbG93aW5nDQo+IGJ1dHRvbnMgdmFsdWUgb24gUUVNVe+8mg0KPiANCj4g
RnJvbSB0aGUgc2NyZWVuc2hvdCB3ZSBjYW4ga25vdyBpdCBkaWRuJ3QgbWFyayB0aGUgbW91c2Ug
bW9kZSBzdGF0dXMgb24gb3JpZ2luYWwNCj4gZGVzaWduLA0KPiBvbmx5IHNldCB0aGUgYWN0dWFs
IGJ1dHRvbiBzdGF0ZS4gU28gSSB0aGluayBoYXZlIHRvIG1hcmsgaXQgaGVyZSBhY2NvcmRpbmcg
dG8gdGhlDQo+IHZhbHVlIG9mICdzLT5hYnNvbHV0ZScuDQoNCkhpLCANCg0Kd2UgaGFkIGEgcXVp
Y2sgY2hhdCBhYm91dCB0aGlzIGludGVybmFsbHkgYW5kIEkgZG9uJ3QgdGhpbmsgd2UgY2FuIG1h
a2UgdGhpcyB3b3JrIGFzDQppcy4gVGhlIGNvcmUgaXNzdWUgaXMgdGhhdCB0aGlzIGRyaXZlciBp
cyBmb3IgVk13YXJlJ3MgbW91c2UsIGlmIHFlbXUgZW11bGF0aW9uIG9mDQp0aGF0IGRldmljZSBk
aXZlcmdlcyBmcm9tIHRoYXQgdGhlbiB3ZSBjYW4ndCBtYWtlIGl0IHdvcmssIGkuZS4gaWYgdGhl
IGRldmljZSB0aGF0DQpxZW11IGVtdWxhdGVzIGRvZXNuJ3QgbWF0Y2ggdGhlIGJlaGF2aW91ciBv
ZiB2bW1vdXNlIHRoZW4gaXQncyBub3QgYSB2bW1vdXNlLg0KDQpJIHRoaW5rIHRoZXJlIGFyZSB0
aHJlZSBwb3NzaWJsZSBzb2x1dGlvbnMgaGVyZToNCjEpIEZpeCBxZW11IHNvIHRoYXQgaXQgcHJv
cGVybHkgZmxhZ3MgcmVsYXRpdmUgdnMgYWJzb2x1dGUgZXZlbnRzDQoNCjIpIEltcGxlbWVudCBz
b21lIGNhcGFiaWxpdGllcyBtZWNoYW5pc20gc28gdGhhdCB3ZSBjYW4gc2hvZWhvcm4gd2hhdCBl
ZmZlY3RpdmVseSBpcw0KYSBkaWZmZXJlbnQgZGV2aWNlIHRoYXQgaGFwcGVucyB0byBoYXZlIHRo
ZSBzYW1lIHBjaSBpZCBpbnRvIHRoaXMgZHJpdmVyIChub3QgaWRlYWwpDQoNCjMpIEZvcmsgdGhl
IGRyaXZlciwgbWFrZSBhbnkgY2hhbmdlcyB5b3Ugd2lzaCBhbmQganVzdCByZW1lbWJlciB0byBj
aGFuZ2UgdGhlIGRldmljZQ0KZGV0ZWN0aW9uIGZvciB0aGUgcWVtdSBtb3VzZSBzbyBpdCBkaWZm
ZXJzIGZyb20gdm1tb3VzZS4gVGhlIGRyaXZlciBpcyBmYWlybHkgc2ltcGxlDQphbmQgaXMgbm90
IHRvbyBiaWcsIGlmIGZpeGluZyBxZW11IGlzIG5vdCBhbiBvcHRpb24gdGhlbiB5b3UgZWZmZWN0
aXZlbHkgaGF2ZSBhDQpkaWZmZXJlbnQgZGV2aWNlIGFuZCB0aGVuIGp1c3QgcHJvcGVybHkgdHJl
YXQgaXQgYXMgc3VjaC4gRnJvbSB5b3VyIGluaXRpYWwgcGF0Y2gNCndoZXJlIHlvdSB3YW50ZWQg
dG8gaGF2ZSB0aGUgcmVsYXRpdmUgZmxhZyBhcyBhIGRlZmluZSwgaXQgc2VlbXMgdGhhdCB5b3Vy
IGtlcm5lbCBpcw0KY3VzdG9tIGFueXdheSAoYmVjYXVzZSBvdGhlcndpc2UgeW91IHdvdWxkbid0
IGJlIGFibGUgdG8gc2V0IHRoYXQgZGVmaW5lKSBzbyB0aGlzDQpzaG91bGQgYmUgdHJpdmlhbGx5
IGRvYWJsZSBvbiB5b3VyIGNvbmZpZy4gQW5kIGxvbmcgdGVybSB5b3UgY2FuIHN1Ym1pdCB0aGUg
bmV3DQpkcml2ZXIgdG8gdGhlIGtlcm5lbCAoYXMgbG9uZyBhcyB5b3UgY2FuIG1ha2Ugc3VyZSB0
aGUgbW91c2UgZGV0ZWN0aW9uIGNvZGUgZG9lc24ndA0KZGV0ZWN0IHRoZSBhY3R1YWwgdm1tb3Vz
ZSBvZiBjb3Vyc2UgdG8gY29uZmxpY3Qgd2l0aCB0aGlzIGRyaXZlcikuDQoNCnoNCg0KDQo=
