Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A715B715E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjE3L4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjE3Lz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:55:58 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03506EA;
        Tue, 30 May 2023 04:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVGzkfPEATZNBBY3X6oSHNLtldQVzV96rYn0LUiwLijNwCSFN4NTjYaRUmLS6AcuJCpq+b9Jns6X1T9RDcddEsHCyey0nmQywiqmr3ji4Xw8442utmsDL3o0JWIqOPnaB5s6X6sDGDwJc8eC1I7LWaX5c59Nz48fNGDKWOPD9k0QhzDUcF1FntFk98LA/P/mxXWl2DblW/ywxzBix+FArxlwIR1xsdLhO0okQq7j6Ke7JeONv3wHpDNGMUu1C6baKxc9I6UC0VvwChxS+pnsKEegjYesel3I9Pdr0SuRgUgpAP2o/pb+moeoBR2OL3iEhECHC+IvrRYLNRmyBIr5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OP1/84TbV7gE00R57pFtrZQCKynu+bulTM+E4PRwi8=;
 b=ZIeyk3sttgPpdxLcaM8akPqZNj6qDvgw0Jb+mVVot70ZLsw4QZRMq5/AD34B0KUZYYT245Yf+UjLx/HntIadTvX7vvu9raFj5KXdoaVV6JqZ2Zvk2FH2eiEgzkXxt4NcyGNuYSM8IxAvbjqIxTI/zhPhTI/5TvXJy4YfRS6RLDhSOnXksXV8GTdJaMhQZbegfcavSzdyvLj+qKzSJqZ8WlcNmRLhMnVahBeDc+XYetYkc64fBLJGqwsqKrYjAKGMAbz9ao+A5elhOqDzHp1fe7EFW2+xobZVmBJNuzASSJCq3fZ7t/vls/GjyW14Hx3+muSQv28pIKbXLU3gXvAr7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OP1/84TbV7gE00R57pFtrZQCKynu+bulTM+E4PRwi8=;
 b=hf1rrg2ktU2rtWi0mOPEB0ONfryYdcGdcfFiRl9KIBJJvaJh0/UibyKVsG7xSOwJXquPL+XeDJBpUoJWy7uvgCCGjnMnC2PEV+gsXmBBsvBsGURtpwC266QUCeVMcuTlD/rgAX6KBda4YOg6rUTIM9TUWPbc3+wuIOW6KAIkiAE=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYBPR01MB5390.jpnprd01.prod.outlook.com (2603:1096:404:801c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:54:45 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:54:45 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: RE: [PATCH 6.3 000/127] 6.3.5-rc1 review
Thread-Topic: [PATCH 6.3 000/127] 6.3.5-rc1 review
Thread-Index: AQHZkZqlgOUN+tCVv0urk7agJbPcBK9ytTNg
Date:   Tue, 30 May 2023 11:54:45 +0000
Message-ID: <TY2PR01MB3788ED71EF97EFC96AF02621B74B9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230528190836.161231414@linuxfoundation.org>
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYBPR01MB5390:EE_
x-ms-office365-filtering-correlation-id: ce116d73-7bce-4554-4c78-08db6104a9c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FV2ZdPglynVP3F1T7KxMvNFs4jOW1VlqaEMuDT9ypfmWdKpJLbsUfIQIz6CV3LCmA1UzqEVZmEOZkrjyN0y6jpy7EYsp+aA/Mk8U+5QSaDWaotUwM/HsEGhSmX/edort2bHmOb/szi3zL+Lf/Yd5wuTcD9F3MHxmq4Qbb5zLk/IOx+DmD9Aiu/tF8p4A+s7hh4pklP5zHBUD2r3KJ/jmu7kTVwMTmlBbX9uVv1WgdTLVzoEO6nFBiA/0bqYNsk2c1iVdXe91zp8RZooy9JwEda3N6nF0dHe4FZUtoPCgorGpBAd75H4UurmHlgSHYod6/Uqw/wLxVha1EjfqN8ONkLFFAlsttXaxfOsLfHIVTTGJfTNnUmJoR3/ouj3B88uW6hPxAfip4dUWORBl6AnpwtI9Y5/xLO20c3wG1b7D/4G5ov0Pg3wVPrypnw1dDPyxS5YoWtz6b2dd4cn12G1jkVVscgrs52ouwijHy8jgW8yXtlHLG8HJdScN/6bknDmNhPoAaYhZs0wYpAXaUVqcg5wyH+aGvmo2IXViHSOo6DE+8yQOsohPfyncGDn8KEdmfdDSNwh7h5xXp9QKm8WwfI29QYeOpQyzjwSvWikhTWEMaDh3JD859XOk9f4lnGa0gdn2jhVG9+M6jRnI9H1/KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(71200400001)(478600001)(54906003)(110136005)(8936002)(52536014)(8676002)(7416002)(5660300002)(33656002)(38070700005)(4744005)(86362001)(2906002)(66556008)(66946007)(4326008)(64756008)(122000001)(76116006)(66446008)(66476007)(316002)(55016003)(38100700002)(41300700001)(26005)(9686003)(6506007)(186003)(966005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VURYVlBJOUtscHdmbHNnTDFITDhLUFJxbUllemtFMXl3UmhBTlVWb0NkMjVs?=
 =?utf-8?B?cUpKZHVQcUJjRXRvbTFwZTZrUk9taStDUWVhdWk5RFk1YmlYeStnQXV6b0pY?=
 =?utf-8?B?bStIVUJYNzV2ZUZxRUtuTnFPdU1pTHB4ekpzc0ZKdjB2TnZ0WTZvRGxERWtX?=
 =?utf-8?B?VndhakplcllTY3dGeTF1TmVyV1FNcW00b0Q2a2tBUk8xNlZXVTNTdW9jSjlk?=
 =?utf-8?B?cXpxVWFIRDlsSWFDeUlhZWZTQXo0SmxST1pjTmRUcVZBNWlNYUx3Tis4S2tK?=
 =?utf-8?B?U0djM3VPZ2VLK2VaK3A2Y0IydHpMTzYyTmc1MGdvOXYrS2FrMkZoeU9qN3oy?=
 =?utf-8?B?MFpFY21PNnJnYlU1dFZQck9rZkUvcjFRZWtKb0NoUlNQRVBWK2dpYXd4bHVn?=
 =?utf-8?B?ZVVQTld1WitGdFlkU21IN0xoRmhEN0Q3ckZXRGJqTDZMM1hOdDUySXhaVzlP?=
 =?utf-8?B?NDlTcUJCZXBqZ2dFc3pwYk1JdCtuQ3ZtU3piMWdPMDRWSGdsRW1URzQ5cjZs?=
 =?utf-8?B?MUcrRTJNeGh3TmFLNWlYMzhEdGJibTkyQUxlNVpCeTE5VkVORmRQVHVvWmZ3?=
 =?utf-8?B?SzBmUkRQbHVhU2g4TEYrbWxzNkVGa2V3RFVuejY5NXFiVDhrcVdUeEY5UFlj?=
 =?utf-8?B?QjZIb2lkS3NYSDYvTUFyWXVxV083cGI2R0d3SkoxQ2E5bU9XaFhoNDJxVERK?=
 =?utf-8?B?czdscXdVby92TmVZODUyNzdRazBFZzNDbDRZSmFDdXgra01UVDNKRWU5d0RT?=
 =?utf-8?B?VW1PQ29YUVk2c2NYazlCcWs1ZVZwdmNrT0xtWDVmR1Z5QW9zZDhIMG0wRlRK?=
 =?utf-8?B?Y05nbjNHQk5QRzArb3JwQzBPOUxqRGErRDRGa2k4M09QbEt6QzdIb2VBZ21k?=
 =?utf-8?B?L01DUnFSdU1qL0szSzJ3V3BWMndubXVyNE9DZFNvT25qbEkrMGswZ3ZTSDJ0?=
 =?utf-8?B?K0VzU0grTzgxTTRuazRNVXBwWjFEMzRMS1dnM3QrdXQ0UmdRYUMzaHd6dUtx?=
 =?utf-8?B?WkFmUEVyZkdyNUlaL2hpWCtnajVHMytvdk9JendzQXdyZFBEWUErTVBaVG41?=
 =?utf-8?B?ZElBV0NKbDZpcWpRNGVmL1JKdjc2bkR0YXZxTmNxWC9KRk1sQWc5NzBUTVlr?=
 =?utf-8?B?NDZkdEd4VEw3dlI1KytVODFEL0NXQmtQWmhRSUp5MTJuUDlGeWg0TmVyOXNG?=
 =?utf-8?B?TmY1K0UvK3RqMHlPV1A4Q1dyOFZxY1FQUTNlUG16TUZYRXRiSVY0eU0yK0dM?=
 =?utf-8?B?a2t4SUlEUzFMREphUTRvcjlWaTczNTlIL1N3b1JpTnV5SEJKblQ0cmtkMFA4?=
 =?utf-8?B?YlRtaEtxT0Q3Tm0zZU1KclFXWDZKSXl4c1NrOFl1QVhtMkdqcXFEMkxTOTk0?=
 =?utf-8?B?QmUxMjY3UzZybEMyUVZ2VjJaRmZMalhLYVBHZTRyYVc5WXpPeTVvbCt1NGFD?=
 =?utf-8?B?UlZGQXlFL1A0NGFXbWtCb1RGYmFlMXNxK3krTGxkWVJPRi9Ic1dtWlRLdUdL?=
 =?utf-8?B?bTkwSC9uNjV4a2N1bEkyTm1LTmc0emFZS3RobVZiRVMyYzRFWGRTaVZhd3V1?=
 =?utf-8?B?YnN3VThTdjBuNksrNWQvZ3FLWmxmOFpWcmh5QXhWVzM5a0JnTVJsOThiTVVN?=
 =?utf-8?B?SkMzQzZUamJoZ045T2dIdENqQ2V0WFhDS3NsUkJJRmsyYllZSVhEbnZUVWxl?=
 =?utf-8?B?STBmNVI5dWYvZ0pycWFPSFBOSjZ3U0lmQXI2QUp0dDE4ZUZadjkzbUlNZi9a?=
 =?utf-8?B?YnlxTW1oRmF4M0ZXNUZnVmE3NUJtMGhIOEZUams0N1FoazExVER3QVBFdGdX?=
 =?utf-8?B?dGNHZVBLUkh0UncwT3B2UTZTU3R1WDhJT1lhbFhDOGltaWZvY1NiUWxKQkNj?=
 =?utf-8?B?SzVKT253cDBmL1AxL083Skl6aDFDTFpEZzFxU3FtelJabzk2bGlVTjRVZ1k2?=
 =?utf-8?B?QndPazlYVWJTdk53c0dPKzluYTh5bHN6RzBxdjMvUE05UXhXbEdJdUk4ckZP?=
 =?utf-8?B?QkZpdksxRVVWMXJlc2YyMnFUVmhHV2FtSUg3Lzd6R0NuOGtaZ1VvWjl5TlBL?=
 =?utf-8?B?VUdzeU93YytsWklESkxCcUhCay9iSkpmUVVzQk5zR0FBeWpscUJVT1pRcEw5?=
 =?utf-8?B?WnJ6eHZsMW1TSmpJU0NmazhmYTJXc2lpOW5LY0NaQXpZWkNZWWsyRWVCRWpR?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce116d73-7bce-4554-4c78-08db6104a9c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 11:54:45.8999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDiTenKecSK5Jsoop9tOFLGS8fm6eim1SZTDTxzOS2UW6oUZa6QsHW+WQwFhmid5o5lPJ2NCLpZDi3goq3Z6rQm5ut2amwHXrfuFUpKkkiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gR3JlZywNCg0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPg0KPiBTZW50OiBTdW5kYXksIE1heSAyOCwgMjAyMyA4OjEwIFBNDQo+IA0K
PiBUaGlzIGlzIHRoZSBzdGFydCBvZiB0aGUgc3RhYmxlIHJldmlldyBjeWNsZSBmb3IgdGhlIDYu
My41IHJlbGVhc2UuDQo+IFRoZXJlIGFyZSAxMjcgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcywgYWxs
IHdpbGwgYmUgcG9zdGVkIGFzIGEgcmVzcG9uc2UNCj4gdG8gdGhpcyBvbmUuICBJZiBhbnlvbmUg
aGFzIGFueSBpc3N1ZXMgd2l0aCB0aGVzZSBiZWluZyBhcHBsaWVkLCBwbGVhc2UNCj4gbGV0IG1l
IGtub3cuDQo+IA0KPiBSZXNwb25zZXMgc2hvdWxkIGJlIG1hZGUgYnkgVHVlLCAzMCBNYXkgMjAy
MyAxOTowODoxMyArMDAwMC4NCj4gQW55dGhpbmcgcmVjZWl2ZWQgYWZ0ZXIgdGhhdCB0aW1lIG1p
Z2h0IGJlIHRvbyBsYXRlLg0KPiANCg0KQ0lQIGNvbmZpZ3VyYXRpb25zIGJ1aWx0IGFuZCBib290
ZWQgd2l0aCBMaW51eCA2LjMuNS1yYzEgKDFjZDUwNmI1ZWM0NCk6DQpodHRwczovL2dpdGxhYi5j
b20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtc3RhYmxlLXJjLWNpLy0vcGlwZWxpbmVz
Lzg4MTQyNDgyNQ0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2xp
bnV4LXN0YWJsZS1yYy1jaS8tL2NvbW1pdHMvbGludXgtNi4zLnkNCg0KVGVzdGVkLWJ5OiBDaHJp
cyBQYXRlcnNvbiAoQ0lQKSA8Y2hyaXMucGF0ZXJzb24yQHJlbmVzYXMuY29tPg0KDQpLaW5kIHJl
Z2FyZHMsIENocmlzDQo=
