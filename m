Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1F97456C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjGCIDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGCICl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:02:41 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65516E5B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:02:20 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1b890e2b99dso11102155ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688371304; x=1690963304;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfNeFv/Jw5jhtJb8APLTMFrU7cthcxZCp8o3g2rnmFc=;
        b=W0JUNytH7CKb/u1vFWYn+04o/Or+fxbZKttdeFPHGmR+S1Jl3iGjG1MqcKBTgoRVwZ
         yesxGRWwYjS9ZwT3NvSzCZb3z8UrHPBlXZc+7JqRTZ3BgodWg/gRtamH6eO4QRaPNYsx
         CGwBKer872S3FQqOfqsGrCkFvfB54WQGQM8ziqnbBec4pAnYW46zyE6LqW2Aus19Zjof
         GZNRI30fSjQBOMyUvX5F/CDWyEex1mQm/ixt7maJcAO0Sum0KQGxzJYkc5dAThQF6aIx
         OdWIEFRQFixuUGy1zrZnuhInQokzE8pus7XzMhLG+IGyIOgcQwXHSo5EA1DeNf9ivzMg
         Vxmw==
X-Gm-Message-State: ABy/qLZTnlZpyICFqLPUmK7hHqoxffdJL+TVn//PpC+OiHFJIXxZmsZC
        lUpTvVmGpjpjG4QOJe2huRiZGJY2qO6365xdY93YjGuJmElF
X-Google-Smtp-Source: APBJJlHJdW8cPjpYEEcPBbId+Rfkx/DY/I5xdl/QyMf5OH8C9dooAtNRER4olIr59NA1z0C/DANxTKe+W7kklN66nK9F7dsOs9OH
MIME-Version: 1.0
X-Received: by 2002:a17:902:ecd0:b0:1b8:3fbd:9aed with SMTP id
 a16-20020a170902ecd000b001b83fbd9aedmr8194818plh.3.1688371303955; Mon, 03 Jul
 2023 01:01:43 -0700 (PDT)
Date:   Mon, 03 Jul 2023 01:01:43 -0700
In-Reply-To: <20230703-unpassend-bedauerlich-492e62f1a429@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2451605ff9093bc@google.com>
Subject: Re: [syzbot] [kernel?] net test error: UBSAN: array-index-out-of-bounds
 in alloc_pid
From:   syzbot <syzbot+3945b679bf589be87530@syzkaller.appspotmail.com>
To:     brauner@kernel.org
Cc:     brauner@kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Jul 02, 2023 at 11:19:54PM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    97791d3c6d0a Merge branch 'octeontx2-af-fixes'
>> git tree:       net
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11b1a6d7280000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3945b679bf589be87530
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/2bd5d64db6b8/disk-97791d3c.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/cd31502424f2/vmlinux-97791d3c.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/33c6f22e34ab/bzImage-97791d3c.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+3945b679bf589be87530@syzkaller.appspotmail.com
>
> #syz dup: [syzbot] [kernel?] net-next test error: UBSAN: array-index-out-of-bounds in alloc_pid

can't find the dup bug

