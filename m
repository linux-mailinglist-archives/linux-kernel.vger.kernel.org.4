Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836AC60C0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJYB0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiJYBZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:25:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8968A449
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuUMySgg76dmKfWGUATKSd1TRoJo7wT7PA4asg6jEpYwrIILfqSffo9Sqhun2Dq8LZ3OpM0issLxpdyCc8eCnuwQZZe35JzGhrWBXhQ12mRwI0bWCnYhFay3MDOVBe6HqS+k+lgbsArd6HV3/Nie4VS6xioRv7Qv8TI61Nq/Yr+oe+2O2q5BJNinv0uau0ID300H7TUFGiVX8B3dWPoxkcXcYFiIdhwhYhA4PFlJ/Abqud2yYNnBV2AItGp34spjaCREH7P3am/qj1YTAHki6ubxBySEVzEEU4JZWBNPqdvs6Ew7DiP2NKkt6DuBpuce+QpV4ytt+PRJel2OHm54Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64QXKoeT2xSFoSeUFc2WBwcz4yCpUQlpm1NxfJZGiSQ=;
 b=LvA29ZDX3iY43lkaI7AbOzu/dG8itwnzkesGEV2p3esJPmkFtREB4Mx2h7UkSjz2n2+w5rPO95jJZdWl4e5y1VPXJj7LOi0+dIC0jnrtu5R1zi+9i1YfsCYSCgU6pKonRQ2D3JJzzCpIUYAeOcPh0H7wBLqTQZC0EB2+fHlrfHTfU4htkigPPRsXBAgX9Kb/c8fmUUuLHYU86PDTFnI6nNZUMLBg0WO/OIKaZvuVwWg3zG7cvguehACeq1kpV4TCcgIxDM7MWXGAmYnLNFwOkkaqNpUPzYgcsBpfQrozYmnMfob9h4oxlWQquehyMSVuDjrdWj35O9Yy+hzhmf1zFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64QXKoeT2xSFoSeUFc2WBwcz4yCpUQlpm1NxfJZGiSQ=;
 b=PRgz4hVC4Isca5OP30JxehMh6/F1C5WROhEa7rtIgpWXMLfKsHK9yOWMM8PNvygCUlfBxdEoHmM8sbQ9s/2y6IN6CUiMuoIp+tdeQ3H6Miw2I8FM3sjECiRqFUPP/SOobGXrQsX7xLvX+xsMsCb3l+PltN/oMCNuRijTVAEy1WnaSTwiUHnxXNa3foDdht4u2jnAPeXCP3I7wSoPiJDBYqSeHKsbgF56cSuSdcob0ZXYBvJy8IcyYF238cfUK9C82Xf6JIjKGhazogFkBpcz/s3vzaJgfb09wtG+iBydgKK1hJ4T92rxAVq72gNjFyRBA8uEDouoGozKsOGJ4ASbSQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 00:58:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 00:58:41 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Nam Cao <namcaov@gmail.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-tcp: replace sg_init_marker() with sg_init_table()
Thread-Topic: [PATCH] nvme-tcp: replace sg_init_marker() with sg_init_table()
Thread-Index: AQHY5j6u2rPwWn2zHUW7sQTIPjIGtK4eTVuA
Date:   Tue, 25 Oct 2022 00:58:41 +0000
Message-ID: <810f1de0-769c-ce67-4ec6-007ce25acfe0@nvidia.com>
References: <20221022174635.15643-1-namcaov@gmail.com>
In-Reply-To: <20221022174635.15643-1-namcaov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6886:EE_
x-ms-office365-filtering-correlation-id: b4272d57-fe98-4eeb-a0b0-08dab6240f39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3YQoQ1FCOMP+ZIdGdbRsnuZriM8tPhOCIpLG0c7Qs1eh2xdUKsUI13syAdUctYklJu4djNfEgTummytX4mBjBVzFEqXAPxa7QY4KuTM7/Fh30P4IVDRLUvTbvK97YHe+lkeT/h1PSMbRl8zk12MJCyNgI9869VLbGJb+mRTQLSq5WMB9Gt8VrssbowF0bYpE0QL742AcyCPAGtxodH8VGDhgXkEGLjXsRqDQ23fc3q+Pxtd86h4pfr+/JuZhWYlLZC3MxvaMlz13IiKnmTQj0w7qxfkvlGSkr9mUjXmxLDRgkbqDuuVsL6WBLj3w3CbSGhrP5f/6EoLds05hid61OGe+BtdkcFVUPHKQcPoCEdLu1SCz9BUIVBvdor1bIrilz/ZMeIM/s6t5eD0AqkcMXBq/unV+ZbdHOw42+C/n3Jk6UcgqY3vPZd5XgxiTtGsnfqWF/BRCtZAZHE8uls49pAn1N3OPtA7FN3fzZpinjFh2FkSDAzu2Kj3db3xTQOxXfMsRfvlFVAbOjLjDnBjU6UwUC6iFGibNfIKwyNwKGKKFvBOzAgTIV2U3PI5VYPjIBR9bkuypydGNY70g8NnCBUqcRzTa/Lbp9PRCyt3J40cWgTl4ySQwcRK7VDo8TgRtG/EYKY1mb8dpOORIfP1Ny1DK0/6g7r3wBwR8cwSW6DpjtmJN4YPu00fE7wbvVeGGHQrwfU2FuLW3D/XRuWlmjKqJH0qK2SahkEYrxomnUFSvNLjq8+dQQwmOJDkpoDN3+VSMMIgVCoXs/1xp6bEXlJLAQ4dR0yI0q1zBSZsEVKZd+j+xiZF5gVXthExWgaPyy/bQ/HmJVSzx+QTiD5uc3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(316002)(6916009)(54906003)(6486002)(71200400001)(5660300002)(76116006)(66946007)(66556008)(66446008)(8676002)(4326008)(91956017)(36756003)(66476007)(8936002)(64756008)(41300700001)(6506007)(122000001)(38070700005)(38100700002)(86362001)(31696002)(6512007)(53546011)(83380400001)(2616005)(186003)(478600001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzY4Y0dlMHBrUEUxaGtPT3lqZFJZdVhaVUIyTUpkbTlJVG14eGhWcTgzaUxl?=
 =?utf-8?B?VUhuV2hNZDQ4T2lEM1FMVStKT1BlVEVwOVI0YUtCb3Rnbm9POFZ6aSt6ZmZx?=
 =?utf-8?B?MGh6WkNUUHZHRjNSY2RwU2ltZXVOU2tuTnRCcWJNTmZsbytoZWxFYzZNVC85?=
 =?utf-8?B?SElwbmhhQ3IwNnJXTWVwdWNBb1YzaEtETDREUGpVVWlHclM0eUR4Z0UwOWpz?=
 =?utf-8?B?SHlEeWpVYXFFVlNhY1IxYmlES1BPaDhpNGlUbnRIY0Yva0NKcGx5M2Q5TFFX?=
 =?utf-8?B?dHlITjUyYStvc3VIUGQyZzdDbnpzcm9UZFU3QmUrOTk4c252cTViWHVmYU1z?=
 =?utf-8?B?WGJwUFE3Tm1DOUNIanp1QjF1eFZBV1I0cyt5Zlpya1duRFNIVFRaNUgwWGFh?=
 =?utf-8?B?ME1yRHJLWmZzemVraWk1b3FzZ1oySDhXUU4rWUREa2xmUk5yZVB0eVNTR2lD?=
 =?utf-8?B?SERYejhaVnd3NGw2bmhyS1FZSDYrcWtJQUpsc2hCRW9LSWJRd3piOCtuVnl4?=
 =?utf-8?B?eVh1Z1JybkpSUzVaQU5EamJtSGc0a1ZHbTd5L0FmUjhFZVR5a0VNNUxlb0pv?=
 =?utf-8?B?dUlkV0dnR0duQUNmc0lEc3F6ZW02cUh3U1V5MTk2bkJPR1hWdS91SEYxMEw3?=
 =?utf-8?B?SmpWRjZPTFJPbjFuMnBWeXY1TDY1dXdwOHoxcWN2bHRFUTh3NWlwcTlDd2xK?=
 =?utf-8?B?TDdVQjh5YWdnNUJjWkVxdE9Remg0emF2QTJqZDVrQmpIRC9LaVpMdldiRE9M?=
 =?utf-8?B?cFlDanR1eDZjZzRVU1FJZG5oa0JFT3FWQ0NQRmtnL3VoWFpxZGR6VUxYaUpi?=
 =?utf-8?B?bkNucEpkaXZmR3dORnk3VXJzdDgxMlo5dUcrK1kxdXVJYlNlZTB2UVpwQTFR?=
 =?utf-8?B?Q0dMejM3L0d4eGJLZjZORDhXb1IrT3NEbnV3eTYwK0I0RUYzVTgvODRtRnRM?=
 =?utf-8?B?Y3dZT0FrM2xHWW9KTHNNK2JVTzJTRG1BL1grZ1hkMlNudGNSR1Y0bndsSUpK?=
 =?utf-8?B?UXVaWXlWaTlaZnVORUtiUmlVSkVsVkxKcjlnNjVkd3prOHdxY0g1Z2dGSFFV?=
 =?utf-8?B?OG1PZkZFbG1WWVJucDg0a2Zab1dqM0dWWXFBNC9LVlB1V09kYVhIRGYwTnFY?=
 =?utf-8?B?Vzl6ZzFmUzBwcnphR0hQNmJQcTFSc3Y5QTdocXl4b3JwY2ZWRGlWWTJFTWlE?=
 =?utf-8?B?aGlvZGVyM0QzeVF4eXo0S0JjTW1leWZWQ0ZQRkVobXJyUkRWdlNidlM3WTZs?=
 =?utf-8?B?clZETEZwZGJmUnprNEkvbEFreDJaNmNzK1k4SDVPY2orb3BQemx2Z29BVzVp?=
 =?utf-8?B?amtWUUhHNUgzc3M2RFhPcXNEUTV2c1ZxU3hkVTRVdmVyOTZiSkFUby9MeGdq?=
 =?utf-8?B?VnQ1TVU0anVQR3FwS0tuRU4vaDZFRnNPU20vU1o5QmhlOENzSGwySXl4STZy?=
 =?utf-8?B?Tjh3V1dXdDFLNDdQZ0U4cVpRd09keU5peUwvVGFIaytsOVRCWXg0NWxZbFNq?=
 =?utf-8?B?RTBZMEFvRVRGVXN3OVRCU0I2SFRGZ1BlMFd4b2o0WnFzUFQ3V0hOcFg5bWVH?=
 =?utf-8?B?YXQvWC9sTWFKbXo3S1ZBWnNDdU1KU29hd2g4S1A3TElFaHowSVBIWkRYWUg5?=
 =?utf-8?B?R0ZXcjBvMloxZDEvZWhIRk5yYTZmQ2cvUHFNRkt6Z3l4cS90cGFMMk0zcUJr?=
 =?utf-8?B?VzNYNHhtMTFOd2plTk9aU1htQlFxMkZyYisrUm9IRTlaN1JDMUlaVWN3bnVB?=
 =?utf-8?B?dkVvbkpwdjUvQ1RERlljRkRNa2tHd2xUTzVKVkhoMWs2L2p2ZENTamZDalRC?=
 =?utf-8?B?Y0Vwc09GZGFabFNnZDg5aW1OUktLNHJUR09OeUVoR1VOenhqVzdvbWw5TXJt?=
 =?utf-8?B?dGdsTW1MeDZNZ3hVL2kvWTRRcU9nSUhaY29GOFZNVW9PVjBaSnpPU0JHTEhO?=
 =?utf-8?B?dFlyS0g3aWdycldqaWdnRCttL0xFUk9PZGVuUzBDQ2lRT1FZR2FxSURBZzVZ?=
 =?utf-8?B?N2U1cVZlMTN6QXFHV3REVzE4V1QzbVhEQnN2bTVTVS9QVTBLUkt4SllKc282?=
 =?utf-8?B?OEJ2N1NBTUdIUE1LdlNvdHZLalJ6TkpJaTBubXFIT3hqRDlpZUc0cmorTmc0?=
 =?utf-8?B?Mkc5dWN1bFFpdHBMZVRHOVR6VHBLR0NPMlVEeVNCeHVKZWUwaE5zZHBocWlu?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <343CE106A2E2CB4CB688A22DEF2C7024@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4272d57-fe98-4eeb-a0b0-08dab6240f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 00:58:41.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9Sb+hSQ9SdRXDITsWuSXW48OoDO2cgA3Zsge6TjXGFpTIXwb71cI53IxiuRmMdRWBWGfGbrOUvymkfikjrycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjIvMjIgMTA6NDYsIE5hbSBDYW8gd3JvdGU6DQo+IEluIG52bWVfdGNwX2RkZ3N0X3Vw
ZGF0ZSgpLCBzZ19pbml0X21hcmtlcigpIGlzIGNhbGxlZCB3aXRoIGFuDQo+IHVuaW5pdGlhbGl6
ZWQgc2NhdHRlcmxpc3QuIFRoaXMgaXMgcHJvYmFibHkgZmluZSwgYnV0IGdjYyBjb21wbGFpbnM6
DQo+IA0KPiAgICBDQyBbTV0gIGRyaXZlcnMvbnZtZS9ob3N0L3RjcC5vDQo+IEluIGZpbGUgaW5j
bHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvZG1hLW1hcHBpbmcuaDoxMCwNCj4gICAgICAgICAg
ICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvc2tidWZmLmg6MzEsDQo+ICAgICAgICAgICAg
ICAgICAgIGZyb20gLi9pbmNsdWRlL25ldC9uZXRfbmFtZXNwYWNlLmg6NDMsDQo+ICAgICAgICAg
ICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L25ldGRldmljZS5oOjM4LA0KPiAgICAgICAg
ICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9uZXQvc29jay5oOjQ2LA0KPiAgICAgICAgICAgICAg
ICAgICBmcm9tIGRyaXZlcnMvbnZtZS9ob3N0L3RjcC5jOjEyOg0KPiBJbiBmdW5jdGlvbiDigJhz
Z19tYXJrX2VuZOKAmSwNCj4gICAgICBpbmxpbmVkIGZyb20g4oCYc2dfaW5pdF9tYXJrZXLigJkg
YXQgLi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0Lmg6MzU2OjIsDQo+ICAgICAgaW5saW5lZCBm
cm9tIOKAmG52bWVfdGNwX2RkZ3N0X3VwZGF0ZeKAmSBhdCBkcml2ZXJzL252bWUvaG9zdC90Y3Au
YzozOTA6MjoNCj4gLi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0Lmg6MjM0OjExOiBlcnJvcjog
4oCYc2cucGFnZV9saW5r4oCZIGlzIHVzZWQgdW5pbml0aWFsaXplZCBbLVdlcnJvcj11bmluaXRp
YWxpemVkXQ0KPiAgICAyMzQgfCAgICAgICAgIHNnLT5wYWdlX2xpbmsgfD0gU0dfRU5EOw0KPiAg
ICAgICAgfCAgICAgICAgIH5+Xn5+fn5+fn5+fn4NCj4gZHJpdmVycy9udm1lL2hvc3QvdGNwLmM6
IEluIGZ1bmN0aW9uIOKAmG52bWVfdGNwX2RkZ3N0X3VwZGF0ZeKAmToNCj4gZHJpdmVycy9udm1l
L2hvc3QvdGNwLmM6Mzg4OjI4OiBub3RlOiDigJhzZ+KAmSBkZWNsYXJlZCBoZXJlDQo+ICAgIDM4
OCB8ICAgICAgICAgc3RydWN0IHNjYXR0ZXJsaXN0IHNnOw0KPiAgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBefg0KPiBjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFz
IGVycm9ycw0KPiANCj4gVXNlIHNnX2luaXRfdGFibGUoKSBpbnN0ZWFkLCB3aGljaCBiYXNpY2Fs
bHkgbWVtc2V0IHRoZSBzY2F0dGVybGlzdCB0bw0KPiB6ZXJvIGZpcnN0IGJlZm9yZSBjYWxsaW5n
IHNnX2luaXRfbWFya2VyKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOYW0gQ2FvIDxuYW1jYW92
QGdtYWlsLmNvbT4NCg0KTG9va3MgZ29vZCB0byBtZSwgY2FuIHlvdSBwbGVhc2Ugc2hhcmUgd2hh
dCB2ZXJzaW9uIGlmIGdjYyB5b3UgYXJlDQp1c2luZyA/IG15IHRlc3Qgc2V0dXAgZGlkIG5vdCBj
YXRjaCB0aGlzIGVycm9yIGFuZCBJJ2QgbGlrZSB0byB1cGRhdGUNCndpdGggdGhlIG9uZSB0aGF0
IGNhbiBjYXRjaCB0aGVzZSBlcnJvcnMuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
