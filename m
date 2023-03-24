Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8606F6C7CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjCXKim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjCXKik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:38:40 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E2418AB9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:38:39 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d5-20020a923605000000b003232594207dso951948ila.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679654319;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9TOw2H2TDDn1VQzhH7iezPzkkf4u+p1oMfgUm2gH4s=;
        b=Y41Ay9NUtePO1Mr0tyjbcTkXAwhdaw2L7uEFfOhZ8WEdH9nOGLeJNzKfcheqLFLqdB
         5R0448tC+L484LjkgKPL378NrHItPx0AdG+cUH1IAHF4huWWE82x5++15Ug/prW4j6AE
         niI7sVJIUCWkNl/oXN4dvUVx0v/87UM9zLFGYaH9VBUYmJzdZ83UaFqanCaFiuS42LrI
         mFvAqnnX7ayeXZ/KXdIIDUUQ4aRCmeHeznt83w2zyJCW41RjoatKnzkdDqFphmcZA/IL
         Pl0/iIPUUOOtuT0r9E3nxx1OLFjptfrOXiYMP3i0HcdRgHgsDG4nJpRYBc+CS6PXrjz5
         jGHw==
X-Gm-Message-State: AAQBX9coKWoS9McKXhIQlFFv980V3TBfoT+AsRySLudZgkhWW4J8f4Qq
        0p/1ewckcAmvxUqM9j0+MGTJ11uapHOAeb17O4iIuh00wuhG
X-Google-Smtp-Source: AKy350bb9yMrtffJAvLki7tYYCcWem0k/K70GZplke3f49eMW0hXZztTj+oio5VmCMIBcoaDwalID7gbPTXUfVKbDFxheDkn0Rw2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:310:a24c:4231 with SMTP id
 l12-20020a056e0212ec00b00310a24c4231mr1538942iln.6.1679654318955; Fri, 24 Mar
 2023 03:38:38 -0700 (PDT)
Date:   Fri, 24 Mar 2023 03:38:38 -0700
In-Reply-To: <00000000000015ac7905e97ebaed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006e5d105f7a2ffe8@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rdma_close
From:   syzbot <syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, dan.carpenter@oracle.com,
        davem@davemloft.net, edumazet@google.com, ericvh@gmail.com,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com, lucho@ionkov.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
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
