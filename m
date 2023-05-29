Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0D871466B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjE2Imu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjE2Imm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:42:42 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2107.outbound.protection.outlook.com [40.107.113.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036BEB1;
        Mon, 29 May 2023 01:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyZ8sICoNWUia/7gUBz13Kl3QqU4M4Ecsx2wakgCJnwBIEt8sGVfocgbS2Zvb8L2SZ+lexMQdx2z7MQK0wX0bDj9A4Ua7hQNYFJLn7u6slNogmsmsuO6aYHBJQ5aQx4d4U33AvMRgsOQkyvRvza4q46Hu5VTJulpxZ1tUVSWXMl5CHQYQJITSaw8txkcbYwLMmd5UxH9hH2n5kXI8a7iyd8yU2/Bhxee2YmUo849qEJQAvqfTIxE7k2gZqMW34+9sFVWS7yusGbLzzQZZHG545HzwnHt7jfI6yJKG1RC283d561H9aRzONGO0cdXphJdA/l9FZKXdgkCNwUnSR0bPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8dwYX+hRw+1B7ey9f3AspKzdmGx1pTWMYhN55CMVTs=;
 b=SLEHykaBTUjA3lQHVYKIViK4uPQtWsj3ADfLMw+S2DsZzvY0Jf5+Pj4aG0EaFylNNH3BeRF8iHjvNraO1xpxIPHFfWmC6wZ+BLX/eOOwhRdzGxokpXOY80APSRo/pnt3cR6odfs9jkl5DPbdf3aHPrxxWerygm+yY4vXEFXLB4ZF/0jQjukiMr1aYvJ2Dvyl1NT9NJCOymgYwU8LdcYpWBTDGbjwe7R0cyHoRwRlWhDWxznpOvSysDaKjaMzUmLQZwOInq0jY7RUMdoAOOT2K1Usea/8LDRU/a8jrkpn6cuFuDGt4R09AtahSxxQyohWxOQv8bI/0y/MRMaytNMJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8dwYX+hRw+1B7ey9f3AspKzdmGx1pTWMYhN55CMVTs=;
 b=EgwC0ucz+spr06Ddu3PIKa/9Lv73ZUVcaOM98qqESVe/k5PYde34frnGb6a7oreg9A9DYz9vHnau6SkpGiA4r2vA1jIYWjj6Pc21zYUlX3YKJvQDwBTxV7f9pkimEsdSWZKWoG9ONLkkD4QlZt66Yqh8eBMuxBZCRDL1mXc96Qo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB11744.jpnprd01.prod.outlook.com (2603:1096:400:407::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 08:42:35 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 08:42:34 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Index: AQHZj99wvrGBFYOn5Ea9mIuOTwGccK9wyqwAgAAi9sA=
Date:   Mon, 29 May 2023 08:42:34 +0000
Message-ID: <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230526143615.372338-1-biju.das.jz@bp.renesas.com>
 <20230529061714.GA25984@pendragon.ideasonboard.com>
In-Reply-To: <20230529061714.GA25984@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB11744:EE_
x-ms-office365-filtering-correlation-id: 6bc7affe-0769-4ef9-88ab-08db6020a65a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2rtLg/EuQWhCql4rM81LZKcRkVilDcQ+92ni2TpRmPKF3PfiZFsuORTUjYXbVp0/eOvcxRXHFHaFfp9YXiOnnucZcE6+0w1037lOraJlOQXbzE673qw4jys9NEMjRmhsxM3AdsIlGq9Dv1OVQuocBkvJw/wQ2lpNY086NbxZxqkXTsv6uVFcORw0x1BZKMePXIunUZw2YZWg15p1PBk8Vf+qoW9h2y5rP/Aop+hTBPUqeF0rMAd46t7nQR8OmPMPGterCvGvbcNFNIFK/hXzlINfAN0CCHjMT9ek4htl0URMHYujPJ9Z0RcUuIEn7A8tRlG2Mkk8fqhrLOt1cBmYZszE6hTsMg/4cBq760/DMgFdnBmJ3nM1L0RdwEYDe/b8d6v1csYIMmpfddsi4PTBMyCt/1bHFP6RaEuVmomV/YOr6w4ga3lj97KcnJodAKi22JRavxNOQW7cmikyGXNxXN4K0FKtnxHzo2e3k6odzA/G56HF8aS1o4IyAwpw0mup65Uc4u06fn3mIusOt5y+tS0PhuKpmVuhEcDhdGUMbcs56eUfPSrsR20ZqK/MMbAHcjWUoua5oCbkH1xhIWiXfm/kXxO4dDTeuyYYObrHJTCQKl9JgYUbguu2V/sB+ZVZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(7696005)(86362001)(41300700001)(38070700005)(55016003)(4326008)(71200400001)(316002)(33656002)(66556008)(66446008)(66476007)(64756008)(66946007)(76116006)(7416002)(52536014)(5660300002)(186003)(2906002)(9686003)(6506007)(26005)(83380400001)(38100700002)(478600001)(54906003)(110136005)(8676002)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXNkSitMQUZNcFhLNS9mWUlMRDJBTkRqcW05UVdnNVhLanBaeWxNUEpMOStV?=
 =?utf-8?B?NnJZWk1lMmVOa1I3WUZ3K0k4bHBXWGRrTEwzZmVUTzJmNzlGTmwzT3pMY2J3?=
 =?utf-8?B?ZDNmVnJYTnkzUHh5ZWJRbmNCQ1lnLzNKeUtiK1VVc0RDUC9BZDU5SFJ6eUdP?=
 =?utf-8?B?aHpxQ09HaWwweTdsanoweTJINlVhVzhWZWRNSHhTVDBZeFBUVkNxNGp2WVVz?=
 =?utf-8?B?aHZ5V0ZoYkF5NDZ2SGFvU3RUUGp6UmZsWGFrZlk0R3NGSmZ1QTJVUjNMRGZp?=
 =?utf-8?B?NUNjSzJmZlZ0MzZUek5UUmEreGtDWVZzbHU4T2N5QndUbjEzUmZmNElram9v?=
 =?utf-8?B?L2E3dWxsd0I0YjZ2Q1Q5K0NXVFBkQmZLdVo1Qnh3a2NSWGdEdzFTd0xuWENY?=
 =?utf-8?B?Sk96UklseUwrMUl6OVBGdUd5Y2xlM0o3cGNJMDZrcHlNL2JOKy9uOS9mc05r?=
 =?utf-8?B?ZTJjMU9FNE8zZERZVG9pd1c2VXFQaGZIa2grcUlQbVMzYm1SUG5JeVVrTTVX?=
 =?utf-8?B?NXc2ajBBVUNnc1VUVnp2dTJSMG9jUzY4NWFaQUVmSUo5b0xEcVduSDdaeXIr?=
 =?utf-8?B?VXB6ME12Nkc5NmNTcHg0MnNnMVlEM1ZJdlFEUXpid3RqRUtyQzIyc3JRYm9t?=
 =?utf-8?B?dnhSbjNaMmZNSDAvTVhCNEpQYUV3NjlnbGhuNVlSMUMvVDYyM0FWbmJ4d0Jw?=
 =?utf-8?B?Q0hDTzFYNUZ1QW9JZkt1TklFNUNycWVYdk9xWkIwbE5VOVdFSTkwK2Z0Tlh3?=
 =?utf-8?B?aDlWU1IxVFNCdjVKak14VWY2VDhlMzJTdUZxMlNNUjdnaG1vQUpGYW15Z3Bs?=
 =?utf-8?B?WkRQRDNpR1ZxMUhwTi9qbWhZOWpRQjR2U3JnNDZJczVqVk9JRmVEYUo1cVVz?=
 =?utf-8?B?MGZGaWFveGlmaU54QjVlcEdJbmhRb29CQklyUFkyVmZKS296c2hGQTUvZ1Vu?=
 =?utf-8?B?VUpZdzNzMDV0Yjlrc2RhaWczWTQxaSt1V0dpVlZEN3RkWWkzUTlYTWVEcFpt?=
 =?utf-8?B?V0hIZjlGZEdKSUlxWUZIM0FHcm9LVGN0T1hvVlBCbWgzZTJ4UWJ2RmF1L2dQ?=
 =?utf-8?B?dkFuWFF1NTBySmtheHBHNWpwd3RQa1NSZWE2TXR6b3VoTXFNdklWaE83aUhM?=
 =?utf-8?B?NjFxSGtad2xjZVJJTWdPUVpQdDYva2VtNWlGVDRFSHR3N2FyVGppUkFUcEpn?=
 =?utf-8?B?TlZTSTErNG54RE83Y29MeVVsVHNtOXZncFl1U2lJOHlSaEt3a1o2SEVEa0lW?=
 =?utf-8?B?SXE3OEpxM1RJTi8ydUFkYmJXc3Y5L081Nm9maGhnVEF1aUZKRzZjei8wcTEv?=
 =?utf-8?B?cjlOaWx3c0VDNXhZMHY5QUo0bmdiMFVHb2ZETGJpTGRpcUp5MXRXVnR1dFB6?=
 =?utf-8?B?NWNtWXN6WkwxNlo0Y1ZrdG5EWldIUW1FdmUwUzhBenlKYy9CUzhLbkoxRFBx?=
 =?utf-8?B?Q3BpZHp1Qll1UU9TOUtOMThBMjNQYVdpZ01jYTFIeUk4SkJ5QTFIbktZNzhS?=
 =?utf-8?B?UUZDRklybVk2NHpjaWhJTnhITDdiWFhZTWRmdk5WcW8wRUk2UTN6bXpRUlJy?=
 =?utf-8?B?alBKTEVhZXNvMEN1c3Z4ZXQ1Mk1vdmgvWTBiOGVSSHFkRS9zaWhNK3hzQWY1?=
 =?utf-8?B?L0dRZm1JalNQQXJ4ZVY4RnlnbTFKeWViMXY2NmxjbW5TSG1wUlVzaDFFSE8r?=
 =?utf-8?B?ZTg3bHVzOUZYeHRPZ0Y3bHgyZDd2YXlWMVRvYkh6Yi8zMlJKYyttcEpGZXZU?=
 =?utf-8?B?ZFZURlk5ZnlIYWJyUHNJbm54VFdaUTNqYnk4ajlvMGV1VE83blBVcmdwU0F6?=
 =?utf-8?B?cVdiYnZ3cDNoZnIzVWloZkdsZFpxYjlPZDVkd0EyY2prc3Y4WkRBSlZ6UHRr?=
 =?utf-8?B?SWU2N2FYQkYreDFYVjdGSFR6RmMva3BENFNQcDNOUHVidUxQMXFOUWNUelVB?=
 =?utf-8?B?NFlaS09scjRJdThIbldrRzdmWWNtOTZ6MHRCM014SUdkK090Sjg1alUzWkpT?=
 =?utf-8?B?TXh4cVZNL1VpV0lob0ovcFZyNTFiazE2WHpiRGE5Z2FZUlc1K2JqbDdJa0V4?=
 =?utf-8?B?OGZzdUlKamQyRTluemtlOGxLSjM3NkRTUW8veWRDbXYvNnkzWUpxSzByWElC?=
 =?utf-8?Q?uNrHUDOUO9R3s9IzK6mRVGA/I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc7affe-0769-4ef9-88ab-08db6020a65a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 08:42:34.8856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOKH2nt43Vi498UvRW1+UPDiNyQzDK4us9nt+msHRO1ycY2s8m1LDqBUEgIIAuWCqOlzSNDjUrbIl0XPt/RtQPb7/8oli1AbLTSQ9cnZKkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11744
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gdXNiOiBnYWRnZXQ6IHVkYzogcmVuZXNhc191c2IzOiBGaXggUlovVjJNDQo+IHtt
b2Rwcm9iZSxiaW5kfSBlcnJvcg0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IFRoYW5rIHlvdSBmb3Ig
dGhlIHBhdGNoLg0KPiANCj4gT24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMDM6MzY6MTVQTSArMDEw
MCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gQ3VycmVudGx5IHttb2Rwcm9iZSwgYmluZH0gYWZ0ZXIg
e3JtbW9kLCB1bmJpbmR9IHJlc3VsdHMgaW4gcHJvYmUNCj4gZmFpbHVyZS4NCj4gPg0KPiA+IGdl
bmlycTogRmxhZ3MgbWlzbWF0Y2ggaXJxIDIyLiAwMDAwMDAwNCAoODUwNzA0MDAudXNiM2RyZCkg
dnMuDQo+ID4gMDAwMDAwMDQgKDg1MDcwNDAwLnVzYjNkcmQpDQo+ID4gcmVuZXNhc191c2IzOiBw
cm9iZSBvZiA4NTA3MDAwMC51c2IzcGVyaSBmYWlsZWQgd2l0aCBlcnJvciAtMTYNCj4gPg0KPiA+
IEZpeCB0aGlzIGlzc3VlIGJ5IHJlcGxhY2luZyAicGFyZW50IGRldiItPiJkZXYiIGFzIHRoZSBp
cnEgcmVzb3VyY2UgaXMNCj4gPiBtYW5hZ2VkIGJ5IHRoaXMgZHJpdmVyLg0KPiANCj4gSWYgdGhl
IGRldiBwb2ludGVyIHBhc3NlZCB0byBkZXZtX3JlcXVlc3RfaXJxKCkgaXMgbm90IHRoZSBjb3Jy
ZWN0IG9uZSwNCj4gaG93IGRvZXMgaXQgd29yayB0aGUgZmlyc3QgdGltZSB0aGUgZHJpdmVyIGlz
IGxvYWRlZCA/DQoNCisgTWFyYy8gS2VybmVsLm9yZyB0byBnaXZlIHNvbWUgZmVlZGJhY2sgb24g
dGhpcyBpc3N1ZQ0KDQpJIGJlbGlldmUgdGhlcmUgbWF5IGJlIGEgYnVnIGluIHRoZSBnZW5pcnEg
KGtlcm5lbC9pcnEpIGRyaXZlci4NCmZpcnN0IHRpbWUgaXQgd29ya3Mgb2suIE1heWJlIHRoaXMg
ZHJpdmVyIGlzIGNhY2hpbmcgb24gdW5sb2FkDQp3aXRoIG51bGwgdmFsdWUgYW5kIGNvbXBhcmlu
ZyB3aXRoIGFjdHVhbCBvbmUgKGlycSAyMikgZHVyaW5nIHJlbG9hZD8/DQoNCk1heWJlIGdlbmly
cSBleHBlcnQgY2FuIGNvbW1lbnQgd2hhdCB3ZW50IHdyb25nIGhlcmU/Pw0KDQo+IA0KPiA+IEZp
eGVzOiA5Y2FkNzJkZmM1NTYgKCJ1c2I6IGdhZGdldDogQWRkIHN1cHBvcnQgZm9yIFJaL1YyTSBV
U0IzRFJEDQo+IGRyaXZlciINCj4gDQo+IFRoZXJlJ3MgYSBtaXNzaW5nICcpJyBhdCB0aGUgZW5k
IG9mIHRoZSBsaW5lLg0KDQpPb3BzIG1pc3NlZCBpdC4NCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvdXNiL2dhZGdldC91ZGMvcmVuZXNhc191c2IzLmMgfCAyICstDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvcmVuZXNhc191c2IzLmMNCj4gPiBiL2RyaXZlcnMv
dXNiL2dhZGdldC91ZGMvcmVuZXNhc191c2IzLmMNCj4gPiBpbmRleCBhYWM4YmMxODVhZmEuLjRh
MzdiMmU0YjliMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL3JlbmVz
YXNfdXNiMy5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9yZW5lc2FzX3VzYjMu
Yw0KPiA+IEBAIC0yODc3LDcgKzI4NzcsNyBAQCBzdGF0aWMgaW50IHJlbmVzYXNfdXNiM19wcm9i
ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCXN0cnVjdCByenYybV91
c2IzZHJkICpkZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShwZGV2LQ0KPiA+ZGV2LnBhcmVudCk7DQo+
ID4NCj4gPiAgCQl1c2IzLT5kcmRfcmVnID0gZGRhdGEtPnJlZzsNCj4gPiAtCQlyZXQgPSBkZXZt
X3JlcXVlc3RfaXJxKGRkYXRhLT5kZXYsIGRkYXRhLT5kcmRfaXJxLA0KPiA+ICsJCXJldCA9IGRl
dm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgZGRhdGEtPmRyZF9pcnEsDQo+ID4gIAkJCQkgICAg
ICAgcmVuZXNhc191c2IzX290Z19pcnEsIDAsDQo+ID4gIAkJCQkgICAgICAgZGV2X25hbWUoZGRh
dGEtPmRldiksIHVzYjMpOw0KPiANCj4gU2hvdWxkbid0IHlvdSB1c2UgZGV2X25hbWUoJnBkZXYt
PmRldikgdG9vID8NCg0KVGhpcyBpcnEgcmVzb3VyY2UgYmVsb25ncyB0byB1c2IzZHJkIGRyaXZl
ciBhbmQgaXMgbWFuYWdlZCBieSByZW5lc2FzX3VzYjMgZHJpdmVyLg0KSXQgaXMganVzdCByZXBy
ZXNlbnRhdGlvbiBvZiBpcnFuYW1lIGFuZCBjYXQgL3Byb2MvaW50ZXJydXB0cyBzaG93cyB0aGUg
Y29ycmVjdCANCmlycSByZXNvdXJjZSBuYW1lLiB3aXRoIGRldl9uYW1lKGRkYXRhLT5kZXYpLCBp
dCBkaXNwbGF5cyBjb3JyZWN0IHJlc291cmNlIG5hbWUNCmFzc29jaWF0ZWQgd2l0aCB0aGUgaGFu
ZGxlci4NCg0Kcm9vdEByenYybTp+IyBjYXQgL3Byb2MvaW50ZXJydXB0cyB8IGdyZXAgdXNiDQog
MjI6ICAgICAgICAgIDAgICAgIEdJQ3YyIDI3NCBMZXZlbCAgICAgODUwNzA0MDAudXNiM2RyZA0K
IDIzOiAgICAgICAgMzUzICAgICBHSUN2MiAyNzcgTGV2ZWwgICAgIHhoY2ktaGNkOnVzYjENCiAy
ODogICAgICAgICAgMCAgICAgR0lDdjIgMjc4IExldmVsICAgICA4NTA3MDAwMC51c2IzcGVyaQ0K
DQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+ID4gIAkJaWYgKHJldCA8IDApDQo+IA0KPiAtLQ0KPiBS
ZWdhcmRzLA0KPiANCj4gTGF1cmVudCBQaW5jaGFydA0K
