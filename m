Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515DF6EC48C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 06:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjDXEwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 00:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjDXEws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:52:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FED2D60;
        Sun, 23 Apr 2023 21:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBYCXoXHlqbvodalEglGNh4mrxEYEw8Kl7P7msdTRUII67veZxa9mjIxzg/om7ZXDDSYLQzHxcQMIPHZtDwf+wpt9U2RExzXoA7ckQDFkBiiNh8mAm9wTE2g1meIwbGFBlPaKa51dYNcvt18zgJOG+bwYj4HXctCu+tQSZG8zDFMi6B27SuP6HnVgN6yE3YzUfFD+mTf6NyAMmGjS8nkZfI8YFqz2VO/NZc9ubjDnucSaF/F0eaDQjfQqMCTPkTxuPFzTcacr4lslzp06U2PtPeRchg+5HUHJQtgE5sOqs1VTjmBVOPf/5SXMY6w059sUEpcJ8Rxru0Qv8O0fw+ZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQm5lzrS/9BKVCdGrCVRp0kFD/NfKfxgahDGBtnG7EM=;
 b=VQUF8X3mcThYJaavjmNOBYSTMxjPsrktz4hbgKNtSb/4gjsPhGL56aowYYH3wKwkPUUnij4beu3I8zYOlhU9eKMiKTZd+WlOtEr6lmF6EyfIWB1SulqTI1OIfVFkBOMVXoAiYYVauz53Z4wPFlZhTfH4/BehMNa0bTX8wCUMOBDU8xKu8nqCeKOkAlFcp2oEteb6YjPOlXWqAU49LDiUDkb9mR5AOuW32YW57pPycr7BzQJVxhpgq/lv2gTYwnnX6Eb4Lk+h8ynHnn2iJRq+2+kmx6iw+AvYwOb2CWQdZL9eBFELw2rFJUnp6Ex00feoALIVDeolZKisiWGUBRjOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQm5lzrS/9BKVCdGrCVRp0kFD/NfKfxgahDGBtnG7EM=;
 b=YX++/nehxzoz2y3k3uiC32HypKbvJCZTT+Tz7XWHGp879Ltyzy/TmISiN9XkfBGMPt0ImhT0MQGBh8KFfmI7zputoDU0gYWtwVRkq2E3y42R+kJWHCPCo/yIqlGsEEVmZSvyUIu9kLoDyzZs9pvVA+bHrcH4sDMrIsT3eUyp24M=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 04:52:43 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::b200:d51b:6fa4:20c2]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::b200:d51b:6fa4:20c2%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 04:52:42 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "shubhrajyoti.datta@xilinx.com" <shubhrajyoti.datta@xilinx.com>,
        "srinivas.neeli@xilinx.com" <srinivas.neeli@xilinx.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "inux-gpio@vger.kernel.org" <inux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Goud, Srinivas" <srinivas.goud@amd.com>,
        "manion05gk@gmail.com" <manion05gk@gmail.com>,
        "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
Subject: RE: [PATCH] gpio: zynq: fix zynqmp_gpio not an immutable chip warning
Thread-Topic: [PATCH] gpio: zynq: fix zynqmp_gpio not an immutable chip
 warning
Thread-Index: AQHZdDxpM1KicXwSSECmXLCZ1ni4pK855vIw
Date:   Mon, 24 Apr 2023 04:52:42 +0000
Message-ID: <BY5PR12MB49029372797FC05FC947E31481679@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <1681311127-6891-1-git-send-email-manikanta.guntupalli@amd.com>
 <CAA0M9UZXdnduEqKJTL8D4Y3dwSG=R9_g5xFMYw8PtLDQkKnZDg@mail.gmail.com>
In-Reply-To: <CAA0M9UZXdnduEqKJTL8D4Y3dwSG=R9_g5xFMYw8PtLDQkKnZDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e6dd8485-4e88-4866-b39d-5d50f9a8f069;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-24T04:46:18Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|IA0PR12MB8325:EE_
x-ms-office365-filtering-correlation-id: cc810130-df77-4c15-0890-08db447fbcd6
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GcIfIRuy7Erqrr2JALjNCyfe9+AzugSdR1G/D2l+isPEHY3wQbZO6eGDQhVekCh9UQEN6yXYupO/sXgyMNKoTZC2XVU/zpWTJV9jzXXWISe8bE4fe6tjnjA1ONOlUsgziKo43nl1Ynl7d3aIr2+VY/2gsHK6JA9kPUiwnt1m/066vYM6vH6RlawxRdCz0LUTO+eAS/rFmNBTD+qloyuocEoD+pGETKPSOs6WqKxG1m6NXU+6CaLBEIBNKA9aR77SclysPckCyF4OnGC40+A7KED7ldk26P7lqzM8Y1UtW6KMKGf+aqiMwxaAgNIpBv9k3x3KRKlpWpe+16ZAQJM3TJ3TiEuq9Z4lcaXJmQ5yikHU0zUYFO+UM6+aZzETSQ+8+fUezOCbpcQace9/WrYHqx86J3x7B0SAC11Lnb7zHpy/YEdx0HVyQde3apwZsvmLlL9IzT2KgSsnO+I5qerjmEzj7Zm8Fv0JCNgN36wOPJZuoAoi05R08hQ1M/wo5Pm6ANZbW1pJ0HQNYUb1HGmNOys7FFw9SJRqrbvYYr3jNWv5+/cS1+pK68KVHMesIbYs/zsMueUKe6lSdrWpOZGiyjPQPH7Zmcd1Yzrb4i+I4BblJ09QY4WFDPGKxbL2N9cdkv+53ooCG7N3KFcCN+ZwyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(8676002)(8936002)(38070700005)(110136005)(54906003)(478600001)(66446008)(66476007)(66556008)(55016003)(64756008)(4326008)(66946007)(76116006)(7416002)(122000001)(921005)(316002)(41300700001)(4744005)(2906002)(38100700002)(52536014)(5660300002)(86362001)(186003)(26005)(6506007)(9686003)(33656002)(53546011)(7696005)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWpBV1BhTmZKWkphL1hCWmZWOW42ODZuL3pZNkhXVU1oUitYZzJDNzhKTE5s?=
 =?utf-8?B?ajIxM1BhazBCZnAvemhxRnk0QS9tNGhrMTQ5SUtUN1pnVSt4a1IxR0NwdjZq?=
 =?utf-8?B?UHRVNlNpZG96ZWYyb3VzQURxVXBPS2pacjEvejBnYXZVOTRhdkIxTFRITEZP?=
 =?utf-8?B?TCtZL1hNY2RWWlQwcTN0T0NFN3Q4U3hZdHM3bU0xVmpXOUsyVjFFR3htRUxl?=
 =?utf-8?B?cndUMlNHQ0pLNHpJWGRlZG5kOFBpdVROKzZ3ZU9qaXJEclZWMHVRT2FoWjVV?=
 =?utf-8?B?QU45L29MQW9zZ0tnbHA5N28zcDc4NW5ldzBlN204aXpweW9ZSFBlZ0dYYkFy?=
 =?utf-8?B?UVorUU8yc3hWbThSWXhRZ1ByL0NZNFZ4UG93NkRrU2lET2tQa0ZEWnlkSGto?=
 =?utf-8?B?RW1LT083bDZlMnVBMmFjdjlFT2h5QzlGMUZBNEc3TXhvT2Q4N2tvRlBZYXk0?=
 =?utf-8?B?N3I2emFpcG1ob2V6WnJzVVQwUlJWOEUrQXpIN0JWY1ZWWldEdS9NbGdkYjhH?=
 =?utf-8?B?YjRWWjRMOHhHVnRPSFdwQUxxN2N3aUVDdTE5eFRzV1luczF4ejdZVkxLUXZt?=
 =?utf-8?B?ZzA1Snh3SUdub0lENGZyRTlHVTBiNEM4Wkdscy9mVzlmM29NSlJWMnVFZVoy?=
 =?utf-8?B?d1M5OEF3anRVVkpnYk03cmYvZUVWWDFDdkJwVkFRUU1pQlczSUQwT09nUkRT?=
 =?utf-8?B?RTNjZ1NBWGtJeUwrNEZEVzFWeTBkZW5LTHJaaENzODJ6RFdRYVhrQ05rcW9Q?=
 =?utf-8?B?YlhVSThaTXY0d2kzVGY3QjFqZVFNbVNZWDBBQWdsL1JLMDJUMm1TVk1EeXA5?=
 =?utf-8?B?U0FKNWgxQzNWTGlRVFUyUDQzUTFucUptNmNNUFNFY0JNN1M1UWpoQ2NBVlFM?=
 =?utf-8?B?dFk3K3ZzRmY2VXZvaXpqb0FMSWJoU1Z1c2VBL1RXeXR4VU5nN0l5Y3ZkQ0Rj?=
 =?utf-8?B?dG4yUGh0NFRHeHdzUHVxMGV6amhRekVXV3I1LzVSLytudGlGWEtSaUNuYVpG?=
 =?utf-8?B?YlhXTWNOMDlybUY4ajJMNWNWM2dzUG5EVjJlT0VsSXFBbW5qQ1ZKdU5tcXJU?=
 =?utf-8?B?Y20yZUJFdU1jZDFmQmxXZ1ZPM05JRkl3ZkZYZHRucXJzVG15bFdEK09JZXBa?=
 =?utf-8?B?MElBMW4xQ1FQazBQNTN6MzZSYjlZdXlhQ004U1J6blZFei9HVmthc0J1bDBB?=
 =?utf-8?B?UWQvRVBlNUNsVzVKaytrYXloelI0UE1tSFZYVnJ1V0NIN1lJU3RFTFJ0aEhE?=
 =?utf-8?B?dG9PbUJsTGNrWTRET2JzK25OY1lZTHR3L3N5TTFtZVhaL2htWFJYcWYzNWJX?=
 =?utf-8?B?QU1DSXo4a0V2UnlRUEl5S0Nua05FLy9sNEx6TENiY3d1Yjk1TXlKV05qbGJq?=
 =?utf-8?B?djR4RDVJUEVSOVhBaUdYTkRkRmtQVkl2VkJwcCsraXJYV0o1NHJVNHpOZFhT?=
 =?utf-8?B?YlViNG8zdDA2V2dqSHZzenpRaU8zZWdWbXVtNnhKRVJQakN2ZVF3SzlOMFVa?=
 =?utf-8?B?UGMxcW1FOWJwdFRPcVhxTVY1MURoTzJqWjdEWHZXRUxMbkg5WXFaQWpCMHcx?=
 =?utf-8?B?Sk1XSjkzR2Z4bXJ4emk2dnVVcnc4Mi9qRDZRZFVob01sTmRCenYyRFkxcFhD?=
 =?utf-8?B?Sk96bFJvcERHYi9DUnQ2WHJYMXhMOGIwenU2WkJJTEZldkhEWGo3TVhhSFZa?=
 =?utf-8?B?dzFQZ1VucnppMXIwaXVWK1ZjeGVzbEloTjNnVmZCM1labXpTdWYxUG0ra01x?=
 =?utf-8?B?ZmpmOWZpMGZ5SCtvaGVMbE0xUHdaWDdlZlRLcEZ3Y3FnYkNrV2dSOEgwK0tB?=
 =?utf-8?B?elNYVXR1OTNUV0t6bXc0TzRod21xY2hVT1Yyb0JidFE3UnRYcWlEVitkNzRy?=
 =?utf-8?B?Y3hyMWJhVTkxRnZRcGtKRDgwUHVtOTBIaHVoMWVSbnIreWVDT2lxN05xc3lp?=
 =?utf-8?B?a0hqeE1pSTkzYTR3cFVId3p1WUtlUHFydzlTc0JPVmNVc2xQS08zb1hmSFk2?=
 =?utf-8?B?MkMwbmx4RTJRRlZFdFhhVHlPc09abVUvVkwyRzZVdHBIdHV3UXBhcXVnWFNS?=
 =?utf-8?B?aktMa1VnMGtqVGxHME5kbkQ4M0ZzV1F2bGtuekdkVjRXTmJXcWJQa2xIQkJj?=
 =?utf-8?Q?DGVQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc810130-df77-4c15-0890-08db447fbcd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 04:52:42.2662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEqERwTGl0meIZ6ShxcG/PH6BS8+g95/XlsEbZyA4wYi1Zfztl6gUdPOFsbdx3qUZA+JfGLvSrEUZgvoTAOusA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gRnJvbTogTWFuaWthbnRhIEd1
bnR1cGFsbGkgPG1hbmlrYW50YS5ndW50dXBhbGxpQGFtZC5jb20+DQo+IERhdGU6IFdlZCwgQXBy
IDEyLCAyMDIzIGF0IDg6MjLigK9QTQ0KPiBTdWJqZWN0OiBbUEFUQ0hdIGdwaW86IHp5bnE6IGZp
eCB6eW5xbXBfZ3BpbyBub3QgYW4gaW1tdXRhYmxlIGNoaXAgd2FybmluZw0KPiBUbzogPG1pY2hh
bC5zaW1la0B4aWxpbnguY29tPiwgPG1pY2hhbC5zaW1la0BhbWQuY29tPiwNCj4gPGdpdEBhbWQu
Y29tPiwgPHNodWJocmFqeW90aS5kYXR0YUB4aWxpbnguY29tPiwNCj4gPHNyaW5pdmFzLm5lZWxp
QHhpbGlueC5jb20+LCA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPiwgPGJyZ2xAYmdkZXYucGw+
LA0KPiA8bGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc+LCA8bGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnPiwNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IENj
OiA8c3Jpbml2YXMuZ291ZEBhbWQuY29tPiwgPG1hbmlvbjA1Z2tAZ21haWwuY29tPiwgTWFuaWth
bnRhDQo+IEd1bnR1cGFsbGkgPG1hbmlrYW50YS5ndW50dXBhbGxpQGFtZC5jb20+DQo+DQo+DQo+
IE1ha2UgdGhlIHN0cnVjdCBpcnFfY2hpcCBjb25zdCBhbmQgZmxhZyBpdCBhcyBJUlFDSElQX0lN
TVVUQUJMRSB0byBmaXgNCj4gImdwaW8gZ3Bpb2NoaXAxOiAoenlucW1wX2dwaW8pOiBub3QgYW4g
aW1tdXRhYmxlIGNoaXAiIHdhcm5pbmcuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW50YSBH
dW50dXBhbGxpIDxtYW5pa2FudGEuZ3VudHVwYWxsaUBhbWQuY29tPg0KUmV2aWV3ZWQtYnk6IFNo
dWJocmFqeW90aSBEYXR0YSA8c2h1YmhyYWp5b3RpLmRhdHRhQGFtZC5jb20+DQoNCg==
