Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B64E723592
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjFFDB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjFFDBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5BC11B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686020452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tXRilKkCioEVIALYe5Wf2FsTaWzsIF1KlSEfbrx8r0=;
        b=L6z9pDZzUFeF80UDzgiOEvxJkwOqZgTJNcYLP1C+kVYwwzOdcbThlkZssPvv3fuTH/w1wS
        eyqK7wJf3/nvUPW7/9bq0Csm+TCJO8+13gAdw5u/nWwdwqRDHf97wG/sHTT4nAYu3H+96j
        amNY9ZdsJLDQUSipvilp0uWXUFnDVR0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-kV9wne-1Nd-HevybLW-7ug-1; Mon, 05 Jun 2023 23:00:51 -0400
X-MC-Unique: kV9wne-1Nd-HevybLW-7ug-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75ebcbb8c80so183770685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 20:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686020451; x=1688612451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tXRilKkCioEVIALYe5Wf2FsTaWzsIF1KlSEfbrx8r0=;
        b=RpvQgOw2vmeHENV1rp/996JUsox47Wd8hSSS+mD6wBsMHgR2DQm52RfBv9sNEWbfW3
         iuGDEmNRIGpY9TrFLdFt/QdQDfZe/s+IuNeKSIReeWw7sMn/FRsqeHRzfD5/vbQ6+FlS
         38+Yx0zjUJ+AlkpsnygEwcFFIwwUcLIOz4+JfptzdJr1LMCd9wKZllbTJvLz2ZRJm9nu
         gNC5Rjdf8bRLRnY33DM8tC1G112/sekOn9auF043Gk2aKDzUwTz1peiZYzFBS45aYXGY
         zrgpzi0vBAGUwC2E0Wq4YczzEyA5GN6WQQt6ACnOjp9TitL00UNGeGbTVxtOecpsnHUI
         jmeQ==
X-Gm-Message-State: AC+VfDyGuJ0cX7PYdmYaV8Ir9NR+A6lVximYYPW8SaoJ8xjvY2n/7RFU
        OuZIJiDfXGJ54OQHyTLUPmHifWzObt+0yN4b0m8q6oy1zgPHDP2DzMdCLexFzK7TB5QQIw5/I/m
        QhEUSHcmhpHWTG/5z/+KHX4Ex
X-Received: by 2002:a05:620a:2794:b0:75b:23a1:3616 with SMTP id g20-20020a05620a279400b0075b23a13616mr687800qkp.39.1686020451098;
        Mon, 05 Jun 2023 20:00:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6x/0Cm40AnwLIqaeE+ggEj23Du26bLV9lLIl1Uco/4+LixRC0yQOluK0EdsDvibDengYz/ww==
X-Received: by 2002:a05:620a:2794:b0:75b:23a1:3616 with SMTP id g20-20020a05620a279400b0075b23a13616mr687774qkp.39.1686020450851;
        Mon, 05 Jun 2023 20:00:50 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a784100b0025069c8a151sm6407398pjl.53.2023.06.05.20.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 20:00:50 -0700 (PDT)
Date:   Tue, 6 Jun 2023 10:55:06 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: Re: [RFC v3 07/21] mm: PKRAM: introduce super block
Message-ID: <aee5eximmv33ke26xrodm7tlqwwojalf2lz3zrgkt75bxeuupe@y3t2sfgdcy7k>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <1682554137-13938-8-git-send-email-anthony.yznaga@oracle.com>
 <upgf3qmqxn7xzbnwwt6nxau4ugqkq7szdaheewzbok27xwch4e@6tdnhkqspok4>
 <f287334c-4054-525e-52ea-a0bbf077b653@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f287334c-4054-525e-52ea-a0bbf077b653@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 07:01:56PM -0700, Anthony Yznaga wrote:
>Hi Coiby,
>
>On 6/4/23 7:40 PM, Coiby Xu wrote:
>>Hi Anthony,
>>
>>On Wed, Apr 26, 2023 at 05:08:43PM -0700, Anthony Yznaga wrote:
>>>The PKRAM super block is the starting point for restoring preserved
>>>memory. By providing the super block to the new kernel at boot time,
>>>preserved memory can be reserved and made available to be restored.
>>>To point the kernel to the location of the super block, one passes
>>>its pfn via the 'pkram' boot param.
>>
>>I'm curious to ask how will the 'pkram' boot param be passed. It seems I
>>can't find the answer in this patch set.
>
>The pfn of the super block read from /sys/kernel/pkram is passed to
>
>the next kernel by adding the boot parameter, pkram=<super block pfn>.
>
>The next kernel picks it up through the early_param("pkram", 
>parse_pkram_sb_pfn)
>
>in this patch below.

Thanks for the explanation! Sorry I didn't make my question clear. I
should have asked who is going to read /sys/kernel/pkram how this pkram
boot parameter will be added for the next kernel.

>
>
>Anthony
>
>
>>
>>
>>>For that purpose, the pkram super
>>>block pfn is exported via /sys/kernel/pkram. If none is passed, any
>>>preserved memory will not be kept, and a new super block will be
>>>allocated.
>>>
>>>Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
>>>Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>>>---
>>>mm/pkram.c | 102 
>>>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>>1 file changed, 100 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/mm/pkram.c b/mm/pkram.c
>>>index da166cb6afb7..c66b2ae4d520 100644
>>>--- a/mm/pkram.c
>>>+++ b/mm/pkram.c
>>>@@ -5,15 +5,18 @@
>>>#include <linux/init.h>
>>>#include <linux/io.h>
>>>#include <linux/kernel.h>
>>>+#include <linux/kobject.h>
>>>#include <linux/list.h>
>>>#include <linux/mm.h>
>>>#include <linux/module.h>
>>>#include <linux/mutex.h>
>>>#include <linux/notifier.h>
>>>+#include <linux/pfn.h>
>>>#include <linux/pkram.h>
>>>#include <linux/reboot.h>
>>>#include <linux/sched.h>
>>>#include <linux/string.h>
>>>+#include <linux/sysfs.h>
>>>#include <linux/types.h>
>>>
>>>#include "internal.h"
>>>@@ -82,12 +85,38 @@ struct pkram_node {
>>>#define PKRAM_ACCMODE_MASK    3
>>>
>>>/*
>>>+ * The PKRAM super block contains data needed to restore the 
>>>preserved memory
>>>+ * structure on boot. The pointer to it (pfn) should be passed 
>>>via the 'pkram'
>>>+ * boot param if one wants to restore preserved data saved by the 
>>>previously
>>>+ * executing kernel. For that purpose the kernel exports the pfn via
>>>+ * /sys/kernel/pkram. If none is passed, preserved memory if any 
>>>will not be
>>>+ * preserved and a new clean page will be allocated for the super 
>>>block.
>>>+ *
>>>+ * The structure occupies a memory page.
>>>+ */
>>>+struct pkram_super_block {
>>>+    __u64    node_pfn;        /* first element of the node list */
>>>+};
>>>+
>>>+static unsigned long pkram_sb_pfn __initdata;
>>>+static struct pkram_super_block *pkram_sb;
>>>+
>>>+/*
>>> * For convenience sake PKRAM nodes are kept in an auxiliary 
>>>doubly-linked list
>>> * connected through the lru field of the page struct.
>>> */
>>>static LIST_HEAD(pkram_nodes);            /* linked through page::lru */
>>>static DEFINE_MUTEX(pkram_mutex);        /* serializes open/close */
>>>
>>>+/*
>>>+ * The PKRAM super block pfn, see above.
>>>+ */
>>>+static int __init parse_pkram_sb_pfn(char *arg)
>>>+{
>>>+    return kstrtoul(arg, 16, &pkram_sb_pfn);
>>>+}
>>>+early_param("pkram", parse_pkram_sb_pfn);
>>>+
>>>static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
>>>{
>>>    return alloc_page(gfp_mask);
>>>@@ -270,6 +299,7 @@ static void pkram_stream_init(struct 
>>>pkram_stream *ps,
>>> * @gfp_mask specifies the memory allocation mask to be used when 
>>>saving data.
>>> *
>>> * Error values:
>>>+ *    %ENODEV: PKRAM not available
>>> *    %ENAMETOOLONG: name len >= PKRAM_NAME_MAX
>>> *    %ENOMEM: insufficient memory available
>>> *    %EEXIST: node with specified name already exists
>>>@@ -285,6 +315,9 @@ int pkram_prepare_save(struct pkram_stream 
>>>*ps, const char *name, gfp_t gfp_mask
>>>    struct pkram_node *node;
>>>    int err = 0;
>>>
>>>+    if (!pkram_sb)
>>>+        return -ENODEV;
>>>+
>>>    if (strlen(name) >= PKRAM_NAME_MAX)
>>>        return -ENAMETOOLONG;
>>>
>>>@@ -404,6 +437,7 @@ void pkram_discard_save(struct pkram_stream *ps)
>>> * Returns 0 on success, -errno on failure.
>>> *
>>> * Error values:
>>>+ *    %ENODEV: PKRAM not available
>>> *    %ENOENT: node with specified name does not exist
>>> *    %EBUSY: save to required node has not finished yet
>>> *
>>>@@ -414,6 +448,9 @@ int pkram_prepare_load(struct pkram_stream 
>>>*ps, const char *name)
>>>    struct pkram_node *node;
>>>    int err = 0;
>>>
>>>+    if (!pkram_sb)
>>>+        return -ENODEV;
>>>+
>>>    mutex_lock(&pkram_mutex);
>>>    node = pkram_find_node(name);
>>>    if (!node) {
>>>@@ -825,6 +862,13 @@ static void __pkram_reboot(void)
>>>        node->node_pfn = node_pfn;
>>>        node_pfn = page_to_pfn(page);
>>>    }
>>>+
>>>+    /*
>>>+     * Zero out pkram_sb completely since it may have been passed from
>>>+     * the previous boot.
>>>+     */
>>>+    memset(pkram_sb, 0, PAGE_SIZE);
>>>+    pkram_sb->node_pfn = node_pfn;
>>>}
>>>
>>>static int pkram_reboot(struct notifier_block *notifier,
>>>@@ -832,7 +876,8 @@ static int pkram_reboot(struct notifier_block 
>>>*notifier,
>>>{
>>>    if (val != SYS_RESTART)
>>>        return NOTIFY_DONE;
>>>-    __pkram_reboot();
>>>+    if (pkram_sb)
>>>+        __pkram_reboot();
>>>    return NOTIFY_OK;
>>>}
>>>
>>>@@ -840,9 +885,62 @@ static int pkram_reboot(struct notifier_block 
>>>*notifier,
>>>    .notifier_call = pkram_reboot,
>>>};
>>>
>>>+static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
>>>+        struct kobj_attribute *attr, char *buf)
>>>+{
>>>+    unsigned long pfn = pkram_sb ? PFN_DOWN(__pa(pkram_sb)) : 0;
>>>+
>>>+    return sprintf(buf, "%lx\n", pfn);
>>>+}
>>>+
>>>+static struct kobj_attribute pkram_sb_pfn_attr =
>>>+    __ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
>>>+
>>>+static struct attribute *pkram_attrs[] = {
>>>+    &pkram_sb_pfn_attr.attr,
>>>+    NULL,
>>>+};
>>>+
>>>+static struct attribute_group pkram_attr_group = {
>>>+    .attrs = pkram_attrs,
>>>+};
>>>+
>>>+/* returns non-zero on success */
>>>+static int __init pkram_init_sb(void)
>>>+{
>>>+    unsigned long pfn;
>>>+    struct pkram_node *node;
>>>+
>>>+    if (!pkram_sb) {
>>>+        struct page *page;
>>>+
>>>+        page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
>>>+        if (!page) {
>>>+            pr_err("PKRAM: Failed to allocate super block\n");
>>>+            return 0;
>>>+        }
>>>+        pkram_sb = page_address(page);
>>>+    }
>>>+
>>>+    /*
>>>+     * Build auxiliary doubly-linked list of nodes connected through
>>>+     * page::lru for convenience sake.
>>>+     */
>>>+    pfn = pkram_sb->node_pfn;
>>>+    while (pfn) {
>>>+        node = pfn_to_kaddr(pfn);
>>>+        pkram_insert_node(node);
>>>+        pfn = node->node_pfn;
>>>+    }
>>>+    return 1;
>>>+}
>>>+
>>>static int __init pkram_init(void)
>>>{
>>>-    register_reboot_notifier(&pkram_reboot_notifier);
>>>+    if (pkram_init_sb()) {
>>>+        register_reboot_notifier(&pkram_reboot_notifier);
>>>+        sysfs_update_group(kernel_kobj, &pkram_attr_group);
>>>+    }
>>>    return 0;
>>>}
>>>module_init(pkram_init);
>>>-- 
>>>1.9.4
>>>
>>>
>>>_______________________________________________
>>>kexec mailing list
>>>kexec@lists.infradead.org
>>>http://lists.infradead.org/mailman/listinfo/kexec
>>>
>>
>

-- 
Best regards,
Coiby

