Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F51723F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjFFKS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjFFKSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:18:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C45DE42
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97ADB624C2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E32C433D2;
        Tue,  6 Jun 2023 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686046729;
        bh=mufbZ9v6TKPPwko+EdRPWegStPKH/y7dsA/paZR8h5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWoJr8Fk6Jdr9/AZnwQsMYGcPjMYPgLCBASmKFzsqDHGiQ6npdff3emBAEHtYlQyw
         cyn2Vtf6KwUafD9XKmCXqq+lKeigSUWeLRj3raIRLY38kGNWjV/x77w4xtpDgrtlMS
         X0vUw7bxgkgtcBrSncODGsH0dkyttdEhhNDctmbI=
Date:   Tue, 6 Jun 2023 12:18:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>, Tom Gall <tom.gall@linaro.org>
Subject: Re: [PATCH] checkpatch: check for missing Fixes tags
Message-ID: <2023060628-sizzle-valuables-b782@gregkh>
References: <ZH7uo6ph8nhidxcV@moroto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH7uo6ph8nhidxcV@moroto>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:30:27AM +0300, Dan Carpenter wrote:
> This check looks for common words that probably indicate a patch
> is a fix.  For now the regex is:
> 
> 	(BUG: KASAN|Call Trace:|syzkaller|stable\@)
> 
> Why are stable patches encouraged to have a fixes tag?  Some people mark
> their stable patches as "# 5.10" etc.  This is not as useful as a Fixes
> tag.  The Fixes tag helps in review.  It helps people to not cherry-pick
> buggy patches without also cherry-picking the fix.
> 
> Also if a bug affects the 5.7 kernel some people will round it up to
> 5.10+ because 5.7 is not supported on kernel.org.  It's possible the Bad
> Binder bug was caused by this sort of gap where companies outside of
> kernel.org are supporting different kernels from kernel.org?
> 
> Should it be counted as a Fix when a patch just silences harmless
> WARN_ON() stack trace.  Yes.  Definitely.
> 
> Is silencing compiler warnings a fix?  It seems unfair to the original
> authors, but we use -Werror now, and warnings break the build so let's
> just add Fixes tags for those.  I tell people that silencing static
> checker warnings is not a fix but the rules on this vary by subsystem.
> 
> Is fixing a minor LTP issue (Linux Test Project) a fix?  Probably?  It's
> hard to know what to do if the LTP test has technically always been
> broken.
> 
> One clear false positive from this check is when a patch updated the
> debug output and the commit message included before and after Call
> Traces.  Sometimes you should just ignore checkpatch.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Nice!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
