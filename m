Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D134F6FC2E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjEIJf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjEIJfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:35:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C5E6;
        Tue,  9 May 2023 02:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4Tk0A9oja34ziDEsAaVPUSUlbCZZj75qmR+mMME7VuG+oSEQE0YU9nf6fSSdEM1sWDkmCvTXiF2hpzLZQsocL16vPPEbvNGuExGuHhSUw+xVDQjv982EjVutcdhYVEWrG9zNyXnguAAHl/36TC+HwlW5mXSHCZlyV6d+iYB4KFfG3nenv98/cQudT7ez+eG7X4SP2u/WRBSYoxjAVXwDaOLNec5cXyh9hx9KmdHBSiP8oByeZLii+TdLSY771v8QGUFBKlO80+8mAfu5V1RdaRHVN14WZC0Zbg+0YOrjyPToUTHPts3qgNdqigWmmYPBsic6E7QH3cTwnR9sRMiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGez5DNflNuIoqf6VeiFcRtCwkgxIKFmbuW4EomqtC4=;
 b=jJ9P9SC5qXa9VJlLcJkF+W7AeHsd6bsweVsvKkSzD8zTvk4uLhkkPBJ2vSKftQisiYqAHzolpzo/p89Ybeo+Ky4QAAuh/fFrMVb5kZ8e75bDA9DAodkrsQe/OfY9/Tpyj5KlI6Gi2+7/fRWSooQ2lUy7CfVEuyleqO6/ozFh7rPrTaxrr7sQWsig8rPrg9/WDSi9ukIDGOc0D5BDij05J0atJmB93ytvWSsbcxwa5Eo1YuOry5YtkgtwJQiNy5nrLbDrERuSKNCrczyvNp9M4WN4/4LRVu3m3I94b1KdQYX6LpGg1L2tdmA1oIpyL7XijQTZIg2Svj9QLE6TWL7dNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGez5DNflNuIoqf6VeiFcRtCwkgxIKFmbuW4EomqtC4=;
 b=c+rCSk3QkfypKGHV8An0FY72wrCDp9yvCkfvG7VvReqLTyoRA89RtD5efqvLUpNiAzXCuRetln1qZvjuc9bD72mFGU9OdW7K0jsKkqL00+9RReE5OtkwB8Yl3e/2rtZ/MbzsSAnxN1OTarRij0BJpM3W9cIYY8maypYexsq5yIHhmXKlQKLLKTcnRO21TP6Ib8uTv8bisr7zTHnMnzMcIItMX12e+7Kb7RkDCWO1f+kMUPAbyI0cNFmrw0tkSe3qzNOSITBvX50TKGiPKJxS1FV7LopVwWQwOf+Z+YNcVDaTwGK3KT3uHnociJ2W3gPc4444gbLFHI2ioYRNaXSucw==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 09:35:51 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::affc:9f98:eb16:ab5e]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::affc:9f98:eb16:ab5e%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 09:35:51 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Liming Sun <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] platform/mellanox: fix potential race in
 mlxbf-tmfifo driver
Thread-Topic: [PATCH v1 1/1] platform/mellanox: fix potential race in
 mlxbf-tmfifo driver
Thread-Index: AQHZeErCeevS3HVKBU67hl1SlQVFQ69RwnYA
Date:   Tue, 9 May 2023 09:35:51 +0000
Message-ID: <BN9PR12MB5381316B1E76612838BBB762AF769@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <b98c0ab61d644ba38fa9b3fd1607b138b0dd820b.1682518748.git.limings@nvidia.com>
In-Reply-To: <b98c0ab61d644ba38fa9b3fd1607b138b0dd820b.1682518748.git.limings@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|DS0PR12MB8198:EE_
x-ms-office365-filtering-correlation-id: f4b4ae67-0f95-4be3-c6fc-08db5070c724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jbDyit01vtp/3t4I+49OKtf6EJ08vXcU2lHZHKCMt25viM3XLDdwQtHwip4/+DDsOyBoKD8rYLtHr/HtBv2g2xilZ5jEt67EeuWno6Tq5X3h3c171+P9Hb0R1MLaT71q6IH3nDNDJ7EZ+f4Kjx6FTgS4qXfG5AQDGWafiq+paTveyGPidlNc5jA+52QDAzA9tWNjuwPYysPrANn3n/LW/oMsrLZf12GpRIwmEEdYruwGUkevlzh1FWAtrxZZEnhWJEwXya9gsyePFPn1ct/U8mziwzeMpVOry1FsmEAUn2tYgZ81XwDBjyo9VlWVlTd7V7DGcmAzGH8iCTUsEWo25fDE3i7IAzeODNGN1r4eAEKuJzpKOXxVV77+NemwLu0IEWhhQnWb/xIN4gg/iD8/HFMJRoT95Dhxsi48V5tuJZHqgPWAoAjwhYl2OxsdqfRnloi0EVhyH26m5ji7lW8QHIRPBq6zvYWlSKmYr9ML9tkC9fd4b+ojHxRacNXkv9JOAE5Z8Rbt75pyHAykQGRVBpJalUtksl7quxT2LDMJeV0qeaHsuo+KOx1Xqec3tVPcXtHnsN08a0FVJ0d31bnysnFa+ZeV2y7eed7I+av6mP+xWhSQievvLZwg4k7WCUV3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(122000001)(2906002)(5660300002)(55016003)(33656002)(52536014)(4326008)(316002)(41300700001)(8936002)(8676002)(71200400001)(66556008)(66476007)(64756008)(66446008)(76116006)(66946007)(54906003)(110136005)(478600001)(86362001)(9686003)(83380400001)(38100700002)(7696005)(6506007)(53546011)(186003)(38070700005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUF1WWhOaFdUbTM3bGUzcXd3bXdUYmdacUhDMXNGUXVZNDBLY01NNFowaG5q?=
 =?utf-8?B?djkvdEJ4a3laUzBMSTJycUdkSUJZdW14bGliREVQK1RKS3JuR1g5ZWlORXA3?=
 =?utf-8?B?NTRsdU9nZkk0MTFVdmF5RnQ1Tis5TGZ0YmcydHp3cmxBNjlpaXZiZWtuMzc3?=
 =?utf-8?B?dXhqRkZLZzljczFUWGc0WmdwVnRsbjdnWmJkUHNCekFLQzVYdnB6d1FrVjBB?=
 =?utf-8?B?MnNjQWF5ajc5MTV0bDZCeHJweXlQZENvNEtRRURwVGRQUmlEbFJUdnFEN2lo?=
 =?utf-8?B?NEs5VUNIQkEyaVZiVTZiSEREUmxtRmhENStOVlZUODVFSXpTaGdKdnRhSkQ2?=
 =?utf-8?B?V1ZLWXMxUE5JOHQrM0laK2MxNlFaSWQ1MjU5QU9WekFaSGM3Qm1lYTdQQmhH?=
 =?utf-8?B?TVdwTmJzT21KQVQ5eVlic2JPSEZZb3FnZW5WaGlZZy9TUGh5TEp0Tm85NFY4?=
 =?utf-8?B?UkdFV1hYRFpoZWhoVmJKQURsNVpjMjNDWFVHaW1xc0xMOU93dGwwbjdSaCtQ?=
 =?utf-8?B?akphNnVhZWR0MEpwTlNiVTh2SzV3RVZjdlIxdHpnOU8vUjl2ZW9RYTFnenpz?=
 =?utf-8?B?cU5vT1Z2Qm1RYVlaMklwcFRTeDhuL2FST3BNUG5YSHlGKzYweHdVeGlEOXlQ?=
 =?utf-8?B?RHFWVHQ5cGlHbnhzN0U1bklqRVp4N2pjMXZMNW5ZeWxVK2I5K0R0TmIvc01J?=
 =?utf-8?B?R3puc3kzeVVnTGxyNXhDcC9iL1ltT2ZnaFB5amlVeTdhem1kTCtUV1p2L3Rx?=
 =?utf-8?B?ZlgwMUtJMVV0cERNMW5ZQ1FLQjJRZUFCMWZFajZGeThiZGJyY0wvZklBMDZ1?=
 =?utf-8?B?UzB0ZVpYeGR5L1BBMm1jcVNnNUNwYVJ3SkdCMVQydFU0RXZPU2kzcUZJWFhq?=
 =?utf-8?B?ZnJ2WWdnNDFvWnVKV3NmUlBlRngxQUw1c1djTEZGOUwwM3N6WTJUdk9IZUtZ?=
 =?utf-8?B?TDZFbGp6L0s4aHloUFBMd2d4MktROGdIWDhzeTVITkpUbmhTU1IrbURvYmlH?=
 =?utf-8?B?RU00a0FaUW9LSnhyc3YzRW95UEFoVE5YT1VFbzdCS0pUUzJ4cXh4OGgreFpP?=
 =?utf-8?B?dWMwdnlLeDR6a09LcjY0Zno3NXFxVVlaS1VHY2loS0FVcXg0ZXYrUDhlbWhk?=
 =?utf-8?B?Y0hPUjVUcWQxUGk2akVCZGtXajgwMWQ0eERsc3R3Q1BHdXFhQ2Fmb2dNVmdK?=
 =?utf-8?B?Q2Z3OFRkK2pSSlVpczN5UkVUcWFkb3p0S1ZhaFZ2OXd5aTNJSHpQNzdzUDBE?=
 =?utf-8?B?S25WY3RTQTFtaTJ1L1NMRFdEZ1J2YmZZVVMydnljSjBzWEp6b1lMR1JaN1Rp?=
 =?utf-8?B?Z1JJQnVDUmZYUXZRN21PM2RiRHNXajF3YUNBNE5PQ0xmSjFFOUlPbXE4RTJa?=
 =?utf-8?B?TEZEOE9xa2ErNlZCYXZ0MkU0U0lqTU9QZ1UwaTh5eEN1ak0rcWtVeTBPellk?=
 =?utf-8?B?Z0NPTktTNEZPaVRGbDBBUlNBK0w4QVoyQ3NCb3FUVUlnUTNoWGFyOGh1QTJp?=
 =?utf-8?B?c0xvbys3UUdHY3N3WWZCMkNORTZZWnJlWmdLNVRpL3pjd0FMSkNOVXNwcDRR?=
 =?utf-8?B?WHZPZ09hZHloVHRkZ0thQzNqQ2dac2pqOTAzQmwyZTVMRjdiQjErbk9ueHB4?=
 =?utf-8?B?ZmRoN0xKQXA2QUg3SDhESTJFUm45UkJIVlZOVitBMlAvTTRBdGlSWHpqdllJ?=
 =?utf-8?B?bkdBSm5KQkh3bU9IUXQwN1lsWUtJQVRPbW5KeFlNRm01bWEzMnlkQkFNUjkv?=
 =?utf-8?B?U2VzckNDdG9sNGJzWWoxT1I5WmVXU3ZSY3UrZmVyd2prajhqaVNXb3o5M29w?=
 =?utf-8?B?bEh1VEpTTnE1eFVlMlBFU2V6aUg4dTFxM0p3VUgyYi95NlNSb3JyNWorUUgx?=
 =?utf-8?B?a2Irdzh4bzNzUkUxRnJ5NUdqbG1kYkxFdzNKcTRUMm1ra1RzekVINy8zbVNs?=
 =?utf-8?B?ZUVjUFdmK01CNFVUYmZQUWYzSlU3N2UxM3NONnk5dnNqeS9MMzk5d3JIMEdZ?=
 =?utf-8?B?ckh4VnREa1RMTThpaWxVa1F5ZFkwL0FZOUM3ckFVbm9UU2hMbndpMUVCT2xR?=
 =?utf-8?B?SVF0bzZsQjlRNkZGYm9VdzVxcWN5VW1hSkNQM3FDWE9nY2RGTkozZlE2eG9o?=
 =?utf-8?Q?Kv4VmxEw4tBCRF8loEqmjYJZ0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b4ae67-0f95-4be3-c6fc-08db5070c724
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 09:35:51.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGaAjzVHY9S5ToZ4iPU1fdYTDCbwJ+yslox7+kj8ne+lvq+GCkb7XNFmSLKO54PxXy+yHZa7bj/PZfC8/B59PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltaW5nIFN1biA8bGlt
aW5nc0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDI2IEFwcmlsIDIwMjMgMTc6MjQN
Cj4gVG86IFZhZGltIFBhc3Rlcm5hayA8dmFkaW1wQG52aWRpYS5jb20+OyBEYXZpZCBUaG9tcHNv
bg0KPiA8ZGF2dGhvbXBzb25AbnZpZGlhLmNvbT47IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJl
ZGhhdC5jb20+Ow0KPiBNYXJrIEdyb3NzIDxtYXJrZ3Jvc3NAa2VybmVsLm9yZz4NCj4gQ2M6IExp
bWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT47IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5r
ZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MSAxLzFdIHBsYXRmb3JtL21lbGxhbm94OiBmaXggcG90ZW50aWFsIHJhY2UgaW4gbWx4
YmYtdG1maWZvDQo+IGRyaXZlcg0KPiANCj4gVGhpcyBjb21taXQgYWRkcyBtZW1vcnkgYmFycmll
ciBmb3IgdGhlICd2cScgdXBkYXRlIGluIGZ1bmN0aW9uDQo+IG1seGJmX3RtZmlmb192aXJ0aW9f
ZmluZF92cXMoKSB0byBhdm9pZCBwb3RlbnRpYWwgcmFjZSBkdWUgdG8gb3V0LW9mLW9yZGVyDQo+
IG1lbW9yeSB3cml0ZS4gSXQgYWxzbyBhZGRzIGJhcnJpZXIgZm9yIHRoZSAnaXNfcmVhZHknDQo+
IGZsYWcgdG8gbWFrZSBzdXJlIHRoZSBpbml0aWFsaXphdGlvbnMgYXJlIHZpc2libGUgYmVmb3Jl
IHRoaXMgZmxhZyBpcyBjaGVja2VkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGltaW5nIFN1biA8
bGltaW5nc0BudmlkaWEuY29tPg0KDQpSZXZpZXdlZC1ieTogVmFkaW0gUGFzdGVybmFrIDx2YWRp
bXBAbnZpZGlhLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4
YmYtdG1maWZvLmMgfCAxMSArKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRm
b3JtL21lbGxhbm94L21seGJmLXRtZmlmby5jDQo+IGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5v
eC9tbHhiZi10bWZpZm8uYw0KPiBpbmRleCA5MWEwNzdjMzViOGIuLmE3OTMxOGU5MGExMyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi10bWZpZm8uYw0KPiAr
KysgYi9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLXRtZmlmby5jDQo+IEBAIC03ODQs
NyArNzg0LDcgQEAgc3RhdGljIHZvaWQgbWx4YmZfdG1maWZvX3J4dHgoc3RydWN0DQo+IG1seGJm
X3RtZmlmb192cmluZyAqdnJpbmcsIGJvb2wgaXNfcngpDQo+ICAJZmlmbyA9IHZyaW5nLT5maWZv
Ow0KPiANCj4gIAkvKiBSZXR1cm4gaWYgdmRldiBpcyBub3QgcmVhZHkuICovDQo+IC0JaWYgKCFm
aWZvLT52ZGV2W2RldmlkXSkNCj4gKwlpZiAoIWZpZm8gfHwgIWZpZm8tPnZkZXZbZGV2aWRdKQ0K
PiAgCQlyZXR1cm47DQo+IA0KPiAgCS8qIFJldHVybiBpZiBhbm90aGVyIHZyaW5nIGlzIHJ1bm5p
bmcuICovIEBAIC05ODAsOSArOTgwLDEzIEBADQo+IHN0YXRpYyBpbnQgbWx4YmZfdG1maWZvX3Zp
cnRpb19maW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwNCj4gDQo+ICAJCXZxLT5u
dW1fbWF4ID0gdnJpbmctPm51bTsNCj4gDQo+ICsJCXZxLT5wcml2ID0gdnJpbmc7DQo+ICsNCj4g
KwkJLyogTWFrZSB2cSB1cGRhdGUgdmlzaWJsZSBiZWZvcmUgdXNpbmcgaXQuICovDQo+ICsJCXZp
cnRpb19tYihmYWxzZSk7DQo+ICsNCj4gIAkJdnFzW2ldID0gdnE7DQo+ICAJCXZyaW5nLT52cSA9
IHZxOw0KPiAtCQl2cS0+cHJpdiA9IHZyaW5nOw0KPiAgCX0NCj4gDQo+ICAJcmV0dXJuIDA7DQo+
IEBAIC0xMzAyLDYgKzEzMDYsOSBAQCBzdGF0aWMgaW50IG1seGJmX3RtZmlmb19wcm9iZShzdHJ1
Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiANCj4gIAltb2RfdGltZXIoJmZpZm8tPnRp
bWVyLCBqaWZmaWVzICsgTUxYQkZfVE1GSUZPX1RJTUVSX0lOVEVSVkFMKTsNCj4gDQo+ICsJLyog
TWFrZSBhbGwgdXBkYXRlcyB2aXNpYmxlIGJlZm9yZSBzZXR0aW5nIHRoZSAnaXNfcmVhZHknIGZs
YWcuICovDQo+ICsJdmlydGlvX21iKGZhbHNlKTsNCj4gKw0KPiAgCWZpZm8tPmlzX3JlYWR5ID0g
dHJ1ZTsNCj4gIAlyZXR1cm4gMDsNCj4gDQo+IC0tDQo+IDIuMzAuMQ0KDQo=
