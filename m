Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF22E5F5212
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJEJvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJEJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:51:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDFC2B26C;
        Wed,  5 Oct 2022 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664963497; x=1696499497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=55o153F2oIWQVHIxDZSidYwEApJpglMmUGd9EEjAqLA=;
  b=KZHqR6kua9M9CIOe87ow/1uIl+x829lg/yFij0EQ80Kial19O7r//9zL
   xfUqkbJ+Dkw8KfGTsrkaC24l8Illr57Gc81D+JZbDAs5k6Fw16Z5fyt/N
   BQKDcOj8NmX3IvSz3QXouofqLVqvZC/srwjtw3I3CkdLR2LsqIzuIFBlj
   nIF2O8bE/khtixGV4wJvFHXdU8uTVdkQ3ISRuUM+EU2/lKwNH2YOPwjdy
   ycO2jgUcfHmXIi8A2NepGif57NtLXgdQlC1LjkIgsKP/tsBlZ9oFZaFQ3
   c0u/J/IcGwnTuzAyyqzglUL6fVjWZOyQyAwfkBnHx23TGHH7wL+GUX6KQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="177118175"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2022 02:51:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 5 Oct 2022 02:51:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 5 Oct 2022 02:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpPkcNSiienDKTUoxiQGBt8l4MjfRK0XiEfE0hT+sCnqEwmBuP+VhqU5QwhDndXXtd+OO5WalxTn+7jOjaV/uUZl5bXf146kk8HPiTCZN9bGMRz4Tjqlez07iPjl9DZympMM5MdoZdk1kP5eZIE2caF32tt+TPcCFE8bL2dJhSkrGF4twy/vF8tDZGr6tCKiQS2KM5G40Oq6RzIDNG6u+t7Kj5En/aleDv2fwObMyeBvDa7gR7VDI2fsg278bPdus/nUFyCoB5qFcEas0TNgBlPRnIfr+O2o5PYNH1rDjhilRkeKVGOIAf27pbS4uxUTtqTkvzP5qkfWQR4HJsxzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55o153F2oIWQVHIxDZSidYwEApJpglMmUGd9EEjAqLA=;
 b=LsnZiOgPgTOAIZmhwf4ZeLEUew99H3qWHieBRkui54l3GyavJNTUhqhRU7HX9Sla35R7cbeb515HjRJ8DzaKYNj33e+GCq0SwkL9Zs1yDcDRLkSlBy7oGhbGgJ4/YUzwcD95OdPC45/G4xgaybJpfo+9DeFomLqNsrstZTJFNb4hqtBgy7/QUT2anaIcrxu2V8NxFGlzokIeG2v4Q4OzzT8S79T7jPUV1sDtakcfCViPiyHKrGFqX8bPQlxixqJXfgqEFkQJ/bRESooZA/rxkXO01faVynEeXY0V/jT9qPOhJjpzsZDv325s6efcE5NDg5hO9YEdnxjsFtbnfrXaWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55o153F2oIWQVHIxDZSidYwEApJpglMmUGd9EEjAqLA=;
 b=Z0hOiA6pj2sNkuPDJeIV0HcowA15gE4OwaxFWdKPb6a3c4IQhiSWsnzVEOUOunqczJrZKi4riV6Hfkvc8NWS0cHWnRFD3ZEaXOUZ0gr9CMOA+iBs+9EiTg5umI6iwVcHOocQ1B7zF0p+UaEtlsIV996yFi2cycP9wYzypCYYkt0=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by CO1PR11MB4817.namprd11.prod.outlook.com (2603:10b6:303:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 09:51:29 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::6c5b:82e0:522d:6a2c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::6c5b:82e0:522d:6a2c%7]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 09:51:29 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <andy.shevchenko@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
Thread-Topic: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Thread-Index: AQHY1V1Eyoyo00S86kajlcGzY3FsyK38aLWAgAMNG5A=
Date:   Wed, 5 Oct 2022 09:51:29 +0000
Message-ID: <BN8PR11MB366807651BEA460207469F8DE95D9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
 <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com>
In-Reply-To: <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|CO1PR11MB4817:EE_
x-ms-office365-filtering-correlation-id: 7ac96ace-ade6-4515-033c-08daa6b72d14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nhUbTeJof3TkkFIhy/3Llypu101qWhdQmGuxeDqrXCt+qxZQaDK3AT6RYG7wV27eQb3gFhE8GQyCf/3p63d1WVGzzXQWdoJ1bjaNu/wkW5fWy9yiw3gmU9c2gmeR3+eC4CNsoHgubBJGV3b2O2cn3Q8vgew67cZhey32oiTSq8lfaLC+HMLGvl2uph+OA1NEkqHjygIm9BTEI5ETFhX3ip+820yJxKPv5muXzsZMf0ZiB2ZzO+2rQ6pKKLg/eLj66H8Fg0TN8oSJXzjwYJ92OUdbMtejC4DXZkCI2kPKYYW2FxA8qZiHsc96z07guIUL/0cel+dcOU46j8JeeML4rbM1lcBMoYeE74JRGG9oxYzCjmoeEUAjXeed2xavju4QIfBbtXEwO8DOUUTVhfeRi+PqT4cJ057QeqwBQ/RKPkZw0vM4b39qtxw3+x5Tq2Wg4q4gMwYeDm+FaKxOn3Q0rgODxIi0K54fjmKBUx1itKtk351EEn2DYGPB7MQaQp/RG7yW5jV+Fp2UJoHLcT2IxT41IYe5qzy4nNcVGTsqC0FxG1sHBgw342nDJHhN9x60HdIv0ulsMiu3mkL8R8pi/4jBjgQHh7oYju3/uTP8cX3OEfmdXQoHcNluHxYQ4GE8t7sna/kJoLnvFtayaBCHCobruOxLac23+iLjDzvGo8mzGqzsr4leEGqkhxZnoC80U/CbqCw6+nSjyI4cwb4A6seSWr4E2cbuJ596nBV5IN4geY6E2gl+IKe/Hw5s6n8efV/hFyn9V5Rjolww+PxkRk40tS7EeTBFRUzz61hiy5QRwz/k72Epg4Hd8tXaGzua7iboMOZkbJwCJLTgEiEfGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(33656002)(86362001)(55016003)(38070700005)(38100700002)(122000001)(83380400001)(186003)(6506007)(9686003)(55236004)(53546011)(107886003)(7696005)(478600001)(26005)(71200400001)(54906003)(6916009)(316002)(76116006)(66946007)(66446008)(64756008)(8676002)(4326008)(66476007)(66556008)(41300700001)(8936002)(5660300002)(52536014)(4744005)(7416002)(2906002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TCtWSzRuZkhkUXZHWUp6aW5KSWRuM0tmNzR4ZWhaTFBSMDVsaEFLV29qT0Nz?=
 =?utf-8?B?Snl3MFl2NVYydS9RM3NIbzh2R2dVaTlnUUEya1huQVlnR3RWVUJRK3RuZXpt?=
 =?utf-8?B?NGU5VlI1Q0dyVzFvRG11VWRJTk03MUxzZG13UTJIcUd5aGVoa3doYU8xM04y?=
 =?utf-8?B?dGUyZ3dUQWNUcjdtckxPWUZSTFBacG1DdVh3VDJWRWhDdEh0d1pCYktLd1Vs?=
 =?utf-8?B?NkczY0JCL1VDNk9mMlNoQWNiQU5zR3BsM0lwbzRmVDhyUTVyR0xtVzdJT0g1?=
 =?utf-8?B?eUVOcFYzUFdNQjd3cXFDK0p5OE9rL1JNTHZVRmFUbEJWbnY5ZE9LRXJRSUdS?=
 =?utf-8?B?ZlFnaTgwRGRCOG5LQURwNU9VL2hGa1NzOU1vSmhkcCtVVnlzbUpyS2U2M0xw?=
 =?utf-8?B?YzRXMTRhKy9JOUNmamxHaEZNNVRNaFVoWitjc3ByUVAyL0RyaVNUcTU0Vko0?=
 =?utf-8?B?RVQvQVovUHY3N1V6Z1lDb0UzZGNockZWT1cxcjF5NmdXZzRPR1pZQnIvV2N1?=
 =?utf-8?B?KzlyczZ3RDdLOTBXU29wY3NGMUhBWHZKNWFKODh2K0EyM1Vjb0xWWHpXbnEx?=
 =?utf-8?B?VXJBMnc0WUZEZDI3d0xIazlWN1JON2k4K1Vmc2s0Q05QZEhMWXRtNk5vZlRV?=
 =?utf-8?B?NHZkR2JodXNQdGlSNzRwaE5GaDExSTJPL1JrTWJ2OCtNVGc3d2NiTEZiWlpj?=
 =?utf-8?B?TjQwdlZMWGJNVXJJbHVZQjdmR0tFbENpVmxrRENYWGE2Z2RxTWVHa1NucWdr?=
 =?utf-8?B?cjAwUXUzdWo5M254dVEweUdMc1RrSkxVSTlGTEtBQldYS05wVzZDVXo1ZmFL?=
 =?utf-8?B?V3doWkZjYkVwZktWeHdpMlVyOTJxNWY0ZnBTMkxrMHJJaTNXVm0zdTl5QTZ2?=
 =?utf-8?B?d2g1UHhvNW14N2lFaEdVeUJ0SGlNS2lmbXhoaHF5Wk1aL0t4bVRIZ0dkZDF5?=
 =?utf-8?B?MDh4dFFCbVhqenJPdm1MWDVDdjBlQXNtVU85S1p2Yy94eDdOVG1od0VuSCsr?=
 =?utf-8?B?aWFOMkd3OUJrMmY0K3RXZUpXaHRYRGZPTkRoSnJPM3REWFZGSmd5RmYzUG5o?=
 =?utf-8?B?VmVkOVBNRWlXYmdjQTFQdkJOaFhNQWh1YWgxSHRSTmo1Qk80L294dm5aU1JB?=
 =?utf-8?B?VGJldEFDM0JiMmx6YXBCNkowaFQ2cmJ0Z2RLRC82RENkd2pIWXlxblo3ZjQ4?=
 =?utf-8?B?K0VpelI3OXJCY1c2Z3VVY3pBeGtCVzZJcWlud0VHcmFyN3ZTQ0MrUloreThn?=
 =?utf-8?B?eGhzRG00RWZBUDI0UTV1Z0JwMkd4VHY2N2IvNHJramNkbTE2bGJyb0pwS1hP?=
 =?utf-8?B?dUlvU0JYajNZQnlOY2JBakdaQ0JZTzZEZ3ViQXd3MFh3bjdjcVhkZThzMkZB?=
 =?utf-8?B?eElaQjR5TmpQZ0p4RDd4c3RQV0NGNlQzdkFyQnhOUk5yS3FJMS8xQk5iRTdY?=
 =?utf-8?B?NWpORm5OWWhpNWJwTHZ0L1JaVVFGTUc3RmFydDdGWVp5UG01M0lvY2J1em5k?=
 =?utf-8?B?NDkvbFZkeTFuMHJReWdEWUFqbDdlWkVXR1ZkdWx2elFLRzlyZndJa0U0VkdE?=
 =?utf-8?B?eUt2b1hua0FMRUl6YWgwNU9TS0ROUjVOd1BaTWw2Sk1ITjB3Rm9XYlpWV3Bh?=
 =?utf-8?B?TXF4KzkreVZvNzd4NjBkZmYzV1lhKzZiYVBIc1k2TVhtVFk3eVBxVHBnWDA2?=
 =?utf-8?B?ZXQxdVdnZGNmNFU5QmxuQUJHTlViK3o3NUJ5RjZyTU55ZzJONERkNnhRTDNY?=
 =?utf-8?B?bW9Xa1JpVVhFV25lcy9kempZSzBZdXp3SFpvVkI2SDJCVDVOVDk0SUxES2xW?=
 =?utf-8?B?MUpYMWJLNDJmZXo3bUV2TC96Tm1oV3h5SGpmR1AwTEI2VkwwOFgyZXJQeS9G?=
 =?utf-8?B?QnZ3ZjJBMHZXeUp0clgwZXhEVHV0ekNBcmxIRnFrZlcvS1NEZncxdmt3WFph?=
 =?utf-8?B?K2hCNmRCMUM1QnBPQjZUZlR5Vy9LZldHbE9OYzJYYVoxOTdIVzVJQmFFbGtC?=
 =?utf-8?B?TXYwTjhLbEZZWCtFMXBaRjY2WUdXV3JNT2lYd2Q2TC9aeWc4M0hvTEMwZ0xx?=
 =?utf-8?B?OFM3TVlRdGVMRXdoOGFWWHh4dGxrZXQzVXFvNVF3d1VuRWRpSXJhYTMwNS9T?=
 =?utf-8?B?U0xqMHZXOWhLRjg3MjdaS3pxLzE5Y3RPaS9oN09VZm9mbXFFcG9FbDlBY3Bu?=
 =?utf-8?Q?qCqd4fGVD7JQSGNcqK0nUPI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac96ace-ade6-4515-033c-08daa6b72d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 09:51:29.1546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oF9X7CpHIDTycacD/9/x+Qjsc5VJ3vWBn2fnl5GfaB2h298a59I10B+G+ewfiy5JfxJPynCep9DDNuTcsOYeAYf9LCSjXLFEY7qwm4+uhJ7KEGZRHxkDXSz7yDBNzLDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4817
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAzLCAyMDIy
IDI6NTMgUE0NCj4gVG86IEt1bWFyYXZlbCBUaGlhZ2FyYWphbiAtIEkyMTQxNyA8S3VtYXJhdmVs
LlRoaWFnYXJhamFuQG1pY3JvY2hpcC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgdHR5
LW5leHQgMS8zXSA4MjUwOiBtaWNyb2NoaXA6IHBjaTF4eHh4OiBBZGQgZHJpdmVyIGZvcg0KPiBx
dWFkLXVhcnQgc3VwcG9ydC4NCj4gDQo+IE9uIFNhdCwgT2N0IDEsIDIwMjIgYXQgOToxNSBBTSBL
dW1hcmF2ZWwgVGhpYWdhcmFqYW4NCj4gPGt1bWFyYXZlbC50aGlhZ2FyYWphbkBtaWNyb2NoaXAu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IHBjaTF4eHh4IGlzIGEgUENJZSBzd2l0Y2ggd2l0aCBhIG11
bHRpLWZ1bmN0aW9uIGVuZHBvaW50IG9uIG9uZSBvZiBpdHMNCj4gPiBkb3duc3RyZWFtIHBvcnRz
LiBRdWFkLXVhcnQgaXMgb25lIG9mIHRoZSBmdW5jdGlvbnMgaW4gdGhlDQo+ID4gbXVsdGktZnVu
Y3Rpb24gZW5kcG9pbnQuIFRoaXMgZHJpdmVyIGxvYWRzIGZvciB0aGUgcXVhZC11YXJ0IGFuZA0K
PiA+IGVudW1lcmF0ZXMgc2luZ2xlIG9yIG11bHRpcGxlIGluc3RhbmNlcyBvZiB1YXJ0IGJhc2Vk
IG9uIHRoZSBQQ0llDQo+ID4gc3Vic3lzdGVtIGRldmljZSBJRC4NCj4gDQo+IFRoYW5rcyBmb3Ig
YW4gdXBkYXRlLCBteSBjb21tZW50cyBiZWxvdy4NClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4g
SSBoYXZlIHN0YXJ0ZWQgdG8gcmV2aWV3IG15IGNvZGUgYmFzZWQgb24geW91ciBjb21tZW50cyBh
bmQgd2lsbCBnZXQgYmFjayB0byB5b3Ugc29vbi4NCg0KVGhhbmsgWW91Lg0KDQpSZWdhcmRzLA0K
S3VtYXINCg==
