Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3BC5EF3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiI2LKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiI2LKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:10:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBE27E830
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:10:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u18so1702177lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TznUKUpOR5bT2ATdHCJ+/WNeel+FbNVXEkaira9S44s=;
        b=W/EMeosjlY79B5ub5OzSbI6nWjVAxkO2wuduXHmuPfJIA+Q66yv4HKpFF1BLPDHYaZ
         e7uZ4iSRb2YmLATy8AIorcxCzo6S4cnLLJLUtPQKEEGnZeUXc63XpaYood+YYEoXnsVs
         l8gECi1RDH9gnCeBEMxIDh/NyoXoWU90LvQmKA3Kcq/ZsJ47k+UtLf6oCOx2M9h9Uel8
         pDxeGliC5QwusCkmipJXIEvy4NxiC4UNEVNc0pkn2R3DzONHSqcxnY1CMkmlVUjH5RC7
         AgONxxU1/S8i8NswIMxckitNpIQ064TIpA+GdNoJaymFxYi1o2J8KssWal9ww2QnkQ9S
         kAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TznUKUpOR5bT2ATdHCJ+/WNeel+FbNVXEkaira9S44s=;
        b=szQ3Hpo7SH7DwPWqk5GV50YtUKMvrxy5PPIjm3+mIp3cgwolidDNTdNOlS3RBRISzZ
         mF5eKIO9Yc5ZPd5qBPuju7zfXS+hgUaE+4Ms+HfOdx/IJSj8sQYiqY3EfF5VyvQ7RY17
         uMk/i8PjeTwIwlwgPXHpxGZO5J7bcQQHqMcjLP5BdI6aIqLzdCs/cx3yE9qPdM6EA8Dw
         HThE8JYRoM1zF3+d0B5nYF7vAxcqHJEDooweoSTvAe21Y+G3ykGC0584yJuU1Y5W2i6k
         /kyJqvp489JAQDtNK6rjvtpNgcZBOkVMJaNBkW6Mr5294yHJAKL+oRjM0pTA8SSWdo9C
         PiYQ==
X-Gm-Message-State: ACrzQf0k/OgC8VKlkqcGRGOHPwf/7eMxWugX+lqht1Qbx8mUliKqi16R
        jJYuUXrTXc0wZXfvdEfLV0Slc1/DRby8ktuUKLRGI0SY8ZtAyg==
X-Google-Smtp-Source: AMsMyM4bY1GS86CGyYczrTEEDATke+Pu9TNcvr+7vr3fP/R4xodtdUJsQXY5rPxsiXRLARFaOdlRfGxA14HlheT8IqQ=
X-Received: by 2002:a05:6512:4016:b0:49a:81b3:808f with SMTP id
 br22-20020a056512401600b0049a81b3808fmr1196726lfb.137.1664449831508; Thu, 29
 Sep 2022 04:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008af58705e9b32b1d@google.com> <14313951-15f1-0ceb-259c-f251eb140706@I-love.SAKURA.ne.jp>
In-Reply-To: <14313951-15f1-0ceb-259c-f251eb140706@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 29 Sep 2022 13:10:19 +0200
Message-ID: <CACT4Y+ZMXN=smH-0FN4Ui0zm6P-c=eEwG6fNJ9deTnc0M099UQ@mail.gmail.com>
Subject: Re: [syzbot] unexpected kernel reboot (8)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        syzbot <syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
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

On Thu, 29 Sept 2022 at 12:25, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> This is not a kernel bug but a fuzzer's bug.
>
> Looking at https://syzkaller.appspot.com/text?tag=ReproC&x=155622df080000 ,
> this reproducer is reading data from /dev/vcs to [0x20001dc0,0x20003DE0) range,
> and passing subset of this range [0x20002300,0x20003300) as "const void *data"
> argument of mount() syscall which is interpreted as a string.
>
> That is, this problem happens when console screen buffer by chance contained
> kernel messages which the kernel has printk()ed upon boot.
>
> (I defer "#syz invalid" because we need to somehow fix this problem on the fuzzer side.)

Oh, I see, I missed the read from /dev/vcs. Thanks for looking into it.
Thinking of possible solutions I think the easiest thing is to
stricten matching of the reboot message, e.g. require it to start from
the beginning of the line, don't have anything at the end, etc. The
real message should not be subject to any "corruptions".

+Aleksandr, please take care of this.

Not sure if there should be a policy on printing user-provided strings
to dmesg in general or not. Unpriv fs types like tmpfs/fuse
effectively allow the injection of arbitrary messages into dmesg w/o
the permission.


> On 2022/09/28 11:03, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    1707c39ae309 Merge tag 'driver-core-6.0-rc7' of git://git...
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=17324288880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8346a1aeed52cb04c9ba
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ca1f54880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155622df080000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com
>
