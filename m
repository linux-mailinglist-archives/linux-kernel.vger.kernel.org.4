Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402EA5B8824
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiINMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiINMXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:23:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8976280517
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joxo11G4XwZRrNkElkBIxWc3uWhx4W2VJSIG6l9P3qNVodwDCjmo6e70s5898XQY9WsVO1SHQWcLR0wsBDIfum23B+UdVrRYPfAICFn+4WzpyxurkNBcH+OAkI5zI25i/rE4MedVdJu9WGcSteZ/op+Zr4UU6xqCMGMO+c6gvYRf6agfeS5VUjfBeu4WkWPa7Xw46CildAYYGrc86T0KLKFps8Pp5mr9nawikmiY912sT+S2VAm4YQBciz6lDpL2M/QL4xdpkCNpdTw9pDMcGSrsYVQqrZRfgLAU9ae2yIbR/SOCJvYl+hFqJHRyOojKVsXbYGFpL6ELOD2O4IFicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zno6VSAsXYykcrqyBSO//Kv9VEiS4zQADTe41T8WCqQ=;
 b=Cd4omcWkAY4BJF4Bh78qA3hGdZRSLi9+Utl9SITPGtrg0io2+fc7VaOTxWzoMasYxAd5BkRGcgQekBCsT9In0iWqvQR/FYFFH7+nPyIFoOJwhvY2B56QtXXTsoAo3YPGCNyMzbjVSu9WQNJM/BUoFTSjROEM3Y1wzxfheZ8U43BXvsOZcfFnBj4rx45TwtaXMrDtXGpPYpOHLopU9GZKoAmHr+tgU+97uj1z9zq3r3aL/mAOETv/Xor6ZH0hoy+wA5KBxJeiKT1nlLHaZEBK3DMteOFOqGO4x+/dDRKJdYS/XPixOrHmxphhrbhTuNhxbN/1pWAgOJHBWLCFY6U/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zno6VSAsXYykcrqyBSO//Kv9VEiS4zQADTe41T8WCqQ=;
 b=Pd1Ul84nyv26KBDAWVzUOsV1AVsKP0JcfGPOlBP6h7kk2n1UX5NxUSDRRwIMNVh3HuwJwFQd33dhTbDCD5O81F/A8zNFe4RvXTS/7And6a0yZsgFPj4MtSOMv28m/XhdtrtjRUNKH6aKFgHi1WRvphjaR3sRvVb5rGw6Fayaw9TDDux2ip9kdBQmvTli3k5zL646kiDd4rZDgNjA5FnVKXqMmMPFJKOGCkx3NLr19gJMUe3r6CrasMDdqQ8byPD/9cuGFcpdUsADospuu7lTQaXpfd06vSOV0XP0GSQwKhCwsPueg/yH4GOOvP1bdhQTMtxf/i0sJuvw6RPr12hYBA==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 14 Sep 2022 12:23:42 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 12:23:42 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] vdpa/mlx5: Fix MQ to support non power of two num queues
Thread-Topic: [PATCH] vdpa/mlx5: Fix MQ to support non power of two num queues
Thread-Index: AQHYxqY/PMpgYASX0EW33TM1MZc5uK3eyRoAgAASqiA=
Date:   Wed, 14 Sep 2022 12:23:42 +0000
Message-ID: <DM8PR12MB54001AF4AF5093504EB7003AAB469@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220912125019.833708-1-elic@nvidia.com>
 <27fec483-e860-aea4-f2d6-3082d702f561@oracle.com>
In-Reply-To: <27fec483-e860-aea4-f2d6-3082d702f561@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|DM4PR12MB5746:EE_
x-ms-office365-filtering-correlation-id: 87deb7ee-5ac6-4d21-197a-08da964bf617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWG6PM4eTPhIu4FtV77VLIk96gJ25+T1RkigroAg+DS8Xb8rCq08otzNY9eogeWoh6ngdrTNY/H8bZR2cGAr3zLHvUBn75UH8m9BaZm09X99M+wDX8jaw6kRiXNuLSzYqRuzU16bD5TMbbNjKbLeP9C2hd3OuXOEpULA0vr8QfSPEyy/7a/5hGK1y4R0i4MuclXpz9pw/rXkHtxR1UbFCyiP/MACydU5Rcara0DJxb5aw1UUL2AsDFeE79vPOnQJhSFjXvNIGyaKESrRfw/kYPsQRaXweourz3JjdOk/ItYPhR69T8rOUaXqZimB18tj2rcxgwnS/+6nCKHc2k4kWMcthXUwdNvYlGohlVIUG7KZJ1mcMOqxcNlRfzSKNzmVr3QWOpK/LSsMhJBmQ1a7LGUq6iH/q3MDAoed1DkwIgs+TaPN1OGB7HNjvVglDoFf25KCff4wkC9AIuBUv5uZARVvvUNWhzj6p6ZirgftjHCeBIJHn/g8u2gCgqi8xWc3sBPEsDl2CW3AI9HHod04o3Y21k3ideSDfCbo53kFeyGhcMx8caGb5nKscLlYwxt/c0ZTjn74sY9kw34qeBpZQTKat1muWAI2sUK7+5ocyyOdOPeKMzbBWFS9xSDhA/U30bsUKOxntqlv5/p1AeMA9e5teOd/I7eeTlT8W8BEmGwnc12rRb2adk6JVGTDDwoRbRDyjcU7/nHpm5xk/vod2kTbrjleK2DZvBbiuX+IKQJULQTXHgJ0VrXyOMRzlvsS3KQARTDu5/mByBAtFPaLBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(52536014)(38100700002)(122000001)(64756008)(26005)(5660300002)(71200400001)(6506007)(7696005)(8936002)(9686003)(38070700005)(478600001)(76116006)(33656002)(2906002)(110136005)(53546011)(186003)(8676002)(66946007)(86362001)(41300700001)(55016003)(66476007)(66556008)(83380400001)(66446008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnN2ZFhvSWU5QXpldC8rY3UyWU9DSExuMXVaRGltRkd6cFArcUUxb2xxb1ND?=
 =?utf-8?B?RVVpRTh3cmpQWlgxbEFYTW1Va2hsU3YvUnVlQVJaODZodlpjZ1NDaHBaQVJh?=
 =?utf-8?B?dlluUkhPaVlNS2FnczFkWDFhcnRlNEVGaWUxTEpvQlQwUWlBUTZwVWhxWGtk?=
 =?utf-8?B?N2t4VGE1eElxREs4anE3VFcwa2x1clluWTV3elgvNklRWEJRV1FPU3MvUkUw?=
 =?utf-8?B?OTVQalNxSjJ1WERZR3REb29ubEgrSzUwWWNzZndTN25hYVpaTjVtOHhVNito?=
 =?utf-8?B?OGxrYVU5OXV6cStSaVBKUEVveFdsSTgxcGdqLzJPRCs0cThkaU4xcTF5T2Nl?=
 =?utf-8?B?M1dNL2JKU3g0eDJ3K3BmanFMZDQ2bmJCVWc0UU5QT0l1aW1GSVNQeWE4REVv?=
 =?utf-8?B?SnVIZHhnbjVya1BTUzhacUprVkp1aW05TU9lWWdxMU9ycVdQL29udkNlV0sv?=
 =?utf-8?B?SmVEbEdEYVFoNDhPYjlhNXdISG5GY2s1ZFlvWS9CRFptS2EvbUxIcFAxUEF0?=
 =?utf-8?B?U0JTVXJtZUtGZVptakJpYzgzS1diaHhWQUVJVmxoKzhkWUpNZnpiZ3hxL0hQ?=
 =?utf-8?B?V1BWdU1QTVU3NlVKRTFOTlJLSUlYU0w1SnNLOXhCWlk5V2pYanVldU0wY1VP?=
 =?utf-8?B?VWZyYW9jdXdtdGF0cVJ1NE1pM3NDTU1hUkg3K0JqV1ZmRFhpeUhmR1BIY0Fv?=
 =?utf-8?B?dDhvTTBUNExxRnpralozK2NuSmNjK3NLZjNwMVJmV1FXbEsxaVU1L2J2ak9a?=
 =?utf-8?B?d2VRK2lDTGJEeGcwaXZ2NFdJTmRybWEvMy82TVdHWFVIdEx3c0FHSlk1SEN1?=
 =?utf-8?B?TWpCNDNZbUR0ZUszbnRQZkd2UDFwbUZPNjFuTU1uSGp2L2tZME9qcnpiZkR6?=
 =?utf-8?B?Ym05ck1pb0hENUN2VXhjdzIvWmU1N1NkSHl6czRFNVllMmdHVGFJTWhDNjQy?=
 =?utf-8?B?N2dnSGdVc0dpOWlyU3g0aWl0aVVWTnRtU2kweUU4TDQzUXFWWUNxVDBHemxB?=
 =?utf-8?B?dUp4Z2dYK2g4K3FmK2lvQytXcWVhcDUrU3EvM0tjeml0K3pKU01odTN3cjVF?=
 =?utf-8?B?d3Z3ZVgwb0VZSU40U29YcENVclZCNnhtbHNpd2R3ZmJDYUw2V3RobXM0d2s0?=
 =?utf-8?B?emt6WjUxTTB1OVl3WGpJNlN3Q2ZEc2FsdzMrNmZweDZDcE16WUFDcllEcTFr?=
 =?utf-8?B?OGlHNzJDZGhxa3VjRlAySWRhM3ppdXpsc056QjA2MHEzaURjMzNtOVg4YjMr?=
 =?utf-8?B?ZWVQVG9qVTVCVVZxakIzaEdkbFVKVjZrRC93cVE1QUVGU3lWRHRJS1laN1FC?=
 =?utf-8?B?WnlyQi9SeHVGM05IdHAzaHVBbFRpaHdkSncxMkQ2KzROZVg5cjIvUTZ0SGhE?=
 =?utf-8?B?YjdwcGpTM1o1TGhSWURQNk9XS3VURWR6M3dhbHd2Wk9YUUw2cVp1R0tMcFB0?=
 =?utf-8?B?aGc1LzlDb2hIL0xPVWk4ajR4cE5WUFh6OUFyNmY1Ni9idXp4R1dSd1ZBa3Vt?=
 =?utf-8?B?ZW9WU3NVUTZvdytOQmdpNUxiQUgwelU3WHN2V2toZXVjcmlUcHloc0dHYnV3?=
 =?utf-8?B?NVpTM3NWb0FyYWJDYTM2NUYzeENNTkVnc3QyRUdFYlhjOFNaUitDamcwWksw?=
 =?utf-8?B?WXo1SDNMbFprdHJycE5HZmo4emxTWnVsS2NaMFg0QXpMa3JEL256ZW5uQzRv?=
 =?utf-8?B?VmtrUDQzbklPdDlvK05wOHBvbXZNMUhySFc0Q0hUaUp6RXVwb3RLWHhjTFk0?=
 =?utf-8?B?eHdYNU9pZG5PcnVDc2kvamJsci9Jb24wbHl6d2JTSysrQXF1cE5SNU5taTRX?=
 =?utf-8?B?TmdhUXpCMHE1bFpsMWpJOXkrZU55Wk1MRlJPaGJUekxZZnozVk95WWk2M1dm?=
 =?utf-8?B?Z2E3WUtFcS92bitXVk03aWV5NVd0YVc0Y2dxalhQbHJvbG9ycnZ2YXVGMEdT?=
 =?utf-8?B?QWVWZnBzcFlnb0VJZjA1VVNvbDNVZHArQlNoOEk2dGRxS0tmSkRkZ3BDNDlB?=
 =?utf-8?B?QjU0MU5RZU42WGgzVFJSWk02NWJjeGRoUHFWeTBzYXZQZElxUGtoMVpPM2lC?=
 =?utf-8?B?aHBBcWZ3Nkh6d1NYUlZlcVp0K3FSemU4SFNqQmNVTG1MNVEzWnBzTDVjSzNR?=
 =?utf-8?Q?NPag=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87deb7ee-5ac6-4d21-197a-08da964bf617
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 12:23:42.1144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxIXxZGJFOr0AJcJ6t6kzPf6/2CJIq6JYiWeAfPV8ivBEH10D2USTNfpK+sdomUB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgMTQgU2VwdGVtYmVyIDIwMjIgMTQ6MTUNCj4gVG86IEVsaSBDb2hlbiA8ZWxpY0Budmlk
aWEuY29tPjsgbXN0QHJlZGhhdC5jb207IGphc293YW5nQHJlZGhhdC5jb207DQo+IGVwZXJlem1h
QHJlZGhhdC5jb207IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB2
ZHBhL21seDU6IEZpeCBNUSB0byBzdXBwb3J0IG5vbiBwb3dlciBvZiB0d28gbnVtDQo+IHF1ZXVl
cw0KPiANCj4gDQo+IA0KPiBPbiA5LzEyLzIwMjIgMTo1MCBQTSwgRWxpIENvaGVuIHdyb3RlOg0K
PiA+IFJRVCBvYmplY3RzIHJlcXVpcmUgdGhhdCBhIHBvd2VyIG9mIHR3byB2YWx1ZSBiZSBjb25m
aWd1cmVkIGZvciBib3RoDQo+ID4gcnF0X21heF9zaXplIGFuZCBycXRfYWN0dWFsIHNpemUuDQo+
ID4NCj4gPiBGb3IgY3JlYXRlX3JxdCwgbWFrZSBzdXJlIHRvIHJvdW5kIHVwIHRvIHRoZSBwb3dl
ciBvZiB0d28gdGhlIHZhbHVlIG9mDQo+ID4gZ2l2ZW4gYnkgdGhlIHVzZXIgd2hvIGNyZWF0ZWQg
dGhlIHZkcGEgZGV2aWNlIGFuZCBnaXZlbiBieQ0KPiA+IG5kZXYtPnJxdF9zaXplLiBUaGUgYWN0
dWFsIHNpemUgaXMgYWxzbyByb3VuZGVkIHVwIHRvIHRoZSBwb3dlciBvZiB0d28NCj4gPiB1c2lu
ZyB0aGUgY3VycmVudCBudW1iZXIgb2YgVlFzIGdpdmVuIGJ5IG5kZXYtPmN1cl9udW1fdnFzLg0K
PiA+DQo+ID4gU2FtZSBnb2VzIHdpdGggbW9kaWZ5X3JxdCB3aGVyZSB3ZSBuZWVkIHRvIG1ha2Ug
c3VyZSBhY3Qgc2l6ZSBpcyBwb3dlcg0KPiA+IG9mIHR3byBiYXNlZCBvbiB0aGUgbmV3IG51bWJl
ciBvZiBRUHMuDQo+ID4NCj4gPiBXaXRob3V0IHRoaXMgcGF0Y2gsIGF0dGVtcHQgdG8gY3JlYXRl
IGEgZGV2aWNlIHdpdGggbm9uIHBvd2VyIG9mIHR3byBRUHMNCj4gPiB3b3VsZCByZXN1bHQgaW4g
ZXJyb3IgZnJvbSBmaXJtd2FyZS4NCj4gDQo+IFdoYXQga2luZCBvZiBlcnJvciB3b3VsZCBpdCBl
bmQgdXAgd2l0aCwgaXMgdGhlcmUgZXhwbGljaXQgd2FybmluZyBpbg0KPiBkbWVzZyBvciBpdCdz
IGp1c3QgaW1wbGljaXQ/DQpUaGUgZXJyb3Igd291bGQgbG9vayBzb21ldGhpbmcgbGlrZSB0aGlz
Og0KW1NlcDE0IDE1OjIwXSBtbHg1X2NvcmUuc2YgbWx4NV9jb3JlLnNmLjY6IG1seDVfY21kX291
dF9lcnI6Nzc4OihwaWQgMzQ2Nik6IENSRUFURV9SUVQoMHg5MTYpIG9wX21vZCgweDApIGZhaWxl
ZCwgc3RhdHVzIGJhZCBwYXJhbWV0ZXIoMHgzKSwgc3luZHJvbWUgKDB4NTM4ZmFiKSwgZXJyKC0y
MikNCg0KPiBBbmQgaXMgdGhlcmUgcGVyZm9ybWFuY2UgaW1wYWN0PyBJdCdkIGJlDQo+IG5pY2Ug
dG8gYWRkIHN1Y2ggZGVzY3JpcHRpb24gdGhhdCB3ZSBjYW4gZWFzaWx5IG1hdGNoIHRoZSBzeW1w
dG9tIGp1c3QNCj4gaW4gY2FzZS4NCj4gDQpJIGRvbid0IHRoaW5rIHRoZXJlIHdvdWxkIGJlIHBl
cmZvcm1hbmNlIGltcGFjdCBidXQgSSBoYXZlbid0IGNoZWNrZWQgcGVyZm9ybWFuY2Ugd2l0aCB0
aGlzIGZpeC4NCg0KPiA+DQo+ID4gRml4ZXM6IDUyODkzNzMzZjJjNSAoInZkcGEvbWx4NTogQWRk
IG11bHRpcXVldWUgc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGlj
QG52aWRpYS5jb20+DQo+IEFja2VkLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5j
b20+DQo+IA0KPiBUaGFua3MsDQo+IC1TaXdlaQ0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jIHwgMTcgKysrKysrKysrKy0tLS0tLS0NCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiBiL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+IGluZGV4IGVkMTAwYTM1ZTU5Ni4uOTA5MTMz
NjVkZWY0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+IEBAIC0x
MzIwLDYgKzEzMjAsOCBAQCBzdGF0aWMgdm9pZCB0ZWFyZG93bl92cShzdHJ1Y3QgbWx4NV92ZHBh
X25ldA0KPiAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKg0KPiA+DQo+ID4gICBz
dGF0aWMgaW50IGNyZWF0ZV9ycXQoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpDQo+ID4gICB7
DQo+ID4gKwlpbnQgcnF0X3RhYmxlX3NpemUgPSByb3VuZHVwX3Bvd19vZl90d28obmRldi0+cnF0
X3NpemUpOw0KPiA+ICsJaW50IGFjdF9zeiA9IHJvdW5kdXBfcG93X29mX3R3byhuZGV2LT5jdXJf
bnVtX3ZxcyAvIDIpOw0KPiA+ICAgCV9fYmUzMiAqbGlzdDsNCj4gPiAgIAl2b2lkICpycXRjOw0K
PiA+ICAgCWludCBpbmxlbjsNCj4gPiBAQCAtMTMyNyw3ICsxMzI5LDcgQEAgc3RhdGljIGludCBj
cmVhdGVfcnF0KHN0cnVjdCBtbHg1X3ZkcGFfbmV0DQo+ICpuZGV2KQ0KPiA+ICAgCWludCBpLCBq
Ow0KPiA+ICAgCWludCBlcnI7DQo+ID4NCj4gPiAtCWlubGVuID0gTUxYNV9TVF9TWl9CWVRFUyhj
cmVhdGVfcnF0X2luKSArIG5kZXYtPnJxdF9zaXplICoNCj4gTUxYNV9TVF9TWl9CWVRFUyhycV9u
dW0pOw0KPiA+ICsJaW5sZW4gPSBNTFg1X1NUX1NaX0JZVEVTKGNyZWF0ZV9ycXRfaW4pICsgcnF0
X3RhYmxlX3NpemUgKg0KPiBNTFg1X1NUX1NaX0JZVEVTKHJxX251bSk7DQo+ID4gICAJaW4gPSBr
emFsbG9jKGlubGVuLCBHRlBfS0VSTkVMKTsNCj4gPiAgIAlpZiAoIWluKQ0KPiA+ICAgCQlyZXR1
cm4gLUVOT01FTTsNCj4gPiBAQCAtMTMzNiwxMiArMTMzOCwxMiBAQCBzdGF0aWMgaW50IGNyZWF0
ZV9ycXQoc3RydWN0IG1seDVfdmRwYV9uZXQNCj4gKm5kZXYpDQo+ID4gICAJcnF0YyA9IE1MWDVf
QUREUl9PRihjcmVhdGVfcnF0X2luLCBpbiwgcnF0X2NvbnRleHQpOw0KPiA+DQo+ID4gICAJTUxY
NV9TRVQocnF0YywgcnF0YywgbGlzdF9xX3R5cGUsDQo+IE1MWDVfUlFUQ19MSVNUX1FfVFlQRV9W
SVJUSU9fTkVUX1EpOw0KPiA+IC0JTUxYNV9TRVQocnF0YywgcnF0YywgcnF0X21heF9zaXplLCBu
ZGV2LT5ycXRfc2l6ZSk7DQo+ID4gKwlNTFg1X1NFVChycXRjLCBycXRjLCBycXRfbWF4X3NpemUs
IHJxdF90YWJsZV9zaXplKTsNCj4gPiAgIAlsaXN0ID0gTUxYNV9BRERSX09GKHJxdGMsIHJxdGMs
IHJxX251bVswXSk7DQo+ID4gLQlmb3IgKGkgPSAwLCBqID0gMDsgaSA8IG5kZXYtPnJxdF9zaXpl
OyBpKyssIGogKz0gMikNCj4gPiArCWZvciAoaSA9IDAsIGogPSAwOyBpIDwgYWN0X3N6OyBpKyss
IGogKz0gMikNCj4gPiAgIAkJbGlzdFtpXSA9IGNwdV90b19iZTMyKG5kZXYtPnZxc1tqICUgbmRl
di0NCj4gPmN1cl9udW1fdnFzXS52aXJ0cV9pZCk7DQo+ID4NCj4gPiAtCU1MWDVfU0VUKHJxdGMs
IHJxdGMsIHJxdF9hY3R1YWxfc2l6ZSwgbmRldi0+cnF0X3NpemUpOw0KPiA+ICsJTUxYNV9TRVQo
cnF0YywgcnF0YywgcnF0X2FjdHVhbF9zaXplLCBhY3Rfc3opOw0KPiA+ICAgCWVyciA9IG1seDVf
dmRwYV9jcmVhdGVfcnF0KCZuZGV2LT5tdmRldiwgaW4sIGlubGVuLCAmbmRldi0NCj4gPnJlcy5y
cXRuKTsNCj4gPiAgIAlrZnJlZShpbik7DQo+ID4gICAJaWYgKGVycikNCj4gPiBAQCAtMTM1NCw2
ICsxMzU2LDcgQEAgc3RhdGljIGludCBjcmVhdGVfcnF0KHN0cnVjdCBtbHg1X3ZkcGFfbmV0DQo+
ICpuZGV2KQ0KPiA+DQo+ID4gICBzdGF0aWMgaW50IG1vZGlmeV9ycXQoc3RydWN0IG1seDVfdmRw
YV9uZXQgKm5kZXYsIGludCBudW0pDQo+ID4gICB7DQo+ID4gKwlpbnQgYWN0X3N6ID0gcm91bmR1
cF9wb3dfb2ZfdHdvKG51bSAvIDIpOw0KPiA+ICAgCV9fYmUzMiAqbGlzdDsNCj4gPiAgIAl2b2lk
ICpycXRjOw0KPiA+ICAgCWludCBpbmxlbjsNCj4gPiBAQCAtMTM2MSw3ICsxMzY0LDcgQEAgc3Rh
dGljIGludCBtb2RpZnlfcnF0KHN0cnVjdCBtbHg1X3ZkcGFfbmV0DQo+ICpuZGV2LCBpbnQgbnVt
KQ0KPiA+ICAgCWludCBpLCBqOw0KPiA+ICAgCWludCBlcnI7DQo+ID4NCj4gPiAtCWlubGVuID0g
TUxYNV9TVF9TWl9CWVRFUyhtb2RpZnlfcnF0X2luKSArIG5kZXYtPnJxdF9zaXplICoNCj4gTUxY
NV9TVF9TWl9CWVRFUyhycV9udW0pOw0KPiA+ICsJaW5sZW4gPSBNTFg1X1NUX1NaX0JZVEVTKG1v
ZGlmeV9ycXRfaW4pICsgYWN0X3N6ICoNCj4gTUxYNV9TVF9TWl9CWVRFUyhycV9udW0pOw0KPiA+
ICAgCWluID0ga3phbGxvYyhpbmxlbiwgR0ZQX0tFUk5FTCk7DQo+ID4gICAJaWYgKCFpbikNCj4g
PiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4gQEAgLTEzNzIsMTAgKzEzNzUsMTAgQEAgc3RhdGlj
IGludCBtb2RpZnlfcnF0KHN0cnVjdCBtbHg1X3ZkcGFfbmV0DQo+ICpuZGV2LCBpbnQgbnVtKQ0K
PiA+ICAgCU1MWDVfU0VUKHJxdGMsIHJxdGMsIGxpc3RfcV90eXBlLA0KPiBNTFg1X1JRVENfTElT
VF9RX1RZUEVfVklSVElPX05FVF9RKTsNCj4gPg0KPiA+ICAgCWxpc3QgPSBNTFg1X0FERFJfT0Yo
cnF0YywgcnF0YywgcnFfbnVtWzBdKTsNCj4gPiAtCWZvciAoaSA9IDAsIGogPSAwOyBpIDwgbmRl
di0+cnF0X3NpemU7IGkrKywgaiArPSAyKQ0KPiA+ICsJZm9yIChpID0gMCwgaiA9IDA7IGkgPCBh
Y3Rfc3o7IGkrKywgaiA9IGogKyAyKQ0KPiA+ICAgCQlsaXN0W2ldID0gY3B1X3RvX2JlMzIobmRl
di0+dnFzW2ogJSBudW1dLnZpcnRxX2lkKTsNCj4gPg0KPiA+IC0JTUxYNV9TRVQocnF0YywgcnF0
YywgcnF0X2FjdHVhbF9zaXplLCBuZGV2LT5ycXRfc2l6ZSk7DQo+ID4gKwlNTFg1X1NFVChycXRj
LCBycXRjLCBycXRfYWN0dWFsX3NpemUsIGFjdF9zeik7DQo+ID4gICAJZXJyID0gbWx4NV92ZHBh
X21vZGlmeV9ycXQoJm5kZXYtPm12ZGV2LCBpbiwgaW5sZW4sIG5kZXYtDQo+ID5yZXMucnF0bik7
DQo+ID4gICAJa2ZyZWUoaW4pOw0KPiA+ICAgCWlmIChlcnIpDQoNCg==
