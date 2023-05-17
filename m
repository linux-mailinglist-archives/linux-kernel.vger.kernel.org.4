Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE989705D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjEQCfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEQCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4366D49CE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA871640E8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9DBC4339B;
        Wed, 17 May 2023 02:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684290919;
        bh=zmqv6MjM7oNtFc9qzavUTqOwali/HD/2c4swdlVL9iM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPG0UaCSc3yYi7kqWgyXuY+XfrjqyLQZq8hVNijuB7BAeftnsErlXkuPVE+2K2rbL
         6ZCx9VqiNcVIFjv+i9kduPtEvFVsp0u6vJcC3+LuhqBpbD1B7u7AmzpdN1Zs7yW5OB
         hbSVIYOR/PeqY7BOrKfD+TVxiHGJ11A1ChFk3/1AA66peMylkwhVuVMvn5v8SJmRAc
         I4MvYbyusg6yNbahSqtb6bV6zLvmtXUJ4q3m/l1L+yLnUJ2OjXULi4oW7/f9fAZQEA
         bdLFU9ojbHyJU8vgBUNUTaSt3JDDZVIdqKzzRJqn1wzbfZQUg03LJOjNUqPi19z3X1
         3UWx2RgVih19A==
Date:   Wed, 17 May 2023 10:35:15 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Tim Van Patten <timvp@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, robbarnes@google.com,
        lalithkraj@google.com, rrangel@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH] [v9] platform/chrome: cros_ec_lpc: Move host command to
 prepare/complete
Message-ID: <ZGQ9Y+vqWhQLHAQh@google.com>
References: <20230515142552.1.I17cae37888be3a8683911991602f18e482e7a621@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515142552.1.I17cae37888be3a8683911991602f18e482e7a621@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 02:25:52PM -0600, Tim Van Patten wrote:
> Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> .prepare() and cros_ec_lpc_complete() during .complete(). This moves the
> host command that the AP sends and allows the EC to log entry/exit of
> AP's suspend/resume more accurately.

I can understand the patch wants to notify EC earlier/later when the system
suspend/resume.  But what is the issue addressed?  What happens if the
measurement of suspend/resume duration is not that accurate?

Copied from my previous mail:
* Should it move the callbacks?
  * Is it appropriate to call cros_ec_suspend() when PM is still in prepare
    phase and call cros_ec_resume() when PM is already in complete phase?

It seems prepare() is a more general callback.  It could be followed by
suspend(), freeze(), or poweroff()[1].  Do we expect the change?  For example,
the system is going to power off but EC gets notification about the system
should be going to suspend.  Same as complete().

Moreover, cros_ec_suspend() and cros_ec_resume() do more than just notify EC.
E.g. [2].

What about other interfaces (i2c, spi, uart)?  Do they also need to change
the callbacks?

[1]: https://elixir.bootlin.com/linux/v6.4-rc1/source/include/linux/pm.h#L74
[2]: https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/platform/chrome/cros_ec.c#L351

> Changes in v9:
> - Remove log statements.
> - Ignore return value from cros_ec_resume().

The change logs are not part of commit message.  They should put after "---".
