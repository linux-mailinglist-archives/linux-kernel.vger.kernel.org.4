Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6E7493B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjGFC0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjGFC0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:26:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2F1737;
        Wed,  5 Jul 2023 19:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEokJS0ylEodX4EKknQlpI2rtB0IhinT0ch7/Hz2tjnBDOtf8zqEJbzGNDeu0ViwPjYWzQV9aZ1R9qhAxGE6pBzgxK8DqYhdamJ1bKLLpskWEXID0eHbzSqmpmt4HJkYnZhB3EvnBAP0NUxKRHiqt85W9myy5rJWe8xHkHAwpUrLdgTIMfFO4byhZB1TABj0fKL1ok5oTefxkXtNc4s6FbPlOdGP/Iyc9GxwtMEKmvS29ianBAxEwan0Ti6+fjur0jiAV1jgH5kE5UkBq41Kcx+Kg6P+q4iIkmDRHbjSnFvNbOMx2ug2bcCoALuTv/ZcYnGrRPzTxZmPnheW0qYYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgAaXibphYSYnw06UDKAiMGto61IUjpK/sKEaAF1+zE=;
 b=oIrVt/MBDyOYPtnonkrxh/QSbkM8sJPB8prRCh7A/brmC6MdgZjmvQXZsrO1jZT+cmxwPQsKLL5skWe98TcJRhu8FK5pdW6iGh9ZJ+8suzXeJqVVaqLThh8OGLw4WnP9XvumpY0bsha6LxCZ97yZBWGGwjO7etaDNN8kpbUWrBU9f7Cit2lUv16raz+K9yqCoxRIs6bzfKmcIXJ77SVmOJbBzwxCIPpr/B0gGHOl4LVec4I3uiQyuuyHiQl+4DZRkswdufwj5SM865e5Sq+e20jfbCKu1SGT50cFHjIzTzY5OgPSEnS6D04m3BgzU1vk+XW85CUdp15OO+jX8wf6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgAaXibphYSYnw06UDKAiMGto61IUjpK/sKEaAF1+zE=;
 b=IYhi07O855x9liIZJaexNWdAy4ugao/pgW/MkBXyYoXTAwnxyjn43e/FAh1Au20QjnUgnhtZs956UGLT1AaeXwQzffJEoardmQ0BdOTH/F70kfycMW3RLWJ6Pk/tzl0zlemPeTd3vgCGxVxblOInyvVQFKGDVHVwn+tfXQdZajo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH7PR08MB8255.namprd08.prod.outlook.com
 (2603:10b6:510:156::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 02:26:39 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 02:26:38 +0000
Date:   Wed, 5 Jul 2023 21:26:30 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] Input: ts-overlay - Add touchscreen overlay
 object handling
Message-ID: <ZKYmVpHq1GftUSxf@nixie71>
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v3-1-b4fb7fc4bab7@wolfvision.net>
 <ZJj5VcHvfMMWMRx8@nixie71>
 <ed1f627b-1713-b273-c083-c98d88f885d2@wolfvision.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1f627b-1713-b273-c083-c98d88f885d2@wolfvision.net>
X-ClientProxiedBy: DM6PR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:5:330::35) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH7PR08MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdcfd81-9081-4f96-e8a1-08db7dc86cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3s0ZDZqryMaKbDzoPyFusnHf83jXNM+NhnmDnFQffhhEqUT938Dnq+l+z7b8hyMxTzpNS3YAIiLaZSjpH3A5Zma/2W0piSkcvRkA99c0CfzAIesSb1NQidZNeNxQEJ6l7xhGYXbWcev8wmTuOT+pQWedPpN7EeJTbG1wD0pWGR+x8xp3QHRfckcRmJ1c8GET3QtBz8ptjZVkM7TLg/4NrDDPyXMJ+lyXDPG+eK3JK7YdZtuj6/M/PdM2YLy6/uVcQ8wr3Dw3EYAlJJqEHZ5fcBi7ewYVM8IaCbQICQH7MbwjqXqi7RphK/B+Nj7mc8s/W2Y4aoicDjbWwT8xjrL7Q6ezCXQWDIkPxSEvNd6dRWWcXeMyERt+nq9iLHE89r67sFG8Wid0clsbYsFD5JEKHX0+1n/NLiLYnNHeuS7DsYKXtREbgq9Y4Anqiqz+i7BWDwFOVDbItCgNEJ7wKmik2YDy6fH445Qu2LMmG5EzPJUgxIHSeSG6KqfeZeaHqb0cIJhZtjDC15HX4+7jTsgmNMPoD3hlfokrmIqHOOmmri3OrdkPkT1e3jSpWvGrJKI5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(366004)(136003)(39830400003)(396003)(451199021)(4326008)(66556008)(54906003)(478600001)(6486002)(6666004)(41300700001)(8936002)(8676002)(38100700002)(66946007)(316002)(6916009)(66476007)(83380400001)(186003)(9686003)(6512007)(26005)(53546011)(6506007)(86362001)(7416002)(5660300002)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RCRT9xyTuH/cQzQBVOzCJ6DGGT+FitwcxTUr8X8kTuYwsfb6nkIB/9AA2dr1?=
 =?us-ascii?Q?6JPKBi2lMgWRh9PrR/zC3alO4jbtiOIErTqPecTigFFlR/jOUQe1q9f/gtYq?=
 =?us-ascii?Q?DAg44bxJl33fniPSUkjLNCcJ3p6FdkPDKH28P+bHeZjTHC4QmEI81Emr2Op4?=
 =?us-ascii?Q?n1GxNK+ItGehv7SH9Ic8edYLbj3+ycWcE71zRloCpNM6bfGeNN8WT6ltFjAO?=
 =?us-ascii?Q?YWIEROg0ZZBOppxGqYtMbOHJdbdHaNDjLSh5Jtl/Q8LXJC6i5ipv60mP6Qrs?=
 =?us-ascii?Q?vXEdlXpKmLPUEg7c0ilcY2tTNcXAqm99WoJoeIrhFZhUxTJsC+mO0fa5swzB?=
 =?us-ascii?Q?xx8NoDzmYLuJwQvBloWLJLEeA6Q73A4hbp48vmUxX6VP3/IKVYdEViP7j81a?=
 =?us-ascii?Q?hlj6hocBViJRb5aeRoHhCqNw3jUcHXq35v86bn2mnz42kL17CDMLkN0QOzIJ?=
 =?us-ascii?Q?de2y48IvrFknbL0I/IHw8SBZ9d8Z+rHPeLj67aBrZ6qxcdZ2ViVEdQ5MQLzG?=
 =?us-ascii?Q?zv1F2uOY7cYfAnn4xfZRIRfeJ3p8WD0EIf9m9IHd7Ml9fC1BOSg3+AU2wVy6?=
 =?us-ascii?Q?ft6BNiL4dSQQT2tYsitF/OgQv6XWOJvfPXdlt4HiWjiODMEKzzAarRNKULOa?=
 =?us-ascii?Q?Nc/oLBCt9v1uf99QcvfFhNn1GObOFSTW1V+uNfOWuBacr1YrBFH0ZPKiJc5q?=
 =?us-ascii?Q?I//8t/p3ayqAywwZpQmxpzI49ASwa6I6FW7+Bfbw43xiDja0Dc3c7MgpBLjV?=
 =?us-ascii?Q?JeXmsM/7ZZ10BOARLAHgIRytyGWvjbOaYhOpiS5lTTNQZ3q5O3YvYXpTkmu2?=
 =?us-ascii?Q?pctzXgvbB6PQBmoDUNVD9U3fkCCd3LfJd4vpUP9Dq3skmETjnbqVPbPowVqf?=
 =?us-ascii?Q?PCJK7AffQl6TpgpArKIgYben2+aSo09JEKKzj8CzWcp7mxPNJMWgmhoFz5aw?=
 =?us-ascii?Q?dcs2sj+v7TYqwS8CR5tN0yb/GqIqxTtjnt0aUZmz7cMEmoccv/Lne+cu6jtZ?=
 =?us-ascii?Q?+YiJxOl4xYW3lmBJnEk4pejT+9l0VbdpAYNCHZaG2FvhCSJRF9N0ZPSMnDXI?=
 =?us-ascii?Q?FO8e12PlmCl2MGZJA+GY7e/i60LzHRC2LikTgpDsV7jwi36xQoo6Cb5Arey5?=
 =?us-ascii?Q?F8R5vd6CyYVy+ZBT/4jKwtLrSjCl3FHWH8ARGKDExcZFbskHYEopjwvHlB2r?=
 =?us-ascii?Q?ApG4Dwa8BenFwulR1wpP/NtYsTZh0v9g0CFuEN6wA2Qfurf7pQ7RCIQu5V5Q?=
 =?us-ascii?Q?1uQtlK89C5BOZlJWpir3hQPzWQAcprhe0QC5vpIzZH5v2rRMwscXGvqaSnc7?=
 =?us-ascii?Q?1pyurf/gGPUFEEThBaMSH91aI3WwXHEromGwPOd1GErfYvUy1B8zKksbe+rJ?=
 =?us-ascii?Q?b1KkOP745ddhRJMwNI062dRWY4FL8hsX7H4Yo0zCdaZVHutEN14XKCGHTHcw?=
 =?us-ascii?Q?Jr8kvq4Gd1BDS7tm3tb25hK8NRden7x290QvZVmAWL7XXugxcEFFwb2wdkID?=
 =?us-ascii?Q?vFMJym5VrIFph4tAHlfTT2sMj1V5jyupjBI5xYL3/c1pWB7S2Sw+0uV6RKeu?=
 =?us-ascii?Q?frHqJ0k/DzWXKjEkp2VdNx8cyEkJ2Ct5eCyO8ztD?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdcfd81-9081-4f96-e8a1-08db7dc86cf9
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 02:26:38.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mcEZNhYJhfpqU5bZl52a4yIyKZaL0dtm2BebiWJY+w2fYJBX3brpu/dv7VVCZGa7trMFbLI3CEvW5uer+7+KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR08MB8255
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Sat, Jul 01, 2023 at 10:58:54PM +0200, Javier Carrasco wrote:
> Hi Jeff,
> 
> On 26.06.23 04:35, Jeff LaBundy wrote:
> >> +
> >> +		dev_info(dev, "Added button at (%u, %u), size %ux%u, code=%u\n",
> >> +			 btn[j].shape.x_origin, btn[j].shape.y_origin,
> >> +			 btn[j].shape.x_size, btn[j].shape.y_size, btn[j].key);
> > 
> > This seems like a dev_dbg() to me.
> > 
> >> +		j++;
> >> +	}
> >> +
> >> +	return 0;
> >> +
> >> +button_prop_cleanup:
> >> +	fwnode_handle_put(child_btn);
> >> +	return rc;
> >> +}
> >> +
> >> +void ts_overlay_set_button_caps(struct ts_overlay_map *map,
> >> +				struct input_dev *dev)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < map->button_count; i++)
> >> +		input_set_capability(dev, EV_KEY, map->buttons[i].key);
> >> +}
> >> +EXPORT_SYMBOL(ts_overlay_set_button_caps);
> > 
> > I don't see a need to expose this function and require participating drivers
> > to call it; we should just have one over-arching function for processing the
> > overlay(s), akin to touchscreen_parse_properties but for the button input
> > device in case the driver separates the button and touchscreen input devices.
> > 
> > That one function would then be responsible for parsing the overlay(s) and
> > calling input_set_capability() on each button.
> > 
> I just realized that I did not reply anything about this, even though
> there is a reason why I exposed this function and now that I am working
> on the v4, some clarification might be required.
> 
> After it was decided that this feature should work with two different
> devices (a touchscreen and a keypad), I registered a keypad in the
> st1232.c probe function if overlay buttons were defined. I did not
> register the device inside the new functions because I thought that I
> would be hiding too much magic from the driver.
> 
> Instead I provided a function to check if a keypad was defined and
> another one to set the capabilities (the one we are discussing). The
> driver could just set any parameters it wants before registering the
> device and use this function within that process. The parsing is not
> missing, it is carried out before and the programmer does not need to
> know the key capabilities to call this function.

I looked back at patch [3/4] with these points in mind, but I still feel
there is too much burden placed on the consuming driver. I imagine that
almost every driver would call ts_overlay_set_button_caps() if
ts_overlay_mapped_buttons() returned true; this would result in a lot of
repeated code that your module should simply do on the driver's behalf.

I think modeling after the touchscreen helpers is a good start and would
be most natural for future customers. Where we have this:

void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
				  struct touchscreen_properties *prop)

Perhaps we need something like this:

int touch_overlay_parse_properties(struct input_dev *input,
				   struct list_head overlay_head)

The latter would do the following:

1. Walk the parent node of *input to find each overlay/button ("segment")
2. Allocate sizeof(struct touch_segment)'s worth of memory and add it to
   the linked list
3. Parse the dimensions and keycode (if present)
4. Call input_set_capability() on *input with the given keycode
5. Return to step (2) for all remaining button(s)

There are two problems with this:

1. *input needs to be allocated ahead-of-time, but you don't know whether
   or not you actually needed it until after the function returns.
2. After the function returns, you need to know whether or not the input
   device is empty (i.e. no childen defined); otherwise there is no point
   in registering the second device.

Part (2) seems pretty easy to solve; the consuming driver could simply call
list_empty() on overlay_head and then decide whether to proceed to populate
the rest of the *input struct and register the device.

Perhaps one way to solve part (1) would be to simply expect the consuming
driver to allocate *input ahead-of-time, as is the case for the touchscreen
helpers. If the same call to list_empty() above returns false, the driver
can call devm_free() on it instead of registering it.

Please note that this complexity only exists for the case where the driver
elects to separate the touchscreen and button devices. Both problems go
away for the simple case where the driver clubs all functions into a single
input device.

> 
> So the process is as follows:
> 1.- Map overlay objects if they are defined.
> 2.- If there is a keypad, set the device properties you want it to have
> (name, etc). The event keys were already parsed and can be set with
> touch_overlay_set_button_caps()
> 3.- Register the device whenever and under the circumstances you like.
> 
> That is the current implementation, not necessarily the best one or the
> one the community would prefer.
> If that is preferred, the mapping function could for example register
> the keypad and return a pointer to the keyboard, inferring the device
> properties from the "main" device that will be registered anyways (e.g.
> using its name + "-keypad") or passing them as parameters, which might
> look a bit artificial. In that case the key capabilities would be
> automatically set and this function would not be exposed any more.
> 
> The question is if we would be missing flexibility when setting the
> device properties prior its registration and if the participating
> drivers want this to be done under the hood. My solution is the one I
> found less intrusive for the driver (at the cost of doing the
> registration itself), but if there are good reasons for a different
> implementation, I will be alright with it. If not, the driver will
> control the keypad registration and will use this function to set the
> key caps.

I think we should stick with the existing model where the consuming driver
is responsible for allocating and registering the input device as you have
done; this is the correct and common pattern. touch_overlay_parse_properties()
or its equivalent should not be managing memory or manipulating properties
of *input beyond those it is immediately concerned with (i.e. key reporting
capabilities).

What I do recommend to change, however, is to absorb what is currently called
ts_overlay_set_button_caps() into the existing parsing code. The consuming
driver will always call it if buttons are defined, and the parsing code knows
whether any are defined.

> 
> Sorry for the late reply to this particular point and especially for the
> long text. But a clarification here might save us from another
> discussion later on :)
> 
> Best regards,
> Javier Carrasco

Kind regards,
Jeff LaBundy
