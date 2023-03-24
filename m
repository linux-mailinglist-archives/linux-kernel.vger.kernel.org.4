Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7B6C7B81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCXJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCXJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:34:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C180911654;
        Fri, 24 Mar 2023 02:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG20GpmTK357VCr2ThH993fD1UnNCYFTg9KPTTw4POf8gjl3/Tdsxs1Ifsdo9lqSeH/mIxI8r4i3ogwO1OS/yQyFwfmk3h1H4oHIGLs91m2zEA7QlQAuEyJ/ukVDDYcT8E6SsRD0VTCkT8vc0wcCkEawvN349cdOpvZWbaM4HK7TglniMBKsFNBwp78Vzf+ygNIAEWcRPBjOqwckAZ9wosydbBeC70Z4/zrW+iZPoFarLM8FRNUxttfUdHi+YItvswjkEQRt4F2UwRbpR2gI9ozSIPuRGlJgmMwSDMwwxAX9wkT1m2olidBxrp9qb4dIjph4l//fMQiW19lMvUfozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC40zxS6hxGlbLcuMRKtVteGvdOt0GYAv8jA9iKCO1E=;
 b=MiNKNS5F9D+OqiCRAcUtBkraNzG9mRAvb38GJOZH0EIlWB4/dIHC0jqC9hZzUNa7RLPVp8+HCEZajZtW90EcxYrAPf2WLEvJU+sIKK0rdZn9fFo9a+0Gyt1RaFTb9/7PdIeSDLs+s/EBpGyhUTL31FdDult6ep4TKy6lERXWOxfsjZKKFgRB/LaKJ3y8xs2FF66umxw8VVLMH9KgKYjzHy/1wpelueYO7dFvdkGEChTGJz4SX+iB/jaK3tJpTG7whdyjofwq990kECkFxpPpTSptslnW1pzJN9X8aHyQR+qlAhWOlhCdqdQ6k4HjNv0S5ueRq5FyZGqljCnoQBD8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC40zxS6hxGlbLcuMRKtVteGvdOt0GYAv8jA9iKCO1E=;
 b=fw1vkNyjA/OrkupIwEKepLdlLmvqem/zWtoJXnkCQ/cY563oLH+A4r2ULGPEOyugcitF2bNymO4rvGP/4TStYlPbzMWoMcj2O2rNs93wUbjTVOxR7vz4cp99RIL1kVT1HkClbTFwN1OqxgRvsLCC7JDKVCcHh5y8z4tTMOwyMJCIqaGwvkIVTSI38AsVIPGt6wtGmbNNCJr32V+Amr03mpRp5zwnK56VtZvL7o/0FCQJoZhGCzpwdJ2wcgrL2Zd7iCRYQuhU/39SozShfsOO70lLjTI/U/hpYhWzQlGwjJpBiS7Y/sv8jN2tevqAKIaiL+wcmjJxVUCA/Q6fzIlDSQ==
Received: from LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 09:34:30 +0000
Received: from LV2PR12MB5992.namprd12.prod.outlook.com
 ([fe80::dd64:4156:acaa:399b]) by LV2PR12MB5992.namprd12.prod.outlook.com
 ([fe80::dd64:4156:acaa:399b%6]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 09:34:30 +0000
From:   Haotien Hsu <haotienh@nvidia.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Wayne Chang <waynec@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Jui Chang Kuo <jckuo@nvidia.com>
Subject: Re: [PATCH v4] usb: xhci: tegra: fix sleep in atomic call
Thread-Topic: [PATCH v4] usb: xhci: tegra: fix sleep in atomic call
Thread-Index: AQHZW8b3IekpF/qyYkSVS8iFJf8xn68Ij7wAgADxUICAAC8PgA==
Date:   Fri, 24 Mar 2023 09:34:30 +0000
Message-ID: <5f6aac15e1fef75799daa3a185e46ba0b6541a50.camel@nvidia.com>
References: <20230321072946.935211-1-haotienh@nvidia.com>
         <ZBx8vliqQVqdK/Pn@kroah.com>
         <3f864eb32214399b911a62c2223abd250f41e1fa.camel@nvidia.com>
In-Reply-To: <3f864eb32214399b911a62c2223abd250f41e1fa.camel@nvidia.com>
Reply-To: Haotien Hsu <haotienh@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5992:EE_|MN0PR12MB6103:EE_
x-ms-office365-filtering-correlation-id: adf02461-4ab9-4b88-21c5-08db2c4af7f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZB50x5/J36bDbCcTdTLFLS8+hvURvM8XPlsKuKlSfyMN0WtYZwYtAFk8HnuTDulep9fIoN/PAIP3oIPp/P/y8aZe75twBgHmrDd9rX0Heyl//jD5/2Ek53JcWfreMRilPcJo9w1TW20jZe7lQ5Y2M664nGa4g7d9NUMhXyfthUUSSifcawfir7KbHiC6TnBX0djGTgpAfE3yS/90bEpQeR9KeCSawjhTMzyOfEYrzPwDJIicP+XyvbQrLWC7bwxh6HwxA0PYusADnR8v0rtOPIFZi+SfAYnoKFo9cTjwuTRC1SAay4HRTqOxMgxuP3omIQYtqjfInDoF8RveTe59+hhADIPF+ekJb/uRO4KllJYKCSy9nzaAUKm42EfuJAvHtfZ1No+qeFpa3Hg1FJ86G433gh5jVDLhvLdzIVYsYA7+BUnDZY5BHWizZkZHtG6CGtGx9csZ64kPTeE/XETTz6cGA0vEamHnt4h+idcOoxGanDz0pNLF0mDfBT2B/vn69suVm23v8LXaV5q+7CbKZefSLNc6TxIcXfflyex7KZ6vo8V56WGTXp2DTOOfLMuUadaVog5IXI0kymK6uHcPox49fsb/7qJspVlwNI1ZCCL/CZQwwuN7K+/j+CHfpeBq2HmTYsKOV3MvLh07HRtHv9v6QASg7r/ecyxVNyIhu37Ftpd3onnprgN0HhbRdNHMUhbHWoxCR3uyH/HTLYm6xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199018)(122000001)(3450700001)(478600001)(2906002)(6916009)(4326008)(8676002)(316002)(71200400001)(5660300002)(186003)(38100700002)(38070700005)(83380400001)(2616005)(36756003)(8936002)(26005)(6512007)(6506007)(41300700001)(54906003)(107886003)(66946007)(76116006)(64756008)(91956017)(86362001)(66476007)(66446008)(66556008)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmk0MHczdUFVbE9vMFB1V0tDUSs1OS9lUUFvTkNrbkNQeDJHZUxGZks3OFRz?=
 =?utf-8?B?ZWwwZFZLblpRcllzNExRR0hNb3hwOG1IUEtjRVdUSlJ2MGhodkRTZ1dsK051?=
 =?utf-8?B?TC9IaEFTTWxkbnk3VXQzL1RVVmJoSXIzTGpmaUk5Z0dUS1BXeStGTjZyUkpZ?=
 =?utf-8?B?ajdDY05GbTExN1dlUkloN0JSdStDbE1oUkdMMjFET1JYVDNMakNPWDFyN3Nk?=
 =?utf-8?B?OVRUck9wcCs4ZUV5elB0S2ZuOEMvZ0huUlVFTEtYUHIwb1FNc1hENzg3WjBj?=
 =?utf-8?B?MW1aNy9DazhrcS80bld4cjlvQjM5dVR2dmNIMHlrbTdCdGN1eFRGMWRIVk9y?=
 =?utf-8?B?bnBDeDVwWWdvL3R6eG5aRmJuQklSRDZpNUlWcEhwRTZ3WHBPU1BBeVFyU21P?=
 =?utf-8?B?WXh2YTBSZ1dQQXlseFI1QnB0djltampVdXBrd3NtdzJwL0JSdjJjTi9SZFpr?=
 =?utf-8?B?YVlPWVhPTU1EaWVqWi9YLzVMdXVDbjBiL0ZjY2I3Q3gyd2tlWDZMNWUvemhT?=
 =?utf-8?B?ak9iSjk1TU5RYkQ5alQzdlU1RFhIUEZHRVVqTHdVcGljd0ZieGJJMHIvc2dt?=
 =?utf-8?B?d1pQUUYrbG56N3BOMEdUTXo5T0dFV25KVUVUNFZ2Tm82RWc2NlFtbHRoWEEz?=
 =?utf-8?B?RXJWdFRZVlQvay9DUjJRUHlhK3Mvd3UwWE5UeXFxYmNRUFdqdHVCWTdZcENt?=
 =?utf-8?B?dlZtWEhHS2l2SVZBd3pnODJaK1NjR3lYWnlyVzhGRjVwL1Bua0VxY0htOUh1?=
 =?utf-8?B?anlQdTZ4TkVVWVhLSmhnSndyYXgrbGVyYVNtSGFPUUJQRUF0YmQxTmlNdGI3?=
 =?utf-8?B?MWE2OEhDVU9tbEFSK25vNHFGWm9QLzQrWXhZNWZMUnkySm12VTlpdm5OZzNh?=
 =?utf-8?B?SEpCT052dkx0eEdWaUhKNW1kVEIrTUJDTjZqOTB6ODZ0bmRRK2VkcThkdjE2?=
 =?utf-8?B?d0ZLY2tCVEd4enJyQlpCNkovM1VLUVorZWVOa3ZibS9DbnNKaS9GenVwcTE0?=
 =?utf-8?B?YStmdkJoc3NkRE43OFJjTlNHK3ZEeEJSNTh5K2E1MXlCNXNHZ3VFdG1la29k?=
 =?utf-8?B?enMwOUQyMnVLbm5nS0hXcVhOblFZSDJ0dE90eTJlemZObWE1WFJhWjdNUlRt?=
 =?utf-8?B?akpJS0wzblRrWlhFc2c0a0pvZm5BS0Vyd0JJVTNzMytPVXpoQ1BYdWwwMDZu?=
 =?utf-8?B?bG5sWVlpRXVtR1lkK0M2Q0pTVXJrYlFWajd3YmwwWlEwK3RjSHVRNkZZamZy?=
 =?utf-8?B?NXRaWGlCek4rSXlHMm5YSEFlQWkzOW5MZmlwb3BHUytEUi9xdXZZSGV2UDRC?=
 =?utf-8?B?bi9ObGtIQnFObFlrNzNLb0JTR0UvdU9JNEVPaTBmQldNaThFL1ZkU1dTL3Zs?=
 =?utf-8?B?UmVXajEzNytmQUVZZXllNkxubXVzN1F3Nnl6NThaNnNRT3dCOU8xaStSalRM?=
 =?utf-8?B?eHNCTVcrMVBkVkpnNWx4a0I4RXJJRGJ6MzBGRHBNWlRCTDE1U3NpdXpKZzVl?=
 =?utf-8?B?NFNaYTd2K3NoakZuUzYzQ2pyQ29OWW95L0pHY3FNZFlpaFMvMjNTcGNIQkdx?=
 =?utf-8?B?UUZndUhON1VwZ2xSdTVmNjVObmozQkMzZnp1ZXhQUjhhTGtBdTRXY21HU2FM?=
 =?utf-8?B?NXoxM3RZT3ZYRVBDb21LSjY4NVB3Z0RGc2txVGgwcmdacnZxdUZGelVPOHNK?=
 =?utf-8?B?SE5tOCtJYU9kc1U0aXFYdUhjMjlESE1IS1A2VHN3KzFFMGRYOVNmUmdZeWRB?=
 =?utf-8?B?SThYREpQbGZ0MDNoYWtsVkEzY08wR3lWTVhmMDJKWUtUMnhmd0EzWEVFWUpz?=
 =?utf-8?B?MXAyQ1lVODdhTU1Uc1dVYnFoZVRUVm91SUlKRktMUlpobzgvYnRENG5XSTN4?=
 =?utf-8?B?cjgvSm5IR3Y0ZGpiTVBkWjFyNnZPZTJKNVRKWmRZRlQ4NXRBdWxnTmhxdEI5?=
 =?utf-8?B?N2d2Ukg3VlVCbU12dWdQRFRoaHEyVnk2Q1BPbXBWVnduSHh3Tko0RkVsMVZ2?=
 =?utf-8?B?cWlVYXE1Z2FPeHg5dEY4UU1sbHBxTGppN1RMVjRMNGlMNmc5Sk1YYWRnWGxw?=
 =?utf-8?B?WHUxNTRLcVU0Zm8yYXVpdnlJMm9MRGNrYmUyZGVxQ2UzM2ZacTRTYkdiT0M4?=
 =?utf-8?Q?eU8HZr4FHPAx6m6u0X5OyRRsk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C26AF0AE6F181943AF4EB4C1E0D0E271@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf02461-4ab9-4b88-21c5-08db2c4af7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 09:34:30.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2Ibe3XgdeMf9hFrt5WBH8CqITLpsl8wPNXQaqgNAxH0YlTxfnZuT4RzCc1Ddqg84vFVNzOLgIk7YuYRxarhQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTI0IGF0IDA2OjQ2ICswMDAwLCBIYW90aWVuIEhzdSB3cm90ZToNCj4g
T24gVGh1LCAyMDIzLTAzLTIzIGF0IDE3OjIyICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+ID4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0
YWNobWVudHMNCj4gPiANCj4gPiANCj4gPiBPbiBUdWUsIE1hciAyMSwgMjAyMyBhdCAwMzoyOTo0
NlBNICswODAwLCBIYW90aWVuIEhzdSB3cm90ZToNCj4gPiA+IEZyb206IFdheW5lIENoYW5nIDx3
YXluZWNAbnZpZGlhLmNvbT4NCj4gPiA+IA0KPiA+ID4gV2hlbiB3ZSBzZXQgdGhlIE9URyBwb3J0
IHRvIEhvc3QgbW9kZSwgd2Ugb2JzZXJ2ZWQgdGhlIGZvbGxvd2luZw0KPiA+ID4gc3BsYXQ6DQo+
ID4gDQo+ID4gV2hhdCAiT1RHIiBwb3J0PyAgVGhhdCBpcyBub3QgYSBVU0IgdGhpbmcgYW55bW9y
ZSBhdCBhbGwuICBIb3cgaXMNCj4gPiB0aGlzDQo+ID4gcGFydCBvZiBhIHhoY2kgY29udHJvbGxl
cj8NCj4gDQo+IEkgd2lsbCB1c2UgJ2R1YWwtcm9sZSBwb3J0JyBpbnN0ZWFkLg0KPiANCj4gV2hl
biB0aGUgcm9sZSBvZiBhIHN1cGVyLXNwZWVkIHBvcnQgaXMgc3dpdGNoZWQsIHdlIG5lZWQgdG8g
Y2xlYXIgb3INCj4gc2V0IFhIQ0kgUE9SVFNDLlBQLg0KPiBPdXIgaG9zdCBtb2RlIGNvbnRyb2xs
ZXIgYW5kIGRldmljZSBtb2RlIGNvbnRyb2xsZXIgc2hhcmUgdGhlIHNhbWUNCj4gc3VwZXItc3Bl
ZWQgcG9ydCBoYXJkd2FyZS4NCj4gV2hlbiBhIHN1cGVyLXNwZWVkIHBvcnQgaXMgZ29pbmcgdG8g
YmUgc3dpdGNoZWQgdG8gZGV2aWNlIG1vZGUgcm9sZSwNCj4gd2UgaGF2ZSB0byBjbGVhciBYSENJ
IFBPUlRTQy5QUCBhdCBob3N0IG1vZGUgY29udHJvbGxlciBzaWRlIHRvDQo+IHJlbGVhc2Ugc3Vw
ZXItc3BlZWQgcG9ydCBoYXJkd2FyZSB0byBkZXZpY2UgbW9kZSBjb250cm9sbGVyLg0KPiBXaGVu
IGEgc3VwZXItc3BlZWQgcG9ydCBpcyBnb2luZyB0byBiZSBzd2l0Y2hlZCB0byBob3N0IG1vZGUg
cm9sZSwgd2UNCj4gaGF2ZSB0byBzZXQgWEhDSSBQT1JUU0MuUFAgYXQgaG9zdCBtb2RlIGNvbnRy
b2xsZXIgc2lkZSB0bw0KPiBhY3F1aXJlIHN1cGVyLXNwZWVkIHBvcnQgaGFyZHdhcmUuDQo+IA0K
SSByZXBsYWNlZCBTUyB3aXRoIHN1cGVyLXNwZWVkIGFuZCBQUCB3aXRoICdYSENJIFBPUlRTQy5Q
UCcgaW4gdGhlDQphYm92ZSBkZXNjcmlwdGlvbiB0byBtYWtlIGl0IGNsZWFyLg0KDQo+ID4gPiBb
ICAxNjcuMDU3NzE4XSBCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxlZCBmcm9tIGludmFsaWQg
Y29udGV4dA0KPiA+ID4gYXQNCj4gPiA+IGluY2x1ZGUvbGludXgvc2NoZWQvbW0uaDoyMjkNCj4g
PiA+IFsgIDE2Ny4wNTc4NzJdIFdvcmtxdWV1ZTogZXZlbnRzIHRlZ3JhX3h1c2JfdXNiX3BoeV93
b3JrDQo+ID4gPiBbICAxNjcuMDU3OTU0XSBDYWxsIHRyYWNlOg0KPiA+ID4gWyAgMTY3LjA1Nzk2
Ml0gIGR1bXBfYmFja3RyYWNlKzB4MC8weDIxMA0KPiA+ID4gWyAgMTY3LjA1Nzk5Nl0gIHNob3df
c3RhY2srMHgzMC8weDUwDQo+ID4gPiBbICAxNjcuMDU4MDIwXSAgZHVtcF9zdGFja19sdmwrMHg2
NC8weDg0DQo+ID4gPiBbICAxNjcuMDU4MDY1XSAgZHVtcF9zdGFjaysweDE0LzB4MzQNCj4gPiA+
IFsgIDE2Ny4wNTgxMDBdICBfX21pZ2h0X3Jlc2NoZWQrMHgxNDQvMHgxODANCj4gPiA+IFsgIDE2
Ny4wNTgxNDBdICBfX21pZ2h0X3NsZWVwKzB4NjQvMHhkMA0KPiA+ID4gWyAgMTY3LjA1ODE3MV0g
IHNsYWJfcHJlX2FsbG9jX2hvb2suY29uc3Rwcm9wLjArMHhhOC8weDExMA0KPiA+ID4gWyAgMTY3
LjA1ODIwMl0gIF9fa21hbGxvY190cmFja19jYWxsZXIrMHg3NC8weDJiMA0KPiA+ID4gWyAgMTY3
LjA1ODIzM10gIGt2YXNwcmludGYrMHhhNC8weDE5MA0KPiA+ID4gWyAgMTY3LjA1ODI2MV0gIGth
c3ByaW50ZisweDU4LzB4OTANCj4gPiA+IFsgIDE2Ny4wNTgyODVdICB0ZWdyYV94dXNiX2ZpbmRf
cG9ydF9ub2RlLmlzcmEuMCsweDU4LzB4ZDANCj4gPiA+IFsgIDE2Ny4wNTgzMzRdICB0ZWdyYV94
dXNiX2ZpbmRfcG9ydCsweDM4LzB4YTANCj4gPiA+IFsgIDE2Ny4wNTgzODBdICB0ZWdyYV94dXNi
X3BhZGN0bF9nZXRfdXNiM19jb21wYW5pb24rMHgzOC8weGQwDQo+ID4gPiBbICAxNjcuMDU4NDMw
XSAgdGVncmFfeGhjaV9pZF9ub3RpZnkrMHg4Yy8weDFlMA0KPiA+ID4gWyAgMTY3LjA1ODQ3M10g
IG5vdGlmaWVyX2NhbGxfY2hhaW4rMHg4OC8weDEwMA0KPiA+ID4gWyAgMTY3LjA1ODUwNl0gIGF0
b21pY19ub3RpZmllcl9jYWxsX2NoYWluKzB4NDQvMHg3MA0KPiA+ID4gWyAgMTY3LjA1ODUzN10g
IHRlZ3JhX3h1c2JfdXNiX3BoeV93b3JrKzB4NjAvMHhkMA0KPiA+ID4gWyAgMTY3LjA1ODU4MV0g
IHByb2Nlc3Nfb25lX3dvcmsrMHgxZGMvMHg0YzANCj4gPiA+IFsgIDE2Ny4wNTg2MThdICB3b3Jr
ZXJfdGhyZWFkKzB4NTQvMHg0MTANCj4gPiA+IFsgIDE2Ny4wNTg2NTBdICBrdGhyZWFkKzB4MTg4
LzB4MWIwDQo+ID4gPiBbICAxNjcuMDU4NjcyXSAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANCj4g
PiA+IA0KPiA+ID4gVGhlIGZ1bmN0aW9uIHRlZ3JhX3h1c2JfcGFkY3RsX2dldF91c2IzX2NvbXBh
bmlvbiBldmVudHVhbGx5DQo+ID4gPiBjYWxscw0KPiA+ID4gdGVncmFfeHVzYl9maW5kX3BvcnQg
YW5kIHRoaXMgaW4gdHVybiBjYWxscyBrYXNwcmludGYgd2hpY2ggbWlnaHQNCj4gPiA+IHNsZWVw
DQo+ID4gPiBhbmQgc28gY2Fubm90IGJlIGNhbGxlZCBmcm9tIGFuIGF0b21pYyBjb250ZXh0Lg0K
PiA+ID4gDQo+ID4gPiBGaXggdGhpcyBieSBtb3ZpbmcgdGhlIGNhbGwgdG8NCj4gPiA+IHRlZ3Jh
X3h1c2JfcGFkY3RsX2dldF91c2IzX2NvbXBhbmlvbg0KPiA+ID4gdG8NCj4gPiA+IHRoZSB0ZWdy
YV94aGNpX2lkX3dvcmsgZnVuY3Rpb24gd2hlcmUgaXQgaXMgcmVhbGx5IG5lZWRlZC4NCj4gPiA+
IA0KPiA+ID4gRml4ZXM6IGY4MzZlNzg0MzAzNiAoInVzYjogeGhjaS10ZWdyYTogQWRkIE9URyBz
dXBwb3J0IikNCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBXYXluZSBDaGFuZyA8d2F5bmVjQG52aWRpYS5jb20+DQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBIYW90aWVuIEhzdSA8aGFvdGllbmhAbnZpZGlhLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4g
VjMgLT4gVjQ6IFJlbW92ZSBjb3B5cmlnaHQgY2hhbmdlIGZyb20gdGhpcyBwYXRjaA0KPiA+ID4g
VjIgLT4gVjM6IEFkZCB2ZXJzaW9uIGluZm9ybWF0aW9uDQo+ID4gPiBWMSAtPiBWMjogQWRkICJG
aXhlcyIgYW5kICJDYzoiIGxpbmVzIGFuZCB1cGRhdGUgY29weXJpZ2h0IHllYXJzDQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktdGVncmEuYyB8IDcgKysrKy0tLQ0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4g
PiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktdGVncmEuYw0KPiA+
ID4gYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktDQo+ID4gPiB0ZWdyYS5jDQo+ID4gPiBpbmRleCAx
ZmYyMmY2NzU5MzAuLmI0MGU4OTdlYzA5MiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNi
L2hvc3QveGhjaS10ZWdyYS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktdGVn
cmEuYw0KPiA+ID4gQEAgLTEzNjAsNiArMTM2MCwxMCBAQCBzdGF0aWMgdm9pZCB0ZWdyYV94aGNp
X2lkX3dvcmsoc3RydWN0DQo+ID4gPiB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiA+IA0KPiA+ID4g
ICAgICAgbXV0ZXhfdW5sb2NrKCZ0ZWdyYS0+bG9jayk7DQo+ID4gPiANCj4gPiA+ICsgICAgIHRl
Z3JhLT5vdGdfdXNiM19wb3J0ID0NCj4gPiA+IHRlZ3JhX3h1c2JfcGFkY3RsX2dldF91c2IzX2Nv
bXBhbmlvbigNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHRlZ3JhLQ0KPiA+ID4gPiBwYWRjdGwsDQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZWdyYS0NCj4gPiA+ID4g
b3RnX3VzYjJfcG9ydCk7DQo+ID4gPiArDQo+ID4gDQo+ID4gWW91IGhhdmUgMTAwIGNvbHVtbnMs
IHBsZWFzZSB1c2UgdGhlbSwgZW5kaW5nIGEgbGluZSB3aXRoICIoIiBpcw0KPiA+IG5vdA0KPiA+
IGdlbmVyYWxseSBhIGdvb2QgaWRlYS4NCj4gDQo+IEkgd2lsbCByZXN1Ym1pdCBhIG5ldyBwYXRj
aC4NCj4gDQo+ID4gdGhhbmtzLA0KPiA+IA0KPiA+IGdyZWcgay1oDQo=
