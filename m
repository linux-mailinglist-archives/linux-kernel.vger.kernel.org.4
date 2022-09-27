Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38EB5ECEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiI0Uj3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Sep 2022 16:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiI0UjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:39:22 -0400
X-Greylist: delayed 53907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 13:39:21 PDT
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB19481DE;
        Tue, 27 Sep 2022 13:39:20 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 89DBD120FDF;
        Tue, 27 Sep 2022 20:39:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 2404E2000E;
        Tue, 27 Sep 2022 20:39:05 +0000 (UTC)
Message-ID: <9de78c46ad8da9e4c59ba6206d9dcc51bc984db1.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Don't count URLs for "line too long"
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        ditya Srivastava <yashsri421@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Tue, 27 Sep 2022 13:39:16 -0700
In-Reply-To: <202209270706.DADC6346@keescook>
References: <20220927021517.1952202-1-keescook@chromium.org>
         <91bb341a01ad5cfe4269ef6857387cf3db9619d0.camel@perches.com>
         <202209270706.DADC6346@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: kjdqog96ubk9spa5taq7iaqhouyo6i1f
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2404E2000E
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19QDelsqtmAtoEUOlWktk0mUigBaUpMn9k=
X-HE-Tag: 1664311144-921371
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-27 at 07:07 -0700, Kees Cook wrote:
> On Mon, Sep 26, 2022 at 10:40:50PM -0700, Joe Perches wrote:
> > On Mon, 2022-09-26 at 19:15 -0700, Kees Cook wrote:
> > > URLs (not in a Link: field) should be ignored for "line too long"
> > > warnings. Allow any line containing "https://" or "http://".
> > 
> > More generally, this should be for any URI
> > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -3175,6 +3175,8 @@ sub process {
> > >  					# file delta changes
> > >  		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
> > >  					# filename then :
> > > +		      $line =~ /https?:\/\// ||
> > > +					# URLs
> > >  		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
> > >  					# A Fixes: or Link: line or signature tag line
> > >  		      $commit_log_possible_stack_dump)) {
> > 
> > And I don't recollect why this wasn't applied, but I think it's a rather better,
> > more complete, patch:
> > 
> > https://lore.kernel.org/lkml/20210114073513.15773-2-yashsri421@gmail.com/
> > 
> > I believe I did ack it and forward it to Andrew Morton, but I don't
> > see it on a lore list.
> 
> Many patches have internal references in the commit log (that aren't
> appropriate for "Link:") like:
> 
> [1] https://some.domain/path/
> 
> It seems more flexible to just ignore lines with "http" in it...

URLs vs URIs which can have multiple forms.

Take a look at the results of this grep:

$ git log -1000000 --format=email --no-merges --grep='://' | grep '://' | \
  grep -v -P 'https?://' | grep -P -oh '\b\w+://' | \
  sort | uniq -c | sort -rn
    422 git://
     46 ftp://
     15 file://
     10 smb://
      5 c://
      3 usbip://
      2 svn://
      2 rsync://
      2 pvr://
      1 ttp://
      1 systemd://
      1 server://
      1 radio://
      1 nbd://
      1 irc://
      1 intel_bts://
      1 htp://
      1 40176://

The more inclusve search pattern finds many uses of git:// and ftp:// 
(and probably a few typos too)

Assuming the URI scheme uses ://, it's perhaps reasonable to change the
suggested search in Aditya's patch from

+			if ($line =~ /^\s*([a-z][\w\.\+\-]*:\/\/\S+)/i) {

to maybe something like this so the URI's use of :// is more obvious

+			if ($line =~ m@^.*\b([a-z][\w\.\+\-]*://\S+)@i) {

