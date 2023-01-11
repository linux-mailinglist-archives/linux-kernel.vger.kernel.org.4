Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEAE665E41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjAKOq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjAKOqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:46:24 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A9C644D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:46:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjM2XCoao/kT37hDXRRIkzDDRf+PCmTNKTOrmp7L3LB2gt9lD1j2e8uKQcyVxbA2sJgeUlYt1UiSGmj4f2d/3fBJNJKUCK7dG1O73V/aNr44M6FD2r3qykIVohaH83jzJ33ibTRKJlePFNk01O5502RRcObe3xXExWmTtfa0h4nSIowA53vU+6e2Ecx85N5PdA4y21FYlbPN2DlkyzpWlODhwbaaZKJCIdTJGOavyGkhNBhMVU/Sv6285/7ivnDRW1trsciwL6VlGo19efekEo4EcOzpMw9iBV8rZpDHvIxtRpW4tAnPb5nZN4JJqcKr5O0hkzOiGlPcEFI/k3riuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlwZJvU8vG59FneTm0Ax/O/tiJ+uDgXeRkltikcGmbI=;
 b=fJoNdz8VCw3S2ooBTKBi8GAxLtW2mtNPV4NheR0BaltmNvg++pujy7jl6xKV550wr27OoMu5oLTYDB3C9grcBJ/C8bd0wHOmxbEoQnt9urPG81w5gNtRFbXmZSKrdnfyclvwkS4K1qyhJKEEtraShCboUIqU8P396sJE4u5qAteUEmLlq6JUYFtpTRue9qgyCovlwmdr+97FviyE2XdWnbB71vm5oZHkaWYOoVEdmHHVVYhrPMxX+CSpGqKa29kwkUHlY9BZaEqIt3zCWt7JFCx3Z5SCDgE9o65nr1untJ3BTsEW8Kv8DOQU6TXOl6ZeuV7GqeVXRqx/H8WOvRdyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlwZJvU8vG59FneTm0Ax/O/tiJ+uDgXeRkltikcGmbI=;
 b=eOjWKXOkAtdBTBQuosA6E5BAN41eoZ2lrMd03lXU9MhuMBu65RF4bfTUN0kgIeWJQkqqpxuV50KDm0TI908G793rkkPf1+QjCoppK9fPA16FjhM+t54zZtCh4oCa7nte0j5gps8fS2oXu3gLAwp+mINbFRhst7gQXn9QcOx7Wyuxvou95cXqyVccKe40YBh4O4SY2W6a4nEhoneR5GyadiKOPiivqOmWYuvXe5qLIfgOusW4B1z/b8/SM0tCl0kI2OsIMCN+xuTEkW4FGQIwe+Meg3/HZjlPLP6KJJ1Mw+U9FizGvIdbS1+CTS7P61oqHlTT5jZrujG/3IdVtOsCbQ==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Wed, 11 Jan 2023 14:46:20 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 14:46:20 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Subject: RE: [PATCH 1/5] virtio_ring: per virtqueue dma device
Thread-Topic: [PATCH 1/5] virtio_ring: per virtqueue dma device
Thread-Index: AQHZJYXp/exib+Y5JEShlN8ZA2yzKK6ZNvrwgAAF4wCAAA5B8A==
Date:   Wed, 11 Jan 2023 14:46:20 +0000
Message-ID: <DM8PR12MB54008B92885A8971C4CFED0EABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-2-jasowang@redhat.com>
 <DM8PR12MB5400E61C7E968AC7604556EBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20230111085210-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230111085210-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|CY8PR12MB7098:EE_
x-ms-office365-filtering-correlation-id: 558bd5d9-ba8e-48c2-4b8e-08daf3e29a80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjipaeL+22E6umMv0ECFyBARMEPHZiaZhf2V2vIFW1PaiV/G8VPISR/v2f5ghek8bRNbkgO07Cu8GJwBBaDG1unHpga1oynu/tS6DsUrJ9JPD19KUHAeKIbq72xAC7ri/pqqajBGfGPqI9xo1gqvy8KsWwfb/erqdBnMKmXOMSTA7+BnLUIbHpYd4/p5xxcthE4+8vdJMXuH5qgbEyHfrRWBt25i3PwHYTyZo+XSDah4rDCrZnMf/GWSczVFjuC5uzDmwcKBDxZLDPJKrOHTux2cNocT+m2q33UcwXFSmIwVmRFl4ZGbzVbrHaSFqWZbSE2kEL4ZxZ7DljWD4uWLiOdBRnp+W0wTXkM24WrPGvcLN7+hjZglzH0CrUlnFLUr0pEiijc1sl8bbtFcWXQOGw22QIy/Cr8780/9zeF9NqDOj2W+GUZvpB12ax86CZDO7TO/lALwOCzgUNpMnJla5/oU//jjlIotyTnZaBcwHUtRyvnHvFDXmAQZgQAeiM9U9khMCr2N+Xh736lKD00q8xdfnNUVtKSuYxSF/h414Xr5O8DyagJhWBVCAQP7KIqht4xtgPF1TbkswBwLRaWiMJLgXM2STqFGzGlrxH5bjldGv+gfgUibohnCq5Rcc0Z/1ujJyNR2YG69lnGmbm6OEu0X7GLKlvUN3TzMyy1C3Nu6tFpFnLGfhIORhw7T4S2YnBhFrawNGLPn3oMrxyaYyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(8936002)(38070700005)(4326008)(76116006)(66556008)(66446008)(2906002)(64756008)(66476007)(52536014)(66946007)(6916009)(5660300002)(33656002)(122000001)(8676002)(38100700002)(83380400001)(86362001)(71200400001)(478600001)(7696005)(316002)(6506007)(55016003)(54906003)(41300700001)(53546011)(26005)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXRuZ0crUTBlL2t1ci9sYmxnM0p3b0dTbGZidzh4Z1NieUZMOE14cXN6Wi9T?=
 =?utf-8?B?Qno2Z3ViSmZoMXM4eHlhWFRHR2NBUkZueW1XLzU1ODhCZkEyb0tZVCtFUnRY?=
 =?utf-8?B?RFczZXpKNHRPZXkrM1U3dEVvdGNaU3ZrWTFUSk53L0hGTHFaMEtSSTM1b0dm?=
 =?utf-8?B?ZGpLTkk0Ukw3YkpmVWNLb0JUTDk5M0pRa1BuNjdiYTZ4S2tDWFhWZEF1a1hs?=
 =?utf-8?B?Qm9xMjNXQzB3ZlMxd0FTeVlJa1EwV0hWOVZ2THF1K0EvK01wZitoNkhkb0lx?=
 =?utf-8?B?WUVyTVB6alJFbzJxbGE5RmdtMVFrc3d0Nm1QTlFzUnRiRlRrVUV3RGgzKzJl?=
 =?utf-8?B?cDVJV0taZzM5VmdhYUlna1V1R1ZNeXF6NCt5TnRBSDZmWTNkcm9qMERYRllQ?=
 =?utf-8?B?SmRMNzVHNko3ZGRQLzhybUMveFFNQ3MwR0U3MGRON2VGYlc1UzNYbEVCdkxZ?=
 =?utf-8?B?RXErT2kyWUxKcW4xQWpzVURwM1NQZUd1V3hYNWVQT1R3RThrcDRkcFZad1hR?=
 =?utf-8?B?dFNhdmpLcHIxSThsdkNieHBWY2NOOG84QkhaYnIwdjU3UCtTUi9LclVpbUgr?=
 =?utf-8?B?SHBWL3ZVL2tOdmFSSndBM1BVeWFDWE95MFhzWUZpUHFCbjFTQWFYQWZDRklE?=
 =?utf-8?B?ZHBsbDFTc1dXQXdHUTJyT256amlUWktBSTlnVUM1QTVvTlNGM3hqdHFWMzdi?=
 =?utf-8?B?aWg4SHNINWFNWWc4bEpaUnZ5d2VaaUVLUFJDL200MVA5UXBvZU1ZVTYxRXRj?=
 =?utf-8?B?UzM0dlMwQnExZjhMWjZJWFlWUHkxUndtWFdodHpxT1cxMERtaWdTaHg4d0Nh?=
 =?utf-8?B?SmNEei9xVjN0WVg3K3F2dUovaHplZitPMnlBd0VqK1ZiblJJdmZCZjZzN1Bv?=
 =?utf-8?B?bWZnaUZSY0ZCUXpja09FVDY4aHJ6OTNOWXJZWnpjOGh4WDVmazIrSG9teDNq?=
 =?utf-8?B?WiswWjVOMzZHYnlhSWdaWE02eDBsOXZCYWxwcTFnWjZnTzhuUm0yb3kwcE5I?=
 =?utf-8?B?OXdkV0V6bnhJK1ZWbEZtTFl1bGJrMTVUZ1RURDlMbGxWUkZiL2RyeE5UL3Zr?=
 =?utf-8?B?aDdhSDFNVmJjejVTMHpSTFlTS1djd2VKU0krNU5ndzZ0WUNzNmJLZUc5YlRk?=
 =?utf-8?B?UUhMbnRka1ZubFVMQTZhS0xsR0VMcWpHeVhYYU10bGlhMStFMm56MEtsN0tx?=
 =?utf-8?B?NjJaSk9nRlduNHNqdUhFV01VbCttVWU4US9VZWhqQ0x2VjdtU2Z1a2N3emdZ?=
 =?utf-8?B?eVdQRGFsdE92WUhDR1VOa0o1NnlMdGtTTWhXRG5iSVdrQlFsVmN1UjNHY2Ru?=
 =?utf-8?B?UjYvcHhqdWphdHd5bHZtTlRQY0lBWGRsU2JqeExMVWFQWGJmaEphc3pPeTBz?=
 =?utf-8?B?K0MxdEJ5ejBoWG8rb1J4Y1R5eW1CeUhlZERzUE90eTJ2ZzB6TjR2a0lnWkt3?=
 =?utf-8?B?cFBmUERjaWVRL0toYVFEMEltbllDd3JHZXhLSXNuTWE3NEZESDluNFNPcWh0?=
 =?utf-8?B?ajZUSXZUNWEwakh4UFRvaEw0eGhJMEU1RlZRWnlEditybkFITm1nbUZmMTlM?=
 =?utf-8?B?UjJsSUcxeEEvNUtUNFd5UXNXUzdEcDByUnhkMFBkT1B2MXVnbmdPc0hDS2Vu?=
 =?utf-8?B?WG1mUEFXdmlMSG9RbTJWRlMraG1sMGxreENjWUxRSGlUTlFhTFFrZFRCTVI3?=
 =?utf-8?B?K2h2b0d6aFNJakZPSXRBb2dZRVVleHROQmRWeTMwaVJyQU12Sk9rclkxaGJH?=
 =?utf-8?B?bmVkOFgrSGN5TmdVclBtVlIwOWtQTlA3M1Z5bVVUdmt4cFExSzhKQVdvbmlh?=
 =?utf-8?B?cUhsV0M4L0tRNER3UFNuQXR0UmpFbUxPTDI5dmJXdWdsdWpwMGRJMGE0RnlI?=
 =?utf-8?B?am5wUC9HcDg0RjB4K09SWi9tUmY4TGYyK0hOR3UwQUE5VXZSbjI1Tk5iWit6?=
 =?utf-8?B?QVBIOTNaVmo0TWpxc2NuQ0M1dmdtUVJQNjNDL2lyZnhFbGtFRzRkTjRJZkZw?=
 =?utf-8?B?Rjd0eEV6ZWtrUXk4d3JXMkhoSU50YWtCcnlnMnNyZ3J6dVdlTEdnYnoxSzhI?=
 =?utf-8?B?MlI2UmlTVlRucUlwUkFzRHRCTzBzN2d6WWlqOE5ETEMwV056UnBkSFFrRlN2?=
 =?utf-8?Q?0nWI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558bd5d9-ba8e-48c2-4b8e-08daf3e29a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 14:46:20.6447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPsmr7R8W9oP/n5edpSfYiwPssOSdjqGj21Lok5Eb6m059rPZZCJO4N4573PQUsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIDExIEphbnVhcnkgMjAyMyAxNTo1Mw0KPiBUbzogRWxpIENvaGVuIDxlbGljQG52aWRp
YS5jb20+DQo+IENjOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsgZ2Rhd2FyQGFt
ZC5jb207DQo+IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiB0YW51ai5rYW1kZUBhbWQuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS81XSB2aXJ0aW9fcmluZzogcGVyIHZpcnRxdWV1ZSBkbWEgZGV2aWNl
DQo+IA0KPiBPbiBXZWQsIEphbiAxMSwgMjAyMyBhdCAwMTozMjoyMFBNICswMDAwLCBFbGkgQ29o
ZW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0K
PiA+ID4gU2VudDogV2VkbmVzZGF5LCAxMSBKYW51YXJ5IDIwMjMgODoyOA0KPiA+ID4gVG86IG1z
dEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tDQo+ID4gPiBDYzogRWxpIENvaGVuIDxl
bGljQG52aWRpYS5jb20+OyBnZGF3YXJAYW1kLmNvbTsNCj4gPiA+IHZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiA+ID4gdGFudWoua2FtZGVAYW1kLmNvbQ0KPiA+ID4gU3ViamVjdDogW1BBVENIIDEvNV0gdmly
dGlvX3Jpbmc6IHBlciB2aXJ0cXVldWUgZG1hIGRldmljZQ0KPiA+ID4NCj4gPiA+IFRoaXMgcGF0
Y2ggaW50cm9kdWNlcyBhIHBlciB2aXJ0cXVldWUgZG1hIGRldmljZS4gVGhpcyB3aWxsIGJlIHVz
ZWQNCj4gPiA+IGZvciB2aXJ0aW8gZGV2aWNlcyB3aG9zZSB2aXJ0cXVldWUgYXJlIGJhY2tlZCBi
eSBkaWZmZXJlbnQgdW5kZXJsYXllcg0KPiA+ID4gZGV2aWNlcy4NCj4gPiA+DQo+ID4gPiBPbmUg
ZXhhbXBsZSBpcyB0aGUgdkRQQSB0aGF0IHdoZXJlIHRoZSBjb250cm9sIHZpcnRxdWV1ZSBjb3Vs
ZCBiZQ0KPiA+ID4gaW1wbGVtZW50ZWQgdGhyb3VnaCBzb2Z0d2FyZSBtZWRpYXRpb24uDQo+ID4g
Pg0KPiA+ID4gU29tZSBvZiB0aGUgd29yayBhcmUgYWN0dWFsbHkgZG9uZSBiZWZvcmUgc2luY2Ug
dGhlIGhlbHBlciBsaWtlDQo+ID4gPiB2cmluZ19kbWFfZGV2aWNlKCkuIFRoaXMgd29yayBsZWZ0
IGFyZToNCj4gPiA+DQo+ID4gPiAtIExldCB2cmluZ19kbWFfZGV2aWNlKCkgcmV0dXJuIHRoZSBw
ZXIgdmlydHF1ZXVlIGRtYSBkZXZpY2UgaW5zdGVhZA0KPiA+ID4gICBvZiB0aGUgdmRldidzIHBh
cmVudC4NCj4gPiA+IC0gQWxsb3cgcGFzc2luZyBhIGRtYV9kZXZpY2Ugd2hlbiBjcmVhdGluZyB0
aGUgdmlydHF1ZXVlIHRocm91Z2ggYSBuZXcNCj4gPiA+ICAgaGVscGVyLCBvbGQgdnJpbmcgY3Jl
YXRpb24gaGVscGVyIHdpbGwga2VlcCB1c2luZyB2ZGV2J3MgcGFyZW50Lg0KPiA+ID4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTMzICsrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gPiAgaW5jbHVkZS9saW51eC92aXJ0aW9fcmlu
Zy5oICB8ICAxNiArKysrKw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTA5IGluc2VydGlvbnMo
KyksIDQwIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYw0KPiA+ID4g
aW5kZXggNzIzYzRlMjllMWQzLi40MTE0NGI1MjQ2YTggMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jDQo+ID4gPiBAQCAtMjAyLDYgKzIwMiw5IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgew0KPiA+ID4gIAkvKiBETUEsIGFsbG9jYXRpb24sIGFuZCBzaXplIGluZm9ybWF0aW9uICov
DQo+ID4gPiAgCWJvb2wgd2Vfb3duX3Jpbmc7DQo+ID4gPg0KPiA+ID4gKwkvKiBEZXZpY2UgdXNl
ZCBmb3IgZG9pbmcgRE1BICovDQo+ID4gPiArCXN0cnVjdCBkZXZpY2UgKmRtYV9kZXY7DQo+ID4g
PiArDQo+ID4gPiAgI2lmZGVmIERFQlVHDQo+ID4gPiAgCS8qIFRoZXkncmUgc3VwcG9zZWQgdG8g
bG9jayBmb3IgdXMuICovDQo+ID4gPiAgCXVuc2lnbmVkIGludCBpbl91c2U7DQo+ID4gPiBAQCAt
MjE5LDcgKzIyMiw4IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlDQo+ID4gPiAqX192cmluZ19u
ZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwNCj4gPiA+ICAJCQkJCSAgICAgICBib29s
IGNvbnRleHQsDQo+ID4gPiAgCQkJCQkgICAgICAgYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRx
dWV1ZSAqKSwNCj4gPiA+ICAJCQkJCSAgICAgICB2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0
cXVldWUNCj4gPiA+ICopLA0KPiA+ID4gLQkJCQkJICAgICAgIGNvbnN0IGNoYXIgKm5hbWUpOw0K
PiA+ID4gKwkJCQkJICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsDQo+ID4gPiArCQkJCQkgICAgICAg
c3RydWN0IGRldmljZSAqZG1hX2Rldik7DQo+ID4gPiAgc3RhdGljIHN0cnVjdCB2cmluZ19kZXNj
X2V4dHJhICp2cmluZ19hbGxvY19kZXNjX2V4dHJhKHVuc2lnbmVkIGludCBudW0pOw0KPiA+ID4g
IHN0YXRpYyB2b2lkIHZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKTsNCj4gPiA+DQo+
ID4gPiBAQCAtMjk3LDEwICszMDEsMTEgQEAgc2l6ZV90IHZpcnRpb19tYXhfZG1hX3NpemUoc3Ry
dWN0IHZpcnRpb19kZXZpY2UNCj4gPiA+ICp2ZGV2KQ0KPiA+ID4gIEVYUE9SVF9TWU1CT0xfR1BM
KHZpcnRpb19tYXhfZG1hX3NpemUpOw0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgdm9pZCAqdnJpbmdf
YWxsb2NfcXVldWUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHNpemVfdCBzaXplLA0KPiA+
ID4gLQkJCSAgICAgIGRtYV9hZGRyX3QgKmRtYV9oYW5kbGUsIGdmcF90IGZsYWcpDQo+ID4gPiAr
CQkJICAgICAgIGRtYV9hZGRyX3QgKmRtYV9oYW5kbGUsIGdmcF90IGZsYWcsDQo+ID4gPiArCQkJ
ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRtYV9kZXYpDQo+ID4gPiAgew0KPiA+ID4gIAlpZiAodnJp
bmdfdXNlX2RtYV9hcGkodmRldikpIHsNCj4gPiA+IC0JCXJldHVybiBkbWFfYWxsb2NfY29oZXJl
bnQodmRldi0+ZGV2LnBhcmVudCwgc2l6ZSwNCj4gPiA+ICsJCXJldHVybiBkbWFfYWxsb2NfY29o
ZXJlbnQoZG1hX2Rldiwgc2l6ZSwNCj4gPiA+ICAJCQkJCSAgZG1hX2hhbmRsZSwgZmxhZyk7DQo+
ID4gPiAgCX0gZWxzZSB7DQo+ID4gPiAgCQl2b2lkICpxdWV1ZSA9IGFsbG9jX3BhZ2VzX2V4YWN0
KFBBR0VfQUxJR04oc2l6ZSksIGZsYWcpOw0KPiA+ID4gQEAgLTMzMCwxMCArMzM1LDExIEBAIHN0
YXRpYyB2b2lkICp2cmluZ19hbGxvY19xdWV1ZShzdHJ1Y3QNCj4gdmlydGlvX2RldmljZQ0KPiA+
ID4gKnZkZXYsIHNpemVfdCBzaXplLA0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAgc3RhdGljIHZv
aWQgdnJpbmdfZnJlZV9xdWV1ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgc2l6ZV90IHNp
emUsDQo+ID4gPiAtCQkJICAgICB2b2lkICpxdWV1ZSwgZG1hX2FkZHJfdCBkbWFfaGFuZGxlKQ0K
PiA+ID4gKwkJCSAgICAgdm9pZCAqcXVldWUsIGRtYV9hZGRyX3QgZG1hX2hhbmRsZSwNCj4gPiA+
ICsJCQkgICAgIHN0cnVjdCBkZXZpY2UgKmRtYV9kZXYpDQo+ID4gPiAgew0KPiA+ID4gIAlpZiAo
dnJpbmdfdXNlX2RtYV9hcGkodmRldikpDQo+ID4gPiAtCQlkbWFfZnJlZV9jb2hlcmVudCh2ZGV2
LT5kZXYucGFyZW50LCBzaXplLCBxdWV1ZSwNCj4gPiA+IGRtYV9oYW5kbGUpOw0KPiA+ID4gKwkJ
ZG1hX2ZyZWVfY29oZXJlbnQoZG1hX2Rldiwgc2l6ZSwgcXVldWUsIGRtYV9oYW5kbGUpOw0KPiA+
ID4gIAllbHNlDQo+ID4gPiAgCQlmcmVlX3BhZ2VzX2V4YWN0KHF1ZXVlLCBQQUdFX0FMSUdOKHNp
emUpKTsNCj4gPiA+ICB9DQo+ID4gPiBAQCAtMzQxLDExICszNDcsMTEgQEAgc3RhdGljIHZvaWQg
dnJpbmdfZnJlZV9xdWV1ZShzdHJ1Y3QNCj4gdmlydGlvX2RldmljZQ0KPiA+ID4gKnZkZXYsIHNp
emVfdCBzaXplLA0KPiA+ID4gIC8qDQo+ID4gPiAgICogVGhlIERNQSBvcHMgb24gdmFyaW91cyBh
cmNoZXMgYXJlIHJhdGhlciBnbmFybHkgcmlnaHQgbm93LCBhbmQNCj4gPiA+ICAgKiBtYWtpbmcg
YWxsIG9mIHRoZSBhcmNoIERNQSBvcHMgd29yayBvbiB0aGUgdnJpbmcgZGV2aWNlIGl0c2VsZg0K
PiA+ID4gLSAqIGlzIGEgbWVzcy4gIEZvciBub3csIHdlIHVzZSB0aGUgcGFyZW50IGRldmljZSBm
b3IgRE1BIG9wcy4NCj4gPiA+ICsgKiBpcyBhIG1lc3MuDQo+ID4gPiAgICovDQo+ID4gPiAgc3Rh
dGljIGlubGluZSBzdHJ1Y3QgZGV2aWNlICp2cmluZ19kbWFfZGV2KGNvbnN0IHN0cnVjdCB2cmlu
Z192aXJ0cXVldWUNCj4gKnZxKQ0KPiA+ID4gIHsNCj4gPiA+IC0JcmV0dXJuIHZxLT52cS52ZGV2
LT5kZXYucGFyZW50Ow0KPiA+ID4gKwlyZXR1cm4gdnEtPmRtYV9kZXY7DQo+ID4gPiAgfQ0KPiA+
DQo+ID4gSG93IGFib3V0IGdldHRpbmcgcmlkIG9mIHRoaXMgZnVuY3Rpb24gYW5kIGp1c3QgdXNl
IHZxLT5kbWFfZGV2Pw0KPiANCj4gV2lsbCBtYWtlIHRoZSBwYXRjaCBldmVuIGJpZ2dlciB0aGFu
IGl0IGlzLg0KDQpJIGNhbid0IHNlZSBob3cgdGhpcyBjYW4gaGFwcGVuLiBZb3UgZ2V0IHJpZCBv
ZiB0aGUgZnVuY3Rpb24gYW5kIHlvdSBsb3NlIG92ZXJhbGwgMTAgbGluZXMuIFdoYXQgYW0gSSBt
aXNzaW5nPw0KDQo+IElmIHlvdSBkbyBwYXRjaCBvbiB0b3AgcGxzLg0KDQo=
