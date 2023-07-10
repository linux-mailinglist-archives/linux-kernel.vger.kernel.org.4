Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7292074D340
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjGJKWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjGJKWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:22:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF34A93
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:21:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso22580365ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688984502; x=1691576502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqufQ/p2OjbA3yfpb1YX+Q16BF65bMBJOaY+VuJd1j0=;
        b=U1i4x1nuapnPR8UEZsLtVMVnvY5UK2mHfDtqLVPeMZWxXCVWnPV3nC7c72q+AMENn8
         zWOKzOGExdJCOxrYU4p6SOdgRUcca4BAYHWz15X3NE7WV993vuU/DFXFkr1SWgbbA7Y8
         Z5p0cT9XIpFrSA06XAtSRIfO5eh9AMf7O7yFaH15HNTX3V2nAt6j07Re72JcS6ypFJeh
         fNSNLtXcmU+Z9xoOJ62+GwIrXkpvIHPTyNJqV1aGP0Ei8IJEjWsCrAQesTsS2AIKWEpT
         yaRkZjfxUMV7NTs2Nzf461HsI/lHi7KUhS6rF60xEpU8RN5A8Z9DZAygbZZzI0hJqBXI
         +f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688984502; x=1691576502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oqufQ/p2OjbA3yfpb1YX+Q16BF65bMBJOaY+VuJd1j0=;
        b=HavD1P9eAAoYgjuKUSZevE+/K7SQTwyJ8aZAe2WFoVKZyZvWMIzqga8l8WDF4ONIQz
         Im7WjOhf/+Pd1Ayrjkw4+cq+LNUKKqNNvYYjWokIfPo3NMzb6rlD5j+RwboplFQ3e+rT
         NRKwfFz70CbZsl9vpsmGcBGAHcVRGJ1bnQoTgAaVmCOk4vDKugG7niYUf/9RNyhovtoU
         eb6CbY+SScbc1RAg8rf62bZk59QKVQ5kkqT4RD6X93O1bkdjDwBwUU5gE3Y2zZneOFYu
         MP6LZqerhA27Ymq7Z0i8m8uSio9TLMom9fL6wIxdMyAHh7Pp0oWeAyvFD4BJ29b1s+xB
         gR4g==
X-Gm-Message-State: ABy/qLbcQfUxDeAv1jN6Zmd+nGJhNMOuUv56Ua9l9aH6/l0kZx23FUwn
        /Wa8V5SATejFV5jItkWV4ASrgw==
X-Google-Smtp-Source: APBJJlEwJm4ABV/SXJklRj9ZSbE14K8I8MwJNH+t/IS63BSGVKmyiro2peJ+5nMUTT/s76cMO38j8Q==
X-Received: by 2002:a17:902:e5c5:b0:1b8:4f92:565e with SMTP id u5-20020a170902e5c500b001b84f92565emr14422055plf.21.1688984502177;
        Mon, 10 Jul 2023 03:21:42 -0700 (PDT)
Received: from [10.254.35.30] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001b523714ed5sm7894167plb.252.2023.07.10.03.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 03:21:41 -0700 (PDT)
Message-ID: <0470814d-a233-0b8c-4d29-ff0cc34e12c4@bytedance.com>
Date:   Mon, 10 Jul 2023 18:21:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] ext4: Make running and commit transaction have their own
 freed_data_list
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230612124017.14115-1-hanjinke.666@bytedance.com>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <20230612124017.14115-1-hanjinke.666@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ted

Can you consider this patch？ As it was already Reviewed by Zhang Yi.

Thanks
Jinke

在 2023/6/12 下午8:40, Jinke Han 写道:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> When releasing space in jbd, we traverse s_freed_data_list to get the
> free range belonging to the current commit transaction. In extreme cases,
> the time spent may not be small, and we have observed cases exceeding
> 10ms. This patch makes running and commit transactions manage their own
> free_data_list respectively, eliminating unnecessary traversal.
> 
> And in the callback phase of the commit transaction, no one will touch
> it except the jbd thread itself, so s_md_lock is no longer needed.
> 
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
> ---
>   fs/ext4/ext4.h    |  2 +-
>   fs/ext4/mballoc.c | 19 +++++--------------
>   2 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 813b4da098a0..356905357dc9 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1557,7 +1557,7 @@ struct ext4_sb_info {
>   	unsigned int *s_mb_maxs;
>   	unsigned int s_group_info_size;
>   	unsigned int s_mb_free_pending;
> -	struct list_head s_freed_data_list;	/* List of blocks to be freed
> +	struct list_head s_freed_data_list[2];	/* List of blocks to be freed
>   						   after commit completed */
>   	struct list_head s_discard_list;
>   	struct work_struct s_discard_work;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4f2a1df98141..8fab5720a979 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3626,7 +3626,8 @@ int ext4_mb_init(struct super_block *sb)
>   
>   	spin_lock_init(&sbi->s_md_lock);
>   	sbi->s_mb_free_pending = 0;
> -	INIT_LIST_HEAD(&sbi->s_freed_data_list);
> +	INIT_LIST_HEAD(&sbi->s_freed_data_list[0]);
> +	INIT_LIST_HEAD(&sbi->s_freed_data_list[1]);
>   	INIT_LIST_HEAD(&sbi->s_discard_list);
>   	INIT_WORK(&sbi->s_discard_work, ext4_discard_work);
>   	atomic_set(&sbi->s_retry_alloc_pending, 0);
> @@ -3878,21 +3879,11 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>   	struct ext4_free_data *entry, *tmp;
>   	struct list_head freed_data_list;
> -	struct list_head *cut_pos = NULL;
> +	struct list_head *s_freed_head = &sbi->s_freed_data_list[commit_tid & 1];
>   	bool wake;
>   
>   	INIT_LIST_HEAD(&freed_data_list);
> -
> -	spin_lock(&sbi->s_md_lock);
> -	list_for_each_entry(entry, &sbi->s_freed_data_list, efd_list) {
> -		if (entry->efd_tid != commit_tid)
> -			break;
> -		cut_pos = &entry->efd_list;
> -	}
> -	if (cut_pos)
> -		list_cut_position(&freed_data_list, &sbi->s_freed_data_list,
> -				  cut_pos);
> -	spin_unlock(&sbi->s_md_lock);
> +	list_replace_init(s_freed_head, &freed_data_list);
>   
>   	list_for_each_entry(entry, &freed_data_list, efd_list)
>   		ext4_free_data_in_buddy(sb, entry);
> @@ -6298,7 +6289,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>   	}
>   
>   	spin_lock(&sbi->s_md_lock);
> -	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list);
> +	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list[new_entry->efd_tid & 1]);
>   	sbi->s_mb_free_pending += clusters;
>   	spin_unlock(&sbi->s_md_lock);
>   }
