Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8325D5FAA26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJKBde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiJKBd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:33:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966AA7DF41;
        Mon, 10 Oct 2022 18:33:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s10so15122546ljp.5;
        Mon, 10 Oct 2022 18:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=20onCpfWpwkHM6YrH8+6NcOzMR0zA9uR0cJi6DXMSdc=;
        b=pQkoFcsZDJH0Kh/HwwTAZAl8UOddRp0WjCd+gy1m0rYnrMV4AaFygOjukdhF/v7gLX
         f8ypt1hxNz3Ia26Nbe+JdfgE3KrxXHVtjyNdfgegBzDQyoryG7V1QIpV8GDx8phGPeMW
         Lctt1vtfSaImLEdQ5nwbnwj/ucUJyRWEbLAsS8XgYBysPI3zAnpXk6IyhDYWwk9TV6Ne
         HhbMNzhfny3ittE9/HV7d4edRAEuk2dZJ8BXqRfk7Z1dGGKg0lTAwhh/AicTxapzQdWB
         wZRDEl01AApLxLqqfp13QR7sp6bNf2FG0viWFYysDcZEBz/MA06Pf9TLsQg1tr+pSij3
         8Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20onCpfWpwkHM6YrH8+6NcOzMR0zA9uR0cJi6DXMSdc=;
        b=JWxs+vFTOASNiRHYFaC7hp2sugpmvYFrDvWo8iVBHNyiyxx+8MVKEYZ4yXGXXw+Ufg
         Guq1TfUEEGZQXX46VfUfNxp5qv9hbv8gwvfgMLOczklnNruyQb3s/+NfBR31z8TKVw7L
         O5/LlEF6IpWOfgMogZqmYxuTPkT0xbE+Bdo5y4cZUXIpkcxaSjB1tf/LxiIGtxrES/0Q
         DX5JtSbk2+teKEmrSJRJqYQUiIp+1Fhr/0Gco+tUPOpdABwIbou3deMdJz4egIsTzf+2
         kH2opVkoI5APOhFgmZp+exK1t8vSDf2ikgoxVNJWQHDjO+ma23+cpkfbBg/kK/9CJtz1
         B7QQ==
X-Gm-Message-State: ACrzQf2xGLsv5KnGz/iZo0oja8RnoA1fggjJdVmc5VPO2A0cPNx9rRgL
        zkuFCL2BIMhWYE0ZLt71R43J4XQTvXVdpHC9KypK72xo
X-Google-Smtp-Source: AMsMyM5CBoH69E1efKQZxQCb5VUFqNR+4VM/PnIu9bqO97LTXx5cOLXLgz1hWviGI3+GKKp1SFpQ2njFahl0chLbwuM=
X-Received: by 2002:a05:651c:222c:b0:26b:dec5:a4f0 with SMTP id
 y44-20020a05651c222c00b0026bdec5a4f0mr8460069ljq.359.1665452002769; Mon, 10
 Oct 2022 18:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <1665450964-27487-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1665450964-27487-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 11 Oct 2022 09:32:53 +0800
Message-ID: <CAGWkznHd4WHpeR5HQrV9=XRpU7etB3qN_H26STTQnnYaXFOjJw@mail.gmail.com>
Subject: Re: [Resend PATCH] mm: use stack_depot for recording kmemleak's backtrace
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can account and sort the output via backtrace under this change

On Tue, Oct 11, 2022 at 9:18 AM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Using stack_depot to record kmemleak's backtrace which has been implemented
> on slub for reducing redundant information.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/kmemleak.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 1eddc01..c9cee3a 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -79,6 +79,7 @@
>  #include <linux/mutex.h>
>  #include <linux/rcupdate.h>
>  #include <linux/stacktrace.h>
> +#include <linux/stackdepot.h>
>  #include <linux/cache.h>
>  #include <linux/percpu.h>
>  #include <linux/memblock.h>
> @@ -159,8 +160,7 @@ struct kmemleak_object {
>         u32 checksum;
>         /* memory ranges to be scanned inside an object (empty for all) */
>         struct hlist_head area_list;
> -       unsigned long trace[MAX_TRACE];
> -       unsigned int trace_len;
> +       depot_stack_handle_t trace_handle;
>         unsigned long jiffies;          /* creation timestamp */
>         pid_t pid;                      /* pid of the current task */
>         char comm[TASK_COMM_LEN];       /* executable name */
> @@ -346,8 +346,11 @@ static void print_unreferenced(struct seq_file *seq,
>                                struct kmemleak_object *object)
>  {
>         int i;
> +       unsigned long *entries;
> +       unsigned int nr_entries;
>         unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
>
> +       nr_entries = stack_depot_fetch(object->trace_handle, &entries);
>         warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
>                    object->pointer, object->size);
>         warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
> @@ -356,10 +359,10 @@ static void print_unreferenced(struct seq_file *seq,
>         hex_dump_object(seq, object);
>         warn_or_seq_printf(seq, "  backtrace:\n");
>
> -       for (i = 0; i < object->trace_len; i++) {
> -               void *ptr = (void *)object->trace[i];
> -               warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
> -       }
> +       for (i = 0; i < nr_entries; i++) {
> +               void *ptr = (void *)entries[i];
> +               warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
> +       }
>  }
>
>  /*
> @@ -378,7 +381,8 @@ static void dump_object_info(struct kmemleak_object *object)
>         pr_notice("  flags = 0x%x\n", object->flags);
>         pr_notice("  checksum = %u\n", object->checksum);
>         pr_notice("  backtrace:\n");
> -       stack_trace_print(object->trace, object->trace_len, 4);
> +       if(object->trace_handle)
> +               stack_depot_print(object->trace_handle);
>  }
>
>  /*
> @@ -591,6 +595,25 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
>         return object;
>  }
>
> +#ifdef CONFIG_STACKDEPOT
> +static noinline depot_stack_handle_t set_track_prepare(void)
> +{
> +       depot_stack_handle_t trace_handle;
> +       unsigned long entries[MAX_TRACE];
> +       unsigned int nr_entries;
> +
> +       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> +       trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> +
> +       return trace_handle;
> +}
> +#else
> +static inline depot_stack_handle_t set_track_prepare(void)
> +{
> +       return 0;
> +}
> +#endif
> +
>  /*
>   * Save stack trace to the given array of MAX_TRACE size.
>   */
> @@ -654,7 +677,7 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
>         }
>
>         /* kernel backtrace */
> -       object->trace_len = __save_stack_trace(object->trace);
> +       object->trace_handle = set_track_prepare();
>
>         raw_spin_lock_irqsave(&kmemleak_lock, flags);
>
> @@ -694,7 +717,6 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
>         rb_link_node(&object->rb_node, rb_parent, link);
>         rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
>                                           &object_tree_root);
> -
>         list_add_tail_rcu(&object->object_list, &object_list);
>  out:
>         raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> @@ -1094,7 +1116,7 @@ void __ref kmemleak_update_trace(const void *ptr)
>         }
>
>         raw_spin_lock_irqsave(&object->lock, flags);
> -       object->trace_len = __save_stack_trace(object->trace);
> +       object->trace_handle = set_track_prepare();
>         raw_spin_unlock_irqrestore(&object->lock, flags);
>
>         put_object(object);
> @@ -2064,6 +2086,7 @@ void __init kmemleak_init(void)
>         if (kmemleak_error)
>                 return;
>
> +       stack_depot_init();
>         jiffies_min_age = msecs_to_jiffies(MSECS_MIN_AGE);
>         jiffies_scan_wait = msecs_to_jiffies(SECS_SCAN_WAIT * 1000);
>
> --
> 1.9.1
>
