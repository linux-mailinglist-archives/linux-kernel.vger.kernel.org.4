Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2833D632E21
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiKUUoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiKUUo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:44:28 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300DBCB979
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:44:27 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id k4so8887944qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLM4dQ8DfOCVp9j2Qcll4uaEz3VQYSBLl74/xIF32d8=;
        b=AM98z3cNsvRELUM5EESx6H5Jini6qLdvb10A63UmI0r9Zvp/b8oQbtmI3aZ7e7mSsZ
         e/GVMo3l2t93qmc9/t6brPu9ki4MVTauqEUdNsjNw/ejYm8W+xXbQjkjGfR9QDheyb20
         aVJZ58rMX1X24kmJBaqderRGLaNMxyLabbGKcs1NVVeCRW1bifK2kK6BE2YFo0z7y+mB
         lD4ltYoyc4GFahO9p0Te/279AoiEvC73qizRw84n3QMJoE2jVdcBEy6A9KHjLXJvWs6I
         wJ8Xjc9YlKRhPq8jyk9jgEvivliKTb8QwC71iuu2mBYS9dfN3yAaLY/ekVjOyzNumZvo
         eW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLM4dQ8DfOCVp9j2Qcll4uaEz3VQYSBLl74/xIF32d8=;
        b=o9PwnYc3lBQOrAoBtNP74wY0Dp29Co8uhhtzf2v3Alvy4zQQtnHm0o7EnsG93WJvUs
         f4RuSheb+7ToZSnNzOABf2KHYHIffGVvRUPAISOsypEI1NFJ5iAT/GR5UO54lve+7WX9
         +oVSTluEwG/oWlwWos1NP+6U6L4wOorRCef2j3Mbnu+v0X27yl2eKxb2VJs0gQh+CdAW
         Nt4naifDBeK05K5DR9C+oZuS8DtUFBPlolRdbDPdbkO5e4ZEoESqkzqEXJFsKlBR8IF2
         DLS8tu4A9r4e3zjNHJYUtNkDXQQM/LZ9y/poNcTuBviPLQpQAHCzvbx2zinlq1dy6Rd6
         kdpw==
X-Gm-Message-State: ANoB5pke/MC0/SxoHxfopOV/u1PaaEm1Fp0HI0tHguGSfp4y79i8bN8n
        4Y0d4MBpBUfFN4RRg3ksT5QvVv7ova6twg==
X-Google-Smtp-Source: AA0mqf4xzKPjIVvSosLQhXCKexOKlCvsdNagXLqURCTkkB6pZlsCkMfyz0dOj1UIOJLpTk7nANYa3w==
X-Received: by 2002:a05:620a:16a7:b0:6ea:3fa0:bbfb with SMTP id s7-20020a05620a16a700b006ea3fa0bbfbmr1185226qkj.473.1669063466320;
        Mon, 21 Nov 2022 12:44:26 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006fba44843a5sm9034117qko.52.2022.11.21.12.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 12:44:25 -0800 (PST)
Date:   Mon, 21 Nov 2022 15:44:51 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, ngupta@vflare.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        ddrokosov@sberdevices.ru
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Message-ID: <Y3vjQ7VJYUEWl2uc@cmpxchg.org>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121190020.66548-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:00:16PM +0300, Alexey Romanov wrote:
> Hello!
> 
> This RFC series adds feature which allows merge identical
> compressed pages into a single one. The main idea is that
> zram only stores object references, which store the compressed
> content of the pages. Thus, the contents of the zsmalloc objects
> don't change in any way.
> 
> For simplicity, let's imagine that 3 pages with the same content
> got into zram:
> 
> +----------------+   +----------------+   +----------------+
> |zram_table_entry|   |zram_table_entry|   |zram_table_entry|
> +-------+--------+   +-------+--------+   +--------+-------+
>         |                    |                     |
>         | handle (1)         | handle (2)          | handle (3)
> +-------v--------+   +-------v---------+  +--------v-------+
> |zsmalloc  object|   |zsmalloc  object |  |zsmalloc  object|
> ++--------------++   +-+-------------+-+  ++--------------++
>  +--------------+      +-------------+     +--------------+
>  | buffer: "abc"|      |buffer: "abc"|     | buffer: "abc"|
>  +--------------+      +-------------+     +--------------+
> 
> As you can see, the data is duplicated. Merge mechanism saves
> (after scanning objects) only one zsmalloc object. Here's
> what happens ater the scan and merge:
> 
> +----------------+   +----------------+   +----------------+
> |zram_table_entry|   |zram_table_entry|   |zram_tabl _entry|
> +-------+--------+   +-------+--------+   +--------+-------+
>         |                    |                     |
>         | handle (1)         | handle (1)          | handle (1)
>         |           +--------v---------+           |
>         +-----------> zsmalloc  object <-----------+
>                     +--+-------------+-+
>                        +-------------+
>                        |buffer: "abc"|
>                        +-------------+
> 
> Thus, we reduced the amount of memory occupied by 3 times.
> 
> This mechanism doesn't affect the perf of the zram itself in
> any way (maybe just a little bit on the zram_free_page function).
> In order to describe each such identical object, we (constantly)
> need sizeof(zram_rbtree_node) bytes. So, for example, if the system
> has 20 identical buffers with a size of 1024, the memory gain will be
> (20 * 1024) - (1 * 1024 + sizeof(zram_rbtree_node)) = 19456 -
> sizeof(zram_rbtree_node) bytes. But, it should be understood, these are
> counts without zsmalloc data structures overhead.
> 
> Testing on my system (8GB ram + 1 gb zram swap) showed that at high 
> loads, on average, when calling the merge mechanism, we can save 
> up to 15-20% of the memory usage.

This looks pretty great.

However, I'm curious why it's specific to zram, and not part of
zsmalloc? That way zswap would benefit as well, without having to
duplicate the implementation. This happened for example with
page_same_filled() and zswap_is_page_same_filled().

It's zsmalloc's job to store content efficiently, so couldn't this
feature (just like the page_same_filled one) be an optimization that
zsmalloc does transparently for all its users?

> This patch serices adds a new sysfs node (trigger merging) and new 
> field in mm_stat (how many pages are merged in zram at the moment):
> 
>   $ cat /sys/block/zram/mm_stat
>     431452160 332984392 339894272 0 339894272 282 0 51374 51374 0
> 
>   $ echo 1 > /sys/block/zram/merge
> 
>   $ cat /sys/block/zram/mm_stat
>     431452160 270376848 287301504 0 339894272 282 0 51374 51374 6593

The optimal frequency for calling this is probably tied to prevalent
memory pressure, which is somewhat tricky to do from userspace.

Would it make sense to hook this up to a shrinker?
