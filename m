Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C58D624826
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiKJRTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiKJRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:18:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCF6659E;
        Thu, 10 Nov 2022 09:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668100729; x=1699636729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jTgPsTpWEp2q8xuowsIAN0qL7D17f/OzFZJ6FJloswQ=;
  b=qETrGZfsv0KGKQYfAdiutoZhLIWV6koseEGCc3Wl4l5I4svEt29ut/dJ
   Xdjt6bpTcfmCJnVzDjk6cbZx8XS+0W+YH91DbrVpBxAATLqpGvRf+0eAZ
   1UGyATTfF1BHVwlIoBbCMOzU04JUKP+LPoO5mn65+PscmXaa604xZOt62
   zpRmap919XOXFRLYqfyVbII9rcYT3UzU72tGIiXgpgAXxpeRLqLYwwdXt
   VoZOBoBbYKkkGMeHUEKhR3tOBc9K+jAnJYjc3mqPrL2CRoQBOUiTkRq+L
   PM/mC99tq8bgYC2amFSWaCBSJ6SE4Q1SGS9Hwthl1gKWz34aO6qYiJb0F
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="188473920"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Nov 2022 10:18:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 10 Nov 2022 10:18:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 10 Nov 2022 10:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVK88LcmTncwIljPr/qm3BcB4nWJaAQXaeYftjDKp6DF1FolyaEIXl3nQqW8a3HAuGPxGfziDnwwqiEIcIfVZpq9gVaJoJ6/UpgP0Tg1cc81qn+yIFHTyRIVI5rNNUDWaV1siA2kLqILc0g2jvhZeJcqz6bJ6GyzCtrDdZasJP6bM23kD4IIOjTy9SyMGBMVtPRQ4IOb67EzF0FW/T8OcWAjHCzMtVSpaeXVyPlaJmWZm8yqcOwq4ESceU4AwINVxK0I5hue6d8ovTecK2p+IiW5mI342cBGvqq2hW1L3IAjWPHcZQmqYgt9zY4akRiZA1eqrjvVIHH4jEfgFDZnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKOy+JCnVGc6c9GhibF31x+dwHQMZrXATwLiwYXu4RQ=;
 b=J7Gl1QPSL84IW3Ln6qfQ6QB1MAiejqofTNOzKDXdvBtSFfymiKP8kfC1mWwR+GlP3soXBkEuE6gX0j3G5xjE6zQO+Eo4ZsiQbfxkwQcVAnueFb09ugeJfIr2MttR3RR26hj5BtVDILlCgPMIB4KllnOao1BYYRqoL0sjGxMS52ZAAQedVblXRKtfMY9w3rkZFUI2TJ4SP1z86m7tH6gbq+h32p1iDYyjTgotrb7EuZrGqtx7dLrPt7w0M3DypkzpgGz89NWxfkq8UpOpAwk7UXrR8pw3UJyBUnJGn7reok0q24omGuhUIbVYkDg7meLzYk7QwlrV4Jv/G9F2cNR/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKOy+JCnVGc6c9GhibF31x+dwHQMZrXATwLiwYXu4RQ=;
 b=lh0lb+t1KqjQOgD0YbdBPkU1IM06akQUXQpBVi2Jlex4xRykbPokEADT+mpDbeE8Ca3dmXF/KckQzqaQI2C97IDHSq2gv0QTjmFFcQvIgIipDRrRNAqGVhKzqAu5eSYQLFwBByQX1nBz9zaj2fZtgwNmjivi1L/XA5RrhE0Nwy0=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 17:18:46 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::fecf:d286:328b:747f]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::fecf:d286:328b:747f%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 17:18:46 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <jirislaby@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v3 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
Thread-Topic: [PATCH v3 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Thread-Index: AQHY8qbOKjSYZX8pv0a09I/nHE/OKK42gJIAgAHWaXA=
Date:   Thu, 10 Nov 2022 17:18:46 +0000
Message-ID: <BN8PR11MB366816A34B16BE29A5FD7912E9019@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20221107124517.1364484-1-kumaravel.thiagarajan@microchip.com>
 <20221107124517.1364484-2-kumaravel.thiagarajan@microchip.com>
 <Y2uWftt5b2AWyTtX@kroah.com>
In-Reply-To: <Y2uWftt5b2AWyTtX@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|SA1PR11MB5828:EE_
x-ms-office365-filtering-correlation-id: 9120063b-7269-4108-e4c5-08dac33fa03b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUCcPcOioUOqWEpKPXWO98R+Vo97cScfFZqpoXs4+O+0krDJRfD4daiCTdNmda2rl3uwqCVopMBgadUriNaSEkQnKaMC8fIpkFjgmkNA0BdnX9po03qcCW5sXn0ZQsqdeeZgdOwfqJTG2obiezMUrvfXUoRUs5Iq9txQbiAi4P2zXKpi0r54cILj21VNediSbtrPq6Avtk2nJipd1kEGriofcaNIOrLeaw0sitxsjnErsaFliGKnXOkLAKAnUwt1zDnNMfmd+TOXBeEjvkZ8HueisBeyJDSuhtDBJvtODeucPsCGoY6e0cCJNMLVGw4Vg3pac1RKcAa2ZwraTpbS4GRBqFbgz5i2CCO2MzyDJWoUVuXkOKH3/cXQYWyqxoDrDZ8k6S2AXJA9TAEw29IkCg2zUmVtWqENnHWCaf/CGiMS+BO03KakTijKvARk41EkPhO2W8jtp2mJ/RFiPKHnYihy80E46GeeMRcWKwwuWOzBQjW3I9otbv2xPQ53UQ7xJuIKTlYZtvWbivxX5IAxxfFkC3JfaC85uqEJCLa2zI3uEOEfXfiGhqKFjECoxPylJ+/8dw4xrV9sA0OlvXdHHMpl9xxad/4kFepc0+G1rGfy2GuL8xwDPEPOtF6YxDbZifHod8OZdvHWu1UZliszXSPLe0wOCxYTq6Xp9cigL0H5wuJjkTwRBtyQVyuOY1PBLEfVWhkoRo7CQ1vSDerE/0yOQ6nQWMdQP9GNLvWH1uvgEMyoTyNI2glRFNip3YagFUA66JuhmId0/4cR7UHeGOb8yKv1et5nMR0JWtFyR5h7ZFmWf98gYUUJDdWkwRUnjdUhoII8L9MJ3RDhdM8Q74b0wF0Q68Y4KMsFkCnigWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(71200400001)(478600001)(107886003)(6916009)(38070700005)(54906003)(316002)(55016003)(7696005)(4326008)(38100700002)(64756008)(66476007)(66556008)(66446008)(8676002)(53546011)(76116006)(66946007)(5660300002)(26005)(122000001)(86362001)(186003)(9686003)(8936002)(7416002)(52536014)(6506007)(83380400001)(33656002)(41300700001)(2906002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J4mvkjwaulUrLhnyKu7PW/ep2RrsYXPNGV5UudQwpY28ldse8otgJ2YNHPU1?=
 =?us-ascii?Q?nfRKCyhkBsEAhouyMV4IxpnuAuTyCTCouOrspRZmCDKBaSffPstv9f+o3wOz?=
 =?us-ascii?Q?jguqwHbd0wH9uSUxAXhbhC0C+hjgPOHMDhiYc0ygdKTHJbshZX2PNzRu4qPd?=
 =?us-ascii?Q?hOI6BolH95sanHNxeEoi5F/3jYZbr6oS3Vsi7dfV6F3uGJt17VLMK8kB+U5S?=
 =?us-ascii?Q?Nkp5iJQZtdzpqBUYmoCsBOEKk+ssCgTFdZVCzdqDcukbsQ6t0ZESKkA86f6k?=
 =?us-ascii?Q?3oYqKkHCTwrfKT7YGGR3DW3o6DxzMBRtbcQGYQL0cCpXB0FS2zD8bQ2a/KkO?=
 =?us-ascii?Q?9+kECygrnODShBSfYQojHpwSUuUSv7GX17RtnZJ9ZP6digvigJtl5tM0/80C?=
 =?us-ascii?Q?XxPmOqha3Py2oBF/yJ+SHSliMxvMH7rgMi0S6GSw4IUKoZZgui737bMeMa3w?=
 =?us-ascii?Q?eII9M3lk+ldMjBy497ebwWvKTY3NFFAsXjUv5oRK3+lPqdAO5f3axFXFFGit?=
 =?us-ascii?Q?6ivmrbcPUe5b7VbOiQM8DWL5sDGp/QLWrV9Io3VcUy/Qefh54l7CaDB6dOAV?=
 =?us-ascii?Q?37jNpQEdSZ4i/E3tnzuKg70c07eA9oLJ27oUlpE3kg9jUPWzeSmheVMXoAIG?=
 =?us-ascii?Q?PaQXiy8jb9sHgTShBS61KuVPBMwZRdTs2Q62mv17iX+QJkp7WKVytylGrf2u?=
 =?us-ascii?Q?0XkOvJrnbyqvf0XkYz2tZXyq2+TXVohvZ9J7n7OLscALG/KbSN8cQkmcmA6N?=
 =?us-ascii?Q?rwlAvQHspUTPHTtiJG+w1yCaCSiycbExP454iUEe8tFPlXlW83sCH4pYppr+?=
 =?us-ascii?Q?nBBiWsGlOlVYywpCHaPURFBQNTI9PJm8mR4lMWm1z8EUT7kfYPLWDrd520Ef?=
 =?us-ascii?Q?RzYTKfX8RBk1+eSh8/vGAcLgK1Q03m2sCAMAlAJe2IJCg+aCZKFZBNeNWPdJ?=
 =?us-ascii?Q?AbcSr6WoGG6pqLTtLmddBZMzQXooT7GzTydQ+JE5rar411v+qcttYLFhJV3m?=
 =?us-ascii?Q?NINk4+4Km7reToXP020iarpoi3joMzsPx/CihbmH/fn8UPlyAPB2LOv9ipUx?=
 =?us-ascii?Q?alnKxgAKaajYHaAt6ya3A1ALK2S6ENpH29nP0qHF1hKMRYno4w60QbML98sq?=
 =?us-ascii?Q?gPrJFxG/u7qEQ+JRPNsnBzuMyUOFs7DhXdqcNH7u7Puk8cbM/HNhfWEL5Ny4?=
 =?us-ascii?Q?LV9E9oVR0A7F/Xo0kSDX23i3OGxTgv13DOD9PdmXUuyuO2Ib33IoG0NMrUeg?=
 =?us-ascii?Q?SqeBni70fFwDnC2uLIQ8OaJwRP70U9s6chtFwlTakTAmWcAozjNMQlNz9UCu?=
 =?us-ascii?Q?o0ZsC9gygCjvCgV1OFnquBkNKUeEA2i1WMAj+4fvwpobDtOltn2dhNG20+cA?=
 =?us-ascii?Q?i5e3XM2Tx40K+Qk/ncQxspG7TnNZ9YO7oG3ti7rA2DZI1o/XMR2ZXOGKZwdk?=
 =?us-ascii?Q?jdvCyj7yYnvXrp4r3cY+ozepFe5YbcG5db1AF0VvY0tL1sW7DRRppZqfnMUe?=
 =?us-ascii?Q?yE6V8RCbclvkS6xz+sRIAIdpMSxSfvW6AEP0lm4DPvmNOlLI2/dvMC54FNYv?=
 =?us-ascii?Q?uov1FtlvymelVZYoPSPHr7slzrQ9LyeuA+BVIaxoROVO6UyBcj7CWSKZgdOS?=
 =?us-ascii?Q?xBcmpe0CV8nSCzDnb/32PO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9120063b-7269-4108-e4c5-08dac33fa03b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 17:18:46.4825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfY1JaShmXDseUYMYnY7EaLFaxD8a3aOZ4wz3rMSNzc80CDn/fMlv5svJ9aWYwg89G48/HLKB7fv6dK9WgpNPQ9WJUIogSafc0Py4qTdgwlyMS1fPeRHCa/WsBZpHm8j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5828
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, November 9, 2022 5:31 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v3 tty-next 1/3] 8250: microchip: pci1xxxx: Add drive=
r for
> quad-uart support.
> =20
> On Mon, Nov 07, 2022 at 06:15:15PM +0530, Kumaravel Thiagarajan wrote:
> > +++ b/drivers/tty/serial/8250/8250_pcilib.c
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Microchip pci1xxxx 8250 library. */
>=20
> Better name and a copyright line?
Yes Greg. I think "8250 PCI library" would be the correct name. Is that fin=
e?
Regarding the copyright, we moved the "setup_port" function from 8250_pci.c=
 to this new file.
Can I use the same copyright statement from 8250_pci.c "Copyright (C) 2001 =
Russell King, All Rights Reserved."?

>=20
> > +
> > +#include <linux/pci.h>
> > +#include "8250.h"
> > +
> > +int pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
> > +                u8 bar, unsigned int offset, int regshift) {
> > +     if (bar >=3D PCI_STD_NUM_BARS)
> > +             return -EINVAL;
> > +
> > +     if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
> > +             if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
> > +                     return -ENOMEM;
> > +
> > +             port->port.iotype =3D UPIO_MEM;
> > +             port->port.iobase =3D 0;
> > +             port->port.mapbase =3D pci_resource_start(dev, bar) + off=
set;
> > +             port->port.membase =3D pcim_iomap_table(dev)[bar] + offse=
t;
> > +             port->port.regshift =3D regshift;
> > +     } else {
> > +             port->port.iotype =3D UPIO_PORT;
> > +             port->port.iobase =3D pci_resource_start(dev, bar) + offs=
et;
> > +             port->port.mapbase =3D 0;
> > +             port->port.membase =3D NULL;
> > +             port->port.regshift =3D 0;
> > +     }
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_setup_port);
>=20
> This needs a better name, 8250_pci_setup_port()?  This is not a pci core
> function.
Yes. I will rename as you mentioned.

Thank You.

Regards,
Kumar
