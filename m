Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2F70953F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjESKlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjESKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:41:20 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902391729
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:40:56 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-76c4c85d605so492234439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684492849; x=1687084849;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9TOw2H2TDDn1VQzhH7iezPzkkf4u+p1oMfgUm2gH4s=;
        b=Ltr1mPFrf7XXKo6Hxv+EHfBlDxY0DqQfvQ/vqU8Fnbp2zuy19Ua9+Q4WC05ybEwXnp
         pmRt40MUvL7oaq2o+17srturPWSHGumBQNkPgtpPOJR4/jswCsbxy8Szrs7SQGoNi7tX
         DbZG19wmAtMbDvWSr2PlKOEfYF8vX2M9Ogr+S0nmigK8RlFPlbYVNUmfDnPiK5l3B4Sr
         +NRv3U+tnZyMs+OlPQ0b95GCpsTj832bY7isLj/8xk6LHia9aHc2lti1LQ275xleZFEY
         9J5m/yROcmOYpa1CjHi3afYF2F57//Km0R41+NXB9LBdPp3ezWd1vR/i0CHAURL1BIz2
         sudw==
X-Gm-Message-State: AC+VfDz+PCLrPFwcqpfBppQyRUQNiFEuWZAQfSdiCmRpjxOYuOt8z7TU
        oZfFsicHEoIySupmWTG5cacLbpLYhvmqcfIqMRwvFgiukPQF
X-Google-Smtp-Source: ACHHUZ4QMAvvAu11HMro1lpXhxQH2y2TZ7K+U96VwnPLzFF6dbDXZjO027mQ4I6oDWKNp85qzxW9oChkbPZmi5LOXlg+QU7yItqI
MIME-Version: 1.0
X-Received: by 2002:a5d:8e07:0:b0:76c:7d5f:3690 with SMTP id
 e7-20020a5d8e07000000b0076c7d5f3690mr687473iod.1.1684492849358; Fri, 19 May
 2023 03:40:49 -0700 (PDT)
Date:   Fri, 19 May 2023 03:40:49 -0700
In-Reply-To: <00000000000015ac7905e97ebaed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9b0a705fc098d91@google.com>
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
