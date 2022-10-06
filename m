Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7925F6C94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJFRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiJFRMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:12:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1653B6007;
        Thu,  6 Oct 2022 10:12:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er9iC6fMr1lwjqKhhPbuS4SCWXq2Ibgsdi/Aw7KfB1elrpk0TNqzWWghUKjK/e9rHowH5oe4Xi3eMLyVoxrF41qYfZfy7TJrj04b66T5A8h0ice5JpdFNi//g0+5NlC6CSOET+rF5Iq9nG7VEtWR2eF0yJ4uOoOpx1wcN4fr6LtR8UBPpp3L2sVhlx1G8cTvxIF8wuBkc3mwuwfoOT02Jkxd1EetgcGOBFBDXllXcp4sVXnw6BQbiey77uWbI2YwrHKDyPyKLnKzDo/ER1g/QoIZeOT7BMvhn9e5zE9Fm/Mp/977usbfgV0z3wbANhFUPIVUZeCVJXtAYvqeST0hKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKw8H/3WVg/F0lY0Epx8jxur115i7jsOGTDqyt08d6k=;
 b=aTKuCrBUnOLQpZSb6fUtkPtmC4yQrXwdFny8KUrgwOni9ztf9XWlA84r3QWSiB47kezpi7ABjfVS9n5rRPb78ON5S42bHe3NbnYwuEs34Ao1mwFt3MbWxa5+s7kwW5na5EigeAOenhl09ct2fjuq4N+oW1rtRr/9Swz1Cfrh0GT9hdNFQx0KKDPDGJYYcdsflt8XensN481JquXAzgmu+jtCcM87l2S4VfyxDJJyif9EcnZu0yeQmgIYEPRzMFxXd0U9UJRLE0LFnHpSfkQcWriLyvT/Wmvqu53F/IJr3h2PzkqmEgfbs36uyYv/5+1TvjUS4/jgFf20pDxDZzPlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKw8H/3WVg/F0lY0Epx8jxur115i7jsOGTDqyt08d6k=;
 b=a1LC9TTQ+IXzrbsuXn2S2BZR0gOypGUDFRJ4NLkBt2x6orpNDjQJO37eXapRyrDlO7frU7JCtn4fXeC4Y1IyctK46ztY7PGHe4DMcBMVcXdXUc8w/qC/Kd4vQJIQJO2aYZR8iuoAx/QshldQW2FItfXcQBjxMizTDr/xholpJNI4ez+o60Ge1RuHjxhGCGktnPBCDLg866JDteuU+/1Lb9tUsk1YLmxfnHmzJfbxOgH4GhTduMVuwzSAsYBzcT2HtxMJqKxiQGne3Kyl0N5qPGuHKikMfATI98nfVs/aCjUwWSsXKs8t0YM4WcPftkk8ns3IFirWnIQQqcd7SoHhUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 17:12:16 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255%4]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 17:12:16 +0000
Date:   Thu, 6 Oct 2022 19:12:09 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 05/16] iommu: Move bus setup to IOMMU device
 registration
Message-ID: <Yz8Mabz/SL7gG9VA@orome>
References: <cover.1660572783.git.robin.murphy@arm.com>
 <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
 <89d873fc-9f0a-156e-dcf2-48a2b9f93dcc@nvidia.com>
 <583c4689-844d-2ae2-79fb-4750b21c4304@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D8msgOXZHCNGXvlZ"
Content-Disposition: inline
In-Reply-To: <583c4689-844d-2ae2-79fb-4750b21c4304@arm.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.7 (2022-08-07)
X-ClientProxiedBy: BE1P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::6) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: c2733923-f3ad-40aa-7046-08daa7bdeb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LX2ZLmxTzljJSmLjnlrQCrl4vdlT0BE5et0mOaCUuAmdY/nbpSp08N9PlADMDY8NIPe3J+aI6AVRauwnfFARuX9sZY7aPRoK14eyOP2NnRby5Evfz2LqdtxzkTgj94ggMIk7303OxxS/L6BOSMGxpmhMVCWvHx6AIFJjLZ2nUfEVQoXtuYz3zc/+uJhAhsKUiM3Ju6JCOKwr1kjsBhEEUqoBVuJE+EpUYQx3dOrHDv6XavS9pVmBNivHRrJKyxU47KId/+wP1OrXEQBBv9wR0I0wXQ/ownmS6TIvndCxlYpjmDlM8MktCFTMfWMnBeHgKSEXR3rHxGJ42nObnK3t6hdyxJnyN1VovtTvUYmoDSdI2DECh2qrwVUQN3veRaFY21DKLTnyr6eUcSpvLJjTWxl6VcsizYxu9yxaeLRZUh5jM4uDHDPx8DQMkgTOdul6nakCi1TYS1UmDuy0D02xS/+pn34bxv1GPjQSM+7pyLp9uU9Z9PGLo7d88NTeCNzHhfxiQ2rreO9evTvrqf0koYXnV5+BgH+JmsMbv9x5/lqmWgDoWnpCJZpJuRAub6TaOP4B3Heqcnv1+s/bwhw7uLliY+zOgyqpziOK/dJKWE22N5fCMDKAtZXoA/ET0VajWDSUOWR1bfWR6Gl8u41nFKs/x7yncUaS0LQPlm9YynAmxCo+KyoNtjF/NP9kF1/pdgUei4xxPW/HfPfD/JKKhIzXba7Sr9IfOym3MrcjEMgMizaccHaR6X3Q+dfw/iNsUeueYEsDkswddZ4zdhx5Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(86362001)(5660300002)(7416002)(186003)(316002)(83380400001)(21480400003)(38100700002)(6512007)(44144004)(9686003)(478600001)(6486002)(6506007)(53546011)(33964004)(4326008)(110136005)(8676002)(66946007)(6666004)(66476007)(66556008)(41300700001)(2906002)(8936002)(54906003)(33716001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FNazVLRDVGU1paK2UxdklRaXZIbldPTDdBTGhENkV2ZDVVWWdRRk5Bbmh4?=
 =?utf-8?B?TEVrL241RGJ3TnFyaEh1c3YxdDZhc1F1bEhEQ1hub2J2d3JIS1NJT3RMYmhp?=
 =?utf-8?B?enoyLy9ueURvM1VyeXRmL25Kc3YvdEZ3aEh5OVpLZWJGdmFheUlSYy9xMnVl?=
 =?utf-8?B?VllWU3h6ZFhKZEdJMkorOHNMaGd2V3hneG9MUnhINkFxUmlEZXk3M3lSb2RD?=
 =?utf-8?B?NWJIRGVBMkhNRXFIMUtKWWcwUkpJRVY2Tzc2a2NxemRwZm9EVnFVeFVsU1BU?=
 =?utf-8?B?U01PY0RPM0JPRERYQlVPYjNQT0ZiSXZ2ZkJxYjFwTWhhVmRtMVl0N0FVbWxr?=
 =?utf-8?B?aDMzSjAzS1lDSHB3NnpIWUx4WXQ0MWVZcUtQL1RKUWthTCt2eXZPSEtsbkVz?=
 =?utf-8?B?aWxSYjZZK1RBYXBMYnRGMmhzbE10K3Fpd1RUeVNtemcyWXgydVhGblFqM3NZ?=
 =?utf-8?B?M0tWVVQ1RERXZkZqbVR0bTB4MFRydHdKRHFQMVFnMWd3QVpBazRsdjZSeTVu?=
 =?utf-8?B?dXlKeVczcnZ5UU82RWMwSyt2Nzlob3hTSzFTQ3dNM2ZKdzNDNEZhaW9aSG9Q?=
 =?utf-8?B?NnBFbFFycTNZdnZiZzgydlRuMnNTQUJKYXlRMk1rVXErZGIydFZyVUFuazdB?=
 =?utf-8?B?WURHWDM2L0lVUjB5ZUdlOTlSL2czMERXaUliQ1NXRENzajAyS2x2WjRyRDRK?=
 =?utf-8?B?TVBrelZCOFE3cFFuQkRmcW11OGdUOEVmK0ZlS1hOaUE3bEUvWTRwcDlpSmVz?=
 =?utf-8?B?SnFuWElHWTJmckFyUnAzMGZUbi9vTmF4N29PbjVzMUV5NS9SSW1yMWVjYlcy?=
 =?utf-8?B?OHRoTDl1S21PQk5RRmVpSnBXMUtqVms5Y0JGK1Q1bzgxWm5NNFoyT1ExM096?=
 =?utf-8?B?RzVPQVNDdzVNSzU5R2VRSExONGRlMytIcVB1ZmtHMXV3WWtQVTMwaGJQa1NL?=
 =?utf-8?B?TGdGWGgrd2ZMcGc1WlRMbVlWSEVIRGZ5NVRxTFhMTm9tMTE1eVk0NFFzbzZE?=
 =?utf-8?B?bjltN1J4em5iZXEvRG9YNEoxSnRRMmhONzduZml1T0plMFZMb0tGeEhOY3Nt?=
 =?utf-8?B?YlovRFpMRHJNMWhHVERQSThwLzVKeGdudVdRSnQvUFJGZ2JPU2VZUjVIcUJx?=
 =?utf-8?B?NkxTTnVzSmZ5YjdvWFR4MTFiZW56YjBEYTFmQXU2eFRua1BmbEZSY3BMQk9P?=
 =?utf-8?B?d2Q4aW05SlAySUEreVlOTk9vT2FrWVlkbEt3WjFQcTYyejJnMnBrSDVuSGMx?=
 =?utf-8?B?QjR3ZVhHTkM0alNLOHpYcHRWa0RQa1BWOHdua2dnNTRxek1vL1ZDeVlsYUU0?=
 =?utf-8?B?Um95YzFiODJPeit5MHd6cUFpSVJWdHFuNlNpWWF1dE1WZXE0azRGYkUwSTNI?=
 =?utf-8?B?WlhyWFZDYlowNDArckZuREp0WHlRN0FJdVByTnlsa1JsZGNHdm9mZzMrYjlk?=
 =?utf-8?B?dG5vSGJPenQwSUNjcWFpdGs1OHJzR1lJWEU1MWxSNm10WXBKb2FkNUV4amlX?=
 =?utf-8?B?NXE1NlpSVTlqVTVJU21OOWRiRFkwNGttd1lZRVRnbXhNY3JMV01sTWVhZ0Zs?=
 =?utf-8?B?OExteHlNc2tIMElvQ1p3dmcvY2V4VUZuK0tQRTVZU3FNQ0x2Q2lrOFEvakhx?=
 =?utf-8?B?K24zQXhoWlBZbVlyMVprT2FhYVlrTFFKR1E1ekx5dUpzTnRINUdMMnNmOVM5?=
 =?utf-8?B?R3lxK2xUczYvaThNNFgvQzVTZkxOKzNiU0JtRC8wK3l5WlRrclJRdVdoUlUw?=
 =?utf-8?B?Y1h0M0xsdHh6V3NiK2h4R1lJTGFuQWcvWWxrRDJsZGZ1L0oyY0tKTHhHc0RX?=
 =?utf-8?B?OFpxSmFuUXI4NnRuM3VnWEdBcnFkTFpWVWk5RjlKMVNsbmhuT0VGZmV6eTlI?=
 =?utf-8?B?V2NnOEtaZnRLL3R6TmR4YkxDKzcvdnJVa0EwV21WNTlSNDBPYjRyazRsVk1p?=
 =?utf-8?B?YXJjK0dnQTQzZXFNUHBneWV0UnhKWUo3NUxrdnZpenpFeXlGZFMxamFlNUVV?=
 =?utf-8?B?WmlQZ3o3N0RGY3d0Y2FOMk5iR1ZtdjhwOUlCdCtDTk90aFBEd1dRb2ZRbmQ5?=
 =?utf-8?B?bEdmQ1crZHg1dlgybmczQTFsaG9INXArOVh3MG9DNW5WODkxMU9LRk9kSEov?=
 =?utf-8?B?bTNXN0RNSXE0MCtGdlpYRjF0d0pJSjI4VE40WW5sOW44bmNuSzdGdnVzS1du?=
 =?utf-8?Q?ZiR197h4gOsHLeWqKt4p8QmFS3lMiLt57HAIqgKSTTxF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2733923-f3ad-40aa-7046-08daa7bdeb45
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 17:12:16.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBrIhLxYyiVI0ByZfefzg1C73896tDDH9KXl7hV4SFdbGOnEonDfHrRj/q685ueQoZalZavC+jagbTqM1DBUJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--D8msgOXZHCNGXvlZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 06, 2022 at 04:27:39PM +0100, Robin Murphy wrote:
> On 2022-10-06 15:01, Jon Hunter wrote:
> > Hi Robin,
> >=20
> > On 15/08/2022 17:20, Robin Murphy wrote:
> > > Move the bus setup to iommu_device_register(). This should allow
> > > bus_iommu_probe() to be correctly replayed for multiple IOMMU instanc=
es,
> > > and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
> > >=20
> > > At this point we can also handle cleanup better than just rolling back
> > > the most-recently-touched bus upon failure - which may release devices
> > > owned by other already-registered instances, and still leave devices =
on
> > > other buses with dangling pointers to the failed instance. Now it's e=
asy
> > > to clean up the exact footprint of a given instance, no more, no less.
> >=20
> >=20
> > Since this change, I have noticed that the DRM driver on Tegra20 is
> > failing to probe and I am seeing ...
> >=20
> >  =C2=A0tegra-gr2d 54140000.gr2d: failed to attach to domain: -19
> >  =C2=A0drm drm: failed to initialize 54140000.gr2d: -19
> >=20
> > Bisect points to this change and reverting it fixes it. Let me know if
> > you have any thoughts.
>=20
> Oh, apparently what's happened is that I've inadvertently enabled the
> tegra-gart driver, since it seems that *wasn't* calling bus_set_iommu()
> before. Looking at the history, it appears to have been that way since
> c7e3ca515e78 ("iommu/tegra: gart: Do not register with bus"), so essentia=
lly
> that driver has been broken and useless for close to 8 years now :(
>=20
> Given that, I'd be inclined to "fix" it as below, or just give up and del=
ete
> the whole thing.

I'm inclined to agree. GART is severely limited: it provides a single
IOMMU domain with an aperture of 32 MiB. It's close to useless for
anything we would want to do and my understanding is that people have
been falling back to CMA for any graphics/display stuff that the GART
would've been useful for.

Given that nobody's felt the urge to fix this for the past 8 years, I
don't think there's enough interest in this to keep it going.

Dmitry, any thoughts?

Thierry

>=20
> Thanks,
> Robin.
>=20
> ----->8-----
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 5c5cb5bee8b6..7b3f7fd6e527 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -230,6 +230,7 @@ config TEGRA_IOMMU_GART
>  	bool "Tegra GART IOMMU Support"
>  	depends on ARCH_TEGRA_2x_SOC
>  	depends on TEGRA_MC
> +	depends on BROKEN
>  	select IOMMU_API
>  	help
>  	  Enables support for remapping discontiguous physical memory

--D8msgOXZHCNGXvlZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM/DGkACgkQ3SOs138+
s6GqQxAAp/MtKKQyqkKatmOMKl9ZN2X0McHOR0+9OXHIkNDh3yrXWwxO+5LmYVW4
hG3fgM40qhEqt5Tfo0QIER5kleMh4r3rwZCyW2LyrXFdYNr1xUViC9Eg8Oy2aeEb
it1DE2JT4N4RviIwu0m+9uQCE53QVF3kZAbWxJ/t+ufgNXgcjHGk6CD+muPyUm6I
rRxtUxb2V0ukhJlR5QfA/Ll6M/xrOsGNxhxOkRFqvZYXvk8m2OkxY7aCZtUHps89
7nvAwCVurdCvb3V36su3H/0bMtdxX3h34foB+u6b3eplNUt2AL9b/JUZEBob2nu4
mLyz9CJ9/I1YCPF7SHRm/cAA4eUILhwmcHEnuAYxdvIfPoeoxR22xzpRge9V9POF
NAiK1BypjLwftYOY6T6TJB0l+H/+pifJ/SZZVHhF97lAXe5PYoym3KWj9BQqrg/P
9ck4okHSl1Y8cYwZiUb2uEUOYT7mvI9Otm68bDWSXCBFdIwfk4B4XoWKSqB+tf9G
EDKo4C3aZyOx+7ta+MGsEqAgdHuY57Rd9znXFDpYwYCiwrGzd/x36BhxRi+w3oP7
uG7ijqiUSq3JyvVIHW5J0m065aH11/GY8R8hbwQhLY2QkMCFv9PZ50exNEhyZP2k
VrZatCsJ2lSe3MUiOe9dlv2mNXhGykFlspzuIZXlhLfOjVijCKs=
=ZD+q
-----END PGP SIGNATURE-----

--D8msgOXZHCNGXvlZ--
