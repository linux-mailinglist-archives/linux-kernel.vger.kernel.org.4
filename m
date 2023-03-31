Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689686D287F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjCaTMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaTMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:12:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB9E1D937;
        Fri, 31 Mar 2023 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aIr2vtxWZXcVvuolWsECaIGNyyoIH0TKmMFQt2ZHtZ4=; b=HNVQNzemSOiE9ckS8FRhSJdp0B
        8uSSZZmucZQ0WC2FbkL2MzlHIdavSFgKfeyYJY/ccrIo6hwn6pCXD6GGV/fWZ7Jq9de78TOqC+BoV
        RShWmVWiP90j1Focjbn9XB9eI6Zr8/LwPab2DoUO7X15vAznOgu92JqwtENFhevTaCY4Lf71LxMW8
        mjwZ4JfvO6WRUSX/07K96KYoJEW13NBtC2sDMTHmk0pUrukfBPH0gEO8Q94QQeiIg1cP/jS5Pf3Br
        r0pe6yUJcX2SZLdnclvrCSofF+2TV8s2gB3++lQz2kq8xCybGzHB47tdnuyXXetZ42JXdqUV2JXZs
        BPYuTC3w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1piKAa-008aZa-27;
        Fri, 31 Mar 2023 19:12:16 +0000
Date:   Fri, 31 Mar 2023 12:12:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jim.cromie@gmail.com
Cc:     linux-modules@vger.kernel.org, song@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with
 module_memory")
Message-ID: <ZCcwkCBgyxOgROVu@bombadil.infradead.org>
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
 <ZCaE71aPvvQ/L05L@bombadil.infradead.org>
 <CAJfuBxwng_fB5XH5LEWAWwN29fitGLBZ8hpdW3+4HjO_MDK1Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxwng_fB5XH5LEWAWwN29fitGLBZ8hpdW3+4HjO_MDK1Eg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:08:23AM -0600, jim.cromie@gmail.com wrote:
> :#> uptime
>  09:45:32 up 1 day, 23:07,  0 users,  load average: 0.07, 0.04, 0.01
> :#> uname -a
> Linux (none) 6.3.0-rc1-f2-00001-gac3b43283923 #359 SMP PREEMPT_DYNAMIC
> Wed Mar 29 09:33:11 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux
> 
> the leaks I sent previously might be from/on a different commit,
> heres the relevant one
> 
> fwiw, the config is unremarkable.  it started with
> CONFIG_BUILD_SALT="5.16.8-200.fc35.x86_64"
> then `make localmodconfig` to drop anything I dont have hw for
> then `virtme-configkernel --update` to pick up the 9p,etc config options
> And some extra DEBUG_* options
> If you'd like to see runs with others, or see the config itself, please ask.

If you wanna see things explode

echo 0 > /proc/sys/vm/oom_dump_tasks
./stress-ng --module 20 --module-name xfs

This assumes xfs is not already loaded, and has all dependencies already
loaded. What would test the load_module() path.

If you wanna see if the test is earlier, you can try a module which
is already loaded on your system.

> :#> uname -a
> Linux (none) 6.3.0-rc1-f2-00001-gac3b43283923 #359 SMP PREEMPT_DYNAMIC
> Wed Mar 29 09:33:11 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux
> :#> ./grok_kmemleak -n
> not: bless( {
>   'backtraces' => {
>     '[<0000000058fb276d>] __kmalloc_node_track_caller+0x4a/0x140
>     [<00000000a2f80203>] memdup_user+0x26/0x90
>     [<00000000f7cd3624>] strndup_user+0x3f/0x60
>     [<0000000098fd26c5>] load_module+0x188b/0x20e0

Can you do:

gdb vmlinux
l *(load_module+0x188b)

And provide the output?

> }, 'LeakSet' )
> mods: bless( {
>   'backtraces' => {
>     '[<0000000058fb276d>] __kmalloc_node_track_caller+0x4a/0x140
>     [<00000000ab7b01fd>] kstrdup+0x32/0x60
>     [<000000005ed25b98>] kobject_set_name_vargs+0x1c/0x90
>     [<0000000090fe19ca>] kobject_init_and_add+0x4d/0x90
>     [<0000000045666935>] mod_sysfs_setup+0xa9/0x6e0

Ok that is a specific enough hint. I'll take a review of this sysfs
path see what changed that could break.

>     [<00000000d6f7187b>] load_module+0x1de3/0x20e0
>     [<0000000074361279>] __do_sys_finit_module+0x93/0xf0
>     [<000000004caeb948>] do_syscall_64+0x34/0x80
>     [<000000009f5d036c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' => 16
>   },

  Luis
