Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD96ED1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjDXPr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjDXPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:47:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 633937AAA;
        Mon, 24 Apr 2023 08:47:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 057D74B3;
        Mon, 24 Apr 2023 08:48:32 -0700 (PDT)
Received: from [10.57.22.201] (unknown [10.57.22.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD2503F64C;
        Mon, 24 Apr 2023 08:47:46 -0700 (PDT)
Message-ID: <f8bd4212-9cca-03ca-884a-c9dec63bb256@arm.com>
Date:   Mon, 24 Apr 2023 17:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] uapi/netfilter: Prefer ISO-friendly __typeof__
Content-Language: en-GB
To:     Petr Vorel <pvorel@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>,
        linux-kbuild@vger.kernel.org
References: <20230416210705.2300706-1-pvorel@suse.cz>
From:   Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20230416210705.2300706-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 23:07, Petr Vorel wrote:
> typeof() is a GNU extension, UAPI requires ISO C, therefore __typeof__()
> should be used.  Similarly to b4bd35a19df5 ("uapi/linux/const.h: Prefer
> ISO-friendly __typeof__") use __typeof__() also in x_tables.h.

Thanks for finishing up the work!

Minor thing, the hash for my commit in -next seems to be 31088f6f7906 at
the moment. As to the Fixes: tag, it looks like it should be (assuming
that commit already exported the macro):

Fixes: 72b2b1dd77e8 ("netfilter: xtables: replace XT_ENTRY_ITERATE macro")

Aside from that, looks good to me, so:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

Kevin

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Based on [1] merged into linux-next as b4bd35a19df5.
> There should be the same Fixes: which we agree in discussion in [1]
> (likely a79ff731a1b2, or d6fc9fcbaa65).
>
> Kind regards,
> Petr
>
> [1] https://lore.kernel.org/lkml/20230411092747.3759032-1-kevin.brodsky@arm.com/
>
>
>  include/uapi/linux/netfilter/x_tables.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/netfilter/x_tables.h b/include/uapi/linux/netfilter/x_tables.h
> index 796af83a963a..d4eced07f2a2 100644
> --- a/include/uapi/linux/netfilter/x_tables.h
> +++ b/include/uapi/linux/netfilter/x_tables.h
> @@ -172,11 +172,11 @@ struct xt_counters_info {
>  
>  /* pos is normally a struct ipt_entry/ip6t_entry/etc. */
>  #define xt_entry_foreach(pos, ehead, esize) \
> -	for ((pos) = (typeof(pos))(ehead); \
> -	     (pos) < (typeof(pos))((char *)(ehead) + (esize)); \
> -	     (pos) = (typeof(pos))((char *)(pos) + (pos)->next_offset))
> +	for ((pos) = (__typeof__(pos))(ehead); \
> +	     (pos) < (__typeof__(pos))((char *)(ehead) + (esize)); \
> +	     (pos) = (__typeof__(pos))((char *)(pos) + (pos)->next_offset))
>  
> -/* can only be xt_entry_match, so no use of typeof here */
> +/* can only be xt_entry_match, so no use of __typeof__ here */
>  #define xt_ematch_foreach(pos, entry) \
>  	for ((pos) = (struct xt_entry_match *)entry->elems; \
>  	     (pos) < (struct xt_entry_match *)((char *)(entry) + \

