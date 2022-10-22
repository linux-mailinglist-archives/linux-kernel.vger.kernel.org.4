Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E556084C3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJVFsf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 22 Oct 2022 01:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJVFsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:48:30 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306FA2B3218
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 22:48:28 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id AA2CF1C60A7;
        Sat, 22 Oct 2022 05:48:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id DFC2A20029;
        Sat, 22 Oct 2022 05:48:09 +0000 (UTC)
Message-ID: <b086dff1295732ad412b4de2f363e75a42bb6069.camel@perches.com>
Subject: Re: [PATCH] checkpatch: handle utf8 while computing length of
 commit msg lines
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Oct 2022 22:48:20 -0700
In-Reply-To: <20221021191507.9026-1-antonio.borneo@foss.st.com>
References: <20221021191507.9026-1-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: DFC2A20029
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: c7g8xs5eprnqr3fpe5c9cixhcuw5hg4x
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX193QcIKrXNbTNcN/8NsqjepZUV7md3dQqo=
X-HE-Tag: 1666417689-726588
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-21 at 21:15 +0200, Antonio Borneo wrote:
> The current check for the length of each line in the commit msg
> uses length($line) that counts line's bytes.
> If the line contains utf8 characters, the byte count can exceed
> the cap even on quite short lines.
> 
> Count the utf8 characters for checking line length.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> 
> ---
> 
> Actually it's not fully clear to me if utf8 characters in the
> commit msg are acceptable/tolerated or to be avoided.

Nor is it to me, likely it's OK though as at least checkpatch has an
existing test/comment for nominally valid UTF-8 in commit messages.

			CHK("INVALID_UTF8",
			    "Invalid UTF-8, patch and commit message should be encoded in UTF-8\n" . $hereptr);

> In the commit msg of 15662b3e8644 ("checkpatch: add a --strict
> check for utf-8 in commit logs") is stated:
> 	Some find using utf-8 in commit logs inappropriate.

I don't particularly care one way or another.

Andrew?  Linus?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1e5e66ae5a52..eaad5da50554 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3220,7 +3220,7 @@ sub process {
>  
>  # Check for line lengths > 75 in commit log, warn once
>  		if ($in_commit_log && !$commit_log_long_line &&
> -		    length($line) > 75 &&
> +		    length(decode("utf8", $line)) > 75 &&
>  		    !($line =~ /^\s*[a-zA-Z0-9_\/\.]+\s+\|\s+\d+/ ||
>  					# file delta changes
>  		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
> 
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780

