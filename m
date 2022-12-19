Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1BC651581
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiLSWYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiLSWYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:24:18 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BF5655B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:24:17 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id e15-20020a056602158f00b006e01d8fa493so4725958iow.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76mJq/l4HZlpTiL5oLX0kKwVOqHktPVtqBnvtIS30Wc=;
        b=QYMc2Yj124t0c/FAkVD8P4Qhv+cXaKPHXyvvgTsVIyq8kZ3TLbL5whfhqF3ndgszXU
         U5kbmQDxrwEJgC34W+b06r4enS9sf4HvJ5rpXvSc3c/mrOO57o23VhPOUqW6V1/QtEId
         K140xFEp6lQnQwoEeHRQeKAIF3F9hEJXqUkHVkuXyuAByPA7StjEKkPo8M7+I6jApe1C
         Ft1TabfSNdc19MlAo3ZDVA7jqY1aIgNp36RseBjh//SMrcumDkVElD88qYEOiOpUyA4t
         tIyNmoR26UzIOKehjc/OOnpqu5/qLApwQkEyRBF9VQxJameE6kibwyZq0iw5KTWZIcVI
         NMFw==
X-Gm-Message-State: ANoB5pk/cHiYq+J7IMZ7sY0OIfAuOKlURhIkuo1GabqEVEVqydz9tkYf
        GUbkWD6jc/5qpXaWpSzZuP1JfBeUjA1KahmQehsfJ1tMC8Cx
X-Google-Smtp-Source: AA0mqf5koWrdgDmYUjh4xKAo1ta9oaVFjF3Be9Dw1NrhXCgSKhjJG/4FuFiOWekR09ThaBrobDJVV94M5L5993+HxdV02lC9kQwo
MIME-Version: 1.0
X-Received: by 2002:a05:6602:42c2:b0:6e0:117f:f0a7 with SMTP id
 ce2-20020a05660242c200b006e0117ff0a7mr9222393iob.127.1671488656681; Mon, 19
 Dec 2022 14:24:16 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:24:16 -0800
In-Reply-To: <Y6DYsN+G3mdKP/Bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0afac05f035c7a0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org, sdf@google.com,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/events/core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1451cef0480000

