Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77F06C0B45
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCTHVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCTHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:21:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FAEB15563
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:21:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0B4EFEC;
        Mon, 20 Mar 2023 00:21:48 -0700 (PDT)
Received: from bogus (unknown [10.57.52.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C9473F71E;
        Mon, 20 Mar 2023 00:21:03 -0700 (PDT)
Date:   Mon, 20 Mar 2023 07:20:29 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        conor.dooley@microchip.com, ionela.voinescu@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, Pierre.Gondois@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arch_topology: Clear LLC sibling when cacheinfo
 teardown
Message-ID: <20230320072029.j6wsdpmmq7gmlvhg@bogus>
References: <20230314075345.1325187-1-suagrfillet@gmail.com>
 <20230316092910.doolw3xiuwwakile@bogus>
 <CAAYs2=gaTkA2f65SXkexxAUkSPxgaPNQGdkSKS4pYmJ3hO7z-Q@mail.gmail.com>
 <20230316145045.if3iw5qdtfjyroea@bogus>
 <CAAYs2=gtgcKthFyb=Vz6VJZamyfedoXJRXfsrAtLzj0-d=D89w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYs2=gtgcKthFyb=Vz6VJZamyfedoXJRXfsrAtLzj0-d=D89w@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 06:20:34AM +0000, Song Shuai wrote:
>
> My original point is to clear the llc_sibling right after clearing of
> share_cpu_map like what you did in 3fcbf1c77d08.
>

Yes I understood that. There were other issues that were fixed later
and hence the state of current code.

> And the ~~issue~~ I described above was found when I manually tested
> the 'base/cacheinfo:online' hpstate,  which can be triggered by the
> following commands:
>
> ```
> hpid=$(sed -n '/cacheinfo/s/:.*//p' /sys/devices/system/cpu/hotplug/states)
> echo $((hpid-1)) > /sys/devices/system/cpu/cpu2/hotplug/target
>
> ```
>

Thanks for the detailed steps. I had guessed something very similar.

> Anyway, the short inconsistency window you explained seems acceptable to me.
>

Yes just inconsistency but technically the CPU topology is still correct
including LLC information. I don't see a point in clearing the cacheinfo
at this point and just couple of hotplug state later reset all the topology
as the CPU is being removed. I feel it to be redundant and we can add if
we absolutely need it(i.e. if there are new users of that information and
need it to be aligned to cacheinfo which I think is highly unlikely).

-- 
Regards,
Sudeep
