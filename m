Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672A260DF12
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiJZKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiJZKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:54:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0245A52E49;
        Wed, 26 Oct 2022 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666781661; x=1698317661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZekV0waZiCjFx7Rfj5xBJ0KcBLK6aJmcdbDczjNG6Qo=;
  b=ZUxy5VZQvuDxvgsXuRGfN+0emPp7sU/Tlv+cixy6J0k0qY8YDtxkm15N
   F8Plvn3R4vnc1ikaahiW3DxNNuqetWvhMLMbelsa+VbJmIDT7FDrMjbxe
   YoyNCdGGUxtM+ns48QfbBt2cB6X93g0367h4inTVF50nQIGwXZKYoKpd0
   7Coc5xGevR9nCHoySdNTBBGYsU3+dV0C99McCOpn6IRiEM+kAtfP2kNLf
   BKB9ohoD7HY/H8+gLCbWYti/bnYTEZYOfLKge9vJQ1VkbRPGZtkev3L+R
   fg4RHn6o6bFPiekcp7FpazMoQk5qvaeQl8VdLuJYiQLBDd2YyNyGvW8wk
   w==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="197091275"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 03:54:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 03:54:20 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 26 Oct 2022 03:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzsz5QF4aQp+5bCZJnTpQ5XghtsPyYGlCvwGHAo6qytMPNVdFRzCkpwWD1mQ6FfvP18d/Pwjqd3dQX3kEQoRSf1Bc4dsHSHN/zr7WLkNg1Kzol0c3SMWM9pizziQy7DELnnIzTlyyM8X2giTHsmwKZTMzMnRScNOvVCuflM7L3ugX/4z0TKkS/J3EXU7be1O+0d/zNw6GIsosCghTkrGIQVLBBlffKm2A/4UsxK3O2ghAUo5WlQ9ZIPy0iC4+IKQWtHZRpbPrlH37reCIjqfo7+enyvMgBTchfNKumUOwmsLMZInSa8u56OXIrwIv5b0arByaJLOy8u4wO/7EI/ujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZekV0waZiCjFx7Rfj5xBJ0KcBLK6aJmcdbDczjNG6Qo=;
 b=FKt3oyCKTfdUYvnHWYrUa9j3TC0L3kIgsZ0h3EkP9LLVhUiamqzcDdHV5UqfYeuTVU6Jp0RUarXEUvenmAjP4CiGng3g7KRhSe83ea6tEKGYs74mTviVUtsAfT6gfZt6XGhSg9+7lvPxlENN7zm0PQT3dyXKNGQFqlhoYMFnJYOIfQVOvcu+a+TNC5/sRXLl28/wfHfDPCm0PPl9Y2MO4sOSRxBOf+NeQRXJg6JKrkZxOgXIRyIkmlWfYsmWCVd0X+kuoj3qobEk3HojX4eVR3pBXrv7jRZGzvCqrbJT1DHokY/m9FSw+jkyE7Irh7+duc9yNU6YcbozhBw/82HClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZekV0waZiCjFx7Rfj5xBJ0KcBLK6aJmcdbDczjNG6Qo=;
 b=Ng914MwlCKKank791iobNXKebnyrzYbYGgZyST3sQC3l0b8xVI1bhMEYmFF9uNS1emGkpRfrMN9JY2+/4jU7EU4hfmnOvJbWC8z86s/skRX3MkCHcSfCGtsxy7GSKJK8txmpXgYsV8dQ1yMhi3B90Np/5XC1hBw+yNfoKebSGJ4=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by PH7PR11MB7480.namprd11.prod.outlook.com (2603:10b6:510:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 10:54:18 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::9689:f094:d23a:ad9e]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::9689:f094:d23a:ad9e%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 10:54:18 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andy.shevchenko@gmail.com>, <Kumaravel.Thiagarajan@microchip.com>
CC:     <linux-serial@vger.kernel.org>, <etremblay@distech-controls.com>,
        <gregkh@linuxfoundation.org>, <ilpo.jarvinen@linux.intel.com>,
        <wander@redhat.com>, <u.kleine-koenig@pengutronix.de>,
        <jk@ozlabs.org>, <macro@orcam.me.uk>, <jirislaby@kernel.org>,
        <johan@kernel.org>, <phil.edworthy@renesas.com>,
        <geert+renesas@glider.be>, <linux-kernel@vger.kernel.org>,
        <lukas@wunner.de>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
Thread-Topic: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Thread-Index: AQHY1V1ECgbqKV8AiUiKZBGdoHOFW638aLWAgCQ/rIA=
Date:   Wed, 26 Oct 2022 10:54:18 +0000
Message-ID: <cc7d8655cb350b45d547abded44ce839cfe00023.camel@microchip.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
         <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
         <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com>
In-Reply-To: <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|PH7PR11MB7480:EE_
x-ms-office365-filtering-correlation-id: 57d42b69-f4f8-4e86-f79c-08dab7406e75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DsoQgOT3Q+dJtB9fuO+iLco0AN46hhTcfaEHJErdPXUIGQLFgOrhWJ/5qjG5fGBBtbXv5G6XR3TQ+NiprY2fHrhkvFXHGg+itUzaeJTtFTElltR1piZGhQYpKXn64YpmnXwLx2JTT0oI/lo85VdECHBifdMPMad6tikhphcOsRr9/6Tzx7TiCJZ9wQcAG3TePBzxYtIHBXifQrRJ5aKo5hTBzVgsHWumU7hcqpHMuIi1G63wl3oL9OqLLwW0emT0L2myXZb7jAk1vMJ2zRc60V/qBTo18X4QL98MjZKpR6z2DhXKYFvLQawzPHPY3/sLZfA8D6KsEzqz3VKudsB7e/OO60E1m9J0PllKuh1geQJavuUhyuWt3//sZqvL4FsH2OIVm0qR/G6c4NXCiQOJy9GE5KwhkcPBZmnKCMqPGXGZ25fYnK/RdYqwvgLY8qV5tRskiXY4sKaYAOhfNwRDNcaPMdzLAlElrqqESt6WhLJX6g8Sui0utwko35p3mSxf38IGtKiY6+7NK6XP2Kb/zxFS/nvQGlmGbOiSjbPgTCIjzz55CUHzHy/iLb0Ox7+b/YV0NZnopcUiLim24gZy/FKksv/uMS7lEZ0EWLGtPLf/8RArux0jRBpPrLaHo1g64rm1TH6uN0X6PASH0H4wImEWCX6tkLVqb4lpqN+KNJu4elOUTYyVLeCaLymdTImptgJ84ACzL/PhV2gg/hlEbWZPIv+L1q3brBGvCyggpde/D10MI8dx5w7qqdfUu0XVBdvyc4S9R4ru2ztd67sGMDTpwRyR3Z5MfDBhg2ay+4I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(36756003)(8936002)(5660300002)(2906002)(7416002)(71200400001)(478600001)(4326008)(41300700001)(64756008)(6636002)(110136005)(66446008)(8676002)(66476007)(66556008)(6486002)(91956017)(38100700002)(86362001)(54906003)(66946007)(76116006)(83380400001)(107886003)(186003)(316002)(6512007)(6506007)(38070700005)(122000001)(26005)(2616005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0lwT2FDTE5yNkhNQ01BYWNyTE5MTHVsQzVtd0RieEpycG8rVEFnd2ZWMFZs?=
 =?utf-8?B?cFh1bXdsT3pKdWs5T3BDWDdJRjZuUWlJRFd5SFRQMlJSaG9TSHVIUlpxK0Qy?=
 =?utf-8?B?OTFaRVNWS2xqMWFoS2FLM0I4RHIydzZ4bkJUb1IxbitBUFNzRnpBeE1BNG95?=
 =?utf-8?B?b0dRSVpNS08zZXJLUmpoZGF5Rkd4M3dsdERIY2ZUNEZxOG9McGM4T0JCRVd4?=
 =?utf-8?B?WjZzak1KSEh2cm5YM0lLVE12cnpEeUdMaXd6cUcwc05zN2VWOHZHTjUrTnZm?=
 =?utf-8?B?dkd0UXZMUzRUYlVrUllyTWFjdFR1TjdFWVN0YUdOTTZ2VmtoWlJiV2tXemJ4?=
 =?utf-8?B?U085UVRHTXNmTUNueC9SYUlmZ1VZSndvNHczOWdiWjMxM0s1RzJ4ekgvVmNw?=
 =?utf-8?B?UU1mcjlXWEQ2TlJkbmhjaE5kYTBJTWEwQWZ0dE5vb0dVZFgxbkphSkh4VjBx?=
 =?utf-8?B?em1KSkhXVmxmNVUwNGduWXRHcG9naHJiUXRzdm52MThHUHJnWDZZY1hLMXpX?=
 =?utf-8?B?d1doYkZJa01La0VZRVNXVW5PemlJVFhhTkhYL282T0ZnQUI4SGdjN3dLMk9i?=
 =?utf-8?B?R3BQSDdrWnhyTFNzbFd6Z05mUTV2L2ZZbHBsOC81Z2I0RlFtYytkUHFPQkxz?=
 =?utf-8?B?MXZySmdJS1JpY2NybEJFTDRFSE1FN293amJCME9TMWVhU0JsdzBjdTZ3R0pL?=
 =?utf-8?B?eWxzR0RlWlBjSFZYaFpGWlovWWZNMnNFazRwQk42azRHdEprNjVaVkZlM0JL?=
 =?utf-8?B?ZDFVVGZpNzVWdTFNeFdPVkNpbG4raEFjNmJTQXAyS2s3d1VKZ0FmNzh2WUJ6?=
 =?utf-8?B?NEdhVGFFK2RKWlZ2WFdsaWc3ZnpPS1VEL2lacGdZSzFFTWFLd1FZVVJzcHU5?=
 =?utf-8?B?S1FDa3BNWlJHMURKNmhveEpwcUNiaDAvTDFQSGxxb2N5SUxmVjdtQjJBZGhH?=
 =?utf-8?B?QjFTbG83VmV6WDk2Rkt0VHo3bTNVdHp0WFJ5QkRvQldhOHJvYlVNeXRMNXRu?=
 =?utf-8?B?RlIzejNqYzAxNEdrYzVqSjZBWm1jNENBRnBvZHI5SzFvMVNiK0EyZzRQSWFi?=
 =?utf-8?B?REt5WTRCMC9WbjMvSGpVUzcxd0VxbWF3S2tITEg0Wjdhb2hKdnZjMWJZcU5W?=
 =?utf-8?B?UFcvWFBhSzVNN3BGK2toNWhJWmpLUC85aWpYOUFwQlBMNHA0UzdFRFl4dTUr?=
 =?utf-8?B?M0FCMWw2dUZ4ckJwaU5vK3RyYXM2Z29XVHJjR0JqS2tTZjEwelU1MVFtRHEx?=
 =?utf-8?B?dDBaYlRsU2N3cG10TXZuYndnTU9ONnViOU5NQnR1SUgrMjc3ZzdvUlJjNWNM?=
 =?utf-8?B?cUkzS2FQY2pDWDFKU0NFQ2tORXRKRkJteXUydFd3SjIzV0NEc1gwMlUwU1Bv?=
 =?utf-8?B?NlpnRWpTYkpNTUhyME5IMnZUbVdINnFkSSsvVTYwaHVNMjVCY1Y3Qml2ZnR0?=
 =?utf-8?B?eTRBRmZyQXR0UG51VDZySWVXQ3FvV2xNNnpYVFZmUkJFTy9mN0MxY1BNMzk5?=
 =?utf-8?B?bjk2R21McENpUlo3TkIxZW0wd0NpblpiNEtnS2NmcEU5YnY3b0I5T2hNK0k1?=
 =?utf-8?B?YVhOTENreXVYZGg0UHB0K1NGZFJHMTEySmc4Y1ZyelhCcmxJMnZjSnd3ODkx?=
 =?utf-8?B?aWlkWlRqRWNJcW1OVkxYRGIzQ2pSN2ZwTFBJYUd5RHQ4UWtaVlRrUnhuNlp5?=
 =?utf-8?B?dit5OXA4Y0dDU2E3V2xHQTQ4S1NLMkZzV0FOVzNhcjBScHVGeFdEVTB2dGxl?=
 =?utf-8?B?WE9BMHlLRHFKb2NGaWQ2WkY1RGtYRnJPZDVPVmhvMDNrb3hmZnZOY3I5TVRR?=
 =?utf-8?B?RjQvK25EeDRHV3hvSUp0OUs5SFhtblNNSVkrWUlVQUlOa2Y3QjZtdy9DQmE4?=
 =?utf-8?B?Y1lFLzVnZmVvNFRyVXord29jUjVjMVNpT0tNQlVrSm1PRVFHU09vOW9veVJw?=
 =?utf-8?B?TlJRek5xVC9GMjI1cDY0cDJHU043TWl2QTh5YzF2enQwNjZsRkxpL09yOVRM?=
 =?utf-8?B?ODVxMEFaZnlWcXY4dDhEVU93WFdVV2M5akYya3RFSEZlNzBodFdCRUQ0djlE?=
 =?utf-8?B?OFF4Q1J1OWszcDBsMm1xYnlqVTNLTEF1MElvYUhIVHhOOFBNamdUMi9pVS9l?=
 =?utf-8?B?M0RtZUpvWlNjdnd6cERFcDVCaWVBV1BHdUMxOVkyM204WmNJcjg0RlFHMTVx?=
 =?utf-8?Q?94D/fPNR0rEyeuQciZbEzc940M6xLWkLdh0+j11ymwnU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15E976A5EAFF5D4D9BEB61227D0E3D9A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d42b69-f4f8-4e86-f79c-08dab7406e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 10:54:18.5048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmFb8W2Xxi2b2T5FTHpmpGRxk/NtE5YnKvOBktEJ0SFyLmLanqEoikVC+aXFe0f+pJuP2Qgwe7SKhSsis1s7E1ngu1dl51+ydCR3ujMw/DvKQIuFWDTX3ISmyDwNa36b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7480
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEyOjIyICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiA+ICvCoMKgwqDCoMKg
wqAgcmV0dXJuIDA7DQo+ID4gK30NCj4gDQo+IERvIHlvdSByZWFsbHkgaGF2ZSBjYXJkcyB0aGF0
IGFyZSBwcm92aWRpbmcgSU8gcG9ydHM/IElmIG5vdCwgc2ltcGxpZnkNCj4gdGhpcyBhY2NvcmRp
bmdseS4NCg0KRGV2aWNlIGRvZXMgbm90IGhhdmUgSU8gcG9ydHMuIEkgd2lsbCByZW1vdmUgc3Vw
cG9ydCBpbiBjb2RlLg0KDQoNCj4gPiArwqDCoMKgwqDCoMKgIGlmIChudW1fdmVjdG9ycyA9PSA0
KQ0KPiANCj4gVGhpcyBjaGVjayBzaG91bGQgdGFrZSBjYXJlIG9mIGFsbCBwb3NzaWJsZSBNU0kg
Pj0gMiwgY29ycmVjdD8NCg0KSGFyZHdhcmUgc3VwcG9ydHMgMiBtb2RlczoNCjEuIE9uZSBpcnEg
dmVjdG9yIGZvciBhbGwgdGhlIGluc3RhbmNlcw0KMi4gbnRoIGlycSB2ZWN0b3IgZm9yIG50aCBp
bnN0YW5jZQ0KU29tZSBzdWJzeXN0ZW0gSUQgbGlrZSBQQ0lfU1VCREVWSUNFX0lEX01DSFBfUENJ
MVhYWFhfNHAgYW5kDQpQQ0lfU1VCREVWSUNFX0lEX01DSFBfUENJMTE0MTQgd2lsbCBmYWlsIGlu
IDJuZCBtb2RlIGlmIGFsbCB0aGUgNCBpcnEgdmVjdG9ycw0KYXJlIG5vdCBhc3NpZ25lZC4gVGhl
cmVmb3JlLCB0byByZWR1Y2UgY29tcGxleGl0eSwgc29mdHdhcmUgd2lsbCBoYW5kbGUgb25seSAx
DQpvciA0IGlycSB2ZWN0b3JzLiANCg0KPiA+ICvCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8
IG5yX3BvcnRzOyBpKyspIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
bnVtX3ZlY3RvcnMgPT0gNCkNCj4gDQo+IERpdHRvLg0KDQpIYXJkd2FyZSBzdXBwb3J0cyAyIG1v
ZGVzOg0KMS4gT25lIGlycSB2ZWN0b3IgZm9yIGFsbCB0aGUgaW5zdGFuY2VzDQoyLiBudGggaXJx
IHZlY3RvciBmb3IgbnRoIGluc3RhbmNlDQpTb21lIHN1YnN5c3RlbSBJRCBsaWtlIFBDSV9TVUJE
RVZJQ0VfSURfTUNIUF9QQ0kxWFhYWF80cCBhbmQNClBDSV9TVUJERVZJQ0VfSURfTUNIUF9QQ0kx
MTQxNCB3aWxsIGZhaWwgaW4gMm5kIG1vZGUgaWYgYWxsIHRoZSA0IGlycSB2ZWN0b3JzDQphcmUg
bm90IGFzc2lnbmVkLiBUaGVyZWZvcmUsIHRvIHJlZHVjZSBjb21wbGV4aXR5LCBzb2Z0d2FyZSB3
aWxsIGhhbmRsZSBvbmx5IDENCm9yIDQgaXJxIHZlY3RvcnMuIA0KDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLmZsYWdzwqDCoMKgwqDCoMKgwqDCoMKgID0gVUFSVF9DQVBfRklG
TywNCj4gPiArwqDCoMKgwqDCoMKgIH0sDQo+IA0KPiBDYW4geW91IGFzc2lnbiB0aGlzIGluIC0+
c2V0dXAoKSBvciBzbyBpbnN0ZWFkIG9mIGFkZGluZyBhIG5ldyBwb3J0IHR5cGU/DQoNCk9rYXks
IEkgd2lsbCBhc3NpZ24gaW4gcGNpMXh4eHhfc2V0dXAgQVBJLg0KDQoNClRoYW5rcyBBbmR5IGZv
ciB0aGUgcmV2aWV3LiBHb2luZyBmb3J3YXJkLCBJIHdpbGwgYmUgYWRkcmVzc2luZyB0aGUgY29t
bWVudHMgKGlmDQphbnkpLg0KDQpUaGFua3MsDQpUaGFydW4gS3VtYXIgUA0K
