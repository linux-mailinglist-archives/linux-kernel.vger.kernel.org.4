Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD2A6420D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiLEApv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiLEApt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:45:49 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7BC11169
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 16:45:48 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t62so11330567oib.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 16:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtvsCQ8fHRhk6x8VToDSbomE5ZMa9LavMZLQcaqpC9Y=;
        b=bZ8SjeMi3/UczyDxZXS7zVDxJajNbrzIoW0OlW8hH6g6BQw0jcAMSTmLGSEHhHDiCS
         /4rq6dAIDr8K8g8vcV6Y6IuidDyFDrjbhbEh9b6l7zdCHlgjoSgwACQDLQL3/raCnx4i
         ttFJTLiEFLut+8z4PZlHT0N30YZx1QgZkLMg64vEe2ryC9m9byJbIQIOWvRuuGITzDfN
         RKdmZTkMVM48o5P/Zr1knzzNTD91AcgmrRXsTxzRsK+/MtnUn8UcwN3UvFRDTKU11VOw
         hZCzwjjr3k8ISOn9gGwoggI+Wo5yGvvGlPe+xSRUMpEOZEJAaa/S2SXzTH6DdcY79G1x
         035g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtvsCQ8fHRhk6x8VToDSbomE5ZMa9LavMZLQcaqpC9Y=;
        b=JLQZa5rOuJWib5x2s0xr8Tebpti0789DAh5FNMi+SXvJdJFAmRLlTgcQUVN4zHU6AD
         xITLkWggeKBqW1XQNSVHQ4aDuKpIT3BJVAIYJOrbJ4IYOFT+0buagHWq0jztdA+4FnSx
         a6MQn0sO0KByW1gJVll5WrSkp9reVQlVWJAS2+YwZhGp8zua2d66jAIuY18jxTGyjM1o
         44zxeth5gzo+DJlI4/STHRKF71jEW/WhY4zd68mSPjiQg2ATDWuFfrR5Q+g2AgHQeqmp
         6/IhDUYVBzq4e+ADyfKMBk3snGzR90gc9hFTonn734b6HsAnLS+YcjN4dYi50GsOHcpY
         9Adg==
X-Gm-Message-State: ANoB5pmkLWzvS788npgKXz805hIRYa8bcRx9qTjA4y4Rp8QevRyv/SxR
        lRm6pZ68btrK+KLqQDkTLlbUWg==
X-Google-Smtp-Source: AA0mqf7jfsaE4Kcw/T3BQzMPBJ+a/VF4WDpQhaEAUCRLq4MFCxgGrjEvAi3xJNByIZnjCSXdF9+EBg==
X-Received: by 2002:a05:6808:149:b0:35b:b8d6:32c5 with SMTP id h9-20020a056808014900b0035bb8d632c5mr15921488oie.226.1670201147592;
        Sun, 04 Dec 2022 16:45:47 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e9-20020a4ae0c9000000b004a05e943f9esm1141017oot.21.2022.12.04.16.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 16:45:47 -0800 (PST)
Date:   Sun, 4 Dec 2022 16:45:35 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Rui Wang <r@hev.cc>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Guoqi Chen <chenguoqic@163.com>,
        Huacai Chen <chenhuacai@loongson.cn>, Rui Wang <kernel@hev.cc>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/shmem: Fix undo range for failed fallocate
In-Reply-To: <9984f58e-826-74c6-1cd4-65366cc01549@google.com>
Message-ID: <5889e4e3-e054-7654-1436-8d2bcbefe3c6@google.com>
References: <20221101032248.819360-1-kernel@hev.cc> <Y2KBovUHODJJ8ZnV@casper.infradead.org> <CAHirt9h2CrLhYML3XW=Vj4=BD5eVDoRAbULVGgNbEdYnAzwCzA@mail.gmail.com> <9984f58e-826-74c6-1cd4-65366cc01549@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 22 Nov 2022, Hugh Dickins wrote:
> On Thu, 3 Nov 2022, hev wrote:
> > On Wed, Nov 2, 2022 at 10:41 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Tue, Nov 01, 2022 at 11:22:48AM +0800, Rui Wang wrote:
> > > > This patch fixes data loss caused by the fallocate system
> > > > call interrupted by a signal.
> > > >
> > > > Bug: https://lore.kernel.org/linux-mm/33b85d82.7764.1842e9ab207.Coremail.chenguoqic@163.com/
> > > > Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> > >
> > > How does that commit introduce this bug?
> > 
> > In the test case[1], we created a file that contains non-zero data
> > from offset 0 to A-1. and a process try to expand this file by
> > fallocate(fd, 0, 0, B), B > A.
> > Concurrently, another process try to interrupt this fallocate syscall
> > by a signal. I think the expected results are:
> > 
> > 1. The file is not expanded and file size is A, and the data from
> > offset 0 to A-1 is not changed.
> > 2. The file is expanded and the data from offset 0 to A-1 is not
> > changed, and from A to B-1 contains zeros.
> > 
> > Now, the unexpected result is that the file is not expanded and the
> > data that from offset 0 to A-1 is changed by
> > truncate_inode_partial_folio that called
> > from shmem_undo_range with unfalloc = true.
> > 
> > This issue is only reproduced when file on tmpfs, and begin from this
> > commit: b9a8a4195c7d ("truncate,shmem: Handle truncates that split
> > large folios")
> 
> Like Matthew, I was sceptical at first.
> 
> But I currently think that you have discovered something important, and
> that your patch is the correct fix to it; but I'm still rather confused,
> and want to do some more thinking and testing: this mail is mainly to
> signal to Matthew that I'm on it, so he doesn't have to rush to look
> at it when he's back.
> 
> I was able to reproduce it with the test case, once I multiplied both
> of the usleep intervals by 10 - before that, it was too difficult for
> it to complete a fallocate: guess the timing is different on my x86 box.

Thanks, I needed that breathing space to get back to thinking it through.

My main concern was, how did Matthew and I come to miss this unfalloc
issue when the folio commit went in?  Speaking for myself (but quite
likely for Matthew too), it's because there was never a need for
special unfalloc treatment in the partial page handling there before,
so we didn't even think of adding any when that got updated.

But when the partial page handling got turned into partial folio
handling, it came to do a lot more than before: it's tricky stuff,
and Matthew intentionally moved all the difficulty there into the
partial folio block; whereas before it had been just as tricky,
but hidden away in the shmem_punch_compound() call from inside the
loop which follows.  And was subject there to the unfalloc exception.

So that sort of satisfied me, how we came to overlook it.

Your patch worked for me, and until yesterday I was intending to
send it in as is.  But then realized that, although it's a peculiar
exception to the standard processing there, unfalloc actually has a
much simpler job to do: just remove any !uptodate folios from the range.
It has no need whatsoever for the zeroing and splitting involved in
truncate_inode_partial_folio(), and I really wanted to avoid having
to think through all that again - easier just to skip it all.

So the patch I'm about to send to Andrew is not quite yours:
but many thanks to you and to Guoqi Chen for revealing this issue.

Hugh
