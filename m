Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6085F9C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiJJKJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJJKJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:09:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D361166853;
        Mon, 10 Oct 2022 03:09:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390F31480;
        Mon, 10 Oct 2022 03:09:36 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E1883F792;
        Mon, 10 Oct 2022 03:09:28 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:09:11 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Message-ID: <Y0PvRz83+lklWeyb@e126311.manchester.arm.com>
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAAYoRsXgmwQXNzDPgVe=_cW=C8_7__GYHCyRKkfX=6dFY9dybw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYoRsXgmwQXNzDPgVe=_cW=C8_7__GYHCyRKkfX=6dFY9dybw@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 05:06:58PM -0700, Doug Smythies wrote:
> 
> I would suggest a completely new governor for your
> only 2 idle states, and of similar power use, scenario.
> Incredibly simple:
> 
> If CPU utilization >= threshold
>   select idle state 0
> Else
>   Select idle state 1
> Endif

That would be easy to implement at least but sadly just doesn't really
work at all. It would just result in huge amounts of too deep C1 sleeps
which are the main problem for us at the moment. For all intents and
purposes, only ever selecting C0 gives better results than this approach
on our hardware.

> As previously mentioned, you are overriding
> everything that teo does anyhow.

To an extent yes, this just came from observations of how cpuidle
behaves on arm. We tried an approach with only ever using C0 and it was
all right on power usage, the device would just heat up too much and
lose performance. That's why this approach of using TEO when the core is
completely idle and moving to the lower state when it's not achieves the
best of both worlds.

> Note to other readers: I also sent Kajetan an off-list email with more
> tests descriptions and web links to results graphs and such.

Looks like the email got lost in my inbox, could be some email filtering
or something like that.. Could you possibly resend and cc my private
email (kajetan.puchalski@tuta.io)?
So far I've not directly received any of your emails, they show up on
the mailing list archive but not in my inbox. Could be an IT issue on my
end but might be worth checking your email setup regardless.

> ... Doug

Thanks,
Kajetan
