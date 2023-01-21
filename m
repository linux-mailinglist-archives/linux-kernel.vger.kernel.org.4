Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9197467627D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjAUAg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAUAg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:36:26 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83477768B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:36:25 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id k7-20020a056e02156700b0030f025aeca3so4809727ilu.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgX3OLdyl63a85Teu2ThGDnS3O9jXoEr2Eos41v+st8=;
        b=mPBOzsFjhr5ZEmxYhovpZocYHwqPgWqj9WzA+5A3BcbKm660d1rk/C6m7Qm2VkCB6K
         gX/LsdlvvVx3k/PicHqIKw/qrCDGYGXQ743I80nqWlWOKQbjqjNr0To/K0bASmOf/U8b
         m7U8dqF+HKtf4w58NzOyvCITbJv4ZM1EXXFSM6La9LxuLIIZwPzc91EFATq+FY7E64gm
         Iebj5rm25vQAYaBwFYobjJhrpT0+ANL0o89kKbPgFJ84SsscYdHD07HHAsOvy4fSf76U
         CdqZZsae9nQgSsZKHVn4Ruk9amJy/BIg/mRzblporK8nGSNZPHEdz6jkRdY5A691V4SF
         fuwg==
X-Gm-Message-State: AFqh2kqVWQZYMn+ZO52PeBTIheMNA+e385+7S2qYUFcrMbVGExQBghD+
        KKfq6t6Vr7CDE6cM0qRqNHpNYrisKaR4F3oVQnb3+Ap4SjXD
X-Google-Smtp-Source: AMrXdXutvEXiengHA3DvVHKzijsZxSuGZwfw0rku6p+wlNUDnMgyL92bIuD6EeDsBmkNphjVMLrdRTrXXCoNF4iL+cUOmbY7n8P/
MIME-Version: 1.0
X-Received: by 2002:a5d:928d:0:b0:6ed:9ed6:6bab with SMTP id
 s13-20020a5d928d000000b006ed9ed66babmr1096038iom.54.1674261384909; Fri, 20
 Jan 2023 16:36:24 -0800 (PST)
Date:   Fri, 20 Jan 2023 16:36:24 -0800
In-Reply-To: <00000000000080bb5c05ebe34a4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bde1e05f2bb5be8@google.com>
Subject: Re: [syzbot] WARNING in cow_file_range_inline
From:   syzbot <syzbot+858534c396b0cdd291d2@syzkaller.appspotmail.com>
To:     Johannes.Thumshirn@wdc.com, clm@fb.com, dsterba@suse.com,
        dsterba@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@fb.com,
        sweettea-kernel@dorminy.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 8bb808c6ad91ec3d332f072ce8f8aa4b16e307e0
Author: David Sterba <dsterba@suse.com>
Date:   Thu Nov 3 13:39:01 2022 +0000

    btrfs: don't print stack trace when transaction is aborted due to ENOMEM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15521666480000
start commit:   337a0a0b63f1 Merge tag 'net-6.1-rc3-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=858534c396b0cdd291d2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e5a422880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16387a16880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
