Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC926621252
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiKHN0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiKHNZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:25:59 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EE027B20;
        Tue,  8 Nov 2022 05:25:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRoPe6NXFIgGVW190EcDRkuCET76T0z+vfubgm6xLgcz69sUMoWbpSrCAbeGOEi73ZDRzttiuH/VsqPr1kyKFlt+aMNxtye7aTK12QbPX4jUdMbqH2fpzJqeyPN2+3MQL7nsVUZhnDxdJNIWrGLt3uvDRiNxgXKaamDHU52UYScUeMN7restV3ch0ulUxIpYZU9x9TTv4zGCINjLiVn/Fjn1bu9WUYm6SJBxJMLwBxM5FrBpJBpDCuyAbvGF8I6lcKBlyh9RMFHJupwgqMb4l+nGT4Zxy6L5nCBoHRrLWm/hKet4Qp0jyyej0kAqRHbAvX6x6qbw4p4f9q4LnMgTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SZAKqWaMgFobVa0k1P9e96cy18+JvcfA07h7E5e/20=;
 b=T5PzvG2jzAPZIprRyBqfPbfApOiOzPLDPQ+gMaH47YWkDzfrbn2+Igbea2w0F0WozTnbjKAzYAtGboMhB927JP7zVFhP4RvY9qvAayaTBFNhASPuuiQHyc7VmkEg+OHOgmD6JuaXdrgUDtUXLVMrNnUeB532+1a2ZHSft9be6JMOAM97sprQggv6YI5fy8jd+Efo/+lpq5iNKc8g4yhcbmuS/PBX9rVuhThaKFkXuWbnnKn7lPusJDTUMVoaYV9UNLismnIaejbqhrOsiqxS1ThK6f5TUE9WB1ZBfye7/zyAlZTtSZAgiYJBGP7XXMWAL9PoiyYOcDAL7mhV770lmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SZAKqWaMgFobVa0k1P9e96cy18+JvcfA07h7E5e/20=;
 b=guBeIpCiSJJQyzTFpcqM1temHMG+KFvdNXLm54GiUhMGOJ+x8Qux0rjnoth0p/keso32No3l0MFw43PvN+LVuHfJC+9eqe+ivoaBDFB8igh+VKdgkNn9hp3SnGAYLQVCMH0oeLWrmgISV7vZboY1pM/pVee2QYxPznMwM6s1kX7LgA88PE4dDNLp697Iqk3q6sk3Gt7bS9+QAgXrIfYFYSdVN+CRkHh7OSvFzguSnvOTZcCmOReiteVuoZsU7rTP+vr8vEVB70NaxUFEUeSGXhT6+/kwQhNOky0zplwYQJIH0D4drpUdTVlql8wDJqsq51QEFmphtjOBx4B6azgu6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Tue, 8 Nov 2022 13:25:54 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255%5]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 13:25:54 +0000
Date:   Tue, 8 Nov 2022 14:25:47 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Ninad Malwade <nmalwade@nvidia.com>
Cc:     jonathanh@nvidia.com, linux@roeck-us.net, jdelvare@suse.com,
        nicolinc@nvidia.com, rkasirajan@nvidia.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] ina3221: Fix shunt sum critical calculation
Message-ID: <Y2pY2zuJOII7ko5l@orome>
References: <20221108044508.23463-1-nmalwade@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dz+E06QEn44x9X3U"
Content-Disposition: inline
In-Reply-To: <20221108044508.23463-1-nmalwade@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.7 (2022-08-07)
X-ClientProxiedBy: ZR0P278CA0070.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::21) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 5327df66-b1d4-4d6c-4dc8-08dac18cc363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTRdDYRGkEThldwOzEiTJDIBrt+ZwZdoTZ/Mo6S4uO/xuGq/AV0vCb9cOv9muW4RBQpOVd0caAPYIw0slFOQPdy8Vci5+o0r+1FcVSd7JDsvizHvGYhdFaJf41qoafjHO7FUKCNHxnRxvkx4saCBWv2f64RiCBLbEWLcJQXhU2ZvVb3pSwzw6qeKUwh3Mx/z/n32gmPoCHM8IsM/CauCY4RdrdXY6ydnLXrINSPrrIStNIvVbd+MoTO25wTwNOBJrqYw7xoGBGbm88toJiwrM9ovOpbEnFq5IjnIhiCQTdKpHi2KDgViX12f0p4R2eARooXPkW9mxJR35E+I/kNchAu3l9BKlAigb6QRJ3tfxu/Pxwm7bA6ruqt/Ml4PS9SqFYqyNak9LJ5oTWBVFgtxA8Kwcdc/u7fbYbovXJFhDG5ZL4NkFgOmHjgx3nGpue6odGubfEewXR5DFzKOtMwz6guSEQyLQLj+Di8AyE83mQRvjhtEZsyzMhChQ6mz1GRXv2L0biPHcZ2Kyqj/2pFIEpL78V250MLT8RBIS06KN36uuPpaUlEiwIjubuKr6RtUEoGuJhVERKpmuggc5mTRrs9Pxv83hC/sHOxzxDsP1aXmML/IbA9r1H3Iw1Eex305jDBJiCQS6+eONOBNetfG+uUCTTebK+ytsXftesEIXUuKxbxRD75sER3gO3GJDl44OovTr6vM0uxYdbk+ENPl7+sEJMwN4Bvw4dcI/E60LgQSSNo5NvxHZSmGN/L/fuw+Lu2gX1vUxxk4XQucGEKq4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199015)(9686003)(33716001)(66946007)(38100700002)(8936002)(21480400003)(41300700001)(86362001)(6512007)(4326008)(5660300002)(66556008)(66476007)(8676002)(83380400001)(6862004)(2906002)(478600001)(6506007)(6666004)(6486002)(186003)(6636002)(316002)(44144004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N9QLY7UL6T0v8osRDxBMNV2N9KXqxMGOY9Kr4tdVuQUnUad6cbnQa3crWE7q?=
 =?us-ascii?Q?K//XiKzO9swPLivkKfL+ek/MYO1Lg29MVNEL5gEhbnwJG9j8xv0jFUoVUPs9?=
 =?us-ascii?Q?/86vWrZsmRL8wQTR7fwR3QK+45KvAOLy2HxP1hObHMzHt+12ZsuPEKG8c9GJ?=
 =?us-ascii?Q?4YsvtInhmmMc3ip4aDzqkJeA79uSfp5SMWCXh36aV0o2R9Cd7bv8oFYmdxRX?=
 =?us-ascii?Q?ruQWVRzB+OPEJj0YPV+aEMNAw/rV1d4S1NcWJzzmPV1XOXlLOnGsgua8g4Yp?=
 =?us-ascii?Q?jr/qvaZ7azAX9peuBHj+W1THWXoT1P0xkrXR5pxUPtmesOvpGksnV2JVlXre?=
 =?us-ascii?Q?+Ot2TrAaXTD5eVMDue1RFDGaeq4yAlqyT/Na/W8ezFu8Uze2sM3JKf0pVo1C?=
 =?us-ascii?Q?jfPZyUsEtB3FiabJDTmH5AXUDyeM8FUHuJbjLseDS5BM3oEFdqUa9aDRnVFY?=
 =?us-ascii?Q?w7KKLzrfYw+Lq6yVs6tkME49uufr17+4if4JJ4q6S5V26L+mmYdLP/Fb6rcc?=
 =?us-ascii?Q?XND2dYDGVDW/nl/JxB8yOpuF5v5iHYbSUJpIBeCRSxl2rj3ZP/tbeuy+2Zsq?=
 =?us-ascii?Q?Wq0DrcGArkXgoa8LPbN7PhiZkUbA+Smw5LGcUFsniixFtNWPbKTIlT582fyQ?=
 =?us-ascii?Q?lDM296R6lIHP+Lg8GLfdGTvGDSjGHWQqzYFHZ4ZuL2FFO9Sc9kq9RJOcuVmT?=
 =?us-ascii?Q?uuGI8zpi3CcSnbyBap6BrIQvl4ltLl7y7tFthTRDZzQQ7qJ4lNL731kjm/OK?=
 =?us-ascii?Q?czZoH5CArhlX7znd70s7G6Z9lBuY5Ok6wLK8AtR+aL8fctkU9IbP+NLxHEyO?=
 =?us-ascii?Q?QgwqEolIbmI2CQEtAKPH5Y6TgB4MT/qyN0LvihrJRUs+TMkhINrDH/ElnlZ2?=
 =?us-ascii?Q?bflxDqCLZU3CzetShsDszPYTAufFL7ftOt8qpBq+hqrhSKgF6I+dAWO4aoso?=
 =?us-ascii?Q?zLz8fCh7N1e+AyjNlhXrq1+j3EaT88pwDaf3TDWxwYJCiZ/EMmDasDXKGxgF?=
 =?us-ascii?Q?NtnY5Y/lux0wOtVXB5O6NH4CmYLKluS3xAVL/+qG3DpP6PQyTeLEIngHeUAM?=
 =?us-ascii?Q?X/VukGF2wnUuQ1vsPGHvT+sTXGgGNGOrqIdPhdlyD8WkCB8iDOy7cmzT+N0J?=
 =?us-ascii?Q?ANI2+oxl1T/QIi/8abDfSjlzopeg99BRRas2uvjOD3Z2vf0qw2ATx+UEJP9w?=
 =?us-ascii?Q?XP2GhJYeeO8wpU3qwCWyjts5/sYoWiYnFvRFAS/8INQ+1DoeP/oNXZo3VNRW?=
 =?us-ascii?Q?8Afq1aDVA/bkwppsu54EROooVUEsX9d+9XOd/Etk19v7st1pBvmtaeYhB6dH?=
 =?us-ascii?Q?tccR8cfLcGL4lFc0Ez2KPCqMd6N3oUAdoRL1FCjuhMSpCgKxxATCcRqFhzfq?=
 =?us-ascii?Q?gtBFAIVTgVeN7TiPZ4M4UprrWxkb9g67fx7un3uclWBXTsj8GGYDjiv9pBdi?=
 =?us-ascii?Q?tIZPsvQm/b6C5nzYuxtrapxg6WiOPkeLfD3AgkoPT5EgSLOmE2sjZJqxwJn3?=
 =?us-ascii?Q?bk9mtfbvtKiZSVg9ikuzDHISbDazlKJptThgas4gnCHeu/4X6oguToaYaLRd?=
 =?us-ascii?Q?uc/PIFoh6s3zjIqLGm2bUviAluzV4HAZnlLzueD9bn6xl0RxtTSU0R7E6/jI?=
 =?us-ascii?Q?T0zGO53SEzilJXgBsz6WwcWqv+JL4/hrhRZ373fV+BGu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5327df66-b1d4-4d6c-4dc8-08dac18cc363
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 13:25:54.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Cnx0zB4JPJsThGWJL+WGu7mtJ2Qdbulbq4Q2InSCFZ9vyxdf0JFFPOrLhKesMImrilAJ6M8hvdCMuQp64Ullw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Dz+E06QEn44x9X3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 12:45:08PM +0800, Ninad Malwade wrote:
> The shunt sum critical limit register value should be left shifted
> by one bit as its LSB-0 is a reserved bit.
>=20
> Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
> ---
>  drivers/hwmon/ina3221.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks correct:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--Dz+E06QEn44x9X3U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNqWNsACgkQ3SOs138+
s6FHzBAAnMEN9nKG7OlDS8UebUlTaljXcj2Nux1w4gFpte6f6RCkCeK1yhFuoJZg
UiRRnX6rc2ZQV7v7pxQ4Obc6c0UlNLw1jEBcBimpbT9UpzqcCpT5etgOhSHlxGpa
02NVf1/cSul3WqYVOyoHhj2o5ZTpb/YbwGJnt/0NJBfkjxaxkU8/8Zoa6Db1VTHT
de81ZWZ1goshN1SSGbrVuMCRzuyPo1sWUaW7xfxx+J8+jHQYtfrixupEQdP/v4o9
dxJamUXqHNfkeWvH4AxURbrS2wvEAy+5HumxdKuylnvn/jtnR2rK51MFmUZiHq+R
vYacepcSah0aQJCruh62gNMfPVHYK2PkR7IWtW8q0ZsdQ7reAn/M9B3T1BstoKkc
EpmYygAAjngRhpH2cGtvFMOPW2c9IFng27iKUjQqMkHR4t03bXQSu+LlrqHjZj2h
V1d4g0G9pb8+mQyQSgLuW0+v5uTT/9RFc1uoD9RCuQKt735tFTvtGgj6wU1Qn1KK
AUjurxDgC8DzqwJCPhQckTp/fKpJmiB3K6j+dM77StEUhw6MuDrsPFl1ietcERn2
tB0WOpKWU2e12Z3UuCANgIHKK5EN0XPV+NmogfblgcC77MdNXIrR/+QyBg8lgvda
EDvlLvimsjeuFKWf1G72AjoVb9wzmsgZNoBEW9NoNirI/gpND6I=
=fca1
-----END PGP SIGNATURE-----

--Dz+E06QEn44x9X3U--
