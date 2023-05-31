Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB577188D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjEaRvL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 13:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjEaRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:51:09 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89E8128;
        Wed, 31 May 2023 10:51:05 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id D8E28AE40D;
        Wed, 31 May 2023 17:51:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 2627220016;
        Wed, 31 May 2023 17:50:59 +0000 (UTC)
Message-ID: <f8efee7cd9f6f685dcf8b90f9169029fec6481e3.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: Check for 0-length and 1-element arrays
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Wed, 31 May 2023 10:50:58 -0700
In-Reply-To: <20230531004929.you.436-kees@kernel.org>
References: <20230531004929.you.436-kees@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2627220016
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: 496175hzteijz6amhbb9zwp5k5ouzkxg
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Jfx/imyxU+afF/ZXYFTbrkeypYQORHFk=
X-HE-Tag: 1685555459-506856
X-HE-Meta: U2FsdGVkX1+aNTuKxLN4EcbXc1zX6K25fsYiiCIKqnZSBShcyHIuzQnlt6oz3EFhzPcd7P3OnSsclk6GYxlreg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 17:49 -0700, Kees Cook wrote:
> Fake flexible arrays have been deprecated since last millennium. Proper
> C99 flexible arrays must be used throughout the kernel so
> CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> bounds checking.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/r/20230517204530.never.151-kees@kernel.org
> ---
> v4:
>  - combine errors (joe)
>  - switch to kerndoc url (joe)
>  - add __packed for struct matching (joe)
> v3: https://lore.kernel.org/r/20230527020929.give.261-kees@kernel.org
> v2: https://lore.kernel.org/lkml/20230526173921.gonna.349-kees@kernel.org
> v1: https://lore.kernel.org/lkml/20230517204530.never.151-kees@kernel.org
> ---
>  scripts/checkpatch.pl | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 30b0b4fdb3bf..64d21b6aa6df 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7430,6 +7430,16 @@ sub process {
>  			}
>  		}
>  
> +# check for array definition/declarations that should use flexible arrays instead
> +		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
> +		    $prevline =~ /^\+\s*(?:\}(?:\s*__packed\s*)?|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {

__packed could be used when a struct is defined and so
needs to also be added to $sline.

		if ($sline =~ /^[\+ ]\s*}\s*(?:__packed\s*)?;\s*$/ &&

e.g.:

struct foo {
	int a;
	int b[0];
} __packed;

> +			if (ERROR("FLEXIBLE_ARRAY",
> +				  "Use C99 flexible arrays - see https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays\n" . $hereprev) &&
> +			    $1 == '0' && $fix) {
> +				$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
> +			}
> +		}
> +
>  # nested likely/unlikely calls
>  		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
>  			WARN("LIKELY_MISUSE",

