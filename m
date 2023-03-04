Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483D06AA803
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 05:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCDEgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 23:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCDEgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 23:36:17 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D511ABFF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 20:36:16 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l1-20020a056e021c0100b003180af2a284so2449792ilh.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 20:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBM8f3nfkQPiCUxCkC/1jIKN/CSWO63Mv0FZdwLHa7w=;
        b=j0cuNJmWIiTGrKAJqKiQT0KI30F8tBqegsmpEnFMM9iGlOb87+Xa68Xsnf49zAAz4V
         0bMKOz/gExEOT+sWGIAZhA/c70xUp1e+owqmViLg5Dgbc3O5kt/ifJbwWVU/cES7IQG+
         QkgetaYNt7cVGOPbJ0rCWOwBN5s8g2i+Xtv9XujcGjRrVfTII8xUfUj+eGEUzPw3a88B
         66vgsIm5WwCL3cdEi3PWQwN0V5qCAiJayC7RZvMtHrenM+5/O35HbkGIgts2uGFc1CQZ
         xUFpww1S5qFTS+PJBfTGqy5uvDKJWg8b/RlBZq8IEJSMeHUCEgm7Up0NkWjUK1ALZmTb
         cLJQ==
X-Gm-Message-State: AO0yUKUs21/2cnbfPWdpb8LcOm8ng+Ns+eJHJ/vK1jZj+mE0OUtvglLq
        cF3xWzyReMX1uMAFsFHngUiiz5m99zXLPrtgVm/7XbewDf3c
X-Google-Smtp-Source: AK7set9ivc7a0hTa59+MlzQADnVR9rVesqaUQ/nvWX6Tgg9CYI6nEEqLldZZLLoEwGD8VgHEij9xXEv9mpDaSxPxdEDomAm6DdMV
MIME-Version: 1.0
X-Received: by 2002:a02:94cd:0:b0:3e1:fb3d:4dce with SMTP id
 x71-20020a0294cd000000b003e1fb3d4dcemr1851215jah.0.1677904576128; Fri, 03 Mar
 2023 20:36:16 -0800 (PST)
Date:   Fri, 03 Mar 2023 20:36:16 -0800
In-Reply-To: <0000000000001d1fb505f605c295@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a2e5e05f60b9aff@google.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in con_font_op
From:   syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, daniel@ffwll.ch, deller@gmx.de,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, keescook@chromium.org,
        linux-fbdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        samuel.thibault@ens-lyon.org, syzkaller-bugs@googlegroups.com
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

syzbot has bisected this issue to:

commit 24d69384bcd34b9dcaf5dab744bf7096e84d1abd
Author: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date:   Thu Jan 19 15:19:16 2023 +0000

    VT: Add KD_FONT_OP_SET/GET_TALL operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120b3232c80000
start commit:   2eb29d59ddf0 Merge tag 'drm-next-2023-03-03-1' of git://an..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=110b3232c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=160b3232c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=3af17071816b61e807ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b71504c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f02d9cc80000

Reported-by: syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com
Fixes: 24d69384bcd3 ("VT: Add KD_FONT_OP_SET/GET_TALL operations")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
