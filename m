Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56259641C58
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 11:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiLDKjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 05:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLDKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 05:39:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9604C12AFC;
        Sun,  4 Dec 2022 02:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670150355; x=1701686355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LV92hQSnLSeA2JBqB2AD4Ja9HpvFbErUltp7RgsWfeI=;
  b=DyDysx5nhGUDEIS+c9VD7GfH5qrFFsypgPDVtImAuO7vz6ZHgFvUyq3G
   NcyU+7mLZnv4txpTHEOzhkyu8mR+kAjtZNdu5B8nlzV6WMONLB1TRprzW
   1aUho6CrhvEETcC9CyzsTh27Xk8hOmeLu3qiGWF6ZOyUWwq63M3HJu8vl
   0prX20mCrtOsQSewKmd660VZPa+qTV6hGUxoXReT8g5IcmEqzwhfdFnWV
   nz3AgrLxlSmnp0nZ6CSbnO+j+zK+pAyi4zWkfwz7o/ODRDvCxxxyd+TIb
   I3w/kmzT2vPqPKAJz1SqgPGK266G2uXWiyyvMqH+R3XmoKJdPUb1FI/VN
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; 
   d="scan'208";a="189924020"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Dec 2022 03:39:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 4 Dec 2022 03:39:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sun, 4 Dec 2022 03:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT3gJk8XtfKK7yMiHlGGg/8OAKXGiEuEGkXMYTRxmXSn6LUEIbGsafACYHBXIn5Jp/Q3eQdzHI7AVJru9+AuHr3zHTcafR8aNGeGwce3wzPADqkcALnc6yCLVG1xHpmvqW7T3NTzqYbrtEG4BVA4CTCVjFhc6qfMgfgby/55EBzNqk1koCJ+ItSzCtDriu9sf+J/xZbcBArrhRgKVpZvfxft+30FeXgfQxd03Qf8hIrOtAHuXmTVwFEpReNL3Che1yCDPcimFpYH+M8gh9sOH+0p5vzGW6yHO8IiTkJJPYTq4izm1z4VQ5bDWh180tna53N08PCTiqs5MJkLPFFKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNzwDTG51cX39Sh97eLs7+2Uxm0ntJGA+DWdDFBH4Bw=;
 b=Q4Zkm8m+ylq2hJvqc4WI+OQCl14qioaMrR5MaHWLNX9KLLorTpTH/N3EXsffulBAJzMUX2pRB7ov3JABEDODRS7B2zHgihGkeaCOGmds6zmWeVjuu+pqx5N8xXA6LQDk0RxLXdCB2igY4I19TGEqYBOPp5gjGCvvEFsYDAJchwUEi4gB+jahI3+pPq2/jC2DBEvd8xmreqIUujXugKRP0bunfHXSjCjhJ1ARe4BWY16ourvEIfSRHH48MyEwd0+ib2mq0b4stoQTn/snHlfkpebp0uGwQELzEWjj7WmVkxWuUzLpE3R7zrcznT7z9j5woF1prApptUfVJzBzqgWlKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNzwDTG51cX39Sh97eLs7+2Uxm0ntJGA+DWdDFBH4Bw=;
 b=CzJksYj+I8rM2z1IrMI2eVXxdXTlSqXLfeG/7kZwZ5k3xVTbbM0ZdC31iQ+AihQ/2VFtzm5cMF61qtpyFzteO3ItqPADomdt+HvueiwJwEcJDYyvHrT5XCbdPW2VtiuTTQmVbn+RN4TCDgmZ+3s7dwi5w/ftcYtWHGWFXvDKz4w=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by CY5PR11MB6234.namprd11.prod.outlook.com (2603:10b6:930:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Sun, 4 Dec
 2022 10:39:10 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%9]) with mapi id 15.20.5880.011; Sun, 4 Dec 2022
 10:39:09 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>,
        <Kumaravel.Thiagarajan@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <macro@orcam.me.uk>,
        <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>, <colin.i.king@gmail.com>
Subject: RE: [PATCH v6 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support.
Thread-Topic: [PATCH v6 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support.
Thread-Index: AQHZBUCRCt8OI9hKyEiqCIdkYKoOua5Yxz6AgATG/YA=
Date:   Sun, 4 Dec 2022 10:39:09 +0000
Message-ID: <PH7PR11MB5958B95CBD036C6A4EB8E76B9B199@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
 <20221201045146.1055913-3-kumaravel.thiagarajan@microchip.com>
 <79c14380-2cf4-108c-544b-98a84e5e251e@linux.intel.com>
In-Reply-To: <79c14380-2cf4-108c-544b-98a84e5e251e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|CY5PR11MB6234:EE_
x-ms-office365-filtering-correlation-id: 6a4c8cce-38af-46d5-ceb0-08dad5e3c6a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hA351eo1xhoJx7vPMfaf5X2q0ctg77QisJ/OpVziSEzO1js4zRLCPyUl5gSJrLSl0WtrASZ2CL05je+8UlcEH7GLJSJJIZLYlooRtxshEdgIzNKYGHmJRHCZSKAa2XHiFDDxG4NZUzh7j93gqy15Z7o7uwWyTbc2w2+CNIGrk0JTJfMXD8WvkxBMDjgVYcttQ/wFSkSUpujky6JbUKaIekgUJL+8G5AaVgz38J6pw4gi/NWRN+7r3+cX2JicFX57tG4BQYthYPXZCJJ8RDUobIEy1UH+Me3D4agD5x2+hxYAGXfLOd6UjAG+qF6Es4hVzG9AyM11wS6tzAGSAW8ewnWDznD4jpid02rQryPwZ4njBS2/oBjL4rtDi54AaZuLWFSDr3fprIO1DyfB5cUQJEWOyjspfaub2/ut9TsoGqVQuyMZsDxwEHYkwzKpc67owaIluVH5lvkNp3KgQhSxCZUlV8hWPkCCQMlXLnvrQYkarRSDhFobgqwgmqH+Uc0jxHdxPxA8yieTod3mm98iyv+rj3sT8xAK2wW8rO8fLsw3AZs5bbtyUijD22UI1GAuTOixQYuyvPTR7LoFFLuw/tGSichrH+QBkxdFzfbyszaqVRFONdrXaAQnus4vAOhI2j3F4/yr8lrZT+6NBEFT45MOgIQ/nQjwXIa4YSrc25hBZQXYJRuu2KKIJW6d2N0k1uHK4REHVfA5AuEP9uXCvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(38070700005)(55016003)(33656002)(54906003)(66946007)(110136005)(4744005)(7696005)(7416002)(52536014)(478600001)(41300700001)(8936002)(8676002)(5660300002)(2906002)(66446008)(76116006)(9686003)(66476007)(64756008)(66556008)(6506007)(86362001)(53546011)(26005)(38100700002)(6636002)(4326008)(316002)(122000001)(186003)(71200400001)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6ImBHmnqqvUiGPJ5UgVZjwW44dDbmVDOtKCI7jaFQMQv7cQIT4ZbhnbOfZ?=
 =?iso-8859-1?Q?4a9Laeor4/JX6p08AQZuyZqZBRYLJ2PAbxZUmtt7uBl2RljKoQjHXVvOpy?=
 =?iso-8859-1?Q?tAdOo3xzpmNc0I6vSLWrOD1/4vZsE52IOdOlM8S7K4VW47y2WhutTx9r3c?=
 =?iso-8859-1?Q?zB2RjuIYSOxBRMy6Gyba7zFT7z86EX+t873G5PVdfoeZ3pNw/qaq0U/DcR?=
 =?iso-8859-1?Q?3YauEFtMNiu0zNYArBygJp/fPpfxDUhTMdWUIn62lTOdiWMI6lV5k/dh8n?=
 =?iso-8859-1?Q?+o3XzGglqCzFWzm6F2v+DfsgqPz6rj9Nnyj5Q1Sb/GZ29XcFfxSbeJWEXw?=
 =?iso-8859-1?Q?gk7zT9ZX64K8z3t6GjmEBMdKEW9qsQKooJbEACw4faGrEIaY7WPmuTKQKT?=
 =?iso-8859-1?Q?CxSgtWjqmEVOfpDG/t+v196dM9BWqeaDjsmXRRQQ/I19+htZwblmfCN8ad?=
 =?iso-8859-1?Q?4K48Um1qMfgiTmD4hf0T9VsHOBSokSI0QdEGVfeJBsX0yPwNSGTc+zzl9c?=
 =?iso-8859-1?Q?GiaLX4aA9NGuq2RufXj6irtDHXNNk/YwpBIomxGMb7eXRZpc455Apvjmsp?=
 =?iso-8859-1?Q?f96V+mmOh6/3LVAo1cG3Mm6ICCICyBuOk2tnwU+M2PPSmeXN8MC1jnCBhC?=
 =?iso-8859-1?Q?Fu7ZmxMwXYit78cnRxzmN1iM8diYiWpd/0EU0uTtX3FJDPmHcZFhsUKtNZ?=
 =?iso-8859-1?Q?zn/i8x/Srb6A2uTjLwTA3OmoRMsjcBOEHWkc6kl3DZYbbIIAXyo1gGITEj?=
 =?iso-8859-1?Q?8qMErIzmDm8oFuIWAFXZNbXMe32A79DjojNu/hOCE6mTqtwI1eI0OusqYP?=
 =?iso-8859-1?Q?J5fk9/rx0l/a4QzEHzupn2D0z6/Jm9AL6Iwmo0lkK4Xl4MsN0X7/67N4Ph?=
 =?iso-8859-1?Q?eykuiS4oGLHq3QZnbk1UZpYPANiuWUFvj+64cCYUo7PDul5GLsKuC89qZO?=
 =?iso-8859-1?Q?gwn3dMD43s0ZLpNIXXI33k6T+ZY4EFx2rYp1lr5OxPh11OEnM3PhUE/kIM?=
 =?iso-8859-1?Q?HzYF5duV6Ul7xkVYi2cuXmTuna0N2zpd3wZLZ+3rqyVlvON9B47CfJaNOG?=
 =?iso-8859-1?Q?2DWuEF/dkRSKswTE6JADDN5EUBcrUMVIApA1EtKOfsXPb2wcfYS1vCjkUc?=
 =?iso-8859-1?Q?wVAI6tlyArPLLIFX+E5HJMtPLnG4Sp/SdHuKO+51Xd34CJX7xtNpM4+joG?=
 =?iso-8859-1?Q?EF6Y0fFlE1DToX1DsMigw/LaHEoaXulAeSqKkMmTOuQ+3Nzebw2iND0u1o?=
 =?iso-8859-1?Q?ux6io/5bzgiyIWtCwum76t0qg51lcJZx6A6Q0U78W24+8bqaENIJwHbLcJ?=
 =?iso-8859-1?Q?OTq8C1q8+64TMb2DLyZMZCuhPnUfh70W91JwF33G50EPJos5OttmBi3VB9?=
 =?iso-8859-1?Q?pgmR5n9txSAm3E8PoksaC6Aw94a/CHaiyj4P6xAIv1ecGKrsC+K8wi8JQE?=
 =?iso-8859-1?Q?qyUesg24lBnzuZg78IPH/OnWV91pgC6cK0g+rx6RqN91Ga9asFvmJO54Qe?=
 =?iso-8859-1?Q?zWwWMZXvIEGoHR8wU3hcADHWCbF376A4iO/QXIsPqlZqq0sReOU4LIufHS?=
 =?iso-8859-1?Q?nJuBoSK5QrRIijjutzN9KZvQ211zgYNuDxjIsG2RqrU1ZjDv74NLc02Upr?=
 =?iso-8859-1?Q?JPTawVvzAMwDIQGF9kNLsXCWdD93liCouz19cNvloN/o0C9BhIOphGPNW2?=
 =?iso-8859-1?Q?2zOmY8W+3V8mRyVhTRI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4c8cce-38af-46d5-ceb0-08dad5e3c6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2022 10:39:09.3031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXUDXZojnj2u5D3mPBYrx32ou5PfowgsWzO2JGutpr5hG3T8gPEiW3buV60yI22psogTlXNobnHMNHwn41Dg1Fuc/pCM7FQ2A3KriykE2Nzu467Ys7YEj3smnJCFcM/f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6234
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Thursday, December 1, 2022 3:10 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v6 tty-next 2/4] serial: 8250_pci1xxxx: Add driver fo=
r
> quad-uart support.
>=20
> > +             {3, -1, -1, -1} /* PCI1p3 */
>=20
> Add comma also to the last item.
>=20
> This array can go outside of function's scope.

Okay, I will create a new function get_physical_port and declare static arr=
ay inside the function.
I will call the function to get value from the array whenever required. The=
 scope of the function
Will be throughout the file.

Thanks,
Tharun Kumar P
