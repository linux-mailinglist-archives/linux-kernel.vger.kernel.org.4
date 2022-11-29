Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD363CAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiK2WN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiK2WNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:13:52 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0146C193FD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:13:51 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id y83so19305603yby.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AChR3z5zwG8J+w96qiQ6SbwWaSdj0A7DrZ0KhnwEfmA=;
        b=oWc0moBsoFW/Zr95SvGfRYWnk8lGQII/5+TCCJx7PHhRr0sG2xT4vvJWmST4Dv20D0
         +hbSWTTme3pjxu7QEpSKvENjx6or7eAEmSplgYZafEppu9TkKc6ZTBtwSrlRCHYd3TOC
         K7w0MMC2z4rcXb0AYGm8Yz/gWCwG4fKYSFI6BCG5HA+X+Z1Wmd9a9DVxP6r9udl9kgq1
         1TtGBDjYmOY0viKadf1Gvf7n5u4eMgn39hqRUc27jB1AkMZ39ypb9iwBy0dhNPH8/23d
         7Dcb9PK+/msidOHe6UIr55pU+ph4YLfdSoOEM8mmzjreiY34o8XGsoeJDcFn5/z7vYIK
         2dWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AChR3z5zwG8J+w96qiQ6SbwWaSdj0A7DrZ0KhnwEfmA=;
        b=KENcBZ2/B46+0yJZfxcI2M0J9aIqq279YSVE7a3b0MzLcUDmRCzf2bhKgqWH8UKXle
         TShhzNLXXslT0uVNeWhyp0MXL+ohk/p72s9ls5Zn+zmJ9WeC6/4B/+EkEDxnu/+Ca90q
         PBqhza6gwclJv7knI6UqStuV+d4+7L7G2C4+QTt8iS2pxBK9FiVTILLWHIJUDPb7suoo
         iiLkSbnVW3jQ/92WV920N+1O/vHbFpmS0fr54MQBEPlFilJGRWm630xyS6x1fWEvOhbm
         dasLoPPgTdHtpt97474OyGHNbvJQYesFCP6hdM06ZKMiJA6v+sBdcR0YhlAd62qhd9Rm
         10DA==
X-Gm-Message-State: ANoB5pmNuPaygN1vF5tD6lnK1j3tNOg0cG/cebUfrjfv2acVflW4hDEf
        KCUhIAYcpktGV5BIrRNvE0Egw479RpAXfbVPIUdDGQ==
X-Google-Smtp-Source: AA0mqf6L29gcgghKWYzswyH8qvjMHxIEwe6DOvuG79a9otQT+UqbSbRNb90qP+B/vJMml3boRfgBUXtCjXxBaI3iDBU=
X-Received: by 2002:a25:7343:0:b0:6f3:aedd:e75 with SMTP id
 o64-20020a257343000000b006f3aedd0e75mr21530134ybc.611.1669760030058; Tue, 29
 Nov 2022 14:13:50 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000c379205ec806d6e@google.com> <000000000000d921ab05ee8e4f48@google.com>
In-Reply-To: <000000000000d921ab05ee8e4f48@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 29 Nov 2022 23:13:13 +0100
Message-ID: <CANpmjNMS3BGeWix=-OBKCK_iorQiGVay58f5U4fJiebF6msPSQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in btrfs_commit_transaction
To:     syzbot <syzbot+9c37714c07194d816417@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, dsterba@suse.cz,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: btrfs: don't print stack trace when transaction is aborted
due to ENOMEM

On Mon, 28 Nov 2022 at 22:11, syzbot
<syzbot+9c37714c07194d816417@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 8bb808c6ad91ec3d332f072ce8f8aa4b16e307e0
> Author: David Sterba <dsterba@suse.com>
> Date:   Thu Nov 3 13:39:01 2022 +0000
>
>     btrfs: don't print stack trace when transaction is aborted due to ENOMEM
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e020bd880000
> start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=9c37714c07194d816417
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17401632880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13176716880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d921ab05ee8e4f48%40google.com.
