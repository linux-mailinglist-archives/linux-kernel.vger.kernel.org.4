Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D11636F93
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiKXBEs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Nov 2022 20:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKXBEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:04:38 -0500
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F2F105ABF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:04:27 -0800 (PST)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id B57AAA0763;
        Thu, 24 Nov 2022 01:04:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 417BE17;
        Thu, 24 Nov 2022 01:03:24 +0000 (UTC)
Message-ID: <b15978c31c043d198e33a4acc0959d4fde494e08.camel@perches.com>
Subject: Re: [PATCH v2 3/5] checkpatch: check line length in Kconfig help
 text
From:   Joe Perches <joe@perches.com>
To:     Robert Elliott <elliott@hpe.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 23 Nov 2022 17:04:22 -0800
In-Reply-To: <20221123011202.939319-4-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
         <20221123011202.939319-1-elliott@hpe.com>
         <20221123011202.939319-4-elliott@hpe.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: ai8dshhdpue1m18n7t9wa6nkmjngwkje
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 417BE17
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/ZTmLUjQNQVeO9NcsguZI86fxxPe/UcJE=
X-HE-Tag: 1669251804-396277
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-22 at 19:12 -0600, Robert Elliott wrote:
> Apply the normal --max-line-length=nn line length checks to
> Kconfig help text.
> 
> The default of 100 is only triggered by one existing line in
> a file named Kconfig. Running with --max-line-length=80 reports
> only a few long lines:

Perhaps add a KCONFIG_LINE_LENGTH specific length.
Likely this should use 80 and not 100

> - 11 between 90 and 99 characters
> - 25 betwen 81 and 89 characters
> 9 of which are due to long URLs.
> 
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  scripts/checkpatch.pl | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c907d5cf0ac8..1b7a98adcaeb 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3496,7 +3496,7 @@ sub process {
>  				next if ($f =~ /^-/);
>  				last if ($f !~ /^[\+ ]/);	# !patch context
>  
> -				if ($f =~ /^[\+ ]\s*(?:bool|tristate|prompt)\s*["']/) {
> +				if ($f =~ /^[\+ ]\s*(?:bool|tristate|string|hex|int|prompt)\s*["']/) {
>  					$needs_help = 1;
>  					next;
>  				}
> @@ -3515,12 +3515,27 @@ sub process {
>  				# and so hopefully shouldn't trigger false
>  				# positives, even though some of these are
>  				# common words in help texts
> -				if ($f =~ /^(?:config|menuconfig|choice|endchoice|
> -					       if|endif|menu|endmenu|source)\b/x) {
> +				if ($f =~ /^(?:config|menuconfig|
> +					       choice|endchoice|
> +					       comment|if|endif|
> +					       menu|endmenu|source)\b/x) {
>  					last;
>  				}
> +
> +				# no further checking for lines with these keywords
> +				if ($f =~ /^(?:default|def_bool|depends|select|imply)\b/x) {
> +					next;
> +				}
> +
> +				my ($length, $indent) = line_stats($f);
> +				if ($length > $max_line_length) {
> +					WARN("CONFIG_DESCRIPTION",
> +					     "Kconfig help text line length ($length) too long: $f\n");
> +				}
> +
>  				$help_length++ if ($has_help);
>  			}
> +
>  			if ($needs_help &&
>  			    $help_length < $min_conf_desc_length) {
>  				my $stat_real = get_stat_real($linenr, $ln - 1);

