Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF8F619D4A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiKDQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKDQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:29:03 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D95121260
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:28:13 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso2928151otq.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v2Pmz+RE2prvZLfTVmDbhJKc4l2QBAu7VJ+q+ErwBNQ=;
        b=coJivt9uBMGehyGbOtS3ZSyEbGRg4IxLXrUT6HLeqU5JAloD/I+eqk5ooZ/5ltCl1L
         vhZVHNVr0HTrnNSCAZgOu/Sctoqpwn+N6M8mab2O2MrQwZovBoPNoYaOtk77WfqjJyU4
         Ofylq0O6yxFkKHhKkWClTaG3+LMeyuIuTPcsNCJ2tkry28WufC9b3AIR4uHu1KYBCfw8
         XQHrgligZQb4L7EGVJE+XioVvcvlaBXIBfoHhIvbEPBPRVRi4AlzJ//GE1JrnKJTc15J
         UIxpHj9rICbnWasf/CAwVGFXjXzo82kaI4N3BQzCenKoVLsvJd01vviFaQMwwJD68qaj
         uDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2Pmz+RE2prvZLfTVmDbhJKc4l2QBAu7VJ+q+ErwBNQ=;
        b=SqCEEsXJLOb+jJAQ+QAYKhD/FLDb7g8nes5K0ynQcrtgvzumg5FOeFRV/JMhCnaxy7
         cjt8Iv/Tbk5xEXL2DDVBs4If/tfICAxBTGP+sQ8Qukttna+RquAz2dkIRKtt8nF3Qy0I
         EroJ82TZlXzeK2Rn3cp/Ov9orNEWIE1pwUqpjLHFiq6sk1FNuCea2ag1XRfmGbSuZ0m7
         jxdh1KJfVBXVO1Ys10WO/I1CPVLGudwlGTzb1zFQ+ddlfCi+hQSCdRabeQNh0c7tIurr
         mtqVRdG2NsJEDErDaeFd1+FFVWEqP84iu3dfDctSkEqJLS6UOBPH1L5mpqNcvmUzjIYG
         xbyw==
X-Gm-Message-State: ACrzQf235rw90oymBkzxnyziQ5S/WW6whOfkAXwRGWMD59Kd6KEqKjj+
        JNG3IvSW39rZLqTqgwvzQHj4BAGAmjOrMCML2qKfHQ==
X-Google-Smtp-Source: AMsMyM5gYieYMr+uYhD9EKHowhKmrdmM1QMekJJ2kzIjeIJ/nD2P/U+aZdsXcT54V0X8/GlC+X2kwrBclF7Xlo0Sstg=
X-Received: by 2002:a9d:62d8:0:b0:66c:4f88:78ff with SMTP id
 z24-20020a9d62d8000000b0066c4f8878ffmr13691730otk.269.1667579293082; Fri, 04
 Nov 2022 09:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000035fba305eca64106@google.com> <Y2UvigDr9ctxlEEE@google.com>
In-Reply-To: <Y2UvigDr9ctxlEEE@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Nov 2022 09:28:02 -0700
Message-ID: <CACT4Y+Zb0T4bPk=gzYtexPqHTGSFAHaeY6DCYq268GV4+TM+gQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in get_desc
To:     Sean Christopherson <seanjc@google.com>
Cc:     syzbot <syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com>,
        bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 08:28, 'Sean Christopherson' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Fri, Nov 04, 2022, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    81214a573d19 Add linux-next specific files for 20221103
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=132019de880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc625e9234bac0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ffb4f000dc2872c93f62
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd52ca880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/5d4dda497754/disk-81214a57.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/9658efff160a/vmlinux-81214a57.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3711180f2565/bzImage-81214a57.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
> >
> > BUG: unable to handle page fault for address: fffffbc5a1c22e00
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 23ffe4067 P4D 23ffe4067 PUD 13ff2d067 PMD 13ff2c067 PTE 0
> > Oops: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 5368 Comm: syz-executor.2 Not tainted 6.1.0-rc3-next-20221103-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > RIP: 0010:get_desc+0x128/0x460 arch/x86/lib/insn-eval.c:660
>
> I'm pretty sure this is the same thing as
>
>   BUG: unable to handle kernel paging request in vmx_handle_exit_irqoff
>
> I'll verify and get a patch posted shortly.

This repro does not create any VMs, it's just:

iopl(0x3)
rt_sigreturn()

Do you still think it's related to the vmx_handle_exit_irqoff issue?
