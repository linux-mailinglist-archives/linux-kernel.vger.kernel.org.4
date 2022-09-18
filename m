Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12E65BBF0A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIRRDX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 18 Sep 2022 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRRDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:03:22 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BFA193F3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:03:21 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 243F0C0FE5;
        Sun, 18 Sep 2022 17:03:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 1E69619;
        Sun, 18 Sep 2022 17:03:16 +0000 (UTC)
Message-ID: <92afdf33e22e8a63f6baaaba94c004cf2ec5a7d7.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Extend matched name characters in
 maintainers_in_file()
From:   Joe Perches <joe@perches.com>
To:     Janne Grunau <j@jannau.net>
Cc:     linux-kernel@vger.kernel.org,
        Martin =?UTF-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Date:   Sun, 18 Sep 2022 10:03:17 -0700
In-Reply-To: <d52110471b332b047777616c762b086ee662225e.camel@perches.com>
References: <20220916084712.84411-1-j@jannau.net>
         <d52110471b332b047777616c762b086ee662225e.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Stat-Signature: bgbfofmr8xqgmp8gqjkx4rym6k7e5s8k
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1E69619
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/EyBIr8EKSI9ghnUkkURiAbkzvP6k+Iqc=
X-HE-Tag: 1663520595-881005
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-09-17 at 07:11 -0700, Joe Perches wrote:
> On Fri, 2022-09-16 at 10:47 +0200, Janne Grunau wrote:
> > Extend the regexp matching name characters to cover Unicode blocks Latin
> > Extended-A and Extended-B.
> > Fixes 'scripts/get_maintainer.pl -f' for
> > 'Documentation/devicetree/bindings/clock/apple,nco.yaml'.
> > 
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > 
> > ---
> > This still excludes Greek and Cyrilic characters which should be
> > expected in names as well. I tried to use '\p{L}' to match all Unicode
> > letters but couldn't get it to work. Feel free understand this as bug
> > report with an incomplete fix.
> 
> Maybe use \p{XPosixAlpha} ?
> 
> but I don't know what version of perl introduced this.
> 
> > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> []
> > @@ -442,7 +442,7 @@ sub maintainers_in_file {
> >  	my $text = do { local($/) ; <$f> };
> >  	close($f);
> >  
> > -	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> > +	my @poss_addr = $text =~ m$[A-Za-zÀ-ɏ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> 
> 	my @poss_addr = $text =~ m$[\p{XPosixAlpha}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;

Using variations of \p{posix} doesn't seem to work for at least perl 5.34.

\p{print} seems to work for Documentation/devicetree/bindings/clock/apple,nco.yaml,
but I don't know how fragile it is.

\p{print} might be too greedy...

---
 scripts/get_maintainer.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..790112c3e1d7 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -442,7 +442,7 @@ sub maintainers_in_file {
 	my $text = do { local($/) ; <$f> };
 	close($f);
 
-	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
+	my @poss_addr = $text =~ m$[\p{print}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
 	push(@file_emails, clean_file_emails(@poss_addr));
     }
 }
@@ -2456,11 +2456,12 @@ sub clean_file_emails {
     foreach my $email (@file_emails) {
 	$email =~ s/[\(\<\{]{0,1}([A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+)[\)\>\}]{0,1}/\<$1\>/g;
 	my ($name, $address) = parse_email($email);
+	$name =~ s/^\p{space}*\p{punct}*\p{space}*//;
 	if ($name eq '"[,\.]"') {
 	    $name = "";
 	}
 
-	my @nw = split(/[^A-Za-zÀ-ÿ\'\,\.\+-]/, $name);
+	my @nw = split(/[^\p{print}\'\,\.\+-]/, $name);
 	if (@nw > 2) {
 	    my $first = $nw[@nw - 3];
 	    my $middle = $nw[@nw - 2];
