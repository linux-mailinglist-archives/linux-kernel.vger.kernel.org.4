Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D74628B78
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiKNVmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbiKNVmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:42:50 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C1819001
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:42:50 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r18so11380466pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPn/wfFTp3jxDOdfQANEH8KPamufk9IhmkNP8DK3lpI=;
        b=CSSVtIIsW/hqYyvPfSqEPJm2HNU//6Yy6iuKqDGypiUHEpC5hdnv/fz0XPNei8kXIc
         Q/r3cO1NeJdoeCbrws0o9sfCyj3RzaMcCcm7T7qED/owqurw4rEJsKvNgyakjQ4TQgXL
         Iq6XQPwOsumHT7Uykbutg3+EIJUhkZfBITabFPnQhQyqu7WWvy4s7tDlbRx+0BiyNqJU
         nvqV4EJqVVdOsURr6aHrR6uqIzAR8ySvtGz91Hd0GgluCutekS4r5m5T/usgw9TIO4bI
         skDq6KgXRn3rZ5DfXLBj2e/PCIi/cD1fe+vrke8lZSEV0zb97DhLKJVuHuOmHswAXGmX
         OkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPn/wfFTp3jxDOdfQANEH8KPamufk9IhmkNP8DK3lpI=;
        b=WtfrnxK5Feh45vNN3z2rZs0EMvHISUagoIfAaDoY4RKq2+TIeQrbrazzEQ2vmVpnaQ
         3CTYO1k+ova1+jjViPiN+NRzOrSN21aqEkzZ5DFDsY8AAvQbQ87SZvSvMzaUDmuzfIf3
         Jo3Aqvqy5kyOUCPfRDvFs9pNW40ePXTycymGH5fteZ00OJUTLaYDwt+4RtFfuAUooPRO
         0B5FTVqJoLIuILSG/k9nw+r0ODCUVpMi3bK4kvmpiQFhJpf9KQyA+X6XsRTl6TpF3IAv
         IGo/693Vymv225O4tJ/6EWqlu+o0DwOI+a8NnI8MSNbeP9Gt32iUXAuI6vt6ZJ5nH/oY
         2zgA==
X-Gm-Message-State: ANoB5pnqEfOMe82lC57nysyHp2ATShmjTFl+TAOh5aIWxVmpFhm0aRiV
        /6rT9QdmXZ8CdORFiPhaRrM=
X-Google-Smtp-Source: AA0mqf72URkOJZc6q2SP76lLrr6c4u/NI5Mu958Mevg4rt7O3UYYUIPRbnyllWd+MNTHzpMUM2GhhA==
X-Received: by 2002:a62:c546:0:b0:56b:d03d:fdb4 with SMTP id j67-20020a62c546000000b0056bd03dfdb4mr15242062pfg.79.1668462169254;
        Mon, 14 Nov 2022 13:42:49 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c20500b0017f36638010sm7944272pll.276.2022.11.14.13.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:42:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 11:42:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     syzbot <syzbot+782984d6f1701b526edb@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_activate (2)
Message-ID: <Y3K2V6hwifLlBDfA@slm.duckdns.org>
References: <000000000000e4e4fe05ed5bf2b0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e4e4fe05ed5bf2b0@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 07:40:56AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    59f2f4b8a757 fs/userfaultfd: Fix maple tree iterator in us..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14e836fa880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=480ba0fb2fd243ac
> dashboard link: https://syzkaller.appspot.com/bug?extid=782984d6f1701b526edb
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/619de907b82c/disk-59f2f4b8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bcd0dc7d69ef/vmlinux-59f2f4b8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a8dbe0bc7228/bzImage-59f2f4b8.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+782984d6f1701b526edb@syzkaller.appspotmail.com
> 
> usb 4-1: Direct firmware load for ueagle-atm/eagleII.fw failed with error -2
> usb 4-1: Falling back to sysfs fallback for: ueagle-atm/eagleII.fw
> ==================================================================
> BUG: KASAN: use-after-free in kernfs_root fs/kernfs/kernfs-internal.h:66 [inline]
> BUG: KASAN: use-after-free in kernfs_next_descendant_post fs/kernfs/dir.c:1289 [inline]
> BUG: KASAN: use-after-free in kernfs_activate+0xd0/0x3a0 fs/kernfs/dir.c:1344
> Read of size 8 at addr ffff888079194b10 by task kworker/1:12/5383

Likely the same one as:

 http://lkml.kernel.org/r/0000000000003a95ce05cd867417@google.com

This is a bug on the firmware loader side.

Thanks.

-- 
tejun
