Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5127B68FD20
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjBIC3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjBIC3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:29:06 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9E53C2E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:29:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbDo-JU_1675909741;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbDo-JU_1675909741)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 10:29:02 +0800
Message-ID: <416afeb8-4385-6d8a-4b35-2c75ffaa36cc@linux.alibaba.com>
Date:   Thu, 9 Feb 2023 10:29:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] erofs: update print symbols for various flags in
 trace
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
References: <20230208112915.6543-1-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230208112915.6543-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/8 19:29, Jingbo Xu wrote:
> As new flags introduced, the corresponding print symbols for trace are
> not added accordingly.  Add these missing print symbols for these flags.
> 
> Also remove the print symbol for EROFS_GET_BLOCKS_RAW as it is going to
> be removed soon.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> v2: remove print symbol for EROFS_GET_BLOCKS_RAW
> ---
>   include/trace/events/erofs.h | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index e095d36db939..cf4a0d28b178 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -19,12 +19,17 @@ struct erofs_map_blocks;
>   		{ 1,		"DIR" })
>   
>   #define show_map_flags(flags) __print_flags(flags, "|",	\
> -	{ EROFS_GET_BLOCKS_RAW,	"RAW" })

Should we remove this in the next patch?
Otherwise it looks good to me.

Thanks,
Gao XIang

> +	{ EROFS_GET_BLOCKS_FIEMAP,	"FIEMAP" },	\
> +	{ EROFS_GET_BLOCKS_READMORE,	"READMORE" },	\
> +	{ EROFS_GET_BLOCKS_FINDTAIL,	"FINDTAIL" })
>   
>   #define show_mflags(flags) __print_flags(flags, "",	\
> -	{ EROFS_MAP_MAPPED,	"M" },			\
> -	{ EROFS_MAP_META,	"I" },			\
> -	{ EROFS_MAP_ENCODED,	"E" })
> +	{ EROFS_MAP_MAPPED,		"M" },		\
> +	{ EROFS_MAP_META,		"I" },		\
> +	{ EROFS_MAP_ENCODED,		"E" },		\
> +	{ EROFS_MAP_FULL_MAPPED,	"F" },		\
> +	{ EROFS_MAP_FRAGMENT,		"R" },		\
> +	{ EROFS_MAP_PARTIAL_REF,	"P" })
>   
>   TRACE_EVENT(erofs_lookup,
>   
