Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62CD67DD59
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjA0GG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjA0GG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:06:27 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E695F4863D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:06:26 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso2570803ilq.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDyJ38N04mO0xgV9nivS5GvKxkffckGDZTzc5D+z9C0=;
        b=s2izBXddZFL4rgIgPDbbjqzsk2b9dRgYYTbLgixU9EsbOnz8fAYYJGZUo7QSo5GpGn
         quIXPv8gnX/J+tcFcHQZzCN9TYlAlh2kGicnxw/azm495hDsMnoh0oIy5l3P4cT6qcgW
         r8x1pH1dDP3rTNSkbaKjvNc1ME/FSI+sk3Hs15vrTLOdaXTXhG5bG8+amhewVuJbFyjS
         Ks7YpyIP2E6OxYMYDTxxFzmDU0E2WlxqSjyMHcTF9DKHAbSjaodQn9QcAK1eZOrwg+zy
         5nz2DUoSyT8igJGLpvCwKTmFMM3nUIGzZJySzkkEzKZlbPvLBiYPB3FXUEbUCXiuei8q
         O0Yw==
X-Gm-Message-State: AFqh2koi+lEoWN/jjpqbsykXzRqMH8JvL5rOxxPlFy2CjszRVMWMyw0i
        HmVjeXbz0BcTfcAuUjQvSyh9W8Ps4J6eoMaVPKZN11LDNGag
X-Google-Smtp-Source: AMrXdXv5FaBDHGOquTWMpsowrpUaywSoO7kZlBoCAVMLMy5c/k532fKFKxaVlIb9ptjNI4CQjneB1NMaIqxtOwAB4DFQAxzn//rK
MIME-Version: 1.0
X-Received: by 2002:a02:ca54:0:b0:3a5:15ad:8dc5 with SMTP id
 i20-20020a02ca54000000b003a515ad8dc5mr4882549jal.103.1674799586281; Thu, 26
 Jan 2023 22:06:26 -0800 (PST)
Date:   Thu, 26 Jan 2023 22:06:26 -0800
In-Reply-To: <0000000000002f9ede05eb40cfbd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000690e9405f338aa34@google.com>
Subject: Re: [syzbot] general protection fault in end_page_writeback
From:   syzbot <syzbot+c9db9ae0bd780a3094e1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, chenzhongjin@huawei.com,
        konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

commit 512c5ca01a3610ab14ff6309db363de51f1c13a6
Author: Chen Zhongjin <chenzhongjin@huawei.com>
Date:   Fri Nov 18 06:33:04 2022 +0000

    nilfs2: fix nilfs_sufile_mark_dirty() not set segment usage as dirty

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138e4485480000
start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=c9db9ae0bd780a3094e1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ad8cc2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106b5906880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: nilfs2: fix nilfs_sufile_mark_dirty() not set segment usage as dirty

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
