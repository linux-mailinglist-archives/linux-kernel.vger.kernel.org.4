Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852F96DE998
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjDLCmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLCmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:42:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C8E170F;
        Tue, 11 Apr 2023 19:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afQtD2r02i9AtV2zWI6oNW90q7P5e9KOrRXDe8WWR0pijWQQ/p5x4zkNJXm928kklou1oG6wxxbx3EJizxPZzymiG9eAmlxCa7x5L9+lQud+63Q9H6QZzthKYHf+OgsNuSip+lzzm8vnd7NY6Q8UgJBDAtGoJU11Y0saVL7ZJd7zasUY2pnjDBXx63piphrX11zsbw0lEnXcR3RV1uEXu3ySh6p7JXsLUTNOSNhznf9iXdZS3ASgj9TbYe5zWEh/1qk6tX8PlJMw6g4lLckmmijeobF9b/dURffROrAejnLZ4O4MBG0N8F3DyIKv9PKtgTqGjGXFrHBYznz8FZKrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jVUqqZs3KFvvwOHmyhUo02DFgq1SRcJsQZ+iMYj8H4=;
 b=mAHcBY3pXtV7KMaB9XTCVz3xauQCPY4s6SHalWde1mYvgIfP5OCi4MOluyzGNUkKrz71C4EU1nYYlONz8qsiUUW85oiQsw8jnFdfNJlXcF23T7QQ8LRYANe6IxkLb50D1Rcw5ta13XWCejbBXwqaRGnQIIHHHGMRbBHlt8HRTIvLWeb77i/CuBg9178e2VI2KooHKw8dGO0DSVhBsT+6VNYaycxR92F/Xrc6n6O65vgE/YImmRZJcpDvFhTeJ69Vz2MeY978gWca57ZWRTorHyWDYSgGRO/Qo3zezTjzMR8phaYdoP0pz8KMoluO918K6NTU0abLRxQp6CuwJDf+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jVUqqZs3KFvvwOHmyhUo02DFgq1SRcJsQZ+iMYj8H4=;
 b=Q4nY0iSnr2MV7I/v4+I9ueC3tzqQmmkz9mJF6Oq2cjts4Wgj7RLd+fTZyZUlr+1Gn9YQOO39MscVFPBKSmPXRFEq/CSDU9qCDZ6hl42NCCNhgf4d++J4eyrSFTO98v/UcRioPgQN4+5bLw/Xxlnp5DN6aOlDZ/poGVKMBoLYI7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com (2603:10b6:4:7c::37)
 by MN2PR08MB6397.namprd08.prod.outlook.com (2603:10b6:208:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 12 Apr
 2023 02:42:43 +0000
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::5dc4:3327:28d3:af7f]) by DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::5dc4:3327:28d3:af7f%3]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 02:42:42 +0000
Date:   Tue, 11 Apr 2023 21:42:25 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Fred Treven <fred.treven@cirrus.com>, dmitry.torokhov@gmail.com,
        ben.bright@cirrus.com, james.ogletree@cirrus.com, lee@kernel.org,
        jdelvare@suse.de, joel@jms.id.au, cy_huang@richtek.com,
        rdunlap@infradead.org, eajames@linux.ibm.com, ping.bai@nxp.com,
        msp@baylibre.com, arnd@arndb.de, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] Input: cs40l26: Support for CS40L26 Boosted Haptic
 Amplifier
Message-ID: <ZDYakQMOPsPTbGe0@nixie71>
References: <SupportforCS40L26BoostedHapticAmplifier>
 <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
 <ZDI0p5Rkp74SzJCv@nixie71>
 <20230410085634.GV68926@ediswmail.ad.cirrus.com>
 <ZDSqfHemG8pKj1k7@nixie71>
 <20230411092708.GX68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411092708.GX68926@ediswmail.ad.cirrus.com>
X-ClientProxiedBy: DS7PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::6) To DM5PR0801MB3767.namprd08.prod.outlook.com
 (2603:10b6:4:7c::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0801MB3767:EE_|MN2PR08MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9db6ac-e1cb-4995-6c8b-08db3aff915e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51gbqJxeLyfC/yQzC28lksXcf+zq7bT3sn9EuNxkkyPu3EP2+f7DMwr+sZ93OjW2EJo/3/0nT/+CC4L5VMkDspc4EhgC1Z/L2z24yOSUmoNlddRLBQ4ltXroh1n474z5tBp0TE0miuyOEoqZt2gXZm4y3s9l/elTJXW5i5mcoVTVyuvuSK1qrUCm83drmB1GxOSUVyaXid2hke70Xtasgb7nRWiS56jyYdmuFaaC9IyN1K7okdpcU3BtpFL93J4bhlues5DNgB7LcVuQS4vdBQ34tPzWzFKlduSaUcBIzhaCp8pUKSQjiz7DD+VtezwAD9ginDThUBCVskirqzgM1xKE3tSSBW7u9Ch32ke/r/Wfuw+AOaz3hGU9wXhrQ/KAalEiulG3ABrCVgckR8fPkyEqBWVVzFA9NHLJmPSaq5ZkknqjELW/2f8lpPuu3BNq5N9BGISpZ7nMmLN+MEVQi/oE6usZTnRcO3gtCuoKi3k5HVKhsxgwPzRZE3r1RYYBmL/efu1HhHBTSg+FIWaK7ON27Uye0BeXUZuKT45wWOvm+NR0kruJAo4qjTJbalTH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0801MB3767.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39830400003)(346002)(396003)(366004)(376002)(451199021)(6666004)(83380400001)(186003)(66556008)(26005)(66899021)(86362001)(66946007)(6506007)(9686003)(6512007)(38100700002)(2906002)(6916009)(8676002)(4326008)(41300700001)(478600001)(33716001)(316002)(5660300002)(7416002)(66476007)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clnSItqOYBybgze9cEvvJo897+eoJWoE6lCLriRnvPPP6qC1RGOIYW6D+/5j?=
 =?us-ascii?Q?twKPKwQ++f15uVR5sts59dR6ZzhB9MeV82s067ZQK+vm/lyoQT7qjAeIdOaJ?=
 =?us-ascii?Q?g5+V17pGSCaH2qZznY+yzBYsbLYw3mQ5JY809yaLzsqn4VefM7EivMhjSLfM?=
 =?us-ascii?Q?ll3ts+xkLbbeVk+5wi0Rmt8sPobP5tJVZf9y9jeQEkxcGGnut4jTWM3YeNhi?=
 =?us-ascii?Q?o6eH1fI3FBStGi6VlqfCl7Jw4D0LhykYFSewhtxqaYrOBJYJcVWcU0frIGS6?=
 =?us-ascii?Q?+xGnzz+L6zQPVRsZFr8VXiI6YSs+U3lqISrCjkrjRbOgGJ+jq6qoSkbFhjgF?=
 =?us-ascii?Q?WwsjlzeOWP5+8by0NVsUUM3TjexKD2vn2vLSE+dngmqvY5u520FFa1v0jz0M?=
 =?us-ascii?Q?/dINkmXy4UPgPKKtGrbrVtB2xDrzHzVTy8Yw0bOMO64EQO1YJH8Csg0PX8gi?=
 =?us-ascii?Q?yzmfjlPXn9FIz5sBdOiXoKGvLuMCA0bLQTGM92FKS2a24s/Btu2YSk8Wi2Lx?=
 =?us-ascii?Q?aYh0hVcUCO8jxFeFUjWcEzKqp3V1Xlhxt8ldRrS/q7+0kzC3J/C9VK4YYhx6?=
 =?us-ascii?Q?IzuyCyGirgWNRc2+bQDAfdgrzXaiobLsnR7hThTTc3iwNboOxZoDb7BLib+c?=
 =?us-ascii?Q?QDvzpdzhUwws6IBpMyfZunmdXaqNhcZk4fa42oR73NxQegrfuvOGM5wPQp0N?=
 =?us-ascii?Q?Bc4/2ZnMQ7msR3o0PkZhjc/d8iFm0/EpO2UkNPJFuZX70LXjLolFsRs4qBLM?=
 =?us-ascii?Q?FfhPaVbDSRnoR2Rh/yAldCgaHBdEcO5eWmffok3tQbGEirTtVqNz/8aTjWAK?=
 =?us-ascii?Q?RmGA5Lxg0R4Tn/BwfIUItInwrDffCnPNfa9cyXIrsX1VefihxbOo/i6MTWjQ?=
 =?us-ascii?Q?5L/usI6+Fjz1xzqvKBmfW+WOLaWhf4b4626emzlFFRctRajnl4Fnu7ssIYDc?=
 =?us-ascii?Q?J6QZhBbScOzYpDYFikYTJ6DsZe/PR8l6HY/3Tz53hLMc7KqgTqoYScwqG+1n?=
 =?us-ascii?Q?X4rI+GhwyGVhcE37EYW6RHeGxxdG16cjw4ul5plXWcLhWJzaSYxw+6Bf3xpj?=
 =?us-ascii?Q?A/Anu3tFir7Sl17V+7yt/iqELyHsr0PhDBGsp/eZBqnTeAmeU/qOo1/L/bYX?=
 =?us-ascii?Q?rP0oGB+iYg9n5dJaeVQL+rGkj7vrdH2ef6diychKpoqEhIEh6xg3rwHFa24m?=
 =?us-ascii?Q?Yu0eekH3+cpboseB8SQy147SS5N93d6XMc4CFIPMHC/isZQQUe3vB/DJ/Q5/?=
 =?us-ascii?Q?N/l277/4BVrGlCRJfoyJZydahyjoRQtHW+2344SUEy7D7l4/UbIpnjkcgn0l?=
 =?us-ascii?Q?r8COhshTmVj11Awxjkqcskm/L0tX85C4Dv7Q3SDnTySAxlfV3kPqytShbKKV?=
 =?us-ascii?Q?M+l8+QPM7ZIctwKIUQFQMDRZxjTqsx+O5IymLNBsWToRQ1YVQvKD4v8m+tCS?=
 =?us-ascii?Q?rm44CH9nLqobmt2Hm41v9YzE0Loz7kSaJrfj7cuHy3KvADH9M7WK9oYl11RS?=
 =?us-ascii?Q?ihyH4nxLEI/qHVmfoYyYVC8jCQepnBSciU3rdlaxTqZ9c4efBHHws3aXChCJ?=
 =?us-ascii?Q?5N7JC0VqhkDH5wTO/C4v0p6DHDG4s7SqAKGDyXQR?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9db6ac-e1cb-4995-6c8b-08db3aff915e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0801MB3767.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 02:42:42.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E285GV5JAEFmczgiHO9H/l5fnCwcaUv5umh1BsObdjiysYGMXwXpj8ONueXnYKkvzmOJslhhqd9cu8p5FVLp8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6397
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On Tue, Apr 11, 2023 at 09:27:08AM +0000, Charles Keepax wrote:
> On Mon, Apr 10, 2023 at 07:31:56PM -0500, Jeff LaBundy wrote:
> > On Mon, Apr 10, 2023 at 08:56:34AM +0000, Charles Keepax wrote:
> > > On Sat, Apr 08, 2023 at 10:44:39PM -0500, Jeff LaBundy wrote:
> > > I would far rather not have every single attempt to communicate
> > > with the device wrapped in a retry if the communication failed
> > > incase the device is hibernating. It seems much cleaner, and less
> > > likely to risk odd behaviour, to know we have brought the device
> > > out of hibernation.
> 
> > A common way to deal with this is that of [1], where the bus calls
> > are simply wrapped with all retry logic limited to two places (read
> > and write). These functions could also print the register address
> > in case of failure, solving the problem of having dozens of custom
> > error messages thorughout the driver.
> 
> I suspect this really comes down to a matter of taste, but my
> thoughts would be that the code is shorter that way, but not
> necessarily simpler. This feels far more error prone and likely
> to encounter issues where the device hibernates at a time someone
> hadn't properly thought through. I am far more comfortable with
> the device is blocked from hibernating whilst the driver is
> actively engaged with it and it keeps any special handling for
> exiting hibernate in one place.

Fair enough. I do concede that having this control in the driver as
opposed to DSP FW is more nimble and makes it easier to respond to
customer issues; I'm sure your battle scars will agree :)

> 
> > Does the current implementation at least allow the device to hibernate
> > while the system is otherwise active, as opposed to _only_ during
> > runtime suspend? If so, that's still a marked improvement from L25
> > era where customers rightfully pointed out that the downstream driver
> > was not making efficient use of hibernation. ;)
> 
> I am not entirely sure I follow this one, yes the device can only
> hibernate whilst it is runtime suspended. But I don't understand
> why that is a problem being runtime resumed implies this device
> is active, not the system is otherwise active. I am not sure if
> I am missing your point or there is some confusion here between
> runtime and system suspend. The device can only hibernate during
> runtime suspend, but the only thing that determines being runtime
> resumed is activity on this device so in general it shouldn't be
> hibernating at that point anyway.

D'oh! I meant to say suspend suspend; I'm aligned.

> 
> > I don't feel particularly strongly about it, so if the current
> > implementation will stay, perhaps consider a few comments in this
> > area to describe how the device's state is managed.
> > 
> 
> I certainly never object to adding some comments.
> 
> Thanks,
> Charles

Kind regards,
Jeff LaBundy
