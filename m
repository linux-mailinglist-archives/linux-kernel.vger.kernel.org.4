Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8301C5BD0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiISPYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiISPYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:24:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B074D399E3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:23:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4ECE3220F3;
        Mon, 19 Sep 2022 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663601004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UeQYK9kQcV2lMsWl00jt1CfUO8aglWQ+0Wrli3shIR0=;
        b=ynoRo9QtjqyG0IEWfeb9mwbZY2Uvfp9CsxQkDu3VyXZI1NjKq5m+v/LJ+twe+RQmf2Bfpz
        kOVNgUHkf1Z2Dsc3JbEvi3ZKlJE21nRHI4GDowl9xa3moNQJw2KRr5TvQv7X4963N7ti+P
        /GLafWkaKBngYkdbRSh/Re0EpNiZpcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663601004;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UeQYK9kQcV2lMsWl00jt1CfUO8aglWQ+0Wrli3shIR0=;
        b=Po5nn5dBmvHOF4ihHD4McCHOKM57s6AdB3rZWkEVV0jLW0YFsvcFhcF1ueQfRYtoIDuKWV
        u7/doBcD/UddhcBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1792513A96;
        Mon, 19 Sep 2022 15:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id feHxBGyJKGM7dwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 19 Sep 2022 15:23:24 +0000
Message-ID: <9440ffc2-cfda-ade0-839c-71e9378193fb@suse.cz>
Date:   Mon, 19 Sep 2022 17:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/3] mm,page_owner: Filter out stacks by a threshold
 counter
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
References: <20220905031012.4450-1-osalvador@suse.de>
 <20220905031012.4450-4-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220905031012.4450-4-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 05:10, Oscar Salvador wrote:
> We want to be able to filter out the output on a threshold basis,
> in this way we can get rid of a lot of noise and focus only on those
> stacks which have an allegedly high counter.
> 
> We can control the threshold value by a new file called
> 'page_owner_threshold', which is 0 by default.

The name could suggest it has to do something with "page_owner" but in fact
it only affects "page_owner_stacks".
So maybe "page_owner_stacks_threshold" ? But now it's rather long. Or maybe
"page_owner_stacks_min_count" ? Also long but maybe the most self-evident?

> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/stackdepot.h |  3 ++-
>  lib/stackdepot.c           |  6 +++--
>  mm/page_owner.c            | 51 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 56 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 19d3f8295df8..742038216cd0 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -25,7 +25,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  					gfp_t gfp_flags, bool can_alloc,
>  					enum stack_depot_action action);
>  void stack_depot_dec_count(depot_stack_handle_t handle);
> -int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos);
> +int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos,
> +				       unsigned long threshold);
>  
>  /*
>   * Every user of stack depot has to call stack_depot_init() during its own init
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index a198b2dbe3fb..a31e882853ab 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -566,7 +566,8 @@ depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save_action);
>  
> -int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
> +int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos,
> +				       unsigned long threshold)
>  {
>  	int i = *pos, ret = 0;
>  	struct stack_record **stacks, *stack;
> @@ -585,7 +586,8 @@ int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
>  	for (; stack; stack = stack->next) {
>  		if (!stack->size || stack->size < 0 ||
>  		    stack->size > size || stack->handle.valid != 1 ||
> -		    refcount_read(&stack->count) < 1)
> +		    refcount_read(&stack->count) < 1 ||
> +		    refcount_read(&stack->count) < threshold)
>  			continue;
>  
>  		ret += stack_trace_snprint(buf, size, stack->entries, stack->size, 0);
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index d88e6b4aefa0..5b895d347c5f 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -43,6 +43,8 @@ static depot_stack_handle_t early_handle;
>  
>  static void init_early_allocated_pages(void);
>  
> +static unsigned long threshold;
> +
>  static int __init early_page_owner_param(char *buf)
>  {
>  	int ret = kstrtobool(buf, &page_owner_enabled);
> @@ -675,7 +677,7 @@ static ssize_t read_page_owner_stacks(struct file *file, char __user *buf,
>  	if (!kbuf)
>  		return -ENOMEM;
>  
> -	ret += stack_depot_print_stacks_threshold(kbuf, count, pos);
> +	ret += stack_depot_print_stacks_threshold(kbuf, count, pos, threshold);
>  	if (copy_to_user(buf, kbuf, ret))
>  		ret = -EFAULT;
>  
> @@ -683,6 +685,51 @@ static ssize_t read_page_owner_stacks(struct file *file, char __user *buf,
>  	return ret;
>  }
>  
> +static int page_owner_threshold_show(struct seq_file *p, void *v)
> +{
> +	 seq_printf(p, "%lu\n", threshold);
> +	return 0;
> +}
> +
> +static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
> +					  size_t count, loff_t *pos)
> +{
> +	char *kbuf;
> +	int ret = 0;
> +
> +	count = min_t(size_t, count, PAGE_SIZE);
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(kbuf, buf, count)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	kbuf[count - 1] = '\0';
> +
> +	ret = kstrtoul(kbuf, 10, &threshold);
> +
> +out:
> +	kfree(kbuf);
> +	return ret ? ret : count;
> +}
> +
> +static int open_page_owner_threshold(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, page_owner_threshold_show, NULL);
> +}
> +
> +
> +static const struct file_operations proc_page_owner_threshold = {
> +	.open = open_page_owner_threshold,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.write = write_page_owner_threshold,
> +	.release = single_release,
> +};
> +
>  static const struct file_operations proc_page_owner_stacks = {
>  	.read = read_page_owner_stacks,
>  };
> @@ -702,6 +749,8 @@ static int __init pageowner_init(void)
>  			    &proc_page_owner_operations);
>  	debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
>  			    &proc_page_owner_stacks);
> +	debugfs_create_file("page_owner_threshold", 0600, NULL, NULL,
> +			     &proc_page_owner_threshold);
>  
>  	return 0;
>  }

