Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7216A70734B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjEQUoZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQUoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:44:23 -0400
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 13:44:21 PDT
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C730E0;
        Wed, 17 May 2023 13:44:21 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 846F9140519;
        Wed, 17 May 2023 20:36:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 5206C32;
        Wed, 17 May 2023 20:36:19 +0000 (UTC)
Message-ID: <4a8999ffb68c3044e14d1c319e80de44177022c4.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Check for strcpy and strncpy too
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Wed, 17 May 2023 13:36:17 -0700
In-Reply-To: <20230517201349.never.582-kees@kernel.org>
References: <20230517201349.never.582-kees@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5206C32
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout05
X-Stat-Signature: 8yk6hhqdpxkz46ko453zis3y9fopcc6u
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+cqv/78fYjwUQhjcPMuWUWsULOChk42DI=
X-HE-Tag: 1684355779-359496
X-HE-Meta: U2FsdGVkX1+AvxqASz4if7H4iTq6FS7yJwsMLxC+XjnQHjY7Rr7eJuzYTcr1FJXsSH1z0W1DQMub9jnnslpVZw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-17 at 13:13 -0700, Kees Cook wrote:
> Warn about strcpy(), strncpy(), and strlcpy(). Suggest strscpy() and
> include pointers to the open KSPP issues for each, which has further
> details and replacement procedures.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/checkpatch.pl | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b30114d637c4..a90e0ede53ad 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6997,10 +6997,22 @@ sub process {
>  #			}
>  #		}
>  
> +# strcpy uses that should likely be strscpy
> +		if ($line =~ /\bstrcpy\s*\(/) {
> +			WARN("STRCPY",
> +			     "Use of strcpy has been replaced with strscpy - see: https://github.com/KSPP/linux/issues/88\n" . $herecurr);

I would prefer something like

			"Prefer strscpy over strcpy etc..."

as there are just too many existing uses of strcpy that can not
easily be converted.

$ git grep -w strcpy -- "*.[chS]" | wc -l
2015

> +		}
> +
>  # strlcpy uses that should likely be strscpy
>  		if ($line =~ /\bstrlcpy\s*\(/) {
>  			WARN("STRLCPY",
> -			     "Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw\@mail.gmail.com/\n" . $herecurr);
> +			     "Use of strlcpy has been replaced with strscpy - see: https://github.com/KSPP/linux/issues/89\n" . $herecurr);
> +		}
> +
> +# strncpy uses that should likely be strscpy or strscpy_pad
> +		if ($line =~ /\bstrncpy\s*\(/) {
> +			WARN("STRNCPY",
> +			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
>  		}
>  
>  # typecasts on min/max could be min_t/max_t

