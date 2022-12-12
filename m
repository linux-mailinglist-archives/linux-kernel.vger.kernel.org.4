Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F164996A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiLLHRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLLHRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:17:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207EC959B;
        Sun, 11 Dec 2022 23:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670829419; x=1702365419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bFgMO3IVpnhcqzRQxeZnVQ95+y+RRZXXXMeJALRxyjY=;
  b=PM914bLT4cZ+cVYLr3LWEiooF1FAaQe8ul50OqB2G3sREXrlRETCHo4T
   BMZYoEgf5IJO5nObwTF84pbvvmSsVo6ZHuQ6ah5WuvH1bYCtz65bZS+0L
   dJJ01tGyexb8EAOM7JhtTcDisa/RQ3FZwx0psboO0EMMJ5LaMDPCOHzQs
   4ljK2ZyTtyO+4hYjzFmmaWHV/H74obiAn5hhmUeGRvw8+tpt2dc5+AgnR
   evnHgJ5W+SLIdTXNWO/YCH2SAofxHXMwa8tNcjehYL+1R3r1uHGoChpOG
   La5jXC5l9H6pLzUAnSRq74L+PcJE1MXKZsBwrdbf8/PrP6VMKFVIee/QS
   w==;
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="127631766"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Dec 2022 00:16:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 00:16:58 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 00:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLE9rkcw46r4PZJsFvdHj6uN20D5uZYcbujLwdbiQSHwk0ebtpeo0SN0KtFIlFnJLa3PHfeD0VXaAKrpd6kmuLW584mF4T2wRdvJKei1P0+ggC6K78PObcdMwhoLTHi5SDUl2Hzw8vbnHyHWIZ+vwskU07jNDvbor4vearZA0faSpPsPJ8cW/8FU4DLKsWgrXsLvloWSUNAcjs3tyremp+zUCuw95Qg9lV5qLJnHFnYZitckDdpkiTTn4hnlfWDL3DKyoyQmQHjLHO9esARh097WQ+9QeyaL+Cu/qrerfqMr4a8SCJNJCR0JUT2WNop7QD8a+bYOaAXic2H4Jgd61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhLf4+YuGcGqvTbg10QNyJ5Mh56mYx3OcuG0l4CV0ek=;
 b=Ae9FXrIuNbZXuegYO28o2VYrFVBGKrJhqw5KF2wQTJLCIXqEAoRdfJb+xj1vOHIB+rP2oXQpJzsrEYZ8kMc9SP33F/wXRBtl1PU5oOPoI57iu8fKR6uiJTr6yrW9SP8ZpJb80wJvUokqOZNRHRDGnsrx6LhU0lg211YY0WFFZZ9Oy5oqbxzonDrhOdpssGoTU6/kDwXhJu+vDhyywZrlDYVqiN8x5b652GSzBxIM/R9UHSZV8rJX2qQajlPebV24tZoHEiRSGkXY6dCxcs+h1SiVTWTA0aaz29fFcEUtK2BV8pvH0tEnPH6cPrLxOJ9LrlMchfl7z3+Dzc1bD647OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhLf4+YuGcGqvTbg10QNyJ5Mh56mYx3OcuG0l4CV0ek=;
 b=K55yWajd9JmuTHvYqVBs3Jiedxh4Tc07Bk0eF/LuULEvtScWjsEDINbN/fGfzFIpWaDvax8aQnScz7Ay2trMd4ChhzGb88ZAckX/P+cB+IdKhEletBEBpGWkUP2sYkkPUIOPMOpulDftQYlmZiSf9pf5ELoC/WTscrOOI1Nk8cY=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by SJ0PR11MB5814.namprd11.prod.outlook.com (2603:10b6:a03:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 07:16:56 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 07:16:55 +0000
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
Subject: RE: [PATCH v8 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Topic: [PATCH v8 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Index: AQHZDJkj7rnAVfXmX0mY3XTqVMobIK5nn64AgAI24uA=
Date:   Mon, 12 Dec 2022 07:16:55 +0000
Message-ID: <PH7PR11MB5958DC96634CFF28AFA8695D9BE29@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221211014730.1233272-1-kumaravel.thiagarajan@microchip.com>
 <20221211014730.1233272-3-kumaravel.thiagarajan@microchip.com>
 <Y5T2ymgsCQhggtvz@smile.fi.intel.com>
In-Reply-To: <Y5T2ymgsCQhggtvz@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|SJ0PR11MB5814:EE_
x-ms-office365-filtering-correlation-id: 904ff5ff-18a5-4a87-0183-08dadc10d9df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WPqb+452FPkWnz4H3XSOxJQRmLW1H7PjsPQnElXPnodoaO8MFBSBxy9gdquV3UM4Ulqo+BNTdghNjkW/MtW9EN4/EAlpju9f1O1ln/DgHT9TRruC/4PJzrSaCHO4WpRsdJFEYnh9a16Iy3+btzyUrRoe7y2ZfGbGqnsG+tqXdmmFWQvtDgXMNSW64DTLKwlk5AbwvUaqNDylr9JpbCj7zFuFBvTRdupnwEDmgapIxubPOZSUjYKfyn06w81jCYgjdv0/spGVdN78HgaR5gPik2d/Tp5sl6/uy+6yneJ8s16yp+0fsB1RTmpIIryZUd6FhZPaJDWKSjRjrHR2s+6ybLQtAgLZlm14+0oWiNDynsnRMFEzIb16YiaqTvx86U23pgbGNppvl4/k/SBe3jEOnj1fI1RK6K6cjj82FJ4XCBsRVkxKIyawhiUiZjXQ/UmqCaFhQ4PWvuUD6RtmfG94vTp5fKobPAQdGAposjOGtmLq0ukpBpz48RkWpiX3/zBjvjDSBVyr2mAM900aPC5Lfc5ZqZFs6K1KZvuZtFm7Zg73YIQSQZBl2MgnUJnqQHK505af8/RYj8AiOLfVKB70m6K5edyRBnPVpvmrMKkU6avu93OfTWR/KjMdZE7c1Obsma+Ai8kGc1nViX1KzubX5SbT363W7I1d8AQaMuLWIe0R9RVtwZPtHQzSRzRF7Fc0qdebQb7gEP1YiNH78llm3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199015)(38070700005)(38100700002)(110136005)(33656002)(86362001)(122000001)(4326008)(8676002)(76116006)(316002)(9686003)(66946007)(71200400001)(6636002)(52536014)(478600001)(7416002)(5660300002)(66556008)(64756008)(66446008)(8936002)(66476007)(41300700001)(55016003)(2906002)(83380400001)(26005)(186003)(54906003)(7696005)(107886003)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3GIdT8rVWUTZRGiivk1feLWra61YSZFNzMXOV/MQbxAX5mBVSfenwElsMn3N?=
 =?us-ascii?Q?1HOMauXiOHvhp134FoHU9ctfpgeYTI+kKZxwJZcGmMcM42cDUoyLqofk7X4v?=
 =?us-ascii?Q?wm6KyWSLZcipNbLVpuBJekqz30lMN2dPPFf29+btXW+aOJrC+p2KgFOfbvz1?=
 =?us-ascii?Q?gOe6BNVUExlLpY0qOExpSnUgID1BsKuCANTtdZOQY/UHiRLM8jy2oxGGQLwL?=
 =?us-ascii?Q?4n1xdydNdVGTzk2dD6Gq2iyy14AestdpHTenvArcATrmYu9qNZlyKJh/1vZt?=
 =?us-ascii?Q?fYOZsKQYJXNTIQbdiV6N0e/2vqayTJdjqVKjulizYbYtp37KhIi5ubRnwWbT?=
 =?us-ascii?Q?FHl7TPq5ceqeu6FXZBpLrZFNpxFfipqVHBs+HRIqWWnzkeKn+I4aQBLTl6QE?=
 =?us-ascii?Q?zwhRk86xv7Rs5n02zBOZQNRCe6Fxhj2OL2l3hLKOW9r60PviTWMELHsEE/PM?=
 =?us-ascii?Q?i873l357wMDhZh4vS22o5lPHjnFw73NBvJVvotZ4L4raIsrCw5AY5//sFlA7?=
 =?us-ascii?Q?25GdG1J4PGYSBffYWftwBu3yPKmRsmF8lArrnw988p/a4GSimiQ532GiKveB?=
 =?us-ascii?Q?fLMZy43q4bsovDTCxzXaPJlh5uh8wQcG7QFTebHFMULXT7+2mksTPfK1LoPb?=
 =?us-ascii?Q?UF8YgKjCrfyDPWW89tmDwX1Q5MKxOD1zQuDvsQLs0L3XHEHHoj7jHLEpOS2t?=
 =?us-ascii?Q?qFWrsv0C0Jecp9v5ucMrLFAhJvMFbTRONBdFYTRQmLa3CGCBrR2NUlSOHw5W?=
 =?us-ascii?Q?0GxYjsVnh33ZqqYr9LEkS2mI7XXQn6bAoQNJrlMXbFomaOBR1PW6+k+VhwNx?=
 =?us-ascii?Q?8xv1gizhaAcrmWT6++wKMZBA9bYPB7BD0XMWCj9Doh4e5/qf8oTac+6ueR2b?=
 =?us-ascii?Q?5bjFZgEz6cIYPVByZsJ0eZfidUwM7ahwr2GvPOllFC0zPjrZYQyIrIV4uX4u?=
 =?us-ascii?Q?AvuveosUZfaht0szPn2zPfk7CmbprIgHt+nnsO+P0LsXYrmZmb+8AYWu0LV1?=
 =?us-ascii?Q?HcC1EwVJCpkElZ6tN2g683bJIJAfk/ZxPXLCx3hFShXRq+NBhp0uBB3JVAD5?=
 =?us-ascii?Q?94jKuB1b053sGXxgPotlrJonjQo1EOTFcch0t3yTNVlSMRIrIp+QcpQtKYcl?=
 =?us-ascii?Q?Hyl0jh0SwRL/9r2mw4Oya0inCLXpoojKVYqnZPA6GkZs5uupOwpKTVV4M7DC?=
 =?us-ascii?Q?Xy/k4BsGiME4Fyxbaacb2yg8A+dnf2WM1aROcgB6nHbVR3An68SPRLozNNRh?=
 =?us-ascii?Q?1NzFLkqUrqmMWSas8vwm53LwL6Cr8dplnQbGTWlw3avwjgpmStmicrcixTk5?=
 =?us-ascii?Q?/7Elh4u6W+tRWmEXrrskDzuMlm5oYwkf+hhm9KARj7RSNcfE5oJPxKMV/5v4?=
 =?us-ascii?Q?P4lc9JMxKIJ0GLUHs7uIqLuD9jCwS+abFg6DdZ6wwWq7KJRT0QgjUj6yhauB?=
 =?us-ascii?Q?ViGvt+h+h9+ydSAstfq54PuQYElareqYSUg2GmXyEH/kkac0vyWOzGegXMrB?=
 =?us-ascii?Q?iImkzPKGEGIBnQvJWYJkzQ3YcbFIJkkaGBrAgFkI/MfyeustiKviGZEXs9z7?=
 =?us-ascii?Q?lukpwngYd0xYef6RMA8nv5m3dAwmOTZOjwexoThJTERuVjttnlyZhNkRAte1?=
 =?us-ascii?Q?k8jcC48vyHe9Oh3DePX5Jw4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904ff5ff-18a5-4a87-0183-08dadc10d9df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 07:16:55.8579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6trd3wXVVmwYX7x21Jea0wO7f/M56yvLHlOGhsYUg3sWcR3Ueh8xrYUxlXRKocEEskkCMNg8kP3Zn65a5+6T71KcR2XdClPZVtxYxUtiC+n6DV91d4y1lpYKqNzCwwVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5814
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
> Sent: Sunday, December 11, 2022 2:45 AM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v8 tty-next 2/4] serial: 8250_pci1xxxx: Add driver fo=
r
> quad-uart support
>=20
> > +             4,/* PCI1p3 */
> > +     };
>=20
> If you move this outside of the function you may use static_assert(), see
> below why.

If you move this outside of the function -> Do you suggest to move the arra=
y outside
the function and make it global?

>=20
>         if (subsys_dev <=3D ARRAY_SIZE(max_port))
>                 return max_port[subsys_dev];
>=20
> (in this case you can make sure it is the same as the above using
> static_assert(), so it won't compile otherwise)

I am not getting this. You suggest doing something like this:
static_assert(subsys_dev <=3D ARRAY_SIZE(max_port)) ?

> > +     priv->membase =3D pcim_iomap(pdev, 0, 0);
>=20
> As you said there will be no hardware that uses IO ports, why do you need
> pci_iomap()? I guess what you may use pci_ioremap_bar().
>=20
> > +     if (!priv->membase)
> > +             return -ENOMEM;

Okay, I will use pci_ioremap_bar(pdev, 0)

> > +     priv->nr =3D nr_ports;
> > +     pci_set_master(pdev);
> > +     max_vec_reqd =3D pci1xxxx_get_max_port(subsys_dev);
>=20
> The above needs a bit of reshuffling and perhaps a blank line or lines.
> Make it ordered and grouped more logically.

Okay. I will do something like this:
	pci_set_master(pdev);
	<NL>
	priv->pdev =3D pdev;
	priv->nr =3D nr_ports;
	<NL>
	subsys_dev =3D priv->pdev->subsystem_device;
	max_vec_reqd =3D pci1xxxx_get_max_port(subsys_dev);
	<NL>
	num_vectors =3D pci_alloc_irq_vectors(pdev, 1, max_vec_reqd, PCI_IRQ_ALL_T=
YPES);
	if (num_vectors < 0)
		return num_vectors;

> Can be simplified a bit by PCI_VDEVICE().

Okay.

Thanks,
Tharun Kumar P
