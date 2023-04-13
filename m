Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E666E1799
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjDMWkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDMWks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:40:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB109EF7;
        Thu, 13 Apr 2023 15:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izgIyo1coov2KHFqlYaYQ4GULvU8n/+EoxF79TUr++Nl2mrYCGXy7KxaPcxrL/rv++MNI7Ig7Qs6A4PgU60KjRDGssIiaucH/VKFY4KeEqNzVX2gwAfx/OeQs8f8LFjkcljvu+htUW6e/3idGnuRcqkAPau7piwD2nF9fqlrR49ovuW7KtFbmr7An/zbWl6kCer74u+6EPNEAzsvlDK7cxrKlN1cnqaAI8QClFqoUSKjMMo2T30EL4QZZDLcbfYLIfL0u+RSvmykeXI0/YBZktTCdux4RtjiJIUiexD/EJZsfqBR3CoVAvUYzc6CFAdYV1eoiukrDMGHRbmcQ3Ndpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzEt8DABvUNLdZBICeGP861ttrPXwx9n/di2OyzYnDU=;
 b=YsUpOC4lAJme7tmOrVS76I5HXauZmo9j8mXmAneRA/6dtYsOPxwI7ylKdbBkS5GD6J6X5c0/+sUsYkGPhpRK9xpehSzr5XPUBHNZ/OO3tAq7MWxKlzM1DPg/HvFd82eLsa+tMI8m2M8ItRNJW/k1wS5/wTi059W++bMRBYSE2dGMJcaZAEgKrw1OpMX3UB5PV67ZEMtim6iC2hgWwDStNX8uIdfC1aiYf1VcgF+M/9/1NfMHORDZNSNaWfreSBdCAMn2e8o+/T6E6Pd5A84bMsddpGcZ0r7tNP5dIXcoAH5QF4VVp3CUAsKSDHw8ZMaSOkaRg9VzYUsN0Q2FmY2GGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzEt8DABvUNLdZBICeGP861ttrPXwx9n/di2OyzYnDU=;
 b=ogKPT6e3lPzSde6wv8w6eXiWkl/7Z7gA5mDAS9XR/ujHjpbrPmE8eIhZQZLLl+6ciqBeqGnlK7FB6eTszy1TGJGgbgwc/4hVmT01z88kFkUX9xZDM7uUDwCCfZrZTEFotZ9xL0XMe8y98bJH5Jj94AO5kidpAM4xfJs7b0anxKw=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 22:40:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6277.036; Thu, 13 Apr 2023
 22:40:08 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Box David E <david.e.box@intel.com>
CC:     "jstultz@google.com" <jstultz@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "svenva@chromium.org" <svenva@chromium.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Thread-Topic: [PATCH v8 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Thread-Index: AQHZbXfsibhgm/7850CLmQzM1sxAfq8o+F4AgADdwFA=
Date:   Thu, 13 Apr 2023 22:40:08 +0000
Message-ID: <MN0PR12MB6101F7E14E3AD1ECFD6C2F25E2989@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230412194917.7164-1-mario.limonciello@amd.com>
 <20230412194917.7164-5-mario.limonciello@amd.com>
 <5d904d5a-d25e-7d6d-57e4-ca451bcead57@linux.intel.com>
In-Reply-To: <5d904d5a-d25e-7d6d-57e4-ca451bcead57@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: david.e.box@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-13T22:40:06Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7119637b-1fb4-4952-9eab-cc176513f064;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-13T22:40:06Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4bc65003-fb57-4a58-ab1e-6041bb5e2893
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB8557:EE_
x-ms-office365-filtering-correlation-id: cb9089a3-53ce-464f-9024-08db3c700897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trgWZJidEzL3xGtUBp+p917UVbgSdG6QoIGb252sRugkGJADAJ9GJ9pViHTz8arz6bQZ4hnLZe09vPtrOuoT1rwNZ3OxK1lsbpjBOxMYtOTwvsCHxn6+xkpNo2HJZSG2kQHQX8cntidoedM9ny+tn1tfNgw3KSY/xCIUy1+puVadbHDJcQ6IH8BpXL1vKmiaYTMJ8ZrghS3neb1yvlp5ug9vkGO4uAKqj5RAUc9FfZPY0C3dUfs+OgZ0wDjTZ0/tYYo3I1Pe8XOS/7clorqsY4i6VHLQ+eTcQAWoynNYeLx72XhveKRd7RMvHdRp6Fj6VaulrOmmSVyaEs0LJ1iLlEu/cZQ0Jrz1bbbQeK03VeqaXyNC7XDFVtr4V5SsZ0XBIMDiRkG003wzjFvoPna9Qob78DPrnhbNPlw9s7s53jRWw2JesVzAq6lfjy7X17oYqRuakIcGeawOeGUw/JcRHbqI7cP8UBI7azL+TWPkuBw4ja6D1VuyHEQYNYUb+7Oj43Kr6YRtzc3Dojg06hmOwv+q4Ht4OIb4GRRkTZ6YaYZbz98Ev5xZOhLPjDRXo19YDVUKni9GZnIfZbLamZDa/7Qv7DhukLb4gqkQuWWwuU0fTO0e8fFNnQEhEpw6fXO2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(9686003)(53546011)(6506007)(54906003)(55016003)(186003)(66574015)(83380400001)(71200400001)(7696005)(5660300002)(33656002)(52536014)(41300700001)(316002)(8676002)(8936002)(86362001)(38070700005)(38100700002)(122000001)(478600001)(66446008)(64756008)(4326008)(66946007)(76116006)(66476007)(66556008)(2906002)(7416002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eRCkp135BH6pJ8/KWgyvLsIdjGJX6LVx+NPmHs3f/zC2Jksv1MDOXLPGib?=
 =?iso-8859-1?Q?eEtdPy/lkv+Ei0+h4rqo16HWToy12RVJZrBQ3SeCfYDP4nWUVDhB8wUNi+?=
 =?iso-8859-1?Q?s5Z90bgZgup1ADK/pHO8axfQcoq/w/16F4nt0wAkCSnP8T6ajK5U/FvtNs?=
 =?iso-8859-1?Q?C5iLiwKsYaUsDD2iJjZu4sJxj8dlTIMWr3wJ7PClCQXq3zcGxg2lGEDUE8?=
 =?iso-8859-1?Q?5tmIvy2KMVumRGwJAoZvxwUw1fZHq0gW6YzTr+Uxe1L2Og6nGfB5EThkGC?=
 =?iso-8859-1?Q?o3YFFkmc5DGNs5EFSjAZ8XNxiwqOncBmV4Q5KFl1nVEzGmu5aae4no5nP1?=
 =?iso-8859-1?Q?nnJ3IsbR3OS0DaF2RzaWaFHepHd0lzd6YLbpPAWzSAFkDZtsHnGRcF6ucd?=
 =?iso-8859-1?Q?2cNLjr+37sYp3xK7bXLu453oUM9NlBrdC8+SlHX+S8UPdm0lLlhvN/Lzsn?=
 =?iso-8859-1?Q?YXE68v31SmuRQtSjuiAcgc3jorXuvU/gBpoMlLR3DA5OuLTEq9zzUTpsr8?=
 =?iso-8859-1?Q?giN+l2gFEQfyJg0cwwMDf0AyugmXxarmOGFZxlB9G2FxKWocfI3NzDaka1?=
 =?iso-8859-1?Q?e2MMXedE8S5kD2Svi4vBWeerQcUgDuj0N0bg/PXP6uC9rhQytP1gBFiDKu?=
 =?iso-8859-1?Q?jGEo7e8hHXM3BUOcx5/ItqLC8HoL3xSS8Ob6isLDzib16lMA7vEbfU/KsO?=
 =?iso-8859-1?Q?fxYF7x4CqJ5XZusNltYdjJWkaByURVjzRz7ooUoGrRHWCm1DOEaRPGHuOR?=
 =?iso-8859-1?Q?E2y0l9SDq6Ifrf8EsGUxGPAL58O9e6I6ObOTWasLZeK0eBdc2iWMNiIn+i?=
 =?iso-8859-1?Q?Gtc07GGNy6e9pvV3B75ly6cmBrGNfKR0lkcRlLgczKRJyZK76FObyahfNT?=
 =?iso-8859-1?Q?QMfi4GcE3FfXa1A12ITOeqgeeTtTnOmWkckgZYC7H3nycUiNdKBBSpZ/6B?=
 =?iso-8859-1?Q?xObUhW2eLodMADK1V8KLhMonbnGrH9Jd9P8HM37it9DYR0gzpb3g+qXadK?=
 =?iso-8859-1?Q?2WMEvH/K8pFgCfjXwYw3HDXpOPsxTgPKH0pJYgm9kzXbSHeVby9JPxTkwC?=
 =?iso-8859-1?Q?n6GD1bnkjvAjGE9T1ET4B9EdfU4IpXCB/ro43DO6pjc414TY0bUMEdo6pU?=
 =?iso-8859-1?Q?R00da+HRpHWyuyjyHpFjSeHu884A+iEzp16tWSYvRpZrTQqIQCpRKH1b36?=
 =?iso-8859-1?Q?cQDwLXOcZeFXOXD6QGdvOrPvMb0ow8g+HLntSCnY4b1V5QRWCyCfmSyyP3?=
 =?iso-8859-1?Q?YTOZ/qYqgTdNq/FR8Rs5Oagxxlf96+hTyemE5p1PIoEJ+9MQH0jrLO3gw4?=
 =?iso-8859-1?Q?qKT/h0MWu9HgUOoMrVaRlvEolNO6UoPROaoFLp65tkL9TZqENmjT3dFq3u?=
 =?iso-8859-1?Q?gRMeE1pi4rN8aQDxCJAxDCbsI9ZYKueA5xUfaX2+O9LNCRO2IYMsVx9tXE?=
 =?iso-8859-1?Q?qM8lyrKg5l6L8iKbd3phZaShk6AxOWJKOM5BgYcxTDiYKgW9e4LDU5DwMG?=
 =?iso-8859-1?Q?x/u5pasjqf7TShtNg3t0Ru0Z79odfGRAB4pSHDjhcBIzvlYls6N2vJR4ed?=
 =?iso-8859-1?Q?v5qY2X4jun2fEv+fgxE9NwLAkTgCgKMmcsg1EmsEF2XWe0G0iVWga40aK9?=
 =?iso-8859-1?Q?8RXfLKxSWjP7NmvWWQUj2dV5aX42Tej1rLhj+dSEZJWHbp/OmPqHLL/1wK?=
 =?iso-8859-1?Q?77e/sBQv0vnAVf6PipI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9089a3-53ce-464f-9024-08db3c700897
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 22:40:08.1065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQbbX1CZokJRRkTQrr5NqYp1/JATW9DXLaZGGQqF5ZoF4S+H1We8624vUJXLko8EiEy2vncUv4/CvMtCLHQZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Thursday, April 13, 2023 04:24
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Box David E <david.e.box@intel.com>; jstultz@google.com;
> pavel@ucw.cz; svenva@chromium.org; Rajneesh Bhardwaj
> <irenic.rajneesh@gmail.com>; S-k, Shyam-sundar <Shyam-sundar.S-
> k@amd.com>; rrangel@chromium.org; Jain Rajat <rajatja@google.com>;
> hdegoede@redhat.com; Mark Gross <markgross@kernel.org>; platform-
> driver-x86@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v8 4/4] platform/x86/intel/pmc: core: Report duration=
 of
> time in HW sleep state
>=20
> On Wed, 12 Apr 2023, Mario Limonciello wrote:
>=20
> > intel_pmc_core displays a warning when the module parameter
> > `warn_on_s0ix_failures` is set and a suspend didn't get to a HW sleep
> > state.
> >
> > Report this to the standard kernel reporting infrastructure so that
> > userspace software can query after the suspend cycle is done.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > v7->v8:
> >  * Report max sleep as well
> > ---
> >  drivers/platform/x86/intel/pmc/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/platform/x86/intel/pmc/core.c
> b/drivers/platform/x86/intel/pmc/core.c
> > index 925c5d676a43..f9677104353d 100644
> > --- a/drivers/platform/x86/intel/pmc/core.c
> > +++ b/drivers/platform/x86/intel/pmc/core.c
> > @@ -1153,6 +1153,7 @@ static int pmc_core_probe(struct platform_device
> *pdev)
> >  	pmc_core_do_dmi_quirks(pmcdev);
> >
> >  	pmc_core_dbgfs_register(pmcdev);
> > +	pm_report_max_hw_sleep(((1UL << 32) - 1) *
> pmc_core_adjust_slp_s0_step(pmcdev, 1));
>=20
> Technically this is FIELD_MAX(SLP_S0_RES_COUNTER_MASK) *
> pmc_core_adjust...?
> Where the define is:
> #define SLP_S0_RES_COUNTER_MASK	GENMASK(31, 0)

That's fine by me to switch it over, it certainly makes it a lot more reada=
ble.
I took the value from @Box David E to use suggested in v7, so what are your
thoughts?

The current version has an overflow error reported by the robot for i386, s=
o it
definitely needs some sort of change.

>=20
> >
> >  	device_initialized =3D true;
> >  	dev_info(&pdev->dev, " initialized\n");
> > @@ -1214,6 +1215,8 @@ static inline bool pmc_core_is_s0ix_failed(struct
> pmc_dev *pmcdev)
> >  	if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
> >  		return false;
> >
> > +	pm_report_hw_sleep_time((u32)(s0ix_counter - pmcdev-
> >s0ix_counter));
> > +
> >  	if (s0ix_counter =3D=3D pmcdev->s0ix_counter)
> >  		return true;
> >
> >
>=20
> --
>  i.
