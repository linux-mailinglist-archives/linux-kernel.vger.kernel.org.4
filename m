Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869676A3F31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjB0KIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjB0KIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:08:36 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5471DB83
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:08:35 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id z5-20020a6b5c05000000b007447572f3f8so3649033ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHBorJxtb8OOdvReJ/cspDu7cb80E+hJP4zqgvf9eJU=;
        b=7addPAgD9YLUZRhYfE/xdogO6mnEeZWkHsvqKxw7ZYDM78r2BA4Q/lEAKQv3epDUb4
         hGhIyDjLh8e1N0HU8/2IxXw0uAF0BK8NRwF7tngfI8qwtrlrCoA9jmIGXPoNp4vONxWs
         w4LgKcu/OjddzM1unZBETsxxuL1w4GJd1Un0w7ZIsdFWYQ3NzjZbFQ4Gwx5JkPztdYL0
         86WiW4NckH3BkmvLqDgdvYmjk7O92Wlef3WtDOBwYqBylaMwmpuqx59Ei7MXRHe7pqZD
         bNM0L9lJ+6i3TnTuZi0WKAFOAAFrKv8zupEfgokSFuN92putRqg4UOMqM7fsYhxT8zmD
         hBsQ==
X-Gm-Message-State: AO0yUKUJD6ax2AwKUT08dhlJJQ2JCEKNumyXhuinYu++cfIopHl+FLA0
        RI0EMgH+nXfN2pXX9lsVl9D7+SM4N/Lp+1/GEIbsV4DjWFsF
X-Google-Smtp-Source: AK7set9XQOjnaY+h0KPoKF8yzSMNDRjBgH9I4koeZnVndKXg0GN9QwyrO+eJsiVC+58G+gFmqP7opHmTZ+1yfcagTkYNKJus8QSw
MIME-Version: 1.0
X-Received: by 2002:a02:2907:0:b0:3eb:fd40:78be with SMTP id
 p7-20020a022907000000b003ebfd4078bemr2564199jap.3.1677492515115; Mon, 27 Feb
 2023 02:08:35 -0800 (PST)
Date:   Mon, 27 Feb 2023 02:08:35 -0800
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a186e05f5aba972@google.com>
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
