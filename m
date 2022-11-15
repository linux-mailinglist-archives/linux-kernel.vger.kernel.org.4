Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FD162946F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiKOJf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKOJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:35:53 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C10113E8B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:35:53 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so15625324fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FgSINhSA/Njf7BAboSWRn2H2Z8Eyr8d7d3Uj1Vunitc=;
        b=KlN9IhLj/d/cWH4Q4BZeeunUbA+jdhn4dmzdyKQv90TAd7FFwWdx3Fj0oyrNYU6hJL
         Nuj0IRJhYaUbrLrtL54BqfIEaOBcRx3H7kisC3zB26ZqIZLUTeEjztbUgpht1eITdNEU
         VlerVoicZrrQpynq6Wa92xiDc6gEKJoI8vo8kEFoPJMocLoQw3HWl0OYIViwnuBHs7Rb
         IdN+EIu3k4i1PCEFrlmCFfyfu9cfL7MZQb7YfRPIx5JoejW1l+EJ7QprQGN8ndOgh2Ou
         HlnafoLRFFr7oVAyNRSbvf4kG+OU+0mO2aDR9faGhjdwdGGyqO2xxJWooAKocRcT5Yo8
         9AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgSINhSA/Njf7BAboSWRn2H2Z8Eyr8d7d3Uj1Vunitc=;
        b=QSRK+qGsGqR+1sVEkY6gLtJl9JRlrTJfkTmBxAQjUl3OB8+e0QxTVuJ2lopA8yRl3h
         Le0MxAQSu5WOSFbqOcLXTCUoln8YIqYPHM9HbkFkg0cVsR5CHaSjToZwLU1fbCIFYxj3
         JYE5/aZ2RLayMjjcDkX5YqLqt9YE7Y++XrbZP9GHaauVavk+NNs90J5GYd1CRCLQFSxw
         PCknSE8UCERbKIg8KOjO6Fzt/T5rvLdptcRai/XT7+Fu5/0SYaUW83TDDM5aAjNLYzcC
         Ze7+tmvvWxfZFUbzcXqvt6y1O0psnDoh1NqwoiTCyMAhttOPKeFsDF1KTDE+/mIm31r2
         6xUg==
X-Gm-Message-State: ANoB5pmoP2jxWYXi3Q8GUI4MtEBbHYJobsrMqO8o1qoB8tDfd3q2NUWW
        qScuCYbpjaOnAKv+Zgr7d7KwH6mhzUzaqZ3I+xn7pPGzRsNk4A==
X-Google-Smtp-Source: AA0mqf7Hk+5KYC4d7Oq6CuCH2K+QUHQERpG6JEB0WgGkR2ol1bwrL5ufdz5qfPeLit73QIdNszS09yHPFMhYkND1kIE=
X-Received: by 2002:a05:6870:9a16:b0:13c:7d1c:5108 with SMTP id
 fo22-20020a0568709a1600b0013c7d1c5108mr546045oab.282.1668504952168; Tue, 15
 Nov 2022 01:35:52 -0800 (PST)
MIME-Version: 1.0
References: <00000000000023209305ed71c833@google.com> <20221115091825.2381-1-hdanton@sina.com>
In-Reply-To: <20221115091825.2381-1-hdanton@sina.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Nov 2022 10:35:40 +0100
Message-ID: <CACT4Y+Z0OqaK0iCqWbez1aYw1zqtSZxNFbYe9jm_p2VToh2-oA@mail.gmail.com>
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

On Tue, 15 Nov 2022 at 10:18, Hillf Danton <hdanton@sina.com> wrote:
>
> On 14 Nov 2022 09:43:48 -0800
> > syzbot found the following issue on:
> >
> > HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=119413e1880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8768e9ec924b08e63f82
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1097e935880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177b5b15880000
>
> In the open path, register nci device without mci_mutex held in bid to break
> the lock chain.

This should be fixed by the following commit when/if it's merged. The
commit removes nci_mutex.

nfc: Allow to create multiple virtual nci devices
https://lore.kernel.org/all/20221104170422.979558-1-dvyukov@google.com/


> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git  1621b6eaebf7
>
> --- x/drivers/nfc/virtual_ncidev.c
> +++ y/drivers/nfc/virtual_ncidev.c
> @@ -15,6 +15,7 @@
>
>  enum virtual_ncidev_mode {
>         virtual_ncidev_enabled,
> +       virtual_ncidev_enabling,
>         virtual_ncidev_disabled,
>         virtual_ncidev_disabling,
>  };
> @@ -128,6 +129,7 @@ static ssize_t virtual_ncidev_write(stru
>
>  static int virtual_ncidev_open(struct inode *inode, struct file *file)
>  {
> +       struct nci_dev *new;
>         int ret = 0;
>
>         mutex_lock(&nci_mutex);
> @@ -135,24 +137,27 @@ static int virtual_ncidev_open(struct in
>                 mutex_unlock(&nci_mutex);
>                 return -EBUSY;
>         }
> +       state = virtual_ncidev_enabling;
> +       mutex_unlock(&nci_mutex);
>
> -       ndev = nci_allocate_device(&virtual_nci_ops, VIRTUAL_NFC_PROTOCOLS,
> -                                  0, 0);
> -       if (!ndev) {
> -               mutex_unlock(&nci_mutex);
> -               return -ENOMEM;
> +       ret = -ENOMEM;
> +       new = nci_allocate_device(&virtual_nci_ops, VIRTUAL_NFC_PROTOCOLS, 0, 0);
> +       if (new) {
> +               ret = nci_register_device(new);
> +               if (ret)
> +                       nci_free_device(new);
>         }
>
> -       ret = nci_register_device(ndev);
> -       if (ret < 0) {
> -               nci_free_device(ndev);
> -               mutex_unlock(&nci_mutex);
> -               return ret;
> +       mutex_lock(&nci_mutex);
> +       if (ret)
> +               state = virtual_ncidev_disabled;
> +       else {
> +               ndev = new;
> +               state = virtual_ncidev_enabled;
>         }
> -       state = virtual_ncidev_enabled;
>         mutex_unlock(&nci_mutex);
>
> -       return 0;
> +       return ret;
>  }
>
>  static int virtual_ncidev_close(struct inode *inode, struct file *file)
> @@ -167,9 +172,9 @@ static int virtual_ncidev_close(struct i
>                 nci_free_device(ndev);
>
>                 mutex_lock(&nci_mutex);
> +               state = virtual_ncidev_disabled;
>         }
>
> -       state = virtual_ncidev_disabled;
>         mutex_unlock(&nci_mutex);
>
>         return 0;
> --
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20221115091825.2381-1-hdanton%40sina.com.
