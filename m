Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB365C4C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbjACRJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbjACRIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:08:37 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711E51583C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:05:26 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id z9-20020a6be009000000b006e0577c3686so8498048iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 09:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adYMTk8ru38p1hb129BlY4UFdkimdZR0g2pLW7AsFwA=;
        b=IGWutwX0Ig92sUjKqLk8CbPpUTqG2vD/bjvI+oAI4ATtcALitFCoR6djLbIEQSx1Qg
         JJ1VEDZKiZiBD69oV8g2p/MsMz/qdxYnkOjUViydYjtzPGbEaPYZAoE8dyCKMPIo41QS
         oG93qfuKTgitYJbNlend3nP5e0c2quAdYXCXeVD7HUc8EfUoaveUKmaG0dZxGxJ/XVu5
         jiS4VPAdFvBszKhJPnNap71Wn/4umbHcWYSKLoYaY89JQjkBIqTFrBQ+CBxeXiSSs80+
         bcjnCgQ/xDMrJQPHBfukTuwKTmnS6IMKGv2tByh730hWW89kGn2x99yY20sTQV4ImT9J
         moiw==
X-Gm-Message-State: AFqh2kowUV1SRqIbD/PV4eP/rWKlxL9VzIUms5i1o1IUDmu4g2KM8izJ
        cXwFkgC0LJINMJg0Z63/uX9DtYVzcdjrggyuK72QhxaA2H3Q
X-Google-Smtp-Source: AMrXdXtA96nR+fiU0f1K/N3U10YIazk1SDNfJPzQvRxLVGRier9BXi3+hjoVpgwieSuBy5521sSGRWF2oZ3YZXa4+aXSF8CxPJcz
MIME-Version: 1.0
X-Received: by 2002:a02:a309:0:b0:387:9f70:be42 with SMTP id
 q9-20020a02a309000000b003879f70be42mr2466736jai.295.1672765525409; Tue, 03
 Jan 2023 09:05:25 -0800 (PST)
Date:   Tue, 03 Jan 2023 09:05:25 -0800
In-Reply-To: <20230103095311.3856-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef464505f15f12c0@google.com>
Subject: Re: [syzbot] WARNING: locking bug in inet_send_prepare
From:   syzbot <syzbot+52866e24647f9a23403f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P3558 } 2645 jiffies s: 2069 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         a5541c08 Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1642be24480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=52866e24647f9a23403f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1799310a480000

