Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85366A4FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjB0XoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0XoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:44:19 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B2A1E1EA;
        Mon, 27 Feb 2023 15:44:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI3cOyLaxOBzV4opjmOXsml++UqAr/nu8ZQFByd+Y9Qxm/qMwyeOIQzwS3XhOwHb+eqf7wMUSul+v6OSS5Yk4zaTbcySZ9aXEtl1ROsWLa2DoHMVViJ/YX9TGGLhz0Z2B15JFNAAAHGdnZhLiuZvDqXayAOoYqxnQhwR9hWpyRyEYc67GwYtqh6pOhyxj24Q5GZLKDZNe5qpJ57z9+C4eZrUyxiJ/CetQWAEd2tk0qjrop2ynI6gETbC952BRk2C+N+osqfqczAFmfBsq+jaAuY6G9cX7x+SMdiAfW/n+JjqnFXZRcn7ltzcpNYR7RT43mPvgbLlriKcciIFRA05lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgaSv63PPAbxycsnXanZYJLXSUO1RCM+ZbOK+n1mojo=;
 b=hr1RzFoT6WvH6R4sEE61numPUpcbO3xz8qxqIYAYFJ36lIa2g3r42lNweQ2v1APxR62sDsbxREsrNPdnYn9Be+nWwXsZojRqD+28+sZydAx62clGJvb+9eiVLr2t+lJMcxRAoWqM4uSDL1I9eeG2Y/6ocaXLT8QHQSfLKI+DVE1dgqDQsSidzmal4io9UMHtXdpActwjgJE8hxcHskcK5r6vDGLsBiH8fhS6yUwF30wQNCUfHE2jK66deJjy8mXERjzsrEko9kAsO6G+wETucDVR9TiR5YRCoX0UwIENmDenRIPE2ZYlyQuCWtmki1ILmNj1WsJU5AB3IcZF5h62CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgaSv63PPAbxycsnXanZYJLXSUO1RCM+ZbOK+n1mojo=;
 b=bKoPflg8DcM6yfZ87iy6gIVLylq4tF32Mk4Z4R7sxDwtKq1kKi7eUOF1/26X0uBpbsiG7yM79jEND8Qy7gQz21ao715UKwFMT34EDIKUCIW0pjEFLx6NR2Rp3keEIHCwR3i4dxmKOnwbXOw7v7586+sAEW65PEj3TbYi0dts6T4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8827.eurprd04.prod.outlook.com (2603:10a6:20b:40a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Mon, 27 Feb
 2023 23:44:15 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8%4]) with mapi id 15.20.6134.030; Mon, 27 Feb 2023
 23:44:15 +0000
Date:   Tue, 28 Feb 2023 01:44:11 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <20230227234411.jqmwshzkeyx6iqyo@skbuf>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
 <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
X-ClientProxiedBy: AM0PR10CA0006.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: e05e0447-fbb5-456d-4d89-08db191c890b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gI2BCjZ2TqGcGJ9GWhXWQhI3m6qpqwg5LEwCKzUnNnoKc43lWSJooqscwb0c4APNZqmYT3No7kT7Z4Q3UVrKgLrvwH+mDeq0ONzV+Oy009EjZk35Fc44wHerh9o6HFLn6msbaqfPAe9C8wJ6Fk0MbzsbwCTMwEJUFQXci7awHs5mdPQR+KnAyi3SN0Hk80R8kIbpK78CRUEUtv172yhKaTWFVAiTrGw6OEC2wpI/scbccsCqggIm05Wb38uRP0d+L7HMNX6L3KbBZzCkQfGGl7ZC9C7DWBQRS/fNs7pb+dwAnJ65F6TKLxqbOwnMtxy5DOvZShR0bcdDbGInmZF4TbQLGMBnMb6i4ct9GqMJWVV1iz1MUsRZ5I9OFu9XVJm75AHtUINBrGnL7xLCZYnfIGmddx5pMppAU6hK/AHzHx548hxhcghVGVfiSH3F0QmNOkoF7KmfU0OJqqUUNh47+eRnsX0jyLpkJ447PfjqrnzkRzcaDPVWuudrfhS9XjDrCWSkLPadY5XxQCsI5Zv9R/PjomRyT7BIwr3VJXEFncsJRjzIzdptC60hcA278QUv/VPPMOYSOhzVb9LDwxaBnj1YtX+/xcwS1qwI71h7lDWc7TfpWNoN5Ak8PUsVRxjlrjpZbXxByjdwAXEvCFR9bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199018)(38100700002)(86362001)(2906002)(44832011)(5660300002)(41300700001)(66946007)(8676002)(66556008)(66476007)(8936002)(6916009)(4326008)(33716001)(1076003)(6506007)(186003)(26005)(6512007)(9686003)(83380400001)(478600001)(316002)(6666004)(6486002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NG5YIaxorA+GnwMOrmWyAvWlZGzKwjRAImEa5K/OCavoJaWIeO+AeeuJN/V0?=
 =?us-ascii?Q?5JidUlAgzzawsnnwlKYamjzMy6lAPiRA1xpq4JkkS9oxfpxL1Joqq3qv4OzS?=
 =?us-ascii?Q?dV9FaxOTiYdMoxg8kfofWpd/anN58U70JyKTeiStAowWrVNsvrSnAyoJ0iGz?=
 =?us-ascii?Q?Y4jfrfcpPtu3jRq0KlktQxSKEJjNpgkOjb55DqfXkP0kruQP9e6BN3COeXcH?=
 =?us-ascii?Q?llWtZDBo64DMFj980NUwCR5WtNkCHxC5bguus78bhzPpQakNOw0gpstl0UBH?=
 =?us-ascii?Q?oPTFOE+ykKQbqRiNja+ru0ueuEuSfzfpvgF2mHeMk9331f5xo+znN2AE5k/Y?=
 =?us-ascii?Q?3HxdM3A4svsHb2MQssGHP0wz+u7Nz036oFGBwmogTSBmusc7fMclKluo+eD9?=
 =?us-ascii?Q?rtYLhKXDip6Fpkl5/UbAY8RMnIggj/UBk4nEyRdkLZfgpNwLqH/knRV0Vxhi?=
 =?us-ascii?Q?/735IVHpBaSdR1mjbdTciGYjTGIr177MOjPIekhyBpXL4w9u5yaRPUNnm6sF?=
 =?us-ascii?Q?+4vvW32ahJjoxQjHXzOiTYdNYbDUFVph/EjgBXJbzwB4nsBobRz74KUF9Vrg?=
 =?us-ascii?Q?vAr5j31k1gOQdH/Q+qR9DffZoPQYQCGsmE+NADTppQE2Lk1U+nl3XaTTOtG1?=
 =?us-ascii?Q?dHAnungb/zB5yUmFytCTgO3yrfsw9V9vVNjfacTN6fXVsBr8OOTX4MhqMVdt?=
 =?us-ascii?Q?u1jG3C5QD9CR7rK8PeGITa8EEDhlbOUOSTkvp0lWbN839kceY4eixkII279E?=
 =?us-ascii?Q?jgqXvH2K3rxfuehxi9sA9EkuJokeoLpqphRS5nLn5E+gkHeMvTokhTvCobwg?=
 =?us-ascii?Q?4ipuNVL1H5GRcdY5q3lH8756MbXmW4fPeomFWiSEuDVon4cdGufgLQvxE8Kl?=
 =?us-ascii?Q?y6KRiIgbY5OcZcrYjCzOYmjirGVsMOTLUQUZhsbk84HC7hVRBtAbgfn78RsI?=
 =?us-ascii?Q?UMDhTBUhHL/ePjNf1H3Z8yrflyUCCUgzHhQmOiOd2wBfB0g0zZ1B3tWZMFzP?=
 =?us-ascii?Q?AAwt5hRroPR8Jm5G+ff5TcpZo1gMGsZO0NKxO+Ay1DJVYKs7TCH+VaInFqxC?=
 =?us-ascii?Q?Vd1sgtni58owOzR0WxccO+Ys/1EY2H00wY2KFQBNhHJYSBQ6gtY9FKZGpTRD?=
 =?us-ascii?Q?/azugk6/7Q6DNRrFdau1KKwlBT1EwIfmqo0jL2Bg0yifRcLKA9/0BEjnxlfZ?=
 =?us-ascii?Q?kWEyqX056Mn7p6nXnfx5A47gufftMmSDdICiw4o58nVgdMP7jT8T1ao4NRII?=
 =?us-ascii?Q?2lPn4VXyrM4tuoxjn3Q+To1XNrolQ4RdfVrAroWzQWdxNXaLlnl+4GTIvlM2?=
 =?us-ascii?Q?fKzHttTjKPh5RYCsar/+12IX0LFiiu8CxDOIiWfAlEMb1LwU3FIafPS24tgI?=
 =?us-ascii?Q?suJ6Y2fkYEUg8YW3n/qPYyyrp3Ix7hYwf59Li+i4avhl5OymvDCTS4RMBOxD?=
 =?us-ascii?Q?sV+LIbxCmNL07xoAUH3wsj2kFUItXhLAjzjiNmanW5yqUUB/vBX3tr/34qeE?=
 =?us-ascii?Q?VfHtfoZp6HG71puHwQ0SIo+Kmo2h7NywoEoce1mHQ/z4rsA1hd3eFhTrAQUJ?=
 =?us-ascii?Q?XBclRA1mkBQsZYcniJGOO9v9Y1qZuW1Ks7LpdH9ljeuVg58/RgjVwDHQP6g1?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05e0447-fbb5-456d-4d89-08db191c890b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 23:44:15.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RS0CuipNb86cuXV0kFRBPgfqsKmGUODOQoG8jMk3LNFIjuMwYNQ4fDQFk+eF0HL1sizyIUDWjnZKvXqaCJebjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Feb 28, 2023 at 12:26:19AM +0200, Andy Shevchenko wrote:
> I believe that there are few reasons for that:
> 1) (besides that what Heikki mentioned);
> 2) the software nodes only for quirks, seems you are trying to implement
> something that should have to be implemented as proper DT / ACPI device node.
> 
> Can you elaborate why do you need that (as you see no other board file requires
> this)?

Trying to keep the answer short while still answering the question.

I'm working with some hardware which is rather complex (a full SoC with
many peripherals inside) which is controlled by a larger SoC running
Linux, over SPI.

As you point out, to describe the peripherals inside the SPI-controlled
SoC would logically require writing a device tree with their register
addresses within the small SoC address space, interrupt routing, clocks,
yadda yadda.

However, this means several hundreds of lines of DT description, but
this is a SPI device. So it's not like I could toss this description in
some sort of SoC .dtsi which a board file would just include, because
this dtsi might need to be instantiated twice or more in a single board
DTS (depends on how many SPI devices there are, physically), and there
isn't a really good way to parameterize what would be a huge macro
(C preprocessor) essentially.

This, plus that 90% of that device tree description wouldn't tell the
driver something it couldn't know already (nothing board-specific about
this information). I'm not a fan of huge device tree descriptions where
driver-level knowledge would do just fine. That SoC is currently
supported by Linux using some bindings like this (simplifying, of course.
There are some board-specific properties inside this node, which I've omitted):

&spi {
	ethernet-switch@0 {
		reg = <0>; // chip select
		compatible = "compatible";
	};

	ethernet-switch@1 {
		reg = <1>; // chip select
		compatible = "compatible";
	};
};

To get descriptions for all its peripherals, I'd have to describe it
like this:

&spi {
	soc@0 {
		reg = <0>; // chip select
		compatible = "compatible";
		#address-cells = <1>; // address space of the SPI device's memory map
		#size-cells = <1>;

		ethernet-switch@base-addr-1 {
			reg = <base-address-1>;
			compatible = "compatible";
		};

		peripheral@base-addr-2 {
			reg = <base-address-2>;
			compatible = "compatible";
		};

		some-other-peripheral@base-addr-3 {
			reg = <base-address-3>;
			compatible = "compatible";
		};

		...
	};

	soc@1 {
		// more of the same
	};
};

So random idea #1 is: device trees where "ethernet-switch" is a child of
"&spi" (first form) exist in the wild, and that's a fact. To change
those device trees to the new format would break forward compatibility,
since old kernels will not understand what to do with them (no driver
for "soc@0").

Random idea #2: even if I had the option to start fresh, there is just
too much boilerplate to put in the device tree, and I'd still go for the
minimalist bindings. Otherwise it's a pain for the end user (board
device tree author), first of all. Lots of ways to write it wrong and
only a single way to get it right. And no reason to let him do it.

With the minimalist bindings, it becomes the responsibility of the
"ethernet-switch" driver to have knowledge of the peripherals which are
present in that SoC, and instantiate dedicated (not monolithic) drivers
for them somehow, at their right base addresses. My current work in
progress is to create software nodes + mfd (in the spi device driver),
and platform device drivers for peripheral@base-addr-2,
some-other-peripheral@base-addr-3 etc, which have no backing OF node.

There are some other variations on this theme which also made me focus
on software nodes + mfd as a way to make sub-drivers of a larger
OF-based driver more modular, without changing device tree bindings.
