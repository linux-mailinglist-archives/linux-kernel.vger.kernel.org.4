Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57769AC37
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBQNOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:14:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BF1311F6;
        Fri, 17 Feb 2023 05:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676639656; x=1708175656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yuCsfNSAv/O9kzvWMG+IF2rGHe40oZ+26FD3SupeQ9U=;
  b=CRsGI5nZyc1N8DOAU6p0hOGzy7TfnY8RsCbUUhtrp7Tc2/zGoozx6zzM
   OPgx+pSKHFREpqU8mg4XSb0vONb2HGsBTwYlyMNF/CC7O3BQOrZEPIzwK
   1lmHbYhaM4VYB3V2U0x5G/sHJs+Dm2djs3t+rE/Iz7pHpI9iM7rRm+lR1
   woEVsFLYtrabSmlgn/kMcCOQ6wflFqKVcDiR4X5daqG80k4mCGzr25noN
   hXUZmP90IPY80KARuItlH/lOMGdZ0RG+GCZYQh2Rijnb6fHAr9/lUr0jL
   rNL/DwNmB0ecIAx64bzfaz6I72R7/5XEKjZQQ2LJ2+yJxHR7Uju7ozKpV
   g==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="201164875"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 06:14:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 06:14:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 17 Feb 2023 06:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNvfw+6sX5h3+nVuRnJJ+B1x0lF4XZ3KzmMxpq8eb5d6sWqdLXtAxFooXForqCJVdRYoEGunknIibV/NkanUcO+RfA9mUqXrJPVlHvPSBzKibM8fBq+jhYW6E/3Nr3iWXy99frcQbI6eD55WV1A8OjQNT+tBrmnc6fvAp8JvPYSRNmBLhOd1FZg6/wwa2oflK+eBybXapsQTIgkiQorxmfOlZu3MntiHN4tDeOpuN06H7r9QpSF9I/XiL50v7Ele5BYUx7sO9PEUbMibsQhg0f4uPaNaSNUvyue/seJb9Cxj726QrtwrcILB1b718xIQdS4LRCNcpwkM+ubcGIAuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuCsfNSAv/O9kzvWMG+IF2rGHe40oZ+26FD3SupeQ9U=;
 b=hugeNEt4u80+L6QpQuqeY90BDioB6e1pn6NbPmvQC+tXA/cPziR6cGaWmDUyO+e7eM4Z5XpvY9hT9kyrtNcUfSW/odTweZqdMugEP5nyO+2MI48Z3nbZL1QbPI5xC5HXbWJkGDe+QRyPeDPS4vzGO/ag4WWktZslMIjYu5SZvNJ3itt9eKkqF1ZlVCv8vfuDzDUxGSjsloQ1ijR06lgq/ltNbpAWdqAlPJqH8BNLGexNfIfjvYVexOtdNGKLfiOPeYyW0WGQZvSnmy3zgxF81MT04zHbLaRbJNxjE4/njt1Zl9s5ew8bWrX7NVkrwTGvodQktgBg/QXhfPmBBUTHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuCsfNSAv/O9kzvWMG+IF2rGHe40oZ+26FD3SupeQ9U=;
 b=dBztagInjl6piU/RI+mEQwnxunQzbEfcM0KB78e00cEpMrzTOZxCo47Ta53eSmDPz4E/JZk9v9Y5/oYTk2kU3EEOTuN3SSS6UQDQZEJoY69uOWPRzWFBNJuL4DBSd+S6HAf5tYsyZR82MzsN9LSJZv0IfQ6jyKylffHUoo5wZbI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 13:14:14 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 13:14:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <amadeuszx.slawinski@linux.intel.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] ASoC: soc-pcm: add option to start DMA after DAI
Thread-Topic: [PATCH v2 1/3] ASoC: soc-pcm: add option to start DMA after DAI
Thread-Index: AQHZQtG75PdAzIHz6kqZwQqLdQhSzg==
Date:   Fri, 17 Feb 2023 13:14:13 +0000
Message-ID: <f63059d3-0b92-2916-873c-e67b773cfd11@microchip.com>
References: <20230217124151.236216-1-claudiu.beznea@microchip.com>
 <20230217124151.236216-2-claudiu.beznea@microchip.com>
 <bd634d42-ebab-f713-365d-6936fdb5d77f@linux.intel.com>
In-Reply-To: <bd634d42-ebab-f713-365d-6936fdb5d77f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BN9PR11MB5292:EE_
x-ms-office365-filtering-correlation-id: 872bc1dc-a252-4b30-6c74-08db10e8dd96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /TN2nl3w+SSbmwEnYkXQrUJu3cuuvgqzpEt8LfKRy9szuaHCOdcpByhABHtcldwk9EIYvn3v/EI16hS0MNY8KZEHSrPLP8bqkNNFE/n+/Sr639xBdSxKPoL7Y+1Ym+UXPtW+ouDXUfxNzZ2wp0YaZGNI70VqysrOzLXWMgodiM6Xojz3qQ+xZYjcaY1cMRV+/9qHwVxUFmijqXvn60tiOzVc8SOABSDW0mTAJU9olYEUc+bTQRs4ZExn9ZHvVubTzIRTn5JnIvSzXRsISognDidaOl1QcLKVv42/0CHDnjP4SYr06JyFxk/bnl0ekbV/yqjMvWPPDxsHxPDCx7/DeWUSVPS3HiBpW+LF0Nv+RB0oZlzQMu/ewoOIhlBcraevEgJOw4vT2/MeneXfFHMTfHge4NZRTFKzlNHzkWovfJHF0WrjkutjVXdzS9igfWOA4uafSKk/icEMvwnCiHUGfOIOpi8mZsY5v03gLoxSNv6z239G5kDuoH5Dapfk6/KEk3xP8gU2NiOcB/AHGDW6jSNZI7FXMPgR2my1cHHRewirPnHw+oCD2YJJWO/43zij7Hr3H6ROTLigkggFsoIaIV3FJGdV/KdsITPWNT/F4BzMM0REWFRz4wbM7dX+Y0d81PbG+TgAIWsq67iUJJ5RFz+AVXm4GYREHdmVpmRBWIVWb2PolfXw9mjgFLvFtzFlH0okVIallVen1ZunWxIhE9czSYx95J3uBOJtz76FDq4A5Is8hzvnPUjoYoRL0a8JG5e7q8seK++C/6JMIoDdEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199018)(36756003)(83380400001)(6486002)(122000001)(86362001)(31686004)(53546011)(186003)(26005)(71200400001)(6506007)(6512007)(478600001)(38100700002)(8936002)(7416002)(316002)(2906002)(110136005)(54906003)(41300700001)(8676002)(2616005)(31696002)(4326008)(66574015)(38070700005)(5660300002)(76116006)(66446008)(66946007)(64756008)(66556008)(66476007)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnJiTFBscSsvR3NncEdDMUxMVE44U0pEakFiTTg4QnZzVlFnRG1JOEpQSXd4?=
 =?utf-8?B?S2N1bUFKeDZmRmNMOUxIcCswMjRPS0Nmck1icVlLSGxWRE41NmdVNHVvRk05?=
 =?utf-8?B?eCsyK3IrTEk2UkhGY2FiOXB0T2NFaWNWTUt2YkJVOVQxVkFUM3FzOEs1SkR4?=
 =?utf-8?B?K3RoQ2JjMkEvd0hGc0RnM2N6NGR5cnkvdHh1VlF0SUZUaE8wRnFhb05Ud3du?=
 =?utf-8?B?dkhCdVRpSURWY3dLeWkyVEV6RWlNRXY3dGZoQ21wWTBsN2kzVW4rS3h2RndH?=
 =?utf-8?B?QkFKeHZOblZBQlIwZVFFL09tVUpvQlBjbW1NSGZmZnZpS3VKRkFlWkZ0TjZs?=
 =?utf-8?B?SWgyN1VBTDBwaHVyY2RNTlVtVHcvbHdCQm9EQzIybUtDUU9IUVkrVEE3U0ky?=
 =?utf-8?B?alRrWTZCL09tMFRkVHdxK1lMbUMrZXpTM2kxU1BvblJFVFM3K294Vkp6ZW5R?=
 =?utf-8?B?VEZQU0dRLzVTeklIZzRXVVc1R0Q3aDZRQmp0N3NzUEdkeXhhUU5FMndZbkdq?=
 =?utf-8?B?M0RUU0I5TzhBRWFIZVhWaU1kMzlGOG1mOWpRMHh6cElFRVE0YmwyUS9wSjZa?=
 =?utf-8?B?NTY5UGRrLzlLUWt6UDNBdWFNeXFXRWN1enpKYmk2eFNTRFFrN0VZWVZKWW1Y?=
 =?utf-8?B?cTczalBGY0NBSlluaStCTVpOL2ZBNEFVclc1MHU2ejJKTmcxQ1ExbEJZSUI5?=
 =?utf-8?B?bzhvUGtTT2VmM1o1UlUvZ0ZrakNZTEc5RzhJUklwWWxBZjk0VGx0WithakJK?=
 =?utf-8?B?aVJZTHpNV0J5RC9OQkZhdmtqczhxU1NJNExlTG1nb2Q5YjhwckRGMmc0b3Vh?=
 =?utf-8?B?Q2pLcTNIbnhVWXpUVTBHMjIxY1BDRmJQSGVZcHY5bVVoNmxjazRMMFdzNERW?=
 =?utf-8?B?N29zRFc5cjJYY2tsWGRwcDBxVm9rNkdjTDNjYXlkNWYzcmlCMEh0TnJSS2dE?=
 =?utf-8?B?SmhWNTYwd0VaVDd2M2xlSkRGN0RqRTd0cjBNTUlXMjk4UU9nVjYrQkZZaWNi?=
 =?utf-8?B?S0tSK0UxQWtBWmhrczdSbXZWaUMvOHk3L0w4cDBLN210cVVLWkNVVnE0dW9J?=
 =?utf-8?B?Q3BFUEM4em44TnphZy9GTDNWeTBVeDNxdzdyandJaC93eGUwWXhYcUR4UjE3?=
 =?utf-8?B?RlFrb2czUngwRUxTQXlxM0pjOEVuTnpyQ0ZENFlUeERhdzVHaUdNakdERUtB?=
 =?utf-8?B?dEt3ZC9FWkkrZ3JFU2pzd0pKSTc4N2t4Q2o2a2IrQnB3bUFCTzhkMmozU0d6?=
 =?utf-8?B?a3l5SmllVFgvdFIxdTBMZElST1lJQmJUYVlHVWZFMTN2N29xMFl5MGZ1SUgy?=
 =?utf-8?B?ZFhCTjZmRzdPMFdNaHBBQzg3T2llUGxNcmU0Mm9wMWc5ei9rMDJVNWxMM3hq?=
 =?utf-8?B?NVhlTndEVXA3T2hmWkF5K3pEVXhXbFZmcFdIcmJ2S3FmSmdhcWJLVzY1cGFx?=
 =?utf-8?B?Y2d2RGVCQkFaQXVyeGJuZ1ZFbDdzZWFtTXBTZm9Kb3Boc3dZMWgrK3R3OTNK?=
 =?utf-8?B?MFJRemJqaEtaTjMxQ2k1YVRWalV4SkR4aWc5OTNGQUMydVBQSUhCMzJERUpQ?=
 =?utf-8?B?ZUc2RTBJYXY5alp1UWtid0NONW5nalA1b2xhWTQzMlQvWjM3cXpUNStIL2Rp?=
 =?utf-8?B?Z2RyanpkS0JVYXZ4WExheFVnVFUwMUNGaVRlVmU1TUVJdHlhVWl6RzhBSWZa?=
 =?utf-8?B?a2hVTXRrODF1QmM1RWRhTlBwdGxZc3JYYnB4b0hSTjdJdFN3L0x6RERQY0pG?=
 =?utf-8?B?THZQR21ST3FsUU1kSE9rdUhVTzNteDhsdkFBWUZvVkQ5c3FiSmRRYmRFOUdQ?=
 =?utf-8?B?c1NmZi9xYnZUUlpTWmM5aGw0NkR6Nlo5NHRnYWNreUoxaXNpWjYvU2dxZHZQ?=
 =?utf-8?B?bWwzOXkrdUh2SlBYN1d6UkFzVlJkTytjZ2hmVzYvamxwcUFlWTdFVFJMOEZM?=
 =?utf-8?B?V2ZVUHpyZnhEczdWb1VIbVBlWkZwcndrdHJ3S0Q1bHF1UDQ3cGNvSzU2ZDUx?=
 =?utf-8?B?V1JiWlRoT1JxYTgwSitpdXp6VysyU3Z4NndrQ1JEbG1rV0JvZE8zOUhWcHls?=
 =?utf-8?B?b1ExY2hqTzQzQUg0Z3hMRE55QmpjMURUcE9pdlBraHVmVU1taE5HRlpWa1Ra?=
 =?utf-8?B?VnJFektnRWV4T25vaEJQRlJxdUUwVjg0cTBqOWZ3THlqVzNaYzRLeDk1Mm9W?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4A3B41A296F484A9D6D99D844C4ED2A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872bc1dc-a252-4b30-6c74-08db10e8dd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 13:14:13.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GiPht/vXHk4If/tvMP4gmYy+YEJioepRVdXYaOASxyjvTscsSpQHABs/dp2n9rK0WPoLEDwIbR4MDLVQHR7zpBhbZ7FHKrb7VJwCipi/Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDIuMjAyMyAxNTowOSwgQW1hZGV1c3ogU8WCYXdpxYRza2kgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMi8xNy8yMDIzIDE6NDEg
UE0sIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4gQWRkIG9wdGlvbiB0byBzdGFydCBETUEgY29t
cG9uZW50IGFmdGVyIERBSSB0cmlnZ2VyLiBUaGlzIGlzIGRvbmUNCj4+IGJ5IGZpbGxpbmcgdGhl
IG5ldyBzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnRfZHJpdmVyOjpzdGFydF9kbWFfbGFzdC4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9j
aGlwLmNvbT4NCj4+IC0tLQ0KPj4gwqAgaW5jbHVkZS9zb3VuZC9zb2MtY29tcG9uZW50LmggfMKg
IDIgKysNCj4+IMKgIHNvdW5kL3NvYy9zb2MtcGNtLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI3
ICsrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3NvdW5kL3NvYy1jb21wb25lbnQuaCBiL2luY2x1ZGUvc291bmQvc29jLWNvbXBvbmVudC5oDQo+
PiBpbmRleCAzMjAzZDM1YmM4YzEuLjA4MTRlZDE0Mzg2NCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1
ZGUvc291bmQvc29jLWNvbXBvbmVudC5oDQo+PiArKysgYi9pbmNsdWRlL3NvdW5kL3NvYy1jb21w
b25lbnQuaA0KPj4gQEAgLTE5MCw2ICsxOTAsOCBAQCBzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnRf
ZHJpdmVyIHsNCj4+IMKgwqDCoMKgwqAgYm9vbCB1c2VfZGFpX3BjbV9pZDvCoMKgwqAgLyogdXNl
IERBSSBsaW5rIFBDTSBJRCBhcyBQQ00gZGV2aWNlIG51bWJlciAqLw0KPj4gwqDCoMKgwqDCoCBp
bnQgYmVfcGNtX2Jhc2U7wqDCoMKgwqDCoMKgwqAgLyogYmFzZSBkZXZpY2UgSUQgZm9yIGFsbCBC
RSBQQ01zICovDQo+Pg0KPj4gK8KgwqDCoMKgIHVuc2lnbmVkIGludCBzdGFydF9kbWFfbGFzdDsN
Cj4+ICsNCj4+IMKgICNpZmRlZiBDT05GSUdfREVCVUdfRlMNCj4+IMKgwqDCoMKgwqAgY29uc3Qg
Y2hhciAqZGVidWdmc19wcmVmaXg7DQo+PiDCoCAjZW5kaWYNCj4+IGRpZmYgLS1naXQgYS9zb3Vu
ZC9zb2Mvc29jLXBjbS5jIGIvc291bmQvc29jL3NvYy1wY20uYw0KPj4gaW5kZXggMDA1YjE3OWE3
NzBhLi41ZWIwNTZiOTQyY2UgMTAwNjQ0DQo+PiAtLS0gYS9zb3VuZC9zb2Mvc29jLXBjbS5jDQo+
PiArKysgYi9zb3VuZC9zb2Mvc29jLXBjbS5jDQo+PiBAQCAtMTA4OCwyMiArMTA4OCwzOSBAQCBz
dGF0aWMgaW50IHNvY19wY21faHdfcGFyYW1zKHN0cnVjdA0KPj4gc25kX3BjbV9zdWJzdHJlYW0g
KnN1YnN0cmVhbSwNCj4+IMKgIHN0YXRpYyBpbnQgc29jX3BjbV90cmlnZ2VyKHN0cnVjdCBzbmRf
cGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLCBpbnQgY21kKQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDC
oCBzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGltZSAqcnRkID0gYXNvY19zdWJzdHJlYW1fdG9fcnRk
KHN1YnN0cmVhbSk7DQo+PiAtwqDCoMKgwqAgaW50IHJldCA9IC1FSU5WQUwsIF9yZXQgPSAwOw0K
Pj4gK8KgwqDCoMKgIHN0cnVjdCBzbmRfc29jX2NvbXBvbmVudCAqY29tcG9uZW50Ow0KPj4gK8Kg
wqDCoMKgIGludCByZXQgPSAtRUlOVkFMLCBfcmV0ID0gMCwgc3RhcnRfZG1hX2xhc3QgPSAwLCBp
Ow0KPj4gwqDCoMKgwqDCoCBpbnQgcm9sbGJhY2sgPSAwOw0KPj4NCj4+IMKgwqDCoMKgwqAgc3dp
dGNoIChjbWQpIHsNCj4+IMKgwqDCoMKgwqAgY2FzZSBTTkRSVl9QQ01fVFJJR0dFUl9TVEFSVDoN
Cj4+IMKgwqDCoMKgwqAgY2FzZSBTTkRSVl9QQ01fVFJJR0dFUl9SRVNVTUU6DQo+PiDCoMKgwqDC
oMKgIGNhc2UgU05EUlZfUENNX1RSSUdHRVJfUEFVU0VfUkVMRUFTRToNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLyogRG8gd2UgbmVlZCB0byBzdGFydCBkbWEgbGFzdD8gKi8NCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yX2VhY2hfcnRkX2NvbXBvbmVudHMocnRkLCBpLCBj
b21wb25lbnQpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChjb21wb25lbnQtPmRyaXZlci0+c3RhcnRfZG1hX2xhc3QpIHsNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGFydF9kbWFf
bGFzdCA9IDE7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+ICsNCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHNuZF9zb2NfbGlua190cmlnZ2VyKHN1YnN0
cmVhbSwgY21kLCAwKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQgPCAw
KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gc3Rh
cnRfZXJyOw0KPj4NCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gc25kX3NvY19w
Y21fY29tcG9uZW50X3RyaWdnZXIoc3Vic3RyZWFtLCBjbWQsIDApOw0KPj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGdvdG8gc3RhcnRfZXJyOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoc3RhcnRfZG1hX2xhc3QpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldCA9IHNuZF9zb2NfcGNtX2RhaV90cmlnZ2VyKHN1YnN0cmVhbSwg
Y21kLCAwKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChyZXQgPCAwKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGdvdG8gc3RhcnRfZXJyOw0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gc25kX3NvY19wY21fY29tcG9uZW50X3Ry
aWdnZXIoc3Vic3RyZWFtLCBjbWQsDQo+PiAwKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfSBlbHNlIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldCA9IHNuZF9zb2NfcGNtX2NvbXBvbmVudF90cmlnZ2VyKHN1YnN0cmVhbSwgY21kLA0KPj4g
MCk7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0
IDwgMCkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBnb3RvIHN0YXJ0X2VycjsNCj4+DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IHNuZF9zb2NfcGNtX2RhaV90cmlnZ2VyKHN1YnN0cmVhbSwgY21kLCAwKTsNCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHNuZF9zb2Nf
cGNtX2RhaV90cmlnZ2VyKHN1YnN0cmVhbSwgY21kLCAwKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfQ0KPj4gwqAgc3RhcnRfZXJyOg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKHJldCA8IDApDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcm9sbGJhY2sgPSAxOw0KPiANCj4gQ2FuIGFsbCBvZiB0aGUgYWJvdmUgYmUgaW1wbGVt
ZW50ZWQgc2ltaWxhcmx5IHRvIGFscmVhZHkgcHJlc2VudA0KPiBzdG9wX2RtYV9maXJzdD8gSXQg
bG9va3Mgc2ltaWxhciBhbmQgSSBkb24ndCBzZWUgcmVhc29uIHRvIGhhdmUgb25lIGZsYWcNCj4g
aW4gc25kX3NvY19jb21wb25lbnRfZHJpdmVyIGFuZCBvdGhlciBpbiBzbmRfc29jX2RhaV9saW5r
Lg0KDQpUaGF0IHdhcyB0aGUgb3RoZXIgc29sdXRpb24gaWRlbnRpZmllZDsgSSBtZW50aW9uZWQg
aXQgaW4gdjE7IGZyb20gdjEgY292ZXINCmxldHRlci9kaXNjdXNzaW9uczoNCg0KVGhlIG90aGVy
IHNvbHV0aW9uIHRoYXQgd2FzIGlkZW50aWZpZWQgZm9yIHRoaXMgd2FzIHRvIGV4dGVuZCB0aGUg
YWxyZWFkeQ0KZXhpc3RpbmcgbWVjaGFuaXNtIGFyb3VuZCBzdHJ1Y3Qgc25kX3NvY19kYWlfbGlu
azo6c3RvcF9kbWFfZmlyc3QuIFRoZSBkb3duc2lkZQ0Kb2YgdGhpcyB3YXMgdGhhdCBhIHBvdGVu
dGlhbCBzdHJ1Y3Qgc25kX3NvY19kYWlfbGluazo6c3RhcnRfZG1hX2xhc3QNCndvdWxkIGhhdmUg
dG8gYmUgcG9wdWxhdGVkIG9uIHNvdW5kIGNhcmQgZHJpdmVyIHRodXMsIGhhZCB0byBiZSB0YWtl
bg0KaW50byBhY2NvdW50IGluIGFsbCBzb3VuZCBjYXJkIGRyaXZlcnMuIEF0IHRoZSBtb21lbnQs
IHRoZSBtY2hwLXBkbWMgaXMNCnVzZWQgb25seSB3aXRoIHNpbXBsZS1hdWRpby1jYXJkLiBJbiBj
YXNlIG9mIHNpbXBsZS1hdWRpby1jYXJkIGEgbmV3IERUDQpiaW5kaW5nIHdvdWxkIGhhZCB0byBi
ZSBpbnRyb2R1Y2VkIHRvIHNwZWNpZnkgdGhpcyBhY3Rpb24gb24gZGFpLWxpbmsNCmRlc2NyaXB0
aW9ucyAoYXMgb2YgbXkgaW52ZXN0aWdhdGlvbikuDQoNCj4gDQo+IA0KDQo=
