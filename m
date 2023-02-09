Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE44169059E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjBIKsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBIKrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:47:10 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3DC6B363
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:45:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzDijywC91fSlXPoU3wWWxALa2rZJ0j0w1sr7YEUpQy02B6qbYgsc0Su4LE53k555HqgxsvItfnwOK+n9rnQ2WxpL5OkgqK5MAKR0bGUZgdi9TUHwiXVX7ggbnbQMtNXoNFMEucSkg0RhVk0WhjYSbECaB+TkJP9uDPeEVhHoyYRTCbNvUEbkhkaWT8BC2XrR/Vgnc5ch5YtBj6n/voQLSpdsoKCDHX4mdsyphodSljzNyIC7gbgcf0LYkItthwT9ixp/4QgQQAuJmjfP8OPez4q2PCn0pq5NEM6dJ8rAV+Bov37XuC8N5FGCZiiWafvA2Zru4mUZfNb6Pvx3zAW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjdT2I26cMLWS/Gvr0GyXlf1/8oOkbIkS40QXUfGYlg=;
 b=XCHXlXsjMPaPrbMGpJ4Rl+J9jMgscUOZX9DYMrn2O4tidbfW3/oK37FApy3Kbfi2CaaplevQyWSMZSubICkBCguMeiTsSWpmVQYgj9GOa4kSoCNn5yIwHhAN0zT23mHhcm5KMQ8q3IMVNLiaZwezysDQ25zkKP58JlUTaEkRqVNmSxylOKSUiT9qevM7kadVC8qtGKqn6vMx12f4fF/YjWnNjjMqCFa65cSc8MZpu6joz/RDA8Y3EcWFVAFJzlg7l1t4/xbEVot3oH9EKPBjf9LPXQeMylK5AwSmz/jcJJmCoSAjqCqt8nkFr/bmIr6xlO4qYEeMaq/T9AIxqrS8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjdT2I26cMLWS/Gvr0GyXlf1/8oOkbIkS40QXUfGYlg=;
 b=TyluydCYsdj/1p6eYt9O2nL2aK6nvcgwCZpaxvN/ya4UabjduPkJ3n0u0E8GxJGYhP5eyKRAixiIopj3kpNq4dzPeetpPPDSg096n3Cr1YjD0As5kVpFIxCxRcuF/RKAIhkaItLR3ocOmGgZvT6whlqZgmbswM5S2rSjcqJm7daPhUXPwwMNPEEKPyfmu+CBnqg/YKNxRYddVI4XuTA22g4PNn14ML6Bhq1CCkVygw9zjME63K6aGOtEccyy3A8rb45GH75v8thtO8+rSfrCAnKe1KYU7nQ2R37i0hEz7mNyeuIM7lXOTFoFAjmxitMd1bhStIV++v/UhNSV4cnvyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 10:45:46 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::6988:39d7:86a0:fa7b]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::6988:39d7:86a0:fa7b%5]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 10:45:45 +0000
Date:   Thu, 9 Feb 2023 11:45:39 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/of: mark an unused function as __maybe_unused
Message-ID: <Y+TO0yEdUNzWUUrA@orome>
References: <20230209010359.23831-1-rdunlap@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zIyMWYSQYQZxu/NB"
Content-Disposition: inline
In-Reply-To: <20230209010359.23831-1-rdunlap@infradead.org>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.9 (2022-11-12)
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 57422fc5-4734-4f90-d370-08db0a8acc88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0gI5U9pILsk794XVMEywU74wMo+q7ULgxHy4FypPaIwzd503f4vfPfC4zii/JMGE4yWd32ufY1oHGTlXUQ4SIlbdo5nA4I2Nw+ULdeYQ9N6nCU5OYRbsmIqgdwIMrkS+X+otsbfyFNLm1xXtww0CH3uk6LzLgos2z/oCcFNk3yobLHGAKWI5qB0KhD00SpLJXDtoFXQYAa50NkRLGhgK40XEwW+frOBbMVBj0RMudVNLf1MUKbpA6lQ4+g14IEkp/DocGn9B80QSdK2/EQZKJvPrgBiX155ONfR8mzjAZR77k7h3zkUOg5VIarPzy7bX0JfZuqh/lk4fI3BnXnaF84Qndav1WETntlrf0sOcbZs+PMADvBtwaYTn/2piVKmdZbsoMLhTzhY518t0Qwh2yhvlMqUfmO2NEd1o+BXvzX5kw7PlArxYE+nnwyUIlDqNpqCIQyHwKD1XoCqf9B+yy45yW5v54bkDcWT/ltc4xhihAPRgPS9AVEg6mONnrPGrxILINXv2xXbVuvNmRCSHQTPhv6fh36LOlCKJxkCUS8ZXrFiwwxw8xjwGZeeYkfEkolBr05l4hrGNOgPpicu9Y9pToUDvt2T63S7GaPJPjSDr/Zi+1rZ0z4BO4oxUinJ/bRLJRogNNMowMWYnn4jE9J2T8C2ZJhOe/p7fg9msO8PojEse2s6L7WDXtzRe3ZKaeg9dCZXi1w5eNbdle0X7CmBZlgE3M1EGSGijoG0Atk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199018)(316002)(66556008)(66476007)(6916009)(66946007)(4326008)(8936002)(41300700001)(8676002)(5660300002)(38100700002)(86362001)(33716001)(54906003)(44144004)(9686003)(6506007)(6512007)(6666004)(186003)(21480400003)(2906002)(83380400001)(478600001)(6486002)(67856001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VYCs6ineGDgQKprC+hzJKoNktoPmz26hvM9UjEtiHI/JOuNtwR5O5pt0JOSN?=
 =?us-ascii?Q?cs8EAR32J9KWLcc514658jNoB/PsCbBtvAdLgpSZ3VZ0rxWF6R5rYnPiP9di?=
 =?us-ascii?Q?I1f46c3QRCrTCrx5xKxbXMNAGWqr7WNhSf3YT7wzyGUQBz7xH6qVMLS6Pyub?=
 =?us-ascii?Q?CawgE8H+I7QKd5GEBrb7kqajQhnYdn8KEFo2OBf1SQoonUMYtkNj1JQ7cesn?=
 =?us-ascii?Q?OIBMkBndpk1xSqXoBH/BzYevBBMeUJSlEqpt19kScUNqCngdpjloGBVqiQA0?=
 =?us-ascii?Q?ZL6/KQLQe+oJBazdEWIhvpJne8hxiEqIw59HuIZ92t+MMvobDZJK95VVDuNI?=
 =?us-ascii?Q?mnofZtWhlJMtO6Buw7ZpMO2N7RvhFdgvvxgNrSzlwocY+iNmSDeeZypiFuDN?=
 =?us-ascii?Q?lyGRYOhT1xTFjNNXDMV88eAwfsuW8vUlWF9Ft9UGa+tjauOoF02LiC6/8lGa?=
 =?us-ascii?Q?zacWLMShyBnq8FK/zOtRXT+xLVOg9xMpnqkigjU1iBOaRQnCg2twP8QlzMnZ?=
 =?us-ascii?Q?X0sG79xP69mSV1jfxDSCJndrXBCqsNFW1fgP9i8jWQrcIxV/r2pWUh8jJMZg?=
 =?us-ascii?Q?gq1otq6dfdqtXrGuYkPsOLpfCOGTdbFKfn6+m8aSJkhaOogbqnjkUvDcywZr?=
 =?us-ascii?Q?IFN65gECf3DIWCBYeyh2pX/s4FmhqPnZHu/h9uLgKxigOPhE5PkAm3os19Ui?=
 =?us-ascii?Q?v+IMXCvqsZCfiagRdRoZPGvaAGffAp+TaSE6tK9yrqv0QX0w9b6D256Or2RS?=
 =?us-ascii?Q?b2YL5a/msRoGloE9TYQTFIboR8kKMd4oULByasujKj580XuisfXZ7yWtnf+r?=
 =?us-ascii?Q?UN9DH/jTQbD3PlIYAPZD0TQ2/k/pnYD2qfDu1FMHGEbqpNlP+DjzXJzRikiC?=
 =?us-ascii?Q?pGdRIHN7FYieHT8Eeh1R1hsfYz8qTcu6I0kkDHT1jWoAckqo7QZwXO+yqF/p?=
 =?us-ascii?Q?uFH4Gy/1jQsHm/NaJAorb+U0zK+QoVBsH48ETk6hMnXEi1W4qm1llXVKYAcw?=
 =?us-ascii?Q?JSB30+x5hW5pcvnX8H8PxDWys849FkfFw8YbSSmz5C8w/XIjRBOV93Dr+FHL?=
 =?us-ascii?Q?+R1oH3bBoLX/eU/2rNalqZR0PXia5siScPfkMnYEdY/n1vc2yeeWq/mxDLDY?=
 =?us-ascii?Q?2R83y1lnzC+e/LPQrJaZmQsLaB1CV9D+Pwu53lTdOm2z3GSnz/PcxTct0Beu?=
 =?us-ascii?Q?B9edJnQMzvKtG+yqi0ItRL+Q+ODYADvpczMQ9w9W7Iuja4n5ykNrheooITzp?=
 =?us-ascii?Q?8fNqfip+Wf/I++lfz6OUc0bRAb6yJ3+iAkTNWVFToXTkLygcFZjUVRqqOnsU?=
 =?us-ascii?Q?zj1xmw6Ovxl9Iyj4qLFMZxw0kDc/xnihMY/qxxs1/QViRO+KAdTOs8zKOmwX?=
 =?us-ascii?Q?a8nKyzTrU5ZREY/jzlztyXNLxRsxLKI8F136rXv/Xe75OfjL2fiZZmAqV7MG?=
 =?us-ascii?Q?5MckpKOpHF07ZQGKMZcj8BzTFpkemzf17287L2ohyhGJ0kJrbUtxEBc1u6dV?=
 =?us-ascii?Q?HXMoAdX2yhhyp21U7YMIKhmoE8HztD8k/czuiFoSqFAn7lji8vYa5JEwV/tQ?=
 =?us-ascii?Q?u2J8vuwBirLkyQK9IRq3rahwmdfP7MbdP0n8i+Q0bo25FoWa8bafycpAvi1y?=
 =?us-ascii?Q?KUZti+yTrBtYQox61X2/JWvh65KVwnx/4JYZUskEfnjA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57422fc5-4734-4f90-d370-08db0a8acc88
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 10:45:45.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ls4wRLKhMdNTtfeGtDTFvFryFHji0vPOy/75QQch45mS5a1kgeslbup8MX9AsTRqtDPz8Cz9Tfd4mwoYvAi/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zIyMWYSQYQZxu/NB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 05:03:59PM -0800, Randy Dunlap wrote:
> When CONFIG_OF_ADDRESS is not set, there is a build warning/error
> about an unused function.
> Annotate the function to quieten the warning/error.
>=20
> ../drivers/iommu/of_iommu.c:176:29: warning: 'iommu_resv_region_get_type'=
 defined but not used [-Wunused-function]
>   176 | static enum iommu_resv_type iommu_resv_region_get_type(struct dev=
ice *dev, struct resource *phys,
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: iommu@lists.linux.dev
> ---
>  drivers/iommu/of_iommu.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff -- a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -173,8 +173,9 @@ const struct iommu_ops *of_iommu_configu
>  	return ops;
>  }
> =20
> -static enum iommu_resv_type iommu_resv_region_get_type(struct device *de=
v, struct resource *phys,
> -						       phys_addr_t start, size_t length)
> +static enum iommu_resv_type __maybe_unused iommu_resv_region_get_type(st=
ruct device *dev,
> +						struct resource *phys,
> +						phys_addr_t start, size_t length)

Maybe this is one of those cases where we should wrap after the return
type/attributes to keep this somewhat readable?

Either way:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--zIyMWYSQYQZxu/NB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPkztMACgkQ3SOs138+
s6HHGQ//QoL+mGw1QUVwpdjWVREnT+jOyOPd0Y8gbVXHdkV6J58abv/qZyV+4jef
ckvwJOgt25kKKJYSnoeL+nt0Cths2tdgYiWaEkeYnx73JAeb40/22lGf/w9nbmVT
FJmHFIeJS3Wqygni9ltTkRB6Z6kSj+xuNo6CD/VBFO9E9nc6pI9ThS9g+z2B5ST8
FfksCRJa0LYYoKay8gr5gXD0uZ5yQzrHuc92BAkXOJibPPE5PQ0n6LKY1+pem4Rl
gy6g4Q/4EeY8KpR4JwaAfsmU+A1gSZiXEg1YkBLIhVye/mUzY4rJiEH2wYHGXNLi
czf3TSfpt9A8ENIvUcbXaKtJKPZU6++NEACBFOArileQymR1MqlSrAxHJYmlhOuh
MRGtmz0cVyH5zMsY7QorP+re2Q/jhW/HvAehpnGca8xAyMIR2AVjBe+yOcDVNMmn
xpK1GM8rLxgAwSu9Klag3fFFriu48XsHiqBcsY5U+7xPHLTOyG1e2EO8d/xS9pLF
BWcWSC6YMtXJske32knIL9HK4fcDuFP4uIeN66lhjdUz6eKXHThVJ0pIl4PIlkO/
OHXN0zwqkc6+VaA9Zk2zfrLacN/kujO/a6g2n4b93sZXVlM6w3Tj+3TcQzJ3Hb4r
+RM1I810/x/Pqiwi0FfaN22NAv7JWvi22/53/xEa6uN7iY1h/+0=
=yZj+
-----END PGP SIGNATURE-----

--zIyMWYSQYQZxu/NB--
