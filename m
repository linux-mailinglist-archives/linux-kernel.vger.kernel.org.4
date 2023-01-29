Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E65680096
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjA2Rwr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 29 Jan 2023 12:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjA2Rwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:52:45 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F01ABDE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:52:44 -0800 (PST)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id E092116012A;
        Sun, 29 Jan 2023 17:52:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id CE87720025;
        Sun, 29 Jan 2023 17:52:39 +0000 (UTC)
Message-ID: <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Relax commit ID check to allow more than
 12 chars
From:   Joe Perches <joe@perches.com>
To:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 29 Jan 2023 09:52:38 -0800
In-Reply-To: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: CE87720025
X-Stat-Signature: dm3ndocb5wjp6mkwmb59oac1mgw8g7or
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19VyKuVUwfSDzGf2OkI84sXNWYWkDO0xus=
X-HE-Tag: 1675014759-215580
X-HE-Meta: U2FsdGVkX19NTmFS2xT8FjcwM/VUxzUUekRqXNfM/j9vTSMZtu7+q0M/tcC42/M03nwk/FBbIO8PjNGhG+XptA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-01-29 at 13:34 +0100, Jonathan Neuschäfer wrote:
> By now, `git log --pretty=%h` (on my copy of linux.git) prints commit
> hashes with 13 digits, because of the number of objects.
> 
> Relax the rule in checkpatch.pl to allow a few more digits (up to 16).

NAK without updating the process docs first.

Documentation/process/submitting-patches.rst-If your patch fixes a bug in a specific commit, e.g. you found an issue using
Documentation/process/submitting-patches.rst:``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
Documentation/process/submitting-patches.rst-the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
Documentation/process/submitting-patches.rst-lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
Documentation/process/submitting-patches.rst-parsing scripts.  For example::
Documentation/process/submitting-patches.rst-
Documentation/process/submitting-patches.rst-   Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually fr>
Documentation/process/submitting-patches.rst-
Documentation/process/submitting-patches.rst-The following ``git config`` settings can be used to add a pretty format for
Documentation/process/submitting-patches.rst-outputting the above style in the ``git log`` or ``git show`` commands::
Documentation/process/submitting-patches.rst-
Documentation/process/submitting-patches.rst-   [core]
Documentation/process/submitting-patches.rst:           abbrev = 12
Documentation/process/submitting-patches.rst-   [pretty]
Documentation/process/submitting-patches.rst-           fixes = Fixes: %h (\"%s\")

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3177,7 +3177,7 @@ sub process {
>  				$tag_case = 0 if $tag eq "Fixes:";
>  				$tag_space = 0 if ($line =~ /^fixes:? [0-9a-f]{5,} ($balanced_parens)/i);
> 
> -				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12}$/i);
> +				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12,16}$/i);
>  				$id_case = 0 if ($orig_commit !~ /[A-F]/);
> 
>  				# Always strip leading/trailing parens then double quotes if existing
> @@ -3194,7 +3194,7 @@ sub process {
>  			if ($ctitle ne $title || $tag_case || $tag_space ||
>  			    $id_length || $id_case || !$title_has_quotes) {
>  				if (WARN("BAD_FIXES_TAG",
> -				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
> +				     "Please use correct Fixes: style 'Fixes: <12-16 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
>  				    $fix) {
>  					$fixed[$fixlinenr] = "Fixes: $cid (\"$ctitle\")";
>  				}
> --
> 2.39.0
> 

