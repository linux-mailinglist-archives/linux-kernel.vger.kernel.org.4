Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3239E64E70A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 06:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLPFkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 00:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPFki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 00:40:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5170CC77A;
        Thu, 15 Dec 2022 21:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671169236; x=1702705236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z19im7fCXWjBvnCcT+S3/vk9KVuPhBr4sak37N5G1pE=;
  b=lNlWGhxKZW2i0Kz5TotWzw4mm9Rbc8jF9LpuOcZXrUkyP2zgHHxAuGbz
   TE746Koeqc3mGWUvWyC9KWN9R6YVcQKmdvE2MLcBc/eMgzS4lnsQi92lo
   7eqXU2rGcNb6rBaM6B/nhJjiT9UFgNsbHeYehvxyNZoiXBE1fQ9+gznJS
   GFLoPhrIDrmMf1gwS0MbAEP5Y9JZj9d1FhrmAkJPpRzZdnYIlJb0fe0jR
   pdzO0jrmY2sUeoYOaz5b0jX4TahTDXhONzPuBDjt6dR406LhWMWxuayQq
   mOgPxVAI8/T2ElhO8767Ibd7E3x898wTdF5E08GBn2RMl9A4YOYXWjvd+
   g==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="204280969"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2022 22:40:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 22:40:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 15 Dec 2022 22:40:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF4J2FkG6agsq2CV2/LWfpKa0gwymHmopKLQgJsdz60pPTJfOnVs0T7ZGGtNhbAppjmqYTBYffxoEDTlL6QvJznZbsnwaWokVvCqZMqapJYksJHTfdnIX5sHD+D946BVa7y3oY5fFMY9QpT2TsmlwAZ/MvQyOFO9f9kFgmmqj4qTZmg2eSJCl+9IXWmIZfjDIpBd6xzjE6AWQ4h/LoxMvo2JWE/PbkFBbZXPcvY3SwHphKhcPFVG21D61tlJQSkAtFkwQmw3iFPk/8ztZeVo8T2R9xdQvsk7977Ikvi3He5dUXVkjO5hmhv2CYDvZRcq6PqXFqVPpH6AU4TGqoCFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VmsqzN2Rk/64HVJW1wjBmwmAW7Tfb53Jso+6RaHfVM=;
 b=T039WZF8zqjCAmPRdcC1jfhOiwhkhbm1KEix/ow1LjllTtpvPW3P134XZQtiUTh/GoQoKK+II6WHvg0RpaZa6Kyyijg0ftn0gvlUlOIx4XSqEE2GgUZ/1YLpn7gCpjEneHnfZZYCdyucz3NpctPv2Z/4t67LxfqJVKEU3vXNBQ1/bwOcLnxbIIWsPerh5WI6y6uYBG9uUsbyGzoP+9H2tDE2T0t0FOd04nB574rTFdVU+VzYaCaGDMgw25E1rS+3VaiB1wqrCWSfjs/6b/AFstGnC5ZIASxhkzVg2HkdX5BsFbOl9+MQKJGd1X1VtHXQfztZe6GCMqnhf3lJPI3c1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VmsqzN2Rk/64HVJW1wjBmwmAW7Tfb53Jso+6RaHfVM=;
 b=K82/fMeVFQIw3/nNYrU7aBONxE+IOf0KeANrGam+hZs+5iagw7etUg1o1qJ8eJg4ScSftHycoCytVOIKAZqaGT1ovoYBS+AndsXDLyUZ+GymKaJ5hQ/jVP8/Nyxz4Ed/F9qU6Np8qa7W+8gfJS8uYwAmK+mDeBiRW2wmfwW/3V0=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 05:40:31 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%9]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 05:40:31 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>,
        <Kumaravel.Thiagarajan@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <cang1@live.co.uk>, <colin.i.king@gmail.com>,
        <phil.edworthy@renesas.com>, <biju.das.jz@bp.renesas.com>,
        <geert+renesas@glider.be>, <lukas@wunner.de>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Topic: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Index: AQHZEKWxJyYrAeLM7kuV3hibr7zg+q5vN+wAgADGUpA=
Date:   Fri, 16 Dec 2022 05:40:31 +0000
Message-ID: <PH7PR11MB5958DF2284FDC67FA7018E9B9BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
 <20221216052656.2098100-3-kumaravel.thiagarajan@microchip.com>
 <Y5tciHzsEGU67h1Z@smile.fi.intel.com>
In-Reply-To: <Y5tciHzsEGU67h1Z@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: d793cac4-3ab5-404a-539f-08dadf280bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WdKIjLf1v3BxmhMKdth/LaTx2jAUZ0za3+Vznk5eAOiaOE83MZd7Yy83jfIMnojw1/0Wn6OycaIfx4Jp1/Z17zSlxpL6JnqWmUJTR8CvNK694FjtU+f0UGSRnHyOqU9JSYQ08dhTcbclGPzSKjRuDPO0DxNB0xqGgnJdV2+yCvTRGCkBfYpcxFb/MjNRU76inj7I/Tu0RnJG8n0NmZyh7PmTfd8GIMUhvYjAhW/rF8Z0OTnMIgcqgo/gIwka733a/i1zEzann7CHCeENt0GAf1DNDYiN0w9uSLNW23UhvnUbo+C5Et4DnK6fW+UE+G4MmMOofQoiLkPCySlF7uLTcSJrwpetJCVf8qAraenBSBw9Prii0qRk0bwIUE1dgwQXZGxyWk020q3K5yfvUSoCPnbBzaEXZEoP0CyGzbPfP/2IBvy7ByRNEBajT8uA7L1sLEgB/jrsZFvCvj7YVSP055PMJD2OuJPTkmzJq/l2rjbkQ5tltop35MoBqhksyjfkqVFEoF5cAAy0H/koqVSlU4eNaJCq0Dg7WCLKJMTFCXAeerCG0POOnoJ5BmwXmln2EiUZ3ZwRbiPhtjdIGhsRQNtHRdwHyIArsaYyH161GD3J6M/vi3/zSWH0x5F/OVpWdQisrlXVdd1fCDimNSw0hheEk3stIKg+nUI7gvr+EfwzB0umMXomCVU61LwJh+13Mw5rTvu+R82n1L15gmCmfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199015)(8936002)(6506007)(52536014)(5660300002)(2906002)(7416002)(33656002)(53546011)(7696005)(316002)(6636002)(41300700001)(86362001)(26005)(9686003)(107886003)(478600001)(54906003)(38070700005)(38100700002)(122000001)(66899015)(110136005)(4326008)(64756008)(76116006)(186003)(66446008)(8676002)(66556008)(66946007)(71200400001)(66476007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MwZCtUC/VVZDDQJ81IJ565pWqGTckLb3zN2wU6IAws9sVYVAbU8luVJlIZzh?=
 =?us-ascii?Q?fsSINN8sF0+IUJXgz6WftgXl0ffoO2rcg9Fj+SjTKWsQrH89Pc3DvnOLO716?=
 =?us-ascii?Q?yvfIxXTdurwky3AaxM9Tnwx10DjICu0ONmxbuSCSHeVrl7kHfiYBhI3qrHaH?=
 =?us-ascii?Q?vOKOEZH/nJYWjfZ38m6PMr6S2azEXVW86LtCFzSrKwVBbdn0NheucJ+S82Ed?=
 =?us-ascii?Q?nN7qg4OcBDIuixspFEi/M/28SSIqDbqJzL4XkTnIMUvTrF4LisIGZGhXnrLB?=
 =?us-ascii?Q?7xTYwfZWmv0/i1E4wjyTpHrLK52H8V+sIT2M06RyxSX32gYcplx6r55c/O8h?=
 =?us-ascii?Q?Tum2Uw66ti0pD0OA2RsR6JIE6bFx3JbHSEK53zpzvf/Jg0Pg9QDW2rMYtn8D?=
 =?us-ascii?Q?Fynx31MKXQYWC4LGrXnlrbMes6gvZtLujvLZllIq/vc7GQ1z6i3UOwzJ8FB8?=
 =?us-ascii?Q?KGyam1qkrJr4LHgAngjvhlFw5kSBxgVX/61y/P5+DApfE12jLVb04kEz+fhb?=
 =?us-ascii?Q?Y9HAaqPldi7TjW9H63vT+fLDufDGtzw9IagJf6DfSY5Tp67s62u3RgWeyGod?=
 =?us-ascii?Q?d/Jk+Qygq4f6iW7Mbj0yPPwXCn7c9DxuAH66f0v+VhR0v3VfopcrJcqS4ioz?=
 =?us-ascii?Q?wSnBU2CCEaA+uW4XrSd+FTzHZIEXJR51Gz0I6Jc1w36W4wm6UIEYEEdxHYFz?=
 =?us-ascii?Q?nskf7b7UM0hSJ9MrqA6LLfqReQOyothJaBgoundz+5UHMbbetKpHcVJXqTFe?=
 =?us-ascii?Q?HCJy14qZSasqHg7hMnE32QoSKe9qeHVHcl3Mc4KscRvHpWnPMgE0KAwRBfFx?=
 =?us-ascii?Q?NNH2ICXFzSmQ1ZjN8TqWp+M1eNKGsM1HVr3Lscapwu9vojd7Tp40w+mOKKl1?=
 =?us-ascii?Q?4YAKHbiCFTY+qxr6ZeMFTyfqTkXyv+w8ZfuHzkR6vhnSaQVIpmfyp53yaOtF?=
 =?us-ascii?Q?DEmgK119JDxrVLl0Hqp2eNNY2KU4uyRexHE4/7cdWrrhocAL2KaqKm1aI0fs?=
 =?us-ascii?Q?MDVhfzL0pdQgFdd1k8uXn64faVcaUsv+Lgxtpx3CGS0pvBcuPUcJhM5GJw8Y?=
 =?us-ascii?Q?Qy5I+XHAUYfdZKHQD/0AWiMJB70GsI2ZVWfXRd4ljkJx0ALfD0zaIC4sTkGB?=
 =?us-ascii?Q?cmeRte+A1Vo01O9uz40iFMWyTBLacaLyNyfc2Ndp7uycJoKGO9OME0asJ6ne?=
 =?us-ascii?Q?MMuf07uWo1aO6DGtjFnEOAy6eAsY1wEaD0asrqMkU7pq9vtzOI3OmMWPT18Z?=
 =?us-ascii?Q?BjRtsk/QL5rpzf51pNkAkM0Ulap+TX/7CRzP+Cf0Q2355wtbayZw0QvuYhc0?=
 =?us-ascii?Q?rtZTp+pNYc/ukgpTas3uMLJrxpd1JysrMRKVthfI/KNxbeFFUNNVUi2s4yyP?=
 =?us-ascii?Q?GAdYv+7k1NCSdqoYs9EpJj1ynVlGyNgN223FGyY2jmbccNvqSpyu81VJEFLa?=
 =?us-ascii?Q?19GdwWU2EwTATScbVhOX4XnsD/SHz1EI5SbcGWPEIm+Fv5SmV8hfJDjEE6/v?=
 =?us-ascii?Q?08BnpS4be4g8TLGR8ohVAHue0TagToLK8pas8dOA3OO8km0N1YYGwPq8aSFC?=
 =?us-ascii?Q?lV9BCw8MrrXkfKsTftjuE4cCzWmFrhX6XP78dqil+0xKXSO+VsIKK8dte16J?=
 =?us-ascii?Q?pflaDW9QsMyTCXsNWqM8Lbc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d793cac4-3ab5-404a-539f-08dadf280bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 05:40:31.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CBd6Q5ACe020P1GpvqtNHz0UNG2zt7w0FTAjiInp7W38aIdlYKV7OsntwIRPDwnysjN9gn6sYOoowdwjlDz6IDVTNwzcyJ/FhmktfxPRNHiWkk32GFdBV3w2CIKuy8b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, December 15, 2022 11:13 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>
> <Tharunkumar.Pasumarthi@microchip.com>
> Subject: Re: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver fo=
r
> quad-uart support
>=20
> > +     ret =3D serial8250_pci_setup_port(pdev, port, 0, port_idx * 256,
> > + 0);
>=20
> Actually isn't 0x100 better (show that there is an offset rather than a v=
alue of
> an register)?=20

Okay, I will so something like this,
#define PORT_OFFSET 0x100
ret =3D serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx, 0)=
;
=20
> > +     num_vectors =3D pci_alloc_irq_vectors(pdev, 1, max_vec_reqd,
> PCI_IRQ_ALL_TYPES);
> > +     if (num_vectors < 0) {
>=20
> > +             pci_iounmap(pdev, priv->membase);
>=20
> Here is inconsistency on how you interpret pci_*() calls when
> pcim_enable_device() has been used. I.e. for IRQ you don't deallocate
> resources explicitly (yes, it's done automatically anyway), but you expli=
citly
> call pci_iounmap(). Choose a single approach for all of them.

AFAIK call to pci_iounmap cannot be avoided since pci_ioremap_bar is not 'm=
anaged' API.
You suggest calling pci_free_irq_vectors (even though it is not mandatory)?

Thanks,
Tharun Kumar P
