Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9A6C781C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCXGqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjCXGqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:46:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150914E81;
        Thu, 23 Mar 2023 23:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StZppJIRJSdtz32WEndYa8Lgex9cwHWzoi7901p/uNoE3gOyULJLqajLZVdktVgvxpZxjTxWoCHGV5/sMiOXWwCLW5ZjuJmnE6HVPgfY23aeO7jqNkNgKYApYdfEKAm6YSKWYU7TKNQI8RbRGKNxM19MFMyg+nwnmTlCBVkSrmK+OlzilAL9Yk0U02Y8QYUxx+RGwleEwGPVjaTqIrUMVIUBXhnf8mI5Qex9+FvypAW7LO7Nl5GAVfBeLv2VMfgpLmPv4UqM02zD5zMlTwqgQnQny6bG4JBDhhPjfqEkSWGlmvpicZoo3VbitCSmmqjo4b+EJxjXAL1YEalziV8lEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMLEb178F3uRIGxBmNiND3yOb0LKDCw3kAwtKXoQow4=;
 b=PrP4kc2TbuyYdYdj2uIntwWPLkGrBO2ntUXe/zuWdLyuAThr5MYV2tLpHqJCMsxPQ34PMhg0lZv07kD5vuYO2KHjG1/7rF9zfE1i1S7AfQef6UNDTbu04OkgFevw33pah9E/sXmdAekx7e8rZQ7Yw2WLMvcSb1/uKF318KY13OwkuMhLCOPa7fQxivd/T122SQ6IfE9m81q1zVT9emXnWsWOG+TOU6HbyWPq1sk9Po4m+u9nrUH+XJrzSKYKIMHzgk9LoJXcPrLhm+Wcman38bidZ1IMlBtwCEGOawl5E8M8Yg81RIs+KWzMgixw8jX3u5zqDSkmYE50SR6E2VMI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMLEb178F3uRIGxBmNiND3yOb0LKDCw3kAwtKXoQow4=;
 b=HYPQbEoCMWl/Pri3lFoASalz/gD2QE3exd3SNimA8lBEiAz5PHQVd8xRypk2Msh/ORHLseN3pcB0mkGUx+MCF6iX2HGt/3N1muM/Q/T5tyJgPEvaGpsRFogJDB1oGKGSzs0CQkKs//rmo5dj9VJcGG6tKATEO3t9cXeSWQJlQ/l1vaAuF4aD8CrZFCeS1ez/Qs1AZNftHrD5b4HvgjXOk/7AyP/Z5Gu4hNXJNu7bpkXC8X24F1hApqQzHyossZ3Vm6YJfGifmTF/r6A6mvhd0txvd5BNiRi5oQfcKrjHP/CIjOLYRSgnorbm/Zi4/b9Vw+gcD8Sh8RclgfouSZ2xKQ==
Received: from DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) by
 DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Fri, 24 Mar 2023 06:46:05 +0000
Received: from DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::3949:5699:fc26:a8dd]) by DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::3949:5699:fc26:a8dd%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 06:46:05 +0000
From:   Haotien Hsu <haotienh@nvidia.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Haotien Hsu <haotienh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Wayne Chang <waynec@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Jui Chang Kuo <jckuo@nvidia.com>
Subject: Re: [PATCH v4] usb: xhci: tegra: fix sleep in atomic call
Thread-Topic: [PATCH v4] usb: xhci: tegra: fix sleep in atomic call
Thread-Index: AQHZW8b3IekpF/qyYkSVS8iFJf8xn68Ij7wAgADxUIA=
Date:   Fri, 24 Mar 2023 06:46:04 +0000
Message-ID: <3f864eb32214399b911a62c2223abd250f41e1fa.camel@nvidia.com>
References: <20230321072946.935211-1-haotienh@nvidia.com>
         <ZBx8vliqQVqdK/Pn@kroah.com>
In-Reply-To: <ZBx8vliqQVqdK/Pn@kroah.com>
Reply-To: Haotien Hsu <haotienh@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5988:EE_|DS0PR12MB8575:EE_
x-ms-office365-filtering-correlation-id: dc4d1411-11e2-4f87-f1c7-08db2c3370b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VsPnejsoDPmNWEv6IbR0ZOMRI6lzRvfM2eIFW0QA93mBjxS+E56O1+FhDSoh1GsREl9WoIvEP5+5VM+KOJ0XAD3WQngJp/6F/MRdF9MSVBAIgMeFsMp40w5yMCMosAyKq9JtYqV/HUFVu4sRDKmhyahpV5H9A/O+/ugasDnWlNJpEXgoYxynfR3JjL1xnTpETDFhr6PDvMSv26MvFGCGkbkOztrO5ewNCbmfceUKyp2Jas0Wqhhv7Z0m7FosgXM3JPiTR5TsKaK9C1HGLBmDyC+hbdPRdHStzvCIWYiXeGiOVGzLKyjW24G/4Hyjdbmu8SNjXL0ayVfRKcclD2AtcoeRB2q6N5hFBoQ8nbHKp9lHK4axcqX6J5ExvnZPOexARv62M82oJFJzVYTjxBIIh0Gfr2qN69XysDnSHtPuWwIHADfXL2nmC2RC6szKMZaVSoLOK7Noc93dZAIKG5mxEjaNq7/+srV8rYUnjQ3PE/+j0aoRFjAn7mLi8gZxqHFZHAbxdJcj3s/glK2nGo5G6D7x2SFTqnjZf2W0Omsabk2zz7BHeA0nFo0B4ZSRzBbu+fN68R8w/4vLgKgD0SmQRznaP2BYxbxC+klkrehx5OfMBCJpDwZXYhmlK0Lha9+W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5988.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(8936002)(66446008)(316002)(5660300002)(86362001)(64756008)(66476007)(91956017)(66556008)(4326008)(76116006)(6916009)(66946007)(8676002)(54906003)(41300700001)(478600001)(3450700001)(2906002)(6486002)(71200400001)(38070700005)(122000001)(107886003)(6506007)(26005)(38100700002)(6512007)(186003)(2616005)(83380400001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3NHc0ttVXNPYXdJKzZSVXpHV3l1S0xVLzlyaGNYMzd2VE02blp1cDh4TXlI?=
 =?utf-8?B?TmxTd3c0cFBxdHY5RjFoYm5HODl0Mzdwb1Z3NndsTHd3NGpYTnIycGxsVWgx?=
 =?utf-8?B?YzM5dzNndXJNSFFFUS8vLzFkZGRGNzRNVmtIZHJFcWFpM3Z6MlpJRUM5SGRW?=
 =?utf-8?B?UHhCbktsc0NrT1lkRWp5Q1QvSll3ZmZHMXhGREFrR2VWVTRDYndhZmVlY0l4?=
 =?utf-8?B?bjhaODJ0aE8vNzJLNGxtNGd5M0l6ZlJsSHhPVUE0Z3JXbWZGMCt0SGNiQUlv?=
 =?utf-8?B?VTNVUHpWYmZtYXA0bnVncDljeEQ2cEhPQjlIOUlWbUhHL3YveW5SZDdhSlNt?=
 =?utf-8?B?Tzk2aDFRQk1mdzdlc3VqQUFGa0g3U09aTmZ1dm9jcEo5U3JBemh2eVNhM1F6?=
 =?utf-8?B?QjJ1UzZDRmkvS1VRV1pncEptSUo0TkkrUWtjNWpiK2tqTDRVNDV6dmdXZmJq?=
 =?utf-8?B?cnlhaVd0YjAvUWd6cUdvTkJmVmdVaXIvVjE1d0Vka21TdGkrbzFuU0ZYdmpZ?=
 =?utf-8?B?YkIySGlMbkU2Mkg4aGtRS2NocEltc1hNUEM2QWVuS2pDNkpUZjZhYmptT2h3?=
 =?utf-8?B?VUcrc2RtT1pSSHk5ZHhJbXRwWUFaQzBHRG5Zb1hnMmFKUlZ4ZXpjZVFuNFRm?=
 =?utf-8?B?UVIvZXM4dUgrMVhtUFhqeW9BQ205a1J0ZEloaGxOZ0RPV254WGR0OHd2aC9n?=
 =?utf-8?B?SVFXM0F1ekVhdUdqUnY0VUh0UG5QYUNsTy9YOXFPTExYWmI3ekpVQ1ZzZmM0?=
 =?utf-8?B?cnB5SHpXR1E1OW5WbG5KNmpjbW80eC8zaWtRek1EWmRBa2JiQk9icW1CbjVW?=
 =?utf-8?B?Mk5xQ0RhY3FBZmFhLzV0Vk1Nc0NuOFg0WWRXOVFGdXUxSVFic2JaQTZMU2FR?=
 =?utf-8?B?N2d4OW1CTU0vVzJYYkdsNjhVMi9SUFhTeXNjbkpTb0dXMURWQjUrbnVvd2Zx?=
 =?utf-8?B?TjVnWFR2RytGdkQ3UDRwdzRVbUJyMWdxcTZNZkgvMzZqbndlUHZ6cGJtdmsz?=
 =?utf-8?B?SkdzSzhFekptRkp5QWZ6MjRSQ0JTVEMxY01JckxBUkVvU3BpRjhPdHNjRHB6?=
 =?utf-8?B?Ym9vR1lENXJFdjVNZ1JZT0NpRk4wTTRudi91eEZjT01nN0Nhb2NPb0dOYUhq?=
 =?utf-8?B?aUtZTHpWUGZUTVhvanM2RmhWQ3RzckxGUjFNVWpMYmdxV296cW02VjZsYXZj?=
 =?utf-8?B?L3lNV2JNc3g2Q2RPdnlEd0FTdnBDNGtDRWVaTUplVHRzUHJGaGoyVzNLMENo?=
 =?utf-8?B?UW5iMllITStwdndsREIrallmL2RCT3A3VW1oQmlpSXZ3OVdiKzA1L29EMEJI?=
 =?utf-8?B?VGRXUnhqcE4yaUh5STY3dFRVMStHaEJoSnBNL042a2hTVW0xendpOTVmelE0?=
 =?utf-8?B?aUJxMTRTRURyTHpOdEx3VkQ5Nm1ZR21Nd0hFOVZ1MFplTDE5YTFPK3hlZjVv?=
 =?utf-8?B?Si9XakU4RFZGOFRWaEl1U0MwUHRPaWlwNGJCNCtmdUtPZ1ZpZGx3b2JyWVd2?=
 =?utf-8?B?T2dUUUFSa0pJZ1hqVzhIWTVVN2t4VjhOTDNGMktoeEo3L2Z4UXphQTRsS0d3?=
 =?utf-8?B?UVozanBtdWJlaUt5amp3RDQwdzBVN3owcm5QMVBrWWRUVlB0NU1zbXlySXVr?=
 =?utf-8?B?dGpORXBCV05hMDZXbm5CaGdYVTB5UXl4a1IzSDhhVkNaSmpYc3NUS0JTbUtE?=
 =?utf-8?B?MzJtZW1ZaUNCQzJKNWFkUC9lVzRkYmxqblNiUFZnRFlKUnU5VlVjVUxKR0RW?=
 =?utf-8?B?ZlBZRnFaL1Y3bUN6d3Q2eGtDZ2lERWRvTUh5Z0NmQUpVU0cvNVpNbUNWeGU2?=
 =?utf-8?B?Q21BcnAzT3pHYjQwMlg1YWpoTDBpcVRYOWRsOVRHMmFST09ybklMWTBVUGpF?=
 =?utf-8?B?RFRGQnlyNGxDckZ5bkpjTE8xbXZYY0xVMGtxSnlPcVVyYzgxL042ays0N0pG?=
 =?utf-8?B?c1Q2YTN3ZlBmU2d6SW83S2UvZGtvRHVkdzdNb2ttQWQvRHJBdWVVbzJibG91?=
 =?utf-8?B?SlJ1N0g4MlV3VFB5UWRQNWJiSW1XSFJkbGpDQ1lzU1ZPMmFPNzV6UWZEY21a?=
 =?utf-8?B?MEdyRDJrSGFCeHA5OWJDajNDOWJtam54KzJiZG5WaHFZWHQ5RUF6YUgrTEVu?=
 =?utf-8?Q?tIuLIZbBog0jNL8vTJbjgRsQj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82A24C09475D224289216273D4CE0D9F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4d1411-11e2-4f87-f1c7-08db2c3370b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 06:46:04.8579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dT8VxAdO5qFurZAVCrHh9DBf2ttjWcM4xwBxF83zC0miphZ9DWN8hUmdozGrPQ/mQCRlQhe8CRoIdcq5rRmViA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTIzIGF0IDE3OjIyICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFj
aG1lbnRzDQo+IA0KPiANCj4gT24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMDM6Mjk6NDZQTSArMDgw
MCwgSGFvdGllbiBIc3Ugd3JvdGU6DQo+ID4gRnJvbTogV2F5bmUgQ2hhbmcgPHdheW5lY0Budmlk
aWEuY29tPg0KPiA+IA0KPiA+IFdoZW4gd2Ugc2V0IHRoZSBPVEcgcG9ydCB0byBIb3N0IG1vZGUs
IHdlIG9ic2VydmVkIHRoZSBmb2xsb3dpbmcNCj4gPiBzcGxhdDoNCj4gDQo+IFdoYXQgIk9URyIg
cG9ydD8gIFRoYXQgaXMgbm90IGEgVVNCIHRoaW5nIGFueW1vcmUgYXQgYWxsLiAgSG93IGlzDQo+
IHRoaXMNCj4gcGFydCBvZiBhIHhoY2kgY29udHJvbGxlcj8NCg0KSSB3aWxsIHVzZSAnZHVhbC1y
b2xlIHBvcnQnIGluc3RlYWQuDQoNCldoZW4gdGhlIHJvbGUgb2YgYSBzdXBlci1zcGVlZCBwb3J0
IGlzIHN3aXRjaGVkLCB3ZSBuZWVkIHRvIGNsZWFyIG9yDQpzZXQgcG9ydCBwb3dlci4NCk91ciBo
b3N0IG1vZGUgY29udHJvbGxlciBhbmQgZGV2aWNlIG1vZGUgY29udHJvbGxlciBzaGFyZSB0aGUg
c2FtZQ0Kc3VwZXItc3BlZWQgcG9ydCBoYXJkd2FyZS4NCldoZW4gYSBTUyBwb3J0IGlzIGdvaW5n
IHRvIGJlIHN3aXRjaGVkIHRvIGRldmljZSBtb2RlIHJvbGUsIHdlIGhhdmUgdG8NCmNsZWFyIFBQ
IGF0IGhvc3QgbW9kZSBjb250cm9sbGVyIHNpZGUgdG8gcmVsZWFzZSBTUyBwb3J0IGhhcmR3YXJl
IHRvDQpkZXZpY2UgbW9kZSBjb250cm9sbGVyLg0KV2hlbiBhIFNTIHBvcnQgaXMgZ29pbmcgdG8g
YmUgc3dpdGNoZWQgdG8gaG9zdCBtb2RlIHJvbGUsIHdlIGhhdmUgdG8NCnNldCBQUCBhdCBob3N0
IG1vZGUgY29udHJvbGxlciBzaWRlIHRvIGFjcXVpcmUgU1MgcG9ydCBoYXJkd2FyZS4NCg0KPiAN
Cj4gPiBbICAxNjcuMDU3NzE4XSBCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxlZCBmcm9tIGlu
dmFsaWQgY29udGV4dA0KPiA+IGF0DQo+ID4gaW5jbHVkZS9saW51eC9zY2hlZC9tbS5oOjIyOQ0K
PiA+IFsgIDE2Ny4wNTc4NzJdIFdvcmtxdWV1ZTogZXZlbnRzIHRlZ3JhX3h1c2JfdXNiX3BoeV93
b3JrDQo+ID4gWyAgMTY3LjA1Nzk1NF0gQ2FsbCB0cmFjZToNCj4gPiBbICAxNjcuMDU3OTYyXSAg
ZHVtcF9iYWNrdHJhY2UrMHgwLzB4MjEwDQo+ID4gWyAgMTY3LjA1Nzk5Nl0gIHNob3dfc3RhY2sr
MHgzMC8weDUwDQo+ID4gWyAgMTY3LjA1ODAyMF0gIGR1bXBfc3RhY2tfbHZsKzB4NjQvMHg4NA0K
PiA+IFsgIDE2Ny4wNTgwNjVdICBkdW1wX3N0YWNrKzB4MTQvMHgzNA0KPiA+IFsgIDE2Ny4wNTgx
MDBdICBfX21pZ2h0X3Jlc2NoZWQrMHgxNDQvMHgxODANCj4gPiBbICAxNjcuMDU4MTQwXSAgX19t
aWdodF9zbGVlcCsweDY0LzB4ZDANCj4gPiBbICAxNjcuMDU4MTcxXSAgc2xhYl9wcmVfYWxsb2Nf
aG9vay5jb25zdHByb3AuMCsweGE4LzB4MTEwDQo+ID4gWyAgMTY3LjA1ODIwMl0gIF9fa21hbGxv
Y190cmFja19jYWxsZXIrMHg3NC8weDJiMA0KPiA+IFsgIDE2Ny4wNTgyMzNdICBrdmFzcHJpbnRm
KzB4YTQvMHgxOTANCj4gPiBbICAxNjcuMDU4MjYxXSAga2FzcHJpbnRmKzB4NTgvMHg5MA0KPiA+
IFsgIDE2Ny4wNTgyODVdICB0ZWdyYV94dXNiX2ZpbmRfcG9ydF9ub2RlLmlzcmEuMCsweDU4LzB4
ZDANCj4gPiBbICAxNjcuMDU4MzM0XSAgdGVncmFfeHVzYl9maW5kX3BvcnQrMHgzOC8weGEwDQo+
ID4gWyAgMTY3LjA1ODM4MF0gIHRlZ3JhX3h1c2JfcGFkY3RsX2dldF91c2IzX2NvbXBhbmlvbisw
eDM4LzB4ZDANCj4gPiBbICAxNjcuMDU4NDMwXSAgdGVncmFfeGhjaV9pZF9ub3RpZnkrMHg4Yy8w
eDFlMA0KPiA+IFsgIDE2Ny4wNTg0NzNdICBub3RpZmllcl9jYWxsX2NoYWluKzB4ODgvMHgxMDAN
Cj4gPiBbICAxNjcuMDU4NTA2XSAgYXRvbWljX25vdGlmaWVyX2NhbGxfY2hhaW4rMHg0NC8weDcw
DQo+ID4gWyAgMTY3LjA1ODUzN10gIHRlZ3JhX3h1c2JfdXNiX3BoeV93b3JrKzB4NjAvMHhkMA0K
PiA+IFsgIDE2Ny4wNTg1ODFdICBwcm9jZXNzX29uZV93b3JrKzB4MWRjLzB4NGMwDQo+ID4gWyAg
MTY3LjA1ODYxOF0gIHdvcmtlcl90aHJlYWQrMHg1NC8weDQxMA0KPiA+IFsgIDE2Ny4wNTg2NTBd
ICBrdGhyZWFkKzB4MTg4LzB4MWIwDQo+ID4gWyAgMTY3LjA1ODY3Ml0gIHJldF9mcm9tX2Zvcmsr
MHgxMC8weDIwDQo+ID4gDQo+ID4gVGhlIGZ1bmN0aW9uIHRlZ3JhX3h1c2JfcGFkY3RsX2dldF91
c2IzX2NvbXBhbmlvbiBldmVudHVhbGx5IGNhbGxzDQo+ID4gdGVncmFfeHVzYl9maW5kX3BvcnQg
YW5kIHRoaXMgaW4gdHVybiBjYWxscyBrYXNwcmludGYgd2hpY2ggbWlnaHQNCj4gPiBzbGVlcA0K
PiA+IGFuZCBzbyBjYW5ub3QgYmUgY2FsbGVkIGZyb20gYW4gYXRvbWljIGNvbnRleHQuDQo+ID4g
DQo+ID4gRml4IHRoaXMgYnkgbW92aW5nIHRoZSBjYWxsIHRvIHRlZ3JhX3h1c2JfcGFkY3RsX2dl
dF91c2IzX2NvbXBhbmlvbg0KPiA+IHRvDQo+ID4gdGhlIHRlZ3JhX3hoY2lfaWRfd29yayBmdW5j
dGlvbiB3aGVyZSBpdCBpcyByZWFsbHkgbmVlZGVkLg0KPiA+IA0KPiA+IEZpeGVzOiBmODM2ZTc4
NDMwMzYgKCJ1c2I6IHhoY2ktdGVncmE6IEFkZCBPVEcgc3VwcG9ydCIpDQo+ID4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBXYXluZSBDaGFuZyA8d2F5bmVj
QG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFvdGllbiBIc3UgPGhhb3RpZW5oQG52
aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gVjMgLT4gVjQ6IFJlbW92ZSBjb3B5cmlnaHQgY2hhbmdl
IGZyb20gdGhpcyBwYXRjaA0KPiA+IFYyIC0+IFYzOiBBZGQgdmVyc2lvbiBpbmZvcm1hdGlvbg0K
PiA+IFYxIC0+IFYyOiBBZGQgIkZpeGVzIiBhbmQgIkNjOiIgbGluZXMgYW5kIHVwZGF0ZSBjb3B5
cmlnaHQgeWVhcnMNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLXRlZ3JhLmMg
fCA3ICsrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXRl
Z3JhLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktDQo+ID4gdGVncmEuYw0KPiA+IGluZGV4IDFm
ZjIyZjY3NTkzMC4uYjQwZTg5N2VjMDkyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hv
c3QveGhjaS10ZWdyYS5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXRlZ3JhLmMN
Cj4gPiBAQCAtMTM2MCw2ICsxMzYwLDEwIEBAIHN0YXRpYyB2b2lkIHRlZ3JhX3hoY2lfaWRfd29y
ayhzdHJ1Y3QNCj4gPiB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiANCj4gPiAgICAgICBtdXRleF91
bmxvY2soJnRlZ3JhLT5sb2NrKTsNCj4gPiANCj4gPiArICAgICB0ZWdyYS0+b3RnX3VzYjNfcG9y
dCA9IHRlZ3JhX3h1c2JfcGFkY3RsX2dldF91c2IzX2NvbXBhbmlvbigNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZWdyYS0NCj4gPiA+
cGFkY3RsLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHRlZ3JhLQ0KPiA+ID5vdGdfdXNiMl9wb3J0KTsNCj4gPiArDQo+IA0KPiBZb3Ug
aGF2ZSAxMDAgY29sdW1ucywgcGxlYXNlIHVzZSB0aGVtLCBlbmRpbmcgYSBsaW5lIHdpdGggIigi
IGlzIG5vdA0KPiBnZW5lcmFsbHkgYSBnb29kIGlkZWEuDQoNCkkgd2lsbCByZXN1Ym1pdCBhIG5l
dyBwYXRjaC4NCg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==
