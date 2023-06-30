Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55937431D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjF3Anh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjF3Ane (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:43:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A302E10C;
        Thu, 29 Jun 2023 17:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688085813; x=1719621813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kmZ1VuGWZ/gpba/Fd4yVSNwbqzv2Ep5cfAupNelklME=;
  b=W3JXu9cqCVwqEUEMZ38yk51G6b03p8EnbYSdbn/5XLNhnnHUuOKliZaH
   Qy2xajDsM2fPOeS372u5v7P/IuVp1RF5rQ2UTW1CwBRkbZV6MyKqwYQgd
   hlkn8MKVLXHGHopHpNR/0PeX4//Kv5pMDC7ePD42CxQN4ZzHve/Mk9cC9
   6kcnztuFf+AOQ7pG95KO2/Z6YPTHORvnV0nwfRbzr+2U13k/W21mmKEAa
   f8VLGi/EX0ixjkMQrETgcrYrBxtoXmRp5AueyFJVL8ue/2EDINZ7Bx8UB
   /8P5jG+vTyk6Fd2Gp2Nm5YAMHeKgdg6hJm1SnJIOga8LbO++cIhx9yfG0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="364851426"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="364851426"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 17:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="717614464"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="717614464"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 29 Jun 2023 17:43:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 17:43:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 17:43:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 17:43:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 17:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir/27YIxQCEC14YwmwBm34RmOjUjlcqeDK5awq31OoYelh67BzI3kJU4U+4jid2rhI2x0wWT/UY1mGlunwtOXW4lN5FkqdyGasZXZ8eDMWU9psEI7Jqgcq5Vg5vx0xw0D4EgPhpVhrp/rszsFm+dymGMzSMeVuRgO8qPNJmqw+MwTNrS3352xBAiezyroqwfBjs2y3OCK3wF52EUTMEDJxV0t2oKtk4IyzZRNtstjoTSOqrH6sn+xNp8yIvQ9LyvH0mR+kGnyCzUiuSrWct/fOnEwdhL4l7mZ4JJQoiieOU8ha6Ceo8xloRWSVRgw4ZJ0To/ac9c/SCyh2j/2pIaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzZ2qb07saQZcYOiA/+MYD1bSaDyT2ZcXrc7zT6ubo8=;
 b=bLhV9vTIMbpIPmNE5A8wXKEJM57bIKr4wnjVpZUHXalRHbAZM/5cml9lhblMMD9tWVJHSYrT4SApWHtvFBr0WGZITSUw8Z0rSAXpibIfeTztbqZ9xjSjP3KeSABSUd6RKkuG11l2xau22YrmBumQidiDUUpZgszLPXG0Z2zpVT0wd6ekzTp/PMpbp2cyhgghE4KrVd/Vj9dioen6UrYYSwC1jRUR2uCyIHkV/z2emHwMMKutYwZ/eVP+4cSuZISJxdXikxhHU0wh8D+krGXCVj4HsOfFbeHGvJT41Jr6l3JanBQfaXj0JvLQgqOGAaGOMncYBjNvbb3DUN+hzYHL8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 00:43:24 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::f070:fc63:a1af:225c]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::f070:fc63:a1af:225c%7]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 00:43:24 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Topic: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Index: AQHZqecsVz9Vq1T91UOKWExVzPdr4a+iDS4AgAByH7A=
Date:   Fri, 30 Jun 2023 00:43:24 +0000
Message-ID: <MWHPR11MB004848F9DD3EE841BCB6F611A92AA@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230628173727.701140-1-utkarsh.h.patel@intel.com>
 <20230628173727.701140-2-utkarsh.h.patel@intel.com>
 <ZJ3BjFExLBWXZxqm@chromium.org>
In-Reply-To: <ZJ3BjFExLBWXZxqm@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|SJ2PR11MB8587:EE_
x-ms-office365-filtering-correlation-id: f0b7b4f1-a048-4c4d-a63e-08db790302f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6h4/mccjwha6k2DocZAu3KRMzESlh+cMh76R8IyLpIMFDKplP0AdzIfuAjV4V+UGtzZISsj/5q2drunss2UEfk1wB9/vZNsDl2Zb7BqTsvGrqd/DCpmejQPjEmzutss50K0Pwh29sN2SOe1e3GesdEYg/KJhGat3uMy91xPi2zMO9+LHZ8VJJAeTY9JJ7VgWo/E5rDXdzW2NPEHHxrAqbsbCMKoHK9x99dsxdFCPIKyw1i8TYr8McaaRO28oa2tgJJdWWCZ+XEZw8oOamRhsQz+IWZC47X8bY5RLvFGAypFT4AIHBfUeWk6eSegqYLZJfctw4ylPCtEAhg0Wkgt97JO8P0nBnjp5TMx7eA1p4s16Hsw+qkrXsLWmkSFiSFzlw1HcCc5YfpK5qR8xVVVTyMhG1xtKIGcWxnC7LN3v1V41BDLzF/Fr7J7qNxson07p7IUeQC7JsLV0NgKyHOVwm3+jzp8dYsPSVeXhntzVaAnVSgnlApWYP2Aq4hWmBVfbDIyqQ0Oy/9GmcUiAbL9nKphMM6ByFgdvCaaODUE2oNA5W6TRi2ZJiv6Mk37nrmiBRrDdWeBB/FUZLptvu4sHhIioq9O16K9SZyNv63Psy/YvX985dW7apfbRqvub1SC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(2906002)(186003)(55016003)(7696005)(71200400001)(122000001)(86362001)(9686003)(38100700002)(82960400001)(26005)(6506007)(41300700001)(54906003)(38070700005)(478600001)(316002)(76116006)(66556008)(66446008)(4326008)(66946007)(33656002)(64756008)(66476007)(6916009)(52536014)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cbcYA6JfVhW3RpROc9QJOr9n73+Xng49tOdijuPQbOXRTG2a23qWzdm90xuN?=
 =?us-ascii?Q?fE6kNkANlu5/AOJYz6dkbBXTqcgsZVgtLLSbhkSFeJxN8zk9I3CfS1IHv+1g?=
 =?us-ascii?Q?ARR9i9qg3Ut9H+C+REp/f6xlZGywkkMZRi+D0TnqJz6WSLV+KWvwLrk7m+P1?=
 =?us-ascii?Q?JzKyMGZYsuIZPYC3M0fY+AYhf96yJMk/6bzbSQf0UZdJK+tYV2ZzGMD56wpi?=
 =?us-ascii?Q?Qcv5ykMBnKVL84f/nxXPgSW5p7X5pF7MAj8vAlN5F5LKuDS8kbKWFJomfs6A?=
 =?us-ascii?Q?31Gj6fUtvrugypONCMtbzaDPxW5eTGfw11w9tHvfsoRwklxviloPdtRLTL2c?=
 =?us-ascii?Q?zmzTnjvnXSCM3nK3eB7lX4qwlv4lPhQ0Ezld+w0z4Otdo1uyg80s8TC8b/AI?=
 =?us-ascii?Q?3Yzy4eQ+Lt4CwedeEH1tiS1SzHDxteIW37ZiGLz/dAEjcb0ExoH0PR4vRK9t?=
 =?us-ascii?Q?P0W86B4Si995eRIcSIlGFaU3pl93ULERNesPJxEukhT3AHs/QI6ZN+WmVLEa?=
 =?us-ascii?Q?v7RvvmBK3BxL+f1AZiux9t21xwJwx6MF4hmNyIKskjs892AJxjo0I7q9aCcE?=
 =?us-ascii?Q?QkAULnr3xUi3nNa0ExfKTDN/im2WRXn1czLGH29J2Pagz9RUz5aWvtdjgtt0?=
 =?us-ascii?Q?5dh8NyjbuGziPzj7lMrOHblGajeWLukR26dtIBDRSWa27l2CyBiEN0x5V0c5?=
 =?us-ascii?Q?gk+QMgqtfSYfNNFPigmUqPNNSVgYYL0Qs6kC/aK74AfPHVx5ZGjvVC8usIwM?=
 =?us-ascii?Q?aPDQIlMz6yRBUPDMSgHzJn9+815gVUE9qHUQLujOlR5+kmirsaqWYfn5jkZ+?=
 =?us-ascii?Q?1aySym4lq1uevhY5lpXRgcsuYXvRakW+YPn23hbx4lbZKuaAL7Rpx8Oc57ZY?=
 =?us-ascii?Q?UiItX16gmN23NW/aSqZVeyssYz0RDMQpvA4hQJvtwl24m3+q8q/I7qoLTL6u?=
 =?us-ascii?Q?EaoCASIL1SVgcjJ3nMdkIYUrg+5pTIA3vN+0D5eaHGiYH6gNK2M+84GjgL7f?=
 =?us-ascii?Q?xQZ7akqTD3sw7kuTm2AfloGxQPQ++mZPVXDztNDeJF/spsdbRmWqQSAV/P1Y?=
 =?us-ascii?Q?LI+uhzkG17He66nxAxYN/nb+feo5I4oTKzrvD9c0K65DxfRQZSM3t0dF3N8i?=
 =?us-ascii?Q?GbIYVNKQP8Mmk31XuDUWoy2AsjDvFlStaOHYn51M7HmQaUHge53xm9pyrT8s?=
 =?us-ascii?Q?Obd4W/QZuACSgMfdJye7BRhyWhAIMDorRhrTRVuBIdOr8v+rjwDCahABZfY8?=
 =?us-ascii?Q?AL41v+d4JySwvUCrqhRwMX1i4nnBc4A4RNORcaFuyxkRfr7OdBA18xV4lJuJ?=
 =?us-ascii?Q?cmpawFYV29T4rwBwsihpO/TvzL7CvG0TlupHCnoMVnurSi7ZJF/MkGld14eB?=
 =?us-ascii?Q?So5botDHFcXHfRoHtfNVUU0kHfb/ysgN2VyELJN70hqh2sPmkMds5EMjdY7e?=
 =?us-ascii?Q?xwXuxa4PV6Kj7L+kG0FZNA/Uz6UTuEZLKWXbg43PaNpycmvPMtCKbhfg/N+p?=
 =?us-ascii?Q?htiSe8cwSvb8zb/CaKTAcwuubp8neexKoH+skeUdgE4x7blvCFi8VTRIW4EU?=
 =?us-ascii?Q?2lDioorjqF5YQcwovbiDXC+uCBbuxiKgmiP1PLjK2Nd6WHoZESiTeggzJt/9?=
 =?us-ascii?Q?Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b7b4f1-a048-4c4d-a63e-08db790302f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 00:43:24.4059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJE75oamF7rPI712UH7cRQRikSzdDZWkmTvE45w+dvnUxWoN9n/jSS1a9ApiRbnCNR9D6IIIameNxYtKNEkIgYFBWbDlI7v6lUjyH9pyvK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8587
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the review and feedback.

> Hi Utkarsh,
>=20
> Thanks for sending the patch.
>=20
> On Jun 28 10:37, Utkarsh Patel wrote:
> > Connector class driver only configure cable type active or passive.
> > With this change it will also configure if the cable type is retimer
> > or
>=20
> nit: Please use imperative form ("Configure if the cable type is...")

Ack.

>=20
> > redriver if required by AP. This detail will be provided as a part of
> > cable discover mode VDO.
> >
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> >

> > +static int cros_typec_get_cable_vdo(struct cros_typec_data *typec, int
> port_num,
> > +				    uint16_t svid)
>=20
> u16 type is used in the kernel.

Ack.=20

>=20
> Also, if this function returns a VDO, the return type should be u32, but.=
.. (see
> later)
>=20
> > +{
> > +	struct cros_typec_port *port =3D typec->ports[port_num];
>=20
> Pass the struct cros_typec_port directly (and then drop the port_num
> argument).

Ack.

>=20
> > +	struct list_head *head =3D &port->plug_mode_list;
> > +	struct cros_typec_altmode_node *node;
> > +
> > +	list_for_each_entry(node, head, list) {
> > +		if (node->amode->svid =3D=3D svid)
> > +			break;
>=20
> Return the vdo here directly; that way, if you reach past the list iterat=
ion, we
> know for sure the SVID wasn't found and you can unconditionally return th=
e
> error case.

Ack.

>=20
> > +	}
> > +
> > +	if (node->amode->svid !=3D svid)
> > +		return 0;
>=20
> I think it is more correct here to have an int return type (so the "not f=
ound"
> case can return -1 or the right error code), and then have the cable VDO =
as a
> pointer argument.

Ack.

> > +	uint32_t cable_vdo;
> u32.

Ack.

>=20
> >  	int ret;
> >
> >  	if (typec->pd_ctrl_ver < 2) {
> > @@ -442,6 +462,11 @@ static int cros_typec_enable_tbt(struct
> > cros_typec_data *typec,
> >
> >  	data.cable_mode |=3D TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
>=20
> Probably a separate patch, but can we get rid of this too, since the cabl=
e_vdo
> should have this information?

Yes, it will need separate patch as there are other capabilities in cable m=
ode and all can be removed once this change goes through.

>=20
> >
> > +	cable_vdo =3D cros_typec_get_cable_vdo(typec, port_num,
> > +USB_TYPEC_TBT_SID);
> > +
> > +	if (cable_vdo & TBT_CABLE_RETIMER)
> > +		data.cable_mode |=3D TBT_CABLE_RETIMER;
>=20
> Why just not or the cable_vdo into existing cable_mode"? :
>=20
> data.cable_mode |=3D cable_vdo;

Agree, with this all other configs for cable mode can be removed and mux dr=
iver will just use cable mode VDO as is.

>=20
> > +
> >  	/* Enter Mode VDO */
> >  	data.enter_vdo =3D TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
> >
> > @@ -513,17 +538,23 @@ static int cros_typec_enable_usb4(struct
> > cros_typec_data *typec,  {
> >  	struct cros_typec_port *port =3D typec->ports[port_num];
> >  	struct enter_usb_data data;
> > +	uint32_t cable_vdo;
>=20
> u32

Ack.

>=20
> >
> >  	data.eudo =3D EUDO_USB_MODE_USB4 << EUDO_USB_MODE_SHIFT;
> >
> > +	cable_vdo =3D cros_typec_get_cable_vdo(typec, port_num,
> > +USB_TYPEC_TBT_SID);
> > +
> >  	/* Cable Speed */
> >  	data.eudo |=3D pd_ctrl->cable_speed << EUDO_CABLE_SPEED_SHIFT;
> >
> >  	/* Cable Type */
> >  	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
> >  		data.eudo |=3D EUDO_CABLE_TYPE_OPTICAL <<
> EUDO_CABLE_TYPE_SHIFT;
> > -	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> > +	else if (cable_vdo & TBT_CABLE_RETIMER)
> >  		data.eudo |=3D EUDO_CABLE_TYPE_RE_TIMER <<
> EUDO_CABLE_TYPE_SHIFT;
> > +	else if (!(cable_vdo & TBT_CABLE_RETIMER) &&
>=20
> The !(cable_vdo & TBT_CABLE_RETIMER) check shouldn't be necessary; the
> earlier "else if" already ensures that by the time we reach here, this cl=
ause is
> satisfied.

Ack.

Sincerely,
Utkarsh Patel.
