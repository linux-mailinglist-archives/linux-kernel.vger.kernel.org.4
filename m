Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1A06EB45B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjDUWCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjDUWCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:02:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B81703
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:02:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f4c437ce5so3675822276.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682114556; x=1684706556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/iD3qt6L/9eIA2IG8ixj9iGFT9v9AV5dfMH5CVDuDCg=;
        b=F6ZubW8g+gwNfJJVuA9hJZzGaJ3LhuuPSOaTYGGUTvuPZTmHhlXY//8X2sE7ttz5rf
         44QY40WtQCKhT4kqqYB1YNAvBPjo1JTvTCarqpTgFCvdkkslc/XqKSGjskX704p3On8F
         wbQ9KfAM865KX9NmtAKqz8AoKX+qSWUEWcYnJt/6ocJN4oDxYYNoWBsjKgyz8mVvt+ab
         g2FtKw9vOYQCVHaoFKXwWws2d8ZhpG2oMvjVN/xMm9RE7U8KC7j5MJeG20JQ0/YXuIw4
         St8WxM8oaSXAS6+iJNa+dpxiKkIuj6pw4kbAWe8W3o29W+JQ2dgeaLGRBpkurXo9OCv3
         Y5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682114556; x=1684706556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iD3qt6L/9eIA2IG8ixj9iGFT9v9AV5dfMH5CVDuDCg=;
        b=LHdLug/GGSCZZ7FuNgRxWmhsuDvLw90kvl9LJ7RpXE9OTazqjBhHYo/gaejMjAwODj
         bWdH7EvY8Y0qyVNUu1B5MXNYo+ZDhPEfy9mY0Wg5oWg0cSkMqMHmdsY0HiXKlfb5xt0J
         4xWjONj3nMqOIKjV8EZBIm2iFY9HOBpFpgs2fAmZox3Q7njzfVl85xtLHsSSnTBaRzVq
         eHUVRDO0nd/vHSHq1fmhupGia7+wZToLRyUa1H5AWWXRcAQRUFqG/7hDE+orQPtpwQ7m
         JcU9b1kPNEEfjbIm4RMwW+p6r33m3xgUkHljBGWKnakLc7CEbzgd3Ouq2OcNiJn3KvWI
         hs4A==
X-Gm-Message-State: AAQBX9cVbQpV+PVBlktrQlqUUI9fnkK61y1UaG6EcQduQ/H4R5OTyqWx
        w1LrnQ+8v/RedAlH58PjNRMk35FNa0U=
X-Google-Smtp-Source: AKy350ZJArJjYJmChAK3H8h5Je7XsDefbKHK/Mg/eh7moGKIFIO+mVnNkYs1UI43rAPeQkUnocXpW/RFdHA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d013:0:b0:b99:4473:ed93 with SMTP id
 h19-20020a25d013000000b00b994473ed93mr535259ybg.4.1682114556524; Fri, 21 Apr
 2023 15:02:36 -0700 (PDT)
Date:   Fri, 21 Apr 2023 15:02:34 -0700
In-Reply-To: <000000000000a0bc2b05f9dd7fab@google.com>
Mime-Version: 1.0
References: <000000000000a0bc2b05f9dd7fab@google.com>
Message-ID: <ZEMH+mqbqzOI4soo@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_tdp_mmu_invalidate_all_roots
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+094a74444165dbcd3a54@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d3e1ee0e67e7 Add linux-next specific files for 20230421
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ac3de0280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=53c789efbcc06cf6
> dashboard link: https://syzkaller.appspot.com/bug?extid=094a74444165dbcd3a54
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c558a9e1fe6a/disk-d3e1ee0e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2ec100a34c4c/vmlinux-d3e1ee0e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1afcd9936dc1/bzImage-d3e1ee0e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+094a74444165dbcd3a54@syzkaller.appspotmail.com

Time to see if syzbot gets confused by a fix that was squashed into the guilty
commit.

#syz fix: KVM: x86: Preserve TDP MMU roots until they are explicitly invalidated
