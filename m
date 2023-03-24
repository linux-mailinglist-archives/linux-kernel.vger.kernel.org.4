Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215476C8022
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjCXOnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCXOn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:43:29 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF422AF29
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:43:27 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l1-20020a056e021c0100b003180af2a284so1331700ilh.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679669007;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXBF2oHmHpd2NV7sQ33KXc5pi0588mwdxTN57DiNNT4=;
        b=kW58T7HvkLh4zDOBnrPsesB+cXlR+VZ4kic3JPgOrbAF28/3A3gjjJx83Ri7zikNqF
         +JQFdhOvIVAhTmrvx1SSOip8S1FRS8XuvARGkDdIbbDRApcyg+6ooS1oFo9LF8NUQiCb
         sP4kpViRHEH96p8hNUOlP2I+FxuBn/bMDMmEK8rWheVFZA0T+3G6vxhff35IE5enNslx
         TH+u43zUYWW1Xe0LA1xxnpX546WIhlh7qdlLhM3uLAaXLQdNqMIVfg4vIH0OqUOQkCG7
         +ioGzu5XFNgESVMApGwMA/IGu9dEGYtDeMTa1Xk4JZ6vh+6QguD5keAVIxFJgdakro4V
         ZLiQ==
X-Gm-Message-State: AO0yUKV96w0XvLjc63/xJrVjnaHp/9xOAJ4f/5b2qdzFlRmLIZtdhs1B
        sXsI9WRyVJO8AtSKXbg9SRMBlbfeEYgvdm9/0GJhNFWrBs3r
X-Google-Smtp-Source: AK7set/eE9N2mdtqK9PkYHONfqdNeHYN7Asa0DB6203yrH9mV9D54z0RfI9Jdxtee+ioISiIZbkKEjfKRdA5mL87+QQRT7WR2SAv
MIME-Version: 1.0
X-Received: by 2002:a02:3314:0:b0:406:2a66:b28c with SMTP id
 c20-20020a023314000000b004062a66b28cmr1045711jae.3.1679669007252; Fri, 24 Mar
 2023 07:43:27 -0700 (PDT)
Date:   Fri, 24 Mar 2023 07:43:27 -0700
In-Reply-To: <000000000000b9753505eaa93b18@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084824b05f7a66a52@google.com>
Subject: Re: [syzbot] [cluster?] possible deadlock in freeze_super (2)
From:   syzbot <syzbot+be899d4f10b2a9522dce@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b66f723bb552ad59c2acb5d45ea45c890f84498b
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue Jan 31 14:06:53 2023 +0000

    gfs2: Improve gfs2_make_fs_rw error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117e2e29c80000
start commit:   4a7d37e824f5 Merge tag 'hardening-v6.3-rc1' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b969c5af147d31c
dashboard link: https://syzkaller.appspot.com/bug?extid=be899d4f10b2a9522dce
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11484328c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127093a0c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: gfs2: Improve gfs2_make_fs_rw error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
