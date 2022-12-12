Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48564A705
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiLLSYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiLLSYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:24:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20A1115C;
        Mon, 12 Dec 2022 10:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670869476; x=1702405476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4365wdZkwgW2b/CTI56DzpYt0hFciYSW7H+V8wNZ3O8=;
  b=Z4zang3ct4hUU7DUpb5mVTQIU6lwNOe5shtHuwf9hrOh8rMFcDBMotjM
   9l0uMy+Zc8t+vbfrWuLs+JHVFpXpbmSyeQSA/ahTPcUkZVqo4CIyaw5PS
   yUZsKFuKhdpJLp2BVTZj9+GFDvVbAzcgxqiDYzUiWjlPmisK+pfDyEs/I
   y3YMRekHWJkgRIHV/LnBAQ2SsHdRettl0QMYPTglBDhr1E+VdyM5DREWS
   AzvVBTkuPmRpZDH0yMXEPWOA+lBK3IP7TpgTkpIhLyChptEXWcOc2i7kR
   8yJBqUNZs7BnxVCXNGj2Pam572ULzwkj2Kh35QBSdF80LqCCtHA4EW9Mi
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="187781479"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Dec 2022 11:24:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 11:24:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 12 Dec 2022 11:24:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAUdTl7F36fO4RXrZQECArbnOERowYCOcw9tFRieqhLkqdWDuy1VN0fw4y+JTztaUHotjLH1hcSRWq4lLkR24fa7H5NbWGRbzJ/e2jG1XJSOWUO7/naM8f0uuUuwydZuA8EIdIEzaFc1Q59r1JMI77REycBf7Y7TtUW5GMgC7jLGwcnb2zbMHX3+puu5v9b67Fh4XTYu3wWG50ondt9dZWmAafxwPLwH6+jra+7Tav01gR0quF2ZzskOA8Rns79tPiDdHU15m4Q5wB6v3FmjYkeKuGMOtQxQwREGG5mtqCYA6/mOHx7s9tQx5YSpGxBhSbI9CmhyJ2hvF97JkTpqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4365wdZkwgW2b/CTI56DzpYt0hFciYSW7H+V8wNZ3O8=;
 b=NPAgrC5tqJNJgKitvjJxRiolfyOtxW6qaxavMXVZ4UsbLsJ3r5197NsRU8kCIrNzKtjZEXXkhyksiHCXz6Xg3MFlQf8HBdbmNHSLYMZOfFiglG68mCaQxrfm/VVM7YXpUuUKqDhqDkMYEdeJLfqW7MYNVr9+Ma1fbmiZMqyVfSHpnNVGP5brQBPVQdJ/Y1W5rwe7e/tR9+6Av0WpDace3aHuaM8vUXSwD7H0cTcpJyft5CXyshn09LR1ar0F7ui1Et1t8zMYZfVQup6K9WUJ4O563wft7ifk+9enOZ1TgGdolCiT1K+CkoN+kKwrwEEka/FBLjkWBXBZT/YLiugPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4365wdZkwgW2b/CTI56DzpYt0hFciYSW7H+V8wNZ3O8=;
 b=bYCkXUoNKD3Vtq/kvgN08PgYJiatslr0QhlZJLklxoacfzPNbsTkLyCfmb1aTKV/WRCGDKzFXStnm89yzpMR57NN417PUFihWAEohnyN0FFNPCMhiXyukvnJOt8W4Uo2y28lwtTR+ezay6sUpGPNogVZqbMsvebWIwGoNYf4j8o=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by CY8PR11MB6891.namprd11.prod.outlook.com (2603:10b6:930:5c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 18:24:30 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 18:24:29 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <jirislaby@kernel.org>, <Kumaravel.Thiagarajan@microchip.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <andriy.shevchenko@linux.intel.com>, <cang1@live.co.uk>,
        <colin.i.king@gmail.com>, <phil.edworthy@renesas.com>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <lukas@wunner.de>, <u.kleine-koenig@pengutronix.de>,
        <wander@redhat.com>, <etremblay@distech-controls.com>,
        <jk@ozlabs.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v8 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Topic: [PATCH v8 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Index: AQHZDJkj7rnAVfXmX0mY3XTqVMobIK5p4f2AgACvFsA=
Date:   Mon, 12 Dec 2022 18:24:29 +0000
Message-ID: <PH7PR11MB59589772F30888181565BEDC9BE29@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221211014730.1233272-1-kumaravel.thiagarajan@microchip.com>
 <20221211014730.1233272-3-kumaravel.thiagarajan@microchip.com>
 <29c707e3-be9f-24fe-107e-591f3b3b3d49@kernel.org>
In-Reply-To: <29c707e3-be9f-24fe-107e-591f3b3b3d49@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|CY8PR11MB6891:EE_
x-ms-office365-filtering-correlation-id: 87667c44-3ca7-4f61-b40c-08dadc6e1ba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M6LP8auBn6Hz8qxvlalHx2A9fGPqbQB8wKX8UUYxQGjJML8zW6zf0OGzHDqCVIttuX0MmpURk9eWVH268iDZ9JnWwbQ/2MQ4cE/uAkOxpnbtajN/ushqIZHH5+31UMx8Ez1ABgwgWdFj3V9j6RZJKSzteyZc76WOCWfIbEyh1GSXzw1tSIeg1UoNDYFOTYOTJH0e68d53jsdBrhCRuHBJimgNiN4IOE0XY/whXNxFSVc/uapwqv1f/yDZ/568sKluZyfYBvV1PmzrEnAJVYi5JozoRXCawp7EtVnylGltfQtcG2lJWPnpxZer0+Df0ao/i6/9mzguhU6WRV+97Qe5jQq/w2xLZ19G/sB4Q/j/6O4kpt+0b6c44r1soHkfV9qBu3eG3AnoJ0dgUF5IluXLoOwOpKJJCMtVaYBvSlFPA1O4rzVmeVw/fUrgASYebJUFn6Od3KUBgB2Zg7hLyhNM47JZu5GKz/tDpIbsFqnltM9JsTGbiYkPkfB56/kUzKRo1VHScPXh7XiqVlkZ7np+W4oDc6yyeBVRJ6qasdLu/BAxk+oyjD1BjgUmRrRyzQcdXNYIyLc40ub6X9sQTExLEOk61aI2DPaneLeokAhUc9JVGBp9vnAp7J7vjo8VuSnVetO2GDfnSJGIWEcTKeKb3cHKlK9jX3RucTMu7pIh5wTNyPuAormzxLNXa13I/cXFdpqULr2zK6DsUNVxOd8lA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(186003)(26005)(41300700001)(71200400001)(478600001)(9686003)(7416002)(54906003)(316002)(52536014)(5660300002)(8936002)(38070700005)(110136005)(107886003)(66476007)(66946007)(33656002)(64756008)(66446008)(66556008)(76116006)(4326008)(86362001)(8676002)(53546011)(7696005)(6506007)(38100700002)(122000001)(4744005)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmJhRWZyRjd6Q3k3QUU0QU9uaVNPZzJsRXZJMS9HekVqRm9vam1UUXQ1M2Fa?=
 =?utf-8?B?MThqaU5aY1N1OGJjbmtVa251V2VPZlJBMDdMd0FveHIzZ2ZiMWpodzdWUy9w?=
 =?utf-8?B?UUNOZWZ6MktNMkM0V3NTV3Q4eFBuR2VLWDFIVjJGcFROZCtnNzAvVjJVbnpp?=
 =?utf-8?B?U3lmYlN5VTlna2llM3ByVStsYzlsVzFWV2ZTQm82SmpJNlZYRXdCK2ZMK1Rn?=
 =?utf-8?B?WTNaVXlHNjQ0ZHN6czdFMjJ4WVlYb3UvNTZkNXQzbmlxMFpiMTJsS3FVVXVr?=
 =?utf-8?B?bU5wY2dScVAycVIxU0ZVdWI4cmlhRFJCRUJTVjBqTm5NOC9DSDBBMUd3eWpB?=
 =?utf-8?B?aGg5R0tod1oyUjZmRldxQXdmMXVaUzNuS2NjQVB0cVRvdW5YSlhWMFIzTTBa?=
 =?utf-8?B?QWtLRjVmTmFNS2wva25XQ1FiUGtRTTcvTFJ4Y21WNk9rQXdvL2FIUU84ODF0?=
 =?utf-8?B?ZlExbWdGNTFxayttd0ZuMjBKL1poR2laRFZ2QS8xeStYYkticE0zVVZBRnNQ?=
 =?utf-8?B?Y2dQUXJHTHdDb1c2dHpqQUVRV1UvVlFFRHFTT3NWaThxQmpPdVhuUmtobjE3?=
 =?utf-8?B?SHZSRkFjdVlvV1NUK1FQMGlhaStJakMzb1ppY2ZoOTBwRUlpQkFjd3VIemRY?=
 =?utf-8?B?V0NGdDN3Sk1FeWQ1bFpCVHlrUjMyZGZGcHdIM0hjcGpYeDRWeWRqUjFEZlU4?=
 =?utf-8?B?SXNRSkNNbDJlWGpEZlRzL2VNdEhNYkZ3Y1pZVmQybWdKYStUOW9oVWhzcEYv?=
 =?utf-8?B?M2NvQzI5ODlBUms4T0JHUkw1dTlrdWhLUTVMRXJmS245Z29aVnVsWS9PdjB5?=
 =?utf-8?B?VUxzVmpFbWxQd042aG8wTnIzYVJZRzE3SkJROEJsNXQzSkw1aVA0WTZWY1I1?=
 =?utf-8?B?anA4alB6Ukl4RVRWZE5hdmI2NGpseGJreVViQ3BYajVGVU8yaFRaQzZ0YVFx?=
 =?utf-8?B?c0hyREFuaUg1UHk4aTU3QkpLSnZoRmp3N1JyK1pSRjBrSXIzb2U4bC81ZVJZ?=
 =?utf-8?B?RU5udVl3Q01Vb1N5bkg0cllDU1dwcjZjVnFySVd0VFNzZVFzUUZJTm5wbDk1?=
 =?utf-8?B?TVBXalZ6b1JsVzZVNkxKSE5mUzdtbmE5VGp6RThGOWxQZEF5c20vVTFWVUxo?=
 =?utf-8?B?cHlhRUJCazNzV2J3VE1xRjN2ZjhaS0ZHVkI5cFFVZmZmV1c3NXR1WjNDZCs3?=
 =?utf-8?B?UGt4ZDBUZkk3VEZGL09sY0tSYkVhaGFXVXlqcm0rV1lqRUZLMzhiVm1pVWtv?=
 =?utf-8?B?UCtEUmhSRHUvK2F6SWV4RVhxblJldzBUeXhtS2JZWW9UdUtDdkhJenN2Kys4?=
 =?utf-8?B?aUUyZHJ0clR4RzNtSno1UW9USFBUNkQ0MHZJWnBCcVRiTTJYYUFrcTFsSE8r?=
 =?utf-8?B?YkJYZDM1djl5dk1qNlV1NmtZdVRMLzFYWCthcTgxZithbDJhYWV0YlA0dm5L?=
 =?utf-8?B?Y2NaTHhGWGJwcGxwSk5oNkh2RHd1dzhuNkhTUzIxYUt1NngzV2VMekpJRXhW?=
 =?utf-8?B?U1dvV1grclRLU21URURuM0NrUWpCZUYxMU1BckQ3VmdHUGZLUG9ONmhBQjha?=
 =?utf-8?B?MjlDRDBDbDBDTHdHdDEyT1FvRXN3Z2xjRWl4Nm1SNnVpZWlkdnhFYmZmWVd6?=
 =?utf-8?B?UDZZVDkwYkZidDIvYmpnaHdqSTJ0b2hwd2N5L1dMR1R0ZFQ1b2dpNVV1TmtT?=
 =?utf-8?B?eUFpM3RjWVR6UkRiMllZdzJDRnd0SSs5OThVM21tWDhsRjRoVGwxdzkrOEoz?=
 =?utf-8?B?T2FSbDNzb0R6YUg4R0J3YnhEVlRjRXMwQVZvcnFBUWViS1lGUVNNQ2lhakky?=
 =?utf-8?B?YjBhK0w1QzNZYW9mK0E1OTdMd1p6ZzhrRVF2ZXUrVlp1blhqVm5qUmI0cHJi?=
 =?utf-8?B?cEpvRFdzMUF6YmlKNlNEelFSblBtR1ZUZlFiZGFMVkRFaGhKeDBpNXpuSGxu?=
 =?utf-8?B?c2phaE5tdWZ2R09jd2kwZFovNmd0QXF6cit1VmU4aER4bWFsWm1SWFVJK1I4?=
 =?utf-8?B?aWRZM0NxUEhyNnEwNWs5cE9lbDlTYmx5NGxqSTJRREkvOXh3YkpMNlpQa29T?=
 =?utf-8?B?NlZwdEhIRlJSSjJNTkJTWU9mRE9CU1ZKaUNKdmFLQjc2Ti9vM2wrV3dpN1hV?=
 =?utf-8?B?dkVsV1R5NzVpQlZNRm5XZk44Ky9UTWxIL1BndXhjemtlOXN0VnZDVVlpLzFZ?=
 =?utf-8?Q?MCtVzp+Wjxzf5/Z0sw9XP6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87667c44-3ca7-4f61-b40c-08dadc6e1ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 18:24:29.4169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36LKq+kXTgGigN8iozAKHkXQJN6SPH7nryjtcx/iXV8oNrrp2cY8U/fg/lf0qCC5SgtvxbLhqPB3YQVOJJDRzBzYSVX5EJAmAL7dL9pzyydT4vCzYB7q4H4tS6Aqm+s8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6891
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgY29tbWVudHMsIEppcmkuIEkgd2lsbCBhZGRyZXNzIGluIHY5IHZlcnNp
b24gb2YgcGF0Y2guDQoNCj4gRnJvbTogSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+
DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTIsIDIwMjIgMToxNSBQTQ0KPiBUbzogS3VtYXJh
dmVsIFRoaWFnYXJhamFuIC0gSTIxNDE3DQo+IDxLdW1hcmF2ZWwuVGhpYWdhcmFqYW5AbWljcm9j
aGlwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OCB0dHktbmV4dCAyLzRdIHNlcmlhbDogODI1MF9wY2kxeHh4eDogQWRkIGRyaXZlciBm
b3INCj4gcXVhZC11YXJ0IHN1cHBvcnQNCg0KPiA+ICsgICAgIGlmIChudW1fdmVjdG9ycyA9PSBt
YXhfdmVjX3JlcWQpDQoNCkkgYW0gYWxzbyBwbGFubmluZyB0byBtYWtlIG1heF92ZWNfcmVxZCBh
cyB1bnNpZ25lZC4gU2luY2UgSSBhbSBjb21wYXJpbmcgaXQgb25seSB3aXRoIHBvc2l0aXZlIHZh
bHVlcyAob2YgbnVtX3ZlY3RvcnMpIGhlcmUgKGFuZCBiZWxvdykuIA0KDQpUaGFua3MsDQpUaGFy
dW4gS3VtYXIgUCANCg==
