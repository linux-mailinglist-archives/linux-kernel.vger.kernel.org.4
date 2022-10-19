Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E207604920
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiJSOWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiJSOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEBE1B94D0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666188241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LA6Cza3pSGpXKVU6F+S8U8JWg8ZovqHMMGY0EaLCBBg=;
        b=UW7ET9xBvD15p++wo9uhWh9knd7dmjoDXYiDkaAGQ/D4eqLsPnf8WG5J9Weu/lo3ebAZeA
        NewEXm6tRCWlBedP+Rr+q7g82eYwFBLYk9dWro3SrMAPU78vfDsud39ZA+YBOiF80NEcMk
        U+Bt9ICuuOPQB/9JgzzcUsBCDoUFCVk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-118--ccvQqyhObugGmWsRnN6ow-1; Wed, 19 Oct 2022 04:42:22 -0400
X-MC-Unique: -ccvQqyhObugGmWsRnN6ow-1
Received: by mail-pl1-f200.google.com with SMTP id y1-20020a17090322c100b001853a004c1bso10832119plg.19
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LA6Cza3pSGpXKVU6F+S8U8JWg8ZovqHMMGY0EaLCBBg=;
        b=7Gw0xLaj9d7MxEMKFVSAxufCvnuNoZKybGqaLb9ms35PMHVeGG/P7D857beepaomhD
         rYIBfxYY5Lx//WKkn8huBsTxCvopghz03ZOmZesHzTvoYsjXxLDtt0tKxdfDBtje+DSv
         6RMHM1yWanEODbIh5su6bHANa/rKBl01dLoOcqAIzaF2gR0pE68lsCgMV1MHa2q2Yst4
         MkHUetoX4AgYVSRFqpJRcXEBD7ROCix+WYuoD4Cd3vDFa1DV/ut7zF54AOd3y6cLxiPe
         +L5HYzuoneVI8K8PJr+ISBXhDiOtkCOMj+tFxPCFJV2A4owyS5sfikQ3M+qBnIMc9pcv
         yzug==
X-Gm-Message-State: ACrzQf3xcop5XF4Zxx17WQCcVp52ykV/YibSuzqrHfqlJuqnG4AxAbKs
        ZDzTAS9MjNXImvlwS5R364TKkN7DcZ96sAY6dXpgpho5Jt9MMG6oPl2O+6cSWgLWsq94zHh89fp
        lUMpbBuWfF9q3CODNJddhKOscRcUWXM3Fjs8TCLLY
X-Received: by 2002:a17:90b:4b41:b0:20a:fe8f:5a3 with SMTP id mi1-20020a17090b4b4100b0020afe8f05a3mr43848754pjb.120.1666168941128;
        Wed, 19 Oct 2022 01:42:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6FuVvfJ4E95k0X9Xk8r9zpE8dH9chRXdFCbAhrjjTZD6cYyig2V8giEmVJuPpTRlj8KdTBtxBPT1gpaqW0jcs=
X-Received: by 2002:a17:90b:4b41:b0:20a:fe8f:5a3 with SMTP id
 mi1-20020a17090b4b4100b0020afe8f05a3mr43848724pjb.120.1666168940805; Wed, 19
 Oct 2022 01:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221019025710.2482945-1-gongruiqi1@huawei.com>
In-Reply-To: <20221019025710.2482945-1-gongruiqi1@huawei.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Oct 2022 10:42:07 +0200
Message-ID: <CAFqZXNuyiYEizcPrjCVE=e6bdH9fA0ffAn6VtJswP9JLboGUTw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use GFP_ATOMIC in convert_context()
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 4:56 AM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
>
> The following warning was triggered on a hardware environment:
>
>   SELinux: Converting 162 SID table entries...
>   BUG: sleeping function called from invalid context at __might_sleep+0x60/0x74 0x0
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 5943, name: tar
>   CPU: 7 PID: 5943 Comm: tar Tainted: P O 5.10.0 #1
>   Call trace:
>    dump_backtrace+0x0/0x1c8
>    show_stack+0x18/0x28
>    dump_stack+0xe8/0x15c
>    ___might_sleep+0x168/0x17c
>    __might_sleep+0x60/0x74
>    __kmalloc_track_caller+0xa0/0x7dc
>    kstrdup+0x54/0xac
>    convert_context+0x48/0x2e4
>    sidtab_context_to_sid+0x1c4/0x36c
>    security_context_to_sid_core+0x168/0x238
>    security_context_to_sid_default+0x14/0x24
>    inode_doinit_use_xattr+0x164/0x1e4
>    inode_doinit_with_dentry+0x1c0/0x488
>    selinux_d_instantiate+0x20/0x34
>    security_d_instantiate+0x70/0xbc
>    d_splice_alias+0x4c/0x3c0
>    ext4_lookup+0x1d8/0x200 [ext4]
>    __lookup_slow+0x12c/0x1e4
>    walk_component+0x100/0x200
>    path_lookupat+0x88/0x118
>    filename_lookup+0x98/0x130
>    user_path_at_empty+0x48/0x60
>    vfs_statx+0x84/0x140
>    vfs_fstatat+0x20/0x30
>    __se_sys_newfstatat+0x30/0x74
>    __arm64_sys_newfstatat+0x1c/0x2c
>    el0_svc_common.constprop.0+0x100/0x184
>    do_el0_svc+0x1c/0x2c
>    el0_svc+0x20/0x34
>    el0_sync_handler+0x80/0x17c
>    el0_sync+0x13c/0x140
>   SELinux: Context system_u:object_r:pssp_rsyslog_log_t:s0:c0 is not valid (left unmapped).
>
> It was found that within a critical section of spin_lock_irqsave in
> sidtab_context_to_sid(), convert_context() (hooked by
> sidtab_convert_params.func) might cause the process to sleep via
> allocating memory with GFP_KERNEL, which is problematic.
>
> As Ondrej pointed out [1], convert_context()/sidtab_convert_params.func
> has another caller sidtab_convert_tree(), which is okay with GFP_KERNEL.
> Therefore, fix this problem by adding a gfp_t argument for
> convert_context()/sidtab_convert_params.func and pass GFP_KERNEL/_ATOMIC
> properly in individual callers.
>
> Link: https://lore.kernel.org/all/20221018120111.1474581-1-gongruiqi1@huawei.com/ [1]
> Reported-by: Tan Ninghao <tanninghao1@huawei.com>
> Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>
> v2: change as Ondrej suggests & redraft commit message

This looks good, thanks!

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

>  [...]

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

