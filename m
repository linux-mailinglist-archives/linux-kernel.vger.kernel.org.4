Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12373654FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiLWLhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiLWLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:37:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C58C83EAC6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:37:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DA601FB;
        Fri, 23 Dec 2022 03:38:11 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 377A73FA32;
        Fri, 23 Dec 2022 03:37:29 -0800 (PST)
Date:   Fri, 23 Dec 2022 11:37:27 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com
Subject: Re: [PATCH 0/9] Rework SCMI initialization and probing sequence
Message-ID: <Y6WS9/dmeGpS7wqV@e120937-lin>
References: <20221222185049.737625-1-cristian.marussi@arm.com>
 <CAFA6WYP++tYORr+-EDPF1EKakwJHaH+_WFq8kzWY-UU3yQJ7Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYP++tYORr+-EDPF1EKakwJHaH+_WFq8kzWY-UU3yQJ7Gg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:06:29AM +0530, Sumit Garg wrote:
> On Fri, 23 Dec 2022 at 00:22, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > Hi,
> >
> > under some configurations the SCMI core stack, which is now initialized
> > as a whole at the subsys_initcall level, can be dependent on some other
> > Kernel subsystems (like TEE) when some SCMI transport backend like optee
> > is used.
> 
> Thanks Cristian for the rework, but this doesn't seem to address
> reluctance to carry forward the DT legacy (see [1]).
> 
> TLDR, it has led to misrepresentation of OP-TEE transport as follows:
> 
>     First represented as a platform device via DT (compatible =
> "linaro,scmi-optee";) and then
>     Migrated to being a TEE bus device (UUID: 0xa8cfe406, 0xd4f5,
> 0x4a2e, 0x9f, 0x8d, 0xa2, 0x5d, 0xc7, 0x54, 0xc0, 0x99)
> 
> Do we really need to have a platform device for every SCMI transport?
> 
> [1] https://lore.kernel.org/lkml/CAFA6WYPwku8d7EiJ8rF5pVh568oy+jXMXLdxSr6r476e0SD2nw@mail.gmail.com/
> 

Hi Sumit,

thanks for the feedback first of all.

This series represents really a long standing point on my todo-list and it
is meant to start addressing/reviewing the whole SCMI stack init/probe
sequencing and transports setup while taking the chance/opportunity to
fix the issue reported by Ludvig.

The natural next step in my (and Sudeep) view would be to split out the SCMI
transports too into proper full fledged drivers, that can be probed by their
own susbsys eventually (when possible) and that will then register with the
SCMI core as available transports; so that we can avoid some of the cruft
when multiple backend subsystems are involved...

...it is just that I have NOT dug deep into this further evolution and I did
NOT want to do it in this series, but just starting laying out some basic rework
toward this direction while fixing Ludvig issue. (... also because there are a
lot of bit and pieces to get right in SCMI around protocols/modules and DT
parsing and I was trying not to break too many things at a time :P...)

Anyway, even in the perspective of the above possible evolution into full
fledged drivers, I doubt that we can get rid completely of the DT based
per-transport platform devices since their DT nodes can carry a bit of
transport related information (even for auto-discoverable transport I think)

...it will just be that such devices, bound to the compatibles, will be used
probably in a different way (also for backward compatibility with DT
bindings...)...indeed...such platform devices now DO carry some information
about the underlying transport to use BUT most of all they represent also
an SCMI platform instance, so that will not definitely go away completely,
it will just loose most of the transport related functionalities

..but... as said...I have not dived too much into this further evolution so
I maybe wrong here on the details... anyway the plan going further, as spoken
also with Sudeep offline, could/should be that depicted above.

Not sure if this answers all of your questions but I'll keep you posted
on this series and next evolutions...

Thanks,
Cristian
