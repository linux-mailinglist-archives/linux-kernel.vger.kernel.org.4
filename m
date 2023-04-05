Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F086D7FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbjDEOkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjDEOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:40:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1591BFB;
        Wed,  5 Apr 2023 07:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKWELvnkb6BBDOvEjvkusI75qdajpD4Rm8cYrmd6IIzAVgZ3Sc4AIq9GKcE9xHZ4d8X9YiAVop4lpBwUJDfFcg4e4+SgYWWI3ZbgVQX3MN7n07QZJWe579dOY4glI6govgdrr3ROSAD5tAcSFlpPcM5Jo/m0W6MaZ/r0K/RlzxOeAGBjcrSy9XMTbfNU+dUTBF43Gv8mOimxBTRl+uSsuLTxoPWrzcPl1plLMjLwf0k5VCSWc9f534FRIXQXbAcnaWuNYkjmA5HN4yb7axjoN02cynscPIV3fziyrjHYIHDbzXCftR6eMKBjpkJ4HdydYHJjupUjZxJdWyftLfmBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSvjzUiaSb4X5/1it3S+ib0ucwEpzPYba2hX15IVi2M=;
 b=nKb+kHBgoDhM88TmdwhK2yyrnMk/q2cFs58UuT3Vg9NEs8ndxZ5egO7VKd+FfpgHwP4zRybewRkgYwR5cUyKST+hFb0PW6Sk92YJ/N257rwz2uKTvpG4Ml6thcs9QhNjiVaklbdF/KX++w10Pp2ukhT/oHV6ZwX1v91axUQI60+5vLr9YnBXak0QXRl5mR1/BzIjqr6/qxOKqLOHUFxlMPs877ON+UbYwALKCAPwU2R7NXijnZnB/pU1RHES7/e/gkQEi0S+6ydoc+dSzT9w46nra61lMEgVzAkZ5K+RXYm8nilALFfnsPvHOp/DAU3eSSwDqH9NifgiHNcdojoPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSvjzUiaSb4X5/1it3S+ib0ucwEpzPYba2hX15IVi2M=;
 b=UtLNjhg009hFYWD1RRxWXN8Up459M02fpSJ6ep3l0YBSif2+vUvcdpaj49PufNXYODBXiigPQPqW7/bHhkl+Q9ZhIh8wipjSSjUvGOCRgHHG9EC0WkCntExiSTKWONxT0VFon8paqizsq18miTx69BxxKLhl96GIfZ9oc1kpT6iorns/fsEOsylxTXEvy233sISAmPt/1kZsh6GPh32AaH0X87rlCORVRnRcYlo0DwsGtUVhFQO4PmpcFLAG8UkwyKz2hwWvun+3C0or1aXjTlvC4Y2MyueXnGLJAIi0oYdyimVdmc4C84JeLf6a5iAOnlU8l84E18Oikb2fcxntgg==
Received: from MN2PR12MB3616.namprd12.prod.outlook.com (2603:10b6:208:cc::25)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 14:40:36 +0000
Received: from MN2PR12MB3616.namprd12.prod.outlook.com
 ([fe80::ed6d:b467:7f58:1207]) by MN2PR12MB3616.namprd12.prod.outlook.com
 ([fe80::ed6d:b467:7f58:1207%6]) with mapi id 15.20.6277.030; Wed, 5 Apr 2023
 14:40:36 +0000
From:   Khalil Blaiech <kblaiech@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        David Thompson <davthompson@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1 RESEND] platform/mellanox: add firmware reset
 support
Thread-Topic: [PATCH v1 1/1 RESEND] platform/mellanox: add firmware reset
 support
Thread-Index: AQHZZ8uOwSrN4makrUqnlN0I4y2l4q8cx8QAgAABpwA=
Date:   Wed, 5 Apr 2023 14:40:36 +0000
Message-ID: <MN2PR12MB3616910645B1BDDDDC5B823DAB909@MN2PR12MB3616.namprd12.prod.outlook.com>
References: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
 <7ec19101-0288-71e1-cdca-cfe7acbbe0e9@redhat.com>
 <8f33b1af-ffcb-9eb2-9294-9b3c5e4fee33@redhat.com>
In-Reply-To: <8f33b1af-ffcb-9eb2-9294-9b3c5e4fee33@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB3616:EE_|MN2PR12MB4376:EE_
x-ms-office365-filtering-correlation-id: 3cc1f093-4878-41e8-fd68-08db35e3b816
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2RSGQxSCAIrNUvv+aVfg6qb+L6JJOIPmrQw/Em6cCD2v3rGiVyz+AvKCuYw5wOnii+iqWbIjWlPsCo+in5G1o7gHNZmlyJ2cytMjBp/gaBit4iQkSv8cQfOD3LJUnN3rKQP7oaLFjRhCCj/8u/H+uvgkoQxnobbgzbLLyyWY1z8hN7fkg2dqnhiGRGObHxiTNQ74NHSAZLrzA6ErIvbTe7riGsYvArMTPpI90dAJ7HplUC0Qt3a+miM1z8eQDc2Ig/1rI/NKfUlR0PAXp7NJhwohh+ci5cyJLcuVZMk2yR54z3icw4wsACyfTL0nRcnQsOG7B8EkfjpbOK/MiV4dTZvWle/tQb9mmuYcdX+PHr+U90Y+BT1JH0lXmgnjt2/VFGUd2jYpsdGOXTTRqnV/KCq6EzpfZCjNDI3tMDPgff48cFJNZm8zUXB58s5gsTBrZyqmokD6sFwsTrOYtsIanElhuVk+Shl+ZObQ7EzjfQoJ2zzPRoLzffHIsohu486kSBjJpmnNj/gvRU7UZuKEHyRvWKLZhZGqp3g2PzYaozY9WjY+vvMQkCAp/7WozU7HlPq/c9pVtMKhOqt+9s3svs+pTJZbwhGPdLl5B1TPK7ONoJrWqNHqfhcw9n6UgO+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3616.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(71200400001)(7696005)(83380400001)(55016003)(33656002)(38100700002)(38070700005)(86362001)(122000001)(53546011)(6506007)(9686003)(186003)(54906003)(110136005)(316002)(2906002)(6636002)(66556008)(64756008)(4326008)(66446008)(8676002)(66946007)(76116006)(66476007)(8936002)(52536014)(5660300002)(41300700001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWhGVjcvaTlxR2tDRnpHNHhpaWJXcnlZSHBZdGJjbHJDcm5pa2VpS2lBckVy?=
 =?utf-8?B?SElSRWZHV29hTStvUjB6aEJDYlppc25OQ0lrNCswL0FrWjBiV0VmTkh5Z1FT?=
 =?utf-8?B?cjgrZzhSVzZoaUVZOU1DMU9IS0U2Qlg5dE9zOVV6cEFxNjdTb29WbnZVQlli?=
 =?utf-8?B?cVlLNmE5VWMwTWk3UWl1V05ReGtRY2F5eURpRGFEUityUlFTWHl0K0hKRHRX?=
 =?utf-8?B?OUU2MFFzR2w2RVRFM2ZFRFVId0ZKbUUxRFBSc082ZDJUbXZOYk1RSmdoZmRx?=
 =?utf-8?B?ZWExMldwTUVwcklFUW5WQkEycFg3ajRoOTdUWEJOL09CM0laN1FQNkZ0UHF5?=
 =?utf-8?B?cldwRkJTYkhpNkk2d2pYc3U4am16bmVZc2FEQmRHaWlnSDFac3ZJN1N1M09U?=
 =?utf-8?B?SnhjRkZEczMwb21PNWMvZlFCRWtGRUhEUXhDQVE1aG1OcHhvWHlwcEVNZS9p?=
 =?utf-8?B?aVFnWlBCSSticzByYy83Zis5dG1tcUR4MkhKdk4wa2pwVExaODYveHhZcjVT?=
 =?utf-8?B?cmJZb0Q3T2gvcWZtTElDWGZGS3BIVmhSQ1BEZGw4NkxTc1pYK2VlS2ZmZjJQ?=
 =?utf-8?B?dDdpRCtSUUdPc3gvYnEzVit1UU94dEpCV1ZUVDA4UDBNRmdzRFZ4dlFoaVJH?=
 =?utf-8?B?Zy9wUmhaUnBuS0NkN21oWTE5NEF3ZzlHOFNDNkp4aktJNmtzeXMyWk5qNTdG?=
 =?utf-8?B?TDE0dGRlbUdFQ0Y3UEFyaXo1QzcvRU9KTlk2ZndDdE0rK1VGWmxYRUF0c0xI?=
 =?utf-8?B?aXZNbU1Pa1plTDVmZmJnTnE4bjF6NTZqNzhac0dmZjljUWZhL2xESmZraTM4?=
 =?utf-8?B?dDJrYWdiM3U1M3R6Y2k0YjlVU3lEN1dpcEpweVBsODRxREFIdm1WbFB2TVV0?=
 =?utf-8?B?RlJMRjdDdDJUUURXeUpYN2h6TTdQa0IxVEdYY0xaeXJxVy9hd0p6K2ZsVVFE?=
 =?utf-8?B?TEFsd1diZ21PV0Q5eitrTWIyVHU2a2lUSXdmeENkVVpzUTRrZGtRQ0pITHg2?=
 =?utf-8?B?U2RMNnpLVHVGV2F2U1Q0ZDNvTjE4bW9QemJsL0d6QmdIZ0Q0Z2ZnZ1lkWFZV?=
 =?utf-8?B?Q0pVcTlYS3hIZ3krVmhTSHJFQngwMHcvWXkwcHlhdnF4dHlCOGtZZENRT2tX?=
 =?utf-8?B?MXZBcHNBcUM4OTZmS1oyVWJqeHdUVUlDamFTcnk3U09wZTJPV1VJZWhHWGk4?=
 =?utf-8?B?YUh3VnA4dXNyUGowOFN4WWlsQk9GVGl4M2MreE1IanE1MVpCUXkvR0tYOWZr?=
 =?utf-8?B?czArcmFrZzN1UEp4SFFVY3R6SjVzMUtId0VTOUhocERTd1ArNEtzNUZwSUNS?=
 =?utf-8?B?S2dYMjdCUmpkWFBTT1FmMzZWQmxHMmUwUnBpK1JzdkEzaVp0WWpMcExXRHpz?=
 =?utf-8?B?aFJBUHVFb1AraEJMbjU0VVB0SVRhWmU5MFgxZk92RkF2dDFCNWlVVE5rUGtn?=
 =?utf-8?B?UXFWSEZWUzBURFg2TXpzY1FlSllIV1c3ekRLV1pRaXNvRFIwL2t5ejhYaWRy?=
 =?utf-8?B?eUtrbEFoRG5oK2NIRFVwYm1SYW1uS000eUxCNUFQVU5veCtOWWw5c2oySjVj?=
 =?utf-8?B?Zzc5cGRVSE1KWFpRYi9GSjlwcXA5SkIyYzRsVDFJOTFsVWpEU1UwQjdQa1pH?=
 =?utf-8?B?SHJySTdFOVk0Q3FsRkRHUEtiSmpjUmd2NmxTWCtpQnNqc1NIZkUvRWp0cFQy?=
 =?utf-8?B?YUloTWJTaDY4Qld6enFFdWdxbzJHZ3hCNGREMi9OWmtrY0ZKUURmMGRETFlO?=
 =?utf-8?B?aTFhZE5EczhDYk5iVGFiWUs3bVAwQmQ4LzNSczJTb2RCQk5UdmVBN0hoQXcy?=
 =?utf-8?B?TlQzdkRPNzlNTGtHUUx5R3FNRTd6dGFjdnA3QkNBa3gyNW5rN1pIV2ovbG1o?=
 =?utf-8?B?S3J6UFBObnJKd1pveEhCcmlZQmR3RzBwSVovZTN6Q3gxcEFpWVVDL1FKcjBm?=
 =?utf-8?B?QU0rekZjRnoyZUpLaFZIMDZ1aUl3cURob1lvakhWYWJBaFh3RmZFcmp3THVl?=
 =?utf-8?B?MjFKZktlSHJyeUUrMmdUUi9UQysrK01Hc3FndnVGcUFDMDltSGxNQ096bnpm?=
 =?utf-8?B?NCtrOGxCbXBoQ29PQkpQYnhrL2NIOTljUXE4b1VGWEJCTHdLSFVkYTRIWlVF?=
 =?utf-8?B?eG9wdWJaZEZUbDZZeXBZUEJZU0ZsWDQyblVYanB4MGh1TlpMUWhlcmhxU2Nw?=
 =?utf-8?Q?DM0w+n8lNgPShGEd9+4Js7UnbKZvA+IAUXzLpW36tMXT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3616.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc1f093-4878-41e8-fd68-08db35e3b816
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 14:40:36.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goQJJEEqqanpU4c3I9ue/1SaktqLVWqe5NGdE4XzIHtCEm0xXDkcpPzmM8zREsKg/kZEgRJGRhot8rRG/P341g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VW5kZXJzdG9vZC4gQW5kIHNvcnJ5IGFib3V0IHRoYXQuDQoNClRoYW5rcyBIYW5zDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRo
YXQuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgQXByaWwgNSwgMjAyMyAxMDozNCBBTQ0KVG86IEto
YWxpbCBCbGFpZWNoIDxrYmxhaWVjaEBudmlkaWEuY29tPjsgbWFya2dyb3NzQGtlcm5lbC5vcmc7
IFZhZGltIFBhc3Rlcm5hayA8dmFkaW1wQG52aWRpYS5jb20+DQpDYzogcGxhdGZvcm0tZHJpdmVy
LXg4NkB2Z2VyLmtlcm5lbC5vcmc7IERhdmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBudmlkaWEu
Y29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2
MSAxLzEgUkVTRU5EXSBwbGF0Zm9ybS9tZWxsYW5veDogYWRkIGZpcm13YXJlIHJlc2V0IHN1cHBv
cnQNCg0KSGksDQoNCk9uIDQvNS8yMyAxNjozMywgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4gSGkg
S2hhbGlsLA0KPiANCj4gT24gNC81LzIzIDE1OjE2LCBLaGFsaWwgQmxhaWVjaCB3cm90ZToNCj4+
IEFkZCBhIG5ldyBzeXNmcyB0byBpbml0aWF0ZSBmaXJtd2FyZSByZXNldCBpbiBpc29sYXRpb24g
bW9kZS4NCj4+DQo+PiBSZXZpZXdlZC1ieTogRGF2aWQgVGhvbXBzb24gPGRhdnRob21wc29uQG52
aWRpYS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBLaGFsaWwgQmxhaWVjaCA8a2JsYWllY2hAbnZp
ZGlhLmNvbT4NCj4gDQo+IFdoeSBhcmUgeW91IHJlc2VuZGluZyB0aGlzIGxlc3MgdGhlbiAyNCBo
b3VycyBhZnRlciB0aGUgaW5pdGlhbCBzdWJtaXNzaW9uID8NCg0KTmV2ZXIgbWluZCwgSSBzZWUg
eW91IGFkZGVkIGEgbWlzc2luZyBDYzogcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5v
cmcNCndoaWNoIGlzIGdvb2QuDQoNCk5leHQgdGltZSBwbGVhc2UgYWRkIGEgbGl0dGxlIG5vdGUg
dG8gdGhlIHJlc2VuZCBleHBsYWluaW5nIHdoeSB5b3UgYXJlIHJlc2VuZGluZyBpdCB0aG91Z2gu
DQoNClJlZ2FyZHMsDQoNCkhhbnMNCg0KDQoNCj4+IC0tLQ0KPj4gIGRyaXZlcnMvcGxhdGZvcm0v
bWVsbGFub3gvbWx4YmYtYm9vdGN0bC5jIHwgMTkgKysrKysrKysrKysrKysrKysrKyAgDQo+PiBk
cml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuaCB8ICA2ICsrKysrKw0KPj4g
IDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuYyANCj4+IGIvZHJpdmVycy9w
bGF0Zm9ybS9tZWxsYW5veC9tbHhiZi1ib290Y3RsLmMNCj4+IGluZGV4IDFjN2EyODhiNTlhNS4u
NWU0MWMyNzAxOTVjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9t
bHhiZi1ib290Y3RsLmMNCj4+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYt
Ym9vdGN0bC5jDQo+PiBAQCAtMjQ0LDExICsyNDQsMjkgQEAgc3RhdGljIHNzaXplX3Qgc2VjdXJl
X2Jvb3RfZnVzZV9zdGF0ZV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+ICAJcmV0dXJuIGJ1
Zl9sZW47DQo+PiAgfQ0KPj4gIA0KPj4gK3N0YXRpYyBzc2l6ZV90IGZ3X3Jlc2V0X3N0b3JlKHN0
cnVjdCBkZXZpY2UgKmRldiwNCj4+ICsJCQkgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAq
YXR0ciwNCj4+ICsJCQkgICAgICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkgew0KPj4g
Kwl1bnNpZ25lZCBsb25nIGtleTsNCj4+ICsJaW50IGVycjsNCj4+ICsNCj4+ICsJZXJyID0ga3N0
cnRvdWwoYnVmLCAxNiwgJmtleSk7DQo+PiArCWlmIChlcnIpDQo+PiArCQlyZXR1cm4gZXJyOw0K
Pj4gKw0KPj4gKwlpZiAobWx4YmZfYm9vdGN0bF9zbWMoTUxYQkZfQk9PVENUTF9GV19SRVNFVCwg
a2V5KSA8IDApDQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsJcmV0dXJuIGNvdW50
Ow0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgREVWSUNFX0FUVFJfUlcocG9zdF9yZXNldF93ZG9n
KTsgIHN0YXRpYyANCj4+IERFVklDRV9BVFRSX1JXKHJlc2V0X2FjdGlvbik7ICBzdGF0aWMgDQo+
PiBERVZJQ0VfQVRUUl9SVyhzZWNvbmRfcmVzZXRfYWN0aW9uKTsNCj4+ICBzdGF0aWMgREVWSUNF
X0FUVFJfUk8obGlmZWN5Y2xlX3N0YXRlKTsgIHN0YXRpYyANCj4+IERFVklDRV9BVFRSX1JPKHNl
Y3VyZV9ib290X2Z1c2Vfc3RhdGUpOw0KPj4gK3N0YXRpYyBERVZJQ0VfQVRUUl9XTyhmd19yZXNl
dCk7DQo+PiAgDQo+PiAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKm1seGJmX2Jvb3RjdGxfYXR0
cnNbXSA9IHsNCj4+ICAJJmRldl9hdHRyX3Bvc3RfcmVzZXRfd2RvZy5hdHRyLA0KPj4gQEAgLTI1
Niw2ICsyNzQsNyBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqbWx4YmZfYm9vdGN0bF9hdHRy
c1tdID0gew0KPj4gIAkmZGV2X2F0dHJfc2Vjb25kX3Jlc2V0X2FjdGlvbi5hdHRyLA0KPj4gIAkm
ZGV2X2F0dHJfbGlmZWN5Y2xlX3N0YXRlLmF0dHIsDQo+PiAgCSZkZXZfYXR0cl9zZWN1cmVfYm9v
dF9mdXNlX3N0YXRlLmF0dHIsDQo+PiArCSZkZXZfYXR0cl9md19yZXNldC5hdHRyLA0KPj4gIAlO
VUxMDQo+PiAgfTsNCj4+ICANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL21lbGxh
bm94L21seGJmLWJvb3RjdGwuaCANCj4+IGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhi
Zi1ib290Y3RsLmgNCj4+IGluZGV4IDE0OGZkYjQzYjQzNS4uYjQ4MjQzZjYwYTU5IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi1ib290Y3RsLmgNCj4+ICsr
KyBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5oDQo+PiBAQCAtNzUs
NiArNzUsMTIgQEANCj4+ICANCj4+ICAjZGVmaW5lIE1MWEJGX0JPT1RDVExfR0VUX0RJTU1fSU5G
TwkJMHg4MjAwMDAwOA0KPj4gIA0KPj4gKy8qDQo+PiArICogSW5pdGlhdGUgRmlybXdhcmUgUmVz
ZXQgdmlhIFRZVS4gVGhpcyBtaWdodCBiZSBpbnZva2VkIGR1cmluZyB0aGUgDQo+PiArcmVzZXQN
Cj4+ICsgKiBmbG93IGluIGlzb2xhdGlvbiBtb2RlLg0KPj4gKyAqLw0KPj4gKyNkZWZpbmUgTUxY
QkZfQk9PVENUTF9GV19SRVNFVCAgMHg4MjAwMDAwRA0KPj4gKw0KPj4gIC8qIFNNQyBmdW5jdGlv
biBJRHMgZm9yIFNpUCBTZXJ2aWNlIHF1ZXJpZXMgKi8NCj4+ICAjZGVmaW5lIE1MWEJGX0JPT1RD
VExfU0lQX1NWQ19DQUxMX0NPVU5UCTB4ODIwMGZmMDANCj4+ICAjZGVmaW5lIE1MWEJGX0JPT1RD
VExfU0lQX1NWQ19VSUQJCTB4ODIwMGZmMDENCj4gDQoNCg==
