Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC96D0C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjC3RVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjC3RVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:21:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4041DE048;
        Thu, 30 Mar 2023 10:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680196871; x=1711732871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L1oR1l/qrg9FO2irhmx1vU0LkyRMzhdR6usuw6PQEd0=;
  b=C0lpE42rEI2chWULsajRgMYIqrNyJ5MCsKTk26YhYW2+jARa9LWv9NB+
   ddyVH1Qh/b3kDbFEQg5lwHCgRzHApCe6t8urA6e7kuQFgzkD1EcIsxunL
   tvQFphaaPLfpHU+n8KWH8XSOXagzvbRsk/PTslNCX/lGpiGRvYTA97MCf
   dpsouLNkExlH6qz7hax6yMJDfbHH6k//PmLsrhnMffxw29DmZPHxv332K
   pzfqNkR+/rre7pDx2J8umxUglpAGimFXFOsXgtqkUxlZr2Qi3IKuUCLEq
   tM42i792i58E94lMoVaANm9HlwMZxu/CH6GqmRQXUsfDsCH5NF7MEi054
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,305,1673938800"; 
   d="scan'208";a="208102405"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2023 10:21:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 10:21:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 30 Mar 2023 10:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2IRVlDr35JzRS0Klxvbi4Lp++rHRiAg0DFsU4R/9zVsGYgfjE364f4KaKV1vp0lNBdRlReOgqi892I7Xbn4oH7Zc6yMfKjfyeLjscMn5hlJgbxmQc2UO225xRizQF7LPYLFW7+4XfETl2JwZ5YAxUMccjEnsJencjls6oAGtXRmxKCDVbmN1ou2UZwq8fqdNJHd4aUNUFoPtw3ky9YxABw0EqZ3x54NA8Kk9J+Lhl1Da7aS+41JzpLH/+j6jdqhfLn2YlxtlwhRl6EMUoOYggzuxx2rWstvWgAHwP9MQ0EU4cRkUvS/MRFHYiQIZ9sQu2+6uwsn8am1bl9gcxKBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1oR1l/qrg9FO2irhmx1vU0LkyRMzhdR6usuw6PQEd0=;
 b=mVAjvMq7/FOe0JpaZJ+R1glqx1AQGXdWVYLNiiikd6DU1XGads8lJabfTR+7T+YFR1Ga9PDQ26SARK0xFLr0lNM/sUeNlbOknDlBN/82+QNEH8zksQfpDSUX4iHliSFZGK31vvCJUBu6CmbykkZb0RhH9BvhlnF99n+K1UcCHNV5YWlL4PnPuSPRTbvmKnMQrMxvvXoaQJLF795bRC8S+aTYLT5MjlwjUctmgmg6T0g9vr/au9bGPO5VG3xMRDFTff1LXYsgw7e0EJQ1IBIhJQxIPgFRvjwBE6ucCblxTVq2Yp1pCxm25ONl0+m+Sdl6S0wMXmtI160CRthz5P9JKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1oR1l/qrg9FO2irhmx1vU0LkyRMzhdR6usuw6PQEd0=;
 b=QAp1CQW4YsbnHs7kjJmKxQOnwH9X9wNVE1i161DzTuC/gWw6QD7Kv16UteYJ0Un9uTqs53K5N5RGLAwnCq5UPS0vLbNP3UWMJbA4U3+hf4BT26MW1EN2REoBRjn+7Lf+X+oIBwdlQPs1U+HI6/VlBbS4aiQMsxVvIv1RIxWnCi4=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Thu, 30 Mar 2023 17:21:06 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::5695:64c3:bc2f:ac49]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::5695:64c3:bc2f:ac49%4]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 17:21:05 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <michael@walle.cc>, <VaibhaavRam.TL@microchip.com>
CC:     <Tharunkumar.Pasumarthi@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
Subject: RE: [PATCH v8 char-misc-next 3/5] misc: microchip: pci1xxxx: Add
 EEPROM Functionality to read and write into EEPROM bin sysfs
Thread-Topic: [PATCH v8 char-misc-next 3/5] misc: microchip: pci1xxxx: Add
 EEPROM Functionality to read and write into EEPROM bin sysfs
Thread-Index: AQHZYYNgTYTojDFibECZYXEsb99IwK8Rh+aAgAFGD4CAAEl3AIAAeqvA
Date:   Thu, 30 Mar 2023 17:21:04 +0000
Message-ID: <BN8PR11MB3668FB0322DB86C1DBDBAADDE98E9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <f999539280139b7085721803f12f836c201edf20.camel@microchip.com>
 <20230330095140.3384441-1-michael@walle.cc>
In-Reply-To: <20230330095140.3384441-1-michael@walle.cc>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|DS0PR11MB7785:EE_
x-ms-office365-filtering-correlation-id: 499bad36-2001-44bc-5a81-08db31432498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MEJpf43iIfb+LhhOPVWLuBWLEZlAjOOf7R1sNyXLWB98IyN5nOtawFIv9xW4+cvwCPY6xKimKixbfq/E1z+/VJMncfte85yyW311A8W9GYakBEPoJqFmhlj3HD3abitjV9KrPUQug23SB5JqbObMA204ZuAPGXsG8VvgY8Vofm3kXL3B+6/bkIQVm1XAP1EgY8Iy6M4JjPTHwI/3QMTQO/ylNyqTfHKcJHhd+bCqlG5/hM/QYco5DBpzF+APtCi5axX9BvCdYuDgSTKWFZtcZoZuoEUH1yWX1iv8WWPulC5QDjudkAnjnv4VKSP4aYA0OhdLzo6VT4k7jpCXclwjXpCz/xxTsVnyQygTsIxoYbRdr5fjfLHljucSGEawv9SIC2NLcdlBbPwoYHlVhXjq4fKLImAvRy06nYVh8HAjw2bRQ9EU74tsI/0d+0OyT0ZS4ysxv66P3sWxY8xHXdGpgmesuHCZUfz5HJJKry+QKr0HTyO8Da1dfPJVBNkKuJwMmPBsw2ufadoX1pUCjI37u4jgNaRjh12ilcWxbPOnwGN4u60JsUwRC2sHm4+AU1H7s2vR8/VXgnqhUNJHVdktyktvo/YzWfb8mo8hjRfx4DjuqIZHQWwgoFrsPCEIChEu8lHmzk3jfNdYaGvmy3CLPl4ZJZ7mRYrBKs0UiYI1pD03YKMdQtdnpDv+grGhkGswipVwNQy04z6RY7QQDelxbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(110136005)(316002)(6636002)(478600001)(54906003)(86362001)(8936002)(122000001)(38070700005)(52536014)(5660300002)(4326008)(66556008)(38100700002)(76116006)(66446008)(66476007)(8676002)(2906002)(33656002)(66946007)(6506007)(41300700001)(64756008)(55016003)(9686003)(53546011)(26005)(186003)(83380400001)(71200400001)(7696005)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h4zUEkiRfulJChnV+yztkoowkLgCgTI7t9C4LKEdjE2QAsDGemWxPl692hGm?=
 =?us-ascii?Q?T+vUXpwFgolg/lNBNBic3MYtew8cKO9JcxTYvpD3HJQZSAi1Zx3iRsmT4Xwl?=
 =?us-ascii?Q?b6DkAyKtrUluPti7b4qI9PBGeJ46O0gaR8iQH6LqzaJnPwTMCygmKZ3UlZZ3?=
 =?us-ascii?Q?DSV/ddjtxgxAhYEJbaG+xTBaMs+gP5BsAmPvG17d+wmmXuU1dlbACqUcmPnY?=
 =?us-ascii?Q?Me2PIIjCca2u3FvxGYIVoO4dbItytNhLNpfiyxYcYzWFTDCwO3v8LpMbL3ZF?=
 =?us-ascii?Q?HLuoFVsxigAOZQPHCXJBEy9JyBODrWyONEcltWvr/Swsw9aCM2GXVNtQe8tI?=
 =?us-ascii?Q?YgpPgRnMchxmlI1cqirVk1zhHfYdf1R+SPvWu9iC6yavShJXjnUgdPq2sWzq?=
 =?us-ascii?Q?hoQO1LzvlemdVVaT4oP63knmsrI5n0Db5t1mg78YK9gQNKcWlknT0gKJs9+R?=
 =?us-ascii?Q?BI1Oo5T0R/RmhXH/E8/bsp65s+1tenqV422W6symIM0+NSYYOKJEPIV7MvxO?=
 =?us-ascii?Q?04ps4Gyp8vnyBMGYu+IPvg6TKL0t83CNSY4c/eDyBUf5zPDTqYC3yA/3r6ga?=
 =?us-ascii?Q?lMLO4DO/7iO6wTFmVDERZjFuo7sRL5GeDJvvwZpODTYIC2k6hhGI6+GPhn7X?=
 =?us-ascii?Q?bz9Utdsg447zZBdbWUzQcnBquzjdUw4h9iqKcx9RPRA/QFxWfL8NLTQFBWbr?=
 =?us-ascii?Q?PJ2KSpOSL8m/YS299mPAs5SS6UONOUzswB/CDtoRHgDHP+JtvZHIZLPkywDY?=
 =?us-ascii?Q?GIYBI7W+0E/964vluEp9a048qXozykzQ/yoFCbwsscTyyvN4qvqcAt1zFI47?=
 =?us-ascii?Q?lpIxqhVKIJ8zo8md0evLIkNkHCwGzFtrjv9hPWpd/pKwIn5OlSkwaDMIA9a7?=
 =?us-ascii?Q?V80Rcdmq0tQKPWIkoJ7k55AlKUiP8FUQpy70JZgcYGjpOitZ+KhCt2Z9lllK?=
 =?us-ascii?Q?HJ9fwP2vXuuvDI/yDr/Aq5d2MVEoPjaqfmDEuP5WtUzlX4WA2F/x3KEwcSAy?=
 =?us-ascii?Q?/pI6WbdfsyPb4S5v05Zz8AejlK4qVUNQv3FnJ9u32Q8GeN1RH2d9Ll8NUDZr?=
 =?us-ascii?Q?7EBiC3YkJw9A+Wv1nNPISkMFfgHXvjbixMZvMHjtBDFmu+5KQt7wgZQHkBfM?=
 =?us-ascii?Q?KytV9VZFIfwEjfZCMn0PorySHI4/L4rkbGjwMYjdptW6YAN/KpIHL79WiTHh?=
 =?us-ascii?Q?6k93wpPxo8PZ75ngs9T+VR6JzX+Gek1+dliWoLm9wmwt7PM4uZG61Q1t/HwB?=
 =?us-ascii?Q?0R4miKf/08EYIvZvd7yiazBMSAT5wGN7f98CbpjThDkQ+FB+y5Lw60786GkG?=
 =?us-ascii?Q?mCPa8x36HJzvmb9WT/Iy9NwriWTkpiRyemtS5Cj7a9Utx8DgKyocZDQnvfA2?=
 =?us-ascii?Q?AQPG0ZITHHt3rtVII85WuD5UEHdSM6TXLvmkvTISkLOdndizMk3iBLV0Iie4?=
 =?us-ascii?Q?9WmalQ/HBEzP6cTBkY6zHxOyN97YmJhWfLGdyQlYFvaNsnAL2Khxo6d3SqZQ?=
 =?us-ascii?Q?bCa285pNYgWPHCeFXFLgG6wYAscl/6fVWPST73C8yfZNx9gEPA5oFAI49Bl6?=
 =?us-ascii?Q?j8sVfZ86MTrfmQ82Gv59CsA72znJCuRzdu5at/QC1tm3bEF5QM0daObq94pQ?=
 =?us-ascii?Q?QYMITOHy/KpebP15WIRdlLY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499bad36-2001-44bc-5a81-08db31432498
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 17:21:04.9229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9u3dVzPHqRFYdYzrdGU2Ohc/7URuzkdQgETs+d76AB813ITWL0cIJn208hEs0smApwgiilZEt0M3JIlzFAvoCzdB3lus5rCrJbhnajDmYDY53Hy9Fbybf9Hu+iCRXbwy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7785
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Thursday, March 30, 2023 3:22 PM
> To: VaibhaavRam TL - I69105 <VaibhaavRam.TL@microchip.com>
>=20
> [First, please CC people who did comments on previous versions.]
Sure. We will do this henceforth.
>=20
> > > > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> > > > industrial, and automotive applications. This switch integrates
> > > > OTP and EEPROM to enable customization of the part in the field.
> > > > This patch adds EEPROM functionality to support the same.
> > >
> > > Again, why not use the in-kernel eeprom api instead?
> > Unlike other in-Kernel EEPROM APIs, this EEPROM is not accessible
> > through any of the i2c/spi buses available to the kernel.
>=20
> I fail to see how this matters. NVMEM has a generic read/write callback.
> There is no dependency on I2C or SPI. Again, you should look into nvmem.
> And it should be perfectly fine to use nvmem without nvmem cells at all.
>=20
> With CONFIG_NVMEM_SYSFS you should get a "nvmem" binary file in sysfs.
> Wit config->compat set (although I don't know if that is recommended) you
> should get an "eeprom" binary file in sysfs.
>=20
> > It is only accessible through the register interface available in the
> > EEPROM controller of the PCI1XXXX device.
Michael & Greg,
By in-kernel EEPROM APIs and NVMEM, are you both referring to the same?
Can you please confirm?
We can explore this if that is fine to use this without nvmem cells.
I think we misunderstood as we were referring to drivers/misc/eeprom for ex=
amples.

Thank You.

Regards,
Kumar

