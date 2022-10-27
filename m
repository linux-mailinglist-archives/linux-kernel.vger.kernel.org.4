Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4BC60F603
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiJ0LQB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Oct 2022 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiJ0LP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:15:58 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF4012AFA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:15:57 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 9B6D6A10C9;
        Thu, 27 Oct 2022 11:15:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id B7A4A2002D;
        Thu, 27 Oct 2022 11:15:39 +0000 (UTC)
Message-ID: <8064d49ffca92adc171f6a954ad9dea2027b8e4d.camel@perches.com>
Subject: Re: [PATCH] scripts: checkpatch: allow case x: return #x macros
From:   Joe Perches <joe@perches.com>
To:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Oct 2022 04:15:53 -0700
In-Reply-To: <20221027104934.160513-1-stf_xl@wp.pl>
References: <20221027104934.160513-1-stf_xl@wp.pl>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B7A4A2002D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: sbztc6aqm4t31qcbyrq17am6ufemunsq
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+sxHZsoCRP+GRRRTsgKBOFkSqtn47mpBQ=
X-HE-Tag: 1666869339-968827
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-27 at 12:49 +0200, Stanislaw Gruszka wrote:
> Do not report errors like below:
> 
> ./scripts/checkpatch.pl -f drivers/net/wireless/ath/ath10k/wmi.h
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> +#define C2S(x) case x: return #x
> 
> since "case x: return #x" macros are already used by some
> in-kernel drivers.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1e5e66ae5a52..4b888b1313d5 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5901,6 +5901,7 @@ sub process {
>  			    $dstat !~ /$exceptions/ &&
>  			    $dstat !~ /^\.$Ident\s*=/ &&				# .foo =
>  			    $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&		# stringification #foo
> +			    $dstat !~ /^case\s*$Ident:\s*return\s*#$Ident$/ &&		# case x: return #x

I think there needs to be a \s+ not \s* after return

And try this grep and see how many of these are handled

$ git grep -P -n '^\s*#\s*define.*\bcase.*#'

It may be better to just use

			    $dstat !~ /^case\b/ &&

$ git grep -P -n '^\s*#\s*define\s+\w+\([^\)]+\)\s*case\b'


