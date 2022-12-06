Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407E8643FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiLFJYO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Dec 2022 04:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiLFJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:23:50 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F49A26117
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:21:52 -0800 (PST)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 3E19E40CCA;
        Tue,  6 Dec 2022 09:21:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 2E66332;
        Tue,  6 Dec 2022 09:21:17 +0000 (UTC)
Message-ID: <15f7df96d49082fb7799dda6e187b33c84f38831.camel@perches.com>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
From:   Joe Perches <joe@perches.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>
Date:   Tue, 06 Dec 2022 01:21:48 -0800
In-Reply-To: <9958a748-2608-8ed2-6e8f-2f3291286271@leemhuis.info>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
         <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
         <25f4838b-208a-cf8c-914c-b2092665d56f@leemhuis.info>
         <23a61dd072ee1d2cc5b54281b0a9dc13e01aa0b8.camel@perches.com>
         <bba95554-19a0-d548-d63c-811b229cbca0@leemhuis.info>
         <d64338a1-e708-dd1f-4d9c-3b793754a8fa@leemhuis.info>
         <b76cd99552c135629ab8e52d3e929916c7965a14.camel@perches.com>
         <9958a748-2608-8ed2-6e8f-2f3291286271@leemhuis.info>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2E66332
X-Stat-Signature: 5rowfeknxtaec4cidberrjpetkj7ohps
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ZD1ZwsGQj1IIPGuQROrcwLwSYY7NdE9Q=
X-HE-Tag: 1670318477-558674
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-06 at 09:50 +0100, Thorsten Leemhuis wrote:
> On 06.12.22 08:44, Joe Perches wrote:
> > On Tue, 2022-12-06 at 08:17 +0100, Thorsten Leemhuis wrote:
> > > On 06.12.22 07:27, Thorsten Leemhuis wrote:
> > > > On 06.12.22 06:54, Joe Perches wrote:
> > []
> > > > > and perhaps a more
> > > > > generic, "is the thing in front of a URI/URL" a known/supported entry,
> > > > > instead of using an known invalid test would be a better mechanism.
> > > > 
> > > > Are you sure about that? It's not that I disagree completely, but it
> > > > sounds overly restrictive to me and makes it harder for new tags to
> > > > evolve in case we might want them.
> > 
> > It's easy to add newly supported values to a list.
> > 
> > > > And what tags would be on this allow-list? Anything else then "Link" and
> > > > "Patchwork"? Those are the ones that looked common and valid to me when
> > > > I ran
> > > > 
> > > > git log --grep='http' v4.0.. | grep http | grep -v '    Link: ' | less
> > > > 
> > > > and skimmed the output. Maybe "Datasheet" should be allowed, too -- not
> > > > sure.
> > []
> > > > But I found a few others that likely should be on the disallow list:
> > > > "Closes:", "Bug:", "Gitlab issue:", "References:", "Ref:", "Bugzilla:",
> > > > "RHBZ:", and "link", as "Link" should be used instead in all of these
> > > > cases afaics.
> > 
> > Do understand please that checkpatch will never be perfect.
> > At best, it's just a guidance tool.
> 
> Of course -- and that's actually a reason why I prefer a disallow list
> over an allow list, as that gives guidance in the way of "don't use this
> tag, use Link instead" instead of enforcing "always use Link: when
> linking somewhere" (now that I've written it like that it feels even
> more odd, because it's obvious that it's a link, so why bother with a
> tag; but whatever).
> 
> I also think the approach with a disallow list will not bother
> developers much, while the other forces them a bit to much into a scheme.
> 
> > To me most of these are in the noise level, but perhaps all should just
> > use Link:
> > 
> > $ git log -100000 --format=email -P --grep='^\w+:[ \t]*http' | \
> >   grep -Poh '^\w+:[ \t]*http' | \
> >   sort | uniq -c | sort -rn
> >  103889 Link: http
> >     415 BugLink: http
> >     372 Patchwork: http
> >     270 Closes: http
> >     221 Bug: http
> >     121 References: http
> > [...]
> 
> Ha, I considered doing something like that when I wrote my earlier mail,
> but was to lazy. :-D thx!
> 
> Yeah, they are not that often, but I grew tired arguing about that,
> that's why I think checkpatch is the better place and in the better
> position to handle that.

I'm not sure that "Patchwork:" is a reasonable prefix.
Is that documented anywhere?

> Anyway, so how to move forward now? Do you insist on a allow list (IOW:
> a Link: or Patchwork: before every http...)? Or is a disallow list with
> the most common unwanted tags for links (that you thankfully compiled)
> fine for you as well?

Maybe
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1c3d13e65c2d0..a526a354cdfbc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3250,6 +3250,13 @@ sub process {
 			$commit_log_possible_stack_dump = 0;
 		}
 
+# Check for odd prefixes before a URI/URL
+		if ($in_commit_log &&
+		    $line =~ /^\s*(\w+):\s*http/ && $1 !~ /^(?:Link|Patchwork)/) {
+			WARN("PREFER_LINK",
+			     "Unusual link reference '$1:', prefer 'Link:'\n" . $herecurr);
+		}
+
 # Check for lines starting with a #
 		if ($in_commit_log && $line =~ /^#/) {
 			if (WARN("COMMIT_COMMENT_SYMBOL",

