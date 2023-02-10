Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1259691CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBJKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjBJKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:36:47 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DA26D63A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:36:37 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id d14-20020a05660225ce00b00734acc87739so3227412iop.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1+xVltypcnxAkvWPCQxFM0n2XimN1lwperOL1Mtxsc=;
        b=ISbBMAjSaLFnQN+xah3Fv7kuuvkrbhOKSH1bQfLgtIaob4kWdblTxkN4urhqf1HMmp
         e0yA2OZurPyRdi7iBD83V7zhH7z12n2UzLel6cdPQQbrBtpgxKaN3x5zAcrK9JmKZNTb
         5EZjqCS6SrI/1xI2ldQkR42rxfLoX7UZoAASc7HPv8GdLd91zAkg9b/GX+Ls9w0pIqjI
         PGVhq9Dk1y8iMfcMQUWagqST/kWu/47yaWLXKKeDopVEb+Wi52AXJ6Vv3Rg6cpkN6loc
         BAdCcGXf7sYtRtuCXyr/EqirSUfmeDhXQrvdsyx3dw9hT5lDLvSJLDeac9VMTyh3dah+
         23EA==
X-Gm-Message-State: AO0yUKV14ecsZ1mKKRPEXnqlX5w+jesELA3ZSFG+mNAsDc9rL2CHnx+e
        ER8klUSL8qZxmMrhELVfPQnh5AA6iIPWR81hUjdWyrFLx9Tw
X-Google-Smtp-Source: AK7set8RPGGTXi5zLTnyjKswbEgN7LWwYzgzA5VGCB+OqcXXhMpBY6wGX14MoheR8H5OO5X6bCqt5kKFvh74/+6PMpEY5/Lis7ba
MIME-Version: 1.0
X-Received: by 2002:a6b:cf12:0:b0:713:f12d:40ba with SMTP id
 o18-20020a6bcf12000000b00713f12d40bamr7429931ioa.72.1676025396365; Fri, 10
 Feb 2023 02:36:36 -0800 (PST)
Date:   Fri, 10 Feb 2023 02:36:36 -0800
In-Reply-To: <00000000000015ac7905e97ebaed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062913f05f45612ae@google.com>
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
