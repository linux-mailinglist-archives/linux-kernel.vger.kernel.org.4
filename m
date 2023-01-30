Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FC968136F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbjA3OfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjA3Oe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:34:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA5A125A3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675089180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22WK4i0WLRr/tRMw0d72BL0o7KUJp/xROzY52CvrtTE=;
        b=jP588YscNmnT5dRPLdQtxg2u7dBtcIsV08OfZflmMrLizoEFiCQ9bVw6ZC151JSXv7G/pt
        YZgZJr4BL6dbiInRPaOXaHL+Ego2L/ARMqMdm++5ILfR2AktJfQGPtedjY4wtvzmS/wLJj
        j20LGXfj/fysbQlUgmMRuI9r30aKpVY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-146-taYcIO93MOiMwpMFmvBZiA-1; Mon, 30 Jan 2023 09:32:59 -0500
X-MC-Unique: taYcIO93MOiMwpMFmvBZiA-1
Received: by mail-pl1-f200.google.com with SMTP id m7-20020a170902db0700b00194bd3c810aso6720911plx.23
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22WK4i0WLRr/tRMw0d72BL0o7KUJp/xROzY52CvrtTE=;
        b=jlgM1bcfac7GzSb/6wPoM9l4b4HzZWoU8wKqUYzFSkxQLgclhT4/nfhJZAe9LQ9Bkw
         nExeRDQMStQ/3oMaDFc1SuyTJUJUGy2jSy9OVBkFvupnsqC96dXvo4T8ZqvnnY3cJPFx
         WtV/MQ7WX8b2jkM7M0dq5HnwONoHMbBUEJTwQrk86Qya89+sQbYyhbKjUsWWGX1BwMwi
         dVIZxfg0h/359mNilRMLHv7ccE407y0hN/ojzU3xII+iW7d+4yWo6HhSvSrQ8VjNplgs
         Z8bYPUph9H2tJyovNpsNluZqnor07ojZBEHAEn90tkTu7kBKH/GZHZ1XFuwtYQSX68Hv
         E61w==
X-Gm-Message-State: AO0yUKXI7xtPDdvLU6tF2HoBqkPywfuS9P0u+ALSnAmhcWV884xpag9Y
        5WtnoNn/fJcCJMVJe5oLJw6o41EoPrQBf8yU1xlyb4mQ1+q2recZ96MY3STT1SX2JkiQQck03ZS
        uiCEo/JGFzDK1znH89QuEBiCmNSk0vZq7+VDBSWXK
X-Received: by 2002:aa7:9478:0:b0:593:b971:2579 with SMTP id t24-20020aa79478000000b00593b9712579mr779031pfq.35.1675089175218;
        Mon, 30 Jan 2023 06:32:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8NIC6aW6DTDWc5ntXK+WFT5eLWDGr761lUI4+FdK1IBK+jf/Y9qLyoe8F753VsJQtmakt5yr/oe5tI+dbzxIM=
X-Received: by 2002:aa7:9478:0:b0:593:b971:2579 with SMTP id
 t24-20020aa79478000000b00593b9712579mr779024pfq.35.1675089174925; Mon, 30 Jan
 2023 06:32:54 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002b5e2405f14e860f@google.com> <20230127051009.3881703-1-eadavis@sina.com>
In-Reply-To: <20230127051009.3881703-1-eadavis@sina.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 30 Jan 2023 15:32:42 +0100
Message-ID: <CAHc6FU7jmjG7wkBHNiQ8J-=89U6pa6SMvJj60hX-WL-cSq9R-w@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix uaf for qda in gfs2_quota_sync
To:     Edward Adam Davis <eadavis@sina.com>
Cc:     syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Edward,

On Fri, Jan 27, 2023 at 6:12 AM <eadavis@sina.com> wrote:
> From: Edward Adam Davis <eadavis@sina.com>
>
> [   81.372851][ T5532] CPU: 1 PID: 5532 Comm: syz-executor.0 Not tainted 6.2.0-rc1-syzkaller-dirty #0
> [   81.382080][ T5532] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
> [   81.392343][ T5532] Call Trace:
> [   81.395654][ T5532]  <TASK>
> [   81.398603][ T5532]  dump_stack_lvl+0x1b1/0x290
> [   81.418421][ T5532]  gfs2_assert_warn_i+0x19a/0x2e0
> [   81.423480][ T5532]  gfs2_quota_cleanup+0x4c6/0x6b0
> [   81.428611][ T5532]  gfs2_make_fs_ro+0x517/0x610
> [   81.457802][ T5532]  gfs2_withdraw+0x609/0x1540
> [   81.481452][ T5532]  gfs2_inode_refresh+0xb2d/0xf60
> [   81.506658][ T5532]  gfs2_instantiate+0x15e/0x220
> [   81.511504][ T5532]  gfs2_glock_wait+0x1d9/0x2a0
> [   81.516352][ T5532]  do_sync+0x485/0xc80
> [   81.554943][ T5532]  gfs2_quota_sync+0x3da/0x8b0
> [   81.559738][ T5532]  gfs2_sync_fs+0x49/0xb0
> [   81.564063][ T5532]  sync_filesystem+0xe8/0x220
> [   81.568740][ T5532]  generic_shutdown_super+0x6b/0x310
> [   81.574112][ T5532]  kill_block_super+0x79/0xd0
> [   81.578779][ T5532]  deactivate_locked_super+0xa7/0xf0
> [   81.584064][ T5532]  cleanup_mnt+0x494/0x520
> [   81.593753][ T5532]  task_work_run+0x243/0x300
> [   81.608837][ T5532]  exit_to_user_mode_loop+0x124/0x150
> [   81.614232][ T5532]  exit_to_user_mode_prepare+0xb2/0x140
> [   81.619820][ T5532]  syscall_exit_to_user_mode+0x26/0x60
> [   81.625287][ T5532]  do_syscall_64+0x49/0xb0
> [   81.629710][ T5532]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   81.636292][ T5532] RIP: 0033:0x7efdd688d517
> [   81.640728][ T5532] Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [   81.660550][ T5532] RSP: 002b:00007fff34520ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [   81.669413][ T5532] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007efdd688d517
> [   81.677403][ T5532] RDX: 00007fff34520db9 RSI: 000000000000000a RDI: 00007fff34520db0
> [   81.685388][ T5532] RBP: 00007fff34520db0 R08: 00000000ffffffff R09: 00007fff34520b80
> [   81.695973][ T5532] R10: 0000555555ca38b3 R11: 0000000000000246 R12: 00007efdd68e6b24
> [   81.704152][ T5532] R13: 00007fff34521e70 R14: 0000555555ca3810 R15: 00007fff34521eb0
> [   81.712868][ T5532]  </TASK>
>
> The function "gfs2_quota_cleanup()" may be called in the function "do_sync()",
> This will cause the qda obtained in the function "qd_check_sync" to be released, resulting in the occurrence of uaf.
> In order to avoid this uaf, we can increase the judgment of "sdp->sd_quota_bitmap" released in the function
> "gfs2_quota_cleanup" to confirm that "sdp->sd_quota_list" has been released.

I can see that there is a problem in the gfs2 quota code, but this
unfortunately doesn't look like an acceptable fix. A better approach
would be to use proper reference counting for gfs2_quota_data objects.
In this case, gfs2_quota_sync() is still holding a reference, so the
underlying object shouldn't be freed.

Fixing this properly will require more than a handful of lines.

> Link: https://lore.kernel.org/all/0000000000002b5e2405f14e860f@google.com
> Reported-and-tested-by: syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> ---
>  fs/gfs2/quota.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 1ed1722..4cf66bd 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1321,6 +1321,9 @@ int gfs2_quota_sync(struct super_block *sb, int type)
>                                         qda[x]->qd_sync_gen =
>                                                 sdp->sd_quota_sync_gen;
>
> +                       if (!sdp->sd_quota_bitmap)
> +                               break;
> +
>                         for (x = 0; x < num_qd; x++)
>                                 qd_unlock(qda[x]);
>                 }
> --
> 2.39.0
>

Thanks,
Andreas

