Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A596F0AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbjD0RXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbjD0RX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:23:28 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0344F40D9;
        Thu, 27 Apr 2023 10:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxsSf7svA4LtiOT/90WOmhQdW0HeaGmDYih9MBJcgYLwpEJNS9WyVyvIM0KndbCpiP9OygszyN6bh0J/o3cTtVvOdEnx0mY0ZXjw97WITzhr8H1uXOirtLl5yLZA7MlAuUDFDNyYb3Q9h1xwH3YtU7OEjuITTtfzZ0SUd+nlxKuT/nJy+Y9/VTpgZg13vzZbbFT0tqcBgTEfWF7Yf86GxkAhoKxmRnpbd0o9XMSLpJVnb/xy2XUQ5jsUdwmkxqmLiYJWorOOwEZt9oQuORwTvD4XXE/l4aTlDRljABoXphNsSz1NJTaIrFju7JJhRAdXm6uutNpoVq06cs1D5u+oCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QbURr4C4YX0xyl80OzoiC+zaVeQKeX1vOBTzNVROmo=;
 b=YXb+kfkNSDY+r1lTEFXnNcRJwqgkOtjzGchsXSO/HBabTBJNdlpODTa6DpbmDUU17Zhq5aJkdCxuzxbQLchctTvvnyTthqV9gvIF/dm8dw/RfxW5M9vaC7p8HMgOpRco41dr2A3KaEIMbfaQwsoAzVPkcpOQwVzgRN2jcyxGpYdrD7E5dJ6fPcfq5QAFRJXaTropgU3DNje5lcUaCR1rpZhvdEHbYPZw4rLozVOPvZph4Qgw5dfCLpCnXp5umaR6cMw0Gas1oVCyGx1TuAgsznIvHti5GhGBePb+ptr+lltkk6X56c1DGzfFKbmT1ZIwfaQgTlTpNEkL2JZcwSgJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QbURr4C4YX0xyl80OzoiC+zaVeQKeX1vOBTzNVROmo=;
 b=GWNRxYtr4WN7g72bOzuI0VDZF+RGqMy/LnGwf4BDBU76J7lqBPWN0FPkJTtKpqlkvA6yA0xqQFfECisgozEJHsPkRs8Poy52oLOJFYq+9GdettGb4jnMas7GcGRakHFie4C/o9G9o94ZZpF9NxMNcaj6jeQwbnAa4ofTyIQg7bE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM6PR08MB6282.namprd08.prod.outlook.com
 (2603:10b6:5:1f0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 17:23:21 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 17:23:21 +0000
Date:   Thu, 27 Apr 2023 12:23:14 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [RFC v1 0/4] Input: support virtual objects on touchscreens
Message-ID: <ZEqvgnhzm7r4O7hz@nixie71>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
 <419c9d72-9791-46ff-8317-b4dfe2e2d0a3@t-8ch.de>
 <ZEf5rfzs22HtQivB@nixie71>
 <aa6125d9-1233-7aab-1811-29acd4ad49a5@wolfvision.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa6125d9-1233-7aab-1811-29acd4ad49a5@wolfvision.net>
X-ClientProxiedBy: DM6PR01CA0022.prod.exchangelabs.com (2603:10b6:5:296::27)
 To SN4PR0801MB3774.namprd08.prod.outlook.com (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DM6PR08MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a723f7-a033-4a20-9bea-08db47441941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VC/dGSTP6aBIcEL54WV8pIu9T3/+pnn8l3z8YAZr2/iTAX7NhZ+c61yyFFD57tqmQc46HviNhEYqk4xOTV3J9JdNSLDwKRZND5nsLkml1/hy7GsZVfip9KjgoXujEmYRElCXJVzn/ndjFdT5AS0rykCKlMDaMkf1IJ50x+L57hRDx7DCyL9b9dYBJY8tfwss84cKqHjOOL9c6ToChJJDdWP5vmwfA4iQEu2KzZEmnw0F48e+9puAyzr1fpH9qQjlQfjJ72qGSZofYWhf2Eu8XfAhjKzGydeHgq/7bp34boeBNxpAJnSUBrHGFZJVgu1ETdr8uxD2+VGikZIks4+ei7HiCEfRHj80WXQ4xs3GpL3jvP0sAs+3mqWr9rSXSdM7Uko7z77v8ZZDzHlzRS7sggvNej5uuQqSJ10I2oeyEcaISB7YF+R0jAeQTTRxGBESlcJDCk3nlObxd+2vMbfsP/sY/AcESEHMizKLufMXVwLbPiWSiAgXUcKrvPOb04jv0kLXPj32G9xtfyXT47S//5hjwovCdmFf1q8fjExoYJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(39830400003)(396003)(346002)(366004)(451199021)(8936002)(7416002)(8676002)(5660300002)(66476007)(6916009)(41300700001)(316002)(2906002)(4326008)(66556008)(66946007)(54906003)(6666004)(478600001)(6486002)(53546011)(186003)(26005)(966005)(66899021)(6512007)(9686003)(6506007)(83380400001)(66574015)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UX/yM/ozjJD2PY2v/Pta0wncDA5kkzJcWa9gXGpkTunTZ0GUWtImuL+RKY?=
 =?iso-8859-1?Q?BsS5/VXqhKlz36O1q73ZU1rd440A2C/EG1kCK5XQry1JbKS5jNZeDHacvI?=
 =?iso-8859-1?Q?pVNOPaT//xWUhlInhjENovLfddFEKyDzeHI8xIIyVy08NjPrOdEV3XSCIy?=
 =?iso-8859-1?Q?J/XugFGCEUu6g49EuVVliGSpcDq4K3WQjQ0kR/xt+hoOz4LvDlBhA68UY/?=
 =?iso-8859-1?Q?/vXUx9erG/ysc1rscMtOUhyUzrXbh4jarbEY+HTTqAxkE9P01yWM9CUVXv?=
 =?iso-8859-1?Q?WopDG6FLWTwfx4oHX2gOmLTTDxQhf7mxVBRsXMaT8w3IM2itx7gDtFBAzl?=
 =?iso-8859-1?Q?avPL+cxOx/+MyZqMLAEiWNo+dq0DkPMLVlrmnqdcHDRJdsGRaj2IqHl/IL?=
 =?iso-8859-1?Q?+k6KD+vPNo76zPWwBY2eYsGyAKPQluua7rXcctEwZMCT28Uo30AeP4TXVa?=
 =?iso-8859-1?Q?khhUXwbkR1Npu4GjoCl2GnKN+vQZuRoUA8TRCirwvYd/IdJPT6dm/U3OeQ?=
 =?iso-8859-1?Q?2OEap6LIuc+4t2dkd3VwkrHx6cpH2l+IFmxolMfe4B53n0OnloUszMi4GE?=
 =?iso-8859-1?Q?+UXwB4MYOQb4Xrw6+PYR+xrCd5sGA1miKp/yGNAtcdpVk6ps+/+vsYdBtv?=
 =?iso-8859-1?Q?VoLPLs24FKgLQCz+b4f1775HJb8t8ImZJ095pnbl7vxxk6HUfu/c/CqJQ6?=
 =?iso-8859-1?Q?Y6z/8RThmwxFuIzzdBp7W4SdLDYhYkgmDCML7G/VaoJaHDReQV1nuDIlye?=
 =?iso-8859-1?Q?ZgucFtSiDS6tua4oEVBBCIeLUPA3WsOQtLw331532Lsi69lt/nBc+KAmlM?=
 =?iso-8859-1?Q?GFZtYIuhfij3Ky7JjKehYFhuPs7MvxskfQnx51GcyOlpc0MnxGYPLc0ijM?=
 =?iso-8859-1?Q?5Qhgxg5n0OFbGnROvDuyD2pZBrmup7P/NylxySOI8pHVYcQ6R0lu5H90xU?=
 =?iso-8859-1?Q?+DjP1YVBZqx5u5y8JMW20fcUeD+BbyHj1uW2nSc9HyMNi6BimwDBv7YvUX?=
 =?iso-8859-1?Q?Sq9cDwwS06KhC4X/U4vrIYN0JshFX3lhWWqjspMcdo2kfp0HiGDdojYsQh?=
 =?iso-8859-1?Q?mMup6morX54iRcGo1HOJf+obDk/4qKQ+2X7YIYuwjtuLBmlyblcu9pQ8uo?=
 =?iso-8859-1?Q?LRKk0YINlkZfde9ckaVqiE+3pWLDVhZIlo7VcDsWjXGStAFplk+yq5TAbF?=
 =?iso-8859-1?Q?gkkUKqcJvR/DZjD5nEIGAx7YVcKkb0Ptwz9QbxodYjzoYC5U+yrJft8Rdk?=
 =?iso-8859-1?Q?lu6feS2UnI4YDxGqKZ8C6iVmrgBU/aVmxO6Uy/tZ44SiDTZW3M4oYiNS46?=
 =?iso-8859-1?Q?cVkq37Qb8qCA187Q7E9K4YS5w9rXvHUb2CfOOVLQ46N6e6ULGdP1mtyKj0?=
 =?iso-8859-1?Q?UhuXsZzYqzktmyHaN/6iqAueMziDLQXqiMz29ZlTRomPTLzW13Gir5KfpH?=
 =?iso-8859-1?Q?4paQQT1NiHti/RvXgXJWW86pkMrJGAuxMn63/ajRrrFrsg9FLSgTk4774w?=
 =?iso-8859-1?Q?6q0upa7neH/BgJI8vyK2zFYDQy13RLPi8nzqBtDkjTmXLVYMaeRgQ1mEp3?=
 =?iso-8859-1?Q?TJRXMaRzbyYNDYN07iG87T1G7vJMALv4ru5JCj9zIEP52Q4GmkOeG/1+UF?=
 =?iso-8859-1?Q?Al1/0/Bieo+ByTCtVxAjjMistFLxN7SpBD?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a723f7-a033-4a20-9bea-08db47441941
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 17:23:21.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YHoYjzP5f1N6OvYVEL99goDAE4BlDeySkCYNzyZw94ct4xLGkO45FZNYprsQfApTatkBjWmAHFwpJXQhWRgmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB6282
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Thu, Apr 27, 2023 at 05:59:42PM +0200, Javier Carrasco wrote:
> Hi,
> 
> On 25.04.23 18:02, Jeff LaBundy wrote:
> > Hi Thomas,
> > 
> > On Tue, Apr 25, 2023 at 05:29:39PM +0200, Thomas Weißschuh wrote:
> >> Hi Javier,
> >>
> >> On 2023-04-25 13:50:45+0200, Javier Carrasco wrote:
> >>> Some touchscreens are shipped with a physical layer on top of them where
> >>> a number of buttons and a resized touchscreen surface might be available.
> >>>
> >>> In order to generate proper key events by overlay buttons and adjust the
> >>> touch events to a clipped surface, these patches offer a documented,
> >>> device-tree-based solution by means of helper functions.
> >>> An implementation for a specific touchscreen driver is also included.
> >>>
> >>> The functions in ts-virtobj provide a simple workflow to acquire
> >>> physical objects from the device tree, map them into the device driver
> >>> structures as virtual objects and generate events according to
> >>> the object descriptions.
> >>>
> >>> This solution has been tested with a JT240MHQS-E3 display, which uses
> >>> the st1624 as a touchscreen and provides two overly buttons and a frame
> >>> that clips its effective surface.
> >>
> >> There are quite a few of notebooks from Asus that feature a printed
> >> numpad on their touchpad [0]. The mapping from the touch events to the
> >> numpad events needs to happen in software.
> > 
> > That example seems a kind of fringe use-case in my opinion; I think the
> > gap filled by this RFC is the case where a touchscreen has a printed
> > overlay with a key that represents a fixed function.
> 
>  Exactly, this RFC addresses exactly such printed overlays.
> > 
> > One problem I do see here is something like libinput or multitouch taking
> > hold of the input device, and swallowing the key presses because it sees
> > the device as a touchscreen and is not interested in these keys.
> 
> Unfortunately I do not know libinput or multitouch and I might be
> getting you wrong, but I guess the same would apply to any event
> consumer that takes touchscreens as touch event producers and nothing else.
> 
> Should they not check the supported events from the device instead of
> making such assumptions? This RFC adds key events defined in the device
> tree and they are therefore available and published as device
> capabilities. That is for example what evtest does to report the
> supported events and they are then notified accordingly. Is that not the
> right way to do it?

evtest is just that, a test tool. It's handy for ensuring the device emits
the appropriate input events in response to hardware inputs, but it is not
necessarily representative of how the input device may be used in practice.

I would encourage you to test this solution with a simple use-case such as
Raspbian, and the virtual keys mapped to easily recognizable functions like
volume up/down.

Here, you will find that libinput will grab the device and declare it to be
a touchscreen based on the input events it advertises. However, you will not
see volume up/down keys are handled.

If you break out the virtual keypad as a separate input device, however, you
will see libinput additionally recognize it as a keyboard and volume up/down
keys will be handled. It is for this reason that a handful of drivers with
this kind of mixed functionality (e.g. ad714x) already branch out multiple
input devices for each function.

As a matter of principle, I find it to be most flexible for logically separate
functions to be represented as logically separate input devices, even if those
input devices all stem from the same piece of hardware. Not only does it allow
you to attach different handlers to each device (i.e. file descriptor), but it
also allows user space to inhibit one device but not the other, etc.

Maybe the right approach, which your RFC already seems to support, is to simply
let the driver decide whether to pass the touchscreen input_dev or a different
input_dev. The driver would be responsible for allocating and registering the
keypad; your functions simply set the capabilities for, and report events from,
whichever input_dev is passed to them. This is something to consider for your
st1232 example.

> 
> Thanks a lot for your feedback!
> > 
> > Therefore, my first impression is that the virtual keypad may be better
> > served by registering its own input device.
> > 
> > Great work by the way, Javier!
> > 
> >>
> >> Do you think your solution is general enough to also support this
> >> usecase?
> >>
> >> The differences I see are
> >> * not device-tree based
> >> * touchpads instead of touchscreens
> >>
> >>> [..]
> >>
> >> [0] https://unix.stackexchange.com/q/494400
> > 
> > Kind regards,
> > Jeff LaBundy

Kind regards,
Jeff LaBundy
