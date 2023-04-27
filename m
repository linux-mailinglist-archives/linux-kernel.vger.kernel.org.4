Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643C6F0ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbjD0Rb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243441AbjD0RbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:31:24 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0776A110
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:31:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-329572e5abeso133374895ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682616683; x=1685208683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUlb2jQpUPLeatHfobfTWKSKYzA/oDXwJnYhGmKuIMo=;
        b=f5D51iexpi/Bq4mM1d+d8IORUcTK0ijifEPpNXpkZu+EqDKjLqGhZ+8dLy5/S7TcYz
         99w8Fke9+G2wVL42sunEky0fy5W9+9LbegP5i5x8n3wasqYpDdampkFgiMQxl7qngRoa
         JtJBB5/8y/V77DnUqQbw+CX5FkuV+9g/sKd2bvcJlA/Ucb6/0dJJxC25Mjy4A0i4Wp4k
         ewx0UZXn3Csy5FBybLqHAZ9z9dDGuENNo4fy2IHxbfJCjH4xMlxh+Qyb/38wTUzS3aMu
         cCU6rAuGgOsKoSzpa7uDoqHyDrV0ZlkrXYW2k1BLMwGos6gpkXznAp6l9ZiEcQ/JNqmf
         KXmQ==
X-Gm-Message-State: AC+VfDxK86nFfQb7gLZVXpXB0Yvq1fRysHGmSobPXBfwZfYJBYcOO1pu
        j9Q1gj+aRldbVn+qsDwbEmFJEGC1O0Qz9+9ZXdDDUE/Dl4wp
X-Google-Smtp-Source: ACHHUZ406V4aWDyomSLGEJ+Er6RgS0rjyP9CbCoIhylq0ovKgQ8PScAFr1oadne9VH/aIUEzm1B81YXsTDIw+KgyavLgvgA+352O
MIME-Version: 1.0
X-Received: by 2002:a92:c009:0:b0:328:c3ae:ec08 with SMTP id
 q9-20020a92c009000000b00328c3aeec08mr1728914ild.1.1682616683390; Thu, 27 Apr
 2023 10:31:23 -0700 (PDT)
Date:   Thu, 27 Apr 2023 10:31:23 -0700
In-Reply-To: <0000000000003f3d9a05f56fcac5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4f18805fa54b9f7@google.com>
Subject: Re: [syzbot] [kernfs?] WARNING: suspicious RCU usage in mas_start
From:   syzbot <syzbot+d79e205d463e603f47ff@syzkaller.appspotmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        david@redhat.com, gregkh@linuxfoundation.org,
        liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 6db504ce55bdbc575723938fc480713c9183f6a2
Author: Liam R. Howlett <Liam.Howlett@oracle.com>
Date:   Wed Mar 8 22:03:10 2023 +0000

    mm/ksm: fix race with VMA iteration and mm_struct teardown

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1674715fc80000
start commit:   f3a2439f20d9 Merge tag 'rproc-v6.3' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd442ddf29eaca0c
dashboard link: https://syzkaller.appspot.com/bug?extid=d79e205d463e603f47ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cfaf1cc80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149edbf0c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm/ksm: fix race with VMA iteration and mm_struct teardown

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
