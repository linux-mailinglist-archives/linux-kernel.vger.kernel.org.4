Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E658562925F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiKOHU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiKOHUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:20:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60930205CA;
        Mon, 14 Nov 2022 23:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668496838; x=1700032838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P2L4C6AJiMx0jzgQnJomliHJH4OQMxzGPKCmxuQKVuo=;
  b=zAJvR4QmejL5A9cgeczdKFkY1T5I1LXh8gxvr1+eRb26YGew/duLq504
   W4GGimME6NT38w1dhLmvyAOEBcJPj0fL0xOzyv5nl25/ljeNsG8gnhyHN
   J86cFuXnDYLgMaKM4Xq1P0JZ15hTeJj+YNHMgq08sWkbjALj+tyx0IXFw
   8ri1esBHnH6s7/w0JW8DaM69Ma+CiwRNKsJXWTuoqUnrQWsxgdKve3Prk
   uIrJBRJ/rNFqm+v7DNSLfc8AytYyPuGU//NuWi33Fs66pqq4UEztI9ZUF
   TEh+18/EL2bkSPAXw1E7nz7dZUFVNrp/6pbAXMR38+LU4EFVK6fMrSnzq
   A==;
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="189004648"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 00:20:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 00:20:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 15 Nov 2022 00:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPzjn/OrayZd8K7QK+t1Fubu8JDjX76nwZS3O5sg4PjdLbDPXP80r2nKO7nCJFVctcKSnh3QETkbO2Hk3FEGFVj11CC1Ekw2hE3E7SCweSUl1PtH/nJNGH6N+DCE78PD5YZmnNNKp3UDP96Y4hvmiu/qCeIPmydW6AxobH0vfgEgqJr/KHSkpg6nM7K2NWpmympdkyXgQjEY2ktXpmPqkTU4vO8HZ2XYNXuECgemH8YpYUSs6aDVi2O8mP+1qevm/ULwY4cYIEh4i1HlMrWlj1pXL3vgC2Ma3j8Lu+7gPUbj26iur0ZnWLaeidwg1Hz4qRlhOnGiu6kK/4N8meD+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqpdnboAv7dpSFi3DphiOCIPkRy4Dib/6tsMr6pdbTM=;
 b=B+SD/YPk3QfCaa8DmjCL8C+frpr1CPgHqsSZuAeGLGrnRJgGEZrodb8veCOW+sYFjGKzdEGgYkpp89FPNDSCBjUItJUs/CRPcct2bRyfPcEiTzWk62RK8QjzEVmwMcFQ4KxbB+yG8EKPnbhoPhyTtJAxhhyU8BjUBOVQ24RqnKkygkLBX7QKWKr0obLMO9XoNW/wXpIpt7AxG2itG99yLOMuxN+H+WTwNokwagIjy/IEoceaJaosPEsPWiyN/KnUA+rjXU+4/d35KnDUE2bcpuChs23inhQ1P2mo4H6VUyILdxknwBXJ0FXtRwpOLmdwnk99sKLrUY9//Lng98rU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqpdnboAv7dpSFi3DphiOCIPkRy4Dib/6tsMr6pdbTM=;
 b=KsdQf5W0BiZreOcZT1VZjo+E/lPM1TTKqpelBMWqK5BD//ePXXVEQIvGKvtvYTstUzootVE0KpL0OueMsKgYrZwSDvR0D1N6mSj/EUdstWzaCobTpZ/O1pn033UEGsv12WrV7xKLeHPi4lK9xuTJtUcxWnHkqK9YrKUgANA2vzs=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 07:20:26 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::d8b1:41fd:186:5cea]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::d8b1:41fd:186:5cea%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 07:20:26 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>,
        <Kumaravel.Thiagarajan@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v4 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
Thread-Topic: [PATCH v4 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Thread-Index: AQHY9eg4nRgFrIaUSkKybozYyfIND6457HCAgAWsSLA=
Date:   Tue, 15 Nov 2022 07:20:25 +0000
Message-ID: <PH7PR11MB59582DB8BA01F82441DF04439B049@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221111161130.2043882-1-kumaravel.thiagarajan@microchip.com>
 <20221111161130.2043882-2-kumaravel.thiagarajan@microchip.com>
 <Y256r//s3DCBI07+@smile.fi.intel.com>
In-Reply-To: <Y256r//s3DCBI07+@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|SJ0PR11MB5600:EE_
x-ms-office365-filtering-correlation-id: 51f37cc2-ead5-44be-44d6-08dac6d9dde7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OfKCBMJF66jcgry+NfhM4mAA/tiXsGmfROtXvQWHFRD5Lcio/TGyX/THEPjYZwjP1OytMAofQq37Q2JXmH6WktQ46AXHrD42wSDdVVuLSXaVQvSRCbRHpve9iQiFtoubvNQiQEcn7rmE0khlrZRhkGHGqrZ+SU3BvXtf3PKMSQiEr6ZXHVJP+JAITnkx3NRTlTkV5y3jOnZayvr4TZLN5CYpzWUwjMW5S70RBiz2m/4eFXkLP6Yy0vIeUIjmPl2zypc+/6DgFpG/ESurzjtw/iQxDxIAaSItC2BCp8CXZkOruDImCPddwyVn/rqzhYq5zeCDz74GWumb6S4khr9oI2mYwGDjKfM5qjX81vBdgM9N7MHqYfqXDCavf9vWYm28iAZ+XFPGdPg4B0d4zw5lXnKl/VBYgAtiSE66eAYceI/a+gnxGVI6qmDPUrYmSSMGFAD1eHsOIcgsRv9Z7h86hL/AfbnFoS6rVwiA9bEDTeFiHxb8en1LazGaw4GIJbFvRmc6YDoxlybtRav9jC7kGQh5aAMTTz1oHSCsjtI71V6nsW9p+zd3my21U5e7rrShRh0XDSuR52/LuHhCGDmQrXNUuafqQJJ/mj1UvNqFUS0UE8Wkz4xMXQZCcTt6A/dbEnB9yEa1rBcPEEpy3ZzJWdmS47zJ+0C1xvI/cobGmxguZGVDXJIkvGoP7QLpTn6FxLTZxvKdeN7cDRuAIIuh1Bo4mLaVHVfb/6vbM0eYUBWjRiNZHAZMNPz4tvYGm6aH17jzfZWVC6XF/RvwJRw1br4BbydLvcdu7B+aYHMlwZnEubioripFBHEXJwOp6pRprc20xZvPeoIHLf2g1fTleg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(4744005)(7416002)(5660300002)(71200400001)(2906002)(41300700001)(4326008)(8676002)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(316002)(54906003)(110136005)(6636002)(7696005)(6506007)(107886003)(86362001)(53546011)(186003)(9686003)(478600001)(26005)(52536014)(8936002)(122000001)(33656002)(55016003)(38070700005)(38100700002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pXslXioYBv4F+e8qHLKhDd+7P+0dc9kw2toMo62tV8wE8NUqEg4ZEs+AQr0O?=
 =?us-ascii?Q?dD1N8jjl729bfJOhBqmy7KxWKsmsT+pwAXuZTKnVYzDr7tmbL0GMs8RwlV18?=
 =?us-ascii?Q?TOLLJYRNylQZ8hTw0mzvkVXy5NTrEEKX7SNUxWBeolR9S3RSkv3fFv8SxF8a?=
 =?us-ascii?Q?jN0QIJ7mTJ1u5JcFInLCJU87SfnmjmqqBnvUr7QoOsq8N3ViBUuOLn9DwQp0?=
 =?us-ascii?Q?MwOQ4MsdpazINVGXbody92+hsxYvIbwC8HGD0J4tUCjwy4qqK/AKU9OiCDp9?=
 =?us-ascii?Q?1KOLrS2rRQHj3tktYqS01BdWWF0Oq/r/VbGRqGc61By8NFW+5XDiSeuQUhpM?=
 =?us-ascii?Q?UPCRTafktWPwHGe5etG5IaJS85o3xMchpsHeDpHMuVSRFViSUQm5UzjTv+FE?=
 =?us-ascii?Q?JirIuNZw88tBrGUyecv1PDw+r3pL/5cs5RKYUHAMAISi3soXerH0CSadpW/b?=
 =?us-ascii?Q?F4Ok9vh7bklOq7rGLoAjTLktnS1d7cxjr8kOoHWuyDeFzX7Yb4dgKpf8r8La?=
 =?us-ascii?Q?MPoiaYer7uUrXH8DhtTPfA5XF8dGmHrvtEAfS+Sj6tiE0hRFZOh+le3KlUkv?=
 =?us-ascii?Q?dX6CWYWO2ZZLWyVwDeQ6mU3CIBudk0C0K3tY9nwp5jfe1ofpqhP7xPE/fRSC?=
 =?us-ascii?Q?l1FDbcOZSWLHHbGakABVs8axngZDD+/Qt8mfZaVxfAA5x4Nh2PNoJx/PxE9W?=
 =?us-ascii?Q?PZSo9w6eA6vW40822qrCU5jMlz2TdxMGqMYLDZ1wT+VWn0QpiKl3HfoCgzJB?=
 =?us-ascii?Q?H9Zns1ywxCwwHKbgSKsI7ICnVpI7fbPNI/ZQXfObtXDfuWiLyGk6UklUp+rO?=
 =?us-ascii?Q?bjdL1AcIIJ4RHVBrYhoYabGh5SqNYMM9VQYRomrnu6foXHmwmaKkGzBdHn9/?=
 =?us-ascii?Q?j+OIgzEbpdJdIWTl5Qb3mDpzwDyYtoegpyYqko1OCsclskUiIcJoGLpzONAS?=
 =?us-ascii?Q?g+gRD6gNrn6CfA50BR/EuyJApmUONMrcT4A872I9r6iZyZszeGxBDgP+hM6E?=
 =?us-ascii?Q?Ycb+H7/eJtyhTZMueaZNXDcW8qi7qJqjBp8SQDbaKvO5YBtQP7xjp4KwTxPU?=
 =?us-ascii?Q?5wKNCS9hMnHmLQr/bLEQOJT88o96gGJFnzDcraX/Xh+fgVLCk/0OJBsBVoVS?=
 =?us-ascii?Q?JAUsIemn1Nv5BrvBRniVH8Pyh1nyXm2V6cYj6ttW2E0KxKwm6HZ0RJ315Yc9?=
 =?us-ascii?Q?foFYc0ot8HePD8xW9UxAqfr/lefXoFnBYTYgOZ30gykgKWnVWzuCLaJ/etxl?=
 =?us-ascii?Q?8ULy95SilARoxDrBiCPiwOHl5MGqLk4e19YDj7vPWxqOfQ4Z9IgxXNWuvj2l?=
 =?us-ascii?Q?8w8tqABTr62uS4it6lhdhU6zJCu4Y+llWjtc6mEd1E/bDUVqpL3IywvjuvOK?=
 =?us-ascii?Q?1//qc+gqS6HH3E0icyozy9ExYmIsuQjv9lyaOrfp794JSQAvakKL/l7nN7wV?=
 =?us-ascii?Q?I7pGLC7fAV4HonO8dIG0WsUcbnAH04xwTfQyfGO2715zTuSMVhEt2b7Ohn2s?=
 =?us-ascii?Q?JqYy7j4uIAjRHrhH2YzhNzhdVhpWIJHHjx5pTWkBcSLHHHhoNOe6F6MXY42N?=
 =?us-ascii?Q?/EkJWb2oy+0LPyCKZphhdqv1DwLdGFuwWPKfOPeLHzRLnL3nHUFo1hNy1c+K?=
 =?us-ascii?Q?xIOyJCVOqjeRVuJrUdSJ1LY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f37cc2-ead5-44be-44d6-08dac6d9dde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 07:20:25.9158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gjcfo8tu/eKCYPZZcqjCh4bhgU3+uMtu2FmkeadxOXUjuutUtQi5qgsYpFvjqb2Lkm8/eCJLjZ/0Ri/VPjn4HJtVLvhbp1GXyzGD5iz7SI+UFFVKXJpBLR0HGvEDk4dG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5600
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
> Sent: Friday, November 11, 2022 10:09 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v4 tty-next 1/3] 8250: microchip: pci1xxxx: Add drive=
r for
> quad-uart support.
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
> > +F:   drivers/tty/serial/8250/8250_pci1xxxx.c
>=20
> Have you checked if 8250_pcilib.c needs to be added to the MAINTAINERS?
> That's why it's better to split that change from this patch.

Hi Andy,
Code in 8250_pcilib.c (serial8250_pci_serial_port API) is taken from 8250_p=
ci.c which is under copyright of Russell King. In the maintainers file, I w=
as not able to find 8250_pci.c. Since, it is not developed by us, it is not=
 optimal to add this file under 'MICROCHIP PCIe UART DRIVER'  section. Wher=
e would you suggest adding this new file (8250_pcilib.c) in the Maintainers=
 file?

Thanks,
Tharun Kumar P
