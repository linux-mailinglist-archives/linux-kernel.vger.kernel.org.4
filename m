Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278366EA871
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDUKjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:39:36 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49147B462
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:39:35 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-763a89d850aso10239839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682073574; x=1684665574;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9TOw2H2TDDn1VQzhH7iezPzkkf4u+p1oMfgUm2gH4s=;
        b=H1Ozzlb7X/pJNGBsBLMT2T+ppxTFOuzVqUkiR+q/UCBjTcInQsP3pOcCdWd0c1OPtm
         ksv6VMPHEQgpz1QF8naclMmF5HlnrqBQ9BgyUUliu5cqBhfme63FpQR1wrM9BgFm7h0m
         NLolnw1kE++JjXVLSEJZ2rcECSgjBjjyDxGud214UHEXznrt6v22Hp+a82nMbQhErfoD
         CEj5CEr6lz6LwGvIPxpkijs8sUnQgWYYrIskgkmgqN+3q9O0zply+dE1+jNArIRRDt7r
         rDxYNZP1yfP75TqMFEpjO2sedGx49hp2ziOpZCrckoSSZxr3buywfmsQJJQKeIM9uBnv
         Ping==
X-Gm-Message-State: AAQBX9cQ6Qtt2+q7QxVwzXEXClnRe55q7XN3DOSTNEMkGj1/4m0cpK1E
        XZ1ukZ63U2nRJzzRWjJ+CcN4duE+zigPYANmHN2N4a+i1GIw
X-Google-Smtp-Source: AKy350YyCFmua8oWPJ4Yg0OC2jZMgh0inWc9TsFM5D0fT3r23bveFRBsJ3dexBUvmI5UDsULh2YriO+HvaWQi4f6SSMZylMOO7au
MIME-Version: 1.0
X-Received: by 2002:a6b:e30e:0:b0:760:a66f:af61 with SMTP id
 u14-20020a6be30e000000b00760a66faf61mr2285637ioc.2.1682073574354; Fri, 21 Apr
 2023 03:39:34 -0700 (PDT)
Date:   Fri, 21 Apr 2023 03:39:34 -0700
In-Reply-To: <00000000000015ac7905e97ebaed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2ba1c05f9d645f5@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rdma_close
From:   syzbot <syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, dan.carpenter@oracle.com,
        davem@davemloft.net, edumazet@google.com, ericvh@gmail.com,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com, lucho@ionkov.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos
