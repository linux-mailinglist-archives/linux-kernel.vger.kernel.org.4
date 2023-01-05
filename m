Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0935F65E85B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjAEJ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjAEJzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:55:39 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC5B59D01;
        Thu,  5 Jan 2023 01:55:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4rs1Kkshfo2fmN6z/dzal7DZAZ5qi+fCmpOT+RihVHD95Kc6fIi20z+e6KTji+X42HiBEjOxmGxyMLk8LFxQfhSAWHcMHlG0d35MJlitxlzM8Hep7uG5GDehiQqgGMqeh/ayQQrTFMC9B5ypmDOl2v0mtsNWUM+FrATi0N1B2ijfu9yT/HziK6d63sJWSiU1XABiejyZ/jjvldAY27kFFsrzGtEotJyXfihEUXGLPGF5d2PNQnYcVfnHKik5Rvmk/RasFRPsfysRw5AzxYW8tcIAkv373h8hErdi+71k25Mk+ai7q5itEmBmboiRZpz4GRGi8Q++Wvorbs6dNko+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCLSsn7Tk7H54yhWV+UsP0yreEg9E2JiJR4Hx4KjBao=;
 b=RsxL3Yu0rQmDLxjO4ejp9yAaUS/DXWtFriTSVWtL/JfQ5Ns+Zsgz0G4LaXHGNOKLscubSDiMau5xknusH2Te/z5RvLH0inpDCQkxjCJjYRnekplO878dMqTlq++VH2fjPT70tafbEGu9oo4I4Au/EK+F1nFoqSck3OhxJSf2QwWFR4a4l3J0RQfdm+3yEeUfQqfU9N7m5d8XDAb/fGY/7wOyywuREeQTe6KSagdMlh9PmgkzbgcNk0D9mqQNjXJPDIeYBnMAET8ABiAMzUVWF3zEJ41H15hS/pCQYFlcMLPUKW9WqB83AV4wG6FhuB1i3suO5zK4+Il3Go5Mw5HkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCLSsn7Tk7H54yhWV+UsP0yreEg9E2JiJR4Hx4KjBao=;
 b=sBlUXV5cD02VHoPQNZTDIG2sIZsiCflS2AM2oGBCN3DxMnGZYi05mA1/mRFF1w5ME0DqcITD/OzzOSewWa0eV5SyRWdznkscIqDoQ+qOe06OaJBsfemJMYWekofSIQL9FBqirUXu8MJUt00MMym+DBU7adUsWzKGvvwW6mJ7RL0bu51pkeofb277Xk/eHNN4GRqGN5abz1sx1JLXh3/Y8xwS94J9CgsLbi2EtIei3VfRKnOqx/dmwPGkQXWDj8SNWLsd4l0/+FMp7JG3LRBYenpOR3/1TiS3vBYFyFkeF7fUVU58rp+oAREB+4BwyV+epD3OmtERF4wOewxC558QuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Thu, 5 Jan 2023 09:55:27 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 09:55:27 +0000
Date:   Thu, 5 Jan 2023 10:55:18 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [rft, PATCH v4 0/3] gpiolib: eventual of_node retirement
Message-ID: <Y7aehlqlwRpQJ970@orome>
References: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
 <Y7WsSh6RCNGIgml4@orome>
 <Y7WujAWPlZ/KWDk5@smile.fi.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="77WwaPK1rjyjLr+e"
Content-Disposition: inline
In-Reply-To: <Y7WujAWPlZ/KWDk5@smile.fi.intel.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.9 (2022-11-12)
X-ClientProxiedBy: BE1P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::19) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|BL1PR12MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: d3442591-5db6-43ef-8be4-08daef02f89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHEUyenUxp7OgZnrRXDTyyZR2+pCfn/xPfy05Y481BbUfVmb0G5z3EbnHyZMWvGTsYUx6+7yZLtAPz85vl75pVI2sp8WvC0h2Si+AqvF1A7azRsv5Y8nyzz5h+4xyqmlCrw/ujxrWFlV2XHU1pf7HSHaHi20K026VRpZxi6Qu5uEHHDYrbdjM7OFMGLwV4f3fvjzGUme72ocJ5IGDcy8irvt57353RhEd1+Hrn5sFhv2ce3Rf6vzeJ1v7ipfZGQGQ/SM2yT8y+iw54G7cUMVL0w+VKfKhueQrEC3k6qkkIeoeY1DvF7YndTlWAx+XNGzkAbCfKAByntYmxo+DPD+dQI5FM7ZMOKUaSpUJGEyAaXAaf2Sp/GBi3Nz0FgXrVrGOi81BteWdxIrUUsKhVubKtiJKtUaj+Rq2ae0HlM732Gcb3dFHJ4zCzjyzX5wqrk7ZymY4kQ8M+SJgDKFHbleK2uj+jRahBzEilWBbLTJndTBpCjPCoGfAPkiNhJ5j005fxaX2mxMD+W9VBMMq6d6J7FJ/8b3FShotHaBo/8AEMB+hThu+O7mRjJIfcN4vYO/qUaSXSqBFihujQZtUnqPg+XTZDITIg68qGOOyrsMuA4gGi60OVb481oUy6Ez4wLqXfsxLOxt74PnCU6ujud1HdwQZDl48wfyzHWMcPlo6SmbGj2ZmYa37yU79JOtpOJsa9W74lwHBtykZaZewezFnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(5660300002)(7416002)(4326008)(41300700001)(316002)(8676002)(66946007)(66556008)(66476007)(8936002)(54906003)(44144004)(2906002)(6916009)(6666004)(6506007)(21480400003)(478600001)(9686003)(6512007)(6486002)(186003)(86362001)(83380400001)(33716001)(38100700002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGEvgV5ywayNGk6whnP4hCqoCznPZQ3XIwyp00mlMt/2LutgJTMv8Y7DyFkf?=
 =?us-ascii?Q?PMEWnr1LHs6sST8PzpqsWn2bnvNzyZvdXTWJUg1OrAwpvv1DClYh4IG9viUj?=
 =?us-ascii?Q?Yh3LzlKuhY1FsEWkZMQCiSMTfAOfVcI88X2TCjb+rnA5uE41UAB99SMrPAUk?=
 =?us-ascii?Q?Mf7FUASJeMQ1wb0q3/2kLbwKIlxlIfa5xQK+bzUbUYpDSxISO44/AzKMz7BO?=
 =?us-ascii?Q?M4+RVTPuLbI/lR5nqpsiUxiWJ6pyY64rtoXai90WLtnaZSYP4MbIhJok5KQA?=
 =?us-ascii?Q?ImAUIvlDDPgY8pl4NyjtkJSBnNEjtOaVHB0IxeiTwo4FJKS73i58mXwOlfWI?=
 =?us-ascii?Q?dtvwrjcbtaik8xLReTE7Z0q6aKItBlsM7mkVcOP5BFHOl1whX4+0YIJxB/Rp?=
 =?us-ascii?Q?/tkvHO+PP+jumd3JK3jJ9kex1P037udGaI1q4S7i5u80SjWZ548OAsmQNtnI?=
 =?us-ascii?Q?A/oeVZqPfAJmbiwQPej/UQ0IZR1b6i49/8gsI1AN5Bg+0I8Yj5AkL8Fe/0Sb?=
 =?us-ascii?Q?4AUMOTeCJfJDQr6iQJKUwmPKsC377ZQN9U/u/QzbzdY0gpl/oUyJe7Gdxuvf?=
 =?us-ascii?Q?ET+J7A0/s+DY0QcPlCpYcFz8SRXP69dmYka1RJxzlaO8tX+4yztUTdhEwHvP?=
 =?us-ascii?Q?5EDheKInr7rlL26IfklGup1jCgpl7o5LL0L0hDwqEFpy4RLzwb03hKXg+hVk?=
 =?us-ascii?Q?r7Yng/KIQElRz4RuGP1rZVsWRhjN+vpUeioeQGmPKRE++c7qBgYCgByHu/8I?=
 =?us-ascii?Q?6y77DE2nRBk8c7ht0N1H448Ehobtj7Ku0RJrLiXG0uLvBrIwudL8M9QMEbK9?=
 =?us-ascii?Q?Ees77hcb732Ln9uWXtN4Kss0yqBxqdHR7vR6sgm8i2x0by/Oy8TWJI/Mn0Mn?=
 =?us-ascii?Q?dNzDjJoiWXPBxAo83Xl7C6reVIBEWRFmpr12vp8vonrf9AV28U0hnr0VpgHV?=
 =?us-ascii?Q?/wJeA3kdXRd76M+YyGEvAkzzhe0hykarqGDTE/QqwXxYyEMZmQXUcAAqMfJs?=
 =?us-ascii?Q?pWJzaNB1R8t5uT8xmGdwRrVZQnB6bdeF0OSZ9kAp8YGYQ4/wiaNzB3A54s1f?=
 =?us-ascii?Q?OeEpspUqY+LoSfoLWrJr+PlHUsBm5hEI+kxgy4p7DyxgRM3Y9nK2/ucIVvwI?=
 =?us-ascii?Q?pwDQ3UnUw5du8TvE2nU/HJesDwqYsavHFX1rSwNz5AfQHt+STgLYFDw9FPHM?=
 =?us-ascii?Q?70LVW9nQ/4XG/SP8+wNbjGkWv10pfdLSAdxDAlfq1MZHC3JH/eQEC1d3EQN1?=
 =?us-ascii?Q?zO8td2/usnwUWT6LigU79XRx6Hm40W3nq+ozcCIeh26WyCCjEoWAmn5G1hP3?=
 =?us-ascii?Q?N2wlUG2E/s5IQIHluVyo3O33++1aYAExwnVRI+t+BN1FV0K3DlJhmPW5QEYS?=
 =?us-ascii?Q?sr0e7mGH0h3AGW/F+t9e3h9WbqDIc2KiwtCe/EpvxHcVM9iXkOcHgqeGqr7q?=
 =?us-ascii?Q?lsQ6Q2M5AanC7Inplu5KGPMLGXRbe0++zZ6xIG2Qs7c1oyhq3ZZWMReJJ0u5?=
 =?us-ascii?Q?faneX2Ijq+gC6+PFoiEw4BY5V5Vapw5hvOteBYH/6w+oVLbh11S7E/c7ecXi?=
 =?us-ascii?Q?Ez4XatUhEPpNzQ01ocUELvtLiNvWTz3yrLfj3bEqg3kOdKNAC6250pt2aMtC?=
 =?us-ascii?Q?du9BG1FbbLLnYoaeOG9sltKkh6XYl/hO0rUbd4xBQIIh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3442591-5db6-43ef-8be4-08daef02f89e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 09:55:26.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GP3jU8SYfr+4J396RixL0RX5cvO5vHFcRDLf8DMM657TToeXlu4++iIa6gm6REX3Wq0Fb1Mz2BxNmgYH80G4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--77WwaPK1rjyjLr+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2023 at 06:51:24PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 04, 2023 at 05:41:46PM +0100, Thierry Reding wrote:
> > On Wed, Dec 28, 2022 at 11:20:42AM +0200, Andy Shevchenko wrote:
> > > Now that all GPIO library users are converted to use fwnode,
> > > Drop redundant field from struct gpio_chip and accompanying
> > > code.
> > >=20
> > > Bart, I prefer this series to go as soon as possible if you
> > > have no objection. Or even as v6.2 material.
> > >=20
> > > Thierry, can you please test it once again, so we will be sure
> > > there is no breakage for OF platforms?
> >=20
> > Seems to be working fine on at least Jetson TX1, so:
> >=20
> > Tested-by: Thierry Reding <treding@nvidia.com>
>=20
> Thank you and HNY!

Happy New Year!

Thierry

--77WwaPK1rjyjLr+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmO2noYACgkQ3SOs138+
s6ErTRAAhYn3COMTotxJOLtxz+70w/SdI+4W6iN8786E19fEGuLgME5euygJgQpx
+1XK98N/ntaWXwj0guBacg2rWIw+fr56dgtyOnkQsQ9jXRM7Zvj5pHzdihJZx2cm
uDW4vfYn6O40rUj6h25/eNlUx8AKdtXBlEX7Pwanm4es8XzVYIKIRBHAhy1q13qP
sHPjMBmSFqcrzBTB7MfKz6SEAcxrpysl9FHwbmZHNfMSCqzWxnmu9bxSojeOvX2b
Vz4pVLDt+ZMIlKnwZisD7vZw4yda6OZH4RMkhr8/LshnobgIY7pJghY2LldKrfR9
7NdHDsHnT3x6vZOcuHuBnd8OK6YLXlJ66kli66BEgRyPUh68nSZnBkQ8D3kLNn7e
jXuWPHMPEKIYt+g/r2hdEorfZYzocUmso/WwnAmPnVY3Vll6/8c9M4CQ4ajoflte
UHdCm7BqjPJ+RMGEjtOGrpiy9G8pmK3+ZLBmmrV6m5nwGZU4P7RM3jVcDYhGsrk/
OJsCkoavitRhAKUedWG26vPAIKKtH+5Ucje5jMeGgst9Lxk5GgL5ztnCZBu3rAEF
Xer6Br60HAblixXzFt14Xg6aPBwOVtzd8H+zS/4FEK7irko5nv4zBgT7GsvCQDAv
TAFcvlYajIUyUC9k7BNdILl/i8ZnxLiKkownEyTuHwN5Lu8a7rI=
=yE9Y
-----END PGP SIGNATURE-----

--77WwaPK1rjyjLr+e--
