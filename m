Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4706C643DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiLFHpD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Dec 2022 02:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLFHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:45:01 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7B211C14
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 23:44:56 -0800 (PST)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 99BACAB285;
        Tue,  6 Dec 2022 07:44:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id A4D626000E;
        Tue,  6 Dec 2022 07:44:53 +0000 (UTC)
Message-ID: <b76cd99552c135629ab8e52d3e929916c7965a14.camel@perches.com>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
From:   Joe Perches <joe@perches.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>
Date:   Mon, 05 Dec 2022 23:44:52 -0800
In-Reply-To: <d64338a1-e708-dd1f-4d9c-3b793754a8fa@leemhuis.info>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
         <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
         <25f4838b-208a-cf8c-914c-b2092665d56f@leemhuis.info>
         <23a61dd072ee1d2cc5b54281b0a9dc13e01aa0b8.camel@perches.com>
         <bba95554-19a0-d548-d63c-811b229cbca0@leemhuis.info>
         <d64338a1-e708-dd1f-4d9c-3b793754a8fa@leemhuis.info>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: A4D626000E
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 4a7gwtrhm5t7e5tzbqetj4bqrusfb7ft
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18H9Li8m3Jyv3MwKXhWpRVmy0CTlP4sj1g=
X-HE-Tag: 1670312693-875875
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-06 at 08:17 +0100, Thorsten Leemhuis wrote:
> On 06.12.22 07:27, Thorsten Leemhuis wrote:
> > On 06.12.22 06:54, Joe Perches wrote:
[]
> > > and perhaps a more
> > > generic, "is the thing in front of a URI/URL" a known/supported entry,
> > > instead of using an known invalid test would be a better mechanism.
> > 
> > Are you sure about that? It's not that I disagree completely, but it
> > sounds overly restrictive to me and makes it harder for new tags to
> > evolve in case we might want them.

It's easy to add newly supported values to a list.

> > And what tags would be on this allow-list? Anything else then "Link" and
> > "Patchwork"? Those are the ones that looked common and valid to me when
> > I ran
> > 
> > git log --grep='http' v4.0.. | grep http | grep -v '    Link: ' | less
> > 
> > and skimmed the output. Maybe "Datasheet" should be allowed, too -- not
> > sure.
[]
> > But I found a few others that likely should be on the disallow list:
> > "Closes:", "Bug:", "Gitlab issue:", "References:", "Ref:", "Bugzilla:",
> > "RHBZ:", and "link", as "Link" should be used instead in all of these
> > cases afaics.

Do understand please that checkpatch will never be perfect.
At best, it's just a guidance tool.

To me most of these are in the noise level, but perhaps all should just
use Link:

$ git log -100000 --format=email -P --grep='^\w+:[ \t]*http' | \
  grep -Poh '^\w+:[ \t]*http' | \
  sort | uniq -c | sort -rn
 103889 Link: http
    415 BugLink: http
    372 Patchwork: http
    270 Closes: http
    221 Bug: http
    121 References: http
    101 v1: http
     77 Bugzilla: http
     60 URL: http
     59 v2: http
     37 Datasheet: http
     35 v3: http
     19 v4: http
     12 v5: http
      9 Ref: http
      9 Fixes: http
      9 Buglink: http
      8 v6: http
      8 Reference: http
      7 V1: http
      7 See: http
      6 1: http
      5 link: http
      4 v7: http
      4 v0: http
      4 0: http
      3 LINK: http
      3 Link:http
      3 IGT: http
      2 V3: http
      2 Schematics: http
      2 RHBZ: http
      2 RFC: http
      2 Reported: http
      2 MR: http
      2 Bugs: http
      2 BUG: http
      2 2: http
      1 Website: http
      1 V9: http
      1 v9: http
      1 V8: http
      1 v8: http
      1 V7: http
      1 V6: http
      1 V5: http
      1 V4: http
      1 V2: http
      1 v1:http
      1 v10: http
      1 Twitter: http
      1 tree: http
      1 tool: http
      1 tests: http
      1 tasks: http
      1 SPI: http
      1 Source: http
      1 SoM: http
      1 Reproducer: http
      1 reliable: http
      1 Related: http
      1 Reference:http
      1 Mesa: http
      1 Lore: http
      1 Links:http
      1 Links: http
      1 Link:  http
      1 ink: http
      1 in: http
      1 here: http
      1 bz: http
      1 Bug:http
      1 AlsaInfo: http

