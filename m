Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453EB5E808F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiIWRTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWRTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:19:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B588C1132;
        Fri, 23 Sep 2022 10:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLM+UukZaw6SN2yhRq01545t/KWMKc+dfyEc7Vu5ZxfH3kHEHHhGQviqKOeNeqBXGtWhV/j9iA6ku/lPVoTmK1RkRuoy3iGmGyti4MWZNMJG5QXgX0RQrGt2MeY1C+oiM5vZy4V00GmWF3px8fdoT/nfrFa3crQUuDcdhoelJ/hnbMVt+xutDd50zrkX585smJ1D/Sy88Zd5HG8wxZWefsYLe1Ds7EDY3fqV3neJd8FTjtqQhsMhbTmGiQtPPZRQu2u2gtezmy+6/wsjWfQsVGnSkRYlztD7riSq04ge9s98eb0PUaTSvNEvdSF0/huR/W3gRLrI7GSL6OCEjQzaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvzMuZsJGzeQ2URqF0cg5vQNo/BlazJ6vBgm+IWK/dI=;
 b=eqMr3U9GrVfr+ftSofZZ6/wRevWLV8O5gExxL6exXDq5R0RoLu5jsGZhxnWHIPEUexO8BKd20kUp0qoyI8PGxj066Mu1H4MD9KF9rShnbEvmu90kF04xPJGEcxuHC4bxEf21P81xxmlWPZCec3h6V2r6qbqYx+eFSUBmG3JWHAOTHy6wFtFRJKJcbYfoGgCbV145uAntGzjQBRLnctQpiSvFo3pj0kRUDwsRwuiPLqv5OrrU3AfI/GueFu/3OGqrfNM994S9RMNn+uE7jewomtIXPPlJRylHWyoDQuZ0//Htl+pX21YuF/NgByQ6Tk4gIHlH/A7CxBvKBSGxhfG84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvzMuZsJGzeQ2URqF0cg5vQNo/BlazJ6vBgm+IWK/dI=;
 b=D6svZNvJaXcNhhuo7WpNs9pINB/Y025NqD4e15p+2HjruQGtVfZpuXSoLQ5xskYNVzU6k9awxVxAGdNlBCB2CkYWPty0r8eN/kXpruSEHPiydh63f50nGqN+oZ7gaxXlbFGOkVxjSGTYSF0tQgL7btbhN+QEDuVD8J357Hu6s/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB7259.namprd08.prod.outlook.com
 (2603:10b6:510:91::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Fri, 23 Sep
 2022 17:19:28 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::afa7:70e3:c2c9:b680]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::afa7:70e3:c2c9:b680%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 17:19:28 +0000
Date:   Fri, 23 Sep 2022 12:19:11 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        dmitry.torokhov@gmail.com, klaus.goger@theobroma-systems.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: add `SW_BOOT_ALT`
Message-ID: <Yy3qj432McMJ/5rl@nixie71>
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
 <20220922101211.3215888-2-foss+kernel@0leil.net>
 <YyyZRt5j180KzGqc@nixie71>
 <7add41ad-2cff-adef-08c4-dbc02f7c7c31@theobroma-systems.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7add41ad-2cff-adef-08c4-dbc02f7c7c31@theobroma-systems.com>
X-ClientProxiedBy: DS7PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::32) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 00763e75-4af4-42f2-55b6-08da9d87c4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBmCipoNBllZPNFVxHJo7LAfk99pz0MLZ+2v2rYxGoMG651mBkDIH8sDPLqP7ZJG9CKPpOUwA236lH2SJo6eoR6QUtXsy3jiuodb2j558dTZV+bFpJIVZG/Widl6TrnydLIurGOWC/ShhOyVHpsOvXKmnRvAkQn7YBIExbSWRs3BkUeY/yWDXEY1XYCaXfDsBRh41D4WyD3A/hNKd46nhxz1igtk9cfbNnax05hiGJhJs4rGOk559qe7JGR/1Vw8Nf3bAnEO7KGHwyt6WqKYPcsms0MXYVIQ7evu9wRJM+Oi3s6h7q5sfytVDpDHlwyZ11k/nuvQxJz5+AaXkQB7uUaEsSG+8gls9HG2dyt43A4GOHlQ38db3sUg7pJPCAN12UT14awarECN0VRUDM9tSBYE2n8IELa/l6wBAC42vfE6xUgqevR4i7wPjGr2Uy+nISBRWO9hxPWWZOc6MBtIuIrPwy0LSdRDZV8aGweaDKF6roj7vWwD3rKub/IZNRL28zl1iE7CHWdiBjbDYQV074HQ1RCgtggpjqqYjrTdr9Rxo9mCcdVHeur9RoTWQXr8BqrN/YB8gWjcIeoTiDZ0nrIsfHT+tiFTG79KPKflEULntk68iKbHMt/IJJfwMKQo7MlOC9UOAWW0mdq6m903uPAG1wwUQ+sXl73JGu4Q2aSEBKQf8MQslbAn0nNm3cjqnu84KwFZDpvF2VzRoeBR+KkgP5YJTXmVDk2M5TM0oGNB7nNfW3Xdjd7HLrTBFOAZM9kOzBFLHjtbtXF1MPDkJZ6WwqDpfVqzSVVn++BANxA0k+xAthDsZr9j0AWRKmICIWxm+mex0toDUh2tGJ/cvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(136003)(366004)(39830400003)(376002)(451199015)(478600001)(4326008)(6512007)(26005)(5660300002)(8936002)(6506007)(9686003)(6916009)(33716001)(6666004)(186003)(41300700001)(53546011)(83380400001)(66946007)(2906002)(66476007)(7416002)(66556008)(316002)(38100700002)(6486002)(966005)(8676002)(86362001)(81973001)(15398625002)(43620500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mnZdiHmtb05zLTQ/7q+uOd/p2NOHcTKuIX2L4935SOuyIxvM5Oo5eecXr51T?=
 =?us-ascii?Q?GcSS8HPEshqrKnN0+d/7RMSKQ2etdWqenUxblbvgb9qmk6F5Hv74TCvJ96E2?=
 =?us-ascii?Q?rBCcmzPd5SczKkxrN2Od2qPogBsJZjpVy2NdQfmU57Ootw/qyRzRJHwtjjBv?=
 =?us-ascii?Q?P8Mo1eX4IeP+vcBuHBvR6IM6Wf5sOuB3//2uIwx6JHr0o0M7z7OJR96bGib8?=
 =?us-ascii?Q?yDJcF6zQPtLr4nhaW1yuarfiA562P8cC3RQw0EVjFPNlADqFOul3Ovp9lK+C?=
 =?us-ascii?Q?PB6x2RAMLGCZZ82yQyUTPAwfZb0R2gVKB6eaGK08suIF6xqq+2LqEwwWmckg?=
 =?us-ascii?Q?d5olsUdQrTMRmz/CC/9k1fyyq6s7NzvWJVWcPoocAxJHNfDV1pzCFPZRXsWm?=
 =?us-ascii?Q?BO7MXQAlhMEv8LNb4IrLsx6D7TdemdY5d+uIG+IeGuPZgViKG1fiV9wC6GIU?=
 =?us-ascii?Q?ZAFVrMYl0M1/tdyAPlYH4MUX+TSZgi+23owkCfr0EX9vn/LlUsGcL2sPz/zb?=
 =?us-ascii?Q?kOwxmhLQRy3tqcjDI0jjs/gy88moCOcyUEahMt6pkdhu0Uq0yWrWFtwMVdJv?=
 =?us-ascii?Q?VdnKrxCRoVwFMzUwhgAzf99Uz71KuavZ3ptIvnDwn7FdvtxAXVotkp3jbAqh?=
 =?us-ascii?Q?/58lSyLSV71BU8InEF2f0lqBn5G9D0pFpuXlr1jnn8Rx7Q7xEKHw/UbG/d5z?=
 =?us-ascii?Q?YY2hRqI8d+msHVV/J1Zx4GnW+cJFxnGH1+TFrA2orErILLqf+mBUazJHYc46?=
 =?us-ascii?Q?LhSnnrHORFEzKgxeigYtYNPjqQTSp8ssTMKunpU5Y6flUw02gYAcoACxENeY?=
 =?us-ascii?Q?yQR8CrUoczvnDzZg1TgFvD8mY6xw/SCSExQz+kOO5rPP+F9pTGlYvQIFmdzL?=
 =?us-ascii?Q?aKZ3po0MRjloqtCkcOJuzhBc8mkAxBqiyjnKPNa/GXrupXvcboXm39DNuasb?=
 =?us-ascii?Q?u+/dLvbT9pzJdhseFnlxDT6k159s3EUYecrp1v8xe+cF77NJ0Usq1sKfrYrq?=
 =?us-ascii?Q?9G7KmL5Wa+OyFjN/49y105tPPj1Tmfp9efL+vbimp51+/YhlUrezS5iwB8m1?=
 =?us-ascii?Q?6+6yA5rfC3BPkwCQZ7RNX14h5/oFuZEZOPl26eaRpnXryZ8FXBSKhsD+8Doe?=
 =?us-ascii?Q?bn2KEbeVByGU6nOLzriKQenNPClcthjChAkVN937VujQKy2DVLioE+ZpTcT4?=
 =?us-ascii?Q?fLuCa6T19lqWSB7ImeJwj2oAdVwhJiCMk8NXtcHmQwa5paxV3hzbTk+H5oNT?=
 =?us-ascii?Q?2mkZBP4tZRNLMUiw3quVGAIkZQ7lFi9HkOdC15G06pnAPZvbri1yBSG4q9lO?=
 =?us-ascii?Q?IdCH8qLn7XHxKtWYGJ1eQ/R1EEd2fXeS1xzRjLneUvgO2JMPErzGO5j5dny6?=
 =?us-ascii?Q?DeZQmKVC+Nc5k8lK9paCp2Iyw16cfrRlr57LFh07th6Zn8vUqjYU/gdTDy40?=
 =?us-ascii?Q?EJBC84e79A2URfYPJijXcfWAKK8iw0HXeiuAtMfLGBvR4jj5RqvGfUtwT0dF?=
 =?us-ascii?Q?u0BN7Rq8yOmKeYODK2O8BGC+81RinxgXcp30rHbHb/8TVhTBS1H99BQKl8jv?=
 =?us-ascii?Q?wcGAKPrr8OqWrbQrcXT3ndkoapJIpDUCCRm2CVQX?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00763e75-4af4-42f2-55b6-08da9d87c4f7
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 17:19:27.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YE2phfFXKOZtNq2Cx3kj3VLzijT2jCr3tyPOJaLmo0ZQRI5KxwRacuk62wkrL6f/92i8IYC6JNWK4M0T+hn10A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7259
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Fri, Sep 23, 2022 at 10:25:58AM +0200, Quentin Schulz wrote:
> Hi Jeff,
> 
> On 9/22/22 19:20, Jeff LaBundy wrote:
> > Hi Quentin,
> > 
> > On Thu, Sep 22, 2022 at 12:12:09PM +0200, Quentin Schulz wrote:
> > > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > 
> > > This event code represents the firmware source to use at boot.
> > > Value 0 means using "standard" firmware source, value 1 means using
> > > "alternative" firmware source.
> > > 
> > > For example, some hardware has the ability to force the BOOTROM to load
> > > the bootloader from a secondary firmware source (say SD card) instead of
> > > trying with the standard first and then the secondary. This event allows
> > > the userspace to know which firmware source was requested *in hardware*.
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > 
> > This does not seem like the right approach, especially since the switch
> > can easily be flipped after the state is already latched.
> > 
> > If the bootloader needs to pass information to the kernel (boot source or
> > otherwise), a safer and more flexible approach is to share some variables
> > in eMMC, or pass information using the kernel cmdline.
> > 
> 
> I made a terrible job at explaining what this switch is for, sorry.
> 
> Obviously, the state of the switch cannot represent which firmware boot
> source was used as only the bootloader will be able to tell (since it
> usually tries storage media in a specific order and the primary boot source
> could get corrupted at one point in time). Anyway, like you rightfully
> stated, this is useless "info" and the important one would be passed by the
> bootloader to the kernel (possibly via Device Tree fixup in case of
> Aarch64). U-Boot does this to set the memory node so this could be done
> again with a different property or something like that. Anyways, not
> something I'm really interested in.
> 
> I have a switch on my devkit which implements the BOOT_ALT#/BIOS_DISABLE#
> functionality from the Q7 standard, see section 3.1.17 Miscellaneous Signals
> in the specs:
> https://sget.org/wp-content/uploads/2018/09/Qseven-Spec_2.1.pdf
> 
> """
> BIOS_DISABLE#
> /BOOT_ALT#
> Module BIOS disable input signal. Pull low to disable
> module's on-board BIOS. Allows off-module BIOS
> implementations. This signal can also be used to disable
> standard boot firmware flash device and enable an alternative
> boot firmware source, for example a boot loader.
> """
> 
> This is basically the configuration of the firmware boot source to use for
> *the next boot*. It does not represent which boot source was used, nor which
> one will effectively be used.
> 
> In our case, this switch electrically disables eMMC and SPI flashes and only
> allow to boot from SD card (this switch is then electrically overridden by
> another GPIO at runtime by the bootloader/Linux kernel, but the state of the
> switch is still available to the user via another GPIO).

Thanks for the additional detail and the use-case is quite clear; I just
don't think input is the right home for this. Input makes more sense for
switches that a user may change during runtime with the expectation that
an event handler effects some sort of response.

Such is the case for lid open/close and headphone insertion, but here we
are just interested in the state of a muxed GPIO.

> 
> I have this switch on the board and I want to expose its state to the user,
> if this new event code is not possible/a good idea what would you suggest we
> could use?
> 
> Note that we already support the same switch but in a different way: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts#n167
> We are just configuring the GPIOs into the GPIO mode with a pull-up, and
> then it's up to the user to use gpiod or gpio-sysfs to check the state of
> the GPIO used for this switch. I don't like this, very not user-friendly and
> was looking for something better :)

Actually, that's exactly what I was going to suggest. What in particular
is not user-friendly about it?

Of course, this is just my opinion as a fellow customer of input and it
is ultimately up to Dmitry.

> 
> Hope I explained myself a bit better this time, lemme know if I can clarify
> anything.
> 
> Thanks!
> Quentin

Kind regards,
Jeff LaBundy
