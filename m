Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FDF60A014
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJXLTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJXLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E70A5FF62
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666610354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o7P6KgeEMi9SnMi8c+SovrKNZ70MRlUTSFvNh1tsfGg=;
        b=IpFBTkT1XyxcJ0QyDnFj6YlxvSdrf7JU/70UYWFlusV4gOBaghiQ1jr/JUW1LQCRW+ncdT
        XAinDstc9XRsZXpfA5QZ1/bXwj8hgQcGwmcntmX1whewB4jBmHxgwZqsgR5UOPl+IDG1gu
        iy84z9Q/0sXiVQEM4/xprYRy9oic1Gs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-dAkDbYaqMiqpyju2LGfOlg-1; Mon, 24 Oct 2022 07:19:11 -0400
X-MC-Unique: dAkDbYaqMiqpyju2LGfOlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 201EC86E927;
        Mon, 24 Oct 2022 11:19:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-157.brq.redhat.com [10.40.194.157])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B546C15BA4;
        Mon, 24 Oct 2022 11:19:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 24 Oct 2022 13:19:06 +0200 (CEST)
Date:   Mon, 24 Oct 2022 13:19:04 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     chen zhang <chenzhang@kylinos.cn>
Cc:     chenzhang_0901@163.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: disable single step in __ptrace_unlink for
 protecting init task
Message-ID: <20221024111904.GA22966@redhat.com>
References: <20221024094759.11434-1-chenzhang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024094759.11434-1-chenzhang@kylinos.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24, chen zhang wrote:
>
> I got below panic when doing fuzz test:
>
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000005
> CPU: 2 PID: 1 Comm: systemd Kdump: loaded Not tainted 6.1.0-rc1 #1
> Hardware name: LENOVO 20L5A07XCD/20L5A07XCD, BIOS N24ET56W (1.31 ) 02/19/2020
> Call Trace:
> [  157.210356]  dump_stack_lvl+0x49/0x63
> [  157.210364]  dump_stack+0x10/0x16
> [  157.210368]  panic+0x10c/0x299
> [  157.210375]  do_exit.cold+0x15/0x15
> [  157.210381]  do_group_exit+0x35/0x90
> [  157.210386]  get_signal+0x910/0x960
> [  157.210390]  ? signal_wake_up_state+0x2e/0x40
> [  157.210396]  ? complete_signal+0xd0/0x2c0
> [  157.210402]  arch_do_signal_or_restart+0x37/0x7c0
> [  157.210408]  ? send_signal_locked+0xf5/0x140
> [  157.210416]  exit_to_user_mode_prepare+0x133/0x180
> [  157.210423]  irqentry_exit_to_user_mode+0x9/0x20
> [  157.210428]  noist_exc_debug+0xea/0x150
> [  157.210433]  asm_exc_debug+0x34/0x40
> [  157.210438] RIP: 0033:0x7fcf2a8e51c9
> [  157.210442] Code: ff ff 73 01 c3 48 8b 0d c5 7c 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 ba 00 00 00 <0f> 05 c3 0f 1f 40 00 f3 0f 1e fa b8 ea 00 00 00 0f 05 48 3d 01 f0
> [  157.210446] RSP: 002b:00007ffd7dc44678 EFLAGS: 00000302
> [  157.210451] RAX: 00000000000000ba RBX: 000055f7c0363170 RCX: 000055f7c04d2820
> [  157.210454] RDX: 00000000ffffffff RSI: ffffffffffffffff RDI: 000055f7c0363170
> [  157.210457] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000001dd0
> [  157.210460] R10: 00007ffd7ddc9090 R11: 000000000000d7da R12: 0000000000000001
> [  157.210463] R13: ffffffffffffffff R14: 000055f7bf3557c1 R15: 0000000000000000
>
> If a task attaches init task and is single stepping it, when this task
> exits, ptrace value will be cleaned. It causes SIGNAL_UNKILLABLE flag
> cleaned, and init task will lose the protection. Init task maybe be killed
> by SIGTRAP signal because of stepping enabled.

Well. If debugger just exits then the tracee (init or a regular process) can be
killed. This is the application bug. Debugger should not exit unexpectedly, that
is all.

The kernel can't "cleanup" the state of the tracee anyway. Say, debugger installs
a breakpoint and exits. The tracee will be killed once it hits this bp. What can
the kernel do?

Not to mention I don't understand how your patch can actually help. If nothing
else,

	- debugger does ptrace(PTRACE_SINGLESTEP), this wakes the tracee up

	- the tracee enters force_sig_info_to_task(SIGTRAP) after single step

	- debugger exits, __ptrace_unlink() clears ptrace/TIF_SINGLESTEP

	- force_sig_info_to_task() clears SIGNAL_UNKILLABLE, the traced init
	  will be killed.

Oleg.

