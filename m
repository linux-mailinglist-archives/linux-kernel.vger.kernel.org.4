Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F206FC48B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjEILG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjEILGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:06:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91F2E46
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyqbEeSsfVraiXfMAyhJgLMeoA5mVh2Xpon4kw1P6ckwORqzVigFYjVfs4L/IilHbyQSjL4zMOc4vV1aF5bQxjR3U5RHsv9fI6SwW4sq1IRn6fX+fg6KEZ0GpCniL0Ms2SsI+L7vC0xSX/2aZnZQ7FriqPIObLW8kauD6d2IQ4AlVT/Uqwo2PK2KO4vkkCW4+M+YrFNr5v34G1G7gvPhnojweql7VuxFKA4DwKaJOLngtzkCcDLFHzJQ9GG5/CIrtclejEEvDMYqn7X0lUPmQPjdiGH7qBBxxeQOhXwRMf9pqD7f894j37/3FB+dj18f28TXO1nt614pGoblpS5JEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qa0XAAa7j1ep0UXAb4Q35VDA0pWMEFJRSnRE7oux5Q=;
 b=cCHjJMdjoJ554TmBFM+JFhaD92hcAUTLEK573AiWMvUWsLrJNc+na30oOoT3COISMNFq5X+Ld8Iq+PhqU3/NgsQB7r4U/RKsP3e5nMsoBmVSub0B6mZKVVEtujcUMRQA/RlUsTFKGJcwHjr2OXqWaSehbWn+GwC702YPIAxCaBOvf6EyYv4uyH9rxXa+Xd68MC7uccy7mCQjkNhqceAeR5PipuunaxzReFXRrt9f8rZCq7im7WGj1M60ltyY2f/ogaeyhU58lFCpUHM5l2f7irFGO9mknfXNeiCza6S+GGUOgenVI5qgn2a7DrjOGN3A80b2I9gKKAKOt3w02FWPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qa0XAAa7j1ep0UXAb4Q35VDA0pWMEFJRSnRE7oux5Q=;
 b=pPoKT2UudySLE8CxI/BkbHvOjQvky2YR5r+1qK0qzwAIbtDkiUP607Ervhi8aiFZtpmBaWm4yV0X+a0NoXhMvP635BPLPN397Y4DR+fRzrU5qbXz5lewmZ5nHlgISrXFDZH2Odvzs2lNMyeGv4Li41KmV/XdhJ8TJWyZEhR9b+c=
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 11:06:19 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 11:06:19 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "maz@kernel.org" <maz@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
        "Cascon, Pablo" <pablo.cascon@amd.com>
Subject: RE: [PATCH] cdx: add MSI support for CDX bus
Thread-Topic: [PATCH] cdx: add MSI support for CDX bus
Thread-Index: AQHZgbbQ8ShyQzF4vUyRRORizYSDaq9RlYMAgAAtW0A=
Date:   Tue, 9 May 2023 11:06:19 +0000
Message-ID: <CH3PR12MB83081FC5F89386EA9C54B4A7E8769@CH3PR12MB8308.namprd12.prod.outlook.com>
References: <20230508140950.12717-1-nipun.gupta@amd.com> <874jom2ash.ffs@tglx>
In-Reply-To: <874jom2ash.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=abde2e10-a3fc-4a7d-8b49-df6a324045a9;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-05-09T10:45:49Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8308:EE_|DM4PR12MB5722:EE_
x-ms-office365-filtering-correlation-id: 855ad18c-e59b-4740-c4a0-08db507d6a77
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRFqkc+UKfAYFNyq3CtP0kj3Eb7Y26Jtk4u6tPyT35a/zplPsLF9IzTvacUKjB2JH5WLwU69DhPl991eju9t4In5dFf3vum9a3knbw0PsZnjujFSDrlHpBMGHHDjaOevYc/OTOD2FzGocPxdBBcEt+YRU1O2HlwgEej2z8GEsTEkx4DONvFnfoWMZd4REcmEdpeszrMHRCDSTKiZ43BnvI3R1ubldIJXIX81skNvsbwGbGoaRoaKpiXyO03/mnrHkyo4t8ii8AzMGTNhh+raFoKsdLN3iHqatqkMK/aAoDOtFZkb43EOa0w9hIa65WY9ie9N95lT4xsNUoy4n2lbuHfThKifRWyMH3tw+cOaDjUEloHEVQbhWq1deO3f/z2uGYlD4aP5lPnpOy3LMi48pKlmAXdpRrXb/MZ5JUTqmKKV4UOZe0YrnKluL8OoDLQywWz+3WW0TQMbYQ2m6nZlUaDUmmrGh+g3EZSh2D/CxzHuEeiufGSLB3aUhpRjPdSgpcDgSL9PqF2aEVGOwCQfmeAD5UH+LtRAtCINjNW/Ttu0ez2D2sWbwO4N6yt8DSZwwTr+ZOL+lKB0Cm9y56mC4w/mxqDjo1nhS82aoPjpvwvE8lhWGT2go1rQTWUR282SWfwdZJ+RVS0zW5GcasMMmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(38070700005)(4326008)(52536014)(316002)(5660300002)(41300700001)(38100700002)(66446008)(64756008)(86362001)(26005)(54906003)(71200400001)(122000001)(53546011)(66946007)(110136005)(66476007)(9686003)(66556008)(6506007)(2906002)(76116006)(8936002)(8676002)(33656002)(186003)(7696005)(478600001)(966005)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nPAyschVjW/eBKDm3vPUn2F70ye68RGBL7aWeVvzacpdwQJebb+8dpzVDCLw?=
 =?us-ascii?Q?SHgbzChASvsEq/I9OzHjKjZwfc/BHBfqWGUlbxKhnpG7qXMKkk/38Fgpt6K/?=
 =?us-ascii?Q?mIIBaVPKYJ0EbHKOIL41MTt1F5tOvrrr9AbXpjtNDcniXYt0GFbym402xsPA?=
 =?us-ascii?Q?NsjyRdTNLLoZYDr0rbwj6MpeA5XHgs5VB/LyhL8c/YL7wxtKxYwlThHh3DCy?=
 =?us-ascii?Q?urALyNwSJV4NCW/zTeqNqGPpiuVpbQGTIwg0GuhZpXrsaxxI8uu+wBQCSt7t?=
 =?us-ascii?Q?OzYSZQUEOjzGPSsDUB+8UZS7JvCA1xXbyfhzIVcBKvHdkYxIkYBx/KWAsvwR?=
 =?us-ascii?Q?xP5pJUUvQyzo1qpJZHnIhJmNoAHikAjomATUMDwdZrY3GgMM7zH/qvlKZbMk?=
 =?us-ascii?Q?at6qcnoEMUybUA2l14TsyXxNfKAM0l+unBezIOhH5+uAwKlEKK8PjTEhBudY?=
 =?us-ascii?Q?vs53Kc/9dD/Pq3sHaKUiCqDlTDZ7COc/mDlhgL8EWXe4liekhuy1cKqnesuk?=
 =?us-ascii?Q?kX2I2ZzUxHA31WE4jarEVOhGr+Qz+el3PeWXIeeCWDzUX9YIigZflwje2KF3?=
 =?us-ascii?Q?GE+d+zcfy7mSyElCReqLpN1BzgKrkxXhozmllAPez3e+rtW2CMzTg++QOuMW?=
 =?us-ascii?Q?A1OItUWoRdSrfu/t5P3Xg9P19u3KNHDukvMq3y1Tyj/kzL69eTnYZtispXjO?=
 =?us-ascii?Q?E9cmtB5HKEUYNw1DzpWIY668tQmpPdFgaTWQdADzCwOa7qJSPZLqDzdFSlPr?=
 =?us-ascii?Q?k9zHIo/nxHIDn6LynyGO8SjAFJv6l5y3uL0h0e9Jxka4kI9zaO3DhzV53YbW?=
 =?us-ascii?Q?kPh0McMdvA0qFXfKRXO4nUU8D044ivyoaEZaeYxm2PngraXhBIKXHjKQ8VGG?=
 =?us-ascii?Q?Aer0FQczbu5P0WD0vo2l6dYYnn6Lj64t1GgBplu9j0rxxDscFSYLgwYb2oFw?=
 =?us-ascii?Q?jZcTEibt3gOL3/wK8YAiq/qhAsc5X8QjSSDRx4vFcTB3nmcsjoV07WSSS0vU?=
 =?us-ascii?Q?IKNQXUzyD6vwStAPWz8pMFC6B/Fs7umHWDJ9NkniENPWa6K3dBxEM/z9qrKr?=
 =?us-ascii?Q?cQj5KcSsZv5jpKa6dxMK0frmLNiIMkRH2DOKcORZ++uWcDtEttqpUqAwvy1o?=
 =?us-ascii?Q?haF8RNdQysUAOZvYHy14RzxemeEhQgM/A2UpPQmjXeKrBaeqHzJvfTMaKqXL?=
 =?us-ascii?Q?LN+oiydnm7s3fSqR3JLQx6S/Dvo3ewxLPlUbY01Kfe2BunR5hH67w+c+XAJl?=
 =?us-ascii?Q?0LXVoi/sFn+k6jYVn5vVilAJpzA9g1dcgv4VdLgMocLjZib/fboL27naWvpG?=
 =?us-ascii?Q?UTP2Jz4BNgRW0bGq6LWR8FueounOCEVmMySJNrIjbQhwth4PhIXeTA0zHM03?=
 =?us-ascii?Q?zQGycpMBXoXM7xgXZsuAke4tSwzpRsEKlXxgLg26IXsdQw6d8nHZGeujMrEv?=
 =?us-ascii?Q?fRRty/TqSIWlNv/2tq7l//sLgvypJcV4fULb66ntf7o5rVcmBPqw2i0B378P?=
 =?us-ascii?Q?E2WGCu2bkgTMa2wrIFAiD6JhO92p+eshLgTbndVSu6Y59Dl7JV6H2C/oSvrc?=
 =?us-ascii?Q?ziMC2BZgXqGOk/ebV8M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855ad18c-e59b-4740-c4a0-08db507d6a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 11:06:19.0411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Uw/HWcypmvBh5tAcI3VVtzlH6ujFkTiA+8PiCkctgfbxdH2nfytt16GZOypyklm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Tuesday, May 9, 2023 1:32 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>; gregkh@linuxfoundation.org;
> maz@kernel.org; jgg@ziepe.ca; linux-kernel@vger.kernel.org
> Cc: git (AMD-Xilinx) <git@amd.com>; Anand, Harpreet
> <harpreet.anand@amd.com>; Jansen Van Vuuren, Pieter <pieter.jansen-
> van-vuuren@amd.com>; Agarwal, Nikhil <nikhil.agarwal@amd.com>; Simek,
> Michal <michal.simek@amd.com>; Gangurde, Abhijit
> <abhijit.gangurde@amd.com>; Cascon, Pablo <pablo.cascon@amd.com>;
> Gupta, Nipun <Nipun.Gupta@amd.com>
> Subject: Re: [PATCH] cdx: add MSI support for CDX bus
>=20
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>=20
>=20
> On Mon, May 08 2023 at 19:39, Nipun Gupta wrote:
> > Add CDX-MSI domain with gic-its domain as parent, to support MSI
> > for CDX devices. CDX devices allocate MSIs from the CDX domain.
> > Also, introduce APIs to alloc and free IRQs for CDX domain.
>=20
> This lacks any information why this needs to have a separate irq domain
> and what this is about. Changelogs need to be self explanatory and
> providing a link to some RFC series which might have more information
> does not cut it.
>=20
> Just for the record. I complained about the useless changelog in that
> RFC series already.
>=20
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>=20
> This Signed-off-by chain is broken. If this is intended to denote
> co-authorship, then please follow:
>=20
>   https://www.kernel.org/doc/html/latest/process/submitting-
> patches.html#when-to-use-acked-by-cc-and-co-developed-by
>=20
> > +static struct irq_chip cdx_msi_irq_chip =3D {
> > +     .name                   =3D "CDX-MSI",
> > +     .irq_mask               =3D irq_chip_mask_parent,
> > +     .irq_unmask             =3D irq_chip_unmask_parent,
> > +     .irq_eoi                =3D irq_chip_eoi_parent,
> > +     .irq_set_affinity       =3D msi_domain_set_affinity,
> > +     .irq_write_msi_msg      =3D cdx_msi_write_msg
> > +};
>=20
> The only real CDX specific functionality here is a CDX specific
> irq_write_msi_msg() callback, right?
>=20
> And I gave you a pointer how this should be handled, but instead of
> helping this effort along you go off and implement it differently just
> because. Sigh!

Hi Thomas,

As you rightly mentioned the irq_chip has only irq_write_msi_msg() as
callback, but there is also cdx_msi_prepare() in msi_domain_ops which
needs to fetch device ID from CDX device, due to which we are currently
using separate CDX domain.

IIUC, as per your suggestion we should have CDX bus token added into=20
its_init_dev_msi_info() of
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/tree/drivers=
/irqchip/irq-gic-v3-its-msi-parent.c?h=3Ddevmsi-arm,
and register CDX specific 'msi_prepare' here; so that we can use
msi_create_device_irq_domain() to create a per device domain?

Thanks,
Nipun

>=20
> Thanks,
>=20
>         tglx
