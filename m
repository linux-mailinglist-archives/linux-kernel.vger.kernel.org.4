Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCA60FA65
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiJ0O2T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Oct 2022 10:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiJ0O2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:28:11 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3435517045D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:28:09 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id B37261A1220;
        Thu, 27 Oct 2022 14:28:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 7A4276000C;
        Thu, 27 Oct 2022 14:28:05 +0000 (UTC)
Message-ID: <62b0e423d7e0fa043438f01cec274d9e1966440c.camel@perches.com>
Subject: Re: [PATCH v2] scripts: checkpatch: allow "case" macros
From:   Joe Perches <joe@perches.com>
To:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Oct 2022 07:28:04 -0700
In-Reply-To: <20221027134334.164301-1-stf_xl@wp.pl>
References: <20221027134334.164301-1-stf_xl@wp.pl>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7A4276000C
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: eegkummte5izuz3xk3yoxfg6jgk68yfa
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+FuQWo0UyUHZFr2m1witeJhecqpYltre4=
X-HE-Tag: 1666880885-273424
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-27 at 15:43 +0200, Stanislaw Gruszka wrote:
> Do not report errors like below:
> 
> ./scripts/checkpatch.pl -f drivers/net/wireless/ath/ath10k/wmi.h
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> +#define C2S(x) case x: return #x
> 
> since many "case ..." macros are already used by some in-kernel drivers.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Acked-by: Joe Perches <joe@perches.com>

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
> +			    $dstat !~ /^case\b/ &&					# case ...
>  			    $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&	# do {...} while (...); // do {...} while (...)
>  			    $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&		# while (...) {...}
>  			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)

