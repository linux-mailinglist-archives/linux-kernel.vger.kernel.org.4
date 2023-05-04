Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B710D6F6CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjEDNb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjEDNbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:31:23 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821FC4C24
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:31:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7638744ba8cso27404739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 06:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683207082; x=1685799082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVwBEos5iu7/7J5iO/o1soHBlv2P/o3LvFqCNG0issM=;
        b=H2PzBkPlwzyuh9MezNVWLuAzTFE7ELOkVb7yjfjinL88z0l9WLF+mhJwN2dM/oEeAF
         vzCAiumZBQ9EcS2+DKw9PPabnM0w9KXcBw8/CrsHYE9Cgfi6n0Np3L/HLIsjleZzw6Fw
         uQZwUP8J/fJ1k/M4UjkLZNc6kMjzlBFZSDVXj+qcUnhzZe4Fggzuf4DoQQlRNxqEl3NU
         z5LF2W/eCnUotr+e2Cq18XAbe+5+t18AntARBAjGSxsPpSR9d3ihQJrLzN34SahXKQaF
         YdMkzllD/WSVAIbww2MzaceaHcdGue34xNEBWSOKV3aZfKQEo1LyjKraVOsjJR+goko/
         5FQQ==
X-Gm-Message-State: AC+VfDxJx3fm9nh1geznZHi8ZwyceItYYahNZEN4JaqKWSiMa+1RWlgP
        gZXF0X/F9urmSW3C7H2j5pTGzvwrEZfzfpCJFp5jZaa+tJQS
X-Google-Smtp-Source: ACHHUZ6HupuhWKorQTNyrYyET7P6ooqBC7PUYwkkiIVJKVyMN7QnPrgbhC+psr9Yh1NWkqdeopoSP95IVRVzcAlLaCZ5RvC47QLG
MIME-Version: 1.0
X-Received: by 2002:a5d:94d1:0:b0:763:dd01:e143 with SMTP id
 y17-20020a5d94d1000000b00763dd01e143mr12018818ior.2.1683207081855; Thu, 04
 May 2023 06:31:21 -0700 (PDT)
Date:   Thu, 04 May 2023 06:31:21 -0700
In-Reply-To: <fb9b6de8-1efc-eeea-7acb-09d291590576@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032909d05fade30c8@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_write_single_data_page
From:   syzbot <syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         2adb872d f2fs: fix potential deadlock due to unpaired ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=114b5338280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86e4eb913e90d4b2
dashboard link: https://syzkaller.appspot.com/bug?extid=eb6201248f684e99b9f8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
