Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3F743A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjF3LPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjF3LPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:15:51 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB21D172C;
        Fri, 30 Jun 2023 04:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfXMrQDqJCEJPKz+7oG0H0hLz0ehDFQlqCLqNNRo9uYvnCr3Px15BxHYxn5TWRQEk3JlxOXvjEQ7gyZwFTwsH4UMR4H0Dg0GMrsS3oskkZITu/cGj+RSTMzd0ZgkflqckVr+M7rdNiOgUIDQuOLX4hzH3bkWXnYVlOgK6WtPGSLvW2ZxvFmFYrQSLixV8ihbCbpBPgf8ry9RpJxJC0m5WslWvtg3Cy+f+6cSChDbbqUz6qo9hieYd3bE5Ausmnw3wubic/Ejtyd9cLYct93Y5D67x9VYc/VS7JABnZtaxcV9oap/2roG7e2EnTwe7LWewOFWdg4nh0oBbJhgGyRhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN+oRSf9VnlbzRs4IegNkomtqtmPll9lByHADPtJNPQ=;
 b=UYAFdlzTZ/90aa4qL5Bd551ek9fpsjO8/NXq4x/jJ5ew/YYHKlS5j3XPv8D98IyiS+BGyH58moeVNebTdJ7xnaS0Rkw405I4fTRPl2X3gVJlnDRPY2Vhst988Gh3LsNoGh9uGeDpV6xhKJ7kZOcxKKmVyXvbg2wthoEbVPkeNEcbG1mVSu0FTEKrSPDY6CVGIWwrJCzZyFsrHkJ72LXb3WvrYF5PAKWRsu7TUk9We/dZaG8dCWlRALm1thCxelbfAhnpdihLz2aW5SrqEJg8wd3J94aP/2H13NieLBkP717Wpi83E1wSZDZhHpi131tMTizoniGjO4Ta7osbpTqAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN+oRSf9VnlbzRs4IegNkomtqtmPll9lByHADPtJNPQ=;
 b=iWskuEzB2meBRV7eCCCh02HwOc8lQFGxeESrUmvbBtIIezH3Z4x5xZpcCVnDfXUgr1gtQH6gU+ymy0+CCMAuMqXOuC0a/DbFzuLTosx1Ky0SOzm0WJ7O6bBXxWdgm99/xRpRKjnOrnqiJhPdMLnsm7Ey2+fW7zwo/OQbfPU5rlg7C7NUBjeXPLpi/JAKrGM1/LviX+u5oDg7vIC2rAfPrbkyNizUur0bwVSNB9vBR4j5/cBlIqgFwA/7+9neffAcqbOnOnMqhfp/O/JaG7En40oEqQwPrv2/UnaHl03Ff4Iz79GvILp3C3TsC1h4GnXRHcqb2mtZ3LRsO/xMbpxSJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 11:15:48 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::5a6f:39cc:8277:f151]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::5a6f:39cc:8277:f151%6]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 11:15:47 +0000
Date:   Fri, 30 Jun 2023 13:15:40 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the tegra tree
Message-ID: <ZJ65XCYh3cr2OMLM@orome>
References: <20230630084726.3d3e47a4@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yNEDxsKcgSmib/Yc"
Content-Disposition: inline
In-Reply-To: <20230630084726.3d3e47a4@canb.auug.org.au>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.10 (2023-03-25)
X-ClientProxiedBy: BE1P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::19) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9e3eab-6aa2-477f-9991-08db795b5aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNekAqeajKam+32vsb59fSEW7f61JYmpKdxghk7wr7EQzOOvX0wK30Se+xNJMJfsFSF0er3ArrVPm9XV5F/UC4juD+Q+GIoj/h8ryjiL1SUeTCGbNU3azgxrbcDvVgPmztNKK4nunoR3aLqnAzSBWg6wDXwZHH+sEAz4ZQm5TS+uNIpn/G+NaeuJiZLV6Piwq5ye5UmJiUpBEBdj9OJSFr+SxQLR1bV+mdualGGwik+2WC1OzLpMAIoy+f4T6nupS6mbLwSKRGH1yEUXGaIx1CD+8OEboONGLXXYd5TinYPezhd/cCGyqF2oB6NGWit4awt2KYktg5T/+0kEgbXsk2ZiAlo763WPQf6X1PIB3X8ARtRKfq5WBtfcBlTI7GiLoPTbqmBFOZEwnM1SY+WX1u3WTaQIrztskC6icobeuSj3MkReNWki0kb5fU8KU7xAIHMILIGGOvHVwrjH91Mlkh8wPH4YwDeuO7lq747q5S8q4doS9B59GuumgjC8MnYd5fMpUTyQMV/pps/33aZBZlWdmugCTEN3gTK2oEIWJo601qd71VLdGYl1Mmru1Qt9aympPWTp7lEaVMB+k/o/2jSs8aC9Fd4sgRMfm6uk/jOJxI82hwxgaDsWFcL7370oEBzP9/tJclrOUpt7kzj15Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(8936002)(5660300002)(316002)(66556008)(4326008)(6916009)(66476007)(66946007)(8676002)(478600001)(38100700002)(6506007)(86362001)(54906003)(41300700001)(6486002)(6666004)(33716001)(186003)(21480400003)(9686003)(6512007)(2906002)(44144004)(83380400001)(76924002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I+ASs1RlT3oHakolP2t3v0Xp4+01HuwqMlrmxaF5W7R81u3vg439xNHJrEM0?=
 =?us-ascii?Q?8xPjdwNV8wiSAqZdudK4SPWfrpQ7l1GCzBlPlcR5eO8TbcCUkpTk0HVgFDJx?=
 =?us-ascii?Q?wgdWjc9izBv8WEzBbDBZMLFTPdo8jLrPkArZhbTLZwIRjntEKF9Pwyz874Xy?=
 =?us-ascii?Q?DrWd4QJUGRkur+LvMNqQpkxQU2XXbCq0QqdjoW3PWItkL82MKmq5gnThMbr+?=
 =?us-ascii?Q?lyNNoeR5t2q1M9FGdICOXWWXOmYZdLt33W9XZxaiq2OaEFYW93XLLTHGxRRd?=
 =?us-ascii?Q?Dhc6La9Ok2NBsLWFaYOlSTDsukd9P+5IV977WADt1Xq4BxJcMGKfHBEUEkT0?=
 =?us-ascii?Q?qaYtM0ElEAa6NklaEenChXYrIWM7ToUHyBKRM32E7MkMM8V2OkQJmjaY+wzU?=
 =?us-ascii?Q?V6SkVyk0ORBzQVALmDduTlznpVQ4dWE+KCiOiC33Yfu5B0P5U4A4/rpEU72e?=
 =?us-ascii?Q?9yTWWeZC/8a6A5MMUwigfDAhrref1xTrTAPaixgQf1i+Vb8AJGjYUJABdR/2?=
 =?us-ascii?Q?IqXlW9Kjv5t0d8BUXS/cd5XnvCpmsF4JO/UBomQBx1gspF46cZ5zveKloZbv?=
 =?us-ascii?Q?PbMc90Xg419wFFevdFU8b3rnbUf8HyNHeneMy/tQRuhvHK4KMD2RKU4AzlKb?=
 =?us-ascii?Q?/47MFa/rAzqGRHKElEBF5cBnMRdO9yBRt+wo5mhhrracMUDmruGiNwcYlj0e?=
 =?us-ascii?Q?z9Yjc2UzOEuaaaYnAUSFSnuE8p4+FghUttQdaSwPHptoKIAeAEB2HX/+YZr/?=
 =?us-ascii?Q?+lXmz3doRIW4qg2duDaFNJCCcV43UsA8nYxAba/g5zuO2nQfG6iciWGVDuIt?=
 =?us-ascii?Q?bRoZI/cG0L9iEP7L8XzYKl2xLdMFneJE1tvf4oashPB9bOJtOvpOpRWuN35R?=
 =?us-ascii?Q?9PeKlzNdPEOqN2y9Ik64KCjrRMhUdSOx5J6mcUr1ZA/1t9pMnoMEggu49lkH?=
 =?us-ascii?Q?2OfPFZHxoCby29oFjCBoKLq5okdEOOnY8bDf2wjfe0eJ74pE+PZjK2zdbi8S?=
 =?us-ascii?Q?QFK/N/zpA66Ad5d4/eX9SmdDZMZ4o7AMAcsZYRvFldpe0jOpPo4j7OqfNrvX?=
 =?us-ascii?Q?A+/RldEg5ShiYYBCn5vQEUozh8uYLa/+MX+zzxAEL9pubtRwXwy7pjEieTj8?=
 =?us-ascii?Q?mjjCjYvAqQWO5ZYZWsi7kcsWe2BJP+tP46zrjHqpOYbgiDSuxGTSli9E23ol?=
 =?us-ascii?Q?is4XQelTu2COC1YXGUW4y4BC3pccfc4QgbCKOrejz4UfbJtFOKcPS6KNcQbo?=
 =?us-ascii?Q?vvlwX8S6OVqesZist+qtJF+OnNFlJ19C3M+lHY5sy301Va5SCbp5B4AICx5b?=
 =?us-ascii?Q?cI+7zNWXCyB9gZ9DfpjMUdySjDgufkhnJmM2hakM6TIpgyhYQmxyhsU2Tf8E?=
 =?us-ascii?Q?J6yZHVo6uZxRKO0imh5ttQtp7xtKcO98nvR0l8XMpfHSLzFQUU/OOXzyP3fp?=
 =?us-ascii?Q?vn2P7UaD/GKlL09Ux9umek7Q8ANkKYPTlnu/kZaUd1g9NfTZNFYzYVu4Nh3x?=
 =?us-ascii?Q?P5CO8hEvk6xB/lgOH+YdQLaJ27qQGPKsRzjmRZaRxyuL/PkOWg6FqTKi4xTE?=
 =?us-ascii?Q?YrIBAFlNMF4w0yNhMZtfBRtherlf4FJFwcWXLTadhd+b+f+UJZcgIw7dhIMk?=
 =?us-ascii?Q?YLerVUQOwhozSD6Tc+Kg/+U5u8037CxqCYl9mhx6z/v1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9e3eab-6aa2-477f-9991-08db795b5aed
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:15:47.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gw9iZv6i+qahDpp/z99WnV0KTfYumSHEcjPBiyY/uOgvidNC6em3QsfQZ2YorYUu3zT2Ie/45KulK2zmk8+TQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--yNEDxsKcgSmib/Yc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 08:47:26AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
>=20
>   0cfe33924cd1 ("dt-bindings: tegra: Document Jetson Orin Nano Developer =
Kit")
>   9928d6789ac8 ("dt-bindings: gpio: Remove FSI domain ports on Tegra234")
>   f13fe44fff40 ("dt-bindings: tegra: Document Jetson Orin Nano")

Content-wise these should all be equivalent, but the above are from a v2
of the dt-bindings pull request that I had sent. The main difference is
that v2 (specifically commit 9928d6789ac8) has a better explanation of
why the patch is needed and provides background on how the problem came
to be.

v2 of the PR also contains two additional patches that somehow didn't
end up in v1 of the PR somehow. They might have been last-minute
applications after which I forgot to redo the tag. They aren't critical
because no device trees using those bindings have been publicly posted
yet, so I can easily queue them up for v6.6.

Given that v1 of the PR is already in Linus' tree it's probably not
worth doing anything about it. The commit message would've been nice to
have for posterity, but everyone affected is already aware of the
details, so no harm done.

Stephen, do you want me to force-push an old version of the dt-bindings
stuff to my for-next branch, or is it okay if I just push out an update
after v6.5-rc1?

Thierry

--yNEDxsKcgSmib/Yc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSeuVoACgkQ3SOs138+
s6Fr5hAAn9gXEmJbP2R4m2R/db15IKvxMNDvU0+Cun9LDYk6TrDjZAJBCPskpKSm
EAhKhx964s37uW98BdBHBDZuKBCy86rzxqvYrlo2Ad/NwYjWXt6Is7Yj1zeld2fO
qjsVbsBxBZfW93etIcviZlCyTumzBqHPTx6uJglU4hjpcc/3wUEE33qtXdmYY7rP
47loM47A7pY6N8/NbiGXfN2qvrEev7ZhPdeP+qXkRCtWQh1PJUQT2RX0rdLfyoSs
2LSXz7dXUc2klyEwVTTrnjuKKJpI9FmAH4RPEmgh6CNmCXC4Nmit2oSsvcnZoi9T
o17h4ItfTngTYPkZnH931zvp0BjjCcSu5MePKFVQCcL2/mrpNYgo+oxfu0h0BeyN
JhEmhfAUOaNDi9xwqJwZmu/kcWTWBmLpk2q88L3uuNKBQMJqTxFB4tby2imvGzD4
vjar+X/64umgx9css41sSALn40lfPoi4bfhmz8cJ6+CrnTyhbIYmK+fD8bqIcpc1
fHespdAIgWa7QSUAB+m2vTXudVfE5r9EzFPSicLvo4DAgZGtDzlv11fOtWiQAuxj
pwcc3M/iQWTjXkc7478q9avn1aiBtMbq0XSKF7vJ/Sit6wUadgFH6AZgQtLypGmb
G2TW2YZEt4WSNHgoUZMrrj0RazVq5sJw5VRN+ZxBM9nO8IIXbYM=
=hI0o
-----END PGP SIGNATURE-----

--yNEDxsKcgSmib/Yc--
