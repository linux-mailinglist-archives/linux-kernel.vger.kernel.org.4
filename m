Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BD96187D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKCSmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCSm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:42:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB1F13DC4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:42:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso6149012pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlOWEygp3Q3B0+hmRBdXcI5bVOc0fg9754HhvUHMgTw=;
        b=QiJupiygbmmUc3WjLYoLwdEpXbkyqRluenMe5CSF0DZppRZqSR71rB5DfdVbzTydkA
         9WXcIK9A4o5ZgIaf95HOS5pTs/H0xWwZ6UKEvWI1YP2aVbzK6louP6iTVs45EO2EiIgP
         EITM80kAbyf5pcz7d1FoKX+p7uZJ7AKM3Z9+jFM0y8zoRSSwQLlyBZYCUflAZNSDt/P6
         QTBs3aVSVdbTmodvMtdpz3hvFYHHT2QuPL0j81b0iFnpM0Jzv6bydaMV0zvDco5gbEVI
         U1XyVRGbni9sq0HG7bw2m9WHKG+VYvJpgtncjTMnb8k0m8jA7yCBSOeQr5y5ELAqy4I5
         bOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlOWEygp3Q3B0+hmRBdXcI5bVOc0fg9754HhvUHMgTw=;
        b=U8aVuATs0+g1OtNHu8fNHbxdzZK/G6MJfQZZzuS1nGL/uWe79BhYgK7hGXNT9K6n8C
         M7NmOHlSo4zOw9xoQL1oFY16W9WQMx4xPr91FteD2B/gUKi7zxKX9MN5duv5LEsKQhF/
         /IOnpftoAHA6b4U+NTgn3wpfs4DTcqVZAfnZmT40nH4SQexBdLo5KkL8pEtv2sRYniMU
         FNYnOc9wdAbuVczcDT0vRaPbkxCh4D0wYrHVeL77Aw2Mr4WNpctojGEXE+yH0VN7Vgbq
         EQU2DwV31DmvLGw9x+SLBiRNPvfNMjT62AAhJiU1JkVAPJ8ZZEld75rqyrid0vwy8krP
         eEiQ==
X-Gm-Message-State: ACrzQf3/8kBRTbRIRuZZ1OVorkafQwcs0LC7oeQf6tIL+XTx22uU1j+9
        MHOGWN6dYkNGsx1SYQ/XxiQioQ==
X-Google-Smtp-Source: AMsMyM6EBJtnVX3JvYSOVeZ4k4i6dahkmGD1RbCqzPgmEs3qyieW8t/He9a9C295cUJNjbXSXVYMkg==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr50938599pjb.164.1667500947963;
        Thu, 03 Nov 2022 11:42:27 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u15-20020a170903124f00b0016d9b101413sm973517plh.200.2022.11.03.11.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:42:27 -0700 (PDT)
Date:   Thu, 3 Nov 2022 18:42:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 vmx_handle_exit_irqoff
Message-ID: <Y2QLkI7Jqj8lNnlj@google.com>
References: <000000000000a4496905ec7f35b7@google.com>
 <0000000000004d244705ec88228c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004d244705ec88228c@google.com>
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    61c3426aca2c Add linux-next specific files for 20221102
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13596541880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=acb529cc910d907c
> dashboard link: https://syzkaller.appspot.com/bug?extid=8cdd16fd5a6c0565e227
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d036de880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d5e00a880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cc56d88dd6a3/disk-61c3426a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5921b65b080f/vmlinux-61c3426a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/39cbd355fedd/bzImage-61c3426a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
> 
> BUG: unable to handle page fault for address: fffffbc0000001d8
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 23ffe4067 P4D 23ffe4067 PUD 0 
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 5404 Comm: syz-executor526 Not tainted 6.1.0-rc3-next-20221102-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:gate_offset arch/x86/include/asm/desc_defs.h:100 [inline]

Looks like a KASAN bug, the KVM side of things looks ok and that code hasn't been
touched in quite some time.  The actual explosion is in kasan_check_range(), not
KVM code.

I'll bisect, this repros very quickly for me.
