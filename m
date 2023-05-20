Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9570A777
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 13:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjETLCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 07:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjETLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 07:02:28 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206941B5
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 04:02:26 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34KB2PZM022470;
        Sat, 20 May 2023 20:02:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Sat, 20 May 2023 20:02:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34KB2P26022460
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 20 May 2023 20:02:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ecba318b-7452-92d0-4a2f-2f6c9255f771@I-love.SAKURA.ne.jp>
Date:   Sat, 20 May 2023 20:02:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [syzbot] [kernel?] possible deadlock in scheduler_tick (2)
Content-Language: en-US
To:     syzbot <syzbot+ece2915262061d6e0ac1@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Mel Gorman <mgorman@techsingularity.net>,
        "Huang, Ying" <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <000000000000cef3a005fc1bcc80@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-mm <linux-mm@kvack.org>
In-Reply-To: <000000000000cef3a005fc1bcc80@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks same pattern with https://lkml.kernel.org/r/6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp .
I think stackdepot needs to drop __GFP_KSWAPD_RECLAIM as well as debugobject did.

Like I wrote at https://lore.kernel.org/linux-mm/d642e597-cf7d-b410-16ce-22dff483fd8e@I-love.SAKURA.ne.jp/ ,
I wish that GFP_ATOMIC / GFP_NOWAIT do not imply __GFP_KSWAPD_RECLAIM...

On 2023/05/20 17:26, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f1fcbaa18b28 Linux 6.4-rc2
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1332a029280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3dc1cdd68141cdc3
> dashboard link: https://syzkaller.appspot.com/bug?extid=ece2915262061d6e0ac1
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f9e1748cceea/disk-f1fcbaa1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6dea99343621/vmlinux-f1fcbaa1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f5a93f86012d/Image-f1fcbaa1.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ece2915262061d6e0ac1@syzkaller.appspotmail.com

