Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11FE5FA254
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJJRCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJJRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:02:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508C72CDFA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA94260F7B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAD8C433C1;
        Mon, 10 Oct 2022 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665421322;
        bh=olIi+YMItqG/0/E5CfQ3WkfdBfThnHS42hOtO0yZ/Ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xCZZuKEzkzhFcWMDP1QPOjn2O7iCMq/qYcH9cXbgExs1IlxyHle0RMBOIk6FAfa+M
         lMM95GYfmiG9sv6VxWJPm1ntJ4hGlfGLCbyngIiehPQuLWXClRpRwbLGmX0DlmFwGp
         0EvWwrwrhp+BFwUww2+1qNkLStX4ntlZ5yWnb8Ww=
Date:   Mon, 10 Oct 2022 19:02:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mushahid Hussain <mushi.shar@gmail.com>
Cc:     samuel.thibault@ens-lyon.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speakup: fix a segfault caused by switching consoles
Message-ID: <Y0RQNt80BnQjozZC@kroah.com>
References: <20221010165720.397042-1-mushi.shar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010165720.397042-1-mushi.shar@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 09:57:20PM +0500, Mushahid Hussain wrote:
> This patch fixes a segfault by adding a null check on synth in
> speakup_con_update(). The segfault can be reproduced as follows:
> 
> 	- Login into a text console
> 
> 	- Load speakup and speakup_soft modules
> 
> 	- Remove speakup_soft
> 
> 	- Switch to a graphics console
> 
> This is caused by lack of a null check on `synth` in
> speakup_con_update().
> 
> Here's the sequence that causes the segfault:
> 
> 	- When we remove the speakup_soft, synth_release() sets the synth
> 	  to null.
> 
> 	- After that, when we change the virtual console to graphics
> 	  console, vt_notifier_call() is fired, which then calls
> 	  speakup_con_update().
> 
> 	- Inside speakup_con_update() there's no null check on synth,
> 	  so it calls synth_printf().
> 
> 	- Inside synth_printf(), synth_buffer_add() and synth_start(),
> 	  both access synth, when it is null and causing a segfault.
> 
> Therefore adding a null check on synth solves the issue.
> 
> Signed-off-by: Mushahid Hussain <mushi.shar@gmail.com>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  drivers/accessibility/speakup/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What commit id does this fix?  Should it go to stable kernels?

thanks,

greg k-h
