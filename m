Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E214604945
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiJSOdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJSOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:32:54 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27519DDA5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:17:37 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id i25-20020a4a8d99000000b0047fa712fc6dso3552636ook.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5BfLX5KRl3Okg348FT7/RFBCfyy3DklPfVwwqyxjUnM=;
        b=RNQDrr8g1rq18i5lSZkSTRzYdRLnEJJsPqhCSziVSNc0KU+8GDtyoDsgYFzQu3mUya
         bIgFLxIlPRZt+jyDTn4h279FKymGwbBU4ByQ3gREPQCDWwPItrL2c0CUGwhZdq0zYTzr
         eb98j+wsXRaiXc3+Mk52Zcx9BCLoW/DkxBVr/gNqINUDGZ/iFepY2QkGoAmff4nEUlin
         HvP9KRAdHJjMquKDNXKcdMrDh/EzEDLxSgVRNhBhfuX1OCZ5siiO+S/6HXhm6hC4BDCQ
         c02OGVReXVVQY1J0YbhIoxfOKGiS8mvtBgJt9XjJx71kc8te3b5iu3gyDF9MqGpbhkYC
         te7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BfLX5KRl3Okg348FT7/RFBCfyy3DklPfVwwqyxjUnM=;
        b=ofqx4ZCNnimTJRulaDDxAdNYehgSwFmFMl1HrsqpqSqlq+DjsHNzjBnFJDtUwGhlQk
         Cjc9NglymJ8Wr3x78bwQ8CDWUWrMEvfL3vcqKpa3X0OJLQBKu72/8vKut8x/io6HQ5cO
         +htlpt98Pr6cuTwu62/iKp0XV8p//T2vQnKP5U2LrNqj36LrzuXU5k2STjGx8eomPSlr
         r4uCt9cdTc7+THZFbFgPNjxM5PEsancwDMyUOmfTVArrwu2af5vsJ0emDULOvVNcMkVd
         JED1JLJ5M2e4REgq1MaWV+CictL6dl733gV0gGpJAw5GsM7FKirCKRTm52hp0yTbdsTw
         uQZw==
X-Gm-Message-State: ACrzQf0r5DWBhCt+NjuOS82YbN1B5eimMLFx1VaHF54yDpFYZO11lt67
        bhs7Y1/BkwD19SWFUOh3ifxfuHD44Cago2qbHeNAxiPOpQ==
X-Google-Smtp-Source: AMsMyM4ymv6dFaiJMYVe2rXIjGqTIMrLYaCpng71BEymljx162jO+w+qkW4F27gM1MPCghftnNAQ/gjbyWKV3+FH6sQ=
X-Received: by 2002:a0d:e64f:0:b0:357:815d:614 with SMTP id
 p76-20020a0de64f000000b00357815d0614mr6939149ywe.276.1666188471096; Wed, 19
 Oct 2022 07:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221019025710.2482945-1-gongruiqi1@huawei.com>
In-Reply-To: <20221019025710.2482945-1-gongruiqi1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Oct 2022 10:07:40 -0400
Message-ID: <CAHC9VhQOXBZid_3-Zm48uysTC+ueSFmJy=g=JMYFEfgdtuwB1A@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use GFP_ATOMIC in convert_context()
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:56 PM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
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
>
>  security/selinux/ss/services.c | 5 +++--
>  security/selinux/ss/sidtab.c   | 4 ++--
>  security/selinux/ss/sidtab.h   | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)

Merged into selinux/stable-6.1, thank you.  Normally I would send this
to Linus in a day or two, but due to some personal logistical
challenges I may be a bit delayed in sending this up.  I would ask for
your patience and that everyone take this opportunity to do some
additional testing :)

Thanks everyone.

-- 
paul-moore.com
