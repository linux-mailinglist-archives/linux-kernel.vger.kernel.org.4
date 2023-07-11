Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D85874F228
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjGKOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjGKOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:24:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B4DBC;
        Tue, 11 Jul 2023 07:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDAE761426;
        Tue, 11 Jul 2023 14:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0FEC433C8;
        Tue, 11 Jul 2023 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689085408;
        bh=y0D8bkf1or402NLl3uVF2AePZpVnhF+paDS0zFSxMIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwQyjOn/X9YN5dTU+kbB6ABx98v8Rjj48CHgtatJH113b7zuj1wvMKEBDKjFNrySM
         Pab87/nXRfGv1JQpuZthb4j3ReqwlayaWWpRGw0pusvpEy7FSJl5fhMUTpydIeJwCg
         LaJ3HUkPJ58G5UIcvLfo9lBgN+JUGpRB3xlMEEUw=
Date:   Tue, 11 Jul 2023 16:23:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        Tom Gall <tom.gall@linaro.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4] checkpatch: check for missing Fixes tags
Message-ID: <2023071117-partition-escargot-9667@gregkh>
References: <f3ac6084-8def-4b57-9e6e-0497555e2784@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ac6084-8def-4b57-9e6e-0497555e2784@moroto.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 04:48:14PM +0300, Dan Carpenter wrote:
> This check looks for common words that probably indicate a patch
> is a fix.  For now the regex is:
> 
> 	(?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller)/)
> 
> Why are stable patches encouraged to have a fixes tag?  Some people mark
> their stable patches as "# 5.10" etc.  This is useful but a Fixes tag is
> still a good idea.  For example, the Fixes tag helps in review.  It
> helps people to not cherry-pick buggy patches without also
> cherry-picking the fix.
> 
> Also if a bug affects the 5.7 kernel some people will round it up to
> 5.10+ because 5.7 is not supported on kernel.org.  It's possible the Bad
> Binder bug was caused by this sort of gap where companies outside of
> kernel.org are supporting different kernels from kernel.org.
> 
> Should it be counted as a Fix when a patch just silences harmless
> WARN_ON() stack trace.  Yes.  Definitely.
> 
> Is silencing compiler warnings a fix?  It seems unfair to the original
> authors, but we use -Werror now, and warnings break the build so let's
> just add Fixes tags.  I tell people that silencing static checker
> warnings is not a fix but the rules on this vary by subsystem.
> 
> Is fixing a minor LTP issue (Linux Test Project) a fix?  Probably?  It's
> hard to know what to do if the LTP test has technically always been
> broken.
> 
> One clear false positive from this check is when someone updated their
> debug output and included before and after Call Traces.  Or when crashes
> are introduced deliberately for testing.  In those cases, you should
> just ignore checkpatch.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
