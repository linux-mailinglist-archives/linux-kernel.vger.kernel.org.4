Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB726F93A4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjEFSfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 14:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 14:35:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CE386BB;
        Sat,  6 May 2023 11:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFgLyLG5NlF9fBK6sGq/0pugtJMiTwMLq7+88kUPaDKc6nU1pGtdp8ycH5gqX8j/sOni45TZ2TE/UDaxWvWFhmZMZn8MuFYnXuDfBuCUDQQVne/RjQm6JKFNSXqk4KUzptRfHikTWpVLCRNBsghKQdbs0heam4Mmc7ksBQ41se7gLCHVqGeq2/e8S18c0D9mlELUDHWHFYeA6lbsYYtubUqeJhg9xnfhEoqSv1Y4krhe/ADPgm26jVpJuv6arp/WwFtGPgZOiisnOMn/629h3HmnWoMquhbjn8M6R5aiqzr60gnwq2T15JiPaCDZHpsPEzs5kkU/oJXAU5vd86pvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t1b5v6u0X6jYnL0yMQF9tHJkYgE9fCsLMUWnk5Qc68=;
 b=LLh52qmnjheyj5jvWrFaUujjETPXqSNU+c6F3XxLoQHKSVUEjWqGM/0Avvgshj9HxvbAw6j+1nQ5RgntpqHE1V/+av/I6up25id3ZNY7Xs0Vhb7L0F8YK5fZ4CXekt5wFgoCt+9GchraTCR1xKLFlq0jZVvNmJglnR7GWTR+GqcDmEb8gF8ytb4umWbX0X8btx/uVD/8AhjegEgXnuJrCeZtck4ee+sdXvg3xVWyXjXnig9Ev9ekBOBMU3fKT3biXa+swf9QtJzHr+eTMCsGe3sS0LF3HnU2CWtvWLNoyXZDNmps4kYld/DXSAy04T7dRDog5nMRZj2sbi7uCISCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t1b5v6u0X6jYnL0yMQF9tHJkYgE9fCsLMUWnk5Qc68=;
 b=0GIm+flP2LAvtF1SoVZQp4nCjfUH5oon2uQZ+NZPX6TPc08kVHkICkLOR1mWnNIwAuXVZ5bZT7/kbWK9eXHY0PwFKwvXWaYNIK0Eaq+KDtBKnDGcL2cXmgkBbZsGGn6PWefc0YjEvDyFibK8GgW+bqwrHtM3QANawqHK0PkoJE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA2PR08MB6602.namprd08.prod.outlook.com
 (2603:10b6:806:119::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 18:35:26 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 18:35:26 +0000
Date:   Sat, 6 May 2023 13:35:19 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
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
Message-ID: <ZFad5ywOpGm+zQLS@nixie71>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
 <419c9d72-9791-46ff-8317-b4dfe2e2d0a3@t-8ch.de>
 <ZEf5rfzs22HtQivB@nixie71>
 <aa6125d9-1233-7aab-1811-29acd4ad49a5@wolfvision.net>
 <ZEqvgnhzm7r4O7hz@nixie71>
 <20230504042927.GA1129520@quokka>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504042927.GA1129520@quokka>
X-ClientProxiedBy: SA9PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:806:a7::28) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA2PR08MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: df1abd49-f1a7-4394-ddba-08db4e60a898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w012eFeENdTZ8fD1lzVYV2rnk19V/dfD5PrdjpFauJLQHFbTAHZ/yOmoUCSmBmQWKMNfyEa+ztqkIz5ubF72bTjQepLlMoQTb33qkG0KuA228ZO95MNq6IaMC60wQdytZK65TKigdHF74RPdT4s+nvKuHDxU4opSamfJwRlNg4Fqc0j57ZeudkWEOhhQ4VTXzFFbN+ysjwi+T48HbO3sCUDr7rAandfrtPYgKnN3gyZqoAjYh6KFY4SpMYjWNkW+cmfpHp2vcqhDDhDq7UfhuJ2me8f3Oux47nMePH/6El7Uo7a39ToOhAaX+0/2YscEkAIPJykJI0DQZTKOjfsK1DtCNBB3qRDVGWayiIIgQXBcwNJ1+ZG0zbJi9366S1LjIGZ685uwxT/B+F0J7kGTSLTg08LmVsVZGiQsbhibNWZbb7win3YEn+5AL5aPXYb1W7dXZcKAIcXZv5/dxvGmM0ypu6TR6FiROMZt+L8d7N7oYhE+qcfzjZfA5Rw3HTF5HCLEX/3xe0aBwgiwbxQxi1HxAKbej4QaTqGeThfe/sWz0KKHT7w50ilAXKixX6It+BM7rU++9Banr/IP5CNYpEflK973imMPHG+XZLSxVW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(136003)(366004)(346002)(376002)(396003)(451199021)(7416002)(86362001)(8676002)(8936002)(33716001)(6916009)(6486002)(66556008)(66946007)(66476007)(4326008)(5660300002)(38100700002)(478600001)(83380400001)(26005)(66574015)(41300700001)(2906002)(186003)(316002)(6512007)(6506007)(9686003)(54906003)(53546011)(66899021)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gF2Ji+72JF8SDwehnVGXU3ZN0GIJsm6ARBJOGNHf3il/tM0LukEpWnfW+g?=
 =?iso-8859-1?Q?hbEqqPH2c0KWCTYEvrBCb0TsETSiEN7R1q2/SFDOx2OQN8uX9/agrA8RPI?=
 =?iso-8859-1?Q?HGxTd8mJsoewFyhASt5Bf6f54H8dmlIrIVCcMvl1qXEFzNOrJ1/T6DRkBj?=
 =?iso-8859-1?Q?K+8o3sHFA262Wb/DIsEve7qNGv0Ix7c6T3nYxaJSUj4V4W5lP7WWc7Okkx?=
 =?iso-8859-1?Q?pzNIqCL7lQXlOTJO6j3JPGLvVGdvWMbXMOIyHC9AfBuPtLF63TnMxjzd1N?=
 =?iso-8859-1?Q?w6EJoXzY7MlK8kRBzA/HhrBwGuW4kM6e6ipfTmupQb61eb/FTzC765ZTL/?=
 =?iso-8859-1?Q?mMnQFEhf3rpEZhbJrKGtsnNAlCZNUfw1AA0jQjRk86q3pSPeKV6VvTCCs3?=
 =?iso-8859-1?Q?3sE9T70fp3ptANuY3LETYTKM+/eDNqR0CuLAClS1FjJ/Q8wTO2KLdLXNG3?=
 =?iso-8859-1?Q?SPMWm0GZRjODbJWSKDTHzKMtPO+L/Yz0nSCRkUWmHa1s5GPNHd+bnLVTjD?=
 =?iso-8859-1?Q?u5mBlIu8Zr01sdPBfFRWaIm4hIVi3cDf3HjH13ihOLMTKeTxwmzCJl2gUP?=
 =?iso-8859-1?Q?XFV/AbA/jOJJVVV0rju3mx8VuZf2dTXuq+xjOYTgLpbG/n8DWjxKtufwcU?=
 =?iso-8859-1?Q?mq3c58TZZKTjNq203bpmPiFEt49XfPLsuh0YEWDHAnRO/ZWwSf2/iUF41U?=
 =?iso-8859-1?Q?DSkdhZoPE+RJ3DkVdqPQEh9IUnQ0T8X3ZkTLR1Q+TJ0ASv+0su7Xidu1UX?=
 =?iso-8859-1?Q?pNsl69DPjSWqyk1VfT6nl0/A0nc4qkm49qGDOaUFIFaVcR7XypQ4jLsxdD?=
 =?iso-8859-1?Q?CP4EDlig8GPFgleIe39xc6646F1JJTkSzjAAXMAyZnMnbaDpLLIaDMnL/4?=
 =?iso-8859-1?Q?18IkEeV7yupFa2ec5bJRoj7Zd9l7Fe9tjmFzYYxEsllH50nlDFO1V0+u84?=
 =?iso-8859-1?Q?VwBnLlXIzlbiwBKBk5YP5YkGPph/DYnNNquSDICgyklIdazEb6qu0oeu3w?=
 =?iso-8859-1?Q?2JLoOo8KxBR3Bx6nN9ejGFSF1TR0lzoLH2WQTQNfQbxqp1M/LRCguKHvwN?=
 =?iso-8859-1?Q?jwZOulQMQ7iNX2OqMTYZtAMCIOD+4BOCxjnmbUXkJIORJtD+pSLXA+gutK?=
 =?iso-8859-1?Q?+mEm7o1eSjUw6Bv71tx15vu4cLYr/taYM41Dw2oCUQP22HpISnRLvtdhkY?=
 =?iso-8859-1?Q?csiTSHpWitfLfa4rhkoYFP4icUobEXOItl7S1wK3Zl+W7DdwlPRMvPOWLS?=
 =?iso-8859-1?Q?pVSBmhKWbKGNwuEewvvlBe4oLhh/OULjfUELyNPK4yh11PFemtPsT8jd4I?=
 =?iso-8859-1?Q?X9FjbAko5Euobs2/QNdy6lZOEWJzLH5ZASdh6C0EHoS17qO9lDiMc9vOIG?=
 =?iso-8859-1?Q?Jjk+4/CSGqBsI21C3qSAt/XCkp3uV3tc68r5+MDLNr1+8VaMBpAHK1itNn?=
 =?iso-8859-1?Q?q8DGbmDvFc0DkoBp8d+MKbWfeaY1MruwrdFsgierQERqH++wedkKw9o5Jf?=
 =?iso-8859-1?Q?IwM6r4FSgA0oBrTUhLjhqHtS80mGr3LtGDuTZN0uqOmHpeyk72AVjM1Wy0?=
 =?iso-8859-1?Q?V4OeovsujVdha5saSRmBDxe8xazxTs0FmRuJUEHxxaKWAoPdeZ0rfQnEne?=
 =?iso-8859-1?Q?jB+wO7vFoCYuPHL5MuQrZLxdzmkZS9k6k4?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1abd49-f1a7-4394-ddba-08db4e60a898
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 18:35:25.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sz3b1H0OZDalA1zV0GwIwG/1usQUo7JLWP2phWjubKL+Qnh3oN2l65NzDVHNV8NtvQpwHP9HDRZli07rwRGL0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6602
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Javier,

On Thu, May 04, 2023 at 02:29:27PM +1000, Peter Hutterer wrote:
> On Thu, Apr 27, 2023 at 12:23:14PM -0500, Jeff LaBundy wrote:
> > Hi Javier,
> > 
> > On Thu, Apr 27, 2023 at 05:59:42PM +0200, Javier Carrasco wrote:
> > > Hi,
> > > 
> > > On 25.04.23 18:02, Jeff LaBundy wrote:
> > > > Hi Thomas,
> > > > 
> > > > On Tue, Apr 25, 2023 at 05:29:39PM +0200, Thomas Weißschuh wrote:
> > > >> Hi Javier,
> > > >>
> > > >> On 2023-04-25 13:50:45+0200, Javier Carrasco wrote:
> > > >>> Some touchscreens are shipped with a physical layer on top of them where
> > > >>> a number of buttons and a resized touchscreen surface might be available.
> > > >>>
> > > >>> In order to generate proper key events by overlay buttons and adjust the
> > > >>> touch events to a clipped surface, these patches offer a documented,
> > > >>> device-tree-based solution by means of helper functions.
> > > >>> An implementation for a specific touchscreen driver is also included.
> > > >>>
> > > >>> The functions in ts-virtobj provide a simple workflow to acquire
> > > >>> physical objects from the device tree, map them into the device driver
> > > >>> structures as virtual objects and generate events according to
> > > >>> the object descriptions.
> > > >>>
> > > >>> This solution has been tested with a JT240MHQS-E3 display, which uses
> > > >>> the st1624 as a touchscreen and provides two overly buttons and a frame
> > > >>> that clips its effective surface.
> > > >>
> > > >> There are quite a few of notebooks from Asus that feature a printed
> > > >> numpad on their touchpad [0]. The mapping from the touch events to the
> > > >> numpad events needs to happen in software.
> > > > 
> > > > That example seems a kind of fringe use-case in my opinion; I think the
> > > > gap filled by this RFC is the case where a touchscreen has a printed
> > > > overlay with a key that represents a fixed function.
> > > 
> > >  Exactly, this RFC addresses exactly such printed overlays.
> > > > 
> > > > One problem I do see here is something like libinput or multitouch taking
> > > > hold of the input device, and swallowing the key presses because it sees
> > > > the device as a touchscreen and is not interested in these keys.
> > > 
> > > Unfortunately I do not know libinput or multitouch and I might be
> > > getting you wrong, but I guess the same would apply to any event
> > > consumer that takes touchscreens as touch event producers and nothing else.
> > > 
> > > Should they not check the supported events from the device instead of
> > > making such assumptions? This RFC adds key events defined in the device
> > > tree and they are therefore available and published as device
> > > capabilities. That is for example what evtest does to report the
> > > supported events and they are then notified accordingly. Is that not the
> > > right way to do it?
> > 
> > evtest is just that, a test tool. It's handy for ensuring the device emits
> > the appropriate input events in response to hardware inputs, but it is not
> > necessarily representative of how the input device may be used in practice.
> 
> ftr, I strongly recommend "libinput record" over evtest since it can be
> replayed. And for libinput testing "libinput debug-events" to see what
> comes out of libinput.
> 
> > I would encourage you to test this solution with a simple use-case such as
> > Raspbian, and the virtual keys mapped to easily recognizable functions like
> > volume up/down.
> > 
> > Here, you will find that libinput will grab the device and declare it to be
> > a touchscreen based on the input events it advertises. However, you will not
> > see volume up/down keys are handled.
> 
> that would be a bug in libinput. libinput doesn't classify devices. It
> uses *internal* backends but the backend for keyboard and touchscreen
> devices is the same. So as long as your device advertises the various
> EV_KEY and EV_ABS bit correctly, things should just work. If that's not
> the case for a device please file a bug.

Please accept my apology for spreading misinformation; the sighting occurred
some time ago and I appear to have mixed up some observations.

I recreated my original issue just now and the problem is actually with LIRC,
which in this case is presenting the hybrid input device to VLC media player
as a remote control.

Prior to launching VLC media player, both touchscreen movement and key events
are handled just fine. Once VLC media player launches and LIRC begins handling
the key events, however, all touchscreen functionality is lost.

Upon closer inspection, it seems that LIRC creates another input device called
"lircd bypass" which relays the "left over" (i.e. touchscreen) events. However,
it seems LIRC does not copy the axis limits, so libinput rightfully rejects
the new device since min ABS_X = max ABS_X = 0.

Therefore, please ignore my sighting with regard to this RFC; it is neither a
bug in libinput nor a valid argument in shaping this RFC. This instead seems
like a possible bug in LIRC, so I will report it there.

> 
> It's still "better" to split it up into different event nodes because
> a lot of userspace may not be able to handle touchscreen+keyboard
> devices but at least at the libinput level this shouldn't be a problem.

I still agree; if nothing else, for the ability to inhibit different functions
at a more granular level. Therefore it seems best that patch [1/4] not mandate
the two input devices to be the same, which it doesn't appear to do anyway.

That being said, Javier, feel free to disregard my suggestion that the input
devices in patch [3/4] remain separate. Sorry for the churn; this was still
very helpful for me at least :)

> 
> And the xf86-input-libinput driver splits up such devices at the X
> level, so even where a device is touchscreen + keyboard you would end up
> with two X devices with separate capabilities so they fit into the X
> "everything is either a pointer or a keyboard" worldview.
> 
> Cheers,
>   Peter
> 

Kind regards,
Jeff LaBundy
