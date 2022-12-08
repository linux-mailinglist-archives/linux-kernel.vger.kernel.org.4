Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D816476E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLHT7I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Dec 2022 14:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLHT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:59:04 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEBF5F6CD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:59:03 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 9CB71C04B8;
        Thu,  8 Dec 2022 19:59:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 3024E8000D;
        Thu,  8 Dec 2022 19:58:59 +0000 (UTC)
Message-ID: <a7de235e15dbba2df9eb7ef82750ea8b6eae2b7b.camel@perches.com>
Subject: Re: [PATCH 1/2] checkpatch: warn when unknown tags are used for
 links
From:   Joe Perches <joe@perches.com>
To:     Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 08 Dec 2022 11:58:58 -0800
In-Reply-To: <869badb999d4021dd6efd792f53fc2859257c350.1670527774.git.kai@dev.carbon-project.org>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
         <869badb999d4021dd6efd792f53fc2859257c350.1670527774.git.kai@dev.carbon-project.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 3024E8000D
X-Stat-Signature: y9dbgd1dm19ghqhj465pn5zti6j5hinc
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+3SflY6wsMr7rPN5Y3yNX/wnURTlDOSNU=
X-HE-Tag: 1670529539-630825
X-HE-Meta: U2FsdGVkX1+uoMQMhqng7v6rJU/vgdqYFJ9MaU23kPCWy9xNGWXdsuUSr68FjfKji8g+Pw6j9ye2w4PpSNp4Fw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-08 at 20:32 +0100, Kai Wasserbäch wrote:
> Issue a warning when encountering URLs behind unknown tags, as Linus
> recently stated ```please stop making up random tags that make no sense.
> Just use "Link:"```[1]. That statement was triggered by an use of
> 'BugLink', but that's not the only tag people invented:
> 
> $ git log -100000 --format=email -P --grep='^\w+:[ \t]*http' | \

Please use the --no-merges output

>   grep -Poh '^\w+:[ \t]*http' | \
>   sort | uniq -c | sort -rn | head -n 20
>  103889 Link: http
>     415 BugLink: http
>     372 Patchwork: http
>     270 Closes: http
>     221 Bug: http
>     121 References: http
>     101 v1: http
>      77 Bugzilla: http
>      60 URL: http
>      59 v2: http
>      37 Datasheet: http
>      35 v3: http
>      19 v4: http
>      12 v5: http
>       9 Ref: http
>       9 Fixes: http
>       9 Buglink: http
>       8 v6: http
>       8 Reference: http
>       7 V1: http
> 
> Some of these non-standard tags make it harder for external tools that
> rely on use of proper tags. One of those tools is the regression
> tracking bot 'regzbot', which looks out for "Link:" tags pointing to
> reports of tracked regressions.
> 
> The initial idea was to use a disallow list to raise an error when
> encountering known unwanted tags like BugLink:; during review it was
> requested to use a list of allowed tags instead[2].
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3239,6 +3239,13 @@ sub process {
>  			$commit_log_possible_stack_dump = 0;
>  		}
>  
> +# Check for odd tags before a URI/URL
> +		if ($in_commit_log &&
> +		    $line =~ /^\s*(\w+):\s*http/ && $1 !~ /^Link/) {
> +			WARN("COMMIT_LOG_USE_LINK",
> +			     "Unknown link reference '$1:', use 'Link:' instead.\n" . $herecurr);

This would allow LinkFoo: so better would be

		    $line =~ /^\s*(\w+):\s*http/ && $1 ne 'Link')
or
		    $line =~ /^\s*(\w+):\s*http/ && $1 !~ /^Link$/) {

(and checkpatch doesn't use periods after output messages)

Maybe better as well would be to use something like the below to
better describe the preferred location of patch versioning info.

# Check for odd tags before a URI/URL
		if ($in_commit_log &&
		    $line =~ /^\s*(\w+):\s*http/ && $1 ne 'Link') {
			if ($1 =~ /^v(?:ersion)?\d+/i) {
				WARN("COMMIT_LOG_VERSIONING",
				     "Patch version information should be after the --- line\n" . $herecurr);
			} else {
				WARN("COMMIT_LOG_USE_LINK",
				     "Unknown link reference '$1:', use 'Link:' instead\n" . $herecurr);
			}
		}

