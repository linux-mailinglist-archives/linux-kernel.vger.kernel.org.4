Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4B5EBC08
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiI0HyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiI0Hxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:53:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F001DABD4A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:53:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s10so10012431ljp.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fCrqRcV7G/sjbNI6P8niqdBkP4gMXK4VMMCcmiA7sPg=;
        b=JADivrkRUpO0XY1CxxQfSgII2kIRlIJXFRGKLRAF6NHVGteZmPZqJBhJKjZR0ju/VB
         /tQFg3mH3bbwuWkHmKnI8jWikLmj282DTeSPeC3BGYxuJFk6qfT1nUDC8/aadpm07NmY
         DnqxuiWtqxOQCupuEXT7DdXlFNe+Tp66FMj0nldEeQS9O+FUK75bt0SzLF4ezNCRU/6w
         qPF1eo7ddWGVKk1uoiF8A6sjGQh0svOP8mj+8/TJ/b8ErhDcGED+6ze6ujhZSnadHak+
         YSdFWX/JpN4AWgfDG0ZGbvnPptcgU2zVTsthb3ctKFUYjBJx8y6PiJrZ5Q2aeO7zXYSv
         iDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fCrqRcV7G/sjbNI6P8niqdBkP4gMXK4VMMCcmiA7sPg=;
        b=nX69jd72XiQd+6UOxqpGVTMybcu+Da8iAlakL1QhLONIVwdCNt6bePRcOhstSUDe/0
         EHY1E+gteb7y9TunDGAtIPVkuyEkkrbNCPxQU/ZRH2eRDeqe9ShU09MNnL4wcN0kNox6
         PIJKGzp6o5OzEYHp9jgjqG5ORj1Z0duJefkXJuAxG8jplml519mEC9vnB2DvZBsVxAAC
         lhGTbxvGEuwG+QfJMJPu5wsIJvjmm7nQKYPXubxfRze0Vz//vXgHRavjroiPBQbZwv5N
         MEnFKsWjdHW0i32vKKBAyv7e3cW22RsN9kDlbUxYgVWvGgru/vB97ZFdnFNYbELl1jQF
         q0vA==
X-Gm-Message-State: ACrzQf1tV7rJn4k/lZCDoj7UWPJwQG3ylt58QJJdrTSp4w5G4lVxnXxT
        KfgES+MEZHotoNjFavZcU5SAphcr7VNK6N+O+wU=
X-Google-Smtp-Source: AMsMyM6LMLiScNE6fMnm043zo3E5rs9pKqQcEYWYSelypaWNf4CT3EFZpHdXAjKrVHA5wOz6wlpZ2ogv/YgLbLX6dtc=
X-Received: by 2002:a2e:b009:0:b0:26c:3fba:c3b8 with SMTP id
 y9-20020a2eb009000000b0026c3fbac3b8mr9274081ljk.114.1664265225115; Tue, 27
 Sep 2022 00:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <1664264570-3716-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1664264570-3716-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 27 Sep 2022 15:53:16 +0800
Message-ID: <CAGWkznEvECnq3uhRvpTZdzp1BE-1gGEdhca6E4BU7R+b-s-StA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: sort kmemleak object via backtrace
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com
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

I am also working on introduce these set of method on SLAB_STORE_USER
which could save a certain amount of memory for slub debug

On Tue, Sep 27, 2022 at 3:46 PM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Kmemleak objects are reported each which could produce lot of redundant
> backtrace informations. introduce a set of method to establish a hash
> tree to sort the objects according to backtrace.
>
> results:
> [  579.075111]c6 [ T5491] kmemleak: unreferenced object 0xffffff80badd9e00 (size 128):
> [  579.082734]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892470
> [  579.096837]c6 [ T5491] kmemleak: unreferenced object 0xffffff80badd9d00 (size 128):
> [  579.104435]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892470
> [  579.118563]c6 [ T5491] kmemleak: unreferenced object 0xffffff80baddce80 (size 128):
> [  579.126201]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892470
> [  579.140303]c6 [ T5491] kmemleak: unreferenced object 0xffffff80baddcb00 (size 128):
> [  579.147906]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892470
> [  579.162032]c6 [ T5491] kmemleak: unreferenced object 0xffffff80bae74a80 (size 128):
> [  579.169661]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892470
> [  579.183775]c6 [ T5491] kmemleak: unreferenced object 0xffffff80bae74100 (size 128):
> [  579.191374]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892471
> [  579.205486]c6 [ T5491] kmemleak: unreferenced object 0xffffff80bae75880 (size 128):
> [  579.213127]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892471
> [  579.227743]c6 [ T5491] kmemleak:   backtrace:
> [  579.232109]c6 [ T5491] kmemleak:     [<0000000066492d96>] __kmalloc_track_caller+0x1d4/0x3e0
> [  579.240506]c6 [ T5491] kmemleak:     [<00000000e5400df8>] kstrdup_const+0x6c/0xa4
> [  579.247930]c6 [ T5491] kmemleak:     [<00000000d7843951>] __kernfs_new_node+0x5c/0x1dc
> [  579.255830]c6 [ T5491] kmemleak:     [<0000000073b5a7bd>] kernfs_new_node+0x60/0xc4
> [  579.263436]c6 [ T5491] kmemleak:     [<000000002c7a48d5>] __kernfs_create_file+0x60/0xfc
> [  579.271485]c6 [ T5491] kmemleak:     [<00000000260ae4a1>] cgroup_addrm_files+0x244/0x4b0
> [  579.279534]c6 [ T5491] kmemleak:     [<00000000ec6bce51>] css_populate_dir+0xb4/0x13c
> [  579.287324]c6 [ T5491] kmemleak:     [<000000005913d698>] cgroup_mkdir+0x1e0/0x31c
> [  579.294859]c6 [ T5491] kmemleak:     [<0000000052605ead>] kernfs_iop_mkdir.llvm.8836999160598622324+0xb0/0x168
> [  579.304817]c6 [ T5491] kmemleak:     [<0000000009665bc4>] vfs_mkdir+0xec/0x170
> [  579.311990]c6 [ T5491] kmemleak:     [<000000003c9c94c1>] do_mkdirat+0xa4/0x168
> [  579.319279]c6 [ T5491] kmemleak:     [<000000005dd5be19>] __arm64_sys_mkdirat+0x28/0x38
> [  579.327242]c6 [ T5491] kmemleak:     [<000000005a0b9381>] el0_svc_common+0xb4/0x188
> [  579.334868]c6 [ T5491] kmemleak:     [<0000000063586a51>] el0_svc_handler+0x2c/0x3c
> [  579.342472]c6 [ T5491] kmemleak:     [<00000000edfd67aa>] el0_svc+0x8/0x100
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/kmemleak.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 1eddc01..34134e5 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -102,6 +102,8 @@
>  #include <linux/kfence.h>
>  #include <linux/kmemleak.h>
>  #include <linux/memory_hotplug.h>
> +#include <linux/jhash.h>
> +#include <linux/random.h>
>
>  /*
>   * Kmemleak configuration and common defines.
> @@ -143,6 +145,7 @@ struct kmemleak_object {
>         unsigned int flags;             /* object status flags */
>         struct list_head object_list;
>         struct list_head gray_list;
> +       struct list_head report_list;
>         struct rb_node rb_node;
>         struct rcu_head rcu;            /* object_list lockless traversal */
>         /* object usage count; object freed when use_count == 0 */
> @@ -161,11 +164,18 @@ struct kmemleak_object {
>         struct hlist_head area_list;
>         unsigned long trace[MAX_TRACE];
>         unsigned int trace_len;
> +       u32 trace_hash;
>         unsigned long jiffies;          /* creation timestamp */
>         pid_t pid;                      /* pid of the current task */
>         char comm[TASK_COMM_LEN];       /* executable name */
>  };
>
> +struct kmemleak_report {
> +       u32 trace_hash;
> +       struct list_head report_list_head;
> +       struct rb_node rb_node_report;
> +       struct list_head *report_pos;
> +};
>  /* flag representing the memory block allocation status */
>  #define OBJECT_ALLOCATED       (1 << 0)
>  /* flag set after the first reporting of an unreference object */
> @@ -195,10 +205,13 @@ struct kmemleak_object {
>  static struct kmemleak_object mem_pool[CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE];
>  static int mem_pool_free_count = ARRAY_SIZE(mem_pool);
>  static LIST_HEAD(mem_pool_free_list);
> +static struct kmemleak_report kr_pool[CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE];
> +static int kr_pool_free_count = ARRAY_SIZE(kr_pool);
>  /* search tree for object boundaries */
>  static struct rb_root object_tree_root = RB_ROOT;
>  /* search tree for object (with OBJECT_PHYS flag) boundaries */
>  static struct rb_root object_phys_tree_root = RB_ROOT;
> +static struct rb_root object_report_tree_root = RB_ROOT;
>  /* protecting the access to object_list, object_tree_root (or object_phys_tree_root) */
>  static DEFINE_RAW_SPINLOCK(kmemleak_lock);
>
> @@ -241,6 +254,7 @@ struct kmemleak_object {
>
>  static void kmemleak_disable(void);
>
> +static u32 trace_seed;
>  /*
>   * Print a warning and dump the stack trace.
>   */
> @@ -423,6 +437,46 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
>         return __lookup_object(ptr, alias, false);
>  }
>
> +void print_unreferenced_object_list(struct seq_file *seq)
> +{
> +       unsigned long flags;
> +       struct kmemleak_object *object;
> +       struct kmemleak_report *object_report;
> +       int i;
> +       struct rb_node *rb;
> +       bool reported_flag = false;
> +
> +       rcu_read_lock();
> +       raw_spin_lock_irqsave(&kmemleak_lock, flags);
> +       for (rb = rb_first(&object_report_tree_root); rb; rb = rb_next(rb)) {
> +               object_report = rb_entry(rb, struct kmemleak_report, rb_node_report);
> +               if (object_report && !list_empty(&object_report->report_list_head)) {
> +                       list_for_each_entry_rcu(object, &object_report->report_list_head, report_list) {
> +                               raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> +                               raw_spin_lock_irqsave(&kmemleak_lock, flags);
> +                               if (unreferenced_object(object) &&
> +                                               (object->flags & OBJECT_REPORTED)) {
> +                                       reported_flag = true;
> +                                       warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
> +                                                       object->pointer, object->size);
> +                                       warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
> +                                                       object->comm, object->pid, object->jiffies);
> +                               }
> +                       }
> +                       if (reported_flag) {
> +                               warn_or_seq_printf(seq, "  backtrace:\n");
> +                               object = list_prev_entry(object, report_list);
> +                               for (i = 0; i < object->trace_len; i++) {
> +                                       void *ptr = (void *)object->trace[i];
> +                                       warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
> +                               }
> +                               reported_flag = false;
> +                       }
> +               }
> +       }
> +       raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> +       rcu_read_unlock();
> +}
>  /*
>   * Increment the object use_count. Return 1 if successful or 0 otherwise. Note
>   * that once an object's use_count reached 0, the RCU freeing was already
> @@ -568,6 +622,7 @@ static void __remove_object(struct kmemleak_object *object)
>                                    &object_phys_tree_root :
>                                    &object_tree_root);
>         list_del_rcu(&object->object_list);
> +       list_del_rcu(&object->report_list);
>  }
>
>  /*
> @@ -610,9 +665,11 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
>  {
>         unsigned long flags;
>         struct kmemleak_object *object, *parent;
> +       struct kmemleak_report *report, *report_parent;
>         struct rb_node **link, *rb_parent;
>         unsigned long untagged_ptr;
>         unsigned long untagged_objp;
> +       u32 trace_hash;
>
>         object = mem_pool_alloc(gfp);
>         if (!object) {
> @@ -623,6 +680,7 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
>
>         INIT_LIST_HEAD(&object->object_list);
>         INIT_LIST_HEAD(&object->gray_list);
> +       INIT_LIST_HEAD(&object->report_list);
>         INIT_HLIST_HEAD(&object->area_list);
>         raw_spin_lock_init(&object->lock);
>         atomic_set(&object->use_count, 1);
> @@ -655,6 +713,7 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
>
>         /* kernel backtrace */
>         object->trace_len = __save_stack_trace(object->trace);
> +       object->trace_hash = jhash2((const u32 *)object->trace, object->trace_len / sizeof(u32), trace_seed);
>
>         raw_spin_lock_irqsave(&kmemleak_lock, flags);
>
> @@ -694,8 +753,42 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
>         rb_link_node(&object->rb_node, rb_parent, link);
>         rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
>                                           &object_tree_root);
> -
>         list_add_tail_rcu(&object->object_list, &object_list);
> +
> +       raw_spin_lock_irqsave(&kmemleak_lock, flags);
> +       link = &object_report_tree_root.rb_node;
> +       rb_parent = NULL;
> +       while (*link) {
> +               raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> +               raw_spin_lock_irqsave(&kmemleak_lock, flags);
> +               rb_parent = *link;
> +               report_parent = rb_entry(rb_parent, struct kmemleak_report, rb_node_report);
> +               trace_hash = report_parent->trace_hash;
> +               if (object->trace_hash < trace_hash)
> +                       link = &report_parent->rb_node_report.rb_left;
> +               else if (trace_hash < object->trace_hash)
> +                       link = &report_parent->rb_node_report.rb_right;
> +               else {
> +                       list_add_tail_rcu(&object->report_list, &report_parent->report_list_head);
> +                       goto out;
> +               }
> +       }
> +       report = kr_pool_free_count ? &kr_pool[--kr_pool_free_count] : NULL;
> +       if (!report)
> +               goto out;
> +       report->trace_hash = object->trace_hash;
> +       /*
> +        * report is the 1st node represent this trace_hash, init its list_head and
> +        * insert it to object_report_tree_root
> +        */
> +       INIT_LIST_HEAD(&report->report_list_head);
> +       /* record 1st object to the list*/
> +       list_add_tail_rcu(&object->report_list, &report->report_list_head);
> +       /* initialize the report_pos as report_list_head*/
> +       report->report_pos = &report->report_list_head;
> +       /* add the node to rb tree*/
> +       rb_link_node(&report->rb_node_report, rb_parent, link);
> +       rb_insert_color(&report->rb_node_report, &object_report_tree_root);
>  out:
>         raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
>         return object;
> @@ -1947,6 +2040,8 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
>                 kmemleak_scan();
>         else if (strncmp(buf, "dump=", 5) == 0)
>                 ret = dump_str_object_info(buf + 5);
> +       else if (strncmp(buf, "report", 6) == 0)
> +               print_unreferenced_object_list(NULL);
>         else
>                 ret = -EINVAL;
>
> @@ -2080,6 +2175,7 @@ void __init kmemleak_init(void)
>                 create_object((unsigned long)__start_ro_after_init,
>                               __end_ro_after_init - __start_ro_after_init,
>                               KMEMLEAK_GREY, GFP_ATOMIC);
> +       get_random_bytes(&trace_seed, 4);
>  }
>
>  /*
> --
> 1.9.1
>
