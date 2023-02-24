Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62326A1A76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBXKjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBXKiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:38:11 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B401A657
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:37:37 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id 22-20020a05660220d600b0074c8b57746cso6034869ioz.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1+xVltypcnxAkvWPCQxFM0n2XimN1lwperOL1Mtxsc=;
        b=zDUBnAvxy/hbjFLz5SQVgsvpEEWzcC8Ijj8x9w0BJeNm/kPaIbfIH94EzYigf3pENn
         1yvDqHbhvMsn3sSdyNif/LdvjplK8LDlvm81J0TIempq02Y27zgzawwbU0wiwxk3BGJC
         ayRQHhVcFyPhIWvdRSNThaAQJa0hixrT1vM90Xyxg3Go2fDw/3aBOQGAzGVMM93JJaPT
         D3OiodRKFZtPLjLGF27XaqIVkb6OIDo7PiWlnSvOGRO4+593asu9iGDPRRMOLVLLSL4E
         upCq2cNV3eVjuIyv8fD5e2CRysC+vRIWGAkVRpfPq7Atte3qzrflBBGGShew4jScJbuc
         F7nw==
X-Gm-Message-State: AO0yUKVNoyKNTB4V7934VEXfh9UeX8XL61qcd+iJmFVcH5dgBTiN5ndD
        n0PEKpYwa+S4lbTUkEWos8CjigukcxlSLomaMym8dbg7gFjY
X-Google-Smtp-Source: AK7set9BQ2hLGkH4rh6LoB1pxceRVcoO+duNseH2oJ7Z8vnoT9cTfctrdK8+cxyn/3t4o+rlHABCUXESiz5flpE9j9PDcihi/jRF
MIME-Version: 1.0
X-Received: by 2002:a02:a15e:0:b0:3c5:19e6:b532 with SMTP id
 m30-20020a02a15e000000b003c519e6b532mr5810674jah.6.1677235057020; Fri, 24 Feb
 2023 02:37:37 -0800 (PST)
Date:   Fri, 24 Feb 2023 02:37:37 -0800
In-Reply-To: <00000000000015ac7905e97ebaed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7553a05f56fb722@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rdma_close
From:   syzbot <syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, dan.carpenter@oracle.com,
        davem@davemloft.net, edumazet@google.com, ericvh@gmail.com,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com, lucho@ionkov.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
9p: client_create/destroy: only call trans_mod->close after create

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=67d13108d855f451cafc

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos
