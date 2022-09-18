Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB9C5BBFD6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIRUcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIRUcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 16:32:20 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54901140C8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 13:32:19 -0700 (PDT)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 673E926F08A; Sun, 18 Sep 2022 22:32:17 +0200 (CEST)
Date:   Sun, 18 Sep 2022 22:32:17 +0200
From:   Janne Grunau <j@jannau.net>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: Re: [PATCH] get_maintainer: Extend matched name characters in
 maintainers_in_file()
Message-ID: <20220918203217.GG4024@jannau.net>
References: <20220916084712.84411-1-j@jannau.net>
 <d52110471b332b047777616c762b086ee662225e.camel@perches.com>
 <92afdf33e22e8a63f6baaaba94c004cf2ec5a7d7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92afdf33e22e8a63f6baaaba94c004cf2ec5a7d7.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-18 10:03:17 -0700, Joe Perches wrote:
> On Sat, 2022-09-17 at 07:11 -0700, Joe Perches wrote:
> > On Fri, 2022-09-16 at 10:47 +0200, Janne Grunau wrote:
> > > Extend the regexp matching name characters to cover Unicode blocks Latin
> > > Extended-A and Extended-B.
> > > Fixes 'scripts/get_maintainer.pl -f' for
> > > 'Documentation/devicetree/bindings/clock/apple,nco.yaml'.
> > > 
> > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > 
> > > ---
> > > This still excludes Greek and Cyrilic characters which should be
> > > expected in names as well. I tried to use '\p{L}' to match all Unicode
> > > letters but couldn't get it to work. Feel free understand this as bug
> > > report with an incomplete fix.
> > 
> > Maybe use \p{XPosixAlpha} ?
> > 
> > but I don't know what version of perl introduced this.
> > 
> > > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> > []
> > > @@ -442,7 +442,7 @@ sub maintainers_in_file {
> > >  	my $text = do { local($/) ; <$f> };
> > >  	close($f);
> > >  
> > > -	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> > > +	my @poss_addr = $text =~ m$[A-Za-zÀ-ɏ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> > 
> > 	my @poss_addr = $text =~ m$[\p{XPosixAlpha}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> 
> Using variations of \p{posix} doesn't seem to work for at least perl 5.34.
> 
> \p{print} seems to work for Documentation/devicetree/bindings/clock/apple,nco.yaml,
> but I don't know how fragile it is.
> 
> \p{print} might be too greedy...

It is, it produces following diff (checking all files in 
Documentation/devicetree/bindings):
-Lubomir Rintel <lkundrak@v3.sk> (in file)
+"Copyright 2019,2020 Lubomir Rintel" <lkundrak@v3.sk> (in file)

There are multiple hits of this form. The main issue is that \p{print} 
includes space. That however fixes many names with 3 parts.

It still fails for "Rafał Miłecki <rafal@milecki.pl>" which my change 
handles correctly.

I'm testing with perl 5.36

> ---
>  scripts/get_maintainer.pl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index ab123b498fd9..790112c3e1d7 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -442,7 +442,7 @@ sub maintainers_in_file {
>  	my $text = do { local($/) ; <$f> };
>  	close($f);
>  
> -	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> +	my @poss_addr = $text =~ m$[\p{print}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
>  	push(@file_emails, clean_file_emails(@poss_addr));
>      }
>  }
> @@ -2456,11 +2456,12 @@ sub clean_file_emails {
>      foreach my $email (@file_emails) {
>  	$email =~ s/[\(\<\{]{0,1}([A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+)[\)\>\}]{0,1}/\<$1\>/g;
>  	my ($name, $address) = parse_email($email);
> +	$name =~ s/^\p{space}*\p{punct}*\p{space}*//;

This change is useful independently of the name regexp as it rejects
'- <email@addr.ess>' (yaml list items) as valid name, email combination.

Janne

