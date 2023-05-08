Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7EA6FB169
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjEHN07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:26:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F70A26EB1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:26:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64115eef620so34393932b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683552416; x=1686144416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQCOJg3W+uzuBK1RqiTQ11fYeTUuvn8Ma1oUc2qRxTs=;
        b=KlZIFceKK/yUt1yZ2w8IWHrzddZd+q+0DLvinVyhw10Yvr8b7ShPD9U6KEoq2V08tJ
         sPUraAFwu4rVe1UwQ5Gi1dDzz6Gu4u0lyW3yhoeDm5oef5WNSzB8oPaRqiDAoITsQsP/
         C+fXcpwGtzl55NZ1QFpnviufpFnguPyo/eMm41aVCaWOhGivGXrv7unxCZjTxV3YKVDx
         7+ZUqtxEuOZAq51FH55m1OIA66WyVoj5pSuoeiQfVg2MLtpLCaMHx9zxN1q9Bu6r3Oo2
         aFpWcncg95OfCZ/wdF59c1giSsDwfsNaoOEqgGK+GstMDgV3sEuTwGuI/4lHih/mu4lo
         +6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683552416; x=1686144416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQCOJg3W+uzuBK1RqiTQ11fYeTUuvn8Ma1oUc2qRxTs=;
        b=JaQaZglc3YmI8zfzy2Qs51HXqho6zRgvmOsZjDJzIolmkFidQ4B9R5EAYjuRZ97Juc
         Rgkd2Nc0+afRAY/8Yeqxzm+dWJKxqNwr7luzukV1+DG5OwSVN0Z3bJyBNLVmDveHDcMp
         sNnxbyIXsslMu3tQuw0POZtUuKWgXcSIaHBsxKXZJMYIlrgwS8LauWBnr9A9aWYT/9+9
         Lo48Z+P7qk3siRC8uBFCbpOsHCKZSwJfMOANGL5PqSaemiGlhm54TmUpLNl0Ln21ZDyO
         +Y7E5jo6h4H+QwDKts5swzpe+W7Zb88JSTY4EXwQukwJqGTAl5PZL4Ar6ZkVKHShDd1Y
         N80g==
X-Gm-Message-State: AC+VfDw5s254HhFNeYW9Y0D4FjmakII74wyj/yLZVp+pNbRiO5nXer0z
        1oVhjnMrsV34LEH7NuH8BoIpfTOzuIVJxQ==
X-Google-Smtp-Source: ACHHUZ5HnOLRskG7NnYBLe2nfjDvZBhtYYyvcvVtwlX0yOcrRs3/2qwK+Rp5IYRwTRqFZxOInp5+Ng==
X-Received: by 2002:a17:902:c409:b0:1a9:778b:c1a8 with SMTP id k9-20020a170902c40900b001a9778bc1a8mr22710917plk.12.1683552416296;
        Mon, 08 May 2023 06:26:56 -0700 (PDT)
Received: from vernon-pc ([49.67.182.217])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b001a98f844e60sm3209582plg.263.2023.05.08.06.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 06:26:55 -0700 (PDT)
Date:   Mon, 8 May 2023 21:26:44 +0800
From:   Vernon Yang <vernon2gm@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 31/36] maple_tree: Add mas_prev_range() and
 mas_find_range_rev interface
Message-ID: <ZFj4dNW953l/qCb4@vernon-pc>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
 <20230505174204.2665599-32-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505174204.2665599-32-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 01:41:59PM -0400, Liam R. Howlett wrote:
> Some users of the maple tree may want to move to the previous range
> regardless of the value stored there.  Add this interface as well as the
> 'find' variant to support walking to the first value, then iterating
> over the previous ranges.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  include/linux/maple_tree.h |   1 +
>  lib/maple_tree.c           | 160 +++++++++++++++++++++++++++----------
>  2 files changed, 121 insertions(+), 40 deletions(-)
>
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index a4cd8f891a090..542b09118a09f 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -467,6 +467,7 @@ void mas_destroy(struct ma_state *mas);
>  int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries);
>
>  void *mas_prev(struct ma_state *mas, unsigned long min);
> +void *mas_prev_range(struct ma_state *mas, unsigned long max);
>  void *mas_next(struct ma_state *mas, unsigned long max);
>  void *mas_next_range(struct ma_state *mas, unsigned long max);
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e050fd1f7cce8..f060c71965c0d 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5924,18 +5924,8 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
>  }
>  EXPORT_SYMBOL_GPL(mt_next);
>
> -/**
> - * mas_prev() - Get the previous entry
> - * @mas: The maple state
> - * @min: The minimum value to check.
> - *
> - * Must hold rcu_read_lock or the write lock.
> - * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
> - * searchable nodes.
> - *
> - * Return: the previous value or %NULL.
> - */
> -void *mas_prev(struct ma_state *mas, unsigned long min)
> +static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
> +		void **entry)
>  {
>  	if (mas->index <= min)
>  		goto none;
> @@ -5953,7 +5943,8 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
>  		if (!mas->index)
>  			goto none;
>  		mas->index = mas->last = 0;
> -		return mas_root(mas);
> +		*entry = mas_root(mas);
> +		return true;
>  	}
>
>  	if (mas_is_none(mas)) {
> @@ -5961,18 +5952,64 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
>  			/* Walked to out-of-range pointer? */
>  			mas->index = mas->last = 0;
>  			mas->node = MAS_ROOT;
> -			return mas_root(mas);
> +			*entry = mas_root(mas);
> +			return true;
>  		}
> -		return NULL;
> +		return true;
>  	}
> -	return mas_prev_slot(mas, min, false);
> +
> +	return false;
>
>  none:
>  	mas->node = MAS_NONE;
> -	return NULL;
> +	return true;
> +}
> +
> +/**
> + * mas_prev() - Get the previous entry
> + * @mas: The maple state
> + * @min: The minimum value to check.
> + *
> + * Must hold rcu_read_lock or the write lock.
> + * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
> + * searchable nodes.
> + *
> + * Return: the previous value or %NULL.
> + */
> +void *mas_prev(struct ma_state *mas, unsigned long min)
> +{
> +	void *entry = NULL;
> +
> +	if (mas_prev_setup(mas, min, &entry))
> +		return entry;
> +
> +	return mas_prev_slot(mas, min, false);
>  }
>  EXPORT_SYMBOL_GPL(mas_prev);
>
> +/**
> + * mas_prev_range() - Advance to the previous range
> + * @mas: The maple state
> + * @min: The minimum value to check.
> + *
> + * Sets @mas->index and @mas->last to the range.
> + * Must hold rcu_read_lock or the write lock.
> + * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
> + * searchable nodes.
> + *
> + * Return: the previous value or %NULL.
> + */
> +void *mas_prev_range(struct ma_state *mas, unsigned long min)
> +{
> +	void *entry = NULL;
> +
> +	if (mas_prev_setup(mas, min, &entry))
> +		return entry;
> +
> +	return mas_prev_slot(mas, min, true);
> +}
> +EXPORT_SYMBOL_GPL(mas_prev_slot);

Hi Liam,

I guess you want to export mas_prev_range symbol instead of mas_prev_slot.

> +
>  /**
>   * mt_prev() - get the previous value in the maple tree
>   * @mt: The maple tree
> @@ -6116,20 +6153,15 @@ void *mas_find_range(struct ma_state *mas, unsigned long max)
>  EXPORT_SYMBOL_GPL(mas_find_range);
>
>  /**
> - * mas_find_rev: On the first call, find the first non-null entry at or below
> - * mas->index down to %min.  Otherwise find the first non-null entry below
> - * mas->index down to %min.
> - * @mas: The maple state
> - * @min: The minimum value to check.
> + * mas_find_rev_setup() - Internal function to set up mas_find_*_rev()
>   *
> - * Must hold rcu_read_lock or the write lock.
> - * If an entry exists, last and index are updated accordingly.
> - * May set @mas->node to MAS_NONE.
> - *
> - * Return: The entry or %NULL.
> + * Returns: True if entry is the answer, false otherwise.
>   */
> -void *mas_find_rev(struct ma_state *mas, unsigned long min)
> +static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
> +		void **entry)
>  {
> +	*entry = NULL;
> +
>  	if (unlikely(mas_is_none(mas))) {
>  		if (mas->index <= min)
>  			goto none;
> @@ -6141,7 +6173,7 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
>  	if (unlikely(mas_is_paused(mas))) {
>  		if (unlikely(mas->index <= min)) {
>  			mas->node = MAS_NONE;
> -			return NULL;
> +			return true;
>  		}
>  		mas->node = MAS_START;
>  		mas->last = --mas->index;
> @@ -6149,14 +6181,12 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
>
>  	if (unlikely(mas_is_start(mas))) {
>  		/* First run or continue */
> -		void *entry;
> -
>  		if (mas->index < min)
> -			return NULL;
> +			return true;
>
> -		entry = mas_walk(mas);
> -		if (entry)
> -			return entry;
> +		*entry = mas_walk(mas);
> +		if (*entry)
> +			return true;
>  	}
>
>  	if (unlikely(!mas_searchable(mas))) {
> @@ -6170,22 +6200,72 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
>  			 */
>  			mas->last = mas->index = 0;
>  			mas->node = MAS_ROOT;
> -			return mas_root(mas);
> +			*entry = mas_root(mas);
> +			return true;
>  		}
>  	}
>
>  	if (mas->index < min)
> -		return NULL;
> +		return true;
>
> -	/* Retries on dead nodes handled by mas_prev_slot */
> -	return mas_prev_slot(mas, min, false);
> +	return false;
>
>  none:
>  	mas->node = MAS_NONE;
> -	return NULL;
> +	return true;
> +}
> +
> +/**
> + * mas_find_rev: On the first call, find the first non-null entry at or below
> + * mas->index down to %min.  Otherwise find the first non-null entry below
> + * mas->index down to %min.
> + * @mas: The maple state
> + * @min: The minimum value to check.
> + *
> + * Must hold rcu_read_lock or the write lock.
> + * If an entry exists, last and index are updated accordingly.
> + * May set @mas->node to MAS_NONE.
> + *
> + * Return: The entry or %NULL.
> + */
> +void *mas_find_rev(struct ma_state *mas, unsigned long min)
> +{
> +	void *entry;
> +
> +	if (mas_find_rev_setup(mas, min, &entry))
> +		return entry;
> +
> +	/* Retries on dead nodes handled by mas_prev_slot */
> +	return mas_prev_slot(mas, min, false);
> +
>  }
>  EXPORT_SYMBOL_GPL(mas_find_rev);
>
> +/**
> + * mas_find_range_rev: On the first call, find the first non-null entry at or
> + * below mas->index down to %min.  Otherwise advance to the previous slot after
> + * mas->index down to %min.
> + * @mas: The maple state
> + * @min: The minimum value to check.
> + *
> + * Must hold rcu_read_lock or the write lock.
> + * If an entry exists, last and index are updated accordingly.
> + * May set @mas->node to MAS_NONE.
> + *
> + * Return: The entry or %NULL.
> + */
> +void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
> +{
> +	void *entry;
> +
> +	if (mas_find_rev_setup(mas, min, &entry))
> +		return entry;
> +
> +	/* Retries on dead nodes handled by mas_prev_slot */
> +	return mas_prev_slot(mas, min, true);
> +}
> +EXPORT_SYMBOL_GPL(mas_find_range_rev);
> +
>  /**
>   * mas_erase() - Find the range in which index resides and erase the entire
>   * range.
>
> --
> 2.39.2
>
