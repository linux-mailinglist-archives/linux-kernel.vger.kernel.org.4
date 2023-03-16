Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCDC6BD95A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCPTgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCPTgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:36:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C66763CE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:36:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5419fb7d6c7so25412237b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678995376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLXQDEpA7yMBHY3pvsFbW1lWjQMlNDrFYkskb+8dWQw=;
        b=PrB4vwvW5iv11UJZpooT7rvslKfDWjKGT7LJSCkScrFN77cNUoEu4Is6TyO/uq1pM8
         rUVfMYnae2iHqUz0IOi0o+jheqTLS1yi3io9ANUg3z3mal53hfvKcgD993sjQSDsSTfr
         fnV9U2X+NoLTmyLVPe9vlekbkFI9tWk1H2wLrizaagkhUfgFCW43xmu+fHBEgSbLNh3M
         gtsPAC/1ahNIRRZ5MIiF3R7f71M/IWqrO4V61dxBBQ80ccXd1IHlka9of+rNFJEFToqZ
         k3tvrTBHPoHCJzJHDOqbzPyG0eoqQDUJP71H7wAWSLHS+YxFzmPcMHU5RrHfrGVAkw5O
         DwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678995376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLXQDEpA7yMBHY3pvsFbW1lWjQMlNDrFYkskb+8dWQw=;
        b=6RF23p9KXfAtJ3y2FAQLvIci2dGl6kSQCX9CEz4SX5A0OxarykLLOxH1z+r4EJconk
         +MbVJbEn9m1JgYtDkVsvPX1o45jgjLIlHREnk7xbyRFIG7I/bDuj5LwKDPVXvDwiSh4/
         J2xmzOy+ci2hSo/twG1Q6EptcHi8k8AL/XJPEjQmOiS0z1aCHFCvGwHDd+C/qJ7o3z7/
         DswU3jXcdtIKH8nN3kzO7zJoewJp0RwUm0Y1NbhkUy2h2sAi22V0R3CGf1Ef4UAuwuU/
         IdHm2zdwQp43ctnwYMq0mjCuUoDejRINQBLN2CS2dzB7cEL4pTFETl9r2H/Vn21paMsR
         SgMw==
X-Gm-Message-State: AO0yUKWwjbL13RQpw693z48T+3w4ogdnxi7CPG4dEmABaCTurRNRg+wZ
        pf0ovaUImcFMtkdZIjEihTlXV3h5/i8=
X-Google-Smtp-Source: AK7set/jMiOWZ6MfnT/kZfZ9gW4uYomOjI9N6aA3TvUYokg/XSTvTQoJd1TbVa2nB7q5J71HLZCidR+AbOg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4005:0:b0:544:6455:e023 with SMTP id
 l5-20020a814005000000b005446455e023mr2927636ywn.10.1678995376823; Thu, 16 Mar
 2023 12:36:16 -0700 (PDT)
Date:   Thu, 16 Mar 2023 19:36:15 +0000
In-Reply-To: <0000000000009af47405f7093fc6@google.com>
Mime-Version: 1.0
References: <0000000000009af47405f7093fc6@google.com>
Message-ID: <ZBNvrx3Q9Wa3WqXL@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_arch_vcpu_ioctl_run (4)
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+8accb43ddc6bd1f5713a@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jarkko@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ee3f96b16468 Merge tag 'nfsd-6.3-1' of git://git.kernel.or..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11622f64c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
> dashboard link: https://syzkaller.appspot.com/bug?extid=8accb43ddc6bd1f5713a
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd61acc80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17402eb0c80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a7ac3e540d6d/disk-ee3f96b1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/604b5042d73d/vmlinux-ee3f96b1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5a6d400b42b5/bzImage-ee3f96b1.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8accb43ddc6bd1f5713a@syzkaller.appspotmail.com
> 
> kvm_intel: KVM_SET_TSS_ADDR needs to be called before running vCPU
> kvm_intel: set kvm_intel.dump_invalid_vmcs=1 to dump internal KVM state.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5082 at arch/x86/kvm/x86.c:11060 kvm_arch_vcpu_ioctl_run+0x2464/0x2af0 arch/x86/kvm/x86.c:11060
> Modules linked in:
> CPU: 0 PID: 5082 Comm: syz-executor178 Not tainted 6.2.0-syzkaller-13115-gee3f96b16468 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
> RIP: 0010:kvm_arch_vcpu_ioctl_run+0x2464/0x2af0 arch/x86/kvm/x86.c:11060

Same thing reported by another syzkaller instance, I'll post fixes in the not too
distant future.

https://lore.kernel.org/all/ZBNrWZQhMX8AHzWM@google.com
