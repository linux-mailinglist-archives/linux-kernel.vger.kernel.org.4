Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1DF5F49D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJDTqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJDTqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:46:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7555A3E3;
        Tue,  4 Oct 2022 12:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XffBE5JmM07LB4iabUDhqqDkzhmYcHYYVs1S2NKkLaP0uA2H+UQ+g00zJAj0eK8EQLNv/mVju3eT9FpsrdIocgLUkcIhO4OaBuGfDkcDApv4JoI/mXQX68k2BCnTrblVZMYL3NqDqFZOx0AcTwKVohKtxasSHzATHH7Uj9+huxeitcqXebnRJzKz+mUrTGN7dbXPHaCaBFGMHjPHETT2fAG6KMx2v1jjgnxVXL0Fm/W2Tqjbv98CikGdKDgC+OplUBvspBl+FLP+g0+nNzzi5zlJf7sN/hhQOaQIu4VYnO8U+iApiUwvhmo1E2D9DJ4bzm3RLvORIaWNe5IK7fK2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUfKSP8M4gxKbDGwhLjKnTbuL6oCuSVCWZIPAGrCZ+c=;
 b=FTtT1LztJqIF5nVwH3DwPLxc7BhPXNpfR0pHWiLmAiGcKhmQAFF+2awAUGAQ/Kc9rvA3dd2sIXqIDSiTW2pILuDx99Sjsec5YipHKzbK+HuZfSb/uRyeiD/nN9wl3CsUtMf5ddQhynjk4NMJ4DyBr21qSonS+pohIxR6Phzq75hJ4L5/y2SUeehuNqDoh03shguWMmN9nnviwqNn/w8ys9eb1WxUWuULY4yvcUycLHfbOy5fWVboXw+Swskc6TX8Q6uYL/3Vzs8o4NyD6b7lQ/f7GxPTPPmMjaYY9Xmb2A1Br2+6tCDk7G7/RwpQUZ0HR3LMOnkCEes6hIzW6zuHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUfKSP8M4gxKbDGwhLjKnTbuL6oCuSVCWZIPAGrCZ+c=;
 b=c62emoz4H8LvldurTk79sqsNnQm3QOy33RAy1eHJ8DZ71uzAno6GMu1Pt9gGxz4PqKeyv6ObICwKroe2PCBtXpVFzOq6HoREhfu0w9nfLzdnohd2eyQunPrr7PF73Wkh1meWiE21zKoD3DmqWvUEViNGqvsboD80dOKDD73DZN0=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.35; Tue, 4 Oct
 2022 19:46:39 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::b9ee:95e9:e8aa:7853]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::b9ee:95e9:e8aa:7853%7]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 19:46:39 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Brad Larson <brad@pensando.io>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 10/17] arm64: dts: Add AMD Pensando Elba SoC support
Thread-Topic: [PATCH v6 10/17] arm64: dts: Add AMD Pensando Elba SoC support
Thread-Index: AQHYtM9B9PbNXj7Y7kSeDaz8sHAff6330ooAgAcX4AA=
Date:   Tue, 4 Oct 2022 19:46:38 +0000
Message-ID: <f830501b-1e63-e84f-d5a9-13ad6d8d1005@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-11-brad@pensando.io>
 <6f9f031b-4d75-de1c-e9de-5aea8d4b8ba1@linaro.org>
In-Reply-To: <6f9f031b-4d75-de1c-e9de-5aea8d4b8ba1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2401:EE_|IA1PR12MB6434:EE_
x-ms-office365-filtering-correlation-id: dc8b8b39-5d52-463b-6811-08daa6412760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJ8oy1cikpO+oRUddsDwSfMAnAlgFmuWeoAi75EG/HXavZZm8iQjysiwGrOsTCipc9DtHg8wlc5GxgsueTvTHg1ItpRSXy1giMKRBDRuI6pztNpMyJbaV3vUDfxZ0agD/fMqrmKeh0fxmiwtybuAYepS7Q/tGGkHfJCg7T9BoEOA6WgkJls/GNhkGQ0oFLPU/qtsuWiE/lHuao0EC4IHGcoaYy9igG5JTj9lBzo+KgV4Gz0YmVL2t5sEFpiDmDpvoAcVbTO6O6hLGCchlZYJyOnQCngVRPn50N7GFnL9ataGSTg7LrNAM1Y5m1B1bc+QsRCc52+YkcAu/zUZdPVFCyH4A4pFqOIxz8B7J2OBqBKSXADt50moxXXoibj/6scAY8/29SmrhLnqm0yUNVfFjuzlUQNOHN4btNaECUz5950J0wmMTYRWu4UpWkTebjOpjJL/VZVtzpL7++wryrLGoMt2NWEQ+2MjqSFDLVEsmz2gvvLwu943Z7cAWGE84kYSwLDr7RFuqKMhRvPJcn+hg/GCKG72R84Yuhmtf9kAtf4IG4gZBefDlzUHYs8hJcijMrsUPe6cTYSF2rA8ZB8OdmFlSjCXDV83sYY2LSvOH5HKcCTXzt5iMbuquklcPJq4zTHmiv8S4JXiVfCXG2j4OR4PDwtsgGz/CBuA7d2tlVCjs8BR/swiCoEYam2QHsaYaJsHiib8GM8qvFbhmT4/K+u+Fx4R88Ds0W2qtp+Mw/vJrPNmnnibqOue1HtV1xoBnyFM0lvNvgw7yeuM4XyyQzTgBMO96LxzTrXpU5n56Wk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(36756003)(31686004)(38070700005)(2906002)(7416002)(91956017)(41300700001)(8936002)(5660300002)(122000001)(76116006)(4326008)(66446008)(66476007)(66556008)(38100700002)(66946007)(64756008)(8676002)(316002)(54906003)(110136005)(86362001)(26005)(6506007)(6512007)(478600001)(83380400001)(71200400001)(186003)(2616005)(6486002)(53546011)(31696002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkYrVFdmeTdYY29rTmNadGpxNjlFSHJWekIrWGpBeTBCSCtYV1RWNW14V0Ry?=
 =?utf-8?B?SWFYdTlPanhJK2NjVy9LSmNoS1VlUWdySTdObzBRaG82YWpFOThLYmVNdktT?=
 =?utf-8?B?dWM3UE5xcjV4VzFxMzA5SG5zQTFjS1hWaDFTcklHb0NCRUpDeUNYS2l1ZEEr?=
 =?utf-8?B?cDVyNlZEcmFPZmVqdVQ4RmNuYlZ1L0FrNkF5cnNhUU1mKzdNSDljNWxyMy9h?=
 =?utf-8?B?R0FVNUVabUE3UUhNNjNOamR3dmJUb0VKR3NuRTBSNXd0RG5LNkRjUmF0OS94?=
 =?utf-8?B?MkcyQnV4V01VSkVzdnZpMHQvNC9WMEJyNnNOOTEwSWdNcUpTRnhRa0gzRUpv?=
 =?utf-8?B?bHozbmpjalRUSFRUNnZCcUtCRklzZ011OGVpT29MWGpMMGE0emd3eEZqc1Nt?=
 =?utf-8?B?YUdVVDk0SUd3d3RFQTBDMU0xYnNOc1V4dmxCY3pqWjV0STBWNWI0NzZ1WVV2?=
 =?utf-8?B?dTJleWErQXZBQk4zbWJWQzRvaGpzWmt6cy90RXpTRDY1OVEzb2NjeFNmc2Z6?=
 =?utf-8?B?NE1vRWczTm9HdHRYb2p2YTVUU240dDhNQW1tSGtPbnpQb2tmWkMrZXJ1UkhW?=
 =?utf-8?B?eDFCaU5nMUpJQWRWdThnZU1UNkNBLzMzVGtpQTJmRnJmdUdnTndSUWpWUFN2?=
 =?utf-8?B?VDROSTI2TG1vYkJNYnpHOUpMWUZ3UEl4TjZFcU93WEFVM3liSjdhZGd0ODM5?=
 =?utf-8?B?eFN5WHFucWJpRklTM0NXS1dnd1NBbENZMmt4dlo5Rno4dFFRUGFpdFF1bEcy?=
 =?utf-8?B?ZG1oMDZqMUQvVlVxWTlDdDR4UGo2NVJPdDRBV0Mrbml5SE8vdUNKWWpvSWdW?=
 =?utf-8?B?UmZPWWhTUEorQlU5TlNJZmErRTJTaU9lUXdhczBRWnZVR1lWejhlYkFrSUhh?=
 =?utf-8?B?Z2NqWHBUSDdZM2dsMkx4SHlzbHlzM1h6YVRiMk1NZDR4TW5UVmdrQUI2RXBj?=
 =?utf-8?B?ajBha00xeDNra3doMkZucytpQ0FNNi81YStLNk02YkFmOVRXWXJHRlQxZGlR?=
 =?utf-8?B?SHZyWHNxWmZ4dnRzS0E1cEVCaE5rV01maUZ3aWtqL0VjV0lJV2p3TWdhR1ZM?=
 =?utf-8?B?Rm9Rd3kxRFNyQ1F1ejVjMXpaTmVxcENEM1l2T1NLWTAzdUVQQTdVVWs1MUgz?=
 =?utf-8?B?MUZISnBSc21LN0JINXJaU3ZYamhHa21KVksxY1pXajBaYWkzV1lNSnZ3SmVO?=
 =?utf-8?B?elh0ZlJiblhiUHU1RTI3cllvb1dsazNkZ2VYTzlFdCt1V0pKcm5wN3ZpUEZZ?=
 =?utf-8?B?cmoxZS9rOUFRc3IwUStXWVltUkV2TGEvMkJDOG5pOU80Tm9OMFdSZk9LSFk1?=
 =?utf-8?B?MDMvSmJIaDFqVSthOS9lOHU3d3FKMk84VThwclM3NGcwVElXU2FKbGUyeGsw?=
 =?utf-8?B?bmRxSWJGTVJpZXZ2b1VIbE0xQ2RoQ2xoYzVFMEtGb0NKRlEwakJJZFNjS3FK?=
 =?utf-8?B?aWxMVGkrUlNxNGxPSWNYQnpwazN6UHRxUWl2Y3hZYk02WmR0WmNVRGJ1NHEr?=
 =?utf-8?B?cE41eXozU2ljb2dkSjhlV29kcERZTmkwZURTSk8vN2Eya2xlNzk2UldJZXhY?=
 =?utf-8?B?UkIwNkhRQ0llclo3M242eGgyN25uU3Y4TUZlamZubUdlNllrM2VwN0dCdmVE?=
 =?utf-8?B?SDFiZTlrUnNad0ZCNGVwbkUzRG02MGtDcXowVWl2bGNMaGg0M3ZweDJUMmp0?=
 =?utf-8?B?bDJnSHdRTjZPT1FqaUkrcDdtc0h0d3RwQTY1UHVXUUgxZ0RockdxYW5ZZUEw?=
 =?utf-8?B?cFpIUTFPU3lLUDg3am1MZHk2UG1jTTJNU3hRbkM2bEc0Y1IrYnFOeCttRVFR?=
 =?utf-8?B?S21sMlZzRVR6TjJZR1J2b3ViU1JpUU5vUmV2dWtYd25nejgwcFNhWjBKNGVF?=
 =?utf-8?B?SjhLZmMvajlYQ2QwTUhOelRGd1JVS3lmS2ZwKzN4aTcvMEQzSVpMVjZBbTNV?=
 =?utf-8?B?UHIzQnluWXdWK2xOR3lMUmd4cGhHVXFCSHZHUEVRcnBLNk4wRGpBUW5Ecm1Q?=
 =?utf-8?B?WGZHKzBUVlRvaGhNRDZDK0dpcjhOTTNGNWJVVk5LQmx5Tkg5U0thUk81dUkx?=
 =?utf-8?B?Vlh1aWluSHRrY1Q1WkpIRU1McTRyc2xYbmVsazZVYVZCK1JNNEY1M1Z0eTJV?=
 =?utf-8?Q?bD/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47DA838AC299AC4C8B753F12C33F0A33@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8b8b39-5d52-463b-6811-08daa6412760
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 19:46:38.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrQzmAnzEE6icqcJCh4bN/XmpfoVlFT5HLUadcuSO0unmipooOotO7CSWyttJofu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8zMC8yMiAxMjoyNyBBTSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gQ2F1dGlv
bjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBw
cm9wZXIgY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBv
ciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiAyMC8wOC8yMDIyIDIxOjU3LCBCcmFkIExhcnNvbiB3
cm90ZToNCj4+IEZyb206IEJyYWQgTGFyc29uIDxibGFyc29uQGFtZC5jb20+DQo+Pg0KPj4gQWRk
IEFNRCBQZW5zYW5kbyBjb21tb24gYW5kIEVsYmEgU29DIHNwZWNpZmljIGRldmljZSBub2Rlcw0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IEJyYWQgTGFyc29uIDxibGFyc29uQGFtZC5jb20+DQo+ICgu
Li4pDQo+DQo+PiArDQo+PiArJmFoYl9jbGsgew0KPj4gKyAgICAgY2xvY2stZnJlcXVlbmN5ID0g
PDQwMDAwMDAwMD47DQo+PiArfTsNCj4+ICsNCj4+ICsmZW1tY19jbGsgew0KPj4gKyAgICAgY2xv
Y2stZnJlcXVlbmN5ID0gPDIwMDAwMDAwMD47DQo+PiArfTsNCj4+ICsNCj4+ICsmZmxhc2hfY2xr
IHsNCj4+ICsgICAgIGNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDAwMDA+Ow0KPj4gK307DQo+PiAr
DQo+PiArJnJlZl9jbGsgew0KPj4gKyAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDE1NjI1MDAwMD47
DQo+PiArfTsNCj4+ICsNCj4+ICsmcXNwaSB7DQo+PiArICAgICBzdGF0dXMgPSAib2theSI7DQo+
IEJsYW5rIGxpbmUgYmV0d2VlbiBwcm9wZXJ0aWVzIGFuZCBkZXZpY2Ugbm9kZXMuIA0KDQpBZGRl
ZCBibGFuayBsaW5lLg0KDQoNCj4+ICsNCj4+ICsmd2R0MCB7DQo+PiArICAgICBzdGF0dXMgPSAi
b2theSI7DQo+PiArfTsNCj4+ICsNCj4+ICsmaTJjMCB7DQo+PiArICAgICBjbG9jay1mcmVxdWVu
Y3kgPSA8MTAwMDAwPjsNCj4+ICsgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gQmxhbmsgbGluZSBi
ZXR3ZWVuIHByb3BlcnRpZXMgYW5kIGRldmljZSBub2Rlcy4NCg0KQWRkZWQgYmxhbmsgbGluZS4N
Cg0KDQo+PiArICAgICBydGNANTEgew0KPj4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54
cCxwY2Y4NTI2MyI7DQo+PiArICAgICAgICAgICAgIHJlZyA9IDwweDUxPjsNCj4+ICsgICAgIH07
DQo+PiArfTsNCj4+ICsNCj4+ICsmc3BpMCB7DQo+PiArICAgICBudW0tY3MgPSA8ND47DQo+PiAr
ICAgICBjcy1ncGlvcyA9IDwwPiwgPDA+LCA8JnBvcnRhIDEgR1BJT19BQ1RJVkVfTE9XPiwNCj4+
ICsgICAgICAgICAgICAgICAgPCZwb3J0YSA3IEdQSU9fQUNUSVZFX0xPVz47DQo+PiArICAgICBz
dGF0dXMgPSAib2theSI7DQo+IEJsYW5rIGxpbmUgYmV0d2VlbiBwcm9wZXJ0aWVzIGFuZCBkZXZp
Y2Ugbm9kZXMuDQoNCg0KQWRkZWQgYmxhbmsgbGluZS4NCg0KDQo+PiArICAgICBzeXNjOiBzeXN0
ZW0tY29udHJvbGxlckAwIHsNCj4+ICsgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhbWQscGVu
c2FuZG8tZWxiYXNyIjsNCg0KDQpSZWdhcmRzLA0KQnJhZA0K
