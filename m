Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0364DAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiLOMGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLOMGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:06:41 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4925A29C8A;
        Thu, 15 Dec 2022 04:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcYVbhzcqYx8uKpHH+4TFRrDBF6HZL2VWgt/x9KYq0cp/60em/UV4+yZZ6FBq97vfHM6SI+5TKkAPkmjBpD/EGnjYAq0H64PE4DLRZaxQNHNCfnUHYAtnbnkqVH/wDJEE7Q9dvb4C+JrP7CfA/X3yNoU3tAsiwC1W+AecylApAzE6H3m5NWaN8b0kP6NowW4cvXYUddzEQfm2NmoS2UpfwiRTrIM1MouX9BjpepC3A/Ngx728bQpcVwBFu+q4i8yM4pujxpZfWsTRDTJU0QMotrkc7HvdBgvN9u1tA0KsbHmiyZewn4AWreUcE9g7KTEz3+X3tdTylSEJMfuWN5vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlyU+ni7aLodMJcACHGf+aAo5A+Hup9VNHTj7aA13og=;
 b=dGZgKsBeykx06V4RafP/5exNlgvRuufdZY6zdJrIZcUJAd7SBnyzNoGUbgd96yvVm3BoVMtttPWbzWaeJL/XE6npa8ySDnwGtitJ1JZRkKcQpklT6Dp++BjPYW8phcztPtORgw//K7WBwDUIBDjlPs0gWMRtNvGAjbRpjrePreqT9Cd93MBtJMC+DKcZtOwas+X8t0INHEoEC4Mf7KbDMn+AzajdX8ddxAGoAS8yWeURdWRo+Y3dt/IgEc9VnroGQBmIGXY7AfUJjKye65mcOOPyk8CMmCiMF7czOlu9SZOawShSF8dNKjgDljwz0v2+MLEOY24O4uzuul+t8lAF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlyU+ni7aLodMJcACHGf+aAo5A+Hup9VNHTj7aA13og=;
 b=f/tpyfOSl20RpfeFxzj6AMOBq1znQFQ0WoSbaWBp01mW7zgAC8VlbUYHJfl+aKA1FEvRm3jCqmjrbZwBQ9pqQQGcF22A3pJMetYw3NVu15cKQ00AwbJF/eMkDXRuuean8C/2em4VTCyCTItviz5lT2GUqdNbjuhMIsnmqk6TsBj04WsbgTZ5WOdgY8JVy6FBeu5A1M817BqBLtPs7DosVij06KINYQ6ocEkfRgnQhC5SGDnjXJYPTSp6XdE5CcKdcvfol4VWyQPwn9fkFRWcGkFV1tzsy3JM+S6upRt3S9Q5M2LRmb4ZN6V/8uu59nCX11vJXCjn2Z4jfRTS3difMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 12:06:38 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0%8]) with mapi id 15.20.5880.021; Thu, 15 Dec 2022
 12:06:38 +0000
Date:   Thu, 15 Dec 2022 13:06:29 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <Y5sNxY1ibaSK5lND@orome>
References: <20221213195313.GA200257@bhelgaas>
 <20221213200733.GA201693@bhelgaas>
 <20221213233649.zmmiskezdponleuc@mobilestation>
 <Y5nfr+AXofk9Ch2m@orome>
 <20221214220735.5fv6agbkwamvfmbv@mobilestation>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LSp9OVivsvvQ9GYN"
Content-Disposition: inline
In-Reply-To: <20221214220735.5fv6agbkwamvfmbv@mobilestation>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.9 (2022-11-12)
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|MN2PR12MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7f00b3-2586-4aab-b57d-08dade94d0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgOQQ6rt7013mCyQXcVp2hwE1uj5IAfTExTfwQOPGM9INcsulOFHdTnfRTdkOf4DM3Px1vFQVgN56M5dFIcLThvX3dgMw9Mn+1gKiAIOKnnuYoaXu7EhwR233P/6Tp8ca3XCIVME2iQX1fMUj98tgHUhZrAaBZ98vUOuz2+4tTrT4BBq9JR196YY5FThuOEssHEClYdZQFRrMumHcYQe7re4jjdnoGm82FlTOgJJq/bBQKeCLCeRqQyFikqkaphgs0lpdHIEKL+Ej8dMuCcXdlfwzoH/8jAknk1bNYrlaB4i/d8oDMBW3sDeomjk0hU5IWtVB4giDYsNk+HiIYpYlD9j9jfXGwwIXVmvu2hivYr3gc1I3izqjlO1QRj9GhvuZF/dQTa33L3IgJN/MuLDrAgGvPOgtUa0ZyR1u6AHT59g6wFUqgXr6xLTb4lbAvrviUgil0mvxNMv2uwJgCx1ytZ3BkbxqM0ueW1O5nqnvgIRsDE7u3Cvl3dpM5fjDR1kvOi2mSz6Vt9zF7GPfSgwYc93njYlKT2fIOWUqIF9ZU0YH51Rp6OYsRRz3i83QgENn1kBiYki/u8RvP0e2UEzlGaFrlMGRYzE7I2vyfh5qVK6OQcZx0Ays0CA/yW2AJR+uA7rvf5zsqPgKU3zePHs7UE+fYpSNT5y7Vhbgw2smG16VTw1oz01zoSwKKCYZBtG81+HEJl4g0MlFSFtZ34fK1+BAHkgaKcLQE5S9WRFrBmrGpzNy1lEBnvTTD+y6LSkVGvkNAcsBtZSGQnOyAVwwLgHsBaY4sNQ0GDpocdkn50dd3R/AhpDKoPYwEpHDLa1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(6916009)(54906003)(21480400003)(8676002)(2906002)(41300700001)(83380400001)(4326008)(66476007)(66556008)(66946007)(5660300002)(316002)(7416002)(6486002)(66899015)(478600001)(86362001)(6666004)(8936002)(33716001)(6512007)(186003)(38100700002)(966005)(44144004)(9686003)(6506007)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CqMTy6Jz0nyTOube9DTpoV7+/mYR4D9FA4MhGMphErbUKhcd+6L/2eTuJjmx?=
 =?us-ascii?Q?zAsVfCC8yv/v+TcBpZ5spDmfThJGv1RItRcSK2DELvPAgs1v2mUEXVxR5aUL?=
 =?us-ascii?Q?FqR4sqsPi/Xi+3SaYZqJIhOrVZtCaRATJwv0qhKWMeFOtvC+kaIL2ACt9Nvg?=
 =?us-ascii?Q?v02w5lBq9mOJYeDrMFkHm9gJJZiZBxYYQekHOTd2dAFaxU9EJJnQNiExzzUO?=
 =?us-ascii?Q?h66MgnJD1q8pFlXyHFznoHPS1AJxTNVbi+gerU4Rj9wGmzutIZt71CB5jhka?=
 =?us-ascii?Q?Zh30mamVV9/7p858QQhSqLO0wZ5+luZXM80vb3awpYmByD3g4djIkWu17GC+?=
 =?us-ascii?Q?EMm/3zF564rA+lyfnbk+3cZgHqnF+MY9L1y+44UC39iZ9li3JRbEQgdTBZbq?=
 =?us-ascii?Q?SNe1d1MZzYYdvweruZr6oHv8vATp4VynrtewZPWvaa5ia1EzKKMD4MKjz5QP?=
 =?us-ascii?Q?KANL1+R5DxcueYtB/s17bV5PvcFNnaUGSKdP9LLHgLnrQn5Iq4CUdKewz7ne?=
 =?us-ascii?Q?XLk73blIFTnhjBBANf6kgUtOsdQsZZDgs3Wn+i1rPcWFd0YI+Dp0dAHotViv?=
 =?us-ascii?Q?SyLRl+Mg3D1jKm91SWNY2kean+FsNBLiDvn62Oe12H2nc0BDQZulBHYpv2Wl?=
 =?us-ascii?Q?ONm8wkpINXfeY5K4fqrrM7dkJND2rfU/FWLPbUWvxnpG6fQFmj234bOMFIvU?=
 =?us-ascii?Q?IkuvyvRPqXCKT5KIssOQKxEdvf5KNDhhSu3SJRvFmyHesAbfs6q8kYcQC474?=
 =?us-ascii?Q?sdEu2MpiN2DD+L0SUXdgJTrPWY4tuZQ5nP7utwNJVdmVoVpz+K6gWqID3yVG?=
 =?us-ascii?Q?ufbH5dLGrn2ntHHjm5eeL/hI1+s2st0rFlYYkFS1hJGsHlAjKTNstZh40ilx?=
 =?us-ascii?Q?ecGaIBIVjip5kCQRsJnmW2PnAR/if8PgJ9P7c8sra1IoRpOv2rY3C3Pd/bCH?=
 =?us-ascii?Q?9lRWpAlCE7NCQwr1zw6HEKX6eMl3wEmQSXXJOd43FDCp9Eqwum2symHdxw3o?=
 =?us-ascii?Q?lrsIXB1XuJV0Ky/6x0a0L4ARu1ytkzGwamXTsDxt58mFq2HhSAN1U0hyd9UY?=
 =?us-ascii?Q?jvLLkCsl6E0T1TQ15h5mp3dzDjiG5qS4WcDS4Jfchwmb1RvW0wBiZj4mUu4E?=
 =?us-ascii?Q?m9yUfO1ejJGd0oazIsZtnm8PYonAdiLchzZfb2GUyLpbpjQuAGwuD9lRd8fr?=
 =?us-ascii?Q?Kwd6jLMOKCvyup1u39glESW1CX6sS9nOAJlJnbWACyx0rq5zTR1Fbiux+be2?=
 =?us-ascii?Q?/WI0dDgW1SHOXph5HsP5zSezIQp3CjyZcMHQheDvCA+GOzwR88nZcl7Wofdx?=
 =?us-ascii?Q?razP7RDB4o/v5va+7xRgKLIPds5bnftn3hWNiNHTkswjp7Fj/iKmSwBuGTne?=
 =?us-ascii?Q?iyP9Lzo7Ww+PtsTySJZLdRkadmrmKaFGHr0EwX1ykgpK9M6tBNb21ibVymxp?=
 =?us-ascii?Q?gDL15SYCk1hVCPu0X8e64TMYud0/v+i0r3LBYZW1Kw6Li8e3oiV1MVOaXi/0?=
 =?us-ascii?Q?yA1n8dohzmWcQlVf3kbz8hWODD/E0oww4Lp22pGaL5GjxEkiLg8cHWDbkbej?=
 =?us-ascii?Q?wxY7fQInyZiRST/7ZGB4EL8fOr8rYkXABtCo2hDCGANl76FhH3NxkMXHvTZr?=
 =?us-ascii?Q?651Awu1aD/+aICusUaVhh941P6lBz11/0FfYhUsSqPew?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7f00b3-2586-4aab-b57d-08dade94d0d4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 12:06:38.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VseP1TbPkVW7ayMdlZRKHXXLljXh7xJH9eXJWQckmSu097CGACJNFwZ6c2tHqj9dJ4wabmK3HWESP1wvwSrKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--LSp9OVivsvvQ9GYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2022 at 01:07:35AM +0300, Serge Semin wrote:
> On Wed, Dec 14, 2022 at 03:37:35PM +0100, Thierry Reding wrote:
> > On Wed, Dec 14, 2022 at 02:36:49AM +0300, Serge Semin wrote:
> > > On Tue, Dec 13, 2022 at 02:07:33PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Dec 13, 2022 at 01:53:13PM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Dec 13, 2022 at 10:03:10PM +0300, Serge Semin wrote:
> > > > > > On Tue, Dec 13, 2022 at 05:48:53PM +0100, Thierry Reding wrote:
> > > > > > > On Tue, Dec 13, 2022 at 10:21:03AM -0600, Bjorn Helgaas wrote:
> > > > > > > > On Mon, Dec 05, 2022 at 09:57:38AM +1100, Stephen Rothwell =
wrote:
> > > > > > > > > Hi all,
> > > > > > > > >=20
> > > > > > > > > Today's linux-next merge of the pci tree got a conflict i=
n:
> > > > > > > > >=20
> > > > > > > > >   Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > >=20
> > > > > > > > > between commit:
> > > > > > > > >=20
> > > > > > > > >   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM sup=
port")
> > > > > > > > >=20
> > > > > > > > > from the arm-soc tree and commit:
> > > > > > > > >=20
> > > > > > > > >   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names=
 common properties")
> > > > > > > > >=20
> > > > > > > > > from the pci tree.
> > > > > > > > >=20
> > > > > > > > > I didn't know how to fix this up, so I just used the latt=
er (and so lost
> > > > > > > > > the addition of "ecam").
> > > > > > > >=20
> > > > > > > > Did I miss a suggested resolution for this?
> > > > > >=20
> > > > > > > We had a brief discussion about this in another thread. So ba=
sically
> > > > > > > Stephen's resolution is fine here and the plan is to instead =
add the
> > > > > > > ECAM bits that the Tegra patch does in a separate patch on to=
p of
> > > > > > > Serge's patch. I should get around to sending that patch tomo=
rrow.
> > > > > >=20
> > > > > > Actually the discussion still goes. I haven't got a respond to =
my
> > > > > > last suggestion which seems to me more reasonable than extendin=
g the
> > > > > > DT-bindings with another vendor-specific reg-name. @Bjorn, plea=
se join
> > > > > > the discussion here:
> > > > > > https://lore.kernel.org/linux-pci/20221114155333.234496-2-jonat=
hanh@nvidia.com/
> > > > >=20
> > >=20
> > > > > Sorry, it's really too late for discussion.  I need to send the v=
6.2
> > > > > pull request today or at the very latest, tomorrow, so the only t=
hing
> > > > > to decide is how to resolve the merge conflict in the simplest
> > > > > possible way.  Unless there's a very compelling reason to resolve=
 it
> > > > > differently than Stephen did, that's going to be the answer.
> > >=20
> > > Sigh... One more redundant vendor-specific name. I wish I was in the
> > > Cc-list of the original series.
> > >=20
> > > >=20
> > > > To be more specific, the current answer is this (which is the same =
as
> > > > what's in next-20221213):
> > > >=20
> > > >   https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/tree=
/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml?id=3Df64171fdd171
> > >=20
> > > Thanks. I've got it from the @Stephen message. @Thierry will submit a
> > > new patch with the same 'ecam'-names change rebased on top of the
> > > updated DT-schema.
> >=20
>=20
> > If Rob doesn't mind this being broken in linux-next for a few more days,
> > I can discuss this internally with our PCI and UEFI teams and find out
> > if your proposal could be made to work.
>=20
> That would be awesome if you managed to work with the already defined
> 'config' reg-name so the DT-schema would look a bit cleaner. Thanks
> in advance.

Looks like Linus has now pulled this in and resolved the conflict
himself. I think there is some benefit in "ecam" being more specific
than "config" and with ECAM being a PCIe standard mapping, it doesn't
seem like it's worth overcomplicating things by overloading the meaning
of "config".

Thierry

--LSp9OVivsvvQ9GYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmObDcMACgkQ3SOs138+
s6HdDBAAgn9ECxpC+S2bftxloqfL+QXcJy0O6lFSiTHUT7bHM7RcWw6mJPcno2X9
dCthjOygQSyiwuatyksQ0Z4MuYeVbWIZffaWNeMh4jV3MEt4olVJS7Nmg0Uy3QnE
Jrl7/jyQluG6j4kRDtcRekGQDUXmLd3FPX8MEEhFlUg4FpgsjhgOCNMJ3piaQbFo
LBglfBPPFnfg2aaUu0//fNo9V9cACQoj4XTmE2pmA8n4HHVLlpbdUXZR5YQMYbcf
5BwZ02J2NvVrWZX5zKjuohMkNuFTOaYfUts33/kuCv+fhQgGBPxwPEiOf21HJyVw
KKTmFga7WRBa6BgYsV/uYXis2ZeR1FEhJ5AArQukKvF5rFGJ4VwUZfs8osxOY0X3
KMOE9f6jiWI1cjp1r/E3bS9Zuyt1eTds8ZvGrKth1LTXPKgv+34VxmM7wfUyA8QO
TJev0KT6NDYqd//RUZ6pj9SFADltcDZpsfiSrGYvR2a/Mx83wxoL3I1xHpCKKlK1
RLfPvLWOMRmsSFIYSVpCDxQ0Gag6Si53EW/Tw+5ilZjmGuHQxzrADxZSB4JFf+ji
yZlONa81gcfghSiveF7uvjOltlnarOwfQqBpO8f7lWSmC/Sj+qq+/xCTlguKormb
+zINTJmewBVv+2Vr41iSxPecVzJ9K6fvny39aAqO5mRMRK6UVtg=
=nbiA
-----END PGP SIGNATURE-----

--LSp9OVivsvvQ9GYN--
