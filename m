Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66686182D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiKCPaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiKCP3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:29:40 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B2F1CB2B;
        Thu,  3 Nov 2022 08:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUODWcfYBsHiMpiNjzaJJfuj27cxOhHozi9t7UAUsWkkOWsJIvUvgbri9hfO+U+TN0C7jG0AZ1RqUyVt7AQ5BQea47hLM6lxXFoZ8nIt1Nev/qBVxw9z/EJ2h+hH/NNmBQ1Eub1pOGTGJM9i+MpQ8hflgaJdHJkjNT/jDozJNGReB+gfmYsNJRhqx2Bxu6hEvuaOxV+81PhXkqQq4kLn2ZYxLhDek5nbVPwuCzmF+AL8d9FFDKt6GUVueCRLMCsmkutA+KmU5dRqZUyFqgjPybblqawMbU7J2AgmgxT2xY4fgNy6Psaa5wB+tb2l3uPei7lL2Z/IB7IxCdi46Jidcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYxnS6zY/vcBWVsxIU/163a21mlWz8gvksItYS23Ncw=;
 b=kh5oWTZsx3VjShWg1XSXgTFujd+C+H9mIFFfpBw4swCJa565qooJ2ehL6fr9vIusp2aNgAsPP5Ixn4oCC/Cc45UOBF6jNm4tXdWl+x7FHxsGBa2iaEJEqeNlR9njxGGG4vdTHSxl0h9Kl9OPVgk00857c5ixRkkdDKRu3v+vwJUWFGcnViM/PMSlB8W1xGG+uDegsG6DPaHwR1e5mFMsOU1IBfVv3iO83rIGOKzWoYQj4pVriXEq6aeKYYPKZ/x2DIzTpcEOrEYlADbNytXSZ95BSf5WTTvV997ol0mE+8hk8DZRGl0y1Jkhiz4I4b+qiJUWcMmUAeEs5VTdcOLhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYxnS6zY/vcBWVsxIU/163a21mlWz8gvksItYS23Ncw=;
 b=H/yY2swTtnb7y0UsGdFnLI3IFRTnzmBUmN8x7uMwSc9FMc2ukQ4GkO3BEXkb4w20oLoaF0a50LH4/hQXFaCErzQ28sPzCaC/OVwM+k+rqm/ofXzEzlJWepGI8lqGT0ZyTW+l3uvMRm1OPswQeUjYk/P54/JsYYxlRupVJP4nErQ=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PA4PR04MB7918.eurprd04.prod.outlook.com (2603:10a6:102:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 15:29:04 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.022; Thu, 3 Nov 2022
 15:29:04 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Jun Li <jun.li@nxp.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "hzpeterchen@gmail.com" <hzpeterchen@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 1/1] usb: cdns3: host: fix endless superspeed
 hub port reset
Thread-Topic: [EXT] Re: [PATCH v2 1/1] usb: cdns3: host: fix endless
 superspeed hub port reset
Thread-Index: AQHY6W5IYTY5uF2C1Eunn77HPj5UCa4h0mAAgAuMaVA=
Date:   Thu, 3 Nov 2022 15:29:04 +0000
Message-ID: <HE1PR0401MB2331E5EA4F974CDADEFAD8E788389@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221026190749.2280367-1-Frank.Li@nxp.com>
 <5877757.lOV4Wx5bFT@steina-w>
In-Reply-To: <5877757.lOV4Wx5bFT@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|PA4PR04MB7918:EE_
x-ms-office365-filtering-correlation-id: bbbe086e-a0ff-4bef-1b84-08dabdb02406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LTaAwJP1WAy6MXkXgLaEiHArUbsGeYdLnXAbDD7xvNwYvrdDAskRrlver0DoKAEWe2uB4+8xi4ovom2zQCvQOCDEueEzhe/xcOQet4wMPc9lJ2edet1yYUkfXihYK6ZXJJvwfjI8qHfxAWVBpx/93kJr7/Tq6ztrT3vp7sEwz/Th7mZd6NWK+sMPhSUQpFvNEPt3X7DRnYh6YBYJ7trZHjkvFRECH9RZQ6RmJT6DU1wOfUjpsHU9CCzdTOdjtLyZkSPjTQlXDT/YGNgCRNC3De3ZnNfBrTQAw46PgzxUiAeSaEMUWbbhp+0QtH1MA9j1PWyX5qx8dVMZM2vPWMfn6uN1Z0FIIEGtMqcPhXR1OeadHXsMTD4xrc+tm61L3ucZvDDR2ibDL6OCrUvsYGSHkztQYxVj6sTC8tNwmuhQx1qxJAJHVsTJrO1jmi39r6woXPsz8HXM7UJzXeI0Zw3Vvm7QzsvxuV9VNyIjTej/8m8jF8B8H6eTiU28qErOtFCrJQx6snweqznJ4EJI/3+8Nljr2ewFZjbP9jPErSLYumgDmgyfq4IlCopSMUhMwXkdigGo8q+pJn84HX9uCveL3gJirZcrZXftkDw+a171J0OWoHxz5Juo3dn9QNsDmpH6CpL6gRjAV5hn7xVobbmfjZtjWUUSndwYCe5hC8QNCsNmLAnC3I9D6wmMn4L367MuBJFF++RhaoX4YwNUh82AD0qftLYpQOnR5461ZL7hqrF1cWuWLVKpMqsvl9zZJXx9B0+X8x84MmsmRHYTF4GUtDOzYWd0MqQcLciH6JIBc44=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(38070700005)(66476007)(33656002)(8676002)(55016003)(83380400001)(86362001)(71200400001)(44832011)(478600001)(6506007)(2906002)(7696005)(316002)(38100700002)(64756008)(66446008)(4326008)(76116006)(66946007)(5660300002)(8936002)(52536014)(7416002)(66556008)(41300700001)(54906003)(110136005)(26005)(55236004)(53546011)(9686003)(122000001)(186003)(84970400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?drs6rHhpnBdPN0cYOy3NVPv1G6VaP004qRixpP2s9K8RP/4jjA96bDJ9VMvD?=
 =?us-ascii?Q?5Ejv6b9wIpQgBWWzpwoKvmj5q6I4Uo52W1k+YXaOzHAQ4qMkpfoHJlSYyMAM?=
 =?us-ascii?Q?XdC0obHSO3q8f8nuR4a7UDIQUPfy0t3Smte6/0iC2qIv0H/h53+DKjuOBwby?=
 =?us-ascii?Q?bg9vXrzIc5ckwnNdqOOEGUFGoydbyK+swIxuw4k9Viz6wRaykRSWxAKCg2Ev?=
 =?us-ascii?Q?WfRKi0PKrx9Oj6/dMli48Gv411zSUrHJP9GwF3+At9f+CDyakgnIqAfnJhMa?=
 =?us-ascii?Q?3Ahzhh3uXmEOuRqv4dXhvKUC8Nd4QC2M9Gl5yNBuZzaBx16oDax2w0MqXsoV?=
 =?us-ascii?Q?Yv+STAoayzUBC+VNoemkK+vG5LLn7MyGphZ3LMRdKv1KymTCgCv57eNkbWKK?=
 =?us-ascii?Q?EvfnjPs1IL+YZrZfc/hljbY9b4wsJE8aB+Cr4DW9BVKNS6R2Ou7pnygRq2AY?=
 =?us-ascii?Q?5kFXY/98zW88p93vvjm9dhdGGgjIruNyyz8yEbrGp/ZUicyDBPBpoqx+v82m?=
 =?us-ascii?Q?6DLOknXYdMA9htdl1CN5ko+4FhANJJMQwcV95ZcSU5XY7tigi2OKqEnrfF8e?=
 =?us-ascii?Q?eNpKfTeuz4Ub0pGNpwr3dbdHbtq5UgL4kdJ2AJTXwhHi34lEMW8qLl8YvC6B?=
 =?us-ascii?Q?ZahhJ5r4XSFNZoXYZV7dkEg0Y+8MSTqy5/hZ05G1jwkYJmVkBzq/r917sGKG?=
 =?us-ascii?Q?h/VLem5NODwfrDZj4nTZXw5Fv/soMIcQCq1RLFcapsjl4WpLXZPqYrdo6PWo?=
 =?us-ascii?Q?vh/fHf3Be/jpRB3PPI4atDX/uJsyl5kj4YDgCTWwe7Hq/X+bFGUaMeO8oj9P?=
 =?us-ascii?Q?Fy82wzEjNXtXDj2E/qTL4oWyJncyb7gGMScztDb9Z+9GffaMF+lwfh3Ijz5C?=
 =?us-ascii?Q?uims4yUeLCHS5f69o6Hvgql6NRJlbyl2D7YF1DHsHnKc0r6napA1y28baI26?=
 =?us-ascii?Q?XVycHYqfKZBR31lnKd+5WagnzB3IHUgYFmlzJiOTXGo6p+k6DVr6BiObxpbc?=
 =?us-ascii?Q?AJwCQ0DrH1sjHDA4ucE9fWT2PCe8Nl/HNL1iIa3Lu2OTUaPqeOYarccF++3u?=
 =?us-ascii?Q?qp+W2HDoibPVXuX2aFLjYWsf3E3BSjLKQGHGvXGybFNSzxgdVRvuOArdePOO?=
 =?us-ascii?Q?DnQ4C/BjZWscs9rpghgA7jBXUrPMBjARA8uicLKc51qoOxMlYELWZuuqUxCt?=
 =?us-ascii?Q?08SHEvPKlgfw46t2QcCLFsbyzzIQWHLiKzKI1qqDhITVszDhFn+HAfqDcd6l?=
 =?us-ascii?Q?waxSUwiMYz7kRF4fxgO3qn5F80MjEugeEA3NleHdLsEbNa7rlCQfffP95Ynv?=
 =?us-ascii?Q?hfz+Z8jPNqL/AUq6Hfiljaqvl+lCcD/j0Q+IIzpWDBQlcBW/OSnZtuKYxBlt?=
 =?us-ascii?Q?ZHMEmnABiRQW1JeRZP/v+ApZMcQvoiTTptfW6cJqgcM0E1Esm92wgcuw7qTs?=
 =?us-ascii?Q?O9Q3rGG7BscUz9+0K/usxW6qx5fUb0tFMhe+0cRYUEAKZSr31cX39VAThP7H?=
 =?us-ascii?Q?by6ln/BA1FAEwL55WCsQC1QsDRGXSXG9s6F0hGMZ0pwXlAxnbP0TA5uGnEWq?=
 =?us-ascii?Q?hIxoxzOrKhKnyzCmUoI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbe086e-a0ff-4bef-1b84-08dabdb02406
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 15:29:04.2151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1rQrZPtGe4EwIQe8GL75ZtE/4seXE8RwT1/RpIlkcx0l5pJf0F7Y2C1iCP/mHOkgW9i61TzZRNIaFxEbATnSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7918
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> Sent: Thursday, October 27, 2022 2:06 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: Jun Li <jun.li@nxp.com>; Frank Li <frank.li@nxp.com>; a-
> govindraju@ti.com; gregkh@linuxfoundation.org; hzpeterchen@gmail.com;
> imx@lists.linux.dev; linux-kernel@vger.kernel.org; linux-
> usb@vger.kernel.org; pawell@cadence.com; peter.chen@kernel.org;
> rogerq@kernel.org; stable@kernel.org
> Subject: [EXT] Re: [PATCH v2 1/1] usb: cdns3: host: fix endless superspee=
d
> hub port reset
>=20
> Caution: EXT Email
>=20
> Am Mittwoch, 26. Oktober 2022, 21:07:49 CEST schrieb Frank Li:
> > From: Li Jun <jun.li@nxp.com>
> >
> > When usb 3.0 hub connect with one USB 2.0 device and NO USB 3.0 device,
> > some usb hub reports endless port reset message.
> >
> > [  190.324169] usb 2-1: new SuperSpeed USB device number 88 using xhci-
> hcd
> > [  190.352834] hub 2-1:1.0: USB hub found
> > [  190.356995] hub 2-1:1.0: 4 ports detected
> > [  190.700056] usb 2-1: USB disconnect, device number 88
> > [  192.472139] usb 2-1: new SuperSpeed USB device number 89 using xhci-
> hcd
> > [  192.500820] hub 2-1:1.0: USB hub found
> > [  192.504977] hub 2-1:1.0: 4 ports detected
> > [  192.852066] usb 2-1: USB disconnect, device number 89
> >
> > The reason is the runtime pm state of USB2.0 port is active and
> > USB 3.0 port is suspend, so parent device is active state.
> >
> >  cat
> > /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-
> hcd.1.auto/usb2/po
> > wer/runtime_status
> >
> >  suspended
> >
> >  cat
> > /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-
> hcd.1.auto/usb1/po
> > wer/runtime_status
> >
> >  active
> >
> >  cat
> > /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-
> hcd.1.auto/power/r
> > untime_status
> >
> >  active
> >
> >  cat
> >
> /sys/bus/platform/devices/5b110000.usb/5b130000.usb/power/runtime_sta
> tus
> >
> >  active
> >
> > So xhci_cdns3_suspend_quirk() have not called. U3 configure is not appl=
ied.
> >
> > move U3 configure into host start. Reinit again in resume function in c=
ase
> > controller power lost during suspend.
> >
> > Cc: stable@vger.kernel.org 5.10
> > Signed-off-by: Li Jun <jun.li@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---

[Frank Li] @greg, friendly ping.

> >
> > Change from V1 to V2.
> >  - call xhci_cdns3_plat_start() in xhci_cdns3_resume_quirk
> > in case power lost during suspend
> >
> >  drivers/usb/cdns3/host.c | 56 ++++++++++++++++++++--------------------
> >  1 file changed, 28 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> > index 9643b905e2d8..6164fc4c96a4 100644
> > --- a/drivers/usb/cdns3/host.c
> > +++ b/drivers/usb/cdns3/host.c
> > @@ -24,11 +24,37 @@
> >  #define CFG_RXDET_P3_EN              BIT(15)
> >  #define LPM_2_STB_SWITCH_EN  BIT(25)
> >
> > -static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd);
> > +static void xhci_cdns3_plat_start(struct usb_hcd *hcd)
> > +{
> > +     struct xhci_hcd *xhci =3D hcd_to_xhci(hcd);
> > +     u32 value;
> > +
> > +     /* set usbcmd.EU3S */
> > +     value =3D readl(&xhci->op_regs->command);
> > +     value |=3D CMD_PM_INDEX;
> > +     writel(value, &xhci->op_regs->command);
> > +
> > +     if (hcd->regs) {
> > +             value =3D readl(hcd->regs + XECP_AUX_CTRL_REG1);
> > +             value |=3D CFG_RXDET_P3_EN;
> > +             writel(value, hcd->regs + XECP_AUX_CTRL_REG1);
> > +
> > +             value =3D readl(hcd->regs + XECP_PORT_CAP_REG);
> > +             value |=3D LPM_2_STB_SWITCH_EN;
> > +             writel(value, hcd->regs + XECP_PORT_CAP_REG);
> > +     }
> > +}
> > +
> > +static int xhci_cdns3_resume_quirk(struct usb_hcd *hcd)
> > +{
> > +     xhci_cdns3_plat_start(hcd);
> > +     return 0;
> > +}
> >
> >  static const struct xhci_plat_priv xhci_plat_cdns3_xhci =3D {
> >       .quirks =3D XHCI_SKIP_PHY_INIT | XHCI_AVOID_BEI,
> > -     .suspend_quirk =3D xhci_cdns3_suspend_quirk,
> > +     .plat_start =3D xhci_cdns3_plat_start,
> > +     .resume_quirk =3D xhci_cdns3_resume_quirk,
> >  };
> >
> >  static int __cdns_host_init(struct cdns *cdns)
> > @@ -90,32 +116,6 @@ static int __cdns_host_init(struct cdns *cdns)
> >       return ret;
> >  }
> >
> > -static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
> > -{
> > -     struct xhci_hcd *xhci =3D hcd_to_xhci(hcd);
> > -     u32 value;
> > -
> > -     if (pm_runtime_status_suspended(hcd->self.controller))
> > -             return 0;
> > -
> > -     /* set usbcmd.EU3S */
> > -     value =3D readl(&xhci->op_regs->command);
> > -     value |=3D CMD_PM_INDEX;
> > -     writel(value, &xhci->op_regs->command);
> > -
> > -     if (hcd->regs) {
> > -             value =3D readl(hcd->regs + XECP_AUX_CTRL_REG1);
> > -             value |=3D CFG_RXDET_P3_EN;
> > -             writel(value, hcd->regs + XECP_AUX_CTRL_REG1);
> > -
> > -             value =3D readl(hcd->regs + XECP_PORT_CAP_REG);
> > -             value |=3D LPM_2_STB_SWITCH_EN;
> > -             writel(value, hcd->regs + XECP_PORT_CAP_REG);
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  static void cdns_host_exit(struct cdns *cdns)
> >  {
> >       kfree(cdns->xhci_plat_data);
>=20
> Although I could only test it on v5.15 downstream kernel
> Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
>=20

