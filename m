Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0425D68CEC0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBGFMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGFMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:12:20 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1DF1114F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 21:12:18 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id y22-20020a5d94d6000000b007076e06ba3dso8449983ior.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 21:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cPjBcGwZD2ophWmZxRGZrb+97SOFYbGlMWtHxkjYIg=;
        b=fWDTkmmMPfqNwqbMApBY0WpEiOaqCwLGzZnC9Z4J6/k+8b0KhTNRPTZREYdHPPzuml
         d5NtqRUty2mNJdQoZ07ui3IUfACSfLc/t0kbvNDu8KpxELfBG1ec4nqRI0rGRhoiMXlh
         zbUGRbtn2k3U7yRYYromob6hcSw7MromJBm7I8hVoQkcgZNPnCXohRRfoHK1DW1BSMiN
         0djzSWGWpRuK/Nzbkx6xH0DnYhpx8wX6Z4mRXKXQl/439LB+uA2x/GQJIJIuwLGVQgqu
         eiOphrPMhw8TORGLJiyYPAAK/mwuvDP4CWV/pPGTValWHgOYdp+SFmR1MlhouYGsyXHC
         NudA==
X-Gm-Message-State: AO0yUKVzyZFVZb65xLXAwJjMiiNYu30dRtbFM/CQN4/OswJflHua1xLJ
        W8neCjKxr3iTSUDR1hd7/R/J7MWQRjR15ZGD18y9h02/0QHK
X-Google-Smtp-Source: AK7set+Yd4wgZadneDyYtwG4rFouPd4jxRWSkb7sxajkMRRAm6vIOUF33Lc41F6AukMpZc1jcAzGCMxsWUm2f2HtQdmMT8yjiJQi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:be5:b0:30f:5544:8f99 with SMTP id
 d5-20020a056e020be500b0030f55448f99mr1062078ilu.30.1675746737974; Mon, 06 Feb
 2023 21:12:17 -0800 (PST)
Date:   Mon, 06 Feb 2023 21:12:17 -0800
In-Reply-To: <20230207045013.1083-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cf67b05f41531f7@google.com>
Subject: Re: [syzbot] kernel BUG in process_one_work
From:   syzbot <syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Bad rss-counter state

BUG: Bad rss-counter state mm:ffff88807ac59200 type:MM_ANONPAGES val:1
BUG: non-zero pgtables_bytes on freeing mm: 12288


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=130232a3480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=c0998868487c1f7e05e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10602ee3480000

