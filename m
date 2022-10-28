Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291C4610891
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiJ1DLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbiJ1DLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:11:34 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B3053A64;
        Thu, 27 Oct 2022 20:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXTqMBKrwoEbNy4Ca8/jduc0B525+QueOkkLgUHSY8Fu0PQUOF1SziFycs2etWK1muFjr3Z0n8zgDkYaPRd+gOVBRRolbKI12tW71oVE0R5zCpcSj1maqEEe4B627R6ASfGJXkbJLjlYe6xNvOz3D4Y87Pg8LX0nX2sn+fVqSugZQOypH5hdTAOYid1pUh2fNK7ZbGDfSY3BZfBRmOnxwuUX1Lj8eJvyRvgDYT37uF/WJVe2HdpxlYI9wWKQLKPYvDYt9SOC+RoclIstQF42ohPVX7FY9wO14abth6LFjpNpK76qktL2Ht+z8hCF2BhnUuRcJBj8iLi9eSWvsTIz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX/FeXhfDT6wgr3yiRsa8nbTL7AsPMxHWObfqWZ8BqI=;
 b=EFR60aI1qf71wnmoiuvPmaxxuIK7mnlNjaFCH6rYGqBw4Q3+4UI48diFjVkbNL7HjcX9vVm1etGJEysLTtL2qe+c6D9v79LFUpQTtosBBzgQPEuPIdnFmMa8Pq1C+krTjViztk/CyoQ2QwmzFr7thmtI+Tg1DdGjggOS/dvumhNKoey/1RuPc9sx+uRy23f2eA37foZA1WyS1auPnUrTJoI75yf14yeOP9ylpng9yCOAy0BEicy2/+Z05jKsx6enn4yjshWkfx8CnnyusdsXF5rWw3BmuEYaohlRq5t6QZzc158h5uE+mA3NAe9GSZ+KG68x1uq3nOKY91sqrdA6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX/FeXhfDT6wgr3yiRsa8nbTL7AsPMxHWObfqWZ8BqI=;
 b=D7vZ2ekgHuFSZn6FPbfcXQ4Ga9Dv8VhpyRnjyYttaMYJKXCpmLjPvayp1SC0vb9sxPR7Yu7DmkDr2YpY6/rvlMOHGK/76LfC2tjHYHOWOeNOvdQf9y3KQyxGTTdS/kzb2vwLU31i/AEUwqJTegxlrI0fDz1lPSruNyP0gKJkgD0bERMaKfD8s2J2TWt/A8NAQ05sT8r1vMAaHHDzGBc/jpdPi0tUtQeRDOjZdNyFgiJ50M7v7zhCYfnoodq/U09lk1A0uQhrdObE8IZAGwCIJkJL7aAn6z9l4C7yItBlmR0SdMUa2OnRarCKy+/NWouZJlksgZUTCgT3quiqO1KjQQ==
Received: from IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 03:11:32 +0000
Received: from IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::ac89:2759:e558:ce6]) by IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::ac89:2759:e558:ce6%7]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 03:11:31 +0000
From:   Jim Lin <jilin@nvidia.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Petlozu Pravareshwar <petlozup@nvidia.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jui Chang Kuo <jckuo@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] xhci: tegra: USB2 pad power controls
Thread-Topic: [PATCH v5 3/3] xhci: tegra: USB2 pad power controls
Thread-Index: AQHY6gh+BNYrjpOm4Um+vCcFc3qVr64iRNGAgADdD4A=
Date:   Fri, 28 Oct 2022 03:11:31 +0000
Message-ID: <2e26a4a16122ca9129f02e03600b088f3effae47.camel@nvidia.com>
References: <20221027133127.27592-1-jilin@nvidia.com>
         <20221027133127.27592-4-jilin@nvidia.com> <Y1qO8cN4+kJVk2f5@kroah.com>
In-Reply-To: <Y1qO8cN4+kJVk2f5@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6603:EE_|CY8PR12MB7290:EE_
x-ms-office365-filtering-correlation-id: e215f49f-c8b8-45e7-dba5-08dab8921d11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vcbKN07DovB4lgSyPBM2kwTwrBz1yprYp2Ebe6K1UTnfNVYK3+FWz5lqSR6EhpUiHwbtbVfNjzBd+wxHmXP496FdlbGA0s1GFvQsUY5UVvCFC7O8vuGw1aiQHFd8zGoTxjTBQRMilYOR4cJujFWIQ2QqLyFfQ/3agR4NyNYZ3rJQXIRAZNTVuFS9mnu6ijbmWZkjRCUpC8a+drVwjkO/kgC9HZqlKpVSzmC1h+IJnKLaB6dA5hwv/yzaUE4JNiZGqLrvrw7ftn7Fv1Of1WSu6wfZ/s6xr1NakWFcQZ8WtQMRGi85m2FXCG1Tpf9vDtWYDKTUZqmbsBPNCaTLvOC4yhbfamZUOxAh0qNEPHKeAHgHtSC/zRkUORD69chWGvCjL9OdiFKfBm/vfCQMXaMrFa+pHeVMIUwO8KWeuzUzlFRs5biVJQIDistlfzn1Ag/cyQi/Wj8jXBFVCGA9HUduFRrhbaDCF0VKzTsnZETnbeUx2zEIVCsHpRwhCavx7aC3YxZHacrdwtai87Q0pgcIHCBZSPC8Yp+LxzIxRRmg0xH7T1JxdpPUV6EU1Y3bED25VvZ4zJxvsAdZ8Vu/r+Fi3+Y6GfjFdMapbX9DXKUY9+OGx+39bR9J4GxlmHOSoG8QHHh/YA5LxZv9s2vn/WCFCvEJT86NyEGpc6aK2tJxBATCqZbRve0IXC5XkZLRgphhHu+zhl8iKOz+FbtY2WHJCKdnveChmD4MNOS2wc1ABJc1D/ylE0IRscyeAdmtnK6jcfwzE/EnSNk7WWEBMAjmqftgxwBmWMnc7XMQeK1UkC0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6603.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(71200400001)(6486002)(2906002)(66946007)(316002)(91956017)(66446008)(64756008)(6916009)(66476007)(54906003)(4326008)(66556008)(478600001)(76116006)(8676002)(122000001)(38100700002)(5660300002)(6512007)(8936002)(6506007)(86362001)(41300700001)(26005)(2616005)(36756003)(83380400001)(38070700005)(186003)(4001150100001)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTJWcDIrYm5LMFpOSmdLUTlQNHpkSDJ5RW02RnJnSHF0OUVOd1FxSGdOMnds?=
 =?utf-8?B?aFl4TkJXckVmMHhMK050M0hUQ1JUK3pRSEVLcE1HK1BmU1VqT2RIZ2VmRVR4?=
 =?utf-8?B?dGFydWFuWnVOTnIxb3RTTSs4T3BEbXp4VjF0c2QwQzlLYmk0a2N0QWlJemRT?=
 =?utf-8?B?bWVlbndjWUFPZjM5eHZHVmNBR281UDlOV0I4UDNENUZudUtHNzRSRkRXejNJ?=
 =?utf-8?B?dlpQcHFOcEFlU1lRV3BLVHR1bzM4d2phOFZlcFpaRG51ek9wQlU3dC8wSjFD?=
 =?utf-8?B?M2lFcHlLN3pia2J2SmgvMUFKWi8rODZ6VGMrVnd4S0JTWXlrcitnT0hXMDE4?=
 =?utf-8?B?N0ZMZi9Ga01ZT3p1N0JpTUhwOUdBZThhd0MwTkdvODBvaFFYdjdPcWdidFdF?=
 =?utf-8?B?bkVCOG1SN0hmVUxvOS85MUFCZ0VuTHNBZjUvMVYwdUtVekJvV3h3bVA3U2FW?=
 =?utf-8?B?bEQyUlA0cy9IdUM0alBYeUtqZTBYbmNtZzlwTm5YeUZlcGRyTFVmbVh4UjRO?=
 =?utf-8?B?YitHUjZPbldyMStQTmtVQjcxSGdacllwTWx6bzk4clpIMTJHaDRGOGlQTGth?=
 =?utf-8?B?akFaSGtkNzlYRkFSNDNFVVZIVFlKbGQ3ZUZXNCtYbmd4Y2gzRnFxUnFFT0pN?=
 =?utf-8?B?TmU1S0lZaHNWN1paZWN6M2ZobjdSS2tIa0tRbFYrYlpIU0tLR240WklkcVRD?=
 =?utf-8?B?WEdTWkZPMjM3SC9ldVJEWmc5YXNWb2dmUjErVEN0Wkk0MW9YRUlLdDQzT0V5?=
 =?utf-8?B?ZTB5NVUzS09qbXJlN2FhZU5QeFRGdk10QzBRQnZQckxIN2srUkkyZ3daWHFT?=
 =?utf-8?B?ZmhWQ0ViRVhlY21IRncvQkROV251UmIzaXU0bjNVSmdwV1Zqbmhnb0ZGQW1D?=
 =?utf-8?B?TXNFdTc1WXlGdEQ3NkJpclJBeStPalFaZVA1MUwraXg0THdoQUZZRnVwOFhQ?=
 =?utf-8?B?MVlWVmhmM2w3VlJLL09reE11RmxkdEUxR2MvS29zbUpCdzJZNHhWbm0yUXpu?=
 =?utf-8?B?Vk5OYk5Rc1lSSnZHYSs2NzUvWmpWVDhCV0pJSTBodGRoTERoVlozRm00cW43?=
 =?utf-8?B?MUZkcDZ3ZWJBTzhQT0VHMW95NVVhT0ZpMHJscjFrcWw4eXJwaUNZWlZDclBL?=
 =?utf-8?B?VVdIY2FzcUQwRXFjNkpiU0EzTzlwUGk0bEx5cHp6WHBLVzl1WjRpRWRndkls?=
 =?utf-8?B?eTBXdkhYdUtMc1ZjNzFUWGV2Z2drM1IrS1VpZXMzYXlHWXlzMDc2SWVHZ0xo?=
 =?utf-8?B?ZUJTUGY2NStTb0NrTmtFVEVycklna2duZXltcDRNazlpWWFUNkNoU2FDZVo3?=
 =?utf-8?B?Wkl3T2JRcStkYk9ycWxzUVdYcVNaY09NZXRHMDN6V2RWb21Rd3Z3UHBSTXlC?=
 =?utf-8?B?b2IyZEpqUFc5QVVwQW9VTGFUbmVMTzdydXVlbTR4VnlJNVdIZktlMGZmV1dL?=
 =?utf-8?B?ZjYvakFjZ3pvQ204WFZBcVhkN29CUHY2UG4vbzM4ajFOcGlCUU1yMnEzeUtS?=
 =?utf-8?B?N3VnZ1cyM0MvbFVPVUdaa21keVZzNGJJeGE0dVptQVZxT1drbmU0Wll5MEov?=
 =?utf-8?B?ZnZIOGhsNC9BWDZmR2ZDNzZIcTlGcm9xem5UaXV2dU53dUZzOGo3VDJycm9E?=
 =?utf-8?B?YWFKU2dvT0h3WWp5UjA3TDh2RWpTZzBYd0RRY2NWOS9YbVF3enZIK3d1U3BU?=
 =?utf-8?B?NVlsOVFBMEtFZjkwOUtTZ0ZObnlobTQvckdlNHNnK01ZSmJQYlNkSTFWa3ZG?=
 =?utf-8?B?a0NXUVBLdWllZ2M1L0RVb2t3OURMSnBXMm9GNkQyclpKS2s5M0hMUzJ2Tlhn?=
 =?utf-8?B?Q2wyUjd5cnJiZnhhd0htTnhOOWtMblhLUTF1eW1VTktMTXZLeDR5NzNPYU00?=
 =?utf-8?B?SW9qTTBNY1BQMU5ZVGtVVVBFbWlLUlhsTGpPbjVoNXByS2VCdXNyUTd1OUl4?=
 =?utf-8?B?bE5JZlZJbUZDWlR5Z241TjNmUjgrN2lIRkZKUzgzdkpKUXRwVHMyTXdsL0Zk?=
 =?utf-8?B?djBLMEJJZFQ3RFZMaDVTaDQwY2JaUjE1VWUrcngrMURYT0JYTmdmQUpPZVpy?=
 =?utf-8?B?Tzc3ZHM3bmxnOEs2WUo3QXpLbzNwdE5tcHpXY3k1R0p4UXVHZmRqTzJyWHJr?=
 =?utf-8?Q?m+HO8c0c4fCbAsZA9HtXZMj3M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCBBE20C50BA134D9C680047EEA34F41@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e215f49f-c8b8-45e7-dba5-08dab8921d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 03:11:31.8323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+J1zTfoxpVjTF+7e+xpJnIKehknP58gThQpidgqfMGk6eI5+4eQwNrkvHV6Ll+o5yM1Xj0PQwn7vFTvNN7TqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDE2OjAwICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBFeHRl
cm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiAN
Cj4gDQo+IE9uIFRodSwgT2N0IDI3LCAyMDIyIGF0IDA5OjMxOjI3UE0gKzA4MDAsIEppbSBMaW4g
d3JvdGU6DQo+ID4gUHJvZ3JhbSBVU0IyIHBhZCBQRCBjb250cm9scyBkdXJpbmcgcG9ydCBjb25u
ZWN0L2Rpc2Nvbm5lY3QsIHBvcnQNCj4gPiBzdXNwZW5kL3Jlc3VtZSwgYW5kIHRlc3QgbW9kZSwg
dG8gcmVkdWNlIHBvd2VyIGNvbnN1bXB0aW9uIG9uDQo+ID4gZGlzY29ubmVjdCBvciBzdXNwZW5k
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldGxvenUgUHJhdmFyZXNod2FyIDxwZXRsb3p1
cEBudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpDIEt1byA8amNrdW9AbnZpZGlhLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaW0gTGluIDxqaWxpbkBudmlkaWEuY29tPg0KPiANCj4g
V2hvIGlzIHRoZSBhdXRob3IgaGVyZT8gIFRoZXNlIGRvIG5vdCBzZWVtIHRvIGJlIGluIHRoZSBj
b3JyZWN0IG9yZGVyDQo+IGlmDQo+IHlvdSBhcmUgdGhlIGF1dGhvciwgcmlnaHQ/DQo+ID4gVGhp
cyBpcyBhbiBvbGQgcGF0Y2guIEVhY2ggdGltZSB3ZW50IHdpdGggc29tZSBzbWFsbCBtb2RpZmlj
YXRpb24uDQoNCg0KUGV0bG96dSBpcyBhdXRob3IgZm9yIGxvY2FsIEtlcm5lbCAzLjE4DQoNClRo
ZW4gSkMgZm9yIGxvY2FsIEtlcm5lbCA0LjQNCk5vdyBteSB0dXJuIGZvciBLZXJuZWwgNS54eA0K
DQoNCj4gDQo+ID4gDQo+ID4gLS0tDQo+ID4gdjI6IEZpeCBpc3N1ZSB0aGF0IHdyb25nIHRlZ3Jh
LT5waHlzW10gbWF5IGJlIGFjY2Vzc2VkIG9uIHRlZ3JhMTI0DQo+ID4gdjM6IE5vIGNoYW5nZSBv
biBjb3B5cmlnaHQNCj4gPiB2NDogUmVtb3ZlIGhjZF90b190ZWdyYV94dXNiKCkgZnVuY3Rpb24g
d2hpY2ggaXMgdXNlZCBvbmx5IG9uY2UuDQo+ID4gdjU6IFVwZGF0ZSAuaHViX2NvbnRyb2wgaW4g
dGVncmFfeGhjaV9vdmVycmlkZXMgKHhoY2ktdGVncmEuYykNCj4gPiAgICAgSW52b2tlIHhoY2lf
aHViX2NvbnRyb2woKSBkaXJlY3RseSAoeGhjaS10ZWdyYS5jKQ0KPiA+IA0KPiA+ICBkcml2ZXJz
L3VzYi9ob3N0L3hoY2ktdGVncmEuYyB8IDEzMQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzMCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS10
ZWdyYS5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLQ0KPiA+IHRlZ3JhLmMNCj4gPiBpbmRleCBj
OGFmMmNkMjIxNmQuLmY2ODViYjc0NTliYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9o
b3N0L3hoY2ktdGVncmEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS10ZWdyYS5j
DQo+ID4gQEAgLTE4OSw2ICsxODksMTMgQEAgc3RydWN0IHRlZ3JhX3h1c2JfY29udGV4dF9zb2Mg
ew0KPiA+ICAgICAgIH0gZnBjaTsNCj4gPiAgfTsNCj4gPiANCj4gPiArZW51bSB0ZWdyYV94aGNp
X3BoeV90eXBlIHsNCj4gPiArICAgICBVU0IzX1BIWSwNCj4gPiArICAgICBVU0IyX1BIWSwNCj4g
PiArICAgICBIU0lDX1BIWSwNCj4gPiArICAgICBNQVhfUEhZX1RZUEVTLA0KPiA+ICt9Ow0KPiA+
ICsNCj4gPiAgc3RydWN0IHRlZ3JhX3h1c2Jfc29jIHsNCj4gPiAgICAgICBjb25zdCBjaGFyICpm
aXJtd2FyZTsNCj4gPiAgICAgICBjb25zdCBjaGFyICogY29uc3QgKnN1cHBseV9uYW1lczsNCj4g
PiBAQCAtMjc0LDYgKzI4MSw3IEBAIHN0cnVjdCB0ZWdyYV94dXNiIHsNCj4gPiANCj4gPiAgICAg
ICBib29sIHN1c3BlbmRlZDsNCj4gPiAgICAgICBzdHJ1Y3QgdGVncmFfeHVzYl9jb250ZXh0IGNv
bnRleHQ7DQo+ID4gKyAgICAgdTMyIGVuYWJsZV91dG1pX3BhZF9hZnRlcl9scDBfZXhpdDsNCj4g
DQo+IFRoaXMgaXMgYSBiaXRmaWVsZCwgaG93IGRvIHdlIGtub3cgaXQgd2lsbCBmaXQgaW4gYSB1
MzI/ICBXaGF0IGlzIHRoZQ0KPiByYW5nZSB5b3UgYXJlIHB1dHRpbmcgaW4gaGVyZT8NCj4gDQo+
IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQpzdGF0aWMgdm9pZCB0ZWdyYV94aGNpX3Byb2dyYW1f
dXRtaV9wb3dlcl9scDBfZXhpdChzdHJ1Y3QgdGVncmFfeHVzYg0KKnRlZ3JhKQ0Kew0KCXVuc2ln
bmVkIGludCBpOw0KDQoJZm9yIChpID0gMDsgaSA8IHRlZ3JhLT5zb2MtPnBoeV90eXBlc1tVU0Iy
X1BIWV0ubnVtOyBpKyspIHsNCgkJaWYgKCFpc19ob3N0X21vZGVfcGh5KHRlZ3JhLCBVU0IyX1BI
WSwgaSkpDQoJCQljb250aW51ZTsNCgkJLyogVVNCMiAqLw0KCQlpZiAodGVncmEtPmVuYWJsZV91
dG1pX3BhZF9hZnRlcl9scDBfZXhpdCAmIEJJVChpKSkNCjoNCkhvdyBtYW55IGJpdHMgdG8gYmUg
dXNlZCBpcyBiYXNlZCBvbiB0ZWdyYS0+c29jLQ0KPnBoeV90eXBlc1tVU0IyX1BIWV0ubnVtIHdo
aWNoIGlzIGRlZmluZWQgbGlrZQ0KDQpzdGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX3h1c2JfcGh5
X3R5cGUgdGVncmEyMTBfcGh5X3R5cGVzW10gPSB7DQo6DQoJeyAubmFtZSA9ICJ1c2IyIiwgLm51
bSA9IDQsIH0sDQo6DQp9Ow0KDQpzdGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX3h1c2JfcGh5X3R5
cGUgdGVncmExOTRfcGh5X3R5cGVzW10gPSB7DQo6DQoJeyAubmFtZSA9ICJ1c2IyIiwgLm51bSA9
IDQsIH0sDQp9Ow0KLCBzbyBmYXIgYXQgbW9zdCA0Lg0KDQpUaGVyZWZvcmUgdTggZm9yIGVuYWJs
ZV91dG1pX3BhZF9hZnRlcl9scDBfZXhpdCBpcyBsb25nIGVub3VnaC4NCg0KLS1udnB1YmxpYw0K
