Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26517693282
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBKQg4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Feb 2023 11:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKQgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:36:54 -0500
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Feb 2023 08:36:51 PST
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CF5EB70;
        Sat, 11 Feb 2023 08:36:50 -0800 (PST)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 4DD001C5E3C;
        Sat, 11 Feb 2023 16:27:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id C414320025;
        Sat, 11 Feb 2023 16:27:26 +0000 (UTC)
Message-ID: <6b9347bc16febf724ca33fe99597eb163b4254ff.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: add email addresses from dts files
From:   Joe Perches <joe@perches.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 11 Feb 2023 08:27:25 -0800
In-Reply-To: <20230211121441.64359-1-krzysztof.kozlowski@linaro.org>
References: <20230211121441.64359-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: C414320025
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: stksxf1ryigfwpg5ae9mfgxyqnce8bmt
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19ZnsGQmHFyq0dpJZERwOBE+ead3zvDbyI=
X-HE-Tag: 1676132846-643905
X-HE-Meta: U2FsdGVkX19P3MKU49M5Fy1lnUt+Wf7iGAThGY/qZpQW0WBCPhy3t4m3eGcd/Ze7deeQMb2IhiY+IDD+n/fpZQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-02-11 at 13:14 +0100, Krzysztof Kozlowski wrote:
> The DTS/DTSI files represent hardware description for Linux kernel,
> which is necessary to properly recognize and configure hardware by
> Linux.  DTS is usually created by people having the actual hardware and
> having interest in keeping it in good shape.  Such people can provide
> review (they might have board schematics) and testing.  Unfortunately
> they mostly do not appear in MAINTAINERS file.  Adding per-DTS entries
> to MAINTAINERS would quickly make it bloated (hundreds of new per-DTS
> entries).
> 
> On the other hand there is no point in CC-ing every Copyright email
> appearing in files, because it might be outdated.  Add new in-file
> pattern for storing maintainers dedicated to specific boards:
> 
>   Maintainer: John Smith <email>
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Suggested-by: Shawn Guo <shawnguo@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This is rework of earlier approach:
> Link: https://lore.kernel.org/r/20210809080204.8381-1-shawnguo@kernel.org

Why the rework?  I think the older one is much simpler.

I believe I forwarded the older one to Andrew Morton awhile back.
I'll check to see what happened to it.


> ---
>  scripts/get_maintainer.pl | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index ab123b498fd9..f02a2a80c3bc 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -445,6 +445,17 @@ sub maintainers_in_file {
>  	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
>  	push(@file_emails, clean_file_emails(@poss_addr));
>      }
> +
> +    # Match "Maintainer: email" entries only in DTS sources
> +    if (-f $file && ($email_file_emails || $file =~ /\.dtsi?$/)) {
> +	open(my $f, '<', $file)
> +	    or die "$P: Can't open $file: $!\n";
> +	my $text = do { local($/) ; <$f> };
> +	close($f);
> +
> +	my @poss_addr = $text =~ m$Maintainer: [A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> +	push(@file_emails, clean_file_emails(@poss_addr));
> +    }
>  }
>  
>  #

