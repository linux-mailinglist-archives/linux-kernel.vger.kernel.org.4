Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4043D6D2C34
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 03:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjDABBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 21:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjDABBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 21:01:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F491B7EE
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 18:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAE03B83284
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 01:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70020C433EF;
        Sat,  1 Apr 2023 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680310863;
        bh=tt7ZGatFV1hjdhv+xFUnZBFTFezV1KSetDds2ucKZNs=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=janccKIkv8gk5FEqwL/V+sypzlpq4VKfugp40dB6anoP5nnRNthYLPOkEfwEJ7cdJ
         j7MogpyMRpzNioQVQhOZpLQSKoBI1jVCSBDSwEia/Ga+jgrS1tewbGxgUNjygTltw0
         vZ8ixmvySVtuX7D4ZpF76C3li+cBtzLsH1+1UwFs+nXq+XRYmRNBnPa9OovYqYo4+/
         fFECcg/GgLz0FVsEwhTi1U936XArQt5FUSoSNJrCtUqHmwMROp8LLBf2rt7BH8OCoT
         jrpo3I3356eoXIB0tiZFTO5HeQp4NmQXBwsdra2KKn9gbSkF9iM3upx92YFOa5V1ih
         Vo3P/JEDThlrw==
Message-ID: <ec3f83d3-c00c-17d5-c967-2e3e7a4798c7@kernel.org>
Date:   Sat, 1 Apr 2023 09:00:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Bo Ye <bo.ye@mediatek.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        xiongping1 <xiongping1@xiaomi.com>,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
Cc:     yongdong.zhang@mediatek.com, peng.zhou@mediatek.com,
        browse.zhang@mediatek.com, light.hsieh@mediatek.com,
        Qilin Tan <qilin.tan@mediatek.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230331092658.72386-1-bo.ye@mediatek.com>
 <20230331092658.72386-2-bo.ye@mediatek.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: add __pack attribute for extent_info
In-Reply-To: <20230331092658.72386-2-bo.ye@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/31 17:26, Bo Ye wrote:
> From: Qilin Tan <qilin.tan@mediatek.com>
> 
> Need add __pack for struct extent_info to align to memory
> layout of struct rb_entry.

Jaegeuk has fixed this bug w/ below patchset, please check it:

https://lore.kernel.org/linux-f2fs-devel/20230313201216.924234-1-jaegeuk@kernel.org/

Thanks,

> 
> struct rb_entry {
>      struct rb_node rb_node;     /* rb node located in rb-tree */
>      union {
>          struct {
>              unsigned int ofs;   /* start offset of the entry */
>              unsigned int len;   /* length of the entry */
>          };
>          unsigned long long key;     /* 64-bits key */
>      } __packed;
> };
> 
> struct extent_info {
>      unsigned int fofs;      /* start offset in a file */
>      unsigned int len;       /* length of the extent */
>      union {
>          ...
>          /* block age extent_cache */
>          struct {
>              /* block age of the extent */
>              unsigned long long age;
>              /* last total blocks allocated */
>              unsigned long long last_blocks;
>          };
> };
> 
> The new fields(age, last_blocks) are u64 in change 71644dff4811, it
> cause the memory alignment based on 8 bytes in some complier. So the
> field fofs and len are alloced with 8 bytes and using the last 4 byts.
> Its memory is not aligned with struct rb_entry. the ofs of rb_entry
> pointer to a invalid value and cause writing file failed.
> 
> struct extent_info's offset should be 12 rather than 16 from the
> beginning of struct rb_entry.
> 
> The offset dump for the bad case as:
> kworker/u16:6: [name:f2fs&]f2fs_lookup_rb_tree_for_insert:MTK_DEBUG: ino=1629 re=0xc675dc08 ofs=0 re->ofs=0, re->len=68 ei=0xc675dc18 ei.fofs=68 ei.len=277
> 
> Fixes: 71644dff4811 ("f2fs: add block_age-based extent cache")
> Signed-off-by: Bo Ye <bo.ye@mediatek.com>
> Signed-off-by: Qilin Tan <qilin.tan@mediatek.com>
> ---
>   fs/f2fs/f2fs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b0ab2062038a..7c690667a42f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -660,7 +660,7 @@ struct extent_info {
>   			unsigned long long last_blocks;
>   		};
>   	};
> -};
> +} __packed;
>   
>   struct extent_node {
>   	struct rb_node rb_node;		/* rb node located in rb-tree */
