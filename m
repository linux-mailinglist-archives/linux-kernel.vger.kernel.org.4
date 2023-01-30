Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04998681C90
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjA3VUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjA3VUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:20:18 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A14360B4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:20:17 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i7-20020a056e021b0700b003033a763270so8170299ilv.19
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVigr/AngTP4AeYzYLLlSBWwu3Rfv21zvesyOAeHomA=;
        b=aT3mqXPGzucrjQRmDvwlKJjacCNKeM/jMEsx1TEnLZVtppkaU+WcfVJhRwvjhVnUYG
         KORTTCyy83hOc4zBlLkavgNVxviOvN952Nc3+Y2J1g9uVvdovyxha3rAEFZI/4Mqh/Dm
         coaye/5jPwXASSCtlX8YWcd63KGd7yYxPuNtoFo+QOs6IlgJa/YvwAnTvyghTncVAhOi
         bB/daKSky3u8zTNaz7wjSvgzSoSvBBisb4LiDmvh4GZb5c23kIQ81rbBEPZ9eIBjAMpr
         S4XsXnJfwy4DjBKG42YSNs+gaP1cWqqYeIRuQG13yWfVMCWGfqMdOuaxo13EvAgU1AhL
         7BHA==
X-Gm-Message-State: AFqh2kqZdglZ/hEJn6aR8XlYJILyTYfErnGIuPGXNYR+JHhUypANTfYx
        FDRiznMCD4061dNwkUOOsJ8Cog5yRAtUjO8QyXbWk5Ph8cFe
X-Google-Smtp-Source: AMrXdXs2fYUBc+3rbGqbh/9EHIdGBvyRqFWeY/4tb1v6Nocq20aoMSwubvPUBpPG8CAWTryp20yqfwB5BZ7jl57jzUeyIvBBkX9A
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f0a:b0:39e:54d8:921b with SMTP id
 ck10-20020a0566383f0a00b0039e54d8921bmr7045994jab.5.1675113616429; Mon, 30
 Jan 2023 13:20:16 -0800 (PST)
Date:   Mon, 30 Jan 2023 13:20:16 -0800
In-Reply-To: <000000000000be147305f0071869@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010e01905f381c827@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in hfs_cat_keycmp
From:   syzbot <syzbot+883fa6a25abf9dd035ef@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com,
        syzkaller-bugs@googlegroups.com, zhangpeng362@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit c53ed55cb275344086e32a7080a6b19cb183650b
Author: ZhangPeng <zhangpeng362@huawei.com>
Date:   Fri Dec 2 03:00:38 2022 +0000

    hfs: Fix OOB Write in hfs_asc2mac

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13294485480000
start commit:   3a28c2c89f4b Merge tag 'unsigned-char-6.2-for-linus' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3de84cba2ef4a23
dashboard link: https://syzkaller.appspot.com/bug?extid=883fa6a25abf9dd035ef
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1261813b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114306af880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hfs: Fix OOB Write in hfs_asc2mac

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
