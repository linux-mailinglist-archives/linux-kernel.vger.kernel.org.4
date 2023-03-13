Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7D6B736A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCMKIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCMKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:08:49 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486D91CF44
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:08:46 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i7-20020a056e021b0700b0031dc4cdc47cso6373556ilv.23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678702125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHBorJxtb8OOdvReJ/cspDu7cb80E+hJP4zqgvf9eJU=;
        b=Uu3O6AwHZXuQ9smljHEO9VvFLwfwTb3IrOdvkSZ8BcQWdFZA6I2EaUXdBqB/JHVxCW
         AKmVF2ulVMRaI9Drtj7UKwLlgKn5Xc10+0pOzwnYIBRnOgNIn+8xcWEMIRa+wPQY9WWD
         em9vXRciFy6bzoD4MIXqaHeEbbuaEnl3xIH5SdxjvsllYu8bqZImo2UeGtbawH3XYuLj
         /m1C4HYrsYe28drzVaTtOCfJ8/jvwDrdi7pPPKQhVPxZnNQDpSkxiG7wT/XWkUP3GcmX
         d6OMWYEcm1vRtQ5NtmUALZkk9NczxroYnQFD65xPtYySVnqezifCTrpaJGWEV40rRJlI
         7o5w==
X-Gm-Message-State: AO0yUKX6bF7YHje8ci6s78c8D2bq2U5SDJmwnpUpr5XiNDEB1isKz+gd
        ON+53NCuejzzcUVr7UwAl23bNG7iPQ0cXq6CKkBdJfOT6+jf
X-Google-Smtp-Source: AK7set+QLDBL3HM2GBIs0e2NeRlDnUS0rfKdZOzo9gAKT9ZVnKKI1esGDLvqOQF/cRIKXfYMHsRJd9ExkoVPPoGSDD/SkQXWcfvo
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10c3:b0:315:34c0:d463 with SMTP id
 s3-20020a056e0210c300b0031534c0d463mr15438778ilj.3.1678702125656; Mon, 13 Mar
 2023 03:08:45 -0700 (PDT)
Date:   Mon, 13 Mar 2023 03:08:45 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e231fc05f6c54bf3@google.com>
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
