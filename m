Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4962F19C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbiKRJm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbiKRJl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:41:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F6893CF0;
        Fri, 18 Nov 2022 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668764440; x=1700300440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xQQCjcxAmzFTEjdwWeYygMiVWKbIYFzEsXVo0iTOe2A=;
  b=WXu/A34hDAqIb0g/99BID3hPjD8KlD579NexfbHXFQ2yxxk20Rbk8lel
   tqpf7VScgqz5y5/Q3SkyIr+0IB0/+7OOn8bQ5XzVMMIzVXgoc+yv0UUPr
   2SKUvFc+sftti/duQYa9FJ0J63yTXoUIazQsWIDrSdeuwN7UzLBcQqKCu
   TY0Z1tOqpviw9gS9isoqc2HTXZUleQSYyl00cIfN+NLs3Q2d9XZnN53KD
   2JQIJAz8t8pxZn8kKXWoFhDX1m9CXhw5O76rE523xmYR3TqDT3xlH/EGU
   MoCa/VvkP+QS4q5bgCUeGpXEikAPfyiNYb2/b4I95p0NSDNkJ+BEK8Jba
   w==;
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="189509367"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2022 02:40:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 18 Nov 2022 02:40:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 18 Nov 2022 02:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th102hy8vBxs3B/VvCyb25vJtrlBAyE8ciTFHNjsf1ahQ6ewMbPaFq0SjAzYHdwuBmp9nvgzPSsa621smqghxurIEVbeUSiduHY0PrdIwgPLDJ+fD3Thz2yJVhDVkuwg0vds6+agTYxJ0bnuWuIj/DmF/ezNeDRnBIJm080537Q0YLJlmgASmp441uQrUWhqZC1iZzA72qEAwPJU1ElaQ5a9Vm7Z0Gcw3M1si6AusNSJnyOA+Hw7GBUCB+ZvSQ9WFUk3j18gghrTmzJbizDn8S5Mpqd3v35oZKFcr6upoOGRMCz1RiSDl9w33hJrCfuPN+ltaJpQ/cTYjIufM1biBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQQCjcxAmzFTEjdwWeYygMiVWKbIYFzEsXVo0iTOe2A=;
 b=cl+lSZDKT+zQY6VRhRQNDSXPK1E3E58IgERVoEHAg2j1ejVTXstiJQ0TFdHwC9XyBI09YQoMGeEX4P/6TJ7tAeEBKBOFjNDXoQEsUElvTdkBqgr7DMeR+G4apOxfGcTbdEMIAV+7vc4k6oSeQuHP8ddZYr628bCLjz1jxDOpQij0jnGv1uyHSKb4uYBP6292pgcju54/Zan0d3VY6xRSqWcSZ5HYrhHMUXEmIpJSrI+l+OuVP239bNH4iwWzDyuNX/JkNv0h0Lbhlk6KtQuNHMn+3HnlrW5BTV1VXDjwIqe4q7j8N0JOo8gsHxeWBiCh4OxYb+oioizP4+c7nlLrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQQCjcxAmzFTEjdwWeYygMiVWKbIYFzEsXVo0iTOe2A=;
 b=If7SnGq3odorpm13w3dLhzgdUcayAAbmtKdOk5NOyEacm0gw3ldza+nxS4jH+LlF5iEViWRbS7Hm8XC00Y5Z/uEY/vRwtKjCk6PuKJMPC/UfmccaxzDtuwDVtu+e41xXZO1D0fvheW0MkNHR4xKjfzzS/LnEvm2vTvTY9KUFUeI=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 09:40:37 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::d8b1:41fd:186:5cea]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::d8b1:41fd:186:5cea%4]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 09:40:37 +0000
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
        <UNGLinuxDriver@microchip.com>, <colin.i.king@gmail.com>
Subject: RE: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Thread-Topic: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Thread-Index: AQHY+kGgCkN3Fu7q/kCCsjfnk+kA+a5CrryAgAG/arA=
Date:   Fri, 18 Nov 2022 09:40:37 +0000
Message-ID: <PH7PR11MB59582CE57CE17F20A041157F9B099@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
 <20221117050126.2966714-3-kumaravel.thiagarajan@microchip.com>
 <Y3Xa9fRP3GGygiVj@smile.fi.intel.com>
In-Reply-To: <Y3Xa9fRP3GGygiVj@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|PH8PR11MB6731:EE_
x-ms-office365-filtering-correlation-id: 7f5a775a-9d80-4f02-aa51-08dac948f2b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HCHkp7pJ2Tkauzv5+ZdBeUWN18gT0DwklP61G/ydAl4IpqJAXU821+coxUC/shzfrVvb9Mn8bF2QogB979fsE/J2zYwA+hl1pzN32ulJBYU56TpIOv4Xmi3LQzMCisD42J5gVsIv9G1I+gSL82pYgE490cHBZh7u+qB0EtReOM2jQAsXKL85y27ng+t5waPbAQHy2csksK437YtYDRUhI3f0peiVA0Urp9A0IVo434MbQbc6Z4w+kKOnqyVSSRUCZQmKCuQlPUAhzLZ54QooJv+xvnbsAp/j+hMyn/5ES/lonl9fNeyWwHALvhFs8u+8SjkrsB6wEB2zgMX+8vqJNYKQRT7sRpie+6HhLy/tilI8y1hyRHV30wVqLlTmQpFuzPTeLefP70V0MxEYlKl8tsvjfDYA0CBiZrY8wgC/S3wfhI1Vwo/hyMHyT+f8LAk/l3Bql3M++QLSwVnsqF4dlk7RzR1fmhGAJRt1bQ6l2nNvg7sgTHSLvJUGdZE4ToBWURdwhQ796DsER9y2LrHEDOavNL3XQdKLEHvyEnTlZ6o3dGhI9LOzBkQL5M4pwhOJ936fkvc6bVqTy/jm1Ba3zMhmCB9NFQrnmXirkWiLIZKt9Nh2c9sCfgeWSclP04Wf+MTEfY+zNwPHm7b52vpvvjCkYeP+4JGHSlYXQdooju8TkcaLcHM7jBgw+fGrdvO8vnnARKAJKAtZYAJxcs2KJjJlaziyJoUNKxqBjFeQyWfIXjqj4eaE0skBOTcaqJfER730L64SWiCkCEW1UiPR1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(83380400001)(9686003)(7696005)(6506007)(186003)(26005)(86362001)(55016003)(38070700005)(33656002)(122000001)(38100700002)(110136005)(2906002)(316002)(6636002)(54906003)(8676002)(4326008)(5660300002)(66446008)(66476007)(66556008)(64756008)(41300700001)(4744005)(8936002)(7416002)(76116006)(66946007)(52536014)(478600001)(71200400001)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g5XJOH6R7tRAaCsupLMVi4FFACGrljfKleikfsPMz6RlsNAtfLK/W7dvGsXW?=
 =?us-ascii?Q?x7cky8F9lHQ2KVjwfuknPfMKyxmbDV0bfHk0YtXL3+FseCRHbfwBbTL16opR?=
 =?us-ascii?Q?cOLHPOm8jYgfLi7OyPRH+tkmYoVrTazyAd3KfTn+O72PrZAXydGRpqx7SIpx?=
 =?us-ascii?Q?iJ82+MJQVjF7Vc8ym3NyrZHsqP0Za9M1NrxyZOEld2u4WJTxyRBjtg/yKoRb?=
 =?us-ascii?Q?6rQiPNZ50/K1l3WbyUpgZMn4PZFNIcbG63+oXM46JQLMpZVLkNf0STEkHhmC?=
 =?us-ascii?Q?eY+50+Qza7ieZqth8YYf/1A8jqLZ629ZdSnKjzNW5LCsnBLbZIf0ys7JU/B4?=
 =?us-ascii?Q?LwQxrxuR6AcGcSrfQikMD0147Xx0ze4PaS6Em74+OZ8VCgmQ900PiXBMAbwf?=
 =?us-ascii?Q?oW62ZTObKyBjHk4vshwJF7nr8ubxx1HgGiMUnmcUglRNHse3xREl+0+TwVRF?=
 =?us-ascii?Q?nZx6irSF3xXCqFteJ2h45x5GnI3AQKLopH2IE2uXUzLLD11VeGUGmPv38w34?=
 =?us-ascii?Q?6iJ20bL/Jbqq8LxYUZKR/UFg2ORR7H3fgAEGlCh6oZohu4ZYdsHtqtp8Jai3?=
 =?us-ascii?Q?pFPsPRXfd3GqHMdwpnMqJySCXYHyhaFGnD3OHMLwj9cHSloPm7ok85z1lpCX?=
 =?us-ascii?Q?vrPwKhZQ2BGqlv6DJ2xFsRS4Wb5ANWgZ6mjjp9dcp8IpJIS2IIbKmaQz/+V2?=
 =?us-ascii?Q?/4e/cwCsEng2QcvsgtvvtB8TEiqTugezuLaq7AiDC85IHTpSZSxZK7FSaCiL?=
 =?us-ascii?Q?Mf9CYJfstxSeNXI0ArVHQuIulI2gh0uHFvjyRXNi/GhyoqdV8mWvUxSrchrq?=
 =?us-ascii?Q?sAOLWl1gjkH06AvLlitDVyK9eljB21jsDsqJRI6PFeJ+jYT8q2k05Juvwb8F?=
 =?us-ascii?Q?AZWFZeBQJZvdn8gj6V7M7XOartOTgwBVF/K6VjrnsiY/oNKmcw9t3lb2fOdF?=
 =?us-ascii?Q?VBz1nO48hpS7yVtsVTnQQNcrGSxI5BmqlSSOQgn0vsvZXPtlgNUovYs6voo8?=
 =?us-ascii?Q?hggT8iudBWgHZgiHiMppznf5FvooHpfLaPwvqpvjrIgh0YtPL5tIKIfWLV9h?=
 =?us-ascii?Q?jayi9LGjNshbmVSA7/ctWR80OrR7T2evN1rHKW5980XUObsYP/v/B3NM6Qyt?=
 =?us-ascii?Q?CRm0KEaJeNh10hUcenaUA1AmwI7azUIrxgAjjLf/XneTOLfPpduOt3Hh6052?=
 =?us-ascii?Q?v61KYDHUBCiO6gS1E4Rd2XiLjNZxowA/Sz3kqT6Sb7nn9DzykgmydFXmj/A9?=
 =?us-ascii?Q?PwLPnj5K7It08AYBMbn0xl4u+DnIQAtNNhhGokHgdutpYo7EDK6L5h+c7bEv?=
 =?us-ascii?Q?+AmWqEHCAnr9nN+XXES3klG/jOv+XshsidSHhzCnqgZxFCXHTCztnBSz/uQx?=
 =?us-ascii?Q?/BmdbiCfrmKuem2pBvX4PqgrGvOklOv3uvsSblGdH4cGHPL71KITxbXjSF3p?=
 =?us-ascii?Q?Z8TKrijEOl7d4sZ/NN81AYUhSabUwcSZtP+F1e6KBtmHYAHLrTMwFY03jJrk?=
 =?us-ascii?Q?LHM7YYwlqU4l7XZAxwPsCqMaiGM0cPXIelOn3rodyhZQwqlGSGDfL9NIPj6V?=
 =?us-ascii?Q?lkdCamvVrSwYakrgtfIY66FC6W50+pHbdC6Eq7tSIsZ1RUiZnYNadHy89mE8?=
 =?us-ascii?Q?X1ubmpYeAEYPoVw1R7tYMiU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5a775a-9d80-4f02-aa51-08dac948f2b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 09:40:37.2880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENjvMM/QLW7IcCpUPifIMZFgwqVubiGVt1PhMIRODMeVBxPr53Y60EIb87Or1qSbYscfA340EaZyaHLuYjfSNe10ltupOMh7get1bgGV1m/QGChamrrqTNEvqCtVj0lp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sent: Thursday, November 17, 2022 12:26 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
> serial8250_pci_setup_port definition in 8250_pcilib.c
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Thu, Nov 17, 2022 at 10:31:24AM +0530, Kumaravel Thiagarajan wrote:
> > Move implementation of setup_port API to serial8250_pci_setup_port
>=20
> Don't you have a dependency issue here?

Okay, I will explain the need for the changes done in commit description.

Thanks,
Tharun Kumar P
