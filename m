Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B4C69C017
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 12:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBSLq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 06:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBSLqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 06:46:24 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781ACA0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 03:46:19 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id f2-20020a926a02000000b003152ca1c48aso101609ilc.21
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 03:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlr5WDVYSCJNG2/QD15o1eE035gzrC0DW5830kTwOlc=;
        b=s2gOMUqCI5yNnb4Uw7AlxjyGhmmR2XuP15MlLZqrYKg+ANptZ0hwDA7Djx43LEb59u
         KfSVKPj3sQb5UCZQLnXr1lXrA89FdYor/Cii9jTVWjGHRkRlQjf44JUBGhgl9gsXk+EA
         VANXqtd62bzx1E3J8uRCJQAC7BnsjBJFiWhujQnGm1YXpk7GaPTDoNgX+FVPbV6108tK
         x/MquswwOVJo5uBB0kSUH2uDozLchTKza9SI/mjvjgHx0wGu6pjzYup8lcMxSpfXFav+
         l5um+AM4bN1EThzVUvo4qI7jV8T7IlWpQqRsFwjblp0u2U2B/Jt2qHbE8a9QH5YYomN5
         lm+Q==
X-Gm-Message-State: AO0yUKWJO2StJR5FUeEwdEsp5P4LD/3vNqurMqYh8VRALjqxtpVeBz2j
        74kjSlEGXH8kCaz/lhPRap8Ty7N1Jk276S3ByaRrxnQodfEQ
X-Google-Smtp-Source: AK7set+VFvL84svGepNuAsLXIrFrPy2CbjziZW+K1F36LbEQ5iGHi54c51+3wBsEKq3QsZ1lQU6Xm7ptwrPf/Dq2vtbvXdNVvMgg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ee1:b0:315:50a4:c5e5 with SMTP id
 j1-20020a056e020ee100b0031550a4c5e5mr7196ilk.2.1676807178943; Sun, 19 Feb
 2023 03:46:18 -0800 (PST)
Date:   Sun, 19 Feb 2023 03:46:18 -0800
In-Reply-To: <20230219114014.2224-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042069905f50c18ee@google.com>
Subject: Re: [syzbot] [bridge?] [netfilter?] KASAN: vmalloc-out-of-bounds Read
 in __ebt_unregister_table
From:   syzbot <syzbot+f61594de72d6705aea03@syzkaller.appspotmail.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

net/bridge/netfilter/ebtables.c:1215:28: error: passing argument 1 of 'ebt_verify_pointers' from incompatible pointer type [-Werror=incompatible-pointer-types]


Tested on:

commit:         3ac88fa4 Merge tag 'net-6.2-final' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=f61594de72d6705aea03
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170d73d7480000

