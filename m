Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330576F27DA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 08:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjD3Gks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 02:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjD3Gkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 02:40:45 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BA8119
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 23:40:42 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-32f240747cdso125493545ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 23:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682836842; x=1685428842;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvwEsqS9PQZsYf/+deAUR2EWNmmTeMlxrn6znYGJXDI=;
        b=Po4EHcZ94x+Y3DXEMZxRvNZ6IsAh+0U36MheH3GdxAkzMjP4bLpF0OLieL5KIfdCIX
         Ekhd9lwjjG3zld8xKO1l0wl/c+uMT6Ul+zPaEdWx21+54GfcGOybzT76DkqAkXdd+Sgq
         mY1+WIwkIBlcmkwWYSb09aDpTLR92hubZ84iQRfNWinOHjkSs6eVJr7eGgjwVFULM80Q
         MCMViVbEIMMcLfdGG+Ma7vnDfboayjEAXaf7F2tTdIuD+PFIvksnncFaUeNXV0vmBybe
         aQXUi3/NGOnAeroOEPm9EMd1oq5dRBXxlSna5GxpFNq955NjT1jnYRN56J8E0fIACYdB
         aJqw==
X-Gm-Message-State: AC+VfDyJjOdZjTqPqjB4OVZMNayeDyfhrYtoh3Btx1/CH3tYq2whjkY5
        S08yq8kA3suJp5+Noc/6vl4lkEemtXsK9MbFSXS/1peNBnZH
X-Google-Smtp-Source: ACHHUZ4IRmsyU86JQtK5Ix/FO+7HqfElebsLx/SZOOJCoCi+XBjP7WOVM5xmsnFNK+Eo2imSHe0jPQixE4Gv2d3q5hKneZeR9WtZ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:360d:b0:763:b184:fe92 with SMTP id
 bc13-20020a056602360d00b00763b184fe92mr9486769iob.0.1682836842176; Sat, 29
 Apr 2023 23:40:42 -0700 (PDT)
Date:   Sat, 29 Apr 2023 23:40:42 -0700
In-Reply-To: <ZE4NVo6rTOeGQdK+@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031682b05fa87fcbe@google.com>
Subject: Re: [syzbot] [sysv?] [vfs?] WARNING in invalidate_bh_lru
From:   syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>
To:     tytso@mit.edu
Cc:     hch@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 21, 2022 at 06:57:38PM -0800, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1560b830480000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
>> dashboard link: https://syzkaller.appspot.com/bug?extid=9743a41f74f00e50fc77
>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e320b3880000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147c0577880000
>
> #syz set subsystems: sysv, udf

The specified label value is incorrect.
"sysv" is not among the allowed values.
Please use one of the supported label values.

The following labels are suported:
no-reminders, prio: {low, normal, high}, subsystems: {.. see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true

>
> There are two reproducers, one that mounts a sysv file system, and the
> other which mounts a udf file system.  There is no mention of ext4 in
> the stack trace, and yet syzbot has assigned this to the ext4
> subsystem for some unknown reason.
>
> 					- Ted
