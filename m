Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7AD728E74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbjFIDRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbjFIDR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:17:29 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5864A30FE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:17:25 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-33db528e4faso10573835ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 20:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686280644; x=1688872644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gQPNTD4llJBmvmnSf20wHOIxgRYmCJ5tVCUw9Zbzww=;
        b=XqpH6n8yrd4nrWSuS0P7j7zsyqibbulg64RNK0bklM2QrxEvxsjS3JCvNwyrh+z9RN
         5cygSPIHW6mNaEnqNxTbm0qj7jCTPf0GbtHEuH2hiyI7briIlJTGZs7oKaOJmT/GySdW
         VkjhkiRPNXQ7TeCp4Y+w36wiEb9D4b0C8W1t5w8FYSdQxM1aoztj8nlxRlkYcBdTZy8Y
         fuTh4hNHqca9U3BEN3/mx13FfmBri4Yh02C0drTnqOEyw2Wh93UzZ5KdC1qNJfFaYsD3
         p857BRxLRWIbOrpW4vcomEjXTa1M5ef6pxmk5guFTpT8lrevh3ByDUVha3lCEGdQG2Oa
         diOw==
X-Gm-Message-State: AC+VfDxGYNrWTGbl0UIuZl0WAqmaXFGutPwMxlLyS87XPiIvgdbdPYkB
        /jGd+LAKZ9XVFir3Hb7C9O4YwsNvM7lSekH+jCJw2QdMTABi
X-Google-Smtp-Source: ACHHUZ7h4fdwyQcom4nMSRbkpxA94XosftuaxZBxJrfb0ViClrnrepF5QHquGgetNwTGmEwN5m+Rwl7lqBisbBEhAcOYB20u72C8
MIME-Version: 1.0
X-Received: by 2002:a92:cac5:0:b0:33d:5314:d74e with SMTP id
 m5-20020a92cac5000000b0033d5314d74emr304446ilq.4.1686280644677; Thu, 08 Jun
 2023 20:17:24 -0700 (PDT)
Date:   Thu, 08 Jun 2023 20:17:24 -0700
In-Reply-To: <000000000000bd448705fda123f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1565005fda9cef1@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in static_key_slow_inc (3)
From:   syzbot <syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        hverkuil-cisco@xs4all.nl, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit eb1d969203eb8212741751f88dcf5cb56bb11830
Author: Hans Verkuil <hverkuil@xs4all.nl>
Date:   Fri Oct 21 12:21:25 2022 +0000

    media: vivid: fix control handler mutex deadlock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16af9d95280000
start commit:   5f63595ebd82 Merge tag 'input-for-v6.4-rc5' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15af9d95280000
console output: https://syzkaller.appspot.com/x/log.txt?x=11af9d95280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=2ab700fe1829880a2ec6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142e0463280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a32add280000

Reported-by: syzbot+2ab700fe1829880a2ec6@syzkaller.appspotmail.com
Fixes: eb1d969203eb ("media: vivid: fix control handler mutex deadlock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
