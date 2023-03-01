Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A2E6A71F2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCARS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCARSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:18:55 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA173B473;
        Wed,  1 Mar 2023 09:18:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4gssM2GtJiMEyETfE8CziHRPwAAoQQz0lcmUKWmI3ViNEPCY6jmYResQAFj0PsPWVEEBZjkZ9meRZUYHIulKNm0oelGMS1iq+jxOBNQKuf0qGjz1cQ6CjjzAQXJAUFG3NE6qvu6Za6ZV0SBmlk9kV+/xOuaVc0tFOf9HAsVm5aA/o+1iLh1aMzAdK/8NErrwXCs+3xIKIiOZs9jcIkKvZdzlFNQ+N+voHV1q432mpY+eY99JhT6Uligx6FM7OKKh4R0PHuAu8QnQUkAEKrG42l2crvWurnUvwT64kRjI3ma5obNzZAZ3kezjoBzDS9NSY2LFyoDe4cm1Ldz/0tXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl7jU2hv5zVUQ0zB1BwM0SCSolfUE6zBw3dkzpIw+OY=;
 b=NBGsovC5PuoMTVsk0vm4BTBaytO0uoRxXvkLTilZkQXsFaNGYWKQMMqVzZVCF3y5B+BagPKvnH7Kwz30VOzf5dbvBYTh/nFIYCPlCyCWEvqARmlBCpX+sOpD3ijkh1I80JSJxYyRxF8drWAIeHHeo7ovmPyg/EnmSb93ukqGPTRADgGORpfP3/61YvU7jjFj9wT18Kjy7ZfmpFyTGePmczpGLios1+j3DR2Wv5Vj6bbSTcgZJUqmfw2Ibs/GkhRrEJm4WH+GDD3OCTeeqC8Kmhs1tDuIBaLZ9VJo02M8fULMPF4nEYKtnAy0QwTcemVWNcmtuRMmCeEk68WFnQUjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl7jU2hv5zVUQ0zB1BwM0SCSolfUE6zBw3dkzpIw+OY=;
 b=FUCfdcE8Ei42VoHOH21mktKda6Ol2D29xCjyugVlq6c+mszcUHsSG/4j6bQYx8Nm7Vx2Y/mr3ZLYwioewUtpBhfkG/rktKw0zLr3xJ4OXuwfouwLxCbPjOjmZKn3l4e6ofNbA0PtG8TSe/gPgGmJzKvKnppm/omZe3eTJsJvNng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8589.eurprd04.prod.outlook.com (2603:10a6:102:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 17:18:48 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8%4]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 17:18:48 +0000
Date:   Wed, 1 Mar 2023 19:18:45 +0200
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
Message-ID: <20230301171845.oliqbso7v2vmyqr3@skbuf>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
 <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
 <20230227234411.jqmwshzkeyx6iqyo@skbuf>
 <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
 <20230301143625.7kdnzujlv4psbhla@skbuf>
 <Y/9qtT0vckSikOKJ@smile.fi.intel.com>
 <20230301152527.khyzifds4w3rkebt@skbuf>
 <Y/9wlDkuh39auAgF@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/9wlDkuh39auAgF@smile.fi.intel.com>
X-ClientProxiedBy: BE1P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcf69cc-d4f3-4831-11e1-08db1a790555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8L7aRGnQuj9dZ3PHeH130xBBfcd6jPCDKnxvKUwvMuubXzf1R0pdSTXVAPVtUvuvxpRI+veqP2mOO7iL85VgBun8VsKPsuKt2jDX/sV4mDLJXy4mOo8gEPT78rIft4zR8FO0C5SlPmHjqV71B2x6IyfsMTO19TFtBaAyCBnbDGKhH/wLsIzpDrcHkiQQ7rLq5Mi508iF09NCZfAww92+NuyZDVNLVA4++VoJwFdDlIAp3zIJrLGMpTQyEGah3DigpBDxE4qtYZhv1UVIuvKN+O6hHQnvXWsxo8ZrP/unuFqvUARL4UbnwODMx4hIQ5zC6MUKczNkGtjBPu4hxmndmxOtdmwCi183Ye5YD0s3pVOkgWrUxS3ok33fAokPggqjnMqDWa+4+boZ9zhEzVH3wxd19Szc9e7R9T924Ev58DBqCFbh0PjKi+HgIRu4SnK9rugB4cT7rV57FrjFYVi8oABx9Z6O+xnV+1aAKSAxEV4VOtXLbtJsUgCtbQhbz80U8y0as7uvemx3bZRWXkcHL7ax+v1JKgqIx8Ug60hwSQhIxpUN0Q4veYfS3wXI8D2ghGJk2C8yDzTdt3GpzxHAejgdAHN2E2lLG2PsAJuZFxyd6sDwMVhvV7sXmFvKRyQN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199018)(38100700002)(6916009)(86362001)(44832011)(2906002)(41300700001)(5660300002)(66556008)(66946007)(66476007)(8936002)(8676002)(4326008)(33716001)(1076003)(6512007)(9686003)(26005)(6506007)(186003)(83380400001)(478600001)(316002)(54906003)(6486002)(6666004)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ca7VuG8t35lw+qQQBGIhY9dFwOrtiMhkZiz0ZuOKZowwIo+Ai9A+RpnjbMEw?=
 =?us-ascii?Q?HVs2uv+eat/RCY8y7zR5F19/CphTDf3yOT7IV3GEibJtklwEn2WMWvEDivoV?=
 =?us-ascii?Q?d3Ouk6R8v+tWM6RVPB04xElPrIHZNinr8rA9iOtUVpjd8xHVJ0KzDLvR9h+I?=
 =?us-ascii?Q?Kaj32u7MgGFa8yri16EvhMt6N760vWRCiweqHv3PmBPgBRDroUwcW/yWBQvG?=
 =?us-ascii?Q?b51x5MfcvANU9n5MaPeQoqO+HsXTWm2zML9I0d9jzrSzJ6GqyWu6R/dqXqLr?=
 =?us-ascii?Q?smubC+PR6L9xMZfGNwgdMngplv8XYouUHsmvTsf/iEce/9xJORVsY1NfNiZH?=
 =?us-ascii?Q?ti3bGKGEcO049/M7AjrGB/3xhWse8EsW6qjsX8/lpQ13YD5nWKPiUwWwOwGb?=
 =?us-ascii?Q?XPiUvTq10/BlknE+zwslqRmwHxeCtUNeu9cOYwgYkb/dRHhmQWvSyAQXJWAr?=
 =?us-ascii?Q?27NTFnM9IwZW3I1tNPbO8FGXjT3OssFICg95nG88iqQbsCbSRFvRkJcVOVOd?=
 =?us-ascii?Q?13a021OVC3w2VMI3ZKFwLhWnd+XI6G1aheV7Rjg6J6ex1WkHehkIToZmOuyx?=
 =?us-ascii?Q?NmWl0xm0+9oly31nLtMBe1Z7ju3oCyov2d/yjb6QOF+R01o4GgBLmHkZSDyD?=
 =?us-ascii?Q?ZHieQba+WSezNuBhWgONs5s40vcIgne3Gnqp8XpquiwlgPRUUcnnr8hZkZkB?=
 =?us-ascii?Q?dfq+Iq8ynGM7OKvTTWZYzWMs7xpk2qWGT3P/eyh2wGCq32pB7vlUzSCrC25a?=
 =?us-ascii?Q?Prk/KbEORCheeNOmLMNG7Voa+RIKsCoSBJK0JRDMIUC2I76eFbVoxOggngyj?=
 =?us-ascii?Q?ZPKllkpSc5xERGCB7mRiAK0DYyLVbUH4wzcwtzHLdt43vZDyb6iZ3EWKkL/3?=
 =?us-ascii?Q?U1Em8Xc2nPXbEghP0c6T9lRnsmH9ykgM24pOu65Y9+EQZgUoS2lys+dBicj4?=
 =?us-ascii?Q?zgrTLsw47lcZv0a8MoxJ0YZ72AFVNzGp8e1Ss51zbm5C1jA93iqyQaBzr5+J?=
 =?us-ascii?Q?iCv1Rb8OM/O43Ift/5uoCeOlbUMvES1q2Q39hOJ1NSlpbDofYru4FgkghoKm?=
 =?us-ascii?Q?sLTvVTb74ygqgBsh6Sz9M71mAQH8a3voSOV9q3j3+MDryzoqMaxqKuUcBgX+?=
 =?us-ascii?Q?Ez7gNBsstfCY4mRumFT+HzbIziwOLygSwmOorTMIjw4+04LzNvNCgVV+rFMR?=
 =?us-ascii?Q?kkG3V9A7EE+aYxeXx5EEtMukJ616749DP88IEfJUivz3kD6HhysYG4gL3ctL?=
 =?us-ascii?Q?qsWI1XVdizbygIPsV3rXYTU8sAsMprE5Jaq8HAwjzWlkFQ2+Fx0gV5rcGECL?=
 =?us-ascii?Q?Koby3jlCScOh4R4Cbty4xkNLEhAkUIarR7ZfS4Ive6lplS2T4emGc589BHX8?=
 =?us-ascii?Q?hSiTWBEh9TV8XrRtityoPzvZsLimvI4lxozE1JL+KX2KD/oKmjlis+SjpgJS?=
 =?us-ascii?Q?V4o1OlRc5ceXGKF0zffmOG5JKL+N84JAPsSNv4cwCLcKS1wtUcGGW2sO30h0?=
 =?us-ascii?Q?vp7THR0ZF4nMCimBGK6cH8X2zgLFgB5F5VuFvZLUoPoYym0byrNM1r09r/W8?=
 =?us-ascii?Q?ZyYEUG9mMnBCpULBXGywXLtt6ZRrLzFkot38A2TMMvIY7tqwOi5wJHkZ3DJS?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcf69cc-d4f3-4831-11e1-08db1a790555
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:18:48.7602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUVQAtaw/pzcl07Wb5KWnpl/cCr4a3CulQ/okRk3PkXcRSenkHBHrCeUFcp+YbSNoxnh410LXTeDO8ylOFFLnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 05:34:44PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 01, 2023 at 05:25:27PM +0200, Vladimir Oltean wrote:
> > On Wed, Mar 01, 2023 at 05:09:41PM +0200, Andy Shevchenko wrote:
> > > With overlays you can create the proper DT description stanza and end user's
> > > job is to just put it somewhere and upload via precoded script or so [1].
> > > 
> > > [1]:https://docs.kernel.org/devicetree/overlay-notes.html
> > 
> > Ah, okay, no, that's already a no-go, since existing device tree blobs
> > aren't compiled with the dtc "-@" flag which would generate the __symbols__
> > node necessary for DT overlays to be applied over them.
> > 
> > That, and it's clunky and uncalled for in general, both from my
> > perspective as a driver developer and that of a random user, if a driver
> > would just start requiring device tree overlays for more functionality.
> > Overlays address none of the complaints I had with large DT bindings
> > being large in general. They are still equally large, but now, they are
> > also spread into multiple files.
> 
> But isn't it what you would like to have working for your case?
> 
> Even taking into account the fixed HW layout, it would make sense to have more
> flexible approach to describe it, no?

Not really, no...
What I would like to have is a (partially) auto- (and dynamically-) generated
firmware description.

I'd need that in order to have a cleaner separation between the device
drivers for the various peripherals on that Ethernet switch SoC.
Currently, there's a lot of monolithic code to drive those peripherals
that lives in drivers/net/dsa/ but would belong to drivers/net/mdio,
drivers/irqchip/, drivers/gpio/, things like that.

What I want is the logic that gets me there, with none of the complications
for things I don't need.

> > > For the second one I'm not really the expert. But either FPGA framework (if
> > > they have anything working for this), or you also may look at Thunderbolt /
> > > USB4 which uses similar approach while being PCIe devices. Okay, the latter
> > > (USB4) is the PCIe topology, while FPGA is whatever behind the PCI switch.
> > > Meaning that FPGA case from HW p.o.v. is closer to your case.
> > 
> > A quick glance at Documentation/driver-api/fpga/ shows that it is a
> > framework for dealing with reprogrammable hardware, and has infra to
> > reprogram it. My hardware is fixed-function and doesn't need any of that.
> > 
> > Are you suggesting that I should look at reusing some common infra with
> > the fpga subsystem instead? A quick grep for device_add in drivers/fpga/
> > shows a bunch of open-coded device_add() and platform_device_add() calls.
> > Is this what you wanted me to see or is there something else?
> 
> Ah, so they don't have a mechanism on how to describe the hardware inside
> FPGA _after_ reconfiguration and apply it to the system? That's what I meant
> when referred to it.

Reading Documentation/devicetree/bindings/fpga/fpga-region.txt (with my
limited and ultra-superficial understanding), I guess that they still
use overlays to describe what should be probed on the reprogrammed regions.
