Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BCD737A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFUEYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFUEYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:24:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F4A1712;
        Tue, 20 Jun 2023 21:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF4E61464;
        Wed, 21 Jun 2023 04:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CD3C433C8;
        Wed, 21 Jun 2023 04:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687321473;
        bh=h0/sKdezqzeCxvzq4RwYWY6GxNwg/n/RaHYyNS21PyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIEwXwWk6vZ3mYDfutp1SnkWSY/yhSA/myLVOPXlPEPCJmVjQ2+eQiWr7+BS4ZDC2
         gUMwJD8IVMkTpMGUoW4gKKHN7onug/2stCWAxLEBPwb8AAU8uXlvzZR9+Jh8VgLB+v
         J/OYwQi9631NqknRonhq59ccTFkBo/KPXmhAkCvlY54Jo2pSo++TsEVoApFTGCJQ3q
         z5PNl2SZsksejsLCGfTnL3ttKgu2q7BGmCRWTZG/bltOzxlGb1GDc6BEoG9Pftnlq6
         2bc4ui1zcvBWhpFQSrAM8stux0RvSHgrPEWX3eoM/PXjROKRp+Si19PKrosSH6DbhY
         FxHVV7WLthrfg==
Date:   Tue, 20 Jun 2023 21:24:31 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] thermal: enhancements on thermal stats
Message-ID: <ZJJ7f9DzaIGrch9I@uf8f119305bce5e.ant.amazon.com>
References: <20230519032719.2581689-1-evalenti@kernel.org>
 <b2eea9c9-e74b-b28e-f6af-244801e726b8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2eea9c9-e74b-b28e-f6af-244801e726b8@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 09:05:07PM +0200, Daniel Lezcano wrote:
> 
> 
> 
> Hi Eduardo,
> 
> On 19/05/2023 05:27, Eduardo Valentin wrote:
> > Hello Rafael and Daniel
> > 
> > After a long hiatus, I am returning to more frequent contributions
> > to the thermal subsystems, as least until I drain some of the
> > commits I have in my trees.
> > 
> > This is a first series of several that will come as improvements
> > on the thermal subsystem that will enable using this subsystem
> > in the Baseboard Management Controller (BMC) space, as part
> > of the Nitro BMC project. To do so, there were a few improvements
> > and new features wrote.
> > 
> > In this series in particular, I present a set of enhancements
> > on how we are handling statistics. The cooling device stats
> > are awesome, but I added a few new entries there. I also
> > introduce stats per thermal zone here too.
> 
> From my POV, that kind of information belongs to debugfs. sysfs is not
> suitable for that.
> 
> The cdev stats are a total mess because of the page size limitation of
> sysfs and the explosion of the combination when there are a large number
> of states (eg. display is 1024 cooling device states resulting in a
> matrix of 1024 x 1024, so more than 4MB of memory).
> 
> For the record, I'm working on such of statistics [1][2], and optimized
> this cooling device statistics in order to get ride of the existing
> sysfs cdev stats.
> 
> Actually, all the stats rely on the mitigation episodes. However, for
> that we need to correctly identify when they begin and when they end. We
> can have mitigation episode inside mitigation episode (eg. passive
> mitigation@trip0 and active mitigation@trip1).
> 
> This is not working today because the trip point detection is incorrect,
> thus the mitigation episodes are also incorrect, consequently the stats
> are de facto incorrect.
> 
> There is more details at [3] but the change assumes the trip points are
> ordered in the ascending order which is wrong, that is why it was not
> merged.
> 
> The mitigation works but the detection is fuzzy, so the math is
> inaccurate and as we are in the boundaries of a temperature limit, the
> resulting statistics do not show us the interesting information to
> optimize the governors when they are not totally inconsistent.
> 
> All the work around the generic trip points is to fix that.
> 
> There is a proposal at LPC to add statistic/debug information for
> thermal, may be you can participate so we join our efforts?

I am not sure if I would be able to join but will look into this and get back to you soon. 

In fact, joining efforts will be awesome!

As for cdev statistics, I believe the transition table is an overkill. And for the cases I have been using,
with 20+ thermal zones with 10+ cdevs assgined to all of thermal zones, is way beyond the PAGE limit size.
Totally agree with that.

I agree this code deserves a cleanup. These patches build on top of what is currently in mainline.
I also would prefer to have this code potentially out of the -sysfs file and handled separately
from the actual sysfs node handling code.

As for the debugfs vs sysfs, the rule of thumb I use here is more if I need this into a production system
or not. The content of the cdev and thermal zone stats can in fact be interpreted in both ways:
(a) on a purely debug image for a developer to check governor behavior etc, which corroborates to your view,
but also (b) in an actual production system where statistics and residency are collected in the entire
population of devices running a particular governor/settings. In the later case, debugfs is not the best fit.


> 
>   -- Daniel
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/trip-crossed%2bdebugfs
> 
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/debugfs-v2
> 
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/trip-crossed%2bdebugfs&id=7d713a9128ad9a153de9c3f5b854c6f1acfb3064
> 

I will take a closer look on the above. Thanks for sharing.


> 
> 
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
All the best,
Eduardo Valentin
