Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC772845F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbjFHP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237672AbjFHP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36761FCC;
        Thu,  8 Jun 2023 08:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0397463188;
        Thu,  8 Jun 2023 15:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79C0C4339B;
        Thu,  8 Jun 2023 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239834;
        bh=mecH44HKv66DOIzb6Cw7QlFUnI1jG2hQESu+9Iq7z0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmTwoGlBOFxuW3U7WjM9jDKF6jaDGwvSfgLS2gMLB3TrsKkjoaV87riWf4s+I830C
         JWWtavKcosH0j49IiUnqYe2xCOD+BrZfbE+59OHmhjjbb45bQ/Cs7bA6dorYHCz5Ni
         +5Er/qVJ1EHaTF/lyMf8H5QUPkcKmtv6jK3KsEFhclr2iQoCbkI0J6zvGKNKKJvW/6
         mWzIybnytBozw1Uoyw3Odt7lpXQC6Z7uxcXiAYrstIHLKh4kImHetejrUPJwnGB+te
         X0zO59VDgkgS4pRR1udZjkFnhgjRNDZg6OPc4qJ0JzKTejrstpoGwt+ArT9QDITK3v
         g1b0zfZj5imdA==
Date:   Thu, 8 Jun 2023 16:57:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com, nm@ti.com,
        afd@ti.com, msp@baylibre.com
Subject: Re: [RESEND PATCH v3] mfd: tps65219: Add support for soft shutdown
 via sys-off API
Message-ID: <20230608155709.GA3572061@google.com>
References: <20230608071947.3467751-1-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230608071947.3467751-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2023, Jerome Neanne wrote:

> Use new API for power-off mode support:
> Link: https://lwn.net/Articles/894511/
> Link: https://lore.kernel.org/all/7hfseqa7l0.fsf@baylibre.com/
> 
> sys-off API allows support of shutdown handler and restart handler.
> 
> Shutdown was not supported before that enhancement.
> This is required for platform that are not using PSCI.
> 
> Test:
> - restart:
>   # reboot
>   Default is cold reset:
>   # cat /sys/kernel/reboot/mode
>   Switch boot mode to warm reset:
>   # echo warm > /sys/kernel/reboot/mode
> - power-off:
>   # halt
> 
> Tested on AM62-LP-SK board.
> 
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> Suggested-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
> 
> Notes:
>     Change-log v3 to v2
>     v2: Link: https://lore.kernel.org/lkml/20230511122100.2225417-1-jneanne@baylibre.com/
>     Lee Jones Review:
>     nits: rm not needed line wraps and restore a cr deleted not related with the patch.
>     
>     Change-log v2 to v1
>     v1: Link: https://lore.kernel.org/all/20230203140150.13071-1-jneanne@baylibre.com/
>     Andrew Davis Review:
>     - Use new helpers devm_register_restart_handler and devm_register_power_off_handler
>     Vignesh Raghavendra:
>     - Fix typo on board name in commit message
> 
>  drivers/mfd/tps65219.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
