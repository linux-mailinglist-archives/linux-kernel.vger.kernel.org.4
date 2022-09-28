Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A515ED8E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiI1JYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiI1JX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:23:58 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CD7B07F8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:23:40 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id a129so12184336vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=N4sJdYiEPta5eHA2aSs5jqQt99tQBvgcHVJEn8oUpUE=;
        b=eSKCu8jWDagj3YjWMVI5UBsyale/FVF3gk972WTjKLL4l7o6ZhkTfIYZl71mqMsHYr
         OoDLLxFqfyThRbjE0ZdnmteQFZi4hxwbw/vHcPYkOpQlT80gXSBs4sJcF9I4PtsGOTq7
         VkmTa9TtRmzLwstGFa2zAtjeEftTu9kDAVvBtrIyr16e6L6lX5jz4E5+TbTukth1Qc9B
         e9O0BugxWkcuUGqe71vAdhoLZQJdw52AT5jGj77Mqm5ZJiS3V5/K9ZAVcV5T8qx/GdSs
         pyaQB9um+kQdCnEXIBxQAtBDaUHGaJ3ACh07gcPLLXtDlczpGpPvg/m00KofgfPx2JHX
         QeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=N4sJdYiEPta5eHA2aSs5jqQt99tQBvgcHVJEn8oUpUE=;
        b=PTl4xc4bIhGO9GC4kNQvOkagTkYlD6W0KCZAskvmCf/usAAFW77R+Tg+mw5I0zD34w
         bEswGvisUqHZ/MD8F8lZJCeXfkDvG2X/Aibg04sfzfl0vs1RIfrLn+r/iQdzWSO7vvos
         36ahpcSG0f+FQiQXkK4tPJuxaeEThk17Fa703fCXHu3bpxU/YQ/ehmDPTaagI6nWfcTb
         mX+1vedqrNwttGytbqWQAZZMq4RIAlRVcrPSSiemi7jcqln33UopgbgDNBeSCb5HDcf0
         i2LmZu0VqbnOi2JW0CVp5Z3zB3CLx0ExFi06X3pD4qTp9wRs+Qh0Zr/xFRyBJoaOxzp9
         5OFg==
X-Gm-Message-State: ACrzQf1WtpxELWMZPY4N6XubViisBKDn+ziD3g52Co932OJMwQRi7ztA
        VFbWhVUy20tP43UO2zZjk9Yxapfq7Bq02GznvjMIVhE0Xz9tIg==
X-Google-Smtp-Source: AMsMyM6ahUMvKegbswPOa40sujoYUJbtET6Q3gm7zQCxkiRQK/vYAYnRE8DBqkoBCtEQEL6ou375gDO5PSAE5Eyql6s=
X-Received: by 2002:a05:6102:3f8e:b0:390:32b1:ed15 with SMTP id
 o14-20020a0561023f8e00b0039032b1ed15mr11797413vsv.8.1664357018966; Wed, 28
 Sep 2022 02:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f2b07b05d5dc87cc@google.com> <00000000000093aefb05e9b93343@google.com>
In-Reply-To: <00000000000093aefb05e9b93343@google.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 28 Sep 2022 17:21:40 +0800
Message-ID: <CAD-N9QWpDpP5YGwq363Z1jDOeEK+S1JjNGmiZsD4KimZSkowgw@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
To:     syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs-owner@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, nogikh@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 5:15 PM syzbot
<syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com> wrote:
>
> This bug is marked as fixed by commit:
> fscache: fix GPF in fscache_free_cookie
> But I can't find it in any tested tree for more than 90 days.
> Is it a correct commit? Please update it by replying:
> #syz fix: exact-commit-title
> Until then the bug is still considered open and
> new crashes with the same signature are ignored.

@Dmitry Vyukov Why syzbot continuously complains about this bug
report? The fix commit looks correct.
