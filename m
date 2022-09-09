Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C931F5B4266
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIIWQN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Sep 2022 18:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIIWQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 18:16:10 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9B8D6BA6;
        Fri,  9 Sep 2022 15:16:06 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 43AD740CC1;
        Fri,  9 Sep 2022 22:16:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id F18B220028;
        Fri,  9 Sep 2022 22:16:01 +0000 (UTC)
Message-ID: <9f9a0740aef282d30af8fa02ca7c6479e80aa9a0.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: warn for non-standard fixes tag style
From:   Joe Perches <joe@perches.com>
To:     "niklas.soderlund@corigine.com" <niklas.soderlund@corigine.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "louis.peens@corigine.com" <louis.peens@corigine.com>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "oss-drivers@corigine.com" <oss-drivers@corigine.com>
In-Reply-To: <Yxrt1aa60xY0H7j0@oden.dyn.berto.se>
References: <20220908164434.122106-1-niklas.soderlund@corigine.com>
         <3275d886491dc934e3277cde9cc766b0ce0886ea.camel@toradex.com>
         <Yxrt1aa60xY0H7j0@oden.dyn.berto.se>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Date:   Fri, 09 Sep 2022 10:57:10 -0700
MIME-Version: 1.0
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: F18B220028
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: m91rttnmjcyc9hp6u7nq9q8fgs9shggn
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX181w+JFSHc52oJAFzxomZOE5ihG4vTbwGs=
X-HE-Tag: 1662761761-371326
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-09 at 09:40 +0200, niklas.soderlund@corigine.com wrote:
> On 2022-09-08 17:49:14 +0000, Philippe Schenker wrote:
> > Thanks for adding me to cc. I will also add Stephen, as he also sent
> > some comments on my submission the exact same problem. I'm supportive of
> > your code as it has the nice advantage of suggesting the right format of
> > the tag if it might be wrong. However it seems lot of stuff is slightly
> > duplicated and lots of lines could be left away simplifying it greatly.

It's not very possible to reduce the line count here.
I mentioned the same thing in my first reply.

> > > +# Check Fixes: styles is correct
> > > +               if (!$in_header_lines && $line =~ /^fixes:?/i) {
> > 
> > I would check all lines that start with fixes, even if there is
> > whitespace in front (and then failing later on...)
> > 
> > if (!$in_header_lines && $line =~ /^\s*fixes:?/i) {

I think that's a poor idea.

You should really review git history for lines that start with fixes
and look at the number of false positives that would give.

Try this grep:

$ git log -100000 --no-merges --grep="^\s*fixes" -i --format=email -P | \
  grep -P -i "^\s*fixes)" | \
  grep -P -v "^Fixes: [0-9a-f]{12,}'
[...]

That is a greater than 10% false positive rate.

I think it's better to make sure that there is a likely SHA1 of some
minimum length after the fixes line.

And a relatively common defect is to have the word "commit" after fixes.

e.g.:

Fixes commit 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver").
Fixes commit a2c60d42d97c ("Add files for new driver - part 16").

So maybe:

	if (!$in_header_lines &&
	    $line =~ /^\s*fixes:?\s*(?:commit\s*)?[0-9a-f]{5,}\b/i)



