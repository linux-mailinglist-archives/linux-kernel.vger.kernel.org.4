Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3870A67EF93
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjA0Ua4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjA0Uax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:30:53 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2121.outbound.protection.outlook.com [40.107.237.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D22A206A5;
        Fri, 27 Jan 2023 12:30:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aq7yORho5TbosQc/ShwZuirtUkc2KRNt/zx7LawZIFwxKTPTbLXej9Z85sFVLo2gs2hKxnvf1o2ecXfwUvDVrkbyup84jA0Lkk/1lWN+6saaM3hnC8x7T+cD4z6PFaUsXhTJyJH4KDb9PzKahgyokUXr7EWfUDl9sfWh5/71Fch9UTlVZcX+nZ6MP/ab+c3MWrGyxHhnDQ//SLduG7MQA8/ffJjWuMM5pid3hAEfM3mbVDSBfc1A/uNcnhZyY/X+gbsChrnKldh/MTJlBj3nTmmrlYt+wLBQV2HybYMVDz6gzhsKf5VpBOJGopyEXbdeGbp2vURLBtaWEsNP7Q2VwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTbj1Xb4UVC/+6jqhwo6TWCNxO8sKjzGIUVhDNL6VRg=;
 b=YUjJb0biEuYmK07zUFU5USsrECvN9rxV5TuySiKet6/euERAstGxrMIIYWjtDh23tKaAxbnLMwYkU1Gxg1y1ZwbB1Bq/zpdjPqe6HGX0mSP1O65lKhiP5/nCzCSXHYJy/pwoJSnwgOEdp/aj6mFDX6UxpGNqbLzjlXZptCWsscsBcuWe0nLFenyfHNrfdr2Jh56sIlH5cBvYEKzF+hQwLH+fnMWREMerhXqMrxrlRPDDjUuyzcupOksmhnCqxy2We7N0yrpctEY88sJxKsUIOwRQx6UrGZJZBVrzaDJL8D9uJqmaY4dYCYZ00VGh9mbKnPtA4GZoQ3f9j+mUi/Xm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTbj1Xb4UVC/+6jqhwo6TWCNxO8sKjzGIUVhDNL6VRg=;
 b=Vw2HvjBs8/WSA6YRwtN8vrX7VWRQIGp+Tsr41sDpowJftiOmJlmbODKr37WYdD9qvjuk6utDnUml8XZScGQBkwHcfeMUr7o1RIdPEEgNcMI6v1aVIDWuYecizVBFYFXGb2sDRgsYmPYFLjsja0LvniFZePMkVBpjJdxsRItFDPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DM5PR1001MB2345.namprd10.prod.outlook.com (2603:10b6:4:2d::31)
 by DS0PR10MB7480.namprd10.prod.outlook.com (2603:10b6:8:165::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.10; Fri, 27 Jan
 2023 20:30:48 +0000
Received: from DM5PR1001MB2345.namprd10.prod.outlook.com
 ([fe80::221:4186:6ea3:9097]) by DM5PR1001MB2345.namprd10.prod.outlook.com
 ([fe80::221:4186:6ea3:9097%7]) with mapi id 15.20.6064.010; Fri, 27 Jan 2023
 20:30:48 +0000
Date:   Fri, 27 Jan 2023 12:30:42 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
Message-ID: <Y9Q0culPHGNZkQz9@euler>
References: <20230127001141.407071-1-saravanak@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To DM5PR1001MB2345.namprd10.prod.outlook.com
 (2603:10b6:4:2d::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2345:EE_|DS0PR10MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fcbb47-1ce8-4ed7-ce11-08db00a56000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61qDKbWgrn5gZw1TfHXsaYOiGt9U/dUYR/ICWJSR0rgV3bHKyDHpyO2HD0IIPuZNzeQ4uG88eHlLgS5w6CvAQM/y+bUq9qU0MO+bTmcums5finaslP4ulHDeoxFl0eSvyNfWz2Lf5dStjdR78NJ1X/fCsK+xNrxK99v346W7dlvyVqud8rfHuhu0d3r8+gneiAQIzPpElHvIcI5kQeeX5bj4vAJ8HOJHRfuCX5urxTWYNuUeVSthTzsDUvFeNwekh7LFH+PGvGIJwvbMiDUPvv3/65nZirTOhHobffcsvxthPhza2kdi7w16EzdZxh/TYFYLGLGwUvGbA05Oh2vN4y1AEjIMHDy8/aiWTr1cW5SBf7dVC4xbbCzut1MLd88U7eUpKLXgQFYeUx2w4p0Uq3nF4o+iI1amjlJhQ61d8YVNaPUb4Nb9pxXsva0gjAg69IYMTY6zX0NFRln1brpOpUmIEr4Xvq+jrpOhRgUsOlv5xFKKPwezN23zOLQ9yeBg/8T5+AaSx9ZGSFfSB8ZZ2DyhGSdOuFGFxjnC5ALRxc24WxOxefXFk4rp2XU5IRBuOBWnXV+FFlZP+Pez2l+bfv7Qm4CJ6pLsSQ5XKsfY6VUmYyXjkyoQu2s52X5brHeYA8OcWCtFO2dQ0EhuFoxDlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2345.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(39830400003)(366004)(136003)(346002)(396003)(451199018)(44832011)(2906002)(7406005)(5660300002)(7416002)(4744005)(8936002)(38100700002)(41300700001)(6666004)(86362001)(6486002)(478600001)(83380400001)(54906003)(316002)(8676002)(66476007)(66946007)(4326008)(6916009)(66556008)(6506007)(9686003)(186003)(6512007)(26005)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1uVrn+VJFo79GjszOpqr9AylzfmL1BdHb2nCnjXc7gIUipAe2ZQiucm+B3th?=
 =?us-ascii?Q?ynM31A7x8SWOuWAB6uOaVLReNQ+auit7yRoK7DGo0yGlkqXVX1Mtcj3qZ0Cn?=
 =?us-ascii?Q?xHM9i0h8lQBy+B0DIqvlQGd5p2CluLG8KWgZfGRbYaTZp9+DZkWaUUw4eeif?=
 =?us-ascii?Q?1I+n2Kivcf4NCwzDI4HpkNNdZ2MrzuSvHKrLcAN5yCJY5KI8II+Qfr6olQPE?=
 =?us-ascii?Q?VHBvzHc0JIa5PwVlrTpVnSl62AwX4Z/tc9ceD6Hzv8W2M8Uqhu3sJ4ey4buR?=
 =?us-ascii?Q?WdRImq4GSTPQTpZYcZOHGoFDEqszHzXW1OTtIS/qRyFtgUr2AwbxpmLvz+ja?=
 =?us-ascii?Q?7L73SgO6TC5mTdEBDEOu2BcfoAcKkp092ICWe7Bu76yQUHp2ZzePgMyPhTVp?=
 =?us-ascii?Q?f13La3qMwoFKhuyjbxP76yS4VUY6mMy940jwlFuSGI3Fmg8f30cdOZPP1mxB?=
 =?us-ascii?Q?zUj3O9NeiTeVuhCzkyEDk+4EM5d8rcqemWXWqpawXuVvKQ4uVOPxXgqgJUjP?=
 =?us-ascii?Q?uztph9RIUXHnYqKpIFQNxDsRSybLoDgBJV7w4ZMs/4NuRwoEoDs0zb7Dwvra?=
 =?us-ascii?Q?aZtSvWcv6Z5ZUkwX9AZT2joPgQEoBhan5qpAqmWhedTnZfdbHbzAUMlfIx/b?=
 =?us-ascii?Q?bZVpMWjYj+Eo4DmOETTaVhT6VCR1gFtsnwlt/qTAl1WVn2c1InpI8kulVypI?=
 =?us-ascii?Q?rqZPCXm7j+ABIrPyreDjfC+cMgjTRlMIuI/k6lFRmQpJHcwclK6ikdVfBI4v?=
 =?us-ascii?Q?iL4AENbg8syjx2PVkNouGf3/noeoM/78ziZeu8gxnZvRHPLO4I4XMuIpNJdg?=
 =?us-ascii?Q?SXXp3MSLnVBp6qx8gUpvYzhdhuwATy5552IZaVL338iMDmB4xlLcvwfQXzyy?=
 =?us-ascii?Q?bVK58eck2wS+Ljw/DeV2UmmlB6DViPY2JQ+mNppuW9guOF17kU3PiJwr607s?=
 =?us-ascii?Q?Rvq6cjUD0Yhx5W20nQ67XVuYbh4MKB2m4s81auHz4mmFDpSASLhaUucpxyUk?=
 =?us-ascii?Q?CGqxI3wVXIUEl1O6PCy9GCAHwu4uZxrIrRR2tPaitIgNtNyWYb7izFlhGQ0T?=
 =?us-ascii?Q?nm5uXvzHn+OPSNlg3P80pg2Jnno4Mok39gOFF9t7BlzI86dYD78en24hLqIJ?=
 =?us-ascii?Q?nchUuC72gz4478pZ29fGYJC9M2+sV2JvTK7871lkijUdLmK15ai5jnOEEYSk?=
 =?us-ascii?Q?fgHM2zeSM7kOHaxjytlndSarZnYNrOhEtQ5fIEJI+RULsVr/Rh4x/eaBA28a?=
 =?us-ascii?Q?A3QpBJaB2XHdOkMj6ILuuemQoQcE4bG/my/bUCrxNxX50TU+cvaKWBbtTsds?=
 =?us-ascii?Q?c1kuty2GIJ+Jd2vU2V+FNwHe1YWFILkshPOr2w76zJzCkumL2jt9A+OJjRtm?=
 =?us-ascii?Q?R8uUw6yFbpDpvkftsDHUQsOSxtR2yFh/nfQ2EVtdF1zFdIb+eFebrO/0XOvF?=
 =?us-ascii?Q?BwSy5jtpaAnamiohomN7bBmxZZmpkuIVWGi+SeWIuOmubwHeRhBDGUjcR1zh?=
 =?us-ascii?Q?9xPGhu3+k3IpVVMu2T82P9JLgCD+Y10He6O1Dftl90mKhm8zZ/HaRMfx5J0K?=
 =?us-ascii?Q?71SoAALuCqKM+lcmqgpXChwSPmUAM7eTIvZVQtPt0g0Z73elUajCkGNWJqK2?=
 =?us-ascii?Q?dpVOf1S4S16ym3Fba/IP8cg=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fcbb47-1ce8-4ed7-ce11-08db00a56000
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2345.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 20:30:48.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4hZY4k583QPhKqNEPUdZbRXWkO/LS2sUytuqHS7xw4B2WmjkLwYvmzH96UAQqSc29Xr8aH9mT8Kb1c2fqVLrfn368S6YPdUEew9XP/gg1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7480
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 04:11:27PM -0800, Saravana Kannan wrote:
> Dmitry, Maxim(s), Miquel, Luca, Doug, Colin, Martin, Jean-Philippe,
> 
> I've Cc-ed you because I had pointed you to v1 of this series + the
> patches in that thread at one point or another as a fix to some issue
> you were facing. It'd appreciate it if you can test this series and
> report any issues, or things it fixed and give Tested-bys.

I applied this on my working net-next/main development branch and can
confirm I am able to successfully boot the Beaglebone Black.

Tested-by: Colin Foster <colin.foster@in-advantage.com>
