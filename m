Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A623A72DC36
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjFMIUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFMIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:20:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69824128;
        Tue, 13 Jun 2023 01:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDjSSe8Ri18y1MnfJLUYePiwJxeMNYVCThRad4XZQWQWnhUx0Ebb+HmquOC2o5WZLsL/lb/CxDLnbZQeJfV4C5KS5vEcS1Cc1qRPXShoXAKd/ZHtglh/tEw2AOQTwzFkYerZcAP0bIHCZgx9oIk47SajTw6qOLle/65C9MyNmijK8TbWpfrGQWK61t8rJOIDB5V2jkYcE9RFEIT3yGH9T2qHXVU4fIQhF14RPJx4NDGEyQvdGBiq7hkbRnxJdXWK2c1qUn/Xy6DI8jVwWLHA2A0k/Z2X2xM+JkC1Iko6B2fQGhnoECl6pXyyHuPc3sXtzQu97W3i8UqvDbajrbajxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QU0vFG7+slyCOBGsHe2q1Ib0T0CMxTMzsHv6w0xFqhQ=;
 b=S2OQ/I0GndzhiO5NJ1NdXBs3sG1pUuOs5SXgB6PSELz7L+5Rxwu7awbjOiI4uIjUHfI66i2biF6vJsmld5mhtqdEvuImyi/5P2vLz3kKzae/NiryVADt80sOUAqWoSQqAmEaQJMGVzRW+xzCA4WCaMtNlXw5xKk+126CJ7i2XtBidnouo+rCY2auIiC6pu4xFeqPsq0ariNSdSfpRWY4BIHBV87nN7RJk0BbMbp2/Jc+BhAZnHINAHZSN63oV+yqqFuAe971dtcjSvSr8TiockG9QUO+TUBH5OZL30PAaUUiyqUNzJpHxhJXTXJrGEKmS1sfQYciDZiKhnAFxypDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QU0vFG7+slyCOBGsHe2q1Ib0T0CMxTMzsHv6w0xFqhQ=;
 b=iG+m7RPoE/N34vINbvdVQRTsMJaldM60yEGO3GHIzrGNQ5uUyU16AfIHmW829g9D4MGayWhPopIOKPzqPmUupA5+hA59UTdeUz1XPHMwQDJ6+58FGrPUlvZuHQpnj1gA7bGLGxYl/9liEocddS9qngy+5fXWStSHpjq2wQhRhwc=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 13 Jun
 2023 08:19:56 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 08:19:56 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] cpufreq: amd-pstate: Set default governor to schedutil
Thread-Topic: [PATCH v2] cpufreq: amd-pstate: Set default governor to
 schedutil
Thread-Index: AQHZnNpxmlVNkY+7oky3diCKzMikhK+GxLGAgACSkFCAAMe3AIAAKwqQ
Date:   Tue, 13 Jun 2023 08:19:56 +0000
Message-ID: <CYYPR12MB86553C506F3209DB340AE28D9C55A@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230612030321.3097627-1-perry.yuan@amd.com>
 <20230612072627.5wzmsfp64jho3bdj@vireshk-i7>
 <CYYPR12MB86556045C209552FF99C47C89C54A@CYYPR12MB8655.namprd12.prod.outlook.com>
 <20230613040550.6mwktq7cyv32wfd5@vireshk-i7>
In-Reply-To: <20230613040550.6mwktq7cyv32wfd5@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0ba65cfc-5246-4865-aba9-096399bdb2ab;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-13T06:39:52Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SJ2PR12MB7845:EE_
x-ms-office365-filtering-correlation-id: 84d28fea-2754-45c4-2612-08db6be6f8d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oFJTuAZviPcel8L4pxuYIabi5MuRwLlA6XpMXDLk6smJt1XCTE3W6YKfuE3l4mwOxOP5QgspJbPhEBWlAzAHwEOnvvXd0VMzeR/WKkuM4ClefeBla1cickB8CQARWilmLS2Wnv2mrfGar0jEx3Vu64oDWsZtpRa3WG8T7gRwP+lDDwm7Qxm64L5fHCCRvVR0cQ/mxhxRVmTcyZm3oGNPm30zttxn6U5p353FqoKBUxcszu65YG5LMr9HsHx2QAQr0WuugCSOd6+DpGeSQMxXgLsuBDjzYGV6auyh19L182ngP0s36Jx5qj+WeQ94/d81SFTrLjym0r3aAAmEnZn2r4/R96TYTV7yE2opCQnV5OLUGZYLFo+omNRXuXZIsqOF6TeZ5xL1rNYBqAdQ5LfCff5wwEsn9RhY4qw02qAbVRBC6/XvPEtk9tW/xVBLTlsCX6rctoxhk7de/i1vgCMcQUMpO5n1S4y6C1aqD35CvONoMEkyfK2HQcpMuwMQlMU303qPenmA7NlO3+R24f+ynkW3l3NvUVgdXZSc7QwjuEfxxwQ31bOZeWG07QFLK0JG6wPVlZgXv6+vxyF7juA8cfAbgmA4hxEa1BrqdNGdPlGIwFZzaVOJgITctJsy0ygO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(6916009)(83380400001)(54906003)(38070700005)(33656002)(478600001)(8676002)(8936002)(66476007)(316002)(76116006)(66946007)(52536014)(41300700001)(66446008)(64756008)(86362001)(4326008)(5660300002)(122000001)(38100700002)(66556008)(7696005)(2906002)(4744005)(71200400001)(55016003)(9686003)(186003)(26005)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3Nkeisva1hWOUlYU2d6NDNiUlh6UlgvVmlFVEFCZjllWXRiTWhCY1l0MVRx?=
 =?utf-8?B?VHJ0Q0xpbWEvMGc5QjBIYnJ6Q0o1dTZjVjFOYWpHVW5OMmE2N2lnYU5vU0tw?=
 =?utf-8?B?aGh3b2FabkVFQnBVY21Sb0xiTjJIVDlFWEhNWFRacFV3cEl3bFRkekpoTU9J?=
 =?utf-8?B?a1ZvSkN4cHByYVh3OWptWGJrUHdlWXNMQXJFYW5pT1NrdEJFSmZsYm5QVllI?=
 =?utf-8?B?Ty9WeGhBWUFRNkFrOGQrTlk0RWs4dURqdXZUeG40M09lV09LajRic3NXNndp?=
 =?utf-8?B?MllzcGRaZGVPK3NXekg5czFLb0FyYllhYkxrTENpMzBiNzJhcVZoSUNtODgr?=
 =?utf-8?B?U0ZGb3kzcktSNVBFSVJtbmVHSVhDS2JaT3ZBOVVaZmlGaVNocHhJblRqaURW?=
 =?utf-8?B?MS80cExGSjBjblRMZk9PeHNmT29zY2tCTUpzVjJITnIxcHBwb01KZEw0dTlx?=
 =?utf-8?B?aVNkNHQzN252akRIdDh5OENicHo2TXE5eEx4N09McXpwY2tOdnRLS3lCTStP?=
 =?utf-8?B?OWZHREEraXNDVExTRmNHRG9CMm5ZUlZyUDZpeE50OW5LZTBhRHZRRDN2L1VC?=
 =?utf-8?B?VmNObllYWldic08yd2psSnM5d3NEaWM0M3ZXZlgxYko4U0pqR1JUbG1qbTQ4?=
 =?utf-8?B?WUY4ZDIrbVNTTTNNTlpwZFhYKzI3M2tBRS9YL2Vobkh3Tnd2TEV5dDlLdWtW?=
 =?utf-8?B?Sm9ZL3EvT3c2WTZiRnhSTGQ5YnAycE8yQ3VFQlFnZ21RVmJqNDVPL0Y0VVhG?=
 =?utf-8?B?aGoxNEF1aTFJcWtkTityZldHejhSSGZwaWxQQU5OTDRZREZNQkxXdEhJQ2c0?=
 =?utf-8?B?QVZxdHdUeE02UkM5NWw5LzVaSWJBYmhySUtZeE94cnNjL1NBWjI4dmVSZ1I3?=
 =?utf-8?B?UUFkYWNleWhWSHNoUnpSTzRnSEpoZDRjcGdaU012ZTlKWGhOczRablp5cVVV?=
 =?utf-8?B?ZGJKeTRoOXV3d05GNGI3dkNVMXBLRlBxYXIxLzJRRXlYOXRMQk9lN0ZWNVhZ?=
 =?utf-8?B?MVZzclNZcDJtWmhCWkZVZU4zaWdMbms5bTZwNFkrQW1yclo1RUdScUtjbUhp?=
 =?utf-8?B?UzRocjVvUVBGTUdkeWhEV2VmeHptZ1F2RTNjU2dTemxTbGZoSDl1am5KMi9a?=
 =?utf-8?B?VStoOFR6Yk9ndDdhUDNOdUo4Yzc1dG53cmxUaTdiUkY4TzczbXpOblR3M2pM?=
 =?utf-8?B?QWhZM3Eyc1lQeW94T3ZOSlVQV05LaXRabW14Mms3VHI2Nm9ES2ViR2FqbHFO?=
 =?utf-8?B?dGJOalRGTTFJS255enBXeFN3MS9OdVhycDVQMHBuK1lGZnBwcktqajdHN3dp?=
 =?utf-8?B?cDc3WmlkbGk2cGxoMCsvTWFxVVJKS1FWNUVmZmN0NHBpVHhzTzgxN29JbHI0?=
 =?utf-8?B?c0pLc3dTSS91eTYwdlpBZy9yTWlMYWRDYXNkbXlWZlVvbGhwMlZEbGZXVi9T?=
 =?utf-8?B?ZTc3WFRRRzBYT3dHeUVUODFOZkhFSGRIZVVpM284OUp2WVlWcFhlT1RNdVBq?=
 =?utf-8?B?UUNMZHN3NnltNXdML09sNjl1VVd4d2o3NG0xWWlJY1RqZHFrRklhYU1kYlUw?=
 =?utf-8?B?Sm85NCtORlcwempqdVp4blNUaUlXUTJFUUNwcU9qWGVzTlBLQTkrQ0JLUGpP?=
 =?utf-8?B?TmZjMWRiOGg2OXVtSkpzdjZSTm5zM20vdU9uQnluaFNJd3FKRUN2TGdzNThT?=
 =?utf-8?B?dHJXNlZTMEd6a1hKZ2dHc3hQd0dmRlZzbUdIcEFoY2NoU01LTHM1WWRCaXlV?=
 =?utf-8?B?S3A2N3dFb0czQWREZFB1MEd3VlpoQmVFVlJNaHlTd29NUGppdmFMMFdnU2JL?=
 =?utf-8?B?N2dmL0NnSEFUU0NIYUpQVk9wdko0NEQ4dnErbzRRNVVhajdIaFVhYlE1cjFi?=
 =?utf-8?B?aWxZSEtNTUJKK21UUk9hNUFnM3YrZ3U2SWRCWUVrakVNRXRUVzRQTm0rUWxt?=
 =?utf-8?B?MHVtN2VVZFVpVW55RnJNcUhQcW9waDg4WnFZNVo4SjNjOGJPTTlqYzczNEVU?=
 =?utf-8?B?ZzZ3SitEUVJrZWFIQndRa0pIYVNiaWU2TzE2bVkxZFhhMHhBWXp6THBjYlRv?=
 =?utf-8?B?OWdYZkt3VUVJODNHb1JUZ2svNHRhVlZ6SVVFVUVldDBlZmFlYmZINS9ub1Rp?=
 =?utf-8?Q?YKow=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d28fea-2754-45c4-2612-08db6be6f8d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 08:19:56.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N57mCr673Y/dlPUoQ6cXuIF4DjZ7RwYEMs6ZKJKRpWUtoerh+dOjsugKiH28ZYeN1CZbM/EkrkL/kng46QOPcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFZpcmVzaCwNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1h
ckBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDEzLCAyMDIzIDEyOjA2IFBNDQo+
IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBDYzogcmFmYWVsLmoud3lz
b2NraUBpbnRlbC5jb207IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsNCj4gTGltb25j
aWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgU2hhcm1hLCBEZWVwYWsN
Cj4gPERlZXBhay5TaGFybWFAYW1kLmNvbT47IEthcm55LCBXeWVzIDxXeWVzLkthcm55QGFtZC5j
b20+Ow0KPiBTaGVub3ksIEdhdXRoYW0gUmFuamFsIDxnYXV0aGFtLnNoZW5veUBhbWQuY29tPjsg
TGksIFN1biBwZW5nIChMZW8pDQo+IDxTdW5wZW5nLkxpQGFtZC5jb20+OyBIdWFuZywgU2hpbW1l
ciA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsNCj4gRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBh
bWQuY29tPjsgTWVuZywgTGkgKEphc3NtaW5lKQ0KPiA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgt
cG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyXSBjcHVmcmVxOiBhbWQtcHN0YXRlOiBTZXQgZGVmYXVsdCBn
b3Zlcm5vciB0bw0KPiBzY2hlZHV0aWwNCj4NCj4gT24gMTItMDYtMjMsIDE2OjExLCBZdWFuLCBQ
ZXJyeSB3cm90ZToNCj4gPiBUaGFuayB5b3UgaGVscCB0byBwcm92aWRlIHRoZSBhY2sgZmxhZy4N
Cj4gPiBJIGhhdmUgYWRkZWQgaXQgdG8gdGhlIFYzLg0KPg0KPiBOb3JtYWxseSB5b3UgYXJlbid0
IHJlcXVpcmVkIHRvIHJlc2VuZCBhIHBhdGNoIGp1c3QgdG8gYWRkIGEgdGFnLiBUaGUNCj4gbWFp
bnRhaW5lciBjYW4gcGljayB0aG9zZSB3aGlsZSBhcHBseWluZyB0aGUgcGF0Y2guIE9mIGNvdXJz
ZSwgaWYgeW91IGFyZQ0KPiByZXF1aXJlZCB0byB1cGRhdGUgdGhlIHBhdGNoIGFuZCByZXNlbmQs
IHRoZW4geW91IG11c3QgaW5jbHVkZSBhbGwgdGhlDQo+IHByb3ZpZGVkIHRhZ3MgYnkgeW91cnNl
bGYuDQo+DQo+IC0tDQo+IFZpcmVzaA0KDQpUaGFuayB5b3UgaGVscCB0byB0ZWxsIG1lIHRoaXMu
DQpJIGhhdmUgYWRkZWQgYWxsIHRoZSB0YWdzIHRoaXMgdGltZS4g8J+Yig0KUGVycnksDQo=
