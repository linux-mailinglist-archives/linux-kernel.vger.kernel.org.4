Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8563713965
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjE1MKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 08:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1MKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 08:10:33 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528B8AF
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 05:10:31 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76c6c1b16d2so383692639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 05:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685275830; x=1687867830;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wm6IKPj1vMMJrUxmKpUlCDI+xA2XUJA6ZIRpAJeh0E8=;
        b=O2c83ZFun5mqxe7LGtLp3KX5VzqtLAfzwB9XiLLKIljZKDFeCykbepaQj7ujWiLGTw
         UOFd6UuDUPv3CcBRx4WSclzpmCrjF+Ek0nVQHFSUJWOZCdD4uzKU67Q5rDEc/kPkXngb
         pcAwoyolWc720Ki2XhZVG+088kvipq6j98vIC1NP/9/cUtxPAj57eL25QDBDfyYvbYOs
         Zx4/JbJWwe+TP59XbxS+j8BQj3cVnm2Fk926QXfFmoWndixEGlTLnKL/7+c4NYsu92V6
         WeKj2VZ8LwiIg5MZZc7fExCTkQYRvbtcajZqIbW5z8rC78SFWbta5WL8ihgZe4eBHp60
         NM0Q==
X-Gm-Message-State: AC+VfDwqNDZ42xNS6EUyXTpftTs4K7Oqh+HxMNBZ9TLlDqugAKbfSYbn
        l0O9my0dlTnNU5NIl+aewh/nWTPX76NZPcqqTzxdspLTxZDX
X-Google-Smtp-Source: ACHHUZ4CR5b8H0wmXLm7aJuF4Tdf0/z5aCLMklVGTfClc5kah2GMYkAu7IYkwVnC9s8+LAyLxMv4TPJTEkHgsZglzH11TYR1f/JW
MIME-Version: 1.0
X-Received: by 2002:a02:948d:0:b0:41c:feac:7a9a with SMTP id
 x13-20020a02948d000000b0041cfeac7a9amr1722550jah.5.1685275830699; Sun, 28 May
 2023 05:10:30 -0700 (PDT)
Date:   Sun, 28 May 2023 05:10:30 -0700
In-Reply-To: <000000000000540fc405f01401bf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ccc9b05fcbfdb68@google.com>
Subject: Re: [syzbot] [xfs?] general protection fault in __xfs_free_extent
From:   syzbot <syzbot+bfbc1eecdfb9b10e5792@syzkaller.appspotmail.com>
To:     dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b2ccab3199aa7cea9154d80ea2585312c5f6eba0
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Wed Apr 12 01:59:53 2023 +0000

    xfs: pass per-ag references to xfs_free_extent

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1007e5c1280000
start commit:   02bf43c7b7f7 Merge tag 'fs.xattr.simple.rework.rbtree.rwlo..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c59170b68d26a55
dashboard link: https://syzkaller.appspot.com/bug?extid=bfbc1eecdfb9b10e5792
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1798429d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161b948f880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfs: pass per-ag references to xfs_free_extent

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
