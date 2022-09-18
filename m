Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30725BC02A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIRVkr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 18 Sep 2022 17:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRVkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 17:40:45 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281181400E
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 14:40:44 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 2DF291A02D0;
        Sun, 18 Sep 2022 21:40:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 909BB6000A;
        Sun, 18 Sep 2022 21:40:41 +0000 (UTC)
Message-ID: <b683a340c820e7b55f7da047bfe3dd327db8ea5c.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Extend matched name characters in
 maintainers_in_file()
From:   Joe Perches <joe@perches.com>
To:     Janne Grunau <j@jannau.net>
Cc:     linux-kernel@vger.kernel.org,
        Martin =?UTF-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Date:   Sun, 18 Sep 2022 14:40:40 -0700
In-Reply-To: <20220918203217.GG4024@jannau.net>
References: <20220916084712.84411-1-j@jannau.net>
         <d52110471b332b047777616c762b086ee662225e.camel@perches.com>
         <92afdf33e22e8a63f6baaaba94c004cf2ec5a7d7.camel@perches.com>
         <20220918203217.GG4024@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 6z1rk8c3ycxnrsniu9jwrqigkbkzm53c
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 909BB6000A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/6wJYtHBuU7X9rGAyUzLuPE6KDlX4ddN8=
X-HE-Tag: 1663537241-402956
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-09-18 at 22:32 +0200, Janne Grunau wrote:
> On 2022-09-18 10:03:17 -0700, Joe Perches wrote:
> > On Sat, 2022-09-17 at 07:11 -0700, Joe Perches wrote:
> > > On Fri, 2022-09-16 at 10:47 +0200, Janne Grunau wrote:
> > > > Extend the regexp matching name characters to cover Unicode blocks Latin
> > > > Extended-A and Extended-B.
> > > > Fixes 'scripts/get_maintainer.pl -f' for
> > > > 'Documentation/devicetree/bindings/clock/apple,nco.yaml'.
[]
> > > > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> > > []
> > > > @@ -442,7 +442,7 @@ sub maintainers_in_file {
> > > >  	my $text = do { local($/) ; <$f> };
> > > >  	close($f);
> > > >  
> > > > -	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> > > > +	my @poss_addr = $text =~ m$[A-Za-zÀ-ɏ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> > > 
> > > 	my @poss_addr = $text =~ m$[\p{XPosixAlpha}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> > 
> > Using variations of \p{posix} doesn't seem to work for at least perl 5.34.
> > 
> > \p{print} seems to work for Documentation/devicetree/bindings/clock/apple,nco.yaml,
> > but I don't know how fragile it is.
> > 
> > \p{print} might be too greedy...
> 
> It is, it produces following diff (checking all files in 
> Documentation/devicetree/bindings):
> -Lubomir Rintel <lkundrak@v3.sk> (in file)
> +"Copyright 2019,2020 Lubomir Rintel" <lkundrak@v3.sk> (in file)
> 
> There are multiple hits of this form. The main issue is that \p{print} 
> includes space. That however fixes many names with 3 parts.

right

> > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
[]
> > @@ -2456,11 +2456,12 @@ sub clean_file_emails {
> >      foreach my $email (@file_emails) {
> >  	$email =~ s/[\(\<\{]{0,1}([A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+)[\)\>\}]{0,1}/\<$1\>/g;
> >  	my ($name, $address) = parse_email($email);
> > +	$name =~ s/^\p{space}*\p{punct}*\p{space}*//;
> 
> This change is useful independently of the name regexp as it rejects
> '- <email@addr.ess>' (yaml list items) as valid name, email combination.

Good.  The below might be a bit better too:

	$name =~ s/(?:\p{space}|\p{punct})*//;

