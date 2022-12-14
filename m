Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157C464CC70
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbiLNOhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbiLNOhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:37:46 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FCE201BF;
        Wed, 14 Dec 2022 06:37:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/xh9MvPbh4yInbwRdp4ibw6eGvBtGMl8TGjPshVMhi/dCHqO1g1Vo8XNjg8waBrYN0osPUIZXibHxQidgzhe6dy93dQBKV9LrJoa2NgYURbGTgam/U6ojsxxrNp1/5FbDPZFlfFcbGtYdxha6J9hKRZtS+PV9Yq/Lh20SYExOqpcFrYSmK7iJ7Dj2cAJC1TUzBUnCv6GaUY+d26oLNK4fsaBsQY0wV5rc2qhPD54s1XTP0cwrvzvIAO4j8FYnThSMKAX15VNbR6vIqejAazO3OJfYsP3fB0+z4LM/JSnWwsfzyW2Oc/ETuzWPM/Y7lIieGxzxdmczsPrEXwIF+spg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05u9NVsG4R1JTADSobHjo6YhA+jbwmpBf7LpCZtJ0Sg=;
 b=EK2MRTpW4jAR1LlrK+uD3nlbfR1VUxw920lijOZ2Rwi9pSudXdu2NXpG7mftulb/yH5Q9dQ/N2MqgsQTFioOhzBLW5sFJNjpdyu1tYz+AJINsql3awE8UYjmjahmYwo0SRhcPo/IkcEt4sIqkGE4oUpIldP6Y8uiEbcPS1pAI+fQowcU11jB6VKOGMgkAd8DMDRWzYceD9bgE0Rq7mTsQ6xAgLh7qCwT32qC2Cj0o4CTNLMq43MWZ5USGHEMYa5iF49M+1O4DmHsRQUwRHsLSkQzcghzZrKc+S0wzYcd/Aiaxpz/XfLllHQvY86SNFcObkaIeK7QpfxW1YWAayKfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05u9NVsG4R1JTADSobHjo6YhA+jbwmpBf7LpCZtJ0Sg=;
 b=smkXypbOyqpj16PJtqeNvUO4Gb116PIo/9EM5JAFSdZPArLOeFgg8Ghi+7BT9txB4NUfwL7lRNNTY/PQQoGNRRrkDnPswM4VWgou5OLbWyw/nmf+75M33mSpzorBtzsiDcuo81y/muVodyo3xAwjITH6JB5gblI+0o11Uy0kZMoXdA5CjxP51JIUceAU+kNDtQjWfxwGZjVY70fFFGxbdVRSjS11TsgvNvLPGB/CAjLqzQD4hWbsfmlU3ZOW/sJjgPq0A9ansigYvPRP+fV4rlDJ3wRBK9nj3vJlqEsAJ3+uMIE84YSUUCIEL8AForf8BlLvlZS/hVz2/sK+Zvt0tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Wed, 14 Dec 2022 14:37:43 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 14:37:43 +0000
Date:   Wed, 14 Dec 2022 15:37:35 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <Y5nfr+AXofk9Ch2m@orome>
References: <20221213195313.GA200257@bhelgaas>
 <20221213200733.GA201693@bhelgaas>
 <20221213233649.zmmiskezdponleuc@mobilestation>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FhN8+P4MJWtqepBQ"
Content-Disposition: inline
In-Reply-To: <20221213233649.zmmiskezdponleuc@mobilestation>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.9 (2022-11-12)
X-ClientProxiedBy: BE0P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::14) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 503e84de-20f5-4021-b4e8-08dadde0c2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1NyOPlOZ9LPoSVRvmg9r5zaG2eA+S4d5L5kUGUO7pGfpb9HP4gSrLOfAAIFlibwezZC03oiu2cMFz/jU8s3AunX3QKgG9bNerkafKniOO3jxUk894N7EffDEyBQumUX+eLEo+QW1jHL6CJ+pIahdst6SzNg8B4Cxtb/0ipi2hBGWHifKUsnuB4wpd3WrD1P4ZUNjhE7qhUjO0d+46gqB9NRyWk1bGZJGR6dXYN9cj2KVbQh/Lio74POHiiGfdoPNJCYHiZfI6oo6Xy24x+zC/Qt8nLs1OH0SKvFAhhpdoYUf9QSn4XnYYPBvstycMz+j2yHj/xP6Odk4TYgjC2R72R4C+g96a46O3fX7NB8cIKksZkIZj059zEtRHXTUvfG6ZSt7V2jHRjAW1Lb4G9jjVXatNDHOrk0FGIdO7iY5OXK8T6q7G+izQqia1Q0B6tWNhY2Xw9iJYBriu7txroB36zyziIin32kAaaYGGzO7qCBFP6yTGDKnaAHYK22y19D4KD0vPdoOiF6KKjhkj+MgEi1M21xcT58bE9pJ5AXCEWZ6GuiRsJbibWr81YTBx7VjOoTKY9sna9M8SWS/5FaGSN2FQ5D9BUKvBxN7l/5xOgmUPOxCqEGhGAj+beGiLm+DoQ56/y7THyjJ3fTfUB31J/AKoKAOrBIMKFzQIUU2C3ZF42LZaEsW16r3N61pXyDxllMXaN53VbbKE3FY3UEKmOwcPOU92YR2fogmHSECe7ShxyT3N0kSjCXSDboPmxoVbdhq5g8bfD4tUA8Xyi1Q2MixswiVTVdrH5Okzfgws2SM2dpARJC7xwdmJUZDxLjtiwoo6RCNoaTF+eWdHDvcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(38100700002)(33716001)(316002)(6666004)(86362001)(6486002)(966005)(66899015)(6506007)(478600001)(66556008)(66946007)(186003)(6512007)(9686003)(110136005)(54906003)(44144004)(66476007)(2906002)(41300700001)(4326008)(8676002)(7416002)(83380400001)(21480400003)(8936002)(5660300002)(67856001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vlSqr6qLBBTLaXG81M/aey21GY7weeb0VDobJTe2PDtKHbRnLMnG+OOIXa7q?=
 =?us-ascii?Q?B2SGpnNWMvaJwpR7B2KiJbQFxan0OrgL7dIGS0+6v7rYuGcLzSVDG36qcNZ6?=
 =?us-ascii?Q?7pK3w9kbypoY03MJ7J5OvSjAt8E53a7/U8SW1kyORWY2EtDZe/Kk/weNDD9k?=
 =?us-ascii?Q?EOl2GBXjqwqaIFjQRnZLFnBXk/InPLZZs3KgNnFVXSGa1hKWDR91jQl5glXI?=
 =?us-ascii?Q?iYGHy6XplRrExuJSnYOtR+mR3ZnlqoOSe/yAE/12BMrq+OFvxxPH3twF6Jey?=
 =?us-ascii?Q?sFy0eZcYlG1QID5BZJGqb0E3WIT38n0Ea4qXF8ZINtivvwFP10c0+GMymYAS?=
 =?us-ascii?Q?dxj9iNrNbb/+wuYervkQxWXXpIvLqJ4zenwp2lZdXgD8GRR5cjXb81zEsM+S?=
 =?us-ascii?Q?7IJEZLYMSR2Gznj8fEuvstoEiCe9AUUdQxoRvjWkqJRwlrBn/gQAToTI1870?=
 =?us-ascii?Q?h6KqVPku3LKTO8a8JpR40QmIaeUIBKHKykE9VW3bje3vpL/V6vQy5VltyLfl?=
 =?us-ascii?Q?PGkmu/Q+bJLexx1Z6VlUMCf1SsX7G7X8Mh1hUFBsk0Znhph4XX7nRty3aM7v?=
 =?us-ascii?Q?UvQHhU60Xrv0K/pE9WmHqpVzN2qLpWJBjjGrIokmAksuoRpUJldHOR+geWK6?=
 =?us-ascii?Q?ajomvY0tWZACyd1iiEtkTh1qfREKBMgu5z71AIszbPZT7lZZOmMvDeGhBONr?=
 =?us-ascii?Q?XcIJ9ntkOo4iJGa0jDpvalpOb9E6wvwYxjW+RnAM1nKe3hN9Fwlj65DSPUl6?=
 =?us-ascii?Q?8qSWHb/XTIxpHfrLVdBK7Z/fSBgYVipTmkshUOe3meYw4qEG9OMFtLEHoyKD?=
 =?us-ascii?Q?X3R5uCGYNyden7uK/Wprrgh6fAO929DTML43s+2JBThBfyVBQ4+4XDRQJhvp?=
 =?us-ascii?Q?tDZMaZEySj7YQ9gIeXXtgwWYg7sMowi86pcI/8CEurdvGfZloEAnNDdP28Cu?=
 =?us-ascii?Q?nrKyxam1czqPn9/WjCxtY6NXjl738XFZJswUmsBoEeF9RFTUi3+fiNpsSYRK?=
 =?us-ascii?Q?6dvUvD/TZyrKVhMKk2RoyjrpQauNiFlGDWgqQscMz6j+2aNqWi7/V89PdILb?=
 =?us-ascii?Q?gd+pgwaQAfTt2ybm5ulluBOD2Xd8PNs+eUmchESEE8jg8nqWvYFXGl55+QcA?=
 =?us-ascii?Q?uu/dXprlIhFXyEodALIrjamIRR1+PgL4df9sW2kMFCkcyrwO2lpg4tgG2Cqh?=
 =?us-ascii?Q?/q3nMTnLMfkImMSAI/O4MoHW7ZHSZ5oS17gybgioqkihc5AzO0+K1yk7KhlJ?=
 =?us-ascii?Q?Gjd1Ir96YrpnxXMkMszQRCdk8e3TPs5mU8EqAK3HB2Yh9bBT+iWjMdzMRmfl?=
 =?us-ascii?Q?eCdHZjFGNSq+96BqflWfwA/E57Bkkw2uob7G3Ysf4z5ZI3FdyAPjA6vA2FaT?=
 =?us-ascii?Q?zRYZrmHOmtvkqYIXYlhw2Qy4gGU8PJLbsYPsm1tU/HSyk2fxj3Nk5A60IjsQ?=
 =?us-ascii?Q?GJE+tm9DSC/oGTcB8b5iTPRwXPKbeyfULD9v4me/TZdzTag3j++R1qpEXcjw?=
 =?us-ascii?Q?snDjwxx3juzA3W4+j2S7yfG6Ln1snd6kZymgWkJwSzFA3DhIPlHvldDmlUiV?=
 =?us-ascii?Q?rCswAbOT2hnRg9YnOBDSAT5ZwLBJyPA+7J0/jHQ7lrqOU5cajHtXyRkZX2qi?=
 =?us-ascii?Q?yMeMvmrak6rs4ib4IcEjkZh1RxSx47xih3UYQj+w0R5j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503e84de-20f5-4021-b4e8-08dadde0c2c5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 14:37:43.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwY0FVEbwXY8m5dvNIwFqzrjXGSgNTo6K0wijU1Gz+DEjLEJ2LDind3qhyTWXrCS6LgeDAlDRSjfiiqF8gg/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--FhN8+P4MJWtqepBQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2022 at 02:36:49AM +0300, Serge Semin wrote:
> On Tue, Dec 13, 2022 at 02:07:33PM -0600, Bjorn Helgaas wrote:
> > On Tue, Dec 13, 2022 at 01:53:13PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Dec 13, 2022 at 10:03:10PM +0300, Serge Semin wrote:
> > > > On Tue, Dec 13, 2022 at 05:48:53PM +0100, Thierry Reding wrote:
> > > > > On Tue, Dec 13, 2022 at 10:21:03AM -0600, Bjorn Helgaas wrote:
> > > > > > On Mon, Dec 05, 2022 at 09:57:38AM +1100, Stephen Rothwell wrot=
e:
> > > > > > > Hi all,
> > > > > > >=20
> > > > > > > Today's linux-next merge of the pci tree got a conflict in:
> > > > > > >=20
> > > > > > >   Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > >=20
> > > > > > > between commit:
> > > > > > >=20
> > > > > > >   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support=
")
> > > > > > >=20
> > > > > > > from the arm-soc tree and commit:
> > > > > > >=20
> > > > > > >   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names com=
mon properties")
> > > > > > >=20
> > > > > > > from the pci tree.
> > > > > > >=20
> > > > > > > I didn't know how to fix this up, so I just used the latter (=
and so lost
> > > > > > > the addition of "ecam").
> > > > > >=20
> > > > > > Did I miss a suggested resolution for this?
> > > >=20
> > > > > We had a brief discussion about this in another thread. So basica=
lly
> > > > > Stephen's resolution is fine here and the plan is to instead add =
the
> > > > > ECAM bits that the Tegra patch does in a separate patch on top of
> > > > > Serge's patch. I should get around to sending that patch tomorrow.
> > > >=20
> > > > Actually the discussion still goes. I haven't got a respond to my
> > > > last suggestion which seems to me more reasonable than extending the
> > > > DT-bindings with another vendor-specific reg-name. @Bjorn, please j=
oin
> > > > the discussion here:
> > > > https://lore.kernel.org/linux-pci/20221114155333.234496-2-jonathanh=
@nvidia.com/
> > >=20
>=20
> > > Sorry, it's really too late for discussion.  I need to send the v6.2
> > > pull request today or at the very latest, tomorrow, so the only thing
> > > to decide is how to resolve the merge conflict in the simplest
> > > possible way.  Unless there's a very compelling reason to resolve it
> > > differently than Stephen did, that's going to be the answer.
>=20
> Sigh... One more redundant vendor-specific name. I wish I was in the
> Cc-list of the original series.
>=20
> >=20
> > To be more specific, the current answer is this (which is the same as
> > what's in next-20221213):
> >=20
> >   https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/tree/Doc=
umentation/devicetree/bindings/pci/snps,dw-pcie.yaml?id=3Df64171fdd171
>=20
> Thanks. I've got it from the @Stephen message. @Thierry will submit a
> new patch with the same 'ecam'-names change rebased on top of the
> updated DT-schema.

If Rob doesn't mind this being broken in linux-next for a few more days,
I can discuss this internally with our PCI and UEFI teams and find out
if your proposal could be made to work.

Thierry

--FhN8+P4MJWtqepBQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOZ36wACgkQ3SOs138+
s6FIDxAAoKzl8R+PRvw3YzWOKT9eIHm82b26yxc2wx0vtHeESoMr90FQHHQKQqlo
JcbYMAh61La9xGLSitvgg8JwHYfiu9+rkn8B92Jxi+ltltVTY/VhigVa2X+XmpqF
lFBxBgq7uJkIBAcM80m5zSyDy94NOEjOfk/1xgdLmgHZOwsHB9W9UdAp9spGtrWT
SEJnHhXk4LDVf6nnl6B2lmjys26QTySdvsHy0LLPUNjS4DWrOqDxOJq0sYYNaSMh
WzBGtbPB123tzK9kCOzYvcKq+E5FpPqFqW0ldpVEwK/Yat7tnWel2FICuOxWjQig
s1SN1IUQs138wQItOoYvlGJ1Oy/YUUHOuPiuC5EBy+SOopOt3NrEBztnua7jaElD
uvVWBrfEtjUddkKbufdb4bEclcBaNpzY3+skwhsWLub+Pcqbfx6n7d0mqN9FO/s9
pxAUAvBjv3QyzFEbcUTExVvnZ+PQSDjgvPKIa5CcYdPXCsJTvaaZ236NTs3i3Fs2
IJAyZ4D6vxcZrve7vwF0J6450nSggajg967ytlVsgMNZX/Gvi/uJQ4/1Okec91zx
aEuX6kcKN6AP7Ua+2fh7Lwut1XGqd9jPiye0CqDF5dk2kzi+vkEt8vU3tzlRDVR2
tzR9SKr+3d8rqCAM0YEWiYLU7Q9F86nUIOdVr59bfCEwP2cZwwo=
=xl2q
-----END PGP SIGNATURE-----

--FhN8+P4MJWtqepBQ--
