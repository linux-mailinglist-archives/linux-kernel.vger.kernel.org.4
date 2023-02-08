Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533BA68E874
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBHGnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBHGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:43:43 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4152AB1;
        Tue,  7 Feb 2023 22:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675838622; x=1707374622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qU+voaAtGDKw2ea/dTzITTJFnJcDTn3fGadxkIdZR+U=;
  b=NZb1Xg4OwaG6y5WX3+Vdbs8lCxC6JY7ZBV9mvLPevqy+tc/0XdJXjUUU
   zrVv8R8WSneMVC1jb3rSfyoE8NEubZa1cHy07JWk3cu3KIBbde7t5p9NB
   n/mV2hKk7QWiQ1wwNHGZJqM9k6i0o9b4ntZKpmuQQTt4WOsnmABe7n9oF
   XCpBPueFMj9RjhJWuCzEi7HTyV+F0RJXnfyYp+15ZF/6yvfyos7KKZs6L
   J+/0g4FFL+2seQM3eF3971kufYQKNL/Gx+CUtdX9wQxqJpJV8GkcdJCUY
   UylSIF9hGh8L1pxNX+RLVhOEXjpb5lBwEZC1kb9HKVxYbZQwvSceZpkGc
   w==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669100400"; 
   d="scan'208";a="195877118"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2023 23:43:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 23:43:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 7 Feb 2023 23:43:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSDCl9+j3FWYEZHskSPLQku4m96TamJdECjeAUExSmZcOBnVvGfpkhtNciGSf6L8pDX9Y9F83WW5kgZ0QevfxGzd0r6tPtT9BZjwpDtX0y/patbJvEAuoe1EbXP3TF7krodUPgxew6/ET3oB2Y2DQPSp5B9eFOrth0+bsF0VG0HGZCpZcEiihNjIkNoIBaqOyDwuovsbDj4YcSMiKjn0lnl9Ihee0bvKeB+8FWJAKICQT1Xcg4pAX50dReW21h/wRhrFnno3HlG3cPm/+L7c+rT7QvlvTmn8JBo7pz5IWcyfm8un8NHJQ50V7+9I6Jf5arPWRtWPJ16v75+jwTiRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU+voaAtGDKw2ea/dTzITTJFnJcDTn3fGadxkIdZR+U=;
 b=Ck6ncZj0t9A/ACsVRZqMWj0h4LWgRMmLv2EaTlG99h74QsuhYCNq3+4RsUhTgNEQ3yTaaCZquYOBlBZuy312jbTHpp5cYVVnXaKJcZGSBnN9okiL398MK9srh+0detc3I+oLk9vWVxHAwEvSsfU6N6wfeIaGvrLp+CHBIV3EPzn5BCEJAUOkLUNvDtsCdxgBWMUgpkz9uImXVOCBtzDvr/LFCIAuuAE8XcL5hi9Rgby0FEDxHJFFnH8Y2hvf6YyfZ/fTp3Qr2k0zMhiDgRAQa0930ggQFqnLiBvCkleRIf2v8/wcufdW30oDILzKOuF69rShNE9fQxKWmSkBPmNhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU+voaAtGDKw2ea/dTzITTJFnJcDTn3fGadxkIdZR+U=;
 b=jFh41sPDEeWV3GeL2RtDrtWm0NqQshu9xDgMXCRc/i4yp7jSwhiV8pCmzk9543nQqvPa8/qloYBi65SZLykM+k/1r9Wlc39y+fkte/9Kv6OTQIVzYVOkfpE/SE4bc/AgUw88yffwpJwIqOfBoY0gJSiMoOZMuEWqMHAGhCTsJ5I=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Wed, 8 Feb
 2023 06:43:38 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%4]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 06:43:37 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <michael@walle.cc>, <gregkh@linuxfoundation.org>
CC:     <Kumaravel.Thiagarajan@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <arnd@arndb.de>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
Subject: RE: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZKXdRTqU9jy+mxk+hberHdhxKbq6nKH0AgBqbxPCAAAdBgIAAekcAgAAN2oCAAU5MAIABG0Bg
Date:   Wed, 8 Feb 2023 06:43:37 +0000
Message-ID: <PH7PR11MB5958AF04A8381219061E65949BD89@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <Y+E9iRWyxqOjO4UX@kroah.com>
 <20230207134526.2465045-1-michael@walle.cc>
In-Reply-To: <20230207134526.2465045-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|SN7PR11MB8027:EE_
x-ms-office365-filtering-correlation-id: 91e3fb58-5639-4508-2def-08db099fced0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5brwFh4cAaMpIS1ojt9f7J3bPJFUx98J9OE2Ha6U3z6HExCGcM4YFZYT1cMPGNfduFh/abQFggOealLfYg/a03YykdaznLf4AIfEsJnlZi33ajvrMeNvxk1vF7tFRDh0kjHcHKrJ7ErH9KHQ9fXbC04+lGVVUwsXEQ8QAFrDYeO/fY6NExoZjdsOFt7mTpfMyClxipkNyP/o80NO3JgykkKhS6YXMeXKINqp2RoCgW1qWPrqc81r9J/gxdIjoltq5K8cY/DApHk+l5s9JYeMsl4AfCtPJfK+Js6P8B782Xl/TIvYxw5STlUu7FSNB0xqEqM/HWuCR1/KHUkI7NDRN9t+iQGvTiQ8Rr92AFRc8aDAG+5VXPRTz5kwENKlkQAdCvctFoqYDnTPsEutrv+X6yxFOwAqzdSbZMezwWZA/4XncLyOEYjNvk6PlqCgqrIgu6Yf3i4iwU9+Pa43WJBMQlWOCDsGwP6/9zr3hNjnQy0xFVUmYDwfJdEjmejNPNkpmZLjq+tDCV1gcPuDVavNuIiusSE8C4zGHAT8uP/yuTyqufvvhwllKyCDp1BHsqagtocnoNG3rQZgbupqjF+IXmYs+u+hndSuYNPPJV4LqQo0yQcURLP7oWlZE9XHLRLzj8TWwrlxXsn/s8AWnz1w4akJei8PjGh98BAmQQcISrB3nWhYoC4Pj8OhFn3Fdg6gpzu0DgSOj5L9nBRoSKxJpqKh5T+lNU0AIHl57xoFSQz6uTD5TpGcnRKakVmM9naA/RkZMIpbxo4soxGspQDmmTNdu+w20Mpwz884RMBs+Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(86362001)(122000001)(38100700002)(71200400001)(66446008)(2906002)(55016003)(4744005)(38070700005)(66476007)(110136005)(54906003)(478600001)(4326008)(33656002)(66946007)(52536014)(41300700001)(76116006)(7696005)(8936002)(5660300002)(66556008)(316002)(9686003)(64756008)(8676002)(53546011)(186003)(6506007)(26005)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YY3BxshxK4E4H/Qk+RLx9qD96q3gm0/333YHXwsubXg4zb9LMirXT1aEkgIy?=
 =?us-ascii?Q?oFRpl6yWuhBr2czY/1aR+it7zrIVUw+tHh8l7kvgPLcCTLf5AUWs2jwrYl2t?=
 =?us-ascii?Q?zNDPOvVOizFphCSo8KrtwCk1XHE8y1u/wNLollgJMlB4HVGzVsOSLNQ1SIba?=
 =?us-ascii?Q?10uf3ARYZoyWONg/jwAQIGgPQV52KcY7CezWWoXdx+FLmXHCBv9apQcLA9YX?=
 =?us-ascii?Q?iNdu32zWasFk5K6Z9EvUTuBczNLrs48WcupGA+9I5mArnl6lFXT95466L8Fh?=
 =?us-ascii?Q?aae80iVq9xBV52tTHKTPDId+BTCeHJKNgHwvHwdJZqBxLQwAYrX9d3ehVpUZ?=
 =?us-ascii?Q?3gaQfUS03aF3G4i/+ndlvW2dqFJ3v+MhggtVJuQ+4FTCNr5UpTHMNj37VPAp?=
 =?us-ascii?Q?P9ljHFPuLplYI6KLnJOo8Tkoj40soc/uOvDBTSznoCqYckO0vpmxH/2GAupl?=
 =?us-ascii?Q?+lFTNVwnmdbSR40OldhrfoIsLPq9eraIsGlPOY4u0RI0yWECEa94zCyNzJ+s?=
 =?us-ascii?Q?NLs1mjhSSidUAVoTMMMoNfHJlu9Arh7X1fdAX9CIjST2NuCI2XD17WLsEVlV?=
 =?us-ascii?Q?v0f0u6f6a9+9OMnbMUKB3KQeSu7L+gJcCUBieR8PTpmQpA/VcKr8lbI8vfaB?=
 =?us-ascii?Q?0SZyUa9YzyD56INH37ZxeD1QQI459KBHFlu9i3Hl5A5sNdn/D7AfGFri02hb?=
 =?us-ascii?Q?4sj0flYNHMV1X4xkVXT6pxWe68RuW39mrcroKSZfz9CGh4tLzJ9MU+pW2bov?=
 =?us-ascii?Q?udsA25ZY+4Vi52t4TzByZYvx6zXKNKOQL37MU3hS2h025YFYaDPXOXTESrQQ?=
 =?us-ascii?Q?fZh77GLfN2QunMV8qCP3MpA9zi/o+a8q0e7eBDsLdoub+acSxKvZFrqW69Gv?=
 =?us-ascii?Q?kFLGv5+2TP3XI1/Ohsv24d1qAaaXsRg5bHI3MyisggUdnl/84VcH5+vaMpsr?=
 =?us-ascii?Q?IgVYvxJozMtbTR2dqVsRTmFEjKKD1yZ5Dg1jpL3nhHB14qsZ/tL05SblmdUg?=
 =?us-ascii?Q?iexOhH8iaDvXC/2KBvwQQjKaxI2tb2FGIQzfNxj31ZZBj7dtcp2cN6qedaDz?=
 =?us-ascii?Q?srpqlUOTicpn+CHYST3X8AtTLLF5S7aQAZOwVaJFG5ktMEoM18fbFDV+v2Rz?=
 =?us-ascii?Q?gSfWRwxukMORylZPpTvAXyt4dbXc6vLaifmsni+yMU+w5PyUm52khgsaFi75?=
 =?us-ascii?Q?+ihjnKzGJCABiiDIHpVGBpBwml0AwVBPfGBISzS+q2siRBiHgeNLqz6Y7moz?=
 =?us-ascii?Q?qijw92FkYiiR9ehof4jld6btuHxrXDOLsurDMmNWFVh0PEJ4iyCswmy3wgE1?=
 =?us-ascii?Q?RL4D+HzyVbEZ6rcpi8QJriySOtu1XRfguC5NtO0fFRyQWV84H3b3aWILvBCH?=
 =?us-ascii?Q?jJBq46Aje3pURweQHmGxhaOZDM3Go1TaN+J4CGzTejcokn6Sqta/Vfzbj67h?=
 =?us-ascii?Q?7qDJs4o77NxDHwZ+y55c1bC2bz5IiOMiC209sJkrmlRVf/AId1PsUWtBV85y?=
 =?us-ascii?Q?spsl19azO+lYoK26ZTHQ779umcu+GGW6GDGoYsYl5uF0pc6P9DhDx1zwjAVk?=
 =?us-ascii?Q?IsLcmcRqGU2HbEVMNuy2xwxCqMo5wGScKQ3UmCm75LCz43aUbuCg9bBhe8b7?=
 =?us-ascii?Q?yJT29zgMIEdK7bmyW56HLwI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e3fb58-5639-4508-2def-08db099fced0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 06:43:37.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeNXpe+Alsxj5I6GO+NV4EFwRDA+AZrJnRnJZCmD9Apd47KUSUJ4+KkA4Je7rgvfXvz9/QFiigDM1SWSLljjf1YTNvn4j0JsmmZBvAputJPg8gVjLorTPYF26y62ZSfc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8027
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, February 7, 2023 7:15 PM
> To: gregkh@linuxfoundation.org
> Subject: Re: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
> OTP/EEPROM driver for the pci1xxxx switch
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe=20
> Yeah that sounds strange. What is the reason to not wait "beyond that"?
>=20
> Reading that paragraph above, it looks like you should have a look at
> linux/iopoll.h.

Thanks for your inputs, Michael. I will use 'read_poll_timeout' function in=
 linux/iopoll.h.

Thanks,
Tharun Kumar P
