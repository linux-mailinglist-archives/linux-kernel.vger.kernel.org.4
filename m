Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5BC738C77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFUQ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFUQ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:59:36 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BDF129
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:59:35 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-77a0fd9d2eeso580484939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366774; x=1689958774;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1hDavOgq5CvR+2F/+7Wz04q8hLMUgP8Nqy1uWzNuSM=;
        b=lvH07PoV7KiM91h2REm5Gk7RZw6jNNJphwaVDhJCG4YvN0SYuLd9xAKtcfbn+0MVXx
         p4BF5xchzk0hHjENxRXeAcA/RR2DOC88Y1igOTLqwHFe0jxMWMQEDJm8Lsz2iyR8Tkv9
         It9GTg4viKP+tplNhBCOooaklC3hvDqKzBmdtD94jU7QLCC/UZdZRlFlBJOTJE43W1Qi
         o090VgwdOYCBdM8NMVQxiQ0W5csq7Ob7+4/lH1uno5X7xw/jW7+IKwIbnXzo/KxzVN39
         Qr7RKbkTDZb+MAXmTTkgKgtuA5GloBjmsDYjj2rhL6mc7LfzCoYcSuGMcGuxrLXJo/iu
         AedQ==
X-Gm-Message-State: AC+VfDx+WbK1mCVVWUWJ1xNazE/mnKy21tZgomEengDcKyRaq9lehA+F
        RWmiOEJoBG6jSZrvsOucZjvTSG5Rx6w7WGJMOo6i0DepAGtJ
X-Google-Smtp-Source: ACHHUZ6GQyTvi+rPOuSowmolkbqyY5pD/8MxSjs6p9y022LfZIA3uZS3gSdLvxok+2NMcNCY3Z69Q2oq9p/By67JaeT1uMwgIU9I
MIME-Version: 1.0
X-Received: by 2002:a6b:7b46:0:b0:76c:7d48:d798 with SMTP id
 m6-20020a6b7b46000000b0076c7d48d798mr5584123iop.0.1687366774495; Wed, 21 Jun
 2023 09:59:34 -0700 (PDT)
Date:   Wed, 21 Jun 2023 09:59:34 -0700
In-Reply-To: <00000000000073c14105fdf2c0f0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033290605fea6b169@google.com>
Subject: Re: [syzbot] [udf?] WARNING in udf_setsize (2)
From:   syzbot <syzbot+db6df8c0f578bc11e50e@syzkaller.appspotmail.com>
To:     jack@suse.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 16d0556568148bdcaa45d077cac9f8f7077cf70a
Author: Jan Kara <jack@suse.cz>
Date:   Wed Dec 7 17:17:34 2022 +0000

    udf: Discard preallocation before extending file with a hole

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17327857280000
start commit:   99ec1ed7c2ed Merge tag '6.4-rc6-smb3-server-fixes' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14b27857280000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b27857280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1662e03f280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141c5260a80000

Reported-by: syzbot+db6df8c0f578bc11e50e@syzkaller.appspotmail.com
Fixes: 16d055656814 ("udf: Discard preallocation before extending file with a hole")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
