Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8E6F870D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjEEQvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEEQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:51:21 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA7160BD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:51:18 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-32f240747cdso115398465ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 09:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305478; x=1685897478;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbnGNgdItHlqccm7N8gfCurOL2pfovrCoWlBfE15OrI=;
        b=F7a7wHn+GnohaA7qdsulxdD/eEY5GWPUOfQkh55hVc8O9FaujgbvW7gehYuvapnVY8
         zNbqHDWBd5EWYwa/U0P09EnW4h8Im1Gkd4YNTVo+kSScSpzpTIF74vxuKCuZpag4G8fa
         2UJQ2jH4gIkfQIX+iGIDiwxmZz42suImDLxUKSza2E++rzOJ8Ju3MGVFTx8jnSxvig7Q
         0EvlWroYYidB+YU8LFc5ZbOIzBYWIMCkfdc+NOritAouzHgZg+k8HLb01aa1niWgtv3b
         gdgnsRyb+u2vM4dfjOsF4FZSZYeghUXRv2HsCi/nGShT9rjwvKFkxUn+VerUJXljxeEC
         htDQ==
X-Gm-Message-State: AC+VfDyM+YUeyQaPSlj36DopRxjJAm72hX732zm1o7hjUWxTp3MfYh8z
        xVbuRFSvcmM9X8g3H8YDpsjOxgYIL/hgmYRBehaFFtCNINx1
X-Google-Smtp-Source: ACHHUZ6nCwvxjaFQY1guH99PFmSUDzgXw6D1xJYhAHc386/xa4SGRfEEaP7fokaIOotO7bdkluxF8YTZpNfMgtwKc/w2zoRa+5cG
MIME-Version: 1.0
X-Received: by 2002:a02:a98b:0:b0:411:b866:8345 with SMTP id
 q11-20020a02a98b000000b00411b8668345mr1210931jam.0.1683305478246; Fri, 05 May
 2023 09:51:18 -0700 (PDT)
Date:   Fri, 05 May 2023 09:51:18 -0700
In-Reply-To: <00000000000016552c05f1d7e734@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014678c05faf51958@google.com>
Subject: Re: [syzbot] [mm?] WARNING in shmem_evict_inode
From:   syzbot <syzbot+3d4aa0d3e784b29b1520@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com, jiaqiyan@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shy828301@gmail.com, syzkaller-bugs@googlegroups.com
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

commit 12904d953364e3bd21789a45137bf90df7cc78ee
Author: Jiaqi Yan <jiaqiyan@google.com>
Date:   Wed Mar 29 15:11:21 2023 +0000

    mm/khugepaged: recover from poisoned file-backed memory

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f67032280000
start commit:   3c4aa4434377 Merge tag 'ceph-for-6.4-rc1' of https://githu..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f67032280000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f67032280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1d541e02d3faec
dashboard link: https://syzkaller.appspot.com/bug?extid=3d4aa0d3e784b29b1520
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d1973c280000

Reported-by: syzbot+3d4aa0d3e784b29b1520@syzkaller.appspotmail.com
Fixes: 12904d953364 ("mm/khugepaged: recover from poisoned file-backed memory")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
