Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04D86D81DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbjDEP3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbjDEP3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:29:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CF13C3E;
        Wed,  5 Apr 2023 08:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 967136278C;
        Wed,  5 Apr 2023 15:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B17C433EF;
        Wed,  5 Apr 2023 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680708554;
        bh=yqnI4bfV+iMcBOW/rXJz9gFWpPoAAXioww5cW7GdyGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBwOpwsIznolYBOaJKQGDS8F7spcBNnpZuZgQIqJPk2CgpJylX5ERxDRkL4uEC0Me
         j0XvUPH3BrZAtRj5x7dHIDh5+YjLUEqfTkfFBO3dXnURIay54Q3EPZQnXnG/Qoa539
         wjUBqjwrHq8aRxKr9Vgmr0e/jaQJSXMBQICJJ6m8KwgjAqMuy900EZ4KdvkriyyKP/
         REPXidnrcIUt698TkoVm9sOb5jwh7PKoSRrLkTAbJwAjhvRYnQNtXY2+HC7V8mg0lP
         +bVmorJBmV6qyYkek3atRoH+fc4TfAKL6I7c4yaexvwZtJHz5nCkKh7OflJrdlO4cx
         BIJMevI3i+VXQ==
Date:   Wed, 5 Apr 2023 16:29:08 +0100
From:   Lee Jones <lee@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        NeilBrown <neilb@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] leds: tca6507: fix error handling of using
 fwnode_property_read_string
Message-ID: <20230405152908.GQ8371@google.com>
References: <cbae7617db83113de726fcc423a805ebaa1bfca6.1680433978.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbae7617db83113de726fcc423a805ebaa1bfca6.1680433978.git.hns@goldelico.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Apr 2023, H. Nikolaus Schaller wrote:

> Commit 96f524105b9c ("leds: tca6507: use fwnode API instead of OF")
>
> changed to fwnode API but did not take into account that a missing property
> "linux,default-trigger" now seems to return an error and as a side effect
> sets value to -1. This seems to be different from of_get_property() which
> always returned NULL in any case of error.
>
> Neglecting this side-effect leads to
>
> [   11.201965] Unable to handle kernel paging request at virtual address ffffffff when read
>
> in the strcmp() of led_trigger_set_default() if there is no led-trigger
> defined in the DTS.
>
> I don't know if this was recently introduced somewhere in the fwnode lib
> or if the effect was missed in initial testing. Anyways it seems to be a
> bug to ignore the error return value of an optional value here in the
> driver.
>
> Fixes: 96f524105b9c ("leds: tca6507: use fwnode API instead of OF")
> Cc: Marek Behún <kabel@kernel.org>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/leds/leds-tca6507.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
