Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC83E64565D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLGJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLGJV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:21:29 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EEA2F8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:21:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tva+Fv7oLyLj67MVf1lh5J44a2feyM2cbYuaopCqI8KohFB89Qiaj6H1+PEoUEqflkzuWyAHoZhRcWiT1e7pUwYMNQH8HS7wr3zkBQFGMSKza90UJMi23qjmDBWsovDUVEDyo8wzSNibxAopibGWpraGnGYlB+wdR+oCq8hX+FMJHJSg0X79urw41gP3CS0GW82lse4PVv/ngRujiNfIau1X9990aL97ckVD9uPj/+I4Lni4sTYooLe7dKP1wfF/LoOhZKInH/VIqGy8t3Q78UKEaO3Hpy1O/ceZDl7QK++uE4shZ8+SOkADvsyIQxpvFro0t25OHfigSborCSMCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IajKgWxUQaImbYgkesR4u1xc3CzaHFIPOSOClS0BHqA=;
 b=O3NqOojS8f9J4dF1mQXOem39gb2BVmyO5xzlimPCfnrDHjTtvjO/Sy4gBlMqP0cTmriYZz32Iy0Ca4RBWf6vw2nCQdy72cJ/oUJ8Ug1F6A+Tbe82JrTHsgJyac2OJ9h/uB2Od3ad1HTyCZ6tEl4X7j3bb+WSO1qetskokn3Yttw0t8t0+ZQU+DkimcOkuxnYegBRZl6/QamwLSc546pA7DZ3ztFdjUQjRsPkIsg0Q3rF/Kv2gQsWVwc38FDFcFjPexCvec1LgcZSMXkah93ccRaecywvrqtE7Ciu5+TleBr/xX8JRp1NWkGutBIP2rmKe7NbSX+wcwD78kUixu30Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IajKgWxUQaImbYgkesR4u1xc3CzaHFIPOSOClS0BHqA=;
 b=FmXtlrCnjPtqy6oRJta8Yz5nWUHn2oxQ5vfwpunYonQaXKwQETvznP6CrC1fMYfAGY8ptxOblB9KJeoJ0HNLMBBcw4jhdyFasxNJULZ4qiVI8NAaUlBIfcTNTTDpVHkcERgXVrHegis7V1FYszVk+RuiorNuvElkQ5lpbJhafSc=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 09:21:23 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::62a0:674e:ffe6:fd9d]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::62a0:674e:ffe6:fd9d%8]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 09:21:23 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>
Subject: RE: [PATCH] phy: xilinx: phy-zynqmp: dynamic clock support for
 power-save
Thread-Topic: [PATCH] phy: xilinx: phy-zynqmp: dynamic clock support for
 power-save
Thread-Index: AQHYxEzLO8kPLQOEdUinB8ZW4dRjaa3n71yAgAA8TxCAABnZgIB4kb6w
Date:   Wed, 7 Dec 2022 09:21:23 +0000
Message-ID: <MN2PR12MB43339B1089E1CF552152DA2D881A9@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20220909130442.1337970-1-piyush.mehta@amd.com>
 <Yylgi+E2BAStgkEx@matsya>
 <MN2PR12MB433380451E7C3F6D6C332973884C9@MN2PR12MB4333.namprd12.prod.outlook.com>
 <Yymo0TvtOPY2ffNN@matsya>
In-Reply-To: <Yymo0TvtOPY2ffNN@matsya>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: vkoul@kernel.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|BL0PR12MB4900:EE_
x-ms-office365-filtering-correlation-id: d638b311-cee2-4fdd-9cb4-08dad8346903
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cHPDbcFtAn1gvluZwGiw/ntvgPu49MTfJs4szAGJFU88JoWPIXvpsRR5eU09c5+YF1h10XlZZT/pBUCaURKD2eqIiHbeKrDAN+u9bvnZ8CdO/j8dAlSSU/XUT6rs7UrfM2HBDXVEGGe5CIR3YQ2CUiNfH2gj/NZcSSvoFwf2Ri26LvzTeS/ctaqe5s9PrdQU92gP9LYtuElDcmLAUwh43Q0VK50o7oyiRSUcRIHLCYY+/sScEtUQOa785G4RQ2GG+BVJXc5MPW31sAxd6H1TQ61DExzVjFomq8QrNr3fGOorHeg8aR1Rj9J6ZvCk0qlH1uZqeA9sSAeHhhdeAgqWXf/7j0jDvSPWkVVoNIXDn/Xqq1xmVltwOViXk8QC02Sx2SkZsJH9UiXJxC29Q++1eSeukT+Q3vRb3q89WWqu/eVsRGSkoPiyLtvv1l4B8xPatj3VwKzYsQuydHD+fxQnHfSM4Rk5FqRZAp0sukCgJAP6MzcL7GJofAy7Qm5zFNzO1hQn2rNeFHkQPJbHdmxBjFM7znRUQZ/3XzVQi+/uIJuf0Gn26lVwZAa5oTcTj21YbUKWdudoq8e5elpzZrF4C3v6xpV0x86ywfPnUmBGIpqxv5nx4oFGEtPejGUZyhbs6Z2fWa8knOKupe5yTCK9NzVhLjHjIFmj2isSbilx5F9XqvOzLpnk9P2INYNhIb+XEmSGNJxOducEJuy7k3HyVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(76116006)(83380400001)(7696005)(38070700005)(6506007)(2906002)(71200400001)(54906003)(6916009)(186003)(86362001)(30864003)(41300700001)(316002)(53546011)(52536014)(5660300002)(8936002)(9686003)(64756008)(66446008)(66946007)(33656002)(66556008)(66476007)(122000001)(55016003)(478600001)(8676002)(4326008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GPRPObCJf3I7jkYUj9J0tZHn5snaSTfK2em7AnYykCf1zfOKphEFDEtbZMiV?=
 =?us-ascii?Q?MJgbCJjJRutGxLOOxRHVouR34Iq5nLeQEemRD6X9DQ5nxa2NLW/n5+g3hPCL?=
 =?us-ascii?Q?VhvVdYGExbp1dLYz7GNUkK/NXbB9gCrUebs/PrMiNRYqO0V2208C7esAoHlb?=
 =?us-ascii?Q?wptt340luao62YyBfqJcp73VX2nVewtbBhsdOBdq6+fBoL9Lk+/LDxiVTxhv?=
 =?us-ascii?Q?cU5+xMo6TtU4FoxVg1WYnh5pavL/BnH9c7HAL0CpPWhvsPAsEfWre8jLmZXD?=
 =?us-ascii?Q?Z78WO3HOLIjCorNteBInPqg2wd6VRZulGBb186Qe9D6Nt5u+VRiOv59Ij26y?=
 =?us-ascii?Q?6imMEG7M1xR1ZYRdAhZYKv9Kam84jsyy49SYRmIvfRMcZUFH6y4ta1acI/7X?=
 =?us-ascii?Q?M85iSXFt0J0UVRUGPBVxL6EjvVGE9F7qMSnSfpkCJ7MIPM8AHwJnbPDWj4vq?=
 =?us-ascii?Q?j1c4OCy3j2IJAjUmHpCt4wbiY1CkSjL3tjnxIdy7lBhaAo3tL16H/0yl3cuw?=
 =?us-ascii?Q?muRybTyrStziDi4dyACelSrkiW4azs8b96E0hEfYKxZ+DIX6Lwx9A9A0Ij5f?=
 =?us-ascii?Q?/CjOOORdH8+jLyMdf+HNudij5yGxAROmqzVKLeLVTwDBv914mMgZrhfIbhCI?=
 =?us-ascii?Q?RcvlsZwVFzRHFJYS1KUJGfL9E9IUuPw4Y5sp7JNL3RWlgZtnWFYTaHyAH3wz?=
 =?us-ascii?Q?AEFWZQvsZ6dW79TBtOTGxLdOIYRG+6ur6Pxfrm5sWsJJnFBq0y9311fpf+cd?=
 =?us-ascii?Q?s2WimIrBNQdqI84k0BdKHPVLCfbLTKL64/oALPkmvnmC+Oi8IMEQkChzjeJ6?=
 =?us-ascii?Q?vhaLM0CRlY1XRXSGkcZBLhOoZGof3UJceSEcCxvc0oaT0GTlWx4pQlWXLtgS?=
 =?us-ascii?Q?zQUJ9GxkDQRYClq/nySq7TdI6bS0Y+ajA6HnmQ7fY3qpqo7C7VPH4jafQqN8?=
 =?us-ascii?Q?E/JKQUI7B9gV2xOX7vhBo96cYXpPYPZScLAzvzSzPU/rZu+CYMOI9WNBHaBu?=
 =?us-ascii?Q?vGRfU5IjIFuFdLYJVwhvJ0N6qKmb8szbO/j39dJhA9VVafKB+zPm0s9uXT/I?=
 =?us-ascii?Q?u7vleUzuQFInWY7OfzYvQaqtVbioLRPaC2LpgndmfjYiSIiq8Bim5VyX2ntB?=
 =?us-ascii?Q?PCXbW9w4j5KL4lXnYQte5xk4xXH94b76JQqNmGh5W/PBLyJr6kyW3zzUYRWs?=
 =?us-ascii?Q?hx1Gw3OCiHazJbFqLyKa/NtpcBJsQvaLgT61FSW5Obi/KCS+YTiqIuTuYXFO?=
 =?us-ascii?Q?8kRea5pezo6/cv6V0sb+zOWbnwzRYkRH7m06tF5jRPdUut5g3XzHKDGAjDQ9?=
 =?us-ascii?Q?v8xNhfhj3iO8MvpWfn6C9PdxfD092BiAfUdnFy3+SpUtNVdkz2s/3YMmV9n3?=
 =?us-ascii?Q?3q4Ue1WEz3BZIOwiO1xEXasaWz/0nCq3vheM4cK5VCNO8DTuTn3uh11Xb1b0?=
 =?us-ascii?Q?16HKXXW9fIsjHAb6MgoQ89forJLpeg1thqyc33bOu2Jt6yvxov85EKqkqqj6?=
 =?us-ascii?Q?qe2D6bxHQDLDCMR8XDMSzJw5lS49fbgBONfzF7OA7kqZOJ0OpaQXBDE10oqu?=
 =?us-ascii?Q?1Z0nmoGWT8MuHH+y0N+xKJ6L2h+7F39UodUlNkQYUYUpB/e/ooWbFJw7DRjb?=
 =?us-ascii?Q?IrPGipC/mdh6uRWAEYA7zSY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d638b311-cee2-4fdd-9cb4-08dad8346903
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 09:21:23.7464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eJxWPOI+/dBPzbwJrXWuSn5Ct9tLZ6Ai+ONdMsOtVpogtHHIV8leeNjZdvUOT0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
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
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, September 20, 2022 5:20 PM
> To: Mehta, Piyush <piyush.mehta@amd.com>
> Cc: laurent.pinchart@ideasonboard.com; kishon@ti.com;
> michal.simek@xilinx.com; Simek, Michal <michal.simek@amd.com>; linux-
> kernel@vger.kernel.org; linux-phy@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>; Paladugu, Siv=
a
> Durga Prasad <siva.durga.prasad.paladugu@amd.com>
> Subject: Re: [PATCH] phy: xilinx: phy-zynqmp: dynamic clock support for
> power-save
>=20
> On 20-09-22, 10:38, Mehta, Piyush wrote:
> > Hello @Vinod Koul,
> >
> > Thanks for review comments.
> > Please find my inline comments below with tag [Piyush].
>=20
> Please _do_ _not_ _top_ _post_
>=20
> And learn how to reply upstream. Am sure there at people at AMD/Xilinx
> who know this..
>=20
>=20
> >
> > Regards,
> > Piyush Mehta
> >
> > > -----Original Message-----
> > > From: Vinod Koul <vkoul@kernel.org>
> > > Sent: Tuesday, September 20, 2022 12:11 PM
> > > To: Mehta, Piyush <piyush.mehta@amd.com>
> > > Cc: laurent.pinchart@ideasonboard.com; kishon@ti.com;
> > > michal.simek@xilinx.com; Simek, Michal <michal.simek@amd.com>;
> > > linux- kernel@vger.kernel.org; linux-phy@lists.infradead.org;
> > > linux-arm- kernel@lists.infradead.org; git (AMD-Xilinx)
> > > <git@amd.com>; Paladugu, Siva Durga Prasad
> > > <siva.durga.prasad.paladugu@amd.com>
> > > Subject: Re: [PATCH] phy: xilinx: phy-zynqmp: dynamic clock support
> > > for power-save
> > >
> > > On 09-09-22, 18:34, Piyush Mehta wrote:
> > > > Enabling clock for all the lanes, consuming power even PHY is
> > > > active or not.
> > >
> > > Pls consider revision to:
> > > Enabling clock for all the lanes consumes power even PHY is active or
> idle..
> > [Piyush]:  will address in next version of patch.
> >
> > >
> > > >
> > > > To resolve the above issue and power saving,made clock
> > > > enabled/disabled based on active PHYs on call of phy_init/phy_exit.
> > >
> > > To resolve this, enable/disable clocks in phy_init/phy_exit
> > [Piyush]:  will address in next version of patch.
> >
> > >
> > > > By default clock is disabled for all the lanes. Whenever phy_init
> > > > called from USB, SATA, SGMII, or display driver, it enabled the
> > > > required clock for requested lane. On phy_exit cycle, it disabled
> > > > clock for the active PHYs.
> > > >
> > > > During the suspend/resume cycle, each USB/ SATA/ SGMII/ display
> > > > driver called phy_exit/phy_init individually. it disabled clock on
> > > > exit, and enabled on initialization for the active PHYs.
> > > >
> > > > Active PHY configuration depends on the peripheral DT node status,
> > > > like USB DT node status 'okay' then driver enabled clock for the
> > > > USB configured lane.
> > > >
> > > > Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> > > > ---
> > > >  drivers/phy/xilinx/phy-zynqmp.c | 59
> > > > ++++++++-------------------------
> > > >  1 file changed, 14 insertions(+), 45 deletions(-)
> > > >
> > > > diff --git a/drivers/phy/xilinx/phy-zynqmp.c
> > > > b/drivers/phy/xilinx/phy-zynqmp.c index 9be9535ad7ab..912c4defdf8d
> > > > 100644
> > > > --- a/drivers/phy/xilinx/phy-zynqmp.c
> > > > +++ b/drivers/phy/xilinx/phy-zynqmp.c
> > > > @@ -572,6 +572,10 @@ static int xpsgtr_phy_init(struct phy *phy)
> > > >
> > > >  	mutex_lock(&gtr_dev->gtr_mutex);
> > > >
> > > > +	/* Configure and enable the clock when peripheral phy_init call
> > > > +*/
> > >
> > > when peripheral invokes phy_init
> > >
> > > > +	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->lane]))
> > > > +		goto out;
> > > > +
> > > >  	/* Skip initialization if not required. */
> > > >  	if (!xpsgtr_phy_init_required(gtr_phy))
> > > >  		goto out;
> > > > @@ -616,9 +620,13 @@ static int xpsgtr_phy_init(struct phy *phy)
> > > > static int xpsgtr_phy_exit(struct phy *phy)  {
> > > >  	struct xpsgtr_phy *gtr_phy =3D phy_get_drvdata(phy);
> > > > +	struct xpsgtr_dev *gtr_dev =3D gtr_phy->dev;
> > > >
> > > >  	gtr_phy->skip_phy_init =3D false;
> > > >
> > > > +	/* Ensure that disable clock only, which configure for lane */
> > > > +	clk_disable_unprepare(gtr_dev->clk[gtr_phy->lane]);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -824,15 +832,11 @@ static struct phy *xpsgtr_xlate(struct
> > > > device *dev,  static int __maybe_unused xpsgtr_suspend(struct devic=
e
> *dev)  {
> > > >  	struct xpsgtr_dev *gtr_dev =3D dev_get_drvdata(dev);
> > > > -	unsigned int i;
> > > >
> > > >  	/* Save the snapshot ICM_CFG registers. */
> > > >  	gtr_dev->saved_icm_cfg0 =3D xpsgtr_read(gtr_dev, ICM_CFG0);
> > > >  	gtr_dev->saved_icm_cfg1 =3D xpsgtr_read(gtr_dev, ICM_CFG1);
> > > >
> > > > -	for (i =3D 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> > > > -		clk_disable_unprepare(gtr_dev->clk[i]);
> > > > -
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -842,13 +846,6 @@ static int __maybe_unused
> > > > xpsgtr_resume(struct
> > > device *dev)
> > > >  	unsigned int icm_cfg0, icm_cfg1;
> > > >  	unsigned int i;
> > > >  	bool skip_phy_init;
> > > > -	int err;
> > > > -
> > > > -	for (i =3D 0; i < ARRAY_SIZE(gtr_dev->clk); i++) {
> > > > -		err =3D clk_prepare_enable(gtr_dev->clk[i]);
> > > > -		if (err)
> > > > -			goto err_clk_put;
> > > > -	}
> > >
> > > hold on, why is this being removed from suspend/resume?
> >
> >
> > [Piyush]:
> > Now, each peripheral driver calls phy_exit/phy_init in suspend/resume,
> and respective active driver will do clock enable and disable.
> >
> > In above xpsgtr resume calls, by default all the clock enabled for all =
the
> lanes, that consumes power even PHY is active or not.
> > So, the clock will be enabled only for active PHY in the phy_init and d=
isabled
> in phy_exit. Clock enabling is not required at multiple times.
>=20
> Learn to use a proper Linux MUA while replying on mail lists
>=20
> on you comment:
> 1. leaving clock on all the time does not sound right to me 2. why not en=
able
> pm_runtime for this driver and do better with power

Enable pm_runtime support:

We have a fixed clock for the GT lanes, as earlier explained GT specific cl=
ock is enabled on phy
initialization of the active state of peripheral (node status =3D "Okay"), =
and disabled on exit.

For pm_runtime design support:

static int __maybe_unused xpsgtr_runtime_suspend(struct device *dev) {
	return 0;
}

static int __maybe_unused xpsgtr_runtime_resume(struct device *dev) {
	return 0;
}

static int __maybe_unused xpsgtr_runtime_idle(struct device *dev) {
	pm_runtime_mark_last_busy(dev);
	pm_runtime_autosuspend(dev);
	return 0;
}

static const struct dev_pm_ops xpsgtr_pm_ops =3D {
	SET_RUNTIME_PM_OPS(xpsgtr_runtime_suspend,
			   xpsgtr_runtime_resume, xpsgtr_runtime_idle)
 };

We don't enable/disable the clock on suspend/resume calls, so is it accepta=
ble to have empty PM ops (xpsgtr_runtime_suspend / xpsgtr_runtime_resume)?

 3. Changes need to be
> documented in changelog, this was not explained in log so unexpected

I will rephrase the commit description to have a detailed description.

>=20
> >
> > >
> > > >
> > > >  	icm_cfg0 =3D xpsgtr_read(gtr_dev, ICM_CFG0);
> > > >  	icm_cfg1 =3D xpsgtr_read(gtr_dev, ICM_CFG1); @@ -869,12 +866,6
> > > @@
> > > > static int __maybe_unused xpsgtr_resume(struct device *dev)
> > > >  		gtr_dev->phys[i].skip_phy_init =3D skip_phy_init;
> > > >
> > > >  	return 0;
> > > > -
> > > > -err_clk_put:
> > > > -	while (i--)
> > > > -		clk_disable_unprepare(gtr_dev->clk[i]);
> > > > -
> > > > -	return err;
> > > >  }
> > > >
> > > >  static const struct dev_pm_ops xpsgtr_pm_ops =3D { @@ -888,7 +879,=
6
> > > > @@ static const struct dev_pm_ops xpsgtr_pm_ops =3D {  static int
> > > > xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)  {
> > > >  	unsigned int refclk;
> > > > -	int ret;
> > > >
> > > >  	for (refclk =3D 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++r=
efclk) {
> > > >  		unsigned long rate;
> > > > @@ -899,19 +889,14 @@ static int xpsgtr_get_ref_clocks(struct
> > > > xpsgtr_dev
> > > *gtr_dev)
> > > >  		snprintf(name, sizeof(name), "ref%u", refclk);
> > > >  		clk =3D devm_clk_get_optional(gtr_dev->dev, name);
> > > >  		if (IS_ERR(clk)) {
> > > > -			ret =3D dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> > > > -					    "Failed to get reference clock
> > > %u\n",
> > > > -					    refclk);
> > > > -			goto err_clk_put;
> > > > +			return dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> > > > +					     "Failed to get ref clock %u\n",
> > > > +					     refclk);
> > > >  		}
> > > >
> > > >  		if (!clk)
> > > >  			continue;
> > > >
> > > > -		ret =3D clk_prepare_enable(clk);
> > > > -		if (ret)
> > > > -			goto err_clk_put;
> > > > -
> > > >  		gtr_dev->clk[refclk] =3D clk;
> > > >
> > > >  		/*
> > > > @@ -931,18 +916,11 @@ static int xpsgtr_get_ref_clocks(struct
> > > > xpsgtr_dev
> > > *gtr_dev)
> > > >  			dev_err(gtr_dev->dev,
> > > >  				"Invalid rate %lu for reference clock %u\n",
> > > >  				rate, refclk);
> > > > -			ret =3D -EINVAL;
> > > > -			goto err_clk_put;
> > > > +			return -EINVAL;
> > > >  		}
> > > >  	}
> > > >
> > > >  	return 0;
> > > > -
> > > > -err_clk_put:
> > > > -	while (refclk--)
> > > > -		clk_disable_unprepare(gtr_dev->clk[refclk]);
> > > > -
> > > > -	return ret;
> > > >  }
> > > >
> > > >  static int xpsgtr_probe(struct platform_device *pdev) @@ -951,7
> > > > +929,6 @@ static int xpsgtr_probe(struct platform_device *pdev)
> > > >  	struct xpsgtr_dev *gtr_dev;
> > > >  	struct phy_provider *provider;
> > > >  	unsigned int port;
> > > > -	unsigned int i;
> > > >  	int ret;
> > > >
> > > >  	gtr_dev =3D devm_kzalloc(&pdev->dev, sizeof(*gtr_dev),
> > > > GFP_KERNEL);
> > > @@
> > > > -991,8 +968,7 @@ static int xpsgtr_probe(struct platform_device
> *pdev)
> > > >  		phy =3D devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
> > > >  		if (IS_ERR(phy)) {
> > > >  			dev_err(&pdev->dev, "failed to create PHY\n");
> > > > -			ret =3D PTR_ERR(phy);
> > > > -			goto err_clk_put;
> > > > +			return PTR_ERR(phy);
> > > >  		}
> > > >
> > > >  		gtr_phy->phy =3D phy;
> > > > @@ -1003,16 +979,9 @@ static int xpsgtr_probe(struct
> > > > platform_device
> > > *pdev)
> > > >  	provider =3D devm_of_phy_provider_register(&pdev->dev,
> > > xpsgtr_xlate);
> > > >  	if (IS_ERR(provider)) {
> > > >  		dev_err(&pdev->dev, "registering provider failed\n");
> > > > -		ret =3D PTR_ERR(provider);
> > > > -		goto err_clk_put;
> > > > +		return PTR_ERR(provider);
> > > >  	}
> > > >  	return 0;
> > > > -
> > > > -err_clk_put:
> > > > -	for (i =3D 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> > > > -		clk_disable_unprepare(gtr_dev->clk[i]);
> > > > -
> > > > -	return ret;
> > > >  }
> > > >
> > > >  static const struct of_device_id xpsgtr_of_match[] =3D {
> > > > --
> > > > 2.25.1
> > >
> > > --
> > > ~Vinod
>=20
> --
> ~Vinod

Regards,
Piyush Mehta
