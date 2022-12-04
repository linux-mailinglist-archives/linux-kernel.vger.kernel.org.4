Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15B5641E32
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 18:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiLDRQO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 4 Dec 2022 12:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLDRQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 12:16:11 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BF413E26;
        Sun,  4 Dec 2022 09:16:10 -0800 (PST)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 151DE1A0AB6;
        Sun,  4 Dec 2022 17:16:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 6E15E20025;
        Sun,  4 Dec 2022 17:15:58 +0000 (UTC)
Message-ID: <c78a28f429beccef0941be90957e2549ea39cbd0.camel@perches.com>
Subject: Re: [PATCH] init_task: Include <linux/rbtree.h> in the right file
From:   Joe Perches <joe@perches.com>
To:     Marco Elver <elver@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     paulmck@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Date:   Sun, 04 Dec 2022 09:16:03 -0800
In-Reply-To: <Y4ymv/BxtulPrM47@elver.google.com>
References: <f06e810735c49a611e7dc75715f0689b5f7e87c6.1670153931.git.christophe.jaillet@wanadoo.fr>
         <Y4ymv/BxtulPrM47@elver.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 6E15E20025
X-Stat-Signature: y44oiop5a53cqwtk798gq9ox5wbbozu4
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_FILL_THIS_FORM_SHORT,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX182QPKfG0oLlS7HH44DolJF2hPJI6KnYL0=
X-HE-Tag: 1670174158-38091
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-12-04 at 14:55 +0100, Marco Elver wrote:
> [+Cc Ingo, who had been working on lots of include improvements.]
> 
> The Cc list is odd -- it appears that get_maintainers.pl is broken on
> init_task.c:
> 
> 	$> ./scripts/get_maintainer.pl init/init_task.c
> 	Mark Rutland <mark.rutland@arm.com> (commit_signer:1/1=100%)
> 	"Paul E. McKenney" <paulmck@kernel.org> (commit_signer:1/1=100%)
> 	Marco Elver <elver@google.com> (commit_signer:1/1=100%,authored:1/1=100%,removed_lines:5/5=100%)
> 	linux-kernel@vger.kernel.org (open list)
> 
> What's going on here?

No one claims to be a maintainer of any init/ files
($ git grep "^F:.*init" MAINTAINERS)
so by default it merely shows the people that have patched the
particular file in the last year.

You could perhaps see this better by adding --no-git --no-gitfallback
to the get_maintainer.pl command line

$ ./scripts/get_maintainer.pl --nogit --nogit-fallback init/init_task.c
linux-kernel@vger.kernel.org (open list)

see the --help option for details

$ ./scripts/get_maintainer.pl --help
usage: ./scripts/get_maintainer.pl [options] patchfile
       ./scripts/get_maintainer.pl [options] -f file|directory
version: 0.26

MAINTAINER field selection options:
  --email => print email address(es) if any
    --git => include recent git *-by: signers
    --git-all-signature-types => include signers regardless of signature type
        or use only (Signed-off-by:|Reviewed-by:|Acked-by:) signers (default: 0)
    --git-fallback => use git when no exact MAINTAINERS pattern (default: 1)
    --git-chief-penguins => include (Linus Torvalds)
    --git-min-signatures => number of signatures required (default: 1)
    --git-max-maintainers => maximum maintainers to add (default: 5)
    --git-min-percent => minimum percentage of commits required (default: 5)
    --git-blame => use git blame to find modified commits for patch or file
    --git-blame-signatures => when used with --git-blame, also include all commit signers
    --git-since => git history to use (default: 1-year-ago)
    --hg-since => hg history to use (default: -365)
    --interactive => display a menu (mostly useful if used with the --git option)
    --m => include maintainer(s) if any
    --r => include reviewer(s) if any
    --n => include name 'Full Name <addr@domain.tld>'
    --l => include list(s) if any
    --moderated => include moderated lists(s) if any (default: true)
    --s => include subscriber only list(s) if any (default: false)
    --remove-duplicates => minimize duplicate email names/addresses
    --roles => show roles (status:subsystem, git-signer, list, etc...)
    --rolestats => show roles and statistics (commits/total_commits, %)
    --file-emails => add email addresses found in -f file (default: 0 (off))
    --fixes => for patches, add signatures of commits with 'Fixes: <commit>' (default: 1 (on))
  --scm => print SCM tree(s) if any
  --status => print status if any
  --subsystem => print subsystem name if any
  --web => print website(s) if any

Output type options:
  --separator [, ] => separator for multiple entries on 1 line
    using --separator also sets --nomultiline if --separator is not [, ]
  --multiline => print 1 entry per line

Other options:
  --pattern-depth => Number of pattern directory traversals (default: 0 (all))
  --keywords => scan patch for keywords (default: 1)
  --sections => print all of the subsystem sections with pattern matches
  --letters => print all matching 'letter' types from all matching sections
  --mailmap => use .mailmap file (default: 1)
  --no-tree => run without a kernel tree
  --self-test => show potential issues with MAINTAINERS file content
  --version => show version
  --help => show this help information

Default options:
  [--email --tree --nogit --git-fallback --m --r --n --l --multiline
   --pattern-depth=0 --remove-duplicates --rolestats]

Notes:
  Using "-f directory" may give unexpected results:
      Used with "--git", git signators for _all_ files in and below
          directory are examined as git recurses directories.
          Any specified X: (exclude) pattern matches are _not_ ignored.
      Used with "--nogit", directory is used as a pattern match,
          no individual file within the directory or subdirectory
          is matched.
      Used with "--git-blame", does not iterate all files in directory
  Using "--git-blame" is slow and may add old committers and authors
      that are no longer active maintainers to the output.
  Using "--roles" or "--rolestats" with git send-email --cc-cmd or any
      other automated tools that expect only ["name"] <email address>
      may not work because of additional output after <email address>.
  Using "--rolestats" and "--git-blame" shows the #/total=% commits,
      not the percentage of the entire file authored.  # of commits is
      not a good measure of amount of code authored.  1 major commit may
      contain a thousand lines, 5 trivial commits may modify a single line.
  If git is not installed, but mercurial (hg) is installed and an .hg
      repository exists, the following options apply to mercurial:
          --git,
          --git-min-signatures, --git-max-maintainers, --git-min-percent, and
          --git-blame
      Use --hg-since not --git-since to control date selection
  File ".get_maintainer.conf", if it exists in the linux kernel source root
      directory, can change whatever get_maintainer defaults are desired.
      Entries in this file can be any command line argument.
      This file is prepended to any additional command line arguments.
      Multiple lines and # comments are allowed.
  Most options have both positive and negative forms.
      The negative forms for --<foo> are --no<foo> and --no-<foo>.


