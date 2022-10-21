Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BD1606E28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJUDKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJUDKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:10:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8B74346;
        Thu, 20 Oct 2022 20:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBc9jRGvANx+Nn1mLmvddYpTAjnKDiRyp/cKSqWXgQtkHohLdKWjsji3fMmj6gj+WTMXlqA30Fg053lIy6dJsSJlBAlE+JMNjYKXzlqDEQgs7qagoqFpJ0Fs2D5bBwpqwbmfODlYqw35bDA4l/QEUkLVBbNWiloy0zYZSpDrwVuQNofPfE23iqW9YsjnR4ImuWLHm/vJxzF1YC72/xrOEL1CHudgYBjFUyVjk2EG4cD+lWKvz0V1iYpUcZk/DCagbLVvSEwgshQAkD+a9GD/zHSDIfKUw0VmSwmJiU1aiLPvyxa7u77wPhPcmqbxt0xGa6Ocwz2xKZ3xweY23BoJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgyzSMw2+DudyAsWBkbOfn+c3Us/JCJeb+MVgNc4t5I=;
 b=kzMX0JK2bDpeMKbsSE/KOPfeYzE1TPGNI5g+G3Hh3cQGyKpHCNUXUsCBT44fjP5tUEToLCqe6XHcBwNwaFAqosImleKM9ZromswPP6Zxbw5e1PNIWhhnwKT7oDMBD56MuWqISA5cv7xRTynbJxiN+/LajLJFJZj02kJ60KmzCPhrZo40hOSFhOMESNmPHC/L3SerT6xCmFxcoNFrsqFBHB2/mIrC5MRi333qK4j3pxsUXq4htamwLqaxq0fMZNAH0X86hDSB2dB5rsvIA2S/tTfXzOvh/Ts5SANwMFz1OIrKJqEZ/09zWLP8s1sSG2fN8DdL5kiPn7ysxk1MJe39pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgyzSMw2+DudyAsWBkbOfn+c3Us/JCJeb+MVgNc4t5I=;
 b=Sdstw+RkMB1krxVu6DFMMlDcwQ8ooAgZ7hPAgnKvWrQaJag7/RkD77nj4xBsef5gW2odYVvsYkY8CQHPMOAJwcr2RtsuFOsrRo796AMEQfqpAH58VvP13YNzdZ4c8VLgr5Wi+FL/NNovSuJwLZr2hzuCXGrEskwiwYy5jPt8hbtFcD64PmASffMUZ5cmRq7vg2me50oGsDIyVPzGfLvTAermLNtetuqle+MGJXz/HvUoIGq9nUUkmGOvc4xjyJxjN0II1cq4ddn8yJndM4BruAm+b/yAUNNu8aUs8K9sJYUN7ks/bGAtXWkoDdcCnn0D35PDQ+JsMBgDxt99enNoyA==
Received: from DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) by
 DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Fri, 21 Oct 2022 03:10:14 +0000
Received: from DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::f992:1d1c:9a:71f0]) by DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::f992:1d1c:9a:71f0%9]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 03:10:14 +0000
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
CC:     Jui Chang Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wayne Chang <waynec@nvidia.com>,
        Haotien Hsu <haotienh@nvidia.com>
Subject: Re: [PATCH] phy: tegra: xusb: Remove usb3 supply
Thread-Topic: [PATCH] phy: tegra: xusb: Remove usb3 supply
Thread-Index: AQHY2JYu6BOcgfNol0mxxdlP1PdQvK4YRBmA
Date:   Fri, 21 Oct 2022 03:10:14 +0000
Message-ID: <5e3792d9-4814-a813-3cef-815242661d64@nvidia.com>
References: <20221005084031.2154251-1-haotienh@nvidia.com>
In-Reply-To: <20221005084031.2154251-1-haotienh@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5988:EE_|DS0PR12MB6485:EE_
x-ms-office365-filtering-correlation-id: 19948d17-e3fc-4169-b14a-08dab311c622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERmg8JNZjBKTK8nQ7Max7vrKYl2wGunPA00PnXiB5fkPdVVLw7+7ol8a0GWiyT+9QHN30bssU8P/MxXVQ3RFgpHnuFoI/u5CKaK1NF8VTXBgvG/j7BagSHjMr7OpvZ2y/OfADva2Dj2vk1tC+xySyGAj6z+yjsuwQxu8CnQFm+yodEXsB4mHLp28PbYi49p+geipZ5mELkpPUbe2m2I2P48W5GaESLD05rdHp3936H8IlkZRbmCuQA/a/aMvbT88DuJGEqZAOUdP26sItvePf5TQk7oyj1gAZVYj7ZqwB8EEgllsBhFhAaJnQNZFAwjQtRZ/CNBEM7jyLD5qCSjPrhaheiLaeoO3WAHP3WBT9jqGRiUn+wH0jqi+5kIdn5H6V6pGrllqVg1XANiKuCqOTWf2ASmC/9BIizMz8hZUv5BYIbVw3U0agdIk2RVS47tEj2uF2KLZc+T71EXbcf8lPXR88VhPQRrJQi0PqOc5CQHAA5FuDSygCCmqT5y1i3sDMLtVqGK+0+FwQjtt1ZPq331TpLIncfvrdSMNORojCUGdKRobLTpuaP3YbkURUw5mBJ2iWBUujV9n5XbGY/7fHPn2y6oFCnk5mx/R1B5n4q+BK7GPCudNcIbAV3kppctEXQRWCWh4F9rqAT41NWTxD92x6HV2ZZ/ABiXORLdeUZP92CvB++9bf8K0OLR4Xxrh/NtMVSF6dEEZQtIKOqNF3Jziev0gC/La2LLIMKocsxp7cNEP4hzmt8ArwfGtBkxD96tFqaBQcmDJNh60sRmWAQawsQcSwRWcxHBcOT1wpKA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5988.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(76116006)(36756003)(31686004)(86362001)(122000001)(31696002)(5660300002)(2616005)(2906002)(186003)(41300700001)(91956017)(6486002)(38070700005)(83380400001)(4326008)(38100700002)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(71200400001)(54906003)(110136005)(66446008)(66556008)(8936002)(8676002)(53546011)(478600001)(107886003)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFYzQTBWNjgvNzRtUjFIcVlJd3d0T3VkRDc3RkxrK3JYZG5xQTNZdDZHalR5?=
 =?utf-8?B?enp3UTVpVlZPcUpPakQwQTNrbkpYeTVoYW1DZm1WWjA1MnFVR1VwRWhueEQz?=
 =?utf-8?B?TXZ4YWF0V2JQRk0xS0JqKzNqUnhHVHhER2VZZityZjExTmJaY1pvZ1QwRVVp?=
 =?utf-8?B?RHFjaE5pWkRzWnp6K3RDUng3MlMzam9WL21IeFJJOE5hOGZueXVHQWJLbS9H?=
 =?utf-8?B?by9ReW9lREFROHZMaXcrbzltWXo0NmJabUxoSmsvQ1RFMVNpNms2NjFuYnRH?=
 =?utf-8?B?M1BIYXRQQytIajJsa2hwRTFQUDdydmxFYS9XSlVSSUVOQmtEUWhCcjQwbkU3?=
 =?utf-8?B?aGJ5QWZuNWx1VjcxN2NvTDc3bW1zc1JDK2JrcDlNSC9ZOTVoOVR1bEVpNmR3?=
 =?utf-8?B?cmdsUlJCbXEvUmt5NmFjR3NBS2J1Slg4dDAxUWRQRGFhOFlxcWcxQ0VzVjdR?=
 =?utf-8?B?SC81V1FrZFd3YXJZOVRucldyYVpEK2RWQzVvUFowWXlZOFV1QkZMUG41TkRj?=
 =?utf-8?B?T0JrUy9veDZHYUg1UDNuVDNsQ21peFJkektQbjBHUW5PMkFRMWNjaCtUUWZa?=
 =?utf-8?B?TjJCcmxWWWVid3lqd1N6aENuOG1WZm1UUUhTdEd0Q3Zhdy85RTVDblViR3hm?=
 =?utf-8?B?c0RSZVdITlZKaW95Sk9aSHBXZkRvb0JXLzM4RHhSMmlLMTBEWjMzR1o3Qkdo?=
 =?utf-8?B?eVNCQXpzR0MyejVJRml1RHFUY0lQOXBTRjZaNXBRZWVIK3Y4bDRRSEw4V1FN?=
 =?utf-8?B?cXVrWHdjQUhCUGY2Unp0QklVaHU5VXIxL3dhN2FqWCtvLytIV3lhem5aQzBG?=
 =?utf-8?B?WWFEcGxTRmd5QWZhb1lWaUg2QTEwd1phTjlFU0RBaElQcG9OUENTOVpMdDJZ?=
 =?utf-8?B?bElzWk1GekZCWVpwS3ZNRytUTTZYMUVMdzZrSFZTNkJUWHU0WFlGQzlNaWdD?=
 =?utf-8?B?RWl2SWtuSHR5QUl3Mk41b1BzWFN3M29HUnZ2cXdvbERBSmtNWmNINUxOa2ZG?=
 =?utf-8?B?WXFjUDN0aVlPK1k0SEFtQkYvc09pRmtsN3V0STBYa0F6MGp1OUhSNnhJekpy?=
 =?utf-8?B?WVdQSm1say9DQ1k1UGtUZm1EUk1kVXVqUDVkVFpGU0ppOGNTdG8rRWhTRFBS?=
 =?utf-8?B?ZDZvTjlxS3ZzR3hWMEtOK29NdVNoc0ZNWGhCUWRadHA3ckZ0MzBwNVBYRTdt?=
 =?utf-8?B?VUlISzhFOVBCWWZFYjRhQ0JhYWFpSGxpOHpuMCtPTDR3LzJURXArUWt5ckxk?=
 =?utf-8?B?V3ZCT25ML20rSE1HREpvZWJqZGs2S1ZvT1FIcFkwM0tkTXVmb3k3Q1gxcG1j?=
 =?utf-8?B?ZDdteWxQWnUyMkc5YXhwL05EZVRYWlFNclNtbzFkT040R0xBM0JQcFdVSnZM?=
 =?utf-8?B?b01MRjJFOTFGRUIwRVNYT01MMzdVTFFpMitnK1lPaks3KzBodTNMdTNnM1NZ?=
 =?utf-8?B?TXVHRXlWalhVd3B1R3Ezb0VNTkNkZHl6U1gydkNkV0MzM3hwVHJZUElMeTU1?=
 =?utf-8?B?V0hXS0R6dTgxWm1nWDFnczA4SUk0b0ZOZGVUd0dTNzZsTXpsck91Kys2WmRt?=
 =?utf-8?B?eUxPTURLaFVaRzlBM0YxckZaWjYzWS9kQkVUK2RLZzdHOHozV0xQVHdBekMv?=
 =?utf-8?B?Q0E1aThjN3pHWWZIdXdlcXQyUHNJMmpZVGdFNE00MkJsL3RUdDd0K25QMGV5?=
 =?utf-8?B?eHBLUkNJZ0d6OXVFSkxXaUxZWjROLzZOVWw4aXpIY1IvZ2hreGpadk53OUsz?=
 =?utf-8?B?ejhuMzJ4NUhaRjZRNy9PS3pUSEEzQ2ttd1BFT0pPc24yYlVQZDVZNGhqRFBw?=
 =?utf-8?B?VzlueWJRL3ZWdUtjN25oQy9VY3dGYWVFcUptN2pHZXl2NkRVbzFJdi9tWWRV?=
 =?utf-8?B?cER6Unlhb0xPZUJ4YkdyQ0labVBiYm4va1pZTmxINndOVkcyMjFmRXVHeXZB?=
 =?utf-8?B?Szd4ZGFUL3l4T0lpYWl5MUN0cVFNSGhTZkVGMDRTMHRGN1RDUXVRS0RYNEdo?=
 =?utf-8?B?WXJXdGR3WDdmK0NzbXROOFBSUWtwMVlZcGVNZUhwS0dtRDE1ekZ2TkFSZE1Y?=
 =?utf-8?B?dmtRenRXUDZndnFlWHVFcnhPN2sxczZIbGpKTFhuZEtZWkthekhJY1ZyZldK?=
 =?utf-8?Q?Bb9s1xYR5YPH3qju/jIvebzdc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37E8A75B33990043B4D4DF14A3269DAC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19948d17-e3fc-4169-b14a-08dab311c622
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 03:10:14.6168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+JhfeMSG6Szsd+CctbGqpe7L17Eq3PU5uGl3DfnsKsagaQLWg1CnSF6tXN+VrRMsJq6qS7xiw8L/tGhGaZGkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNS8yMiAxNjo0MCwgSGFvdGllbiBIc3Ugd3JvdGU6DQo+IEZyb206IFdheW5lIENoYW5n
IDx3YXluZWNAbnZpZGlhLmNvbT4NCj4gDQo+IFJlbW92ZSByZWR1bmRhbnQgY29kZXMgZm9yIGdl
dHRpbmcgdGhlIHZidXMgc3VwcGx5IG9mIHVzYjMgcG9ydHMgYmVjYXVzZQ0KPiB3ZSBnZXQgYW5k
IGNvbnRyb2wgdGhlIHZidXMgc3VwcGx5IGJ5IHRoZSBjb21wYW5pb24gdXNiMiBwb3J0cw0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogV2F5bmUgQ2hhbmcgPHdheW5lY0BudmlkaWEuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBIYW90aWVuIEhzdSA8aGFvdGllbmhAbnZpZGlhLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9waHkvdGVncmEveHVzYi10ZWdyYTEyNC5jIHwgIDEgLQ0KPiAgIGRyaXZlcnMvcGh5
L3RlZ3JhL3h1c2ItdGVncmExODYuYyB8ICAxIC0NCj4gICBkcml2ZXJzL3BoeS90ZWdyYS94dXNi
LXRlZ3JhMjEwLmMgfCAgMSAtDQo+ICAgZHJpdmVycy9waHkvdGVncmEveHVzYi5jICAgICAgICAg
IHwgMTAgKy0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvcGh5L3RlZ3JhL3h1c2IuaCAgICAgICAgICB8
ICAyIC0tDQo+ICAgNSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTQgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvdGVncmEveHVzYi10ZWdyYTEyNC5j
IGIvZHJpdmVycy9waHkvdGVncmEveHVzYi10ZWdyYTEyNC5jDQo+IGluZGV4IGRiNTZjN2ZiZTYw
Yi4uZjRmNzVlYTAzM2I4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BoeS90ZWdyYS94dXNiLXRl
Z3JhMTI0LmMNCj4gKysrIGIvZHJpdmVycy9waHkvdGVncmEveHVzYi10ZWdyYTEyNC5jDQo+IEBA
IC0xNjUyLDcgKzE2NTIsNiBAQCB0ZWdyYTEyNF91c2IzX3BvcnRfbWFwKHN0cnVjdCB0ZWdyYV94
dXNiX3BvcnQgKnBvcnQpDQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWdyYV94dXNi
X3BvcnRfb3BzIHRlZ3JhMTI0X3VzYjNfcG9ydF9vcHMgPSB7DQo+ICAgCS5yZWxlYXNlID0gdGVn
cmFfeHVzYl91c2IzX3BvcnRfcmVsZWFzZSwNCj4gLQkucmVtb3ZlID0gdGVncmFfeHVzYl91c2Iz
X3BvcnRfcmVtb3ZlLA0KPiAgIAkuZW5hYmxlID0gdGVncmExMjRfdXNiM19wb3J0X2VuYWJsZSwN
Cj4gICAJLmRpc2FibGUgPSB0ZWdyYTEyNF91c2IzX3BvcnRfZGlzYWJsZSwNCj4gICAJLm1hcCA9
IHRlZ3JhMTI0X3VzYjNfcG9ydF9tYXAsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS90ZWdy
YS94dXNiLXRlZ3JhMTg2LmMgYi9kcml2ZXJzL3BoeS90ZWdyYS94dXNiLXRlZ3JhMTg2LmMNCj4g
aW5kZXggZjYwOTk2MDlmMTU0Li4yNWRiNDk3ODlmNDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
cGh5L3RlZ3JhL3h1c2ItdGVncmExODYuYw0KPiArKysgYi9kcml2ZXJzL3BoeS90ZWdyYS94dXNi
LXRlZ3JhMTg2LmMNCj4gQEAgLTEyMTMsNyArMTIxMyw2IEBAIHRlZ3JhMTg2X3VzYjNfcG9ydF9t
YXAoc3RydWN0IHRlZ3JhX3h1c2JfcG9ydCAqcG9ydCkNCj4gICANCj4gICBzdGF0aWMgY29uc3Qg
c3RydWN0IHRlZ3JhX3h1c2JfcG9ydF9vcHMgdGVncmExODZfdXNiM19wb3J0X29wcyA9IHsNCj4g
ICAJLnJlbGVhc2UgPSB0ZWdyYV94dXNiX3VzYjNfcG9ydF9yZWxlYXNlLA0KPiAtCS5yZW1vdmUg
PSB0ZWdyYV94dXNiX3VzYjNfcG9ydF9yZW1vdmUsDQo+ICAgCS5lbmFibGUgPSB0ZWdyYTE4Nl91
c2IzX3BvcnRfZW5hYmxlLA0KPiAgIAkuZGlzYWJsZSA9IHRlZ3JhMTg2X3VzYjNfcG9ydF9kaXNh
YmxlLA0KPiAgIAkubWFwID0gdGVncmExODZfdXNiM19wb3J0X21hcCwNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGh5L3RlZ3JhL3h1c2ItdGVncmEyMTAuYyBiL2RyaXZlcnMvcGh5L3RlZ3JhL3h1
c2ItdGVncmEyMTAuYw0KPiBpbmRleCBlZWRmYzdjMmNjMDUuLmViYzhhN2UyMWEzMSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9waHkvdGVncmEveHVzYi10ZWdyYTIxMC5jDQo+ICsrKyBiL2RyaXZl
cnMvcGh5L3RlZ3JhL3h1c2ItdGVncmEyMTAuYw0KPiBAQCAtMzA3OCw3ICszMDc4LDYgQEAgdGVn
cmEyMTBfdXNiM19wb3J0X21hcChzdHJ1Y3QgdGVncmFfeHVzYl9wb3J0ICpwb3J0KQ0KPiAgIA0K
PiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVncmFfeHVzYl9wb3J0X29wcyB0ZWdyYTIxMF91c2Iz
X3BvcnRfb3BzID0gew0KPiAgIAkucmVsZWFzZSA9IHRlZ3JhX3h1c2JfdXNiM19wb3J0X3JlbGVh
c2UsDQo+IC0JLnJlbW92ZSA9IHRlZ3JhX3h1c2JfdXNiM19wb3J0X3JlbW92ZSwNCj4gICAJLmVu
YWJsZSA9IHRlZ3JhMjEwX3VzYjNfcG9ydF9lbmFibGUsDQo+ICAgCS5kaXNhYmxlID0gdGVncmEy
MTBfdXNiM19wb3J0X2Rpc2FibGUsDQo+ICAgCS5tYXAgPSB0ZWdyYTIxMF91c2IzX3BvcnRfbWFw
LA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvdGVncmEveHVzYi5jIGIvZHJpdmVycy9waHkv
dGVncmEveHVzYi5jDQo+IGluZGV4IDQ2NjYxYThkNWJiYy4uMGVhYWI2ZDg0NmJmIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3BoeS90ZWdyYS94dXNiLmMNCj4gKysrIGIvZHJpdmVycy9waHkvdGVn
cmEveHVzYi5jDQo+IEBAIC05NjAsOCArOTYwLDcgQEAgc3RhdGljIGludCB0ZWdyYV94dXNiX3Vz
YjNfcG9ydF9wYXJzZV9kdChzdHJ1Y3QgdGVncmFfeHVzYl91c2IzX3BvcnQgKnVzYjMpDQo+ICAg
CQkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgCX0NCj4gICANCj4gLQl1c2IzLT5zdXBwbHkgPSByZWd1
bGF0b3JfZ2V0KCZwb3J0LT5kZXYsICJ2YnVzIik7DQo+IC0JcmV0dXJuIFBUUl9FUlJfT1JfWkVS
Tyh1c2IzLT5zdXBwbHkpOw0KPiArCXJldHVybiAwOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMg
aW50IHRlZ3JhX3h1c2JfYWRkX3VzYjNfcG9ydChzdHJ1Y3QgdGVncmFfeHVzYl9wYWRjdGwgKnBh
ZGN0bCwNCj4gQEAgLTEwMTgsMTMgKzEwMTcsNiBAQCB2b2lkIHRlZ3JhX3h1c2JfdXNiM19wb3J0
X3JlbGVhc2Uoc3RydWN0IHRlZ3JhX3h1c2JfcG9ydCAqcG9ydCkNCj4gICAJa2ZyZWUodXNiMyk7
DQo+ICAgfQ0KPiAgIA0KPiAtdm9pZCB0ZWdyYV94dXNiX3VzYjNfcG9ydF9yZW1vdmUoc3RydWN0
IHRlZ3JhX3h1c2JfcG9ydCAqcG9ydCkNCj4gLXsNCj4gLQlzdHJ1Y3QgdGVncmFfeHVzYl91c2Iz
X3BvcnQgKnVzYjMgPSB0b191c2IzX3BvcnQocG9ydCk7DQo+IC0NCj4gLQlyZWd1bGF0b3JfcHV0
KHVzYjMtPnN1cHBseSk7DQo+IC19DQo+IC0NCj4gICBzdGF0aWMgdm9pZCBfX3RlZ3JhX3h1c2Jf
cmVtb3ZlX3BvcnRzKHN0cnVjdCB0ZWdyYV94dXNiX3BhZGN0bCAqcGFkY3RsKQ0KPiAgIHsNCj4g
ICAJc3RydWN0IHRlZ3JhX3h1c2JfcG9ydCAqcG9ydCwgKnRtcDsNCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGh5L3RlZ3JhL3h1c2IuaCBiL2RyaXZlcnMvcGh5L3RlZ3JhL3h1c2IuaA0KPiBpbmRl
eCBkNjZiMjJiZmVhYTcuLjFiNmI3ODBlZmVlYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waHkv
dGVncmEveHVzYi5oDQo+ICsrKyBiL2RyaXZlcnMvcGh5L3RlZ3JhL3h1c2IuaA0KPiBAQCAtMzYw
LDcgKzM2MCw2IEBAIHZvaWQgdGVncmFfeHVzYl9oc2ljX3BvcnRfcmVsZWFzZShzdHJ1Y3QgdGVn
cmFfeHVzYl9wb3J0ICpwb3J0KTsNCj4gICANCj4gICBzdHJ1Y3QgdGVncmFfeHVzYl91c2IzX3Bv
cnQgew0KPiAgIAlzdHJ1Y3QgdGVncmFfeHVzYl9wb3J0IGJhc2U7DQo+IC0Jc3RydWN0IHJlZ3Vs
YXRvciAqc3VwcGx5Ow0KPiAgIAlib29sIGNvbnRleHRfc2F2ZWQ7DQo+ICAgCXVuc2lnbmVkIGlu
dCBwb3J0Ow0KPiAgIAlib29sIGludGVybmFsOw0KPiBAQCAtMzgyLDcgKzM4MSw2IEBAIHN0cnVj
dCB0ZWdyYV94dXNiX3VzYjNfcG9ydCAqDQo+ICAgdGVncmFfeHVzYl9maW5kX3VzYjNfcG9ydChz
dHJ1Y3QgdGVncmFfeHVzYl9wYWRjdGwgKnBhZGN0bCwNCj4gICAJCQkgIHVuc2lnbmVkIGludCBp
bmRleCk7DQo+ICAgdm9pZCB0ZWdyYV94dXNiX3VzYjNfcG9ydF9yZWxlYXNlKHN0cnVjdCB0ZWdy
YV94dXNiX3BvcnQgKnBvcnQpOw0KPiAtdm9pZCB0ZWdyYV94dXNiX3VzYjNfcG9ydF9yZW1vdmUo
c3RydWN0IHRlZ3JhX3h1c2JfcG9ydCAqcG9ydCk7DQo+ICAgDQo+ICAgc3RydWN0IHRlZ3JhX3h1
c2JfcG9ydF9vcHMgew0KPiAgIAl2b2lkICgqcmVsZWFzZSkoc3RydWN0IHRlZ3JhX3h1c2JfcG9y
dCAqcG9ydCk7DQoNCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBoYXZlIGFueSBjb21tZW50
cy4NClRoYW5rIHlvdS4NCg0KDQo=
