Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313EC71318A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjE0Big convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 May 2023 21:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjE0Bie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:38:34 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF22ADF;
        Fri, 26 May 2023 18:38:32 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 3DBCF141002;
        Sat, 27 May 2023 01:38:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id EA0BB32;
        Sat, 27 May 2023 01:38:28 +0000 (UTC)
Message-ID: <c65be7a615f5cfa300289a6f251d97286c8d81e9.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Warn about 0-length and 1-element arrays
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Fri, 26 May 2023 18:38:27 -0700
In-Reply-To: <20230526173921.gonna.349-kees@kernel.org>
References: <20230526173921.gonna.349-kees@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: EA0BB32
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: ar7pxy4d5pomtswdnnjsoe6yy71gsm5g
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Z4R0AzZANWt0rt9/6+l9fhMNP8CYirfg=
X-HE-Tag: 1685151508-894923
X-HE-Meta: U2FsdGVkX1+dCPvMh4+sUOxCG3A4UsxokVf1Qv/rpx/JakuJ4v/mgl6nh4O/u1+RLoWUvMu+7GDdBhK04PktRA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-05-26 at 10:39 -0700, Kees Cook wrote:
> Fake flexible arrays have been deprecated since last millennium. Proper
> C99 flexible arrays must be used throughout the kernel so
> CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> bounds checking.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> @@ -7430,6 +7430,21 @@ sub process {
>  			}
>  		}
>  
> +# check for array definition/declarations that should use flexible arrays instead
> +		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
> +		    $prevline =~ /^\+\s*(?:(?:struct|union|enum)\s+$Ident|\}|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {

I think this is overly complicated and not necessary

		    $prevline =~ /^\+\s*$Type\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {

should work no?

($Type already includes this from @typeList):
	qr{struct\s+$Ident},
	qr{union\s+$Ident},
	qr{enum\s+$Ident},

> +			if ($1 == '0') {
> +				if (WARN("ZERO_LENGTH_ARRAY",
> +					 "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev) &&
> +				    $fix) {
> +					$fixed[$fixlinenr - 1] =~ s/\[0\]/[]/g;

And this $fix doesn't work if the line is struct foo bar[ 0 ];
and the use of /g is odd.

Because the message is a WARN and not an ERR, please use
"Prefer/over" and not "Use/instead of"

					$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
> +				}
> +			} else {
> +				WARN("ONE_ELEMENT_ARRAY",
> +				     "Use C99 flexible arrays instead of one-element arrays - see https://github.com/KSPP/linux/issues/79\n" . $hereprev);
> +			}

And this could have a $fix change too

				if (WARN("ONE_ELEMENT_ARRAY",
					 ...) &&
				    $fix) {
					$fixed[$fixlinenr - 1] =~ s/\[\s*1\s*\]/[]/;
> +		}
> +
>  # nested likely/unlikely calls
>  		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
>  			WARN("LIKELY_MISUSE",

