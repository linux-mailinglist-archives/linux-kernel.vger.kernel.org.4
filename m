Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2391707779
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjERBiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERBiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4B51FDA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D93A864BD6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38ECC433D2;
        Thu, 18 May 2023 01:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684373896;
        bh=9kZC/W7wSSz+CjE+Xd0ZlPs5dPn4WsmW2A5Yc06pJck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuOCg0ieUajiob7Go2hP6KmxMVuoFJamr6eGZXrym/U6QRoNmPxNwFQL0GbnmzPaM
         GvBM70mb7RITsgF4xvRFe91n10RK3+U21+ugBBzlUZbHiXULwTRdiQ2rI+ERULvqeZ
         2HaBX6UPN2inAIGEvijLYf/cyiiMNo3+u0yQCnBIsQ9xIDcj/7LKCUDmdu0B2AWYBs
         Anjg3I+mf+FULgr94zyLq7gwMbTe0S4cYkra03Nfj71jpC3RP15wMp1S3NXzC2J7Y4
         Ej1i2NXhZV6o2yvkMQdTx8KsGIdWbGphqgnv2z/ZD64Z5iNIs2CFTjK/2qglSNWpwQ
         ZK8Gf6EGYMKJQ==
Date:   Thu, 18 May 2023 09:38:12 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Tim Van Patten <timvp@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, robbarnes@google.com,
        lalithkraj@google.com, rrangel@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH] [v9] platform/chrome: cros_ec_lpc: Move host command to
 prepare/complete
Message-ID: <ZGWBhEMmo2lStTg9@google.com>
References: <20230515142552.1.I17cae37888be3a8683911991602f18e482e7a621@changeid>
 <ZGQ9Y+vqWhQLHAQh@google.com>
 <CAMaBtwHxaevxLY7zWNDU8zbyWx=puLkeeRAjFtovvrA5pjtJ4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMaBtwHxaevxLY7zWNDU8zbyWx=puLkeeRAjFtovvrA5pjtJ4w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 09:56:59AM -0600, Tim Van Patten wrote:
> > I can understand the patch wants to notify EC earlier/later when the system
> suspend/resume.  But what is the issue addressed?  What happens if the
> measurement of suspend/resume duration is not that accurate?
> 
> Please see the following:
> - b/206860487
> - https://docs.google.com/document/d/1AgaZmG70bAKhZb-ZMbZT-TyY49zPoKuDDbD61dDBSTQ/edit?disco=AAAAws1enlw&usp_dm=false

I have no permission to access the doc.  Please put the context in the commit
message.  It's usually helpful if you could put the corresponding EC FW
changes.

> The issue is that we need the EC aware of the AP being in the process
> of suspend/resume from start to finish, so we can accurately
> determine:
> - How long the process took to better gauge we're meeting ChromeOS requirements.
> - When the AP failed to complete the process, so we can collect data
> and perform error recovery.

Is it a new feature?  How could the *error* recovery do?

> > It seems prepare() is a more general callback.  It could be followed by
> suspend(), freeze(), or poweroff()[1].  Do we expect the change?  For example,
> the system is going to power off but EC gets notification about the system
> should be going to suspend.  Same as complete().
> 
> Please reference the implementation of SET_LATE_SYSTEM_SLEEP_PM_OPS
> and see that we were already calling it in the poweroff path:
> 
> #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> .suspend_late = suspend_fn, \
> .resume_early = resume_fn, \
> .freeze_late = suspend_fn, \
> .thaw_early = resume_fn, \
> .poweroff_late = suspend_fn, \  <<---- here
> .restore_early = resume_fn,
> 
> * @poweroff_late: Continue operations started by @poweroff(). Analogous to
> * @suspend_late(), but it need not save the device's settings in memory.
> 
> So, there is unlikely to be any functional difference with this change
> in terms of poweroff.

I see.  There is still slightly change in disabling/enabling IRQ[2].  But I
think it would be fine as long as they are symmetric.

[2]: https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/platform/chrome/cros_ec.c#L351

> > What about other interfaces (i2c, spi, uart)?  Do they also need to change
> the callbacks?
> 
> We aren't concerned about those devices, because they aren't being
> used on the devices we're seeing issues with. If devices using those
> ECs want this change, they can pick it up as well, but we don't have
> any way to test changes on those devices (whatever they may be).

This doesn't sound good.  As I would suppose you are adding some new EC FW
features regarding to EC_CMD_HOST_SLEEP_EVENT, you should consider the
existing systems too.

What happens if a system uses older kernel (without this patch) to
communicate with new EC FW via LPC?

How about adding a new EC host command for your purpose so that it won't
affect the existing systems?  I knew this was discussed in some older series
but I didn't follow the thread.

> On Tue, May 16, 2023 at 8:35 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Mon, May 15, 2023 at 02:25:52PM -0600, Tim Van Patten wrote:
> > > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> > > .prepare() and cros_ec_lpc_complete() during .complete(). This moves the
> > > host command that the AP sends and allows the EC to log entry/exit of
> > > AP's suspend/resume more accurately.
> >
> > I can understand the patch wants to notify EC earlier/later when the system
[...]

Please don't top-posting next time.
