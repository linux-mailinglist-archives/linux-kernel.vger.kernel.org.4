Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F314619B9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiKDP2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiKDP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:28:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E09C2FFCD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:28:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h14so4790266pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLloCxWAl7ptVNCksuAEItfXL5IPNNlIfD5LW1zVqIA=;
        b=YxMojb4lDtGBEKCRM0ojXAnntu/D9J7Ip/uGO2aM6r+4qgN6Rz+3h2sHLyT2QKjkl4
         IqA+LT+5gAWW0Xd7OwAYRyiN1XBeroAF8mlGZ+Gqzz2sTos2mTDWtFpBP5Yilf+2zMw4
         TNtMi/3glozGGN/rPYJtOU+H4aWY5DtlZRu7OpIujfaXEVUuExWthPfgcQbo1hebYM63
         FojGR2TOhLvwMIQbtu5wPzheLx1zskPUL1GflIxvy2mzi+qB6fhNCVJ9QZlaiOhr9GzO
         tRDHny4Myyr11p720CQkRyr7faxVGbUiSY4pt901uXXGI6h3PiJ0KxfMnHb2Qe4FDwkZ
         EmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLloCxWAl7ptVNCksuAEItfXL5IPNNlIfD5LW1zVqIA=;
        b=rDcrQlbvO6HM+EOfkDj8Lo/1DI+CgfcLZZUJ1XwOKn1DNP2xWjIlS2iY6Nx54u/pzk
         ZN8hBsRaezhoes+U8BCe35kZeEZp0qeBXeKor6r9QrYae7PBwCLc5EKQvjwA0HyqEqJK
         hpdCTvkoonbjcwYcCv9FWyzllZi1WK0U5mg//0GCA4hEa37Wf/IyFkYZpAfQBf1qkYDt
         vPKRzvzUbcShPebF9fZ5tqvFQ1VOJT9u0MBwnDwwY4ZXUbZGPWGSW83u1Gh+PA7Xgm/i
         UVvsiE45+iexWMAGWRa/6P76cU94tR8ydIUsp1pqQr3BIHQUHisP6ZhCNJPBH+vc0tKR
         q9Cw==
X-Gm-Message-State: ACrzQf1sAzryYWXHYjpL0fcxYlvE2PZ0URYXT/qFQjmx+bZpmMljPtuL
        bVL7RE7YAlzGfbCtqqUaR9KTLw==
X-Google-Smtp-Source: AMsMyM7mIU3C8ePyVq6nKk4vgL0wyQhsOrCMfHiGBW/KSSq6H+hh6NjRpTKJcc1Ys9jmYL3KAL+9gA==
X-Received: by 2002:a17:902:7d8a:b0:187:337a:b29b with SMTP id a10-20020a1709027d8a00b00187337ab29bmr21492603plm.96.1667575694399;
        Fri, 04 Nov 2022 08:28:14 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b0017f36638010sm2755002ple.276.2022.11.04.08.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:28:14 -0700 (PDT)
Date:   Fri, 4 Nov 2022 15:28:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in get_desc
Message-ID: <Y2UvigDr9ctxlEEE@google.com>
References: <00000000000035fba305eca64106@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000035fba305eca64106@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    81214a573d19 Add linux-next specific files for 20221103
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=132019de880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc625e9234bac0
> dashboard link: https://syzkaller.appspot.com/bug?extid=ffb4f000dc2872c93f62
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd52ca880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5d4dda497754/disk-81214a57.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9658efff160a/vmlinux-81214a57.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3711180f2565/bzImage-81214a57.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
> 
> BUG: unable to handle page fault for address: fffffbc5a1c22e00
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 23ffe4067 P4D 23ffe4067 PUD 13ff2d067 PMD 13ff2c067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 5368 Comm: syz-executor.2 Not tainted 6.1.0-rc3-next-20221103-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:get_desc+0x128/0x460 arch/x86/lib/insn-eval.c:660

I'm pretty sure this is the same thing as 

  BUG: unable to handle kernel paging request in vmx_handle_exit_irqoff

I'll verify and get a patch posted shortly.
