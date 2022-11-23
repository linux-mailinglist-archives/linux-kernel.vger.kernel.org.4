Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C963635AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiKWLCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbiKWLCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:02:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2081F630
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:57:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g12so28775370wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeDxktV8QTllihTd7PH+bhJsvB6hqJRLWTAJ7A3ymXA=;
        b=Rn/DtYSNu+udYPympAkO8sk368pdvJyy+vU9aWxlQVDobXQkyhRRpJG2XdwTmCmtOX
         y9EitJpbHoDNW4ey0ers5ZAVihFHF6voTHj0mhx0gXiAq09vXnMksXbZ1udNq/KG1BsY
         txqKF/BjP6Jkptsb/7TFsdngZTkVjn4jymzR/SUkhrnK2E4BUVXR9062cJLw29S7Grwi
         HfG+UfUVKR+qe2CS6TFGO31DjuMqMNGR7cQ9LfjENqEbCmbDKtD47IwMrg06RZbE8yMU
         wRzQfRyC6zgbwym600SX2cSGC6vsPJayIMYoquD7qcP0R83wjjRaQUU1WfHfR9L86x/U
         g0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeDxktV8QTllihTd7PH+bhJsvB6hqJRLWTAJ7A3ymXA=;
        b=DRm2tglGIn/hq7H9yTVQBPe+CA8t5bZNLaU7n/OhNPFbMSSCzuyKiokV/jOjzdnpmU
         1lYLh4wuigNtfe515bd8CgsRYvHEJeSdAQwgylkiJC5X5Twc5uL5ogVcbp8SMo5RA+Ik
         jtfwsXexlKABKZksftfuS1rncTV2vCSPZaH0++KNV6bZZ9xhYl7CyWkxMWgtBS9HgNY/
         S7xV8J/4ZASMbFISr9RJUHdcxd6XjPk0CuzevUKj36CIhVNbXZYVwC2TQQ4zQ+e+vByc
         IFFWDcdJlAdmvGXu19+9W9I8x/5TS3KDYQMhDYjFNRoxH0C9N8OmUx3ssghcggNtf3KX
         RglQ==
X-Gm-Message-State: ANoB5pmUwPK0s7UbSisOgbWuOw+0DaQ36jYlNUxX0lUB0HoLWj+oGa3F
        Y68ke4aZyOeHwwVZwwuFi5X69w==
X-Google-Smtp-Source: AA0mqf4rUpfphiDD7G4+8WfDIZDz56W02dLBhmH/+gbZfuxQvD1v2vtq/4WTBquORTFDDv4YF0Rxjg==
X-Received: by 2002:adf:f847:0:b0:241:d9c7:3400 with SMTP id d7-20020adff847000000b00241d9c73400mr7526087wrq.620.1669201067780;
        Wed, 23 Nov 2022 02:57:47 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:5fb5:228c:93d7:c5d8])
        by smtp.gmail.com with ESMTPSA id c16-20020a5d4f10000000b0023677081f3asm16093493wru.42.2022.11.23.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 02:57:46 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:57:40 +0100
From:   Marco Elver <elver@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com>,
        peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in task_work_run (2)
Message-ID: <Y338pCjXlDT8Zu3z@elver.google.com>
References: <000000000000fad77705e7fd40fb@google.com>
 <000000000000e7513905ebf4346f@google.com>
 <CACT4Y+aHHV-+ECUux1=DR11P3Xd-apJN7ALE4GsOxq-MBGo-Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aHHV-+ECUux1=DR11P3Xd-apJN7ALE4GsOxq-MBGo-Lg@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
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

On Wed, Nov 23, 2022 at 10:49AM +0100, Dmitry Vyukov wrote:
> On Wed, 26 Oct 2022 at 20:29, syzbot
> <syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    88619e77b33d net: stmmac: rk3588: Allow multiple gmac cont..
> > git tree:       bpf
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1646d6f2880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9228d6098455bb209ec8
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bc425e880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1126516e880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/f8435d5c2c21/disk-88619e77.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/551d8a013e81/vmlinux-88619e77.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/7d3f5c29064d/bzImage-88619e77.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com
> 
> Should perf task work hold a reference to the event to prevent this?

Probably should cancel the task work?

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 88619e77b33d


diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5ddc88592ff8..1457725fa8a9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4970,10 +4970,12 @@ static bool exclusive_event_installable(struct perf_event *event,
 
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
+static void perf_pending_task(struct callback_head *head);
 
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
+	task_work_cancel(current, perf_pending_task);
 
 	unaccount_event(event);
 
