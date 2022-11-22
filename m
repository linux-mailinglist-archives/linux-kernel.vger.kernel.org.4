Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A8633D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiKVNHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiKVNHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:07:37 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244AF38A1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:07:32 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id n205so15756529oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sHcsAnPoB5K6nlfDb8qSDTmr2dnvL5PwfuPRo7G6IRI=;
        b=LCvLO+3owJfkfVOd6g6RcWpfhCiSkvOXq57fz+1N/hl/Fyu6QvtwznVQeEYsjJ593h
         s2s4JT1JCdH9uVxvNO0dDG1D+f4K0I41O1bAbUgg15aIpgttkSd7xNHDxOdHzFDmfDtt
         LktDifMmX5WApSSEzGQYfTV3Qc01tD47i5iWplimx3sj0Ss7ToL9P29R7bnJfS+bAc5k
         BVXmT64w5e1lu+Hp+GiJeol+ThAWmj+/qa9WWyWM1YTVC0QQIEt3EhNbdjAqxzeNmvyD
         yYLHlxeJdYFZoLEsHdqJQgl3hcRMI3Ei3A2KCFcmgR56W7H1cC3Z9dWOXlgN0qPrUEw9
         A8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHcsAnPoB5K6nlfDb8qSDTmr2dnvL5PwfuPRo7G6IRI=;
        b=cSCoTmoZXmKOAAAH7x2YOODpc4GHFU06vnXLhpqF1xOMk+YPAOUAzBg87byE75OR6R
         cC3as9cHnnsPeWraiv5W8fXtT11iVoFSFORZK5kqaFTO0yfQVj6D3N9+b7+986NrHNNW
         CA3umUZ7NNlcdJ/hDMUC0gISdPUlGB4Mil+X1JVXPm1IWxwC9wGamwW7VH1Lhlc3JQKO
         LmIe4QU+DKcJguPvl/DMceD+OqdmN4l8ArZtanipb36U0ZYr7AhEX7bnwxQbmEkHekw6
         u7iPoDaeX6uyQC3fvcXK//eri5T78kro+RrCiNuMErpgLzpapyeKziOs0ng16XzmM/Ts
         iOCA==
X-Gm-Message-State: ANoB5pnW+j8MlT6jhge0YDvrdS7j8UgusXni9MWtj/s69/2lAuUmEALj
        hy+UL7Om4KbfN6GL/mFVY81uHgi0UX41VTHryil6/w==
X-Google-Smtp-Source: AA0mqf63tSh3bBeSOdovOohNEXjPjZCTjy6r7yiO2GT42YU8s0rH2NV+8zEBTSYcSkJmPRRlh6F5TcD5hva2+urEWjk=
X-Received: by 2002:a05:6808:1115:b0:359:cb71:328b with SMTP id
 e21-20020a056808111500b00359cb71328bmr11135034oih.282.1669122451909; Tue, 22
 Nov 2022 05:07:31 -0800 (PST)
MIME-Version: 1.0
References: <00000000000023209305ed71c833@google.com> <20221115091825.2381-1-hdanton@sina.com>
 <CACT4Y+Z0OqaK0iCqWbez1aYw1zqtSZxNFbYe9jm_p2VToh2-oA@mail.gmail.com>
In-Reply-To: <CACT4Y+Z0OqaK0iCqWbez1aYw1zqtSZxNFbYe9jm_p2VToh2-oA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Nov 2022 14:07:20 +0100
Message-ID: <CACT4Y+a1uFJHWX0kWTyYV-KycuaZWjjnfPZ4xHP_SQP-+f1dFA@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in nci_set_local_general_bytes
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+8768e9ec924b08e63f82@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

On Tue, 15 Nov 2022 at 10:35, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, 15 Nov 2022 at 10:18, Hillf Danton <hdanton@sina.com> wrote:
> >
> > On 14 Nov 2022 09:43:48 -0800
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=119413e1880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=8768e9ec924b08e63f82
> > > userspace arch: arm64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1097e935880000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177b5b15880000
> >
> > In the open path, register nci device without mci_mutex held in bid to break
> > the lock chain.
>
> This should be fixed by the following commit when/if it's merged. The
> commit removes nci_mutex.
>
> nfc: Allow to create multiple virtual nci devices
> https://lore.kernel.org/all/20221104170422.979558-1-dvyukov@google.com/

#syz fix: NFC: nci: Allow to create multiple virtual nci devices

> > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git  1621b6eaebf7
> >
> > --- x/drivers/nfc/virtual_ncidev.c
> > +++ y/drivers/nfc/virtual_ncidev.c
> > @@ -15,6 +15,7 @@
> >
> >  enum virtual_ncidev_mode {
> >         virtual_ncidev_enabled,
> > +       virtual_ncidev_enabling,
> >         virtual_ncidev_disabled,
> >         virtual_ncidev_disabling,
> >  };
> > @@ -128,6 +129,7 @@ static ssize_t virtual_ncidev_write(stru
> >
> >  static int virtual_ncidev_open(struct inode *inode, struct file *file)
> >  {
> > +       struct nci_dev *new;
> >         int ret = 0;
> >
> >         mutex_lock(&nci_mutex);
> > @@ -135,24 +137,27 @@ static int virtual_ncidev_open(struct in
> >                 mutex_unlock(&nci_mutex);
> >                 return -EBUSY;
> >         }
> > +       state = virtual_ncidev_enabling;
> > +       mutex_unlock(&nci_mutex);
> >
> > -       ndev = nci_allocate_device(&virtual_nci_ops, VIRTUAL_NFC_PROTOCOLS,
> > -                                  0, 0);
> > -       if (!ndev) {
> > -               mutex_unlock(&nci_mutex);
> > -               return -ENOMEM;
> > +       ret = -ENOMEM;
> > +       new = nci_allocate_device(&virtual_nci_ops, VIRTUAL_NFC_PROTOCOLS, 0, 0);
> > +       if (new) {
> > +               ret = nci_register_device(new);
> > +               if (ret)
> > +                       nci_free_device(new);
> >         }
> >
> > -       ret = nci_register_device(ndev);
> > -       if (ret < 0) {
> > -               nci_free_device(ndev);
> > -               mutex_unlock(&nci_mutex);
> > -               return ret;
> > +       mutex_lock(&nci_mutex);
> > +       if (ret)
> > +               state = virtual_ncidev_disabled;
> > +       else {
> > +               ndev = new;
> > +               state = virtual_ncidev_enabled;
> >         }
> > -       state = virtual_ncidev_enabled;
> >         mutex_unlock(&nci_mutex);
> >
> > -       return 0;
> > +       return ret;
> >  }
> >
> >  static int virtual_ncidev_close(struct inode *inode, struct file *file)
> > @@ -167,9 +172,9 @@ static int virtual_ncidev_close(struct i
> >                 nci_free_device(ndev);
> >
> >                 mutex_lock(&nci_mutex);
> > +               state = virtual_ncidev_disabled;
> >         }
> >
> > -       state = virtual_ncidev_disabled;
> >         mutex_unlock(&nci_mutex);
> >
> >         return 0;
> > --
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20221115091825.2381-1-hdanton%40sina.com.
