Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA7650988
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiLSJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiLSJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:49:51 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBD8A198;
        Mon, 19 Dec 2022 01:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au9iVZEtJNjVn7XyGfi4Os1MyQmA5rSGo2CoP41L1wJuXu9r2oSYs4INCMwY5sH77O6q7qE+vBUsbPpVmPOyz66RNkQXR4xtErb+VrYmuQ5+dD7En5OBgI9LwRyBR01wIeEWERlPOitibX7yfVJjSP0Z4oP+jY/xqWsrvsaAZ6pyFmdFL6HNWDHvVA5juP626OSbFcsuBJqZ0i0KTuNOigwQ14NL1dBrZy9aNbUG1PZkm+A8ON4O6qBSdBJH49skEV/l+AV7+IEVezy4Hi+sIOm9flmmx4oU50IlP6Mx5ZS/6+1o+6LPK4y6r2PG9hS3mEopRtCzUVHnJT76Vr+r6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOZvKclmF1OCLqmKxia5d63lnrr4ju1AoxE58hIRiBM=;
 b=OyS3F9GqHsgC6S3+b2LPE5qv11Tga06sSXua379CNNWlR0TaRTz0gcRw4XQyXa3hE8ZAvtvXZRfEE+VLdWzzLnHdZebaerIHIvAvKquuxPQFHcnhp9NLfZa956pS6fyKQuVp/0rkad9yIZ3UeqaBF2UT+7SbiNCIcpi1NEnGjWV07RiHuJpjj3rqvpu74AXQlXlf/01JZ6vBphOXL+U6vMbMQxuQVn2lTb1JBl7Xh5MGFG6qoVPPe7AGhcjxiaWsKtrRSFSq9XqI1YXzseDri5Or/+C3LP+WWPo7O3bHDXKM6DphOcOmgO9GJ99ZlqeLU8D+78fuFjR/Vxf4ompvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOZvKclmF1OCLqmKxia5d63lnrr4ju1AoxE58hIRiBM=;
 b=FXwIkssQPcUK4TGgc2EXzWiZDaSt0eq/lTp7kjKUSXLhHnD2r6RP+Qy/4zegssCZ6uq0ZlOQvkuC4XUhpjmUQs5GjcCW2fYJ9P6oEFII80TA4ut8PN/3QHDYyfNukyoviUxedkG/S3ZfwL0shoUQLyZqL4qcN3qO+7gFs/q/618=
Received: from DU2PR01MB8034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:273::14) by PA4PR01MB10134.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:263::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 09:49:43 +0000
Received: from DU2PR01MB8034.eurprd01.prod.exchangelabs.com
 ([fe80::d922:93f6:20ed:45d8]) by DU2PR01MB8034.eurprd01.prod.exchangelabs.com
 ([fe80::d922:93f6:20ed:45d8%8]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 09:49:43 +0000
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Ray Chi <raychi@google.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] usb: core: hub: disable autosuspend for TI TUSB8041
Thread-Topic: [PATCH v1] usb: core: hub: disable autosuspend for TI TUSB8041
Thread-Index: AQHZEVkt+jYbVB9ekEOw/M01Qce2ea5wqVmAgARQ+nA=
Date:   Mon, 19 Dec 2022 09:49:43 +0000
Message-ID: <DU2PR01MB8034851942DE30E72080B943F9E59@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
References: <20221216141717.2728340-1-f.suligoi@asem.it>
 <Y5yTm5PsE8n4whq/@rowland.harvard.edu>
In-Reply-To: <Y5yTm5PsE8n4whq/@rowland.harvard.edu>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asem.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR01MB8034:EE_|PA4PR01MB10134:EE_
x-ms-office365-filtering-correlation-id: f08475cb-75f1-4298-18d4-08dae1a65aed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DwGo8fioT+ooRyzJHfb21IhOYTS9Ak9X8lha8fX3QaC0Zh5mGHNxOkSU/KKdy+1IJbeTj3aTul9PMkOzn/bVnef0bVKXqr7G+K2OhMGA/TQbQ0VvDiMExc84VQTdbSTrEDBlTOewYzkK/1EzOPXIEiIzswBFebx1Q+PZ06wHZTuk2s9bHlcb8o28rHPbQcnrAiIi4oVt5tBRnv7VpFQFdfgJV9+VbZsyz/ADKH7nsqfDssh8jkFBzbz86IA1lpbm/jpFXrIxfj5FkdWfl8BqCgdUl2fwb+gHC3y/Vlxn2Z7fM7YokgM3Ew9CWzwh3M2eDvf21bAULbAyPyynMTtSUtcMBf1Z8ruLHkC7fOmTKbmZgH8bD1OdXTPR8JAFHCyXok8S2bz6dpzJ3r+VHEhC3GRkBw42lHQHR4M+FS6vwKDm9spmE+B9rkBWXSckvNl8i6IlqjxFY6KjmLJJ6o1I8FsX0ox+WPcvY2VqxtZT0XhkKP8iXF9E/+Jf56aZBndhBcPuAHkH2XAz+l+ryEH25cWE1HIFWy32f5RXVcJUuTkMHXeSvtGiWUKxYcXxgtemugWudCRGH9jNrqq9l1MSlfG4+nydHVxzL9T/mk2rFfbfe4Lh6+CJOhomJI5Uhf2Ye4iAoEpZUkYVoqeqN0zXTOWToSLBQV9KIVjJBOZtl6U54hdpOyC9r5osyGBOQiD4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR01MB8034.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39840400004)(366004)(346002)(396003)(376002)(451199015)(54906003)(38070700005)(6916009)(6506007)(7696005)(316002)(478600001)(38100700002)(8676002)(4326008)(76116006)(66476007)(86362001)(122000001)(66946007)(64756008)(66556008)(66446008)(71200400001)(5660300002)(4744005)(33656002)(52536014)(8936002)(9686003)(2906002)(41300700001)(186003)(55016003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hUXkSDOnB3cR0iJzMTRPWCXL11M8duIB/T8UKOUFZiMfAVBeUCAJTkeJp/vP?=
 =?us-ascii?Q?cPeprDF/VUScAoc70Jv0Gv13714KDBvpDXJNhN2HQOkB8VwuB36hdQNkDG/K?=
 =?us-ascii?Q?sJ5CFKuuLtWOSyNwTCC//F5viFQAvclN6oyup3d9zg4m9r7AbhwJFcEMAj1t?=
 =?us-ascii?Q?Se4FhOyKwxQ95MyfaVSMr7cFWou4OMz+zuQcUHbFb0w6Zv2Z4TD2EWxI2/vw?=
 =?us-ascii?Q?/TstjhOHB1YPwOtbJS2nNRaEiRR7mKa/jGslkbe+avtVeyQwHf49Wghs4UeW?=
 =?us-ascii?Q?2KHywwM8iFNADMF4vreFYFbkPG9PBzT3NGaFKsKhgYKFVtGwBRPWnEIrdRDA?=
 =?us-ascii?Q?K8b/i9LBNyGfgsDIA5nVaSLLJWnTm9pVy+hxLxRcW/+OWtjmirJH3Y8gycvA?=
 =?us-ascii?Q?Avg6A/EwBEn8hRX9cQCrK5fCkGgCoLwJEwl0Ko/7nPuoiKEA7K5DueLk5noR?=
 =?us-ascii?Q?eL1AI3UuqfPcRrc0wtO0jkm3ZqmDuRB4VPnIuV006x3rPmgARTG3h4stfyXN?=
 =?us-ascii?Q?BLiXl9xHXVK1OiVX6jgpL/TI72JEM6vSci44TSm7+loQs3tQjlL0MMPprzuo?=
 =?us-ascii?Q?HRU2DQW3VpBJECOplEyL5Y/du3DK9/lx1k07ZV4XGT+Nq+Uh/dWv11Ee3e8m?=
 =?us-ascii?Q?iA+lbuyjbClVo5kfJ3sbgy/z9SLLT58rm0NzMXb8VNeOM579GO21k4zG68lR?=
 =?us-ascii?Q?0D7ftLJiss91k+XfL7JriuxDyDItRV1fI7F9ehIUQUrFCpyQuhtBQa3Ujx13?=
 =?us-ascii?Q?MYBZmpKTGUANLvMj8EiNqazYTIojrk3SvPlnyKIKa68guX95lNoTb8EOuKPW?=
 =?us-ascii?Q?qwInBCVhZ4PYvwZZhR4woIDx16KYC8As2sImXHw1lNrLgnYCYBTs1xKfVl7M?=
 =?us-ascii?Q?G/a+D3LxhBbeN6/WGNra7s4W6EP2mTbHzInOesvBaWMlDCQuGRRH0zppstm/?=
 =?us-ascii?Q?tyvqMHYW5tAhf+CmQKVooOTWNKfUL1EAdLCkf6/xna3DzFp6zrjgF+WIiOx6?=
 =?us-ascii?Q?romBCKBmKouXHFWMkFoaKEYNYG36LX55JN9mbAwpCCN/PP3493OUwZCFlDWG?=
 =?us-ascii?Q?gON8Ka9hpZ1kGwO68GnkQVPqHUPhZMvl0UshN5bt6NUKAVQZyV2OI58JA9eE?=
 =?us-ascii?Q?nztOf0UOSmudEzo4JPnuJgwEKRdDwDJ0dK2GOdU68XTNIdKvXuOdrR3S2dow?=
 =?us-ascii?Q?B0YGFd9cRhOKkma/ZDkdfYBafrHwDq+lTbUjVjaSnw33j4XtWMVM2R+S9rdj?=
 =?us-ascii?Q?qxUMxL8G37vTyfwn6JBzabDrtbfSRGbn/TlDM+65Tz6j+2crLBpfns/cB4oM?=
 =?us-ascii?Q?mSIJfDu+9PXowA0jV8R1lwzzNCXbYk3Tz/UwxJTG4xZnKWMGFQIxFel6s6d2?=
 =?us-ascii?Q?UoJB4ftvRWpjhsvzEdqD6ykbfrfGAdPgCsyrXolCGLtd8su9cgRY4TWy8ZeQ?=
 =?us-ascii?Q?eVaJD+JVsA2CI0nCNhdGFbMD5WQYX9mnKMQ6JjY/OuKQ2rX2XpvZ39MeONnq?=
 =?us-ascii?Q?NbkAqqsBUTnASRzeBEUDMhnZcpW3Fub4r98qvjN6SsjVCAhtNspXi+bxo+u8?=
 =?us-ascii?Q?df0de+VpOYlaBk7+X4s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR01MB8034.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08475cb-75f1-4298-18d4-08dae1a65aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 09:49:43.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7Q9g8VqB1k30IyrCmBFxirpflzMdbz8vmnhs1OrrYbSVzpaW/i5ejMXUXlNdTGgDLB//GRnnrmhaBGSeL7DPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR01MB10134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Alan,

...

drivers/usb/core/hub.c index
> > 77e73fc8d673..b64be35e203f 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -44,6 +44,10 @@
> >  #define USB_PRODUCT_USB5534B			0x5534
> >  #define USB_VENDOR_CYPRESS			0x04b4
> >  #define USB_PRODUCT_CY7C65632			0x6570
> > +#define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
> > +#define USB_PRODUCT_TUSB8041_USB3		0x8140
> > +#define USB_PRODUCT_TUSB8041_USB2		\
> > +	(USB_PRODUCT_TUSB8041_USB3 |
> ((USB_PRODUCT_TUSB8041_USB3 & 0x00FF) ^
> > +0x02))
>=20
> Argh.  Just put the actual hex number here -- people don't want to do
> calculations like this in their head when they are reading code.  (Not to
> mention that the number would occupy only six characters of source text
> whereas your calculation occupies a lot more.)
>=20
> Otherwise fine.

Ok, I'll put the actual hex number instead of the formula.
Thanks for your suggestion!

>=20
> Alan Stern
>=20

Best regards,
Flavio
