Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529006BD192
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCPNzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCPNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:55:52 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE63B9525
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:55:34 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id p8-20020a92d288000000b0032314990768so867453ilp.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974934;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ/FNvgLdcXAOrzYmFGWyR+aBvsxlksNaDVN45XdDnU=;
        b=gxmJgQEi5u4xvKNB+jg/DfntI+wL2KUOkS2b3wlOGqOhaH6kQf/2SSWMZnSBv3vvm/
         C4BCjJtNAX12I5pEjeeHqZ4lPEihjyuyNTqBpon2fnkRALxojLlhTBNJawg1IP0O3gs1
         B/RQy47u+V45eW5GgppZPTeh041BTuatiwdixSsTozHJAC7A4oKwpenBfTqpiNbLt3t3
         WxYC0GWe8RCt33y8mvXeFCx2HcH75GgKvIbaIVyowx6qEgquQvnOnOZtLkAAt+Fgxw6X
         zzJEQucKYvoiNX5KVMN8zQQmdej8fLr0krb+0A3TH+jA4JBzNA3JAnRLDdSI8l3XtbTt
         sLuA==
X-Gm-Message-State: AO0yUKU0W6bFdXLEbAa9Kf4RzM8Z+uVH6nJMClIEc7eZs7jmrNEZ1q8+
        GmDwJKOupC6KYtMnDaCNSpcyqbPV9YvvYKIcsgNNHJHzpEar
X-Google-Smtp-Source: AK7set+m1GorzD/bhP5oPX5Vssl4Los5pW30QsA80xv39eHRgkqv75zSaH0CLE1RcGrOWi/tduuZ4rAk8o1B/CodDy9IrUFO78AA
MIME-Version: 1.0
X-Received: by 2002:a02:7310:0:b0:3ca:61cc:4bbc with SMTP id
 y16-20020a027310000000b003ca61cc4bbcmr22164632jab.2.1678974934165; Thu, 16
 Mar 2023 06:55:34 -0700 (PDT)
Date:   Thu, 16 Mar 2023 06:55:34 -0700
In-Reply-To: <20230316135527.GM860405@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089b14a05f704d00a@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: bad unlock balance in ext4_rename
From:   syzbot <syzbot+636aeec054650b49a379@syzkaller.appspotmail.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Mar 16, 2023 at 03:51:50AM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    9c1bec9c0b08 Merge tag 'linux-kselftest-fixes-6.3-rc3' of ..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12d6a556c80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=6c84f77790aba2eb
>> dashboard link: https://syzkaller.appspot.com/bug?extid=636aeec054650b49a379
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> 
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.5-rc2

This crash does not have a reproducer. I cannot test it.

>
