Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284345E730A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIWEiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiIWEiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:38:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA8122A60;
        Thu, 22 Sep 2022 21:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNjIaMT7AyLM1P/E3lc0R3FN8iZtIWpD8dOqZ8Zxl6wCmPmdNVeYdeFgXctLlTZRyPrfeTjqh411/EivsVwS3GzgGZVPK3c6HLrjqt1CAVc8Pd+o6ZMlYM4rJuT5GzTwwUA9wau8qZgZdIZiVBVwEnJO5LZmlkGNDuqzaVGrWg6BxGRN3mp+TcS81tbTjuSnHVEowvGWLhZ9QfzRH506PxGdY8NtFac9xgd8Sik44QyBXTMimaAn8d4H1+ce/0Bo78FGhOTfQ+Aq7E9NoImf56vJq6YHI1QhR6+6afRl5XVWloXQLjNWsPFPn2JayA9+nvVAv5XQpROf3fj9ihLHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ7yDIP05Fe8jY+VWwbnti5lizldnZ2mkXy70obdbIU=;
 b=K6vIFeH4flAel8gDN8FxLBqPeJG788ti6IQKOS5TNsqicG5nchozKwhX1nCTKtlGQ6cXY4Jr7KloP2jwDLifbuekdZkUwzBadL4F/ywUgGlmAKdQgeMbXldeLBbz97Eencb9O+YbcjlOocR9z3LKzCPkGlGmUbrgFuav72y5DudHQBxxnvG+RD8IKDIlhgYBZFIGaWGnB9VJeQFVNnq1dO3R451gT1MTxhxHNkHUDaBOMya7pUqeT3o9mswIFglQeGKbIsfuUYbBWqwdRi5ikOFgpsUsPwQQKjA4WZ740GQMR+QmfsM2/Fk9kS6j4xZUJKhgLbhqGkxnZfhxWLBA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ7yDIP05Fe8jY+VWwbnti5lizldnZ2mkXy70obdbIU=;
 b=En109etM6wWwhGJUMAU69Zao5e1fvJASnIFU84b4oIdNXIg35LFRow2hXqx/VimS9ZkLQOH07YEI9gM9Wrz1mLf/ayO8HWPHQwzk4fzZxYxJJDCGJF0znX/fP9oXsw2NDMrOv6NHWVR81qUt2gA+BB5ckPs9MjQD51YL4ELWspk=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 04:38:05 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::1438:15a9:cb60:6f03]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::1438:15a9:cb60:6f03%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 04:38:05 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: RE: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Thread-Topic: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Thread-Index: AQHYxoXS/6kPrZnbm0ah5M+XCTD+5K3dF3KAgAHHNvCAAVMmAIAABZkAgAGkkQCACYWfgIABFjDA
Date:   Fri, 23 Sep 2022 04:38:05 +0000
Message-ID: <MN2PR12MB4333EBFADEDD7DB623F4634188519@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20220912085730.390555-1-piyush.mehta@amd.com>
 <4cc7a6d2-64ef-c176-21ad-4c3e66f664f7@linaro.org>
 <MN2PR12MB43330B57F5CFBEC35105665188469@MN2PR12MB4333.namprd12.prod.outlook.com>
 <05ce5c7c-c7e2-cac1-341a-5461804f96ea@linaro.org>
 <46b9bb31-efb5-1e1f-9d01-3841661293dc@amd.com>
 <00368da8-bf24-da5a-15da-dbc1a6a716e8@linaro.org>
 <1824afba-c249-f5d1-e504-d71bf7d79979@amd.com>
In-Reply-To: <1824afba-c249-f5d1-e504-d71bf7d79979@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|DS0PR12MB6654:EE_
x-ms-office365-filtering-correlation-id: 08f57b2a-9a02-4ecb-68b2-08da9d1d681a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qZyTzYvnDrpRI6n8Wxr+tDa5mzqt4neYaEx1HcDiuCV/bZ1BE4+EUavv7IJ9pYpyJ+Po/1Arrt7ut5xCCZBoPwiwUbxha88rovlANeixdddhb3YguibwRvmRXBHcGPM2NaOckzPAODTYF1fwhU/ZMVLXohCHgjNpBLdl5Cfz44SnFKPfkWx59XeIt2oPbv/YtK+wxqmS9kxZTYs9dP4xAQE6J2wCyvlZewPzFebmb7eVfZRZi/5VnuLGWBpH91AtYwLutgZ2wmlMDexXPWdpZlNDBMTmHEtrDpUcYVHwi5v5A/ETM5CxwwBnBroeCs/iImmxQNCW0yawe9Mq1ssFu4a5eAzT2B7ZTfvod2oUkvHA5WJVJjX7GTE8zsUWZ52nU6EGjP7Wzblj4EaAr0tuLgLFY24ZQjwkPyeDMe99pt36h2ApZj9alnioSOZWv1QRiF+K02+uEWRxGctTdVue0pg+e2MczbezevmcsQK810Rksik9vX/9KlUNxItBbXZ7b1x/SDvzEsz3D7GT6w8BKt2JBn57NUJu33vSbL54eGk/38fKLTAMOYKyyHVoUrOZxVRSCNB71VIZqlh1R1P4Ph09z9EaUfDwGyVn+/JiDpXMj1AMQFEOrea8KDviPrkjib2jLzrzVWzu3xfWhxE5Vi3juxydKS3490u4SIqbfjs3dtPxu/LPkGkDqT3XwkoWI08VEmnMsSltCpJ4vo53k1WYDGeMmJETWlO2YLte+mRczYANFERu9Vwh852D5JBH0gjk5UTe/hgwdsGknrXCvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(83380400001)(71200400001)(38100700002)(7696005)(6506007)(53546011)(122000001)(5660300002)(316002)(186003)(54906003)(110136005)(76116006)(2906002)(66946007)(66556008)(66476007)(9686003)(38070700005)(33656002)(41300700001)(107886003)(52536014)(8676002)(4326008)(64756008)(8936002)(66446008)(478600001)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVdhbElXTWVjQWpieFZJcVI0VzllN3I4UGwxOTd6Q3dEQkZCcVJ5S1ZDQUIz?=
 =?utf-8?B?KzNaTTJaelRGZWVGYWwrSlhTM0ZWN2MrVW5JSE5WZm10NXV1N3Nya3BXS3ky?=
 =?utf-8?B?dzB4bU0xOWk0a0dFSHdOUDYzWFU2Wm5BanVReWplQjByNHZlTGRJRFp1N0hN?=
 =?utf-8?B?T3huUVI3Z2tGcVhSNkkweDJqYmZ5azlGazRJQlg4dE5SRmxKd0V6N0lFZWtM?=
 =?utf-8?B?TjZ3ZXFYK28rM3N5a2ZrRkcrbzRQY0Q3Smt0NUMzRkp1TjcrUFJzT2laT3dL?=
 =?utf-8?B?L1pKZnN3dHBOa3VKNWxwdU9ETVlWd1UvdFgrcGJuZ2hwQTlPYkV1dDU1N3Ix?=
 =?utf-8?B?TUYvQkt6R3Z1QVFscmdrMDZaN3NEd2lIamdlTUo1dklBOWpEMXB0V2R3VGZu?=
 =?utf-8?B?MmZkT204cXV4MWdaQ3orcEVudHhEYXNMUkdiNGNNaDlCdlh3L0dHRjVTMnl6?=
 =?utf-8?B?bDF5ZmJObVl4bUJPZ1ovRGYrVE5YdEtmM0RKQU1KZ01jcWZmNy83ZDkveGpi?=
 =?utf-8?B?S2JnWm9iMFpJbm42NFVXUnQvd3ZPWUxoMm1pWVVtb1VCMTdIQjNDamNsRUN3?=
 =?utf-8?B?QlBVZ3VQM2R4RFVSdml0eTFXTUtIY1Q2RE5QeENIWlRGTDUzUzJaVUoveEdO?=
 =?utf-8?B?RDdkQ3ErT2ZEdnNiZTFkTjU2MGg3Ri9tWGJ5bzJ4NHV0QWI0amdxT3RnRFU2?=
 =?utf-8?B?Vy92SW1tSVl0ampEUW95emg1UmlCZ1NhNUFtSjJJZlZxWnNIc1lyVnhzWWlK?=
 =?utf-8?B?Z2NjQWlGbklHSDdjcGpxR08rNjhKTmNOVnZsbzNST0lneXhEYzN4WGJVQVdC?=
 =?utf-8?B?bVQvN2Ivb1VwSzJQYTE4SzdYRlhMcTBuNHlROVUwMFNyVk1QVE5vSnJ3K25N?=
 =?utf-8?B?R05nM2E0dmRkZGRsQWgzcmRmc0R0bDZOYkxNaWlDRW5kNTRBQVBLWE1DKytI?=
 =?utf-8?B?MFRKVTg3NlRMRmRXalpFbHo4WkJjVVpsLzR1Ym95L3g5TmErL29xTXlvWndy?=
 =?utf-8?B?dFlXWEN6MFVQTzFwUjRyOThxcXQwUmpVS3lyc1g2bldnVC95TkxUWDFSNUJy?=
 =?utf-8?B?aUFjbzZRaUxxdmFRd0RZNElrVnVGZWpsMVBZRUR4WTZKYnlKQkhSOVpRcFY1?=
 =?utf-8?B?MVdxRWRvZWwzdTJsbVQwVmZJZlQ1V2RSbk0vck92R25DSXFtcVZ6YVAxVjF0?=
 =?utf-8?B?aXRvKzBvbE50Rk1ZNG9hMkNSNHdJQ0RSbDM0eXJyd3MyK3VmZ3NxOUNEUFpj?=
 =?utf-8?B?Rkt6cG52Ry9vVHUyaDVhNHMzVHUyWWkxOUxHd0svN1ZjZVZQSnQvTDVVRkkx?=
 =?utf-8?B?VFlFTDB0YmJIWno0bERYbGRsbHpHQzEyNHMzUkdybzdUYmpyVzhKNldGbk5p?=
 =?utf-8?B?Q0VULzVGa0dQSG1qWWcwTTRsUjljd1dhcU5qWXp1MWRuYnZnWENqZjZwQ292?=
 =?utf-8?B?K0NzNlFtQWZ4RkhkYVlNNUZwNDNCR0xHU2Y0ZnV0NG1yR2JTZnQxRkxEWldG?=
 =?utf-8?B?bkpqUWJ2eEdDejRyMHJjSHZxMWJyOVYxQTc4cTIvOEtwblljZDhZbDVERUxC?=
 =?utf-8?B?UktkelplQm50RUlBMFUxWWJPMlNwUlNRbkdGa2tRRU9PWGIyMkdNR2x1UCsr?=
 =?utf-8?B?TkUxT0VpNWF4L1o5NllXU0N3K2NjamNKeC82OTJMWVdYNzFHMmp1UzF6Yjl1?=
 =?utf-8?B?TkRCekZqVXlPMjFFaUZFeFU2OVlZN1Nid0FLZjVtUFg2amtEQmk3cmhUVWJa?=
 =?utf-8?B?L0tYdndWczEzUGpnMlVRLzV1RkFyOFZYbk5OMWwxSkJyNStwWmxBRW9XVTBM?=
 =?utf-8?B?bFNIQkZ3eDRUTUMxS3ZEYklTNFh0clJlUnFlK0Rmdk9lQjlDZExmZ2ZZR3h0?=
 =?utf-8?B?UG1iQXlkdUhNUm50ZCtocWVJRnU1dEF4c0pLdGpWNk5HdTJFdEF1QTFoWFR1?=
 =?utf-8?B?LzBrTVdpeUFZZXRIcGlFMTlyVmpOVXNjTyszaUhsNVhHNU5uL0ZPSU93Qlpu?=
 =?utf-8?B?RGNKUXZIMndadmNjVE5Ebyt2ekd0RTkyR0lBZjhxamdRNmFCbFJGUzIyOHI4?=
 =?utf-8?B?TTVsNEVEQm9vcEtockdVVk5SNjU3ZjI5T2sveStCUTBucHA2b1ZOYWtUWUhY?=
 =?utf-8?B?OTRmYU9xK2p4c2kyWERyRW5jVU80NzREcnBEK0RBVDFXTEhsQkRodUM3K3Vv?=
 =?utf-8?Q?jjQTJfrQY46ufmm8iztkn9E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f57b2a-9a02-4ecb-68b2-08da9d1d681a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 04:38:05.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r959Q63CxSsvtwcN+FLrhRj6EkHnWb8ka6QVQUiuGWwBBBCyOrKMvXT3ZcSvdatv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltZWssIE1pY2hhbCA8
bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjIsIDIw
MjIgNTowNSBQTQ0KPiBUbzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3Nr
aUBsaW5hcm8ub3JnPjsgTWVodGEsIFBpeXVzaA0KPiA8cGl5dXNoLm1laHRhQGFtZC5jb20+OyBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5c3p0
b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGJhbGJpQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4
LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGFsYWR1Z3UsIFNpdmEgRHVyZ2EgUHJhc2FkDQo+
IDxzaXZhLmR1cmdhLnByYXNhZC5wYWxhZHVndUBhbWQuY29tPjsgTWFuaXNoIE5hcmFuaQ0KPiA8
bWFuaXNoLm5hcmFuaUB4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5k
aW5nczogdXNiOiBkd2MzOiBBZGQgaW50ZXJydXB0LW5hbWVzIHRvIGluY2x1ZGUNCj4gaGliZXJu
YXRpb24gaW50ZXJydXB0DQo+IA0KPiANCj4gDQo+IE9uIDkvMTYvMjIgMTI6MTAsIEtyenlzenRv
ZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gT24gMTUvMDkvMjAyMiAxMDowNCwgTWljaGFsIFNpbWVr
IHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiA5LzE1LzIyIDEwOjQ0LCBLcnp5c3p0b2YgS296
bG93c2tpIHdyb3RlOg0KPiA+Pj4gT24gMTQvMDkvMjAyMiAxNDoxNSwgTWVodGEsIFBpeXVzaCB3
cm90ZToNCj4gPj4+Pg0KPiA+Pj4+PiBXaGVyZSBpcyB0aGUgdXNlciAoRFRTKSBhbmQgaW1wbGVt
ZW50YXRpb24gb2YgdGhpcyBjaGFuZ2U/IElmIHRoaXMNCj4gPj4+Pj4gaXMgc3BlY2lmaWMgdG8g
WGlsaW54LCB3aHkgeW91IGRvIG5vdCBoYXZlIGRldmljZSBzcGVjaWZpYyBjb21wYXRpYmxlPw0K
PiA+Pj4+IFtQaXl1c2hdOg0KPiA+Pj4+IFdlIGhhdmUgZGVkaWNhdGVkIGlycSBsaW5lIGZvciBo
aWJlcm5hdGlvbiBmZWF0dXJlLCAgImhpYmVyIiBpcnEgbGluZQ0KPiB0cmlnZ2VycyBoaWJlcm5h
dGlvbiBpbnRlcnJ1cHQuDQo+ID4+Pj4gRFdDMyBjb3JlIHN1cHBvcnRzIHRoZSBoaWJlcm5hdGlv
biBmZWF0dXJlLCB3ZSBoYXZlIGEgZGVkaWNhdGVkIGNvZGUNCj4gd2hpY2ggaXMgeWV0IHRvIGJl
IHVwc3RyZWFtZWQuDQo+ID4+Pj4gQXMgdGhlIGhpYmVybmF0aW9uIGZlYXR1cmUgcHJvdmlkZWQg
YnkgZHdjMy1jb3JlLCBzbyB0aGlzIHdpbGwgYmUNCj4gc3VwcG9ydGVkIGJ5IG90aGVyIFNPQy92
ZW5kb3JzLg0KPiA+Pj4NCj4gPj4+IEJ1dCBpcyBoaWJlciBpcnEgbGluZSBwcmVzZW50IGluIG90
aGVyIHZlbmRvcnM/IFdoYXQgY29uZnVzZXMgbWUgaXMNCj4gPj4+IGFkZGluZyBub3Qgb25seSAi
aGliZXIiIGlycSBidXQgYWxzbyBvdGcgaW4gY29tcGxldGVseSBuZXcgZW51bS4NCj4gPj4NCj4g
Pj4gSSB3aWxsIGxldCBQaXl1c2ggdG8gY29tbWVudCBoaWJlciBJUlEuIEJ1dCBJIGV4cGVjdCB3
ZSBkb24ndCBoYXZlDQo+ID4+IHZpc2liaWxpdHkgd2hhdCBvdGhlcnMgYXJlIGRvaW5nIGJ1dCB0
aGlzIGlzIGxpbmUgaXMgbm90IFhpbGlueA0KPiA+PiBpbnZlbnRpb24gdGhhdCdzIHdoeSBJIGV4
cGVjdCBJUCBmcm9tIFN5bm9wc3lzIGhhdmUgaXQgYnkgZGVmYXVsdCBidXQNCj4gPj4gaXQgaXMg
dXAgdG8gc29jIHZlbmRvciBpZiBoaWJlcm5hdGlvbiBmZWF0dXJlIGlzIGVuYWJsZWQgb3Igbm90
Lg0KPiA+Pg0KPiA+PiBvdGcgaXMgYWxyZWFkeSBsaXN0ZWQgaW4NCj4gPj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+Pg0KPiA+PiBJdCBp
cyBvbmx5IGFib3V0IG9yZGVyLg0KPiA+PiBEcml2ZXIgaXMgYWxyZWFkeSB1c2luZw0KPiA+PiBw
bGF0Zm9ybV9nZXRfaXJxX2J5bmFtZS4uKCkgZnVuY3Rpb25zDQo+ID4NCj4gPiBMaW51eCBkcml2
ZXIgeWVzLCBidXQgb3RoZXIgcGxhdGZvcm1zIChib290bG9hZGVycywgb3BlcmF0aW5nIHN5c3Rl
bXMpDQo+ID4gbWlnaHQgYmUgZG9pbmcgdGhpbmdzIGRpZmZlcmVudGx5LiBUaGVyZWZvcmUgdGhl
IG9yZGVyIGFuZCBpdGVtcyBhcmUNCj4gPiB1c3VhbGx5IHN0cmljdC4gSWYgdGhleSBjYW5ub3Qg
YmUgc3RyaWN0LCBpdCBpcyBuaWNlIHRvIGtub3cgd2h5IG9yIGl0DQo+ID4gaXMgbmljZSB0byBy
ZXN0cmljdCBpdCB0byBzb21lIHNwZWNpZmljIHZhcmlhbnQgKGlmIGl0IGlzIGFwcGxpY2FibGUp
Lg0KPiA+DQo+ID4gVGhpcyBpcyB3aHkgSSBhc2tlZCB3aGV0aGVyIHRoZSBsaW5lIGlzIHNwZWNp
ZmljIHRvIFhpbGlueCBvciB0byBvdGhlcnMuDQo+ID4NCj4gPj4NCj4gPj4gSSB0aGluayBhbnkg
Y29tYmluYXRpb24gc2hvdWxkIGJlIGZpbmUuIERvIHdlIG5lZWQgdG8gcmVjb3JkIHVzZWQNCj4g
Pj4gb3JkZXIgb3IgdGhlcmUgaXMgd2F5IGluIHlhbWwgdG8gc3VwcG9ydCBhbnkgY29tYmluYXRp
b24gd2l0aA0KPiA+PiBkd2NfdXNiMywgaG9zdCwgcGVyaXBoZXJhbCwgb3RnIHNob3VsZCBiZSB3
b3JraW5nIChpZ25vcmluZyB0aGF0IGhpYmVyDQo+IHdoaWNoIHNob3VsZCBiZSBsaWtlbHkgdGhl
cmUgdG9vKS4NCj4gPg0KPiA+IFdoYXQgY29uZnVzZXMgbWUgaGVyZSBtb3JlLCBpcyBoYXZpbmcg
b3RnLiBJIHVuZGVyc3RhbmQgdGhhdCBkd2NfdXNiMw0KPiA+IGlzIHRoZSBzaW5nbGUgaW50ZXJy
dXB0IGZvciBhbGwgdGhlIG1vZGVzLCBzbyBteSBuYWl2ZSBhcHByb2FjaCB3b3VsZCBiZToNCj4g
PiBvbmVPZjoNCj4gPiAgIC0gZHdjX3VzYjMNCj4gPiAgIC0gZW51bSBbZHdjX3VzYjMsIGhpYmVy
XQ0KPiA+ICAgLSBlbnVtIFtob3N0LCBwZXJpcGhlcmFsLCBvdGddDQo+ID4gICAtIGVudW0gW2hv
c3QsIHBlcmlwaGVyYWwsIG90ZywgaGliZXJdDQo+ID4NCj4gPiBIb3dldmVyIGhlcmUgUGl5dXNo
IGFkZHMgbm90IG9ubHkgaGliZXIgYnV0IGFsc28gb3RnLi4uDQo+IA0KPiBJIHdhcyBsb29raW5n
IGF0IGNvZGUgYW5kIEkgdGhpbmsgd2Ugc2hvdWxkIGJlIGFibGUgdG8gdXNlIHRoaXMgb3JkZXIN
Cj4gLSBlbnVtIFtob3N0LCBwZXJpcGhlcmFsLCBvdGcsIGhpYmVyXQ0KPiB3aGljaCBzaG91bGQg
ZW5zdXJlIGNvbXBhdGliaWxpdHkgaW4gb3RoZXIgU1cgcHJvamVjdHMuDQo+IA0KPiBXZSBjYW4g
Y29tcGxldGVseSBpZ25vcmUgZHdjX3VzYjMuIEl0IG1lYW5zIGFib3ZlIGR3Y191c2IzLCBoaWJl
cg0KPiBzaG91bGRuJ3QgYmUgYWxzbyBsaXN0ZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIHNlY29u
ZCBlbnRyeSBpcyBhbGwgdGhlIHRpbWUgaXJxDQo+IGZvciBwZXJpcGhlcmFsLg0KPiANCj4gVGhh
bmtzLA0KPiBNaWNoYWwNCg0KRW5hYmxpbmcgd2FrZXVwIGluIHp5bnFNcCB3ZSBuZWVkIHRvIHB1
dCB0aGUgY29yZSBpbnRvIGhpYmVybmF0aW9uLCBhcyB2ZXJzYWwgZG9uJ3QgaGF2ZSBoaWJlcm5h
dGlvbiBjb25jZXB0LCBidXQgd2UgcmVxdWlyZSBpbnRlcnJ1cHQgZm9yIHdha2V1cC4NCldlIGhh
dmUgYSB2ZXJzYWwgcGxhdGZvcm0gd2hlcmUgd2UgYXJlIG5vdCB1c2luZyBoaWJlcm5hdGlvbiwg
YnV0IHN5c3RlbSB3YWtlIHVwIHdlIG5lZWQgdGhlIGludGVycnVwdC4gRm9yIHRoaXMgaW50ZXJy
dXB0LW5hbWUgZW51bSB3b3VsZCBiZToNCi0gZW51bSBbaG9zdCwgcGVyaXBoZXJhbCwgb3RnLCB1
c2Itd2FrZXVwXQ0KDQp6eW5xTXAgOg0KLSBlbnVtIFtob3N0LCBwZXJpcGhlcmFsLCBvdGcsIGhp
YmVyXQ0KDQpWZXJzYWw6DQotIGVudW0gW2hvc3QsIHBlcmlwaGVyYWwsIG90ZywgdXNiLXdha2V1
cF0NCg0KUmVnYXJkcywNClBpeXVzaCBNZWh0YQ0K
