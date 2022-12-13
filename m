Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911FC64BA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiLMQtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiLMQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:49:08 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9B1E724;
        Tue, 13 Dec 2022 08:49:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DULmI9icw6As7VYny7dbpLvgBEWYVWT2LJ+l/c8hgshh/u2IOwbthgesSQUzgvOALoAzomERQyBgFO43xtlbzYZ17jSQ/I520/k6OBsmKSoyfITeJU72cB09OuDB/4v/nulAQENv3SLdUOAbtc/GhHcAr7pAMy18Il0X4OFw41/EiAJmRdlIb12DMW0Rn0bFwgo78PQ+u1DZUyThWLAMbkbMMYqE7lHjmS++HJRknDjfVqrQVVpbgBHuyFqmPIq1dw/hx1IVDRo6pWDQ3Xi+njeJSnMnL1eSkPOVvM89l61f2vN4l9BuratsBe6WZivTal6Y6tuMqVPYiIQrggODIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AurmBtbLmP8fGvs9ntDLKyTbJObCZl0TYcHdBMo3PKw=;
 b=GF0SofaFbpL7oy9oq8+G61KJr90Uaq+k7U8fmW29sAmxr0FmVKdcytAL5HEs/YBR1udz7/n58U/PJW8DQLgRzanMSpxNURsKzNSDuwDmnGmV4DivaBOjApz470+p4P+SrCs0lkbS3TnQ5lAYGlMSfGaDwQYzwIHVaULWU2QuUg6c+AnZ0SV0kY77HAuEQi4mYVu6XY4m/ROjP0kCMj9KHgT0k4SGalfJjJdOaC1llvNQ7PWIOTsyymQNTONclZLjF2AAHaSvWIbeGLMNt4xuYxLlrGC3gjz+mCCWOdq2j3pFYEPy6Z/Vxk52OyoTIESmoxugjkJ4SBoOaHYf4ofmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AurmBtbLmP8fGvs9ntDLKyTbJObCZl0TYcHdBMo3PKw=;
 b=eLZYekxqgZZaUcettRq3SvPqEt8/ZMRcF7t0OJIgms0/K3tALPzi4J1zKdxiU08jEwzgte8CPbP0HCyWlnsEPH+EVwzaodWMUvnTyx6yKWwQcJCatXugRdC3kgkrx4EQECvpXexQpZuvXi9Y28kdFbIZRHqNNQyS+r8LzWpPo/5Gx4Of2MMQHV900ir03bggRl9a7x1EJZy4gkfAxnlXbn8CSCYCe3m57cgU4xJVIwCGQcWhOiinSXO1gpKKioxoaUibU/gOLpscybh53sYqstJfR2Us8zk1DIm7LEaU9PzVZffmS1trXcbDHs0V7xdA/DvZgOy/Wp8cpmQybRZZdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 16:49:00 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 16:49:00 +0000
Date:   Tue, 13 Dec 2022 17:48:53 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <Y5is9cp6WdWixwgU@orome>
References: <20221205095738.607b9551@canb.auug.org.au>
 <20221213162103.GA106222@bhelgaas>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0mpWKdjTJOccsDp1"
Content-Disposition: inline
In-Reply-To: <20221213162103.GA106222@bhelgaas>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.9 (2022-11-12)
X-ClientProxiedBy: FR0P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::9) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: e6662035-409b-4911-fa24-08dadd29ef36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGv1v+/DaFvbb1JLE+rbp7fGUn7DcU9nnSoYhWsYk2AGXmA/TMo9k4qOJ5zM2e9xLQI45EM7RukHaqBiS5+S8sQ/0i6RU/bGNmNPI8CEG0Kflnf/HKUUbhdwU0ogsY3VNdPt4cVfuBDCneVieSLDAhiTRbvT6mGCHqL0G8ZDANe1OZQN+fXCfZh6AKQennXuPMP8YOmso/Bz2SjtLDvkWPa5S3S/W8qMkPtt1AE4xQV8nbBmEIzKP3OXBZVLSHdo16M/PVbnj3L3DsafQeZc2xAxMuLyl35vYqdAVow5yNHOhGIIyXuG2YpAGbEtm6uBipHkTYO/WqYJsYRtgxjCiMoI71vR90te/xNGkzgZe6F154pbXwoegxNgVcJreMkXAonGi+vJNd5j324Ds43W9VnZ7Oc7nNpvk+dvJrQlLkcPz0w5/TYPlw53FPRQGZj9oTsukxMWr9qjz4TlFKj6zyRWdnOGNdlm4FWgOnHzX6EkJH6U/xIlnrvi44KWgqJoIrXYVXSzS7eMzrRyZrytgxCbP2FpMqlaY06s3o2khEwXc8gRQ0lUbG/WZ0l5pt7EOlcibrXTn5j+l98K8OlGqU3N4ZhzVOORw30GqHjsou3O3VVXjb5MSqeplNXRUoKQ+HAaSmoigo/9Fph/t0Q+53Zq6rdU1wowi16xy3diFPRQ/JhnuZ+zcuEHZKTZLu7L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(86362001)(44144004)(6486002)(478600001)(4326008)(6512007)(9686003)(6666004)(66946007)(66556008)(7416002)(66476007)(6506007)(5660300002)(316002)(41300700001)(8676002)(2906002)(54906003)(6916009)(8936002)(186003)(38100700002)(21480400003)(33716001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4qvzWkgvVy8QH34Gd0d9/TqTp/nFDydutSLEzZhkysSrQ/Oy8RLME8OaZTwJ?=
 =?us-ascii?Q?liqfkg2stP83a/f3spTAdOmapymm7DrOUCMtNeAsYrfAuGaKDUrwER+r5sCH?=
 =?us-ascii?Q?k4eoBhre25NROXgJTYRHuaNMmyGDbUQjI7x6zBm00uqBbtmEL89PpsQSSvXr?=
 =?us-ascii?Q?v5kgv5+zIGHgdp/ZRpvqZPBziVSp1Sr92pZlRmLTdenoS+ZUH+GjlzftrO1d?=
 =?us-ascii?Q?G5h1VpCkMVdlyB/QHFsoh8GiqAHr3AXNRmNm/QgTSdzEekQKCHi8dPKy++Sc?=
 =?us-ascii?Q?pL7jc+/tjJ+tPHtywtQHi1b0tfVlF7m4vRwTkOhggega5YRKeUdJS3lw1yZP?=
 =?us-ascii?Q?2t4tnue5vVgZaOi/eB0GlQnDMiUeudR7IWmPM+mFzYoPbumPXPtMQOor1D4k?=
 =?us-ascii?Q?ai/ncQW2ATb6eYeRZFkuq9RZSpQndto6K7RzwXIXyFT6d/icpPrJ99zlehv2?=
 =?us-ascii?Q?kkVyWT9XCJpfN42GtqrEg5ijeMjWYVK0aR7jlme1uPLVrBsVoYmiFfyiwzUL?=
 =?us-ascii?Q?nWMj+OZWtt/AW9DC6937Eo86zjpqaYuKz0Gbq2LlwfKRaUzCnKQ2lwR8KD2y?=
 =?us-ascii?Q?X0vPsvagrC1wVzMJw19cCycoqyATVVMrL3jvL2wv9jSxYXvp1mekOIlLXhXu?=
 =?us-ascii?Q?QMhFBL2gmATHXMvwOW2lxvj/KujvOqW90Lo5+DkzRo1cRHJ14cSgjQRziWzw?=
 =?us-ascii?Q?qxkycO62grTyI6xFgXVk47oBZNqy8i+JeZ0DW3TFVW81ZFGmE5ZwyxbwBvXU?=
 =?us-ascii?Q?lbWgyaopmPnVqbqZWoewo0m/2poaInYtQfO3vc0wsdrM3W9Q4CHznvBiO4QQ?=
 =?us-ascii?Q?oG0p+clRhALNye4N7NdSX6wxbUcj6UtvLZdXM/tG1xMAFOQZmHp5o6T8hLqu?=
 =?us-ascii?Q?yj0ii8cYzIAfeu1jl3wh1NU+6Pll89sGpDFsz/XktBxEGvDRu+YywvlEnC+E?=
 =?us-ascii?Q?6yABrvr1QfKn4d3GgxtHZDhXHNczC7tEqiRG3DJ0RZW17RimI6Px5+wIeJQy?=
 =?us-ascii?Q?X3e8BkzwPOImjeLAJFgW4MLUpUPs55Xx96t03nicei1/SNcdCi3Qe3Ippy1L?=
 =?us-ascii?Q?DAOrugNc0yL3+/qcVaTcVbAls1gLLsAb2Oiz7+OqOflntRDsLInSwxlXXXKu?=
 =?us-ascii?Q?+aI9UWESZSeejLCzo4mhuPm8gaMyt2sgRAF/sXYpaoScn5F7jRmzNwrNm8Yd?=
 =?us-ascii?Q?Y1HlXexJWnvG3/FLoFCNSsCxI7elPMQoCFbu2BZl4Z3pb1iVfiFF9p6QDhJj?=
 =?us-ascii?Q?953nEtH1VTBdCSpxgwzDCq6PuWZlu6LQQut78EnxkWa1Q0x5E42ng0etwH5o?=
 =?us-ascii?Q?MKK/WU+Dj/jb1hjoDn/IYXsMSQCIZ4eqCTL4tsRUL6JAIZV0XTBoXJb/xdAM?=
 =?us-ascii?Q?BG2qgRkaLcOiU5PSxdJbcPTRPFnsl9TcydnsdOAbcBRZvt0jp/c7J5tjt4k7?=
 =?us-ascii?Q?UBQkM6Ta/q1ui66txv8w41Gf0z0JY528r9pg9jrSU9pNgQbVIt1lIcdOdUya?=
 =?us-ascii?Q?qDDJmQPjylRAa1iDIqAuenLTO8ZGK/1UhIpvOnG06gw4afVk1lxgi+TDhgkm?=
 =?us-ascii?Q?Z8hKnY5ETSf9H894rpSzMxEjeCjLgDMx/8j0Vt3xd/Bz7MiqyKtUak3qxfLz?=
 =?us-ascii?Q?7puOZH/meNpTHoOLnRcESGCYtDXDa1Ts0fv7koWY3rTr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6662035-409b-4911-fa24-08dadd29ef36
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 16:49:00.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkTdrdubrnQhCERMkmn/8srKLE3M7QE9N0wWcFSZ21Xj2sctDHvsaBk/GE7Upk9GID/v1PzHCIkGOf+BZ2xhCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0mpWKdjTJOccsDp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 10:21:03AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 05, 2022 at 09:57:38AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the pci tree got a conflict in:
> >=20
> >   Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> >=20
> > between commit:
> >=20
> >   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")
> >=20
> > from the arm-soc tree and commit:
> >=20
> >   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common proper=
ties")
> >=20
> > from the pci tree.
> >=20
> > I didn't know how to fix this up, so I just used the latter (and so lost
> > the addition of "ecam").
>=20
> Did I miss a suggested resolution for this?

We had a brief discussion about this in another thread. So basically
Stephen's resolution is fine here and the plan is to instead add the
ECAM bits that the Tegra patch does in a separate patch on top of
Serge's patch. I should get around to sending that patch tomorrow.

Thierry

--0mpWKdjTJOccsDp1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOYrPUACgkQ3SOs138+
s6EEghAAuPQiw1O7wFpguaspQhHPqYkzdaIZJibB9FRy6025yT9XrzzUDvv4VqVB
nDCBxFam8tK3m1fWoB/x63w2Rnvpr/5Bq5VD8CeTtfwH49wDBgPByciiFxteE+p2
aCBADgUiPd/rBuIAVFrXETKlYA42/2lVjZxsGCScxCot4dxG8nD93xpws3Y+Yovs
7YuLcv1SjPabiZ3ohMyyNcX7wDNam76cpWPxW3lvI17ilWOwBlflbgsGOqWAvyLz
4AtMjv/5k9UANb3euAt9q/R4enVAYb+rV+TtO9oG3+xJPNA4U689kmK1LfRP6dX2
rAUtp3Dfc+xO/wQTSulW8Y3TZp0oOSVTn2G71UuQ7l+qelN67OQ7dbsulqvAgB9n
DjKCN8pfet6MYiprjbKBTlE3GwEJfDXs+/k0nBWap7jW7NW/FCYToqojMRB37Ty3
FSpzqeNV1khyunGN1l1VXN5fxK49VgmX+pEIlm3wA9TC//0sSXDrZ+bxCsb/9w2X
StA/LlTnKAcoWCzXXZrrj2CfyzEAmcREydROcbE02MXbibPKc0LMY3R2w00BDH0b
SHRopyR2CFwFSySY6fsoZN6Y0gcNpDea6hAdvDRHCG/PjxNBYG0oLeLw+0jE1buL
SA6BZgfP3tIEHMZne43pj1hR8mNT+wqg3vyXYBask3+jocII/6M=
=qjbn
-----END PGP SIGNATURE-----

--0mpWKdjTJOccsDp1--
