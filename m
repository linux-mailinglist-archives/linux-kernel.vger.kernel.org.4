Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A787C6A6F60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCAPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCAPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:25:37 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF530C0;
        Wed,  1 Mar 2023 07:25:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwIarR/0f32sunA0joOCwibbdZyLIVslfgORsz6L4x4Eb3AaLQ96qd61lQdmwpY+T96hBlEKdijFl2Q+/Xj0usgowGA6egMhp3CsOrX1d3IuualULPr+FSucqhhQA9dLqvwr99wj9CiFLv3sUBAPqL8vR76WMxYmkDN196yO0HVA0mL/jGO9hPYw2aBgpdEBQnzg2+pFuyV6hJVUrHw+bRG+p55e+73XT0oKL8scGNIp3kOvDEHQWTNPdhx/RJKHovfv4T+F0Y28TUJYL+d6kyRSR+CvtJ6I5QAQI99TL8LjFSILg2yQJdP+hSjuF/WP7ycjBA8080Z5Hy6wqn3LXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBW/AgtxQCtBegPKpb/U+q3oxRpuyNRw9uVWJXoqexo=;
 b=SPqGU72wXLK5NPFyjKSsCyAY2f5jPo5qLHua4CyM9DsFx+Xvey15O7pCt2x+XbzGeNwBG4NjqoeE5G6pds6WokM4MPPohSS9rZF01zJ0+bIPB98wYu2LtaZ/FJj1qRhuiSdMh3QZwCxbDQ0IIZo8zTRzCRWAbj8oJs0iTLCIqqUyfLsqIiKlYkIkO6RnzRSwpTPm4hnn9u8QHSBxz3wnOGc3MWKLZ1OUdk26qXeg7sra5fzP+k2zMrsfFt5wghnW1pvMxi5dR95hTAWAHoiYPcwpYws4qogfPsrE/0LjochU1F/upYXb61IPXBrV5isFDi0US7Zp25BeeoZGxehLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBW/AgtxQCtBegPKpb/U+q3oxRpuyNRw9uVWJXoqexo=;
 b=ZmFvf+jKxcBv4xTaSMNPFhN10KjTRsQOYfgSz62PTvG3Jb0FmxaYaulskEdBAShoU9NIxsjODGiKaegghbb6pvNpWYawb07g3S24NhWvvDIhAUATjD6fwO9DxDitNuOC66yr9mZu5jN70I6eBAJFo6IjUry2KxcVh4Ak3Xctjew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DUZPR04MB9871.eurprd04.prod.outlook.com (2603:10a6:10:4b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Wed, 1 Mar
 2023 15:25:31 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8%4]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 15:25:31 +0000
Date:   Wed, 1 Mar 2023 17:25:27 +0200
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
Message-ID: <20230301152527.khyzifds4w3rkebt@skbuf>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
 <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
 <20230227234411.jqmwshzkeyx6iqyo@skbuf>
 <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
 <20230301143625.7kdnzujlv4psbhla@skbuf>
 <Y/9qtT0vckSikOKJ@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/9qtT0vckSikOKJ@smile.fi.intel.com>
X-ClientProxiedBy: BE1P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DUZPR04MB9871:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b3000a-4753-4296-8b4b-08db1a693188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SiqpaMc6D8q/3rQ+2z6p9YpaN77JkTM5rKJf13F5jPCYWB9ecK7NNg28uFC69tYlkUTP264VpzOBMarTM/StvBBDe5vV5OSqPvhucmqdncCCDqACyyrbtqvOlmB7e1BjE9sqFd6gymf1+gYndlTmJDqSG0GDd02hIXbFqv0EnO4pVQPlds3/qG0wM5qEF9n3PFouphqZUQalCRSKmZxkimfrkEwUjt+XfpP2aAXND+EG8wWju3JIR0r683zmcI3WIzPASEp5pj28pTkpJmdmwvVHydbC8bYlUwKr8fsp/U3Df5tVOL0zWxzOSEuG+wKqDKW7m1e/qZ8QZ9lKiY6+fxqIk4EXv7Lx9R0nDlNOTabd0OU+DAdJSLEWY1C3vpHLj3coRHtZM1sOqFLXl5nyD4Cv4z3uRg8qzQHKGKsToFxAJxH61ECZYTECRSHqxmfu4fz6Szbq8PwmdZN//Dokv6s6GqZuMiPkRqNMqDE2MGZI05h8ooUPGJ+TUvgtfWmBWN+d/7wVrRZMA0/vdLO801wRr6Klh5o4zcAOXfy2Ke7sxHF9uiLdo4O2t3mNpJyD6k9AQ4Fny3gmpClM7WmI3DTFTeuugJGv4GkvGrlxQTKwTAmQwH16t4fDfmTNHGCL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199018)(33716001)(83380400001)(54906003)(1076003)(6506007)(6512007)(6666004)(26005)(9686003)(186003)(6486002)(38100700002)(2906002)(66476007)(8676002)(66946007)(6916009)(86362001)(4326008)(8936002)(66556008)(5660300002)(44832011)(478600001)(316002)(41300700001)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F+oSmuDe9sVIbJ/6mdl9cRUqSoI5IRxsAN4o842eziJ+ewuP+IhgwHtUoTG1?=
 =?us-ascii?Q?FN94cdM8hFbEuc9dGQTh1Ydg/WOP/ISOFZZIxwqCMt3WJ/4AgdSptCTwJ6QV?=
 =?us-ascii?Q?HPZGdPAZbSuXw7Pmr2pqnFbm7b8ru772shvllU5l0XLk70FHBJa1w3EL9Yzv?=
 =?us-ascii?Q?kYAN86J3ARsaS+nvWCOx3eUFBRfFbdUMvjehMqh9R+3Rc4yXR5LaodKRByvK?=
 =?us-ascii?Q?idyS2nTNl/YjV6bX9Wl1kIrgHeCRU6+OvRW7H4WaPNNlQayfmLJnaHms8xZM?=
 =?us-ascii?Q?7j99XeDe9juCuJjqEN4SG66xSiyukUBK6HNxfFvkQaotrJq4seyCiZs2h79+?=
 =?us-ascii?Q?Fq5eObPvyn/GzptGN2bgTW8Mcj99QFPhYgKbSdkYWnl+7zm2mSTOlhNV5rlh?=
 =?us-ascii?Q?RXvQxM1Apn2BTRpTrYflNNknMRbd2DGM3VZFQ7TAp1+3j8nNJiFU5EWX61PX?=
 =?us-ascii?Q?6nZRZUqeSs8iA3anJBQrvmDY1IVGClIHC1+Ay/W9i5hYdJM963t84y0c1v+r?=
 =?us-ascii?Q?vBZvOPdwTaKOc8atRG7PwIVSRoAcm6x4eCBeBeC2X195Wbq3VPIwzIpnXk6k?=
 =?us-ascii?Q?raRFz7B+e71bC5ydoiipwLBwIA3KYpbG+XW6MFaeVo7yWGn2I0wrgyfrk0Ey?=
 =?us-ascii?Q?62SPEMKLDeH9ItlRM3tsE9jOxUwCCBvxGiLhWK8GaHO9ONvABWSHPAdpqLpt?=
 =?us-ascii?Q?5y3hWUfiKeettky/HAlImq1SggRFOeLxFPU6snvMNOwEHkLnuuLCKmeC+3hQ?=
 =?us-ascii?Q?6n7Bl3e8+JIU2L0GR6ZG4NLEtSWHymQpBGokXzyPA/QELk2wgQUdZfy7g/QL?=
 =?us-ascii?Q?fr0HkyQALjCZKzDMMq0EMecO9ak+2rg2BplA/iyKUwAQGgyw7KWwdubKZtvG?=
 =?us-ascii?Q?fxG17p/nEuRZ2Z+NCIlHeLng9NtALmVcLIS8mNqrDNTbn8DKxyOCHxhBuqnX?=
 =?us-ascii?Q?BJlkbBW9tZ5z+jYU7g4fKi2bre6PykZpy3NBnEa3ozxzvEOc5QH95NnR86f0?=
 =?us-ascii?Q?7Hluk03Yy3NZ3xdvwuCmIsl1OnDDOuEBM8KW1IRrGr+2JM/Tlo2gM14UKadz?=
 =?us-ascii?Q?0icsrnWL8enqvGS9Obfj7wB0sGa8fECqogBzir2TpX4M7Rl1lqlxVforcgCr?=
 =?us-ascii?Q?EhdSSXuVUla3oNLztQcJAr3w1NsH19VVGTVwJEay6sr2QLs6PDB0Y9RzbZMQ?=
 =?us-ascii?Q?G+6GIR77gLExaSggXnP1ZyoQC+TjG5j2C0jj3sZBK0oyD91+RqtkmEQByqhw?=
 =?us-ascii?Q?PUXzQwhSINoq3LPrGKezCrSQ+1PaCdrakAP6szN0pSODUjyKKqinoU2vRIoz?=
 =?us-ascii?Q?cMwwTEcLFWGHnOTNFEXrsCS6vdobgQmyYLOfbp7wmSn1FTz9ugEAGLh0Gs+R?=
 =?us-ascii?Q?/VMlkvGJUix+Eau+r9GiRpU1K2qQnIgvlk8L+6+l+I0Ox+S3ZBQOJ7QKC07Q?=
 =?us-ascii?Q?MOzuxUIz65uomEPPdzvbeflT1sGq4dPXaW2FGP++/BRtEoycjjOqzdbtF0tP?=
 =?us-ascii?Q?/4nf2nyA0C9Cxim0JzElTovPDrw724zMHAgfULSMJoQ/KI9d8C51aH8CRizx?=
 =?us-ascii?Q?IGv8ICohq7Q53zlVNZy1KQoihRjGqr+3Rqfh1NoKQHqFO7i+qRBhVdpcdrmH?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b3000a-4753-4296-8b4b-08db1a693188
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 15:25:30.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gP4MoGJ9rDfOn9aVfLMl/ocib+iLYUc2zUIlsRkFhaJAClclcmt4FFmmwiXz9+TlhUVSp21ttNnX7eazsN7pWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9871
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 05:09:41PM +0200, Andy Shevchenko wrote:
> With overlays you can create the proper DT description stanza and end user's
> job is to just put it somewhere and upload via precoded script or so [1].
> 
> [1]:https://docs.kernel.org/devicetree/overlay-notes.html

Ah, okay, no, that's already a no-go, since existing device tree blobs
aren't compiled with the dtc "-@" flag which would generate the __symbols__
node necessary for DT overlays to be applied over them.

That, and it's clunky and uncalled for in general, both from my
perspective as a driver developer and that of a random user, if a driver
would just start requiring device tree overlays for more functionality.
Overlays address none of the complaints I had with large DT bindings
being large in general. They are still equally large, but now, they are
also spread into multiple files.

> For the second one I'm not really the expert. But either FPGA framework (if
> they have anything working for this), or you also may look at Thunderbolt /
> USB4 which uses similar approach while being PCIe devices. Okay, the latter
> (USB4) is the PCIe topology, while FPGA is whatever behind the PCI switch.
> Meaning that FPGA case from HW p.o.v. is closer to your case.

A quick glance at Documentation/driver-api/fpga/ shows that it is a
framework for dealing with reprogrammable hardware, and has infra to
reprogram it. My hardware is fixed-function and doesn't need any of that.

Are you suggesting that I should look at reusing some common infra with
the fpga subsystem instead? A quick grep for device_add in drivers/fpga/
shows a bunch of open-coded device_add() and platform_device_add() calls.
Is this what you wanted me to see or is there something else?
