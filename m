Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE0680A67
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjA3KHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjA3KGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:06:53 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C6B30E83
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:06:44 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so7112054ilj.14
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHBorJxtb8OOdvReJ/cspDu7cb80E+hJP4zqgvf9eJU=;
        b=rnBOcAV7N/Riz2ZE9KdKO9sGGf6p4vKIbV+lEl7Fl3kGoO9OCsxPFKQD++/QJOHG8l
         yNRRNkn4aOWCcc+vc2/gLd01TBA7uECxHoMbaswKX+fIUeaFgFHEQZaXRGPDdWYnx713
         xHjjof7mV6RKrgLT0dVLVA8pbbqqAvsvTzljiHxtJcZ+sADBs4AUqtGHU29zPifBZBkW
         /755N3RX24uiVXyhWnNI5XeUrFSKH0arO6/9lsh/3ppfGfvM07mubKtWomBBO5gvdxfF
         TGJQ8fRDeg9usMhlgli71BIXnpT85hcbv5HqfJ+rJaUA/7++qc29vm3Qzw5tSSmWBaB7
         4SbQ==
X-Gm-Message-State: AO0yUKVgjt5kjpx21zaL2TMGw2OeaeN0ZgatyHs3UA7pbhZYcj0wxAEt
        X9Dbjqw1S6E27X47npRRC77766I7/H+De670X5ysoWM7078F
X-Google-Smtp-Source: AK7set8QVvDE6Gzy4hHO8QvS/BqWwaHgQl6GdJ1EY5X9b6fjYAZywnh0zbGaU9rQ7PgnFR/LWwXICJmwpBQa4CnRQVXqL3xblwvl
MIME-Version: 1.0
X-Received: by 2002:a92:b512:0:b0:311:136:7727 with SMTP id
 f18-20020a92b512000000b0031101367727mr114568ile.112.1675073203474; Mon, 30
 Jan 2023 02:06:43 -0800 (PST)
Date:   Mon, 30 Jan 2023 02:06:43 -0800
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000441c7d05f3785ff7@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
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
net: core: netlink: add helper refcount dec and lock function
net: sched: add helper function to take reference to Qdisc
net: sched: extend Qdisc with rcu
net: sched: rename qdisc_destroy() to qdisc_put()
net: sched: use Qdisc rcu API instead of relying on rtnl lock

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux 4.19
Dashboard link: https://syzkaller.appspot.com/bug?extid=5f229e48cccc804062c0

---
[1] I expect the commit to be present in:

1. linux-4.19.y branch of
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
