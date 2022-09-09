Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA65B3AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiIIOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiIIOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:43:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFAC10B573;
        Fri,  9 Sep 2022 07:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1ZMOsEwcZTElekkgmPhQe+xxg5QyX00VuQeeutRc9bha6w/RWoAMHf/bf97IdhSYNmW6bTPYgI/5zWcfQOslXLMEBRDr8LcBOl232Ks2u3rEEiakQye27sXP8ff4Jgrnn7y77G1qbquMOZl05nEFWdhXNGTpYNMioztMjfW8jk9CJ9lmcwil7hWpFIvQBY/NMVE6eNXEXWdd24SkG3kFcVupuAFS8nb9P0rnlWv7OIyH8SRsOc6CnQCcVix+a+7MaKY8pjPjDqhiCPmAkDqjXXighTlFWpFWq0yr940+1eZAVCwech1UiJdKDR6A+kyVPo2h9KjCgvcLXU9OLeujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3Q+VpTVbAT1VaI+dUGWp2DgAVRZY9FTNj6THzzNcp0=;
 b=hwGZSU+HN+fF7s/4rgMjGQg6OxmxjYJVZhmHfqOfwD88rAy8LfQqwpWewmvfRR9V/FTtEv6BxPBiCpUSW5Zb8MFjf6bxK5cXVcLejiVdeZRjYHFOhp4TF/SkKW8Bxe7XXMyCh0ki0zKSFgJ6ICCf43y78PI6bO4FEDKid9ljYuXt/bPgkdw2vSghPEKkIbKAoWZvIu+jxV6b1cx5DZj8qBIGda15NkeFhit1MN6N+Y4ZTgWDh/AoYCjNub3AmiHrZa21ZbXBuSnShQc9+KE/+A/9eurJ25Xqsp/4W1RlcpXJXv53Cr7A3M/BMl96va5+7KjHv9vK7ECdL7tZfqOiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3Q+VpTVbAT1VaI+dUGWp2DgAVRZY9FTNj6THzzNcp0=;
 b=XLScRZnR5pjLaMaUYSrc+wprvTe5y1PAQV6tTX0SHJfOwGrmOSPuS7NtZBkdoJkO6TmQ0wg27U8DQ101OnCC8o8ehvqpqBmwD6Jd3UFG0owd1n3bv13Ou4UIBGiCfMElYAhAeU7XzsEI45KVUlXXZPPoFlckakdZUrDbNaSabOTKUqBTX2FoxbjIA8G0vIaKzeSmDfevt7oLy7MRqdON43Kjf54kJ/RCkD+cKfNM0wcdJhER8ohFHjhf0quYAxpp4oPhpfTZoiB8pJ62iIhwiG7W+STOyz4CZxvTizj4QytT0HgoqNNh8Gd/NalKTNvZRub9yE4uCZx+bUhNeBzXdg==
Received: from IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 by CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 14:43:14 +0000
Received: from IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::c16f:a8f1:ca2c:52e4]) by IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::c16f:a8f1:ca2c:52e4%4]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 14:43:14 +0000
From:   Jim Lin <jilin@nvidia.com>
To:     "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: rndis: Avoid dereference before NULL check
Thread-Topic: [PATCH] usb: gadget: rndis: Avoid dereference before NULL check
Thread-Index: AQHYw6xnAqgS7O8nqUKvh68pSasTJ63WlVSAgACYSwA=
Date:   Fri, 9 Sep 2022 14:43:14 +0000
Message-ID: <4242e47a94bf7ffe989ca2c6ed48e862ce3b3013.camel@nvidia.com>
References: <20220908175615.5095-1-jilin@nvidia.com>
         <YxrRPxeh/iCeCW4R@kroah.com>
In-Reply-To: <YxrRPxeh/iCeCW4R@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6603:EE_|CH0PR12MB5372:EE_
x-ms-office365-filtering-correlation-id: 9ae9bcf7-06cb-4051-f61e-08da9271a023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3/Hq1AYOcebFY4GikUCc0UO5tkuBLfX/E8m3EMqLeGX9aVOoMNMnvo8m9e2d/Ducjc9w+vyUqpupsl3iBzsB9EEuQxhBvDtRNkyJYpzoUUa2B+6Ndr8Hls1JGQYyWl+sZEq7q7+OuykzH+9ryj1xZF8mxK3vI0BO+5aQiibiSBUZp8+fjpByaamdl4a1nAGOvyrjpqmZkG0Awd1iKOkORSW9AYGBEwE83mH2yfqTnnKWv9UeSuzfRuAV994DhYfuIMM6Fio3deD6UKHeoVGtV0kD3zm6X7nsbqajj2Q4YUiF3EdCfjds4axaA9XGSB1bn4t5SgETCJ+zHlcYYowlWNwDOIJBg9UJDaLm0vbdKl4tX1mBfpNKzjLYLJC1ftt7HLndjrg+pQnUoTFvgUYAU9tyaZXBYqHV/nly22ZKbPPmCAX3TvKsObEJyXyr7FAUApZmCT1m+7T8o27PxIAj0/hh3LU2gWiAFnNrT6Y4/vkZevldGTyHJLfmaPwi6rUZGY4IlT38BhnDfDGNp5x26kott84Qd0QbrzUm6WeRsb0BafsI9vWQbywWxJs7bhmpMiUxEXaPJZS71qB9oQPFFzHnQwGOnw9dUxCqz/jE3ZGlT/UYTSewjU6qx83WYc0BpvRkNYEUBXbJSmRT0HtkwEdcZWXgWco2FuVYHxO/kI/wIxuOfFWN3dsAQ4ObPH11S/7bCvoUvtvdpq1HvuF/kFp0OiZKo8B+qr+AgN1uXDRe1YMUqE+dRleqdyboODUVFqa4c75GoJuha2QnZdeiOoIZV7eLd8zIsjLY16CbleE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6603.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(5660300002)(2906002)(54906003)(110136005)(36756003)(316002)(91956017)(6506007)(71200400001)(6486002)(41300700001)(26005)(6512007)(478600001)(186003)(83380400001)(2616005)(8676002)(76116006)(122000001)(38100700002)(64756008)(66476007)(8936002)(4326008)(66446008)(66556008)(66946007)(38070700005)(86362001)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDRLT1RJUVM2S3VRUGFuRkNMWDZJN3lxYnN2WDF0bFdaQk1qNXB2SmJNcnpi?=
 =?utf-8?B?MTkwQkIxRTlWbVJmNmhBTHBVdWs1SFpwVjVzYkVTK1lET3R3SE95VWdmcFk1?=
 =?utf-8?B?UUppMnJHWXZ4TXhsc3dxa08wbGhXVmlLcmlRNER0TmNaY2FtUEl2SHVpOUlq?=
 =?utf-8?B?eFN3YlhmUmpsaHpFKzUxb3dza2JQSFVWVk5mLzNuVUdIUlFnTDE0SE1QaVRH?=
 =?utf-8?B?Y0RITmVBN29CMHExcjFZYWdlelJkNFMvNjN2Z0t6WDV3NnhtdE9nYXl0S2Q5?=
 =?utf-8?B?TEF0bS9NNGtMRmM4MGRsd05NVGVha1RLeitXNUVlZXlxNnlkQ0psMjVHL0tt?=
 =?utf-8?B?RnFVYTdMMkxXL1psWTl4bTJWVThyN1RDYWl1dWFhamR3MEFHSmg4Rmw1UDRW?=
 =?utf-8?B?b0tQRDZRZE1FVHgxWi9IQWJTa2htMUc3c05RWnJINTNpc0ZNalZuWUhBYkNV?=
 =?utf-8?B?Si9tdkMrZGFxY0VPS2o4Ry9JY1dUMHVlQytmMWUxcU8vMkh1cnhKR1VmcTJm?=
 =?utf-8?B?Wlo2RElWVFljVUpVUnBXc25rSnlSZXFSVUU2eUVLSE8ycEZCREZrUjYwVE9U?=
 =?utf-8?B?WjdIRkQxeStIVWZzTDRqc2Y5bzhlS1FEZjZGQlNNWGdBRWdNekUzWGVtSjhk?=
 =?utf-8?B?ajFFMWVJdzk5RnZFMmx0MUdveFNRUUdwb1VpQlF1R1AyRXIrdVlTbzVGSjVM?=
 =?utf-8?B?a1pIWTFwZENydzNmZXN0Yjc5Vi9TLytjWHRRdWVsdFNzUjRGM2NtSnhEQUNS?=
 =?utf-8?B?a0p1U0h2bGxaME5LZmMrdERmdFhGblBxdVUydEtBQ1RpNS9OQXU4WUZRbnpY?=
 =?utf-8?B?ZmNORzRJa0RWN0FUNTZFekRGQVVldllhUi8yM1BRTmJreTljSUFZR1F5YnNP?=
 =?utf-8?B?dUoxdU9PTDFEc0U5ZXlLbDZDbmk2Vk5CcHhmNEpDZjVoVmN6eVNoc1VjMW1q?=
 =?utf-8?B?TTVFSDV0MFMzSjhMTVk1WElYcWt2Z2JMRWFKcDY3aDlVckdocitscy8yWm5D?=
 =?utf-8?B?bVZEQzc5aXpSRDJza05NeTkzQ2xnZXErRHB4aCs3QWpma1VGbE8rbTdRRTg4?=
 =?utf-8?B?OVk5Zk5Xc0M3TC9Ta2dSMXJXK1kvVWVzUTd6MVFWbG9vQk5wMldRakxsVGRN?=
 =?utf-8?B?enRBYnRhMWhzQzNsd3FzTkllNGVVVS9IN0pRRzBqL21xaHFIMmJkK3RzcXNy?=
 =?utf-8?B?clZKRVBZc2dsdkkwNVRNNTBzVVAxdGt1VnVtYTg2V0lVMm9ZVlNyVFNiOHhu?=
 =?utf-8?B?RmpBQmlUdVhESFdXTnl5eWIvOWRtNHhNaWQ3TmNidkJGRDBDWU5SVU5YU3NC?=
 =?utf-8?B?RVFRRHh1VFdZK3l6WmNlcXg1S1ByUkRGRzJTb0lkaC93b29UY1M0MS9sWTg0?=
 =?utf-8?B?YnlLNVhaMnIxNzNjQ3VUMW9jMzcveE9mR0hmK1RQcWhZN0lXVlpQQXd3aUZj?=
 =?utf-8?B?SzJ1WGlTNUx3UTVHaVhPOUQwM1BaM0UvTVI2VDk4S2dsbEU4TEp5dXVlS2Rm?=
 =?utf-8?B?ZUhTc1llaWxBUHFSRTZPdlRaMm9aUjJGc0pTVHlLaU0xMWNJdFBxUzFiWlRV?=
 =?utf-8?B?eW1yOHF6UXdFRFpoQnpJckQrd20yYlBWWTlGODFkeG9GbWNWNlViM25FdUJW?=
 =?utf-8?B?MldQNXR2b0JnM09SQm9KUE5qZkkvYUoyMFBTK09nY2JrYTc2b1BxeFIwRzhS?=
 =?utf-8?B?SkdhVkFXTURSaGFHd1dJeVhVTURickFiaUZKdDR0VW9taUljYlppdXVQZTJo?=
 =?utf-8?B?UVUwYzlyeCtZd2hEVEI3YlhuWXBnU3g4SEJJOFF3d1pvWWV4RmRKMm1XTkRD?=
 =?utf-8?B?TDkzd2RSWWpsWncvSi9IZGF2dm5uOGNWVFoyeGdVT0hmSjJXYmJzRGc2RnVT?=
 =?utf-8?B?Qitzd0dTNWpLSWZOT3BaRnlOYjZueCs1K3R4YTVkRXV1RTJMVUg4b2UxM1VX?=
 =?utf-8?B?VXh4ejBFdm8wMUhQRDJHRnFleWZrK3ZpNmRzZ3FnRm5IKzl3cm5MY2k1YVp1?=
 =?utf-8?B?bThKd0NLSUxhaEFhRWc4U2hKVFNLUk0zZUZESGtLVHFxV3pBNGdNOGVIdmdJ?=
 =?utf-8?B?b2NBa3ZTMWZmNUY2NVg3L0tvR1RvTWFwQnFUN0hDNFRvZ0s3V0RQSmdrU3RF?=
 =?utf-8?Q?FxTCiA0yt/olQGOf2oLTBeHSN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <323002E8E530394C8C45825BED0F49A7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae9bcf7-06cb-4051-f61e-08da9271a023
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 14:43:14.1705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJtKEYJj9QEfpB6RRWr5EJFvr+j8mfJIk/uISRmNNaMEOw+/VK99EFvgYHNeP/VfQYT43nI/iCLc18lDuqLfGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDA3OjM4ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBFeHRl
cm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiAN
Cj4gDQo+IE9uIEZyaSwgU2VwIDA5LCAyMDIyIGF0IDAxOjU2OjE1QU0gKzA4MDAsIEppbSBMaW4g
d3JvdGU6DQo+ID4gTlVMTCBjaGVjayBpcyBwZXJmb3JtZWQgYWZ0ZXIgcGFyYW1zLT5kZXYgaXMg
ZGVyZWZlcmVuY2VkIGluDQo+ID4gZGV2X2dldF9zdGF0cy4NCj4gDQo+IEkgZG8gbm90IHVuZGVy
c3RhbmQgdGhpcyBzdGF0ZW1lbnQuDQo+IA0KPiA+IEZpeGVkIGJ5IGFkZGluZyBhIE5VTEwgY2hl
Y2sgYmVmb3JlIGRlcmVmZXJlbmNpbmcgcGFyYW1zLT5kZXYgYW5kDQo+ID4gcmVtb3Zpbmcgc3Vi
c2VxdWVudCBOVUxMIGNoZWNrcyBmb3IgaXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQW5p
cnVkZGhhIFRWUyBSYW8gPGFucmFvQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlt
IExpbiA8amlsaW5AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL3JuZGlzLmMgfCAzNyArKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4gLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9ybmRp
cy5jDQo+ID4gYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vcm5kaXMuYw0KPiA+IGluZGV4
IDY0ZGU5ZjFiODc0Yy4uZDJmMThmMzRjOGU1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNi
L2dhZGdldC9mdW5jdGlvbi9ybmRpcy5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL3JuZGlzLmMNCj4gPiBAQCAtMTk4LDYgKzE5OCw5IEBAIHN0YXRpYyBpbnQgZ2VuX25k
aXNfcXVlcnlfcmVzcChzdHJ1Y3QNCj4gPiBybmRpc19wYXJhbXMgKnBhcmFtcywgdTMyIE9JRCwg
dTggKmJ1ZiwNCj4gPiAgICAgICBvdXRidWYgPSAoX19sZTMyICopJnJlc3BbMV07DQo+ID4gICAg
ICAgcmVzcC0+SW5mb3JtYXRpb25CdWZmZXJPZmZzZXQgPSBjcHVfdG9fbGUzMigxNik7DQo+ID4g
DQo+ID4gKyAgICAgaWYgKCFwYXJhbXMtPmRldikNCj4gPiArICAgICAgICAgICAgIHJldHVybiAt
RU5PREVWOw0KPiA+ICsNCj4gDQo+IEFzIFNlcmdleSBwb2ludHMgb3V0LCB0aGlzIGNoZWNrIGlz
IHVzZWxlc3MgYW5kIHRoZSBvbmVzIGJlbG93IHNob3VsZA0KPiBhbHNvIGJlIHJlbW92ZWQuDQo+
IA0KPiBCdXQsIHdoeSBtYWtlIHRoaXMgY2hlY2sgYXQgYWxsLCBob3cgZGlkIHlvdSB0cmlnZ2Vy
IGEgcHJvYmxlbSB3aXRoDQo+IHRoZQ0KPiBjdXJyZW50IGNvZGU/DQo+IA0KPiBBcmUgeW91IHVz
aW5nIHRoaXMgZHJpdmVyPyAgSWYgc28sIHdoeT8gIEl0IGlzIHRvdGFsbHkgYnJva2VuIChhcyBw
ZXINCj4gdGhlIHNwZWNpZmljYXRpb24pIGFuZCB3ZSByZWFsbHkgcmVhbGx5IG5lZWQgdG8ganVz
dCBkZWxldGUgaXQgZnJvbQ0KPiB0aGUNCj4gdHJlZSB0byBwcmV2ZW50IGFueW9uZSBlbHNlIGZy
b20gZXZlciB1c2luZyBpdC4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQpUaGFua3Mg
Zm9yIHJldmlldywgcGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLg0KSXNzdWUgd2FzIHRyaWdnZXJl
ZCBieSBvdXIgaW50ZXJuYWwgdG9vbCAocHJvYmFibHkgbm90IHNtYXJ0IGVub3VnaCwNCmFuZCBj
YXVzZSBmYWxzZSBhbGFybSkuDQoNCi0tbnZwdWJsaWMNCg==
