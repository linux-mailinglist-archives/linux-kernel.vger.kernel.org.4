Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F007076B5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjERAGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjERAG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:06:28 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E70DB
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:06:26 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7606e3c6c8aso91971039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684368385; x=1686960385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoMoqXQ0K9ottZ20H37Za5eMXtoOXhgZyhPciqIVH40=;
        b=ElRtFPs+TRjTybkz63ARQT28CroHY+KZHB5Ho9rz9NiWUJtMw9cjye+DXHLm+FPmF1
         IocSUjqoswzJwhFscvUpn19PBLmEQ4IF8mz05RodjZfX4vhhE6UX/zWuf883eSJOgR0r
         c0IVBBlTwlHtpSq6d/1+TO/sxvlajJ9yvePE5C8fjeLsbFGMz9lSsRN+h8OcQwAZRIZ0
         0s2s8APzH0oKyvxVoPjymcQxf3rA7clVnliITCU6EWBG4Z6so6L5BOECR44ZFWDiZQ9I
         cNhxqUrChYwt6caSiUKogUlRTy8h2hhD0TUXjEsy+cYsUZSbhWh7kPqF0D0IesIeYFv0
         tZUQ==
X-Gm-Message-State: AC+VfDxPrfwsmNudGco+AQ3mWY9JE7O480WlCfy8OpA1bzVIouHyWNGW
        amtCcKOBPi2rmoDK+B51UlhoUP2LARadY6gW5Idp9oaoYruT
X-Google-Smtp-Source: ACHHUZ6DNGJMApeEtlCbWYZKgYUwbD77h7Sl32mT1FuFXMAbv1g8H2Rp/h6l/JOhvlYQ3m90Yo89xTWn99FpYmbgBWBt1f8GKVyH
MIME-Version: 1.0
X-Received: by 2002:a5e:db04:0:b0:76f:d7c2:aa54 with SMTP id
 q4-20020a5edb04000000b0076fd7c2aa54mr3866659iop.1.1684368385810; Wed, 17 May
 2023 17:06:25 -0700 (PDT)
Date:   Wed, 17 May 2023 17:06:25 -0700
In-Reply-To: <000000000000d03b0805fbe71d55@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ea77505fbec93b6@google.com>
Subject: Re: [syzbot] [erofs?] general protection fault in erofs_bread (2)
From:   syzbot <syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com>
To:     chao@kernel.org, hsiangkao@linux.alibaba.com, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
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

syzbot has bisected this issue to:

commit 6a318ccd7e083729cbcdbd174d7070f6b7d24130
Author: Jingbo Xu <jefflexu@linux.alibaba.com>
Date:   Fri Apr 7 22:28:08 2023 +0000

    erofs: enable long extended attribute name prefixes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=159afed9280000
start commit:   f1fcbaa18b28 Linux 6.4-rc2
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=179afed9280000
console output: https://syzkaller.appspot.com/x/log.txt?x=139afed9280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6beb6ffe4f59ef2a
dashboard link: https://syzkaller.appspot.com/bug?extid=bbb353775d51424087f2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd834e280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167ef106280000

Reported-by: syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com
Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
