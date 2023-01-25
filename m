Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B10867BF86
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjAYWEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjAYWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:04:19 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961B146160
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:04:18 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so114441iln.21
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4j4zAJC/2EmwcnJP6ftS+as+swMxwqDT2ysbAjVEwgg=;
        b=o5n8fvpvNUeQFqmt0riGYMROpvsCkMOqMT1JB0O/TLnpwKzWaI99sebXMKF8nXpGO8
         UW+jArwlWmLoTQXi4lhu9pKvPqE2mScl5cMwsZ3C5YLv5kTTSA1mtR35165Tu9gUuiBi
         EZRrBaOccd4e/Z79ClhtdQ7T6ngcHNkRXH4qwuEI1stnFWnzxcDArIOFKq8ujYYPoPgP
         IDybbam+e3iOebjM62eB5w300tBrgcBz0mYFL9xt85YGH7ZtIc8F2n1at35eXKQ9nEkW
         0ulHQr5wr9pNhK0534LMOrw0zRuMkivFrix2Fsy1AlaZBnq2YqqKhzeDJ3JqvQhHjbWS
         THnQ==
X-Gm-Message-State: AFqh2koIjtd2H8DxrClIEOcoLNXpnIHcVeA7V05KXhaCSV3K6XpVkhy5
        BJS5g4NjzhLxHacDlGxrD67FiUvzT5ZZiDfAksHnS9w1muIV
X-Google-Smtp-Source: AMrXdXucSaA625/s6uPzA6SiNy1W0s/WQZpWA+bZBhdUxkCbA4b2k/chS5hFSQovYB03eW/NrRrmDfrFkVu9wRVrqVvNHlR8mbsQ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:372b:b0:3a6:aff:8eca with SMTP id
 k43-20020a056638372b00b003a60aff8ecamr3995209jav.187.1674684257909; Wed, 25
 Jan 2023 14:04:17 -0800 (PST)
Date:   Wed, 25 Jan 2023 14:04:17 -0800
In-Reply-To: <0000000000009ecbf205dda227bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004dc42605f31dd05c@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in mas_next_nentry
From:   syzbot <syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com>
To:     Liam.Howlett@oracle.com, brauner@kernel.org,
        dan.carpenter@oracle.com, dvyukov@google.com,
        liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        wanjiabing@vivo.com, willy@infradead.org
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

syzbot suspects this issue was fixed by commit:

commit 59f2f4b8a757412fce372f6d0767bdb55da127a8
Author: Liam Howlett <liam.howlett@oracle.com>
Date:   Mon Nov 7 20:11:42 2022 +0000

    fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129e8afe480000
start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=7170d66493145b71afd4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bfb2a9880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b1d319880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
