Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4634E64780A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLHVed convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Dec 2022 16:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLHVeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:34:24 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1857B4C0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:34:23 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id BAB05160C34;
        Thu,  8 Dec 2022 21:34:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 7036E8000F;
        Thu,  8 Dec 2022 21:34:19 +0000 (UTC)
Message-ID: <af55807391b7cd119c02a0a4f5c88bcda89b243a.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: warn when Reported-by: is not followed
 by Link:
From:   Joe Perches <joe@perches.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 08 Dec 2022 13:34:18 -0800
In-Reply-To: <a834b2a3-273a-f40a-57c4-ae1e89aa67c4@leemhuis.info>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
         <4af6cd7f0833f18e9eee8caba1913e682c5ec071.1670527774.git.kai@dev.carbon-project.org>
         <3953eb4913bf9b5610854624c4c632e710cd1ec9.camel@perches.com>
         <a834b2a3-273a-f40a-57c4-ae1e89aa67c4@leemhuis.info>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7036E8000F
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: sass193k1cbg5dedan8ayfar384iz9nw
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18SagjShbFo/REkew/BstDRCfxC+HbpBuc=
X-HE-Tag: 1670535259-13137
X-HE-Meta: U2FsdGVkX1+xJKUXvbQa/915LnaPuE8RgxgFaPjs+gnSMhL25abJe4Kp05HFEEBNthvFtv8I5cG5DJeK7QOYVg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-08 at 22:11 +0100, Thorsten Leemhuis wrote:
> Joe, many thx for your time and your valuable feedback. I agree with
> most of it and will look into addressing it tomorrow, but there is one
> area where I have a different option:
> 
> On 08.12.22 21:21, Joe Perches wrote:
> > On Thu, 2022-12-08 at 20:32 +0100, Kai Wasserbäch wrote:
> > > +
> > > +			# check if Reported-by: is followed by a Link:
> > > +			if ($sign_off =~ /^reported-by:$/i) {
> > > +				if (!defined $lines[$linenr]) {
> > > +					WARN("BAD_REPORTED_BY_LINK",
> > > +					     "Reported-by: should be immediately followed by Link: to the report\n" . "$here\n" . $rawline);
> > > +				} elsif ($rawlines[$linenr] !~ /^\s*link:\s*(.*)/i) {
> > > +					WARN("BAD_REPORTED_BY_LINK",
> > > +					     "Reported-by: should be immediately followed by Link: to the report\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
> > > +				} elsif ($lines[$linenr] !~ /https?:\/\//i) {
> > > +					WARN("BAD_REPORTED_BY_LINK",
> > > +					     "Link: following Reported-by: should contain an URL\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
> > 
> > [...]
> > 
> > Also the actual link line should likely be from lore
> > 
> > So maybe: 
> > 				} elsif ($lines[$linenr] !~ m{https?://lore.kernel.org/.+}i) {
> > 					WARN("BAD_REPORTED_BY_LINK",
> > 					     "Link: following Reported-by: should use a lore.kernel.org URL\n" . $herecurr . $rawlines[$linenr]);
> 
> I'm pretty sure that's not want we want, as from regression tracking I
> known that we have other links that should continue to work here. Links
> to bugzilla.kernel.org immediately come to my mind, for example. Then
> there are some subsystems that use issue trackers on github or in gitlab
> instances (DRM for example), which must work here, too; and we
> occasionally even have links to bugs in bugzilla instances from RH or
> SUSE there, as sometimes valuable details for code archeologists can be
> found there.

Outside the fact there are relatively few existing uses of Link: after
Reported-by:, it appears that "Fixes:" should also be allowed.

$ git log --no-merges --format=email -P -i --grep "^Reported-by:" -100000 | \
  grep -A1  "^Reported-by:" | \
  grep -v -P '^(Reported-by:|\-\-)' | \
  cut -f1 -d":" | sort | uniq -c | sort -rn | head -20
  31719 Signed-off-by
   4556 Tested-by
   4276 Cc
   2976 Fixes
   2304 Reviewed-by
   1526 Acked-by
    949 Suggested-by
    821 Link
    387 
    228 CC
    139 Bugzilla
     82 Reported-and-tested-by
     69 Debugged-by
     68 References
     63 Bisected-by
     43 Co-developed-by
     34 LKML-Reference
     29 Diagnosed-by
     27 [ paulmck
     26 Addresses-Coverity-ID

and lore definitely dominates the Link: uses.

And IMO: the lkml.kernel.org entries should instead use lore.

Maybe there should be some other patterns allowed.  Dunno.

$ git log --no-merges --format=email -P -i --grep "^Reported-by:" -100000 | \
  grep -A1  "^Reported-by:" | \
  grep '^Link:' | \
  cut -f1-3 -d"/" | sort | uniq -c | sort -rn | head -20
    551 Link: https://lore.kernel.org
     67 Link: http://lkml.kernel.org
     42 Link: https://bugzilla.kernel.org
     28 Link: https://github.com
     16 Link: https://lkml.kernel.org
     11 Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
     10 Link: https://patchwork.freedesktop.org
     10 Link: https://github.blog
      9 Link: https://syzkaller.appspot.com
      9 Link: https://lkml.org
      6 Link: https://www.spinics.net
      5 Link: https://gitlab.freedesktop.org
      5 Link: https://bugs.debian.org
      5 Link: http://lore.kernel.org
      4 Link: https://www.openwall.com
      4 Link: https://patchwork.kernel.org
      4 Link: http://patchwork.freedesktop.org
      3 Link: https://marc.info
      3 Link: https://bugzilla.linux-nfs.org
      2 Link: https://bugzilla.suse.com

