Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4305636FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKXBJn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Nov 2022 20:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKXBJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:09:37 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B04D9BBC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:09:36 -0800 (PST)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id DC3161A086C;
        Thu, 24 Nov 2022 01:09:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 6FB5520027;
        Thu, 24 Nov 2022 01:09:02 +0000 (UTC)
Message-ID: <ed9330dd4e1b916a842c1cb0069e880ae5ca8ea2.camel@perches.com>
Subject: Re: [PATCH v2 1/5] checkpatch: improve Kconfig help text patch
 parsing
From:   Joe Perches <joe@perches.com>
To:     Robert Elliott <elliott@hpe.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 23 Nov 2022 17:09:30 -0800
In-Reply-To: <20221123011202.939319-2-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
         <20221123011202.939319-1-elliott@hpe.com>
         <20221123011202.939319-2-elliott@hpe.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: m4uycm9apfc6o4co68dri37j4n3mo3za
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6FB5520027
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ABedIi3QDFvXZT1EkBZC/0MKq7HOqYbA=
X-HE-Tag: 1669252142-307289
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-22 at 19:11 -0600, Robert Elliott wrote:
> While parsing Kconfig help text, allow the strings that affect
> parsing (e.g., help, bool, tristate, and prompt) to be in existing
> text, not just added text (i.e., allow both + and a space character
> at the beginning of the line).
> 
> This improves parsing of a patch like:
> 
> +config CRYPTO_SHA512_S390
> +       tristate "SHA384 and SHA512 (s390)"
> +       depends on S390
>         select CRYPTO_HASH
>         help
> -         SHA512 secure hash standard (DFIPS 180-2).
> +         SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
> 
> -         This version of SHA implements a 512 bit hash with 256 bits of
> -         security against collision attacks.
> +         Architecture: s390
> 
> -         This code also includes SHA-384, a 384 bit hash with 192 bits
> -         of security against collision attacks.
> +         It is available as of z10.

This would seem to be an invalid patch as it adds a config block.

Not sure this is a good change.

> 
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  scripts/checkpatch.pl | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c8a616a9d034..1d9e563e768a 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3490,11 +3490,11 @@ sub process {
>  				next if ($f =~ /^-/);
>  				last if ($f !~ /^[\+ ]/);	# !patch context
>  
> -				if ($f =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
> +				if ($f =~ /^[\+ ]\s*(?:bool|tristate|prompt)\s*["']/) {
>  					$needs_help = 1;
>  					next;
>  				}
> -				if ($f =~ /^\+\s*help\s*$/) {
> +				if ($f =~ /^[\+ ]\s*help\s*$/) {
>  					$has_help = 1;
>  					next;
>  				}
> @@ -3519,7 +3519,8 @@ sub process {
>  			    $help_length < $min_conf_desc_length) {
>  				my $stat_real = get_stat_real($linenr, $ln - 1);
>  				WARN("CONFIG_DESCRIPTION",
> -				     "please write a help paragraph that fully describes the config symbol\n" . "$here\n$stat_real\n");
> +				     "please write $min_conf_desc_length lines of help text that fully describes the config symbol (detected $help_length lines)\n" .
> +				     "$here\n$stat_real\n");
>  			}
>  		}
>  

