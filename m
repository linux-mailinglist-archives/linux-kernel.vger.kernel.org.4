Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5009C659756
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 11:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiL3Kej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 05:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiL3Kef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 05:34:35 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FA813F37
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 02:34:35 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h24-20020a056e021d9800b0030be8a5dd68so11766168ila.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 02:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1+xVltypcnxAkvWPCQxFM0n2XimN1lwperOL1Mtxsc=;
        b=dq4fyprvZbJP0ZwpuksQzY6NSbjtTasfqo+9N+EIxamIcOAAJXPCq38dI3DhEvMjze
         QJfOkqvTEY+VWFbt/DUfG9kCgztP1rMpY+H+nNjskCSvFQ3puNPIVmTjsr0ySU4CqQza
         IOjdsoz2ZthGyomkRdspYm0jSjiov+htAWH5p/wklxwokv+H9/pr6MBvYzL5tVJ/9c8i
         6o2tLpfQKahk/I5Pn2xy+NBwfsuoGkD5FyRptaIfKVcm3NkUT1dqTD7Ks6Rc74Zm+biA
         xLiwl/02xOp3H67tQ578xMARl2QEuYcd+ItGl+OTnkWJEl29XqGblK0xOxuRvyvKxKY8
         /O0w==
X-Gm-Message-State: AFqh2kqSqteXuhxPSNX/PD/1VW72d+FquDZK8mjnNNxucZNGlojlK/UV
        QKsMbpsNZmTsdoUUBD4mwfaujrZFPLL2lbYcOcCpgggntqJB
X-Google-Smtp-Source: AMrXdXuCVhfuhDVOVDBO2QEW3ZsUFRaZINtASNymA6eBjtRAhCOlpvlwUqMjxK5NbcRex/8HxlW2bK/0gq0OxTMGvKNDTLJeZwSu
MIME-Version: 1.0
X-Received: by 2002:a5e:cb44:0:b0:6df:b793:35ac with SMTP id
 h4-20020a5ecb44000000b006dfb79335acmr2257037iok.33.1672396474461; Fri, 30 Dec
 2022 02:34:34 -0800 (PST)
Date:   Fri, 30 Dec 2022 02:34:34 -0800
In-Reply-To: <00000000000015ac7905e97ebaed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8b66105f1092536@google.com>
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
