Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CA469423F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBMKHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBMKHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:07:31 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8FBBDE6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:07:29 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id f16-20020a5d8790000000b0073dfed277b3so2169707ion.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHBorJxtb8OOdvReJ/cspDu7cb80E+hJP4zqgvf9eJU=;
        b=PHaY53bkRPSsQa3OvNCTS+EmUBzj6EUUGSRujXkxGXYx3fnFBF3Z4H4z6h5cIM7GNM
         ghZIQf1jfDV29fTWF+110nIkqGK2TqdjDXmTy3naftbYp/oaB64d1qa1/DahXoH4MVjg
         UT8El+kHQNx6iJhvcls+X/hyKBzgO8WNotxhFcJdT7n0bZJ/sKYMftrALkzw562M/wlL
         LKqlqkxV/Ff8tIKdeMrqTyN21Dhbc9KShyB9IjwsFOx9aGJ7Z5Zo07pRkplPmzC6RDmC
         vytnyFPyEMvA8RNpXkHv7cJTNw/Lcnl4UGlzuodEn3Xdwvft2olyljXhjHnBjhSTuKHA
         dJ2Q==
X-Gm-Message-State: AO0yUKUi+6JaD4FL7llHHDl/r5vfmIXYZilWT55vZwbB20LKxmKPlrUl
        FZ2dtcbIAa9OudVczh41eY27TKlSeA/8fxXHxbWzsdgCJwzQ
X-Google-Smtp-Source: AK7set+1zNVr8o2nj/umsTq2MSUxT+uwUFhErqQ89XND3OWGaYEsKtjlinyVLzMfHvhdQTrdc2u9qIlH4UfDrjptuhJVAoRIXO4U
MIME-Version: 1.0
X-Received: by 2002:a5e:a90f:0:b0:71b:df97:1d95 with SMTP id
 c15-20020a5ea90f000000b0071bdf971d95mr11408959iod.80.1676282849081; Mon, 13
 Feb 2023 02:07:29 -0800 (PST)
Date:   Mon, 13 Feb 2023 02:07:29 -0800
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c33f7305f4920330@google.com>
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
