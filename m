Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DD73713C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjFTQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFTQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:15:01 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2128.outbound.protection.outlook.com [40.107.100.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0447810FF;
        Tue, 20 Jun 2023 09:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSlyrg5h1blbQBl4M52TgU0kS5GRzyF4pk6fb6TWNNMa8dSHauT/gqCAKMe1ApzaB8fZVtPPHEMNEp6uexcpZd7/Au0iybgNvIsEHPI+Dek9lemBT5uY+x7UExGGS906kNV9ODuakAvZRPfaoMr00x08SJuIPVTQ8eD51tDTv6oW9AWtvjqEFIcmhK9eAlghocl6/R7p7VRYj9JwOvflig4p8v3jUP+y7MKh5ms11hR8v2aIQu2qu3bidROA/JzDi/sXL6cTIuM3sy0IpkGhdw2rKiD9uDdcxu9OoBKG1Mp8H88vvrlI6p/mtE1Eg2C4SetF3EmMuHKOCCp82c3g0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JZKWTj9wT4J2/HDjz3NLMAWvpiMbbw1PeOsDWODt8M=;
 b=PZ4JVRbx6Twz1J0wDj6dA7tGBQCH3VTa69feqkFz7YF8mb9N4xYjqAgLV+8HyEB/WgKk2KgNL1lh9Oa7MK768NacqEEMw3JbRGtPe9BpbGuKQQmBbVJT00IVOUdXQrvll3lvD99alVuW32i1RL1IH5mYI7qHf5y+Z5AASP68eY+Tzj1afjqiNLacAHjOwB6ldtP/neqRV3DTIv23fdJAE+vMG2edE9e4JPBm5wRpT8UTDbC7qO9do//sVYJe6Oh2IoJBoafrZGwIECXj0qyietiRwmYSwKNtXroCHN04h+PQCK6RRzjWwmicJ5Na7k+XygFoHGloDQpmaSNrMleT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JZKWTj9wT4J2/HDjz3NLMAWvpiMbbw1PeOsDWODt8M=;
 b=tj5VsFQx9YzEKF4593h0Bw9lDB4dEk4KDLXw5do3DStH6jww9fy/Ezt6bFLowzC6D2SFc0O06LP4AcYVOxP1TP24ckrKav7pQN7eckbYxIswrlMf61SYzihGgZfNovW/xbqpVojU6I94FF5nXd3stsESF/j59bVpCFYnCyJWvcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB3688.namprd13.prod.outlook.com (2603:10b6:610:9b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 16:14:52 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 16:14:51 +0000
Date:   Tue, 20 Jun 2023 18:14:44 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: microchip: add ksz_prmw32() helper
Message-ID: <ZJHQdJsnw9TZUM1E@corigine.com>
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
 <20230620113855.733526-3-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620113855.733526-3-linux@rasmusvillemoes.dk>
X-ClientProxiedBy: AM4P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::24) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB3688:EE_
X-MS-Office365-Filtering-Correlation-Id: 172f7ef9-c917-4286-869f-08db71a97a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ap9FfmEhD/PclGk/qZapID6BAOTQnORc33/+qgsISC2esawXY9K3bCHw8XMugFwLVua/4qbMKjReMTqfHci8NZ8lhiGi4P/fE7IV9U0Y5aCC/iPCYUKVNoZInFCYevIH/luMt2HPV/pSeZAIlBSUKN6x/Hj+CXGS1E5OGDiuei6PZsY2mIpnyLsrbE3755CFJaM78oSaBpV6lCgp007NBEEOwZKvE+a0KIfyughqtpMLLcgiNWRabse9hfA7YahhZFRGkOjeXIygebjGnuLLpiDmEgq8h8dmpK9T6LeKNgU93+bx0m4VZ2hPQ/oLqnveXe4CVdfrWD1GfdlYOB9meozvQ8rrn61gApyFvyOG4OTKQl9w5YK0cV8lkdEFtPfkYx+3dUHQuI83DC15BnFob1AX994Xtoz/lLAwJOfOmTVEbFCl44IUI7b6gen1Jl7UXKPr6HNoC0rRXULynkfL943Wex2KkIQJQ19d0a+Y8xWHBqC5IHWWYBF/i/sJk99MzW0nTItYfAexc3XVTLi2m7e3GP1NUp3UqGbROH+whmUlH5kzDPPbAiUEObnQXPSQK+utcU/feHB5d8KK0Rk556ywF47QI4EgdyqFJAxfxB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39830400003)(451199021)(38100700002)(54906003)(6666004)(6486002)(478600001)(2906002)(44832011)(5660300002)(4326008)(6916009)(7416002)(316002)(66556008)(66946007)(66476007)(8676002)(8936002)(41300700001)(2616005)(6512007)(186003)(6506007)(558084003)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nSQ/0Q06hAU7B0D+WyWufqVgSTos/BlB0rp+o9gxiMzGw1SfzMMagjg7fwpN?=
 =?us-ascii?Q?Cfn7EPjdSf0TQ3qE+KguMS7nanxbWj5Me/35Ny1Rs5d3a4PED43VFZL/e2YE?=
 =?us-ascii?Q?ZjofJWZpZw9vxL1Ra7R2nrgh04Ixp2y7F1KZ2rXZ+6nQN9pARrx2zc/RhzDL?=
 =?us-ascii?Q?ZRK9z3ls7wxaq1yQh/Fzr9+2ubx+u51gY6F9+L6WhsiJhTLxRYEylFx39ndA?=
 =?us-ascii?Q?dEqkazZ33A6SnS+hJw8CjcDeY5LmS9RpFVmVS5KvKIc0eC7/1A5bfYGxf0BC?=
 =?us-ascii?Q?z/y8AAivx81QfjC89wKbqt5Fdpinkd8Zij06fmw4v0uWodjSL2Xg/Kqoi5mP?=
 =?us-ascii?Q?Ikqyl0WVnCRwY8efrRoim3WxWcMB+6oCTpuh7QbG/zXm8qxvPZy6YmK6o7OF?=
 =?us-ascii?Q?rSU//joxEsmTajFE+rXM3tiZE6MLmrYCCdKj/rEnNKeSBXar4xJjwVXBVoxE?=
 =?us-ascii?Q?fQaopF5l7nvZ0p/z8DgIVUa8TKw7p5ELeXE3dNEyo1YeJT3lzL7Ba6HO9Myl?=
 =?us-ascii?Q?CVWxzOIWwhf/Eca7kVSsXegeA8Sn0iP3GlGJIjY0dmyCgHfdD4XLErdugKfH?=
 =?us-ascii?Q?xm4WjLmxmu9ezQ6fOgUnqda6gcAtdsS+XIl4o9Tf2UexAFq+rFRiU81oSXjM?=
 =?us-ascii?Q?/J9ReD7vAMCIiV/+i4TLpXpQmDUAVO3xciCCV/lRdRqNbQBYhMCm+UQJOpyt?=
 =?us-ascii?Q?G9XRubT4Ogtutw3cMH8WlNTMLPUW3SoD00KDj3d+OoFdLzKk3a2JpwsKRF1K?=
 =?us-ascii?Q?Aw/aUYbTzUKyudF6CqSv/4DNSNP9KNzOFiuC2mxtcjMq6rap0hXci3XzdL9l?=
 =?us-ascii?Q?f0MUfik6RFUNHsa4J1oiR0BpkTPfnecQLJMJK7xIZ6qC61T9uc7+/40yF2p5?=
 =?us-ascii?Q?zjoFet9LfocXF1r8LoEfRwz5UatUhJch/JB1izU+gCYY0Uk2BvTq2ft2Ga+4?=
 =?us-ascii?Q?1kdKrDEJHCpSgm4xS8+BYrDEUzYJ+uN7HiMhCryuXqRia57nB52Wy9172xB+?=
 =?us-ascii?Q?pOagkAe05kPezAhSmhjRWGVbMPJH3S61JkMHEOigu1lljWFh+17XtcBoAdqj?=
 =?us-ascii?Q?IhRzQxUFZBazCaYKH1jQ8Q9gnPdWKIv6SYZN1Ynk0+O5Q54XIX48t6mrm3mX?=
 =?us-ascii?Q?dRwUvWJ0TK9D3m8ztM/9g3/i3vCy6NpG6UDYAlqI1iNn+7bBVt7KRE7LxEcw?=
 =?us-ascii?Q?qoNeHrNgbLsgJSTNja/2wob5KQMViYd7UqI9iQE7RyWNEENFZopflmZj6O34?=
 =?us-ascii?Q?RwQD+wFqAH/0et4J4rHDWoNn6TLZ6KwDjG8WRc+GMV2hyuo9E9vbcJm2Fy05?=
 =?us-ascii?Q?UyRaHH3/UIt0M+jekVbjynjXtASFEmasE5n3JXnbZGNSmDsn52Y8vfma2y1s?=
 =?us-ascii?Q?uE6o238NEsipPK/nB87z6fajooJ1yU6kI3YyLWDhj2xef74KTlHY57nj59G+?=
 =?us-ascii?Q?lAuOev8xNwn0hGlcXuwgvxgU4UGxLyV8bA1XSwYFbh/d/ghdWkNmNdWw5tUO?=
 =?us-ascii?Q?GQTIhdu2BlQnP1zM/vDrPh5zMshfKsFOjaXDn+NI9k2OnS+cLzEhiLAYFrBm?=
 =?us-ascii?Q?O+7inPXY3Uditr6R2xK9zu34jfe5E7UjTq35LTMZWY6vBH9jHdUzw7ORbaTf?=
 =?us-ascii?Q?wHLWqutU9mSF92XPueWzUD9M7DCnCxQqKqvIkkt7Oj/TkeJpVpz4iHF4XZig?=
 =?us-ascii?Q?mlfHMg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172f7ef9-c917-4286-869f-08db71a97a02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 16:14:51.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4nUBL07qeke1tBGpxIXRhG6YRSgMrvZdw99vjkqKXwDPR7ot5wBx7vL7BB7LSeVRaPy5NANTK+od6sxHxJ3ODkGqDj+lZS2qah8xBGq/Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3688
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:38:53PM +0200, Rasmus Villemoes wrote:
> This will be used in a subsequent patch fixing an errata for writes to
> certain PHY registers.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

