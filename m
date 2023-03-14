Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501D26BA0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCNUaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCNUao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:30:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D62630299;
        Tue, 14 Mar 2023 13:30:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFt+nuWuX5WKq3sWwXA8cfOPMCrdNfgElV+7EQF5HKvGzSfaLGwCLRU0fFuPDHp0iEDFPk7HnfjMEVoFxunZcSVfVPO3Ow/b7j5lEirEEw2D4YTnC/Uz9zhPsvBJNOhVpJpHq07cGdyDNrVKuIspxuVTqKMxpNUkTLAan1kx84qDBMbpMoGgLHEPr9/cj5dTzCaGNaDVqf/Oz0vOS/MPazc6FdypK+bnHyrTQ3S64+eynbb/oX3h+6wR9YdNgG991MrQ/WW/eprI+vDJCbdhMtNY0K8a1992AUSnMFu4PLbVQUnwggLVBvUksBiZV7LNz0dHyTk7ft/g1PPkZudBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAljYTnR8ccJ8NTW941nEWnhJiXgrU6QxJJRM4BEN4c=;
 b=eBpcvTF19Od/YxnkHRdmGgTmTSV+Gn3UmkX5Xo8SQQw5HYlwEY+8Ir4JwLK2/7hAPTDzkco4TwADYL5G4sbnLIIFFS5Hg7aVP7FQXNqaz8FS+XXW+tJJ1wZKo45Xht2zMrXaWuW5iny/AnaVJ8pBjMT2KU79tWY2SpDBSlkd1b7r8nVprWoruv4kc/Mu1DjQy4LW6Nt7pO/Paf3rUPz9ZPL0Y+pb66B2KMpEWmsk9d/a1c0yu5EY+eYGUIhoI5cdhKHde50CC9cUKItav/aUmWdhL7KHqbppakCWz4o7sXt8ninsTTAW+yCBLKqgGALGcI11arEPKIY2ns1Rh43JPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAljYTnR8ccJ8NTW941nEWnhJiXgrU6QxJJRM4BEN4c=;
 b=XFtqmKx9scWEDeFOcz3a6zBpxgqvEoAYSFyQegqF3MBlifDbCNwWPRCYcFSk+maj2bfg++NwDSi3u3iLcwBooylokoCWmsGcn32bCC/9n2T1YpgT/0P6VZ7F6xVqdnDli0FPoW7suKRELlP0ZQdcFlTJMkzA1ZP+CCXtgMsYVEruK/gxvkkyzpCD4fK5M0UbiKuGRanPhrz0NKOwi2tu9FvMjBd4oGBF9zhJy0EbIzw2BtLAcNysZCyvA/luf8Q62YiZEn5qwLu1hxeAiX6G+Gh1y9Hob8V7wAzn3PhwkTrS6FRlkKl9aW/8KkikrJHHGhoNmNMnvgAoTpC8aOUx/Q==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 20:30:40 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 20:30:40 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "niyas.sait@linaro.org" <niyas.sait@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver support
Thread-Topic: [PATCH v4 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver
 support
Thread-Index: AQHZQxaXis8h0J8vyUGnQ7U8Uh2ONa7Tx+kAgAlAt3CAANpGgIAc/INA
Date:   Tue, 14 Mar 2023 20:30:40 +0000
Message-ID: <CH2PR12MB3895897EEE9AA284533978A5D7BE9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <cover.1676668853.git.asmaa@nvidia.com>
 <4cda8cfc37fb15a0c3b180ab4c34a6f6f859fe3c.1676668853.git.asmaa@nvidia.com>
 <CAHp75VeTbV7CyVZrXsrm8rqLnYdOunzTDhanqzceyJ3KyPjdwA@mail.gmail.com>
 <CH2PR12MB38959833A5A4073F8B2A84FDD7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VdFsxPPnNES0KS2koUGZz1C9dbNZbRtCRQBsFb1csqL7A@mail.gmail.com>
In-Reply-To: <CAHp75VdFsxPPnNES0KS2koUGZz1C9dbNZbRtCRQBsFb1csqL7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|SJ0PR12MB5405:EE_
x-ms-office365-filtering-correlation-id: 90ae84e2-1f0c-47c3-5aee-08db24cafa31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: knorgObOGzbAWXhJ/hoL6TBWoI7eAkR2aH7Aw+cY3WD7/rlMYj6nTECC2R4cuipYdGQabaEkIaam3JEn3KgQS1hg1VnEtaRVQEPnQhVr/y6JrUwByIkRlgr/vHRwWKFvIpxULKApm5SpdJWrahyVxy87N3GWvJmFpxTDiSDMWTOlw+3JndBld4Gl1g/JnA+oyZ0ch5rTWQQyJ/rPOPABs1SyTX9IFQ36nkY0kBYgDVsfIaln4UAglynxABiCZRWRP07OEoh5inA0KkM4Xcacaf5J9w2tKygCQbfTwkOJbbTNJk7/FB5wgMUo9dLGdaWw/IwPyNt40QwObs1vDrBytKQYfl7XwhB5rVfP6WiD6iFmHvu02q+ui8IJJn6IkXSUfZewpcoWQXEWVnKXUVdRmCjHrstGwTwZGaW63AOqNDt3prfwv42FKIzj1oFrQQmjp7pqGKy+jiiRfwVXyCYstbNcP2gKqh9KYoZa2Dh/oYVmU7pfyqUkhtiMvNU5iPX4zrJ3SjK1Q01UnYc/eGVa1DZeD6v3l1PwzfNQajzNkFvcrl7zloOFXFHIQw6LQ2EVl6frqbKto1UQdE7KEPY4HkCrrTcnLZODwRbC3A0wBxqMSjAxAuLWfO9hzWD7+vnIH5ZdyHnU1HuPszA/1VfnNFKMjXkzvF2/FSkTzBa92fUcREpeEFhH0vkYv2DnoVHSOdo7H0ZAIEP+gKElD1eKPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(2906002)(122000001)(83380400001)(5660300002)(52536014)(66446008)(55016003)(8676002)(66556008)(33656002)(66476007)(41300700001)(8936002)(64756008)(6916009)(76116006)(4326008)(316002)(38070700005)(38100700002)(86362001)(54906003)(186003)(478600001)(7696005)(66946007)(9686003)(71200400001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elhKVlRiR0cyWjRJakZRVmpSdnB0Z0xTYWVxSzFMM1ROZ3A4R2Z3TFJsOGNv?=
 =?utf-8?B?V24yYzJoNm1sZVJ4QXZLeGtUWGFpRnBkK3JxNzhNcFpDajh0bVc3N01FUmFs?=
 =?utf-8?B?MTJsK0ZZWnN4dUxhTTdScHZ3REZWTFVjWmNYMGZwV1hrL0NRUExWUmdSQ2Fq?=
 =?utf-8?B?TDVXL1prdjFPM2g0ck1sOHVKNHhTZzQ3UU1OWmZtWlJtQmpVZHdyZWZCMDRP?=
 =?utf-8?B?WTNYL1plenpydjhxcTBpTGE4KzRJRFh5TThiYVV1em9zKzQzRE9lWjhtcjhL?=
 =?utf-8?B?d0NsT3VpQWx0TU9yeEw4dVZ0RFJvSUFlTk4yRnluYzZOMFM4MTcyc1RCeXcx?=
 =?utf-8?B?c2hnSFk1UkdQcGVsSGJuYWt3Z2dSWnkycFFCa3F3RFRqRjNESjlwR3UySzRQ?=
 =?utf-8?B?N1NyVVpWT0tKUHVqZGE3d3gxVXZmWjBWbWQ3VmN1TVljak9IK2dhSEp2Nnlk?=
 =?utf-8?B?ZEFNeTRqMVVvYTFkVXUzdXZ0TFZ6N3JUQnZqVWhsNXgvMjNmUisxOTJ1L1lM?=
 =?utf-8?B?U3FCbGNSNXVGMTRoQ09qMFRHQUEvalJSMXJ3eEMwNkJ2Qlh6bGxSZVhSbnhR?=
 =?utf-8?B?enZvaWNvU0pXRlZSNFFJa1JHMDVnVEhkSE9wdDU3K3V3YXB5dSs5MFU5bU4w?=
 =?utf-8?B?MVg5dXFGMmxwZ0tFTEMyc0hKajg5cGtCNUpkeFpLR0MyTEJxWmN3eWJWckxE?=
 =?utf-8?B?ajNTMUFvbXV6S1VmUjRYZjJPTVJTcGZHR2VSUmNpWnNuS0NPbjdvOUVFMjUw?=
 =?utf-8?B?QXQ0N0tza1lmbTdjb05RcVZoWUZWaVdSQjNVU1NoWTI3U2xzRExOTlNyOFJW?=
 =?utf-8?B?MkgwMnUyREd2aE0zMkIvWHBPa3F6ZitzWktKWUVhNTlnYWN5UHB0eThaNVJL?=
 =?utf-8?B?VVNvU0dvSFdjcDgxYjFsZnA4VzhKWUxTVldqMXlJOHpKWEk0WlBDYWI5M2Ex?=
 =?utf-8?B?cUFwN2RxcnNhcmh0UGlMYUZOWXZ4Uk83ZVBtT3MvNGNXMHM2OFErdmM0cS8x?=
 =?utf-8?B?aTFIdlRteG91ek1Ib0FiYUN5U29rWFM1QlNuY21IaEI3MjNEa0pNY04ySWtJ?=
 =?utf-8?B?Wkh0ek4zSERSdmJXK0U3TUFROG1Vb1hzSk8xbEN4UTJHUUEwOGRmVy92NWRi?=
 =?utf-8?B?czM3ZXc2WHF3eEp0YTEvalpTejBubnk4YjZKT2xIWnhETXhVcVJ6eURlaG5E?=
 =?utf-8?B?ZG5GTHJtM1hqSzd0QWFqWDNsYXBPWVJkdUp1UmMxZ0pkSmk4SDVZdk02SGlk?=
 =?utf-8?B?RzZkYWI4eDZGRG9KT2ovWHQzcXZGY3UwUVByQ1Zlbjc2aDRxT2hibTVQVVVP?=
 =?utf-8?B?MS9CcjRiVVg3UG1tZzRGa1lpVDB1dVpmdzhjU09oNm5HSDg0RUkyRk1SYnNK?=
 =?utf-8?B?MW0xRHQzdzNOSE43d0Z1YUUzS2xjVzVYNytCeHo0SXpNdStCbWtQeThFOGlT?=
 =?utf-8?B?UFZvbDFtRXpQQ2ZqbTE2cGVvSzM3cjlvbmtuNVBvbnRRK3M3UGQ4dG4ySEZH?=
 =?utf-8?B?TUFESGJJL1JSdncrNTRVakFVN3dlVHp0aHdLWjJFd0V4WU45MmJJOE5uS1lK?=
 =?utf-8?B?cmVCUmNpVEZsNHlIZW80RzBvRHd1V3Y3VG5wb3Y1VUMvd1kxZ1BVS0VxeXpa?=
 =?utf-8?B?OFRJRXBHR0xkVWJFcVJVKzlpMmtKUk1ydFdiNGNINzg0bkNoN1Bad2RDeFJ0?=
 =?utf-8?B?OXo4cU5qaVcyMy9zU0tPbnZZRVVuSkhFdU54NUFKeVZWMGoxTWZ6NzBQd1BD?=
 =?utf-8?B?YWJCSTBzMERNOGtTSW9DM2dXZWZmOUZIdE94NEZhZi96elVQNmhuTHdXSDR5?=
 =?utf-8?B?NXd0VzBLaGwvam1aWkJrRFYrRkFRd0ZDQU9ySUpLZ01qeVFSSFJUZnJWOFdJ?=
 =?utf-8?B?REJhR3U4Z0R1VFhmQ2p6cTlVcTIyTjRDMHk0cXFtZ1NnWU1pWnBtN0xnYnE1?=
 =?utf-8?B?N0MwNG91SEpYNEtCOWpnNGdkWkhiN1BrZW41THYrRldMWGlpdTRFV2djL2px?=
 =?utf-8?B?OUIycTFXVktDS1dMekhaT0ZpQkNmeWovSllucytZY2w4R2ZNbTZhN0tla0F2?=
 =?utf-8?B?cHJhaUxCNFFNcUpoQWpPSlg5L1lDMCtSTkR6ejNNajFtZy9STEVGKzdDOHV0?=
 =?utf-8?Q?AnJY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ae84e2-1f0c-47c3-5aee-08db24cafa31
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 20:30:40.1964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVEdzWXPlExIgW6Ze0ptMQ6LHF1NGyoa2F1oRlptZv5W3DJOGaD8TOcM0uNgt1HOLNqZJpC1bmUNxpBiIk3eOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+ID4gPiArICAgICAgIC8qIFRoaXMgcmVzb3VyY2UgaXMgc2hhcmVkIHNvIHVzZSBkZXZt
X2lvcmVtYXAgKi8NCj4gPiA+DQo+ID4gPiBDYW4geW91IGVsYWJvcmF0ZSBvbiB3aG8gYWN0dWFs
bHkgcmVxdWVzdHMgdGhlIHJlZ2lvbj8gQW5kIHdoeSBpcyBpdA0KPiA+ID4gbm90IF90aGlzXyBk
cml2ZXI/DQo+ID4NCj4gPiBUaGlzIHJlc291cmNlIGlzIHNoYXJlZCB3aXRoIHRoZSBncGlvLW1s
eGJmMy5jIGRyaXZlci4gVGhlIGdwaW8tbWx4YmYzLmMNCj4gZHJpdmVyIGRvZXMgbm90IGFjY2Vz
cyB0aGUgc2FtZSBvZmZzZXRzIGFzIHRoZSBwaW5jdHJsLW1seGJmMy5jIGRyaXZlciwgYnV0IGl0
DQo+IGFjY2Vzc2VzIHNldmVyYWwgb3RoZXIgcmVnaXN0ZXJzIG9mZnNldHMgaW4gYmV0d2Vlbi4N
Cj4gDQo+IE9rYXksIHNvIGluIHN1Y2ggYSBjYXNlIHlvdSBuZWVkIGEgY29tbW9uIGRlbm9taW5h
dG9yIHRoYXQgYWN0dWFsbHkgZG9lcw0KPiB0aGlzIGFsbCBmb3IgeW91IHZpYSwgZm9yIGV4YW1w
bGUsIHJlZ21hcC4gSWYgdGhlIHJlZ2lvbiBpcyBub3QgcmVxdWVzdGVkLCBiYWQNCj4gdGhpbmdz
IG1heSBoYXBwZW4uDQoNCkhpIEFuZHksDQoNCkkgaGF2ZSB0YWtlbiBhIGxvb2sgYXQgdGhlIHJl
Z21hcCBkcml2ZXIgYW5kIGRlY2lkZWQgd2Ugd2lsbCBtYWludGFpbiB0aGUNCkN1cnJlbnQgaW1w
bGVtZW50YXRpb24gd2l0aCBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UuDQpUaGUgbWFp
biByZWFzb24gaXMgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgd2l0aCBvbGRlciBrZXJuZWxz
LiBBbHRob3VnaCB3ZQ0KRG8gc3VwcG9ydCB0aGUgbGF0ZXN0IGtlcm5lbCwgd2UgaGF2ZSBzb21l
IGN1c3RvbWVycyB3aG8gYXJlIHN0aWxsIHVzaW5nIG9sZA0KS2VybmVscyB3aGljaCBkb27igJl0
IGhhdmUgcmVnbWFwIHN1cHBvcnQuIEJ1dCBJIGhhdmUgZm91bmQgYSBzb2x1dGlvbiB3aGljaA0K
SW52b2x2ZXMgdXNpbmcgIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSBoZXJlIGFzIHlv
dSBpbml0aWFsbHkNCnN1Z2dlc3RlZC4NCnBhdGNoIHY1IGNvbWluZyBzb29uIQ0KDQpUaGFua3Mu
DQpBc21hYQ0K
