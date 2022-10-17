Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1044600B03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJQJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJQJhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:37:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63AC578A0;
        Mon, 17 Oct 2022 02:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcTlTjRXQpLdUUxZnmHQTT6ZvoLLy/6H4j+IkxIc05cOi3lRlOf7y0BdznpRpFKZjW+8OF+O0X8XhrJHC5m2rnP4RdH6w3NpBxF/pvOvQ4R9qJHcmOZDTmWjahMQhKYRw/XpasdJm3/NQGugZvC1JLN/PV2x0lTiVsHrBEnPha23F2twkaqZsL7yE5mCar+smwei3XVvG98AbP/THeRAQVPQwnZsVDJ6O1zaQui0ZZmlX34bqdkwsb38F0LlnV+870JL9arpvhtaKOiJD1WrHejBUd94vQQxp4BBntqXWJRJwOglHfJulzu61WrFJRzBjNhkjqAzX6fz0iLsAH96pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG5bGbOmQ/0aNw8TSfbCjVw5YZgrzKG78NZvrZrSv68=;
 b=ZiFNDnWoHLm2YANbQRHDHUnuatp8IZG9vQqiMlzKF+xW2dvX0N5LLL/tLEGvxKoRbP2/BFiOq83MzQ7i5DIYNoiSF7QZyjr9XNtELgcKsfoTrICbglASXw4fWrA+ij8XHest4OtwubetWX8mE9/+lhGVg/rWRP4wkm3nB5k2g5CbiFe0Z+AcgZCN+Hpwa9PbjQgXoG3bhbL0K0TFmaHJXeiMOJIjGO9fomeQUF0BjfjqDJe8NYMS4gMpT8ccQA03Lo/B++JPLDXKTAGy39tJ+0wcs0yUYRNXXfrPGBAPmGJGRZyGUAXEhqllcRLXyRtuzrx/srO1BhiwdtJ3T6vJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG5bGbOmQ/0aNw8TSfbCjVw5YZgrzKG78NZvrZrSv68=;
 b=geUg/MFUxsLGTGXKmGUyUnBGjVd9+CuRuGyj/Ooxk+JwyUS7r2kBbptOl7p/n5tO1YHnismgV6FXOzaMJ2nZGiSUfrbFpwgm4vIE5ULOnNVxlpp5lB57SM2RGXWwdS8qxmp7g2U7BLOfMShTEGPYgCTKD4Iq/StVWN7lWM48BS4aTUXo3F8Y7NWueq6A4IJBeFIPV8HXR7KKtKrNZqGDI12aJBe5uTR5lgOtVRGcm7VlbMQ0/Tr/IVP+XDE7fSxPXadWSF8sh9vpWidKOsZB/rF0jxDXgPgx4nLn+xHnXu8bZGAilWRS1lyEo12V9L54k0gxKkcBW5GfkR7oMmAYYg==
Received: from IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 09:36:39 +0000
Received: from IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::d140:ead8:ffd1:76e3]) by IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::d140:ead8:ffd1:76e3%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 09:36:39 +0000
From:   Jim Lin <jilin@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v3] xhci: tegra: USB2 pad power controls
Thread-Topic: [PATCH v3] xhci: tegra: USB2 pad power controls
Thread-Index: AQHY3iTzGqk+LW8EIUGun7Nw/Ps9r64Ko9kAgAe3xIA=
Date:   Mon, 17 Oct 2022 09:36:39 +0000
Message-ID: <cf9b9c605ed06e59edd3ae5deba914cfbfa55be3.camel@nvidia.com>
References: <20221012102511.3093-1-jilin@nvidia.com>
         <37b168f2-049c-c01f-9f60-c119fabf8606@nvidia.com>
In-Reply-To: <37b168f2-049c-c01f-9f60-c119fabf8606@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6603:EE_|CY8PR12MB7435:EE_
x-ms-office365-filtering-correlation-id: 3ddc4a1a-486b-410b-99a3-08dab02317b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DnG9A0Uofvjnl5rs6s8/KnDyLNh/qbTHntZRYqoV+S6Vr5s7CyPzoaeuSv6H0lMnnjkE6/KndYdInEU+F0Lx3P15H70iG16T2Ie+v1hIhqLb4ehXYDhy4KF033J69lfC/cDjIkHH8NJdk1/PUbWv20qPLZYk4VaHRD4am4XJ1AHU+XZDccWfThq6kNQgz7ggCV5OqPJM/pdh5bvoHAKpn727RXA+XQRr6ydCJ15CZZNDWLA/BzbYFHBILOhrXNTIIbt1nixonKpsT2eCUyd1wgh2Qe8Wh3P1nIDXVYn3x4O+JI5UVfUGu0Lq84kSd+BC3xaUmboHIh23+7TYvV9UngOFWiu4Fi6ECGpaF6uHiwshSm9WfclsqN7D9XoYqHCzW6pgMEtyde1pVCHcf5qPridrnI/WCpMDlhxq14314ioCS9SGm/5Kry2xDUEHhmk2GHSm6Dg8HvjL2ftGnAjjIYnHu+9Q5x4Gdvzl1JYDJuGjsTK773rQbe3BYCHn/jv1yYYuOvcmhIGIWpJXhNo2zh4Q2GYa0v14NfcIRcFOCpGCKzJPbWATg4+nccR5lZ0Gz+YQWyvf9+Z1cedWc7B/naxevzTO6n3exXo5SMv2wJ/jW+OPmsi7Yrp1b3TU7t2jC/0wygb29jkYKTusDH36y1inW5CxdWyQ+MDNtyR8/D1ptzVZnbLfSPzr6i0ipDXyKBpEAJ2OtxKr81q4TVLx0ps77NyL6wQfjv3NCFrWmycny4EVT6enQZ4prtFwquJ1PfAcnye7Z0wPNWGTDV5SNgXm0wQAs7MWaRXOUMUTgYU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6603.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199015)(36756003)(38100700002)(8936002)(6862004)(5660300002)(122000001)(83380400001)(86362001)(38070700005)(26005)(6512007)(54906003)(37006003)(6636002)(186003)(2616005)(478600001)(71200400001)(6486002)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(53546011)(41300700001)(8676002)(91956017)(4326008)(6506007)(2906002)(4001150100001)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHNoR0hwTGN3MlpiejIxYUFMWUJZQzgwNVBHbmRkWDE5QnZiY2xCTUpMVjJZ?=
 =?utf-8?B?cXBIVFN0allYSyttYTJhYjNUeXdrN0g1TllNU0cyUkRiU3o0alhZNnFUNmQw?=
 =?utf-8?B?ZWE3Z1YxWDV3TUxmVU5lNFQzdUtkZ0lNMjVkYUVVZXJsdm42dVJFWmU1WER3?=
 =?utf-8?B?RTJ0eDhneGtUdnRYZG1vWVN4b1M2QTZnOFVKVVpSUW0yeCtQRkJLZXdlS0dr?=
 =?utf-8?B?K1FNYUY0WFhndWt5RzlCVWRkYWRlcjMxWDZpdDlBWkVURFoza25UZFlhbG5l?=
 =?utf-8?B?cUxXTHJkL042QVBra0srZ1VPb2dOem9IQlUrVXloN0UzREdJcVl2d0UzNERk?=
 =?utf-8?B?UU1nVDZXdkRHU0V3Q2xmRGpVSzV3Ym5MM2RqS0RTSjJmbkpaa3lncS9vcHdQ?=
 =?utf-8?B?bU9MYTdBOFBKMjlsOCthUGtIejBRRm1qMkNUMGJIcnZLYVpsOHpIYitscnFh?=
 =?utf-8?B?NDNwVjVrZER4RXZkQVNwUmtuOWx2WFVkSHlJTVlRVHNpa29jT0xUMFo0aWJh?=
 =?utf-8?B?by9rcXhYZEEyVWttd0VIQ215Q1JrYzhDWExwa016bHYrYzRQeHRGa0dQMVhv?=
 =?utf-8?B?UHR2R1N6cFBNZnlpQk5rSURIeTEyVmgyWWhtTkhnV2NpM3gxRkwxMm85QkNv?=
 =?utf-8?B?WEhjZkwzTVZKckJlSEhwaGZXNFpHOW5hWVllQnhVUHJXZVJPbC9FTFBiTndZ?=
 =?utf-8?B?dzNoem04di81V2xiYVNUSHk0QXNFM1EyRVFzVzNKcUMyTWtXSG1wTzdiR1dt?=
 =?utf-8?B?K2xqaTYrSjhwSmRDUE9tdGQ2a1d5c0tNanppS0lCYUdOQXJkbk8zNTF0TGdT?=
 =?utf-8?B?cFJ3YnJNaFlkTEZIOHg0dUd2VGM2bW9oNFhlN1pHNzhGUWphaFdoM1BzR0Nu?=
 =?utf-8?B?dDBxQk9zc3Q2VGtNUjNISUNIRVBiWitIWU1lYTlIV3JVakRIYkl4R282Q2dG?=
 =?utf-8?B?T3ZMQStXNlZ3THRrODZrTzNiQVhrcTNOYzRka1kyN0JRUGx2WE5WQzZ5Z0Jz?=
 =?utf-8?B?SnV2RHZnbmZaUnV1RWtOYVFmekhwVWVLZVlSQ3BzZXliWCswbzQ1a2JkNUtP?=
 =?utf-8?B?aE04UmZJM2FMRjNlZkx2SHFxMk5pWFpZQTF5MHdjT3lxSjJMTm8xUTFwa0ZU?=
 =?utf-8?B?Z2NZR1pNenZscGx6bjFEcFp3RTB0T2o5RldTd1JWNnVrQTNIMjNzTVdVbElW?=
 =?utf-8?B?VnVwaVlaRDhPMlRLYnZ5Y1kzL2paaWJUeGNnTzJqbEV3aDU2bGprYzVOZnQ3?=
 =?utf-8?B?dUQ0VGhvSWttTFNiTm9jWXlkTTBlT0padFFUMXgzZ2RyYUQ1bVpQMG1uM0RI?=
 =?utf-8?B?dDR0ZTJzbFJlNVhYK0lkbUhSY1VhaWR1MmlZQ1lsYWgrSHhvVEJXRmJOZG00?=
 =?utf-8?B?dXMzV0NGbEtoMHoxQkJCNmhBSi9wTmpVaFowRzVYQkhaR3Qva3QxSUEyQXFK?=
 =?utf-8?B?VWllTTFUSkdrdVN5UHZxRmY0OXNpRlRJMDdZVnBvSEdYbkZmanBwUG12aVJt?=
 =?utf-8?B?UWhGd2JZbzZERER6SUJrZmZ0elBmZUFWSWs3WXFJMHRKR2ovemQ2VXJFako2?=
 =?utf-8?B?WUlBYmpYWGkrNytlM0c4K0lnRUlyVSs0ZTQ3YjdKMXhpaU5IemFXNm9XL1d6?=
 =?utf-8?B?OEl6ekxuZFVzR2dZcGJKcGJHZ3hMS01pNVF4QU9TNmpvblgyZkd0dUVKa1FP?=
 =?utf-8?B?ZnZGREFjTi80VHFGSUlCdGJHeW5MblY2cGFEak00QTdIa2hkaUxMUnkrNVZ0?=
 =?utf-8?B?VjZqenNXSkJYcGtjai9XVElzS095THh6SnNmTzE1am5IcXpRVUltbFB0WWJX?=
 =?utf-8?B?SG5na0lsZ3E4S3NQaXNGYSszQ0hBRmdHVlZEV2xoeW12WStLTzZKQmJrVVZn?=
 =?utf-8?B?UTVsVTNJNktxRUdRU2xpc2J5L09VRkdCVVRDd0x2Y2lkOUNrTlZKd0hMaS83?=
 =?utf-8?B?VS9vdmFuRkNBQ2t3NFoxT001T0J3b3I3VVM3QmRCd1VqT25XK3JsNnpyK3Ja?=
 =?utf-8?B?UzhKbUdZWE5idzZoTVFLNUFWekMwL3hJa21Jd3VzY2pFVUtQVmRQb2pZVWc1?=
 =?utf-8?B?eGFvU1BPQndrTHFOOHhETUhhYnBQbUlRRXZTYzF3ZFBYV0s4d2lIekhDYVJT?=
 =?utf-8?Q?73ysCUTOut2kVU+Uy8uy4hCbz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADD4D8957C4D0241A6C91C8A8FF09FE8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddc4a1a-486b-410b-99a3-08dab02317b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 09:36:39.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogXyHStzOJ5k5/98bQ/qep8euAAN36qZ5f5oaTFgEft7+dtbkrNXeQDbL4DvsVKUPJzJ5JSHU7lELRm2KtwRGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTEyIGF0IDEyOjQ1ICswMTAwLCBKb24gSHVudGVyIHdyb3RlOg0KPiBP
biAxMi8xMC8yMDIyIDExOjI1LCBKaW0gTGluIHdyb3RlOg0KPiA+IFByb2dyYW0gVVNCMiBwYWQg
UEQgY29udHJvbHMgZHVyaW5nIHBvcnQgY29ubmVjdC9kaXNjb25uZWN0LCBwb3J0DQo+ID4gc3Vz
cGVuZC9yZXN1bWUsIGFuZCB0ZXN0IG1vZGUsIHRvIHJlZHVjZSBwb3dlciBjb25zdW1wdGlvbiBv
bg0KPiA+IGRpc2Nvbm5lY3Qgb3Igc3VzcGVuZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
aW0gTGluIDxqaWxpbkBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBGaXggaXNzdWUgdGhh
dCB3cm9uZyB0ZWdyYS0+cGh5c1tdIG1heSBiZSBhY2Nlc3NlZCBvbiB0ZWdyYTEyNA0KPiA+IHYz
OiBObyBjaGFuZ2Ugb24gY29weXJpZ2h0DQo+ID4gDQo+ID4gICBkcml2ZXJzL3VzYi9ob3N0L3ho
Y2ktdGVncmEuYyB8IDEzOQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMzggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktdGVncmEuYyBiL2Ry
aXZlcnMvdXNiL2hvc3QveGhjaS0NCj4gPiB0ZWdyYS5jDQo+ID4gaW5kZXggYzhhZjJjZDIyMTZk
Li45OTYxODJhMTk1OWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXRl
Z3JhLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktdGVncmEuYw0KPiA+IEBAIC0x
ODksNiArMTg5LDEzIEBAIHN0cnVjdCB0ZWdyYV94dXNiX2NvbnRleHRfc29jIHsNCj4gPiAgIAl9
IGZwY2k7DQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gK2VudW0gdGVncmFfeGhjaV9waHlfdHlwZSB7
DQo+ID4gKwlVU0IzX1BIWSwNCj4gPiArCVVTQjJfUEhZLA0KPiA+ICsJSFNJQ19QSFksDQo+ID4g
KwlNQVhfUEhZX1RZUEVTLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgIHN0cnVjdCB0ZWdyYV94dXNi
X3NvYyB7DQo+ID4gICAJY29uc3QgY2hhciAqZmlybXdhcmU7DQo+ID4gICAJY29uc3QgY2hhciAq
IGNvbnN0ICpzdXBwbHlfbmFtZXM7DQo+ID4gQEAgLTI3NCw5ICsyODEsMTcgQEAgc3RydWN0IHRl
Z3JhX3h1c2Igew0KPiA+ICAgDQo+ID4gICAJYm9vbCBzdXNwZW5kZWQ7DQo+ID4gICAJc3RydWN0
IHRlZ3JhX3h1c2JfY29udGV4dCBjb250ZXh0Ow0KPiA+ICsJdTMyIGVuYWJsZV91dG1pX3BhZF9h
ZnRlcl9scDBfZXhpdDsNCj4gPiAgIH07DQo+ID4gICANCj4gPiAgIHN0YXRpYyBzdHJ1Y3QgaGNf
ZHJpdmVyIF9fcmVhZF9tb3N0bHkgdGVncmFfeGhjaV9oY19kcml2ZXI7DQo+ID4gK3N0YXRpYyBp
bnQgKCpvcmlnaW5hbF94aGNpX2h1Yl9jb250cm9sKShzdHJ1Y3QgdXNiX2hjZCAqaGNkLCB1MTYN
Cj4gPiB0eXBlUmVxLCB1MTYgd1ZhbHVlLCB1MTYgd0luZGV4LA0KPiA+ICsJICAgIGNoYXIgKmJ1
ZiwgdTE2IHdMZW5ndGgpOw0KPiANCj4gSXMgaXQgYmV0dGVyIHRvIGFkZCB0aGlzIGZ1bmN0aW9u
IHBvaW50ZXIgdG8gdGhlIHRlZ3JhX3h1c2INCj4gc3RydWN0dXJlPw0KPiANCj4gSm9uDQo+IA0K
RG8geW91IG1lYW4gcmVtb3ZpbmcgdmFyaWFibGUgIm9yaWdpbmFsX3hoY2lfaHViX2NvbnRyb2wi
IGFuZCBzYXZlDQpmdW5jdGlvbiBwb2ludGVyIHRvIHRoZSB0ZWdyYV94dXNiIHN0cnVjdHVyZSA/
DQoNCkJ1dCB0aGF0IGRvZXNuJ3QgbG9vayBwb3NzaWJsZSBvdmVyIGhlcmUgdG8gcG9pbnQgdG8g
dGVncmFfeHVzYg0Kc3RydWN0dXJlIGFuZCBzYXZlIHBvaW50ZXIgKHRvIHRlZ3JhX3hoY2lfaGNf
ZHJpdmVyLmh1Yl9jb250cm9sKSBpbnRvDQppdC4NCg0KIg0Kc3RhdGljIGludCBfX2luaXQgdGVn
cmFfeHVzYl9pbml0KHZvaWQpDQp7DQoJeGhjaV9pbml0X2RyaXZlcigmdGVncmFfeGhjaV9oY19k
cml2ZXIsICZ0ZWdyYV94aGNpX292ZXJyaWRlcyk7DQoNCglyZXR1cm4gcGxhdGZvcm1fZHJpdmVy
X3JlZ2lzdGVyKCZ0ZWdyYV94dXNiX2RyaXZlcik7DQp9DQptb2R1bGVfaW5pdCh0ZWdyYV94dXNi
X2luaXQpOw0KIg0KDQotLW52cHVibGljDQo=
