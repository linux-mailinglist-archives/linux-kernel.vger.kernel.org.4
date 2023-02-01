Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB0F6862D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjBAJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjBAJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:30:31 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615D75CD30;
        Wed,  1 Feb 2023 01:30:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3dwJnJ/U5n45POWWfHATQ91l0Et5KwR/9J0PGptCbDhFYanRBzvlzXw3T3xEMLNlW9Q9ES+PYJr4nQ3OUkdNkrCWeEut6PZ6a5UxriuwtgX41rZiUV1V2ghLVQFyqtvNCbjhS4EMak4O26EhrRIWma8l07ZyDUO9MFUDwP7WogOJouVrBVE3wcqMkRNFvbx8kaziUGpGR6AyBEz9oc8OzznIRHndb4A5tTyQOJMZ0/H/1iQAgE9dGC1Ja8xZPqi/7VmMJnuQYlBOuazcj7XCCVfCKAZBuWhYagW0aAbyNrnln0mBzzrt8wW3lJw0pPqDcs3AdbXRArod+pHYlpVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJYnPmYCmpLyFBg+PgrFoFmKhLQE+zR215vP/wXdONE=;
 b=V1mXDDO2jhQatjuEE8jznz5Moz2d/Wi7nCbZPkHTJ1ZW6ggzKyk8piCnA18B8WJu7bG+hGrwxZgGyHUYkyKcFsM62Ob4s453ytkO5svnpfLY4YTQIPHidxK3Ro7/+Pm8m09aJs0sw2W+ZP2XwCXvv0ufj6WE13cEZnVSIFhYPs72mrzdNdf0wysPVmLFbVt5Zl7PSEReO/f6ZgaTquZNcC8vYWJFGNBnhN9C++alGhg/9RKbFqdOeGUPRhfWIPfG6bXKUbTtrA83zFKGLMcq25hoH2F7pwaoxL57ZVLNcoBSCjpkp7Pl/56eqaiCydSk7KXoombmRp7uGXkB2fu/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJYnPmYCmpLyFBg+PgrFoFmKhLQE+zR215vP/wXdONE=;
 b=kCdfhWwy7kpRBv46SAo7xr9SiEiYCWOzbsx3oyRUK/FS++SKlTCSNJrs7TYeL4ngEnz4WW2V/dMYOQVUiAtWvpv4a7T++JsggRlftwZxw23fgJvdDm1ovS17Owzi7CEusInC2swCzL6uNegUCm8E/wiN7CRXqJvzcz6O64ytKeU35btQl4Sref+LX5il8MRS/bS4EPk3NYOlh3nHe7CGeKiI9uPHMaFYl4kLYCr32BRjjdYOlJkVEEoiyKWwnOxxplLe/Q5Kg5gZ7M65c5Pzzgv9BQMdHL3njW6PohNF3DQzkuaq1nV1SUUl066dL3+xtPBTHjtAzRd8jO45tar69A==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AS8PR10MB7398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:615::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 09:30:28 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c%3]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 09:30:28 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] tty: n_gsm: add TIOCMIWAIT support
Thread-Topic: [PATCH 3/3] tty: n_gsm: add TIOCMIWAIT support
Thread-Index: AQHZNhj+ED0+S+B5S0O8QJxkJNAmc66503Dg
Date:   Wed, 1 Feb 2023 09:30:28 +0000
Message-ID: <DB9PR10MB588166BD5DA668E4F6DEA597E0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230201080151.2068-1-daniel.starke@siemens.com>
 <20230201080151.2068-3-daniel.starke@siemens.com>
 <Y9oluEimqDixw60I@kroah.com>
In-Reply-To: <Y9oluEimqDixw60I@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-02-01T09:30:26Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=a7abfb4f-3c8e-4bfc-8e6e-e59141e124df;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|AS8PR10MB7398:EE_
x-ms-office365-filtering-correlation-id: 99ec4a76-4bbb-41e8-9002-08db0436f492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WaD3g8zYxH7g/Lg/QXLXrv8zJj+34+GCtjBVUxRlOdAdwDixPa6+3aCkoho6I5mcwVOcjgrZIq9WfyJ+okOWQL/DHnMlgcM82BFFWWLo44SfBUfUl2u/QrGFgAbtv62LzWvQPbbBUathHPRfnN4Lk+NrfOuEQEIO+FFc+99pVELAlVDgNRUdeqwxBysBDbagVTpHT9yAnU4l6Jhw3aHu9n6kjk2Q9WZAjBoFofyBJDll0HKbxinBHeZBOmiAPVhaa1eT0RqxWAleY6Z9w5dt1QzZN4mR1fYbUSvutkBaWvvqB8WznG80zD4rZ2vSe8OWnHXnleVg7eomOPUNCECl70VeIcnAulhi4agOGJukBDbSzWWEorY6GOxpIwRKiZAwNFVYnRnU07k7IjgBqyI502qQcp6WpnQAJGiDDA8Jj4HL5Z2HrkvU5+e4NzfpcS04csQXzxtx3w1rJeOMkNGnIOSF0UIdZpkDabQQpbuhAc6sxwsVyA/F60G3VNHuKTwzaIhSrvbJggPaMZMMbmUfO507oCrk/0tVxF6X5A3LOuhQIYMt+iW8qHaonCgKPFYl1LhmW1fQibVTuzBLCRJSTpNnyu5rB21LGcYQrpXFRAFuSMGGND9o+nWDL9rVWlFa40oewxpXETwb6PBI+/h7Y+WN2E94X+QU7/WxeJ6uZEIO/NPPswittfSkAza7m6iahtviHh0ARQ5B8VC6uQcapA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(33656002)(54906003)(316002)(83380400001)(71200400001)(186003)(9686003)(26005)(478600001)(55016003)(6916009)(64756008)(4326008)(66946007)(76116006)(66476007)(52536014)(6506007)(38070700005)(8936002)(7696005)(8676002)(41300700001)(5660300002)(86362001)(82960400001)(66556008)(66899018)(38100700002)(66446008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lc4KKuqA9ZRqK4cuFwk0MDWbZj8GGm1HoUHefwN+zimwp+FcQVcR52iP8/pp?=
 =?us-ascii?Q?+vnksWMM8teQ1BW1vqICHhaOp2/JSJY1lCAxXdiGbJTrbDw2eGt7F9s1/Afe?=
 =?us-ascii?Q?SwNc6u6vj2oXef3fCriBNWwAkt90mqGw9Wmjt3MzW6SAAt6kBDtjsXUMUHN8?=
 =?us-ascii?Q?GJQtQlp0mX8kEEN0BOUj7AnG45Qb0yKXL393NwmHzhy33KNx4UiBPVjcLM+7?=
 =?us-ascii?Q?mHWFaJewPcp2106EWtPhtEaetjdyepZd7WnBrP0V/8PsC5cEfmP3PaMYxGiC?=
 =?us-ascii?Q?SfekxsZ7fA6gD2In2mZeIefbxEU4XfNuOdbMb5WX7UfIofTkEEkEM6YjWqVa?=
 =?us-ascii?Q?Up0ZVb980mi/VydFFPBWuEevnTRb49/msjfbietsGP0zliu9O6CDM/KjSJIF?=
 =?us-ascii?Q?5HDufvG1344JrKCoJZCKOAB06MveHWCk7NGBv2sQb7c0X6XVfhvXNCCRaLcp?=
 =?us-ascii?Q?U9PSGbChIqA1MG6nIK3ngre7ROmV36+DPRkFCrzMOd49fiBhezjOlmHgFOfp?=
 =?us-ascii?Q?XXYxRbZhck5ILg1bNfjYnqN2iSg0RnKclBslJjMc5aANr0tQeD0mKakTzwmR?=
 =?us-ascii?Q?S2EFvZ3NamE7YmoMvxyNgGwSmS/Kpo5AM8yNmVVVDuadU1PEd3cpRyFX3YGy?=
 =?us-ascii?Q?yo2AhW8Q9x7YA2TnVH362bC2l1hqiqdGYelKmdJSRGVJQJxdta5v84h4phKs?=
 =?us-ascii?Q?GTA1VxqEREicI/h8vTLxw9H9bu2oQAeEwBNPeX2a7NlcMI2FBtffnJRKVMpV?=
 =?us-ascii?Q?a9IoJh2AnEGmP2/OasoE2IFYGyO9G0wsXsk4l50Ga4izyrmhPg2AloYQ2zcn?=
 =?us-ascii?Q?lNtvFcYVcBcXRLodDk1tZeg/sbwfV3i1SIgINkPEB7cTOzBXgWf+hf96LCAZ?=
 =?us-ascii?Q?cxpqY7+JpxdX0caVrVINHW2ROaz32svxQNxR5YEXfVKnX12VCo2nht+nSVyp?=
 =?us-ascii?Q?ZI4VELWG3aXDzbsHFWRiUgEnQ3xPBwI2iOZBatTK3i74x87TZ4BV8ZhoQC7M?=
 =?us-ascii?Q?uE8U2ISbFHD8az/8EP/VdOyyGJp0fhHsjkYU85SQDdTz1SpYvtPh3TPWqQDA?=
 =?us-ascii?Q?+qeEJuxfk6cKHrANyXABTutXEYYtm7XhtqP3HJRKzIw5pcZwGrQKEzMNbN/Q?=
 =?us-ascii?Q?+ID+xlaQglniN4oxjeW3APvWlaalD55mXLrJxUvDKbbaYgM6ZBNuYGAjww+X?=
 =?us-ascii?Q?7Ube+7UnGZOGi9jMLWmR17+pHKxpsX9D7reSzzY5jSWslyG1bbGFOnXdI/Op?=
 =?us-ascii?Q?FPgbtlB5XIw7Vj0fNqv9Vozg+cdkTUA1EPU9kE6PU1V5w+gENMp60y4vZIuo?=
 =?us-ascii?Q?9kZRT6CdxDLqKSMH8VnG7RrK99xd9vD0fTe0BP9WwxEXIEzs6Jch5b7hrgrg?=
 =?us-ascii?Q?DKMb9gZ2vOnLdoJFiPkZbkR+xmBb0LygqzcMNkElpQUvM4Ew4ob3+//UambL?=
 =?us-ascii?Q?AAyoEKdasOsoKDVCho9ILDexfAqVLHgz7Q2Sz0rzlRSA2/73Is8N0hbGTf4Q?=
 =?us-ascii?Q?Z3HpXjZFzxed3v388r8X3BdBs4rvpWoiWIK1FKU783pF/jPy3NGxqYsBDhgf?=
 =?us-ascii?Q?xAT4D/USI8B5LTO8ojezRY1NQjacCCSkZxVrZUOHagJs5t9O6Ga51flaqn/3?=
 =?us-ascii?Q?tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ec4a76-4bbb-41e8-9002-08db0436f492
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 09:30:28.0891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Psjg3lWykI/x23FesJeNVPSq3HkYtS2op7c4WpxHK1X/NMn3c32ITro45PObZrXPmcu8nvV+zqMQN60MzTihkt+qJrwpC8mxkS0n1R1LiOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7398
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Add support for the TIOCMIWAIT ioctl on the virtual ttys. This enables =
the
> > user to wait for virtual modem signals like RING.
> >=20
> > Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> > ---
> >  drivers/tty/n_gsm.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >=20
> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > index 118511c1fa37..48fb7dad44cd 100644
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -1542,6 +1542,7 @@ static void gsm_process_modem(struct tty_struct *=
tty, struct gsm_dlci *dlci,
> >  	if (brk & 0x01)
> >  		tty_insert_flip_char(&dlci->port, 0, TTY_BREAK);
> >  	dlci->modem_rx =3D mlines;
> > +	wake_up_interruptible(&dlci->gsm->event);
> >  }
> > =20
> >  /**
> > @@ -3848,6 +3849,35 @@ static int gsm_modem_update(struct gsm_dlci *dlc=
i, u8 brk)
> >  	return -EPROTONOSUPPORT;
> >  }
> > =20
> > +/**
> > + * gsm_wait_modem_change	-	wait for modem status line change
>=20
> No need for tabs.
>=20
> Or for kernel doc for static functions, but that's not a big deal.

All other functions follow the same style here. Nevertheless, I will
replace the tabs with spaces. Originally, I had planned a code clean-up
after committing all the changes from my original RFC.

> > + * @dlci: channel
> > + * @mask: modem status line bits
> > + */
> > +
>=20
> No blank line please, didn't checkpatch warn about that?

No, checkpatch did not warn about this and all other functions follow the
same style. I will remove the blank line.

> > +static int gsm_wait_modem_change(struct gsm_dlci *dlci, u32 mask)
> > +{
> > +	struct gsm_mux *gsm =3D dlci->gsm;
> > +	u32 old =3D dlci->modem_rx & mask;
> > +	int ret;
> > +
> > +	if (gsm->dead)
> > +		return -ENODEV;
> > +
> > +	do {
> > +		ret =3D wait_event_interruptible(gsm->event, gsm->dead
> > +					      || old ^ (dlci->modem_rx & mask));
> > +		if (ret)
> > +			return ret;
> > +		if (dlci->state !=3D DLCI_OPEN)
> > +			return -EL2NSYNC;
> > +		if (gsm->dead)
> > +			return -ENODEV;
> > +	} while ((old ^ (dlci->modem_rx & mask)) =3D=3D 0);
>=20
> No way to break out of the loop if it goes for forever?

I assume that this is the expected behavior for TIOCMIWAIT. The functions
returns if:
- the requested modem signal changed
- the wait function got interrupted (e.g. by a signal)
- the underlying DLCI was closed
- the underlying ldisc device was removed

I can add that the function returns immediate if a mask has been passed
which matches no modem signal if this is preferred?

Best regards,
Daniel Starke
