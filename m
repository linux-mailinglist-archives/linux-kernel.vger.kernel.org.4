Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E837E6F80EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjEEKkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjEEKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:40:46 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADC91943E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 03:40:45 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-763c3442563so98146139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 03:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683283244; x=1685875244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9TOw2H2TDDn1VQzhH7iezPzkkf4u+p1oMfgUm2gH4s=;
        b=djMS5adym77Yb+78E0mM8pKPqHlCJezj3GJzqbgn01LVSIb4js7I0CdE8xHO29TnRX
         b+CBb3earL73eFclREQwLSxmFX0BNcMiO2RGeqca1V2A+StRGy3mQrTc0tRKUKVCV5X/
         /56gYNE5bgpZf6FIcwnf9WgtQKW62ng++xYAAdflpppZW1Y8wjIL8pD1NvjVIYaWm1je
         rtGbf4fkELhSmBYLzw6xSs5qymOhUcEO7erHkmcTM5HPPkvAhzw9tQsh2uRXxtp63uVf
         Cy8mcyuXCv18l1HdwuNBrG+lxzXyfs0ehG52/jWZAihjbgpL2X6hY8wqVphzboBuK8p/
         Iwjw==
X-Gm-Message-State: AC+VfDzXGgtI0QfIiYengwtf6RcsTVc1Fy4M1C3oLvvUVrYxsF2H+ZUe
        0ntZqno2SZG4FpyE6XXBXV7KiilhmcWi3go+P9HcHt7HCbVN
X-Google-Smtp-Source: ACHHUZ5xOG3XGCx93dAYKbJBrOdkpF4bz1D74zAPToSCxvNwuTdypA21a6QfnU9ZY2IJzVNvRPtVJwEW4o1w9mz95YJTvmVXCpaE
MIME-Version: 1.0
X-Received: by 2002:a02:290f:0:b0:416:1d9f:9887 with SMTP id
 p15-20020a02290f000000b004161d9f9887mr374342jap.3.1683283244809; Fri, 05 May
 2023 03:40:44 -0700 (PDT)
Date:   Fri, 05 May 2023 03:40:44 -0700
In-Reply-To: <00000000000015ac7905e97ebaed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd060905faefeb19@google.com>
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
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
