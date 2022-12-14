Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3724164C465
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiLNHbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiLNHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:31:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E34213D01;
        Tue, 13 Dec 2022 23:31:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E39E9B81636;
        Wed, 14 Dec 2022 07:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF76C433EF;
        Wed, 14 Dec 2022 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671003098;
        bh=b30liFGgWuPmxvMtC0nZnmfl1IYBgEeD5WKn41SCZ/c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BbBTgoQprWo6PtFyOZkae90Vei6C0LOEIZrYJmLkwFmWYTgzRkcmQvPjfSNElfXUo
         f+B4Vs8kivgm/oed4SlKPM7PycH5yTE2+q0LJHJMsMofHdDDAeKavHoAsg7xugFvca
         ETsQFsqJN1+lQjOoWXOdZUNpYFLQREetG94rs7/9bzX3WL5WVY2R+id82h+L1+Ycdz
         Fvu5pAHCDcqTwCb8HS9dMn33R4fci3xy5CnglquaQkzycao6Re3rc49Lcmbspu3zuT
         7+w99qQCCO0fvwxepyWsMzvg0vGlgt6uRVad7B5XclpDU+qctKtYDKS9ShxgkwnbA1
         /yeQ6n2i112GQ==
Date:   Wed, 14 Dec 2022 16:31:35 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter
 on boot up
Message-Id: <20221214163135.54536cafdc6a2216fd9debfa@kernel.org>
In-Reply-To: <20221213190321.379c6c2c@gandalf.local.home>
References: <20221213172429.7774f4ba@gandalf.local.home>
        <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
        <20221213190321.379c6c2c@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 19:03:21 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 14 Dec 2022 08:49:54 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > Avoid calling the synchronization function when system_state is
> > > SYSTEM_BOOTING.  
> > 
> > Shouldn't this be done inside tracepoint_synchronize_unregister()?
> > Then, it will prevent similar warnings if we expand boot time feature.
> 
> I thought about that, but because this is a special case, I was thinking
> that we don't just gloss over it and have something call this when it
> shouldn't be in early boot up. I was surprised when it was called, and then
> had to debug it a bit to figure out why it was. When I discovered the path
> it took to get there, I realized it was legitimate.
> 
> Right now, I only see this one case as an exception. If more pop up that
> are correct, then we can switch it over. But right now, I still want
> calling tracepoint_synchronize_unregister() to warn if it is called in
> early boot up, because that could be a sign that something went wrong.

Thanks, I got it. :) So when we find more synchronization is involved,
we'll revisit it.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
