Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE9074EF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGKMmW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGKMmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:42:20 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 05:42:19 PDT
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4331B0;
        Tue, 11 Jul 2023 05:42:19 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 089D61A0244;
        Tue, 11 Jul 2023 12:31:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 078BD2000E;
        Tue, 11 Jul 2023 12:31:14 +0000 (UTC)
Message-ID: <07bfc0b4676d07274acdcdf38752f73573938382.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: check for missing Fixes tags
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        Tom Gall <tom.gall@linaro.org>, kernel-janitors@vger.kernel.org
Date:   Tue, 11 Jul 2023 05:31:14 -0700
In-Reply-To: <756970eb-6204-415a-a997-d67a14ba6584@moroto.mountain>
References: <756970eb-6204-415a-a997-d67a14ba6584@moroto.mountain>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 078BD2000E
X-Stat-Signature: bntx7nnfjs8pgkaxre5rphbiyjb1h1rx
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19x2gh+vWixMU+NLw21/2xbr+6SUctP47I=
X-HE-Tag: 1689078674-258117
X-HE-Meta: U2FsdGVkX19WJVhw/iKSXETy0xJZnvCDQiiGHuoBIfwUnZePzCs0/u1bKh+ihRC5iT82hWN6003xPJD/GV85un13yIrw8x0IJAEu0kVmlrqqztUPVGG7SNvieWp/7DzKrgukrQXPKhBeFCaPPk6gA+r6wnwR+wfyTJpI5LwaGdJmOuLu/Vr2RZQC281UzdEyZR1JUTkf93hvyMEWehnAiZrfMQ55zmK50YwbvfyP2igwlXPchYSQjV/fsFg3v8PV6GeZJ4s+Ll/s6oCv77sEtHf3wHlBlHs4LoBMObbJn/aTZs33NUGxEnd5YIl0hxRoOOdD7/sxmgdH7r68JFH/XUdnffQlpM0wN4wG7C9zxLck8PJ61ozqkY086aq0vQxphc7fRZFZWZ2iG4DHQIYvOAIYQ/t00tpvMr5iBw85BelsGVPxSlG+cbrQEPHoYK3s
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-11 at 10:44 +0300, Dan Carpenter wrote:
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
> ---
> v3: Add UBSAN to the regex as Kees suggested.
> 
> v2: I fixed the formatting issues Joe pointed out.

But just added another.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3186,6 +3193,16 @@ sub process {
>  			}
>  		}
>  
> +# These indicate a bug fix
> +		if (!$in_header_lines && !$is_patch &&
> +			$line =~ /^This reverts commit/) {
> +			$is_revert = 1;
> +		}
> +
> +		if (!$in_header_lines && !$is_patch &&
> +			$line =~ /(?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller)/) {

align to open parenthesis please

