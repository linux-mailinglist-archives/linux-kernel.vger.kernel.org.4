Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4476466B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLHCBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLHCBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:01:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2EB7E40B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 18:01:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD2C561D34
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A72C433C1;
        Thu,  8 Dec 2022 02:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670464900;
        bh=N38wXucF+hF5PyocURbX3I6VBx7GbBgyGw4H55pF/kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQVAbKnZciV0/8X+Scesz7mDBs3Am3DVWFJa8YNKi8FdiCLseuQizXAeiWuXDH4g9
         EBo/d1Fa2ZnIAVw4OJvLu8NJ5MajQ5cPLaNhLbE5cl8ppcpVJVeg7fkmjwD5v4M7as
         +6mMk3t8HeJW1niyvGSeui6Q5fjwXDJADVOeERgUcMT72Ac0TKAIetDSAGZEoGJgle
         kliBIhOleVnV1kKdxFrT/rwmngevG9lgvQmZbA9+K1qinol+6c8KKz3BSLyqxQZjYm
         jj7RLiBrTExT29ZekVHhIv8rM+VxtomKcsfotbSZ+PdO2r8bQJJWqP+nI/s8fuP0t+
         PjwgSHt57coDQ==
Date:   Thu, 8 Dec 2022 10:01:35 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Victor Ding <victording@chromium.org>,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        groeck@chromium.org, dustin@howett.net, gustavoars@kernel.org,
        gregkh@linuxfoundation.org, sebastian.reichel@collabora.com,
        dnojiri@chromium.org, lee.jones@linaro.org, bleung@chromium.org,
        tinghan.shen@mediatek.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: zero out stale
 pointers
Message-ID: <Y5FFf+VjViglELbZ@google.com>
References: <20221207093924.v2.1.I1864b6a7ee98824118b93677868d22d3750f439b@changeid>
 <Y5EZmSSbOFRpfBNj@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5EZmSSbOFRpfBNj@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 10:54:17PM +0000, Prashant Malani wrote:
> On Dec 07 09:39, Victor Ding wrote:
> > `cros_typec_get_switch_handles` allocates four pointers when obtaining
> > type-c switch handles. These pointers are all freed if failing to obtain
> > any of them; therefore, pointers in `port` become stale. The stale
> > pointers eventually cause use-after-free or double free in later code
> > paths. Zeroing out all pointer fields after freeing to eliminate these
> > stale pointers.
> > 
> > Fixes: f28adb41dab4 ("platform/chrome: cros_ec_typec: Register Type C switches")
> > Fixes: 1a8912caba02 ("platform/chrome: cros_ec_typec: Get retimer handle")
> > Signed-off-by: Victor Ding <victording@chromium.org>
> Acked-by: Prashant Malani <pmalani@chromium.org>
> 
> Hey Tzung-Bi, it looks like you've already created a tag for the
> v6.2 pull request, so I don't know if it's too late to apply this
> for the current dev cycle.
> So, I've not applied it, but have left the Acked-by tag.
> 
> Please feel free to apply it if there's still room for it before
> you send out the pull request.

Given that the patch fixes an use-after-free, let's include this in the
coming merge window.  Have queued.
