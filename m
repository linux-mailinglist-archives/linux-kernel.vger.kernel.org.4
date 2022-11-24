Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE0636F98
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKXBH1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Nov 2022 20:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiKXBHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:07:23 -0500
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B199107E41
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:07:19 -0800 (PST)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 208CE80A07;
        Thu, 24 Nov 2022 01:07:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id F017E17;
        Thu, 24 Nov 2022 01:06:15 +0000 (UTC)
Message-ID: <c0f360168ecd2b4fe121fe476a8b696fd8a7735f.camel@perches.com>
Subject: Re: [PATCH v2 4/5] checkpatch: discard processed lines
From:   Joe Perches <joe@perches.com>
To:     Robert Elliott <elliott@hpe.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 23 Nov 2022 17:07:13 -0800
In-Reply-To: <20221123011202.939319-5-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
         <20221123011202.939319-1-elliott@hpe.com>
         <20221123011202.939319-5-elliott@hpe.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: F017E17
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: gxojzz9ugihcx1jd7hsaf7rwwxdoqgw7
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/1dH/31XdCAQqn1/+dOIJFSDgsLu2+34c=
X-HE-Tag: 1669251975-79764
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-22 at 19:12 -0600, Robert Elliott wrote:
> Advance the line numbers so messages don't repeat previously
> processed lines.

I am concerned that this would create new breakage on existing patch content.
Please show me this does not.

> 
> Before:
> 	WARNING: please write 4 lines of help text that fully describes the
> 	config symbol (detected 3 lines)
> 	#195: FILE: crypto/Kconfig:837:
> 	+config CRYPTO_GHASH_CLMUL_NI_INTEL
> 	+       tristate "GHASH (x86_64 with CLMUL-NI)"
> 		depends on X86 && 64BIT
> 	+       select CRYPTO_CRYPTD
> 	+       select CRYPTO_CRYPTD
> 	+       select CRYPTO_CRYPTD
> 		help
> 	+         GCM GHASH hash function (NIST SP800-38D)
> 	+         GCM GHASH hash function (NIST SP800-38D)
> 
> 		  Architecture: x86_64 using:
> 	+         * CLMUL-NI (carry-less multiplication new instructions)
> 	+         * CLMUL-NI (carry-less multiplication new instructions)
> 	+         * CLMUL-NI (carry-less multiplication new instructions)
> 
> 	+config CRYPTO_GHASH_S390
> 	+config CRYPTO_GHASH_S390
> 	+config CRYPTO_GHASH_S390
> 	+config CRYPTO_GHASH_S390
> 
> After:
> 	WARNING: please write 4 lines of help text that fully describes the
> 	config symbol (detected 3 lines)fu
> 	#195: FILE: crypto/Kconfig:837:
> 	+config CRYPTO_GHASH_CLMUL_NI_INTEL
> 	+       tristate "GHASH (x86_64 with CLMUL-NI)"
> 		depends on X86 && 64BIT
> 	+       select CRYPTO_CRYPTD
> 		help
> 	+         GCM GHASH hash function (NIST SP800-38D)
> 
> 		  Architecture: x86_64 using:
> 	+         * CLMUL-NI (carry-less multiplication new instructions)
> 
> 	+config CRYPTO_GHASH_S390
> 
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  scripts/checkpatch.pl | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1b7a98adcaeb..d11d58e36ee9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1971,21 +1971,25 @@ sub raw_line {
>  	$cnt++;
>  
>  	my $line;
> +	my $consumed;
>  	while ($cnt) {
>  		$line = $rawlines[$offset++];
> +		$consumed++;
>  		next if (defined($line) && $line =~ /^-/);
>  		$cnt--;
>  	}
>  
> -	return $line;
> +	return ($line, $consumed);
>  }
>  
>  sub get_stat_real {
>  	my ($linenr, $lc) = @_;
>  
> -	my $stat_real = raw_line($linenr, 0);
> +	my ($stat_real, $consumed) = raw_line($linenr, 0);
>  	for (my $count = $linenr + 1; $count <= $lc; $count++) {
> -		$stat_real = $stat_real . "\n" . raw_line($count, 0);
> +		my ($more, $consumed) = raw_line($count, 0);
> +		$stat_real = $stat_real . "\n" . $more;
> +		$count += $consumed - 1;
>  	}
>  
>  	return $stat_real;
> @@ -1996,7 +2000,8 @@ sub get_stat_here {
>  
>  	my $herectx = $here . "\n";
>  	for (my $n = 0; $n < $cnt; $n++) {
> -		$herectx .= raw_line($linenr, $n) . "\n";
> +		my ($more, $consumed) = raw_line($linenr, $n);
> +		$herectx .= $more . "\n";
>  	}
>  
>  	return $herectx;
> @@ -4323,7 +4328,7 @@ sub process {
>  			}
>  
>  			my (undef, $sindent) = line_stats("+" . $s);
> -			my $stat_real = raw_line($linenr, $cond_lines);
> +			my ($stat_real, $consumed) = raw_line($linenr, $cond_lines);
>  
>  			# Check if either of these lines are modified, else
>  			# this is not this patch's fault.
> @@ -5420,7 +5425,7 @@ sub process {
>  					$herectx = $here . "\n";
>  					my $cnt = statement_rawlines($if_stat);
>  					for (my $n = 0; $n < $cnt; $n++) {
> -						my $rl = raw_line($linenr, $n);
> +						my ($rl, $consumed) = raw_line($linenr, $n);
>  						$herectx .=  $rl . "\n";
>  						last if $rl =~ /^[ \+].*\{/;
>  					}
> @@ -5617,8 +5622,9 @@ sub process {
>  				my $cond_lines = 1 + $#newlines;
>  				my $stat_real = '';
>  
> -				$stat_real = raw_line($linenr, $cond_lines)
> -							. "\n" if ($cond_lines);
> +				my $consumed;
> +				($stat_real, $consumed) = raw_line($linenr, $cond_lines)
> +							           . "\n" if ($cond_lines);
>  				if (defined($stat_real) && $cond_lines > 1) {
>  					$stat_real = "[...]\n$stat_real";
>  				}
> @@ -7024,7 +7030,7 @@ sub process {
>  			my $cnt = statement_rawlines($stat);
>  			my $herectx = $here . "\n";
>  			for (my $n = 0; $n < $cnt; $n++) {
> -				my $rl = raw_line($linenr, $n);
> +				my ($rl, $consumed) = raw_line($linenr, $n);
>  				$herectx .=  $rl . "\n";
>  				$ok = 1 if ($rl =~ /^[ \+]\{/);
>  				$ok = 1 if ($rl =~ /\{/ && $n == 0);

