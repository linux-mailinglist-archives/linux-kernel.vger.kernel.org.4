Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A79172474F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjFFPLP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jun 2023 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjFFPLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:11:13 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9D91B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:11:11 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 6CC35160658;
        Tue,  6 Jun 2023 15:11:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 487DA20029;
        Tue,  6 Jun 2023 15:11:04 +0000 (UTC)
Message-ID: <9717acd3dd00d607da718da251a0bba6b376da96.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing Fixes tags
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>, Tom Gall <tom.gall@linaro.org>
Date:   Tue, 06 Jun 2023 08:11:03 -0700
In-Reply-To: <ZH7uo6ph8nhidxcV@moroto>
References: <ZH7uo6ph8nhidxcV@moroto>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: e8yizfse93tg34wrnxuks1axdeyptqji
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 487DA20029
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+javYTQk+znKLFunfTX/GuQNyDwql5ppE=
X-HE-Tag: 1686064264-172003
X-HE-Meta: U2FsdGVkX1+eUvA1i0Fj9NdSdrQT4hO2mjQv92PtA4kgpE592e6rAUI3ME5m6kc/aR+LitmPRJmYeBdyse8MSNXulh2JgBTfY3OeW3bBqx5wxzTRqYbJe1QT0sM58LArvNmrF2Vm2++3q9Tw5hhUtlwGAb4Jchkgz/O/FLUmU3KycC7FahjjhIKIr7B+V1HaZok109BExatA9FZr1OdBXhBIr1262F5TXYb8tEcz5M0Tu6y+TP9OZi3sEekDA+5iSXwwZSV32nD49EWBuhPwwRuRTdEOWPDqZzN0GIsvAtFj++Kt1iOcHoFLWrZ3qNLG
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-06 at 11:30 +0300, Dan Carpenter wrote:
> This check looks for common words that probably indicate a patch
> is a fix.  For now the regex is:
> 
> 	(BUG: KASAN|Call Trace:|syzkaller|stable\@)

Seems sensible.  Style notes:


> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3186,6 +3192,12 @@ sub process {
>  			}
>  		}
>  
> +# These indicate a bug fix
> +		if (!$in_header_lines &&
> +			$line =~ /(BUG: KASAN|Call Trace:|syzkaller|stable\@)/) {
> +			$needs_fixes_tag++;

Align to open parenthesis please.
Maybe add "Closes:"
This should not check any actual patch lines.

So this should likely use

		if (!$in_header_lines && !$is_patch &&
		    $line =~ /\b(?:BUG: KASAN|Call Trace:|Closes:|syzkaller|stable\@)/) {

There's no use of $needs_fixes_tag as something
other than a bool, so please just use

			$needs_fixes_tag = 1;

> @@ -3198,6 +3210,7 @@ sub process {
>  			my $id_length = 1;
>  			my $id_case = 1;
>  			my $title_has_quotes = 0;
> +			$fixes_tag++;

			$fixes_tag = 1;

here too

> @@ -7636,6 +7649,12 @@ sub process {
>  		ERROR("NOT_UNIFIED_DIFF",
>  		      "Does not appear to be a unified-diff format patch\n");
>  	}
> +	if ($is_patch && $has_commit_log && $chk_fixes_tag) {
> +		if ($needs_fixes_tag && $fixes_tag == 0) {

		if ($needs_fixes_tag && !$fixes_tag) {

> +			ERROR("MISSING_FIXES_TAG",
> +			"This looks like a fix but there is no Fixes: tag\n");

Alignment to open parenthesis and likely WARN not ERROR

