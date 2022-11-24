Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854D5638035
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKXUeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXUeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:34:08 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26412B7006
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 12:34:07 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f7so3852885edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 12:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+zbdt+3aJ/puBsqwQA0QSSEIHoZCeyYKLKFOfyKPSpI=;
        b=QLUMjAXQ2fEkphOSVbRVLpIQyWa0NhYO3SAX0XGU1tP14KCRI6rg5di8LGjlRorP7u
         Fv6zFzIDcQfAy0wmSaWmoFXzVM0TTmzlS2Gsu2nyw8cvtfNzBliPOQeMV7qGPJfuFbLC
         Ulc8QldPJBMRfb9bpYCSt+MDLB+PP+cQJ+8W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zbdt+3aJ/puBsqwQA0QSSEIHoZCeyYKLKFOfyKPSpI=;
        b=6mJfOddaq5RjWrmYmQYy+nNQLoh3zNQiX5Dl5OaaHgXA+Zy/S3SnIvVXtkwn5RHzBW
         Sava7e9VsX1T0GnbrHfx57EDMGE9Jq70R3zpArL7vO0IDP4WyY7Y016SJcjBOKAzJxn8
         XJR3Z2SfXxgN//MMReqDpDbRRLnLI5xWXzIXgvuFY8kFMWEf62D5Gbvr/WdIDbXtLzsY
         RX9CKxV2ry1zV33YgNiBawmYTixMzMzH5lkiKjCOwKgiFAZ/cLZVa16TBaHxKxI/rf+w
         XdNHcoE3iUv2ZL1l2u/9arQABls5odwXPOja7Avj5kcq8F0J1go7Qm7m2i7RuKNtmYMQ
         prIg==
X-Gm-Message-State: ANoB5pkq0AQ6jfyyh1tU/qttl1EsTSeC+vApkL3sVTXdUzo4v/ZFxr8H
        PgzLHXu1ZZhKCCdw5dpj1ttbJVZgEEon+SKs56R6bA==
X-Google-Smtp-Source: AA0mqf6fdqwI0cS8RCosBZkrrlkXrH2sw8vgJawRYCTTkV6ECf84oA86pFY3q/0Ilo9qtsPH7028ypyDVo6RoIoCXC0=
X-Received: by 2002:a05:6402:e04:b0:469:e6ef:9164 with SMTP id
 h4-20020a0564020e0400b00469e6ef9164mr13510155edh.185.1669322045392; Thu, 24
 Nov 2022 12:34:05 -0800 (PST)
MIME-Version: 1.0
References: <2505800d-8625-dab0-576a-3a0221954ba3@leemhuis.info> <Y3+jz5CVA9S+h2+b@ZenIV>
In-Reply-To: <Y3+jz5CVA9S+h2+b@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 24 Nov 2022 21:33:54 +0100
Message-ID: <CAJfpeguqCrEbvv4d4jdOnczQ9VOf4u9sSghvnDOWvUb84fv6OQ@mail.gmail.com>
Subject: Re: [regression, bisected] Bug 216738 - Adding O_APPEND to O_RDWR
 with fcntl(fd, F_SETFL) does not work on overlayfs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Pierre Labastie <pierre.labastie@neuf.fr>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 at 18:03, Al Viro <viro@zeniv.linux.org.uk> wrote:

> So basically we have this
> static int ovl_change_flags(struct file *file, unsigned int flags)
> {
>         struct inode *inode = file_inode(file);
>         int err;
>
>         flags &= OVL_SETFL_MASK;
>
>         if (((flags ^ file->f_flags) & O_APPEND) && IS_APPEND(inode))
>                 return -EPERM;
>
>         if ((flags & O_DIRECT) && !(file->f_mode & FMODE_CAN_ODIRECT))
>                 return -EINVAL;
>
>         if (file->f_op->check_flags) {
>                 err = file->f_op->check_flags(flags);
>                 if (err)
>                         return err;
>         }
>
>         spin_lock(&file->f_lock);
>         file->f_flags = (file->f_flags & ~OVL_SETFL_MASK) | flags;
>         spin_unlock(&file->f_lock);
>
>         return 0;
> }
> open-coding what setfl() would've done, without updating ->f_iocb_flags...
> Not hard to deal with...
>
> I could pick it in vfs.git #fixes, or Miklos could put it through his tree.
> Miklos, which way would you prefer that to go?

I'll pick this into #overlayfs-next, as a PR for this cycle is needed anyway.

Thanks,
Miklos
