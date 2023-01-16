Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697CE66BB34
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAPKG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjAPKGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:06:03 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2A41C320
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:05:39 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id 4-20020a6b1404000000b00704700d919cso8940202iou.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHBorJxtb8OOdvReJ/cspDu7cb80E+hJP4zqgvf9eJU=;
        b=OXSGdEABBAE8ZE5WV4+5hOyL4D7Z40j4EPrfc/nbMIrKuAeesQYLhAbbKhxkbDoNGC
         +CIWsTuyF3XQ2A0Yck3CLqA/XfwMvkBse+h4K1aFL/JgmiagyV6ie6KVQbEtIQC7GEI6
         Rj9/Bcus/J/rHwkdIf/+qX9r+/CPetMlXJ8ko7SpwmQY9fN8td10l8zyOwqWholrNOcS
         fnF/HLN2oF5Z+izcZbNITH6NJ07NigOyvO/LHFwAYJrOO0MRnyTL1jU92jQF/FCoVPfb
         xmMVPLTFApq1Di8LFC+DFSU4BFLRgLPmGDBKjOvRfgz8tPonMu8cBpBBq8ZzlxPfLg4Z
         7R/Q==
X-Gm-Message-State: AFqh2kqeGfakp9gYXM/iUHhJU+h3VxDiMShU8bAFCy/Fz2venzF+rd/w
        3g1lulwVFhWInGIqaTMqRaBgm+O+od/GXz5tl1XHrvyillfW
X-Google-Smtp-Source: AMrXdXuMP+pXnU29vioyn5DTxncoDXWP/ebGCT1OI1VyV4CErkZ7/qWNWt3CVaWvm9lE1o9ahTrKqTXpaELpCWNw9DQog1XK4YTq
MIME-Version: 1.0
X-Received: by 2002:a02:cc28:0:b0:3a1:50fe:b95f with SMTP id
 o8-20020a02cc28000000b003a150feb95fmr803468jap.57.1673863538798; Mon, 16 Jan
 2023 02:05:38 -0800 (PST)
Date:   Mon, 16 Jan 2023 02:05:38 -0800
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1f99705f25eb92f@google.com>
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
