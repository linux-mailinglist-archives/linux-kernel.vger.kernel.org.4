Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A426334BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiKVFjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiKVFjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:39:16 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A9721274
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:39:16 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id z139-20020a6bc991000000b006dac0d359edso6486243iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDHiCNxIn/z7bNGfAT44FusXeHcFJAow6l0Lx7uONlU=;
        b=AImuDTKvPGysw0evkFtfZadO0rx71FY9xSiN64+Id8dvwfe/Xqwd6OOpqcYR5X//SV
         Oh5OeXT5ih0PPleDTwbtvJmk/M69V/SNSQrcGUFPCAbIi/LMPjCh3+00o9BPJ89YfHog
         Tb+0k0JQKcZvZ+ZVHCC+WUEBRMsmJnrygKC34O3H6UxRL8MIaOljbf2+7dyfXODkfZOc
         lKUooKMS8cssIWFM6fEG1UCMHGDMpiM7B42LwsNVsV34uTUzO8QP7T/WGGTPhLesdpj9
         7b8LL/LxTpyska+6DJe9W8h6R+H6DcoSdklDzQ/R/yqUvmKu+ogGa+UHe1IhVyJUvFLd
         MHDA==
X-Gm-Message-State: ANoB5pn1AQQQeTEBPR23ibazDIeo6dg97BgOMajNxYAYDe2ilrdyJt1P
        hNdNaheRjMEEjONQxIQfOfeFngsh84qcoAOC/4pFrnYt1C8x
X-Google-Smtp-Source: AA0mqf4a0BHoqsnrezXkaycFKNDR61DuR+fYA0esxSmDidn3Kf+nBqP+hC/zfGsOOY06ZUKKGMW9ucWsRXqiZLeyMyE9GGHbxvt4
MIME-Version: 1.0
X-Received: by 2002:a5e:9405:0:b0:6a1:48d3:149e with SMTP id
 q5-20020a5e9405000000b006a148d3149emr1042832ioj.136.1669095555513; Mon, 21
 Nov 2022 21:39:15 -0800 (PST)
Date:   Mon, 21 Nov 2022 21:39:15 -0800
In-Reply-To: <000000000000d984e005eb5ca593@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aec24b05ee0897b3@google.com>
Subject: Re: [syzbot] WARNING in cleanup_transaction
From:   syzbot <syzbot+021d10c4d4edc87daa03@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
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

syzbot suspects this issue was fixed by commit:

commit 8bb808c6ad91ec3d332f072ce8f8aa4b16e307e0
Author: David Sterba <dsterba@suse.com>
Date:   Thu Nov 3 13:39:01 2022 +0000

    btrfs: don't print stack trace when transaction is aborted due to ENOMEM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12586f7d880000
start commit:   493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fcaed6880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147d4978880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
