Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F65BCBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiISMW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiISMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:22:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4FE15FF4;
        Mon, 19 Sep 2022 05:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKshMO8mZ58wnIrhgSlpcxkTrIZR+roX858Kq/JYfVbepv6JRObx8BwwNEp2r7hqWdraGKfuhXKo9bVj92jsy69fMWveJbCLrJoXkE8yegyXl+s1AGIYK5WSl5X8Zuo3D2yHQPLVJRtdvuCFotXnh6tp4ZCj6KJBGN4YURSaAoq3ZhVA2CuQwt0UM7RruxYvSgCoFKdkMNGR8X9iiYlqxuNXpwfMMrsVg6O0jvctwnVI6vIcXmHCKjBi51ozj0vttUYcnuYifHYM72jCkdrnOfr2iSKuez53q2ZNHg9WTK/liIXu4Brq3da9ILzUfq7ToLSXY8+i6dkYdPHS5WoX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MhAJdr8xyfUMk5tx7mGyHKLHGLKeL8CTZGchXUn38s=;
 b=gKZQWRcbKyAvFF3TP3WrdB867Kd+6GqqzyBKpq8mWbEeVAviJmVlrWdV2Bx7GQEA8V9+PVBvMqxs05XXYoO34+iFqRJweb52Hcs7V1QQp//2h+Wyt9mR92oci27QOM9JsZXm5jG3Ws6qHnpUDWwa6Gf3DRdgVXX4jIatOS7aMEASO61f/Hb+0ttJ4vsYtwPyt4zvJMzcfpuaeusmuLPIrVuyPAA0Qj5yZTD1/OeAnI3Pmg8IKu1PIaB9R/qGJGDP6V0fpP0wOU+3FUzAai+hnUk4Wqk0TE7O8+7Qh5cHVWB9Qlln+x1ejRy0fvTCyJewoBrhv9rshpdIyi3Xr0gL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MhAJdr8xyfUMk5tx7mGyHKLHGLKeL8CTZGchXUn38s=;
 b=tnf/70uHDK6GyKOfTchYwnWu6nBOg8De2ZqQCqcXWya5CBtEvKmhbJHsAWbAThpX4dxdorsQJ+eCkeTKziXxQU0457bJgOzmEc4oyxyKfKHScAglRau8ph8G5L6xAGj1V77ryEM09Pnhk0UiWTFndNc4PeGjfyN0Zpig0VwvjBZ82SuqDJVAptm8uH3nKWXYkyE2srUMCAJj2n+PZu+wvCwnvHegmszgIyuVdXyPPLa/wGiKvRQRyxH7wGCr1vL+9732zNA4a99oCSmRCzJPFmIY6JBO4PMR1oPdsCMBHdWMhDsylfBxz59XLYVqdmOGBesNnneIGTVKyGth1hug5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.15; Mon, 19 Sep 2022 12:22:42 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::bd0e:9ec:167b:a19d]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::bd0e:9ec:167b:a19d%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 12:22:42 +0000
Date:   Mon, 19 Sep 2022 14:22:36 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tegra tree
Message-ID: <YyhfDKdYPv4hIkub@orome>
References: <20220916073410.3fda3f0d@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i/KkFrCdVuThPfJ2"
Content-Disposition: inline
In-Reply-To: <20220916073410.3fda3f0d@canb.auug.org.au>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.7 (2022-08-07)
X-ClientProxiedBy: FR2P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::18) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: b10d181e-0673-4d8b-196f-08da9a39a660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APo0gK6lkKQiDE8/rU18B1CR/JuBfk2HmHgL9naDAz71vYpjdTHAXtOxdNYFt1SXTD7q6Lfnuo/jtLNtUUJwHXNVSajJSDqwF4D9tUoUzMYrOtfZuQLuifsWcNymrAoJjR0OB/YHoiJHH80d51VFLo5c2tnaybXuB8QtW4oLIYOvoXNITMTC38TJ95qOX447UqssBCYf5rMjmJXjJGvuHitLlw72g/COQWVicrmyZqwAAGAmrKol6F8S0BAZuT2EKewA8MLIqDGTszVxQSY+lPnKBaHPs0ibhY33eLqioFxC6DN7HVt+ugafM5ouKDZPvL7lrd0U1nWh4MWA5naU5f8BBix3xuULJoDVTQd/lhNTvcU/KbDCyBcmmexx4CYQCl9eH4srTrfGpZtiradV+PrbYVofdGNXTzSa50bkKfKDQQRrFXE9a3E+YtDoL+gwLE8YpqJqrt7bqviCNptfsHlEzZNAkvZy7xjI71QKjKdrR6+grSugcB2J0n3jTcHw4misqejRSG5hqgWyQakIHbDoXrPaKmHhtZpwJgHLmOK+/n4kfqTF3xSrydWlApITr+iq+gJxZAPScYkl6poqbwmMJjXQxRLon3AQCmD2CFbVOYm2/wz1mDeQWK6j4BNb6D1LsVpPUH7aaKDcpG3RaK2jN1e/YPRAqf/RAXs9GA+pqDaSoyRb9cHGC1h2uCCI7pLkzaOuAU0Ju6LxtFIqAuoKcpix9w0WLLuhS9RVBoDfU042V4eLmMdQ3wCm+DIZSS3lP22ltQaWPn1IGzePPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(4326008)(66946007)(6506007)(8676002)(5660300002)(66556008)(6666004)(33716001)(6512007)(564344004)(66476007)(8936002)(44144004)(9686003)(2906002)(186003)(21480400003)(38100700002)(41300700001)(86362001)(478600001)(54906003)(6916009)(6486002)(316002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sy/9PYofvatTDzTFug72bMM0dSkGgzZZkaximPmp+KBGJ6tnmW43TQC4+03u?=
 =?us-ascii?Q?Y7jkr7+KL1c1LcyWZHtoc8ObgtgET2xrltazRAJpCCcodOocyMoNIW8d8ATu?=
 =?us-ascii?Q?nZmCfEU/ZumbocM46KiL5jnaALJvry/8NCxsH+n7q7mP4tkuuJ0+ixp7F0P2?=
 =?us-ascii?Q?zOOABxcau95dEyLepLRlYVNKIjPF62lWd6Ph0u+qsbaZkKEWmfeQ8tCp4hKq?=
 =?us-ascii?Q?CUTXx69DU7t+SJKJ7SkPxWBAqyu48nupByZLqnbRx8OPko0YQtJw2g+J6fMI?=
 =?us-ascii?Q?yLVawOEe97pclYMLj7WCRtXjEKC8ya597kIB+4V1CPyRZ24QiOc5vWVXMEkv?=
 =?us-ascii?Q?fruBQFFsavBwr9huTRCk5lQ7nWDysZe7rGl/q9AJgIjSxmhD3SU86wA3IheL?=
 =?us-ascii?Q?2zg5HdauFu/PPVnUofHOoNRwDl7vTVPzDhe/T281+lpxTWzzQtPUqecehyBP?=
 =?us-ascii?Q?G0y1BlaJmQX/pNnXFclGXyXOebS7tqPShlHqJ1gDzx/Pooo2hjzP4Th3BGF6?=
 =?us-ascii?Q?WJbtzfJjgjwg5i3Aak1lOpyopjv6C3fzTxszk76h/kZr3qcXwCHbdVBpp6qn?=
 =?us-ascii?Q?QmmB4TVtWdqwD5sRNq1YbIXawl8sRtE/FG+pNAusxU8atnl10hMf+DL43vLR?=
 =?us-ascii?Q?vu8Qghnw67HOcHhBgA6QZ+qHWG7PFRdnOZDT0bqwYRIR6Km0EBAaqVfui4Q7?=
 =?us-ascii?Q?wHEIovkTcJmO4LlBIEKwhPGrrbZ0icDn0wa/S+xXMCm2bobgJULuAusDdwlm?=
 =?us-ascii?Q?nLCq9BisoquJriXJ5/zbIvtusQXhNVpbU+KS74oLImPNBQCju15NYb9IHwn3?=
 =?us-ascii?Q?dmR7dzXGmoTUGEMDuFGCBjhpaZUijvKqfSL9OIAWLhXToDhB2EvXuCf03fuA?=
 =?us-ascii?Q?Ay1tJFZVFacQVAzU8J52vLY///HgBTaXdx3OLZCuarowaBfTTETuC4R+EArt?=
 =?us-ascii?Q?bjZp3wwfv6/dp+V6VX2L2WFZmNnezxEtG5hoN60gvqdB1lcTVfh2ZvWyA+XV?=
 =?us-ascii?Q?10E9r4kHoVWTBTh1ZZOiy2sEvHKgTlJIBOKC5PAQXBeK1GGsX4wZtQv/X/i8?=
 =?us-ascii?Q?otxza1mQpKm0EHCvHXROrfD8Y9sK5PIVFCb/aH433YKAvxcEyBjAG1TDYAVc?=
 =?us-ascii?Q?d0TFKVK00SJHABtrMWVJ6f74iLyO4wo9NR1RGRzSXq28npOohQSNsF6Wu56+?=
 =?us-ascii?Q?rh7WUjPCbN3pXTMMi7amrwsNq7+jzm1ukKWZTsi7zS8zaLG8R76l41MoOMSY?=
 =?us-ascii?Q?lqVO/UeYdfkipGfD4bigmh/V0y+3i+wZLr1XLpX6jSvC6o3qE9o98gj+prXH?=
 =?us-ascii?Q?frnQ7SoUBb85hWcnAxC9n+ddBTi5g88I6H30Q7o4h8V/LygGqCKf2nU0syxz?=
 =?us-ascii?Q?ywB/4gpE+xQnMnfaTjsUDNHRuFwvefQpffFcThoblFagDtRSczHRykAd2ijo?=
 =?us-ascii?Q?IxDUKdvnrsjEo82YULsIjs2aeGDleYSWZcs2L0N1FSq0oDrDTrynia0YYEy3?=
 =?us-ascii?Q?NBnkwZApn4qYFOac5a+iKpiEcE/1Qdcl8XClQgq2sMeAtadEMvUKfpBboJy/?=
 =?us-ascii?Q?JTnPtamt44VU+Ndk2L27LQDHeczJu4DOLAeyeQeMnjXzLpuT7b/mJ2t1+yLk?=
 =?us-ascii?Q?7Ad4MfRABmWnbdwiSr8D8JL0nhzqg+3vOYtxZJ/RQoHV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10d181e-0673-4d8b-196f-08da9a39a660
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:22:42.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhP7R2McWpxU4qVe4gCp00pPMDUKeAPSukIoGweCYuyYQi8QU93te7zSblulWHJD4Ra1BrJi/EQ1+5wman5Yog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--i/KkFrCdVuThPfJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2022 at 07:34:10AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Commit
>=20
>   2254182807fc ("soc/tegra: fuse: Drop Kconfig dependency on TEGRA20_APB_=
DMA")
>=20
> is missing a Signed-off-by from its committer.

Hi Stephen,

thanks for catching this. I've fixed it up now.

Thierry

--i/KkFrCdVuThPfJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMoXwwACgkQ3SOs138+
s6F4ng//UvJk23lLNyvKYu5VfYXRxAUCXd0zte6lZS35qHQid7M86ElBbDGYnuhL
kjOP883XFyuxXx7l3VwUGBndwCnNC3mEMsBhbW2mvZNKAMSPfSDY+TwsrJkHvEFs
b5d+t25eVBfIpcCPqynFwTi/We9MNbrGRbEpJNSLQCVsr9iyd/ZgUhHTJ/Z+oOd1
sovdJ5Hxu0VMiD8qncSFwMncGyIW7LlTaCmvsp/BjKleYrPEml2lRHsMZkaDhl8A
YHRhBf+CxLPzbuFJ/qIujE7oMokkdU2jY4AvqiNTelf4vC0QKW6B9416OXdjA9Aq
yl+xRMRANUP/XEGBZlSXrvAwgvg8zrH35CNPh5TZ7bJNygw3/zD+HcTL6NRHewRd
mtlakHLJbRTaDJEgIJ5+fYNQ6oiwOWoj7uq1ClnCIG4sJD9959Ldbhiepdh1Ht7l
4pc20OlKFXQd5z7vUzlurfIQA0bxOpKjDGUU59Os1w7TPYnv7Sh+UAkxvuxKDEMY
CA4uUoUzTCnV3jVhIOAnQfZ6Or3IYehd8ESLMH8NefHxQkfKMTdQeZtfAu7zYIXI
PYWwPnrkAAC+bqC1d6BBhHDaxG7Z67rzle7YGp77VFaCffujA0swaASVhZaxIFK2
Ry7Wq4BU3VxPPDzv1JHAOSM+D9CBF/UzymR7Rw4bIHOiQTCNHO8=
=bosV
-----END PGP SIGNATURE-----

--i/KkFrCdVuThPfJ2--
