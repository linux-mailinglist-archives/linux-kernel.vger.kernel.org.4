Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496C65FD4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJMGdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJMGdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:33:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F40127BC0;
        Wed, 12 Oct 2022 23:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZSpraomsGX0Fd/vxd4Un8VNSVoX/wNiwPAEH8QTdL4/ENtBOIhjmmJ4DIaHg7TIh8cH0Tnf00RuwvL4jx5Ywi/Bhr9CnFTGAUTTcu7JUnve2Y0lpMaks0V1XUckhBPqby60fI8s2M14p8JspVsnhiVHo1bsINrkWmMAEcMIw/LEwYVAGUx8ExF1VjA2biFftuwR6MCJLVK3wdEv8byui8+M330kLDxJKwQBV/0WzBa7y2LB9AcUPWuuVIk78OBM927OeRU5eNPOjTz10ngqfJXiAcLSlQeKswC8LLtL6GCHPoJwcH5DY8vtoMr60U7K/hJOM6goAIstYjS5FY+q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erLN+nduICXrSz3TJzS4OqzRFbbZkHz11yicVu6DlME=;
 b=ixMl+sLXZJn1V8iCVzJgHyuZQw4OZWPnS7wVUhfuag6TJcQX6om5l3AJ53eoJrw7apTwr5PRUIoBVw5EvSEz7IVHlSfTK2nBE5/CNg/oR47pI09gkT3CZDIXV+OBXDZlIZnbkUEu6T7FuNw4ae13aLMsW/sZAR9rIfwlpaUg8RbbGXMLmjf/XPZq2yIRxd0NAp+9EVulbON4xMwJSgsuDH1oN0tBrpeFAtPaPJ5rvqzR9qE5JaK8TBQYQ4AA1Y3HzhIg4ZBv72T+5DK0U5dtXDK7Bu9wTInIwUs1B9bvSWD/adqU3M1tBfv5bqDX6MdPZMK5gnFg6gTgOGE8l5kh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erLN+nduICXrSz3TJzS4OqzRFbbZkHz11yicVu6DlME=;
 b=hLmZ45bbr1hVvZ1OzQRnwh0fDUnqhsU/ybRxfU79rHFu9ESQuNXOeOpicFDtEN96cuvEdSoHkSVipcEB9Apfic/c9vXGQ5Ba619DERO/aNU7PtE0qIUf79DwekFHm0+6iRImru1/4KaGK68YL6hjlKf4LvKX0U5Ox+eJvJhR6zVUdTxwkKneYKuTvL5Uob1az1P42oroKI+wMR8W6kxWUReKHizIT47IxX7o2EUgoUI5O4hL5I8nT+y1SbqPqHL6U/j8MnHV/ZEolEuylN6wlXKdTVU11x3Vt3RtS7vFZlf58XNEaUqW032vJDPfWWwiCiX28mZSnlI0mLsRrZ2Vjg==
Received: from DM5PR12MB2406.namprd12.prod.outlook.com (2603:10b6:4:b7::23) by
 DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Thu, 13 Oct 2022 06:33:27 +0000
Received: from DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::e1bc:e724:1595:253a]) by DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::e1bc:e724:1595:253a%4]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 06:33:27 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH v7 2/4] mmc: sdhci-tegra: Add support to program MC stream
 ID
Thread-Topic: [PATCH v7 2/4] mmc: sdhci-tegra: Add support to program MC
 stream ID
Thread-Index: AQHY2YSER75rWmO+bUy3rmTn4NwGFa4I/R0AgAAcmjCAAA6WAIACv2mw
Date:   Thu, 13 Oct 2022 06:33:27 +0000
Message-ID: <DM5PR12MB2406405CE44A7606B5A28203B7259@DM5PR12MB2406.namprd12.prod.outlook.com>
References: <Yz6zfrVq9cP/wrJb@orome>
 <20221006130622.22900-1-pshete@nvidia.com>
 <20221006130622.22900-2-pshete@nvidia.com>
 <CAPDyKFr_Yi2EgrBUzsORnM4mOkf25WR8+7_dfF2h4XzRDPm9-w@mail.gmail.com>
 <DM5PR12MB2406610AB26183BACB19EED6B7239@DM5PR12MB2406.namprd12.prod.outlook.com>
 <CAPDyKFqn2jMVQ5BAOZPFx2OOyMRQvsQ1E7mGAQp82x5+v6aSGQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqn2jMVQ5BAOZPFx2OOyMRQvsQ1E7mGAQp82x5+v6aSGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2406:EE_|DM4PR12MB5793:EE_
x-ms-office365-filtering-correlation-id: de21b74f-4d9e-41ae-4727-08daace4d61d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dH95lIKCi7WX8KFZaCQZ8fuPxRDKvK8f0bTwwKxP1r5qT8KG15f8K7d2EXVF7Z7SCTnDc9Wo0GkB1moCVqNI/Wy1AUc7bQ0zkAFz4TVdFU97khJSLZfoMweDr17hvJdAkbpfRgxs7TsdBA4X8xDkKnVMG6V+8DbCYb3ZBRJrXdk9DqyCW+M+5NThxoTd3hFxlSAjOlLRzGtL4DvUkRtrJWQlzSLRZtXVIGzvfBBqripOmaJz2u+TAV4IEqVukJrxpA4FL1i4MVwRAVhwZ2018/6D8608Ya1HqrA2vsV/dh2zqvTiQqmZqqGB2swxtQBNoYExLtMwIwHwuNsIb4HSSya0Wq3p1A5mXNLQ4FBip1ls8baQ7P48eHxhLvAX5R1xZrIWL0pxnuH6MaPo2emBl8GfhdIAnm0NBPU2jf8klWM8R89ey54uQpRGYdzQ9F1Z+Vqw8wIHmQL6ZKHprAJKRjgOyKV0LIz/T4VZXA1M3hnFjNJHzWjyJw7kV+cZn4h+sRSjkMnvdngDdXkPNoa/gv+YwrI/s9U+KmbpvUVKJM/k7+LZQ6AMpINCf2LGIhF8jPVvPgS0kWd3FSlSxCCiVtQUxv+X7LlvhFCMdFf8G+9jFWdz/tkOGJo56SNkh82RgSitnigBMHlEwXXTx3CRm4sMPSKfg4evUoeCtvbbH9wb2y+IqLgowaP73DyibW0OLJxLE4/WvCZOcv1SxfB1Xof72RFJDWHhK7OSFZ+zESEcmppy/eqA1GyuHWiq+e4/IUF6GvwT8/qh81YON+hNgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2406.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(66556008)(41300700001)(76116006)(66446008)(86362001)(66476007)(64756008)(8676002)(66946007)(2906002)(55016003)(186003)(8936002)(83380400001)(52536014)(38070700005)(4326008)(5660300002)(33656002)(53546011)(107886003)(6506007)(122000001)(38100700002)(478600001)(71200400001)(9686003)(316002)(7696005)(54906003)(26005)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTFIdTlkTWg0cjUwM05pV3U4U0NqSmFOOWl3NlQ4ZXcraFJaekg2RjZwNUx0?=
 =?utf-8?B?Y3ZzRVFZYTFxTzVuRnQzbGVvMHpEVDhlM1NIWGhmUlpGdFpGNkhIUlEyQTVl?=
 =?utf-8?B?ZUxxK2NsZWM5NStsZ2dhVDh3VUZMNTZnTEMrMFdNd0tKNFRzUElYdHBha3hv?=
 =?utf-8?B?TndVRy8wM21JZGZneDBLZVNZTS9welNYMlJCTXNzbmcwUkZXd2xBeXNsb3VY?=
 =?utf-8?B?T1UrNUgxRFNoNU0xY1hEd1JjalF3dk13SW1BRlNqbkE0NzFmTnlGUzUrMWJt?=
 =?utf-8?B?bHBvSnA3ZTVuZFRyR2lpQjJOQlRBaU9WVlljblZacDdBLzlpd0JRWG9Zc1p2?=
 =?utf-8?B?WXJudi9CYllsUytMaGdzMDMrRjMxZ1hmTzViMG9qa2M3OVRhaU16dHNOejky?=
 =?utf-8?B?VWxkQ3pRY3dVZEhXTXB1bHVUc0RQaDNyOFZQRXJmM3kxWGdmbXNiOUNZUXdr?=
 =?utf-8?B?SlB4U1pXY0UwMisxMkhWbC9zcWpRdmxUQitRM2MzQ2ZHS1dnZlFOZGdwbHVk?=
 =?utf-8?B?RnBKK1VINXJxTWpPZ3RNYldSb094SmFRWjVXaVFoNkVHZTNBdXZjSGZaTDFJ?=
 =?utf-8?B?WXBzcWtwbDZmeU5iWk0zSlBpKzNMSEtxRXdHU2JWanZGSkpVNTlxa0QvN0ZN?=
 =?utf-8?B?Zkt6cU92dFJkb0VzZi9mS3ZUMDJ6T0kxS0FwcjlTRnZ2REt3V2Vab0VnRVRZ?=
 =?utf-8?B?Y2NHazBQdTBOenkwcWEwYndTaHNrWGE0TUpKZ3preVhCMXorNFdXanRxYzc0?=
 =?utf-8?B?WWdBVWh6UGxISmtoV1M0Zys2NVVGQ09vQUdaZmhwK0J4WFNMWkRWMkFpcG5t?=
 =?utf-8?B?eWttTXVJZi9randJaDBKdE90bVhZV3R6QzZKeTVKL0loQTBGbnJjQmtyZkV1?=
 =?utf-8?B?bTRqa3JsbitxczJJUS9ieWZvTlZob3VLMTZLUXQwSTNtaEdXS1Z5YkpEeCtV?=
 =?utf-8?B?aGkzNzYraDQ5eVB1eGpHdDZKSGZyRWxMdzVWR0dHTEU2Q3lheEVlZ3MyWEdp?=
 =?utf-8?B?cm83OVJ4bHlmN1I1a3h5amc3K3ZNaHU3Rk9vbDBiNi9KcWpXRFZuWXhWM1po?=
 =?utf-8?B?Uk83c2crM295S0Q1SU9IZ25hbE1SUUdMeTRiMU9kM3R5c1kyZ1FQVWIvd0hl?=
 =?utf-8?B?WDBiekZOQ01rNzY5Z1IvL2E4MHQwZWIxcmZMNFh6YXIvZ0RidFEvMXd4Z2wv?=
 =?utf-8?B?SUV6Y1Q4OHZ0OU5TSnJ5U1h6RFErTFRWdmVTT2MwTjdLdURQOHBoeFNISFZq?=
 =?utf-8?B?dEZkaSs1ZDgyclhGSVA0b1VDR2hKYVR6RG9VdGVzYnlIV2t6eUhvTG5yNVpC?=
 =?utf-8?B?N0VkTG10aXVuSGtPcVdNSlVSRWJpTkpDMHFNRnZpOFFoREx5cnI4Z3VwTWVV?=
 =?utf-8?B?U3puZmhEMStEeVpIUk5mWU9VZ2s4ZG9rMW9qL0xwdVpKVDdIc2xMRUF1R1lt?=
 =?utf-8?B?UFVJbFhJU0wvU0RERmc0ZXVQNDFQMXFkRi9oUzJqU2UyV093WjZxQWQvQzdO?=
 =?utf-8?B?blJ5MzZaMFJFRjdSSTRSSHMrTFVsRmdBZ0JqZGRaZjBteEZ0akZWQVB6Y3k2?=
 =?utf-8?B?QU1FUE5ZcDB5cjRsK3hyWFhzS0x5U01xbUhXVTlPV29QR0c5a2lrL01CT0xI?=
 =?utf-8?B?SU5ZQVFENmhQR0o2WDh1ZmJLcFBJOTRZWkZhTFdkNGs3MFg1enB4bDV1dVBq?=
 =?utf-8?B?M0hNY2ZxdEpHRjdEWGRhSjdhdktod1BmOC8wZFQrdW9MeEZQS1VmSnpBVVI1?=
 =?utf-8?B?N1QyYzBXMFg4SnpPTlRENkJ4MXU3WldkVlVMQXRNQlp1QkhqeDdBTnBmYW1H?=
 =?utf-8?B?clk5eVFHQTlNRXlLZGxVMUhuRUwzbHl5MkFxWk9SVVZSR3QxZEpUa1huODlm?=
 =?utf-8?B?R2piMFdpSlgrOXVPSnQ1NCttaEpyRHEwNlM3MFpxNmZrQTJEbGNEL2haSVd1?=
 =?utf-8?B?ektmak9aTjJkNW5EbFFnenRPOTFCSDR3MUNSOEdBRnhtMTRtaWdIVGN6Vm1F?=
 =?utf-8?B?REt0YkRubnNjOGJzMURDN2xUb2NXS3YwR0VSc29EVGw4R3Y2a2FzRzJEbGYx?=
 =?utf-8?B?cVE0SC9YMXM2R2JRbnErb3NuQXBEdnBndG5ZL2JESHdQZElNc0NlM01YbSt4?=
 =?utf-8?Q?92vg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2406.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de21b74f-4d9e-41ae-4727-08daace4d61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 06:33:27.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrOoYUYQAKwoZLyvjApUmwR7OBSbcdJON2MZsCTrGPa/FAoXlWYYakQnqn3/k3HoZ6ZFN+S4jaCXRy2ymbFTWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWxmLA0KDQo+PiBJbiB0aGF0IGNhc2UsIHBlcmhhcHMgd2UgY2FuIGFkZCBhICJkZXBlbmRz
IG9uIElPTU1VX0FQSSIgaW4gdGhlIEtjb25maWcNCj4+IGluc3RlYWQ/IE9yIGlzIHRoZSB0ZWdy
YSBkcml2ZXIgdXNlZCBvbiBwbGF0Zm9ybXMgd2hlcmUgSU9NTVVfQVBJIGNvdWxkIGJlDQo+PiB1
bnNldD8NClllcyBpdCBjYW4vd2lsbCB3b3JrIHdpdGggSU9NTVUgZGlzYWJsZWQgc28gaXRzIG5v
dCByZWNvbW1lbmRlZCB0byBhZGQgYSAiZGVwZW5kcyBvbiIgY29uZGl0aW9uIGluIEtjb25maWcu
DQoNClRoYW5rcw0KUHJhdGhhbWVzaA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVz
ZGF5LCBPY3RvYmVyIDExLCAyMDIyIDY6MDQgUE0NCj4gVG86IFByYXRoYW1lc2ggU2hldGUgPHBz
aGV0ZUBudmlkaWEuY29tPg0KPiBDYzogYWRyaWFuLmh1bnRlckBpbnRlbC5jb207IHRoaWVycnku
cmVkaW5nQGdtYWlsLmNvbTsgSm9uYXRoYW4gSHVudGVyDQo+IDxqb25hdGhhbmhAbnZpZGlhLmNv
bT47IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LQ0KPiBtbWNAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC10ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBBbmlydWRkaGEgVHZzIFJhbyA8YW5yYW9AbnZpZGlhLmNvbT47IFN1cmVzaA0KPiBN
YW5naXB1ZGkgPHNtYW5naXB1ZGlAbnZpZGlhLmNvbT47IEtyaXNobmEgWWFybGFnYWRkYQ0KPiA8
a3lhcmxhZ2FkZGFAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAyLzRdIG1t
Yzogc2RoY2ktdGVncmE6IEFkZCBzdXBwb3J0IHRvIHByb2dyYW0gTUMNCj4gc3RyZWFtIElEDQo+
IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KPiANCj4gDQo+IE9uIFR1ZSwgMTEgT2N0IDIwMjIgYXQgMTM6NDQsIFByYXRoYW1lc2gg
U2hldGUgPHBzaGV0ZUBudmlkaWEuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIFVsZg0KPiA+DQo+
ID4gVGhlIGluaXRpYWwgcGF0Y2hlcyB3ZXJlIHdpdGhvdXQgdGhlICNpZmRlZi4gI2lmZGVmIGlz
IGJlaW5nIGFkZGVkIGFzIHBlciByZXZpZXcNCj4gY29tbWVudHMgYW5kIGtlcm5lbCByb2JvdCBl
cnJvcnMuDQo+ID4gRm9sbG93aW5nIGVycm9yIHdhcyBkZXRlY3RlZCBieSBrZXJuZWwgcm9ib3QN
Cj4gPiA+Pg0KPiA+IEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gPg0K
PiA+ICAgIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYzogSW4gZnVuY3Rpb24gJ3NkaGNp
X3RlZ3JhX3Byb2JlJzoNCj4gPiA+PiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXRlZ3JhLmM6MTc5
NDo1NDogZXJyb3I6ICdzdHJ1Y3QgaW9tbXVfZndzcGVjJyBoYXMNCj4gbm8gbWVtYmVyIG5hbWVk
ICdpZHMnDQo+ID4gICAgIDE3OTQgfCAgICAgICAgICAgICAgICAgICAgICAgICB0ZWdyYV9ob3N0
LT5zdHJlYW1pZCA9IGZ3c3BlYy0+aWRzWzBdICYgMHhmZmZmOw0KPiA+ICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefg0KPiA+
DQo+ID4NCj4gPiB2aW0gKzE3OTQgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jDQo+ID4g
Pj4NCj4gPiBBZHJpYW4gYWxzbyBwb2ludGVkIG91dCB0aGlzIGlzc3VlIHNvIHRvIGFkZHJlc3Mg
dGhlc2UgaXNzdWVzICNpZmRlZg0KPiA+IHdhcyBhZGRlZA0KPiANCj4gSSBzZWUhDQo+IA0KPiBJ
biB0aGF0IGNhc2UsIHBlcmhhcHMgd2UgY2FuIGFkZCBhICJkZXBlbmRzIG9uIElPTU1VX0FQSSIg
aW4gdGhlIEtjb25maWcNCj4gaW5zdGVhZD8gT3IgaXMgdGhlIHRlZ3JhIGRyaXZlciB1c2VkIG9u
IHBsYXRmb3JtcyB3aGVyZSBJT01NVV9BUEkgY291bGQgYmUNCj4gdW5zZXQ/DQo+IA0KPiBbLi4u
XQ0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
