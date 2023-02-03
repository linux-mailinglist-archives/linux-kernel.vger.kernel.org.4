Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07769688F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBCFsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjBCFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:48:21 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE965F1B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:48:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VanSjdg_1675403296;
Received: from 30.97.48.205(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VanSjdg_1675403296)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 13:48:17 +0800
Message-ID: <cb34ae5b-2fa1-458c-523a-be179f9248bd@linux.alibaba.com>
Date:   Fri, 3 Feb 2023 13:48:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] erofs: add print symbols for various flags in trace
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
References: <20230203035303.35082-1-jefflexu@linux.alibaba.com>
 <20230203035303.35082-2-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230203035303.35082-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingbo,

On 2023/2/3 11:53, Jingbo Xu wrote:
> As new flags introduced, the corresponding print symbols for trace are
> not added accordingly.  Add these missing print symbols for these flags.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   include/trace/events/erofs.h | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index 4f4c44ea3a65..c0dbe9c4f656 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -19,12 +19,18 @@ struct erofs_map_blocks;
>   		{ 1,		"DIR" })
>   
>   #define show_map_flags(flags) __print_flags(flags, "|",	\
> -	{ EROFS_GET_BLOCKS_RAW,	"RAW" })
> +	{ EROFS_GET_BLOCKS_RAW,		"RAW" },	\

Initially, it was just used for reading compressed (raw) data
for compressed files.  However, it's never used actually.

Could we just gid of this flag (EROFS_GET_BLOCKS_RAW)?

Thanks,
Gao Xiang

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
