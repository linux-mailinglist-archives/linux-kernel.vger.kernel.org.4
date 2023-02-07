Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023C668D343
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjBGJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjBGJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:52:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B953D52E;
        Tue,  7 Feb 2023 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675763542; x=1707299542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=izaOz+baFOdDwilzFHiTdBH7NSXCN+qYssLZ6gOHtjQ=;
  b=N8g3WDQS5QNG/xRid3lnBc1c9kC+l8icGqrxt/9oYu0ddtl/DFLxfrnn
   9+l/g8e0s/8OYuHpAbPS62mkhtM2DAUTivkl8hIoQ1bjIdDL8fjRQ0u3F
   b9ArlBk92uS6jowqztrVe8ngjLV8Ds0tMIvQPnBNaB0zYBRX9Yb/9HNxz
   RHWCfAEy5yI3/dsrLUdPPUuBFiVuWRkAsi2Uz3g0bPqMnjZp9P68B+zou
   tWsnAtl/yzCSEm9yysMccJzkXyDx51qHJoFbJnqAamaEgFbTN75QWrOyr
   ZE1Snnfb0BidObbdEkqqAoFPWLHhpFoNyJjMfb7OU2kqYToT88TeNC8al
   w==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669100400"; 
   d="scan'208";a="199634492"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2023 02:52:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 02:52:21 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 7 Feb 2023 02:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARk0K6KAzqf+fMjekAiQgxAN1o7LGrFHYETTjreJ2ylBpnGyWDTjdh7MKAZRNx66Q3ZLYIqcOd4MDL+1ocJsFrpXTAvT43Nj2AP4PyLnRbGBMEucDc5C3oYowO6KU8fbalwS65rx8yHsjSYJwwigq9F7XJWytKvm6lA58T8eRfoXnVjEM2j0xv2ZlHQ2P4wbLM3IHkE2HDCfjtWRXQNjtYcgReH6B5i5NsFYV+3QfjoHZVZ1wkOqL2mAWx1PytggHwA4nFOkItqsJsBv/7OAkzMlu+1J1Ng7paP8+cujQ/pvY02KOWjq9kFJum7HuOXl2V1IbJWZg/JfnQy3clGVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izaOz+baFOdDwilzFHiTdBH7NSXCN+qYssLZ6gOHtjQ=;
 b=jeri8tigvswboWP2frJOAz08n1eoNQT1j7GSlMLUo3gGDULWwhEL4IjLOtosyYCTHrEToMQmleiOF/GXbeBuwlDYs6B80MVC6CyW2rP5zYNlAnbpMYVq1MdWasJjNWuwQ7+SFMx47sUb2jnQc7vgjhxSpqqBOhvE7rgyhXSlp3YLVC2FQZ6Kl9QN9UC/ZFRn3pLlxD7T2FUz8Yn3rgk2ZRoJ4x4pfQsqL/43w5Bm4N8ZHBhD+/tg9uPiZAry5PJuj8TbiSkZFqZOxE/adqlAzw8NqwSy/2J0/8XOdaksO6REej/OAbY9yEysYGL9D4RAf3QT04UyGS+wzOqO9NKPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izaOz+baFOdDwilzFHiTdBH7NSXCN+qYssLZ6gOHtjQ=;
 b=gxojX2Su6E69dQJE8ZoWkVwXY7AIp0l3RX6zRGeW4hWwuzBEDTNZHBrlmtpA+JqY9OtYAvn6W/YzSe7SqRNCwQU5zIOAKzT0pobk/J9SiQHC/rRJNFuE3QjBx1CiIhEVoG03zZtfzIrFKtWDjCQ46bwWAQHyxxX59aKTwy6NNRY=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 09:52:19 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 09:52:19 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <Kumaravel.Thiagarajan@microchip.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <lkp@intel.com>
Subject: RE: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZKXdRTqU9jy+mxk+hberHdhxKbq6nKH0AgBqbxPCAAAdBgIAAekcAgAAN2oCAAQuHUA==
Date:   Tue, 7 Feb 2023 09:52:18 +0000
Message-ID: <PH7PR11MB5958A72A7165DF1EF28724709BDB9@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20230116192908.2980862-1-kumaravel.thiagarajan@microchip.com>
 <Y8pzIgeMyf2oNCn4@kroah.com>
 <PH7PR11MB59587A0639FE44245A68312B9BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y+DLVwfOjEKYJpyB@kroah.com>
 <PH7PR11MB59589EE1C7787496316C04339BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y+E9iRWyxqOjO4UX@kroah.com>
In-Reply-To: <Y+E9iRWyxqOjO4UX@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|CY8PR11MB7748:EE_
x-ms-office365-filtering-correlation-id: 41831fd2-49a3-496d-3d7d-08db08f10059
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4PW8g0qP8wInYWe3XD38Ky0jV+Hix6GpqYB3RlXB0/fsxFLaCM0N1sKAnfYjaoRxcMPMeOUmABPkBSGn9GbwsXwXDikcLum90XVqfDYHav1vBbx8HeOoPXHqERC8D/KDnMqBADC3qStTs3Pw+BM182s5HFeOKG6Ycnt99Re9wJWPj/u1HNLoHYSmNjXMrKG0CPOGCIA1fdzwyXORUXstRuDatBrtnl3EIIAV9dMFOnfWfsV0RoAzlNzzzTIAEXzSrjY4Lku0pvX1YgABDt8lQu/tWX94cSV8t/cYnlrq89Bc32rXyuufaJL+VWn5fCzZyMzvMUcrmXXyAUPDSbbbgNpUgn0U1zR4jnRgNm7M4pvSwIwewGygs6bBdsOYcjnfA4GTIx7kyYAimL6hpBFaaPjSGLd4LsqG/Z1xqfraJkXT6SoGoEWSQPc3BBUp0nURo0kOW7TMLlXh83tE8jasmOEfUt20df+bkSzRlW1ZZsT6327V3plzeT+OJmg6DuEy351sSDgzSd3lMb5qV0O4tKfVwqN+NBi32/fp6Kjo2WbZR+KfLQIpS3j94EQ/UQGVuimEIRHrdDD4W27rhAm4ZED1akhpniZCmx7RiUUbS3seGPhELvXgKgWUtsGa3DIbVghsrAtnbX003APpjOoNmPVSTd7SmeLsRgNjCa7dKbeIemqiNB87VALQpbXvHGoeYVWA/AEVAhB9IQreBA6AfAOOABWuzlk/Be9NyBC+iR6vLTOeepJ7gu7uQ47NGLudFt415XJjzQJnHxOgxNaeNwlfTJxP4GDDTMMqM9HXaIk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199018)(26005)(9686003)(6506007)(53546011)(186003)(122000001)(38100700002)(38070700005)(54906003)(316002)(5660300002)(52536014)(55016003)(8936002)(41300700001)(2906002)(33656002)(4744005)(7696005)(71200400001)(76116006)(4326008)(66946007)(66446008)(64756008)(66556008)(66476007)(6916009)(86362001)(8676002)(478600001)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hMaDL0guuOWFX9SHfG9QjNSbUEO7CC6ZoiZJ3SWChctz0uyXwZUUXDn7og38?=
 =?us-ascii?Q?DDC1avHyVRQpfLQ1uyAv6PTObC7YyHj5A5xutdPFgVvsVphhVfYatxh+LFv2?=
 =?us-ascii?Q?/o+u7ZKgEpmzC8Kiwp+dgm+Zszk8Edkt//y4cabfzLa6JihxY1ZNdG0vohh7?=
 =?us-ascii?Q?xnzbMEM43E5iXWxLyCw+UxCsPApViaEBwgdSK0B6D08sqPBXFR2D6DWBMgch?=
 =?us-ascii?Q?XF1fAFD6L80xjTQIJ02J7HR6Nq8LnPmnQQTGsnw4N+dLdvapl7adzm4Npzk3?=
 =?us-ascii?Q?WaUZ6vUNhLgqECAgtAZEUG0JMPRzIZb9aJnBsSk5vjL28Nn0q3DD6zIaMlOu?=
 =?us-ascii?Q?NcqTKA47nIlNZmEq9VmXZCAuc4YNbm18Gr8tPN+4NEbYw9JnT+6PAz1pDvng?=
 =?us-ascii?Q?B/2W7lDhw2HtOSZUt94sP16aGamYbCOWuKVX3j8EK2OvP5sXxeAZKOQeboMV?=
 =?us-ascii?Q?Qyy+YHNP6b1yijWgqShi1Y8J+8rwdwo5m5046jVlUQsnwbUV8bgRx72sCiyD?=
 =?us-ascii?Q?wJqelEf7P1DrFxDAJPchrCdDkjicdpy2TZS0UktMsfw75l/GVQ+D3SvSsOC8?=
 =?us-ascii?Q?DhbREBTBMky7I0rl5zGo2Wpal5PpBQOgOAYHO3UdT9EOZFeR7fG+pyxYlwEf?=
 =?us-ascii?Q?GVs3TJqWYaFRsk9xh8bY4AR/WUCCfosBgP+iGQiSeUL2pzF13Uc0mf05Nlwa?=
 =?us-ascii?Q?0FblNjgNjTAjA7CJp3tODOkDnU1pZM6chQkgbfJDkxANSLNG1PEpSVgxNl+8?=
 =?us-ascii?Q?Bp1cndHvSNQkazaoO4hp88Q+z6GVBF4S6TAnWRe5PYZQJks0OKY04s0r12fr?=
 =?us-ascii?Q?W5lQQODRNgjX8YWSW0wySjlNu/Q3+eGgxNq9BflVQn7ZKVn6XP4UV6FeQlVD?=
 =?us-ascii?Q?1IQbSwGu6c5M2txK2zq+2gizc+TiLHb8Uk5o8lEN2JWUFibDaJjHSSznA0I9?=
 =?us-ascii?Q?b3ES16NIsnDvxNEI5GW9/stnarp9r9sXp2n934Z4jRPuM78u8xBc40YnavdA?=
 =?us-ascii?Q?97lKwAmiTLr/s7Ey9AHeu+Ld/5AElTU+a3+TCI0ASmvA2tJDfqr9ADURMh8G?=
 =?us-ascii?Q?slwsXBRewAwII/nUGqAe3YMqYIxXsDRkLzwt3ii0tmUSSVmWJEJRNMWLGOxS?=
 =?us-ascii?Q?Z5V0BhvIleZecgTX2AyrQtsEF9zN72WrOMDCRtxw1vHd5DUxc1TL8I7CypiO?=
 =?us-ascii?Q?gRJRw1nfvJhTXJC62dZ1sjJr2BH4ZIitthX+sBMM79d790VEzhSaKOqqRsmx?=
 =?us-ascii?Q?1o5vA4xNwZ0sGivuqhaWlWJS69jC3rSmQ+usDJ64Fu1RqK3rVmzA3Ei8xTEB?=
 =?us-ascii?Q?e6plo/uWbbKGFa0iipjUVmm1x01Yyeiuap8DtEwZOLOHxRxnj5l4Ygg/wiZY?=
 =?us-ascii?Q?YSR4eh/GO4N0JJvuHQag2r/0HuD7Lyxyv/b7WoLeT3SeCBRf+jaLO4JixzDz?=
 =?us-ascii?Q?pfVB7B5ode8w5NO4quBofKZky602ujNCQeZEk+xC/xmIad9KHrv54vitmuoU?=
 =?us-ascii?Q?BYwAptfAjZmxgW9AC2omQVuGidKeYVoCMjT7IsG7bn7Fq0yaH529HiT8BTue?=
 =?us-ascii?Q?725n1IZowVY61Z4r7uXM64vkpYWfU1fhzENPg9Wzby9fH0s+lm/PXN6nyrg6?=
 =?us-ascii?Q?8Pf0jV/BKGk6LYG4i2cCD2s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41831fd2-49a3-496d-3d7d-08db08f10059
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 09:52:18.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccsam5lQmvw3RsCofg9fTKMfrMW8VNTgO9gcBTvKvDekhLjrNd98XjTHweRFQ3x254YnAf3xcRGjGB+FxL3DuzNPqjv7zIk2gqCahxWtNDZpiibICGsFjQ8iCJx+ABTt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, February 6, 2023 11:19 PM
> To: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>
> Subject: Re: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
> OTP/EEPROM driver for the pci1xxxx switch
> =20
> > This logic is not possible with normal timer functions. Timer wrapping
> > logic is handled by time_before API internally. So, there does not
> > seem to be issue with existing code.
>=20
> I have no context here as to what the code actually looked like anymore, =
so I
> do not know what is going on anymore, sorry.

Greg, I addressed all the comments received for V2 version of the patch (ex=
cept for the one in discussion).=20
Shall I send V3 patch so that you will be able to get back previous context=
?

Thanks,
Tharun Kumar P
