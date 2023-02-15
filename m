Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D019697619
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjBOGCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBOGCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:02:41 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B0155B1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:02:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so17895344wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cMA9E/Fk+zOFexE6LGH5wlHSQfv8PVAef4t1hJo5VsE=;
        b=nDQluRYk4z497UGB+a+St+T8yu9W6tjAIItaENzcIY74IT505va6UvMlYRgh1TjQsB
         thJCmQqYAD4o3mO+RL+Ywf3/Em26/dLsuKM6Cb1QmnjzfQIiX/WNM1K2rFdDWSGg6x/D
         18whotwhdc5zpmpn5Fp3tZI9Y1IP1aVfYkzVpzSi8FdRmIlXXT4YuAYArhHMlF5Mfscu
         IT5w8MYAV3QyGjuQXohoIuI3e89OjnsrppcIjA8iQ2IXnnsZQO+Lasc0tggnsMp0rD6d
         EG3y1n0sWEdiKR4OO7Vrr2qtFCZP1ufbfwEqnapXmCTRe84VKJrkaylXyf2JyKj6iZEL
         vBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMA9E/Fk+zOFexE6LGH5wlHSQfv8PVAef4t1hJo5VsE=;
        b=y2bdqDwHNTRYisP+WBZElm9noV/+XpXctOs0jVjx37C6Im/YlMCFJ8rzXUNTI36ktL
         Jc7OvXJWR4Rae0nbXBZBtIq/qACY39riqTWRzP4yKCJeYGcEJxrY++u3duJKpUDk/6LP
         mp/PD3mcOWep3n5fkhrDFQ/nKQGMtsYWKR/JoKbPk8sKKRuwiWgOAs5vQTg5Fl2Cugmz
         kgD7+wRoVwEehYUOyFXDRxdeXkQkj4kFISq0EPLAjXoeeb7barRiaQ2WWmEBtIiLgQKr
         Zfubgaxyuc3xv8Fq9bwD1on/iNAHSD3s3b6SdlggtRLLRAV8aW0nJQMlpaPoOwCawOb5
         YBQg==
X-Gm-Message-State: AO0yUKXDfysgvdIOZClnG1FmXsIvGawOuW+CBc3TQ1MEnyAXpvmxvAlG
        qAAW06jlkhmGcpE9Rt4m0FlPQyS3srVR5d4vHXqk3g==
X-Google-Smtp-Source: AK7set+yowuM5clzipIw5kttFNpRCu8Sl95L/EX4K92hW+WW8leRnkI3oPQ5iO3W5KOvTM/8PioYNoQyS7BcIZgLH30=
X-Received: by 2002:adf:f982:0:b0:2bf:bd46:908d with SMTP id
 f2-20020adff982000000b002bfbd46908dmr12903wrr.580.1676440958716; Tue, 14 Feb
 2023 22:02:38 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004e1dfa05f4a48e6b@google.com> <20230215015231.3646-1-hdanton@sina.com>
In-Reply-To: <20230215015231.3646-1-hdanton@sina.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 14 Feb 2023 23:02:02 -0700
Message-ID: <CAOUHufYzJoh=Pvican+c8E5-5vyv_TuVaa27nDKXw3CLR=ca5A@mail.gmail.com>
Subject: Re: [syzbot] [nilfs2?] INFO: task hung in nilfs_segctor_thread
To:     Hillf Danton <hdanton@sina.com>, Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 6:52 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Tue, 14 Feb 2023 00:14:42 -0800
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    f6feea56f66d Merge tag 'mm-hotfixes-stable-2023-02-13-13-5..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=165ee62b480000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=42ba4da8e1e6af9f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f0c4082ce5ebebdac63b
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ba7207480000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fd30d0c80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/1ae0143f08d5/disk-f6feea56.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/18b8a23fa0cb/vmlinux-f6feea56.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/d915f4c5c8c0/bzImage-f6feea56.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/1acd3b288433/mount_0.gz
> >

> >  folio_mark_accessed+0x51c/0xf00 mm/swap.c:515
>
> Syzbot was launched without MGLRU enabled [1].
> Dmitry could you turn it on by default?

Thanks for the heads up!

(I should have followed up with Dmitry earlier... doing it now.)
