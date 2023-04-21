Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12276EA0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 02:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjDUAlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 20:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjDUAl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 20:41:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BEC9F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:41:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b509fe13eso1316549b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682037685; x=1684629685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V9j1g7sK3q1/d39/yJUozMObHifrV7DZPVY+c2FKrBI=;
        b=tG404iTeIKBzFQ2afETCq9JjRtSLFROG7JgUWHjmUVO8bezWtXVh9fjsDB9qRaIpqR
         /9KZTJMWPrlLV74rGkMv7B4tbZNrlmUxFtH7VaISia45q5Lw9wUn5XxXswwB+SI8mV0H
         2+V1tEiLlOzEgFuupmaWSol/CF5rJ2CbgUCUA1E75EJfZrMVrW8AtG/5A+o8Qb98o9xb
         euWEaN9Luo30IGtV6DG4HQTnL7HAOp8AkUL4lNTmoyOJw/uwGTRCnfKnTuOj/bzAbOWn
         XtpnK4b1vc3J4C9KitxYQNQ579ym3u+zhSl78+KkkBB8gpr9vSYLygR0mXdpPS8ZMurR
         aYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682037685; x=1684629685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9j1g7sK3q1/d39/yJUozMObHifrV7DZPVY+c2FKrBI=;
        b=XlZKlSCRz2sm1D6Vfv6d1U/UHEdRDjp3cOh8zeZctReDy2DOz3AxYCedqjojvZ77t5
         guAhMP2BafARa2gh2abQCLp9Uc/xDgZ8vmqiGtx52L6FdZyeY+/GEyTtUzKbkO7Bfs1l
         yODyILJxTO0pWSjc1bzG3+eRYT8ECC/Ke75CWCmHtigEHORb6M6/Ecj02WQ/nXZ5266t
         PEw2WYml07JFQFHi2LA+WSLtNUIjTECRXGh506mBVULyUB6M2Owt/28PoSpS4WuGXPAH
         fUL/39LHtzi2jdKdahLemuWsLJbzuEDy7yiHhblVgsuAmIdtbJDVBRrCoOYL5H2LAhYq
         tddA==
X-Gm-Message-State: AAQBX9cFK1z+8yS3FUhtLda/JuddxfOQ1H0QrZkcjCy035QcLfjHpOwQ
        znod9fmWu6ehJU1zP6R2jjw8zA==
X-Google-Smtp-Source: AKy350bVNciq3SNwM9/Ddxv0JWqBoEq72bXp1tM1bZOuJakAJlgFz+RpCEcC6VXd3q9ffKbHa+m4YA==
X-Received: by 2002:a05:6a00:14c5:b0:63f:15cc:9c1c with SMTP id w5-20020a056a0014c500b0063f15cc9c1cmr1476876pfu.34.1682037685429;
        Thu, 20 Apr 2023 17:41:25 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s23-20020a62e717000000b005aa60d8545esm1813677pfh.61.2023.04.20.17.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 17:41:24 -0700 (PDT)
Date:   Fri, 21 Apr 2023 00:41:20 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-mm@kvack.org, tkjos@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Using page-fault handler in binder
Message-ID: <ZEHbsOmokBGlzNjo@google.com>
References: <ZEGh4mliGHvyWIvo@google.com>
 <CAJuCfpEGBquOjEBFD87DEHqWc0TZ8TkLHRh6RAjR=1wFPbMNHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEGBquOjEBFD87DEHqWc0TZ8TkLHRh6RAjR=1wFPbMNHw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 02:35:00PM -0700, Suren Baghdasaryan wrote:
> On Thu, Apr 20, 2023 at 1:34 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > Instead of caching page pointers, I believe binder could make use of
> > get_user_pages_remote() and trigger a page fault as needed. Basically,
> > implement something similar to access_remote_vm() but that instead does
> > a copy_from_user(). However, I don't see many in-tree users of these
> > routines, so I wonder if I'm overlooking something in this approach?
> 
> Sounds doable but there might be GUP details I'm missing...
> 
> >
> > One more reason for the page caching in binder is being able to free
> > pages from the shrinker's callback. Unused pages are added to an LRU
> > list and we manually zap/free them when they are reclaimed. It is not
> > evident to me how can binder mark a range within the vma region as
> > reclaimable?
> 
> I think you would have to release the individual pages using
> put_page(). Also note that get_user_pages_remote() is being
> deprecated, see:
> https://elixir.bootlin.com/linux/latest/source/mm/gup.c#L2171

Yeah, I remember reading that comment but it doesn't make sense since
the suggested alternatives do not support operations on _remote_ mm.

I actually tracked this down and it seems the original comment was made
for get_user_pages() instead, in commit f0818f472d8d ("mm: gup: add
get_user_pages_locked and get_user_pages_unlocked"). The whole comment
block was then carried over without update into get_user_pages_remote()
in commit 1e9877902dc7 ("mm/gup: Introduce get_user_pages_remote()").
The comment block was finally switched to use the "_remote" portion in
commit adc8cb406e52 ("mm/gup.c: update the documentation"). In reality,
this comment should be relocated to the get_user_pages() section.

> 
> >
> > Any pointers are appreciated!
> >
> > --
> > Carlos Llamas
