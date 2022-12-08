Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E25647722
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLHUWF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Dec 2022 15:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiLHUV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:21:57 -0500
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6551E186EA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:21:56 -0800 (PST)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 8AAC880C73;
        Thu,  8 Dec 2022 20:21:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 0708B20027;
        Thu,  8 Dec 2022 20:21:50 +0000 (UTC)
Message-ID: <3953eb4913bf9b5610854624c4c632e710cd1ec9.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: warn when Reported-by: is not followed
 by Link:
From:   Joe Perches <joe@perches.com>
To:     Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 08 Dec 2022 12:21:50 -0800
In-Reply-To: <4af6cd7f0833f18e9eee8caba1913e682c5ec071.1670527774.git.kai@dev.carbon-project.org>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
         <4af6cd7f0833f18e9eee8caba1913e682c5ec071.1670527774.git.kai@dev.carbon-project.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 0708B20027
X-Stat-Signature: j5k8sgrmcu75hwdfzkbseua4tdzyxyjt
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/YVhSE+ihJj0vummOmnovpWEljgE6P5Xc=
X-HE-Tag: 1670530910-641128
X-HE-Meta: U2FsdGVkX181QdevkTFaY+KaBvX6D0nW5i2dEOJdh/h4CaE8sb267r7G6XwMJfjXaeJ8MM/VqPZbbws8eadouQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-08 at 20:32 +0100, Kai Wasserbäch wrote:
> Encourage patch authors to link to reports by issuing a warning, if
> a Reported-by: is not accompanied by a link to the report. Those links
> are often extremely useful for any code archaeologist that wants to know
> more about the backstory of a change than the commit message provides.
> That includes maintainers higher up in the patch-flow hierarchy, which
> is why Linus asks developers to add such links [1, 2, 3]. To quote [1]:
> 
> > Again, the commit has a link to the patch *submission*, which is
> > almost entirely useless. There's no link to the actual problem the
> > patch fixes.
> > 
> > [...]
> > 
> > Put another way: I can see that
> > 
> > Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
> > 
> > in the commit, but I don't have a clue what the actual report was, and
> > there really isn't enough information in the commit itself, except for
> > a fairly handwavy "Device drivers might, for instance, still need to
> > flush operations.."
> > 
> > I don't want to know what device drivers _might_ do. I would want to
> > have an actual pointer to what they do and where.
> 
> Another reason why these links are wanted: the ongoing regression
> tracking efforts can only scale with them, as they allow the regression
> tracking bot 'regzbot' to automatically connect tracked reports with
> patches that are posted or committed to fix tracked regressions.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3144,6 +3144,20 @@ sub process {
>  					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);

I believe this use of '"$here\n" . $rawline . "\n"' to be a defect.
I think this should just use $herecurr

And the unnecessary space before a newline is an abomination ;)

  					     "Co-developed-by and Signed-off-by: name/email do not match\n" . $herecurr . $rawlines[$linenr]);

> +
> +			# check if Reported-by: is followed by a Link:
> +			if ($sign_off =~ /^reported-by:$/i) {
> +				if (!defined $lines[$linenr]) {
> +					WARN("BAD_REPORTED_BY_LINK",
> +					     "Reported-by: should be immediately followed by Link: to the report\n" . "$here\n" . $rawline);
> +				} elsif ($rawlines[$linenr] !~ /^\s*link:\s*(.*)/i) {
> +					WARN("BAD_REPORTED_BY_LINK",
> +					     "Reported-by: should be immediately followed by Link: to the report\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
> +				} elsif ($lines[$linenr] !~ /https?:\/\//i) {
> +					WARN("BAD_REPORTED_BY_LINK",
> +					     "Link: following Reported-by: should contain an URL\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);

Please use a space before and after a string concatenation '.'

English generally uses "a URL" and not "an URL"
https://www.techtarget.com/whatis/feature/Which-is-correct-a-URL-or-an-URL

Also the actual link line should likely be from lore

So maybe: 
				} elsif ($lines[$linenr] !~ m{https?://lore.kernel.org/.+}i) {
					WARN("BAD_REPORTED_BY_LINK",
					     "Link: following Reported-by: should use a lore.kernel.org URL\n" . $herecurr . $rawlines[$linenr]);

etc...

