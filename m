Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F66B9027
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCNKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjCNKfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:35:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AFB97FE5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:35:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b13so15496765ljf.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678790103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1JuELhTJwIN/BuNgCW2HSGunJAg926V+YaVufQMF0Gg=;
        b=ZFxPezWpR621MrKtyfgGxDJNidswYVpeY8UYgp4mL6AEFx9z1GrZ9imF9YQLoBBe8z
         K//TkC/88GrwcomawGWgguWYhzKZZ6XurcovHypOJW5HkWWPw6gD13C8xwcv3mHCzAEa
         gPE6kMDfgYTCfL0jLf3Gj+nzE5LCpd9upa5ryPxETPp3DKDbzhCE3mJS4uMLJLsRUZbH
         3zoGNWehF285X/zN5TUgYiWKtCQT+iLAoJdU0gQgFWPC04sL684OPsn2/9LVIgOUCU5S
         G0NZKN+rHgC/5HMCxLt/vDubJZXF2XUV4VceaIgNftYpdC9SwTjPeQ1vnzT/1htQ1nqf
         0WNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678790103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JuELhTJwIN/BuNgCW2HSGunJAg926V+YaVufQMF0Gg=;
        b=E1/00CzwXgSY5QAgJ+K/jjIQrAySJRWt6DAHc/TwyhFaOTYHMdk2qvLZQPTlowMjLn
         Ynywxk4X6bP/l/mygwU/fg4cwGOX+OS0o1E0JBaUEtEqxSRfDsLZ3+AuB+rXy8rmcYn3
         +uipCCgonDHzDCn8MiSqVXUP0W873Yvv6Cg17zK+R9d+bVAX7Qx97wMBP+W48p0KGrDr
         Hqdod8EvgeuAFVy3fKx2XBy+lUlysLbh16AsG+xX8AYE8LcRmc58XMxKjpO2Bn1Fdv/u
         fNjF4KuaVeKQ5oC4VOz3Gm7TYt4AQzwL76EgaDQBbMQIu7SBlPkGPfOPzQNs0smpt5DN
         s/Pw==
X-Gm-Message-State: AO0yUKVmzk679Fl69ixJ77ok1tghyvEK4+03OZpkcuscZ086pujF2d8i
        wKdN7pEv5AKsNAuAiKLBBLFcaCXSuOkTRskDDp37MQ==
X-Google-Smtp-Source: AK7set+nVNpCp2TWhO7HP43nyyaH5wdvrBirwmLwcQrqyn7orb2IeZEwTFAOHCCfYyoJn2y1TsWXi83gfC+mzVSChME=
X-Received: by 2002:a2e:b90d:0:b0:298:7034:836e with SMTP id
 b13-20020a2eb90d000000b002987034836emr6666498ljb.8.1678790102864; Tue, 14 Mar
 2023 03:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004c06c405eb318db4@google.com> <000000000000a5202905f6765872@google.com>
In-Reply-To: <000000000000a5202905f6765872@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Mar 2023 11:34:50 +0100
Message-ID: <CACT4Y+YiLoseRKwZBzM6AbR0x=TBV348CkLUGcckrd04QxRjTg@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_run_delayed_refs
To:     syzbot <syzbot+ebdb2403435c4136db2b@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 12:57, syzbot
<syzbot+ebdb2403435c4136db2b@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 8bb808c6ad91ec3d332f072ce8f8aa4b16e307e0
> Author: David Sterba <dsterba@suse.com>
> Date:   Thu Nov 3 13:39:01 2022 +0000
>
>     btrfs: don't print stack trace when transaction is aborted due to ENOMEM
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1541ad14c80000
> start commit:   98555239e4c3 Merge tag 'arc-6.1-fixes' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebdb2403435c4136db2b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a4d8ea880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13172832880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix:
btrfs: don't print stack trace when transaction is aborted due to ENOMEM
