Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F064E499
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLOXSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiLOXSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:18:22 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2108.outbound.protection.outlook.com [40.107.237.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376C95D6B8;
        Thu, 15 Dec 2022 15:18:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZgH+jGbCCNIheqgdyx5B1hEqvQvMe7bsPWt9NwSWXTwiBSRifGVxEf51BGj7Mni9h+HJmIZkLvXoprwlJT5GUt63QBEXGn1ZHdRGGzYq2TLLMkAF6nK0ZBFnYD9BoUcDflySxzxtJVUHSmnEagVB9+K0XN5ooilEYs+yBtjzcQ6DqdH2J5EW/wh5W+BRAByiFq9uJC19m8/TVj9w0GQAv5kwXzqAJ+3wNAtI0ueSW+gcfGh8oxzbDjeOidb6p4tudrRhqKwT0EOYGgCLJzytuPXFfmADnSSNTOsvt2c2HGoh6hIUsl6wkjbIYiQ2YlhVokcfK4UWrfV2evoaln+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/UsKsxaY7zJW/zYS1qqMkP7hP3RQJymgP1bT11hmpM=;
 b=AGrWYy5LRsatD5UjYu+Qm6pd4Jp8N4Ibxrnu6oF6wwJOt4zu5KOwIPOskZfMFxPOr9MbK98G7pwjmSY5h98KRrdXwg4lOY8/Hw2Ms3C/Vly7P4DInSDh5eVFl8o55XBW7BZKGQrQsZv6ez3SX9Lsuq6dn5r5qCiXcdWQRO63reu8fxrhGfsyFROgn31RB7jXRsHh2g2uGVdZ9arvatQjkejJRxV61p/gGwgEhKJ78F0Su4KEoC1kd7u/4LBEe/+hLw5cyFXe1923BvZ906fwp2kHKBPHmiPJtDnMfuRTMhookgKpVSBQZKKygWkiZ3GuqI9jj/FGw9qxNBb8d3VGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/UsKsxaY7zJW/zYS1qqMkP7hP3RQJymgP1bT11hmpM=;
 b=N+exkXncbeD98THlz8UBdKejxE4NvuY54mwfaavpaUj0T1irdHm45kfe321OS+1npx9IE/ab5YSf840Jn7gZagRHy0XlqcCkse7Kn8rqgge0SjQAqYlZUuODT/cB0HGwEO0Ss6u6H3BkT9tuRgRTjmYpGk46BiJXf66CiB91v4k=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4645.namprd13.prod.outlook.com (2603:10b6:408:126::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.20; Thu, 15 Dec
 2022 23:18:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%9]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 23:18:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     minoura makoto <minoura@valinux.co.jp>,
        Hiroshi Shimamoto <h-shimamoto@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        List Linux Next Mailing <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the nfs tree
Thread-Topic: linux-next: Fixes tag needs some work in the nfs tree
Thread-Index: AQHZENuE4yelOAWjuEa25aEzLaGbLQ==
Date:   Thu, 15 Dec 2022 23:18:19 +0000
Message-ID: <5ACA3AF2-C039-4BE8-9FA5-2BA5A7FF775A@hammerspace.com>
References: <20221215115449.71fa7b95@canb.auug.org.au>
In-Reply-To: <20221215115449.71fa7b95@canb.auug.org.au>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB4645:EE_
x-ms-office365-filtering-correlation-id: ff7d641e-ff1c-4baf-6341-08dadef2a719
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I9bjZ9jScHb19O1frDORHn7R1tWcCxowl3LWdDggHV7wh3Rqv/6zpCUQg3/Yg2Up0oxWGNYAfmCSAbyO01QEb3+BtgkihedkM7zQxQwDNilTW5uX+SWlNMJPOrJY+/E2Ls7NTJQA00w6ygGSv6NoNaDrCycxT+zmG7JLJrVi8IfyydUwxg7Qwg01nDc3fmgGgL9yY+fdbyjkhudahB7Stq1jkUyPENpZwdlN2HkbN8It8EbDwibvIhSZ99FQLNfPtaqoGKAdiOLHAg4/pZaQoGukyrPU4ojda7esOMVJb/gJcG22Xj22xN6J3xiVsEkftmXs8IQxmwu5znU5rVHSeb60zfT6jq5hOnLmxsHJ1okk25EP5/VlJbFuZtGQrxs8oAvYUbI9GVYe9Z0Dno5oma+2TbqQ4qwU+dl+W/G/69ttkbNdzaQVi6zGXfBoJ1bbpYncWup4y9kPO4rEgZziEtuPeQofKjsYhY2S1oSVnXzhk3X9jbqvkfWvlWUlYTCniAKPfgdBxDWOBtQZJddDgeYquVrlg9uhW1uK/p1+aS/oYjwNPhvYPdxr+82FDrcKaOeXbBeGdz+OGNKAEW48fslKTeHSXA/hTwh4LNOyjHpbG2+d+9dwt7px5pX8z9lKZKHzAHQlChfC1edCwq1tv3Jqg+cRr49voROFAtUvobHOEJGyXM1S9FucR7DbbX9FcpzWFppQQnGrQq9YyR+9vyPpl+MGibHLopQQYJI6Rlk5ZJYnlQ9nJZd+UT0wAMA9d4uV9LUp9wWNdSWb6+QayoE7SCMX9h0KNOoz19D3GOM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(396003)(346002)(136003)(366004)(376002)(451199015)(4744005)(38070700005)(6506007)(71200400001)(2906002)(6486002)(53546011)(316002)(186003)(66446008)(6916009)(76116006)(66946007)(66476007)(66556008)(64756008)(2616005)(4326008)(33656002)(8676002)(54906003)(8936002)(5660300002)(6512007)(41300700001)(86362001)(36756003)(38100700002)(122000001)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T29iMjI2UUFEYTJ4N09tSTVNOHB5c2VXZTdCVkhla3pVb0IxTXBmWU42Qy9j?=
 =?utf-8?B?R01BTUVjT0x1eUVSLzBPWitvTGFIanNJK3lkeE9RSWxFVTkvdnpYQ28raGpY?=
 =?utf-8?B?OS9sWXZkYkI1Q0tvb1AyZVk0R1BBbFZKcGhieHBMdGQ5L1VLeVFUcEVXUXdx?=
 =?utf-8?B?Q1R3VHpVa1FjWnF3bndwZHVaL1JhTzh6dDJCRFhPV3FrNTRhVFpZV25qTHpj?=
 =?utf-8?B?emZhTFJhMHdRdlJsSjJzVjFUK09lbC9IZFgxTjNqQ1piQ25mUGJiTHZ5K0lN?=
 =?utf-8?B?ZzVrWTBGcXJrMkdWZ3FlTEdlNUwySEdGK0dJVS9rMGpoWVhaV3lWQy9xZFNI?=
 =?utf-8?B?NUZaZE55Z2dKSFoxb1NUaHpVVm43QUV3THp5cVFYblNBNjhZL1lId3NyVUJT?=
 =?utf-8?B?U3JvTENJYnRqUFlJaUFlWDloYldvYkttS1FtZXVxM3ZiWVZ3T3YvWjIrNElv?=
 =?utf-8?B?Y2w4WmFTWmg4MmVMVXl0NTRVS2FJUGRWeHZWNGRkM3N1TjRFR2tmbDFGcXZv?=
 =?utf-8?B?VXZTWE96c1hRbSsyYWVDZ21mdFpVNXo2clhGeXhBd0FBWnJnOERRRWhjMVVS?=
 =?utf-8?B?ZHcrclZzbmVNWjFjTXhUMTN1NzlqMmVGTjFLd2VUMXFZZW9uQzVDeUlwR1Ni?=
 =?utf-8?B?SmN1dkdmejljbFBaOXhFSWRNdjFTcEZvSjBoT1NVZll1QUV3V3ViOTIrOWF4?=
 =?utf-8?B?dmVYdFdONDRwNnNUR2tzSi9CUlZGNzhBTkpmSFd0R3BLbWw3dStWQXV3RExE?=
 =?utf-8?B?amNpdmZ2UGY0V1JkUEtiRjhJU2pBc2sva3l1dkVVN2hTV2QybnRDUE5yS0ls?=
 =?utf-8?B?OVp5SUFrMzhsdUxWVHdQNXRlc3N4L1dNU0oyd3lDMVlXL2JyeEdPTGhHaXpz?=
 =?utf-8?B?clBOV1JaZ1UyeUNOY3dZK25DQnBGRnlRQ2hBa1JCNHd6ZVkra2p0d3NpMFV6?=
 =?utf-8?B?MlM4RUVybnl3TVNjSWVJK0lwTytmd1VtV3lSbmg4dUdaRVZrUU1YZ3pLMW1s?=
 =?utf-8?B?YlRPUUZPNm16cjU4WnlTOGswdDhLZUlhalBYem1UdkFhaDF6ckRxRHYvTGJq?=
 =?utf-8?B?U1BrNE5RVUdXYjVpN1lKdWprRzhPS01UU0xSbGx3eGY3T0xnUjY3WnFpekZF?=
 =?utf-8?B?OEJsejlvTlBFc3dSaU5acENqWkYrR2d1b1FlcnV6a2xDM1pQc095aXNpTnVk?=
 =?utf-8?B?STRtVTF4TGdVcC9QMy9kMm1tQnE5Z2lpRm1Lc05JZmI4bXVCbUxJeldmbXcz?=
 =?utf-8?B?SzdmK1lHWDVDb215WlVvd2JOUWQ3ZDBRaXhUeHU0dlIxc0dvRk5LeXdTeUNQ?=
 =?utf-8?B?UGludVJLb083eWthc0hvTW1NUEo3dXFmeGdVamVUaEJ5dDhDMDNFQmtxUDFS?=
 =?utf-8?B?clo0VnM3Skt2RGZkWC9KcjY5WTVmcFFmQWh5QUwrbTRVTzBsekJMdURYSEU1?=
 =?utf-8?B?a2dMM0ZWOGp3bGNsN0g1VlBwcmNFbXZjbFI4MXZGdHNqK2ZpbUR4N1ZuMkZm?=
 =?utf-8?B?UGdRTHhXVDh6SjQxYkhXOGFRcW15dmVZWXFXankxK2Q1cFozS3BWcERSODBU?=
 =?utf-8?B?ZTVpMGszcEVuY1hQN2lwVVBMTENlb0FVc1FkTi9KUDR0SXlsRDUyTXliakd2?=
 =?utf-8?B?K2g1RjVCMTFPeENTdXNSb01QaHpEbkw1MFRTYjR0SkhWclZQVE94cUdaT3Ew?=
 =?utf-8?B?a1NPVE1KMS9oSGQ4Y2t4UE13Q3pSNVdHZGprRmg3UUdvUzY1dlFVZzVyM2w3?=
 =?utf-8?B?c09hK0cyMTZKSCtrTTF5RzUvYW55UFVLd0dsekZ6QUdIdzJJeXNKSHpxdElT?=
 =?utf-8?B?b0RwLzdOQlNhT2FObytYeWZ4WGR5azhaRmlGWkd5ZzgvZnAyNjk2T0taOGZZ?=
 =?utf-8?B?RFprTmFpVlNabmpnK1F5bG5QWHV6L2k5MHdxaHNaOStla1dYWk9SekZEeGx0?=
 =?utf-8?B?VW9mZVJjQVZpSHBMY093VitnSVhJaFdxNzB0SnhSTzFRTFdEakNRSXg4UHVE?=
 =?utf-8?B?anUwejNvUUkxMU9CRkswMkZrVTFrSFV5cDY2dDJYQS94UE5nRWRsMERvaWd0?=
 =?utf-8?B?SEFDL0lIdkFYUlJWMXpOeEpYay9Yc2RQL09oZXF1clVuQXI0L0lXWnNVVnE1?=
 =?utf-8?B?VTl6ellUM09hUVEyZ09jK00wOTJzS052cDB0bnJRZEE5M0VJdG9lVk1rTmZv?=
 =?utf-8?B?a0JVSVdDVlV0b3UvMnNFRElwVjZFbEExcXR5SGtDWTNMeHl4SjY0VFc0UWtz?=
 =?utf-8?B?dDBraUs2SittS3oxWTh0S2s1bzhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21919AE0B2DFC344AEF006C7ADC1454F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7d641e-ff1c-4baf-6341-08dadef2a719
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 23:18:19.2788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrdMzX3PcpmjWW1CKtBZ9hKkqyphttTweN90/Ia5Ufp9m8kOH6XC6nXbmo7cSM1Nuvs+UZF95KrC+eyc4i8BLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4645
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gRGVjIDE0LCAyMDIyLCBhdCAxOTo1NCwgU3RlcGhlbiBSb3Rod2VsbCA8c2ZyQGNh
bmIuYXV1Zy5vcmcuYXU+IHdyb3RlOg0KPiANCj4gSGkgYWxsLA0KPiANCj4gSW4gY29tbWl0DQo+
IA0KPiAgNDA1YWI0NWI1YWZhICgiU1VOUlBDOiBlbnN1cmUgdGhlIG1hdGNoaW5nIHVwY2FsbCBp
cyBpbi1mbGlnaHQgdXBvbiBkb3duY2FsbCIpDQo+IA0KPiBGaXhlcyB0YWcNCj4gDQo+ICBGaXhl
czogQ29tbWl0IDkxMzBiOGRiYzZhYyAoIlNVTlJQQzogYWxsb3cgZm9yIHVwY2FsbHMgZm9yIHRo
ZSBzYW1lIHVpZA0KPiANCj4gaGFzIHRoZXNlIHByb2JsZW0ocyk6DQo+IA0KPiAgLSBsZWFkaW5n
IHdvcmQgJ0NvbW1pdCcgdW5leHBlY3RlZA0KPiAgLSBTdWJqZWN0IGhhcyBsZWFkaW5nIGJ1dCBu
byB0cmFpbGluZyBwYXJlbnRoZXNlcw0KPiAgLSBTdWJqZWN0IGhhcyBsZWFkaW5nIGJ1dCBubyB0
cmFpbGluZyBxdW90ZXMNCj4gIC0gU3ViamVjdCBkb2VzIG5vdCBtYXRjaCB0YXJnZXQgY29tbWl0
IHN1YmplY3QNCj4gICAgSnVzdCB1c2UNCj4gZ2l0IGxvZyAtMSAtLWZvcm1hdD0nRml4ZXM6ICVo
ICgiJXMiKScNCj4gDQo+IFBsZWFzZSBkbyBub3Qgc3BsaXQgRml4ZXMgdGFncyBvdmVyIG1vcmUg
dGhhbiBvbmUgbGluZS4NCj4gDQo+IC0tIA0KPiBDaGVlcnMsDQo+IFN0ZXBoZW4gUm90aHdlbGwN
Cg0KVGhhbmtzIFN0ZXBoZW4hIFNvcnJ5IGFib3V0IG1pc3NpbmcgdGhhdC4NCknigJl2ZSBmaXhl
ZCB1cCB0aGUgb2ZmZW5kaW5nIGxpbmUgYW5kIHB1c2hlZCBvdXQgYSBuZXcgbGludXgtbmV4dCBi
cmFuY2guDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg==
