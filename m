Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8868D465
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjBGKgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjBGKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:36:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A424C9F;
        Tue,  7 Feb 2023 02:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675766135; x=1707302135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AW4MssJMU/6v2Wciisbv4Zb6VxTgc2u7dIOmftiRQpY=;
  b=An5hlEEbG6CEMpyTmJFlduqMt6+gwcTw8uvY09zuCC1QtdMS+559RTRs
   chaI9z1Pm7wVeEsOlyyD9H5cHg7EBSC21n3sCKsb8V7g5eLzYFVzxHpkX
   qD/TwJLlq+s8D3yIIRoKQUdKTHnyPKT1CddyceWMF+RBsmQD10kxkhdS3
   rY7w1GO2hJ6I+5r0AdpaeNfzYm6cNByKZM5lshlu9ecLmHhbu//LUZpF1
   +2dT2P4qvwK+kzr0FvB7c60EGc7qKSJf9XGFzQMzh5RGGOmtyuSuIP+Xc
   k1GnnDRvyoLiQfjFuMDQMo/37Pfl8ks428wL/n3hTRVXHbsnsmTrViBu6
   w==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669100400"; 
   d="scan'208";a="135924393"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2023 03:34:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 03:34:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 03:34:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW0aukum3wTd3DXfrTNowQsCmzLpwsKt0KAowP3ySZnRK7bhkEuKvLBwHi900ejz4k01kYHVdPWixWx8TqjejKWV+orR/xXXffqQQo7ddnVtot9RchyMscgS1ZfZF/odmfI3xnGd+Cyo0MeOSZlW+GOggX6ZtfNcEMkdlnHZmy1eM1vsdLOIIkrlUIvLWoqNP2wfAiNp7UaUhk1wHaQRH8cN/vIlFMGhW9cVMbE5dXP6yYdO3QY6f34/G9Cx32+CNijFFGR1pU5SMgg+cx3Co4MgEpunbggnuMPTJpAhMclhTXJFGNFDSa9j5oHmjvOj8cYvsmh6RrvT4i/Zop11dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW4MssJMU/6v2Wciisbv4Zb6VxTgc2u7dIOmftiRQpY=;
 b=L/wNCAbppowT4iD/ngAt0LhmooOPyUViV/bTAp6M316qDrGhVJMd8MDy5B9mroHne0qx9xP+afAvsgx12NLzl5dBWNl7pV8+Gj3TCB2zcSNbHW1PUFyjnV5R1JMPbUzQBvbW+8+ODIU3FaAL3gbshpjBGd721aFd/6Hp2b2ZF7pq2I/rURGZJgw6N8Wq6rudB0zw2SqIbQonqRXEcC2FY8eWspGfW5QmYdUDsV6FgkrYoX4G4uyniTIK2iurkG/dyaZUzlPIlvNoOqGyiXWReJrmoj93KrcmmlgSNDLy+Dvqt3CN/3GtAEf8NZcNWVfxXKruI7L5Td4FBK3rLS77Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW4MssJMU/6v2Wciisbv4Zb6VxTgc2u7dIOmftiRQpY=;
 b=NOBbiUNZBqxv1672/NuWS24ffLGlKCuPZKqxJeZdDDIn3wkvdBgvDyaeEyRK5AI8bSb7FnhWwVqqWO6YUeRxEs5dl3wct8iRF7w6FvySam1cxUTnWylSOigD5exKciGvK0fzzRu4KEGCNWPI8eQd9xNLbAfYBVVCD0IhdMXBd8E=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 10:34:48 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 10:34:47 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <Kumaravel.Thiagarajan@microchip.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <lkp@intel.com>
Subject: RE: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZKXdRTqU9jy+mxk+hberHdhxKbq6nKH0AgBqbxPCAAAdBgIAAekcAgAAN2oCAAQuHUIAADHhQ
Date:   Tue, 7 Feb 2023 10:34:47 +0000
Message-ID: <PH7PR11MB5958A5B33798411DE2EBC90E9BDB9@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20230116192908.2980862-1-kumaravel.thiagarajan@microchip.com>
 <Y8pzIgeMyf2oNCn4@kroah.com>
 <PH7PR11MB59587A0639FE44245A68312B9BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y+DLVwfOjEKYJpyB@kroah.com>
 <PH7PR11MB59589EE1C7787496316C04339BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y+E9iRWyxqOjO4UX@kroah.com>
 <PH7PR11MB5958A72A7165DF1EF28724709BDB9@PH7PR11MB5958.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB5958A72A7165DF1EF28724709BDB9@PH7PR11MB5958.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|CY5PR11MB6343:EE_
x-ms-office365-filtering-correlation-id: 3c687eeb-244d-405f-d8e9-08db08f6ef3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1lt12VsyexTqO4TAAmgyMh/3qTOp8LQ21B7BTRzGxKS5VntyGlPmOG1mxRkT8j+k7zW6G3ZJFCin5ZzQoesrabsJJ7ORNxlYLfCdRSJNO/uVstSM38bwqYgiTFd5OpU4INLdFmLlbkeSIClasTUEJZk1mMYbZsujzM+0u7iOMBlGBWJAHZm0cxdvA+N1nKUwMU2W/ELZmWr3a+9VG0EFCv0P7zUFirV0gFQoXqBn2FCMcR2xYDF7bOmGQTcCgFuTeuZW/ig/T1lroyVEhQhwO6z5EkDQgMcKA/ijYHOslikMrNpbCppMput5Qzlhn+wCV1mqaTAqyz2jGExsZh989ccw4nW2lKIggeHZVk74XhN/Idke+itOum5BT0DzgdMgkhj+GXcaIXgbDOmCEF5+mGI2cX/H02y1yS6IL25+ZmEDzgh6S7iONWeD5lT64kXi/EwkCF+llPDPF1rHSgBTOwx3UcF3GcQEQP9H0HR/LCG+n/7ApEjBcJuOQJAPKONkBf4NaMOHGlti7VWJVsWjGXfKjVvfZWqJD1lfXzcdEsu5xkTPUjXEehUJ4rm4xfl8JRJKyHx+71921+P9XCwJIpId8RC/IbFhFCFrdmD0m8mPTyNGnc33vOvkL9UF0zAVt5tq1ODnFaI66UIEDFsTF0kyM9RNfPUfhXU9UWEj+EHq5Kq/CKd1fiX4aXhxrH2hpgnOEOGxt5ECTFzgwSyTmZ0ZsJo9iLrTt7fr48D649frR4hyn7IDM2lYuWe6rTLPn8bpQdEaAg0jYkI7zfJhOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199018)(33656002)(38070700005)(122000001)(86362001)(52536014)(4326008)(66446008)(41300700001)(66476007)(6916009)(8936002)(66556008)(64756008)(54906003)(66946007)(76116006)(316002)(38100700002)(8676002)(5660300002)(4744005)(71200400001)(55016003)(478600001)(7696005)(26005)(9686003)(186003)(6506007)(2940100002)(53546011)(2906002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?in3ZFobfcyX7wDg09U3MmGMkhY6YZYRkUeCaxqjsdsFX69YAK7Dyzhiu4Bve?=
 =?us-ascii?Q?nrw6ieH8j19DKMDglHfrRdwVenzMw9E85wIq/c9F+AM1r5DCuAFuNYWMxKXx?=
 =?us-ascii?Q?We+7JeNyGZTfQXlpL59TU05yrwc6PW47f06D7WZf7z+5pL8y+NrKjkhimCW3?=
 =?us-ascii?Q?dIQpP12YQUL/7oyh27hbl2OndBzslgASiH/jy+UemxDvgksI1QyMvfIuGG2q?=
 =?us-ascii?Q?jh2xpzsjV47hTxPBU8fbEy7WGTNBzcCx8b8B8iLFNkbCx7rflnUGxHFpMZwU?=
 =?us-ascii?Q?XU/cs3O8dxOrs6CCa6vpIfV3SLeQ1A02CgcZycSgJYb/eBmJjf8RDzuWmpmz?=
 =?us-ascii?Q?rBG7XDQcaLzxK9Ih+TrGuZKCvEyfDSklbiwMW2VkNxHr3GXEZb6x8iZJtEe9?=
 =?us-ascii?Q?3WCbmUt635w0HkoD7ImRKU1wUmjc/iFuHIuqe4Kcqn4593AH/Ov/OTDN8sil?=
 =?us-ascii?Q?i/5lZjDh1R0KKxyd40Zl0+5LUnqfBfSMfNZ9IEDUh9Zv6XcAupYU7sPWVajF?=
 =?us-ascii?Q?a0t4avtK8lFVxhnTyCwVRpPBXVth6URhjPC0M8TP15msTss92wf8e8Q/v5lN?=
 =?us-ascii?Q?pVPAZV6pmRFPFYGWImJr20O9tApJcvEL7dgNb/cafM45zrVwZ+qN1YjIFCzJ?=
 =?us-ascii?Q?OGQ7ZdnjXUbvVRYP94hRz13l76dXxTYTchIClWTQu9+YPx4p89cQlm6kI8RZ?=
 =?us-ascii?Q?es9TtDRaQNT2UxOn/dlIS1Hb7Nowitrrfkk2jcMFM5NEbz7IN5et82M/ZVvn?=
 =?us-ascii?Q?sjGHrPogCKNWwkDoozQsF5ESGgECChgj3DOFbj7Sw8KDV8Rv175LVDQgOs1C?=
 =?us-ascii?Q?tGWEIGoWeYXEyhvbzRkTQGYf1yaywsImHZs4NyyG1FWdtre1ngrrrtjYheQ7?=
 =?us-ascii?Q?uIDdet6lcgJ9g7AVQdXcIQjWPYp6Mxseg+FMqzQWJKiO6tSOBcYbDkw/0t21?=
 =?us-ascii?Q?Mf9b+ByO/JpG2D7Q6OdariOZpamPvrOh+g0JJ6U4zdEwe6JFjmIOL7XyBPmu?=
 =?us-ascii?Q?YBQFvZLRP0AswJBfpW5uHnCqr2oLy0trAMVA1HcxK1yO+axbF2IbgqredXEW?=
 =?us-ascii?Q?OAaj+dN6kQDv52H8dt+Dj0J004sU/P79j7HrHezQIDmSwezMTyzupEquTELa?=
 =?us-ascii?Q?5uhLFEwmZtQRL8JMfVLYXeTVkg7CuD5HnjLLCkvAlO+Ks/Jtb90r7QydgPuV?=
 =?us-ascii?Q?MnO8w8ddrH0GAfG/4xdMFddrN20xdCC98CyNO/iR3smVzqF9uaBZ/fnb9j5M?=
 =?us-ascii?Q?eBAIH/AajDrXZiIM5CXxS1y+x5knXy5e/OXvRzUePGVHinyqe+EXmy/imoWX?=
 =?us-ascii?Q?YMUlWBRSsCMoMWXAwxFp1ZmwlEKn7ur+TjNNr1uQKD15VXY9+Y3Yn8o/iIGj?=
 =?us-ascii?Q?bHzbw+KbzhV7xWLiBSG58fbX0C9DTtLXFBXBOCUcNscip021oTUefLhjVj8e?=
 =?us-ascii?Q?yQ1bAK2vVIYUHHlfHesKPJTsKqScqlT+gMtZEZK3tbp2OwMDwGdJ5xC1WqgF?=
 =?us-ascii?Q?gu4MZJDy+Q9V1Q7Ybe2EJFM536mbH3qBC6AoEBFvzqmEBWQ1PMrqUS15MeJW?=
 =?us-ascii?Q?RhFEFM0QYQN0QTNKBYCkBxbCJN/5sk4NEPNyPIY55+1u4IxJ6T5allQ8brPo?=
 =?us-ascii?Q?fay99+swm4QxY9OZQlK8nWc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c687eeb-244d-405f-d8e9-08db08f6ef3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 10:34:47.1242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPkhJlOqtG3YANbmyxV21hDadlMROsEdgyaCA+gsy1PUWa6TVyjcK67XhtamOxCJ5SgGiBe1Q3hjW2mo4XGWI+96iuKZ+F1cI6KIm0lRKeD/dgG3exmnpQzZsIrpYIj+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Tharunkumar Pasumarthi - I67821
> Sent: Tuesday, February 7, 2023 3:22 PM
> To: Greg KH <gregkh@linuxfoundation.org>
> Subject: RE: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
> OTP/EEPROM driver for the pci1xxxx switch
>=20
> >
> > I have no context here as to what the code actually looked like
> > anymore, so I do not know what is going on anymore, sorry.
>=20
> Greg, I addressed all the comments received for V2 version of the patch
> (except for the one in discussion).
> Shall I send V3 patch so that you will be able to get back previous conte=
xt?

Sorry, I meant to ask if I could send V4 patch (not V3) addressing V3 comme=
nts.

Thanks,
Tharun Kumar P
