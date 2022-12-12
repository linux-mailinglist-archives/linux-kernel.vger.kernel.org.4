Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6938064A53F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiLLQvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLLQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:51:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D514388A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:51:08 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q7so12732201wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zdKYitirjFUvJOqH75WY9wqcicdY0ZKchesIKslPTDk=;
        b=Nm57cZd02W0zL2/5xwuBi9IHyI8TrElP/I6CSCoax110itKNY5B71nnPey5vGNTI5E
         D2WdKEFM4MXdvvoW72zhyrH4oGnRjPEVP029fpVn1R2bq8dCKubrCJyrRMNF7ahTXN7D
         VYYXk7b9s3WSrbyYR3hoqmyiBZbMNPi4k7YxxU2YQyC6wVkgMR2KUDbwWNrPWATQFqWl
         H24NgXTNsqnVIgXipJqBnFCGgxTy0FMP+Je2mJuJzh3HiftFMYb5tg4jPCekwnfF42rG
         SiLvMEyWoum5oY6jIUdXdGOalPXT97WuEoqpn/JLfKg4RY4sVTl3A5JfoKvaPoJRrfqX
         Mbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdKYitirjFUvJOqH75WY9wqcicdY0ZKchesIKslPTDk=;
        b=7bO4j9oPTf+BTRMeVqMhaibb2VUc49tGgzYGhdLDCy9d+rXhNcbnUShGwZSIgi7ubp
         8MuwIOCmR/qfqQCo6yuwAfatYpAuQPJwjuhdHbpml4b4wRXsmZ8nJVISKitr2R2WVEvr
         7Rdhm6joO3QvkVZ9JfX9U+q6g/JcVV82FR7TddGan1IXGL+GJYrIWEJYQ99k16IZNMKB
         8JvwPukOcrTUC3XZSMsc6/ElvnEhtgk8eu5CpVFSEuDYZDKF2sMFi18Od+HkkYBjfR6W
         1McFlsQAxio4ZFGRWvLCd6ncAgo+b3tkF4QPkRblxW4SurBJ/Y71sINI8PLJ+oERC5mD
         d2qA==
X-Gm-Message-State: ANoB5plJgfV1+RD2bspJp7cuwqSh8H8gmbhjv2MjOjDmaIF52CrRCW0b
        aCHmx3jggS88npVcFBkqiHwf919BNpCnVRI6Ii0=
X-Google-Smtp-Source: AA0mqf6QxYRdXfCb9/N8S90fQaOuz1jlxeRxtTpJnifImRcjKiCXNKSKfd+xl0nmTotR3FofPs3Z6Yhkij0qrAOLnDw=
X-Received: by 2002:adf:df81:0:b0:242:6553:668e with SMTP id
 z1-20020adfdf81000000b002426553668emr10674273wrl.131.1670863867123; Mon, 12
 Dec 2022 08:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20221205175140.1543229-1-nphamcs@gmail.com> <20221205175140.1543229-4-nphamcs@gmail.com>
 <Y5UbhBTB2nSMN4UD@ZenIV> <Y5crEpr5QWptjK17@bfoster>
In-Reply-To: <Y5crEpr5QWptjK17@bfoster>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 12 Dec 2022 08:50:55 -0800
Message-ID: <CAKEwX=Og2JTWbtpU=n+PVskR8ovNiN-GJwrPoMrbe+q+K_-EBw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cachestat: implement cachestat syscall
To:     Brian Foster <bfoster@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@meta.com
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

On Mon, Dec 12, 2022 at 5:22 AM Brian Foster <bfoster@redhat.com> wrote:
>
> On Sat, Dec 10, 2022 at 11:51:32PM +0000, Al Viro wrote:
> > On Mon, Dec 05, 2022 at 09:51:39AM -0800, Nhat Pham wrote:
> >
> > > +   if (!access_ok(cstat, sizeof(struct cachestat)))
> > > +           return -EFAULT;
> >
> > What for?  You are using copy_to_user() later, right?
> >
> > > +   f = fdget(fd);
> > > +   if (f.file) {
> >
> > It would be easier to read if you inverted the condition here.
> >
>
> Seconded.. I mentioned the same the last time I looked at this. On
> looking again, perhaps it might even make sense to create a
> filemap_cachestat() to split up the syscall bits from the associated map
> walking bits..? That subsequently raises the question of whether a new
> .c file is really necessary..
>
> Brian
>

Personally, I think it's better to add a new .c file for the new syscall.
But I'm impartial with respect to the refactoring otherwise. I'll just give it a
shot and see if it looks cleaner.

(BTW - I just realized this is the v2 thread. I have sent out a v3 - feel free
to take a look at that as well! These comments are still valid for the new
version though).
