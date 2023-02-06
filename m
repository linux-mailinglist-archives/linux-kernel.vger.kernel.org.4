Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF0868BCC2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBFMZ1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Feb 2023 07:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:25:25 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100191EBD0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:25:24 -0800 (PST)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id AFCA8140693;
        Mon,  6 Feb 2023 12:25:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 333372002E;
        Mon,  6 Feb 2023 12:25:20 +0000 (UTC)
Message-ID: <12e05a2c2aa1ab5627f4a57135ce4c493abb5a97.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Relax commit ID check to allow more than
 12 chars
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 06 Feb 2023 04:25:19 -0800
In-Reply-To: <CAMuHMdU4HUmTJZiecL9u0G1LuZ18K_1hYo4Q_U9S2a2fuo=xRA@mail.gmail.com>
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
         <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
         <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
         <CAMuHMdWcjUXwkk2V29p-hifDnMhLRSwQBXMzVeURRA48znKC5Q@mail.gmail.com>
         <bbdf99df867786510f709473fa2c3744dbf27bb4.camel@perches.com>
         <CAMuHMdU4HUmTJZiecL9u0G1LuZ18K_1hYo4Q_U9S2a2fuo=xRA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 333372002E
X-Stat-Signature: o11snzhun5bjzaikzw6nenhrefshzyz6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+XhMEzXbQWd2mnvYJ/q+YBhou0YD8q4HE=
X-HE-Tag: 1675686320-519272
X-HE-Meta: U2FsdGVkX1/EDLZyNSBxWkNPBpN0QajvoTACBLdA7CE+6NPBBbtVVCxJ/+K+Goe8ueGtBxeDv2zTm7o7VoOhOQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-02-06 at 12:54 +0100, Geert Uytterhoeven wrote:
> Hi Joe,

rehi Geert

maybe:
---
 scripts/checkpatch.pl | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd44d12965c98..55267ee6b1190 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -36,6 +36,8 @@ my $showfile = 0;
 my $file = 0;
 my $git = 0;
 my %git_commits = ();
+my $git_sha1_min = 12;
+my $git_sha1_max = 14;
 my $check = 0;
 my $check_orig = 0;
 my $summary = 1;
@@ -1230,7 +1232,13 @@ sub git_commit_info {
 		 $lines[0] =~ /^fatal: bad object $commit/) {
 		$id = undef;
 	} else {
-		$id = substr($lines[0], 0, 12);
+		my $len = length($commit);
+		if ($len < $git_sha1_min) {
+			$len = $git_sha1_min;
+		} elsif ($len > $git_sha1_max) {
+			$len = $git_sha1_max;
+		}
+		$id = substr($lines[0], 0, $len);
 		$desc = substr($lines[0], 41);
 	}
 
@@ -1297,7 +1305,7 @@ for my $filename (@ARGV) {
 	if ($filename eq '-') {
 		$vname = 'Your patch';
 	} elsif ($git) {
-		$vname = "Commit " . substr($filename, 0, 12) . ' ("' . $git_commits{$filename} . '")';
+		$vname = "Commit " . substr($filename, 0, $git_sha1_min) . ' ("' . $git_commits{$filename} . '")';
 	} else {
 		$vname = $filename;
 	}
@@ -3191,7 +3199,7 @@ sub process {
 				$tag_case = 0 if $tag eq "Fixes:";
 				$tag_space = 0 if ($line =~ /^fixes:? [0-9a-f]{5,} ($balanced_parens)/i);
 
-				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12}$/i);
+				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{$git_sha1_min,$git_sha1_max}$/i);
 				$id_case = 0 if ($orig_commit !~ /[A-F]/);
 
 				# Always strip leading/trailing parens then double quotes if existing
@@ -3208,7 +3216,7 @@ sub process {
 			if ($ctitle ne $title || $tag_case || $tag_space ||
 			    $id_length || $id_case || !$title_has_quotes) {
 				if (WARN("BAD_FIXES_TAG",
-				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
+				     "Please use correct Fixes: style 'Fixes: <$git_sha1_min to $git_sha1_max chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
 				    $fix) {
 					$fixed[$fixlinenr] = "Fixes: $cid (\"$ctitle\")";
 				}
@@ -3300,9 +3308,9 @@ sub process {
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
 		    (($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
 		      ($line =~ /\bcommit\s*$/i && defined($rawlines[$linenr]) && $rawlines[$linenr] =~ /^\s*[0-9a-f]{5,}\b/i)) ||
-		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
-		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
-		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
+		     ($line =~ /(?:\s|^)[0-9a-f]{$git_sha1_min,40}(?:[\s"'\(\[]|$)/i &&
+		      $line !~ /[\<\[][0-9a-f]{$git_sha1_min,40}[\>\]]/i &&
+		      $line !~ /\bfixes:\s*[0-9a-f]{$git_sha1_min,40}/i))) {
 			my $init_char = "c";
 			my $orig_commit = "";
 			my $short = 1;
@@ -3340,11 +3348,11 @@ sub process {
 			if ($input =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
 				$init_char = $1;
 				$orig_commit = lc($2);
-				$short = 0 if ($input =~ /\bcommit\s+[0-9a-f]{12,40}/i);
+				$short = 0 if ($input =~ /\bcommit\s+[0-9a-f]{$git_sha1_min,40}/i);
 				$long = 1 if ($input =~ /\bcommit\s+[0-9a-f]{41,}/i);
 				$space = 0 if ($input =~ /\bcommit [0-9a-f]/i);
 				$case = 0 if ($input =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			} elsif ($input =~ /\b([0-9a-f]{12,40})\b/i) {
+			} elsif ($input =~ /\b([0-9a-f]{$git_sha1_min,40})\b/i) {
 				$orig_commit = lc($1);
 			}
 
@@ -3355,7 +3363,7 @@ sub process {
 			    ($short || $long || $space || $case || ($orig_desc ne $description) || !$has_quotes) &&
 			    $last_git_commit_id_linenr != $linenr - 1) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herectx);
+				      "Please use git commit description style 'commit <$git_sha1_min to $git_sha1_max chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herectx);
 			}
 			#don't report the next line if this line ends in commit and the sha1 hash is the next line
 			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
