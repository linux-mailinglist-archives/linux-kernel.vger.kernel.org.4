Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB667CD85
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjAZOTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjAZOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:19:10 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53A56A704
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:18:41 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso1249956ilq.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+nF+RW16YJdagWMfMttlQoNAWgrztV2W7ki7kcH6wQ=;
        b=5jliA+WoKOc58dSQaDRGok7ZEmsuPUQguL5BILbbNkQQig2SJzPEBZyP37U3dvAXnP
         Fjzr16mFTupu/Np0C0PVoO6hI8yi7eq7Kn0b2mE72zCT3v21iVW38IbWog3Yo9cDXqqb
         AraPkck8pDR84Yg2iVBxX6cAbDhK+eUeTRZCmLuEnd/JGl+ZPVjIdxp7z6sCY9Zn0gWn
         hY9+FmTS0SsAFB+ZyWlI2BZKDsRjq2cJXbTtOEm7NsRAF0A1ZYLv5chXDVFIN9Wn5Fk1
         letEwFhubQr7BUK/4Vhlem8Td5enC7+LV0W8659axwDB1QITBDm3Iit/F6I69PRIm2CS
         n4CQ==
X-Gm-Message-State: AFqh2koMzIqMjB0AmBOkSgULE082YwXT7YT5Y/0SgXcL8Xg9MpGrfioe
        yaBrsQbx1TNq1vKkCW79xDdg+Nad5z1STw+iLUFCRV8MIBK6
X-Google-Smtp-Source: AMrXdXtcH4ugW0dNRQ7ZfF6SczQn0xpplKw5P7FtIjRWz13PZ+9UZq2GtmXnv95pBDcikeb1+ZgB8qxL2nPtmQ7KXoZTTbDWmJFG
MIME-Version: 1.0
X-Received: by 2002:a02:3407:0:b0:39e:a16b:99c6 with SMTP id
 x7-20020a023407000000b0039ea16b99c6mr3610706jae.167.1674742696299; Thu, 26
 Jan 2023 06:18:16 -0800 (PST)
Date:   Thu, 26 Jan 2023 06:18:16 -0800
In-Reply-To: <000000000000788a6905f0c06160@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080d62605f32b6bcb@google.com>
Subject: Re: [syzbot] INFO: task hung in rfkill_sync_work
From:   syzbot <syzbot+9ef743bba3a17c756174@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        johannes@sipsolutions.net, krzysztof.kozlowski@canonical.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org, linma@zju.edu.cn,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
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

commit 3e3b5dfcd16a3e254aab61bd1e8c417dd4503102
Author: Lin Ma <linma@zju.edu.cn>
Date:   Tue Nov 16 15:26:52 2021 +0000

    NFC: reorder the logic in nfc_{un,}register_device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110cbe1e480000
start commit:   9d2f6060fe4c Merge tag 'trace-v6.2-1' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=130cbe1e480000
console output: https://syzkaller.appspot.com/x/log.txt?x=150cbe1e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85327a149d5f50f
dashboard link: https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156edba0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15556074480000

Reported-by: syzbot+9ef743bba3a17c756174@syzkaller.appspotmail.com
Fixes: 3e3b5dfcd16a ("NFC: reorder the logic in nfc_{un,}register_device")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
